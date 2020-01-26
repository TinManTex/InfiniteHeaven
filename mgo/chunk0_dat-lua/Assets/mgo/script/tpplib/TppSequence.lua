local e={}
local a={}
local i={}
local c=256
local u=0
local _=180
local o=Fox.StrCode32
local T=Tpp.IsTypeFunc
local r=Tpp.IsTypeTable
local n=GkEventTimerManager.Start
local s=TppScriptVars.SVarsIsSynchronized
e.MISSION_PREPARE_STATE=Tpp.Enum{"START","WAIT_INITALIZE","WAIT_TEXTURE_LOADING","END_TEXTURE_LOADING","WAIT_SAVING_FILE","END_SAVING_FILE","FINISH"}
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
function e.RegisterSequences(n)
  if not r(n)then
    return
  end
  local s=#n
  if s>(c-1)then
    return
  end
  local t={}
  mvars.seq_demoSequneceList={}
  for e=1,e.SYS_SEQUENCE_LENGTH do
    t[e]=i[e]
  end
  for s=1,#n do
    local e=e.SYS_SEQUENCE_LENGTH+s
    t[e]=n[s]
    local n=string.sub(n[s],5,8)
    if n=="Demo"then
      mvars.seq_demoSequneceList[e]=true
    end
    if(mvars.seq_heliStartSequence==nil)and(n=="Game")then
      mvars.seq_heliStartSequence=e
    end
  end
  mvars.seq_sequenceNames=Tpp.Enum(t)
end
function e.RegisterSequenceTable(e)
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
function e.SetNextSequence(s,e)
  local n=nil
  if mvars.seq_sequenceNames then
    n=mvars.seq_sequenceNames[s]
  end
  if n==nil then
    return
  end
  local t=false
  local a=false
  local i=false
  local s=true
  if e and r(e)then
    t=e.isExecMissionClear
    a=e.isExecGameOver
    i=e.isExecDemoPlaying
    s=e.isExecMissionPrepare
  end
  if TppMission.CheckMissionState(t,a,i,s)then
    svars.seq_sequence=n
    return
  end
end
function e.ReserveNextSequence(s,n)
  TppScriptVars.SetSVarsNotificationEnabled(false)
  e.SetNextSequence(s,n)
  TppScriptVars.SetSVarsNotificationEnabled(true)
end
function e.GetCurrentSequenceIndex()
  return svars.seq_sequence
end
function e.GetSequenceIndex(n)
  local e=mvars.seq_sequenceNames
  if e then
    return e[n]
  end
end
function e.GetSequenceNameWithIndex(n)
  local e=mvars.seq_sequenceNames
  if e then
    local e=e[n]
    if e then
      return e
    end
  end
  return""
end
local r=e.GetSequenceNameWithIndex
function e.GetCurrentSequenceName()
  if svars then
    return r(svars.seq_sequence)
  end
end
function e.GetMissionStartSequenceName()
  if mvars.seq_missionStartSequence then
    return r(mvars.seq_missionStartSequence)
  end
end
function e.GetContinueCount()
  local e=svars.seq_sequence
  return svars.seq_sequenceContinueCount[e]
end
function e.MakeSVarsTable(s)
  local n={}
  local e,t,t=1
  for a,s in pairs(s)do
    local t=type(s)
    if t=="boolean"then
      n[e]={name=a,type=TppScriptVars.TYPE_BOOL,value=s,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif t=="number"then
      n[e]={name=a,type=TppScriptVars.TYPE_INT32,value=s,save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif t=="string"then
      n[e]={name=a,type=TppScriptVars.TYPE_UINT32,value=o(s),save=true,sync=true,category=TppScriptVars.CATEGORY_MISSION}
    elseif t=="table"then
      n[e]=s
    end
    e=e+1
  end
  return n
end
local o=1
local s=6
local t=2
i={"Seq_Mission_Prepare"}
e.SYS_SEQUENCE_LENGTH=#i
a.Seq_Mission_Prepare={Messages=function(e)
  return Tpp.StrCode32Table{UI={{msg="EndFadeIn",sender="FadeInOnGameStart",func=function()
    end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="StartMissionTelopFadeIn",func=function()n("Timer_HelicopterMoveStart",s)
    end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="StartMissionTelopFadeOut",func=function()
      mvars.seq_nowWaitingStartMissionTelopFadeOut=nil
      e.FadeInStartOnGameStart()
    end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="PushEndLoadingTips",func=function()
      mvars.seq_nowWaitingPushEndLoadingTips=nil
      n("Timer_WaitStartingGame",1)
    end,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}},Timer={{msg="Finish",sender="Timer_WaitStartingGame",func=e.MissionGameStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="Finish",sender="Timer_HelicopterMoveStart",func=e.HelicopterMoveStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}},{msg="Finish",sender="Timer_FadeInStartOnNoTelopHelicopter",func=e.FadeInStartOnGameStart,option={isExecMissionPrepare=true,isExecMissionClear=true,isExecGameOver=true}}}}
end,OnEnter=function(n)
  mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.WAIT_INITALIZE
  mvars.seq_textureLoadWaitStartTime=u
  mvars.seq_canMissionStartWaitStartTime=Time.GetRawElapsedTimeSinceStartUp()
  TppMain.OnEnterMissionPrepare()
  TppMain.DisablePause()
end,OnLeave=function(s,n)
  TppMain.OnMissionGameStart(n)
  e.DoOnEndMissionPrepareFunction()
  if e.IsFirstLandStart()then
    if not TppSave.IsReserveVarRestoreForContinue()then
      local e=TppMission.GetMissionStartRecoverDemoType()
      if e==TppDefine.MISSION_START_RECOVER_DEMO_TYPE.WALKER_GEAR then
        TppUI.ShowAnnounceLog("looting_weapon",nil,nil)
        TppUI.ShowAnnounceLog("get_wgear","walkergear_w_1",1)
      end
      TppMission.UpdateCheckPointAtCurrentPosition()
    end
  end
end,HelicopterMoveStart=function()
  if(gvars.ply_initialPlayerState==TppDefine.INITIAL_PLAYER_STATE.RIDEON_HELICOPTER)and(svars.ply_isUsedPlayerInitialAction==false)then
    TppHelicopter.SetRouteToHelicopterOnStartMission()
  end
end,MissionGameStart=function()
  if mvars.seq_demoSequneceList[mvars.seq_missionStartSequence]then
    TppMain.DisableBlackLoading()
    e.SetMissionGameStartSequence()
  else
    if mvars.seq_isHelicopterStart then
      if mvars.seq_noMissionTelopOnHelicopter then
        a.Seq_Mission_Prepare.HelicopterMoveStart()n("Timer_FadeInStartOnNoTelopHelicopter",t)
      else
        TppSoundDaemon.ResetMute"Loading"mvars.seq_nowWaitingStartMissionTelopFadeOut=true
        TppUI.StartMissionTelop()
      end
    else
      a.Seq_Mission_Prepare.FadeInStartOnGameStart()
    end
  end
end,FadeInStartOnGameStart=function()
  TppMain.DisableBlackLoading()
  local n
  if mvars.seq_isHelicopterStart then
    TppSound.SetHelicopterStartSceneBGM()n=Tpp.GetHelicopterStartExceptGameStatus()
  else
    if TppMission.IsMissionStart()and(not TppMission.IsFreeMission(vars.missionCode))then
      n={AnnounceLog=false}
    end
  end
  e.SetMissionGameStartSequence()
  TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeInOnGameStart",nil,{exceptGameStatus=n})
end,SkipTextureLoadingWait=function()
  if mvars.seq_skipTextureLoadingWait then
    return true
  end
end,DEBUG_TextPrint=function(e)
  local n=(nil).NewContext();(nil).Print(n,{.5,.5,1},e)
end,OnUpdate=function(t)
  if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
    TppUI.ShowAccessIconContinue()
  end
  TppMission.ExecuteSystemCallback"OnUpdateWhileMissionPrepare"if gvars.ini_isTitleMode then
    if SplashScreen.GetSplashScreenWithName"foxLogo"then
      TppMpBaseRuleset.SetEnabledToSpawnPlayers(false)
    else
      TppMpBaseRuleset.SetEnabledToSpawnPlayers(true)
    end
  end
  local c=30
  local p=.35
  local s=false
  local a=false
  local i=Mission.GetTextureLoadedRate()
  local r=TppMission.CanStart()
  local l=TppMotherBaseManagement.IsEndedSyncControl()
  if t.SkipTextureLoadingWait()then
    i=1
  end
  local a=0
  local t=c
  local u=Time.GetRawElapsedTimeSinceStartUp()
  local S=u-mvars.seq_canMissionStartWaitStartTime
  if(r==false)and(S>_)then
    if not mvars.seq_doneDumpCanMissionStartRefrainIds then
      mvars.seq_doneDumpCanMissionStartRefrainIds=true
    end
  end
  if not l then
    return
  end
  TppTerminal.VarSaveMbMissionStartSyncEnd()
  TppSave.DoReservedSaveOnMissionStart()
  if r then
    if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING)then
      mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.WAIT_TEXTURE_LOADING
      TppMain.OnTextureLoadingWaitStart()
      mvars.seq_textureLoadWaitStartTime=u
    end
    a=Time.GetRawElapsedTimeSinceStartUp()-mvars.seq_textureLoadWaitStartTime
    t=c-a
    if(i>p)or(t<0)then
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
  if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.END_TEXTURE_LOADING)then
    mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.WAIT_SAVING_FILE
    TppMain.OnMissionStartSaving()
  end
  if(mvars.seq_missionPrepareState<e.MISSION_PREPARE_STATE.END_SAVING_FILE)then
    mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.END_SAVING_FILE
    if t<0 then
    end
    TppMain.OnMissionCanStart()
    if TppUiCommand.IsEndLoadingTips()then
      TppUI.FinishLoadingTips()n("Timer_WaitStartingGame",o)
    else
      if gvars.waitLoadingTipsEnd then
        mvars.seq_nowWaitingPushEndLoadingTips=true
        TppUiCommand.PermitEndLoadingTips()
      else
        TppUI.FinishLoadingTips()n("Timer_WaitStartingGame",o)
      end
    end
  end
end}
function e.IsMissionPrepareFinished()
  if mvars.seq_missionPrepareState then
    if mvars.seq_missionPrepareState>=e.MISSION_PREPARE_STATE.FINISH then
      return true
    end
  end
  return false
end
function e.IsEndSaving()
  if mvars.seq_missionPrepareState then
    if mvars.seq_missionPrepareState>=e.MISSION_PREPARE_STATE.END_SAVING_FILE then
      return true
    end
  end
  return false
end
function e.SaveMissionStartSequence()
  local e=e.SYS_SEQUENCE_LENGTH+1
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
function e.SetMissionGameStartSequence()
  mvars.seq_missionPrepareState=e.MISSION_PREPARE_STATE.FINISH
  svars.seq_sequence=mvars.seq_missionStartSequence
end
function e.SetOnEndMissionPrepareFunction(e)
  mvars.seq_onEndMissionPrepareFunction=e
end
function e.DoOnEndMissionPrepareFunction()
  if mvars.seq_onEndMissionPrepareFunction then
    mvars.seq_onEndMissionPrepareFunction()
  end
end
function e.IsHelicopterStart()
  return mvars.seq_isHelicopterStart
end
function e.IsFirstLandStart()
  if((not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(not mvars.seq_isHelicopterStart))and(mvars.seq_missionStartSequence==(e.SYS_SEQUENCE_LENGTH+1))then
    return true
  else
    return false
  end
end
function e.IsLandContinue()
  if((not mvars.seq_demoSequneceList[mvars.seq_missionStartSequence])and(not mvars.seq_isHelicopterStart))and(e.GetContinueCount()>0)then
    return true
  else
    return false
  end
end
function e.CanHandleSignInUserChangedException()
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
function e.IncrementContinueCount()
  local e=svars.seq_sequence
  local n=svars.seq_sequenceContinueCount[e]+1
  local s=255
  if n<=s then
    svars.seq_sequenceContinueCount[e]=n
  end
end
function e.DeclareSVars()
  return{{name="seq_sequence",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,notify=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="seq_sequenceContinueCount",arraySize=c,type=TppScriptVars.TYPE_UINT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="dbg_seq_sequenceName",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.DEBUG_Init()
end
function e.Init(n)
  e.MakeSequenceMessageExecTable()svars.seq_sequence=e.GetSequenceIndex"Seq_Mission_Prepare"if n.sequence then
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
function e.OnReload()
  e.MakeSequenceMessageExecTable()
end
function e.MakeSequenceMessageExecTable()
  if not mvars.seq_sequenceTable then
    return
  end
  for n,e in pairs(mvars.seq_sequenceTable)do
    if e.Messages and T(e.Messages)then
      local e=e.Messages(e)
      mvars.seq_sequenceTable[n]._messageExecTable=Tpp.MakeMessageExecTable(e)
    end
  end
end
function e.OnChangeSVars(n,s)
  if n=="seq_sequence"then
    local s=d(svars.seq_sequence)
    if s==nil then
      return
    end
    local n=mvars.seq_sequenceTable[mvars.seq_currentSequence]
    if n and n.OnLeave then
      n.OnLeave(n,e.GetSequenceNameWithIndex(svars.seq_sequence))
    end
    mvars.seq_currentSequence=mvars.seq_sequenceNames[svars.seq_sequence]
    if s.OnEnter then
      local e
      s.OnEnter(s)
    end
  end
end
function e.OnMessage(o,n,i,r,a,t,s)
  if mvars.seq_sequenceTable==nil then
    return
  end
  local e=mvars.seq_sequenceTable[mvars.seq_currentSequence]
  if e==nil then
    return
  end
  local e=e._messageExecTable
  Tpp.DoMessage(e,TppMission.CheckMessageOption,o,n,i,r,a,t,s)
end
function e.Update()
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
function e.DebugUpdate()
  local e=mvars
  local s=svars
  local n=(nil).NewContext()
  if e.debug.showCurrentSequence or e.debug.showSequenceHistory then
    if e.debug.showCurrentSequence then(nil).Print(n,{.5,.5,1},"LuaSystem SEQ.showCurrSequence");(nil).Print(n," current_sequence = "..tostring(r(s.seq_sequence)))
    end
    if e.debug.showSequenceHistory then(nil).Print(n,{.5,.5,1},"LuaSystem SEQ.showSeqHistory")
      for s,e in ipairs(e.debug.seq_sequenceHistory)do(nil).Print(n," seq["..(tostring(s)..("] = "..tostring(e))))
      end
    end
  end
end
return e
