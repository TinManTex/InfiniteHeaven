local this = {}






this.Setup = function()
	
	GkEventTimerManager.StopAll()
end


this.Start = function( timerName, timerTime )
	TppCommon.DeprecatedFunction( "GkEventTimerManager.Start( timerName, timerTime )" )
	GkEventTimerManager.Start( timerName, timerTime )
end


this.Stop = function( timerName )
	TppCommon.DeprecatedFunction( "GkEventTimerManager.Stop( timerName )" )
	GkEventTimerManager.Stop( timerName )
end


this.StopAll = function()
	TppCommon.DeprecatedFunction( "GkEventTimerManager.StopAll()" )
	GkEventTimerManager.StopAll()
end


this.IsTimerActive = function( timerName )
	TppCommon.DeprecatedFunction( "GkEventTimerManager.IsTimerActive( timerName )" )
	return GkEventTimerManager.IsTimerActive( timerName )
end




return this