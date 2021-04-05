
local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_ArrivalInAfghanistan		= "p31_010010",	
	Demo_RescueMillerExplanation	= "p31_010020",	
	Demo_GetIntel					= "p31_010025",	
	Demo_RescueMiller				= "p31_010030",	
	Demo_TimeOverDeadMiller			= "p31_010035",	
	Demo_ParasiteAppearance			= "p31_010040",	
	Demo_ParasiteDiscover_upper			= "p31_010045",	

	Demo_EscapeWithMillerOnHeli		= "p31_010050",	
}




this.demoBlockList = {
	Demo_ArrivalInAfghanistan 		= { 
										
										"/Assets/tpp/pack/mission2/story/s10020/s10020_d01.fpk" },

	Demo_RescueMiller				= { "/Assets/tpp/pack/mission2/story/s10020/s10020_d03.fpk" },
	Demo_ParasiteAppearance			= { "/Assets/tpp/pack/mission2/story/s10020/s10020_d04.fpk" },
	Demo_EscapeWithMillerOnHeli		= { "/Assets/tpp/pack/mission2/story/s10020/s10020_d05.fpk" },
}




this.ArrivalInAfghanistan = function(funcs)
	TppDemo.Play("Demo_ArrivalInAfghanistan",funcs, 
					{ useDemoBlock = true,}
				)
end


this.RescueMillerExplanation = function(func)
	TppDemo.Play("Demo_RescueMillerExplanation",{ onEnd = function() func() end,} , {
                        useDemoBlock = true,})
end


this.GetIntel_village = function(func)
	TppDemo.PlayGetIntelDemo({ onEnd = function() func() end,},"GetIntelIdentifier","GetIntel_village")
end


this.GetIntel_commFacility = function(func)
	TppDemo.PlayGetIntelDemo({ onEnd = function() func() end,},"GetIntelIdentifier","GetIntel_commFacility")
end


this.RescueMiller = function(func)
	TppDemo.Play(
		"Demo_RescueMiller", { onEnd = func },		
		{ useDemoBlock = true, interpGameToDemo = false, }
	)
end


this.TimeOverDeadMiller = function(func)
	TppDemo.Play(
		"Demo_TimeOverDeadMiller", { onEnd = function() func() end, },		
		{ useDemoBlock = true, interpGameToDemo = false, isExecGameOver = true }
	)
end


this.ParasiteAppearance = function(func)
	TppDemo.Play("Demo_ParasiteAppearance",{ onEnd = function() func() end,}, {
                        useDemoBlock = true,
						isSnakeOnly = false,})
end


this.ParasiteDiscover_upper = function(startfunc,endfunc)
	TppDemo.Play("Demo_ParasiteDiscover_upper",
					{ 
						onStart = function() startfunc() end,
						onEnd = function() endfunc() end,
					}, 
					{	
						useDemoBlock = true,
						isSnakeOnly = false,
					})
end












this.EscapeWithMillerOnHeli = function(func)
	TppDemo.Play("Demo_EscapeWithMillerOnHeli",{ onEnd = function() func() end,} , {
                        useDemoBlock = true,
                        finishFadeOut = true,
                        waitBlockLoadEndOnDemoSkip = false,	
						isExecMissionClear = true,})
end




return this
