



local this = AnnihilationQuest.CreateInstance( "field_q11030" )

this.targetList = {
	"zmb_q11030_0000",
	"zmb_q11030_0001",
	"zmb_q11030_0002",
	"zmb_q11030_0003",
}

this.debugRadioLineTable = {
	start = {
		"field_q11030",
		"AI「近くにゾンビの巣があるようです」",
		"AI「駆除してください」",
	},
}

this.targetMarkerName = "marker_q11030_target"

this.questStep.Quest_Main.OnEnterSub = function( self )
	Fox.Log( "q11030.questStep.Quest_Main.OnEnterSub()" )
	TppRadio.Play( "start" )
end

return this
