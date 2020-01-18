local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table



this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_RECOVERED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_ELIMINATED ] = TppRadio.IGNORE_COMMON_RADIO





this.radioList = {
	
	{"s0036_rtrg0010",	playOnce = false},	
	{"s0036_rtrg1010",	playOnce = true},	
	{"f1000_rtrg2180",	playOnce = true},	
	{"f1000_rtrg2550",	playOnce = true},	
	{"s0036_rtrg2030",	playOnce = true},	
	{"s0036_rtrg2035",	playOnce = true},	
	{"s0036_rtrg2037",	playOnce = true},	

	
	{"f1000_rtrg2370",	playOnce = true},	
	{"f1000_rtrg2425",	playOnce = true},	
	{"f1000_rtrg2400",	playOnce = true},	

	nil
}





this.optionalRadioList = {
	OptionalRadioSet_01first	= "Set_s0036_oprg0010",
	OptionalRadioSet_02field	= "Set_s0036_oprg0030",
	OptionalRadioSet_03target	= "Set_s0036_oprg0050",
	OptionalRadioSet_04esc		= "Set_s0036_oprg0100",
	nil
}














this.intelRadioList = {
	sol_vip_0000 = "s0036_esrg0050",	
	esp_10036_0000 = "s0036_esrg0030",	
	esp_10036_0001 = "f1000_esrg1500",	
	esp_10036_0002 = "s0036_esrg0020",	
	nil
}




this.ORadioSet01 = function()
	Fox.Log("set opt 01")
	TppRadio.SetOptionalRadio( "Set_s0036_oprg0010" )
end

this.ORadioSet04 = function()
	Fox.Log("set opt 01")
	TppRadio.SetOptionalRadio( "Set_s0036_oprg0100" )
end





this.MissionStart = function()
	Fox.Log("radio play : mission start")
	TppRadio.Play( "s0036_rtrg0010",{delayTime = "short"} )
	
end


this.ArrivedField = function()
	Fox.Log("#### s10036_radio.ArrivedField ####")
	if svars.isDownVip == false then
		TppRadio.Play( "s0036_rtrg1010",{delayTime = "short"} )
		TppRadio.SetOptionalRadio( "Set_s0036_oprg0030" )
	end
end

this.GetVIP = function()
	Fox.Log("#### s10036radio.GetVIP ####")
	TppRadio.Play( "s0036_rtrg2035",{delayTime = "mid"} )
end

this.GetVIPDontKnow = function()
	Fox.Log("#### s10036radio.GetVIPDontKnow ####")
	TppRadio.Play( "f1000_rtrg2370",{delayTime = "mid"} )
end

this.KillVIP = function()
	Fox.Log("#### s10036radio.KillVIP ####")
	TppRadio.Play( "s0036_rtrg2030",{delayTime = "short"} )
end

this.KillVIPDontKnow = function()
	Fox.Log("#### s10036radio.KillVIPDontKnow ####")
	TppRadio.Play( "f1000_rtrg2400",{delayTime = "short"} )
end


this.FoundTarget = function()
	Fox.Log("#### s10036radio.FoundTarget ####")
	TppRadio.Play( "f1000_rtrg2180",{delayTime = "short"} )
	TppRadio.SetOptionalRadio( "Set_s0036_oprg0050" )
end

this.foundTargetFar = function()

end

this.FulutonVipDontKnow = function()
	Fox.Log("#### s10036radio.FulutonVipDontKnow ####")
	TppRadio.Play( "f1000_rtrg2425",{delayTime = "short"} )
end

this.WatchPhoto = function()
	Fox.Log("#### s10036radio.WatchPhoto ####")
	TppRadio.Play( "s0036_mirg0020",{delayTime = "short"}  )
end

this.Unconscious = function()
	Fox.Log("#### s10036radio.Unconscious ####")
	if svars.isFlag01 == true then
		TppRadio.Play( "f1000_rtrg2550",{delayTime = "long"} )
	else
		Fox.Log("not play because target not found yet")
	end
end

this.ClearRadioWithVIP = function()
	Fox.Log("clear radio with vip")
	TppRadio.Play( "s0036_rtrg2037", {delayTime = "long"})
end



return this
