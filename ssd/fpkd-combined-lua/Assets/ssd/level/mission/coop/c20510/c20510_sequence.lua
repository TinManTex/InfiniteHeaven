local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20510" )

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 1954.279, 293.746, -442.375 )	

this.time = "12:00:00"
this.fixedTime = true

this.identifier = "coop_location_afgh_3"
this.defensePositionKey = "coop_location_afgh_3_start_point_1"

this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/sbri/block_mission/large/bridge/sbri_bridge_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.craftGimmickTableTable = {
}

this.singularityEffectName = "singularity"

this.importantGimmickTableList = {
	{ locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00", datasetName = "/Assets/ssd/level/location/sbri/block_mission/large/bridge/sbri_bridge_digger_c01.fox2", },
}

this.gimmickObjectiveMap = {
}


this.mapInfoDataIdentifierName = "coop_location_afgh_3"	
this.mapInfoMineName = "mining_machine_1"	
this.mapInfoStealthAreaName = "stealth_area_1"	


this.DEFENSE_MAP_LOCATOR_NAME = "afgh_enemyBase_cp"	










this.rankScoreList = {
	200000,	
	100000,	
	50000,	
	25000,	
	10000,	
	0,	
}




this.waveSequenceSettings = {
	{	
		waveName = "wave_01_01",	
		waveLimitTime = 120.0,	
	},
	{	
		waveName = "wave_02_01",
		waveLimitTime = 120.0,
	},
	{	
		waveName = "wave_03_01",
		waveLimitTime = 120.0,
	},
}

this.treasureBoxResourcesTableList = {
}


this.treasurePointResourcesTableList = {
}




this.nextMissionId = 21010










return this
