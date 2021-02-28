/*
CameraSync.cs
Component that uses IPCControl to sync the position and rotation of camera from the game.

Add this component to a gameobject.
If the script cannot find existing one it will create a gameobject 'Main Camera'.
Once IPC is running (click 'Toggle IPC' in Window->FoxKit->MGSV IPC after game is running) 
Click Single Update or Continious Object on this component to update the gameobjects to the games position.
 */
using System.Collections.Generic;
using UnityEngine;
namespace FoxKit.IH {
    [ExecuteInEditMode]
    public class CameraSync : IPCFeature {
        string gameObjectName = "Main Camera";
        GameObject proxyGameObject;

        public SyncDirection syncDirection = SyncDirection.GAME_TO_EDITOR;

        override public void RegisterFromGameCommands() {
            IPC.Instance.AddCommand("GameCameraPos", GameCameraPos);
        }//RegisterFromGameCommands

        override public void OnIPCUpdate() {
            if (syncDirection == SyncDirection.EDITOR_TO_GAME) {
                float x = -proxyGameObject.transform.position.x;
                float y = proxyGameObject.transform.position.y;
                float z = proxyGameObject.transform.position.z;
                float pitch = proxyGameObject.transform.rotation.eulerAngles.x;
                float yaw = proxyGameObject.transform.rotation.eulerAngles.y;
                IPC.Instance.ToGameCmd($"SetCameraPos|{x}|{y}|{z}|{pitch}|{yaw}");
            } else {
                IPC.Instance.ToGameCmd("GetCameraPos");
            }
        }//OnIPCUpdate

        //Set up any game objects we manage
        override public void SetupGameObjects() {
            proxyGameObject = GameObject.Find(gameObjectName);
            if (proxyGameObject == null) {
                proxyGameObject = new GameObject(gameObjectName);
            }//if !gameObject
        }//SetupGameObjects

        //tex commands from game
        //tex all commands take in single param and array of args
        //args[0] = messageId(not really useful for a command)
        //args[1] = command name(ditto)
        //args[2 +] = arg as string

        private void GameCameraPos(string[] args) {
            float x = -float.Parse(args[2]);//tex fox to unity conversion
            float y = float.Parse(args[3]);
            float z = float.Parse(args[4]);

            float pitch = float.Parse(args[5]);
            float yaw = float.Parse(args[6]);

            proxyGameObject.transform.position = new Vector3(x, y, z);
            Quaternion yawQuat = Quaternion.Euler(pitch, yaw, 0.0f);//tex TODO likely not correct
            proxyGameObject.transform.rotation = yawQuat;

            //Debug.Log($"GameCameraPos: {x},{y},{z},{pitch},{yaw}");//DEBUG
        }//GameCameraPos
    }//class CameraSync
}//namespace