	



local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local lastAddedStep



local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM


local REWARD_POSITION = Vector3( 423.721, 281.7263, 2214.715 )

local this = BaseFlagMission.CreateInstance( "k40077" )	


local k40077_diggerIdentifierParam = {
	"GIM_P_Digger",
	"whm0_gim_n0000|srt_whm0_main0_def_v00",
	"/Assets/ssd/level/location/afgh/block_mission/large/field/afgh_field_digger_c01.fox2",
}

local defenseTargetGimmickIdentifier = {
	gimmickId		= k40077_diggerIdentifierParam[1],
	name			= k40077_diggerIdentifierParam[2],
	dataSetName		= k40077_diggerIdentifierParam[3],
}

local importantGimmickTable = {
	gimmickId		= k40077_diggerIdentifierParam[1],
	locatorName		= k40077_diggerIdentifierParam[2],
	datasetName		= k40077_diggerIdentifierParam[3],
}




local tipsMenuList = {
	
	TIPS_WAVE = {
		tipsTypes		= {
			{ HelpTipsType.TIPS_77_A, HelpTipsType.TIPS_77_B, HelpTipsType.TIPS_77_C, },
			{ HelpTipsType.TIPS_78_A, HelpTipsType.TIPS_78_B, HelpTipsType.TIPS_78_C, },
		},
		tipsRadio		= "f3010_rtrg0908",
		endFunction		= function() this.EndTipsWave() end,
	},
}

this.missionAreas = {
	{ 
		name = "marker_missionArea", 
		trapName = "trap_missionArea", 
		visibleArea = 5, 
		guideLinesId = "guidelines_mission_common_coop",
	},
}


this.enterMissionAreaRadio = "f3010_rtrg0902"


BaseFlagMission.AddSaveVarsList(
	this,
	{
		{ name = "isTipsIris",		 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isFirstBuilding",	 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
		{ name = "isTipsWave",		 type = TppScriptVars.TYPE_BOOL,	value = false,	save = true, category = TppScriptVars.CATEGORY_MISSION },
	}
)




this.OnActivate = function()
	local stepIndex = SsdFlagMission.GetCurrentStepIndex()
	
	this.waveSettings.wavePropertyTable.wave_k40077_00.defensePosition = TppGimmick.GetDiggerDefensePosition( defenseTargetGimmickIdentifier )
	
	fvars.isFirstBuilding = false
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameMain" ) and stepIndex <= SsdFlagMission.GetStepIndex( "GameDefense" ) then
		
		this.DisplayGuideLine( { "guidelines_mission_common_coop"} )
	end
	
	if stepIndex >= SsdFlagMission.GetStepIndex( "GameBoot" ) then
		MissionObjectiveInfoSystem.SetForceOpen( true )
	end
end





this.importantGimmickList =  {
	importantGimmickTable,	
}


this.showDiggerPlanedPlace = 1	




this.messageTable = {
	Trap = {
		{	
			sender = "trap_k40077_DefenseGameAlertArea",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				Fox.Log( "k40077.Messages():Trap:Enter:trap_k40077_DefenseGameAlertArea" )
			end,
		},
		{	
			sender = "trap_k40077_DefenseGameArea",
			msg = "Enter",
			func = function( trapName, gameObjectId )
				Fox.Log( "k40077.Messages():Trap:Enter:trap_k40077_DefenseGameArea" )
			end,
		},
	},
}


this.EndTipsWave = function()
	
	Gimmick.SetSsdPowerOff{
		gimmickId		= k40077_diggerIdentifierParam[1],
		name			= k40077_diggerIdentifierParam[2],
		dataSetName		= k40077_diggerIdentifierParam[3],
		powerOff		= false,
	}
	TppRadio.Play("f3010_rtrg0909")
end


this.OpenFieldMap = function()
	local center = Vector3( 423.721, 279.757, 2214.715 )
	SsdBlankMap.SetReachedArea{ position=center, radius=100.0 }
	Fox.Log( "k40077.function():OpenFieldMap" )
end






this.waveSettings = {
	waveList = {
		"wave_k40077_00",
		"wave_k40077_01",
		"wave_k40077_02",
	},
	wavePropertyTable = {
	
		wave_k40077_00 = {
			defenseTimeSec	= (60 * 15),
			alertTimeSec	= 30,
			limitTimeSec	= (30 * 3),
			intervalTimeSec	= 30,
			endEffectName	= "explosion",
			defenseGameType = TppDefine.DEFENSE_GAME_TYPE.ENEMY_BASE,
			
			useSpecifiedAreaEnemy = {
				{ pos = { 424.898, 269.727, 2210.426 }, radius = 90 },
			},
			defenseTargetGimmickProperty = {
				identificationTable = {
					digger = defenseTargetGimmickIdentifier,
				},
				alertParameters = { needAlert = true, alertRadius = 12, }
			},
			enemyLaneRouteList = {
				"rt_SpawnPoint_k40077_0000_A",
				"rt_SpawnPoint_k40077_0003_A",
				"rt_SpawnPoint_k40077_0003_B",
				"rt_SpawnPoint_k40077_0003_C",
				"rt_SpawnPoint_k40077_0005_A",
				"rt_SpawnPoint_k40077_0001_A",
				"rt_SpawnPoint_k40077_0001_B",
			},
			waveFinishShockWaveRadius = 9.4,
		},
	
		wave_k40077_01 = {
			limitTimeSec	= (30 * 6),
			intervalTimeSec		= 30,
			endEffectName	= "explosion",
			enemyLaneRouteList = {
				"rt_SpawnPoint_k40077_0001_A",
				"rt_SpawnPoint_k40077_0002_A",
				"rt_SpawnPoint_k40077_0002_B",
				"rt_SpawnPoint_k40077_0003_A",
			},
		},
	
		wave_k40077_02 = {
			limitTimeSec	= (30 * 8),
			isTerminal		= true,
			endEffectName	= "explosion",
			enemyLaneRouteList = {
				"rt_SpawnPoint_k40077_0000_A",
				"rt_SpawnPoint_k40077_0001_A",
				"rt_SpawnPoint_k40077_0007_B",
				"rt_SpawnPoint_k40077_0007_A",
				"rt_SpawnPoint_k40077_0005_A",
			},
		},
	},
	waveTable = {
		wave_k40077_00 = {
			{ 1, "SpawnPoint_k40077_0000", ZOMBIE, 4, -2 },
			{ 14, "SpawnPoint_k40077_0005",ZOMBIE, 2, -2 },
			{ 0, "SpawnPoint_k40077_0000", ZOMBIE, 4, -3 },
			{ 5, "SpawnPoint_k40077_0001", ZOMBIE, 3, -5 },
			{ 30, "SpawnPoint_k40077_0003", ZOMBIE, 5, -5 },
			{ 0, "SpawnPoint_k40077_0000", ZOMBIE, 3, -5 },
			{ 5, "SpawnPoint_k40077_0005", ZOMBIE, 5, -5 },
		},
		wave_k40077_01 = {
			{ 0, "SpawnPoint_k40077_0002", ZOMBIE, 1, -1 },
			{ 5, "SpawnPoint_k40077_0002", ZOMBIE, 3, -1 },
			{ 5, "SpawnPoint_k40077_0002", ZOMBIE, 6, -1 },
			{ 10, "SpawnPoint_k40077_0001", ZOMBIE, 4, -1 },
			{ 60, "SpawnPoint_k40077_0003", ZOMBIE, 4, -1 },
			{ 10, "SpawnPoint_k40077_0002", ZOMBIE, 5, -4 },
			{ 5, "SpawnPoint_k40077_0001", ZOMBIE, 4, -4 },
		},
		wave_k40077_02 = {
			{ 0, "SpawnPoint_k40077_0007", ZOMBIE, 3, -1 },
			{ 10, "SpawnPoint_k40077_0007", ZOMBIE, 3, -1 },
			{ 10, "SpawnPoint_k40077_0000", ZOMBIE, 2, -1 },
			{ 0, "SpawnPoint_k40077_0001", ZOMBIE, 2, -1 },
			{ 10, "SpawnPoint_k40077_0001", ZOMBIE, 3, -1 },
			{ 0, "SpawnPoint_k40077_0000", ZOMBIE, 3, -1 },
			{ 80, "SpawnPoint_k40077_0005", BOM, 1, -1 },
			{ 0, "SpawnPoint_k40077_0005", ZOMBIE, 4, -1, },
			{ 30, "SpawnPoint_k40077_0001", ZOMBIE, 6, -1, "walk" },
			{ 0, "SpawnPoint_k40077_0007", ZOMBIE, 3, -1, "walk" },
			{ 5, "SpawnPoint_k40077_0000", ZOMBIE, 1, -1 },
			{ 10, "SpawnPoint_k40077_0000", ZOMBIE, 2, -1 },
			{ 5, "SpawnPoint_k40077_0007", ZOMBIE, 3, -1, },
			{ 0, "SpawnPoint_k40077_0000", ZOMBIE, 2, -1 },
			{ 20, "SpawnPoint_k40077_0007", ZOMBIE, 3, -1 },
			{ 0, "SpawnPoint_k40077_0001", ZOMBIE, 3, -1 },
		},
	},
	
	spawnPointDefine = {
		SpawnPoint_k40077_0000 = { spawnLocator = "SpawnPoint_k40077_0000", route = { "rt_k40077_SP_0000_0000", "rt_k40077_SP_0000_0001"}, },
		SpawnPoint_k40077_0001 = { spawnLocator = "SpawnPoint_k40077_0001", route = { "rt_k40077_SP_0001_0000", "rt_k40077_SP_0001_0001"}, },
		SpawnPoint_k40077_0002 = { spawnLocator = "SpawnPoint_k40077_0002", route = { "rt_k40077_SP_0002_0000","rt_k40077_SP_0002_0001", "rt_k40077_SP_0002_0002",}, },
		SpawnPoint_k40077_0003 = { spawnLocator = "SpawnPoint_k40077_0003", },
		SpawnPoint_k40077_0004 = { spawnLocator = "SpawnPoint_k40077_0004", },
		SpawnPoint_k40077_0005 = { spawnLocator = "SpawnPoint_k40077_0005", route = "rt_k40077_SP_0005_0000", },
		SpawnPoint_k40077_0006 = { spawnLocator = "SpawnPoint_k40077_0006", },
		SpawnPoint_k40077_0007 = { spawnLocator = "SpawnPoint_k40077_0007", route = { "rt_k40077_SP_0007_0000", "rt_k40077_SP_0007_0001", "rt_k40077_SP_0007_0002", "rt_k40077_SP_0007_0003", },},
		SpawnPoint_k40077_0008 = { spawnLocator = "SpawnPoint_k40077_0008", },
	},
}



lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameMain",
	OnEnter = function()
		if ( fvars.isFirstBuilding == true ) then	
			this.DisplayMissionArea( "marker_missionArea" )
		end
		
		this.DisplayGuideLine( { "guidelines_mission_common_coop"} )
	end,
	options = {
		marker = {		
			{ name = "marker_target", areaName = "marker_missionArea", },
		},
		radio = { name = "f3010_rtrg0900", options = { isOnce = true } },	
		objective = "mission_common_objective_putDigger",
		route = {
			{ enemyName = "zmb_k40077_0004", routeName = "rt_zmb_k40077_0000", },
			{ enemyName = "zmb_k40077_0012", routeName = "rt_zmb_k40077_0001", },
			{ enemyName = "zmb_k40077_0009", routeName = "rt_zmb_k40077_0002", },
		},
	},
	clearConditionTable = {
		putDigger = defenseTargetGimmickIdentifier,
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	addStepName = "GameBoot",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		MissionObjectiveInfoSystem.SetForceOpen( true )
		
		this.DisableMissionArea( "marker_missionArea" )
		
		TppMarker.Enable( "marker_target", 0, "moving", "all", 0, true, true )
		if ( fvars.isFirstBuilding == false ) then
			
			this.OpenFieldMap()
			
			fvars.isFirstBuilding = true
		elseif ( fvars.isFirstBuilding == true ) then		
			
			TppRadio.Play("f3000_rtrg2109", { delayTime = 3.0 } )
		end
	end,
	OnLeave = function()
		
		TppMarker.Disable( "marker_target" )
	end,
	options = {
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

this.flagStep.GameBoot.messageTable = {
	GameObject = {
		{
			msg = "BuildingSpawnEffectEnd",
			func = function( gameObjectId, typeId, productionId )
				Fox.Log( "k40077.Messages(): GameObject: msg:BuildingSpawnEffectEnd, gameObjectId:" .. tostring( gameObjectId ) )
				if ( fvars.isTipsWave == false ) then
					local gimmickGameObjectId
					gimmickGameObjectId = Gimmick.SsdGetGameObjectId{
						gimmickId		= k40077_diggerIdentifierParam[1],
						name			= k40077_diggerIdentifierParam[2],
						dataSetName		= k40077_diggerIdentifierParam[3],
					}
					if ( gameObjectId == gimmickGameObjectId ) then
						Fox.Log( "k40077.Messages(): gameObjectId == gimmickGameObjectId" )
						
						fvars.isTipsWave = true
						
						TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_WAVE )
					end
				end
			end
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameDefense",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		Gimmick.SetSsdPowerOff{
			gimmickId		= k40077_diggerIdentifierParam[1],
			name			= k40077_diggerIdentifierParam[2],
			dataSetName		= k40077_diggerIdentifierParam[3],
			powerOff		= true,
		}
		
		this.SetWaveWalkSpeed("zmb_field_0000", "walk")
		this.SetWaveWalkSpeed("zmb_field_0001", "walk")
		this.SetWaveWalkSpeed("zmb_field_0002", "walk")
		this.SetWaveWalkSpeed("zmb_field_0003", "walk")
		this.SetWaveWalkSpeed("zmb_field_0004", "walk")
		this.SetWaveWalkSpeed("zmb_field_0005", "walk")
		this.SetWaveWalkSpeed("zmb_field_0006", "walk")
		this.SetWaveWalkSpeed("zmb_field_0007", "walk")
		this.SetWaveWalkSpeed("zmb_field_0008", "walk")
		this.SetWaveWalkSpeed("zmb_field_0009", "walk")
		this.SetWaveWalkSpeed("zmb_field_0010", "walk")
		this.SetWaveWalkSpeed("zmb_field_0011", "walk")
		this.SetWaveWalkSpeed("zmb_field_0012", "walk")
		this.SetWaveWalkSpeed("zmb_field_0013", "walk")
		this.SetWaveWalkSpeed("zmb_field_0014", "walk")
		this.SetWaveWalkSpeed("zmb_field_0015", "walk")
		this.SetWaveWalkSpeed("zmb_field_0016", "walk")
		this.SetWaveWalkSpeed("zmb_field_0017", "walk")
		this.SetWaveWalkSpeed("zmb_field_0018", "walk")
		this.SetWaveWalkSpeed("zmb_field_0027", "walk")
	end,
	OnLeave = function()
	end,
	options = {
		radio = { name = "f3010_rtrg0904", options = { delayTime = 16.0 }},
		objective = "mission_common_objective_defendDigger_coop",
		checkObjectiveIfCleared = "mission_common_objective_defendDigger_coop",
		nextStepDelay = {
			{ type = "Delay", delayTimeSec = 6.0, },	
		},
	},
	clearConditionTable = {
		wave = {
			waveName = "wave_k40077_00",
			maxWaveCount = 3,		
			defenseGameArea = {
				areaTrapName = "trap_k40077_DefenseGameArea",
				alertTrapName = "trap_k40077_DefenseGameAlertArea",
			},
		},
	},
}




this.SetWaveWalkSpeed = function( locatorName, speed )
	if speed == nil then
		speed = "speed"
	end
	local gameObjectId = { type="SsdZombie" } 
	local command = { id="SetWaveWalkSpeed", speed=speed, locatorName=locatorName }
	GameObject.SendCommand( gameObjectId, command )
end


this.flagStep.GameDefense.messageTable = {
	GameObject = {
		{	
			msg = "FinishWave",
			func = function( waveName, waveIndex )
				local waveName = TppMission.GetCurrentWaveName()
				Fox.Log( "k40077.Messages():GameObject:FinishWave: " .. tostring( waveName ) )
				if waveName == "wave_k40077_00" then
					Fox.Log( "k40077.IntervalRadio: wave_k40077_00" )
					TppRadio.Play("f3010_rtrg0914", { delayTime = 3.0 } )
				end
				if waveName == "wave_k40077_01" then
					Fox.Log( "k40077.IntervalRadio: wave_k40077_01" )
					TppRadio.Play("f3010_rtrg0916", { delayTime = 3.0 } )
				end
			end
		},
		{	
			msg = "FinishWaveInterval",
			func = function( waveName, waveIndex )
				Fox.Log( "k40077.Messages():Timer:FinishWaveInterval" )
				TppRadio.Play("f3000_rtrg2116", { delayTime = 2.0 } )
			end
		},
	},
}





lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameEscape",
	previousStep = lastAddedStep,
	OnEnter = function()
		
		this.DisableGuideLine()
	end,
	options = {
		radio = "f3010_rtrg0918",
		objective = "mission_common_objective_returnToBase",
		vanishDigger = { waveName = "wave_k40077_00" },
	},
	clearConditionTable = {
		home = { checkObjective = "mission_common_objective_returnToBase", },
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this, 
	addStepName = "GameClear",
	previousStep = lastAddedStep,
	options = {
	},
	clearConditionTable = {
		clearStage = {
			true,
		}
	},
}




this.blackRadioOnEnd = "K40077_0020"




this.releaseAnnounce = { "EnableCreateCoop", }

return this
