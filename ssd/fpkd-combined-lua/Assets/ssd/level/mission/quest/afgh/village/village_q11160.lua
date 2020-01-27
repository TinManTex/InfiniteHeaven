






local this = ExtraDiggingQuest.CreateInstance( "village_q11160" )


this.waveName = "wave_village_q11160"


this.importantGimmickList = {
	
	{
		gimmickId	= "GIM_P_Digger",
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/mission/quest/afgh/village/village_q11160.fox2",
	},
}


this.defenseGameArea = "trap_village_q11160_DefenseGameArea"
this.defenseGameAlertArea = "trap_village_q11160_DefenseGameAlertArea"

return this
