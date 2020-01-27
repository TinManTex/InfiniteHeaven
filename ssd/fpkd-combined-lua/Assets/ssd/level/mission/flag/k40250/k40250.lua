	



local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId


local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
local DASH		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH


local REWARD_POSITION = Vector3( 1319.509, 128.942, -1547.883 )

local this = BaseFlagMission.CreateInstance( "k40250" )

local k40250_diggerIdentifierParam = {
	"GIM_P_Digger",
	"whm0_gim_n0000|srt_whm0_main0_def_v00",
	"/Assets/ssd/level/location/mafr/block_mission/large/diamond/mafr_diamond_digger_c01.fox2",
}

local defenseTargetGimmickIdentifier = {
	gimmickId		= k40250_diggerIdentifierParam[1],
	name			= k40250_diggerIdentifierParam[2],
	dataSetName		= k40250_diggerIdentifierParam[3],
}

local importantGimmickTable = {
	gimmickId		= k40250_diggerIdentifierParam[1],
	locatorName		= k40250_diggerIdentifierParam[2],
	datasetName		= k40250_diggerIdentifierParam[3],
}



this.missionAreas = {
	{
		name = "marker_missionArea",	trapName = "trap_missionArea",		visibleArea = 9, guideLinesId = "guidelines_mission_common_coop",
	},
}


this.enterMissionAreaRadio = "f3010_rtrg2002"


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isFirstBuilding",	 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)


this.disableEnemy = {
	{ enemyName = "zmb_diamond_04_0000" },
	{ enemyName = "zmb_diamond_04_0001" },
	{ enemyName = "zmb_diamond_04_0002" },
	{ enemyName = "zmb_diamond_04_0003" },
	{ enemyName = "zmb_diamond_04_0006" },
	{ enemyName = "zmb_diamond_04_0007" },
	{ enemyName = "zmb_diamond_04_0008" },

	{ enemyName = "zmb_diamond_05_0000" },
	{ enemyName = "zmb_diamond_05_0001" },
	{ enemyName = "zmb_diamond_05_0002" },
	{ enemyName = "zmb_diamond_05_0003" },
	{ enemyName = "zmb_diamond_05_0004" },
	{ enemyName = "zmb_diamond_05_0005" },
	{ enemyName = "zmb_diamond_05_0006" },

	{ enemyName = "zmb_stelthArea_01_0000" },
	{ enemyName = "zmb_stelthArea_01_0001" },
	{ enemyName = "zmb_stelthArea_01_0002" },
	{ enemyName = "zmb_stelthArea_01_0003" },
	{ enemyName = "zmb_stelthArea_01_0004" },
}





this.waveSettings = {
	waveList = {
		"wave_k40250_00",
		"wave_k40250_01",
		"wave_k40250_02",
	},
	wavePropertyTable = {
		
		wave_k40250_00 = {
			defenseTimeSec	= (60 * 10),
			alertTimeSec	= 30,
			limitTimeSec	= (60 * 3.5),
			intervalTimeSec	= 60,
			endEffectName	= "explosion",
			defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,
			useSpecifiedAreaEnemy = {
				{ pos = { 1322.315, 121.623, -1545.419 }, radius = 60 },
			},
			defenseTargetGimmickProperty = {
				identificationTable = {
					digger = defenseTargetGimmickIdentifier,
				},
				alertParameters = { 
					needAlert = true, 
					alertRadius = 15,
				},
			},

			enemyLaneRouteList = {
				"map_rt_k40250_wave01_0000",
				"map_rt_k40250_wave01_0001",
				"map_rt_k40250_wave01_0002",
				"map_rt_k40250_wave01_0003",
				"map_rt_k40250_wave01_0004",
			},

			waveFinishShockWaveRadius = 6,
		},
		
		wave_k40250_01 = {
			limitTimeSec	= (60 * 3.5),
			intervalTimeSec		= 80,
			endEffectName	= "explosion",

			enemyLaneRouteList = {
				"map_rt_k40250_wave02_0000",
				"map_rt_k40250_wave02_0001",
				"map_rt_k40250_wave02_0002",
				"map_rt_k40250_wave02_0003",
				"map_rt_k40250_wave02_0004",
				"map_rt_k40250_wave02_0005",
				"map_rt_k40250_wave02_0006",
				"map_rt_k40250_wave02_0007",
			},

		},
		
		wave_k40250_02 = {
			limitTimeSec	= (60 * 3.5),
			isTerminal		= true,
			endEffectName	= "explosion",

			enemyLaneRouteList = {
				"map_rt_k40250_wave03_0000",
				"map_rt_k40250_wave03_0001",
				"map_rt_k40250_wave03_0002",
				"map_rt_k40250_wave03_0003",
				"map_rt_k40250_wave03_0004",
				"map_rt_k40250_wave03_0005",
				"map_rt_k40250_wave03_0006",
			},

		},
	},

	waveTable = {
		wave_k40250_00 = {
		
			{  0, "SpawnPoint_Wave1_0001", ZOMBIE, 4, -3 },
			{ 15, "SpawnPoint_Wave1_0000", ZOMBIE, 4, -3 },
			{ 40, "SpawnPoint_Wave1_0004", ZOMBIE, 5, -3 },
			{ 13, "SpawnPoint_Wave1_0003", ZOMBIE, 6, -3 },
			{  6, "SpawnPoint_Wave1_0004", ZOMBIE, 4, -3 },

			{ 40, "SpawnPoint_Wave1_0001", ZOMBIE, 3, -4 },
			{  5, "SpawnPoint_Wave1_0000", ZOMBIE, 2, -4 },
			{  5, "SpawnPoint_Wave1_0001", ZOMBIE, 2, -4 },
			{  0, "SpawnPoint_Wave1_0000", ZOMBIE, 2, -4 },
			{ 10, "SpawnPoint_Wave1_0002", ZOMBIE, 2, -4 },
			{  5, "SpawnPoint_Wave1_0000", ZOMBIE, 1, -4 },
			{ 10, "SpawnPoint_Wave1_0004", ZOMBIE, 3, -4 },
			{  0, "SpawnPoint_Wave1_0003", ZOMBIE, 3, -5 },
			{  5, "SpawnPoint_Wave1_0003", ZOMBIE, 3, -5 },
			{ 10, "SpawnPoint_Wave1_0002", ZOMBIE, 4, -5 },
			{ 10, "SpawnPoint_Wave1_0000", ZOMBIE, 2, -5 },
			{  6, "SpawnPoint_Wave1_0004", ZOMBIE, 4, -5 },
		},

		wave_k40250_01 = {
			{  0, "SpawnPoint_Wave2_0002", ZOMBIE, 4, -3, },
			{ 15, "SpawnPoint_Wave2_0003", ZOMBIE, 5, -3, },
			{ 10, "SpawnPoint_Wave2_0002", ZOMBIE, 3, -3, },
			{ 10, "SpawnPoint_Wave2_0001", ZOMBIE, 3, -3, },
			{  0, "SpawnPoint_Wave2_0000", ZOMBIE, 4, -3, },
			{  0, "SpawnPoint_Wave2_0003", ZOMBIE, 3, -3, },
			{  5, "SpawnPoint_Wave2_0001", ZOMBIE, 3, -3, },

			{ 60, "SpawnPoint_Wave2_0006", ZOMBIE, 4, -3, },
			{  0, "SpawnPoint_Wave2_0007", ZOMBIE, 4, -4, },
			{  5, "SpawnPoint_Wave2_0006", ZOMBIE, 3, -3, },
			{  5, "SpawnPoint_Wave2_0004", ZOMBIE, 3, -4, },
			{  5, "SpawnPoint_Wave2_0005", ZOMBIE, 4, -3, },
			{  0, "SpawnPoint_Wave2_0004", ZOMBIE, 3, -4, },
			{ 10, "SpawnPoint_Wave2_0003", ZOMBIE, 4, -3, },
			{  0, "SpawnPoint_Wave2_0004", ZOMBIE, 3, -4, },
			{  5, "SpawnPoint_Wave2_0000", ZOMBIE, 2, -3, },
			{  0, "SpawnPoint_Wave2_0003", ZOMBIE, 4, -4, },
			{  0, "SpawnPoint_Wave2_0001", ZOMBIE, 3, -3, },
			{ 10, "SpawnPoint_Wave2_0000", ZOMBIE, 3, -4, },
			{  5, "SpawnPoint_Wave2_0004", ZOMBIE, 3, -3, },
			{  0, "SpawnPoint_Wave2_0002", ZOMBIE, 3, -5, },
			{  0, "SpawnPoint_Wave2_0003", ZOMBIE, 3, -5, },

			{ 15, "SpawnPoint_Wave2_0006", ZOMBIE, 2, -5, },
			{  5, "SpawnPoint_Wave2_0004", ZOMBIE, 4, -3, },
			{  5, "SpawnPoint_Wave2_0002", ZOMBIE, 2, -5, },
			{  5, "SpawnPoint_Wave2_0001", ZOMBIE, 3, -3, },
			{  5, "SpawnPoint_Wave2_0004", ZOMBIE, 2, -5, },
			{  5, "SpawnPoint_Wave2_0005", ZOMBIE, 3, -5, },
			{  5, "SpawnPoint_Wave2_0007", ZOMBIE, 3, -4, },
		},

		wave_k40250_02 = {
			{  0, "SpawnPoint_Wave3_0006", ZOMBIE, 4, -4 },
			{ 10, "SpawnPoint_Wave3_0002", ZOMBIE, 3, -4 },
			{ 15, "SpawnPoint_Wave3_0006", BOM,	   1, -3, "walk", },
			{  5, "SpawnPoint_Wave3_0002", ZOMBIE, 3, -4 },
			{  5, "SpawnPoint_Wave3_0003", ZOMBIE, 5, -3 },
			{ 10, "SpawnPoint_Wave3_0001", ZOMBIE, 3, -4 },

			{ 50, "SpawnPoint_Wave3_0004", ZOMBIE, 4, -4 },
			{  0, "SpawnPoint_Wave3_0005", ZOMBIE, 3, -4 },
			{ 10, "SpawnPoint_Wave3_0000", ZOMBIE, 4, -4 },
			{ 10, "SpawnPoint_Wave3_DASH_0000", DASH, 1, -8, "walk", 1 },
			{  0, "SpawnPoint_Wave3_0001", ZOMBIE, 3, -4 },
			{  5, "SpawnPoint_Wave3_0004", ZOMBIE, 4, -4 },
			{  0, "SpawnPoint_Wave3_0005", ZOMBIE, 3, -4 },

			{ 20, "SpawnPoint_Wave3_0000", ZOMBIE, 4, -4 },
			{  5, "SpawnPoint_Wave3_0003", ZOMBIE, 3, -4 },
			{  5, "SpawnPoint_Wave3_DASH_0001", DASH, 1, -8, "walk", 1 },
			{  5, "SpawnPoint_Wave3_0005", ZOMBIE, 2, -4 },
			{  5, "SpawnPoint_Wave3_0002", ZOMBIE, 3, -4 },

			{ 10, "SpawnPoint_Wave3_0004", ZOMBIE, 4, -4 },
			{  0, "SpawnPoint_Wave3_0003", ZOMBIE, 3, -4 },
			{  0, "SpawnPoint_Wave3_0005", ZOMBIE, 2, -4 },
			{  8, "SpawnPoint_Wave3_0002", ZOMBIE, 2, -4 },
			{  5, "SpawnPoint_Wave3_0004", ZOMBIE, 2, -3 },
			{  5, "SpawnPoint_Wave3_0000", ZOMBIE, 2, -4 },
			{ 10, "SpawnPoint_Wave3_0005", ZOMBIE, 3, -4 },
			{  5, "SpawnPoint_Wave3_0004", ZOMBIE, 2, -5 },
			{  1, "SpawnPoint_Wave3_0003", ZOMBIE, 2, -4 },
			{  1, "SpawnPoint_Wave3_0002", ZOMBIE, 2, -5 },
			{  1, "SpawnPoint_Wave3_0003", ZOMBIE, 3, -4 },
			{  1, "SpawnPoint_Wave3_0005", ZOMBIE, 2, -5 },
			{  1, "SpawnPoint_Wave3_0002", ZOMBIE, 2, -4 },
			{  1, "SpawnPoint_Wave3_0004", ZOMBIE, 2, -5 },
		},
	},

	spawnPointDefine = {
		
		SpawnPoint_Wave1_0000 = { spawnLocator = "SpawnPoint_k40250_A_0000", route = { "rt_k40250_wave01_0000" }, radius = 2.0,},
		SpawnPoint_Wave1_0001 = { spawnLocator = "SpawnPoint_k40250_A_0001", route = { "rt_k40250_wave01_0001" }, radius = 2.0,},
		SpawnPoint_Wave1_0002 = { spawnLocator = "SpawnPoint_k40250_A_0002", route = { "rt_k40250_wave01_0002" }, radius = 2.0,},
		SpawnPoint_Wave1_0003 = { spawnLocator = "SpawnPoint_k40250_A_0002", route = { "rt_k40250_wave01_0003" }, radius = 2.0,},
		SpawnPoint_Wave1_0004 = { spawnLocator = "SpawnPoint_k40250_A_0003", route = { "rt_k40250_wave01_0004" }, radius = 2.0,},
		SpawnPoint_Wave1_0005 = { spawnLocator = "SpawnPoint_k40250_A_0000", route = { "rt_k40250_wave01_0005" }, radius = 2.0,},

		SpawnPoint_Wave1_DASH_0000 = { spawnLocator = "SpawnPoint_k40250_A_0000", route = { "rt_k40250_wave01_dash_0000" }, radius = 2.0,},
		SpawnPoint_Wave1_DASH_0001 = { spawnLocator = "SpawnPoint_k40250_A_0001", route = { "rt_k40250_wave01_dash_0001" }, radius = 2.0,},
		SpawnPoint_Wave1_DASH_0002 = { spawnLocator = "SpawnPoint_k40250_A_0002", route = { "rt_k40250_wave01_dash_0002" }, radius = 2.0,},
		SpawnPoint_Wave1_DASH_0003 = { spawnLocator = "SpawnPoint_k40250_A_0002", route = { "rt_k40250_wave01_dash_0003" }, radius = 2.0,},

		
		SpawnPoint_Wave2_0000 = { spawnLocator = "SpawnPoint_k40250_B_0000", route = { "rt_k40250_wave02_0000" }, radius = 2.0,},
		SpawnPoint_Wave2_0001 = { spawnLocator = "SpawnPoint_k40250_B_0001", route = { "rt_k40250_wave02_0001" }, radius = 2.0,},
		SpawnPoint_Wave2_0002 = { spawnLocator = "SpawnPoint_k40250_B_0002", route = { "rt_k40250_wave02_0002" }, radius = 2.0,},
		SpawnPoint_Wave2_0003 = { spawnLocator = "SpawnPoint_k40250_B_0003", route = { "rt_k40250_wave02_0003" }, radius = 2.0,},
		SpawnPoint_Wave2_0004 = { spawnLocator = "SpawnPoint_k40250_B_0004", route = { "rt_k40250_wave02_0004" }, radius = 2.0,},
		SpawnPoint_Wave2_0005 = { spawnLocator = "SpawnPoint_k40250_B_0005", route = { "rt_k40250_wave02_0005" }, radius = 2.0,},
		SpawnPoint_Wave2_0006 = { spawnLocator = "SpawnPoint_k40250_B_0006", route = { "rt_k40250_wave02_0006" }, radius = 2.0,},
		SpawnPoint_Wave2_0007 = { spawnLocator = "SpawnPoint_k40250_B_0007", route = { "rt_k40250_wave02_0007" }, radius = 2.0,},
		
		
		SpawnPoint_Wave3_0000 = { spawnLocator = "SpawnPoint_k40250_C_0000", route = { "rt_k40250_wave03_0000" }, radius = 2.0,},
		SpawnPoint_Wave3_0001 = { spawnLocator = "SpawnPoint_k40250_C_0001", route = { "rt_k40250_wave03_0001" }, radius = 2.0,},
		SpawnPoint_Wave3_0002 = { spawnLocator = "SpawnPoint_k40250_C_0002", route = { "rt_k40250_wave03_0002" }, radius = 2.0,},
		SpawnPoint_Wave3_0003 = { spawnLocator = "SpawnPoint_k40250_C_0003", route = { "rt_k40250_wave03_0003" }, radius = 2.0,},
		SpawnPoint_Wave3_0004 = { spawnLocator = "SpawnPoint_k40250_C_0004", route = { "rt_k40250_wave03_0004" }, radius = 2.0,},
		SpawnPoint_Wave3_0005 = { spawnLocator = "SpawnPoint_k40250_C_0005", route = { "rt_k40250_wave03_0005" }, radius = 2.0,},
		SpawnPoint_Wave3_0006 = { spawnLocator = "SpawnPoint_k40250_C_0006", route = { "rt_k40250_wave03_0006" }, radius = 2.0,},

		SpawnPoint_Wave3_DASH_0000 = { spawnLocator = "SpawnPoint_k40250_C_0000", route = { "rt_k40250_wave03_dash_0000" }, radius = 2.0,},
		SpawnPoint_Wave3_DASH_0001 = { spawnLocator = "SpawnPoint_k40250_C_0004", route = { "rt_k40250_wave03_dash_0001" }, radius = 2.0,},
	},
}




this.importantGimmickList =  {
	importantGimmickTable,	
}


this.showDiggerPlanedPlace = 1	





this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()

	
	this.waveSettings.wavePropertyTable.wave_k40250_00.defensePosition = TppGimmick.GetDiggerDefensePosition( defenseTargetGimmickIdentifier )

	
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
	options = {
		marker = {
			{ name = "marker_target", areaName = "marker_missionArea" },
		},
		radio = { name = "f3010_rtrg2000", options = { isOnce = true } },	
		objective = "mission_common_objective_putDigger",
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
			
			local center = Vector3( 1318.924, 119.942, -1547.529 )
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
			gimmickId		= k40250_diggerIdentifierParam[1],
			name			= k40250_diggerIdentifierParam[2],
			dataSetName		= k40250_diggerIdentifierParam[3],
			powerOff		= true,
		}
	end,
	clearConditionTable = {
		wave = {
			waveName = "wave_k40250_00",
			maxWaveCount = 3,		
			defenseGameArea = {
				areaTrapName = "trap_k40250_DefenseGameArea",
				alertTrapName = "trap_k40250_DefenseGameAlertArea",
			},
		},
	},
	options = {
		radio = { name = "f3010_rtrg0904", options = { delayTime = 16.0 }},
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
				Fox.Log( "k40250.Messages():GameObject:FinishWave: " .. tostring( waveName ) )
				if waveName == "wave_k40250_00" then
					Fox.Log( "k40250.IntervalRadio: wave_k40250_00" )
					TppRadio.Play("f3010_rtrg0914", { delayTime = 3.0 } )
				end
				if waveName == "wave_k40250_01" then
					Fox.Log( "k40250.IntervalRadio: wave_k40250_01" )
					TppRadio.Play("f3010_rtrg0916", { delayTime = 3.0 } )
				end
			end
		},
		{	
			msg = "FinishWaveInterval",
			func = function( waveName, waveIndex )
				Fox.Log( "k40250.Messages():Timer:FinishWaveInterval" )
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
		objective = "mission_common_objective_returnToFOB",
		vanishDigger = { waveName = "wave_k40250_00" },
	},
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToFOB", },
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




this.blackRadioOnEnd = "K40250_0020"




this.releaseAnnounce = { "OpenNewCoopMission" }

return this
