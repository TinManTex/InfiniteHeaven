local this = {}






this.PlayBGM = function( bgmName )
	TppMusicManager.StartSceneMode()
	TppMusicManager.PlaySceneMusic( bgmName )
end


this.StopBGM = function( bgmName )
	TppMusicManager.PlaySceneMusic( bgmName )
	TppMusicManager.EndSceneMode()
end


this.PlayEvent = function( eventName )
	TppCommon.DeprecatedFunction( "TppSoundDaemon.PostEvent( eventName )" )
	TppSoundDaemon.PostEvent( eventName )
end


this.RegisterSourceEvent = function( name, tag, playEvent, stopEvent )
	TppCommon.DeprecatedFunction( "TppSoundDaemon.GetInstance():RegisterSourceEvent( event )" )
	this.m_manager:RegisterSourceEvent{
		sourceName	= name,
		tag			= tag,
		playEvent	= playEvent,
		stopEvent	= stopEvent,
	}
end


this.UnregisterSourceEvent = function( name, tag )
	TppCommon.DeprecatedFunction( "TppSoundDaemon.GetInstance():UnregisterSourceEvent( event )" )
	this.m_manager:UnregisterSourceEvent{
		sourceName	= name,
		tag			= tag,
	}
end




this.Start = function()
	this.m_manager = TppSoundDaemon.GetInstance()
end




this.m_manager = nil




return this