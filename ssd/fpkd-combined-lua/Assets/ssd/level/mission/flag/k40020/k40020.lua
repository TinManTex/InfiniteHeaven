




local this = BaseFlagMission.CreateInstance( "k40020" )

local lastAddedStep


this.registerRescueTargetUniqueCrew = {
	locatorName = "npc_k40020_0000",
	uniqueType = SsdCrewType.UNIQUE_TYPE_NRS,
}




this.importantGimmickList = {
	{
		gimmickId	= "GIM_P_Portal",
		locatorName = "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		datasetName	= "/Assets/ssd/level/location/afgh/block_extraLarge/south/afgh_south_gimmick.fox2",
	}
}




this.missionAreas = {
	{
		name = "marker_missionArea", trapName = "trap_missionArea", visibleArea = 5, guideLinesId = "guidelines_mission_common_signal"
	},
}




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameNpcCarry" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_signal"} )
	end

	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end

	
	TppQuest.RegisterSkipStartQuestDemo( "field_q22010" )

end


this.enemyRouteTable = {
	{ enemyName = "zmb_k40020_0000", routeName = "rt_k40020_0000", },
	{ enemyName = "zmb_k40020_0001", routeName = "rt_k40020_0001", },
	{ enemyName = "zmb_k40020_0002", routeName = "rt_k40020_0002", },
	{ enemyName = "zmb_k40020_0003", routeName = "rt_k40020_0003", },
	{ enemyName = "zmb_k40020_0006", routeName = "rt_k40020_0004", },
	{ enemyName = "zmb_k40020_0007", routeName = "rt_k40020_0005", },
}


this.disableEnemy = {
	{ enemyName = "zmb_dungeon01_01_0001" },
	{ enemyName = "zmb_dungeon01_00_0002" },
}


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isEnterDoor",			type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioMissionArea",	type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isRadioTarget",		type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameNpcCarry",
	OnEnter = function( self )
		
		this.DisplayGuideLine( { "guidelines_mission_common_signal" } )
	end,
	OnLeave = function()
		
		this.SetNpcCarryMarker( false )
	end,
	clearConditionTable = {
		carry = {
			{ locatorName = "npc_k40020_0000", },
		},
	},
	options = {
		continueRadio = "f3010_rtrg0501",
		objective = "mission_40020_objective_02",
		checkObjectiveIfCleared = "mission_40020_objective_02",
		onLeaveRadio = "f3000_rtrg0803",
	}
}

this.flagStep.GameNpcCarry.messageTable = {
	Trap = {
		{
			sender = "trap_missionArea",
			msg = "Enter",
			func = function()
				if fvars.isRadioMissionArea == false then
					TppRadio.Play( "f3010_rtrg0502" )
					fvars.isRadioMissionArea = true
				end
				this.SetNpcCarryMarker( true )
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_target",
			msg = "Enter",
			func = function()
				if fvars.isRadioTarget == false then
					TppRadio.Play( "f3010_rtrg0504" )
					fvars.isRadioTarget = true
				end
				this.SetNpcCarryMarker( true )
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_missionArea",
			msg = "Exit",
			func = function()
				this.SetNpcCarryMarker( false )
			end,
			option = { isExecFastTravel = true, },
		},
	},
}

this.SetNpcCarryMarker = function( isEnable )
	if isEnable == true then
		if fvars.isRadioTarget == false then
			TppMarker.Disable( "marker_target" )
			TppMarker.Enable( "marker_signal", 0, "moving", "all", 0, true, true )
		else
			TppMarker.Disable( "marker_signal" )
			TppMarker.Enable( "marker_target", 0, "moving", "all", 0, true, true )
		end
	else
		TppMarker.Disable( "marker_signal" )
		TppMarker.Disable( "marker_target" )
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameEscape",
	OnEnter = function( self )
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		if TppGameStatus.IsSetBy( "trap_missionArea", "S_IN_MISSION_AREA" ) then
			TppMarker.Enable( "marker_door", 0, "moving", "all", 0, true, true )
		end
	end,
	options = {
		continueRadio = "f3010_rtrg0503",
		objective = "mission_40020_objective_03",
		route = {
			{ enemyName = "zmb_k40020_0000", routeName = "", },
			{ enemyName = "zmb_k40020_0001", routeName = "", },
			{ enemyName = "zmb_k40020_0002", routeName = "", },
			{ enemyName = "zmb_k40020_0003", routeName = "", },
			{ enemyName = "zmb_k40020_0006", routeName = "", },
			{ enemyName = "zmb_k40020_0007", routeName = "", },
		},
	},
	clearConditionTable = {
		rescue = {
			{
				locatorName = "npc_k40020_0000",
				rescueDemo = { demoName ="p01_000021", options = { finishFadeOut = true } },	
				checkObjective = "mission_40020_objective_03",
			},
		},
	},
}

this.flagStep.GameEscape.messageTable = { 
	Trap = {
		{
			sender = "trap_missionArea",
			msg = "Enter",
			func = function()
				this.SetEscapeMarker( true, false )
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_missionArea",
			msg = "Exit",
			func = function()
				this.SetEscapeMarker( false, false )
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_fastTravel",
			msg = "Enter",
			func = function()
				this.SetEscapeMarker( true, true )
			end,
			option = { isExecFastTravel = true, },
		},
		{
			sender = "trap_fastTravel",
			msg = "Exit",
			func = function()
				this.SetEscapeMarker( true, false )
			end,
			option = { isExecFastTravel = true, },
		},
	},
}

this.SetEscapeMarker = function( isEnable, isFastTravel )
	if isEnable == true then
		if isFastTravel == false then
			TppMarker.Disable( "marker_fastTravel" )
			TppMarker.Enable( "marker_door", 0, "moving", "all", 0, true, true )
		else
			TppMarker.Disable( "marker_door" )
			TppMarker.Enable( "marker_fastTravel", 0, "moving", "all", 0, true, true )
		end
	else
		TppMarker.Disable( "marker_door" )
		TppMarker.Disable( "marker_fastTravel" )
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = true,
	}
}




this.blackRadioOnEnd = "K40020_0020"




this.releaseAnnounce = { "EnableCrewAssign", "OpenNewUnitFarm", "EnableFarming" }

return this
