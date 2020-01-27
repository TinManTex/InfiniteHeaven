local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20110" )

this.locationScriptName = "afgh_village_script_c01"	

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 502.9887, 322.1473, 1046.013 )	

this.time = "13:50:00"
this.fixedTime = true

this.identifier = "coop_location_afgh_2"
this.defensePositionKey = "coop_location_afgh_2_mining_machine_1"




this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.extraTargetGimmickTableListTable = {}	


this.dynamicShockWaveRadius = true




this.prepareTime = 180




this.intervalTimeTable = {
	120,	
	120,	
	120,	
	120,	
}




this.nextMissionId = 21010





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/village/c20110_variation.json"




return this
