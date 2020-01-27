-- DOBUILD: 1
-- ssd TppMission.lua
local this={}
local StrCode32=InfCore.StrCode32--tex was Fox.StrCode32
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
local missionClearCodeNone=0
local maxObjective=64
local unkM4=1
local unkM3=0
local dayInSeconds=(24*60)*60
local unkM1=2
local MAX_32BIT_UINT=TppDefine.MAX_32BIT_UINT
local function RegistMissionTimerPlayRecord()
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
function this.UpdateObjective(objectiveInfo)
  if not mvars.mis_missionObjectiveDefine then
    return
  end
  if mvars.mis_objectiveSetting then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
  local radio=objectiveInfo.radio
  local radioSecond=objectiveInfo.radioSecond
  local options=objectiveInfo.options
  mvars.mis_objectiveSetting=objectiveInfo.objectives
  mvars.mis_updateObjectiveRadioGroupName=nil
  if not IsTypeTable(mvars.mis_objectiveSetting)then
    return
  end
  local doUpdate=false
  for unkI1,unkI2 in pairs(mvars.mis_objectiveSetting)do
    local isEnableAnyMissionObjective=not this.IsEnableMissionObjective(unkI2)
    if isEnableAnyMissionObjective then
      isEnableAnyMissionObjective=not this.IsEnableAnyParentMissionObjective(unkI2)
    end
    if isEnableAnyMissionObjective then
      doUpdate=true
      break
    end
  end
  if IsTypeTable(radio)then
    if doUpdate then
      mvars.mis_updateObjectiveRadioGroupName=TppRadio.GetRadioNameAndRadioIDs(radio.radioGroups)
      local objectiveRadioOption=this.GetObjectiveRadioOption(radio)
      TppRadio.Play(radio.radioGroups,objectiveRadioOption)
    end
  end
  if IsTypeTable(radioSecond)then
    if doUpdate then
      local objectiveRadioOption=this.GetObjectiveRadioOption(radioSecond)
      objectiveRadioOption.isEnqueue=true
      TppRadio.Play(radioSecond.radioGroups,objectiveRadioOption)
    end
  end
  if not IsTypeTable(radio)then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
function this.UpdateCheckPoint(checkPointInfo)
  TppCheckPoint.Update(checkPointInfo)
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
function this.IsMatchStartLocation(missionCode)
  local locationName=TppPackList.GetLocationNameFormMissionCode(missionCode)
  if TppLocation.IsAfghan()then
    local locationCode=TppDefine.LOCATION_ID[locationName]
    if locationCode~=TppDefine.LOCATION_ID.AFGH and locationCode~=TppDefine.LOCATION_ID.SSD_AFGH then
      return false
    end
  elseif TppLocation.IsMiddleAfrica()then
    if TppDefine.LOCATION_ID[locationName]~=TppDefine.LOCATION_ID.MAFR then
      return false
    end
  elseif TppLocation.IsMotherBase()then
    if TppDefine.LOCATION_ID[locationName]~=TppDefine.LOCATION_ID.MTBS then
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
function this.AcceptMission(missionCode)
  this.SetNextMissionCodeForMissionClear(missionCode)
end
function this.AcceptMissionOnFreeMission(missionCode,orderBoxBlockList,svarSet)
  local isMatchStartLocation=this.IsMatchStartLocation(missionCode)
  if not isMatchStartLocation then
    return
  end
  local noOrderBoxMissionEnum=SsdMissionList.NO_ORDER_BOX_MISSION_ENUM[tostring(missionCode)]
  if noOrderBoxMissionEnum then
    this.ReserveMissionClear{nextMissionId=missionCode,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
    return
  end
  local normalMissionCode=missionCode
  if this.IsHardMission(normalMissionCode)then
    normalMissionCode=this.GetNormalMissionCodeFromHardMission(normalMissionCode)
  end
  local orderBoxBlock=orderBoxBlockList[normalMissionCode]
  if orderBoxBlock==nil then
    return
  end
  if not this.IsSysMissionId(missionCode)then
    MissionListMenuSystem.SetCurrentMissionCode(missionCode)
  end
  svars[svarSet]=missionCode
  TppScriptBlock.Load("orderBoxBlock",normalMissionCode,true)
  return true
end
function this.Reload(loadInfo)
  local isNoFade,missionPackLabelName,locationCode,OnEndFadeOut,showLoadingTips
  if loadInfo then
    isNoFade=loadInfo.isNoFade
    missionPackLabelName=loadInfo.missionPackLabelName
    locationCode=loadInfo.locationCode
    showLoadingTips=loadInfo.showLoadingTips
    mvars.mis_nextLayoutCode=loadInfo.layoutCode
    mvars.mis_nextClusterId=loadInfo.clusterId
    OnEndFadeOut=loadInfo.OnEndFadeOut
  end
  if showLoadingTips~=nil then
    mvars.mis_showLoadingTipsOnReload=showLoadingTips
  else
    mvars.mis_showLoadingTipsOnReload=true
  end
  if missionPackLabelName then
    mvars.mis_missionPackLabelName=missionPackLabelName
  end
  if locationCode then
    mvars.mis_nextLocationCode=locationCode
  end
  if OnEndFadeOut and IsTypeFunc(OnEndFadeOut)then
    mvars.mis_reloadOnEndFadeOut=OnEndFadeOut
  else
    mvars.mis_reloadOnEndFadeOut=nil
  end
  gvars.mis_tempSequenceNumberForReload=svars.seq_sequence
  if isNoFade then
    this.ExecuteReload()
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ReloadFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
  end
end
function this.RestartMission(loadInfo)
  local isNoFade
  local isReturnToMission
  if loadInfo then
    isNoFade=loadInfo.isNoFade
    isReturnToMission=loadInfo.isReturnToMission
  end
  TppMain.EnablePause()
  if isReturnToMission then
    mvars.mis_isReturnToMission=true
  end
  if isNoFade then
    this.ExecuteRestartMission(mvars.mis_isReturnToMission)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"RestartMissionFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ExecuteRestartMission(isReturnToMission)
  this.SafeStopSettingOnMissionReload()
  TppQuest.OnMissionGameEnd()
  SsdFlagMission.OnMissionGameEnd()
  SsdBaseDefense.OnMissionGameEnd()
  TppPlayer.ResetInitialPosition()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)
  if not isReturnToMission then
    this.VarResetOnNewMission()
  end
  local missionCallbackReturn
  if isReturnToMission then
    missionCallbackReturn=this.ExecuteOnReturnToMissionCallback()
  end
  local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
  if locationName then
    local locationCode=TppDefine.LOCATION_ID[locationName]
    if locationCode then
      vars.locationCode=locationCode
    end
  end
  local currentMissionCode=nil
  if isReturnToMission then
    currentMissionCode=vars.missionCode
    vars.missionCode=this.GetFreeMissionCode()
  end
  TppSave.VarSave()
  if mvars.mis_needSaveConfigOnNewMission then
    TppSave.VarSaveConfig()
  end
  local DoLoad=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    local n={force=true}
    this.RequestLoad(vars.missionCode,currentMissionCode,n)
  end
  if missionCallbackReturn then
    this.ShowAnnounceLogOnFadeOut(DoLoad)
  else
    DoLoad()
  end
end
function this.ContinueFromCheckPoint(loadInfo)
  local isNoFade
  local isReturnToMission
  local isNeedUpdateBaseManagement
  if loadInfo then
    isNoFade=loadInfo.isNoFade
    isReturnToMission=loadInfo.isReturnToMission
    isNeedUpdateBaseManagement=loadInfo.isNeedUpdateBaseManagement
  end
  TppMain.EnablePause()
  if isReturnToMission then
    mvars.mis_isReturnToMission=true
  end
  if isNeedUpdateBaseManagement then
    mvars.isNeedUpdateBaseManagement=true
  end
  if isNoFade then
    this.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission,mvars.isNeedUpdateBaseManagement)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ContinueFromCheckPointFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ReturnToMission(_loadInfo)
  local loadInfo=_loadInfo or{}
  loadInfo.isReturnToMission=true
  this.DisableInGameFlag()
  this.RestartMission(loadInfo)
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
function this.ExecuteContinueFromCheckPoint(unkP1,unkP2,doMissionCallback,unkP4)
  TppQuest.OnMissionGameEnd()
  SsdFlagMission.OnMissionGameEnd()
  SsdBaseDefense.OnMissionGameEnd()
  TppWeather.OnEndMissionPrepareFunction()
  this.SafeStopSettingOnMissionReload()
  this._OnEstablishMissionEnd()
  TppUI.PreloadLoadingTips(0)
  local currentMissionCode=vars.missionCode
  this.IncrementRetryCount()
  if TppSystemUtility.GetCurrentGameMode()=="TPP"then
    TppEnemy.StoreSVars(true)
  end
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT)
  TppPlayer.StorePlayerDecoyInfos()
  TppRadioCommand.StoreRadioState()
  local callbackResult
  if doMissionCallback then
    callbackResult=this.ExecuteOnReturnToMissionCallback()
  end
  if Tpp.IsEditorNoLogin()then
    TppSave.VarSave()
    TppSave.SaveGameData(vars.missionCode,nil,nil,true)
    local EditorServerSaveFinishCallback=function()
      TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
      SsdBuilding.SetLevel{level=0}
      this.RequestLoad(vars.missionCode,currentMissionCode)
    end
    if callbackResult then
      TppSave.LoadFromServer()
      this.ShowAnnounceLogOnFadeOut(EditorServerSaveFinishCallback)
    else
      gvars.sav_needCheckPointSaveOnMissionStart=true
      TppSave.LoadFromServer(EditorServerSaveFinishCallback)
    end
    return
  end
  local initialSettings={}
  local IntialStartPos=function()
    initialSettings={}
    initialSettings.sav_continueForOutOfBaseArea=gvars.sav_continueForOutOfBaseArea
    initialSettings.mis_gameoverCount=gvars.mis_gameoverCount
    initialSettings.ply_startPosX=gvars.ply_startPosTempForBaseDefense[0]
    initialSettings.ply_startPosY=gvars.ply_startPosTempForBaseDefense[1]
    initialSettings.ply_startPosZ=gvars.ply_startPosTempForBaseDefense[2]
    initialSettings.ply_startRotY=gvars.ply_startPosTempForBaseDefense[3]
  end
  local InitialStartPosBaseDefense=function()
    if not IsTypeTable(initialSettings)then
      return
    end
    gvars.sav_continueForOutOfBaseArea=initialSettings.sav_continueForOutOfBaseArea
    gvars.mis_gameoverCount=initialSettings.mis_gameoverCount
    gvars.ply_startPosTempForBaseDefense[0]=initialSettings.ply_startPosX
    gvars.ply_startPosTempForBaseDefense[1]=initialSettings.ply_startPosY
    gvars.ply_startPosTempForBaseDefense[2]=initialSettings.ply_startPosZ
    gvars.ply_startPosTempForBaseDefense[3]=initialSettings.ply_startRotY
    initialSettings={}
  end
  local MissionFinalizer=function()
    local currentStorySequence=TppStory.GetCurrentStorySequence()
    IntialStartPos()
    TppVarInit.InitializeOnNewGame()
    TppScriptVars.InitOnTitle()
    Player.ResetVarsOnMissionStart()
    TppSave.ReserveVarRestoreForContinue()
    InitialStartPosBaseDefense()
    if not gvars.mis_isAbandonForDisconnect then--RETAILPATCH: 1.0.14 added check
      gvars.mis_skipOnPreLoadForContinue=true
    end
    gvars.sav_needCheckPointSaveOnMissionStart=false
    gvars.mis_skipUpdateBaseManagement=true
    gvars.str_storySequence=Mission.GetServerStorySequence()
    if not gvars.str_storySequence or gvars.str_storySequence==0 then
      gvars.str_storySequence=currentStorySequence
    end
    if unkP4 then
      gvars.mis_skipUpdateBaseManagement=false
    end
    Mission.InitializeDlcMission()
  end
  local ServerSaveFinishCallback=function()
    Mission.AddFinalizer(MissionFinalizer)
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    local missionCode,locationCode=Mission.GetServerMissionInfo()
    if missionCode==TppDefine.MISSION_CODE_NONE then
      missionCode=TppDefine.SYS_MISSION_ID.TITLE
      locationCode=TppDefine.LOCATION_ID.INIT
    elseif locationCode==0 then
      locationCode=TppDefine.LOCATION_ID[TppPackList.GetLocationNameFormMissionCode(missionCode)]
    end
    vars.missionCode=missionCode
    vars.locationCode=locationCode
    this.RequestLoad(missionCode,nil,{force=true})
  end
  TppSave.LoadFromServer(ServerSaveFinishCallback)
end
function this.IncrementRetryCount()
  PlayRecord.RegistPlayRecord"MISSION_RETRY"
  Tpp.IncrementPlayData"totalRetryCount"
  TppSequence.IncrementContinueCount()
end
function this.ExecuteOnReturnToMissionCallback()
  local OnReturnToMission
  if this.systemCallbacks and this.systemCallbacks.OnReturnToMission then
    OnReturnToMission=this.systemCallbacks.OnReturnToMission
  end
  if OnReturnToMission then
    TppMain.DisablePause()
    Player.SetPause()
    TppUiStatusManager.ClearStatus"AnnounceLog"
    OnReturnToMission()
    TppTerminal.AddStaffsFromTempBuffer()
    TppSave.VarSave()
    TppSave.SaveGameData(nil,nil,nil,true)
  end
  return OnReturnToMission
end
function this.CanAbortMission()
  if not this.CheckMissionState(isExecMissionClear,true)then--RETAILBUG: isExecMissionClear undefined
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
function this.AbortMission(abortInfo)
  InfMain.AbortMissionTop(abortInfo)--tex
  local isNoFade
  local isNoSave
  local isTitleMode
  local isExecMissionClear
  local isContinueCurrentPos
  local emergencyMissionId
  local nextMissionId
  local nextLayoutCode
  local nextClusterId
  local nextMissionStartRoute
  local isAlreadyGameOver
  local delayTime,fadeDelayTime,fadeSpeed=0,0,TppUI.FADE_SPEED.FADE_NORMALSPEED
  local presentationFunction
  local playRadio
  local isNoSurviveBox
  local isReplayMission=false--RETAILPATCH: 1.0.9.0
  if IsTypeTable(abortInfo)then
    --RETAILPATCH: 1.0.9.0>
    if abortInfo.isReplayMission then
      isReplayMission=abortInfo.isReplayMission
    end
    --<
    isNoFade=abortInfo.isNoFade
    emergencyMissionId=abortInfo.emergencyMissionId
    nextMissionId=abortInfo.nextMissionId
    nextLayoutCode=abortInfo.nextLayoutCode
    nextClusterId=abortInfo.nextClusterId
    nextMissionStartRoute=abortInfo.nextMissionStartRoute
    isExecMissionClear=abortInfo.isExecMissionClear
    isNoSave=abortInfo.isNoSave
    isAlreadyGameOver=abortInfo.isAlreadyGameOver
    isContinueCurrentPos=abortInfo.isContinueCurrentPos
    if abortInfo.delayTime then
      delayTime=abortInfo.delayTime
    end
    if abortInfo.fadeDelayTime then
      fadeDelayTime=abortInfo.fadeDelayTime
    end
    if abortInfo.fadeSpeed then
      fadeSpeed=abortInfo.fadeSpeed
    end
    presentationFunction=abortInfo.presentationFunction
    isTitleMode=abortInfo.isTitleMode
    playRadio=abortInfo.playRadio
    if isTitleMode then
      nextMissionId=TppDefine.SYS_MISSION_ID.TITLE
    elseif mvars.mis_reservedNextMissionCodeForAbort then
      nextMissionId=mvars.mis_reservedNextMissionCodeForAbort
    end
    if abortInfo.isNoSurviveBox then
      isNoSurviveBox=true
    end
  end
  --RETAILPATCH: 1.0.9.0>
  if isReplayMission then
    mvars.mis_abortForReplayMission=isReplayMission
    if mvars.mis_missionAbortLoadingOption==nil then
      mvars.mis_missionAbortLoadingOption={}
    end
    mvars.mis_missionAbortLoadingOption.force=true
  else
    mvars.mis_abortForReplayMission=nil
  end
  --<
  if not this.CanAbortMission()then
    return
  end
  if delayTime then
    mvars.mis_missionAbortDelayTime=delayTime
  end
  if fadeDelayTime then
    mvars.mis_missionAbortFadeDelayTime=fadeDelayTime
  end
  if fadeSpeed then
    mvars.mis_missionAbortFadeSpeed=fadeSpeed
  end
  mvars.mis_abortPresentationFunction=presentationFunction
  if isTitleMode then
    mvars.mis_abortIsTitleMode=isTitleMode
  end
  mvars.mis_abortWithPlayRadio=playRadio
  mvars.mis_emergencyMissionCode=emergencyMissionId
  mvars.mis_nextMissionCodeForAbort=nextMissionId
  mvars.mis_nextLayoutCodeForAbort=nextLayoutCode
  mvars.mis_nextClusterIdForAbort=nextClusterId
  mvars.mis_nextMissionStartRouteForAbort=nextMissionStartRoute
  if isNoSave then
    mvars.mis_abortWithSave=false
  else
    mvars.mis_abortWithSave=true
  end
  if isNoFade then
    mvars.mis_abortWithFade=false
  else
    mvars.mis_abortWithFade=true
  end
  if isContinueCurrentPos then
    mvars.mis_isResetMissionPosition=false
  else
    mvars.mis_isResetMissionPosition=true
  end
  if isNoSurviveBox then
    mvars.mis_abortWithoutSurviveBox=true
  end
  if not isAlreadyGameOver then
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
  local missionCode=vars.missionCode
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
  local isFreeMission=this.IsFreeMission(missionCode)
  local nextIsFreeMission=this.IsFreeMission(mvars.mis_nextMissionCodeForAbort)
  local isResetMissionPosition=mvars.mis_isResetMissionPosition
  vars.missionCode=mvars.mis_nextMissionCodeForAbort
  mvars.mis_abortCurrentMissionCode=missionCode
  local locationName=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
  if locationName then
    local locationCode=TppDefine.LOCATION_ID[locationName]
    if locationCode then
      vars.locationCode=locationCode
    end
  end
  TppCrew.FinishMission(missionCode)
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
    gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
    SsdSbm.StoreToSVars()
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
    TppGimmick.DecrementCollectionRepopCount()
    TppBuddyService.SetVarsMissionStart()
    if nextIsFreeMission then
      TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
    end
  else
    TppPlayer.ResetMissionStartPosition()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  end
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT,isFreeMission,nextIsFreeMission,isResetMissionPosition,mvars.mis_abortWithSave)
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
    local abortWithSave=false
    if mvars.mis_abortWithSave then
      abortWithSave=true
    end
    gvars.sav_needCheckPointSaveOnMissionStart=true
    TppSave.VarSave(missionCode,abortWithSave)
    TppSave.SaveGameData(missionCode,nil,nil,true,abortWithSave)
    if mvars.mis_needSaveConfigOnNewMission then
      TppSave.VarSaveConfig()
      TppSave.SaveConfigData(nil,nil,reserveNextMissionStart)--RETAILBUG: typo orphan
    end
  end
end
function this.LoadForMissionAbort()
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  this.RequestLoad(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)
end
function this.ReturnToTitle()
  --RETAILPATCH: 1.0.12>
  if gvars.exc_processingForDisconnect then
    return
  end
  --<
  local isAlreadyGameOver
  if this.IsMultiPlayMission(vars.missionCode)then
    this.DisconnectMatching(false)
    TppGameStatus.Reset("SimpleMissionController","S_IS_ONLINE")
    TppGameStatus.Reset("SimpleMissionController","S_IS_MULTIPLAY")
    isAlreadyGameOver=true
  end
  vars.invitationDisableRecieveFlag=1
  this.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.TITLE,isNoSave=true,isTitleMode=true,isAlreadyGameOver=isAlreadyGameOver}
end
function this.GameOverReturnToTitle()
  if IS_GC_2017_COOP then
    mvars.mis_missionAbortLoadingOption={showLoadingTips=true,waitOnLoadingTipsEnd=false}
  end
  --RETAILPATCH: 1.0.12
  if gvars.exc_processingForDisconnect then
    return
  end
  --<
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
function this.ReserveGameOver(gameOverType,gameOverRadio,isAborting)
  --tex>
  if gameOverType==TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA then
    if Ivars.disableOutOfBoundsChecks:Is(1) then
      return false
    end
  end
  if gameOverType~=TppDefine.GAME_OVER_TYPE.ABORT then
    if Ivars.disableGameOver:Is(1) then
      return false
    end
  end
  --<
  if svars.mis_isDefiniteMissionClear then
    return false
  end
  mvars.mis_isAborting=isAborting
  mvars.mis_isReserveGameOver=true
  svars.mis_isDefiniteGameOver=true
  if type(gameOverType)=="number"and gameOverType<TppDefine.GAME_OVER_TYPE.MAX then
    svars.mis_gameOverType=gameOverType
  end
  if type(gameOverRadio)=="number"and gameOverRadio<TppDefine.GAME_OVER_RADIO.MAX then
    svars.mis_gameOverRadio=gameOverRadio
  end
  if this.IsMultiPlayMission(vars.missionCode)then
    TppUI.PreloadLoadingTips(1)
  else
    TppUI.PreloadLoadingTips(0)
  end
  local missionCode=vars.missionCode
  if not this.IsMultiPlayMission(missionCode)and not this.IsInitMission(missionCode)then
    local gameOverType=svars.mis_gameOverType
    if gameOverType==TppDefine.GAME_OVER_TYPE.PLAYER_DEAD or gameOverType==TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD then--RETAILPATCH: 1.0.5.0 removed repeated comparison
      TppUI.SetDefaultGameOverMenu()
    else
      TppUI.SetGameOverMenu{GameOverMenuType.CONTINUE_FROM_CHECK_POINT}
    end
    if gameOverType~=TppDefine.GAME_OVER_TYPE.ABORT then
      this.IncrementGameOverCount()
    end
  else
    TppUI.SetDefaultGameOverMenu()
  end
  return true
end
function this.ReserveGameOverOnPlayerKillChild(gameId)
  if not mvars.mis_childGameObjectIdKilledPlayer then
    mvars.mis_childGameObjectIdKilledPlayer=gameId
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
function this.CanMissionClear(clearInfo)
  mvars.mis_needSetCanMissionClear=true
  if IsTypeTable(clearInfo)then
    if clearInfo.jingle then
      mvars.mis_canMissionClearNeedJingle=clearInfo.jingle
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
  local snd_bgmList=mvars.snd_bgmList
  if snd_bgmList and snd_bgmList.bgm_escape then
    mvars.mis_needSetEscapeBgm=true
  end
end
function this.SetMissionClearState(missionClearState)
  if gvars.mis_missionClearState<missionClearState then
    gvars.mis_missionClearState=missionClearState
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
function this.ReserveMissionClear(missionClearInfo)
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
  if missionClearInfo then
    if missionClearInfo.missionClearType then
      svars.mis_missionClearType=missionClearInfo.missionClearType
    end
    if missionClearInfo.nextMissionId then
      this.SetNextMissionCodeForMissionClear(missionClearInfo.nextMissionId)
    end
    if missionClearInfo.resetPlayerPos then
      mvars.mis_isResetMissionPosition=missionClearInfo.resetPlayerPos
    end
    if missionClearInfo.isLocationChangeWithFastTravel then
      mvars.mis_isLocationChangeWithFastTravel=missionClearInfo.isLocationChangeWithFastTravel
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
function this.MissionGameEnd(sequence)
  local delayTime=0
  local fadeDelayTime=0
  local fadeSpeed=TppUI.FADE_SPEED.FADE_NORMALSPEED
  if IsTypeTable(sequence)then
    delayTime=sequence.delayTime or 0
    fadeSpeed=sequence.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    fadeDelayTime=sequence.fadeDelayTime or 0
    if sequence.loadStartOnResult~=nil then
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=sequence.loadStartOnResult
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
  mvars.mis_missionGameEndDelayTime=delayTime
  this.ResetGameOverCount()
  this.FadeOutOnMissionGameEnd(fadeDelayTime,fadeSpeed,"MissionGameEndFadeOutFinish")
  PlayRecord.RegistPlayRecord"MISSION_CLEAR"
end
function this.FadeOutOnMissionGameEnd(fadeDelay,fadeSpeed,fadeId)
  if fadeDelay==0 then
    this._FadeOutOnMissionGameEnd(fadeSpeed,fadeId)
  else
    mvars.mis_missionGameEndFadeSpeed=fadeSpeed
    mvars.mis_missionGameEndFadeId=fadeId
    TimerStart("Timer_FadeOutOnMissionGameEndStart",fadeDelay)
  end
end
function this._FadeOutOnMissionGameEnd(fadeSpeed,fadeId)
  TppUI.FadeOut(fadeSpeed,fadeId,TppUI.FADE_PRIORITY.SYSTEM,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
end
function this.CheckGameOverDemo(gameOverType)
  if gameOverType>TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK then
    return false
  end
  if band(svars.mis_gameOverType,TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK)==gameOverType then
    return true
  else
    return false
  end
end
function this.ShowGameOverMenu(params)
  local delayTime
  if IsTypeTable(params)then
    if type(params.delayTime)=="number"then
      delayTime=params.delayTime
    end
  end
  if(Tpp.IsQARelease())then
    mvars.mis_isGameOverMenuShown=true
  end
  if delayTime and delayTime>0 then
    TimerStart("Timer_GameOverPresentation",delayTime)
  else
    this.ExecuteShowGameOverMenu()
  end
end
function this.ExecuteShowGameOverMenu()
  TppRadio.Stop(
  )GameOverMenuSystem.SetType(GameOverType.Normal)
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL then
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
function this.ShowAnnounceLogOnFadeOut(EndAnnounceLogFunc)
  if TppUiCommand.GetSuspendAnnounceLogNum()>0 then
    TppUiStatusManager.ClearStatus"AnnounceLog"mvars.mis_endAnnounceLogFunction=EndAnnounceLogFunc
  else
    EndAnnounceLogFunc()
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
  TppSoundDaemon.SetMute"Result"
  this.EnablePauseForShowResult()
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
function this.MissionFinalize(options)
  TppSoundDaemon.SetMute"Loading"
  local isNoFade,isExecGameOver,showLoadingTips,setMute
  if IsTypeTable(options)then
    isNoFade=options.isNoFade
    isExecGameOver=options.isExecGameOver
    showLoadingTips=options.showLoadingTips
    setMute=options.setMute
  end
  if showLoadingTips~=nil then
    mvars.mis_showLoadingTipsOnMissionFinalize=showLoadingTips
  else
    mvars.mis_showLoadingTipsOnMissionFinalize=true
  end
  if setMute then
    mvars.mis_setMuteOnMissionFinalize=setMute
  end
  if gvars.mis_nextMissionCodeForMissionClear~=missionClearCodeNone then
    local isStoryMission=this.IsStoryMission(vars.missionCode)
    local isNextStoryMission=this.IsStoryMission(gvars.mis_nextMissionCodeForMissionClear)
    if isStoryMission or isNextStoryMission then
      SsdMarker.UnregisterMarker{type="USER_001"}
    end
  end
  --RETAILPATCH: 1.0.9.0>
  if Mission.IsReplayMission()then
    local loadInfo={}
    loadInfo.isNeedUpdateBaseManagement=false
    this.ContinueFromCheckPoint(loadInfo)
    return
  end
  --<
  if isNoFade then
    this.ExecuteMissionFinalize()
  else
    if isExecGameOver then
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeAtGameOverFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
    else
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
    end
  end
end
function this.ExecuteMissionFinalize()
  InfCore.LogFlow("TppMission.ExecuteMissionFinalize "..vars.missionCode)--tex
  InfMain.ExecuteMissionFinalizeTop()--tex
  if not this.IsSysMissionId(vars.missionCode)then
    TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.MISSION_END,this.ExecuteMissionFinalizeAfterServerSave)
  else
    this.ExecuteMissionFinalizeAfterServerSave()
  end
end
function this.ExecuteMissionFinalizeAfterServerSave()
  SsdReplayMission.ClearReplayMissionSetting()--RETAILPATCH: 1.0.9.0
  local nextLocationName=TppPackList.GetLocationNameFormMissionCode(gvars.mis_nextMissionCodeForMissionClear)
  if nextLocationName then
    mvars.mis_nextLocationCode=TppDefine.LOCATION_ID[nextLocationName]
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
  local waitOnLoadingTipsEnd
  local currentMissionCode=vars.missionCode
  local currentLocationCode=vars.locationCode
  local isFreeMission,nextIsFreeMission,isResetMissionPosition,isLocationChangeWithFastTravel
  if gvars.mis_nextMissionCodeForMissionClear~=missionClearCodeNone then
    isFreeMission=this.IsFreeMission(vars.missionCode)
    nextIsFreeMission=this.IsFreeMission(gvars.mis_nextMissionCodeForMissionClear)
    isResetMissionPosition=mvars.mis_isResetMissionPosition
    isLocationChangeWithFastTravel=mvars.mis_isLocationChangeWithFastTravel
    vars.locationCode=mvars.mis_nextLocationCode
    vars.missionCode=gvars.mis_nextMissionCodeForMissionClear
  else
    Tpp.DEBUG_Fatal"Not defined next missionId!!"
    this.RestartMission()
    return
  end
  if nextIsFreeMission then
    TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
  end
  TppGimmick.DecrementCollectionRepopCount()
  Gimmick.StoreSaveDataPermanentGimmickForMissionClear()
  Gimmick.StoreSaveDataPermanentGimmickFromMissionAfterClear()
  if isFreeMission then
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
  end
  if nextIsFreeMission then
    vars.requestFlagsAboutEquip=255
  end
  TppEnemy.ClearDDParameter()
  if gvars.solface_groupNumber>=4294967295 then
    gvars.solface_groupNumber=0
  else
    gvars.solface_groupNumber=gvars.solface_groupNumber+1
  end
  gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
  SsdSbm.StoreToSVars()
  TppRadioCommand.StoreRadioState()
  local isLocationChange=(vars.locationCode~=currentLocationCode)
  TppClock.SaveMissionStartClock()
  TppWeather.SaveMissionStartWeather()
  TppBuddyService.SetVarsMissionStart()
  TppBuddyService.BuddyMissionInit()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE,isFreeMission,nextIsFreeMission,isResetMissionPosition,nil,isLocationChange,isLocationChangeWithFastTravel)
  TppWeather.OnEndMissionPrepareFunction()
  this.VarResetOnNewMission()
  local reserveNextMissionStartSave=true
  TppSave.VarSave(currentMissionCode,true)
  local saveGameData=false
  do--NMC I dont get this
    saveGameData=true
  end
  if saveGameData then
    TppSave.SaveGameData(currentMissionCode,nil,nil,reserveNextMissionStartSave,true)
  end
  if mvars.mis_needSaveConfigOnNewMission then
    TppSave.VarSaveConfig()
    TppSave.SaveConfigData(nil,nil,reserveNextMissionStartSave)
  end
  if TppRadio.playingBlackTelInfo then
    mvars.mis_showLoadingTipsOnMissionFinalize=false
  end
  SsdBlankMap.DisableDefenseMode()
  TppCrew.FinishMission(currentMissionCode)
  this.RequestLoad(vars.missionCode,currentMissionCode,{showLoadingTips=mvars.mis_showLoadingTipsOnMissionFinalize,waitOnLoadingTipsEnd=waitOnLoadingTipsEnd})
end
--tex REWORKED
local shortTypeToLong={
  s="story",
  e="extra",
  f="free",
  k="flag",
  d="defense",
}
function this.ParseMissionName(missionCodeName)
  local missionCode=string.sub(missionCodeName,2)
  missionCode=tonumber(missionCode)
  local missionTypeCode=string.sub(missionCodeName,1,1)
  local missionTypeCodeName=shortTypeToLong[missionTypeCode]
  return missionCode,missionTypeCodeName
end
--ORIG
--function this.ParseMissionName(missionCodeName)
--  local missionCode=string.sub(missionCodeName,2)
--  missionCode=tonumber(missionCode)
--  local missionTypeCode=string.sub(missionCodeName,1,1)
--  local missionTypeCodeName
--  if(missionTypeCode=="s")then
--    missionTypeCodeName="story"
--    elseif(missionTypeCode=="e")then
--    missionTypeCodeName="extra"
--    elseif(missionTypeCode=="f")then
--    missionTypeCodeName="free"
--    elseif(missionTypeCode=="k")then
--    missionTypeCodeName="flag"
--    elseif(missionTypeCode=="d")then
--    missionTypeCodeName="defense"
--    end
--  return missionCode,missionTypeCodeName
--end
function this.IsStoryMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==1 then
    return true
  else
    return false
  end
end
function this.IsFreeMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==3 then
    return true
  else
    return false
  end
end
function this.IsHardMission(missionCode)
  local n=math.floor(missionCode/1e3)
  local e=math.floor(missionCode/1e4)*10
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
function this.GetNormalMissionCodeFromHardMission(missionCode)
  return missionCode-1e3
end
function this.IsMatchingRoom(missionCode)
  if missionCode==TppDefine.SYS_MISSION_ID.TITLE then
    return true
  end
  local first2Digits=math.floor(missionCode/1e3)
  return first2Digits==21
end
function this.IsMultiPlayMission(missionCode)
  if missionCode==TppDefine.SYS_MISSION_ID.TITLE then
    return true
  end
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==2 then
    return true
  else
    return false
  end
end
function this.IsCoopMission(missionCode)
  return(not this.IsMatchingRoom(missionCode)and this.IsMultiPlayMission(missionCode))
end
function this.IsAvatarEditMission(missionCode)
  return(missionCode==TppDefine.SYS_MISSION_ID.AVATAR_EDIT)or(missionCode==TppDefine.SYS_MISSION_ID.MAFR_AVATAR_EDIT)
end
function this.IsInitMission(missionCode)
  return(missionCode==TppDefine.SYS_MISSION_ID.INIT or missionCode==TppDefine.SYS_MISSION_ID.TITLE)
end
function this.IsTitleMission(missionCode)
  return missionCode==TppDefine.SYS_MISSION_ID.TITLE
end
function this.IsEventMission(missionCode)
  if not this.IsCoopMission(missionCode)then
    return false
  end
  if missionCode>=22e3 then
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
function this.IsSysMissionId(missionCode)
  local e
  for i,_missionCode in pairs(TppDefine.SYS_MISSION_ID)do
    if missionCode==_missionCode then
      return true
    end
  end
  return false
end
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="Dead",func=this.OnPlayerDead,option={isExecGameOver=true}},
      {msg="AllDead",func=this.OnAllPlayersDead,option={isExecGameOver=true}},
      {msg="InFallDeathTrapLocal",func=this.OnPlayerFallDead,option={isExecGameOver=true}},
      {msg="Exit",sender="outerZone",
        func=function()
          mvars.mis_isOutsideOfMissionArea=true
        end,
        option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Enter",sender="outerZone",
        func=function()
          mvars.mis_isOutsideOfMissionArea=false
        end,
        option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Exit",sender="innerZone",
        func=function()
          if mvars.mis_fobDisableAlertMissionArea==true then
            return
          end
          mvars.mis_isAlertOutOfMissionArea=true
          if not this.CheckMissionClearOnOutOfMissionArea()then
            this.EnableAlertOutOfMissionArea()
          end
        end,
        option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Enter",sender="innerZone",
        func=function()
          mvars.mis_isAlertOutOfMissionArea=false
          this.DisableAlertOutOfMissionArea()
        end,
        option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Exit",sender="hotZone",
        func=function()
          mvars.mis_isOutsideOfHotZone=true
          this.ExitHotZone()
        end,
        option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Enter",sender="hotZone",
        func=function()
          mvars.mis_isOutsideOfHotZone=false
          if TppSequence.IsMissionPrepareFinished()then
            this.PlayCommonRadioOnInsideOfHotZone()
          end
        end,
        option={isExecMissionPrepare=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="OnInjury",
        func=function()
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOMMEND_CURE)
        end},
      {msg="PlayerFultoned",func=this.OnPlayerFultoned},
      {msg="WarpEnd",
        func=function()
          if mvars.mis_finishWarpToBaseCallBack then
            mvars.mis_finishWarpToBaseCallBack()
            mvars.mis_finishWarpToBaseCallBack=nil
          end
        end,
        option={isExecGameOver=true,isExecFastTravel=true}}
    },
    UI={
      {msg="EndTelopCast",
        func=function()
          if mvars.f30050_demoName=="NuclearEliminationCeremony"then
            return
          end
          TppUiStatusManager.ClearStatus"AnnounceLog"
        end},
      {msg="EndFadeOut",sender="MissionGameEndFadeOutFinish",func=this.OnMissionGameEndFadeOutFinish,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="MissionFinalizeFadeOutFinish",func=this.ExecuteMissionFinalize,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="MissionFinalizeAtGameOverFadeOutFinish",func=this.ExecuteMissionFinalize,option={isExecGameOver=true,isExecMissionClear=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="RestartMissionFadeOutFinish",
        func=function()
          this.ExecuteRestartMission(mvars.mis_isReturnToMission)
        end,
        option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="ContinueFromCheckPointFadeOutFinish",
        func=function()
          this.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission,mvars.isNeedUpdateBaseManagement)
        end,
        option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="ReloadFadeOutFinish",
        func=function()
          if mvars.mis_reloadOnEndFadeOut then
            mvars.mis_reloadOnEndFadeOut()
          end
          this.ExecuteReload()
        end,
        option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="AbortMissionFadeOutFinish",
        func=function()
          if mvars.mis_missionAbortDelayTime>0 then
            TimerStart("Timer_MissionAbort",mvars.mis_missionAbortDelayTime)
          else
            this.OnEndFadeOutMissionAbort()
          end
        end,
        option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="GameOverReturnToBaseFadeOut",func=this.ExecuteGameOverReturnToBase,option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="EndFadeOut",sender="ReturnToTitleWithSave",func=this.ExecuteReturnToTitleWithSave,option={isExecMissionClear=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="EndFadeIn",sender="FadeInOnGameStart",
        func=function()
          this.ShowAnnounceLogOnGameStart()
        end},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",
        func=function()
          this.ShowAnnounceLogOnGameStart()
        end},
      {msg="GameOverOpen",func=TppMain.DisableGameStatusOnGameOverMenu,option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="GameOverContinueFromCheckPoint",func=this.ExecuteContinueFromCheckPoint,option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="GameOverReturnToBase",func=this.GameOverReturnToBase,option={isExecGameOver=true,isExecMissionClear=true,isExecFastTravel=true}},
      {msg="GameOverMenuAutomaticallyClosed",
        func=function()
          if IS_GC_2017_COOP then
            local n=mvars.mis_isReserveGameOver or svars.mis_isDefiniteGameOver
            if n then
              this.GameOverReturnToTitle()
            end
            return
          end
          this.ReturnToMatchingRoom()
        end,
        option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="PauseMenuCheckpoint",func=this.ContinueFromCheckPoint},
      {msg="PauseMenuAbortMission",func=this.AbortMissionByMenu},
      {msg="PauseMenuAbortMissionGoToAcc",func=this.AbortMissionByMenu},
      {msg="PauseMenuFinishFobManualPlaecementMode",func=this.AbortMissionByMenu},
      {msg="PauseMenuRestart",func=this.RestartMission},
      {msg="PauseMenuReturnToTitle",
        func=function()
          this.ReturnToTitle()
          vars.isAbandonFromUser=1
        end},
      {msg="PauseMenuReturnToMission",
        func=function()
          this.ReturnToMission{withServerPenalty=true}
        end},
      {msg="PauseMenuReturnToBase",func=this.ReturnToBaseByMenu},
      {msg="RequestPlayRecordClearInfo",func=this.SetPlayRecordClearInfo},
      {msg="AiPodMenuCancelMissionSelected",
        func=function()
          this.AbortMissionByMenu{isNoSurviveBox=true}
        end},
      {msg="EndMissionTelopDisplay",
        func=function()
          if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
            this.MissionFinalize{isNoFade=true,setMute="Result"}
          end
        end,
        option={isExecMissionClear=true,isExecGameOver=true,isExecFastTravel=true}},
      {msg="EndAnnounceLog",
        func=function()
          if mvars.mis_endAnnounceLogFunction then
            mvars.mis_endAnnounceLogFunction()
            mvars.mis_endAnnounceLogFunction=nil
          end
        end,
        option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="EndResultBlockLoad",func=this.OnEndResultBlockLoad,option={isExecMissionClear=true,isExecGameOver=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="StoryMissionResultClosed",
        func=function()
          this.ExecRewardProcess()
        end},
      {msg="BlackRadioClosed",func=function(n)
        if not IsTypeString(mvars.mis_blackRadioSetting)or n~=StrCode32(mvars.mis_blackRadioSetting)then
          return
        end
        mvars.mis_blackRadioSetting=nil
        TppSoundDaemon.SetKeepBlackRadioEnable(false)
        this.ExecRewardProcess()
      end},
      {msg="ReleaseAnnouncePopupPushEnd",
        func=function()
          if not mvars.mis_releaseAnnounceSetting then
            return
          end
          mvars.mis_releaseAnnounceSetting=nil
          this.ExecRewardProcess()
        end},
      {msg="PresetRadioEditMenuClosed",func=TppSave.SaveEditData},
      {msg="CommunicationMarkerEditMenuClosed",func=TppSave.SaveEditData},
      {msg="GestureEditMenuClosed",func=TppSave.SaveEditData},
      {msg="LastOrderMenuTimeChanged",func=TppSave.SaveOnlyLocalEditData},--RETAILPATCH: 1.0.8.0
      {msg="AbandonFromPauseMenu",
        func=function()
          vars.isAbandonFromUser=1
          if this.IsCoopMission(vars.missionCode)then
            return
          end
          this.AbandonMission()
        end},
      {msg="AiPodMenuMoveToAssemblyPointSelected",func=function(n,n)
        if not this.IsMultiPlayMission(vars.missionCode)then
          this.GoToCoopLobbyWithSave()
        end
      end},
      {msg="PopupClose",sender=TppDefine.ERROR_ID.SESSION_ABANDON,func=function()
        this.AbandonMission{needRestore=true}--RETAILPATCH: 1.0.12 added needrestore
      end,
      option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="AiPodMenuReturnToTitleWithSaveSelected",func=this.ReturnToTitleWithSave}},
    Radio={
      {msg="Finish",func=this.OnFinishUpdateObjectiveRadio}
    },
    Timer={
      {msg="Finish",sender="Timer_OutsideOfHotZoneCount",func=this.OutsideOfHotZoneCount,nil},
      {msg="Finish",sender="Timer_OnEndReturnToTile",func=this.RestartMission,option={isExecGameOver=true,isExecFastTravel=true},nil},
      {msg="Finish",sender="Timer_GameOverPresentation",func=this.ExecuteShowGameOverMenu,option={isExecGameOver=true,isExecFastTravel=true},nil},
      {msg="Finish",sender="Timer_MissionGameEndStart",func=this.OnMissionGameEndFadeOutFinish2nd,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Finish",sender="Timer_MissionGameEndStart2nd",func=this.ShowMissionGameEndAnnounceLog,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Finish",sender="Timer_FadeOutOnMissionGameEndStart",
        func=function()
          this._FadeOutOnMissionGameEnd(mvars.mis_missionGameEndFadeSpeed,mvars.mis_missionGameEndFadeId)
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecFastTravel=true}},
      {msg="Finish",sender="Timer_StartMissionAbortFadeOut",func=this.FadeOutOnMissionAbort,option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="Finish",sender="Timer_MissionAbort",func=this.OnEndFadeOutMissionAbort,option={isExecGameOver=true,isExecFastTravel=true}},
      {msg="Finish",sender=Timer_outsideOfInnerZoneStr,func=function()
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
      end},
      {msg="Finish",sender="Timer_UpdateCheckPoint",
        func=function()
          TppStory.UpdateStorySequence{updateTiming="OnUpdateCheckPoint",isInGame=true}
        end},
      {msg="Finish",sender="Timer_WaitStartMigration",
        func=function()
          this.AbandonMission{needRestore=true}--RETAILPATCH: 1.0.12 added needRestore
        end},
      {msg="Finish",sender="Timer_WaitFinishMigration",
        func=function()
          this.AbandonMission{needRestore=true}--RETAILPATCH: 1.0.12 added needRestore
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="Finish",sender="Timer_SessionAbandon",
        func=function()
          this.AbandonMission{needRestore=true}--RETAILPATCH: 1.0.12 added needRestore
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="Finish",sender="Timer_WaitSavingForReturnToTitle",func=this.ExecuteReturnToTitleWithSave,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}
    },
    GameObject={
      {msg="ChangePhase",func=function(i,n)
        if mvars.mis_isExecuteGameOverOnDiscoveryNotice then
          if n==TppGameObject.PHASE_ALERT then
            this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ON_DISCOVERY,TppDefine.GAME_OVER_RADIO.OTHERS)
          end
        end
      end},
      {msg="DisableTranslate",func=function(e)
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
      end},
      {msg="FinishWaveInterval",
        func=function()
          Mission.EndWaveResult()
        end},
      {msg="GameOverConfirm",func=this.OnAllPlayersDead,option={isExecGameOver=true,isExecFastTravel=true}}},
    MotherBaseManagement={
      {msg="CompletedPlatform",func=function(e,e,e)
        TppStory.UpdateStorySequence{updateTiming="OnCompletedPlatform",isInGame=true}
      end},
      {msg="RequestSaveMbManagement",
        func=function()
          if((TppSave.IsForbidSave()or(vars.missionCode==10030))or(vars.missionCode==10115))or(not this.CheckMissionState())then
            TppMotherBaseManagement.SetRequestSaveResultFailure()
            return
          end
          TppSave.SaveOnlyMbManagement(TppSave.ReserveNoticeOfMbSaveResult)
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="RequestSavePersonal",
        func=function()
          TppSave.CheckAndSavePersonalData()
        end}
    },
    Trap={
      {msg="Enter",sender="trap_mission_failed_area",
        func=function()
          this.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)
        end,
        option={isExecFastTravel=true}}},
    Network={
      {msg="StartHostMigration",
        func=function()
          if IsTimerActive"Timer_WaitStartMigration"then
            TimerStop"Timer_WaitStartMigration"
          end
          TimerStart("Timer_WaitFinishMigration",120)
          gvars.mis_processingHostmigration=true
          gvars.mis_lastResultOfHostmigration=true
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="FinishHostMigration",func=function(e)
        gvars.mis_processingHostmigration=false
        if IsTimerActive"Timer_WaitFinishMigration"then
          TimerStop"Timer_WaitFinishMigration"
        end
      end,
      option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="FailedHostMigration",
        func=function()
          gvars.mis_lastResultOfHostmigration=false
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}},
      {msg="AcceptedInvate",
        func=function()
          if this.IsMultiPlayMission(vars.missionCode)then
            this.AbandonMission{needRestore=true}--RETAILPATCH: 1.0.12 added needRestore
          elseif this.IsAvatarEditMission(vars.missionCode)then
          else
            this.GoToCoopLobby()
          end
        end,
        option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true,isExecFastTravel=true}}
    }
  }
end
function this.MessagesWhileLoading()
  return Tpp.StrCode32Table{
    UI={
      {msg="StoryMissionResultClosed",
        func=function()
          this.ExecRewardProcess()
        end},
      {msg="BlackRadioClosed",
        func=function(n)
          TppPause.UnregisterPause"BlackRadio"
          if not IsTypeString(mvars.mis_blackRadioSetting)or n~=StrCode32(mvars.mis_blackRadioSetting)then
            return
          end
          mvars.mis_blackRadioSetting=nil
          TppSoundDaemon.SetKeepBlackRadioEnable(false)
          this.ExecRewardProcess()
        end},
      {msg="ReleaseAnnouncePopupPushEnd",
        func=function()
          if not mvars.mis_releaseAnnounceSetting then
            return
          end
          mvars.mis_releaseAnnounceSetting=nil
          this.ExecRewardProcess()
        end},
      {msg="BonusPopupAllClose",func=this.OnEndMissionReward},
      {msg="EndFadeIn",sender="OnEndWarpByFastTravel",
        func=TppPlayer.OnEndFadeInWarpByFastTravel},
      {msg="EndFadeOut",sender="FadeOutForMovieEnd",
        func=function()
          mvars.mov_checkEndFadeOut=true
        end}
    },
    Radio={
      {msg="Finish",func=TppRadio.OnFinishRadioWhileLoading},
      nil
    },
    Video={
      {msg="VideoPlay",
        func=function(e)
          TppMovie.DoMessage(e,"onStart")
        end},
      {msg="VideoStopped",
        func=function(e)
          TppMovie.DoMessage(e,"onEnd")
        end}
    }
  }
end
local FallDeathS32=StrCode32"FallDeath"
local SuicideS32=StrCode32"Suicide"
function this.OnPlayerDead(playerId,deathTypeStr32)
end
function this.OnAllPlayersDead(unkP1,deathTypeS32)
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
  this._OnDeadCommon(deathTypeS32)
end
function this.OnPlayerFallDead()
  TppPlayer.PlayFallDeadCamera()
end
function this.OnAbortMissionPreparation()
  this.SetNextMissionCodeForMissionClear(missionClearCodeNone)
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
function this.OnAllocate(missionTable)
  vars.invitationDisableRecieveFlag=0
  this.systemCallbacks={
    OnEstablishMissionClear=function()
      this.MissionGameEnd{loadStartOnResult=false}
    end,
    OnDisappearGameEndAnnounceLog=this.ShowMissionResult,
    OnEndMissionCredit=nil,
    OnEndMissionReward=nil,
    OnGameOver=nil,
    OnOutOfMissionArea=nil,
    OnUpdateWhileMissionPrepare=nil,
    OnFinishBlackTelephoneRadio=function()
      if not gvars.needWaitMissionInitialize then
        this.ShowMissionReward()
      end
    end,
    OnOutOfHotZone=nil,
    OnOutOfHotZoneMissionClear=nil,
    OnUpdateStorySequenceInGame=nil,
    CheckMissionClearFunction=nil,
    OnReturnToMission=nil,
    OnAddStaffsFromTempBuffer=nil,
    CheckMissionClearOnRideOnFultonContainer=nil,
    OnRecovered=nil,OnSetMissionFinalScore=nil,
    OnEndDeliveryWarp=nil,
    OnFultonContainerMissionClear=nil,
    OnOutOfDefenseGameArea=nil,
    OnAlertOutOfDefenseGameArea=nil
  }
  this.RegisterMissionID()
  Mission.AddFinalizer(this.OnMissionFinalize)
  if missionTable.sequence then
    if missionTable.sequence.MISSION_WORLD_CENTER then
      TppCoder.SetWorldCenter(missionTable.sequence.MISSION_WORLD_CENTER)
    end
    local objectiveDefine=missionTable.sequence.missionObjectiveDefine
    local ojectiveTree=missionTable.sequence.missionObjectiveTree
    local objectiveEnum=missionTable.sequence.missionObjectiveEnum
    if objectiveDefine and ojectiveTree then
      this.SetMissionObjectives(objectiveDefine,ojectiveTree,objectiveEnum)
    end
    if missionTable.sequence.missionStartPosition then
      if IsTypeTable(missionTable.sequence.missionStartPosition.orderBoxList)then
        mvars.mis_orderBoxList=missionTable.sequence.missionStartPosition.orderBoxList
      end
    end
    if this.IsStoryMission(vars.missionCode)then
      if missionTable.sequence.blackRadioOnEnd then
        if IsTypeString(missionTable.sequence.blackRadioOnEnd)then
          mvars.mis_blackRadioSetting=missionTable.sequence.blackRadioOnEnd
        end
      end
      if missionTable.sequence.releaseAnnounce then
        if IsTypeTable(missionTable.sequence.releaseAnnounce)then
          mvars.mis_releaseAnnounceSetting=missionTable.sequence.releaseAnnounce
          ReleaseAnnouncePopupSystem.SetInfos(mvars.mis_releaseAnnounceSetting)
        end
      end
    end
    if missionTable.sequence.DEFENSE_MAP_LOCATOR_NAME then
      SsdBlankMap.EnableDefenseMode{areaName=missionTable.sequence.DEFENSE_MAP_LOCATOR_NAME}
    else
      SsdBlankMap.DisableDefenseMode()
    end
  end
  mvars.mis_isOutsideOfMissionArea=false
  mvars.mis_isOutsideOfHotZone=true
  gvars.mis_isAbandonForDisconnect=false--RETAILPATCH: 1.0.12
  this.MessageHandler={
    OnMessage=function(sender,messageId,arg0,arg1,arg2,arg3)
      this.OnMessageWhileLoading(sender,messageId,arg0,arg1,arg2,arg3)
    end
  }
  GameMessage.SetMessageHandler(this.MessageHandler,{"UI","Radio","Video","Network","Nt"})
end
function this.DisableInGameFlag()
  mvars.mis_missionStateIsNotInGame=true
end
function this.EnableInGameFlag(resetMute)
  if gvars.mis_missionClearState<=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
    mvars.mis_missionStateIsNotInGame=false
    if not resetMute then
      TppSoundDaemon.ResetMute"Loading"
    end
  else
    mvars.mis_missionStateIsNotInGame=true
  end
end
--tex>
local skipLogCallBack={
  OnUpdateWhileMissionPrepare=true,
  OnUpdateStorySequenceInGame=true,
}
--<
function this.ExecuteSystemCallback(callbackName,arg1)
  --tex> DEBUG
  if ivars.debugFlow then
    if not skipLogCallBack[callbackName] then
      InfCore.LogFlow("TppMission.ExecuteSystemCallback:"..callbackName.."("..tostring(arg1)..")")
    end
  end
  --<
  local CallBack=this.systemCallbacks[callbackName]
  if IsTypeFunc(CallBack)then
    return CallBack(arg1)
  end
end
function this.Init(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(this.MessagesWhileLoading())
  mvars.mis_isAlertOutOfMissionArea=false
  mvars.mis_isAllDead=false
  gvars.mis_skipOnPreLoadForContinue=false
  mvars.mis_defeseGameAreaTrapTable={}
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(this.MessagesWhileLoading())
  if missionTable.sequence then
    local objectiveDefine=missionTable.sequence.missionObjectiveDefine
    local ojectiveTree=missionTable.sequence.missionObjectiveTree
    local objectiveEnum=missionTable.sequence.missionObjectiveEnum
    if objectiveDefine and ojectiveTree then
      this.SetMissionObjectives(objectiveDefine,ojectiveTree,objectiveEnum)
    end
  end
  local callBackNames={
    "OnEstablishMissionClear",
    "OnDisappearGameEndAnnounceLog",
    "OnEndMissionCredit",
    "OnEndMissionReward",
    "OnGameOver",
    "OnOutOfMissionArea",
    "OnUpdateWhileMissionPrepare",
    "OnFinishBlackTelephoneRadio",
    "OnOutOfHotZone",
    "OnOutOfHotZoneMissionClear",
    "OnUpdateStorySequenceInGame",
    "CheckMissionClearFunction",
    "OnReturnToMission",
    "OnAddStaffsFromTempBuffer",
    "CheckMissionClearOnRideOnFultonContainer",
    "OnRecovered",
    "OnMissionGameEndFadeOutFinish",
    "OnFultonContainerMissionClear"
  }
  for i,name in ipairs(callBackNames)do
    local systemCallbacks=_G.TppMission.systemCallbacks
    if systemCallbacks then
      local Callback=systemCallbacks[name]
      this.systemCallbacks=this.systemCallbacks or{}
      this.systemCallbacks[name]=Callback
    end
  end
end
function this.RegisterMissionID()
  mvars.mis_missionName=this._CreateMissionName(vars.missionCode)
end
function this.DeclareSVars()
  return{
    {name="mis_canMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,notify=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isDefiniteGameOver",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_gameOverType",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_gameOverRadio",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isDefiniteMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_missionClearType",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isAbandonMission",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_objectiveEnable",arraySize=maxObjective,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
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
function this.IgnoreAlertOutOfMissionAreaForBossQuiet(enable)
  if enable==true then
    mvars.mis_ignoreAlertOfMissionArea=true
  else
    mvars.mis_ignoreAlertOfMissionArea=false
  end
end
function this.EnableAlertOutOfMissionArea()
  local ignoreAlert=false
  if mvars.mis_ignoreAlertOfMissionArea==true then
    ignoreAlert=true
  end
  if svars.mis_canMissionClear then
    return
  end
  if mvars.mis_missionStateIsNotInGame then
    return
  end
  mvars.mis_enableAlertOutOfMissionArea=true
  TppUI.ShowAnnounceLog"closeOutOfMissionArea"
  if not ignoreAlert then
    TppOutOfMissionRangeEffect.Enable(3)
  end
end
function this.DisableAlertOutOfMissionArea()
  mvars.mis_enableAlertOutOfMissionArea=false
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.ExitHotZone()
  this.ExecuteSystemCallback"OnOutOfHotZone"
  if svars.mis_canMissionClear then
    TppUI.ShowAnnounceLog"leaveHotZone"
    if not IsNotAlert()then
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
    RegistMissionTimerPlayRecord()
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
  local function MBSave()
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
  this.waitMbSyncAndSaveCoroutine=coroutine.create(MBSave)
end
function this.ResumeMbSaveCoroutine()
  if this.waitMbSyncAndSaveCoroutine then
    local ok,ret=coroutine.resume(this.waitMbSyncAndSaveCoroutine)
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
  TppQuest.OnMissionGameEnd()
  SsdFlagMission.OnMissionGameEnd()
  SsdBaseDefense.OnMissionGameEnd()
  --RETAILPATCH: 1.0.9.0>
  if not mvars.mis_abortForReplayMission then
    SsdReplayMission.ClearReplayMissionSetting()
  end
  --<
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
  local exceptGameStatus
  if mvars.mis_abortWithSave then
    exceptGameStatus={AnnounceLog="SUSPEND_LOG"}
  else
    exceptGameStatus={AnnounceLog="INVALID_LOG"}
  end
  TppUI.FadeOut(mvars.mis_missionAbortFadeSpeed,"AbortMissionFadeOutFinish",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true,exceptGameStatus=exceptGameStatus})
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
  local gameOverType=svars.mis_gameOverType
  if gameOverType~=TppDefine.GAME_OVER_TYPE.PLAYER_DEAD and gameOverType~=TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD then--RETAILPATCH: 1.0.2.1: added check to allow revival
    Mission.SetRevivalDisabled(true)
  end
  local tipNames={}
  local currentStorySequence=TppStory.GetCurrentStorySequence()
  for i=currentStorySequence,TppDefine.STORY_SEQUENCE.STORY_START,-1 do
    local tipsForStorySeq=TppDefine.CONTINUE_TIPS_TABLE[e]
    if tipsForStorySeq then
      for j,tipName in ipairs(tipsForStorySeq)do
        table.insert(tipNames,tipName)
      end
    end
  end
  SsdUiSystem.RequestForceCloseForMissionClear()
  if#tipNames>0 then
    local continueTipsCount=gvars.continueTipsCount
    if(continueTipsCount>#tipNames)then
      continueTipsCount=1
      gvars.continueTipsCount=1
    end
    local tipName=tipNames[continueTipsCount]
    local tipId
    if tipName then
      tipId=TppDefine.TIPS[tipName]
    end
    if IsTypeNumber(tipId)then
      gvars.continueTipsCount=gvars.continueTipsCount+1
    end
  end
  local onGameOver
  if this.systemCallbacks.OnGameOver then
    onGameOver=this.systemCallbacks.OnGameOver()
  end
  if not onGameOver then
    local shownMenu=false
    if this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)then
      shownMenu=true
      this.ShowGameOverMenu{delayTime=TppPlayer.PLAYER_FALL_DEAD_DELAY_TIME}
    elseif this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.TARGET_DEAD)then
      local i=TppPlayer.SetTargetDeadCameraIfReserved()
      if i then
        shownMenu=true
        this.ShowGameOverMenu{delayTime=6}
      end
    elseif this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED)then
      local i=TppPlayer.SetDefenseTargetBrokenCameraIfReserved()
      if i then
        shownMenu=true
        this.ShowGameOverMenu{delayTime=6}
      end
    end
    if not shownMenu then
      this.ShowGameOverMenu()
    end
  end
  if(Tpp.IsQARelease())then
    if not(this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.ABORT)or this.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.S10060_RETURN_END))and(not mvars.mis_isGameOverMenuShown)then
    end
  end
end
function this.UpdateAtCanMissionClear(isOutsideOfHotZone,isOutsideOfMissionArea)
  if not isOutsideOfHotZone then
    mvars.mis_lastOutSideOfHotZoneButAlert=nil
    StopTimerOutsideHotZone()
    return
  end
  local isNotAlert=IsNotAlert()
  local isPlayerStatusNormal=IsPlayerStatusNormal()
  if isOutsideOfMissionArea then
    if isPlayerStatusNormal then
      StopTimerOutsideHotZone()
      this.ReserveMissionClearOnOutOfHotZone()
    end
  else
    if isNotAlert and isPlayerStatusNormal then
      if not IsTimerActive"Timer_OutsideOfHotZoneCount"then
        TimerStart("Timer_OutsideOfHotZoneCount",unkM9)
      end
    else
      if not isNotAlert then
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
function this.DisconnectMatching(leaveSession)
  local isHost=TppNetworkUtil.IsHost()
  if isHost then
    svars.mis_isAbandonMission=true
  end
  SsdMatching.RequestCancelAutoMatch()
  if(leaveSession)then
    SsdMatching.RequestLeaveRoomAndSession()
  end
end
function this.AbandonMission(params)--RETAILPATCH: 1.0.12 added param
  local params=params or {}
  if not this.IsCoopMission(vars.missionCode)then
    if this.IsMatchingRoom(vars.missionCode)then
      this.AbandonCoopLobbyMission(vars.missionCode)
    end
    return
  end
  this.DisconnectMatching(true)
  --RETAILPATCH: 1.0.12
  if params.needRestore then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"AbandonMissionForGoToLobby",TppUI.FADE_PRIORITY.SYSTEM)
    gvars.mis_isAbandonForDisconnect=true
    this.GoToCoopLobby()
  else
    --<
    this.ReturnToMatchingRoom()
  end
end
function this.AbandonCoopLobbyMission(missionCode)
  if not this.IsMatchingRoom(vars.missionCode)then
    return
  end
  if IS_GC_2017_COOP then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)
    this.DisconnectMatching(false)
    this.GameOverReturnToTitle()
    return
  end
  local isMultiPlayMission=this.IsMultiPlayMission(missionCode)
  this.DisconnectMatching(isMultiPlayMission)
  Mission.RequestCancelMatchingScreen()
  if not isMultiPlayMission then
    local loadInfo={}
    loadInfo.isNeedUpdateBaseManagement=true
    this.ContinueFromCheckPoint(loadInfo)
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
function this.AbortMissionByMenu(abortInfo)
  if this.IsCoopMission(vars.missionCode)then
    this.AbandonMission()
  else
    local _abortInfo=abortInfo or{}
    if this.IsMultiPlayMission(vars.missionCode)then
      _abortInfo.isNoSurviveBox=true
    end
    this.AbortForOutOfMissionArea(_abortInfo)
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
  local missionCode=TppDefine.SYS_MISSION_ID.AFGH_FREE
  if TppLocation.IsMiddleAfrica()then
    missionCode=TppDefine.SYS_MISSION_ID.MAFR_FREE
  end
  this.AbortMission{nextMissionId=missionCode,isAlreadyGameOver=true}
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
      local positions={}
      for i,boxName in pairs(mvars.mis_orderBoxList)do
        local pos,rot=this.GetOrderBoxLocatorByTransform(boxName)
        if pos then
          table.insert(positions,pos)
        end
      end
      TppBuddyService.SetMissionGroundStartPositions{positions=positions}
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
  local boxName=this.FindOrderBoxName(gvars.mis_orderBoxName)
  return this._SetMissionOrderBoxPosition(boxName)
end
function this._SetMissionOrderBoxPosition(boxName)
  local boxPosition,boxRotation=this.GetOrderBoxLocator(boxName)
  if boxPosition then
    local posOffset=Vector3(0,-.75,1.98)
    local fixedPos=Vector3(boxPosition[1],boxPosition[2],boxPosition[3])
    local rotQuat=-Quat.RotationY(TppMath.DegreeToRadian(boxRotation)):Rotate(posOffset)
    local position=rotQuat+fixedPos
    local positionVecTable=TppMath.Vector3toTable(position)
    local rotationDeg=boxRotation
    TppPlayer.SetInitialPosition(positionVecTable,rotationDeg)
    TppPlayer.SetMissionStartPosition(positionVecTable,rotationDeg)
    return true
  end
end
function this.FindOrderBoxName(orderBoxNameStr32)
  for i,orderBoxName in pairs(mvars.mis_orderBoxList)do
    if StrCode32(orderBoxName)==orderBoxNameStr32 then
      return orderBoxName
    end
  end
end
function this.GetOrderBoxLocator(orderBoxName)
  if not IsTypeString(orderBoxName)then
    return
  end
  return Tpp.GetLocator("OrderBoxIdentifier",orderBoxName)
end
function this.GetOrderBoxLocatorByTransform(orderBoxName)
  if not IsTypeString(orderBoxName)then
  end
  return Tpp.GetLocatorByTransform("OrderBoxIdentifier",orderBoxName)
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
  --RETAILPATCH: 1.0.9.0
  if Mission.IsReplayMission()and this.IsStoryMission(vars.missionCode)then
    SsdSaveSystem.SaveReplayEnd()
  end
  --<
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
  InfMain.OnMissionGameEndTop()--tex
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
  local missionClearType=this.GetMissionClearType()
  if(missionClearType==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO)or(missionClearType==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX)then
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
--objectiveDefine=missionTable.sequence.missionObjectiveDefine
function this.SetMissionObjectives(objectiveDefine,ojectiveTree,objectiveEnum)
  mvars.mis_missionObjectiveDefine=objectiveDefine
  mvars.mis_missionObjectiveTree=ojectiveTree
  mvars.mis_missionObjectiveEnum=objectiveEnum
  if mvars.mis_missionObjectiveTree then
    for n,e in Tpp.BfsPairs(mvars.mis_missionObjectiveTree)do
      for objectiveName,i in pairs(e)do
        local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
        if objectiveDefine then
          objectiveDefine.parent=objectiveDefine.parent or{}
          objectiveDefine.parent[n]=true
        end
      end
    end
  end
  --NMC uhh, ok, there's no code after these checks so what's the point?
  if mvars.mis_missionObjectiveTree and mvars.mis_missionObjectiveEnum==nil then
    return
  end
  if#mvars.mis_missionObjectiveEnum>maxObjective then
    return
  end
end
function this.OnFinishUpdateObjectiveRadio(radioGroupNameS32)
  if radioGroupNameS32==StrCode32(mvars.mis_updateObjectiveRadioGroupName)then
    this.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
--mvars.mis_objectiveSetting
function this.ShowUpdateObjective(objectiveSetting)
  if not IsTypeTable(objectiveSetting)then
    return
  end
  local announceLogTable={}
  for n,objectiveName in pairs(objectiveSetting)do
    local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
    local unkl1=true
    local notEnabled=not this.IsEnableMissionObjective(objectiveName)
    if notEnabled then
      notEnabled=(not this.IsEnableAnyParentMissionObjective(objectiveName))
    end
    if objectiveDefine and notEnabled then
      this.DisableChildrenObjective(objectiveName)
      this._ShowObjective(objectiveDefine,true)
      local announceInfo={isMissionAnnounce=false,subGoalId=nil}
      if objectiveDefine.announceLog then
        announceInfo.isMissionAnnounce=true
        if objectiveDefine.subGoalId then
          announceInfo.subGoalId=objectiveDefine.subGoalId
        end
        announceLogTable[objectiveDefine.announceLog]=announceInfo
      end
      this.SetMissionObjectiveEnable(objectiveName,true)
    end
  end
  if next(announceLogTable)then
    for i=1,#TppUI.ANNOUNCE_LOG_PRIORITY do
      local priority=TppUI.ANNOUNCE_LOG_PRIORITY[i]
      local announceLogInfo=announceLogTable[priority]
      if announceLogInfo then
        if announceLogInfo.isMissionAnnounce then
          TppUI.ShowAnnounceLog(priority)
          if announceLogInfo.subGoalId and announceLogInfo.subGoalId>0 then
            TppUI.ShowAnnounceLog("subGoalContent",nil,nil,nil,announceLogInfo.subGoalId)
          end
        end
        announceLogTable[priority]=nil
      end
    end
    if next(announceLogTable)then
      for announceId,n in pairs(announceLogTable)do
        TppUI.ShowAnnounceLog(announceId)
      end
    end
    TppSoundDaemon.PostEvent"sfx_s_terminal_data_fix"
  end
  mvars.mis_objectiveSetting=nil
  mvars.mis_updateObjectiveRadioGroupName=nil
end
function this._ShowObjective(objectiveDefine,enableTask)
  if objectiveDefine.packLabel then
    if not TppPackList.IsMissionPackLabelList(objectiveDefine.packLabel)then
      return
    end
  end
  if objectiveDefine.setInterrogation==nil then
    objectiveDefine.setInterrogation=true
  end
  if objectiveDefine.gameObjectName then
    TppMarker.Enable(objectiveDefine.gameObjectName,objectiveDefine.visibleArea,objectiveDefine.goalType,objectiveDefine.viewType,objectiveDefine.randomRange,objectiveDefine.setImportant,objectiveDefine.setNew,objectiveDefine.langId,objectiveDefine.guidelinesId)
  end
  if objectiveDefine.gimmickId then
    local ret,gameId=TppGimmick.GetGameObjectId(objectiveDefine.gimmickId)
    if ret then
      TppMarker.Enable(gameId,objectiveDefine.visibleArea,objectiveDefine.goalType,objectiveDefine.viewType,objectiveDefine.randomRange,objectiveDefine.setImportant,objectiveDefine.setNew,objectiveDefine.langId,objectiveDefine.guidelinesId)
    end
  end
  if objectiveDefine.subGoalId then
    TppUI.EnableMissionSubGoal(objectiveDefine.subGoalId)
    if objectiveDefine.subGoalId>0 then
      if not objectiveDefine.announceLog then
        objectiveDefine.announceLog="updateMissionInfo"
      end
    end
  end
  if objectiveDefine.showEnemyRoutePoints then
    if TppUiCommand.ShowEnemyRoutePoints then
      local radioGroupName=objectiveDefine.showEnemyRoutePoints.radioGroupName
      if IsTypeString(radioGroupName)then
        objectiveDefine.showEnemyRoutePoints.radioGroupName=StrCode32(radioGroupName)
      end
      TppUiCommand.ShowEnemyRoutePoints(objectiveDefine.showEnemyRoutePoints)
    end
  end
  if objectiveDefine.targetBgmCp then
    TppEnemy.LetCpHasTarget(objectiveDefine.targetBgmCp,true)
  end
  if objectiveDefine.missionTask then
    TppUI.EnableMissionTask(objectiveDefine.missionTask,enableTask)
  end
  if objectiveDefine.seEventName then
    if enableTask then
      TppSoundDaemon.PostEvent(objectiveDefine.seEventName)
    end
  end
end
function this.RestoreShowMissionObjective()
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  for i,objectiveName in ipairs(mvars.mis_missionObjectiveEnum)do
    if not svars.mis_objectiveEnable[i]then
      local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
      if objectiveDefine then
        this.DisableObjective(objectiveDefine)
      end
    end
  end
  for i,objectiveName in ipairs(mvars.mis_missionObjectiveEnum)do
    if svars.mis_objectiveEnable[i]then
      local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
      if objectiveDefine then
        this._ShowObjective(objectiveDefine,false)
      end
    end
  end
end
function this.SetMissionObjectiveEnable(objectiveName,enable)
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  local objectiveEnum=mvars.mis_missionObjectiveEnum[objectiveName]
  if not objectiveEnum then
    return
  end
  svars.mis_objectiveEnable[objectiveEnum]=enable
end
function this.IsEnableMissionObjective(objectiveName)
  if not mvars.mis_missionObjectiveEnum then
    return
  end
  local objectiveEnum=mvars.mis_missionObjectiveEnum[objectiveName]
  if not objectiveEnum then
    return
  end
  return svars.mis_objectiveEnable[objectiveEnum]
end
function this.GetParentObjectiveName(objectiveName)
  local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
  if not objectiveDefine then
    return
  end
  return objectiveDefine.parent
end
function this.IsEnableAnyParentMissionObjective(objectiveName)
  local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
  if not objectiveDefine then
    return
  end
  if not objectiveDefine.parent then
    return false
  end
  local hasEnabled
  for _objectiveName,unkV1 in pairs(objectiveDefine.parent)do
    if this.IsEnableMissionObjective(_objectiveName)then
      return true
    else
      hasEnabled=this.IsEnableAnyParentMissionObjective(_objectiveName)
      if hasEnabled then
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
  for objectiveName,n in Tpp.BfsPairs(n)do
    local objectiveDefine=mvars.mis_missionObjectiveDefine[objectiveName]
    if objectiveDefine then
      this.SetMissionObjectiveEnable(objectiveName,false)
      this.DisableObjective(objectiveDefine)
    end
  end
end
function this.DisableObjective(objectiveDefine)
  if objectiveDefine.packLabel then
    if not TppPackList.IsMissionPackLabelList(objectiveDefine.packLabel)then
      return
    end
  end
  if objectiveDefine.gameObjectName then
    TppMarker.Disable(objectiveDefine.gameObjectName,objectiveDefine.mapRadioName)
  end
  if objectiveDefine.gimmickId then
    local ret,gameId=TppGimmick.GetGameObjectId(objectiveDefine.gimmickId)
    if ret then
      TppMarker.Disable(gameId,objectiveDefine.mapRadioName)
    end
  end
  if objectiveDefine.showEnemyRoutePoints then
    local groupIndex=objectiveDefine.showEnemyRoutePoints.groupIndex
    if TppUiCommand.InitEnemyRoutePoints then
      TppUiCommand.InitEnemyRoutePoints(groupIndex)
    end
  end
  if objectiveDefine.targetBgmCp then
    TppEnemy.LetCpHasTarget(objectiveDefine.targetBgmCp,false)
  end
  if objectiveDefine.missionTask then
    TppUiCommand.DisableMissionTask(objectiveDefine.missionTask)
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
function this.SafeStopSettingOnMissionReload(params)
  local setMute
  if params and params.setMute then
    setMute=params.setMute
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
  if setMute then
    TppSoundDaemon.SetMute(setMute)
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
  this.SetNextMissionCodeForMissionClear(missionClearCodeNone)
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
  InfCore.LogFlow("TppMission.Load nextMissionCode:"..tostring(nextMissionCode).." currentMissionCode:"..tostring(currentMissionCode))--tex
  InfCore.PrintInspect(loadSettings,"loadSettings")--tex DEBUG
  InfMain.OnLoad(nextMissionCode,currentMissionCode)--tex
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
    local waitLoadingTipsEnd=((((((nextIsMultiPlay
      or nextIsAvatarEdit)
      or InvitationManagerController.IsGoingCoopMission())
      or gvars.mis_isReloaded)
      or gvars.ini_isTitleMode)
      or nextIsInit)
      or gvars.mis_isAbandonForDisconnect)--RETAILPATCH: 1.0.12 added isAbandonfordisconnect
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
function this.SetNextMissionCodeForMissionClear(missionCode)
  gvars.mis_nextMissionCodeForMissionClear=missionCode
  gvars.mis_nextLocationCodeForMissionClear=vars.locationCode
  local locationName=TppPackList.GetLocationNameFormMissionCode(missionCode)
  if locationName then
    gvars.mis_nextLocationCodeForMissionClear=TppDefine.LOCATION_ID[locationName]
  end
  --RETAILPATCH: 1.0.9.0>
  if Mission.IsReplayMission()then
    if TppLocation.IsMiddleAfrica()then
      gvars.mis_nextLocationCodeForMissionClear=TppDefine.LOCATION_ID.MAFR
      gvars.mis_nextMissionCodeForMissionClear=TppDefine.SYS_MISSION_ID.MAFR_FREE
    else
      gvars.mis_nextLocationCodeForMissionClear=TppDefine.LOCATION_ID.SSD_AFGH
      gvars.mis_nextMissionCodeForMissionClear=TppDefine.SYS_MISSION_ID.AFGH_FREE
    end
  end
  --<
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
  local objectiveRadioOption={}
  if IsTypeTable(n.radioOptions)then
    for i,n in pairs(n.radioOptions)do
      objectiveRadioOption[i]=n
    end
  end
  if FadeFunction.IsFadeProcessing()then
    local delayTime=objectiveRadioOption.delayTime
    local fadeTime=TppUI.FADE_SPEED.FADE_NORMALSPEED+1.2
    if IsTypeString(delayTime)then
      objectiveRadioOption.delayTime=TppRadio.PRESET_DELAY_TIME[delayTime]+fadeTime
    elseif IsTypeNumber(delayTime)then
      objectiveRadioOption.delayTime=delayTime+fadeTime
    else
      objectiveRadioOption.delayTime=fadeTime
    end
  end
  return objectiveRadioOption
end
function this.OnMissionStart()
  local missionCode=vars.missionCode
  if this.IsCoopMission(missionCode)then
    Mission.StartVotingSystem()
  end
  if not this.IsSysMissionId(missionCode)then
    MissionListMenuSystem.SetCurrentMissionCode(missionCode)
  else
    MissionListMenuSystem.SetCurrentMissionCode(TppDefine.MISSION_CODE_NONE)--RETAILPATCH: 1.0.10.0
  end
  mvars.mis_isMultiPlayMission=this.IsMultiPlayMission(missionCode)
  gvars.mis_isReloaded=false
end
function this.OnMissionFinalize()
  local e=vars.missionCode
  SsdSbm.SetKubTemporalStorageMode(false)
end
function this.SetPlayRecordClearInfo()
  local clearCount,allCount=TppStory.CalcAllMissionClearedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="MissionClear",clearCount=clearCount,allCount=allCount}
  local clearCount,allCount=TppStory.CalcAllMissionTaskCompletedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="MissionTaskClear",clearCount=clearCount,allCount=allCount}
  local clearCount,allCount=TppQuest.CalcQuestClearedCount()
  TppUiCommand.SetPlayRecordClearInfo{recordId="SideOpsClear",clearCount=clearCount,allCount=allCount}
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
  local missionCode,missionTypeCodeName=this.ParseMissionName(this.GetMissionName())
  if missionTypeCodeName=="free"then
    if gvars.mis_isExistOpenMissionFlag then
      TppUI.ShowAnnounceLog"missionListUpdate"
      TppUI.ShowAnnounceLog"missionAdd"
      gvars.mis_isExistOpenMissionFlag=false
    end
    TppQuest.ShowAnnounceLogQuestOpen()
  end
end
function this.SetDefensePosition(position)
  if not IsTypeTable(position)then
    return
  end
  local pos
  if position.useCurrentLocationBaseDiggerPosition then
    pos=TppGimmick.GetCurrentLocationDiggerPosition()
  else
    pos=position
  end
  Mission.SetDefensePosition{pos=pos}
end
function this.RegisterDefenseGameArea(t,s,waveName)
  mvars.mis_defeseGameAreaTrapTable=mvars.mis_defeseGameAreaTrapTable or{}
  local defeseGameAreaTrapTable=mvars.mis_defeseGameAreaTrapTable
  defeseGameAreaTrapTable.trapList=defeseGameAreaTrapTable.trapList or{}
  table.insert(defeseGameAreaTrapTable.trapList,t)
  defeseGameAreaTrapTable.alertTrapList=defeseGameAreaTrapTable.alertTrapList or{}
  table.insert(defeseGameAreaTrapTable.alertTrapList,s)
  defeseGameAreaTrapTable.trapToWaveName=defeseGameAreaTrapTable.trapToWaveName or{}
  defeseGameAreaTrapTable.trapToWaveName[StrCode32(t)]=waveName
  defeseGameAreaTrapTable.trapToWaveName[StrCode32(s)]=waveName
  mvars.mis_defeseGameAreaMessageExecTable=Tpp.MakeMessageExecTable(Tpp.StrCode32Table{
    Trap={
      {msg="Exit",sender=defeseGameAreaTrapTable.trapList,func=this.OnExitDefenseGameArea},
      {msg="Exit",sender=defeseGameAreaTrapTable.alertTrapList,func=this.OnExitAlertDefenseGameAreaTrap}
    }
  })
end
function this.OnExitDefenseGameArea(trapNameS32)
  if(not this.systemCallbacks.OnOutOfDefenseGameArea)or(not mvars.mis_defeseGameAreaTrapTable.trapToWaveName)then
    return
  end
  local waveName=mvars.mis_defeseGameAreaTrapTable.trapToWaveName[trapNameS32]
  this.systemCallbacks.OnOutOfDefenseGameArea(waveName)
end
function this.OnExitAlertDefenseGameAreaTrap(trapNameS32)
  if((not this.systemCallbacks.OnAlertOutOfDefenseGameArea)or(not mvars.mis_defeseGameAreaTrapTable.trapToWaveName))or(Mission.GetDefenseGameState()==TppDefine.DEFENSE_GAME_STATE.NONE)then
    return
  end
  local waveName=mvars.mis_defeseGameAreaTrapTable.trapToWaveName[trapNameS32]
  this.systemCallbacks.OnAlertOutOfDefenseGameArea(waveName)
end
function this.RegisterFreePlayWaveSetting(freeWaveSetting)
  if not IsTypeTable(freeWaveSetting)then
    return
  end
  mvars.mis_freeWaveSetting=freeWaveSetting
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
  local spawnSetting,spawnPointList=TppEnemy.MakeSpawnSettingTable(n,s,o)
  local waveSetting=TppEnemy.MakeWaveSettingTable(n,s)
  TppEnemy.RegisterWaveSpawnPointList(spawnPointList)
  local TppCommandPost2={type="TppCommandPost2"}
  GameObject.SendCommand(TppCommandPost2,{id="SetSpawnSetting",settingTable=spawnSetting})
  GameObject.SendCommand(TppCommandPost2,{id="SetWaveSetting",settingTable=waveSetting})
end
function this.RegisterWaveList(waveList)
  if not IsTypeTable(waveList)then
    return
  end
  mvars.mis_waveList=waveList
end
function this.RegisterWavePropertyTable(wavePropertyTable)
  if not IsTypeTable(wavePropertyTable)then
    return
  end
  mvars.mis_wavePropertyTable=wavePropertyTable
end
function this.GetWaveLimitTime(e)
  if not mvars.mis_wavePropertyTable then
    return
  end
  local waveProperties=mvars.mis_wavePropertyTable[e]
  if not waveProperties then
    return
  end
  return waveProperties.limitTimeSec
end
function this.GetWaveIntervalTime(e)
  if not mvars.mis_wavePropertyTable then
    return
  end
  local waveProperties=mvars.mis_wavePropertyTable[e]
  if not waveProperties then
    return
  end
  return waveProperties.intervalTimeSec
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
function this.SetInitialWaveName(initialWaveName)
  local n=mvars.mis_waveList[initialWaveName]
  if not n then
    return
  end
  mvars.mis_initialWaveName=initialWaveName
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
function this.StartDefenseGame(limitTime,alertTime,defenseType,waveInfo)
  if waveInfo==nil then
    waveInfo={}
  end
  mvars.mis_waveIndex=1
  if mvars.mis_initialWaveName then
    local waveIndex=mvars.mis_waveList[mvars.mis_initialWaveName]
    if not waveIndex then
      return
    end
    mvars.mis_waveIndex=waveIndex
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
  Mission.StartDefenseGame{limitTime=limitTime,prepareTime=(waveInfo.prepareTime or limitTime),alertTime=alertTime,defenseType=defenseType,finishType=waveInfo.finishType,killCount=waveInfo.killCount,shockWaveEffect=waveInfo.shockWaveEffect,miniMap=waveInfo.miniMap,prepareTimerLangId=waveInfo.prepareTimerLangId,waveTimerLangId=waveInfo.waveTimerLangId,intervalTimerLangId=waveInfo.intervalTimerLangId,showWaveTimer=waveInfo.showWaveTimer}
end
function this.StartDefenseGameWithWaveProperty(waveProperties)
  if not IsTypeTable(waveProperties)then
    return
  end
  local defenseGameType=waveProperties.defenseGameType
  local defenseTimeSec=waveProperties.defenseTimeSec
  local alertTimeSec=waveProperties.alertTimeSec
  local shockWaveEffect=waveProperties.endEffectName or"explosion"
  local finishType=waveProperties.finishType
  local miniMap=waveProperties.miniMap
  local prepareTimerLangId=waveProperties.prepareTimerLangId
  local waveTimerLangId=waveProperties.waveTimerLangId
  local intervalTimerLangId=waveProperties.intervalTimerLangId
  local showWaveTimer=waveProperties.showWaveTimer
  local isBaseDigging=waveProperties.isBaseDigging
  local prepareTime=waveProperties.prepareTime
  local showWaveTimer=waveProperties.showWaveTimer
  local waveInfo={shockWaveEffect=shockWaveEffect,miniMap=miniMap,prepareTime=prepareTime,prepareTimerLangId=prepareTimerLangId,waveTimerLangId=waveTimerLangId,intervalTimerLangId=intervalTimerLangId,showWaveTimer=showWaveTimer}
  if finishType then
    waveInfo.finishType=finishType.type
    waveInfo.killCount=finishType.maxCount
  end
  this.StartDefenseGame(defenseTimeSec,alertTimeSec,defenseGameType,waveInfo)
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
--tex REWORKED
local idRangeToTypeCode={
  ["1"]="s",
  ["2"]="e",
  ["3"]="f",
  ["4"]="h",
  ["5"]="o",
}
function this._CreateMissionName(missionCode)
  local firstDigit=string.sub(tostring(missionCode),1,1)
  local missionTypeCode=idRangeToTypeCode[firstDigit]
  if missionTypeCode==nil then
    if(Tpp.IsQARelease())and missionCode>=6e4 then
      return tostring(missionCode).."(for test)"
    end
    return nil
  end
  return missionTypeCode..tostring(missionCode)
end
--ORIG
--function this._CreateMissionName(missionCode)
--  local firstDigit=string.sub(tostring(missionCode),1,1)
--  local missionPrefix
--  if(firstDigit=="1")then
--    missionPrefix="s"
--  elseif(firstDigit=="2")then
--    missionPrefix="e"
--  elseif(firstDigit=="3")then
--    missionPrefix="f"
--  elseif(firstDigit=="4")then
--    missionPrefix="h"
--  elseif(firstDigit=="5")then
--    missionPrefix="o"
--  else
--    if(Tpp.IsQARelease())and missionCode>=6e4 then
--      return tostring(missionCode).."(for test)"
--    end
--    return nil
--  end
--  return missionPrefix..tostring(missionCode)
--end
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
  if InvitationManagerController.IsGoingCoopMission()and(not this.IsMultiPlayMission(unkP2)) or gvars.mis_isAbandonForDisconnect then --RETAILPATCH: 1.0.12 added isAbandonfordisconnect
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
        gvars.mis_isAbandonForDisconnect=false--RETAILPATCH: 1.0.14
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
    if InvitationManagerController.IsGoingCoopMission()or gvars.mis_isAbandonForDisconnect then--RETAILPATCH: 1.0.12 added isabandon
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
