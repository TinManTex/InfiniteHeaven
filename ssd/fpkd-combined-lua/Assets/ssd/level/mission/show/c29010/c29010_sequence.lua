local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionSequence.CreateInstance( "c29010" )

this.INITIAL_CAMERA_ROTATION = { 8, 27.0, }
this.MISSION_START_INITIAL_ACTION = PlayerInitialAction.SQUAT
this.MISSION_WORLD_CENTER = Vector3( 423.0762, 269.7263, 2208.609 )	


this.startFogDensity = 0.009
this.waveFogDensity = 0.008

this.ignoreLoadSmallBlocks = {
	{ 134, 151, },
	{ 134, 152, },
	{ 135, 152, },
	{ 136, 152, },
	{ 137, 152, },
	{ 138, 148, },
	{ 138, 149, },
	{ 138, 150, },
	{ 138, 151, },
	{ 138, 152, },
}

this.time = "13:50:00"
this.fixedTime = true

this.identifier = "coop_location_afgh_1"
this.defensePositionKey = "coop_location_afgh_1_mining_machine_1"

this.targetGimmickTable = {
	locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
	datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c01.fox2",
	type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
}




this.craftGimmickTableTable = {
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

this.singularityEffectName = "singularity"



this.waveFinishShockWaveRadius = 25


this.mapInfoDataIdentifierName = "coop_location_afgh_1"	
this.mapInfoMineName = "mining_machine_1"	
this.mapInfoStealthAreaName = "stealth_area_1"	




this.intervalTimeTable = {
	[ 1 ] = 180,
	[ 2 ] = 180,
	[ 3 ] = 180,
}




this.walkerGearNameList = {
	"walkerGear_0000",
	"walkerGear_0001",
}





this.fastTravelPointNameList = {
}




this.questGimmickTableListTable = {
	{	
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
			locatorName = "cut0_gim_n0038|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0039|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0040|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0041|srt_cut0_main0_def_v00",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{
			locatorName = "cut0_gim_n0042|srt_cut0_main0_def_v00",
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
		{	
			locatorName = "ssde_flor001_cold001_gim_n0025|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0026|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0027|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0028|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0029|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0030|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0031|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0032|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0033|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0034|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0035|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0036|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0037|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
		{	
			locatorName = "ssde_flor001_cold001_gim_n0038|srt_ssde_flor001_cold001",
			datasetName = "/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_gimmick_c01.fox2",
			type = TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		},
	},
}




this.nextMissionId = 21010





this.defenseGameDataJsonFilePath = "/Assets/ssd/level_asset/defense_game/show/c29010_variation.json"




return this
