



local this = BossQuest.CreateInstance( "field_q61010" )

this.creatureBlockName		= "afgh_field_gluttony"

this.gameObjectType			= "SsdBoss3"
this.gameObjectName			= "bss_gluttony_0000"

this.routeName				= "rt_glu_q61010_0000"

this.demoBlockName			= "BossGluttony"
this.demoName				= "BossGluttony"

this.gvarsName				= "mis_isDemoGluttonyBossAppearance"

this.demoTrapName			= "trap_GluttonyBossDemoAppearance"
this.BossEnableTrapName		= "trap_GluttonyBossAppearance"

this.singularityEffectName	= "singularity_q61010"

this.isNoDemo				= false

this.targetList = {
	"bss_gluttony_0000",
}

return this
