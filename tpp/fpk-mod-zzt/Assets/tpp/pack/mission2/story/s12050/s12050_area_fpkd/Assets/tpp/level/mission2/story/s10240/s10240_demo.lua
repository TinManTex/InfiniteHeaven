--DEBUGNOW
local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
}

this.demoBlockList = {
}




this.PlayOpeningDemo = function(func)
	Fox.Log("#### PlayDemo ####")

	TppDemo.Play( 
		"Demo_Opening",
		{ 
			onInit = function() 
				
				TppClock.SetTime( "00:00:00" )
				
				TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
			end,
			onEnd = function() 
				
				TppClock.SetTime(  "17:00:00" )
				TppWeather.CancelRequestWeather()
				func() 
			end,
		},
		{
			useDemoBlock = true,
			finishFadeOut = true,
			startNoFadeIn = true,
		} 
	) 
end

this.PlayGoToInside = function(func)
	Fox.Log("#### PlayDemo ####")

	local translation, rotQuat = MotherBaseStage.GetDemoCenter()
	DemoDaemon.SetDemoTransform( this.demoList.Demo_GoToInside, rotQuat, translation )

	TppDemo.Play( 
		"Demo_GoToInside",
		{ 
			onEnd = function() func() end,
		},
		{
			finishFadeOut = true,
			useDemoBlock = true,
			waitBlockLoadEndOnDemoSkip = false,
		}
	) 
end

this.PlayEnterInMbqf = function(func)
	Fox.Log("#### PlayEnterInMbqf ####")

	TppDemo.Play( 
		"Demo_EnterInMBQF",
		{ 
			onEnd = function() func() end,
		},
		{
			startNoFadeIn = true,
			
		}
	) 
end


this.PlayRoofDemo = function(func,startFunc)
	Fox.Log("#### PlayRoofDemo ####")
	TppDemo.Play( 
		"Demo_Roof_Event",
		{ 
		onInit = function() 
			
			TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
		end,
		onStart = function()
			startFunc()
		end,
		onEnd = function() 
			func() 
		end,
		
		} 
	
	) 
end

this.PlayExitDemo = function(func)
	Fox.Log("#### PlayExitDemo ####")
	TppDemo.Play( "Demo_Exit",
	{ 
		onInit = function() 
			
			TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
		end,
		onEnd = function() func() end,
	},
	{
		waitBlockLoadEndOnDemoSkip = false,
		finishFadeOut = true,
	}
	 ) 
end


this.PlayExitWithLiveMan = function(func)
	Fox.Log("#### PlayExitWithLiveMan ####")


	TppDemo.Play( 
		"Demo_ExitWithLiveMan",
		{ 
			onInit = function() 
				
				TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
			end,
			onEnd = function() func() end,
		},
		{
			nil,
			
		}
	) 
end

return this
