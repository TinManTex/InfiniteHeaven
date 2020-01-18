local this={}
local a={}
local r={}
local S=256
local c=0
local _=180
local StrCode32=Fox.StrCode32
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local StartTime=GkEventTimerManager.Start
local SVarsIsSynchronized=TppScriptVars.SVarsIsSynchronized
this.MISSION_PREPARE_STATE=Tpp.Enum{"START","WAIT_INITALIZE","WAIT_TEXTURE_LOADING","END_TEXTURE_LOADING","WAIT_SAVING_FILE","END_SAVING_FILE","FINISH"}
local function s(n)
  local e=mvars.seq_sequenceTable
  if e then
    return e[n]
  end
end
local function d(n)
  local e=mvars.seq_sequenceNames
  if e then
    return s(e[n])
  end
end
function this.RegisterSequences(n)
  if not IsTable(n)then
    return
  end
  local s=#n
  if s>(S-1)then
    return
  end
  local s={}
  mvars.seq_demoSequneceList={}
  for e=1,this.SYS_SEQUENCE_LENGTH do
    s[e]=r[e]
  end
  for t=1,#n do
    local e=this.SYS_SEQUENCE_LENGTH+t
    s[e]=n[t]
    local n=string.sub(n[t],5,8)
    if n=="Demo"then
      mvars.seq_demoSequneceList[e]=true
    end
    if(mvars.seq_heliStartSequence==nil)and(n=="Game")then
      mvars.seq_heliStartSequence=e
    end
  end
  mvars.seq_sequenceNames=Tpp.Enum(s)
end
function this.RegisterSequenceTable(e)
  if e==nil then
    return
  end
  mvars.seq_sequenceTable=Tpp.MergeTable(e,a,true)
  local s={}
  for t,n in ipairs(mvars.seq_sequenceNames)do
    if e[n]==nil then
      e[n]=s
    end
  end
end
function this.SetNextSequence(sequenceName,e)
  local sequenceId=nil
  if mvars.seq_sequenceNames then
    sequenceId=mvars.seq_sequenceNames[sequenceName]
  end
  if sequenceId==nil then
    return
  end
  local isExecMissionClear=false
  local isExecGameOver=false
  local isExecDemoPlaying=false
  local isExecMissionPrepare=true
  if e and IsTable(e)then
    isExecMissionClear=e.isExecMissionClear
    isExecGameOver=e.isExecGameOver
    isExecDemoPlaying=e.isExecDemoPlaying
    isExecMissionPrepare=e.isExecMissionPrepare
  end
  if TppMission.CheckMissionState(isExecMissionClear,isExecGameOver,isExecDemoPlaying,isExecMissionPrepare)then
    svars.seq_sequence=sequenceId
    return
  end
end
function this.ReserveNextSequence(s,n)
  TppScriptVars.SetSVarsNotificationEnabled(false)
  this.SetNextSequence(s,n)
  TppScriptVars.SetSVarsNotificationEnabled(true)
end
function this.GetCurrentSequenceIndex()
  return svars.seq_sequence
end
function this.GetSequenceIndex(n)
  local e=mvars.seq_sequenceNames
  if e then
    return e[n]
  end
end
function this.GetSequenceNameWithIndex(n)
  local e=mvars.seq_sequenceNames
  if e then
    local e=e[n]
    if e then
      return e
    end
  end
  return""end
local i=this.GetSequenceNameWithIndex
function this.GetCurrentSequenceName()
  if svars then
    return i(svars.seq_sequence)
  end
end
function this.GetMissionStartSequenceName()
  if mvars.seq_missionStartSequence then
    return i(mvars.seq_missionStartSequence)
  end
end
function this.GetMissionStartSequenceIndex()
  return mvars.seq_missionStartSequence
end
function this.GetContinueCount()
  local e=svars.seq_sequence
  return svars.seq_sequenceContinueCount[e]
end
function this.MakeSVarsTable(saveVarsList)
  local svarTable={}
  local e,t,t=1
  for name,value in pairs(saveVarsList)do
    local valueType=type(value)
    if valueType=="boolean"then
      svarTable[e]={name=name,type=TppScriptVars.TYPE_BOOL,value=value,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif valueType=="number"then
      svarTable[e]={name=name,type=TppScriptVars.TYPE_INT32,value=value,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif valueType=="string"then
      svarTable[e]={name=name,type=TppScriptVars.TYPE_UINT32,value=StrCode32(value),save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif valueType=="table"then
      svarTable[e]=value
    end
    e=e+1
  end
  return svarTable
end
local o=1
local s=6
local t=2
r={"Seq_Mission_Prepare"}
this.SYS_SEQUENCE_LENGTH=#r
a.Seq_Mission_Prepare={
  Messages=function(e)
    return Tpp.StrCode32Table{
      UI={
        {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()
          end,
          option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
        {msg="StartMissionTelopFadeIn",func=function()
          StartTime("Timer_HelicopterMoveStart",s)
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
        {msg="StartMissionTelopFadeOut",func=function()
          mvars.seq_nowWaitingStartMissionTelopFadeOut=nil
          e.FadeInStartOnGameStart()
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
        {msg="PushEndLoadingTips",func=function()
          mvars.seq_nowWaitingPushEndLoadingTips=nil
          StartTime("Timer_WaitStartingGame",1)
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}},
      Timer={
        {msg="Finish",sender="Timer_WaitStartingGame",func=e.MissionGameStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
        {msg="Finish",sender="Timer_HelicopterMoveStart",func=e.HelicopterMoveStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
        {msg="Finish",sender="Timer_FadeInStartOnNoTelopHelicopter",func=e.FadeInStartOnGameStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}}}
  end,
  OnEnter=function(n)
    mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_INITALIZE
    mvars.seq_textureLoadWaitStartTime=c
    mvars.seq_canMissionStartWaitStartTime=Time.GetRawElapsedTimeSinceStartUp()
    TppMain.OnEnterMissionPrepare()
    TppMain.DisablePause()
    if TppMission.IsFOBMission(vars.missionCode)==true then
      TppNetworkUtil.RequestGetFobServerParameter()
    end
  end,
  OnLeave=function(s,n)
    TppMain.OnMissionGameStart(n)
    this.DoOnEndMissionPrepareFunction()
    if this.IsFirstLandStart()then
      if not TppSave.IsReserveVarRestoreForContinue()then
        TppUiStatusManager.ClearStatus"AnnounceLog"
        TppUiStatusManager.SetStatus("AnnounceLog","SUSPEND_LOG")
        TppMission.UpdateCheckPointAtCurrentPosition()
      end
    end
  end,
  HelicopterMoveStart=function()
    if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
      TppHelicopter.SetRouteToHelicopterOnStartMission()
    end
  end,
  MissionGameStart=function()
    if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
      TppMain.DisableBlackLoading()
      this.SetMissionGameStartSequence()
    else
      if mvars.seq_isHelicopterStart then
        if mvars.seq_noMissionTelopOnHelicopter then
          a.Seq_Mission_Prepare.HelicopterMoveStart()StartTime("Timer_FadeInStartOnNoTelopHelicopter",t)
        else
          TppSoundDaemon.ResetMute"Loading"mvars.seq_nowWaitingStartMissionTelopFadeOut=true
          TppUI.StartMissionTelop()
        end
      else
        a.Seq_Mission_Prepare.FadeInStartOnGameStart()
      end
    end
  end,
  FadeInStartOnGameStart=function()
    TppMain.DisableBlackLoading()
    local n
    if mvars.seq_isHelicopterStart then
      TppSound.SetHelicopterStartSceneBGM()n=Tpp.GetHelicopterStartExceptGameStatus()
    else
      if TppMission.IsMissionStart()and(not TppMission.IsFreeMission(vars.missionCode))then
        n={AnnounceLog=false}
      end
    end
    this.SetMissionGameStartSequence()
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnGameStart",nil,{exceptGameStatus=n})
  end,
  SkipTextureLoadingWait=function()
    if mvars.seq_skipTextureLoadingWait then
      return true
    end
  end,
  DEBUG_TextPrint=function(n)
    local e=(nil).NewContext();(nil).Print(e,{.5,.5,1},n)
  end,
  OnUpdate=function(t)
    if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
      TppUI.ShowAccessIconContinue()
    end
    TppMission.ExecuteSystemCallback"OnUpdateWhileMissionPrepare"
    local r=30
    local d=.35
    local s=false
    local a=false
    local a=Mission.GetTextureLoadedRate()
    local u=TppMission.CanStart()
    local l=TppMotherBaseManagement.IsEndedSyncControl()
    if t.SkipTextureLoadingWait()then
      a=1
    end
    local c=0
    local t=r
    local i=Time.GetRawElapsedTimeSinceStartUp()
    local S=i-mvars.seq_canMissionStartWaitStartTime
    if(u==false)and(S>_)then
      if not mvars.seq_doneDumpCanMissionStartRefrainIds then
        mvars.seq_doneDumpCanMissionStartRefrainIds=true
      end
    end
    if not l then
      return
    end
    if(not TppMission.IsDefiniteMissionClear())then--RETAILPATCH: 1060 - check added
      TppTerminal.VarSaveMbMissionStartSyncEnd()
      TppSave.DoReservedSaveOnMissionStart()
    end
    if TppMission.IsFOBMission(vars.missionCode)==true then
      if TppNetworkUtil.IsRequestFobServerParameterBusy()then
        return
      end
    end
    if u then
      if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING)then
        mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING
        TppMain.OnTextureLoadingWaitStart()
        mvars.seq_textureLoadWaitStartTime=i
      end
      c=Time.GetRawElapsedTimeSinceStartUp()-mvars.seq_textureLoadWaitStartTime
      t=r-c
      if(a>d)or(t<0)then
        s=true
      end
      if mvars.seq_forceStopWhileNotPressedPad then
        s=DebugPad.IsScannedAorB()
        if s then
          mvars.seq_forceStopWhileNotPressedPad=false
        end
      end
    end
    if not s then
      return
    end
    if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
      mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_SAVING_FILE
      TppMain.OnMissionStartSaving()
    end
    if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.END_SAVING_FILE)then
      mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.END_SAVING_FILE
      if t<0 then
      end
      TppMain.OnMissionCanStart()
      if TppUiCommand.IsEndLoadingTips()then
        TppUI.FinishLoadingTips()StartTime("Timer_WaitStartingGame",o)
      else
        if gvars.waitLoadingTipsEnd then
          mvars.seq_nowWaitingPushEndLoadingTips=true
          TppUiCommand.PermitEndLoadingTips()
        else
          TppUI.FinishLoadingTips()StartTime("Timer_WaitStartingGame",o)
        end
      end
    end
  end}
function this.IsMissionPrepareFinished()
  if mvars.seq_missionPrepareState then
    if mvars.seq_missionPrepareState>=this.MISSION_PREPARE_STATE.FINISH then
      return true
    end
  end
  return false
end
function this.IsEndSaving()
  if mvars.seq_missionPrepareState then
    if mvars.seq_missionPrepareState>=this.MISSION_PREPARE_STATE.END_SAVING_FILE then
      return true
    end
  end
  return false
end
function this.SaveMissionStartSequence()
  local e=this.SYS_SEQUENCE_LENGTH+1
  mvars.seq_isHelicopterStart=false
  mvars.seq_missionStartSequence=e
  if svars.seq_sequence>e then
    mvars.seq_missionStartSequence=svars.seq_sequence
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    return
  end
  if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
    mvars.seq_isHelicopterStart=true
    if(mvars.seq_missionStartSequence<=e)then
      mvars.seq_missionStartSequence=mvars.seq_heliStartSequence
    else
      mvars.seq_noMissionTelopOnHelicopter=true
    end
  end
end
function this.SetMissionGameStartSequence()
  mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.FINISH
  svars.seq_sequence=mvars.seq_missionStartSequence
end
function this.SetOnEndMissionPrepareFunction(e)
  mvars.seq_onEndMissionPrepareFunction=e
end
function this.DoOnEndMissionPrepareFunction()
  if mvars.seq_onEndMissionPrepareFunction then
    mvars.seq_onEndMissionPrepareFunction()
  end
end
function this.IsHelicopterStart()
  return mvars.seq_isHelicopterStart
end
function this.IsFirstLandStart()
  if((not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(not mvars.seq_isHelicopterStart))and(mvars.seq_missionStartSequence==(this.SYS_SEQUENCE_LENGTH+1))then
    return true
  else
    return false
  end
end
function this.IsLandContinue()
  if((not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(not mvars.seq_isHelicopterStart))and(this.GetContinueCount()>0)then
    return true
  else
    return false
  end
end
function this.CanHandleSignInUserChangedException()
  if mvars==nil then
    return true
  end
  if mvars.seq_currentSequence==nil then
    return true
  end
  local e=mvars.seq_sequenceTable[mvars.seq_currentSequence]
  if e==nil then
    return true
  end
  if e.ignoreSignInUserChanged then
    return false
  else
    return true
  end
end
function this.IncrementContinueCount()
  local e=svars.seq_sequence
  local n=svars.seq_sequenceContinueCount[e]+1
  local s=255
  if n<=s then
    svars.seq_sequenceContinueCount[e]=n
  end
end
function this.DeclareSVars()
  return{
    {name="seq_sequence",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,notify=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="seq_sequenceContinueCount",arraySize=S,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="dbg_seq_sequenceName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.DEBUG_Init()
end
function this.Init(n)
  this.MakeSequenceMessageExecTable()svars.seq_sequence=this.GetSequenceIndex"Seq_Mission_Prepare"if n.sequence then
    if n.sequence.SKIP_TEXTURE_LOADING_WAIT then
      mvars.seq_skipTextureLoadingWait=true
    end
    if n.sequence.FORCE_STOP_MISSION_PREPARE_WHILE_NOT_PRESSED_PAD then
      mvars.seq_forceStopWhileNotPressedPad=true
    end
    if n.sequence.NO_MISSION_TELOP_ON_START_HELICOPTER then
      mvars.seq_noMissionTelopOnHelicopter=true
    end
  end
end
function this.OnReload()
  this.MakeSequenceMessageExecTable()
end
function this.MakeSequenceMessageExecTable()
  if not mvars.seq_sequenceTable then
    return
  end
  for n,e in pairs(mvars.seq_sequenceTable)do
    if e.Messages and IsFunc(e.Messages)then
      local e=e.Messages(e)
      mvars.seq_sequenceTable[n]._messageExecTable=Tpp.MakeMessageExecTable(e)
    end
  end
end
function this.OnChangeSVars(name,s)
  if name=="seq_sequence"then
    local s=d(svars.seq_sequence)
    if s==nil then
      return
    end
    local n=mvars.seq_sequenceTable[mvars.seq_currentSequence]
    if n and n.OnLeave then
      n.OnLeave(n,this.GetSequenceNameWithIndex(svars.seq_sequence))
    end
    mvars.seq_currentSequence=mvars.seq_sequenceNames[svars.seq_sequence]
    if s.OnEnter then
      local e
      s.OnEnter(s)
    end
  end
end
function this.OnMessage(o,s,i,a,r,n,t)
  if mvars.seq_sequenceTable==nil then
    return
  end
  local e=mvars.seq_sequenceTable[mvars.seq_currentSequence]
  if e==nil then
    return
  end
  local e=e._messageExecTable
  Tpp.DoMessage(e,TppMission.CheckMessageOption,o,s,i,a,r,n,t)
end
function this.Update()
  local e=mvars
  local n=svars
  if e.seq_currentSequence==nil then
    return
  end
  local e=e.seq_sequenceTable[e.seq_currentSequence]
  if e==nil then
    return
  end
  local n=e.OnUpdate
  if n then
    n(e)
  end
end
function this.DebugUpdate()
  local e=mvars
  local s=svars
  local n=(nil).NewContext()
  if e.debug.showCurrentSequence or e.debug.showSequenceHistory then
    if e.debug.showCurrentSequence then(nil).Print(n,{.5,.5,1},"LuaSystem SEQ.showCurrSequence");(nil).Print(n," current_sequence = "..tostring(i(s.seq_sequence)))
    end
    if e.debug.showSequenceHistory then(nil).Print(n,{.5,.5,1},"LuaSystem SEQ.showSeqHistory")
      for s,e in ipairs(e.debug.seq_sequenceHistory)do(nil).Print(n," seq["..(tostring(s)..("] = "..tostring(e))))
      end
    end
  end
end
return this
