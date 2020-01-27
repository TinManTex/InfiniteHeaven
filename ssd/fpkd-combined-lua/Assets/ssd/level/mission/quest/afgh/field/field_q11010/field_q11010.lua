






local this = ExtraDiggingQuest.CreateInstance( "field_q11010" )


this.waveName = "wave_field_q11010"


this.importantGimmickList = {
	
	{
		gimmickId	= "GIM_P_Digger",
		locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
		datasetName = "/Assets/ssd/level/mission/quest/afgh/field/field_q11010/field_q11010.fox2",
	},
}


this.defenseGameArea = "trap_field_q11010_DefenseGameArea"
this.defenseGameAlertArea = "trap_field_q11010_DefenseGameAlertArea"

return this
