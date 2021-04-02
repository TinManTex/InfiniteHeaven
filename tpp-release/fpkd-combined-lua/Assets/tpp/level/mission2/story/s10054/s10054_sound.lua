local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table






this.USE_COMMON_ESCAPE_BGM = true
this.heliDescentJingleName = "Play_bgm_mission_heli_descent_low"







function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end




this.bgmList = {
        bgm_finale = {
                start = "Play_bgm_mission_chase",
                finish = "Stop_bgm_mission_chase",
        },
        bgm_extra_troops = {
                start = "Play_bgm_mission_chase_phase",
                finish = "Stop_bgm_mission_chase_phase",
                switch = {
                        "Set_Switch_bgm_mission_chase_phase_al",	
                        "Set_Switch_bgm_mission_chase_phase_sn",	
                },
        },
}


this.SetPhase_frontLine = function()
	TppSound.SetPhaseBGM( "front_line" )
end

this.SetScene_emergencyTime = function()
		TppSound.SetSceneBGM("bgm_finale")
end

this.SetScene_bonusTarget = function()
		TppSound.SetSceneBGM("bgm_extra_troops")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_mission_chase_phase_al")
end

this.SetScene_bonusTarget_AllClear = function()
		TppSound.SetSceneBGM("bgm_extra_troops")
		TppSound.SetSceneBGMSwitch("Set_Switch_bgm_mission_chase_phase_sn")
end



return this
