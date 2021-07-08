using FoxKit.Utils;
using System;
using UnityEngine;

[ExecuteInEditMode]
public class EventParamHelper : MonoBehaviour
{
    public enum RouteAimTargetType
    {
        NoTarget = 0,
        StaticPoint = 0x100,
        Character = 0x200,
        RouteAsSightMovePath = 0x300,
        RouteAsObject = 0x400,
        NoTargetAlt = 0x1000000,
        StaticPointAlt = 0x1000100,
        CharacterAlt = 0x1000200,
        RouteAsSightMovePathAlt = 0x1000300,
        RouteAsObjectAlt = 0x1000400,
    };

    public bool IsEdge = false;

    public RouteAimTargetType AimTargetType;
    public uint Param0Uint = 0;

    public string Param1 = "0";
    public uint Param1Uint = 0;

    public string Param2 = "0";
    public uint Param2Uint = 0;

    public string Param3 = "0";
    public uint Param3Uint = 0;

    public string Param4 = "0";
    public uint Param4Uint = 0;

    public string Param5 = "0";
    public uint Param5Uint = 0;

    public string Param6 = "0";
    public uint Param6Uint = 0;

    public string Param7 = "0";
    public uint Param7Uint = 0;

    public string Param8 = "0";
    public uint Param8Uint = 0;

    public string Param9 = "0";
    public uint Param9Uint = 0;

    public float ParamFloat = 0.0f;
    public uint FloatAsUint = 0;

    public string ParamString = "";
    public uint StringAsS32Uint = 0;

    public ushort P1Short0FromYaw = 0;
    public ushort P1Short1WaitTime = 0;
    public uint Param1Combined = 0;

    // Use this for initialization
    void Start()
    {

    }

    // Update is called once per frame
    void Update()
    {

    }

    private uint StrCode32(string inputString)
    {
        return (uint)Hashing.HashFileNameLegacy(inputString);
    }

    // Called when value is changed in inspector
    private void OnValidate()
    {
        FloatAsUint = BitConverter.ToUInt32(BitConverter.GetBytes(ParamFloat), 0);

        StringAsS32Uint = StrCode32(ParamString);


        int aimAltRange = 0x1000000;
        // No edge events in vanilla frts use alt aimTargetType
        if (IsEdge)
        {
            if ((int)AimTargetType >= aimAltRange)
            {
                AimTargetType -= aimAltRange;
            }
        }


        switch (AimTargetType)
        {
            case RouteAimTargetType.NoTarget:
            case RouteAimTargetType.NoTargetAlt:
                Param2Uint = 0;
                Param3Uint = 0;
                Param4Uint = 0;
                break;
            case RouteAimTargetType.StaticPoint:
            case RouteAimTargetType.StaticPointAlt:
                Param2Uint = 0;
                Param3Uint = 0;
                Param4Uint = 0;

                float Param2Float = 0.0f;
                float Param3Float = 0.0f;
                float Param4Float = 0.0f;

                float.TryParse(Param2, out Param2Float);
                float.TryParse(Param3, out Param3Float);
                float.TryParse(Param4, out Param4Float);

                Param2Uint = BitConverter.ToUInt32(BitConverter.GetBytes(Param2Float), 0);
                Param3Uint = BitConverter.ToUInt32(BitConverter.GetBytes(Param3Float), 0);
                Param4Uint = BitConverter.ToUInt32(BitConverter.GetBytes(Param4Float), 0);

                break;
            case RouteAimTargetType.Character:
            case RouteAimTargetType.CharacterAlt:
                Param2Uint = StrCode32(Param2);
                Param3Uint = 0;
                Param4Uint = 0;
                break;
            case RouteAimTargetType.RouteAsSightMovePath:
            case RouteAimTargetType.RouteAsSightMovePathAlt:
                Param2Uint = StrCode32(Param2);
                Param3Uint = StrCode32(Param3);
                Param4Uint = StrCode32(Param4);
                break;
            case RouteAimTargetType.RouteAsObject:
            case RouteAimTargetType.RouteAsObjectAlt:
                Param2Uint = StrCode32(Param2);
                Param3Uint = StrCode32(Param3);
                Param4Uint = StrCode32(Param4);
                break;
            default:
                break;
        }

        Param0Uint = IsEdge ? (uint)AimTargetType : (uint)AimTargetType + 1;

        P1Short0FromYaw = GetShortRotation();

        uint RIGHT = 0xFFFF;
        Param1Combined = (uint)((P1Short0FromYaw << 16) | (P1Short1WaitTime & RIGHT));
    }//OnValidate

    private ushort GetShortRotation()
    {
        //tex: from caplag
        //https://discord.com/channels/364177293133873153/364177978315374592/819967138550251530
        float yaw = transform.rotation.eulerAngles.y;
        yaw -= 360;
        yaw = Mathf.Abs(yaw);
        yaw *= 182;
        return (ushort)yaw;
    }//GetShortRotation
}//EventParamHelper
