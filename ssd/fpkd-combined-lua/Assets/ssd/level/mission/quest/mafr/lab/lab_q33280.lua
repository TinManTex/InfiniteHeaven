



local this = RescueQuest.CreateInstance( "lab_q33280" )
this.target = "npc_lab_q33280_0000" 

this.enemyRouteTableList = {
	{ enemyType = "SsdZombie", enemyName = "zmb_q33280_0000", routeName = "rts_lab_33280_0000", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33280_0001", routeName = "rts_lab_33280_0001", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33280_0002", routeName = "rts_lab_33280_0002", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33280_0003", routeName = "rts_lab_33280_0003", },
	{ enemyType = "SsdZombie", enemyName = "zmb_q33280_0004", routeName = "rts_lab_33280_0004", },
}
 
return this