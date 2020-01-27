local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionEnemy.CreateInstance( "c20010" )




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
		count = 8,
	},
	{	
		typeName = "SsdInsect2",
		count = 8,
	},
	{	
		typeName = "SsdInsect3",
		count = 8,
	},
	{	
		typeName = "SsdDestroyer",
		count = 1,
	},
}




this.mapRouteNameListTable = {
	rt_SpawnPoint_E_0000_0000 = {
		"rt_SpawnPoint_E_0000_0000",
	},
	rt_SpawnPoint_E_0000_0001 = {
		"rt_SpawnPoint_E_0000_0001",
	},
	rt_SpawnPoint_E_0000_0002 = {
		"rt_SpawnPoint_E_0000_0002",
	},
	rt_SpawnPoint_E_0000_0003 = {
		"rt_SpawnPoint_E_0000_0003",
	},
	rt_SpawnPoint_E_0001_0000 = {
		"rt_SpawnPoint_E_0001_0000",
	},
	rt_SpawnPoint_E_0001_0001 = {
		"rt_SpawnPoint_E_0001_0001",
	},
	rt_SpawnPoint_E_0001_0002 = {
		"rt_SpawnPoint_E_0001_0002",
	},
	rt_SpawnPoint_E_0001_0003 = {
		"rt_SpawnPoint_E_0001_0003",
	},
	rt_SpawnPoint_E_0002_0000 = {
		"rt_SpawnPoint_E_0002_0000",
	},
	rt_SpawnPoint_E_0002_0001 = {
		"rt_SpawnPoint_E_0002_0001",
	},
	rt_SpawnPoint_E_0002_0002 = {
		"rt_SpawnPoint_E_0002_0002",
	},
	rt_SpawnPoint_E_0002_0003 = {
		"rt_SpawnPoint_E_0002_0003",
	},
	rt_SpawnPoint_NE_0000_0000 = {
		"rt_SpawnPoint_NE_0000_0000",
	},
	rt_SpawnPoint_NE_0000_0001 = {
		"rt_SpawnPoint_NE_0000_0001",
	},
	rt_SpawnPoint_NE_0000_0002 = {
		"rt_SpawnPoint_NE_0000_0002",
	},
	rt_SpawnPoint_NE_0000_0003 = {
		"rt_SpawnPoint_NE_0000_0003",
	},
	rt_SpawnPoint_NE_0001_0000 = {
		"rt_SpawnPoint_NE_0001_0000",
	},
	rt_SpawnPoint_NE_0001_0001 = {
		"rt_SpawnPoint_NE_0001_0001",
	},
	rt_SpawnPoint_NE_0001_0002 = {
		"rt_SpawnPoint_NE_0001_0002",
	},
	rt_SpawnPoint_NE_0001_0003 = {
		"rt_SpawnPoint_NE_0001_0003",
	},
	rt_SpawnPoint_NE_0002_0000 = {
		"rt_SpawnPoint_NE_0002_0000",
	},
	rt_SpawnPoint_NE_0002_0001 = {
		"rt_SpawnPoint_NE_0002_0001",
	},
	rt_SpawnPoint_NE_0002_0002 = {
		"rt_SpawnPoint_NE_0002_0002",
	},
	rt_SpawnPoint_NE_0002_0003 = {
		"rt_SpawnPoint_NE_0002_0003",
	},
	rt_SpawnPoint_NE_0003_0000 = {
		"rt_SpawnPoint_NE_0003_0000",
	},
	rt_SpawnPoint_NE_0003_0001 = {
		"rt_SpawnPoint_NE_0003_0001",
	},
	rt_SpawnPoint_NE_0003_0002 = {
		"rt_SpawnPoint_NE_0003_0002",
	},
	rt_SpawnPoint_NE_0003_0003 = {
		"rt_SpawnPoint_NE_0003_0003",
	},
	rt_SpawnPoint_NE_0004_0000 = {
		"rt_SpawnPoint_NE_0004_0000",
	},
	rt_SpawnPoint_NE_0004_0001 = {
		"rt_SpawnPoint_NE_0004_0001",
	},
	rt_SpawnPoint_NE_0004_0002 = {
		"rt_SpawnPoint_NE_0004_0002",
	},
	rt_SpawnPoint_NE_0004_0003 = {
		"rt_SpawnPoint_NE_0004_0003",
	},
	rt_SpawnPoint_NE_0005_0000 = {
		"rt_SpawnPoint_NE_0005_0000",
	},
	rt_SpawnPoint_NE_0005_0001 = {
		"rt_SpawnPoint_NE_0005_0001",
	},
	rt_SpawnPoint_NE_0005_0002 = {
		"rt_SpawnPoint_NE_0005_0002",
	},
	rt_SpawnPoint_NE_0005_0003 = {
		"rt_SpawnPoint_NE_0005_0003",
	},
	rt_SpawnPoint_NW_0000_0000 = {
		"rt_SpawnPoint_NW_0000_0000",
	},
	rt_SpawnPoint_NW_0000_0001 = {
		"rt_SpawnPoint_NW_0000_0001",
	},
	rt_SpawnPoint_NW_0000_0002 = {
		"rt_SpawnPoint_NW_0000_0002",
	},
	rt_SpawnPoint_NW_0000_0003 = {
		"rt_SpawnPoint_NW_0000_0003",
	},
	rt_SpawnPoint_NW_0000_0004 = {
		"rt_SpawnPoint_NW_0000_0004",
	},
	rt_SpawnPoint_NW_0000_0005 = {
		"rt_SpawnPoint_NW_0000_0005",
	},
	rt_SpawnPoint_NW_0001_0000 = {
		"rt_SpawnPoint_NW_0001_0000",
	},
	rt_SpawnPoint_NW_0001_0001 = {
		"rt_SpawnPoint_NW_0001_0001",
	},
	rt_SpawnPoint_NW_0001_0002 = {
		"rt_SpawnPoint_NW_0001_0002",
	},
	rt_SpawnPoint_NW_0001_0003 = {
		"rt_SpawnPoint_NW_0001_0003",
	},
	rt_SpawnPoint_NW_0002_0000 = {
		"rt_SpawnPoint_NW_0002_0000",
	},
	rt_SpawnPoint_NW_0002_0001 = {
		"rt_SpawnPoint_NW_0002_0001",
	},
	rt_SpawnPoint_NW_0002_0002 = {
		"rt_SpawnPoint_NW_0002_0002",
	},
	rt_SpawnPoint_NW_0002_0003 = {
		"rt_SpawnPoint_NW_0002_0003",
	},
	rt_SpawnPoint_NW_0003_0000 = {
		"rt_SpawnPoint_NW_0003_0000",
	},
	rt_SpawnPoint_NW_0003_0001 = {
		"rt_SpawnPoint_NW_0003_0001",
	},
	rt_SpawnPoint_NW_0003_0002 = {
		"rt_SpawnPoint_NW_0003_0002",
	},
	rt_SpawnPoint_NW_0003_0003 = {
		"rt_SpawnPoint_NW_0003_0003",
	},
	rt_SpawnPoint_NW_0004_0000 = {
		"rt_SpawnPoint_NW_0004_0000",
	},
	rt_SpawnPoint_NW_0004_0001 = {
		"rt_SpawnPoint_NW_0004_0001",
	},
	rt_SpawnPoint_NW_0004_0002 = {
		"rt_SpawnPoint_NW_0004_0002",
	},
	rt_SpawnPoint_NW_0004_0003 = {
		"rt_SpawnPoint_NW_0004_0003",
	},
	rt_SpawnPoint_NW_0005_0000 = {
		"rt_SpawnPoint_NW_0005_0000",
	},
	rt_SpawnPoint_NW_0005_0001 = {
		"rt_SpawnPoint_NW_0005_0001",
	},
	rt_SpawnPoint_NW_0005_0002 = {
		"rt_SpawnPoint_NW_0005_0002",
	},
	rt_SpawnPoint_NW_0005_0003 = {
		"rt_SpawnPoint_NW_0005_0003",
	},
	rt_SpawnPoint_SE_0000_0000 = {
		"rt_SpawnPoint_SE_0000_0000",
	},
	rt_SpawnPoint_SE_0000_0001 = {
		"rt_SpawnPoint_SE_0000_0001",
	},
	rt_SpawnPoint_SE_0000_0002 = {
		"rt_SpawnPoint_SE_0000_0002",
	},
	rt_SpawnPoint_SE_0000_0003 = {
		"rt_SpawnPoint_SE_0000_0003",
	},
	rt_SpawnPoint_SE_0001_0000 = {
		"rt_SpawnPoint_SE_0001_0000",
	},
	rt_SpawnPoint_SE_0001_0001 = {
		"rt_SpawnPoint_SE_0001_0001",
	},
	rt_SpawnPoint_SE_0001_0002 = {
		"rt_SpawnPoint_SE_0001_0002",
	},
	rt_SpawnPoint_SE_0001_0003 = {
		"rt_SpawnPoint_SE_0001_0003",
	},
	rt_SpawnPoint_SE_0002_0000 = {
		"rt_SpawnPoint_SE_0002_0000",
	},
	rt_SpawnPoint_SE_0002_0001 = {
		"rt_SpawnPoint_SE_0002_0001",
	},
	rt_SpawnPoint_SE_0002_0002 = {
		"rt_SpawnPoint_SE_0002_0002",
	},
	rt_SpawnPoint_SE_0002_0003 = {
		"rt_SpawnPoint_SE_0002_0003",
	},
	rt_SpawnPoint_SE_0003_0000 = {
		"rt_SpawnPoint_SE_0003_0000",
	},
	rt_SpawnPoint_SE_0003_0001 = {
		"rt_SpawnPoint_SE_0003_0001",
	},
	rt_SpawnPoint_SE_0003_0002 = {
		"rt_SpawnPoint_SE_0003_0002",
	},
	rt_SpawnPoint_SE_0003_0003 = {
		"rt_SpawnPoint_SE_0003_0003",
	},
	rt_SpawnPoint_SE_0004_0000 = {
		"rt_SpawnPoint_SE_0004_0000",
	},
	rt_SpawnPoint_SE_0004_0001 = {
		"rt_SpawnPoint_SE_0004_0001",
	},
	rt_SpawnPoint_SE_0004_0002 = {
		"rt_SpawnPoint_SE_0004_0002",
	},
	rt_SpawnPoint_SE_0004_0003 = {
		"rt_SpawnPoint_SE_0004_0003",
	},
	rt_SpawnPoint_SE_0005_0000 = {
		"rt_SpawnPoint_SE_0005_0000",
	},
	rt_SpawnPoint_SE_0005_0001 = {
		"rt_SpawnPoint_SE_0005_0001",
	},
	rt_SpawnPoint_SE_0005_0002 = {
		"rt_SpawnPoint_SE_0005_0002",
	},
	rt_SpawnPoint_SE_0005_0003 = {
		"rt_SpawnPoint_SE_0005_0003",
	},
	rt_SpawnPoint_SW_0000_0000 = {
		"rt_SpawnPoint_SW_0000_0000",
	},
	rt_SpawnPoint_SW_0000_0000 = {
		"rt_SpawnPoint_SW_0000_0000",
	},
	rt_SpawnPoint_SW_0000_0001 = {
		"rt_SpawnPoint_SW_0000_0001",
	},
	rt_SpawnPoint_SW_0000_0002 = {
		"rt_SpawnPoint_SW_0000_0002",
	},
	rt_SpawnPoint_SW_0000_0003 = {
		"rt_SpawnPoint_SW_0000_0003",
	},
	rt_SpawnPoint_SW_0001_0000 = {
		"rt_SpawnPoint_SW_0001_0000",
	},
	rt_SpawnPoint_SW_0001_0001 = {
		"rt_SpawnPoint_SW_0001_0001",
	},
	rt_SpawnPoint_SW_0001_0002 = {
		"rt_SpawnPoint_SW_0001_0002",
	},
	rt_SpawnPoint_SW_0001_0003 = {
		"rt_SpawnPoint_SW_0001_0003",
	},
	rt_SpawnPoint_SW_0002_0000 = {
		"rt_SpawnPoint_SW_0002_0000",
	},
	rt_SpawnPoint_SW_0002_0001 = {
		"rt_SpawnPoint_SW_0002_0001",
	},
	rt_SpawnPoint_SW_0002_0002 = {
		"rt_SpawnPoint_SW_0002_0002",
	},
	rt_SpawnPoint_SW_0002_0003 = {
		"rt_SpawnPoint_SW_0002_0003",
	},
	rt_SpawnPoint_SW_0003_0000 = {
		"rt_SpawnPoint_SW_0003_0000",
	},
	rt_SpawnPoint_SW_0003_0001 = {
		"rt_SpawnPoint_SW_0003_0001",
	},
	rt_SpawnPoint_SW_0003_0002 = {
		"rt_SpawnPoint_SW_0003_0002",
	},
	rt_SpawnPoint_SW_0003_0003 = {
		"rt_SpawnPoint_SW_0003_0003",
	},
	rt_SpawnPoint_SW_0004_0000 = {
		"rt_SpawnPoint_SW_0004_0000",
	},
	rt_SpawnPoint_SW_0004_0001 = {
		"rt_SpawnPoint_SW_0004_0001",
	},
	rt_SpawnPoint_SW_0004_0002 = {
		"rt_SpawnPoint_SW_0004_0002",
	},
	rt_SpawnPoint_SW_0004_0003 = {
		"rt_SpawnPoint_SW_0004_0003",
	},
	rt_SpawnPoint_SW_0005_0000 = {
		"rt_SpawnPoint_SW_0005_0000",
	},
	rt_SpawnPoint_SW_0005_0001 = {
		"rt_SpawnPoint_SW_0005_0001",
	},
	rt_SpawnPoint_SW_0005_0002 = {
		"rt_SpawnPoint_SW_0005_0002",
	},
	rt_SpawnPoint_SW_0005_0003 = {
		"rt_SpawnPoint_SW_0005_0003",
	},
	rt_SpawnPoint_U_0000_0000 = {
		"rt_SpawnPoint_U_0000_0000",
	},
	rt_SpawnPoint_U_0000_0001 = {
		"rt_SpawnPoint_U_0000_0001",
	},
	rt_SpawnPoint_U_0000_0002 = {
		"rt_SpawnPoint_U_0000_0002",
	},
	rt_SpawnPoint_U_0000_0003 = {
		"rt_SpawnPoint_U_0000_0003",
	},
}

return this
