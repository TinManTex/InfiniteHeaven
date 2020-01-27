



local this = DefenseQuest.CreateInstance( "village_q22080" )	

this.waveName = "wave_fast_afgh14"
this.fasttravelPointName = "fast_afgh14"

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

return this
