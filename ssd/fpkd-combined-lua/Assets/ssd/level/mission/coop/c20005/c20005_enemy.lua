local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.requires = {}




this.spawnSettingTable = {
	spawn0010_2_0 = {	
		locatorSet = { spawnLocator = "SpawnPoint0010", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 5.0, groupId = 1, },
		},
	},
	spawn0010_4_0 = {	
		locatorSet = { spawnLocator = "SpawnPoint0010", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 5.0, groupId = 1, },
		},
	},
	spawn0010_6_0 = {	
		locatorSet = { spawnLocator = "SpawnPoint0010", route = "rt_SpawnPoint0010_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 5.0, groupId = 1, },
		},
	},
	spawn0010_8_0 = {	
		locatorSet = { spawnLocator = "SpawnPoint0010", route = { "rt_SpawnPoint0010_0000", "rt_SpawnPoint0010_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, },
		},
	},
	spawn0020_2_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0020", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 5.0, groupId = 1, },
		},
	},
	spawn0020_4_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0020", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 5.0, groupId = 1, },
		},
	},
	spawn0020_6_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0020", route = "rt_SpawnPoint0020_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 5.0, groupId = 1, },
		},
	},
	spawn0020_8_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0020", route = { "rt_SpawnPoint0020_0000", "rt_SpawnPoint0020_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, },
		},
	},
	spawn0030_2_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0030", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 5.0, groupId = 1, },
		},
	},
	spawn0030_4_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0030", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 5.0, groupId = 1, },
		},
	},
	spawn0030_6_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0030", route = "rt_SpawnPoint0030_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 5.0, groupId = 1, },
		},
	},
	spawn0030_8_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0030", route = { "rt_SpawnPoint0030_0000", "rt_SpawnPoint0030_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, },
		},
	},
	spawn0040_2_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0040", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 5.0, groupId = 1, },
		},
	},
	spawn0040_4_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0040", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 5.0, groupId = 1, },
		},
	},
	spawn0040_6_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0040", route = "rt_SpawnPoint0040_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 5.0, groupId = 1, },
		},
	},
	spawn0040_8_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0040", route = { "rt_SpawnPoint0040_0000", "rt_SpawnPoint0040_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, },
		},
	},
	spawn0050_2_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0050", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 5.0, groupId = 1, },
		},
	},
	spawn0050_4_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0050", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 5.0, groupId = 1, },
		},
	},
	spawn0050_6_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0050", route = { "rt_SpawnPoint0050_0000", "rt_SpawnPoint0050_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 5.0, groupId = 1, },
		},
	},
	spawn0050_8_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0050", route = { "rt_SpawnPoint0050_0000", "rt_SpawnPoint0050_0001", "rt_SpawnPoint0050_0002", "rt_SpawnPoint0050_0003", "rt_SpawnPoint0050_0004", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, },
		},
	},
	spawn0060_2_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0060", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 2, radius = 5.0, groupId = 1, },
		},
	},
	spawn0060_4_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0060", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 4, radius = 5.0, groupId = 1, },
		},
	},
	spawn0060_6_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0060", route = "rt_SpawnPoint0060_0000", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 6, radius = 5.0, groupId = 1, },
		},
	},
	spawn0060_8_0 = {
		locatorSet = { spawnLocator = "SpawnPoint0060", route = { "rt_SpawnPoint0060_0000", "rt_SpawnPoint0060_0001", }, },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, },
		},
	},

	spawn_stealthArea_8_0 = {
		locatorSet = { spawnLocator = "SpawnPoint_stealthArea", },
		enemySet = {
			{ type = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE, count = 8, radius = 5.0, groupId = 1, level = 10, isStealth = 1, },
		},
	},
}

this.waveSettingTable = {
	
	wave_01_1	= { type = "none", spawnTableName = "spawn0010_2_0", },

	
	wave_01_2	= { type = "none", spawnTableName = "spawn0040_2_0", },

	
	wave_02		= {	type = "none",	spawnTableName = "spawn0050_2_0",					nextWave = "wave_02_01",	},
	wave_02_01	= {	type = "auto",	spawnTableName = "spawn0030_2_0",	waitTime = 10.0,								},

	
	wave_03		= {	type = "none",	spawnTableName = "spawn0010_2_0",					nextWave = "wave_03_01",	},
	wave_03_01	= {	type = "auto",	spawnTableName = "spawn0020_2_0",	waitTime = 10.0,	nextWave = "wave_03_02",	},
	wave_03_02	= {	type = "auto",	spawnTableName = "spawn0060_4_0",	waitTime = 20.0,								},

	
	wave_04		= {	type = "none",	spawnTableName = "spawn0030_4_0",					nextWave = "wave_04_01",	},
	wave_04_01	= {	type = "auto",	spawnTableName = "spawn0040_4_0",	waitTime = 10.0,	nextWave = "wave_04_02",	},
	wave_04_02	= {	type = "auto",	spawnTableName = "spawn0050_4_0",	waitTime = 20.0,	nextWave = "wave_04_03",	},
	wave_04_03	= {	type = "auto",	spawnTableName = "spawn0060_4_0",	waitTime = 30.0,								},

	
	wave_05		= {	type = "none",	spawnTableName = "spawn0040_4_0",					nextWave = "wave_05_01",	},
	wave_05_01	= {	type = "auto",	spawnTableName = "spawn0060_4_0",	waitTime = 10.0,	nextWave = "wave_05_02",	},
	wave_05_02	= {	type = "auto",	spawnTableName = "spawn0010_4_0",	waitTime = 20.0,	nextWave = "wave_05_03",	},
	wave_05_03	= {	type = "auto",	spawnTableName = "spawn0030_6_0",	waitTime = 30.0,	nextWave = "wave_05_04",	},
	wave_05_04	= {	type = "auto",	spawnTableName = "spawn0020_6_0",	waitTime = 40.0,								},

	
	wave_06		= {	type = "none",	spawnTableName = "spawn0040_4_0",					nextWave = "wave_06_01",	},
	wave_06_01	= {	type = "auto",	spawnTableName = "spawn0060_4_0",	waitTime = 10,	nextWave = "wave_06_02",	},
	wave_06_02	= {	type = "auto",	spawnTableName = "spawn0020_6_0",	waitTime = 20,	nextWave = "wave_06_03",	},
	wave_06_03	= {	type = "auto",	spawnTableName = "spawn0010_6_0",	waitTime = 30,	nextWave = "wave_06_04",	},
	wave_06_04	= {	type = "auto",	spawnTableName = "spawn0050_8_0",	waitTime = 40,	nextWave = "wave_06_05",	},
	wave_06_05	= {	type = "auto",	spawnTableName = "spawn0030_8_0",	waitTime = 50,								},

	
	wave_07		= {	type = "none",	spawnTableName = "spawn0020_6_0",					nextWave = "wave_07_01",	},
	wave_07_01	= {	type = "auto",	spawnTableName = "spawn0040_6_0",	waitTime = 10,	nextWave = "wave_07_02",	},
	wave_07_02	= {	type = "auto",	spawnTableName = "spawn0050_8_0",	waitTime = 20,	nextWave = "wave_07_03",	},
	wave_07_03	= {	type = "auto",	spawnTableName = "spawn0010_8_0",	waitTime = 30,	nextWave = "wave_07_04",	},
	wave_07_04	= {	type = "auto",	spawnTableName = "spawn0030_8_0",	waitTime = 40,	nextWave = "wave_07_05",	},
	wave_07_05	= {	type = "auto",	spawnTableName = "spawn0060_8_0",	waitTime = 50,								},

	
	wave_stealthArea 	= {	type = "none",	spawnTableName = "spawn_stealthArea_8_0",									},
}




this.GetSpawnLocatorNames = function( waveName )
	Fox.Log( "c20005_enemy.GetSpawnLocatorNames(): waveName:" .. tostring( waveName ) )

	local waveSetting = this.waveSettingTable[ waveName ]
	local spawnLocatorNames = {}
	while waveSetting do
		if waveSetting.endLoop then
			break
		end
		if	waveSetting.spawnTableName and
			this.spawnSettingTable[ waveSetting.spawnTableName ] and
			this.spawnSettingTable[ waveSetting.spawnTableName ].locatorSet and
			this.spawnSettingTable[ waveSetting.spawnTableName ].locatorSet.spawnLocator then

			local targetSpawnLocatorName = this.spawnSettingTable[ waveSetting.spawnTableName ].locatorSet.spawnLocator

			local need = true
			for _, spawnLocatorName in ipairs( spawnLocatorNames ) do
				if spawnLocatorName == targetSpawnLocatorName then
					need = false
				end
			end

			if need then
				table.insert( spawnLocatorNames, targetSpawnLocatorName )
			end
			waveSetting = this.waveSettingTable[ waveSetting.nextWave ]
		else
			Fox.Warning( "c20005_enemy.GetSpawnLocatorNames(): wave and spawn settings maybe wrong. waveName:" .. tostring( waveName ) .. ", spawnTableName:" .. tostring( waveSetting.spawnTableName ) )
			waveSetting = nil	
		end
	end
	return spawnLocatorNames
end



this.InitEnemy = function ()
end



this.SetUpEnemy = function ()

	Fox.Log( "c20005_enemy.SetUpEnemy()" )

	
	local gameObjectId = { type = "TppCommandPost2", }
	GameObject.SendCommand( gameObjectId, { id = "SetSpawnSetting", settingTable = this.spawnSettingTable, } )
	GameObject.SendCommand( gameObjectId, { id = "SetWaveSetting", settingTable = this.waveSettingTable } )

end


this.OnLoad = function ()
end




return this
