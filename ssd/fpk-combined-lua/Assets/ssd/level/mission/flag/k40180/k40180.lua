




local this = BaseFlagMission.CreateInstance( "k40180" )

local lastAddedStep

this.registerRescueTargetUniqueCrew = {
	locatorName = "npc_k40180_0000",
	uniqueType = SsdCrewType.UNIQUE_TYPE_SETH,
}


this.missionDemoBlock = { demoBlockName = "EncounterDan" }




BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isRadioMissionArea", type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)


this.missionAreas = {
	{
		name = "marker_missionArea", 
		trapName = "trap_missionArea", 
		visibleArea = 6, 
		guideLinesId = "guidelines_mission_40180_01",
	},

	{ 
		name = "marker_missionArea01", 
		trapName = "trap_missionArea01", 
		visibleArea = 6, 
		hide = true,
	},
}




function this.SetEventDoorLock()
	Fox.Log("k40180.SetEventDoorLock")
	Gimmick.SetEventDoorLock(
		"mafr_fenc005_door001_gim_n0000|srt_mafr_fenc005_door001",
		"/Assets/tpp/level/location/mafr/block_small/151/151_125/mafr_151_125_asset.fox2",
		true,	
		0	
	)
end

function this.ResetEventDoorLock()
	Fox.Log("k40180.ResetEventDoorLock")
	Gimmick.SetEventDoorLock(
		"mafr_fenc005_door001_gim_n0000|srt_mafr_fenc005_door001",
		"/Assets/tpp/level/location/mafr/block_small/151/151_125/mafr_151_125_asset.fox2",
		false,	
		1	
	)
end

function this.SetEventDoorInvincible( isInvincible )
	Fox.Log("k40180.SetEventDoorLock: isInvincible = " .. tostring( isInvincible ) )
	local result = Gimmick.SetInvincible{
		gimmickId = "GIM_P_Door",
		name = "mafr_fenc005_door001_gim_n0000|srt_mafr_fenc005_door001",
		dataSetName = "/Assets/tpp/level/location/mafr/block_small/151/151_125/mafr_151_125_asset.fox2",
		isInvincible = isInvincible,
	}
end




this.OnActivate = function()

	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	
	local isEventDoorStageBlockActive = Tpp.IsLoadedSmallBlock( 151, 125 )
	if stepIndex <= SsdFlagMission.GetStepIndex( "GameGoToEncountArea" ) then
		if isEventDoorStageBlockActive then
			this.SetEventDoorLock()
		end
		this.SetEventDoorInvincible( true )
	else
		if isEventDoorStageBlockActive then
			this.ResetEventDoorLock()
		end
		this.SetEventDoorInvincible( false )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameGoToEncountArea" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_40180_01"} )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisplayMissionArea( "marker_missionArea01" )
		this.DisableMissionArea( "marker_missionArea" )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end

	
	TppQuest.RegisterSkipStartQuestDemo( "diamond_q22160" )
	
end


this.AddOnTerminate = function()
	this.SetEventDoorInvincible( false )
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameGoToEncountArea",
	previousStep = lastAddedStep,
	OnEnter = function( self )
		
		if Tpp.IsLoadedSmallBlock( 151, 125 ) then
			this.SetEventDoorLock()
		end
		
		this.DisplayGuideLine( { "guidelines_mission_40180_01"} )
	end,
	options = {
		radio = "f3010_rtrg1700",
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea" },
		},
		objective = "mission_40180_objective_01",
		nextStepDelay = {
			{ type = "FadeOut", },
		},
	},
	clearConditionTable = {
		trap = "trap_encountArea",	
	},
}

local EVENT_DOOR_POS = { 2389.897, 96.41132, -908.4319 }
local CHECK_ENEMY_RANGE = 10	


this.flagStep.GameGoToEncountArea.messageTable = {
	Trap = {
		{
			sender = "trap_missionArea",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				
				this.SetEventDoorLock()
				
				if fvars.isRadioMissionArea == false then
					TppRadio.Play("f3010_rtrg1702")
					fvars.isRadioMissionArea = true
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
	Player = {
		{	
			msg = "CheckEventDoorNgIcon",
			func = function( playerId, doorId )
				Fox.Log("player in event door")
				local isPlaying = TppRadioCommand.IsPlayingRadio()
				local canOpen, checkAlert, checkEnemy = TppDemo.CheckEventDemoDoor( doorId, EVENT_DOOR_POS, CHECK_ENEMY_RANGE )
				if canOpen then
					
				elseif ( checkAlert == false ) then
					
				elseif ( checkEnemy == false ) then
					
				end
			end
		},
		{	
			msg = "StartEventDoorPicking",
			func = function ()
				
				local fvarsName = "k40180_GameGoToEncountArea_trap_trap_encountArea"
				fvars[fvarsName] = true
				this.flagStep.GameGoToEncountArea:GoToNextStepIfConditionCleared( fvarsName )
			end
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoEncount",
	OnEnter = function( self )
		
		TppDemo.SpecifyIgnoreNpcDisable( "npc_k40180_0000" )
		
		Gimmick.InvisibleGimmick(
			0,
			"mafr_fenc005_door001_gim_n0000|srt_mafr_fenc005_door001",
			"/Assets/tpp/level/location/mafr/block_small/151/151_125/mafr_151_125_asset.fox2",
			true,
			{ gimmickId = "GIM_P_Door", }
		)
	end,
	OnLeave= function( self )
		
		Gimmick.InvisibleGimmick(
			0,
			"mafr_fenc005_door001_gim_n0000|srt_mafr_fenc005_door001",
			"/Assets/tpp/level/location/mafr/block_small/151/151_125/mafr_151_125_asset.fox2",
			false,
			{ gimmickId = "GIM_P_Door", }
		)
	end,
	clearConditionTable = {
		demo = {
			demoName = "p40_000015",
			options = { useDemoBlock = true, waitBlockLoadEndOnDemoSkip = false, }
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMain",
	OnEnter = function()
		this.SetEventDoorInvincible( false )
		this.ResetEventDoorLock()
	end,
	options = {
		continueRadio = "f3010_rtrg1703",
		onLeaveRadio = "f3000_rtrg0814",
		marker = {
			{ name = "marker_crew", areaName = "marker_missionArea" },
		},
		objective = "mission_40180_objective_01",
		checkObjectiveIfCleared = "mission_40180_objective_01",
	},
	clearConditionTable = {
		carry = {
			{ locatorName = "npc_k40180_0000", },
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameEscape",
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisplayMissionArea( "marker_missionArea01" )
		
		this.DisableMissionArea( "marker_missionArea" )
	end,
	options = {
		continueRadio = "f3010_rtrg1703",
		objective = "mission_40180_objective_02",
		checkObjectiveIfCleared = "mission_40180_objective_02",
		marker = {
			{ name = "marker_return", areaName = "marker_missionArea01", mapTextId = "hud_facilityInfo_fastTravel_name" },
		},
	},
	clearConditionTable = {
		rescue = {
			{
				locatorName = "npc_k40180_0000",
				rescueDemo = {
					demoName = "p01_000020",
					funcs = {
						onStart = function()
							
							Fox.Log("k40180: p01_000020.onStart: SetDemoVoice")
							local gameObjectId = GameObject.SendCommand( { type="SsdCrew" }, { id = "GetRescuedCrew" } )
							if gameObjectId then
								GameObject.SendCommand( gameObjectId, { id = "SetDemoVoice",	voiceId="POWV_0050" } )
							end
						end,
					},
					options = { finishFadeOut = true }
				},	
				checkObjective =  "mission_40180_objective_02",
			},
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = true,
	}
}




this.blackRadioOnEnd = "K40180_0020"

return this
