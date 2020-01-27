local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.bgmList = {
		bgm_infected = {
				start = "Play_bgm_s10240_infected_one",
				finish = "Stop_bgm_s10240_infected_one",
        },
		bgm_infected_1st = {
				start = "Play_bgm_s10240_infected_sw_1st",
				finish = "Stop_bgm_s10240_infected_sw_1st",
				switch = {
						"Set_Switch_bgm_s10240_infected_01",
						"Set_Switch_bgm_s10240_infected_02",
						"Set_Switch_bgm_s10240_infected_03",
				},
        },
		bgm_infected_2nd = {
				start = "Play_bgm_s10240_infected_sw_2nd",
				finish = "Stop_bgm_s10240_infected_sw_2nd",
				switch = {
						"Set_Switch_bgm_s10240_infected_01",
						"Set_Switch_bgm_s10240_infected_02",
						"Set_Switch_bgm_s10240_infected_03",
						"Set_Switch_bgm_s10240_dying",
				},
        },
		bgm_infected_piano = {
				start = "Play_bgm_s10240_infected_piano",
				finish = "Stop_bgm_s10240_infected_piano",
        },
		bgm_heli_start = {
				start = "Play_bgm_s10240_helicopter",
				finish = "Stop_bgm_s10240_helicopter",
        },
        bgm_piano_end = {
    	    start = "Play_bgm_s10240_infected_piano_end",
			finish = "Stop_bgm_s10240_infected_piano_end",
		},
}


this.showCreditJingleName = "Play_bgm_s10240_jingle_ed"


this.StartOneShot = function()
	TppSound.SetSceneBGM("bgm_infected")
end


this.StartBGM00 = function()
	TppSound.SetSceneBGM("bgm_heli_start")
end

this.StartBGM01 = function()
	TppSound.SetSceneBGM("bgm_infected_1st")
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10240_infected_01")
end
this.StartBGM02 = function()
	TppSound.SetSceneBGM("bgm_infected_2nd")
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10240_infected_01")
end

this.StartBGM03 = function()
	TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_s10240_infected_piano" )
end

this.StartJingleEnd = function()
	TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_s10240_infected_piano_end" )
end


this.SwitchBGM02 = function()
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10240_infected_02")
end

this.SwitchBGM03 = function()
	TppSound.SetSceneBGMSwitch("Set_Switch_bgm_s10240_infected_03")
end




this.StopBGM00 = function()
	TppSound.StopSceneBGM("bgm_heli_start")
end

this.StopBGM01 = function()
	TppSound.StopSceneBGM("bgm_infected_1st")
end

this.StopBGM02 = function()
	TppSound.StopSceneBGM("bgm_infected_2nd")
end

this.StopBGM03 = function()
	Fox.Log("StopBGM03()")
	TppSound.StopSceneBGM("bgm_infected_piano")
end




function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end






return this
