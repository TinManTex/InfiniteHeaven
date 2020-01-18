-- DOBUILD: 1
local this={}

local ApendArray=Tpp.ApendArray
local n=Tpp.DEBUG_StrCode32ToString
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsSavingOrLoading=TppScriptVars.IsSavingOrLoading
local UpdateScriptsInScriptBlocks=ScriptBlock.UpdateScriptsInScriptBlocks
local GetCurrentMessageResendCount=Mission.GetCurrentMessageResendCount
local updateList={}
local numUpdate=0
local c={}
local o=0
local T={}
local u=0
local n={}
local n=0
local S={}
local P={}
local s=0
local d={}
local h={}
local p=0
local function n()--tex NMC: cant actually see this referenced anywhere
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
function this.OnAllocate(n)
  TppWeather.OnEndMissionPrepareFunction()
  this.DisableGameStatus()
  this.EnablePause()
  TppClock.Stop()
  updateList={}
  numUpdate=0
  T={}
  u=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil)
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  if TppMission.IsFOBMission(vars.missionCode)then
    InfMenu.ResetSettings()--tex reset settings on FOB
    TppMission.SetFOBMissionFlag()
    TppGameStatus.Set("Mission","S_IS_ONLINE")
  else
    TppGameStatus.Reset("Mission","S_IS_ONLINE")
  end
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(n)
  TppClock.OnAllocate(n)
  TppTrap.OnAllocate(n)
  TppCheckPoint.OnAllocate(n)
  TppUI.OnAllocate(n)
  TppDemo.OnAllocate(n)
  TppScriptBlock.OnAllocate(n)
  TppSound.OnAllocate(n)
  TppPlayer.OnAllocate(n)
  TppMission.OnAllocate(n)
  TppTerminal.OnAllocate(n)
  TppEnemy.OnAllocate(n)
  TppRadio.OnAllocate(n)
  TppGimmick.OnAllocate(n)
  TppMarker.OnAllocate(n)
  TppRevenge.OnAllocate(n)
  this.ClearStageBlockMessage()
  TppQuest.OnAllocate(n)
  TppAnimal.OnAllocate(n)
  local function s()
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
  s()
  if n.sequence then
    if f30050_sequence then--
      function f30050_sequence.NeedPlayQuietWishGoMission()--RETAILPATCH: 1.0.4.1 PATCHUP: in general I understand the need for patch ups, and in cases like this i even admire the method, however the implementation of just shoving them seemingly anywhere... needs better execution.
        local isClearedSideOps=TppQuest.IsCleard"mtbs_q99011"
        local isNotPlayDemo=not TppDemo.IsPlayedMBEventDemo"QuietWishGoMission"
        local isCanArrival=TppDemo.GetMBDemoName()==nil
        return(isClearedSideOps and isNotPlayDemo)and isCanArrival
      end
    end
    if IsTypeFunc(n.sequence.MissionPrepare)then
      n.sequence.MissionPrepare()
    end
    if IsTypeFunc(n.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(n.sequence.OnEndMissionPrepareSequence)
    end
  end
  for n,e in pairs(n)do
    if IsTypeFunc(e.OnLoad)then
      e.OnLoad()
    end
  end
  do
    local o={}
    for t,e in ipairs(Tpp._requireList)do
      if _G[e]then
        if _G[e].DeclareSVars then
          ApendArray(o,_G[e].DeclareSVars(n))
        end
      end
    end
    local s={}
    for n,e in pairs(n)do
      if IsTypeFunc(e.DeclareSVars)then
        ApendArray(s,e.DeclareSVars())
      end
      if IsTypeTable(e.saveVarsList)then
        ApendArray(s,TppSequence.MakeSVarsTable(e.saveVarsList))
      end
    end
    ApendArray(o,s)
    TppScriptVars.DeclareSVars(o)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while IsSavingOrLoading()do
      coroutine.yield()
    end
    TppRadioCommand.SetScriptDeclVars()
    local layoutCode=vars.mbLayoutCode
    if gvars.ini_isTitleMode then
      TppPlayer.MissionStartPlayerTypeSetting()
    else
      if TppMission.IsMissionStart()then
        TppVarInit.InitializeForNewMission(n)
        TppPlayer.MissionStartPlayerTypeSetting()
        if not TppMission.IsFOBMission(vars.missionCode)then
          TppSave.VarSave(vars.missionCode,true)
        end
      else
        TppVarInit.InitializeForContinue(n)
      end
      TppVarInit.ClearIsContinueFromTitle()
    end
    --TppUiCommand.ExcludeNonPermissionContents()--RETAILPATCH: 1.0.4.1 --tex trying to lock down dlc mods?
    TppStory.SetMissionClearedS10030()
    TppTerminal.StartSyncMbManagementOnMissionStart()
    if TppLocation.IsMotherBase()then
      if layoutCode~=vars.mbLayoutCode then
        if vars.missionCode==30050 then
          vars.mbLayoutCode=layoutCode
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    this.StageBlockCurrentPosition(true)
    TppMission.SetSortieBuddy()
    TppStory.UpdateStorySequence{updateTiming="BeforeBuddyBlockLoad"}
    if n.sequence then
      local dbt=n.sequence.DISABLE_BUDDY_TYPE
      --if InfMain.IsMbPlayTime() then--tex no DISABLE_BUDDY_TYPE
     --   dbt=nil
      --end--
      if dbt ~= nil then
        local disableBuddyType
        if IsTypeTable(dbt)then
          disableBuddyType=dbt
        else
          disableBuddyType={dbt}
        end
        for n,buddyType in ipairs(disableBuddyType)do
          TppBuddyService.SetDisableBuddyType(buddyType)
        end
      end
    end
    --if(vars.missionCode==11043)or(vars.missionCode==11044)then--tex ORIG: changed to issubs check, more robust even without my mod
    if TppMission.IsSubsistenceMission() and gvars.isManualSubsistence~=InfMain.SETTING_SUBSISTENCE_PROFILE.BOUNDER then--tex disable
      TppBuddyService.SetDisableAllBuddy()
    end
    if TppGameSequence.GetGameTitleName()=="TPP"then
      if n.sequence and n.sequence.OnBuddyBlockLoad then
        n.sequence.OnBuddyBlockLoad()
      end
      if TppLocation.IsAfghan()or TppLocation.IsMiddleAfrica()then
        TppBuddy2BlockController.Load()
      end
    end
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
  if gvars.enemyParameters==1 then--tex use tweaked soldier parameters
  --tex REF: this.lifeParameterTableDefault={maxLife=2600,maxStamina=3e3,maxLimbLife=1500,maxArmorLife=7500,maxHelmetLife=500,sleepRecoverSec=300,faintRecoverSec=50,dyingSec=60}
    local healthMult=gvars.enemyHealthMult--tex mod enemy health scale
    InfEnemyParams.lifeParameterTableMod.maxLife = TppMath.ScaleValueClamp1(InfEnemyParams.lifeParameterTableDefault.maxLife,healthMult)
    InfEnemyParams.lifeParameterTableMod.maxLimbLife = TppMath.ScaleValueClamp1(InfEnemyParams.lifeParameterTableDefault.maxLimbLife,healthMult)
    InfEnemyParams.lifeParameterTableMod.maxArmorLife = TppMath.ScaleValueClamp1(InfEnemyParams.lifeParameterTableDefault.maxArmorLife,healthMult)
    InfEnemyParams.lifeParameterTableMod.maxHelmetLife = TppMath.ScaleValueClamp1(InfEnemyParams.lifeParameterTableDefault.maxHelmetLife,healthMult)
    TppSoldier2.ReloadSoldier2ParameterTables(InfEnemyParams.soldierParametersMod)--tex reloadsoldierparams changes
  end--
  if n.enemy then
    if IsTypeTable(n.enemy.soldierPowerSettings)then
      TppEnemy.SetUpPowerSettings(n.enemy.soldierPowerSettings)
    end
  end
  TppRevenge.DecideRevenge(n)
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
    elseif TppMission.IsFOBMission(vars.missionCode)or InfMain.IsMbPlayTime() then--tex I dont actually know what this is lol
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
  if n.sequence then
    mvars.mis_baseList=n.sequence.baseList
    TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)
  end
end
function this.OnInitialize(missionTable)
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
    if IsTypeTable(e)then
      TppEnemy.NPCEntryPointSetting(e)
    end
  end
  TppLandingZone.OverwriteBuddyVehiclePosForALZ()
  if missionTable.enemy then
    if IsTypeTable(missionTable.enemy.vehicleSettings)then
      TppEnemy.SetUpVehicles()
    end
    if IsTypeFunc(missionTable.enemy.SpawnVehicleOnInitialize)then
      missionTable.enemy.SpawnVehicleOnInitialize()
    end
    TppReinforceBlock.SetUpReinforceBlock()
  end
  for t,e in pairs(missionTable)do
    if IsTypeFunc(e.Messages)then
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
  if TppMission.IsManualSubsistence() then--tex disable heli be fightan
    local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId ~= nil and gameObjectId ~= GameObject.NULL_ID then
      GameObject.SendCommand(gameObjectId, { id="SetCombatEnabled", enabled=false }) 
    end 
  end--
  if missionTable.enemy then
    if GameObject.DoesGameObjectExistWithTypeName"TppSoldier2"then
      GameObject.SendCommand({type="TppSoldier2"},{id="CreateFaceIdList"})
    end
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
    if IsTypeTable(missionTable.enemy.interrogation)then
      TppInterrogation.InitInterrogation(missionTable.enemy.interrogation)
    end
    if IsTypeTable(missionTable.enemy.useGeneInter)then
      TppInterrogation.AddGeneInter(missionTable.enemy.useGeneInter)
    end
    if IsTypeTable(missionTable.enemy.uniqueInterrogation)then
      TppInterrogation.InitUniqueInterrogation(missionTable.enemy.uniqueInterrogation)
    end
    do
      local e
      if IsTypeTable(missionTable.enemy.routeSets)then
        e=missionTable.enemy.routeSets
        for e,n in pairs(e)do
          if not IsTypeTable(mvars.ene_soldierDefine[e])then
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
    if missionTable.enemy.SetUpEnemy and IsTypeFunc(missionTable.enemy.SetUpEnemy)then
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
    if e and IsTypeFunc(e)then
      e()
    end
    TppEnemy.RegisterRouteAnimation()
    local e=missionTable.sequence.SetUpLocation
    if e and IsTypeFunc(e)then
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
  TppDemo.UpdateNuclearAbolitionFlag()
  TppQuest.AcquireKeyItemOnMissionStart()
end
function this.SetUpdateFunction(e)
  updateList={}
  numUpdate=0
  c={}
  o=0
  T={}
  u=0
  updateList={TppMission.Update,TppSequence.Update,TppSave.Update,TppDemo.Update,TppPlayer.Update,TppMission.UpdateForMissionLoad,InfMenu.UpdateModMenu}--tex added infmenu
  numUpdate=#updateList
  for n,e in pairs(e)do
    if IsTypeFunc(e.OnUpdate)then
      o=o+1
      c[o]=e.OnUpdate
    end
  end
end
function this.OnEnterMissionPrepare()
  if TppMission.IsMissionStart()then
    TppScriptBlock.PreloadSettingOnMissionStart()
  end
  TppScriptBlock.ReloadScriptBlock()
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
  TppLocation.ActivateBlock()
  TppWeather.OnMissionCanStart()
  TppMarker.OnMissionCanStart()
  TppResult.OnMissionCanStart()
  TppQuest.InitializeQuestLoad()
  TppRatBird.OnMissionCanStart()
  TppMission.OnMissionStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  TppLandingZone.OnMissionCanStart()
  TppOutOfMissionRangeEffect.Disable(0)
  if TppLocation.IsMiddleAfrica()then
    TppGimmick.MafrRiverPrimSetting()
  end
  if MotherBaseConstructConnector.RefreshGimmicks then
    if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
      MotherBaseConstructConnector.RefreshGimmicks()
    end
  end
  if vars.missionCode==10240 and TppLocation.IsMBQF()then
    Player.AttachGasMask()
  end
  if(vars.missionCode==10150)then
    local e=TppSequence.GetMissionStartSequenceIndex()
    if(e~=nil)and(e<TppSequence.GetSequenceIndex"Seq_Game_SkullFaceToPlant")then
      if(svars.mis_objectiveEnable[17]==false)then
        Gimmick.ForceResetOfRadioCassetteWithCassette()
      end
    end
  end
end
function this.OnMissionGameStart(n)
  TppClock.Start()
  if not gvars.ini_isTitleMode then
    PlayRecord.RegistPlayRecord"MISSION_START"end
  TppQuest.InitializeQuestActiveStatus()
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
function this.ReservePlayerLoadingPosition(n,s,o,t,i,a,p)
  this.DisableGameStatus()
  if n==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if t then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif s then
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
    elseif(o and TppLocation.IsMotherBase())then
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
      if o then
        if mvars.mis_orderBoxName then
          TppMission.SetMissionOrderBoxPosition()
          TppPlayer.ResetNoOrderBoxMissionStartPosition()
        else
          TppPlayer.ResetInitialPosition()
          TppPlayer.ResetMissionStartPosition()
          local e={
          [10020]={1449.3460693359,339.18698120117,1467.4300537109,-104},
          [10050]={-1820.7060546875,349.78659057617,-146.44400024414,139},
          [10070]={-792.00512695313,537.3740234375,-1381.4598388672,136},
          [10080]={-439.28802490234,-20.472593307495,1336.2784423828,-151},
          [10140]={499.91635131836,13.07358455658,1135.1315917969,79},
          [10150]={-1732.0286865234,543.94067382813,-2225.7587890625,162},
          [10260]={-1260.0454101563,298.75305175781,1325.6383056641,51}
          }
          e[11050]=e[10050]
          e[11080]=e[10080]
          e[11140]=e[10140]
          e[10151]=e[10150]
          e[11151]=e[10150]
          local e=e[vars.missionCode]
          if TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(vars.missionCode)]and e then
            TppPlayer.SetNoOrderBoxMissionStartPosition(e,e[4])
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
    if a then
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
  if s and p then
    Mission.AddLocationFinalizer(function()
      this.StageBlockCurrentPosition()
    end)
  else
    this.StageBlockCurrentPosition()
  end
end
function this.StageBlockCurrentPosition(e)
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  else
    StageBlockCurrentPositionSetter.SetEnable(false)
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    StageBlockCurrentPositionSetter.SetEnable(true)StageBlockCurrentPositionSetter.DisablePosition()
    if e then
      while not StageBlock.LargeAndSmallBlocksAreEmpty()do
        coroutine.yield()
      end
    end
  end
end
function this.OnReload(n)
  for t,e in pairs(n)do
    if IsTypeFunc(e.OnLoad)then
      e.OnLoad()
    end
    if IsTypeFunc(e.Messages)then
      n[t]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if n.enemy then
    if IsTypeTable(n.enemy.routeSets)then
      TppClock.UnregisterClockMessage"ShiftChangeAtNight"TppClock.UnregisterClockMessage"ShiftChangeAtMorning"TppEnemy.RegisterRouteSet(n.enemy.routeSets)
      TppEnemy.MakeShiftChangeTable()
    end
  end
  for t,e in ipairs(Tpp._requireList)do
    if _G[e].OnReload then
      _G[e].OnReload(n)
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if n.sequence then
    TppCheckPoint.RegisterCheckPointList(n.sequence.checkPointList)
  end
  this.SetUpdateFunction(n)
  this.SetMessageFunction(n)
end
function this.OnUpdate(e)
  local e
  local update=updateList
  local e=c
  local t=T
  for e=1,numUpdate do
    update[e]()
  end
  for n=1,o do
    e[n]()
  end
  UpdateScriptsInScriptBlocks()
end
function this.OnChangeSVars(e,n,t)
  for i,e in ipairs(Tpp._requireList)do
    if _G[e].OnChangeSVars then
      _G[e].OnChangeSVars(n,t)
    end
  end
end
function this.SetMessageFunction(e)
  S={}
  s=0
  d={}
  p=0
  for n,e in ipairs(Tpp._requireList)do
    if _G[e].OnMessage then
      s=s+1
      S[s]=_G[e].OnMessage
    end
  end
  for n,t in pairs(e)do
    if e[n]._messageExecTable then
      p=p+1
      d[p]=e[n]._messageExecTable
    end
  end
end
function this.OnMessage(n,e,t,i,o,a,r)
  local n=mvars
  local l=""
  local T
  local c=Tpp.DoMessage
  local u=TppMission.CheckMessageOption
  local T=TppDebug
  local T=P
  local T=h
  local T=TppDefine.MESSAGE_GENERATION[e]and TppDefine.MESSAGE_GENERATION[e][t]
  if not T then
    T=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local m=GetCurrentMessageResendCount()
  if m<T then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for s=1,s do
    local n=l
    S[s](e,t,i,o,a,r,n)
  end
  for n=1,p do
    local s=l
    c(d[n],u,e,t,i,o,a,r,s)
  end
  if n.loc_locationCommonTable then
    n.loc_locationCommonTable.OnMessage(e,t,i,o,a,r,l)
  end
  if n.order_box_script then
    n.order_box_script.OnMessage(e,t,i,o,a,r,l)
  end
  if n.animalBlockScript and n.animalBlockScript.OnMessage then
    n.animalBlockScript.OnMessage(e,t,i,o,a,r,l)
  end
end
function this.OnTerminate(e)
  if e.sequence then
    if IsTypeFunc(e.sequence.OnTerminate)then
      e.sequence.OnTerminate()
    end
  end
end
return this
