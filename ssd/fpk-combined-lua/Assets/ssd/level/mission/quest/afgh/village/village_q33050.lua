



local this = RescueQuest.CreateInstance( "village_q33050" )

this.target = "npc_village_q33050_0000"

this.enemyRouteTableList = {
	{ enemyType = "SsdZombie", enemyName = "zmb_q33050_0000", routeName = "rts_village_q33050_0000", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33050_0001", routeName = "rts_village_q33050_0001", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33050_0002", routeName = "rts_village_q33050_0002", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33050_0003", routeName = "rts_village_q33050_0003", },
}

return this
