






local this = ExtraDiggingQuest.CreateInstance( "factory_q11921" )


this.waveName = "wave_factory_q11921"


this.importantGimmickList = {
	
	{
		gimmickId	= "GIM_P_Digger",
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/mission/quest/mafr/factory/factory_q11921.fox2",
	},
}


this.defenseGameArea = "trap_factory_q11921_DefenseGameArea"
this.defenseGameAlertArea = "trap_factory_q11921_DefenseGameAlertArea"

return this
