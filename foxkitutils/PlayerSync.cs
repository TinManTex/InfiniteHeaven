/*
PlayerSync.cs
Component that uses IPCControl to sync the position and rotation of gamebject to players
Must have an IPCControl component on the same game.
Add this component to a gameobject with some visual representation of the player (like a cube).
Once IPC is running (See comment at top of IPCControl on how to set it up) click SyncPlayer to start syncing the movement of gameobject this component is attached to.
 */
namespace FoxKit.IH.Utils
{
    using System.Collections;
    using System.Collections.Generic;
    using UnityEngine;
    using UnityEditor;

    [ExecuteInEditMode]
    public class PlayerSync : MonoBehaviour
    {
        public bool SyncPlayer = false;
        public bool SyncCamera = false;

        bool isSetup = false;
        bool doRepaint = false;

        void OnEnable()
        {
            //Debug.Log("PlayerSync.OnEnable");//DEBUG
            EditorApplication.update += OnEditorUpdate;
        }//OnEnable

        void OnDisable()
        {
            EditorApplication.update -= OnEditorUpdate;
        }//OnDisable

        void OnEditorUpdate()
        {
            //tex TODO: put ipcControl on its own gameobject? //DEBUGNOW
            IPCControl ipcControl = gameObject.GetComponent(typeof(IPCControl)) as IPCControl;
            if (ipcControl == null)
            {
                Debug.Log("WARNING: ipcControl==null");
            }

            //tex KLUDGE need a point of execution thats guaranteed after ipc instance exists, or set it up as a singleton I guess.
            if (!isSetup && ipcControl != null)
            {
                Debug.Log("PlayerSync Setup");//DEBUG
                isSetup = true;
                ipcControl.AddCommand("GamePlayerPos", GamePlayerPos);
                ipcControl.AddCommand("GameCameraPos", GameCameraPos);
            }


            if (SyncPlayer)
            {
                SyncCamera = false;
                ipcControl.ToMgsvCmd("GetPlayerPos");
                doRepaint = true;
            }

            if (SyncCamera)
            {
                SyncPlayer = false;
                ipcControl.ToMgsvCmd("GetCameraPos");
                doRepaint = true;
            }

            if (doRepaint)
            {
                EditorWindow view = EditorWindow.GetWindow<SceneView>();
                view.Repaint();
            }
        }//OnEditorUpdate


        //tex commands from game
        //tex all commands take in single param and array of args
        //args[0] = messageId(not really useful for a command)
        //args[1] = command name(ditto)
        //args[2 +] = args as string

        private void GamePlayerPos(string[] args)
        {
            float x = -float.Parse(args[2]);//tex fox to unity conversion
            float y = float.Parse(args[3]);
            float z = float.Parse(args[4]);
            float yaw = float.Parse(args[5]);

            //Debug.Log($"GamePlayerPos: {x},{y},{z},{yaw}");//DEBUG

            transform.position = new Vector3(x, y, z);
            Quaternion yawQuat = Quaternion.Euler(0.0f, yaw, 0.0f);
            transform.rotation = yawQuat;
        }//GamePlayerPos


        private void GameCameraPos(string[] args)
        {
            float x = -float.Parse(args[2]);//tex fox to unity conversion
            float y = float.Parse(args[3]);
            float z = float.Parse(args[4]);

            float pitch = float.Parse(args[5]);
            float yaw = float.Parse(args[6]);

            transform.position = new Vector3(x, y, z);
            Quaternion yawQuat = Quaternion.Euler(pitch, yaw, 0.0f);//tex TODO likely not correct
            transform.rotation = yawQuat;

            Debug.Log($"GameCameraPos: {x},{y},{z},{pitch},{yaw}");//DEBUGNOW
        }//GameCameraPos
    }//class PlayerSync
}//namespace