local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.demoList = {
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




return this
