/*
IPCControl.cs
Component to communicate with MGSV via IHHooks command/message system.
Add component to a gameobject.
Start MGSV
Click StartIPC on the component inspector.
 */
namespace FoxKit.IH.Utils
{
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEditor;
    using IHExt;

    /// <summary>
    /// 
    /// </summary>
    [ExecuteInEditMode]
    public class IPCControl : MonoBehaviour
    {
        public bool StartIPC = false;//DEBUGNOW


        private bool ipcRunning = false;
        public bool IPCRunning
        {
            get { return ipcRunning; }
        }

        private long extSession;

        IPC ipc;

        void OnEnable()
        {
            Debug.Log("IPCControl.OnEnable");//DEBUGNOW

            if (ipc == null)
            {
                System.DateTime currentDate = System.DateTime.Now;
                extSession = currentDate.Ticks;
                ipc = new IPC();
                ipc.ExtSession = extSession;
                ipc.UseMgsvToExtCmdQueue = true;
                ipc.ServerInName = "mgsv_in";
                ipc.ServerOutName = "mgsv_out";
            }

            EditorApplication.update += OnEditorUpdate;
        }//OnEnable

        void OnDisable()
        {
            Debug.Log("IPCControl.OnDisable");//DEBUGNOW

            EditorApplication.update -= OnEditorUpdate;
            if (ipc != null)
            {
                ipc.ShutdownPipeThreads();
                ipc = null;
            }
        }//OnDisable

        void OnEditorUpdate()
        {
            if (StartIPC)
            {
                if (!ipcRunning)
                {
                    ipc.StartPipeThreads();
                    ipc.ToMgsvCmd($"extSession|{extSession}");
                    ipcRunning = true;
                }
            } else
            {
                if (ipcRunning)
                {
                    ipc.ShutdownPipeThreads();
                    ipcRunning = false;
                }
            }

            if (ipcRunning)
            {
                ipc.ProcessCommandQueue();
            }
        }//OnEditorUpdate

        public void AddCommand(string name, System.Action<string[]> command)
        {
            if (ipc == null)
            {
                Debug.Log("WARNING: IPCControl.AddCommand: ipc==null");
            } else
            {
                ipc.AddCommand(name, command);
            }
        }//AddCommand

        public void ToMgsvCmd(string message)
        {
            if (!ipcRunning)
            {
                Debug.Log("WARNING: IPCControl.ToMgsvCmd: !IPCRunning");
                return;
            }

            if (ipc == null)
            {
                Debug.Log("WARNING: IPCControl.ToMgsvCmd: ipc==null");
                return;
            }

            ipc.ToMgsvCmd(message);
        }//ToMgsvCmd
    }//class PlayerSync
}//namespace
