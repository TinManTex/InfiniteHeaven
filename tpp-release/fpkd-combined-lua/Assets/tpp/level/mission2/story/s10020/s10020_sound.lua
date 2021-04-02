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
        bgm_parasites = {
                start = "Play_bgm_s10020_parasites",
                finish = "Set_Switch_bgm_s10020_parasites_ed",
                restore = "Set_Switch_bgm_s10020_parasites_sp",
					
				switch = {
					"Set_Switch_bgm_s10020_parasites_sp",

					"Set_Switch_bgm_s10020_parasites_sn",
					"Set_Switch_bgm_s10020_parasites_al",
					"Set_Switch_bgm_s10020_parasites_ed",
				},
        },
        bgm_afghanistan = {
                start = "Play_bgm_s10020_afghanistan",
                finish = "Stop_bgm_s10020_afghanistan",
        },
}




return this
