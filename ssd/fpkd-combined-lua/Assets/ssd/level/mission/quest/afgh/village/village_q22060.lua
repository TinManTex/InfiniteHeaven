



local this = DefenseQuest.CreateInstance( "village_q22060" )	

this.waveName = "wave_fast_afgh11"
this.fasttravelPointName = "fast_afgh11"

this.enemyWaveWalkSpeedList = {
}

this.enemyWaveByNameTableList= {
	{ enemyName = "zmb_q22060_0002", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0000", ignoreWave = true },
	{ enemyName = "zmb_q22060_0003", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0001", ignoreWave = true },
	{ enemyName = "zmb_q22060_0004", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0000", ignoreWave = true },
	{ enemyName = "zmb_q22060_0005", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0002", ignoreWave = true },
	{ enemyName = "zmb_q22060_0006", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0002", ignoreWave = true },
	{ enemyName = "zmb_q22060_0007", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0001", ignoreWave = true },
	{ enemyName = "zmb_q22060_0008", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0003", ignoreWave = true },
	{ enemyName = "zmb_q22060_0009", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0001", ignoreWave = true },
	{ enemyName = "zmb_q22060_0010", enemyType = "SsdZombie", spawnLocator= "SpawnPoint_q22060_0000", relayLocator1= "RelayPoint_q22060_0002", ignoreWave = true },

}

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.alertRadio = "f3000_rtrg0115"

this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

this.defenseGameAlertArea = "trap_defenseGameAlertArea_q22060"
this.defenseGameArea = "trap_defenseGameArea_q22060"

return this
