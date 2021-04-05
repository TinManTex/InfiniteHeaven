local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.bgmList = {
}






this.USE_COMMON_ESCAPE_BGM = true
this.heliDescentJingleName = "Play_bgm_mission_heli_descent_low"








function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end




this.bgmList = {
        bgm_cheer = {
                start = "Play_bgm_mission_chase",
                finish = "Stop_bgm_mission_chase",
        },
        bgm_wipeLeftOut = {
                start = "Play_bgm_mission_chase_phase",
                finish = "Stop_bgm_mission_chase_phase",
                switch = {
                        "Set_Switch_bgm_mission_chase_phase_al",	
                        "Set_Switch_bgm_mission_chase_phase_sn",	
                },
        },
        bgm_heli_fight = {
                start = "Play_bgm_s10171_heli_fight",
                finish = "Stop_bgm_s10171_heli_fight",
        },
}


this.SetPhase_missionBGM = function()
	TppSound.SetPhaseBGM( "front_line" )
end

this.SetScene_cheer = function()
	TppSound.SetSceneBGM("bgm_cheer")
end

this.SetScene_wipeLeftOut = function()
	TppSound.SetSceneBGM("bgm_wipeLeftOut")
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_mission_chase_phase_al")
end

this.SetScene_heli_fight = function()
	TppSound.SetSceneBGM("bgm_heli_fight")
end

this.SetScene_target_AllClear = function()
	TppSound.StopSceneBGM()
	TppSound.ResetPhaseBGM()
end




return this
