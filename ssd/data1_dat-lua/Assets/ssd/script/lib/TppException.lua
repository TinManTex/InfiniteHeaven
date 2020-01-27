local this={}
this.MGO_INVITATION_CANCEL_POPUP_ID=5010
this.CLOSE_INIVITATION_CANCEL_POPUP_INTERVAL=1.5
this.PROCESS_STATE=Tpp.Enum{"EMPTY","START","SHOW_DIALOG","SUSPEND","FINISH"}
this.TYPE=Tpp.Enum{
  "INVITATION_ACCEPT",
  "DISCONNECT_FROM_PSN",
  "DISCONNECT_FROM_KONAMI",
  "DISCONNECT_FROM_NETWORK",
  "SESSION_DISCONNECT_FROM_HOST",
  "SESSION_JOIN_FAILED",
  "SIGNIN_USER_CHANGED",
  "INVITATION_PATCH_DLC_CHECKING",
  "INVITATION_PATCH_DLC_ERROR",
  "INVITATION_ACCEPT_BY_OTHER",
  "INVITATION_ACCEPT_WITHOUT_SIGNIN",
  "WAIT_MGO_CHUNK_INSTALLATION"
}
this.GAME_MODE=Tpp.Enum{"TPP","TPP_FOB","MGO"}
this.TYPE_DISCONNECT_NETWORK_LIST={"DISCONNECT_FROM_PSN","DISCONNECT_FROM_KONAMI","DISCONNECT_FROM_NETWORK"}
this.TYPE_DISCONNECT_P2P_LIST={"SESSION_DISCONNECT_FROM_HOST","SESSION_JOIN_FAILED"}
this.OnEndExceptionDialog={}
this.mgoInvitationUpdateCount=0
this.fadingCountForDisconnection=0
function this.IsDisabledMgoInChinaKorea()
  if(TppGameSequence.GetShortTargetArea()=="ck")then
    if(not TppGameSequence.IsMgoEnabled())then
      return true
    end
  end
  return false
end
this.SHOW_EXECPTION_DIALOG={
  [this.TYPE.INVITATION_ACCEPT]=function()
    this.mgoInvitationUpdateCount=0
    this.mgoInvitationPopupId=nil
    if this.IsDisabledMgoInChinaKorea()then
      return 5013
    elseif TppStory.CanPlayMgo()then
      if this.GetCurrentGameMode()==this.GAME_MODE.TPP_FOB then
        this.mgoInvitationPopupId=this.MGO_INVITATION_CANCEL_POPUP_ID
        return this.MGO_INVITATION_CANCEL_POPUP_ID
      else
        return 5001,Popup.TYPE_TWO_BUTTON,nil,true
      end
    else
      return 5004
    end
  end,
  [this.TYPE.DISCONNECT_FROM_PSN]=function()
    return TppDefine.ERROR_ID.DISCONNECT_FROM_PSN
  end,
  [this.TYPE.DISCONNECT_FROM_KONAMI]=function()
    return TppDefine.ERROR_ID.DISCONNECT_FROM_KONAMI
  end,
  [this.TYPE.DISCONNECT_FROM_NETWORK]=function()
    return TppDefine.ERROR_ID.DISCONNECT_FROM_NETWORK
  end,
  [this.TYPE.SESSION_DISCONNECT_FROM_HOST]=function()
    if this.GetCurrentGameMode()=="TPP"then
      return TppDefine.ERROR_ID.DISCONNECT_FROM_NETWORK
    end
    return TppDefine.ERROR_ID.SESSION_ABANDON
  end,
  [this.TYPE.SESSION_JOIN_FAILED]=function()
    return TppDefine.ERROR_ID.FAILED_JOIN_SESSION
  end,
  [this.TYPE.SIGNIN_USER_CHANGED]=function()
    return TppDefine.ERROR_ID.SIGNIN_USER_CHANGED
  end,
  [this.TYPE.INVITATION_PATCH_DLC_CHECKING]=function()
    return 5100,false,"POPUP_TYPE_NO_BUTTON_NO_EFFECT",nil
  end,
  [this.TYPE.INVITATION_PATCH_DLC_ERROR]=function()
    return 5103
  end,
  [this.TYPE.INVITATION_ACCEPT_BY_OTHER]=function()
    return 5005
  end,
  [this.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=function()
    return 5012
  end,
  [this.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=function()
    return TppDefine.ERROR_ID.NOW_INSTALLING,Popup.TYPE_ONE_CANCEL_BUTTON
  end
}
function this.NoProcessOnEndExceptionDialog()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if not Tpp.IsMaster()then
    local exceptionType=this.TYPE[gvars.exc_processingExecptionType]
    local gameMode=this.GetCurrentGameMode()
    local gameType=this.GAME_MODE[gameMode]
  end
  return this.PROCESS_STATE.FINISH
end
function this.OnEndExceptionForDisconnectDialog()
  local missionCode=vars.missionCode
  if missionCode==TppDefine.SYS_MISSION_ID.INIT then
    return this.PROCESS_STATE.FINISH
  end
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if TppSave.IsSaving()then
    return this.PROCESS_STATE.SUSPEND
  end
  if this.fadingCountForDisconnection==0 then
    TppUI.SetFadeColorToBlack()
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForDisconnect",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
  end
  this.fadingCountForDisconnection=this.fadingCountForDisconnection+1
  if this.fadingCountForDisconnection<3 then
    return this.PROCESS_STATE.SUSPEND
  end
  FadeFunction.SetFadeCallEnable(false)
  TppVideoPlayer.StopVideo()
  TppUI.FinishLoadingTips()
  SsdUiSystem.RequestForceClose()
  SignIn.SetStartupProcessCompleted(false)
  SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
  TppRadio.StopForException()
  TppMusicManager.StopMusicPlayer(1)
  TppMusicManager.EndSceneMode()
  TppRadioCommand.SetEnableIgnoreGamePause(false)
  GkEventTimerManager.StopAll()
  StageBlockCurrentPositionSetter.SetEnable(false)
  TppQuest.OnMissionGameEnd()
  SsdFlagMission.OnMissionGameEnd()
  SsdBaseDefense.OnMissionGameEnd()
  TppScriptBlock.UnloadAll()
  Mission.AddFinalizer(function()
    TppMission.DisablePauseForShowResult()
    FadeFunction.SetFadeCallEnable(true)
    TppUI.SetFadeColorToBlack()
    gvars.waitLoadingTipsEnd=false
  end)
  TppSimpleGameSequenceSystem.Start()
  TppMission.ReturnToTitleForException()
  return this.PROCESS_STATE.FINISH
end
function this.CanExceptionHandlingForFromHost()
  if not gvars.canExceptionHandling then
    return false
  end
  return true
end
function this.OnEndExceptionForFromHost()
  if not this.CanExceptionHandlingForFromHost()then
    return this.PROCESS_STATE.SUSPEND
  end
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    local e=TppNetworkUtil.IsHost()
    if e then
      TppMission.AbandonMission()
    else
      if Mission.IsHostMigrationActive()then
      else
        TppMission.AbandonMission()
      end
    end
  end
  TppMission.SetInvitationStart(false)
  return this.PROCESS_STATE.FINISH
end
function this.OnEndExceptionDialogForSignInUserChange()
  if not TppSequence.CanHandleSignInUserChangedException()then
    return this.PROCESS_STATE.FINISH
  end
  TppUI.FinishLoadingTips()
  TppRadio.playingBlackTelInfo=nil
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if TppSave.IsSaving()then
    return this.PROCESS_STATE.SUSPEND
  end
  if TppUiCommand.IsShowPopup()then
    TppUiCommand.ErasePopup()
  end
  if this.fadingCountForDisconnection==0 then
    TppUI.SetFadeColorToBlack()
    TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
  end
  this.fadingCountForDisconnection=this.fadingCountForDisconnection+1
  if this.fadingCountForDisconnection<3 then
    return this.PROCESS_STATE.SUSPEND
  end
  FadeFunction.SetFadeCallEnable(false)
  TppVideoPlayer.StopVideo()
  if not Tpp.IsMaster()then
    gvars.dbg_forceMaster=true
  end
  gvars.isLoadedInitMissionOnSignInUserChanged=true
  SignIn.SetStartupProcessCompleted(false)
  TppUiCommand.SetLoadIndicatorVisible(true)
  SsdUiSystem.RequestForceClose()
  StageBlockCurrentPositionSetter.SetEnable(false)
  SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
  TppRadio.Stop()
  TppMusicManager.StopMusicPlayer(1)
  TppMusicManager.EndSceneMode()
  TppRadioCommand.SetEnableIgnoreGamePause(false)
  GkEventTimerManager.StopAll()
  TppQuest.OnMissionGameEnd()
  SsdFlagMission.OnMissionGameEnd()
  SsdBaseDefense.OnMissionGameEnd()
  TppScriptBlock.UnloadAll()
  Mission.AddFinalizer(function()
    this.waitPatchDlcCheckCoroutine=nil
    TppSave.missionStartSaveFilePool=nil
    TppMission.DisablePauseForShowResult()
    FadeFunction.SetFadeCallEnable(true)
    TppUI.SetFadeColorToBlack()
    gvars.isLoadedInitMissionOnSignInUserChanged=false
    gvars.waitLoadingTipsEnd=false
  end)
  TppVarInit.StartInitMission()
  return this.PROCESS_STATE.FINISH
end
function this.UpdateMgoInvitationAccept()
  if(this.currentErrorPopupLangId==this.MGO_INVITATION_CANCEL_POPUP_ID)then
    this.mgoInvitationUpdateCount=this.mgoInvitationUpdateCount+Time.GetFrameTime()
    if this.mgoInvitationUpdateCount>this.CLOSE_INIVITATION_CANCEL_POPUP_INTERVAL then
      TppUiCommand.ErasePopup()
    end
  end
end
function this.OnEndExceptionDialogForMgoInvitationAccept()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if this.IsDisabledMgoInChinaKorea()then
    this.CancelMgoInvitation()
    return this.PROCESS_STATE.FINISH
  end
  if not TppStory.CanPlayMgo()then
    this.CancelMgoInvitation()
    return this.PROCESS_STATE.FINISH
  end
  if(this.mgoInvitationPopupId==this.MGO_INVITATION_CANCEL_POPUP_ID)then
    this.CancelMgoInvitation()
    return this.PROCESS_STATE.FINISH
  end
  if TppSave.IsSaving()then
    if DebugText then
      local context=DebugText.NewContext()
      DebugText.Print(context,{.5,.5,1},"TppException : Wating saving process.")
    end
    return this.PROCESS_STATE.SUSPEND
  end
  local popupType=TppUiCommand.GetPopupSelect()
  if popupType==Popup.SELECT_OK then
    PatchDlc.StartCheckingPatchDlc()
    if PatchDlc.IsCheckingPatchDlc()then
      local gameMode=this.GetCurrentGameMode()
      this.Enqueue(this.TYPE.INVITATION_PATCH_DLC_CHECKING,gameMode)
    else
      if PatchDlc.DoesExistPatchDlc()then
        this.CheckMgoChunkInstallation()
      else
        local gameMode=this.GetCurrentGameMode()
        this.Enqueue(this.TYPE.INVITATION_PATCH_DLC_ERROR,gameMode)
      end
    end
  else
    this.CancelMgoInvitation()
  end
  return this.PROCESS_STATE.FINISH
end
function this.OnEndExceptionDialogForPatchDlcCheck()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if TppSave.IsSaving()then
    return this.PROCESS_STATE.SUSPEND
  end
  if PatchDlc.DoesExistPatchDlc()then
    this.CheckMgoChunkInstallation()
  else
    local gameMode=this.GetCurrentGameMode()
    this.Enqueue(this.TYPE.INVITATION_PATCH_DLC_ERROR,gameMode)
  end
  return this.PROCESS_STATE.FINISH
end
function this.CheckMgoChunkInstallation()
  if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
    this.GoToMgoByInivitaion()
  else
    Tpp.StartWaitChunkInstallation(Chunk.INDEX_MGO)
    local gameMode=this.GetCurrentGameMode()
    this.Enqueue(this.TYPE.WAIT_MGO_CHUNK_INSTALLATION,gameMode)
  end
end
function this.GoToMgoByInivitaion()
  TppPause.RegisterPause"GoToMGO"TppGameStatus.Set("GoToMGO","S_DISABLE_PLAYER_PAD")
  this.isNowGoingToMgo=true
  this.fadeOutRemainTimeForGoToMgo=TppUI.FADE_SPEED.FADE_HIGHSPEED
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHSPEED,"GoToMgoByInivitaion",TppUI.FADE_PRIORITY.SYSTEM,{setMute=true})
  FadeFunction.SetFadeCallEnable(false)
end
function this.UpdateMgoChunkInstallingPopup()
  Tpp.ShowChunkInstallingPopup(Chunk.INDEX_MGO,true)
  if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
    TppUiCommand.ErasePopup()
  end
end
function this.OnEndExceptionDialogForPatchDlcError()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  Tpp.ClearDidCancelPatchDlcDownloadRequest()
  this.CancelMgoInvitation()
  return this.PROCESS_STATE.FINISH
end
function this.UpdateMgoPatchDlcCheckingPopup()
  if PatchDlc.IsCheckingPatchDlc()then
    TppUI.ShowAccessIconContinue()
    return
  end
  TppUiCommand.ErasePopup()
end
function this.OnEndExceptionDialogForInvitationAcceptFromOther()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if not Tpp.IsMaster()then
    local exceptionType=this.TYPE[gvars.exc_processingExecptionType]
    local gameMode=this.GetCurrentGameMode()
    local gameType=this.GAME_MODE[gameMode]
  end
  this.CancelMgoInvitation()
  return this.PROCESS_STATE.FINISH
end
function this.OnEndExceptionDialogForInvitationAcceptWithoutSignIn()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if not Tpp.IsMaster()then
    local exceptionType=this.TYPE[gvars.exc_processingExecptionType]
    local gameMode=this.GetCurrentGameMode()
    local gameType=this.GAME_MODE[gameMode]
  end
  this.CancelMgoInvitation()
  return this.PROCESS_STATE.FINISH
end
function this.OnEndExceptionDialogForCheckMgoChunkInstallation()
  if not gvars.canExceptionHandling then
    return this.PROCESS_STATE.SUSPEND
  end
  if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
    this.GoToMgoByInivitaion()
  else
    this.CancelMgoInvitation()
  end
  return this.PROCESS_STATE.FINISH
end
function this.CancelMgoInvitation()
InvitationManager.ResetAccept()
InvitationManager.EnableMessage(true)
  if Chunk.GetChunkState(Chunk.INDEX_MGO)~=Chunk.STATE_INSTALLED then
    Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
  end
end
function this.CoopMissionEndOnException()
  return this.PROCESS_STATE.FINISH
end
this.POPUP_CLOSE_CHECK_FUNC={
  [this.TYPE.INVITATION_ACCEPT]=this.UpdateMgoInvitationAccept,
  [this.TYPE.INVITATION_PATCH_DLC_CHECKING]=this.UpdateMgoPatchDlcCheckingPopup,
  [this.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=this.UpdateMgoChunkInstallingPopup
}
this.TPP_ON_END_EXECPTION_DIALOG={
  [this.TYPE.INVITATION_ACCEPT]=this.OnEndExceptionDialogForMgoInvitationAccept,
  [this.TYPE.DISCONNECT_FROM_PSN]=this.OnEndExceptionForDisconnectDialog,
  [this.TYPE.DISCONNECT_FROM_KONAMI]=this.OnEndExceptionForDisconnectDialog,
  [this.TYPE.DISCONNECT_FROM_NETWORK]=this.OnEndExceptionForDisconnectDialog,
  [this.TYPE.SESSION_DISCONNECT_FROM_HOST]=this.OnEndExceptionForFromHost,
  [this.TYPE.SESSION_JOIN_FAILED]=this.OnEndExceptionForFromHost,
  [this.TYPE.SIGNIN_USER_CHANGED]=this.OnEndExceptionDialogForSignInUserChange,
  [this.TYPE.INVITATION_PATCH_DLC_CHECKING]=this.OnEndExceptionDialogForPatchDlcCheck,
  [this.TYPE.INVITATION_PATCH_DLC_ERROR]=this.OnEndExceptionDialogForPatchDlcError,
  [this.TYPE.INVITATION_ACCEPT_BY_OTHER]=this.OnEndExceptionDialogForInvitationAcceptFromOther,
  [this.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=this.OnEndExceptionDialogForInvitationAcceptWithoutSignIn,
  [this.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=this.OnEndExceptionDialogForCheckMgoChunkInstallation
}
function this.RegisterOnEndExceptionDialog(gameType,exceptionType)
  this.OnEndExceptionDialog[gameType]=exceptionType
end
this.RegisterOnEndExceptionDialog(this.GAME_MODE.TPP,this.TPP_ON_END_EXECPTION_DIALOG)
function this.GetCurrentGameMode()
  return this.GAME_MODE.TPP
end
function this.Enqueue(exceptionName,t)
  if not this.TYPE[exceptionName]then
    return
  end
  local exc_exceptionQueueDepth=gvars.exc_exceptionQueueDepth
  local exc_exceptionQueueDepth=gvars.exc_exceptionQueueDepth+1
  if exc_exceptionQueueDepth>=TppDefine.EXCEPTION_QUEUE_MAX then
    return
  end
  if(gvars.exc_processingExecptionType==exceptionName)then
    return
  end
  if this.HasQueue(exceptionName,t)then
    return
  end
  gvars.exc_exceptionQueueDepth=exc_exceptionQueueDepth
  gvars.exc_exceptionQueue[exc_exceptionQueueDepth]=exceptionName
  gvars.exc_queueGameMode[exc_exceptionQueueDepth]=t
end
function this.Dequeue(e)
  local e=e or 0
  if e>gvars.exc_exceptionQueueDepth then
    return
  end
  local t=gvars.exc_exceptionQueue[e]
  local o=gvars.exc_queueGameMode[e]
  local n=gvars.exc_exceptionQueueDepth
  for e=e,(n-1)do
    gvars.exc_exceptionQueue[e]=gvars.exc_exceptionQueue[e+1]
    gvars.exc_queueGameMode[e]=gvars.exc_queueGameMode[e+1]
  end
  gvars.exc_exceptionQueue[n]=0
  gvars.exc_queueGameMode[n]=0
  gvars.exc_exceptionQueueDepth=n-1
  return t,o
end
function this.HasQueue(n,e)
  for t=0,gvars.exc_exceptionQueueDepth do
    if n==nil then
      return true
    end
    if(gvars.exc_exceptionQueue[t]==n)and((e==nil)or(gvars.exc_queueGameMode[t]==e))then
      return true
    end
  end
  return false
end
function this.StartProcess(n,t)
  gvars.exc_processState=this.PROCESS_STATE.START
  gvars.exc_processingExecptionType=n
  gvars.exc_processingExecptionGameMode=t
  this.EnablePause()
end
function this.FinishProcess()
  gvars.exc_processState=this.PROCESS_STATE.EMPTY
  gvars.exc_processingExecptionType=0
  gvars.exc_processingExecptionGameMode=0
  this.DisablePause()
end
function this.EnablePause()
  TppPause.RegisterPause"TppException.lua"
  TppGameStatus.Set("TppException","S_DISABLE_PLAYER_PAD")
end
function this.DisablePause()
  TppPause.UnregisterPause"TppException.lua"
  TppGameStatus.Reset("TppException","S_DISABLE_PLAYER_PAD")
end
this.currentErrorPopupLangId=nil
local n=false
function this.Update()
  if not gvars then
    return
  end
  if this.isNowGoingToMgo then
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},"TppException : Now going to mgo by invitation")
    end
    if this.fadeOutRemainTimeForGoToMgo~=nil then
      if this.fadeOutRemainTimeForGoToMgo>0 then
        this.fadeOutRemainTimeForGoToMgo=this.fadeOutRemainTimeForGoToMgo-Time.GetFrameTime()
      else
        if not n then
          n=true
          Mission.SwitchApplication"mgo"
          end
      end
    end
    return
  end
  if gvars.isLoadedInitMissionOnSignInUserChanged then
    if DebugText then
      DebugText.Print(DebugText.NewContext(),{.5,.5,1},"TppException : Now loaded for sign in user changed.")
    end
    return
  end
  if gvars.exc_exceptionQueueDepth<=0 and(gvars.exc_processState<=this.PROCESS_STATE.EMPTY)then
    return
  end
  if(gvars.exc_processState>this.PROCESS_STATE.EMPTY)then
    local gameMod=this.GetCurrentGameMode()
    if this.IsProcessing()then
      gvars.exc_processState=this.PROCESS_STATE.SHOW_DIALOG
      local PopupCloseCheckFunc=this.POPUP_CLOSE_CHECK_FUNC[gvars.exc_processingExecptionType]
      if PopupCloseCheckFunc then
        PopupCloseCheckFunc()
      end
      if DebugText then
        local context=DebugText.NewContext()
        DebugText.Print(context,{.5,.5,1},"TppException : Now execption proccessing. execptionType = "..(tostring(this.TYPE[gvars.exc_processingExecptionType])..(", gameMode = "..tostring(this.GAME_MODE[gameMod]))))
        DebugText.Print(context,{.5,.5,1},"TppException : queueDepth = "..tostring(gvars.exc_exceptionQueueDepth))
      end
    else
      this.currentErrorPopupLangId=nil
      local n=this.OnEndExceptionDialog[gameMod]
      if not n then
        this.FinishProcess()
        return
      end
      local n=n[gvars.exc_processingExecptionType]
      if not n then
        this.FinishProcess()
        return
      end
      gvars.exc_processState=n()
      local exc_processState=gvars.exc_processState
      if DebugText then
        local context=DebugText.NewContext()
        DebugText.Print(context,{.5,.5,1},"TppException : Now execption proccessing. execptionType = "..(tostring(this.TYPE[gvars.exc_processingExecptionType])..(", gameMode = "..tostring(this.GAME_MODE[gameMod]))))
        DebugText.Print(context,{.5,.5,1},"TppException : gvars.exc_processState = "..tostring(exc_processState))
      end
      if exc_processState>this.PROCESS_STATE.SHOW_DIALOG then
        this.DisablePause()
      end
      if exc_processState==this.PROCESS_STATE.FINISH then
        this.FinishProcess()
      end
    end
  else
    local n,t=this.Dequeue()
    this.StartProcess(n,t)
    local n=this.ShowPopup(n)
    if not n then
      this.FinishProcess()
    end
  end
end
function this.ShowPopup(n)
  local n=this.SHOW_EXECPTION_DIALOG[n]
  if not n then
    return
  end
  local n,t,o,i=n()
  if not n then
    return
  end
  if t==nil then
    t=Popup.TYPE_ONE_BUTTON
  end
  if o then
    TppUiCommand.SetPopupType(o)
  end
  if i then
    TppUiCommand.SetPopupSelectNegative()
  end
  TppUiCommand.ShowErrorPopup(n,t)
  this.currentErrorPopupLangId=n
  return true
end
function this.OnAllocate(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(n)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.Messages()
  return Tpp.StrCode32Table{
    Network={
      {msg="InvitationAccept",func=this.OnInvitationAccept},
      {msg="DisconnectFromPsn",func=this.OnDisconnectFromPsn},
      {msg="DisconnectFromKonami",func=this.OnDisconnectFromKonami},
      {msg="DisconnectFromNetwork",func=this.OnDisconnectFromNetwork},
      {msg="SignInUserChanged",func=this.SignInUserChanged},
      {msg="InvitationAcceptByOther",func=this.OnInvitationAcceptByOther},
      {msg="InvitationAcceptWithoutSignIn",func=this.OnInvitationAcceptWithoutSignIn},
      {msg="EndLogin",func=function()
        gvars.exc_skipServerSaveForException=false
        gvars.exc_processingForDisconnect=false
      end},
      {msg="SessionDisconnectFromHost",func=this.OnSessionDisconnectFromHost},
      {msg="FailedJoinSession",func=this.OnFailedJoinSession},
      {msg="NoPrivilegeMultiPlay",func=function()
        TppUiCommand.ShowErrorPopup(2310)
      end}},
    Nt={
      {msg="SessionDisconnectFromHost",func=this.OnSessionDisconnectFromHost},
      {msg="FailedJoinSession",func=this.OnFailedJoinSession},
      {msg="SessionDeleteMember",func=function()
        if TppServerManager.FobIsSneak()then
          local e=4181
          TppUiCommand.ShowErrorPopup(e)
        end
      end}},
    Dlc={{msg="DlcStatusChanged",func=this.OnDlcStatusChanged}}}
end
function this.OnInvitationAccept()
  local n=this.GetCurrentGameMode()
  this.Enqueue(this.TYPE.INVITATION_ACCEPT,n)
  this.Update()
end
function this.OnDisconnectFromPsn()
  local n=this.GetCurrentGameMode()
  vars.invitationDisableRecieveFlag=1
  this.DequeueP2PDisconnectException()
  this.Enqueue(this.TYPE.DISCONNECT_FROM_PSN,n)
  this._OnDisconnectNetworkCommon()
  this.Update()
end
function this.OnDisconnectFromKonami()
  local n=this.GetCurrentGameMode()
  vars.invitationDisableRecieveFlag=1
  this.DequeueP2PDisconnectException()
  this.Enqueue(this.TYPE.DISCONNECT_FROM_KONAMI,n)
  this._OnDisconnectNetworkCommon()
  this.Update()
end
function this.OnDisconnectFromNetwork()
  local gameMode=this.GetCurrentGameMode()
  vars.invitationDisableRecieveFlag=1
  this.DequeueP2PDisconnectException()
  this.Enqueue(this.TYPE.DISCONNECT_FROM_NETWORK,gameMode)
  this._OnDisconnectNetworkCommon()
  this.Update()
end
function this.OnSessionDisconnectFromHost()
  local n=TppNetworkUtil.IsHost()
  if n then
    TppMission.AbandonMission()
    return
  end
  this._OnP2PDisconnect(this.TYPE.SESSION_DISCONNECT_FROM_HOST)
  this.Update()
end
function this.OnFailedJoinSession()
  this._OnP2PDisconnect(this.TYPE.SESSION_JOIN_FAILED)
  this.Update()
end
function this._OnP2PDisconnect(o)
  if this.IsSkipDisconnectFromHost()then
    return
  end
  if TppGameMode.GetUserMode()~=TppGameMode.U_KONAMI_LOGIN then
    return
  end
  local n=this.GetCurrentGameMode()
  for o,t in ipairs(this.TYPE_DISCONNECT_NETWORK_LIST)do
    if gvars.exc_processingExecptionType==t then
      return
    elseif this.HasQueue(t,n)then
      return
    end
  end
  this.Enqueue(o,n)
end
function this.SignInUserChanged()
  if not TppSequence.CanHandleSignInUserChangedException()then
    return
  end
  InvitationManager.EnableMessage(false)
  gvars.exc_skipServerSaveForException=true
  gvars.exc_processingForDisconnect=true
  this.fadingCountForDisconnection=0
  local n=this.GetCurrentGameMode()
  this.Enqueue(this.TYPE.SIGNIN_USER_CHANGED,n)
  this.Update()
end
function this.OnInvitationAcceptByOther()
  local n=this.GetCurrentGameMode()
  this.Enqueue(this.TYPE.INVITATION_ACCEPT_BY_OTHER,n)
  this.Update()
end
function this.OnInvitationAcceptWithoutSignIn()
  local n=this.GetCurrentGameMode()
  this.Enqueue(this.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN,n)
  this.Update()
end
function this.OnDlcStatusChanged()
  if vars.missionCode==TppDefine.SYS_MISSION_ID.INIT then
    return
  end
  local e=8014
  if gvars.ini_isTitleMode then
    e=8013
  end
  if TppUiCommand.IsShowPopup(e)then
  else
    TppUiCommand.ShowErrorPopup(e,Popup.TYPE_ONE_BUTTON)
  end
end
function this._OnDisconnectNetworkCommon()
  if IS_GC_2017_COOP then
    TppMission.DisconnectMatching(false)
  end
  Mission.HostMigration_SetActive(false)
  if gvars.canExceptionHandling then
    SsdMatching.RequestDisconnect()
  end
  gvars.exc_skipServerSaveForException=true
  gvars.exc_processingForDisconnect=true
  this.fadingCountForDisconnection=0
end
function this.DequeueWithType(o)
  local t=gvars.exc_exceptionQueueDepth
  local n=0
  while n<t do
    if gvars.exc_exceptionQueue[n]==o then
      this.Dequeue(n)t=gvars.exc_exceptionQueueDepth
    else
      n=n+1
    end
  end
end
function this.HasQueueNetworkDisconnect()
  local t=this.GetCurrentGameMode()
  for o,n in ipairs(this.TYPE_DISCONNECT_NETWORK_LIST)do
    if gvars.exc_processingExecptionType==n then
      return true
    elseif this.HasQueue(n,t)then
      return true
    end
  end
  return false
end
function this.SetSkipDisconnectFromHost()
  gvars.exc_skipDisconnectFromHostException=true
end
function this.ResetSkipDisconnectFromHost()
  gvars.exc_skipDisconnectFromHostException=false
end
function this.IsSkipDisconnectFromHost()
  return gvars.exc_skipDisconnectFromHostException
end
function this.DequeueP2PDisconnectException()
  for t,n in ipairs(this.TYPE_DISCONNECT_P2P_LIST)do
    this.DequeueWithType(this.TYPE[n])
  end
end
function this.IsProcessing()
  return this.currentErrorPopupLangId and TppUiCommand.IsShowPopup(this.currentErrorPopupLangId)
end
local n={}
function n.Update()
  this.Update()
end
function n:OnMessage(a,i,n,t,o,c)
  local r
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOptionWhileLoading,a,i,n,t,o,c,r)
end
ScriptUpdater.Create("exceptionMessageHandler",n,{"Network","Nt","UI","Dlc"})
return this
