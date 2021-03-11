using FoxKit.Utils;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//tex: converts the transform the component is attached to to a string of fox quat
//toggle the component using its checkmark to update the quat string

namespace FoxKit.IH
{
    [ExecuteInEditMode]
    public class RotToFoxQuat : MonoBehaviour
    {
        public string quatString;
        void OnEnable()
        {
            quatString = GetQuatString();
        }

        private string GetQuatString()
        {
            FoxLib.Core.Quaternion foxQuat = FoxUtils.UnityToFox(transform.rotation);
            return $"x=\"{foxQuat.X}\" y=\"{foxQuat.Y}\" z=\"{foxQuat.Z}\" w=\"{foxQuat.W}\"";
        }//CalcQuatString
    }//class RotToFoxQuat
}//namespace FoxKit.IH
