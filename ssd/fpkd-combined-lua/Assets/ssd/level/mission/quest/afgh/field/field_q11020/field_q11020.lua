



local this = AnnihilationQuest.CreateInstance( "field_q11020" )

this.targetList = {
	"zmb_q11020_0000",
	"zmb_q11020_0001",
	"zmb_q11020_0002",
	"zmb_q11020_0003",
}

this.debugRadioLineTable = {
	start = {
		"field_q11020",
		"AI「近くにゾンビの巣があるようです」",
		"AI「駆除してください」",
	},
}

this.targetMarkerName = "marker_q11020_target"

this.questStep.Quest_Main.OnEnterSub = function( self )
	Fox.Log( "q11020.questStep.Quest_Main.OnEnterSub()" )
	TppRadio.Play( "start" )
end

return this
