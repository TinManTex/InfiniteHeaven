local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseMissionSequence.CreateInstance( "s10035" )

this.requires = {
	"/Assets/ssd/level/mission/story/s10035/KaijuUtility.lua",
}

this.sequences = {}




this.INITIAL_CAMERA_ROTATION = { 0, 268.3, }


this.disableBaseCheckPoint = true

local ESCAPE_GOAL_NAVI_MAX_COUNT = 14



this.VARIABLE_TRAP_SETTING = {
	{ name = "trap_fallDeath_Escape1_0000", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape1_0001", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape1_0002", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape2_0001", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape3_0000", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape3_0001", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape3_0002", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
	{ name = "trap_fallDeath_Escape3_0003", type = TppDefine.TRAP_TYPE.TRIGGER, initialState = TppDefine.TRAP_STATE.DISABLE, },
}


this.VARIABLE_TRAP_GROUP = {
	Escape1 = {
		"trap_fallDeath_Escape1_0000",
		"trap_fallDeath_Escape1_0001",
		"trap_fallDeath_Escape1_0002",
	},
	Escape2 = {
		"trap_fallDeath_Escape2_0001",
	},
	Escape3 = {
		"trap_fallDeath_Escape3_0000",
		"trap_fallDeath_Escape3_0001",
		"trap_fallDeath_Escape3_0002",
		"trap_fallDeath_Escape3_0003",
	},
}




this.WAVE_LIST = Tpp.Enum{
	"wave_01",
}

this.WAVE_PROPERTY_TABLE = {
	wave_01 = {
		defenseTimeSec = 380,
		limitTimeSec = 380,
		alertTimeSec = 30,
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.BASE,
		defensePosition = { useCurrentLocationBaseDiggerPosition = true },
		defenseTargetGimmickProperty = {
			identificationTable = {
				digger = TppGimmick.GetAfghBaseDiggerIdentifier(),
			},
		},
		isTerminal = true
	},
}








this.sequenceList = {
	"Seq_Demo_Kaiju",	
	"Seq_Demo_MB",	
	"Seq_Game_Escape1",
	"Seq_Demo_Explosion",	
	"Seq_Game_Escape2",
	"Seq_Demo_CatWalk",	
	"Seq_Game_Escape3",
	"Seq_Demo_Wormhole",	
	nil,
}





this.saveVarsList = {
	didEventKaiju01 = false,
	didEventKaiju02 = false,
	didEventKaiju03 = false,
	didEventKaiju04 = false,
	didEventKaiju05 = false,
	didEventKaiju06 = false,
	didDeadEnd01 = false,
	didDeadEnd02 = false,
	didDeadEnd03 = false,
	didDeadEnd04 = false,
	didDeadEnd05 = false,
	didDeadEnd06 = false,
	didDeadEnd07 = false,
	didDeadEnd08 = false,
	didDeadEnd09 = false,
	escapeTimeOver = 60,
}


this.checkPointList = {
	"CHK_DefenseGame",
	"CHK_Escape1",
	"CHK_Escape2",
	"CHK_Escape3",
	nil
}







this.missionObjectiveDefine = {
	marker_goal = {
		gameObjectName = "marker_goal", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all",
	},
	marker_startDefense = {
		gameObjectName = "marker_startDefense", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all",
	},
}

for i = 1, ESCAPE_GOAL_NAVI_MAX_COUNT do
	local objectiveName = string.format( "marker_goalNavi%04d", i )
	this.missionObjectiveDefine[objectiveName] = {
		gameObjectName = objectiveName, visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", seEventName = "sfx_s_mb_reach_point",
	}
end











local goalNaviObjectiveTree = {}

this.missionObjectiveTree = {
	marker_goal = goalNaviObjectiveTree,
}

do
	local missionObjectiveTree = goalNaviObjectiveTree
	for i = ESCAPE_GOAL_NAVI_MAX_COUNT, 1, -1 do	
		local objectiveName = string.format( "marker_goalNavi%04d", i )
		missionObjectiveTree[objectiveName] = {}
		missionObjectiveTree = missionObjectiveTree[objectiveName]
	end
	missionObjectiveTree["marker_startDefense"] = {}
end

local baseMissionObjetiveEnum = { "marker_goal", "marker_startDefense", }
for i = 1, ESCAPE_GOAL_NAVI_MAX_COUNT do
	local objectiveName = string.format( "marker_goalNavi%04d", i )
	baseMissionObjetiveEnum[#baseMissionObjetiveEnum+1] = objectiveName
end

this.missionObjectiveEnum = Tpp.Enum( baseMissionObjetiveEnum )





this.AfterMissionPrepare = function()
	Fox.Log( "s10035_sequence.AfterMissionPrepare()" )

	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			TppMission.MissionGameEnd()
		end,
		OnEndMissionReward = function()
			TppMission.MissionFinalize{ isNoFade = true }
			TppPlayer.ResetInitialPosition()
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.s10035_OUT_OF_MISSION_AREA )
		end,
		OnGameOver = function()
			
			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.S10035_TOO_CLOSE_KAIJU ) then
				TppPlayer.StartGameOverCamera( PlayerInfo.GetLocalPlayerIndex(), "EndFadeOut_CloseKaijuPlayerDeadCamera", nil, "EndFadeIn_CloseKaijuPlayerDeadCamera" )
				TppMission.ShowGameOverMenu{ delayTime = 6.0 }
				return true
			end
			
			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.S10035_OUT_OF_MISSION_AREA ) then
				TppPlayer.StartGameOverCamera( PlayerInfo.GetLocalPlayerIndex(), "EndFadeOut_OutOfMissionAreaDemo", nil, "EndFadeIn_OutOfMissionAreaDemo" )
				TppMission.ShowGameOverMenu{ delayTime = 6.0 }
				return true
			end
		end,
		nil
	}

	
	FogWallController.SetEnabled( false )
	
	TppSoundDaemon.SetKeepPhaseEnable( false )

	
	TppMission.RegisterWaveList( this.WAVE_LIST )
	TppMission.RegisterWavePropertyTable( this.WAVE_PROPERTY_TABLE )

	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )

	
	afgh_base.AddOnBaseActivatedCallBackFunction( this.OnBaseActivated )

	if DebugMenu then
		mvars.qaDebug.s10035_stopDistanceCheck = false
		DebugMenu.AddDebugMenu(" s10035", "stopDistanceCheck", "bool", mvars.qaDebug, "s10035_stopDistanceCheck")
		mvars.qaDebug.s10035_stopGameOverTimer = false
		DebugMenu.AddDebugMenu(" s10035", "stopGameOverTimer", "bool", mvars.qaDebug, "s10035_stopGameOverTimer")
	end

end


this.OnBuddyBlockLoad = function()
	
	local PLAYER_INITIAL_CAMERA_ROTATION = {
		
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape1" )] = { 3.802, -94.93449, },
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape2" )] = { 29.730, 74.700, },
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape3" )] = { 5.211, -103.975, },
	}
	local gameSequenceIntialCameraRotation = PLAYER_INITIAL_CAMERA_ROTATION[ TppSequence.GetCurrentSequenceIndex() ]
	if gameSequenceIntialCameraRotation then
		vars.playerCameraRotation[0] = gameSequenceIntialCameraRotation[1]
		vars.playerCameraRotation[1] = gameSequenceIntialCameraRotation[2]
	end
end

this.AfterOnRestoreSVars = function()
	Fox.Log( "s10035_sequence.AfterOnRestoreSVars()" )

	if TppSequence.GetMissionStartSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_Escape1" ) then
		KaijuUtility.SetEnabled( false )
	else

	end

	Mission.SetWaveCount( #this.WAVE_LIST )

	
	this.SetFallDeathTrap( TppSequence.GetMissionStartSequenceIndex() )
end


this.AfterOnEndMissionPrepareSequence = function()
	
	Mission.SetRevivalDisabled( false )

	
	TppClock.SetTime( "12:00:00" )	
	TppClock.Stop()	

	local missionStartSequenceIndex = TppSequence.GetMissionStartSequenceIndex()
	if ( missionStartSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Escape2" ) ) then
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.00, { fogDensity = 0.03 }  )	
	elseif ( missionStartSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Escape3" ) ) then
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.00, { fogDensity = 0.08 }  )	
	else
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.00 )	
	end

	
	
	if missionStartSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_Escape1" ) then
		TppDataUtility.SetVisibleEffectFromGroupId( "MissionGoalWormhole", false )
	else
		TppDataUtility.SetVisibleEffectFromGroupId( "MissionGoalWormhole", true )
	end

	this.InitializeBaseAssetFor_s10035( missionStartSequenceIndex )

	this.SetChrisInitialState( missionStartSequenceIndex )

	this.SetUpMissionObjectiveInfo()

	
	do
		local base = {
			Vector3( -603.843, 315.5, 2247.47 ),
			Vector3( -597.802, 320.5, 2226.6 ),
			Vector3( -564.072, 315.5, 2223.00 ),
		}
		local size = {
			Vector3( 16.0, 16.0, 24.0 ),
			Vector3( 16.0, 16.0, 24.0 ),
			Vector3( 30.0, 10.0, 20.0 ),
		}
		for i = 1, #base do
			Gimmick.AddUnitInterferer{
				base = base[i],
				size = size[i],
				key = "s10060",
			}
		end
	end
end

this.OnBaseActivated = function()
	Fox.Log( "s10035_sequence.OnBaseActivated()" )
	local sequenceIndex = TppSequence.GetCurrentSequenceIndex()
	this.InitializeBaseAssetFor_s10035( sequenceIndex )
end

this.InitializeBaseAssetFor_s10035 = function( sequenceIndex )
	Fox.Log( "s10035_sequence.InitializeBaseAssetFor_s10035 : sequenceIndex = " .. tostring(sequenceIndex) )

	if sequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_Escape2" ) then
		this.SetBaseAssetVisibility( "p30_000040_after_ON_before_OFF", false )
		this.SetBaseAssetVisibility( "p30_000040_before_ON_after_OFF", true )
	else
		this.SetBaseAssetVisibility( "p30_000040_after_ON_before_OFF", true )
		this.SetBaseAssetVisibility( "p30_000040_before_ON_after_OFF", false )
	end

	if sequenceIndex < TppSequence.GetSequenceIndex( "Seq_Game_Escape3" ) then
		this.SetDemoCatWalkVisibility( true ) 
	else
		this.SetDemoCatWalkVisibility( false ) 
	end

	if sequenceIndex == TppSequence.GetSequenceIndex( "Seq_Demo_CatWalk" ) then
		this.SetBaseAssetVisibility( "p30_000050_after_ON_before_OFF", false )
		this.SetBaseAssetVisibility( "p30_000050_before_ON_after_OFF", false )
	end

	
	this.SetBaseAssetVisibility( "p30_000060_after_ON_before_OFF", false )
	this.SetBaseAssetVisibility( "p30_000060_before_ON_after_OFF", true )

	
	local pathDataSetName = "/Assets/ssd/level/location/afgh/block_large/base/afgh_base_path.fox2"
	local pathNameList = {
		"pathElude_LastAfghBefore_0000",
		"pathElude_LastAfghBefore_0001",
		"pathElude_LastAfghBefore_0002",
		"pathElude_LastAfghBefore_0003",
	}
	local pathEnableList = {
		false,
		false,
		false,
		false,
	}
	for index, pathName in pairs( pathNameList ) do
		GeoPathService.EnablePath( pathDataSetName, pathName, pathEnableList[index] )
	end
end




this.AddOnTerminateFunction(
	function()
		Fox.Log( "s10035_sequence.AfterOnTerminate()" )
		
		Mission.SetRevivalDisabled( false )
		
		TppUiStatusManager.UnsetStatus("SsdUiCommon", "IS_KAIJU_WAR")
		
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		
		FogWallController.SetEnabled( true )
		
		TppSoundDaemon.SetKeepPhaseEnable( false )
		
		Gimmick.RemoveUnitInterferer{ key = "s10060", }
	end
)





function this.SetBaseAssetVisibility( key, visibility )
	TppDataUtility.SetVisibleDataFromIdentifier( "DataIdentifier_afgh_base_identifier", key, visibility, true )
end

function this.SetDemoCatWalkVisibility( isBeforeDemo )
	this.SetBaseAssetVisibility( "p30_000050_before_ON_after_OFF", isBeforeDemo )
	this.SetBaseAssetVisibility( "p30_000050_after_ON_before_OFF", ( not isBeforeDemo ) )
end


function this.SetGeorgeStandByDemoWormhole()
	local crewName = "uniq_mlt"
	local enable, translation, rotQuat = DemoDaemon.GetStartPosition( "p30_000060", crewName )	
	if not enable then
		Fox.Error("s10035_sequence.SetGeorgeStandByDemoWormhole : Cannot get demo start position. crewName = " .. tostring(crewName))
		return
	end
	local pos, rotY = TppMath.Vector3toTable(translation) , Tpp.GetRotationY( rotQuat )
	pos[2] = pos[2] + 10	
	rotY = foxmath.DegreeToRadian(rotY)
	local gameObjectId = GameObject.GetGameObjectId( "SsdCrew", crewName )
	GameObject.SendCommand( gameObjectId, { id="Warp", pos = pos, rotY = rotY } )
end


function this.SetChrisInitialState( missionStartSequenceIndex )

	local crewName = "uniq_boy"
	local enable, translation, rotQuat = DemoDaemon.GetEndPosition( "p30_000040", crewName )	
	if not enable then
		Fox.Error("s10035_sequence.SetChrisInitialState : Cannot get demo end position. crewName = " .. tostring(crewName))
		return
	end
	local pos, rotY = TppMath.Vector3toTable(translation) , Tpp.GetRotationY( rotQuat )
	rotY = foxmath.DegreeToRadian(rotY)

	
	local uniq_boy_initialStateTable = {
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape1" )] = { id="SetCarried" },
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape2" )] = { id="Warp", pos = pos, rotY = rotY },
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape3" )] = { id="SetCarried" },
	}
	local uniq_boy_initialState = uniq_boy_initialStateTable[missionStartSequenceIndex]

	if uniq_boy_initialState then
		Fox.Log( "s10035_sequence.SetChrisInitialState() Set uniq_boy initial state" )
		GameObject.SendCommand( GameObject.GetGameObjectId( "SsdCrew", crewName ), uniq_boy_initialState )
	end
end

function this.GoNextSequence( self, option )
	if not self then
		Fox.Error("s10035_sequence.GoNextSequence : self is nil.")
		return
	end
	if self.nextSequence then
		TppSequence.SetNextSequence( self.nextSequence, option )
	else
		Fox.Error("s10035_sequence.GoNextSequence : self.nextSequence is nil.")
		return
	end
end




function this.SetUpMissionObjectiveInfo()
	MissionObjectiveInfoSystem.Clear()	
	MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_10035_objective_02", }
	MissionObjectiveInfoSystem.Open()	
	MissionObjectiveInfoSystem.SetForceOpen(true)
end




function this.SetFallDeathTrap( sequenceIndex )
	if not Tpp.IsTypeNumber(sequenceIndex) then
		Fox.Error("s10035_sequence.SetFallDeathTrap : sequenceIndex is not number. sequenceIndex = " .. tostring(sequenceIndex))
		return
	end
	local enbleFallDeathIndexList = {
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape1" )] = 1,
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape2" )] = 2,
		[TppSequence.GetSequenceIndex( "Seq_Game_Escape3" )] = 3,
	}
	local enbleFallDeathIndex = enbleFallDeathIndexList[sequenceIndex] or 0
	Fox.Log("s10035_sequence.SetFallDeathTrap: enbleFallDeathIndex = " .. tostring(enbleFallDeathIndex))
	for index, trapGroupName in ipairs{ "Escape1", "Escape2", "Escape3", } do
		if index <= enbleFallDeathIndex then
			this._SetFallDeathTrap( trapGroupName, true )
		else
			this._SetFallDeathTrap( trapGroupName, false )
		end
	end
end

function this._SetFallDeathTrap( trapGroupName, enable )
	local trapGroupList = this.VARIABLE_TRAP_GROUP[trapGroupName]
	if not trapGroupList then
		Fox.Error("this.EnableFallDeathTrap : invalid trap group name. trapGroupName = " .. tostring(trapGroupName) )
		return
	end
	for index, trapName in ipairs( trapGroupList ) do
		if enable then
			TppTrap.Enable( trapName )
		else
			TppTrap.Disable( trapName )
		end
	end
end




function this.StartGameOverDistanceCheck()
	GkEventTimerManager.Start( "Timer_GameOverDistanceCheck", 4 )
end

function this._StartGameOverDistanceCheck()
	GkEventTimerManager.Start( "Timer_GameOverDistanceCheck", 2 )
end

function this.GameOverDistanceCheck()
	local boyGameObjectId = GameObject.GetGameObjectId( "SsdCrew", "uniq_boy" )
	local boyPos = GameObject.SendCommand( boyGameObjectId, { id="GetPosition" } )
	local playerPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ )
	local diffVector = playerPos - boyPos
	local distance = diffVector:Dot( diffVector )
	local CAUTION_THRESHOLD, GAMEOVER_THRESHOLD = 6, 16
	if ( distance > ( GAMEOVER_THRESHOLD * GAMEOVER_THRESHOLD ) ) then
		
		
		TppPlayer.ReserveTargetDeadCameraGameObjectId( boyGameObjectId )
		TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.TARGET_DEAD, TppDefine.GAME_OVER_RADIO.S10020_TARGET_KILL )
	elseif ( distance > ( CAUTION_THRESHOLD * CAUTION_THRESHOLD ) ) then
		
		this.PlayDistanceCautionRadio()
	else
		
	end
	if DebugText then
		mvars.s10035_DEBUG_GameOverCheckDistance = distance
	end
	this._StartGameOverDistanceCheck()
end

function this.PlayDistanceCautionRadio()
	if not mvars.s10035_lastPlayedCautionDistanceRadio then
		TppRadio.Play( "f3010_rtrg1506" )
		GkEventTimerManager.Start( "Timer_ClearPlayedDistanceCautionRadio", 20 )
		mvars.s10035_lastPlayedCautionDistanceRadio = true
	end
end

function this.ClearPlayedDistanceCautionRadio()
	mvars.s10035_lastPlayedCautionDistanceRadio = nil
end

function this.StopGameOverDistanceCheckTimer()
	for index, TimerName in ipairs{ "Timer_GameOverDistanceCheck", "Timer_ClearPlayedDistanceCautionRadio" } do
		if GkEventTimerManager.IsTimerActive( TimerName ) then
			Fox.Log("this.StopGameOverDistanceCheckTimer : stop " .. TimerName )
			GkEventTimerManager.Stop(TimerName)
		end
	end
end


function this.UpdateGoalNavi( goalNaviMarkerName, radio )
	if ( not TppMission.IsEnableMissionObjective( goalNaviMarkerName ) )
	and ( not TppMission.IsEnableAnyParentMissionObjective( goalNaviMarkerName ) ) then
		this.StartTimeOverTimer( goalNaviMarkerName )
	end

	TppMission.UpdateObjective{ objectives = { goalNaviMarkerName, }, radio = radio }

end








this.GOAL_NAVI_TIME_OVER_SEC = {
	marker_goalNavi0001 = { 30, 30, 10 },
	marker_goalNavi0002 = { 10, 30, 10 },
	marker_goalNavi0003 = { 15, 30, 10 },
	marker_goalNavi0004 = { 15, 30, 10 },
	marker_goalNavi0005 = { 15, 30, 10 },
	marker_goalNavi0006 = { 15, 30, 10 },
	marker_goalNavi0007 = { 15, 30, 10 },
	marker_goalNavi0008 = { 25, 30, 10 },
	marker_goalNavi0009 = { 25, 30, 10 },
	marker_goalNavi0010 = { 15, 30, 10 },
	marker_goalNavi0011 = { 10, 30, 10 },
	marker_goalNavi0012 = { 10, 30, 10 },
	marker_goalNavi0013 = { 10, 30, 10 },
	marker_goalNavi0014 = { 15, 30, 10 },
}

function this.StartTimeOverTimer( goalNaviMarkerName )
	this.StopTimeOverTimer()
	mvars.s10035_goalNaviMarkerName = goalNaviMarkerName
	local timeOverSec = this.GOAL_NAVI_TIME_OVER_SEC[goalNaviMarkerName]
	if goalNaviMarkerName then
		Fox.Log("StartTimeOverTimer : timeOverSec = " .. tostring(timeOverSec[1]) )
		GkEventTimerManager.Start( "Timer_TimeOverGameOver", timeOverSec[1] )
	else
		Fox.Error("StartTimeOverTimer : invalid goalNaviMarkerName. goalNaviMarkerName = " .. tostring(goalNaviMarkerName) )
	end
end

function this.StopTimeOverTimer()
	local TimerName = "Timer_TimeOverGameOver"
	if GkEventTimerManager.IsTimerActive( TimerName ) then
		Fox.Log("this.StopTimeOverTimer : stop " .. TimerName )
		GkEventTimerManager.Stop(TimerName)
	end
	TopLeftDisplaySystem.RequestClose()
end

function this.StartTimeOverDisplayTimer()
	if not mvars.s10035_goalNaviMarkerName then
		Fox.Error("this.StartTimeOverDisplayTimer :mvars.s10035_goalNaviMarkerName is nil" )
		return
	end
	local timeOverSec = this.GOAL_NAVI_TIME_OVER_SEC[mvars.s10035_goalNaviMarkerName]
	if timeOverSec then
		TopLeftDisplaySystem.SetInfo{
			titleLangId = "timer_info_s10035", 
			type = TopLeftDisplayType.TIME,
			startTime = timeOverSec[2],
			alertTime = timeOverSec[3],
		}
		TopLeftDisplaySystem.RequestOpen()
	else
		Fox.Error("this.StartTimeOverDisplayTimer : invalid goalNaviMarkerName. goalNaviMarkerName = " .. tostring(mvars.s10035_goalNaviMarkerName) )
	end
end

function this.TimeOverWhileEscapeSequence()
	TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.S10035_TIME_OVER, TppDefine.GAME_OVER_RADIO.S10020_TARGET_KILL )
end




function this.StartKaijuClusterAttackDemo()
	Fox.Log("this.StartKaijuClusterAttackDemo")
	
	local command = {
		id = "SetCommandAction",
		actionType = "ClusterAttack",
		actorRoleIndex = 1,
		targetPosition = Vector3(-592.034, 320.919, 2215.55),
		launchVector = Vector4(-567.595, 346.251, 2244.69, foxmath.DegreeToRadian(-30)),
		isActorOnly = true,
		commandId = "KaijuClusterAttackDemo",
	}
	local baseGameObjectId = GameObject.GetGameObjectId( "SsdKaiju", "kij_0000" )
	local gameObjectId = baseGameObjectId + 0
	GameObject.SendCommand( gameObjectId, command )
end




function this.IsGameEscapeSequence( sequenceIndex )
	local sequenceIndex = sequenceIndex or TppSequence.GetCurrentSequenceIndex()
	if ( sequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Escape1" ) )
	or ( sequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Escape2" ) )
	or ( sequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Escape3" ) ) then
		return true
	else
		return false
	end
end

function this.CloseKaijuPlayerDeadCamera()
	TppPlayer.PrepareStartGameOverCamera()

	Player.RequestToPlayCameraNonAnimation{
		characterId = mvars.ply_gameOverCameraGameObjectId, 
		isFollowPos = false,	
		isFollowRot = true,	
		followTime = 7,	
		followDelayTime = 0.1,	
		




		candidateRots = { {10, 0}, {10, 45}, {10, 90}, {10, 135}, {10, 180}, {10, 225}, {10, 270} },
		skeletonNames = {"SKL_004_HEAD", "SKL_011_LUARM", "SKL_021_RUARM", "SKL_032_LFOOT", "SKL_042_RFOOT" },	
		



		skeletonCenterOffsets = { Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0) },
		skeletonBoundings = { Vector3(0,0.45,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0, -0.3,0), Vector3(0, -0.3, 0) },
		offsetPos = Vector3( 1.0, -1.25, -6.0),	
		focalLength = 21.0,	
		aperture = 1.875,	
		timeToSleep = 10,	
		fitOnCamera = true,	
		timeToStartToFitCamera = 0.001,	
		fitCameraInterpTime = 0.24,	
		diffFocalLengthToReFitCamera = 16,	
	}
end

function this.OutOfMissionAreaPlayerDeadCamera()
	
	local command = {
		id = "SetCommandAction",
		actionType = "ClusterAttack",
		actorRoleIndex = 1,
		targetPosition = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ),
		launchVector = Vector4(vars.playerPosX, vars.playerPosY + 10.0, vars.playerPosZ, foxmath.DegreeToRadian(-30)),
		isActorOnly = true,
		skipMotion = true,
		commandId = "OnOutOfMissionAreaGameOver",
	}
	local baseGameObjectId = GameObject.GetGameObjectId( "SsdKaiju", "kij_0000" )
	local gameObjectId = baseGameObjectId + 0
	GameObject.SendCommand( gameObjectId, command )

	
	TppPlayer.PrepareStartGameOverCamera()

	Player.RequestToPlayCameraNonAnimation{
		characterId = mvars.ply_gameOverCameraGameObjectId, 
		isFollowPos = false,	
		isFollowRot = true,	
		followTime = 7,	
		followDelayTime = 0.1,	
		




		candidateRots = { {10, 0}, {10, 45}, {10, 90}, {10, 135}, {10, 180}, {10, 225}, {10, 270} },
		skeletonNames = {"SKL_004_HEAD", "SKL_011_LUARM", "SKL_021_RUARM", "SKL_032_LFOOT", "SKL_042_RFOOT" },	
		



		skeletonCenterOffsets = { Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0,0,0) },
		skeletonBoundings = { Vector3(0,0.45,0), Vector3(0,0,0), Vector3(0,0,0), Vector3(0, -0.3,0), Vector3(0, -0.3, 0) },
		offsetPos = Vector3( 1.0, 3.5, -3.0),	
		focalLength = 21.0,	
		aperture = 1.875,	
		timeToSleep = 10,	
		fitOnCamera = true,	
		timeToStartToFitCamera = 0.001,	
		fitCameraInterpTime = 0.24,	
		diffFocalLengthToReFitCamera = 16,	
	}

	this.ForceEnablePlayerDamageForGameOverDemo()
end

function this.ForceEnablePlayerDamageForGameOverDemo()
	Fox.Log("s10035_sequence.this.ForceEnablePlayerDamageForGameOverDemo")
	
	
	local gameStatusScript = {
		"TppMain.lua",
		"TppUI.lua"
	}
	for index, scriptName in ipairs(gameStatusScript) do
		TppGameStatus.Reset( scriptName, "S_DISABLE_PLAYER_DAMAGE")
		TppGameStatus.Reset( scriptName, "S_DISABLE_TARGET")
		TppGameStatus.Reset( scriptName, "S_DISABLE_THROWING")
	end
end






for i = 1, 4 do
	local trapName = "trap_deadEnd0" .. tostring(i)
	local svarsName = "didDeadEnd0" .. tostring(i)
	this.messageTable = this.AddMessage(
		this.messageTable,
		{
			Trap = {
				{	
					sender = trapName,
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if this.IsGameEscapeSequence() then
							if not svars[svarsName] then
								svars[svarsName] = true
								s10035_radio.PlayOnDeadEnd()
							end
						end
					end,
				},
			},
		}
	)
end



for i = 1, ESCAPE_GOAL_NAVI_MAX_COUNT do
	local trapName = string.format( "trap_goalNavi%04d", i )
	local objectiveName = string.format( "marker_goalNavi%04d", i )
	this.messageTable = this.AddMessage(
		this.messageTable,
		{
			Trap = {
				{
					sender = trapName,
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if this.IsGameEscapeSequence() then
							this.UpdateGoalNavi( objectiveName )
						end
					end,
				},
			},
		}
	)
end


this.messageTable = this.AddMessage(
	this.messageTable,
	{
		UI = {
			{
				msg = "EndFadeOut", sender = "EndFadeOut_OutOfMissionAreaDemo",
				func = function()
					GkEventTimerManager.Start( "Timer_OutOfMissionAreaDemo", 0.2 )
					GkEventTimerManager.Start( "Timer_OutOfMissionAreaForceDead", 1.5 )
				end,
				option = { isExecGameOver = true },
			},
			{
				msg = "EndFadeIn", sender = "EndFadeIn_OutOfMissionAreaDemo",
				func = this.ForceEnablePlayerDamageForGameOverDemo,
				option = { isExecGameOver = true },
			},
			{
				msg = "EndFadeIn", sender = "EndFadeIn_StartTargetDeadCamera",
				func = this.ForceEnablePlayerDamageForGameOverDemo,
				option = { isExecGameOver = true },
			},
		},
		Timer = {
			{
				sender = "Timer_OutOfMissionAreaDemo",
				msg = "Finish",
				func = this.OutOfMissionAreaPlayerDeadCamera,
				option = { isExecGameOver = true },
			},
			{
				sender = "Timer_OutOfMissionAreaForceDead",
				msg = "Finish",
				func = function()
					
					Player.SetLifeZero()
				end,
				option = { isExecGameOver = true },
			},
		},
		GameObject = {
			{
				msg = "Dead",
				func = function( gameObjectId )
					local boyGameObjectId = GameObject.GetGameObjectId( "SsdCrew", "uniq_boy" )
					if ( gameObjectId == boyGameObjectId ) then
						TppPlayer.ReserveTargetDeadCameraGameObjectId( gameObjectId )
						TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.TARGET_DEAD, TppDefine.GAME_OVER_RADIO.S10020_TARGET_KILL )
					end
				end,
			},
		},
	}
)

function this.QARelease_DEBUG_MENU_OnUpdate_for_GameSeqeunce()
	if DebugText then
		if mvars.qaDebug.s10035_stopDistanceCheck then
			DebugText.Print(DebugText.NewContext(), "Now force stopping game-over distance check." )
			this.StopGameOverDistanceCheckTimer()
		end
		if mvars.qaDebug.s10035_stopGameOverTimer then
			DebugText.Print(DebugText.NewContext(), "Now force stopping time-over check timer." )
			this.StopTimeOverTimer()
		end
		if mvars.s10035_DEBUG_CurrentKaijuEventMotion then
			DebugText.Print(DebugText.NewContext(), "Current Event Motion : " .. tostring(mvars.s10035_DEBUG_CurrentKaijuEventMotion) )
		end
		if mvars.s10035_DEBUG_GameOverCheckDistance then
			DebugText.Print(DebugText.NewContext(), "Boy to player distance : " .. tostring(mvars.s10035_DEBUG_GameOverCheckDistance) )
		end
	end
end





this.sequences.Seq_Demo_Kaiju = {
	OnEnter = function( self )
		s10035_demo.PlayKaiju{ onEnd = function() this.GoNextSequence( self ) end, }
	end,

	OnLeave = function ()
	end,

	nextSequence = "Seq_Demo_MB",
}

this.sequences.Seq_Demo_MB = {
	OnEnter = function( self )
		TppDemo.SpecifyIgnoreNpcDisable( "uniq_boy" )
		KaijuUtility.SetUpBySequence( self.kaijuParams )
		KaijuUtility.DisableMaterialControlInDemo()
		TppSoundDaemon.SetKeepPhaseEnable( true )
		s10035_demo.PlayMB{ onEnd = function() this.GoNextSequence( self ) end, }
	end,

	OnLeave = function ()
		TppMission.UpdateCheckPoint{ checkPoint = "CHK_Escape1", ignoreAlert = true, }
	end,

	kaijuParams = { rail = "kaiju_rail_0000", },

	nextSequence = "Seq_Game_Escape1",
}

this.sequences.Seq_Game_Escape1 = {
	Messages = function( self )
		return StrCode32Table{
			Trap = {
				{	
					sender = "trap_explosion",
					msg = "Enter",
					func = function()
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_MOMENT, "GoToDemoExplosionFadeOut" )
						this.GoNextSequence( self )
					end,
				},
				{	
					sender = "trap_Escape01_gameOver",
					msg = "Enter",
					func = function()
						TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.S10035_OUT_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.s10035_OUT_OF_MISSION_AREA )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_GameOverDistanceCheck",
					msg = "Finish",
					func = this.GameOverDistanceCheck,
				},
				{
					sender = "Timer_TimeOverGameOver",
					msg = "Finish",
					func = this.StartTimeOverDisplayTimer,
				},
			},
			UI = {
				{
					msg = "DisplayTimerTimeUp",
					func = this.TimeOverWhileEscapeSequence,
				},
			},
		}
	end,

	OnEnter = function( self )
		
		this.SetFallDeathTrap( TppSequence.GetCurrentSequenceIndex() )
		
		Mission.SetRevivalDisabled( true )
		TppUI.SetDefenseGameMenu()
		
		this.UpdateGoalNavi( "marker_goalNavi0001", { radioGroups = "f3010_rtrg1504", radioOptions = { delayTime = "mid" }, } )
		
		this.SetUpMissionObjectiveInfo()
		this.SetGeorgeStandByDemoWormhole()

		KaijuUtility.SetUpBySequence( self.kaijuParams )
		TppDataUtility.SetVisibleEffectFromGroupId( "MissionGoalWormhole", true )

		this.ClearPlayedDistanceCautionRadio()
		this.StartGameOverDistanceCheck()
		TppSoundDaemon.SetKeepPhaseEnable( true )

		s10035_enemy.SetEnableSpiderBySequenceName( "Seq_Game_Escape1" ) 

		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 30, { fogDensity = 0.03 } )
	end,

	nextSequence = "Seq_Demo_Explosion",

	kaijuParams = { rail = "kaiju_rail_0000", },

	OnUpdate = function( self )
		this.QARelease_DEBUG_MENU_OnUpdate_for_GameSeqeunce()
	end,

	OnLeave = function ()
		s10035_enemy.SetEnableAllSpider( false ) 
		this.StopGameOverDistanceCheckTimer()
		this.StopTimeOverTimer()
	end,
}

this.sequences.Seq_Demo_Explosion = {

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{
					msg = "p30_000040_DestroyedFloor_ON",
					func = function()
						this.SetBaseAssetVisibility( "p30_000040_after_ON_before_OFF", true )
						this.SetBaseAssetVisibility( "p30_000040_before_ON_after_OFF", false )
					end,
					option = { isExecDemoPlaying = true, },
				},
			},
		}
	end,

	OnEnter = function( self )
		TppDemo.SpecifyIgnoreNpcDisable( "uniq_boy" )
		s10035_demo.PlayExplosion{
			onEnd = function()
				this.GoNextSequence( self )
			end,
		}
	end,

	OnLeave = function ()
		TppMission.UpdateCheckPoint{ checkPoint = "CHK_Escape2", ignoreAlert = true, }
	end,

	nextSequence = "Seq_Game_Escape2",
}










local eventMotionTable = {
	["p1_step"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle1_step.gani",	
		nextMotion = "p1_idle",
	},
	["p1_idle"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle1_lp.gani",	
		isLoop = true,
	},
	["p11_arm_pre"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle11_arm_lp.gani",	
		isLoop = true,
	},
	["p11_arm"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle11_arm.gani",	
		nextMotion = "p1_idle",
	},
	["p2_look"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle2_look.gani",	
		nextMotion = "p3_idle",
	},
	["p3_head"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle3_head.gani",	
		nextMotion = "p3_idle",
	},
	["p3_idle"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle2_lp.gani",	
		isLoop = true,
	},
	["gameOver01"] = {
		path = "/Assets/ssd/motion/SI_game/fani/bodies/kij0/kij0eve/kij0eve_s_idle1_armL.gani",	
		nextMotion = "p1_idle",
	},
}


local eventStrCodeMotionTable = {}
for motionName, motionTable in pairs(eventMotionTable) do
	eventStrCodeMotionTable[StrCode32(motionName)] = motionTable
end


function this.SetKaijuEventMotion( motionName, isInterpolationOff )
	local motionPath = eventMotionTable[motionName].path
	if not motionPath then
		Fox.Error( "Kaiju", "s10035_sequence.SetKaijuEventMotion : invalid moition name. motionName = " .. tostring(motionName) .. ", isInterpolationOff = " .. tostring(isInterpolationOff) )
		return
	end
	local isLoop = eventMotionTable[motionName].isLoop

	Fox.Log( "Kaiju", "s10035_sequence.SetKaijuEventMotion : motionName = " .. tostring(motionName) .. ", isLoop = " .. tostring(isLoop) )
	KaijuUtility.SendCommand{
		id = "SetCommandAction",
		actionType = "Motion",
		motionPath = motionPath,
		isLoop = isLoop,
		targetAngleY = foxmath.DegreeToRadian( -32.9272 ),
		commandId = motionName,
		isConstrainRail = true,
		isGroundIkOff = true,
		isInterpolationOff = isInterpolationOff,
	}

	if DebugText then
		mvars.s10035_DEBUG_CurrentKaijuEventMotion = motionPath
	end
end


function this.OnEndKaijuEventMotion( gameObjectId, commandId )
	local motionTable = eventStrCodeMotionTable[commandId]
	if not motionTable then
		
		Fox.Log( "Kaiju", "s10035_sequence.OnEndKaijuEventMotion : No motionTable commandId. commandId = " .. tostring(commandId) )
		return
	end
	local nextMotionName = motionTable.nextMotion
	if not nextMotionName then
		
		if not motionTable.isLoop then
			Fox.Error( "Kaiju", "s10035_sequence.OnEndKaijuEventMotion : No nextMotion but isLoop option is false. Please check eventMotionTable." )
		end
		return
	end

	
	this.SetKaijuEventMotion( nextMotionName )
end

this.sequences.Seq_Game_Escape2 = {
	Messages = function( self )
		return StrCode32Table{
			UI = {
				{
					msg = "EndFadeOut", sender = "EndFadeOut_CloseKaijuPlayerDeadCamera",
					func = function()
						GkEventTimerManager.Start( "Timer_StartCloseKaijuPlayerDeadCamera", 0.2 )
					end,
					option = { isExecGameOver = true },
				},
				{
					msg = "EndFadeIn", sender = "EndFadeIn_CloseKaijuPlayerDeadCamera",
					func = this.ForceEnablePlayerDamageForGameOverDemo,
					option = { isExecGameOver = true },
				},
				{
					msg = "DisplayTimerTimeUp",
					func = this.TimeOverWhileEscapeSequence,
				},
			},
			Timer = {
				{
					sender = "Timer_GameOverDistanceCheck",
					msg = "Finish",
					func = this.GameOverDistanceCheck,
				},
				{
					sender = "Timer_ClearPlayedDistanceCautionRadio",
					msg = "Finish",
					func = this.ClearPlayedDistanceCautionRadio,
				},
				{
					sender = "Timer_PlayerCarriedChirisDelay",
					msg = "Finish",
					func = function()
						this.UpdateGoalNavi( "marker_goalNavi0003" )
					end
				},
				{
					sender = "Timer_TimeOverGameOver",
					msg = "Finish",
					func = this.StartTimeOverDisplayTimer,
				},
				{
					sender = "Timer_StartCloseKaijuPlayerDeadCamera",
					msg = "Finish",
					func = function()
						TppPlayer.Warp{ pos = { -568.358, 301.643, 2255.91 }, rotY = 80.484, }
						this.SetKaijuEventMotion( "gameOver01", true ) 
						this.CloseKaijuPlayerDeadCamera()
					end,
					option = { isExecGameOver = true },
				},
			},
			Trap = {
				{	
					sender = "trap_eventKaiju01",
					msg = "Enter",
					func = function()
						if not svars.didEventKaiju01 then
							svars.didEventKaiju01 = true
							KaijuUtility.SetUpBySequence( self.kaijuParams )
							this.SetKaijuEventMotion( "p1_step" )
							s10035_radio.PlayEventKaiju01()
						end
					end,
				},
				{	
					sender = "trap_eventKaiju02",
					msg = "Enter",
					func = function()
						if not svars.didEventKaiju02 then
							svars.didEventKaiju02 = true
							this.SetKaijuEventMotion( "p2_look" )
							s10035_radio.PlayEventKaiju02()
						end
					end,
				},
				{	
					sender = "trap_eventKaiju06",
					msg = "Enter",
					func = function()
						if not svars.didEventKaiju06 then
							svars.didEventKaiju06 = true
							this.SetKaijuEventMotion( "p11_arm_pre" )
						end
					end,
				},
				{	
					sender = "trap_eventKaiju04",
					msg = "Enter",
					func = function()
						if not svars.didEventKaiju04 then
							svars.didEventKaiju04 = true
							this.SetKaijuEventMotion( "p11_arm" )
						end
					end,
				},
				{	
					sender = "trap_catWalk",
					msg = "Enter",
					func = function()
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_MOMENT, "GoToDemoCatWalkFadeOut" )
						this.GoNextSequence( self )
					end,
				},
				{	
					sender = "trap_Escape02_gameOver",
					msg = "Enter",
					func = function()
						TppPlayer.ReserveTargetDeadCameraGameObjectId( PlayerInfo.GetLocalPlayerIndex() )
						TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.S10035_TOO_CLOSE_KAIJU, TppDefine.GAME_OVER_RADIO.S10020_TARGET_KILL )
					end,
				},
			},
			GameObject = {
				{
					msg = "Carried",
					func = function ( gameObjectId, commandId )
						if not mvars.s10035_isShowNaviMarker02 then
							mvars.s10035_isShowNaviMarker02 = true
							GkEventTimerManager.Start( "Timer_PlayerCarriedChirisDelay", 1.5 )
						end
					end
				},
				{
					msg = "CommandActionEnd",
					sender = "kij_0000",
					func = function ( gameObjectId, commandId )
						this.OnEndKaijuEventMotion( gameObjectId, commandId )
					end
				},
			},
		}
	end,

	OnEnter = function( self )
		
		this.SetFallDeathTrap( TppSequence.GetCurrentSequenceIndex() )
		
		Mission.SetRevivalDisabled( true )
		TppUI.SetDefenseGameMenu()
		
		KaijuUtility.SetEnabled( false )

		this.SetGeorgeStandByDemoWormhole()
		this.SetBaseAssetVisibility( "p30_000040_after_ON_before_OFF", true )
		TppSoundDaemon.SetKeepPhaseEnable( true )

		if DebugText then
			mvars.s10035_DEBUG_CurrentKaijuEventMotion = nil
		end

		this.ClearPlayedDistanceCautionRadio()
		this.StartGameOverDistanceCheck()

		
		TppMarker.Disable( "marker_goalNavi0002" )

		s10035_enemy.SetEnableSpiderBySequenceName( "Seq_Game_Escape2" ) 

		this.StartTimeOverTimer( "marker_goalNavi0002" )

		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 10, { fogDensity = 0.03 } )
	end,

	OnUpdate = function( self )
		this.QARelease_DEBUG_MENU_OnUpdate_for_GameSeqeunce()
	end,

	OnLeave = function ()
		s10035_enemy.SetEnableAllSpider( false ) 
		this.StopGameOverDistanceCheckTimer()
		this.StopTimeOverTimer()
	end,

	nextSequence = "Seq_Demo_CatWalk",
	kaijuParams = { rail = { "kaiju_rail_0002", startType = "Terminal" }, },
}

this.sequences.Seq_Demo_CatWalk = {
	OnEnter = function( self )
		TppDemo.SpecifyIgnoreNpcDisable( "uniq_boy" )
		s10035_demo.PlayCatWalk{
			onStart = function()
				this.SetBaseAssetVisibility( "p30_000050_after_ON_before_OFF", false )
				this.SetBaseAssetVisibility( "p30_000050_before_ON_after_OFF", false )
			end,
			onEnd = function()
				this.SetDemoCatWalkVisibility( false ) 
				this.GoNextSequence( self )
			end,
		}

	end,

	OnLeave = function ()
		TppMission.UpdateCheckPoint{ checkPoint = "CHK_Escape3", ignoreAlert = true, }
	end,

	kaijuParams = { rail = { "kaiju_rail_0002", startType = "Terminal" }, },

	nextSequence = "Seq_Game_Escape3",
}

this.sequences.Seq_Game_Escape3 = {
	Messages = function( self )
		return StrCode32Table{
			UI = {
				{
					msg = "DisplayTimerTimeUp",
					func = this.TimeOverWhileEscapeSequence,
				},
			},
			Timer = {
				{
					sender = "Timer_GameOverDistanceCheck",
					msg = "Finish",
					func = this.GameOverDistanceCheck,
				},
				{
					sender = "Timer_ClearPlayedDistanceCautionRadio",
					msg = "Finish",
					func = this.ClearPlayedDistanceCautionRadio,
				},
				{
					sender = "Timer_TimeOverGameOver",
					msg = "Finish",
					func = this.StartTimeOverDisplayTimer,
				},
			},
			Trap = {
				{	
					sender = "trap_eventKaiju03",
					msg = "Enter",
					func = function()
						if not svars.didEventKaiju03 then
							svars.didEventKaiju03 = true
							this.SetKaijuEventMotion( "p3_head" )
							s10035_radio.PlayEventKaiju03()
						end
					end,
				},
				{	
					sender = "trap_eventKaiju05",
					msg = "Enter",
					func = function()
						if not svars.didEventKaiju05 then
							svars.didEventKaiju05 = true
							TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 10, { fogDensity = 0.03 } )
							this.StartKaijuClusterAttackDemo()
						end
					end,
				},
				{	
					sender = "trap_goal",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						this.GoNextSequence( self )
					end,
				},
			},
			GameObject = {
				{
					msg = "CommandActionEnd",
					sender = "kij_0000",
					func = function ( gameObjectId, commandId )
						if ( commandId == Fox.StrCode32("KaijuClusterAttackDemo") ) then
							this.SetKaijuEventMotion( "p3_idle" )	
						else
							this.OnEndKaijuEventMotion( gameObjectId, commandId )
						end
					end
				},
			},
		}
	end,

	OnEnter = function( self )
		if DebugText then
			mvars.s10035_DEBUG_CurrentKaijuEventMotion = nil
		end

		
		this.SetFallDeathTrap( TppSequence.GetCurrentSequenceIndex() )

		
		Mission.SetRevivalDisabled( true )
		TppUI.SetDefenseGameMenu()

		this.SetGeorgeStandByDemoWormhole()

		KaijuUtility.SetUpBySequence( self.kaijuParams )
		this.SetKaijuEventMotion( "p3_idle" )
		this.UpdateGoalNavi( "marker_goalNavi0008" )

		this.ClearPlayedDistanceCautionRadio()
		this.StartGameOverDistanceCheck()
		TppSoundDaemon.SetKeepPhaseEnable( true )

		s10035_enemy.SetEnableAllSpider( false ) 

		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 10, { fogDensity = 0.08 } )
	end,

	OnUpdate = function( self )
		this.QARelease_DEBUG_MENU_OnUpdate_for_GameSeqeunce()
	end,

	OnLeave = function ()
		TppMarker.Disable( "marker_goalNavi0014" )
		this.StopGameOverDistanceCheckTimer()
		this.StopTimeOverTimer()
	end,

	nextSequence = "Seq_Demo_Wormhole",

	kaijuParams = { rail = { "kaiju_rail_0002", startType = "Terminal" }, },
}

this.sequences.Seq_Demo_Wormhole = {
	Messages = function( self )
		return StrCode32Table{
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutPlayDemoWormhole",
					func = function()
						s10035_demo.PlayWormhole{
							onStart = function()
								TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0, { fogDensity = 0.001 } )
								
								this.SetBaseAssetVisibility( "p30_000060_before_ON_after_OFF", false )
								
								afgh_base.SetAiVisibility( false )
								
								TppDataUtility.SetVisibleEffectFromGroupId( "MissionGoalWormhole", false )
							end,
							onEnd = function()
								TppMission.ReserveMissionClear{
									missionClearType = TppDefine.MISSION_CLEAR_TYPE.CYPRUS_GOAL,
									nextMissionId = 30020,
									resetPlayerPos = true,
								}
							end,
						}
					end,
				},
			},
		}
	end,

	OnEnter = function( self )
		MissionObjectiveInfoSystem.Check{ langId = "mission_10035_objective_02", checked = true, }
		
		Player.RequestToSetTargetStance(PlayerStance.STAND) 
		local translation, rotQuat = Tpp.GetLocatorByTransform( "DemoStartPositionIdentifier", "DemoWormholeStartPosition" )
		local direction = Tpp.GetRotationY( rotQuat )
		Player.RequestToMoveToPosition{
			name = "s10030_DemoStartMoveToPosition",
			position = translation,
			direction = direction,
			moveType = PlayerMoveType.WALK,
			onlyInterpPosition = false,
			timeout = TppUI.FADE_SPEED.FADE_NORMALSPEED,
		}
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FadeOutPlayDemoWormhole" )
	end,

	OnLeave = function ()
	end,
}




return this
