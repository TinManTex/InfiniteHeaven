local this={}
this.requires={"/Assets/mgo/script/lib/MgoException.lua"}
this._requireList={}
do
  local i={
    TppMain=true,
    TppDemoBlock=true,
    mafr_luxury_block_list=true,
    TppEnemy=true,
    TppEneFova=true,
    TppRevenge=true,
    TppAnimal=true,
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
  for n,t in ipairs(Tpp.requires)do
    local t=Tpp.SplitString(t,"/")
    local t=string.sub(t[#t],1,#t[#t]-4)
    if i[t]then
    else
      this._requireList[#this._requireList+1]=t
    end
  end
end
local p=Tpp.ApendArray
local t=Tpp.DEBUG_StrCode32ToString
local i=Tpp.IsTypeFunc
local S=Tpp.IsTypeTable
local f=TppScriptVars.IsSavingOrLoading
local M=ScriptBlock.UpdateScriptsInScriptBlocks
local P=Mission.GetCurrentMessageResendCount
local s={}
local l=0
local T={}
local r=0
local n={}
local c=0
local d={}
local O={}
local a=0
local u={}
local m={}
local o=0
local function t()
  if QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD then
    QuarkSystem.PostRequestToLoad()coroutine.yield()
    while QuarkSystem.GetCompilerState()==QuarkSystem.COMPILER_STATE_WAITING_TO_LOAD do
      coroutine.yield()
    end
  end
end
function this.OnAllocate(t)
  TppMain.DisableGameStatus()
  TppMain.EnablePause()
  s={}
  l=0
  n={}
  c=0
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,nil,nil,{setMute=true})
  TppSave.WaitingAllEnqueuedSaveOnStartMission()
  TppGameStatus.Set("Mission","S_IS_ONLINE")
  Mission.Start()
  TppMission.WaitFinishMissionEndPresentation()
  TppMission.DisableInGameFlag()
  TppException.OnAllocate(t)
  TppClock.OnAllocate(t)
  TppTrap.OnAllocate(t)
  TppUI.OnAllocate(t)
  TppDemo.OnAllocate(t)
  TppSound.OnAllocate(t)
  TppPlayer.OnAllocate(t)
  TppMission.OnAllocate(t)
  this.ClearStageBlockMessage()
  if t.sequence then
    if i(t.sequence.MissionPrepare)then
      t.sequence.MissionPrepare()
    end
    if i(t.sequence.OnEndMissionPrepareSequence)then
      TppSequence.SetOnEndMissionPrepareFunction(t.sequence.OnEndMissionPrepareSequence)
    end
  end
  for t,e in pairs(t)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
  end
  do
    local n={}
    for t,e in ipairs(this._requireList)do
      if _G[e]then
        if _G[e].DeclareSVars then
          p(n,_G[e].DeclareSVars())
        end
      end
    end
    local o={}
    for t,e in pairs(t)do
      if i(e.DeclareSVars)then
        p(o,e.DeclareSVars())
      end
      if S(e.saveVarsList)then
        p(o,TppSequence.MakeSVarsTable(e.saveVarsList))
      end
    end
    p(n,o)
    TppScriptVars.DeclareSVars(n)
    TppScriptVars.SetSVarsNotificationEnabled(false)
    while f()do
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
        TppPlayer.SetInitialPlayerState(t)
        TppPlayer.ResetDisableAction()
        if t.sequence then
          TppPlayer.InitItemStockCount()
        end
        TppPlayer.RestoreChimeraWeaponParameter()
        if t.sequence and S(t.sequence.playerInitialWeaponTable)then
          TppPlayer.SetInitWeapons(t.sequence.playerInitialWeaponTable)
        end
        TppPlayer.RestorePlayerWeaponsOnMissionStart()
        TppPlayer.SetMissionStartAmmoCount()
        if t.sequence and S(t.sequence.playerInitialItemTable)then
          TppPlayer.SetInitItems(t.sequence.playerInitialItemTable)
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
  if t.sequence then
    mvars.mis_baseList=t.sequence.baseList
  end
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
    local e=Fox.GetActMode()
    if(e=="GAME")then
      Fox.SetActMode"EDIT"
    end
  end
  TppMain.DisablePause()
end
function this.OnInitialize(t)
  if TppMission.IsMissionStart()then
    TppTrap.InitializeVariableTraps()
  else
    TppTrap.RestoreVariableTrapState()
  end
  for n,e in pairs(t)do
    if i(e.Messages)then
      t[n]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnInitialize()
  end
  for i,e in ipairs(this._requireList)do
    if _G[e]then
      if _G[e].Init then
        _G[e].Init(t)
      end
    end
  end
  if not TppMission.IsMissionStart()then
    TppWeather.RestoreFromSVars()
    TppMarker.RestoreMarkerLocator()
  end
  if t.sequence then
    local e=t.sequence.SetUpRoutes
    if e and i(e)then
      e()
    end
    local e=t.sequence.SetUpLocation
    if e and i(e)then
      e()
    end
  end
  for t,e in pairs(t)do
    if e.OnRestoreSVars then
      e.OnRestoreSVars()
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
  this.SetUpdateFunction(t)
  this.SetMessageFunction(t)
  TppClock.Start()
end
function this.SetUpdateFunction(e)
  s={}
  l=0
  T={}
  r=0
  n={}
  c=0
  s={
    TppException.Update,
    TppMission.Update,
    TppSequence.Update,
    TppSave.Update,
    TppDemo.Update,
    TppPlayer.Update
  }
  l=#s
  for t,e in pairs(e)do
    if i(e.OnUpdate)then
      r=r+1
      T[r]=e.OnUpdate
    end
  end
  if(Fox.GetDebugLevel()>=Fox.DEBUG_LEVEL_QA_RELEASE)then
    n={TppSequence.DebugUpdate,TppDebug.DebugUpdate,TppTrap.DebugUpdate}
  else
    n={}
  end
  c=#n
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
  local t,e=TppMission.ParseMissionName(TppMission.GetMissionName())
  if(e=="free"or e=="heli")and gvars.mis_isExistOpenMissionFlag then
    TppUI.ShowAnnounceLog"missionListUpdate"
    TppUI.ShowAnnounceLog"missionAdd"
  end
end
function this.ClearStageBlockMessage()
  StageBlock.ClearLargeBlockNameForMessage()
  StageBlock.ClearSmallBlockIndexForMessage()
end
function this.ReservePlayerLoadingPosition(t,a,o,i,n,s)
  TppMain.DisableGameStatus()
  if t==TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE then
    if i then
      TppHelicopter.ResetMissionStartHelicopterRoute()
      TppPlayer.ResetInitialPosition()
      TppPlayer.ResetMissionStartPosition()
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.ResetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif a then
      if gvars.heli_missionStartRoute~=0 then
        TppPlayer.SetStartStatusRideOnHelicopter()
      else
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      end
      TppPlayer.ResetNoOrderBoxMissionStartPosition()
      TppMission.SetIsStartFromHelispace()
      TppMission.ResetIsStartFromFreePlay()
    elseif n then
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
  elseif t==TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT then
    TppPlayer.ResetInitialPosition()
    TppHelicopter.ResetMissionStartHelicopterRoute()
    TppMission.ResetIsStartFromHelispace()
    TppMission.ResetIsStartFromFreePlay()
    if s then
      if n then
        TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.SetMissionStartPositionToCurrentPosition()
        TppPlayer.ResetNoOrderBoxMissionStartPosition()
      elseif i then
        TppPlayer.ResetMissionStartPosition()
      end
    else
      if i then
        TppHelicopter.ResetMissionStartHelicopterRoute()
        TppPlayer.ResetInitialPosition()
        TppPlayer.ResetMissionStartPosition()
      elseif n then
        TppMission.SetMissionOrderBoxPosition()
      end
    end
  elseif t==TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART then
  elseif t==TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT then
  end
  this.StageBlockCurrentPosition()
end
function this.StageBlockCurrentPosition()
  if vars.initialPlayerFlag==PlayerFlag.USE_VARS_FOR_INITIAL_POS then
    StageBlockCurrentPositionSetter.SetEnable(true)
    StageBlockCurrentPositionSetter.SetPosition(vars.initialPlayerPosX,vars.initialPlayerPosZ)
  end
end
function this.OnReload(t)
  for n,e in pairs(t)do
    if i(e.OnLoad)then
      e.OnLoad()
    end
    if i(e.Messages)then
      t[n]._messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
    end
  end
  for i,e in ipairs(this._requireList)do
    if _G[e]then
      if _G[e].OnReload then
        _G[e].OnReload(t)
      end
    end
  end
  if mvars.loc_locationCommonTable then
    mvars.loc_locationCommonTable.OnReload()
  end
  if t.sequence then
  end
  this.SetUpdateFunction(t)
  this.SetMessageFunction(t)
end
function this.OnUpdate(e)
  local e
  local i=s
  local t=T
  local e=n
  for e=1,l do
    i[e]()
  end
  for e=1,r do
    t[e]()
  end
  M()
end
function this.OnChangeSVars(n,i,t)
  for n,e in ipairs(this._requireList)do
    if _G[e]then
      if _G[e].OnChangeSVars then
        _G[e].OnChangeSVars(i,t)
      end
    end
  end
end
function this.SetMessageFunction(t)
  d={}
  a=0
  u={}
  o=0
  for t,e in ipairs(this._requireList)do
    if _G[e]then
      if _G[e].OnMessage then
        a=a+1
        d[a]=_G[e].OnMessage
      end
    end
  end
  for e,i in pairs(t)do
    if t[e]._messageExecTable then
      o=o+1
      u[o]=t[e]._messageExecTable
    end
  end
end
function this.OnMessage(e,t,i,s,n,p,l)
  local e=mvars
  local r=""
  local T
  local S=Tpp.DoMessage
  local M=TppMission.CheckMessageOption
  local T=TppDebug
  local T=O
  local T=m
  local T=TppDefine.MESSAGE_GENERATION[t]and TppDefine.MESSAGE_GENERATION[t][i]
  if not T then
    T=TppDefine.DEFAULT_MESSAGE_GENERATION
  end
  local c=P()
  if c<T then
    return Mission.ON_MESSAGE_RESULT_RESEND
  end
  for o=1,a do
    local e=r
    d[o](t,i,s,n,p,l,e)
  end
  for e=1,o do
    local o=r
    S(u[e],M,t,i,s,n,p,l,o)
  end
  if e.loc_locationCommonTable then
    e.loc_locationCommonTable.OnMessage(t,i,s,n,p,l,r)
  end
  if e.order_box_script then
    e.order_box_script.OnMessage(t,i,s,n,p,l,r)
  end
  if e.animalBlockScript and e.animalBlockScript.OnMessage then
    e.animalBlockScript.OnMessage(t,i,s,n,p,l,r)
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
