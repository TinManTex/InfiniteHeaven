








gntn_load2 = {

OnEnterStartGame = function()



	

	WeatherManager.LoadNewWeatherParametersFile("/Assets/tpp/level/location/gntn/block_common/gntn_climateSettings.twpf")
	WeatherManager.SwitchWeatherDesc("location",7,0) 
	WeatherManager.RequestWeather(5,0) 
	WeatherManager.PauseNewWeatherChangeRandom(true) 
	
	WeatherManager.PauseClock(true) 
	WeatherManager.SetCurrentClock(00,00)
	
	TppEffectUtility.SetColorCorrectionLut( "/Assets/tpp/effect/gr_pic/lut/gntn_25thDemo_FILTERLUT.ftex" )
end,

}
