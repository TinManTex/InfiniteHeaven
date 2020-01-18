local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	
	"DetectStopPump_enemy",
	
	
	{ "s0080_rtrg1000", playOnce = true },		
	{ "s0080_rtrg1010", },						
	{ "s0080_rtrg1020", playOnce = true },		
	{ "s0080_rtrg1030", playOnce = true },		
	{ "s0080_rtrg1040", playOnce = true },		
	{ "s0080_rtrg1050", playOnce = true },		
	{ "s0080_rtrg1060", playOnce = true },		
	{ "s0080_rtrg1070", playOnce = true },		
	{ "s0080_rtrg1080", playOnce = true },		
	{ "s0080_rtrg1090", playOnce = true },		
	{ "s0080_rtrg1100", playOnce = true },		
	{ "s0080_rtrg1110", playOnce = true },		
	{ "s0080_rtrg1120", playOnce = true },		
	{ "s0080_rtrg1130", playOnce = true },		
	{ "s0080_rtrg1140", playOnce = true },		
	{ "s0080_rtrg1150", playOnce = true },		
	{ "s0080_rtrg1160", playOnce = true },		
	{ "s0080_rtrg1170", playOnce = true },		
	{ "s0080_rtrg1180", playOnce = true },		
	{ "s0080_rtrg1190", playOnce = true },		
	{ "s0080_rtrg2010", playOnce = true },		
	{ "s0080_rtrg2020", playOnce = true },		
	{ "s0080_rtrg2030", playOnce = true },		
	{ "s0080_rtrg2040", playOnce = true },		
	{ "s0080_rtrg2050", playOnce = true },		
	{ "s0080_rtrg4010", playOnce = true },		
	{ "s0080_rtrg4020", playOnce = true },		
	{ "s0080_rtrg4030", },						
	{ "s0080_rtrg4040", },						
	{ "s0080_rtrg4045", },						
	{ "s0080_rtrg4050", },						
	{ "s0080_rtrg4060", },						
	{ "s0080_rtrg4053", },						
	{ "s0080_rtrg4056", },						
	{ "f1000_rtrg7010", },						
	{ "s0080_rtrg4070", playOnce = true },		
	{ "s0080_rtrg4080", playOnce = true },		
	{ "s0080_rtrg4090", playOnce = true },		
	{ "s0080_rtrg5000", playOnce = true },		
	{ "s0080_rtrg5100", playOnce = true },		
	
	{ "s0080_rtrg1035", playOnce = true },		
	{ "s0080_rtrg1055", playOnce = true },		
	
	
	{ "s0080_mirg1010", },						
	{ "s0080_mirg1020", },						
	{ "s0080_mirg1030", },						
	
	
	{ "s0080_mprg1010", },						
	{ "s0080_mprg1020", },						
	
 }





this.optionalRadioList = {
	"Set_s0080_oprg0070",	
	"Set_s0080_oprg0080",	
	"Set_s0080_oprg0090",	
	"Set_s0080_oprg0100",	
	"Set_s0080_oprg0110",	
	"Set_s0080_oprg0120",	
	"Set_s0080_oprg0130",	
	
}





this.intelRadioList = {
	erl_dirtyriver		 				= "s0080_esrg1010",	


	erl_flowStation_entrance 			= "s0080_esrg1050",	
	erl_flowStation_route			 	= "s0080_esrg1060",	
	erl_chimney							= "s0080_esrg1070",	
	erl_Scorchedearth					= "s0080_esrg3010",	
	erl_ScorchedearthCorpse				= "s0080_esrg3020",	
	erl_lookAtTank						= "s0080_esrg4010",	
	erl_lookAtPumproom					= "s0080_esrg4020",	
	erl_lookAtDeadbody					= "s0080_esrg4030",	
	
	type_walkergear						= "s0080_esrg4050", 
	type_walkergear_used				= "s0080_esrg4050", 

	
	sol_outland_0000					= "s0080_esrg1030",	
	sol_outland_0001					= "s0080_esrg1030",	
	sol_outland_0002					= "s0080_esrg1030",	
	sol_outland_0003					= "s0080_esrg1030",	
	sol_outland_0004					= "s0080_esrg1030",	
	sol_outland_0005					= "s0080_esrg1030",		
	sol_teacher_0000					= "s0080_esrg1030",	
	sol_teacher_0001					= "s0080_esrg1030",	
	sol_01_20_0000						= "s0080_esrg1030",	
	sol_01_20_0001						= "s0080_esrg1030",	
	sol_outlandEast_0000				= "s0080_esrg1030",	
	sol_outlandEast_0001				= "s0080_esrg1030",	
	sol_outlandEast_0002				= "s0080_esrg1030",	
	sol_outlandEast_0003				= "s0080_esrg1030",	
	sol_outlandNorth_0000				= "s0080_esrg1030",	
	sol_outlandNorth_0001				= "s0080_esrg1030",	
	sol_outlandNorth_0002				= "s0080_esrg1030",	
	sol_outlandNorth_0003				= "s0080_esrg1030",	
	sol_flowStation_0000				= "s0080_esrg1030",	
	sol_flowStation_0001				= "s0080_esrg1030",	
	sol_flowStation_0002				= "s0080_esrg1030",	
	sol_flowStation_0003				= "s0080_esrg1030",	
	sol_flowStation_0004				= "s0080_esrg1030",	
	sol_flowStation_0005				= "s0080_esrg1030",	
	sol_flowStation_0006				= "s0080_esrg1030",	
	sol_flowStation_0007				= "s0080_esrg1030",	
	sol_flowStation_0008				= "s0080_esrg1030",	
	sol_flowStation_0009				= "s0080_esrg1030",	
	sol_flowStation_0010				= "s0080_esrg1030",	
	sol_flowStation_0011				= "s0080_esrg1030",	
	sol_flowStation_0012				= "s0080_esrg1030",	
	sol_flowStation_0013				= "s0080_esrg1030",	
	sol_flowStation_0014				= "s0080_esrg1030",	
	sol_flowStation_0015				= "s0080_esrg1030",	
	sol_flowStation_0016				= "s0080_esrg1030",	
	sol_flowStation_0017				= "s0080_esrg1030",	
	sol_swampWest_0000					= "s0080_esrg1030",	
	sol_swampWest_0001					= "s0080_esrg1030",	
	sol_swampWest_0002					= "s0080_esrg1030",	
	sol_swampWest_0003					= "s0080_esrg1030",		
	sol_swampWest_0004					= "s0080_esrg1030",	
	sol_swampWest_0005					= "s0080_esrg1030",	
	sol_walkerGear_0000					= "s0080_esrg1030",	
	sol_walkerGear_0001					= "s0080_esrg1030",	
	sol_walkerGear_0002					= "s0080_esrg1030",	
	sol_walkerGear_0003					= "s0080_esrg1030",	
	

}

this.IntelRadioList_enemy  = {
	
	sol_flowStation_0000				= "s0080_esrg4040",	
	sol_flowStation_0001				= "s0080_esrg4040",	
	sol_flowStation_0002				= "s0080_esrg4040",	
	sol_flowStation_0003				= "s0080_esrg4040",	
	sol_flowStation_0004				= "s0080_esrg4040",	
	sol_flowStation_0005				= "s0080_esrg4040",	
	sol_flowStation_0006				= "s0080_esrg4040",	
	sol_flowStation_0007				= "s0080_esrg4040",	
	sol_flowStation_0008				= "s0080_esrg4040",	
	sol_flowStation_0009				= "s0080_esrg4040",	
	sol_flowStation_0010				= "s0080_esrg4040",	
	sol_flowStation_0011				= "s0080_esrg4040",	
	sol_flowStation_0012				= "s0080_esrg4040",	
	sol_flowStation_0013				= "s0080_esrg4040",	
	sol_flowStation_0014				= "s0080_esrg4040",	
	sol_flowStation_0015				= "s0080_esrg4040",	
	sol_flowStation_0016				= "s0080_esrg4040",	
	sol_flowStation_0017				= "s0080_esrg4040",	
	sol_swampWest_0000					= "s0080_esrg4040",	
	sol_swampWest_0001					= "s0080_esrg4040",	
	sol_swampWest_0002					= "s0080_esrg4040",	
	sol_swampWest_0003					= "s0080_esrg4040",		
	sol_swampWest_0004					= "s0080_esrg4040",	
	sol_swampWest_0005					= "s0080_esrg4040",	
	sol_walkerGear_0000					= "s0080_esrg4040",	
	sol_walkerGear_0001					= "s0080_esrg4040",	
	sol_walkerGear_0002					= "s0080_esrg4040",	
	sol_walkerGear_0003					= "s0080_esrg4040",	
	
	sol_outland_0000					= "f1000_esrg0870",	
	sol_outland_0001					= "f1000_esrg0870",	
	sol_outland_0002					= "f1000_esrg0870",	
	sol_outland_0003					= "f1000_esrg0870",	
	sol_outland_0004					= "f1000_esrg0870",	
	sol_outland_0005					= "f1000_esrg0870",		
	sol_teacher_0001					= "f1000_esrg0870",	
	sol_01_20_0000						= "f1000_esrg0870",	
	sol_01_20_0001						= "f1000_esrg0870",	
	sol_outlandEast_0000				= "f1000_esrg0870",	
	sol_outlandEast_0001				= "f1000_esrg0870",	
	sol_outlandEast_0002				= "f1000_esrg0870",	
	sol_outlandEast_0003				= "f1000_esrg0870",	
	sol_outlandNorth_0000				= "f1000_esrg0870",	
	sol_outlandNorth_0001				= "f1000_esrg0870",	
	sol_outlandNorth_0002				= "f1000_esrg0870",	
	sol_outlandNorth_0003				= "f1000_esrg0870",	
}



this.blackTelephoneDisplaySetting = {
	f6000_rtrg0080 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10080_02.ftex", 0.6 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10080_01.ftex", 15.2 }, 
			{ "hide", "sub_1", 39.4 }, 
			{ "hide", "main_1", 39.7 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10080_03.ftex", 40.0 },
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10080_02.ftex", 0.6 }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10080_01.ftex", 13.1 }, 
			{ "hide", "main_1", 37.4 }, 
			{ "hide", "sub_1", 37.7 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10080_03.ftex", 38.0 }, 
		},
	},
}






this.Opening = function()
	TppRadio.Play( 	"s0080_rtrg4080", { delayTime = "short" })
end
this.Opening2 = function()
	TppRadio.Play( 	"s0080_rtrg4090", { delayTime = "short" })
end


this.MissionStart = function()
	TppRadio.Play( "s0080_rtrg1010", { delayTime = "short" } )
end


this.ApproachOutland = function()
	TppRadio.Play( "s0080_rtrg1030", { delayTime = "short" } )
end


this.ApproachFlowStation = function()
	TppRadio.Play( "s0080_rtrg1120", { delayTime = "short" } )
end


this.ApproachScorchedearthVillage = function()
	TppRadio.Play( "s0080_rtrg1100", { delayTime = "short" } )
end

this.ApproachScorchedearthCorpse = function()
	TppRadio.Play( "s0080_rtrg1110", { delayTime = "short" } )
end


this.AfterDemo_outland = function()
	TppRadio.Play( "s0080_rtrg1040", { delayTime = "short" } )
end

this.DontAttackTochild = function()
	TppRadio.Play( "s0080_rtrg1050", { delayTime = "short" } )
end


this.ApproachRiver = function()
	TppRadio.Play( "s0080_rtrg1020", { delayTime = "short" } )
end


this.OtherSideWay = function()

end


this.WayToFlowStation = function()
	TppRadio.Play( "s0080_rtrg1090", { delayTime = "short" } )
end


this.NotCompleteObjective = function()

end


this.ApproachPump = function()
	TppRadio.Play( "s0080_rtrg1170", { delayTime = "short" } )
end


this.ApproachTank = function()
	TppRadio.Play( "s0080_rtrg1130", { delayTime = "short" } )
end


this.PutC4 = function()
	TppRadio.Play( "s0080_rtrg1140", { delayTime = "short" } )
end

this.PutC4andLeave = function()
	TppRadio.Play( "s0080_rtrg1150", { delayTime = "short" } )
end



this.StopedPump_beforeTank = function()
	TppRadio.Play( "s0080_rtrg1180", { delayTime = "mid" } )
end

this.StopedPump_afterTank = function()
	TppRadio.Play( "s0080_rtrg2020", { delayTime = "mid" } )
end

this.BreakedTank_beforePump = function()
	TppRadio.Play( "s0080_rtrg1190", { delayTime = "mid" } )
end

this.BreakedTank_afterPump = function()
	TppRadio.Play( "s0080_rtrg2010", { delayTime = "mid" } )
end
	

this.MountainHunting_start = function()
	TppRadio.Play( 	"s0080_rtrg2050", { delayTime = "short" })
end


this.DetailOfMission = function()
	TppRadio.Play( 	"s0080_rtrg1060", { delayTime = "short" })
end


this.DetailOfMission2 = function()
	TppRadio.Play( 	"s0080_rtrg1070", { delayTime = "short" })
end



this.RoadBlocked_1 = function()
	TppRadio.Play( 	"s0080_rtrg2030", { delayTime = "short" })
end

this.RoadBlocked_2 = function()
	TppRadio.Play( 	"s0080_rtrg2040", { delayTime = "short" })
end


this.DisableTranslateCount = function()
	TppRadio.Play( 	"s0080_rtrg1000", { delayTime = "short" } )
end


this.ThisisPump = function()
	TppRadio.Play( 	"s0080_rtrg4010", { delayTime = "short" } )
end


this.ThisisTank = function()
	TppRadio.Play( 	"s0080_rtrg4020", { delayTime = "short" } )
end


this.LookatWalkerGear = function()
	TppRadio.Play( 	"s0080_rtrg4070", { delayTime = "short" } )
end


this.AboutFultonThechild = function()
	TppRadio.Play( 	"s0080_rtrg5000", { delayTime = "short" } )
end


this.CantCatchThechild = function()
	TppRadio.Play( 	"s0080_rtrg5100", { delayTime = "short" } )
end


this.SurprisedChild = function()
	TppRadio.Play( 	"s0080_rtrg1035", { delayTime = "short" } )
end


this.FultonChild = function()
	TppRadio.Play( 	"s0080_rtrg1055", { delayTime = "short" } )
end


this.continue_startpoint = function()
	TppRadio.Play( 	"s0080_rtrg4040", { delayTime = "short" } )
end
this.continue_outland = function()
	TppRadio.Play( 	"s0080_rtrg4045", { delayTime = "short" } )
end
this.continue_road = function()
	TppRadio.Play( 	"s0080_rtrg4050", { delayTime = "short" } )
end
this.continue_flowStation = function()
	TppRadio.Play( 	"s0080_rtrg4060", { delayTime = "short" } )
end
this.continue_afterBreakTank = function()
	TppRadio.Play( 	"s0080_rtrg4056", { delayTime = "short" } )
end
this.continue_afterStopPump = function()
	TppRadio.Play( 	"s0080_rtrg4053", { delayTime = "short" })
end
this.continue_completeObjective = function()
	TppRadio.Play( 	"f1000_rtrg7010", { delayTime = "short" })
end


this.afterMissionRadio = function()
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0080" )
end





this.SetRadio_start = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0070" )
	
	this.SetRadio_EspionageRadio_start()
	
end


this.SetRadio_EspionageRadio_start = function()
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
			"erl_chimney" , 
			"erl_dirtyriver",
			"erl_flowStation_entrance",
			"erl_flowStation_route",
			"erl_dirtyriver",
			"erl_lookAtPumproom",
			"erl_lookAtTank",
			"erl_Scorchedearth",
			"erl_ScorchedearthCorpse",

		}, 
		enable = true }
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
			"erl_teacherDemo" ,
			"erl_lookAtDeadbody" , 
		}, 
		enable = false }	
end


this.SetRadio_ChangeIntelRadio_enemy = function()
	TppRadio.ChangeIntelRadio( s10080_radio.IntelRadioList_enemy )
end

this.SetRadio_ApproachOutland = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0080" )
end

this.SetRadio_EnableEspionageTeacherDemo = function()
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
	{ 	"erl_teacherDemo" , 
	}, enable = true }	
end

this.SetRadio_DisableEspionageTeacherDemo = function()
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
	{ 	"erl_teacherDemo" , 
	}, enable = false }	
end


this.SetRadio_WayToFlowStation = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0090" )
end


this.SetRadio_ApproachFlowStation = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0100" )
end


this.SetRadio_afterStopedPump = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0110" )
	
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
			"erl_lookAtPumproom" , 
		}, 
		enable = false }	
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
			"erl_lookAtDeadbody" , 
		}, 
		enable = true }	
end


this.SetRadio_afterBreakedTank = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0120" )
	
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
		"erl_lookAtTank" , 
		}, 
		enable = false }	
end

this.SetRadio_missionComplete = function()
	TppRadio.SetOptionalRadio( "Set_s0080_oprg0130" )

	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
			"erl_chimney" , 
			"erl_dirtyriver",
			"erl_flowStation_entrance",
			"erl_flowStation_route",
			"erl_dirtyriver",
			"erl_lookAtPumproom",
			"erl_Scorchedearth",
			"erl_ScorchedearthCorpse",
		}, 
		enable = false }
	TppRadioCommand.SetEnableEspionageRadioTarget{ name= 
		{ 	
			"erl_lookAtDeadbody" , 
		}, 
		enable = true }	
end



return this
