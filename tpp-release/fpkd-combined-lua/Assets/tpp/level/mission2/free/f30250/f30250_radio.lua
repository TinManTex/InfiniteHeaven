local this = {}





this.commonRadioTable = {
	[ TppDefine.COMMON_RADIO.ENEMY_RECOVERED ]				= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.ABORT_BY_HELI  ] 				= TppRadio.IGNORE_COMMON_RADIO,
}




this.radioList = {
}





this.optionalRadioList = {
}





this.intelRadioList = {
}





this.SetOptionalRadioFromSituation = function()
end

this.InsertToActiveOptionalRadio = function(targetRadio)
end

this.RemoveToActiveOptionalRadio = function(targetRadio)
end




return this
