








tpp_default_setting = {





events = {
	clockListener = {
		clock_mafrDay_clockEventMessage = "OnClockMafrDay",		
		clock_mafrNight_clockEventMessage = "OnClockMafrNight",	
		clock1900_clockEventMessage = "OnClock1900"
		},
},






OnClockMafrDay = function( data, body, sender, id, hour, minute, arg3, arg4 )




	return true

end,


OnClockMafrNight = function( data, body, sender, id, hour, minute, arg3, arg4 )




	return true

end,


OnClock1900 = function( data, body, sender, id, hour, minute, arg3, arg4 )

	local wm=TppWeatherManager:GetInstance()
	wm:DebugSetCurrentClock(06,30)
	return true

end,

}
