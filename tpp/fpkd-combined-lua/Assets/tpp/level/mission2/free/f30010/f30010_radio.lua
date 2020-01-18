local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.commonRadioTable = {
	[ TppDefine.COMMON_RADIO.ABORT_BY_HELI ] = TppRadio.IGNORE_COMMON_RADIO,
}




this.radioList = {
	{ "f2000_rtrg0010", playOnce = true },	
	"f2000_rtrg0025",		
	"f2000_rtrg0035",		
	"f2000_rtrg0040",		
	"f2000_rtrg0050",		
	"f2000_rtrg0060",		
	"f2000_rtrg0070",		
	"f2000_rtrg0080",		

	"f2000_rtrg0090",		
	"f2000_rtrg1110",		
	"f2000_rtrg1120",		
	"f2000_rtrg1130",		

	"f1000_rtrg0690",		
	"f1000_rtrg0700",		

	"f2000_rtrg1330",		
	"f2000_rtrg8420",		
	"f2000_rtrg3005",		
	"f2000_rtrg3010",		
	"f2000_rtrg8430",		

	
	"f1000_mprg0050",		
}

this.debugRadioLineTable = {

	
	RescueHuey_announce = {
		"[dbg]ボス、東側で兵器開発をしている科学者がHECを通じて接触してきた",
		"[dbg]名前はエメリッヒ",
		"[dbg]彼は西側への亡命を希望している",
		"[dbg]まずは依頼者であり、ターゲットでもあるエメリッヒと接触したい",
		"[dbg]この科学者は常時、北のソビエト軍ベースキャンプで軟禁状態にある",
		"[dbg]だが今は変電施設に来ている",
		"[dbg]新兵器のデモンストレーションをするためにな",
		"[dbg]今がターゲット接触のチャンスといえるだろう",
		"[dbg]変電施設へ向かえ。エメリッヒに接触するんだ",
	},
	
	RescueHuey_updateArea = {
		"[dbg]変電施設に到達したな",
		"[dbg]エメリッヒ博士は施設北端の実験場にいるはずだ",
		"[dbg]実験場の入り口を目指してくれ",
	},

}





this.optionalRadioList = {
	"Set_f2000_oprg0010"
}














this.MissionBriefing = function()

	
	TppRadio.Play( this.GetMissionBriefingRadio() )

end

this.GetMissionBriefingRadio = function()

	return "f2000_rtrg0010"

end


this.NearDiamondWest = function()
	
	TppRadio.Play( "s0081_rtrg1010")
end




this.OnInterpreterRecognized = function()

end











this.BossQuiet_announce = function()
	Fox.Log("#### f30010_radio.BossQuiet_announce ####")
	TppRadio.Play( "f2000_rtrg1330" )
end








return this
