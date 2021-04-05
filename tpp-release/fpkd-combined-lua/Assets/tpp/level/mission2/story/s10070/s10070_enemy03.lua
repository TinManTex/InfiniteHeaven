local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local targetRV = "lzs_sovietBase_S_0000"

this.requires = {}







local TARGET_HUEY = "TppHuey2GameObjectLocator"
local SAHELAN_WEAKENING_COUNT = 2	
local SAHELAN_LIFE_ESCAPE_SEQ = 25000		
local SAHELAN_STOP_LIFE_ESCAPE_SEQ = 1500		
local SAHELAN_LIFE_HELI_SEQ = 1300		
local SAHELAN_LIFE_FINAL_SEQ = 1000	

this.sahelanLifeTable = {
	Body 	=	SAHELAN_LIFE_ESCAPE_SEQ/3,	
	Bp 		=	SAHELAN_LIFE_ESCAPE_SEQ/6,	

	Head 	=	200000,				
	ArmR 	=	SAHELAN_LIFE_ESCAPE_SEQ/6,	
	ArmL 	=	SAHELAN_LIFE_ESCAPE_SEQ/6,	
	ThighR 	=	SAHELAN_LIFE_ESCAPE_SEQ/6,	
	ThighL 	=	SAHELAN_LIFE_ESCAPE_SEQ/6,	
	LegR 	=	SAHELAN_LIFE_ESCAPE_SEQ/6,	
	LegL 	=	SAHELAN_LIFE_ESCAPE_SEQ/6,	


	Tnk		=	SAHELAN_LIFE_ESCAPE_SEQ/6,	

}

this.sahelanLifeTable_Last = {
	Body 	=	10000,	
	Bp 		=	10000,	
	Head 	=	10000,	
	ArmR 	=	10000,	
	ArmL 	=	10000,	
	ThighR 	=	10000,	
	ThighL 	=	10000,	
	LegR 	=	10000,	
	LegL 	=	10000,	
	Tnk		=	10000,	
}




this.soldierDefine = {
	
	nil
}

this.VEHICLE_SPAWN_LIST = {
	{ id = "Spawn", locator = "VehicleLocator01", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.NONE, },
	{ id = "Spawn", locator = "VehicleLocator02", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL, },
	{ id = "Spawn", locator = "VehicleLocator03", type = Vehicle.type.EASTERN_TRUCK, subType = Vehicle.subType.NONE, },
}





this.routeSets = {
	
	nil
}



this.combatSetting = {
	nil
}


this.disablePowerSettings = {
	"MISSILE",
	"SMG",
}




this.SahelanCounter = 0

this.activeRvTable = {}


this.sahelanRouteTable = {

	

	trap_shln_area0020 = { "rts_shln_s_0020", "rts_shln_c_0020" },
	trap_shln_area0030 = { "rts_shln_s_0030", "rts_shln_c_0030" },
	trap_shln_area0040 = { "rts_shln_s_0040", "rts_shln_c_0040" },


	trap_shln_area1010 = { "rts_shln_s_1010", "rts_shln_c_1010" },
	trap_shln_area1020 = { "rts_shln_s_1020", "rts_shln_c_1020" },
	trap_shln_area1030 = { "rts_shln_s_1030", "rts_shln_c_1030" },


	trap_shln_area2010 = { "rts_shln_s_2010", "rts_shln_c_2010" },
	trap_shln_area2020 = { "rts_shln_s_2020", "rts_shln_c_2020" },
	trap_shln_area2030 = { "rts_shln_s_2030", "rts_shln_c_2030" },
	trap_shln_area2040 = { "rts_shln_s_2040", "rts_shln_c_2040" },
	trap_shln_area2050 = { "rts_shln_s_2050", "rts_shln_c_2050" },
	trap_shln_area2060 = { "rts_shln_s_2060", "rts_shln_c_2060" },


	trap_shln_area3010 = { "rts_shln_s_3010", "rts_shln_c_3010" },
	trap_shln_area3020 = { "rts_shln_s_3020", "rts_shln_c_3020" },
	trap_shln_area3030 = { "rts_shln_s_3030", "rts_shln_c_3030" },
	trap_shln_area3040 = { "rts_shln_s_3040", "rts_shln_c_3040" },
	trap_shln_area3050 = { "rts_shln_s_3050", "rts_shln_c_3050" },
	trap_shln_area3060 = { "rts_shln_s_3060", "rts_shln_c_0033" },		
	trap_shln_area3070 = { "rts_shln_s_3070", "rts_shln_c_3070" },


	trap_shln_area4010 = { "rts_shln_s_4010", "rts_shln_c_0034" },		
	trap_shln_area4020 = { "rts_shln_s_4020", "rts_shln_c_4020" },


	trap_shln_area5010 = { "rts_shln_s_5010", "rts_shln_c_5010" },
	trap_shln_area5020 = { "rts_shln_s_5020", "rts_shln_c_5020" },
	trap_shln_area5030 = { "rts_shln_s_5030", "rts_shln_c_5030" },


	trap_shln_area6010 = { "rts_shln_s_6010", "rts_shln_c_6010" },
	trap_shln_area6020 = { "rts_shln_s_6020", "rts_shln_c_0032" },		
	trap_shln_area6030 = { "rts_shln_s_6030", "rts_shln_c_6030" },

	trap_shln_area7000 = { "rts_shln_s_7000", "rts_shln_c_7000" },

	


	trap_shln_dummy02 = { "rts_shln_s_7000", "rts_shln_c_0023" },
	trap_shln_dummy03 = { "rts_shln_s_7000", "rts_shln_c_0031" },



}


this.sahelanLinkRouteTable = {
	
	{ { "rts_shln_s_5020", 3, }, { "rts_shln_c_5010", 2 }, }, 
	{ { "rts_shln_s_1030", 4, }, { "rts_shln_c_1010", 7 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2010", 5 }, }, 
	{ { "rts_shln_s_2060", 5, }, { "rts_shln_c_3030", 6 }, }, 
	{ { "rts_shln_s_3060", 5, }, { "rts_shln_c_3070", 2 }, }, 
	{ { "rts_shln_s_3040", 5, }, { "rts_shln_c_3030", 6 }, }, 
	{ { "rts_shln_s_6030", 5, }, { "rts_shln_c_6030", 7 }, }, 
	{ { "rts_shln_s_6030", 13, }, { "rts_shln_c_6020", 2 }, }, 
	{ { "rts_shln_s_2040", 9, }, { "rts_shln_c_2020", 4 }, }, 
	{ { "rts_shln_s_1020", 7, }, { "rts_shln_c_2010", 1 }, }, 
	{ { "rts_shln_s_6030", 2, }, { "rts_shln_c_6030", 3 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_4020", 3 }, }, 
	{ { "rts_shln_s_6020", 4, }, { "rts_shln_c_5020", 5 }, }, 
	{ { "rts_shln_s_1000", 3, }, { "rts_shln_c_0023", 5 }, }, 
	{ { "rts_shln_s_6020", 4, }, { "rts_shln_c_6010", 1 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_2060", 4 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_2060", 5 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_2050", 4 }, }, 
	{ { "rts_shln_s_4010", 10, }, { "rts_shln_c_3040", 8 }, }, 
	{ { "rts_shln_s_2030", 5, }, { "rts_shln_c_2040", 9 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_2030", 13 }, }, 
	{ { "rts_shln_s_5010", 3, }, { "rts_shln_c_3070", 6 }, }, 
	{ { "rts_shln_c_2030", 11, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_s_3050", 5, }, { "rts_shln_c_3050", 6 }, }, 
	{ { "rts_shln_s_3040", 12, }, { "rts_shln_c_3040", 2 }, }, 
	{ { "rts_shln_s_3040", 5, }, { "rts_shln_c_3030", 14 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_3010", 4 }, }, 
	{ { "rts_shln_s_2010", 18, }, { "rts_shln_c_1020", 4 }, }, 
	{ { "rts_shln_s_6030", 5, }, { "rts_shln_c_6030", 3 }, }, 
	{ { "rts_shln_s_6020", 7, }, { "rts_shln_c_6010", 2 }, }, 
	{ { "rts_shln_s_6030", 13, }, { "rts_shln_c_6030", 12 }, }, 
	{ { "rts_shln_s_6010", 4, }, { "rts_shln_c_6010", 3 }, }, 
	{ { "rts_shln_s_2050", 12, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_s_3030", 4, }, { "rts_shln_c_3040", 2 }, }, 
	{ { "rts_shln_s_2010", 18, }, { "rts_shln_c_1010", 9 }, }, 
	{ { "rts_shln_s_5020", 9, }, { "rts_shln_c_4020", 10 }, }, 
	{ { "rts_shln_s_1010", 3, }, { "rts_shln_c_1010", 4 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_2060", 4 }, }, 
	{ { "rts_shln_s_0040", 8, }, { "rts_shln_c_0040", 7 }, }, 
	{ { "rts_shln_s_6030", 13, }, { "rts_shln_c_6030", 12 }, }, 
	{ { "rts_shln_s_1030", 8, }, { "rts_shln_c_2010", 5 }, }, 
	{ { "rts_shln_s_5030", 7, }, { "rts_shln_c_4020", 2 }, }, 
	{ { "rts_shln_s_0040", 6, }, { "rts_shln_c_0040", 4 }, }, 
	{ { "rts_shln_s_3050", 4, }, { "rts_shln_c_3050", 4 }, }, 
	{ { "rts_shln_s_1030", 4, }, { "rts_shln_c_1010", 4 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2010", 8 }, }, 
	{ { "rts_shln_s_3010", 3, }, { "rts_shln_c_2060", 11 }, }, 
	{ { "rts_shln_s_2050", 2, }, { "rts_shln_c_2050", 7 }, }, 
	{ { "rts_shln_s_1020", 3, }, { "rts_shln_c_1020", 7 }, }, 
	{ { "rts_shln_s_1030", 8, }, { "rts_shln_c_2040", 7 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_2010", 1 }, }, 
	{ { "rts_shln_s_0020", 0, }, { "rts_shln_c_0040", 2 }, }, 
	{ { "rts_shln_s_5020", 3, }, { "rts_shln_c_5020", 3 }, }, 
	{ { "rts_shln_s_3060", 5, }, { "rts_shln_c_3050", 7 }, }, 
	{ { "rts_shln_s_1030", 8, }, { "rts_shln_c_2040", 9 }, }, 
	{ { "rts_shln_s_4020", 11, }, { "rts_shln_c_5010", 13 }, }, 
	{ { "rts_shln_s_2040", 4, }, { "rts_shln_c_2030", 13 }, }, 
	{ { "rts_shln_s_3020", 2, }, { "rts_shln_c_2040", 12 }, }, 
	{ { "rts_shln_s_2040", 9, }, { "rts_shln_c_2030", 6 }, }, 
	{ { "rts_shln_c_6010", 6, }, { "rts_shln_c_6030", 3 }, }, 
	{ { "rts_shln_s_5020", 3, }, { "rts_shln_c_5030", 2 }, }, 
	{ { "rts_shln_s_1030", 8, }, { "rts_shln_c_2010", 8 }, }, 
	{ { "rts_shln_s_3010", 12, }, { "rts_shln_c_2020", 9 }, }, 
	{ { "rts_shln_s_5030", 7, }, { "rts_shln_c_5020", 10 }, }, 
	{ { "rts_shln_c_2010", 1, }, { "rts_shln_s_2010", 12 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_2020", 2 }, }, 
	{ { "rts_shln_s_1030", 8, }, { "rts_shln_c_1030", 8 }, }, 
	{ { "rts_shln_s_2050", 2, }, { "rts_shln_c_2020", 6 }, }, 
	{ { "rts_shln_c_3010", 4, }, { "rts_shln_c_2020", 9 }, }, 
	{ { "rts_shln_s_3040", 5, }, { "rts_shln_c_3030", 14 }, }, 
	{ { "rts_shln_s_1030", 8, }, { "rts_shln_c_2010", 3 }, }, 
	{ { "rts_shln_s_2010", 18, }, { "rts_shln_c_1020", 7 }, }, 
	{ { "rts_shln_s_2050", 9, }, { "rts_shln_c_2030", 11 }, }, 
	{ { "rts_shln_s_1010", 3, }, { "rts_shln_c_2010", 8 }, }, 
	{ { "rts_shln_s_1010", 3, }, { "rts_shln_c_2010", 3 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_2030", 6 }, }, 
	{ { "rts_shln_s_2050", 9, }, { "rts_shln_c_3020", 13 }, }, 
	{ { "rts_shln_s_6030", 13, }, { "rts_shln_c_6030", 14 }, }, 
	{ { "rts_shln_s_6030", 9, }, { "rts_shln_c_6030", 6 }, }, 
	{ { "rts_shln_s_3050", 3, }, { "rts_shln_c_3050", 8 }, }, 
	{ { "rts_shln_s_1020", 4, }, { "rts_shln_c_0023", 8 }, }, 
	{ { "rts_shln_s_3050", 8, }, { "rts_shln_c_3040", 6 }, }, 
	{ { "rts_shln_s_1000", 3, }, { "rts_shln_c_0023", 8 }, }, 
	{ { "rts_shln_s_1030", 6, }, { "rts_shln_c_2010", 1 }, }, 
	{ { "rts_shln_s_5010", 6, }, { "rts_shln_c_4020", 3 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_3010", 8 }, }, 
	{ { "rts_shln_s_1020", 4, }, { "rts_shln_c_0023", 5 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2010", 1 }, }, 
	{ { "rts_shln_s_3070", 4, }, { "rts_shln_c_3070", 2 }, }, 
	{ { "rts_shln_s_0020", 3, }, { "rts_shln_c_0020", 6 }, }, 
	{ { "rts_shln_c_5020", 8, }, { "rts_shln_c_4020", 5 }, }, 
	{ { "rts_shln_s_1010", 3, }, { "rts_shln_c_1030", 14 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_1010", 4 }, }, 
	{ { "rts_shln_c_2050", 7, }, { "rts_shln_c_3020", 1 }, }, 
	{ { "rts_shln_s_3040", 5, }, { "rts_shln_c_3040", 2 }, }, 
	{ { "rts_shln_s_4010", 4, }, { "rts_shln_c_3070", 16 }, }, 
	{ { "rts_shln_s_2030", 11, }, { "rts_shln_c_2030", 9 }, }, 
	{ { "rts_shln_s_3020", 2, }, { "rts_shln_c_2020", 8 }, }, 
	{ { "rts_shln_s_0040", 6, }, { "rts_shln_c_0040", 5 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_3020", 1 }, }, 
	{ { "rts_shln_s_2050", 8, }, { "rts_shln_c_3020", 1 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_2020", 9 }, }, 
	{ { "rts_shln_s_2050", 11, }, { "rts_shln_c_3020", 12 }, }, 
	{ { "rts_shln_s_3040", 5, }, { "rts_shln_c_3010", 8 }, }, 
	{ { "rts_shln_s_6010", 6, }, { "rts_shln_c_6010", 8 }, }, 
	{ { "rts_shln_s_3050", 2, }, { "rts_shln_c_3030", 7 }, }, 
	{ { "rts_shln_s_3020", 5, }, { "rts_shln_c_3020", 4 }, }, 
	{ { "rts_shln_s_2030", 11, }, { "rts_shln_c_2040", 12 }, }, 
	{ { "rts_shln_s_2010", 18, }, { "rts_shln_c_2010", 1 }, }, 
	{ { "rts_shln_s_1020", 7, }, { "rts_shln_c_1010", 4 }, }, 
	{ { "rts_shln_c_3030", 6, }, { "rts_shln_c_3010", 8 }, }, 
	{ { "rts_shln_s_2060", 5, }, { "rts_shln_c_2060", 11 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_5020", 8 }, }, 
	{ { "rts_shln_s_3020", 6, }, { "rts_shln_c_3020", 4 }, }, 
	{ { "rts_shln_s_2010", 1, }, { "rts_shln_c_2010", 3 }, }, 
	{ { "rts_shln_s_2040", 9, }, { "rts_shln_c_2010", 8 }, }, 
	{ { "rts_shln_s_4020", 11, }, { "rts_shln_c_3070", 6 }, }, 
	{ { "rts_shln_s_3040", 5, }, { "rts_shln_c_3030", 6 }, }, 
	{ { "rts_shln_s_6010", 6, }, { "rts_shln_c_6010", 1 }, }, 
	{ { "rts_shln_s_1010", 3, }, { "rts_shln_c_1030", 8 }, }, 
	{ { "rts_shln_s_6010", 4, }, { "rts_shln_c_6010", 8 }, }, 
	{ { "rts_shln_s_1000", 9, }, { "rts_shln_c_1010", 9 }, }, 
	{ { "rts_shln_s_1030", 4, }, { "rts_shln_c_2010", 1 }, }, 
	{ { "rts_shln_s_4020", 7, }, { "rts_shln_c_4020", 10 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_4020", 10 }, }, 
	{ { "rts_shln_s_3060", 4, }, { "rts_shln_c_3050", 6 }, }, 
	{ { "rts_shln_s_2020", 6, }, { "rts_shln_c_2020", 6 }, }, 
	{ { "rts_shln_c_3070", 16, }, { "rts_shln_c_3070", 5 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_2060", 9 }, }, 
	{ { "rts_shln_s_3020", 6, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_s_3010", 14, }, { "rts_shln_c_3020", 15 }, }, 
	{ { "rts_shln_s_3040", 7, }, { "rts_shln_c_3040", 12 }, }, 
	{ { "rts_shln_s_3020", 8, }, { "rts_shln_c_3020", 15 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_2040", 9 }, }, 
	{ { "rts_shln_s_3050", 4, }, { "rts_shln_c_3050", 6 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2010", 3 }, }, 
	{ { "rts_shln_s_6030", 4, }, { "rts_shln_c_6010", 6 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2040", 7 }, }, 
	{ { "rts_shln_s_5030", 1, }, { "rts_shln_c_5020", 5 }, }, 
	{ { "rts_shln_s_5010", 11, }, { "rts_shln_c_3070", 14 }, }, 
	{ { "rts_shln_s_5030", 2, }, { "rts_shln_c_5030", 5 }, }, 
	{ { "rts_shln_c_3020", 6, }, { "rts_shln_c_3050", 6 }, }, 
	{ { "rts_shln_c_2040", 12, }, { "rts_shln_c_2020", 4 }, }, 
	{ { "rts_shln_c_0023", 14, }, { "rts_shln_c_1020", 7 }, }, 
	{ { "rts_shln_c_0023", 14, }, { "rts_shln_c_1010", 9 }, }, 
	{ { "rts_shln_s_3030", 7, }, { "rts_shln_c_2060", 4 }, }, 
	{ { "rts_shln_s_2030", 7, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_c_3020", 19, }, { "rts_shln_c_2060", 4 }, }, 
	{ { "rts_shln_c_5030", 2, }, { "rts_shln_c_5010", 4 }, }, 
	{ { "rts_shln_s_6030", 4, }, { "rts_shln_c_6030", 8 }, }, 
	{ { "rts_shln_s_6030", 10, }, { "rts_shln_c_6030", 8 }, }, 
	{ { "rts_shln_s_6030", 10, }, { "rts_shln_c_6030", 7 }, }, 
	{ { "rts_shln_s_6020", 7, }, { "rts_shln_c_6010", 6 }, }, 
	{ { "rts_shln_s_5010", 0, }, { "rts_shln_c_3070", 6 }, }, 
	{ { "rts_shln_s_5030", 5, }, { "rts_shln_c_5020", 10 }, }, 
	{ { "rts_shln_s_4020", 5, }, { "rts_shln_c_4020", 3 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_2010", 3 }, }, 
	{ { "rts_shln_s_4010", 5, }, { "rts_shln_c_3070", 14 }, }, 
	{ { "rts_shln_s_2010", 18, }, { "rts_shln_c_1030", 14 }, }, 
	{ { "rts_shln_s_6020", 4, }, { "rts_shln_c_6010", 3 }, }, 
	{ { "rts_shln_c_1030", 8, }, { "rts_shln_s_2010", 1 }, }, 
	{ { "rts_shln_s_5020", 9, }, { "rts_shln_c_5010", 10 }, }, 
	{ { "rts_shln_c_3020", 16, }, { "rts_shln_c_2060", 4 }, }, 
	{ { "rts_shln_s_2030", 9, }, { "rts_shln_c_2030", 9 }, }, 
	{ { "rts_shln_s_3010", 0, }, { "rts_shln_c_3020", 4 }, }, 
	{ { "rts_shln_s_1020", 4, }, { "rts_shln_c_0023", 7 }, }, 
	{ { "rts_shln_s_2010", 12, }, { "rts_shln_c_1030", 8 }, }, 
	{ { "rts_shln_s_0020", 3, }, { "rts_shln_c_0020", 5 }, }, 
	{ { "rts_shln_s_3020", 5, }, { "rts_shln_c_3050", 6 }, }, 
	{ { "rts_shln_s_2020", 2, }, { "rts_shln_c_2020", 9 }, }, 
	{ { "rts_shln_s_2020", 1, }, { "rts_shln_c_2030", 9 }, }, 
	{ { "rts_shln_s_2030", 9, }, { "rts_shln_c_3020", 13 }, }, 
	{ { "rts_shln_s_0040", 9, }, { "rts_shln_c_0040", 7 }, }, 
	{ { "rts_shln_s_0040", 9, }, { "rts_shln_c_0040", 9 }, }, 
	{ { "rts_shln_s_1000", 3, }, { "rts_shln_c_0023", 4 }, }, 
	{ { "rts_shln_s_0040", 8, }, { "rts_shln_c_0040", 5 }, }, 
	{ { "rts_shln_s_2030", 5, }, { "rts_shln_c_2020", 2 }, }, 
	{ { "rts_shln_s_3030", 1, }, { "rts_shln_c_3040", 6 }, }, 
	{ { "rts_shln_s_2050", 14, }, { "rts_shln_c_2030", 6 }, }, 
	{ { "rts_shln_s_4020", 11, }, { "rts_shln_c_5010", 10 }, }, 
	{ { "rts_shln_s_3050", 2, }, { "rts_shln_c_3040", 2 }, }, 
	{ { "rts_shln_s_0030", 3, }, { "rts_shln_c_0032", 3 }, }, 
	{ { "rts_shln_s_2030", 8, }, { "rts_shln_c_3020", 13 }, }, 
	{ { "rts_shln_s_3040", 10, }, { "rts_shln_c_3040", 12 }, }, 
	{ { "rts_shln_s_6010", 4, }, { "rts_shln_c_6010", 1 }, }, 
	{ { "rts_shln_s_3020", 5, }, { "rts_shln_c_3020", 6 }, }, 
	{ { "rts_shln_s_2060", 7, }, { "rts_shln_c_2060", 11 }, }, 
	{ { "rts_shln_s_2010", 12, }, { "rts_shln_c_1030", 5 }, }, 
	{ { "rts_shln_s_5010", 6, }, { "rts_shln_c_4020", 7 }, }, 
	{ { "rts_shln_s_2040", 9, }, { "rts_shln_c_2030", 4 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2010", 5 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_1030", 8 }, }, 
	{ { "rts_shln_s_2050", 8, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_s_6010", 7, }, { "rts_shln_c_6010", 1 }, }, 
	{ { "rts_shln_s_3010", 14, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_s_6020", 8, }, { "rts_shln_c_6010", 3 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_5010", 13 }, }, 
	{ { "rts_shln_s_2050", 12, }, { "rts_shln_c_3020", 13 }, }, 
	{ { "rts_shln_s_1020", 3, }, { "rts_shln_c_1020", 4 }, }, 
	{ { "rts_shln_s_2050", 12, }, { "rts_shln_c_2030", 11 }, }, 
	{ { "rts_shln_s_4010", 6, }, { "rts_shln_c_3050", 4 }, }, 
	{ { "rts_shln_c_3070", 5, }, { "rts_shln_c_4020", 8 }, }, 
	{ { "rts_shln_c_3070", 2, }, { "rts_shln_c_3050", 7 }, }, 
	{ { "rts_shln_s_2030", 6, }, { "rts_shln_c_2030", 9 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2040", 12 }, }, 
	{ { "rts_shln_c_2060", 11, }, { "rts_shln_c_3020", 4 }, }, 
	{ { "rts_shln_s_3010", 3, }, { "rts_shln_c_3020", 4 }, }, 
	{ { "rts_shln_s_6030", 6, }, { "rts_shln_c_6030", 6 }, }, 
	{ { "rts_shln_s_4020", 7, }, { "rts_shln_c_4020", 7 }, }, 
	{ { "rts_shln_s_6030", 2, }, { "rts_shln_c_7000", 8 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_4020", 10 }, }, 
	{ { "rts_shln_s_6010", 7, }, { "rts_shln_c_6010", 3 }, }, 
	{ { "rts_shln_s_6030", 3, }, { "rts_shln_c_6030", 3 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_1010", 4 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_5010", 19 }, }, 
	{ { "rts_shln_s_5020", 6, }, { "rts_shln_c_4020", 3 }, }, 
	{ { "rts_shln_s_4020", 2, }, { "rts_shln_c_5010", 13 }, }, 
	{ { "rts_shln_s_5010", 3, }, { "rts_shln_c_4020", 10 }, }, 
	{ { "rts_shln_s_3030", 1, }, { "rts_shln_c_2060", 11 }, }, 
	{ { "rts_shln_s_3010", 12, }, { "rts_shln_c_2050", 7 }, }, 
	{ { "rts_shln_s_3020", 8, }, { "rts_shln_c_3020", 14 }, }, 
	{ { "rts_shln_s_4020", 2, }, { "rts_shln_c_4020", 10 }, }, 
	{ { "rts_shln_s_4020", 2, }, { "rts_shln_c_5010", 10 }, }, 
	{ { "rts_shln_s_5010", 9, }, { "rts_shln_c_3070", 6 }, }, 
	{ { "rts_shln_s_4010", 8, }, { "rts_shln_c_3070", 2 }, }, 
	{ { "rts_shln_s_4010", 8, }, { "rts_shln_c_3050", 7 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_2040", 7 }, }, 
	{ { "rts_shln_s_3070", 4, }, { "rts_shln_c_3050", 7 }, }, 
	{ { "rts_shln_s_3060", 3, }, { "rts_shln_c_3050", 2 }, }, 
	{ { "rts_shln_s_3060", 6, }, { "rts_shln_c_3050", 8 }, }, 
	{ { "rts_shln_s_2020", 5, }, { "rts_shln_c_2020", 8 }, }, 
	{ { "rts_shln_s_3060", 4, }, { "rts_shln_c_3050", 8 }, }, 
	{ { "rts_shln_s_3050", 4, }, { "rts_shln_c_3050", 2 }, }, 
	{ { "rts_shln_s_5020", 9, }, { "rts_shln_c_4020", 3 }, }, 
	{ { "rts_shln_s_3040", 10, }, { "rts_shln_c_2060", 14 }, }, 
	{ { "rts_shln_s_3040", 7, }, { "rts_shln_c_3040", 8 }, }, 
	{ { "rts_shln_c_3040", 2, }, { "rts_shln_c_2060", 14 }, }, 
	{ { "rts_shln_s_2040", 9, }, { "rts_shln_c_2030", 13 }, }, 
	{ { "rts_shln_s_2030", 5, }, { "rts_shln_c_2030", 13 }, }, 
	{ { "rts_shln_s_2020", 1, }, { "rts_shln_c_2030", 11 }, }, 
	{ { "rts_shln_s_3020", 2, }, { "rts_shln_c_2020", 6 }, }, 
	{ { "rts_shln_s_1020", 7, }, { "rts_shln_c_1010", 9 }, }, 
	{ { "rts_shln_s_3010", 12, }, { "rts_shln_c_2020", 2 }, }, 
	{ { "rts_shln_s_1010", 5, }, { "rts_shln_c_1030", 14 }, }, 
	{ { "rts_shln_s_2050", 2, }, { "rts_shln_c_2020", 9 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2040", 7 }, }, 
	{ { "rts_shln_s_2040", 9, }, { "rts_shln_c_2050", 4 }, }, 
	{ { "rts_shln_s_3030", 4, }, { "rts_shln_c_3020", 4 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2040", 9 }, }, 
	{ { "rts_shln_s_2010", 1, }, { "rts_shln_c_1030", 5 }, }, 
	{ { "rts_shln_s_1020", 7, }, { "rts_shln_c_1010", 7 }, }, 
	{ { "rts_shln_s_2010", 6, }, { "rts_shln_c_2040", 9 }, }, 
	{ { "rts_shln_s_4020", 5, }, { "rts_shln_c_4020", 8 }, }, 
	{ { "rts_shln_s_6030", 2, }, { "rts_shln_c_7000", 5 }, }, 
	{ { "rts_shln_s_5010", 11, }, { "rts_shln_c_3070", 5 }, }, 
}








this.missileRouteList = {
	"rts_SearchMissile0000",
	"rts_SearchMissile0001",
	"rts_SearchMissile0002",
	"rts_SearchMissile0003",
	"rts_SearchMissile0004",
	"rts_SearchMissile0005",
	"rts_SearchMissile0006",
	"rts_SearchMissile0007",
	"rts_SearchMissile0008",
	"rts_SearchMissile0009",
	"rts_SearchMissile0010",
	"rts_SearchMissile0011",
	"rts_SearchMissile0012",
	"rts_SearchMissile0013",
	"rts_SearchMissile0014",
	"rts_SearchMissile0015",
	"rts_SearchMissile0016",
	"rts_SearchMissile0017",
	"rts_SearchMissile0018",
	"rts_SearchMissile0019",
	"rts_SearchMissile0020",
	"rts_SearchMissile0021",
	"rts_SearchMissile0022",
	"rts_SearchMissile0023",
	"rts_SearchMissile0024",
	"rts_SearchMissile0025",
	"rts_SearchMissile0026",
	"rts_SearchMissile0027",
	"rts_SearchMissile0028",
	"rts_SearchMissile0029",
	"rts_SearchMissile0030",
	"rts_SearchMissile0031",
	"rts_SearchMissile0032",
	"rts_SearchMissile0033",
	"rts_SearchMissile0034",
	"rts_SearchMissile0035",
	"rts_SearchMissile0036",
	"rts_SearchMissile0037",
	"rts_SearchMissile0038",
	"rts_SearchMissile0039",
	"rts_SearchMissile0040",
	"rts_SearchMissile0041",
}


this.rvSetTable = {

	
	lzs_sovietBase_S_0000 = {
		jumpPos =	{ -2037.069, 432.601, -1137.089, 120.0 },		
		shootPos =	{ -2079.964, 455.498, -1236.991 },		
		heliPos =	{ -1955.206, 432.700, -1174.032 },		
		attackPos =	{ -2051.957,497.2467,-1298.688 },		
	},
	
	lzs_sovietBase_S_0001 = {
		jumpPos =	{ -2159.427, 441.790, -1171.342, 120.0 },
		shootPos =	{ -2201.116, 457.788, -1151.382 },
		heliPos =	{ -2147.232,451.0734,-1247.691 },
		attackPos =	{ -2107.33,481.9187,-1174.144 },
	},
	
	lzs_sovietSouth_W_0000 = {
		jumpPos =	{ -1628.000, 418.013, -1077.658, 120.0 },
		shootPos =	{ -1762.894, 429.377, -1086.336 },
		heliPos =	{ -1638.567, 429.171, -1176.758 },
		attackPos =	{ -1494.162,467.172,-1096.844 },
	},
}


this.ignoreTrapList = {
	

	"trap_shln_area6010",
	"trap_shln_area6020",
	"trap_shln_area6030",
	"trap_shln_area7000",
}


this.SpawnVehicleOnInitialize = function()
	Fox.Log("*** SpawnVehicleOnInitialize ***")
	TppEnemy.SpawnVehicles( this.VEHICLE_SPAWN_LIST )
end




this.sahelanTraps = {}
for trapName,sahelanRoutes in pairs ( this.sahelanRouteTable ) do
	local trapTable = {
		msg = "Enter",	sender = trapName,
		func = function ()	this.UpdateSahelanRoute( trapName )	end
	}
	table.insert( this.sahelanTraps, trapTable )
end

function this.Messages()
	return
	StrCode32Table {
		Trap = this.sahelanTraps,
		nil
	}
end






this.InitEnemy = function ()
	Fox.Log("*** s10070_enemy03 InitEnemy ***")
end



this.SetUpEnemy = function ()
	Fox.Log("*** s10070_enemy03 SetUpEnemy ***")
	
	TppEnemy.SetRescueTargets( {TARGET_HUEY} )

	
	local sequenceIndex = TppSequence.GetSequenceIndex("Seq_Game_EscapeSahelan")
	if sequenceIndex >= TppSequence.GetCurrentSequenceIndex() then
		this.SetUpSahelan()
	end

	
	local gameObjectId = { type="TppCommonWalkerGear2", index=0 }
	s10070_sequence.SetUpSPwalkerGear(gameObjectId)


end


this.OnLoad = function ()
	Fox.Log("*** s10070_enemy03 onload ***")
end






this.SetUpSahelan = function()
	Fox.Log("*** s10070_enemy03 SetUpSahelan ***")

	
	this.SetSahelanRoute( "rts_shln_s_1010", "rts_shln_c_0023" )
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	GameObject.SendCommand(gameObjectId, {id="SetCautionRoute", route="rts_shln_c_0023"} )	

	
	this.UpdateSahelanBaseRoute( "rts_shln_b_0000" )

	
	this.SetSahelanSearchRouteList()

	
	this.SetSahelanRouteLink()

	
	this.SetSahelanMissileRouteList()

	
	this.SetSahelanLife(SAHELAN_LIFE_ESCAPE_SEQ)
	
	this.SetSahelanPartsLife(this.sahelanLifeTable)

	
	if DEBUG then
		DEBUG.SetDebugMenuValue("Sahelan2", "ToStopActionRestLifeVal",	100 )	

		

		DEBUG.SetDebugMenuValue("Sahelan2", "StompAttackSize",	100 )		
		DEBUG.SetDebugMenuValue("Sahelan2", "AttackShortRange",  25 )

		
		DEBUG.SetDebugMenuValue("Sahelan2", "LostAlertTime", 20)	
		
		DEBUG.SetDebugMenuValue("Sahelan2", "LostPlayerTime", 40 )	

		
		DEBUG.SetDebugMenuValue("Sahelan2", "GoToHeliDistanceMin", 120 )	
		
		DEBUG.SetDebugMenuValue("Sahelan2", "CloseToTargetLength", 55 )	

		DEBUG.SetDebugMenuValue("Sahelan2", "LengthForPeepAction", 30 )	
		DEBUG.SetDebugMenuValue("Sahelan2", "RouteEvToPlayerLength", 40 )	

		
		DEBUG.SetDebugMenuValue("Sahelan2", "ReflexTimeOnAlert", 600)	

		
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyDiscoveryDist", 35)		
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyDiscoveryVAngle", 90)	
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyDiscoveryHAngle", 60)	
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyNormalDist", 75)			
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyNormalVAngle", 90)		
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyNormalHAngle", 50)		
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyFarDist", 150)			
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyFarVAngle", 60)			
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "BodyFarHAngle", 50)			
		DEBUG.SetDebugMenuValue("Sahelan2 Sight", "NormalToFarSpeed", 30)		

		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VsHeliMissileSpdRate", 150 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VsHeliSrchMissInterval", 75 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VsHeliSrchMissWaitingTime", 85 )	
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VsHeliLastAttackTime", 400 )		

		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunFireMaxTime", 6 )			
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunFireLostTime", 3 )			
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunFireRange", 100 )				
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunFireNumOfOneShot", 5 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunOneShotInterval", 45 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunFireNumOfOneUnit", 3 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunOneUnitInterval", 150 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunOneSetInterval", 300 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunWobbingRate2", 3 )			
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "VulcunImpactRange", 45 )			
		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "PileAtkStartWaitTime", 80 )		
		DEBUG.SetDebugMenuValue("Sahelan2 Weapon", "PileAtkEndWaitTime", 150 )		
	end

end



this.SetSahelanLife = function(slife)
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local cmdSetLife = { id = "SetMaxLife", life = slife } 
	local cmdStopLife = { id = "SetStopLife", life = SAHELAN_STOP_LIFE_ESCAPE_SEQ } 
	GameObject.SendCommand( gameObjectId, cmdSetLife )
	GameObject.SendCommand( gameObjectId, cmdStopLife )
end


this.SetSahelanPartsLife =function(sahelanLifeTable)
	for partsName,partsLife in pairs ( sahelanLifeTable ) do

		local gameObjectId = {type="TppSahelan2", group=0, index=0}
		local command = { id = "SetMaxPartsLife", parts = partsName, life = partsLife }
		GameObject.SendCommand( gameObjectId, command )
	end
end


this.SetSahelanType = function()
	
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {id="SetStageType", index = 0, }	
	GameObject.SendCommand(gameObjectId, command)
end


this.GetDistanceToPlayer = function()
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {id="GetDistanceToPlayer" }
	local distance = 0
	distance = GameObject.SendCommand(gameObjectId, command)
	Fox.Log("*** s10070_enemy03 GetDistanceToPlayer ***"..distance )
	return distance
end


this.GetDistanceToLandingZone = function()
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {id="GetDistanceToLandingZone" }
	local distance = 0
	distance = GameObject.SendCommand(gameObjectId, command)
	Fox.Log("*** s10070_enemy03 GetDistanceToLandingZone ***"..distance )
	return distance
end


this.UpdateSahelanBaseRoute = function( baseRouteName )
	Fox.Log("*** s10070_enemy03 UpdateSahelanBaseRoute ***"..baseRouteName )

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {id="SetBaseRoute", route=baseRouteName}
	GameObject.SendCommand(gameObjectId, command)

end


this.UpdateSahelanRoute = function( trapName )
	Fox.Log("*** s10070_enemy03 UpdateSahelanRoute ***"..trapName )

	local sahelanRouteTable = this.sahelanRouteTable
	local ignoreTrapList = this.ignoreTrapList

	
	for k, ignoreTrap in pairs(ignoreTrapList) do
		if trapName == ignoreTrap and this.SahelanCounter > SAHELAN_WEAKENING_COUNT then
			return
		end
	end

	
	for k, v in pairs(sahelanRouteTable) do
		if k == trapName then
			this.SetSahelanRoute( v[1], v[2] )
			return
		end
	end
end


this.SetSahelanRoute = function( sneakRouteName, cautionRouteName )
	Fox.Log("*** s10070_enemy03 SetSahelanRoute ***")

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command1 = {id="SetSneakRoute", route=sneakRouteName}

	GameObject.SendCommand(gameObjectId, command1)


end


this.SetSahelanSearchRouteList = function()
	Fox.Log("*** s10070_enemy03 SetSahelanSearchRouteList ***")

	local sahelanRouteTable = this.sahelanRouteTable
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local indexNum = 0

	
	for k, routeName in pairs(sahelanRouteTable) do
		Fox.Log("SetSahelanSearchRouteList:routeName::"..routeName[2])
		Fox.Log("SetSahelanSearchRouteList:indexNum::"..indexNum)
		local command = {id="SetCautionRouteAll", route= routeName[2], index=indexNum }
		GameObject.SendCommand(gameObjectId, command)
		indexNum = indexNum + 1
	end
end


this.SetSahelanRouteLink = function()
	Fox.Log("*** s10070_enemy03 SetSahelanRouteLink ***")

	local routeLinkTable = this.sahelanLinkRouteTable
	local gameObjectId = {type="TppSahelan2", group=0, index=0}

	for setNum, linkSet in pairs(routeLinkTable) do
		local routeName = {}
		local indexNum = {}

		for k, routeInfo in pairs(linkSet) do
			routeName[k] = routeInfo[1]
			indexNum[k] = routeInfo[2]
		end
		
		local command = {id="SetRelativeRouteNode", route0= routeName[1], index0=indexNum[1], route1= routeName[2], index1=indexNum[2], }
		GameObject.SendCommand(gameObjectId, command)

	end
end


this.SetSahelanMissileRouteList = function()
	Fox.Log("*** s10070_enemy03 SetSahelanMissileRouteList ***")

	local routeList = this.missileRouteList
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local indexNum = 0

	for k, routeName in pairs(routeList) do
		Fox.Log("SetSahelanMissileRouteList:routeName::"..routeName)
		local command = {id="SetSearchMissileRouteAll", route= routeName, index=indexNum }
		GameObject.SendCommand(gameObjectId, command)
		indexNum = indexNum + 1
	end
end


this.SetUpHeliPosTable = function( currentRvName )
	Fox.Log("*** s10070_enemy03 SetUpHeliPosTable ***")

	local rvTable = this.rvSetTable
	if currentRvName then
		for rvNameKey, posTable in pairs(rvTable) do
			Fox.Log("rvNameKey : "..rvNameKey )
			
			if StrCode32(rvNameKey) == currentRvName then
				this.activeRvTable = posTable
				return
			end
		end
	end

end


this.SetReadyVsHeliSeq = function( currentRvName )
	Fox.Log("*** s10070_enemy03 SetReadyVsHeliSeq ***"..currentRvName )

	local activeJumpPos = {}
	local activeJumpRot = 0.0

	
	this.SetUpHeliPosTable(currentRvName)

	
	for posName, pos in pairs(this.activeRvTable) do
		if posName == "jumpPos" then
			activeJumpPos = { pos[1], pos[2], pos[3] }
			activeJumpRot = pos[4]
		else
			Fox.Log("posName::"..posName)
		end
	end
	Fox.Log("activeShootPos ::: x: "..activeJumpPos[1].." y: "..activeJumpPos[2].." z: "..activeJumpPos[3] )

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {
			id = "SetPrevVsHeliSequencePosition",
			targetPosition = Vector3( activeJumpPos[1], activeJumpPos[2], activeJumpPos[3] ), 
			targetRotationY = activeJumpRot 
		}
	GameObject.SendCommand(gameObjectId, command)

end


this.SetVsHeliSeqStart = function( currentRvName )
	Fox.Log("*** s10070_enemy03 SetVsHeliSeqStart ***")

	Fox.Log("currentRvName : "..currentRvName )

	
	this.SetSahelanLife(SAHELAN_LIFE_HELI_SEQ)

	this.SetUpHeliPosTable(currentRvName)

	local activeShootPos = {}
	local activeHeliPos = {}

	
	for posName, pos in pairs(this.activeRvTable) do
		if posName == "shootPos" then
			activeShootPos = { pos[1], pos[2], pos[3] }
		elseif posName == "heliPos" then
			activeHeliPos = { pos[1], pos[2], pos[3] }
		else
			Fox.Log("posName::"..posName)
		end
	end
	
	Fox.Log("activeShootPos ::: x: "..activeShootPos[1].." y: "..activeShootPos[2].." z: "..activeShootPos[3] )
	Fox.Log("activeHeliPos ::: x: "..activeHeliPos[1].." y: "..activeHeliPos[2].." z: "..activeHeliPos[3] )

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {
			id = "SetVsHeliSequenceStart",
			landingPosition = Vector3( activeHeliPos[1], activeHeliPos[2], activeHeliPos[3] ), 
			targetPosition = Vector3( activeShootPos[1], activeShootPos[2], activeShootPos[3] ) 
		}
	GameObject.SendCommand(gameObjectId, command)

end


this.SetVsHeliSeqEnd = function()
	Fox.Log("*** s10070_enemy03 SetVsHeliSeqEnd ***")

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = { id = "SetVsHeliSequenceMissileStop", }
	GameObject.SendCommand(gameObjectId, command)

end


this.SetVsHeliSeqFinishAttack = function()
	Fox.Log("*** s10070_enemy03 SetVsHeliSeqFinishAttack ***")

	
	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = {
		id = "SetVsHeliSequenceLast",
		targetPosition = Vector3( 0, 0, 0 ) 
	}
	GameObject.SendCommand(gameObjectId, command)
end



this.GetRVParam_HeliStart = function()
	Fox.Log("*** s10070_enemy03 GetTargetRV ***")

	local currentRvName = "lzs_sovietBase_S_0001"
	local rvTable = this.rvSetTable
	local activeShootPos = {}
	local activeHeliPos = {}

	for rvName, posTable in pairs(rvTable) do
		Fox.Log("rvName : "..rvName )
		
		if rvName == currentRvName then
			for posName, pos in pairs(posTable) do
				if posName == "shootPos" then
					activeShootPos = { pos[1], pos[2], pos[3] }
				elseif posName == "heliPos" then
					activeHeliPos = { pos[1], pos[2], pos[3] }
				else
					Fox.Log("posName::"..posName)
				end
			end
			
			Fox.Log("activeShootPos ::: x: "..activeShootPos[1].." y: "..activeShootPos[2].." z: "..activeShootPos[3] )
			Fox.Log("activeShootPos ::: x: "..activeHeliPos[1].." y: "..activeHeliPos[2].." z: "..activeHeliPos[3] )

		end
	end

end



this.SetRVPosToSahelan = function()
	Fox.Log("*** s10070_enemy03 SetRVPosToSahelan ***")

	
	local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
	local currentRvName = GameObject.SendCommand(gameObjectId, { id="GetCurrentLandingZoneName" })	
	Fox.Log("currentRvName : "..currentRvName )

	
	if currentRvName then
		this.SetRVPosToSahelanbyName(currentRvName)
	end

end

this.SetRVPosToSahelanbyName = function( currentRvName )
	Fox.Log("*** s10070_enemy03 SetRVPosToSahelanbyName ***"..currentRvName )

	local rvTable = this.rvSetTable
	local activeHeliPos = {}

	for rvNameKey, posTable in pairs(rvTable) do
		Fox.Log("rvNameKey : "..rvNameKey )
		
		if StrCode32(rvNameKey) == currentRvName then
			for posName, pos in pairs(posTable) do
				if posName == "heliPos" then
					activeHeliPos = { pos[1], pos[2], pos[3] }
				else
					Fox.Log("posName::"..posName)
				end
			end
			
			Fox.Log("activeHeliPos ::: x: "..activeHeliPos[1].." y: "..activeHeliPos[2].." z: "..activeHeliPos[3] )

			local gameObjectId = {type="TppSahelan2", group=0, index=0}
			local command = {
					id = "SetHeliPosition",
					position = Vector3( activeHeliPos[1], activeHeliPos[2], activeHeliPos[3] ), 
				}
			GameObject.SendCommand(gameObjectId, command)
			return
		end
	end

end


this.ResetRVPosToSahelan = function()
	Fox.Log("*** s10070_enemy03 ResetRVPosToSahelan ***")

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local command = { id = "ResetHeliPosition", }
	GameObject.SendCommand(gameObjectId, command)

end


this.ResetSahelanCounter = function()
	this.SahelanCounter = 0
	Fox.Log("*** s10070_enemy03 ResetSahelanCounter ***"..this.SahelanCounter)
end
this.CountSahelanCounter = function()
	this.SahelanCounter = this.SahelanCounter + 1
	Fox.Log("*** s10070_enemy03 CountSahelanCounter ***"..this.SahelanCounter)
end


this.SwitchAttackToHoveringHeli = function( flag )

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	if flag then
		Fox.Log("*** s10070_enemy03 SwitchAttackToHoveringHeli:Enable ***")
		local command = { id = "SetEnableAttackToHoveringHeli" }
		GameObject.SendCommand(gameObjectId, command)
	else
		Fox.Log("*** s10070_enemy03 SwitchAttackToHoveringHeli:Disable ***")
		local command = { id = "ResetEnableAttackToHoveringHeli" }
		GameObject.SendCommand(gameObjectId, command)
	end

end


this.CheckPlayerInSight = function()

	local gameObjectId = {type="TppSahelan2", group=0, index=0}
	local isPlayerInSight = GameObject.SendCommand( gameObjectId, { id = "IsPlayerInSight" } )

	if isPlayerInSight then
		Fox.Log("*** s10070_enemy03 CheckPlayerInSight: Player is InSight ***")
		return true
	else
		Fox.Log("*** s10070_enemy03 CheckPlayerInSight: Player is not InSight ***")
		return false
	end

end



return this
