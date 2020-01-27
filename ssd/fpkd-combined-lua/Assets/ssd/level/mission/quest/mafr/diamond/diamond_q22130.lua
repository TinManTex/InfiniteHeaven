



local this = DefenseQuest.CreateInstance( "diamond_q22130" )	

this.waveName = "wave_fast_mafr07"
this.fasttravelPointName = "fast_mafr07"

this.startRadio = "f3000_rtrg1601" 
this.failureRadio = "f3000_rtrg1607"
this.alertRadio = "f3000_rtrg0115"

this.questStep.Quest_Defense.onEnterRadio = "f3000_rtrg1605"
this.questStep.Quest_Clear.onEnterRadio = "f3000_rtrg1606"

this.defenseGameAlertArea = "trap_defenseGameAlertArea_q22130"
this.defenseGameArea = "trap_defenseGameArea_q22130"


this.questStep.Quest_Defense.OnEnterSub = function( self )
	Fox.Log( "q22130.questStep.Quest_Defense.OnEnterSub()" )

	local gameObjectId = { type="SsdZombieShell" }
	local command = { id = "IgnoreVerticalShot", ignore=true }
	GameObject.SendCommand( gameObjectId, command )
end


this.questStep.Quest_Defense.OnLeaveSub = function( self )
	Fox.Log( "q22130.questStep.Quest_Defense.OnLeaveSub()" )

	local gameObjectId = { type="SsdZombieShell" }
	local command = { id = "IgnoreVerticalShot", ignore=false }
	GameObject.SendCommand( gameObjectId, command )
end


return this
