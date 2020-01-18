local e={}
e.MGO_INVITATION_CANCEL_POPUP_ID=5010
e.CLOSE_INIVITATION_CANCEL_POPUP_INTERVAL=1.5
e.PROCESS_STATE=Tpp.Enum{"EMPTY","START","SHOW_DIALOG","SUSPEND","FINISH"}
e.TYPE=Tpp.Enum{"INVITATION_ACCEPT","DISCONNECT_FROM_PSN","DISCONNECT_FROM_KONAMI","DISCONNECT_FROM_NETWORK","SESSION_DISCONNECT_FROM_HOST","SIGNIN_USER_CHANGED","INVITATION_PATCH_DLC_CHECKING","INVITATION_PATCH_DLC_ERROR","INVITATION_ACCEPT_BY_OTHER","INVITATION_ACCEPT_WITHOUT_SIGNIN","WAIT_MGO_CHUNK_INSTALLATION"}
e.GAME_MODE=Tpp.Enum{"TPP","TPP_FOB","MGO"}
e.OnEndExceptionDialog={}
e.mgoInvitationUpdateCount=0
e.SHOW_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=function()
e.mgoInvitationUpdateCount=0
e.mgoInvitationPopupId=nil
if TppStory.CanPlayMgo()then
if e.GetCurrentGameMode()==e.GAME_MODE.TPP_FOB then
e.mgoInvitationPopupId=e.MGO_INVITATION_CANCEL_POPUP_ID
return e.MGO_INVITATION_CANCEL_POPUP_ID
else
return 5001,Popup.TYPE_TWO_BUTTON,nil,true
end
else
return 5004
end
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
end,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=function()
return 5100,false,"POPUP_TYPE_NO_BUTTON_NO_EFFECT",nil
end,[e.TYPE.INVITATION_PATCH_DLC_ERROR]=function()
return 5103
end,[e.TYPE.INVITATION_ACCEPT_BY_OTHER]=function()
return 5005
end,[e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=function()
return 5012
end,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=function()
return TppDefine.ERROR_ID.NOW_INSTALLING,Popup.TYPE_ONE_CANCEL_BUTTON
end}
function e.NoProcessOnEndExceptionDialog()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
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
if TppUiCommand.IsShowPopup()then
TppUiCommand.ErasePopup()
end
gvars.isLoadedInitMissionOnSignInUserChanged=true
e.isLoadedInitMissionOnSignInUserChanged=true
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",nil,{setMute=true})FadeFunction.SetFadeCallEnable(false)SignIn.SetStartupProcessCompleted(false)
TppUI.SetFadeColorToBlack()StageBlockCurrentPositionSetter.SetEnable(false)
TppUiCommand.SetLoadIndicatorVisible(true)SubtitlesCommand.SetIsEnabledUiPrioStrong(false)
TppRadio.Stop()
TppMusicManager.StopMusicPlayer(1)
TppMusicManager.EndSceneMode()
TppRadioCommand.SetEnableIgnoreGamePause(false)GkEventTimerManager.StopAll()Mission.AddFinalizer(function()
e.waitPatchDlcCheckCoroutine=nil
TppSave.missionStartSaveFilePool=nil
TppMission.DisablePauseForShowResult()
vars.locationCode=TppDefine.LOCATION_ID.INIT
vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
TppScriptVars.InitForNewGame()
TppGVars.AllInitialize()
TppSave.VarSave(TppDefine.SYS_MISSION_ID.INIT,true)
TppSave.VarSaveConfig()
TppSave.VarSavePersonalData()
local n=TppSave.GetSaveGameDataQueue(vars.missionCode)
for t,e in ipairs(n.slot)do
TppScriptVars.CopySlot({n.savingSlot,e},e)
end
TppUiStatusManager.UnsetStatus("All","ABORT")FadeFunction.SetFadeCallEnable(true)
end)
TppVarInit.StartInitMission()
return e.PROCESS_STATE.FINISH
end
function e.UpdateMgoInvitationAccept()
if(e.currentErrorPopupLangId==e.MGO_INVITATION_CANCEL_POPUP_ID)then
e.mgoInvitationUpdateCount=e.mgoInvitationUpdateCount+Time.GetFrameTime()
if e.mgoInvitationUpdateCount>e.CLOSE_INIVITATION_CANCEL_POPUP_INTERVAL then
TppUiCommand.ErasePopup()
end
end
end
function e.OnEndExceptionDialogForMgoInvitationAccept()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if not TppStory.CanPlayMgo()then
e.CancelMgoInvitation()
return e.PROCESS_STATE.FINISH
end
if(e.mgoInvitationPopupId==e.MGO_INVITATION_CANCEL_POPUP_ID)then
e.CancelMgoInvitation()
return e.PROCESS_STATE.FINISH
end
if TppSave.IsSaving()then
return e.PROCESS_STATE.SUSPEND
end
local n=TppUiCommand.GetPopupSelect()
if n==Popup.SELECT_OK then
PatchDlc.StartCheckingPatchDlc()
if PatchDlc.IsCheckingPatchDlc()then
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.INVITATION_PATCH_DLC_CHECKING,n)
else
if PatchDlc.DoesExistPatchDlc()then
e.CheckMgoChunkInstallation()
else
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.INVITATION_PATCH_DLC_ERROR,n)
end
end
else
e.CancelMgoInvitation()
end
return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForPatchDlcCheck()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if TppSave.IsSaving()then
return e.PROCESS_STATE.SUSPEND
end
if PatchDlc.DoesExistPatchDlc()then
e.CheckMgoChunkInstallation()
else
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.INVITATION_PATCH_DLC_ERROR,n)
end
return e.PROCESS_STATE.FINISH
end
function e.CheckMgoChunkInstallation()
if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
e.GoToMgoByInivitaion()
else
Tpp.StartWaitChunkInstallation(Chunk.INDEX_MGO)
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.WAIT_MGO_CHUNK_INSTALLATION,n)
end
end
function e.GoToMgoByInivitaion()
TppPause.RegisterPause"GoToMGO"TppGameStatus.Set("GoToMGO","S_DISABLE_PLAYER_PAD")
e.isNowGoingToMgo=true
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"GoToMgoByInivitaion",nil,{setMute=true})Mission.SwitchApplication"mgo"end
function e.UpdateMgoChunkInstallingPopup()
Tpp.ShowChunkInstallingPopup(Chunk.INDEX_MGO,true)
if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
TppUiCommand.ErasePopup()
end
end
function e.OnEndExceptionDialogForPatchDlcError()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
Tpp.ClearDidCancelPatchDlcDownloadRequest()
e.CancelMgoInvitation()
return e.PROCESS_STATE.FINISH
end
function e.UpdateMgoPatchDlcCheckingPopup()
if PatchDlc.IsCheckingPatchDlc()then
TppUI.ShowAccessIconContinue()
return
end
TppUiCommand.ErasePopup()
end
function e.OnEndExceptionDialogForInvitationAcceptFromOther()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
e.CancelMgoInvitation()
return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForInvitationAcceptWithoutSignIn()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
e.CancelMgoInvitation()
return e.PROCESS_STATE.FINISH
end
function e.OnEndExceptionDialogForCheckMgoChunkInstallation()
if not gvars.canExceptionHandling then
return e.PROCESS_STATE.SUSPEND
end
if Chunk.GetChunkState(Chunk.INDEX_MGO)==Chunk.STATE_INSTALLED then
e.GoToMgoByInivitaion()
else
e.CancelMgoInvitation()
end
return e.PROCESS_STATE.FINISH
end
function e.CancelMgoInvitation()InvitationManager.ResetAccept()InvitationManager.EnableMessage(true)
if Chunk.GetChunkState(Chunk.INDEX_MGO)~=Chunk.STATE_INSTALLED then
Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
end
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
TppMission.ReturnToMission{withServerPenalty=true}
end
end
return e.PROCESS_STATE.FINISH
end
e.POPUP_CLOSE_CHECK_FUNC={[e.TYPE.INVITATION_ACCEPT]=e.UpdateMgoInvitationAccept,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=e.UpdateMgoPatchDlcCheckingPopup,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=e.UpdateMgoChunkInstallingPopup}
e.TPP_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.NoProcessOnEndExceptionDialog,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.NoProcessOnEndExceptionDialog,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.NoProcessOnEndExceptionDialog,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.NoProcessOnEndExceptionDialog,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=e.OnEndExceptionDialogForPatchDlcCheck,[e.TYPE.INVITATION_PATCH_DLC_ERROR]=e.OnEndExceptionDialogForPatchDlcError,[e.TYPE.INVITATION_ACCEPT_BY_OTHER]=e.OnEndExceptionDialogForInvitationAcceptFromOther,[e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=e.OnEndExceptionDialogForInvitationAcceptWithoutSignIn,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=e.OnEndExceptionDialogForCheckMgoChunkInstallation}
e.TPP_FOB_ON_END_EXECPTION_DIALOG={[e.TYPE.INVITATION_ACCEPT]=e.OnEndExceptionDialogForMgoInvitationAccept,[e.TYPE.DISCONNECT_FROM_PSN]=e.FobMissionEndOnException,[e.TYPE.DISCONNECT_FROM_KONAMI]=e.FobMissionEndOnException,[e.TYPE.DISCONNECT_FROM_NETWORK]=e.FobMissionEndOnException,[e.TYPE.SESSION_DISCONNECT_FROM_HOST]=e.FobMissionEndOnException,[e.TYPE.SIGNIN_USER_CHANGED]=e.OnEndExceptionDialogForSignInUserChange,[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=e.OnEndExceptionDialogForPatchDlcCheck,[e.TYPE.INVITATION_ACCEPT_BY_OTHER]=e.OnEndExceptionDialogForInvitationAcceptFromOther,[e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=e.OnEndExceptionDialogForInvitationAcceptWithoutSignIn,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=e.OnEndExceptionDialogForCheckMgoChunkInstallation}
function e.RegisterOnEndExceptionDialog(n,t)
e.OnEndExceptionDialog[n]=t
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
function e.Enqueue(n,i)
if not e.TYPE[n]then
return
end
local t=gvars.exc_exceptionQueueDepth
local o=gvars.exc_exceptionQueueDepth+1
if o>=TppDefine.EXCEPTION_QUEUE_MAX then
return
end
if(gvars.exc_processingExecptionType==n)then
return
end
if e.HasQueue(n,i)then
return
end
gvars.exc_exceptionQueueDepth=o
gvars.exc_exceptionQueue[t]=n
gvars.exc_queueGameMode[t]=i
end
function e.Dequeue(e)
local e=e or 0
if e>gvars.exc_exceptionQueueDepth then
return
end
local o=gvars.exc_exceptionQueue[e]
local t=gvars.exc_queueGameMode[e]
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
function e.HasQueue(t,e)
for n=0,gvars.exc_exceptionQueueDepth do
if(gvars.exc_exceptionQueue[n]==t)and((e==nil)or(gvars.exc_queueGameMode[n]==e))then
return true
end
end
return false
end
function e.StartProcess(n,t)
gvars.exc_processState=e.PROCESS_STATE.START
gvars.exc_processingExecptionType=n
gvars.exc_processingExecptionGameMode=t
local o={[e.TYPE.INVITATION_PATCH_DLC_CHECKING]=true,[e.TYPE.INVITATION_PATCH_DLC_ERROR]=true,[e.TYPE.INVITATION_ACCEPT_BY_OTHER]=true,[e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN]=true,[e.TYPE.INVITATION_ACCEPT]=true,[e.TYPE.WAIT_MGO_CHUNK_INSTALLATION]=true}
if(t==e.GAME_MODE.TPP_FOB)and(o[n])then
TppGameStatus.Set("TppException","S_DISABLE_PLAYER_PAD")
else
e.EnablePause()
end
end
function e.FinishProcess()
gvars.exc_processState=e.PROCESS_STATE.EMPTY
gvars.exc_processingExecptionType=0
gvars.exc_processingExecptionGameMode=0
e.DisablePause()
end
function e.EnablePause()
TppPause.RegisterPause"TppException.lua"TppGameStatus.Set("TppException","S_DISABLE_PLAYER_PAD")
end
function e.DisablePause()
TppPause.UnregisterPause"TppException.lua"TppGameStatus.Reset("TppException","S_DISABLE_PLAYER_PAD")
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
local n=e.GetCurrentGameMode()
if e.currentErrorPopupLangId and TppUiCommand.IsShowPopup(e.currentErrorPopupLangId)then
gvars.exc_processState=e.PROCESS_STATE.SHOW_DIALOG
local e=e.POPUP_CLOSE_CHECK_FUNC[gvars.exc_processingExecptionType]
if e then
e()
end
else
e.currentErrorPopupLangId=nil
local n=e.OnEndExceptionDialog[n]
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
local n=gvars.exc_processState
if n>e.PROCESS_STATE.SHOW_DIALOG then
e.DisablePause()
end
if n==e.PROCESS_STATE.FINISH then
e.FinishProcess()
end
end
else
local n,t=e.Dequeue()
e.StartProcess(n,t)
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
return Tpp.StrCode32Table{Network={{msg="InvitationAccept",func=e.OnInvitationAccept},{msg="DisconnectFromPsn",func=e.OnDisconnectFromPsn},{msg="DisconnectFromKonami",func=e.OnDisconnectFromKonami},{msg="DisconnectFromNetwork",func=e.OnDisconnectFromNetwork},{msg="SignInUserChanged",func=e.SignInUserChanged},{msg="InvitationAcceptByOther",func=e.OnInvitationAcceptByOther},{msg="InvitationAcceptWithoutSignIn",func=e.OnInvitationAcceptWithoutSignIn}},Nt={{msg="SessionDisconnectFromHost",func=e.OnSessionDisconnectFromHost},{msg="SessionDeleteMember",func=function()
if TppServerManager.FobIsSneak()then
local e=4181
TppUiCommand.ShowErrorPopup(e)
end
end}},Dlc={{msg="DlcStatusChanged",func=e.OnDlcStatusChanged}}}
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
if e.isNowGoingToMgo then
return
end
TppSave.ForbidSave()
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.SIGNIN_USER_CHANGED,n)
e.Update()
end
function e.OnInvitationAcceptByOther()
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.INVITATION_ACCEPT_BY_OTHER,n)
e.Update()
end
function e.OnInvitationAcceptWithoutSignIn()
local n=e.GetCurrentGameMode()
e.Enqueue(e.TYPE.INVITATION_ACCEPT_WITHOUT_SIGNIN,n)
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
function n:OnMessage(i,a,o,n,t,E)
local T
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOptionWhileLoading,i,a,o,n,t,E,T)
end
ScriptUpdater.Create("exceptionMessageHandler",n,{"Network","Nt","UI","Dlc"})
return e
