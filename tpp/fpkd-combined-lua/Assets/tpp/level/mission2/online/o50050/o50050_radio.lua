local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.radioList = {
	"f5000_rtrg0010",	
	"f5000_rtrg0020",	
	"f5000_rtrg0030",	
	"f5000_rtrg0040",	
	"f5000_rtrg0050",	
	"f5000_rtrg0060",	
	"f5000_rtrg0070",	
	"f5000_rtrg0080",	
	"f5000_rtrg0090",	
	"f5000_rtrg0100",	
	"f5000_rtrg0110",	
	"f5000_rtrg0120",	
	"f5000_rtrg0130",	
	"f5000_rtrg0140",	
	"f5000_rtrg0150",	
	"f5000_rtrg0160",	
	"f5000_rtrg0170",	
	"f5000_rtrg0180",	
	"f1000_rtrg1150",	
	"f8000_gmov0120",
	"f1000_rtrg0645",
	"f1000_rtrg0655",
}


this.MissionStartRadioList = {
	"f5000_rtrg0010",	
	"f5000_rtrg0020",	
}





this.optionalRadioList = {
	"Set_f5000_rtrg0010",		
	"Set_f5000_rtrg0020",		
	"Set_f5000_rtrg0030",		
	"Set_f5000_rtrg0040",		
}





this.intelRadioList = {
	nil
}






this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.PHASE_DOWN_OUTSIDE_HOTZONE ] = TppRadio.IGNORE_COMMON_RADIO		 
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT ] 		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE		 ]		= TppRadio.IGNORE_COMMON_RADIO		  

this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_S		 ]		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_A		 ]		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_B		 ]		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_C		 ]		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_D		 ]		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_E		 ]		= TppRadio.IGNORE_COMMON_RADIO		  
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED		 ]		= TppRadio.IGNORE_COMMON_RADIO		  


this.commonRadioTable[ TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN ]			= TppRadio.IGNORE_COMMON_RADIO


do
	local IGNORE_COMMON_RADIO_LIST = {
		TppDefine.COMMON_RADIO.PHASE_DOWN_OUTSIDE_HOTZONE,	
		TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT,		
		TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE,			
		TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_CHANGE_SNEAK,	
		TppDefine.COMMON_RADIO.RETURN_HOTZONE,			
		TppDefine.COMMON_RADIO.ABORT_BY_HELI,			
		TppDefine.COMMON_RADIO.RECOMMEND_CURE,			
		TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN,		
		TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME,		
		TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE,	
		TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME,		
		TppDefine.COMMON_RADIO.RECOVERED_RUSSIAN_INTERPRETER,	
		TppDefine.COMMON_RADIO.TARGET_MARKED,			
		TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED,		
		TppDefine.COMMON_RADIO.TARGET_RECOVERED,		
		TppDefine.COMMON_RADIO.TARGET_ELIMINATED,		
		TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE,		
		TppDefine.COMMON_RADIO.CANNOT_GET_INTEL_ON_ALERT,	
		TppDefine.COMMON_RADIO.CALL_BUDDY_QUIET_WHILE_FORCE_HOSPITALIZE,	
		TppDefine.COMMON_RADIO.DISCOVERED_BY_SNIPER,		
		TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI,	
		TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI,		
		TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN,	
		TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS,	
		TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END,		
		TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END_ENEMY_ATTACK, 	
		TppDefine.COMMON_RADIO.HELI_DAMAGE_FROM_PLAYER,		
	}
	for index, commonRadioEnum in ipairs( IGNORE_COMMON_RADIO_LIST ) do
		this.commonRadioTable[ commonRadioEnum ] = TppRadio.IGNORE_COMMON_RADIO
	end
end










this.GetHostMissionStart = function( isFound )
	local radioGroups = {}
	if isFound == true then
		table.insert( radioGroups, "f5000_rtrg0020" )
	else
		table.insert( radioGroups, "f5000_rtrg0010" )
	end
	return radioGroups
end






this.ClientMissionStart = function( isFound )
	if isFound == true then
		TppRadio.Play( "f5000_rtrg0040", { delayTime = "mid" } )
	else
		TppRadio.Play( "f5000_rtrg0030", { delayTime = "mid" } )
	end
end




this.HostMissionWin = function()
	Fox.Log("#### Call Raio o50050_radio.HostMissionWin ####")
	TppRadio.Play( "f5000_rtrg0050", { delayTime = "mid" } )
end


this.ClientMissionLose = function()
	Fox.Log("#### Call Raio o50050_radio.ClientMissionLose ####")
	TppRadio.Play( {"f5000_rtrg0160","f5000_rtrg0080"}, { delayTime = "mid" })
end


this.HostMissionLose = function()
	Fox.Log("#### Call Raio o50050_radio.HostMissionLose ####")
	TppRadio.Play( {"f5000_rtrg0070","f5000_rtrg0080"}, { delayTime = "mid" })
end



this.ClientMissionWin = function()
	Fox.Log("#### Call Raio o50050_radio.ClientMissionWin ####")
	TppRadio.Play( {"f5000_rtrg0120","f5000_rtrg0130"}, { delayTime = "mid" })
end


this.HostMissionAbort = function()
	Fox.Log("#### Call Raio o50050_radio.HostMissionAbort ####")
	TppRadio.Play( "f5000_rtrg0060", "f5000_rtrg0080", { delayTime = "mid" } )
end

this.ClientMissionAbort = function()
	Fox.Log("#### Call Raio o50050_radio.ClientMissionAbort ####")
	TppRadio.Play( "f5000_rtrg0140", "f5000_rtrg0150", { delayTime = "mid" } )
end


this.HostResultMissionLose_DD_Dead = function()
	Fox.Log("#### Call Raio o50050_radio.HostResultMissionLose_DD_Dead ####")
	TppRadio.Play( {"f5000_rtrg0090"}, { delayTime = "short" })
end


this.HostResultMissionLose_DD_Fulton = function()
	Fox.Log("#### Call Raio o50050_radio.HostResultMissionLose_DD_Fulton ####")
	TppRadio.Play( {"f5000_rtrg0100"}, { delayTime = "short" })
end


this.HostResultOpenWarmhole = function()
	Fox.Log("#### Call Raio o50050_radio.HostResultOpenWarmhole ####")
	TppRadio.Play( {"f5000_rtrg0110"}, { delayTime = "short" })
end


this.ClientResultGottenStaff = function()
	Fox.Log("#### Call Raio o50050_radio.ClientResultGottenStaff ####")
	TppRadio.Play( {"f5000_rtrg0170"}, { delayTime = "short" })
end


this.ClientResultOpenWarmhole = function()
	Fox.Log("#### Call Raio o50050_radio.ClientResultOpenWarmhole ####")
	TppRadio.Play( {"f5000_rtrg0180"}, { delayTime = "short" })
end


this.DoCrimeAndGameOver = function()
	Fox.Log("#### Call Raio o50050_radio.DoCrimeAndGameOver ####")
	TppRadio.Play( {"f8000_gmov0120"}, { delayTime = "mid" })
end


this.ClientWin_SomeoneRemove = function()
	Fox.Log("#### Call Raio o50050_radio.ClientWin_SomeoneRemove ####")
	TppRadio.Play( {"f5000_rtrg0100"}, { delayTime = "short" })
end


this.ClientWin_SomeoneDead = function()
	Fox.Log("#### Call Raio o50050_radio.ClientWin_SomeoneDead ####")
	TppRadio.Play( {"f5000_rtrg0090"}, { delayTime = "short" })
end


this.NearByNuclear = function()
	
	if vars.mbmIsEnableNuclearDevelop == 1 then
		if TppRadio.IsPlayed({"f1000_rtrg0645"}) == false then
			Fox.Log("#### Call Raio o50050_radio.NearByNuclear_DisableDevelop ####")
			TppRadio.Play( {"f1000_rtrg0645"}, { delayTime = "mid" })
		end
	else
		if TppRadio.IsPlayed({"f1000_rtrg0655"}) == false then
			Fox.Log("#### Call Raio o50050_radio.NearByNuclear_EnableDevelop ####")
			TppRadio.Play( {"f1000_rtrg0655"}, { delayTime = "mid" })
		end
	end
end




return this
