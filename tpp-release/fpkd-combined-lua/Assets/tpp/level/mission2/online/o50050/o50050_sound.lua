local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.bgmList = {
	bgm_fob_neutral = {
		start = "Play_bgm_mission_chase_phase",
	},
	bgm_time_limit = {
		start = "Play_bgm_mission_chase_phase",
	},
	
	bgm_metallic = {
		start = "Play_bgm_s10140_metallic",
		finish = "Set_Switch_bgm_s10140_metallic_ed",
		restore = "Set_Switch_bgm_s10140_metallic_op",
		switch = {
			"Set_Switch_bgm_s10140_metallic_op",
			"Set_Switch_bgm_s10140_metallic_sn",
			"Set_Switch_bgm_s10140_metallic_al",
			"Set_Switch_bgm_s10140_metallic_ed",
		},
	},
	bgm_post_metallic = {
		start = "Play_bgm_s10140_post_metallic",
		finish = "Stop_bgm_s10140_post_metallic",
	},
}






function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end



this.SetPhase_startFOB = function()
	Fox.Log("### o50050_sound::SetPhase_startFOB ###")

	TppSound.SetPhaseBGM( "bgm_fob_neutral" )
end


this.SetScene_emergencyTime = function()
	Fox.Log("### o50050_sound::SetScene_emergencyTime ###")
	TppSound.SetPhaseBGM( "bgm_time_limit" )
end





function this.PlayAlertSiren( switch )
	local source = "asiren"
	local tag	 = "Loop"
	local pEvent = "sfx_m_mtbs_siren"
	local sEvent = "Stop_sfx_m_mtbs_siren"
	local daemon = TppSoundDaemon.GetInstance()

	if switch == true then
		daemon:RegisterSourceEvent{
			sourceName = source,
			tag = tag,
			playEvent = pEvent,
			stopEvent = sEvent,
		}
	elseif switch == false then
		daemon:UnregisterSourceEvent{
			sourceName = source,
			tag = tag,
			playEvent = pEvent,
			stopEvent = sEvent,
		}
	end
end










return this
