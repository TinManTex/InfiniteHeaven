



local NULL_ID = GameObject.NULL_ID
local SendCommand = GameObject.SendCommand


local ZOMBIE	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE
local BOM		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_BOM
local DASH		= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_DASH
local MORTOR	= TppGameObject.GAME_OBJECT_TYPE_ZOMBIE_SHELL
local CAMERA	= TppGameObject.GAME_OBJECT_TYPE_INSECT_1
local SPIDER	= TppGameObject.GAME_OBJECT_TYPE_INSECT_2

local this = BaseFlagMission.CreateInstance( "k40240" )

local targetEnemyList = {}

function this.InsertTargetEnemyList( enemyList, maxCount, stringFormat )
	for i = 0, maxCount do
		local enemyName = string.format( stringFormat, i )
		table.insert( targetEnemyList, enemyName)
	end
end

local zombieNameFormatTable = {
	["zmb_shell_k40240_%04d"] = 0,
}
for stringFormat, maxCount in pairs( zombieNameFormatTable ) do
	this.InsertTargetEnemyList( targetEnemyList,  maxCount, stringFormat )
end




this.waveSettings = {
	waveList = {
		"wave_k40240",
	},
	wavePropertyTable = {
		wave_k40240 = {
			limitTimeSec	= (60 * 10),
			defenseTimeSec	= (60 * 10),
			alertTimeSec	= 30,
			isTerminal		= true,
			pos				= TppGimmick.GetCurrentLocationDiggerPosition(),
			radius			= 2,
			endEffectName	= "explosion_afgh00_k40075",
			defenseGameType	= TppDefine.DEFENSE_GAME_TYPE.BASE,
			finishType		= { type = TppDefine.DEFENSE_FINISH_TYPE.KILL_COUNT, maxCount = #targetEnemyList },
		},
	},
	waveTable = {
		wave_k40240 = {},
	},
	
	spawnPointDefine = {},
}













this.importantGimmickList = TppGimmick.GetBaseImportantGimmickList()	

this.foreceBreakImportantGimmickListIndex = 4	


this.missionDemoBlock = { demoBlockName = "AfterSethBattle" }

local lastAddedStep




this.OnActivate = function()
	local targetEnemyType = "SsdZombieShell"
	for index, enemyName in ipairs( targetEnemyList ) do
		TppEnemy.SetDisablePermanent( enemyName, targetEnemyType )
	end
end




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "DemoBeforeSethBattle",
	OnEnter = function()
		BaseMissionSequence.DisableBaseCheckPoint()	
	end,
	OnLeave = function()
		BaseMissionSequence.EnableBaseCheckPoint()	
	end,
	options = {},
	clearConditionTable = {
		demo = {
			demoName = "p20_000020",	
			options = { useDemoBlock = true, finishFadeOut = false, waitBlockLoadEndOnDemoSkip = false, }
		},
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameMain",
	OnEnter = function()
		local targetEnemyType = "SsdZombieShell"
		for index, enemyName in ipairs( targetEnemyList ) do
			TppEnemy.SetEnablePermanent( enemyName, targetEnemyType )
		end
		BaseMissionSequence.DisableBaseCheckPoint()	
		
		TppEnemy.SetEnemyLevelByEnemyType{
			groupLocatorNameList = { "k40240_Wave0000", },
			SsdZombieShell = { level = 22, randomRange = 0 },
		}
		
		SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = { "guidelines_mission_common__zombie_squad" } }
	end,
	OnLeave = function()
		BaseMissionSequence.EnableBaseCheckPoint()	
	end,
	options = {
		radio = "f3010_rtrg2200",
		objective = "mission_40240_objective_01",
	},
	clearConditionTable = {
		kill = {
			targetList = targetEnemyList,
		},
		wave = {
			checkObjective = "mission_40240_objective_01",
			waveName = "wave_k40240",
			defenseGameArea = {
				areaTrapName = "trap_baseDefenseGameArea",
				alertTrapName = "trap_baseDefenseGameAlertArea",
			},
		},
		orCheck = true,
	},
}




lastAddedStep = BaseFlagMission.AddStepWithTable{
	flagMissionInstance = this,
	previousStep = lastAddedStep,
	addStepName = "GameClear",
	clearConditionTable = {
		clearStage = {
			demo = {
				demoName = "p50_000007",
				options = {
					useDemoBlock = true,
					finishFadeOut = true,
				},
			},
			fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED,
		}
	},
}




this.clearRadio = "f3000_rtrg0213"




this.blackRadioOnEnd = "K40240_0020"






return this
