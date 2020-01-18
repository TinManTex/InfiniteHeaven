local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


this.requires = {}



local JACKAL_GROUP01 = "JackalGameObjectLocator01"
local JACKAL_GROUP02 = "JackalGameObjectLocator02"
local JACKAL_GROUP03 = "JackalGameObjectLocator03"
local JACKAL_GROUP04 = "JackalGameObjectLocator04"
local JACKAL_GROUP05 = "JackalGameObjectLocator05"
local JACKAL_GROUP06 = "JackalGameObjectLocator06"





this.USE_COMMON_REINFORCE_PLAN = true







this.FirstCarSearchUnit = {
	"sol_SwampWest_0002",
	"sol_SwampWest_0003",
	"sol_SwampWest_0004",
}


this.SurroundCarSearchUnit = {
	"sol_SwampWest_0005",
}



this.NOTALKINGLIST= {
	"sol_SwampWest_0002",
	"sol_SwampWest_0003",
	"sol_SwampWest_0004",
	"sol_SwampWest_0005",
	"sol_ExecuteUnit_0000",		
	"sol_ExecuteUnit_0001",		
}


this.SURROUNDUNITLIST= {
		"sol_swampSurrond_0003",

		"sol_swampSurrond_0005",
		"sol_swampSurrond_0000",
		"sol_swampSurrond_0001",
		"sol_swampSurrond_0002",
}







this.soldierDefine = {

	
	mafr_swamp_cp = {
		"sol_swamp_0000",
		"sol_swamp_0001",
		"sol_swamp_0002",
		"sol_swamp_0003",
		"sol_swamp_0004",
		"sol_swamp_0005",
		"sol_swamp_0006",
		"sol_swamp_0007",
		"sol_swampSurrond_0003",

		"sol_swampSurrond_0005",
		"sol_swampSurrond_0000",		
		"sol_swampSurrond_0001",		
		"sol_swampSurrond_0002",		

		"sol_ExecuteUnit_0000",		
		"sol_ExecuteUnit_0001",		
		"sol_SwampNear_0000",			
		"sol_SwampNear_0001",
		nil
	},
	mafr_swampWest_ob = {
		"sol_SwampWest_0000",
		"sol_SwampWest_0001",
		"sol_SwampWest_0002",
		"sol_SwampWest_0003",
		"sol_SwampWest_0005",
		"sol_SwampWest_0004",
		nil
	},


	mafr_swampEast_ob = {
		"sol_SwampEast_0000",
		"sol_SwampEast_0001",
		"sol_SwampEast_0002",
		"sol_SwampEast_0003",
		nil
	},
	mafr_swampSouth_ob = {
		"sol_SwampSouth_0000",
		"sol_SwampSouth_0001",
		"sol_SwampSouth_0002",
		"sol_SwampSouth_0003",
		nil
	},


	mafr_EX_Truck_cp = {
		"sol_Truck_Driver",
		nil
	},



	mafr_Travel_cp_01 = {
		nil
	},
	mafr_Travel_cp_02 = {
		nil
	},

	
	mafr_Travel_cp_04 = {
		nil
	},
	mafr_Travel_cp_05 = {
		nil
	},

	
	mafr_02_22_lrrp = { nil },
	mafr_06_22_lrrp = { nil },
	mafr_05_22_lrrp = {
		"sol_lrrp_05_22_0000",
		"sol_lrrp_05_22_0001",
		lrrpTravelPlan = "travel_swamp",
	 },
	nil
}


this.soldierPowerSettings = {
	sol_SwampWest_0002 = { "SHOTGUN", "ARMOR", },
	sol_SwampWest_0003 = { "SHOTGUN", "ARMOR", },

	
	sol_ExecuteUnit_0000 = { "MG" },
	sol_ExecuteUnit_0001 = { "SHOTGUN" },
}







local spawnList = {

	{ id="Spawn", locator="veh_Search_0000", type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },	
	{ id="Spawn", locator="veh_Surround_01", type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },		
	{ id="Spawn", locator="veh_Execute_0000", type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0, },	
	{ id = "Spawn", locator = "veh_Truck_0001",	type = Vehicle.type.WESTERN_TRUCK, subType = Vehicle.subType.WESTERN_TRUCK_CARGO_CONTAINER, paintType=Vehicle.paintType.FOVA_0, },

}

this.vehicleDefine = {
	instanceCount	= #spawnList + 1,
}

this.SpawnVehicleOnInitialize = function()
	TppEnemy.SpawnVehicles( spawnList )
end






this.routeSets = {


	mafr_swamp_cp = {
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
			"groupSwampNear",
		},
		fixedShiftChangeGroup = {
			"groupSniper",	
			"groupSwampNear",	
		},
		sneak_day = {
			groupSniper = {
				{ "rt_swamp_snp_0000", attr = "SNIPER" },
				{ "rt_swamp_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_swamp_d_0000",
				"rt_swamp_d_0005",
				"rt_swamp_d_0010",
			},
			groupB = {
				"rt_swamp_d_0001",
				"rt_swamp_d_0006",
				"rt_swamp_d_0011",
			},
			groupC = {
				"rt_swamp_d_0002",
				"rt_swamp_d_0007",
				"rt_swamp_d_0012",

			},
			groupD = {
				"rt_swamp_d_0003",
				"rt_swamp_d_0008",
				"rt_swamp_d_0013",

			},
			groupE = {
				"rt_swamp_d_0004",
				"rt_swamp_d_0009",
				"rt_swamp_d_0014",

			},
			groupSwampNear = {	
				"rt_SwampNear_d_0000",
				"rt_SwampNear_d_0001",
				"rt_SwampNear_d_0002_no_watchtower_sub",	
			},
			nil
		},

		sneak_night = {
			groupSniper = {
				{ "rt_swamp_snp_0000", attr = "SNIPER" },
				{ "rt_swamp_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_swamp_n_0000",
				"rt_swamp_n_0005_no_searchlight_sub",	
				"rt_swamp_n_0010",
			},
			groupB = {
				"rt_swamp_n_0001_no_searchlight_sub",	
				"rt_swamp_n_0006",
				"rt_swamp_n_0011",
			},
			groupC = {
				"rt_swamp_n_0002",
				"rt_swamp_n_0007",
				"rt_swamp_n_0012",

			},
			groupD = {
				"rt_swamp_n_0003_no_searchlight_sub",	
				"rt_swamp_n_0008_no_searchlight_sub",	
				"rt_swamp_n_0013",

			},
			groupE = {
				"rt_swamp_n_0004",
				"rt_swamp_n_0009_no_searchlight_sub",	
				"rt_swamp_n_0014",

			},
			groupSwampNear = {	
				"rt_SwampNear_n_0000_no_searchlight_sub",		
				"rt_SwampNear_n_0001_no_searchlight_sub",		
				"rt_SwampNear_n_0002",
			},
			nil
		},
		caution = {
			groupSniper = {
				{ "rt_swamp_snp_0000", attr = "SNIPER" },
				{ "rt_swamp_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_swamp_c_0000",
				"rt_swamp_c_0001",
				"rt_swamp_c_0002",
				"rt_swamp_c_0003",
				"rt_swamp_c_0004_searchlight",		
				"rt_swamp_c_0005",
				"rt_swamp_c_0006",
				"rt_swamp_c_0007",
				"rt_swamp_c_0000",	
				"rt_swamp_c_0008",
				"rt_swamp_c_0009",
				"rt_swamp_c_0010",
				"rt_swamp_c_0011",
				"rt_swamp_c_0012",
				"rt_swamp_c_0013",
				"rt_swamp_c_0014",
				"rt_swamp_c_0015",
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
			groupE = {
			},
			groupSwampNear = {
			},
			nil
		},
		hold = {
			groupSniper = {
			},
			groupA = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swamp_h_0002",
				"rt_swamp_h_0003",
			},
			groupB = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swamp_h_0002",
				"rt_swamp_h_0003",
			},
			groupC = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swamp_h_0002",
				"rt_swamp_h_0003",
			},
			groupD = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swamp_h_0002",
				"rt_swamp_h_0003",
			},
			groupE = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swamp_h_0002",
				"rt_swamp_h_0003",
			},
			groupSwampNear = {
				"rt_swampNear_h_0000",
				"rt_swampNear_h_0001",
				"rt_swampNear_h_0002",
			},
		},
		sleep = {
			groupSniper = {
			},
			groupA = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swamp_s_0002",
				"rt_swamp_s_0003",
			},
			groupB = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swamp_s_0002",
				"rt_swamp_s_0003",
			},
			groupC = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swamp_s_0002",
				"rt_swamp_s_0003",
			},
			groupD = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swamp_s_0002",
				"rt_swamp_s_0003",
			},
			groupE = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swamp_s_0002",
				"rt_swamp_s_0003",
			},
			groupSwampNear = {
				"rt_swampNear_s_0000",
				"rt_swampNear_s_0001",
				"rt_swampNear_s_0002",
			},
		},
		travel = {
			lrrpHold = {
				"rt_swamp_l_0000",
				"rt_swamp_l_0001",
			},
			SupportIn = {
				"rts_Truck025_swamp",
			},
			SupportOut = {
				"rt_swamp_lin_E",
			},
			Smoking02 = {
				"SmokingBreak02",
			},
		},
		outofrain = {
			"rt_swamp_r_0000",
			"rt_swamp_r_0001",
			"rt_swamp_r_0002",
			"rt_swamp_r_0003",
			"rt_swamp_r_0004",
			"rt_swamp_r_0005",
			"rt_swamp_r_0006",
			"rt_swamp_r_0007",
			"rt_swamp_r_0008",
			"rt_swamp_r_0009",
			"rt_swamp_r_0010",
			"rt_swamp_r_0011",
		},
		nil
	},



	mafr_swampWest_ob = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"rt_swampWest_d_0001",		
				"rts_d_SwampWest0001",
				"rts_d_SwampWest0002",
				"rts_d_SwampWest0003",
				"rts_d_SwampWest0004",
				"rts_d_SwampWest0005",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rt_swampWest_n_0000",
				"rt_swampWest_n_0001",
				"rt_swampWest_n_0002",
				"rt_swampWest_n_0003",
				"rt_swampWest_n_0004",
				"rt_swampWest_n_0005",
			},
			nil
		},
		caution = {
			groupA = {
				"rt_swampWest_c_0000",
				"rt_swampWest_c_0001",
				"rt_swampWest_c_0002",
				"rt_swampWest_c_0003",
				"rt_swampWest_c_0004",
				"rt_swampWest_c_0005",
			},
			nil
		},
		hold = {
			default = {
			},
		},
		sleep = {
			default = {
				"rt_swampWest_s_0000",
				"rt_swampWest_s_0001",
			},
		},
		travel = {
			Smoking01 = {
				"SmokingBreak01",
			},
		},
		outofrain = {
			"rt_swampWest_r_0000",
			"rt_swampWest_r_0001",
			"rt_swampWest_r_0002",
			"rt_swampWest_r_0003",
			"rt_swampWest_r_0004",
			"rt_swampWest_r_0005",
			"rt_swampWest_r_0006",
			"rt_swampWest_r_0007",
		},
		nil
	},


	mafr_EX_Truck_cp = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"rts_Driver_standby",
			},
			nil
		},
		sneak_night = {
			groupA = {
				"rts_Driver_standby",
			},
			nil
		},
		caution = {
			groupA = {
				"rts_Driver_standby",
			},
			nil
		},
		hold = {
			default = {
				"rts_Driver_standby",
			},
		},
		nil
	},


	
	mafr_Travel_cp_01 = {
		priority = {
			"groupA",		
			"groupB",		
			"groupC",		
			"groupD",		
		},
		sneak_day = {
			groupA = {
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		sneak_night= {
			groupA = {
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		caution = {
			groupA = {
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		hold = {
			default = {

			},
		},
		travel = {
			
			
			groupA = {
				"First_Car",
				"First_Car",
				"First_Car",

			},
			groupB = {
				"Surround_Car",	
			},
			groupC = {			
				"Last_Car",
				"Last_Car",
				"Last_Car",
				"Last_Car",
			},
			groupD = {
				"rts_Truck02",	
			},
			SupportOut = {
				"Last_Car_back",
			},
		},
		nil
	},

	
	mafr_Travel_cp_02 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {

			},
		},
		sneak_night= {
			groupA = {

			},
		},
		caution = {
			groupA = {

			},
		},
		hold = {
			default = {

			},
		},
		travel = {
			
			
			groupA = {
				"Second_Car",
				"Second_Car",
			},
		},
		nil
	},


	
	mafr_Travel_cp_04 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {

			},
		},
		sneak_night= {
			groupA = {

			},
		},
		caution = {
			groupA = {

			},
		},
		hold = {
			default = {

			},
		},
		travel = {
			groupA = {
				"rts_Truck01",
			},
		},
		nil
	},


	
	mafr_Travel_cp_05 = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {

			},
		},
		sneak_night= {
			groupA = {

			},
		},
		caution = {
			groupA = {

			},
		},
		hold = {
			default = {

			},
		},
		travel = {
			groupA = {
				"rts_Truck03",
			},
		},
		nil
	},

	
	mafr_swampEast_ob		 	= { USE_COMMON_ROUTE_SETS = true,	},
	mafr_swampSouth_ob		 	= { USE_COMMON_ROUTE_SETS = true,	},

	

	mafr_02_22_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	mafr_06_22_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},
	mafr_05_22_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
	},

	nil
}





this.combatSetting = {

	
	mafr_swampWest_ob = {
		"gt_swampWest_0000",
	},

	mafr_swampEast_ob = {
		"gt_swampEast_0000",
	},

	mafr_swampSouth_ob = {
		"gt_swampSouth_0000",
	},
	
	mafr_swamp_cp = {
		"TppGuardTargetData0001",
		"cs_swamp_s10091",
		"gt_swamp_0001",
		"cs_swamp_0001",
		
		"gt_swampForest",
		"cs_swampForest_s10091",
	},
	nil

}






this.UniqueInterStart_sol_ExecuteUnit_0000 = function( soldier2GameObjectId, cpID )
	if (svars.isExecuteUnitRouteChanged == true) and (svars.isExecuteUnitInterrogated == false) then
		Fox.Log("###CallBack : Unique : InterStart_sol_ExecuteUnit_0000")
		TppInterrogation.UniqueInterrogation( cpID, "enqt3000_131010") 
	else
		Fox.Log("###Nothing_to_SAY")
		TppInterrogation.UniqueInterrogation( cpID, "enqt1000_151010") 
	end

	return true		
end

this.UniqueInterEnd_sol_ExecuteUnit_0000 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###CallBack : Unique : InterEnd_sol_ExecuteUnit_0001 : InterName = " .. tostring(interName) )
	
	svars.isExecuteUnitInterrogated = true
end



this.InterCall_Target01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10091_enemy.InterCall_Target01()")
	TppMission.UpdateObjective{
		objectives = {"interrogation_area_swampNorthForest",},
	}
end
this.InterCall_Target02 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10091_enemy.InterCall_Target02()")
	TppMission.UpdateObjective{
		objectives = {"interrogation_area_swamp_Target02",},
	}
end

this.InterCall_SubTaskTarget = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10091_enemy.InterCall_SubTaskTarget()")
	TppMission.UpdateObjective{
		objectives = {"interrogation_on_HiddenHostage",},
	}
	TppRadio.Play( "f1000_esrg0810",{delayTime = "short", isEnqueue = true} )
end

this.InterCall_Truck = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("###***s10091_enemy.InterCall_Truck()")
	TppMission.UpdateObjective{
		objectives = {"interrogation_on_TruckDriver",},
	}
	TppMarker.Enable( "veh_Truck_0001" , 0 , "none" , "map_and_world_only_icon" , 0 , false , true )	
end

this.uniqueInterrogation = {
	unique = {
		{ name = "enqt3000_131010", func = this.UniqueInterEnd_sol_ExecuteUnit_0000, },		
		nil
	},
	uniqueChara = {
		{ name = "sol_ExecuteUnit_0000", func = this.UniqueInterStart_sol_ExecuteUnit_0000, },
		{ name = "sol_ExecuteUnit_0001", func = this.UniqueInterStart_sol_ExecuteUnit_0000, },
		nil
	},
	nil
}





this.interrogation = {
	
	mafr_swamp_cp = {
		
		high = {
			{ name = "enqt3000_111010", func = this.InterCall_Target01, },	
		
			{ name = "enqt1000_106920", func = this.InterCall_Truck, },	
			{ name = "enqt1000_1i1210", func = this.InterCall_SubTaskTarget, },	
			nil
		},
		normal = {
			nil
		},
		nil
	},
	mafr_swampWest_ob = {
		
		high = {
			{ name = "enqt1000_1c1210", func = this.InterCall_Truck, },	
		},
		
		normal = {
			nil
		},
		nil
	},
	nil
}


this.HighInterrogation = function()
	Fox.Log("###*** SetUp_HighInterrogation ***")
	TppInterrogation.AddHighInterrogation(
		GameObject.GetGameObjectId( "mafr_swamp_cp" ),
		{
			{ name = "enqt3000_111010", func = this.InterCall_Target01, },
		
			{ name = "enqt1000_1i1210", func = this.InterCall_SubTaskTarget, },
			{ name = "enqt1000_106920", func = this.InterCall_Truck, },
		}
	)
end


this.RemoveHighInterrogationSubTask = function()
	Fox.Log("###*** s10091_enemy.RemoveHighInterrogationSubTask ***")
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("mafr_swamp_cp"),
	{
		{ name = "enqt1000_1i1210", func = s10091_enemy.InterCall_SubTaskTarget, },
	})
end


this.RemoveHighInterrogationSubTask06 = function()
	Fox.Log("###*** s10091_enemy.RemoveHighInterrogationSubTask06 ***")
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("mafr_swamp_cp"),
	{
		{ name = "enqt1000_106920", func = s10091_enemy.InterCall_Truck, },
	})
end

this.RemoveHighInterrogation = function()
	Fox.Log("###*** s10091_enemy.RemoveHighInterrogation ***")
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("mafr_swamp_cp"),
	{
		{ name = "enqt3000_111010", func = s10091_enemy.InterCall_Target01, },
	})
end




this.useGeneInter = {
	
	mafr_swamp_cp		= true,
	mafr_swampWest_ob		= true,
	mafr_swampEast_ob		= true,
	mafr_swampSouth_ob		= true,
	nil
}





this.travelPlans = {
		Travel_First_Car = {
			ONE_WAY = true,
			{ cp = "mafr_Travel_cp_01", routeGroup={ "travel", "groupA" } },
			{ cp = "mafr_swamp_cp", finishTravel=true },
		},



		Travel_Surround_Car = {
			ONE_WAY = true,
			{ cp = "mafr_Travel_cp_01", routeGroup={ "travel", "groupB" } },
			{ cp = "mafr_swamp_cp", finishTravel=true },
		},


		Travel_Second_Car = {
			ONE_WAY = true,
			{ cp = "mafr_Travel_cp_02", routeGroup={ "travel", "groupA" } },
			{ cp = "mafr_swamp_cp", finishTravel=true },
		},


		Travel_Final_GetBack = {
			ONE_WAY = true,
			{ cp = "mafr_Travel_cp_01", routeGroup={ "travel", "SupportOut" } },		
			{ cp = "mafr_Travel_cp_01", routeGroup={ "travel", "groupC" } },
			{ cp = "mafr_swampWest_ob", finishTravel=true },
		},


		Travel_Truck = {
			ONE_WAY = true,
			{ cp = "mafr_Travel_cp_04", routeGroup={ "travel", "groupA" } },
			{ cp = "mafr_swampWest_ob", routeGroup={ "travel", "Smoking01" }, wait = 35 },	

			{ cp = "mafr_Travel_cp_01", routeGroup={ "travel", "groupD" } },

			{ cp = "mafr_swamp_cp", routeGroup={ "travel", "SupportIn" } },		

			{ cp = "mafr_swamp_cp", routeGroup={ "travel", "Smoking02" }, wait = 100 },	

			{ cp = "mafr_swamp_cp", routeGroup={ "travel", "SupportOut" } },		

			{ cp = "mafr_Travel_cp_05", routeGroup={ "travel", "groupA" } },
			{ cp = "mafr_swampEast_ob", finishTravel=true },
		},

		travel_swamp = {
			{ base = "mafr_swampSouth_ob"},
			{ cp="mafr_05_22_lrrp", 		routeGroup={ "travel", "lrrp_05to22" }, },
			{ cp="mafr_swamp_cp", 		routeGroup={ "travel", "lrrpHold" }, },
			{ cp="mafr_06_22_lrrp", 		routeGroup={ "travel", "lrrp_22to06" }, },
			{ base = "mafr_swampEast_ob"},
			{ cp="mafr_06_22_lrrp", 		routeGroup={ "travel", "lrrp_06to22" }, },
			{ cp="mafr_swamp_cp", 		routeGroup={ "travel", "lrrpHold" }, },
			{ cp="mafr_05_22_lrrp", 		routeGroup={ "travel", "lrrp_22to05" }, },
		},

}







this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	local gameObjectId = { type="TppCommandPost2" } 

	local combatAreaList = {
		area1 = {
			{ guardTargetName="TppGuardTargetData0001", locatorSetName="cs_swamp_s10091",}, 
		},
		area2 = {
			{ guardTargetName="gt_swamp_0001", locatorSetName="cs_swamp_0001",},
		},
		
		area3 = {
			{ guardTargetName="gt_swampForest", locatorSetName="cs_swampForest_s10091",},
		},
	}
	local command = { id = "SetCombatArea", cpName = "mafr_swamp_cp", combatAreaList = combatAreaList }
	GameObject.SendCommand( gameObjectId, command )


	
	this.HighInterrogation()


	
	this.SetSwampNearRoute()

	
	local obSetCommand = { id = "SetMarchCp" }
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_Travel_cp_01" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_Travel_cp_02" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_Travel_cp_04" ) , obSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "mafr_Travel_cp_05" ) , obSetCommand )

	
	this.SetExecuteUnitDayRouteBasedOnTime()

	
	this.SetWolfRouteBasedOnTime()


	
	this.PrisonerCanbeKilled( "hos_s10091_0000" )

	
	this.SurroundersRouteSet()

	
	TppEnemy.SetRescueTargets( { "hos_s10091_0000", "hos_s10091_0001" } )


	
	local gameObjectId = GameObject.GetGameObjectId("TppHostageUnique", "hos_s10091_0001" )
	local command = {
			id		= "SetHostage2Flag",
			flag	= "disableFulton",	
			on		= true,
	}
	GameObject.SendCommand( gameObjectId, command )

	
	this.SetHostageVoiceType()

	
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10091_0002" )
	local command = { id="SetHostage2Flag", flag="forceNoUseHair", on=true }
	GameObject.SendCommand( gameObjectId, command )

	
	this.SetUpExecuteUnitFova()

	
	this.SetAllEnemyStaffParam()

	
	this.SetUpHostageLanguage()

	
	
	local targetList = {
		"sol_ExecuteUnit_0000",
		"sol_ExecuteUnit_0001",
		"hos_s10091_0002",
		"sol_SwampWest_0002",
		"sol_SwampWest_0003",
		"sol_SwampWest_0004",
		"sol_SwampWest_0005",
		"sol_Truck_Driver",
	}
	this.RegistHoldRecoveredStateForMissionTask( targetList )

	
	TppEnemy.SetSneakRoute( "sol_SwampWest_0002", "rts_d_SwampWest_waiting00" )
	TppEnemy.SetSneakRoute( "sol_SwampWest_0003", "rts_d_SwampWest_waiting01" )
	TppEnemy.SetSneakRoute( "sol_SwampWest_0004", "rts_d_SwampWest_waiting02" )
	TppEnemy.SetSneakRoute( "sol_SwampWest_0005", "rts_d_SwampWest_waiting03" )

	
	this.SetAllWolfIgnoreNotice()


end


this.OnLoad = function ()
	Fox.Log("*** s10091 onload ***")
end








this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(targetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end


this.SetHostageVoiceType = function()
	Fox.Log("Set Voice Type for all DD Hostage")
	
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10091_0000" )
	local command = { id = "SetVoiceType", voiceType = "hostage_c" }
	GameObject.SendCommand( gameObjectId, command )

	
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10091_0001" )
	local command = { id = "SetVoiceType", voiceType = "hostage_d" }
	GameObject.SendCommand( gameObjectId, command )

end



this.CPRadioNotFoundTarget = function( gameObjectId )
	Fox.Log("***###s10091_enemy.CPRadioNotFoundTarget###")
	local command = { id="CallRadio", label="CPR0081", stance="Squat" }
	GameObject.SendCommand( gameObjectId, command )
end


this.CheckAliveEnemy = function()
	for index, soldierName in pairs(this.SURROUNDUNITLIST) do
		if soldierName then
			if TppEnemy.GetLifeStatus( soldierName ) == TppEnemy.LIFE_STATUS.NORMAL then
				Fox.Log("!!!! s10091_enemy.CheckAliveEnemy return !!!!"..soldierName)
				return soldierName
			end
		end
	end

	Fox.Log("!!!! s10156_enemy.CheckAliveEnemy ->NoAliveEnemy !!!!")
	return nil
end



function this.DisableOccasionalChat()
	Fox.Log("***###s10091_enemy.DisableOccasionalChat###")
	for i, soldierName in ipairs(this.NOTALKINGLIST) do

		local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", soldierName )
		local command = { id="SetDisableOccasionalChat", disable=true }
		GameObject.SendCommand( gameObjectId, command )
	end
end


this.SetUpExecuteUnitFova = function()
	Fox.Log("***SetUpExecuteUnitFova***")
	
	local soldierName = "sol_ExecuteUnit_0000"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local command = { id = "ChangeSpecialFova", faceIndex=0, bodyIndex=0, balaclavaFaceId=TppEnemyFaceId.pfs_balaclava }
	GameObject.SendCommand( soldierId, command )

	
	local soldierName = "sol_ExecuteUnit_0001"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	command = { id = "ChangeSpecialFova", faceIndex=1, bodyIndex=1, balaclavaFaceId=TppEnemyFaceId.pfs_balaclava }
	GameObject.SendCommand( soldierId, command )

end



this.SetAllEnemyOnVehicle = function()
	Fox.Log( "*****s10091_enemy.SetAllEnemyOnVehicle***")

	local soldierName = "sol_SwampWest_0002"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_SwampWest_0003"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_SwampWest_0004"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )



	local soldierName = "sol_SwampWest_0005"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Surround_01"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )


	local soldierName = "sol_ExecuteUnit_0000"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Execute_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_ExecuteUnit_0001"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Execute_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false,	isVigilance=true }
	GameObject.SendCommand( soldierId, command )


	local soldierName = "sol_Truck_Driver"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Truck_0001"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	GameObject.SendCommand( soldierId, command )

end



this.SetSearchUnitOnVehicle = function()
	Fox.Log( "*****s10091_enemy.SetSearchUnitOnVehicle***")

	local soldierName = "sol_SwampWest_0002"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_SwampWest_0003"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_SwampWest_0004"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	GameObject.SendCommand( soldierId, command )

	local soldierName = "sol_SwampWest_0005"
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local vehicleName = "veh_Search_0000"
	local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
	local command = { id="SetRelativeVehicle", targetId=vehicleId, rideFromBeginning=false }
	GameObject.SendCommand( soldierId, command )
end


this.SurroundersRouteSet = function()
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0000", "rts_d_Surround0000" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0001", "rts_d_Surround0001" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0002", "rts_d_Surround0002" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0003", "rts_d_Surround0003" )

	TppEnemy.SetSneakRoute( "sol_swampSurrond_0005", "rts_d_Surround0005" )


	TppEnemy.SetCautionRoute( "sol_swampSurrond_0000", "rts_d_Surround0000" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0001", "rts_d_Surround0001" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0002", "rts_d_Surround0002" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0003", "rts_d_Surround0003" )

	TppEnemy.SetCautionRoute( "sol_swampSurrond_0005", "rts_d_Surround0005" )
end



this.SurroundersBacktoSwamp = function()
	Fox.Log( "*****s10091_enemy.SurroundersBacktoSwamp*****")
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0000", "rts_back_swamp0000" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0001", "rts_back_swamp0001" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0002", "rts_back_swamp0002" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0003", "rts_back_swamp0003" )

	TppEnemy.SetSneakRoute( "sol_swampSurrond_0005", "rts_back_swamp0005" )


	TppEnemy.SetCautionRoute( "sol_swampSurrond_0000", "rts_back_swamp0000" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0001", "rts_back_swamp0001" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0002", "rts_back_swamp0002" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0003", "rts_back_swamp0003" )

	TppEnemy.SetCautionRoute( "sol_swampSurrond_0005", "rts_back_swamp0005" )
end



function this.PrisonerCanbeKilled( hostageName )
	Fox.Log("***PrisonerCanbeKilled***")

	local GetGameObjectId = GameObject.GetGameObjectId
	local gameObjectId = GetGameObjectId( hostageName )
	local command = { id = "SetNoticeState", state = TppGameObject.HOSTAGE_NOTICE_STATE_FLEE }
	GameObject.SendCommand( gameObjectId, command )
end


function this.GoToExecute( soldierName )
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
	local hostageName = "hos_s10091_0001"
	local hostageId = GameObject.GetGameObjectId("TppHostageUnique", hostageName )
	local command = { id="SetExecuteHostage", targetId=hostageId }
	GameObject.SendCommand( soldierId, command )
end



this.ReturnPosition = function()
	Fox.Log( "*****s10091_enemy.ReturnPosition****")

	TppEnemy.UnsetSneakRoute( "sol_SwampWest_0002" )
	TppEnemy.UnsetSneakRoute( "sol_SwampWest_0003" )
	TppEnemy.UnsetSneakRoute( "sol_SwampWest_0004" )
	TppEnemy.UnsetSneakRoute( "sol_SwampWest_0005" )

	TppEnemy.UnsetCautionRoute( "sol_SwampWest_0002" )
	TppEnemy.UnsetCautionRoute( "sol_SwampWest_0003" )
	TppEnemy.UnsetCautionRoute( "sol_SwampWest_0004" )
	TppEnemy.UnsetCautionRoute( "sol_SwampWest_0005" )

end


this.SearchUnitDayTime = function()
	Fox.Log( "*****s10091_enemy.SearchUnitDayTime*****")
	TppEnemy.SetSneakRoute( "sol_SwampWest_0002", "rts_d_Search0001" )
	TppEnemy.SetSneakRoute( "sol_SwampWest_0003", "rts_d_Search0002" )

	
	TppEnemy.SetCautionRoute( "sol_SwampWest_0002", "rts_d_Search0001" )
	TppEnemy.SetCautionRoute( "sol_SwampWest_0003", "rts_d_Search0002" )
end


this.SearchUnit02DayTime = function()
	Fox.Log( "*****s10091_enemy.SearchUnit02DayTime*****")
	TppEnemy.SetSneakRoute( "sol_SwampWest_0003", "rts_d_Search0002" )

	
	TppEnemy.SetCautionRoute( "sol_SwampWest_0003", "rts_d_Search0002" )
end


this.SearchUnitNightTime = function()
	Fox.Log( "*****s10091_enemy.SearchUnitNightTime*****")
	TppEnemy.SetSneakRoute( "sol_SwampWest_0002", "rts_n_Search0001" )
	TppEnemy.SetSneakRoute( "sol_SwampWest_0003", "rts_n_Search0002" )

	
	TppEnemy.SetCautionRoute( "sol_SwampWest_0002", "rts_n_Search0001" )
	TppEnemy.SetCautionRoute( "sol_SwampWest_0003", "rts_n_Search0002" )
end


this.SearchUnit02NightTime = function()
	Fox.Log( "*****s10091_enemy.SearchUnit02NightTime*****")
	TppEnemy.SetSneakRoute( "sol_SwampWest_0003", "rts_n_Search0002" )

	
	TppEnemy.SetCautionRoute( "sol_SwampWest_0003", "rts_n_Search0002" )
end
















this.TravelPlanFinal = function()
		Fox.Log( "*****s10091_enemy.TravelPlanFinal*****")
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_SwampWest_0002"), { id = "StartTravel", travelPlan="Travel_Final_GetBack" } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_SwampWest_0003"), { id = "StartTravel", travelPlan="Travel_Final_GetBack" } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_SwampWest_0004"), { id = "StartTravel", travelPlan="Travel_Final_GetBack" } )
	GameObject.SendCommand( GameObject.GetGameObjectId( "sol_SwampWest_0005"), { id = "StartTravel", travelPlan="Travel_Final_GetBack" } )
end


this.PrisonerNotFound = function()
	Fox.Log( "*****s10091_enemy.PrisonerNotFound*****")

	
	TppEnemy.UnsetSneakRoute( "sol_swampSurrond_0000" )
	TppEnemy.UnsetSneakRoute( "sol_swampSurrond_0001" )
	TppEnemy.UnsetSneakRoute( "sol_swampSurrond_0002" )
	TppEnemy.UnsetSneakRoute( "sol_swampSurrond_0003" )

	TppEnemy.UnsetSneakRoute( "sol_swampSurrond_0005" )

	
	TppEnemy.UnsetCautionRoute( "sol_swampSurrond_0000" )
	TppEnemy.UnsetCautionRoute( "sol_swampSurrond_0001" )
	TppEnemy.UnsetCautionRoute( "sol_swampSurrond_0002" )
	TppEnemy.UnsetCautionRoute( "sol_swampSurrond_0003" )

	TppEnemy.UnsetCautionRoute( "sol_swampSurrond_0005" )
end


































































this.NarrowSearch = function()
	Fox.Log( "*****s10091_enemy.NarrowSearch*****")

	
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0000", "rts_d_2nd_Surround0000" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0001", "rts_d_2nd_Surround0001" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0002", "rts_d_2nd_Surround0002" )
	TppEnemy.SetSneakRoute( "sol_swampSurrond_0003", "rts_d_2nd_Surround0003" )

	TppEnemy.SetSneakRoute( "sol_swampSurrond_0005", "rts_d_2nd_Surround0005" )


	TppEnemy.SetCautionRoute( "sol_swampSurrond_0000", "rts_d_2nd_Surround0000" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0001", "rts_d_2nd_Surround0001" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0002", "rts_d_2nd_Surround0002" )
	TppEnemy.SetCautionRoute( "sol_swampSurrond_0003", "rts_d_2nd_Surround0003" )

	TppEnemy.SetCautionRoute( "sol_swampSurrond_0005", "rts_d_2nd_Surround0005" )

end



this.SetExecuteUnitDayRouteBasedOnTime = function()
	Fox.Log( "*****s10091_enemy.SetExecuteUnitDayRouteBasedOnTime*****")
	local timeOfDay = TppClock.GetTimeOfDay()
	if (timeOfDay == "day") then			
		TppEnemy.SetSneakRoute( "sol_ExecuteUnit_0000", "rt_d_ExecuteUnit_0000" )
		TppEnemy.SetSneakRoute( "sol_ExecuteUnit_0001", "rt_d_ExecuteUnit_0001" )

		TppEnemy.SetCautionRoute( "sol_ExecuteUnit_0000", "rt_c_ExecuteUnit_0000" )
		TppEnemy.SetCautionRoute( "sol_ExecuteUnit_0001", "rt_c_ExecuteUnit_0001" )

	elseif (timeOfDay == "night") then	
		TppEnemy.SetSneakRoute( "sol_ExecuteUnit_0000", "rt_n_ExecuteUnit_0000" )
		TppEnemy.SetSneakRoute( "sol_ExecuteUnit_0001", "rt_n_ExecuteUnit_0001" )

		TppEnemy.SetCautionRoute( "sol_ExecuteUnit_0000", "rt_c_ExecuteUnit_0000" )
		TppEnemy.SetCautionRoute( "sol_ExecuteUnit_0001", "rt_c_ExecuteUnit_0001" )

	else

	end
end


this.UnSetExecuteUnitRoute = function()
	Fox.Log( "*****s10091_enemy.UnSetExecuteUnitRoute*****")

	TppEnemy.UnsetSneakRoute( "sol_ExecuteUnit_0000" )
	TppEnemy.UnsetSneakRoute( "sol_ExecuteUnit_0001" )

	TppEnemy.UnsetCautionRoute( "sol_ExecuteUnit_0000" )
	TppEnemy.UnsetCautionRoute( "sol_ExecuteUnit_0001" )

end


this.SetSwampNearRoute = function()
	Fox.Log( "*****s10091_enemy.SetSwampNearRoute*****")
	TppEnemy.InitialRouteSetGroup{
		cpName = "mafr_swamp_cp",
		soldierList = { "sol_SwampNear_0000",	"sol_SwampNear_0001" },
		groupName = "groupSwampNear",
	}

	
	TppEnemy.SetCautionRoute( "sol_SwampNear_0000", "rt_SwampNear_c_0000" )
	TppEnemy.SetCautionRoute( "sol_SwampNear_0001", "rt_SwampNear_c_0001_searchlight" )
end


this.SetWolfRouteDayTime = function()
	Fox.Log( "*****s10091_enemy.SetWolfRouteDayTime***")
	this.SetUpWolf( JACKAL_GROUP01, "rt_swamp_wolf_d_01" )
	this.SetUpWolf( JACKAL_GROUP02, "rt_swamp_wolf_d_02" )
	this.SetUpWolf( JACKAL_GROUP03, "rt_swamp_wolf_d_03" )
	this.SetUpWolf( JACKAL_GROUP04, "rt_swamp_wolf_d_04" )
	this.SetUpWolf( JACKAL_GROUP05, "rt_swamp_wolf_d_05" )
	this.SetUpWolf( JACKAL_GROUP06, "rt_swamp_wolf_d_06" )
end


this.SetWolfRouteNightTime = function()
	Fox.Log( "*****s10091_enemy.SetWolfRouteNightTime***")
	this.SetUpWolf( JACKAL_GROUP01, "rt_swamp_wolf_n_01" )
	this.SetUpWolf( JACKAL_GROUP02, "rt_swamp_wolf_n_02" )
	this.SetUpWolf( JACKAL_GROUP03, "rt_swamp_wolf_n_03" )
	this.SetUpWolf( JACKAL_GROUP04, "rt_swamp_wolf_n_04" )
	this.SetUpWolf( JACKAL_GROUP05, "rt_swamp_wolf_n_05" )
	this.SetUpWolf( JACKAL_GROUP06, "rt_swamp_wolf_n_06" )
end

this.SetAllWolfIgnoreNotice = function()
	Fox.Log( "*****s10091_enemy.SetAllWolfIgnoreNotice***")
	this.SetWolfIgnoreNotice( JACKAL_GROUP01 )
	this.SetWolfIgnoreNotice( JACKAL_GROUP02 )
	this.SetWolfIgnoreNotice( JACKAL_GROUP03 )
	this.SetWolfIgnoreNotice( JACKAL_GROUP04 )
	this.SetWolfIgnoreNotice( JACKAL_GROUP05 )
	this.SetWolfIgnoreNotice( JACKAL_GROUP06 )
end

this.SetAllWolfBackNotice = function()
	Fox.Log( "*****s10091_enemy.SetAllWolfBackNotice***")
	this.SetWolfBackNotice( JACKAL_GROUP01 )
	this.SetWolfBackNotice( JACKAL_GROUP02 )
	this.SetWolfBackNotice( JACKAL_GROUP03 )
	this.SetWolfBackNotice( JACKAL_GROUP04 )
	this.SetWolfBackNotice( JACKAL_GROUP05 )
	this.SetWolfBackNotice( JACKAL_GROUP06 )
end


this.SetAllEnemyStaffParam = function ()
	Fox.Log("#### s10091_enemy.SetAllStaffParam ####")
	TppEnemy.AssignUniqueStaffType{
		locaterName = "sol_ExecuteUnit_0000",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10091_EXECUTEUNIT_A,		
		alreadyExistParam = { staffTypeId =2, randomRangeId =4, skill ="Botanist" },
	}
	TppEnemy.AssignUniqueStaffType{
		locaterName = "sol_ExecuteUnit_0001",
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10091_EXECUTEUNIT_B,		
		alreadyExistParam = { staffTypeId =40, randomRangeId =4, skill ="TroublemakerViolence" },
	}
	TppEnemy.AssignUniqueStaffType{
		locaterName = "sol_Truck_Driver",	
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10091_TRUCK_DRIVER,			
		alreadyExistParam = { staffTypeId =48, randomRangeId =4, skill ="Moodmaker" },
	}
	TppEnemy.AssignUniqueStaffType{
		locaterName = "hos_s10091_0002",	
		uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10091_SWAMPNEAR_HOSTAGE,	
		alreadyExistParam = { staffTypeId =3, randomRangeId =6, skill ="MetamaterialEngineer" },
	}
end


this.SetUpHostageLanguage = function ()
	Fox.Log("###***SetUpLanguage_for_Hostage! ENGLISH ####")
	local gameObjectId = GameObject.GetGameObjectId( "hos_s10091_0002" )
	local setLanguage = { id = "SetLangType", langType="english" }
	local setVoiceType = { id = "SetVoiceType", voiceType = "hostage_b" }

	GameObject.SendCommand( gameObjectId, setLanguage )
	GameObject.SendCommand( gameObjectId, setVoiceType )

end



this.SetUpGoat = function ( locatorName, routeName )

	local gameObjectId = {type="TppGoat", group=0, index=0}
	local command = {
			id="SetHerdEnabledCommand",
			type="Route",
			name=locatorName, 
			instanceIndex=0,
			route=routeName 	
	}
	GameObject.SendCommand( gameObjectId, command )
	GameObject.SendCommand( gameObjectId, command )
end


this.SetUpWolf = function ( locatorName, routeName )

	local gameObjectId = {type="TppJackal", group=0, index=0}
	local command = {
			id="SetHerdEnabledCommand",
			type="Route",
			name=locatorName, 
			instanceIndex=0,
			route=routeName 	
	}
	GameObject.SendCommand( gameObjectId, command )
end


this.SetWolfRouteBasedOnTime = function()
	local timeOfDay = TppClock.GetTimeOfDay()
	if (timeOfDay == "day") then	
		this.SetWolfRouteDayTime()

	elseif (timeOfDay == "night") then	
		this.SetWolfRouteNightTime()

	else

	end
end


this.SetWolfIgnoreNotice = function( locatorName )
	local gameObjectId = {type = "TppJackal", index = GameObject.GetGameObjectId( locatorName ) }
	local command = {
	id = "SetIgnoreNotice",
		isHostage = true, 
	}
	GameObject.SendCommand(gameObjectId, command)
end


this.SetWolfBackNotice = function( locatorName )
	Fox.Log( "*****s10091_enemy.SetWolfBackNotice***")
	local gameObjectId = {type = "TppJackal", index = GameObject.GetGameObjectId( locatorName ) }
	local command = {
	id = "SetIgnoreNotice",
		isHostage = false
	}
	GameObject.SendCommand(gameObjectId, command)
end



return this
