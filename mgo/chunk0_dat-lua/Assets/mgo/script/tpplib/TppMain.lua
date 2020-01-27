-- TppMain.lua
local this={}
local l=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local i=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local M=TppScriptVars.IsSavingOrLoading
local P=ScriptBlock.UpdateScriptsInScriptBlocks
local f=Mission.GetCurrentMessageResendCount
local moduleUpdateFuncs={}
local numModuleUpdateFuncs=0
local missionScriptOnUpdateFuncs={}
local numOnUpdate=0
local RENAMEsomeupdatetable2={}
local RENAMEsomeupdate2=0
local n={}
local n=0
local onMessageTable={}
local m={}
local onMessageTableSize=0
local messageExecTable={}
local h={}
local messageExecTableSize=0
local function n()
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()coroutine.yield()
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
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
end
function this.EnableGameStatusForDemo()
  TppDemo.ReserveEnableInGameFlag()
  Tpp.SetGameStatus{target={S_DISABLE_PLAYER_PAD=true,S_DISABLE_TARGET=true,S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppMain.lua"}
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
  TppPause.RegisterPause"TppMain.lua"end
function this.DisablePause()
  TppPause.UnregisterPause"TppMain.lua"end
function this.EnableBlackLoading(e)
  TppGameStatus.Set("TppMain.lua","S_IS_BLACK_LOADING")
  if e then
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
  TppClock.Stop()moduleUpdateFuncs={}numModuleUpdateFuncs=0
  RENAMEsomeupdatetable2={}RENAMEsomeupdate2=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil)
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFOBMissionFlag()
    TppGameStatus.Set("Mission","S_IS_ONLINE")
  else
    TppGameStatus.Reset("Mission","S_IS_ONLINE")
  end
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(missionTable)
  TppClock.OnAllocate(missionTable)
  TppTrap.OnAllocate(missionTable)
  TppCheckPoint.OnAllocate(missionTable)
  TppUI.OnAllocate(missionTable)
  TppDemo.OnAllocate(missionTable)
  TppScriptBlock.OnAllocate(missionTable)
  TppSound.OnAllocate(missionTable)
  TppPlayer.OnAllocate(missionTable)
  TppMission.OnAllocate(missionTable)
  TppTerminal.OnAllocate(missionTable)
  TppEnemy.OnAllocate(missionTable)
  TppRadio.OnAllocate(missionTable)
  TppGimmick.OnAllocate(missionTable)
  TppMarker.OnAllocate(missionTable)
  TppRevenge.OnAllocate(missionTable)
  this.ClearStageBlockMessage()
  TppQuest.OnAllocate(missionTable)
  TppAnimal.OnAllocate(missionTable)
  InfMain.OnAllocate(missionTable)--tex
  local function o()
    if TppLocation.IsAfghan()then
      if afgh then
        afgh.OnAllocate()
      end
    elseif TppLocation.IsMiddleAfrica()then
      if mafr then
        mafr.OnAllocate()
      end
    elseif TppLocation.IsCyprus()then
      if cypr then
        cypr.OnAllocate()
      end
    elseif TppLocation.IsMotherBase()then
      if mtbs then
        mtbs.OnAllocate()
      end
    end
  end
  o()
  if missionTable.sequence then
    if i(missionTable.sequence.MissionPrepare)then
      missionTable.sequence.MissionPrepare()
    end
    if i(missionTable.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(missionTable.sequence.OnEndMissionPrepareSequence)
    end
  end
  for n,e in pairs(missionTable)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
  end
  do
    local o={}
    for t,e in ipairs(Tpp._requireList)do
      if _G[e]then
        if _G[e].DeclareSVars then
          l(o,_G[e].DeclareSVars(missionTable))
        end
      end
    end
    local s={}
    for n,e in pairs(missionTable)do
      if i(e.DeclareSVars)then
        l(s,e.DeclareSVars())
      end
      if t(e.saveVarsList)then
        l(s,TppSequence.MakeSVarsTable(e.saveVarsList))
      end
    end
    l(o,s)
    TppScriptVars.DeclareSVars(o)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while M()do
      coroutine.yield()
    end
    TppRadioCommand.SetScriptDeclVars()
    local i=vars.mbLayoutCode
    if gvars.ini_isTitleMode then
      TppPlayer.MissionStartPlayerTypeSetting()
    else
      if TppMission.IsMissionStart()then
        TppVarInit.InitializeForNewMission(missionTable)
        TppPlayer.MissionStartPlayerTypeSetting()
        if not TppMission.IsFOBMission(vars.missionCode)then
          TppSave.VarSave(vars.missionCode,true)
        end
      else
        TppVarInit.InitializeForContinue(missionTable)
      end
      TppVarInit.ClearIsContinueFromTitle()
    end
    TppStory.SetMissionClearedS10030()
    TppTerminal.StartSyncMbManagementOnMissionStart()
    if TppLocation.IsMotherBase()then
      if i~=vars.mbLayoutCode then
        if vars.missionCode==30050 then
          vars.mbLayoutCode=i
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    this.StageBlockCurrentPosition(true)
    TppMission.SetSortieBuddy()
    TppStory.UpdateStorySequence{updateTiming="BeforeBuddyBlockLoad"}
    if missionTable.sequence then
      local e=missionTable.sequence.DISABLE_BUDDY_TYPE
      if e then
        local n
        if t(e)then
          n=e
        else
          n={e}
        end
        for n,e in ipairs(n)do
          TppBuddyService.SetDisableBuddyType(e)
        end
      end
    end
    if(vars.missionCode==11043)or(vars.missionCode==11044)then
      TppBuddyService.SetDisableAllBuddy()
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
    if t(missionTable.enemy.soldierPowerSettings)then
      TppEnemy.SetUpPowerSettings(missionTable.enemy.soldierPowerSettings)
    end
  end
  TppRevenge.DecideRevenge(missionTable)
  if TppEquip.CreateEquipMissionBlockGroup then
    if(vars.missionCode>6e4)then
      TppEquip.CreateEquipMissionBlockGroup{size=(380*1024)*24}
    else
      TppPlayer.SetEquipMissionBlockGroupSize()
    end
  end
  if TppEquip.CreateEquipGhostBlockGroups then
    if TppSystemUtility.GetCurrentGameMode()=="MGO"then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=16}
    elseif TppMission.IsFOBMission(vars.missionCode)then
      TppEquip.CreateEquipGhostBlockGroups{ghostCount=1}
    end
  end
  TppEquip.StartLoadingToEquipMissionBlock()
  TppPlayer.SetMaxPickableLocatorCount()
  TppPlayer.SetMaxPlacedLocatorCount()
  TppEquip.AllocInstances{instance=60,realize=60}
  TppEquip.ActivateEquipSystem()
  if TppEnemy.IsRequiredToLoadDefaultSoldier2CommonPackage()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if missionTable.sequence then
    mvars.mis_baseList=missionTable.sequence.baseList
    TppCheckPoint.RegisterCheckPointList(missionTable.sequence.checkPointList)
  end
  InfCore.LogFlow("OnAllocate Bottom "..vars.missionCode)--tex
end
function this.OnInitialize(missionTable)
  InfCore.LogFlow("OnInitialize Top "..vars.missionCode)--tex
  InfMain.OnInitializeTop(missionTable)--tex
  if TppMission.IsFOBMission(vars.missionCode)then
    TppMission.SetFobPlayerStartPoint()
  elseif TppMission.IsNeedSetMissionStartPositionToClusterPosition()then
    TppMission.SetMissionStartPositionMtbsClusterPosition()
    this.StageBlockCurrentPosition(true)
  else
    TppCheckPoint.SetCheckPointPosition()
  end
  if TppEnemy.IsRequiredToLoadSpecialSolider2CommonBlock()then
    TppEnemy.LoadSoldier2CommonBlock()
  end
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  TppAnimalBlock.InitializeBlockStatus()
  if TppQuestList then
    TppQuest.RegisterQuestList(TppQuestList.questList)
    TppQuest.RegisterQuestPackList(TppQuestList.questPackList)
  end
  TppHelicopter.AdjustBuddyDropPoint()
  if missionTable.sequence then
    local e=missionTable.sequence.NPC_ENTRY_POINT_SETTING
    if t(e)then
      TppEnemy.NPCEntryPointSetting(e)
    end
  end
  TppLandingZone.OverwriteBuddyVehiclePosForALZ()
  if missionTable.enemy then
    if t(missionTable.enemy.vehicleSettings)then
      TppEnemy.SetUpVehicles()
    end
    if i(missionTable.enemy.SpawnVehicleOnInitialize)then
      missionTable.enemy.SpawnVehicleOnInitialize()
    end
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for t,e in pairs(missionTable)do
    if i(e.Messages)then
      missionTable[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  TppLandingZone.OnInitialize()
  for t,e in ipairs(Tpp._requireList)do
    if _G[e].Init then
      _G[e].Init(missionTable)
    end
  end
  if missionTable.enemy then
    if GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
      GameObject.SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})
    end
    if t(missionTable.enemy.soldierDefine)then
      TppEnemy.DefineSoldiers(missionTable.enemy.soldierDefine)
    end
    if missionTable.enemy.InitEnemy and i(missionTable.enemy.InitEnemy)then
      missionTable.enemy.InitEnemy()
    end
    if t(missionTable.enemy.soldierPersonalAbilitySettings)then
      TppEnemy.SetUpPersonalAbilitySettings(missionTable.enemy.soldierPersonalAbilitySettings)
    end
    if t(missionTable.enemy.travelPlans)then
      TppEnemy.SetTravelPlans(missionTable.enemy.travelPlans)
    end
    TppEnemy.SetUpSoldiers()
    if t(missionTable.enemy.soldierDefine)then
      TppEnemy.InitCpGroups()
      TppEnemy.RegistCpGroups(missionTable.enemy.cpGroups)
      TppEnemy.SetCpGroups()
      if mvars.loc_locationGimmickCpConnectTable then
        TppGimmick.SetCommunicateGimmick(mvars.loc_locationGimmickCpConnectTable)
      end
    end
    if t(missionTable.enemy.interrogation)then
      TppInterrogation.InitInterrogation(missionTable.enemy.interrogation)
    end
    if t(missionTable.enemy.useGeneInter)then
      TppInterrogation.AddGeneInter(missionTable.enemy.useGeneInter)
    end
    if t(missionTable.enemy.uniqueInterrogation)then
      TppInterrogation.InitUniqueInterrogation(missionTable.enemy.uniqueInterrogation)
    end
    do
      local e
      if t(missionTable.enemy.routeSets)then
        e=missionTable.enemy.routeSets
        for e,n in pairs(e)do
          if not t(mvars.ene_soldierDefine[e])then
          end
        end
      end
      if e then
        TppEnemy.RegisterRouteSet(e)
        TppEnemy.MakeShiftChangeTable()
        TppEnemy.SetUpCommandPost()
        TppEnemy.SetUpSwitchRouteFunc()
      end
    end
    if missionTable.enemy.soldierSubTypes then
      TppEnemy.SetUpSoldierSubTypes(missionTable.enemy.soldierSubTypes)
    end
    TppRevenge.SetUpEnemy()
    TppEnemy.ApplyPowerSettingsOnInitialize()
    TppEnemy.ApplyPersonalAbilitySettingsOnInitialize()
    TppEnemy.SetOccasionalChatList()
    TppEneFova.ApplyUniqueSetting()
    if missionTable.enemy.SetUpEnemy and i(missionTable.enemy.SetUpEnemy)then
      missionTable.enemy.SetUpEnemy()
    end
    if TppMission.IsMissionStart()then
      TppEnemy.RestoreOnMissionStart2()
    else
      TppEnemy.RestoreOnContinueFromCheckPoint2()
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
    TppMarker.RestoreMarkerLocator()
  end
  TppPlayer.RestoreSupplyCbox()
  TppPlayer.RestoreSupportAttack()
  TppTerminal.MakeMessage()
  if missionTable.sequence then
    local e=missionTable.sequence.SetUpRoutes
    if e and i(e)then
      e()
    end
    TppEnemy.RegisterRouteAnimation()
    local e=missionTable.sequence.SetUpLocation
    if e and i(e)then
      e()
    end
  end
  for n,e in pairs(missionTable)do
    if e.OnRestoreSVars then
      e.OnRestoreSVars()
    end
  end
  TppMission.RestoreShowMissionObjective()
  TppRevenge.SetUpRevengeMine()
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
  TppMission.PostMissionOrderBoxPositionToBuddyDog()
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
  TppQuest.UpdateActiveQuest()
  TppDevelopFile.OnMissionCanStart()
  if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    if TppQuest.IsActiveQuestHeli()then
      TppEnemy.ReserveQuestHeli()
    end
  end
  InfMain.OnInitializeBottom(missionTable)--tex
  InfCore.LogFlow("OnInitialize Bottom "..vars.missionCode)--tex
end
function this.SetUpdateFunction(missionTable)
  moduleUpdateFuncs={}
  numModuleUpdateFuncs=0
  missionScriptOnUpdateFuncs={}
  numOnUpdate=0
  RENAMEsomeupdatetable2={}
  RENAMEsomeupdate2=0
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
    if i(module.OnUpdate)then
      numOnUpdate=numOnUpdate+1
      missionScriptOnUpdateFuncs[numOnUpdate]=module.OnUpdate
    end
  end
end
function this.OnEnterMissionPrepare()
end
function this.OnTextureLoadingWaitStart()
  if not TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  gvars.canExceptionHandling=true
end
function this.OnMissionStartSaving()
end
function this.OnMissionCanStart()
  if TppMission.IsMissionStart()then
    TppWeather.SetDefaultWeatherProbabilities()
    TppWeather.SetDefaultWeatherDurations()
    if(not gvars.ini_isTitleMode)and(not TppMission.IsFOBMission(vars.missionCode))then
      TppSave.VarSave(nil,true)
    end
  end
  TppWeather.OnMissionCanStart()
  TppMission.OnMissionStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  TppOutOfMissionRangeEffect.Disable(0)
  if MotherBaseConstructConnector.RefreshGimmicks then
    if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
      MotherBaseConstructConnector.RefreshGimmicks()
    end
  end
  InfMain.OnMissionCanStartBottom()--tex
end
function this.OnMissionGameStart(n)
  TppClock.Start()
  if not gvars.ini_isTitleMode then
    PlayRecord.RegistPlayRecord"MISSION_START"end
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
  TppSoundDaemon.ResetMute"Telop"end
function this.ClearStageBlockMessage()StageBlock.ClearLargeBlockNameForMessage()StageBlock.ClearSmallBlockIndexForMessage()
end
function this.ReservePlayerLoadingPosition(n,o,s,t,i,p,a)
  this.DisableGameStatus()
  if n==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if t then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif o then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
        if mvars.mis_helicopterMissionStartPosition then
          TppPlayer.SetInitialPosition(mvars.mis_helicopterMissionStartPosition,0)
          TppPlayer.SetMissionStartPosition(mvars.mis_helicopterMissionStartPosition,0)
        end
      else
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        local e=TppDefine.NO_HELICOPTER_MISSION_START_POSITION[vars.missionCode]
        if e then
          TppPlayer.SetInitialPosition(e,0)
          TppPlayer.SetMissionStartPosition(e,0)
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
        end
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif i then
      if TppLocation.IsMotherBase()then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppPlayer.SetMissionStartPositionToCurrentPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
      TppLocation.MbFreeSpecialMissionStartSetting(TppMission.GetMissionClearType())
    elseif(s and TppLocation.IsMotherBase())then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    else
      if s then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
          TppPlayer.ResetNoOrderBoxMissionStartPosition()
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]then
            TppPlayer.SetNoOrderBoxMissionStartPositionToCurrentPosition()
          else
            TppPlayer.ResetNoOrderBoxMissionStartPosition()
          end
        end
        local e=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[vars.missionCode]
        if e then
          TppPlayer.SetStartStatusRideOnHelicopter()
          TppMission.SetIsStartFromHelispace()
          TppMission.ResetIsStartFromFreePlay()
        else
          TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
          TppHelicopter.ResetMissionStartHelicopterRoute()
          TppMission.ResetIsStartFromHelispace()
          TppMission.SetIsStartFromFreePlay()
        end
        local e=TppMission.GetMissionClearType()
        TppQuest.SpecialMissionStartSetting(e)
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
        TppMission.ResetIsStartFromHelispace()
        TppMission.ResetIsStartFromFreePlay()
      end
    end
  elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if p then
      if i then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif t then
        TppPlayer.ResetMissionStartPosition()
      elseif vars.missionCode~=5 then
      end
    else
      if t then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif i then
        TppMission.SetMissionOrderBoxPosition()
      elseif vars.missionCode~=5 then
      end
    end
  elseif n==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif n==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  if o and a then
    Mission.AddLocationFinalizer(function()
      this.StageBlockCurrentPosition()
    end)
  else
    this.StageBlockCurrentPosition()
  end
end
function this.StageBlockCurrentPosition(e)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.DisablePosition()
    if e then
      while not StageBlock.LargeAndSmallBlocksAreEmpty()do
        coroutine.yield()
      end
    end
  end
end
function this.OnReload(missionTable)
  for t,e in pairs(missionTable)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
    if i(e.Messages)then
      missionTable[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if missionTable.enemy then
    if t(missionTable.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"
      TppClock.UnregisterClockMessage"ShiftChangeAtMorning"
      TppEnemy.RegisterRouteSet(missionTable.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for t,lib in ipairs(Tpp._requireList)do
    local OnReload=_G[lib].OnReload
    if OnReload then
      InfCore.LogFlow(lib..".OnReload")--tex DEBUG
      InfCore.PCallDebug(OnReload,missionTable)--tex PCall
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
  local e
  local e=moduleUpdateFuncs
  local n=missionScriptOnUpdateFuncs
  local t=RENAMEsomeupdatetable2
  for n=1,numModuleUpdateFuncs do
    e[n]()
  end
  for e=1,numOnUpdate do
    n[e]()
  end
  P()
end
function this.OnChangeSVars(e,t,n)
  for i,e in ipairs(Tpp._requireList)do
    if _G[e].OnChangeSVars then
      _G[e].OnChangeSVars(t,n)
    end
  end
end
function this.SetMessageFunction(missionTable)
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
  if not TppMission.IsFOBMission(vars.missionCode)then
    for i,module in ipairs(InfModules)do
      if module.OnMessage then
        InfCore.LogFlow("SetMessageFunction:"..module.name)
        onMessageTableSize=onMessageTableSize+1
        onMessageTable[onMessageTableSize]=module.OnMessage
      end
    end
  end
  --<
  for name,module in pairs(missionTable)do
    if missionTable[name]._messageExecTable then
      messageExecTableSize=messageExecTableSize+1
      messageExecTable[messageExecTableSize]=missionTable[name]._messageExecTable
    end
  end
end
function this.OnMessage(missionTable,sender,messageId,arg0,arg1,arg2,arg3)
  if Ivars.debugMessages:Is(1)then--tex>
    --DEBUGNOW InfCore.PCall(InfLookup.PrintOnMessage,sender,messageId,arg0,arg1,arg2,arg3)
  end--<
  local e=mvars
  local s=""
  local T
  local c=Tpp.DoMessage
  local u=TppMission.CheckMessageOption
  local T=TppDebug
  local T=m
  local T=h
  local T=TppDefine.MESSAGE_GENERATION[sender]and TppDefine.MESSAGE_GENERATION[sender][messageId]
  if not T then
    T=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local m=f()
  if m<T then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for e=1,onMessageTableSize do
    local o=s
    onMessageTable[e](sender,messageId,arg0,arg1,arg2,arg3,o)
  end
  for e=1,messageExecTableSize do
    local o=s
    c(messageExecTable[e],u,sender,messageId,arg0,arg1,arg2,arg3,o)
  end
  if e.loc_locationCommonTable then
    e.loc_locationCommonTable.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,s)
  end
  if e.order_box_script then
    e.order_box_script.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,s)
  end
  if e.animalBlockScript and e.animalBlockScript.OnMessage then
    e.animalBlockScript.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,s)
  end
end
function this.OnTerminate(e)
  if e.sequence then
    if i(e.sequence.OnTerminate)then
      e.sequence.OnTerminate()
    end
  end
end
return this
