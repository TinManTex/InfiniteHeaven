local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionEnemy.CreateInstance( "c20310" )




this.spawnSettingTable = {
	SpawnPoint_A_0000_n1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_A_0000_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_d1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_d2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_m1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_m2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n4 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n3_i1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0000_n3_b1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_b4 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n6 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n4_b2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n5_f1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_A_0000_n5_i1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0000_n5_b1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n8 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", "rt_SpawnPoint_A_0000_0002", "rt_SpawnPoint_A_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n6_b2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", "rt_SpawnPoint_A_0000_0002", "rt_SpawnPoint_A_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_n6_i2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_0000", "rt_SpawnPoint_A_0000_0001", "rt_SpawnPoint_A_0000_0002", "rt_SpawnPoint_A_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0000_s1 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_s2 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_s4 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_s8 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_c1 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_c2 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_c4 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0000_c8 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 8, radius = 2.0, groupId = 1, },
		},
	},

	SpawnPoint_A_0001_n1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_A_0001_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_d1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_d2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_m1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_m2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n4 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n3_e1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, typeEX = "Elec", },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n3_i1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0001_n3_b1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_b4 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n6 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n4_b2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n5_i1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0001_n5_e1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_A_0001_n5_b1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n8 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", "rt_SpawnPoint_A_0001_0002", "rt_SpawnPoint_A_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n6_b2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", "rt_SpawnPoint_A_0001_0002", "rt_SpawnPoint_A_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0001_n6_i2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_0000", "rt_SpawnPoint_A_0001_0001", "rt_SpawnPoint_A_0001_0002", "rt_SpawnPoint_A_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},

	SpawnPoint_A_0002_n1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_A_0002_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_h2 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_d1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_d2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_m1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_m2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n4 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n3_i1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0002_n3_b1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_b4 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n6 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n4_b2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n5_i1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0002_n5_e1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_A_0002_n5_b1 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n8 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", "rt_SpawnPoint_A_0002_0002", "rt_SpawnPoint_A_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n6_b2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", "rt_SpawnPoint_A_0002_0002", "rt_SpawnPoint_A_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_A_0002_n6_f2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", "rt_SpawnPoint_A_0002_0002", "rt_SpawnPoint_A_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_A_0002_n6_i2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", "rt_SpawnPoint_A_0002_0002", "rt_SpawnPoint_A_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_A_0002_n6_e2 = {	
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_0000", "rt_SpawnPoint_A_0002_0001", "rt_SpawnPoint_A_0002_0002", "rt_SpawnPoint_A_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_B_0000_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_h2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_B_0000_b4 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000",},
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000",},
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n3_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_B_0000_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n5_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_B_0000_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_B_0000_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n5_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", "rt_SpawnPoint_B_0000_0002", "rt_SpawnPoint_B_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", "rt_SpawnPoint_B_0000_0002", "rt_SpawnPoint_B_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", "rt_SpawnPoint_B_0000_0002", "rt_SpawnPoint_B_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_B_0000_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", "rt_SpawnPoint_B_0000_0002", "rt_SpawnPoint_B_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_B_0000_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_0000", "rt_SpawnPoint_B_0000_0001", "rt_SpawnPoint_B_0000_0002", "rt_SpawnPoint_B_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_B_0000_s1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_s2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_s4 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_s8 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_c1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_c2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_c4 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0000_c8 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 8, radius = 2.0, groupId = 1, },
		},
	},

	SpawnPoint_B_0001_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001",},
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001",},
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_B_0001_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", "rt_SpawnPoint_B_0001_0002", "rt_SpawnPoint_B_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", "rt_SpawnPoint_B_0001_0002", "rt_SpawnPoint_B_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0001_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_0000", "rt_SpawnPoint_B_0001_0001", "rt_SpawnPoint_B_0001_0002", "rt_SpawnPoint_B_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_B_0002_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002",},
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002",},
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_B_0002_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", "rt_SpawnPoint_B_0002_0002", "rt_SpawnPoint_B_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", "rt_SpawnPoint_B_0002_0002", "rt_SpawnPoint_B_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_B_0002_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", "rt_SpawnPoint_B_0002_0002", "rt_SpawnPoint_B_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_B_0002_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_0000", "rt_SpawnPoint_B_0002_0001", "rt_SpawnPoint_B_0002_0002", "rt_SpawnPoint_B_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_C_0000_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1,},
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0000_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0000_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0000_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0000_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n5_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", "rt_SpawnPoint_C_0000_0002", "rt_SpawnPoint_C_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", "rt_SpawnPoint_C_0000_0002", "rt_SpawnPoint_C_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0000_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", "rt_SpawnPoint_C_0000_0002", "rt_SpawnPoint_C_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0000_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", "rt_SpawnPoint_C_0000_0002", "rt_SpawnPoint_C_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_C_0000_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_0000", "rt_SpawnPoint_C_0000_0001", "rt_SpawnPoint_C_0000_0002", "rt_SpawnPoint_C_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1,  },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0000_s1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 1, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_s2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 2, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_s4 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 4, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_s8 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 8, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_c1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 1, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_c2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 2, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_c4 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 4, radius = 2.0, groupId = 1,  },
		},
	},
	SpawnPoint_C_0000_c8 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 8, radius = 2.0, groupId = 1,  },
		},
	},

	SpawnPoint_C_0001_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0001_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0001_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0001_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0001_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n5_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", "rt_SpawnPoint_C_0001_0002", "rt_SpawnPoint_C_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", "rt_SpawnPoint_C_0001_0002", "rt_SpawnPoint_C_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0001_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", "rt_SpawnPoint_C_0001_0002", "rt_SpawnPoint_C_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0001_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_0000", "rt_SpawnPoint_C_0001_0001", "rt_SpawnPoint_C_0001_0002", "rt_SpawnPoint_C_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_C_0002_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_h2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0002_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0002_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0002_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0002_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n5_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", "rt_SpawnPoint_C_0002_0002", "rt_SpawnPoint_C_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0002_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", "rt_SpawnPoint_C_0002_0002", "rt_SpawnPoint_C_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0002_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_0000", "rt_SpawnPoint_C_0002_0001", "rt_SpawnPoint_C_0002_0002", "rt_SpawnPoint_C_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_C_0003_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0003_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0003_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0003_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_C_0003_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n5_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", "rt_SpawnPoint_C_0003_0002", "rt_SpawnPoint_C_0003_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", "rt_SpawnPoint_C_0003_0002", "rt_SpawnPoint_C_0003_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_C_0003_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", "rt_SpawnPoint_C_0003_0002", "rt_SpawnPoint_C_0003_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_C_0003_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_0000", "rt_SpawnPoint_C_0003_0001", "rt_SpawnPoint_C_0003_0002", "rt_SpawnPoint_C_0003_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_D_0000_n1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_D_0000_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n3_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0000_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_b4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n5_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0000_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", "rt_SpawnPoint_D_0000_0002", "rt_SpawnPoint_D_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", "rt_SpawnPoint_D_0000_0002", "rt_SpawnPoint_D_0000_0003",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", route = { "rt_SpawnPoint_D_0000_0000", "rt_SpawnPoint_D_0000_0001", "rt_SpawnPoint_D_0000_0002", "rt_SpawnPoint_D_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0000_s1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_s2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_s4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_s8 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_c1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_c2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_c4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0000_c8 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 8, radius = 2.0, groupId = 1, },
		},
	},

	SpawnPoint_D_0001_n1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_D_0001_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_h1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_D_0001_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n3_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0001_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_b4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n5_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0001_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", "rt_SpawnPoint_D_0001_0002", "rt_SpawnPoint_D_0001_0003", "rt_SpawnPoint_D_0001_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", "rt_SpawnPoint_D_0001_0002", "rt_SpawnPoint_D_0001_0003", "rt_SpawnPoint_D_0001_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0001_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0001", route = { "rt_SpawnPoint_D_0001_0000", "rt_SpawnPoint_D_0001_0001", "rt_SpawnPoint_D_0001_0002", "rt_SpawnPoint_D_0001_0003", "rt_SpawnPoint_D_0001_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},

	SpawnPoint_D_0002_n1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_D_0002_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n3_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0002_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_b4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n5_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0002_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", "rt_SpawnPoint_D_0002_0002", "rt_SpawnPoint_D_0002_0003", "rt_SpawnPoint_D_0002_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", "rt_SpawnPoint_D_0002_0002", "rt_SpawnPoint_D_0002_0003", "rt_SpawnPoint_D_0002_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0002_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0002", route = { "rt_SpawnPoint_D_0002_0000", "rt_SpawnPoint_D_0002_0001", "rt_SpawnPoint_D_0002_0002", "rt_SpawnPoint_D_0002_0003", "rt_SpawnPoint_D_0002_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},

	SpawnPoint_D_0003_n1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_D_0003_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n3_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0003_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_b4 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n5_i1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_D_0003_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", "rt_SpawnPoint_D_0003_0002", "rt_SpawnPoint_D_0003_0003", "rt_SpawnPoint_D_0003_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", "rt_SpawnPoint_D_0003_0002", "rt_SpawnPoint_D_0003_0003", "rt_SpawnPoint_D_0003_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_D_0003_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_D_0003", route = { "rt_SpawnPoint_D_0003_0000", "rt_SpawnPoint_D_0003_0001", "rt_SpawnPoint_D_0003_0002", "rt_SpawnPoint_D_0003_0003", "rt_SpawnPoint_D_0003_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},

	SpawnPoint_E_0000_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0000_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0000_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0000_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0000_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", "rt_SpawnPoint_E_0000_0002", "rt_SpawnPoint_E_0000_0003", "rt_SpawnPoint_E_0000_0004", "rt_SpawnPoint_E_0000_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", "rt_SpawnPoint_E_0000_0002", "rt_SpawnPoint_E_0000_0003", "rt_SpawnPoint_E_0000_0004", "rt_SpawnPoint_E_0000_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", "rt_SpawnPoint_E_0000_0002", "rt_SpawnPoint_E_0000_0003", "rt_SpawnPoint_E_0000_0004", "rt_SpawnPoint_E_0000_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0000_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", route = { "rt_SpawnPoint_E_0000_0000", "rt_SpawnPoint_E_0000_0001", "rt_SpawnPoint_E_0000_0002", "rt_SpawnPoint_E_0000_0003", "rt_SpawnPoint_E_0000_0004", "rt_SpawnPoint_E_0000_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0000_s1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_s2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_s4 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_s8 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_c1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_c2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_c4 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0000_c8 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 8, radius = 2.0, groupId = 1, },
		},
	},

	SpawnPoint_E_0001_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0001_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0001_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0001_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0001_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", "rt_SpawnPoint_E_0001_0002", "rt_SpawnPoint_E_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", "rt_SpawnPoint_E_0001_0002", "rt_SpawnPoint_E_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", "rt_SpawnPoint_E_0001_0002", "rt_SpawnPoint_E_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0001_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", "rt_SpawnPoint_E_0001_0002", "rt_SpawnPoint_E_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 7, radius = 2.0, groupId = 1,},
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0001_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0001", route = { "rt_SpawnPoint_E_0001_0000", "rt_SpawnPoint_E_0001_0001", "rt_SpawnPoint_E_0001_0002", "rt_SpawnPoint_E_0001_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 7, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_E_0002_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0002_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0002_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0002_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0002_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", "rt_SpawnPoint_E_0002_0002", "rt_SpawnPoint_E_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", "rt_SpawnPoint_E_0002_0002", "rt_SpawnPoint_E_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0002_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", "rt_SpawnPoint_E_0002_0002", "rt_SpawnPoint_E_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0002_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0002", route = { "rt_SpawnPoint_E_0002_0000", "rt_SpawnPoint_E_0002_0001", "rt_SpawnPoint_E_0002_0002", "rt_SpawnPoint_E_0002_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_E_0003_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_d2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_m1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_m2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0003_n3_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0003_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n3_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0003_n5_e1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_E_0003_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", "rt_SpawnPoint_E_0003_0002", "rt_SpawnPoint_E_0003_0003", "rt_SpawnPoint_E_0003_0004", "rt_SpawnPoint_E_0003_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", "rt_SpawnPoint_E_0003_0002", "rt_SpawnPoint_E_0003_0003", "rt_SpawnPoint_E_0003_0004", "rt_SpawnPoint_E_0003_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_E_0003_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", "rt_SpawnPoint_E_0003_0002", "rt_SpawnPoint_E_0003_0003", "rt_SpawnPoint_E_0003_0004", "rt_SpawnPoint_E_0003_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_E_0003_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_E_0003", route = { "rt_SpawnPoint_E_0003_0000", "rt_SpawnPoint_E_0003_0001", "rt_SpawnPoint_E_0003_0002", "rt_SpawnPoint_E_0003_0003", "rt_SpawnPoint_E_0003_0004", "rt_SpawnPoint_E_0003_0005",  }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},

	SpawnPoint_F_0000_n1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, level = 10, },
		},
	},
	SpawnPoint_F_0000_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_h2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_ARMOR, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n4 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n3_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_F_0000_n3_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 3, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n6 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n5_f1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_F_0000_n5_b1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n4_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n5_d1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 5, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n8 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", "rt_SpawnPoint_F_0000_0002", "rt_SpawnPoint_F_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n6_b2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", "rt_SpawnPoint_F_0000_0002", "rt_SpawnPoint_F_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_n6_f2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", "rt_SpawnPoint_F_0000_0002", "rt_SpawnPoint_F_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 1, typeEX = "Fire", },
		},
	},
	SpawnPoint_F_0000_n6_i2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", "rt_SpawnPoint_F_0000_0002", "rt_SpawnPoint_F_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Ice", },
		},
	},
	SpawnPoint_F_0000_n6_e2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", route = { "rt_SpawnPoint_F_0000_0000", "rt_SpawnPoint_F_0000_0001", "rt_SpawnPoint_F_0000_0002", "rt_SpawnPoint_F_0000_0003", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 2.0, groupId = 1, },
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 2.0, groupId = 1, typeEX = "Elec", },
		},
	},
	SpawnPoint_F_0000_s1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_s2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_s4 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_s8 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_2, count = 8, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_c1 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 1, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_c2 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 2, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_c4 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 4, radius = 2.0, groupId = 1, },
		},
	},
	SpawnPoint_F_0000_c8 = {
		locatorSet = { spawnLocator = "SpawnPoint_F_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_INSECT_1, count = 8, radius = 2.0, groupId = 1, },
		},
	},

	
	SpawnPoint_StealthArea_n2_0 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 1, radius = 2.0, groupId = 2, isStealth = 1, level = 10, },
		},
	},
	SpawnPoint_StealthArea_n4_1 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0001", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.0, groupId = 2, isStealth = 1, level = 10, },
		},
	},
	SpawnPoint_StealthArea_n8_2 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0002", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 2.0, groupId = 2, isStealth = 1, level = 5, },
		},
	},
	SpawnPoint_StealthArea_b1_3 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 2, isStealth = 1, level = 5, },
		},
	},
	SpawnPoint_StealthArea_b1_4 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0004", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 1, radius = 2.0, groupId = 2, isStealth = 1, level = 5, },
		},
	},
	SpawnPoint_StealthArea_b2_3 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0003", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 2, isStealth = 1, level = 5, },
		},
	},
	SpawnPoint_StealthArea_b2_4 = {
		locatorSet = { spawnLocator = "SpawnPoint_StealthArea0004", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM, count = 2, radius = 2.0, groupId = 2, isStealth = 1, level = 5, },
		},
	},
}

this.waveSettingTable = {
	
	wave_01 =		{ type = "none",	spawnTableName = "SpawnPoint_A_0000_n4",					nextWave = "wave_01_01", },
	wave_01_01 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n4",	waitTime = 1.0,	nextWave = "wave_01_02", },
	wave_01_02 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n4",		waitTime = 1.0,	nextWave = "wave_01_03", },
	wave_01_03 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",	waitTime = 30.0,	nextWave = "wave_01_04", },
	wave_01_04 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",	waitTime = 1.0,	nextWave = "wave_01_05", },
	wave_01_05 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n6",		waitTime = 1.0,	nextWave = "wave_01_06", },
	wave_01_06 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n4",	waitTime = 60.0,	nextWave = "wave_01_01", endLoop = true, },

	
	wave_02 =		{ type = "none", spawnTableName = "SpawnPoint_C_0000_n4",					nextWave = "wave_02_01", },
	wave_02_01 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n4",		waitTime = 1.0,	nextWave = "wave_02_02", },
	wave_02_02 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n4",	waitTime = 1.0,	nextWave = "wave_02_03", },
	wave_02_03 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n4",		waitTime = 1.0,	nextWave = "wave_02_04", },
	wave_02_04 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n4",	waitTime = 29.0,	nextWave = "wave_02_05", },
	wave_02_05 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n6",		waitTime = 1.0,	nextWave = "wave_02_06", },
	wave_02_06 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n6",	waitTime = 1.0,	nextWave = "wave_02_07", },
	wave_02_07 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n6",		waitTime = 1.0,	nextWave = "wave_02_08", },
	wave_02_08 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n4",	waitTime = 58.0,	nextWave = "wave_02_01", endLoop = true, },

	
	wave_03 =		{ type = "none",	spawnTableName = "SpawnPoint_D_0000_n4",						nextWave = "wave_03_01", },
	wave_03_01 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n3_b1",	waitTime = 1.0,	nextWave = "wave_03_02", },
	wave_03_02 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 1.0,	nextWave = "wave_03_03", },
	wave_03_03 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n4",		waitTime = 1.0,	nextWave = "wave_03_04", },
	wave_03_04 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 1.0,	nextWave = "wave_03_05", },
	wave_03_05 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",		waitTime = 28.0,	nextWave = "wave_03_06", },
	wave_03_06 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n6",		waitTime = 1.0,	nextWave = "wave_03_07", },
	wave_03_07 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",		waitTime = 1.0,	nextWave = "wave_03_08", },
	wave_03_08 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n6",		waitTime = 1.0,	nextWave = "wave_03_09", },
	wave_03_09 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",		waitTime = 1.0,	nextWave = "wave_03_10", },
	wave_03_10 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 56.0,	nextWave = "wave_03_01", endLoop = true, },

	
	wave_04 =		{ type = "none",	spawnTableName = "SpawnPoint_B_0000_n4",						nextWave = "wave_04_01", },
	wave_04_01 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n3_b1",		waitTime = 1.0,	nextWave = "wave_04_02", },
	wave_04_02 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n4",	waitTime = 1.0,	nextWave = "wave_04_03", },
	wave_04_03 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n4",			waitTime = 1.0,	nextWave = "wave_04_04", },
	wave_04_04 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n4",			waitTime = 1.0,	nextWave = "wave_04_05", },
	wave_04_05 =	{ type = "auto",	spawnTableName = "SpawnPoint_C_0000_n4",			waitTime = 1.0,	nextWave = "wave_04_06", },
	wave_04_06 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n6",		waitTime = 27.0,	nextWave = "wave_04_07", },
	wave_04_07 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n6",			waitTime = 1.0,	nextWave = "wave_04_08", },
	wave_04_08 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",		waitTime = 1.0,	nextWave = "wave_04_09", },
	wave_04_09 =	{ type = "auto",	spawnTableName = "SpawnPoint_A_0000_n6",			waitTime = 1.0,	nextWave = "wave_04_10", },
	wave_04_10 =	{ type = "auto",	spawnTableName = "SpawnPoint_F_0000_n5_b1",			waitTime = 1.0,	nextWave = "wave_04_11", },
	wave_04_11 =	{ type = "auto",	spawnTableName = "SpawnPoint_F_0000_n6",			waitTime = 1.0,	nextWave = "wave_04_12", },
	wave_04_12 =	{ type = "auto",	spawnTableName = "SpawnPoint_B_0000_n4",		waitTime = 54.0,	nextWave = "wave_04_01", endLoop = true, },

	
	wave_05 =		{ type = "none",	spawnTableName = "SpawnPoint_E_0000_n4",						nextWave = "wave_05_01", },
	wave_05_01 =	{ type = "auto",	spawnTableName = "SpawnPoint_E_0000_n3_b1",		waitTime = 1.0,	nextWave = "wave_05_02", },
	wave_05_02 =	{ type = "auto",	spawnTableName = "SpawnPoint_E_0000_n3_b1",	waitTime = 1.0,	nextWave = "wave_05_03", },
	wave_05_03 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 1.0,	nextWave = "wave_05_04", },
	wave_05_04 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 1.0,	nextWave = "wave_05_05", },
	wave_05_05 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",			waitTime = 1.0,	nextWave = "wave_05_06", },
	wave_05_06 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 1.0,	nextWave = "wave_05_07", },
	wave_05_07 =	{ type = "auto",	spawnTableName = "SpawnPoint_E_0000_n6",	waitTime = 26.0,	nextWave = "wave_05_08", },
	wave_05_08 =	{ type = "auto",	spawnTableName = "SpawnPoint_E_0000_n6",			waitTime = 1.0,	nextWave = "wave_05_09", },
	wave_05_09 =	{ type = "auto",	spawnTableName = "SpawnPoint_E_0000_n6",		waitTime = 1.0,	nextWave = "wave_05_10", },
	wave_05_10 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n6",			waitTime = 1.0,	nextWave = "wave_05_11", },
	wave_05_11 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n6",		waitTime = 1.0,	nextWave = "wave_05_12", },
	wave_05_12 =	{ type = "auto",	spawnTableName = "SpawnPoint_F_0000_n5_b1",		waitTime = 1.0,	nextWave = "wave_05_13", },
	wave_05_13 =	{ type = "auto",	spawnTableName = "SpawnPoint_F_0000_n6",			waitTime = 1.0,	nextWave = "wave_05_14", },
	wave_05_14 =	{ type = "auto",	spawnTableName = "SpawnPoint_D_0000_n4",		waitTime = 52.0,	nextWave = "wave_05_01", endLoop = true, },
}




this.routeSettingTableList = {
}




this.lookTargetSettingTableList = {
}

this.enemyLevelSettingTable = {
	missionLevel = 35,
}


this.stealthAreaWaveTableList = {
}




this.mapRouteNameListTable = {
}




this.dropInstanceCountSettingTableList = {
	{	
		typeName = "SsdBoss3",
		count = 1,
	},
	{	
		typeName = "SsdZombie",
		count = 8,
	},
	{	
		typeName = "SsdZombieBom",
		count = 2,
	},
	{	
		typeName = "SsdZombieArmor",
		count = 4,
	},
	{	
		typeName = "SsdZombieDash",
		count = 2,
	},
	{	
		typeName = "SsdZombieShell",
		count = 2,
	},
}

return this
