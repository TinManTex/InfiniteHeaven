local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


this.commonRadioTable = {
	[ TppDefine.COMMON_RADIO.RESULT_RANK_S ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_A ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_B ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_C ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_D ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_E ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED ] = TppRadio.IGNORE_COMMON_RADIO,
}

this.gameOverRadioTable = {}




this.radioList = {
	"s0010_rtrg0010",
}





this.PlayBlackTelephoneRadio = function()
	Fox.Log("s10010_radio.PlayBlackTelephoneRadio()")
	TppRadio.Play( "s0010_rtrg0010" )
end




return this
