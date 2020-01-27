



local this = DefenseQuest.CreateInstance( "diamond_q22100" )	

this.waveName = "wave_fast_mafr03"
this.fasttravelPointName = "fast_mafr03"

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.alertRadio = "f3000_rtrg0115"

this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

this.defenseGameAlertArea = "trap_defenseGameAlertArea_q22100"
this.defenseGameArea = "trap_defenseGameArea_q22100"

return this
