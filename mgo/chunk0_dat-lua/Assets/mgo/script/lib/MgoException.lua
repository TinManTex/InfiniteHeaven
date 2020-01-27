-- MgoException.lua
local this={}
function this.OnEndExceptionDialogForMgoInvitationAccept()
  return TppException.PROCESS_STATE.FINISH
end
function this.MgoExitRoomOnException()
  if TppException.GetCurrentGameMode()~=TppException.GAME_MODE.MGO then
    return TppException.PROCESS_STATE.FINISH
  end
  MgoMatchMakingManager.ExitRoom()
  return TppException.PROCESS_STATE.FINISH
end
function this.OnEndExceptionDialogForSignInUserChange()
  if TppException.GetCurrentGameMode()~=TppException.GAME_MODE.MGO then
    return TppException.PROCESS_STATE.FINISH
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT,"FadeOutOnEndExceptionDialogForSignInUserChange",nil,{setMute=true})
  SignIn.SetStartupProcessCompleted(false)
  MgoMatchMakingManager.ExitRoom()
  Mission.SwitchApplication"tpp"
  return TppException.PROCESS_STATE.FINISH
end
this.MGO_ON_END_EXCEPTION_TABLE={
  [TppException.TYPE.INVITATION_ACCEPT]=this.OnEndExceptionDialogForMgoInvitationAccept,
  [TppException.TYPE.DISCONNECT_FROM_PSN]=this.OnEndExceptionDialogForSignInUserChange,
  [TppException.TYPE.DISCONNECT_FROM_KONAMI]=this.MgoExitRoomOnException,
  [TppException.TYPE.DISCONNECT_FROM_NETWORK]=this.MgoExitRoomOnException,
  [TppException.TYPE.SESSION_DISCONNECT_FROM_HOST]=this.MgoExitRoomOnException,
  [TppException.TYPE.SIGNIN_USER_CHANGED]=this.OnEndExceptionDialogForSignInUserChange,
  [TppException.TYPE.USER_NOT_SIGNED_IN]=this.OnEndExceptionDialogForSignInUserChange
}
TppException.RegisterOnEndExceptionDialog(TppException.GAME_MODE.MGO,this.MGO_ON_END_EXCEPTION_TABLE)
return this
