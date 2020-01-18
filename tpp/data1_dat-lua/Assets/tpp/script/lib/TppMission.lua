local this={}
local e=this
local o=Fox.StrCode32
local i=Tpp.IsTypeFunc
local s=Tpp.IsTypeTable
local l=Tpp.IsTypeString
local m=Tpp.IsTypeNumber
local n=GkEventTimerManager.Start
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local d=TppScriptVars.SVarsIsSynchronized
local n=PlayRecord.RegistPlayRecord
local t=bit.bnot
local I,t,t=bit.band,bit.bor,bit.bxor
local t=GkEventTimerManager.Start
local C=GkEventTimerManager.Stop
local p=GkEventTimerManager.IsTimerActive
local a=Tpp.IsHelicopter
local v=Tpp.IsNotAlert
local g=Tpp.IsPlayerStatusNormal
local r=DemoDaemon.IsDemoPlaying
local r=10
local r=3
local y=5
local A=2.5
local r="Timer_outsideOfInnerZone"
local u=0
local _=64
local D=2
local E=4
local R=(24*60)*60
local c=2
local c=TppDefine.MAX_32BIT_UINT
local function h()
  n"MISSION_TIMER_UPDATE"
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
function this.RegiserMissionSystemCallback(n)
  e.RegisterMissionSystemCallback(n)
end
function this.RegisterMissionSystemCallback(n)
  if s(n)then
    if i(n.OnEstablishMissionClear)then
      e.systemCallbacks.OnEstablishMissionClear=n.OnEstablishMissionClear
    end
    if i(n.OnDisappearGameEndAnnounceLog)then
      e.systemCallbacks.OnDisappearGameEndAnnounceLog=n.OnDisappearGameEndAnnounceLog
    end
    if i(n.OnEndMissionCredit)then
      e.systemCallbacks.OnEndMissionCredit=n.OnEndMissionCredit
    end
    if i(n.OnEndMissionReward)then
      e.systemCallbacks.OnEndMissionReward=n.OnEndMissionReward
    end
    if i(n.OnGameOver)then
      e.systemCallbacks.OnGameOver=n.OnGameOver
    end
    if i(n.OnOutOfMissionArea)then
      e.systemCallbacks.OnOutOfMissionArea=n.OnOutOfMissionArea
    end
    if i(n.OnUpdateWhileMissionPrepare)then
      e.systemCallbacks.OnUpdateWhileMissionPrepare=n.OnUpdateWhileMissionPrepare
    end
    if i(n.OnFobDefenceGameOver)then
      e.systemCallbacks.OnFobDefenceGameOver=n.OnFobDefenceGameOver
    end
    if i(n.OnFinishBlackTelephoneRadio)then
      e.systemCallbacks.OnFinishBlackTelephoneRadio=n.OnFinishBlackTelephoneRadio
    end
    if i(n.OnOutOfHotZone)then
    end
    if i(n.OnOutOfHotZoneMissionClear)then
      e.systemCallbacks.OnOutOfHotZoneMissionClear=n.OnOutOfHotZoneMissionClear
    end
    if i(n.OnUpdateStorySequenceInGame)then
      e.systemCallbacks.OnUpdateStorySequenceInGame=n.OnUpdateStorySequenceInGame
    end
    if i(n.CheckMissionClearFunction)then
      e.systemCallbacks.CheckMissionClearFunction=n.CheckMissionClearFunction
    end
    if i(n.OnReturnToMission)then
      e.systemCallbacks.OnReturnToMission=n.OnReturnToMission
    end
    if i(n.OnAddStaffsFromTempBuffer)then
      e.systemCallbacks.OnAddStaffsFromTempBuffer=n.OnAddStaffsFromTempBuffer
    end
    if i(n.CheckMissionClearOnRideOnFultonContainer)then
      e.systemCallbacks.CheckMissionClearOnRideOnFultonContainer=n.CheckMissionClearOnRideOnFultonContainer
    end
    if i(n.OnRecovered)then
      e.systemCallbacks.OnRecovered=n.OnRecovered
    end
    if i(n.OnSetMissionFinalScore)then
      e.systemCallbacks.OnSetMissionFinalScore=n.OnSetMissionFinalScore
    end
    if i(n.OnEndDeliveryWarp)then
      e.systemCallbacks.OnEndDeliveryWarp=n.OnEndDeliveryWarp
    end
    if i(n.OnMissionGameEndFadeOutFinish)then
      e.systemCallbacks.OnMissionGameEndFadeOutFinish=n.OnMissionGameEndFadeOutFinish
    end
    if i(n.OnFultonContainerMissionClear)then
      e.systemCallbacks.OnFultonContainerMissionClear=n.OnFultonContainerMissionClear
    end
  end
end
function this.UpdateObjective(n)
  if not mvars.mis_missionObjectiveDefine then
    return
  end
  if mvars.mis_objectiveSetting then
    e.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
  local i=n.radio
  local t=n.radioSecond
  local o=n.options
  mvars.mis_objectiveSetting=n.objectives
  mvars.mis_updateObjectiveRadioGroupName=nil
  if not s(mvars.mis_objectiveSetting)then
    return
  end
  local n
  if TppSequence.IsHelicopterStart()then
    if not TppPlayer.IsAlreadyDropped()then
      n=true
    end
  end
  if s(o)then
    if o.isForceHelicopterStart then
      n=true
    end
  end
  if n then
    mvars.mis_updateObjectiveOnHelicopterStart=true
  end
  local o=false
  for n,i in pairs(mvars.mis_objectiveSetting)do
    local n=not e.IsEnableMissionObjective(i)
    if n then
      n=not e.IsEnableAnyParentMissionObjective(i)
    end
    if n then
      o=true
      break
    end
  end
  if s(i)then
    if o then
      if not n then
        mvars.mis_updateObjectiveRadioGroupName=TppRadio.GetRadioNameAndRadioIDs(i.radioGroups)
      end
      local e=e.GetObjectiveRadioOption(i)
      TppRadio.Play(i.radioGroups,e)
    end
  end
  if s(t)then
    if o then
      local e=e.GetObjectiveRadioOption(t)
      if n then
        mvars.mis_updateObjectiveDoorOpenRadioGroups=t.radioGroups
        mvars.mis_updateObjectiveDoorOpenRadioOptions=e
      else
        e.isEnqueue=true
        TppRadio.Play(t.radioGroups,e)
      end
    end
  end
  if not s(i)then
    e.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
function this.SetHelicopterDoorOpenTime(e)
  if not m(e)then
    return
  end
  mvars.mis_helicopterDoorOpenTimerTimeSec=e
end
function this.UpdateCheckPoint(e)
  TppCheckPoint.Update(e)
end
function this.UpdateCheckPointAtCurrentPosition()
  TppCheckPoint.UpdateAtCurrentPosition()
end
function this.IsMatchStartLocation(e)
  local e=TppPackList.GetLocationNameFormMissionCode(e)
  if TppLocation.IsAfghan()then
    if TppDefine.LOCATION_ID[e]~=TppDefine.LOCATION_ID.AFGH then
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
function this.IsStartFromHelispace()
  return gvars.mis_isStartFromHelispace
end
function this.IsStartFromFreePlay()
  return gvars.mis_isStartFromFreePlay
end
function this.AcceptMission(n)
  if e.IsEmergencyMission(n)then
    return
  end
  if not e.IsHelicopterSpace(vars.missionCode)then
    return
  end
  e.SetNextMissionCodeForMissionClear(n)
  TppUiCommand.StartMissionPreparation()
end
function this.AcceptMissionOnFreeMission(n,s,t)
  if e.IsEmergencyMission(n)then
    return
  end
  local i=e.IsMatchStartLocation(n)
  if not i then
    return
  end
  local i=TppDefine.NO_ORDER_BOX_MISSION_ENUM[tostring(n)]
  if i then
    local i=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[n]
    if i then
      e.ReserveMissionClear{nextMissionId=n,nextHeliRoute=i,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
    else
      e.ReserveMissionClear{nextMissionId=n,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
    end
    return
  end
  local i=n
  if e.IsHardMission(i)then
    i=e.GetNormalMissionCodeFromHardMission(i)
  end
  local e=s[i]
  if e==nil then
    return
  end
  svars[t]=n
  TppScriptBlock.Load("orderBoxBlock",i,true)
  return true
end
function this.AcceptMissionOnMBFreeMission(n,s,t)
  if e.IsEmergencyMission(n)then
    return
  end
  local i=e.IsMatchStartLocation(n)
  if not i then
    return
  end
  local i=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[n]
  if n==10115 then
    i=t[s][1]
  end
  if i then
    e.ReserveMissionClear{nextHeliRoute=i,nextMissionId=n,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
  else
    e.ReserveMissionClear{nextMissionId=n,missionClearType=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX}
  end
end
function this.AcceptEmergencyMission(n,s,i,t)
  if not e.IsEmergencyMission(n)then
    return
  end
  local o=e.GetCurrentLocationHeliMissionAndLocationCode()
  if e.IsFOBMission(n)==true then
    vars.returnStaffHeader=vars.playerStaffHeader
    vars.returnStaffSeeds=vars.playerStaffSeed
  end
  e.AbortMission{emergencyMissionId=n,nextMissionId=o,nextLayoutCode=s,nextClusterId=i,nextMissionStartRoute=t,isNoSave=true,isInterrupt=true}
end
function this.AcceptStartFobSneaking(i,s,n)
  e.SetNextMissionCodeForMissionClear(n)
  mvars.mis_nextLayoutCode=TppLocation.ModifyMbsLayoutCode(i)
  mvars.mis_nextClusterId=s
end
function this.SelectNextMissionHeliStartRoute(n,i,t)
  local s
  if not t then
    s=e.IsEmergencyMission(n)
  end
  local t=TppDefine.NO_HELICOPTER_ROUTE_ENUM[tostring(n)]
  if not t then
    local e=TppDefine.NO_ORDER_FIX_HELICOPTER_ROUTE[n]
    if e then
      i=o(e)
    end
  else
    i=0
  end
  if not t then
    if i==0 then
    end
  end
  if s then
    gvars.mis_nextMissionCodeForEmergency=n
  else
    e.SetNextMissionCodeForMissionClear(n)
    gvars.heli_missionStartRoute=i
  end
end
function this.SetHelicopterMissionStartPosition(s,i,n,e)
  if s==1 then
    mvars.mis_helicopterMissionStartPosition={i,n,e}
  else
    mvars.mis_helicopterMissionStartPosition=nil
  end
end
function this.StartEmergencyMissionTimer(i)
  if not s(i)then
    return
  end
  local n=i.openTimer
  if not s(n)then
    return
  end
  local i=i.closeTimer
  if not s(i)then
    return
  end
  local s,t,a=n.name,n.timeSecFromHeli,n.timeSecFromLand
  local o,r,i=i.name,i.timeSecFromHeli,i.timeSecFromLand
  local n
  n=e._StartEmergencyMissionTimer(s,t,a)
  if n then
  else
    return
  end
  n=e._StartEmergencyMissionTimer(o,r,i)
  if n then
  else
    return
  end
end
function this._StartEmergencyMissionTimer(n,s,i)
  if not l(n)then
    return
  end
  if not m(s)then
    return
  end
  if not m(i)then
    return
  end
  if e.IsStartFromHelispace()then
    t(n,s)
    return s
  else
    t(n,i)
    return i
  end
end
function this.Reload(n)
  local r,o,a,s,t,l
  if n then
    r=n.isNoFade
    o=n.missionPackLabelName
    a=n.locationCode
    t=n.showLoadingTips
    l=n.ignoreMtbsLoadLocationForce
    mvars.mis_nextLayoutCode=n.layoutCode
    mvars.mis_nextClusterId=n.clusterId
    s=n.OnEndFadeOut
  end
  if t~=nil then
    mvars.mis_showLoadingTipsOnReload=t
  else
    mvars.mis_showLoadingTipsOnReload=true
  end
  if l then
    mvars.mis_ignoreMtbsLoadLocationForce=true
  end
  if o then
    mvars.mis_missionPackLabelName=o
  end
  if a then
    mvars.mis_nextLocationCode=a
  end
  if s and i(s)then
    mvars.mis_reloadOnEndFadeOut=s
  else
    mvars.mis_reloadOnEndFadeOut=nil
  end
  if r then
    e.ExecuteReload()
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ReloadFadeOutFinish",nil,{setMute=true})
  end
end
function this.RestartMission(n)
  local i
  local s
  if n then
    i=n.isNoFade
    s=n.isReturnToMission
  end
  TppMain.EnablePause()
  if s then
    mvars.mis_isReturnToMission=true
  end
  if e.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_SHAM)then
    TppNetworkUtil.SessionEnableAccept(false)
    TppNetworkUtil.SessionDisconnectPreparingMembers()
  end
  if i then
    e.ExecuteRestartMission(mvars.mis_isReturnToMission)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"RestartMissionFadeOutFinish",nil,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ExecuteRestartMission(i)
  e.SafeStopSettingOnMissionReload()
  TppQuest.OnMissionGameEnd()
  TppPlayer.ResetInitialPosition()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)
  e.VarResetOnNewMission()
  local s
  if i then
    s=e.ExecuteOnReturnToMissionCallback()
    if(vars.missionCode==30050)then
      e.ResetMBFreeStartPositionToCommand()
    end
  end
  local n=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
  if n then
    local e=TppDefine.LOCATION_ID[n]
    if e then
      vars.locationCode=e
    end
  end
  TppSave.VarSave()
  if mvars.mis_needSaveConfigOnNewMission then
    TppSave.VarSaveConfig()
  end
  local n=nil
  if i then
    e.ClearFobMode()n=vars.missionCode
  end
  local n=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
      local i={force=true}
      if e.IsFOBMission(vars.missionCode)then
        i={force=true,waitOnLoadingTipsEnd=false}
      end
      e.RequestLoad(vars.missionCode,n,i)
    else
      e.Load(vars.missionCode,n,{force=true})
    end
  end
  if s then
    e.ShowAnnounceLogOnFadeOut(n)
  else
    n()
  end
end
function this.ContinueFromCheckPoint(n)
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
    e.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission)
  else
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"ContinueFromCheckPointFadeOutFinish",nil,{setMute=true,exceptGameStatus={AnnounceLog="INVALID_LOG"}})
  end
end
function this.ReturnToMission(n)
  local n=n or{}
  n.isReturnToMission=true
  e.DisableInGameFlag()
  e.ResetEmegerncyMissionSetting()
  if(vars.missionCode==50050)then
    TppSave.VarRestoreOnContinueFromCheckPoint()
    if TppNetworkUtil.IsSessionConnect()then
      TppNetworkUtil.CloseSession()
    end
  else
    TppSave.VarRestoreOnMissionStart()
  end
  e.RestartMission(n)
end
function this.ExecuteContinueFromCheckPoint(i,a,o)
  TppQuest.OnMissionGameEnd()
  TppWeather.OnEndMissionPrepareFunction()
  e.SafeStopSettingOnMissionReload()
  local t=gvars.usingNormalMissionSlot
  local n=vars.missionCode
  if not e.IsFOBMission(n)then
    e.IncrementRetryCount()
  end
  if gvars.usingNormalMissionSlot==false then
    e.ResetEmegerncyMissionSetting()
    TppSave.VarRestoreOnContinueFromCheckPoint()
  end
  if e.IsFOBMission(n)then
    TppSave.VarRestoreOnContinueFromCheckPoint()
  end
  if TppSystemUtility.GetCurrentGameMode()=="TPP"then
    TppEnemy.StoreSVars(true)
  end
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT)
  TppPlayer.StoreSupplyCbox()
  TppPlayer.StoreSupportAttack()
  TppPlayer.StorePlayerDecoyInfos()
  TppRadioCommand.StoreRadioState()
  local s
  if o then
    s=e.ExecuteOnReturnToMissionCallback()
  end
  if t then
    if a==GameOverMenu.POPUP_RESULT_YES then
      if i==GameOverMenu.STEALTH_ASSIST_POPUP then
        svars.dialogPlayerDeadCount=0
      end
      if i==GameOverMenu.PERFECT_STEALTH_POPUP then
        svars.chickCapEnabled=true
      end
    end
    if e.IsHardMission(vars.missionCode)then
      TppPlayer.UnsetRetryFlag()
    else
      if svars.chickCapEnabled then
        TppPlayer.SetRetryFlagWithChickCap()
      elseif GameConfig.GetStealthAssistEnabled()then
        TppPlayer.SetRetryFlag()
      else
        TppPlayer.UnsetRetryFlag()
      end
    end
    TppSave.VarSaveOnRetry()
    if not e.IsFOBMission(vars.missionCode)then
      TppSave.SaveGameData(vars.missionCode,nil,nil,true)
    end
  end
  local n=function()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
    local i
    if e.IsFOBMission(n)then
      i={waitOnLoadingTipsEnd=false}
    end
    if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
      e.RequestLoad(vars.missionCode,n,i)
    else
      e.Load(vars.missionCode,n,i)
    end
  end
  if s then
    e.ShowAnnounceLogOnFadeOut(n)
  else
    n()
  end
end
function this.IncrementRetryCount()
  PlayRecord.RegistPlayRecord"MISSION_RETRY"
  Tpp.IncrementPlayData"totalRetryCount"
  TppSequence.IncrementContinueCount()
end
function this.ExecuteOnReturnToMissionCallback()
  local n
  if e.systemCallbacks and e.systemCallbacks.OnReturnToMission then
    n=e.systemCallbacks.OnReturnToMission
  end
  if n then
    TppMain.DisablePause()
    Player.SetPause()
    TppUiStatusManager.ClearStatus"AnnounceLog"
    n()
    TppTerminal.AddStaffsFromTempBuffer()
    TppSave.VarSave()
    TppSave.SaveGameData(nil,nil,nil,true)
  end
  return n
end
function this.AbortMission(n)
  local r
  local u
  local l
  local o
  local S
  local O
  local f
  local T
  local c
  local d
  local p
  local a,t,i=0,0,TppUI.FADE_SPEED.FADE_NORMALSPEED
  local m
  local M
  if s(n)then
    r=n.isNoFade
    O=n.emergencyMissionId
    f=n.nextMissionId
    T=n.nextLayoutCode
    c=n.nextClusterId
    d=n.nextMissionStartRoute
    S=n.isExecMissionClear
    u=n.isNoSave
    l=n.isInterrupt
    p=n.isAlreadyGameOver
    if n.delayTime then
      a=n.delayTime
    end
    if n.fadeDelayTime then
      t=n.fadeDelayTime
    end
    if n.fadeSpeed then
      i=n.fadeSpeed
    end
    m=n.presentationFunction
    o=n.isTitleMode
    M=n.playRadio
  end
  if not e.CheckMissionState(S,true)then
    return
  end
  if mvars.mis_isAborting then
    return
  end
  if a then
    mvars.mis_missionAbortDelayTime=a
  end
  if t then
    mvars.mis_missionAbortFadeDelayTime=t
  end
  if i then
    mvars.mis_missionAbortFadeSpeed=i
  end
  mvars.mis_abortPresentationFunction=m
  if o then
    mvars.mis_abortIsTitleMode=o
  end
  mvars.mis_abortWithPlayRadio=M
  mvars.mis_emergencyMissionCode=O
  mvars.mis_nextMissionCodeForAbort=f
  mvars.mis_nextLayoutCodeForAbort=T
  mvars.mis_nextClusterIdForAbort=c
  mvars.mis_nextMissionStartRouteForAbort=d
  if u then
    mvars.mis_abortWithSave=false
  else
    mvars.mis_abortWithSave=true
  end
  if r then
    mvars.mis_abortWithFade=false
  else
    mvars.mis_abortWithFade=true
  end
  if l then
    mvars.mis_isInterruptMission=true
  end
  if not p then
    e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ABORT,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA,true)
  else
    e.EstablishedMissionAbort()
  end
end
function this.ExecuteMissionAbort()
  e.VarSaveForMissionAbort()
  e.LoadForMissionAbort()
end
function this.VarSaveForMissionAbort()
  if e.IsFOBMission(vars.missionCode)then
    if(vars.fobSneakMode==FobMode.MODE_SHAM)then
      mvars.mis_abortWithSave=false
    else
      mvars.mis_abortWithSave=true
    end
  end
  if not mvars.mis_nextMissionCodeForAbort then
    Tpp.DEBUG_Fatal"Not defined next missionId!!"
    e.RestartMission()
    return
  end
  e.SafeStopSettingOnMissionReload()
  if TppServerManager.FobIsSneak()then
    TppServerManager.AbortSneakMotherBase()
  end
  e.UnsetFobSneakFlag(mvars.mis_nextMissionCodeForAbort)
  local n=vars.missionCode
  if gvars.ini_isTitleMode then
    gvars.title_nextMissionCode=n
    gvars.title_nextLocationCode=vars.locationCode
    TppVarInit.InitializeForNewMission{}
    Player.SetPause()
  end
  mvars.mis_missionAbortLoadingOption={}
  local i=e.IsHelicopterSpace(n)
  local a=e.IsFreeMission(n)
  local s=e.IsHelicopterSpace(mvars.mis_nextMissionCodeForAbort)
  local t=e.IsFreeMission(mvars.mis_nextMissionCodeForAbort)
  if mvars.mis_isInterruptMission then
    gvars.usingNormalMissionSlot=false
    if i then
      mvars.mis_missionAbortLoadingOption.showLoadingTips=false
    else
      mvars.mis_missionAbortLoadingOption.showLoadingTips=true
      mvars.mis_missionAbortLoadingOption.waitOnLoadingTipsEnd=false
    end
    if mvars.mis_emergencyMissionCode then
      gvars.mis_nextMissionCodeForEmergency=mvars.mis_emergencyMissionCode
    end
    if mvars.mis_nextLayoutCodeForAbort then
      gvars.mis_nextLayoutCodeForEmergency=mvars.mis_nextLayoutCodeForAbort
    end
    if mvars.mis_nextClusterIdForAbort then
      gvars.mis_nextClusterIdForEmergency=mvars.mis_nextClusterIdForAbort
    end
    if mvars.mis_nextMissionStartRouteForAbort then
      gvars.mis_nextMissionStartRouteForEmergency=mvars.mis_nextMissionStartRouteForAbort
    end
  end
  vars.missionCode=mvars.mis_nextMissionCodeForAbort
  mvars.mis_abortCurrentMissionCode=n
  if e.IsFOBMission(vars.missionCode)then
    vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCodeForAbort)
    vars.mbClusterId=mvars.mis_nextClusterIdForAbort
    vars.locationCode=TppDefine.LOCATION_ID.MTBS
  else
    local e=TppPackList.GetLocationNameFormMissionCode(vars.missionCode)
    if e then
      local e=TppDefine.LOCATION_ID[e]
      if e then
        vars.locationCode=e
      end
    end
  end
  TppEnemy.ClearDDParameter()
  if(not e.IsFOBMission(n)and not e.IsFreeMission(n))and not e.IsHelicopterSpace(n)then
    TppRevenge.ReduceRevengePointOnAbort(n)
  end
  if mvars.mis_abortWithSave then
    if t then
      e.ReserveMissionStartRecoverSoundDemo()
    else
      e.ClearMissionStartRecoverSoundDemo()
    end
    if not mvars.mis_abortByRestartFromHelicopter then
      TppEnemy.FultonRecoverOnMissionGameEnd()
      TppHero.AnnounceMissionAbort()
    end
    if s then
      TppPlaced.DeleteAllCaptureCage()
    else
      TppPlayer.SaveCaptureAnimal()
    end
    TppClock.SaveMissionStartClock()
    TppWeather.SaveMissionStartWeather()
    TppTerminal.AddStaffsFromTempBuffer()
    TppRevenge.OnMissionClearOrAbort(n)
    TppRevenge.SaveMissionStartMineArea()
    if gvars.solface_groupNumber>=4294967295 then
      gvars.solface_groupNumber=0
    else
      gvars.solface_groupNumber=gvars.solface_groupNumber+1
    end
    gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
    TppPlayer.SavePlayerCurrentWeapons()
    local n=TppPlayer.RestoreWeaponsFromUsingTemp()
    if not n then
      TppPlayer.SavePlayerCurrentAmmoCount()
    end
    TppPlayer.SavePlayerCurrentItems()
    TppPlayer.RestoreItemsFromUsingTemp()
    TppPlayer.StoreSupplyCbox()
    TppPlayer.StoreSupportAttack()
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
    TppGimmick.DecrementCollectionRepopCount()
    e.ExecuteVehicleSaveCarryOnAbort()
    TppBuddyService.SetVarsMissionStart()
    e.KillDyingQuiet()
    if(not i)and t then
      TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
    end
    if gvars.usingNormalMissionSlot then
      TppStory.FailedRetakeThePlatformIfOpened()
    end
  else
    if gvars.usingNormalMissionSlot then
      TppPlayer.RestoreWeaponsFromUsingTemp()
      TppPlayer.RestoreItemsFromUsingTemp()
      if not TppStory.IsAlwaysOpenRetakeThePlatform()then
        TppStory.CloseRetakeThePlatform()
      end
    end
    e.ClearMissionStartRecoverSoundDemo()
    TppPlayer.ResetMissionStartPosition()
    TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  end
  if s then
    TppUiCommand.LoadoutSetReturnHelicopter()
  end
  local o={[10091]=TppMotherBaseManagement.UnlockedStaffsS10091,[10081]=TppMotherBaseManagement.UnlockedStaffS10081,[10115]=TppMotherBaseManagement.UnlockedStaffsS10115}
  local o=o[n]
  if o then
    if TppStory.IsMissionCleard(n)then
      o{crossMedal=false}
    end
  end
  TppBuddyService.BuddyMissionInit()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_ABORT,i,a,s,t,mvars.mis_abortWithSave)
  TppWeather.OnEndMissionPrepareFunction()
  e.VarResetOnNewMission()
  gvars.mis_orderBoxName=0
  if gvars.ini_isTitleMode then
    mvars.mis_missionAbortLoadingOption.showLoadingTips=false
    gvars.ini_isReturnToTitle=true
  else
    TppTerminal.ReserveMissionStartMbSync()
    local e=false
    if mvars.mis_abortWithSave then
      e=true
    end
    TppSave.VarSave(n,e)
    TppSave.SaveGameData(n,nil,nil,true)
    if mvars.mis_needSaveConfigOnNewMission then
      TppSave.VarSaveConfig()
      TppSave.SaveConfigData(nil,nil,reserveNextMissionStart)
    end
  end
end
function this.LoadForMissionAbort()
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  if gvars.str_storySequence>=TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    e.RequestLoad(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)
  else
    e.Load(vars.missionCode,mvars.mis_abortCurrentMissionCode,mvars.mis_missionAbortLoadingOption)
  end
end
function this.ReturnToTitle()
  if e.IsHelicopterSpace(vars.missionCode)then
    TppMotherBaseManagement.ProcessBeforeSync()
    TppMotherBaseManagement.StartSyncControl{}
    TppSave.SaveMBAndGlobal()
    e.CreateMbSaveCoroutine()
  end
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    e.AbortMission{nextMissionId=10010,isNoSave=true,isTitleMode=true}
  else
    local n,i=e.GetCurrentLocationHeliMissionAndLocationCode()
    e.AbortMission{nextMissionId=n,isNoSave=true,isTitleMode=true}
  end
end
function this.GameOverReturnToTitle()
  gvars.title_nextMissionCode=vars.missionCode
  gvars.title_nextLocationCode=vars.locationCode
  gvars.ini_isTitleMode=true
  mvars.mis_abortWithSave=false
  if gvars.str_storySequence<TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
    mvars.mis_nextMissionCodeForAbort=10010
  else
    mvars.mis_nextMissionCodeForAbort=e.GetCurrentLocationHeliMissionAndLocationCode()
  end
  e.ExecuteMissionAbort()
end
function this.ReserveGameOver(i,n,s)
  if svars.mis_isDefiniteMissionClear then
    return false
  end
  if e.IsFOBMission(vars.missionCode)==true and TppServerManager.FobIsSneak()==true then
    TppMain.DisablePlayerPad()
    TppUiStatusManager.SetStatus("PauseMenu","INVALID")
  end
  mvars.mis_isAborting=s
  mvars.mis_isReserveGameOver=true
  svars.mis_isDefiniteGameOver=true
  if type(i)=="number"and i<TppDefine.GAME_OVER_TYPE.MAX then
    svars.mis_gameOverType=i
  end
  if type(n)=="number"and n<TppDefine.GAME_OVER_RADIO.MAX then
    svars.mis_gameOverRadio=n
  end
  return true
end
function this.ReserveGameOverOnPlayerKillChild(n)
  if not mvars.mis_childGameObjectIdKilledPlayer then
    mvars.mis_childGameObjectIdKilledPlayer=n
    e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_KILL_CHILD_SOLDIER,TppDefine.GAME_OVER_RADIO.PLAYER_KILL_CHILD_SOLDIER)
  end
end
function this.IsGameOver()
  return svars.mis_isDefiniteGameOver
end
function this.CanMissionClear(e)
  mvars.mis_needSetCanMissionClear=true
  if s(e)then
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
  TppHelicopter.SetNoTakeOffTime()
end
function this.IsCanMissionClear()
  return svars.mis_canMissionClear
end
function this.OnCanMissionClear()
  if mvars.mis_canMissionClearNeedJingle~=false then
    TppSound.PostJingleOnCanMissionClear()
  end
  if a(vars.playerVehicleGameObjectId)then
    local e=GameObject.SendCommand({type="TppHeli2",index=0},{id="GetUsingRoute"})
    if TppLandingZone.IsAssaultDropLandingZone(e)then
      GameObject.SendCommand({type="TppHeli2",index=0},{id="PullOut"})
    end
  end
  TppUiCommand.ShowHotZone()
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
  if e.IsFOBMission(vars.missionCode)==true and TppServerManager.FobIsSneak()==true then
    TppMain.DisablePlayerPad()
    TppUiStatusManager.SetStatus("PauseMenu","INVALID")
  end
  mvars.mis_isReserveMissionClear=true
  if n then
    if n.missionClearType then
      svars.mis_missionClearType=n.missionClearType
    end
    if n.nextMissionId then
      e.SetNextMissionCodeForMissionClear(n.nextMissionId)
    end
    if n.nextHeliRoute then
      mvars.heli_missionStartRoute=n.nextHeliRoute
    end
    if n.nextLayoutCode then
      mvars.mis_nextLayoutCode=n.nextLayoutCode
      vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCode)
    end
    if n.nextClusterId then
      mvars.mis_nextClusterId=n.nextClusterId
      vars.mbClusterId=n.nextClusterId
    end
    if n.isInterruptMissionEnd then
      mvars.mis_isInterruptMissionEnd=true
    end
  end
  svars.mis_isDefiniteMissionClear=true
  return true
end
function this.MissionGameEnd(n)
  local i=0
  local t=0
  local s=TppUI.FADE_SPEED.FADE_NORMALSPEED
  if Tpp.IsTypeTable(n)then
    i=n.delayTime or 0
    s=n.fadeSpeed or TppUI.FADE_SPEED.FADE_NORMALSPEED
    t=n.fadeDelayTime or 0
    if n.loadStartOnResult~=nil then
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=n.loadStartOnResult
    else
      mvars.mis_doMissionFinalizeOnMissionTelopDisplay=false
    end
  end
  if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
    e.SetNeedWaitMissionInitialize()
  else
    e.ResetNeedWaitMissionInitialize()
  end
  mvars.mis_missionGameEndDelayTime=i
  e.FadeOutOnMissionGameEnd(t,s,"MissionGameEndFadeOutFinish")
  PlayRecord.RegistPlayRecord"MISSION_CLEAR"
end
function this.FadeOutOnMissionGameEnd(i,s,n)
  if i==0 then
    e._FadeOutOnMissionGameEnd(s,n)
  else
    mvars.mis_missionGameEndFadeSpeed=s
    mvars.mis_missionGameEndFadeId=n
    t("Timer_FadeOutOnMissionGameEndStart",i)
  end
end
function this._FadeOutOnMissionGameEnd(n,e)
  TppUI.FadeOut(n,e,nil,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
end
function this.CheckGameOverDemo(e)
  if e>TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK then
    return false
  end
  if I(svars.mis_gameOverType,TppDefine.GAME_OVER_TYPE.GAME_OVER_DEMO_MASK)==e then
    return true
  else
    return false
  end
end
function this.ShowGameOverMenu(i)
  local n
  if s(i)then
    if type(i.delayTime)=="number"then
      n=i.delayTime
    end
  end
  if n and n>0 then
    t("Timer_GameOverPresentation",n)
  else
    e.ExecuteShowGameOverMenu()
  end
end
function this.ShowStealthAssistPopup()
  if((vars.missionCode==10010)or(vars.missionCode==10240))or(vars.missionCode==10280)then
    return GameOverMenu.NO_POPUP
  end
  if e.IsHardMission(vars.missionCode)then
    return GameOverMenu.NO_POPUP
  end
  if mvars.mis_isGameOverReasonSuicide then
    return GameOverMenu.NO_POPUP
  end
  if svars.chickCapEnabled then
    return GameOverMenu.NO_POPUP
  end
  if GameConfig.GetStealthAssistEnabled()then
    if svars.dialogPlayerDeadCount>E then
      if gvars.elapsedTimeSinceLastUseChickCap>=R then
        return GameOverMenu.PERFECT_STEALTH_POPUP
      else
        return GameOverMenu.NO_POPUP
      end
    else
      return GameOverMenu.NO_POPUP
    end
  else
    if svars.dialogPlayerDeadCount>D then
      return GameOverMenu.STEALTH_ASSIST_POPUP
    else
      return GameOverMenu.NO_POPUP
    end
  end
end
function this.ExecuteShowGameOverMenu()
  TppRadio.Stop()
  local e=e.ShowStealthAssistPopup()
  TppUiCommand.StartGameOver(e)
end
function this.ShowMissionGameEndAnnounceLog()
  e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_GAME_END)
  if mvars.res_noResult then
    e.ShowAnnounceLogOnFadeOut(e.OnEndResultBlockLoad)
  else
    e.ShowAnnounceLogOnFadeOut(TppUiCommand.StartResultBlockLoad)
  end
end
function this.ShowAnnounceLogOnFadeOut(e)
  if TppUiCommand.GetSuspendAnnounceLogNum()>0 then
    TppUiStatusManager.ClearStatus"AnnounceLog"
    mvars.mis_endAnnounceLogFunction=e
  else
    e()
  end
end
function this.OnEndResultBlockLoad()
  TppUiStatusManager.SetStatus("GmpInfo","INVALID")
  if e.systemCallbacks.OnDisappearGameEndAnnounceLog then
    e.systemCallbacks.OnDisappearGameEndAnnounceLog(svars.mis_missionClearType)
  end
end
function this.EnablePauseForShowResult()
  if not gvars.enableResultPause then
    TppPause.RegisterPause"ShowResult"
    gvars.enableResultPause=true
  end
end
function this.DisablePauseForShowResult()
  if gvars.enableResultPause then
    TppPause.UnregisterPause"ShowResult"
    gvars.enableResultPause=false
  end
end
function this.ShowMissionResult()
  TppUiStatusManager.SetStatus("AnnounceLog","INVALID_LOG")
  TppRadio.Stop()
  TppSoundDaemon.SetMute"Loading"
  TppSoundDaemon.SetMute"Result"
  TppSound.EndJingleOnClearHeli()
  e.EnablePauseForShowResult()
  TppMotherBaseManagement.AddBonusPopupFromBonusPopupFlagStaffs()
  TppRadioCommand.SetEnableIgnoreGamePause(true)
  TppSound.PostJingleStartResultPresentation(svars.bestRank)
  TppUiCommand.CallMissionEndTelop()
  TppSound.SafeStopAndPostJingleOnShowResult()
  TppRadio.PlayResultRadio()
end
function this.ShowMissionReward()
  if TppReward.IsStacked()and(vars.missionCode~=50050)then
    TppReward.ShowAllReward()
  else
    e.OnEndMissionReward()
  end
end
function this.OnEndMissionReward()
  if gvars.needWaitMissionInitialize then
    e.ResetMissionClearState()
  else
    e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.REWARD_END)
  end
  if i(e.systemCallbacks.OnEndMissionReward)then
    e.systemCallbacks.OnEndMissionReward()
  else
    if gvars.needWaitMissionInitialize==false then
      e.ExecuteMissionFinalize()
    end
  end
  e.ResetNeedWaitMissionInitialize()
end
function this.MissionFinalize(n)
  local o,a,t,i,r,l
  if s(n)then
    o=n.isNoFade
    a=n.isExecGameOver
    t=n.showLoadingTips
    i=n.setMute
    r=n.isInterruptMissionEnd
    l=n.ignoreMtbsLoadLocationForce
  end
  if t~=nil then
    mvars.mis_showLoadingTipsOnMissionFinalize=t
  else
    mvars.mis_showLoadingTipsOnMissionFinalize=true
  end
  if i then
    mvars.mis_setMuteOnMissionFinalize=i
  end
  if r then
    mvars.mis_isInterruptMissionEnd=true
  end
  if l then
    mvars.mis_missionFinalizeIgnoreMtbsLoadLocationForce=true
  end
  if o then
    e.ExecuteMissionFinalize()
  else
    if a then
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeAtGameOverFadeOutFinish",nil,{setMute=true})
    else
      TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"MissionFinalizeFadeOutFinish",nil,{setMute=true})
    end
  end
end
function this.ExecuteMissionFinalize()
  local n=TppPackList.GetLocationNameFormMissionCode(gvars.mis_nextMissionCodeForMissionClear)
  if n then
    mvars.mis_nextLocationCode=TppDefine.LOCATION_ID[n]
  end
  e.SafeStopSettingOnMissionReload{setMute=mvars.mis_setMuteOnMissionFinalize}
  e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.MISSION_FINALIZED)
  e.UnsetFobSneakFlag(gvars.mis_nextMissionCodeForMissionClear)
  if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
    if TppUiCommand.IsEndMissionTelop()then
    end
    e.ShowMissionReward()
    e.systemCallbacks.OnFinishBlackTelephoneRadio=nil
    e.systemCallbacks.OnEndMissionCredit=nil
  end
  local l
  local n=vars.missionCode
  local r=vars.locationCode
  local i,a
  local t,s
  if e.IsFOBMission(gvars.mis_nextMissionCodeForMissionClear)then
    l=false
    TppSave.VarSave(n,true)
    TppSave.SaveGameData(n)
  end
  if gvars.mis_nextMissionCodeForMissionClear~=u then
    i=e.IsHelicopterSpace(vars.missionCode)
    t=e.IsFreeMission(vars.missionCode)
    a=e.IsHelicopterSpace(gvars.mis_nextMissionCodeForMissionClear)
    s=e.IsFreeMission(gvars.mis_nextMissionCodeForMissionClear)
    if mvars.heli_missionStartRoute then
      if Tpp.IsTypeString(mvars.heli_missionStartRoute)then
        gvars.heli_missionStartRoute=o(mvars.heli_missionStartRoute)
      elseif Tpp.IsTypeNumber(mvars.heli_missionStartRoute)then
        gvars.heli_missionStartRoute=mvars.heli_missionStartRoute
      else
        return
      end
    end
    if mvars.mis_nextLayoutCode then
      vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCode)
    else
      local e=TppDefine.STORY_MISSION_LAYOUT_CODE[gvars.mis_nextMissionCodeForMissionClear]
      if e then
        vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(e)
      end
    end
    if mvars.mis_nextClusterId then
      vars.mbClusterId=mvars.mis_nextClusterId
    end
    vars.locationCode=mvars.mis_nextLocationCode
    vars.missionCode=gvars.mis_nextMissionCodeForMissionClear
  else
    if not mvars.mis_isInterruptMissionEnd then
      Tpp.DEBUG_Fatal"Not defined next missionId!!"
      e.RestartMission()
      return
    end
  end
  if i then
    TppClock.SetTimeFromHelicopterSpace(mvars.mis_selectedDeployTime,r,vars.locationCode)
    if TppSave.CanSaveMbMangementData()then
      TppTerminal.ReserveMissionStartMbSync()
    end
  end
  TppPlayer.SavePlayerCurrentWeapons()
  local o=TppPlayer.RestoreWeaponsFromUsingTemp()
  TppPlayer.SavePlayerCurrentItems()
  TppPlayer.RestoreItemsFromUsingTemp()
  if not o then
    TppPlayer.SavePlayerCurrentAmmoCount()
  end
  if n==10030 and TppSave.CanSaveMbMangementData(n)then
    vars.items[2]=TppEquip.EQP_IT_TimeCigarette
    vars.items[3]=TppEquip.EQP_IT_Nvg
    vars.initItems[2]=TppEquip.EQP_IT_TimeCigarette
    vars.initItems[3]=TppEquip.EQP_IT_Nvg
    TppUiCommand.LoadoutSetItemEquipInfoInMission{slotIndex=2,equipId=TppEquip.EQP_IT_TimeCigarette,level=1}
    TppUiCommand.LoadoutSetItemEquipInfoInMission{slotIndex=3,equipId=TppEquip.EQP_IT_Nvg,level=1}
  end
  if(not i)then
    if e.IsMbFreeMissions(gvars.mis_nextMissionCodeForMissionClear)then
      TppUiCommand.LoadoutSetMissionRecieveFromFreeToMission()
    elseif s then
      TppUiCommand.LoadoutSetMissionEndFromMissionToFree()
    end
  end
  if not(i and s)then
    TppUiCommand.RemovedAllUserMarker()
  end
  if a then
    TppUiCommand.LoadoutSetReturnHelicopter()
  end
  if not i and not t then
    TppGimmick.DecrementCollectionRepopCount()
    Gimmick.StoreSaveDataPermanentGimmickForMissionClear()
    Gimmick.StoreSaveDataPermanentGimmickFromMissionAfterClear()
  end
  if t then
    Gimmick.StoreSaveDataPermanentGimmickFromMission()
  end
  local o={
  [10091]=function()
    if TppMotherBaseManagement.CanOpenS10091()then
      TppMotherBaseManagement.LockedStaffsS10091()
    end
  end,
  [10081]=function()
    if TppMotherBaseManagement.CanOpenS10081()then
      TppMotherBaseManagement.LockedStaffS10081()
    end
  end,
  [10115]=function()
    if TppMotherBaseManagement.CanOpenS10115{section="Develop"}then
      TppMotherBaseManagement.LockedStaffsS10115{section="Develop"}
    end
  end}
  local o=o[gvars.mis_nextMissionCodeForMissionClear]
  if o then
    if TppStory.IsMissionCleard(vars.missionCode)then
      o()
    end
  end
  if s then
    vars.requestFlagsAboutEquip=255
  end
  TppEnemy.ClearDDParameter()
  TppRevenge.OnMissionClearOrAbort(n)
  if gvars.solface_groupNumber>=4294967295 then
    gvars.solface_groupNumber=0
  else
    gvars.solface_groupNumber=gvars.solface_groupNumber+1
  end
  gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
  TppPlayer.StoreSupplyCbox()
  TppPlayer.StoreSupportAttack()
  TppRadioCommand.StoreRadioState()
  local o=false
  if vars.missionCode==10115 then
    o=true
  end
  local r=(vars.locationCode~=r)
  if not i then
    TppTerminal.AddStaffsFromTempBuffer(nil,o)
  end
  TppClock.SaveMissionStartClock()
  TppWeather.SaveMissionStartWeather()
  TppBuddyService.SetVarsMissionStart()
  TppBuddyService.BuddyMissionInit()
  TppRevenge.SaveMissionStartMineArea()
  TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_FINALIZE,i,t,a,s,nil,r)
  TppWeather.OnEndMissionPrepareFunction()
  e.VarResetOnNewMission()
  if not e.IsFOBMission(vars.missionCode)then
    local i=true
    TppSave.VarSave(n,true)
    local e=false
    do
      e=true
    end
    if e and(not o)then
      TppSave.SaveGameData(n,nil,nil,i)
    end
    if mvars.mis_needSaveConfigOnNewMission then
      TppSave.VarSaveConfig()
      TppSave.SaveConfigData(nil,nil,i)
    end
  end
  if mvars.mis_isInterruptMissionEnd then
    e.ResetEmegerncyMissionSetting()
    TppSave.VarSaveMBAndGlobal()
    TppSave.VarRestoreOnContinueFromCheckPoint()
    TppPlayer.ResetInitialPosition()
    TppMain.ReservePlayerLoadingPosition(TppDefine.MISSION_LOAD_TYPE.MISSION_RESTART)
    if(vars.missionCode==30050)then
      e.ResetMBFreeStartPositionToCommand()
    end
    e.VarResetOnNewMission()
    TppSave.VarSave()
    TppSave.SaveGameData(vars.missionCode)
  end
  if TppRadio.playingBlackTelInfo then
    mvars.mis_showLoadingTipsOnMissionFinalize=false
  end
  e.RequestLoad(vars.missionCode,n,{showLoadingTips=mvars.mis_showLoadingTipsOnMissionFinalize,waitOnLoadingTipsEnd=l,ignoreMtbsLoadLocationForce=mvars.mis_missionFinalizeIgnoreMtbsLoadLocationForce})
end
function this.ParseMissionName(e)
  local i=string.sub(e,2)
  i=tonumber(i)
  local n=string.sub(e,1,1)
  local e
  if(n=="s")then
    e="story"
  elseif(n=="e")then
    e="extra"
  elseif(n=="f")then
    e="free"
  elseif(n=="h")then
    e="heli"
  end
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
function this.IsHelicopterSpace(e)
  local e=math.floor(e/1e4)
  if e==4 then
    return true
  else
    return false
  end
end
function this.IsFreeMission(e)--tex: NMC: free mission ids are in the 30000 range, see TppDefine.SYS_MISSION_ID
  local e=math.floor(e/1e4)
  if e==3 then
    return true
  else
    return false
  end
end
function this.IsMbFreeMissions(e)
  local n={[30050]=true,[30150]=true,[30250]=true}
  if n[e]then
    return true
  else
    return false
  end
end
function this.IsFOBMission(e)
  local e=math.floor(e/1e4)
  if e==5 then
    return true
  else
    return false
  end
end
--tex is hard mission override
function this.IsHardMission(m)
  if (gvars.isManualHard > 0) then
    return true
  end
  return e.IsActualHardMission(m)
end
function this.IsManualHardMission()
  return (gvars.isManualHard > 0)
end
--tex end
function this.IsActualHardMission(e)--tex was IsHardMission
--function this.IsHardMission(e)
  local n=math.floor(e/1e3)
  local e=math.floor(e/1e4)*10
  if(n-e)==1 then
    return true
  else
    return false
  end
end
--tex
function this.GetNormalMissionCodeFromHardMission(m)
  if e.IsActualHardMission(m) then
    return m-1e3
  else
    return m
  end
end
--[[--tex ORIG:, commentary: (like I'm so great) seems like a stupid way to do it and so easy to forget to check
function this.GetNormalMissionCodeFromHardMission(e)
  return e-1e3
end--]]
function this.IsSubsistenceMission()
  if(vars.missionCode==11043)or(vars.missionCode==11044)or(gvars.isManualSubsistence > 0)then--tex added subsitence toggle
    return true
  else
    return false
  end
end
function this.IsManualSubsistenceMission()--tex
  return (gvars.isManualSubsistence > 0)
end
function this.IsActualSubsistenceMission()--tex
  if(vars.missionCode==11043)or(vars.missionCode==11044)then
    return true
  else
    return false
  end
end
function this.IsPerfectStealthMission()
  if(((vars.missionCode==11082)or(vars.missionCode==11033))or(vars.missionCode==11080))or(vars.missionCode==11121)then
    return true
  else
    return false
  end
end
function this.SetFOBMissionFlag()
  Mission.SetMissionFlags(bit.bor(Mission.MISSION_FLAGS_FOB,Mission.MISSION_FLAGS_MB))
end
function this.IsMissionStart()
  if gvars.sav_varRestoreForContinue then
    return false
  else
    return true
  end
end
function this.IsSysMissionId(e)
  local n
  for i,n in pairs(TppDefine.SYS_MISSION_ID)do
    if e==n then
      return true
    end
  end
  return false
end
function this.IsEmergencyMission(e)
  if e then
    if e==50050 then
      if TppServerManager.FobIsSneak()then
        return false
      else
        return true
      end
    end
    if e==10115 then
      if TppStory.IsAlwaysOpenRetakeThePlatform()then
        return false
      else
        return true
      end
    end
  else
    return not gvars.usingNormalMissionSlot
  end
end
function this.Messages()
  return Tpp.StrCode32Table{
    Player={
      {msg="Dead",func=e.OnPlayerDead,option={isExecGameOver=true}},
      {msg="Exit",sender="outerZone",func=function()
        mvars.mis_isOutsideOfMissionArea=true
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Enter",sender="outerZone",func=function()
        mvars.mis_isOutsideOfMissionArea=false
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Exit",sender="innerZone",func=function()
        if mvars.mis_fobDisableAlertMissionArea==true then
          return
        end
        mvars.mis_isAlertOutOfMissionArea=true
        if not e.CheckMissionClearOnOutOfMissionArea()then
          e.EnableAlertOutOfMissionArea()
        end
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Enter",sender="innerZone",func=function()
        mvars.mis_isAlertOutOfMissionArea=false
        e.DisableAlertOutOfMissionArea()
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Exit",sender="hotZone",func=function()
        mvars.mis_isOutsideOfHotZone=true
        e.ExitHotZone()
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="Enter",sender="hotZone",func=function()
        mvars.mis_isOutsideOfHotZone=false
        if TppSequence.IsMissionPrepareFinished()then
          e.PlayCommonRadioOnInsideOfHotZone()
        end
      end,option={isExecMissionPrepare=true,isExecDemoPlaying=true}},
      {msg="RideHelicopter",func=function()
        t("Timer_PlayCommonRadioOnRideHelicopter",1)
      end},
      {msg="OnInjury",func=function()
        TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RECOMMEND_CURE)
      end},
      {msg="PlayerFultoned",func=e.OnPlayerFultoned},
      {msg="FinishOpeningDemoOnHeli",func=function()
        TppSound.StopHelicopterStartSceneBGM()
        TppUiStatusManager.ClearStatus"EquipPanel"
        TppUiStatusManager.ClearStatus"HeadMarker"
        TppUiStatusManager.ClearStatus"WorldMarker"
        if e.IsFreeMission(vars.missionCode)or(e.IsFOBMission(vars.missionCode)and(vars.fobSneakMode==FobMode.MODE_VISIT))then
          TppUiStatusManager.ClearStatus"AnnounceLog"
        end
        if mvars.mis_updateObjectiveOnHelicopterStart then
          e.ShowUpdateObjective(mvars.mis_objectiveSetting)
          if mvars.mis_updateObjectiveDoorOpenRadioGroups then
            TppRadio.Play(mvars.mis_updateObjectiveDoorOpenRadioGroups,mvars.mis_updateObjectiveDoorOpenRadioOptions)
          end
        end
      end}},
    UI={
      {msg="EndTelopCast",func=function()
        TppUiStatusManager.ClearStatus"AnnounceLog"
      end},
      {msg="EndFadeOut",sender="MissionGameEndFadeOutFinish",func=e.OnMissionGameEndFadeOutFinish,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="EndFadeOut",sender="MissionFinalizeFadeOutFinish",func=e.ExecuteMissionFinalize,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true}},
      {msg="EndFadeOut",sender="MissionFinalizeAtGameOverFadeOutFinish",func=e.ExecuteMissionFinalize,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="EndFadeOut",sender="RestartMissionFadeOutFinish",func=function()
        e.ExecuteRestartMission(mvars.mis_isReturnToMission)
      end,option={isExecMissionClear=true,isExecMissionPrepare=true}},
      {msg="EndFadeOut",sender="ContinueFromCheckPointFadeOutFinish",func=function()
        e.ExecuteContinueFromCheckPoint(nil,nil,mvars.mis_isReturnToMission)
      end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="EndFadeOut",sender="ReloadFadeOutFinish",func=function()
        if mvars.mis_reloadOnEndFadeOut then
          mvars.mis_reloadOnEndFadeOut()
        end
        e.ExecuteReload()
      end,option={isExecMissionClear=true,isExecMissionPrepare=true}},
      {msg="EndFadeOut",sender="AbortMissionFadeOutFinish",func=function()
        if mvars.mis_missionAbortDelayTime>0 then
          t("Timer_MissionAbort",mvars.mis_missionAbortDelayTime)
        else
          e.OnEndFadeOutMissionAbort()
        end
      end,option={isExecGameOver=true}},
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()
        --tex player life values for difficulty. Difficult to track down the best place for this, player.changelifemax hangs anywhere but pretty much in game and ready to move, Anything before the ui ending fade in in fact, why.
        --which i don't like, my shitty code should be run in the shadows, not while player is getting viewable frames lol, this is at least just before that
        --RETRY: push back up again, you may just have fucked something up lol
        if not this.IsFOBMission(vars.missionCode)then--tex no idea how this would effect fob missions, never done one
          Player.ResetLifeMaxValue()
          local healthMult=gvars.playerHealthMult
          local newMax=vars.playerLifeMax
          if lifeMult==0 then--tex special case, rather than rely on mult for varying input life at low mults just set life to 10 BALLANCE:?good value for one shot?, in practice doesn't hit because of float accuracy
            Player.ChangeLifeMaxValue(10)
          elseif lifeMult==1 then
            Player.ResetLifeMaxValue()
          else
            newMax=newMax*healthMult
            if newMax < 1 then
              newMax = 1
            end
            Player.ChangeLifeMaxValue(newMax)
          end
        end--
        if TppSequence.IsHelicopterStart()then
          e.StartHelicopterDoorOpenTimer()
        end
        if TppSequence.IsLandContinue()then
          local e=e.IsHelicopterSpace(vars.missionCode)
          if((vars.missionCode~=10010)and(vars.missionCode~=10280))and(not e)then
            TppTerminal.ShowLocationAndBaseTelopForContinue()
          end
        end
        TppTerminal.GetFobStatus()
        e.ShowAnnounceLogOnGameStart()
        TppMain.ModMissionMessage()--tex
      end},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()
        e.ShowAnnounceLogOnGameStart()
      end},
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=function()
        if(vars.missionCode==30050)then
          TppTerminal.GetFobStatus()
        end
      end},
      {msg="GameOverOpen",func=TppMain.DisableGameStatusOnGameOverMenu,option={isExecGameOver=true}},
      {msg="GameOverContinue",func=e.ExecuteContinueFromCheckPoint,option={isExecGameOver=true}},
      {msg="GameOverAbortMission",func=e.GameOverAbortMission,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="GameOverAbortMissionGoToAcc",func=e.GameOverAbortMission,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="GameOverReturnToMission",func=function()
        e.ReturnToMission{isNoFade=true}
      end,option={isExecGameOver=true,isExecMissionClear=true}},
      {msg="GameOverRestart",func=function()
        e.ExecuteRestartMission()
      end,option={isExecGameOver=true}},
      {msg="GameOverReturnToTitle",func=e.GameOverReturnToTitle,option={isExecGameOver=true}},
      {msg="GameOverRestartFromHelicopter",func=function()
        mvars.mis_abortByRestartFromHelicopter=true
        e.AbortForRideOnHelicopter{isNoSave=false,isAlreadyGameOver=true}
      end,option={isExecGameOver=true}},
      {msg="PauseMenuCheckpoint",func=e.ContinueFromCheckPoint},
      {msg="PauseMenuAbortMission",func=e.AbortMissionByMenu},
      {msg="PauseMenuAbortMissionGoToAcc",func=e.AbortMissionByMenu},
      {msg="PauseMenuRestart",func=e.RestartMission},
      {msg="PauseMenuReturnToTitle",func=e.ReturnToTitle},
      {msg="PauseMenuRestartFromHelicopter",func=function()
        mvars.mis_abortByRestartFromHelicopter=true
        e.AbortForRideOnHelicopter{isNoSave=false}
      end},
      {msg="PauseMenuReturnToMission",func=e.ReturnToMission},
      {msg="RequestPlayRecordClearInfo",func=e.SetPlayRecordClearInfo},
      {msg="EndMissionTelopDisplay",func=function()
        if mvars.mis_doMissionFinalizeOnMissionTelopDisplay then
          e.MissionFinalize{isNoFade=true,setMute="Result"}
        end
      end,option={isExecMissionClear=true,isExecGameOver=true}},
      {msg="EndAnnounceLog",func=function()
        if mvars.mis_endAnnounceLogFunction then
          mvars.mis_endAnnounceLogFunction()
          mvars.mis_endAnnounceLogFunction=nil
        end
      end,option={isExecMissionClear=true,isExecGameOver=true,isExecMissionPrepare=true}},
      {msg="EndResultBlockLoad",func=e.OnEndResultBlockLoad,option={isExecMissionClear=true,isExecGameOver=true,isExecDemoPlaying=true}}},
    Radio={
      {msg="Finish",func=e.OnFinishUpdateObjectiveRadio}},
    Timer={
      {msg="Finish",sender="Timer_OutsideOfHotZoneCount",func=e.OutsideOfHotZoneCount,nil},
      {msg="Finish",sender="Timer_OnEndReturnToTile",func=e.RestartMission,option={isExecGameOver=true},nil},
      {msg="Finish",sender="Timer_GameOverPresentation",func=e.ExecuteShowGameOverMenu,option={isExecGameOver=true},nil},
      {msg="Finish",sender="Timer_MissionGameEndStart",func=e.OnMissionGameEndFadeOutFinish2nd,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Finish",sender="Timer_MissionGameEndStart2nd",func=e.ShowMissionGameEndAnnounceLog,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Finish",sender="Timer_FadeOutOnMissionGameEndStart",func=function()
        e._FadeOutOnMissionGameEnd(mvars.mis_missionGameEndFadeSpeed,mvars.mis_missionGameEndFadeId)
      end,option={isExecMissionClear=true,isExecDemoPlaying=true}},
      {msg="Finish",sender="Timer_StartMissionAbortFadeOut",func=e.FadeOutOnMissionAbort,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_MissionAbort",func=e.OnEndFadeOutMissionAbort,option={isExecGameOver=true}},
      {msg="Finish",sender="Timer_PlayCommonRadioOnRideHelicopter",func=function()
        if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
          e.PlayCommonRadioOnRideHelicopter()
        end
      end},
      {msg="Finish",sender="Timer_RemoveUserMarker",func=function()
        if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
          TppUiCommand.RemovedAllUserMarker()
        end
      end},
      {msg="Finish",sender=r,func=function()
        if(mvars.mis_isAlertOutOfMissionArea==false)then
          return
        end
        if e.CheckMissionClearOnOutOfMissionArea()then
          if mvars.mis_enableAlertOutOfMissionArea then
            e.DisableAlertOutOfMissionArea()
          end
        else
          if not mvars.mis_enableAlertOutOfMissionArea then
            e.EnableAlertOutOfMissionArea()
          end
        end
      end},
      {msg="Finish",sender="Timer_UpdateCheckPoint",func=function()
        TppStory.UpdateStorySequence{updateTiming="OnUpdateCheckPoint",isInGame=true}
      end},
      {msg="Finish",sender="Timer_MissionStartHeliDoorOpen",
        func=function()
          GameObject.SendCommand({type="TppHeli2",index=0},{id="RequestSnedDoorOpen"})
        end}},
    GameObject={
      {msg="ChangePhase",func=function(i,n)
        if mvars.mis_isExecuteGameOverOnDiscoveryNotice then
          if n==TppGameObject.PHASE_ALERT then
            e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.ON_DISCOVERY,TppDefine.GAME_OVER_RADIO.OTHERS)
          end
        end
      end},
      {msg="HeliDoorClosed",sender="SupportHeli",func=e.MissionClearOrAbortOnHeliDoorClosed},
      {msg="CalledFromStandby",sender="SupportHeli",func=function()
        if e.GetMissionName()~="s10020"then
          TppUI.ShowAnnounceLog"callHeliRecieved"
          local e=TppSupportRequest.GetCallRescueHeliGmpCost()
          TppTerminal.UpdateGMP{gmp=-e,gmpCostType=TppDefine.GMP_COST_TYPE.CALL_HELLI}svars.supportGmpCost=svars.supportGmpCost+e
        end
        TppSound.ClearOnDecendingLandingZoneJingleFlag()
      end},
      {msg="DescendToLandingZone",func=function()
        local n=e.CheckMissionClearOnOutOfMissionArea()
        local e=svars.mis_canMissionClear
        if n or e then
          TppSound.PostJingleOnDecendingLandingZone()
        else
          TppSound.PostJingleOnDecendingLandingZoneWithOutCanMissionClear()
        end
      end},
      {msg="StartedPullingOut",func=function()
        t("Timer_RemoveUserMarker",1)
        end},
      {msg="LostControl",func=function(e,n,i)
        local e=GameObject.GetTypeIndex(e)
        if e~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
          return
        end
        if n==o"Start"then
          TppHelicopter.SetNewestPassengerTable()
          local e=TppHelicopter.GetPassengerlist()
          if s(e)and next(e)then
            TppUI.ShowAnnounceLog"extractionFailed"
          end
        end
        if n==o"End"then
          local e=TppSupportRequest.GetCrashRescueHeliGmpCost()
          TppTerminal.UpdateGMP{gmp=-e,gmpCostType=TppDefine.GMP_COST_TYPE.DESTROY_SUPPORT_HELI}
          if Tpp.IsPlayer(i)then
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END)
          else
            TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END_ENEMY_ATTACK)
          end
          svars.supportGmpCost=svars.supportGmpCost+e
        end
      end},
      {msg="Damage",func=function(e,n,i)
        local e=GameObject.GetTypeIndex(e)
        if e~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
          return
        end
        if Tpp.IsPlayer(i)and TppDamage.IsActiveByAttackId(n)then
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.HELI_DAMAGE_FROM_PLAYER)
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
      end}},
    Terminal={
      {msg="MbDvcActCallRescueHeli",func=function(n,e)do
        if e==2 then
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE)
        else
          TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME)
        end
      end
      end},
      {msg="MbDvcActSelectLandPointEmergency",func=e.AcceptEmergencyMission},
      {msg="MbDvcActAcceptMissionList",func=e.AcceptEmergencyMission},
      {msg="MbDvcActHeliLandStartPos",func=e.SetHelicopterMissionStartPosition}},
    MotherBaseManagement={
      {msg="UpSectionLv",func=function(e,i,n)
        TppUI.ShowAnnounceLog(TppTerminal.unitLvAnnounceLogTable[e].up,n)
      end},
      {msg="DownSectionLv",func=function(e,i,n)
        TppUI.ShowAnnounceLog(TppTerminal.unitLvAnnounceLogTable[e].down,n)
      end},
      {msg="CompletedPlatform",func=function(e,e,e)
        TppStory.UpdateStorySequence{updateTiming="OnCompletedPlatform",isInGame=true}
      end},
      {msg="RequestSaveMbManagement",func=function()
        if vars.missionCode==10030 then
          TppMotherBaseManagement.SetRequestSaveResultFailure()
          return
        end
        if vars.missionCode==10115 then
          TppMotherBaseManagement.SetRequestSaveResultFailure()
          return
        end
        if not e.CheckMissionState()then
          TppMotherBaseManagement.SetRequestSaveResultFailure()
          return
        end
        TppSave.SaveOnlyMbManagement(TppSave.ReserveNoticeOfMbSaveResult)
      end,option={isExecMissionClear=true,isExecDemoPlaying=true,isExecGameOver=true,isExecMissionPrepare=true}}},
    Trap={
      {msg="Enter",sender="trap_mission_failed_area",func=function()
        if Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
        else
          e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)
        end
      end}}}
end
function this.MessagesWhileLoading()
  return Tpp.StrCode32Table{
    UI={
      {msg="EndMissionTelopFadeOut",func=function()
        e.DisablePauseForShowResult()
        if not gvars.needWaitMissionInitialize then
          if gvars.mis_missionClearState==TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
            return
          end
          e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.SHOW_CREDIT_END)
          if i(e.systemCallbacks.OnEndMissionCredit)then
            e.systemCallbacks.OnEndMissionCredit()
          else
            if not TppRadio.playingBlackTelInfo then
              e.ShowMissionReward()
            end
          end
        end
      end},
      {msg="BonusPopupAllClose",func=e.OnEndMissionReward}},
    Radio={
      {msg="Finish",func=TppRadio.OnFinishBlackTelephoneRadio},nil},
    Video={
      {msg="VideoPlay",func=function(e)
        TppMovie.DoMessage(e,"onStart")
      end},
      {msg="VideoStopped",func=function(e)
        TppMovie.DoMessage(e,"onEnd")
      end}}}
end
local f=o"FallDeath"
local c=o"Suicide"
function this.OnPlayerDead(i,n)
  if not TppNetworkUtil.IsHost()then
    return
  end
  local s=e.IsFOBMission(vars.missionCode)
  if(not s)or TppPlayer.IsSneakPlayerInFOB(i)then
    if n==f then
      mvars.mis_isGameOverReasonSuicide=true
      e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)
    else
      if n==c then
        mvars.mis_isGameOverReasonSuicide=true
      end
      e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.PLAYER_DEAD,TppDefine.GAME_OVER_RADIO.PLAYER_DEAD)
    end
  else
    svars.mis_fobDefenceGameOver=TppDefine.FOB_DEFENCE_GAME_OVER_TYPE.PLAYER_DEAD
  end
end
function this.OnEndMissionPreparation(n,i)
  mvars.mis_selectedDeployTime=n
  if this.IsSubsistenceMission() then--tex force ASAP mission time
    mvars.mis_selectedDeployTime=TppClock.DEPLOY_TIME.CURRENT
  end--
  if gvars.mis_nextMissionCodeForEmergency==0 then
    local s
    if gvars.heli_missionStartRoute==0 then
      s=mvars.heli_missionStartRoute
    end
    local n=TppDefine.STORY_MISSION_CLUSTER_ID[gvars.mis_nextMissionCodeForMissionClear]
    if i then
      n=i
    end
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,nextMissionId=gvars.mis_nextMissionCodeForMissionClear,nextHeliRoute=s,nextClusterId=n}
  else
    gvars.usingNormalMissionSlot=false
    e.GoToEmergencyMission()
  end
end
function this.GetNextMissionCodeForEmergency()
  return(mvars.mis_emergencyMissionCode or gvars.mis_nextMissionCodeForEmergency)
end
function this.OnAbortMissionPreparation()
  e.SetNextMissionCodeForMissionClear(u)
  gvars.heli_missionStartRoute=0
end
function this.WaitFinishMissionEndPresentation()
  while(not TppUiCommand.IsEndMissionTelop())do
    if TppUiCommand.KeepMissionStartTelopBg then
      TppUiCommand.KeepMissionStartTelopBg(false)
    end
    coroutine.yield()
  end
  while(TppRadio.playingBlackTelInfo~=nil)do
    coroutine.yield()
  end
  TppUiCommand.StartResultBlockUnload()
  if gvars.needWaitMissionInitialize then
    TppMain.DisablePause()
  end
  while(gvars.needWaitMissionInitialize)do
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
  e.ResetNeedWaitMissionInitialize()
end
function this.OnAllocate(n)
  e.systemCallbacks={
    OnEstablishMissionClear=function()
      e.MissionGameEnd{loadStartOnResult=false}
    end,
    OnDisappearGameEndAnnounceLog=e.ShowMissionResult,
    OnEndMissionCredit=nil,
    OnEndMissionReward=nil,
    OnGameOver=nil,
    OnOutOfMissionArea=nil,
    OnUpdateWhileMissionPrepare=nil,
    OnFobDefenceGameOver=nil,
    OnFinishBlackTelephoneRadio=function()
      if not gvars.needWaitMissionInitialize then
        e.ShowMissionReward()
      end
    end,
    OnOutOfHotZone=nil,
    OnOutOfHotZoneMissionClear=nil,
    OnUpdateStorySequenceInGame=nil,
    CheckMissionClearFunction=nil,
    OnReturnToMission=nil,
    OnAddStaffsFromTempBuffer=nil,
    CheckMissionClearOnRideOnFultonContainer=nil,
    OnRecovered=nil,
    OnSetMissionFinalScore=nil,
    OnEndDeliveryWarp=nil,
    OnFultonContainerMissionClear=nil
  }
  e.RegisterMissionID()
  if n.sequence then
    local i=n.sequence.missionObjectiveDefine
    local t=n.sequence.missionObjectiveTree
    local o=n.sequence.missionObjectiveEnum
    if i and t then
      e.SetMissionObjectives(i,t,o)
    end
    if n.sequence.missionStartPosition then
      if s(n.sequence.missionStartPosition.orderBoxList)then
        mvars.mis_orderBoxList=n.sequence.missionStartPosition.orderBoxList
      end
    end
    if n.sequence.ENABLE_DEFAULT_HELI_MISSION_CLEAR then
      mvars.mis_enableDefaultHeliMisionClear=true
    end
    mvars.mis_helicopterDoorOpenTimerTimeSec=15
    if n.sequence.HELICOPTER_DOOR_OPEN_TIME_SEC then
      mvars.mis_helicopterDoorOpenTimerTimeSec=n.sequence.HELICOPTER_DOOR_OPEN_TIME_SEC
    end
  end
  mvars.mis_isOutsideOfMissionArea=false
  mvars.mis_isOutsideOfHotZone=true
  e.MessageHandler={
    OnMessage=function(i,o,a,n,s,t)
      e.OnMessageWhileLoading(i,o,a,n,s,t)
    end
  }
  GameMessage.SetMessageHandler(e.MessageHandler,{"UI","Radio","Video","Network","Nt"})
end
function this.DisableInGameFlag()
  mvars.mis_missionStateIsNotInGame=true
end
function this.EnableInGameFlag(n)
  if(not gvars.usingNormalMissionSlot)and e.IsHelicopterSpace(vars.missionCode)then
    n=true
  end
  if gvars.mis_missionClearState<=TppDefine.MISSION_CLEAR_STATE.NOT_CLEARED_YET then
    mvars.mis_missionStateIsNotInGame=false
    if not n then
      TppSoundDaemon.ResetMute"Loading"
    end
  else
    mvars.mis_missionStateIsNotInGame=true
  end
end
function this.ExecuteSystemCallback(n,s)
  local e=e.systemCallbacks[n]
  if i(e)then
    return e(s)
  end
end
function this.Init(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
  e.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(e.MessagesWhileLoading())
  local n=e.IsHelicopterSpace(vars.missionCode)
  local e=e.IsFreeMission(vars.missionCode)
  if((not n)and(not e))and(not TppLocation.IsCyprus())then
    mvars.mis_isAlertOutOfMissionArea=true
  else
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==10030 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==10140 or vars.missionCode==11140 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==10240 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
  if vars.missionCode==50050 then
    mvars.mis_isAlertOutOfMissionArea=false
  end
end
function this.OnReload(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
  e.messageExecTableWhileLoading=Tpp.MakeMessageExecTable(e.MessagesWhileLoading())
  if n.sequence then
    local i=n.sequence.missionObjectiveDefine
    local s=n.sequence.missionObjectiveTree
    local n=n.sequence.missionObjectiveEnum
    if i and s then
      e.SetMissionObjectives(i,s,n)
    end
  end
  local n={"OnEstablishMissionClear","OnDisappearGameEndAnnounceLog","OnEndMissionCredit","OnEndMissionReward","OnGameOver","OnOutOfMissionArea","OnUpdateWhileMissionPrepare","OnFobDefenceGameOver","OnFinishBlackTelephoneRadio","OnOutOfHotZone","OnOutOfHotZoneMissionClear","OnUpdateStorySequenceInGame","CheckMissionClearFunction","OnReturnToMission","OnAddStaffsFromTempBuffer","CheckMissionClearOnRideOnFultonContainer","OnRecovered","OnMissionGameEndFadeOutFinish","OnFultonContainerMissionClear"}
  for i,n in ipairs(n)do
    local i=_G.TppMission.systemCallbacks
    if i then
      local i=i[n]
      e.systemCallbacks=e.systemCallbacks or{}
      e.systemCallbacks[n]=i
    end
  end
end
function this.RegisterMissionID()
  mvars.mis_missionName=e._CreateMissionName(vars.missionCode)
end
function this.DeclareSVars()
  return{
    {name="mis_canMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,notify=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isDefiniteGameOver",type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_gameOverType",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_gameOverRadio",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_isDefiniteMissionClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_missionClearType",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_objectiveEnable",arraySize=_,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="mis_fobDefenceGameOver",type=TppScriptVars.TYPE_UINT8,value=0,save=false,sync=true,wait=true,category=TppScriptVars.CATEGORY_MISSION},
    {name="chickCapEnabled",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    {name="dialogPlayerDeadCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},
    nil
  }
end
function this.CheckMessageOptionWhileLoading()
  return true
end
function this.OnMessageWhileLoading(s,i,t,o,r,a)
  local n=Tpp.DEBUG_StrCode32ToString
  local n
  Tpp.DoMessage(e.messageExecTableWhileLoading,e.CheckMessageOptionWhileLoading,s,i,t,o,r,a,n)
end
function this.OnMessage(r,a,s,i,n,t,o)
  Tpp.DoMessage(e.messageExecTable,e.CheckMessageOption,r,a,s,i,n,t,o)
end
function this.CheckMessageOption(n)
  local a=false
  local r=false
  local t=false
  local i=false
  if n and s(n)then
    a=n[o"isExecMissionClear"]
    r=n[o"isExecGameOver"]
    t=n[o"isExecDemoPlaying"]
    i=n[o"isExecMissionPrepare"]
  end
  return e.CheckMissionState(a,r,t,i)
end
function this.CheckMissionState(i,s,t,o)
  local n=mvars
  local e=svars
  if e==nil then
    return
  end
  local r=n.mis_isReserveMissionClear or e.mis_isDefiniteMissionClear
  local a=n.mis_isReserveGameOver or e.mis_isDefiniteGameOver
  local l=TppDemo.IsNotPlayable()
  local n=false
  if e.seq_sequence<=1 then
    n=true
  end
  if r and not i then
    return false
  elseif a and not s then
    return false
  elseif l and not t then
    return false
  elseif n and not o then
    return false
  else
    return true
  end
end
function this.CheckMissionClearOnOutOfMissionArea()
  if e.systemCallbacks.CheckMissionClearFunction then
    return e.systemCallbacks.CheckMissionClearFunction()
  else
    return false
  end
end
function this.EnableAlertOutOfMissionAreaIfAlertAreaStart()
  if mvars.mis_isAlertOutOfMissionArea then
    e.EnableAlertOutOfMissionArea()
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
  if not a(vars.playerVehicleGameObjectId)then
    mvars.mis_enableAlertOutOfMissionArea=true
    TppUI.ShowAnnounceLog"closeOutOfMissionArea"
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA)
    if not e then
      TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",true,1)
      TppOutOfMissionRangeEffect.Enable(3)
    end
  end
end
function this.DisableAlertOutOfMissionArea()
  mvars.mis_enableAlertOutOfMissionArea=false
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.ExitHotZone()
  e.ExecuteSystemCallback"OnOutOfHotZone"
  if svars.mis_canMissionClear then
    TppUI.ShowAnnounceLog"leaveHotZone"
    if not v()and not a(vars.playerVehicleGameObjectId)then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT)
    else
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE)
    end
  end
end
function this.PlayCommonRadioOnInsideOfHotZone()
  if svars.mis_canMissionClear then
    local e=not a(vars.playerVehicleGameObjectId)
    if e then
      TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.RETURN_HOTZONE)
    end
  end
end
function this.OnChangeFobDefenceGameOver()
  if svars.mis_fobDefenceGameOver==TppDefine.FOB_DEFENCE_GAME_OVER_TYPE.INIT then
    return
  end
  if TppNetworkUtil.IsHost()then
    return
  end
  if e.systemCallbacks.OnFobDefenceGameOver then
    e.systemCallbacks.OnFobDefenceGameOver(svars.mis_fobDefenceGameOver)
  end
end
function this.PlayCommonRadioOnRideHelicopter()
  if svars.mis_canMissionClear then
    e.StartJingleOnHelicopterClear()
  else
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.ABORT_BY_HELI)
  end
end
function this.StartJingleOnHelicopterClear()
  TppSound.StartJingleOnClearHeli()
  TppSoundDaemon.SetMute"HeliClosing"
end
function this.MissionClearOrAbortOnHeliDoorClosed()
  if not mvars.mis_enableDefaultHeliMisionClear then
    return
  end
  if svars.mis_canMissionClear then
    e.ReserveMissionClearOnRideOnHelicopter()
  else
    e.AbortForRideOnHelicopter{isNoSave=false}
  end
end
function this.ReserveMissionStartRecoverSoundDemo()
  if Tpp.IsEnemyWalkerGear(vars.playerVehicleGameObjectId)then
    gvars.mis_missionStartRecoverDemoType=TppDefine.MISSION_START_RECOVER_DEMO_TYPE.WALKER_GEAR
    TppTerminal.ReserveHelicopterSoundOnMissionGameEnd()
  elseif Tpp.IsVehicle(vars.playerVehicleGameObjectId)then
    gvars.mis_missionStartRecoverDemoType=TppDefine.MISSION_START_RECOVER_DEMO_TYPE.VEHICLE
  else
    e.ClearMissionStartRecoverSoundDemo()
  end
end
function this.ClearMissionStartRecoverSoundDemo()
  gvars.mis_missionStartRecoverDemoType=TppDefine.MISSION_START_RECOVER_DEMO_TYPE.NONE
end
function this.GetMissionStartRecoverDemoType()
  return gvars.mis_missionStartRecoverDemoType
end
function this.OutsideOfHotZoneCount()
  if mvars.mis_isOutsideOfHotZone then
    e.ReserveMissionClearOnOutOfHotZone()
  end
end
local function c()
  if p"Timer_OutsideOfHotZoneCount"then
    C"Timer_OutsideOfHotZoneCount"
  end
end
function this.CheckMissionClearOnRideOnFultonContainer()
  if e.systemCallbacks.CheckMissionClearOnRideOnFultonContainer then
    return e.systemCallbacks.CheckMissionClearOnRideOnFultonContainer()
  else
    return false
  end
end
function this.OnPlayerFultoned()
  if e.IsFOBMission(vars.missionCode)then
    return
  end
  if e.IsCanMissionClear()or e.CheckMissionClearOnRideOnFultonContainer()then
    e.ReserveMissionClearOnRideOnFultonContainer()
  else
    e.AbortForRideFultonContainer()
  end
end
function this.Update()
  TppMain.UpdateModMenu()--tex
  local n=mvars
  local s=svars
  local o=e.GetMissionName()
  if n.mis_needSetCanMissionClear then
    e._SetCanMissionClear()
  end
  if n.mis_missionStateIsNotInGame then
    return
  end
  local f,c,T,m=e.GetSyncMissionStatus()
  local u=n.mis_isAlertOutOfMissionArea
  local i=n.mis_isOutsideOfMissionArea
  local d=n.mis_isOutsideOfHotZone
  local l=s.mis_canMissionClear
  if f and c then
    TppMain.DisableGameStatus()
    HighSpeedCamera.RequestToCancel()
    e.EstablishedMissionClear(s.mis_missionClearType)
  elseif T and m then
    TppMain.DisableGameStatus()
    HighSpeedCamera.RequestToCancel()
    if n.mis_isAborting then
      e.EstablishedMissionAbort()
    else
      e.EstablishedGameOver()
    end
  elseif l then
    e.UpdateAtCanMissionClear(d,i)
  else
    if i then
      local n=not a(vars.playerVehicleGameObjectId)
      if n then
        if e.CheckMissionClearOnOutOfMissionArea()then
          e.ReserveMissionClearOnOutOfHotZone()
        else
          if e.systemCallbacks.OnOutOfMissionArea==nil then
            e.AbortForOutOfMissionArea{isNoSave=false}
          else
            e.systemCallbacks.OnOutOfMissionArea()
          end
        end
      end
    end
    if u then
      if not p(r)then
        t(r,A)
      end
    else
      if p(r)then
        C(r)
      end
    end
  end
  if TppSequence.IsMissionPrepareFinished()then
    h()
  end
  e.ResumeMbSaveCoroutine()
  if n.mis_needSetEscapeBgm then
    if o=="s10090"or o=="s11090"then
      TppSound.StartEscapeBGM()
    else
      if vars.playerPhase>TppEnemy.PHASE.SNEAK then
        TppSound.StartEscapeBGM()
      else
        TppSound.StopEscapeBGM()
      end
    end
  end
end
function this.UpdateForMissionLoad()
  if mvars.mis_loadRequest then
    e.LoadWithChunkCheck()
  end
end
function this.CreateMbSaveCoroutine()
  local function n()
    while(not TppMotherBaseManagement.IsEndedSyncControl())do
      coroutine.yield()
    end
    if TppMotherBaseManagement.IsResultSuccessedSyncControl()then
      TppSave.SaveOnlyMbManagement()
    end
  end
  e.waitMbSyncAndSaveCoroutine=coroutine.create(n)
end
function this.ResumeMbSaveCoroutine()
  if e.waitMbSyncAndSaveCoroutine then
    local n,n=coroutine.resume(e.waitMbSyncAndSaveCoroutine)
    if coroutine.status(e.waitMbSyncAndSaveCoroutine)=="dead"then
      e.waitMbSyncAndSaveCoroutine=nil
      return
    end
  end
end
function this.GetSyncMissionStatus()
  local o=mvars
  local e=svars
  local a=TppNetworkUtil.IsHost()
  local r=TppNetworkUtil.IsSessionConnect()
  local t=false
  local i=false
  local s=false
  local n=false
  if a then
    t=e.mis_isDefiniteMissionClear and d"mis_isDefiniteMissionClear"
    i=d"mis_missionClearType"
    s=e.mis_isDefiniteGameOver and d"mis_isDefiniteGameOver"
    n=d"mis_gameOverType"
  else
    if r then
      t=e.mis_isDefiniteMissionClear
      i=true
      s=e.mis_isDefiniteGameOver
      n=e.mis_gameOverType
    else
      t=o.mis_isReserveMissionClear
      i=true
      s=o.mis_isDefiniteGameOver
      n=true
    end
  end
  return t,i,s,n
end
function this.SeizeReliefVehicleOnAbort()
  if mvars.mis_abortIsTitleMode then
    return
  end
  if not GameObject.DoesGameObjectExistWithTypeName"TppVehicle2"then
    return
  end
  local e=GameObject.CreateGameObjectId("TppVehicle2",0)
  if not GameObject.SendCommand(e,{id="IsAlive"})then
    return
  end
  if mvars.mis_abortWithSave and not mvars.mis_abortByRestartFromHelicopter then
    if e~=vars.playerVehicleGameObjectId then
      if Player.GetItemLevel(TppEquip.EQP_IT_Fulton_Cargo)>=2 or Player.GetItemLevel(TppEquip.EQP_IT_Fulton_WormHole)>=1 then
        local n=GameObject.SendCommand(e,{id="GetResourceId"})
        local i=not Tpp.IsHelicopter(vars.playerVehicleGameObjectId)
        TppTerminal.OnFulton(e,nil,nil,n,nil,i,PlayerInfo.GetLocalPlayerIndex())
      end
    end
  else
    GameObject.SendCommand(e,{id="Seize",options={"Fulton","CheckFultonType","DirectAccount"}})
  end
end
function this.SeizeReliefVehicleOnClear()
  if not GameObject.DoesGameObjectExistWithTypeName"TppVehicle2"then
    return
  end
  local n=GameObject.CreateGameObjectId("TppVehicle2",0)
  if not GameObject.SendCommand(n,{id="IsAlive"})then
    return
  end
  if n~=vars.playerVehicleGameObjectId then
    local i={"Fulton","CheckFultonType"}
    local s=e.GetMissionClearType()
    if not e.EvaluateReliefVehicleSeizable(s)then
      table.insert(i,"CheckFarFromPlayer")
    end
    GameObject.SendCommand(n,{id="Seize",options=i})
  end
end
function this.SeizeReliefVehicleOnForceGoToMb()
  if not GameObject.DoesGameObjectExistWithTypeName"TppVehicle2"then
    return
  end
  local e=GameObject.CreateGameObjectId("TppVehicle2",0)
  if not GameObject.SendCommand(e,{id="IsAlive"})then
    return
  end
  GameObject.SendCommand(e,{id="Seize",options={"Fulton","CheckFultonType","DirectAccount"}})
end
function this.EvaluateReliefVehicleSeizable(e)
  if((e~=TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO and e~=TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END)and e~=TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END)and e~=TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END then
    return true
  end
  return false
end
function this.EvaluateVehicleCarryOption(i)
  local n={}
  if e.EvaluateReliefVehicleSeizable(i)then
    table.insert(n,"Abandon")
  end
  return n
end
function this.ExecuteVehicleSaveCarryOnAbort()
  if mvars.mis_abortByRestartFromHelicopter then
    return
  end
  Vehicle.SaveCarry()
end
function this.ExecuteVehicleSaveCarryOnClear()
  local n=vars.locationCode
  if n~=TppDefine.LOCATION_ID.AFGH and n~=TppDefine.LOCATION_ID.MAFR then
    return
  end
  local n=e.GetMissionClearType()
  local t=e.EvaluateVehicleCarryOption(n)
  local i=nil
  local s=nil
  if n==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO then
    if mvars.mis_orderBoxList then
      if gvars.mis_orderBoxName~=0 then
        local n=e.FindOrderBoxName(gvars.mis_orderBoxName)
        local e,n=e.GetOrderBoxLocator(n)
        if e then
          local o=Vector3(0,-.75,1.98)
          local t=Vector3(e[1],e[2],e[3])
          local e=-Quat.RotationY(TppMath.DegreeToRadian(n)):Rotate(o)i=e+t
          s=n
        end
      end
    end
  end
  Vehicle.SaveCarry{options=t,initialPosition=i,initialRotY=s}
end
function this.EstablishedMissionAbort()
  e.SeizeReliefVehicleOnAbort()
  TppQuest.OnMissionGameEnd()
  if mvars.mis_abortWithPlayRadio then
    TppRadio.PlayGameOverRadio()
  end
  if mvars.mis_abortIsTitleMode then
    gvars.ini_isTitleMode=true
  end
  if mvars.mis_abortPresentationFunction then
    mvars.mis_abortPresentationFunction()
  end
  if mvars.mis_abortWithFade then
    if mvars.mis_missionAbortFadeDelayTime==0 then
      e.FadeOutOnMissionAbort()
    else
      t("Timer_StartMissionAbortFadeOut",mvars.mis_missionAbortFadeDelayTime)
    end
  else
    e.ExecuteMissionAbort()
  end
end
function this.FadeOutOnMissionAbort()
  local e
  if mvars.mis_abortWithSave then
    TppHero.MissionAbort()
    e={AnnounceLog="SUSPEND_LOG"}
  else
    e={AnnounceLog="INVALID_LOG"}
  end
  TppUI.FadeOut(mvars.mis_missionAbortFadeSpeed,"AbortMissionFadeOutFinish",nil,{setMute=true,exceptGameStatus=e})
end
function this.OnEndFadeOutMissionAbort()
  e.VarSaveForMissionAbort()
  e.ShowAnnounceLogOnFadeOut(e.LoadForMissionAbort)
end
function this.EstablishedGameOver()
  TppMusicManager.StopJingleEvent()
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
  if#n>0 then
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
    if Tpp.IsTypeNumber(e)then
      TppUiCommand.SeekLoadingTips(tostring(e))
      gvars.continueTipsCount=gvars.continueTipsCount+1
    end
  end
  local n
  if e.systemCallbacks.OnGameOver then
    n=e.systemCallbacks.OnGameOver()
  end
  if not mvars.mis_isGameOverReasonSuicide then
    svars.dialogPlayerDeadCount=svars.dialogPlayerDeadCount+1
  end
  if not n then
    if e.CheckGameOverDemo(TppDefine.GAME_OVER_TYPE.PLAYER_FALL_DEAD)then
      TppPlayer.PlayFallDeadCamera()
      e.ShowGameOverMenu{delayTime=TppPlayer.PLAYER_FALL_DEAD_DELAY_TIME}
    else
      e.ShowGameOverMenu()
    end
  end
end
function this.UpdateAtCanMissionClear(n,o)
  if not n then
    mvars.mis_lastOutSideOfHotZoneButAlert=nil
    c()
    return
  end
  local s=v()
  local i=g()
  local n=not a(vars.playerVehicleGameObjectId)
  if o then
    if i and n then
      c()
      e.ReserveMissionClearOnOutOfHotZone()
    end
  else
    if(s and i)and n then
      if not p"Timer_OutsideOfHotZoneCount"then
        t("Timer_OutsideOfHotZoneCount",y)
      end
    else
      if not s then
        mvars.mis_lastOutSideOfHotZoneButAlert=true
      end
      c()
    end
  end
end
function this.ReserveMissionClearOnOutOfHotZone()
  if e.systemCallbacks.OnOutOfHotZoneMissionClear then
    e.systemCallbacks.OnOutOfHotZoneMissionClear()
    return
  end
  e._ReserveMissionClearOnOutOfHotZone()
end
function this._ReserveMissionClearOnOutOfHotZone()
  if mvars.mis_lastOutSideOfHotZoneButAlert then
    TppRadio.PlayCommonRadio(TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK)
  end
  if TppLocation.IsAfghan()then
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}
  elseif TppLocation.IsMiddleAfrica()then
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE}
  else
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE}
  end
end
function this.ReserveMissionClearOnRideOnHelicopter()
  if TppLocation.IsAfghan()then
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI}
  elseif TppLocation.IsMiddleAfrica()then
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_HELI}
  elseif TppLocation.IsMotherBase()then
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.MTBS_HELI}
  else
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI}
  end
end
function this.ReserveMissionClearOnRideOnFultonContainer()
  if e.systemCallbacks.OnFultonContainerMissionClear then
    e.systemCallbacks.OnFultonContainerMissionClear()
  else
    local n=e.GetCurrentLocationHeliMissionAndLocationCode()
    e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER,nextMissionId=n}
  end
end
function this.AbortMissionByMenu()
  if e.IsFOBMission(vars.missionCode)then
    TppSoundDaemon.PostEvent"env_wormhole_out"
    e.ReserveGameOver(TppDefine.GAME_OVER_TYPE.FOB_ABORT,TppDefine.GAME_OVER_RADIO.OUT_OF_MISSION_AREA)
  else
    if gvars.mis_isStartFromHelispace then
      e.AbortForRideOnHelicopter()
    elseif gvars.mis_isStartFromFreePlay then
      e.AbortForOutOfMissionArea()
    else
      e.AbortForRideOnHelicopter()
    end
  end
end
function this.AbortForOutOfMissionArea(r)
  local n=true
  local o
  local i,a
  local t
  if s(r)then
    if r.isNoSave then
      n=true
    else
      n=false
      i=5.5
      a=TppUI.FADE_SPEED.FADE_HIGHSPEED
      o=TppPlayer.PlayMissionAbortCamera
      t=true
    end
  end
  if TppLocation.IsAfghan()then
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=n,fadeDelayTime=i,fadeSpeed=a,presentationFunction=o,playRadio=t}
  elseif TppLocation.IsMiddleAfrica()then
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_FREE,isNoSave=n,fadeDelayTime=i,fadeSpeed=a,presentationFunction=o,playRadio=t}
  else
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_FREE,isNoSave=n,fadeDelayTime=i,fadeSpeed=a,presentationFunction=o,playRadio=t}
  end
end
function this.AbortForRideOnHelicopter(t)
  local n=true
  local i=false
  if s(t)then
    if t.isNoSave then
      n=true
    else
      n=false
    end
    if t.isAlreadyGameOver then
      i=true
    end
  end
  if TppLocation.IsAfghan()then
    gvars.ini_isTitleMode=false
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI,isNoSave=n,isAlreadyGameOver=i}
  elseif TppLocation.IsMiddleAfrica()then
    gvars.ini_isTitleMode=false
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MAFR_HELI,isNoSave=n,isAlreadyGameOver=i}
  elseif TppLocation.IsMotherBase()then
    gvars.ini_isTitleMode=false
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.MTBS_HELI,isNoSave=n,isAlreadyGameOver=i}
  else
    gvars.ini_isTitleMode=false
    e.AbortMission{nextMissionId=TppDefine.SYS_MISSION_ID.AFGH_HELI,isNoSave=n,isAlreadyGameOver=i}
  end
end
function this.AbortForRideFultonContainer(n)
  e.AbortForRideOnHelicopter{isNoSave=false}
end
function this.GameOverAbortMission()
  if gvars.mis_isStartFromHelispace then
    e.GameOverAbortForRideOnHelicopter()
  elseif gvars.mis_isStartFromFreePlay then
    e.GameOverAbortForOutOfMissionArea()
  else
    e.GameOverAbortForRideOnHelicopter()
  end
  e.ExecuteMissionAbort()
end
function this.GameOverAbortForOutOfMissionArea()
  if TppLocation.IsAfghan()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
  elseif TppLocation.IsMiddleAfrica()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MAFR_FREE
  else
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_FREE
  end
end
function this.GameOverAbortForRideOnHelicopter()
  if TppLocation.IsAfghan()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_HELI
  elseif TppLocation.IsMiddleAfrica()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MAFR_HELI
  elseif TppLocation.IsMotherBase()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MTBS_HELI
  elseif TppLocation.IsMBQF()then
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.MTBS_HELI
  else
    mvars.mis_abortWithSave=false
    mvars.mis_nextMissionCodeForAbort=TppDefine.SYS_MISSION_ID.AFGH_HELI
  end
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
  if n=="mis_fobDefenceGameOver"then
    e.OnChangeFobDefenceGameOver()
  end
  if n=="mis_canMissionClear"then
    if svars.mis_canMissionClear then
      e.OnCanMissionClear()
    end
    if mvars.mis_isAlertOutOfMissionArea then
      e.EnableAlertOutOfMissionArea()
    else
      e.DisableAlertOutOfMissionArea()
    end
    if mvars.mis_isOutsideOfHotZone then
      e.ExitHotZone()
    end
  end
end
function this.PostMissionOrderBoxPositionToBuddyDog()
  if(not e.IsFreeMission(vars.missionCode))then
    if mvars.mis_orderBoxList then
      local n={}
      for s,i in pairs(mvars.mis_orderBoxList)do
        local e,i=e.GetOrderBoxLocatorByTransform(i)
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
function this.SetIsStartFromHelispace()
  gvars.mis_isStartFromHelispace=true
end
function this.ResetIsStartFromHelispace()
  gvars.mis_isStartFromHelispace=false
end
function this.SetIsStartFromFreePlay()
  gvars.mis_isStartFromFreePlay=true
end
function this.ResetIsStartFromFreePlay()
  gvars.mis_isStartFromFreePlay=false
end
function this.CanMissionAbortByMenu()
  if gvars.mis_isStartFromHelispace or gvars.mis_isStartFromFreePlay then
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
  local n=e.FindOrderBoxName(gvars.mis_orderBoxName)
  return e._SetMissionOrderBoxPosition(n)
end
function this._SetMissionOrderBoxPosition(n)
  local e,n=e.GetOrderBoxLocator(n)
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
    if o(e)==n then
      return e
    end
  end
end
function this.GetOrderBoxLocator(e)
  if not l(e)then
    return
  end
  return Tpp.GetLocator("OrderBoxIdentifier",e)
end
function this.GetOrderBoxLocatorByTransform(e)
  if not l(e)then
  end
  return Tpp.GetLocatorByTransform("OrderBoxIdentifier",e)
end
function this.SetFobPlayerStartPoint()
  local n={"Command","Combat","Develop","Support","Medical","Spy","BaseDev"}
  local e=255
  if not MotherBaseStage.GetFirstCluster then
    e=MotherBaseStage.GetCurrentCluster()
  else
    e=MotherBaseStage.GetFirstCluster()
  end
  local i=n[e+1]
  local n=TppMotherBaseManagement.GetMbsClusterGrade{category=i}
  if TppMotherBaseManagement.GetMbsClusterBuildStatus{category=i}~="Completed"then
    n=n-1
  end
  local n=n-1
  if n<0 then
    return false
  end
  local n=""
  if TppNetworkUtil.IsHost()==false then
    n="player_locator_clst"..(e.."_plnt0_df0")
    local e,n=Tpp.GetLocator("MtbsStartPointIdentifier",n)
    if e then
      TppPlayer.SetInitialPosition(e,n)
      return true
    end
    return false
  end
end
function this.IsNeedSetMissionStartPositionToClusterPosition()
  if gvars.forcePlayerPositionDemoCenter then
    gvars.forcePlayerPositionDemoCenter=false
    return true
  end
  if not TppLocation.IsMotherBase()then
    return false
  end
  if e.IsSysMissionId(vars.missionCode)then
    return false
  end
  if TppPackList.GetLocationNameFormMissionCode(vars.missionCode)=="MTBS"then
    return false
  else
    return true
  end
end
function this.ReserveForcePlayerPositionToMbDemoCenter()
  gvars.forcePlayerPositionDemoCenter=true
end
function this.SetMissionStartPositionMtbsClusterPosition()
  if mtbs_cluster==nil then
    return
  end
  local e=MotherBaseStage.GetFirstCluster()
  local n=mtbs_cluster.GetClusterName(MotherBaseStage.GetFirstCluster()+1)
  local e=MotherBaseStage.GetDemoCenter(e)
  local e=TppMath.Vector3toTable(e)
  TppPlayer.SetInitialPosition(e,0)
end
function this.EstablishedMissionClear()
  DemoDaemon.StopAll()
  GkEventTimerManager.StopAll()
  if Tpp.IsHorse(vars.playerVehicleGameObjectId)then
    GameObject.SendCommand(vars.playerVehicleGameObjectId,{id="HorseForceStop"})
  end
  e.SeizeReliefVehicleOnClear()
  vars.playerDisableActionFlag=PlayerDisableAction.SUBJECTIVE_CAMERA
  TppHero.SetFirstMissionClearHeroPoint()
  if e.systemCallbacks.OnSetMissionFinalScore then
    e.systemCallbacks.OnSetMissionFinalScore(svars.mis_missionClearType)
  end
  e.SetMissionClearState(TppDefine.MISSION_CLEAR_STATE.ESTABLISHED_CLEAR)
  if(svars.mis_missionClearType==TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER)then
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"EstablishedMissionClearOnRideOnFultonContainer",nil,{exceptGameStatus={AnnounceLog="SUSPEND_LOG"}})
  end
  e.systemCallbacks.OnEstablishMissionClear(svars.mis_missionClearType)
end
function this.OnMissionGameEndFadeOutFinish()
  local n=e.IsHelicopterSpace(gvars.mis_nextMissionCodeForMissionClear)
  if not n then
    e.ReserveMissionStartRecoverSoundDemo()
  else
    e.ClearMissionStartRecoverSoundDemo()
  end
  TppEnemy.FultonRecoverOnMissionGameEnd()
  TppPlayer.SaveCaptureAnimal()
  TppTerminal.AddVolunteerStaffs()
  if Player.CallRemovingChickenCapSE~=nil then
    Player.CallRemovingChickenCapSE()
  end
  if e.systemCallbacks.OnMissionGameEndFadeOutFinish then
    e.systemCallbacks.OnMissionGameEndFadeOutFinish()
  end
  if(mvars.mis_missionGameEndDelayTime>.1)then
    t("Timer_MissionGameEndStart",mvars.mis_missionGameEndDelayTime)
  else
    t("Timer_MissionGameEndStart",.1)
  end
end
function this.OnMissionGameEndFadeOutFinish2nd()
  TppUiStatusManager.ClearStatus"GmpInfo"
  TppStory.UpdateStorySequence{updateTiming="OnMissionClear",missionId=e.GetMissionID()}
  TppResult.SetMissionFinalScore()
  e.KillDyingQuiet()
  TppTrophy.UnlockOnBuddyFriendlyMax()
  TppTrophy.UnlockOnAllMissionTaskCompleted()
  local a,o,n,i,s,r=TppStory.CheckAllMissionCleared()
  if a then
    TppStory.CompleteAllMissionCleared()
    TppTrophy.Unlock(12)
  end
  if o then
    TppStory.CompleteAllMissionSRankCleared()
    TppTrophy.Unlock(14)
  end
  if n then
    TppStory.CompleteAllNormalMissionCleared()
    TppEmblem.AcquireOnAllMissionCleared()
  end
  if i then
    TppStory.CompleteAllNormalMissionSRankCleared()
    TppEmblem.AcquireOnAllMissionSRankCleared()
  end
  if s then
    TppStory.CompleteAllHardMissionCleared()
  end
  if r then
    TppStory.CompleteAllHardMissionSRankCleared()
  end
  if vars.totalMarkingCount>=750 then
    TppTerminal.AcquireKeyItem{dataBaseId=TppMotherBaseManagementConst.DESIGN_3020,pushReward=true}
  end
  if TppBuddyService.CanSortieBuddyType(BuddyType.DOG)then
    TppTrophy.Unlock(24,1e3,-1e3)
  end
  if TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)then
    TppTrophy.Unlock(25,1e3,-1e3)
  end
  if TppUiCommand.CheckMbTopMenuDHorseCustomizeOpen~=nil then
    if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.HORSE)>=100 then
      if TppUiCommand.CheckMbTopMenuDHorseCustomizeOpen()==false then
        TppUiCommand.SetMbTopMenuDHorseCustomizeOpen(true)
        e._PushReward(TppScriptVars.CATEGORY_MB_MANAGEMENT,"reward_403",TppReward.TYPE.COMMON)
      end
    end
    if TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.DOG)>=100 then
      if TppUiCommand.CheckMbTopMenuDDogCustomizeOpen()==false then
        TppUiCommand.SetMbTopMenuDDogCustomizeOpen(true)
        e._PushReward(TppScriptVars.CATEGORY_MB_MANAGEMENT,"reward_404",TppReward.TYPE.COMMON)
      end
    end
  end
  TppQuest.OnMissionGameEnd()
  TppTerminal.OnEstablishMissionClear()
  TppTerminal.PushRewardOnMbSectionOpen()
  TppHero.UpdateHero()
  TppCassette.OnEstablishMissionClear()
  TppRanking.UpdateOpenRanking()
  local n=TppMotherBaseManagement.GetResourceUsableCount{resource="NuclearWaste"}
  TppRanking.UpdateScore("NuclearDisposeCount",n)
  TppRanking.SendCurrentRankingScore()do
    local n=e.GetMissionID()
    if(not e.IsFOBMission(n)and not e.IsFreeMission(n))and not e.IsHelicopterSpace(n)then
      TppRevenge.ReduceRevengePointOnMissionClear(n)
    end
  end
  TppTutorial.OpenTipsOnCurrentStory()
  if gvars.usingNormalMissionSlot then
    TppStory.FailedRetakeThePlatformIfOpened()
  end
  local n=e.GetMissionClearType()
  if(n==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO)or(n==TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_NO_ORDER_BOX)then
    TppUiCommand.LoadoutSetMissionRecieveFromFreeToMission()
  end
  TppHero.AnnounceFirstMissionClearHeroPoint()
  TppPlayer.AggregateCaptureAnimal()
  if not e.IsHelicopterSpace(e.GetMissionID())then
    TppTerminal.AddStaffsFromTempBuffer()
  end
  e.ExecuteVehicleSaveCarryOnClear()
  e.ForceGoToMbFreeIfExistMbDemo()
  if not e.IsFOBMission(gvars.mis_nextMissionCodeForMissionClear)then
    TppSave.VarSave()
  end
  t("Timer_MissionGameEndStart2nd",.1)
end
function this.SetMissionObjectives(i,n,e)
  mvars.mis_missionObjectiveDefine=i
  mvars.mis_missionObjectiveTree=n
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
  if#mvars.mis_missionObjectiveEnum>_ then
    return
  end
end
function this.OnFinishUpdateObjectiveRadio(n)
  if n==o(mvars.mis_updateObjectiveRadioGroupName)then
    e.ShowUpdateObjective(mvars.mis_objectiveSetting)
  end
end
function this.ShowUpdateObjective(n)
  if not s(n)then
    return
  end
  local i={}
  for n,s in pairs(n)do
    local n=mvars.mis_missionObjectiveDefine[s]
    local t=not e.IsEnableMissionObjective(s)
    if t then
      t=(not e.IsEnableAnyParentMissionObjective(s))
    end
    if n.packLabel then
      if not TppPackList.IsMissionPackLabelList(n.packLabel)then
        t=false
      end
    end
    if n and t then
      e.DisableChildrenObjective(s)
      e._ShowObjective(n,true)
      local t={isMissionAnnounce=false,subGoalId=nil}
      if n.announceLog then
        t.isMissionAnnounce=true
        if n.subGoalId then
          t.subGoalId=n.subGoalId
        end
        i[n.announceLog]=t
      end
      e.SetMissionObjectiveEnable(s,true)
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
  mvars.mis_updateObjectiveOnHelicopterStart=nil
end
function this._ShowObjective(e,s)
  if e.packLabel then
    if not TppPackList.IsMissionPackLabelList(e.packLabel)then
      return
    end
  end
  if e.setInterrogation==nil then
    e.setInterrogation=true
  end
  if e.gameObjectName then
    TppMarker.Enable(e.gameObjectName,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.mapRadioName,e.langId,e.goalLangId,e.setInterrogation)
  end
  if e.gimmickId then
    local i,n=TppGimmick.GetGameObjectId(e.gimmickId)
    if i then
      TppMarker.Enable(n,e.visibleArea,e.goalType,e.viewType,e.randomRange,e.setImportant,e.setNew,e.mapRadioName,e.langId,e.goalLangId,e.setInterrogation)
    end
  end
  if e.photoId then
    TppUI.EnableMissionPhoto(e.photoId,e.addFirst,e.addSecond,e.isComplete,e.photoRadioName)
  end
  if e.hudPhotoId then
    TppUiCommand.ShowPictureInfoHud(e.hudPhotoId,1,3)
  end
  if e.subGoalId then
    TppUI.EnableMissionSubGoal(e.subGoalId)
    if e.subGoalId>0 then
      if not e.announceLog then
        e.announceLog="updateMissionInfo"
      end
    end
  end
  if e.showEnemyRoutePoints then
    if TppUiCommand.ShowEnemyRoutePoints then
      local n=e.showEnemyRoutePoints.radioGroupName
      if l(n)then
        e.showEnemyRoutePoints.radioGroupName=o(n)
      end
      TppUiCommand.ShowEnemyRoutePoints(e.showEnemyRoutePoints)
    end
  end
  if e.targetBgmCp then
    TppEnemy.LetCpHasTarget(e.targetBgmCp,true)
  end
  if e.missionTask then
    TppUI.EnableMissionTask(e.missionTask,s)
  end
  if e.spySearch then
    TppUI.EnableSpySearch(e.spySearch)
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
        e.DisableObjective(n)
      end
    end
  end
  for i,n in ipairs(mvars.mis_missionObjectiveEnum)do
    if svars.mis_objectiveEnable[i]then
      local n=mvars.mis_missionObjectiveDefine[n]
      if n then
        e._ShowObjective(n,false)
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
    if e.IsEnableMissionObjective(n)then
      return true
    else
      i=e.IsEnableAnyParentMissionObjective(n)
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
      e.SetMissionObjectiveEnable(i,false)
      e.DisableObjective(n)
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
    local n,i=TppGimmick.GetGameObjectId(e.gimmickId)
    if n then
      TppMarker.Disable(i,e.mapRadioName)
    end
  end
  if e.photoId then
    TppUI.DisableMissionPhoto(e.photoId,e.photoRadioName)
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
  if e.spySearch then
    TppUI.DisableSpySearch(e.spySearch)
  end
end
function this.VarSaveOnUpdateCheckPoint(n)
  gvars.isNewGame=false
  TppTerminal.OnRecoverByHelicopterOnCheckPoint()
  TppTerminal.AddStaffsFromTempBuffer(true)
  TppSave.ReserveVarRestoreForContinue()
  if TppSystemUtility.GetCurrentGameMode()=="TPP"then
    TppEnemy.StoreSVars()
  end
  TppWeather.StoreToSVars()
  TppMarker.StoreMarkerLocator()
  TppPlayer.StoreSupplyCbox()
  TppPlayer.StoreSupportAttack()
  TppPlayer.StorePlayerDecoyInfos()
  if not Tpp.IsHelicopter(vars.playerVehicleGameObjectId)then
    svars.ply_isUsedPlayerInitialAction=true
  end
  TppRadioCommand.StoreRadioState()
  if Gimmick.StoreSaveDataPermanentGimmickFromCheckPoint then
    Gimmick.StoreSaveDataPermanentGimmickFromCheckPoint()
  end
  TppSave.VarSave(vars.missionCode)
  if vars.missionCode==10115 then
    return
  end
  if not n then
    TppSave.SaveGameData()
    e.CreateMbSaveCoroutine()
  end
end
function this.SafeStopSettingOnMissionReload(n)
  local e
  if n and n.setMute then
    e=n.setMute
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
  if e then
    TppSoundDaemon.SetMute(e)
  else
    TppSound.SetMuteOnLoading()
  end
  TppOutOfMissionRangeEffect.Disable(1)
  TppTerminal.PlayTerminalVoice("VOICE_WARN_MISSION_AREA",false)
end
function this.VarResetOnNewMission()
  TppScriptVars.InitForNewMission()
  TppCheckPoint.Reset()
  TppQuest.ResetQuestStatus()
  TppPackList.SetDefaultMissionPackLabelName()
  TppPlayer.UnsetRetryFlag()
  if GameConfig.GetStealthAssistEnabled()then
    mvars.mis_needSaveConfigOnNewMission=true
    GameConfig.SetStealthAssistEnabled(false)
  end
  TppPlayer.ResetStealthAssistCount()
  TppSave.ReserveVarRestoreForMissionStart()
  TppResult.ClearNewestPlayStyleHistory()
  e.SetNextMissionCodeForMissionClear(u)
  e.ResetMissionClearState()
end
function this.GetCurrentLocationHeliMissionAndLocationCode()
  if TppLocation.IsAfghan()then
    return TppDefine.SYS_MISSION_ID.AFGH_HELI,TppDefine.LOCATION_ID.AFGH
  elseif TppLocation.IsMiddleAfrica()then
    return TppDefine.SYS_MISSION_ID.MAFR_HELI,TppDefine.LOCATION_ID.MAFR
  elseif TppLocation.IsMotherBase()then
    return TppDefine.SYS_MISSION_ID.MTBS_HELI,TppDefine.LOCATION_ID.MTBS
  elseif TppLocation.IsMBQF()then
    return TppDefine.SYS_MISSION_ID.MTBS_HELI,TppDefine.LOCATION_ID.MTBS
  else
    return TppDefine.SYS_MISSION_ID.AFGH_HELI,TppDefine.LOCATION_ID.AFGH
  end
end
function this.ResetEmegerncyMissionSetting()
  gvars.usingNormalMissionSlot=true
  gvars.mis_nextMissionCodeForEmergency=0
  gvars.mis_nextLayoutCodeForEmergency=TppDefine.INVALID_LAYOUT_CODE
  gvars.mis_nextClusterIdForEmergency=TppDefine.INVALID_CLUSTER_ID
  gvars.mis_nextMissionStartRouteForEmergency=0
  vars.returnStaffHeader=0
  vars.returnStaffSeeds=0
end
function this.GoToEmergencyMission()
  local i=gvars.mis_nextMissionCodeForEmergency
  local s
  if i~=TppDefine.SYS_MISSION_ID.FOB then
    if gvars.mis_nextMissionStartRouteForEmergency~=0 then
      s=gvars.mis_nextMissionStartRouteForEmergency
    else
      return
    end
  end
  local n
  if gvars.mis_nextLayoutCodeForEmergency~=TppDefine.INVALID_LAYOUT_CODE then
    n=gvars.mis_nextLayoutCodeForEmergency
  else
    n=TppDefine.STORY_MISSION_LAYOUT_CODE[missionCode]or TppDefine.OFFLINE_MOHTER_BASE_LAYOUT_CODE
  end
  local t=2
  if gvars.mis_nextClusterIdForEmergency~=TppDefine.INVALID_CLUSTER_ID then
    t=gvars.mis_nextClusterIdForEmergency
  end
  e.ReserveMissionClear{missionClearType=TppDefine.MISSION_CLEAR_TYPE.FROM_HELISPACE,nextMissionId=i,nextHeliRoute=s,nextLayoutCode=n,nextClusterId=t}
end
function this.RequestLoad(n,i,e)
  if not mvars then
    return
  end
  TppMain.EnablePause()
  mvars.mis_loadRequest={nextMission=n,currentMission=i,options=e}
end
function this.LoadWithChunkCheck()
  local t,i,n=mvars.mis_loadRequest.nextMission,mvars.mis_loadRequest.currentMission,mvars.mis_loadRequest.options
  local s=Tpp.GetChunkIndex(vars.locationCode)
  if e.IsChunkLoading(s)then
    return
  end
  e.Load(t,i,n)
  mvars.mis_loadRequest=nil
end
function this.IsChunkLoading(e)
  if Chunk.GetChunkState(e)==Chunk.STATE_INSTALLED then
    if mvars.mis_isChunkLoading then
      Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
      mvars.mis_isChunkLoading=false
    end
    if TppUiCommand.IsShowPopup(TppDefine.ERROR_ID.NOW_INSTALLING)then
      TppUiCommand.ErasePopup()
    end
    return false
  end
  if not mvars.mis_isChunkLoading then
    Chunk.PrefetchChunk(e)Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
    mvars.mis_isChunkLoading=true
  end
  if SplashScreen.GetSplashScreenWithName"konamiLogo"then
    return true
  end
  if SplashScreen.GetSplashScreenWithName"kjpLogo"then
    return true
  end
  if SplashScreen.GetSplashScreenWithName"foxLogo"then
    return true
  end
  Tpp.ShowChunkInstallingPopup(e,false)
  return true
end
function this.Load(n,i,e)
  local s
  if(e and e.showLoadingTips~=nil)then
    s=e.showLoadingTips
  else
    s=true
  end
  if(e and e.waitOnLoadingTipsEnd~=nil)then
    gvars.waitLoadingTipsEnd=e.waitOnLoadingTipsEnd
  else
    gvars.waitLoadingTipsEnd=true
  end
  TppMain.EnablePause()
  TppMain.EnableBlackLoading(s)
  if not TppEnemy.IsLoadedDefaultSoldier2CommonPackage()then
    TppEnemy.UnloadSoldier2CommonBlock()
  end
  if(i~=n)or(e and e.force)then
    local o=TppPackList.GetLocationNameFormMissionCode(n)
    local t=TppPackList.GetLocationNameFormMissionCode(i)
    local s
    if o=="MTBS"and t=="MTBS"then
      if n~=TppDefine.SYS_MISSION_ID.MTBS_HELI then
        if not(e and e.ignoreMtbsLoadLocationForce)then
          s={force=true}
        end
      end
    end
    if TppLocation.IsMotherBase()then
      local s=TppLocation.ApplyPlatformParamToMbStage(n,"MotherBase")
      local e=TppDefine.STORY_MISSION_LAYOUT_CODE[n]
      if e then
        if i==nil and n==30050 then
        else
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(e)
        end
      else
        if s then
          vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(TppMotherBaseManagement.GetMbsTopologyType())
        end
      end
    end
    if TppSystemUtility.GetCurrentGameMode()=="TPP"then
      TppEneFova.InitializeUniqueSetting()
      TppEnemy.PreMissionLoad(n,i)
    end
    Mission.LoadLocation(s)Mission.LoadMission(e)
  else
    Mission.RequestToReload()
  end
  TppUI.ShowAccessIcon()
end
function this.ExecuteReload()
  if mvars.mis_nextLocationCode then
    vars.locationCode=mvars.mis_nextLocationCode
  end
  if mvars.mis_nextLayoutCode then
    vars.mbLayoutCode=TppLocation.ModifyMbsLayoutCode(mvars.mis_nextLayoutCode)
  end
  if mvars.mis_nextClusterId then
    vars.mbClusterId=mvars.mis_nextClusterId
  end
  e.SafeStopSettingOnMissionReload()
  TppPackList.SetMissionPackLabelName(mvars.mis_missionPackLabelName)
  TppPlayer.ForceSetAllInitialWeapon()
  TppSave.VarSave()
  TppSave.CheckAndSavePersonalData()
  e.RequestLoad(vars.missionCode,nil,{force=true,showLoadingTips=mvars.mis_showLoadingTipsOnReload,ignoreMtbsLoadLocationForce=mvars.mis_ignoreMtbsLoadLocationForce})
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
end
function this.GetNextMissionCodeForMissionClear()
  return gvars.mis_nextMissionCodeForMissionClear
end
function this.AlwaysMissionCanStart()
  mvars.mis_alwaysMissionCanStart=true
end
function this.KillDyingQuiet()
  if TppBuddyService.BuddyProcessMissionEnd then
    TppBuddyService.BuddyProcessMissionEnd()
  else
    if TppBuddyService.IsQuietDeadFromDying and TppBuddyService.IsQuietDeadFromDying()then
      TppBuddyService.QuietDyingToDead()
    end
  end
end
function this.SetSortieBuddy()
  if TppDemo.IsPlayedMBEventDemo"DdogGoWithMe"then
    TppBuddyService.SetSortieBuddyType(BuddyType.DOG)
  end
  if TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
  else
    if TppQuest.IsCleard"mtbs_q99011"then
      if TppBuddyService.DidObtainBuddyType(BuddyType.QUIET)then
        if not TppBuddyService.CanSortieBuddyType(BuddyType.QUIET)then
          TppStory.StartElapsedMissionEvent(TppDefine.ELAPSED_MISSION_EVENT.QUIET_WITH_GO_MISSION,TppDefine.INIT_ELAPSED_MISSION_COUNT.QUIET_WITH_GO_MISSION)
        end
        TppBuddyService.SetSortieBuddyType(BuddyType.QUIET)
      end
    end
  end
end
local n={[30050]=true,[50050]=true}
local i={[TppDefine.MISSION_CLEAR_TYPE.ON_FOOT]=true,[TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER]=true,[TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_VEHILCE]=true,[TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_FULTON_CONTAINER]=true}
function this.ForceGoToMbFreeIfExistMbDemo()
  if n[vars.missionCode]then
    return
  end
  local n=e.GetMissionClearType()
  if not i[n]then
    return
  end
  local n=TppStory.GetForceMBDemoNameOrRadioList"forceMBDemo"
  if n then
    TppDemo.SetNextMBDemo(n)
    if TppDefine.MB_FREEPLAY_RIDEONHELI_DEMO_DEFINE[n]~=nil then
      e.SetNextMissionStartHeliRoute"ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"
    end
    e.SetNextMissionCodeForMissionClear(TppDefine.SYS_MISSION_ID.MTBS_FREE)
    e.SeizeReliefVehicleOnForceGoToMb()
  end
  local n=TppStory.GetForceMBDemoNameOrRadioList("blackTelephone",{demoName=n})
  if n then
    TppRadio.SaveRewardEndRadioList(n)
    if n[1]=="f6000_rtrg0310"then
      e.SetNextMissionCodeForMissionClear(TppDefine.SYS_MISSION_ID.MAFR_HELI)
    else
      e.SetNextMissionCodeForMissionClear(TppDefine.SYS_MISSION_ID.MTBS_FREE)
    end
  end
end
function this.ResetMBFreeStartPositionToCommand()
  TppHelicopter.ResetMissionStartHelicopterRoute()
  TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
  TppPlayer.ResetInitialPosition()
  TppPlayer.ResetMissionStartPosition()
  TppPlayer.ResetNoOrderBoxMissionStartPosition()
  e.ResetIsStartFromHelispace()
  e.ResetIsStartFromFreePlay()
  vars.mbClusterId=TppDefine.CLUSTER_DEFINE.Command
end
function this.SetNextMissionStartHeliRoute(e)
  mvars.heli_missionStartRoute=e
end
function this.ClearFobMode()
  vars.fobSneakMode=FobMode.MODE_NONE
end
function this.UnsetFobSneakFlag(n)
  if not e.IsFOBMission(n)then
    if TppServerManager.FobIsSneak()then
      vars.fobIsSneak=0
    end
  end
end
function this.StartHelicopterDoorOpenTimer()
  local e=mvars.mis_helicopterDoorOpenTimerTimeSec
  GameObject.SendCommand({type="TppHeli2",index=0},{id="SetSendDoorOpenManually",enabled=true})
  t("Timer_MissionStartHeliDoorOpen",e)
end
function this.GetObjectiveRadioOption(n)
  local e={}
  if s(n.radioOptions)then
    for n,i in pairs(n.radioOptions)do
      e[n]=i
    end
  end
  if FadeFunction.IsFadeProcessing()then
    local n=e.delayTime
    local i=TppUI.FADE_SPEED.FADE_NORMALSPEED+1.2
    if l(n)then
      e.delayTime=TppRadio.PRESET_DELAY_TIME[n]+i
    elseif m(n)then
      e.delayTime=n+i
    else
      e.delayTime=i
    end
  end
  return e
end
function this.OnMissionStart()
  if e.IsMissionStart()then
    gvars.mis_quietCallCountOnMissionStart=vars.buddyCallCount[BuddyType.QUIET]
    if vars.buddyType==BuddyType.QUIET then
      gvars.mis_quietCallCountOnMissionStart=gvars.mis_quietCallCountOnMissionStart-1
    end
  end
  --[[if this.IsManualSubsistenceMission() then--tex force sieze vehicle on subs mission start. Pulls vehicle fine, but doesn't credit to motherbase. CULL: RETRY: DOC: force no vehicle drop
    this.SeizeReliefVehicleOnClear()  
  end--]]
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
  local n,e=e.ParseMissionName(e.GetMissionName())
  if(e=="free"or e=="heli")then
    if gvars.mis_isExistOpenMissionFlag then
      TppUI.ShowAnnounceLog"missionListUpdate"
      TppUI.ShowAnnounceLog"missionAdd"
      gvars.mis_isExistOpenMissionFlag=false
    end
    TppQuest.ShowAnnounceLogQuestOpen()
  end
end
function this._CreateMissionName(i)
  local n=string.sub(tostring(i),1,1)
  local e
  if(n=="1")then
    e="s"
  elseif(n=="2")then
    e="e"
  elseif(n=="3")then
    e="f"
  elseif(n=="4")then
    e="h"
  elseif(n=="5")then
    e="o"
  else
    return nil
  end
  return e..tostring(i)
end
function this._PushReward(e,i,n)
  TppReward.Push{category=e,langId=i,rewardType=n}
end
return this
