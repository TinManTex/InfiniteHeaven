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
        bgm_chase = {
                start = "Play_bgm_mission_chase",
                finish = "Stop_bgm_mission_chase",

        },
}




return this
