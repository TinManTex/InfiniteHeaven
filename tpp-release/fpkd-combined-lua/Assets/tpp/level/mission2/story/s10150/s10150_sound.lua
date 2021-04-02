local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


this.heliSeTable = {
	
	trap_SE_Heli02 	= 		{"sfx_e_m_heli_okb_02","OtherHeli0001"},
	trap_SE_Heli03	= 		{"sfx_e_m_heli_okb_03","OtherHeli0002"},
	trap_SE_Heli04	=  		{"sfx_e_m_heli_okb_04","OtherHeli0003"},
	trap_SE_Heli05	=  		{"sfx_e_m_heli_okb_05","OtherHeli0003"},
	trap_SE_Heli06	= 	 	{"sfx_e_m_heli_okb_06","OtherHeli0001"},
	trap_SE_Heli07	=  		{"sfx_e_m_heli_okb_07","OtherHeli0003"},
	trap_SE_Heli08	=  		{"sfx_e_m_heli_okb_08","OtherHeli0001"},
	trap_SE_Heli09	=  		{"sfx_e_m_heli_okb_09","OtherHeli0001"},
	trap_SE_Heli09_L	=  	{"sfx_e_m_heli_okb_09_landing","OtherHeli0001"},
}


this.vehicleSeTable = {
	trap_SE_Vehicle01 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle02 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle03 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle04 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle05 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle06 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle07 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle08 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle09 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle10 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle11 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle12 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle13 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle14 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle15 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle16 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle17 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle18 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle19 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle20 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle21 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle22 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle23 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle24 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle25 	=  "Play_sfx_c_okb_get_over",
	trap_SE_Vehicle26 	=  "Play_sfx_c_okb_lv_skid_01",
	trap_SE_Vehicle27 	=  "Play_sfx_c_okb_lv_skid_02",
	trap_SE_Vehicle28 	=  "Play_sfx_c_okb_lv_skid_03",
	trap_SE_Vehicle29 	=  "Play_sfx_c_okb_lv_skid_04",
	trap_SE_Vehicle30 	=  "Play_sfx_c_okb_lv_skid_05",
	trap_SE_Vehicle31 	=  "Play_sfx_c_okb_lv_skid_06",
	trap_SE_Vehicle32 	=  "Play_sfx_c_okb_lv_skid_07",
	trap_SE_Vehicle33 	=  "Play_sfx_c_okb_lv_skid_08",
	trap_SE_Vehicle34 	=  "Play_sfx_c_okb_lv_skid_09",
	trap_SE_Vehicle35 	=  "Play_sfx_c_okb_lv_skid_10",
	trap_SE_Vehicle36 	=  "Play_sfx_c_okb_lv_skid_11",
	trap_SE_Vehicle37 	=  "Play_sfx_c_okb_lv_skid_12",
	trap_SE_Vehicle38 	=  "Play_sfx_c_okb_lv_skid_13",
}








function this.Messages()

	local messageTable = {
		Trap = {},
		nil
	}
	for trapName,labelSet in pairs ( this.heliSeTable ) do
		local trapTableTalk = {
			msg = "Enter",	sender = trapName,
			func = function ()	this.PlaySoundHeli( labelSet )	end
		}
		table.insert( messageTable.Trap, trapTableTalk )
	end
	
	for trapName,labelName in pairs ( this.vehicleSeTable ) do
		local trapTableTalk = {
			msg = "Enter",	sender = trapName,
			func = function ()	this.PlaySoundVehicle( labelName )	end
		}
		table.insert( messageTable.Trap, trapTableTalk )
	end
	
	
	return
	StrCode32Table( messageTable )
end

this.PlaySoundHeli = function(labelSet)
	local heliGameObjectId = GameObject.GetGameObjectId(labelSet[2])
	GameObject.SendCommand( heliGameObjectId, { id="CallSound", eventName=labelSet[1] } ) 
end
this.PlaySoundVehicle = function(labelName)
	TppSoundDaemon.PostEvent(labelName)
end











function this.MissionOpeningSoundSetting()
	
	
end




function this.GameOverSoundSetting()
	
	
	
end




function this.MissionClearJingleSetting()
	
	
end

this.bgmList = {
	bgm_skull_road = {
		start = "Play_bgm_s10150_road",
		finish = "Stop_bgm_s10150_road",
		},
	bgm_skull_stairs = {
		start = "Play_bgm_s10150_stairs",
		finish = "Stop_bgm_s10150_stairs",
		},
	bgm_skull_walk = {
		start = "Play_bgm_s10150_walk",
		finish = "Stop_bgm_s10150_walk",
		},
	bgm_skull_drive = {
		start = "Play_bgm_skull_drive",
		finish = "Stop_bgm_skull_drive",
		},
}



return this
