local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {

	Demo_RecoverReptilePod	= "p31_060010",				
	
	Demo_AttackedByQuiet_1	= "p31_030100_000",			
	Demo_AttackedByQuiet_2	= "p31_030100_001",			
	
	Demo_RescueSpecial		= "p31_080010_000_final",	
	
	Demo_RecoverVolgin		= "p31_080100_000_final"
}




this.demoBlockList = {
}




function this.LoadOpeningDemoBlock()
	
	TppAnimalBlock.StopAnimalBlockLoad()
	
	TppScriptBlock.Load(
		"animal_block",
		"_openingDemo",
		true, 
		true 
	)
end

function this.PlayOpening()
	
	TppDemo.PlayOpening(
		{
			onEnd = function()
				TppMission.MissionFinalize{
					isNoFade = true, showLoadingTips = false, setMute = "Telop",
				}
			end,
		},
		{ useDemoBlock = true, finishFadeOut = true, isExecMissionClear = true, fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED }
	)
end

function this.PlayRecoverVolgin( startFunc, endFunc )
	Fox.Log("***** f30010_demo:PlayRecoverVolgin *****")
	TppDemo.Play("Demo_RecoverVolgin",
		{
			onStart = function() startFunc() end,
			onEnd = function() endFunc() end,
		},
		{
			useDemoBlock = false,
			finishFadeOut = true
		}
	)
end



return this
