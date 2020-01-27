local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionEnemy.CreateInstance( "c20510" )




this.spawnSettingTable = {
	
	spawn_A_0000_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0000", route = { "rt_SpawnPoint_A_0000_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_A_0001_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0001", route = { "rt_SpawnPoint_A_0001_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_A_0002_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0002", route = { "rt_SpawnPoint_A_0002_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_A_0003_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_A_0003", route = { "rt_SpawnPoint_A_0003_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	
	spawn_B_0000_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0000", route = { "rt_SpawnPoint_B_0000_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_B_0001_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0001", route = { "rt_SpawnPoint_B_0001_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_B_0002_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0002", route = { "rt_SpawnPoint_B_0002_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_B_0003_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_B_0003", route = { "rt_SpawnPoint_B_0003_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	
	spawn_C_0000_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0000", route = { "rt_SpawnPoint_C_0000_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_C_0001_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0001", route = { "rt_SpawnPoint_C_0001_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_C_0002_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0002", route = { "rt_SpawnPoint_C_0002_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
	spawn_C_0003_ZOMBIE_04 = {
		locatorSet = { spawnLocator = "SpawnPoint_C_0003", route = { "rt_SpawnPoint_C_0003_zmb_0000" }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 2.5, groupId = 1, },
		},
	},
}

this.waveSettingTable = {
	
	wave_01_01 = { type = "none",	spawnTableName = "spawn_A_0000_ZOMBIE_04",							nextWave = "wave_01_02", },
	wave_01_02 = { type = "auto",	spawnTableName = "spawn_A_0001_ZOMBIE_04",		waitTime =  2.0,	nextWave = "wave_01_03", },
	wave_01_03 = { type = "auto",	spawnTableName = "spawn_A_0002_ZOMBIE_04",		waitTime =  2.0,	nextWave = "wave_01_04", },
	wave_01_04 = { type = "auto",	spawnTableName = "spawn_A_0003_ZOMBIE_04",		waitTime =  2.0,	nextWave = "wave_01_05", },
	wave_01_05 = { type = "auto",	spawnTableName = "spawn_A_0000_ZOMBIE_04",		waitTime = 15.0,	nextWave = "wave_01_06", },
	wave_01_06 = { type = "auto",	spawnTableName = "spawn_A_0001_ZOMBIE_04",		waitTime =  2.0,	nextWave = "wave_01_07", },
	wave_01_07 = { type = "auto",	spawnTableName = "spawn_A_0002_ZOMBIE_04",		waitTime =  2.0,	nextWave = "wave_01_08", },
	wave_01_08 = { type = "auto",	spawnTableName = "spawn_A_0003_ZOMBIE_04",		waitTime =  2.0,	nextWave = "wave_01_05",	endLoop = true, },
	
	
	wave_02_01 = { type = "none",	spawnTableName = "spawn_B_0000_ZOMBIE_04",							nextWave = "wave_02_02", },
	wave_02_02 = { type = "auto",	spawnTableName = "spawn_B_0001_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_02_03", },
	wave_02_03 = { type = "auto",	spawnTableName = "spawn_B_0002_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_02_04", },
	wave_02_04 = { type = "auto",	spawnTableName = "spawn_B_0003_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_02_05", },
	wave_02_05 = { type = "auto",	spawnTableName = "spawn_B_0000_ZOMBIE_04",		waitTime = 15.0,	nextWave = "wave_02_06", },
	wave_02_06 = { type = "auto",	spawnTableName = "spawn_B_0001_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_02_07", },
	wave_02_07 = { type = "auto",	spawnTableName = "spawn_B_0002_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_02_08", },
	wave_02_08 = { type = "auto",	spawnTableName = "spawn_B_0003_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_02_05",	endLoop = true, },
	
	
	wave_03_01 = { type = "none",	spawnTableName = "spawn_C_0000_ZOMBIE_04",							nextWave = "wave_03_02", },
	wave_03_02 = { type = "auto",	spawnTableName = "spawn_C_0001_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_03_03", },
	wave_03_03 = { type = "auto",	spawnTableName = "spawn_C_0002_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_03_04", },
	wave_03_04 = { type = "auto",	spawnTableName = "spawn_C_0003_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_03_05", },
	wave_03_05 = { type = "auto",	spawnTableName = "spawn_C_0000_ZOMBIE_04",		waitTime = 15.0,	nextWave = "wave_03_06", },
	wave_03_06 = { type = "auto",	spawnTableName = "spawn_C_0001_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_03_07", },
	wave_03_07 = { type = "auto",	spawnTableName = "spawn_C_0002_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_03_08", },
	wave_03_08 = { type = "auto",	spawnTableName = "spawn_C_0003_ZOMBIE_04",		waitTime =  5.0,	nextWave = "wave_03_05",	endLoop = true, },

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
	
	rt_SpawnPoint_A_0000_zmb_0000 = {
		"rt_SpawnPoint_A_0000_zmb_0000",
	},
	
	rt_SpawnPoint_A_0001_zmb_0000 = {
		"rt_SpawnPoint_A_0001_zmb_0000",
	},
	
	rt_SpawnPoint_A_0002_zmb_0000 = {
		"rt_SpawnPoint_A_0002_zmb_0000",
	},
	
	rt_SpawnPoint_A_0003_zmb_0000 = {
		"rt_SpawnPoint_A_0003_zmb_0000",
	},
	
	rt_SpawnPoint_B_0000_zmb_0000 = {
		"rt_SpawnPoint_B_0000_zmb_0000",
	},
	
	rt_SpawnPoint_B_0001_zmb_0000 = {
		"rt_SpawnPoint_B_0001_zmb_0000",
	},
	
	rt_SpawnPoint_B_0002_zmb_0000 = {
		"rt_SpawnPoint_B_0002_zmb_0000",
	},
	
	rt_SpawnPoint_B_0003_zmb_0000 = {
		"rt_SpawnPoint_B_0003_zmb_0000",
	},
	
	rt_SpawnPoint_C_0000_zmb_0000 = {
		"rt_SpawnPoint_C_0000_zmb_0000",
	},
	
	rt_SpawnPoint_C_0001_zmb_0000 = {
		"rt_SpawnPoint_C_0001_zmb_0000",
	},
	
	rt_SpawnPoint_C_0002_zmb_0000 = {
		"rt_SpawnPoint_C_0002_zmb_0000",
	},
	
	rt_SpawnPoint_C_0003_zmb_0000 = {
		"rt_SpawnPoint_C_0003_zmb_0000",
	},
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
