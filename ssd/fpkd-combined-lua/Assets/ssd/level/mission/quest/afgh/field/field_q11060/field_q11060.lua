



local this = AnnihilationQuest.CreateInstance( "field_q11060" )

this.targetList = {
	"zmb_q11060_0000",
	"zmb_q11060_0001",
	"zmb_q11060_0002",
	"zmb_q11060_0003",
}

this.debugRadioLineTable = {
	start = {
		"field_q11060",
		"AI「近くにゾンビの巣があるようです」",
		"AI「駆除してください」",
	},
}

this.targetMarkerName = "marker_q11060_target"

this.questStep.Quest_Main.OnEnterSub = function( self )
	Fox.Log( "q11060.questStep.Quest_Main.OnEnterSub()" )
	TppRadio.Play( "start" )
end

return this
