local this={}
local _=256
local o=0
local c=1
local s=0
local i="flag_mission_block"
local r="FStep_Clear"
local p=Fox.StrCode32
local m=Tpp.StrCode32Table
local a=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local u=Tpp.IsTypeString
local l=GkEventTimerManager.Start
local S={name="fms_systemFlags",arraySize=4,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}
local f=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}
local d=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}
if not Tpp.IsMaster()then
  this.DEBUG_OnRestoreFvarsCallback={}
end
function this.RegisterStepList(e)
  if not t(e)then
    return
  end
  local n=#e
  if n==0 then
    return
  end
  if n>=_ then
    return
  end
  table.insert(e,r)
  mvars.fms_stepList=Tpp.Enum(e)
end
function this.RegisterStepTable(n)
  if not t(n)then
    return
  end
  this.RegisterResultStepTable(n)
  mvars.fms_stepTable=n
end
local n=function()
  if TppRadioCommand.IsPlayingRadio()then
    GkEventTimerManager.Start("SsdFlagMission_Clear",1)
  elseif not mvars.fms_clearStepFinished then
    this.FadeOutAndResult()
    mvars.fms_clearStepFinished=true
  end
end
function this.RegisterResultStepTable(a)a[r]={
  Messages=function(a)
    return m{
      Timer={{sender="SsdFlagMission_Clear",msg="Finish",func=n,option={isExecFastTravel=true}}},
      UI={{msg="BaseResultUiSequenceDaemonEnd",func=function()
        if mvars.fms_isReservedBaseResultStarted then
          mvars.fms_isReservedBaseResultStarted=nil
          this.OnEndResult()
        end
      end}}}
  end,
  OnEnter=function()
    TppGameStatus.Set("FmsResult","S_DISABLE_PLAYER_PAD")
    TppRadio.Stop()
    if mvars.fms_clearState==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR then
      if mvars.fms_blackRadioOnEnd then
        BlackRadio.Close()
        BlackRadio.ReadJsonParameter(mvars.fms_blackRadioOnEnd)
      end
      Player.SetPadMask{settingName="OnFlagMissionClear",except=true,sticks=PlayerPad.STICK_R}
      mvars.fms_clearStepFinished=nil
      n()
    else
      this.FadeOutAndUnloadBlock()
    end
  end,
  OnLeave=function()
  end}
end
function this.RegisterSystemCallbacks(n)
  if not t(n)then
    return
  end
  mvars.fms_systemCallbacks=mvars.fms_systemCallbacks or{}
  local function t(n,e)
    if a(n[e])then
      mvars.fms_systemCallbacks[e]=n[e]
    end
  end
  local e={"OnActivate","OnDeactivate","OnTerminate","OnAlertOutOfDefenseGameArea","OnOutOfDefenseGameArea"}
  for a=1,#e do
    t(n,e[a])
  end
end
function this.SetNextStep(t)
  if not mvars.fms_stepTable then
    return
  end
  if not mvars.fms_stepList then
    return
  end
  local s=mvars.fms_stepTable[t]
  local n=mvars.fms_stepList[t]
  if s==nil then
    return
  end
  if n==nil then
    return
  end
  local i=gvars.fms_currentFlagStepNumber
  if((n~=c)and(i~=n))and this.IsInvoking()then
    local n=this.GetFlagStepTable(i)
    local e=n.OnLeave
    if a(e)then
      e(n)
    end
  end
  gvars.fms_currentFlagStepNumber=n
  local n=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
  local n=this.GetBlockState()
  if mvars.fms_allocated then
    local e=s.OnEnter
    if a(e)then
      e(s)
    end
  end
  if Tpp.IsQARelease()or nil then
    Mission.SetMiniText(1,"fmis:"..this.GetCurrentFlagMissionName())
    Mission.SetMiniText(2,"step:"..t)
  end
end
function this.ClearWithSave(a,n)
  if not n then
    n=this.GetCurrentFlagMissionName()
  end
  PlayRecord.RegistPlayRecord"FLAG_MISSION_END"
  this._EstablishMissionClear(a)
  if a==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR then
    this.Clear(n)
    this.Save()
  elseif a==TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE then
    this.Failure(n)
    this.Save()
  end
  TppStory.UpdateStorySequence{updateTiming="FlagMissionEnd"}
  TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.FLAG_MISSION_END)
end
function this.Clear(n)
  if n==nil then
    n=this.GetCurrentFlagMissionName()
    if n==nil then
      return
    end
  end
  local a=this.GetMissionIndex(n)
  if a==nil then
    return
  end
  TppResult.SetMissionFinalScore(TppDefine.MISSION_TYPE.FLAG)
  mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR
  this.SetNextStep(r)
  this.ShowAnnounceLog(d.CLEAR,n)
  this.CheckClearBounus(a,n)
  this.UpdateClearFlag(a,true)
  this.GetClearKeyItem(n)SsdMarker.UnregisterMarker{type="USER_001"}
end
function this.Failure(n)
  if n==nil then
    n=this.GetCurrentFlagMissionName()
    if n==nil then
      return
    end
  end
  local a=this.GetMissionIndex(n)
  if a==nil then
    return
  end
  mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE
  this.UpdateClearFlag(a,false)
  this.SetNextStep(r)
  this.ShowAnnounceLog(d.FAILURE,n)
end
function this._EstablishMissionClear(e)
  if e==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR then
    fvars.fms_systemFlags[0]=true
    fvars.fms_systemFlags[1]=true
    TppMission.ResetGameOverCount()
  else
    fvars.fms_systemFlags[0]=true
    fvars.fms_systemFlags[1]=false
  end
end
function this.Abort()
  local n=this.GetCurrentFlagMissionName()
  if not n then
    return
  end
  local n=this.GetMissionIndex(n)
  if n==nil then
    return
  end
  this.UpdateClearFlag(n,false)
  this.Save()
  this.UnloadFlagMissionBlock()
end
function this.DeclareFVars(e)
  if not t(e)then
  end
  table.insert(e,1,S)
  TppScriptVars.DeclareFVars(e)
  Mission.RegisterUserFvars()
  mvars.fms_delaredFVarsList=e
end
function this.Save()
  TppSave.VarSave()
  TppSave.SaveGameData(vars.missionCode)
end
function this.SetClearFlag(e)
  if e==nil then
    return
  end
  local e=string.sub(e,-5)
  local e=SsdMissionList.MISSION_ENUM[e]
  if e and gvars.str_missionClearedFlag[e]then
    gvars.str_missionClearedFlag[e]=true
  end
end
function this.FadeOutAndUnloadBlock(e)
  if e==nil or e==0 then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutAndUnload",TppUI.FADE_PRIORITY.RESULT)
  else
    l("UnloadFadeOutDelay",e)
  end
end
function this.FadeOutAndResult(e)
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutAndResult",TppUI.FADE_PRIORITY.RESULT)
end
function this.IsClearState()
  if not mvars.fms_stepList then
    return false
  end
  local e=mvars.fms_stepList[r]
  if e==nil then
    return false
  end
  if gvars.fms_currentFlagStepNumber==e then
    return true
  end
  return false
end
function this.IsCurrentStepWaveName(n)
  local e=this.GetFlagStepTable(this.GetCurrentStepIndex())
  if not e then
    return
  end
  if(e.waveName==n)then
    return true
  else
    return false
  end
end
function this.OnAllocate(e)
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
end
function this.OnEndResult()
  TppRadio.Stop()
  if mvars.fms_blackRadioOnEnd then
    l("Timer_WaitBlackRadio",1)
  elseif mvars.fms_releaseAnnouncePopup then
    ReleaseAnnouncePopupSystem.RequestOpen()
  elseif BaseResultUiSequenceDaemon.IsActive()then
    mvars.fms_isReservedBaseResultStarted=true
    BaseResultUiSequenceDaemon.SetReserved(false)
  else
    TppSoundDaemon.SetMute"Loading"
    this.UnloadFlagMissionBlock()
    l("Timer_CheckUnload",1)
  end
end
function this.Messages()
  return m{
    UI={
      {msg="EndFadeOut",sender="FlagFadeOutAndUnload",func=function()
        this.UnloadFlagMissionBlock()
        l("Timer_CheckUnload",1)
      end,option={isExecFastTravel=true}},
      {msg="EndFadeOut",sender="FlagFadeOutAndResult",func=function()
        TppCrew.FinishFlagMission(gvars.fms_currentFlagMissionCode)
        if mvars.fms_resultRadio then
          TppRadio.PlayResultRadio(this.OnEndResult)
        else
          this.OnEndResult()
        end
      end,option={isExecFastTravel=true}},
      {msg="EndFadeOut",sender="FlagFadeOutForRestart",func=function()
        this.UnloadFlagMissionBlock()
        l("Timer_CheckRestart",1)
      end,option={isExecFastTravel=true}},
      {msg="BlackRadioClosed",func=function(n)
        if not u(mvars.fms_blackRadioOnEnd)or n~=p(mvars.fms_blackRadioOnEnd)then
          return
        end
        mvars.fms_blackRadioOnEnd=this.GetNextBlackRadioEndSetting()
        if mvars.fms_blackRadioOnEnd then
          BlackRadio.Close()
          BlackRadio.ReadJsonParameter(mvars.fms_blackRadioOnEnd)
        else
          TppSoundDaemon.SetKeepBlackRadioEnable(false)
        end
        this.OnEndResult()
      end},
      {msg="ReleaseAnnouncePopupPushEnd",func=function()
        if not mvars.fms_releaseAnnouncePopup then
          return
        end
        mvars.fms_releaseAnnouncePopup=nil
        this.OnEndResult()
      end}}
    ,Marker={
      {msg="ChangeToEnable",func=function(t,s,a,n)
        this._ChangeToEnable(t,s,a,n)
      end}},
    Timer={
      {msg="Finish",sender="UnloadFadeOutDelay",func=function()
        TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutAndUnload",TppUI.FADE_PRIORITY.FLAG)
      end,option={isExecFastTravel=true}},
      {msg="Finish",sender="Timer_CheckUnload",func=function()
        local n=function()
          SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
          mvars.bfm_needSaveForMissionStart=true
        end
        this._CheckUnloadBlock("Timer_CheckUnload","FlagMissionEnd",n)
      end},
      {msg="Finish",sender="Timer_CheckRestart",func=function()
        local n=function()SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
          this.SelectAndLoadMission(mvars.fms_reloadMissionName)
          this.Activate()
          mvars.fms_reloadMissionName=nil
        end
        this._CheckUnloadBlock("Timer_CheckRestart","FlagMissionRestart",n)
      end},
      {msg="Finish",sender="Timer_WaitBlackRadio",func=function(n)
        if not mvars.fms_blackRadioOnEnd then
          this.OnEndResult()
          TppSoundDaemon.SetKeepBlackRadioEnable(false)
          return
        end
        TppRadio.StartBlackRadio()
        TppSoundDaemon.SetKeepBlackRadioEnable(true)
      end,option={isExecFastTravel=true}}}}
end
function this._CheckUnloadBlock(t,s,n)
  local e=this.GetBlockState()
  if e==nil then
    if n and a(n)then
      n()
    end
    Mission.SendMessage("Mission","OnFlagMissionUnloaded")
    return
  end
  if e==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
    if n and a(n)then
      n()
    end
    Mission.SendMessage("Mission","OnFlagMissionUnloaded")
  else
    l(t,1)
  end
end
function this.OnMessage(n,a,t,s,i,l,r)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,n,a,t,s,i,l,r)
end
function this.OnSubScriptMessage(r,s,l,i,n,a,t)
  local o=mvars.fms_scriptBlockCommonMessageExecTable
  if o then
    local e=t
    Tpp.DoMessage(o,TppMission.CheckMessageOption,r,s,l,i,n,a,e)
  end
  local o=mvars.fms_scriptBlockMessageExecTable
  if o then
    local e=t
    Tpp.DoMessage(o,TppMission.CheckMessageOption,r,s,l,i,n,a,e)
  end
  if this.IsInvoking()and mvars.fms_stepList then
    local o=gvars.fms_currentFlagStepNumber
    local e=this.GetFlagStepTable(o)
    if e then
      local o=e._commonMessageExecTable
      if o then
        local e=t
        Tpp.DoMessage(o,TppMission.CheckMessageOption,r,s,l,i,n,a,e)
      end
      local e=e._messageExecTable
      if e then
        local t=t
        Tpp.DoMessage(e,TppMission.CheckMessageOption,r,s,l,i,n,a,t)
      end
    end
  end
end
function this.OnDeactivate(e)
end
function this.InitializePackList(locationName)
  mvars.loadedInfoList={}
  local n={}
  local FLAG_MISSION_LIST=SsdMissionList.FLAG_MISSION_LIST
  for i=1,#FLAG_MISSION_LIST do
    local e=FLAG_MISSION_LIST[i]
    if e.location==locationName then
      n[e.name]={}
      table.insert(mvars.loadedInfoList,e)
      table.insert(n[e.name],e.pack)
    end
  end
  TppScriptBlock.RegisterCommonBlockPackList(i,n)
end
function this.InitializeActiveStatus()
  local n=this.GetBlockState()
  if n==nil then
    return
  end
  if n==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY then
    return
  end
  mvars.fms_requestInitializeActiveStatus=false
  if n<ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE or not this._CanActivate()then
    mvars.fms_requestInitializeActiveStatus=true
    return
  end
  this.Invoke()
end
function this.InitializeMissionLoad()
  if gvars.fms_currentFlagMissionCode==s then
    return
  end
  local n=this.GetBlockState()
  if not n then
    return
  end
  local n="k"..tostring(gvars.fms_currentFlagMissionCode)
  this.LoadMission(n)
end
function this.IsEstablishedMissionClear()
  if gvars.fms_currentFlagMissionCode==s then
    return false
  end
  local e=this.GetBlockState()
  if not e then
    return false
  end
  return(mvars.fms_clearState==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR)
end
function this.QARELEASE_DEBUG_Init()
  local e
  if DebugMenu then
    e=DebugMenu
  else
    return
  end
  mvars.qaDebug.historyFmsStep={}
  mvars.qaDebug.prevFmsViewMarkerFlag=false
  mvars.qaDebug.showCurrentFmsState=false
  e.AddDebugMenu("LuaFlagMission","showCurrentState","bool",mvars.qaDebug,"showCurrentFmsState")
  mvars.qaDebug.forceFmsClear=false
  e.AddDebugMenu("LuaFlagMission","forceClear","bool",mvars.qaDebug,"forceFmsClear")
  mvars.qaDebug.forceFmsFail=false
  e.AddDebugMenu("LuaFlagMission","forceFail","bool",mvars.qaDebug,"forceFmsFail")
  mvars.qaDebug.forceFmsLoad=false
  e.AddDebugMenu("LuaFlagMission","forceLoad","bool",mvars.qaDebug,"forceFmsLoad")
  mvars.qaDebug.forceFmsLoadIndex=0
  e.AddDebugMenu("LuaFlagMission","forceLoadIndex","int32",mvars.qaDebug,"forceFmsLoadIndex")
  mvars.qaDebug.forceFmsRestart=false
  e.AddDebugMenu("LuaFlagMission","forceRestart","bool",mvars.qaDebug,"forceFmsRestart")
  mvars.qaDebug.forceFmsViewMarker=false
  e.AddDebugMenu("LuaFlagMission","viewMarker","bool",mvars.qaDebug,"forceFmsViewMarker")
  mvars.qaDebug.bfmShowCraftStep=false
  e.AddDebugMenu("LuaFlagMission","showCraftStep","bool",mvars.qaDebug,"bfmShowCraftStep")
  mvars.qaDebug.bfmShowKillCount=false
  e.AddDebugMenu("LuaFlagMission","showKillCount","bool",mvars.qaDebug,"bfmShowKillCount")
end
function this.QAReleaseDebugUpdate()
  local a=DebugText.Print
  local n=DebugText.NewContext()
  local t=SsdMissionList.FLAG_MISSION_LIST
  local s=#t
  do
    if s==0 then
      mvars.qaDebug.forceFmsLoadIndex=0
    elseif mvars.qaDebug.forceFmsLoadIndex<0 then
      mvars.qaDebug.forceFmsLoadIndex=s
    elseif mvars.qaDebug.forceFmsLoadIndex>s then
      mvars.qaDebug.forceFmsLoadIndex=0
    end
  end
  if mvars.qaDebug.forceFmsClear then
    mvars.qaDebug.forceFmsClear=false
    local n=this.GetCurrentFlagMissionName()
    if n then
      this.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR,n)
    end
  end
  if mvars.qaDebug.forceFmsFail then
    mvars.qaDebug.forceFmsFail=false
    local n=this.GetCurrentFlagMissionName()
    if n then
      this.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE,n)
    end
  end
  if mvars.qaDebug.showCurrentFmsState then
    a(n,"")a(n,{.5,.5,1},"FlagMission showCurrentState")
    local s=this.GetCurrentFlagMissionName()
    if not s then
      a(n,"Current Mission : -----")
    else
      a(n,"Current Mission : "..tostring(s))
    end
    local s=this.GetBlockState()
    if s==nil then
      a(n,"Block State : FLAG MISSION BLOCK isn't found...")
      return
    end
    local e={}
    e[ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY]="EMPTY"
    e[ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING]="PROCESSING"
    e[ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE]="INACTIVE"
    e[ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE]="ACTIVE"
    a(n,"Block State : "..tostring(e[s]))
    a(n,"gvars.fms_currentFlagMissionCode : "..tostring(gvars.fms_currentFlagMissionCode))
    a(n,"gvars.fms_currentFlagStepNumber : "..tostring(gvars.fms_currentFlagStepNumber))
    if not mvars.fms_stepList then
      a(n,"Sequence is not Defined...")
    else
      local e=gvars.fms_currentFlagStepNumber
      local e=mvars.fms_stepList[e]a(n,"Current Sequence : "..tostring(e))
    end
    if mvars.qaDebug.forceFmsLoadIndex==0 then
      a(n,"Selected Mission : -----")
    else
      local e=t[mvars.qaDebug.forceFmsLoadIndex]
      if e then
        a(n,"Selected Mission : "..tostring(e.name))
      end
    end
  end
  if mvars.qaDebug.forceFmsLoad then
    local n=mvars.qaDebug.forceFmsLoadIndex
    mvars.qaDebug.forceFmsLoadIndex=0
    mvars.qaDebug.forceFmsLoad=false
    if n==0 then
      return
    end
    local n=t[n]
    if not n then
      return
    else
      this.SelectAndLoadMission(n.name)
      this.Activate()
    end
  end
  if mvars.qaDebug.forceFmsRestart then
    mvars.qaDebug.forceFmsRestart=false
    this.RestartMission()
  end
  if mvars.qaDebug.forceFmsViewMarker~=mvars.qaDebug.prevFmsViewMarkerFlag then
    local n=mvars.qaDebug.forceFmsViewMarker
    local e=mvars.mar_missionMarkerList
    if e and next(e)then
      if n then
        for n,e in ipairs(e)do
          SsdMarker.Enable{gameObjectId=e,enable=true}
        end
      else
        for n,e in ipairs(e)do
          SsdMarker.Enable{gameObjectId=e,enable=false}
        end
      end
    end
  end
  mvars.qaDebug.prevFmsViewMarkerFlag=mvars.qaDebug.forceFmsViewMarker
end
function this.ShowAnnounceLogMissionOpen()
  if mvars.fms_isNewOpenFlag==true then
    mvars.fms_isNewOpenFlag=false
    this.ShowAnnounceLog(d.OPEN)
  end
end
function this.OnInitialize(n)
  local s=n.GetCommonMessageTable
  if a(s)then
    local e=s()
    if t(e)and next(e)then
      mvars.fms_scriptBlockCommonMessageExecTable=Tpp.MakeMessageExecTable(e)
    end
  end
  local s=n.Messages
  if a(s)then
    local e=s()
    if t(e)and next(e)then
      mvars.fms_scriptBlockMessageExecTable=Tpp.MakeMessageExecTable(e)
    end
  end
  this.MakeFlagStepMessageExecTable()
  if n.score and n.score.missionScoreTable then
    TppResult.SetMissionScoreTable(n.score.missionScoreTable)
  else
    TppResult.SetMissionScoreTable{baseTime={S=300,A=600,B=1800,C=5580,D=6480,E=8280}}
  end
  if n.clearRadio then
    mvars.fms_clearRadio=n.clearRadio
  end
  mvars.fms_resultRadio=nil
  if n.resultRadio then
    mvars.fms_resultRadio=n.resultRadio
    TppRadio.SetIndivResultRadioSetting(n.resultRadio)
  end
  mvars.fms_blackRadioOnEnd=nil
  mvars.fms_blackRadioOnEndSetting={}
  if n.blackRadioOnEnd then
    if u(n.blackRadioOnEnd)then
      mvars.fms_blackRadioOnEndSetting={n.blackRadioOnEnd}
    elseif t(n.blackRadioOnEnd)then
      mvars.fms_blackRadioOnEndSetting=n.blackRadioOnEnd
    end
    mvars.fms_blackRadioOnEnd=this.GetNextBlackRadioEndSetting()
  end
  mvars.fms_releaseAnnouncePopup=nil
  if n.releaseAnnounce and t(n.releaseAnnounce)then
    mvars.fms_releaseAnnouncePopup=n.releaseAnnounce
    ReleaseAnnouncePopupSystem.SetInfos(mvars.fms_releaseAnnouncePopup)
  end
  this._ResetFlagMissionInfo(n)
  this._LoadVars()SsdUiSystem.FlagMissionDidStart()
  if this.IsEstablishedMissionClear()then
    TppGameStatus.Set("FmsResult","S_DISABLE_PLAYER_PAD")
  end
  mvars.fms_skipServerSave=nil
  if n.SKIP_SERVER_SAVE then
    mvars.fms_skipServerSave=true
  end
  if a(n.OnRestoreFVars)then
    n.OnRestoreFVars()
  end
  TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_START)
end
function this._ResetFlagMissionInfo(n)
  local a=this.GetCurrentFlagMissionName()
  if not a then
    local n=n.missionName
    if n then
      this.SetCurrentFlagMissionName(n)
      mvars.fms_currentFlagTable=this.GetMissionTable(n)
    end
  end
end
function this._LoadVars()
  if mvars.fms_startFromSelect then
    if not Tpp.IsMaster()then
      this.DEBUG_ExecOnRestoreFvars()
    end
    return
  end
  if gvars.fms_currentFlagMissionCode==40270 then
    return
  end
  TppScriptVars.LoadVarsFromSlot(TppDefine.SAVE_SLOT.CHECK_POINT,TppScriptVars.GROUP_BIT_FVARS,TppScriptVars.CATEGORY_MISSION)
  TppSave.RestoreToVars(TppScriptVars.GROUP_BIT_FVARS)
  if fvars.fms_systemFlags[0]then
    if fvars.fms_systemFlags[1]then
      mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR
    else
      mvars.fms_clearState=TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE
    end
  end
  if not Tpp.IsMaster()then
    this.DEBUG_ExecOnRestoreFvars()
  end
end
function this.OnTerminate()
  this.ExecuteSystemCallback"OnTerminate"
  if(mvars.fms_clearState==TppDefine.FLAG_MISSION_CLEAR_TYPE.CLEAR)then
    TppPlayer.ResetPlayerForReturnBaseCamp()
  end
  Gimmick.RemoveUnitInterferer{key="flagMission"}
  gvars.fms_currentFlagStepNumber=o
  mvars.fms_systemCallbacks=nil
  mvars.fms_lastBlockState=nil
  mvars.fms_stepList=nil
  mvars.fms_stepTable=nil
  mvars.fms_currentFlagTable=nil
  mvars.fms_startFromSelect=nil
  mvars.fms_clearState=nil
  mvars.fms_skipServerSave=nil
  mvars.fms_scriptBlockCommonMessageExecTable=nil
  mvars.fms_scriptBlockMessageExecTable=nil
  mvars.fms_resultRadio=nil
  mvars.fms_blackRadioOnEnd=nil
  mvars.fms_blackRadioOnEndSetting={}
  mvars.fms_releaseAnnouncePopup=nil
  mvars.fms_isReservedBaseResultStarted=nil
  mvars.fms_delaredFVarsList=nil
  this.ClearCurrentFlagMissionName()
  local e=ScriptBlock.GetScriptBlockId(i)
  TppScriptBlock.FinalizeScriptBlockState(e)
  TppGameStatus.Reset("FmsResult","S_DISABLE_PLAYER_PAD")
  Mission.ResetFVarsList()
  MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)
  TppRadio.ResetIndivResultRadioSetting()
  TppTutorial.ResetHelpTipsSettings()
  SsdUiSystem.FlagMissionWillFinish()
  TppMission.OnEndDefenseGame()
  TppQuest.UnregisterSkipStartQuestDemo()
  if Tpp.IsQARelease()or nil then
    Mission.SetMiniText(1,"")
    Mission.SetMiniText(2,"")
  end
end
function this._CanActivate()
  if CrewBlockController and CrewBlockController.IsProcessing()then
    return false
  end
  if not TppSequence.IsMissionPrepareFinished()then
    return false
  end
  if not mvars.fms_activateFlag then
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
  local r=n.fms_lastBlockState
  local i=t.SCRIPT_BLOCK_STATE_INACTIVE
  local t=t.SCRIPT_BLOCK_STATE_ACTIVE
  if n.fms_requestInitializeActiveStatus then
    this.InitializeActiveStatus()
    return
  end
  if s==i then
    if this._CanActivate()then
      this.ActivateFlagMissionBlock()
      this.ClearBlockStateRequest()
    end
    n.fms_lastInactiveToActive=false
  elseif s==t then
    if not this._CanActivate()then
      return
    end
    local t
    if this.IsInvoking()then
      t=this.GetFlagStepTable(gvars.fms_currentFlagStepNumber)
    end
    if n.fms_lastInactiveToActive then
      n.fms_lastInactiveToActive=false
      n.fms_deactivated=false
      this.ExecuteSystemCallback"OnActivate"n.fms_allocated=true
      this.Invoke()t=this.GetFlagStepTable(gvars.fms_currentFlagStepNumber)
    end
    if(not r)or r<=i then
      n.fms_lastInactiveToActive=true
    end
    if t and a(t.OnUpdate)then
      t.OnUpdate(t)
    end
    if n.fms_blockStateRequest==f.DEACTIVATE then
      this.DeactivateFlagMissionBlock()
      this.ClearBlockStateRequest()
    end
  else
    n.fms_lastInactiveToActive=false
    this.ClearBlockStateRequest()
  end
  n.fms_lastBlockState=s
end
function this.OnMissionGameEnd()
  local n=this.GetBlockState()
  mvars.fms_isMissionEnd=true
  if n==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    this._DoDeactivate()
  end
end
function this.ClearBlockStateRequest()
  mvars.fms_blockStateRequest=f.NONE
end
function this.Invoke()
  if gvars.fms_currentFlagStepNumber==o then
    gvars.fms_currentFlagStepNumber=c
  end
  local n=mvars.fms_stepList[gvars.fms_currentFlagStepNumber]
  this.SetNextStep(n)
  if mvars.fms_startFromSelect then
    PlayRecord.RegistPlayRecord"FLAG_MISSION_START"
  else
    PlayRecord.RegistPlayRecord"FLAG_MISSION_CONTINUE"
  end
end
function this.SelectAndLoadMission(n)
  this.ResetFlagMissionStatus()
  this.LoadMission(n)
  mvars.fms_startFromSelect=true
end
function this.LoadMission(n)
  local a=TppScriptBlock.Load(i,n)
  if a==false then
    return
  end
  this.SetCurrentFlagMissionName(n)
  mvars.fms_currentFlagTable=this.GetMissionTable(n)
  local e=gvars.fms_currentFlagMissionCode
  MissionListMenuSystem.SetCurrentMissionCode(e)
  TppCrew.StartFlagMission(e)
  mvars.fms_activateFlag=false
end
function this.IsLoaded()
  if gvars.fms_currentFlagMissionCode==s then
    return true
  end
  local e=this.GetBlockState()
  if not e then
    return true
  end
  if e>=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
    return true
  end
  return false
end
function this.Activate()
  if gvars.fms_currentFlagMissionCode==s then
    return
  end
  local e=this.GetBlockState()
  if not e then
    return
  end
  mvars.fms_activateFlag=true
end
function this.IsActive()
  if gvars.fms_currentFlagMissionCode==s then
    return false
  end
  local e=this.GetBlockState()
  if not e then
    return false
  end
  if e==ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
    return true
  end
  return false
end
function this.RestartMission()
  mvars.fms_reloadMissionName=mvars.fms_currentFlagName
  if not mvars.fms_reloadMissionName then
    return
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FlagFadeOutForRestart",TppUI.FADE_PRIORITY.FLAG)
end
function this.GetCurrentFlagMissionName()
  return mvars.fms_currentFlagName
end
function this.SetCurrentFlagMissionName(e)
  mvars.fms_currentFlagName=e
  gvars.fms_currentFlagMissionCode=tonumber(string.sub(e,-5))
end
function this.ClearCurrentFlagMissionName()
  mvars.fms_currentFlagName=nil
  gvars.fms_currentFlagMissionCode=s
end
function this.ResetFlagMissionStatus()
  gvars.fms_currentFlagMissionCode=s
  gvars.fms_currentFlagStepNumber=o
end
function this.UnloadFlagMissionBlock()
  TppScriptBlock.Unload(i)
end
function this.ActivateFlagMissionBlock()
  local e=ScriptBlock.GetScriptBlockId(i)
  TppScriptBlock.ActivateScriptBlockState(e)
end
function this.DeactivateFlagMissionBlock()
  local e=ScriptBlock.GetScriptBlockId(i)
  TppScriptBlock.DeactivateScriptBlockState(e)
end
function this.GetCurrentMissionTable()
  return mvars.fms_currentFlagTable
end
function this.GetMissionTable(n)
  if not mvars.loadedInfoList then
    return
  end
  for e=1,#mvars.loadedInfoList do
    local e=mvars.loadedInfoList[e]
    if e.name==n then
      return e
    end
  end
end
function this.GetMissionIndex(e)
  local e=string.sub(e,-5)
  local e=SsdMissionList.MISSION_ENUM[e]
  if e then
    return e
  end
end
function this.ExecuteSystemCallback(e,n)
  if mvars.fms_systemCallbacks==nil then
    return
  end
  local e=mvars.fms_systemCallbacks[e]
  if e then
    return e(n)
  end
end
function this.IsInvoking()
  if gvars.fms_currentFlagStepNumber~=o then
    return true
  else
    return false
  end
end
function this.UpdateActiveFlagMission(e)
end
function this.IsRepop(e)
end
function this.IsOpen(e)
end
function this.IsCleared(n)
  local e=this.GetMissionIndex(n)
  if e==nil then
    return
  end
  return gvars.str_missionClearedFlag[e]
end
function this.IsEnd(n)
  if n==nil then
    n=this.GetCurrentFlagMissionName()
    if n==nil then
      return
    end
  end
  if mvars.fms_stepList[gvars.fms_currentFlagStepNumber]==r then
    return true
  end
  return false
end
function this._DoDeactivate()
  mvars.fms_deactivated=true
  this.ExecuteSystemCallback"OnDeactivate"
  TppScriptVars.ClearFVars()
  this.ResetFlagMissionStatus()
  mvars.fms_allocated=false
end
function this.MakeFlagStepMessageExecTable()
  if not t(mvars.fms_stepTable)then
    return
  end
  for n,e in pairs(mvars.fms_stepTable)do
    local n=e.GetCommonMessageTable
    if a(n)then
      local n=n(e)
      if t(n)and next(n)then
        e._commonMessageExecTable=Tpp.MakeMessageExecTable(n)
      end
    end
    local n=e.Messages
    if a(n)then
      local n=n(e)
      if t(n)and next(n)then
        e._messageExecTable=Tpp.MakeMessageExecTable(n)
      end
    end
  end
end
function this.GetFlagStepTable(e)
  if mvars.fms_stepList==nil then
    return
  end
  local e=mvars.fms_stepList[e]
  if e==nil then
    return
  end
  local e=mvars.fms_stepTable[e]
  if e~=nil then
    return e
  else
    return
  end
end
function this.GetBlockState()
  local e=ScriptBlock.GetScriptBlockId(i)
  if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(e)
end
function this.CheckClearBounus(e,e)
end
function this.UpdateClearFlag(e,n)
  if n then
    gvars.str_missionClearedFlag[e]=true
  end
end
function this.GetClearKeyItem(e)
end
function this.ShowAnnounceLog(e,e,e,e)
end
function this._ChangeToEnable(e,e,e,e)
end
function this.OverWriteStepIndex(e)
  gvars.fms_currentFlagStepNumber=e
end
function this.GetCurrentStepIndex()
  return gvars.fms_currentFlagStepNumber
end
function this.GetCurrentStepName()
  return mvars.fms_stepList[this.GetCurrentStepIndex()]
end
function this.GetStepName(e)
  return mvars.fms_stepList[e]
end
function this.GetStepIndex(e)
  return mvars.fms_stepList[e]
end
function this.InitFVars()
  if not t(mvars.fms_delaredFVarsList)then
    return
  end
  for n,e in ipairs(mvars.fms_delaredFVarsList)do
    local a,e,n=e.name,e.arraySize,e.value
    if e and(e>1)then
      for e=0,(e-1)do
        fvars[a][e]=n
      end
    else
      fvars[a]=n
    end
  end
end
function this.SetClearJingleName(e)
  mvars.fms_clearJingleName=e
end
function this.OverwriteResultRadioSetting(n)
  if this.IsClearState()then
    return
  end
  TppRadio.ResetIndivResultRadioSetting()
  mvars.fms_resultRadio=n
  TppRadio.SetIndivResultRadioSetting(n)
end
function this.GetNextBlackRadioEndSetting()
  if not mvars.fms_blackRadioOnEndSetting then
    return
  end
  if not next(mvars.fms_blackRadioOnEndSetting)then
    return
  end
  local e=mvars.fms_blackRadioOnEndSetting[1]
  if not e then
    return
  end
  table.remove(mvars.fms_blackRadioOnEndSetting,1)
  return e
end
if not Tpp.IsMaster()then
  function this.DEBUG_AddCallbackOnRestoreFvars(n)
    if a(n)then
      table.insert(this.DEBUG_OnRestoreFvarsCallback,n)
    end
  end
  function this.DEBUG_ExecOnRestoreFvars()
    for t,n in ipairs(this.DEBUG_OnRestoreFvarsCallback)do
      if a(n)then
        n()
      end
    end
    this.DEBUG_OnRestoreFvarsCallback={}
  end
end
return this
