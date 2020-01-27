local this={}
local n=Fox.StrCode32
local n=Tpp.IsTypeTable
local i=GameObject.GetGameObjectId
local i=GameObject.NULL_ID
local t=FadeFunction.CallFadeIn
local _=FadeFunction.CallFadeOut
if SsdFadeManager then
  t=SsdFadeManager.RequestFadeIn
  _=SsdFadeManager.RequestFadeOut
end
local d=0
this.FADE_SPEED={FADE_MOMENT=0,FADE_HIGHESTSPEED=.5,FADE_HIGHSPEED=1,FADE_NORMALSPEED=2,FADE_LOWSPEED=4,FADE_LOWESTSPEED=8}
if SsdFadeManager then
  this.FADE_PRIORITY={SYSTEM=SsdFadeManager.PRIORITY_SYSTEM,DEMO=SsdFadeManager.PRIORITY_DEMO,RESULT=SsdFadeManager.PRIORITY_RESULT,MISSION=SsdFadeManager.PRIORITY_MISSION,FLAG=SsdFadeManager.PRIORITY_FLAG,QUEST=SsdFadeManager.PRIORITY_QUEST,USER=SsdFadeManager.PRIORITY_USER}
else
  this.FADE_PRIORITY={}
end
this.ANNOUNCE_LOG_TYPE={updateMissionInfo="announce_mission_info_update",updateMap="announce_map_update",recoverTarget="announce_target_extract",eliminateTarget="announce_target_eliminate",destroyTarget="announce_target_destroy",achieveObjectiveCount="announce_objective_complete_num",achieveAllObjectives="announce_objective_complete",getIntel="announce_get_intel_file",target_died="announce_target_died",target_eliminate_failed="announce_target_eliminate_failed",target_extract_failed="announce_target_extract_failed",staff_dead="announce_staff_dead",staff_dying="announce_staff_dying",closeOutOfMissionArea="announce_mission_area_warning",getDiamond="announce_get_diamond",missionListUpdate="announce_mission_list_update",sunset="announce_sunset",sunrise="announce_sunrise",weather_sunny="announce_weather_sunny",weather_cloudy="announce_weather_cloudy",weather_rainy="announce_weather_rain",weather_sandstorm="announce_weather_sandstorm",weather_foggy="announce_weather_fog",getPoster="announce_get_gravure",task_complete="announce_task_complete",quest_add="announce_quest_add",quest_complete="announce_quest_complete",quest_delete="announce_quest_delete",quest_list_update="announce_quest_list_update",mine_quest_log="announce_quest_disposal_mine",quest_get_photo="announce_get_photo",find_keyitem="announce_find_keyitem",get_tape="announce_get_tape",add_alt_machine="announce_add_alt_machine",get_blueprint="announce_get_blueprint",recoveredFilmCase="announce_get_film_case",find_processed_res="announce_find_processed_res",find_diamond="announce_find_diamond",find_plant="announce_find_plant"}
this.ANNOUNCE_LOG_PRIORITY={"eliminateTarget","recoveredFilmCase","recoverTarget","destroyTarget","achieveAllObjectives","achieveObjectiveCount","getIntel","updateMissionInfo","updateMap"}
this.EMBLEM_ANNOUNCE_LOG_TYPE={[Fox.StrCode32"front"]="find_em_front",[Fox.StrCode32"base"]="find_em_back",[Fox.StrCode32"word"]="find_em_string"}
function this.Messages()
  return Tpp.StrCode32Table{UI={{msg="EndFadeIn",func=this.EnableGameStatusOnFade,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",func=this.DisableGameStatusOnFadeOutEnd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecFastTravel=true}},{msg="ConfigurationUpdated",func=function()
    if vars.missionCode==TppDefine.SYS_MISSION_ID.INIT then
      return
    end
    TppSave.VarSaveConfig()
    if TppSave.IsSavingWithFileName(TppDefine.CONFIG_SAVE_FILE_NAME)or TppSave.HasQueue(TppDefine.CONFIG_SAVE_FILE_NAME)then
      return
    end
    TppSave.SaveConfigData()
  end,option={isExecGameOver=true}},{msg="StartMissionTelopFadeOut",func=function()
    TppSoundDaemon.ResetMute"Telop"end}},Network={{msg="AddSessionMember",func=function()
    this._UpdateCoopMissionPauseMenuList()
    end},{msg="DeleteSessionMember",func=function()
      this._UpdateCoopMissionPauseMenuList()
    end}}}
end
local function s(e)
  if type(e)=="string"then
    return Fox.StrCode32(e)
  elseif type(e)=="number"then
    return e
  end
  return nil
end
function this.FadeIn(a,o,n,i)
  local o=s(o)
  if i then
    mvars.ui_onEndFadeInExceptGameStatus=i.exceptGameStatus
  elseif mvars.ui_onEndFadeInOverrideExceptGameStatus then
    mvars.ui_onEndFadeInExceptGameStatus=mvars.ui_onEndFadeInOverrideExceptGameStatus
  else
    mvars.ui_onEndFadeInExceptGameStatus=nil
  end
  TppSoundDaemon.ResetMute"Outro"if SsdFadeManager then
    if not n then
      n=this.FADE_PRIORITY.USER
    end
  end
  t(a,o,n)
  this.EnableGameStatusOnFadeInStart()
end
function this.OverrideFadeInGameStatus(e)
  mvars.ui_onEndFadeInOverrideExceptGameStatusTemporary=e
end
function this.UnsetOverrideFadeInGameStatus()
  mvars.ui_onEndFadeInOverrideExceptGameStatusTemporary=nil
end
function this.GetOverrideGameStatus()
  return mvars.ui_onEndFadeInOverrideExceptGameStatusTemporary
end
function this.SetFadeColorToBlack()FadeFunction.SetFadeColor(0,0,0,255)
end
function this.SetFadeColorToWhite()FadeFunction.SetFadeColor(255,255,255,255)
end
function this.FadeOut(d,u,t,i)
  local o,a
  if n(i)then
    o=i.setMute
    a=i.exceptGameStatus
  end
  local n=s(u)
  this.DisableGameStatusOnFade(a)
  if o then
    TppSound.SetMuteOnLoading()
  else
    if(not TppSoundDaemon.CheckCurrentMuteIs"Pause")and(not TppSoundDaemon.CheckCurrentMuteMoreThan"Outro")then
      TppSoundDaemon.SetMute"Outro"end
  end
  if SsdFadeManager then
    if not t then
      t=this.FADE_PRIORITY.USER
    end
  end
  _(d,n,t)
end
function this.ShowAnnounceLog(o,a,t,n,i)
  if gvars.ini_isTitleMode then
    return
  end
  local e=this.ANNOUNCE_LOG_TYPE[o]
  if e then
    if n then
      TppUiCommand.AnnounceLogDelayTime(n)
    end
    TppUiCommand.AnnounceLogViewLangId(e,a,t)
  elseif i then
    local e=TppUiCommand.GetCurrentMissionSubGoalByNo(i)
    TppUiCommand.AnnounceLogViewLangId(e)
  end
end
function this.ShowColorAnnounceLog(o,t,i,n)
  if gvars.ini_isTitleMode then
    return
  end
  local e=this.ANNOUNCE_LOG_TYPE[o]
  if e then
    if n then
      TppUiCommand.AnnounceLogDelayTime(n)
    end
    TppUiCommand.AnnounceLogViewLangId(e,t,i,0,0,true)
  end
end
function this.ShowJoinAnnounceLog(i,t,a,o,n)
  if gvars.ini_isTitleMode then
    return
  end
  local i=this.ANNOUNCE_LOG_TYPE[i]
  local e=this.ANNOUNCE_LOG_TYPE[t]
  if i and e then
    if n then
      TppUiCommand.AnnounceLogDelayTime(n)
    end
    TppUiCommand.AnnounceLogViewJoinLangId(i,e,a,o)
  end
end
function this.ShowColorJoinAnnounceLog(n,t,a,o,i)
  if gvars.ini_isTitleMode then
    return
  end
  local n=this.ANNOUNCE_LOG_TYPE[n]
  local e=this.ANNOUNCE_LOG_TYPE[t]
  if n and e then
    if i then
      TppUiCommand.AnnounceLogDelayTime(i)
    end
    TppUiCommand.AnnounceLogViewJoinLangId(n,e,a,o,0,0,true)
  end
end
function this.ShowEmergencyAnnounceLog(n)
  this.ShowAnnounceLog"emergencyMissionOccur"if not(TppUiStatusManager.CheckStatus("AnnounceLog","INVALID_LOG")or TppUiStatusManager.CheckStatus("AnnounceLog","SUSPEND_LOG"))then
    if n==true then
      TppSoundDaemon.PostEvent"sfx_s_fob_emergency"else
      TppSoundDaemon.PostEvent"sfx_s_fob_alert"end
  end
end
function this.EnableMissionSubGoal(e)
  TppUiCommand.SetCurrentMissionSubGoalNo(e)
end
function this.StartMissionTelop(e,n,i)
  TppSoundDaemon.SetMute"Telop"if e then
    TppUiCommand.SetMissionStartTelopId(e)
  end
  TppUiCommand.CallMissionStartTelop(n,i)
  TppSound.PostJingleOnMissionStartTelop()
end
function this.GetMaxMissionTask(e)
  return 0
end
function this.EnableMissionTask(i,t)
  if t==nil then
    t=true
  end
  if not n(i)then
    return
  end
  local n={}
  for e,i in pairs(i)do
    n[e]=i
  end
  local i=n.taskNo
  if not i then
    return
  end
  if n.isHide==nil then
    if n.isFirstHide then
      if not TppStory.IsMissionCleard(vars.missionCode)and(not this.IsTaskLastCompleted(i))then
        n.isHide=true
      else
        n.isHide=false
      end
    else
      n.isHide=false
    end
  end
  if n.isComplete then
    n.isHide=false
    local n=vars.missionCode
    local o=this.GetTaskCompletedNumber(n)
    this.SetTaskLastCompleted(i,true)
    local i=this.GetTaskCompletedNumber(n)
    local n=this.GetMaxMissionTask(n)
    if n==nil then
      return
    end
    if t then
      if i>o then
        this.ShowAnnounceLog("task_complete",i,n)
      end
    end
    TppMission.SetPlayRecordClearInfo()
  end
  if this.IsTaskLastCompleted(i)then
    n.isLastCompleted=true
  else
    n.isLastCompleted=false
  end
  TppUiCommand.EnableMissionTask(n)
end
function this.IsTaskLastCompleted(n)
  local e=this.GetLastCompletedFlagIndex(n)
  if e then
    return gvars.ui_isTaskLastComleted[e]
  end
end
function this.SetTaskLastCompleted(i,n)
  local e=this.GetLastCompletedFlagIndex(i)
  if e then
    gvars.ui_isTaskLastComleted[e]=n
  end
end
function this.GetLastCompletedFlagIndex(n)
  return this._GetLastCompletedFlagIndex(vars.missionCode,n)
end
function this._GetLastCompletedFlagIndex(n,e)
  local n=SsdMissionList.MISSION_ENUM[tostring(n)]
  if not n then
    return
  end
  if not Tpp.IsTypeNumber(e)then
    return
  end
  if(e<0)or(e>=TppDefine.MAX_MISSION_TASK_COUNT)then
    return
  end
  return n*TppDefine.MAX_MISSION_TASK_COUNT+e
end
function this.GetTaskCompletedNumber(e)
  local n=SsdMissionList.MISSION_ENUM[tostring(e)]
  if not n then
    return 0
  end
  local e=0
  for i=0,TppDefine.MAX_MISSION_TASK_COUNT-1 do
    local n=n*TppDefine.MAX_MISSION_TASK_COUNT+i
    if gvars.ui_isTaskLastComleted[n]then
      e=e+1
    end
  end
  return e
end
function this.ShowControlGuide(i)
  if not n(i)then
    return
  end
  local t,o,n,s,a,_,d
  t=i.actionName
  o=i.continue
  n=i.time
  s=i.isOnce
  a=i.isOnceThisGame
  _=i.pauseControl
  d=i.ignoreRadio
  if not this.IsEnableToShowGuide(true)then
    return
  end
  if type(t)~="string"then
    return
  end
  local e=TppDefine.CONTROL_GUIDE[t]
  local i=TppDefine.CONTROL_GUIDE_LANG_ID_LIST[e]
  if i==nil then
    return
  end
  if s then
    if gvars.ui_isControlGuideShownOnce[e]then
      return
    end
    gvars.ui_isControlGuideShownOnce[e]=true
  end
  if a then
    if gvars.ui_isControlGuidShownInThisGame[e]then
      return
    end
    gvars.ui_isControlGuidShownInThisGame[e]=true
  end
  if not n then
    n=TppTutorial.DISPLAY_TIME.DEFAULT
  end
  TppUiCommand.SetButtonGuideDispTime(n)
  if not _ then
    if(o==true)then
      TppUiCommand.CallButtonGuideContinue(i,false,false,false)
    else
      TppUiCommand.CallButtonGuide(i,false,false,false)
    end
  else
    local e=TppDefine.PAUSE_CONTROL_GUIDE[e]
    if e then
      TppUiCommand.CallControllerHelp(e,i)
    end
  end
  local e=TppTutorial.ControlGuideRadioList[e]
  if e then
    TppTutorial.PlayRadio(e)
  end
end
function this.IsEnableToShowGuide(e)
  if TppUiCommand.IsMbDvcTerminalOpened()then
    return false
  end
  if not e then
    if TppRadioCommand.IsPlayingRadio()then
      return false
    end
  end
  if TppDemo.IsNotPlayable()then
    return false
  end
  return true
end
function this.StartDisplayTimer(e)
end
function this.ShowSavingIcon(e)
  TppUiCommand.CallSaveMessage(e)
end
function this.ShowLoadingIcon()
  TppUiCommand.CallLoadMessage()
end
function this.ShowAccessIcon()
  TppUiCommand.CallAccessMessage()
end
function this.ShowAccessIconContinue()
  TppUiCommand.CallAccessContinueMessage()
end
function this.HideAccessIcon()
  TppUiCommand.HideAccessMessage()
end
function this.ShowTextureLogo()
  TppUiCommand.ShowTextureLogo()
end
function this.HideTextureLogo()
  TppUiCommand.HideTextureLogo()
end
function this.PreloadLoadingTips(e)LoadingTipsMenuSystem.PrefetchBegin(e)
end
function this.StartLoadingTips()
  local e=TppStory.GetCurrentStorySequence()
  if e<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
    LoadingTipsMenuSystem.SetBgImageType(LoadingTips.BG_2)
  else
    LoadingTipsMenuSystem.SetBgImageType(LoadingTips.BG_1)
  end
  TppUiCommand.StartLoadingTipsCommon()
end
function this.FinishLoadingTips()
  TppUiCommand.RequestEndLoadingTips()
end
function this.SetCoopFullUiLockType(e)e=e or TppStory.GetCurrentStorySequence()
  if Mission.IsEndCoopTutorialForStorySequence()then
    SsdUiSystem.Unlock(SsdUiLockType.COOP_FULL)
  else
    SsdUiSystem.Lock(SsdUiLockType.COOP_FULL)
  end
end
function this.OnAllocate(n)
  local i=true
  if n.sequence then
    if n.sequence.OVERRIDE_SYSTEM_EXCEPT_GAME_STATUS then
      mvars.ui_onEndFadeInOverrideExceptGameStatus=n.sequence.OVERRIDE_SYSTEM_EXCEPT_GAME_STATUS
    end
    if n.sequence.NO_LOAD_UI_DEFAULT_BLOCK then
      i=false
    end
  end
  if i then
    this.LoadAndWaitUiDefaultBlock()
  else
    return
  end
  MapInfoSystem.SetupInfos(TppQuestList)
  if n.sequence then
    if n.sequence.UNSET_UI_SETTING then
      mvars.ui_unsetUiSetting=n.sequence.UNSET_UI_SETTING
    end
    if n.sequence.UNSET_PAUSE_MENU_SETTING then
      mvars.ui_unsetPauseMenuSetting=n.sequence.UNSET_PAUSE_MENU_SETTING
    end
    if n.sequence.UNSET_GAME_OVER_MENU_SETTING then
      mvars.ui_unsetGameOverMenuSetting=n.sequence.UNSET_GAME_OVER_MENU_SETTING
    end
  end
  if TppMission.IsMissionStart()then
    this.EnableMissionSubGoal(d)
  end
  if TppUiCommand.InitAllEnemyRoutePoints then
    TppUiCommand.InitAllEnemyRoutePoints()
  end
end
function this.LoadAndWaitUiDefaultBlock()
  TppUiCommand.LoadUiDefaultBlock()
  local e=0
  local n,i=0,25
  local e=false
  e=not TppUiCommand.IsTppUiReady()
  while e and(n<i)do
    e=not TppUiCommand.IsTppUiReady()n=n+Time.GetFrameTime()coroutine.yield()
  end
end
function this.OnMissionStart()
  local e=vars.missionCode
  local e=TppMission.IsFreeMission(e)
  if e then
    return
  end
end
function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  local n=vars.missionCode
  local i=TppMission.IsFreeMission(n)
  local n=TppMission.IsMultiPlayMission(n)
  TppUiStatusManager.UnsetStatus("MbEquipDevelop","NO_OPEN_SUPPORT_DIALOG")
  TppUiCommand.ResetCurrentMissionSubGoalNo()
  local i=(UiCommonDataManager.GetInstance()~=nil)
  if i then
    if n then
      this._UpdateCoopMissionPauseMenuList()
    else
      this._UpdateSingleMissionPauseMenuList()
    end
    local e=false
    if TppMission.IsMultiPlayMission(vars.missionCode)then
      e=true
    end
    TppPauseMenu.SetIgnoreActorPause(e)
  end
  if i then
    this._SetGameOverMenu(n)
  end
  GameConfig.ApplyAllConfig()
  TppUiCommand.ClearAllMissionTask()
  TppUiStatusManager.UnsetStatus("EquipHudAll","ALL_KILL_NOUSE")
  TppUiStatusManager.UnsetStatus("QuestAreaAnnounce","INVALID")
  if(Tpp.IsQARelease()or nil)then
    local e={{langId="mission_10020_objective_01"},{langId="mission_10020_objective_02"},{langId="mission_10020_objective_03"},{langId="mission_10020_objective_04"},{langId="mission_10030_objective_01"},{langId="mission_10030_objective_02"},{langId="mission_10030_objective_03"},{langId="mission_10030_objective_04"},{langId="mission_10030_objective_05"},{langId="mission_10035_objective_02"},{langId="mission_10040_objective_01"},{langId="mission_10040_objective_02"},{langId="mission_10040_objective_03"},{langId="mission_10060_objective_01"},{langId="mission_10060_objective_02"},{langId="mission_10060_objective_03"},{langId="mission_10060_objective_04"},{langId="mission_10060_objective_05"},{langId="mission_10060_objective_06"},{langId="mission_10060_objective_07"},{langId="mission_10060_objective_08"},{langId="mission_10060_objective_09"},{langId="mission_10060_objective_10"},{langId="mission_40010_objective_01"},{langId="mission_40010_objective_02"},{langId="mission_40015_objective_01"},{langId="mission_40015_objective_02"},{langId="mission_40015_objective_03"},{langId="mission_40020_objective_01"},{langId="mission_40020_objective_03"},{langId="mission_40020_objective_04"},{langId="mission_40025_objective_01"},{langId="mission_40025_objective_02"},{langId="mission_40030_objective_01"},{langId="mission_40030_objective_04"},{langId="mission_40030_objective_05"},{langId="mission_40030_objective_06"},{langId="mission_40035_objective_01"},{langId="mission_40040_objective_01"},{langId="mission_40040_objective_03"},{langId="mission_40040_objective_06"},{langId="mission_40040_objective_07"},{langId="mission_40040_objective_08"},{langId="mission_40040_objective_09"},{langId="mission_40050_objective_01"},{langId="mission_40050_objective_02"},{langId="mission_40050_objective_03"},{langId="mission_40050_objective_04"},{langId="mission_40050_objective_05"},{langId="mission_40050_objective_06"},{langId="mission_40050_objective_07"},{langId="mission_40050_objective_08"},{langId="mission_40050_objective_09"},{langId="mission_40050_objective_10"},{langId="mission_40050_objective_11"},{langId="mission_40060_objective_01"},{langId="mission_40060_objective_02"},{langId="mission_40060_objective_03"},{langId="mission_40060_objective_04"},{langId="mission_40060_objective_05"},{langId="mission_40060_objective_06"},{langId="mission_40060_objective_07"},{langId="mission_40070_objective_01"},{langId="mission_40070_objective_02"},{langId="mission_40070_objective_03"},{langId="mission_40070_objective_04"},{langId="mission_40070_objective_06"},{langId="mission_40070_objective_07"},{langId="mission_40080_objective_01"},{langId="mission_40080_objective_02"},{langId="mission_40090_objective_03"},{langId="mission_40090_objective_04"},{langId="mission_40090_objective_05"},{langId="mission_40145_objective_01"},{langId="mission_40145_objective_02"},{langId="mission_40150_objective_01"},{langId="mission_40150_objective_02"},{langId="mission_40150_objective_03"},{langId="mission_40150_objective_04"},{langId="mission_40150_objective_05"},{langId="mission_40150_objective_06"},{langId="mission_40150_objective_07"},{langId="mission_40160_objective_01"},{langId="mission_40170_objective_01"},{langId="mission_40170_objective_02"},{langId="mission_40170_objective_03"},{langId="mission_40180_objective_01"},{langId="mission_40180_objective_02"},{langId="mission_40220_objective_03"},{langId="mission_40230_objective_01"},{langId="mission_40230_objective_02"},{langId="mission_40240_objective_01"},{langId="mission_40250_objective_01"},{langId="mission_40250_objective_02"},{langId="mission_40260_objective_01"},{langId="mission_40260_objective_02"},{langId="mission_40260_objective_03"},{langId="mission_40260_objective_04"},{langId="mission_40260_objective_05"},{langId="mission_40260_objective_06"},{langId="mission_40260_objective_07"},{langId="mission_40260_objective_08"},{langId="mission_40260_objective_09"},{langId="mission_common_objective_accessToAI"},{langId="mission_common_objective_bootDigger"},{langId="mission_common_objective_defeatCreatures"},{langId="mission_common_objective_defeatZombies"},{langId="mission_common_objective_defendDigger_coop"},{langId="mission_common_objective_defendDigger_single"},{langId="mission_common_objective_enterRuin"},{langId="mission_common_objective_gatherFood"},{langId="mission_common_objective_getDiggerParts"},{langId="mission_common_objective_getMemoryBoard"},{langId="mission_common_objective_getMemoryBoard_atRuin"},{langId="mission_common_objective_learnSkill"},{langId="mission_common_objective_openMAP"},{langId="mission_common_objective_putDigger"},{langId="mission_common_objective_rebootTransporter"},{langId="mission_common_objective_rescueVictim"},{langId="mission_common_objective_returnToBase"},{langId="mission_common_objective_returnToBase_byFT"},{langId="mission_common_objective_returnToFOB"}}MissionObjectiveInfoSystem.DEBUG_SetLangIdTable(e)
  end
end
function this.OnReload()
  this.Init()
end
function this.OnMessage(i,n,a,o,t,s,_)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,i,n,a,o,t,s,_)
end
function this.OnChangeSVars(e,e)
end
function this.DisableGameStatusOnFade(e)
  local i={S_DISABLE_NPC=false}
  if n(e)then
    for e,n in pairs(e)do
      i[e]=n
    end
  end
  Tpp.SetGameStatus{target="all",enable=false,except=i,scriptName="TppUI.lua"}
end
function this.DisableGameStatusOnFadeOutEnd()
  Tpp.SetGameStatus{target="all",enable=false,scriptName="TppUI.lua"}
end
function this.EnableGameStatusOnFadeInStart()
  Tpp.SetGameStatus{target={S_DISABLE_NPC=true,S_DISABLE_NPC_NOTICE=true,S_DISABLE_TARGET=true,S_DISABLE_PLAYER_PAD=true,S_DISABLE_PLAYER_DAMAGE=true,S_DISABLE_THROWING=true,S_DISABLE_PLACEMENT=true},enable=true,scriptName="TppUI.lua"}
end
function this.EnableGameStatusOnFade()
  local e,i
  if n(mvars.ui_onEndFadeInExceptGameStatus)then
    i=mvars.ui_onEndFadeInExceptGameStatus
  elseif n(mvars.ui_onEndFadeInOverrideExceptGameStatusTemporary)then
    i=mvars.ui_onEndFadeInOverrideExceptGameStatusTemporary
  else
    if TppDemo.IsNotPlayable()then
      e=e or{}
      for n,i in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
        e[n]=false
      end
      e.PauseMenu=nil
      e.InfoTypingText=nil
    end
  end
  if i then
    e={}
    for i,n in pairs(i)do
      e[i]=n
    end
  end
  Tpp.SetGameStatus{target="all",enable=true,except=e,scriptName="TppUI.lua"}
end
function this.SetDefaultGameOverMenu()
  local n=TppMission.IsMultiPlayMission(vars.missionCode)
  this._SetGameOverMenu(n)
end
function this.SetGameOverMenu(e)
  if not n(e)or not next(e)then
    return
  end
  GameOverMenuSystem.RegisterGameOverMenuItems(e)
end
function this.SetDefenseGameMenu()
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    return
  end
  if n(mvars.ui_unsetPauseMenuSetting)then
    table.insert(mvars.ui_unsetPauseMenuSetting,GamePauseMenu.RETURN_TO_BASE)
  else
    mvars.ui_unsetPauseMenuSetting={GamePauseMenu.RETURN_TO_BASE}
  end
  this._UpdateSingleMissionPauseMenuList()
  if n(mvars.ui_unsetGameOverMenuSetting)then
    table.insert(mvars.ui_unsetGameOverMenuSetting,GameOverMenuType.RETURN_TO_BASE)
  else
    mvars.ui_unsetGameOverMenuSetting={GameOverMenuType.RETURN_TO_BASE}
  end
  this._SetGameOverMenu()
end
function this.UnsetDefenseGameMenu()
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    return
  end
  local i=function(n,t)
    local e
    for i,n in ipairs(n)do
      if n==t then
        e=i
        break
      end
    end
    return e
  end
  if n(mvars.ui_unsetPauseMenuSetting)then
    local e=i(mvars.ui_unsetPauseMenuSetting,GamePauseMenu.RETURN_TO_BASE)
    if e then
      table.remove(mvars.ui_unsetPauseMenuSetting,e)
    end
  end
  this._UpdateSingleMissionPauseMenuList()
  if n(mvars.ui_unsetGameOverMenuSetting)then
    local e=i(mvars.ui_unsetGameOverMenuSetting,GameOverMenuType.RETURN_TO_BASE)
    if e then
      table.remove(mvars.ui_unsetGameOverMenuSetting,e)
    end
  end
  this._SetGameOverMenu()
end
function this._UpdateCoopMissionPauseMenuList()
  local n=this._GetCoopMissionPauseMenuList()
  this._UpdatePauseMenu(n)
end
function this._GetCoopMissionPauseMenuList()
  if Mission.EnableAbandonMissionForPauseMenu()then
    return{GamePauseMenu.ABANDON_MATCH,GamePauseMenu.ONLINE_NEWS,GamePauseMenu.STORE_ITEM,GamePauseMenu.RECORDS_ITEM,GamePauseMenu.CONTROLS_AND_TIPS_ITEM,GamePauseMenu.OPEN_OPTION_MENU}
  else
    return{GamePauseMenu.RETURN_TO_TITLE,GamePauseMenu.ONLINE_NEWS,GamePauseMenu.STORE_ITEM,GamePauseMenu.RECORDS_ITEM,GamePauseMenu.CONTROLS_AND_TIPS_ITEM,GamePauseMenu.OPEN_OPTION_MENU}
  end
end
function this._UpdateSingleMissionPauseMenuList()
  local n={GamePauseMenu.RESTART_FROM_CHECK_POINT,GamePauseMenu.RETURN_TO_BASE,GamePauseMenu.RETURN_TO_TITLE,GamePauseMenu.ONLINE_NEWS,GamePauseMenu.STORE_ITEM,GamePauseMenu.RECORDS_ITEM,GamePauseMenu.CONTROLS_AND_TIPS_ITEM,GamePauseMenu.OPEN_OPTION_MENU}
  this._UpdatePauseMenu(n)
end
function this._UpdatePauseMenu(i)
  if not n(i)then
    return
  end
  if Tpp.DEBUG_Where then
  end
  if mvars.ui_unsetPauseMenuSetting then
    this._DeletePauseMenu(i,mvars.ui_unsetPauseMenuSetting)
  end
  TppUiCommand.RegisterPauseMenuPage(i)
end
function this._DeletePauseMenu(i,e)
  if not n(e)then
    return
  end
  for e,t in ipairs(e)do
    local e
    for n,i in ipairs(i)do
      if i==t then
        e=n
        break
      end
    end
    if e then
      table.remove(i,e)
    end
  end
end
function this._SetGameOverMenu(t)
  local e={}
  local n=function(i,e)
    if not mvars.ui_unsetGameOverMenuSetting then
      table.insert(i,e)
    else
      local n=false
      for t,i in ipairs(mvars.ui_unsetGameOverMenuSetting)do
        if i==e then
          n=true
          break
        end
      end
      if not n then
        table.insert(i,e)
      end
    end
  end
  if not t then
    n(e,GameOverMenuType.CONTINUE_FROM_CHECK_POINT)n(e,GameOverMenuType.RETURN_TO_BASE)
  end
  GameOverMenuSystem.RegisterGameOverMenuItems(e)
end
return this
