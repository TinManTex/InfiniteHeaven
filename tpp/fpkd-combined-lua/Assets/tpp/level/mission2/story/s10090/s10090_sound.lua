local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.bgmList = {
}






this.USE_COMMON_ESCAPE_BGM = false








function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end




this.bgmList = {
	bgm_metallic2 = {
		start	= "Play_bgm_s10090_metallic",
		finish	= "Stop_bgm_s10090_metallic",
		restore = "Set_Switch_bgm_s10090_metallic_op",
		switch	= {
			"Set_Switch_bgm_s10090_metallic_sn",
			"Set_Switch_bgm_s10090_metallic_al",
			"Set_Switch_bgm_s10090_metallic_ed",
		},
	},
	bgm_escape = {
		start	= "Play_bgm_mafr_mission_escape",
		finish	= "Stop_bgm_mafr_mission_escape",
	}
}





function this.SetUp()
	if s10090_sequence.IsMainSequence() == true then
		if svars.isDyingAllParasites == true then
			TppSound.SetSceneBGM( "bgm_escape" )
		end
	else
		TppSound.SetSceneBGM( "bgm_escape" )
	end
end


function this.SetParasitesStart()
	TppSound.SetSceneBGM("bgm_metallic2")
end


function this.SetParasitesStartedCombat()
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10090_metallic_al")
end


function this.SetParasitesStartedSearch()
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10090_metallic_sn")
end


function this.SetParasitesEnd()
	TppSound.SetSceneBGM( "bgm_escape" )
end




return this
