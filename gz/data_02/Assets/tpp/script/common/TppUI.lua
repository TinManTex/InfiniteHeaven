local this = {}




this.Messages = {
	UI = {
		{ message = "StartMissionTelopFadeIn",		localFunc = "_OnOpeningTransitionStart" },
		{ message = "StartMissionTelopFadeOut",		localFunc = "_OnOpeningTransitionEnd" },
		{ message = "StartMissionTelopBgFadeOut",	localFunc = "_OnOpeningTransitionBgEnd" },
		{ message = "EndMissionTelopStartNextLoading",	localFunc = "_OnEndingStartNextLoading" },
		{ message = "EndMissionTelopFadeIn",		localFunc = "_OnEndingTransitionStart" },
		{ message = "EndMissionTelopFadeOut",		localFunc = "_OnEndingTransitionEnd" },
		{ message = "EndMissionTelopRadioStop",		localFunc = "_OnEndingTransitionRadioStop" },
	},
	
	Timer = {
		{ data = "StartTransitionFadeOut_End",	message = "OnEnd", localFunc = "_OnOpeningTransitionFadeOutEnd" },
		{ data = "EndTransitionFadeOut_End",	message = "OnEnd", localFunc = "_OnEndingTransitionFadeOutEnd" },
		{ data = "StartTransitionFadeIn_End",	message = "OnEnd", localFunc = "_OnOpeningTransitionFadeInEnd" },
		{ data = "EndTransitionFadeIn_End",		message = "OnEnd", localFunc = "_OnEndingTransitionFadeInEnd" },
	},
}






this.FadeIn = function( frameNum )
	TppPlayer.DisableControlMode( "LockPadMode" )
	FadeFunction.CallFadeIn( frameNum )



end


this.FadeOut = function( frameNum )
	TppPlayer.EnableControlMode( "LockPadMode" )
	FadeFunction.CallFadeOut( frameNum )



end


this.ShowTransition = function( transitionType, funcs )
	this._ShowTransition( transitionType, false, funcs )
end


this.ShowTransitionInGame = function( transitionType, funcs )
	this._ShowTransition( transitionType, true, funcs )
end




this.ShowTransitionWithFadeOut = function( transitionType, funcs, fadeOutSec )
	if fadeOutSec ~= nil then
		if( transitionType == "opening" ) then
			TppTimer.Start( "StartTransitionFadeOut_End", fadeOutSec )
		elseif( transitionType == "ending" ) then
			TppTimer.Start( "EndTransitionFadeOut_End", fadeOutSec )
		else



			return
		end	
		this.m_transitionFuncs[transitionType] = funcs
		this.FadeOut( fadeOutSec )
		this.m_onEndFadeInSec = nil
		this._DisableGameStatusOnFade()
	else
		this._ShowTransition( transitionType, false, funcs )
	end

end




this.ShowTransitionWithFadeIn = function( transitionType, funcs, fadeInSec )
	this._ShowTransition( transitionType, false, funcs, fadeInSec )
end





this.ShowTransitionWithFadeOutIn = function( transitionType, funcs, fadeOutSec, fadeInSec )
	if fadeOutSec ~= nil then
		if( transitionType == "opening" ) then
			TppTimer.Start( "StartTransitionFadeOut_End", fadeOutSec )
		elseif( transitionType == "ending" ) then
			TppTimer.Start( "EndTransitionFadeOut_End", fadeOutSec )
		else



			return
		end	
		this.m_onEndFadeInSec = fadeInSec
		this.m_transitionFuncs[transitionType] = funcs
		this.FadeOut( fadeOutSec )
		this._DisableGameStatusOnFade()
	else
		this._ShowTransition( transitionType, false, funcs, fadeInSec )
	end
end



this.ShowAllMarkers = function()
	TppCommon.DeprecatedFunction( "HudCommonDataManager.GetInstance():StartWorldMarkerObj()" )
	this.m_hudData:StartWorldMarkerObj()
end


this.ShowIcon = function( tutorialName, iconName )
	TppCommon.DeprecatedFunction( "HudCommonDataManager.GetInstance():CallButtonGuide( tutorialName, iconName )" )
	this.m_hudData:CallButtonGuide( tutorialName, iconName )
end






this.Start = function()
	
	this.m_hudData = HudCommonDataManager.GetInstance()
	if( this.m_hudData == NULL ) then



		return
	end

	
	this.m_uiData = UiCommonDataManager.GetInstance()
	if( this.m_uiData == NULL ) then



		return
	end
end


this._ShowTransition = function( transitionType, inGame, funcs, fadeInSec )
	this.m_onEndFadeInSec = fadeInSec
	this.m_transitionFuncs[transitionType] = nil 

	
	if( transitionType == "opening" ) then
		if( inGame == false) then
			TppGameStatus.Set("TppUI.lua","S_DISABLE_GAME")
		end
		this.m_hudData:CallMissionStartTelop()
	elseif( transitionType == "ending" ) then
		if( inGame == false) then
			TppGameStatus.Set("MissionManager","S_DISABLE_GAME")
			TppGameStatus.Set("TppUI.lua","S_DISABLE_GAME")
		end
		this.m_hudData:CallMissionEndTelop()
	else



		return
	end	

	
	if( funcs ~= nil ) then
		this.m_transitionFuncs[transitionType] = funcs
		this._PlayBGM( transitionType, funcs.playBGM )
	end
end


this._DisableGameStatusOnFade = function()
	TppGameStatus.Set("TppUI.lua","S_DISABLE_TARGET")
	TppGameStatus.Set("TppUI.lua","S_DISABLE_TRAP")
	TppGameStatus.Set("TppUI.lua","S_DISABLE_PLAYER_PAD")
end

this._EnableGameStatusOnFade = function()
	TppGameStatus.Reset("TppUI.lua","S_DISABLE_TARGET")
	TppGameStatus.Reset("TppUI.lua","S_DISABLE_TRAP")
	TppGameStatus.Reset("TppUI.lua","S_DISABLE_PLAYER_PAD")
end


this.OnOpeningTransitionStart = function()
end


this.OnOpeningTransitionEnd = function()
	TppGameStatus.Reset("TppUI.lua","S_DISABLE_GAME")
	if this.m_onEndFadeInSec ~= nil then
		this.FadeIn( this.m_onEndFadeInSec )
		TppTimer.Start( "StartTransitionFadeIn_End", this.m_onEndFadeInSec )
		this._DisableGameStatusOnFade()
	else
		this._EnableGameStatusOnFade()
	end
end


this.OnOpeningTransitionBgEnd = function()
end


this.OnEndingStartNextLoading = function()
end


this.OnEndingTransitionStart = function()
end


this.OnEndingTransitionEnd = function()

	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:StopDirect()

	TppGameStatus.Reset("TppUI.lua","S_DISABLE_GAME")
	if this.m_onEndFadeInSec ~= nil then
		this.FadeIn( this.m_onEndFadeInSec )
		TppTimer.Start( "EndTransitionFadeIn_End", this.m_onEndFadeInSec )
		this._DisableGameStatusOnFade()
	else
		this._EnableGameStatusOnFade()
	end
end


this.EnableHUD = function()
	TppCommon.DeprecatedFunction( "UiCommonDataManager.GetInstance():ResetDemoSettingForHud()" )
	UiCommonDataManager.GetInstance():ResetDemoSettingForHud()
end


this.DisableHUD = function()
	TppCommon.DeprecatedFunction( "UiCommonDataManager.GetInstance():SetDemoSettingForHud()" )
	UiCommonDataManager.GetInstance():SetDemoSettingForHud()
end


this.EnableTerminal = function()
	TppCommon.DeprecatedFunction( "UiCommonDataManager.GetInstance():ResetDemoSettingForMBDvc()" )
	UiCommonDataManager.GetInstance():ResetDemoSettingForMBDvc()
end


this.DisableTerminal = function()
	TppCommon.DeprecatedFunction( "UiCommonDataManager.GetInstance():SetDemoSettingForMBDvc()" )
	UiCommonDataManager.GetInstance():SetDemoSettingForMBDvc()
end






this._OnOpeningTransitionStart = function()
	this.OnOpeningTransitionStart()
	this._DoMessage( "opening", "onStart" )
end


this._OnOpeningTransitionEnd = function()
	this.OnOpeningTransitionEnd()
	this._DoMessage( "opening", "onEnd" )
end


this._OnOpeningTransitionBgEnd = function()
	this.OnOpeningTransitionBgEnd()
	this._DoMessage( "opening", "onOpeningBgEnd" )
end


this._OnEndingStartNextLoading = function()
	this.OnEndingStartNextLoading()
	this._DoMessage( "ending", "onEndingStartNextLoading" )
end


this._OnEndingTransitionStart = function()
	this.OnEndingTransitionStart()
	this._DoMessage( "ending", "onStart" )
end


this._OnEndingTransitionEnd = function()
	this.OnEndingTransitionEnd()
	this._DoMessage( "ending", "onEnd" )
end


this._OnEndingTransitionRadioStop = function()
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:StopDirect()
end


this._OnOpeningTransitionFadeOutEnd = function()
	this._ShowTransition( "opening", false, this.m_transitionFuncs["opening"],this.m_onEndFadeInSec )
end


this._OnEndingTransitionFadeOutEnd = function()
	this._ShowTransition( "ending", false, this.m_transitionFuncs["ending"],this.m_onEndFadeInSec )
end


this._OnOpeningTransitionFadeInEnd = function()
	this._EnableGameStatusOnFade()
end


this._OnEndingTransitionFadeInEnd = function()
	this._EnableGameStatusOnFade()
end


this._DoMessage = function( transitionName, funcName )
	if( this.m_transitionFuncs == nil or this.m_transitionFuncs[transitionName] == nil or this.m_transitionFuncs[transitionName][funcName] == nil ) then return end
	this.m_transitionFuncs[transitionName][funcName]()
	
	this.m_transitionFuncs[transitionName][funcName] = nil
end


this._PlayBGM = function( transitionType, bgmName )
	if( bgmName ~= nil ) then
		TppSoundDaemon.PostEvent( bgmName )
	end
end




this.m_hudData = nil
this.m_uiData = nil
this.m_transitionFuncs = {}
this.m_onEndFadeInSec = nil 




return this
