local afgh = {}





afgh.requires = {
	"/Assets/ssd/level/location/afgh/block_common/afgh_luxury_block_list.lua",
	"/Assets/ssd/script/location/afgh/afgh_base.lua",
	"/Assets/ssd/script/location/afgh/afgh_boss.lua",
	"/Assets/ssd/script/location/afgh/afgh_animal.lua",
	"/Assets/ssd/script/location/afgh/afgh_visibilitySettings.lua",
	"/Assets/ssd/script/location/afgh/afgh_waveSettings.lua",
	"/Assets/ssd/script/location/afgh/afgh_wormhole.lua",
	"/Assets/ssd/script/location/afgh/afgh_treasureBox.lua",
	"/Assets/ssd/script/location/afgh/afgh_treasurePoint.lua",
	"/Assets/ssd/script/location/afgh/afgh_treasureQuest.lua",
	"/Assets/ssd/script/location/afgh/afgh_treasureMission.lua",
	"/Assets/ssd/script/location/afgh/afgh_wormholeQuest.lua",
	"/Assets/ssd/script/location/afgh/afgh_gimmick.lua",
}

function afgh.OnAllocate()
	Fox.Log("############### afgh.OnAllocate ###############")
	mvars.loc_locationCommonTable			= afgh
	mvars.loc_locationBase					= afgh_base
	mvars.loc_locationBoss					= afgh_boss
	mvars.loc_locationAnimalSettingTable	= afgh_animal
	mvars.loc_locationVisibilitySettings	= afgh_visibilitySettings
	mvars.loc_locationCommomnWaveSettings	= afgh_waveSettings
	mvars.loc_locationWormhole				= afgh_wormhole
	mvars.loc_locationTreasureBox			= afgh_treasureBox
	mvars.loc_locationTreasurePoint			= afgh_treasurePoint
	mvars.loc_locationTreasureQuest			= afgh_treasureQuest
	mvars.loc_locationTreasureMission		= afgh_treasureMission
	mvars.loc_locationWormholeQuest			= afgh_wormholeQuest
	mvars.loc_locationGimmick				= afgh_gimmick

	afgh_animal.OnAllocate()
end

function afgh.OnInitialize()
	Fox.Log("############### afgh.OnInitialize ###############")

	
	afgh_base.OnInitialize()
	afgh_boss.OnInitialize()
	
	
end

function afgh.OnReload()
	
	afgh_base.OnReload()
end

function afgh.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	strLogText = "afgh.lua:".. strLogText
	
	if afgh_animal.OnMessage then
		afgh_animal.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	end
	if afgh_base.OnMessage then
		afgh_base.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	end
end

function afgh.OnMissionCanStart()
	afgh_luxury_block_list.RegistLuxuryBlock()
	afgh_animal.OnMissionCanStart()
end

return afgh
