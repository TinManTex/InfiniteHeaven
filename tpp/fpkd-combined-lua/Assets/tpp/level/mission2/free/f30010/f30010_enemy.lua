-- DOBUILD: 0
-- ORIGINALQAR: chunk2
-- PACKPATH: \Assets\tpp\pack\mission2\free\f30010\f30010.fpkd
local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}


this.cpList = {}










this.MAX_SOLDIER_STATE_COUNT = 360


this.USE_COMMON_REINFORCE_PLAN = true


this.soldierPowerSettings = {
	sol_quest_0004 = { "SNIPER" },
	sol_quest_0005 = { "SNIPER" },
	sol_quest_0006 = { "SHIELD" },
	sol_quest_0007 = { "MISSILE" },
}



this.VEHICLE_SPAWN_LIST = {
	
	{	
		id = "Spawn",
		locator = "veh_lv_0000",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0001",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0002",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0003",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0004",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0005",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0006",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0007",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0008",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0009",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0010",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0011",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	{	
		id = "Spawn",
		locator = "veh_lv_0012",	type = Vehicle.type.EASTERN_LIGHT_VEHICLE
	},
	
	{	
		id = "Spawn",
		locator = "veh_trc_0000",	type = Vehicle.type.EASTERN_TRUCK,	subType = Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION,
	},
	{	
		id = "Spawn",
		locator = "veh_trc_0001",	type = Vehicle.type.EASTERN_TRUCK,	subType = Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION,
	},
	{	
		id = "Spawn",
		locator = "veh_trc_0002",	type = Vehicle.type.EASTERN_TRUCK,	subType = Vehicle.subType.EASTERN_TRUCK_CARGO_DRUM,
	},
	{	
		id = "Spawn",
		locator = "veh_trc_0003",	type = Vehicle.type.EASTERN_TRUCK,	subType = Vehicle.subType.EASTERN_TRUCK_CARGO_DRUM,
	},
	{	
		id = "Spawn",
		locator = "veh_trc_0004",	type = Vehicle.type.EASTERN_TRUCK,	subType = Vehicle.subType.EASTERN_TRUCK_CARGO_GENERATOR,
	},
	{	
		id = "Spawn",
		locator = "veh_trc_0005",	type = Vehicle.type.EASTERN_TRUCK,	subType = Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL,
	},
}


this.vehicleDefine = { instanceCount = 2 + 6 + 13 + 1 }--NMC: Quest + Truck + Jeep + Player





this.soldierDefine = {

	
	
	
	
	afgh_field_cp = {
		"sol_field_0000",
		"sol_field_0001",
		"sol_field_0002",
		"sol_field_0003",
		"sol_field_0004",
		"sol_field_0005",
		"sol_field_0006",
		"sol_field_0007",
		"sol_field_0008",
		"sol_field_0009",
		"sol_field_0010",
		"sol_field_0011",
		nil
	},
	
	afgh_remnants_cp = {
		"sol_remnants_0000",
		"sol_remnants_0001",
		"sol_remnants_0002",
		"sol_remnants_0003",
		"sol_remnants_0004",
		"sol_remnants_0005",
		"sol_remnants_0006",
		"sol_remnants_0007",
		"sol_remnants_0008",
		"sol_remnants_0009",
		nil
	},
	
	afgh_tent_cp = {
		"sol_tent_0000",
		"sol_tent_0001",
		"sol_tent_0002",
		"sol_tent_0003",
		"sol_tent_0004",
		"sol_tent_0005",
		"sol_tent_0006",
		"sol_tent_0007",
		"sol_tent_0008",
		"sol_tent_0009",
		"sol_tent_0010",
		"sol_tent_0011",
		nil
	},
	
	
	
	
	afgh_fieldEast_ob = {
		"sol_fieldEast_0000",
		"sol_fieldEast_0001",
		"sol_fieldEast_0002",
		nil
	},
	
	afgh_fieldWest_ob = {
		"sol_fieldWest_0000",
		"sol_fieldWest_0001",
		"sol_fieldWest_0002",
		nil
	},
	
	afgh_remnantsNorth_ob = {
		"sol_remnantsNorth_0000",
		"sol_remnantsNorth_0001",
		"sol_remnantsNorth_0002",
		"sol_remnantsNorth_0003",
		nil
	},
	
	afgh_tentEast_ob = {
		"sol_tentEast_0000",
		"sol_tentEast_0001",
		"sol_tentEast_0002",
		"sol_tentEast_0003",
		nil
	},
	
	afgh_tentNorth_ob = {
		"sol_tentNorth_0000",
		"sol_tentNorth_0001",
		"sol_tentNorth_0002",
		"sol_tentNorth_0003",
		"sol_tentNorth_0004",

		nil
	},
	
	
	
	
	afgh_village_cp = {
		"sol_village_0000",
		"sol_village_0001",
		"sol_village_0002",
		"sol_village_0003",
		"sol_village_0004",
		"sol_village_0005",
		"sol_village_0006",
		"sol_village_0007",
		"sol_village_0008",
		"sol_village_0009",
		nil
	},
	
	afgh_slopedTown_cp = {
		"sol_slopedTown_0000",
		"sol_slopedTown_0001",
		"sol_slopedTown_0002",
		"sol_slopedTown_0003",
		"sol_slopedTown_0004",
		"sol_slopedTown_0005",
		"sol_slopedTown_0006",
		"sol_slopedTown_0007",
		"sol_slopedTown_0008",
		"sol_slopedTown_0009",
		"sol_slopedTown_0010",
		nil
	},
	
	afgh_commFacility_cp = {
		"sol_commFacility_0000",
		"sol_commFacility_0001",
		"sol_commFacility_0002",
		"sol_commFacility_0003",
		"sol_commFacility_0004",
		"sol_commFacility_0005",
		"sol_commFacility_0006",
		"sol_commFacility_0007",
		"sol_commFacility_0008",
		nil
	},
	
	afgh_enemyBase_cp = {
		"sol_enemyBase_0000",
		"sol_enemyBase_0001",
		"sol_enemyBase_0002",
		"sol_enemyBase_0003",
		"sol_enemyBase_0004",
		"sol_enemyBase_0005",
		"sol_enemyBase_0006",
		"sol_enemyBase_0007",
		"sol_enemyBase_0008",
		"sol_enemyBase_0009",
		"sol_enemyBase_0010",
		"sol_enemyBase_0011",
		"sol_enemyBase_0012",
		"sol_enemyBase_0013",
		nil
	},
	
	
	
	
	afgh_commWest_ob = {
		"sol_commWest_0000",
		"sol_commWest_0001",
		"sol_commWest_0002",
		"sol_commWest_0003",
		nil
	},
	
	afgh_ruinsNorth_ob = {
		"sol_ruinsNorth_0000",
		"sol_ruinsNorth_0001",
		"sol_ruinsNorth_0002",
		nil
	},
	
	afgh_slopedWest_ob = {
		"sol_slopedWest_0000",
		"sol_slopedWest_0001",
		"sol_slopedWest_0002",
		nil
	},
	
	afgh_villageEast_ob = {
		"sol_villageEast_0000",
		"sol_villageEast_0001",
		"sol_villageEast_0002",
		"sol_villageEast_0003",
		nil
	},
	
	afgh_villageNorth_ob = {
		"sol_villageNorth_0000",
		"sol_villageNorth_0001",
		"sol_villageNorth_0002",
		"sol_villageNorth_0003",
		nil
	},
	
	afgh_villageWest_ob = {
		"sol_villageWest_0000",
		"sol_villageWest_0001",
		"sol_villageWest_0002",
		nil
	},
	
	afgh_enemyEast_ob = {
		"sol_enemyEast_0000",
		"sol_enemyEast_0001",
		"sol_enemyEast_0002",
		nil
	},
	
	
	
	
	afgh_bridge_cp = {
		"sol_bridge_0000",
		"sol_bridge_0001",
		"sol_bridge_0002",
		"sol_bridge_0003",
		"sol_bridge_0004",
		"sol_bridge_0005",
		"sol_bridge_0006",
		"sol_bridge_0007",
		"sol_bridge_0008",
		"sol_bridge_0009",
		nil
	},
	
	afgh_fort_cp = {
		"sol_fort_0000",
		"sol_fort_0001",
		"sol_fort_0002",
		"sol_fort_0003",
		"sol_fort_0004",
		"sol_fort_0005",
		"sol_fort_0006",
		"sol_fort_0007",
		"sol_fort_0008",
		"sol_fort_0009",
		nil
	},
	
	afgh_cliffTown_cp = {
		"sol_cliffTown_0000",
		"sol_cliffTown_0001",
		"sol_cliffTown_0002",
		"sol_cliffTown_0003",
		"sol_cliffTown_0004",
		"sol_cliffTown_0005",
		"sol_cliffTown_0006",
		"sol_cliffTown_0007",
		"sol_cliffTown_0008",
		"sol_cliffTown_0009",
		"sol_cliffTown_0010",
		"sol_cliffTown_0011",
		"sol_cliffTown_0012",







	},
	
	
	
	
	afgh_bridgeNorth_ob = {
		"sol_bridgeNorth_0000",
		"sol_bridgeNorth_0001",
		"sol_bridgeNorth_0002",
		"sol_bridgeNorth_0003",
		nil
	},
	
	afgh_bridgeWest_ob = {
		"sol_bridgeWest_0000",
		"sol_bridgeWest_0001",
		"sol_bridgeWest_0002",
		"sol_bridgeWest_0003",
		nil
	},
	
	afgh_cliffEast_ob = {
		"sol_cliffEast_0000",
		"sol_cliffEast_0001",
		"sol_cliffEast_0002",
		"sol_cliffEast_0003",
		nil
	},
	
	afgh_cliffSouth_ob = {
		"sol_cliffSouth_0000",
		"sol_cliffSouth_0001",
		"sol_cliffSouth_0002",
		"sol_cliffSouth_0003",
		nil
	},
	
	afgh_cliffWest_ob = {
		"sol_cliffWest_0000",
		"sol_cliffWest_0001",
		"sol_cliffWest_0002",
		"sol_cliffWest_0003",
		nil
	},
	
	afgh_enemyNorth_ob = {
		"sol_enemyNorth_0000",
		"sol_enemyNorth_0001",
		"sol_enemyNorth_0002",
		"sol_enemyNorth_0003",
		nil
	},
	
	afgh_fortSouth_ob = {
		"sol_fortSouth_0000",
		"sol_fortSouth_0001",
		"sol_fortSouth_0002",
		"sol_fortSouth_0003",
		nil
	},
	
	afgh_fortWest_ob = {
		"sol_fortWest_0000",
		"sol_fortWest_0001",
		"sol_fortWest_0002",
		"sol_fortWest_0003",
		nil
	},
	
	afgh_slopedEast_ob = {
		"sol_slopedEast_0000",
		"sol_slopedEast_0001",
		"sol_slopedEast_0002",
		"sol_slopedEast_0003",
		nil
	},
	
	
	
	
	afgh_powerPlant_cp = {
		"sol_powerPlant_0000",
		"sol_powerPlant_0001",
		"sol_powerPlant_0002",
		"sol_powerPlant_0003",
		"sol_powerPlant_0004",
		"sol_powerPlant_0005",
		"sol_powerPlant_0006",
		"sol_powerPlant_0007",
		"sol_powerPlant_0008",
		"sol_powerPlant_0009",
		nil
	},
	
	afgh_sovietBase_cp = {
		"sol_sovietBase_0000",
		"sol_sovietBase_0001",
		"sol_sovietBase_0002",
		"sol_sovietBase_0003",
		"sol_sovietBase_0004",
		"sol_sovietBase_0005",
		"sol_sovietBase_0006",
		"sol_sovietBase_0007",
		"sol_sovietBase_0008",
		"sol_sovietBase_0009",
		"sol_sovietBase_0010",
		"sol_sovietBase_0011",
		"sol_sovietBase_0012",
		"sol_sovietBase_0013",
		"sol_sovietBase_0014",
		nil
	},
	
	
	
	
	afgh_plantWest_ob = {
		"sol_plantWest_0000",
		"sol_plantWest_0001",
		"sol_plantWest_0002",
		nil
	},
	
	afgh_sovietSouth_ob = {
		"sol_sovietSouth_0000",
		"sol_sovietSouth_0001",
		"sol_sovietSouth_0002",
		nil
	},
	
	afgh_waterwayEast_ob = {
		"sol_waterwayEast_0000",
		"sol_waterwayEast_0001",
		"sol_waterwayEast_0002",
		"sol_waterwayEast_0003",
		"sol_waterwayEast_0004",
		"sol_waterwayEast_0005",
		nil
	},
	
	
	
	
	afgh_citadel_cp = {
		"sol_citadel_0000",
		"sol_citadel_0001",
		"sol_citadel_0002",
		"sol_citadel_0003",
		"sol_citadel_0004",
		"sol_citadel_0005",
		"sol_citadel_0006",
		"sol_citadel_0007",
		"sol_citadel_0008",
		"sol_citadel_0009",
		"sol_citadel_0010",
		"sol_citadel_0011",
		"sol_citadel_0012",
		"sol_citadel_0013",
		"sol_citadel_0014",
		"sol_citadel_0015",
		"sol_citadel_0016",
		"sol_citadel_0017",
		"sol_citadel_0018",
		"sol_citadel_0019",
		"sol_citadel_0020",










	},
	
	
	
	
	afgh_citadelSouth_ob = {
		"sol_citadelSouth_0000",
		"sol_citadelSouth_0001",
		"sol_citadelSouth_0002",

		nil
	},
	
	
	

	afgh_01_13_lrrp = {
		"sol_01_13_0000",
		"sol_01_13_0001",
--		"sol_ih_0010",--DEBUGNOW
--		"sol_ih_0011",
		lrrpTravelPlan	= "travelArea2_01",
		lrrpVehicle		= "veh_trc_0000",
	},

	afgh_01_32_lrrp = {  
		nil
	},

	afgh_02_14_lrrp = {
		nil
	},

	afgh_02_34_lrrp = {
		nil
	},

	afgh_02_35_lrrp = {
		nil
	},

	afgh_03_08_lrrp = {--DEBUGNOW -- no go 
		nil
	},

	afgh_03_11_lrrp = {--DEBUGNOW not "travelArea2_01",   
		nil
	},

	afgh_04_32_lrrp = {--DEBUGNOW not "travelArea2_01",
		nil
	},

	afgh_04_36_lrrp = {
		"sol_04_36_0000",
		"sol_04_36_0001",
--		    "sol_ih_0012",--DEBUGNOW
--    "sol_ih_0013",
		lrrpTravelPlan	= "travelArea2_02",
		lrrpVehicle		= "veh_trc_0001",
	},

	afgh_05_11_lrrp = {--DEBUGNOW not "travelArea2_01",  
    nil
	},

	afgh_05_33_lrrp = {
		"sol_05_33_0000",
		"sol_05_33_0001",
--		        "sol_ih_0014",--DEBUGNOW
--    "sol_ih_0015",
		lrrpTravelPlan	= "travelArea2_03",
		lrrpVehicle		= "veh_trc_0002",
	},

	afgh_06_24_lrrp = {--DEBUGNOW no go
		nil
	},

	afgh_07_08_lrrp = {--DEBUGNOW no go
		nil
	},

	afgh_08_23_lrrp = {--DEBUGNOW no go
		nil
	},

	afgh_09_10_lrrp = {
		nil
	},

	afgh_09_23_lrrp = {
		nil
	},

	afgh_10_31_lrrp = {
		nil
	},

	afgh_12_31_lrrp = {
		nil
	},

	afgh_12_37_lrrp = {
		nil
	},

	afgh_13_34_lrrp = {
		nil
	},

	afgh_14_32_lrrp = {
		nil
	},

	afgh_14_35_lrrp = {
		nil
	},

	afgh_15_35_lrrp = {
		nil
	},

	afgh_15_36_lrrp = {
		nil
	},

	afgh_16_29_lrrp = {
		"sol_16_29_0000",
		"sol_16_29_0001",
--		        "sol_ih_0016",--DEBUGNOW
--    "sol_ih_0017",
		lrrpTravelPlan	= "travelArea1_01",
		lrrpVehicle		= "veh_trc_0003",
	},

	afgh_18_39_lrrp = {
		nil
	},

	afgh_19_26_lrrp = {
		"sol_19_26_0000",
		"sol_19_26_0001",
--		        "sol_ih_0018",--DEBUGNOW
--    "sol_ih_0019",
		lrrpTravelPlan	= "travelArea4_01",
		lrrpVehicle		= "veh_trc_0005",
	},

	afgh_19_39_lrrp = {
		nil
	},

	afgh_20_21_lrrp = {
		nil
	},

	afgh_20_28_lrrp = {
		nil
	},

	afgh_20_29_lrrp = {
		nil
	},

	afgh_21_24_lrrp = {
		nil
	},

	afgh_21_28_lrrp = {
		"sol_21_28_0000",
		"sol_21_28_0001",
--		        "sol_ih_0006",--DEBUGNOW
--    "sol_ih_0007",
		lrrpTravelPlan	= "travelArea1_02",
		lrrpVehicle		= "veh_trc_0004",
	},

	afgh_22_24_lrrp = {
		nil
	},

	afgh_27_39_lrrp = {
		nil
	},

	afgh_28_29_lrrp = {
		nil
	},

	afgh_33_37_lrrp = {
		nil
	},

	afgh_36_38_lrrp = {--DEBUGNOW ok
		nil
	},

	
	
	
	quest_cp = {
		"sol_quest_0000",
		"sol_quest_0001",
		"sol_quest_0002",
		"sol_quest_0003",
		"sol_quest_0004",
		"sol_quest_0005",
		"sol_quest_0006",
		"sol_quest_0007",
		nil
	},

	nil
}






this.routeSets = {

	
	
	
	
	afgh_field_cp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_remnants_cp		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_tent_cp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_fieldEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_fieldWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_remnantsNorth_ob	= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_tentEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_tentNorth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_village_cp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_slopedTown_cp		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_commFacility_cp	= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_enemyBase_cp		= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_commWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_ruinsNorth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_slopedWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_villageEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_villageNorth_ob	= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_villageWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_enemyEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_bridge_cp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_fort_cp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_cliffTown_cp		= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_bridgeNorth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_bridgeWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_cliffEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_cliffSouth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_cliffWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_enemyNorth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_fortSouth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_fortWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_slopedEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_powerPlant_cp		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_sovietBase_cp		= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_plantWest_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_sovietSouth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_waterwayEast_ob	= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_citadel_cp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_citadelSouth_ob	= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	
	
	afgh_01_13_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_01_32_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_02_14_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_02_34_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_02_35_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_03_08_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_03_11_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_04_32_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_04_36_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_05_11_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_05_33_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_06_24_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_07_08_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_08_23_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_09_10_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_09_23_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_10_31_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_12_31_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_12_37_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_13_34_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_14_32_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_14_35_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_15_35_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_15_36_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_16_29_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_18_39_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_19_26_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_19_39_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_20_21_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_20_29_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_20_28_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_21_24_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_21_28_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_22_24_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_27_39_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_28_29_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_33_37_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	afgh_36_38_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},

	
	
	
	quest_cp				= { USE_COMMON_ROUTE_SETS = true, },

	nil
}





this.DisableRouteExcludeChatTable = {
	"rt_ruinsNorth_d_0000",
	"rt_ruinsNorth_d_0001",
	"rt_ruinsNorth_d_0002",
}






this.lrrpHoldTime = 15

this.travelPlans = {

	

	
	travelArea1_01 = {
		{ cp="afgh_16_29_lrrp", 		routeGroup={ "travel", "lrrp_29to16" }, },
		{ cp="afgh_fieldEast_ob", 		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_fieldEast_ob",	 	routeGroup={ "travel", 					"out_lrrpHold_B01" }, },
		{ cp="afgh_fieldEast_ob",	 	routeGroup={ "travel", 					"out_lrrpHold_B02" }, },
		{ cp="afgh_fieldEast_ob",	 	routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_16_29_lrrp", 		routeGroup={ "travel", "lrrp_16to29" }, },
		{ cp="afgh_field_cp",			routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_field_cp",			routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_field_cp",			routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_20_29_lrrp", 		routeGroup={ "travel", "lrrp_29to20" }, },
		{ cp="afgh_fieldWest_ob", 		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_fieldWest_ob",	 	routeGroup={ "travel", 					"out_lrrpHold_B01" }, },
		{ cp="afgh_fieldWest_ob",	 	routeGroup={ "travel", 					"out_lrrpHold_B02" }, },
		{ cp="afgh_fieldWest_ob",	 	routeGroup={ "travel", 					"out_lrrpHold_B03" }, },
		{ cp="afgh_20_29_lrrp", 		routeGroup={ "travel", "lrrp_20to29" }, },
		{ cp="afgh_field_cp",			routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_field_cp",			routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_field_cp",			routeGroup={ "travel", 					"out_lrrpHold_E" }, },
	},

	travelArea1_02 = {
		{ cp="afgh_21_28_lrrp", 		routeGroup={ "travel", "lrrp_28to21" }, },
		{ cp="afgh_remnantsNorth_ob",	routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_remnantsNorth_ob",	routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_21_24_lrrp", 		routeGroup={ "travel", "lrrp_21to24" }, },
		{ cp="afgh_tent_cp",			routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_tent_cp",			routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_tent_cp",			routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_21_24_lrrp", 		routeGroup={ "travel", "lrrp_24to21" }, },
		{ cp="afgh_remnantsNorth_ob",	routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_remnantsNorth_ob",	routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_21_28_lrrp", 		routeGroup={ "travel", "lrrp_21to28" }, },
		{ cp="afgh_remnants_cp",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_remnants_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_remnants_cp",		routeGroup={ "travel", 					"out_lrrpHold_B01" }, },
		{ cp="afgh_remnants_cp",		routeGroup={ "travel", 					"out_lrrpHold_B02" }, },
		{ cp="afgh_remnants_cp",		routeGroup={ "travel", 					"out_lrrpHold_B03" }, },
	},

	
	
	travelArea2_01 = {
		{ cp="afgh_01_13_lrrp", 		routeGroup={ "travel", "lrrp_13to01" }, },
		{ cp="afgh_villageEast_ob", 	routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_villageEast_ob", 	routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_01_32_lrrp", 		routeGroup={ "travel", "lrrp_01to32" }, },
		{ cp="afgh_village_cp", 		routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_village_cp", 		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_village_cp", 		routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_14_32_lrrp", 		routeGroup={ "travel", "lrrp_32to14" }, },
		{ cp="afgh_villageNorth_ob",	routeGroup={ "travel", 					"in_lrrpHold_S_E" }, },
		{ cp="afgh_villageNorth_ob",	routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_02_14_lrrp",			routeGroup={ "travel", "lrrp_14to02" }, },
		{ cp="afgh_commWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_S_E" }, },
		{ cp="afgh_commWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_02_34_lrrp",			routeGroup={ "travel", "lrrp_02to34" }, },
		{ cp="afgh_commFacility_cp",	routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_commFacility_cp",	routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_commFacility_cp",	routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_13_34_lrrp",			routeGroup={ "travel", "lrrp_34to13" }, },
		{ cp="afgh_ruinsNorth_ob",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_ruinsNorth_ob",		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
	},

	
	travelArea2_02 = {
		{ cp="afgh_04_36_lrrp", 		routeGroup={ "travel", "lrrp_36to04" }, },
		{ cp="afgh_villageWest_ob", 	routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_villageWest_ob", 	routeGroup={ "travel", 					"out_lrrpHold_B" }, },
		{ cp="afgh_villageWest_ob", 	routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_04_36_lrrp", 		routeGroup={ "travel", "lrrp_04to36" }, },
		{ cp="afgh_enemyBase_cp",		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_enemyBase_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_enemyBase_cp",		routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_15_36_lrrp",			routeGroup={ "travel", "lrrp_36to15" }, },
		{ cp="afgh_slopedWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_slopedWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_15_35_lrrp",			routeGroup={ "travel", "lrrp_15to35" }, },
		{ cp="afgh_slopedTown_cp",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_slopedTown_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_slopedTown_cp",		routeGroup={ "travel", 					"out_lrrpHold_B01" }, },
		{ cp="afgh_slopedTown_cp",		routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_15_35_lrrp",			routeGroup={ "travel", "lrrp_35to15" }, },
		{ cp="afgh_slopedWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_slopedWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_W" }, },
		{ cp="afgh_15_36_lrrp",			routeGroup={ "travel", "lrrp_15to36" }, },
		{ cp="afgh_enemyBase_cp",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_enemyBase_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_enemyBase_cp",		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
	},
	

	
	travelArea2_03 = {
		{ cp="afgh_05_33_lrrp", 		routeGroup={ "travel", "lrrp_33to05" }, },
		{ cp="afgh_bridgeWest_ob", 		routeGroup={ "travel",					"in_lrrpHold_N" }, },
		{ cp="afgh_bridgeWest_ob", 		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_05_11_lrrp", 		routeGroup={ "travel", "lrrp_05to11" }, },
		{ cp="afgh_slopedEast_ob",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_slopedEast_ob",		routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_03_11_lrrp", 		routeGroup={ "travel", "lrrp_11to03" }, },
		{ cp="afgh_cliffSouth_ob",		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_cliffSouth_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_03_08_lrrp", 		routeGroup={ "travel", "lrrp_03to08" }, },
		{ cp="afgh_cliffWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_cliffWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_08_23_lrrp", 		routeGroup={ "travel", "lrrp_08to23" }, },
		{ cp="afgh_cliffTown_cp",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_cliffTown_cp",		routeGroup={ "travel", "lrrpHold_01" }, },
		{ cp="afgh_cliffTown_cp",		routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_09_23_lrrp", 		routeGroup={ "travel", "lrrp_23to09" }, },
		{ cp="afgh_cliffEast_ob",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_cliffEast_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_09_10_lrrp", 		routeGroup={ "travel", "lrrp_09to10" }, },
		{ cp="afgh_fortWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_fortWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_10_31_lrrp", 		routeGroup={ "travel", "lrrp_10to31" }, },
		{ cp="afgh_fort_cp",			routeGroup={ "travel", 					"in_lrrpHold_W" }, },
		{ cp="afgh_fort_cp",			routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_12_31_lrrp", 		routeGroup={ "travel", "lrrp_31to12" }, },
		{ cp="afgh_fortSouth_ob",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_fortSouth_ob",		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_12_37_lrrp", 		routeGroup={ "travel", "lrrp_12to37" }, },
		{ cp="afgh_bridgeNorth_ob",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_bridgeNorth_ob",		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_33_37_lrrp", 		routeGroup={ "travel", "lrrp_37to33" }, },
		{ cp="afgh_bridge_cp",			routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_bridge_cp",			routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_bridge_cp",			routeGroup={ "travel", 					"out_lrrpHold_S" }, },
	},
	

	
	travelArea4_01 = {
		{ cp="afgh_19_26_lrrp", 		routeGroup={ "travel", "lrrp_26to19" }, },
		{ cp="afgh_plantWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_plantWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_19_39_lrrp", 		routeGroup={ "travel", "lrrp_19to39" }, },
		{ cp="afgh_sovietSouth_ob",		routeGroup={ "travel", 					"in_lrrpHold_N" }, },
		{ cp="afgh_sovietSouth_ob",		routeGroup={ "travel", 					"out_lrrpHold_E" }, },
		{ cp="afgh_27_39_lrrp", 		routeGroup={ "travel", "lrrp_39to27" }, },
		{ cp="afgh_sovietBase_cp",		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_sovietBase_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_sovietBase_cp",		routeGroup={ "travel", 					"out_lrrpHold_S" }, },
		{ cp="afgh_27_39_lrrp", 		routeGroup={ "travel", "lrrp_27to39" }, },
		{ cp="afgh_sovietSouth_ob",		routeGroup={ "travel", 					"in_lrrpHold_E" }, },
		{ cp="afgh_sovietSouth_ob",		routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_19_39_lrrp", 		routeGroup={ "travel", "lrrp_39to19" }, },
		{ cp="afgh_plantWest_ob",		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_plantWest_ob",		routeGroup={ "travel", 					"out_lrrpHold_N" }, },
		{ cp="afgh_19_26_lrrp", 		routeGroup={ "travel", "lrrp_19to26" }, },
		{ cp="afgh_powerPlant_cp",		routeGroup={ "travel", 					"in_lrrpHold_S" }, },
		{ cp="afgh_powerPlant_cp",		routeGroup={ "travel", "lrrpHold" }, },
		{ cp="afgh_powerPlant_cp",		routeGroup={ "travel", 					"out_lrrpHold_B01" }, },
		{ cp="afgh_powerPlant_cp",		routeGroup={ "travel", 					"out_lrrpHold_B02" }, },
		{ cp="afgh_powerPlant_cp",		routeGroup={ "travel", 					"out_lrrpHold_B03" }, },
	},

  --tex generic(common route set or whatev) travelplans from missions>
  --10020
--  travelCommFacility01 = {
--    { cp="afgh_02_34_lrrp",     routeGroup={ "travel", "lrrp_02to34" } }, 
--    { cp="afgh_commFacility_cp",  routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_13_34_lrrp",     routeGroup={ "travel", "lrrp_34to13" } }, 
--    { cp="afgh_ruinsNorth_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_13_34_lrrp",     routeGroup={ "travel", "lrrp_13to34" } }, 
--    { cp="afgh_commFacility_cp",  routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_02_34_lrrp",     routeGroup={ "travel", "lrrp_34to02" } }, 
--    { cp="afgh_commWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--  },
--  
--  travelSlopedTown01 = {
--    { cp="afgh_14_35_lrrp",     routeGroup={ "travel", "lrrp_35to14" } }, 
--    { cp="afgh_villageNorth_ob",  routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_14_32_lrrp",     routeGroup={ "travel", "lrrp_14to32" } }, 
--    { cp="afgh_village_cp",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_14_32_lrrp",     routeGroup={ "travel", "lrrp_32to14" } }, 
--    { cp="afgh_villageNorth_ob",  routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_14_35_lrrp",     routeGroup={ "travel", "lrrp_14to35" } }, 
--    { cp="afgh_slopedTown_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--  },
----  
--  travelSlopedTown02 = {
--    { cp="afgh_02_14_lrrp",     routeGroup={ "travel", "lrrp_14to02" } }, 
--    { cp="afgh_commWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_02_35_lrrp",     routeGroup={ "travel", "lrrp_02to35" } }, 
--    { cp="afgh_slopedTown_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_02_35_lrrp",     routeGroup={ "travel", "lrrp_35to02" } }, 
--    { cp="afgh_commWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_02_14_lrrp",     routeGroup={ "travel", "lrrp_02to14" } }, 
--    { cp="afgh_villageNorth_ob",  routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--  },
--  
  travelEnemyBase01_10020 = {
    { cp="afgh_15_36_lrrp",     routeGroup={ "travel", "lrrp_36to15" } }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_15_35_lrrp",     routeGroup={ "travel", "lrrp_15to35" } }, 
    { cp="afgh_slopedTown_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_15_35_lrrp",     routeGroup={ "travel", "lrrp_35to15" } }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_15_36_lrrp",     routeGroup={ "travel", "lrrp_15to36" } }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
  },
  
  ---10033
--  travelEnemyBase01_10033 = {
--    { base = "afgh_villageWest_ob"},
--    { base = "afgh_enemyBase_cp"},
--    { base = "afgh_enemyEast_ob"},
--    { base = "afgh_enemyBase_cp"},
--  },
--
--  
--  travelEnemyBase02_10033 = {
--    { base = "afgh_enemyEast_ob"},
--    { base = "afgh_enemyBase_cp"},
--    { base = "afgh_tentEast_ob"},
--    { base = "afgh_enemyBase_cp"},
--  },
--
  travelEnemyBase03_10033 = {
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "out_lrrpHold_W" } },  
    { cp="afgh_15_36_lrrp",     routeGroup={ "travel", "lrrp_15to36" } }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "in_lrrpHold_N" } }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "out_lrrpHold_S" } },  
    { cp="afgh_04_36_lrrp",     routeGroup={ "travel", "lrrp_36to04" } }, 
    { cp="afgh_villageWest_ob",   routeGroup={ "travel", "in_lrrpHold_W" } }, 
    { cp="afgh_villageWest_ob",   routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_villageWest_ob",   routeGroup={ "travel", "out_lrrpHold_E" } },  
    { cp="afgh_04_32_lrrp",     routeGroup={ "travel", "lrrp_04to32" } }, 
    { cp="afgh_04_32_lrrp",     routeGroup={ "travel", "lrrp_32to04" } }, 
    { cp="afgh_villageWest_ob",   routeGroup={ "travel", "in_lrrpHold_E" } }, 
    { cp="afgh_villageWest_ob",   routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_villageWest_ob",   routeGroup={ "travel", "out_lrrpHold_W" } },  
    { cp="afgh_04_36_lrrp",     routeGroup={ "travel", "lrrp_04to36" } }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "in_lrrpHold_S" } }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_enemyBase_cp",     routeGroup={ "travel", "out_lrrpHold_N" } },  
    { cp="afgh_15_36_lrrp",     routeGroup={ "travel", "lrrp_36to15" } }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "in_lrrpHold_W" } }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "out_lrrpHold_E" } },  
    { cp="afgh_15_35_lrrp",     routeGroup={ "travel", "lrrp_15to35" } }, 
    { cp="afgh_slopedTown_cp",    routeGroup={ "travel", "in_lrrpHold_W" } }, 
    { cp="afgh_slopedTown_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_slopedTown_cp",    routeGroup={ "travel", "out_lrrpHold_W" } },  
    { cp="afgh_15_35_lrrp",     routeGroup={ "travel", "lrrp_35to15" } }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "in_lrrpHold_E" } }, 
    { cp="afgh_slopedWest_ob",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
  },
  
 --10036
--  travelField = {
--    { base = "afgh_fieldEast_ob" },
--    { base = "afgh_field_cp" },
--    { base = "afgh_fieldWest_ob" },
--    { base = "afgh_field_cp" },
--  },
  
  --10040
--  travel_mount = {
--    { base="afgh_fortSouth_ob", },
--    { base="afgh_bridgeNorth_ob", },
--  },
--  travel_cliff = {
--    { base = "afgh_bridgeWest_ob"},
--    { base = "afgh_slopedEast_ob"},
--  },
--
--  --10041
--  lrrp_villageNorth_to_slopedTown = {
--    { base = "afgh_commWest_ob",    },
--    { base = "afgh_slopedTown_cp",    },
--    { base = "afgh_commWest_ob",    },
--    { base = "afgh_villageNorth_ob",  },
--  },
--  lrrp_enemyBase_to_villageNotrh = {
--    { base = "afgh_slopedWest_ob",    },
--    { base = "afgh_slopedTown_cp",    },
--    { base = "afgh_villageNorth_ob",  },
--    { base = "afgh_slopedTown_cp",    },
--    { base = "afgh_slopedWest_ob",    },
--    { base = "afgh_enemyBase_cp",   },
--
--  },
--  lrrp_field_to_remnantsNotrh = {
--    { base = "afgh_remnantsNorth_ob",   },
--    { base = "afgh_fieldWest_ob",   },
--    { base = "afgh_field_cp",   },
--    { base = "afgh_fieldWest_ob",   },
--  },
--
--  --10043
  travelCommFacility = {
    { cp = "afgh_commFacility_cp",    routeGroup = { "travel",          "in_lrrpHold_E" }, },
    { cp = "afgh_commFacility_cp",    routeGroup = { "travel", "lrrpHold" }   },
    { cp = "afgh_commFacility_cp",    routeGroup = { "travel",          "out_lrrpHold_W" }, },
    { cp = "afgh_02_34_lrrp",       routeGroup = { "travel", "lrrp_34to02" }  },
    { cp = "afgh_commWest_ob",      routeGroup = { "travel", "lrrpHold" }   },
    { cp = "afgh_02_34_lrrp",       routeGroup = { "travel", "lrrp_02to34" }  },
    { cp = "afgh_commFacility_cp",    routeGroup = { "travel",          "in_lrrpHold_W" }, },
    { cp = "afgh_commFacility_cp",    routeGroup = { "travel", "lrrpHold" }   },
    { cp = "afgh_commFacility_cp",    routeGroup = { "travel",          "out_lrrpHold_E" }, },
    { cp = "afgh_13_34_lrrp",       routeGroup = { "travel", "lrrp_34to13" }  },
    { cp = "afgh_ruinsNorth_ob",    routeGroup = { "travel", "lrrpHold" }   },
    { cp = "afgh_13_34_lrrp",       routeGroup = { "travel", "lrrp_13to34" }  },
  },
  
  travelVehicle_= {
    { cp="afgh_13_34_lrrp",       routeGroup={ "travel", "lrrp_34to13" }, },
    { cp="afgh_ruinsNorth_ob",      routeGroup={ "travel",          "in_lrrpHold_N" }, },
    { cp="afgh_ruinsNorth_ob",      routeGroup={ "travel",          "out_lrrpHold_S" }, },
    { cp="afgh_01_13_lrrp",       routeGroup={ "travel", "lrrp_13to01" }, },
    { cp="afgh_villageEast_ob",     routeGroup={ "travel",          "in_lrrpHold_E" }, },
    { cp="afgh_villageEast_ob",     routeGroup={ "travel",          "out_lrrpHold_W" }, },
    { cp="afgh_01_32_lrrp",       routeGroup={ "travel", "lrrp_01to32" }, },
    { cp="afgh_village_cp",       routeGroup={ "travel",          "in_lrrpHold_E" }, },
    { cp="afgh_village_cp",       routeGroup={ "travel", "lrrpHold" }, },
    { cp="afgh_village_cp",       routeGroup={ "travel",          "out_lrrpHold_W" }, },
    { cp="afgh_14_32_lrrp",       routeGroup={ "travel", "lrrp_32to14" }, },
    { cp="afgh_villageNorth_ob",    routeGroup={ "travel",          "in_lrrpHold_S_E" }, },
    { cp="afgh_villageNorth_ob",    routeGroup={ "travel",          "out_lrrpHold_E" }, },
    { cp="afgh_02_14_lrrp",       routeGroup={ "travel", "lrrp_14to02" }, },
    { cp="afgh_commWest_ob",      routeGroup={ "travel",          "in_lrrpHold_S_E" }, },
    { cp="afgh_commWest_ob",      routeGroup={ "travel",          "out_lrrpHold_E" }, },
    { cp="afgh_02_34_lrrp",       routeGroup={ "travel", "lrrp_02to34" }, },
    { cp="afgh_commFacility_cp",    routeGroup={ "travel",          "in_lrrpHold_W" }, },
    { cp="afgh_commFacility_cp",    routeGroup={ "travel", "lrrpHold" }, },
    { cp="afgh_commFacility_cp",    routeGroup={ "travel",          "out_lrrpHold_E" }, },
  },
--  
--  travelvillageEast = {
--    { base = "afgh_villageEast_ob", },
--    { base = "afgh_village_cp", },
--    { base = "afgh_villageNorth_ob", },
--    { base = "afgh_commWest_ob", },
--    { base = "afgh_villageNorth_ob", },
--    { base = "afgh_village_cp", },
--  },
----  
----  
--  travelcommWest = {
--    { base = "afgh_commWest_ob", },
--    { base = "afgh_villageNorth_ob", },
--    { base = "afgh_village_cp", },
--    { base = "afgh_villageEast_ob", },
--    { base = "afgh_village_cp", },
--    { base = "afgh_villageNorth_ob", },
--  },
--
--  --10045
--  travelfieldWest = {
--    { base = "afgh_fieldWest_ob", },
--    { base = "afgh_field_cp", },
--  },
--  
--  --10070
--  travel_powerPlant = {
--    { cp="afgh_19_26_lrrp",     routeGroup={ "travel", "lrrp_26to19" } }, 
--    { cp="afgh_plantWest_ob",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_19_39_lrrp",     routeGroup={ "travel", "lrrp_19to39" } }, 
--    { cp="afgh_sovietSouth_ob",   routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_27_39_lrrp",     routeGroup={ "travel", "lrrp_39to27" } }, 
--    { cp="afgh_sovietBase_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_27_39_lrrp",     routeGroup={ "travel", "lrrp_27to39" } }, 
--    { cp="afgh_sovietSouth_ob",   routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_19_39_lrrp",     routeGroup={ "travel", "lrrp_39to19" } }, 
--    { cp="afgh_plantWest_ob",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--    { cp="afgh_19_26_lrrp",     routeGroup={ "travel", "lrrp_19to26" } }, 
--    { cp="afgh_powerPlant_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
--  },
--
  travel_sovietBase = {  
    { cp="afgh_27_39_lrrp",     routeGroup={ "travel", "lrrp_27to39" } }, 
    { cp="afgh_sovietSouth_ob",   routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_19_39_lrrp",     routeGroup={ "travel", "lrrp_39to19" } }, 
    { cp="afgh_plantWest_ob",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_19_26_lrrp",     routeGroup={ "travel", "lrrp_19to26" } }, 
    { cp="afgh_powerPlant_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_19_26_lrrp",     routeGroup={ "travel", "lrrp_26to19" } }, 
    { cp="afgh_plantWest_ob",     routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_19_39_lrrp",     routeGroup={ "travel", "lrrp_19to39" } }, 
    { cp="afgh_sovietSouth_ob",   routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
    { cp="afgh_27_39_lrrp",     routeGroup={ "travel", "lrrp_39to27" } }, 
    { cp="afgh_sovietBase_cp",    routeGroup={ "travel", "lrrpHold" },wait=this.lrrpHoldTime }, 
  }, 
  
  --<
}






this.combatSetting = {

	
	
	
	
	afgh_field_cp			= { USE_COMMON_COMBAT = true,	},
	
	afgh_remnants_cp		= { USE_COMMON_COMBAT = true,	},
	
	afgh_tent_cp			= { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_fieldEast_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_fieldWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_remnantsNorth_ob	= { USE_COMMON_COMBAT = true,	},
	
	afgh_tentEast_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_tentNorth_ob		= { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_village_cp			= { USE_COMMON_COMBAT = true,	},
	
	afgh_slopedTown_cp		= { USE_COMMON_COMBAT = true,	},
	
	afgh_commFacility_cp	= { USE_COMMON_COMBAT = true,	},
	
	afgh_enemyBase_cp		= { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_commWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_ruinsNorth_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_slopedWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_villageEast_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_villageNorth_ob	= { USE_COMMON_COMBAT = true,	},
	
	afgh_villageWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_enemyEast_ob		= { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_bridge_cp			= { USE_COMMON_COMBAT = true,	},
	
	afgh_fort_cp			= { USE_COMMON_COMBAT = true,	},
	
	afgh_cliffTown_cp		= { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_bridgeNorth_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_bridgeWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_cliffEast_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_cliffSouth_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_cliffWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_enemyNorth_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_fortSouth_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_fortWest_ob		= { USE_COMMON_COMBAT = true,	},
	
	afgh_slopedEast_ob		= { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_powerPlant_cp		 = { USE_COMMON_COMBAT = true,	},
	
	afgh_sovietBase_cp		 = { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_plantWest_ob		 = { USE_COMMON_COMBAT = true,	},
	
	afgh_sovietSouth_ob		 = { USE_COMMON_COMBAT = true,	},
	
	afgh_waterwayEast_ob	 = { USE_COMMON_COMBAT = true,	},
	
	
	
	
	afgh_citadel_cp			 = { USE_COMMON_COMBAT = true,	},
	
	afgh_citadelSouth_ob	 = { USE_COMMON_COMBAT = true,	},

	nil
}




this.useGeneInter = {
	
	

	













































	nil
}


this.interrogation = {

	
	afgh_field_cp = {nil},
	afgh_remnants_cp = {nil},
	afgh_tent_cp = {nil},
	
	afgh_fieldEast_ob = {nil},
	afgh_fieldWest_ob = {nil},
	afgh_remnantsNorth_ob = {nil},
	afgh_tentEast_ob = {nil},
	
	afgh_village_cp = {nil},
	afgh_slopedTown_cp = {nil},
	afgh_commFacility_cp = {nil},
	afgh_enemyBase_cp = {nil},
	
	afgh_commWest_ob = {nil},
	afgh_villageEast_ob = {nil},
	afgh_villageNorth_ob = {nil},
	afgh_villageWest_ob = {nil},
	afgh_ruinsNorth_ob = {nil},
	afgh_slopedWest_ob = {nil},
	afgh_enemyEast_ob = {nil},

	
	afgh_bridge_cp = {nil},
	afgh_fort_cp = {nil},
	afgh_cliffTown_cp = {nil},
	
	afgh_bridgeNorth_ob = {nil},
	afgh_bridgeWest_ob = {nil},
	afgh_cliffEast_ob = {nil},
	afgh_cliffSouth_ob = {nil},
	afgh_cliffWest_ob = {nil},
	afgh_enemyNorth_ob = {nil},
	afgh_fortSouth_ob = {nil},
	afgh_fortWest_ob = {nil},
	afgh_slopedEast_ob = {nil},
	
	afgh_powerPlant_cp = {nil},
	afgh_sovietBase_cp = {nil},
	
	afgh_plantWest_ob = {nil},
	afgh_sovietSouth_ob = {nil},
	afgh_waterwayEast_ob = {nil},
	
	afgh_citadel_cp = {nil},
	afgh_citadelSouth_ob = {nil},
	nil
}




function this.Messages()
	return
	StrCode32Table {
		Trap = {
			{
				msg = "Enter",	sender = "trap_FreePlay_area01",
				func = function()
					Fox.Log("### trap_FreePlay_area01 Enter ###")
					f30010_enemy.UpdateOutOfAreaSetting( 1 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area02",
				func = function()
					Fox.Log("### trap_FreePlay_area02 Enter ###")
					f30010_enemy.UpdateOutOfAreaSetting( 2 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area03",
				func = function()
					Fox.Log("### trap_FreePlay_area03 Enter ###")
					f30010_enemy.UpdateOutOfAreaSetting( 3 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area04",
				func = function()
					Fox.Log("### trap_FreePlay_area04 Enter ###")
					f30010_enemy.UpdateOutOfAreaSetting( 4 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area05",
				func = function()
					Fox.Log("### trap_FreePlay_area05 Enter ###")
					f30010_enemy.UpdateOutOfAreaSetting( 5 )
				end,
				option = { isExecMissionPrepare = true }
			},
			nil
		},
	}
end





this.SpawnVehicleOnInitialize = function()
	TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
end


this.InitEnemy = function ()
	Fox.Log("*** f30010 InitEnemy ***")
end



this.SetUpEnemy = function ()

	Fox.Log("*** f30010 SetUpEnemy ***")
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	local cpList = {
		afgh_cpGroups.group_Area1,
		afgh_cpGroups.group_Area2,
		afgh_cpGroups.group_Area3,
		afgh_cpGroups.group_Area4,
		afgh_cpGroups.group_Area5,
	}
	this.cpList = cpList

	


	
	this.RouteExcludeChat( false, this.DisableRouteExcludeChatTable )

	
	TppEnemy.SetupQuestEnemy()

end


this.OnLoad = function ()
	Fox.Log("*** f30010 OnLoad ***")
end





function this.UpdateOutOfAreaSetting( currentArea )
	Fox.Log("*** f30010 UpdateOutOfAreaSetting:currentArea::" .. currentArea )
	
	local currentCpList = this.cpList[ currentArea ]
	
	for cpName, soldiersInCp in pairs( this.soldierDefine ) do
		if currentCpList[cpName] or cpName == "quest_cp" then	
			TppEnemy.SetOutOfArea( soldiersInCp, false )
		else
			TppEnemy.SetOutOfArea( soldiersInCp, true )
		end
	end
end


function this.RouteExcludeChat( enabled, routeTable )
	local gameObjectId	 = { type = "TppCommandPost2", index=0 }
	local command		 = { id = "SetRouteExcludeChat", routes = routeTable, enabled = enabled }
	GameObject.SendCommand( gameObjectId, command )
end




return this
