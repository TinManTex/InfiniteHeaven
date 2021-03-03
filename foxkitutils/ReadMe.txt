Inter Process Communication between Unity and MGSV via IHHook.

Requires an IH build that includes IHHook.

Copy the IH folder to your Unity Assets folder (into FoxKit folder if you want).

Add CameraSync, PlayerSync, UserMarkerSync components (any that derive from IPCFeature) onto any game object (I usually just create an empty one and put them all on it).
The components will create some proxy gameobjects.

Start MGSV (that has an IH/IHook build).
In Unity choose Window->FoxKit->MGSV IPC
In the new window click Toggle IPC.
On the component click Single or Continuous Update for the respective proxy object to update.


CameraSyncs EDITOR_TO_GAME will only update IH FreeCam position (since there's currently no viable runtime cam pos/rotation update function).