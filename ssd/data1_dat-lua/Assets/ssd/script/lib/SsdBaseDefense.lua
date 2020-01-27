-- SsdBaseDefense
local this={}
local MAX_STEPS=256
local stepNumberNone=0
local step1=1
local missionNameNone=0
local base_defense_blockStr="base_defense_block"
local BStep_ClearStr="BStep_Clear"
local p=600
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local TimerStart=GkEventTimerManager.Start
local f=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}
local t=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}
local statusDisableOnReward={"S_DISABLE_TARGET","S_DISABLE_NPC_NOTICE","S_DISABLE_PLAYER_DAMAGE","S_DISABLE_THROWING","S_DISABLE_PLACEMENT"}
local o={}
function this.RegisterStepList(stepList)
  if not IsTypeTable(stepList)then
    return
  end
  local n=#stepList
  if n==0 then
    return
  end
  if n>=MAX_STEPS then
    return
  end
  table.insert(stepList,BStep_ClearStr)
  mvars.bdf_stepList=Tpp.Enum(stepList)
end
function this.RegisterStepTable(stepTable)
  if not IsTypeTable(stepTable)then
    return
  end
  this.RegisterResultStepTable(stepTable)
  mvars.bdf_stepTable=stepTable
end
function this.RegisterResultStepTable(resultStepTable)
  resultStepTable[BStep_ClearStr]={
    OnEnter=function()
    end,
    OnLeave=function()
    end
  }
end
function this.RegisterSystemCallbacks(callbacks)
  if not IsTypeTable(callbacks)then
    return
  end
  mvars.bdf_systemCallbacks=mvars.bdf_systemCallbacks or{}
  local function AddCallBack(callbacks,funcName)
    if IsTypeFunc(callbacks[funcName])then
      mvars.bdf_systemCallbacks[funcName]=callbacks[funcName]
    end
  end
  local callbackNames={"OnActivate","OnDeactivate","OnTerminate","OnGameStart"}
  for n=1,#callbackNames do
    AddCallBack(callbacks,callbackNames[n])
  end
end
function this.SetNextStep(stepName)
  if not mvars.bdf_stepTable then
    return
  end
  if not mvars.bdf_stepList then
    return
  end
  local n=mvars.bdf_stepTable[stepName]
  local stepNumber=mvars.bdf_stepList[stepName]
  if n==nil then
    return
  end
  if stepNumber==nil then
    return
  end
  if(stepNumber~=step1)and this.IsInvoking()then
    local stepTable=this.GetStepTable(gvars.bdf_currentStepNumber)
    local OnLeave=stepTable.OnLeave
    if IsTypeFunc(OnLeave)then
      OnLeave(stepTable)
    end
  end
  gvars.bdf_currentStepNumber=stepNumber
  local t=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  local blockState=this.GetBlockState()
  if mvars.bdf_allocated then
    local OnEnter=n.OnEnter
    if IsTypeFunc(OnEnter)then
      OnEnter(n)
    end
  end
end
function this.ClearWithSave(clearType,currentMissionName)
  if not currentMissionName then
    currentMissionName=this.GetCurrentMissionName()
  end
  TppStory.UpdateStorySequence{updateTiming="BaseDefenseEnd"}
  if clearType==TppDefine.BASE_DEFENSE_CLEAR_TYPE.CLEAR then
    this.Clear(currentMissionName)
  elseif clearType==TppDefine.BASE_DEFENSE_CLEAR_TYPE.FAILURE then
    this.Failure(currentMissionName)
  end
  BaseDefenseManager.WaveEnd()
  TppStory.UpdateStorySequence{updateTiming="OnBaseDefenseClear"}
  this.Save()
end
function this.Clear(currentMissionName)
  if currentMissionName==nil then
    currentMissionName=this.GetCurrentMissionName()
    if currentMissionName==nil then
      return
    end
  end
  this.ShowAnnounceLog(t.CLEAR,currentMissionName)
  this.PlayClearRadio(currentMissionName)
  this.GetClearKeyItem(currentMissionName)
  TppMission.OnClearDefenseGame()
end
function this.Failure(currentMissionName)
  if currentMissionName==nil then
    currentMissionName=this.GetCurrentMissionName()
    if currentMissionName==nil then
      return
    end
  end
  BaseDefenseManager.Failure()
  this.ShowAnnounceLog(t.FAILURE,currentMissionName)
end
function this.Save()
  TppMission.VarSaveOnUpdateCheckPoint()
end
function this.SetClearFlag(e)
end
function this.SetDestructionTime(time)
  mvars.destructionTime=time
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
  local missionCodeList=BaseDefenseManager.GetMissionCodeList()
  local t={}
  for e=1,#missionCodeList do
    local e="d"..tostring(missionCodeList[e])
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
  mvars.bdf_waitLoading=false--RETAILPATCH: 1.0.5.0
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
  Player.SetPadMask{settingName="BaseDiggingClearDefense",except=false,buttons=(((PlayerPad.HOLD+PlayerPad.FIRE)+PlayerPad.CALL)+PlayerPad.SUBJECT)+PlayerPad.SKILL}--RETAILPATCH:1.0.5.0 added +SKILL
  for n,e in ipairs(statusDisableOnReward)do
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
          TimerStart("Timer_BdfRewardDrop",.1)
        end
        this.StartResultSequence()
        this.SetNextStep(BStep_ClearStr)
      end}},
    UI={
      {msg="EndFadeOut",sender="FadeOutOnStartBaseDefense",func=function()
        mvars.bdf_waitLoading=SsdBuilding.IsNetworkBusy()--RETAILPATCH: 1.0.5.0
        TppMain.DisablePlayerPad()
        TppEnemy.SetEnemyLevelForBaseDefense()
        TppQuest.SetUnloadableAll(true)
        if not mvars.bdf_waitLoading then--RETAILPATCH: 1.0.5.0 added check
          SsdBuildingMenuSystem.CloseBuildingMenu()
          SsdUiSystem.RequestForceCloseForMissionClear()
          this.LoadMission(mvars.bdf_loadMissionName)
        end
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
        TppQuest.SetUnloadableAll(false)TimerStart("Timer_BdfCheckUnload",1)
      end},
      {msg="EndFadeIn",sender="FadeInOnStartDefense",func=function()
        TppMain.EnablePlayerPad()
      end},
      {msg="EndFadeIn",sender="FadeInOnFinishDefense",func=function()
        BaseDefenseManager.OpenNextWaveTime{displayTime=10}
        RewardPopupSystem.RequestOpen(RewardPopupSystem.OPEN_TYPE_CHECK_POINT)--RETAILPATCH: 1.0.5.0
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
  TppScriptBlock.RegisterCommonBlockPackList(base_defense_blockStr,e)
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
  gvars.bdf_currentStepNumber=step1
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
    n(t,"")
    n(t,{.5,.5,1},"BaseDefense showCurrentState")
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
    n(t,"Block State : "..tostring(e[a]))
    n(t,"gvars.bdf_currentMissionName : "..tostring(gvars.bdf_currentMissionName))
    n(t,"gvars.bdf_currentStepNumber : "..tostring(gvars.bdf_currentStepNumber))
    if not mvars.bdf_stepList then
      n(t,"Sequence is not Defined...")
    else
      local e=gvars.bdf_currentStepNumber
      local e=mvars.bdf_stepList[e]n(t,"Current Sequence : "..tostring(e))
    end
    n(t,"--- Base Destruction State ---")
    if mvars.isStartDestruction then
      n(t,"DestructionTime[sec] : "..tostring(mvars.destructionTime))
      local e=Mission.GetBaseDestructionRate()
      n(t,"   BaseDamageRate[%] : "..tostring(e*100))
    else
      n(t,"Destruction isn't started yet...")
    end
    n(t,"")
    n(t,"--- BaseDefense ThreatValue ---")
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
  local Messages=n.Messages
  if IsTypeFunc(Messages)then
    local messageTable=Messages()
    mvars.bdf_scriptBlockMessageExecTable=Tpp.MakeMessageExecTable(messageTable)
  end
  this.MakeStepMessageExecTable()
  this._ResetMissionInfo(n)
end
function this._ResetMissionInfo(t)
  local currentMissionName=this.GetCurrentMissionName()
  if not currentMissionName then
    local missionName=t.missionName
    if missionName then
      this.ResetMissionStatus()
      this.SetCurrentMissionName(missionName)
    end
  end
end
function this.OnTerminate()
  this.ExecuteSystemCallback"OnTerminate"
  mvars.bdf_systemCallbacks=nil
  mvars.bdf_lastBlockState=nil
  mvars.bdf_stepList=nil
  mvars.bdf_stepTable=nil
  gvars.bdf_currentStepNumber=stepNumberNone
  mvars.bdf_scriptBlockMessageExecTable=nil
  mvars.bdf_rewardCount=0
  mvars.bdf_waitLoading=false--RETAILPATCH: 1.0.5.0
  this.ClearCurrentMissionName()
  local scriptBlockId=ScriptBlock.GetScriptBlockId(base_defense_blockStr)
  TppScriptBlock.FinalizeScriptBlockState(scriptBlockId)
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
  local blockState=this.GetBlockState()
  if blockState==nil then
    return
  end
  local ScriptBlock=ScriptBlock
  local mvars=mvars
  local bdf_lastBlockState=mvars.bdf_lastBlockState
  local SCRIPT_BLOCK_STATE_INACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
  local SCRIPT_BLOCK_STATE_ACTIVE=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  if mvars.bdf_waitLoading then--RETAILPATCH: 1.0.5.0>
    mvars.bdf_waitLoading=SsdBuilding.IsNetworkBusy()
    if not mvars.bdf_waitLoading then
      SsdBuildingMenuSystem.CloseBuildingMenu()
      SsdUiSystem.RequestForceCloseForMissionClear()
      this.LoadMission(mvars.bdf_loadMissionName)
    else
      return
    end
  end--<
  if mvars.bdf_requestInitializeActiveStatus then
    this.InitializeActiveStatus()
    return
  end
  if blockState==SCRIPT_BLOCK_STATE_INACTIVE then
    if this._CanActivate()then
      this.ActivateBaseDefenseBlock()
      this.ClearBlockStateRequest()
    end
    mvars.bdf_lastInactiveToActive=false
  elseif blockState==SCRIPT_BLOCK_STATE_ACTIVE then
    if not this._CanActivate()then
      return
    end
    local stepTable
    if this.IsInvoking()then
      stepTable=this.GetStepTable(gvars.bdf_currentStepNumber)
    end
    if mvars.bdf_lastInactiveToActive then
      mvars.bdf_lastInactiveToActive=false
      mvars.bdf_deactivated=false
      this.ExecuteSystemCallback"OnActivate"
      mvars.bdf_allocated=true
      this.Invoke()
      stepTable=this.GetStepTable(gvars.bdf_currentStepNumber)
      this.ExecuteSystemCallback("OnGameStart",BaseDefenseManager.GetCurrentWaveIndex())
      BaseDefenseManager.RestoreScore()
      do
        local startPos={-441.836,288.34,2232.67}
        local playerPos=TppPlayer.GetPosition()
        local dist=TppMath.FindDistance(startPos,playerPos)
        local warpPos={-441.8,288.15,2234}
        if dist<4 then
          TppPlayer.Warp{pos=warpPos,rotY=0}
          Player.RequestToSetCameraRotation{rotX=20,rotY=-141,interpTime=0}
        end
      end
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnStartDefense",TppUI.FADE_PRIORITY.MISSION)
    end
    if(not bdf_lastBlockState)or bdf_lastBlockState<=SCRIPT_BLOCK_STATE_INACTIVE then
      mvars.bdf_lastInactiveToActive=true
    end
    if stepTable and IsTypeFunc(stepTable.OnUpdate)then
      stepTable.OnUpdate(stepTable)
    end
    if mvars.bdf_blockStateRequest==f.DEACTIVATE then
      this.DeactivateBaseDefenseBlock()
      this.ClearBlockStateRequest()
    end
  else
    mvars.bdf_lastInactiveToActive=false
    this.ClearBlockStateRequest()
  end
  mvars.bdf_lastBlockState=blockState
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
  local blockState=this.GetBlockState()
  if not blockState then
    return
  end
  mvars.bdf_isMissionEnd=true
  if blockState==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    this._DoDeactivate()
  end
end
function this.ClearBlockStateRequest()
  mvars.bdf_blockStateRequest=f.NONE
end
function this.Invoke()
  gvars.bdf_currentStepNumber=step1
  local stepName=mvars.bdf_stepList[gvars.bdf_currentStepNumber]
  this.SetNextStep(stepName)
end
function this.LoadMission(missionName)
  local loaded=TppScriptBlock.Load(base_defense_blockStr,missionName)
  if loaded==false then
    return
  end
  this.ResetMissionStatus()
  this.SetCurrentMissionName(missionName)
  TppMission.DisableBaseCheckPoint()
end
function this.GetCurrentMissionName()
  return mvars.bdf_currentMissionName
end
function this.SetCurrentMissionName(currentMissionName)
  mvars.bdf_currentMissionName=currentMissionName
  gvars.bdf_currentMissionName=Fox.StrCode32(currentMissionName)
end
function this.ClearCurrentMissionName()
  mvars.bdf_currentMissionName=nil
  gvars.bdf_currentMissionName=missionNameNone
end
function this.ResetMissionStatus()
  gvars.bdf_currentMissionName=missionNameNone
  gvars.bdf_currentStepNumber=stepNumberNone
end
function this.UnloadBaseDefenseBlock()
  TppScriptBlock.Unload(base_defense_blockStr)
end
function this.ActivateBaseDefenseBlock()
  local e=ScriptBlock.GetScriptBlockId(base_defense_blockStr)
  TppScriptBlock.ActivateScriptBlockState(e)
end
function this.DeactivateBaseDefenseBlock()
  local e=ScriptBlock.GetScriptBlockId(base_defense_blockStr)
  TppScriptBlock.DeactivateScriptBlockState(e)
end
function this.ExecuteSystemCallback(e,n)
  if mvars.bdf_systemCallbacks==nil then
    return
  end
  local CallBack=mvars.bdf_systemCallbacks[e]
  if CallBack then
    return CallBack(n)
  end
end
function this.IsInvoking()
  if gvars.bdf_currentStepNumber~=stepNumberNone then
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
function this.IsEnd(currentMissionName)
  if currentMissionName==nil then
    currentMissionName=this.GetCurrentMissionName()
    if currentMissionName==nil then
      return
    end
  end
  if mvars.bdf_stepList[gvars.bdf_currentStepNumber]==BStep_ClearStr then
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
    local CreateMessagesFunc=e.Messages
    if IsTypeFunc(CreateMessagesFunc)then
      local messageTable=CreateMessagesFunc(e)
      e._messageExecTable=Tpp.MakeMessageExecTable(messageTable)
    end
  end
end
function this.GetStepTable(stepNumber)
  if mvars.bdf_stepList==nil then
    return
  end
  local stepName=mvars.bdf_stepList[stepNumber]
  if stepName==nil then
    return
  end
  local stepTable=mvars.bdf_stepTable[stepName]
  if stepTable~=nil then
    return stepTable
  else
    return
  end
end
function this.GetBlockState()
  local blockId=ScriptBlock.GetScriptBlockId(base_defense_blockStr)
  if blockId==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(blockId)
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
function this.SetWaveIntervalTime(time)
  mvars.bdf_nextWaveWaitHour=time
end
function this.FinishWave()
  Player.ResetPadMask{settingName="BaseDiggingClearDefense"}
  for i,gameStatusName in ipairs(statusDisableOnReward)do
    TppGameStatus.Reset("BaseBaseDigging",gameStatusName)
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnFinishBaseDefense",TppUI.FADE_PRIORITY.MISSION)
end
function this._CheckUnloadBlock(timerName,msgName,DoOnUnloadFunc)
  local blockState=this.GetBlockState()
  if blockState==nil then
    if DoOnUnloadFunc and IsTypeFunc(DoOnUnloadFunc)then
      DoOnUnloadFunc()
    end
    Mission.SendMessage("Mission","OnBaseDefenseEnd")
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,msgName,TppUI.FADE_PRIORITY.MISSION)
    return
  end
  if blockState==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
    if DoOnUnloadFunc and IsTypeFunc(DoOnUnloadFunc)then
      DoOnUnloadFunc()
    end
    Mission.SendMessage("Mission","OnBaseDefenseEnd")
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,msgName,TppUI.FADE_PRIORITY.MISSION)
  else
    TimerStart(timerName,1)
  end
end
return this
