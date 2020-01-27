






local this = ExtraDiggingQuest.CreateInstance( "factory_q11340" )


this.waveName = "wave_factory_q11340"


this.importantGimmickList = {
	
	{
		gimmickId	= "GIM_P_Digger",
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11340.fox2",
	},
}


this.defenseGameArea = "trap_factory_q11340_DefenseGameArea"
this.defenseGameAlertArea = "trap_factory_q11340_DefenseGameAlertArea"

return this
