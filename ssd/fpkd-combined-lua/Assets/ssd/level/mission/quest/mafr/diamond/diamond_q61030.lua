



local this = BossQuest.CreateInstance( "diamond_q61030" )

this.creatureBlockName	= "mafr_diamond_gluttony"

this.gameObjectType		= "SsdBoss3"
this.gameObjectName		= "bss_gluttony_0000"

this.routeName			= "rt_glu_q61030_0000"

this.BossEnableTrapName	= "trap_GluttonyBossAppearance"

this.isNoDemo			= true

this.targetList = {
	"bss_gluttony_0000",
}

return this
