local e={}
function e.GetLocationName()
  if vars.locationCode==10 then
    return"afgh"
  elseif vars.locationCode==20 then
    return"mafr"
  elseif vars.locationCode==30 then
    return"cypr"
  elseif vars.locationCode==50 then
    return"mtbs"
  elseif vars.locationCode==55 then
    return"mbqf"
  end
end
function e.IsAfghan()
  if vars.locationCode==10 then
    return true
  else
    return false
  end
end
function e.IsMiddleAfrica()
  if vars.locationCode==20 then
    return true
  else
    return false
  end
end
function e.IsCyprus()
  if vars.locationCode==30 then
    return true
  else
    return false
  end
end
function e.IsMotherBase()
  if vars.locationCode==50 then
    return true
  else
    return false
  end
end
function e.IsMBQF()
  if vars.locationCode==55 then
    return true
  else
    return false
  end
end
function e.SetBuddyBlock(e)
  if TppGameSequence.GetGameTitleName()=="TPP"then
    if e==10 or e==20 then
      if TppBuddy2BlockController.CreateBlock then
        TppBuddy2BlockController.CreateBlock()
      end
    else
      if TppBuddy2BlockController.DeleteBlock then
        TppBuddy2BlockController.DeleteBlock()
      end
    end
  end
  return locationPackagePath
end
MotherBaseStage.RegisterModifyLayoutCodes{0,10,20,30,40,70,80,90,980}
function e.ModifyMbsLayoutCode(n)
  return MotherBaseStage.ModifyLayoutCode(n)
end
e.debug_useDebugMbParam=nil
function e.DEBUG_UseDebugMbParam()e.debug_useDebugMbParam=true
end
function e.ApplyPlatformParamToMbStage(n,t)
  if not TppMotherBaseManagement.BaseSvarsToMbsParam then
    return false
  end
  if e.debug_useDebugMbParam then
    e.debug_useDebugMbParam=nil
    return false
  end
  if n==10030 and TppMotherBaseManagement.SetUpMbsParamFor10030 then
    TppMotherBaseManagement.SetUpMbsParamFor10030()
  elseif n~=50050 then
    if TppDefine.EMERGENCY_MISSION_ENUM[n]then
      TppUiCommand.MapParamToMbsParam()
    else
      TppMotherBaseManagement.BaseSvarsToMbsParam{base=t}
    end
  else
    TppMotherBaseManagement.BaseFobToMbsParam()
  end
  return true
end
function e.GetMbStageHelicopterRoute(t,e,a)
  local e
  if t==50050 then
    TppMotherBaseManagement.BaseFobToMbsParam()
    local a=TppMotherBaseManagement.GetMbsTopologyType{}
    local n=TppMotherBaseManagement.GetMbsFirstCluster{}
    local o=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[n+1]}
    e=string.format("ly%03d_cl%02d_%05d_heli0000|cl%02dpl%01d_mb_fndt_plnt_heli_%05d|rt_apr_of",a,n,t,n,o-1,t)
  else
    e=a
  end
  return e
end
function e.SetForceConstructDevelopCluster()
  e.ApplyPlatformParamToMbStage()
  local n=TppMotherBaseManagement.GetMbsClusterGrade{category="Develop"}
  local e=1
  if n<e then
    TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Develop",grade=e,buildStatus="Completed",timeMinute=0,isNew=true}
  end
end
function e.RegistBaseAssetTable(n,e)
  if n then
    mvars.loc_locationBaseAssetOnActive={}
    for e,n in pairs(n)do
      mvars.loc_locationBaseAssetOnActive[Fox.StrCode32(e)]=n
    end
  end
  if e then
    mvars.loc_locationBaseOnActiveSmallBlock=e
    for e,n in pairs(e)do
      local e=n.activeArea
      if e then
        local e=Tpp.AreaToIndices(e)
        StageBlock.AddSmallBlockIndexForMessage(e)
      end
      if not n.OnActive then
      end
    end
  end
end
function e.RegistMissionAssetInitializeTable(n,e)
  if n then
    mvars.loc_missionAssetOnActive={}
    for n,e in pairs(n)do
      mvars.loc_missionAssetOnActive[Fox.StrCode32(n)]=e
    end
  end
  if e then
    mvars.loc_missionAssetOnActiveSmallBlock=e
    for e,n in pairs(e)do
      local e=n.activeArea
      if e then
        local e=Tpp.AreaToIndices(e)
        StageBlock.AddSmallBlockIndexForMessage(e)
      end
      if not n.OnActive then
      end
    end
  end
end
function e.Init(n)e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.ActivateBlock()
  local n={[1]=true,[30]=true,[50]=true,[55]=true}
  if n[vars.locationCode]then
    return
  end
  local n=StageBlock.GetLoadedLargeBlocks(0)
  for t,n in pairs(n)do
    e.OnActiveLargeBlock(n,StageBlock.ACTIVE)
  end
  local a=4
  local t,n=StageBlock.GetCurrentMinimumSmallBlockIndex()
  if not((t==0)and(n==0))then
    local o=t+a
    local a=n+a
    for t=t,o do
      for n=n,a do
        e.OnActiveSmallBlock(t,n,StageBlock.ACTIVE)
      end
    end
  end
end
function e.OnReload()e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMessage(i,s,r,a,o,t,n)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,i,s,r,a,o,t,n)
end
function e.Messages()
  return Tpp.StrCode32Table{Block={{msg="OnChangeLargeBlockState",func=e.OnActiveLargeBlock,option={isExecDemoPlaying=true,isExecMissionPrepare=true}},{msg="OnChangeSmallBlockState",func=e.OnActiveSmallBlock,option={isExecDemoPlaying=true,isExecMissionPrepare=true}}},nil}
end
function e.OnActiveLargeBlock(n,e)
  if e==StageBlock.INACTIVE then
    return
  end
  if TppSequence.IsEndSaving()==false then
    return
  end
  local e=mvars.loc_locationBaseAssetOnActive
  if e then
    local e=e[n]if e then
      e()
    end
  end
  local e=mvars.loc_missionAssetOnActive
  if e then
    local e=e[n]if e then
      e()
    end
  end
end
function e.OnActiveSmallBlock(t,n,e)
  if e==StageBlock.INACTIVE then
    return
  end
  local e=mvars.loc_locationBaseOnActiveSmallBlock
  if e then
    for a,e in pairs(e)do
      local e,a=e.activeArea,e.OnActive
      if e then
        if Tpp.CheckBlockArea(e,t,n)then
          a()
        end
      end
    end
  end
  local e=mvars.loc_missionAssetOnActiveSmallBlock
  if e then
    for a,e in pairs(e)do
      local e,a=e.activeArea,e.OnActive
      if e then
        if Tpp.CheckBlockArea(e,t,n)then
          a()
        end
      end
    end
  end
end
function e.GetMbStageClusterGrade(n)
  local e=TppMotherBaseManagement.GetMbsClusterGrade{category=TppDefine.CLUSTER_NAME[n]}
  if TppMotherBaseManagement.GetMbsClusterBuildStatus{category=TppDefine.CLUSTER_NAME[n]}=="Building"then
    e=e-1
  end
  return e
end
function e.GetLocalMbStageClusterGrade(e)
  return TppMotherBaseManagement.GetClusterGrade{base="MotherBase",category=TppDefine.CLUSTER_NAME[e]}
end
function e.MbFreeSpecialMissionStartSetting(e)
  if e==TppDefine.MISSION_CLEAR_TYPE.HELI_TAX_MB_FREE_CLEAR then
    if mvars.mis_helicopterMissionStartPosition then
      TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
      TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
    end
    TppMission.SetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
  end
end
return e
