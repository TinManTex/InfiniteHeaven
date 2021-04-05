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
        bgm_metallic = {
                start = "Play_bgm_s10140_metallic",
                finish = "Set_Switch_bgm_s10140_metallic_ed",
                restore = "Set_Switch_bgm_s10140_metallic_op",
				switch = {
					"Set_Switch_bgm_s10140_metallic_op",
					"Set_Switch_bgm_s10140_metallic_sn",
					"Set_Switch_bgm_s10140_metallic_al",
					"Set_Switch_bgm_s10140_metallic_ed",
				},
        },
        bgm_post_metallic = {
                start = "Play_bgm_s10140_post_metallic",
                finish = "Stop_bgm_s10140_post_metallic",
        },
}



return this
