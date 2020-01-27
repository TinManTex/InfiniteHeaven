




local this = BaseFlagMission.CreateInstance( "k40310" )
local lastAddedStep


this.missionAreas = {
	{ 
		name = "marker_missionArea", 
		trapName = "trap_missionArea", 
		visibleArea = 9,
		guideLinesId = "guidelines_mission_common_memoryBoard",
	},
}


this.enterMissionAreaRadio = "f3010_rtrg2801"




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisableMissionArea( "marker_missionArea" )
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameAiAccess" ) then
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
	end
	
end




this.AddOnTerminate = function()
	
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
end


local memoryBoardIdentifierParam = {
	{
		gimmickId		= "GIM_P_CommonSwitch",
		name			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
		dataSetName		= "/Assets/tpp/level/location/mafr/block_small/152/152_113/mafr_152_113_gimmick.fox2",
	},
}






this.disableEnemy = {
	
	{ enemyName = "zmb_152_113_0000" },
	{ enemyName = "zmb_152_113_0001" },
	{ enemyName = "zmb_152_113_0002" },
	{ enemyName = "zmb_152_113_0003" },
	{ enemyName = "zmb_152_113_0004" },
	{ enemyName = "zmb_152_113_0005" },
	{ enemyName = "zmb_152_113_0006" },
	{ enemyName = "zmb_152_113_0007" },
	{ enemyName = "zmb_152_113_0008" },
	{ enemyName = "zmb_152_113_0009" },
	{ enemyType = "SsdZombieShell", enemyName = "zmb_shell_152_113_0000" },
	{ enemyType = "SsdZombieShell", enemyName = "zmb_shell_152_113_0001" },
	
	{ enemyName = "zmb_lab_02_0000" },
	{ enemyName = "zmb_lab_02_0001" },
	{ enemyName = "zmb_lab_02_0002" },
	{ enemyName = "zmb_lab_02_0003" },
	{ enemyName = "zmb_lab_02_0004" },
	{ enemyName = "zmb_lab_02_0008" },
}


this.enemyRouteTable = {
	{ enemyName = "zmb_w_k40310_0001", routeName = "rt_zmb_w_k40310_0001", },
	{ enemyName = "zmb_w_k40310_0050", routeName = "rt_zmb_w_k40310_0050", },
	{ enemyName = "zmb_w_k40310_0056", routeName = "rt_zmb_w_k40310_0056", },
	{ enemyName = "zmb_w_k40310_0049", routeName = "rt_zmb_w_k40310_0049", },
}









lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameTipsToBecomeStrong",
	clearConditionTable = {
		tips = {
			tipsTypes	= {
							{ HelpTipsType.TIPS_115_A, HelpTipsType.TIPS_115_B, HelpTipsType.TIPS_115_C, },
						},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	previousStep = lastAddedStep,
	OnEnter = function( self )
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end,
	options = {
		radio = "f3010_rtrg2800",
		continueRadio = "f3010_rtrg2802",
		marker = "marker_target",
		objective = "mission_common_objective_getMemoryBoard",
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId		= memoryBoardIdentifierParam[1].gimmickId,
				locatorName		= memoryBoardIdentifierParam[1].name,
				datasetName		= memoryBoardIdentifierParam[1].dataSetName,
				isPowerOn		= true,
				isAlertLockType = true,
				checkObjective	= "mission_common_objective_getMemoryBoard",
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40310_sequence",
					key = "GetIntel_ClassMemory",
				},
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameEscape",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableGuideLine()
		
		this.DisableMissionArea( "marker_missionArea" )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
	end,
	options = {
		radio = "f3000_rtrg0256",
		objective = "mission_common_objective_returnToFOB",		
	},
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToFOB", },
	},
}



lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameAiAccess",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		TppMarker.Enable( "marker_target_AI", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
	end,
	OnLeave = function()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		TppMarker.Disable( "marker_target_AI" )
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
	end,
	options = {
		radio = "f3000_rtrg0257",
		objective = "mission_common_objective_accessToAI",	
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId	= "GIM_P_AI",
				locatorName = "com_ai101_gim_n0000|srt_aip1_main0_def",
				datasetName = "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",
				checkObjective = "mission_common_objective_accessToAI",
			},
		},
	},
}



lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameClear",
	previousStep = lastAddedStep,
	clearConditionTable = {
		clearStage = { demo = "p01_000010" },		
	},
}








this.resultRadio = "f3010_rtrg2804"




this.releaseAnnounce = {
	"OpenNewClassAssault",
	"OpenNewClassJaeger",
	"OpenNewClassMedic",
	"OpenNewClassScout",
}

return this
