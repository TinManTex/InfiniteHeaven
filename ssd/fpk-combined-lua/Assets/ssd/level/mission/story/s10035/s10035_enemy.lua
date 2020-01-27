local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


local ZOMBIE = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM = TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM

this.requires = {}





this.soldierDefine = {
	nil
}



this.simpleWaveTable = {
 wave_01 = {
  { 15, "SpawnPoint0001", ZOMBIE, 4 },
  { 9, "SpawnPoint0002", ZOMBIE, 2 },
  { 9, "SpawnPoint0000", ZOMBIE, 2 },
  { 18, "SpawnPoint0001", ZOMBIE, 4 },
  { 9, "SpawnPoint0000", ZOMBIE, 2 },
  { 9, "SpawnPoint0002", ZOMBIE, 2 },
  { 40, "SpawnPoint0003", ZOMBIE, 3 },
  { 30, "SpawnPoint0004", ZOMBIE, 4 },
  { 20, "SpawnPoint0004", ZOMBIE, 2 },
  { 85, "SpawnPoint0005", ZOMBIE, 3 },
  { 6, "SpawnPoint0005", ZOMBIE, 3 },
  { 6, "SpawnPoint0005", ZOMBIE, 3 },
  { 45, "SpawnPoint0005", ZOMBIE, 3 },
  { 6, "SpawnPoint0005", ZOMBIE, 3 },
  { 6, "SpawnPoint0005", ZOMBIE, 3 },
 },
}

this.spawnPointDefine = {
	SpawnPoint0000 = { spawnLocator = "SpawnPoint0000", },
	SpawnPoint0001 = { spawnLocator = "SpawnPoint0001", },
	SpawnPoint0002 = { spawnLocator = "SpawnPoint0002", },
	SpawnPoint0003 = { spawnLocator = "SpawnPoint0003", },
	SpawnPoint0004 = { spawnLocator = "SpawnPoint0004", },
	SpawnPoint0005 = { spawnLocator = "SpawnPoint0005", },
}

this.sequenceSpiderTable = {
	Seq_Game_Escape1 = {
		"SsdSpiderGameObjectLocator0002",
		"SsdSpiderGameObjectLocator0003",
		"SsdSpiderGameObjectLocator0006",
	},
	Seq_Game_Escape2 = {
		"SsdSpiderGameObjectLocator0000",
		"SsdSpiderGameObjectLocator0001",
		"SsdSpiderGameObjectLocator0002",
		"SsdSpiderGameObjectLocator0003",
	},
	GameOver = {
		"SsdSpiderGameObjectLocatorForGameOver",
	},
}





this.SetEnableAllSpider = function( isEnable )
	for sequenceName, locatorList in pairs(this.sequenceSpiderTable) do
		for index, locatorName in ipairs(locatorList) do
			this.SetEnableSpider( locatorName, isEnable )
		end
	end
end

this.SetEnableSpiderBySequenceName = function( sequenceName )
	for iSequenceName, locatorList in pairs(this.sequenceSpiderTable) do
		local isEnable = false
		if iSequenceName == sequenceName then
			isEnable = true
		end
		for index, locatorName in ipairs(locatorList) do
			this.SetEnableSpider( locatorName, isEnable )
		end
	end

	local locatorList = this.sequenceSpiderTable[sequenceName]
	if locatorList then
		for index, locatorName in ipairs(locatorList) do
			this.SetEnableSpider( locatorName, isEnable )
		end
	end
end

this.SetEnableSpider = function( locatorName, isEnable )
	local gameObjectId = GameObject.GetGameObjectId( "SsdInsect2", locatorName )
	if not ( gameObjectId == GameObject.NULL_ID ) then
		GameObject.SendCommand( gameObjectId, { id = "SetEnabled", enabled = isEnable } )
	else
		Fox.Error("SetEnableSpider : cannot get gameObjectId. locatorName = " .. tostring(locatorName) )
	end
end


this.InitEnemy = function ()
end



this.SetUpEnemy = function ()
	local spawnSettingTable, waveSpawnPointList = TppEnemy.MakeSpawnSettingTable( s10035_sequence.WAVE_LIST, this.simpleWaveTable, this.spawnPointDefine )
	local waveSettingTable = TppEnemy.MakeWaveSettingTable( s10035_sequence.WAVE_LIST, this.simpleWaveTable )
	TppEnemy.RegisterWaveSpawnPointList( waveSpawnPointList )
	
	local gameObjectId = { type = "TppCommandPost2", }
	GameObject.SendCommand( gameObjectId, { id = "SetSpawnSetting", settingTable = spawnSettingTable, } )
	GameObject.SendCommand( gameObjectId, { id = "SetWaveSetting", settingTable = waveSettingTable } )
end


this.OnLoad = function ()
end




return this
