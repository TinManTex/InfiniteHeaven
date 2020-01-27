


local this = BaseFreeMissionDemo.CreateInstance( "f30020" )


this.demoList = {
	StartAfrica			= "p40_000010",	
	EncounterDan		= "p40_000015",	
	DiscoverSaheran		= "p40_000020",	
	RecoverSaheran		= "p40_000030",	
	SecureSaheran		= "p01_000050",	
	RescueCrew_Man		= "p01_000020",	
	RescueCrew_Woman	= "p01_000021",	
	BossAerial			= "p01_000120",	
}


this.demoBlockList = {
	StartAfrica			= { "/Assets/ssd/pack/mission/free/f30020/f30020_d01.fpk", },
	DiscoverSaheran		= { "/Assets/ssd/pack/mission/free/f30020/f30020_d02.fpk", },
	RecoverSaheran		= { "/Assets/ssd/pack/mission/free/f30020/f30020_d03.fpk", },
	BossAerial			= { "/Assets/ssd/pack/mission/free/f30020/f30020_d04.fpk", },
	EncounterDan		= { "/Assets/ssd/pack/mission/free/f30020/f30020_d05.fpk", },
}


this.storySequenceDemoTable = {
	[ TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST ] = "StartAfrica",
}






this.storySequenceDemoExclusionTable = {
}

return this
