local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c20420" )

this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( -1044.196, -13.140, -248.997 )	

this.time = "12:00:00"
this.fixedTime = true

this.identifier = "coop_location_mafr_2"
this.defensePositionKey = "coop_location_mafr_2_mining_machine_1"

this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.craftGimmickTableTable = {
	[ Fox.StrCode32( "PRD_BLD_WeaponPlant_A" ) ] = {	
		locatorName = "com_weapon_plant001_gim_n0000|srt_weapon_plant001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_WeaponPlant_B" ) ] = {	
		locatorName = "ssde_wepn001_vrtn001_gim_n0000|srt_ssde_wepn001_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_GadgetPlant_A" ) ] = {	
		locatorName = "ssde_wepn003_vrtn001_gim_n0000|srt_ssde_wepn003_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_GadgetPlant_B" ) ] = {	
		locatorName = "com_gadget_plant001_gim_n0000|srt_gadget_plant001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_MedicalPlant_A" ) ] = {	
		locatorName = "ssde_mdcn001_vrtn001_gim_n0000|srt_ssde_mdcn001_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_MedicalPlant_B" ) ] = {	
		locatorName = "com_medical_plant001_gim_n0000|srt_medical_plant001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Kitchen_A" ) ] = {	
		locatorName = "com_kitchen001_gim_n0000|srt_kitchen001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Kitchen_B" ) ] = {	
		locatorName = "ssde_ktch001_vrtn001_gim_n0000|srt_ssde_ktch001_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Kitchen_C" ) ] = {	
		locatorName = "ssde_ktch001_vrtn002_gim_n0000|srt_ssde_ktch001_vrtn002",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_AmmoBox" ) ] = {	
		locatorName = "mtbs_cntn003_vrtn001_gim_n0000|srt_mtbs_cntn003_vrtn001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Warehouse_A" ) ] = {	
		locatorName = "ssde_boxx001_gim_n0000|srt_ssde_boxx001",
		datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
}

this.singularityEffectName = "singularity"

this.importantGimmickTableList = {
	{ locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00", datasetName = "/Assets/ssd/level/location/mafr/block_mission/large/flowStation/mafr_flowStation_digger_c01.fox2", },
}

this.gimmickObjectiveMap = {
}


this.mapInfoDataIdentifierName = "coop_location_mafr_2"	
this.mapInfoMineName = "mining_machine_1"	
this.mapInfoStealthAreaName = "stealth_area_1"	


this.DEFENSE_MAP_LOCATOR_NAME = "mafr_flowStation_cp"	










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
		waveName = "wave_01",	
		waveLimitTime = 120.0,	
	},
	{	
		waveName = "wave_02",
		waveLimitTime = 150.0,
	},
	{	
		waveName = "wave_03",
		waveLimitTime = 180.0,
	},
	{	
		waveName = "wave_04",
		waveLimitTime = 210.0,
	},
	{	
		waveName = "wave_05",
		waveLimitTime = 240.0,
	},
}

this.treasureBoxResourcesTableList = {
}


this.treasurePointResourcesTableList = {
}




this.nextMissionId = 21010





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/flowStation/c20420.json"




return this
