-- DOBUILD: 1
--InfMain.lua
--Mostly interface between TppMain / other game modules and IH modules.
InfCore.LogFlow"Load InfMain.lua"
local this={}

--LOCALOPT:
local InfMain=this
local InfCore=InfCore
local IvarProc=IvarProc
local InfButton=InfButton
local InfModules=InfModules
local TppMission=TppMission
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Enum=TppDefine.Enum
local StrCode32=InfCore.StrCode32
local GetPlayingDemoId=DemoDaemon.GetPlayingDemoId
local IsDemoPaused=DemoDaemon.IsDemoPaused
local IsDemoPlaying=DemoDaemon.IsDemoPlaying
local DoMessage=Tpp.DoMessage
local CheckMessageOption=TppMission.CheckMessageOption
local pairs=pairs
local ipairs=ipairs

local reloadModulesCombo={
  InfButton.HOLD,
  InfButton.DASH,
  InfButton.ACTION,
  InfButton.SUBJECT,
}

this.appliedProfiles=false

--STATE
--tex gvars.isContinueFromTitle is cleared in OnAllocate while it could have still been useful,
--this is valid from OnAllocateTop to OnInitializeBottom, till not helispace
this.isContinueFromTitle=false

function this.OnLoadEvars()

end

--CALLER: TppVarInit.StartTitle, game save actually first loaded
--not super accurate execution timing wise
function this.OnStartTitle()
  InfCore.LogFlow"InfMain.OnStartTitle"
  InfCore.gameSaveFirstLoad=true

  this.CallOnModules("OnStartTitle")
end

--tex from InfHooks hook on TppSave.DoSave
function this.OnSave()
  IvarProc.OnSave()
end

--Tpp module hooks/calls>

--tex from TppMission.Load
function this.OnLoad(nextMissionCode,currentMissionCode)
  if this.IsFOBMission(nextMissionCode)then
    return
  end

  this.CallOnModules("OnLoad",nextMissionCode,currentMissionCode)
end

--CALLER: TppEneFova.PreMissionLoad
function this.PreMissionLoad(missionId,currentMissionId)
  InfCore.LogFlow"InfMain.PreMissionLoad"

  if this.IsFOBMission(missionId)then
    return
  end

  this.CallOnModules("PreMissionLoad",missionId,currentMissionId)
end

function this.OnAllocateTop(missionTable)
  local enable=Ivars.debugMode:Is(1)
  this.DebugModeEnable(enable)

  if gvars.isContinueFromTitle then
    this.isContinueFromTitle=true
  end

  this.CallOnModules("OnAllocateTop",missionTable)
end
function this.OnAllocate(missionTable)
  if this.IsFOBMission(vars.missionCode)then
    --DEBUGNOW
    if InfSoldierParams then
      TppSoldier2.ReloadSoldier2ParameterTables(InfSoldierParams.soldierParametersDefaults)
    end
    if InfResources then
    InfResources.DefaultResourceTables()
    end
    return
  end

  if igvars then
    InfCore.Log("inf_levelSeed "..tostring(igvars.inf_levelSeed))--DEBUG
  end

  this.CallOnModules("OnAllocate",missionTable)
end
--tex in OnAllocate, just after sequence.MissionPrepare
function this.MissionPrepare()
  if this.IsFOBMission(vars.missionCode)then
    return
  end

  this.CallOnModules("MissionPrepare")
end

--tex called at very start of TppMain.OnInitialize, use mostly for hijacking missionTable scripts
function this.OnInitializeTop(missionTable)
  if this.IsFOBMission(vars.missionCode)then
    return
  end

  this.CallOnModules("OnInitializeTop",missionTable)
end

--tex called about halfway through TppMain.OnInitialize (on all require libs)
function this.Init(missionTable)
  this.abortToAcc=false

  if this.IsFOBMission(vars.missionCode) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  local currentChecks=this.UpdateExecChecks(this.execChecks)
  this.CallOnModules("Init",missionTable,currentChecks)
end

--tex just after mission script_enemy.SetUpEnemy
function this.SetUpEnemy(missionTable)
  InfCore.LogFlow("InfMain.SetUpEnemy "..vars.missionCode)
  if this.IsFOBMission(vars.missionCode)then
    return
  end
  this.CallOnModules("SetUpEnemy",missionTable)
end

function this.OnInitializeBottom(missionTable)
  if this.IsFOBMission(vars.missionCode)then
    return
  end

  if vars.missionCode>TppDefine.SYS_MISSION_ID.TITLE and not this.IsHelicopterSpace(vars.missionCode) then
    this.isContinueFromTitle=false
  end
end

--CALLER: TppMissionList.GetMissionPackagePath
--IN/OUT packPath
function this.AddMissionPacks(missionCode,packPaths)
  InfCore.LogFlow("InfMain.AddMissionPacks "..missionCode)
  if TppMission.IsFOBMission(missionCode)then
    return
  end

  --  local packages=this.packages[missionCode]
  --  if packages then
  --    for i,packPath in ipairs(packages) do
  --      packPaths[#packPaths+1]=packPath
  --    end
  --  end

  for i,module in ipairs(InfModules) do
    if IsFunc(module.AddMissionPacks) then
      InfCore.LogFlow(module.name..".AddMissionPacks:")
      InfCore.PCallDebug(module.AddMissionPacks,missionCode,packPaths)
    end
  end
end

--tex called via TppSequence Seq_Mission_Prepare.OnUpdate > TppMain.OnMissionCanStart
function this.OnMissionCanStartBottom()
  InfCore.LogFlow"InfMain.OnMissionCanStartBottom"
  if this.IsFOBMission(vars.missionCode)then
    return
  end

  local currentChecks=this.UpdateExecChecks(this.execChecks)
  this.CallOnModules("OnMissionCanStart",currentChecks)
end

--tex called from TppMain.OnReload (TODO: caller of that?) on all require libs
function this.OnReload(missionTable)
  if this.IsFOBMission(vars.missionCode) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  this.CallOnModules("OnReload",missionTable)
end

--tex called from TppMission.OnMissionGameEndFadeOutFinish2nd
function this.OnMissionGameEndTop()
  if this.IsFOBMission(vars.missionCode)then
    return
  end

  this.CallOnModules("OnMissionGameEnd")
end

--tex called from TppMission.AbortMission (TODO: caller of that?)
function this.AbortMissionTop(abortInfo)
  if this.IsFOBMission(abortInfo.nextMissionId)then
    return
  end

  --InfCore.Log("AbortMissionTop "..vars.missionCode)--DEBUG
  InfMain.RegenSeed(vars.missionCode,abortInfo.nextMissionId)

  InfGameEvent.DisableEvent()--DEBUGNOW: InfMainTpp
end

--CALLERS TppMission.MissionFinalize/OnEndMissionReward < called from in sequence when decided mission is ended
function this.ExecuteMissionFinalizeTop()
  if this.IsFOBMission(gvars.mis_nextMissionCodeForMissionClear)then
    return
  end

  this.RegenSeed(vars.missionCode,gvars.mis_nextMissionCodeForMissionClear)
  InfGameEvent.DisableEvent()--DEBUGNOW: InfMainTpp
  InfCore.PCall(InfGameEvent.GenerateEvent,gvars.mis_nextMissionCodeForMissionClear)--DEBUGNOW: InfMainTpp
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.Messages()
  return Tpp.StrCode32Table{
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=this.FadeInOnGameStart},--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=this.FadeInOnGameStart},--fires on: returning to heli from mission
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=this.FadeInOnGameStart},--fires on: on-foot mother base, both initial and continue
    },
    Block={
      {msg="StageBlockCurrentSmallBlockIndexUpdated",func=function(blockIndexX,blockIndexY,clusterIndex)
        if Ivars.printOnBlockChange:Is(1) then
          InfCore.DebugPrint("OnSmallBlockIndex - x:"..blockIndexX..", y:"..blockIndexY.." clusterIndex:"..tostring(clusterIndex))
        end
      end},
      {msg="OnChangeLargeBlockState",func=function(blockNameStr32,blockStatus)
        if Ivars.printOnBlockChange:Is(1) then
          InfCore.DebugPrint("OnChangeLargeBlockState - blockNameStr32:"..blockNameStr32.." blockStatus:"..blockStatus)
        end
      end},
    },
  }
end

--CALLER: TppUI.FadeIn
function this.OnFadeInDirect(msgName)
  InfCore.LogFlow("InfMain.OnFadeInDirect:"..tostring(msgName))
  if vars.missionCode > 5 and this.IsFOBMission(vars.missionCode)then
    return
  end

  this.CallOnModules("OnFadeInDirect",msgName)
end

--CALLER: TppUI.FadeOut
function this.OnFadeOutDirect(msgName)
  InfCore.LogFlow("InfMain.OnFadeOutDirect:"..tostring(msgName))
  if vars.missionCode > 5 and this.IsFOBMission(vars.missionCode)then
    return
  end

  this.CallOnModules("OnFadeOutDirect",msgName)
end

--msg called fadeins
function this.FadeInOnGameStart()
  InfCore.LogFlow"InfMain.FadeInOnGameStart"
  this.WeaponVarsSanityCheck()--DEBUGNOW TODO this wont actually be called since messages are off in FOB?, but it was working when I wrote it, so did I only block messages in fob after?

  if this.IsFOBMission(vars.missionCode)then
    return
  end

  --TppUiStatusManager.ClearStatus"AnnounceLog"
  --InfMenu.ModWelcome()
end

function this.OnMenuOpen()

end
function this.OnMenuClose()
  local activeControlMode=this.GetActiveControlMode()
  if activeControlMode then
    if IsFunc(activeControlMode.OnActivate) then
      activeControlMode.OnActivate()
    end
  end

  InfCore.PCallDebug(IvarProc.SaveAll)
end

--Caller heli_common_sequence.Seq_Game_MainGame.OnEnter
function this.OnEnterACC()
  if not InfCore.mainModulesOK then
    this.ModuleErrorMessage()
  else
    InfMenu.ModWelcome()

    --tex dummy/EQUIP_NONE hangun/assault CULL
    --    local developIds={
    --      900,
    --      901,
    --    }
    --    for i,developId in ipairs(developIds) do
    --      if not TppMotherBaseManagement.IsEquipDevelopedFromDevelopID{equipDevelopID=developId} then
    --        InfCore.Log("SetEquipDeveloped "..developId)
    --        TppMotherBaseManagement.SetEquipDeveloped{equipDevelopID=developId}
    --      end
    --    end

    --tex only want this on enter ACC because changing vars on a mission is not a good idea
    if not this.appliedProfiles then
      this.appliedProfiles=true
      IvarProc.ApplyInfProfiles(Ivars.profileNames)
    end
  end
end
--tex on holding esc at title
function this.ClearOnAbortToACC()
  igvars.inf_event=false
end

this.execChecks={
  inGame=false,--tex actually loaded game, ie at least 'continued' from title screen
  inHeliSpace=false,
  inMission=false,
  inDemo=false,
  initialAction=false,--tex mission actually started/reached ground, triggers on checkpoint save so might not be valid for some uses
  inGroundVehicle=false,
  inSupportHeli=false,
  onBuddy=false,--tex sexy
  inBox=false,
  inMenu=false,
}

this.currentTime=0

this.abortToAcc=false--tex

--tex NOTE: doesn't actually return a new table/reuses input
function this.UpdateExecChecks(currentChecks)
  for k,v in pairs(this.execChecks) do
    this.execChecks[k]=false
  end

  currentChecks.inGame=not mvars.mis_missionStateIsNotInGame
  currentChecks.inHeliSpace=vars.missionCode and this.IsHelicopterSpace(vars.missionCode)
  currentChecks.inMission=currentChecks.inGame and not currentChecks.inHeliSpace
  currentChecks.inDemo=currentChecks.inGame and (IsDemoPaused() or IsDemoPlaying() or GetPlayingDemoId())

  if currentChecks.inGame then
    local playerVehicleId=vars.playerVehicleGameObjectId
    if not currentChecks.inHeliSpace then
      currentChecks.initialAction=svars.ply_isUsedPlayerInitialAction--VERIFY that start on ground catches this (it's triggered on checkpoint save DOESNT catch motherbase ground start
      --if not initialAction then--DEBUG
      --InfCore.DebugPrint"not initialAction"
      --end
      currentChecks.inSupportHeli=Tpp.IsHelicopter(playerVehicleId)--tex VERIFY
      currentChecks.inGroundVehicle=Tpp.IsVehicle(playerVehicleId)-- or Tpp.IsEnemyWalkerGear(playerVehicleId)?? VERIFY
      currentChecks.onBuddy=Tpp.IsHorse(playerVehicleId) or Tpp.IsPlayerWalkerGear(playerVehicleId)
      currentChecks.inBox=Player.IsVarsCurrentItemCBox()
    end
  end

  return currentChecks
end
this.startTime=0
this.updateTimes={}--DEBUG
function this.Update()
  InfCore.PCallDebug(function()--DEBUG
    local InfMenu=InfMenu
    if this.IsFOBMission(vars.missionCode) then
      return
    end

    if this.debugModule then
      this.startTime=os.clock()--DEBUG
    end

    local currentChecks=this.UpdateExecChecks(this.execChecks)
    this.currentTime=Time.GetRawElapsedTimeSinceStartUp()

    InfButton.UpdateHeld()
    InfButton.UpdateRepeatReset()

    this.DoControlSet(currentChecks)

    ---Update shiz
    if not InfCore.mainModulesOK then
      if InfButton.OnButtonHoldTime(InfMenu.toggleMenuButton) then
        this.ModuleErrorMessage()
      end
    else
      InfMenu.Update(currentChecks)
      currentChecks.inMenu=InfMenu.menuOn

      for i,module in ipairs(InfModules) do
        if module.Update then
          if this.debugModule then
            this.updateTimes[module.name]=this.updateTimes[module.name] or {}
            this.startTime=os.clock()--DEBUG
          end

          --tex <module>.active is either number or ivar
          local active=this.ValueOrIvarValue(module.active)
          if module.active==nil or active>0 then
            local updateRate=this.ValueOrIvarValue(module.updateRate)
            this.ExecUpdate(currentChecks,this.currentTime,module.execCheckTable,module.execState,updateRate,module.Update)
          end

          if this.debugModule then
            table.insert(this.updateTimes[module.name],os.clock()-this.startTime)
          end
        end
      end
    end
    ---
    InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks

    if this.debugModule then
    --    this.updateTimes[#this.updateTimes+1]=os.clock()-this.startTime
    end
  end)--DEBUG
end

function this.ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,ExecUpdateFunc)
  --tex modules may set their own update rate
  if execState and execState.nextUpdate>currentTime then
    return
  end

  if execChecks then
    for check,ivarCheck in pairs(execChecks) do
      if currentChecks[check]~=ivarCheck then
        return
      end
    end
  end

  if not IsFunc(ExecUpdateFunc) then
    InfCore.DebugPrint"ExecUpdateFunc is not a function"
    return
  end

  InfCore.PCallDebug(ExecUpdateFunc,currentChecks,currentTime,execChecks,execState)

  if updateRate>0 then
    execState.nextUpdate=currentTime+updateRate
  end

  --DEBUG
  --if currentChecks.inGame then
  -- InfCore.DebugPrint("currentTime: "..tostring(currentTime).." updateRate:"..tostring(updateRate) .." nextUpdate:"..tostring(execState.nextUpdate))
  --end
end

function this.DoControlSet(currentChecks)
  local abortButton=InfButton.ESCAPE
  InfButton.buttonStates[abortButton].holdTime=1.6

  if InfButton.OnButtonHoldTime(abortButton) then
    if gvars.ini_isTitleMode then
      local splash=SplashScreen.Create("abortsplash","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)
      SplashScreen.Show(splash,0,0.3,0)
      this.abortToAcc=true
      this.ClearOnAbortToACC()
    else--elseif currentChecks.inGame then--WIP
    --this.ClearStatus()
    end
  end

  if currentChecks.inGame then
    if InfButton.OnComboActive(reloadModulesCombo) then
      InfCore.DebugPrint("LoadExternalModules")
      local isReload=true
      this.LoadExternalModules(isReload)
      if not InfCore.mainModulesOK then
        this.ModuleErrorMessage()
      end
    end
  end
end

--warp mode,camadjust
--config
this.moveRightButton=InfButton.RIGHT
this.moveLeftButton=InfButton.LEFT
this.moveForwardButton=InfButton.UP
this.moveBackButton=InfButton.DOWN
this.moveUpButton=InfButton.DASH
this.moveDownButton=InfButton.ZOOM_CHANGE
--cam buttons
this.resetModeButton=InfButton.SUBJECT
this.verticalModeButton=InfButton.ACTION
this.zoomModeButton=InfButton.FIRE
this.apertureModeButton=InfButton.RELOAD
this.focusDistanceModeButton=InfButton.STANCE
this.distanceModeButton=InfButton.HOLD
this.speedModeButton=InfButton.ACTION

this.nextEditCamButton=InfButton.RIGHT
this.prevEditCamButton=InfButton.LEFT

function this.RegenSeed(currentMission,nextMission)
  --tex hard to find a line to draw in the sand between one mission and the next, so i'm just going for if you've gone to acc then that you're new levelseed set
  -- this does mean that free roam<>mission wont get a change though, but that may be useful in some circumstances
  if this.IsHelicopterSpace(nextMission) and currentMission>5 then
    this.RandomResetToOsTime()
    igvars.inf_levelSeed=math.random(0,2147483647)
    InfCore.Log("InfMain.RegenSeed new seed "..tostring(igvars.inf_levelSeed))--DEBUG
  end
end

function this.RandomSetToLevelSeed()
  --  InfCore.Log("RandomSetToLevelSeed:"..tostring(igvars.inf_levelSeed))--DEBUG
  --  InfCore.Log("caller:"..InfCore.DEBUG_Where(2))--DEBUG
  math.randomseed(igvars.inf_levelSeed)
  math.random()
  math.random()
  math.random()
end

function this.RandomResetToOsTime()
  --  InfCore.Log"RandomResetToOsTime"--DEBUG
  --  InfCore.Log("caller:"..InfCore.DEBUG_Where(2))--DEBUG
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
end



function this.MinMaxIvarRandom(ivarName)
  local ivarMin=Ivars[ivarName.."_MIN"]
  local ivarMax=Ivars[ivarName.."_MAX"]
  return math.random(ivarMin:Get(),ivarMax:Get())
end

this.SetFriendlyCp = function()
  local gameObjectId = { type="TppCommandPost2", index=0 }
  local command = { id="SetFriendlyCp" }
  GameObject.SendCommand( gameObjectId, command )
end

this.SetFriendlyEnemy = function()
  local gameObjectId = { type="TppSoldier2" }
  local command = { id="SetFriendly", enabled=true }
  GameObject.SendCommand( gameObjectId, command )
end

this.cpPositions={
  afgh={
    afgh_citadelSouth_ob={-1682.557,536.637,-2409.226},
    afgh_sovietSouth_ob={-1558.834,414.159,-1159.438},
    afgh_plantWest_ob={-1173.101,458.269,-1392.586},
    afgh_waterwayEast_ob={-1358.766,398.534,-742.015},
    afgh_tentNorth_ob={-1758.428,336.844,211.112},
    afgh_enemyNorth_ob={-182.129,411.550,-454.07},
    afgh_cliffWest_ob={302.273,415.153,-860.780},
    afgh_tentEast_ob={-1169.6,302.742,938.917},
    afgh_enemyEast_ob={-361.562,356.97,114.79},
    afgh_cliffEast_ob={1259.04,479.846,-1345.574},
    afgh_slopedWest_ob={99.113,334.220,89.654},
    afgh_remnantsNorth_ob={-1065.079,291.448,1467.447},
    afgh_cliffSouth_ob={1040.302,379.051,-505.49},
    afgh_fortWest_ob={1825.444,465.684,-1252.843},
    afgh_villageWest_ob={-258.249,298.451,927.591},
    afgh_slopedEast_ob={977.664,318.965,-169.445},
    afgh_fortSouth_ob={2194.072,429.323,-1271},
    afgh_villageNorth_ob={504.530,329.411,702.308},
    afgh_commWest_ob={983.531,347.594,665.96},
    afgh_bridgeWest_ob={1584.864,347.409,48.656},
    afgh_bridgeNorth_ob={2394.559,369.135,-517.208},
    afgh_fieldWest_ob={8.862,274.866,1992.816},
    afgh_villageEast_ob={939.176,318.845,1259.34},
    afgh_ruinsNorth_ob={1623.511,323.038,1062.995},
    afgh_fieldEast_ob={1101.482,318.458,1828.101},

    --afgh_plantSouth_ob--Only references in generic setups",-- no actual missions
    --afgh_waterway_cp--Only references in generic setups",-- no actual missions

    afgh_cliffTown_cp={787,466,-994},
    afgh_tent_cp={-1761.73,317.69,806.51},
    afgh_powerPlant_cp={-685,533,-1487},
    afgh_sovietBase_cp={-2197,443,-1474},
    afgh_remnants_cp={-905.605,288.846,1922.272},
    afgh_field_cp={425.95,270.16,2198.39},
    afgh_citadel_cp={-1251.708,595.181,-2936.821},
    afgh_fort_cp={2106.16,463.64,-1747.21},
    afgh_village_cp={508,319,1171},
    afgh_bridge_cp={1920,322,-475},
    afgh_commFacility_cp={1488.730,357.429,459.287},
    afgh_slopedTown_cp={514.191,331.173,43.403},
    afgh_enemyBase_cp={-596.89,353.02,497.40},
  },
  mafr={
    mafr_swampWest_ob={-561.458,1.203,-189.687},--Guard Post 01, NW Kiziba Camp
    mafr_diamondNorth_ob={1326.073,152.667,-1899.799},--Guard Post 02, NE Kungenga Mine
    mafr_bananaEast_ob={570.117,79.988,-1071.741},--Guard Post 03, SE Bampeve Plantation
    mafr_bananaSouth_ob={232.093,3.048,-653.531},--Guard Post 04, SW Bampeve Plantation
    mafr_savannahNorth_ob={707.557,34.091,-913.209},--Guard Post 05, NE Ditadi Abandoned Village
    mafr_outlandNorth_ob={-806.758,1.056,690.615},--Guard Post 06, North Masa Village
    mafr_diamondWest_ob={1047.941,121.694,-1170.218},--Guard Post 07, West Kungenga Mine
    mafr_labWest_ob={2146.880,192.241,-2177.558},--Guard Post 08, NW Lufwa Valley
    mafr_savannahWest_ob={713.843,3.120,-547.492},--Guard Post 09, North Ditadi Abandoned Village
    mafr_swampEast_ob={344.727,-5.164,-7.508},--Guard Post 10, SE Kiziba Camp
    mafr_outlandEast_ob={-275.585,-7.796,767.962},--Guard Post 11, East Masa Village
    mafr_swampSouth_ob={316.517,-5.944,369.979},--Guard Post 12, South Kiziba Camp
    mafr_diamondSouth_ob={1439.533,99.656,-720.559},--Guard Post 13, SW Kungenga Mine
    mafr_pfCampNorth_ob={928.184,-4.859,372.320},--Guard Post 14, NE Nova Braga Airport
    mafr_savannahEast_ob={1197.290,8.719,78.842},--Guard Post 15, South Ditadi Abandoned Village
    mafr_hillNorth_ob={1915.400,60.799,-230.770},--Guard Post 16, NE Munoko ya Nioka Station
    mafr_factoryWest_ob={2515.327,71.937,-814.150},--Guard Post 17, West Ngumba Industrial Zone
    mafr_pfCampEast_ob={1196.617,-4.470,567.516},--Guard Post 18, East Nova Braga Airport
    mafr_hillWest_ob={1673.172,24.406,137.511},--Guard Post 19, NW Munoko ya Nioka Station
    mafr_factorySouth_ob={2349.303,68.733,-113.923},--Guard Post 20, SW Ngumba Industrial Zone
    mafr_hillWestNear_ob={1799.202,-4.737,711.536},--Guard Post 21, West Munoko ya Nioka Station
    mafr_chicoVilWest_ob={1549.457,-10.819,1776.419},--Guard Post 22, South Nova Braga Airport
    mafr_hillSouth_ob={2012.754,-10.564,1376.297},--Guard Post 23, SW Munoko ya Nioka Station
    --mafr_swampWestNear_ob--Only references in generic setups, no actual missions

    mafr_flowStation_cp={-1001.38,-7.20,-199.16},--Mfinda Oilfield
    mafr_banana_cp={277.078,42.670,-1160.725},--Bampeve Plantation
    mafr_diamond_cp={1243.253,139.279,-1524.267},--Kungenga Mine
    mafr_lab_cp={2707.418,174.801,-2428.483},--Lufwa Valley
    mafr_swamp_cp={-55.823,-3.758,55.400},--Kiziba Camp
    mafr_outland_cp={-596.105,-16.714,1094.863},--Masa Village
    mafr_savannah_cp={979.923,26.267,-201.705},--Ditadi Abandoned Village
    mafr_pfCamp_cp={846.46,-4.97,1148.62},--Nova Braga Airport
    mafr_hill_cp={2154.83,63.09,366.70},--Munoko ya Nioka Station --redo

  --mafr_factory_cp={},--Ngumba Industrial Zone - no soldiers  NOTE in interrog
  --mafr_swampWestNear_ob={},--Only references in generic setups, no actual missions

  --mafr_chicoVil_cp={},--??
  },
  mbqf={
    mbqf_mtbs_cp={-158.183,0.801,-2076.006},
  },
  mtbs={
    mbqf_mtbs_cp={-158.183,0.801,-2076.006},--tex mbqf free (f30250) (loc 55) actually comes up as location 50/mtbs
    ["ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|mtbs_command_cp"]={9.430,0.800,-24.179},
    ["ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|mtbs_combat_cp"]={1141.248,8.800,-604.406},
    ["ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|mtbs_develop_cp"]={1189.571,20.798,314.824},
    ["ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|mtbs_support_cp"]={372.656,0.800,860.953},
    ["ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|mtbs_medic_cp"]={-137.282,0.800,-964.455},
    ["ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|mtbs_intel_cp"]={-668.973,4.925,524.886},
    ["ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|mtbs_basedev_cp"]={-744.900,8.800,-360.478},
  }
}

function this.GetClosestCp(position)
  local playerPos={vars.playerPosX,vars.playerPosY,vars.playerPosZ}
  position=position or playerPos

  local locationName=InfUtil.GetLocationName()
  local cpPositions=this.cpPositions[locationName]
  if cpPositions==nil then
    InfCore.DebugPrint("WARNING: GetClosestCp no cpPositions for locationName "..locationName)
    return nil,nil,nil
  end

  local closestCp=nil
  local closestDist=9999999999999999
  local closestPosition=nil
  for cpName,cpPosition in pairs(cpPositions)do
    if cpPosition==nil then
      InfCore.DebugPrint("cpPosition==nil for "..tostring(cpName))
      return
    elseif #cpPosition~=3 then
      InfCore.DebugPrint("#cpPosition~=3 for "..tostring(cpName))
      return
    end

    local distSqr=TppMath.FindDistance(position,cpPosition)
    --InfCore.DebugPrint(cpName.." dist:"..math.sqrt(distSqr))--DEBUG
    if distSqr<closestDist then
      closestDist=distSqr
      closestCp=cpName
      closestPosition=cpPosition
    end
  end
  --InfCore.DebugPrint("Closest cp "..InfMenu.CpNameString(closestCp,locationName)..":"..closestCp.." ="..math.sqrt(closestDist))--DEBUG
  local cpId=GetGameObjectId(closestCp)
  if cpId and cpId~=NULL_ID then
    return closestCp,closestDist,closestPosition
  else
    return
  end
end
--<cp stuff

--actionflags
this.menuDisableActions=PlayerDisableAction.OPEN_EQUIP_MENU--+PlayerDisableAction.OPEN_CALL_MENU

function this.RestoreActionFlag()
  --local activeControlMode=this.GetActiveControlMode()
  -- WIP
  --  if activeControlMode then
  --    if bit.band(vars.playerDisableActionFlag,menuDisableActions)==menuDisableActions then
  --    else
  --      this.EnableAction(menuDisableActions)
  --    end
  --  else
  this.EnableAction(this.menuDisableActions)
  --  end
end

function this.DisableAction(actionFlag)
  if not this.ActionIsDisabled(actionFlag) then
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+actionFlag
  end
end
function this.EnableAction(actionFlag)
  if this.ActionIsDisabled(actionFlag) then
    vars.playerDisableActionFlag=vars.playerDisableActionFlag-actionFlag
  end
end

function this.ActionIsDisabled(actionFlag)
  if bit.band(vars.playerDisableActionFlag,actionFlag)==actionFlag then
    return true
  end
  return false
end

--
this.allButCamPadMask={
  settingName="allButCam",
  except=true,
  --buttons=PlayerPad.STANCE,
  sticks=PlayerPad.STICK_R,
}
--CULL REF
--local commonControlPadMask={
--  settingName="controlMode",
--  except=false,
--  buttons=PlayerPad.ALL,
--  sticks=PlayerPad.STICK_L,--+PlayerPad.STICK_R,
--  triggers=PlayerPad.TRIGGER_L+PlayerPad.TRIGGER_R,
--}

function this.GetActiveControlMode()
  local controlModes={
    Ivars.warpPlayerUpdate,
    Ivars.adjustCameraUpdate,
  }
  for i,ivar in ipairs(controlModes)do
    if ivar:Is(1) then
      return ivar
    end
  end
  return nil
end
--

--tex duplication of TppDefine with outer clusters defined
--Separation is Quarantine,Ward,mbqf
--Zoo ly500, don't think it's officially cluster 8, but I'm making it so
this.CLUSTER_NAME={"Command","Combat","Develop","Support","Medical","Spy","BaseDev","Separation","Zoo"}
this.CLUSTER_DEFINE=InfUtil.EnumFrom0(this.CLUSTER_NAME)
--this.PLNT_NAME={"Special","Common1","Common2","Common3"}--or plat0-plat3
--this.PLNT_DEFINE=this.Enum(this.PLNT_NAME)

--lrrp plus
this.baseNames={
  afgh={
    --TODO HANG "afgh_citadelSouth_ob",--Guard Post 01, East Afghanistan Central Base Camp
    "afgh_sovietSouth_ob",--Guard Post 02, South Afghanistan Central Base Camp
    "afgh_plantWest_ob",--Guard Post 03, NW Serak Power Plant
    "afgh_waterwayEast_ob",--Guard Post 04, East Aabe Shifap Ruins
    "afgh_tentNorth_ob",--Guard Post 05, NE Yakho Oboo Supply Outpost--note: not in 30010 interrogate
    "afgh_enemyNorth_ob",--Guard Post 06, NE Wakh Sind Barracks
    "afgh_cliffWest_ob",--Guard Post 07, NW Sakhra Ee Village
    "afgh_tentEast_ob",--Guard Post 08, SE Yakho Oboo Supply Outpost
    "afgh_enemyEast_ob",--Guard Post 09, East Wakh Sind Barracks
    "afgh_cliffEast_ob",--Guard Post 10, East Sakhra Ee Village
    "afgh_slopedWest_ob",--Guard Post 11, NW Ghwandai Town
    "afgh_remnantsNorth_ob",--Guard Post 12, North Lamar Khaate Palace
    "afgh_cliffSouth_ob",--Guard Post 13, South Sakhra Ee Village
    "afgh_fortWest_ob",--Guard Post 14, West Smasei Fort
    "afgh_villageWest_ob",--Guard Post 15, NW Wialo Village
    "afgh_slopedEast_ob",--Guard Post 16, SE Da Ghwandai Khar
    "afgh_fortSouth_ob",--Guard Post 17, SW Smasei Fort
    "afgh_villageNorth_ob",--Guard Post 18, NE Wailo Village
    "afgh_commWest_ob",--Guard Post 19, West Eastern Communications Post
    "afgh_bridgeWest_ob",--Guard Post 20, West Mountain Relay Base
    "afgh_bridgeNorth_ob",--Guard Post 21, SE Mountain Relay Base
    "afgh_fieldWest_ob",--Guard Post 22, North Shago Village
    "afgh_villageEast_ob",--Guard Post 23, SE Wailo Village
    "afgh_ruinsNorth_ob",--Guard Post 24, East Spugmay Keep
    "afgh_fieldEast_ob",--Guard Post 25, East Shago Village

    --"afgh_plantSouth_ob",--Only references in generic setups, no actual missions
    --"afgh_waterway_cp",--Only references in generic setups, no actual missions

    "afgh_cliffTown_cp",--Qarya Sakhra Ee
    "afgh_tent_cp",--Yakho Oboo Supply Outpost
    "afgh_powerPlant_cp",--Serak Power Plant
    "afgh_sovietBase_cp",--Afghanistan Central Base Camp
    "afgh_remnants_cp",--Lamar Khaate Palace
    "afgh_field_cp",--Da Shago Kallai
    "afgh_citadel_cp",--OKB Zero
    "afgh_fort_cp",--Da Smasei Laman
    "afgh_village_cp",--Da Wialo Kallai
    "afgh_bridge_cp",--Mountain Relay Base
    "afgh_commFacility_cp",--Eastern Communications Post
    "afgh_slopedTown_cp",--Da Ghwandai Khar
    "afgh_enemyBase_cp",--Wakh Sind Barracks
  },--#39

  mafr={
    "mafr_swampWest_ob",--Guard Post 01, NW Kiziba Camp
    "mafr_diamondNorth_ob",--Guard Post 02, NE Kungenga Mine
    "mafr_bananaEast_ob",--Guard Post 03, SE Bampeve Plantation
    "mafr_bananaSouth_ob",--Guard Post 04, SW Bampeve Plantation
    "mafr_savannahNorth_ob",--Guard Post 05, NE Ditadi Abandoned Village
    "mafr_outlandNorth_ob",--Guard Post 06, North Masa Village
    "mafr_diamondWest_ob",--Guard Post 07, West Kungenga Mine
    "mafr_labWest_ob",--Guard Post 08, NW Lufwa Valley
    "mafr_savannahWest_ob",--Guard Post 09, North Ditadi Abandoned Village
    "mafr_swampEast_ob",--Guard Post 10, SE Kiziba Camp
    "mafr_outlandEast_ob",--Guard Post 11, East Masa Village
    "mafr_swampSouth_ob",--Guard Post 12, South Kiziba Camp
    "mafr_diamondSouth_ob",--Guard Post 13, SW Kungenga Mine
    "mafr_pfCampNorth_ob",--Guard Post 14, NE Nova Braga Airport
    "mafr_savannahEast_ob",--Guard Post 15, South Ditadi Abandoned Village
    "mafr_hillNorth_ob",--Guard Post 16, NE Munoko ya Nioka Station
    --TODO HANG addlrrp  "mafr_factoryWest_ob",--Guard Post 17, West Ngumba Industrial Zone
    "mafr_pfCampEast_ob",--Guard Post 18, East Nova Braga Airport
    "mafr_hillWest_ob",--Guard Post 19, NW Munoko ya Nioka Station
    "mafr_factorySouth_ob",--Guard Post 20, SW Ngumba Industrial Zone
    "mafr_hillWestNear_ob",--Guard Post 21, West Munoko ya Nioka Station
    "mafr_chicoVilWest_ob",--Guard Post 22, South Nova Braga Airport
    "mafr_hillSouth_ob",--Guard Post 23, SW Munoko ya Nioka Station
    --"mafr_swampWestNear_ob",--Only references in generic setups, no actual missions
    "mafr_flowStation_cp",--Mfinda Oilfield
    "mafr_banana_cp",--Bampeve Plantation
    "mafr_diamond_cp",--Kungenga Mine
    "mafr_lab_cp",--Lufwa Valley
    "mafr_swamp_cp",--Kiziba Camp
    "mafr_outland_cp",--Masa Village
    "mafr_savannah_cp",--Ditadi Abandoned Village
    "mafr_pfCamp_cp",--Nova Braga Airport
    "mafr_hill_cp",--Munoko ya Nioka Station

  --"mafr_factory_cp",--Ngumba Industrial Zone - no soldiers  NOTE in interrog
  --"mafr_chicoVil_cp",--??
  },--#34
  mbqf={
    "mbqf_mtbs_cp",
  },
  mtbs={
    "mbqf_mtbs_cp",--tex WORKAROUND mbqf free (f30250) (loc 55) actually comes up as location 50/mtbs
    "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|mtbs_command_cp",
    "ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|mtbs_combat_cp",
    "ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|mtbs_develop_cp",
    "ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|mtbs_support_cp",
    "ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|mtbs_medic_cp",
    "ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|mtbs_intel_cp",
    "ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|mtbs_basedev_cp",
  },
}

--tex in the mission soldierDefine tables there's a bunch of empty _lrrp cps that I'm repurposing
local lrrpInd="_lrrp"
function this.BuildEmptyCpPool(soldierDefine)
  local cpPool={}
  for cpName,cpDefine in pairs(soldierDefine)do
    local cpId=GetGameObjectId("TppCommandPost2",cpName)
    if cpId==NULL_ID then
      InfCore.DebugPrint("BuildEmptyCpPool: soldierDefine "..cpName.."==NULL_ID")--DEBUG
    else
      if #cpDefine==0 then
        --tex cp is labeled _lrrp
        if string.find(cpName,lrrpInd) then
          if not cpDefine.lrrpVehicle and not cpDefine.travelPlan then
            cpPool[#cpPool+1]=cpName
          end
        end
      end
    end
  end
  --  InfCore.Log"cpPool"--DEBUG
  --  InfCore.PrintInspect(cpPool)--DEBUG
  return cpPool
end

function this.BuildBaseCpPool(soldierDefine)
  local cpPool={}
  for cpName,cpDefine in pairs(soldierDefine)do
    local cpId=GetGameObjectId("TppCommandPost2",cpName)
    if cpId==NULL_ID then
      InfCore.DebugPrint("BuildCpPool: soldierDefine "..cpName.."==NULL_ID")--DEBUG
    else
      if #cpDefine>0 then
        if not cpDefine.lrrpVehicle and not cpDefine.travelPlan then
          cpPool[#cpPool+1]=cpName
        end
      end
    end
  end
  --  InfCore.Log"cpPool"--DEBUG
  --  InfCore.PrintInspect(cpPool)--DEBUG
  return cpPool
end

--IN-SIDE: InfVehicle.inf_patrolVehicleConvoyInfo
function this.BuildCpPoolWildCard(soldierDefine)
  local baseNamePool={}
  for cpName,cpDefine in pairs(soldierDefine)do
    if #cpDefine>0 then
      local cpId=GetGameObjectId("TppCommandPost2",cpName)
      if cpId==NULL_ID then
        InfCore.Log("BuildCpPoolWildCard: soldierDefine cpId==NULL",true)--DEBUG
      else
        --tex TODO: allow quest_cp, but regenerate soldier on quest load
        if cpName=="quest_cp" then
        --tex TODO: consider if you want to  have wilcards in lrrps
        elseif cpDefine.lrrpVehicle==nil and cpDefine.lrrpTravelPlan~=nil then
        elseif cpDefine.lrrpVehicle~=nil then
          if #cpDefine>1 then--ASSUMPTION only armored vehicles have 1 occupant
            --WORKAROUND the ordering of convoy setup/filling previously empty cpDefines on checkpoint restart
            local isConvoy=InfVehicle.inf_patrolVehicleConvoyInfo[cpDefine.lrrpTravelPlan]
            if isConvoy==false then
              baseNamePool[#baseNamePool+1]=cpName
            end
          end
        else
          baseNamePool[#baseNamePool+1]=cpName
        end
      end
    end
  end
  return baseNamePool
end
---
function this.MarkObject(gameId)
  if gameId==NULL_ID then
    return
  end

  local radiusLevel=0--0-9
  local goalType="none"--TppMarker.GoalTypes
  local viewType="all"--TppMarker.ViewTypes
  local randomLevel=0--0-9 randoms to radiuslevel I guess
  local setImportant=true
  local setNew=false
  TppMarker.Enable(gameId,0,"moving","all",0,setImportant,setNew)
end
---

function this.ClearStatus()
  InfCore.PCall(function()
    local splash=SplashScreen.Create("abortsplash","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)
    SplashScreen.Show(splash,0,0.3,0)

    vars.playerDisableActionFlag=PlayerDisableAction.NONE
    Player.SetPadMask{settingName="AllClear"}
    Tpp.SetGameStatus{target="all",enable=true,scriptName="InfMain.lua"}
    InfCore.DebugPrint"Cleared status"
  end)
end

local startOnFootStr="startOnFoot"
function this.IsStartOnFoot(missionCode,isAssaultLz)
  local missionCode=missionCode or vars.missionCode
  local enabled=IvarProc.EnabledForMission(startOnFootStr,missionCode)

  local assault=IvarProc.IsForMission(startOnFootStr,"NOT_ASSAULT",missionCode)
  if isAssaultLz and assault then
    return false
  else
    return enabled
  end
end

--ORPHAN
function this.ReadSaveVar(name,category)
  local category=category or TppScriptVars.CATEGORY_GAME_GLOBAL
  local globalSlotForSaving={TppDefine.SAVE_SLOT.SAVING,TppDefine.SAVE_FILE_INFO[category].slot}
  return TppScriptVars.GetVarValueInSlot(globalSlotForSaving,"gvars",name,0)
end

function this.IsContinue()
  return gvars.sav_varRestoreForContinue and not this.isContinueFromTitle
end

function this.WeaponVarsSanityCheck()
  --tex throw on some default weapons if using dummy/equip none so to not run afoul of CheckPlayerEquipmentServerItemCorrect
  --see SetSubsistenceSettings for alt attempt that doesn't seem to work.
  --TODO: currently the weapons arent added via RequestLoadToEquipMissionBlock so weapons wont be usable, but since the user would have had decided to go into fob with equip_none instead of changing to a proper loadout whatev
  if this.IsFOBMission(vars.missionCode) then
    local changedWeapon=vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]==TppEquip.EQP_None or vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]==TppEquip.EQP_None
    if changedWeapon then
      InfMenu.PrintLangId"fob_weapon_change"
    end
    if vars.weapons[TppDefine.WEAPONSLOT.PRIMARY_HIP]==TppEquip.EQP_None then
      --SVG-76 grade 1
      Player.ChangeEquip{
        equipId=TppEquip.EQP_WP_East_ar_010,
        stock=31,
        stockSub=0,
        ammo=180,
        ammoSub=0,
        dropPrevEquip = false,
      }
    end
    if vars.weapons[TppDefine.WEAPONSLOT.SECONDARY]==TppEquip.EQP_None then
      --Wu S grade 1
      Player.ChangeEquip{
        equipId=TppEquip.EQP_WP_West_thg_010,
        stock=8,
        stockSub=0,
        ammo=14,
        ammoSub=0,
        suppressorLife=100,
        isSuppressorOn=true,
        isLightOn=false,
        dropPrevEquip=false,
      }
    end
  end
end

function this.IsFOBMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==5 then
    return true
  else
    return false
  end
end
function this.IsHelicopterSpace(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==4 then
    return true
  else
    return false
  end
end

function this.ValueOrIvarValue(value)
  local value=value or 0
  if IsTable(value) then
    value=value:Get()
  end
  return value
end

function this.DisplayFox32(foxString)
  local str32 = StrCode32(foxString)
  TppUiCommand.AnnounceLogView("string :"..foxString .. "="..str32)
end

function this.DebugModeEnable(enable)
  local prevMode=InfCore.debugMode

  if enable then
    InfCore.Log("DebugModeEnable:"..tostring(enable),false)
    if InfHooks then
      InfCore.PCall(InfHooks.SetupDebugHooks)
    end
    if InfMenu then
      InfMenu.AddDevMenus()
    end
  else
    InfCore.Log("Further logging disabled while debugMode is off")
  end
  InfCore.debugMode=enable
end

--modules
--SIDE: modules,this.modulesOK
--SIDE: InfCore.files
--SIDE: this.moduleNames
--isReload = user initiated
function this.LoadExternalModules(isReload)
  InfCore.LogFlow"InfMain.LoadExternalModules"

  InfCore.mainModulesOK=true
  InfCore.otherModulesOK=true

  if isReload then
    InfCore.PCallDebug(InfCore.RefreshFileList)
  end

  --tex clear InfModules
  InfModules.moduleNames={}
  for i,moduleName in ipairs(InfModules)do
    InfModules[i]=nil
  end

  for i,moduleName in ipairs(InfModules.coreModules)do
    table.insert(InfModules.moduleNames,moduleName)
  end

  --tex get other external modules
  local moduleFiles=InfCore.GetFileList(InfCore.files.modules,".lua",true)
  for i,moduleName in ipairs(moduleFiles)do
    if not InfModules.isCoreModule[moduleName] then
      table.insert(InfModules.moduleNames,moduleName)
    end
  end
  InfCore.PrintInspect(InfModules.moduleNames,"InfModules.moduleNames")--DEBUG

  for i,moduleName in ipairs(InfModules.moduleNames) do
    InfCore.LoadExternalModule(moduleName,isReload)
    local module=_G[moduleName]
    if module then
      --InfCore.Log("Loaded "..moduleName)--DEBUG
      module.name=moduleName
      table.insert(InfModules,module)
    else
      if InfModules.isCoreModule[moduleName] then
        InfCore.mainModulesOK=false
      else
        InfCore.otherModulesOK=false
      end
    end
    --tex give some reponsiveness back, other hosts not set up as coroutine, or to resume
    if luaHostType=="MoonSharp" then
      coroutine.yield()
    end
  end

  InfCore.LogFlow("PostAllModulesLoad")--DEBUG
  InfCore.PCallDebug(this.PostAllModulesLoad)
  --NOTE: On first load only InfMain has been loaded at this point, so can't reference other IH lib modules.
  this.CallOnModules("PostAllModulesLoad")

  --tex profiles
  local ret=InfCore.PCall(IvarProc.SetupInfProfiles)
  --WORKAROUND PCall
  if ret and Ivars then
    Ivars.profileNames=ret[1]
    Ivars.profiles=ret[2]
  end
  --DEBUG
  --  InfCore.Log"--------------"
  --  InfCore.PrintInspect(Ivars.profileNames)
  --  InfCore.PrintInspect(Ivars.profiles)
end

--tex runs a function on all IH modules, used as the main message/event propogation to ih modules
function this.CallOnModules(functionName,...)
  for i,module in ipairs(InfModules) do
    if IsFunc(module[functionName]) then
      InfCore.LogFlow(module.name.."."..functionName..":")
      InfCore.PCallDebug(module[functionName],...)
    end
  end
end

function this.ModDirErrorMessage()
  --tex TODO: if InfLang then printlangid else -v-
  local msg="Infinite Heaven: Could not find MGS_TPP\\mod\\. See FAQ Known issues.txt"
  InfCore.DebugPrint(msg)
  InfCore.Log(msg,false,true)
end

function this.ModuleErrorMessage()
  --tex TODO: if InfLang then printlangid else -v-
  InfCore.DebugPrint"Infinite Heaven: Could not load modules from MGS_TPP\\mod\\. See FAQ Known issues.txt"
  InfCore.Log("Infinite Heaven: Could not load modules from MGS_TPP\\mod\\. See FAQ Known issues.txt",false,true)
end

function this.PostAllModulesLoad()
  local enable=Ivars.debugMode:Is(1)
  this.DebugModeEnable(enable)
end

--CALLER end of start2nd.lua
function this.LoadLibraries()
  InfCore.LogFlow"InfMain.LoadLibraries"

  for i,module in ipairs(InfModules) do
    if IsFunc(module.LoadLibraries) then
      InfCore.LogFlow(module.name..".LoadLibraries:")
      InfCore.PCallDebug(module.LoadLibraries)
    end
    end
end

--EXEC
_G.InfMain=this--WORKAROUND allowing external modules access to this before it's actually returned --KLUDGE using _G since I'm already definining InfMain as local

InfCore.LogFlow"InfMain Exec"
this.LoadExternalModules()
if not InfCore.mainModulesOK then
  this.ModuleErrorMessage()
end
InfCore.doneStartup=true

InfCore.LogFlow"InfMain.lua done"

return this
