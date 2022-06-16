using UnityEngine;
using FoxKit.Utils;
using System.Collections;
using System.Collections.Generic;

//tex: converts the transform the component is attached to to string of fox quat and fox translation

//toggle the component using its checkmark to update the quat string and translation
//can change quatFormat and translationFormat to change the text output of quatString, translationString


//routeParam1 is first part (4bytes) of route param1 (rotation and waittime)

namespace FoxKit.IH
{
    [ExecuteInEditMode]
    public class UnityToFoxTransformStrings : MonoBehaviour
    {
        public string translationFormat = "x=\"{0}\" y=\"{1}\" z=\"{2}\" w=\"0\"";
        public string translationString;

        public string quatFormat = "x=\"{0}\" y=\"{1}\" z=\"{2}\" w=\"{3}\"";
        public string quatString;

        public string routeParam1Rotation;
        void OnEnable()
        {
            translationString = GetTranslationString();
            quatString = GetQuatString();
            routeParam1Rotation = GetShortRotation();
        }

        private string GetTranslationString()
        {
            FoxLib.Core.Vector3 foxTranslation = FoxUtils.UnityToFox(transform.position);
            return string.Format(translationFormat, foxTranslation.X, foxTranslation.Y, foxTranslation.Z);
        }//GetTranslationString

        private string GetQuatString()
        {
            FoxLib.Core.Quaternion foxQuat = FoxUtils.UnityToFox(transform.rotation);
            return string.Format(quatFormat, foxQuat.X, foxQuat.Y, foxQuat.Z, foxQuat.W);
        }//GetQuatString

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

        // Called when value is changed in inspector
        private void OnValidate()
        {

        }//OnValidate

        void Update()
        {
            if (transform.hasChanged)
            {
                OnEnable();
            }
        }//Update
    }//class RotToFoxQuat
}//namespace FoxKit.IH
