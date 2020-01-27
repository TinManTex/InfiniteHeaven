local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local IsTypeNumber=Tpp.IsTypeNumber
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local SVarsIsSynchronized=TppScriptVars.SVarsIsSynchronized
local RegistPlayRecord=PlayRecord.RegistPlayRecord
local bnot=bit.bnot
local band,bor,bxor=bit.band,bit.bor,bit.bxor
local TimerStart=GkEventTimerManager.Start
local TimerStop=GkEventTimerManager.Stop
local IsTimerActive=GkEventTimerManager.IsTimerActive
local IsNotAlert=Tpp.IsNotAlert
local IsPlayerStatusNormal=Tpp.IsPlayerStatusNormal
local IsDemoPlaying=DemoDaemon.IsDemoPlaying
local unkM11=10
local unkM10=3
local unkM9=5
local unkM8=2.5
local Timer_outsideOfInnerZoneStr="Timer_outsideOfInnerZone"
local unkM6=0
local unkM5=64
local unkM4=1
local unkM3=0
local dayInSeconds=(24*60)*60
local unkM1=2
local MAX_32BIT_UINT=TppDefine.MAX_32BIT_UINT
local function UnkFunc1()
  RegistPlayRecord"MISSION_TIMER_UPDATE"
end
function this.GetMissionID()
  return vars.missionCode
end
function this.GetMissionName()
  return mvars.mis_missionName
end
function this.GetMissionClearType()
  return svars.mis_missionClearType
end
function this.IsDefiniteMissionClear()
  return svars.mis_isDefiniteMissionClear
end
function this.RegiserMissionSystemCallback(callbacks)
  this.RegisterMissionSystemCallback(callbacks)
end
function this.RegisterMissionSystemCallback(callbacks)
  if IsTypeTable(callbacks)then
    if IsTypeFunc(callbacks.OnEstablishMissionClear)then
      this.systemCallbacks.OnEstablishMissionClear=callbacks.OnEstablishMissionClear
    end
    if IsTypeFunc(callbacks.OnDisappearGameEndAnnounceLog)then
      this.systemCallbacks.OnDisappearGameEndAnnounceLog=callbacks.OnDisappearGameEndAnnounceLog
    end
    if IsTypeFunc(callbacks.OnEndMissionCredit)then
      this.systemCallbacks.OnEndMissionCredit=callbacks.OnEndMissionCredit
    end
    if IsTypeFunc(callbacks.OnEndMissionReward)then
      this.systemCallbacks.OnEndMissionReward=callbacks.OnEndMissionReward
    end
    if IsTypeFunc(callbacks.OnGameOver)then
      this.systemCallbacks.OnGameOver=callbacks.OnGameOver
    end
    if IsTypeFunc(callbacks.OnOutOfMissionArea)then
      this.systemCallbacks.OnOutOfMissionArea=callbacks.OnOutOfMissionArea
    end
    if IsTypeFunc(callbacks.OnUpdateWhileMissionPrepare)then
      this.systemCallbacks.OnUpdateWhileMissionPrepare=callbacks.OnUpdateWhileMissionPrepare
    end
    if IsTypeFunc(callbacks.OnFinishBlackTelephoneRadio)then
      this.systemCallbacks.OnFinishBlackTelephoneRadio=callbacks.OnFinishBlackTelephoneRadio
    end
    if IsTypeFunc(callbacks.OnOutOfHotZone)then
    end
    if IsTypeFunc(callbacks.OnOutOfHotZoneMissionClear)then
      this.systemCallbacks.OnOutOfHotZoneMissionClear=callbacks.OnOutOfHotZoneMissionClear
    end
    if IsTypeFunc(callbacks.OnUpdateStorySequenceInGame)then
      this.systemCallbacks.OnUpdateStorySequenceInGame=callbacks.OnUpdateStorySequenceInGame
    end
    if IsTypeFunc(callbacks.CheckMissionClearFunction)then
      this.systemCallbacks.CheckMissionClearFunction=callbacks.CheckMissionClearFunction
    end
    if IsTypeFunc(callbacks.OnReturnToMission)then
      this.systemCallbacks.OnReturnToMission=callbacks.OnReturnToMission
    end
    if IsTypeFunc(callbacks.OnAddStaffsFromTempBuffer)then
      this.systemCallbacks.OnAddStaffsFromTempBuffer=callbacks.OnAddStaffsFromTempBuffer
    end
    if IsTypeFunc(callbacks.CheckMissionClearOnRideOnFultonContainer)then
      this.systemCallbacks.CheckMissionClearOnRideOnFultonContainer=callbacks.CheckMissionClearOnRideOnFultonContainer
    end
    if IsTypeFunc(callbacks.OnRecovered)then
      this.systemCallbacks.OnRecovered=callbacks.OnRecovered
    end
    if IsTypeFunc(callbacks.OnSetMissionFinalScore)then
      this.systemCallbacks.OnSetMissionFinalScore=callbacks.OnSetMissionFinalScore
    end
    if IsTypeFunc(callbacks.OnEndDeliveryWarp)then
      this.systemCallbacks.OnEndDeliveryWarp=callbacks.OnEndDeliveryWarp
    end
    if IsTypeFunc(callbacks.OnMissionGameEndFadeOutFinish)then
      this.systemCallbacks.OnMissionGameEndFadeOutFinish=callbacks.OnMissionGameEndFadeOutFinish
    end
    if IsTypeFunc(callbacks.OnFultonContainerMissionClear)then
      this.systemCallbacks.OnFultonContainerMissionClear=callbacks.OnFultonContainerMissionClear
    end
    if IsTypeFunc(callbacks.OnOutOfDefenseGameArea)then
      this.systemCallbacks.OnOutOfDefenseGameArea=callbacks.OnOutOfDefenseGameArea
    end
    if IsTypeFunc(callbacks.OnAlertOutOfDefenseGameArea)then
      this.systemCallbacks.OnAlertOutOfDefenseGameArea=callbacks.OnAlertOutOfDefenseGameArea
    end
  end
end
function this.UpdateObjective(s)
  if not mvars.mis_missionObjectiveDefine then
    return
  end
  if mvars.mis_objectiveSetting then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
  local n=s.radio
  local a=s.radioSecond
  local t=s.options
  mvars.mis_objectiveSetting=s.objectives
  mvars.mis_updateObjectiveRadioGroupName=nil
  if not IsTypeTable(mvars.mis_objectiveSetting)then
    return
  end
  local s=false
  for n,i in pairs(mvars.mis_objectiveSetting)do
    local n=not this.IsEnableMissionObjective(i)
    if n then
      n=not this.IsEnableAnyParentMissionObjective(i)
    end
    if n then
      s=true
      break
    end
  end
  if IsTypeTable(n)then
    if s then
      mvars.mis_updateObjectiveRadioGroupName=TppRadio.GetRadioNameAndRadioIDs(n.radioGroups)
      local e=this.GetObjectiveRadioOption(n)
      TppRadio.Play(n.radioGroups,e)
    end
  end
  if IsTypeTable(a)then
    if s then
      local e=this.GetObjectiveRadioOption(a)
      e.isEnqueue=true
      TppRadio.Play(a.radioGroups,e)
    end
  end
  if not IsTypeTable(n)then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
function this.UpdateCheckPoint(e)
  TppCheckPoint.Update(e)
end
function this.UpdateCheckPointAtCurrentPosition()
  TppCheckPoint.UpdateAtCurrentPosition()
end
function this.EnableBaseCheckPoint()
  mvars.frm_disableBaseCheckPoint=false
end
function this.DisableBaseCheckPoint()
  mvars.frm_disableBaseCheckPoint=true
end
function this.IsBaseCheckPointEnabled()
  return(not mvars.frm_disableBaseCheckPoint)
end
function this.IsMatchStartLocation(e)
  local e=TppPackList.GetLocationNameFormMissionCode(e)
  if TppLocation.IsAfghan()then
    local e=TppDefine.LOCATION_ID[e]
    if e~=TppDefine.LOCATION_ID.AFGH and e~=TppDefine.LOCATION_ID.SSD_AFGH then
      return false
    end
  elseif TppLocation.IsMiddleAfrica()then
    if TppDefine.LOCATION_ID[e]~=TppDefine.LOCATION_ID.MAFR then
      return false
    end
  elseif TppLocation.IsMotherBase()then
    if TppDefine.LOCATION_ID[e]~=TppDefine.LOCATION_ID.MTBS then
      return false
    end
  else
    return false
  end
  return true
end
function this.RegistDiscoveryGameOver()
  mvars.mis_isExecuteGameOverOnDiscoveryNotice=true
end
function this.IsStartFromFreePlay()
  return gvars.mis_isStartFromFreePlay
end
function this.AcceptMission(n)
  this.SetNextMissionCodeForMissionClear(n)
end
function this.AcceptMissionOnFreeMission(n,a,s)
  local i=this.IsMatchStartLocation(n)
  if not i then
    return
  end
  local i=SsdMissionList.NO_ORDER_BOX_MISSION_ENUM[tostring(n)]
  if i then
    this.ReserveMissionClear{nextMissionId=n,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
    return
  end
  local i=n
  if this.IsHardMission(i)then
    i=this.GetNormalMissionCodeFromHardMission(i)
  end
  local a=a[i]
  if a==nil then
    return
  end
  if not this.IsSysMissionId(n)then
    MissionListMenuSystem.SetCurrentMissionCode(n)
  end
  svars[s]=n
  TppScriptBlock.Load("orderBoxBlock",i,true)
  return true
end
function this.Reload(n)
  local r,o,a,i,t
  if n then
    r=n.isNoFade
    o=n.missionPackLabelName
    a=n.locationCode
    t=n.showLoadingTips
    mvars.mis_nextLayoutCode=n.layoutCode
    mvars.mis_nextClusterId=n.clusterId
    i=n.OnEndFadeOut
  end
  if t~=nil then
    mvars.mis_showLoadingTipsOnReload=t
  else
    mvars.mis_showLoadingTipsOnReload=true
  end
  if o then
    mvars.mis_missionPackLabelName=o
  end
  if a then
    mvars.mis_nextLocationCode=a
  end
  if i and IsTypeFunc(i)then
    mvars.mis_reloadOnEndFadeOut=i
  else
    mvars.mis_reloadOnEndFadeOut=nil
  end
  gvars.mis_tempSequenceNumberForReload=svars.seq_sequence
  if r then
    this.ExecuteReload()
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ReloadFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
  end
end
function this.RestartMission(n)
  local s
  local i
  if n then
    s=n.isNoFade
    i=n.isReturnToMission
  end
  TppMain.EnablePause()
  if i then
    mvars.mis_isReturnToMission=true
  end
  if s then
    this.ExecuteRestartMission(mvars.mis_isReturnToMission)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"RestartMissionFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ExecuteRestartMission(n)
  this.SafeStopSettingOnMissionReload()
  TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()
  TppPlayer.ResetInitialPosition()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)
  if not n then
    this.VarResetOnNewMission()
  end
  local i
  if n then
    i=this.ExecuteOnReturnToMissionCallback()
  end
  local s=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
  if s then
    local e=TppDefine.LOCATION_ID[s]
    if e then
      vars.locationCode=e
    end
  end
  local s=nil
  if n then
    s=vars.missionCode
    vars.missionCode=this.GetFreeMissionCode()
  end
  TppSave.VarSave()
  if mvars.mis_needSaveConfigOnNewMission then
    TppSave.VarSaveConfig()
  end
  local n=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    local n={force=true}
    this.RequestLoad(vars.missionCode,s,n)
  end
  if i then
    this.ShowAnnounceLogOnFadeOut(n)
  else
    n()
  end
end
function this.ContinueFromCheckPoint(loadInfo)
  local a
  local s
  local i
  if loadInfo then
    a=loadInfo.isNoFade
    s=loadInfo.isReturnToMission
    i=loadInfo.isNeedUpdateBaseManagement
  end
  TppMain.EnablePause()
  if s then
    mvars.mis_isReturnToMission=true
  end
  if i then
    mvars.isNeedUpdateBaseManagement=true
  end
  if a then
    this.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission,mvars.isNeedUpdateBaseManagement)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ContinueFromCheckPointFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ReturnToMission(n)
  local n=n or{}n.isReturnToMission=true
  this.DisableInGameFlag()
  this.RestartMission(n)
end
function this.ReturnToFreeMission()
  mvars.mis_abortWithSave=false
  mvars.mis_nextMissionCodeForAbort=this.GetFreeMissionCode()
  this.ExecuteMissionAbort()
  this.DisconnectMatching(false)
end
function this.ReturnToMatchingRoom()
  if IS_GC_2017_COOP then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)
    this.DisconnectMatching(false)
    this.GameOverReturnToTitle()
    return
  end
  mvars.mis_abortWithSave=false
  mvars.mis_nextMissionCodeForAbort=this.GetCoopLobbyMissionCode()
  this.ExecuteMissionAbort()
end
function this.ExecuteContinueFromCheckPoint(n,n,a,t)
  TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()
  TppWeather.OnEndMissionPrepareFunction()
  this.SafeStopSettingOnMissionReload()
  this._OnEstablishMissionEnd()
  TppUI.PreloadLoadingTips(0)
  local s=vars.missionCode
  this.IncrementRetryCount()
  if TppSystemUtility.GetCurrentGameMode()=="TPP"then
    TppEnemy.StoreSVars(true)
  end
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT)
  TppPlayer.StorePlayerDecoyInfos()
  TppRadioCommand.StoreRadioState()
  local n
  if a then
    n=this.ExecuteOnReturnToMissionCallback()
  end
  if Tpp.IsEditorNoLogin()then
    TppSave.VarSave()
    TppSave.SaveGameData(vars.missionCode,nil,nil,true)
    local i=function()
      TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")SsdBuilding.SetLevel{level=0}
      this.RequestLoad(vars.missionCode,s)
    end
    if n then
      TppSave.LoadFromServer()
      this.ShowAnnounceLogOnFadeOut(i)
    else
      gvars.sav_needCheckPointSaveOnMissionStart=true
      TppSave.LoadFromServer(i)
    end
    return
  end
  local n={}
  local s=function()n={}n.sav_continueForOutOfBaseArea=gvars.sav_continueForOutOfBaseArea
    n.mis_gameoverCount=gvars.mis_gameoverCount
    n.ply_startPosX=gvars.ply_startPosTempForBaseDefense[0]n.ply_startPosY=gvars.ply_startPosTempForBaseDefense[1]n.ply_startPosZ=gvars.ply_startPosTempForBaseDefense[2]n.ply_startRotY=gvars.ply_startPosTempForBaseDefense[3]
  end
  local n=function()
    if not IsTypeTable(n)then
      return
    end
    gvars.sav_continueForOutOfBaseArea=n.sav_continueForOutOfBaseArea
    gvars.mis_gameoverCount=n.mis_gameoverCount
    gvars.ply_startPosTempForBaseDefense[0]=n.ply_startPosX
    gvars.ply_startPosTempForBaseDefense[1]=n.ply_startPosY
    gvars.ply_startPosTempForBaseDefense[2]=n.ply_startPosZ
    gvars.ply_startPosTempForBaseDefense[3]=n.ply_startRotY
    n={}
  end
  local n=function()
    local e=TppStory.GetCurrentStorySequence()s()
    TppVarInit.InitializeOnNewGame()
    TppScriptVars.InitOnTitle()Player.ResetVarsOnMissionStart()
    TppSave.ReserveVarRestoreForContinue()n()
    gvars.mis_skipOnPreLoadForContinue=true
    gvars.sav_needCheckPointSaveOnMissionStart=false
    gvars.mis_skipUpdateBaseManagement=true
    gvars.str_storySequence=Mission.GetServerStorySequence()
    if not gvars.str_storySequence or gvars.str_storySequence==0 then
      gvars.str_storySequence=e
    end
    if t then
      gvars.mis_skipUpdateBaseManagement=false
    end
    Mission.InitializeDlcMission()
  end
  local e=function()Mission.AddFinalizer(n)
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    local n,i=Mission.GetServerMissionInfo()
    if n==TppDefine.MISSION_CODE_NONE then
      n=TppDefine.SYS_MISSION_ID.TITLE
      i=TppDefine.LOCATION_ID.INIT
    elseif i==0 then
      i=TppDefine.LOCATION_ID[TppPackList.GetLocationNameFormMissionCode(n)]
    end
    vars.missionCode=n
    vars.locationCode=i
    this.RequestLoad(n,nil,{force=true})
  end
  TppSave.LoadFromServer(e)
end
function this.IncrementRetryCount()PlayRecord.RegistPlayRecord"MISSION_RETRY"Tpp.IncrementPlayData"totalRetryCount"TppSequence.IncrementContinueCount()
end
function this.ExecuteOnReturnToMissionCallback()
  local n
  if this.systemCallbacks and this.systemCallbacks.OnReturnToMission then
    n=this.systemCallbacks.OnReturnToMission
  end
  if n then
    TppMain.DisablePause()Player.SetPause()
    TppUiStatusManager.ClearStatus"AnnounceLog"n()
    TppTerminal.AddStaffsFromTempBuffer()
    TppSave.VarSave()
    TppSave.SaveGameData(nil,nil,nil,true)
  end
  return n
end
function this.CanAbortMission()
  if not this.CheckMissionState(isExecMissionClear,true)then
    return false
  end
  if mvars.mis_isAborting then
    return false
  end
  if TppGameStatus.IsSet("TppMission","S_IS_BLACK_LOADING")then
    return false
  end
  return true
end
function this.AbortMission(n)
  local S
  local M
  local s
  local O
  local v
  local c
  local a
  local p
  local u
  local l
  local d
  local o,r,t=0,0,TppUI.FADE_SPEED.FADE_NORMALSPEED
  local m
  local f
  local T
  if IsTypeTable(n)then
    S=n.isNoFade
    c=n.emergencyMissionId
    a=n.nextMissionId
    p=n.nextLayoutCode
    u=n.nextClusterId
    l=n.nextMissionStartRoute
    O=n.isExecMissionClear
    M=n.isNoSave
    d=n.isAlreadyGameOver
    v=n.isContinueCurrentPos
    if n.delayTime then
      o=n.delayTime
    end
    if n.fadeDelayTime then
      r=n.fadeDelayTime
    end
    if n.fadeSpeed then
      t=n.fadeSpeed
    end
    m=n.presentationFunction
    s=n.isTitleMode
    f=n.playRadio
    if s then
      a=TppDefine.SYS_MISSION_ID.TITLE
    elseif mvars.mis_reservedNextMissionCodeForAbort then
      a=mvars.mis_reservedNextMissionCodeForAbort
    end
    if n.isNoSurviveBox then
      T=true
    end
  end
  if not this.CanAbortMission()then
    return
  end
  if o then
    mvars.mis_missionAbortDelayTime=o
  end
  if r then
    mvars.mis_missionAbortFadeDelayTime=r
  end
  if t then
    mvars.mis_missionAbortFadeSpeed=t
  end
  mvars.mis_abortPresentationFunction=m
  if s then
    mvars.mis_abortIsTitleMode=s
  end
  mvars.mis_abortWithPlayRadio=f
  mvars.mis_emergencyMissionCode=c
  mvars.mis_nextMissionCodeForAbort=a
  mvars.mis_nextLayoutCodeForAbort=p
  mvars.mis_nextClusterIdForAbort=u
  mvars.mis_nextMissionStartRouteForAbort=l
  if M then
    mvars.mis_abortWithSave=false
  else
    mvars.mis_abortWithSave=true
  end
  if S then
    mvars.mis_abortWithFade=false
  else
    mvars.mis_abortWithFade=true
  end
  if v then
    mvars.mis_isResetMissionPosition=false
  else
    mvars.mis_isResetMissionPosition=true
  end
  if T then
    mvars.mis_abortWithoutSurviveBox=true
  end
  if not d then
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ABORT,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA,true)
  else
    this.EstablishedMissionAbort()
  end
end
function this.ExecuteMissionAbort()
  this.VarSaveForMissionAbort()
  this.LoadForMissionAbort()
end
function this.VarSaveForMissionAbort()
  if not mvars.mis_nextMissionCodeForAbort then
    Tpp.DEBUG_Fatal"Not defined next missionId!!"this.RestartMission()
    return
  end
  this.SafeStopSettingOnMissionReload()
  local n=vars.missionCode
  if gvars.ini_isTitleMode then
    gvars.title_nextMissionCode=TppDefine.SYS_MISSION_ID.TITLE
    gvars.title_nextLocationCode=TppDefine.LOCATION_ID.INIT
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.TITLE
    TppVarInit.InitializeForNewMission{}Player.SetPause()
  else
    SsdFlagMission.Abort()
  end
  MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)
  if mvars.mis_missionAbortLoadingOption==nil then
    mvars.mis_missionAbortLoadingOption={}
  end
  local a=this.IsFreeMission(n)
  local s=this.IsFreeMission(mvars.mis_nextMissionCodeForAbort)
  local t=mvars.mis_isResetMissionPosition
  vars.missionCode=mvars.mis_nextMissionCodeForAbort
  mvars.mis_abortCurrentMissionCode=n
  local i=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
  if i then
    local e=TppDefine.LOCATION_ID[i]
    if e then
      vars.locationCode=e
    end
  end
  TppCrew.FinishMission(n)
  TppEnemy.ClearDDParameter()
  if mvars.mis_abortWithSave then
    TppPlayer.SaveCaptureAnimal()
    TppClock.SaveMissionStartClock()
    TppWeather.SaveMissionStartWeather()
    TppTerminal.AddStaffsFromTempBuffer()
    if gvars.solface_groupNumber>=4294967295 then
      gvars.solface_groupNumber=0
    else
      gvars.solface_groupNumber=gvars.solface_groupNumber+1
    end
    gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)SsdSbm.StoreToSVars()Gimmick.StoreSaveDataPermanentGimmickFromMission()
    TppGimmick.DecrementCollectionRepopCount()
    TppBuddyService.SetVarsMissionStart()
    if s then
      TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
    end
  else
    TppPlayer.ResetMissionStartPosition()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  end
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT,a,s,t,mvars.mis_abortWithSave)
  TppWeather.OnEndMissionPrepareFunction()
  this.VarResetOnNewMission()
  gvars.mis_orderBoxName=0
  if gvars.ini_isTitleMode then
    mvars.mis_missionAbortLoadingOption.showLoadingTips=false
    gvars.ini_isReturnToTitle=true
  else
    if this.IsInitMission(vars.missionCode)then
      return
    end
    local e=false
    if mvars.mis_abortWithSave then
      e=true
    end
    gvars.sav_needCheckPointSaveOnMissionStart=true
    TppSave.VarSave(n,e)
    TppSave.SaveGameData(n,nil,nil,true,e)
    if mvars.mis_needSaveConfigOnNewMission then
      TppSave.VarSaveConfig()
      TppSave.SaveConfigData(nil,nil,reserveNextMissionStart)
    end
  end
end
function this.LoadForMissionAbort()
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  this.RequestLoad(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)
end
function this.ReturnToTitle()
  local n
  if this.IsMultiPlayMission(vars.missionCode)then
    this.DisconnectMatching(false)
    TppGameStatus.Reset("SimpleMissionController","S_IS_ONLINE")
    TppGameStatus.Reset("SimpleMissionController","S_IS_MULTIPLAY")
    n=true
  end
  vars.invitationDisableRecieveFlag=1
  this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.TITLE,isNoSave=true,isTitleMode=true,isAlreadyGameOver=n}
end
function this.GameOverReturnToTitle()
  if IS_GC_2017_COOP then
    mvars.mis_missionAbortLoadingOption={showLoadingTips=true,waitOnLoadingTipsEnd=false}
  end
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=vars.locationCode
  gvars.ini_isTitleMode=true
  mvars.mis_abortWithSave=false
  mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.TITLE
  vars.invitationDisableRecieveFlag=1
  this.ExecuteMissionAbort()
end
function this.ReturnToTitleForException()
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=vars.locationCode
  gvars.ini_isTitleMode=false
  mvars.mis_abortWithSave=false
  mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.INIT
  gvars.mis_tempSequenceNumberForReload=0
  vars.invitationDisableRecieveFlag=1
  this.ExecuteMissionAbort()
end
function this.ReturnToTitleWithSave()
  vars.invitationDisableRecieveFlag=1
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"ReturnToTitleWithSave",TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
end
function this.ExecuteReturnToTitleWithSave()
  if TppSave.IsSaving()then
    TimerStart("Timer_WaitSavingForReturnToTitle",1)
    return
  end
  TppSave.AddServerSaveCallbackFunc(this.ReturnToTitle)
  this.VarSaveOnUpdateCheckPoint()
end
function this.ReserveGameOver(n,i,s)
  if svars.mis_isDefiniteMissionClear then
    return false
  end
  mvars.mis_isAborting=s
  mvars.mis_isReserveGameOver=true
  svars.mis_isDefiniteGameOver=true
  if type(n)=="number"and n<TppDefine.GAME_OVER_TYPE.MAX then
    svars.mis_gameOverType=n
  end
  if type(i)=="number"and i<TppDefine.GAME_OVER_RADIO.MAX then
    svars.mis_gameOverRadio=i
  end
  if this.IsMultiPlayMission(vars.missionCode)then
    TppUI.PreloadLoadingTips(1)
  else
    TppUI.PreloadLoadingTips(0)
  end
  local n=vars.missionCode
  if not this.IsMultiPlayMission(n)and not this.IsInitMission(n)then
    local n=svars.mis_gameOverType
    if n==TppDefine.GAME_OVER_TYPE.PLAYER_DEAD or n==TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD then
      TppUI.SetDefaultGameOverMenu()
    else
      TppUI.SetGameOverMenu{GameOverMenuType.CONTINUE_FROM_CHECK_POINT}
    end
    if n~=TppDefine.GAME_OVER_TYPE.ABORT then
      this.IncrementGameOverCount()
    end
  else
    TppUI.SetDefaultGameOverMenu()
  end
  return true
end
function this.ReserveGameOverOnPlayerKillChild(n)
  if not mvars.mis_childGameObjectIdKilledPlayer then
    mvars.mis_childGameObjectIdKilledPlayer=n
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_KILL_CHILD_SOLDIER,TppDefine.GAME_OVER_RADIO.PLAYER_KILL_CHILD_SOLDIER)
  end
end
function this.IsGameOver()
  return svars.mis_isDefiniteGameOver
end
function this.IncrementGameOverCount()
  if gvars.mis_gameoverCount<255 then
    gvars.mis_gameoverCount=gvars.mis_gameoverCount+1
  end
end
function this.ResetGameOverCount()
  gvars.mis_gameoverCount=0
end
function this.GetGameOverCount()
  return gvars.mis_gameoverCount
end
function this.CanMissionClear(e)
  mvars.mis_needSetCanMissionClear=true
  if IsTypeTable(e)then
    if e.jingle then
      mvars.mis_canMissionClearNeedJingle=e.jingle
    else
      mvars.mis_canMissionClearNeedJingle=true
    end
  end
end
function this._SetCanMissionClear()
  mvars.mis_needSetCanMissionClear=false
  if svars.mis_canMissionClear then
    return
  end
  svars.mis_canMissionClear=true
end
function this.IsCanMissionClear()
  return svars.mis_canMissionClear
end
function this.OnCanMissionClear()
  if mvars.mis_canMissionClearNeedJingle~=false then
    TppSound.PostJingleOnCanMissionClear()
  end
  local e=mvars.snd_bgmList
  if e and e.bgm_escape then
    mvars.mis_needSetEscapeBgm=true
  end
end
function this.SetMissionClearState(e)
  if gvars.mis_missionClearState<e then
    gvars.mis_missionClearState=e
    return true
  else
    return false
  end
end
function this.ResetMissionClearState()
  gvars.mis_missionClearState=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET
end
function this.GetMissionClearState()
  return gvars.mis_missionClearState
end
function this.ReserveMissionClear(n)
  if svars.mis_isDefiniteGameOver then
    return false
  end
  if mvars.mis_isReserveMissionClear or svars.mis_isDefiniteMissionClear then
    return false
  end
  mvars.mis_isReserveMissionClear=true
  mvars.mis_isResetMissionPosition=false
  mvars.mis_isLocationChangeWithFastTravel=false
  gvars.mis_skipUpdateBaseManagement=true
  if n then
    if n.missionClearType then
      svars.mis_missionClearType=n.missionClearType
    end
    if n.nextMissionId then
      this.SetNextMissionCodeForMissionClear(n.nextMissionId)
    end
    if n.resetPlayerPos then
      mvars.mis_isResetMissionPosition=n.resetPlayerPos
    end
    if n.isLocationChangeWithFastTravel then
      mvars.mis_isLocationChangeWithFastTravel=n.isLocationChangeWithFastTravel
    end
  end
  svars.mis_isDefiniteMissionClear=true
  if this.IsMultiPlayMission(vars.missionCode)then
    TppUI.PreloadLoadingTips(1)
  else
    TppUI.PreloadLoadingTips(0)
  end
  return true
end
function this.MissionGameEnd(n)
  local a=0
  local s=0
  local t=TppUI.FADE_SPEED.FADE_NORMALSPEED
  if IsTypeTable(n)then
    a=n.delayTime or 0
    t=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    s=n.fadeDelayTime or 0
    if n.loadStartOnResult~=nil then
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=n.loadStartOnResult
    else
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=false
    end
  end
  if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
    this.SetNeedWaitMissionInitialize()
  else
    this.ResetNeedWaitMissionInitialize()
  end
  MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)
  mvars.mis_missionGameEndDelayTime=a
  this.ResetGameOverCount()
  this.FadeOutOnMissionGameEnd(s,t,"MissionGameEndFadeOutFinish")PlayRecord.RegistPlayRecord"MISSION_CLEAR"end
function this.FadeOutOnMissionGameEnd(s,n,i)
  if s==0 then
    this._FadeOutOnMissionGameEnd(n,i)
  else
    mvars.mis_missionGameEndFadeSpeed=n
    mvars.mis_missionGameEndFadeId=i
    TimerStart("Timer_FadeOutOnMissionGameEndStart",s)
  end
end
function this._FadeOutOnMissionGameEnd(e,n)
  TppUI.FadeOut(e,n,TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
end
function this.CheckGameOverDemo(e)
  if e>TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK then
    return false
  end
  if band(svars.mis_gameOverType,TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK)==e then
    return true
  else
    return false
  end
end
function this.ShowGameOverMenu(s)
  local n
  if IsTypeTable(s)then
    if type(s.delayTime)=="number"then
      n=s.delayTime
    end
  end
  if(Tpp.IsQARelease())then
    mvars.mis_isGameOverMenuShown=true
  end
  if n and n>0 then
    TimerStart("Timer_GameOverPresentation",n)
  else
    this.ExecuteShowGameOverMenu()
  end
end
function this.ExecuteShowGameOverMenu()
  TppRadio.Stop()GameOverMenuSystem.SetType(GameOverType.Normal)
  local e=TppStory.GetCurrentStorySequence()
  if e<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
    GameOverMenuSystem.SetBgType(GameOverBg.TYPE_2)
  else
    GameOverMenuSystem.SetBgType(GameOverBg.TYPE_1)
  end
  GameOverMenuSystem.RequestOpen()
end
function this.ShowMissionGameEndAnnounceLog()
  this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END)
  this.ShowAnnounceLogOnFadeOut(this.OnEndResultBlockLoad)
end
function this.ShowAnnounceLogOnFadeOut(e)
  if TppUiCommand.GetSuspendAnnounceLogNum()>0 then
    TppUiStatusManager.ClearStatus"AnnounceLog"mvars.mis_endAnnounceLogFunction=e
  else
    e()
  end
end
function this.OnEndResultBlockLoad()
  TppUiStatusManager.SetStatus("GmpInfo","INVALID")
  if this.systemCallbacks.OnDisappearGameEndAnnounceLog then
    this.systemCallbacks.OnDisappearGameEndAnnounceLog(svars.mis_missionClearType)
  end
end
function this.EnablePauseForShowResult()
  if not gvars.enableResultPause then
    TppPause.RegisterPause("ShowResult",TppPause.PAUSE_LEVEL_GAMEPLAY_MENU)
    gvars.enableResultPause=true
  end
end
function this.DisablePauseForShowResult()
  if gvars.enableResultPause then
    TppPause.UnregisterPause"ShowResult"gvars.enableResultPause=false
  end
end
function this.ShowMissionResult()
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  TppRadio.Stop()
  TppSoundDaemon.SetMute"Result"this.EnablePauseForShowResult()
  TppRadioCommand.SetEnableIgnoreGamePause(true)
  TppSound.SafeStopAndPostJingleOnShowResult()
  if this.IsStoryMission(vars.missionCode)and TppRadio.IsSetIndivResultRadioSetting()then
    TppRadio.PlayResultRadio(this.ExecRewardProcess)
  else
    this.ExecRewardProcess()
  end
end
function this.ExecRewardProcess()
  if mvars.mis_blackRadioSetting then
    TppSoundDaemon.SetKeepBlackRadioEnable(true)
    TppRadio.StartBlackRadio()
  elseif mvars.mis_releaseAnnounceSetting then
    ReleaseAnnouncePopupSystem.RequestOpen()
  else
    this.DisablePauseForShowResult()
    this.ShowMissionReward()
  end
end
function this.ShowMissionReward()
  if TppReward.IsStacked()then
    TppReward.ShowAllReward()
  else
    this.OnEndMissionReward()
  end
end
function this.OnEndMissionReward()
  if gvars.needWaitMissionInitialize then
    this.ResetMissionClearState()
  else
    this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.REWARD_END)
  end
  if IsTypeFunc(this.systemCallbacks.OnEndMissionReward)then
    this.systemCallbacks.OnEndMissionReward()
  else
    if gvars.needWaitMissionInitialize==false then
      this.ExecuteMissionFinalize()
    end
  end
  this.ResetNeedWaitMissionInitialize()
end
function this.MissionFinalize(n)
  TppSoundDaemon.SetMute"Loading"local o,t,a,s
  if IsTypeTable(n)then
    o=n.isNoFade
    t=n.isExecGameOver
    a=n.showLoadingTips
    s=n.setMute
  end
  if a~=nil then
    mvars.mis_showLoadingTipsOnMissionFinalize=a
  else
    mvars.mis_showLoadingTipsOnMissionFinalize=true
  end
  if s then
    mvars.mis_setMuteOnMissionFinalize=s
  end
  if gvars.mis_nextMissionCodeForMissionClear~=unkM6 then
    local n=this.IsStoryMission(vars.missionCode)
    local e=this.IsStoryMission(gvars.mis_nextMissionCodeForMissionClear)
    if n or e then
      SsdMarker.UnregisterMarker{type="USER_001"}
    end
  end
  if o then
    this.ExecuteMissionFinalize()
  else
    if t then
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeAtGameOverFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
    else
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
    end
  end
end
function this.ExecuteMissionFinalize()
  if not this.IsSysMissionId(vars.missionCode)then
    TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_END,this.ExecuteMissionFinalizeAfterServerSave)
  else
    this.ExecuteMissionFinalizeAfterServerSave()
  end
end
function this.ExecuteMissionFinalizeAfterServerSave()
  local n=TppPackList.GetLocationNameFormMissionCode(gvars.mis_nextMissionCodeForMissionClear)
  if n then
    mvars.mis_nextLocationCode=TppDefine.LOCATION_ID[n]
  end
  this.SafeStopSettingOnMissionReload{setMute=mvars.mis_setMuteOnMissionFinalize}
  this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_FINALIZED)
  if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
    if TppUiCommand.IsEndMissionTelop()then
    end
    this.ShowMissionReward()
    this.systemCallbacks.OnFinishBlackTelephoneRadio=nil
    this.systemCallbacks.OnEndMissionCredit=nil
  end
  local r
  local n=vars.missionCode
  local o=vars.locationCode
  local s,i,t,a
  if gvars.mis_nextMissionCodeForMissionClear~=unkM6 then
    s=this.IsFreeMission(vars.missionCode)i=this.IsFreeMission(gvars.mis_nextMissionCodeForMissionClear)t=mvars.mis_isResetMissionPosition
    a=mvars.mis_isLocationChangeWithFastTravel
    vars.locationCode=mvars.mis_nextLocationCode
    vars.missionCode=gvars.mis_nextMissionCodeForMissionClear
  else
    Tpp.DEBUG_Fatal"Not defined next missionId!!"this.RestartMission()
    return
  end
  if i then
    TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
  end
  TppGimmick.DecrementCollectionRepopCount()Gimmick.StoreSaveDataPermanentGimmickForMissionClear()Gimmick.StoreSaveDataPermanentGimmickFromMissionAfterClear()
  if s then
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
  end
  if i then
    vars.requestFlagsAboutEquip=255
  end
  TppEnemy.ClearDDParameter()
  if gvars.solface_groupNumber>=4294967295 then
    gvars.solface_groupNumber=0
  else
    gvars.solface_groupNumber=gvars.solface_groupNumber+1
  end
  gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)SsdSbm.StoreToSVars()
  TppRadioCommand.StoreRadioState()
  local o=(vars.locationCode~=o)
  TppClock.SaveMissionStartClock()
  TppWeather.SaveMissionStartWeather()
  TppBuddyService.SetVarsMissionStart()
  TppBuddyService.BuddyMissionInit()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE,s,i,t,nil,o,a)
  TppWeather.OnEndMissionPrepareFunction()
  this.VarResetOnNewMission()
  local s=true
  TppSave.VarSave(n,true)
  local i=false
  do
    i=true
  end
  if i then
    TppSave.SaveGameData(n,nil,nil,s,true)
  end
  if mvars.mis_needSaveConfigOnNewMission then
    TppSave.VarSaveConfig()
    TppSave.SaveConfigData(nil,nil,s)
  end
  if TppRadio.playingBlackTelInfo then
    mvars.mis_showLoadingTipsOnMissionFinalize=false
  end
  SsdBlankMap.DisableDefenseMode()
  TppCrew.FinishMission(n)
  this.RequestLoad(vars.missionCode,n,{showLoadingTips=mvars.mis_showLoadingTipsOnMissionFinalize,waitOnLoadingTipsEnd=r})
end
function this.ParseMissionName(e)
  local i=string.sub(e,2)i=tonumber(i)
  local n=string.sub(e,1,1)
  local e
  if(n=="s")then
    e="story"elseif(n=="e")then
    e="extra"elseif(n=="f")then
    e="free"elseif(n=="k")then
    e="flag"elseif(n=="d")then
    e="defense"end
  return i,e
end
function this.IsStoryMission(e)
  local e=math.floor(e/1e4)
  if e==1 then
    return true
  else
    return false
  end
end
function this.IsFreeMission(e)
  local e=math.floor(e/1e4)
  if e==3 then
    return true
  else
    return false
  end
end
function this.IsHardMission(e)
  local n=math.floor(e/1e3)
  local e=math.floor(e/1e4)*10
  if(n-e)==1 then
    return true
  else
    return false
  end
end
function this.GetFreeMissionCode()
  if TppLocation.IsAfghan()then
    return TppDefine.SYS_MISSION_ID.AFGH_FREE
  elseif TppLocation.IsMiddleAfrica()then
    return TppDefine.SYS_MISSION_ID.MAFR_FREE
  end
end
function this.GetCoopLobbyMissionCode()
  local e=this.GetMissionID()
  if e==20005 or e==21005 then
    return TppDefine.SYS_MISSION_ID.TUTORIAL_MATCHING_ROOM
  elseif TppLocation.IsAfghan()then
    return TppDefine.SYS_MISSION_ID.AFGH_MATCHING_ROOM
  elseif TppLocation.IsMiddleAfrica()then
    return TppDefine.SYS_MISSION_ID.MAFR_MATCHING_ROOM
  elseif vars.locationCode==TppDefine.LOCATION_ID.INIT then
    return TppDefine.SYS_MISSION_ID.NO_LOCATION_MATCHING_ROOM
  elseif vars.locationCode==TppDefine.LOCATION_ID.SPFC then
    return TppDefine.SYS_MISSION_ID.SPFC_MATCHING_ROOM
  elseif vars.locationCode==TppDefine.LOCATION_ID.SSAV then
    return TppDefine.SYS_MISSION_ID.SSAV_MATCHING_ROOM
  else
    return TppDefine.SYS_MISSION_ID.NO_LOCATION_MATCHING_ROOM
  end
end
function this.GetAvaterMissionCode()
  if TppLocation.IsAfghan()then
    return TppDefine.SYS_MISSION_ID.AVATAR_EDIT
  elseif TppLocation.IsMiddleAfrica()then
    return TppDefine.SYS_MISSION_ID.MAFR_AVATAR_EDIT
  else
    return TppDefine.SYS_MISSION_ID.AVATAR_EDIT
  end
end
function this.GetNormalMissionCodeFromHardMission(e)
  return e-1e3
end
function this.IsMatchingRoom(e)
  if e==TppDefine.SYS_MISSION_ID.TITLE then
    return true
  end
  local e=math.floor(e/1e3)
  return e==21
end
function this.IsMultiPlayMission(e)
  if e==TppDefine.SYS_MISSION_ID.TITLE then
    return true
  end
  local e=math.floor(e/1e4)
  if e==2 then
    return true
  else
    return false
  end
end
function this.IsCoopMission(missionCode)
  return(not this.IsMatchingRoom(missionCode)and this.IsMultiPlayMission(missionCode))
end
function this.IsAvatarEditMission(e)
  return(e==TppDefine.SYS_MISSION_ID.AVATAR_EDIT)or(e==TppDefine.SYS_MISSION_ID.MAFR_AVATAR_EDIT)
end
function this.IsInitMission(e)
  return(e==TppDefine.SYS_MISSION_ID.INIT or e==TppDefine.SYS_MISSION_ID.TITLE)
end
function this.IsTitleMission(e)
  return e==TppDefine.SYS_MISSION_ID.TITLE
end
function this.IsEventMission(n)
  if not this.IsCoopMission(n)then
    return false
  end
  if n>=22e3 then
    return true
  end
  return false
end
function this.IsMissionStart()
  if gvars.sav_varRestoreForContinue then
    return false
  else
    return true
  end
end
function this.IsSysMissionId(n)
  local e
  for i,e in pairs(TppDefine.SYS_MISSION_ID)do
    if n==e then
      return true
    end
  end
  return false
end
function this.Messages()
  return Tpp.StrCode32Table{Player={{msg="Dead",func=this.OnPlayerDead,option={isExecGameOver=true}},{msg="AllDead",func=this.OnAllPlayersDead,option={isExecGameOver=true}},{msg="InFallDeathTrapLocal",func=this.OnPlayerFallDead,option={isExecGameOver=true}},{msg="Exit",sender="outerZone",func=function()
    mvars.mis_isOutsideOfMissionArea=true
  end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Enter",sender="outerZone",func=function()
    mvars.mis_isOutsideOfMissionArea=false
  end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Exit",sender="innerZone",func=function()
    if mvars.mis_fobDisableAlertMissionArea==true then
      return
    end
    mvars.mis_isAlertOutOfMissionArea=true
    if not this.CheckMissionClearOnOutOfMissionArea()then
      this.EnableAlertOutOfMissionArea()
    end
  end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Enter",sender="innerZone",func=function()
    mvars.mis_isAlertOutOfMissionArea=false
    this.DisableAlertOutOfMissionArea()
  end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Exit",sender="hotZone",func=function()
    mvars.mis_isOutsideOfHotZone=true
    this.ExitHotZone()
  end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Enter",sender="hotZone",func=function()
    mvars.mis_isOutsideOfHotZone=false
    if TppSequence.IsMissionPrepareFinished()then
      this.PlayCommonRadioOnInsideOfHotZone()
    end
  end,option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="OnInjury",func=function()
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOMMEND_CURE)
  end},{msg="PlayerFultoned",func=this.OnPlayerFultoned},{msg="WarpEnd",func=function()
    if mvars.mis_finishWarpToBaseCallBack then
      mvars.mis_finishWarpToBaseCallBack()
      mvars.mis_finishWarpToBaseCallBack=nil
    end
  end,option={isExecGameOver=true,isExecFastTravel=true}}},UI={{msg="EndTelopCast",func=function()
    if mvars.f30050_demoName=="NuclearEliminationCeremony"then
      return
    end
    TppUiStatusManager.ClearStatus"AnnounceLog"end},{msg="EndFadeOut",sender="MissionGameEndFadeOutFinish",func=this.OnMissionGameEndFadeOutFinish,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="MissionFinalizeFadeOutFinish",func=this.ExecuteMissionFinalize,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="MissionFinalizeAtGameOverFadeOutFinish",func=this.ExecuteMissionFinalize,option={isExecGameOver=true,isExecMissionClear=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="RestartMissionFadeOutFinish",func=function()
    this.ExecuteRestartMission(mvars.mis_isReturnToMission)
    end,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="ContinueFromCheckPointFadeOutFinish",func=function()
      this.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission,mvars.isNeedUpdateBaseManagement)
    end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="ReloadFadeOutFinish",func=function()
      if mvars.mis_reloadOnEndFadeOut then
        mvars.mis_reloadOnEndFadeOut()
      end
      this.ExecuteReload()
    end,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="AbortMissionFadeOutFinish",func=function()
      if mvars.mis_missionAbortDelayTime>0 then
        TimerStart("Timer_MissionAbort",mvars.mis_missionAbortDelayTime)
      else
        this.OnEndFadeOutMissionAbort()
      end
    end,option={isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="GameOverReturnToBaseFadeOut",func=this.ExecuteGameOverReturnToBase,option={isExecGameOver=true,isExecFastTravel=true}},{msg="EndFadeOut",sender="ReturnToTitleWithSave",func=this.ExecuteReturnToTitleWithSave,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndFadeIn",sender="FadeInOnGameStart",func=function()
      this.ShowAnnounceLogOnGameStart()
    end},{msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()
      this.ShowAnnounceLogOnGameStart()
    end},{msg="GameOverOpen",func=TppMain.DisableGameStatusOnGameOverMenu,option={isExecGameOver=true,isExecFastTravel=true}},{msg="GameOverContinueFromCheckPoint",func=this.ExecuteContinueFromCheckPoint,option={isExecGameOver=true,isExecFastTravel=true}},{msg="GameOverReturnToBase",func=this.GameOverReturnToBase,option={isExecGameOver=true,isExecMissionClear=true,isExecFastTravel=true}},{msg="GameOverMenuAutomaticallyClosed",func=function()
      if IS_GC_2017_COOP then
        local n=mvars.mis_isReserveGameOver or svars.mis_isDefiniteGameOver
        if n then
          this.GameOverReturnToTitle()
        end
        return
      end
      this.ReturnToMatchingRoom()
    end,option={isExecGameOver=true,isExecFastTravel=true}},{msg="PauseMenuCheckpoint",func=this.ContinueFromCheckPoint},{msg="PauseMenuAbortMission",func=this.AbortMissionByMenu},{msg="PauseMenuAbortMissionGoToAcc",func=this.AbortMissionByMenu},{msg="PauseMenuFinishFobManualPlaecementMode",func=this.AbortMissionByMenu},{msg="PauseMenuRestart",func=this.RestartMission},{msg="PauseMenuReturnToTitle",func=function()
      this.ReturnToTitle()
      vars.isAbandonFromUser=1
    end},{msg="PauseMenuReturnToMission",func=function()
      this.ReturnToMission{withServerPenalty=true}
    end},{msg="PauseMenuReturnToBase",func=this.ReturnToBaseByMenu},{msg="RequestPlayRecordClearInfo",func=this.SetPlayRecordClearInfo},{msg="AiPodMenuCancelMissionSelected",func=function()
      this.AbortMissionByMenu{isNoSurviveBox=true}
    end},{msg="EndMissionTelopDisplay",func=function()
      if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
        this.MissionFinalize{isNoFade=true,setMute="Result"}
      end
    end,option={isExecMissionClear=true,isExecGameOver=true,isExecFastTravel=true}},{msg="EndAnnounceLog",func=function()
      if mvars.mis_endAnnounceLogFunction then
        mvars.mis_endAnnounceLogFunction()
        mvars.mis_endAnnounceLogFunction=nil
      end
    end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="EndResultBlockLoad",func=this.OnEndResultBlockLoad,option={isExecMissionClear=true,isExecGameOver=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="StoryMissionResultClosed",func=function()
      this.ExecRewardProcess()
    end},{msg="BlackRadioClosed",func=function(n)
      if not IsTypeString(mvars.mis_blackRadioSetting)or n~=StrCode32(mvars.mis_blackRadioSetting)then
        return
      end
      mvars.mis_blackRadioSetting=nil
      TppSoundDaemon.SetKeepBlackRadioEnable(false)
      this.ExecRewardProcess()
    end},{msg="ReleaseAnnouncePopupPushEnd",func=function()
      if not mvars.mis_releaseAnnounceSetting then
        return
      end
      mvars.mis_releaseAnnounceSetting=nil
      this.ExecRewardProcess()
    end},{msg="PresetRadioEditMenuClosed",func=TppSave.SaveEditData},{msg="CommunicationMarkerEditMenuClosed",func=TppSave.SaveEditData},{msg="GestureEditMenuClosed",func=TppSave.SaveEditData},{msg="AbandonFromPauseMenu",func=function()
      vars.isAbandonFromUser=1
      if this.IsCoopMission(vars.missionCode)then
        return
      end
      this.AbandonMission()
    end},{msg="AiPodMenuMoveToAssemblyPointSelected",func=function(n,n)
      if not this.IsMultiPlayMission(vars.missionCode)then
        this.GoToCoopLobbyWithSave()
      end
    end},{msg="PopupClose",sender=TppDefine.ERROR_ID.SESSION_ABANDON,func=function()
      this.AbandonMission()
    end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="AiPodMenuReturnToTitleWithSaveSelected",func=this.ReturnToTitleWithSave}},Radio={{msg="Finish",func=this.OnFinishUpdateObjectiveRadio}},Timer={{msg="Finish",sender="Timer_OutsideOfHotZoneCount",func=this.OutsideOfHotZoneCount,nil},{msg="Finish",sender="Timer_OnEndReturnToTile",func=this.RestartMission,option={isExecGameOver=true,isExecFastTravel=true},nil},{msg="Finish",sender="Timer_GameOverPresentation",func=this.ExecuteShowGameOverMenu,option={isExecGameOver=true,isExecFastTravel=true},nil},{msg="Finish",sender="Timer_MissionGameEndStart",func=this.OnMissionGameEndFadeOutFinish2nd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_MissionGameEndStart2nd",func=this.ShowMissionGameEndAnnounceLog,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_FadeOutOnMissionGameEndStart",func=function()
    this._FadeOutOnMissionGameEnd(mvars.mis_missionGameEndFadeSpeed,mvars.mis_missionGameEndFadeId)
    end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_StartMissionAbortFadeOut",func=this.FadeOutOnMissionAbort,option={isExecGameOver=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_MissionAbort",func=this.OnEndFadeOutMissionAbort,option={isExecGameOver=true,isExecFastTravel=true}},{msg="Finish",sender=Timer_outsideOfInnerZoneStr,func=function()
      if(mvars.mis_isAlertOutOfMissionArea==false)then
        return
      end
      if this.CheckMissionClearOnOutOfMissionArea()then
        if mvars.mis_enableAlertOutOfMissionArea then
          this.DisableAlertOutOfMissionArea()
        end
      else
        if not mvars.mis_enableAlertOutOfMissionArea then
          this.EnableAlertOutOfMissionArea()
        end
      end
    end},{msg="Finish",sender="Timer_UpdateCheckPoint",func=function()
      TppStory.UpdateStorySequence{updateTiming="OnUpdateCheckPoint",isInGame=true}
    end},{msg="Finish",sender="Timer_WaitStartMigration",func=function()
      this.AbandonMission()
    end},{msg="Finish",sender="Timer_WaitFinishMigration",func=function()
      this.AbandonMission()
    end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_SessionAbandon",func=function()
      this.AbandonMission()
    end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="Finish",sender="Timer_WaitSavingForReturnToTitle",func=this.ExecuteReturnToTitleWithSave,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}},GameObject={{msg="ChangePhase",func=function(i,n)
      if mvars.mis_isExecuteGameOverOnDiscoveryNotice then
        if n==TppGameObject.PHASE_ALERT then
          this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ON_DISCOVERY,TppDefine.GAME_OVER_RADIO.OTHERS)
        end
      end
    end},{msg="DisableTranslate",func=function(e)
      local e=TppEnemy.GetSoldierType(e)
      if e==EnemyType.TYPE_SOVIET then
        if not TppQuest.IsCleard"ruins_q19010"then
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN,true)
        end
      elseif e==EnemyType.TYPE_PF then
        if not TppQuest.IsCleard"outland_q19011"then
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS,true)
        end
      end
    end},{msg="FinishWaveInterval",func=function()Mission.EndWaveResult()
      end},{msg="GameOverConfirm",func=this.OnAllPlayersDead,option={isExecGameOver=true,isExecFastTravel=true}}},MotherBaseManagement={{msg="CompletedPlatform",func=function(e,e,e)
      TppStory.UpdateStorySequence{updateTiming="OnCompletedPlatform",isInGame=true}
      end},{msg="RequestSaveMbManagement",func=function()
        if((TppSave.IsForbidSave()or(vars.missionCode==10030))or(vars.missionCode==10115))or(not this.CheckMissionState())then
          TppMotherBaseManagement.SetRequestSaveResultFailure()
          return
        end
        TppSave.SaveOnlyMbManagement(TppSave.ReserveNoticeOfMbSaveResult)
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},{msg="RequestSavePersonal",func=function()
        TppSave.CheckAndSavePersonalData()
      end}},Trap={{msg="Enter",sender="trap_mission_failed_area",func=function()
        this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)
      end,option={isExecFastTravel=true}}},Network={{msg="StartHostMigration",func=function()
        if IsTimerActive"Timer_WaitStartMigration"then
          TimerStop"Timer_WaitStartMigration"end
        TimerStart("Timer_WaitFinishMigration",120)
        gvars.mis_processingHostmigration=true
        gvars.mis_lastResultOfHostmigration=true
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="FinishHostMigration",func=function(e)
        gvars.mis_processingHostmigration=false
        if IsTimerActive"Timer_WaitFinishMigration"then
          TimerStop"Timer_WaitFinishMigration"end
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="FailedHostMigration",func=function()
        gvars.mis_lastResultOfHostmigration=false
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},{msg="AcceptedInvate",func=function()
        if this.IsMultiPlayMission(vars.missionCode)then
          this.AbandonMission()
        elseif this.IsAvatarEditMission(vars.missionCode)then
        else
          this.GoToCoopLobby()
        end
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}}}
end
function this.MessagesWhileLoading()
  return Tpp.StrCode32Table{UI={{msg="StoryMissionResultClosed",func=function()
    this.ExecRewardProcess()
  end},{msg="BlackRadioClosed",func=function(n)
    TppPause.UnregisterPause"BlackRadio"if not IsTypeString(mvars.mis_blackRadioSetting)or n~=StrCode32(mvars.mis_blackRadioSetting)then
      return
    end
    mvars.mis_blackRadioSetting=nil
    TppSoundDaemon.SetKeepBlackRadioEnable(false)
    this.ExecRewardProcess()
  end},{msg="ReleaseAnnouncePopupPushEnd",func=function()
    if not mvars.mis_releaseAnnounceSetting then
      return
    end
    mvars.mis_releaseAnnounceSetting=nil
    this.ExecRewardProcess()
  end},{msg="BonusPopupAllClose",func=this.OnEndMissionReward},{msg="EndFadeIn",sender="OnEndWarpByFastTravel",func=TppPlayer.OnEndFadeInWarpByFastTravel},{msg="EndFadeOut",sender="FadeOutForMovieEnd",func=function()
    mvars.mov_checkEndFadeOut=true
  end}},Radio={{msg="Finish",func=TppRadio.OnFinishRadioWhileLoading},nil},Video={{msg="VideoPlay",func=function(e)
    TppMovie.DoMessage(e,"onStart")
  end},{msg="VideoStopped",func=function(e)
    TppMovie.DoMessage(e,"onEnd")
  end}}}
end
local FallDeathS32=StrCode32"FallDeath"
local SuicideS32=StrCode32"Suicide"
function this.OnPlayerDead(e,e)
end
function this.OnAllPlayersDead(i,n)
  if this.IsCoopMission(vars.missionCode)then
    return
  end
  if not TppNetworkUtil.IsHost()then
    return
  end
  if mvars.mis_isAllDead==true then
    return
  end
  mvars.mis_isAllDead=true
  this._OnDeadCommon(n)
end
function this.OnPlayerFallDead()
  TppPlayer.PlayFallDeadCamera()
end
function this.OnAbortMissionPreparation()
  this.SetNextMissionCodeForMissionClear(unkM6)
end
function this.WaitFinishMissionEndPresentation()
  while(not TppUiCommand.IsEndMissionTelop())do
    if TppUiCommand.KeepMissionStartTelopBg then
      TppUiCommand.KeepMissionStartTelopBg(false)
    end
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end result: TppUiCommand.IsEndMissionTelop() = "..tostring(TppUiCommand.IsEndMissionTelop()))
    end
    if DebugText and(TppRadio.playingBlackTelInfo~=nil)then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end blackTelephoneRadio : radioGroupName = "..tostring(TppRadio.playingBlackTelInfo.radioName))
    end
    coroutine.yield()
  end
  while(TppRadio.playingBlackTelInfo~=nil)do
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end blackTelephoneRadio : radioGroupName = "..tostring(TppRadio.playingBlackTelInfo.radioName))
    end
    coroutine.yield()
  end
  TppUiCommand.StartResultBlockUnload()
  if gvars.needWaitMissionInitialize then
    TppMain.DisablePause()
  end
  while(gvars.needWaitMissionInitialize)do
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},"Waiting end reward popup : gvars.needWaitMissionInitialize = "..tostring(gvars.needWaitMissionInitialize))
    end
    coroutine.yield()
  end
  TppMain.EnablePause()
end
function this.SetNeedWaitMissionInitialize()
  gvars.needWaitMissionInitialize=true
end
function this.ResetNeedWaitMissionInitialize()
  gvars.needWaitMissionInitialize=false
end
function this.CancelLoadOnResult()
  mvars.mis_doMissionFinalizeOnMissionTelopDisplay=nil
  this.ResetNeedWaitMissionInitialize()
end
function this.OnAllocate(n)
  vars.invitationDisableRecieveFlag=0
  this.systemCallbacks={OnEstablishMissionClear=function()
    this.MissionGameEnd{loadStartOnResult=false}
  end,OnDisappearGameEndAnnounceLog=this.ShowMissionResult,OnEndMissionCredit=nil,OnEndMissionReward=nil,OnGameOver=nil,OnOutOfMissionArea=nil,OnUpdateWhileMissionPrepare=nil,OnFinishBlackTelephoneRadio=function()
    if not gvars.needWaitMissionInitialize then
      this.ShowMissionReward()
    end
  end,OnOutOfHotZone=nil,OnOutOfHotZoneMissionClear=nil,OnUpdateStorySequenceInGame=nil,CheckMissionClearFunction=nil,OnReturnToMission=nil,OnAddStaffsFromTempBuffer=nil,CheckMissionClearOnRideOnFultonContainer=nil,OnRecovered=nil,OnSetMissionFinalScore=nil,OnEndDeliveryWarp=nil,OnFultonContainerMissionClear=nil,OnOutOfDefenseGameArea=nil,OnAlertOutOfDefenseGameArea=nil}
  this.RegisterMissionID()Mission.AddFinalizer(this.OnMissionFinalize)
  if n.sequence then
    if n.sequence.MISSION_WORLD_CENTER then
      TppCoder.SetWorldCenter(n.sequence.MISSION_WORLD_CENTER)
    end
    local a=n.sequence.missionObjectiveDefine
    local s=n.sequence.missionObjectiveTree
    local t=n.sequence.missionObjectiveEnum
    if a and s then
      this.SetMissionObjectives(a,s,t)
    end
    if n.sequence.missionStartPosition then
      if IsTypeTable(n.sequence.missionStartPosition.orderBoxList)then
        mvars.mis_orderBoxList=n.sequence.missionStartPosition.orderBoxList
      end
    end
    if this.IsStoryMission(vars.missionCode)then
      if n.sequence.blackRadioOnEnd then
        if IsTypeString(n.sequence.blackRadioOnEnd)then
          mvars.mis_blackRadioSetting=n.sequence.blackRadioOnEnd
        end
      end
      if n.sequence.releaseAnnounce then
        if IsTypeTable(n.sequence.releaseAnnounce)then
          mvars.mis_releaseAnnounceSetting=n.sequence.releaseAnnounce
          ReleaseAnnouncePopupSystem.SetInfos(mvars.mis_releaseAnnounceSetting)
        end
      end
    end
    if n.sequence.DEFENSE_MAP_LOCATOR_NAME then
      SsdBlankMap.EnableDefenseMode{areaName=n.sequence.DEFENSE_MAP_LOCATOR_NAME}
    else
      SsdBlankMap.DisableDefenseMode()
    end
  end
  mvars.mis_isOutsideOfMissionArea=false
  mvars.mis_isOutsideOfHotZone=true
  this.MessageHandler={OnMessage=function(n,i,s,t,a,o)
    this.OnMessageWhileLoading(n,i,s,t,a,o)
  end}GameMessage.SetMessageHandler(this.MessageHandler,{"UI","Radio","Video","Network","Nt"})
end
function this.DisableInGameFlag()
  mvars.mis_missionStateIsNotInGame=true
end
function this.EnableInGameFlag(e)
  if gvars.mis_missionClearState<=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
    mvars.mis_missionStateIsNotInGame=false
    if not e then
      TppSoundDaemon.ResetMute"Loading"end
  else
    mvars.mis_missionStateIsNotInGame=true
  end
end
function this.ExecuteSystemCallback(i,n)
  local e=this.systemCallbacks[i]
  if IsTypeFunc(e)then
    return e(n)
  end
end
function this.Init(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(this.MessagesWhileLoading())
  mvars.mis_isAlertOutOfMissionArea=false
  mvars.mis_isAllDead=false
  gvars.mis_skipOnPreLoadForContinue=false
  mvars.mis_defeseGameAreaTrapTable={}
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(this.MessagesWhileLoading())
  if n.sequence then
    local i=n.sequence.missionObjectiveDefine
    local s=n.sequence.missionObjectiveTree
    local n=n.sequence.missionObjectiveEnum
    if i and s then
      this.SetMissionObjectives(i,s,n)
    end
  end
  local n={"OnEstablishMissionClear","OnDisappearGameEndAnnounceLog","OnEndMissionCredit","OnEndMissionReward","OnGameOver","OnOutOfMissionArea","OnUpdateWhileMissionPrepare","OnFinishBlackTelephoneRadio","OnOutOfHotZone","OnOutOfHotZoneMissionClear","OnUpdateStorySequenceInGame","CheckMissionClearFunction","OnReturnToMission","OnAddStaffsFromTempBuffer","CheckMissionClearOnRideOnFultonContainer","OnRecovered","OnMissionGameEndFadeOutFinish","OnFultonContainerMissionClear"}
  for i,n in ipairs(n)do
    local i=_G.TppMission.systemCallbacks
    if i then
      local i=i[n]
      this.systemCallbacks=this.systemCallbacks or{}
      this.systemCallbacks[n]=i
    end
  end
end
function this.RegisterMissionID()
  mvars.mis_missionName=this._CreateMissionName(vars.missionCode)
end
function this.DeclareSVars()
  return{{name="mis_canMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,notify=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isDefiniteGameOver",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_gameOverType",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_gameOverRadio",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isDefiniteMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_missionClearType",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_isAbandonMission",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},{name="mis_objectiveEnable",arraySize=unkM5,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.CheckMessageOptionWhileLoading()
  return true
end
function this.OnMessageWhileLoading(sender,messageId,arg0,arg1,arg2,arg3)
  --ORPHAN local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
  local strLogText
  Tpp.DoMessage(this.messageExecTableWhileLoading,this.CheckMessageOptionWhileLoading,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,this.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if mvars.mis_defeseGameAreaMessageExecTable then
    Tpp.DoMessage(mvars.mis_defeseGameAreaMessageExecTable,this.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  end
end
function this.CheckMessageOption(options)
  local isExecMissionClear=false
  local isExecGameOver=false
  local isExecDemoPlaying=false
  local isExecMissionPrepare=false
  local isExecFastTravel=false
  if options and IsTypeTable(options)then
    isExecMissionClear=options[StrCode32"isExecMissionClear"]
    isExecGameOver=options[StrCode32"isExecGameOver"]
    isExecDemoPlaying=options[StrCode32"isExecDemoPlaying"]
    isExecMissionPrepare=options[StrCode32"isExecMissionPrepare"]
    isExecFastTravel=options[StrCode32"isExecFastTravel"]
  end
  return this.CheckMissionState(isExecMissionClear,isExecGameOver,isExecDemoPlaying,isExecMissionPrepare,isExecFastTravel)
end
function this.CheckMissionState(checkMissionClear,checkGameOver,checkDemoPlaying,isExecMissionPrepare,checkMissionPrepare)
  local mvars=mvars
  local svars=svars
  if svars==nil then
    return
  end
  local idMissionClear=mvars.mis_isReserveMissionClear or svars.mis_isDefiniteMissionClear
  local isGameOver=mvars.mis_isReserveGameOver or svars.mis_isDefiniteGameOver
  local isDemoPlaying=TppDemo.IsNotPlayable()
  local isMissionPrepare=false
  if svars.seq_sequence<=1 then
    isMissionPrepare=true
  end
  local isFastTravelling=(mvars.ply_deliveryWarpState~=nil)
  if idMissionClear and not checkMissionClear then
    return false
  elseif isGameOver and not checkGameOver then
    return false
  elseif isDemoPlaying and not checkDemoPlaying then
    return false
  elseif isMissionPrepare and not isExecMissionPrepare then
    return false
  elseif isFastTravelling and not checkMissionPrepare then
    return false
  else
    return true
  end
end
function this.CheckMissionClearOnOutOfMissionArea()
  if this.systemCallbacks.CheckMissionClearFunction then
    return this.systemCallbacks.CheckMissionClearFunction()
  else
    return false
  end
end
function this.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  if mvars.mis_isAlertOutOfMissionArea then
    this.EnableAlertOutOfMissionArea()
  end
end
function this.IgnoreAlertOutOfMissionAreaForBossQuiet(e)
  if e==true then
    mvars.mis_ignoreAlertOfMissionArea=true
  else
    mvars.mis_ignoreAlertOfMissionArea=false
  end
end
function this.EnableAlertOutOfMissionArea()
  local e=false
  if mvars.mis_ignoreAlertOfMissionArea==true then
    e=true
  end
  if svars.mis_canMissionClear then
    return
  end
  if mvars.mis_missionStateIsNotInGame then
    return
  end
  mvars.mis_enableAlertOutOfMissionArea=true
  TppUI.ShowAnnounceLog"closeOutOfMissionArea"if not e then
    TppOutOfMissionRangeEffect.Enable(3)
  end
end
function this.DisableAlertOutOfMissionArea()
  mvars.mis_enableAlertOutOfMissionArea=false
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.ExitHotZone()
  this.ExecuteSystemCallback"OnOutOfHotZone"if svars.mis_canMissionClear then
    TppUI.ShowAnnounceLog"leaveHotZone"if not IsNotAlert()then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT)
    else
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE)
    end
  end
end
function this.PlayCommonRadioOnInsideOfHotZone()
  if svars.mis_canMissionClear then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RETURN_HOTZONE)
  end
end
function this.OutsideOfHotZoneCount()
  if mvars.mis_isOutsideOfHotZone then
    this.ReserveMissionClearOnOutOfHotZone()
  end
end
local function StopTimerOutsideHotZone()
  if IsTimerActive"Timer_OutsideOfHotZoneCount"then
    TimerStop"Timer_OutsideOfHotZoneCount"
  end
end
function this.CheckMissionClearOnRideOnFultonContainer()
  if this.systemCallbacks.CheckMissionClearOnRideOnFultonContainer then
    return this.systemCallbacks.CheckMissionClearOnRideOnFultonContainer()
  else
    return false
  end
end
function this.OnPlayerFultoned()
end
function this.Update()
  local mvars=mvars
  local svars=svars
  local missionName=this.GetMissionName()
  if mvars.mis_needSetCanMissionClear then
    this._SetCanMissionClear()
  end
  if mvars.mov_checkEndFadeOut then
    mvars.mov_checkEndFadeOut=nil
    TppMovie.OnEndFadeOut()
  end
  if mvars.mis_missionStateIsNotInGame then
    return
  end
  local isReserveMissionClear,isSyncMissionClearType,isReserveGameOver,isSyncGameOverType=this.GetSyncMissionStatus()
  local isAlertOutOfMissionArea=mvars.mis_isAlertOutOfMissionArea
  local isOutsideOfMissionArea=mvars.mis_isOutsideOfMissionArea
  local isOutsideOfHotZone=mvars.mis_isOutsideOfHotZone
  local canMissionClear=svars.mis_canMissionClear
  if isReserveMissionClear and isSyncMissionClearType then
    TppMain.DisableGameStatus()
    HighSpeedCamera.RequestToCancel()
    this.EstablishedMissionClear(svars.mis_missionClearType)
    this._OnEstablishMissionEnd()
  elseif isReserveGameOver and isSyncGameOverType then
    TppMain.DisableGameStatus()
    HighSpeedCamera.RequestToCancel()
    if mvars.mis_isAborting then
      this.EstablishedMissionAbort()
    else
      this.EstablishedGameOver()
    end
    this._OnEstablishMissionEnd()
  elseif canMissionClear then
    this.UpdateAtCanMissionClear(isOutsideOfHotZone,isOutsideOfMissionArea)
  else
    if isOutsideOfMissionArea then
      if this.CheckMissionClearOnOutOfMissionArea()then
        this.ReserveMissionClearOnOutOfHotZone()
      else
        if this.systemCallbacks.OnOutOfMissionArea==nil then
          this.AbortForOutOfMissionArea{isNoSave=false}
        else
          this.systemCallbacks.OnOutOfMissionArea()
        end
      end
    end
    if isAlertOutOfMissionArea then
      if not IsTimerActive(Timer_outsideOfInnerZoneStr)then
        TimerStart(Timer_outsideOfInnerZoneStr,unkM8)
      end
    else
      if IsTimerActive(Timer_outsideOfInnerZoneStr)then
        TimerStop(Timer_outsideOfInnerZoneStr)
      end
    end
  end
  if TppSequence.IsMissionPrepareFinished()then
    UnkFunc1()
  end
  this.ResumeMbSaveCoroutine()
  if mvars.mis_needSetEscapeBgm then
    if vars.playerPhase>TppEnemy.PHASE.SNEAK then
      TppSound.StartEscapeBGM()
    else
      TppSound.StopEscapeBGM()
    end
  end
  if mvars.mis_isMultiPlayMission then
    return
  end
  TppQuest.OnUpdate()
  SsdFlagMission.OnUpdate()
  SsdBaseDefense.OnUpdate()
  SsdCreatureBlock.OnUpdate()
end
function this.UpdateForMissionLoad()
  if mvars.mis_loadRequest then
    this.Load(mvars.mis_loadRequest.nextMission,mvars.mis_loadRequest.currentMission,mvars.mis_loadRequest.options)
    mvars.mis_loadRequest=nil
  end
end
function this.CreateMbSaveCoroutine()
  local function n()
    while(not TppMotherBaseManagement.IsEndedSyncControl())do
      if DebugText then
        DebugText.Print(DebugText.NewContext(),"WaitMbSyncAndSave:")
      end
      coroutine.yield()
    end
    if TppMotherBaseManagement.IsResultSuccessedSyncControl()then
      TppSave.SaveOnlyMbManagement()
    end
  end
  this.waitMbSyncAndSaveCoroutine=coroutine.create(n)
end
function this.ResumeMbSaveCoroutine()
  if this.waitMbSyncAndSaveCoroutine then
    local n,n=coroutine.resume(this.waitMbSyncAndSaveCoroutine)
    if coroutine.status(this.waitMbSyncAndSaveCoroutine)=="dead"then
      this.waitMbSyncAndSaveCoroutine=nil
      return
    end
  end
end
function this.GetSyncMissionStatus()
  local mvars=mvars
  local svars=svars
  local isHost=TppNetworkUtil.IsHost()
  local isSessionConnect=TppNetworkUtil.IsSessionConnect()
  local isReserveMissionClear=false
  local isSyncMissionClearType=false
  local isReserveGameOver=false
  local isSyncGameOverType=false
  if not isSessionConnect then
    isReserveMissionClear=mvars.mis_isReserveMissionClear
    isSyncMissionClearType=true
    isReserveGameOver=mvars.mis_isReserveGameOver
    isSyncGameOverType=true
  else
    if isHost then
      isReserveMissionClear=svars.mis_isDefiniteMissionClear and SVarsIsSynchronized"mis_isDefiniteMissionClear"
      isSyncMissionClearType=SVarsIsSynchronized"mis_missionClearType"
      isReserveGameOver=svars.mis_isDefiniteGameOver and SVarsIsSynchronized"mis_isDefiniteGameOver"
      isSyncGameOverType=SVarsIsSynchronized"mis_gameOverType"
    else
      isReserveMissionClear=svars.mis_isDefiniteMissionClear
      isSyncMissionClearType=true
      isReserveGameOver=svars.mis_isDefiniteGameOver
      isSyncGameOverType=svars.mis_gameOverType
    end
  end
  return isReserveMissionClear,isSyncMissionClearType,isReserveGameOver,isSyncGameOverType
end
function this.EstablishedMissionAbort()
  TppQuest.OnMissionGameEnd()SsdFlagMission.OnMissionGameEnd()SsdBaseDefense.OnMissionGameEnd()
  if mvars.mis_abortWithPlayRadio then
    TppRadio.PlayGameOverRadio()
  end
  if mvars.mis_abortPresentationFunction then
    mvars.mis_abortPresentationFunction()
  end
  if mvars.mis_abortWithFade then
    if mvars.mis_missionAbortFadeDelayTime==0 then
      this.FadeOutOnMissionAbort()
    else
      TimerStart("Timer_StartMissionAbortFadeOut",mvars.mis_missionAbortFadeDelayTime)
    end
  else
    this._CreateSurviveCBox()
    this.ExecuteMissionAbort()
  end
end
function this.FadeOutOnMissionAbort()
  local e
  if mvars.mis_abortWithSave then
    e={AnnounceLog="SUSPEND_LOG"}
  else
    e={AnnounceLog="INVALID_LOG"}
  end
  TppUI.FadeOut(mvars.mis_missionAbortFadeSpeed,"AbortMissionFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus=e})
end
function this.OnEndFadeOutMissionAbort()
  if mvars.mis_abortIsTitleMode then
    gvars.ini_isTitleMode=true
  end
  this._CreateSurviveCBox()
  this.VarSaveForMissionAbort()
  this.ShowAnnounceLogOnFadeOut(this.LoadForMissionAbort)
end
function this.EstablishedGameOver()
  TppMusicManager.StopJingleEvent()
  if not this.IsMultiPlayMission(vars.missionCode)then
    TppScriptVars.ResetAliveTime()
  end
  local n=svars.mis_gameOverType
  if n~=TppDefine.GAME_OVER_TYPE.PLAYER_DEAD and n~=TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD then--RETAILPATCH: 1.0.2.1: added check to allow revival
    Mission.SetRevivalDisabled(true)
  end
  local n={}
  local i=TppStory.GetCurrentStorySequence()
  for e=i,TppDefine.STORY_SEQUENCE.STORY_START,-1 do
    local e=TppDefine.CONTINUE_TIPS_TABLE[e]
    if e then
      for i,e in ipairs(e)do
        table.insert(n,e)
      end
    end
  end
  SsdUiSystem.RequestForceCloseForMissionClear()if#n>0 then
    local e=gvars.continueTipsCount
    if(e>#n)then
      e=1
      gvars.continueTipsCount=1
    end
    local n=n[e]
    local e
    if n then
      e=TppDefine.TIPS[n]
    end
    if IsTypeNumber(e)then
      gvars.continueTipsCount=gvars.continueTipsCount+1
    end
  end
  local n
  if this.systemCallbacks.OnGameOver then
    n=this.systemCallbacks.OnGameOver()
  end
  if not n then
    local n=false
    if this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)then
      n=true
      this.ShowGameOverMenu{delayTime=TppPlayer.PLAYER_FALL_DEAD_DELAY_TIME}
    elseif this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.TARGET_DEAD)then
      local i=TppPlayer.SetTargetDeadCameraIfReserved()
      if i then
        n=true
        this.ShowGameOverMenu{delayTime=6}
      end
    elseif this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED)then
      local i=TppPlayer.SetDefenseTargetBrokenCameraIfReserved()
      if i then
        n=true
        this.ShowGameOverMenu{delayTime=6}
      end
    end
    if not n then
      this.ShowGameOverMenu()
    end
  end
  if(Tpp.IsQARelease())then
    if not(this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.ABORT)or this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.S10060_RETURN_END))and(not mvars.mis_isGameOverMenuShown)then
    end
  end
end
function this.UpdateAtCanMissionClear(n,s)
  if not n then
    mvars.mis_lastOutSideOfHotZoneButAlert=nil
    StopTimerOutsideHotZone()
    return
  end
  local i=IsNotAlert()
  local n=IsPlayerStatusNormal()
  if s then
    if n then
      StopTimerOutsideHotZone()
      this.ReserveMissionClearOnOutOfHotZone()
    end
  else
    if i and n then
      if not IsTimerActive"Timer_OutsideOfHotZoneCount"then
        TimerStart("Timer_OutsideOfHotZoneCount",unkM9)
      end
    else
      if not i then
        mvars.mis_lastOutSideOfHotZoneButAlert=true
      end
      StopTimerOutsideHotZone()
    end
  end
end
function this.ReserveMissionClearOnOutOfHotZone()
  if this.systemCallbacks.OnOutOfHotZoneMissionClear then
    this.systemCallbacks.OnOutOfHotZoneMissionClear()
    return
  end
  this._ReserveMissionClearOnOutOfHotZone()
end
function this._ReserveMissionClearOnOutOfHotZone()
  if mvars.mis_lastOutSideOfHotZoneButAlert then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK)
  end
  if TppLocation.IsAfghan()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}
  elseif TppLocation.IsMiddleAfrica()then
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE}
  else
    this.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}
  end
end
function this.DisconnectMatching(e)
  local n=TppNetworkUtil.IsHost()
  if n then
    svars.mis_isAbandonMission=true
  end
  SsdMatching.RequestCancelAutoMatch()
  if(e)then
    SsdMatching.RequestLeaveRoomAndSession()
  end
end
function this.AbandonMission()
  if not this.IsCoopMission(vars.missionCode)then
    if this.IsMatchingRoom(vars.missionCode)then
      this.AbandonCoopLobbyMission(vars.missionCode)
    end
    return
  end
  this.DisconnectMatching(true)
  this.ReturnToMatchingRoom()
end
function this.AbandonCoopLobbyMission(n)
  if not this.IsMatchingRoom(vars.missionCode)then
    return
  end
  if IS_GC_2017_COOP then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)
    this.DisconnectMatching(false)
    this.GameOverReturnToTitle()
    return
  end
  local n=this.IsMultiPlayMission(n)
  this.DisconnectMatching(n)
  Mission.RequestCancelMatchingScreen()
  if not n then
    local n={}n.isNeedUpdateBaseManagement=true
    this.ContinueFromCheckPoint(n)
  else
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=this.GetCoopLobbyMissionCode()
    if mvars.mis_missionAbortLoadingOption==nil then
      mvars.mis_missionAbortLoadingOption={}
    end
    mvars.mis_missionAbortLoadingOption.force=true
    this.ExecuteMissionAbort()
  end
end
function this.AbortMissionByMenu(n)
  if this.IsCoopMission(vars.missionCode)then
    this.AbandonMission()
  else
    local n=n or{}
    if this.IsMultiPlayMission(vars.missionCode)then
      n.isNoSurviveBox=true
    end
    this.AbortForOutOfMissionArea(n)
  end
end
function this.AbortForOutOfMissionArea(abortInfo)
  local isNoSave=false
  local isNoSurviveBox=false
  local presentationFunction
  local fadeDelayTime,fadeSpeed
  local playRadio
  if IsTypeTable(abortInfo)then
    if abortInfo.isNoSave then
      isNoSave=true
    end
    if abortInfo.isNoSurviveBox then
      isNoSurviveBox=true
    end
  end
  if TppLocation.IsAfghan()then
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=isNoSave,fadeDelayTime=fadeDelayTime,fadeSpeed=fadeSpeed,presentationFunction=presentationFunction,playRadio=playRadio,isNoSurviveBox=isNoSurviveBox}
  elseif TppLocation.IsMiddleAfrica()then
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE,isNoSave=isNoSave,fadeDelayTime=fadeDelayTime,fadeSpeed=fadeSpeed,presentationFunction=presentationFunction,playRadio=playRadio,isNoSurviveBox=isNoSurviveBox}
  else
    this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=isNoSave,fadeDelayTime=fadeDelayTime,fadeSpeed=fadeSpeed,presentationFunction=presentationFunction,playRadio=playRadio,isNoSurviveBox=isNoSurviveBox}
  end
end
function this.GameOverAbortMission()
  local n=TppDefine.SYS_MISSION_ID.AFGH_FREE
  if TppLocation.IsMiddleAfrica()then
    n=TppDefine.SYS_MISSION_ID.MAFR_FREE
  end
  this.AbortMission{nextMissionId=n,isAlreadyGameOver=true}
end
function this.GameOverAbortForOutOfMissionArea()
  mvars.mis_abortWithSave=true
  if TppLocation.IsAfghan()then
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
  elseif TppLocation.IsMiddleAfrica()then
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MAFR_FREE
  else
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
  end
end
function this.GameOverReturnToBase()
  TppRadio.Stop()
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"GameOverReturnToBaseFadeOut",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
end
function this.ExecuteGameOverReturnToBase()
  local WarpFinishCallback=function()
    local ServerSaveCallback=function()
      TppUI.HideAccessIcon()
      TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,"GameOverReturnToBaseFadeIn",TppUI.FADE_PRIORITY.SYSTEM)
    end
    Player.ResetPadMask{settingName="FastTravel"}
    local lifeRecoveryRate=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minLifeRateByContinue"}
    local oxygenRecoveryRate=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minOxygenRateByContinue"}
    local hungerRecoveryRate=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minHungerRateByContinue"}
    local thirstRecoveryRate=ScriptParam.GetValue{category=ScriptParamCategory.PLAYER,paramName="minThirstRateByContinue"}
    local reviveCommand={
      id="Revive",
      revivalType="Return",
      invincibleTime=0,
      lifeRecoveryRate=lifeRecoveryRate,
      oxygenRecoveryRate=oxygenRecoveryRate,
      hungerRecoveryRate=hungerRecoveryRate,
      thirstRecoveryRate=thirstRecoveryRate,
      cureInjuryAll=false
    }
    GameObject.SendCommand({type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()},reviveCommand)
    GameOverMenuSystem.RequestClose()
    TppMain.EnableGameStatus()
    TppGameStatus.Reset("TppMission.GameOverReturnToBase","S_IS_BLACK_LOADING")
    TppGameStatus.Reset("TppMission.GameOverReturnToBase","S_DISABLE_TARGET")
    TppSave.AddServerSaveCallbackFunc(ServerSaveCallback)
    if mvars.mis_isNeedSaveForGameOverReturnToBase then
      this.VarSaveOnUpdateCheckPoint()
    end
    Mission.SetRevivalDisabled(false)--RETAILPATCH: 1.0.2.1
  end
  svars.mis_isDefiniteGameOver=false
  svars.mis_gameOverType=0
  mvars.mis_isAborting=false
  mvars.mis_isReserveGameOver=false
  mvars.mis_isAllDead=false
  mvars.mis_isGameOverReasonSuicide=false
  mvars.mis_isNeedSaveForGameOverReturnToBase=false
  if TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")then
    mvars.mis_isNeedSaveForGameOverReturnToBase=true
  end
  this._CreateSurviveCBox()
  this._WarpToBase(WarpFinishCallback)
  TppGameStatus.Set("TppMission.GameOverReturnToBase","S_IS_BLACK_LOADING")
  TppGameStatus.Set("TppMission.GameOverReturnToBase","S_DISABLE_TARGET")
  TppUI.ShowAccessIcon()
end
function this.ReturnToBaseByMenu()
  if this.IsMultiPlayMission(vars.missionCode)then
    this.AbortMissionByMenu()
    return
  end
  if mvars.mis_isReserveMissionClear or mvars.mis_isReserveGameOver then
    return
  end
  if TppPlayer.IsFastTraveling()then
    return
  end
  TppPlayer.StartFastTravelByReturnBase()
end
function this._WarpToBase(CallBack)
  mvars.mis_finishWarpToBaseCallBack=nil
  if IsTypeFunc(CallBack)then
    mvars.mis_finishWarpToBaseCallBack=CallBack
  end
  local travelPointName="fast_afgh_basecamp"
  if TppLocation.IsMiddleAfrica()then
    travelPointName="fast_mafr_basecamp"
  end
  local identifier,key=SsdFastTravel.GetFastTravelPointName(StrCode32(travelPointName))
  if not identifier or not key then
    local basePositions={afgh=Vector3(-442,288,2239),mafr=Vector3(2790,96,-910)}
    local locationName=TppLocation.GetLocationName()
    --RETAILBUG:
    local position=basePositions[locationName]
    if not position then
      position=basePositions.afgh
    end
    local playerId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
    local command={id="WarpAndWaitBlock",pos=basePositions[locationName],resetState=true}
    GameObject.SendCommand(playerId,command)
    return
  end
  local pos,rotY=Tpp.GetLocatorByTransform(identifier,key)
  local rotYRad=Tpp.GetRotationY(rotY)
  if pos then
    pos=pos+Vector3(0,.8,0)
  end
  local playerId={type="TppPlayer2",index=PlayerInfo.GetLocalPlayerIndex()}
  local command={id="WarpAndWaitBlock",pos=pos,rotY=TppMath.DegreeToRadian(rotYRad),resetState=true}
  GameObject.SendCommand(playerId,command)
end
function this.OnChangeSVars(n,i)
  if n=="mis_isDefiniteMissionClear"then
    if(svars.mis_isDefiniteMissionClear)then
      mvars.mis_isReserveMissionClear=true
    end
  end
  if n=="mis_isDefiniteGameOver"then
    if(svars.mis_isDefiniteGameOver)then
      mvars.mis_isDefiniteGameOver=true
    end
  end
  if n=="mis_canMissionClear"then
    if svars.mis_canMissionClear then
      this.OnCanMissionClear()
    end
    if mvars.mis_isAlertOutOfMissionArea then
      this.EnableAlertOutOfMissionArea()
    else
      this.DisableAlertOutOfMissionArea()
    end
    if mvars.mis_isOutsideOfHotZone then
      this.ExitHotZone()
    end
  end
  if n=="mis_isAbandonMission"then
    if svars.mis_isAbandonMission then
      local n=TppNetworkUtil.IsHost()
      if not n then
        if Mission.IsHostMigrationActive()then
          this.StartWaitHostMigrationTimer()
        else
          if Mission.IsIgnoreExceptionDisconnectFromHost()then
            return
          end
          TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.SESSION_ABANDON)
          this.DisconnectMatching(true)
        end
      end
    end
  end
end
function this.StartWaitHostMigrationTimer()
  if Mission.IsHostMigrationActive()then
    TimerStart("Timer_WaitStartMigration",60)
  end
end
function this.PostMissionOrderBoxPositionToBuddyDog()
  if(not this.IsFreeMission(vars.missionCode))then
    if mvars.mis_orderBoxList then
      local n={}
      for s,i in pairs(mvars.mis_orderBoxList)do
        local e,i=this.GetOrderBoxLocatorByTransform(i)
        if e then
          table.insert(n,e)
        end
      end
      TppBuddyService.SetMissionGroundStartPositions{positions=n}
    else
      TppBuddyService.ResetDogLeakedInformation()
    end
  else
    TppBuddyService.ResetDogLeakedInformation()
  end
end
function this.SetIsStartFromFreePlay()
  gvars.mis_isStartFromFreePlay=true
end
function this.ResetIsStartFromHelispace()
end
function this.ResetIsStartFromFreePlay()
  gvars.mis_isStartFromFreePlay=false
end
function this.CanMissionAbortByMenu()
  if gvars.mis_isStartFromFreePlay then
    return true
  else
    return false
  end
end
function this.SetMissionOrderBoxPosition()
  if not mvars.mis_orderBoxList then
    return
  end
  if gvars.mis_orderBoxName==0 then
    return
  end
  local n=this.FindOrderBoxName(gvars.mis_orderBoxName)
  return this._SetMissionOrderBoxPosition(n)
end
function this._SetMissionOrderBoxPosition(n)
  local e,n=this.GetOrderBoxLocator(n)
  if e then
    local i=Vector3(0,-.75,1.98)
    local s=Vector3(e[1],e[2],e[3])
    local e=-Quat.RotationY(TppMath.DegreeToRadian(n)):Rotate(i)
    local e=e+s
    local e=TppMath.Vector3toTable(e)
    local n=n
    TppPlayer.SetInitialPosition(e,n)
    TppPlayer.SetMissionStartPosition(e,n)
    return true
  end
end
function this.FindOrderBoxName(n)
  for i,e in pairs(mvars.mis_orderBoxList)do
    if StrCode32(e)==n then
      return e
    end
  end
end
function this.GetOrderBoxLocator(e)
  if not IsTypeString(e)then
    return
  end
  return Tpp.GetLocator("OrderBoxIdentifier",e)
end
function this.GetOrderBoxLocatorByTransform(e)
  if not IsTypeString(e)then
  end
  return Tpp.GetLocatorByTransform("OrderBoxIdentifier",e)
end
function this.EstablishedMissionClear()
  DemoDaemon.StopAll()
  GkEventTimerManager.StopAll()
  if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
    GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})
  end
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  if this.systemCallbacks.OnSetMissionFinalScore then
    this.systemCallbacks.OnSetMissionFinalScore(svars.mis_missionClearType)
  end
  this.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.ESTABLISHED_CLEAR)
  this.systemCallbacks.OnEstablishMissionClear(svars.mis_missionClearType)
end
function this.OnMissionGameEndFadeOutFinish()
  TppEnemy.FultonRecoverOnMissionGameEnd()
  TppPlayer.SaveCaptureAnimal()
  if Player.CallRemovingChickenCapSE~=nil then
    Player.CallRemovingChickenCapSE()
  end
  if this.systemCallbacks.OnMissionGameEndFadeOutFinish then
    this.systemCallbacks.OnMissionGameEndFadeOutFinish()
  end
  if(mvars.mis_missionGameEndDelayTime>.1)then
    TimerStart("Timer_MissionGameEndStart",mvars.mis_missionGameEndDelayTime)
  else
    TimerStart("Timer_MissionGameEndStart",.1)
  end
end
function this.OnMissionGameEndFadeOutFinish2nd()
  TppUiStatusManager.ClearStatus"GmpInfo"
  TppStory.UpdateStorySequence{updateTiming="OnMissionClear",missionId=this.GetMissionID()}
  TppResult.SetMissionFinalScore(TppDefine.MISSION_TYPE.STORY)
  TppQuest.OnMissionGameEnd()
  SsdFlagMission.OnMissionGameEnd()
  SsdBaseDefense.OnMissionGameEnd()
  TppTerminal.OnEstablishMissionClear()
  if mvars.mis_blackRadioSetting then
    BlackRadio.Close()
    BlackRadio.ReadJsonParameter(mvars.mis_blackRadioSetting)
  end
  TppTutorial.OpenTipsOnCurrentStory()
  local e=this.GetMissionClearType()
  if(e==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO)or(e==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX)then
    TppUiCommand.LoadoutSetMissionRecieveFromFreeToMission()
  end
  TppPlayer.AggregateCaptureAnimal()
  TppTerminal.AddStaffsFromTempBuffer()
  TppSave.EraseAllGameDataSaveRequest()
  TppSave.VarSave()
  if DebugMenu then
    TppSave.QARELEASE_DEBUG_ExecuteReservedDestroySaveData()
  end
  TimerStart("Timer_MissionGameEndStart2nd",.1)
end
function this.SetMissionObjectives(n,i,e)
  mvars.mis_missionObjectiveDefine=n
  mvars.mis_missionObjectiveTree=i
  mvars.mis_missionObjectiveEnum=e
  if mvars.mis_missionObjectiveTree then
    for n,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
      for e,i in pairs(e)do
        local e=mvars.mis_missionObjectiveDefine[e]
        if e then
          e.parent=e.parent or{}
          e.parent[n]=true
        end
      end
    end
  end
  if mvars.mis_missionObjectiveTree and mvars.mis_missionObjectiveEnum==nil then
    return
  end
  if#mvars.mis_missionObjectiveEnum>unkM5 then
    return
  end
end
function this.OnFinishUpdateObjectiveRadio(n)
  if n==StrCode32(mvars.mis_updateObjectiveRadioGroupName)then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
function this.ShowUpdateObjective(n)
  if not IsTypeTable(n)then
    return
  end
  local i={}
  for n,s in pairs(n)do
    local n=mvars.mis_missionObjectiveDefine[s]
    local a=true
    local a=not this.IsEnableMissionObjective(s)
    if a then
      a=(not this.IsEnableAnyParentMissionObjective(s))
    end
    if n and a then
      this.DisableChildrenObjective(s)
      this._ShowObjective(n,true)
      local a={isMissionAnnounce=false,subGoalId=nil}
      if n.announceLog then
        a.isMissionAnnounce=true
        if n.subGoalId then
          a.subGoalId=n.subGoalId
        end
        i[n.announceLog]=a
      end
      this.SetMissionObjectiveEnable(s,true)
    end
  end
  if next(i)then
    for e=1,#TppUI.ANNOUNCE_LOG_PRIORITY do
      local n=TppUI.ANNOUNCE_LOG_PRIORITY[e]
      local e=i[n]
      if e then
        if e.isMissionAnnounce then
          TppUI.ShowAnnounceLog(n)
          if e.subGoalId and e.subGoalId>0 then
            TppUI.ShowAnnounceLog("subGoalContent",nil,nil,nil,e.subGoalId)
          end
        end
        i[n]=nil
      end
    end
    if next(i)then
      for e,n in pairs(i)do
        TppUI.ShowAnnounceLog(e)
      end
    end
    TppSoundDaemon.PostEvent"sfx_s_terminal_data_fix"
  end
  mvars.mis_objectiveSetting=nil
  mvars.mis_updateObjectiveRadioGroupName=nil
end
function this._ShowObjective(e,n)
  if e.packLabel then
    if not TppPackList.IsMissionPackLabelList(e.packLabel)then
      return
    end
  end
  if e.setInterrogation==nil then
    e.setInterrogation=true
  end
  if e.gameObjectName then
    TppMarker.Enable(e.gameObjectName,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.langId,e.guidelinesId)
  end
  if e.gimmickId then
    local i,n=TppGimmick.GetGameObjectId(e.gimmickId)
    if i then
      TppMarker.Enable(n,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.langId,e.guidelinesId)
    end
  end
  if e.subGoalId then
    TppUI.EnableMissionSubGoal(e.subGoalId)
    if e.subGoalId>0 then
      if not e.announceLog then
        e.announceLog="updateMissionInfo"end
    end
  end
  if e.showEnemyRoutePoints then
    if TppUiCommand.ShowEnemyRoutePoints then
      local n=e.showEnemyRoutePoints.radioGroupName
      if IsTypeString(n)then
        e.showEnemyRoutePoints.radioGroupName=StrCode32(n)
      end
      TppUiCommand.ShowEnemyRoutePoints(e.showEnemyRoutePoints)
    end
  end
  if e.targetBgmCp then
    TppEnemy.LetCpHasTarget(e.targetBgmCp,true)
  end
  if e.missionTask then
    TppUI.EnableMissionTask(e.missionTask,n)
  end
  if e.seEventName then
    if n then
      TppSoundDaemon.PostEvent(e.seEventName)
    end
  end
end
function this.RestoreShowMissionObjective()
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  for i,n in ipairs(mvars.mis_missionObjectiveEnum)do
    if not svars.mis_objectiveEnable[i]then
      local n=mvars.mis_missionObjectiveDefine[n]
      if n then
        this.DisableObjective(n)
      end
    end
  end
  for i,n in ipairs(mvars.mis_missionObjectiveEnum)do
    if svars.mis_objectiveEnable[i]then
      local n=mvars.mis_missionObjectiveDefine[n]
      if n then
        this._ShowObjective(n,false)
      end
    end
  end
end
function this.SetMissionObjectiveEnable(e,n)
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  local e=mvars.mis_missionObjectiveEnum[e]
  if not e then
    return
  end
  svars.mis_objectiveEnable[e]=n
end
function this.IsEnableMissionObjective(e)
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  local e=mvars.mis_missionObjectiveEnum[e]
  if not e then
    return
  end
  return svars.mis_objectiveEnable[e]
end
function this.GetParentObjectiveName(e)
  local e=mvars.mis_missionObjectiveDefine[e]
  if not e then
    return
  end
  return e.parent
end
function this.IsEnableAnyParentMissionObjective(n)
  local n=mvars.mis_missionObjectiveDefine[n]
  if not n then
    return
  end
  if not n.parent then
    return false
  end
  local i
  for n,s in pairs(n.parent)do
    if this.IsEnableMissionObjective(n)then
      return true
    else
      i=this.IsEnableAnyParentMissionObjective(n)
      if i then
        return true
      end
    end
  end
  return false
end
function this.DisableChildrenObjective(s)
  local n
  for i,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
    if i==s then
      n=e
      break
    end
  end
  if not n then
    return
  end
  for i,n in Tpp.BfsPairs(n)do
    local n=mvars.mis_missionObjectiveDefine[i]
    if n then
      this.SetMissionObjectiveEnable(i,false)
      this.DisableObjective(n)
    end
  end
end
function this.DisableObjective(e)
  if e.packLabel then
    if not TppPackList.IsMissionPackLabelList(e.packLabel)then
      return
    end
  end
  if e.gameObjectName then
    TppMarker.Disable(e.gameObjectName,e.mapRadioName)
  end
  if e.gimmickId then
    local i,n=TppGimmick.GetGameObjectId(e.gimmickId)
    if i then
      TppMarker.Disable(n,e.mapRadioName)
    end
  end
  if e.showEnemyRoutePoints then
    local e=e.showEnemyRoutePoints.groupIndex
    if TppUiCommand.InitEnemyRoutePoints then
      TppUiCommand.InitEnemyRoutePoints(e)
    end
  end
  if e.targetBgmCp then
    TppEnemy.LetCpHasTarget(e.targetBgmCp,false)
  end
  if e.missionTask then
    TppUiCommand.DisableMissionTask(e.missionTask)
  end
end
function this.VarSaveOnUpdateCheckPoint(n)
  gvars.isNewGame=false
  TppTerminal.AddStaffsFromTempBuffer(true)
  TppSave.ReserveVarRestoreForContinue()
  TppEnemy.StoreSVars()
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppPlayer.StorePlayerDecoyInfos()
  SsdSbm.StoreToSVars()
  this.VarSaveForBuilding()
  SsdCrewSystem.Store()
  SsdBaseManagement.Store()
  svars.ply_isUsedPlayerInitialAction=true
  TppRadioCommand.StoreRadioState()
  Gimmick.StoreSaveDataPermanentGimmickFromCheckPoint()
  TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.CHECK_POINT)
end
function this.VarSaveForBuilding()
  if TppLocation.IsOMBS()or TppLocation.IsInit()then
    return
  end
  SsdBuilding.Save()
end
function this.SafeStopSettingOnMissionReload(e)
  local n
  if e and e.setMute then
    n=e.setMute
  end
  mvars.mis_missionStateIsNotInGame=true
  gvars.canExceptionHandling=false
  SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
  TppRadio.Stop()
  TppMusicManager.StopMusicPlayer(1)
  TppMusicManager.EndSceneMode()
  TppRadioCommand.SetEnableIgnoreGamePause(false)
  if TppBuddy2BlockController.Unload then
    TppBuddy2BlockController.Unload()
  end
  GkEventTimerManager.StopAll()
  if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
    GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})
  end
  if n then
    TppSoundDaemon.SetMute(n)
  else
    TppSound.SetMuteOnLoading()
  end
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.VarResetOnNewMission()
  TppScriptVars.InitForNewMission()
  TppCheckPoint.Reset()
  TppQuest.ResetQuestStatus()SsdFlagMission.ResetFlagMissionStatus()
  TppPackList.SetDefaultMissionPackLabelName()
  TppPlayer.UnsetRetryFlag()
  if GameConfig.GetStealthAssistEnabled()then
    mvars.mis_needSaveConfigOnNewMission=true
    GameConfig.SetStealthAssistEnabled(false)
  end
  TppPlayer.ResetStealthAssistCount()
  TppSave.ReserveVarRestoreForMissionStart()
  this.SetNextMissionCodeForMissionClear(unkM6)
  this.ResetMissionClearState()
end
function this.RequestLoad(nextMission,currentMission,options)
  if not mvars then
    return
  end
  if gvars.isLoadedInitMissionOnSignInUserChanged then
    return
  end
  TppMain.EnablePause()
  mvars.mis_loadRequest={nextMission=nextMission,currentMission=currentMission,options=options}
end
function this.OnPreLoadWithChunkCheck()
  local nextMissionCode,currentMissionCode,needLoadMission=gvars.mis_nextMissionAfterChunkCheck,gvars.mis_currentMissionAfterChunkCheck,gvars.mis_needLoadMissionAfterChunkCheck
  if DebugText then
    local Context=DebugText.NewContext()
    DebugText.Print(Context,{.5,.5,1},"Requested load : nextMission = "..(tostring(nextMissionCode)..(", currentMission = "..tostring(currentMissionCode))))
  end
  if vars.locationCode==TppDefine.LOCATION_ID.INIT or nextMissionCode>=6e4 then
    this._OnPreLoadWithChunkCheckEnd(currentMissionCode,nextMissionCode)
    return
  else
    do
      if mvars.mis_popupTypeChunkInstalling==nil then
        if TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)then
          mvars.mis_popupTypeChunkInstalling=TppDefine.ERROR_ID.NOW_INSTALLING
        end
      elseif not TppUiCommand.IsShowPopup()then
        if mvars.mis_popupTypeChunkInstalling==TppDefine.ERROR_ID.NOW_INSTALLING then
          TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.INSTALL_CANCEL,Popup.TYPE_TWO_BUTTON)
          mvars.mis_popupTypeChunkInstalling=TppDefine.ERROR_ID.INSTALL_CANCEL
          return
        elseif mvars.mis_popupTypeChunkInstalling==TppDefine.ERROR_ID.INSTALL_CANCEL then
          if TppUiCommand.GetPopupSelect()==1 then
            mvars.mis_isCancelChunkLoadingOnMissionLoad=true
          else
            mvars.mis_popupTypeChunkInstalling=nil
          end
        else
          mvars.mis_popupTypeChunkInstalling=nil
        end
      end
    end
    if not mvars.mis_isCancelChunkLoadingOnMissionLoad then
      local chunkIndexList=Tpp.GetChunkIndexList(vars.locationCode,nextMissionCode)
      if this.IsChunkLoading(chunkIndexList,true)then
        return
      end
    else
      needLoadMission=true
      gvars.ini_isTitleMode=true
      nextMissionCode=TppDefine.SYS_MISSION_ID.INIT
      vars.missionCode=nextMissionCode
      vars.locationCode=TppDefine.LOCATION_ID.INIT
      gvars.waitLoadingTipsEnd=false
      TppUI.SetFadeColorToBlack()
    end
  end
  this._OnPreLoadWithChunkCheckEnd(currentMissionCode,nextMissionCode,needLoadMission)
end
function this._OnPreLoadWithChunkCheckEnd(currentMissionCode,nextMissionCode,needLoadMission)
  Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
  if needLoadMission then
    Mission.LoadMission(currentMissionCode,nextMissionCode,{showLoadingTips=true,force=true})
  end
  if(currentMissionCode~=nextMissionCode)then
    this.LoadLocation(currentMissionCode,nextMissionCode)
  end
  mvars.mis_isCancelChunkLoadingOnMissionLoad=nil
  mvars.mis_isChunkLoadingOnMissionLoad=nil
  gvars.mis_chunkingCheckOnPreLoad=false
  gvars.mis_needLoadMissionAfterChunkCheck=false
  gvars.mis_nextMissionAfterChunkCheck=1
  gvars.mis_currentMissionAfterChunkCheck=1
end
function this.IsChunkLoading(chunkIndexes,unkP2)
  if SplashScreen.GetSplashScreenWithName"konamiLogo"then
    return true
  end
  if SplashScreen.GetSplashScreenWithName"kjpLogo"then
    return true
  end
  if SplashScreen.GetSplashScreenWithName"foxLogo"then
    return true
  end
  Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
  for i,chunkIndex in ipairs(chunkIndexes)do
    local chunkState=Chunk.GetChunkState(chunkIndex)
    if chunkState==Chunk.STATE_INSTALLED then
    elseif chunkState==Chunk.STATE_INSTALLING then
      if not TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.INSTALL_CANCEL)then
        Tpp.ShowChunkInstallingPopup(chunkIndexes,unkP2)
      end
      return true
    elseif chunkState==Chunk.STATE_EMPTY then
      Chunk.PrefetchChunk(chunkIndex)
      return true
    end
  end
  if TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)or TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)then
    TppUiCommand.ErasePopup()
  end
  Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
  return false
end
function this.Load(nextMissionCode,currentMissionCode,loadSettings)
  local showLoadingTips
  if(loadSettings and loadSettings.showLoadingTips~=nil)then
    showLoadingTips=loadSettings.showLoadingTips
  else
    showLoadingTips=true
  end
  local currentIsMultiPlay=(currentMissionCode and not this.IsMultiPlayMission(currentMissionCode))
  local nextIsMultiPlay=this.IsMultiPlayMission(nextMissionCode)
  local nextIsAvatarEdit=this.IsAvatarEditMission(nextMissionCode)
  local nextIsInit=(nextMissionCode==TppDefine.SYS_MISSION_ID.INIT)
  if(loadSettings and loadSettings.waitOnLoadingTipsEnd~=nil)then
    gvars.waitLoadingTipsEnd=loadSettings.waitOnLoadingTipsEnd
  else
    local waitLoadingTipsEnd=(((((nextIsMultiPlay or nextIsAvatarEdit)or InvitationManagerController.IsGoingCoopMission())or gvars.mis_isReloaded)or gvars.ini_isTitleMode)or nextIsInit)
    if waitLoadingTipsEnd then
      gvars.waitLoadingTipsEnd=false
    else
      gvars.waitLoadingTipsEnd=true
    end
  end
  TppMain.EnablePause()
  TppMain.EnableBlackLoading(showLoadingTips)
  if not TppEnemy.IsLoadedDefaultSoldier2CommonPackage()then
    TppEnemy.UnloadSoldier2CommonBlock()
  end
  if nextIsMultiPlay or nextIsInit then
    BaseDefenseManager.Reset()
  end
  local forceLoad=((loadSettings and loadSettings.force)or((this.IsMatchingRoom(nextMissionCode)and this.IsMatchingRoom(currentMissionCode))and InvitationManagerController.HasInviteConsumed()))or(nextMissionCode==TppDefine.SYS_MISSION_ID.TITLE)
  if(currentMissionCode~=nextMissionCode)or forceLoad then
    if TppSystemUtility.GetCurrentGameMode()=="TPP"then
      TppEneFova.InitializeUniqueSetting()
      TppEnemy.PreMissionLoad(nextMissionCode,currentMissionCode)
    end
    if not Mission.IsReadyGameSequence()or forceLoad then
      this.LoadLocation(currentMissionCode,nextMissionCode,forceLoad)
    end
    Mission.LoadMission{force=forceLoad}
  else
    Mission.RequestToReload()
  end
  TppUI.ShowAccessIcon()
end
function this.ExecuteReload()
  if gvars.exc_processingForDisconnect then
    return
  end
  if mvars.mis_nextLocationCode then
    vars.locationCode=mvars.mis_nextLocationCode
  end
  if mvars.mis_nextClusterId then
    vars.mbClusterId=mvars.mis_nextClusterId
  end
  gvars.sav_skipRestoreToVars=true
  gvars.mis_isReloaded=true
  gvars.mis_skipUpdateBaseManagement=true
  TppStory.UpdateStorySequence{updateTiming="OnMissionReload"}
  this.SafeStopSettingOnMissionReload()
  TppPackList.SetMissionPackLabelName(mvars.mis_missionPackLabelName)
  TppSave.VarSave()
  TppSave.CheckAndSavePersonalData()
  this.RequestLoad(vars.missionCode,nil,{force=true,showLoadingTips=mvars.mis_showLoadingTipsOnReload})
end
function this.CanStart()
  if mvars.mis_alwaysMissionCanStart then
    return true
  else
    return Mission.CanStart()
  end
end
function this.SetNextMissionCodeForMissionClear(e)
  gvars.mis_nextMissionCodeForMissionClear=e
  gvars.mis_nextLocationCodeForMissionClear=vars.locationCode
  local e=TppPackList.GetLocationNameFormMissionCode(e)
  if e then
    gvars.mis_nextLocationCodeForMissionClear=TppDefine.LOCATION_ID[e]
  end
end
function this.GetNextMissionCodeForMissionClear()
  return gvars.mis_nextMissionCodeForMissionClear
end
function this.AlwaysMissionCanStart()
  mvars.mis_alwaysMissionCanStart=true
end
function this.SetSortieBuddy()
end
function this.GetObjectiveRadioOption(n)
  local e={}
  if IsTypeTable(n.radioOptions)then
    for i,n in pairs(n.radioOptions)do
      e[i]=n
    end
  end
  if FadeFunction.IsFadeProcessing()then
    local n=e.delayTime
    local i=TppUI.FADE_SPEED.FADE_NORMALSPEED+1.2
    if IsTypeString(n)then
      e.delayTime=TppRadio.PRESET_DELAY_TIME[n]+i
    elseif IsTypeNumber(n)then
      e.delayTime=n+i
    else
      e.delayTime=i
    end
  end
  return e
end
function this.OnMissionStart()
  local missionCode=vars.missionCode
  if this.IsCoopMission(missionCode)then
    Mission.StartVotingSystem()
  end
  if not this.IsSysMissionId(missionCode)then
    MissionListMenuSystem.SetCurrentMissionCode(missionCode)
  end
  mvars.mis_isMultiPlayMission=this.IsMultiPlayMission(missionCode)
  gvars.mis_isReloaded=false
end
function this.OnMissionFinalize()
  local e=vars.missionCode
  SsdSbm.SetKubTemporalStorageMode(false)
end
function this.SetPlayRecordClearInfo()
  local e,n=TppStory.CalcAllMissionClearedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="MissionClear",clearCount=e,allCount=n}
  local n,e=TppStory.CalcAllMissionTaskCompletedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="MissionTaskClear",clearCount=n,allCount=e}
  local n,e=TppQuest.CalcQuestClearedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="SideOpsClear",clearCount=n,allCount=e}
end
function this.IsBossBattle()
  if not mvars.mis_isBossBattle then
    return false
  end
  return true
end
function this.StartBossBattle()
  mvars.mis_isBossBattle=true
end
function this.FinishBossBattle()
  mvars.mis_isBossBattle=false
end
function this.ShowAnnounceLogOnGameStart()
  local n,e=this.ParseMissionName(this.GetMissionName())
  if e=="free"then
    if gvars.mis_isExistOpenMissionFlag then
      TppUI.ShowAnnounceLog"missionListUpdate"
      TppUI.ShowAnnounceLog"missionAdd"
      gvars.mis_isExistOpenMissionFlag=false
    end
    TppQuest.ShowAnnounceLogQuestOpen()
  end
end
function this.SetDefensePosition(n)
  if not IsTypeTable(n)then
    return
  end
  local e
  if n.useCurrentLocationBaseDiggerPosition then
    e=TppGimmick.GetCurrentLocationDiggerPosition()
  else
    e=n
  end
  Mission.SetDefensePosition{pos=e}
end
function this.RegisterDefenseGameArea(t,s,i)
  mvars.mis_defeseGameAreaTrapTable=mvars.mis_defeseGameAreaTrapTable or{}
  local n=mvars.mis_defeseGameAreaTrapTable
  n.trapList=n.trapList or{}
  table.insert(n.trapList,t)n.alertTrapList=n.alertTrapList or{}
  table.insert(n.alertTrapList,s)n.trapToWaveName=n.trapToWaveName or{}n.trapToWaveName[StrCode32(t)]=i
  n.trapToWaveName[StrCode32(s)]=i
  mvars.mis_defeseGameAreaMessageExecTable=Tpp.MakeMessageExecTable(Tpp.StrCode32Table{Trap={{msg="Exit",sender=n.trapList,func=this.OnExitDefenseGameArea},{msg="Exit",sender=n.alertTrapList,func=this.OnExitAlertDefenseGameAreaTrap}}})
end
function this.OnExitDefenseGameArea(n)
  if(not this.systemCallbacks.OnOutOfDefenseGameArea)or(not mvars.mis_defeseGameAreaTrapTable.trapToWaveName)then
    return
  end
  local n=mvars.mis_defeseGameAreaTrapTable.trapToWaveName[n]
  this.systemCallbacks.OnOutOfDefenseGameArea(n)
end
function this.OnExitAlertDefenseGameAreaTrap(n)
  if((not this.systemCallbacks.OnAlertOutOfDefenseGameArea)or(not mvars.mis_defeseGameAreaTrapTable.trapToWaveName))or(Mission.GetDefenseGameState()==TppDefine.DEFENSE_GAME_STATE.NONE)then
    return
  end
  local n=mvars.mis_defeseGameAreaTrapTable.trapToWaveName[n]
  this.systemCallbacks.OnAlertOutOfDefenseGameArea(n)
end
function this.RegisterFreePlayWaveSetting(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.mis_freeWaveSetting=e
end
function this.GetFreePlayWaveSetting()
  return mvars.mis_freeWaveSetting
end
function this.SetUpWaveSetting(a)
  if not IsTypeTable(a)then
    return
  end
  local n,t,s,o={},{},{},{}
  for a,i in ipairs(a)do
    for i,e in ipairs(i[1])do
      table.insert(n,e)
    end
    Tpp.MergeTable(t,i[2])
    Tpp.MergeTable(s,i[3])
    Tpp.MergeTable(o,i[4])
  end
  this.RegisterWaveList(Tpp.Enum(n))
  this.RegisterWavePropertyTable(t)
  local i,e=TppEnemy.MakeSpawnSettingTable(n,s,o)
  local n=TppEnemy.MakeWaveSettingTable(n,s)
  TppEnemy.RegisterWaveSpawnPointList(e)
  local e={type="TppCommandPost2"}
  GameObject.SendCommand(e,{id="SetSpawnSetting",settingTable=i})
  GameObject.SendCommand(e,{id="SetWaveSetting",settingTable=n})
end
function this.RegisterWaveList(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.mis_waveList=e
end
function this.RegisterWavePropertyTable(e)
  if not IsTypeTable(e)then
    return
  end
  mvars.mis_wavePropertyTable=e
end
function this.GetWaveLimitTime(e)
  if not mvars.mis_wavePropertyTable then
    return
  end
  local e=mvars.mis_wavePropertyTable[e]
  if not e then
    return
  end
  return e.limitTimeSec
end
function this.GetWaveIntervalTime(e)
  if not mvars.mis_wavePropertyTable then
    return
  end
  local e=mvars.mis_wavePropertyTable[e]
  if not e then
    return
  end
  return e.intervalTimeSec
end
function this.GetWaveProperty(e)
  if not mvars.mis_wavePropertyTable then
    return
  end
  return mvars.mis_wavePropertyTable[e]
end
function this.IsTerminalWave(e)
  if not mvars.mis_wavePropertyTable then
    return
  end
  return mvars.mis_wavePropertyTable[e].isTerminal
end
function this.GetCurrentWaveName()
  if not mvars.mis_waveList then
    return
  end
  if not mvars.mis_waveIndex then
    return
  end
  return mvars.mis_waveList[mvars.mis_waveIndex]
end
function this.GetNextWaveName()
  if not mvars.mis_waveList then
    return
  end
  if not mvars.mis_waveIndex then
    return
  end
  return mvars.mis_waveList[mvars.mis_waveIndex+1]
end
function this.SetInitialWaveName(e)
  local n=mvars.mis_waveList[e]
  if not n then
    return
  end
  mvars.mis_initialWaveName=e
end
if(Tpp.IsQARelease()or nil)then
  function this.DEBUG_SetInitialWaveName(n)
    this.SetInitialWaveName(n)
  end
  function this.DEBUG_GetInitialWaveName(e)
    return mvars.mis_initialWaveName
  end
end
function this.GetInitialWaveName()
  return mvars.mis_initialWaveName
end
function this.GetCurrentWaveIndex()
  return mvars.mis_waveIndex
end
function this.AddDefenseGameTargetKillCount(e)
  if not Mission.AddDefenseGameTargetKillCount then
    return
  end
  if e==nil then
    e=1
  end
  Mission.AddDefenseGameTargetKillCount(e)
end
function this.GetDefenseGameTargetKillCount()
  if not Mission.AddDefenseGameTargetKillCount then
    return 0
  end
  return Mission.GetDefenseGameTargetKillCount()
end
function this.SetDiggerLifeBreakSetting(e)
  if not Mission.SetDiggerLifeBreakSetting then
    return
  end
  Mission.SetDiggerLifeBreakSetting(e)
end
function this.StartDefenseGame(i,s,a,n)
  if n==nil then
    n={}
  end
  mvars.mis_waveIndex=1
  if mvars.mis_initialWaveName then
    local e=mvars.mis_waveList[mvars.mis_initialWaveName]
    if not e then
      return
    end
    mvars.mis_waveIndex=e
  end
  TppUI.SetDefenseGameMenu()
  if not this.IsMultiPlayMission(vars.missionCode)then
    SsdSbm.SetKubTemporalStorageMode(true)
  end
  if mvars.mis_defeseGameAreaTrapTable and mvars.mis_defeseGameAreaTrapTable.trapList then
    for n,e in ipairs(mvars.mis_defeseGameAreaTrapTable.trapList)do
      MapInfoSystem.SetSingleMissionDefenseGameArea(e)
    end
  end
  Mission.StartDefenseGame{limitTime=i,prepareTime=(n.prepareTime or i),alertTime=s,defenseType=a,finishType=n.finishType,killCount=n.killCount,shockWaveEffect=n.shockWaveEffect,miniMap=n.miniMap,prepareTimerLangId=n.prepareTimerLangId,waveTimerLangId=n.waveTimerLangId,intervalTimerLangId=n.intervalTimerLangId,showWaveTimer=n.showWaveTimer}
end
function this.StartDefenseGameWithWaveProperty(n)
  if not IsTypeTable(n)then
    return
  end
  local s=n.defenseGameType
  local r=n.defenseTimeSec
  local o=n.alertTimeSec
  local shockWaveEffect=n.endEffectName or"explosion"
  local i=n.finishType
  local miniMap=n.miniMap
  local prepareTimerLangId=n.prepareTimerLangId
  local waveTimerLangId=n.waveTimerLangId
  local intervalTimerLangId=n.intervalTimerLangId
  local a=n.showWaveTimer
  local isBaseDigging=n.isBaseDigging
  local prepareTime=n.prepareTime
  local showWaveTimer=n.showWaveTimer
  local n={shockWaveEffect=shockWaveEffect,miniMap=miniMap,prepareTime=prepareTime,prepareTimerLangId=prepareTimerLangId,waveTimerLangId=waveTimerLangId,intervalTimerLangId=intervalTimerLangId,showWaveTimer=showWaveTimer}
  if i then
    n.finishType=i.type
    n.killCount=i.maxCount
  end
  this.StartDefenseGame(r,o,s,n)
end
function this.StopDefenseGame()
  TppGimmick.DeactivateRegisterdDefenseTarget()
  if TppLocation.IsAfghan()then
    TppGimmick.ResetAfghBaseDiggerTarget()
    TppEnemy.SetUnrealAllFreeZombie(false)
  end
  Mission.DisableWaveEffect()
  Mission.StopDefenseGame()
  TppUI.UnsetDefenseGameMenu()
  SsdSbm.SetKubTemporalStorageMode(false)
  if mvars.mis_defeseGameAreaTrapTable and mvars.mis_defeseGameAreaTrapTable.trapList then
    for n,e in ipairs(mvars.mis_defeseGameAreaTrapTable.trapList)do
      MapInfoSystem.ClearSingleMissionDefenseGameArea(e)
    end
  end
  mvars.mis_waveIndex=nil
  mvars.mis_initialWaveName=nil
end
function this.StopDefenseTotalTime()
  Mission.DisableWaveEffect()
  Mission.StopDefenseTotalTime()
end
function this.ExtendTimeLimit(extendTime)
  Mission.ExtendTimeLimit{extendTime=extendTime}
end
function this.StartWaveInterval(unkT1)
  local intervalTime,currentWaveName,nextWaveName
  if IsTypeNumber(unkT1)then
    intervalTime=unkT1
  elseif IsTypeTable(unkT1)then
    currentWaveName=this.GetCurrentWaveName()
    nextWaveName=this.GetNextWaveName()
    intervalTime=this.GetWaveIntervalTime(currentWaveName)
    if not intervalTime then
      return
    end
    TppEnemy.StartWaveInterval(nextWaveName)
  else
    return
  end
  local nextWaveProperties=this.GetWaveProperty(nextWaveName)
  if nextWaveProperties then
    if nextWaveProperties.enemyLaneRouteList then
      Mission.RegisterEnemyLaneRouteTable{[""]=nextWaveProperties.enemyLaneRouteList}
    end
  end
  Mission.StartWaveInterval{intervalTime=intervalTime}
  Mission.StartWaveResult()
end
function this.ShowPrepareInitWaveUI(n)
  local waveProperties=this.GetWaveProperty(n)
  if waveProperties then
    if waveProperties.enemyLaneRouteList then
      Mission.RegisterEnemyLaneRouteTable{[""]=waveProperties.enemyLaneRouteList}
    end
    TppEnemy.EnableWaveSpawnPointEffect(n)
    Mission.EnableWaveEffect()
    SsdMinimap.Open()
    if waveProperties.defenseTargetGimmickProperty then
      local defenseTargetList=TppGimmick.MakeDefenseTargetListFromWaveProperty(waveProperties.defenseTargetGimmickProperty)
      if defenseTargetList then
        TppGimmick.SetDefenseTargetWithList(defenseTargetList,true)
        TppGimmick.RegisterActivatedDefenseTargetList(defenseTargetList)
      end
    end
    TppUI.SetDefenseGameMenu()
  end
end
function this.DisablePrepareInitWaveUI(e)
  TppGimmick.DeactivateRegisterdDefenseTarget()
  Mission.DisableWaveEffect()
  MapInfoSystem.ClearVisibleEnemyRouteInfos()
  TppEffectUtility.RemoveEnemyRootView()
  SsdMinimap.Close()
  TppUI.UnsetDefenseGameMenu()
end
function this.StartInitialWave(unkP1,unkP2)
  this.SetInitialWaveName(unkP1)
  local waveProperties=this.GetWaveProperty(unkP1)
  if not IsTypeTable(waveProperties)then
    return
  end
  local defenseTimeSec=waveProperties.defenseTimeSec
  if not defenseTimeSec then
    defenseTimeSec=(30*3)
  end
  local alertTimeSec=waveProperties.alertTimeSec
  if not alertTimeSec then
    alertTimeSec=defenseTimeSec/10
  end
  local defenseGameType=waveProperties.defenseGameType
  if not defenseGameType then
    defenseGameType=TppDefine.DEFENSE_GAME_TYPE.BASE
  end
  local endEffectName=waveProperties.endEffectName or"explosion"
  local finishType=waveProperties.finishType
  local miniMap=waveProperties.miniMap
  local prepareTimerLangId=waveProperties.prepareTimerLangId
  local waveTimerLangId=waveProperties.waveTimerLangId
  local intervalTimerLangId=waveProperties.intervalTimerLangId
  local showWaveTimer=waveProperties.showWaveTimer
  local isBaseDigging=waveProperties.isBaseDigging
  local unkT1={
    shockWaveEffect=endEffectName,
    miniMap=miniMap,
    prepareTimerLangId=prepareTimerLangId,
    waveTimerLangId=waveTimerLangId,
    intervalTimerLangId=intervalTimerLangId,
    showWaveTimer=showWaveTimer
  }
  if finishType then
    unkT1.finishType=finishType.type
    unkT1.killCount=finishType.maxCount
  end
  if not unkP2 then
    this.StartDefenseGame(defenseTimeSec,alertTimeSec,defenseGameType,unkT1)
  end
  local defaultDiggerLifeBreakPoints={.75,.5,.25}
  local defaultDiggerLifeBreakShockWaveRadius=2
  local diggerLifeBreakPoints=waveProperties.diggerLifeBreakPoints or defaultDiggerLifeBreakPoints
  local diggerLifeBreakShockWaveRadius=waveProperties.diggerLifeBreakShockWaveRadius or defaultDiggerLifeBreakShockWaveRadius
  this.SetDiggerLifeBreakSetting{breakPoints=diggerLifeBreakPoints,radius=diggerLifeBreakShockWaveRadius}
  local defaultWaveFinishShockWaveRadius=60
  local waveFinishShockWaveRadius=waveProperties.waveFinishShockWaveRadius or defaultWaveFinishShockWaveRadius
  if waveFinishShockWaveRadius then
    Mission.SetDiggerShockWaveRadiusAtWaveFinish(waveFinishShockWaveRadius)
  end
  if((TppLocation.IsAfghan()and(defenseGameType==TppDefine.DEFENSE_GAME_TYPE.BASE))and unkT1.finishType~=TppDefine.DEFENSE_FINISH_TYPE.KILL_COUNT)and not(isBaseDigging)then
    TppGimmick.SetAfghBaseDiggerTargetToReturnWormhole()
    TppGimmick.OpenAfghBaseDigger()
    TppEnemy.SetUnrealAllFreeZombie(true)
  end
  local unkT2
  local pos,radius=(waveProperties.defensePosition or waveProperties.pos),waveProperties.radius
  local useSpecifiedAreaEnemy=waveProperties.useSpecifiedAreaEnemy
  if IsTypeTable(useSpecifiedAreaEnemy)then
    if IsTypeTable(useSpecifiedAreaEnemy[1])and useSpecifiedAreaEnemy[1].pos then
      if not pos then
        pos,radius=useSpecifiedAreaEnemy[1].pos,useSpecifiedAreaEnemy[1].radius
      end
    else
      useSpecifiedAreaEnemy=nil
    end
  end
  if not pos then
    pos={useCurrentLocationBaseDiggerPosition=true}
  end
  if radius and IsTypeNumber(pos[1])then
    unkT2=unkT2 or{}
    unkT2.useSpecifiedAreaEnemy=useSpecifiedAreaEnemy or{{pos=pos,radius=radius}}
  end
  this.SetDefensePosition(pos)
  if waveProperties.defenseTargetGimmickProperty then
    local defenseTargetList=TppGimmick.MakeDefenseTargetListFromWaveProperty(waveProperties.defenseTargetGimmickProperty)
    if defenseTargetList then
      TppGimmick.SetDefenseTargetWithList(defenseTargetList,true)
      TppGimmick.RegisterActivatedDefenseTargetList(defenseTargetList)
      local gimmickIdTable=waveProperties.defenseTargetGimmickProperty.identificationTable
      if gimmickIdTable and gimmickIdTable.fastTravelPoint then
        TppGimmick.SetDefenseTargetLevelByWaveProperty(waveProperties)
      end
    end
  end
  if waveProperties.enemyLaneRouteList then
    Mission.RegisterEnemyLaneRouteTable{[""]=waveProperties.enemyLaneRouteList}
  end
  local currentWave=this.GetCurrentWaveName()
  TppEnemy.StartWave(currentWave,true,unkT2)
end
function this.StartNextWave()
  if not mvars.mis_waveIndex then
    return
  end
  if not mvars.mis_waveList then
    return
  end
  local waveIndex=mvars.mis_waveIndex+1
  if waveIndex>#mvars.mis_waveList then
    return
  end
  mvars.mis_waveIndex=waveIndex
  local currentWaveName=this.GetCurrentWaveName()
  TppEnemy.StartWave(currentWaveName,false)
  return currentWaveName
end
function this.StopWaveInterval()
  Mission.StopWaveInterval()
end
function this.OnClearDefenseGame()
  SsdSbm.AddKubInTemporalStorage()
end
function this.OnEndDefenseGame()
  local e=Gimmick.BreakAtTheBaseDefenseEnd()
  Gimmick.SetAllSwitchInvalid(false)
  SsdSbm.SetKubTemporalStorageMode(false)
end
function this.IsHostmigrationProcessing()
  return gvars.mis_processingHostmigration
end
function this.IsLastResultOfHostmigration()
  return gvars.mis_lastResultOfHostmigration
end
function this.WaitJoinedRoomIfAcceptedInvite()
  while(SsdMatching.IsBusy())do
    coroutine.yield()
  end
  InvitationManagerController.RequestJoinInviteRoom()
  while(SsdMatching.IsBusy())do
    coroutine.yield()
  end
end
function this.WaitCreateRoom()
  if not this.IsMatchingRoom(vars.missionCode)then
    return
  end
  if Mission.IsJoinedCoopRoom()then
    return
  end
  if gvars.ini_isTitleMode then
    return
  end
  while(SsdMatching.IsBusy()or TppException.IsProcessing())do
    coroutine.yield()
  end
  SsdMatching.RequestCreateJoinRoom()
  while(SsdMatching.IsBusy())do
    coroutine.yield()
  end
end
function this.InitializeCoopMission()
  if this.IsMultiPlayMission(vars.missionCode)and TppServerManager.IsLoginKonami()then
    this.WaitJoinedRoomIfAcceptedInvite()
    if not Mission.IsJoinedCoopRoom()then
      Mission.ResetCoopLobbyParams()
      this.WaitCreateRoom()
    end
  end
end
function this.IsInvitationStart()
  return gvars.title_isInvitationStart
end
function this.SetInvitationStart(bool)
  gvars.title_isInvitationStart=bool
end
function this._CreateMissionName(missionCode)
  local firstDigit=string.sub(tostring(missionCode),1,1)
  local missionPrefix
  if(firstDigit=="1")then
    missionPrefix="s"
  elseif(firstDigit=="2")then
    missionPrefix="e"
  elseif(firstDigit=="3")then
    missionPrefix="f"
  elseif(firstDigit=="4")then
    missionPrefix="h"
  elseif(firstDigit=="5")then
    missionPrefix="o"
  else
    if(Tpp.IsQARelease())and missionCode>=6e4 then
      return tostring(missionCode).."(for test)"
    end
    return nil
  end
  return missionPrefix..tostring(missionCode)
end
function this._PushReward(category,langId,rewardType)
  TppReward.Push{category=category,langId=langId,rewardType=rewardType}
end
function this._OnDeadCommon(deathTypeS32)
  if deathTypeS32==FallDeathS32 then
    mvars.mis_isGameOverReasonSuicide=true
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)
  else
    if deathTypeS32==SuicideS32 then
      mvars.mis_isGameOverReasonSuicide=true
    end
    this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)
  end
end
function this._OnEstablishMissionEnd()
  TppPlayer.EnableSwitchIcon()
end
function this._CreateSurviveCBox()
  if mvars.mis_abortWithoutSurviveBox then
    return
  end
  SsdSbm.CreateSurviveCbox()
end
function this.OnAfterMissionFinalize(unkP1,unkP2)
  if InvitationManagerController.IsGoingCoopMission()and(not this.IsMultiPlayMission(unkP2))then
    TppSave.VarRestoreOnContinueFromCheckPoint()
    vars.missionCode=this.GetCoopLobbyMissionCode()
    gvars.sav_skipRestoreToVars=true
  end
end
local n=nil
function this.OnPreLoad(currentMissionAfterChunkCheck,nextMissionAfterChunkCheck)
  local unkL1=false
  if gvars.mis_skipOnPreLoadForContinue then
  elseif this.IsMatchingRoom(nextMissionAfterChunkCheck)then
    local coopMissioncode=Mission.GetCoopMissionCode()
    if Mission.CanJoinSession()then
      if Mission.IsSortiedCoopMission()and this.IsCoopMission(coopMissioncode)then
        vars.missionCode=coopMissioncode
        vars.locationCode=TppDefine.LOCATION_ID[TppPackList.GetLocationNameFormMissionCode(coopMissioncode)]
        gvars.sav_skipRestoreToVars=true
        unkL1=true
      end
    else
      this.DisconnectMatching(true)
      TppException.OnFailedJoinSession()
      if not Mission.CanSortieMission()then
        Mission.OpenPopupSortieReadyFailed()
      end
    end
  end
  gvars.mis_chunkingCheckOnPreLoad=true
  gvars.mis_needLoadMissionAfterChunkCheck=true
  gvars.mis_nextMissionAfterChunkCheck=nextMissionAfterChunkCheck
  gvars.mis_currentMissionAfterChunkCheck=currentMissionAfterChunkCheck
end
function this.LoadLocation(unkP1,unkP2,unkP3)
  local locationName=TppPackList.GetLocationNameFormMissionCode(unkP2)
  local locationName2=TppPackList.GetLocationNameFormMissionCode(unkP1)
  if(unkP2==10010)then
    locationName=TppLocation.GetLocationName()
  end
  if this.IsMatchingRoom(unkP2)and(unkP3)then
    locationName=TppLocation.GetLocationName()
  end
  if this.IsAvatarEditMission(unkP2)then
    locationName=TppLocation.GetLocationName()
  end
  local locationCode=TppDefine.LOCATION_ID[locationName]
  local packagePath=""
  local packagePathSub=""
  if locationCode==TppDefine.LOCATION_ID.SSD_AFGH or locationCode==TppDefine.LOCATION_ID.AFGH then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_afgh.fpk"
    if not this.IsMultiPlayMission(unkP2)then
      packagePathSub="/Assets/ssd/pack/gimmick/common/gimmick_main_base.fpk"
    end
  elseif locationCode==TppDefine.LOCATION_ID.MAFR then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_mafr.fpk"
  elseif locationCode==TppDefine.LOCATION_ID.SBRI then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_sbri.fpk"
  elseif locationCode==TppDefine.LOCATION_ID.SPFC then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_spfc.fpk"
  elseif locationCode==TppDefine.LOCATION_ID.SSAV then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_ssav.fpk"
  elseif locationCode==TppDefine.LOCATION_ID.INIT then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_init.fpk"
  elseif locationCode==TppDefine.LOCATION_ID.AFTR then
    packagePath="/Assets/ssd/pack/gimmick/common/gimmick_main_aftr.fpk"
  end
  TppGimmickBlockController.Setup{
    packagePath=packagePath,
    packagePathSub=packagePathSub,
    totalSize=(1024*1024)*57,
    unitSize0=1024*18+512,
    unitCount0=768,
    unitCountPart0=192,
    unitSize1=1024*24,
    unitCount1=128,
    unitCountPart1=64,
    unitSize2=1024*34,
    unitCount2=64,
    unitCountPart2=0
  }
  Mission.LoadLocation()
end
function this.GoToCoopLobby()
  this.EnableInGameFlag()GameOverMenuSystem.RequestForceClose()
  local lobbyMissionCode=this.GetCoopLobbyMissionCode()
  if lobbyMissionCode then
    TppDemo.EnableNpc()
    if InvitationManagerController.IsGoingCoopMission()then
      local loadInfo={}
      loadInfo.isNeedUpdateBaseManagement=false
      this.ContinueFromCheckPoint(loadInfo)
    else
      mvars.mis_nextMissionCodeForAbort=lobbyMissionCode
      mvars.mis_abortWithSave=false
      this.ExecuteMissionAbort()
    end
  end
end
function this.GoToCoopLobbyWithSave()
  this.UpdateCheckPointAtCurrentPosition()
  if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
    this.GoToCoopLobby(false)
  else
    local GoToCoopLobbyCallBack=function()
      this.GoToCoopLobby(false)
    end
    TppSave.AddServerSaveCallbackFunc(GoToCoopLobbyCallBack)
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"GoToCoopLobbyWait",TppUI.FADE_PRIORITY.SYSTEM)
  end
end
function this.GoToAvatarEditWithSave()
  this.UpdateCheckPointAtCurrentPosition()
  local avatarMissionCode=this.GetAvaterMissionCode()
  if mvars.mis_skipServerSave or mvars.fms_skipServerSave then
    this.AbortMission{nextMissionId=avatarMissionCode}
  else
    local AbortMissionCallback=function()
      this.AbortMission{nextMissionId=avatarMissionCode}
    end
    TppSave.AddServerSaveCallbackFunc(AbortMissionCallback)
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"GoToAvatarEditWait",TppUI.FADE_PRIORITY.SYSTEM)
  end
end
function this.IsFromAvatarRoom()
  return gvars.mis_isFromAvatarRoom
end
function this.SetIsFromAvatarRoom(isFromAvatarRoom)
  gvars.mis_isFromAvatarRoom=isFromAvatarRoom
end
return this
