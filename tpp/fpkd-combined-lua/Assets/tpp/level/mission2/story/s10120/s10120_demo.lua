local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_Liquid_combatcamera 		= "p41_010005",
	Demo_Liquid_combat 		= "p41_010010_000_final",
	Demo_Liquid_combatEnd 	= "p41_010030_000_final",	
	Demo_Liquid_HeliEscape 	= "p41_010040_000_final",
}

this.demoBlockList = {
	Demo_Liquid_combatcamera 		= { "/Assets/tpp/pack/mission2/story/s10120/s10120_d01.fpk" },
	Demo_Liquid_combat 		= { "/Assets/tpp/pack/mission2/story/s10120/s10120_d01.fpk" },
	Demo_Liquid_combatEnd	= { "/Assets/tpp/pack/mission2/story/s10120/s10120_d02.fpk" },
	Demo_Liquid_HeliEscape	= { "/Assets/tpp/pack/mission2/story/s10120/s10120_d03.fpk" },
}




this.PlayLiquidTest0 = function(func)
	TppDemo.Play(
		"Demo_Liquid_combatcamera",
		{ 
			onEnd = function() func() end,
		}, 
		{
			useDemoBlock = true,
			isSnakeOnly = false,
		}
	)
end

this.PlayLiquidTest = function(func)
	TppDemo.Play(
		"Demo_Liquid_combat",
		{ 
			onStart = function() 

			if vars.isKikongoTranslatable == 1 then
				
				TppSoundDaemon.PostEvent( 'set_state_lang_kikongo' )
			else
				
				TppSoundDaemon.PostEvent( 'set_state_lang_original' )
			end

			func() end,
			
			onEnd = function() 
			
			
			TppSoundDaemon.PostEvent( 'set_state_lang_none' )

			func() end,
		}, 
		{
			useDemoBlock = true,
		}
	)
end

this.PlayLiquidTest2 = function(funcs)
	TppDemo.Play("Demo_Liquid_combatEnd",funcs, 
					{ useDemoBlock = true,}
	)
end

this.PlayLiquidTest3 = function(func)
	Fox.Log("plsy cemo")
	TppDemo.Play(
		"Demo_Liquid_HeliEscape",
		{ 
			onEnd = function() func() end,
		},
		{
			useDemoBlock = true,
			isExecMissionClear = true,
			finishFadeOut		= true
		}
	)
end




return this
