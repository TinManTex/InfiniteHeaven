local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
	Demo_EncountQuiet		= "p31_070005", 
	Demo_QuietChoked 		= "p31_070010",	

	Demo_AfterTankBattle	= "p31_070015_000_final",	
	Demo_SnakeBite_01		= "p31_070020_000_final",	
	Demo_SnakeBite_02		= "p31_070020_001_final",	
	Demo_QuietSpeak			= "p31_070030_000_final",	
	Demo_QuietVanishing		= "p31_070040_000_final",	
	Demo_CameraForLetter	= "p31_070050_002",	
	Demo_LetterFromQuiet	= "p31_070050_000_final",	
	Demo_QuietDrifted		= "p31_070050_001_final",	
}

this.demoBlockList = {
	Demo_EncountQuiet		= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d00.fpk" },	
	Demo_QuietChoked		= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d01.fpk" },	

	Demo_AfterTankBattle	= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d02.fpk" },	
	Demo_SnakeBite_01		= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d03.fpk" },	
	Demo_SnakeBite_02		= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d03.fpk" },	
	Demo_QuietSpeak			= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d04.fpk" },	
	Demo_QuietVanishing		= { TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT,"/Assets/tpp/pack/mission2/story/s10260/s10260_d05.fpk" },	
	Demo_CameraForLetter	= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d06.fpk" },	
	Demo_LetterFromQuiet	= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d06.fpk" },	
	Demo_QuietDrifted		= { "/Assets/tpp/pack/mission2/story/s10260/s10260_d06.fpk","/Assets/tpp/pack/mission2/story/s10260/s10260_ending.fpk" },	
}





this.PlayOpeningDemo = function(func)
	Fox.Log("#### s10211_demo.PlayOpeningDemo ####")
	TppDemo.PlayOpening{ onEnd = function() func() end,} 
end


this.EncountQuiet = function(func)
	TppDemo.Play("Demo_EncountQuiet",{ onEnd = func }, { useDemoBlock = true, finishFadeOut = true, isSnakeOnly = false, } )
end


this.QuietChoked = function(func)
	TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_0000", false ) 
	TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_vrtn004_0001", true )	
	TppDemo.Play("Demo_QuietChoked",{ onEnd = func }, { useDemoBlock = true, startNoFadeIn = true,} )
end


this.AfterTankBattle = function(func)
	TppDemo.Play("Demo_AfterTankBattle",{ onEnd = func }, { useDemoBlock = true, startNoFadeIn = true,} )
end


this.SnakeBite_01 = function(func)
	TppDemo.Play("Demo_SnakeBite_01",{ onEnd = func }, { useDemoBlock = true, finishFadeOut = true, isExecMissionClear = true } )
end


this.SnakeBite_02 = function(func)
	TppDemo.Play("Demo_SnakeBite_02",{ onEnd = func }, { useDemoBlock = true, finishFadeOut = true, startNoFadeIn = true, isExecMissionClear = true } )
end


this.QuietSpeak = function(func)
	TppDemo.Play("Demo_QuietSpeak",{ onEnd = func }, { useDemoBlock = true, finishFadeOut = true, startNoFadeIn = true, isExecMissionClear = true } )
end


this.QuietVanishing = function(func)
	TppDemo.Play("Demo_QuietVanishing",{ onStart = function() TppSoundDaemon.ResetMute( 'Loading' ) end, onEnd = func }, { useDemoBlock = true,  startNoFadeIn = true, isExecMissionClear = true } )
end


this.CameraForLetter = function(func)
	TppDemo.Play("Demo_CameraForLetter",{ onEnd = func }, { useDemoBlock = true, isExecMissionClear = true, isSnakeOnly = false, } )
end


this.LetterFromQuiet = function(func)
	TppDemo.Play("Demo_LetterFromQuiet",{ onEnd = func }, { useDemoBlock = true, finishFadeOut = true, isExecMissionClear = true } )
end


this.QuietDrifted = function(func)
	TppDemo.Play("Demo_QuietDrifted",{ onEnd = func }, { useDemoBlock = true, finishFadeOut = true, isExecMissionClear = true, isSnakeOnly = false, } )
end




return this
