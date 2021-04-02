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
		bgm_sahelan_02 = {
				start = "Play_bgm_s10151_sahelan",
				finish = "Stop_bgm_s10151_sahelan",
				switch = {
						"Set_Switch_bgm_s10151_normal",
						"Set_Switch_bgm_s10151_up",
                },

		},
}



return this
