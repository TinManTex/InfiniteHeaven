






local this = ExtraDiggingQuest.CreateInstance( "diamond_q11928" )


this.waveName = "wave_diamond_q11928"


this.importantGimmickList = {
	
	{
		gimmickId	= "GIM_P_Digger",
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/mission/quest/mafr/diamond/diamond_q11928.fox2",
	},
}


this.defenseGameArea = "trap_diamond_q11928_DefenseGameArea"
this.defenseGameAlertArea = "trap_diamond_q11928_DefenseGameAlertArea"

return this
