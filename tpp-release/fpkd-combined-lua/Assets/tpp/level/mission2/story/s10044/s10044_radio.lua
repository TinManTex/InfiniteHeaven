local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ] = TppRadio.IGNORE_COMMON_RADIO




this.radioList = {
	"s0044_rtrg0010",
	"s0044_rtrg0020",
	"s0044_rtrg0030",
	"s0044_rtrg0050",
	"s0044_rtrg0060",
	"s0044_rtrg0080",
	"s0044_rtrg0090",
	"s0044_rtrg0100",
	"s0044_rtrg0105",		
	"s0044_rtrg0120",
	"s0044_rtrg0130",
	"s0044_rtrg0140",
	"s0044_rtrg0150",
	"s0044_rtrg0160",
	"s0044_rtrg0165",		
	"s0044_rtrg0190",
	"s0044_rtrg0200",
	"s0044_rtrg0201",		
	"s0044_rtrg0210",
	"s0044_rtrg0220",
	"f1000_rtrg1640",
	{ "f1000_rtrg1680", playOnce = true },	
	"f1000_rtrg7010",
	"f1000_rtrg2171",
	"f1000_rtrg2175",
	"f1000_rtrg1370",

	"s0044_mirg0010", 

	{"s0044_mprg0010",playOnce = true}, 
	{"s0044_mprg0030",playOnce = true}, 
	{"s0044_mprg0040",playOnce = true}, 
	{"s0044_mprg0050",playOnce = true}, 
	{"s0044_mprg0060",playOnce = true}, 

	
	"f1000_rtrg3545",
	"f1000_esrg1055",
	"f1000_mprg0235",
	"f1000_mirg0020",

	
	"s0044_esrg0010",
	"s0044_esrg0020",
	"s0044_rtrg0300",
}





this.optionalRadioList = {
	"Set_s0044_oprg0000",	
	"Set_s0044_oprg0010",	
	"Set_s0044_oprg0020",	
	"Set_s0044_oprg0030",	

	"Set_s0044_oprg0100",	
}







this.intelRadioList = {
	veh_sensha				=	"s0044_esrg0010",		
	veh_sensha0000			=	"s0044_esrg0010",		
	sol_enemyNorth_lvVIP	=	"s0044_esrg0100",		

	rds_intel_house_info_default		=	"s0044_esrg0030",		
	rds_cliffTown_info		=	"s0044_esrg0050",		







}


this.intelRadioListAfterInterrogation = {
	veh_sensha				=	"s0044_esrg0010",		
	veh_sensha0000			=	"s0044_esrg0010",		
	sol_enemyNorth_lvVIP	=	"s0044_esrg0100",		

	rds_intel_house_info_default		=	"Invalid",		
	rds_intel_house_info		=	"s0044_esrg0040",		
	rds_cliffTown_info		=	"s0044_esrg0050",		
}


this.intelRadioListAfterIntelDemo = {
	veh_sensha				=	"s0044_esrg0010",		
	veh_sensha0000			=	"s0044_esrg0010",		
	sol_enemyNorth_lvVIP	=	"s0044_esrg0100",		

	rds_intel_house_info_default		=	"Invalid",		
	rds_intel_house_info		=	"Invalid",		

	rds_cliffTown_info		=	"s0044_esrg0050",		
}












this.PlayMissionStart = function()
	Fox.Log(":: s10044 :: radio.lua ::")

	TppMission.UpdateObjective{
		radio = {
			radioGroups = {"s0044_rtrg0010", "s0044_rtrg0020"},
			radioOptions = { priority = "strong",nil},
		},
		objectives = { "default_area_clifftown",nil },
	}
end


this.PlayGetInfo = function()
	Fox.Log("Got a information")
	TppRadio.Play("s0044_rtrg0140",{delayTime = 10})
	TppRadio.Play("s0044_rtrg0210",{isEnqueue = true, delayTime = "short"})
end


this.PlayGetInfo_ButItisWaste = function()
	Fox.Log("Got a information but it is Waste")
	TppRadio.Play("s0044_rtrg0120",{delayTime = "short"})
end


this.PlayGetInfo_ButIknow = function()
	Fox.Log("Got a information but I know the tank is moving")
	TppRadio.Play("s0044_rtrg0130",{delayTime = "short"})
end

this.PlayWhyareyougothere = function()
	Fox.Log("Why are you go there ?")
	TppRadio.Play("s0044_rtrg0030",{delayTime = "short"})
end

this.PlayTargetIdentifiedWithoutInfo = function()
	TppRadio.Play("s0044_rtrg0160",{delayTime = "short"})
end

this.PlayEliminatedTarget = function()
	Fox.Log("Good Job (Eliminated Target)!")
	TppRadio.Play("f1000_rtrg1640",{isEnqueue = true, delayTime = "mid"})
end

this.PlayFultonTank = function()
	Fox.Log("##**s10044_radio.PlayFultonTank")
	TppRadio.Play("s0044_rtrg0105",{delayTime = "mid"})
end

this.PlayEliminateVIP = function()
	TppRadio.Play("s0044_rtrg0080",{isEnqueue = true, delayTime = "mid"})
end

this.PlayTargetIdentified = function()
	TppRadio.Play("s0044_rtrg0150",{delayTime = "short"})
end
this.PlayTargetTank01Identified = function()
	TppRadio.Play("f1000_rtrg2171",{delayTime = "short"})
end
this.PlayTargetTank02Identified = function()
	TppRadio.Play("f1000_rtrg2175",{delayTime = "short"})
end

this.PlayEliminateTheTanks = function()
	TppRadio.Play("s0044_rtrg0090",{isEnqueue = true, delayTime = "mid"})
end

this.PlayEliminateTheTank = function()
	TppRadio.Play("s0044_rtrg0100",{isEnqueue = true, delayTime = "mid"})
end

this.PlayHelpRadioFromIntelTeam = function()
	TppRadio.Play("s0044_rtrg0060",{isEnqueue = true, delayTime = "short"})
end

this.PlayMissionClear = function()
	TppRadio.Play("f1000_rtrg1370",{isEnqueue = true, delayTime = 4})
end

this.PlayTargetFultonFailed = function()
	Fox.Log("#### s10044_radio.PlayTargetFultonFailed ####")
	TppRadio.Play( "f1000_rtrg3410", {isEnqueue = true, delayTime = "short"})
end


this.PlayTargetsArrivedFort = function()
	Fox.Log("#### s10044_radio.PlayTargetsArrivedFort ####")
	TppRadio.Play( "s0044_rtrg0200", {isEnqueue = true, delayTime = "short"})
end


this.PlayOnlyVipArrivedFort = function()
	Fox.Log("#### s10044_radio.PlayOnlyVipArrivedFort ####")
	TppRadio.Play( "s0044_rtrg0165", {isEnqueue = true, delayTime = "short"})
end


this.ORadioSet01 = function()
	Fox.Log("set opt 01")
	TppRadio.SetOptionalRadio( "Set_s0044_oprg1000" )
end
this.ORadioSet20 = function()
	Fox.Log("set opt 20")
	TppRadio.SetOptionalRadio( "Set_s0044_oprg2000" )
end
this.ORadioSet25 = function()
	Fox.Log("set opt 25")
	TppRadio.SetOptionalRadio( "Set_s0044_oprg2500" )
end
this.ORadioSet30 = function()
	Fox.Log("set opt 30")
	TppRadio.SetOptionalRadio( "Set_s0044_oprg3000" )
end
this.ORadioSet40 = function()
	Fox.Log("set opt 40")
	TppRadio.SetOptionalRadio( "Set_s0044_oprg4000" )
end
this.ORadioSet50 = function()
	Fox.Log("set opt 50")
	TppRadio.SetOptionalRadio( "Set_s0044_oprg5000" )
end

this.PlayDeadHostage = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg2090",{delayTime = "mid"})
	this.ORadioSet25()
end

this.PlayInFort = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg1060",{delayTime = "short"})
end
this.PlayInBridge = function()
	Fox.Log(":: s10044_radio :: check flag. chenge radio by information of hostage ::")
	if svars.isGetInfoHostage then
		Fox.Log("have a information")
		TppRadio.Play("s0044_rtrg1020",{delayTime = "short"})
	else
		if TppEnemy.GetLifeStatus("hos_s10044_0000") == TppEnemy.LIFE_STATUS.DEAD then
			Fox.Log("dead hostage")
			TppRadio.Play("s0044_rtrg1044",{delayTime = "short"})
		else
			Fox.Log("no infomation")
			TppRadio.Play("s0044_rtrg1030",{delayTime = "short"})
		end
	end
end

this.PlayInCliffTown = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg1120",{delayTime = "short"})
end

this.PlayFoundHostage = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	
	
	TppRadio.Play("s0044_rtrg2010",{delayTime = "short"})
	this.ORadioSet20()
end


this.PlayHintOfRoom = function()
	Fox.Log(":: s10044 :: play hint of place if player do not know place ")
	if svars.isGetInfoHoneyBee then
		Fox.Log("no play radio, because player know place")
	else
		TppRadio.Play("s0044_rtrg1070",{delayTime = "short"})
	end
end

this.PlayGetHoneyBee = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg4020",{delayTime = "short"})
	this.ORadioSet40()
end

this.PlayRideOnVehicle = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg2030",{delayTime = "short"})
end

this.PlayFindRoom = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg4010",{delayTime = "long"})
end


this.PlayBossEncounter = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg4040",{delayTime = "short"})
end

this.PlayBossEnd = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg5020",{delayTime = "short"})
	this.ORadioSet50()
end



this.PlayFultonHost = function()
	Fox.Log(":: s10044 :: radio.lua ::")
	TppRadio.Play("s0044_rtrg3020",{delayTime = "short"})
end

this.PlayInfoHostage1 = function()
	Fox.Log(":: s10044 :: rescue normal hostage 1::")
	TppRadio.Play("s0044_rtrg1090",{delayTime = "short"})
end
this.PlayInfoHostage2 = function()
	Fox.Log(":: s10044 :: rescue normal hostage 2::")
	TppRadio.Play("s0044_rtrg1100",{delayTime = "short"})
end
this.PlayInfoHostage3 = function()
	Fox.Log(":: s10044 :: rescue normal hostage 3::")
	TppRadio.Play("s0044_rtrg1110",{delayTime = "short"})
end


this.PlayAboutBattleVehicle = function()
	Fox.Log(":: s10044 :: get information for vehicle::")
	TppRadio.Play("f1000_rtrg3545",{delayTime = "long"})
end


this.PlayContinue_GetInfo =function()
	Fox.Log("PlayContinue_GetInfo")
	TppRadio.Play("s0044_rtrg0210",{delayTime = "short"})
end
this.PlayContinue_ListenIntel =function()
	Fox.Log("PlayContinue_ListenIntel")
	TppRadio.Play("s0044_rtrg0220",{delayTime = "short"})

end



this.CantGetIntelOnAlert = function()
	TppRadio.Play( "f1000_rtrg1680" )
end



return this
