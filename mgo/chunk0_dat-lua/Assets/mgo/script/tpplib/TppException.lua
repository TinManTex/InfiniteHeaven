local e={}
e.PROCESS_STATE=Tpp.Enum{"EMPTY","START","SHOW_DIALOG","SUSPEND","FINISH"}
e.TYPE=Tpp.Enum{"INVITATION_ACCEPT","DISCONNECT_FROM_PSN","DISCONNECT_FROM_KONAMI","DISCONNECT_FROM_NETWORK","SESSION_DISCONNECT_FROM_HOST","SIGNIN_USER_CHANGED","USER_NOT_SIGNED_IN"}
e.GAME_MODE=Tpp.Enum{"TPP","TPP_FOB","MGO"}
e.OnEndExceptionDialog={}
e.SHOW_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=function()
return nil
end,[e.TYPE.DISCONNECT_FROM_PSN]=function()
return TppDefine.ERROR_ID.DISCONNECT_FROM_PSN
end,[e.TYPE.DISCONNECT_FROM_KONAMI]=function()
return TppDefine.ERROR_ID.DISCONNECT_FROM_KONAMI
end,[e.TYPE.DISCONNECT_FROM_NETWORK]=function()
return TppDefine.ERROR_ID.DISCONNECT_FROM_NETWORK
end,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=function()
if e.GetCurrentGameMode()=="TPP"then
return
end
return TppDefine.ERROR_ID.SESSION_DISCONNECT_FROM_HOST
end,[e.TYPE.SIGNIN_USER_CHANGED]=function()
return TppDefine.ERROR_ID.SIGNIN_USER_CHANGED
end,[e.TYPE.USER_NOT_SIGNED_IN]=function()
return TppDefine.ERROR_ID.START_NOT_SIGN_IN
end}
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
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",nil,{setMute=true})SignIn.SetStartupProcessCompleted(false)
TppUI.SetFadeColorToBlack()StageBlockCurrentPositionSetter.SetEnable(false)
TppUiCommand.SetLoadIndicatorVisible(true)SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
TppRadio.Stop()
TppMusicManager.StopMusicPlayer(1)
TppMusicManager.EndSceneMode()
TppRadioCommand.SetEnableIgnoreGamePause(false)GkEventTimerManager.StopAll()Mission.AddFinalizer(function()
TppMission.DisablePauseForShowResult()
TppScriptVars.InitForNewGame()
TppGVars.AllInitialize()
TppSave.VarSave(TppDefine.SYS_MISSION_ID.INIT,true)
TppSave.VarSaveConfig()
TppSave.VarSavePersonalData()
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
Mission.SwitchApplication"mgo"return e.PROCESS_STATE.FINISH
end
function e.ForbidFobExceptionHandling()
mvars.exc_permitFobExceptionHandling=nil
end
function e.PermitFobExceptionHandling()
mvars.exc_permitFobExceptionHandling=true
end
function e.SuspendFobExceptionHandling()
mvars.exc_suspendFobExceptionHandling=true
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
e.TPP_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.NoProcessOnEndExceptionDialog,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.NoProcessOnEndExceptionDialog,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.NoProcessOnEndExceptionDialog,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.NoProcessOnEndExceptionDialog,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange}
e.TPP_FOB_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.FobMissionEndOnException,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.FobMissionEndOnException,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.FobMissionEndOnException,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.FobMissionEndOnException,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange}
function e.RegisterOnEndExceptionDialog(t,n)
e.OnEndExceptionDialog[t]=n
end
e.RegisterOnEndExceptionDialog(e.GAME_MODE.TPP,e.TPP_ON_END_EXECPTION_DIALOG)
e.RegisterOnEndExceptionDialog(e.GAME_MODE.TPP_FOB,e.TPP_FOB_ON_END_EXECPTION_DIALOG)
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
gvars.exc_exceptionQueueDepth=e
gvars.exc_exceptionQueue[t]=n
gvars.exc_queueGameMode[t]=o
end
function e.Dequeue(e)
local n=e or 0
if n>gvars.exc_exceptionQueueDepth then
return
end
local t=gvars.exc_exceptionQueue[n]
local o=gvars.exc_queueGameMode[n]
local e=gvars.exc_exceptionQueueDepth
for e=n,(e-1)do
gvars.exc_exceptionQueue[e]=gvars.exc_exceptionQueue[e+1]
gvars.exc_queueGameMode[e]=gvars.exc_queueGameMode[e+1]
end
gvars.exc_exceptionQueue[e]=0
gvars.exc_queueGameMode[e]=0
gvars.exc_exceptionQueueDepth=e-1
return t,o
end
function e.StartProcess(n,t)
gvars.exc_processState=e.PROCESS_STATE.START
gvars.exc_processingExecptionType=n
gvars.exc_processingExecptionGameMode=t
local n=e.GetCurrentGameMode()
if n==e.GAME_MODE.TPP then
e.EnablePause()
end
end
function e.FinishProcess()
gvars.exc_processState=e.PROCESS_STATE.EMPTY
gvars.exc_processingExecptionType=0
gvars.exc_processingExecptionGameMode=0
local n=e.GetCurrentGameMode()
e.DisablePause()
end
function e.EnablePause()
TppGameStatus.Set("TppException","S_DISABLE_PLAYER_PAD")
end
function e.DisablePause()
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
local n=e.OnEndExceptionDialog[gvars.exc_processingExecptionGameMode]
if not n then
e.FinishProcess()
return
end
local n=n[gvars.exc_processingExecptionType]
if not n then
e.FinishProcess()
return
end
gvars.exc_processState=n()
if gvars.exc_processState==e.PROCESS_STATE.FINISH then
e.FinishProcess()
end
end
else
local n,t=e.Dequeue()
e.StartProcess(n,t)do
local t=e.ShowPopup(n)
if((((n==e.TYPE.DISCONNECT_FROM_PSN or n==e.TYPE.DISCONNECT_FROM_KONAMI)or n==e.TYPE.DISCONNECT_FROM_NETWORK)or n==e.TYPE.SESSION_DISCONNECT_FROM_HOST)or n==e.TYPE.SIGNIN_USER_CHANGED)or n==e.TYPE.USER_NOT_SIGNED_IN then
MgoMatchMakingManager.ExitRoom()
end
if not t then
e.FinishProcess()
end
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
return Tpp.StrCode32Table{Network={{msg="InvitationAccept",func=e.OnInvitationAccept},{msg="DisconnectFromPsn",func=e.OnDisconnectFromPsn},{msg="DisconnectFromKonami",func=e.OnDisconnectFromKonami},{msg="DisconnectFromNetwork",func=e.OnDisconnectFromNetwork},{msg="SignInUserChanged",func=e.SignInUserChanged},{msg="UserNotSignedIn",func=e.UserNotSignedIn}},Nt={{msg="SessionDisconnectFromHost",func=e.OnSessionDisconnectFromHost},{msg="SessionDeleteMember",func=function()
if TppServerManager.FobIsSneak()then
local e=4181
TppUiCommand.ShowErrorPopup(e)
end
end}},Dlc={{msg="DlcStatusChanged",func=e.OnDlcStatusChanged}},UI={{msg="StartDlcAnnounce",func=e.OnStartDlcAnnounce},{msg="EndDlcAnnounce",func=e.OnEndDlcAnnounce}}}
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
function e.UserNotSignedIn()
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.USER_NOT_SIGNED_IN,n)
e.Update()
end
function e.OnDlcStatusChanged()
gvars.isChangeDlcStatus=true
end
function e.OnStartDlcAnnounce()Player.SetPadMask{settingName="DlcAnnounce",except=false,buttons=PlayerPad.MB_DEVICE}
gvars.isChangeDlcStatus=false
end
function e.OnEndDlcAnnounce(e)
if e==0 then
gvars.isChangeDlcStatus=true
end
Player.ResetPadMask{settingName="DlcAnnounce"}
end
local n={}
function n.Update()
e.Update()
end
function n:OnMessage(i,t,o,r,n,E)
local a
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOptionWhileLoading,i,t,o,r,n,E,a)
end
ScriptUpdater.Create("exceptionMessageHandler",n,{"Network","Nt","UI","Dlc"})
return e
