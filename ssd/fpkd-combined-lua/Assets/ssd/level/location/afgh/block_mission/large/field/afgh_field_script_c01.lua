



local  afgh_field_script_c01 = {}




afgh_field_script_c01.ignoreLoadSmallBlocks = {
	{ 134, 151, },
	{ 134, 152, },
	{ 135, 152, },
	{ 136, 152, },
	{ 137, 152, },
	{ 138, 150, },
	{ 138, 151, },
	{ 138, 152, },
}




afgh_field_script_c01.craftGimmickTableTable = {
	[ Fox.StrCode32( "PRD_BLD_WeaponPlant_B" ) ] = {	
		locatorName = "ssde_wepn001_vrtn001_gim_n0000|srt_ssde_wepn001_vrtn001",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_GadgetPlant_B" ) ] = {	
		locatorName = "com_gadget_plant001_gim_n0000|srt_gadget_plant001",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_AmmoBox" ) ] = {	
		locatorName = "ssde_boxx011_gim_n0000|srt_ssde_boxx011",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Warehouse_A" ) ] = {	
		locatorName = "ssde_boxx001_gim_n0000|srt_ssde_boxx001",
		datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
}




afgh_field_script_c01.singularityEffectName = "singularity"




afgh_field_script_c01.stealthAreaNameTable = {
	[ Fox.StrCode32( "Gluttony" ) ] = "coop_location_afgh_1_stealth_area_1",	
	[ Fox.StrCode32( "Aerial" ) ] = "coop_location_afgh_1_stealth_area_2",	
}




afgh_field_script_c01.huntDownRouteNameTable = {
	"HuntDown0000",
	"HuntDown0001",
	"HuntDown0002",
	"HuntDown0003",
	"HuntDown0004",
	"HuntDown0005",
	"HuntDown0006",
	"HuntDown0007",
	"HuntDown0008",
	"HuntDown0009",
	"HuntDown0010",
	"HuntDown0011",
	"HuntDown0012",
	"HuntDown0013",
	"HuntDown0014",
	"HuntDown0015",
	"RoomHuntDown0000",
	"RoomHuntDown0001",
	"RoomHuntDown0002",
	"RoomHuntDown0003",
}




afgh_field_script_c01.walkerGearNameList = {
	"walkerGear_0000",
	"walkerGear_0001",
	"walkerGear_0002",
	"walkerGear_0003",
	"walkerGear_0004",
	"walkerGear_0005",
}




afgh_field_script_c01.extraTargetGimmickTableListTable = {
	[ 1 ] = {
		{	
			locatorName = "whm1_gim_n0000|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0000",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 20,
			floatingSingularityEffectName = "floatingSingularity_0000",
		},
		{	
			locatorName = "whm1_gim_n0001|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0001",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			extraTargetRadius = 15,
			floatingSingularityEffectName = "floatingSingularity_0001",
		},
		{	
			locatorName = "whm1_gim_n0002|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0002",
			wave = {
				[ 1 ] = false,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0002",
		},
		{	
			locatorName = "whm1_gim_n0003|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0003",
			wave = {
				[ 1 ] = false,
				[ 2 ] = false,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0003",
		},

	},
	[ 2 ] = {
		{	
			locatorName = "whm1_gim_n0004|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0004",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0004",
		},
		{	
			locatorName = "whm1_gim_n0005|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0005",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0005",
		},
		{	
			locatorName = "whm1_gim_n0003|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0003",
			wave = {
				[ 1 ] = false,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0003",
		},
		{	
			locatorName = "whm1_gim_n0010|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0010",
			wave = {
				[ 1 ] = false,
				[ 2 ] = false,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0010",
		},
	},
	[ 3 ] = {
		{	
			locatorName = "whm1_gim_n0007|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0007",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0007",
		},
		{	
			locatorName = "whm1_gim_n0002|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0002",
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0002",
		},
		{	
			locatorName = "whm1_gim_n0009|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0009",
			wave = {
				[ 1 ] = false,
				[ 2 ] = true,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0009",
		},
		{	
			locatorName = "whm1_gim_n0006|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c02/afgh_field_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0006",
			wave = {
				[ 1 ] = false,
				[ 2 ] = false,
				[ 3 ] = true,
				[ 4 ] = true,
				[ 5 ] = true,
			},
			floatingSingularityEffectName = "floatingSingularity_0006",
		},
	},
}




afgh_field_script_c01.breakableGimmickTableList = {
	{
		locatorName = "afgh_wndw003_wdfm001_gim_n0000|srt_afgh_wndw003_glas001_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm001_gim_n0000|srt_afgh_wndw003_glas001_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm001_gim_n0001|srt_afgh_wndw003_glas001_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm001_gim_n0001|srt_afgh_wndw003_glas001_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm001_gim_n0002|srt_afgh_wndw003_glas001_0000",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",
	},
	{
		locatorName = "afgh_wndw003_wdfm001_gim_n0002|srt_afgh_wndw003_glas001_0001",
		datasetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",
	},
}




afgh_field_script_c01.treasurePointTableList = {
	
	{
		
		name = "com_treasure_null001_gim_n0000|srt_gim_null_treasure",
		dataSetName = "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_gimmick.fox2",
		resources = {
			"RES_Oil",
			"RES_Rag",
			"RES_Iron",
			"RES_Wood",
			"RES_Oil",
			"RES_Rag",
			"RES_Iron",
			"RES_Wood",
			"RES_Stainless_Steel", 
			"COL_GunPowderSet5", 
			"RES_Stainless_Steel", 
			"COL_GunPowderSet5", 
		},
		label = "treasurePoint_name_013",	
	},
	
	{
		
		name = "com_treasure_null001_gim_n0000|srt_gim_null_treasure",
		dataSetName = "/Assets/ssd/level/location/afgh/block_small/137/137_149/afgh_137_149_gimmick.fox2",
		resources = {
			"RES_Water_Dirty",
			"RES_Water_Dirty",
			"RES_Water_Dirty",
			"RES_Water_Dirty",
			"RES_Water_Dirty",
		},
		type = "WATER_TAP",	
		label = "treasurePoint_name_001",	
	},
	{
		
		name = "com_treasure_null001_gim_n0001|srt_gim_null_treasure",
		dataSetName = "/Assets/ssd/level/location/afgh/block_small/137/137_149/afgh_137_149_gimmick.fox2",
		resources = {
			"RES_Steel", 
			"RES_Steel", 
			"RES_Stainless_Steel", 
			"COL_GunPowderSet5", 
		},
		label = "treasurePoint_name_013",	
	},
	
	{
		
		name = "com_treasure_null001_gim_n0000|srt_gim_null_treasure",
		dataSetName = "/Assets/ssd/level/location/afgh/block_small/138/138_148/afgh_138_148_gimmick.fox2",
		resources = {
			"COL_WireSet3", 
			"RES_Stainless_Steel", 
			"COL_GunPowderSet5", 
		},
		label = "treasurePoint_name_015",	
	},
}




afgh_field_script_c01.treasureBoxTableList = {
	
	{
		name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
		dataSetName			= "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",	
		breakResources		= {
			"COL_WoodBox_E",
			"COL_Drum_A",
			"COL_GunPowderPack_WH",
		},
		breakRandomCount	= 0,
		damageRate			= 1,
		pickingDifficulty = 1,
	},
	
	{
		name				= "ssde_boxx004_gim_n0003|srt_ssde_boxx004",
		dataSetName			= "/Assets/ssd/level/location/afgh/block_large/field/afgh_field_asset.fox2",	
		breakResources		= {
			"COL_Bottle_C_WH",
			"COL_Tube_TNT_WH",
			"COL_WoodStick_Nail",
		},
		breakRandomCount	= 0,
		damageRate			= 1,
		pickingDifficulty = 1,
	},
	
	{
		name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
		dataSetName			= "/Assets/ssd/level/location/afgh/block_small/137/137_149/afgh_137_149_gimmick.fox2",
		breakResources		= {
			"COL_GunPowderPack_WH",
			"COL_Tube_TNT_WH",
			"COL_Broken_D_WH",
		},
		breakRandomCount	= 0,
		damageRate			= 1,
		pickingDifficulty = 1,
	},
	
	{
		name				= "ssde_boxx004_gim_n0000|srt_ssde_boxx004",
		dataSetName			= "/Assets/ssd/level/location/afgh/block_small/135/135_150/afgh_135_150_gimmick.fox2",
		breakResources		= {
			"COL_Cluster_Fabric_WH",
			"COL_GunPowderPack_WH",
			"COL_Cluster_Steel_WH",
		},
		breakRandomCount	= 0,
		damageRate			= 1,
		pickingDifficulty = 1,
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
	"COL_Tire_B_WH",
	"COL_Bottle_C_WH",
	"COL_Oil",
	"COL_Tableware_G_WH",
	"COL_Ashtray_WH",
	"COL_Bucket_C_WH",
	"COL_Cluster_Steel_WH",
	"COL_MedicalEquip_D_WH",
	"COL_Tube_TNT_WH",
}

local PROBABILITY = 0.8
local RANDOM_COUNT = 3




afgh_field_script_c01.wormholePointResourceTableList = {
	{
		name			= "com_wormhole_null001_gim_n0000|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
}




afgh_field_script_c01.questGimmickTableListTable = {
	[ 1 ] = {	
		{	
			locatorName = "nad0_main0_def_gim_n0000|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},

		{	
			locatorName = "hw00_gim_n0000|srt_hw00_main0_def",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_MORTAR,
		},

		{
			locatorName = "cut0_gim_n0000|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0001|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0002|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0003|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0004|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0005|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0006|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0007|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0010|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0011|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0012|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0013|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0014|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},

		{	
			locatorName = "ssde_flor001_cold001_gim_n0000|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0001|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0002|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0003|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0004|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0005|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0006|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0007|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0008|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0009|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0010|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0011|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0012|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
	[ 2 ] = {	
		{	
			locatorName = "nad0_main0_def_gim_n0001|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},

		{
			locatorName = "cut0_gim_n0015|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0016|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0017|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0018|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0019|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0020|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0021|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0022|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},

		{	
			locatorName = "ssde_flor001_cold001_gim_n0006|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0007|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0008|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0009|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0010|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0011|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0012|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0013|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0014|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0015|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0016|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0017|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0018|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
	[ 3 ] = {	
		{	
			locatorName = "nad0_main0_def_gim_n0002|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},

		{	
			locatorName = "hw00_gim_n0002|srt_hw00_main0_def",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_MORTAR,
		},

		{
			locatorName = "cut0_gim_n0023|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0024|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0025|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0026|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0027|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0028|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0029|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0030|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0031|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0032|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0033|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0034|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0035|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0036|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0037|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},

		{	
			locatorName = "ssde_flor001_cold001_gim_n0019|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0020|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0021|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0022|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0023|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0024|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
}

return afgh_field_script_c01
