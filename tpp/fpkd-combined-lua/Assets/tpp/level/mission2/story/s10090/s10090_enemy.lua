local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local IsTypeFunc = Tpp.IsTypeFunc
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID

this.requires = {}






this.DEBUG_ON_PARASITES_PARAMETERS = true






this.ENEMY_NAME = {
	
	ZRS_ESCORT01					= "sol_ZRS_0000",					
	ZRS_ESCORT02					= "sol_ZRS_0001",					
	
	ZRS_PFCAMP01					= "sol_ZRS_0002",					
	ZRS_PFCAMP02					= "sol_ZRS_0003",					
	ZRS_PFCAMP03					= "sol_ZRS_0004",					
	ZRS_PFCAMP04					= "sol_ZRS_0005",					
	
	ZRS_SWAMP01						= "sol_ZRS_0006",					
	ZRS_SWAMP02						= "sol_ZRS_0007",					
	
	ZRS_FLOWSTATION01				= "sol_ZRS_0008",					
	ZRS_FLOWSTATION02				= "sol_ZRS_0009",					
	
	ZRS_ESCORT_VEHICLE_01			= "sol_ZRS_0010",					
	ZRS_ESCORT_VEHICLE_02			= "sol_ZRS_0011",					
	ZRS_ESCORT_VEHICLE_03			= "sol_ZRS_0012",					
	ZRS_ESCORT_VEHICLE_04			= "sol_ZRS_0013",					
	
	ZRS_TRANSPORT01					= "sol_ZRS_demo_0000",				
	ZRS_TRANSPORT02					= "sol_ZRS_demo_0001",				
}


this.VEHICLE_NAME = {
	WEST_WAV01						= "veh_wav_0000",					
	WEST_WAV02						= "veh_wav_0001",					
	TRUCK_TARGET					= "veh_trc_0000",					
	VEHICLE_01						= "veh_lv_0000",					
}


this.CP_NAME = {
	ESCROT_OB_01					= "ms_escort01_ob",					
	ESCROT_OB_02					= "ms_escort02_ob",					
	ESCROT_OB_03					= "ms_escort03_ob",					
	ESCROT_LRRP						= "ms_05_23_lrrp",					
	TRANSPORT_OB					= "ms_Transport_ob",				
}


this.VEHICLE_SPAWN_LIST_NORMAL = {
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.WEST_WAV01,
		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
		subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN,
		paintType = Vehicle.paintType.FOVA_0,
		class = Vehicle.class.DEFAULT,
	},
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.WEST_WAV02,
		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
		subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,
		paintType = Vehicle.paintType.FOVA_0,
		class = Vehicle.class.DEFAULT,
	},
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.TRUCK_TARGET,
		type = Vehicle.type.WESTERN_TRUCK,
		subType = Vehicle.subType.WESTERN_TRUCK_HOOD,
		paintType = Vehicle.paintType.FOVA_0,
	},
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.VEHICLE_01,
		type = Vehicle.type.WESTERN_LIGHT_VEHICLE,
		paintType = Vehicle.paintType.FOVA_0,
	},
}


this.VEHICLE_SPAWN_LIST_HARD = {
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.WEST_WAV01,
		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
		subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN,

		class = Vehicle.class.DARK_GRAY,
	},
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.WEST_WAV02,
		type = Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
		subType = Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,

		class = Vehicle.class.OXIDE_RED,
	},
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.TRUCK_TARGET,
		type = Vehicle.type.WESTERN_TRUCK,
		subType = Vehicle.subType.WESTERN_TRUCK_HOOD,
		paintType = Vehicle.paintType.FOVA_0,
	},
	{	
		id = "Spawn",
		locator = this.VEHICLE_NAME.VEHICLE_01,
		type = Vehicle.type.WESTERN_LIGHT_VEHICLE,
		paintType = Vehicle.paintType.FOVA_0,
	},
}



this.PARASITES_PARAMETERS_LIST_NORMAL = {
	sightDistance					= 25,							
	sightDistanceCombat				= 75,							

	sightHorizontal					= 60,							
	noiseRate						= 8,							
	avoidSideMin					= 8,							
	avoidSideMax					= 12,							
	areaCombatBattleRange			= 50,							
	areaCombatBattleToSearchTime	= 1,							
	areaCombatLostSearchRange		= 1000,							
	areaCombatLostToGuardTime		= 120,							


	throwRecastTime					= 10,							
}

this.PARASITES_PARAMETERS_LIST_EXSTREME = {
	sightDistance					= 25,							
	sightDistanceCombat				= 100,							

	sightHorizontal					= 100,							
	noiseRate						= 10,							
	avoidSideMin					= 8,							
	avoidSideMax					= 12,							
	areaCombatBattleRange			= 50,							
	areaCombatBattleToSearchTime	= 1,							
	areaCombatLostSearchRange		= 1000,							
	areaCombatLostToGuardTime		= 60,							


	throwRecastTime					= 10,							
}







this.USE_COMMON_REINFORCE_PLAN = true


this.vehicleDefine = { instanceCount = 4 }


this.soldierSubTypes = {
	
	PF_B = {
		
		this.ENEMY_NAME.ZRS_ESCORT01,
		this.ENEMY_NAME.ZRS_ESCORT02,
		
		this.ENEMY_NAME.ZRS_PFCAMP01,
		this.ENEMY_NAME.ZRS_PFCAMP02,
		this.ENEMY_NAME.ZRS_PFCAMP03,
		this.ENEMY_NAME.ZRS_PFCAMP04,
		
		this.ENEMY_NAME.ZRS_SWAMP01,
		this.ENEMY_NAME.ZRS_SWAMP02,
		
		this.ENEMY_NAME.ZRS_FLOWSTATION01,
		this.ENEMY_NAME.ZRS_FLOWSTATION02,
		
		this.ENEMY_NAME.ZRS_TRANSPORT01,
		this.ENEMY_NAME.ZRS_TRANSPORT02,
		
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_01,
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_02,
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_03,
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_04,
	},
}


this.soldierPowerSettings = {
	
	sol_pfCamp_0001 = { "SNIPER" },
	sol_pfCamp_0002 = { "SNIPER" },
	sol_pfCamp_0003 = { "SNIPER" },
	
	sol_ZRS_0010	= { "SOFT_ARMOR", "HELMET", },
	sol_ZRS_0011	= { "SOFT_ARMOR", "HELMET", },
	sol_ZRS_0012	= { "SOFT_ARMOR", "HELMET", "MISSILE" },
	sol_ZRS_0013	= { "SOFT_ARMOR", "HELMET", "MISSILE" },
}





this.soldierDefine = {
	
	
	ms_escort01_ob = {
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_01,
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_02,
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_03,
		this.ENEMY_NAME.ZRS_ESCORT_VEHICLE_04,
	},
	
	ms_escort02_ob = {
		nil
	},
	
	ms_escort03_ob = {
		nil
	},
	
	ms_Transport_ob = {
		this.ENEMY_NAME.ZRS_TRANSPORT01,
		this.ENEMY_NAME.ZRS_TRANSPORT02,
	},
	
	ms_05_23_lrrp = {
		nil
	},
	
	
	
	mafr_savannah_cp = {
		"sol_savannah_0000",
		"sol_savannah_0001",
		"sol_savannah_0002",
		"sol_savannah_0003",
		"sol_savannah_0004",
		"sol_savannah_0005",
		"sol_savannah_0006",
		"sol_savannah_0007",
		"sol_savannah_0008",
		"sol_savannah_0009",
		"sol_savannah_0010",
		"sol_savannah_0011",
		nil
	},
	mafr_pfCamp_cp = {
		"sol_pfCamp_0000",
		"sol_pfCamp_0001",
		"sol_pfCamp_0002",
		"sol_pfCamp_0003",
		"sol_pfCamp_0004",
		"sol_pfCamp_0005",
		"sol_pfCamp_0006",
		"sol_pfCamp_0007",
		"sol_pfCamp_0008",
		"sol_pfCamp_0009",
		"sol_pfCamp_0010",
		this.ENEMY_NAME.ZRS_PFCAMP01,
		this.ENEMY_NAME.ZRS_PFCAMP02,
		this.ENEMY_NAME.ZRS_PFCAMP03,
		this.ENEMY_NAME.ZRS_PFCAMP04,
		nil
	},
	mafr_swamp_cp = {
		this.ENEMY_NAME.ZRS_SWAMP01,
		this.ENEMY_NAME.ZRS_SWAMP02,
		"sol_swamp_0000",
		"sol_swamp_0001",
		"sol_swamp_0002",
		"sol_swamp_0003",
		"sol_swamp_0004",
		"sol_swamp_0005",
		"sol_swamp_0006",
		"sol_swamp_0007",
		"sol_swamp_0008",
		"sol_swamp_0009",
		"sol_swamp_0010",
		"sol_swamp_0011",
		"sol_swamp_0012",
		"sol_swamp_0013",
		"sol_swamp_0014",
		"sol_swamp_0015",
		"sol_swamp_0016",
		"sol_swamp_0017",
		nil
	},
	mafr_flowStation_cp = {
		this.ENEMY_NAME.ZRS_FLOWSTATION01,
		this.ENEMY_NAME.ZRS_FLOWSTATION02,
		"sol_flowStation_0000",
		"sol_flowStation_0001",
		"sol_flowStation_0002",
		"sol_flowStation_0003",
		"sol_flowStation_0004",
		"sol_flowStation_0005",
		"sol_flowStation_0006",
		"sol_flowStation_0007",
		"sol_flowStation_0008",
		"sol_flowStation_0009",
		"sol_flowStation_0010",
		"sol_flowStation_0011",
		nil
	},
	
	mafr_savannahEast_ob = {
		"sol_savannahEast_0000",
		"sol_savannahEast_0001",
		"sol_savannahEast_0002",
		"sol_savannahEast_0003",
		nil
	},
	mafr_pfCampNorth_ob = {
		"sol_pfCampNorth_0000",
		"sol_pfCampNorth_0001",
		"sol_pfCampNorth_0002",
		"sol_pfCampNorth_0003",
		"sol_pfCampNorth_0004",
		"sol_pfCampNorth_0005",
		nil
	},
	mafr_pfCampEast_ob = {
		"sol_pfCampEast_0000",
		"sol_pfCampEast_0001",
		"sol_pfCampEast_0002",
		"sol_pfCampEast_0003",
		this.ENEMY_NAME.ZRS_ESCORT01,
		this.ENEMY_NAME.ZRS_ESCORT02,
		nil
	},
	mafr_swampSouth_ob = {
		"sol_swampSouth_0000",
		"sol_swampSouth_0001",
		"sol_swampSouth_0002",
		"sol_swampSouth_0003",
		"sol_swampSouth_0004",
		nil
	},
	mafr_swampEast_ob = {
		"sol_swampEast_0000",
		"sol_swampEast_0001",
		"sol_swampEast_0002",
		"sol_swampEast_0003",
		nil
	},
	mafr_swampWest_ob = {
		"sol_swampWest_0000",
		"sol_swampWest_0001",
		"sol_swampWest_0002",
		"sol_swampWest_0003",
		nil
	},
	
	mafr_01_21_lrrp = {
		nil
	},
	mafr_02_21_lrrp = {
		"sol_02_21_0000",
		"sol_02_21_0001",
		lrrpTravelPlan = "travel_lrrp_01",
	},
	mafr_02_22_lrrp = {
		nil
	},
	mafr_05_16_lrrp = {
		nil
	},
	mafr_05_22_lrrp = {
		nil
	},
	mafr_05_23_lrrp = {
		nil
	},
	mafr_06_16_lrrp = {
		nil
	},
	mafr_06_22_lrrp = {
		nil
	},
	mafr_06_24_lrrp = {
		nil
	},
	mafr_13_15_lrrp = {
		"sol_13_15_0000",
		"sol_13_15_0001",
		lrrpTravelPlan = "travel_lrrp_03",
	},
	mafr_13_16_lrrp = {
		nil
	},
	mafr_13_24_lrrp = {
		nil
	},
	mafr_15_16_lrrp = {
		nil
	},
	mafr_15_23_lrrp = {
		nil
	},
	mafr_16_23_lrrp = {
		nil
	},
	mafr_16_24_lrrp = {
		nil
	},
	nil
}


this.parasiteSquadList = {
	"wmu_s10090_0000",
	"wmu_s10090_0001",
	"wmu_s10090_0002",
	"wmu_s10090_0003",
}





this.routeSets = {
	
	
	
	
	ms_escort01_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_escort01_d_0000",
				"rts_escort01_d_0001",
				"rts_escort01_d_0002",
				"rts_escort01_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rts_escort01_d_0000",
				"rts_escort01_d_0001",
				"rts_escort01_d_0002",
				"rts_escort01_d_0003",
			},
		},
		caution = {
			groupA = {
				"rts_escort01_d_0000",
				"rts_escort01_d_0001",
				"rts_escort01_d_0002",
				"rts_escort01_d_0003",
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_escort01_to_escort02 = {
				"rts_v_escort01_0000",
				"rts_v_escort01_0000",
				"rts_v_escort01_0000",
				"rts_v_escort01_0000",
			},
		},
		nil
	},
	
	
	ms_05_23_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
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
			lrrp_escort01_to_escort02 = {
				"rts_v_escort01_escort02_0000",
				"rts_v_escort01_escort02_0000",
				"rts_v_escort01_escort02_0000",
				"rts_v_escort01_escort02_0000",
			},
		},
		nil
	},
	
	
	ms_escort02_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_escort02_d_0000",
				"rts_escort02_d_0001",
				"rts_escort02_d_0002",
				"rts_escort02_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rts_escort02_d_0000",
				"rts_escort02_d_0001",
				"rts_escort02_d_0002",
				"rts_escort02_d_0003",
			},
		},
		caution = {
			groupA = {
				"rts_escort02_d_0000",
				"rts_escort02_d_0001",
				"rts_escort02_d_0002",
				"rts_escort02_d_0003",
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_escort01_to_escort02 = {
				"rts_v_escort02_0000",
				"rts_v_escort02_0000",
				"rts_v_escort02_0000",
				"rts_v_escort02_0000",
			},
			lrrp_escort02_to_swampSouth = {
				"rts_v_escort02_0001",
				"rts_v_escort02_0001",
				"rts_v_escort02_0001",
				"rts_v_escort02_0001",
			},
		},
		nil
	},
	
	
	ms_escort03_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_escort03_d_0000",
				"rts_escort03_d_0001",
				"rts_escort03_d_0002",
				"rts_escort03_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rts_escort03_d_0000",
				"rts_escort03_d_0001",
				"rts_escort03_d_0002",
				"rts_escort03_d_0003",
			},
		},
		caution = {
			groupA = {
				"rts_escort03_d_0000",
				"rts_escort03_d_0001",
				"rts_escort03_d_0002",
				"rts_escort03_d_0003",
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_swampSouth_to_escort03 = {
				"rts_v_escort03_0000",
				"rts_v_escort03_0000",
				"rts_v_escort03_0000",
				"rts_v_escort03_0000",
			},
		},
		nil
	},
	
	
	ms_Transport_ob = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
				"rts_zrs_transport_ene01_d_0000",
				"rts_zrs_transport_ene02_d_0000",
			},
		},
		sneak_night = {
			groupA = {
				"rts_zrs_transport_ene01_d_0000",
				"rts_zrs_transport_ene02_d_0000",
			},
		},
		caution = {
			groupA = {
				"rts_zrs_transport_ene01_d_0000",
				"rts_zrs_transport_ene02_d_0000",
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_e_transport_escort01",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_e_transport_escort02",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_e_transport_truck01",
			},
		},
		nil
	},
	
	
	
	mafr_pfCampNorth_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_swampEast_ob		= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_05_16_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_06_16_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_06_22_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_06_24_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_13_16_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_15_16_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_16_23_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_16_24_lrrp			= { USE_COMMON_ROUTE_SETS = true,	},
	
	
	mafr_savannah_cp = { 
		USE_COMMON_ROUTE_SETS = true,
	},
		
	mafr_13_24_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	mafr_savannahEast_ob	= {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	mafr_13_15_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
	},
	
	mafr_pfCampEast_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			
			lrrp_pfCampEast_to_pfCamp_rts_escort01 = {
				"rts_v_s_pfCampEast_escort01",
			},
			lrrp_pfCampEast_to_pfCamp_rts_escort02 = {
				"rts_v_s_pfCampEast_escort02",
			},
		},
	},
	
	mafr_15_23_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			
			lrrp_pfCampEast_to_pfCamp_rts_escort01_01 = {
				"rts_v_15to23_escort01_0000",
			},
			lrrp_pfCampEast_to_pfCamp_rts_escort02_01 = {
				"rts_v_15to23_escort02_0000",
			},
			
			lrrp_pfCampEast_to_pfCamp_rts_escort01_02 = {
				"rts_v_15to23_escort01_0001",
			},
			lrrp_pfCampEast_to_pfCamp_rts_escort02_02 = {
				"rts_v_15to23_escort02_0001",
			},
		},
	},
	
	mafr_pfCamp_cp = {
		priority = {
			"groupConversation",
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupConversation = {
				"rts_pfCamp_ene01_d_0000",
			},
			groupSniper = {
				{ "rt_pfCamp_snp_0000", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0001", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0003", attr = "SNIPER", },
			},
			groupA = {
				"rt_pfCamp_d_0000",
				"rt_pfCamp_d_0011",
				"rt_pfCamp_d_0008",
				"rt_pfCamp_d_0004",
			},
			groupB = {
				"rt_pfCamp_d_0001",
				"rt_pfCamp_d_0005",
				"rt_pfCamp_d_0009",
				"rt_pfCamp_d_0002",
			},
			groupC = {
				"rt_pfCamp_d_0010",
				"rt_pfCamp_d_0007",
				"rt_pfCamp_d_0006",
				"rt_pfCamp_d_0003",
			},
		},
		sneak_night = {
			groupConversation = {
				"rts_pfCamp_ene01_d_0000",
			},
			groupSniper = {
				{ "rt_pfCamp_snp_0000", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0001", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0003", attr = "SNIPER", },
			},
			groupA = {
				"rt_pfCamp_n_0000",
				"rt_pfCamp_n_0006",
				"rt_pfCamp_n_0010",
				"rt_pfCamp_n_0005",
			},
			groupB = {
				"rt_pfCamp_n_0001",
				"rt_pfCamp_n_0007",
				"rt_pfCamp_n_0009",
				"rt_pfCamp_n_0004",
			},
			groupC = {
				"rt_pfCamp_n_0003",
				"rt_pfCamp_n_0011",
				"rt_pfCamp_n_0008",
				"rt_pfCamp_n_0002",
			},
		},
		caution = {
			groupConversation = {
				"rts_pfCamp_ene01_d_0000",
			},
			groupSniper = {
				{ "rt_pfCamp_snp_0000", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0001", attr = "SNIPER", },
				{ "rt_pfCamp_snp_0003", attr = "SNIPER", },
			},
			groupA = {
				"rt_pfCamp_c_0000",
				"rt_pfCamp_c_0001",
				"rt_pfCamp_c_0002",
				"rt_pfCamp_c_0003",
				"rt_pfCamp_c_0004",
				"rt_pfCamp_c_0005",
				"rt_pfCamp_c_0006",
				"rt_pfCamp_c_0007",
				"rt_pfCamp_c_0008",
				"rt_pfCamp_c_0009",
				"rt_pfCamp_c_0010",
				"rt_pfCamp_c_0011",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
				"rt_pfCamp_h_0000",
				"rt_pfCamp_h_0001",
				"rt_pfCamp_h_0002",
				"rt_pfCamp_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_pfCamp_s_0000",
				"rt_pfCamp_s_0001",
			},
		},
		travel = {
			lrrpHold = {
				"rt_pfCamp_l_0000",
				"rt_pfCamp_l_0001",
			},
			
			lrrp_pfCampEast_to_pfCamp_rts_escort01 = {
				"rts_v_e_pfCamp_escort01",
			},
			lrrp_pfCampEast_to_pfCamp_rts_escort02 = {
				"rts_v_e_pfCamp_escort02",
			},
			
			lrrp_pfCamp_to_swampSouth_rts_escort01 = {
				"rts_v_s_pfCamp_escort01",
			},
			lrrp_pfCamp_to_swampSouth_rts_escort02 = {
				"rts_v_s_pfCamp_escort02",
			},
			lrrp_pfCamp_to_swampSouth_rts_truck01 = {
				"rts_v_s_pfCamp_truck01",
			},
		},
	},
	
	mafr_05_23_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			
			lrrp_pfCamp_to_swampSouth_rts_escort01 = {
				"rts_v_23to05_0001",
			},
			lrrp_pfCamp_to_swampSouth_rts_escort02 = {
				"rts_v_23to05_0001",
			},
			lrrp_pfCamp_to_swampSouth_rts_truck01 = {
				"rts_v_23to05_0000",
			},
			
			lrrp_escort02_to_swampSouth = {
				"rts_v_escort02_05_0000",
				"rts_v_escort02_05_0000",
				"rts_v_escort02_05_0000",
				"rts_v_escort02_05_0000",
			},
		}
	},
	
	mafr_swampSouth_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			
			lrrp_pfCamp_to_swampSouth_rts_escort01 = {
				"rts_v_e_swampSouth_escort01",
			},
			lrrp_pfCamp_to_swampSouth_rts_escort02 = {
				"rts_v_e_swampSouth_escort02",
			},
			lrrp_pfCamp_to_swampSouth_rts_truck01 = {
				"rts_v_e_swampSouth_truck01",
			},
			
			lrrp_swampSouth_to_swamp_rts_escort01 = {
				"rts_v_s_swampSouth_escort01",
			},
			lrrp_swampSouth_to_swamp_rts_escort02 = {
				"rts_v_s_swampSouth_escort02",
			},
			lrrp_swampSouth_to_swamp_rts_truck01 = {
				"rts_v_s_swampSouth_truck01",
			},
			lrrp_escort02_to_swampSouth = {
				"rts_v_escort02_05_0001",
				"rts_v_escort02_05_0001",
				"rts_v_escort02_05_0001",
				"rts_v_escort02_05_0001",
			},
			lrrp_swampSouth_to_escort03 = {
				"rts_v_s_swampSouth_vehicle01",
				"rts_v_s_swampSouth_vehicle01",
				"rts_v_s_swampSouth_vehicle01",
				"rts_v_s_swampSouth_vehicle01",
			},
		}
	},
	
	mafr_05_22_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			
			lrrp_swampSouth_to_swamp_rts_escort01 = {
				"rts_v_05to22_0000",
			},
			lrrp_swampSouth_to_swamp_rts_escort02 = {
				"rts_v_05to22_0000",
			},
			lrrp_swampSouth_to_swamp_rts_truck01 = {
				"rts_v_05to22_0000",
			},
			lrrp_swampSouth_to_escort03 = {
				"rts_v_05to22_0001",
				"rts_v_05to22_0001",
				"rts_v_05to22_0001",
				"rts_v_05to22_0001",
			},
		}
	},
	
	mafr_swamp_cp 			= {
		priority = {
			"groupConversation",
			"groupZRS",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
			"groupE",
		},
		sneak_day = {
			groupConversation = {
				"rts_swamp_ene01_d_0000",
			},
			groupZRS = {
				"rts_zrs_swamp_ene02_d_0000",
				"rts_zrs_swamp_ene03_d_0000",
			},
			groupA = {
				"rt_swamp_d_0000",
				"rt_SwampNear_d_0000",
				"rt_swamp_d_0007",
				"rt_swamp_d_0011",
			},
			groupB = {
				"rt_swamp_d_0001",
				"rt_SwampNear_d_0001",
				"rt_swamp_d_0008",
				"rt_swamp_d_0012",
			},
			groupC = {
				"rt_swamp_d_0002",
				"rt_SwampNear_d_0002_no_watchtower_sub",
				"rt_swamp_d_0009",
				"rt_SwampNear_d_0004",
			},
			groupD = {
				"rt_swamp_d_0003",
				"rt_swamp_d_0005",
				"rt_swamp_d_0010",
				"rt_swamp_d_0013",
			},
			groupE = {
				"rt_swamp_d_0004",
				"rt_swamp_d_0006",
				"rt_SwampNear_d_0003",
				"rt_swamp_d_0014",
			},
		},
		sneak_night = {
			groupConversation = {
				"rts_swamp_ene01_d_0000",
			},
			groupZRS = {
				"rts_zrs_swamp_ene02_d_0000",
				"rts_zrs_swamp_ene03_d_0000",
			},
			groupA = {
				"rt_swamp_n_0000",
				"rt_SwampNear_n_0000_no_searchlight_sub",
				"rt_swamp_n_0007",
				"rt_swamp_n_0011",
			},
			groupB = {
				"rt_swamp_n_0001_no_searchlight_sub",
				"rt_SwampNear_n_0001_no_searchlight_sub",
				"rt_swamp_n_0008_no_searchlight_sub",
				"rt_swamp_n_0012",
			},
			groupC = {
				"rt_swamp_n_0002",
				"rt_SwampNear_n_0002",
				"rt_swamp_n_0009_no_searchlight_sub",
				"rt_SwampNear_n_0004",
			},
			groupD = {
				"rt_swamp_n_0003_no_searchlight_sub",
				"rt_swamp_n_0005_no_searchlight_sub",
				"rt_swamp_n_0010",
				"rt_swamp_n_0013",
			},
			groupE = {
				"rt_swamp_n_0004",
				"rt_swamp_n_0006",
				"rt_SwampNear_n_0003",
				"rt_swamp_n_0014",
			},
		},
		caution = {
			groupConversation = {
				"rts_swamp_ene01_d_0000",
			},
			groupZRS = {
				"rts_zrs_swamp_ene02_d_0000",
				"rts_zrs_swamp_ene03_d_0000",
			},
			groupA = {
				"rt_swamp_c_0000",
				"rt_swamp_c_0001",
				"rt_swamp_c_0002",
				"rt_swamp_c_0003",
				"rt_swamp_c_0004_searchlight",
				"rt_SwampNear_c_0000",
				"rt_SwampNear_c_0001_searchlight",
				"rt_SwampNear_c_0002",
				"rt_swamp_c_0005",
				"rt_swamp_c_0006",
				"rt_swamp_c_0007",
				"rt_swamp_c_0008",
				"rt_swamp_c_0009",
				"rt_swamp_c_0010",
				"rt_SwampNear_c_0003",
				"rt_SwampNear_c_0004",
				"rt_swamp_c_0000",		
				"rt_swamp_c_0011",
				"rt_swamp_c_0012",
				"rt_swamp_c_0013",
				"rt_swamp_c_0014",
				"rt_swamp_c_0015",
			},
			groupB = {},
			groupC = {},
			groupD = {},
			groupE = {},
		},
		hold = {
			default = {
				"rt_swamp_h_0000",
				"rt_swamp_h_0001",
				"rt_swampNear_h_0000",
				"rt_swamp_h_0002",
				"rt_swampNear_h_0001",
			},
		},
		sleep = {
			default = {
				"rt_swamp_s_0000",
				"rt_swamp_s_0001",
				"rt_swampNear_s_0000",
				"rt_swamp_s_0002",
				"rt_swampNear_s_0001",
			},
		},
		travel = {
			
			lrrp_swampSouth_to_swamp_rts_escort01 = {
				"rts_v_e_swamp_escort01",
			},
			lrrp_swampSouth_to_swamp_rts_escort02 = {
				"rts_v_e_swamp_escort02",
			},
			lrrp_swampSouth_to_swamp_rts_truck01 = {
				"rts_v_e_swamp_truck01",
			},
			
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_s_swamp_escort01",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_s_swamp_escort02",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_s_swamp_truck01",
			},
			
			lrrpHold = {
				"rt_swamp_l_0000",
				"rt_swamp_l_0001",
			},
			lrrpHold01 = {
				"rt_swamp_l_0002",
				"rt_swamp_l_0003",
			},
		},
	},
	
	mafr_02_22_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_22to02_0000",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_22to02_0000",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_22to02_0000",
			},
		}
	},
	
	mafr_swampWest_ob		= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_swampWest_0000",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_swampWest_0000",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_swampWest_0000",
			},
		}
	},
	
	mafr_02_21_lrrp			= {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_02to21_0000",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_02to21_0000",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_02to21_0000",
			},
		}
	},
	
	
	mafr_flowStation_cp = {
		priority = {
			"groupZRS",
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupZRS = {
				"rts_zrs_flowStation_ene01_d_0000",
				"rts_zrs_flowStation_ene02_d_0000",
			},
			groupA = {
				"rt_flowStation_d_0000",
				"rt_flowStation_d_0001",
				"rt_flowStation_d_0002",
				"rt_flowStation_d_0003",
			},
			groupB = {
				"rt_flowStation_d_0004",
				"rt_flowStation_d_0005",
				"rt_flowStation_d_0006",
				"rt_flowStation_d_0007",
			},
			groupC = {
				"rt_flowStation_d_0008",
				"rt_flowStation_d_0009",
				"rt_flowStation_d_0010",
				"rt_flowStation_d_0011",
			},
		},
		sneak_night = {
			groupZRS = {
				"rts_zrs_flowStation_ene01_d_0000",
				"rts_zrs_flowStation_ene02_d_0000",
			},
			groupA = {
				"rt_flowStation_n_0000",
				"rt_flowStation_n_0001",
				"rt_flowStation_n_0002",
				"rt_flowStation_n_0003",
			},
			groupB = {
				"rt_flowStation_n_0004",
				"rt_flowStation_n_0005",
				"rt_flowStation_n_0006",
				"rt_flowStation_n_0007",
			},
			groupC = {
				"rt_flowStation_n_0008",
				"rt_flowStation_n_0009",
				"rt_flowStation_n_0010",
				"rt_flowStation_n_0011",
			},
		},
		caution = {
			groupZRS = {
				"rts_zrs_flowStation_ene01_d_0000",
				"rts_zrs_flowStation_ene02_d_0000",
			},
			groupA = {
				"rt_flowStation_c_0000",
				"rt_flowStation_c_0001",
				"rt_flowStation_c_0002",
				"rt_flowStation_c_0003",
				"rt_flowStation_c_0004",
				"rt_flowStation_c_0005",
				"rt_flowStation_c_0006",
				"rt_flowStation_c_0007",
				"rt_flowStation_c_0008",
				"rt_flowStation_c_0009",
				"rt_flowStation_c_0010",
				"rt_flowStation_c_0011",
				"rt_flowStation_c_0012",
				"rt_flowStation_c_0013",
			},
			groupB = {},
			groupC = {},
		},
		hold = {
			default = {
				"rt_flowStation_h_0000",
				"rt_flowStation_h_0001",
				"rt_flowStation_h_0002",
				"rt_flowStation_h_0003",
			},
		},
		sleep = {
			default = {
				"rt_flowStation_s_0000",
				"rt_flowStation_s_0001",
				"rt_flowStation_s_0002",
				"rt_flowStation_s_0003",
			},
		},
		travel = {
			lrrpHold = {
				"rt_flowStation_l_0000",
				"rt_flowStation_l_0001",
			},
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_flowStation_0000",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_flowStation_0000",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_flowStation_0000",
			},
		},
	},
	
	mafr_01_21_lrrp = {
		priority = {
			"groupA",
		},
		sneak_day = {
			groupA = {
			},
		},
		sneak_night = {
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
			lrrp_01to21 = {
				"rt_01to21_0000",
				"rt_01to21_0000",
			},
			lrrp_21to01 = {
				"rt_21to01_0000",
				"rt_21to01_0000",
			},
			rp_01to21 = {
				"rt_01to21_0000",
				"rt_01to21_0000",
				"rt_01to21_0000",
				"rt_01to21_0000",
			},
			rp_21to01 = {
				"rt_21to01_0000",
				"rt_21to01_0000",
				"rt_21to01_0000",
				"rt_21to01_0000",
			},
			lrrp_swamp_to_transport_rts_escort01 = {
				"rts_v_21to01_0000",
			},
			lrrp_swamp_to_transport_rts_escort02 = {
				"rts_v_21to01_0000",
			},
			lrrp_swamp_to_transport_rts_truck01 = {
				"rts_v_21to01_0000",
			},
		},
		nil
	},
	
	nil
}





this.travelPlans = {
	
	
	
	
	
	
	travel_v_pfCampEast_to_pfCamp_escort01_01 = {
		ONE_WAY = true,
		{ cp = "mafr_pfCampEast_ob", 		routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort01" } },
		{ cp = "mafr_15_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort01_01" } },
		{ cp = "mafr_15_23_lrrp", 			},
	},
	
	travel_v_pfCampEast_to_pfCamp_escort02_01 = {
		ONE_WAY = true,
		{ cp = "mafr_pfCampEast_ob", 		routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort02" } },
		{ cp = "mafr_15_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort02_01" } },
		{ cp = "mafr_15_23_lrrp", 			},
	},
	
	
	travel_v_pfCampEast_to_pfCamp_escort01_02 = {
		ONE_WAY = true,
		{ cp = "mafr_15_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort01_02" } },
		{ cp = "mafr_pfCamp_cp", 			routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort01" } },
		{ cp = "mafr_pfCamp_cp", 			},
	},
	
	travel_v_pfCampEast_to_pfCamp_escort02_02 = {
		ONE_WAY = true,
		{ cp = "mafr_15_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort02_02" } },
		{ cp = "mafr_pfCamp_cp", 			routeGroup={ "travel", "lrrp_pfCampEast_to_pfCamp_rts_escort02" } },
		{ cp = "mafr_pfCamp_cp", 			},
	},
	
	
	travel_v_pfCamp_to_swampSouth_escort01 = {
		ONE_WAY = true,
		{ cp = "mafr_pfCamp_cp", 			routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_escort01" } },
		{ cp = "mafr_05_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_escort01" } },
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_escort01" } },
		{ cp = "mafr_swampSouth_ob", 		},
	},
	travel_v_pfCamp_to_swampSouth_escort02 = {
		ONE_WAY = true,
		{ cp = "mafr_pfCamp_cp", 			routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_escort02" } },
		{ cp = "mafr_05_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_escort02" } },
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_escort02" } },
		{ cp = "mafr_swampSouth_ob", 		},
	},
	travel_v_pfCamp_to_swampSouth_truck01 = {
		ONE_WAY = true,
		{ cp = "mafr_pfCamp_cp", 			routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_truck01" } },
		{ cp = "mafr_05_23_lrrp", 			routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_truck01" } },
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_pfCamp_to_swampSouth_rts_truck01" } },
		{ cp = "mafr_swampSouth_ob", 		},
	},
	
	
	travel_v_swampSouth_to_swamp_escort01 = {
		ONE_WAY = true,
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_escort01" } },
		{ cp = "mafr_05_22_lrrp", 			routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_escort01" } },
		{ cp = "mafr_swamp_cp", 			routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_escort01" } },
		{ cp = "mafr_swamp_cp", 			},
	},
	travel_v_swampSouth_to_swamp_escort02 = {
		ONE_WAY = true,
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_escort02" } },
		{ cp = "mafr_05_22_lrrp", 			routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_escort02" } },
		{ cp = "mafr_swamp_cp", 			routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_escort02" } },
		{ cp = "mafr_swamp_cp", 			},
	},
	travel_v_swampSouth_to_swamp_truck01 = {
		ONE_WAY = true,
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_truck01" } },
		{ cp = "mafr_05_22_lrrp", 			routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_truck01" } },
		{ cp = "mafr_swamp_cp", 			routeGroup={ "travel", "lrrp_swampSouth_to_swamp_rts_truck01" } },
		{ cp = "mafr_swamp_cp", 			},
	},
	
	travel_v_swamp_to_transport_escort01 = {
		ONE_WAY = true,
		{ cp = "mafr_swamp_cp", 			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "mafr_02_22_lrrp", 			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "mafr_swampWest_ob",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "mafr_02_21_lrrp",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "mafr_flowStation_cp",		routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "mafr_01_21_lrrp",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "ms_Transport_ob",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort01" } },
		{ cp = "ms_Transport_ob", 			},
	},
	travel_v_swamp_to_transport_escort02 = {
		ONE_WAY = true,
		{ cp = "mafr_swamp_cp", 			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "mafr_02_22_lrrp", 			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "mafr_swampWest_ob",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "mafr_02_21_lrrp",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "mafr_flowStation_cp",		routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "mafr_01_21_lrrp",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "ms_Transport_ob",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_escort02" } },
		{ cp = "ms_Transport_ob", 			},
	},
	travel_v_swamp_to_transport_truck01 = {
		ONE_WAY = true,
		{ cp = "mafr_swamp_cp", 			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "mafr_02_22_lrrp", 			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "mafr_swampWest_ob",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "mafr_02_21_lrrp",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "mafr_flowStation_cp",		routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "mafr_01_21_lrrp",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "ms_Transport_ob",			routeGroup={ "travel", "lrrp_swamp_to_transport_rts_truck01" } },
		{ cp = "ms_Transport_ob", 			},
	},
	
	
	
	
	travel_v_escort01_to_escort02 = {
		ONE_WAY = true,
		{ cp = "ms_escort01_ob", 			routeGroup={ "travel", "lrrp_escort01_to_escort02" } },
		{ cp = "ms_05_23_lrrp", 			routeGroup={ "travel", "lrrp_escort01_to_escort02" } },
		{ cp = "ms_escort02_ob", 			routeGroup={ "travel", "lrrp_escort01_to_escort02" } },
	},
	
	travel_v_escort02_to_swampSouth = {
		ONE_WAY = true,
		{ cp = "ms_escort02_ob", 			routeGroup={ "travel", "lrrp_escort02_to_swampSouth" } },
		{ cp = "mafr_05_23_lrrp", 			routeGroup={ "travel", "lrrp_escort02_to_swampSouth" } },
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_escort02_to_swampSouth" } },
		{ cp = "mafr_swampSouth_ob", 		},
	},
	
	travel_v_swampSouth_to_escort03 = {
		ONE_WAY = true,
		{ cp = "mafr_swampSouth_ob", 		routeGroup={ "travel", "lrrp_swampSouth_to_escort03" } },
		{ cp = "mafr_05_22_lrrp", 			routeGroup={ "travel", "lrrp_swampSouth_to_escort03" } },
		{ cp = "ms_escort03_ob", 			routeGroup={ "travel", "lrrp_swampSouth_to_escort03" } },
		{ cp = "ms_escort03_ob", 			},
	},
	
	
	
	
	travel_lrrp_01 = {
		{ cp = "mafr_02_21_lrrp", 			routeGroup = { "travel", "lrrp_21to02"	}	},
		{ cp = "mafr_swampWest_ob", 		routeGroup = { "travel", "lrrpHold"		}	},
		{ cp = "mafr_02_22_lrrp", 			routeGroup = { "travel", "lrrp_02to22"	}	},
		{ cp = "mafr_swamp_cp",		 		routeGroup = { "travel", "lrrpHold01"	}	},
		{ cp = "mafr_02_22_lrrp",		 	routeGroup = { "travel", "lrrp_22to02"	}	},
		{ cp = "mafr_swampWest_ob",		 	routeGroup = { "travel", "lrrpHold"		}	},
		{ cp = "mafr_02_21_lrrp",		 	routeGroup = { "travel", "lrrp_02to21"	}	},
		{ cp = "mafr_flowStation_cp",	 	routeGroup = { "travel", "lrrpHold"		}	},
	},
	travel_lrrp_03 = {
		{ cp = "mafr_13_15_lrrp", 			routeGroup = { "travel", "lrrp_15to13"	}	},
		{ cp = "mafr_savannahEast_ob", 		routeGroup = { "travel", "lrrpHold"		}	},
		{ cp = "mafr_13_24_lrrp", 			routeGroup = { "travel", "lrrp_13to24"	}	},
		{ cp = "mafr_savannah_cp", 			routeGroup = { "travel", "lrrpHold"		}	},
		{ cp = "mafr_16_24_lrrp", 			routeGroup = { "travel", "lrrp_24to16"	}	},
		{ cp = "mafr_pfCampNorth_ob", 		routeGroup = { "travel", "lrrpHold"		}	},
		{ cp = "mafr_15_16_lrrp", 			routeGroup = { "travel", "lrrp_16to15"	}	},
		{ cp = "mafr_pfCampEast_ob", 		routeGroup = { "travel", "lrrpHold"		}	},
	},
}






this.cpGroups = {
	group_Area2 = {
		
		this.CP_NAME.ESCROT_OB_01,		
		this.CP_NAME.ESCROT_OB_02,		
		this.CP_NAME.ESCROT_OB_03,		
		this.CP_NAME.ESCROT_LRRP,		
		this.CP_NAME.TRANSPORT_OB,		
		
		"mafr_01_21_lrrp",
	},
}





this.combatSetting = {
	
	ms_escort01_ob = {
		"gt_escort01_0000",
	},
	ms_escort02_ob = {
		"gt_escort02_0000",
	},
	ms_escort03_ob = {
		"gt_escort03_0000",
	},
	ms_Transport_ob = {
		"gt_Transport_0000",
	},
	
	mafr_savannah_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_pfCamp_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swamp_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_flowStation_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_pfCampNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_pfCampEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swampSouth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swampEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swampWest_ob = {
		USE_COMMON_COMBAT = true,
	},
}









this.InterCall_common = function( soldier2GameObjectId, cpID, interName )
	
end

this.InterCall_pfCampNorth01 = function( soldier2GameObjectId, cpID, interName )
	
	svars.highInterrogationIndex = svars.highInterrogationIndex + 1
	
	this.SetHighInterrogationOb()
	
	TppMission.UpdateObjective{
		objectives = { "area_Intel_pfCampNorth", },
	}
end

this.InterCall_pfCampNorth02 = function( soldier2GameObjectId, cpID, interName )
	
	svars.highInterrogationIndex = svars.highInterrogationIndex + 1
	
	this.SetHighInterrogationOb()
end

this.InterCall_pfCampNorth03 = function( soldier2GameObjectId, cpID, interName )
	
	svars.highInterrogationIndex = svars.highInterrogationIndex + 1
	
	this.SetHighInterrogationOb()
	
	TppMission.UpdateObjective{
		objectives = { "area_Interrogation_pfCamp", },
	}
end


this.highInterrogationTable = {
	
	groupA = {
		{ name = "enqt1000_094531", func = this.InterCall_common },
		{ name = "enqt1000_094528", func = this.InterCall_common },
		{ name = "enqt1000_094525", func = this.InterCall_common },
	},
	
	groupB = {
		{ name = "enqt1000_094538", func = this.InterCall_pfCampNorth01 },
		{ name = "enqt1000_094535", func = this.InterCall_pfCampNorth02 },
		{ name = "enqt1000_094534", func = this.InterCall_pfCampNorth03 },
	},
}


this.interrogation = {
	
	mafr_savannah_cp = {
		
		high = {
			this.highInterrogationTable.groupA[1],
			this.highInterrogationTable.groupA[2],
			this.highInterrogationTable.groupA[3],
		},
		
		normal = {
			nil
		},
		nil
	},
	mafr_pfCamp_cp = {
		
		high = {
	
	
	
		},
		
		normal = {
			nil
		},
		nil
	},
	mafr_swamp_cp = {
		
		high = {
			this.highInterrogationTable.groupA[1],
			this.highInterrogationTable.groupA[2],
			this.highInterrogationTable.groupA[3],
		},
		
		normal = {
			nil
		},
		nil
	},
	mafr_flowStation_cp = {
		
		high = {
			this.highInterrogationTable.groupA[1],
			this.highInterrogationTable.groupA[2],
			this.highInterrogationTable.groupA[3],
		},
		
		normal = {
			nil
		},
		nil
	},
	
	mafr_pfCampNorth_ob = {
		
		high = {
			this.highInterrogationTable.groupB[1],
			this.highInterrogationTable.groupB[2],
			this.highInterrogationTable.groupB[3],
		},
		
		normal = {
			nil
		},
		nil
	},
	
	nil
}


this.useGeneInter = {
	
	mafr_savannah_cp			= true,
	mafr_pfCamp_cp				= true,
	mafr_swamp_cp				= true,
	mafr_flowStation_cp			= true,
	
	mafr_savannahEast_ob		= true,
	mafr_pfCampNorth_ob			= true,
	mafr_pfCampEast_ob			= true,
	mafr_swampSouth_ob			= true,
	mafr_swampEast_ob			= true,
	mafr_swampWest_ob			= true,
	
	mafr_01_21_lrrp				= true,
	mafr_02_21_lrrp				= true,
	mafr_02_22_lrrp				= true,
	mafr_05_16_lrrp				= true,
	mafr_05_22_lrrp				= true,
	mafr_05_23_lrrp				= true,
	mafr_06_16_lrrp				= true,
	mafr_06_22_lrrp				= true,
	mafr_06_24_lrrp				= true,
	mafr_13_15_lrrp				= true,
	mafr_13_16_lrrp				= true,
	mafr_13_24_lrrp				= true,
	mafr_15_16_lrrp				= true,
	mafr_16_23_lrrp				= true,
	mafr_16_24_lrrp				= true,
}


this.SetHighInterrogationCp = function()
	local cpNameTable = {
		{
			cpName = "mafr_pfCamp_cp",
			eventSequenceIndexMin = s10090_sequence.ENUM_EVENT_VEHICLE_SEQUENCE.ENTER_PFCAMP,
			eventSequenceIndexMax = s10090_sequence.ENUM_EVENT_VEHICLE_SEQUENCE.EXIT_PFCAMP,
		},
		{
			cpName = "mafr_swamp_cp",
			eventSequenceIndexMin = s10090_sequence.ENUM_EVENT_VEHICLE_SEQUENCE.ENTER_SWAMP,
			eventSequenceIndexMax = s10090_sequence.ENUM_EVENT_VEHICLE_SEQUENCE.EXIT_SWAMP,
		},
		{	cpName = "mafr_flowStation_cp",
			eventSequenceIndexMin = s10090_sequence.ENUM_EVENT_VEHICLE_SEQUENCE.ENTER_FLOWSTATION,
			eventSequenceIndexMax = s10090_sequence.ENUM_EVENT_VEHICLE_SEQUENCE.EXIT_FLOWSTATION,
		},
	}
	if svars.eventSequenceIndex >= mvars.interEventSequenceIndex then
		mvars.interEventSequenceIndex = svars.eventSequenceIndex
		for i, params in ipairs( cpNameTable ) do
			local gameObjectId = GameObject.GetGameObjectId( params.cpName )
			if gameObjectId == NULL_ID then
				Fox.Error("Cannot get gameObjectId. cpName = " .. tostring(params.cpName) )
			else
				local interrogationTable = nil
				local eventSequenceIndex = svars.eventSequenceIndex
				
				TppInterrogation.ResetFlagHigh( gameObjectId )
				
				if eventSequenceIndex < params.eventSequenceIndexMin then
					interrogationTable = {}
					table.insert( interrogationTable, this.highInterrogationTable.groupA[1] )
				elseif eventSequenceIndex >= params.eventSequenceIndexMin and eventSequenceIndex < params.eventSequenceIndexMax then
					interrogationTable = {}
					table.insert( interrogationTable, this.highInterrogationTable.groupA[2] )
				elseif eventSequenceIndex >= params.eventSequenceIndexMax then
					interrogationTable = {}
					table.insert( interrogationTable, this.highInterrogationTable.groupA[3] )
				end
				if interrogationTable ~= nil then
					TppInterrogation.AddHighInterrogation( gameObjectId, interrogationTable )
				end
			end
		end
	end
end


this.SetHighInterrogationOb = function()
	Fox.Log("*** HighInterrogation ***")
	local gameObjectId = GameObject.GetGameObjectId( "mafr_pfCampNorth_ob" )
	if gameObjectId == NULL_ID then
		Fox.Error("Cannot get gameObjectId. cpName = " .. tostring(params.cpName) )
	else
		local interrogationTable = nil
		
		TppInterrogation.ResetFlagHigh( gameObjectId )
		
		if svars.highInterrogationIndex == 0 then
			interrogationTable = {}
			table.insert( interrogationTable, this.highInterrogationTable.groupB[1] )
		elseif svars.highInterrogationIndex == 1 then
			interrogationTable = {}
			table.insert( interrogationTable, this.highInterrogationTable.groupB[2] )
		elseif svars.highInterrogationIndex == 2 then
			interrogationTable = {}
			table.insert( interrogationTable, this.highInterrogationTable.groupB[3] )
		end
		if interrogationTable ~= nil then
			TppInterrogation.AddHighInterrogation( gameObjectId, interrogationTable )
		end
	end
end






this.SpawnVehicleOnInitialize = function()
	
	local missionName = TppMission.GetMissionName()
	
	if missionName == "s10090" then
		TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST_NORMAL )
	elseif missionName == "s11090" then
		TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST_HARD )
	else
		Fox.Error( "Mission ID s10090 & s11090 Only" )
	end
end


this.InitEnemy = function()
	
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_pfCamp_cp",		"groupConversation" )
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_swamp_cp",		"groupConversation" )
	
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_pfCamp_cp",		"groupSniper" )
	
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_swamp_cp",		"groupZRS" )
	TppEnemy.NoShifhtChangeGruopSetting( "mafr_flowStation_cp", "groupZRS" )
end


this.SetUpEnemy = function()
	
	if svars.isMissionStart == false then
		
		s10090_sequence.OnCommonFunc{ messageId = StrCode32( s10090_sequence.COMMON_MESSAGE_LIST.E_INIT ) }
		s10090_sequence.OnCommonFunc{ messageId = StrCode32( s10090_sequence.COMMON_MESSAGE_LIST.E_INIT_PFCAMPEAST ) }
		if DEBUG then
			
			this.DebugSetMissionStartPosition()
		end
	end
	
	s10090_sequence.OnCommonFunc{ messageId = StrCode32( s10090_sequence.COMMON_MESSAGE_LIST.E_INIT_MESSAGE ) }
	
	TppEnemy.SetRescueTargets{ this.VEHICLE_NAME.TRUCK_TARGET }
	
	TppEnemy.UnRealizeParasiteSquad()
	
	TppEnemy.RegisterCombatSetting( this.combatSetting )
	
	this.SetHighInterrogationCp()
	
	this.SetHighInterrogationOb()
	
	TppEnemy.InitialRouteSetGroup{ cpName = "mafr_pfCamp_cp",		soldierList = { "sol_pfCamp_0000" }, 														groupName = "groupConversation" }
	TppEnemy.InitialRouteSetGroup{ cpName = "mafr_swamp_cp",		soldierList = { "sol_swamp_0000" }, 														groupName = "groupConversation" }
	
	TppEnemy.InitialRouteSetGroup{ cpName = "mafr_pfCamp_cp",		soldierList = { "sol_pfCamp_0001", "sol_pfCamp_0002", "sol_pfCamp_0003" }, 					groupName = "groupSniper" }
	
	TppEnemy.InitialRouteSetGroup{ cpName = "mafr_swamp_cp",		soldierList = { this.ENEMY_NAME.ZRS_SWAMP01,		this.ENEMY_NAME.ZRS_SWAMP02 },			groupName = "groupZRS" }
	TppEnemy.InitialRouteSetGroup{ cpName = "mafr_flowStation_cp",	soldierList = { this.ENEMY_NAME.ZRS_FLOWSTATION01,	this.ENEMY_NAME.ZRS_FLOWSTATION02 },	groupName = "groupZRS" }
	
	this.SetRequestToObserve( this.VEHICLE_NAME.TRUCK_TARGET )
	
	for i, gameObjectName in pairs( this.ENEMY_NAME ) do
		TppEnemy.RegistHoldRecoveredState( gameObjectName )
	end
end


this.OnLoad = function()
	
end






this.SetKeepAlert = function( enable )
	local gameObjectId	= { type="TppCommandPost2", index = 0 }
	local command		= { id = "SetKeepAlert", enable = enable }
	GameObject.SendCommand( gameObjectId, command )
end






this.GetGameObjectIdUsingRoute = function( routeName )
	local soldiers = GameObject.SendCommand( { type = "TppSoldier2" }, { id = "GetGameObjectIdUsingRoute", route = routeName } )
	return soldiers
end


this.GetGameObjectIdUsingRouteTable = function( routeNameTable )
	if not IsTypeTable( routeNameTable ) then
		routeNameTable = { routeNameTable }
	end
	for i, routeName in ipairs( routeNameTable ) do
		local soldiers = this.GetGameObjectIdUsingRoute( routeName )
		for i, soldier in ipairs( soldiers ) do
			return soldier
		end
	end
	return nil
end


this.GetStatus = function( enemyName )
	
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	
	local isValue = false
	local lifeState = GameObject.SendCommand( enemyName, { id = "GetLifeStatus" } )
	
	if lifeState == TppGameObject.NPC_LIFE_STATE_NORMAL then
		isValue = true
	end
	
	return isValue
end


this.GetLifeStatus = function( enemyName )
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	
	local lifeState = GameObject.SendCommand( enemyName, { id = "GetLifeStatus" } )
	
	return lifeState
end


this.SetEnemyMessage = function( enemyName, messageName, isRegistered )
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	if enemyName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(enemyName) )
		return
	end
	if messageName == nil then
		return
	end
	local command = { id = "RegisterMessage", message = messageName, isRegistered = isRegistered }
	GameObject.SendCommand( enemyName, command )
end



this.SetEnemyState = function( paramList )
	for key, param in pairs( paramList ) do
		if param.gameObjectName then
			local gameObjectId = param.gameObjectName
			if IsTypeString( gameObjectId ) then
				gameObjectId = GetGameObjectId( gameObjectId )
			end
			if gameObjectId == NULL_ID then
				Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(param.gameObjectName) )
			end
			
			if param.routeName then
				local nodeNum = param.nodeNum or 0
				TppEnemy.SetSneakRoute( gameObjectId, param.routeName, nodeNum )
			end
			
			if param.enable then
				if param.enable == false then
					TppEnemy.SetDisable( gameObjectId )
				else
					TppEnemy.SetEnable( gameObjectId )
				end
			end
			
			if param.noDamage then
				local command
				if param.noDamage == false then
					command = { id = "SetDisableDamage", life = false, faint = false, sleep = false }
				else
					command = { id = "SetDisableDamage", life = true, faint = true, sleep = true }
				end
				GameObject.SendCommand( gameObjectId, command )
			end
		end
	end
end


this.IsZRS = function( gameObjectId )
	if IsTypeString( gameObjectId ) then
		gameObjectId = GetGameObjectId( gameObjectId )
	end
	if gameObjectId == NULL_ID then
		Fox.Error("Cannot get gameObjectId. gameObjectId = " .. tostring(gameObjectId) )
		return
	end
	for i, enemyName in pairs( this.ENEMY_NAME ) do
		if IsTypeString( enemyName ) then
			enemyName = GetGameObjectId( enemyName )
		end
		if enemyName == NULL_ID then
			Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(enemyName) )
			return
		end
		if gameObjectId == enemyName then
			return true, gameObjectId
		end
	end
	return false, nil
end


this.IsDirver = function( gameObjectId )
	if IsTypeString( gameObjectId ) then
		gameObjectId = GetGameObjectId( gameObjectId )
	end
	if gameObjectId == NULL_ID then
		Fox.Error("Cannot get gameObjectId. gameObjectId = " .. tostring(gameObjectId) )
		return
	end
	local vehicleGameObjectId = GameObject.SendCommand( gameObjectId, { id="GetVehicleGameObjectId" } )
	if vehicleGameObjectId ~= NULL_ID then
		return true
	end
	return false
end






this.IsVehicleStateFulton = function( vehicleName )
	
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	
	if vehicleName == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. vehicleName )
		return nil, nil
	end
	
 	local stateFlags = GameObject.SendCommand( vehicleName, { id = "GetState", } )
	
	if bit.band( stateFlags, Vehicle.state.CAN_FULTON ) == Vehicle.state.CAN_FULTON then
		return true
	end
	
	return false
	
end


this.IsVehicleStateSpeedDown = function( vehicleName )
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	
	if vehicleName == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. vehicleName )
		return nil, nil
	end
	
 	local stateFlags = GameObject.SendCommand( vehicleName, { id = "GetState", } )
	
	if bit.band( stateFlags, Vehicle.state.SPEED_DOWN ) == Vehicle.state.SPEED_DOWN then
		return true
	end
	
	return false
	
end


this.GetVehicleGameObjectName = function( s_gameObjectId )
	for i, gameObjectName in pairs( this.VEHICLE_NAME ) do
		local gameObjectId = GetGameObjectId( gameObjectName )
		if s_gameObjectId == gameObjectId then
			return gameObjectName
		end
	end
end



this.GetVehiclePosition = function( vehicleName )
	local position = nil
	
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	
	if vehicleName == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. vehicleName )
		return position
	end
	
	position = GameObject.SendCommand( vehicleName, { id = "GetPosition", } )
	
	return position
end


this.GetVehicleRiderId = function( vehicleName )
	
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	
	if vehicleName == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. vehicleName )
		return nil, nil
	end
	
	local riderIdArray = GameObject.SendCommand( vehicleName, { id="GetRiderId", } )
	
	return riderIdArray
	
end


this.GetVehicleRiderCount = function( vehicleName )
	
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	
	if vehicleName == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. vehicleName )
		return nil, nil
	end
	
	local riderIdArray	= GameObject.SendCommand( vehicleName, { id="GetRiderId", } )
	local riderCount	= 0
	
	if riderIdArray == nil then
		return 0
	end
	
	for seatIndex,riderId in ipairs( riderIdArray ) do
		if riderId ~= GameObject.NULL_ID then
			riderCount = riderCount + 1 
		end
	end
	
	return riderCount
end


this.GetVehicleRiderIdTable = function( VehicleNameTable )
	local enemyIdTable = {}
	for i, vehicleName in pairs( VehicleNameTable ) do
		if not s10090_sequence.GetVehicleValue( s10090_sequence.ENUM_VEHICLE_VALUE_TYPE.PRESENCE, vehicleName ) then
			local riderIdArray	= this.GetVehicleRiderId( vehicleName )
			local riderCount	= this.GetVehicleRiderCount( vehicleName )
			if riderCount > 0 then
				for seatIndex, riderId in ipairs( riderIdArray ) do
					if riderId ~= GameObject.NULL_ID then
						table.insert( enemyIdTable, riderId )
					end
				end
			end
		end
	end
	return enemyIdTable
end


this.SetVehicleState = function( paramList )
	for key, param in pairs( paramList )  do
		local gameObjectId = param.gameObjectName
		if IsTypeString( gameObjectId ) then
			gameObjectId = GetGameObjectId( gameObjectId )
		end
		if gameObjectId == NULL_ID then
			Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. param.gameObjectName )
			return
		end
		GameObject.SendCommand( gameObjectId, { id  = "SetPosition", position = param.pos, rotY = param.rotY, } )
	end
end



this.SetVehicleLife = function( vehicleName, life )
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	
	if vehicleName == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. vehicleName )
	end
	
	GameObject.SendCommand( vehicleName, { id = "SetBodyLife", life = life } )
end


this.SetRelativeVehicle = function( enemyName, vehicleName, isrideFromBeginning, isVigilance )
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	if enemyName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(enemyName) )
		return
	end
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	if vehicleName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. vehicleName = " .. tostring(vehicleName) )
		return
	end
	isVigilance = isVigilance or false
	if isrideFromBeginning then
		GameObject.SendCommand( enemyName, { id = "SetRelativeVehicle", targetId = vehicleName, rideFromBeginning = isrideFromBeginning, isVigilance = isVigilance } )
	else
		GameObject.SendCommand( enemyName, { id = "SetRelativeVehicle", targetId = vehicleName, isVigilance = isVigilance } )
	end
end



this.SetRequestToObserve = function( vehicleName )
	if IsTypeString( vehicleName ) then
		vehicleName = GetGameObjectId( vehicleName )
	end
	if vehicleName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. vehicleName = " .. tostring(vehicleName) )
		return
	end
	local command = { id="RequestToObserve", observation=bit.bor( Vehicle.observation.PLAYER_WILL_HARM_VEHICLE, Vehicle.observation.PLAYER_WILL_BREAK_VEHICLE, Vehicle.observation.PLAYER_STOPS_VEHICLE_BY_BREAKING_WHEELS ), }
	GameObject.SendCommand( vehicleName, command )
end






function this.SetAppearParasites()
	
	this.SetAreaCombatEnabled( true )
	
	GameObject.SendCommand({type="TppParasite2"}, { id="SetDeterrentEnabled", enabled=true })
	

	
	this.SetCorrodeActionEnabled( false )
	
	this.SetGuardTargetId( this.VEHICLE_NAME.TRUCK_TARGET )
	
	this.SetParameters()
	
	this.SetParasitesFog( true )
	
	this.SetKeepAlert( true )
	
	for i, enemyIdTable in pairs( this.soldierDefine ) do
		this.SetTableZombie{ 
							enemyIdTable = enemyIdTable,
							enabled = true,
							isFixedPointCombat = true,
							noZombieVehicleNameTable = { this.VEHICLE_NAME.WEST_WAV01, this.VEHICLE_NAME.WEST_WAV02, },
							}
	end
end


function this.SetExitParasites()
	
	this.SetParasiteStartExit()
	
	this.SetAreaCombatEnabled( false )
	
	this.SetDeterrentVehicleEnabled( false )
	
	this.SetParasitesFog( false )
	
	this.SetKeepAlert( false )
	
	for i, enemyIdTable in pairs( this.soldierDefine ) do
		this.SetTableZombie{ 
							enemyIdTable = enemyIdTable,
							enabled = false,
							isFixedPointCombat = false,
							noZombieVehicleNameTable = { this.VEHICLE_NAME.WEST_WAV01, this.VEHICLE_NAME.WEST_WAV02, },
							}
	end
end


this.SetParasiteStartPos = function( pos )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	pos = pos or Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ )
	GameObject.SendCommand( { type = "TppParasite2", }, { id = "StartAppearance",	position = pos, radius = 10 } )
end


this.StartGuard = function()
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	GameObject.SendCommand( { type = "TppParasite2", }, { id = "StartGuard", } )
end


this.StartSearch = function()
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	GameObject.SendCommand( { type = "TppParasite2", }, { id = "StartSearch", } )
end


this.SetParasiteStartExit = function()
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	GameObject.SendCommand( { type = "TppParasite2", }, { id = "StartWithdrawal", } )
end


this.SetCorrodeActionEnabled = function( param )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	GameObject.SendCommand( { type="TppParasite2" }, { id="SetCorrodeActionEnabled", enabled = param } ) 
end


this.SetAreaCombatEnabled = function( param )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	GameObject.SendCommand( { type="TppParasite2" }, { id="SetAreaCombatEnabled", enabled = param } ) 
end


this.SetDeterrentVehicleEnabled = function( param )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	GameObject.SendCommand( { type="TppParasite2" }, { id="SetDeterrentVehicleEnabled", enabled = param } ) 
end



this.SetGuardTargetId = function( gameObjectId )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	if IsTypeString( gameObjectId ) then
		gameObjectId = GetGameObjectId( gameObjectId )
	end
	
	if gameObjectId == NULL_ID then
		Fox.Error( "Cannot get gameObjectId. gameObjectName = " .. gameObjectId )
	end
	GameObject.SendCommand( { type="TppParasite2" }, { id="SetGuardTargetId", targetId = gameObjectId } )
end


this.SetParameters = function()
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	if this.DEBUG_ON_PARASITES_PARAMETERS == false then
		return
	end
	local missionName = TppMission.GetMissionName()
	local params_N = this.PARASITES_PARAMETERS_LIST_NORMAL		
	local params_E = this.PARASITES_PARAMETERS_LIST_EXSTREME	
	
	if		missionName == "s10090"	then
		GameObject.SendCommand( { type="TppParasite2" }, { id="SetParameters", params = params_N } )
	elseif	missionName == "s11090"	then
		GameObject.SendCommand( { type="TppParasite2" }, { id="SetParameters", params = params_E } )
	else
		
		GameObject.SendCommand( { type="TppParasite2" }, { id="SetParameters", params = params_N } )
	end
end


this.SetParasitesFog = function( param )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	param = param or false
	if param == false then
		TppWeather.CancelRequestWeather( TppDefine.WEATHER.SUNNY, 3 )
	else
		TppWeather.RequestWeather( TppDefine.WEATHER.FOGGY, 0, { fogDensity = 0.010 } )
	end
end


this.SetZombie = function( enemyName, enabled )
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	if not Tpp.IsSoldier( enemyName ) then
		return
	end
	if enemyName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring(enemyName) )
		return
	end
	GameObject.SendCommand( enemyName, { id = "SetZombie", enabled = enabled, isZombieSkin=true } )
end


this.SetTableZombie = function( params )
	if params.enemyIdTable == nil then
		return
	end
	local rideEnemyIdTable = {}
	local enabled =  params.enabled or false
	
	
	if params.noZombieVehicleNameTable then
		rideEnemyIdTable = this.GetVehicleRiderIdTable( params.noZombieVehicleNameTable )
	end
	
	local isNoZombieSucces = false

	for i, enemyName in pairs( params.enemyIdTable ) do
		if params.noZombieVehicleNameTable then
			isNoZombieSucces = false
			for j, enemyId in pairs( rideEnemyIdTable ) do
				if IsTypeString( enemyName ) then
					enemyName = GetGameObjectId( enemyName )
				end
				if enemyName == enemyId then
					isNoZombieSucces = true
				end
			end
			
			if isNoZombieSucces == false then
				this.SetZombie( enemyName, enabled )
			
			else
				if params.isFixedPointCombat == true then
					this.SetFixedPointCombatEnemy( enemyName, enabled )
				end
			end
		else
			if IsTypeString( enemyName ) then
				enemyName = GetGameObjectId( enemyName )
			end
			this.SetZombie( enemyName, enabled )
		end
	end
	
end


this.IsParasites = function( s_gameObjectId )
	if not IsTypeTable( mvars.ene_parasiteSquadList ) then
		Fox.Error( "Cannot No Data mvars.ene_parasiteSquadList")
		return
	end
	
	for i,gameObjectName in pairs( mvars.ene_parasiteSquadList ) do
		local gameObjectId = GetGameObjectId( gameObjectName )
		if s_gameObjectId == gameObjectId then
			return true
		end
	end
end






this.SetFixedPointCombatVehicle = function( vehicleNameTable, enabled )
	local enemyIdTable = this.GetVehicleRiderIdTable( vehicleNameTable )
	for i, enemyName in pairs( enemyIdTable ) do
		this.SetFixedPointCombatEnemy( enemyName, enabled )
	end
end


this.SetFixedPointCombatEnemy = function( enemyName, enabled )
	if IsTypeString( enemyName ) then
		enemyName = GetGameObjectId( enemyName )
	end
	if enemyName == NULL_ID then
		Fox.Error("Cannot get gameObjectId. enemyName = " .. tostring( enemyName ) )
		return
	end
	local command = {}
	if enabled == true then
		command = { id="SetCommandAi", commandType = CommandAi.FORCE_WAIT }
	else
		command = { id="RemoveCommandAi" }
	end
	GameObject.SendCommand( enemyName, command )
end






this.RouteCallConversation = function( speakerRouteNameTable, friendRouteNameTable, speechLabel, isMonologue )
	
	local speakerGameObjectId	= this.GetGameObjectIdUsingRouteTable( speakerRouteNameTable )
	local friendGameObjectId	= this.GetGameObjectIdUsingRouteTable( friendRouteNameTable )
	if isMonologue == true then
		if speakerGameObjectId == nil then
			return
		end
		
		friendGameObjectId = speakerGameObjectId
	else
		if speakerGameObjectId == nil or friendGameObjectId == nil then
			return
		end
	end
	
	this.CallConversation( speakerGameObjectId, friendGameObjectId, speechLabel )
end


this.CallConversation = function( speakerGameObjectId, friendGameObjectId, speechLabel )
	if Tpp.IsTypeString( speakerGameObjectId ) then
		speakerGameObjectId = GetGameObjectId( speakerGameObjectId )
	end
	if Tpp.IsTypeString( friendGameObjectId ) then
		friendGameObjectId = GetGameObjectId( friendGameObjectId )
	end
	local command = { id = "CallConversation", label = speechLabel, friend = friendGameObjectId, }
	GameObject.SendCommand( speakerGameObjectId, command )
end


this.RouteCallRadio = function( speakerRouteNameTable, speechLabel, stance )
	
	local speakerGameObjectId	= this.GetGameObjectIdUsingRouteTable( speakerRouteNameTable )
	
	this.CallRadio( speakerGameObjectId, speechLabel, stance )
end


this.CallRadio = function( speakerGameObjectId, speechLabel, stance )
	if Tpp.IsTypeString( speakerGameObjectId ) then
		speakerGameObjectId = GetGameObjectId( speakerGameObjectId )
	end
	local command
	if stance == nil then
		command = { id = "CallRadio", label = speechLabel , voiceType="ene_c" }
	else
		command = { id = "CallRadio", label = speechLabel, stance = stance , voiceType="ene_c" }
	end
	GameObject.SendCommand( speakerGameObjectId, command )
end





if DEBUG then


this.DebugSetMissionStartPosition = function()
	if TppMission.IsMissionStart() then
		local settingTable = nil
		if svars.isDbgMissionStartIndex > 0 then
			settingTable = s10090_sequence.dbgMissionStartSettingTable[svars.isDbgMissionStartIndex]
		end
		if settingTable ~= nil then
			
			if settingTable.enemy ~= nil then 
				this.SetEnemyState( settingTable.enemy )
			end
			
			if settingTable.vehicle ~= nil then 
				this.SetVehicleState( settingTable.vehicle )
			end
			
			if settingTable.func ~= nil then 
				for key, param in ipairs( settingTable.func ) do
					param.func()
				end
			end
		end
	end
end

end




return this
