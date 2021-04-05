local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}




this.USE_COMMON_REINFORCE_PLAN = true





local spawnList_normal = {
        { id="Spawn", locator="veh_s10054_0000", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, class = Vehicle.class.DEFAULT, },	
        { id="Spawn", locator="veh_s10054_0002", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, class = Vehicle.class.DEFAULT, },	
        { id="Spawn", locator="veh_s10054_0003", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, class = Vehicle.class.DEFAULT, },	
        { id="Spawn", locator="veh_s10054_0009", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL, },	
}
local despawnList_normal = {
		{ id="Despawn", locator="veh_s10054_0001", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION, },	
        { id="Despawn", locator="veh_s10054_0004", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0005", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0007", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0008", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0010", type = Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0011", type = Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0012", type = Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DEFAULT, },	
		{ id="Despawn", locator="veh_s10054_0006", type = Vehicle.type.EASTERN_LIGHT_VEHICLE, },	
}

local spawnList_hard = {
        { id="Spawn", locator="veh_s10054_0000", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, class = Vehicle.class.DEFAULT, },	
        { id="Spawn", locator="veh_s10054_0002", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, class = Vehicle.class.DARK_GRAY, },	
        { id="Spawn", locator="veh_s10054_0003", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, class = Vehicle.class.OXIDE_RED, },	
        { id="Spawn", locator="veh_s10054_0009", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL, },	
}
local despawnList_hard = {
		{ id="Despawn", locator="veh_s10054_0001", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION, },	
        { id="Despawn", locator="veh_s10054_0004", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DARK_GRAY, },	
		{ id="Despawn", locator="veh_s10054_0005", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DARK_GRAY, },	
		{ id="Despawn", locator="veh_s10054_0007", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.DARK_GRAY, },	
		{ id="Despawn", locator="veh_s10054_0008", type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE , subType = Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY, class = Vehicle.class.OXIDE_RED, },	
		{ id="Despawn", locator="veh_s10054_0010", type = Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DARK_GRAY, },	
		{ id="Despawn", locator="veh_s10054_0011", type = Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.DARK_GRAY, },	
		{ id="Despawn", locator="veh_s10054_0012", type = Vehicle.type.EASTERN_TRACKED_TANK, class = Vehicle.class.OXIDE_RED, },	
		{ id="Despawn", locator="veh_s10054_0006", type = Vehicle.type.EASTERN_LIGHT_VEHICLE, },	
}

this.vehicleDefine = {
        instanceCount   = #spawnList_normal + #despawnList_normal,
}

this.SpawnVehicleOnInitialize = function()
	local missionName = TppMission.GetMissionName()

	if missionName == "s10054"	then
        TppEnemy.SpawnVehicles( spawnList_normal )
        TppEnemy.DespawnVehicles( despawnList_normal ) 
    elseif	missionName == "s11054"	then
        TppEnemy.SpawnVehicles( spawnList_hard )
        TppEnemy.DespawnVehicles( despawnList_hard ) 
	else
        TppEnemy.SpawnVehicles( spawnList_normal )
        TppEnemy.DespawnVehicles( despawnList_normal ) 
	end
end





this.soldierDefine = {
	
	s10054_searchEnemy_cp = {	
		"sol_search_0000",
		"sol_search_0001",
		"sol_search_0002",
		"sol_search_0003",
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
		"sol_s10054_0005",
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
		"sol_enemyBase_0014",
		"sol_enemyBase_0015",
		"sol_enemyBase_0016",
		"sol_enemyBase_0017",
		"sol_s10054_0000",		
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
		"sol_s10054_0002",
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
		nil
	},
	afgh_enemyEast_ob = {	
		"sol_enemyEast_0000",
		"sol_enemyEast_0001",
		"sol_enemyEast_0002",
		"sol_enemyEast_0003",
		nil
	},
	afgh_villageWest_ob = {	
		"sol_villageWest_0000",
		"sol_villageWest_0001",
		"sol_villageWest_0002",
		"sol_villageWest_0003",
		nil
	},
	afgh_remnantsNorth_ob = {	
		"sol_remnantsNorth_0000",
		"sol_remnantsNorth_0001",
		"sol_remnantsNorth_0002",
		"sol_remnantsNorth_0003",
		nil
	},
	
	
	
	afgh_04_32_lrrp		= { "sol_s10054_0004", nil },	
	afgh_04_36_lrrp		= { nil },	
	afgh_06_24_lrrp		= { nil },	
	afgh_06_36_lrrp		= { nil },	
	afgh_15_36_lrrp		= { nil },	
	afgh_20_21_lrrp		= { "sol_s10054_0003", nil },	
	afgh_21_24_lrrp		= { nil },	
	afgh_21_28_lrrp		= { nil },	
	afgh_22_24_lrrp		= { nil },	
	afgh_28_29_lrrp		= { "sol_s10054_0006", "sol_s10054_0007","sol_s10054_0009", nil },	
	afgh_36_38_lrrp		= { nil },	
	s10054_areaOut_cp	= { "sol_s10054_0001","sol_s10054_0008","sol_s10054_0011","sol_s10054_0012",nil },
	s10054_areaOut02_cp	= { "sol_s10054_0010", nil },
	nil
}





this.routeSets = {
	s10054_searchEnemy_cp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
			},
		},
		sneak_night= {
			groupA = {
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
			},
		},
		caution = {
			groupA = {
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
				"rts_searchRoute_0000",
			},
		},
		hold = {
			default = {},
		},
		nil
	},
	afgh_tent_cp = {
	
		priority = {
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		sneak_day = {
			groupA = {
				"rt_tent_d_0012",
				"rt_tent_d_0000",
			},
			groupB = {
				"rt_tent_d_0004",
				"rt_tent_d_0005",
			},
			groupC = {
				"rt_tent_d_0014",
				"rt_tent_d_0015",
			},
			groupD = {
				"rt_tent_d_0008",
				"rt_tent_d_0006",
			},
			groupE = {
				"rt_tent_d_0019",
				"rt_tent_d_0001",
			},
		},
		sneak_night= {
			groupA = {
				"rt_tent_n_0005",
				"rt_tent_n_0001",
			},
			groupB = {
				"rt_tent_n_0017",
				"rt_tent_n_0012",
			},
			groupC = {
				"rt_tent_n_0008",
				"rt_tent_n_0018",
			},
			groupD = {
				"rt_tent_n_0019",
				"rt_tent_n_0018",
			},
			groupE = {
				"rt_tent_n_0006",
				"rt_tent_n_0014",
			},
		},
		caution = {
			groupA = {
				"rt_tent_c_0005",
				"rt_tent_c_0008",
				"rt_tent_c_0010",
				"rt_tent_c_0011",
				"rt_tent_c_0006",
				"rt_tent_c_0002",
				"rt_tent_c_0013",
				"rt_tent_c_0001",
				"rt_tent_c_0012",
				"rt_tent_c_0000",
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
			groupE = {
			},
		},
		hold = {
			default = {
				"rt_tent_h_0002",
				"rt_tent_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_tent_s_0000",
				"rt_tent_s_0001",
			}
		},
		travel = {
			lrrpHold = {},
			lrrp_enemybase_to_areaOut_rts_target01		= { "rts_target01_0004a", },
			lrrp_enemybase_to_areaOut_rts_target01b		= { "rts_target01_0004b", },
			lrrp_remnants_to_areaOut_rts_target02		= { "rts_target02_0004", },
			lrrp_tent_to_areaOut_rts_target03			= { "rts_target03_0000a", },
			lrrp_tent_to_areaOut_rts_target03b			= { "rts_target03_0000b", },
			lrrp_areaOut_to_areaOut_rts_truck			= { "rts_truck_0003", },
			lrrp_areaOut_to_areaOut_rts_vehicle			= { "rts_vehicle_0003","rts_vehicle_0003", },
			lrrp_areaOut_to_areaOut_rts_target04		= { "rts_target04_0003", },
			lrrp_areaOut_to_areaOut_rts_target05		= { "rts_target05_0006a", },
			lrrp_areaOut_to_areaOut_rts_target05b		= { "rts_target05_0006b", },
			lrrp_areaOut_to_areaOut_rts_target06		= { "rts_target06_0005", },
			lrrp_areaOut_to_areaOut_rts_target07		= { "rts_target07_0005", },
			lrrp_rts_bonus01_01							= { "rts_bonus01_0004", },
			lrrp_rts_bonus01_02							= { "rts_bonus01_0007", },
		},
	},
	afgh_enemyBase_cp		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01	= { "rts_target01_0000", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0007", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0007","rts_vehicle_0007", },
			lrrp_rts_bonus03_01						= { "rts_bonus03_0003", },
			lrrp_rts_bonus03_02						= { "rts_bonus03_0007", },
		},
	},
	afgh_remnants_cp		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_remnants_to_areaOut_rts_target02		= { "rts_target02_0000a", },
			lrrp_remnants_to_areaOut_rts_target02b		= { "rts_target02_0000b", },
			lrrp_areaOut_to_areaOut_rts_target06		= { "rts_target06_0001", },
			lrrp_areaOut_to_areaOut_rts_target07		= { "rts_target07_0001", },
			lrrp_rts_bonus02_01							= { "rts_bonus02_0001", },
		},
	},
	afgh_tentEast_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01 = { "rts_target01_0002", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0005", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0005","rts_vehicle_0005", },
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0004", },
			lrrp_rts_bonus03_02						= { "rts_bonus03_0005", },
		},
	},
	afgh_enemyEast_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_rts_bonus03_00 = { "rts_bonus03_0001", },
		},
	},
	afgh_villageWest_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0001", },
		},
	},
	afgh_remnantsNorth_ob	= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_remnants_to_areaOut_rts_target02	= { "rts_target02_0002", },
			lrrp_areaOut_to_areaOut_rts_target04	= { "rts_target04_0001", },
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0003", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0003", },
			lrrp_rts_bonus02						= { "rts_bonus02_0003", },
		},
	},
	afgh_tentNorth_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01	= { "rts_target01_0006", },
			lrrp_remnants_to_areaOut_rts_target02	= { "rts_target02_0006", },
			lrrp_tent_to_areaOut_rts_target03		= { "rts_target03_0002", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0001", },
			lrrp_areaOut_to_areaOut_rts_target04	= { "rts_target04_0005", },
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0008", },
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0007", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0007", },
			lrrp_rts_bonus01_00						= { "rts_bonus01_0001", },
			lrrp_rts_bonus01_01						= { "rts_bonus01_0002", },
			lrrp_rts_bonus01_02						= { "rts_bonus01_0009", },
			lrrp_rts_bonus02_01						= { "rts_bonus02_0003", },
			lrrp_rts_bonus02_02						= { "rts_bonus02_0004", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0001","rts_vehicle_0001", },
		},
	},
	
	afgh_04_32_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0000", },
		},
	},
	
	afgh_04_36_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0002", },
		},
	},
	
	afgh_06_24_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01	= { "rts_target01_0003", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0004", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0004","rts_vehicle_0004", },
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0005", },
			lrrp_rts_bonus01_02						= { "rts_bonus01_0006", },
		},
	},
	
	afgh_06_36_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01	= { "rts_target01_0001", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0006", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0006","rts_vehicle_0006", },
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0003", },
			lrrp_rts_bonus03_01						= { "rts_bonus03_0004", },
			lrrp_rts_bonus03_02						= { "rts_bonus03_0006", },
		},
	},
	
	afgh_15_36_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0008", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0008","rts_vehicle_0008", },
		},
	},
	
	afgh_20_21_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_areaOut_to_areaOut_rts_target04	= { "rts_target04_0000", },
			lrrp_rts_bonus02_02						= { "rts_bonus02_0005", },
		},
	},
	
	afgh_21_24_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_remnants_to_areaOut_rts_target02	= { "rts_target02_0003", },
			lrrp_areaOut_to_areaOut_rts_target04	= { "rts_target04_0002a", },
			lrrp_areaOut_to_areaOut_rts_target04b	= { "rts_target04_0002b", },
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0004", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0004", },
			lrrp_rts_bonus01_01						= { "rts_bonus01_0005", },
		},
	},
	
	afgh_21_28_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_remnants_to_areaOut_rts_target02	= { "rts_target02_0001", },
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0002", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0002", },
			lrrp_rts_bonus02_01						= { "rts_bonus02_0002", },
		},
	},
	
	afgh_22_24_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01	= { "rts_target01_0005", },
			lrrp_remnants_to_areaOut_rts_target02	= { "rts_target02_0005", },
			lrrp_tent_to_areaOut_rts_target03		= { "rts_target03_0001", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0002", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0002","rts_vehicle_0002", },
			lrrp_areaOut_to_areaOut_rts_target04	= { "rts_target04_0004", },
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0007", },
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0006", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0006", },
			lrrp_rts_bonus01_01						= { "rts_bonus01_0003", },
			lrrp_rts_bonus01_02						= { "rts_bonus01_0008", },
		},
	},
	
	afgh_28_29_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0000", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0000", },
			lrrp_rts_bonus02_00						= { "rts_bonus02_0000", },
		},
	},
	
	afgh_36_38_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_rts_bonus03_00						= { "rts_bonus03_0002", },
		},
	},
	
	s10054_areaOut_cp		= {
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
		travel = {
			lrrp_enemybase_to_areaOut_rts_target01	= { "rts_target01_0007", },
			lrrp_remnants_to_areaOut_rts_target02	= { "rts_target02_0007", },
			lrrp_tent_to_areaOut_rts_target03		= { "rts_target03_0003", },
			lrrp_areaOut_to_areaOut_rts_truck		= { "rts_truck_0000", },
			lrrp_areaOut_to_areaOut_rts_target04	= { "rts_target04_0006", },
			lrrp_areaOut_to_areaOut_rts_target05	= { "rts_target05_0009", },
			lrrp_areaOut_to_areaOut_rts_target06	= { "rts_target06_0008", },
			lrrp_areaOut_to_areaOut_rts_target07	= { "rts_target07_0008", },
			lrrp_rts_bonus01_00						= { "rts_bonus01_0000", },
			lrrp_areaOut_to_areaOut_rts_vehicle		= { "rts_vehicle_0000","rts_vehicle_0000", },
		},
	},
	
	s10054_areaOut02_cp		= {
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
		travel = {
			lrrp_rts_bonus03_00						= { "rts_bonus03_0000", },
		},
	},
}





this.enemyBaseTargetVehicle_GO = function()
	Fox.Log(" taravelPlan START : enemyBaseTargetVehicle_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0000") , { id = "StartTravel", travelPlan = "travel_enemyBase_to_areaOut_target01" , keepInAlert = true } )
end

this.remnantsTargetVehicle_GO = function()
	Fox.Log(" taravelPlan START : remnantsTargetVehicle_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0002") , { id = "StartTravel", travelPlan = "travel_remnants_to_areaOut_target02" , keepInAlert = true } )
end

this.hideTargetVehicle_GO = function()
	Fox.Log(" taravelPlan START : hideTargetVehicle_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0005") , { id = "StartTravel", travelPlan = "travel_tent_to_areaOut_target03" , keepInAlert = true } )
end

this.areaOut01_GO = function()
	Fox.Log(" taravelPlan START : areaOut01_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0003") , { id = "StartTravel", travelPlan = "travel_areaOut_to_areaOut_target04" , keepInAlert = true } )
end

this.areaOut02_GO = function()
	Fox.Log(" taravelPlan START : areaOut02_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0004") , { id = "StartTravel", travelPlan = "travel_areaOut_to_areaOut_target05" , keepInAlert = true } )
end

this.areaOut03_GO = function()
	Fox.Log(" taravelPlan START : areaOut03_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0006") , { id = "StartTravel", travelPlan = "travel_areaOut_to_areaOut_target06" , keepInAlert = true } )
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0007") , { id = "StartTravel", travelPlan = "travel_areaOut_to_areaOut_target07" , keepInAlert = true } )
end

this.bonusTarget_GO = function()
	Fox.Log(" taravelPlan START : bonusTarget_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0008") , { id = "StartTravel", travelPlan = "travel_bonusTarget01_00" , keepInAlert = false } )
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0009") , { id = "StartTravel", travelPlan = "travel_bonusTarget02_00" , keepInAlert = false } )
end
this.bonusTarget_GO_2 = function()
	Fox.Log(" taravelPlan START : bonusTarget_GO_2 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0010") , { id = "StartTravel", travelPlan = "travel_bonusTarget03_00" , keepInAlert = false } )
end

this.bonusTarget01_railChange_to01 = function()
	Fox.Log(" taravelPlan START : bonusTarget01_01 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0008") , { id = "StartTravel", travelPlan = "travel_bonusTarget01_01" , keepInAlert = false } )
end

this.bonusTarget01_railChange_to02 = function()
	Fox.Log(" taravelPlan START : bonusTarget01_02 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0008") , { id = "StartTravel", travelPlan = "travel_bonusTarget01_02" , keepInAlert = false } )
end

this.bonusTarget02_railChange_to01 = function()
	Fox.Log(" taravelPlan START : bonusTarget02_01 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0009") , { id = "StartTravel", travelPlan = "travel_bonusTarget02_01" , keepInAlert = false } )
end

this.bonusTarget02_railChange_to02 = function()
	Fox.Log(" taravelPlan START : bonusTarget02_02 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0009") , { id = "StartTravel", travelPlan = "travel_bonusTarget02_02" , keepInAlert = false } )
end

this.bonusTarget03_railChange_to01 = function()
	Fox.Log(" taravelPlan START : bonusTarget03_01 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0010") , { id = "StartTravel", travelPlan = "travel_bonusTarget03_01" , keepInAlert = false } )
end

this.bonusTarget03_railChange_to02 = function()
	Fox.Log(" taravelPlan START : bonusTarget03_02 ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0010") , { id = "StartTravel", travelPlan = "travel_bonusTarget03_02" , keepInAlert = false } )
end


this.bulletTruck_GO = function()
	Fox.Log(" taravelPlan START : bulletTruck_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0001") , { id = "StartTravel", travelPlan = "travel_areaOut_to_areaOut_truck" , keepInAlert = true } )
end

this.vehicle_GO = function()
	Fox.Log(" taravelPlan START : vehicle_GO ")
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0011") , { id = "StartTravel", travelPlan = "travel_enemyBase_to_areaOut_vehicle" , keepInAlert = true } )
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0012") , { id = "StartTravel", travelPlan = "travel_enemyBase_to_areaOut_vehicle" , keepInAlert = true } )
end




this.InterCall_Hostage_01 = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{
		objectives = { "hostage_remnants" },	
	}
	return true
end
this.InterCall_Hostage_02 = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{
		objectives = { "hostage_enemyBase" },	
	}
	return true
end
this.InterCall_searchEnemy = function( soldier2GameObjectId, cpID, interName )
	
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_tent_cp"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_enemyBase_cp"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_remnants_cp"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_tentEast_ob"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_tentNorth_ob"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_enemyEast_ob"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_villageWest_ob"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	TppInterrogation.RemoveHighInterrogation( GameObject.GetGameObjectId("afgh_remnantsNorth_ob"),
		{ { name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },} )
	
	TppMission.UpdateObjective{
		objectives = { "searchEnemy_01","searchEnemy_02","searchEnemy_03","searchEnemy_04", },
	}
	return true
end
this.InterCall_movingHostage_01 = function( soldier2GameObjectId, cpID, interName )
	return true
end
this.InterCall_movingHostage_02 = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{ objectives = { "movingHostage_01",},}
	return true
end
this.InterCall_movingHostage_03 = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{ objectives = { "movingHostage_02",},}
	return true
end
this.InterCall_movingHostage_04 = function( soldier2GameObjectId, cpID, interName )
	TppMission.UpdateObjective{ objectives = { "movingHostage_03",},}
	return true
end

this.interrogation = {
	afgh_tent_cp = {
		high = { 			
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_enemyBase_cp = {
		high = { 			
			{ name = "enqt1000_1i1310",		func = this.InterCall_Hostage_02, },
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_remnants_cp = {
		high = {			
			{ name = "enqt1000_1i1210",		func = this.InterCall_Hostage_01, },
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_tentEast_ob = {
		high = { 			
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_tentNorth_ob = {
		high = { 			
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_enemyEast_ob = {
		high = { 			
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_villageWest_ob = {
		high = { 			
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	afgh_remnantsNorth_ob = {
		high = { 			
			{ name = "enqt1000_107018",		func = this.InterCall_searchEnemy, },
			nil
		},
		normal = { nil },	
		nil
	},
	s10054_searchEnemy_cp = {
		high = { 			
			{ name = "enqt1000_107022",		func = this.InterCall_movingHostage_01, },
			{ name = "enqt1000_107027",		func = this.InterCall_movingHostage_02, },
			{ name = "enqt1000_107032",		func = this.InterCall_movingHostage_03, },
			{ name = "enqt1000_1i1210",		func = this.InterCall_movingHostage_04, },
			nil
		},
		normal = { nil },	
		nil
	},	
}

this.useGeneInter = {
	afgh_tent_cp			= true,
	afgh_enemyBase_cp		= true,
	afgh_remnants_cp		= true,
	afgh_tentEast_ob		= true,
	afgh_tentNorth_ob		= true,
	afgh_enemyEast_ob		= true,
	afgh_villageWest_ob		= true,
	afgh_remnantsNorth_ob	= true,
	nil
}



this.cpGroups = {
	group_Area1 = {
		"s10054_areaOut_cp",
		"s10054_areaOut02_cp",
		"s10054_searchEnemy_cp",
	},
	group_Area2 = {
	},
}




this.lrrpHoldTime = 15

this.travelPlans = {

	
	travel_enemyBase_to_areaOut_target01 = {
		ONE_WAY = true,
		{ cp = "afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "afgh_06_36_lrrp", 			routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "afgh_tentEast_ob", 			routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "afgh_06_24_lrrp", 			routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01b" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_enemybase_to_areaOut_rts_target01" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_remnants_to_areaOut_target02 = {
		ONE_WAY = true,
		{ cp = "afgh_remnants_cp", 			routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "afgh_remnants_cp", 			routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02b" } },
		{ cp = "afgh_21_28_lrrp", 			routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "afgh_remnantsNorth_ob", 	routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "afgh_21_24_lrrp", 			routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_remnants_to_areaOut_rts_target02" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_tent_to_areaOut_target03 = {
		ONE_WAY = true,
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_tent_to_areaOut_rts_target03" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_tent_to_areaOut_rts_target03b" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_tent_to_areaOut_rts_target03" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_tent_to_areaOut_rts_target03" } },
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_tent_to_areaOut_rts_target03" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_areaOut_to_areaOut_target04 = {
		ONE_WAY = true,
		{ cp = "afgh_20_21_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "afgh_remnantsNorth_ob",		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "afgh_21_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "afgh_21_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04b" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target04" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_areaOut_to_areaOut_target05 = {
		ONE_WAY = true,
		{ cp = "afgh_04_32_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_villageWest_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_04_36_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_06_36_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_tentEast_ob", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_06_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05b" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target05" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_areaOut_to_areaOut_target06 = {
		ONE_WAY = true,
		{ cp = "afgh_28_29_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_remnants_cp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_21_28_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_remnantsNorth_ob", 	routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_21_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },	
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target06" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_areaOut_to_areaOut_target07 = {
		ONE_WAY = true,
		{ cp = "afgh_28_29_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_remnants_cp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_21_28_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_remnantsNorth_ob", 	routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_21_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },	
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_target07" } },
		{ cp = "s10054_areaOut_cp" },
	},
	
	travel_areaOut_to_areaOut_truck = {
		ONE_WAY = true,
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_06_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_tentEast_ob", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_06_36_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_15_36_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_truck" } },
		{ cp = "afgh_15_36_lrrp" },
	},
	
	travel_enemyBase_to_areaOut_vehicle = {
		ONE_WAY = true,
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_tent_cp", 				routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_06_24_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_tentEast_ob", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_06_36_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_15_36_lrrp", 			routeGroup={ "travel", "lrrp_areaOut_to_areaOut_rts_vehicle" } },
		{ cp = "afgh_15_36_lrrp" },
	},
	
	travel_bonusTarget01_00 = {
		ONE_WAY = true,
		{ cp = "s10054_areaOut_cp", 		routeGroup={ "travel", "lrrp_rts_bonus01_00" } },	
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_rts_bonus01_00" } },	
		{ cp = "afgh_tentNorth_ob" },
	},
	travel_bonusTarget01_01 = {
		ONE_WAY = true,
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_rts_bonus01_01" } },	
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus01_01" } },	
		{ cp = "afgh_tent_cp",		 		routeGroup={ "travel", "lrrp_rts_bonus01_01" } },	
		{ cp = "afgh_21_24_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus01_01" } },	
		{ cp = "afgh_21_24_lrrp" },
	},
	travel_bonusTarget01_02 = {
		ONE_WAY = true,
		{ cp = "afgh_06_24_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus01_02" } },	
		{ cp = "afgh_tent_cp",		 		routeGroup={ "travel", "lrrp_rts_bonus01_02" } },	
		{ cp = "afgh_22_24_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus01_02" } },	
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_rts_bonus01_02" } },	
		{ cp = "afgh_tentNorth_ob" },
	},
	
	travel_bonusTarget02_00 = {
		ONE_WAY = true,
		{ cp = "afgh_28_29_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus02_00" } },	
		{ cp = "afgh_28_29_lrrp" },
	},
	travel_bonusTarget02_01 = {
		ONE_WAY = true,
		{ cp = "afgh_remnants_cp", 			routeGroup={ "travel", "lrrp_rts_bonus02_01" } },	
		{ cp = "afgh_21_28_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus02_01" } },	
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_rts_bonus02_01" } },	
		{ cp = "afgh_tentNorth_ob" },
	},
	travel_bonusTarget02_02 = {
		ONE_WAY = true,
		{ cp = "afgh_tentNorth_ob", 		routeGroup={ "travel", "lrrp_rts_bonus02_02" } },	
		{ cp = "afgh_20_21_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus02_02" } },	
		{ cp = "afgh_20_21_lrrp" },
	},
	
	travel_bonusTarget03_00 = {
		ONE_WAY = true,
		{ cp = "s10054_areaOut02_cp", 		routeGroup={ "travel", "lrrp_rts_bonus03_00" } },		
		{ cp = "afgh_enemyEast_ob", 		routeGroup={ "travel", "lrrp_rts_bonus03_00" } },		
		{ cp = "afgh_36_38_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus03_00" } },		
		{ cp = "afgh_36_38_lrrp" },
	},
	travel_bonusTarget03_01 = {
		ONE_WAY = true,
		{ cp = "afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrp_rts_bonus03_01" } },		
		{ cp = "afgh_06_36_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus03_01" } },		
		{ cp = "afgh_06_36_lrrp" },
	},
	travel_bonusTarget03_02 = {
		ONE_WAY = true,
		{ cp = "afgh_tentEast_ob", 			routeGroup={ "travel", "lrrp_rts_bonus03_02" } },		
		{ cp = "afgh_06_36_lrrp", 			routeGroup={ "travel", "lrrp_rts_bonus03_02" } },		
		{ cp = "afgh_enemyBase_cp", 		routeGroup={ "travel", "lrrp_rts_bonus03_02" } },		
		{ cp = "afgh_enemyBase_cp" },
	},
}



this.combatSetting = {
	afgh_tent_cp = {
		"gt_tent_0000",
		"cs_tent_0000",
	},
	afgh_enemyBase_cp = {
		"gt_enemyBase_0000",
		"gt_enemyBase_0001",
		"cs_enemyBase_0000",
		"cs_enemyBase_0001",
		combatAreaList = {
			area1 = {	
					{ guardTargetName = "gt_enemyBase_0000", locatorSetName = "cs_enemyBase_0000", },
			},
			area2 = {	
					{ guardTargetName = "gt_enemyBase_0001", locatorSetName = "cs_enemyBase_0001", },
			},
		},
	},
	afgh_remnants_cp = {
		"gt_remnants_0000",
		"cs_remnants_0000",
	},
	afgh_tentEast_ob = {
		"gt_tentEast_0000",
	},
	afgh_enemyEast_ob = {
		"gt_enemyEast_0000",
	},
	afgh_villageWest_ob = {
		"gt_villageWest_0000",
	},
	afgh_remnantsNorth_ob = {
		"gt_remnantsNorth_0000",
	},
	afgh_tentNorth_ob = {
		"gt_tentNorth_0000",
	},
	s10054_searchEnemy_cp = {
	},
	nil
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	local missionName		= TppMission.GetMissionName()
	local hosRiverId		= GameObject.GetGameObjectId( "hos_s10054_0000" )	
	local hosAbductId		= GameObject.GetGameObjectId( "hos_s10054_0001" )	
	local hosSandId			= GameObject.GetGameObjectId( "hos_s10054_0002" )	
	local hosNormalId_A		= GameObject.GetGameObjectId( "hos_s10054_0003" )	
	local hosNormalId_B		= GameObject.GetGameObjectId( "hos_s10054_0004" )	
	local hosCliffId		= GameObject.GetGameObjectId( "hos_s10054_0005" )	
	local hosRiver_routeSet	= { id = "SetSneakRoute", route = "rts_hosRiver_0000",}
	local hosSand_routeSet	= { id = "SetSneakRoute", route = "rts_hosSand_0000",}
	local hosCliff_routeSet	= { id = "SetSneakRoute", route = "rts_hosCliff_0000",}
	local obSetCommand		= { id = "SetOuterBaseCp" }
	local lrrpSetCommand	= { id = "SetLrrpCp" }
	
	
	local Lang_English		= { id = "SetLangType", langType="english" }	
	
	local VoiceType_A		= { id = "SetVoiceType", voiceType = "hostage_a" }
	local VoiceType_B		= { id = "SetVoiceType", voiceType = "hostage_b" }
	local VoiceType_C		= { id = "SetVoiceType", voiceType = "hostage_c" }
	local VoiceType_D		= { id = "SetVoiceType", voiceType = "hostage_d" }
	
	
	local targetDriverId_01		= GameObject.GetGameObjectId("TppSoldier2", "sol_s10054_0000" )	
	local targetDriverId_02		= GameObject.GetGameObjectId("TppSoldier2", "sol_s10054_0002" )	
	local targetDriverId_03		= GameObject.GetGameObjectId("TppSoldier2", "sol_s10054_0005" )	
	
	local targetVehicleId_01	= GameObject.GetGameObjectId("TppVehicle2", "veh_s10054_0000" )	
	local targetVehicleId_02	= GameObject.GetGameObjectId("TppVehicle2", "veh_s10054_0002" )	
	local targetVehicleId_03	= GameObject.GetGameObjectId("TppVehicle2", "veh_s10054_0003" )	
	
	local command_target01 		= { id="SetRelativeVehicle", targetId = targetVehicleId_01	, rideFromBeginning = true }		
	local command_target02 		= { id="SetRelativeVehicle", targetId = targetVehicleId_02	, rideFromBeginning = true }		
	local command_target03 		= { id="SetRelativeVehicle", targetId = targetVehicleId_03	, rideFromBeginning = true }		
	
	
	
	
	if missionName == "s11054"	then
		TppHelicopter.SetEnemyColoring( TppDefine.ENEMY_HELI_COLORING_TYPE.BLACK )
	else
		TppHelicopter.SetEnemyColoring( TppDefine.ENEMY_HELI_COLORING_TYPE.DEFAULT )
	end
	
	
	
	
	GameObject.SendCommand( hosRiverId		, Lang_English )
	GameObject.SendCommand( hosRiverId		, VoiceType_C )
	
	GameObject.SendCommand( hosAbductId		, Lang_English )
	GameObject.SendCommand( hosAbductId		, VoiceType_A )
	
	GameObject.SendCommand( hosSandId		, Lang_English )
	GameObject.SendCommand( hosSandId		, VoiceType_A )
	
	GameObject.SendCommand( hosNormalId_A	, Lang_English )
	GameObject.SendCommand( hosNormalId_A	, VoiceType_D )
	
	GameObject.SendCommand( hosNormalId_B	, Lang_English )
	GameObject.SendCommand( hosNormalId_B	, VoiceType_C )
	
	GameObject.SendCommand( hosCliffId		, Lang_English )
	GameObject.SendCommand( hosCliffId		, VoiceType_B )
	
	
	
	
	GameObject.SendCommand( targetDriverId_01	, command_target01 )
	GameObject.SendCommand( targetDriverId_02	, command_target02 )
	GameObject.SendCommand( targetDriverId_03	, command_target03 )
	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0001") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0011") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0012") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0004") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0003") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0006") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0007") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0008") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0009") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId("sol_s10054_0010") , { id="SetEnabled", enabled=false } )	
	GameObject.SendCommand( GameObject.GetGameObjectId( "hos_s10054_0001" ) , { id="SetEnabled", enabled=false } )	
	
	
	
	local prisonBreakHostage_A	= { type = "TppHostage2" , index = GameObject.GetGameObjectId("hos_s10054_0005") }
	local prisonBreakHostage_B	= { type = "TppHostage2" , index = GameObject.GetGameObjectId("hos_s10054_0000") }
	local prisonBreakHostage_C	= { type = "TppHostage2" , index = GameObject.GetGameObjectId("hos_s10054_0002") }
	local prisonBreak = { id = "SetNoticeState", state = TppGameObject.HOSTAGE_NOTICE_STATE_FLEE }
	GameObject.SendCommand( prisonBreakHostage_A , prisonBreak )
	GameObject.SendCommand( prisonBreakHostage_B , prisonBreak )
	GameObject.SendCommand( prisonBreakHostage_C , prisonBreak )
	
	
	
	
	TppEnemy.SetSneakRoute( "sol_s10054_0000" , "rts_targetEnemyBase_wait" )
	TppEnemy.SetCautionRoute( "sol_s10054_0000" , "rts_targetEnemyBase_wait" )
	TppEnemy.SetAlertRoute( "sol_s10054_0000" , "rts_targetEnemyBase_wait" )
	
	TppEnemy.SetSneakRoute( "sol_s10054_0002" , "rts_targetRemnants_wait" )
	TppEnemy.SetCautionRoute( "sol_s10054_0002" , "rts_targetRemnants_wait" )
	TppEnemy.SetAlertRoute( "sol_s10054_0002" , "rts_targetRemnants_wait" )
	
	TppEnemy.SetSneakRoute( "sol_s10054_0005" , "rts_targetHideVehicle_wait" )
	TppEnemy.SetCautionRoute( "sol_s10054_0005" , "rts_targetHideVehicle_wait" )
	TppEnemy.SetAlertRoute( "sol_s10054_0005" , "rts_targetHideVehicle_wait" )
	
	
	
	TppEnemy.AssignUniqueStaffType{
        locaterName = "hos_s10054_0001",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10054_HOSTAGE_01,	
        alreadyExistParam = { staffTypeId =3, randomRangeId =6, skill ="ElectricSpinningEngineer" },		
	}
	TppEnemy.AssignUniqueStaffType{
        locaterName = "hos_s10054_0000",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10054_HOSTAGE_02,	
        alreadyExistParam = { staffTypeId =41, randomRangeId =4, skill =nil },		
	}
	TppEnemy.AssignUniqueStaffType{
        locaterName = "hos_s10054_0002",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10054_HOSTAGE_03,	
        alreadyExistParam = { staffTypeId =12, randomRangeId =6, skill =nil },		
	}
	TppEnemy.AssignUniqueStaffType{
        locaterName = "hos_s10054_0003",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10054_HOSTAGE_04,	
        alreadyExistParam = { staffTypeId =61, randomRangeId =4, skill ="DrugEngineer" },	
	}
	TppEnemy.AssignUniqueStaffType{
        locaterName = "hos_s10054_0004",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10054_HOSTAGE_06,	
        alreadyExistParam = { staffTypeId =3, randomRangeId =6, skill ="CyberneticsEngineer" },	
	}
	TppEnemy.AssignUniqueStaffType{
        locaterName = "hos_s10054_0005",
        uniqueStaffTypeId = TppDefine.UNIQUE_STAFF_TYPE_ID.S10054_HOSTAGE_05,	
        alreadyExistParam = { staffTypeId =60, randomRangeId =4, skill ="Surgeon" },	
	}
	
	
	
	GameObject.SendCommand( GameObject.GetGameObjectId( "s10054_areaOut_cp" ) , lrrpSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "s10054_areaOut02_cp" ) , lrrpSetCommand )
	GameObject.SendCommand( GameObject.GetGameObjectId( "s10054_searchEnemy_cp" ) , obSetCommand )
	
	
	
	TppEnemy.SetEliminateTargets( { "veh_s10054_0000","veh_s10054_0002","veh_s10054_0003","veh_s10054_0004","veh_s10054_0005","veh_s10054_0007","veh_s10054_0008" } )
	
	
	
	TppEnemy.RegistHoldRecoveredState("sol_search_0000")
	TppEnemy.RegistHoldRecoveredState("sol_search_0001")
	TppEnemy.RegistHoldRecoveredState("sol_search_0002")
	TppEnemy.RegistHoldRecoveredState("sol_search_0003")
	TppEnemy.RegistHoldRecoveredState("hos_s10054_0000")
	TppEnemy.RegistHoldRecoveredState("hos_s10054_0001")
	TppEnemy.RegistHoldRecoveredState("hos_s10054_0002")
	TppEnemy.RegistHoldRecoveredState("hos_s10054_0003")
	TppEnemy.RegistHoldRecoveredState("hos_s10054_0004")
	TppEnemy.RegistHoldRecoveredState("hos_s10054_0005")
	TppEnemy.RegistHoldRecoveredState("veh_s10054_0010")
	TppEnemy.RegistHoldRecoveredState("veh_s10054_0011")
	TppEnemy.RegistHoldRecoveredState("veh_s10054_0012")
	
	
	
	GameObject.SendCommand( hosRiverId , hosRiver_routeSet )
	GameObject.SendCommand( hosSandId , hosSand_routeSet )
	GameObject.SendCommand( hosCliffId , hosCliff_routeSet )
	
	
	
	TppEnemy.RegisterCombatSetting( this.combatSetting )
end
this.OnLoad = function ()
	Fox.Log("*** s10054 onload ***")
end




return this
