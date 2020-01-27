




local this = BaseFlagMission.CreateInstance( "k40090" )

local lastAddedStep


this.missionAreas = {
	{
		name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 5, guideLinesId = "guidelines_mission_common_memoryBoard"
	},
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isRadioEntrance01",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioMemoryBoard",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isEnterRuin",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)


this.messageTable = {
	SsdBuilding = {
		{	
			msg = "BuildingFinish",
				func = function( gameObjectId, productionIdCode )
				if ( productionIdCode == Fox.StrCode32( "PRD_BLD_StandbyRoom_A" ) ) then
					Fox.Log("k40090.BuildingFinish : PRD_BLD_StandbyRoom_A gameObjectId = " .. tostring(gameObjectId) )
					
				end
			end,
		},
	},
	Trap = {
		{	
			sender = "trap_missionArea",
			msg = "Enter",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex >= SsdFlagMission.GetStepIndex( "GameGoRuin" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMain" )  then
					if fvars.isRadioEntrance01 == false then
						TppRadio.Play("f3010_rtrg1102")
						fvars.isRadioEntrance01 = true
					end
					
					TppMarker.Enable( "marker_entrance", 0, "moving", "all", 0, true, true )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea",
			msg = "Exit",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex >= SsdFlagMission.GetStepIndex( "GameGoRuin" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMain" )  then
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
				if stepIndex >= SsdFlagMission.GetStepIndex( "GameGoRuin" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMain" )  then
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
				if stepIndex >= SsdFlagMission.GetStepIndex( "GameGoRuin" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameMain" )  then
					if mvars.isDisableEntranceMarker == true then
						TppMarker.Enable( "marker_entrance", 0, "moving", "all", 0, true, true )
						mvars.isDisableEntranceMarker = false
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	mvars.isDisableEntranceMarker = false
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturn" ) then
		this.DisableMissionArea( "marker_missionArea" )
	end

	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturn" ) then
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end

end





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameGoRuin",
	OnEnter = function( self )
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end,
	options = {
		radio = { "f3010_rtrg1100", "f3000_rtrg0220" },
		objective = "mission_common_objective_getMemoryBoard",
		
		recipe = {
			"RCP_BLD_FoodStorage_A",		
			"RCP_BLD_MedicalStorage_A",		
			"RCP_BLD_WaterTank_A",			
			"RCP_BLD_DirtyWaterTank_B",		
		},
	},
	clearConditionTable = {
		trap = "trap_BlackRadio",
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "PlayEnterRuinBlackRadio",
	clearConditionTable = {
		blackRadio = {
			startRadio = "f3010_rtrg1104",
			blackRadioList = { "K40090_0030" },
		},
	},
}


this.afterDemoFunc01 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_006", "ARCHIVE_B_006" } }
end





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	previousStep = lastAddedStep,
	addStepName = "GameMain", 
	
	options = {
		continueRadio = "f3010_rtrg1105",
		OnChangeClearCondition = function( updateFvarsName )
			if ( updateFvarsName == "k40090_GameMain_collect_1" ) then
				Fox.Log("updateFvarsName : k40090_GameMain_collect_1")
				TppMarker.Disable( "marker_objective" )
				
				if fvars["k40090_GameMain_switch_ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001"] then
					

				else
				end
			elseif ( updateFvarsName == "k40090_GameMain_switch_ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001" ) then
				Fox.Log("updateFvarsName : k40090_GameMain_switch_ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001")
				TppMarker.Disable( "marker_objective02" )
				
				if fvars["k40090_GameMain_collect_1"] then
					
					TppMarker.Enable( "marker_return", 0, "moving", "all", 0, true, true )
				else
				end
			else
				Fox.Error("絶対ないはず")
			end
		end,
		objective = { "mission_common_objective_getMemoryBoard_atRuin", "mission_40090_objective_04" },
	},
	
	
	clearConditionTable = {
		switch = {
			{
				gimmickId			= "GIM_P_CommonSwitch",
				locatorName			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
				datasetName			= "/Assets/ssd/level/location/afgh/block_large/dungeon2/afgh_dungeon2_gimmick.fox2",
				isPowerOn			= true,
				isAlertLockType		= true,
				checkObjective			= "mission_common_objective_getMemoryBoard_atRuin",
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40090_sequence",
					key = "GetIntel_farm",
					afterDemoFunc = this.afterDemoFunc01,
				},
			},
		},
		collect = {
			{ name = "RES_WheelChairParts", count = 1, checkObjective = "mission_40090_objective_04", },
		},
	},
}

this.flagStep.GameMain.messageTable = { 
	Trap = {
		{
			sender = "trap_wheelChair01",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if not fvars["k40090_GameMain_collect_1"] then
					TppMarker.Enable( "marker_objective", 0, "moving", "all", 0, true, true )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_wheelChair01",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				TppMarker.Disable( "marker_objective" )
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_room3",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if not fvars["k40090_GameMain_switch_ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001"] then
					TppMarker.Enable( "marker_objective02", 0, "moving", "all", 0, true, true )
				end
				if fvars.isRadioMemoryBoard == false then
					TppRadio.Play( "f3000_rtrg0226" )
					fvars.isRadioMemoryBoard = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_room3",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				TppMarker.Disable( "marker_objective02" )
			end,
			option = { isExecFastTravel = true, },
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameReturn",
	OnEnter = function( self )
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
	end,
	options = {
		radio = "f3000_rtrg0204",
		objective = "mission_common_objective_returnToBase",
	},
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToBase", },
	},
}

this.flagStep.GameReturn.messageTable = { 
	Trap = {
		{
			sender = "trap_room3",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				Fox.Log( "trap_exitRoom:Enter" )
				TppMarker.Disable( "marker_return" )
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameAiAccess",
	OnEnter = function()
		
		TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	end,
	options ={
		radio = "f3000_rtrg0257",
		objective = "mission_common_objective_accessToAI",
		checkObjectiveIfCleared = "mission_common_objective_accessToAI",
		nextStepDelay = {
			{ type = "FadeOut", },
		},
	},
	clearConditionTable ={
		switch = {
			{
				gimmickId	= "GIM_P_AI",
				locatorName = "com_ai001_gim_n0000|srt_aip0_main0_def",
				datasetName = "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
			},
		},
	},
}

lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoAccess",
	clearConditionTable ={
		demo = { demoName = "p01_000010", options = { finishFadeOut = true }, },
	},
}

lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameBlackRadio",
	OnEnter = function()
		
		Mission.SetHasWheelChair( true )
	end,
	clearConditionTable ={
		blackRadio = {
			blackRadioList = { "K40090_0020", "K40090_0031" },
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameCraft",
	OnEnter = function()
		
		Mission.SetHasWheelChair( true )
		
		TppMarker.Disable("marker_ai")
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	end,
	options = {
		radio = "f3000_rtrg1301",
		recipe = "RCP_BLD_StandbyRoom_A",
	},
	clearConditionTable ={
		completeCraft = {
			
			{
				missionObjectiveInfoTable = {
					langId				= "mission_40090_objective_03",
					facilityType = SsdSbm.FACILITY_TYPE_Building,
					productionIdCode = {
						"PRD_BLD_StandbyRoom_A",
					},
				},
			},
			
			{
				requiredBuilding = "PRD_BLD_StandbyRoom_A",
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	OnEnter = function()
		
		Mission.SetHasWheelChair( true )
	end,
	clearConditionTable ={
		clearStage = {
			demo = {
				demoName = "p01_000030",	
				funcs = {
					
					SetDemoTransform = function()
						local centerPos = Vector3( -443.267, 288.906, 2240.07 )	
						local distance, pos, gameObjectId = Gimmick.SearchNearestSsdGimmick{
							pos = centerPos,
							productionId = "PRD_BLD_StandbyRoom_A",
							heavySearch = true,
							onlyBuilding = true,
							searchRadius = 120,
						}
						if not distance then
							return
						end
						local gimmickPosition, gimmickRotation = Gimmick.SsdGetPosAndRot{ gameObjectId = gameObjectId, }
						if not gimmickPosition then
							Fox.Error("k40090.SetDemoTransform gannot get gimmick gameObjectId.")
							return
						end
						local demoTransform = Vector3( gimmickPosition:GetX(), 287.296, gimmickPosition:GetZ() )	
						return demoTransform
					end,
				 },
			}
		},
	},
}








this.releaseAnnounce = { "OpenCrewDeployment" }

return this
