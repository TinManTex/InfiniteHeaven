



local  afgh_village_script_c01 = {}




afgh_village_script_c01.ignoreLoadSmallBlocks = {
	{ 134, 139, },
	{ 134, 140, },
	{ 134, 141, },
	{ 134, 142, },
	{ 134, 143, },
	{ 135, 139, },
	{ 136, 139, },
	{ 137, 139, },
	{ 138, 139, },
}




afgh_village_script_c01.craftGimmickTableTable = {
	[ Fox.StrCode32( "PRD_BLD_WeaponPlant_B" ) ] = {	
		locatorName = "ssde_wepn001_vrtn001_gim_n0000|srt_ssde_wepn001_vrtn001",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_GadgetPlant_B" ) ] = {	
		locatorName = "com_gadget_plant001_gim_n0000|srt_gadget_plant001",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_AmmoBox" ) ] = {	
		locatorName = "ssde_boxx011_gim_n0000|srt_ssde_boxx011",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Warehouse_A" ) ] = {	
		locatorName = "ssde_boxx001_gim_n0000|srt_ssde_boxx001",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
}




afgh_village_script_c01.singularityEffectName = "singularity"




afgh_village_script_c01.stealthAreaNameTable = {
	[ Fox.StrCode32( "Gluttony" ) ]  = "coop_location_afgh_2_stealth_area_2",	
	[ Fox.StrCode32( "Aerial" ) ]  = "coop_location_afgh_2_stealth_area_1",	
}




if afgh_boss then
	afgh_village_script_c01.huntDownRouteNameTable = afgh_boss.aerialRouteTable[ Fox.StrCode32("afgh_village") ]
end




afgh_village_script_c01.walkerGearNameList = {
	"walkerGear_0000",
	"walkerGear_0001",
	"walkerGear_0002",
	"walkerGear_0003",
	"walkerGear_0004",
	"walkerGear_0005",
}




afgh_village_script_c01.extraTargetGimmickTableListTable = {
	[ 1 ] = {
		{
			locatorName = "whm1_gim_n0000|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0000",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 20.0,
		},
		{
			locatorName = "whm1_gim_n0001|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0001",
			wave = {
				[ 1 ] = false,
				[ 2 ] = false,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 25.0,
		},
		{
			locatorName = "whm1_gim_n0002|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0002",
			wave = {
				[ 1 ] = false,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 25.0,
		},
		{
			locatorName = "whm1_gim_n0003|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0003",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 20.0,
		},
	},
	[ 2 ] = {
		{
			locatorName = "whm1_gim_n0004|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0004",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
		{
			locatorName = "whm1_gim_n0005|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0005",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
		{
			locatorName = "whm1_gim_n0006|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0006",
			wave = {
				[ 1 ] = false,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
		{
			locatorName = "whm1_gim_n0007|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0007",
			wave = {
				[ 1 ] = false,
				[ 2 ] = false,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
	},
	[ 3 ] = {
		{
			locatorName = "whm1_gim_n0008|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0008",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 20.0,
		},
		{
			locatorName = "whm1_gim_n0009|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0009",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
		{
			locatorName = "whm1_gim_n0010|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0010",
			wave = {
				[ 1 ] = false,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
		{
			locatorName = "whm1_gim_n0011|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0011",
			wave = {
				[ 1 ] = false,
				[ 2 ] = false,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15.0,
		},
	},
}




afgh_village_script_c01.breakableGimmickTableList = {
	{
		locatorName = "afgh_wndw003_wdfm002_gim_n0000|srt_afgh_wndw003_glas002_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm002_gim_n0000|srt_afgh_wndw003_glas002_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0001|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0001|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0002|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0002|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0003|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0003|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0004|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0004|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0005|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0005|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0006|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0006|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0007|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0007|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0008|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0008|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0011|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0011|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0012|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0012|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0013|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0013|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0014|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0014|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0015|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0015|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0022|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0022|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0023|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0023|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0024|srt_afgh_wndw003_glas003_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm003_gim_n0024|srt_afgh_wndw003_glas003_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_asset.fox2",
	},
}




afgh_village_script_c01.treasurePointTableList = {
	{	
		name = "com_treasure_null001_gim_n0000|srt_gim_null_treasure",
		dataSetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_gimmick.fox2",
		resources = {
			"RES_Oil",
			"RES_Rag",
			"RES_Iron",
			"RES_Wood",
			"RES_Oil",
			"RES_Rag",
			"RES_Iron",
			"RES_Wood",
			"RES_Oil",
			"RES_Rag",
			"RES_Iron",
			"RES_Wood",
		},
		label = "treasurePoint_name_013",	
	},
	{	
		name = "com_treasure_null001_gim_n0001|srt_gim_null_treasure",
		dataSetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_gimmick.fox2",
		resources = {	
			"RES_Corn",
			"RES_Corn",
			"RES_Corn",
			"RES_Corn",
		},
		label = "name_PRD_BLD_VegetableFarm_B",	
	},
}




afgh_village_script_c01.treasureBoxTableList = {
	{	
		name = "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
		dataSetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_gimmick.fox2",
		breakResources = {
			"COL_WoodBox_E",
			"COL_Drum_A",
			"COL_GunPowderPack_WH",
		},
		breakRandomCount = 0,
		damageRate = 1,
		pickingDifficulty = 1,
	},
	{	
		name = "ssde_boxx004_gim_n0001|srt_ssde_boxx004",
		dataSetName = "/Assets/ssd/level/location/afgh/block_large/village/afgh_village_gimmick.fox2",
		breakResources = {
			"COL_Bottle_C_WH",
			"COL_Tube_TNT_WH",
			"COL_WoodStick_Nail",
		},
		breakRandomCount = 0,
		damageRate = 1,
		pickingDifficulty = 1,
	},
	{	
		name = "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
		dataSetName = "/Assets/ssd/level/location/afgh/block_small/136/136_141/afgh_136_141_gimmick.fox2",
		breakResources = {
			"COL_GunPowderPack_WH",
			"COL_Cluster_Fabric_WH",
			"COL_Carton_A",
		},
		breakRandomCount = 0,
		damageRate = 1,
		pickingDifficulty = 1,
	},
	{	
		name = "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
		dataSetName = "/Assets/ssd/level/location/afgh/block_small/139/139_142/afgh_139_142_gimmick.fox2",
		breakResources = {
			"COL_Cluster_Fabric_WH",
			"COL_Oil",
			"COL_Cluster_Steel_WH",
		},
		breakRandomCount = 0,
		damageRate = 1,
		pickingDifficulty = 2,
	},
	
	{
		name				= "ssde_boxx004_gim_n0001|srt_ssde_boxx004",
		dataSetName			= "/Assets/ssd/level/location/afgh/block_small/135/135_140/afgh_135_140_gimmick.fox2",
		breakResources		= {
			"COL_Tube_TNT_WH",
			"COL_GunPowderPack_WH",
			"COL_Cluster_Steel_WH",
		},
		breakRandomCount	= 0,
		damageRate			= 0.8,
		pickingDifficulty	= 1,
	},

}

local RESOURCES = {
	"COL_WoodStick_Nail",
	"COL_DrumFragment_4",
	"COL_Carton_G",
	"COL_Sandbag_WH",
	"COL_Cluster_Fabric_WH",
	"COL_Carton_E",
	"COL_Carton_A",
	"COL_GunPowderPack_WH",
	"COL_MedicalEquip_A_WH",
	"COL_Solvent",
	"COL_Tire_B_WH",
	"COL_Bottle_C_WH",
	"COL_Oil",
	"COL_Carton_F",
	"COL_Tableware_G_WH",
	"COL_Ashtray_WH",
	"COL_Carton_B",
	"COL_Bucket_C_WH",
	"COL_Broken_D_WH",
	"COL_Cluster_Steel_WH",
	"COL_MedicalEquip_D_WH",
	"COL_Bag_B_WH",
	"COL_Tube_TNT_WH",
}

local PROBABILITY = 0.8
local RANDOM_COUNT = 3




afgh_village_script_c01.wormholePointResourceTableList = {
	{
		name			= "com_wormhole_null001_gim_n0000|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0001|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0002|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0003|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0004|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0005|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0006|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0007|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0008|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0009|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0010|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0011|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0012|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0013|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0014|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0015|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0016|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
	{
		name			= "com_wormhole_null001_gim_n0017|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
}




afgh_village_script_c01.questGimmickTableListTable = {
	[ 1 ] = {	
		{
			locatorName = "cut0_gim_n0000|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0001|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0002|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0003|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0004|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0005|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0006|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0007|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0012|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0014|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0015|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0016|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0017|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0018|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0019|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
	[ 2 ] = {	
		{
			locatorName = "cut0_gim_n0030|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0031|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0032|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0033|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0034|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0035|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0036|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0037|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0038|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0039|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0040|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0041|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0042|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0043|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0044|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0045|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
	[ 3 ] = {	
		{
			locatorName = "cut0_gim_n0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0010|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0011|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0012|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0013|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0014|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0015|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0016|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0017|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0018|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0019|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0020|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0021|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0022|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0023|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0024|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0025|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0026|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0027|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0028|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0029|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0030|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0031|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0032|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0033|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0034|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0035|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0036|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0037|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0042|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0043|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0044|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0045|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
}

return afgh_village_script_c01
