



local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM

local this = BaseFlagMission.CreateInstance( "k40155" )

local baseImportantGimmickList = TppGimmick.GetBaseImportantGimmickList() or {}


if baseImportantGimmickList[4] then
	baseImportantGimmickList[4].checkObjective = "mission_common_objective_bootDigger"
	baseImportantGimmickList[4].isPowerOn = true
end

this.missionAreas = {
	{
		name = "marker_missionArea",
		trapName = "trap_MissionArea",
		visibleArea = 3,
		guideLinesId = "guidelines_mission_common_wormhole",
	},
}

this.missionDemoBlock = { demoBlockName = "StartDefense2" }

this.disableBaseCheckPoint = true





this.waveSettings = {
	waveList = {
		"wave_k40155",
	},
	wavePropertyTable = {
		wave_k40155 = {
			defenseTimeSec = 390,
			limitTimeSec = 390,
			alertTimeSec = 30,
			defenseGameType = TppDefine.DEFENSE_GAME_TYPE.BASE,
			defensePosition = { useCurrentLocationBaseDiggerPosition = true },
			defenseTargetGimmickProperty = {
				identificationTable = {
					digger = TppGimmick.GetAfghBaseDiggerIdentifier(),
				},
				alertParameters = { needAlert = true, alertRadius = 15, }
			},
			isTerminal = true
		},
	},
	waveTable = {
	 wave_k40155 = {
	  { 15, "SpawnPoint_k40155_0002", ZOMBIE, 4 },
	  { 9, "SpawnPoint_k40155_0001", ZOMBIE, 4 },
	  { 12, "SpawnPoint_k40155_0003", ZOMBIE, 4 },
	  { 18, "SpawnPoint_k40155_0002", ZOMBIE, 6 },
	  { 9, "SpawnPoint_k40155_0001", ZOMBIE, 5 },
	  { 15, "SpawnPoint_k40155_0003", ZOMBIE, 6 },
	  { 50, "SpawnPoint_k40155_0004", ZOMBIE, 6 },
	  { 30, "SpawnPoint_k40155_0005", ZOMBIE, 6 },
	  { 20, "SpawnPoint_k40155_0005", ZOMBIE, 4 },
	  { 70, "SpawnPoint_k40155_0006", ZOMBIE, 4 },
	  { 6, "SpawnPoint_k40155_0006", ZOMBIE, 4 },
	  { 6, "SpawnPoint_k40155_0006", ZOMBIE, 4 },
	  { 35, "SpawnPoint_k40155_0006", ZOMBIE, 4 },
	  { 6, "SpawnPoint_k40155_0006", ZOMBIE, 4 },
	  { 6, "SpawnPoint_k40155_0004", ZOMBIE, 4 },
	  { 6, "SpawnPoint_k40155_0004", ZOMBIE, 4 },
	  { 6, "SpawnPoint_k40155_0006", ZOMBIE, 4 },
	 },
	},
	
	spawnPointDefine = {
		SpawnPoint_k40155_0001 = { spawnLocator = "SpawnPoint_k40155_0001", },
		SpawnPoint_k40155_0002 = { spawnLocator = "SpawnPoint_k40155_0002", },
		SpawnPoint_k40155_0003 = { spawnLocator = "SpawnPoint_k40155_0003", },
		SpawnPoint_k40155_0004 = { spawnLocator = "SpawnPoint_k40155_0004", },
		SpawnPoint_k40155_0005 = { spawnLocator = "SpawnPoint_k40155_0005", },
		SpawnPoint_k40155_0006 = { spawnLocator = "SpawnPoint_k40155_0006", },
	},
}




this.importantGimmickList = TppGimmick.GetBaseImportantGimmickList()	

this.foreceBreakImportantGimmickListIndex = 4	

this.OnActivate = function()
	TppDataUtility.SetVisibleEffectFromGroupId( "k40155_ReturnWormhole", false )
end




this.OnRestoreFVars = function()
	Fox.Log("k40155.OnRestoreFVars")
	local currentStepName = SsdFlagMission.GetCurrentStepName()
	Fox.Log("currentStepName : " .. tostring( currentStepName ))
	if currentStepName == "DemoDefenseStart" or currentStepName == "GameDefense" then
		Fox.Log( "---- OverWriteStep ----" )
		
		local overWriteStepIndex = SsdFlagMission.GetStepIndex( "GameOpening" )
		SsdFlagMission.OverWriteStepIndex( overWriteStepIndex )
		
		SsdFlagMission.InitFVars()
	end
end




this.AddOnTerminate = function()
	Fox.Log("k40155.AddOnTerminate")
	
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
end

local lastAddedStep




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameOpening",
	OnEnter = function()
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
	end,
	OnLeave = function()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
	end,
	options = {
		radio = "f3010_rtrg1500",
		objective = "mission_common_objective_bootDigger",
		marker = { name = "marker_diggerSwitch", areaName = "marker_missionArea", viewType = "world_only_icon", mapTextId = "hud_digger_gauge_caption" },
		nextStepDelay = {
			{ type = "FadeOut", },	
		},
	},
	clearConditionTable = {
		switch = {
			baseImportantGimmickList[4],
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoDefenseStart",
	OnEnter = function()
		
		TppMission.SetInitialWaveName("wave_k40155")
		
		TppClock.SetTime( "12:00:00" )	
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.00 )	
	end,
	OnLeave = function()
		TppWeather.CancelForceRequestWeather()
	end,
	options = {
		setUpWaveSettings = true,
	},
	clearConditionTable = {
		demo = { demoName = "p30_000010", options = { useDemoBlock = true } },
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameDefense",
	OnEnter = function()
		BaseMissionSequence.DisableBaseCheckPoint()	
		
		Gimmick.SetSsdPowerOff{
			gimmickId		= baseImportantGimmickList[1].gimmickId,
			name			= baseImportantGimmickList[1].locatorName,
			dataSetName		= baseImportantGimmickList[1].datasetName,
			powerOff		= true
		}
		
		this.DisableMissionArea( "marker_missionArea" )
		
		TppClock.SetTime( "12:00:00" )	
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.00 )	
		
		TppDataUtility.SetVisibleEffectFromGroupId( "k40155_ReturnWormhole", true )
	end,
	OnLeave = function()
		BaseMissionSequence.EnableBaseCheckPoint()	
		TppWeather.CancelForceRequestWeather()
	end,
	options = {
		radio = "f3010_rtrg1502",
		objective = "mission_common_objective_defendDigger_single",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 10.0, },	
			{ type = "FadeOut", },	
		},
	},
	clearConditionTable = {
		wave = {
			checkObjective = "mission_common_objective_defendDigger_single",
			waveName = "wave_k40155",
			onClearRadio = { name = "f3000_rtrg1117", options = { delayTime = 3.0 } },	
			defenseGameArea = {
				areaTrapName = "trap_baseDefenseGameArea",
				alertTrapName = "trap_baseDefenseGameAlertArea",
			},
		},
	},
}




BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = true,
	},
}




this.blackRadioOnEnd = "K40155_0020"

return this
