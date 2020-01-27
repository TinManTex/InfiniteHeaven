




local this = BaseFlagMission.CreateInstance( "k40220" )

local lastAddedStep


this.missionAreas = {
	{
		name			= "marker_missionArea",
		trapName		= "trap_missionArea",
		visibleArea		= 6,
		guideLinesId	= "guidelines_mission_common_memoryBoard",
	},
}


this.enterMissionAreaRadio = "f3010_rtrg1102"


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isRadioEntrance",				type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioMemoryBoard",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isMissionObjectiveEntrance",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()
	
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	mvars.isDisableEntranceMarker = false

	
	local translation, rotQuat = Tpp.GetLocatorByTransform( "DataIdentifier_f30020_sequence", "aiDemoPosition" )
	DemoDaemon.SetDemoTransform( "p01_000020", rotQuat, translation )

	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard" } )
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


this.UpdateMissionObjective = function( isUpdate )
	if isUpdate == true and fvars.isMissionObjectiveEntrance == false then
		fvars.isMissionObjectiveEntrance = true
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_getMemoryBoard_atRuin", }		
	else
		if fvars.isMissionObjectiveEntrance == false then
			MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_getMemoryBoard", }			
		else
			MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_getMemoryBoard_atRuin", }	
		end
	end
end


this.messageTable = {
	Trap = {
		{	
			sender = "trap_missionArea",
			msg = "Enter",
			func = function()
				
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
					TppMarker.Enable( "marker_entrance", 0, "moving", "all", 0, true, true )
				end
				
				this.UpdateMissionObjective( true )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea",
			msg = "Exit",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
					
					TppMarker.Disable( "marker_entrance" )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_entranceOff",
			msg = "Enter",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
					if mvars.isDisableEntranceMarker == false then
						TppMarker.Disable( "marker_entrance" )
						mvars.isDisableEntranceMarker = true
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_entranceOn",
			msg = "Enter",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
					if mvars.isDisableEntranceMarker == true then
						TppMarker.Enable( "marker_entrance", 0, "moving", "all", 0, true, true )
						mvars.isDisableEntranceMarker = false
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_memoryBoard",
			msg = "Enter",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
					
					TppMarker.Enable( "marker_target", 0, "moving", "all", 0, true, true )
					
					if fvars.isRadioMemoryBoard == false then
						fvars.isRadioMemoryBoard = true
						TppRadio.Play( "f3000_rtrg0226" )
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_memoryBoard",
			msg = "Exit",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
					
					TppMarker.Disable( "marker_target" )
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}


this.afterDemoFunc01 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_009", "ARCHIVE_B_009" } }
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMain",
	OnEnter = function( self )
		
		this.UpdateMissionObjective( false )
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end,
	OnLeave = function( self )
		
		TppMarker.Disable( "marker_entrance" )
		
		TppMarker.Disable( "marker_target" )
	end,
	options = {
		radio = "f3010_rtrg1902",
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId			= "GIM_P_CommonSwitch",
				locatorName			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
				datasetName			= "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
				isPowerOn			= true,
				isAlertLockType		= true,
				checkObjective		= "mission_common_objective_getMemoryBoard_atRuin",
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40220_sequence",
					key = "GetIntel_diamond",
					afterDemoFunc = this.afterDemoFunc01,
				},
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameEscape",
	OnEnter = function()
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
	end,
	options = {
		radio = { name = "f3000_rtrg0204", options = { delayTime = 2.0 } },
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
	OnEnter = function()
		
		TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
		
		this.DisableMissionArea( "marker_missionArea" )
	end,
	OnLeave = function()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_MOVE_TO_OTHER_LOCATION )
	end,
	options = {
		radio = { name = "f3000_rtrg0257", options = { delayTime = 2.0 } },
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




this.clearRadio = "f3000_rtrg0213"




this.blackRadioOnEnd = "K40220_0020"

return this
