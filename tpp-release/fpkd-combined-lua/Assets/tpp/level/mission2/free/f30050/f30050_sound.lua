-- DOBUILD: 0 --DEBUGNOW
-- ORIGINALQAR: chunk3
-- PACKPATH: \Assets\tpp\pack\mission2\free\f30050\f30050.fpkd
--f30050_sound.lua
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
        bgm_eli_challenge = {
                start = "Play_bgm_f30050_eli",
                finish = "Stop_bgm_f30050_eli",
        },
        bgm_shooting_range = {
                start = "Play_bgm_mtbs_training",
                finish = "Stop_bgm_mtbs_training",
        },
        bgm_nuclear_ending = {
        		start = "Play_p51_020030_bgm",
        		finish = "Stop_p51_020030_bgm",
        },
        bgm_nuclear_userrole = {
        		start = "Play_p51_020050",
        		finish = "Stop_p51_020050",
        },
        bgm_heliStart = {
			start = "Play_bgm_mtbs_free_start",
			finish = "Stop_bgm_mtbs_free_start",
		},
		--tex> o50050 fob
  bgm_fob_neutral = {
    start = "Play_bgm_mission_chase_phase",
  },
  bgm_time_limit = {
    start = "Play_bgm_mission_chase_phase",
  },
  --<
}




function this.SetScene_ShootingRange()
	TppSound.SetSceneBGM("bgm_shooting_range")
end




return this
