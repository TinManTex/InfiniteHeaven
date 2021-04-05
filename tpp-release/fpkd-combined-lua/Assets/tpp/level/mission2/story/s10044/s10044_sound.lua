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
        bgm_s10044_target_escape = {
                start = "Play_bgm_s10044_target_escape",
                finish = "Stop_bgm_s10044_target_escape",
                switch = {
                        "Set_Switch_bgm_s10044_target_escape_low",
                        "Set_Switch_bgm_s10044_target_escape_high",
                },
        },
}

this.BGMChase = function()
		Fox.Log("BGM :: bgm_chase")
		TppSound.SetPhaseBGM( "bgm_chase" )
end
this.heliDescentJingleName = "Play_bgm_mission_heli_descent_low"



return this
