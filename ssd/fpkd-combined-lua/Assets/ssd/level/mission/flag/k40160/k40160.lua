




local this = BaseFlagMission.CreateInstance( "k40160" )

local lastAddedStep


this.missionAreas = {
	{
		name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 6, guideLinesId = "guidelines_mission_common_memoryBoard",
	},
}


this.enterMissionAreaRadio = "f3000_rtrg0226"




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) then
		
		this.DisableMissionArea( "marker_missionArea" )
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) then
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
end


this.afterDemoFunc01 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_008", "ARCHIVE_B_008" } }
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMain",
	OnEnter = function( self )
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end,
	options = {
		radio = "f3010_rtrg1600",
		objective = {
			"mission_common_objective_getMemoryBoard",	
		},
		marker = {
			{ name = "marker_target", },
		},
		archive = {
			"ARCHIVE_A_007",	
			"ARCHIVE_B_007",	
		},
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId			= "GIM_P_CommonSwitch",
				locatorName			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
				datasetName			= "/Assets/tpp/level/location/mafr/block_small/153/153_126/mafr_153_126_gimmick.fox2",
				isPowerOn			= true,
				isAlertLockType		= true,
				checkObjective			= "mission_common_objective_getMemoryBoard",
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40160_sequence",
					key = "GetIntel_mafrMemory",
					afterDemoFunc = this.afterDemoFunc01,
				},
			},
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameReturnToBase",
	OnEnter = function( self )
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
	end,
	options = {
		radio = "f3000_rtrg0204",
		objective = "mission_common_objective_returnToFOB",		
	},
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToFOB", },
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameAiAccess",
	OnEnter = function( self )
		
		TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	end,
	options = {
		radio = "f3000_rtrg0257",
		objective = "mission_common_objective_accessToAI",	
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId	= "GIM_P_AI",
				locatorName = "com_ai001_gim_n0000|srt_aip0_main0_def",
				datasetName = "/Assets/ssd/level/location/mafr/block_common/mafr_common_asset_base.fox2",
				checkObjective = "mission_common_objective_accessToAI",
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			demo = "p01_000010",
			fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED,
		},
	},
}




this.blackRadioOnEnd = "K40160_0020"




this.releaseAnnounce = { "EnableFastTravelMafr", }

return this
