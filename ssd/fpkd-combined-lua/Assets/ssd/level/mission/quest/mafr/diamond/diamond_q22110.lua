



local this = DefenseQuest.CreateInstance( "diamond_q22110" )	

this.waveName = "wave_fast_mafr04"
this.fasttravelPointName = "fast_mafr04"

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

return this
