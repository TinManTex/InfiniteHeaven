foxkitutils
A collection of helpful(?) scripts for Unity to be used along side FoxKit.
Look in the scripts headers for more comments about the specific script.

Inter Process Communication between Unity and MGSV via IHHook.
https://www.youtube.com/watch?v=GXKs9cjadgo

Requires an IH build that includes IHHook.

Copy the IH folder to your Unity Assets folder (into FoxKit folder if you want).

IPC
IPCWindow
IPCFeature
PlayerSync
CameraSync
UserMarkerSync

Add CameraSync, PlayerSync, UserMarkerSync components (any that derive from IPCFeature) onto any game object (I usually just create an empty one and put them all on it).
The components will create some proxy gameobjects.

Start MGSV (that has an IH/IHook build).
In Unity choose Window->FoxKit->MGSV IPC
In the new window click Toggle IPC.
On the component click Single or Continuous Update for the respective proxy object to update.

You can also change the proxy game object to have it update the position and rotation of another object directly (like a route node for example).


CameraSyncs EDITOR_TO_GAME will only update IH FreeCam position (since there's currently no viable runtime cam pos/rotation update function).