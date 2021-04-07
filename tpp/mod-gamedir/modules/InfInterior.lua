--InfInterior.lua
-- tex implements IH interior addon system
--currently only for motherbase

--TODO: make rest of IH interior aware. I guess: IsMissionPackLabel, but "default" or "Interior"?

--REF clusters {"Command","Combat","Develop","Support","Medical","Spy","BaseDev"}

--REF interior addon module <GameDir>\mod\interiors\ >
--DEBUGNOW
local this={
  description="Interior example: BG Hangar",--description for IH
  missionCode=30050,--missionCode this is an interior for DEBUGNOW do I want to restrict it like that? its needed at some point, and all the outer exit info is a position in the specific mission
  packs=function(missionCode)--DEBUGNOW?
    TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30050/f30050_hanger_btg00mod.fpk"
  end,
  --tex switch on mb to enter interior. strictly speaking this doesn't need to have anything to do with the interior
  enterSwitchLocatorName="ext_enter_switch_cl0_plnt0_hangar_ih",--DEBUGNOW
  enterSwitchDataSet="/Assets/tpp/level/location/mtbs/block_large/ext_switches_ly03_cl00_ih.fox2",--DEBUGNOW this will be dynamic on vars.layout
  --tex interior to exterior switch, defined in an interior pack
  exitSwitchLocatorName="int_exit_switch_mtbs_hanger_test_ih",
  exitDataSetName="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick_test_ih.fox2",
  startPos={pos={-11.600,-8.000,8.511},rotY=180},--start position, rotation in interior coordinates
  startCamera={rotX=-10,rotY=200},--optional, initial camera rotation once warped to interior
  clusterName="Command",--mb specific, the cluster this interior is supposed to be in
  plant="plnt0",--mb specific, the plant (platform) the interior is supposed to be in
  outsideExitPos={pos={-30.980, -7.000, 14.779},rotY=0},--DEBUGNOW in relation to platform center?? see GetPositionOuterInterior
}

--return this
--< REF interior addon module
local interiorInfo=this--DEBUGNOW

InfCore.StrCode32(interiorInfo.enterSwitchLocatorName)--DEBUGNOW add for lookup
InfCore.StrCode32(interiorInfo.exitSwitchLocatorName)--DEBUGNOW add for lookup

local function AddDataSetToLookup(dataset)--DEBUGNOW TODO add this to inflookup
  local path32=Fox.PathFileNameCode32(dataset)--DEBUGNOW TODO do a InfCore.PathFileNameCode32 setup like InfCore.StrCode32
  InfLookup.path32ToDataSetName[path32]=dataset
end

--DEBUGNOW AddDataSetToLookup(interiorInfo.enterSwitchDataSet)
--DEBUGNOW AddDataSetToLookup(interiorInfo.exitSwitchDataSet)

--DEBUGNOW
--DEBUGNOW
--hangar interior switch
local gimmickName="gntn_swtc001_vrtn001_gim_n0000|srt_gntn_swtc001_vrtn001"
local dataSetName="/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
--cluster ? plat0 battlge hangar exterior entrance switch
local gimmickName="ly003_cl02_item0000|cl02pl0_uq_0020_gim_onlymb2|gntn_swtc001_vrtn001_gim_n0000|srt_gntn_swtc001_vrtn001"
local dataSetName="/Assets/tpp/level/location/mtbs/block_area/ly00" ..tostring(vars.mbLayoutCode) .."/cl02/mtbs_ly00" ..tostring(vars.mbLayoutCode).. "_cl02_item.fox2"


--DEBUGNOW
local switchEntries={
  ["ly003_cl02_item0000|cl02pl0_uq_0020_gim_onlymb2|gntn_swtc001_vrtn001_gim_n0000|srt_gntn_swtc001_vrtn001"]={--tex gimmickId is switchEntried Id
    clusterName="Develop",
    plant="plnt0",
    outsideExitPos={pos={-30.980,-7.000,14.779},rotY=180},--DEBUGNOW in relation to platform center?? see GetPositionOuterInterior
  }
}
--DEBUGNOW
local switchConnections={
  ["ly003_cl02_item0000|cl02pl0_uq_0020_gim_onlymb2|gntn_swtc001_vrtn001_gim_n0000|srt_gntn_swtc001_vrtn001"]={
    interior="some_interior_id",
  },
}
--tex then reverse lookup I guess for interior>switchId


local this={}

local StrCode32=InfCore.StrCode32

function this.AddMissionPacks(missionCode,packPaths)
  --DEBUGNOW
  --if has locations installed
  if missionCode==30050 then
    --layout, cluster? how does game add these cluster packs?
   --table.insert(packPaths,"/Assets/tpp/pack/location/mtbs/pack_area/mtbs_area_ly000_cl00_ih.fpk")


    --DEBUGNOW test switches
    TppPackList.AddMissionPack"/Assets/tpp/pack/location/mtbs/pack_area/mtbs_area_ly003_cl00_ih.fpk"--DEBUGNOW this fpk not in right place, see area packs mtbs_area_ly003_cl00
 
  end
end--AddMissionPacks

function this.AddInteriorMissionPacks(missionCode)
--DEBUGNOW get missionCode/ base pack for mission
     TppPackList.AddMissionPack"/Assets/tpp/pack/mission2/free/f30050/f30050_interior_base.fpk"

  local interiorInfo=interiorInfo--DEBUGNOW how do we know what interior??

  interiorInfo.packs(missionCode)
end

function this.PushSwitchOnLeave(gameObjectId, locatorNameStr32, name, switchFlag)
  InfCore.Log"InfInterior.PushSwitchOnLeave"--tex DEBUG

  --DEBUGNOW TODO iterate interiorExitSwitches
  local interiorInfo=interiorInfo--DEBUGNOW get interior for gameObjectName, name? iteate switches until GimmickGetGameobject==gameobject??
  
  if locatorNameStr32~=StrCode32(interiorInfo.exitSwitchLocatorName) then--DEBUGNOW
    InfCore.Log("locatorName ~= "..tostring(interiorInfo.exitSwitchLocatorName))--DEBUGNOW
    return false
  end

  --tex TODO? (interior def optional) open interior door
  --  local dataSetName = "/Assets/tpp/level/location/mtbs/block_large/mtbs_hanger_gimmick.fox2"
  --  local dataName = "mtbs_door006_door004_ev_gim_n0000|srt_mtbs_door006_door004_ev"
  --  Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION, dataName, dataSetName, false)
  --tex TODO -^- open door sound
  --  local soundPos = this.GetPositionInInteriorDoor()
  --  TppSoundDaemon.PostEvent3D( "sfx_m_hanger_door_open", Vector3(soundPos[1],soundPos[2],soundPos[3]), 'Loading')

  TppMission.Reload{
    missionPackLabelName="AfterDemo",
    clusterId=TppDefine.CLUSTER_DEFINE[interiorInfo.clusterName],--DEBUGNOW
    OnEndFadeOut=function()
      svars.restartClusterId=TppDefine.CLUSTER_DEFINE[interiorInfo.clusterName]--DEBUGNOW
      TppSequence.ReserveNextSequence("Seq_Game_Setup")
      local pos,rotY=this.GetPositionOuterInterior(gameObjectId,locatorNameStr32,name,switchFlag)
      TppPlayer.SetInitialPosition(pos,rotY)
      mtbs_cluster.LockCluster(interiorInfo.clusterName)--DEBUGNOW wut
      svars.isLeaveInterior=true--DEBUGNOW
    end,
  }
  return true
end--PushSwitchOnLeave

function this.PlayerSwitchStart(playerGameObjectId, switchGameObjectId)
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

--DEBUGNOW not workable as no info as to what interior we exited
--change f30050_sequence.isLeaveInterior to id of what switch
function this.PlayExteriorDoorClose()
--    local soundPos = this.GetPositionOuterInterior(gameObjectId, gameObjectName, name, switchFlag)
--    TppSoundDaemon.PostEvent3D( "sfx_m_hanger_door_close", Vector3(soundPos[1],soundPos[2],soundPos[3]), 'Loading')
end--PlayExteriorDoorClose

--CALLER: PushSwitchOnLeave
function this.GetPositionOuterInterior(gameObjectId, gameObjectName, name, switchFlag)
  --DEBUGNOW TODO: find interior for switch, get exit/outside teleport pos
  local interiorInfo=interiorInfo--DEBUGNOW
  
  return mtbs_cluster.GetPosAndRotY( interiorInfo.clusterName, interiorInfo.plant, interiorInfo.outsideExitPos.pos , interiorInfo.outsideExitPos.rotY )
end--GetPositionOuterInterior

--tex DEBUGNOW need info on what switch or interior it is
function this.WarpToInterior()
  TppPlayer.Warp{ pos = {-11.600, -8.000, 8.511}, rotY = 180}
  Player.RequestToSetCameraRotation{rotX =-10 , rotY = 200 }
end

function this.PushSwitchOnEnterInterior(gameObjectId, locatorNameS32, name, switchFlag)
  InfCore.LogFlow"PushSwitchOnEnterInterior"


  local interiorInfo=interiorInfo--DEBUGNOW

  --DEBUGNOW check interior switches
  if locatorNameS32~=StrCode32(interiorInfo.enterSwitchLocatorName) then
    InfCore.Log("locatorNameStr ~= "..interiorInfo.enterSwitchLocatorName)--DEBUGNOW
    return false
  end

  --DEBUGNOW
  do
    local triggerDistance = 9.0
    local pos, rotY = mtbs_cluster.GetPosAndRotY( interiorInfo.clusterName, interiorInfo.plant, interiorInfo.outsideExitPos.pos, 0 )--GOTCHA DEBUGNOW why rotY = 0 instead of interiorInfo.outsideExitPos.rotY???
    local distance = (pos[1] - vars.playerPosX) * ( pos[1] - vars.playerPosX ) + ( pos[2] - vars.playerPosY ) * (pos[2] - vars.playerPosY) + (pos[3] - vars.playerPosZ) * ( pos[3] - vars.playerPosZ )
    if distance > triggerDistance then
      InfCore.Log("WARNING: player > triggerDistance")
      --DEBUGNOW return
    end
  end


  TppSound.HaltSceneBGM()--DEBUGNOW

  --f30050_sequence.SetEnableQuestUI(false)--DEBUGNOW

  --tex DEBUGNOW (interiorInfo optional) door open and sound
  --  local dataSetName = "/Assets/tpp/level/location/mtbs/block_area/ly00" ..tostring(vars.mbLayoutCode) .."/cl02/mtbs_ly00" ..tostring(vars.mbLayoutCode).. "_cl02_item.fox2"
  --  local dataName = "ly003_cl02_item0000|cl02pl0_uq_0020_gim_onlymb2|mtbs_door006_door002_ev_gim_n0000|srt_mtbs_door006_door002_ev"
  --  Gimmick.BreakGimmick(TppGameObject.GAME_OBJECT_TYPE_EVENT_ANIMATION, dataName, dataSetName, false)
  --
  --  local soundPos = this.GetPositionOuterInteriorDoor()
  --  TppSoundDaemon.PostEvent3D( "sfx_m_hanger_door_open", Vector3(soundPos[1],soundPos[2],soundPos[3]), 'Loading')

  TppMission.Reload{
    missionPackLabelName = "Interior",
    clusterId = TppDefine.CLUSTER_DEFINE[interiorInfo.clusterName],--DEBUGNOW was TppDefine.CLUSTER_DEFINE.Command,--DEBUGNOW
    OnEndFadeOut = function()
      svars.restartClusterId = TppDefine.CLUSTER_DEFINE[interiorInfo.clusterName]--DEBUGNOW was TppDefine.CLUSTER_DEFINE.Command--DEBUGNOW
      TppSave.ReserveVarRestoreForContinue()
      this.SetPlayerInitialPositionInInterior()--DEBUGNOW
      TppSequence.ReserveNextSequence( "Seq_Demo_Interior" )
    end,
  }
  --  else--REF CULL was if not BattleGearDevelop, fun to just have the door buzz
  --    local playerPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
  --    local soundPos = playerPos + Quat.RotationY( vars.playerRotY ):Rotate( Vector3(-0.65,0.35,0.3) )
  --    TppSoundDaemon.PostEvent3D( "sfx_m_door_buzzer", soundPos )
  --  end
end--PushSwitchOnEnterInterior

--DEBUGNOW need interiorInfo
function this.SetPlayerInitialPositionInInterior()
  TppPlayer.SetInitialPosition({-11.600, -8.000, 8.511}, 180 )
  vars.playerCameraRotation[0] = -10
  vars.playerCameraRotation[1] = 200
end--SetPlayerInitialPositionInInterior

--DEBUGNOW need interiorInfo
--CALLERS: Seq_Demo_Interior OnEnter, Seq_Game_Interior OnEnter,
function this.SetupInterior()
  TppWeather.ForceRequestWeather( TppDefine.WEATHER.SUNNY, 0 )

  --DEBUGNOW TppDataUtility.SetVector4EffectFromId("BattleHangerDoorLightOnLeave", "Color", 0.0, 1.0, 0.5, 0.5 )--DEBUGNOW
  --DEBUGNOW
  --  TppUiStatusManager.SetStatus( "EquipHud" ,"INVALID")
  --  TppUiStatusManager.SetStatus( "EquipPanel","INVALID")
  --  TppUI.OverrideFadeInGameStatus{
  --    EquipHud = false,
  --    EquipPanel = false,
  --  }
  --  f30050_sequence.SetEnableQuestUI(false)--DEBUGNOW
end--SetupInterior

function this.SetupPadMaskInInterior()
  Player.SetPadMask {

    settingName = "Interior",

    except = false,

    buttons = PlayerPad.MB_DEVICE
    + PlayerPad.HOLD
    + PlayerPad.RELOAD
  }
end--SetupPadMaskInInterior

--DEBUGNOW
--CALLER: ?, use?
function this.GetPositionInInteriorDoor()
  local pos = {-11.512, -6.922, 10.334}
  local rotY = 0
  return mtbs_cluster.GetPosAndRotY( "Command", "plnt0", pos, rotY )
end--GetPositionInInteriorDoor

--DEBUGNOW
--CALLER: ?, use?
function this.GetPositionOuterInteriorDoor()
  local pos = {-30.078, -6.922, 15.039 }
  local rotY = 0
  return mtbs_cluster.GetPosAndRotY( "Develop", "plnt0", pos , rotY )
end--GetPositionOuterInteriorDoor

return this
