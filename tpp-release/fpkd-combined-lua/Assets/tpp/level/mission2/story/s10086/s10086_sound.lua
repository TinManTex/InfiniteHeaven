local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.USE_COMMON_ESCAPE_BGM = true
this.heliDescentJingleName = "Play_bgm_mission_heli_descent_low"

this.bgmList = {
	bgm_kill_hostage = {
		start = "bgm_s10086_kill_hostage",
	},
}




function this.MissionOpeningSoundSetting()

	Fox.Log( "s10086_sound.MissionOpeningSoundSetting()" )

end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end




function this.OnHostageKilled()

	Fox.Log( "s10086_sound.OnHostageKilled()" )

	TppSound.SetPhaseBGM( "bgm_s10086_kill_hostage" )

end




return this
