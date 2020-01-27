local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId





local this = BaseMissionSequence.CreateInstance( "s10050" )

this.sequences = {}


this.disableBaseCheckPoint = true


this.disableEnemyRespawn = true


this.CREAUTER_COUNT_MAX = 64





local targetEnemyList = {}

function this.InsertTargetEnemyList( enemyList, maxCount, stringFormat )
	for i = 0, maxCount do
		local enemyName = string.format( stringFormat, i )
		table.insert( targetEnemyList, enemyName)
	end
end

local zombieNameFormatTable = {
	["zmb_shell_s10050_%04d"] = 0,
}

for stringFormat, maxCount in pairs( zombieNameFormatTable ) do
	this.InsertTargetEnemyList( targetEnemyList,  maxCount, stringFormat )
end




this.waveSettings = {
	waveList = {
		"wave_s10050",
	},
	wavePropertyTable = {
		wave_s10050 = {
			limitTimeSec	= (60 * 400),
			defenseTimeSec	= (60 * 400),
			alertTimeSec	= 30,
			isTerminal		= true,
			pos				= TppGimmick.GetCurrentLocationDiggerPosition(),
			radius			= 2,
			endEffectName	= "explosion_afgh00_k40075",
			defenseGameType	= TppDefine.DEFENSE_GAME_TYPE.BASE,
			finishType		= { type = TppDefine.DEFENSE_FINISH_TYPE.KILL_COUNT, maxCount = #targetEnemyList },
			miniMap = false,
		},
	},
	waveTable = {
		wave_s10050 = {},
	},
	
	spawnPointDefine = {},
}





this.importantGimmickList = TppGimmick.GetBaseImportantGimmickList()	








this.sequenceList = {
	"Seq_Demo_BeforeSethBattle",
	"Seq_Game_SethBattle",
	"Seq_Demo_ReserveMissionClear",
	"Seq_Demo_AfterSethBattle",
}

function this.OnLoad()
	Fox.Log("#### OnLoad ####")
	TppSequence.RegisterSequences( this.sequenceList )
	TppSequence.RegisterSequenceTable( this.sequences )
end
































function this.GoNextSequence( self, option )
	if not self then
		Fox.Error("s10050_sequence.GoNextSequence : self is nil." .. " Called  from " .. Tpp.DEBUG_Where(2) )
		return
	end
	if self.nextSequence then
		TppSequence.SetNextSequence( self.nextSequence, option )
	else
		Fox.Error("s10050_sequence.GoNextSequence : self.nextSequence is nil."  .. " Called  from " .. Tpp.DEBUG_Where(2) )
		return
	end
end

function this.IsTargetEnemy( gameObjectId )
	local targetEnemyName = targetEnemyList[1]
	if not targetEnemyName then
		Fox.Error("s10050_sequence.IsTargetEnemy: targetEnemyName is nil." )
		return
	end
	if ( gameObjectId == GetGameObjectId( targetEnemyName ) ) then
		return true
	else
		return false
	end
end

function this.ReserveMissionClear()
	Fox.Log( "s10050_sequence.ReserveMissionClear()")
	TppMission.ReserveMissionClear{
		missionClearType = TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,
		nextMissionId = 30010,
		resetPlayerPos = true,
	}
end









function this.AfterMissionPrepare()
	Fox.Log( "s10050_sequence.MissionPrepare()")

	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED }
		end,
		OnDisappearGameEndAnnounceLog = function()
			TppMission.OnEndDefenseGame()
			TppSequence.SetNextSequence( "Seq_Demo_AfterSethBattle", { isExecMissionClear = true } )
		end,
		OnEndMissionReward = function()
			TppTrophy.Unlock( 13 ) 
			TppMission.MissionFinalize{ isNoFade = true }
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		
		OnOutOfDefenseGameArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		
		OnAlertOutOfDefenseGameArea = function()
			this.PlayAlertOutOfMissionAreaRadio()
		end,
		nil
	}
	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )

	
	FogWallController.SetEnabled( false )

	
	TppMission.RegisterWaveList( this.waveSettings.waveList )
	TppMission.RegisterWavePropertyTable( this.waveSettings.wavePropertyTable )
end




function this.AfterOnRestoreSVars()
	Fox.Log( "s10050_sequence.AfterOnRestoreSVars()" )
end


function this.AfterOnEndMissionPrepareSequence()
	
	TppClock.SetTime( "16:00:00" )	
	TppClock.Stop()	
	TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.0, { fogDensity = 0.0, } )
end




this.AddOnTerminateFunction(
	function()
		Fox.Log( "s10050_sequence.AfterOnTerminate()" )
		TppEffectUtility.SetSsdMistWallVisibility(true)		
		FogWallController.SetEnabled( true )	
	end
)







this.messageTable = this.AddMessage(
	this.messageTable,
	{
	}
)


function this.PlayAlertOutOfMissionAreaRadio()
	if not mvars.s10050_isClosePlayedAlertRadio then
		TppRadio.Play( "f3000_rtrg0114" )
		mvars.s10050_isClosePlayedAlertRadio = true

		local timerName = "Timer_PermitPlayAlretRadio"
		if GkEventTimerManager.IsTimerActive( timerName ) then
			GkEventTimerManager.Stop(timerName)
		end
		GkEventTimerManager.Start( timerName, 10 )
	end
end


function this.PowerOffBaseFastTravelPoint()
	Gimmick.SetSsdPowerOff{
		gimmickId		= "GIM_P_Portal",
		name			= "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_small/129/129_150/afgh_129_150_gimmick.fox2",
		powerOff		= true,
	}
end


function this.PowerOffBaseSkillTrainer()
	Gimmick.SetSsdPowerOff{
		gimmickId		= "GIM_P_AI_Skill",
		name			= "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
		powerOff		= true,
	}
end






this.sequences.Seq_Demo_BeforeSethBattle = {

	OnEnter = function( self )
		TppDemo.SpecifyIgnoreNpcDisable( "zmb_shell_s10050_0000" )
		Fox.Log( "s10050_sequences.Seq_Demo_BeforeSethBattle.OnEnter()" )
		s10050_demo.PlayBeforeSethBattle{
			onInit = function()
				afgh_base.SetBaseFastTravelVisibility( false )
			end,
			onEnd = function()
				afgh_base.SetBaseFastTravelVisibility( true )
				this.GoNextSequence( self )
			end,
		}
	end,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{	
					msg = "p50_000005_SetSethDemoThreat",
					func = function()
						local gameObjectId = GameObject.GetGameObjectId( "SsdZombieShell", "zmb_shell_s10050_0000" )
						GameObject.SendCommand( gameObjectId, { id = "SetSethDemoThreat" } )
					end,
					option = { isExecDemoPlaying = true },
				},
			},
		}
	end,

	nextSequence = "Seq_Game_SethBattle",

	OnLeave = function ()
		Fox.Log( "s10050_sequences.Seq_Demo_BeforeSethBattle.OnLeave()" )
	end,
}

this.sequences.Seq_Game_SethBattle = {
	Messages = function( self ) 
		return StrCode32Table {
			GameObject = {
				{
					msg = "Dead",
					func = function( gameObjectId )
						if this.IsTargetEnemy( gameObjectId ) then
							this.GoNextSequence( self )
						end
					end
				},
				{	
					msg = "SethIsNearDead",
					func = function()
						s10050_radio.PlayDyingBossRadio()
					end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log( "s10050_sequence.Seq_Game_SethBattle.OnEnter()" )

		s10050_radio.PlayStartSequenceRadio()
		this.PowerOffBaseSkillTrainer()
		this.PowerOffBaseFastTravelPoint()
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_40240_objective_01", }
		MissionObjectiveInfoSystem.SetForceOpen(true)
		SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = { "guidelines_mission_10050_03" } }

		
		local gameObjectId = GameObject.GetGameObjectId( "SsdZombieShell", "zmb_shell_s10050_0000" ) 
		GameObject.SendCommand( gameObjectId, { id = "SetForceAlert" } )
		GameObject.SendCommand( gameObjectId, { id = "SetLevel", level = 18, randVal = 0 } )
		GameObject.SendCommand( gameObjectId, { id = "ReloadLevel" } )

		
		TppMission.RegisterDefenseGameArea( "trap_baseDefenseGameArea", "trap_baseDefenseGameAlertArea", "wave_s10050" )
		TppMission.StartInitialWave( "wave_s10050" )

		
		Mission.SetPausedDefenseGameTimer( true )
	end,

	OnLeave = function ()
		Fox.Log( "s10050_sequence.Seq_Game_SethBattle.OnLeave()" )
		TppMission.OnClearDefenseGame()
		TppMission.StopDefenseGame()
		local namedCrewQuestId = "k40220"
		SsdCrewSystem.RegisterTempCrew{ quest=namedCrewQuestId }
		SsdCrewSystem.EmployTempCrew{ quest=namedCrewQuestId }
		TppMission.UpdateCheckPointAtCurrentPosition()
		this.JastHasDefeatSeth = true
	end,

	nextSequence = "Seq_Demo_ReserveMissionClear",
}

this.sequences.Seq_Demo_ReserveMissionClear = {
	OnEnter = function()
		Fox.Log( "s10050_sequence.Seq_Demo_ReserveMissionClear.OnEnter()" )
		if not this.JastHasDefeatSeth then
			TppMission.EnableInGameFlag( true )	
		end
		this.ReserveMissionClear()
	end,
}


this.sequences.Seq_Demo_AfterSethBattle = {

	OnEnter = function()
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_40240_objective_01", }
		MissionObjectiveInfoSystem.SetForceOpen(true)
		Fox.Log( "s10050_sequences.Seq_Demo_AfterSethBattle.OnEnter()" )
		s10050_demo.PlayAfterSethBattle{
			onEnd = function()
				
				TppUI.FadeOut( TppUI.FADE_SPEED.FADE_MOMENT, "FadeOutOnEndAfterSethBattle", TppUI.FADE_PRIORITY.SYSTEM, { setMute = true } )
				TppMission.ShowMissionResult()
			end,
		}
	end,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{
					msg = "SethDefeat",
					func = function()
						MissionObjectiveInfoSystem.Check{ langId = "mission_40240_objective_01", checked = true, }	
					end,
					option = { isExecMissionClear = true, isExecDemoPlaying = true },
				},
			},
		}
	end,
}


this.blackRadioOnEnd = "K40240_0020"




this.releaseAnnounce = { "OpenNewUnitDevelop", "CanCrewDeploymentMafr", }




return this
