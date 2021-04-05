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
	
	bgm_parasites_sniper = {
		start = "Play_bgm_s10130_parasites_01",
		finish = "Set_Switch_bgm_s10130_parasites_01_ed",
		restore = "Set_Switch_bgm_boss_phase_none",
		switch = {
			"Set_Switch_bgm_s10130_parasites_01_sn",
			"Set_Switch_bgm_s10130_parasites_01_al",
			"Set_Switch_bgm_s10130_parasites_01_ed",
		},
	},
	
	bgm_codetalker = {
	},
	
	bgm_codetalker_2nd = {
	},
	
	bgm_parasites_sniper_2 = {
		start = "Play_bgm_s10130_parasites_02",
		finish = "Set_Switch_bgm_s10130_parasites_01_ed",
		restore = "Set_Switch_bgm_boss_phase_none",
		switch = {
			"Set_Switch_bgm_s10130_parasites_01_nt",
			"Set_Switch_bgm_s10130_parasites_01_sn",
			"Set_Switch_bgm_s10130_parasites_01_al",
			"Set_Switch_bgm_s10130_parasites_01_ed",
		},
	},
	bgm_codetalker_walk = {
		start = "Play_bgm_s10130_codetalker",
		finish = "Stop_bgm_s10130_codetalker",
	},
}

this.BGMParasitesSneek = function()
		Fox.Log("BGM :: parasite SNEEK")
		TppSound.SetSceneBGM("bgm_parasites_sniper")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10130_parasites_01_sn")
end

this.BGMParasitesAlert = function()
		Fox.Log("BGM :: parasite ALERT")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10130_parasites_01_al")
end

this.BGMParasitesEd = function()
		Fox.Log("BGM :: parasite ED")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10130_parasites_01_ed")
end

this.BGMParasitesSneek2 = function()
		Fox.Log("BGM :: parasite SNEEK2")
		TppSound.SetSceneBGM("bgm_parasites_sniper_2")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10130_parasites_01_sn")
end

this.BGMParasitesAlert2 = function()
		Fox.Log("BGM :: parasite ALERT2")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10130_parasites_01_al")
end

this.BGMParasitesEd2 = function()
		Fox.Log("BGM :: parasite ED2")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10130_parasites_01_ed")
end




return this
