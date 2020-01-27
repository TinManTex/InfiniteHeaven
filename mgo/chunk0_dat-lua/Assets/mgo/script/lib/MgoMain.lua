-- MgoMain.lua
-- NMC: Stripped down TppMain for mgo
InfCore.LogFlow"Load MgoMain.lua"--tex
local this={}
this.requires={"/Assets/mgo/script/lib/MgoException.lua"}
this._requireList={}
do
  local disallow={
    TppMain=true,
    TppDemoBlock=true,
    mafr_luxury_block_list=true,
    TppEnemy=true,TppEneFova=true,
    TppRevenge=true,TppAnimal=true,
    TppAnimalBlock=true,
    TppHero=true,
    TppFreeHeliRadio=true,
    TppStory=true,
    TppTerminal=true,
    TppPaz=true,
    TppMbFreeDemo=true,
    TppTutorial=true,
    TppResult=true,
    TppReward=true,
    TppRevenge=true,
    TppReinforceBlock=true,
    TppCheckPoint=true
  }
  for n,libPath in ipairs(Tpp.requires)do
    local split=Tpp.SplitString(libPath,"/")
    local libName=string.sub(split[#split],1,#split[#split]-4)
    if disallow[libName]then
    else
      this._requireList[#this._requireList+1]=libName
    end
  end
end
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
local onMessageTable={}
local O={}
local onMessageTableSize=0
local messageExecTable={}
local m={}
local messageExecTableSize=0
local function RENAMEwhatisquarksystem()
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()coroutine.yield()
    while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
      coroutine.yield()
    end
  end
end
function this.OnAllocate(missionTable)
  InfCore.LogFlow("OnAllocate Top "..vars.missionCode)--tex
  InfMain.OnAllocateTop(missionTable)--tex
  TppMain.DisableGameStatus()
  TppMain.EnablePause()
  moduleUpdateFuncs={}
  numModuleUpdateFuncs=0
  debugUpdateFuncs={}
  numDebugUpdateFuncs=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil,{setMute=true})
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  TppGameStatus.Set("Mission","S_IS_ONLINE")
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(missionTable)
  TppClock.OnAllocate(missionTable)
  TppTrap.OnAllocate(missionTable)
  TppUI.OnAllocate(missionTable)
  TppDemo.OnAllocate(missionTable)
  TppSound.OnAllocate(missionTable)
  TppPlayer.OnAllocate(missionTable)
  TppMission.OnAllocate(missionTable)
  InfMain.OnAllocate(missionTable)--tex
  this.ClearStageBlockMessage()
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
    for t,lib in ipairs(this._requireList)do
      if _G[lib]then
        if _G[lib].DeclareSVars then
          InfCore.LogFlow(lib..".DeclareSVars")--tex DEBUG
          ApendArray(allSvars,InfCore.PCallDebug(_G[lib].DeclareSVars,missionTable))--tex PCall
        end
      end
    end
    --tex>
    --tex not fob check pretty critical here since svars mismatch actoss clients cause corruption and hangs across clients
    if not TppMission.IsFOBMission(vars.missionCode)then
      for i,module in ipairs(InfModules)do
        if module.DeclareSVars then
          InfCore.LogFlow(module.name..".DeclareSVars:")
          ApendArray(allSvars,InfCore.PCallDebug(module.DeclareSVars,missionTable))
        end
      end
    end
    --<
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
    TppScriptVars.DeclareSVars(allSvars)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while IsSavingOrLoading()do
      coroutine.yield()
    end
    if TppRadioCommand.SetScriptDeclVars then
      TppRadioCommand.SetScriptDeclVars()
    end
    if not gvars.ini_isTitleMode then
      if TppMission.IsMissionStart()then
        if(Fox.GetDebugLevel()>=Fox.DEBUG_LEVEL_QA_RELEASE)then
          TppDebug.DEBUG_RestoreSVars()
        end
        TppClock.RestoreMissionStartClock()
        TppWeather.RestoreMissionStartWeather()
        TppPlayer.SetInitialPlayerState(missionTable)
        TppPlayer.ResetDisableAction()
        if missionTable.sequence then
          TppPlayer.InitItemStockCount()
        end
        TppPlayer.RestoreChimeraWeaponParameter()
        if missionTable.sequence and IsTypeTable(missionTable.sequence.playerInitialWeaponTable)then
          TppPlayer.SetInitWeapons(missionTable.sequence.playerInitialWeaponTable)
        end
        TppPlayer.RestorePlayerWeaponsOnMissionStart()
        TppPlayer.SetMissionStartAmmoCount()
        if missionTable.sequence and IsTypeTable(missionTable.sequence.playerInitialItemTable)then
          TppPlayer.SetInitItems(missionTable.sequence.playerInitialItemTable)
        end
        TppPlayer.RestorePlayerItemsOnMissionStart()
        TppUI.OnMissionStart()
        TppPlayer.SetInitialPositionFromMissionStartPosition()
        PlayRecord.RegistPlayRecord"MISSION_START"
        else
        PlayRecord.RegistPlayRecord"MISSION_RETRY"
        Gimmick.RestoreSaveDataPermanentGimmickFromCheckPoint()
        TppMotherBaseManagement.SetupAfterRestoreFromSVars()
      end
    end
    this.StageBlockCurrentPosition()
    TppSequence.SaveMissionStartSequence()
    TppScriptVars.SetSVarsNotificationEnabled(true)
  end
  TppPlayer.SetMaxPickableLocatorCount()
  TppPlayer.SetMaxPlacedLocatorCount()
  TppEquip.AllocInstances{instance=60,realize=60}
  TppEquip.ActivateEquipSystem()
  if missionTable.sequence then
    mvars.mis_baseList=missionTable.sequence.baseList
  end
  InfCore.LogFlow("OnAllocate Bottom "..vars.missionCode)--tex
end
function this.PostInitialize()
  TppNetworkUtil.StopDebugSession()
  if(Fox.GetPlatformName()~="Windows"or not Editor)or Preference.IsCustomPrefs()then
    Script.LoadLibrary"/Assets/mgo/level/debug_menu/Select.lua"
    Select.Start()
  else
    vars.locationCode=65535
    vars.missionCode=65535
    TppMission.Load(vars.locationCode)
    local actMode=Fox.GetActMode()
    if(actMode=="GAME")then
      Fox.SetActMode"EDIT"
    end
  end
  TppMain.DisablePause()
end
function this.OnInitialize(missionTable)
  InfCore.LogFlow("OnInitialize Top "..vars.missionCode)--tex
  InfMain.OnInitializeTop(missionTable)--tex
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.Messages)then
      missionTable[name]._messageExecTable=Tpp.MakeMessageExecTable(module.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  for i,lib in ipairs(this._requireList)do
    if _G[lib]then
      if _G[lib].Init then
        InfCore.LogFlow(lib..".Init")--tex DEBUG
        InfCore.PCallDebug(_G[lib].Init,missionTable)--tex wrapped in pcall
      end
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
    TppMarker.RestoreMarkerLocator()
  end
  if missionTable.sequence then
    local SetUpRoutes=missionTable.sequence.SetUpRoutes
    if SetUpRoutes and IsTypeFunc(SetUpRoutes)then
      SetUpRoutes()
    end
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
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
  TppClock.Start()
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
    TppException.Update,
    TppMission.Update,
    TppSequence.Update,
    TppSave.Update,
    TppDemo.Update,
    TppPlayer.Update,
    InfMain.Update,--tex
  }
  numModuleUpdateFuncs=#moduleUpdateFuncs
  for name,module in pairs(missionTable)do
    if IsTypeFunc(module.OnUpdate)then
      numOnUpdate=numOnUpdate+1
      missionScriptOnUpdateFuncs[numOnUpdate]=module.OnUpdate
    end
  end
  if(Fox.GetDebugLevel()>=Fox.DEBUG_LEVEL_QA_RELEASE)then
    debugUpdateFuncs={TppSequence.DebugUpdate,TppDebug.DebugUpdate,TppTrap.DebugUpdate}
  else
    debugUpdateFuncs={}
  end
  numDebugUpdateFuncs=#debugUpdateFuncs
end
function this.OnEnterMissionPrepare()
  if TppMission.IsMissionStart()then
    TppScriptBlock.PreloadSettingOnMissionStart()
  end
  TppScriptBlock.ReloadScriptBlock()
end
function this.OnTextureLoadingWaitStart()
  StageBlockCurrentPositionSetter.SetEnable(false)
end
function this.OnMissionCanStart()
  if TppMission.IsMissionStart()then
    TppWeather.SetDefaultWeatherProbabilities()
    TppWeather.SetDefaultWeatherDurations()
  end
  TppWeather.OnMissionCanStart()
  TppMarker.OnMissionCanStart()
  TppResult.OnMissionCanStart()
  TppQuest.InitializeQuestLoad()
  TppRatBird.OnMissionCanStart()
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnMissionCanStart()
  end
  if TPP_FOCUS_TEST_BUILD then
    TppDebug.SetPlayLogEnabled(true)
  end
  TppOutOfMissionRangeEffect.Disable(0)
  if MotherBaseConstructConnector.RefreshGimmicks then
    if vars.locationCode==TppDefine.LOCATION_ID.MTBS then
      MotherBaseConstructConnector.RefreshGimmicks()
    end
  end
  InfMain.OnMissionCanStartBottom()--tex
end
function this.OnMissionGameStart(e)
  if not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_MOMENT)
    TppUI.EnableGameStatusOnFade()
    TppGimmick.OnMissionGameStart()
  end
  TppQuest.InitializeQuestActiveStatus()
  if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    TppMain.EnableGameStatusForDemo()
  else
    TppMain.EnableGameStatus()
  end
  local missionNumber,missionTypeCodeName=TppMission.ParseMissionName(TppMission.GetMissionName())
  if(missionTypeCodeName=="free"or missionTypeCodeName=="heli")and gvars.mis_isExistOpenMissionFlag then
    TppUI.ShowAnnounceLog"missionListUpdate"
    TppUI.ShowAnnounceLog"missionAdd"
  end
end
function this.ClearStageBlockMessage()
  StageBlock.ClearLargeBlockNameForMessage()
  StageBlock.ClearSmallBlockIndexForMessage()
end
--REF TPP (missionLoadType,isHeliSpace,isFreeMission,nextIsHeliSpace,nextIsFreeMission,abortWithSave,isLocationChange)
function this.ReservePlayerLoadingPosition(missionLoadType,unk1,unk2,unk3,unk4,unk5)
  TppMain.DisableGameStatus()
  if missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if unk3 then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif unk1 then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif unk4 then
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
    elseif(unk2 and TppLocation.IsMotherBase())then
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
      if unk2 then
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
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppMission.ResetIsStartFromHelispace()
        TppMission.SetIsStartFromFreePlay()
        local missionClearType=TppMission.GetMissionClearType()
        TppQuest.SpecialMissionStartSetting(missionClearType)
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
        TppMission.ResetIsStartFromHelispace()
        TppMission.ResetIsStartFromFreePlay()
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if unk5 then
      if unk4 then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif unk3 then
        TppPlayer.ResetMissionStartPosition()
      end
    else
      if unk3 then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif unk4 then
        TppMission.SetMissionOrderBoxPosition()
      end
    end
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif missionLoadType==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  this.StageBlockCurrentPosition()
end
function this.StageBlockCurrentPosition()
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
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
  for i,lib in ipairs(this._requireList)do
    if _G[lib]then
      if _G[lib].OnReload then
        InfCore.LogFlow(lib..".OnReload")--tex DEBUG
        InfCore.PCallDebug(_G[lib],missionTable)--tex PCall
      end
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if missionTable.sequence then
  end
  this.SetUpdateFunction(missionTable)
  this.SetMessageFunction(missionTable)
end
function this.OnUpdate(missionTable)
  --ORPHAN: local e
  local moduleUpdateFuncs=moduleUpdateFuncs
  local missionScriptOnUpdateFuncs=missionScriptOnUpdateFuncs
  local debugUpdateFuncs=debugUpdateFuncs
  --tex
  if InfCore.debugOnUpdate then
    for i=1,numModuleUpdateFuncs do
      InfCore.PCallDebug(moduleUpdateFuncs[i])
    end
    for i=1,numOnUpdate do
      InfCore.PCallDebug(missionScriptOnUpdateFuncs[i])
    end
    --ORIG>
  else
    for i=1,numModuleUpdateFuncs do
      moduleUpdateFuncs[i]()
    end
    for i=1,numOnUpdate do
      missionScriptOnUpdateFuncs[i]()
    end
  end
  UpdateScriptsInScriptBlocks()
end
function this.OnChangeSVars(subScripts,varName,key)
  for i,lib in ipairs(this._requireList)do
    if _G[lib]then
      if _G[lib].OnChangeSVars then
        InfCore.LogFlow(lib..".OnChangeSVars")--tex DEBUG
        InfCore.PCallDebug(_G[lib].OnChangeSVars,varName,key)--tex PCALL
      end
    end
  end
end
function this.SetMessageFunction(missionTable)
  onMessageTable={}
  onMessageTableSize=0
  messageExecTable={}
  messageExecTableSize=0
  for n,lib in ipairs(this._requireList)do
    if _G[lib]then
      if _G[lib].OnMessage then
        onMessageTableSize=onMessageTableSize+1
        onMessageTable[onMessageTableSize]=_G[lib].OnMessage
      end
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
--tex called via mission_main.OnMessage TODO: caller of that? probably engine
--sender and messageClass are actually str32 of the original messageexec creation definitions
--GOTCHA: sender is actuall the message class (Player,MotherBaseManagement,UI etc), not to be confused with the sender defined in the messageexec definitions.
--args are lua type number, but may represent enum,int,float, StrCode32, whatever.
--arg0 may match sender (not messageClass) in messageexec definition (see Tpp.DoMessage)
function this.OnMessage(missionTable,sender,messageId,arg0,arg1,arg2,arg3)
  if Ivars.debugMessages:Is(1)then--tex>
    InfCore.PCall(InfLookup.PrintOnMessage,sender,messageId,arg0,arg1,arg2,arg3)
  end--<
  local mvars=mvars
  local strLogTextEmpty=""
  local T
  local DoMessage=Tpp.DoMessage
  local CheckMessageOption=TppMission.CheckMessageOption
  local T=TppDebug
  local T=O
  local T=m
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
    InfCore.PCallDebug(onMessageTable[i],sender,messageId,arg0,arg1,arg2,arg3,strLogText)--tex wrapped in pcall
  end
  for i=1,messageExecTableSize do
    local strLogText=strLogTextEmpty
    InfCore.PCallDebug(DoMessage,messageExecTable[i],CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)--tex wrapped in pcall
  end
  if mvars.loc_locationCommonTable then
    InfCore.PCallDebug(mvars.loc_locationCommonTable.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end
  if mvars.order_box_script then
    InfCore.PCallDebug(mvars.order_box_script.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end
  if mvars.animalBlockScript and mvars.animalBlockScript.OnMessage then
    InfCore.PCallDebug(mvars.animalBlockScript.OnMessage,sender,messageId,arg0,arg1,arg2,arg3,strLogTextEmpty)--tex wrapped in pcall
  end
end
function this.OnTerminate(missionTable)
  if missionTable.sequence then
    if IsTypeFunc(missionTable.sequence.OnTerminate)then
      missionTable.sequence.OnTerminate()
    end
  end
end
return this
