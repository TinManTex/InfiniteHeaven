using System.Collections;
using System.Collections.Generic;
using UnityEngine;

//tex: copies the transform of the proxy object to the object this script is attached to
//useful to put on a preab and point to one of the IH IPC proxy objects, moving that to position, then creating new prefab and hitting copy

public class GetProxyTransform : MonoBehaviour
{
    public GameObject proxyObject = null;
    public bool getProxyTransform = false;

    // Called when value is changed in inspector
    private void OnValidate()
    {
        if (getProxyTransform)
        {
            getProxyTransform = false;

            if (proxyObject)
            {
                transform.position = proxyObject.transform.position;
                transform.rotation = proxyObject.transform.rotation;
            }
        }
    }//OnValidate
}//GetProxyPosition
