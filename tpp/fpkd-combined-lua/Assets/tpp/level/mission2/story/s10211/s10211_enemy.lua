local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}

local SUPER_REINFORCE_VHEHICLE_RESERVE = 1	


local JACKAL_GROUP01 = "anml_Jackal_00"
local JACKAL_GROUP02 = "anml_Jackal_01"
local JACKAL_GROUP03 = "anml_Jackal_02"
local JACKAL_GROUP04 = "anml_Jackal_03"
local JACKAL_GROUP05 = "anml_Jackal_04"
local JACKAL_GROUP06 = "anml_Jackal_05"


local ESCAPE_POINT_00	=0
local ESCAPE_POINT_01	=1
local ESCAPE_POINT_02	=2
local ESCAPE_POINT_03	=3
local ESCAPE_POINT_04	=4
local ESCAPE_POINT_05	=5


local CARRY_TALK_00	=0
local CARRY_TALK_01	=1
local CARRY_TALK_02	=2
local CARRY_TALK_03	=3
local CARRY_TALK_04	=4
local CARRY_TALK_05	=5
local CARRY_TALK_06	=6
local CARRY_TALK_07	=7
local CARRY_TALK_08	=8
local CARRY_TALK_09	=9
local CARRY_TALK_10	=10
local CARRY_TALK_11	=11
local CARRY_TALK_12	=12


local 	GUARD_TALK_FIRST=0
local 	GUARD_TALK_SECOND=1


	
this.LABEL_INTEL = "enqt1000_094538"	
	
this.LABEL_HOSTAGE = "enqt1000_106943"

	
this.LABEL_TARGET_AREA ="enqt3000_191010"	

	
this.LABEL_TARGET_POSITION =  "enqt1000_106946" 

	
this.LABEL_TARGET_EQUIPMENT_00 = "enqt1000_106949"
this.LABEL_TARGET_EQUIPMENT_01 ="enqt1000_106951"

	
this.LABEL_VIP_REACTION_00 = "enqt3000_1a1010"	
this.LABEL_VIP_REACTION_01 = "enqt3000_1b1010"	
this.LABEL_VIP_REACTION_02 = "enqt3000_1c1010"	
this.LABEL_VIP_REACTION_03 = "enqt3000_1d1010"	

	
this.LABEL_GUARD_REACTION_00 = "enqt1000_106954"	
this.LABEL_GUARD_REACTION_01 = "enqt1000_106957"	


	
this.LABEL_GUARD_MEDIC_00 = "enqt1000_106961" 
this.LABEL_GUARD_MEDIC_01 = "enqt1000_106963" 

	
this.LABEL_ROGUE_COYOTE_00 ="enqt1000_106966"
this.LABEL_ROGUE_COYOTE_01 ="enqt1000_106969"

	
this.LABEL_JACKAL ="enqt1000_107054"






this.ENEMY_NAME = {
	FOLLOWER01		= "sol_mis_0001",		
	TARGET			= "sol_mis_0000",		

	FOLLOWER02		= "sol_mis_0002",		
	FOLLOWER03		= "sol_mis_0003",		
	FOLLOWER04		= "sol_mis_0004",		
	FOLLOWER05		= "sol_mis_0005",		


}

this.BONUS_HOSTAGE_NAME	= {
	HOSTAGE_00	=	"hos_mis_0000",
	HOSTAGE_01	=	"hos_mis_0001",
	HOSTAGE_02	=	"hos_mis_0002",
	HOSTAGE_03	=	"hos_mis_0003",
}

this.HOSTAGE_LANG_TABLE	= {
	{ this.BONUS_HOSTAGE_NAME.HOSTAGE_00, "afrikaans", "hostage_a", },
	{ this.BONUS_HOSTAGE_NAME.HOSTAGE_01, "kikongo", "hostage_b", },
	{ this.BONUS_HOSTAGE_NAME.HOSTAGE_02, "kikongo", "hostage_b", },
	{ this.BONUS_HOSTAGE_NAME.HOSTAGE_03, "kikongo", "hostage_a", },
}


local MiSSION_TARGET_GROUP = {
	this.ENEMY_NAME.TARGET,
	this.ENEMY_NAME.FOLLOWER01,


}


local MiSSION_GUARD_GROUP = {
	this.ENEMY_NAME.FOLLOWER02,
	this.ENEMY_NAME.FOLLOWER03,
	this.ENEMY_NAME.FOLLOWER04,
	this.ENEMY_NAME.FOLLOWER05,
}




local VIP_GROUP_ALL ={
	this.ENEMY_NAME.TARGET,
	this.ENEMY_NAME.FOLLOWER01,
	this.ENEMY_NAME.FOLLOWER02,
	this.ENEMY_NAME.FOLLOWER03,
	this.ENEMY_NAME.FOLLOWER04,
	this.ENEMY_NAME.FOLLOWER05,
}


local VIP_TRAVEL_GROUP ={
	"lrrp_vip_to_swamp",
	"lrrp_guard1_to_swamp ",
	"lrrp_guard2_to_swamp ",
	"lrrp_guard3_to_swamp ",
	"lrrp_guard4_to_swamp ",
	"lrrp_guard5_to_swamp ",
}


local TARGET_SEQUENCE = Tpp.Enum{
	"SEQUENCE1",
	"SEQUENCE2",
	"SEQUENCE3",
	"SEQUENCE4",
}


local TARGET_SEQUENCE_ROUTE = {







	{
		"route_vip_seq1_0000",
		"route_vip_seq1_0000",
		"route_vip_seq1_0000",
	},
	{
		"route_vip_seq2_0000",
		"route_vip_seq2_0000",
		"route_vip_seq2_0000",
	},
	{
		"route_vip_seq3_0000",
		"route_vip_seq3_0000",
		"route_vip_seq3_0000",
	},
	{
		"route_vip_seq4_0001",
		"route_vip_seq4_0000",
		"route_vip_seq4_0002",
	},
}
local VIP_CAUTION_ROUTE0 = {
	"route_escape_caution0000",
	"route_escape_caution0000",
	"route_escape_caution0000",
	"route_escape_caution0000",
	"route_escape_caution0000",
	"route_escape_caution0000",
}

local VIP_CAUTION_ROUTE1 = {
	"route_escape_caution0001",
	"route_escape_caution0001",
	"route_escape_caution0001",
	"route_escape_caution0001",
	"route_escape_caution0001",
	"route_escape_caution0001",
}

local VIP_CAUTION_ROUTE2 ={
	"route_escape_caution0002",
	"route_escape_caution0002",
	"route_escape_caution0002",
	"route_escape_caution0002",
	"route_escape_caution0002",
	"route_escape_caution0002",
}

local VIP_CAUTION_ROUTE3 ={
	"route_escape_caution0003",
	"route_escape_caution0003",
	"route_escape_caution0003",
	"route_escape_caution0003",
	"route_escape_caution0003",
	"route_escape_caution0003",
}

local VIP_CAUTION_ROUTE4 ={
	"route_escape_caution0004",
	"route_escape_caution0004",
	"route_escape_caution0004",
	"route_escape_caution0004",
	"route_escape_caution0004",
	"route_escape_caution0004",
}
local VIP_CAUTION_ROUTE5 ={
	"route_escape_caution0005",
	"route_escape_caution0005",
	"route_escape_caution0005",
	"route_escape_caution0005",
	"route_escape_caution0005",
	"route_escape_caution0005",
}


local SWAMP_CAUTION_ROUTE = {
	"rt_swamp_c_0015",
	"rt_swamp_c_0002",
	"rt_swamp_c_0003",
	"rt_swamp_c_0000",
	"rt_swamp_c_0004_no_searchlight_sub",
	"rt_swamp_c_0001",
}


local GUARD_SEQUENCE_ROUTE = {






	{
		"route_vip_seq1_0002",
		"route_vip_seq1_0002",
		"route_vip_seq1_0002",
	},
	{
		"route_vip_seq2_0002",
		"route_vip_seq2_0002",
		"route_vip_seq2_0002",
	},
	{
		"route_vip_seq3_0002",
		"route_vip_seq3_0002",
		"route_vip_seq3_0002",
	},
	{
		"route_vip_seq4_0003",
		"route_vip_seq4_0004",
		"route_vip_seq4_0005",
	},
}
NODEMESSAGE_VIPROUTE_SEQ1 = "seq1_arrived"
NODEMESSAGE_VIPROUTE_SEQ3 = "seq3_arrived"






this.USE_COMMON_REINFORCE_PLAN = true





this.soldierDefine = {

	
	cp_swamp_vip = {
		this.ENEMY_NAME.FOLLOWER01,
		this.ENEMY_NAME.TARGET,	

		this.ENEMY_NAME.FOLLOWER02,
		this.ENEMY_NAME.FOLLOWER03,

		this.ENEMY_NAME.FOLLOWER04,
		this.ENEMY_NAME.FOLLOWER05,
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
		"sol_savannah_0012",
		"sol_savannah_0013",
		nil
	},
	mafr_swamp_cp = {
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


		nil
	},
	
	mafr_swampEast_ob = {
		"sol_swampEast_0000",
		"sol_swampEast_0001",
		"sol_swampEast_0002",
		"sol_swampEast_0003",

		"sol_swampEast_0004",	
		nil
	},
	mafr_swampSouth_ob	= {
		"sol_swampSouth_0000",
		"sol_swampSouth_0001",
		"sol_swampSouth_0002",


		"sol_swampSouth_0004",

		nil
	},
	mafr_pfCampNorth_ob  = {
		"sol_pfCampNorth_0000",
		"sol_pfCampNorth_0001",
		"sol_pfCampNorth_0002",
		"sol_pfCampNorth_0003",
		"sol_pfCampNorth_0004",
		nil
	},
	mafr_bananaSouth_ob	= {
		"sol_bananaSouth_0000",
		"sol_bananaSouth_0001",
		"sol_bananaSouth_0002",


		nil
	},
	mafr_savannahWest_ob	= {
		"sol_savannahWest_0000",
		"sol_savannahWest_0001",
		"sol_savannahWest_0002",
	
		nil
	},
	mafr_savannahEast_ob	= {
		"sol_savannahEast_0000",
		"sol_savannahEast_0001",
		"sol_savannahEast_0002",
		"sol_savannahEast_0003",

		"sol_savannahEast_0004",	

		nil
	},

	mafr_swampWest_ob = {
		nil
	},


	
	mafr_02_22_lrrp = {
		nil
	},

	mafr_04_07_lrrp = {
		"sol_lrrp_04_07_0000",
		"sol_lrrp_04_07_0001",
		"sol_lrrp_04_07_0002",
		"sol_lrrp_04_07_0003",
		lrrpVehicle = "Vehicle2Locator0002", 

		lrrpTravelPlan = "lrrp_bananaSouth_to_sanannahWest",
		nil
	},
	mafr_04_09_lrrp = {
		nil
	},

	mafr_05_16_lrrp = {
		nil
	},
	mafr_05_22_lrrp = {
		"sol_lrrp_05_22_0002",
		"sol_lrrp_05_22_0003",
		lrrpTravelPlan = "lrrp_swampSouth_to_sanannahEast2",
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
	mafr_07_24_lrrp = {
		nil
	},
	mafr_13_16_lrrp = {
		nil
	},
	mafr_13_24_lrrp = {
		"sol_lrrp_05_22_0000",
		"sol_lrrp_05_22_0001",
		lrrpTravelPlan = "lrrp_swampSouth_to_sanannahEast",

		nil
	},

	mafr_16_24_lrrp = {
		nil
	},



	nil
}



this.soldierSubTypes = {
		
		PF_C = {
				"sol_lrrp_04_07_0000",
				"sol_lrrp_04_07_0001",
				"sol_lrrp_04_07_0002",
				"sol_lrrp_04_07_0003",
		},
 }








this.routeSets = {

	
	cp_swamp_vip = {
		priority = {
			"groupA"
		},
		sneak_day = {
			groupA = {
				"route_swamp_vip",
				"route_swamp_vip",
				"route_swamp_guard1",
				"route_swamp_guard1",
				"route_swamp_guard2",
				"route_swamp_guard2",
				"route_swamp_vip",
				"route_swamp_vip",

			},
			nil
		},
		sneak_night = {
			groupA = {
				"route_swamp_vip",
				"route_swamp_vip",
				"route_swamp_guard1",
				"route_swamp_guard1",
				"route_swamp_guard2",
				"route_swamp_guard2",
				"route_swamp_vip",
				"route_swamp_vip",

			},
			nil
		},
		caution = {
			groupA = {
				"route_vip_caution0000",
				"route_vip_caution0000",
				"route_guard1_sneak0000",
				"route_guard1_sneak0001",
				"route_guard2_sneak0000",
				"route_guard2_sneak0001",

			
			
			
			},
			nil
		},

		travel = {
			lrrp_vip = {
				"route_vip_sneak0000",
				"route_vip_sneak0000",
				"route_vip_sneak0000",
				"route_vip_sneak0000",
				"route_vip_sneak0000",
			},

			lrrp_guard1 = {
				"route_guard1_sneak0000",
				"route_guard1_sneak0001",
				"route_guard1_sneak0000",
				"route_guard1_sneak0001",
				"route_guard1_sneak0000",
			},
			lrrp_guard2 = {
				"route_guard2_sneak0000",
				"route_guard2_sneak0001",
				"route_guard2_sneak0000",
				"route_guard2_sneak0001",
				"route_guard2_sneak0000",
			},

		},
		hold = {
		},
		nil
	},
	
	

	mafr_savannah_cp = { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_swamp_cp =  {
		USE_COMMON_ROUTE_SETS = true,

		travel = {
			swamp_vip = {
				"route_vip_seq4_0000",
			},
			swamp_guard1 = {
				"route_vip_seq4_0001",
			},
			swamp_guard2 = {
				"route_vip_seq4_0002",
			},
			swamp_guard3 = {
				"route_vip_seq4_0003",
			},
			swamp_guard4 = {
				"route_vip_seq4_0004",
			},
			swamp_guard5 = {
				"route_vip_seq4_0005",
			},
		},

	},


	
	
	mafr_swampEast_ob = { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_swampSouth_ob = { USE_COMMON_ROUTE_SETS = true,	},
	
	mafr_pfCampNorth_ob = { USE_COMMON_ROUTE_SETS = true,	},

	
	mafr_bananaSouth_ob = {
		USE_COMMON_ROUTE_SETS = true,
		travel = {
			lrrp_rest_bananaSouth = {
				"rt_lrrp_rest_0004",
				"rt_lrrp_rest_0005",
				"rt_lrrp_rest_0006",
				"rt_lrrp_rest_0007",
			},
		}

	},

	
	mafr_savannahWest_ob = {
		USE_COMMON_ROUTE_SETS = true,

		travel = {
			lrrp_rest_savannahWest = {
				"rt_lrrp_rest_0000",
				"rt_lrrp_rest_0001",
				"rt_lrrp_rest_0002",
				"rt_lrrp_rest_0003",
			},
			lrrp_turn_savannahWest = {
				"rail_07to04_0001",
				"rail_07to04_0001",
				"rail_07to04_0001",
				"rail_07to04_0001",
			},

		}
},

	
	mafr_savannahEast_ob = { USE_COMMON_ROUTE_SETS = true,	},

	
	mafr_swampWest_ob = { USE_COMMON_ROUTE_SETS = true,	},


	
	mafr_04_07_lrrp =  {
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
			lrrp_04to07 = {
				"rt_04to07_0000",
				"rt_04to07_0000",
				"rt_04to07_0000",
				"rt_04to07_0000",
			},


			lrrp_07to04 = {
				"rt_07to04_0000",
				"rt_07to04_0000",
				"rt_07to04_0000",
				"rt_07to04_0000",
			},
			rp_04to07 = {
				"rail_04to07_0000",
				"rail_04to07_0000",
				"rail_04to07_0000",
				"rail_04to07_0000",
			},

			rp_04to07_0001 = {
				"rail_04to07_0001",
				"rail_04to07_0001",
				"rail_04to07_0001",
				"rail_04to07_0001",
			},

			rp_04to07_0002 = {
				"rail_04to07_0002",
				"rail_04to07_0002",
				"rail_04to07_0002",
				"rail_04to07_0002",
			},
			rp_07to04 = {
				"rail_07to04_0000",
				"rail_07to04_0000",
				"rail_07to04_0000",
				"rail_07to04_0000",
			},
		},
		nil
	},

	mafr_02_22_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_04_09_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_05_16_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_05_22_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_06_16_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_06_22_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_06_24_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_07_24_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_13_16_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_13_24_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	mafr_16_24_lrrp =  { USE_COMMON_ROUTE_SETS = true,	},
	nil
}

this.shiftChangeTable = {
	
	cp_swamp_vip = {
	},
	
	mafr_savannah_cp = {
	},
	mafr_swamp_cp = {

	},

	
	mafr_swampEast_ob = {
	},
	mafr_swampSouth_ob	= {
	},
	mafr_pfCampNorth_ob  = {
	},
	nil
}


this.useGeneInter = {
	mafr_savannah_cp = true,	
	mafr_swamp_cp = true,

	mafr_swampEast_ob = true,
	mafr_swampSouth_ob = true,

	mafr_pfCampNorth_ob = true,

	mafr_bananaSouth_ob = true,

	mafr_savannahWest_ob = true,
	mafr_savannahEast_ob = true,


	nil
}






this.lrrpHoldTime = 15

this.travelPlans = {

	lrrp_swampSouth_to_sanannahEast = {
		{ base = "mafr_pfCampNorth_ob",		},
		{ base = "mafr_swampEast_ob",		},
		{ base = "mafr_swamp_cp",			},
		{ base = "mafr_swampSouth_ob",		},
		{ base = "mafr_swamp_cp",	},
		{ base = "mafr_swampEast_ob",	},
		{ base = "mafr_savannah_cp",	},
		{ base = "mafr_savannahEast_ob",	},

	},

	lrrp_swampSouth_to_sanannahEast2 = {
		{ base = "mafr_swampSouth_ob",		},
		{ base = "mafr_swamp_cp",	},
		{ base = "mafr_swampEast_ob",	},
		{ base = "mafr_savannah_cp",	},
		{ base = "mafr_savannahEast_ob",	},
		{ base = "mafr_pfCampNorth_ob",		},
		{ base = "mafr_swampEast_ob",		},
		{ base = "mafr_swamp_cp",			},
	},

	lrrp_bananaSouth_to_sanannahWest = {

		 { cp = "mafr_04_07_lrrp", routeGroup={ "travel", "rp_04to07" } }, 
		 { cp = "mafr_04_07_lrrp", routeGroup={ "travel", "rp_04to07_0001" } }, 
		 { cp = "mafr_04_07_lrrp", routeGroup={ "travel", "rp_04to07_0002" } }, 


		 { cp = "mafr_savannahWest_ob", routeGroup={ "travel", "lrrp_rest_savannahWest" } }, 
		 { cp = "mafr_savannahWest_ob", routeGroup={ "travel", "lrrp_turn_savannahWest" } }, 

		 { cp = "mafr_04_07_lrrp", routeGroup={ "travel", "rp_07to04" } }, 
		 { cp = "mafr_bananaSouth_ob", routeGroup={ "travel", "lrrp_rest_bananaSouth" } }, 

	},

	
	lrrp_vip_to_swamp = {
		ONE_WAY = true,
		{ cp = "cp_swamp_vip", routeGroup={ "travel", "lrrp_vip" } }, 
		{ cp = "mafr_swamp_cp", routeGroup={ "travel", "swamp_vip" } }, 
	},

	lrrp_guard1_to_swamp = {
		ONE_WAY = true,
		{ cp = "cp_swamp_vip", routeGroup={ "travel", "lrrp_vip" } }, 
		{ cp = "mafr_swamp_cp", routeGroup={ "travel", "swamp_guard1" } }, 
	},

	lrrp_guard2_to_swamp = {
		ONE_WAY = true,
		{ cp = "cp_swamp_vip", routeGroup={ "travel", "lrrp_guard1" } }, 
		{ cp = "mafr_swamp_cp", routeGroup={ "travel", "swamp_guard2" } }, 
	},

	lrrp_guard3_to_swamp = {
		ONE_WAY = true,
		{ cp = "cp_swamp_vip", routeGroup={ "travel", "lrrp_guard1" } }, 
		{ cp = "mafr_swamp_cp", routeGroup={ "travel", "swamp_guard3" } }, 
	},
	lrrp_guard4_to_swamp = {
		ONE_WAY = true,
		{ cp = "cp_swamp_vip", routeGroup={ "travel", "lrrp_guard2" } }, 
		{ cp = "mafr_swamp_cp", routeGroup={ "travel", "swamp_guard4" } }, 
	},

	lrrp_guard5_to_swamp = {
		ONE_WAY = true,
		{ cp = "cp_swamp_vip", routeGroup={ "travel", "lrrp_guard2" } }, 
		{ cp = "mafr_swamp_cp", routeGroup={ "travel", "swamp_guard5" } }, 
	},






}




local spawnList = {
	{ id="Spawn", locator="Vehicle2Locator0002", type=Vehicle.type.WESTERN_LIGHT_VEHICLE, paintType=Vehicle.paintType.FOVA_0 },

}




this.SetWolfRouteDayTime = function()
	Fox.Log( "*****s10211_enemy.SetWolfRouteDayTime***")
	this.SetUpWolf( JACKAL_GROUP01, "rt_swamp_wolf_d_01" )
	this.SetUpWolf( JACKAL_GROUP02, "rt_swamp_wolf_d_02" )
	this.SetUpWolf( JACKAL_GROUP03, "rt_swamp_wolf_d_03" )
	this.SetUpWolf( JACKAL_GROUP04, "rt_swamp_wolf_d_04" )
	this.SetUpWolf( JACKAL_GROUP05, "rt_swamp_wolf_d_05" )
	this.SetUpWolf( JACKAL_GROUP06, "rt_swamp_wolf_d_06" )



end


this.SetWolfRouteNightTime = function()
	Fox.Log( "*****s10211_enemy.SetWolfRouteNightTime***")
	this.SetUpWolf( JACKAL_GROUP01, "rt_swamp_wolf_n_01" )
	this.SetUpWolf( JACKAL_GROUP02, "rt_swamp_wolf_n_02" )
	this.SetUpWolf( JACKAL_GROUP03, "rt_swamp_wolf_n_03" )
	this.SetUpWolf( JACKAL_GROUP04, "rt_swamp_wolf_n_04" )
	this.SetUpWolf( JACKAL_GROUP05, "rt_swamp_wolf_n_05" )
	this.SetUpWolf( JACKAL_GROUP06, "rt_swamp_wolf_n_06" )


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
end


this.SetUpWolf = function ( locatorName, routeName )

	local gameObjectId = {type="TppWolf", group=0, index=0}
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

































this.UniqueInterStart_target = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_target" .. svars.vipTalkCount)
	if svars.vipTalkCount == 0 then
		Fox.Log("###UniqueInter vip1")
		TppInterrogation.UniqueInterrogation( cpID, this.LABEL_VIP_REACTION_00) 
	elseif svars.vipTalkCount == 1 then
		Fox.Log("###UniqueInter vip2")
		TppInterrogation.UniqueInterrogation( cpID, this.LABEL_VIP_REACTION_01) 
	elseif svars.vipTalkCount == 2 then
		Fox.Log("###UniqueInter vip3")
		TppInterrogation.UniqueInterrogation( cpID, this.LABEL_VIP_REACTION_02) 
	elseif svars.vipTalkCount == 3 then
		Fox.Log("###UniqueInter vip4")
		TppInterrogation.UniqueInterrogation( cpID, this.LABEL_VIP_REACTION_03) 
	else
		return false
	end
	svars.vipTalkCount = svars.vipTalkCount+1
	if 	svars.vipTalkCount >3	then
		svars.vipTalkCount =2
	end
	return true
end


this.UniqueInterend_target = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterend_target1")

end


this.UniqueInterStart_medic = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterStart_medic" .. svars.medicTalkCount)
	if svars.medicTalkCount == 0 then
		Fox.Log("###UniqueInter medic1")
		TppInterrogation.UniqueInterrogation( cpID, this.LABEL_GUARD_MEDIC_00 ) 
	elseif svars.medicTalkCount == 1 then
		Fox.Log("###UniqueInter medic2")
		TppInterrogation.UniqueInterrogation( cpID, this.LABEL_GUARD_MEDIC_01 ) 
	else
		return false
	end
	svars.medicTalkCount = svars.medicTalkCount + 1
	if 	svars.medicTalkCount >1	then
		svars.medicTalkCount =1
	end
	return true
end

this.UniqueInterend_medic = function( soldier2GameObjectId, cpID )
	Fox.Log("###CallBack : UniqueInterend_medic")

end


this.uniqueInterrogation = {
	
	unique = {
		{ name =this.LABEL_VIP_REACTION_00,	func = this.UniqueInterend_target,},			
		{ name =this.LABEL_VIP_REACTION_01,	func = this.UniqueInterend_target,},			
		{ name =this.LABEL_VIP_REACTION_02,	func = this.UniqueInterend_target,},			
		{ name =this.LABEL_VIP_REACTION_03 ,	func = this.UniqueInterend_target,},			

		{ name =this.LABEL_GUARD_MEDIC_00 ,		func = this.UniqueInterend_medic,},			
		{ name =this.LABEL_GUARD_MEDIC_01 ,		func = this.UniqueInterend_medic,},			
	},

	
	uniqueChara = {
		{ name = this.ENEMY_NAME.TARGET,			func = this.UniqueInterStart_target,},		
		{ name = this.ENEMY_NAME.FOLLOWER03,			func = this.UniqueInterStart_medic,},		

	},
}




this.InterCall_Hostage = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_Hostage")
	TppMission.UpdateObjective{
		objectives = { "hos_subTarget_0000", "hos_subTarget_0001","hos_subTarget_0002", "hos_subTarget_0003", nil  },
	}
	local sequence = TppSequence.GetCurrentSequenceName()
	if ( sequence == "Seq_Game_Escape" ) then
	else
		TppRadio.Play( "f1000_esrg0760",{delayTime = "long"}  )	
	end
	s10211_sequence.DeleteHighInterrogationHostage()


	return true
end
this.InterCall_TargetGoal = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_TargetGoal")

	
	if svars.isReserve_13 == false then	
		svars.isReserve_13 = true	
		s10211_sequence.DeleteHighInterrogationTargetGoal()	

		TppRadio.Play( "s0211_rtrg1040",{delayTime = "long"}  )	
		
		TppMission.UpdateObjective{
			objectives = { "add_TargetHint",},
		}
	end

	return true
end
this.InterCall_Inter = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_Inter")

	TppMission.UpdateObjective{
		objectives = { "Interrogation_InfoTape", "search_Item_InfoTape",nil  },
	}
	return true
end

this.InterCall_VipEquip1 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_VipEquip")

	return true
end
this.InterCall_VipEquip2 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_VipEquip")
	return true
end
	
this.InterCall_SearchUnit1 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_SearchUnit")

	return true
end

this.InterCall_SearchUnit2 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_SearchUnit2")

	return true
end
this.InterCall_VipSwamp = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_VipSwamp")

	return true
end
	
this.InterCall_WildAnimal = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_WildAnimal")

	svars.isHearJackal	=true	
	s10211_sequence.DeleteHighInterrogationAboutAnimal()	

	TppMission.UpdateObjective{
		objectives = {
			"marker_jackal_00",
			"marker_jackal_01",
			"marker_jackal_02",
			"marker_jackal_03",
			"marker_jackal_04",
			"marker_jackal_05",
			nil  },
	}
	TppRadio.Play( "s0211_rtrg1030")

	return true
end

this.InterCall_GuardReaction_00 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_GuardReaction_00")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_GUARD_REACTION_00 ) 
	return true
end

this.InterCall_GuardReaction_01 = function( soldier2GameObjectId, cpID, interName )
	Fox.Log("CallBack : InterCall_GuardReaction_01")
	TppInterrogation.UniqueInterrogation( cpID, this.LABEL_GUARD_REACTION_01 ) 
	return true
end


this.interrogation = {

	cp_swamp_vip = {
		
		high = {

			{ name = this.LABEL_GUARD_REACTION_00,	func = this.InterCall_GuardReaction_00, },		
			{ name = this.LABEL_GUARD_REACTION_01,	func = this.InterCall_GuardReaction_01, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



	mafr_savannah_cp ={
		
		high = {
			{ name = this.LABEL_INTEL ,		func = this.InterCall_Inter, },		
			{ name = this.LABEL_HOSTAGE,		func = this.InterCall_Hostage, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_swamp_cp ={
		
		high = {
			{ name = this.LABEL_TARGET_POSITION ,	this = this.InterCall_VipSwamp },		
			{ name = this.LABEL_TARGET_AREA, func = this.InterCall_TargetGoal, },	
			{ name = this.LABEL_HOSTAGE,	func = this.InterCall_Hostage, },		
		},
		
		normal = {
			
			nil
		},
		nil
	},



	mafr_swampEast_ob ={
		
		high = {
			{ name = this.LABEL_TARGET_AREA, func = this.InterCall_TargetGoal, },	
			{ name = this.LABEL_TARGET_EQUIPMENT_00,		func = this.InterCall_VipEquip1, },		
			{ name = this.LABEL_TARGET_EQUIPMENT_01,		func = this.InterCall_VipEquip2, },		
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_swampSouth_ob ={
		
		high = {
			{ name = this.LABEL_TARGET_AREA, func = this.InterCall_TargetGoal, },	
			{ name = this.LABEL_TARGET_EQUIPMENT_00,		func = this.InterCall_VipEquip1, },		
			{ name = this.LABEL_TARGET_EQUIPMENT_01,		func = this.InterCall_VipEquip2, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_pfCampNorth_ob ={
		
		high = {
			{ name = this.LABEL_TARGET_AREA, func = this.InterCall_TargetGoal, },	
			{ name = this.LABEL_TARGET_EQUIPMENT_00,		func = this.InterCall_VipEquip1, },		
			{ name = this.LABEL_TARGET_EQUIPMENT_01,		func = this.InterCall_VipEquip2, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_savannahEast_ob ={
		
		high = {
			{ name = this.LABEL_TARGET_AREA, func = this.InterCall_TargetGoal, },	
			{ name = this.LABEL_TARGET_EQUIPMENT_00,		func = this.InterCall_VipEquip1, },		
			{ name = this.LABEL_TARGET_EQUIPMENT_01,		func = this.InterCall_VipEquip2, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},


	mafr_bananaSouth_ob ={
		
		high = {
			{ name = this.LABEL_ROGUE_COYOTE_00,	func = this.InterCall_SearchUnit1, },		
			{ name = this.LABEL_ROGUE_COYOTE_01,	func = this.InterCall_SearchUnit2, },		
			{ name = this.LABEL_JACKAL,		func = this.InterCall_WildAnimal },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},



	mafr_savannahWest_ob ={
		
		high = {
			{ name = this.LABEL_ROGUE_COYOTE_00,	func = this.InterCall_SearchUnit1, },		
			{ name = this.LABEL_ROGUE_COYOTE_01,	func = this.InterCall_SearchUnit2, },		
			{ name = this.LABEL_JACKAL,		func = this.InterCall_WildAnimal },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
	mafr_04_07_lrrp = {
		
		high = {
			{ name = this.LABEL_JACKAL,		func = this.InterCall_WildAnimal },		
			{ name = this.LABEL_ROGUE_COYOTE_00,	func = this.InterCall_SearchUnit1, },		
			{ name = this.LABEL_ROGUE_COYOTE_01,	func = this.InterCall_SearchUnit2, },		
			nil
		},
		
		normal = {
			
			nil
		},
		nil
	},
}


















this.combatSetting = {
	mafr_savannah_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swamp_cp = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swampEast_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_swampSouth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_pfCampNorth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_bananaSouth_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_savannahWest_ob = {
		USE_COMMON_COMBAT = true,
	},
	mafr_savannahEast_ob = {
		USE_COMMON_COMBAT = true,
	},

	nil
}

this.soldierPowerSettings = {
	
	sol_savannah_0000 = { "SNIPER", },
	
	sol_savannah_0009 = { "SNIPER", },

	
	sol_mis_0000 = { "SOFT_ARMOR","SNIPER", },

	
	sol_mis_0001 = { "SOFT_ARMOR", "HELMET","SHOTGUN", },
	sol_mis_0002 = { "SOFT_ARMOR", "GAS_MASK","MG", },

	sol_mis_0003 = { "SOFT_ARMOR", "GAS_MASK","MISSILE", },
	sol_mis_0004 = { "SOFT_ARMOR", "GAS_MASK","MISSILE" },
	sol_mis_0005 = { "SOFT_ARMOR", "SNIPER","NVG", },

	sol_lrrp_04_07_0000 = { "NVG", },
	sol_lrrp_04_07_0001 = { "NVG", "MG",},
	sol_lrrp_04_07_0002 = { "NVG", "SNIPER",},
	sol_lrrp_04_07_0003 = { "NVG", "SNIPER" },

}





this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	TppEnemy.RegisterCombatSetting( this.combatSetting )





	
	this.SetMarchCp()
	this.SetUpRegisterMessage()	
	
	this.SetWolfRouteBasedOnTime()
	
	local gameObjectId = { type="TppCommandPost2" } 

	local combatAreaList = {
		area1 = {
			{ guardTargetName="gt_swamp_0000", locatorSetName="cs_swamp_0000",}, 
		},
		area2 = {
			{ guardTargetName="gt_swamp_0001", locatorSetName="cs_swamp_0001",},
		},
	}
	local command = { id = "SetCombatArea", cpName = "mafr_swamp_cp", combatAreaList = combatAreaList }
	GameObject.SendCommand( gameObjectId, command )

	
	TppEnemy.SetEliminateTargets( { this.ENEMY_NAME.TARGET } )

	
	local targetList = {
		this.ENEMY_NAME.FOLLOWER01,
		this.ENEMY_NAME.FOLLOWER02,
		this.ENEMY_NAME.FOLLOWER03,
		this.ENEMY_NAME.FOLLOWER04,
		this.ENEMY_NAME.FOLLOWER05,
		this.BONUS_HOSTAGE_NAME.HOSTAGE_00,
		this.BONUS_HOSTAGE_NAME.HOSTAGE_01,
		this.BONUS_HOSTAGE_NAME.HOSTAGE_02,
		this.BONUS_HOSTAGE_NAME.HOSTAGE_03,
	}
	this.RegistHoldRecoveredStateForMissionTask( targetList )


	this.SetNpcStaffParameter( this.ENEMY_NAME.TARGET, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_TRAFFICKER ,{ staffTypeId =56, randomRangeId =4, skill ="TroublemakerHarassment" })	
	this.SetNpcStaffParameter( this.ENEMY_NAME.FOLLOWER01, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_BODYGUARD_01 ,{ staffTypeId =2, randomRangeId =6, skill ="Grappler" })	
	this.SetNpcStaffParameter( this.ENEMY_NAME.FOLLOWER02, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_BODYGUARD_04 ,{ staffTypeId =60, randomRangeId =4, skill =nil })	
	this.SetNpcStaffParameter( this.ENEMY_NAME.FOLLOWER03, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_BODYGUARD_02 ,{ staffTypeId =52, randomRangeId =4, skill =nil })	
	this.SetNpcStaffParameter( this.ENEMY_NAME.FOLLOWER04, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_BODYGUARD_03 ,{ staffTypeId =51, randomRangeId =4, skill =nil })	
	this.SetNpcStaffParameter( this.ENEMY_NAME.FOLLOWER05, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_BODYGUARD_05 ,{ staffTypeId =57, randomRangeId =4, skill =nil })	

	this.SetNpcStaffParameter(this.BONUS_HOSTAGE_NAME.HOSTAGE_00, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_HOSTAGE_A ,{ staffTypeId =3, randomRangeId =6, skill ="MonitorEngineer" })	
	this.SetNpcStaffParameter(this.BONUS_HOSTAGE_NAME.HOSTAGE_01, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_HOSTAGE_B ,{ staffTypeId =62, randomRangeId =4, skill ="Surgeon" })	
	this.SetNpcStaffParameter(this.BONUS_HOSTAGE_NAME.HOSTAGE_02, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_HOSTAGE_C ,{ staffTypeId =50, randomRangeId =4, skill =nil })	
	this.SetNpcStaffParameter(this.BONUS_HOSTAGE_NAME.HOSTAGE_03, TppDefine.UNIQUE_STAFF_TYPE_ID.S10211_HOSTAGE_D ,{ staffTypeId =53, randomRangeId =4, skill =nil })	


	
	for k, langSet in pairs(this.HOSTAGE_LANG_TABLE) do

		local gameObjectId = GameObject.GetGameObjectId( langSet[1] )
		local lang = langSet[2]
		local voice = langSet[3]

		GameObject.SendCommand( gameObjectId, { id = "SetLangType", langType=lang } )
		GameObject.SendCommand( gameObjectId, { id = "SetVoiceType", voiceType=voice } )

	end


end


this.OnLoad = function ()
	Fox.Log("*** s10211 onload ***")
end







this.RegistHoldRecoveredStateForMissionTask = function( targetList )
	Fox.Log("###*** MissionTask register beginning ***")
	for index, targetName in pairs(targetList) do
		TppEnemy.RegistHoldRecoveredState( targetName )
	end
end







this.SetRelativeVehicle = function(soldierName, vehicleName)
	Fox.Log("#### s10070_enemy02.SetRelativeVehicle #### soldierName = " ..tostring(soldierName).. ", vehicleName = " ..tostring(vehicleName))

	local soldierId = GameObject.GetGameObjectId( "TppSoldier2", soldierName )
	local vehicleId = GameObject.GetGameObjectId( "TppVehicle2", vehicleName )

	local command = { id = "SetRelativeVehicle", targetId = vehicleId, rideFromBegining = true	}
	GameObject.SendCommand( soldierId, command )

end
this.vehicleDefine = {
		instanceCount	= #spawnList + SUPER_REINFORCE_VHEHICLE_RESERVE,
}
this.SpawnVehicleOnInitialize = function()
		TppEnemy.SpawnVehicles( spawnList )
end

this.StartVipTravel = function()
	Fox.Log("!!!! s10211_enemy.StartVipTravel !!!!")
	TppUiCommand.SetMisionInfoCurrentStoryNo(0)	



















	local command = { id = "StartTravel", travelPlan =	"lrrp_vip_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.TARGET)
	GameObject.SendCommand( gameObjectId, command )
	local command = { id = "StartTravel", travelPlan =	"lrrp_guard1_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.FOLLOWER01)
	GameObject.SendCommand( gameObjectId, command )
	local command = { id = "StartTravel", travelPlan =	"lrrp_guard2_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.FOLLOWER02)
	GameObject.SendCommand( gameObjectId, command )
	local command = { id = "StartTravel", travelPlan =	"lrrp_guard3_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.FOLLOWER03)
	GameObject.SendCommand( gameObjectId, command )
	local command = { id = "StartTravel", travelPlan =	"lrrp_guard4_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.FOLLOWER04)
	GameObject.SendCommand( gameObjectId, command )
	local command = { id = "StartTravel", travelPlan =	"lrrp_guard5_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.FOLLOWER05)
	GameObject.SendCommand( gameObjectId, command )


end


this.ReStartVipTravel= function()	
	Fox.Log("!!!! s10211_enemy.ReStartVipTravel !!!!")
	svars.isReserve_03 = false	

	local command = { id = "StartTravel", travelPlan =	"lrrp_vip_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.TARGET)
	GameObject.SendCommand( gameObjectId, command )
	local command = { id = "StartTravel", travelPlan =	"lrrp_guard1_to_swamp", }
	local gameObjectId = GameObject.GetGameObjectId(this.ENEMY_NAME.FOLLOWER01)
	GameObject.SendCommand( gameObjectId, command )
end

function this.SetVipGroupSwampCautionRoute()
	for index, enemyName in pairs(VIP_GROUP_ALL) do

		TppEnemy.SetCautionRoute( enemyName, SWAMP_CAUTION_ROUTE[index] )
	end
end

this.SetVipEscapeRoute= function()	
	local phase=svars.ldReserve_02
	Fox.Log("!!!! s10211_enemy.SetVipEscapeRoute !!!!" .. phase)

	if svars.isReserve_03 == false then	
		Fox.Log("!!!! Vip Escape !!!!" .. phase)

		svars.isReserve_03 = true	
		this.TransferCp( MiSSION_TARGET_GROUP,"")

		for index, enemyName in pairs(MiSSION_TARGET_GROUP) do

			if phase == ESCAPE_POINT_00 then
				TppEnemy.SetCautionRoute( enemyName, VIP_CAUTION_ROUTE0[index] )
				TppEnemy.SetSneakRoute( enemyName, VIP_CAUTION_ROUTE0[index] )
			elseif phase == ESCAPE_POINT_01 then
				TppEnemy.SetCautionRoute( enemyName, VIP_CAUTION_ROUTE1[index] )
				TppEnemy.SetSneakRoute( enemyName, VIP_CAUTION_ROUTE1[index] )
			elseif phase == ESCAPE_POINT_02 then
				TppEnemy.SetCautionRoute( enemyName, VIP_CAUTION_ROUTE2[index] )
				TppEnemy.SetSneakRoute( enemyName, VIP_CAUTION_ROUTE2[index] )
			elseif phase == ESCAPE_POINT_03 then
				TppEnemy.SetCautionRoute( enemyName, VIP_CAUTION_ROUTE3[index] )
				TppEnemy.SetSneakRoute( enemyName, VIP_CAUTION_ROUTE3[index] )
			elseif phase == ESCAPE_POINT_04 then
				TppEnemy.SetCautionRoute( enemyName, VIP_CAUTION_ROUTE4[index] )
				TppEnemy.SetSneakRoute( enemyName, VIP_CAUTION_ROUTE4[index] )
			elseif phase == ESCAPE_POINT_05 then
				TppEnemy.SetCautionRoute( enemyName, VIP_CAUTION_ROUTE5[index] )
				TppEnemy.SetSneakRoute( enemyName, VIP_CAUTION_ROUTE5[index] )

			end

			if	TppEnemy.IsEliminated(this.ENEMY_NAME.TARGET) == false then
				if	TppEnemy.GetLifeStatus(this.ENEMY_NAME.TARGET) == TppEnemy.LIFE_STATUS.NORMAL
						and TppEnemy.GetStatus(this.ENEMY_NAME.TARGET) == EnemyState.NORMAL then

					s10211_radio.VipCpCaution()	
				end
			end
		end
	end
end




local function SetVipRoute( sequence )
	for index, enemyName in pairs(MiSSION_TARGET_GROUP) do
		TppEnemy.SetSneakRoute( enemyName, TARGET_SEQUENCE_ROUTE[sequence][index] )
	end

	for index, enemyName in pairs(MiSSION_GUARD_GROUP) do
		TppEnemy.SetSneakRoute( enemyName, GUARD_SEQUENCE_ROUTE[sequence][index] )
	end
end



this.SetUpRegisterMessage = function()
	local CHECK_PHASE_MEMBER =	{
		"sol_mis_0001",		
		"sol_mis_0000",		
		"sol_mis_0002",		

		"sol_mis_0003",		
		"sol_mis_0004",		
		"sol_mis_0005",		
	}
	local command = { id = "RegisterMessage", message="ChangePhase", isRegistered=true }

	for i , enemyName in pairs(CHECK_PHASE_MEMBER) do
		local gameObjectId = GameObject.GetGameObjectId( enemyName )
		GameObject.SendCommand( gameObjectId, command )
	end
end





this.SetEnemyFlag_MovePriority = function( enemyName, guardTargetData )
	Fox.Log("!!!! s10211_enemy.SetEnemyFlag_MovePriority !!!!")

	local SendCommand = GameObject.SendCommand

	local gameObjectIdEnemy = GameObject.GetGameObjectId("TppSoldier2", enemyName)
	local gameObjectIdCp = {type="TppCommandPost2", group=0, index=0}

	if gameObjectIdEnemy ~= nil and guardTargetData ~= nil then

		
		local command = {
			id="SetSoldier2Flag",
			flag = "inLocator",
			on = true,
		}
		SendCommand(gameObjectIdEnemy, command)

		
		local command = {
			id="AssignMemberRoleInLocator",
			locatorName=guardTargetData,
			soldier2GameObjectId=gameObjectIdEnemy,
		}
		SendCommand(gameObjectIdCp, command)
	end

end


this.UnSetEnemyFlag_MovePriority = function( enemyName, guardTargetData )
	Fox.Log("!!!! s10211_enemy.UnSetEnemyFlag_MovePriority !!!!")

	local SendCommand = GameObject.SendCommand

	local gameObjectIdEnemy = GameObject.GetGameObjectId("TppSoldier2", enemyName)
	local gameObjectIdCp = {type="TppCommandPost2", group=0, index=0}

	if gameObjectIdEnemy ~= nil and guardTargetData ~= nil then

		
		local command = {
			id="SetSoldier2Flag",
			flag = "inLocator",
			on = false,
		}
		SendCommand(gameObjectIdEnemy, command)

		
		local command = {
			id="ClearMemberRole",
			soldier2GameObjectId=gameObjectIdEnemy,
		}
		SendCommand(gameObjectIdCp, command)
	end

end



this.CheckVipRouteArrived = function( gameObjectId, routeId, param, messageId )
	Fox.Log("!!!! s10211_enemy.CheckVipRouteArrived !!!!"..messageId)


		if messageId == StrCode32(NODEMESSAGE_VIPROUTE_SEQ1) then
			SetVipRoute( TARGET_SEQUENCE.SEQUENCE2 )
		elseif messageId == StrCode32(NODEMESSAGE_VIPROUTE_SEQ3) then
			SetVipRoute( TARGET_SEQUENCE.SEQUENCE4 )
			
			svars.isTargetArrivedSwamp = true
		end

end


this.UpdateVipRoute_Seq1 = function()
	SetVipRoute( TARGET_SEQUENCE.SEQUENCE1 )
end
this.UpdateVipRoute_Seq2 = function()
	SetVipRoute( TARGET_SEQUENCE.SEQUENCE2 )
end
this.UpdateVipRoute_Seq3 = function()
	SetVipRoute( TARGET_SEQUENCE.SEQUENCE3 )
end
this.UpdateVipRoute_Seq4 = function()
	SetVipRoute( TARGET_SEQUENCE.SEQUENCE4 )
end


this.setUpFovaEnemy = function()
	 
	do
		
		local fovas = {
			{ name=this.ENEMY_NAME.TARGET, 	faceId=620, bodyId=253 },
		}

		
		for i,fova in ipairs(fovas) do
			local gameObjectId = GameObject.GetGameObjectId( fova.name )
			local command = { id = "ChangeFova", faceId = fova.faceId, bodyId = fova.bodyId }
			if gameObjectId ~= GameObject.NULL_ID then
				GameObject.SendCommand( gameObjectId, command )
			else
				Fox.Error( "Fova setting is failed. because " .. fova.name .. " is not found." )
			end
		end
	end
end


this.SetNpcStaffParameter = function( soldierName, uniqueTypeId ,alreadyExistParam)
	local GetGameObjectId = GameObject.GetGameObjectId
	local SendCommand = GameObject.SendCommand
	local gameObjId = GetGameObjectId(soldierName)

	
	TppEnemy.AssignUniqueStaffType{	locaterName = soldierName,	uniqueStaffTypeId = uniqueTypeId,	alreadyExistParam = alreadyExistParam}

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

this.TransferCpMembers = function(travelMember,planName)
	Fox.Log("#### s10211_enemy.TransferCpMembers ####")

	
	
	if not Tpp.IsTypeTable( travelMember ) then
		travelMember = { travelMember }
	end

	if travelMember and next(travelMember) then
		for index,enemyName in pairs(travelMember) do
		local command = { id = "StartTravel", travelPlan =	planName[index] }
		Fox.Log("#### start travel ####" .. enemyName)
		Fox.Log("#### plan name ####" .. planName[index] )

		local gameObjectId = GameObject.GetGameObjectId(enemyName)
			GameObject.SendCommand( gameObjectId, command )
		end
	end
end


this.CallMonologueHostageHos1= function()
	this.CallMonologueHostageMain(this.BONUS_HOSTAGE_NAME.HOSTAGE_00)
end
this.CallMonologueHostageHos2= function()
	this.CallMonologueHostageMain(this.BONUS_HOSTAGE_NAME.HOSTAGE_01)
end
this.CallMonologueHostageHos3= function()
	this.CallMonologueHostageMain(this.BONUS_HOSTAGE_NAME.HOSTAGE_02)
end
this.CallMonologueHostageHos4= function()
	this.CallMonologueHostageMain(this.BONUS_HOSTAGE_NAME.HOSTAGE_03)
end
this.CallMonologueHostageMain = function(locatorName)
		Fox.Log("#### CallMonologueHostageMain ####" .. locatorName)

	local lavel

	if svars.HostageTalkCount == CARRY_TALK_00 then
		lavel ="speech211_carry010"
	elseif svars.HostageTalkCount == CARRY_TALK_01 then
		lavel ="speech211_carry011"
	elseif svars.HostageTalkCount == CARRY_TALK_02 then
		lavel ="speech211_carry012"
	elseif svars.HostageTalkCount == CARRY_TALK_03 then
		lavel ="speech211_carry013"
	elseif svars.HostageTalkCount == CARRY_TALK_04 then
		lavel ="speech211_carry014"
	elseif svars.HostageTalkCount == CARRY_TALK_05 then
		lavel ="speech211_carry015"
	elseif svars.HostageTalkCount == CARRY_TALK_06 then
		lavel ="speech211_carry016"
	elseif svars.HostageTalkCount == CARRY_TALK_07 then
		lavel ="speech211_carry017"
	elseif svars.HostageTalkCount == CARRY_TALK_08 then
		lavel ="speech211_carry018"
	elseif svars.HostageTalkCount == CARRY_TALK_09 then
		lavel ="speech211_carry019"
	elseif svars.HostageTalkCount == CARRY_TALK_10 then
		lavel ="speech211_carry020"
	elseif svars.HostageTalkCount == CARRY_TALK_11 then
		lavel ="speech211_carry021"
	else
		lavel ="speech211_carry022"
	end

	this.CallMonologueHostage(locatorName,lavel)


end


this.CallMonologueHostage = function( locatorName, labelName )
		Fox.Log("#### CallMonologueHostage ####" .. locatorName)


	local gameObjectType = "TppHostage2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id="CallMonologue",
		label = labelName,
		carry = true,
	}
	GameObject.SendCommand( gameObjectId, command )

end





this.SetMarchCp = function()
	local gameObjectId = GameObject.GetGameObjectId( "cp_swamp_vip" )
	local command = { id = "SetMarchCp" }
	GameObject.SendCommand( gameObjectId, command )
end




return this
