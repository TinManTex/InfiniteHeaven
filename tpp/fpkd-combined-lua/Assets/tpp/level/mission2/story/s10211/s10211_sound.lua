local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table






this.bgmList = {
}




this.heliDescentJingleName = "Play_bgm_mission_heli_descent_low"


this.USE_COMMON_ESCAPE_BGM = true




function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end






function this.CallEscapeMusic()
	Fox.Log("!!!! s10211_sound.CallEscapeMusic !!!!")

	
	TppMusicManager.StartSceneMode()
	
	TppMusicManager.PlaySceneMusic( "Play_bgm_s10211_escape" )

end


function this.EndEscapeMusic()
	Fox.Log("!!!! s10211_sound.EndEscapeMusic !!!!")

	
	TppMusicManager.PlaySceneMusic( "Stop_bgm_s10211_escape" )
	
	TppMusicManager.EndSceneMode()

end




return this
