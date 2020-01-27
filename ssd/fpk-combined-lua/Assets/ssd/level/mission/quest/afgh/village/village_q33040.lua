



local this = RescueQuest.CreateInstance( "village_q33040" )

this.target = "npc_village_q33040_0000"

this.enemyRouteTableList = {
	{ enemyType = "SsdZombie", enemyName = "zmb_q33040_0000", routeName = "rts_village_q33040_0000", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33040_0001", routeName = "rts_village_q33040_0001", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33040_0002", routeName = "rts_village_q33040_0002", },
}

return this
