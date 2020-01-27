local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c29210" )

this.INITIAL_CAMERA_ROTATION = { 7.6784949302673, 33.724617004395 }
this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 1322.204, 119.9836, -1544.622 )	


this.startFogDensity = 0.009
this.waveFogDensity = 0.008

this.time = "12:00:00"
this.fixedTime = true

this.identifier = "coop_location_mafr_1"
this.defensePositionKey = "coop_location_mafr_1_mining_machine_1"

this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.craftGimmickTableTable = {
	[ Fox.StrCode32( "PRD_BLD_WeaponPlant_B" ) ] = {	
		locatorName = "ssde_wepn001_vrtn001_gim_n0000|srt_ssde_wepn001_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_GadgetPlant_B" ) ] = {	
		locatorName = "com_gadget_plant001_gim_n0000|srt_gadget_plant001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_AmmoBox" ) ] = {	
		locatorName = "ssde_boxx011_gim_n0000|srt_ssde_boxx011",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Warehouse_A" ) ] = {	
		locatorName = "ssde_boxx001_gim_n0000|srt_ssde_boxx001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
}

this.singularityEffectName = "singularity"



this.waveFinishShockWaveRadius = 25


this.mapInfoDataIdentifierName = "coop_location_mafr_1"	
this.mapInfoMineName = "mining_machine_1"	




this.prepareTime = 240




this.intervalTimeTable = {
	[ 1 ] = 180,
	[ 2 ] = 120,
}




this.walkerGearNameList = {
	"walkerGear_0000",
	"walkerGear_0001",
}




this.nextMissionId = 21020





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/show/c29210_variation.json"




return this
