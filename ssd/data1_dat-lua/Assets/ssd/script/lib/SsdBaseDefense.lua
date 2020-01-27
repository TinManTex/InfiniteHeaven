local this={}
local S=256
local c=0
local l=1
local u=0
local s="base_defense_block"
local i="BStep_Clear"
local p=600
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local d=GkEventTimerManager.Start
local f=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}
local t=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}
local m={"S_DISABLE_TARGET","S_DISABLE_NPC_NOTICE","S_DISABLE_PLAYER_DAMAGE","S_DISABLE_THROWING","S_DISABLE_PLACEMENT"}
local o={}
function this.RegisterStepList(e)
  if not IsTypeTable(e)then
    return
  end
  local n=#e
  if n==0 then
    return
  end
  if n>=S then
    return
  end
  table.insert(e,i)
  mvars.bdf_stepList=Tpp.Enum(e)
end
function this.RegisterStepTable(n)
  if not IsTypeTable(n)then
    return
  end
  this.RegisterResultStepTable(n)
  mvars.bdf_stepTable=n
end
function this.RegisterResultStepTable(e)e[i]={
  OnEnter=function()
  end,
  OnLeave=function()
  end}
end
function this.RegisterSystemCallbacks(t)
  if not IsTypeTable(t)then
    return
  end
  mvars.bdf_systemCallbacks=mvars.bdf_systemCallbacks or{}
  local function s(n,e)
    if IsTypeFunc(n[e])then
      mvars.bdf_systemCallbacks[e]=n[e]
    end
  end
  local e={"OnActivate","OnDeactivate","OnTerminate","OnGameStart"}
  for n=1,#e do
    s(t,e[n])
  end
end
function this.SetNextStep(t)
  if not mvars.bdf_stepTable then
    return
  end
  if not mvars.bdf_stepList then
    return
  end
  local n=mvars.bdf_stepTable[t]
  local t=mvars.bdf_stepList[t]
  if n==nil then
    return
  end
  if t==nil then
    return
  end
  if(t~=l)and this.IsInvoking()then
    local n=this.GetStepTable(gvars.bdf_currentStepNumber)
    local e=n.OnLeave
    if IsTypeFunc(e)then
      e(n)
    end
  end
  gvars.bdf_currentStepNumber=t
  local t=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  local e=this.GetBlockState()
  if mvars.bdf_allocated then
    local e=n.OnEnter
    if IsTypeFunc(e)then
      e(n)
    end
  end
end
function this.ClearWithSave(t,n)
  if not n then
    n=this.GetCurrentMissionName()
  end
  TppStory.UpdateStorySequence{updateTiming="BaseDefenseEnd"}
  if t==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR then
    this.Clear(n)
  elseif t==TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE then
    this.Failure(n)
  end
  BaseDefenseManager.WaveEnd()
  TppStory.UpdateStorySequence{updateTiming="OnBaseDefenseClear"}
  this.Save()
end
function this.Clear(n)
  if n==nil then
    n=this.GetCurrentMissionName()
    if n==nil then
      return
    end
  end
  this.ShowAnnounceLog(t.CLEAR,n)
  this.PlayClearRadio(n)
  this.GetClearKeyItem(n)
  TppMission.OnClearDefenseGame()
end
function this.Failure(n)
  if n==nil then
    n=this.GetCurrentMissionName()
    if n==nil then
      return
    end
  end
  BaseDefenseManager.Failure()
  this.ShowAnnounceLog(t.FAILURE,n)
end
function this.Save()
  TppMission.VarSaveOnUpdateCheckPoint()
end
function this.SetClearFlag(e)
end
function this.SetDestructionTime(e)
  mvars.destructionTime=e
end
function this.StartDestruction()
  mvars.isStartDestruction=true
  Mission.StartBaseDestruction{destructionTime=mvars.destructionTime}
end
function this.GetCurrentWaveIndex()
  return BaseDefenseManager.GetCurrentWaveIndex()
end
function this.GetTotalWaveCount()
  return BaseDefenseManager.GetTotalWaveCount()
end
function this.OnAllocate(n)
  local n=BaseDefenseManager.GetMissionCodeList()
  local t={}
  for e=1,#n do
    local e="d"..tostring(n[e])
    table.insert(t,e)
  end
  o=TppDefine.Enum(t)
  BaseDefenseManager.RegisterCallback{onStart=this.OnStart,onFinish=this.OnFinish,onReceiveReward=this.OnRecvReward,onOutOfArea=this.OnOutOfMissionArea,onEndAutoDefense=this.OnEndAutoDefense}
end
function this.Init(n)
  this.OnInit()
end
function this.OnReload(n)
  this.OnInit()
end
function this.OnInit()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  if not TppMission.IsFreeMission(vars.missionCode)then
    return
  end
  local n=TppLocation.GetLocationName()
  if n then
    this.InitializePackList(n)
  end
  mvars.isStartDestruction=false
  mvars.destructionTime=p
end
function this.OnStart(e,n,t)
  mvars.bdf_loadMissionName=nil
  if e==TppDefine.MISSION_CODE_NONE then
    return
  end
  mvars.bdf_loadMissionName=("d"..tostring(e))
  mvars.bdf_skipBreakDiggingGameOver=true
  local e="/Assets/ssd/level_asset/defense_game/debug/"..(tostring(mvars.bdf_loadMissionName)..("_attack_"..(tostring(n)..".json")))
  Mission.LoadDefenseGameDataJson(e)
  if not t then
    TppPauseMenu.SetIgnoreActorPause(true)
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnStartBaseDefense",TppUI.FADE_PRIORITY.MISSION)
  end
end
function this.OnFinish(n,a)
  mvars.bdf_isAbandon=n
  mvars.bdf_skipBreakDiggingGameOver=false
  if n then
    Mission.SendMessage("Mission","AbandonBaseDefense")
    this.ShowAnnounceLog(t.FAILURE,missionName)--ORPHAN
    this.StartRewardSequence(TppDefine.BASE_DEFENSE_CLEAR_TYPE.ABANDON)
  end
end
function this.OnRecvReward(e)
  mvars.bdf_rewardCount=e
end
function this.OnOutOfMissionArea()
  TppPlayer.StoreTempInitialPosition()
  TppMission.ContinueFromCheckPoint()
end
function this.OnEndAutoDefense(e)
  if e then
    TppStory.UpdateStorySequence{updateTiming="OnBaseDefenseClear"}
    local e=BaseDefenseManager.GetCurrentMissionCode()
    if e==TppDefine.BASE_DEFENSE_TUTORIAL_MISSION then
      BaseDefenseManager.SetClosedFlag(TppDefine.BASE_DEFENSE_TUTORIAL_MISSION,true)
    end
  end
end
function this.StartRewardSequence(a)
  if mvars.bdf_isStartRewardSequence then
    return
  end
  local n=BaseDefenseManager.GetCurrentMissionCode()
  if n==TppDefine.MISSION_CODE_NONE then
    return
  end
  mvars.bdf_isStartRewardSequence=true
  local t=this.GetCurrentMissionName()
  if not t then
    t="d"..tostring(n)
  end
  Gimmick.SetAllSwitchInvalid(true)
  this.ClearWithSave(a,t)
  this.OnStartRewardSequence(a,n)
end
function this.OnStartRewardSequence(n,t)
  Player.SetPadMask{settingName="BaseDiggingClearDefense",except=false,buttons=(((PlayerPad.HOLD+PlayerPad.FIRE)+PlayerPad.CALL)+PlayerPad.SUBJECT)+PlayerPad.SKILL}
  for n,e in ipairs(m)do
    TppGameStatus.Set("BaseBaseDigging",e)
  end
  TppUiStatusManager.SetStatus("PauseMenu","INVALID")
  SsdUiSystem.RequestForceCloseForMissionClear()
  if n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR then
    DefenceTelopSystem.SetInfo(t,DefenceTelopType.Complete)
  elseif n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.ABANDON then
    DefenceTelopSystem.SetInfo(t,DefenceTelopType.Abort)
  else
    DefenceTelopSystem.SetInfo(t,DefenceTelopType.Failure)
  end
  TppMission.StopDefenseTotalTime()GkEventTimerManager.Start("Timer_BdfOpenTelopWait",1)
  if(n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.ABANDON)or(n==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR and BaseDefenseManager.IsTerminalWave())then
    mvars.bdf_viewTotalResult=true
    GkEventTimerManager.Start("Timer_BdfOpenRewardWormhole",4)
    GkEventTimerManager.Start("Timer_BdfDestroySingularityEffect",12)
    GkEventTimerManager.Start("Timer_BdfBaseDiggingFinish",35)
  else
    mvars.bdf_viewTotalResult=false
    this.CloseRewardWormhole()
    GkEventTimerManager.Start("Timer_BdfBaseDiggingFinish",10)
  end
end
function this.OpenRewardWormhole()
  local e=TppGimmick.baseImportantGimmickList.afgh[4]
  Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetRewardMode"}
  local n=TppGimmick.GetDiggerDefensePosition(TppGimmick.GetAfghBaseDiggerIdentifier())
  if not n then
    return
  end
  local n=Vector3(n[1],n[2]+20,n[3])
  Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="SetTargetPos",position=n}
  Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Open"}
end
function this.CloseRewardWormhole()
  local e=TppGimmick.baseImportantGimmickList.afgh[4]
  Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="Close"}
end
function this.StartResultSequence()
  ResultSystem.OpenBaseDefenseResult()
end
function this.OpenRewardResult()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnOpenBdfReward",TppUI.FADE_PRIORITY.MISSION)
end
function this.Messages()
  return StrCode32Table{
    GameObject={
      {msg="DiggingStartEffectEnd",func=function()
        if mvars.bdf_isStartRewardSequence then
          GkEventTimerManager.Start("Timer_BdfCloseRewardWormhole",5)
        end
      end}},
    Marker={
      {msg="ChangeToEnable",func=function(t,n,a,s)
        this._ChangeToEnable(t,n,a,s)
      end}},
    Timer={
      {msg="Finish",sender="Timer_BdfCheckUnload",func=function(n)
        local t=function()
          TppMain.EnablePlayerPad()
          if TppMission.IsInitMission(vars.missionCode)then
            return
          end
        end
        this._CheckUnloadBlock(n,"FadeInOnFinishDefense",t)
      end},
      {msg="Finish",sender="Timer_BdfRewardDrop",func=function(e)
        local e=BaseDefenseManager.DropRewardBox()
        if not e then
        end
      end},
      {msg="Finish",sender="Timer_BdfOpenTelopWait",func=function()
        DefenceTelopSystem.RequestOpen()
      end},
      {msg="Finish",sender="Timer_BdfCloseRewardWormhole",func=this.CloseRewardWormhole},
      {msg="Finish",sender="Timer_BdfOpenRewardWormhole",func=function()
        this.OpenRewardWormhole()
      end},
      {msg="Finish",sender="Timer_BdfDestroySingularityEffect",func=function()
        local e=TppGimmick.baseImportantGimmickList.afgh[4]
        Gimmick.SetAction{gimmickId=e.gimmickId,name=e.locatorName,dataSetName=e.datasetName,action="StopRewardWormhole"}
      end},
      {msg="Finish",sender="Timer_BdfBaseDiggingFinish",func=function()
        if mvars.bdf_viewTotalResult then
          d("Timer_BdfRewardDrop",.1)
        end
        this.StartResultSequence()
        this.SetNextStep(i)
      end}},
    UI={
      {msg="EndFadeOut",sender="FadeOutOnStartBaseDefense",func=function()
        TppMain.DisablePlayerPad()
        TppEnemy.SetEnemyLevelForBaseDefense()
        TppQuest.SetUnloadableAll(true)
        SsdBuildingMenuSystem.CloseBuildingMenu()
        SsdUiSystem.RequestForceCloseForMissionClear()
        this.LoadMission(mvars.bdf_loadMissionName)
      end},
      {msg="EndFadeOut",sender="FadeOutOnFinishBaseDefense",func=function()
        TppMain.DisablePlayerPad()
        this.UnloadBaseDefenseBlock()
        BaseDefenseManager.Finish()
        mvars.bdf_nextWaveWaitHour=0
        mvars.bdf_isAbandon=false
        mvars.bdf_isStartRewardSequence=false
        mvars.bdf_viewTotalResult=false
        SsdRewardCbox.ClearAll()
        TppMission.StopDefenseGame()
        TppPauseMenu.SetIgnoreActorPause(false)
        Gimmick.SetAllSwitchInvalid(false)
        local e=TppStory.GetCurrentStorySequence()
        TppEnemy.SetEnemyLevelBySequence(e)
        TppQuest.SetUnloadableAll(false)d("Timer_BdfCheckUnload",1)
      end},
      {msg="EndFadeIn",sender="FadeInOnStartDefense",func=function()
        TppMain.EnablePlayerPad()
      end},
      {msg="EndFadeIn",sender="FadeInOnFinishDefense",func=function()
        BaseDefenseManager.OpenNextWaveTime{displayTime=10}
      end},
      {msg="BaseDefenseMissionResultClosed",func=this.OpenRewardResult,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="BaseDefenseRewardClosed",func=this.FinishWave,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="FadeOutOnOpenBdfReward",func=function()
        if mvars.bdf_viewTotalResult then
          TppMain.DisablePlayerPad()
          BaseDefenseRewardSystem.RequestOpen()
        else
          this.FinishWave()
        end
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}}}}
end
function this.OnMessage(o,s,t,a,r,i,n)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,o,s,t,a,r,i,n)
  local l=mvars.bdf_scriptBlockMessageExecTable
  if l then
    local e=n
    Tpp.DoMessage(l,TppMission.CheckMessageOption,o,s,t,a,r,i,e)
  end
  if this.IsInvoking()and mvars.bdf_stepList then
    local l=gvars.bdf_currentStepNumber
    local e=this.GetStepTable(l)
    if e then
      local e=e._messageExecTable
      if e then
        local n=n
        Tpp.DoMessage(e,TppMission.CheckMessageOption,o,s,t,a,r,i,n)
      end
    end
  end
end
function this.OnDeactivate(e)
end
function this.InitializePackList(e)
  if e~="afgh"then
    return
  end
  mvars.loadedInfoList={}
  local e={}
  local n=BaseDefenseManager.GetMissionCodeList()
  local t="/Assets/ssd/pack/mission/defense/d50010/d50010.fpk"
  for a=1,#n do
    local n=n[a]
    local n="d"..tostring(n)e[n]={}
    table.insert(mvars.loadedInfoList,n)
    table.insert(e[n],t)
  end
  TppScriptBlock.RegisterCommonBlockPackList(s,e)
end
function this.InitializeActiveStatus()
  local n=this.GetBlockState()
  if n==nil then
    return
  end
  if n==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
    return
  end
  mvars.bdf_requestInitializeActiveStatus=false
  if n<ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or not this._CanActivate()then
    mvars.bdf_requestInitializeActiveStatus=true
    return
  end
  gvars.bdf_currentStepNumber=l
  local n=mvars.bdf_stepList[gvars.bdf_currentStepNumber]
  this.SetNextStep(n)
end
function this.IsSkipBreakDiggingGameOver()
  return(mvars.bdf_skipBreakDiggingGameOver==true)
end
function this.ResetSkipBreakDiggingGameOverFlag()
  mvars.bdf_skipBreakDiggingGameOver=false
end
function this.QARELEASE_DEBUG_Init()
  local e
  if DebugMenu then
    e=DebugMenu
  else
    return
  end
  mvars.qaDebug.historyBdfStep={}
  mvars.qaDebug.showCurrentBdfState=false
  e.AddDebugMenu("LuaBaseDefense","showCurrentState","bool",mvars.qaDebug,"showCurrentBdfState")
  mvars.qaDebug.forceBdfClear=false
  e.AddDebugMenu("LuaBaseDefense","forceClear","bool",mvars.qaDebug,"forceBdfClear")
  mvars.qaDebug.forceBdfFail=false
  e.AddDebugMenu("LuaBaseDefense","forceFail","bool",mvars.qaDebug,"forceBdfFail")
  mvars.qaDebug.forceBdfLoad=false
  e.AddDebugMenu("LuaBaseDefense","forceLoad","bool",mvars.qaDebug,"forceBdfLoad")
  mvars.qaDebug.forceBdfLoadIndex=0
  e.AddDebugMenu("LuaBaseDefense","forceLoadIndex","int32",mvars.qaDebug,"forceBdfLoadIndex")
end
function this.QAReleaseDebugUpdate()
  local n=DebugText.Print
  local t=DebugText.NewContext()
  local i=BaseDefenseManager.GetMissionCodeList()
  local s=#i
  if mvars.qaDebug.forceBdfClear then
    mvars.qaDebug.forceBdfClear=false
    local n=this.GetCurrentMissionName()
    if n then
      this.ClearWithSave(TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR,n)
    end
    this.UnloadBaseDefenseBlock()
  end
  if mvars.qaDebug.forceBdfFail then
    mvars.qaDebug.forceBdfFail=false
    local n=this.GetCurrentMissionName()
    if n then
      this.ClearWithSave(TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE,n)
    end
    this.UnloadBaseDefenseBlock()
  end
  if mvars.qaDebug.showCurrentBdfState then
    n(t,"")n(t,{.5,.5,1},"BaseDefense showCurrentState")
    local a=this.GetCurrentMissionName()
    if not a then
      n(t,"Current Mission : -----")
    else
      n(t,"Current Mission : "..tostring(a))
    end
    local a=this.GetBlockState()
    if a==nil then
      n(t,"Block State : BASE DEFENSE BLOCK isn't found...")
      return
    end
    local e={}
    e[ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"
    e[ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"
    e[ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"
    e[ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"
    n(t,"Block State : "..tostring(e[a]))n(t,"gvars.bdf_currentMissionName : "..tostring(gvars.bdf_currentMissionName))n(t,"gvars.bdf_currentStepNumber : "..tostring(gvars.bdf_currentStepNumber))
    if not mvars.bdf_stepList then
      n(t,"Sequence is not Defined...")
    else
      local e=gvars.bdf_currentStepNumber
      local e=mvars.bdf_stepList[e]n(t,"Current Sequence : "..tostring(e))
    end
    n(t,"--- Base Destruction State ---")
    if mvars.isStartDestruction then
      n(t,"DestructionTime[sec] : "..tostring(mvars.destructionTime))
      local e=Mission.GetBaseDestructionRate()n(t,"   BaseDamageRate[%] : "..tostring(e*100))
    else
      n(t,"Destruction isn't started yet...")
    end
    n(t,"")n(t,"--- BaseDefense ThreatValue ---")
  end
  do
    if s==0 then
      mvars.qaDebug.forceBdfLoadIndex=0
    elseif mvars.qaDebug.forceBdfLoadIndex>s then
      mvars.qaDebug.forceBdfLoadIndex=0
    end
  end
  if mvars.qaDebug.forceBdfLoad then
    local n=mvars.qaDebug.forceBdfLoadIndex
    mvars.qaDebug.forceBdfLoadIndex=0
    mvars.qaDebug.forceBdfLoad=false
    if n==0 then
      return
    end
    local n=i[n]
    if not n then
      return
    else
      local n="d"..tostring(n)
      this.LoadMission(n)
    end
  end
end
function this.OnInitialize(n)
  local t=n.Messages
  if IsTypeFunc(t)then
    local e=t()
    mvars.bdf_scriptBlockMessageExecTable=Tpp.MakeMessageExecTable(e)
  end
  this.MakeStepMessageExecTable()
  this._ResetMissionInfo(n)
end
function this._ResetMissionInfo(t)
  local n=this.GetCurrentMissionName()
  if not n then
    local n=t.missionName
    if n then
      this.ResetMissionStatus()
      this.SetCurrentMissionName(n)
    end
  end
end
function this.OnTerminate()
  this.ExecuteSystemCallback"OnTerminate"
  mvars.bdf_systemCallbacks=nil
  mvars.bdf_lastBlockState=nil
  mvars.bdf_stepList=nil
  mvars.bdf_stepTable=nil
  gvars.bdf_currentStepNumber=c
  mvars.bdf_scriptBlockMessageExecTable=nil
  mvars.bdf_rewardCount=0
  this.ClearCurrentMissionName()
  local e=ScriptBlock.GetScriptBlockId(s)
  TppScriptBlock.FinalizeScriptBlockState(e)
  TppMission.OnEndDefenseGame()
  TppMission.EnableBaseCheckPoint()
end
function this._CanActivate()
  if BaseDefenseManager.IsBusy()then
    return false
  end
  return true
end
function this.OnUpdate()
  local s=this.GetBlockState()
  if s==nil then
    return
  end
  local t=ScriptBlock
  local n=mvars
  local i=n.bdf_lastBlockState
  local r=t.SCRIPT_BLOCK_STATE_INACTIVE
  local t=t.SCRIPT_BLOCK_STATE_ACTIVE
  if n.bdf_requestInitializeActiveStatus then
    this.InitializeActiveStatus()
    return
  end
  if s==r then
    if this._CanActivate()then
      this.ActivateBaseDefenseBlock()
      this.ClearBlockStateRequest()
    end
    n.bdf_lastInactiveToActive=false
  elseif s==t then
    if not this._CanActivate()then
      return
    end
    local t
    if this.IsInvoking()then
      t=this.GetStepTable(gvars.bdf_currentStepNumber)
    end
    if n.bdf_lastInactiveToActive then
      n.bdf_lastInactiveToActive=false
      n.bdf_deactivated=false
      this.ExecuteSystemCallback"OnActivate"n.bdf_allocated=true
      this.Invoke()t=this.GetStepTable(gvars.bdf_currentStepNumber)
      this.ExecuteSystemCallback("OnGameStart",BaseDefenseManager.GetCurrentWaveIndex())
      BaseDefenseManager.RestoreScore()do
        local e={-441.836,288.34,2232.67}
        local n=TppPlayer.GetPosition()
        local n=TppMath.FindDistance(e,n)
        local e={-441.8,288.15,2234}
        if n<4 then
          TppPlayer.Warp{pos=e,rotY=0}Player.RequestToSetCameraRotation{rotX=20,rotY=-141,interpTime=0}
        end
      end
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnStartDefense",TppUI.FADE_PRIORITY.MISSION)
    end
    if(not i)or i<=r then
      n.bdf_lastInactiveToActive=true
    end
    if t and IsTypeFunc(t.OnUpdate)then
      t.OnUpdate(t)
    end
    if n.bdf_blockStateRequest==f.DEACTIVATE then
      this.DeactivateBaseDefenseBlock()
      this.ClearBlockStateRequest()
    end
  else
    n.bdf_lastInactiveToActive=false
    this.ClearBlockStateRequest()
  end
  n.bdf_lastBlockState=s
end
function this.GetOpenableMissionList()
  local e={}
  if not mvars.loadedInfoList then
    return e
  end
  if#mvars.loadedInfoList==0 then
    return e
  end
  for n=1,#mvars.loadedInfoList do
    local n=mvars.loadedInfoList[n]
    table.insert(e,n)
  end
  return e
end
function this.OnMissionGameEnd()
  local n=this.GetBlockState()
  if not n then
    return
  end
  mvars.bdf_isMissionEnd=true
  if n==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    this._DoDeactivate()
  end
end
function this.ClearBlockStateRequest()
  mvars.bdf_blockStateRequest=f.NONE
end
function this.Invoke()
  gvars.bdf_currentStepNumber=l
  local n=mvars.bdf_stepList[gvars.bdf_currentStepNumber]
  this.SetNextStep(n)
end
function this.LoadMission(n)
  local t=TppScriptBlock.Load(s,n)
  if t==false then
    return
  end
  this.ResetMissionStatus()
  this.SetCurrentMissionName(n)
  TppMission.DisableBaseCheckPoint()
end
function this.GetCurrentMissionName()
  return mvars.bdf_currentMissionName
end
function this.SetCurrentMissionName(e)
  mvars.bdf_currentMissionName=e
  gvars.bdf_currentMissionName=Fox.StrCode32(e)
end
function this.ClearCurrentMissionName()
  mvars.bdf_currentMissionName=nil
  gvars.bdf_currentMissionName=u
end
function this.ResetMissionStatus()
  gvars.bdf_currentMissionName=u
  gvars.bdf_currentStepNumber=c
end
function this.UnloadBaseDefenseBlock()
  TppScriptBlock.Unload(s)
end
function this.ActivateBaseDefenseBlock()
  local e=ScriptBlock.GetScriptBlockId(s)
  TppScriptBlock.ActivateScriptBlockState(e)
end
function this.DeactivateBaseDefenseBlock()
  local e=ScriptBlock.GetScriptBlockId(s)
  TppScriptBlock.DeactivateScriptBlockState(e)
end
function this.ExecuteSystemCallback(e,n)
  if mvars.bdf_systemCallbacks==nil then
    return
  end
  local e=mvars.bdf_systemCallbacks[e]
  if e then
    return e(n)
  end
end
function this.IsInvoking()
  if gvars.bdf_currentStepNumber~=c then
    return true
  else
    return false
  end
end
function this.IsRepop(e)
end
function this.IsOpen(e)
end
function this.IsActive(e)
end
function this.IsCleared(e)
  local e=tonumber(string.sub(e,-5))
  return BaseDefenseManager.IsCleared(e)
end
function this.IsEnd(n)
  if n==nil then
    n=this.GetCurrentMissionName()
    if n==nil then
      return
    end
  end
  if mvars.bdf_stepList[gvars.bdf_currentStepNumber]==i then
    return true
  end
  return false
end
function this._DoDeactivate()
  mvars.bdf_deactivated=true
  this.ExecuteSystemCallback"OnDeactivate"
  mvars.bdf_allocated=false
end
function this.MakeStepMessageExecTable()
  if not IsTypeTable(mvars.bdf_stepTable)then
    return
  end
  for n,e in pairs(mvars.bdf_stepTable)do
    local n=e.Messages
    if IsTypeFunc(n)then
      local n=n(e)
      e._messageExecTable=Tpp.MakeMessageExecTable(n)
    end
  end
end
function this.GetStepTable(e)
  if mvars.bdf_stepList==nil then
    return
  end
  local e=mvars.bdf_stepList[e]
  if e==nil then
    return
  end
  local e=mvars.bdf_stepTable[e]
  if e~=nil then
    return e
  else
    return
  end
end
function this.GetBlockState()
  local e=ScriptBlock.GetScriptBlockId(s)
  if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(e)
end
function this.PlayClearRadio(e)
end
function this.GetClearKeyItem(e)
end
function this.ShowAnnounceLog(e,e,e,e)
end
function this._ChangeToEnable(e,e,e,e)
end
function this.IsMissionActivated()
  return this.GetBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
end
function this.SetWaveIntervalTime(e)
  mvars.bdf_nextWaveWaitHour=e
end
function this.FinishWave()
  Player.ResetPadMask{settingName="BaseDiggingClearDefense"}
  for n,e in ipairs(m)do
    TppGameStatus.Reset("BaseBaseDigging",e)
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnFinishBaseDefense",TppUI.FADE_PRIORITY.MISSION)
end
function this._CheckUnloadBlock(s,t,n)
  local e=this.GetBlockState()
  if e==nil then
    if n and IsTypeFunc(n)then
      n()
    end
    Mission.SendMessage("Mission","OnBaseDefenseEnd")
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,t,TppUI.FADE_PRIORITY.MISSION)
    return
  end
  if e==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
    if n and IsTypeFunc(n)then
      n()
    end
    Mission.SendMessage("Mission","OnBaseDefenseEnd")
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,t,TppUI.FADE_PRIORITY.MISSION)
  else
    d(s,1)
  end
end
return this
