local e={}
e.PROCESS_STATE=Tpp.Enum{"EMPTY","START","SHOW_DIALOG","SUSPEND","FINISH"}
e.TYPE=Tpp.Enum{"INVITATION_ACCEPT","DISCONNECT_FROM_PSN","DISCONNECT_FROM_KONAMI","DISCONNECT_FROM_NETWORK","SESSION_DISCONNECT_FROM_HOST","SIGNIN_USER_CHANGED"}
e.GAME_MODE=Tpp.Enum{"TPP","TPP_FOB","MGO"}
e.OnEndExceptionDialog={}
e.SHOW_EXECPTION_DIALOG={
[e.TYPE.INVITATION_ACCEPT]=function()
  return TppDefine.ERROR_ID.GET_MGO_INVITATION
end,
[e.TYPE.DISCONNECT_FROM_PSN]=function()
  return TppDefine.ERROR_ID.DISCONNECT_FROM_PSN
end,
[e.TYPE.DISCONNECT_FROM_KONAMI]=function()
  return TppDefine.ERROR_ID.DISCONNECT_FROM_KONAMI
end,
[e.TYPE.DISCONNECT_FROM_NETWORK]=function()
  return TppDefine.ERROR_ID.DISCONNECT_FROM_NETWORK
end,
[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=function()
  if e.GetCurrentGameMode()=="TPP"then
    return
  end
  return TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST
end,
[e.TYPE.SIGNIN_USER_CHANGED]=function()
  return TppDefine.ERROR_ID.SIGNIN_USER_CHANGED
end
}
function e.NoProcessOnEndExceptionDialog()
  return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForSignInUserChange()
  if not TppSequence.CanHandleSignInUserChangedException()then
    return e.PROCESS_STATE.FINISH
  end
  TppUiStatusManager.SetStatus("All","ABORT")
  TppUI.FinishLoadingTips()
  TppRadio.playingBlackTelInfo=nil
  if not gvars.canExceptionHandling then
    return e.PROCESS_STATE.SUSPEND
  end
  if TppSave.IsSaving()then
    return e.PROCESS_STATE.SUSPEND
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",nil,{setMute=true})
  SignIn.SetStartupProcessCompleted(false)
  TppUI.SetFadeColorToBlack()
  StageBlockCurrentPositionSetter.SetEnable(false)
  TppUiCommand.SetLoadIndicatorVisible(true)
  SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
  TppRadio.Stop()
  TppMusicManager.StopMusicPlayer(1)
  TppMusicManager.EndSceneMode()
  TppRadioCommand.SetEnableIgnoreGamePause(false)
  GkEventTimerManager.StopAll()
  Mission.AddFinalizer(function()
    TppMission.DisablePauseForShowResult()
    TppScriptVars.InitForNewGame()
    TppGVars.AllInitialize()
    TppSave.VarSave(TppDefine.SYS_MISSION_ID.INIT,true)
    TppSave.VarSaveConfig()
    TppSave.VarSavePersonalData()
    local e=TppSave.GetSaveGameDataQueue(vars.missionCode)
    for o,n in ipairs(e.slot)do
      TppScriptVars.CopySlot({e.savingSlot,n},n)
    end
    TppUiStatusManager.UnsetStatus("All","ABORT")
  end)
  TppVarInit.StartInitMission()
  return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForMgoInvitationAccept()
  if not gvars.canExceptionHandling then
    return e.PROCESS_STATE.SUSPEND
  end
  if TppSave.IsSaving()then
    return e.PROCESS_STATE.SUSPEND
  end
  Mission.SwitchApplication"mgo"
  return e.PROCESS_STATE.FINISH
end
function e.ForbidFobExceptionHandling()mvars.exc_permitFobExceptionHandling=nil
end
function e.PermitFobExceptionHandling()mvars.exc_permitFobExceptionHandling=true
end
function e.SuspendFobExceptionHandling()mvars.exc_suspendFobExceptionHandling=true
  mvars.exc_permitFobExceptionHandling=nil
end
function e.FobMissionEndOnException()
  if not gvars.canExceptionHandling then
    return e.PROCESS_STATE.SUSPEND
  end
  local n=e.GetCurrentGameMode()
  if n~=e.GAME_MODE.TPP_FOB then
    return e.PROCESS_STATE.FINISH
  end
  if TppSave.IsSaving()then
    return e.PROCESS_STATE.SUSPEND
  end
  if TppMission.IsHelicopterSpace(vars.missionCode)then
    if mvars.exc_permitFobExceptionHandling then
      TppUiCommand.AbortFobMissionPreparation()
    else
      if mvars.exc_suspendFobExceptionHandling then
        return e.PROCESS_STATE.SUSPEND
      else
        return e.PROCESS_STATE.FINISH
      end
    end
  else
    if mvars.exc_permitFobExceptionHandling==nil then
      return e.PROCESS_STATE.SUSPEND
    end
    if TppServerManager.FobIsSneak()then
      TppMission.AbortMissionByMenu()
    else
      TppMission.ReturnToMission()
    end
  end
  return e.PROCESS_STATE.FINISH
end
e.TPP_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.NoProcessOnEndExceptionDialog,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.NoProcessOnEndExceptionDialog,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.NoProcessOnEndExceptionDialog,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.NoProcessOnEndExceptionDialog,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange}e.TPP_FOB_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.FobMissionEndOnException,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.FobMissionEndOnException,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.FobMissionEndOnException,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.FobMissionEndOnException,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange}
function e.RegisterOnEndExceptionDialog(n,o)e.OnEndExceptionDialog[n]=o
end
e.RegisterOnEndExceptionDialog(e.GAME_MODE.TPP,e.TPP_ON_END_EXECPTION_DIALOG)e.RegisterOnEndExceptionDialog(e.GAME_MODE.TPP_FOB,e.TPP_FOB_ON_END_EXECPTION_DIALOG)
function e.GetCurrentGameMode()
  if TppSystemUtility.GetCurrentGameMode()=="MGO"then
    return e.GAME_MODE.MGO
  else
    if TppMission.IsFOBMission(vars.missionCode)then
      if TppMission.CheckMissionState(false,false,false,true)then
        return e.GAME_MODE.TPP_FOB
      else
        return e.GAME_MODE.TPP
      end
    else
      if TppServerManager.FobIsSneak()then
        return e.GAME_MODE.TPP_FOB
      end
      if(TppMission.GetNextMissionCodeForEmergency()==50050)then
        return e.GAME_MODE.TPP_FOB
      else
        return e.GAME_MODE.TPP
      end
    end
  end
end
function e.Enqueue(n,o)
  if not e.TYPE[n]then
    return
  end
  local t=gvars.exc_exceptionQueueDepth
  local e=gvars.exc_exceptionQueueDepth+1
  if e>=TppDefine.EXCEPTION_QUEUE_MAX then
    return
  end
  if(gvars.exc_processingExecptionType==n)and(gvars.exc_processingExecptionGameMode==o)then
    return
  end
  for e=0,gvars.exc_exceptionQueueDepth do
    if(gvars.exc_exceptionQueue[e]==n)and(gvars.exc_queueGameMode[e]==o)then
      return
    end
  end
  gvars.exc_exceptionQueueDepth=e
  gvars.exc_exceptionQueue[t]=n
  gvars.exc_queueGameMode[t]=o
end
function e.Dequeue(e)
  local e=e or 0
  if e>gvars.exc_exceptionQueueDepth then
    return
  end
  local o=gvars.exc_exceptionQueue[e]local t=gvars.exc_queueGameMode[e]
  local n=gvars.exc_exceptionQueueDepth
  for e=e,(n-1)do
    gvars.exc_exceptionQueue[e]=gvars.exc_exceptionQueue[e+1]
    gvars.exc_queueGameMode[e]=gvars.exc_queueGameMode[e+1]
    end
  gvars.exc_exceptionQueue[n]=0
  gvars.exc_queueGameMode[n]=0
  gvars.exc_exceptionQueueDepth=n-1
  return o,t
end
function e.StartProcess(n,o)gvars.exc_processState=e.PROCESS_STATE.START
  gvars.exc_processingExecptionType=n
  gvars.exc_processingExecptionGameMode=o
  e.EnablePause()
end
function e.FinishProcess()gvars.exc_processState=e.PROCESS_STATE.EMPTY
  gvars.exc_processingExecptionType=0
  gvars.exc_processingExecptionGameMode=0
  e.DisablePause()
end
function e.EnablePause()
  TppPause.RegisterPause"TppException.lua"
  TppGameStatus.Set("TppException","S_DISABLE_PLAYER_PAD")
end
function e.DisablePause()
  TppPause.UnregisterPause"TppException.lua"
  TppGameStatus.Reset("TppException","S_DISABLE_PLAYER_PAD")
end
e.currentErrorPopupLangId=nil
function e.Update()
  if not gvars then
    return
  end
  if gvars.exc_exceptionQueueDepth<=0 and(gvars.exc_processState<=e.PROCESS_STATE.EMPTY)then
    return
  end
  if(gvars.exc_processState>e.PROCESS_STATE.EMPTY)then
    if e.currentErrorPopupLangId and TppUiCommand.IsShowPopup(e.currentErrorPopupLangId)then
      gvars.exc_processState=e.PROCESS_STATE.SHOW_DIALOG
    else
      e.currentErrorPopupLangId=nil
      local n=e.OnEndExceptionDialog[gvars.exc_processingExecptionGameMode]if not n then
        e.FinishProcess()
        return
      end
      local n=n[gvars.exc_processingExecptionType]if not n then
        e.FinishProcess()
        return
      end
      gvars.exc_processState=n()
      local n=gvars.exc_processState
      if n>e.PROCESS_STATE.SHOW_DIALOG then
        e.DisablePause()
      end
      if n==e.PROCESS_STATE.FINISH then
        e.FinishProcess()
      end
    end
  else
    local n,o=e.Dequeue()
    e.StartProcess(n,o)
    local n=e.ShowPopup(n)
    if not n then
      e.FinishProcess()
    end
  end
end
function e.ShowPopup(n)
  local n=e.SHOW_EXECPTION_DIALOG[n]
  if not n then
    return
  end
  local n=n()
  if not n then
    return
  end
  TppUiCommand.ShowErrorPopup(n,Popup.TYPE_ONE_BUTTON)
  e.currentErrorPopupLangId=n
  return true
end
function e.OnAllocate(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.Messages()
  return Tpp.StrCode32Table{
    Network={
      {msg="InvitationAccept",func=e.OnInvitationAccept},
      {msg="DisconnectFromPsn",func=e.OnDisconnectFromPsn},
      {msg="DisconnectFromKonami",func=e.OnDisconnectFromKonami},
      {msg="DisconnectFromNetwork",func=e.OnDisconnectFromNetwork},
      {msg="SignInUserChanged",func=e.SignInUserChanged}},
    Nt={
      {msg="SessionDisconnectFromHost",func=e.OnSessionDisconnectFromHost},
      {msg="SessionDeleteMember",func=function()
        if TppServerManager.FobIsSneak()then
          local e=4181
          TppUiCommand.ShowErrorPopup(e)
        end
      end}},
    Dlc={{msg="DlcStatusChanged",func=e.OnDlcStatusChanged}}
  }
end
function e.OnInvitationAccept()
  local n=e.GetCurrentGameMode()
  e.Enqueue(e.TYPE.INVITATION_ACCEPT,n)
  e.Update()
end
function e.OnDisconnectFromPsn()
  local n=e.GetCurrentGameMode()
  e.Enqueue(e.TYPE.DISCONNECT_FROM_PSN,n)
  e.Update()
end
function e.OnDisconnectFromKonami()
  local n=e.GetCurrentGameMode()
  e.Enqueue(e.TYPE.DISCONNECT_FROM_KONAMI,n)
  e.Update()
end
function e.OnDisconnectFromNetwork()
  local n=e.GetCurrentGameMode()
  e.Enqueue(e.TYPE.DISCONNECT_FROM_NETWORK,n)
  e.Update()
end
function e.OnSessionDisconnectFromHost()
  local n=e.GetCurrentGameMode()
  e.Enqueue(e.TYPE.SESSION_DISCONNECT_FROM_HOST,n)
  e.Update()
end
function e.SignInUserChanged()
  if not TppSequence.CanHandleSignInUserChangedException()then
    return
  end
  local n=e.GetCurrentGameMode()
  e.Enqueue(e.TYPE.SIGNIN_USER_CHANGED,n)
  e.Update()
end
function e.OnDlcStatusChanged()
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
local n={}
function n.Update()
  e.Update()
end
function n:OnMessage(n,o,r,i,t,s)
  local a
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOptionWhileLoading,n,o,r,i,t,s,a)
end
ScriptUpdater.Create("exceptionMessageHandler",n,{"Network","Nt","UI","Dlc"})
return e
