local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseCoopMissionEnemy.CreateInstance( "c20210" )




this.mapRouteNameListTable = {
	
	rt_SpawnPoint_A_0000_zmb_0000 = {
		"map_rt_SpawnPoint_A_0000_0000",
	},
	rt_SpawnPoint_A_0000_zmb_0001 = {
		"map_rt_SpawnPoint_A_0000_0001",
	},
	rt_SpawnPoint_A_0000_zmb_0002 = {
		"map_rt_SpawnPoint_A_0000_0002",
	},
	rt_SpawnPoint_A_0000_zmb_0003 = {
		"map_rt_SpawnPoint_A_0000_0003",
	},
	
	rt_SpawnPoint_A_0001_zmb_0000 = {
		"map_rt_SpawnPoint_A_0001_0000",
	},
	rt_SpawnPoint_A_0001_zmb_0001 = {
		"map_rt_SpawnPoint_A_0001_0001",
	},
	rt_SpawnPoint_A_0001_zmb_0002 = {
		"map_rt_SpawnPoint_A_0001_0002",
	},
	rt_SpawnPoint_A_0001_zmb_0003 = {
		"map_rt_SpawnPoint_A_0001_0003",
	},
	
	rt_SpawnPoint_A_0002_zmb_0000 = {
		"map_rt_SpawnPoint_A_0002_0000",
	},
	rt_SpawnPoint_A_0002_zmb_0001 = {
		"map_rt_SpawnPoint_A_0002_0001",
	},
	rt_SpawnPoint_A_0002_zmb_0002 = {
		"map_rt_SpawnPoint_A_0002_0002",
	},
	rt_SpawnPoint_A_0002_zmb_0003 = {
		"map_rt_SpawnPoint_A_0002_0003",
	},
	
	rt_SpawnPoint_A_0003_zmb_0000 = {
		"map_rt_SpawnPoint_A_0003_0000",
	},
	rt_SpawnPoint_A_0003_zmb_0001 = {
		"map_rt_SpawnPoint_A_0003_0001",
	},
	rt_SpawnPoint_A_0003_zmb_0002 = {
		"map_rt_SpawnPoint_A_0003_0002",
	},
	rt_SpawnPoint_A_0003_zmb_0003 = {
		"map_rt_SpawnPoint_A_0003_0003",
	},
	
	rt_SpawnPoint_B_0000_zmb_0000 = {
		"map_rt_SpawnPoint_B_0000_0000",
	},
	rt_SpawnPoint_B_0000_zmb_0001 = {
		"map_rt_SpawnPoint_B_0000_0001",
	},
	
	rt_SpawnPoint_B_0001_zmb_0000 = {
		"map_rt_SpawnPoint_B_0001_0000",
	},
	rt_SpawnPoint_B_0001_zmb_0001 = {
		"map_rt_SpawnPoint_B_0001_0001",
	},
	rt_SpawnPoint_B_0001_zmb_0002 = {
		"map_rt_SpawnPoint_B_0001_0002",
	},
	
	rt_SpawnPoint_B_0002_zmb_0000 = {
		"map_rt_SpawnPoint_B_0002_0000",
	},
	rt_SpawnPoint_B_0002_zmb_0001 = {
		"map_rt_SpawnPoint_B_0002_0001",
	},
	rt_SpawnPoint_B_0002_zmb_0002 = {
		"map_rt_SpawnPoint_B_0002_0002",
	},
	
	rt_SpawnPoint_B_0003_zmb_0000 = {
		"map_rt_SpawnPoint_B_0003_0000",
	},
	rt_SpawnPoint_B_0003_zmb_0001 = {
		"map_rt_SpawnPoint_B_0003_0001",
	},
	rt_SpawnPoint_B_0003_zmb_0002 = {
		"map_rt_SpawnPoint_B_0003_0002",
	},
	rt_SpawnPoint_B_0003_zmb_0003 = {
		"map_rt_SpawnPoint_B_0003_0003",
	},
	
	rt_SpawnPoint_C_0000_zmb_0000 = {
		"map_rt_SpawnPoint_C_0000_0000",
	},
	rt_SpawnPoint_C_0000_zmb_0001 = {
		"map_rt_SpawnPoint_C_0000_0001",
	},
	
	rt_SpawnPoint_C_0001_zmb_0000 = {
		"map_rt_SpawnPoint_C_0001_0000",
	},
	rt_SpawnPoint_C_0001_zmb_0001 = {
		"map_rt_SpawnPoint_C_0001_0001",
	},
	rt_SpawnPoint_C_0001_zmb_0002 = {
		"map_rt_SpawnPoint_C_0001_0002",
	},
	
	rt_SpawnPoint_C_0002_zmb_0000 = {
		"map_rt_SpawnPoint_C_0002_0000",
	},
	rt_SpawnPoint_C_0002_zmb_0001 = {
		"map_rt_SpawnPoint_C_0002_0001",
	},
	rt_SpawnPoint_C_0002_zmb_0002 = {
		"map_rt_SpawnPoint_C_0002_0002",
	},
	
	rt_SpawnPoint_C_0003_zmb_0000 = {
		"map_rt_SpawnPoint_C_0003_0000",
	},
	rt_SpawnPoint_C_0003_zmb_0001 = {
		"map_rt_SpawnPoint_C_0003_0001",
	},
	rt_SpawnPoint_C_0003_zmb_0002 = {
		"map_rt_SpawnPoint_C_0003_0002",
	},
	rt_SpawnPoint_C_0003_zmb_0003 = {
		"map_rt_SpawnPoint_C_0003_0003",
	},
	
	rt_SpawnPoint_D_0000_zmb_0000 = {
		"map_rt_SpawnPoint_D_0000_0000",
	},
	rt_SpawnPoint_D_0000_zmb_0001 = {
		"map_rt_SpawnPoint_D_0000_0001",
	},
	rt_SpawnPoint_D_0000_zmb_0002 = {
		"map_rt_SpawnPoint_D_0000_0002",
	},
	rt_SpawnPoint_D_0000_zmb_0003 = {
		"map_rt_SpawnPoint_D_0000_0003",
	},
	
	rt_SpawnPoint_D_0001_zmb_0000 = {
		"map_rt_SpawnPoint_D_0001_0000",
	},
	rt_SpawnPoint_D_0001_zmb_0001 = {
		"map_rt_SpawnPoint_D_0001_0001",
	},
	rt_SpawnPoint_D_0001_zmb_0002 = {
		"map_rt_SpawnPoint_D_0001_0002",
	},
	rt_SpawnPoint_D_0001_zmb_0003 = {
		"map_rt_SpawnPoint_D_0001_0003",
	},
	
	rt_SpawnPoint_D_0002_zmb_0000 = {
		"map_rt_SpawnPoint_D_0002_0000",
	},
	
	rt_SpawnPoint_D_0003_zmb_0000 = {
		"map_rt_SpawnPoint_D_0003_0000",
	},
	rt_SpawnPoint_D_0003_zmb_0001 = {
		"map_rt_SpawnPoint_D_0003_0001",
	},
	rt_SpawnPoint_D_0003_zmb_0002 = {
		"map_rt_SpawnPoint_D_0003_0002",
	},
	rt_SpawnPoint_D_0003_zmb_0003 = {
		"map_rt_SpawnPoint_D_0003_0003",
	},
	
	rt_SpawnPoint_E_0000_zmb_0000 = {
		"map_rt_SpawnPoint_E_0000_0000",
	},
	rt_SpawnPoint_E_0000_zmb_0001 = {
		"map_rt_SpawnPoint_E_0000_0001",
	},
	rt_SpawnPoint_E_0000_zmb_0002 = {
		"map_rt_SpawnPoint_E_0000_0002",
	},
	rt_SpawnPoint_E_0000_zmb_0003 = {
		"map_rt_SpawnPoint_E_0000_0003",
	},
	
	rt_SpawnPoint_E_0001_zmb_0000 = {
		"map_rt_SpawnPoint_E_0001_0000",
	},
	rt_SpawnPoint_E_0001_zmb_0001 = {
		"map_rt_SpawnPoint_E_0001_0001",
	},
	rt_SpawnPoint_E_0001_zmb_0002 = {
		"map_rt_SpawnPoint_E_0001_0002",
	},
	rt_SpawnPoint_E_0001_zmb_0003 = {
		"map_rt_SpawnPoint_E_0001_0003",
	},
	
	rt_SpawnPoint_E_0002_zmb_0000 = {
		"map_rt_SpawnPoint_E_0002_0000",
	},
	rt_SpawnPoint_E_0002_zmb_0001 = {
		"map_rt_SpawnPoint_E_0002_0001",
	},
	rt_SpawnPoint_E_0002_zmb_0002 = {
		"map_rt_SpawnPoint_E_0002_0002",
	},
	rt_SpawnPoint_E_0002_zmb_0003 = {
		"map_rt_SpawnPoint_E_0002_0003",
	},
	
	rt_SpawnPoint_A_0002_zmb_dash_0000 = {
	},
	rt_SpawnPoint_C_0002_zmb_dash_0000 = {
	},
}




this.dropInstanceCountSettingTableList = {
	{	
		typeName = "SsdZombie",
		count = 4,
	},
	{	
		typeName = "SsdZombieArmor",
		count = 1,
	},
}

return this
