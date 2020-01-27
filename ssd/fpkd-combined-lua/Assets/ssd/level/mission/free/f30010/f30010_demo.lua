


local this = BaseFreeMissionDemo.CreateInstance( "f30010" )


this.demoList = {
	HeliDown			= "p20_000020",		
	StartDefense		= "p20_000030",		
	StartDefense2		= "p30_000010",		
	AirTank				= "p01_000060",		
	GasMask				= "p01_000070",		
	SkillTracer			= "p01_000100",		
	RescueChild			= "p01_000022",		
	BossGluttony		= "p01_000110",		
	BossAerial			= "p01_000120",		
	FastTravel			= "p01_000090",		
	FastTravelEnd		= "p01_000091",		
	UpdateInfo			= "p01_000011",		
	RescueCrew_Man		= "p01_000020",		
	RescueCrew_Woman	= "p01_000021",		
}


this.demoBlockList = {
	HeliDown			= { "/Assets/ssd/pack/mission/free/f30010/f30010_d02.fpk", },	
	StartDefense		= { "/Assets/ssd/pack/mission/free/f30010/f30010_d03.fpk", },	
	StartDefense2		= { "/Assets/ssd/pack/mission/free/f30010/f30010_d04.fpk", },	
	AirTank				= { "/Assets/ssd/pack/mission/free/f30010/f30010_d05.fpk", },	
	RescueChild			= { "/Assets/ssd/pack/mission/free/f30010/f30010_d06.fpk", },	
	BossGluttony		= { "/Assets/ssd/pack/mission/free/f30010/f30010_d07.fpk", },	
	BossAerial			= { "/Assets/ssd/pack/mission/free/f30010/f30010_d08.fpk", },	
	FastTravel			= { "/Assets/ssd/pack/mission/free/f30010/f30010_d09.fpk", },	
	UpdateInfo			= { "/Assets/ssd/pack/mission/free/f30010/f30010_d10.fpk", },
}


this.storySequenceDemoTable = {
	[ TppDefine.STORY_SEQUENCE.BEFORE_k40040 ]			= "UpdateInfo",
	[ TppDefine.STORY_SEQUENCE.BEFORE_k40070 ]			= "AirTank",
	[ TppDefine.STORY_SEQUENCE.BEFORE_k40015 ]			= "FastTravel",
	[ TppDefine.STORY_SEQUENCE.CLEARED_k40015 ]			= "HeliDown",
	[ TppDefine.STORY_SEQUENCE.BEFORE_DEFENSE_AREA_1 ]	= "StartDefense",
	[ TppDefine.STORY_SEQUENCE.BEFORE_k40080 ]			= "RescueChild",
}






this.storySequenceDemoExclusionTable = {
	StartDefense	= true,	
	StartDefense2	= true,	
	AirTank			= true,	
	GasMask			= true,	
	SkillTracer		= true,	
	FastTravel		= true,	
	FastTravelEnd	= true,	
	RescueChild		= true,	
	UpdateInfo		= true,	
}

return this
