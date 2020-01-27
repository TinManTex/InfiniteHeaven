



local this = RescueQuest.CreateInstance( "factory_q33080" )

this.target = "npc_factory_q33080_0000"


this.enemyRouteTableList = {
	{ enemyType = "SsdZombie", enemyName = "zmb_q33080_0000", routeName = "rts_factory_q33080_0000", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33080_0001", routeName = "rts_factory_q33080_0001", },

	{ enemyType = "SsdInsect1", enemyName = "cam_q33080_0000", routeName = "rt_cam_q33080_0000", },
	{ enemyType = "SsdInsect1", enemyName = "cam_q33080_0001", routeName = "rt_cam_q33080_0001", },
	{ enemyType = "SsdInsect1", enemyName = "cam_q33080_0002", routeName = "rt_cam_q33080_0002", },
}

return this
