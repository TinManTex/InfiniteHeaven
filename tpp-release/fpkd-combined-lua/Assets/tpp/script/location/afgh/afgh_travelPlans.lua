local afgh_travelPlans = {}








afgh_travelPlans.lrrpNumberDefine = Tpp.Enum{
	"afgh_villageEast_ob",
	"afgh_commWest_ob",
	"afgh_cliffSouth_ob",
	"afgh_villageWest_ob",
	"afgh_bridgeWest_ob",
	"afgh_tentEast_ob",
	"afgh_enemyNorth_ob",
	"afgh_cliffWest_ob",
	"afgh_cliffEast_ob",
	"afgh_fortWest_ob",
	"afgh_slopedEast_ob",
	"afgh_fortSouth_ob",
	"afgh_ruinsNorth_ob",
	"afgh_villageNorth_ob",
	"afgh_slopedWest_ob",
	"afgh_fieldEast_ob",
	"afgh_plantSouth_ob",		
	"afgh_waterwayEast_ob",
	"afgh_plantWest_ob",
	"afgh_fieldWest_ob",
	"afgh_remnantsNorth_ob",
	"afgh_tentNorth_ob",
	"afgh_cliffTown_cp",
	"afgh_tent_cp",
	"afgh_waterway_cp",
	"afgh_powerPlant_cp",
	"afgh_sovietBase_cp",
	"afgh_remnants_cp",
	"afgh_field_cp",
	"afgh_citadel_cp",
	"afgh_fort_cp",
	"afgh_village_cp",
	"afgh_bridge_cp",
	"afgh_commFacility_cp",
	"afgh_slopedTown_cp",
	"afgh_enemyBase_cp",
	"afgh_bridgeNorth_ob",
	"afgh_enemyEast_ob",
	"afgh_sovietSouth_ob",
}




afgh_travelPlans.cpLinkMatrix = {
	"0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0",
	"0	0	0	0	0	0	0	1	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0",
	"0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0",
	"0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0",
	"0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	1	0	0",
	"1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0",
	"0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	1	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0",
	"1	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	1",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	1	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	0	0	0	0	0	1	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"1	0	0	1	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0",
	"0	1	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	1	0	0	0	0	0	0	0	0	1	0	0	1	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0",
	"0	0	0	1	0	1	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0",
	"0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0	0	0	0",
	"0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	0	0	0",
	"0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	0	0	0	0	0	0	0	1	0	0	0	0	0	0	0	0	0	0	0	0",
}












afgh_travelPlans.reinforceTravelPlan = {
	
	
	
	afgh_field_cp = {
		"afgh_fieldEast_ob",
		"afgh_fieldWest_ob",
	},
	afgh_tent_cp = {
		"afgh_tentNorth_ob",
		"afgh_tentEast_ob",
	},
	afgh_remnants_cp = {
		"afgh_remnantsNorth_ob",
		"afgh_field_cp",
	},
	
	
	
	afgh_commFacility_cp = {
		"afgh_ruinsNorth_ob",
		"afgh_commWest_ob",
	},
	afgh_village_cp = {
		"afgh_villageWest_ob",
		"afgh_villageNorth_ob",
	},
	afgh_enemyBase_cp = {
		"afgh_villageWest_ob",
		"afgh_slopedWest_ob",
	},
	afgh_slopedTown_cp = {
		"afgh_commWest_ob",
		"afgh_villageNorth_ob",
	},
	
	
	
	afgh_cliffTown_cp = {
		"afgh_cliffEast_ob",
		"afgh_cliffWest_ob",
	},
	afgh_fort_cp = {
		"afgh_fortWest_ob",
		"afgh_fortSouth_ob",
	},
	afgh_bridge_cp = {
		"afgh_bridgeNorth_ob",
		"afgh_bridgeWest_ob",
	},
	
	
	
	afgh_powerPlant_cp = {
		"afgh_plantWest_ob",
	},
	afgh_sovietBase_cp = {
		"afgh_sovietSouth_ob",
	},
	
	
	
}

afgh_travelPlans.defaultTravelRouteGroup = {
	afgh_villageWest_ob = {
		afgh_enemyBase_cp = {
			"travel", "in_lrrpHold_S"
		},
	},
	afgh_enemyEast_ob = {
		afgh_enemyBase_cp = {
			"travel", "in_lrrpHold_N"
		},
	},
}

return afgh_travelPlans