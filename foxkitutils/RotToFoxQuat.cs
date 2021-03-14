using FoxKit.Utils;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//tex: converts the transform the component is attached to to a string of fox quat
//toggle the component using its checkmark to update the quat string

//routeParam1 is first part (4bytes) of route param1 (rotation and waittime)

namespace FoxKit.IH
{
    [ExecuteInEditMode]
    public class RotToFoxQuat : MonoBehaviour
    {
        public string quatString;
        public string routeParam1Rotation;
        void OnEnable()
        {
            quatString = GetQuatString();
            routeParam1Rotation = GetShortRotation();
        }

        private string GetQuatString()
        {
            FoxLib.Core.Quaternion foxQuat = FoxUtils.UnityToFox(transform.rotation);
            return $"x=\"{foxQuat.X}\" y=\"{foxQuat.Y}\" z=\"{foxQuat.Z}\" w=\"{foxQuat.W}\"";
        }//CalcQuatString

        private string GetShortRotation()
        {
            //tex: from caplag
            //https://discord.com/channels/364177293133873153/364177978315374592/819967138550251530
            float yaw = transform.rotation.eulerAngles.y;
            yaw -= 360;
            yaw = Mathf.Abs(yaw);
            yaw *= 182;
            int yawInt = (int)yaw;
            return yawInt.ToString("X");
        }//GetShortRotation
    }//class RotToFoxQuat
}//namespace FoxKit.IH
