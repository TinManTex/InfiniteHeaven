




local this = BaseFlagMission.CreateInstance( "k40130" )


this.registerRescueTargetUniqueCrew = {
	locatorName = "npc_k40130_0000",
	uniqueType = SsdCrewType.UNIQUE_TYPE_PLC,
}

local lastAddedStep




this.missionAreas = {
	{ 
		name = "marker_missionArea00", 
		trapName = "trap_missionArea00", 
		visibleArea = 8, 
		guideLinesId = "guidelines_mission_common_signal",
	},
	{ 
		name = "marker_missionArea01", 
		trapName = "trap_missionArea01", 
		visibleArea = 8, 
		hide = true 
	},
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isReachedIntermediatePoint",				type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)


this.enterMissionAreaRadio = "f3010_rtrg1204"




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisableMissionArea( "marker_missionArea00" )
		this.DisplayMissionArea( "marker_missionArea01" )
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end

	
	TppQuest.RegisterSkipStartQuestDemo( "village_q22150" )
	
end





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameMain",
	OnEnter = function()
		
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
	end,
	options = {
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea00", },
		},
		radio = "f3010_rtrg1200",
		objective = "mission_40020_objective_02",
		checkObjectiveIfCleared = "mission_40020_objective_02",
		route = {
				{ enemyName = "zmb_k40130_miranda01", routeName = "rt_zmb_k40130_miranda01", },
				{ enemyName = "zmb_k40130_miranda02", routeName = "rt_zmb_k40130_miranda02", },
				{ enemyName = "zmb_k40130_miranda04", routeName = "rt_zmb_k40130_miranda04", },
		},
		recipe = {
			"RCP_BLD_Shelter_B",			
			"RCP_BLD_VegetableFarm_B",		
			"RCP_BLD_AccessoryPlant_B",		
		},
		onLeaveRadio = { "f3000_rtrg0803", "f3000_rtrg0814" },
	},
	clearConditionTable = {
		carry = {
			{ locatorName = "npc_k40130_0000", },
		},
	},
}


this.flagStep.GameMain.messageTable = { 
	Trap = {
		{
			sender = "trap_intermediatePoint0001",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if not fvars.isReachedIntermediatePoint then
					TppRadio.Play("f3010_rtrg1202")	
					fvars.isReachedIntermediatePoint = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameEscape",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea00" )
		
		this.DisplayMissionArea("marker_missionArea01")
	end,
	options = {
		continueRadio = "f3010_rtrg1205",
		objective = "mission_40020_objective_03",
		checkObjectiveIfCleared = "mission_40020_objective_03",
		marker = {
			{ name = "marker_targetFTP", areaName = "marker_missionArea01", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
	},
	clearConditionTable = {
		rescue = {
			{
				locatorName = "npc_k40130_0000",
				rescueDemo = { demoName = "p01_000020", options = { finishFadeOut = true } },
				checkObjective = "mission_40020_objective_03",
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameClear",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.DisableMissionArea( "marker_missionArea01" )
	end,
	options = {
	},
	clearConditionTable = {
		clearStage = true,
	},
}




this.blackRadioOnEnd = { "K40130_0020", "K40130_0030" }




this.releaseAnnounce = {
	"OpenNewUnitMedical",
	"OpenNewUnitFood",
}

return this
