--InfTransition.lua
-- tex implements in-game transition from one mission to another


--REF transtion info <GameDir>\mod\transition\ >
--DEBUGNOW TODO

--< REF transtion info

local this={}

local StrCode32=InfCore.StrCode32

this.infosPath="transitions"

this.names={}
this.infos={}--[name]=info

--[StrCode32(info.switchLocatorName)]=info
this.infoForSwitch={}

function this.PostModuleReload(prevModule)
  this.LoadLibraries()
end--PostAllModulesLoad

function this.LoadLibraries()
  this.LoadInfos()
  this.RegisterInfos()
end--LoadLibraries

function this.LoadInfos()
  --tex load infos
  local names={}
  local infos={}
  
  local files=InfCore.GetFileList(InfCore.files[this.infosPath],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("Load info: "..this.infosPath.." "..fileName)
    local name=InfUtil.StripExt(fileName)
    local module=InfCore.LoadSimpleModule(InfCore.paths[this.infosPath],fileName)
    if module==nil then
    --tex LoadSimpleModule should give the error
    else
      --TODO VALIDATE
      infos[name]=module
      table.insert(names,name)
    end--if module
  end
  
  this.names=names
  this.infos=infos
  
  if this.debugModule then
    InfCore.PrintInspect(this.infos,"InfTransition infos")
  end
end--LoadInfos

function this.RegisterInfos()
  for name,info in pairs(this.infos)do
    this.infoForSwitch[StrCode32(info.switchLocatorName)]=info
  end--for infos
end--RegisterInfos

function this.AddMissionPacks(missionCode,packPaths)
  if not InfMain.IsPastTitle(missionCode) then
    return
  end

  for name,transitionInfo in pairs(this.infos)do
    if transitionInfo.fromMissionCode==missionCode then
      local packs=transitionInfo.missionPacks
      if packs then
        if missionCode==30050 then
          packs=packs[vars.mbLayoutCode] or packs[0]--tex layout 0 can act as an all-layouts pack
        end
        for i,packPath in ipairs(packs)do
          packPaths[#packPaths+1]=packPath
        end
      end--if packs
    end--if missionCode
  end--for infor
end--AddMissionPacks
function this.Init(missionTable)
  this.messageExecTable=nil
  
  local missionHasTransition=false
  for name,transitionInfo in pairs(this.infos)do
    if transitionInfo.missionCode==vars.missionCode then
      missionHasTransition=true
      break
    end
  end
  if not missionHasTransition then
    return
  end
  
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end--Init
function this.OnReload(missionTable)
  this.messageExecTable=nil
  
  local missionHasTransition=false
  for name,transitionInfo in pairs(this.infos)do
    if transitionInfo.missionCode==vars.missionCode then
      missionHasTransition=true
      break
    end
  end
  if not missionHasTransition then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end--OnReload
local DoMessage=Tpp.DoMessage
local CheckMessageOption=TppMission.CheckMessageOption
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if this.messageExecTable==nil then
    return
  end
  DoMessage(this.messageExecTable,CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end--OnMessage
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="SwitchGimmick",func=this.PushSwitch},
    },
    Player={
      {msg="PlayerSwitchStart",func=this.PlayerSwitchStart},
    },
  }--StrCode32Table
end--Messages

--CALLER: msg="SwitchGimmick"
--REF PushSwitchOnLeaveBattleHanger
function this.PushSwitch(gameObjectId,locatorNameS32,name,switchFlag)
  InfCore.Log"InfTransition.PushSwitch"

  local transitionInfo=this.infoForSwitch[locatorNameS32]
  if transitionInfo==nil then
    InfCore.Log("InfTransition.PushSwitch infoForSwitch["..InfLookup.StrCode32ToString(locatorNameS32).." S32]==nil")
    return
  end
  
  if locatorNameS32~=StrCode32(transitionInfo.switchLocatorName) then
    InfCore.Log("ERROR: InfTransition.PushSwitch locatorName ~= "..tostring(transitionInfo.switchLocatorName))
    return
  end

  --tex TODO? (interior def optional) open interior door
  --  local dataSetName = "/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
  --  local dataName = "mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
  --  Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION, dataName, dataSetName, false)
  --tex TODO -^- open door sound, just play at info outsideExitPos?
  --  local soundPos = this.GetPositionInInteriorDoor()
  --  TppSoundDaemon.PostEvent3D( "sfx_m_hanger_door_open", Vector3(soundPos[1],soundPos[2],soundPos[3]), 'Loading')
--  local clusterId=TppDefine.CLUSTER_DEFINE[transferInfo.clusterName]
--  TppMission.Reload{
--    missionPackLabelName="AfterDemo",
--    clusterId=clusterId,
--    OnEndFadeOut=function()
--      svars.restartClusterId=clusterId
--      TppSequence.ReserveNextSequence("Seq_Game_Setup")
--      local pos,rotY=this.GetPositionOuterInterior(transferInfo)
--      TppPlayer.SetInitialPosition(pos,rotY)
--      mtbs_cluster.LockCluster(transferInfo.clusterName)
--      --svars.isLeaveInterior=true--tex ala isLeaveBattleHanger, just to play sfx_m_hanger_door_close OnEndMissionPrepareSequence
--    end,
--  }
  local startPos=transitionInfo.startPos.pos or transitionInfo.startPos
  if startPos then
    local rotY=transitionInfo.startPos.rotY or startPos[4]
    if transitionInfo.clusterName then
      startPos,rotY=this.GetMBPosAndRotY(transitionInfo.clusterName,transitionInfo.plant,startPos,rotY)
    end
    startPos[4]=rotY
    
    mvars.mis_transitionMissionStartPosition=startPos
    InfCore.PrintInspect(transitionInfo.startPos,"transitionInfo.startPos")--DEBUGNOW
    InfCore.PrintInspect(mvars.mis_transitionMissionStartPosition,"mis_transitionMissionStartPosition")--DEBUGNOW
  end
  
  local clusterId
  if transitionInfo.clusterName then
    clusterId=TppDefine.CLUSTER_DEFINE[transitionInfo.clusterName]
  end
  TppMission.ReserveMissionClear{
    nextMissionId=transitionInfo.missionCode,
    nextClusterId=clusterId,
    nextHeliRoute=transitionInfo.heliRoute,
    missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX
  }
end--PushSwitchOnLeave
--CALLER: msg="PlayerSwitchStart"
--REF f30050_sequence msg = "PlayerSwitchStart"
function this.PlayerSwitchStart(playerGameObjectId,switchGameObjectId)
--tex just run camera
--tex exit switch
--  do
--    local _, gameObjectId = Gimmick.GetGameObjectId(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "gntn_swtc001_vrtn001_gim_n0000|srt_gntn_swtc001_vrtn001","/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2" )
--    if gameObjectId == switchGameObjectId then
--      this.SetCameraPushSwitch()
--      return
--    end
--  end
--  --tex enter switch
--  do
--    local gimmickName = "ly003_cl02_item0000|cl02pl0_uq_0020_gim_onlymb2|gntn_swtc001_vrtn001_gim_n0000|srt_gntn_swtc001_vrtn001"
--    local dataSetName = "/Assets/tpp/level/location/mtbs/block_area/ly00" ..tostring(vars.mbLayoutCode) .."/cl02/mtbs_ly00" ..tostring(vars.mbLayoutCode).. "_cl02_item.fox2"
--    local _, gameObjectId = Gimmick.GetGameObjectId(TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, gimmickName , dataSetName)
--    if gameObjectId == switchGameObjectId then
--      this.SetCameraPushSwitch()
--      return
--    end
--  end
end--PlayerSwitchStart

--tex currently just unmodded copy of f30050_sequence SetCameraPushSwitch
--which in vanilla is used for outside and inside switches for both battlegear and paz room so probably dont even need to change this
function this.SetCameraPushSwitch()
  Player.RequestToPlayCameraNonAnimation {
    characterId = GameObject.GetGameObjectIdByIndex("TppPlayer2", 0),
    isFollowPos = true,
    isFollowRot = true,
    followTime = 4,
    followDelayTime = 0.1,
    candidateRots = { {6,10}, {6,-10} },
    skeletonNames = {"SKL_004_HEAD", "SKL_031_LLEG", "SKL_041_RLEG" },
    skeletonCenterOffsets = { Vector3( 0.0, 0.2, 0.0), Vector3( -0.15, 0.0, 0.0), Vector3( -0.15, 0.0, 0.0) },
    skeletonBoundings = { Vector3( 0.1, 0.125, 0.1), Vector3( 0.15, 0.1, 0.05), Vector3( 0.15, 0.1, 0.05) },
    offsetPos = Vector3(0.0,0.0,-3.0),
    focalLength = 28.0,
    aperture = 1.875,
    timeToSleep = 100,
    interpTimeAtStart = 0.5,
    fitOnCamera = false,
    timeToStartToFitCamera = 1,
    fitCameraInterpTime = 0.3,
    diffFocalLengthToReFitCamera = 16,
  }
end--SetCameraPushSwitch

--WORKAROUND mtbs_cluster only loaded with mtbs
local CLUSTER_INDEX = {}
for i,clusterName in ipairs(TppDefine.CLUSTER_NAME) do
  CLUSTER_INDEX[clusterName] = i
end
local PLNT_INDEX = {
  plnt0 = 0,
  plnt1 = 1,
  plnt2 = 2,
  plnt3 = 3,
}
function this.GetDemoCenter( clusterName, plntName )
  if clusterName then
    local clusterId = CLUSTER_INDEX[clusterName] - 1
    local plntId = 0
    if plntName then
      if Tpp.IsTypeString(plntName) then
        plntId = PLNT_INDEX[plntName]
      elseif Tpp.IsTypeNumber( plntName ) then
        plntId = plntName
      end
    end
    return MotherBaseStage.GetDemoCenter( clusterId, plntId )
  else
    return MotherBaseStage.GetDemoCenter()
  end
end
--GetPosAndRotY
function this.GetMBPosAndRotY( clusterName, plntName, pos, rotY )
  local plntCenterPos, rotQuat = this.GetDemoCenter( clusterName, plntName )
  local posVec = plntCenterPos + rotQuat:Rotate( Vector3(pos[1],pos[2],pos[3]) )
  local retPos = { posVec:GetX(), posVec:GetY(), posVec:GetZ() }
  local retRotY = rotY + Tpp.GetRotationY( rotQuat )
  return retPos, retRotY
end

return this
