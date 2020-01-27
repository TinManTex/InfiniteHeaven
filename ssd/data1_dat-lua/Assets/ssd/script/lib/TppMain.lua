-- DOBUILD: 1
-- ssd TppMain.lua
local this={}
local ApendArray=Tpp.ApendArray
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsSavingOrLoading=TppScriptVars.IsSavingOrLoading
local UpdateScriptsInScriptBlocks=ScriptBlock.UpdateScriptsInScriptBlocks
local GetCurrentMessageResendCount=Mission.GetCurrentMessageResendCount
local moduleUpdateFuncs={}
local numModuleUpdateFuncs=0
local missionScriptOnUpdateFuncs={}
local numOnUpdate=0
local debugUpdateFuncs={}
local numDebugUpdateFuncs=0
local qarReleaseUpdateFuncs={}
local numQarReleaseUpdateFuncs=0
local onMessageTable={}
local unkM3={}
local onMessageTableSize=0
local messageExecTable={}
local unkM4={}
local messageExecTableSize=0
--NMC: cant actually see this referenced anywhere
local function WaitForQuark()
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()
    coroutine.yield()
    while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
      coroutine.yield()
    end
  end
end
function this.DisableGameStatus()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,except={S_DISABLE_NPC=false},scriptName="TppMain.lua"}
end
function this.DisableGameStatusOnGameOverMenu()
  TppMission.DisableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=false,scriptName="TppMain.lua"}
end
function this.EnableGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true,S_DISABLE_HUD=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableGameStatusForDemo()
  TppDemo.ReserveEnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true,S_DISABLE_HUD=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableAllGameStatus()
  TppMission.EnableInGameFlag()
  Tpp.SetGameStatus{target="all",enable=true,scriptName="TppMain.lua"}
end
function this.EnablePlayerPad()
  TppGameStatus.Reset("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function this.DisablePlayerPad()
  TppGameStatus.Set("TppMain.lua","S_DISABLE_PLAYER_PAD")
end
function this.EnablePause()
  TppPause.RegisterPause"TppMain.lua"
end
function this.DisablePause()
  TppPause.UnregisterPause"TppMain.lua"
end
function this.EnableBlackLoading(showLoadingTips)
  TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")
  if showLoadingTips then
    TppUI.StartLoadingTips()
  end
end
function this.DisableBlackLoading()
  TppGameStatus.Reset("TppMain.lua","S_IS_BLACK_LOADING")
  TppUI.FinishLoadingTips()
end
function this.OnAllocate(missionTable)
  InfCore.LogFlow("OnAllocate Top "..vars.missionCode)--tex
  InfMain.OnAllocateTop(missionTable)--tex
  TppWeather.OnEndMissionPrepareFunction()
  this.DisableGameStatus()
  this.EnablePause()
  TppClock.Stop()
  moduleUpdateFuncs={}
  numModuleUpdateFuncs=0
  debugUpdateFuncs={}
  numDebugUpdateFuncs=0
  if(Tpp.IsQARelease()or nil)then
    TppDebug.RequestResetPlayLog()
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,TppUI.FADE_PRIORITY.SYSTEM)
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  TppMission.InitializeCoopMission()Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  if(Tpp.IsQARelease()or nil)then
    mvars.qaDebug={}
    TppSave.QARELEASE_DEBUG_Init()
    TppDebug.QARELEASE_DEBUG_Init()
    TppStory.QARELEASE_DEBUG_Init()
    TppEnemy.QARELEASE_DEBUG_Init()
    TppQuest.QARELEASE_DEBUG_Init()
    TppRadio.QARELEASE_DEBUG_Init()
    SsdFlagMission.QARELEASE_DEBUG_Init()
    SsdBaseDefense.QARELEASE_DEBUG_Init()
    SsdCreatureBlock.QARELEASE_DEBUG_Init()
    TppAnimalBlock.QARELEASE_DEBUG_Init()
  end

  --tex REWORKED to allow pcall TODO: should probably lua-hang on error rather than let it continue
  local libAllocateOrder={
    "TppException",
    "TppClock",
    "TppTrap",
    "TppCheckPoint",
    "TppUI",
    "TppDemo",
    "TppScriptBlock",
    "TppSound",
    "TppPlayer",
    "TppMission",
    "TppTerminal",
    "TppEnemy",
    "TppRadio",
    "TppGimmick",
    "TppMarker",
  }
  --tex in lua pcalls on a yield triggers an 'attempt to yield across metamethod/C-call boundary' error
  local yields={
    TppUI=true,
  }
  for i,libName in ipairs(libAllocateOrder)do
    InfCore.LogFlow(libName..".OnAllocate")
    if not _G[libName].OnAllocate then
      InfCore.Log("ERROR: TppMain.OnAllocate: could not find "..libName..".OnAllocate",false,true)
    else
      if yields[libName] then
        _G[libName].OnAllocate(missionTable)
      else
        InfCore.PCallDebug(_G[libName].OnAllocate,missionTable)
      end
    end
  end
  this.ClearStageBlockMessage()--tex VERIFY that TppQuest, TppAnimal .onallocate needs ClearStageBlockMessage (see ORIG)
  local libAllocateOrderPostBlockMessageClear={
    "TppQuest",
    "TppAnimal",
    "SsdFlagMission",
    "SsdBaseDefense",
    "SsdCreatureBlock",
    "InfMain",--tex
  }
  for i,libName in ipairs(libAllocateOrderPostBlockMessageClear)do
    InfCore.LogFlow(libName..".OnAllocate")
    if not _G[libName].OnAllocate then
      InfCore.Log("ERROR: TppMain.OnAllocate: could not find "..libName..".OnAllocate",false,true)
    else
      if yields[libName] then
        _G[libName].OnAllocate(missionTable)
      else
        InfCore.PCallDebug(_G[libName].OnAllocate,missionTable)
      end
    end
  end

  --ORIG
  --  TppException.OnAllocate(missionTable)
  --  TppClock.OnAllocate(missionTable)
  --  TppTrap.OnAllocate(missionTable)
  --  TppCheckPoint.OnAllocate(missionTable)
  --  TppUI.OnAllocate(missionTable)
  --  TppDemo.OnAllocate(missionTable)
  --  TppScriptBlock.OnAllocate(missionTable)
  --  TppSound.OnAllocate(missionTable)
  --  TppPlayer.OnAllocate(missionTable)
  --  TppMission.OnAllocate(missionTable)
  --  TppTerminal.OnAllocate(missionTable)
  --  TppEnemy.OnAllocate(missionTable)
  --  TppRadio.OnAllocate(missionTable)
  --  TppGimmick.OnAllocate(missionTable)
  --  TppMarker.OnAllocate(missionTable)
  --  this.ClearStageBlockMessage()
  --  TppQuest.OnAllocate(missionTable)
  --  TppAnimal.OnAllocate(missionTable)
  --  SsdFlagMission.OnAllocate(missionTable)
  --  SsdBaseDefense.OnAllocate(missionTable)
  --  SsdCreatureBlock.OnAllocate(missionTable)

  local function LocationOnAllocate()
    if TppLocation.IsAfghan()then
      if afgh then
        afgh.OnAllocate()
      end
    elseif TppLocation.IsMiddleAfrica()then
      if mafr then
        mafr.OnAllocate()
      end
    end
  end
  LocationOnAllocate()
  if missionTable.sequence then
    if IsTypeFunc(missionTable.sequence.MissionPrepare)then
      missionTable.sequence.MissionPrepare()
    end
    if IsTypeFunc(missionTable.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(missionTable.sequence.OnEndMissionPrepareSequence)
    end
  end
  InfMain.MissionPrepare()--tex
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnLoad)then
      InfCore.PCallDebug(module.OnLoad)--tex wrapped in pcall
    end
  end
  do
    local allSvars={}
    for i,lib in ipairs(Tpp._requireList)do
      if _G[lib]then
        if _G[lib].DeclareSVars then
          InfCore.LogFlow(lib..".DeclareSVars")--tex DEBUG
          ApendArray(allSvars,InfCore.PCallDebug(_G[lib].DeclareSVars,missionTable))--tex PCall
        end
      end
    end
    local missionSvars={}
    for name,module in pairs(missionTable)do
      if IsTypeFunc(module.DeclareSVars)then
        ApendArray(missionSvars,module.DeclareSVars())
      end
      if IsTypeTable(module.saveVarsList)then
        ApendArray(missionSvars,TppSequence.MakeSVarsTable(module.saveVarsList))
      end
    end
    ApendArray(allSvars,missionSvars)
    TppScriptVars.DeclareSVars(allSvars)Mission.RegisterUserSvars()
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while IsSavingOrLoading()do
      coroutine.yield()
    end
    while not SsdSaveSystem.IsIdle()do
      coroutine.yield()
    end
    TppRadioCommand.SetScriptDeclVars()
    if gvars.ini_isTitleMode then
      TppPlayer.MissionStartPlayerTypeSetting()
      Gimmick.RestoreSaveDataPermanentGimmickFromMission()--RETAILPATCH: 1.0.5.0
    else
      if TppMission.IsMissionStart()then
        TppVarInit.InitializeForNewMission(missionTable)
        TppPlayer.MissionStartPlayerTypeSetting()
        TppSave.VarSave(vars.missionCode,true)
      else
        TppVarInit.InitializeForContinue(missionTable)
      end
      TppVarInit.ClearIsContinueFromTitle()
    end
    TppUiCommand.ExcludeNonPermissionContents()
    if(not TppMission.IsDefiniteMissionClear())then
      TppTerminal.StartSyncMbManagementOnMissionStart()
    end
    TppPlayer.FailSafeInitialPositionForFreePlay()
    this.StageBlockCurrentPosition(true)
    TppMission.SetSortieBuddy()
    if missionTable.sequence then
      local disableBuddyType=missionTable.sequence.DISABLE_BUDDY_TYPE
      if disableBuddyType then
        local disableBuddyTypes
        if IsTypeTable(disableBuddyType)then
          disableBuddyTypes=disableBuddyType
        else
          disableBuddyTypes={disableBuddyType}
        end
        for n,buddyType in ipairs(disableBuddyTypes)do
          TppBuddyService.SetDisableBuddyType(buddyType)
        end
      end
    end
    if TppGameSequence.GetGameTitleName()=="TPP"then
      if missionTable.sequence and missionTable.sequence.OnBuddyBlockLoad then
        missionTable.sequence.OnBuddyBlockLoad()
      end
      if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
        TppBuddy2BlockController.Load()
      end
    end
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.soldierPowerSettings)then
      TppEnemy.SetUpPowerSettings(missionTable.enemy.soldierPowerSettings)
    end
  end
  if TppEquip.CreateEquipMissionBlockGroup then
    if(vars.missionCode>6e4)then
      TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}
    else
      TppPlayer.SetEquipMissionBlockGroupSize()
    end
  end
  if TppEquip.CreateEquipGhostBlockGroups then
    TppEquip.CreateEquipGhostBlockGroups{ghostCount=3}
  end
  TppEquip.StartLoadingToEquipMissionBlock()
  TppPlayer.SetMaxPickableLocatorCount()
  TppPlayer.SetMaxPlacedLocatorCount()
  TppEquip.AllocInstances{instance=60,realize=60}
  TppEquip.ActivateEquipSystem()
  if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  mvars.mis_skipServerSave=false
  if missionTable.sequence then
    mvars.mis_baseList=missionTable.sequence.baseList
    TppCheckPoint.RegisterCheckPointList(missionTable.sequence.checkPointList)
    if missionTable.sequence.SKIP_SERVER_SAVE then
      mvars.mis_skipServerSave=true
    end
  end
  InfCore.LogFlow("OnAllocate Bottom "..vars.missionCode)--tex
end
function this.OnInitialize(missionTable)
  InfCore.LogFlow("OnInitialize Top "..vars.missionCode)--tex
  InfMain.OnInitializeTop(missionTable)--tex
  TppCheckPoint.SetCheckPointPosition()
  if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  TppAnimalBlock.InitializeBlockStatus()
  SsdCreatureBlock.InitializeBlockStatus()
  TppQuest.RegisterQuestPackList(TppQuestList.questPackList)
  TppQuest.RegisterQuestList(TppQuestList.questList)
  if missionTable.enemy then
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(module.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  for i,lib in ipairs(Tpp._requireList)do
    if _G[lib].Init then
      InfCore.LogFlow(lib..".Init")--tex DEBUG
      InfCore.PCallDebug(_G[lib].Init,missionTable)--tex wrapped in pcall
    end
  end
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.soldierDefine)then
      TppEnemy.DefineSoldiers(missionTable.enemy.soldierDefine)
    end
    if missionTable.enemy.InitEnemy and IsTypeFunc(missionTable.enemy.InitEnemy)then
      missionTable.enemy.InitEnemy()
    end
    if IsTypeTable(missionTable.enemy.soldierPersonalAbilitySettings)then
      TppEnemy.SetUpPersonalAbilitySettings(missionTable.enemy.soldierPersonalAbilitySettings)
    end
    if IsTypeTable(missionTable.enemy.travelPlans)then
      TppEnemy.SetTravelPlans(missionTable.enemy.travelPlans)
    end
    TppEnemy.SetUpSoldiers()
    if IsTypeTable(missionTable.enemy.soldierDefine)then
      TppEnemy.InitCpGroups()
      TppEnemy.RegistCpGroups(missionTable.enemy.cpGroups)
      TppEnemy.SetCpGroups()
      if mvars.loc_locationGimmickCpConnectTable then
        TppGimmick.SetCommunicateGimmick(mvars.loc_locationGimmickCpConnectTable)
      end
    end
    do
      local routeSets
      if IsTypeTable(missionTable.enemy.routeSets)then
        routeSets=missionTable.enemy.routeSets
        for cpName,n in pairs(routeSets)do
          if not IsTypeTable(mvars.ene_soldierDefine[cpName])then
          end
        end
      end
      if routeSets then
        TppEnemy.RegisterRouteSet(routeSets)
        TppEnemy.MakeShiftChangeTable()
        TppEnemy.SetUpCommandPost()
        TppEnemy.SetUpSwitchRouteFunc()
      end
    end
    if missionTable.enemy.soldierSubTypes then
      TppEnemy.SetUpSoldierSubTypes(missionTable.enemy.soldierSubTypes)
    end
    TppEneFova.ApplyUniqueSetting()
    if missionTable.enemy.SetUpEnemy and IsTypeFunc(missionTable.enemy.SetUpEnemy)then
      missionTable.enemy.SetUpEnemy()
    end
    InfMain.SetUpEnemy(missionTable)--tex
    if TppMission.IsMissionStart()then
      TppEnemy.RestoreOnMissionStart2()
    else
      TppEnemy.RestoreOnContinueFromCheckPoint2()
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
  end
  local missionCode=vars.missionCode
  if TppMission.IsStoryMission(missionCode)or TppMission.IsFreeMission(missionCode)then
    local update=true
    if gvars.mis_skipUpdateBaseManagement then
      update=false
    end
    BaseDefenseManager.Restore(update)
    gvars.mis_skipUpdateBaseManagement=false
  end
  TppMarker.RestoreMarkerLocator()
  TppTerminal.MakeMessage()
  if missionTable.sequence then
    local SetUpRoutes=missionTable.sequence.SetUpRoutes
    if SetUpRoutes and IsTypeFunc(SetUpRoutes)then
      SetUpRoutes()
    end
    TppEnemy.RegisterRouteAnimation()
    local SetUpLocation=missionTable.sequence.SetUpLocation
    if SetUpLocation and IsTypeFunc(SetUpLocation)then
      SetUpLocation()
    end
  end
  for name,module in pairs(missionTable)do
    if module.OnRestoreSVars then
      module.OnRestoreSVars()
    end
  end
  TppMission.RestoreShowMissionObjective()
  if TppPickable.StartToCreateFromLocators then
    TppPickable.StartToCreateFromLocators()
  end
  if TppPlaced and TppPlaced.StartToCreateFromLocators then
    TppPlaced.StartToCreateFromLocators()
  end
  if TppMission.IsMissionStart()then
    TppRadioCommand.RestoreRadioState()
  else
    TppRadioCommand.RestoreRadioStateContinueFromCheckpoint()
  end
  TppMission.SetPlayRecordClearInfo()
  TppMission.PostMissionOrderBoxPositionToBuddyDog()
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
  TppQuest.UpdateActiveQuest()
  TppQuest.AcquireKeyItemOnMissionStart()
  TppUI.HideAccessIcon()
  InfMain.OnInitializeBottom(missionTable)--tex
  InfCore.LogFlow("OnInitialize Bottom "..vars.missionCode)--tex
end
function this.SetUpdateFunction(missionTable)
  moduleUpdateFuncs={}
  numModuleUpdateFuncs=0
  missionScriptOnUpdateFuncs={}
  numOnUpdate=0
  debugUpdateFuncs={}
  numDebugUpdateFuncs=0
  moduleUpdateFuncs={
    TppMission.Update,
    TppSequence.Update,
    TppSave.Update,
    TppDemo.Update,
    TppPlayer.Update,
    TppMission.UpdateForMissionLoad,
    InfMain.Update,--tex
  }
  numModuleUpdateFuncs=#moduleUpdateFuncs

  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnUpdate)then
      numOnUpdate=numOnUpdate+1
      missionScriptOnUpdateFuncs[numOnUpdate]=module.OnUpdate
    end
  end

  if(Tpp.IsQARelease()or nil)then
    qarReleaseUpdateFuncs={
      TppSave.QAReleaseDebugUpdate,
      TppDebug.QAReleaseDebugUpdate,
      TppStory.QAReleaseDebugUpdate,
      TppEnemy.QAReleaseDebugUpdate,
      TppQuest.QAReleaseDebugUpdate,
      TppRadio.QAReleaseDebugUpdate,
      SsdFlagMission.QAReleaseDebugUpdate,
      SsdBaseDefense.QAReleaseDebugUpdate,
      SsdCreatureBlock.QAReleaseDebugUpdate,
      TppAnimalBlock.QAReleaseDebugUpdate
    }
    numQarReleaseUpdateFuncs=#qarReleaseUpdateFuncs
  end
end
function this.OnEnterMissionPrepare()
  TppScriptBlock.PreloadSettingOnMissionStart()
  TppScriptBlock.ReloadScriptBlock()
end
function this.OnTextureLoadingWaitStart()
  StageBlockCurrentPositionSetter.SetEnable(false)
  gvars.canExceptionHandling=true
end
function this.OnMissionStartSaving()
end
function this.OnMissionCanStart()
  TppWeather.SetDefaultWeatherProbabilities()
  TppWeather.SetDefaultWeatherDurations()
  if TppMission.IsMissionStart()then
  end
  SsdCreatureBlock.InitializeLoad()
  TppLocation.ActivateBlock()
  TppWeather.OnMissionCanStart()
  TppMarker.OnMissionCanStart()
  TppResult.OnMissionCanStart()
  TppQuest.InitializeQuestLoad()
  TppRatBird.OnMissionCanStart()
  TppMission.OnMissionStart()
  SsdFlagMission.InitializeMissionLoad()
  TppPlayer.OnMissionCanStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  if(Tpp.IsQARelease()or nil)then
    if TPP_FOCUS_TEST_BUILD or TPP_ENABLE_PLAY_LOG_START then
      TppDebug.SetPlayLogEnabled(true)
    end
  end
  TppOutOfMissionRangeEffect.Disable(0)
  if TppLocation.IsMiddleAfrica()then
    TppGimmick.MafrRiverPrimSetting()
  end
  InfMain.OnMissionCanStartBottom()--tex
end
function this.OnMissionGameStart(n)
  if gvars.sav_needCheckPointSaveOnMissionStart then
    TppMission.VarSaveOnUpdateCheckPoint()
    gvars.sav_needCheckPointSaveOnMissionStart=false
  else
    TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_START)
  end
  TppClock.Start()
  if not gvars.ini_isTitleMode then
    PlayRecord.RegistPlayRecord"MISSION_START"
  end
  TppQuest.InitializeQuestActiveStatus()
  SsdFlagMission.InitializeActiveStatus()
  SsdBaseDefense.InitializeActiveStatus()
  if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    this.EnableGameStatusForDemo()
  else
    this.EnableGameStatus()
  end
  if Player.RequestChickenHeadSound~=nil then
    Player.RequestChickenHeadSound()
  end
  TppTerminal.OnMissionGameStart()
  if TppSequence.IsLandContinue()then
    TppMission.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  end
  TppUI.SetCoopFullUiLockType()
  TppSoundDaemon.ResetMute"Telop"
end
function this.ClearStageBlockMessage()
  StageBlock.ClearLargeBlockNameForMessage()
  StageBlock.ClearSmallBlockIndexForMessage()
end
function this.ReservePlayerLoadingPosition(missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
  this.DisableGameStatus()
  if missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if isFreeMission then
      TppPlayer.ResetInitialPosition()
      TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromFreePlay()
      if nextIsHeliSpace then
        TppPlayer.ResetMissionStartPosition()
      elseif isLocationChange then
        TppPlayer.SetMissionStartPositionToBaseFastTravelPoint()
      else
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
    else
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      if isHeliSpace then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppMission.SetIsStartFromFreePlay()
      else
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
        TppMission.ResetIsStartFromFreePlay()
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppMission.ResetIsStartFromFreePlay()
    if nextIsFreeMission then
      if isFreeMission then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        if nextIsHeliSpace then
          TppPlayer.ResetMissionStartPosition()
        else
          TppPlayer.SetMissionStartPositionToCurrentPosition()
        end
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif vars.missionCode~=TppDefine.SYS_MISSION_ID.TITLE then
      end
    else
      if isFreeMission then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=TppDefine.SYS_MISSION_ID.TITLE then
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if abortWithSave then
    Mission.AddLocationFinalizer(function()this.StageBlockCurrentPosition()end)
  else
    this.StageBlockCurrentPosition()
  end
end
function this.StageBlockCurrentPosition(yieldTillEmpty)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
end
function this.OnReload(missionTable)
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnLoad)then
      module.OnLoad()
    end
    if IsTypeFunc(module.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(module.Messages())
    end
  end
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"
      TppClock.UnregisterClockMessage"ShiftChangeAtMorning"
      TppClock.UnregisterClockMessage"ShiftChangeAtMidNight"
      TppEnemy.RegisterRouteSet(missionTable.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for i,lib in ipairs(Tpp._requireList)do
    if _G[lib].OnReload then
      InfCore.LogFlow(lib..".OnReload")--tex DEBUG
      InfCore.PCallDebug(_G[lib].OnReload,missionTable)--tex PCall
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if missionTable.sequence then
    TppCheckPoint.RegisterCheckPointList(missionTable.sequence.checkPointList)
  end
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
end
function this.OnUpdate(missionTable)
  --ORPHAN: local e
  local moduleUpdateFuncs=moduleUpdateFuncs
  local missionScriptOnUpdateFuncs=missionScriptOnUpdateFuncs
  --ORPHAN: local debugUpdateFuncs=debugUpdateFuncs
  --tex
  if InfCore.debugOnUpdate then
    for i=1,numModuleUpdateFuncs do
      InfCore.PCallDebug(moduleUpdateFuncs[i])
    end
    for i=1,numOnUpdate do
      InfCore.PCallDebug(missionScriptOnUpdateFuncs[i])
    end
    UpdateScriptsInScriptBlocks()
    if(Tpp.IsQARelease()or nil)then
      for i=1,numQarReleaseUpdateFuncs do
        InfCore.PCallDebug(qarReleaseUpdateFuncs[i])
      end
    end
    --ORIG>
  else
    for i=1,numModuleUpdateFuncs do
      moduleUpdateFuncs[i]()
    end
    for i=1,numOnUpdate do
      missionScriptOnUpdateFuncs[i]()
    end
    UpdateScriptsInScriptBlocks()
    if(Tpp.IsQARelease()or nil)then
      for i=1,numQarReleaseUpdateFuncs do
        qarReleaseUpdateFuncs[i]()
      end
    end
  end
end
function this.OnChangeSVars(subScripts,varName,key)
  if(Tpp.IsQARelease()or nil)then
    if(TppDebug.DEBUG_SkipOnChangeSVarsLog[varName]==nil)then
    end
  end
  for i,lib in ipairs(Tpp._requireList)do
    if _G[lib].OnChangeSVars then
      InfCore.LogFlow(lib..".OnChangeSVars")--tex DEBUG
      InfCore.PCallDebug(_G[lib].OnChangeSVars,varName,key)--tex PCALL
    end
  end
end
function this.SetMessageFunction(missionTable)--RENAME:
  onMessageTable={}
  onMessageTableSize=0
  messageExecTable={}
  messageExecTableSize=0
  for n,lib in ipairs(Tpp._requireList)do
    if _G[lib].OnMessage then
      onMessageTableSize=onMessageTableSize+1
      onMessageTable[onMessageTableSize]=_G[lib].OnMessage
    end
  end
  --tex>
  if not InfMain.IsOnlineMission(vars.missionCode)then
    for i,module in ipairs(InfModules)do
      if module.OnMessage then
        InfCore.LogFlow("SetMessageFunction:"..module.name)
        onMessageTableSize=onMessageTableSize+1
        onMessageTable[onMessageTableSize]=module.OnMessage
      end
    end
  end
  --<
  for n,lib in pairs(missionTable)do
    if missionTable[n]._messageExecTable then
      messageExecTableSize=messageExecTableSize+1
      messageExecTable[messageExecTableSize]=missionTable[n]._messageExecTable
    end
  end
end
--tex called via mission_main.OnMessage TODO: caller of that? probably engine
--sender and messageClass are actually str32 of the original messageexec creation definitions
--GOTCHA: sender is actuall the message class (Player,MotherBaseManagement,UI etc), not to be confused with the sender defined in the messageexec definitions.
--args are lua type number, but may represent enum,int,float, StrCode32, whatever.
--arg0 may match sender (not messageClass) in messageexec definition (see Tpp.DoMessage)
function this.OnMessage(missionTable,sender,messageId,arg0,arg1,arg2,arg3)
  --tex>
  if InfCore.debugMode and Ivars.debugMessages:Is(1) then
    if InfLookup then
      InfCore.PCall(InfLookup.PrintOnMessage,sender,messageId,arg0,arg1,arg2,arg3)
    end
  end
  --<
  local mvars=mvars--LOCALOPT
  local strLogTextEmpty=""
  --ORPHAN local T
  local DoMessage=Tpp.DoMessage--LOCALOPT
  local CheckMessageOption=TppMission.CheckMessageOption--LOCALOPT
  local TppDebug=TppDebug
  --ORPHAN local T=TppDebug
  --ORPHAN local T=unkM3
  --ORPHAN local T=unkM4
  local resendCount=TppDefine.MESSAGE_GENERATION[sender]and TppDefine.MESSAGE_GENERATION[sender][messageId]
  if not resendCount then
    resendCount=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local currentResendCount=GetCurrentMessageResendCount()
  if currentResendCount<resendCount then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for i=1,onMessageTableSize do
    local strLogText=strLogTextEmpty
    onMessageTable[i](sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  end
  for i=1,messageExecTableSize do
    local s=strLogTextEmpty
    DoMessage(messageExecTable[i],CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,s)
  end
  SsdFlagMission.OnSubScriptMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)
  end
  if mvars.order_box_script then
    mvars.order_box_script.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)
  end
  if TppAnimalBlock.OnMessage then
    TppAnimalBlock.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)
  end
end
function this.OnTerminate(missionTable)
  if missionTable.sequence then
    if IsTypeFunc(missionTable.sequence.OnTerminate)then
      missionTable.sequence.OnTerminate()
    end
  end
  Mission.ResetVarsList()
end
return this
