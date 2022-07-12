/*
IPCWindow.cs
Window to communicate with MGSV via IHHooks command/message system.
Start Game (that has IHHook)
Open Window > FoxKit > MGSV IPC
Click StartIPC.

Use a IPCFeature derived component to do stuff
 */
using UnityEditor;
using UnityEngine;
namespace FoxKit.IH {
    public class IPCWindow : EditorWindow
    {
        [MenuItem("Window/FoxKit/MSGV IPC")]
        public static void Create()
        {
            var window = GetWindow<IPCWindow>();
            window.titleContent = new GUIContent("MSGV IPC");
            window.Show();
        }//Create

        private void OnEnable()
        {
            Debug.Log("IPCWindow.OnEnable");

            startIPC = false;
            ipcRunning = false;
            if (this.ipc != null)
            {
               // return;
            }

            System.DateTime currentDate = System.DateTime.Now;
            extSession = currentDate.Ticks;
            ipc = IPC.Instance;
            ipc.ExtSession = extSession;
            ipc.UseMgsvToExtCmdQueue = true;
            ipc.ServerInName = "mgsv_in";
            ipc.ServerOutName = "mgsv_out";

            EditorApplication.update += OnEditorUpdate;//tex: dont know if this is the same frequency as EditorWindow.Update, it seems more frequent (looking at scene repaint) but that might be placebo
        }//OnEnable
        
        private void OnDisable()
        {
            Debug.Log("IPCWindow.OnDisable");

            if (ipc != null) {
                ipc.ShutdownPipeThreads();
                ipc = null;
            }

            startIPC = false;
            ipcRunning = false;

            //playersync
            EditorApplication.update -= OnEditorUpdate;
        }//OnDisable

        //DEBUGNOW CULL
        public void Update() {

        }//Update

        void OnEditorUpdate() {
            if (ipcRunning && ipc.CheckPipeThreadEnded()) {
                startIPC = false;
            }

            if (startIPC) {
                if (!ipcRunning) {
                    Debug.Log("ipc.StartPipeThreads");
                    ipc.StartPipeThreads();
                    ipcRunning = true;
                }
            } else {
                if (ipcRunning) {
                    Debug.Log("ipc.ShutdownPipeThreads");
                    ipc.ShutdownPipeThreads();
                    ipcRunning = false;
                }
            }//Start/ShutdownPipeThreads

            if (ipc.IsPipeConnected()) {
                if (extSession == 0) {
                    System.DateTime currentDate = System.DateTime.Now;
                    extSession = currentDate.Ticks;
                    ipc.ExtSession = extSession;
                    ipc.ToGameCmd($"extSession|{extSession}");
                }
                ipc.ProcessToExtCommandQueue();
            } else {
                extSession = 0;
            }//if IsPipeConnected
        }//OnEditorUpdate

        //GUI
        void OnGUI()
        {
            EditorGUILayout.BeginHorizontal();
            if (GUILayout.Button($"Toggle IPC")) {
                this.startIPC = !this.startIPC;
            }
            EditorGUI.BeginDisabledGroup(true);
            this.ipcRunning = EditorGUILayout.Toggle("IPC Enabled:", this.ipcRunning);
            EditorGUI.EndDisabledGroup();
            EditorGUILayout.EndHorizontal();
        }//OnGUI


        //IPC
        public bool startIPC = false;

        private IPC ipc;
        private long extSession;

        private bool ipcRunning = false;
        public bool IPCRunning {
            get { return ipcRunning; }
        }
        public void AddCommand(string name, System.Action<string[]> command) {
            if (ipc == null) {
                Debug.Log("WARNING: IPCWindow.AddCommand: ipc==null");
            } else {
                ipc.AddCommand(name, command);
            }
        }//AddCommand

        public void ToMgsvCmd(string message) {
            if (!ipcRunning) {
                Debug.Log("WARNING: IPCWindow.ToMgsvCmd: !IPCRunning");
                return;
            }

            if (ipc == null) {
                Debug.Log("WARNING: IPCWindow.ToMgsvCmd: ipc==null");
                return;
            }

            ipc.ToGameCmd(message);
        }//ToMgsvCmd
    }//IPCWindow
}//namespace
