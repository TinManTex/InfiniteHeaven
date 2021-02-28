/*
IPCFeature.cs
Base MonoBehaviour of component that uses IPC in conjunction with IHHook to send and recieve commands from
mgsv
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

        void OnEnable() {
            //Debug.Log("PlayerSync.OnEnable");//DEBUG
            EditorApplication.update += OnEditorUpdate;

            RegisterFromGameCommands();

            singleUpdate = false;
            continuousUpdate = false;

            SetupGameObjects();
        }//OnEnable

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

        public abstract void RegisterFromGameCommands();
        public abstract void OnIPCUpdate();
        public abstract void SetupGameObjects();
    }//class IPCFeature
}//namespace FoxKit.IH
