local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


local GROUP_FIELD_VIP_ARRIVAL_ROUTE 	= 0
local GROUP_FIELD_VIP_DEPARTURE_ROUTE 	= 1
local GROUP_ENEMY_BASE_VIP_ARRIVAL_ROUTE 	= 2
local GROUP_ENEMY_BASE_VIP_DEPARTURE_ROUTE 	= 3

local SUPER_REINFORCE_VHEHICLE_RESERVE = 1	

local VIP_MEETING_WAIT_TIME = 60*12

local VIP_UNSET_RELATIVE_VEHICLE = 60	


if DEBUG then	

this.DEBUG_strCode32List = {
	"afgh_fieldWest_ob",
	"afgh_villageNorth_ob",
	"afgh_commWest_ob",
	"afgh_slopedWest_ob",	
	"afgh_slopedTown_cp",		

	"afgh_village_cp",
	"afgh_enemyBase_cp",
	"afgh_field_cp",
	"afgh_villageWest_ob",
	"afgh_fieldEast_ob",
	"afgh_villageWest_ob",


	"afgh_02_14_lrrp",
	"afgh_02_35_lrrp",

	"afgh_14_32_lrrp",
	"afgh_14_35_lrrp",

	"afgh_15_35_lrrp",
	"afgh_15_36_lrrp",

	"afgh_20_29_lrrp",
	"afgh_20_21_lrrp",


	"afgh_04_32_lrrp",
	"afgh_04_36_lrrp",


	"afgh_01_16_lrrp",
	"afgh_01_32_lrrp",
	"afgh_16_29_lrrp",

}
end	



this.LABEL_REACTION_FIELD_VIP = "enqt1000_106924"
this.LABEL_REACTION_VILLAGE_VIP = "enqt1000_106927" 
this.LABEL_REACTION_ENEMY_BASE_VIP = "enqt1000_106930"


this.LABEL_REACTION_FIELD_DRIVER = "enqt1000_131010"
this.LABEL_REACTION_FIELD_GUARD = "shksa000_131010"

this.LABEL_REACTION_ENEMY_BASE_DRIVER = "enqt1000_121010"
this.LABEL_REACTION_ENEMY_BASE_GUARD = "shksa000_111010"

this.LABEL_POSITION_FIELD_VIP = "enqt1000_106933"
this.LABEL_POSITION_VILLAGE_VIP = "enqt1000_106936" 
this.LABEL_POSITION_ENEMY_BASE_VIP = "enqt1000_106939"

this.LABEL_MEETING_POINT ="enqt1000_101521"
this.LABEL_MEETING_POINT_LRRP= "enqt1000_101526"


this.LABEL_SLOPED_TOWN_HOSTAGE ="enqt1000_271b10"


this.LABEL_ABOUT_HOSTAGE ="enqt1000_1i1310"
this.LABEL_POSITION_HOSTAGE ="enqt1000_271c10"

this.LABEL_POSITION_VEHICLE ="enqt1000_1c1110"

this.LABEL_REACTION_OTHER_OB = "enqt1000_101010"







local VILLAGE_VIP_ROUTES ={
	BEFORE_MEETING_DAY	= {
		"rts_vip_village_waiting",
		"rts_guard_village_d_0000",
		"rts_guard_village_d_0001",
		"rts_guard_village_d_0002",
		"rts_guard_village_d_0003",
		"rts_guard_village_d_0004",

		"rts_guard_village_d_0005",
		"rts_guard_village_d_0006",
		"rts_guard_village_d_0007",
		"rts_guard_village_d_0008",

	},
	BEFORE_MEETING_NIGHT	= {
		"rts_vip_village_waiting",
		"rts_guard_village_n_0000",
		"rts_guard_village_n_0001",
		"rts_guard_village_n_0002",
		"rts_guard_village_n_0003",
		"rts_guard_village_n_0004",

		"rts_guard_village_n_0004",
		"rts_guard_village_n_0004",
		"rts_guard_village_n_0004",
		"rts_guard_village_n_0004",


	},
	AFTER_MEETING_DAY	= {
		"rts_vip_village_back",
		"rts_guard_village_d_0100",
		"rts_guard_village_d_0101",
		"rts_guard_village_d_0102",
		"rts_guard_village_d_0103",
		"rts_guard_village_d_0104",

		"rts_guard_village_d_0104",
		"rts_guard_village_d_0104",
		"rts_guard_village_d_0104",
		"rts_guard_village_d_0104",

	},
	AFTER_MEETING_NIGHT	= {
		"rts_vip_village_back_n",
		"rts_guard_village_n_0100",
		"rts_guard_village_n_0101",
		"rts_guard_village_n_0102",
		"rts_guard_village_n_0103",
		"rts_guard_village_n_0104",

		"rts_guard_village_n_0104",
		"rts_guard_village_n_0104",
		"rts_guard_village_n_0104",
		"rts_guard_village_n_0104",

	},
	CAUTION	= {			
		"rts_vip_village_escape",
		"rts_guard_village_c_0000",
		"rts_guard_village_c_0001",
		"rts_guard_village_c_0002",
		"rts_guard_village_c_0003",
		"rts_guard_village_c_0004",

		"rts_guard_village_c_0000",
		"rts_guard_village_c_0001",
		"rts_guard_village_c_0002",
		"rts_guard_village_c_0003",
	},
}


local FIELD_VIP_ROUTES ={
	ARRIVED_VILLAGE	= {
		"rts_driver_field_inbase",
		"rts_vip_field_inbase",
		"rts_guard_field_0000_inbase",
	},
	ARRIVED_VILLAGE_DEBUG	= {
		"rts_driver_field_inbase",
		"rts_vip_field_inbase_debug",
		"rts_guard_field_0000_inbase",
	},
	CAUTION_AT_VILLAGE	= {
		"rts_driver_field_back",
		"rts_vip_field_escape",
		"rts_guard_field_0000_back",
	},

	AFTER_MEETING	= {	
		"rts_driver_field_back",
		"rts_vip_field_back",
		"rts_guard_field_0000_back",
	},
	BACK_BASE_DAY	= {	
		"rts_driver_field_d_0000",
		"rts_vip_field_d_0000",
		"rts_guard_field_d_0000",
	},
	BACK_BASE_NIGHT	= {		
		"rts_driver_field_d_0000",
		"rts_vip_field_n_0000",
		"rts_guard_field_n_0000",
	},
	BACK_BASE_CAUTION	= {		
		"rts_driver_field_c_0000",
		"rts_vip_field_c_0000",
		"rts_guard_field_c_0000",
	},
}

local ENEMYBASE_VIP_ROUTES ={
	ARRIVED_VILLAGE	= {	
		"rts_driver_enemyBase_inbase",
		"rts_vip_enemyBase_inbase",
		"rts_guard_enemyBase_0000_inbase",
	},
	ARRIVED_VILLAGE_DEBUG	= {	
		"rts_driver_enemyBase_inbase",
		"rts_vip_enemyBase_inbase_debug",
		"rts_guard_enemyBase_0000_inbase",
	},
	CAUTION_AT_VILLAGE	= {
		"rts_driver_enemyBase_back",
		"rts_vip_enemyBase_escape",
		"rts_guard_enemyBase_0000_back",
	},
	AFTER_MEETING	= {		
		"rts_driver_enemyBase_back",
		"rts_vip_enemyBase_back",
		"rts_guard_enemyBase_0000_back",
	},
	BACK_BASE_DAY	= {		
		"rts_driver_enemyBase_d_0000",
		"rts_vip_enemyBase_d_0000",
		"rts_guard_enemyBase_d_0000",
	},
	BACK_BASE_NIGHT	= {		
		"rts_driver_enemyBase_n_0000",
		"rts_vip_enemyBase_n_0000",
		"rts_guard_enemyBase_n_0000",
	},
	BACK_BASE_CAUTION	= {		
		"rts_driver_enemyBase_c_0000",
		"rts_vip_enemyBase_c_0000",
		"rts_guard_enemyBase_c_0000",
	},
}

local ALL_VIP_MEETING_ROUTES ={	
	"rts_vip_field_meeting",
	"rts_vip_enemyBase_meeting",
	"rts_vip_village_meeting",
}


local FIELD_VIP_TRAVEL_TO_VILLAGE ={

	"lrrp_FieldToVillage",
	"lrrp_FieldToVillage",
	"lrrp_FieldToVillage",

}



local ENEMYBASE_VIP_TRAVEL_TO_VILLAGE ={
	"lrrp_EnemyBaseToVillageDriver",
	"lrrp_EnemyBaseToVillage",
	"lrrp_EnemyBaseToVillageGuard",
}






this.USE_COMMON_REINFORCE_PLAN = true




this.ENEMY_NAME				= {
	FIELD_VIP				= "sol_vip_field",						
	VILLAGE_VIP				= "sol_vip_village",					
	ENEMYBASE_VIP			= "sol_vip_enemyBase",					

	FIELD_DRIVER			= "sol_driver_field",					
	FIELD_GUARD_00			= "sol_guard_field_0000",				

	ENEMYBASE_DRIVER		= "sol_driver_enemyBase",				
	ENEMYBASE_GUARD_00		= "sol_guard_enemyBase_0000",			


	VILLAGE_GUARD_00			= "sol_guard_village_0000",				
	VILLAGE_GUARD_01			= "sol_guard_village_0001",				
	VILLAGE_GUARD_02			= "sol_guard_village_0002",				
	VILLAGE_GUARD_03			= "sol_guard_village_0003",				
	VILLAGE_GUARD_04			= "sol_guard_village_0004",				




	LRRP_00	=	"sol_02_14_0000",
	LRRP_01	=	"sol_15_35_0000",
	LRRP_02	=	"sol_20_29_0000",

}
this.BONUS_HOSTAGE_NAME	= {
	HOSTAGE_00	=	"hos_subTarget_0000",
	HOSTAGE_01	=	"hos_subTarget_0001",
}



local FIELD_VIP_GROUP = {
	this.ENEMY_NAME.FIELD_DRIVER,
	this.ENEMY_NAME.FIELD_VIP,
	this.ENEMY_NAME.FIELD_GUARD_00,

}

local ENEMYBASE_VIP_GROUP = {
	this.ENEMY_NAME.ENEMYBASE_DRIVER,
	this.ENEMY_NAME.ENEMYBASE_VIP,
	this.ENEMY_NAME.ENEMYBASE_GUARD_00,


}
local VILLAGE_VIP_GROUP = {
	this.ENEMY_NAME.VILLAGE_VIP,
	this.ENEMY_NAME.VILLAGE_GUARD_00,
	this.ENEMY_NAME.VILLAGE_GUARD_01,
	this.ENEMY_NAME.VILLAGE_GUARD_02,
	this.ENEMY_NAME.VILLAGE_GUARD_03,
	this.ENEMY_NAME.VILLAGE_GUARD_04,


}


local VILLAGE_GUARD_GROUP = {
	this.ENEMY_NAME.VILLAGE_GUARD_00,
	this.ENEMY_NAME.VILLAGE_GUARD_01,
	this.ENEMY_NAME.VILLAGE_GUARD_02,
	this.ENEMY_NAME.VILLAGE_GUARD_03,
	this.ENEMY_NAME.VILLAGE_GUARD_04,

}


local BONUS_TASK_GUARD_GROUP = {
	this.ENEMY_NAME.FIELD_DRIVER,
	this.ENEMY_NAME.FIELD_GUARD_00,
	this.ENEMY_NAME.ENEMYBASE_DRIVER,
	this.ENEMY_NAME.ENEMYBASE_GUARD_00,
}


local BONUS_TASK_SOLDIER_GROUP = {
	this.BONUS_HOSTAGE_NAME.HOSTAGE_00,
	this.BONUS_HOSTAGE_NAME.HOSTAGE_01,
}


local ALL_VIP_GROUP = {
	this.ENEMY_NAME.ENEMYBASE_VIP,
	this.ENEMY_NAME.FIELD_VIP,
	this.ENEMY_NAME.VILLAGE_VIP,
}





this.voiceTable = {
	labelFirst={	
		[1]		=	"CT10041_01a",
		[2]		=	"CT10041_01b",
	},

	labelFullton={	
		[1]		=	"CT10041_02a",
		[2]		=	"CT10041_02b",
		[3]		=	"CT10041_02c",
		[4]		=	"CT10041_02d",
		[5]		=	"CT10041_02e",
		[6]		=	"CT10041_02f",
	},
	labelKill={		
		[1]		=	"CT10041_03a",
		[2]		=	"CT10041_03b",
		[3]		=	"CT10041_03c",
	},
	labelLast={		
		[1]		=	"CT10041_04a",
		[2]		=	"CT10041_04b",
		[3]		=	"CT10041_04c",
		[4]		=	"CT10041_04d",
	},

	monologue	={		
		fieldVip		=	"CT10041_05",
		villageVip		=	"CT10041_06",
		enemyBaseVip	=	"CT10041_07",
	},

	Cancel	={		
		fieldVip		=	"CT10041_08",
		villageVip		=	"CT10041_09",
		enemyBaseVip	=	"CT10041_10",
	}

}


this.speakerTable = {
	NameFirst = {
		[1]		=	this.ENEMY_NAME.VILLAGE_VIP,
		[2]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
	},

	NameFullton = {
		[1]		=	this.ENEMY_NAME.VILLAGE_VIP,
		[2]		=	this.ENEMY_NAME.FIELD_VIP,
		[3]		=	this.ENEMY_NAME.FIELD_VIP,
		[4]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[5]		=	this.ENEMY_NAME.VILLAGE_VIP,
		[6]		=	this.ENEMY_NAME.VILLAGE_VIP,
	},

	NameKill = {
		[1]		=	this.ENEMY_NAME.FIELD_VIP,
		[2]	=	this.ENEMY_NAME.VILLAGE_VIP,
		[3]	=	this.ENEMY_NAME.ENEMYBASE_VIP,

	},
	NameLast = {
		[1]	=	this.ENEMY_NAME.FIELD_VIP,
		[2]	=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[3]	=	this.ENEMY_NAME.FIELD_VIP,
		[4]	=	this.ENEMY_NAME.VILLAGE_VIP,

	},
}

this.listnerTable = {
	NameFirst = {
		[1]		=	this.ENEMY_NAME.FIELD_VIP,
		[2]		=	this.ENEMY_NAME.VILLAGE_VIP,
	},
	NameFullton = {
		[1]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[2]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[3]		=	this.ENEMY_NAME.VILLAGE_VIP,
		[4]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[5]		=	this.ENEMY_NAME.FIELD_VIP,
		[6]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
	},
	NameKill = {

		[1]		=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[2]	=	this.ENEMY_NAME.ENEMYBASE_VIP,
		[3]	=	this.ENEMY_NAME.FIELD_VIP,

	},
	NameLast = {
		[1]	=	this.ENEMY_NAME.FIELD_VIP,
		[2]	=	this.ENEMY_NAME.VILLAGE_VIP,
		[3]	=	this.ENEMY_NAME.VILLAGE_VIP,
		[4]	=	this.ENEMY_NAME.FIELD_VIP,
	},

}

this.MeetingRouteTable = {

	RouteFirstVillage={	
		[1]		=	"rts_village_CT10041_01a",
		[2]		=	"rts_village_CT10041_01b",
	},
	RouteFirstField={	
		[1]		=	"rts_field_CT10041_01a",
		[2]		=	"rts_field_CT10041_01b",
	},

	RouteFirstEnemyBase={	
		[1]		=	"rts_enemyBase_CT10041_01a",
		[2]		=	"rts_enemyBase_CT10041_01b",
	},



	RouteFulltonVillage={	
		[1]		=	"rts_village_CT10041_02a",
		[2]		=	"rts_village_CT10041_02b",
		[3]		=	"rts_village_CT10041_02c",
		[4]		=	"rts_village_CT10041_02d",
		[5]		=	"rts_village_CT10041_02e",
		[6]		=	"rts_village_CT10041_02f",
	},

	RouteFulltonField={	
		[1]		=	"rts_field_CT10041_02a",
		[2]		=	"rts_field_CT10041_02b",
		[3]		=	"rts_field_CT10041_02c",
		[4]		=	"rts_field_CT10041_02d",
		[5]		=	"rts_field_CT10041_02e",
		[6]		=	"rts_field_CT10041_02f",
	},


	RouteFulltonEnemyBase={	
		[1]		=	"rts_enemyBase_CT10041_02a",
		[2]		=	"rts_enemyBase_CT10041_02b",
		[3]		=	"rts_enemyBase_CT10041_02c",
		[4]		=	"rts_enemyBase_CT10041_02d",
		[5]		=	"rts_enemyBase_CT10041_02e",
		[6]		=	"rts_enemyBase_CT10041_02f",
	},


	RouteLastVillage={		
		[1]		=	"rts_village_CT10041_04a",
		[2]		=	"rts_village_CT10041_04b",
		[3]		=	"rts_village_CT10041_04c",
		[4]		=	"rts_village_CT10041_04d",
	},

	RouteLastField={		
		[1]		=	"rts_field_CT10041_04a",
		[2]		=	"rts_field_CT10041_04b",
		[3]		=	"rts_field_CT10041_04c",
		[4]		=	"rts_field_CT10041_04d",
	},
	RouteLastEnemyBase={		
		[1]		=	"rts_enemyBase_CT10041_04a",
		[2]		=	"rts_enemyBase_CT10041_04b",
		[3]		=	"rts_enemyBase_CT10041_04c",
		[4]		=	"rts_enemyBase_CT10041_04d",
	},

}








this.soldierDefine = {
















	
	afgh_field_cp = {
		this.ENEMY_NAME.FIELD_DRIVER,
		this.ENEMY_NAME.FIELD_VIP,
		this.ENEMY_NAME.FIELD_GUARD_00,
		"sol_field_0000",
		"sol_field_0001",
		"sol_field_0002",
		"sol_field_0003",
		"sol_field_0004",

		"sol_field_0005",
		"sol_field_0006",
		"sol_field_0007",
		"sol_field_0008",


	},
	afgh_enemyBase_cp = {
		this.ENEMY_NAME.ENEMYBASE_DRIVER,
		this.ENEMY_NAME.ENEMYBASE_VIP,
		this.ENEMY_NAME.ENEMYBASE_GUARD_00,
		"sol_enemyBase_0000",
		"sol_enemyBase_0001",
		"sol_enemyBase_0002",
		"sol_enemyBase_0003",
		"sol_enemyBase_0004",



	},

	afgh_village_cp = {
		this.ENEMY_NAME.VILLAGE_VIP,
		this.ENEMY_NAME.VILLAGE_GUARD_00,
		this.ENEMY_NAME.VILLAGE_GUARD_01,
		this.ENEMY_NAME.VILLAGE_GUARD_02,
		this.ENEMY_NAME.VILLAGE_GUARD_03,
		this.ENEMY_NAME.VILLAGE_GUARD_04,


		this.ENEMY_NAME.VILLAGE_GUARD_05,
		this.ENEMY_NAME.VILLAGE_GUARD_06,
		this.ENEMY_NAME.VILLAGE_GUARD_07,
		this.ENEMY_NAME.VILLAGE_GUARD_08,


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
		"sol_slopedTown_0011",


		nil
	},



	
	afgh_villageEast_ob = {
		"sol_villageEast_0000",
		"sol_villageEast_0001",
		"sol_villageEast_0002",

		"sol_villageEast_0003",
		nil


	},
	afgh_villageWest_ob = {
		"sol_villageWest_0000",
		"sol_villageWest_0001",
		"sol_villageWest_0002",

		"sol_villageWest_0003",
		nil
	},
	afgh_fieldEast_ob = {
		"sol_fieldEast_0000",
		"sol_fieldEast_0001",

		"sol_fieldEast_0002",
		"sol_fieldEast_0003",
		nil
	},
	afgh_villageNorth_ob = {
		"sol_villageNorth_0000",
		"sol_villageNorth_0001",


		"sol_villageNorth_0002",
		"sol_villageNorth_0003",
		"sol_villageNorth_0004",

		nil
	},


	afgh_fieldWest_ob = {
		"sol_fieldWest_0000",
		"sol_fieldWest_0001",

		"sol_fieldWest_0002",
		"sol_fieldWest_0003",
		"sol_fieldWest_0004",


		nil
	},
	afgh_slopedWest_ob = {
		"sol_slopedWest_0000",
		"sol_slopedWest_0001",

		"sol_slopedWest_0002",
		"sol_slopedWest_0003",
		

		nil
	},
	afgh_commWest_ob = {
		"sol_commWest_0000",
		"sol_commWest_0001",

		"sol_commWest_0002",
		"sol_commWest_0003",
		"sol_commWest_0004",

		nil
	},
	afgh_remnantsNorth_ob = {
		nil
	},

	afgh_01_16_lrrp = {	nil	},
	afgh_01_32_lrrp = {	nil	},

	afgh_02_14_lrrp = {
		"sol_02_14_0000",
		"sol_02_14_0001",


		lrrpTravelPlan = "lrrp_villageNorth_to_slopedTown",
	},
	afgh_02_35_lrrp = {	nil	},

	afgh_04_32_lrrp = {	nil	},
	afgh_04_36_lrrp = {	nil	},


	afgh_14_32_lrrp = {	nil	},
	afgh_14_35_lrrp = {	nil	},

	afgh_15_35_lrrp = {
		"sol_15_35_0000",
		"sol_15_35_0001",

		lrrpTravelPlan = "lrrp_enemyBase_to_villageNotrh",

		nil
	},
	afgh_15_36_lrrp = {	nil,},

	afgh_16_29_lrrp = {	nil	},

	afgh_20_21_lrrp = {	nil	},

	afgh_20_29_lrrp = {
		"sol_20_29_0000",
		"sol_20_29_0001",

		lrrpTravelPlan = "lrrp_field_to_remnantsNotrh",
		nil
	},

}


this.VIP_SEQUENCE = Tpp.Enum{
	"START",		
	"ASSEMBLING",	
	"INBASE",		
	"CONVERSATION",	
	"BACK_BASE",	
	"ESCAPE",
}

this.soldierPowerSettings = {
	sol_vip_village 	= { "SMG", },	

	sol_vip_field 				= { "SHOTGUN", },	
	sol_driver_field 			= { "MG", },
	sol_guard_field_0000 		= { "SHOTGUN",},

	sol_vip_enemyBase 			= { "SNIPER", },	
	sol_driver_enemyBase 		= { "MG", },
	sol_guard_enemyBase_0000 	= { "SHOTGUN", },







}




local spawnList = {
	{ id = "Spawn", locator = "veh_s10041_VipField",		type = Vehicle.type.EASTERN_LIGHT_VEHICLE,		},	
	{ id = "Spawn", locator = "veh_s10041_VipEnemyBase",	 type = Vehicle.type.EASTERN_LIGHT_VEHICLE,		},	
}


this.vehicleDefine = {
		instanceCount	= #spawnList + 1,
}

this.SpawnVehicleOnInitialize = function()
		TppEnemy.SpawnVehicles( spawnList )
end




local GRU_VEHICLE_GROUP = {
	
	veh_s10041_VipField = 	{
		this.ENEMY_NAME.FIELD_DRIVER,
		this.ENEMY_NAME.FIELD_VIP,
		this.ENEMY_NAME.FIELD_GUARD_00,

	},
	veh_s10041_VipEnemyBase = 	{
		this.ENEMY_NAME.ENEMYBASE_DRIVER,
		this.ENEMY_NAME.ENEMYBASE_VIP,
		this.ENEMY_NAME.ENEMYBASE_GUARD_00,
	},
}




this.routeSets = {

	
	

	

	
	
	afgh_04_36_lrrp = {
		USE_COMMON_ROUTE_SETS = true,		
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
			lrrp_v_36to04 = {
				"rt_v_36to04_0001",
				"rt_v_36to04_0001",
				"rt_v_36to04_0001",
				"rt_v_36to04_0001",
			},
			lrrp_v_04to36 = {
				"rt_v_04to36_0001",
				"rt_v_04to36_0001",
				"rt_v_04to36_0001",
				"rt_v_04to36_0001",
			},

			lrrp_v_04to36_Run = {
				"rt_v_04to36_0001_Run",
				"rt_v_04to36_0001_Run",
				"rt_v_04to36_0001_Run",
				"rt_v_04to36_0001_Run",
			},

		},
		nil
	},
	
	afgh_04_32_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
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
			lrrp_v_04to32 = {
				"rt_v_04to32_0001",
				"rt_v_04to32_0001",
				"rt_v_04to32_0001",
				"rt_v_04to32_0001",
			},
			lrrp_v_32to04 = {
				"rt_v_32to04_0001",
				"rt_v_32to04_0001",
				"rt_v_32to04_0001",
				"rt_v_32to04_0001",
			},
			lrrp_v_32to04_Run = {
				"rt_v_32to04_0001_Run",
				"rt_v_32to04_0001_Run",
				"rt_v_32to04_0001_Run",
				"rt_v_32to04_0001_Run",
			},
			
			lrrp_VipEB_rtrn= {
				"rts_VipEB_rtrn_BeforeArrivedVillage",
				"rts_VipEB_rtrn_BeforeArrivedVillage",
				"rts_VipEB_rtrn_BeforeArrivedVillage",
				"rts_VipEB_rtrn_BeforeArrivedVillage",
			},
		},
		nil
	},

	
	afgh_16_29_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
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

			lrrp_v_29to16 = {
				"rt_v_29to16_0001",
				"rt_v_29to16_0001",
				"rt_v_29to16_0001",
				"rt_v_29to16_0001",
			},
			lrrp_v_16to29 = {
				"rt_v_16to29_0001",
				"rt_v_16to29_0001",
				"rt_v_16to29_0001",
				"rt_v_16to29_0001",
			},
			lrrp_v_16to29_Run = {
				"rt_v_16to29_0001_Run",
				"rt_v_16to29_0001_Run",
				"rt_v_16to29_0001_Run",
				"rt_v_16to29_0001_Run",
			},
		},
		nil
	},
	
	afgh_01_16_lrrp = {
	
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
			lrrp_01to16 = {
				"rt_01to16_0000",
				"rt_01to16_0000",
			},
			lrrp_16to01 = {
				"rt_16to01_0000",
				"rt_16to01_0000",
			},
			lrrp_v_16to01 = {
				"rt_v_16to01_0001",
				"rt_v_16to01_0001",
				"rt_v_16to01_0001",
				"rt_v_16to01_0001",
			},
			lrrp_v_01to16 = {
				"rt_v_01to16_0001",
				"rt_v_01to16_0001",
				"rt_v_01to16_0001",
				"rt_v_01to16_0001",
			},
			lrrp_v_01to16_Run = {
				"rt_v_01to16_0001_Run",
				"rt_v_01to16_0001_Run",
				"rt_v_01to16_0001_Run",
				"rt_v_01to16_0001_Run",
			},
		},
		nil
	},

	
	afgh_01_32_lrrp = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_v_01to32 = {
				"rt_v_01to32_0001",
				"rt_v_01to32_0001",
				"rt_v_01to32_0001",
				"rt_v_01to32_0001",
			},
			lrrp_v_32to01 = {
				"rt_v_32to01_0001",
				"rt_v_32to01_0001",
				"rt_v_32to01_0001",
				"rt_v_32to01_0001",
			},
			lrrp_v_32to01_Run = {
				"rt_v_32to01_0001_Run",
				"rt_v_32to01_0001_Run",
				"rt_v_32to01_0001_Run",
				"rt_v_32to01_0001_Run",
			},
		},
		nil
	},


	



	afgh_02_14_lrrp = {	USE_COMMON_ROUTE_SETS = true,},
	afgh_02_35_lrrp = {	USE_COMMON_ROUTE_SETS = true,},


	
	


	afgh_14_32_lrrp = {	USE_COMMON_ROUTE_SETS = true,},
	afgh_14_35_lrrp = {	USE_COMMON_ROUTE_SETS = true,},


	afgh_15_35_lrrp = {	USE_COMMON_ROUTE_SETS = true,},
	afgh_15_36_lrrp = {	USE_COMMON_ROUTE_SETS = true,},



	afgh_20_29_lrrp = {	USE_COMMON_ROUTE_SETS = true,},
	afgh_20_21_lrrp = {	USE_COMMON_ROUTE_SETS = true,},

	
	
	afgh_villageWest_ob = {
		USE_COMMON_ROUTE_SETS = true,

		sneak_day = {
			groupA = {
				"rt_villageWest_d_0000",
				"rt_villageWest_d_0003",
				"rts_villageWest_0000",
			},
			groupB = {
				"rt_villageWest_d_0001_sub",
				"rt_villageWest_d_0004",
				"rts_villageWest_0001",
			},
			groupC = {
				"rt_villageWest_d_0002",
				"rt_villageWest_d_0005",
			},
		},
		sneak_night = {
			groupA = {
				"rt_villageWest_n_0000_sub",
				"rt_villageWest_n_0003",
				"rts_villageWest_0000",
			},
			groupB = {
				"rt_villageWest_n_0001",
				"rt_villageWest_n_0004",
				"rts_villageWest_0001",
			},
			groupC = {
				"rt_villageWest_n_0002",
				"rt_villageWest_n_0005",
			},
		},
		caution = {
			groupA = {
				"rt_villageWest_c_0000",
				"rt_villageWest_c_0001",
				"rts_villageWest_c_0000",		
				"rts_villageWest_c_0001",		
				"rt_villageWest_c_0002",
				"rt_villageWest_c_0003",
				"rt_villageWest_c_0002",
				"rt_villageWest_c_0004",
			},
			groupB = {
			},
			groupC = {
			},
		},
		travel = {
			lrrp_v_villageWest_ob_36to32 = {
				"rts_villageWest_36to32",
				"rts_villageWest_36to32",
				"rts_villageWest_36to32",
				"rts_villageWest_36to32",

			},
			lrrp_v_villageWest_ob_32to36 = {
				"rts_villageWest_32to36",
				"rts_villageWest_32to36",
				"rts_villageWest_32to36",
				"rts_villageWest_32to36",
			},

			lrrp_v_villageWest_ob_32to36_Run = {
				"rts_villageWest_32to36_Run",
				"rts_villageWest_32to36_Run",
				"rts_villageWest_32to36_Run",
				"rts_villageWest_32to36_Run",
			},

		},
	},
	
	afgh_villageEast_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_v_villageEast_ob_16to32 = {
				"rts_villageEast_16to32",
				"rts_villageEast_16to32",
				"rts_villageEast_16to32",
				"rts_villageEast_16to32",
			},
			lrrp_v_villageEast_ob_32to16 = {
				"rts_villageEast_32to16",
				"rts_villageEast_32to16",
				"rts_villageEast_32to16",
				"rts_villageEast_32to16",
			},
			lrrp_v_villageEast_ob_32to16_Run = {
				"rts_villageEast_32to16_Run",
				"rts_villageEast_32to16_Run",
				"rts_villageEast_32to16_Run",
				"rts_villageEast_32to16_Run",
			},
		},
	},
	
	afgh_fieldEast_ob = {
		USE_COMMON_ROUTE_SETS = true,

		sneak_day = {
			groupA = {
				"rt_fieldEast_d_0000",
				"rt_fieldEast_d_0003",
				"rts_fieldEast_0001",
			},
			groupB = {
				"rt_fieldEast_d_0001",
				"rt_fieldEast_d_0003",
			},
			groupC = {
				"rt_fieldEast_d_0002",
				"rts_fieldEast_0000",
			},
		},
		sneak_night = {
			groupA = {
				"rt_fieldEast_n_0000",
				"rt_fieldEast_n_0003",
				"rts_fieldEast_0001",
			},
			groupB = {
				"rt_fieldEast_n_0001",
				"rt_fieldEast_n_0003",
			},
			groupC = {
				"rt_fieldEast_n_0002",
				"rts_fieldEast_0000",
			},
		},
		caution = {
			groupA = {
				"rt_fieldEast_c_0000",
				"rt_fieldEast_c_0001",
				"rt_fieldEast_c_0002",
				"rts_fieldEast_c_0000",				
				"rts_fieldEast_c_0001",				
				"rt_fieldEast_c_0003",
				"rt_fieldEast_c_0003",
				"rt_fieldEast_c_0001",
				"rt_fieldEast_c_0002",
			},
			groupB = {
			},
			groupC = {
			},
		},
		hold = {
			default = {
			},
		},
		travel = {
			lrrp_v_fieldEast_ob_29to01 = {
				"rts_fieldEast_29to01",
				"rts_fieldEast_29to01",
				"rts_fieldEast_29to01",
				"rts_fieldEast_29to01",
			},
			lrrp_v_fieldEast_ob_01to29 = {
				"rts_fieldEast_01to29",
				"rts_fieldEast_01to29",
				"rts_fieldEast_01to29",
				"rts_fieldEast_01to29",
			},
			lrrp_v_fieldEast_ob_01to29_Run = {
				"rts_fieldEast_01to29_Run",
				"rts_fieldEast_01to29_Run",
				"rts_fieldEast_01to29_Run",
				"rts_fieldEast_01to29_Run",
			},
		},
	},




	afgh_slopedTown_cp = {
		USE_COMMON_ROUTE_SETS = true,
	},


	

	afgh_villageNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},

	afgh_fieldWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},


	afgh_slopedWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},

	afgh_commWest_ob = {
		USE_COMMON_ROUTE_SETS = true,
		sneak_day = {
			groupA = {
				"rt_commWest_d_0000",
				"rt_commWest_d_0002",
				"rts_commWest_d_0000",	
			},
			groupB = {
				"rt_commWest_d_0001_sub",
				"rt_commWest_d_0003",
			},
		},
		sneak_night = {
			groupA = {
				"rt_commWest_n_0000",
				"rt_commWest_n_0002_sub",
				"rts_commWest_n_0000",	
			},
			groupB = {
				"rt_commWest_n_0001",
				"rt_commWest_n_0003",
			},
		},
		caution = {
			groupA = {
				"rt_commWest_c_0000",
				"rt_commWest_c_0001",
				"rt_commWest_c_0002",
				"rt_commWest_c_0003",
				"rt_commWest_c_0002",
				"rt_commWest_c_0003",
				"rt_commWest_c_0001",	
			},
			groupB = {
			},
		},

	},
	afgh_remnantsNorth_ob = {
		USE_COMMON_ROUTE_SETS = true,
	},

	

	afgh_enemyBase_cp = {
		USE_COMMON_ROUTE_SETS = true,
	
		
		
		
		
		
		
		sneak_day = {
			groupDriverEnemyBase = {
				"rts_driver_enemyBase_d_0000",
				nil
			},
			groupVipEnemyBase = {
				"rts_vip_enemyBase_d_0000",
				nil
			},
			groupGuardEnemyBase = {
				"rts_guard_enemyBase_d_0000",
				nil
			},

		},
		sneak_night = {
			groupDriverEnemyBase = {
				"rts_driver_enemyBase_n_0000",
				nil
			},
			groupVipEnemyBase = {
				"rts_vip_enemyBase_n_0000",
				nil
			},
			groupGuardEnemyBase = {
				"rts_guard_enemyBase_n_0000",
				nil
			},
		},
		caution = {
			groupDriverEnemyBase = {
				"rts_driver_enemyBase_c_0000",
				nil
			},
			groupVipEnemyBase = {
				"rts_vip_enemyBase_c_0000",
				nil
			},
			groupGuardEnemyBase = {
				"rts_guard_enemyBase_c_0000",
				nil
			},
		},

		sleep = {
			groupDriverEnemyBase = {
				"rts_driver_enemyBase_h_0000",
				nil
			},
			groupVipEnemyBase = {
				"rts_vip_enemyBase_h_0000",
				nil
			},
			groupGuardEnemyBase = {
				"rts_guard_enemyBase_h_0000",
				nil
			},
		},

		hold = {
			groupDriverEnemyBase = {
				"rts_driver_enemyBase_h_0000",
				nil
			},
			groupVipEnemyBase = {
				"rts_vip_enemyBase_h_0000",
				nil
			},
			groupGuardEnemyBase = {
				"rts_guard_enemyBase_h_0000",
				nil
			},
		},

		travel = {
			lrrp_VipEnemyBaseRideVehicle = {
				"rts_vip_enemyBase",
			},
			lrrp_DriverEnemyBaseRideVehicle = {
				"rts_driver_enemyBase",

			},
			lrrp_GuardEnemyBaseRideVehicle = {
				"rts_guard_enemyBase_0000",
			},

			lrrp_VipEnemyBaseTo36 = {
				"rts_v_VipEnemyBaseTo36",
				"rts_v_VipEnemyBaseTo36",
				"rts_v_VipEnemyBaseTo36",
				"rts_v_VipEnemyBaseTo36",
			},
			lrrp_VipEnemyBaseTo36_Back = {
				"rts_v_VipEnemyBaseTo36_back",
				"rts_v_VipEnemyBaseTo36_back",
				"rts_v_VipEnemyBaseTo36_back",
				"rts_v_VipEnemyBaseTo36_back",
			},

			lrrp_VipEnemyBaseTo36_Back_Run = {
				"rts_v_VipEnemyBaseTo36_back_Run",
				"rts_v_VipEnemyBaseTo36_back_Run",
				"rts_v_VipEnemyBaseTo36_back_Run",
				"rts_v_VipEnemyBaseTo36_back_Run",
			},
		},
	},


	afgh_village_cp = {
		USE_COMMON_ROUTE_SETS = true,

	
	
		
		
	
	

	
	
	
	
	
	

	

		travel = {
			inbase_FieldVIP = {
				"rts_vip_field_inbase",
			},
			back_FieldVIP = {
				"rts_vip_field_back",
			},

			inbase_FieldGuard = {
				"rts_guard_field_0000_inbase",
			},
			back_FieldGuard = {
				"rts_guard_field_0000_back",
			},


			lrrp_fieldVIP_01to32 = {
				"rts_vip_field_01to32",
				"rts_vip_field_01to32",
				"rts_vip_field_01to32",
				"rts_vip_field_01to32",
			},
			lrrp_fieldVIP_32to01_switchBack = {
				"rts_vip_field_32to01_switchBack",
				"rts_vip_field_32to01_switchBack",
				"rts_vip_field_32to01_switchBack",
				"rts_vip_field_32to01_switchBack",
			},
			lrrp_fieldVIP_32to01_switchBack_Run = {
				"rts_vip_field_32to01_switchBack_Run",
				"rts_vip_field_32to01_switchBack_Run",
				"rts_vip_field_32to01_switchBack_Run",
				"rts_vip_field_32to01_switchBack_Run",
			},


			lrrp_fieldVIP_32to01 = {
				"rts_vip_field_32to01",
				"rts_vip_field_32to01",
				"rts_vip_field_32to01",
				"rts_vip_field_32to01",
			},
			lrrp_fieldVIP_32to01_Run = {
				"rts_vip_field_32to01_Run",
				"rts_vip_field_32to01_Run",
				"rts_vip_field_32to01_Run",
				"rts_vip_field_32to01_Run",
			},


			lrrp_EnemyBaseVIP_04to32 = {
				"rts_vip_enemyBase_04to32",
				"rts_vip_enemyBase_04to32",
				"rts_vip_enemyBase_04to32",
				"rts_vip_enemyBase_04to32",
			},

			lrrp_EnemyBaseVIP_32to04 = {
				"rts_vip_enemyBase_32to04",
				"rts_vip_enemyBase_32to04",
				"rts_vip_enemyBase_32to04",
				"rts_vip_enemyBase_32to04",
			},

			lrrp_EnemyBaseVIP_32to04_Run = {
				"rts_vip_enemyBase_32to04_Run",
				"rts_vip_enemyBase_32to04_Run",
				"rts_vip_enemyBase_32to04_Run",
				"rts_vip_enemyBase_32to04_Run",
			},

			lrrp_EnemyBaseVIP_32to04_switchBack = {
				"rts_vip_enemyBase_32to04_switchBack",
				"rts_vip_enemyBase_32to04_switchBack",
				"rts_vip_enemyBase_32to04_switchBack",
				"rts_vip_enemyBase_32to04_switchBack",
			},

			lrrp_EnemyBaseVIP_32to04_switchBack_Run = {
				"rts_vip_enemyBase_32to04_switchBack_Run",
				"rts_vip_enemyBase_32to04_switchBack_Run",
				"rts_vip_enemyBase_32to04_switchBack_Run",
				"rts_vip_enemyBase_32to04_switchBack_Run",
			},

			inbase_EnemyBaseVIP = {
				"rts_vip_enemyBase_inbase",
			},
			back_EnemyBaseVIP = {
				"rts_vip_enemyBase_back",
			},

			inbase_EnemyBaseGuard = {
				"rts_guard_enemyBase_0000_inbase",
			},
			back_EnemyBaseGuard = {
				"rts_guard_enemyBase_0000_back",
			},

			inbase_VillageVIP = {
				"rts_vip_village_waiting",
			},
			back_VillageVIP = {
				"rts_vip_village_waiting",
			}

		},

	},

	afgh_field_cp = {
		USE_COMMON_ROUTE_SETS = true,
	
		
		
	
		sneak_day = {
			groupVip = {
				"rts_driver_field_d_0000",
				"rts_vip_field_d_0000",
				"rts_guard_field_d_0000",
			},
		},
		sneak_night = {
			groupVip = {
				"rts_driver_field_n_0000",
				"rts_vip_field_n_0000",
				"rts_guard_field_n_0000",
			},
		},
		caution = {
			groupVip = {
				"rts_driver_field_c_0000",
				"rts_vip_field_c_0000",
				"rts_guard_field_c_0000",
			},
		},
		sleep = {
			groupVip = {
				"rts_driver_field_h_0000",
				"rts_vip_field_h_0000",
				"rts_guard_field_h_0000",
			},
		},
		hold = {
			groupVip = {
				"rts_driver_field_h_0000",
				"rts_vip_field_h_0000",
				"rts_guard_field_h_0000",
			},
		},


		travel = {
			lrrp_VipFieldRideVehicle = {
				"rts_vip_field",
				"rts_vip_field",
				"rts_vip_field",
			},
			lrrp_DriverFieldRideVehicle = {
				"rts_driver_field",
			},
			lrrp_GuardFieldRideVehicle = {
				"rts_guard_field_0000",
			},
			lrrpVipFieldTo29 = {
				"rts_v_VipFieldTo29",
				"rts_v_VipFieldTo29",
				"rts_v_VipFieldTo29",
				"rts_v_VipFieldTo29",
			},
			lrrpVipFieldTo29_back = {
				"rts_v_VipFieldTo29_back",
				"rts_v_VipFieldTo29_back",
				"rts_v_VipFieldTo29_back",
				"rts_v_VipFieldTo29_back",
			},
			lrrpVipFieldTo29_back_Run = {
				"rts_v_VipFieldTo29_back_Run",
				"rts_v_VipFieldTo29_back_Run",
				"rts_v_VipFieldTo29_back_Run",
				"rts_v_VipFieldTo29_back_Run",
			},
		},
	},

}

this.VIP_Squat = {
	afgh_field_cp = {
		this.ENEMY_NAME.FIELD_DRIVER,
		this.ENEMY_NAME.FIELD_VIP,
		this.ENEMY_NAME.FIELD_GUARD_00,
	

	},
	afgh_enemyBase_cp = {
		this.ENEMY_NAME.ENEMYBASE_DRIVER,
		this.ENEMY_NAME.ENEMYBASE_VIP,
		this.ENEMY_NAME.ENEMYBASE_GUARD_00,
	

	},

	afgh_village_cp = {
		this.ENEMY_NAME.VILLAGE_VIP,
		this.ENEMY_NAME.VILLAGE_GUARD_00,
		this.ENEMY_NAME.VILLAGE_GUARD_01,
		this.ENEMY_NAME.VILLAGE_GUARD_02,
		this.ENEMY_NAME.VILLAGE_GUARD_03,
		this.ENEMY_NAME.VILLAGE_GUARD_04,

	},


	
	
	
	
}



this.VIP_Route = {
	afgh_field_cp = {
		"rts_vip_field",
		"rts_vip_field",
		"rts_vip_field_back",
		"rts_vip_field_inbase",
		"rts_vip_field_backBase",
	},
	afgh_enemyBase_cp = {

		"rts_vip_enemyBase",
		"rts_vip_enemyBase",
		"rts_vip_enemyBase_back",
		"rts_vip_enemyBase_backBase",
		"rts_vip_enemyBase_inbase",
	},
	afgh_village_cp = {
		"rts_vip_village_waiting",
		"rts_vip_village_waiting",
		"rts_vip_village_waiting",
		"rts_vip_village_waiting",
		"rts_vip_village_waiting",
		"rts_vip_village_waiting",
	},


}



this.lrrpHoldTime = 15

this.travelPlans = {

	
	lrrp_FieldToVillage = {
		ONE_WAY = true,
		 { cp = "afgh_field_cp", routeGroup={ "travel", "lrrp_VipFieldRideVehicle" } }, 
		 { cp = "afgh_field_cp", routeGroup={ "travel", "lrrpVipFieldTo29" } }, 
		 { cp = "afgh_16_29_lrrp", routeGroup={ "travel", "lrrp_v_29to16" } }, 
		 { cp = "afgh_fieldEast_ob", routeGroup={ "travel", "lrrp_v_fieldEast_ob_29to01" } }, 
		 { cp = "afgh_01_16_lrrp", routeGroup={ "travel", "lrrp_v_16to01" } }, 
		 { cp = "afgh_villageEast_ob", routeGroup={ "travel", "lrrp_v_villageEast_ob_16to32" } }, 
		 { cp = "afgh_01_32_lrrp", routeGroup={ "travel", "lrrp_v_01to32" } }, 
		 { cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_01to32" } }, 
		 { cp = "afgh_village_cp", finishTravel=true },												

	},
	
	lrrp_FieldToVillageDriver = {
		ONE_WAY = true,
		 { cp = "afgh_field_cp", routeGroup={ "travel", "lrrp_DriverFieldRideVehicle" } }, 
		 { cp = "afgh_field_cp", routeGroup={ "travel", "lrrpVipFieldTo29" } }, 
		 { cp = "afgh_16_29_lrrp", routeGroup={ "travel", "lrrp_v_29to16" } }, 
		 { cp = "afgh_fieldEast_ob", routeGroup={ "travel", "lrrp_v_fieldEast_ob_29to01" } }, 
		 { cp = "afgh_01_16_lrrp", routeGroup={ "travel", "lrrp_v_16to01" } }, 
		 { cp = "afgh_villageEast_ob", routeGroup={ "travel", "lrrp_v_villageEast_ob_16to32" } }, 
		 { cp = "afgh_01_32_lrrp", routeGroup={ "travel", "lrrp_v_01to32" } }, 
		 { cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_01to32" } }, 
		 { cp = "afgh_village_cp", finishTravel=true },												

	},
	
	lrrp_FieldToVillageGuard = {
		ONE_WAY = true,
		 { cp = "afgh_field_cp", routeGroup={ "travel", "lrrp_GuardFieldRideVehicle" } }, 
		 { cp = "afgh_field_cp", routeGroup={ "travel", "lrrpVipFieldTo29" } }, 
		 { cp = "afgh_16_29_lrrp", routeGroup={ "travel", "lrrp_v_29to16" } }, 
		 { cp = "afgh_fieldEast_ob", routeGroup={ "travel", "lrrp_v_fieldEast_ob_29to01" } }, 
		 { cp = "afgh_01_16_lrrp", routeGroup={ "travel", "lrrp_v_16to01" } }, 
		 { cp = "afgh_villageEast_ob", routeGroup={ "travel", "lrrp_v_villageEast_ob_16to32" } }, 
		 { cp = "afgh_01_32_lrrp", routeGroup={ "travel", "lrrp_v_01to32" } }, 
		 { cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_01to32" } }, 
		 { cp = "afgh_village_cp", finishTravel=true },												

	},




	
	lrrp_FieldToVillage_Return = {
		ONE_WAY = true,
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_32to01_switchBack" } }, 				
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_32to01" } },							
		{ cp = "afgh_01_32_lrrp", routeGroup={ "travel", "lrrp_v_32to01" } },								
		{ cp = "afgh_villageEast_ob", routeGroup={ "travel", "lrrp_v_villageEast_ob_32to16" } },				
		{ cp = "afgh_01_16_lrrp", routeGroup={ "travel", "lrrp_v_01to16" } },								
		{ cp = "afgh_fieldEast_ob", routeGroup={ "travel", "lrrp_v_fieldEast_ob_01to29" } }, 				
		{ cp = "afgh_16_29_lrrp", routeGroup={ "travel", "lrrp_v_16to29" } },								
		{ cp = "afgh_field_cp", routeGroup={ "travel", "lrrpVipFieldTo29_back" } },							
		{ cp = "afgh_field_cp", finishTravel=true },														
	},


	
	lrrp_FieldToVillage_Return_Run = {
		ONE_WAY = true,
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_32to01_switchBack_Run" } }, 				
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_fieldVIP_32to01_Run" } },							
		{ cp = "afgh_01_32_lrrp", routeGroup={ "travel", "lrrp_v_32to01_Run" } },								
		{ cp = "afgh_villageEast_ob", routeGroup={ "travel", "lrrp_v_villageEast_ob_32to16_Run" } },				
		{ cp = "afgh_01_16_lrrp", routeGroup={ "travel", "lrrp_v_01to16_Run" } },								
		{ cp = "afgh_fieldEast_ob", routeGroup={ "travel", "lrrp_v_fieldEast_ob_01to29_Run" } }, 				
		{ cp = "afgh_16_29_lrrp", routeGroup={ "travel", "lrrp_v_16to29_Run" } },								
		{ cp = "afgh_field_cp", routeGroup={ "travel", "lrrpVipFieldTo29_back_Run" } },							
		{ cp = "afgh_field_cp", finishTravel=true },														
	},





	
	lrrp_EnemyBaseToVillage = {
		ONE_WAY = true,
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_VipEnemyBaseRideVehicle" } }, 
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_VipEnemyBaseTo36" } }, 
		{ cp = "afgh_04_36_lrrp", routeGroup={ "travel", "lrrp_v_36to04" } }, 
		{ cp = "afgh_villageWest_ob", routeGroup={ "travel", "lrrp_v_villageWest_ob_36to32" } }, 
		{ cp = "afgh_04_32_lrrp", routeGroup={ "travel", "lrrp_v_04to32" } }, 
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_04to32" } }, 
		{ cp = "afgh_village_cp", finishTravel=true },												
		
	},
	
	lrrp_EnemyBaseToVillageDriver = {
		ONE_WAY = true,
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_DriverEnemyBaseRideVehicle" } }, 
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_VipEnemyBaseTo36" } }, 
		{ cp = "afgh_04_36_lrrp", routeGroup={ "travel", "lrrp_v_36to04" } }, 
		{ cp = "afgh_villageWest_ob", routeGroup={ "travel", "lrrp_v_villageWest_ob_36to32" } }, 
		{ cp = "afgh_04_32_lrrp", routeGroup={ "travel", "lrrp_v_04to32" } }, 
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_04to32" } }, 
		{ cp = "afgh_village_cp", finishTravel=true },												
		
	},
	
	lrrp_EnemyBaseToVillageGuard = {
		ONE_WAY = true,
		 { cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_GuardEnemyBaseRideVehicle" } }, 
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_VipEnemyBaseTo36" } }, 
		{ cp = "afgh_04_36_lrrp", routeGroup={ "travel", "lrrp_v_36to04" } }, 
		{ cp = "afgh_villageWest_ob", routeGroup={ "travel", "lrrp_v_villageWest_ob_36to32" } }, 
		{ cp = "afgh_04_32_lrrp", routeGroup={ "travel", "lrrp_v_04to32" } }, 
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_04to32" } }, 
		{ cp = "afgh_village_cp", finishTravel=true },												
		
	},

	
	lrrp_EnemyBaseToVillage_Return = {
		ONE_WAY = true,
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_32to04_switchBack" } }, 		
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_32to04" } },					
		{ cp = "afgh_04_32_lrrp", routeGroup={ "travel", "lrrp_v_32to04" } },								
		{ cp = "afgh_villageWest_ob", routeGroup={ "travel", "lrrp_v_villageWest_ob_32to36" } }, 			
		{ cp = "afgh_04_36_lrrp", routeGroup={ "travel", "lrrp_v_04to36" } },								
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_VipEnemyBaseTo36_Back" } }, 			
		{ cp = "afgh_enemyBase_cp", finishTravel=true },												
	},

	

	lrrp_EnemyBaseToVillage_Return_Run = {
		ONE_WAY = true,
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_32to04_switchBack_Run" } }, 		
		{ cp = "afgh_village_cp", routeGroup={ "travel", "lrrp_EnemyBaseVIP_32to04_Run" } },					
		{ cp = "afgh_04_32_lrrp", routeGroup={ "travel", "lrrp_v_32to04_Run" } },								
		{ cp = "afgh_villageWest_ob", routeGroup={ "travel", "lrrp_v_villageWest_ob_32to36_Run" } }, 			
		{ cp = "afgh_04_36_lrrp", routeGroup={ "travel", "lrrp_v_04to36_Run" } },								
		{ cp = "afgh_enemyBase_cp", routeGroup={ "travel", "lrrp_VipEnemyBaseTo36_Back_Run" } }, 		
		{ cp = "afgh_enemyBase_cp", finishTravel=true },													

	},












	lrrp_villageNorth_to_slopedTown = {
		{ base = "afgh_commWest_ob",		},
		{ base = "afgh_slopedTown_cp",		},
		{ base = "afgh_commWest_ob",		},
		{ base = "afgh_villageNorth_ob",	},

	},
	lrrp_enemyBase_to_villageNotrh = {
		{ base = "afgh_slopedWest_ob",		},
		{ base = "afgh_slopedTown_cp",		},
		{ base = "afgh_villageNorth_ob",	},
		{ base = "afgh_slopedTown_cp",		},
		{ base = "afgh_slopedWest_ob",		},
		{ base = "afgh_enemyBase_cp",		},

	},
	lrrp_field_to_remnantsNotrh = {
		{ base = "afgh_remnantsNorth_ob",		},
		{ base = "afgh_fieldWest_ob",		},
		{ base = "afgh_field_cp",		},
		{ base = "afgh_fieldWest_ob",		},

	},

	




}





this.combatSetting = {
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
	afgh_field_cp = {
		USE_COMMON_COMBAT = true,
	},
	afgh_village_cp = {
		area1 = {	
			{ guardTargetName = "gt_s10041_0000", locatorSetName = "cs_s10041_0000", },
		},

	},
	afgh_slopedTown_cp = {
		USE_COMMON_COMBAT = true,
	},
	afgh_commFacility_cp = {
		USE_COMMON_COMBAT = true,
	},

	afgh_fieldEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	afgh_fieldWest_ob = {
		USE_COMMON_COMBAT = true,
	},

	afgh_villageEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	afgh_villageWest_ob = {
		USE_COMMON_COMBAT = true,
	},



	afgh_commWest_ob = {
		USE_COMMON_COMBAT = true,
	},


	afgh_slopedWest_ob = {
		USE_COMMON_COMBAT = true,
	},




}










this.UniqueInterStart_sol_driver_field = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_driver_field")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_FIELD_DRIVER)
	return true
end


this.UniqueInterEnd_sol_driver_field = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_driver_field")
	return true

end


this.UniqueInterStart_sol_guard_field_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_guard_field_0000")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_FIELD_GUARD) 
	return true
end


this.UniqueInterEnd_sol_guard_field_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_guard_field_0000")

end

this.UniqueInterStart_sol_vip_field = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_vip_field")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_FIELD_VIP) 
	return true
end


this.UniqueInterEnd_sol_vip_field = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_vip_field")
end





this.UniqueInterStart_sol_driver_enemyBase = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_driver_enemyBase")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_ENEMY_BASE_DRIVER) 

	return true
end


this.UniqueInterEnd_sol_driver_enemyBase = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_driver_enemyBase")
end


this.UniqueInterStart_sol_guard_enemyBase_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_guard_enemyBase_0000")

	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_FIELD_GUARD )
	return true
end


this.UniqueInterEnd_sol_guard_enemyBase_0000 = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_guard_enemyBase_0000")
end

this.UniqueInterStart_sol_vip_enemyBase = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_vip_enemyBase")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_ENEMY_BASE_VIP) 
	return true
end


this.UniqueInterEnd_sol_vip_enemyBase  = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_vip_enemyBase")
end




this.UniqueInterStart_sol_vip_village = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_sol_vip_village")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_REACTION_VILLAGE_VIP) 

	return true
end


this.UniqueInterEnd_sol_vip_village = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterEnd_sol_vip_village")
end



	
this.InterCall_AboutHostages = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_AboutHostages")
	TppMission.UpdateObjective{
		objectives = { "hos_subTarget_0000", "hos_subTarget_0001", nil	},
	}
	s10041_sequence.DeleteHighInterrogationAboutHostage()

	s10041_sequence.DeleteHighInterrogationPositionHostage()	

	s10041_radio.AboutHostage()
	return true
end

	
this.InterCall_PositionHostages = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_PositionHostages")
	TppMission.UpdateObjective{
		objectives = { "hos_subTarget_0000", "hos_subTarget_0001", nil	},
	}
	s10041_sequence.DeleteHighInterrogationAboutHostage()

	s10041_sequence.DeleteHighInterrogationPositionHostage()	
	s10041_radio.AboutHostage()
	return true
end


this.InterCall_SlopedTownHostages = function( soldier2GameObjectId, cpID, interName )

	Fox.Log("CallBack : InterCall_AboutHostages")
	TppMission.UpdateObjective{
		objectives = { "hos_subTarget_0000", "hos_subTarget_0001", nil	},
	}
	s10041_sequence.DeleteHighInterrogationAboutHostage()

	s10041_sequence.DeleteHighInterrogationPositionHostage()	

	s10041_radio.AboutHostage()
	return true
end


	
this.InterCall_DontKnowMeeting = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_DontKnowMeeting")
	return true
end



this.InterCall_VillageVip = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_VillageVip")

	TppMission.UpdateObjective{	objectives = { "target_vip_village", nil  },}	
	return true
end


this.InterCall_MeetingPoint = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_MeetingPoint")

	svars.isReserve_01 = true	
	TppMission.UpdateObjective{	objectives = { "marker_meetingPointIntel", nil	},}	

	s10041_sequence.DeleteHighInterrogationMeetingPoint()
	return true
end


this.InterCall_MeetingPoint_lrrp = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_MeetingPoint")
	svars.isReserve_01 = true	
	TppMission.UpdateObjective{	objectives = { "marker_meetingPointIntel", nil	},}	
	s10041_sequence.DeleteHighInterrogationMeetingPoint()

	return true
end

this.InterCall_Vehicle = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_Vehicle")

	
	TppMission.UpdateObjective{	objectives = { "marker_veh_s10041_VipEnemyBase","marker_veh_s10041_VipField", nil  },}	
	s10041_sequence.DeleteHighInterrogationVehicle()
	if svars.isReserve_02 == false 	then
		svars.isReserve_02 = true	
		s10041_radio.AboutVehicle()
	end
	return true
end


	
this.InterCall_fieldVipAway = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_fieldVipAway")
	TppMission.UpdateObjective{	objectives = { "target_vip_field", nil	},}	
	s10041_sequence.DeleteHighInterrogationFieldVipAll()

	return true
end

	
this.InterCall_EnemyBaseVipAway = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_EnemyBaseVipAway")
	TppMission.UpdateObjective{	objectives = { "target_vip_enemyBase", nil	},}	

	s10041_sequence.DeleteHighInterrogationEnemyBaseVipAll()
	return true
end
	
this.InterCall_EnemyBaseVipStay = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_EnemyBaseVipStay")

	TppMission.UpdateObjective{	objectives = { "target_vip_enemyBase", nil	},}	
	return true
end

	
this.InterCall_EnemyBaseVipNotCome = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_EnemyBaseVipNotCome")
	TppMission.UpdateObjective{	objectives = { "target_vip_enemyBase", nil	},}	
	s10041_sequence.DeleteHighInterrogationEnemyBaseVipAll()

	return true
end







this.uniqueInterrogation = {
	
	unique = {
		{ name =this.LABEL_REACTION_FIELD_DRIVER ,	func = this.UniqueInterEnd_sol_driver_field,},			
		{ name =this.LABEL_REACTION_FIELD_GUARD ,	func = this.UniqueInterEnd_sol_guard_field_0000,},			
		{ name =this.LABEL_REACTION_VILLAGE_VIP,	func = this.UniqueInterEnd_sol_vip_field,},			

		{ name =this.LABEL_REACTION_ENEMY_BASE_DRIVER ,	func = this.UniqueInterEnd_sol_driver_enemyBase,},			
		{ name =this.LABEL_REACTION_ENEMY_BASE_GUARD ,	func = this.UniqueInterEnd_sol_guard_enemyBase_0000,},			

		{ name =this.LABEL_REACTION_ENEMY_BASE_VIP ,	func = this.UniqueInterEnd_sol_vip_enemyBase,},			

		{ name =this.LABEL_REACTION_VILLAGE_VIP ,	func = this.UniqueInterEnd_sol_vip_village,},			


	},
	
	uniqueChara = {
		{ name = this.ENEMY_NAME.FIELD_DRIVER,			func = this.UniqueInterStart_sol_driver_field,},		
		{ name = this.ENEMY_NAME.FIELD_GUARD_00,		func = this.UniqueInterStart_sol_guard_field_0000,},		
		{ name = this.ENEMY_NAME.FIELD_VIP,			func = this.UniqueInterStart_sol_vip_field,},		

		{ name = this.ENEMY_NAME.ENEMYBASE_DRIVER,			func = this.UniqueInterStart_sol_driver_enemyBase,},		
		{ name = this.ENEMY_NAME.ENEMYBASE_GUARD_00,		func = this.UniqueInterStart_sol_guard_enemyBase_0000,},		
		{ name = this.ENEMY_NAME.ENEMYBASE_VIP,			func = this.UniqueInterStart_sol_vip_enemyBase,},		

		{ name = this.ENEMY_NAME.VILLAGE_VIP,			func = this.UniqueInterStart_sol_vip_village,},		


	},
}

this.interrogation = {


	afgh_village_cp = {
		
		high = {
			{ name = this.LABEL_POSITION_VILLAGE_VIP ,		func = this.InterCall_VillageVip, },	
			{ name = this.LABEL_MEETING_POINT,		func = this.InterCall_MeetingPoint, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



	afgh_enemyBase_cp = {
		
		high = {
			{ name = this.LABEL_POSITION_ENEMY_BASE_VIP,		func = this.InterCall_EnemyBaseVipAway, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_field_cp = {
		
		high = {
			{ name =this.LABEL_POSITION_FIELD_VIP,		func = this.InterCall_fieldVipAway, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},


	afgh_slopedTown_cp = {
		
		high = {
			{ name =this.LABEL_SLOPED_TOWN_HOSTAGE,		func = this.InterCall_SlopedTownHostages, },		
			{ name = this.LABEL_REACTION_OTHER_OB,		func = this.InterCall_DontKnowMeeting, },		

			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},




	afgh_fieldEast_ob  = {
		
		high = {
			{ name =this.LABEL_POSITION_FIELD_VIP,		func = this.InterCall_fieldVipAway, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_villageEast_ob = {
		
		high = {
			{ name =this.LABEL_POSITION_FIELD_VIP,		func = this.InterCall_fieldVipAway, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_villageWest_ob = {
		
		high = {
			{ name = this.LABEL_POSITION_ENEMY_BASE_VIP,		func = this.InterCall_EnemyBaseVipAway, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



	afgh_villageNorth_ob = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			{ name = this.LABEL_REACTION_OTHER_OB,		func = this.InterCall_DontKnowMeeting, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},

	afgh_fieldWest_ob = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			{ name = this.LABEL_REACTION_OTHER_OB,		func = this.InterCall_DontKnowMeeting, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},

	afgh_commWest_ob = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },		
			{ name = this.LABEL_REACTION_OTHER_OB,		func = this.InterCall_DontKnowMeeting, },		
			nil
		},
		
		normal = {
			
			nil
		},
	},
	afgh_slopedWest_ob = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_SlopedTownHostages, },		
			{ name = this.LABEL_REACTION_OTHER_OB,		func = this.InterCall_DontKnowMeeting, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},


	
		
			
	afgh_02_14_lrrp = {
		
		high = {
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_02_35_lrrp = {
		
		high = {
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



		
			
	afgh_14_32_lrrp = {
		
		high = {
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_14_35_lrrp = {
		
		high = {
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},

		
			
	afgh_15_35_lrrp = {
		
		high = {
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_15_36_lrrp = {
		
		high = {
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},


	

	afgh_20_29_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_20_21_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



	
	afgh_04_32_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_04_36_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



	
	afgh_01_16_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_01_32_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	afgh_16_29_lrrp = {
		
		high = {
			{ name = this.LABEL_ABOUT_HOSTAGE,		func = this.InterCall_AboutHostages, },			
			{ name = this.LABEL_POSITION_VEHICLE,		func = this.InterCall_Vehicle, },		
			{ name = this.LABEL_MEETING_POINT_LRRP,		func = this.InterCall_MeetingPoint_lrrp, },		
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
	afgh_fieldEast_ob = true,	
	afgh_fieldWest_ob = true,
	afgh_villageEast_ob = true,
	afgh_villageWest_ob = true,
	afgh_villageNorth_ob = true,
	afgh_commWest_ob = true,
	afgh_slopedWest_ob = true,

	afgh_village_cp = true,
	afgh_enemyBase_cp = true,
	afgh_field_cp = true,
	afgh_slopedTown_cp = true,



	afgh_02_14_lrrp= true,
	afgh_02_35_lrrp= true,

	
	afgh_14_32_lrrp= true,
	afgh_14_35_lrrp= true,

	
	afgh_15_35_lrrp= true,
	afgh_15_36_lrrp= true,

	
	afgh_20_29_lrrp= true,
	afgh_20_21_lrrp= true,


	
	afgh_04_32_lrrp= true,
	afgh_04_36_lrrp= true,

	
	afgh_01_16_lrrp= true,
	afgh_01_32_lrrp= true,
	afgh_16_29_lrrp= true,

	nil
}





function this.SetVipRoute()

	this.WaitingVillageVipRoute()

	Fox.Log("#### StartTravel VIP_Field ####")	
	this.TransferCpMembers( FIELD_VIP_GROUP,FIELD_VIP_TRAVEL_TO_VILLAGE)

	Fox.Log("#### StartTravel VIP_EnemyBase ####")	
	this.TransferCpMembers( ENEMYBASE_VIP_GROUP,ENEMYBASE_VIP_TRAVEL_TO_VILLAGE)

	TppUiCommand.SetMisionInfoCurrentStoryNo(0)	

	
	
	

end

function this.SetVipRouteConversation()
	this.WaitingVillageVipRoute()
	this.SetFieldVipRoute("ARRIVED_VILLAGE_DEBUG")
	this.SetFieldVipCautionRoute("CAUTION_AT_VILLAGE")

	this.SetEnemyBaseVipRoute("ARRIVED_VILLAGE_DEBUG")
	this.SetEnemyBaseVipCautionRoute("CAUTION_AT_VILLAGE")
	TppUiCommand.SetMisionInfoCurrentStoryNo(0)	

	
	
	

end




function this.SetMeetingRoute_VIP(nGameObjectID)
	if svars.isMeetingAborted == true then
		Fox.Log("#### Meeting is already aborted. ####")
		this.SetReturnRoute_VIP(nGameObjectID)
	else
		
		if nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_DRIVER) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_GUARD_00) then

			if svars.isCancelMeetingFieldVip == true then	
				this.SetReturnRoute_VIP(nGameObjectID)
			else											
				Fox.Log("#### FIELD VIP_arrived ####")
				this.SetFieldVipRoute("ARRIVED_VILLAGE")
				this.SetFieldVipCautionRoute("CAUTION_AT_VILLAGE")


			end
		elseif nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_DRIVER) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_GUARD_00) then
			if svars.isCancelMeetingEnemyBaseVip == true then
				this.SetReturnRoute_VIP(nGameObjectID)
			else										
				Fox.Log("#### EnemyBase VIP_arrived ####")
				this.SetEnemyBaseVipRoute("ARRIVED_VILLAGE")
				this.SetEnemyBaseVipCautionRoute("CAUTION_AT_VILLAGE")

			end
		else
			Fox.Log("#### Unknown sender. sendername = " .. StrCode32(strVIPName))
		end
	end
end





function this.SetReturnRoute_VIP(nGameObjectID)
		local gameObjectId
		local cmdTravel

	
	if nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_DRIVER) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_GUARD_00) then
		Fox.Log("#### StartReturnTravel VIP_Field ####")

		this.SetupStepBasedOntravelCountField()							
		this.UnsetRouteFieldGroup()										

		s10041_sequence.HighInterrogationFieldVipReturnTravel()	

	elseif 	nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_DRIVER) or
				nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_GUARD_00) then
		Fox.Log("#### Start_lrrp_EnemyBaseToVillage_Return VIP_EnemyBase ####")

		this.SetupStepBasedOntravelCountEnemyBase()					
		this.UnsetRouteEnemyBaseGroup()								

		s10041_sequence.HighInterrogationEnemyBaseVipReturnTravel()	

	else
		Fox.Log("#### Unknown sender. sendername = " .. StrCode32(strVIPName))
	end

end


function this.SetBackBaseRoute_VIP(nGameObjectID)
	
	if nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) or
			nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_DRIVER) or
			nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_GUARD_00) then

		Fox.Log("#### FIELD VIP go back base ####")
		this.FieldVipBackBase()

	elseif nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) or
			nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_DRIVER) or
			nGameObjectID == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_GUARD_00) then

		Fox.Log("#### EnemyBase VIP back base####")
		this.EnemyBaseVipBackBase()
	else
		Fox.Log("#### Unknown sender. sendername = " .. StrCode32(strVIPName))
	end

end




this.InsertVillageVipHudPhoto = function()
	Fox.Log("###***s10041_enemy.InsertVillageVipHudPhoto")
	Fox.Log("###***InsertVillageVipHudPhoto")
	if svars.isIdentifiedVillageVip == false then		
		Fox.Log("###***NotIdentifyOn_VillageVip_Yet_InsertHudPhoto")
		TppSoundDaemon.PostEvent( 'sfx_s_enemytag_main_tgt' )			
		TppMission.UpdateObjective{ objectives = { "hud_photo_village" }, }
	else
		Fox.Log("###***VillageVip_HasAlreadyIdentified_NoNeedInsertHudPhoto")
	end
end



this.InsertFieldVipHudPhoto = function()
	Fox.Log("###***s10041_enemy.InsertFieldVipHudPhoto")
	Fox.Log("###***InsertFieldVipHudPhoto")
	if svars.isIdentifiedFieldVip == false then		
		Fox.Log("###***NotIdentifyOn_FieldVip_Yet_InsertHudPhoto")
		TppSoundDaemon.PostEvent( 'sfx_s_enemytag_main_tgt' )
		TppMission.UpdateObjective{ objectives = { "hud_photo_field" }, }
	else
		Fox.Log("###***FieldVip_HasAlreadyIdentified_NoNeedInsertHudPhoto")
	end
end



this.InsertEnemyBaseVipHudPhoto = function()
	Fox.Log("###***s10041_enemy.InsertEnemyBaseVipHudPhoto")
	Fox.Log("###***InsertEnemyBaseVipHudPhoto")
	if svars.isIdentifiedEnemyBaseVip == false then		
		Fox.Log("###***NotIdentifyOn_EnemyBaseVip_Yet_InsertHudPhoto")
		TppSoundDaemon.PostEvent( 'sfx_s_enemytag_main_tgt' )
		TppMission.UpdateObjective{ objectives = { "hud_photo_enemyBase" }, }
	else
		Fox.Log("###***EnemyBaseVip_HasAlreadyIdentified_NoNeedInsertHudPhoto")
	end
end


function this.EliminatedVIP(nGameObjectId,EliminateTypeId)
	Fox.Log("#### Eliminated Enemy EliminateTypeId ####" .. EliminateTypeId )
	local VIPEliminated = s10041_sequence.vipKillType.NOT_VIP

	if nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) then

		if svars.isReserve_06 == true then	
			Fox.Log("#### FieldVip Already Eliminated ####")
		else
			svars.isReserve_06 = true 

			if EliminateTypeId == s10041_sequence.EliminateType.KILL then
				this.AnnounceFieldVipKill()	
				if svars.isIdentifiedFieldVip == false then
					Fox.Log("#### Set Eliminate Type KILL_NOT_IDENTIFIED ####")
					this.InsertFieldVipHudPhoto()		
					VIPEliminated = s10041_sequence.vipKillType.KILL_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type KILL_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.KILL_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.FULLTON then
				if svars.isIdentifiedFieldVip == false then
					Fox.Log("#### Set Eliminate Type FULLTON_NOT_IDENTIFIED ####")
					this.InsertFieldVipHudPhoto()		
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type FULLTON_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.FULLTON_FAILED then
				this.AnnounceFieldVipKill()	

				if svars.isIdentifiedFieldVip == false then
					Fox.Log("#### Set Eliminate Type FULLTON_FAILED_NOT_IDENTIFIED ####")
					this.InsertFieldVipHudPhoto()		
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_FAILED_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type FULLTON_FAILED_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_FAILED_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.HELI then
				if svars.isIdentifiedFieldVip == false then
					Fox.Log("#### Set Eliminate Type HELI_NOT_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.HELI_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type HELI_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.HELI_IDENTIFIED		
				end
			else
				Fox.Log("#### Not Set Eliminate Type ####")
			end


		

			s10041_sequence.DeleteHighInterrogationFieldVipAll()
		end
	elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) then

		if svars.isReserve_07 == true then	
			Fox.Log("#### FieldVip Already Eliminated ####")
		else
			svars.isReserve_07 = true 

			if EliminateTypeId == s10041_sequence.EliminateType.KILL then
				this.AnnounceEnemyBaseVipKill()	

				if svars.isIdentifiedEnemyBaseVip == false then
					Fox.Log("#### Set Eliminate Type KILL_NOT_IDENTIFIED ####")
					this.InsertEnemyBaseVipHudPhoto()
					VIPEliminated = s10041_sequence.vipKillType.KILL_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type KILL_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.KILL_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.FULLTON then
				if svars.isIdentifiedEnemyBaseVip == false then
					Fox.Log("#### Set Eliminate Type FULLTON_NOT_IDENTIFIED ####")
					this.InsertEnemyBaseVipHudPhoto()
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type FULLTON_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.FULLTON_FAILED then
				this.AnnounceEnemyBaseVipKill()	
				if svars.isIdentifiedEnemyBaseVip == false then
					Fox.Log("#### Set Eliminate Type FULLTON_FAILED_NOT_IDENTIFIED ####")
					this.InsertEnemyBaseVipHudPhoto()
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_FAILED_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type FULLTON_FAILED_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_FAILED_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.HELI then
				if svars.isIdentifiedEnemyBaseVip == false then
					Fox.Log("#### Set Eliminate Type HELI_NOT_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.HELI_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type HELI_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.HELI_IDENTIFIED		
				end
			else
				Fox.Log("#### Not Set Eliminate Type ####")
			end




			s10041_sequence.DeleteHighInterrogationEnemyBaseVipAll()

		end
	elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.VILLAGE_VIP) then
		if svars.isReserve_05 == true then	
			Fox.Log("#### FieldVip Already Eliminated ####")
		else
			svars.isReserve_05 = true 

			if EliminateTypeId == s10041_sequence.EliminateType.KILL then
				this.AnnounceVillageVipKill()	
				if svars.isIdentifiedVillageVip == false then
					Fox.Log("#### Set Eliminate Type KILL_NOT_IDENTIFIED ####")
					this.InsertVillageVipHudPhoto()
					VIPEliminated = s10041_sequence.vipKillType.KILL_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type KILL_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.KILL_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.FULLTON then
				if svars.isIdentifiedVillageVip == false then
					Fox.Log("#### Set Eliminate Type FULLTON_NOT_IDENTIFIED ####")
					this.InsertVillageVipHudPhoto()
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type FULLTON_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.FULLTON_FAILED then

				this.AnnounceVillageVipKill()	
				if svars.isIdentifiedVillageVip == false then
					Fox.Log("#### Set Eliminate Type FULLTON_FAILED_NOT_IDENTIFIED ####")
					this.InsertVillageVipHudPhoto()
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_FAILED_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type FULLTON_FAILED_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.FULLTON_FAILED_IDENTIFIED		
				end

			elseif EliminateTypeId == s10041_sequence.EliminateType.HELI then
				if svars.isIdentifiedVillageVip == false then
					Fox.Log("#### Set Eliminate Type HELI_NOT_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.HELI_NOT_IDENTIFIED	
				else
					Fox.Log("#### Set Eliminate Type HELI_IDENTIFIED ####")
					VIPEliminated = s10041_sequence.vipKillType.HELI_IDENTIFIED		
				end
			else
				Fox.Log("#### Not Set Eliminate Type ####")
			end

	

			s10041_sequence.DeleteHighInterrogationVillageVipAll()
		end
	else
		Fox.Log("#### This Enemy is not a VIP = " .. nGameObjectId)
		VIPEliminated = s10041_sequence.vipKillType.NOT_VIP

		local isVillageGuardEliminated	=	true				
		for index, enemyName in pairs(VILLAGE_GUARD_GROUP) do
			if	TppEnemy.IsEliminated(enemyName) == false then
				isVillageGuardEliminated	=	false
			end
		end
		if isVillageGuardEliminated == true and		
			svars.isMeetingAborted == false then
			Fox.Log("#### village guard all eliminated ####")
			TppRadio.ChangeIntelRadio( s10041_radio.intelRadioListGualdEliminated )
		end

	end
	Fox.Log("#### VIPEliminated ####" .. VIPEliminated)

	return VIPEliminated
end



function this.AnnounceVillageVipKill()	
	Fox.Log("#### s10041_enemy.AnnounceVillageVipKill ####")


	svars.isReserve_08 = true	
	TppMission.UpdateObjective{objectives = { "announce_FirstTargetKilled" , nil},}	
	s10041_sequence.UpdateAnnounceLogAchieveObjeciveCount()		
	TppMission.UpdateObjective{objectives = { "task0_complete" , nil},}	
	TppMission.UpdateObjective{	objectives = { "clear_photo_villageVip", nil },}
	s10041_sequence.AnnounceAllObjectiveFinish()
end

function this.AnnounceFieldVipKill()	
	Fox.Log("#### s10041_enemy.AnnounceFieldVipKill ####")

	svars.isReserve_09 = true	
	TppMission.UpdateObjective{objectives = { "announce_SecondTargetKilled" , nil},}	
	s10041_sequence.UpdateAnnounceLogAchieveObjeciveCount()		
	TppMission.UpdateObjective{objectives = { "task1_complete", nil },}	
	TppMission.UpdateObjective{	objectives = { "clear_photo_fieldVip", nil },	}
	s10041_sequence.AnnounceAllObjectiveFinish()
end


function this.AnnounceEnemyBaseVipKill()	
	Fox.Log("#### s10041_enemy.AnnounceEnemyBaseVipKill ####")


	svars.isReserve_10 = true 
	TppMission.UpdateObjective{objectives = { "announce_ThirdTargetKilled" , nil},}	
	s10041_sequence.UpdateAnnounceLogAchieveObjeciveCount()		
	TppMission.UpdateObjective{objectives = { "task2_complete", nil },}	
	TppMission.UpdateObjective{	objectives = { "clear_photo_enemyBaseVip", nil },	}
	s10041_sequence.AnnounceAllObjectiveFinish()
end







function this.TravelCountVIP(nGameObjectId)
	Fox.Log("###*** s10041_enemy.TravelCountVIP ####")

		
	if nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) then
		svars.travelCountField = svars.travelCountField + 1
		Fox.Log("#### FIELD VIP  Travel Count =" .. svars.travelCountField )
		
		
		if svars.travelCountField	== 0	then				
			Fox.Log("#### Travel step 0 ERROR_step! ####" )

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.DepartureCp	then									
			Fox.Log("#### Travel step 1  DepartureCp now afgh_field_cp ####" )

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.Lrrp29ToFieldEast then							
			Fox.Log("#### Travel step 2  Lrrp29ToFieldEast now afgh_16_29_lrrp ####" )

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.FieldEastToLrrp01 then							
			Fox.Log("#### Travel step 3  FieldEastToLrrp01 now afgh_fieldEast_ob ####" )
			s10041_sequence.DeleteHighInterrogationFieldEastNotCome()	

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.Lrrp01ToVillageEast then			
			Fox.Log("#### Travel step 4  Lrrp01ToVillageEast now afgh_01_16_lrrp ####" )
			s10041_sequence.AddHighInterrogationFieldEastGone()	

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.VillageEastToLrrp32 then			
			Fox.Log("#### Travel step 5  VillageEastToLrrp32 now afgh_villageEast_ob ####" )
			s10041_sequence.DeleteHighInterrogationVillageEastNotCome()		

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.Lrrp32ToVillage then				
			Fox.Log("#### Travel step 6  Lrrp32ToVillage now afgh_01_32_lrrp ####" )
			s10041_sequence.AddHighInterrogationVillageEastGone()	

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.VillageToTravelEnd then			
			Fox.Log("#### Travel step 7  VillageToTravelEnd noｆw afgh_village_cp ####" )

		elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.ArrivedVillage then				
			Fox.Log("#### Travel step 8  VillageToTravelEnd and ArrivedMessageSend ####" )


		else																								
			Fox.Log("#### NoNeedToCountAnyMore ####" )
		end




	elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) then

		svars.travelCountEnemyBase = svars.travelCountEnemyBase + 1
		Fox.Log("#### ENEMY BASE VIP Travel Count =" .. svars.travelCountEnemyBase )
		
		
		if svars.travelCountEnemyBase	== 0	then				
			Fox.Log("#### Travel step 0 ERROR_step! ####" )

		elseif svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.DepartureCp	then				
			Fox.Log("#### Travel step 1  DepartureCp now afgh_enemyBase_cp ####" )

		elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.Lrrp36ToVillageWest then			
			Fox.Log("#### Travel step 2  Lrrp36ToVillageWest now afgh_04_36_lrrp ####" )
			s10041_sequence.DeleteHighInterrogationVillageWestNotCome()	

		elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.VillageWestToLrrp32 then			
			Fox.Log("#### Travel step 3  FieldEastToLrrp01 now afgh_villageWest_ob ####" )
			s10041_sequence.AddHighInterrogationVillageWestGone()	

		elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.Lrrp32ToVillage then				
			Fox.Log("#### Travel step 4  Lrrp01ToVillageEast now afgh_04_32_lrrp ####" )

		elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.VillageToTravelEnd then					
			Fox.Log("#### Travel step 5  VillageToTravelEnd now afgh_village_cp ####" )

		elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.ArrivedVillage then						
			Fox.Log("#### Travel step 6  VillageToTravelEnd and ArrivedMessageSend ####" )

		else																								
			Fox.Log("#### NoNeedToCountAnyMore ####" )
	end


	elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.VILLAGE_VIP) then
		Fox.Log("#### Error VILLAGE VIP no travel ####")
	else
		Fox.Log("###*** This Enemy is not a VIP = " .. nGameObjectId)
	end
end


function this.returnDelayedVIP(nGameObjectId)
		
	if nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) then
		Fox.Log("#### FIELD VIP dalayed ####")
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0020" )
		this.SetFieldVipRoute("AFTER_MEETING")
	elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) then
		Fox.Log("#### ENEMY BASE VIP dalayed ####")
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0020" )
		this.SetEnemyBaseVipRoute("AFTER_MEETING")
	elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.VILLAGE_VIP) then
		Fox.Log("#### VILLAGE VIP dalayed ####")
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0020" )
		this.EndMeetingVillage ()
	else
		Fox.Log("#### This Enemy is not a VIP = " .. nGameObjectId)
	end
end


function this.SetWaitingVIP(nGameObjectId)
	local sequence = TppSequence.GetCurrentSequenceName()

	if ( sequence == "Seq_GameVipAssembleVillage" ) then	

		
		if nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) then
			Fox.Log("#### FIELD VIP WAITING ####")
			svars.isWaiting_fieldVip = true
		elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) then
			Fox.Log("#### ENEMY BASE VIP WAITING ####")
			svars.isWaiting_enemyBaseVip = true
		elseif nGameObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.VILLAGE_VIP) then
			Fox.Log("#### VILLAGE VIP WAITING ####")
			svars.isWaiting_villageVip = true
		else
			Fox.Log("#### This Enemy is not a VIP = " .. nGameObjectId)
		end

		
		local isWaitingVipRemain = 3
		if	svars.isWaiting_fieldVip == true then
			isWaitingVipRemain = isWaitingVipRemain -1
		end
		if	svars.isWaiting_enemyBaseVip == true then
			isWaitingVipRemain = isWaitingVipRemain -1
		end
		if svars.isWaiting_villageVip == true then
			isWaitingVipRemain = isWaitingVipRemain -1
		end
		if isWaitingVipRemain == 0 then	
			if	TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
				TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
				TppEnemy.GetLifeStatus(this.ENEMY_NAME.VILLAGE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and

				TppEnemy.GetStatus(this.ENEMY_NAME.FIELD_VIP) == EnemyState.NORMAL and
				TppEnemy.GetStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == EnemyState.NORMAL and
				TppEnemy.GetStatus(this.ENEMY_NAME.VILLAGE_VIP) == EnemyState.NORMAL then

				Fox.Log("#### MEETING BEGIN BEFORE TIMEOUT ####")
				
				for index, enemyName in pairs(ALL_VIP_GROUP) do
					TppEnemy.SetSneakRoute( enemyName, ALL_VIP_MEETING_ROUTES[index] )
				end
			else
				Fox.Log("#### SOME VIP ABNORMAL ####")	
			end
		else
			
			Fox.Log("#### Waiting VIP remain " .. isWaitingVipRemain .. "####")
			if	svars.isWaiting_fieldVip == false then
				Fox.Log("#### FIELD VIP ABSENT ####")
			end
			if svars.isWaiting_enemyBaseVip == false then
				Fox.Log("#### EnemyBase VIP ABSENT ####")
			end
			if svars.isWaiting_villageVip == false then
				Fox.Log("#### VILLAGE VIP ABSENT ####")
			end
		end
	end
end


function this.CheckVipLife()
	local isVipFullton = false
	for index, enemyName in pairs(ALL_VIP_GROUP) do
		local isVipStatus = TppEnemy.GetLifeStatus(enemyName)
		if isVipStatus == TppEnemy.LIFE_STATUS.DEAD then
		else
			Fox.Log("*** some Vip Alive ***")
			isVipFullton = true
		end
	end
	return isVipFullton
end








function this.AbortMeeting_Emergency()
	Fox.Log("#### Emergency VIP Meeting Aborted! ####")
	svars.isMeetingAborted		= true	
	TppUiCommand.SetMisionInfoCurrentStoryNo(1)	
	TppRadio.ChangeIntelRadio( s10041_radio.intelRadioListAbortMeeting )
	s10041_sequence.HighInterrogationAbortMeeting()


	this.UnsetRouteVillageGroup()	
	
	
	
	

	this.EndMeetingVillage ()	

	
	
	
	

	local phaseName =TppEnemy.GetPhase("afgh_village_cp")	
	this.AbortMonologue(phaseName)	

end





function this.AbortMeeting (phaseName)

	if svars.isMeetingAborted == true then
		Fox.Log("#### Meeting is already aborted. ####")
	else

		
		Fox.Log("#### VIP Meeting Aborted! ####")
		TppUiCommand.SetMisionInfoCurrentStoryNo(1)	
		TppRadio.ChangeIntelRadio( s10041_radio.intelRadioListAbortMeeting )
		s10041_sequence.HighInterrogationAbortMeeting()

		TppRadio.SetOptionalRadio( "Set_s0041_oprg0020" )
		this.UnsetRouteVillageGroup()	
		this.EndMeetingVillage ()	

		if	svars.isWaiting_fieldVip == false then	
			this.CancelTravelFieldVip(phaseName)
		else										
			TppMission.UpdateObjective{	objectives = { "route_vip_field_departure", nil  },}	
			this.SetFieldVipRoute("AFTER_MEETING")
			s10041_sequence.HighInterrogationFieldVipReturnTravel()	
		end

		if	svars.isWaiting_enemyBaseVip == false then
			this.CancelTravelEnemyBaseVip(phaseName)
		else										
			TppMission.UpdateObjective{	objectives = { "route_vip_enemyBase_departure", nil  },}	
			this.SetEnemyBaseVipRoute("AFTER_MEETING")
			s10041_sequence.HighInterrogationEnemyBaseVipReturnTravel()	
		end

		this.AbortMonologue(phaseName)	

		svars.isMeetingAborted		= true	
	end
end


function this.CancelTravelFieldVip(phaseName)
	Fox.Log("##### s10041_enemy.CancelTravelFieldVip ######")

	TppMission.UpdateObjective{	objectives = { "route_vip_field_departure", nil  },}	
	s10041_sequence.HighInterrogationFieldVipReturnTravel()	


	
	if svars.isCancelMeetingfieldVip == true then
		Fox.Log("#### FIELD VIP already cancel travel ####")	
	else
		if svars.isMeetingAborted == true then 
			Fox.Log("#### Meeting is already aborted. ####")
		else
			Fox.Log("#### FIELD VIP cancel Meeting! ####")
			svars.isCancelMeetingFieldVip = true		
			this.AbortMonologueField(phaseName)
			
			
			

			
			this.SetupStepBasedOntravelCountField()

			
			this.SetRestrictNoticeOnFDVIP()
		end
	end
end


function this.CancelTravelEnemyBaseVip(phaseName)
	Fox.Log("##### s10041_enemy.CancelTravelEnemyBaseVip ######")
	TppMission.UpdateObjective{	objectives = { "route_vip_enemyBase_departure", nil  },}	
	s10041_sequence.HighInterrogationEnemyBaseVipReturnTravel()	

	
	if svars.isCancelMeetingEnemyBaseVip == true then
		Fox.Log("#### ENEMYBASE VIP already cancel travel ####")
	else
		if svars.isMeetingAborted == true then 
			Fox.Log("#### Meeting is already aborted. ####")
		else
			Fox.Log("#### ENEMYBASE VIP cancel travel ####")
			svars.isCancelMeetingEnemyBaseVip =true		
			this.AbortMonologueEnemyBase(phaseName)

			
			
			

			
			this.SetRestrictNoticeOnEBVIP()

			
			this.SetupStepBasedOntravelCountEnemyBase()
		end
	end
end


function this.AbortMonologue(phaseName)
	local phaseName =TppEnemy.GetPhase("afgh_village_cp")	

	
	if TppEnemy.GetLifeStatus(this.ENEMY_NAME.VILLAGE_VIP) == TppEnemy.LIFE_STATUS.NORMAL	then
		this.AbortMonologueVillage()
		svars.isCancelMeetingVillageVip=true	

	else
		if TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
				svars.isWaiting_fieldVip == true then
			this.CpRadioFieldVip()
			
			svars.isCancelMeetingVillageVip=true				
		else
			if TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
				svars.isWaiting_enemyBaseVip == true then
				this.CpRadioEnemyBaseVip()
				
				svars.isCancelMeetingVillageVip=true							
			else
			
				Fox.Log("#### All VIPs aren't normal ####")
			end
		end
	end

end


function this.AbortMonologueVillage()
	Fox.Log("#### village vip try to use cp radio ####")

	local phaseName =TppEnemy.GetPhase("afgh_village_cp")	
	if TppEnemy.GetLifeStatus(this.ENEMY_NAME.VILLAGE_VIP) == TppEnemy.LIFE_STATUS.NORMAL then
		if ( phaseName == TppEnemy.PHASE.SNEAK) then
		elseif ( phaseName == TppEnemy.PHASE.ALERT) then	
			this.CpRadioVillage()
		else											
			this.CpRadioVillage()
		end
	end
end


function this.CpRadioVillage()
	Fox.Log("####  ####")
	this.CpRadioVillageMain()

end

function this.CpRadioVillageMain()
	Fox.Log("#### village vip cp radio NOW####")
	if		svars.isReserve_20	== false	then
		Fox.Log("#### village vip 1st time CP radio####")
		local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_vip_village" )
		local command = { id="CallRadio", label="HQSP030", stance="SquatCaution", voiceType="ene_a", isForce = true }
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### village vip has already CP radio once####")
	end
end



function this.AbortMonologueField(phaseName)
	Fox.Log("#### field group try to use cp radio ####")
	if ( phaseName == TppEnemy.PHASE.SNEAK) then
		Fox.Log("#### Phase is SNEAK ####")
	else
		Fox.Log("#### Phase is NOT SNEAK ####")
			if	svars.travelCountField	<=	6	then
				Fox.Log("#### StillOnTheWayToVillage ####")
				
					if TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_GUARD_00) == TppEnemy.LIFE_STATUS.NORMAL then
						Fox.Log("#### FieldGuard_Can_CallCP ####")
						this.CpRadioFieldGuard()
					else
						
						Fox.Log("#### FieldGuard_CanNOT_CallCP, CheckOn Driver ####")
								if TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_DRIVER) == TppEnemy.LIFE_STATUS.NORMAL then
									Fox.Log("#### FieldDriver_Can_CallCP ####")
									this.CpRadioFieldDriver()
								else
									
									Fox.Log("#### FieldDriver_CanNOT_CallCP, CheckOn Vip ####")
											if TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.NORMAL then
												Fox.Log("#### FieldVip_Can_CallCP ####")
												this.CpRadioFieldVip()
											else
												Fox.Log("#### Nobody_can_CallCP ####")
											end
								end
					end
			else
				Fox.Log("#### AlreadyEnterCPofVillage_NoNeedToCallCp ####")
			end
	end

end





function this.CpRadioFieldVip()
	Fox.Log("#### field vip cp radio NOW####")

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_vip_field" )
	local command = { id="CallRadio", label="HQSP020", stance="SquatCaution", voiceType="ene_d", isForce = true }

	if svars.isCancelMeetingVillageVip==false 		then						
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("###field vip NoNeed cp radio  ####")
	end
end


function this.CpRadioFieldDriver()
	Fox.Log("#### field driver cp radio NOW!####")

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_driver_field" )
	local command = { id="CallRadio", label="HQSP030", stance="SquatCaution", voiceType="ene_a", isForce = true }				
	if svars.isCancelMeetingVillageVip==false 		then						
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("###field driver NoNeed cp radio  ####")
	end
end


function this.CpRadioFieldGuard()
	Fox.Log("#### field guard cp radio NOW####")

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_guard_field_0000" )
	local command = { id="CallRadio", label="HQSP040", stance="SquatCaution", voiceType="ene_c", isForce = true }					
	if svars.isCancelMeetingVillageVip==false 		then						
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("###field guard NoNeed cp radio  ####")
	end
end






function this.AbortMonologueEnemyBase(phaseName)

	Fox.Log("#### enemyBase group try to use cp radio ####")
	if ( phaseName == TppEnemy.PHASE.SNEAK) then
		Fox.Log("#### Phase is SNEAK ####")
	else
		Fox.Log("#### Phase is NOT SNEAK ####")
		if	svars.travelCountEnemyBase		<=	4	then
			Fox.Log("#### StillOnTheWayToVillage ####")
				
				if TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_GUARD_00) == TppEnemy.LIFE_STATUS.NORMAL then
					Fox.Log("#### enemyBaseGuard_Can_CallCP ####")
					this.CpRadioEnemyBaseGuard()
				else
					
					Fox.Log("#### enemyBaseGuard_CanNOT_CallCP, CheckOn Driver ####")
							if TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_DRIVER) == TppEnemy.LIFE_STATUS.NORMAL then
								Fox.Log("#### enemyBaseDriver_Can_CallCP ####")
								this.CpRadioEnemyBaseDriver()
							else
								
								Fox.Log("#### FieldDriver_CanNOT_CallCP, CheckOn Vip ####")
										if TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.NORMAL then
											Fox.Log("#### enemyBaseVip_Can_CallCP ####")
											this.CpRadioEnemyBaseVip()
										else
											Fox.Log("#### Nobody_can_CallCP ####")
										end
							end
				end
		else
			Fox.Log("#### AlreadyEnterCPofVillage_NoNeedToCallCp ####")
		end
	end

end






function this.CpRadioEnemyBaseVip()
	Fox.Log("#### enemyBase vip cp radio NOW!####")

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_vip_enemyBase" )
	local command = { id="CallRadio", label="HQSP040", stance="SquatCaution", voiceType="ene_c", isForce = true }

	if svars.isCancelMeetingVillageVip==false then	
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("#### enemyBase vip NoNeed for cp radio ####")
	end
end



function this.CpRadioEnemyBaseDriver()
	Fox.Log("#### enemyBase driver cp radio NOW####")

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_driver_enemyBase" )
	local command = { id="CallRadio", label="HQSP030", stance="SquatCaution", voiceType="ene_a", isForce = true }			
	if svars.isCancelMeetingVillageVip==false 		then						
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("###enemyBase driver NoNeed cp radio  ####")
	end
end


function this.CpRadioEnemyBaseGuard()
	Fox.Log("#### enemyBase guard cp radio NOW####")

	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_guard_enemyBase_0000" )							
	local command = { id="CallRadio", label="HQSP020", stance="SquatCaution", voiceType="ene_d", isForce = true }
	if svars.isCancelMeetingVillageVip==false 		then						
		GameObject.SendCommand( gameObjectId, command )
	else
		Fox.Log("###enemyBase guard NoNeed cp radio  ####")
	end
end






function this.StartMeeting ()
	Fox.Log("#### s10041_enemy.StartMeeting####")

	
	local readyMeetingCount =0


	if svars.isMeetingAborted == true then
		Fox.Log("#### Meeting is already aborted. ####")
	else

		
		if	svars.isWaiting_fieldVip == true then
			readyMeetingCount = readyMeetingCount +1
		end
		if	svars.isWaiting_enemyBaseVip == true then
			readyMeetingCount = readyMeetingCount +1
		end
		if svars.isWaiting_villageVip == true then
			readyMeetingCount = readyMeetingCount +1
		end

		
		if (readyMeetingCount == 3 ) and 
				TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
				TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
				TppEnemy.GetLifeStatus(this.ENEMY_NAME.VILLAGE_VIP) == TppEnemy.LIFE_STATUS.NORMAL then


			Fox.Log("#### Meeting3Vip ####")	
			Fox.Log(" MeetingCount = " .. tostring(svars.meetingCount)	)

			this.StartMeeting3VIP()
		else
			Fox.Log("####Cancel Meeting ####")	
			this.CancelMeeting()
			
		end
	end
end




function this.CancelMeeting ()
	if svars.isMeetingAborted == true then
		Fox.Log("#### Meeting is already aborted. ####")
	else
		TppUiCommand.SetMisionInfoCurrentStoryNo(1)	
		TppRadio.ChangeIntelRadio( s10041_radio.intelRadioListAbortMeeting )
		s10041_sequence.AddHighInterrogationAfterMeeting()	
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0020" )


		
		if	TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.DEAD	or		
			(svars.isReserve_09 == true)		then		
				Fox.Log("#### fieldVip is Already GONE, Make sure other 2 don't always sit on the car and make them travel back ####")
				this.SetupStepBasedOntravelCountField()		
		end

		if	TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.DEAD	or		
			(svars.isReserve_10 == true)		then		
				Fox.Log("#### enemyBaseVip is Already GONE, Make sure other 2 don't always sit on the car and make them travel back ####")
				this.SetupStepBasedOntravelCountEnemyBase()		
		end
		

		
		if	TppEnemy.GetLifeStatus(this.ENEMY_NAME.VILLAGE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
			TppEnemy.GetStatus(this.ENEMY_NAME.VILLAGE_VIP) == EnemyState.NORMAL and
			svars.isWaiting_villageVip == true then
			
			svars.isCancelMeeting = true
			Fox.Log("#### cancel meeting by village Vip ####")	
			this.CallMonologue( this.ENEMY_NAME.VILLAGE_VIP, this.voiceTable.monologue.villageVip )

		elseif	TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
			TppEnemy.GetStatus(this.ENEMY_NAME.FIELD_VIP) == EnemyState.NORMAL and
			svars.isWaiting_fieldVip == true then
			
			svars.isCancelMeeting = true
			Fox.Log("#### cancel meeting by field Vip ####")	
			this.CallMonologue( this.ENEMY_NAME.FIELD_VIP, this.voiceTable.monologue.fieldVip )

		elseif	TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
			TppEnemy.GetStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == EnemyState.NORMAL and
			svars.isWaiting_enemyBaseVip == true then
			
			svars.isCancelMeeting = true
			Fox.Log("#### cancel meeting by enemyBase Vip ####")	
			this.CallMonologue( this.ENEMY_NAME.ENEMYBASE_VIP, this.voiceTable.monologue.enemyBaseVip )


		else
			Fox.Log("#### SOME VIP MISSING ####")	

		end
	end
end


this.CallMonologue = function( speaker, label )

	local gameObjectType = "TppSoldier2"
	local locatorNameA = speaker
	local locatorNameB = speaker

	
	if Tpp.IsTypeString(locatorNameA) then
		locatorNameA = GameObject.GetGameObjectId(gameObjectType, locatorNameA)
	end
	if Tpp.IsTypeString(locatorNameB) then
		locatorNameB = GameObject.GetGameObjectId(gameObjectType, locatorNameB)
	end

	GameObject.SendCommand( locatorNameA, {
		id		= "CallConversation",
		label	= label,
		friend	= locatorNameB,
	} )


end





function this.StartMeeting3VIP ()
	
	if svars.isMeetingAborted == true then
		Fox.Log("#### Meeting is already aborted. ####")
	else
		Fox.Log("#### VIP Started the Meeting! ####")

		
		
		
		if	TppEnemy.GetLifeStatus(this.ENEMY_NAME.FIELD_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
			TppEnemy.GetLifeStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and
			TppEnemy.GetLifeStatus(this.ENEMY_NAME.VILLAGE_VIP) == TppEnemy.LIFE_STATUS.NORMAL and

			TppEnemy.GetStatus(this.ENEMY_NAME.FIELD_VIP) == EnemyState.NORMAL and
			TppEnemy.GetStatus(this.ENEMY_NAME.ENEMYBASE_VIP) == EnemyState.NORMAL and
			TppEnemy.GetStatus(this.ENEMY_NAME.VILLAGE_VIP) == EnemyState.NORMAL then

			Fox.Log("#### ALL VIP STATUS NORMAL ####")
			this.getMeeting3ObjectsByRoute ()

		else
			this.AbortMeeting_Emergency()
		end
	
	end
end


function this.getMeeting3Objects ()
	Fox.Log("#### s10041_enemy.getMeeting3Objects ####")

	local gameObjectID_Speaker
	local gameObjectID_Listener
	local voiceLabelId
	local i = svars.meetingCount
	if svars.isCancelMeeting == false then	
		if svars.meetingPart == s10041_sequence.meetingPart.FIRST then
			Fox.Log("#### MEETING FIRST ####")
			gameObjectID_Speaker = GameObject.GetGameObjectId( "TppSoldier2", this.speakerTable.NameFirst[i] )
			gameObjectID_Listener = GameObject.GetGameObjectId( "TppSoldier2", this.listnerTable.NameFirst[i])
			voiceLabelId	=	this.voiceTable.labelFirst[i]

		elseif svars.meetingPart == s10041_sequence.meetingPart.FULLTON then	
			Fox.Log("#### MEETING FULLTON ####")
			gameObjectID_Speaker = GameObject.GetGameObjectId( "TppSoldier2", this.speakerTable.NameFullton[i] )
			gameObjectID_Listener = GameObject.GetGameObjectId( "TppSoldier2", this.listnerTable.NameFullton[i])
			voiceLabelId	=	this.voiceTable.labelFullton[i]
		elseif svars.meetingPart == s10041_sequence.meetingPart.KILL then	
			Fox.Log("#### MEETING KILL ####")
			gameObjectID_Speaker = GameObject.GetGameObjectId( "TppSoldier2", this.speakerTable.NameKill[i] )
			gameObjectID_Listener = GameObject.GetGameObjectId( "TppSoldier2", this.listnerTable.NameKill[i])
			voiceLabelId	=	this.voiceTable.labelKill[i]
		elseif svars.meetingPart == s10041_sequence.meetingPart.LAST then	
			Fox.Log("#### MEETING LAST ####")
			gameObjectID_Speaker = GameObject.GetGameObjectId( "TppSoldier2", this.speakerTable.NameLast[i] )
			gameObjectID_Listener = GameObject.GetGameObjectId( "TppSoldier2", this.listnerTable.NameLast[i])
			voiceLabelId	=	this.voiceTable.labelLast[i]
		else
		Fox.Log("#### meeting error ####")
			
			return nil
		end
		this.conversationMain(gameObjectID_Speaker,gameObjectID_Listener,voiceLabelId)
	end
end



function this.getMeeting3ObjectsByRoute ()

	
	local i = svars.meetingCount

	Fox.Log("#### s10041_enemy.getMeeting3Objects #### meeting count " .. i)

	if svars.isCancelMeeting == false then	
		if svars.meetingPart == s10041_sequence.meetingPart.FIRST then
			Fox.Log("#### MEETING FIRST ####")
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.VILLAGE_VIP, this.MeetingRouteTable.RouteFirstVillage[i] )
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.FIELD_VIP, this.MeetingRouteTable.RouteFirstField[i] )
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.ENEMYBASE_VIP, this.MeetingRouteTable.RouteFirstEnemyBase[i] )

		elseif svars.meetingPart == s10041_sequence.meetingPart.FULLTON then	
			Fox.Log("#### MEETING FULLTON ####")
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.VILLAGE_VIP, this.MeetingRouteTable.RouteFulltonVillage[i] )
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.FIELD_VIP, this.MeetingRouteTable.RouteFulltonField[i] )
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.ENEMYBASE_VIP, this.MeetingRouteTable.RouteFulltonEnemyBase[i] )

		elseif svars.meetingPart == s10041_sequence.meetingPart.LAST then	
			Fox.Log("#### MEETING LAST ####")
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.VILLAGE_VIP, this.MeetingRouteTable.RouteLastVillage[i] )
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.FIELD_VIP, this.MeetingRouteTable.RouteLastField[i] )
			TppEnemy.SetSneakRoute( this.ENEMY_NAME.ENEMYBASE_VIP, this.MeetingRouteTable.RouteLastEnemyBase[i] )

		else
			Fox.Log("#### meeting error ####")
			
			return nil
		end
	end
end




function this.conversationMain(speaker,listner,label)
	Fox.Log("#### s10041_enemy.conversationMain ####")

	GameObject.SendCommand(
		speaker,
		{
			id = "CallConversation",
			label=	label,
			friend = listner
		}
	)
end


function this.EndMeeting ()
	if svars.isMeetingAborted == true then
		Fox.Log("#### Meeting is already aborted. ####")
	else
		Fox.Log("#### Meeting finished. ####")
		svars.isMeetingAborted		= true	
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0020" )
		TppUiCommand.SetMisionInfoCurrentStoryNo(1)	
		TppRadio.ChangeIntelRadio( s10041_radio.intelRadioListAbortMeeting )

		s10041_sequence.DeleteHighInterrogationBeforeMeeting()
		s10041_sequence.DeleteHighInterrogationMeetingPoint()	

		s10041_sequence.HighInterrogationFieldVipReturnTravel()	
		s10041_sequence.HighInterrogationEnemyBaseVipReturnTravel()	
		TppMission.UpdateObjective{	objectives = { "deleteMeetingMarker","marker_villageVip", nil  },}	
		
		if	svars.isWaiting_fieldVip == true then
			TppMission.UpdateObjective{	objectives = { "route_vip_field_departure", nil  },}	
			this.SetFieldVipRoute("AFTER_MEETING")
		end
		if	svars.isWaiting_enemyBaseVip == true then
			TppMission.UpdateObjective{	objectives = { "route_vip_enemyBase_departure", nil  },}	
			this.SetEnemyBaseVipRoute("AFTER_MEETING")
		end
		if svars.isWaiting_villageVip == true then
			this.EndMeetingVillage ()
		end

		svars.isMeetingAborted		= true	
	end

end




	
this.CheckVipEmenyBaseBeforeArrviedVillage = function()
	Fox.Log("#### s10041_enemy.CheckVipEmenyBaseBeforeArrviedVillage ####")
	this.SetRelativeVehicleVigilance("veh_s10041_VipEnemyBase")		

end


this.UnsetTravelPlanForEnemy = function(soldierId)
	Fox.Log("#### s10041_enemy.UnsetTravelPlanForEnemy #### soldierId = " ..soldierId)

	
	if Tpp.IsTypeString( soldierId ) then
		soldierId = GameObject.GetGameObjectId( "TppSoldier2", soldierId )
	end

	
	GameObject.SendCommand( soldierId, { id = "StartTravel", travelPlan = "" } )
end



this.TransferCp = function(travelMember,planName)
	Fox.Log("#### s10041_enemy.TransferCp ####")

	
	local command = { id = "StartTravel", travelPlan = planName }
	
	if not Tpp.IsTypeTable( travelMember ) then
		travelMember = { travelMember }
	end

	if travelMember and next(travelMember) then
		for i,enemyName in pairs(travelMember) do
			local gameObjectId = GameObject.GetGameObjectId(enemyName)
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end


this.TransferCpStep = function(travelMember,planName,stepId)
	Fox.Log("#### s10041_enemy.TransferCpStep ####")

	Fox.Log("#### Travel step " .. stepId)
	
	local command = { id = "StartTravel", travelPlan = planName ,step = stepId}
	
	if not Tpp.IsTypeTable( travelMember ) then
		travelMember = { travelMember }
	end

	if travelMember and next(travelMember) then
		for i,enemyName in pairs(travelMember) do
			local gameObjectId = GameObject.GetGameObjectId(enemyName)
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end



this.TransferCpStepIndividual = function(nObjectId,planName,stepId)
	Fox.Log("#### s10041_enemy.TransferCpStepIndividual ####")
	if nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) or
		nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_DRIVER) or
		nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_GUARD_00) then

		local command = { id = "StartTravel", travelPlan = planName ,step = stepId}
		GameObject.SendCommand( nObjectId, command )
	else

	end
end


this.SetupStepBasedOntravelCountField	 = function()
	Fox.Log("###***s10041_enemy.SetupStepBasedOntravelCountField####")

	local step
	if svars.travelCountField	== s10041_sequence.FieldVipSequence.DepartureCp	then							
		step = 7																											
		Fox.Log("#### VipFD Travel Return Start From *step7* lrrpVipFieldTo29_back ####" .. step )

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.Lrrp29ToFieldEast then					
		step = 6																											
		Fox.Log("#### VipFD Travel Return Start From *step6* lrrp_v_16to29 ####" .. step )

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.FieldEastToLrrp01 then					
		step = 5																										
		Fox.Log("#### VipFD Travel Return Start From *step5* lrrp_v_fieldEast_ob_01to29 ####" .. step )

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.Lrrp01ToVillageEast then					
		step = 4																										
		Fox.Log("#### VipFD Travel Return Start From *step4* lrrp_v_01to16 ####" .. step )

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.VillageEastToLrrp32 then				
		step = 3																										
		Fox.Log("#### VipFD Travel Return Start From *step3* lrrp_v_villageEast_ob_32to16 ####" .. step )

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.Lrrp32ToVillage then				
		step = 2																										
		Fox.Log("#### VipFD Travel Return Start From *step2* lrrp_v_32to01 ####" .. step )

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.VillageToTravelEnd then				
		
		Fox.Log("#### VipFD Haven't arrived Village Yet KeepTravelling ####")

	elseif	svars.travelCountField	== s10041_sequence.FieldVipSequence.ArrivedVillage then						
		step = 0
		Fox.Log("#### VipFDTravel step 0 Start From afgh_village_cp ####" .. step )

	else																								
		Fox.Log("#### Travel step NeverMind ####")
	end


	if step == 7 then
		Fox.Log("###**** VipFD Return from Step7 NOW####")
		this.SetCpCaution("afgh_field_cp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipField")											
		this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)				

	elseif step == 6 then
		Fox.Log("###**** VipFD Return from Step6 NOW####")
		this.SetCpCaution("afgh_16_29_lrrp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipField")											
		this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)						

	elseif step == 5 then
		Fox.Log("###**** VipFD Return from Step5 NOW####")
		this.SetCpCaution("afgh_fieldEast_ob")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipField")											
		this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)						

	elseif step == 4 then
		Fox.Log("###**** VipFD Return from Step4 NOW####")
		this.SetCpCaution("afgh_01_16_lrrp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipField")											
		this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)						

	elseif step == 3 then
		Fox.Log("###**** VipFD Return from Step3 NOW####")
		this.SetCpCaution("afgh_villageEast_ob")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipField")											
		this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)						

	elseif step == 2 then
		Fox.Log("###**** VipFD Return from Step2 NOW####")
		this.SetCpCaution("afgh_01_32_lrrp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipField")											
		this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)						

	elseif step == 0 then
																									
		if	TppEnemy.IsVehicleBroken( "veh_s10041_VipField" )	== true	then
			Fox.Log("###**** VehIsBroken Return_Run from Step0 Now ####")
			Fox.Log("###**** VipFD already arrived Village, Return from Step0 Now ####")
			this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return_Run",step)						
		else
			Fox.Log("###****VehIsAvailable VipFD already arrived Village, Return from Step0 Now ####")
			this.TransferCpStep( FIELD_VIP_GROUP,"lrrp_FieldToVillage_Return",step)				
		end

	else
		Fox.Log("#### Travel step NeverMind & VipFD has on the way back  ####")
	end

end



this.SetupStepBasedOntravelCountEnemyBase	 = function()
	Fox.Log("###***s10041_enemy.SetupStepBasedOntravelCountEnemyBase####")

	local step
	if svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.DepartureCp	then					
		step = 5																											
		Fox.Log("#### Travel step 5 Start From lrrp_VipEnemyBaseTo36_Back ####" .. step )

	elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.Lrrp36ToVillageWest then			
		step = 4																											
		Fox.Log("#### Travel step 4 Start From lrrp_v_04to36 ####" .. step )

	elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.VillageWestToLrrp32 then			
		step = 3																											
		Fox.Log("#### Travel step 3 Start From lrrp_v_villageWest_ob_32to36 ####" .. step )

	elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.Lrrp32ToVillage then				
		step = 2																											
		Fox.Log("#### Travel step 2 Start From lrrp_v_32to04 ####" .. step )

	elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.VillageToTravelEnd then				
		
		Fox.Log("#### Haven't arrived Village Yet KeepTravelling ####")

	elseif	svars.travelCountEnemyBase	== s10041_sequence.EnemyBaseVipSequence.ArrivedVillage then				
		step = 0
		Fox.Log("#### Travel step 0 Start From afgh_village_cp ####" .. step )

	else																								
		Fox.Log("#### Travel step NeverMind ####")
	end


	if step == 5 then
		Fox.Log("###**** EB VIP Return from Step5 NOW####")
		this.SetCpCaution("afgh_enemyBase_cp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipEnemyBase")									
		this.TransferCpStep( ENEMYBASE_VIP_GROUP,"lrrp_EnemyBaseToVillage_Return_Run",step)		

	elseif step == 4 then
		Fox.Log("###**** EB VIP Return from Step4 NOW####")
		this.SetCpCaution("afgh_04_36_lrrp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipEnemyBase")									
		this.TransferCpStep( ENEMYBASE_VIP_GROUP,"lrrp_EnemyBaseToVillage_Return_Run",step)		

	elseif step == 3 then
		Fox.Log("###**** EB VIP Return from Step3 NOW####")
		this.SetCpCaution("afgh_villageWest_ob")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipEnemyBase")									
		this.TransferCpStep( ENEMYBASE_VIP_GROUP,"lrrp_EnemyBaseToVillage_Return_Run",step)		

	elseif step == 2 then
		Fox.Log("###**** EB VIP Return from Step2 NOW####")
		this.SetCpCaution("afgh_04_32_lrrp")															
		this.UnsetRelativeVehicleNow("veh_s10041_VipEnemyBase")									
		this.TransferCpStep( ENEMYBASE_VIP_GROUP,"lrrp_EnemyBaseToVillage_Return_Run",step)		

	elseif step == 0 then
																									
		if	TppEnemy.IsVehicleBroken( "veh_s10041_VipEnemyBase" )	== true	then
			Fox.Log("###**** VehIsBroken Return_Run from Step0 Now ####")
			this.TransferCpStep( ENEMYBASE_VIP_GROUP,"lrrp_EnemyBaseToVillage_Return_Run",step)		
		else
			Fox.Log("###****VehIsAvailable EB VIP already arrived Village, Return from Step0 Now ####")
			this.TransferCpStep( ENEMYBASE_VIP_GROUP,"lrrp_EnemyBaseToVillage_Return",step)		
		end
	else
		Fox.Log("#### Travel step NeverMind & EB VIP has on the way back  ####")
	end

end



this.TransferCpMembers = function(travelMember,planName)
	Fox.Log("#### s10041_enemy.TransferCpMembers ####")

	
	
	if not Tpp.IsTypeTable( travelMember ) then
		travelMember = { travelMember }
	end

	if travelMember and next(travelMember) then
		for index,enemyName in pairs(travelMember) do
		local command = { id = "StartTravel", travelPlan =	planName[index] }
			local gameObjectId = GameObject.GetGameObjectId(enemyName)
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end



this.SetCpCaution = function(cpID)
	Fox.Log("!!!! this.SetCpCaution !!!!  :  " .. tostring(cpID))
	local gameObjectId = GameObject.GetGameObjectId( cpID )
	GameObject.SendCommand( gameObjectId, {id = "SetPhase",phase = TppGameObject.PHASE_CAUTION} )			
end



this.UnsetRouteVillageGroup = function()
	for index, enemyName in pairs(VILLAGE_VIP_GROUP) do
		TppEnemy.UnsetSneakRoute( enemyName )
	end
end



this.UnsetRouteFieldGroup = function()

	Fox.Log("#### cancel All Routes FIELD_VIP_GROUP. ####")

	

	for index, enemyName in pairs(FIELD_VIP_GROUP) do
		TppEnemy.UnsetSneakRoute( enemyName )
		TppEnemy.UnsetCautionRoute( enemyName )
	end
end











this.UnsetRouteEnemyBaseGroup = function()
	Fox.Log("#### cancel All Routes ENEMYBASE_VIP_GROUP. ####")

	
	

	for index, enemyName in pairs(ENEMYBASE_VIP_GROUP) do
		TppEnemy.UnsetSneakRoute( enemyName )
		TppEnemy.UnsetCautionRoute( enemyName )
	end
end


function this.all_enemy_route_shift_Day()
	Fox.Log("#### s10041_enemy.all_enemy_route_shift_Day ####")
	if svars.isMeetingAborted == false then	
		
		this.SetVillageVipRoute("BEFORE_MEETING_DAY")
	else								
		
		this.SetVillageVipRoute("AFTER_MEETING_DAY")
	end

	if svars.isReturn_enemyBaseVip	== true then	
		
		this.SetEnemyBaseVipRoute("BACK_BASE_DAY")
	end

	if svars.isReturn_fieldVip	== true then	
		
		this.SetFieldVipRoute("BACK_BASE_DAY")
	end
end

function this.all_enemy_route_shift_Night()
	Fox.Log("#### s10041_enemy.all_enemy_route_shift_Night ####")
	if svars.isMeetingAborted == false then	
		
		this.SetVillageVipRoute("BEFORE_MEETING_NIGHT")
	else								
		
		this.SetVillageVipRoute("AFTER_MEETING_NIGHT")
	end

	if svars.isReturn_enemyBaseVip	== true then	
		
		this.SetEnemyBaseVipRoute("BACK_BASE_NIGHT")
	end

	if svars.isReturn_fieldVip	== true then	
		
		this.SetFieldVipRoute("BACK_BASE_NIGHT")
	end

end

function this.EnemyBaseVipBackBase ()
	Fox.Log("#### s10041_enemy.EnemyBaseVipBackBase ####")
	svars.isReturn_enemyBaseVip		= true	

	if	TppEnemy.IsEliminated(s10041_enemy.ENEMY_NAME.FIELD_VIP) == true 
			or svars.isReturn_fieldVip == true then	
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0040" )
	end

	s10041_sequence.HighInterrogationEnemyBaseVipBack()	
	s10041_sequence.AddHighInterrogationVillageWestSetMine()

	TppMission.UpdateObjective{	objectives = { "marker_enemyBaseVip", nil  },}	

	local string =	TppClock.GetTimeOfDay() 
	if string == "day" then	
		this.SetEnemyBaseVipRoute("BACK_BASE_DAY")
		this.SetEnemyBaseVipCautionRoute("BACK_BASE_CAUTION")		
	else	
		this.SetEnemyBaseVipRoute("BACK_BASE_NIGHT")
		this.SetEnemyBaseVipCautionRoute("BACK_BASE_CAUTION")		
	end
end


this.SetEnemyBaseVipRoute = function( status )
	for index, enemyName in ipairs(ENEMYBASE_VIP_GROUP) do
		TppEnemy.SetSneakRoute( enemyName, ENEMYBASE_VIP_ROUTES[status][index] )
	end
end

this.SetEnemyBaseVipCautionRoute = function( status )
	for index, enemyName in ipairs(ENEMYBASE_VIP_GROUP) do
		TppEnemy.SetCautionRoute( enemyName, ENEMYBASE_VIP_ROUTES[status][index] )
	end
end



function this.FieldVipBackBase ()
	Fox.Log("#### s10041_enemy.FieldVipBackBase ####")
	svars.isReturn_fieldVip			= true	

	if	TppEnemy.IsEliminated(s10041_enemy.ENEMY_NAME.ENEMYBASE_VIP) == true 
			or svars.isReturn_enemyBaseVip == true then	
		TppRadio.SetOptionalRadio( "Set_s0041_oprg0040" )
	end

	s10041_sequence.HighInterrogationFieldVipBack()	

	s10041_sequence.AddHighInterrogationFieldEastSetMine()
	s10041_sequence.AddHighInterrogationVillageEastSetMine()

	TppMission.UpdateObjective{	objectives = { "marker_fieldVip", nil  },}	

	local string =	TppClock.GetTimeOfDay() 
	if string == "day" then	
		this.SetFieldVipRoute("BACK_BASE_DAY")
		this.SetFieldVipCautionRoute("BACK_BASE_CAUTION")		
	else	
		this.SetFieldVipRoute("BACK_BASE_NIGHT")
		this.SetFieldVipCautionRoute("BACK_BASE_CAUTION")		
	end
end


this.SetFieldVipRoute = function( status )
	for index, enemyName in ipairs(FIELD_VIP_GROUP) do
		TppEnemy.SetSneakRoute( enemyName, FIELD_VIP_ROUTES[status][index] )
	end
end


this.SetFieldVipCautionRoute = function( status )
	for index, enemyName in ipairs(FIELD_VIP_GROUP) do
		TppEnemy.SetCautionRoute( enemyName, FIELD_VIP_ROUTES[status][index] )
	end
end

this.WaitingVillageVipRoute = function( )
	Fox.Log("*** set field group route ***")
	local string =	TppClock.GetTimeOfDay() 
	if string == "day" then	
		this.SetVillageVipRoute("BEFORE_MEETING_DAY")
	else	
		this.SetVillageVipRoute("BEFORE_MEETING_NIGHT")
	end
end


function this.EndMeetingVillage ()
	local string =	TppClock.GetTimeOfDay() 
	if string == "day" then	
		this.SetVillageVipRoute("AFTER_MEETING_DAY")
	else	
		this.SetVillageVipRoute("AFTER_MEETING_NIGHT")
	end
end


this.SetVillageVipRoute = function( status )
	for index, enemyName in ipairs(VILLAGE_VIP_GROUP) do
		TppEnemy.SetSneakRoute( enemyName, VILLAGE_VIP_ROUTES[status][index] )
		TppEnemy.SetCautionRoute( enemyName, VILLAGE_VIP_ROUTES["CAUTION"][index] )
	end
end
















this.SetNpcStaffParameter = function( soldierName, uniqueTypeId ,alreadyExistParam )
	local GetGameObjectId = GameObject.GetGameObjectId
	local SendCommand = GameObject.SendCommand
	local gameObjId = GetGameObjectId(soldierName)

	
	TppEnemy.AssignUniqueStaffType{	locaterName = soldierName,	uniqueStaffTypeId = uniqueTypeId,	alreadyExistParam = alreadyExistParam}

end


this.SetUpRegisterMessage = function()
	local CHECK_PHASE_MEMBER =	{
		"sol_vip_field",
		"sol_vip_village",
		"sol_vip_enemyBase",

		"sol_driver_field",
		"sol_guard_field_0000",
		"sol_driver_enemyBase",
		"sol_guard_enemyBase_0000",
	}
	local command = { id = "RegisterMessage", message="ChangePhase", isRegistered=true }

	for i , enemyName in pairs(CHECK_PHASE_MEMBER) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		GameObject.SendCommand( gameObjectId, command )
	end
end





function this.SetVipVoiceType()
	local VIP_LIST =	{
		"sol_vip_field",					
		"sol_vip_village",
		"sol_vip_enemyBase",

		"sol_driver_field",				
		"sol_guard_field_0000",		

		"sol_driver_enemyBase",				
		"sol_guard_enemyBase_0000",		
	}
	local VIP_VOICE_TYPE =	{
		[1]="ene_d",
		[2]="ene_a",
		[3]="ene_c",

		[4]="ene_a",
		[5]="ene_c",

		[6]="ene_a",
		[7]="ene_d",

	}

	for i , enemyName in pairs(VIP_LIST) do
		this.SetVoiceType(enemyName,VIP_VOICE_TYPE[i])
	end
end



function this.SetVoiceType(enemyName,voiceType)

	
	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "soldier0000" )
	local command = { id = "SetVoiceType", voiceType= voiceType }
	local actionState = GameObject.SendCommand( gameObjectId, command )

end







this.SetRelativeVehicle = function(vehicleName)
	Fox.Log("*** s10041_enemy.SetRelativeVehicle")
	for index, enemyName in ipairs(GRU_VEHICLE_GROUP[vehicleName]) do
		local soldierName = GRU_VEHICLE_GROUP[vehicleName][index]
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId , rideFromBeginning=false, isMust = true }			
		Fox.Log("### vehicleId  ###"  .. tostring(vehicleName) )
		Fox.Log("### soldierId  ###"  .. tostring(soldierName) )

		GameObject.SendCommand( soldierId, command )
	end
end

this.SetVipRelativeVehicleMust = function()
	Fox.Log("*** s10041_enemy.SetVipRelativeVehicleMust")

		local enemyBaseVip 		= GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP)
		local enemyBaseVeh 	= GameObject.GetGameObjectId("TppVehicle2", "veh_s10041_VipEnemyBase" )
		local enemyBaseVipcommand = { id="SetRelativeVehicle", targetId=enemyBaseVeh , rideFromBeginning=false, isMust=true }			

		local fieldVip				= GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP)
		local fieldVeh 			= GameObject.GetGameObjectId("TppVehicle2", "veh_s10041_VipField" )
		local fieldVipcommand 	= { id="SetRelativeVehicle", targetId=fieldVeh , rideFromBeginning=false }			

		GameObject.SendCommand( enemyBaseVip, enemyBaseVipcommand )

		GameObject.SendCommand( fieldVip, fieldVipcommand )
end


this.SetRelativeVehicleVigilance = function(vehicleName)
	Fox.Log("*** s10041_enemy.SetRelativeVehicleVigilance")
	for index, enemyName in ipairs(GRU_VEHICLE_GROUP[vehicleName]) do
		local soldierName = GRU_VEHICLE_GROUP[vehicleName][index]
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId , rideFromBeginning=false, isVigilance=true }
		Fox.Log("### vehicleId  ###"  .. tostring(vehicleName) )
		Fox.Log("### soldierId  ###"  .. tostring(soldierName) )

		GameObject.SendCommand( soldierId, command )
	end
end


this.SetRelativeVehicleNoVigilance = function(vehicleName)
	Fox.Log("*** s10041_enemy.SetRelativeVehicleNoVigilance")
	for index, enemyName in ipairs(GRU_VEHICLE_GROUP[vehicleName]) do
		local soldierName = GRU_VEHICLE_GROUP[vehicleName][index]
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local vehicleId = GameObject.GetGameObjectId("TppVehicle2", vehicleName )
		local command = { id="SetRelativeVehicle", targetId=vehicleId , rideFromBeginning=false, isVigilance=false }
		Fox.Log("### vehicleId  ###"  .. tostring(vehicleName) )
		Fox.Log("### soldierId  ###"  .. tostring(soldierName) )

		GameObject.SendCommand( soldierId, command )
	end
end


this.UnsetRelativeVehicleNow = function(vehicleName)
	Fox.Log("*** s10041_enemy.UnsetRelativeVehicleNow")

	for index, enemyName in ipairs(GRU_VEHICLE_GROUP[vehicleName]) do			
		local soldierName = GRU_VEHICLE_GROUP[vehicleName][index]
		local soldierId = GameObject.GetGameObjectId("TppSoldier2", soldierName )
		local command = { id="UnsetRelativeVehicle"}									
		Fox.Log("### soldierId  ###"  .. tostring(soldierName) )
		GameObject.SendCommand( soldierId, command )
	end

end


this.SetEnemyBaseVIPRoutesInVillageWest = function( nObjectId )
	Fox.Log("*** s10041_enemy.SetEnemyBaseVIPRoutesInVillageWest")

	this.UnsetTravelPlanForEnemy( nObjectId )		

	this.UnSetRestrictNoticeOnEBVIP()			

	if nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_VIP) then
		Fox.Log("*** VipEB_Start_to_HideInVillageWest")
		TppEnemy.SetSneakRoute( "sol_vip_enemyBase", "rts_EB_villageWest_s_0000" )
		TppEnemy.SetCautionRoute( "sol_vip_enemyBase", "rts_EBVip_villageWest_c_0000" )

	elseif nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_DRIVER) then
		Fox.Log("*** DriverEB_Start_to_HideInVillageWest")
		TppEnemy.SetSneakRoute( "sol_driver_enemyBase", "rts_EB_villageWest_s_0000" )
		TppEnemy.SetCautionRoute( "sol_driver_enemyBase", "rts_EBDriver_villageWest_c_0000" )

	elseif nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.ENEMYBASE_GUARD_00) then
		Fox.Log("*** GuardEB_Start_to_HideInVillageWest")
		TppEnemy.SetSneakRoute( "sol_guard_enemyBase_0000", "rts_EB_villageWest_s_0000" )
		TppEnemy.SetCautionRoute( "sol_guard_enemyBase_0000", "rts_EBGuard_villageWest_c_0000" )
	else

	end
end



this.SetFieldVIPRoutesInFieldEast = function( nObjectId )
	Fox.Log("*** s10041_enemy.SetFieldVIPRoutesInFieldEast")

	this.UnsetTravelPlanForEnemy( nObjectId )		

	this.UnSetRestrictNoticeOnFDVIP()				

	if nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) then
		Fox.Log("*** VipFD_Start_to_HideInFieldEast")
		TppEnemy.SetSneakRoute( "sol_vip_field", "rts_FD_fieldEast_s_0000" )
		TppEnemy.SetCautionRoute( "sol_vip_field", "rts_FDVip_fieldEast_c_0000" )

	elseif nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_DRIVER) then
		Fox.Log("*** DriverFD_Start_to_HideInFieldEast")
		TppEnemy.SetSneakRoute( "sol_driver_field", "rts_FD_fieldEast_s_0000" )
		TppEnemy.SetCautionRoute( "sol_driver_field", "rts_FDDriver_fieldEast_c_0000" )

	elseif nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_GUARD_00) then
		Fox.Log("*** GuardFD_Start_to_HideInFieldEast")
		TppEnemy.SetSneakRoute( "sol_guard_field_0000", "rts_FD_fieldEast_s_0000" )
		TppEnemy.SetCautionRoute( "sol_guard_field_0000", "rts_FDGuard_fieldEast_c_0000" )
	else

	end

end


this.SetFieldVIPRoutesInVillageEast = function( nObjectId )
	Fox.Log("*** s10041_enemy.SetFieldVIPRoutesInVillageEast")

	this.UnsetTravelPlanForEnemy( nObjectId )		

	this.UnSetRestrictNoticeOnFDVIP()				

	if nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_VIP) then
		Fox.Log("*** VipFD_Start_to_HideInVillageEast")
		TppEnemy.SetSneakRoute( "sol_vip_field", "rts_FD_villageEast_s_0000" )
		TppEnemy.SetCautionRoute( "sol_vip_field", "rts_FDVip_villageEast_c_0000" )

	elseif nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_DRIVER) then
		Fox.Log("*** DriverFD_Start_to_HideInVillageEast")
		TppEnemy.SetSneakRoute( "sol_driver_field", "rts_FD_villageEast_s_0000" )
		TppEnemy.SetCautionRoute( "sol_driver_field", "rts_FDDriver_villageEast_c_0000" )

	elseif nObjectId == GameObject.GetGameObjectId("TppSoldier2", this.ENEMY_NAME.FIELD_GUARD_00) then
		Fox.Log("*** GuardFD_Start_to_HideInVillageEast")
		TppEnemy.SetSneakRoute( "sol_guard_field_0000", "rts_FD_villageEast_s_0000" )
		TppEnemy.SetCautionRoute( "sol_guard_field_0000", "rts_FDGuard_villageEast_c_0000" )
	else

	end

end



this.SetRestrictNoticeOnFDVIP = function()

	local gameObjectId
	for i, name in pairs( FIELD_VIP_GROUP ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			Fox.Log("###***s10041_enemy.SetRestrictNoticeOnFDVIP "..name )
			gameObjectId = GameObject.GetGameObjectId( name )
			GameObject.SendCommand( gameObjectId, { id="SetRestrictNotice", enabled = true }  )
		end
	end
end


this.UnSetRestrictNoticeOnFDVIP = function()
	local gameObjectId

	for i, name in pairs( FIELD_VIP_GROUP ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			Fox.Log("****s10041_enemy.UnSetRestrictNoticeOnFDVIP "..name )
			gameObjectId = GameObject.GetGameObjectId( name )
			GameObject.SendCommand( gameObjectId, { id="SetRestrictNotice", enabled = false }  )
		end
	end
end




this.SetRestrictNoticeOnEBVIP = function()

	local gameObjectId
	for i, name in pairs( ENEMYBASE_VIP_GROUP ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			Fox.Log("****s10041_enemy.SetRestrictNoticeOnEBVIP "..name )
			gameObjectId = GameObject.GetGameObjectId( name )
			GameObject.SendCommand( gameObjectId, { id="SetRestrictNotice", enabled = true }  )
		end
	end
end


this.UnSetRestrictNoticeOnEBVIP = function()
	local gameObjectId

	for i, name in pairs( ENEMYBASE_VIP_GROUP ) do
		if name == nil then
			Fox.Error("name is nil")
		else
			Fox.Log("****s10041_enemy.UnSetRestrictNoticeOnEBVIP "..name )
			gameObjectId = GameObject.GetGameObjectId( name )
			GameObject.SendCommand( gameObjectId, { id="SetRestrictNotice", enabled = false }  )
		end
	end
end





























































this.CheckVipRouteMarker	= function ()
	
end













this.SetUpRelativeVehicle = function(vehicleName)
	this.SetRelativeVehicle("veh_s10041_VipField")
	this.SetRelativeVehicle("veh_s10041_VipEnemyBase")
end




this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(targetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end














this.InitEnemy = function ()
	Fox.Log("*** s10041_enemy.InitEnemy() ***")
end



this.SetUpEnemy = function ()
	Fox.Log("*** s10041_enemy.SetUpEnemy() ***")





	if DEBUG then
	
	
		if svars.isSkipToConversation == true then
			this.SetVipRouteConversation()
			GameObject.SendCommand( GameObject.GetGameObjectId("TppVehicle2", "veh_s10041_VipField" ), { id  = "SetPosition", position = Vector3( 526.034, 320.619 ,1190.245 ), rotY = 0, } )
			GameObject.SendCommand( GameObject.GetGameObjectId("TppVehicle2", "veh_s10041_VipEnemyBase" ), { id  = "SetPosition", position = Vector3( 514.948, 321.339 ,1190.875 ), rotY = 0, } )
		else
			this.SetVipRoute()
		end
	
	else
		this.SetVipRoute()
	end

	this.SetUpRegisterMessage()

	
	

	
	TppEnemy.RegistHoldBrokenState("veh_s10041_VipField")
	TppEnemy.RegistHoldBrokenState("veh_s10041_VipEnemyBase")

	this.SetUpRelativeVehicle()				
	this.SetVipRelativeVehicleMust()			

	TppEnemy.SetEliminateTargets(
		
		{ this.ENEMY_NAME.FIELD_VIP,this.ENEMY_NAME.ENEMYBASE_VIP,this.ENEMY_NAME.VILLAGE_VIP,
		}
	)

	
	local targetList = {
		this.ENEMY_NAME.FIELD_DRIVER,
		this.ENEMY_NAME.FIELD_GUARD_00,
		this.ENEMY_NAME.ENEMYBASE_DRIVER,
		this.ENEMY_NAME.ENEMYBASE_GUARD_00,
		"hos_subTarget_0000",
		"hos_subTarget_0001",
	}
	this.RegistHoldRecoveredStateForMissionTask( targetList )

	this.SetNpcStaffParameter( this.ENEMY_NAME.FIELD_VIP, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_FIELD_COMMANDER ,{ staffTypeId =2, randomRangeId =6, skill ="Grappler" })	
	this.SetNpcStaffParameter( this.ENEMY_NAME.VILLAGE_VIP, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_VILLAGE_COMMANDER ,{ staffTypeId =15, randomRangeId =6, skill =nil })
	this.SetNpcStaffParameter( this.ENEMY_NAME.ENEMYBASE_VIP, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_ENEMY_BASE_COMMANDER ,{ staffTypeId =5, randomRangeId =6, skill =nil })

	this.SetNpcStaffParameter( this.ENEMY_NAME.FIELD_DRIVER, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_FIELD_DRIVER ,{ staffTypeId =58, randomRangeId =4, skill =nil })
	this.SetNpcStaffParameter( this.ENEMY_NAME.FIELD_GUARD_00, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_FIELD_BODYGUARD,{ staffTypeId =2, randomRangeId =6, skill =nil} )

	this.SetNpcStaffParameter( this.ENEMY_NAME.ENEMYBASE_DRIVER, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_ENEMY_BASE_DRIVER ,{ staffTypeId =3, randomRangeId =6, skill ="RadarEngineer" })
	this.SetNpcStaffParameter( this.ENEMY_NAME.ENEMYBASE_GUARD_00, TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_ENEMY_BASE_BODYGUARD ,{ staffTypeId =41, randomRangeId =4, skill =nil })

	this.SetNpcStaffParameter( "hos_subTarget_0000", TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_HOSTAGE_A ,{ staffTypeId =62, randomRangeId =4, skill =nil })
	this.SetNpcStaffParameter( "hos_subTarget_0001", TppDefine.UNIQUE_STAFF_TYPE_ID.S10041_HOSTAGE_B ,{ staffTypeId =62, randomRangeId =4, skill ="Botanist"} )	


	
	local gameObjectId
	local command
	command = { id = "SetLangType", langType="pashto" }
	gameObjectId = GameObject.GetGameObjectId( "hos_subTarget_0000" )
	GameObject.SendCommand( gameObjectId, command )

	gameObjectId = GameObject.GetGameObjectId( "hos_subTarget_0001" )
	GameObject.SendCommand( gameObjectId, command )

end





this.OnLoad = function ()
end




return this
