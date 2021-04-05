local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.bgmList = {
	bgm_volgin_ride = {
		start = "Play_bgm_s10010_volgin_ride",
		finish = "Stop_bgm_s10010_volgin_ride",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_02",
			"Set_Switch_bgm_s10010_sw_03",
		},
	},
	bgm_4th_floor = {
		start = "Play_bgm_s10010_4f",
		finish = "Stop_bgm_s10010_4f",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_02",
			"Set_Switch_bgm_s10010_sw_03",
		},
	},
	bgm_volgin_gone = {
		start = "Play_bgm_s10010_volgin_gone",
		finish = "Stop_bgm_s10010_volgin_gone",
	},
	bgm_soldiers_corridor = {
		start = "Play_bgm_s10010_soldiers_corridor",
		finish = "Stop_bgm_s10010_soldiers_corridor",
	},
	bgm_patient_01 = {
		start = "Play_bgm_s10010_patient_01",
		finish = "Stop_bgm_s10010_patient_01",
	},
	bgm_patient_02 = {
		start = "Play_bgm_s10010_patient_02",
		finish = "Stop_bgm_s10010_patient_02",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_02",
		},
	},
	bgm_stairs_01 = {
		start = "Play_bgm_s10010_stairs_01",
		finish = "Stop_bgm_s10010_stairs_01",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_02",
		},
	},
	bgm_3rd_floor = {
		start = "Play_bgm_s10010_3f",
		finish = "Stop_bgm_s10010_3f",
	},
	bgm_3rd_floor_02 = {
		start = "Play_bgm_s10010_3f_02",
		finish = "Stop_bgm_s10010_3f_02",
	},
	bgm_stairs_02 = {
		start = "Play_bgm_s10010_stairs_02",
		finish = "Stop_bgm_s10010_stairs_02",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_02",
		},
	},
	bgm_fire = {
		start = "Play_bgm_s10010_fire",
		finish = "Stop_bgm_s10010_fire",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_ed",
		},
	},
	bgm_shoot_him = {
		start = "Play_bgm_s10010_shoot_him",
		finish = "Stop_bgm_s10010_shoot_him",
		switch = {
			"Set_Switch_bgm_s10010_sw_01",
			"Set_Switch_bgm_s10010_sw_ed",
		},
	},
	bgm_volgin = {
		start = "Play_bgm_s10010_volgin",
		finish = "Stop_bgm_s10010_volgin",
	},
	bgm_gameover = {
		start = "Play_bgm_s10010_gameover",
		finish = "Stop_bgm_s10010_gameover",
	},
}




function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end




return this
