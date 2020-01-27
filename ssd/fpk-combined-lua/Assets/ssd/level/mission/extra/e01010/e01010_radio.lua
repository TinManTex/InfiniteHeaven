local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	
	
	openingText = {
		"[dbg]今回の目的は敵部隊長の「排除」だ",
		"[dbg]だがその敵部隊がどこにいるかがわからない",
		"[dbg]まずは敵部隊の作戦計画書を入手するんだ",
		"[dbg]スネーク、savannah拠点に向かい作戦計画書を入手してくれ",
	},
	
	SavannahText = {
		"[dbg]よし、到着したな",
		"[dbg]作戦計画書はおそらく中央テントにあるはずだ",
		"[dbg]マーカーの位置だ。何とか接近してくれ",
	},
	
	GetInfoTape = {
		"[dbg]よし、作戦計画書を回収したな",
		"[dbg]こちらで内容を解析しよう",
		"[dbg]そこは危険だ。ひとまず拠点外まで離脱するんだ",
		"[dbg]最寄のRVをマークした。そこまで退避してくれ",
	},
	
	"s0093_rtrg0020",	
	"s0093_rtrg2010",	
}





this.optionalRadioList = {
	test = test
}





this.intelRadioList = {
	test = test
}





this.MissionStart = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "openingText", { playDebug = true } )
end


this.ArrivedSavannah = function()
	Fox.Log("#### s10211_radio.ArrivedSavannah ####")
	TppRadio.Play( "SavannahText", { playDebug = true } )
end


this.GetSavannahInfoTape = function()
	Fox.Log("#### s10211_radio.GetSavannahInfoTape ####")
	TppRadio.Play( "GetInfoTape", { playDebug = true } )
end




return this
