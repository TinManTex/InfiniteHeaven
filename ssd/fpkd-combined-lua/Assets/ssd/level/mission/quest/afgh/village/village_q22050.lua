



local this = DefenseQuest.CreateInstance( "village_q22050" )	

this.waveName = "wave_fast_afgh10"
this.fasttravelPointName = "fast_afgh10"

this.enemyWaveWalkSpeedList = {
	{ enemyName = "zmb_q22050_0004", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_q22050_0005", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_q22050_0008", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "bom_q22050_0001", enemyType = "SsdZombieBom", speed = "walk" },
}

this.enemyWaveByNameTableList= {
	{ enemyName = "zmb_q22050_0004", enemyType = "SsdZombie", spawnLocator= "SpawnPoint0000", relayLocator1= "RelayPoint0000", ignoreWave = true },
	{ enemyName = "zmb_q22050_0005", enemyType = "SsdZombie", spawnLocator= "SpawnPoint0000", relayLocator1= "RelayPoint0000", ignoreWave = true },
	{ enemyName = "bom_q22050_0000", enemyType = "SsdZombieBom", spawnLocator= "SpawnPoint0000", relayLocator1= "RelayPoint0000", ignoreWave = true },
}

this.startRadio = "f3000_rtrg1601"  
this.failureRadio = "f3000_rtrg1607"
this.alertRadio = "f3000_rtrg0115"

this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

this.defenseGameAlertArea = "trap_defenseGameAlertArea_q22050"
this.defenseGameArea = "trap_defenseGameArea_q22050"


return this
