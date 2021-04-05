local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.commonRadioTable = {
	[ TppDefine.COMMON_RADIO.ABORT_BY_HELI ] = TppRadio.IGNORE_COMMON_RADIO,
}




this.radioList = {
	{ "f2000_rtrg0010", playOnce = true },	
}





this.optionalRadioList = {
	"Set_f2000_oprg0010",
}













this.MissionBriefing = function()
	
	TppRadio.Play( "f2000_rtrg0010" )
end



















return this
