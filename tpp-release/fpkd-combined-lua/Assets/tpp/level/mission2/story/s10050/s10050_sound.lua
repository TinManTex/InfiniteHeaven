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
        bgm_quiet = {
                start = "Play_bgm_s10050_quiet",
                finish = "Stop_bgm_s10050_quiet",
                restore = "Set_Switch_bgm_boss_phase_none",
				switch = {
					"Set_Switch_bgm_boss_phase_op",
					"Set_Switch_bgm_boss_phase_sn",
					"Set_Switch_bgm_boss_phase_al",
					"Set_Switch_bgm_boss_phase_nt",
					"Set_Switch_bgm_boss_phase_ed",
				},
        },
}




return this
