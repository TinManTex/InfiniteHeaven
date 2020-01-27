local this = BaseMissionRadio.CreateInstance( "s10050" )
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
}




this.optionalRadioList = {
}




this.intelRadioList = {
}






this.PlayStartSequenceRadio = function()
	Fox.Log( "s10050_radio.PlayEscapeSequenceRadio()" )
	TppRadio.Play( "f3010_rtrg2202" )
end


this.PlayDyingBossRadio = function()
	Fox.Log( "s10050_radio.PlayDyingBossRadio()" )
	TppRadio.Play( "f3010_rtrg2204" )
end




return this
