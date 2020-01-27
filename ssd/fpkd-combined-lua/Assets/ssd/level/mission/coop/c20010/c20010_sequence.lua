local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20010" )

this.locationScriptName = "afgh_field_script_c01"	

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 423.0762, 269.7263, 2208.609 )	

this.time = "13:50:00"
this.fixedTime = true

this.identifier = "coop_location_afgh_1"
this.defensePositionKey = "coop_location_afgh_1_mining_machine_1"




this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.extraTargetGimmickTableListTable = {}	


this.dynamicShockWaveRadius = true
this.waveFinishShockWaveRadiusMax = 70	


this.prepareTime = 180




this.intervalTimeTable = {
	120,	
	120,	
	120,	
	120,	
}




this.nextMissionId = 21010





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/field/c20010_variation.json"




return this
