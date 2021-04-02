local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_RECOVERED ] = TppRadio.IGNORE_COMMON_RADIO



this.radioList = {
	
	
	"f1000_mprg0170",	
	"s0085_mprg0020",	
	
	
	"s0085_rtrg0010",	
	"s0085_rtrg0020",	
	"s0085_rtrg0030",	
	"s0085_rtrg0040",	
	"s0085_rtrg0050",	
	"s0085_rtrg0060",	
	"s0085_rtrg0070",	
	"s0085_rtrg0080",	
	"s0085_rtrg0090",	
	"s0085_rtrg0100",	
	"s0085_rtrg0110",	
	"f1000_rtrg2171",	
	"f1000_rtrg4240",	
	"f1000_rtrg1560",	
	
	
	"s0085_mirg0010",	
	"s0085_mirg0020",	
	"s0085_mirg0030",	
}





this.optionalRadioList = {
	
	"Set_s0085_oprg0010",	
	"Set_s0085_oprg0020",	
	"Set_s0085_oprg0030",	
	"Set_s0085_oprg0040",	
	"Set_s0085_oprg0050",	
	"Set_s0085_oprg0060",	
	"Set_s0085_oprg0070",	
}





this.intelRadioList = {
	sol_interrogator_0000 = "s0085_esrg0010",	
	sol_interrogator_0001 = "s0085_esrg0010",	
	hostage_tent = "s0085_esrg0020",	
	hos_target_0000 = "f1000_esrg0590",	
	hos_target_0001 = "s0085_esrg0030",	
}


this.intelRadioListFleeHosMarkedTarget = {
	hos_target_0000 = "f1000_esrg0545",	
}
this.intelRadioListConvoyHosMarkedTarget = {
	hos_target_0001 = "s0085_esrg0050",	
}


this.intelRadioListFlee = {
	hos_target_0000 = "s0085_esrg0040",	
}


this.intelRadioListConvoyStart = {
	hostage_tent = "Invalid",	
	sol_interrogator_0000 = "Invalid",	
	sol_interrogator_0001 = "Invalid",	
	hos_target_0001 = "s0085_esrg0060",	
}


this.intelRadioListTentOff = {
	hostage_tent = "Invalid",	
}


this.intelRadioListConvoyTroopsOff = {
	sol_interrogator_0000 = "Invalid",	
	sol_interrogator_0001 = "Invalid",	
}


this.intelRadioListConvoyFinished = {
	hos_target_0001 = "s0085_esrg0050",	
}









this.PlayMissionStartRadio = function()

	if TppSequence.GetContinueCount() > 0 then
		this.PlayMissionContinueRadio()	
	else
		Fox.Log("#### s10085_radio.PlayMissionStartRadio ####")
		TppRadio.Play( "s0085_rtrg0010" )
	end

end





this.GetMissionStartRadioGroup = function()
	local radioGroup = "s0085_rtrg0010"
	local radioGroupTable = {}
	table.insert( radioGroupTable, radioGroup )
	Fox.Log( "#### s10085_radio.GetMissionStartRadioGroup: " .. tostring(radioGroup) )
	return radioGroupTable
end





this.PlayMissionContinueRadio = function()

	Fox.Log("#### s10085_radio.PlayMissionContinueRadio ####")
	TppRadio.Play( "s0085_rtrg0020" )

end




 
this.PlayHostageFlee = function()

	Fox.Log("#### s10085_radio.PlayHostageFlee ####")
	TppRadio.Play( "s0085_rtrg0070" )

end





this.PlayConvoyTroopsStarted = function()

	Fox.Log("#### s10085_radio.PlayConvoyTroopsStarted ####")
	TppRadio.Play( "s0085_rtrg0050" )

end





this.PlayFleeHostageAlmostKilled = function()
	if svars.isFleeHostageRescued == true or svars.isFleeHostageDead == true then
		return
	end
	Fox.Log("#### s10085_radio.PlayFleeHostageAlmostKilled ####")
	TppRadio.Play( "Radio_FleeHostageAlmostKilled", { playDebug = true } )

end





this.PlayHostageNotInTent = function()
	Fox.Log("#### s10085_radio.PlayHostageNotInTent ####")
	TppRadio.Play( "s0085_rtrg0080" )
end





this.PlayAfterRescueOneHostage = function()

	Fox.Log("#### s10085_radio.PlayAfterRescueOneHostage　####")
	TppRadio.Play( {"f1000_rtrg1560", "s0085_rtrg0060"}, { delayTime = "long" } )

end





this.PlayFailToRescueFleeHostage = function()

	if svars.isConvoyHostageDead == false and svars.isConvoyHostageRescued == false then
		Fox.Log("#### s10085_radio.PlayFailToRescueFleeHostage　####")
		TppRadio.Play( "Radio_FailToRescueFleeHostage", { playDebug = true } )
	end

end





this.PlayBreakAwayRescueAll = function()

	Fox.Log("#### s10085_radio.PlayBreakAwayRescueAll　####")
	TppRadio.Play( "s0085_rtrg0090" )

end





this.PlayMarkFleeHostage = function()

	Fox.Log("#### s10085_radio.PlayMarkFleeHostage ####")
	TppRadio.Play( "s0085_rtrg0030", { delayTime = "long" } )

end





this.PlayMarkConvoyHostage = function()

	Fox.Log("#### s10085_radio.PlayMarkConvoyHostage ####")
	TppRadio.Play( "s0085_rtrg0040", { delayTime = "long" } )

end





this.PlayUpdateFleeHostageMarketTarget = function( messageName )

	Fox.Log("#### s10085_radio.PlayUpdateFleeHostageMarketTarget ####")
	TppRadio.Play( "f1000_rtrg2171", { delayTime = "long" } )
	
end





this.PlayUpdateWomanHostageMarketTarget = function( messageName )

	Fox.Log("#### s10085_radio.PlayUpdateWomanHostageMarketTarget ####")
	TppRadio.Play( "f1000_rtrg4240", { delayTime = "long" } )
	
end





this.PlayHostageDamageFromPlayer = function( messageName )

	Fox.Log("#### s10085_radio.PlayHostageDamageFromPlayer ####")
	TppRadio.Play( "s0085_rtrg0100" )
	
end





this.OptionalRadioRescueTwo = function()
	Fox.Log("#### s10085_radio.OptionalRadioRescueTwo ####")
	TppRadio.SetOptionalRadio( "Set_s0085_oprg0020" )
end





this.OptionalRadioRescueOneHostage = function()
	Fox.Log("#### s10085_radio.OptionalRadioRescueOneHostage ####")
	
	
	if svars.isConvoyHostageRescued and svars.isFleeHostageRescued == false then
		TppRadio.SetOptionalRadio( "Set_s0085_oprg0030" )
	
	elseif svars.isConvoyHostageRescued == false and svars.isFleeHostageRescued then
		
		if svars.isConvoyHostageAway == false or svars.isHostageNotInTentKnown == false then
			TppRadio.SetOptionalRadio( "Set_s0085_oprg0040" )
		elseif svars.isHostageNotInTentKnown then
			if svars.isConvoyPositionKnown == false and svars.isConvoyHostageAway then
				if svars.isConvoyHostageMarked == false then
					TppRadio.SetOptionalRadio( "Set_s0085_oprg0010" )	
				else
					TppRadio.SetOptionalRadio( "Set_s0085_oprg0050" )	
				end
			else
				TppRadio.SetOptionalRadio( "Set_s0085_oprg0060" )
			end
		end
	end
end





this.OptionalRadioClear = function()
	Fox.Log("#### s10085_radio.OptionalRadioClear ####")
	TppRadio.SetOptionalRadio( "Set_s0085_oprg0070" )
end





this.BlackTelephoneRadio = function()
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0110" ) 
end




this.blackTelephoneDisplaySetting = {
	f6000_rtrg0110  = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10085/mb_photo_10085_010_1.ftex", 0.6,"cast_american_technician" }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10085/mb_photo_10085_020_1.ftex", 0.9,"cast_technicians_assistant" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_03.ftex", 8.3 }, 
			{ "hide", "main_1", 19.9 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_04.ftex", 34.1 }, 
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_05.ftex", 41.9 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_06.ftex", 49.5 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10085/mb_photo_10085_010_1.ftex", 0.6,"cast_american_technician" }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10085/mb_photo_10085_020_1.ftex", 0.9,"cast_technicians_assistant" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_03.ftex", 7.4 }, 
			{ "hide", "main_1", 17.1 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_04.ftex", 28.4 }, 
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_05.ftex", 34.9 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10085_06.ftex", 42.0 }, 
		},
	},
}




return this
