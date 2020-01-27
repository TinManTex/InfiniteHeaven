local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20710" )

this.locationScriptName = "ssav_savannah_script_c01"	

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 966.277, 23.272, -186.639 )	

this.time = "13:50:00"
this.fixedTime = true

this.startFogDensity	= 0.05
this.waveFogDensity		= 0.03

this.identifier = "coop_location_mafr_3"
this.defensePositionKey = "coop_location_mafr_3_mining_machine_1"




this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/ssav/block_mission/large/savannah/ssav_savannah_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.extraTargetGimmickTableListTable = {}	


this.dynamicShockWaveRadius = true
this.waveFinishShockWaveRadiusMin	= 10		
this.waveFinishShockWaveRadiusMax	= 75		
this.shockWaveRadiusEnlargementTime = 15 * 60	




this.intervalTimeTable = {
	120,
	120,
	120,
	120,
}




this.nextMissionId = 21025





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/savannah/c20710_variation.json"




return this
