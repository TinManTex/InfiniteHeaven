local mafr = {}





mafr.requires = {
	"/Assets/tpp/level/location/mafr/block_common/mafr_luxury_block_list.lua",
	"/Assets/ssd/script/location/mafr/mafr_base.lua",
	"/Assets/ssd/script/location/mafr/mafr_boss.lua",
	"/Assets/ssd/script/location/mafr/mafr_animal.lua",
	"/Assets/ssd/script/location/mafr/mafr_visibilitySettings.lua",
	"/Assets/ssd/script/location/mafr/mafr_waveSettings.lua",
	"/Assets/ssd/script/location/mafr/mafr_wormhole.lua",
	"/Assets/ssd/script/location/mafr/mafr_treasureBox.lua",
	"/Assets/ssd/script/location/mafr/mafr_treasurePoint.lua",
	"/Assets/ssd/script/location/mafr/mafr_treasureQuest.lua",
	"/Assets/ssd/script/location/mafr/mafr_treasureMission.lua",
	"/Assets/ssd/script/location/mafr/mafr_wormholeQuest.lua",
	"/Assets/ssd/script/location/mafr/mafr_gimmick.lua",
}

function mafr.OnAllocate()
	Fox.Log("############### mafr.OnAllocate ###############")
	mvars.loc_locationCommonTable			= mafr
	mvars.loc_locationBase					= mafr_base
	mvars.loc_locationBoss					= mafr_boss
	mvars.loc_locationAnimalSettingTable	= mafr_animal
	mvars.loc_locationVisibilitySettings	= mafr_visibilitySettings
	mvars.loc_locationCommomnWaveSettings	= mafr_waveSettings
	mvars.loc_locationWormhole				= mafr_wormhole
	mvars.loc_locationTreasureBox			= mafr_treasureBox
	mvars.loc_locationTreasurePoint			= mafr_treasurePoint
	mvars.loc_locationTreasureQuest			= mafr_treasureQuest
	mvars.loc_locationTreasureMission		= mafr_treasureMission
	mvars.loc_locationWormholeQuest			= mafr_wormholeQuest
	mvars.loc_locationGimmick				= mafr_gimmick

	mafr_animal.OnAllocate()
end

function mafr.OnInitialize()
	Fox.Log("############### mafr.OnInitialize ###############")

	
	mafr_base.OnInitialize()
	mafr_boss.OnInitialize()
	
	
end

function mafr.OnReload()
	
	mafr_base.OnReload()
end

function mafr.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	strLogText = "mafr.lua:".. strLogText
	
	if mafr_animal.OnMessage then
		mafr_animal.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	end
	if mafr_base.OnMessage then
		mafr_base.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	end
end

function mafr.OnMissionCanStart()
	mafr_luxury_block_list.RegistLuxuryBlock()
	mafr_animal.OnMissionCanStart()
end

return mafr