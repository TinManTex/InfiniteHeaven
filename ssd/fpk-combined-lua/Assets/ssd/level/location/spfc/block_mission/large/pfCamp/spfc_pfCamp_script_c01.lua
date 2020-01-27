



local  spfc_pfCamp_script_c01 = {}




spfc_pfCamp_script_c01.ignoreLoadSmallBlocks = {
}




spfc_pfCamp_script_c01.craftGimmickTableTable = {
	[ Fox.StrCode32( "PRD_BLD_WeaponPlant_B" ) ] = {	
		locatorName = "ssde_wepn001_vrtn001_gim_n0000|srt_ssde_wepn001_vrtn001",
		datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_GadgetPlant_B" ) ] = {	
		locatorName = "com_gadget_plant001_gim_n0000|srt_gadget_plant001",
		datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
	[ Fox.StrCode32( "PRD_BLD_AmmoBox" ) ] = {	
		locatorName = "ssde_boxx011_gim_n0000|srt_ssde_boxx011",
		datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
	},
	[ Fox.StrCode32( "PRD_BLD_Warehouse_A" ) ] = {	
		locatorName = "ssde_boxx001_gim_n0000|srt_ssde_boxx001",
		datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_plant_c01.fox2",
		type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		visible = true,
	},
}




spfc_pfCamp_script_c01.singularityEffectName = "singularity"




spfc_pfCamp_script_c01.impactAreaHeightOffset = -9.809




spfc_pfCamp_script_c01.stealthAreaNameTable = {
	[ Fox.StrCode32( "Gluttony" ) ] = "coop_location_mafr_2_stealth_area_1",	
	[ Fox.StrCode32( "Aerial" ) ] = "coop_location_mafr_2_stealth_area_2",	
}




spfc_pfCamp_script_c01.huntDownRouteNameTable = {
	"HuntDown0000",
	"HuntDown0001",
	"HuntDown0002",
	"HuntDown0003",
	"HuntDown0004",
	"HuntDown0005",
	"HuntDown0006",
	"HuntDown0007",
	"HuntDown0008",
}




spfc_pfCamp_script_c01.walkerGearNameList = {
	"walkerGear_0000",
	"walkerGear_0001",
	"walkerGear_0002",
	"walkerGear_0003",
	"walkerGear_0004",
	"walkerGear_0005",
}




spfc_pfCamp_script_c01.extraTargetGimmickTableListTable = {
	[1] = {
		{
			locatorName = "whm1_gim_n0000|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0000",
			extraTargetRadius = 35,
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0001|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0001",
			extraTargetRadius = 35,
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0002|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0002",
			extraTargetRadius = 45,
			wave = {
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0003|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0003",
			extraTargetRadius = 30,
			wave = {
				[ 3 ] = true,
			},
		},
	},
	[2] = {
		{
			locatorName = "whm1_gim_n0004|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0004",
			extraTargetRadius = 35,
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0005|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0005",
			extraTargetRadius = 20,
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0006|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0006",
			extraTargetRadius = 35,
			wave = {
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0007|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0007",
			extraTargetRadius = 35,
			wave = {
				[ 3 ] = true,
			},
		},
	},
	[3] = {
		{
			locatorName = "whm1_gim_n0008|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0008",
			extraTargetRadius = 30,
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0009|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0009",
			extraTargetRadius = 20,
			wave = {
				[ 1 ] = true,
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0010|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0010",
			extraTargetRadius = 30,
			wave = {
				[ 2 ] = true,
				[ 3 ] = true,
			},
		},
		{
			locatorName = "whm1_gim_n0011|srt_whm1_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_digger_c02.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
			markerName = "marker_extraDigger0011",
			extraTargetRadius = 25,
			wave = {
				[ 3 ] = true,
			},
		},
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

local PROBABILITY = 1
local RANDOM_COUNT = 5




spfc_pfCamp_script_c01.wormholePointResourceTableList = {
	{
		name			= "com_wormhole_null001_gim_n0000|srt_gim_null_wormhole",
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
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
		dataSetName		= "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_wormhole_c01.fox2",
		resources = RESOURCES,
		reset			= false,
		radius			= 45,
		halfSize		= 0,
		probability		= PROBABILITY,
		randomCount		= RANDOM_COUNT,
		randomOffset	= 5,
	},
}




spfc_pfCamp_script_c01.questGimmickTableListTable = {
	[ 1 ] = {	
		{
			locatorName = "cut0_gim_n_01_0000|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0001|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0002|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0003|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0004|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0005|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0006|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0007|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0010|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0011|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0012|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0013|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0014|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0015|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0016|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0017|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0018|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0019|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0020|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0021|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "nad0_main0_def_gim_n_01_0000|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},
	},
	[ 2 ] = {	
		{
			locatorName = "cut0_gim_n_02_0000|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0001|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0002|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0003|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0004|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0005|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0006|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0007|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0010|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0011|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0012|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0013|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0014|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0015|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0016|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0017|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0018|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0019|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0020|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_02_0021|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "nad0_main0_def_gim_n_02_0000|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0000|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0001|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0002|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0003|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0004|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0005|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0006|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_fire001_gim_n_02_0007|srt_ssde_flor001_fire001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0000|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0001|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0002|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0003|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0004|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0005|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
	[ 3 ] = {	
		
		{
			locatorName = "cut0_gim_n_01_0000|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0001|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0002|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0003|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0010|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0011|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0018|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0019|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0020|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_01_0021|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "nad0_main0_def_gim_n_01_0000|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0000|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0001|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "ssde_flor001_cold001_gim_n_02_0002|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "nad0_main0_def_gim_n_02_0000|srt_nad0_main0_def",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN,
		},
		
		{
			locatorName = "cut0_gim_n_03_0000|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0001|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0002|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0003|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0004|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0005|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0006|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0007|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0008|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0009|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0010|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0011|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0012|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0013|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0014|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0015|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0016|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n_03_0017|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/spfc/block_mission/large/pfCamp/spfc_pfCamp_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
}

return spfc_pfCamp_script_c01
