






gntn_load = {

OnEnterStartGame = function()



	
	local mm = TppMissionManager:GetInstance()

	
	
	mm:SetMissionEnable("m9904")
	mm:RequestAcceptMission("m9904")

	
	








	local wm=TppWeatherManager:GetInstance()
	wm:SwitchWeatherDesc("location",7,0) 
	
	wm:PauseNewWeatherChangeRandom(true) 
	
	wm:PauseClock(true) 
	wm:SetCurrentClock(00,00)

end,

OnUpdateMissionPlayable = function( )

	local mm = TppMissionManager:GetInstance()
	mm:SetMissionEnable("m9904")

end,


}
