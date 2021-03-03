using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.ComponentModel;
using System.IO;
using System.IO.Pipes;
using System.Linq;
using System.Text;
using UnityEngine;

namespace FoxKit.IH {
    public sealed class IPC {
        string serverInName = "mgsv_in";
        string serverOutName = "mgsv_out";
        public string ServerInName {
            set {
                serverInName = value;
            }
        }
        public string ServerOutName {
            set {
                serverOutName = value;
            }
        }

        private ConcurrentQueue<string> extToMgsvCmdQueue = new ConcurrentQueue<string>();
        private ConcurrentQueue<string> mgsvToExtCmdQueue = new ConcurrentQueue<string>();

        private Dictionary<string, Action<string[]>> commands = new Dictionary<string, Action<string[]>>();

        //LEGACY: IHExt text IPC
        private int extToMgsvCurrent = 0;//tex current/max, last command to be written out
        private int extToMgsvComplete = 0;//tex min/confirmed executed by mgsv, only commands above this should be written out
        private int mgsvToExtComplete = 0;//tex min/confimed executed by ext


        private long extSession = 0;
        private long mgsvSession = 0;

        BackgroundWorker serverInWorker = null;
        BackgroundWorker serverOutWorker = null;

        volatile bool isPipeConnected = false;
        public bool IsPipeConnected() {
            return serverInWorker != null && serverOutWorker != null && isPipeConnected;
        }

        //tex control whether command is executed on pipe read or added to a queue so some other thread can call ProcessCommandQueue to process
        bool useMgsvToExtCmdQueue = true;
        public bool UseMgsvToExtCmdQueue {
            set {
                useMgsvToExtCmdQueue = value;
            }
        }//UseMgsvToExtCmdQueue

        public long ExtSession {
            set {
                extSession = value;
            }
        }//ExtSession

        //tex singleton
        private static readonly IPC instance = new IPC();
        public static IPC Instance {
            get {
                return instance;
            }
        }//Instance

        // Explicit static constructor to tell C# compiler
        // not to mark type as beforefieldinit
        static IPC() {
        }

        private IPC() {
        }

        ~IPC() {
            ShutdownPipeThreads();
        }//IPC dtor

        public void StartPipeThreads() {
            serverInWorker = new BackgroundWorker();
            serverInWorker.DoWork += new DoWorkEventHandler(serverIn_DoWork);
            serverInWorker.WorkerSupportsCancellation = true;
            serverInWorker.RunWorkerAsync();

            serverOutWorker = new BackgroundWorker();
            serverOutWorker.DoWork += new DoWorkEventHandler(serverOut_DoWork);
            serverOutWorker.WorkerSupportsCancellation = true;
            serverOutWorker.RunWorkerAsync();
        }//StartPipeThreads

        public void ShutdownPipeThreads() {
            if (serverInWorker != null) {
                serverInWorker.CancelAsync();
                serverInWorker = null;
            }

            if (serverOutWorker != null) {
                serverOutWorker.CancelAsync();
                serverOutWorker = null;
            }

            isPipeConnected = false;
        }//ShutdownPipeThreads

        public bool CheckPipeThreadEnded() {
            return !serverOutWorker.IsBusy;//tex only care about serverOutWorker because that's the only one that closes down nicely lol
        }//CheckPipeThreadEnded

        //tex mgsv_in pipe (IHExt out) process thread
        //IN/SIDE: serverInName
        void serverIn_DoWork(object sender, DoWorkEventArgs eventArgs) {
            Debug.Log("serverIn_DoWork start");
            BackgroundWorker worker = (BackgroundWorker)sender;

            using (var serverIn = new NamedPipeClientStream(".", serverInName, PipeDirection.Out)) {//tex: piped named from mgsv standpoint, so we pipe out to mgsv in, and visa versa
                // Connect to the pipe or wait until the pipe is available.
                Debug.Log("Attempting to connect to serverIn...");
                serverIn.Connect();

                isPipeConnected = true;

                Debug.Log($"Connected to {serverInName}.");
                //DEBUG Debug.Log($"There are currently {serverIn.NumberOfServerInstances} pipeIn server instances open.");

                serverIn.ReadMode = PipeTransmissionMode.Message;

                StreamWriter sw = new StreamWriter(serverIn, Encoding.UTF8);
                while (true) {
                    //Debug.Log("serverIn_DoWork");//DEBUG
                    if (worker.CancellationPending) {
                        Debug.Log("serverIn: worker.CancellationPending");
                        break;
                    }
                    //tex doesnt seem to work
                    //other alternative is to fail on write 
                    //catch pipe broken exception, which I should be doing anywya
                    //but that's assuming I am writing
                    //or (actually doing this -^-) to have serverOut RunWorkerCompleted cancel this (since it does hit !IsConnected) 
                    if (!serverIn.IsConnected) {
                        Debug.Log("!serverIn.IsConnected");
                        break;
                    }
                    //sw.Write("Sent from client.");//DEBUG
                    if (extToMgsvCmdQueue.Count() > 0) {
                        string command;
                        while (extToMgsvCmdQueue.TryDequeue(out command)) {
                            if (worker.CancellationPending) {
                                break;
                            }
                            //DEBUGNOW this eats the command -^-
                            try {
                                //Debug.Log("Client write: " + command);//DEBUGNOW
                                sw.Write(command);
                                sw.Flush();
                            } catch (IOException exception) {
                                Debug.Log(exception.Message);
                                break;
                                //DEBUGNOW need to break out one loop further, or just let extToMgsvCmdQueue run down?
                            }
                        }//while extToMgsvCmdQueue
                    }//if extToMgsvCmdQueue
                }//while true
            }//using pipeIn
            Debug.Log("serverIn_DoWork exit");
        }//serverIn_DoWork

        //tex mgsv_out pipe (IHExt in) process thread
        //IN/SIDE: serverOutName
        //IN-OUT/SIDE: mgsvToExtComplete
        void serverOut_DoWork(object sender, DoWorkEventArgs eventArgs) {
            Debug.Log("serverOut_DoWork start");
            BackgroundWorker worker = (BackgroundWorker)sender;

            //tex there's an issue with client/in pipes not working in message mode
            //https://stackoverflow.com/questions/32739224/c-sharp-unauthorizedaccessexception-when-enabling-messagemode-for-read-only-name
            //The solution below lets you keep the server as out only (OUTBOUND in c++), but this constructor for NamedPipeClientStream isn't available in .net standard (thus not unity)
            //using (var serverOut = new NamedPipeClientStream(
            //        ".",
            //        serverOutName,
            //        PipeAccessRights.ReadData | PipeAccessRights.WriteAttributes,
            //        PipeOptions.None,
            //        System.Security.Principal.TokenImpersonationLevel.None,
            //        System.IO.HandleInheritability.None)) {
                //tex so using this instead of above, where pipedirection is InOut instead of In, the gotcha is server must be InOut/DUPLEX as well
                //GOTCHA: which also theoretically means a client could stall the pipe if it writes to it as IHHook only treats is as out only.
             using (var serverOut = new NamedPipeClientStream(".", serverOutName, PipeDirection.InOut)) {
                // Connect to the pipe or wait until the pipe is available.
                Debug.Log("Attempting to connect to serverOut...");
                serverOut.Connect();

                Debug.Log($"Connected to {serverOutName}.");
                //DEBUGNOW Debug.Log($"There are currently {serverOut.NumberOfServerInstances} pipe server instances open.");

                serverOut.ReadMode = PipeTransmissionMode.Message;

                while (true) {
                    //Debug.Log("serverOut_DoWork");//DEBUG
                    if (worker.CancellationPending) {
                        Debug.Log("serverOut: worker.CancellationPending");
                        break;
                    }
                    //tex works on standalone/console project but not via Unity, no idea whats up there
                    if (!serverOut.IsConnected) {
                        Debug.Log("!serverOut.IsConnected");
                        break;
                    }

                    //DEBUGNOW WORKAROUND: due to above not working GOTCHA: only works because serverOut is DUPLEX (due to another workaround lol)
                    StreamWriter sw = new StreamWriter(serverOut, Encoding.UTF8);
                    try {
                        sw.Write("");
                        sw.Flush();
                    } catch (IOException exception) {
                        Debug.Log(exception.Message);
                        break;
                    }

                    //DEBUGNOW using (
                    StreamReader sr = new StreamReader(serverOut, Encoding.UTF8);//DEBUGNOW ) {//tex DEBUGNOW: will hang if ouside the loop
                        string message;
                        int count = 0;
                        //tex message mode doesn't seem to be working for mgsv_out
                        //despite checking everything on both sides and despite it working for mgsv_in
                        //was: while ((message = sr.ReadLine()) != null) {
                        var peek = sr.Peek();//GOTCHA: will block exec here till theres something in the pipe
                        while (sr.Peek() > 0) {
                            if (worker.CancellationPending) {
                                break;
                            }

                            if (!serverOut.IsConnected) {
                                Debug.Log("!serverOut.IsConnected");
                                break;
                            }

                            //OFF see above
                            //message = sr.ReadLine();
                            //message = sr.ReadToEnd();
                            message = ReadByChar(sr);

                            //Debug.Log($"Received from server: {message}");//DEBUGNOW
                            if (String.IsNullOrEmpty(message)) {
                                continue;
                            }

                            if (useMgsvToExtCmdQueue) {
                                mgsvToExtCmdQueue.Enqueue(message);
                            } else {
                                ProcessCommand(message, count);
                            }
                            count++;
                        }//while Read
                    //DEBUGNOW}//using streamreader
                }//while true
            }//using pipeOut
            Debug.Log("serverOut_DoWork exit");
        }//serverOut_DoWork

        private static string ReadByChar(StreamReader sr) {
            StringBuilder stringBuilder = new StringBuilder();
            char c;
            do {
                c = (char)sr.Read();
                if (c == -1) {//tex end of stream
                    break;
                } else if (c == '\0') {
                    break;
                } else {
                    stringBuilder.Append(c);
                }
            } while (!sr.EndOfStream) ;
            return stringBuilder.ToString();
        }//ReadByChar

        //OUT/SIDE: mgsvToExtComplete
        private void ProcessCommand(string message, int count) {
            char[] delimiters = { '|' };
            string[] args = message.Split(delimiters);
            int messageId;

            if (Int32.TryParse(args[0], out messageId)) {
                if (args.Length < 1) {
                    Debug.Log("WARNING: args.Length < 1");
                } else {
                    string commandName = args[1];//tex args 0 is messageId
                    if (!commands.ContainsKey(commandName)) {
                        Debug.Log("WARNING: Unrecogined command:" + commandName);
                    } else {
                        commands[commandName](args);
                    }
                }//if args

                mgsvToExtComplete = messageId;
            }// parse messageId
        }//ProcessCommand

        //tex call from some other thread to process mgsvToExtCmdQueue messages 
        public void ProcessToExtCommandQueue() {
            if (!IsPipeConnected()) {
                return;
            }

            if (!mgsvToExtCmdQueue.IsEmpty) {
                string message;
                while (mgsvToExtCmdQueue.TryDequeue(out message)) {
                    ProcessCommand(message, 0);
                }
            }
        }//ProcessCommandQueue

        public void ToGameCmd(string cmd, params object[] args) {
            if (!IsPipeConnected()) {
                Debug.Log($"WARNING: ToGameCmd when !isPipeConnected: {cmd}");
                return;
            }

            StringBuilder message = new StringBuilder($"{extToMgsvCurrent}|{cmd}");
            foreach (string arg in args) {
                message.Append($"|{arg}");
            }
            extToMgsvCmdQueue.Enqueue(message.ToString());
            extToMgsvCurrent++;

            //Debug.Log(message);
        }//ToGameCmd

        public void AddCommand(string name, Action<string[]> command) {
            if (commands.ContainsKey(name)) {
                //Debug.Log($"WARNING: commands dictionary already has entry for '{name}'");
            } else {
                commands.Add(name, command);
            }
        }//AddCommand
    }//PipeClient
}//namespace IHExt
