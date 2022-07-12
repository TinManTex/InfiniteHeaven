/*
PlayerSync.cs
Component that uses IPCControl to sync the position and rotation of player from the game.

Add this component to a gameobject.
If the script cannot find existing one it will create a gameobject 'Player', you can also manually choose the proxy gameobject in the component inspector.
Once IPC is running (click 'Toggle IPC' in Window->FoxKit->MGSV IPC after game is running) 
Click Single Update or Continious Object on this component to update the gameobjects to the games position.
 */
using UnityEngine;
namespace FoxKit.IH {
    [ExecuteInEditMode]
    public class PlayerSync : IPCFeature {
        string gameObjectName = "Player";
        public GameObject proxyGameObject;

        public SyncDirection syncDirection = SyncDirection.GAME_TO_EDITOR;
        public float offSetY = -0.8f;//tex whatever playerPosY actually is, its about 0.8 above ground pos, though user may want to adjust it to a bit less (ih showpos has had it at -0.783) to clear actual ground a bit/have less of an issue with clipping

        override public void RegisterFromGameCommands() {
            IPC.Instance.AddCommand("GamePlayerPos", GamePlayerPos);
        }//RegisterFromGameCommands

        override public void OnIPCUpdate() {
            if (syncDirection == SyncDirection.EDITOR_TO_GAME) {
                float x = proxyGameObject.transform.position.x;
                float y = proxyGameObject.transform.position.y;
                float z = proxyGameObject.transform.position.z;
                float yaw = proxyGameObject.transform.rotation.eulerAngles.y;
				//unity to fox
				x=-x;
				yaw=-yaw;
				
                IPC.Instance.ToGameCmd($"SetPlayerPos|{x}|{y}|{z}|{yaw}");
            } else {
                //GAME_TO_EDITOR
                IPC.Instance.ToGameCmd("GetPlayerPos");
            }
        }//OnIPCUpdate

        //Set up any game objects we manage
        override public void SetupGameObjects() {
            Debug.Log("PlayerSync.SetupGameObjects");
            if (proxyGameObject == null) {//tex user can set proxyGameObject to what they want so dont trample that
                proxyGameObject = GameObject.Find(gameObjectName);
                if (proxyGameObject == null) {
                    proxyGameObject = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    proxyGameObject.name = "Player";
                }//if !gameObject
            }//if !gameObject
        }//SetupGameObjects

        //tex commands from game
        //tex all commands take in single param and array of args
        //args[0] = messageId(not really useful for a command)
        //args[1] = command name(ditto)
        //args[2 +] = arg as string

		//n|GamePlayerPos|{x}|{y}|{z}|{yaw}
        private void GamePlayerPos(string[] args) {
            float x = float.Parse(args[2], System.Globalization.CultureInfo.InvariantCulture);
            float y = float.Parse(args[3], System.Globalization.CultureInfo.InvariantCulture);
            float z = float.Parse(args[4], System.Globalization.CultureInfo.InvariantCulture);
            float yaw = float.Parse(args[5], System.Globalization.CultureInfo.InvariantCulture);
            //fox to unity
            x=-x;
            yaw=-yaw;

            y = y + offSetY;

            if (proxyGameObject != null) {
                proxyGameObject.transform.position = new Vector3(x, y, z);
                Quaternion yawQuat = Quaternion.Euler(0.0f, yaw, 0.0f);
                proxyGameObject.transform.rotation = yawQuat;
            }
            //Debug.Log($"GamePlayerPos: {x},{y},{z},{yaw}");//DEBUG
        }//GamePlayerPos
    }//class PlayerSync
}//namespace