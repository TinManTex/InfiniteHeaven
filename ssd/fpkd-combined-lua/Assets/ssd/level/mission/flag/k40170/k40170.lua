





local this = BaseFlagMission.CreateInstance( "k40170" )

local lastAddedStep


this.missionDemoBlock = { demoBlockName = "DiscoverSaheran" }


this.blackRadioZombieList = {
	"zmb_k40170_black_0000",
	"zmb_k40170_black_0001",
	"zmb_k40170_black_0002",
	"zmb_k40170_black_0003",
	"zmb_k40170_black_0004",
	"zmb_k40170_black_0005",
}


this.missionAreas = {
	{ 
		name = "marker_missionArea00", 
		trapName = "trap_missionArea00", 
		visibleArea = 8, 
		guideLinesId = "guidelines_mission_40170_01",
	},
}


this.enterMissionAreaRadio = "f3000_rtrg0200"




BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isMissionEscape",				 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)


this.enemyLevelSettingTable = {
	areaSettingTableList = {
		{
			areaName = "AreamafrWalker",
			level = -4,
			randomRange = 0,
		},
		{
			areaName = "AreamafrMortar",
			level = -6,
			randomRange = 0,
		},
	},
}




this.OnActivate = function()

	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameAfterGetSecuredSahelan" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_40170_01" } )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		
		this.DisableMissionArea( "marker_missionArea00" )
	end
	
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
	
	
	this.SetFixBlackRadioZombie()
	
	
	TppQuest.RegisterSkipStartQuestDemo( "diamond_q22130" )
end

function this.SaheralanSwithPowerSetting( powerOff )
	Gimmick.SetSsdPowerOff{
		gimmickId	= "GIM_P_SahelanRailGun",
		name		= "mgs0_moss_gim_n0000|srt_mgs0_moss0_ssd_v00",
		dataSetName	= "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
		powerOff	= powerOff,
	}
end

function this.SetFixBlackRadioZombie()
	local baseRandVal = 19753 * 30	
	local fovaNumberTable = {
		zmb_k40170_black_0000 = 18,
		zmb_k40170_black_0001 = 6,
	}
	for _, locatorName in ipairs{ "zmb_k40170_black_0000", "zmb_k40170_black_0001", } do
		local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", locatorName )
		local fovaNumber = fovaNumberTable[locatorName]
		Fox.Log( "k40170.SetFixBlackRadioZombie: locatorName = " .. tostring(locatorName) .. ", fovaNumber = " .. tostring(fovaNumber) )
		local command = { id = "SetFixRandVal", randVal = baseRandVal + fovaNumber }
		GameObject.SendCommand( gameObjectId, command )
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameMain",
	OnEnter = function()
		
		this.DisplayGuideLine( { "guidelines_mission_40170_01"} )
	end,
	OnLeave = function()
		TppQuest.UnregisterSkipStartQuestDemo()
	end,
	options = {
		radio = "f3010_rtrg1800",
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea00", },
		},
		objective = "mission_40170_objective_03",
		nextStepDelay = {
			{ type = "FadeOut", fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED },
		},
		disableEnemy = this.blackRadioZombieList,
	},
	clearConditionTable = {
		trap = "trap_enemy",
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoDiscoverSahelan",
	options = {
		disableEnemy = this.blackRadioZombieList,
	},
	clearConditionTable = {
		demo = {
			demoName = "p40_000020",
			options = { useDemoBlock = true, waitBlockLoadEndOnDemoSkip = false, }
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameGetSecuredSahelan",
	previousStep = lastAddedStep,
	OnEnter = function( self )
		self.lastDefenseGameState = nil
	end,
	OnLeave = function( self )
		self.lastDefenseGameState = nil
	end,
	
	AddOnUpdate = function( self )
		local defenseGameState = Mission.GetDefenseGameState()
		local isDefenseGameActive, isChangedDefenseGameState
		if ( defenseGameState ~= TppDefine.DEFENSE_GAME_STATE.NONE ) then
			isDefenseGameActive = true
		else
			isDefenseGameActive = false
		end
		if ( self.lastDefenseGameState ~= defenseGameState ) then
			isChangedDefenseGameState = true
		end
		self.lastDefenseGameState = defenseGameState
		
		if isChangedDefenseGameState then
			if isDefenseGameActive then
				this.SaheralanSwithPowerSetting( true )
			else
				this.SaheralanSwithPowerSetting( false )
			end
		end
	end,
	options = {
		continueRadio = "f3010_rtrg1800",
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea00", },
		},
		objective = "mission_40170_objective_03",
		nextStepDelay = {
			{ type = "FadeOut", fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED },
		},
		disableEnemy = this.blackRadioZombieList,
	},
	clearConditionTable = {
		switch = {
			{
				gimmickId	= "GIM_P_SahelanRailGun",
				locatorName = "mgs0_moss_gim_n0000|srt_mgs0_moss0_ssd_v00",
				datasetName = "/Assets/tpp/level/location/mafr/block_large/lab/mafr_lab_gimmick.fox2",
				isPowerOn = true,
				isAlertLockType = true,
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "DemoGetSecuredSahelan",
	previousStep = lastAddedStep,
	OnLeave = function()
		TppPlayer.Warp{ pos = { 2704.43, 70.0, -1895.23 }, rotY = -77.0953 }
	end,
	options = {
		disableEnemy = this.blackRadioZombieList,
	},
	clearConditionTable = {
		searchDemo = {
			identifier = "GetIntelIdentifier_k40170_sequence",
			key = "GetIntel_sahelan",
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "DemoBlackRadioAfterSecuredSahelan",
	previousStep = lastAddedStep,
	options = {
		disableEnemy = this.blackRadioZombieList,
	},
	clearConditionTable = {
		blackRadio = {
			blackRadioList = { "K40170_0010" },
		},
	},
}

this.flagStep.DemoBlackRadioAfterSecuredSahelan.messageTable = {
	UI = {
		{
			msg = "BlackRadioClosed",
			func = function()
				Fox.Log( "k40170.Messages(): DemoBlackRadioAfterSecuredSahelan: msg:BlackRadioClosed" )
				local targetEnemyType = "SsdZombie"
				for _, enemyName in ipairs( this.blackRadioZombieList ) do
					TppEnemy.SetEnablePermanent( enemyName, targetEnemyType )
				end
				
				Player.StartTargetConstrainCamera {
					cameraType = PlayerCamera.Around,	
					force = true,	
					fixed = true,	
					recoverPreOrientation = false,	
					gameObjectName ="zmb_k40170_black_0000",	
					skeletonName = "SKL_004_HEAD",	
					interpTime = 0.6,	
					areaSize = 0.5,	
					time = 1.0,		
					focalLength = 32.0,	
					focalLengthInterpTime = 0.3,	
					minDistance = 1.0,	
					maxDistanve = 50.0,	
					doCollisionCheck =false,	
				}
			end,
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameAfterGetSecuredSahelan",
	previousStep = lastAddedStep,
	OnEnter = function( self )
		
		table.insert( self.conditionVarsNameList, "isMissionEscape" )
		
		local command = { id = "SetForceAlert" }
		for _, enemyName in ipairs{ "zmb_k40170_black_0000", "zmb_k40170_black_0001", } do
			local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", enemyName ) 
			GameObject.SendCommand( gameObjectId, command )
		end
		
		GkEventTimerManager.Start( "TimerGuaranteeGoNextStep", 30 )
	end,
	OnLeave = function()
		
		if GkEventTimerManager.IsTimerActive( "TimerGuaranteeGoNextStep" ) then
			GkEventTimerManager.Stop( "TimerGuaranteeGoNextStep" )
		end
	end,
	options = {
		radio =  "f3010_rtrg1804",
		objective = "mission_40170_objective_03",
		checkObjectiveIfCleared = "mission_40170_objective_03",
		enableEnemy = this.blackRadioZombieList,
	},
	clearConditionTable = {},
}


this.flagStep.GameAfterGetSecuredSahelan.GoToNextStep = function()
	Fox.Log( "k40170.GameAfterGetSecuredSahelan.GoToNextStep" )
	local conditionVarsName = "isMissionEscape"
	fvars[conditionVarsName]= true
	this.flagStep.GameAfterGetSecuredSahelan:GoToNextStepIfConditionCleared( conditionVarsName )
end




this.flagStep.GameAfterGetSecuredSahelan.messageTable = {
	Radio = {
		{
			msg = "Finish",
			func = function( radioName )
				if radioName == Fox.StrCode32( "f3010_rtrg1804" ) then
					this.flagStep.GameAfterGetSecuredSahelan.GoToNextStep()
				end
			end,
			option = { isExecFastTravel = true, },
		},
	},
	
	Timer = {
		{
			msg = "Finish",
			sender = "TimerGuaranteeGoNextStep",
			func = function()
				Fox.Log( "k40170.Messages(): TimerGuaranteeGoNextStep: msg:Finish" )
				this.flagStep.GameAfterGetSecuredSahelan.GoToNextStep()
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
		
		this.DisableGuideLine()
		
		this.DisableMissionArea( "marker_missionArea00" )
	end,
	OnLeave = function()
	end,
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToFOB", },
	},
	options = {
		radio = { name = "f3000_rtrg0204", options = { delayTime = 2.0 } },	
		objective = "mission_common_objective_returnToFOB",
		enableEnemy = this.blackRadioZombieList,
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameAiAccess",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		TppMarker.Enable( "marker_target_AI", 0, "moving", "all", 0, true, true )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
	end,
	OnLeave = function()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		TppMarker.Disable( "marker_target_AI" )
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
	addStepName = "Gameclear",
	previousStep = lastAddedStep,
	clearConditionTable = {
		clearStage = {
			demo = "p01_000010",
			fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED,
		},
	},
	options = {
	},
}





this.blackRadioOnEnd = { "K40170_0020", }

return this
