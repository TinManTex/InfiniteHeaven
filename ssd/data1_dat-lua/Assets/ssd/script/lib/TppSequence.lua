-- ssd TppSequence.lua
local this={}
local a={}
local r={}
local _=256
local c=0
local S=180
local n=60
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local TimerStart=GkEventTimerManager.Start
local SVarsIsSynchronized=TppScriptVars.SVarsIsSynchronized
this.MISSION_PREPARE_STATE=Tpp.Enum{"START","WAIT_INITALIZE","WAIT_TEXTURE_LOADING","END_TEXTURE_LOADING","WAIT_ALL_MEMBER_IF_COOP","WAIT_BASE_DEFENSE_RESULT","WAIT_SAVING_FILE","END_SAVING_FILE","WAIT_INITIAL_LOAD","END_CHECK_EXCEPTION","FINISH"}
local function s(n)
  local e=mvars.seq_sequenceTable
  if e then
    return e[n]
  end
end
local function p(n)
  local e=mvars.seq_sequenceNames
  if e then
    return s(e[n])
  end
end
function this.RegisterSequences(n)
  if not IsTypeTable(n)then
    return
  end
  local s=#n
  if s>(_-1)then
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
function this.SetNextSequence(r,n)
  local s=nil
  if mvars.seq_sequenceNames then
    s=mvars.seq_sequenceNames[r]
  end
  if s==nil then
    return
  end
  local t=false
  local a=false
  local u=false
  local o=true
  if n and IsTypeTable(n)then
    t=n.isExecMissionClear
    a=n.isExecGameOver
    u=n.isExecDemoPlaying
    o=n.isExecMissionPrepare
  end
  if TppMission.CheckMissionState(t,a,u,o)then
    if Tpp.IsQARelease()or nil then
      local n=TppMission.GetMissionName()
      local e=this.GetCurrentSequenceName()
      Mission.SetMiniText(0,r)
    end
    svars.seq_sequence=s
    return
  end
  if Tpp.IsQARelease()or nil then
    local n=TppMission.GetMissionName()
    local e=this.GetCurrentSequenceName()
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
local u=this.GetSequenceNameWithIndex
function this.GetCurrentSequenceName()
  if svars then
    return u(svars.seq_sequence)
  end
end
function this.GetMissionStartSequenceName()
  if mvars.seq_missionStartSequence then
    return u(mvars.seq_missionStartSequence)
  end
end
function this.GetMissionStartSequenceIndex()
  return mvars.seq_missionStartSequence
end
function this.GetContinueCount()
  local e=svars.seq_sequence
  return svars.seq_sequenceContinueCount[e]
end
function this.MakeSVarsTable(s)
  local n={}
  local e,t,t=1
  for i,s in pairs(s)do
    local t=type(s)
    if t=="boolean"then
      n[e]={name=i,type=TppScriptVars.TYPE_BOOL,value=s,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif t=="number"then
      n[e]={name=i,type=TppScriptVars.TYPE_INT32,value=s,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif t=="string"then
      n[e]={name=i,type=TppScriptVars.TYPE_UINT32,value=StrCode32(s),save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif t=="table"then
      n[e]=s
    end
    e=e+1
  end
  return n
end
local s=1
r={"Seq_Mission_Prepare","Seq_Accepted_Invitation"}
this.SYS_SEQUENCE_LENGTH=#r
a.Seq_Mission_Prepare={Messages=function(e)
  return Tpp.StrCode32Table{
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",
        func=function()
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="StartMissionTelopFadeIn",
        func=function()
        end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="StartMissionTelopFadeOut",
        func=function()
          mvars.seq_nowWaitingStartMissionTelopFadeOut=nil
          e.FadeInStartOnGameStart()
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},
      {msg="PushEndLoadingTips",
        func=function()
          mvars.seq_nowWaitingPushEndLoadingTips=nil
          TimerStart("Timer_WaitStartingGame",s)
        end,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}},
    Timer={
      {msg="Finish",sender="Timer_WaitStartingGame",
        func=e.MissionGameStart,
        option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}}
  }
end,
OnEnter=function(n)
  if Tpp.IsQARelease()or nil then
    Mission.SetMiniText(0,"Seq_Mission_Prepare")
  end
  mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_INITALIZE
  mvars.seq_textureLoadWaitStartTime=c
  mvars.seq_canMissionStartWaitStartTime=Time.GetRawElapsedTimeSinceStartUp()
  mvars.isTextureLoadFinished=false
  TppMain.OnEnterMissionPrepare()
  TppMain.DisablePause()
  gvars.canExceptionHandling=true
end,OnLeave=function(s,n)
  TppMain.OnMissionGameStart(n)
  this.DoOnEndMissionPrepareFunction()
  if this.IsFirstLandStart()then
    if not TppSave.IsReserveVarRestoreForContinue()then
      TppUiStatusManager.ClearStatus"AnnounceLog"
      TppUiStatusManager.SetStatus("AnnounceLog","SUSPEND_LOG")
    end
  end
end,CanMissionGameStart=function()
  if SsdFlagMission.IsLoaded()then
    return true
  end
  return false
end,MissionGameStart=function()
  if InvitationManagerController.IsGoingCoopMission()then
    TppMain.DisableBlackLoading()
    this.SetNextSequence"Seq_Accepted_Invitation"elseif not a.Seq_Mission_Prepare.CanMissionGameStart()then
    TimerStart("Timer_WaitStartingGame",s)
  elseif mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    TppMain.DisableBlackLoading()
    this.SetMissionGameStartSequence()
  else
    a.Seq_Mission_Prepare.FadeInStartOnGameStart()
  end
end,FadeInStartOnGameStart=function()
  TppMain.DisableBlackLoading()
  local n
  if TppMission.IsMissionStart()and(not TppMission.IsFreeMission(vars.missionCode))then
    n={AnnounceLog=false}
  end
  this.SetMissionGameStartSequence()
  if gvars.exc_processingExecptionType~=0 then
    return
  end
  TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnGameStart",TppUI.FADE_PRIORITY.MISSION,{exceptGameStatus=n})
end,SkipTextureLoadingWait=function()
  if mvars.seq_skipTextureLoadingWait then
    return true
  end
end,DEBUG_TextPrint=function(e)
  if not DebugText then
    return
  end
  local n=DebugText.NewContext()
  DebugText.Print(n,{.5,.5,1},e)
end,OnUpdate=function(n)
  if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
    TppUI.ShowAccessIconContinue()
  end
  TppMission.ExecuteSystemCallback"OnUpdateWhileMissionPrepare"local _=30
  local u=.35
  local i=mvars.isTextureLoadFinished
  local a=false
  local o=Mission.GetTextureLoadedRate()
  local a=false
  if vars.missionCode~=TppDefine.SYS_MISSION_ID.INIT then
    local e=TppMission.CanStart()
    if Player.IsInstanceValid()or vars.missionCode>=6e4 then
      a=e
    end
  else
    a=TppMission.CanStart()
  end
  if n.SkipTextureLoadingWait()then
    o=1
  end
  local c=0
  local r=_
  local d=Time.GetRawElapsedTimeSinceStartUp()
  local l=d-mvars.seq_canMissionStartWaitStartTime
  if DebugText then
    if mvars.seq_nowWaitingStartMissionTelopFadeOut then
      n.DEBUG_TextPrint"Now waiting start mission telop fade out message"
      end
    if mvars.seq_nowWaitingPushEndLoadingTips then
      n.DEBUG_TextPrint"Now waiting PushEndLoadingTips message."
      end
  end
  if(a==false)and(l>S)then
    if not mvars.seq_doneDumpCanMissionStartRefrainIds then
      mvars.seq_doneDumpCanMissionStartRefrainIds=true
      if DebugMenu then
        DebugMenu.SetDebugMenuValue("Mission","ViewStartRefrain",true)
      end
    end
  end
  if(not TppMission.IsDefiniteMissionClear())then
    TppTerminal.VarSaveMbMissionStartSyncEnd()
    TppSave.DoReservedSaveOnMissionStart()
  end
  if a then
    if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING)then
      mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING
      TppMain.OnTextureLoadingWaitStart()
      mvars.seq_textureLoadWaitStartTime=d
    end
    c=Time.GetRawElapsedTimeSinceStartUp()-mvars.seq_textureLoadWaitStartTime
    r=_-c
    if(o>u)or(r<0)then
      i=true
    end
    if mvars.seq_forceStopWhileNotPressedPad then
      i=DebugPad.IsScannedAorB()
      if i then
        mvars.seq_forceStopWhileNotPressedPad=false
      end
    end
    mvars.isTextureLoadFinished=i
  else
    if DebugText then
      n.DEBUG_TextPrint(string.format("033.0 > [MissionPrepare] Waiting Mission.CanStart() is true. canMissionStartWaitingTime =  %02.2f[s] : TIMEOUT = %02.2f[s]",l,S))
    end
  end
  if not i then
    if DebugText then
      n.DEBUG_TextPrint(string.format("034.0 > [MissionPrepare] Waiting texture loading. TimeOutRemain = %02.2f[s], textureLoadRatio = %03.2f /.%03.2f",r,o*100,u*100))
      if mvars.seq_forceStopWhileNotPressedPad then
        n.DEBUG_TextPrint"034.0 > Force stop while not pressed pad. If you want proceed, you push A or B."else
        if DebugPad and DebugPad.IsScannedAorB then
          n.DEBUG_TextPrint"034.0 > If you want skip texture load for debug, you push A or B."end
      end
    end
    return
  end
  if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.WAIT_BASE_DEFENSE_RESULT)then
    if BaseDefenseManager.IsBusy()then
      n.DEBUG_TextPrint"051.0 > Wait BaseDefense Result."return
    end
    if BaseDefenseManager.IsNeedCheckPointSave()then
      gvars.sav_needCheckPointSaveOnMissionStart=true
    end
    mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_BASE_DEFENSE_RESULT
  end
  if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.WAIT_SAVING_FILE)then
    mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_SAVING_FILE
    TppMain.OnMissionStartSaving()
  end
  if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.END_SAVING_FILE)then
    mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.END_SAVING_FILE
    if r<0 then
    end
    TppMain.OnMissionCanStart()
    return
  end
  if(mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.WAIT_INITIAL_LOAD)then
    if not n.CanMissionGameStart()then
      n.DEBUG_TextPrint"065.0 > Wait Initial Mission Loading."return
    end
    mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.WAIT_INITIAL_LOAD
    if TppUiCommand.IsEndLoadingTips()then
      TppUI.FinishLoadingTips()TimerStart("Timer_WaitStartingGame",s)
    else
      if gvars.waitLoadingTipsEnd then
        mvars.seq_nowWaitingPushEndLoadingTips=true
        TppUiCommand.PermitEndLoadingTips()
      else
        TppUI.FinishLoadingTips()TimerStart("Timer_WaitStartingGame",s)
      end
    end
  end
  if mvars.seq_missionPrepareState<this.MISSION_PREPARE_STATE.END_CHECK_EXCEPTION then
    mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.END_CHECK_EXCEPTION
    if gvars.exc_processingExecptionType~=0 and gvars.waitLoadingTipsEnd then
      TppUI.FinishLoadingTips()TimerStart("Timer_WaitStartingGame",s)
    end
  end
end}a.Seq_Accepted_Invitation={OnEnter=function()
  TppMission.GoToCoopLobby()
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
  local n=this.SYS_SEQUENCE_LENGTH+1
  mvars.seq_missionStartSequence=n
  if(Tpp.IsQARelease()or nil)and(svars.dbg_seq_sequenceName~=0)then
    local e
    for n,s in pairs(mvars.seq_sequenceNames)do
      if StrCode32(s)==svars.dbg_seq_sequenceName then
        e=n
        break
      end
    end
    if e then
      mvars.seq_missionStartSequence=e
      svars.dbg_seq_sequenceName=0
      return
    end
  end
  if TppMission.IsTitleMission(vars.missionCode)or TppMission.IsInitMission(vars.missionCode)then
    gvars.mis_tempSequenceNumberForReload=0
  elseif svars.seq_sequence>n then
    mvars.seq_missionStartSequence=svars.seq_sequence
  elseif gvars.mis_tempSequenceNumberForReload>n then
    mvars.seq_missionStartSequence=gvars.mis_tempSequenceNumberForReload
    gvars.mis_tempSequenceNumberForReload=0
  end
end
function this.SetMissionGameStartSequence()
  mvars.seq_missionPrepareState=this.MISSION_PREPARE_STATE.FINISH
  svars.seq_sequence=mvars.seq_missionStartSequence
  if Tpp.IsQARelease()or nil then
    local e=this.GetSequenceNameWithIndex(mvars.seq_missionStartSequence)
    Mission.SetMiniText(0,e)
  end
end
function this.SetOnEndMissionPrepareFunction(e)
  mvars.seq_onEndMissionPrepareFunction=e
end
function this.DoOnEndMissionPrepareFunction()
  NamePlateMenu.SetDefaultNamePlateIfSetBegginerNamePlate()
  if mvars.seq_onEndMissionPrepareFunction then
    mvars.seq_onEndMissionPrepareFunction()
  end
  --RETAILPATCH: 1.0.10.0>
  if Mission.IsFromReplayMission()then
    if TppMission.IsFreeMission(vars.missionCode)then
      Player.SetReplayMissionToSkillTrainer()
    end
    Mission.ResetFromReplayMission()
    if TppSoundDaemon.ReserveResetCutSceneMute then
      TppSoundDaemon.ReserveResetCutSceneMute()
    end
  end
  --<
end
function this.IsFirstLandStart()
  if(not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(mvars.seq_missionStartSequence==(this.SYS_SEQUENCE_LENGTH+1))then
    return true
  else
    return false
  end
end
function this.IsLandContinue()
  if(not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(this.GetContinueCount()>0)then
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
  return{{name="seq_sequence",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,notify=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="seq_sequenceContinueCount",arraySize=_,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="dbg_seq_sequenceName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.DEBUG_Init()
end
function this.Init(n)
  this.MakeSequenceMessageExecTable()svars.seq_sequence=this.GetSequenceIndex"Seq_Mission_Prepare"
  if n.sequence then
    if n.sequence.SKIP_TEXTURE_LOADING_WAIT then
      mvars.seq_skipTextureLoadingWait=true
    end
    if n.sequence.FORCE_STOP_MISSION_PREPARE_WHILE_NOT_PRESSED_PAD then
      mvars.seq_forceStopWhileNotPressedPad=true
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
    if e.Messages and IsTypeFunc(e.Messages)then
      local e=e.Messages(e)
      mvars.seq_sequenceTable[n]._messageExecTable=Tpp.MakeMessageExecTable(e)
    end
  end
end
function this.OnChangeSVars(n,s)
  if n=="seq_sequence"then
    local s=p(svars.seq_sequence)
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
function this.OnMessage(t,s,n,o,a,r,i)
  if mvars.seq_sequenceTable==nil then
    return
  end
  local e=mvars.seq_sequenceTable[mvars.seq_currentSequence]
  if e==nil then
    return
  end
  local e=e._messageExecTable
  Tpp.DoMessage(e,TppMission.CheckMessageOption,t,s,n,o,a,r,i)
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
  local n=DebugText.NewContext()
  if e.debug.showCurrentSequence or e.debug.showSequenceHistory then
    if e.debug.showCurrentSequence then
      DebugText.Print(n,{.5,.5,1},"LuaSystem SEQ.showCurrSequence")
      DebugText.Print(n," current_sequence = "..tostring(u(s.seq_sequence)))
    end
    if e.debug.showSequenceHistory then
      DebugText.Print(n,{.5,.5,1},"LuaSystem SEQ.showSeqHistory")
      for e,s in ipairs(e.debug.seq_sequenceHistory)do
        DebugText.Print(n," seq["..(tostring(e)..("] = "..tostring(s))))
      end
    end
  end
end
return this
