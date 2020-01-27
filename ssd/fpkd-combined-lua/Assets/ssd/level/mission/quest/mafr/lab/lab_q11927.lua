



local this = AnnihilationQuest.CreateInstance( "field_q11010" )

this.targetList = {
	"zmb_q11010_0000",
	"zmb_q11010_0001",
	"zmb_q11010_0002",
	"zmb_q11010_0003",
}

this.debugRadioLineTable = {
	start = {
		"field_q11010",
		"AI「近くにゾンビの巣があるようです」",
		"AI「駆除してください」",
	},
}

this.questStep.Quest_Main.OnEnterSub = function( self )
	Fox.Log( "q11010.questStep.Quest_Main.OnEnterSub()" )
	TppRadio.Play( "start" )
end

return this
