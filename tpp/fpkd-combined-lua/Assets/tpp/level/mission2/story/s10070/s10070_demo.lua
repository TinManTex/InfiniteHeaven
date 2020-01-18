local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_SahelanTest		= "p31_040010_000_final",	
	Demo_GetIntel			= "p31_010025",				
	Demo_ContactHuey		= "p31_040110",				
	Demo_RideMetal			= "p31_040130_000_final",	
	Demo_SahelanHerald01	= "p31_040135_000",			
	Demo_SahelanHerald02	= "p31_040135_001",			
	Demo_SahelanAttacks		= "p31_040140",				
	Demo_SahelanFalling		= "p31_040160_000_final",	
	Demo_MotherBase			= "p31_040200_000_final",	

}




this.demoBlockList = {
	Demo_SahelanTest 		= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d01.fpk" },	
	Demo_GetIntel			= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d07.fpk" },	
	Demo_ContactHuey 		= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d02.fpk" },
	Demo_RideMetal 			= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d06.fpk" },	
	Demo_SahelanHerald01 	= {
								TppDefine.MISSION_COMMON_PACK.EAST_TRUCK,
								"/Assets/tpp/pack/mission2/story/s10070/s10070_d08.fpk"
							 },	
	Demo_SahelanHerald02 	= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d08.fpk" },	
	Demo_SahelanAttacks 	= {
								TppDefine.MISSION_COMMON_PACK.SKULLFACE,
								TppDefine.MISSION_COMMON_PACK.EAST_TRUCK,
								"/Assets/tpp/pack/mission2/story/s10070/s10070_d03.fpk",
							 },
	Demo_SahelanFalling 	= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d04.fpk" },
	Demo_MotherBase 		= { "/Assets/tpp/pack/mission2/story/s10070/s10070_d05.fpk" },	
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10211_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening{ onEnd 	= function() func() end,	}
end


this.SahelanTest = function( startFunc, endFunc )
	TppDemo.Play("Demo_SahelanTest",
		{
			onStart = function() startFunc() end,
			onEnd = function() endFunc() end,
		},
		{
			useDemoBlock = true,
			startNoFadeIn = true,
			finishFadeOut = true
		}
	)
end

this.GetIntel = function( endFunc )
	Fox.Log("#### s10070_demo.GetIntel_powerPlant ####")
	TppDemo.PlayGetIntelDemo(
		{
		
			onEnd = function() endFunc() end,
		},
		"GetIntelIdentifier",
		"GetIntel_HueyPos",
		{
			useDemoBlock = true
		},
		true
	)
end

this.ContactHuey = function( startFunc, endFunc )
	TppDemo.Play(
		"Demo_ContactHuey",
		{
			onStart = function() startFunc() end,
			onEnd = function() endFunc() end,
		},

		{ useDemoBlock = true, }
	)
end


this.RideMetal = function( startFunc, endFunc )
	TppDemo.Play(
		"Demo_RideMetal",
		{
			onStart = function() startFunc() end,
			onEnd = function() endFunc() end,
		},
		{
			useDemoBlock = true,
		
		}
	)
end


this.SahelanHerald01 = function(func)
	TppDemo.Play(
		"Demo_SahelanHerald01", { onEnd = function() func() end,},
		{ useDemoBlock = true, isSnakeOnly = false, }
	)
end


this.SahelanHerald02 = function(func)
	TppDemo.Play(
		"Demo_SahelanHerald02", { onEnd = function() func() end,},
		{ useDemoBlock = true,
		 finishFadeOut = true,
		 isSnakeOnly = false,
		 }
	)
end


this.SahelanAttacks = function(func)
	TppDemo.Play(
		"Demo_SahelanAttacks", { onEnd = function() func() end,},
		{ 
			useDemoBlock = true, 
			startNoFadeIn = true,
		}
	)
end


this.BoardingHeli = function(func)
	TppDemo.Play(
		"Demo_BoardingHeli", { onEnd = function() func() end,},
		{ useDemoBlock = true, }
	)
end


this.SahelanFalling = function(func)
	TppDemo.Play(
		"Demo_SahelanFalling", { onEnd = function() func() end,},
		{
			useDemoBlock = true,
			isExecMissionClear = true,	
			
			finishFadeOut = true,
		}
	)
end


this.MotherBase = function(func)
	TppDemo.Play(
		"Demo_MotherBase", { onEnd = function() func() end,},
		{
			useDemoBlock = true,
			isExecMissionClear = true,	
			finishFadeOut = true,
			startNoFadeIn = true,
		}
	)
end




return this
