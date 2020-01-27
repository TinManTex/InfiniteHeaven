



local this = RescueQuest.CreateInstance( "village_q33071" )	

this.debugRadioLineTable = {
	start_village_q33071 = {
		"village_q33071",
		"AI「近くに遭難者がいるようです」",
	},
	rescue_village_q33071 = {
		"AI「遭難者を確保」",
		"AI「帰還してください」",
	},
	clear_village_q33071 = {
		"AI「遭難者を救出しました」",
	},
}

this.target = "npc_village_q33071_0000"	
this.startRadio = "start"    

this.questStep.Quest_Clear.onEnterRadio = "clear_village_q33071"

return this
