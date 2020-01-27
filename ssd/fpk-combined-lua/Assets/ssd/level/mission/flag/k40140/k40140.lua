



local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local lastAddedStep


local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM

local REWARD_POSITION = Vector3( 501.113, 322.155 + 12, 1043.583 )

local this = BaseFlagMission.CreateInstance( "k40140" )


local k40140_diggerIdentifierParam = {
	"GIM_P_Digger",
	"whm0_gim_n0000|srt_whm0_main0_def_v00",
	"/Assets/ssd/level/location/afgh/block_mission/large/village/afgh_village_digger_c01.fox2",
}

local defenseTargetGimmickIdentifier = {
	gimmickId		= k40140_diggerIdentifierParam[1],
	name			= k40140_diggerIdentifierParam[2],
	dataSetName		= k40140_diggerIdentifierParam[3],
}

local importantGimmickTable = {
	gimmickId		= k40140_diggerIdentifierParam[1],
	locatorName		= k40140_diggerIdentifierParam[2],
	datasetName		= k40140_diggerIdentifierParam[3],
}


this.missionAreas = {
	{
		name = "marker_missionArea",
		trapName = "trap_missionArea",
		visibleArea = 9,
		guideLinesId = "guidelines_mission_common_coop",
	},
}


this.enterMissionAreaRadio = "f3010_rtrg0902"


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isFirstBuilding",	 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	this.waveSettings.wavePropertyTable.wave_k40140_00.defensePosition = TppGimmick.GetDiggerDefensePosition( defenseTargetGimmickIdentifier )
	
	fvars.isFirstBuilding = false
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameEscape" ) then
		this.DisableMissionArea( "marker_missionArea" )
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameDefense" ) then
		this.DisplayGuideLine( { "guidelines_mission_common_coop"} )
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameBoot" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
end




this.waveSettings = {
	waveList = {
		"wave_k40140_00",
		"wave_k40140_01",
		"wave_k40140_02",
	},
	wavePropertyTable = {
		
		wave_k40140_00 = {
			defenseTimeSec	= (60 * 10),
			alertTimeSec	= 30,
			limitTimeSec	= (60 * 3),
			intervalTimeSec	= 30,
			endEffectName	= "explosion",
			defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,
			defenseTargetGimmickProperty = {
				identificationTable = {
					digger = defenseTargetGimmickIdentifier,
				},
				alertParameters = {
					needAlert = true,
					alertRadius = 20,
				},
			},

			enemyLaneRouteList = {
				"map_route_wave01_0000",
				"map_route_wave01_0001",
				"map_route_wave01_0002",
				"map_route_wave01_0003",
				"map_route_wave01_0004",
			},
			waveFinishShockWaveRadius = 5,
		},
		
		wave_k40140_01 = {
			limitTimeSec	= (60 * 3),
			intervalTimeSec		= 30,
			endEffectName	= "explosion",

			enemyLaneRouteList = {
				"map_route_wave02_0000",
				"map_route_wave02_0001",
				"map_route_wave02_0002",
				"map_route_wave02_0003",
			},
		},

		
		wave_k40140_02 = {
			limitTimeSec	= (60 * 4),
			isTerminal		= true,
			endEffectName	= "explosion",

			enemyLaneRouteList = {
				"map_route_wave03_0000",
				"map_route_wave03_0001",
				"map_route_wave03_0002",
				"map_route_wave03_0003",
				"map_route_wave03_0004",
				"map_route_wave03_0005",
			},
		},
	},

	waveTable = {
		wave_k40140_00 = {
		
			{  3, "SpawnPoint_Wave1_0001", ZOMBIE, 3, -3 },
			{  8, "SpawnPoint_Wave1_0002", ZOMBIE, 4, -3 },
			{ 35, "SpawnPoint_Wave1_0000", ZOMBIE, 4, -3 },
			{ 10, "SpawnPoint_Wave1_0004", ZOMBIE, 3, -3 },
			{ 30, "SpawnPoint_Wave1_0003", ZOMBIE, 5, -3 },
			{ 25, "SpawnPoint_Wave1_0001", ZOMBIE, 5, -3 },
			{ 10, "SpawnPoint_Wave1_0002", ZOMBIE, 8, -3 },
		},
		wave_k40140_01 = {
			{  0, "SpawnPoint_Wave2_0000", ZOMBIE, 3, -3 },
			{  5, "SpawnPoint_Wave2_0001", ZOMBIE, 4, -3 },
			{ 15, "SpawnPoint_Wave2_0000", ZOMBIE, 4, -3 },
			{  5, "SpawnPoint_Wave2_0003", BOM, 1, -3 },
			{ 10, "SpawnPoint_Wave2_0001", ZOMBIE, 6, -3 },
			{ 35, "SpawnPoint_Wave2_0002", ZOMBIE, 6, -3 },
			{ 25, "SpawnPoint_Wave2_0001", ZOMBIE, 5, -3 },
			{ 20, "SpawnPoint_Wave2_0003", ZOMBIE, 6, -3 },
			{ 30, "SpawnPoint_Wave2_0000", ZOMBIE, 4, -3 },
			{ 10, "SpawnPoint_Wave2_0002", ZOMBIE, 6, -3 },
		},
		wave_k40140_02 = {
			{  5, "SpawnPoint_Wave3_0002", ZOMBIE, 4, -3 },
			{  8, "SpawnPoint_Wave3_0003", ZOMBIE, 5, -3 },
			{ 20, "SpawnPoint_Wave3_0000", ZOMBIE, 4, -3 },
			{ 15, "SpawnPoint_Wave3_0005", ZOMBIE, 4, -3 },
			{ 20, "SpawnPoint_Wave3_0002", ZOMBIE, 6, -3 },
			{ 15, "SpawnPoint_Wave3_0004", ZOMBIE, 4, -3 },
			{ 60, "SpawnPoint_Wave3_0003", ZOMBIE, 5, -3 },
			{ 30, "SpawnPoint_Wave3_0001", ZOMBIE, 3, -3 },
			{ 25, "SpawnPoint_Wave3_0003", ZOMBIE, 8, -3 },
			{ 10, "SpawnPoint_Wave3_0002", ZOMBIE, 4, -3 },
			{ 20, "SpawnPoint_Wave3_0000", ZOMBIE, 3, -3 },
			{ 10, "SpawnPoint_Wave3_0001", ZOMBIE, 3, -3 },
			{ 1, "SpawnPoint_Wave3_0004", ZOMBIE, 3, -3 },
			{ 0, "SpawnPoint_Wave3_0005", ZOMBIE, 3, -3 },
		},
	},

	spawnPointDefine = {
		
		SpawnPoint_Wave1_0000 = { spawnLocator = "SpawnPoint_k40140_A_0000", route = { "rt_k40140_wave01_0000" }, radius = 2.0,},
		SpawnPoint_Wave1_0001 = { spawnLocator = "SpawnPoint_k40140_A_0001", route = { "rt_k40140_wave01_0001" }, radius = 2.0,},
		SpawnPoint_Wave1_0002 = { spawnLocator = "SpawnPoint_k40140_A_0002", route = { "rt_k40140_wave01_0002" }, radius = 2.0,},
		SpawnPoint_Wave1_0003 = { spawnLocator = "SpawnPoint_k40140_A_0003", route = { "rt_k40140_wave01_0003" }, radius = 2.0,},
		SpawnPoint_Wave1_0004 = { spawnLocator = "SpawnPoint_k40140_A_0001", route = { "rt_k40140_wave01_0004" }, radius = 2.0,},

		
		SpawnPoint_Wave2_0000 = { spawnLocator = "SpawnPoint_k40140_B_0000", route = { "rt_k40140_wave02_0000" }, radius = 2.0,},
		SpawnPoint_Wave2_0001 = { spawnLocator = "SpawnPoint_k40140_B_0001", route = { "rt_k40140_wave02_0001" }, radius = 2.0,},
		SpawnPoint_Wave2_0002 = { spawnLocator = "SpawnPoint_k40140_B_0002", route = { "rt_k40140_wave02_0002" }, radius = 2.0,},
		SpawnPoint_Wave2_0003 = { spawnLocator = "SpawnPoint_k40140_B_0003", route = { "rt_k40140_wave02_0003" }, radius = 2.0,},

		
		SpawnPoint_Wave3_0000 = { spawnLocator = "SpawnPoint_k40140_C_0000", route = { "rt_k40140_wave03_0000" }, radius = 2.0,},
		SpawnPoint_Wave3_0001 = { spawnLocator = "SpawnPoint_k40140_C_0001", route = { "rt_k40140_wave03_0001" }, radius = 2.0,},
		SpawnPoint_Wave3_0002 = { spawnLocator = "SpawnPoint_k40140_C_0002", route = { "rt_k40140_wave03_0002" }, radius = 2.0,},
		SpawnPoint_Wave3_0003 = { spawnLocator = "SpawnPoint_k40140_C_0003", route = { "rt_k40140_wave03_0003" }, radius = 2.0,},
		SpawnPoint_Wave3_0004 = { spawnLocator = "SpawnPoint_k40140_C_0004", route = { "rt_k40140_wave03_0004" }, radius = 2.0,},
		SpawnPoint_Wave3_0005 = { spawnLocator = "SpawnPoint_k40140_C_0000", route = { "rt_k40140_wave03_0005" }, radius = 2.0,},
	},
}




this.importantGimmickList =  {
	importantGimmickTable,	
}


this.showDiggerPlanedPlace = 1	




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMain",
	OnEnter = function()
		if ( fvars.isFirstBuilding == true ) then	
			
			
			this.DisplayMissionArea( "marker_missionArea" )
		end
		
		this.DisplayGuideLine( { "guidelines_mission_common_coop"} )
	end,
	OnLeave = function()
		if ( fvars.isFirstBuilding == true ) then	
			
			
		end
	end,
	options = {
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea" },
		},
		radio = { name = "f3010_rtrg1300", options = { isOnce = true } },	
		objective = "mission_common_objective_putDigger",
		recipe = {
			"RCP_BLD_HerbFarm_A",	
			"RCP_BLD_HerbFarm_B",	
			"RCP_BLD_Kitchen_D",	
		},
	},
	clearConditionTable = {
		putDigger = defenseTargetGimmickIdentifier,
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameBoot",
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		TppMarker.Enable( "marker_target", 0, "moving", "all", 0, true, true )
		if ( fvars.isFirstBuilding == false ) then
			
			local center = Vector3( 503.132, 322.323, 1046.586 )
			SsdBlankMap.SetReachedArea{ position=center, radius=100.0 }
			
			fvars.isFirstBuilding = true
		end
	end,
	OnLeave = function()
		
		TppMarker.Disable( "marker_target" )
	end,
	options = {
		radio = "f3010_rtrg0906",
		objective = "mission_common_objective_putDigger",
		checkObjectiveIfCleared = "mission_common_objective_putDigger",
		stepNameIfOutOfDefenseArea = "GameMain",
	},
	clearConditionTable = {
		switch = {
			importantGimmickTable,
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameDefense",
	OnEnter = function()
		
		Gimmick.SetSsdPowerOff{
			gimmickId		= k40140_diggerIdentifierParam[1],
			name			= k40140_diggerIdentifierParam[2],
			dataSetName		= k40140_diggerIdentifierParam[3],
			powerOff		= true,
		}
	end,
	clearConditionTable = {
		wave = {
			waveName = "wave_k40140_00",
			maxWaveCount = 3,		
			defenseGameArea = {
				areaTrapName = "trap_k40140_DefenseGameArea",
				alertTrapName = "trap_k40140_DefenseGameAlertArea",
			},
		},
	},
	options = {
		radio = { name = "f3010_rtrg1304", options = { delayTime = 17.0 }},
		objective = "mission_common_objective_defendDigger_coop",
		checkObjectiveIfCleared = "mission_common_objective_defendDigger_coop",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 6.0, },	
		},
	},
}


this.flagStep.GameDefense.messageTable = {
	GameObject = {
		{	
			msg = "FinishWave",
			func = function( waveName, waveIndex )
				local waveName = TppMission.GetCurrentWaveName()
				Fox.Log( "k40140.Messages():GameObject:FinishWave: " .. tostring( waveName ) )
				if waveName == "wave_k40140_00" then
					Fox.Log( "k40140.IntervalRadio: wave_k40140_00" )
					TppRadio.Play("f3010_rtrg0914", { delayTime = 3.0 } )
				end
				if waveName == "wave_k40140_01" then
					Fox.Log( "k40140.IntervalRadio: wave_k40140_01" )
					TppRadio.Play("f3010_rtrg0916", { delayTime = 3.0 } )
				end
			end
		},
		{	
			msg = "FinishWaveInterval",
			func = function( waveName, waveIndex )
				Fox.Log( "k40140.Messages():Timer:FinishWaveInterval" )
				TppRadio.Play("f3000_rtrg2116", { delayTime = 2.0 } )
			end
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameEscape",
	OnEnter = function()
		
		this.DisableGuideLine()
	end,
	options = {
		radio = "f3000_rtrg0204",
		objective = "mission_common_objective_returnToBase",
		vanishDigger = { waveName = "wave_k40140_00" },
	},
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToBase", },
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			true,
		}
	},
}




this.blackRadioOnEnd = "K40140_0020"




this.releaseAnnounce = { "OpenNewCoopMission" }

return this
