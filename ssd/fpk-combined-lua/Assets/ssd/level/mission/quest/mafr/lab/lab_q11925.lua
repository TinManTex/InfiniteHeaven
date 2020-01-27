






local this = ExtraDiggingQuest.CreateInstance( "lab_q11925" )


this.waveName = "wave_lab_q11925"


this.importantGimmickList = {
	
	{
		gimmickId	= "GIM_P_Digger",
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/mission/quest/mafr/lab/lab_q11925.fox2",
	},
}


this.defenseGameArea = "trap_lab_q11925_DefenseGameArea"
this.defenseGameAlertArea = "trap_lab_q11925_DefenseGameAlertArea"

return this
