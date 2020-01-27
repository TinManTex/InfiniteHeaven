local this = BaseMissionRadio.CreateInstance( "s10060" )
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	"f3010_rtrg2498",	
	"f3010_rtrg2499",	
	"f3010_rtrg2500",	
	"f3010_rtrg2502",	
	"f3010_rtrg2503",	
	"f3010_rtrg2504",
	"f3010_rtrg2506",
	"f3010_rtrg2508",	
	"f3010_rtrg2510",
	"f3010_rtrg2512",
	"f3010_rtrg2514",
	"f3010_rtrg2516",
	"f3010_rtrg2550",	
	"f3010_rtrg2552",	
	"f3010_rtrg2554",	
	"s0035_rtrg0050",
	"s0035_rtrg0055",
	"f3000_rtrg1117",	
}




this.optionalRadioList = {
	test = test
}




this.intelRadioList = {
	test = test
}




this.PlayDefense = function()
	Fox.Log( "s10060_radio.PlayDefense()" )
	TppRadio.Play( "f3010_rtrg2498", { delayTime = 2.0 } )
end

this.PlayRailgun = function( sequenceName )
	Fox.Log( "s10060_radio.PlayRailgun()" )
	local startRailGunRadioTable = {
		Seq_Game_Railgun = "f3010_rtrg2514",
		Seq_Game_Railgun2 = "f3010_rtrg2550",
	}
	TppRadio.Play( startRailGunRadioTable[sequenceName] )
end

this.PlayNotEffectiveDamageByRailGun = function()
	Fox.Log( "s10060_radio.PlayNotEffectiveDamageByRailGun()" )
	TppRadio.Play( "f3010_rtrg2516" )
end




return this
