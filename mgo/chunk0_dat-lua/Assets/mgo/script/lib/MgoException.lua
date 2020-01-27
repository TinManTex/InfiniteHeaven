local n={}function n.OnEndExceptionDialogForMgoInvitationAccept()return TppException.PROCESS_STATE.FINISH
end
function n.MgoExitRoomOnException()if TppException.GetCurrentGameMode()~=TppException.GAME_MODE.MGO then
return TppException.PROCESS_STATE.FINISH
end
MgoMatchMakingManager.ExitRoom()return TppException.PROCESS_STATE.FINISH
end
function n.OnEndExceptionDialogForSignInUserChange()if TppException.GetCurrentGameMode()~=TppException.GAME_MODE.MGO then
return TppException.PROCESS_STATE.FINISH
end
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",nil,{setMute=true})SignIn.SetStartupProcessCompleted(false)MgoMatchMakingManager.ExitRoom()Mission.SwitchApplication"tpp"return TppException.PROCESS_STATE.FINISH
end
n.MGO_ON_END_EXCEPTION_TABLE={[TppException.TYPE.INVITATION_ACCEPT]=n.OnEndExceptionDialogForMgoInvitationAccept,[TppException.TYPE.DISCONNECT_FROM_PSN]=n.OnEndExceptionDialogForSignInUserChange,[TppException.TYPE.DISCONNECT_FROM_KONAMI]=n.MgoExitRoomOnException,[TppException.TYPE.DISCONNECT_FROM_NETWORK]=n.MgoExitRoomOnException,[TppException.TYPE.SESSION_DISCONNECT_FROM_HOST]=n.MgoExitRoomOnException,[TppException.TYPE.SIGNIN_USER_CHANGED]=n.OnEndExceptionDialogForSignInUserChange,[TppException.TYPE.USER_NOT_SIGNED_IN]=n.OnEndExceptionDialogForSignInUserChange}TppException.RegisterOnEndExceptionDialog(TppException.GAME_MODE.MGO,n.MGO_ON_END_EXCEPTION_TABLE)return n