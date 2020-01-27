



local this = DefenseQuest.CreateInstance( "diamond_q22090" )	

this.waveName = "wave_fast_mafr02"
this.fasttravelPointName = "fast_mafr02"

this.enemyWaveWalkSpeedList = {
	{ enemyName = "zmb_q22090_0006", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_q22090_0007", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_q22090_0008", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_q22090_0009", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_q22090_0010", enemyType = "SsdZombie", speed = "walk" },
	{ enemyName = "zmb_bom_q22090_0001", enemyType = "SsdZombieBom", speed = "walk" },
	{ enemyName = "zmb_bom_q22090_0002", enemyType = "SsdZombieBom", speed = "walk" },
}

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.alertRadio = "f3000_rtrg0115"

this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

this.defenseGameAlertArea = "trap_defenseGameAlertArea_q22090"
this.defenseGameArea = "trap_defenseGameArea_q22090"

return this
