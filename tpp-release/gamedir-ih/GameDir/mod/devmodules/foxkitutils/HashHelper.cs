using System.Collections;
using System.Collections.Generic;
using System.Globalization;
using UnityEngine;

public class HashHelper : MonoBehaviour
{
    public string S64Hex = "";
    public string S32Uint = "";

    // Called when value is changed in inspector
    private void OnValidate()
    {
        try
        {
            uint s32Hash = (uint)ulong.Parse(S64Hex, NumberStyles.HexNumber);
            S32Uint = s32Hash.ToString();
        } catch
        {
        }
    }
}
