local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_Opening	= "p51_070020_000_final",
	Demo_GoToInside	= "p51_070110_000_final",
	Demo_Roof_Event = "p51_070220_000_final",
	Demo_Exit		= "p51_070300_000_final",
	Demo_Funeral 	= "p51_070500_000_final",
	Demo_EnterInMBQF = "p51_070120_000_final",
	Demo_ExitWithLiveMan	= "p51_070280_000_final",
}

this.demoBlockList = {
	Demo_Opening 		= { "/Assets/tpp/pack/mission2/story/s10240/s10240_d01.fpk" },
	Demo_GoToInside	 	= { "/Assets/tpp/pack/mission2/story/s10240/s10240_d02.fpk" },
	Demo_Funeral	 	= { "/Assets/tpp/pack/mission2/story/s10240/s10240_d03.fpk" },
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


this.PlayFuneralDemo = function(func)
	Fox.Log("#### PlayFuneralDemo ####")

	local translation, rotQuat = MotherBaseStage.GetDemoCenter()
	DemoDaemon.SetDemoTransform( this.demoList.Demo_Funeral, rotQuat, translation )

	
	local canSortie = TppBuddyService.CanSortieBuddyType(BuddyType.DOG)
	if canSortie == false then
		
		TppDemoUtility.SetInvisibleUniqueCharacter{invisible = { "Dog" }}
	end

	TppDemo.Play( "Demo_Funeral",
		{ 
			onInit = function() 
				
				TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )
			end,		
			onEnd = function()
				gvars.s10240_isPlayedFuneralDemo = true	
				func()
			end,
		},
		{
			startNoFadeIn = true,
			finishFadeOut = true,
			isExecMissionClear=true,
			useDemoBlock = true,
			waitBlockLoadEndOnDemoSkip = false,
		}
	) 
end



return this
