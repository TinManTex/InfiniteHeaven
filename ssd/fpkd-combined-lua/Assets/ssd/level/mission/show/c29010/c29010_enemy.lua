local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionEnemy.CreateInstance( "c29010" )




this.dropInstanceCountSettingTableList = {
	{	
		typeName = "SsdZombie",
		count = 4,
	},
	{	
		typeName = "SsdZombieArmor",
		count = 2,
	},
}




this.mapRouteNameListTable = {
	rt_SpawnPoint_E_0000_0000 = {
		"map_rt_SpawnPoint_E_0000_0009",
	},
	rt_SpawnPoint_E_0000_0001 = {
		"map_rt_SpawnPoint_E_0000_0010",
	},
	rt_SpawnPoint_E_0000_0002 = {
		"map_rt_SpawnPoint_E_0000_0006",
		"map_rt_SpawnPoint_E_0000_0007",
	},
	rt_SpawnPoint_E_0000_0003 = {
		"map_rt_SpawnPoint_E_0000_0008",
		"map_rt_SpawnPoint_E_0002_0001",
		"map_rt_SpawnPoint_E_0002_0002",
		"map_rt_SpawnPoint_E_0002_0007",
		"map_rt_SpawnPoint_NE_0000_0003",
	},
	rt_SpawnPoint_E_0001_0000 = {
		"map_rt_SpawnPoint_E_0001_0005",
	},
	rt_SpawnPoint_E_0001_0001 = {
		"map_rt_SpawnPoint_E_0001_0005",
	},
	rt_SpawnPoint_E_0001_0002 = {
		"map_rt_SpawnPoint_E_0001_0001",
		"map_rt_SpawnPoint_E_0001_0002",
	},
	rt_SpawnPoint_E_0001_0003 = {
		"map_rt_SpawnPoint_E_0001_0001",
		"map_rt_SpawnPoint_E_0001_0003",
		"map_rt_SpawnPoint_E_0001_0004",
	},
	rt_SpawnPoint_E_0002_0000 = {
		"map_rt_SpawnPoint_E_0002_0008",
	},
	rt_SpawnPoint_E_0002_0001 = {
		"map_rt_SpawnPoint_E_0002_0009",
	},
	rt_SpawnPoint_E_0002_0002 = {
		"map_rt_SpawnPoint_E_0002_0006",
		"map_rt_SpawnPoint_E_0002_0007",
		"map_rt_SpawnPoint_NE_0000_0003",
	},
	rt_SpawnPoint_E_0002_0003 = {
		"map_rt_SpawnPoint_E_0002_0007",
		"map_rt_SpawnPoint_NE_0000_0003",
	},
	rt_SpawnPoint_NE_0000_0000 = {
		"map_rt_SpawnPoint_NE_0000_0009",
	},
	rt_SpawnPoint_NE_0000_0001 = {
		"map_rt_SpawnPoint_NE_0000_0009",
	},
	rt_SpawnPoint_NE_0000_0002 = {
		"map_rt_SpawnPoint_NE_0000_0010",
	},
	rt_SpawnPoint_NE_0000_0003 = {
		"map_rt_SpawnPoint_NE_0000_0011",
	},
	rt_SpawnPoint_NE_0001_0000 = {
		"map_rt_SpawnPoint_NE_0001_0005",
	},
	rt_SpawnPoint_NE_0001_0001 = {
		"map_rt_SpawnPoint_NE_0001_0006",
	},
	rt_SpawnPoint_NE_0001_0002 = {
		"map_rt_SpawnPoint_NE_0001_0001",
		"map_rt_SpawnPoint_NE_0001_0002",
		"map_rt_SpawnPoint_NE_0001_0003",
	},
	rt_SpawnPoint_NE_0001_0003 = {
		"map_rt_SpawnPoint_NE_0001_0001",
		"map_rt_SpawnPoint_NE_0001_0002",
		"map_rt_SpawnPoint_NE_0001_0004",
	},
	rt_SpawnPoint_NE_0002_0000 = {
		"map_rt_SpawnPoint_NE_0002_0007",
	},
	rt_SpawnPoint_NE_0002_0001 = {
		"map_rt_SpawnPoint_NE_0002_0010",
	},
	rt_SpawnPoint_NE_0002_0002 = {
		"map_rt_SpawnPoint_NE_0000_0006",
		"map_rt_SpawnPoint_NE_0000_0007",
		"map_rt_SpawnPoint_NE_0000_0008",
		"map_rt_SpawnPoint_NE_0002_0008",
	},
	rt_SpawnPoint_NE_0002_0003 = {
		"map_rt_SpawnPoint_NE_0002_0009",
	},
	rt_SpawnPoint_NW_0000_0000 = {
		"map_rt_SpawnPoint_NW_0000_0015",
	},
	rt_SpawnPoint_NW_0000_0001 = {
		"map_rt_SpawnPoint_NE_0001_0003",
	},
	rt_SpawnPoint_NW_0000_0002 = {
		"map_rt_SpawnPoint_NW_0000_0001",
		"map_rt_SpawnPoint_NW_0000_0002",
	},
	rt_SpawnPoint_NW_0000_0003 = {
		"map_rt_SpawnPoint_NW_0000_0001",
		"map_rt_SpawnPoint_NW_0000_0002",
	},
	rt_SpawnPoint_NW_0000_0004 = {
		"map_rt_SpawnPoint_NW_0000_0004",
		"map_rt_SpawnPoint_NW_0000_0005",
		"map_rt_SpawnPoint_NW_0000_0006",
		"map_rt_SpawnPoint_NW_0000_0010",
		"map_rt_SpawnPoint_NW_0000_0011",
		"map_rt_SpawnPoint_NW_0000_0012",
	},
	rt_SpawnPoint_NW_0000_0005 = {
		"map_rt_SpawnPoint_NW_0000_0004",
		"map_rt_SpawnPoint_NW_0000_0005",
		"map_rt_SpawnPoint_NW_0000_0006",
		"map_rt_SpawnPoint_NW_0000_0010",
		"map_rt_SpawnPoint_NW_0000_0011",
		"map_rt_SpawnPoint_NW_0000_0013",
		"map_rt_SpawnPoint_NW_0000_0014",
	},
	rt_SpawnPoint_NW_0001_0000 = {
		"map_rt_SpawnPoint_NW_0001_0004",
	},
	rt_SpawnPoint_NW_0001_0001 = {
		"map_rt_SpawnPoint_NE_0001_0003",
	},
	rt_SpawnPoint_NW_0001_0002 = {
		"map_rt_SpawnPoint_NW_0000_0001",
		"map_rt_SpawnPoint_NW_0000_0002",
	},
	rt_SpawnPoint_NW_0001_0003 = {
		"map_rt_SpawnPoint_NW_0000_0006",
		"map_rt_SpawnPoint_NW_0000_0009",
		"map_rt_SpawnPoint_NW_0000_0010",
		"map_rt_SpawnPoint_NW_0000_0011",
		"map_rt_SpawnPoint_NW_0000_0012",
		"map_rt_SpawnPoint_NW_0001_0003",
	},
	rt_SpawnPoint_NW_0002_0000 = {
		"map_rt_SpawnPoint_NW_0002_0001",
	},
	rt_SpawnPoint_NW_0002_0001 = {
		"map_rt_SpawnPoint_NE_0001_0004",
	},
	rt_SpawnPoint_NW_0002_0002 = {
		"map_rt_SpawnPoint_NW_0000_0001",
		"map_rt_SpawnPoint_NW_0000_0002",
	},
	rt_SpawnPoint_NW_0002_0003 = {
		"map_rt_SpawnPoint_NW_0000_0001",
		"map_rt_SpawnPoint_NW_0000_0003",
	},
	rt_SpawnPoint_SE_0000_0000 = {
		"map_rt_SpawnPoint_SE_0000_0003",
	},
	rt_SpawnPoint_SE_0000_0001 = {
		"map_rt_SpawnPoint_SE_0000_0003",
	},
	rt_SpawnPoint_SE_0000_0002 = {
		"map_rt_SpawnPoint_E_0001_0001",
		"map_rt_SpawnPoint_E_0001_0002",
	},
	rt_SpawnPoint_SE_0000_0003 = {
		"map_rt_SpawnPoint_E_0001_0001",
		"map_rt_SpawnPoint_E_0001_0003",
		"map_rt_SpawnPoint_E_0001_0004",
	},
	rt_SpawnPoint_SE_0001_0000 = {
		"map_rt_SpawnPoint_SE_0001_0005",
	},
	rt_SpawnPoint_SE_0001_0001 = {
	},
	rt_SpawnPoint_SE_0001_0002 = {
		"map_rt_SpawnPoint_E_0001_0002",
		"map_rt_SpawnPoint_SE_0001_0004",
	},
	rt_SpawnPoint_SE_0001_0003 = {
		"map_rt_SpawnPoint_E_0001_0003",
		"map_rt_SpawnPoint_E_0001_0004",
		"map_rt_SpawnPoint_SE_0001_0004",
	},
	rt_SpawnPoint_SE_0002_0000 = {
		"map_rt_SpawnPoint_SE_0002_0005",
	},
	rt_SpawnPoint_SE_0002_0001 = {
		"map_rt_SpawnPoint_SE_0002_0005",
	},
	rt_SpawnPoint_SE_0002_0002 = {
		"maps_rt_SpawnPoint_SE_0002_0002_0000",
	},
	rt_SpawnPoint_SE_0002_0003 = {
		"maps_rt_SpawnPoint_SE_0002_0003_0000",
	},
	rt_SpawnPoint_SW_0000_0000 = {
		"map_rt_SpawnPoint_SW_0000_0013",
	},
	rt_SpawnPoint_SW_0000_0000 = {
		"map_rt_SpawnPoint_SW_0000_0013",
	},
	rt_SpawnPoint_SW_0000_0001 = {
		"map_rt_SpawnPoint_SW_0000_0014",
	},
	rt_SpawnPoint_SW_0000_0002 = {
		"map_rt_SpawnPoint_SW_0000_0005",
		"map_rt_SpawnPoint_SW_0000_0006",
		"map_rt_SpawnPoint_SW_0000_0007",
		"map_rt_SpawnPoint_SW_0000_0008",
		"map_rt_SpawnPoint_SW_0000_0009",
	},
	rt_SpawnPoint_SW_0000_0003 = {
		"map_rt_SpawnPoint_SW_0000_0009",
		"map_rt_SpawnPoint_SW_0000_0010",
		"map_rt_SpawnPoint_SW_0000_0011",
	},
	rt_SpawnPoint_SW_0001_0000 = {
		"map_rt_SpawnPoint_SW_0001_0007",
	},
	rt_SpawnPoint_SW_0001_0001 = {
		"map_rt_SpawnPoint_SW_0001_0008",
	},
	rt_SpawnPoint_SW_0001_0002 = {
		"map_rt_SpawnPoint_SW_0000_0009",
		"map_rt_SpawnPoint_SW_0000_0011",
		"map_rt_SpawnPoint_SW_0001_0001",
		"map_rt_SpawnPoint_SW_0001_0002",
		"map_rt_SpawnPoint_SW_0001_0003",
	},
	rt_SpawnPoint_SW_0001_0003 = {
		"map_rt_SpawnPoint_SW_0000_0008",
		"map_rt_SpawnPoint_SW_0000_0009",
		"map_rt_SpawnPoint_SW_0001_0001",
		"map_rt_SpawnPoint_SW_0001_0002",
		"map_rt_SpawnPoint_SW_0001_0003",
	},
	rt_SpawnPoint_SW_0001_0004 = {
		"map_rt_SpawnPoint_NW_0000_0006",
		"map_rt_SpawnPoint_NW_0000_0007",
		"map_rt_SpawnPoint_NW_0000_0008",
		"map_rt_SpawnPoint_NW_0000_0009",
		"map_rt_SpawnPoint_NW_0000_0010",
		"map_rt_SpawnPoint_SW_0001_0001",
		"map_rt_SpawnPoint_SW_0001_0005",
	},
	rt_SpawnPoint_SW_0002_0000 = {
		"map_rt_SpawnPoint_SW_0002_0006",
	},
	rt_SpawnPoint_SW_0002_0001 = {
		"map_rt_SpawnPoint_SW_0002_0007",
	},
	rt_SpawnPoint_SW_0002_0002 = {
		"map_rt_SpawnPoint_SW_0000_0007",
		"map_rt_SpawnPoint_SW_0000_0008",
		"map_rt_SpawnPoint_SW_0000_0009",
	},
	rt_SpawnPoint_SW_0002_0003 = {
		"map_rt_SpawnPoint_SW_0000_0009",
		"map_rt_SpawnPoint_SW_0000_0010",
		"map_rt_SpawnPoint_SW_0000_0011",
	},
	rt_SpawnPoint_SW_0002_0004 = {
		"map_rt_SpawnPoint_SW_0002_0003",
		"map_rt_SpawnPoint_SW_0002_0004",
	},
	rt_SpawnPoint_SW_0002_0005 = {
		"map_rt_SpawnPoint_E_0001_0004",
		"map_rt_SpawnPoint_SW_0002_0003",
		"map_rt_SpawnPoint_SW_0002_0005",
	},
	rt_SpawnPoint_U_0000_0000 = {
		"map_rt_SpawnPoint_U_0000_0004",
	},
	rt_SpawnPoint_U_0000_0001 = {
		"map_rt_SpawnPoint_U_0000_0004",
	},
	rt_SpawnPoint_U_0000_0002 = {
		"map_rt_SpawnPoint_NE_0000_0003",
		"map_rt_SpawnPoint_U_0000_0002",
	},
	rt_SpawnPoint_U_0000_0003 = {
		"map_rt_SpawnPoint_NW_0000_0010",
		"map_rt_SpawnPoint_U_0000_0003",
	},
}

return this
