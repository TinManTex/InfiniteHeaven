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
		bgm_sahelan_01 = {
				start = "Play_bgm_s10070_sahelan",
				finish = "Stop_bgm_s10070_sahelan",
				switch = {
						"Set_Switch_bgm_s10070_sahelan_al",
						"Set_Switch_bgm_s10070_sahelan_ev",
						"Set_Switch_bgm_s10070_sahelan_sn",

                },

		},
}



return this
