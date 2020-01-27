local this = BaseMissionRadio.CreateInstance( "s10035" )
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	"f3010_rtrg1500",	
	"f3010_rtrg1502",	
	"f3010_rtrg1504",	
	"f3010_rtrg1506",	
	"f3010_rtrg1508",	
	"f3010_rtrg1510",	
	"f3010_rtrg1512",	
	"f3010_rtrg1514",	
	"f3000_rtrg1117",	
}




this.optionalRadioList = {
	test = test
}




this.intelRadioList = {
	test = test
}





this.PlayEventKaiju01 = function()
	Fox.Log( "s10035_radio.PlayEventKaiju01()" )
	TppRadio.Play( "f3010_rtrg1508", { delayTime = 3.2 } )
end

this.PlayEventKaiju02 = function()
	Fox.Log( "s10035_radio.PlayEventKaiju02()" )
	TppRadio.Play( "f3010_rtrg1512", { delayTime = 1.5 } )
end

this.PlayEventKaiju03 = function()
	Fox.Log( "s10035_radio.PlayEventKaiju03()" )
	TppRadio.Play( "f3010_rtrg1510" )
end

this.PlayOnDeadEnd = function()
	Fox.Log( "s10035_radio.PlayOnDeadEnd()" )
	TppRadio.Play( "f3010_rtrg1514", { delayTime = 1.5 } )
end




return this
