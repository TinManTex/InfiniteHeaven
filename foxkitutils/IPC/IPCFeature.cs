/*
IPCFeature.cs
Base MonoBehaviour of component that uses IPC in conjunction with IHHook to send and recieve commands from
mgsv
Don't need to do anything with this manually, use another component that inherits from it (Camera/Player/UserMarkerSync).
 */

using UnityEditor;
using UnityEngine;
namespace FoxKit.IH {
    public enum SyncDirection {
        GAME_TO_EDITOR,
        EDITOR_TO_GAME,
    }

    //tex just using MonoBehaviour scripts for now since there doesn't seem obviouse way to slap a bunch of embedded windows/controls in another editor window (BeginWindow does full window title and border and I done want non of that).
    [ExecuteInEditMode]
    abstract public class IPCFeature : MonoBehaviour {
        private bool wantsRepaint = true;
        public bool continuousUpdate = false;
        public bool singleUpdate = false;
        protected bool doRepaint = false;
        private bool hasRegisteredToGameCmds = false;
        
        void OnEnable() {
            Start();
        }//OnEnable
        
        void Start() {
            //Debug.Log("IPCFeature.Start");//DEBUG
            EditorApplication.update += OnEditorUpdate;

            hasRegisteredToGameCmds = false;

            RegisterFromGameCommands();

            singleUpdate = false;
            continuousUpdate = false;

            SetupGameObjects();
        }//Start

        void OnDisable() {
            EditorApplication.update -= OnEditorUpdate;
        }//OnDisable

        void OnEditorUpdate() {
            //OnUpdate();

            if (!IPC.Instance.IsPipeConnected()) {
                return;
            }

            if (continuousUpdate || singleUpdate) {
                singleUpdate = false;

                //GOTCHA this would break on IH reloadmodules, but resetting component (or entity component is on, would reinit it)
                if (!hasRegisteredToGameCmds) {
                    hasRegisteredToGameCmds = true;

                    RegisterToGameCommands();
                }

                OnIPCUpdate();
                if (wantsRepaint) {
                    doRepaint = true;
                }
            }

            if (doRepaint) {
                doRepaint = false;
                //EditorWindow view = EditorWindow.GetWindow<SceneView>();
                //view.Repaint();

                //SceneView.lastActiveSceneView.Repaint();

                UnityEditorInternal.InternalEditorUtility.RepaintAllViews();
            }//if doRepaint
        }//OnEditorUpdate

        public virtual void RegisterFromGameCommands() { }
        public virtual void RegisterToGameCommands() { }
        public abstract void OnIPCUpdate();
        public virtual void SetupGameObjects() { }
    }//class IPCFeature
}//namespace FoxKit.IH
