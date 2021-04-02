local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {

	
	
	{"s0081_rtrg0010",	playOnce = true },		
	{"s0081_rtrg1010", 	playOnce = true },		
	{"f1000_rtrg3170",	playOnce = true },		
	{"s0081_rtrg2010",	playOnce = true },		
	
	{"s0081_rtrg2015",	playOnce = true },		
	{"s0081_rtrg2020",	playOnce = true },		
	{"s0081_rtrg2030",	playOnce = true },		
	{"f1000_rtrg2330",	playOnce = true },		
	{"s0081_rtrg3010",	playOnce = true },		
	{"s0081_rtrg3020",	playOnce = true },		
	{"s0081_rtrg4010",	playOnce = true },		
	{"s0081_rtrg5010",	playOnce = true },		


	{"s0081_rtrg5020",	playOnce = true },		
	{"s0081_rtrg5030",	playOnce = true },		
	{"s0081_rtrg5040",	playOnce = true },		
	{"s0081_rtrg6010",	playOnce = true },		

	{"s0081_rtrg6030",	playOnce = true },		
	{"s0081_rtrg7010",	playOnce = true },		
	
	"s0081_rtrg0020",		
	"s0081_rtrg0030",		
	
	
	"s0081_oprg0010",
	"f1000_oprg0570",	
	
	"s0081_oprg5010",							
	
	"f1000_rtrg2080",							
	"f1000_rtrg2170",							
}





this.optionalRadioList = {
	"Set_s0081_oprg0010",	
	"Set_s0081_oprg2010",	
	"Set_s0081_oprg3010",	
	"Set_s0081_oprg4010",	
	"Set_s0081_oprg5010",	
	"Set_s0081_oprg9000",	
}





this.intelRadioList = {

	hosHouse 		= "f1000_esrg1240",	
	hosHouse_dummy  = "f1000_esrg1240", 
	hosBlood 		= "s0081_esrg2010", 

}

this.ResetIntelRadioForHouse = function()
	
	TppRadio.ChangeIntelRadio{	hosHouse		= "Invalid",}
	TppRadio.ChangeIntelRadio{	hosHouse_dummy	= "Invalid",}
end

this.ResetIntelRadioDefaultAll = function()
	TppRadio.ChangeIntelRadio{	hosHouse		= "Invalid",}
	TppRadio.ChangeIntelRadio{	hosHouse_dummy	= "Invalid",}
	TppRadio.ChangeIntelRadio{	hosBlood		= "Invalid",}
end





this.blackTelephoneDisplaySetting = {

	
	f6000_rtrg0090  = {
		Japanese = {
			{ "mbstaff_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_01.ftex", 0.6 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_02.ftex", 9.9 }, 
		},
		English = {
			{ "mbstaff_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_01.ftex", 0.6 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_02.ftex", 9.8 }, 
		},
	},

	
	f6000_rtrg0100  = {
		Japanese = {
			{ "mbstaff_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_01.ftex", 0.6 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_02.ftex", 12.2 }, 
		},
		English = {
			{ "mbstaff_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_01.ftex", 0.6 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10081_02.ftex", 11.4 }, 
		},
	},
}








this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ] = TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ] = TppRadio.IGNORE_COMMON_RADIO









function this.Messages()
	return
	StrCode32Table {
		Trap = {
			{ msg = "Enter", sender = "trap_nearDiamondWest",	func = this.NearDiamondWest },
			
			{ msg = "Enter", sender = "trap_nearTruckExp",		func = this.NearTruckExplosion },
			nil
		},
	}
end






this.SpyMonologue = function()
	local gameObjectId = GameObject.GetGameObjectId("hos_spy")
	local command = {
		id="CallMonologue",
		label = "speech081_carry030"
	}
	GameObject.SendCommand( gameObjectId, command )
end










this.NearDiamondWest = function()
	if not svars.isKnowSpy and not svars.isGoToSpyRoom then
		
		TppRadio.Play( "s0081_rtrg1010")
	end
end


this.PerfectHunting = function()
	TppRadio.Play( "s0081_rtrg5040")
end

this.SpyEscapeTruck = function()
	TppRadio.Play("s0081_rtrg0020")
end

this.SpyAccident = function()
	TppRadio.Play("s0081_rtrg0030", { delayTime = "long" , priority ="strong"})
end


this.NearTarget = function()
	if(svars.SpyStatus == s10081_sequence.SPY_STATUS.SPY_INJURED) then
		TppRadio.Play( "s0081_rtrg5010")
	end
	
end


this.NearTruckExplosion = function()
	if(svars.SpyStatus == s10081_sequence.SPY_STATUS.SPY_INJURED) then
		TppRadio.Play( "s0081_rtrg3020")
	end
end


this.FultonSuccess = function()
	TppRadio.Play( "s0081_rtrg6030")
end

this.MissionClear = function()
	TppRadio.Play("s0081_rtrg7010")
end


this.EscapeTheTarget = function()
	TppRadio.Play( "s0081_rtrg0020")
	
end


this.ContinueObjective = function()

	if svars.isKnowSpy == false then
		TppRadio.Play{"s0081_oprg0010","f1000_oprg0570"}
	else
		
	end
end


this.TelephoneRadioAlive = function()
		TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0100" ) 
end

this.TelephoneRadioDead = function()
		TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0090" ) 
end





return this
