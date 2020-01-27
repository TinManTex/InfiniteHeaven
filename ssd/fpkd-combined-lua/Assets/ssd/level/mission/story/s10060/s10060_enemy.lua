local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


local ZOMBIE = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
local DASH = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH
local MORTOR = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL
local SPIDER = TppGameObject.GAME_OBJECT_TYPE_INSECT_2

this.requires = {}





this.soldierDefine = {
	
	cp_base = {
		nil
	},
	nil
}





this.routeSets = {
	
	
	cp_base = {
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
		hold = {
			default = {
			},
		},
		nil
	},	
}


this.simpleWaveTable = {
 wave_01 = {
  { 4, "SpawnPoint0001", ZOMBIE, 4, nil, },
  { 1, "SpawnPoint0001", BOM, 1, nil, },
  { 4, "SpawnPoint0002", ZOMBIE, 4, nil, },
  { 1, "SpawnPoint0002", BOM, 2, nil, },
  { 12, "SpawnPoint0003", ZOMBIE, 4, nil, },
  
  { 30, "SpawnPoint0001", ZOMBIE, 4, nil, },
  { 6, "SpawnPoint0000", ZOMBIE, 4, nil, },
  { 1, "SpawnPoint0000", BOM, 1, nil, },
  { 12, "SpawnPoint0001", ZOMBIE, 4, nil, },
  { 1, "SpawnPoint0001", BOM, 2, nil, },
  
  { 30, "SpawnPoint0003", ZOMBIE, 8, nil, },
  { 6, "SpawnPoint0001", ZOMBIE, 8, nil, },
  { 1, "SpawnPoint0001", BOM, 1, nil, },
  { 15, "SpawnPoint0002", ZOMBIE, 8, nil, "walk"  },
  { 4, "SpawnPoint0000", ZOMBIE, 8, nil, "walk"  },
  { 6, "SpawnPoint0003", ZOMBIE, 8, nil, "walk"  },
  
  { 30, "SpawnPoint0001", ZOMBIE, 8, nil, "walk"  },
  { 4, "SpawnPoint0003", ZOMBIE, 8, nil, "walk"  },
  { 1, "SpawnPoint0003", BOM, 1, nil, "walk"  },
  
  { 30, "SpawnPoint0002", ZOMBIE, 8, nil, "walk"  },
  { 6, "SpawnPoint0000", ZOMBIE, 8, nil, "walk"  },
  { 12, "SpawnPoint0001", ZOMBIE, 8, nil, "walk"  },
  { 1, "SpawnPoint0001", BOM, 1, nil, "walk"  },
  
  { 30, "SpawnPoint0000", ZOMBIE, 8 },
  { 1, "SpawnPoint0000", BOM, 1, nil, "walk"  },
  { 6, "SpawnPoint0003", ZOMBIE, 8, nil, "walk"  },
 },
 wave_02 = {
  { 10, "SpawnPoint0010_3", ZOMBIE, 5 },
  { 4, "SpawnPoint0010_3", ZOMBIE, 4 },
  { 15, "SpawnPoint0010_3", ZOMBIE, 5 },
  { 20, "SpawnPoint0011_3", ZOMBIE, 9, },
  { 35, "SpawnPoint0010_3", ZOMBIE, 7, },
  { 15, "SpawnPoint0011_3", ZOMBIE, 8, },
  { 15, "SpawnPoint0010_3", ZOMBIE, 11, },
  
  { 50, "SpawnPoint0010_3", ZOMBIE, 5 },
  { 15, "SpawnPoint0011_3", ZOMBIE, 8, },
  { 4, "SpawnPoint0010_3", ZOMBIE, 6 },
  { 12, "SpawnPoint0010_3", ZOMBIE, 12 },
  { 60, "SpawnPoint0012_3", BOM, 1 },
  { 2, "SpawnPoint0010_3", BOM, 2 },
  { 2, "SpawnPoint0011_3", BOM, 1 },
  { 2, "SpawnPoint0012_3", ZOMBIE, 8, },
  
  { 70, "SpawnPoint0010_3", ZOMBIE, 7, },
  { 20, "SpawnPoint0011_3", ZOMBIE, 7, },
  { 12, "SpawnPoint0010_3", ZOMBIE, 6, },
  { 15, "SpawnPoint0012_3", ZOMBIE, 8, },
  { 15, "SpawnPoint0010_3", ZOMBIE, 8, nil, "walk" },
  { 15, "SpawnPoint0011_3", ZOMBIE, 9, nil, "walk" },
  { 6, "SpawnPoint0010_3", ZOMBIE, 8, nil, "walk" },
  { 12, "SpawnPoint0012_3", ZOMBIE, 8, },
  
  { 70, "SpawnPoint0010_3", MORTOR, 4, nil, "walk" },
 },
 wave_03 = {
  { 1, "SpawnPoint0020", ZOMBIE, 10 },
  { 20, "SpawnPoint0020", BOM, 2 },
  { 30, "SpawnPoint0021", ZOMBIE, 10 },
  { 60, "SpawnPoint0020", ZOMBIE, 6 },
  { 20, "SpawnPoint0020", SPIDER, 10 },
  { 30, "SpawnPoint0021", ZOMBIE, 6 },
 },
 wave_04 = {
  { 1, "SpawnPoint0042", ZOMBIE, 4 },
  { 1, "SpawnPoint0043", ZOMBIE, 4 },
  { 1, "SpawnPoint0044", ZOMBIE, 4 },
  { 20, "SpawnPoint0040", ZOMBIE, 3, },
  { 1, "SpawnPoint0041", ZOMBIE, 3 },
  { 1, "SpawnPoint0042", ZOMBIE, 3 },
  { 1, "SpawnPoint0043", ZOMBIE, 3 },
  { 1, "SpawnPoint0044", ZOMBIE, 3 },
  { 1, "SpawnPoint0045", ZOMBIE, 3 },
  { 1, "SpawnPoint0046", ZOMBIE, 3 },
  { 30, "SpawnPoint0040", ZOMBIE, 6 },
  { 1, "SpawnPoint0041", ZOMBIE, 6 },
  { 1, "SpawnPoint0042", ZOMBIE, 6 },
  { 1, "SpawnPoint0043", ZOMBIE, 6 },
  { 1, "SpawnPoint0044", ZOMBIE, 6 },
  { 1, "SpawnPoint0045", ZOMBIE, 6 },
  { 1, "SpawnPoint0046", ZOMBIE, 6 },
  { 10, "SpawnPoint0043", DASH, 3 },
  { 30, "SpawnPoint0040", ZOMBIE, 8 },
  { 1, "SpawnPoint0040", BOM, 1 },
  { 1, "SpawnPoint0041", ZOMBIE, 8 },
  { 1, "SpawnPoint0042", ZOMBIE, 8 },
  { 1, "SpawnPoint0042", BOM, 1 },
  { 1, "SpawnPoint0043", ZOMBIE, 8 },
  { 1, "SpawnPoint0044", ZOMBIE, 8 },
  { 1, "SpawnPoint0044", BOM, 1 },
  { 1, "SpawnPoint0045", ZOMBIE, 8 },
  { 1, "SpawnPoint0046", ZOMBIE, 8 },
  { 1, "SpawnPoint0046", BOM, 1 },
  { 75, "SpawnPoint0040", DASH, 1 },
  { 1, "SpawnPoint0041", DASH, 1 },
  { 1, "SpawnPoint0042", DASH, 1 },
  { 1, "SpawnPoint0043", DASH, 1 },
  { 1, "SpawnPoint0044", DASH, 1 },
  { 1, "SpawnPoint0045", DASH, 1 },
  { 1, "SpawnPoint0046", DASH, 1 },
  { 75, "SpawnPoint0040", ZOMBIE, 8 },
  { 1, "SpawnPoint0041", ZOMBIE, 8 },
  { 1, "SpawnPoint0042", ZOMBIE, 8 },
  { 1, "SpawnPoint0043", ZOMBIE, 8 },
  { 1, "SpawnPoint0044", ZOMBIE, 8 },
  { 1, "SpawnPoint0045", ZOMBIE, 8 },
  { 1, "SpawnPoint0046", ZOMBIE, 8 },
 },
}

this.spawnPointDefine = {
	SpawnPoint0000 = { spawnLocator = "SpawnPoint0000", relayLocator1 = "RelayPoint0000_0001", relayLocator2 = "RelayPoint0000_0002", relayLocator3 = "RelayPoint0000_0003" },
	SpawnPoint0001 = { spawnLocator = "SpawnPoint0001", relayLocator1 = "RelayPoint0000_0001", relayLocator2 = "RelayPoint0000_0002", relayLocator3 = "RelayPoint0000_0003" },
	SpawnPoint0002 = { spawnLocator = "SpawnPoint0002", relayLocator1 = "RelayPoint0000_0001", relayLocator2 = "RelayPoint0000_0002", relayLocator3 = "RelayPoint0000_0003" },
	SpawnPoint0003 = { spawnLocator = "SpawnPoint0003", relayLocator1 = "RelayPoint0000_0001", relayLocator2 = "RelayPoint0000_0002", relayLocator3 = "RelayPoint0000_0003" },
	SpawnPoint0010_2 = { spawnLocator = "SpawnPoint0010", relayLocator1 = "RelayPoint_dnw0_gim_n0002", },
	SpawnPoint0011_2 = { spawnLocator = "SpawnPoint0011", relayLocator1 = "RelayPoint_dnw0_gim_n0002", },
	SpawnPoint0012_2 = { spawnLocator = "SpawnPoint0012", relayLocator1 = "RelayPoint_dnw0_gim_n0002", },
	SpawnPoint0010_3 = { spawnLocator = "SpawnPoint0010", relayLocator1 = "RelayPoint_dnw0_gim_n0003", },
	SpawnPoint0011_3 = { spawnLocator = "SpawnPoint0011", relayLocator1 = "RelayPoint_dnw0_gim_n0003", },
	SpawnPoint0012_3 = { spawnLocator = "SpawnPoint0012", relayLocator1 = "RelayPoint_dnw0_gim_n0003", },
	SpawnPoint0020 = { spawnLocator = "SpawnPoint0020", relayLocator1 = "RelayPoint0020_0001", relayLocator2 = "RelayPoint0021_0002", },
	SpawnPoint0021 = { spawnLocator = "SpawnPoint0021", relayLocator1 = "RelayPoint0021_0001", relayLocator2 = "RelayPoint0021_0002", },
	SpawnPoint0040 = { spawnLocator = "SpawnPoint0040", relayLocator1 = "RelayPoint0040", },
	SpawnPoint0041 = { spawnLocator = "SpawnPoint0041", relayLocator1 = "RelayPoint0041", },
	SpawnPoint0042 = { spawnLocator = "SpawnPoint0042", },
	SpawnPoint0043 = { spawnLocator = "SpawnPoint0043", },
	SpawnPoint0044 = { spawnLocator = "SpawnPoint0044", },
	SpawnPoint0045 = { spawnLocator = "SpawnPoint0045", },
	SpawnPoint0046 = { spawnLocator = "SpawnPoint0046", },
}






this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	local spawnSettingTable, waveSpawnPointList = TppEnemy.MakeSpawnSettingTable( s10060_sequence.WAVE_LIST, this.simpleWaveTable, this.spawnPointDefine )
	local waveSettingTable = TppEnemy.MakeWaveSettingTable( s10060_sequence.WAVE_LIST, this.simpleWaveTable )
	TppEnemy.RegisterWaveSpawnPointList( waveSpawnPointList )
	
	local gameObjectId = { type = "TppCommandPost2", }
	GameObject.SendCommand( gameObjectId, { id = "SetSpawnSetting", settingTable = spawnSettingTable, } )
	GameObject.SendCommand( gameObjectId, { id = "SetWaveSetting", settingTable = waveSettingTable } )
end


this.OnLoad = function ()
	Fox.Log("*** s10060 onload ***")
end




return this
