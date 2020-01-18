local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.radioList = {
	{ "s0156_rtrg0010", },		
	{ "s0156_rtrg0020" },		
	{ "s0156_rtrg0030" },
	{ "f1000_rtrg7010" },		
	{ "s0156_rtrg0040", playOnce = true },		

}






this.gameOverRadioTable = {}
	this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10156_FILMCASE_DESTROYED] = "s0156_gmov0010"





this.optionalRadioList = {
	"Set_s0156_oprg0010",	
	"Set_s0156_oprg0020",	
	"Set_s0156_oprg0040",	
}





this.intelRadioList = {

		
		rds_s10156_A							= "s0156_esrg0030",	
		rds_s10156_B							= "s0156_esrg0030",
		rds_s10156_C							= "s0156_esrg0030",
		rds_ruins_info							= "s0156_esrg0010",	
		hos_s10156_0000							= "f1000_esrg0790",	
}

this.intelRadioList02 = {

		
		rds_s10156_A							= "s0156_esrg0030",	
		rds_s10156_B							= "s0156_esrg0030",
		rds_s10156_C							= "s0156_esrg0030",
		rds_ruins_info							= "s0156_esrg0020",	
		hos_s10156_0000							= "f1000_esrg0790",	
}





this.CanMissionClearRadio = function()
	Fox.Log("#### s10156_radio.CanMissionClearRadio ####")
	TppRadio.Play( "f1000_rtrg7010", { delayTime = "mid" } )
end


this.ViewPointRadio = function()
	Fox.Log("#### s10156_radio.ViewPointRadio ####")
	TppRadio.Play( "s0156_rtrg0040", { delayTime = "short", isEnqueue = true } )
end




return this
