local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI ] = "f1000_rtrg3781"



this.radioList = {
	
	
	"s0171_mprg0010",
	"s0171_mprg0020",
	
	"s0171_mirg0010",
	"s0171_mirg0020",
	"s0171_mirg0030",
	"s0171_mirg0040",
	"s0171_mirg0050",
	
	"s0171_rtrg0010",
	"f1000_rtrg0150",
	"s0171_rtrg0030",
	"s0171_rtrg0040",
	"s0171_rtrg0050",
	"s0171_rtrg0060",
	"f1000_rtrg1375",	
	"f1000_rtrg3280",	
	"f1000_rtrg3290",	
	"f1000_rtrg3410",	
}




this.debugRadioLineTable = {
	




	



}





this.optionalRadioList = {
	"Set_s0171_oprg0010", 	
	"Set_s0171_oprg0020",	
	"Set_s0171_oprg0030",	
}





this.intelRadioList = {
	EnemyHeli = "f1000_esrg1165",			
	veh_s10171_tank1 = "f1000_esrg1040",	
	veh_s10171_tank2 = "f1000_esrg1050",	
	veh_s10171_wav = "f1000_esrg1030",		
	veh_s10171_wav_add = "f1000_esrg1190"	
}









this.PlayMissionStartRadio = function()

	Fox.Log("#### s10171_radio.PlayMissionStartRadio ####")
	TppRadio.Play( "s0171_rtrg0010" )
	
end





this.GetMissionStartRadioGroup = function()
	
	Fox.Log( "#### s10171_radio.GetMissionStartRadioGroup: " .. tostring(radioGroup) )
	return { "s0171_rtrg0010", "f1000_rtrg3280" }
	
end





this.GetPlayGetIntelRadioGroup = function()

	Fox.Log("#### s10171_radio.GetPlayGetIntelRadioGroup ####")
	return { "f1000_rtrg0150" }
	
end





this.PlayMissionContinueRadio = function()

	Fox.Log("#### s10171_radio.PlayMissionContinueRadio ####")
	TppRadio.Play( "s0171_rtrg0030" )

end





this.PlayLittleMoreTargetRadio = function()

	Fox.Log("#### s10171_radio.PlayLittleMoreTargetRadio ####")
	TppRadio.Play( "s0171_rtrg0040", { delayTime = "long" } )

end





this.PlayOneTargetLeftRadio = function()

	Fox.Log("#### s10171_radio.PlayOneTargetLeftRadio ####")
	TppRadio.Play( "s0171_rtrg0050", { delayTime = "long" } )

end





this.PlayGetIntelRadio = function()

	Fox.Log("#### s10171_radio.PlayGetIntelRadio ####")
	TppRadio.Play( "f1000_rtrg0150" )
	
end





this.PlayClearRadio = function()

	Fox.Log("#### s10171_radio.PlayClearRadio ####")
	TppRadio.Play( "f1000_rtrg1375" )
	
end





this.NewTargetRadio = function()

	Fox.Log("#### s10171_radio.NewTargetRadio ####")
	TppRadio.Play( "f1000_rtrg3290", { isEnqueue = true, delayTime = "long" } )
	
end





this.GetNewTargetRadioGroup = function()

	Fox.Log("#### s10171_radio.GetNewTargetRadioGroup ####")
	return { "f1000_rtrg3290", { isEnqueue = true, delayTime = "long" } }
	
end





this.PlayTargetFultonFailed = function()
	Fox.Log("#### s10171_radio.PlayTargetFultonFailed ####")
	TppRadio.Play( "f1000_rtrg3410", { delayTime = "long" } )
end





this.OptionalRadioEliminateTarget = function()
	Fox.Log("#### s10171_radio.OptionalRadioEliminateTarget ####")
	TppRadio.SetOptionalRadio( "Set_s0171_oprg0010" )
end





this.OptionalRadioDoInterrogate = function()
	Fox.Log("#### s10171_radio.OptionalRadioDoInterrogate ####")
	TppRadio.SetOptionalRadio( "Set_s0171_oprg0020" )
end





this.OptionalRadioEscape = function()
	Fox.Log("#### s10171_radio.OptionalRadioEscape ####")
	TppRadio.SetOptionalRadio( "Set_s0171_oprg0030" )
end




return this
