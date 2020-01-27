local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20220" )

this.locationScriptName = "mafr_diamond_script_c01"	

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 1322.204, 119.9836, -1544.622 )	

this.time = "13:50:00"
this.fixedTime = true

this.identifier = "coop_location_mafr_1"
this.defensePositionKey = "coop_location_mafr_1_mining_machine_1"




this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}


this.dynamicShockWaveRadius = true
this.waveFinishShockWaveRadiusMin	= 10		
this.waveFinishShockWaveRadiusMax	= 75		
this.shockWaveRadiusEnlargementTime = 15 * 60	




this.intervalTimeTable = {
	180,	
	180,	
	180,	
	180,	
}




this.nextMissionId = 21020





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/diamond/c20220_variation.json"




return this
