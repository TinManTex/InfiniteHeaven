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
        bgm_volgin_02 = {
                start = "Play_bgm_s10110_volgin_02",
                finish = "Stop_bgm_s10110_volgin_02",
                restore = "Set_Switch_bgm_boss_phase_none",
				switch = {
					"Set_Switch_bgm_boss_phase_al",
					"Set_Switch_bgm_boss_phase_ed",
					"Set_Switch_bgm_boss_phase_none",
					"Set_Switch_bgm_boss_phase_sn",
				},
        },
        bgm_volgin = {
                start = "Play_bgm_s10110_volgin_01",
                finish = "Stop_bgm_s10110_volgin_01",
                restore = "Set_Switch_bgm_boss_phase_none",
				switch = {
					"Set_Switch_bgm_boss_phase_al",
					"Set_Switch_bgm_boss_phase_ed",
					"Set_Switch_bgm_boss_phase_none",
					"Set_Switch_bgm_boss_phase_sn",
				},
        },
        bgm_factory = {
                start = "Play_bgm_s10110_factory",
                finish = "Stop_bgm_s10110_factory",
        },
}

this.startHeliClearJingleName = "" 



return this
