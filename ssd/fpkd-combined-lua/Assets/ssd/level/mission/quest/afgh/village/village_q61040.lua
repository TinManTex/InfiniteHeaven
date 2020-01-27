



local this = BossQuest.CreateInstance( "village_q61040" )

this.creatureBlockName	= "afgh_village_aerial"

this.gameObjectType		= "SsdBoss1"
this.gameObjectName		= "bss_aerial_0000"

this.routeName			= "rt_aer_q61040_0000"

this.BossEnableTrapName	= "trap_AerialBossAppearance"

this.isNoDemo			= true

this.targetList = {
	"bss_aerial_0000",
}

return this
