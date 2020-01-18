local afgh_animal = {}


afgh_animal.animalBlockPackList = {
	_openingDemo				= { "/Assets/tpp/pack/mission2/common/mis_com_opening_demo.fpk" },
	commFacility_E				= { "/Assets/tpp/pack/mission2/animal/commFacility_E/anml_commFacility_E_00.fpk" },
	commFacility_W				= { "/Assets/tpp/pack/mission2/animal/commFacility_W/anml_commFacility_W_00.fpk" },
	enemyBase_E					= { "/Assets/tpp/pack/mission2/animal/enemyBase_E/anml_enemyBase_E_00.fpk" },
	enemyBase_S					= { "/Assets/tpp/pack/mission2/animal/enemyBase_S/anml_enemyBase_S_00.fpk" },
	enemyBase_S_BuddyPuppy		= { "/Assets/tpp/pack/mission2/animal/enemyBase_S/anml_enemyBase_S_01.fpk" },
	field_N						= { "/Assets/tpp/pack/mission2/animal/field_N/anml_field_N_00.fpk" },
	field_N_BuddyPuppy			= { "/Assets/tpp/pack/mission2/animal/field_N/anml_field_N_01.fpk" },
	remnantsNorth_N				= { "/Assets/tpp/pack/mission2/animal/remnantsNorth_N/anml_remnantsNorth_N_00.fpk" },
	remnantsNorth_N_s10052		= { "/Assets/tpp/pack/mission2/animal/remnantsNorth_N/anml_remnantsNorth_N_10.fpk" },	
	ruins_N						= { "/Assets/tpp/pack/mission2/animal/ruins_N/anml_ruins_N_00.fpk" },
	ruins_N_BuddyPuppy			= { "/Assets/tpp/pack/mission2/animal/ruins_N/anml_ruins_N_01.fpk" },
	ruins_S						= { "/Assets/tpp/pack/mission2/animal/ruins_S/anml_ruins_S_00.fpk" },
	slopedTown_S				= { "/Assets/tpp/pack/mission2/animal/slopedTown_S/anml_slopedTown_S_00.fpk" },
	slopedTown_S_RescueSpecial	= { "/Assets/tpp/pack/mission2/animal/slopedTown_S/anml_slopedTown_S_10.fpk" },
	village_N					= { "/Assets/tpp/pack/mission2/animal/village_N/anml_village_N_00.fpk" },
	village_W					= { "/Assets/tpp/pack/mission2/animal/village_W/anml_village_W_00.fpk" },
	waterway_I					= { "/Assets/tpp/pack/mission2/animal/waterway_I/anml_waterway_I_00.fpk" },
	waterway_I_Quiet			= { "/Assets/tpp/pack/mission2/animal/waterway_I/anml_waterway_I_10.fpk" },		
	waterway_I_Child			= { "/Assets/tpp/pack/mission2/animal/sovietBase_E/anml_sovietBase_E_10.fpk" },
	powerPlant_S				= { "/Assets/tpp/pack/mission2/animal/powerPlant_S/anml_powerPlant_S_00.fpk" },
	cliffTown_NE				= { "/Assets/tpp/pack/mission2/animal/cliffTown_NE/anml_cliffTown_NE_00.fpk" },
	citadel_S					= { "/Assets/tpp/pack/mission2/animal/citadel_S/anml_citadel_S_00.fpk" },
	cliffTown_SE				= { "/Assets/tpp/pack/mission2/animal/cliffTown_SE/anml_cliffTown_SE_00.fpk" },
	cliffTown_WS				= { "/Assets/tpp/pack/mission2/animal/cliffTown_WS/anml_cliffTown_WS_00.fpk" },
	powerPlant_SE				= { "/Assets/tpp/pack/mission2/animal/powerPlant_SE/anml_powerPlant_SE_00.fpk" },
	sovietBase_E				= { "/Assets/tpp/pack/mission2/animal/sovietBase_E/anml_sovietBase_E_00.fpk" },
	sovietBase_I				= { "/Assets/tpp/pack/mission2/animal/sovietBase_I/anml_sovietBase_I_00.fpk" },
	sovietBase_I_AiPod			= { "/Assets/tpp/pack/mission2/animal/sovietBase_I/anml_sovietBase_I_10.fpk" },		
	remnants_NE					= { "/Assets/tpp/pack/mission2/animal/remnants_NE/anml_remnants_NE_00.fpk" },

	bridge_S					= { "/Assets/tpp/pack/mission2/animal/bridge_S/anml_bridge_S_00.fpk" },
	bridge_N					= { "/Assets/tpp/pack/mission2/animal/bridge_N/anml_bridge_N_00.fpk" },
	tent_N						= { "/Assets/tpp/pack/mission2/animal/tent_N/anml_tent_N_00.fpk" },
}


afgh_animal.animalTypeSetting = {
	commFacility_E			= {
								Wolf		= { groupNumber = 1 },
							},
	commFacility_W			= {
								Goat		= { groupNumber = 5 }
							},
	enemyBase_E				= {
								Goat		= { groupNumber = 4 }
							},
	enemyBase_S				= {
								Bear		= { groupNumber = 1 }
							},
	enemyBase_S_BuddyPuppy	= {
								BuddyPuppy	= { groupNumber = 1 }
							},
	field_N					= {
								Goat		= { groupNumber = 5 },
							},
	field_N_BuddyPuppy		= {
								BuddyPuppy	= { groupNumber = 1 }
							},
	remnantsNorth_N			= {
								Goat		= { groupNumber = 4 }
							},
	remnantsNorth_N_s10052	= {
								Goat		= { groupNumber = 1 }
							},
	ruins_N					= {
								Goat		= { groupNumber = 4 }
							},
	ruins_N_BuddyPuppy		= {
								BuddyPuppy	= { groupNumber = 1 },

							},
	ruins_S					= {
								Goat		= { groupNumber = 5 }
							},
	slopedTown_S			= {
								Goat		= { groupNumber = 5 }
							},
	slopedTown_S_RescueSpecial	= {
								NoAnimal	= { groupNumber = 1 }
							},
	village_N				= {
								Goat		= { groupNumber = 4 }
							},
	village_W				= {
								Goat		= { groupNumber = 2 }
							},
	waterway_I				= {
								Goat		= { groupNumber = 1 }
							},
	waterway_I_Quiet		= {
								NoAnimal	= { groupNumber = 1 }
							},
	waterway_I_Child		= {
								Bear		= { groupNumber = 2 }
							},
	powerPlant_S			= {
								Goat		= { groupNumber = 4 },
							},
	cliffTown_NE			= {
								Zebra		= { groupNumber = 4 }
							},
	citadel_S				= {
								Wolf		= { groupNumber = 1 }
							},
	cliffTown_SE			= {
								Bear		= { groupNumber = 1 }
							},
	cliffTown_WS			= {
								Wolf		= { groupNumber = 1 },
							},
	powerPlant_SE			= {
								Wolf		= { groupNumber = 1 },
							 },
	sovietBase_E			= {
								Wolf		= { groupNumber = 1 }
							},
	sovietBase_I			= {
								Wolf		= { groupNumber = 1 }
							},
	sovietBase_I_AiPod		= {
								NoAnimal	= { groupNumber = 1 }
							},
	remnants_NE				= {
								Wolf		= { groupNumber = 1 },
							},
	bridge_S				= {
								Zebra		= { groupNumber = 4 }
							},
	bridge_N				= {
								Zebra		= { groupNumber = 4 }
							},
	tent_N					= {
								Goat		= { groupNumber = 4 },
							},

}



afgh_animal.habitatTable = {
	
	
	
	{ areaName = "commFacility_E",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(1572.077, 367.495, 541.622), radius=5, },			

		},
	},
	{ areaName = "commFacility_W",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(1090.559, 343.381, 550.907), radius=5, },			
		},
	},
	{ areaName = "enemyBase_E",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(-294.032, 330.505, 294.244), radius=6, },			
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_500, iconPos=Vector3(-309.269, 341.626, 262.416), radius=8, },			

		},
	},
	{ areaName = "enemyBase_S",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_600, iconPos=Vector3(-342.726, 321.078, 798.033), radius=5, },			
			
		},
	},
	{ areaName = "field_N",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1920, iconPos=Vector3(588.304, 323.132, 1784.641), radius=7, },			
		},
	},
	{ areaName = "remnantsNorth_N",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(-1342.886, 296.001, 1205.265), radius=5, },		
			
		},
	},
	{ areaName = "ruins_N",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(1270.328, 352.691, 1227.353), radius=7, },			
		},
	},
	{ areaName = "ruins_S",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1920, iconPos=Vector3(1310.198, 315.216, 1903.136), radius=6, },			
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_500, iconPos=Vector3(1310.198, 315.216, 1903.136), radius=8, },			
		},
	},
	{ areaName = "slopedTown_S",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(413.284, 313.532, 178.215), radius=6, },			

		},
	},
	{ areaName = "village_N",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(642.958, 345.206, 846.566), radius=5, },			
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_2240, iconPos=Vector3(751.818, 353.351, 929.483), radius=7, },			


		},
	},
	{ areaName = "village_W",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(87.549, 326.029, 890.241), radius=5, },			
		},
	},
	{ areaName = "waterway_I",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1920, iconPos=Vector3(-1740.180, 349.465, -298.084), radius=7, },		
			
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_2241, iconPos=Vector3(-1740.180, 349.465, -298.084), radius=5, },			
		},
	},
	{ areaName = "powerPlant_S",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(-1108.139, 404.353, -873.506), radius=6, },		
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1430, iconPos=Vector3(-1097.162, 433.826, -985.501), radius=8, },		
		},
	},
	{ areaName = "cliffTown_NE",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_200, iconPos=Vector3(1044.528, 461.581, -1415.157), radius=5, },		
		},
	},
	{ areaName = "citadel_S",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(-1362.906, 543.199, -2548.654), radius=5, },		

		},
	},
	{ areaName = "cliffTown_SE",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_600, iconPos=Vector3(1481.427, 381.846, -226.986), radius=5, },			
			
		},
	},
	{ areaName = "cliffTown_WS",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(371.162, 414.099, -854.827), radius=5, },			

		},
	},
	{ areaName = "powerPlant_SE",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(-385.796, 478.739, -1078.716), radius=5, },		
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1430, iconPos=Vector3(-433.720, 457.531, -862.648), radius=7, },		

		},
	},
	{ areaName = "sovietBase_E",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(-1423.140, 494.969, -1871.319), radius=5, },		

		},
	},
	{ areaName = "sovietBase_I",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(-1948.141, 432.695, -1162.204), radius=5, },		

		},
	},
	{ areaName = "remnants_NE",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_100, iconPos=Vector3(-173.997, 276.592, 1843.571), radius=6, },			
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1300, iconPos=Vector3(-314.876, 283.115, 1853.356), radius=8, },		


		},
	},
	{ areaName = "bridge_S",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_200, iconPos=Vector3(2046.934, 366.790, -193.515), radius=5, },			
		},
	},
	{ areaName = "bridge_N",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_200, iconPos=Vector3(2247.978, 394.752, -1154.267), radius=5, },		
		},
	},
	{ areaName = "tent_N",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1900, iconPos=Vector3(-1873.381, 326.954, 575.254), radius=5, },			
			
		},
	},
	{ areaName = "hagewashi",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1200, iconPos=Vector3(832.0, 482.845, -1088.0), radius=5, },		
		},
	},

	
	{ areaName = "blanford",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_510, iconPos=Vector3(-1597.404, 382.155, -699.864), radius=4, },		
		},
	},
	{ areaName = "caracal",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_1310, iconPos=Vector3(-1366.199, 311.377, 929.335), radius=4, },		
		},
	},
	{ areaName = "ratel",
		areaMembers = {
			{ animalGroupId=TppMotherBaseManagementConst.ANIMAL_2100, iconPos=Vector3(-1332.182, 400.808, -487.316), radius=4, },		
		},
	},
	
}

	
afgh_animal.animalAreaSetting = {
	{
		areaName = "commFacility_E",
		loadArea = {144, 135, 147, 139},	
		activeArea = {145, 136, 146, 138},	
		defines = {
			{
				keyList = { "commFacility_E" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "commFacility_W",
		loadArea = {140, 134, 143, 139},	
		activeArea = {141, 135, 142, 138},	
		defines = {
			{
				keyList = { "commFacility_W" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "enemyBase_E",
		loadArea = {127, 132, 133, 136},	
		activeArea = {128, 133, 132, 135},	
		defines = {
			{
				keyList = { "enemyBase_E" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "enemyBase_S",
		loadArea = {126, 137, 131, 140},	
		activeArea = {127, 138, 130, 139},	
		defines = {
			{
				keyList = { "enemyBase_S_BuddyPuppy" },
				conditionFunc = function()
					return afgh_animal.IsBuddyPuppy()
				end,
			},
			{
				keyList = { "enemyBase_S" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "field_N",
		loadArea = {135, 145, 140, 151},	
		activeArea = {136, 146, 139, 150},	
		defines = {
			{
				keyList = { "field_N_BuddyPuppy" },
				conditionFunc = function()
					return afgh_animal.IsBuddyPuppy()
				end,
			},
			{
				keyList = { "field_N" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "remnantsNorth_N",
		loadArea = {120, 140, 124, 146},	
		activeArea = {121, 141, 123, 145},	
		defines = {
			{
				keyList = { "remnantsNorth_N_s10052" },
				conditionFunc = function()
					return afgh_animal.IsEventOn10052()
				end,
			},
			{
				keyList = { "remnantsNorth_N" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "ruins_N",
		loadArea = {140, 140, 145, 144},	
		activeArea = {141, 141, 144, 143},	
		defines = {
			{
				keyList = { "ruins_N_BuddyPuppy" },
				conditionFunc = function()
					return afgh_animal.IsBuddyPuppy()
				end,
			},
			{
				keyList = { "ruins_N" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "ruins_S",
		loadArea = {141, 145, 145, 150},	
		activeArea = {142, 146, 144, 149},	
		defines = {
			{
				keyList = { "ruins_S" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "slopedTown_S",
		loadArea = {134, 132, 139, 137},	
		activeArea = {135, 133, 138, 136},	
		defines = {
			{
				keyList = { "slopedTown_S_RescueSpecial" },
				conditionFunc = function()
					return afgh_animal.IsRescueSpecial()
				end,
			},
			{
				keyList = { "slopedTown_S" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "village_N",
		loadArea = {136, 138, 139, 141},	
		activeArea = {137, 139, 138, 140},	
		defines = {
			{
				keyList = { "village_N" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "village_W",
		loadArea = {132, 138, 135, 141},	
		activeArea = {133, 139, 134, 140},	
		defines = {
			{
				keyList = { "village_W" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "waterway_I",
		loadArea = {117, 128, 121, 133},	
		activeArea = {118, 129, 120, 132},	
		defines = {
			{
				keyList = { "waterway_I_Child" },
				conditionFunc = function()
					return afgh_animal.IsChild_q20912()
				end,
			},
			{
				keyList = { "waterway_I_Quiet" },
				conditionFunc = function()
					return afgh_animal.IsQuiet()
				end,
			},
			{
				keyList = { "waterway_I" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "powerPlant_S",
		loadArea = {122, 122, 126, 128},	
		activeArea = {123, 123, 125, 127},	
		defines = {
			{
				keyList = { "powerPlant_S" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "cliffTown_NE",
		loadArea = {139, 120, 145, 124},	
		activeArea = {140, 121, 144, 123},	
		defines = {
			{
				keyList = { "cliffTown_NE" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "citadel_S",
		loadArea = {119, 110, 124, 114},	
		activeArea = {120, 111, 123, 113},	
		defines = {
			{
				keyList = { "citadel_S" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "cliffTown_SE",
		loadArea = {140, 127, 145, 133},	
		activeArea = {141, 128, 144, 132},	
		defines = {
			{
				keyList = { "cliffTown_SE" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "cliffTown_WS",
		loadArea = {132, 124, 138, 129},	
		activeArea = {133, 125, 137, 128},	
		defines = {
			{
				keyList = { "cliffTown_WS" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "powerPlant_SE",
		loadArea = {127, 122, 131, 128},	
		activeArea = {128, 123, 130, 127},	
		defines = {
			{
				keyList = { "powerPlant_SE" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "sovietBase_E",
		loadArea = {119, 115, 123, 121},	
		activeArea = {120, 116, 122, 120},	
		defines = {
			{
				keyList = { "sovietBase_E" },
				conditionFunc = nil,		
			},
		},
	},
	{
		areaName = "sovietBase_I",
		loadArea = {111, 115, 118, 125},	
		activeArea = {112, 116, 117, 124},	
		defines = {
			{
				keyList = { "sovietBase_I_AiPod" },
				conditionFunc = function()
					return afgh_animal.IsAiPod()
				end,
			},
			{
				keyList = { "sovietBase_I" },
				conditionFunc = nil,		
			},
		},
	},

	{
		areaName = "remnants_NE",
		loadArea = {125, 143, 134, 151},	
		activeArea = {126, 144, 133, 150},	
		defines = {
			{
				keyList = { "remnants_NE" },
				conditionFunc = nil,		
			},
		},
	},

	{
		areaName = "bridge_S",
		loadArea =	 {146, 129, 151, 133},	
		activeArea = {147, 130, 150, 132},	
		defines = {
			{
				keyList = { "bridge_S" },
				conditionFunc = nil,		
			},
		},
	},

	{
		areaName = "bridge_N",
		loadArea =	 {148, 121, 153, 128},	
		activeArea = {149, 122, 152, 127},	
		defines = {
			{
				keyList = { "bridge_N" },
				conditionFunc = nil,		
			},
		},
	},

	{
		areaName = "tent_N",
		loadArea =	 {116, 135, 121, 139},	
		activeArea = {117, 136, 120, 138},	
		defines = {
			{
				keyList = { "tent_N" },
				conditionFunc = nil,		
			},
		},
	},
}



afgh_animal.captureCageAnimalAreaSetting = {
	{
		areaName = "commFacility_E",
		activeArea = {145, 136, 146, 138},	
	},
	{
		areaName = "commFacility_W",
		activeArea = {141, 135, 142, 138},	
	},
	{
		areaName = "enemyBase_E",
		activeArea = {128, 133, 132, 135},	
	},
	{
		areaName = "enemyBase_S",
		activeArea = {127, 138, 130, 139},	
	},
	{
		areaName = "field_N",
		activeArea = {136, 146, 139, 150},	
	},
	{
		areaName = "remnantsNorth_N",
		activeArea = {121, 141, 123, 145},	
	},
	{
		areaName = "ruins_N",
		activeArea = {141, 141, 144, 143},	
	},
	{
		areaName = "ruins_S",
		activeArea = {142, 146, 144, 149},	
	},
	{
		areaName = "slopedTown_S",
		activeArea = {135, 133, 138, 136},	
	},
	{
		areaName = "village_N",
		activeArea = {137, 139, 138, 140},	
	},
	{
		areaName = "village_W",
		activeArea = {133, 139, 134, 140},	
	},
	{
		areaName = "waterway_I",
		activeArea = {118, 129, 120, 132},	
	},
	{
		areaName = "powerPlant_S",
		activeArea = {123, 123, 125, 127},	
	},
	{
		areaName = "cliffTown_NE",
		activeArea = {140, 121, 144, 123},	
	},
	{
		areaName = "citadel_S",
		activeArea = {120, 111, 123, 113},	
	},
	{
		areaName = "cliffTown_SE",
		activeArea = {141, 128, 144, 132},	
	},
	{
		areaName = "cliffTown_WS",
		activeArea = {133, 125, 137, 128},	
	},
	{
		areaName = "powerPlant_SE",
		activeArea = {128, 123, 130, 127},	
	},
	{
		areaName = "sovietBase_E",
		activeArea = {119, 116, 122, 120},	
	},
	{
		areaName = "sovietBase_I",
		activeArea = {112, 116, 117, 124},	
	},

	{
		areaName = "remnants_NE",
		activeArea = {126, 144, 133, 150},	
	},

	{
		areaName = "bridge_S",
		activeArea = {147, 130, 150, 132},	
	},

	{
		areaName = "bridge_N",
		activeArea = {149, 122, 152, 127},	
	},

	{
		areaName = "tent_N",
		activeArea = {117, 136, 120, 138},	
	},


	{
		areaName = "blanford",
		activeArea = {120, 127, 120, 127},	
	},

	{
		areaName = "caracal",
		activeArea = {122, 140, 122, 140},	
	},

	{
		areaName = "ratel",
		activeArea = {122, 128, 122, 129},	
	},

	{
		areaName = "hagewashi",
		activeArea = {139, 124, 139, 124},	
	},
}


afgh_animal.captureAnimalList = {

	enemyBase_E			= { TppMotherBaseManagementConst.ANIMAL_500},
	ruins_S				= { TppMotherBaseManagementConst.ANIMAL_500},
	village_N				= { TppMotherBaseManagementConst.ANIMAL_2240},
	powerPlant_S			= { TppMotherBaseManagementConst.ANIMAL_1430},
	cliffTown_SE			= { TppMotherBaseManagementConst.ANIMAL_1300},
	powerPlant_SE			= { TppMotherBaseManagementConst.ANIMAL_1430},
	remnants_NE			= { TppMotherBaseManagementConst.ANIMAL_1300},
	waterway_I				= { TppMotherBaseManagementConst.ANIMAL_2241},
	hagewashi				= { TppMotherBaseManagementConst.ANIMAL_1200 },


	wholeArea= {
								TppMotherBaseManagementConst.ANIMAL_400,  	
								TppMotherBaseManagementConst.ANIMAL_700, 	
								TppMotherBaseManagementConst.ANIMAL_800, 	
								TppMotherBaseManagementConst.ANIMAL_1400,  
								TppMotherBaseManagementConst.ANIMAL_1410,  
								TppMotherBaseManagementConst.ANIMAL_1700, 	
								TppMotherBaseManagementConst.ANIMAL_2000, 	
								TppMotherBaseManagementConst.ANIMAL_2200, 	
		},

	blanford				= { TppMotherBaseManagementConst.ANIMAL_510},	
	caracal					= { TppMotherBaseManagementConst.ANIMAL_1310},	
	ratel					= { TppMotherBaseManagementConst.ANIMAL_2100},	

}


afgh_animal.animalRareLevel = {
	[TppMotherBaseManagementConst.ANIMAL_400] = TppMotherBaseManagementConst.ANIMAL_RARE_NR, 
	[TppMotherBaseManagementConst.ANIMAL_500] = TppMotherBaseManagementConst.ANIMAL_RARE_R, 
	[TppMotherBaseManagementConst.ANIMAL_510] = TppMotherBaseManagementConst.ANIMAL_RARE_SR, 
	[TppMotherBaseManagementConst.ANIMAL_700] = TppMotherBaseManagementConst.ANIMAL_RARE_N, 
	[TppMotherBaseManagementConst.ANIMAL_800] = TppMotherBaseManagementConst.ANIMAL_RARE_N, 
	[TppMotherBaseManagementConst.ANIMAL_1200] = TppMotherBaseManagementConst.ANIMAL_RARE_N, 
	[TppMotherBaseManagementConst.ANIMAL_1300] = TppMotherBaseManagementConst.ANIMAL_RARE_R, 
	[TppMotherBaseManagementConst.ANIMAL_1310] = TppMotherBaseManagementConst.ANIMAL_RARE_SR, 
	[TppMotherBaseManagementConst.ANIMAL_1400] = TppMotherBaseManagementConst.ANIMAL_RARE_N, 
	[TppMotherBaseManagementConst.ANIMAL_1410] = TppMotherBaseManagementConst.ANIMAL_RARE_NR, 
	[TppMotherBaseManagementConst.ANIMAL_1430] = TppMotherBaseManagementConst.ANIMAL_RARE_R, 
	[TppMotherBaseManagementConst.ANIMAL_1700] = TppMotherBaseManagementConst.ANIMAL_RARE_NR, 
	[TppMotherBaseManagementConst.ANIMAL_2000] = TppMotherBaseManagementConst.ANIMAL_RARE_N, 
	[TppMotherBaseManagementConst.ANIMAL_2100] = TppMotherBaseManagementConst.ANIMAL_RARE_SR, 
	[TppMotherBaseManagementConst.ANIMAL_2200] = TppMotherBaseManagementConst.ANIMAL_RARE_N, 
	[TppMotherBaseManagementConst.ANIMAL_2240] = TppMotherBaseManagementConst.ANIMAL_RARE_R, 
	[TppMotherBaseManagementConst.ANIMAL_2241] = TppMotherBaseManagementConst.ANIMAL_RARE_NR, 
}


local SOIL_MATERIAL = { CaptureCageMaterial.MTR_SOIL_A, CaptureCageMaterial.MTR_SOIL_B, CaptureCageMaterial.MTR_SOIL_C, CaptureCageMaterial.MTR_SOIL_D, CaptureCageMaterial.MTR_SOIL_E, CaptureCageMaterial.MTR_SOIL_F, CaptureCageMaterial.MTR_SOIL_G, CaptureCageMaterial.MTR_SOIL_H, CaptureCageMaterial.MTR_SOIL_R, CaptureCageMaterial.MTR_SOIL_W }
afgh_animal.animalMaterial = {
	[TppMotherBaseManagementConst.ANIMAL_1410]	= SOIL_MATERIAL, 
	[TppMotherBaseManagementConst.ANIMAL_1430]	= { CaptureCageMaterial.MTR_ROCK_B, CaptureCageMaterial.MTR_SOIL_B, CaptureCageMaterial.MTR_GRAV_A }, 
	[TppMotherBaseManagementConst.ANIMAL_2200]	= SOIL_MATERIAL, 
	[TppMotherBaseManagementConst.ANIMAL_2240]	= { CaptureCageMaterial.MTR_SOIL_B, CaptureCageMaterial.MTR_SOIL_C, CaptureCageMaterial.MTR_GRAV_A }, 
	[TppMotherBaseManagementConst.ANIMAL_2241]	= { CaptureCageMaterial.MTR_SOIL_C, CaptureCageMaterial.MTR_SOIL_D }, 
	[TppMotherBaseManagementConst.ANIMAL_800]	= { CaptureCageMaterial.MTR_GRAV_A }, 
	[TppMotherBaseManagementConst.ANIMAL_1700]	= { CaptureCageMaterial.MTR_SOIL_B }, 
	[TppMotherBaseManagementConst.ANIMAL_2000]	= { CaptureCageMaterial.MTR_SOIL_B, CaptureCageMaterial.MTR_GRAV_A }, 
	[TppMotherBaseManagementConst.ANIMAL_400]	= { CaptureCageMaterial.MTR_SAND_C }, 
	[TppMotherBaseManagementConst.ANIMAL_1300]	= { CaptureCageMaterial.MTR_SAND_C }, 
	[TppMotherBaseManagementConst.ANIMAL_1310]	= { CaptureCageMaterial.MTR_SOIL_B, CaptureCageMaterial.MTR_GRAV_A, CaptureCageMaterial.MTR_ROCK_B }, 
	[TppMotherBaseManagementConst.ANIMAL_500]	= { CaptureCageMaterial.MTR_GRAV_A, CaptureCageMaterial.MTR_SOIL_B }, 
	[TppMotherBaseManagementConst.ANIMAL_510]	= { CaptureCageMaterial.MTR_ROCK_B }, 
	[TppMotherBaseManagementConst.ANIMAL_2100]	= { CaptureCageMaterial.MTR_GRAV_A, CaptureCageMaterial.MTR_SOIL_B }, 
}


afgh_animal.animalInfoList = {
	[TppMotherBaseManagementConst.ANIMAL_400]  = { name="YOTSUYUBIRIKUGAME" },
	[TppMotherBaseManagementConst.ANIMAL_500]  = { name="AKAGITSUNE" },
	[TppMotherBaseManagementConst.ANIMAL_510]  = { name="BURANNFO-DOGITSUNE" },
	[TppMotherBaseManagementConst.ANIMAL_700]  = { name="BEHISHUTAINNHOOHIGEKOUMORI" },
	[TppMotherBaseManagementConst.ANIMAL_800]  = { name="OBUTOSASORI" },
	[TppMotherBaseManagementConst.ANIMAL_1200] = { name="SHIROERIHAGEWASHI" },
	[TppMotherBaseManagementConst.ANIMAL_1300] = { name="SUNANEKO" },
	[TppMotherBaseManagementConst.ANIMAL_1310] = { name="KARAKARU" },
	[TppMotherBaseManagementConst.ANIMAL_1400] = { name="ARECHINEZUMI" },
	[TppMotherBaseManagementConst.ANIMAL_1410] = { name="OOMIMIHARINEZUMI" },
	[TppMotherBaseManagementConst.ANIMAL_1430] = { name="AFUGANNNAKIUSAGI" },
	[TppMotherBaseManagementConst.ANIMAL_1700] = { name="NANNDA" },
	[TppMotherBaseManagementConst.ANIMAL_2000] = { name="HYOUMONNTOKAGEMODOKI" },
	[TppMotherBaseManagementConst.ANIMAL_2100] = { name="RA-TERU" },
	[TppMotherBaseManagementConst.ANIMAL_2200] = { name="WATARIGARASU" },
	[TppMotherBaseManagementConst.ANIMAL_2240] = { name="NABEKOU" },
	[TppMotherBaseManagementConst.ANIMAL_2241] = { name="KOUNOTORI" },
}




function afgh_animal.OnAllocate()
	mvars.loc_locationAnimalSettingTable = afgh_animal
	TppScriptBlock.RegisterCommonBlockPackList( "animal_block", afgh_animal.animalBlockPackList )
end




function afgh_animal.OnMissionCanStart()
	
	TppMotherBaseManagement.RegisterDataBaseAnimalHabitat{
		locationId = TppDefine.LOCATION_ID.AFGH,
		areas = afgh_animal.habitatTable,
		wholeAreaMembers = afgh_animal.captureAnimalList.wholeArea,
	}

	
	local blockId = ScriptBlock.GetScriptBlockId("animal_block")
	if blockId == ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
		return
	end

	Fox.Log("animal block is exist. animal block load message setting activate.")

	afgh_animal.Messages = function()
		return
		Tpp.StrCode32Table{
			Block = {
				{
					msg = "StageBlockCurrentSmallBlockIndexUpdated",
					func = function( x, y )
						TppAnimalBlock.UpdateLoadAnimalBlock( x, y )
					end,
				},
			},
		}
	end

	afgh_animal.messageExecTable = Tpp.MakeMessageExecTable( afgh_animal.Messages() )

	afgh_animal.OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
		Tpp.DoMessage( afgh_animal.messageExecTable,TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText)
	end

	afgh_animal.MAX_AREA_NUM = #afgh_animal.animalAreaSetting

	
	local x, y = Tpp.GetCurrentStageSmallBlockIndex()
	TppAnimalBlock.UpdateLoadAnimalBlock( x, y )

	if DEBUG then
		mvars.debug_currentBlock = {}
	end
end





afgh_animal.IsBuddyPuppy = function()
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	if ( currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARD_TO_MATHER_BASE ) then
		return false
	end
	if TppBuddyService.IsDeadBuddyType(BuddyType.DOG) then
		Fox.Log("Buddy puppy is dead. New buddy puppy appear.")
		return true
	end
	if TppBuddyService.DidObtainBuddyType(BuddyType.DOG) == false then
		Fox.Log("Buddy puppy is not obtained. First buddy puppy appear.")
		return true
	end
	return false
end




afgh_animal.IsRescueSpecial = function()
	local isActive = TppQuest.IsActive( "cliffTown_q99080" )
	local currentQuestname = TppQuest.GetCurrentQuestName()
	
	if isActive == true or currentQuestname == "cliffTown_q99080" then
		return true
	end
	return false
end





afgh_animal.IsAiPod = function()
	local isActive = TppQuest.IsActive( "sovietBase_q99030" )
	local currentQuestname = TppQuest.GetCurrentQuestName()
	
	if isActive == true or currentQuestname == "sovietBase_q99030" then
		return true
	end
	return false
end





afgh_animal.IsQuiet = function()
	local isActive = TppQuest.IsActive( "waterway_q99010" )
	local currentQuestname = TppQuest.GetCurrentQuestName()
	
	if isActive == true or currentQuestname == "waterway_q99010" then
		return true
	end
	return false
end




afgh_animal.IsChild_q20912 = function()
	local isActive = TppQuest.IsActive( "sovietBase_q20912" )
	local currentQuestname = TppQuest.GetCurrentQuestName()
	
	if isActive == true or currentQuestname == "sovietBase_q20912" then
		return true
	end
	return false
end





afgh_animal.IsEventOn10052 = function()
	local isActive = TppMission.GetMissionID()
	if isActive == 10052 then
		return true
	end
	return false
end


return afgh_animal