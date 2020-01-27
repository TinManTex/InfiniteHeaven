local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20620" )

this.locationScriptName = "spfc_pfCamp_script_c01"	

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 835.855, -12.001, 1215.855 )	

this.time = "13:50:00"
this.fixedTime = true

this.identifier = "coop_location_mafr_2"
this.defensePositionKey = "coop_location_mafr_2_mining_machine_1"




this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}


this.diggerLifeBreakSetting = {
	breakPoints = { 0.875, 0.75, 0.625, 0.5, 0.375, 0.25, 0.125 },
	radius = 15,
	rangeY = { 0, 10 },
}


this.dynamicShockWaveRadius			= true
this.waveFinishShockWaveRadiusMin	= 20		
this.waveFinishShockWaveRadiusMax	= 70		
this.shockWaveRadiusEnlargementTime = 8 * 60	




this.prepareTime = 180




this.intervalTimeTable = {
	180,
	180,
	180,
	180,
}




this.nextMissionId = 21019





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/pfCamp/c20620_variation.json"




return this
