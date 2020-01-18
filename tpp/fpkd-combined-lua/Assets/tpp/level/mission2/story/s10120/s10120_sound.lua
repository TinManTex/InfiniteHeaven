local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table








function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end

this.bgmList = {
		bgm_liquid = {
        },
		bgm_eli = {
                start = "Play_bgm_s10120_eli",
				finish = "Stop_bgm_s10120_eli",
				switch = {
					"Set_Switch_bgm_s10120_eli_al",
					"Set_Switch_bgm_s10120_eli_sn",
					"Set_Switch_bgm_s10120_eli_ed",




				},
        },
}




return this
