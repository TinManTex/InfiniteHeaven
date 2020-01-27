



local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM

local this = BaseFlagMission.CreateInstance( "k40075" )

this.missionAreas = {
	{
		name = "marker_missionArea",
		trapName = "trap_MissionArea_k40075",
		visibleArea = 3,
		guideLinesId = "guidelines_mission_common_wormhole",
	},
}

this.missionDemoBlock = { demoBlockName = "StartDefense" }

this.disableBaseCheckPoint = true

this.demoEnemyList = {}
for i = 0, 2 do
	local enemyName = string.format( "zmb_k40075_%04d", i )
	table.insert( this.demoEnemyList, enemyName )
end




this.waveSettings = {
	waveList = {
		"wave_k40075",
	},
	wavePropertyTable = {
		wave_k40075 = {
			limitTimeSec	= (60 * 7),
			defenseTimeSec	= (60 * 7),
			alertTimeSec	= 30,
			isTerminal		= true,
			defensePosition = TppGimmick.GetCurrentLocationDiggerPosition(),
			endEffectName	= "explosion_afgh00_k40075",
			defenseGameType = TppDefine.DEFENSE_GAME_TYPE.BASE,
			defenseTargetGimmickProperty = {
				identificationTable = {
					digger = TppGimmick.GetAfghBaseDiggerIdentifier()
				},
				alertParameters = { needAlert = true, alertRadius = 15, }
			},
		},
	},
	waveTable = {
	 wave_k40075 = {
	  { 15, "SpawnPoint_k40075_0002_0", ZOMBIE, 1, -1 },
	  { 6, "SpawnPoint_k40075_0002_3", ZOMBIE, 2, -1 },
	  { 9, "SpawnPoint_k40075_0002_1", ZOMBIE, 2, -1 },
	  { 6, "SpawnPoint_k40075_0002_2", ZOMBIE, 2, -1 },
	  { 15, "SpawnPoint_k40075_0002_1", ZOMBIE, 2, -1 },
	  { 6, "SpawnPoint_k40075_0002_0", ZOMBIE, 1, -1 },
	  { 6, "SpawnPoint_k40075_0002_2", ZOMBIE, 2, -1 },
	  { 15, "SpawnPoint_k40075_0002_0", ZOMBIE, 2, -1 },
	  { 6, "SpawnPoint_k40075_0002_3", ZOMBIE, 1, -1 },
	  { 6, "SpawnPoint_k40075_0002_1", ZOMBIE, 2, -1 },
	  { 60, "SpawnPoint_k40075_0003", ZOMBIE, 3, -1 },
	  { 9, "SpawnPoint_k40075_0003", ZOMBIE, 3, -1 },
	  { 1, "SpawnPoint_k40075_0003", BOM, 1, },
	  { 30, "SpawnPoint_k40075_0003", ZOMBIE, 6, -1 },
	  { 3, "SpawnPoint_k40075_0003", BOM, 1, },
	  { 40, "SpawnPoint_k40075_0001", ZOMBIE, 3, -1 },
	  { 12, "SpawnPoint_k40075_0001", ZOMBIE, 3, -1 },
	  { 40, "SpawnPoint_k40075_0001", ZOMBIE, 3, -1 },
	  { 6, "SpawnPoint_k40075_0001", ZOMBIE, 3, -1 },
	  { 6, "SpawnPoint_k40075_0003", ZOMBIE, 3, -1 },
	  { 6, "SpawnPoint_k40075_0003", ZOMBIE, 3, -1 },
	  { 20, "SpawnPoint_k40075_0001", ZOMBIE, 3, -1 },
	  { 9, "SpawnPoint_k40075_0003", ZOMBIE, 3, -1 },
	 },
	},
	
	spawnPointDefine = {
		SpawnPoint_k40075_0001 = { spawnLocator = "SpawnPoint_k40075_0001", },
		SpawnPoint_k40075_0002_0 = { spawnLocator = "SpawnPoint_k40075_0002_0", },
		SpawnPoint_k40075_0002_1 = { spawnLocator = "SpawnPoint_k40075_0002_1", },
		SpawnPoint_k40075_0002_2 = { spawnLocator = "SpawnPoint_k40075_0002_2", },
		SpawnPoint_k40075_0002_3 = { spawnLocator = "SpawnPoint_k40075_0002_3", },
		SpawnPoint_k40075_0003 = { spawnLocator = "SpawnPoint_k40075_0003", },
	},
}




this.importantGimmickList = TppGimmick.GetBaseImportantGimmickList()	

this.foreceBreakImportantGimmickListIndex = 4	

this.OnActivate = function()
	TppDataUtility.SetVisibleEffectFromGroupId( "k40075_ReturnWormhole", false )
end




this.OnRestoreFVars = function()
	Fox.Log("k40075.OnRestoreFVars")
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
	Fox.Log("k40075.AddOnTerminate")
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
end

local lastAddedStep




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameOpening",
	OnEnter = function()
		
		Gimmick.SetSsdPowerOff{
			gimmickId		= "GIM_P_Digger",
			name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
			dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",
			powerOff		= false
		}
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
	end,
	OnLeave = function()
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_MINING_MACHINE_MENU )
	end,
	options = {
		radio = "f3010_rtrg0800",
		objective = "mission_common_objective_bootDigger",
		marker = { name = "marker_diggerSwitch", areaName = "marker_missionArea", viewType = "world_only_icon", mapTextId = "hud_digger_gauge_caption" },
		disableEnemy = this.demoEnemyList,
		recipe = {
			
			"RCP_BLD_Kitchen_B",			
			
			"RCP_BLD_DirtyWaterTank_A",		
		},
		nextStepDelay = {
			{ type = "FadeOut", },
		},
	},
	clearConditionTable = {
		switch = {
			{	
				gimmickId	= "GIM_P_Digger",
				locatorName = "whm0_gim_n0000|srt_whm0_main0_def_v00",
				datasetName = "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",
				checkObjective = "mission_common_objective_bootDigger",
			},
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoDefenseStart",
	OnEnter = function()
		
		TppMission.SetInitialWaveName("wave_k40075")
		TppDemo.SpecifyIgnoreNpcDisable( this.demoEnemyList )
	end,
	options = {
		enableEnemy = this.demoEnemyList,
		setUpWaveSettings = true,
	},
	clearConditionTable = {
		demo = {
			demoName = "p20_000030",
			options = { useDemoBlock = true }
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameDefense",
	OnEnter = function()
		BaseMissionSequence.DisableBaseCheckPoint()	
		
		TppEnemy.SetEnemyLevelByEnemyType{
			groupLocatorNameList = { "zmb_k40075_demo" },
			SsdZombie = { level = 6, randomRange = 0 },
		}
		
		Gimmick.SetSsdPowerOff{
			gimmickId		= "GIM_P_Digger",
			name			= "whm0_gim_n0000|srt_whm0_main0_def_v00",
			dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset.fox2",
			powerOff		= true
		}
		
		this.AssignDemoZombeToDefenseGame()
		
		this.DisableMissionArea( "marker_missionArea" )
		
		TppDataUtility.SetVisibleEffectFromGroupId( "k40075_ReturnWormhole", true )
	end,
	OnLeave = function()
		BaseMissionSequence.EnableBaseCheckPoint()	
		TppDataUtility.SetVisibleEffectFromGroupId( "k40075_ReturnWormhole", false )
	end,
	options = {
		radio = "f3010_rtrg0802",
		objective = "mission_common_objective_defendDigger_single",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 4.0, },
			{ type = "FadeOut", fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHSPEED, },
		},
	},
	clearConditionTable = {
		wave = {
			checkObjective = "mission_common_objective_defendDigger_single",
			waveName = "wave_k40075",
			defenseGameArea = {
				areaTrapName = "trap_baseDefenseGameArea",
				alertTrapName = "trap_baseDefenseGameAlertArea",
			},
		},
	},
}

function this.AssignDemoZombeToDefenseGame()
	Fox.Log("k40075.GameDefense : AssignDemoZombeToDefenseGame")
	
	local command = { id="SetWaveByName", spawnLocator="SpawnPoint_k40075_0002_0", }
	local speedCommand = { id="SetWaveWalkSpeed", speed = "walk", }
	for index, locatorName in ipairs{ "zmb_k40075_0000", "zmb_k40075_0001", "zmb_k40075_0002" } do
		local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", locatorName )
		command.locatorName = locatorName
		speedCommand.locatorName = locatorName
		GameObject.SendCommand( gameObjectId, command )
		GameObject.SendCommand( gameObjectId, speedCommand )
	end
end




BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			demo = {
				demoName = "p20_000040",
				options = { useDemoBlock = true }
			},
			fadeSpeed = 0.1,
		},
	},
}




this.blackRadioOnEnd = "K40075_0020"


return this
