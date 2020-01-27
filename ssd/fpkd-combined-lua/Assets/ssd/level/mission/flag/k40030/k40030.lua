




local this = BaseFlagMission.CreateInstance( "k40030" )

local lastAddedStep


local tipsMenuList = {
	
	TIPS_CREW_MANAGEMENT = {
		tipsRadio = "f3000_rtrg2002",
		tipsTypes = { HelpTipsType.TIPS_101_A, HelpTipsType.TIPS_101_B, HelpTipsType.TIPS_101_C },
	},
}




this.missionAreas = {
	{
		name = "marker_missionArea", 
		trapName = "trap_missionArea", 
		visibleArea = 5, 
		guideLinesId = "guidelines_mission_common_memoryBoard", 
		hide = true
	},
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isStartKaiju",		type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isEnterRuin",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioEntrance01",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioEntrance02",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioGoal",			type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioCadaver01",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioCadaver02",	type = TppScriptVars.TYPE_BOOL, value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()

	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	mvars.isDisableEntranceMarker	= false
	mvars.isTrapCadaver01			= false
	mvars.isTimerCadaver01			= false
	mvars.isTrapCadaver02			= false
	mvars.isTimerCadaver02			= false
	mvars.isStartKaiju				= false

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameAiAccess" ) then
		this.DisableMissionArea( "marker_missionArea" )
	end
	
	
	if stepIndex == SsdFlagMission.GetStepIndex( "GameMain" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
	end
	
	
	if ( stepIndex >= SsdFlagMission.GetStepIndex( "GameTutorialStart" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameTutorialWaitCloseMenu" ) ) or ( stepIndex >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) ) then
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
	
	
	this.SetZombieBomLevel()
end




this.messageTable = {

	GameObject = {
		{	
			msg = "PickupTreasurePoint",
			func = function( gameObjectId, locatorName, dataSetName, itemName )
				Fox.Log( "PickupTreasurePoint locatorName:" ..tostring( locatorName ) .. " dataSetName:" ..tostring( dataSetName ).. " gameObjectId:" ..tostring( gameObjectId ))
				if dataSetName ==  Gimmick.GetDataSetCode( "/Assets/ssd/level/mission/flag/k40030/k40030_item.fox2" ) then
					if locatorName == Fox.StrCode32( "com_treasure_null001_gim_n0000|srt_gim_null_treasure" ) then
						
						this.PlayRadioCadaver01()
					elseif locatorName == Fox.StrCode32( "com_treasure_null001_gim_n0001|srt_gim_null_treasure" ) then
						
						this.PlayRadioCadaver02()
					end
				end
			end
		},
	},
	Trap = {
		{	
			sender = "trap_cadaver01",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if mvars.isTrapCadaver01 == false then
					mvars.isTrapCadaver01 = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_cadaver01",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				if mvars.isTrapCadaver01 == true and mvars.isTimerCadaver01 == false then
					mvars.isTimerCadaver01 = true
					GkEventTimerManager.Start( "TimerCadaver01", 3 )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_cadaver02",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if mvars.isTrapCadaver02 == false then
					mvars.isTrapCadaver02 = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_cadaver02",
			msg = "Exit",
			func = function( trapName, gameObjectId )
				if mvars.isTrapCadaver02 == true and mvars.isTimerCadaver02 == false then
					mvars.isTimerCadaver02 = true
					GkEventTimerManager.Start( "TimerCadaver02", 3 )
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_kaiju",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if SsdFlagMission.GetCurrentStepIndex() >= SsdFlagMission.GetStepIndex( "GameReturnToBase" ) then
					if fvars.isStartKaiju == false then
						TppEnemy.SetKaijuRailStartPosition( "rail_kaiju_area01_k40030", Vector3( -87.548, 274.146, 1899.244 ) )
						TppEnemy.SetEnableKaiju()
						TppRadio.Play("f3010_rtrg0608", { delayTime = 8.0 } )	
						fvars.isStartKaiju = true
						mvars.isStartKaiju = true
					end
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = "TimerCadaver01",
			func = function()
				
				this.PlayRadioCadaver01()
			end
		},
		{	
			msg = "Finish",
			sender = "TimerCadaver02",
			func = function()
				
				this.PlayRadioCadaver02()
			end
		},
	},
}




function this.PlayRadioCadaver01()
	if fvars.isRadioCadaver01 == false then
		TppRadio.Play( "f3010_rtrg0604", { delayTime = "mid" } )
		fvars.isRadioCadaver01 = true
	end
end




function this.PlayRadioCadaver02()
	if fvars.isRadioCadaver02 == false then
		TppRadio.Play( "f3010_rtrg0606", { delayTime = "mid" } )
		fvars.isRadioCadaver02 = true
	end
end




function this.CheckGeorgeIsAlreadyFarmingGroup( self )
	if self.needCheckIsGeorgeAlreadyFarmingGroup then
		if ( SsdCrewSystem.GetUniqueCrewGroup{ uniqueType = SsdCrewType.UNIQUE_TYPE_MLT } == SsdCrewGroup.GROUP_FARM )
		or ( SsdCrewSystem.GetUniqueCrewGroup{ uniqueType = SsdCrewType.UNIQUE_TYPE_NRS } == SsdCrewGroup.GROUP_FARM ) then
			Fox.Log("George is already assigned")
			SsdFlagMission.SetNextStep( "GameMain" )
		end
		self.needCheckIsGeorgeAlreadyFarmingGroup = false
	end
end




this.SetZombieBomLevel = function()
	Fox.Log( "s40030_SetZombieBomLevel")
	local gameObjectId = GameObject.GetGameObjectId( "SsdZombieBom", "zmb_dungeon01_01_0009" )
	local command = { id = "SetLevelForce", level = 2 }
	GameObject.SendCommand( gameObjectId, command )
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameTutorialStart",
	OnEnter = function( self )
		self.needCheckIsGeorgeAlreadyFarmingGroup = true
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		MissionObjectiveInfoSystem.SetForceOpen2( true ) 
	end,
	AddOnUpdate = this.CheckGeorgeIsAlreadyFarmingGroup,
	options = {
		radio = "f3000_rtrg2001",
		recipe = {
			
			"RCP_BLD_VegetableFarm_A",		
			"RCP_BLD_Shelter_A",			
		},
		objective = {
			{
				langId = "mission_common_objective_accessToAI",
				facilityMenuType = FacilityMenuType.CREW_MANAGEMENT,
			},
		},
	},
}

this.flagStep.GameTutorialStart.messageTable = {
	UI = {
		{	
			msg = "CrewManagementMenuOpened",
			func = function()
				SsdFlagMission.SetNextStep( "GameTutorialShowTips" )
			end
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTutorialShowTips",
	OnEnter = function( self )
		self.needCheckIsGeorgeAlreadyFarmingGroup = true
	end,
	AddOnUpdate = this.CheckGeorgeIsAlreadyFarmingGroup,
	clearConditionTable = {
		tips = tipsMenuList.TIPS_CREW_MANAGEMENT,
	},
	options = {
		objective = {
			{
				langId = "mission_40030_objective_01",
				facilityMenuType = FacilityMenuType.CREW_MANAGEMENT,
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTutorialWaitAssign",
	OnEnter = function( self )
		self.needCheckIsGeorgeAlreadyFarmingGroup = true
	end,
	AddOnUpdate = this.CheckGeorgeIsAlreadyFarmingGroup,
	nextStepName = "GameTutorialWaitCloseMenu",
	options = {
		objective = {
			{
				langId = "mission_40030_objective_01",
				facilityMenuType = FacilityMenuType.CREW_MANAGEMENT,
			},
		},
	},
}

this.flagStep.GameTutorialWaitAssign.messageTable = {
	SsdCrewSystem = {
		{	
			msg = "SetGroup",
			func = function( uniqueIndex, group )
				
				if ( group == SsdCrewGroup.GROUP_FARM ) then
					MissionObjectiveInfoSystem.Check{ langId = "mission_40030_objective_01", checked = true, }
					SsdFlagMission.SetNextStep( "GameTutorialWaitCloseMenu" )
				end
			end
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameTutorialWaitCloseMenu",
	OnEnter = function( self )
		GkEventTimerManager.Start( "TimerNextStepGameMain", 10 )
	end,
}

this.flagStep.GameTutorialWaitCloseMenu.messageTable = {
	UI = {
		{	
			msg = "FacilityListMenuClosed",
			func = function()
				SsdFlagMission.SetNextStep( "GameMain" )
			end
		},
	},
	Timer = {
		{	
			msg = "Finish",
			sender = "TimerNextStepGameMain",
			func = function()
				local stepIndex = SsdFlagMission.GetCurrentStepIndex()
				if stepIndex == SsdFlagMission.GetStepIndex( "GameTutorialWaitCloseMenu" ) then
					SsdFlagMission.SetNextStep( "GameMain" )
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}


this.afterDemoFunc01 = function()
	
	SsdSbm.AddArchive{ id = { "ARCHIVE_A_005", "ARCHIVE_B_005" } }
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMain",
	OnEnter = function( self )
		
		this.DisplayMissionArea("marker_missionArea")
		
		this.DisplayGuideLine( { "guidelines_mission_common_memoryBoard"} )
		
		this.SetMissionObjective( true, false )
		
		MissionObjectiveInfoSystem.SetForceOpen( false )
		MissionObjectiveInfoSystem.SetForceOpen2( false ) 
	end,
	OnLeave = function( self )
		
		TppMarker.Disable( "marker_target" )
		TppMarker.Disable( "marker_dungeon" )
	end,
	options = {
		radio = "f3010_rtrg0600",
		objective = "mission_common_objective_getMemoryBoard_atRuin",
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId			= "GIM_P_CommonSwitch",
				locatorName			= "ssde_swtc001_bord001_gim_n0000|srt_ssde_swtc001_bord001",
				datasetName			= "/Assets/ssd/level/location/afgh/block_extraLarge/south/afgh_south_gimmick.fox2",
				isPowerOn			= true,
				isAlertLockType		= true,
				checkObjective		= "mission_common_objective_getMemoryBoard_atRuin",
				memoryBoardDemo = {
					identifier = "GetIntelIdentifier_k40030_sequence",
					key = "GetIntel_wormhole",
					afterDemoFunc = this.afterDemoFunc01,
				},
			},
		},
	},
}


this.SetMissionObjective = function( isInit, isCheck )
	if isInit == true then
		
		MissionObjectiveInfoSystem.Clear()
	end
	if isCheck == true and fvars.isEnterRuin == false then
		MissionObjectiveInfoSystem.Check{ langId = "mission_common_objective_enterRuin", checked = true, }
		fvars.isEnterRuin = true
	end
	if fvars.isEnterRuin == false then
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_enterRuin", }				
	else
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_common_objective_getMemoryBoard_atRuin", }	
	end
end

this.flagStep.GameMain.messageTable = {
	Trap = {
		{	
			sender = "trap_missionArea",
			msg = "Enter",
			func = function()
				
				TppMarker.Enable( "marker_dungeon", 0, "moving", "all", 0, true, true )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_missionArea",
			msg = "Exit",
			func = function()
				TppMarker.Disable( "marker_dungeon" )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_entranceOff",
			msg = "Enter",
			func = function()
				mvars.isDisableEntranceMarker = true
				TppMarker.Disable( "marker_dungeon" )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_entranceOn",
			msg = "Enter",
			func = function()
				if mvars.isDisableEntranceMarker == true then
					mvars.isDisableEntranceMarker = false
					
					TppMarker.Enable( "marker_dungeon", 0, "moving", "all", 0, true, true )
				end
				
				this.SetMissionObjective( false, true )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_goal",
			msg = "Enter",
			func = function()
				
				TppMarker.Enable( "marker_target", 0, "moving", "all", 0, true, true )
				
				if fvars.isRadioGoal == false then
					TppRadio.Play("f3000_rtrg0226")
					fvars.isRadioGoal = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_goal",
			msg = "Exit",
			func = function()
				TppMarker.Disable( "marker_target" )
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_radio01",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if fvars.isRadioEntrance01 == false then
					TppRadio.Play("f3010_rtrg0602")
					fvars.isRadioEntrance01 = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
		{	
			sender = "trap_radio02",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				if fvars.isRadioEntrance02 == false then
					TppRadio.Play("f3000_rtrg1701")
					fvars.isRadioEntrance02 = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameReturnToBase",
	OnEnter = function( self )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		this.DisableGuideLine()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end,
	options = {
		radio = "f3000_rtrg0204",
		objective = "mission_common_objective_returnToBase",
		checkObjectiveIfCleared = "mission_common_objective_returnToBase",
	},
	clearConditionTable = {
		home = true,
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameAiAccess",
	OnEnter = function( self )
		TppMarker.Enable( "marker_ai", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		if mvars.isStartKaiju == false then
			TppEnemy.SetKaijuRailStartPosition( "rail_kaiju_area01_k40030", Vector3( -87.548, 274.146, 1899.244 ) )
			mvars.isStartKaiju = true
		end
	end,
	options = {
		radio = "f3000_rtrg0257",
		objective = "mission_common_objective_accessToAI",
		checkObjectiveIfCleared = "mission_common_objective_accessToAI",
	},
	clearConditionTable = {
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
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = { demo = "p01_000010", fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED, },
	}
}




this.clearRadio = "f3000_rtrg0213"




this.blackRadioOnEnd = "K40030_0020"





this.releaseAnnounce = { "EnhanceWormholeExtractionDevice" }

return this
