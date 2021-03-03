/*
UserMarkerSync.cs
Component that uses IPCControl to sync the position of Usermarkers from the game.
Does not sync from editor to game as IHHook/lua currently has no method to set usermarker.

Add this component to a gameobject.
If the script cannot find existing ones it will create a gameobject UserMarkers with UserMarker{n} 0-5 as children to represent the markers.
Once IPC is running (click 'Toggle IPC' in Window->FoxKit->MGSV IPC after game is running) 
Click Single Update or Continious Object on this component to update the gameobjects to the games position.
 */
using System.Collections.Generic;
using UnityEngine;
namespace FoxKit.IH {
    [ExecuteInEditMode]
    public class UserMarkerSync : IPCFeature {
        const int MAX_MARKERS = 5;
        List<GameObject> userMarkers = new List<GameObject>();

        override public void RegisterFromGameCommands() { 
            IPC.Instance.AddCommand("UserMarkerPos", UserMarkerPos);
        }//RegisterFromGameCommands

        override public void OnIPCUpdate() {
            //get user markers
            for (int i = 0; i < MAX_MARKERS; i++) {
                if (userMarkers[i] != null) {
                    //userMarkers[i].SetActive(false);
                }
                IPC.Instance.ToGameCmd($"GetUserMarkerPos|{i}");
            }//for i < MAX_MARKERS 
        }//OnIPCUpdate

        //Set up any game objects we manage
        override public void SetupGameObjects() {
            userMarkers.Clear();
            string groupName = "UserMarkers";
            GameObject userMarkerGroup = GameObject.Find(groupName);
            if (userMarkerGroup == null) {
                userMarkerGroup = new GameObject(groupName);
            }//if !userMarkerGroup
            for (int i = 0; i < MAX_MARKERS; i++) {
                string markerName = $"UserMarker{i}";
                GameObject userMarker = GameObject.Find(markerName);
                if (userMarker == null) {
                    userMarker = GameObject.CreatePrimitive(PrimitiveType.Cube);
                    userMarker.name = markerName;
                    userMarker.transform.parent = userMarkerGroup.transform;
                }
                userMarkers.Add(userMarker);
            }//for i < MAX_MARKERS
        }//SetupGameObjects

        //tex commands from game
        //tex all commands take in single param and array of args
        //args[0] = messageId(not really useful for a command)
        //args[1] = command name(ditto)
        //args[2 +] = arg as string

        private void UserMarkerPos(string[] args)
        {
            int index = int.Parse(args[2]);
            float x = -float.Parse(args[3]);//tex fox to unity conversion
            float y = float.Parse(args[4]);
            float z = float.Parse(args[5]);

            //Debug.Log($"UserMarkerPos[{index}]: {x},{y},{z}");//DEBUG
            if (userMarkers[index] != null) {
                GameObject markerObject = userMarkers[index];
                markerObject.transform.localPosition = new Vector3(x, y, z);
                markerObject.SetActive(true);
                doRepaint = true;
            }
        }//UserMarkerPos
    }//class UserMarkerSync
}//namespace