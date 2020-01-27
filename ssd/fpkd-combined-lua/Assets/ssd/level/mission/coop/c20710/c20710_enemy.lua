local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionEnemy.CreateInstance( "c20710" )




this.dropInstanceCountSettingTableList = {
	{	
		typeName = "SsdBoss3",
		count = 1,
	},
	{	
		typeName = "SsdBoss1",
		count = 1,
	},
	{	
		typeName = "SsdZombie",
		count = 4,
	},
	{	
		typeName = "SsdZombiePack",
		count = 4,
	},
	{	
		typeName = "SsdInsect1",
		count = 4,
	},
	{	
		typeName = "SsdInsect2",
		count = 4,
	},
	{	
		typeName = "SsdInsect3",
		count = 4,
	},
	{	
		typeName = "SsdDestroyer",
		count = 1,
	},
}




this.mapRouteNameListTable = {
	
	
	
	rt_SpawnPoint_01_0000_zmb_0000 = {
		"rt_SpawnPoint_01_0000_zmb_0000",
	},
	rt_SpawnPoint_01_0000_zmb_0001 = {
		"rt_SpawnPoint_01_0000_zmb_0001",
	},
	rt_SpawnPoint_01_0001_zmb_0000 = {
		"rt_SpawnPoint_01_0001_zmb_0000",
	},
	rt_SpawnPoint_01_0001_zmb_0001 = {
		"rt_SpawnPoint_01_0001_zmb_0001",
	},
	rt_SpawnPoint_01_0002_zmb_0000 = {
		"rt_SpawnPoint_01_0002_zmb_0000",
	},
	rt_SpawnPoint_01_0003_zmb_0000 = {
		"rt_SpawnPoint_01_0003_zmb_0000",
	},
	rt_SpawnPoint_01_0003_zmb_0001 = {
		"rt_SpawnPoint_01_0003_zmb_0001",
	},
	rt_SpawnPoint_01_0004_zmb_0000 = {
		"rt_SpawnPoint_01_0004_zmb_0000",
	},
	rt_SpawnPoint_01_0004_zmb_0001 = {
		"rt_SpawnPoint_01_0004_zmb_0001",
	},
	rt_SpawnPoint_01_0004_zmb_0002 = {
		"rt_SpawnPoint_01_0004_zmb_0002",
	},
	rt_SpawnPoint_01_0005_zmb_0000 = {
		"rt_SpawnPoint_01_0005_zmb_0000",
	},
	rt_SpawnPoint_01_0006_zmb_0000 = {
		"rt_SpawnPoint_01_0006_zmb_0000",
	},
	rt_SpawnPoint_01_0006_zmb_0001 = {
		"rt_SpawnPoint_01_0006_zmb_0001",
	},
	
	
	
	rt_SpawnPoint_02_0000_zmb_0000 = {
		"rt_SpawnPoint_02_0000_zmb_0000",
	},
	rt_SpawnPoint_02_0000_zmb_0001 = {
		"rt_SpawnPoint_02_0000_zmb_0001",
	},
	rt_SpawnPoint_02_0000_zmb_0002 = {
		"rt_SpawnPoint_02_0000_zmb_0002",
	},
	rt_SpawnPoint_02_0001_zmb_0000 = {
		"rt_SpawnPoint_02_0001_zmb_0000",
	},
	rt_SpawnPoint_02_0002_zmb_0000 = {
		"rt_SpawnPoint_02_0002_zmb_0000",
	},
	rt_SpawnPoint_02_0002_zmb_0001 = {
		"rt_SpawnPoint_02_0002_zmb_0001",
	},
	rt_SpawnPoint_02_0003_zmb_0000 = {
		"rt_SpawnPoint_02_0003_zmb_0000",
	},
	rt_SpawnPoint_02_0003_zmb_0001 = {
		"rt_SpawnPoint_02_0003_zmb_0001",
	},
	rt_SpawnPoint_02_0004_zmb_0000 = {
		"rt_SpawnPoint_02_0004_zmb_0000",
	},
	rt_SpawnPoint_02_0005_zmb_0000 = {
		"rt_SpawnPoint_02_0005_zmb_0000",
	},
	rt_SpawnPoint_02_0006_zmb_0000 = {
		"rt_SpawnPoint_02_0006_zmb_0000",
	},
	rt_SpawnPoint_02_0007_zmb_0000 = {
		"rt_SpawnPoint_02_0007_zmb_0000",
	},
	
	
	
	rt_SpawnPoint_03_0000_zmb_0000 = {
		"rt_SpawnPoint_03_0000_zmb_0000",
	},
	rt_SpawnPoint_03_0000_zmb_0001 = {
		"rt_SpawnPoint_03_0000_zmb_0001",
	},
	rt_SpawnPoint_03_0001_zmb_0000 = {
		"rt_SpawnPoint_03_0001_zmb_0000",
	},
	rt_SpawnPoint_03_0001_zmb_0001 = {
		"rt_SpawnPoint_03_0001_zmb_0001",
	},
	rt_SpawnPoint_03_0002_zmb_0000 = {
		"rt_SpawnPoint_03_0002_zmb_0000",
	},
	rt_SpawnPoint_03_0002_zmb_0001 = {
		"rt_SpawnPoint_03_0002_zmb_0001",
	},
	rt_SpawnPoint_03_0003_zmb_0000 = {
		"rt_SpawnPoint_03_0003_zmb_0000",
	},
	rt_SpawnPoint_03_0003_zmb_0001 = {
		"rt_SpawnPoint_03_0003_zmb_0001",
	},
	rt_SpawnPoint_03_0004_zmb_0000 = {
		"rt_SpawnPoint_03_0004_zmb_0000",
	},
	rt_SpawnPoint_03_0004_zmb_0001 = {
		"rt_SpawnPoint_03_0004_zmb_0001",
	},
	rt_SpawnPoint_03_0005_zmb_0000 = {
		"rt_SpawnPoint_03_0005_zmb_0000",
	},
	rt_SpawnPoint_03_0005_zmb_0001 = {
		"rt_SpawnPoint_03_0005_zmb_0001",
	},
	rt_SpawnPoint_03_0006_zmb_0000 = {
		"rt_SpawnPoint_03_0006_zmb_0000",
	},
	rt_SpawnPoint_03_0006_zmb_0001 = {
		"rt_SpawnPoint_03_0006_zmb_0001",
	},
}

return this
