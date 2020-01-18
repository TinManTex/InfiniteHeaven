local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}





this.USE_COMMON_REINFORCE_PLAN = true






this.EVENT_SEQUENCE = Tpp.Enum{
	
	"REMNANTS_CONVERSATION_START",
	"REMNANTS_TURNAROUND_HOSTAGE",
	"REMNANTS_MONOLOGUE_TO_HOSTAGE",

	"REMNANTS_VEHICLE_START",
	
	"REMNANTSNORTH_VEHICLE_ARRIVED",
	"REMNANTSNORTH_CONVERSATION_START",
	"REMNANTSNORTH_CONVERSATION_STOP",
	"REMNANTSNORTH_MONOLOGUE_FRIEND",
	"REMNANTSNORTH_CONVERSATION_RESTART_1",
	
	"REMNANTSNORTH_CONVERSATION_RESTART_2",

	"REMNANTSNORTH_CONVERSATION_LAST",
	"REMNANTSNORTH_GOTO_VEHICLE",
	"REMNANTSNORTH_MONOLOGUE_TO_HOSTAGE",
	"REMNANTSNORTH_VEHICLE_START",
	
	"BETWEEN_A_VEHICLE_ARRIVED",
	"BETWEEN_A_MONOLOGUE_START",
	"BETWEEN_A_FRIEND_ACT_MOVE",

	"BETWEEN_A_FRIEND_ACT_FIRE_1",
	"BETWEEN_A_MONOLOGUE_FRIEND",
	
	"BETWEEN_A_FRIEND_ACT_FIRE_2",
	"BETWEEN_A_MONOLOGUE_LAST",
	"BETWEEN_A_GOTO_VEHICLE",
	"BETWEEN_A_MONOLOGUE_TO_HOSTAGE",
	"BETWEEN_A_VEHICLE_START",
	
	"BETWEEN_B_VEHICLE_ARRIVED",
	"BETWEEN_B_CONVERSATION_START",
	"BETWEEN_B_MONOLOGUE_FRIEND",
	"BETWEEN_B_GOTO_VEHICLE",
	"BETWEEN_B_MONOLOGUE_TO_HOSTAGE",
	
	"BETWEEN_B_VEHICLE_START",
	
	"TENT_VEHICLE_ARRIVED",
	"TENT_CONVERSATION_START",
	"TENT_TURNAROUND_HOSTAGE",
	"TENT_GOTO_TORTURE_ROOM",
	"TENT_MONOLOGUE_TO_HOSTAGE",
	"TENT_JOIN_SHIFT",
	"TENT_TRANSPORT_COMPLETE",
	
}


this.TALK_SEQUENCE = Tpp.Enum{
	
	"REMNANTS_CONVERSATION_ABOUT_ORDERS",		
	"REMNANTS_MONOLOGUE_TO_MALAK",				
	
	"REMNANTSNORTH_CONVERSATION_ABOUT_MALAK",	
	"REMNANTSNORTH_MONOLOGUE_IS_SOMEONE_THERE",	
	"REMNANTSNORTH_CONVERSATION_DONT_SCARE_ME",	
	"REMNANTSNORTH_CONVERSATION_ABOUT_RUMORS",	
	"REMNANTSNORTH_MONOLOGUE_TO_MALAK",			
	
	"BETWEEN_A_MONOLOGUE_TO_FRIEND",			
	"BETWEEN_A_MONOLOGUE_TO_ANIMALS",			
	"BETWEEN_A_MONOLOGUE_GET_BACK_VEHICLES",	
	
	"BETWEEN_A_MONOLOGUE_TO_MALAK",				
	
	"BETWEEN_B_CONVERSATION_ABOUT_VILLAGE",		
	"BETWEEN_B_MONOLOGUE_ABOUT_MALAK",			
	"BETWEEN_B_MONOLOGUE_TO_MALAK",				
	
	"TENT_CONVERSATION_ABOUT_DESTINATION",		
	"TENT_MONOLOGUE_TO_MALAK",					
	
}



local TRANSPORT_VEHICLE_DRIVER	= "sol_s10052_transportVehicle_0000"
local TRANSPORT_VEHICLE_GUARD	= "sol_s10052_transportVehicle_0001"
local GUARD_VEHICLE_DRIVER		= "sol_s10052_guardVehicle_0000"
local EXECUTIONER_REMNANTS		= "sol_s10052_Executioner_remnants_0000"
local EXECUTIONER_TENT			= "sol_s10052_Executioner_tent_0000"

local TARGET_HOSTAGE			= "hos_target_0000"
local HOSTAGE_01				= "hos_remnants_0000"
local HOSTAGE_02				= "hos_remnants_0001"
local HOSTAGE_03				= "hos_remnants_0002"
local HOSTAGE_04				= "hos_tent_0000"
local HOSTAGE_05				= "hos_tent_0001"

local TRANSPORT_VEHICLE			= "veh_transportVehicle_0000"
local GUARD_VEHICLE				= "veh_transportVehicle_0001"


this.soldierPowerSettings = {
	[ TRANSPORT_VEHICLE_DRIVER ] = {}, 
}



local spawnList = {
	{ id = "Spawn",	locator = TRANSPORT_VEHICLE,	type = Vehicle.type.EASTERN_LIGHT_VEHICLE, },
	{ id = "Spawn",	locator = GUARD_VEHICLE,		type = Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE, },
}



this.vehicleDefine = {
	instanceCount   = #spawnList + 1,	
}



this.SpawnVehicleOnInitialize = function()
	TppEnemy.SpawnVehicles( spawnList )
end



this.convoyTable = {
	GameObject.GetGameObjectId( "TppVehicle2", TRANSPORT_VEHICLE ),
	GameObject.GetGameObjectId( "TppVehicle2", GUARD_VEHICLE ),
}



this.voiceTable = {
	hostage = {
		carry = {
			missionTarget = {
				[1] = "speech052_carry010",
				[2] = "speech052_carry020",
			},
		},
	},
	vehicleRiders = {
		inter = {
			driver = {
				
				[1] = "shksa000_111010",
				[2] = "shksa000_121010",
				[3] = "shksa000_131010",
				[4] = "shksa000_141010",
				[5] = "shksa000_151010",
			},
			guard = {
				
				[1] = "shksa000_191010",
				[2] = "shksa000_1a1010",
			},
		},
	},
	remnants = {
		inter = {
			executioner = {
				
				[1] = "enqt1000_271b10",
				[2] = "enqt1000_271c10",
				[3] = "enqt1000_271d10",
			},
			cpHigh = {
				[1] = "shksa000_101010",
			},
		},
		conversation = {
			[1]	= "speech52_EV010",
		},
		monologue = {
			[1]	= "speech52_EV011",
		},
	},
	remnantsNorth = {
		conversation = {
			[1]	= "speech52_EV020",
			[2]	= "speech52_EV022",
			[3]	= "speech52_EV023",
		},
		monologue = {
			[1]	= "speech52_EV021",
			[2]	= "speech52_EV024",
		},
	},
	betweenBase_A = {
		conversation = {
		},
		monologue = {
			[1]	= "speech52_EV030",
			[2]	= "speech52_EV031",
			[3]	= "speech52_EV032",
			[4]	= "speech52_EV033",
		},
	},
	betweenBase_B = {
		conversation = {
			[1]	= "speech52_EV040",
		},
		monologue = {
			[1]	= "speech52_EV041",
			[2]	= "speech52_EV042",
		},
	},
	tent = {
		inter = {
			
			executioner = {
				[1] = "shksa000_1b1010",
				[2] = "shksa000_1c1010",
			},
			cpHigh = {
				[1] = "enqt1000_271b10",
			},
		},
		conversation = {
			[1]	= "speech52_EV050",
		},
		monologue = {
			[1]	= "speech52_EV051",
			torture	= {
				[1]	= "speech52_EV060",
				[2]	= "speech52_EV061",
				[3]	= "speech52_EV062",
				[4]	= "speech52_EV063",
			},
		},
	},
}



this.routeTable = {
	
	remnants = {
		
		transportVehicle = {
			driver = {
				[1] =				"rts_transportVehicle_driver_remnants_event_0001",
				[2] =				"rts_transportVehicle_driver_remnants_event_0002",
				[3] =				"rts_transportVehicle_driver_remnants_event_0003",
				conversation = {
					[1] =			"rts_transportVehicle_driver_remnants_conversation_0001",
					[2] =			"rts_transportVehicle_driver_remnants_conversation_0002",
				},
			},
			guard = {
				[1] =				"rts_transportVehicle_guard_remnants_event_0001",
				[2] =				"rts_transportVehicle_guard_remnants_event_0002",
			},
		},
		
		guardVehicle = {
			driver = {
				[1] =				"rts_guardVehicle_driver_remnants_event_0001",
			},
		},
		
		executioner = {
			
			wait = {
				sneak =				"rts_remnants_Executioner_event_0001",
			},
			
			killHostage = {
				sneak = {
					[1] =			"rts_remnants_Executioner_killHostage_sneak01",
					[2] =			"rts_remnants_Executioner_killHostage_sneak02",
					[3] =			"rts_remnants_Executioner_killHostage_sneak03",
				},
				caution = {
					[1] =			"rts_remnants_Executioner_killHostage_caution01",
					[2] =			"rts_remnants_Executioner_killHostage_caution02",
					[3] =			"rts_remnants_Executioner_killHostage_caution03",
				},
			},
			
			annihilatedHostage = {
				day =				"rt_remnants_d_0011",
				night =				"rt_remnants_n_0011",
			}
		},
	},
	
	
	remnantsNorth = {
		
		transportVehicle = {
			driver = {
				[1] =				"rts_transportVehicle_driver_remnantsNorth_event_0001",
				[2] =				"rts_transportVehicle_driver_remnantsNorth_event_0002",
				[3] =				"rts_transportVehicle_driver_remnantsNorth_event_0003",
				[4] =				"rts_transportVehicle_driver_remnantsNorth_event_0004",
				conversation = {
					[1] = 			"rts_transportVehicle_driver_remnantsNorth_conversation_0001",
					[2] = 			"rts_transportVehicle_driver_remnantsNorth_conversation_0002",
					[3] = 			"rts_transportVehicle_driver_remnantsNorth_conversation_0003",
					[4] = 			"rts_transportVehicle_driver_remnantsNorth_conversation_0004",
				},
			},
			guard = {
				[1] =				"rts_transportVehicle_guard_remnantsNorth_event_0001",
			},
		},
		
		guardVehicle = {
			driver = {
				[1] =				"rts_guardVehicle_driver_remnantsNorth_event_0001",
				[2] =				"rts_guardVehicle_driver_remnantsNorth_event_0001",
				[3] =				"rts_guardVehicle_driver_remnantsNorth_event_0001",
			},
		},
		
		conversationEnemy = {
			
			day =					"rt_remnantsNorth_d_0000",
			night =					"rt_remnantsNorth_n_0000",
			
			[1] =					"rts_remnantsNorth_event_0001",
			[2] =					"rts_remnantsNorth_event_0002",
			[3] =					"rts_remnantsNorth_event_0003",
			[4] =					"rts_remnantsNorth_event_0004",
			conversation = {
				[1] =				"rts_remnantsNorth_conversation_0001",
			},
		},
		otherEnemy = {
			
			[1] = "rts_remnantsNorth_wait_0001",
			[2] = "rts_remnantsNorth_wait_0002",
			[3] = "rts_remnantsNorth_wait_0003",
			[4] = "rts_remnantsNorth_wait_0004",
		},
	},

	
	betweenBase_A = {
		
		transportVehicle = {
			driver = {
				[1] =				"rts_transportVehicle_driver_betweenA_event_0001",
				[2] =				"rts_transportVehicle_driver_betweenA_event_0002",
				[3] =				"rts_transportVehicle_driver_betweenA_event_0003",
				conversation = {
					[1] =			"rts_transportVehicle_driver_betweenA_conversation_0001",
					[2] =			"rts_transportVehicle_driver_betweenA_conversation_0002",
					[3] =			"rts_transportVehicle_driver_betweenA_conversation_0003",
				},
			},
			guard = {
				[1] =				"rts_transportVehicle_guard_betweenA_event_0001",
				[2] =				"rts_transportVehicle_guard_betweenA_event_0002",
				[3] =				"rts_transportVehicle_guard_betweenA_event_0003",
				[4] =				"rts_transportVehicle_guard_betweenA_event_0004",
				[5] =				"rts_transportVehicle_guard_betweenA_event_0005",
				conversation = {
					[1] =			"rts_transportVehicle_guard_betweenA_conversation_0001",
				},
			},
		},
		
		guardVehicle = {
			driver = {
				[1] =				"rts_guardVehicle_driver_betweenA_event_0001",
			},
		},
		
		animal = {
			[1] =					"rts_anml_goat_event_0000",	
			[2] =					"rts_anml_goat_event_0001",	
			[3] =					"",	
		},
	},
	
	
	betweenBase_B = {
		
		transportVehicle = {
			driver = {
				[1] =				"rts_transportVehicle_driver_betweenB_event_0001",	
				[2] =				"rts_transportVehicle_driver_betweenB_event_0002",	
				[3] =				"rts_transportVehicle_driver_betweenB_event_0003",	
				conversation = {
					[1] =			"rts_transportVehicle_driver_betweenB_conversation_0001",	
					[2] =			"rts_transportVehicle_driver_betweenB_conversation_0002",	
					[3] =			"rts_transportVehicle_driver_betweenB_conversation_0003",	
				},
			},
			guard = {
				[1] =				"rts_transportVehicle_guard_betweenB_event_0001",	
			},
		},
		
		guardVehicle = {
			driver = {
				[1] =				"rts_guardVehicle_driver_betweenB_event_0001",	
				[2] =				"rts_guardVehicle_driver_betweenB_event_0002",	
				[3] =				"rts_guardVehicle_driver_betweenB_event_0003",	
			},
		},
	},

	
	tent = {
		
		transportVehicle = {
			driver = {
				[1] =				"rts_transportVehicle_driver_tent_event_0001",
				[2] =				"rts_transportVehicle_driver_tent_event_0002",
				[3] =				"rts_transportVehicle_driver_tent_event_0003",
				[4] =				"rts_transportVehicle_driver_tent_event_0004",
				conversation = {
					[1] =			"rts_transportVehicle_driver_tent_conversation_0001",	
					[2] =			"rts_transportVehicle_driver_tent_conversation_0002",	
				},
				day =				"rt_tent_d_0018",
				night =				"rt_tent_n_0018",
				arrivedOnCaution =	"rts_transportVehicle_driver_tent_caution_0001",		
				returnEvent =		"rts_transportVehicle_driver_tent_event_0099",			
				cautionAfterTransport = "rts_transportVehicle_driver_tent_caution_0002",	
			},
			guard = {
				[1] =				"rts_transportVehicle_guard_tent_event_0001",
				[2] =				"rts_transportVehicle_guard_tent_event_0002",
				day =				"rt_tent_d_0013",
				night =				"rt_tent_n_0013",
				arrivedOnCaution =	"rts_transportVehicle_guard_tent_caution_0001",	
			},
		},
		
		conversationEnemy = {
			day =					"rt_tent_d_0017",
			night =					"rt_tent_n_0014",
			[1] =					"rts_tent_event_0001",
		},
		
		executioner = {
			sneak = {
				[1] =				"rts_tent_Executioner_s_0000",		
				[2] =				"rts_tent_Executioner_s_0001",		
				[3] =				"rts_tent_Executioner_loop_0000",	
			},
			caution = {
				[1] =				"rts_tent_Executioner_c_0000",		
				[2] =				"rts_tent_Executioner_c_0001",		
				[3] =				"rts_tent_Executioner_c_0001",		
			},
		},
	},
	
	travelPlans = {
		
		toTent = {
			[1]	= {
				remnants		=	"rts_travelPlan_toTent_01_01_remnants",
				lrrp_21_28		=	"rts_travelPlan_toTent_01_02_lrrp",
				remnantsNorth	=	"rts_travelPlan_toTent_01_03_remnantsNorth",
			},
			[2]	= {
				remnantsNorth	=	"rts_travelPlan_toTent_02_01_remnantsNorth",
				lrrp_21_24		=	"rts_travelPlan_toTent_02_02_lrrp",
			},
			[3]	= {
				lrrp_21_24		=	"rts_travelPlan_toTent_03_01_lrrp",
				tent			=	"rts_travelPlan_toTent_03_02_tent",
			},
			[4] = {
				tent			=	"rts_travelPlan_toTent_04_01_tent",
			},
		},
		
		toEnemyBase = {
			tent_01				=	"rts_travelPlan_toEnemyBase_01_01_tent_01",
			tent_02				=	"rts_travelPlan_toEnemyBase_01_01_tent_02",
			tent_03				=	"rts_travelPlan_toEnemyBase_01_01_tent_03",
			lrrp_6_24			=	"rts_travelPlan_toEnemyBase_01_02_lrrp",
			tentEast			=	"rts_travelPlan_toEnemyBase_01_03_tentEast",
			lrrp_6_36			=	"rts_travelPlan_toEnemyBase_01_04_lrrp",
		},
	},
}




this.soldierDefine = {
	
	afgh_remnants_cp = {
		"sol_remnants_0000",
		"sol_remnants_0001",
		"sol_remnants_0002",
		"sol_remnants_0003",
		"sol_remnants_0004",
		"sol_remnants_0005",
		"sol_remnants_0006",
		"sol_remnants_0007",
		
		EXECUTIONER_REMNANTS,
		TRANSPORT_VEHICLE_DRIVER,
		TRANSPORT_VEHICLE_GUARD,
		GUARD_VEHICLE_DRIVER,
		
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
		
		EXECUTIONER_TENT,
		
		nil
	},
	
	afgh_remnantsNorth_ob = {
		"sol_remnantsNorth_0000",
		"sol_remnantsNorth_0001",
		"sol_remnantsNorth_0002",
		"sol_remnantsNorth_0003",
		nil
	},
	
	afgh_fieldWest_ob = {
		"sol_fieldWest_0000",
		"sol_fieldWest_0001",
		"sol_fieldWest_0002",
		"sol_fieldWest_0003",
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
	
	afgh_06_24_lrrp = {
		"sol_06_24_0000",
		"sol_06_24_0001",
		lrrpTravelPlan = "travel_lrrp_tentEast_tent",			
		nil
	},
	
	afgh_06_36_lrrp = {
		
		nil
	},
	
	afgh_20_28_lrrp = {
		"sol_20_28_0000",
		"sol_20_28_0001",
		lrrpTravelPlan = "travel_lrrp_remnants_fieldWest",		
		nil
	},
	
	afgh_21_24_lrrp = {
		"sol_21_24_0000",
		"sol_21_24_0001",
		lrrpTravelPlan = "travel_lrrp_tent_remnantsNorth",		
		nil
	},
	
	afgh_21_28_lrrp = {
		"sol_21_28_0000",
		"sol_21_28_0001",
		lrrpTravelPlan = "travel_lrrp_remnantsNorth_remnants",	
		nil
	},
	
	afgh_22_24_lrrp = {
		"sol_22_24_0000",
		"sol_22_24_0001",
		lrrpTravelPlan = "travel_lrrp_tentNorth_tent",			
		nil
	},
	nil
}






this.routeSets = {
	
	afgh_remnants_cp = {
		USE_COMMON_ROUTE_SETS = true,
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_remnants_snp_0000", attr = "SNIPER" },
				{ "rt_remnants_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_remnants_d_0005",		
				"rt_remnants_d_0001",		
				"rt_remnants_d_0011",		
			},
			groupB = {
				"rt_remnants_d_0000",		
				"rt_remnants_d_0003",		
				"rt_remnants_d_0006",		
			},
			groupC = {
				"rt_remnants_d_0013",		
				"rt_remnants_d_0008",		
				"rt_remnants_d_0004",		
			},
			groupD = {
				"rt_remnants_d_0007",		
				"rt_remnants_d_0002",		
				"rt_remnants_d_0009",		
			},
		},
		sneak_night = {
			groupSniper = {
				{ "rt_remnants_snp_0000", attr = "SNIPER" },
				{ "rt_remnants_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_remnants_n_0003",		
				"rt_remnants_n_0001_sub",	
				"rt_remnants_n_0004",		
			},
			groupB = {
				"rt_remnants_n_0005",		
				"rt_remnants_n_0009",		
				"rt_remnants_n_0007",		
			},
			groupC = {
				"rt_remnants_n_0006_sub",	
				"rt_remnants_n_0008",		
				"rt_remnants_n_0010",		
			},
			groupD = {
				"rt_remnants_n_0000_sub",	
				"rt_remnants_n_0002_sub",	
				"rt_remnants_n_0011",		
			},
		},
		caution = {
			groupSniper = {
				{ "rt_remnants_snp_0000", attr = "SNIPER" },
				{ "rt_remnants_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_remnants_c_0005",	
				"rt_remnants_c_0000",	
				"rt_remnants_c_0006",	
				"rt_remnants_c_0007",	
				"rt_remnants_c_0001",	
				"rt_remnants_c_0003",	
				"rt_remnants_c_0008",	
				"rt_remnants_c_0002",	
				"rt_remnants_c_0004",	
				"rt_remnants_c_0011",	
				"rt_remnants_c_0009",	
				"rt_remnants_c_0010",	
				"rt_remnants_c_0015",	
				"rt_remnants_c_0014",	
				"rt_remnants_c_0013",	
				"rt_remnants_c_0012",	
			},
			groupB = {
			},
			groupC = {
			},
			groupD = {
			},
		},
		travel = {
			lrrpHold = {
				"rt_remnants_l_0000",
				"rt_remnants_l_0001",
			},
			in_lrrpHold_N = {
				"rt_remnants_lin_N",
				"rt_remnants_lin_N",
			},
			out_lrrpHold_B01 = {
				"rt_remnants_lout_B01",
				"rt_remnants_lout_B01",
			},
			out_lrrpHold_B02 = {
				"rt_remnants_lout_B02",
				"rt_remnants_lout_B02",
			},
			out_lrrpHold_B03 = {
				"rt_remnants_lout_B03",
				"rt_remnants_lout_B03",
			},
			lrrp_remnants_to_tent_rts_escort01 = {
				this.routeTable.travelPlans.toTent[1].remnants,		
				this.routeTable.travelPlans.toTent[1].remnants,		
				this.routeTable.travelPlans.toTent[1].remnants,		
			},
		},
		nil
	},
	
	
	afgh_tent_cp = {
		USE_COMMON_ROUTE_SETS = true,
		priority = {
			"groupSniper",
			"groupA",
			"groupB",
			"groupC",
			"groupD",
		},
		sneak_day = {
			groupSniper = {
				{ "rt_tent_snp_0000", attr = "SNIPER" },
				{ "rt_tent_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_tent_d_0000",		
				"rt_tent_d_0014",		
				"rt_tent_d_0004",		
				"rt_tent_d_0003",		
			},
			groupB = {
				"rt_tent_d_0001",		
				"rt_tent_d_0017",		
				"rt_tent_d_0006",		
				"rt_tent_d_0013",		
			},
			groupC = {
				"rt_tent_d_0016",		
				"rt_tent_d_0002",		
				"rt_tent_d_0008_sub",	
			},
			groupD = {
				"rt_tent_d_0012",		
				"rt_tent_d_0005",		
				"rt_tent_d_0019",		
			},
		},
		sneak_night= {
			groupSniper = {
				{ "rt_tent_snp_0000", attr = "SNIPER" },
				{ "rt_tent_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_tent_n_0000",		
				"rt_tent_n_0014",		
				"rt_tent_n_0004_sub",	
				"rt_tent_n_0003",		
			},
			groupB = {
				"rt_tent_n_0001",		
				"rt_tent_n_0015",		
				"rt_tent_n_0006",		
				"rt_tent_n_0013",		
			},
			groupC = {
				"rt_tent_n_0016",		
				"rt_tent_n_0002",		
				"rt_tent_n_0008_sub",	
			},
			groupD = {
				"rt_tent_n_0012",		
				"rt_tent_n_0005_sub",	
				"rt_tent_n_0019",		
			},
		},
		caution = {
			groupSniper = {
				{ "rt_tent_snp_0000", attr = "SNIPER" },
				{ "rt_tent_snp_0001", attr = "SNIPER" },
			},
			groupA = {
				"rt_tent_c_0000",	
				"rt_tent_c_0001",	
				"rt_tent_c_0006",	
				"rt_tent_c_0014",	
				"rt_tent_c_0019",	
				"rt_tent_c_0004",	
				"rt_tent_c_0005",	
				"rt_tent_c_0017",	
				"rt_tent_c_0002",	
				"rt_tent_c_0003",	
				"rt_tent_c_0008",	
				"rt_tent_c_0015",	
				
				"rt_tent_c_0018",	
				"rt_tent_c_0016",	
				
				"rt_tent_c_0012",	
				"rt_tent_c_0009",	
				
				"rt_tent_c_0011",	
				"rt_tent_c_0007",	
				
				"rt_tent_c_0013",	
				"rt_tent_c_0010",	
				
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
		travel = {
			lrrpHold = {
				"rt_tent_l_0000",
				"rt_tent_l_0001",
			},
			in_lrrpHold_S = {
				"rt_tent_lin_S",
				"rt_tent_lin_S",
			},
			out_lrrpHold_N = {
				"rt_tent_lout_N",
				"rt_tent_lout_N",
			},
			lrrp_remnants_to_tent_rts_escort03 = {
				this.routeTable.travelPlans.toTent[3].tent,				
				this.routeTable.travelPlans.toTent[3].tent,				
				this.routeTable.travelPlans.toTent[3].tent,				
			},
			lrrp_remnants_to_tent_rts_escort04 = {
				this.routeTable.travelPlans.toTent[4].tent,				
				this.routeTable.travelPlans.toTent[4].tent,				
			},
			lrrp_tent_to_enemyBase_rts_secession01 = {
				this.routeTable.travelPlans.toEnemyBase.tent_03,			
			},
			
			lrrp_tent_to_enemyBase_rts_secession01_01 = {
				this.routeTable.travelPlans.toEnemyBase.tent_01,			
			},
			lrrp_tent_to_enemyBase_rts_secession01_02 = {
				this.routeTable.travelPlans.toEnemyBase.tent_02,			
			},
		},
		nil
	},
	
	
	afgh_remnantsNorth_ob =		{
		USE_COMMON_ROUTE_SETS = true,
		priority = {
			"groupA",
			"groupB",
			"groupC",
		},
		sneak_day = {
			groupA = {
				"rt_remnantsNorth_d_0000",
				"rt_remnantsNorth_d_0003",
			},
			groupB = {
				"rt_remnantsNorth_d_0001",
				"rt_remnantsNorth_d_0001",
			},
			groupC = {
				"rt_remnantsNorth_d_0002",
				"rt_remnantsNorth_d_0002",
			},
		},
		sneak_night= {
			groupA = {
				"rt_remnantsNorth_n_0000",
				"rt_remnantsNorth_n_0003",
			},
			groupB = {
				"rt_remnantsNorth_n_0001",
				"rt_remnantsNorth_n_0001",
			},
			groupC = {
				"rt_remnantsNorth_n_0002",
				"rt_remnantsNorth_n_0002",
			},
		},
		caution = {
			groupA = {
				"rt_remnantsNorth_c_0000",
				"rt_remnantsNorth_c_0001",
				"rt_remnantsNorth_c_0002",
				"rt_remnantsNorth_c_0002",
				"rt_remnantsNorth_c_0000",
				"rt_remnantsNorth_c_0001",
				"rt_remnantsNorth_c_0000",
				"rt_remnantsNorth_c_0002",
			},
			groupB = {
			},
			groupC = {
			},
		},
		travel = {
			
			lrrpHold = {
				"rt_remnantsNorth_l_0000",
				"rt_remnantsNorth_l_0001",
			},
			
			lrrp_remnants_to_tent_rts_escort01 = {
				this.routeTable.travelPlans.toTent[1].remnantsNorth,	
				this.routeTable.travelPlans.toTent[1].remnantsNorth,	
				this.routeTable.travelPlans.toTent[1].remnantsNorth,	
			},
			lrrp_remnants_to_tent_rts_escort02 = {
				this.routeTable.travelPlans.toTent[2].remnantsNorth,	
				this.routeTable.travelPlans.toTent[2].remnantsNorth,	
				this.routeTable.travelPlans.toTent[2].remnantsNorth,	
			},
		},
	},
	
	
	afgh_fieldWest_ob =		{	USE_COMMON_ROUTE_SETS = true,	},
	
	
	afgh_tentEast_ob =		{
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			
			lrrpHold = {
				"rt_tentEast_l_0000",
				"rt_tentEast_l_0001",
			},
			
			lrrp_tent_to_enemyBase_rts_secession01 = {
				this.routeTable.travelPlans.toEnemyBase.tentEast,		
			},
		},
	},
	
	
	afgh_tentNorth_ob =		{	USE_COMMON_ROUTE_SETS = true,	},
	
	
	afgh_06_24_lrrp =		{
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_tent_to_enemyBase_rts_secession01 = {
				this.routeTable.travelPlans.toEnemyBase.lrrp_6_24,		
			},
		},
	},
	
	
	afgh_06_36_lrrp =		{
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_tent_to_enemyBase_rts_secession01 = {
				this.routeTable.travelPlans.toEnemyBase.lrrp_6_36,		
			},
		},
	},
	
	
	afgh_21_24_lrrp =		{
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_remnants_to_tent_rts_escort02 = {
				this.routeTable.travelPlans.toTent[2].lrrp_21_24,		
				this.routeTable.travelPlans.toTent[2].lrrp_21_24,		
				this.routeTable.travelPlans.toTent[2].lrrp_21_24,		
			},
			lrrp_remnants_to_tent_rts_escort03 = {
				this.routeTable.travelPlans.toTent[3].lrrp_21_24,		
				this.routeTable.travelPlans.toTent[3].lrrp_21_24,		
				this.routeTable.travelPlans.toTent[3].lrrp_21_24,		
			},
		},
	},
	
	
	afgh_20_28_lrrp =		{	USE_COMMON_ROUTE_SETS = true,	},
	
	
	afgh_21_28_lrrp =		{
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_remnants_to_tent_rts_escort01 = {
				this.routeTable.travelPlans.toTent[1].lrrp_21_28,		
				this.routeTable.travelPlans.toTent[1].lrrp_21_28,		
				this.routeTable.travelPlans.toTent[1].lrrp_21_28,		
			},
		},
	},
	
	
	afgh_22_24_lrrp =		{	USE_COMMON_ROUTE_SETS = true,	},

	

}




local	PLAN_1	=	"travel_mission_remnants_to_remnantsNorth"
local	PLAN_2	=	"travel_mission_remnantsNorth_to_betweenA"
local	PLAN_3	=	"travel_mission_betweenA_to_betweenB"
local	PLAN_4	=	"travel_mission_betweenB_to_tent"
local	PLAN_X	=	"travel_mission_tent_to_enemyBase"


this.travelPlans = {
	
	
	[ PLAN_1 ] = {
		ONE_WAY = true,
		{ cp = "afgh_remnants_cp",			routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort01" } },
		{ cp = "afgh_21_28_lrrp",			routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort01" } },
		{ cp = "afgh_remnantsNorth_ob",		routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort01" } },
		{ cp = "afgh_remnantsNorth_ob" },
	},
	[ PLAN_2 ] = {
		ONE_WAY = true,
		{ cp = "afgh_remnantsNorth_ob",		routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort02" } },
		{ cp = "afgh_21_24_lrrp",			routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort02" } },
		{ cp = "afgh_21_24_lrrp" },
	},
	[ PLAN_3 ] = {
		ONE_WAY = true,
		{ cp = "afgh_21_24_lrrp",			routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort03" } },
		{ cp = "afgh_tent_cp",				routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort03" } },
		{ cp = "afgh_tent_cp" },
	},
	[ PLAN_4 ] = {
		ONE_WAY = true,
		{ cp = "afgh_tent_cp",				routeGroup = { "travel", "lrrp_remnants_to_tent_rts_escort04" } },
		{ cp = "afgh_tent_cp" },
	},
	
	[ PLAN_X ] = {
		ONE_WAY = true,
		{ cp = "afgh_tent_cp",				routeGroup = { "travel", "lrrp_tent_to_enemyBase_rts_secession01_01" } },
		{ cp = "afgh_tent_cp",				routeGroup = { "travel", "lrrp_tent_to_enemyBase_rts_secession01_02" } },
		{ cp = "afgh_tent_cp",				routeGroup = { "travel", "lrrp_tent_to_enemyBase_rts_secession01" } },
		{ cp = "afgh_06_24_lrrp",			routeGroup = { "travel", "lrrp_tent_to_enemyBase_rts_secession01" } },
		{ cp = "afgh_tentEast_ob",			routeGroup = { "travel", "lrrp_tent_to_enemyBase_rts_secession01" } },
		{ cp = "afgh_06_36_lrrp",			routeGroup = { "travel", "lrrp_tent_to_enemyBase_rts_secession01" } },
		{ cp = "afgh_06_36_lrrp" },
	},
	
	
	travel_lrrp_remnants_fieldWest = {
		{ base = "afgh_fieldWest_ob", },
		{ base = "afgh_remnants_cp", },			
	},

	
	travel_lrrp_remnantsNorth_remnants = {
		{ base = "afgh_remnants_cp", },
		{ base = "afgh_remnantsNorth_ob", },	
	},

	
	travel_lrrp_tent_remnantsNorth = {
		{ base = "afgh_remnantsNorth_ob", },
		{ base = "afgh_tent_cp", },				
	},

	
	travel_lrrp_tentEast_tent = {
		{ base = "afgh_tent_cp", },
		{ base = "afgh_tentEast_ob", },			
	},

	
	travel_lrrp_tentNorth_tent = {
		{ base = "afgh_tent_cp", },
		{ base = "afgh_tentNorth_ob", },		
	},
}




this.combatSetting = {
	
	
	afgh_remnants_cp = {
		USE_COMMON_COMBAT = true,


	},
	
	afgh_tent_cp = {
		USE_COMMON_COMBAT = true,


	},
	
	
	afgh_fieldWest_ob = {
		USE_COMMON_COMBAT = true,

	},
	
	afgh_remnantsNorth_ob = {
		USE_COMMON_COMBAT = true,

	},
	
	afgh_tentEast_ob = {
		USE_COMMON_COMBAT = true,

	},
	
	afgh_tentNorth_ob = {
		USE_COMMON_COMBAT = true,

	},
}







this.ExecuteUniqueInter = function( cpID, interDetail )
	Fox.Log( "#### s10052_enemy.ExecuteUniqueInter #### interDetail = " ..interDetail )
	if ( interDetail == "" ) then
		return false
	else
		TppInterrogation.UniqueInterrogation( cpID, interDetail )

		return true
	end
end



this.UniqueInterStart_driver = function( soldier2GameObjectId, cpID )
	Fox.Log( "#### s10052_enemy.UniqueInterStart_driver #### soldier2gameObjectId = " ..soldier2GameObjectId )

	local interDetail = ""

	
	if( svars.eventCount >= this.EVENT_SEQUENCE["TENT_JOIN_SHIFT"])then
		Fox.Log( "#### s10052_enemy.UniqueInterStart_driver #### EVENT_SEQUENCE >= TENT_JOIN_SHIFT")
		
		if ( svars.interCount_driver == 0 ) then
			interDetail = this.voiceTable.vehicleRiders.inter.driver[4]		
		elseif ( svars.interCount_driver >= 1 ) then
			interDetail = this.voiceTable.vehicleRiders.inter.driver[5]
			svars.isGetInfoFromDriver = true
		end
		
	
	elseif( svars.eventCount >= this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"])then
		Fox.Log( "#### s10052_enemy.UniqueInterStart_driver #### EVENT_SEQUENCE >= REMNANTS_VEHICLE_START")
		
		if ( svars.interCount_driver == 0 ) then
			interDetail = this.voiceTable.vehicleRiders.inter.driver[2]
		elseif ( svars.interCount_driver >= 1 ) then
			interDetail = this.voiceTable.vehicleRiders.inter.driver[3]
		end
		
	
	else
		Fox.Log( "#### s10052_enemy.UniqueInterStart_driver #### EVENT_SEQUENCE < REMNANTS_VEHICLE_START")
		interDetail = this.voiceTable.vehicleRiders.inter.driver[1]
	end
	
	return this.ExecuteUniqueInter( cpID, interDetail )
end



this.UniqueInterEnd_driver = function( soldier2GameObjectId, cpID )
	svars.interCount_driver = svars.interCount_driver + 1

	if ( svars.isGetInfoFromDriver == true and svars.infoCount < 3 ) then
		
		svars.infoCount = 3
		
		
		TppMission.UpdateObjective{	objectives = { "area_tent_lv3" },}
	end
end



this.UniqueInterStart_guard = function( soldier2GameObjectId, cpID )
	Fox.Log( "#### s10052_enemy.UniqueInterStart_guard #### soldier2gameObjectId = " ..soldier2GameObjectId )

	local interDetail = ""

	if ( svars.interCount_guard == 0 ) then
		interDetail = this.voiceTable.vehicleRiders.inter.guard[1]
	elseif ( svars.interCount_guard >= 1 ) then
		interDetail = this.voiceTable.vehicleRiders.inter.guard[2]
	end

	return this.ExecuteUniqueInter( cpID, interDetail )
end



this.UniqueInterEnd_guard = function( soldier2GameObjectId, cpID )
	svars.interCount_guard = svars.interCount_guard + 1
end



this.UniqueInterStart_executioner_remnants = function( soldier2GameObjectId, cpID )
	Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_remnants #### soldier2gameObjectId = " ..soldier2GameObjectId )

	local interDetail = ""

	
	if ( svars.isPermitMarkedHostage_1 ) then
		Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_remnants #### isPermitMarkedHostage_1 = " ..tostring(svars.isPermitMarkedHostage_1) )
		interDetail = this.voiceTable.remnants.inter.executioner[1]
		
	
	elseif ( svars.isPermitMarkedHostage_2 ) then
		Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_remnants #### isPermitMarkedHostage_2 = " ..tostring(svars.isPermitMarkedHostage_2) )
		interDetail = this.voiceTable.remnants.inter.executioner[2]
		
	
	elseif ( svars.isPermitMarkedHostage_3 ) then
		Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_remnants #### isPermitMarkedHostage_3 = " ..tostring(svars.isPermitMarkedHostage_3) )
		interDetail = this.voiceTable.remnants.inter.executioner[3]
		
	
	else
		Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_remnants #### All Hostages Prohibit Marked. ")
	end

	
	return this.ExecuteUniqueInter( cpID, interDetail )
end



this.UniqueInterEnd_executioner_remnants = function( soldier2GameObjectId, cpID )
	svars.interCount_executioner_remnants = svars.interCount_executioner_remnants + 1

	
	


















	
	TppMission.UpdateObjective{	objectives = { 	"remnants_hostage_1" },}
	TppMission.UpdateObjective{	objectives = { 	"remnants_hostage_2" },}
	TppMission.UpdateObjective{	objectives = { 	"remnants_hostage_3" },}
	svars.isPermitMarkedHostage_1 = false
	svars.isPermitMarkedHostage_2 = false
	svars.isPermitMarkedHostage_3 = false

end



this.UniqueInterStart_executioner_tent = function( soldier2GameObjectId, cpID )
	Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_tent #### soldier2gameObjectId = " ..soldier2GameObjectId )
	
	local interDetail = ""

	
	if( svars.eventCount >= this.EVENT_SEQUENCE["TENT_VEHICLE_ARRIVED"])then
		Fox.Log( "#### s10052_enemy.UniqueInterStart_executioner_tent #### EVENT_SEQUENCE >= TENT_VEHICLE_ARRIVED")
		
		if ( svars.interCount_executioner_tent == 0 ) then
			interDetail = this.voiceTable.tent.inter.executioner[1]
		elseif ( svars.interCount_executioner_tent >= 1 ) then
			interDetail = this.voiceTable.tent.inter.executioner[2]
		end
	end

	return this.ExecuteUniqueInter( cpID, interDetail )
end



this.UniqueInterEnd_executioner_tent = function( soldier2GameObjectId, cpID )
	svars.interCount_executioner_tent = svars.interCount_executioner_tent + 1
end



this.InterCall_remnants = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("#### s10052_enemy.InterCall_remnants #### soldierId = " .. soldier2GameObjectId .. ", cpID =" .. cpID )
	
	svars.infoCount = svars.infoCount + 1
	svars.isGetInfoFromEnemy = true
	
	s10052_sequence.GetInfo("enemy")
end


this.InterCall_tent = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("#### s10052_enemy.InterCall_tent #### soldierId = " .. soldier2GameObjectId .. ", cpID =" .. cpID )
	
	TppMission.UpdateObjective{	objectives = { 	"tent_hostage_1" },}
	TppMission.UpdateObjective{	objectives = { 	"tent_hostage_2" },}

	
	s10052_sequence.ControlInterFlagToCP("afgh_tent_cp", "reset")

	svars.tempSvars_006 = true	
end



this.uniqueInterrogation = {
	
	unique = {
		{ name = this.voiceTable.vehicleRiders.inter.driver[1],	func = this.UniqueInterEnd_driver,},
		{ name = this.voiceTable.vehicleRiders.inter.driver[2],	func = this.UniqueInterEnd_driver,},
		{ name = this.voiceTable.vehicleRiders.inter.driver[3],	func = this.UniqueInterEnd_driver,},
		{ name = this.voiceTable.vehicleRiders.inter.driver[4],	func = this.UniqueInterEnd_driver,},
		{ name = this.voiceTable.vehicleRiders.inter.driver[5],	func = this.UniqueInterEnd_driver,},
		{ name = this.voiceTable.vehicleRiders.inter.guard[1],		func = this.UniqueInterEnd_guard,},
		{ name = this.voiceTable.vehicleRiders.inter.guard[2],		func = this.UniqueInterEnd_guard,},
		{ name = this.voiceTable.remnants.inter.executioner[1],	func = this.UniqueInterEnd_executioner_remnants,},
		{ name = this.voiceTable.remnants.inter.executioner[2],	func = this.UniqueInterEnd_executioner_remnants,},
		{ name = this.voiceTable.remnants.inter.executioner[3],	func = this.UniqueInterEnd_executioner_remnants,},
		{ name = this.voiceTable.tent.inter.executioner[1],		func = this.UniqueInterEnd_executioner_tent,},
		{ name = this.voiceTable.tent.inter.executioner[2],		func = this.UniqueInterEnd_executioner_tent,},
	},
	
	uniqueChara = {
		{ name = TRANSPORT_VEHICLE_DRIVER,							func = this.UniqueInterStart_driver,},
		{ name = TRANSPORT_VEHICLE_GUARD,							func = this.UniqueInterStart_guard,},
		{ name = EXECUTIONER_REMNANTS,								func = this.UniqueInterStart_executioner_remnants,},
		{ name = EXECUTIONER_TENT,									func = this.UniqueInterStart_executioner_tent,},
	},
}



this.interrogation = {

	afgh_remnants_cp = {
		
		high = {
			{ name = this.voiceTable.remnants.inter.cpHigh[1], func = this.InterCall_remnants, },
			nil
		},
		normal = {
			nil
		},
		nil
	},
	afgh_tent_cp = {
		
		high = {
			{ name = this.voiceTable.tent.inter.cpHigh[1], 	func = this.InterCall_tent, },
			nil
		},
		normal = {
			nil
		},
		nil
	},
	nil
}




this.useGeneInter = {
	
	afgh_remnants_cp		= true,
	afgh_tent_cp			= true,
	
	afgh_remnantsNorth_ob	= true,
	afgh_fieldWest_ob		= true,
	afgh_tentNorth_ob		= true,
	afgh_tentEast_ob		= true,
	nil
}







this.InitEnemy = function ()
	Fox.Log("### s10052_enemy.InitEnemy ###")

	
	TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnants.transportVehicle.driver[1] )
	TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.remnants.transportVehicle.guard[1] )
	TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_GUARD ,	this.routeTable.remnants.transportVehicle.guard[2] )	
	TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.remnants.guardVehicle.driver[1] )
	TppEnemy.SetCautionRoute(	GUARD_VEHICLE_DRIVER ,		this.routeTable.remnants.guardVehicle.driver[1] )		

	
	TppEnemy.SetSneakRoute(		EXECUTIONER_REMNANTS ,		this.routeTable.remnants.executioner.wait.sneak )
	TppEnemy.SetCautionRoute(	EXECUTIONER_REMNANTS ,		this.routeTable.remnants.executioner.killHostage.caution[1] )

	
	svars.executeRouteName_S = StrCode32(this.routeTable.remnants.executioner.killHostage.sneak[1])
	svars.executeRouteName_C = StrCode32(this.routeTable.remnants.executioner.killHostage.caution[1])
	
	
	TppEnemy.SetSneakRoute(		EXECUTIONER_TENT ,			this.routeTable.tent.executioner.sneak[1] )
	TppEnemy.SetCautionRoute(	EXECUTIONER_TENT ,			this.routeTable.tent.executioner.caution[1] )
	
	
	s10052_enemy.EnableSoldierOnLrrp_21_24(false)

	
	this.SetTargetDistanceCheck()
	
	
	TppEnemy.SetRescueTargets( { TARGET_HOSTAGE } )	
	
	
	local gameObjectId = GameObject.GetGameObjectId("TppHostage2", TARGET_HOSTAGE )
	local command = {	id = "SetHostage2Flag",	flag = "disableFulton",  on = true,	}
	GameObject.SendCommand( gameObjectId, command )

	
	command = { id = "SetHostage2Flag", flag = "silent", on = true }
	GameObject.SendCommand( gameObjectId, command )
	
	
	command = { id = "SetMovingNoticeTrap", enable = true } 
	GameObject.SendCommand( gameObjectId, command ) 
	
	
	this.ForceRealizeEventNPC()
	
	
	this.SetDisableOccasionalChatOnSequence()
	
end



this.SetUpEnemy = function ()
	Fox.Log("### s10052_enemy.SetUpEnemy ###")
	TppEnemy.RegisterCombatSetting( this.combatSetting )

	
	GameObject.SendCommand( { type="TppVehicle2", },{ id = "RegisterConvoy", convoyId = {
		GameObject.GetGameObjectId( "TppVehicle2", TRANSPORT_VEHICLE ),
		GameObject.GetGameObjectId( "TppVehicle2", GUARD_VEHICLE ),
	},} )

	
	this.SetRelativeVehicle(TRANSPORT_VEHICLE_DRIVER ,	TRANSPORT_VEHICLE)
	this.SetRelativeVehicle(TRANSPORT_VEHICLE_GUARD ,	TRANSPORT_VEHICLE)
	this.SetRelativeVehicle(TARGET_HOSTAGE ,			TRANSPORT_VEHICLE)	
	this.SetRelativeVehicle(GUARD_VEHICLE_DRIVER ,		GUARD_VEHICLE)

	
	this.SetUpRegisterMessage()
	
	
	this.EnableFollowedSetting(true)
	
	
	
	local existParamTable_01 = { staffTypeId =45, randomRangeId =4, skill ="TranqEngineer" }
	this.SetUniqueStaffParam(TARGET_HOSTAGE, TppDefine.UNIQUE_STAFF_TYPE_ID.S10052_MALAK, existParamTable_01)				
	
	
	local existParamTable_02 = { staffTypeId =52, randomRangeId =4, skill =nil }
	this.SetUniqueStaffParam(TRANSPORT_VEHICLE_DRIVER, TppDefine.UNIQUE_STAFF_TYPE_ID.S10052_DRIVER, existParamTable_02)	
	
	
	local existParamTable_03 = { staffTypeId =2, randomRangeId =6, skill ="Study" }
	this.SetUniqueStaffParam(HOSTAGE_01, 85, existParamTable_03)															
	
	local existParamTable_04 = { staffTypeId =6, randomRangeId =6, skill ="HaulageEngineer" }
	this.SetUniqueStaffParam(HOSTAGE_02, 84, existParamTable_04)															
	
	local existParamTable_05 = { staffTypeId =49, randomRangeId =4, skill =nil }
	this.SetUniqueStaffParam(HOSTAGE_03, 86, existParamTable_05)
	
	
	local existParamTable_06 = { staffTypeId =3, randomRangeId =6, skill ="MechatronicsEngineer" }
	this.SetUniqueStaffParam(HOSTAGE_04, 82, existParamTable_06)															
	
	local existParamTable_07 = { staffTypeId =50, randomRangeId =4, skill =nil }
	this.SetUniqueStaffParam(HOSTAGE_05, 83, existParamTable_07)
	
	
	this.SetHostageLangType(TARGET_HOSTAGE,"pashto")		
	this.SetHostageLangType(HOSTAGE_01,"pashto")			
	this.SetHostageLangType(HOSTAGE_02,"pashto")			
	this.SetHostageLangType(HOSTAGE_03,"pashto")			
	this.SetHostageLangType(HOSTAGE_04,"russian")			
	this.SetHostageLangType(HOSTAGE_05,"russian")			
	
	
	this.SetHostageVoiceType(TARGET_HOSTAGE,"hostage_a")	
	
	
	this.RegistHoldRecoveredStateForMissionTask( s10052_sequence.MISSION_TASK_TARGET_LIST_REMNANTS )
	this.RegistHoldRecoveredStateForMissionTask( s10052_sequence.MISSION_TASK_TARGET_LIST_TENT )
	this.RegistHoldRecoveredStateForMissionTask( s10052_sequence.MISSION_TASK_TARGET_LIST_VEHICLE )
	
	
	if not( svars.tempSvars_006 ) then
		if not( svars.rescueHostageCount_tent == 2 ) then
			s10052_sequence.ControlInterFlagToCP("afgh_tent_cp", "set")	
		end
	end
end



this.OnLoad = function ()
	Fox.Log("### s10052_enemy.Onload ###")
end







this.ForceRealizeEventNPC = function ()
	Fox.Log( "#### s10052_enemy.ForceRealizeEventNPC ####" )

	local enemyList = {
		"sol_s10052_transportVehicle_0000",
		"sol_s10052_transportVehicle_0001",
		"sol_s10052_guardVehicle_0000",
		"sol_s10052_Executioner_remnants_0000",
		"sol_s10052_Executioner_tent_0000",
	}
	for i, enemyName in pairs (enemyList) do
		local gameObjectId = GameObject.GetGameObjectId("TppSoldier2", enemyName)
		local command = { id="SetForceRealize" }
		GameObject.SendCommand( gameObjectId, command )	
	end
end



this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("### s10052_enemy.RegistHoldRecoveredStateForMissionTask ### Regist Start!")
	for index, targetName in pairs(targetList) do
		Fox.Log("### s10052_enemy.RegistHoldRecoveredStateForMissionTask ### Registed... "..tostring(targetName))
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end



this.SetRouteDrivers = function (id, routeId)
	Fox.Log( "#### s10052_enemy.SetRouteDrivers #### NPC[ " ..tostring(id).. " ] sent a message from Route[ " ..tostring(routeId).. " ] !" )

	
	
	local driverId = GameObject.GetGameObjectId(TRANSPORT_VEHICLE_DRIVER)
	local isNeutralizeDriver = TppEnemy.IsNeutralized(TRANSPORT_VEHICLE_DRIVER)
	
	
	
	if ( not isNeutralizeDriver ) then
		
		if ( id ~= driverId ) then
			
			if (	routeId == StrCode32(this.routeTable.travelPlans.toTent[1].remnantsNorth )			or
					routeId == StrCode32(this.routeTable.travelPlans.toTent[2].lrrp_21_24 )			or
					routeId == StrCode32(this.routeTable.travelPlans.toTent[3].tent )					or
					routeId == StrCode32(this.routeTable.travelPlans.toTent[4].tent )					or

					routeId == StrCode32(this.routeTable.tent.transportVehicle.driver[2] ))			then

				Fox.Log( "#### s10052_enemy.SetRouteDrivers #### This NPC[ " ..tostring(id).. " ] is not a Driver! This Route[ " ..tostring(routeId).. " ] is only allowed to Driver(alive)!" )
				
				return
			end
		end
	end

	
	if ( svars.eventCount >	this.EVENT_SEQUENCE["REMNANTS_CONVERSATION_START"] ) then
		s10052_sequence.StopTimer("Timer_SwitchPhaseToCaution_TimeOut")
	end

	
	
	local conversationEnemy = this.SearchNormalEnemyFromSequence()
	if (conversationEnemy == nil) then
		
		s10052_sequence.StartTimer("Timer_SwitchPhaseToCaution", 5)
	else
		
		this.CheckMainActorStatus()
	end
	
	
	this.SetDisableOccasionalChatOnSequence()
	
	Fox.Log( "#### s10052_enemy.SetRouteDrivers #### EVENT_SEQUENCE= " .. this.EVENT_SEQUENCE[svars.eventCount] )
	
	
	
	if ( this.EVENT_SEQUENCE[svars.eventCount] ==		"REMNANTS_CONVERSATION_START" ) then
		TppEnemy.SetSneakRoute( TRANSPORT_VEHICLE_DRIVER , this.routeTable.remnants.transportVehicle.driver.conversation[1] )				

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] ==	"REMNANTS_TURNAROUND_HOSTAGE" ) then

		
		if (svars.isRadioTrigger_1 or svars.isRadioTrigger_2 or svars.isRadioTrigger_3 ) then
			svars.isHearTransportProject = true
		
			if ( svars.isTargetRescue ) then
				
			elseif ( svars.isTargetMarked ) then
				
				s10052_radio.RevelationTransportProject()
			else
				
				TppMission.UpdateObjective{
					radio = {
						radioGroups = { "s0052_rtrg0020"},
						radioOptions = { delayTime = "mid" },
					},
					objectives = { "area_tent_lv1" },
				}
			end
			
			if ( svars.infoCount == 0 and not(svars.isTargetRescue) ) then
				local TARGET_IN_TENT = 1
				TppUiCommand.SetMisionInfoCurrentStoryNo(TARGET_IN_TENT)
			end
			
			
			svars.infoCount = svars.infoCount + 1
			
			
			s10052_sequence.CheckSituationForPhaseBGM()
		end
	
		TppEnemy.SetSneakRoute( TRANSPORT_VEHICLE_DRIVER , this.routeTable.remnants.transportVehicle.driver[2] )							
		TppEnemy.SetSneakRoute(		EXECUTIONER_REMNANTS ,	this.routeTable.remnants.executioner.killHostage.sneak[1] )					
		TppEnemy.SetCautionRoute(	EXECUTIONER_REMNANTS ,	this.routeTable.remnants.executioner.killHostage.caution[1] )					
		
		
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_1 )
		
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] ==	"REMNANTS_MONOLOGUE_TO_HOSTAGE" ) then
		TppEnemy.SetSneakRoute( TRANSPORT_VEHICLE_DRIVER , this.routeTable.remnants.transportVehicle.driver.conversation[2] )				

	
	


	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] ==	"REMNANTS_VEHICLE_START" ) then
		
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER,	PLAN_1)
		s10052_enemy.SetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER,		PLAN_1)
		s10052_enemy.UnsetRouteForVehicleRiders()	

		
		if ( svars.isSkipOnEmergency ) then
			s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_1 )
			svars.eventCount = this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"] - 1	
			svars.talkCount = this.TALK_SEQUENCE["REMNANTSNORTH_MONOLOGUE_TO_MALAK"]
		else
			
			this.SetOtherEnemyRouteForRemnantsNorth(true)
			
			TppEnemy.SetSneakRoute( 	conversationEnemy ,			this.routeTable.remnantsNorth.conversationEnemy[1] )					
		end
	
		svars.isDriveTime			= true

		
		svars.tempSvars_007			= true	
		
		if not( svars.isGetInfoFromEnemy ) and not( svars.isTargetMarked ) then
			s10052_sequence.ControlInterFlagToCP("afgh_remnants_cp", "set")
		end
		
		TppTrap.Enable( "trap_intelAtRemnants" )
		TppTrap.Enable( "trap_intelMarkAreaRemnants" )

	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_VEHICLE_ARRIVED" ) then
		
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER)
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD)
		s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)

		
		TppEnemy.SetCautionRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.remnantsNorth.transportVehicle.guard[1] )				
		TppEnemy.SetCautionRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.remnantsNorth.guardVehicle.driver[1] )					

		if ( svars.isDiscoverdEscape_Target ) then
			
			TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.remnantsNorth.guardVehicle.driver[1] )					
			TppEnemy.SetCautionRoute(	GUARD_VEHICLE_DRIVER ,		this.routeTable.remnantsNorth.guardVehicle.driver[1] )					
		else
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver[1] )				
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.remnantsNorth.transportVehicle.guard[1] )				
			TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.remnantsNorth.guardVehicle.driver[1] )					
		end
		svars.isDriveTime			= false
		
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_CONVERSATION_START" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver.conversation[1] )	
	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_CONVERSATION_STOP" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver[2] )					
		TppEnemy.SetSneakRoute( 	conversationEnemy ,			this.routeTable.remnantsNorth.conversationEnemy[2] )						

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_MONOLOGUE_FRIEND" ) then
		TppEnemy.SetSneakRoute(		conversationEnemy ,	this.routeTable.remnantsNorth.conversationEnemy.conversation[1] )					
	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_CONVERSATION_RESTART_1" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver.conversation[2] )	
		TppEnemy.SetSneakRoute( 	conversationEnemy ,			this.routeTable.remnantsNorth.conversationEnemy[3] )						
	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_CONVERSATION_RESTART_2" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver[3])					
		TppEnemy.SetSneakRoute( 	conversationEnemy ,			this.routeTable.remnantsNorth.conversationEnemy[4] )						

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_CONVERSATION_LAST" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver.conversation[3] )	

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_GOTO_VEHICLE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver[4] )					
		TppEnemy.UnsetSneakRoute( 	conversationEnemy )																						

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] ==	"REMNANTSNORTH_MONOLOGUE_TO_HOSTAGE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.remnantsNorth.transportVehicle.driver.conversation[4] )	

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "REMNANTSNORTH_VEHICLE_START" ) then
		
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER,	PLAN_2 )
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_2 )
		s10052_enemy.SetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER,		PLAN_2 )
		s10052_enemy.UnsetRouteForVehicleRiders()	

		
		if ( svars.isSkipOnEmergency or svars.isStayPlayerInAnimalTrap or svars.isSkipAnimalEvent ) then
			svars.eventCount = this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"] - 1	
		end
		
		
		this.SetOtherEnemyRouteForRemnantsNorth(false)
		
		svars.isDriveTime			= true		

	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_VEHICLE_ARRIVED" ) then
		
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER)
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD)
		s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)

		
		TppEnemy.SetCautionRoute(		TRANSPORT_VEHICLE_DRIVER ,	"rts_transportVehicle_driver_betweenA_caution_0001" )					
		TppEnemy.SetCautionRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard[1] )				
		TppEnemy.SetCautionRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_A.guardVehicle.driver[1] )					


		if ( svars.isDiscoverdEscape_Target ) then
			
			s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER,	PLAN_3 )
			s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_3 )
			s10052_enemy.SetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER,		PLAN_3 )
			svars.eventCount = this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_ARRIVED"] - 1	
		else
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_A.transportVehicle.driver[1] )				
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard[1] )				
			TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_A.guardVehicle.driver[1] )					
		end
		
		this.EnableEscapeAttributeForAnimal(true)																							
		
		svars.isDriveTime			= false

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_MONOLOGUE_START" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_A.transportVehicle.driver.conversation[1] )	

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_FRIEND_ACT_MOVE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_A.transportVehicle.driver[2] )					
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard[2] )					

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_FRIEND_ACT_FIRE_1" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard[3]  )					
		this.SetEventRouteForAnimal(this.routeTable.betweenBase_A.animal[2])																

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_MONOLOGUE_FRIEND" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard.conversation[1] )		

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_FRIEND_ACT_FIRE_2" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard[4]  )					

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_MONOLOGUE_LAST" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_A.transportVehicle.driver.conversation[2] )	
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_A.transportVehicle.guard[5] )					

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_GOTO_VEHICLE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_A.transportVehicle.driver[3] )					

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_MONOLOGUE_TO_HOSTAGE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_A.transportVehicle.driver.conversation[3] )	

		
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_3 )

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_A_VEHICLE_START" ) then
		
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER,	PLAN_3 )
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_3 )
		s10052_enemy.SetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER,		PLAN_3 )
		s10052_enemy.UnsetRouteForVehicleRiders()	

		
		if ( svars.isSkipOnEmergency ) then
			svars.eventCount = this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"] - 1	
			s10052_enemy.EnableNoticeForAnimal(true)	
			this.SetEventRouteForAnimal(this.routeTable.betweenBase_A.animal[2])															
			
		elseif ( svars.isStayPlayerInAnimalTrap or svars.isSkipAnimalEvent ) then
			svars.eventCount = this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_ARRIVED"] - 1	
			svars.talkCount = this.TALK_SEQUENCE["BETWEEN_B_CONVERSATION_ABOUT_VILLAGE"]
		end
		this.EnableEscapeAttributeForAnimal(false)																							
		svars.isDriveTime			= true
		
	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_B_VEHICLE_ARRIVED" ) then

		
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER)
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD)
		s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)

		
		TppEnemy.SetCautionRoute(		TRANSPORT_VEHICLE_DRIVER ,	"rts_transportVehicle_driver_betweenB_caution_0001" )					
		TppEnemy.SetCautionRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_B.transportVehicle.guard[1] )				
		TppEnemy.SetCautionRoute(		GUARD_VEHICLE_DRIVER ,		"rts_guardVehicle_driver_betweenB_caution_0001" )						

		if ( svars.isDiscoverdEscape_Target ) then
			
			s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER,	PLAN_4 )
			s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_4 )
			s10052_enemy.SetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER,		PLAN_X )	
			svars.eventCount = this.EVENT_SEQUENCE["TENT_VEHICLE_ARRIVED"] - 1	
		else
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_B.transportVehicle.driver[1] )				
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.betweenBase_B.transportVehicle.guard[1] )				
			TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_B.guardVehicle.driver[1] )					
		end
		
		svars.isDriveTime			= false

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_B_CONVERSATION_START" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_B.transportVehicle.driver.conversation[1] )	
		TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_B.guardVehicle.driver[2] )						
	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_B_MONOLOGUE_FRIEND" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_B.transportVehicle.driver.conversation[2] )	
		TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_B.guardVehicle.driver[3] )						

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_B_GOTO_VEHICLE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_B.transportVehicle.driver[3] )					

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_B_MONOLOGUE_TO_HOSTAGE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.betweenBase_B.transportVehicle.driver.conversation[3] )	
		
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "BETWEEN_B_VEHICLE_START" ) then
		
		TppEnemy.UnsetSneakRoute(	TRANSPORT_VEHICLE_DRIVER	)	
		TppEnemy.UnsetSneakRoute(	TRANSPORT_VEHICLE_GUARD		)
		TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_DRIVER	)	
		TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_GUARD		)
		
		
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER,	PLAN_4 )
		s10052_enemy.SetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD,		PLAN_4 )
		
		
		TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_B.guardVehicle.driver[1] )						
		
		
		if ( svars.isSkipOnEmergency ) then
			
			if not(svars.tempSvars_003) then	
				s10052_enemy.SetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER,	PLAN_4 )
			end
		else
			
			TppEnemy.SetSneakRoute(		conversationEnemy ,			this.routeTable.tent.conversationEnemy[1] )
		end

		svars.isDriveTime			= true

	
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_VEHICLE_ARRIVED" ) then
		
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER)
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD)

		if ( svars.isDiscoverdEscape_Target ) then
			
			
		elseif ( svars.isSkipOnEmergency ) then
			
			TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.arrivedOnCaution	)	
			TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.guard.arrivedOnCaution	)	
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.returnEvent 		)	
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.driver.returnEvent 		)	

			
			if not(svars.tempSvars_003) and not(svars.tempSvars_011) then	
				svars.tempSvars_011 = true
				this.DeleteConvoySetting()																								
				TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		"rts_guardVehicle_driver_tent_caution_0001" 		)			
				TppEnemy.SetCautionRoute(	GUARD_VEHICLE_DRIVER ,		"rts_guardVehicle_driver_tent_caution_0001" 		)			
				TppEnemy.SetAlertRoute(		GUARD_VEHICLE_DRIVER ,		"rts_guardVehicle_driver_tent_caution_0001" 		)			
				s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)
			end
			
			svars.eventCount = this.EVENT_SEQUENCE["TENT_GOTO_TORTURE_ROOM"] - 1	
			svars.talkCount = this.TALK_SEQUENCE["TENT_MONOLOGUE_TO_MALAK"]
		else
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver[1] )					
			TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.guard[1] )					
		end
		
		
		this.EnableRestrictNotice(false)

		svars.isVehicleArrivedTent	= true
		svars.isDriveTime			= false

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_CONVERSATION_START" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.conversation[1] )			

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_TURNAROUND_HOSTAGE" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver[2] )						
		TppEnemy.UnsetSneakRoute(	conversationEnemy )																					
		
	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_GOTO_TORTURE_ROOM" ) then
		

		svars.isTargetRideOnVehicleSequence = false

		
		TppEnemy.UnsetSneakRoute(	TRANSPORT_VEHICLE_DRIVER	)	
		TppEnemy.UnsetSneakRoute(	TRANSPORT_VEHICLE_GUARD		)
		TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_DRIVER	)	
		TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_GUARD		)
		
		this.SetHostageWalk( 									this.routeTable.tent.transportVehicle.driver[3] )						
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver[3] )						
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.driver[3] )						
		TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver[3] )						
		TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.driver[3] )						
		this.SetForceFormationLine(true)

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_MONOLOGUE_TO_HOSTAGE" ) then
		
		svars.isSkipOnEmergency = false

		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.conversation[2] )			
		TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.cautionAfterTransport )	
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.guard[2] )						
		TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_GUARD )																			

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_JOIN_SHIFT" ) then
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver[4] )						
		TppEnemy.SetSneakRoute(		EXECUTIONER_TENT ,			this.routeTable.tent.executioner.sneak[2])								
		TppEnemy.SetCautionRoute(	EXECUTIONER_TENT ,			this.routeTable.tent.executioner.caution[2] )							

	
	
	elseif ( this.EVENT_SEQUENCE[svars.eventCount] == "TENT_TRANSPORT_COMPLETE" ) then
		
		this.UnsetRouteForVehicleRiders()
		
		TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.cautionAfterTransport )	
		
	else
		return
	end
	
	
	if ( svars.eventCount < this.EVENT_SEQUENCE["TENT_TRANSPORT_COMPLETE"] or not(svars.isSkipOnEmergency) ) then
		
		s10052_sequence.StartTimer("Timer_SwitchPhaseToCaution_TimeOut", 300)
	end

	svars.eventCount = svars.eventCount + 1			
	s10052_radio.SetOptionalRadioFromSituation()	
	s10052_radio.SetIntelRadioFromSituation()		
	s10052_sequence.CheckSituationForPhaseBGM()		

end



this.UnsetRouteForVehicleRiders = function()
	
	TppEnemy.UnsetSneakRoute(	TRANSPORT_VEHICLE_DRIVER	)	
	TppEnemy.UnsetSneakRoute(	TRANSPORT_VEHICLE_GUARD		)
	if ( this.CheckExecuteFlag() ) then
		if(svars.eventCount == this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"])then
			TppEnemy.UnsetSneakRoute(	GUARD_VEHICLE_DRIVER		)
		elseif(svars.eventCount == this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"])then
			TppEnemy.UnsetSneakRoute(	GUARD_VEHICLE_DRIVER		)
		elseif(svars.eventCount == this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"])then
			TppEnemy.UnsetSneakRoute(	GUARD_VEHICLE_DRIVER		)
		elseif(svars.eventCount == this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"])then
			TppEnemy.UnsetSneakRoute(	GUARD_VEHICLE_DRIVER		)
		else
			
		end
	end
	
	TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_DRIVER	)	
	TppEnemy.UnsetCautionRoute(	TRANSPORT_VEHICLE_GUARD		)	

	if ( this.CheckExecuteFlag() ) then
		if(svars.eventCount == this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"])then
			TppEnemy.UnsetCautionRoute(	GUARD_VEHICLE_DRIVER		)	
		elseif(svars.eventCount == this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"])then
			TppEnemy.UnsetCautionRoute(	GUARD_VEHICLE_DRIVER		)	
		elseif(svars.eventCount == this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"])then
			TppEnemy.UnsetCautionRoute(	GUARD_VEHICLE_DRIVER		)	
		elseif(svars.eventCount == this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"])then
			TppEnemy.UnsetCautionRoute(	GUARD_VEHICLE_DRIVER	)
		else
			
		end
	end
	



end



this.SetRouteExecutionerRemnants = function ()
	Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants ####" )
	Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### executeRouteName_S:NOW = " .. tostring(svars.executeRouteName_S) )
	Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### executeRouteName_C:NOW = " .. tostring(svars.executeRouteName_C) )

	local hostageName = "initName"	
	local nextRoute_S = ""
	local nextRoute_C = ""

	
	if ( svars.isDiscoverdEscape_1 == false and svars.executeRouteName_S == StrCode32( this.routeTable.remnants.executioner.killHostage.sneak[1] ) ) then
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### KILL_ROUTE = " ..this.routeTable.remnants.executioner.killHostage.sneak[1] )
		hostageName = HOSTAGE_01
		nextRoute_S = this.routeTable.remnants.executioner.killHostage.sneak[2]
		nextRoute_C = this.routeTable.remnants.executioner.killHostage.caution[2]
		svars.executeRouteName_S = StrCode32( nextRoute_S )
		svars.executeRouteName_C = StrCode32( nextRoute_C )
		
	elseif ( svars.isDiscoverdEscape_2 == false and svars.executeRouteName_S == StrCode32( this.routeTable.remnants.executioner.killHostage.sneak[2] ) ) then
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### KILL_ROUTE = " ..this.routeTable.remnants.executioner.killHostage.sneak[2] )
		hostageName = HOSTAGE_02
		nextRoute_S = this.routeTable.remnants.executioner.killHostage.sneak[3]
		nextRoute_C = this.routeTable.remnants.executioner.killHostage.caution[3]
		svars.executeRouteName_S = StrCode32( nextRoute_S )
		svars.executeRouteName_C = StrCode32( nextRoute_C )
		
	elseif ( svars.isDiscoverdEscape_3 == false and svars.executeRouteName_S == StrCode32( this.routeTable.remnants.executioner.killHostage.sneak[3] ) ) then
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### KILL_ROUTE = " ..this.routeTable.remnants.executioner.killHostage.sneak[3] )
		hostageName = HOSTAGE_03	

	else
		
		this.SetRouteExecutionerRemnants_ErrorTracer(hostageName)
	end


	
	Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### hostageName = " .. hostageName )

	
	if ( hostageName ~= "initName" ) then
		local gameObjectId = GameObject.GetGameObjectId("TppSoldier2", EXECUTIONER_REMNANTS )	
		local hostageId = GameObject.GetGameObjectId("TppHostage2", hostageName )				
		local command = { id="SetExecuteHostage", targetId=hostageId }							
		GameObject.SendCommand( gameObjectId, command )										
	
	
	elseif ( hostageName == "initName" ) then
		
		if ( svars.executeRouteName_S == StrCode32( this.routeTable.remnants.executioner.killHostage.sneak[1] ) ) then
			nextRoute_S = this.routeTable.remnants.executioner.killHostage.sneak[2]
			nextRoute_C = this.routeTable.remnants.executioner.killHostage.caution[2]
			svars.executeRouteName_S = StrCode32( nextRoute_S )
			svars.executeRouteName_C = StrCode32( nextRoute_C )

		elseif ( svars.executeRouteName_S == StrCode32( this.routeTable.remnants.executioner.killHostage.sneak[2] ) ) then
			nextRoute_S = this.routeTable.remnants.executioner.killHostage.sneak[3]
			nextRoute_C = this.routeTable.remnants.executioner.killHostage.caution[3]
			svars.executeRouteName_S = StrCode32( nextRoute_S )
			svars.executeRouteName_C = StrCode32( nextRoute_C )
			
		elseif ( svars.executeRouteName_S == StrCode32( this.routeTable.remnants.executioner.killHostage.sneak[3] ) ) then
			
			
		else
			
			this.SetRouteExecutionerRemnants_ErrorTracer(hostageName)
		end
		
	else
		
		this.SetRouteExecutionerRemnants_ErrorTracer(hostageName)
	end

	
	if( nextRoute_S == "" ) then
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### Execution finished!")
		svars.tempSvars_002 = true	

		TppEnemy.UnsetSneakRoute( EXECUTIONER_REMNANTS )
		TppEnemy.UnsetCautionRoute( EXECUTIONER_REMNANTS )

	else
		TppEnemy.SetSneakRoute( EXECUTIONER_REMNANTS , nextRoute_S )
		TppEnemy.SetCautionRoute( EXECUTIONER_REMNANTS , nextRoute_C )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### executeRouteName_S:NEXT = " .. tostring(nextRoute_S) )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### executeRouteName_C:NEXT = " .. tostring(nextRoute_C) )
	end
end



this.SetRouteExecutionerRemnants_ErrorTracer = function (hostageName)
		
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! ERROR TRACER : START !!" )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! hostageName = " .. hostageName )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! svars.isDiscoverdEscape_1 = " .. tostring(svars.isDiscoverdEscape_1) )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! svars.isDiscoverdEscape_2 = " .. tostring(svars.isDiscoverdEscape_2) )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! svars.isDiscoverdEscape_3 = " .. tostring(svars.isDiscoverdEscape_3) )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! executeRouteName_S:NOW = " .. tostring(svars.executeRouteName_S) )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! executeRouteName_C:NOW = " .. tostring(svars.executeRouteName_C) )
		Fox.Log( "#### s10052_enemy.SetRouteExecutionerRemnants #### !! ERROR TARCER : END !!" )
end



this.SetEndRouteExecutionerTent = function ()
	if ( not svars.isTargetRescue ) then
		Fox.Log("#### s10052_enemy.SetEndRouteExecutionerTent ####")
		TppEnemy.SetSneakRoute( EXECUTIONER_TENT , this.routeTable.tent.executioner.sneak[3] )
		TppEnemy.SetCautionRoute( EXECUTIONER_TENT , this.routeTable.tent.executioner.caution[3] )
	end
end



this.SetEmergencyRide = function ()
	svars.isSkipOnEmergency = true

	
	if( svars.eventCount > this.EVENT_SEQUENCE["TENT_TURNAROUND_HOSTAGE"] )then
		Fox.Log( "#### s10052_enemy.SetEmergencyRide #### EVENT_SEQUENCE["..this.EVENT_SEQUENCE[svars.eventCount].."] > TENT_TURNAROUND_HOSTAGE")

		
		svars.isSkipOnEmergency = false
		
	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"] + 1 )then
		Fox.Log( "#### s10052_enemy.SetEmergencyRide #### EVENT_SEQUENCE["..this.EVENT_SEQUENCE[svars.eventCount].."] > BETWEEN_B_VEHICLE_START")

		
		TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.arrivedOnCaution	)	
		TppEnemy.SetCautionRoute(	TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.guard.arrivedOnCaution	)	
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.returnEvent 		)	
		TppEnemy.SetSneakRoute(		TRANSPORT_VEHICLE_GUARD ,	this.routeTable.tent.transportVehicle.driver.returnEvent 		)	
		
		svars.eventCount = this.EVENT_SEQUENCE["TENT_TURNAROUND_HOSTAGE"] - 1	
		svars.talkCount = this.TALK_SEQUENCE["TENT_MONOLOGUE_TO_MALAK"]
		
	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"] + 1 )then
		Fox.Log( "#### s10052_enemy.SetEmergencyRide #### EVENT_SEQUENCE["..this.EVENT_SEQUENCE[svars.eventCount].."] > BETWEEN_A_VEHICLE_START")
		svars.eventCount = this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"]
		
	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"] + 1 )then
		Fox.Log( "#### s10052_enemy.SetEmergencyRide #### EVENT_SEQUENCE["..this.EVENT_SEQUENCE[svars.eventCount].."] > REMNANTSNORTH_VEHICLE_START")
		svars.eventCount = this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"]
		
	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"] + 1 )then
		Fox.Log( "#### s10052_enemy.SetEmergencyRide #### EVENT_SEQUENCE["..this.EVENT_SEQUENCE[svars.eventCount].."] > REMNANTS_VEHICLE_START")
		svars.eventCount = this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"]

	
	else
		Fox.Log( "#### s10052_enemy.SetEmergencyRide #### EVENT_SEQUENCE["..this.EVENT_SEQUENCE[svars.eventCount].."] < REMNANTS_VEHICLE_START")
		svars.eventCount = this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"]
	end

	if ( svars.isSkipOnEmergency ) and this.CheckExecuteFlag() then
		
		this.SetRouteDrivers()
	else
		
		this.JoinToActorToNearestBase()
	end
	
	if not( svars.tempSvars_009 ) then
		
		this.EnableForceRailDriveSpeedFAST(true)
	end

end



this.SetEndRouteDriversOnCaution = function ()
	Fox.Log("#### s10052_enemy.SetEndRouteDriversOnCaution ####")
	
	
	svars.isVehicleArrivedTent_Caution = true
	
	
	svars.eventCount = this.EVENT_SEQUENCE.TENT_GOTO_TORTURE_ROOM	

	
	TppEnemy.SetCautionRoute( TRANSPORT_VEHICLE_DRIVER ,	this.routeTable.tent.transportVehicle.driver.arrivedOnCaution )
	TppEnemy.SetCautionRoute( TRANSPORT_VEHICLE_GUARD ,		this.routeTable.tent.transportVehicle.guard.arrivedOnCaution )

	
	TppEnemy.SetSneakRoute( TRANSPORT_VEHICLE_DRIVER ,		this.routeTable.tent.transportVehicle.driver.returnEvent )
	TppEnemy.SetSneakRoute( TRANSPORT_VEHICLE_GUARD ,		this.routeTable.tent.transportVehicle.driver.returnEvent )	

end



this.CheckRouteUsingSoldier = function( routeName )
	Fox.Log("#### s10052_enemy.CheckRoute #### routeName = "..tostring(routeName))

	if routeName == nil then
		return
	end

	local gameObjectId = { type="TppSoldier2" } 
	local command = { id="GetGameObjectIdUsingRoute", route=routeName }
	local soldiers = GameObject.SendCommand( gameObjectId, command )
	
	if soldiers[1] == nil then
		return
	else
		return soldiers[1]	
	end
end



this.SearchNormalEnemyFrom = function( targetCp )
	if this.soldierDefine[targetCp] == nil then
		Fox.Log("#### s10052_enemy.SearchNormalEnemyFrom(" ..tostring(targetCp).. ") #### targetCp is nil...")
		return
	else

	end
	
	
	for i, enemyName in pairs( this.soldierDefine[targetCp] ) do
		local lifeState = TppEnemy.GetLifeStatus( enemyName )
		if ( lifeState == TppEnemy.LIFE_STATUS.NORMAL ) then
			local actionState = TppEnemy.GetStatus( enemyName )
			local nomalState = 1 
			if ( actionState == nomalState) then
				Fox.Log("#### s10052_enemy.SearchNormalEnemyFrom(" ..targetCp.. ") #### "..enemyName.. " is NORMAL!")

				return enemyName
			else

			end
		else

		end
	end
	
	
	Fox.Log("#### s10052_enemy.SearchNormalEnemyFrom(" ..targetCp.. ") #### check finished!")
	return nil
end



this.SearchNormalEnemyFromSequence = function()
	Fox.Log("#### s10052_enemy.SearchNormalEnemyFromSequence #### EVENT_SEQUENCE = "..this.EVENT_SEQUENCE[svars.eventCount])
	
	if( svars.eventCount >= this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"] and
		svars.eventCount <= this.EVENT_SEQUENCE["TENT_GOTO_TORTURE_ROOM"] )then
		
		return this.SearchNormalEnemyFrom("afgh_tent_cp")
		
	elseif( svars.eventCount >= this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"] and
			svars.eventCount <= this.EVENT_SEQUENCE["REMNANTSNORTH_MONOLOGUE_TO_HOSTAGE"] )then
		
		return this.SearchNormalEnemyFrom("afgh_remnantsNorth_ob")
		
	else
		Fox.Log("#### s10052_enemy.SearchNormalEnemyFromSequence #### This sequence does not need normal enenmy...")
		return false
	end
end



this.SetOtherEnemyRouteForRemnantsNorth = function(flag)
	if(flag)then
		TppEnemy.SetSneakRoute("sol_remnantsNorth_0000","rts_remnantsNorth_wait_0001")
		TppEnemy.SetSneakRoute("sol_remnantsNorth_0001","rts_remnantsNorth_wait_0002")
		TppEnemy.SetSneakRoute("sol_remnantsNorth_0002","rts_remnantsNorth_wait_0003")
		TppEnemy.SetSneakRoute("sol_remnantsNorth_0003","rts_remnantsNorth_wait_0004")
	else
		TppEnemy.UnsetSneakRoute("sol_remnantsNorth_0000")
		TppEnemy.UnsetSneakRoute("sol_remnantsNorth_0001")
		TppEnemy.UnsetSneakRoute("sol_remnantsNorth_0002")
		TppEnemy.UnsetSneakRoute("sol_remnantsNorth_0003")
	end
end



this.SetUpRegisterMessage = function()
	local CHECK_PHASE_MEMBER =	{
		TRANSPORT_VEHICLE_DRIVER,
		TRANSPORT_VEHICLE_GUARD,
		GUARD_VEHICLE_DRIVER,
	}
	local command = { id = "RegisterMessage", message="ChangePhase", isRegistered=true }

	for i , enemyName in pairs( CHECK_PHASE_MEMBER ) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		Fox.Log( "#### s10052_enemy.SetUpRegisterMessage #### targetId = "..gameObjectId )

		GameObject.SendCommand( gameObjectId, command )
	end
end



this.CheckPhaseChange = function (gameObjectId, phaseName)
	local executeFlag = false
	local CHECK_PHASE_MEMBER =	{
		TRANSPORT_VEHICLE_DRIVER,
		TRANSPORT_VEHICLE_GUARD,
		GUARD_VEHICLE_DRIVER,
	}
	
	if ( svars.tempSvars_003 ) then
		CHECK_PHASE_MEMBER = {
			TRANSPORT_VEHICLE_DRIVER,
			TRANSPORT_VEHICLE_GUARD,
		}
	end
	
	
	for i , enemyName in pairs( CHECK_PHASE_MEMBER ) do
		local checkEnemy = GameObject.GetGameObjectId( enemyName )
		
		if ( checkEnemy == gameObjectId ) then
			if ( phaseName >= TppGameObject.PHASE_CAUTION ) then
				Fox.Log( "#### s10052_enemy.CheckPhaseChange #### Enemy ["..checkEnemy.."] and Phase ["..phaseName.."] is OK!!" )
				executeFlag = true
			end
		end
	end
	
	
	if ( svars.eventCount <= this.EVENT_SEQUENCE["TENT_VEHICLE_ARRIVED"] ) then
		if (svars.tempSvars_010) then
			
			this.EnableRestrictNotice(false)
		else
			
			this.EnableRestrictNotice(true)
		end
	end

	
	if ( executeFlag and not(svars.isOverlapCheckPhase) ) then
		Fox.Log("#### s10052_enemy.CheckPhaseChange #### Execute this Function.")
		
		
		this.SetEmergencyRide()
		
		svars.isOverlapCheckPhase = true
	else
		Fox.Log( "#### s10052_enemy.CheckPhaseChange #### Not Execute this Function. Because executeFlag = "..tostring(executeFlag).. ", isOverLapCheckPhase = " ..tostring(svars.isOverlapCheckPhase) )
	end
end



this.EnableRestrictNotice = function( enableFlag )
	local RESTRICT_MEMBER =	{
		TRANSPORT_VEHICLE_DRIVER,
		TRANSPORT_VEHICLE_GUARD,
		
	}
	local command = { id="SetRestrictNotice", enabled = enableFlag }

	for i , enemyName in pairs( RESTRICT_MEMBER ) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		Fox.Log( "#### s10052_enemy.SetRestrictNotice #### targetId = "..gameObjectId..", enabled = "..tostring(enableFlag) )

		GameObject.SendCommand( gameObjectId, command )
	end
end



this.CheckMainActorStatus = function()
	
	local CHECK_ENEMY = {
		TRANSPORT_VEHICLE_DRIVER,
		TRANSPORT_VEHICLE_GUARD,
		GUARD_VEHICLE_DRIVER,
	}

	
	if ( svars.eventCount >= this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"] ) then
		CHECK_ENEMY = {
			TRANSPORT_VEHICLE_DRIVER,
			TRANSPORT_VEHICLE_GUARD,
		}
	end

	
	Fox.Log("#### s10052_enemy.CheckMainActorStatus #### Check start!")
	for i, checkEnemy in pairs (CHECK_ENEMY ) do
		if ( TppEnemy.IsNeutralized(checkEnemy) ) then
			Fox.Log( "#### s10052_enemy.CheckMainActorStatus #### ["..tostring(checkEnemy).."] is neutralized...")
			
			s10052_sequence.StartTimer("Timer_SwitchPhaseToCaution", 5)
			
		else
			Fox.Log( "#### s10052_enemy.CheckMainActorStatus #### ["..tostring(checkEnemy).."] is OK!")
		end
	end
	Fox.Log( "#### s10052_enemy.CheckMainActorStatus #### Check end!")
end



this.SwitchPhaseToCaution = function()
	local isNeutralizeDriver	= TppEnemy.IsNeutralized(TRANSPORT_VEHICLE_DRIVER)
	local isNeutralizeGuard		= TppEnemy.IsNeutralized(TRANSPORT_VEHICLE_GUARD)
	local radioPlayer			= TRANSPORT_VEHICLE_DRIVER
	local radioLabel			= "CPR0050"

	
	if (isNeutralizeDriver) then
		radioPlayer = TRANSPORT_VEHICLE_GUARD
		if (isNeutralizeGuard) then
			radioPlayer = GUARD_VEHICLE_DRIVER
		end
	end

	if not(svars.tempSvars_001) and not(svars.isSkipOnEmergency) then
		Fox.Log( "#### s10052_enemy.SwitchPhaseToCaution #### radioPlayer = "..tostring(radioPlayer))
		
		local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", radioPlayer )
		local command = { id="CallRadio", label=radioLabel, stance="Squat" }
		GameObject.SendCommand( gameObjectId, command )

		svars.tempSvars_001	= true	
	end
end



this.EnableSoldierOnLrrp_21_24 = function(enableFlag)
	local targetCp = "afgh_21_24_lrrp"
	local illigalId = 65535	

	for i, enemyName in pairs( this.soldierDefine[targetCp] ) do
		local targetId = GameObject.GetGameObjectId( "TppSoldier2", enemyName )
		if not( targetId == illigalId ) then
			local command = { id = "SetEnabled", enabled = enableFlag }
			GameObject.SendCommand( targetId , command )
			Fox.Log("#### s10052_enemy.EnableSoldierOnLrrp_21_24 #### targetId = " ..tostring(targetId).. ", enabled = " ..tostring(enableFlag))
		end
	end
end



this.SetForceFormationLine = function(enableFlag)
	local FORMATION_MEMBER =	{
		TRANSPORT_VEHICLE_DRIVER,
		TRANSPORT_VEHICLE_GUARD,
	}
	local command = { id = "SetForceFormationLine", enable = enableFlag }

	for i , enemyName in pairs( FORMATION_MEMBER ) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		Fox.Log( "#### s10052_enemy.SetForceFormationLine #### targetId = "..gameObjectId..", enabled = "..tostring(enableFlag) )

		GameObject.SendCommand( gameObjectId, command )
	end
end



this.SwitchRouteByLostVehicle = function()
	
	this.EnableRestrictNotice(false)

	
	if ( this.CheckAliveVehicle(TRANSPORT_VEHICLE) ) then
		Fox.Log("#### s10052_enemy.SwitchRouteByLostVehicle #### targetVehicle alive!")
		
		this.SetFormationAround(TRANSPORT_VEHICLE)
		
	else
		Fox.Log("#### s10052_enemy.SwitchRouteByLostVehicle #### targetVehicle not alive...")
		this.SetHostageExecutionFlag()	
		if not(svars.tempSvars_003)then
			this.SetFormationAround(GUARD_VEHICLE)
		end
	end
end



this.SetFormationAround = function(target)
	
	local targetVehicle	= GameObject.GetGameObjectId("TppVehicle2", target)
	local driverPos		= 2
	local guardPos		= 3

	if not(this.CheckAliveVehicle(target)) then
		return
	end

	if( target == GUARD_VEHICLE )then
		driverPos	= 0
		guardPos	= 1
	end

	
	local soldierId = GameObject.GetGameObjectId("TppSoldier2", TRANSPORT_VEHICLE_DRIVER )
	local command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = targetVehicle, formationIndex = driverPos } 
	GameObject.SendCommand( soldierId, command )
	
	
	soldierId = GameObject.GetGameObjectId("TppSoldier2", TRANSPORT_VEHICLE_GUARD )
	command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = targetVehicle, formationIndex = guardPos } 
	GameObject.SendCommand( soldierId, command )
	
	
	soldierId = GameObject.GetGameObjectId("TppSoldier2", GUARD_VEHICLE_DRIVER )
	command = { id="SetCommandAi", commandType = CommandAi.ESCORT, vehicle = GUARD_VEHICLE, formationIndex = 0 } 
	GameObject.SendCommand( soldierId, command )

end



this.JoinToActorToNearestBase = function()
	if(svars.eventCount >= this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_ARRIVED"]) and (svars.eventCount < this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"]) then
		s10052_enemy.SetEmergencyRide()
		
	elseif(svars.eventCount >= this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_ARRIVED"]) and (svars.eventCount < this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"]) then
		s10052_enemy.SwitchPhaseToCaution()
	
	
	elseif(svars.eventCount == this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"]) then
	elseif(svars.eventCount == this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"]) then
	elseif(svars.eventCount == this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"]) then
	elseif(svars.eventCount == this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"]) then
	else
		
		s10052_enemy.UnsetRouteForVehicleRiders()
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_DRIVER)
		s10052_enemy.UnsetTravelPlanForEventVehicle(TRANSPORT_VEHICLE_GUARD)
		s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)
	end
end



this.UnsetTravelPlanForException = function()
	if(svars.eventCount >= this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_ARRIVED"]) and (svars.eventCount <= this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"]) then
		TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.remnantsNorth.guardVehicle.driver[1] )
		TppEnemy.SetCautionRoute(	GUARD_VEHICLE_DRIVER ,		this.routeTable.remnantsNorth.guardVehicle.driver[1] )
		s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)	
	elseif(svars.eventCount >= this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_ARRIVED"]) and (svars.eventCount <= this.EVENT_SEQUENCE["BETWEEN_B_VEHICLE_START"]) then
		if(svars.tempSvars_012)then
			TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		"rts_guardVehicle_driver_betweenB_caution_0001" )
			TppEnemy.SetCautionRoute(	GUARD_VEHICLE_DRIVER ,		"rts_guardVehicle_driver_betweenB_caution_0001" )
		else
			TppEnemy.SetSneakRoute(		GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_A.guardVehicle.driver[1] )
			TppEnemy.SetCautionRoute(	GUARD_VEHICLE_DRIVER ,		this.routeTable.betweenBase_A.guardVehicle.driver[1] )
		end
		s10052_enemy.UnsetTravelPlanForEventVehicle(GUARD_VEHICLE_DRIVER)	
	end
end





this.SetHostageWalk = function ( hostageRoute )
	Fox.Log( "#### s10052_enemy.SetHostageWalk ####" )

	
	if ( svars.isTargetRescue == false ) then
		local gameObjectId = GameObject.GetGameObjectId("TppHostage2", TARGET_HOSTAGE)
		local command = { id = "SetSneakRoute", route = hostageRoute, }
		GameObject.SendCommand( gameObjectId, command )	
	else
		return
	end
end



this.SetHostageRideVehicle = function ( isGetOffVehicle )
	
	if not(svars.isTargetRescue) and not(svars.tempSvars_010) then
		Fox.Log( "#### s10052_enemy.SetHostageRideVehicle #### isGetOffVehicle = "..tostring(isGetOffVehicle) )
		local gameObjectId = GameObject.GetGameObjectId("TppHostage2", TARGET_HOSTAGE)		
		local rideVehicleId = GameObject.GetGameObjectId("TppVehicle2", TRANSPORT_VEHICLE)	
		local command = {
			id			=	"RideVehicle",
			vehicleId	=	rideVehicleId,
			off			=	isGetOffVehicle,	
		}
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log( "#### s10052_enemy.SetHostageRideVehicle #### This function does not execute. Because svars.isTargetRescue = "..tostring(svars.isTargetRescue) )
		return
	end
	
	if ( isGetOffVehicle == false ) then
		
		svars.isTargetRideOnVehicleSequence = true
	else
		svars.isTargetRideOnVehicleSequence = false
	end	
end



this.SetEndRouteHostage = function ()
	Fox.Log("#### s10052_enemy.SetEndRouteHostage ####")
	
	local gameObjectId = GameObject.GetGameObjectId( "TppHostage2", TARGET_HOSTAGE )
	
	
	local command = {
			id = "SetSneakRoute",
			route = "", 
	}
	GameObject.SendCommand( gameObjectId, command )	
end



this.SetTargetDistanceCheck = function()
	Fox.Log("#### s10052_enemy.SetTargetDistanceCheck ####")

	local command = { id = "SetPlayerDistanceCheck", enabled = true, near = 50, far = 55 }
	GameObject.SendCommand( GameObject.GetGameObjectId( TARGET_HOSTAGE ), command )
end



this.EnableFollowedSetting = function(enableFlag)
	Fox.Log("#### s10052_enemy.EnableFollowedSetting #### enable = " ..tostring(enableFlag))
	local gameObjectId = GameObject.GetGameObjectId( TARGET_HOSTAGE )
	local command = { id = "SetFollowed", enable = enableFlag }
	GameObject.SendCommand( gameObjectId, command )
end



this.SetHostageLangType = function(target,lang)
	local gameObjectId = GameObject.GetGameObjectId( target )
	local command = { id = "SetLangType", langType = lang }
	GameObject.SendCommand( gameObjectId, command )
end



this.SetHostageVoiceType = function(target,voice)
	local gameObjectId = GameObject.GetGameObjectId( target )
	local command = { id = "SetVoiceType", voiceType = voice }
	GameObject.SendCommand( gameObjectId, command )
end



this.SetHostageExecutionFlag = function()
	local gameObjectId = GameObject.GetGameObjectId( TARGET_HOSTAGE )
	local command = { id = "SetNoticeState", state = TppGameObject.HOSTAGE_NOTICE_STATE_FLEE }
	
end



this.CheckHostageRideVehicle = function()
	local gameObjectId = GameObject.GetGameObjectId( TARGET_HOSTAGE )
	local command = { id = "GetRideVehicleState" }
	local type, vehicleId, seatIndex = GameObject.SendCommand( gameObjectId, command )
	local target = GameObject.GetGameObjectId( "TppVehicle2", TRANSPORT_VEHICLE )
	local flag = false
	
	if vehicleId == target then
		flag = true
	end
	return flag
end






this.CallConversation = function(targetA, targetB, targetLabel)
	Fox.Log("#### s10052_enemy.CallConversation #### targetA = "..tostring(targetA)..", targetB = "..tostring(targetB)..", targetLabel = "..tostring(targetLabel))

	local gameObjectType = "TppSoldier2"
	local locatorNameA = targetA
	local locatorNameB = targetB

	
	if Tpp.IsTypeString(locatorNameA) then
		locatorNameA = GameObject.GetGameObjectId(gameObjectType, locatorNameA)
	end
	if Tpp.IsTypeString(locatorNameB) then
		locatorNameB = GameObject.GetGameObjectId(gameObjectType, locatorNameB)
	end
	
	GameObject.SendCommand( locatorNameA, {
		id		= "CallConversation",
		label	= targetLabel,
		friend	= locatorNameB,
		range	= 50,
	} )
	
	
	s10052_radio.CheckSituationAndPlayRadio()

end




this.CallMonologue = function( speakerId, targetLabel )
	Fox.Log("#### s10052_enemy.CallMonologue #### speakerId = " ..tostring(speakerId).. ", targetLabel = " ..tostring(targetLabel))

	local gameObjectType = "TppHostage2"

	
	if Tpp.IsTypeString( speakerId ) then
		speakerId = GameObject.GetGameObjectId( gameObjectType, speakerId )
	end
	
	local command = { id="CallMonologue", label = targetLabel,	carry = true }
	GameObject.SendCommand( speakerId, command )

end



this.StartConversation = function()
	Fox.Log("#### s10052_enemy.StartConversation #### EVENT_SEQUENCE= " .. tostring(this.TALK_SEQUENCE[svars.talkCount]) )

	
	local conversationEnemy = this.SearchNormalEnemyFromSequence()
	
	
	if ( this.TALK_SEQUENCE[svars.talkCount] ==			"REMNANTS_CONVERSATION_ABOUT_ORDERS"		) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, EXECUTIONER_REMNANTS,		this.voiceTable.remnants.conversation[1])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"REMNANTS_MONOLOGUE_TO_MALAK"				) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.remnants.monologue[1])


	
	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"REMNANTSNORTH_CONVERSATION_ABOUT_MALAK" 	) then
		
		this.CallConversation(conversationEnemy, TRANSPORT_VEHICLE_DRIVER,			this.voiceTable.remnantsNorth.conversation[1])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"REMNANTSNORTH_MONOLOGUE_IS_SOMEONE_THERE"	) then
		
		this.CallConversation(conversationEnemy, conversationEnemy,				this.voiceTable.remnantsNorth.monologue[1])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"REMNANTSNORTH_CONVERSATION_DONT_SCARE_ME"	) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, conversationEnemy,			this.voiceTable.remnantsNorth.conversation[2])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"REMNANTSNORTH_CONVERSATION_ABOUT_RUMORS"	) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, conversationEnemy,			this.voiceTable.remnantsNorth.conversation[3])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"REMNANTSNORTH_MONOLOGUE_TO_MALAK"			) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.remnantsNorth.monologue[2])

	
	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_A_MONOLOGUE_TO_FRIEND"				) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.betweenBase_A.monologue[1])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_A_MONOLOGUE_TO_ANIMALS"			) then
		
		this.CallConversation(TRANSPORT_VEHICLE_GUARD, TRANSPORT_VEHICLE_GUARD,	this.voiceTable.betweenBase_A.monologue[2])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_A_MONOLOGUE_GET_BACK_VEHICLES"		) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.betweenBase_A.monologue[3])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_A_MONOLOGUE_TO_MALAK"				) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.betweenBase_A.monologue[4])
		

	
	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_B_CONVERSATION_ABOUT_VILLAGE"		) then
		
		this.CallConversation(GUARD_VEHICLE_DRIVER,		TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.betweenBase_B.conversation[1])
	
	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_B_MONOLOGUE_ABOUT_MALAK"			) then
		
		this.CallConversation(GUARD_VEHICLE_DRIVER,		GUARD_VEHICLE_DRIVER,		this.voiceTable.betweenBase_B.monologue[1])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"BETWEEN_B_MONOLOGUE_TO_MALAK"				) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.betweenBase_B.monologue[2])


	
	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"TENT_CONVERSATION_ABOUT_DESTINATION"		) then
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, conversationEnemy,			this.voiceTable.tent.conversation[1])

	elseif ( this.TALK_SEQUENCE[svars.talkCount] ==	"TENT_MONOLOGUE_TO_MALAK"					) then
		
		this.CallConversation(TRANSPORT_VEHICLE_DRIVER, TRANSPORT_VEHICLE_DRIVER,	this.voiceTable.tent.monologue[1])

	else
		Fox.Log("#### s10052_enemy.StartConversation #### Does not match [svar.talkCount]...")

	end
	
	svars.isTalkTime = true
	s10052_radio.SetOptionalRadioFromSituation()	
	s10052_radio.SetIntelRadioFromSituation()		
end



this.SearchLabelFromConversationEndMessage = function(targetLabel)
	local LABEL_TABLE = {
		"speech52_EV010",
		"speech52_EV011",
		"speech52_EV020",
		"speech52_EV021",
		"speech52_EV022",
		"speech52_EV023",
		"speech52_EV024",
		"speech52_EV030",
		"speech52_EV031",
		"speech52_EV032",
		"speech52_EV033",
		"speech52_EV040",
		"speech52_EV041",
		"speech52_EV042",
		"speech52_EV050",
		"speech52_EV051",
	}

	for i, searchLabel in pairs( LABEL_TABLE ) do
		if ( targetLabel == Fox.StrCode32(searchLabel) ) then
			Fox.Log("#### s10052_enemy.SearchLabelFromConversationEndMessage #### targetLabel [" ..tostring(targetLabel).. "] is event label!")
			return true
		end
	end
	Fox.Log("#### s10052_enemy.SearchLabelFromConversationEndMessage #### targetLabel [" ..tostring(targetLabel).. "] is not event label...")
	return false
end



this.DisableOccasionalChatFor = function( targetEnemy, disableFlag )
	if ( targetEnemy == nil ) then
		
		return
	end
	
	
	if ( disableFlag == nil ) then
		return
	end

	local illigalId = 65535	
	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", targetEnemy )
	if not(gameObjectId == illigalId) then
		local command = { id="SetDisableOccasionalChat", disable=disableFlag }
		GameObject.SendCommand( gameObjectId, command )
		Fox.Log("#### s10052_enemy.DisableOccasionalChatFor #### targetEnemy = " ..tostring(targetEnemy)..", disableFlag = " ..tostring(disableFlag))
	end
end



this.DisableOccasionalChatForEnemyFrom = function( targetCp, disableFlag )
	if this.soldierDefine[targetCp] == nil then
		Fox.Log("#### s10052_enemy.DisableOccasionalChatForEnemyFrom(" ..tostring(targetCp).. ") #### targetCp is nil...")
		return
	end

	if ( disableFlag == nil ) then
		return
	end

	Fox.Log("#### s10052_enemy.DisableOccasionalChatForEnemyFrom(" ..tostring(targetCp).. ") #### disableFlag = " ..tostring(disableFlag))
	for i, enemyName in pairs( this.soldierDefine[targetCp] ) do
		this.DisableOccasionalChatFor(enemyName, disableFlag )
	end

end



this.SetDisableOccasionalChatOnSequence = function()
	
	
	if( svars.eventCount > this.EVENT_SEQUENCE["TENT_JOIN_SHIFT"] )then
		
		this.DisableOccasionalChatForEnemyFrom("afgh_tent_cp",false)
		this.DisableOccasionalChatForEnemyFrom("afgh_06_24_lrrp",false)	
		this.DisableOccasionalChatForEnemyFrom("afgh_21_24_lrrp",false)	
		this.DisableOccasionalChatForEnemyFrom("afgh_22_24_lrrp",false)	
	
	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["BETWEEN_A_VEHICLE_START"] )then
		
		this.DisableOccasionalChatForEnemyFrom("afgh_tent_cp",true)
		this.DisableOccasionalChatForEnemyFrom("afgh_06_24_lrrp",true)	
		this.DisableOccasionalChatForEnemyFrom("afgh_22_24_lrrp",true)	

	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["REMNANTSNORTH_VEHICLE_START"] )then
		
		this.DisableOccasionalChatForEnemyFrom("afgh_remnantsNorth_ob",false)
		this.DisableOccasionalChatForEnemyFrom("afgh_21_28_lrrp",false)	

	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["REMNANTS_VEHICLE_START"] )then
		
		this.DisableOccasionalChatForEnemyFrom("afgh_remnants_cp",false)
		this.DisableOccasionalChatForEnemyFrom("afgh_20_28_lrrp",false)	

	
	elseif( svars.eventCount > this.EVENT_SEQUENCE["REMNANTS_MONOLOGUE_TO_HOSTAGE"] )then
		
		this.DisableOccasionalChatForEnemyFrom("afgh_21_24_lrrp",true)	
		this.DisableOccasionalChatForEnemyFrom("afgh_remnantsNorth_ob",true)

	
	else
		
		this.DisableOccasionalChatForEnemyFrom("afgh_21_28_lrrp",true)	
		this.DisableOccasionalChatForEnemyFrom("afgh_remnants_cp",true)
		this.DisableOccasionalChatForEnemyFrom("afgh_20_28_lrrp",true)	
		
	end
	
	
	
	if( svars.eventCount > this.EVENT_SEQUENCE["TENT_JOIN_SHIFT"] )then
		
	else
		
		this.DisableOccasionalChatFor(	TRANSPORT_VEHICLE_DRIVER,	true)
		this.DisableOccasionalChatFor(	TRANSPORT_VEHICLE_GUARD,	true)
	end

	
	if( svars.tempSvars_002 )then
		
		this.DisableOccasionalChatFor(	EXECUTIONER_REMNANTS,		false)
	else
		
		this.DisableOccasionalChatFor(	EXECUTIONER_REMNANTS,		true)
	end
	
	
	this.DisableOccasionalChatFor(		EXECUTIONER_TENT,			true)
end






this.SetRelativeVehicle = function(soldierId, vehicleId)
	Fox.Log("#### s10052_enemy.SetRelativeVehicle #### soldierId = " ..tostring(soldierId).. ", vehicleId = " ..tostring(vehicleId))

	if ( soldierId == TARGET_HOSTAGE ) then
		if Tpp.IsTypeString( soldierId ) then
			soldierId = GameObject.GetGameObjectId( "TppHostage2", soldierId )
		end
	else
		if Tpp.IsTypeString( soldierId ) then
			soldierId = GameObject.GetGameObjectId( "TppSoldier2", soldierId )
		end
	end
	
	vehicleId = GameObject.GetGameObjectId( "TppVehicle2", vehicleId )
	
	
	local command = {}
	local hostage	= GameObject.GetGameObjectId( "TppHostage2", TARGET_HOSTAGE )
	local g_driver	= GameObject.GetGameObjectId( "TppSoldier2", GUARD_VEHICLE_DRIVER )
	
	if( soldierId == hostage ) then
		command = { id = "SetRelativeVehicle", targetId = vehicleId }													
	elseif( soldierId == g_driver ) then
		command = { id = "SetRelativeVehicle", targetId = vehicleId, rideFromBeginning = true, isVigilance = true }	
	else
		command = { id = "SetRelativeVehicle", targetId = vehicleId, isVigilance = true }								
	end

	GameObject.SendCommand( soldierId, command )
end



this.DeleteConvoySetting = function()
	Fox.Log("#### s10052_enemy.DeleteConvoySetting ####")
	GameObject.SendCommand( { type="TppVehicle2", }, { id="UnregisterConvoy", convoyId=GameObject.GetGameObjectId( "TppVehicle2", TRANSPORT_VEHICLE ), } )
end




this.SetTravelPlanForEventVehicle = function(soldierId, planName)
	local keepFlag = true	

	
	if Tpp.IsTypeString( soldierId ) then
		soldierId = GameObject.GetGameObjectId( "TppSoldier2", soldierId )
	end
	
	
	Fox.Log("#### s10052_enemy.SetTravelPlanForEventVehicle #### soldierId = " ..soldierId.. ", travelPlan = " ..planName.. ", keepInAlert = " ..tostring(keepFlag))
	GameObject.SendCommand( soldierId, { id = "StartTravel", travelPlan = planName, keepInAlert = keepFlag } )
end



this.UnsetTravelPlanForEventVehicle = function(soldierId)
	Fox.Log("#### s10052_enemy.UnsetTravelPlanForEventVehicle #### soldierId = " ..soldierId)

	
	if Tpp.IsTypeString( soldierId ) then
		soldierId = GameObject.GetGameObjectId( "TppSoldier2", soldierId )
	end
	
	
	GameObject.SendCommand( soldierId, { id = "StartTravel", travelPlan = "", keepInAlert = false } )
end



this.EnableFixedPointCombatForEventVehicle = function(enabled)
	Fox.Log("#### s10052_enemy.EnableFixedPointCombatForEventVehicle #### enabled = " ..tostring(enabled))

	
	local soldierId = GameObject.GetGameObjectId( "TppSoldier2", GUARD_VEHICLE_DRIVER )
	
	
	local command = {}
	if (enabled) then
		command = { id="SetCommandAi", commandType = CommandAi.FORCE_WAIT }	
	else
		command = { id="RemoveCommandAi" }										
	end
	
	GameObject.SendCommand( soldierId, command )
end



this.CheckFixedPointCombatForEventVehicle = function()




















end



this.EnableForceRailDriveSpeedFAST = function(enableFlag)
	local TARGET_VEHICLES =	{
		TRANSPORT_VEHICLE,
		GUARD_VEHICLE,
	}

	local command = {}
	if(enableFlag)then
		command = { id="ForceRailDriveSpeed", speed=Vehicle.speed.FORWARD_FAST, }
	else
		command = { id="CancelForceRailDriveSpeed", }
	end

	for i , vehicleName in pairs( TARGET_VEHICLES ) do
		local gameObjectId = GameObject.GetGameObjectId( "TppVehicle2", vehicleName )
		if ( this.CheckAliveVehicle(vehicleName) ) then
			Fox.Log( "#### s10052_enemy.EnableForceRailDriveSpeedFAST #### vehicleId = "..gameObjectId..", enabled = "..tostring(enableFlag) )
			GameObject.SendCommand( gameObjectId, command )
		end
	end
	
	
	if(svars.tempSvars_013)then
		local gameObjectId = GameObject.GetGameObjectId( "TppVehicle2", GUARD_VEHICLE )
		command = { id="CancelForceRailDriveSpeed", }
		GameObject.SendCommand( gameObjectId, command )
	end
end



this.VanishSAV = function()
	local vehicleId = GameObject.GetGameObjectId( "TppVehicle2", GUARD_VEHICLE )
	if GameObject.SendCommand( vehicleId, { id="IsAlive", } ) then
		Fox.Log( "#### s10052_enemy.VanishSAV ####")
		GameObject.SendCommand( GameObject.GetGameObjectId( GUARD_VEHICLE_DRIVER ) , { id="SetEnabled", enabled=false } )
		GameObject.SendCommand( { type="TppVehicle2", },{	id = "Despawn",	name = GUARD_VEHICLE, } )
	end
end



this.CheckAliveVehicle = function( target )
	local vehicleId = GameObject.GetGameObjectId( "TppVehicle2", target )
	return GameObject.SendCommand(vehicleId, { id="IsAlive", })
end



this.CheckRideOnAnyEnemy = function( target )
	local vehicleId = GameObject.GetGameObjectId( "TppVehicle2", target )
	
	
	if not this.CheckAliveVehicle(target) then
		return false
	end
	
	local riderIdArray = GameObject.SendCommand( vehicleId, { id="GetRiderId", } )
	local seatCount = #riderIdArray
	for seatIndex,riderId in ipairs( riderIdArray ) do
		Fox.Log( "#### s10052_enemy.CheckRideOnAnyEnemy #### target ["..target.."], seatIndex ["..seatIndex.."] "..riderId)

		
		if ( target == TRANSPORT_VEHICLE ) then
			if (seatIndex == 1) then
				if (riderId ~= GameObject.NULL_ID) then
					if (riderId == GameObject.GetGameObjectId( "TppSoldier2", TRANSPORT_VEHICLE_DRIVER )) then
						return true
					elseif (riderId == GameObject.GetGameObjectId( "TppSoldier2", TRANSPORT_VEHICLE_GUARD )) then
						return true
					else
						return false
					end
				else
					return false
				end
			end
			
		elseif ( target == GUARD_VEHICLE ) then
			if (seatIndex == 1) then
				if (riderId ~= GameObject.NULL_ID) then
					if (riderId == GameObject.GetGameObjectId( "TppSoldier2", GUARD_VEHICLE_DRIVER	 )) then
						return true
					else
						return false
					end
				else
					return false
				end
			end
			
		else
			return false			
		end
	end
end






this.SetEnableForAnimal = function(enableFlag)
	local targetAnimal = "anml_goat_00"		
	local doesExist = GameObject.DoesGameObjectExistWithTypeName( "TppGoat" )	
	
	if (doesExist) then
		Fox.Log("#### s10052_enemy.SetEnableForAnimal #### targetAnimal = " ..targetAnimal.. ", enabled = " ..tostring(enableFlag))
		
		local gameObjectId = GameObject.GetGameObjectId( "TppGoat", targetAnimal )
		local command = {id = "SetEnabled", name = targetAnimal, enabled = enableFlag }
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### s10052_enemy.SetEnableForAnimal #### This function not execute! Because TppGoat does not exist.")
	end
	
end


this.EnableNoticeForAnimal = function(enableFlag)
	local targetAnimal = "anml_goat_00"		
	local doesExist = GameObject.DoesGameObjectExistWithTypeName( "TppGoat" )	
	
	if (doesExist) then
		Fox.Log("#### s10052_enemy.EnableNoticeForAnimal #### targetAnimal = " ..targetAnimal.. ", enabled = " ..tostring(enableFlag))
		
		local gameObjectId = GameObject.GetGameObjectId( "TppGoat", targetAnimal )
		local command = {id = "SetNoticeEnabled", name = targetAnimal, enabled = enableFlag }
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### s10052_enemy.EnableNoticeForAnimal #### This function not execute! Because TppGoat does not exist.")
	end
	
end


this.SetEventRouteForAnimal = function(setRoute)
	local targetAnimal = "anml_goat_00"		
	local doesExist = GameObject.DoesGameObjectExistWithTypeName( "TppGoat" )	
	
	if (doesExist) then
		Fox.Log("#### s10052_enemy.SetEventRouteForAnimal #### targetAnimal = " ..targetAnimal.. ", setRoute = " ..setRoute )

		local gameObjectId = GameObject.GetGameObjectId( "TppGoat", targetAnimal )
		local command = {id = "SetHerdEnabledCommand", name = targetAnimal, route = setRoute, type = "Route" }
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### s10052_enemy.SetEventRouteForAnimal #### This function not execute! Because TppGoat does not exist.")
	end
	
end



this.EnableEscapeAttributeForAnimal = function(enableFlag)
	local targetAnimal = "anml_goat_00"		
	local doesExist = GameObject.DoesGameObjectExistWithTypeName( "TppGoat" )	
	
	if (doesExist) then
		Fox.Log("#### s10052_enemy.EnableEscapeAttributeForAnimal #### targetAnimal = " ..targetAnimal..", enableFlag = "..tostring(enableFlag))
		local gameObjectId = GameObject.GetGameObjectId( "TppGoat", targetAnimal )
		local command = { id = "SetEscapeAttribute", enabled = enableFlag }
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### s10052_enemy.EnableEscapeAttributeForAnimal #### This function not execute! Because TppGoat does not exist.")
	end
end



this.CheckExecuteFlag = function()
	local executeFlag = true
	
	if (svars.isDiscoverdEscape_Target) then
		executeFlag = false
	end
	
	if (svars.tempSvars_010) then
		executeFlag = false
	end
	
	if not(this.CheckAliveVehicle(TRANSPORT_VEHICLE)) then
		executeFlag = false
	end
	
	if not(this.CheckHostageRideVehicle())then
		executeFlag = false
	end
	
	return executeFlag
end






this.SetUniqueStaffParam = function (targetName, uniqueTypeId, existParamTable)
	Fox.Log("#### s10052_enemy.SetUniqueStaffParam #### targetName = " ..targetName.. ", uniqueTypeId = " ..uniqueTypeId )
	TppEnemy.AssignUniqueStaffType{	locaterName = targetName,	uniqueStaffTypeId = uniqueTypeId,	alreadyExistParam = existParamTable	}
end




return this