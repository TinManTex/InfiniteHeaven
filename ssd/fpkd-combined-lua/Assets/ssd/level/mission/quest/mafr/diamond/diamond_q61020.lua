



local this = BossQuest.CreateInstance( "diamond_q61020" )

this.creatureBlockName		= "mafr_diamond_aerial"

this.gameObjectType			= "SsdBoss1"
this.gameObjectName			= "bss_aerial_0000"

this.routeName				= "rt_aer_q61020_0000"

this.demoName				= "BossAerial"
this.demoBlockName			= "BossAerial"
this.demoTrapName			= "trap_AerialBossAppearance"
this.demoIdentifierName		= "GetIntelIdentifier_q61020_sequence"
this.demoPointName			= "DemoAppearance"

this.isNoDemo				= false

this.gvarsName				= "mis_isDemoAerialBossAppearance"

this.demoTrapName			= "trap_AerialBossDemoAppearance"
this.BossEnableTrapName		= "trap_AerialBossAppearance"

this.singularityEffectName	= "singularity_q61020"

this.targetList = {
	"bss_aerial_0000",
}

return this
