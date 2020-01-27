


local this = BaseFreeMissionEnemy.CreateInstance( "f30010" )
local NULL_ID = GameObject.NULL_ID






this.creatureDataTable = {
	
	[ "zmb_dungeon01_01_0011" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_dungeon01_01_0011",
	},
	[ "zmb_dungeon01_01_0012" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_dungeon01_01_0012",
	},
	[ "zmb_dungeon01_02_0002" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_dungeon01_02_0002",
	},
	[ "zmb_dungeon01_02_0004" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_dungeon01_02_0004",
	},
	[ "com_dungeon01_02_0000" ] = {
		enemytype	= "SsdInsect1",
		route		= "rt_cam_dungeon01_02_0000",
	},
	
	





	
	[ "zmb_140_141_0000" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_140_141_0000",
	},
	[ "zmb_140_141_0001" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_140_141_0001",
	},
	[ "zmb_140_141_0002" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_140_141_0002",
	},
	[ "zmb_136_140_0003" ] = {
		enemytype	= "SsdZombie",
		route		= "rt_zmb_140_141_0003",
	},
	
}


this.kaijuRailList = {
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40035,
		railName	= "rail_kaiju_area01_0000",
		pos			= Vector3( 84.726, 268.516, 2151.428 ),
		isPriority	= false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40035,
		railName	= "rail_kaiju_area01_0001",
		pos			= Vector3( 84.726, 268.516, 2151.428 ),
		isPriority	= false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40077,
		railName	= "rail_kaiju_area01_0000",
		pos			= Vector3( 203.634, 268.539, 2222.073 ),
		isPriority	= true,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40080,
		railName	= "rail_kaiju_area01_0001",
		pos			= Vector3( 203.634, 268.539, 2222.073 ),
		isPriority	=false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40090,
		railName	= "rail_kaiju_area02_0001",
		pos			= Vector3( 1114.630, 309.612, 1278.894 ),
		isPriority	= true,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40130,
		railName	= "rail_kaiju_area02_0000",
		pos			= Vector3( 1151.021, 311.422, 1281.129 ),
		isPriority	= false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.BEFORE_k40140,
		railName	= "rail_kaiju_area02_0001",
		pos			= Vector3( 371.981, 319.860, 1064.557 ),
		isPriority	= true,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH,
		railName	= "rail_kaiju_area01_0000",
		pos			= Vector3( -351.646, 276.677, 1751.485 ),
		isPriority	= false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH,
		railName	= "rail_kaiju_area01_0001",
		pos			= Vector3( 298.586, 274.455, 2209.887 ),
		isPriority	= false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH,
		railName	= "rail_kaiju_area02_0000",
		pos			= Vector3( 656.275, 320.340, 1130.295 ),
		isPriority	= false,
	},
	{	
		sequence	= TppDefine.STORY_SEQUENCE.CLEARED_RETURN_TO_AFGH,
		railName	= "rail_kaiju_area02_0001",
		pos			= Vector3( 802.433, 318.166, 1249.431 ),
		isPriority	= false,
	},
}





this.spawnList = {
	{ id="Spawn", name="west_lv", locator="TppVehicle2GameObject_WestLv0000", type=Vehicle.type.WESTERN_LIGHT_VEHICLE, subType=Vehicle.subType.NONE, },
}





this.walkerGearTableList = {
	{ name = "walkerGear_q74010" },
	{ name = "walkerGear_q74020" },
}





return this
