local this={
  description="TGS 2014 SPECIAL MISSION",
  missionCode=13000,
  location="MAFR",
  packs=function(missionCode)
    TppPackList.AddLocationCommonScriptPack(missionCode)
    TppPackList.AddLocationCommonMissionAreaPack(missionCode)
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk"--tex PF_A,B,C soldiers
    TppPackList.AddDefaultMissionAreaPack(missionCode)
    do
      local settings={
        {
          type="hostage",
          name="hos_tgs_2014_0000",
          faceId=TppDefine.QUEST_FACE_ID_LIST.TAN,
          bodyId=TppDefine.QUEST_BODY_ID_LIST.MAFR_HOSTAGE_MALE
        },
      }
      TppEneFova.AddUniqueSettingPackage(settings)
    end
  end,
  fovaSetupFunc=function(locationName,missionId)
    TppEneFova.SetupFovaForLocation(locationName)--tex default fova func for location (fovaSetupFuncs.mafr in this case)
  end,
  enableOOB=true,
  missionGuaranteeGMP=12e5,
  missionTaskList={0,1,2,3},
  missionMapParams={
    missionArea2 = {
      {
        name="trig_innerZone",
        vertices={
          Vector3(2879.42,31.98,-1632.86),
          Vector3(2879.42,31.98,-2591.70),
          Vector3(2392.00,31.98,-2591.70),
          Vector3(2392.00,31.98,-1632.86),
        },
      },
    -- {
    -- name="trig_outerZone",
    -- vertices={
    -- Vector3(2929.42,31.98,-1586.00),
    -- Vector3(2929.42,31.98,-2641.70),
    -- Vector3(2342.00,31.98,-2641.70),
    -- Vector3(2342.00,31.98,-1586.00),
    -- },
    -- },
    },
    safetyArea2 = {
      {
        name="trig_hotZone",
        vertices={
          Vector3(2870.22,31.98,-1794.00),
          Vector3(2870.22,31.98,-2581.27),
          Vector3(2441.71,31.98,-2581.27),
          Vector3(2441.71,31.98,-1794.00),
        },
      },
    },
    missionStartPoint = {
      Vector3(2654.108,95.831,-1875.746),
    },
    heliLandPoint = {
      {
        point=Vector3(2652.815,96.82401,-1877.056),
        startPoint=Vector3(2654.108,95.831,-1875.746),
        routeId="lz_drp_lab_tgs_20140000|rt_drp_lab_tgs_2014_0000"
      },
    },
  },
}
return this
