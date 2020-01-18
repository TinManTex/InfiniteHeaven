local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}

this.requires = {
	"/Assets/tpp/level/mission2/free/f30010/f30010_orderBoxList.lua",
}




this.MAX_PICKABLE_LOCATOR_COUNT = 100

this.MAX_PLACED_LOCATOR_COUNT = 200	

this.NO_MISSION_TELOP_ON_START_HELICOPTER = true 

this.NO_RESULT = true

local TIMER_BOSS_QUIET_RADIO = 60	






local S10043_GIMMICK_DATA_LIST = {
	ANTN001							= { gimmickId = "commFacility_antn001", locatorName = "afgh_antn001_vrtn004_gim_n0000|srt_afgh_antn001_fndt004" },
	ANTN002							= { gimmickId = "commFacility_antn002", locatorName = "afgh_antn001_vrtn004_gim_n0001|srt_afgh_antn001_fndt004" },
	ANTN003							= { gimmickId = "commFacility_antn003", locatorName = "afgh_antn001_vrtn004_gim_n0002|srt_afgh_antn001_fndt004" },
	CMMN001							= { gimmickId = "commFacility_cmmn001", locatorName = "afgh_cmmn002_cmmn001_gim_n0000|srt_afgh_cmmn002_cmmn001" },
}

local gimmickBreakSettingTable = {}

gimmickBreakSettingTable[StrCode32( S10043_GIMMICK_DATA_LIST.ANTN001.locatorName )] = {
	locatorName		= S10043_GIMMICK_DATA_LIST.ANTN001.locatorName,
	svarsFlagName	= "isBrokenGimmick_s10043_01",
}

gimmickBreakSettingTable[StrCode32( S10043_GIMMICK_DATA_LIST.ANTN002.locatorName )] = {
	locatorName = S10043_GIMMICK_DATA_LIST.ANTN002.locatorName,
	svarsFlagName	= "isBrokenGimmick_s10043_02",
}

gimmickBreakSettingTable[StrCode32( S10043_GIMMICK_DATA_LIST.ANTN003.locatorName )] = {
	locatorName = S10043_GIMMICK_DATA_LIST.ANTN003.locatorName,
	svarsFlagName	= "isBrokenGimmick_s10043_03",
}

gimmickBreakSettingTable[StrCode32( S10043_GIMMICK_DATA_LIST.CMMN001.locatorName )] = {
	locatorName = S10043_GIMMICK_DATA_LIST.CMMN001.locatorName,
	svarsFlagName	= "isBrokenGimmick_s10043_04",
}








function this.OnLoad()
	Fox.Log("#### OnLoad ####")	

	TppSequence.RegisterSequences{
		
		"Seq_Game_FreePlay",
		
		"Seq_Demo_RecoverVolgin",	
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end





this.saveVarsList = {
	acceptMissionId					= 0,		
	isUniqueInter_interpreter		= 0,		
	isInterpreterRecognized			= false,	
	isOnGetIntel_LostQuiet			= false,	
	
	isBrokenGimmick_s10043_01		= false,	
	isBrokenGimmick_s10043_02		= false,	
	isBrokenGimmick_s10043_03		= false,	
	isBrokenGimmick_s10043_04		= false,	
	isBrokenGimmick_MissionClear	= false,	
}


this.checkPointList = {
	
	
	"CHK_bridge",
	"CHK_citadel",
	"CHK_cliffTown",
	"CHK_commFacility_E",
	"CHK_enemyBase_E",
	"CHK_field_N01",
	"CHK_fort",
	"CHK_powerPlant_W",
	"CHK_remnants",
	"CHK_ruins",
	"CHK_slopedTown_S",
	"CHK_sovietBase_S",
	"CHK_tent",
	"CHK_village_E",
	"CHK_waterway_S",
	"CHK_waterway_W",
	nil
}


this.baseList = {
	
	"bridge",
	"citadel",
	"cliffTown",
	"commFacility",
	"enemyBase",
	"field",
	"fort",
	"powerPlant",
	"remnants",
	"ruins",
	"slopedTown",
	"sovietBase",
	"tent",
	"village",
	"waterway",
	
	"bridgeNorth",
	"bridgeWest",
	"citadelSouth",
	"cliffEast",
	"cliffSouth",
	"cliffWest",
	"commWest",
	"enemyEast",
	"enemyNorth",
	"fieldEast",
	"fieldWest",
	"fortSouth",
	"fortWest",
	"plantWest",
	"remnantsNorth",
	"ruinsNorth",
	"slopedEast",
	"slopedWest",
	"sovietSouth",
	"tentEast",
	"tentNorth",
	"villageEast",
	"villageNorth",
	"villageWest",
	"waterwayEast",
	nil
}







this.missionObjectiveDefine = {
	
	default_area_ruinsNorth = {
		gameObjectName = "marker_ruinsNorth", visibleArea = 4, randomRange = 0, viewType = "map_only_icon", setNew = false,
		langId = "marker_enemyarea_trans", mapRadioName = "f1000_rtrg0700", announceLog = "updateMap",
	},
	
	area_ruinsNorth_none = {},

	default_none = {},
}












this.missionObjectiveTree = {
	default_none = {
		area_ruinsNorth_none = {
			default_area_ruinsNorth = {},
		},
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"default_area_ruinsNorth",
	"area_ruinsNorth_none",
	"default_none",
}

this.missionStartPosition = {
	
	orderBoxList = {
		"box_s10033_00",
		"box_s10033_01",
		"box_s10036_00",
		"box_s10036_01",
		"box_s10036_02",
		"box_s10040_00",
		"box_s10041_00",
		"box_s10041_01",
		"box_s10041_02",
		"box_s10041_03",
		"box_s10043_00",
		"box_s10044_00",
		"box_s10044_01",
		"box_s10045_00",
		"box_s10052_00",
		"box_s10054_00",
		"box_s10054_01",
		"box_s10054_02",
		"box_s10156_00",
		
	},
	helicopterRouteList = {
	},
}







function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")

	
	this.RegiserMissionSystemCallback()
	
	TppScriptBlock.RegisterCommonBlockPackList( "orderBoxBlock", f30010_orderBoxList.orderBoxBlockList )

	
	TppRatBird.EnableBird( "TppCritterBird" )

	
	Gimmick.EnableAlarmLampAll(false)
end






function this.OnGameOver()
	Fox.Log("*** " .. tostring(gameOverType) .. " OnGameOver ***")
	if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.PLAYER_KILL_CHILD_SOLDIER ) then
		TppPlayer.SetPlayerKilledChildCamera()
		TppMission.ShowGameOverMenu{ delayTime = TppDefine.GAME_OVER_TARGET_DEAD_DEMO_TIME }
		return true
	end
end




function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()

	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")

	
	if TppMission.IsMissionStart() then
		svars.isBrokenGimmick_s10043_01  = TppGimmick.IsBroken{ gimmickId = S10043_GIMMICK_DATA_LIST.ANTN001.gimmickId, searchFromSaveData = true }
		svars.isBrokenGimmick_s10043_02  = TppGimmick.IsBroken{ gimmickId = S10043_GIMMICK_DATA_LIST.ANTN002.gimmickId, searchFromSaveData = true }
		svars.isBrokenGimmick_s10043_03  = TppGimmick.IsBroken{ gimmickId = S10043_GIMMICK_DATA_LIST.ANTN003.gimmickId, searchFromSaveData = true }
		svars.isBrokenGimmick_s10043_04  = TppGimmick.IsBroken{ gimmickId = S10043_GIMMICK_DATA_LIST.CMMN001.gimmickId, searchFromSaveData = true }
		
		gvars.s10043_forceMissionClear = false
		
		if ( svars.isBrokenGimmick_s10043_01 == true and svars.isBrokenGimmick_s10043_02 == true and svars.isBrokenGimmick_s10043_03 == true ) or ( svars.isBrokenGimmick_s10043_04 == true ) then
			svars.isBrokenGimmick_MissionClear = true
		end
	end

	
	TppUiCommand.EnableQuietTarget()
	if not TppStory.IsMissionCleard( 10151 ) then
		TppUiCommand.DisableQuietTarget{ position=Vector3(-1523.049,509.4265,-2977.823), radius=500 }
	end
end



function this.RegiserMissionSystemCallback()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " RegiserMissionSystemCallback ***")

	
	
		
		
		
		
	
	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			
			local orderBoxName = TppMission.FindOrderBoxName( gvars.mis_orderBoxName )
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				if orderBoxName then
					local START_MISSION_GAME_END_TIME = 0.33
					local START_OPENING_DEMO_FADE_SPEED = TppUI.FADE_SPEED.FADE_HIGHESTSPEED
					TppSoundDaemon.PostEvent('sfx_s_ifb_mbox_arrival')
					GkEventTimerManager.Start( "Timer_LoadOpeningDemoBlock", START_OPENING_DEMO_FADE_SPEED + START_MISSION_GAME_END_TIME )
					GkEventTimerManager.Start( "Timer_StartMissionGamEndOnOpeningDemo", START_MISSION_GAME_END_TIME )
				else
					Fox.Warning("Cannot find orderBoxName from this.missionStartPosition.orderBoxList")
					TppMission.MissionGameEnd()
				end
			elseif ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR ) then
				SubtitlesCommand.SetIsEnabledUiPrioStrong( true ) 
				TppRadioCommand.SetEnableIgnoreGamePause( true )	
				if not mvars.f30010_playerFultoned then 
					this._ForceMBCamera()
				end
				TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED, fadeDelayTime = 3.5 }
			else
				TppMission.MissionGameEnd()
			end
		end,
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				local orderBoxName = TppMission.FindOrderBoxName( gvars.mis_orderBoxName )
				if not orderBoxName then
					Fox.Error("Cannot get orderBoxName. gvars.mis_orderBoxName = " .. tostring(gvars.mis_orderBoxName) )
				end
				TppMission.ShowMissionReward()
				return
			end

			
			if	( missionClearType == TppDefine.MISSION_CLEAR_TYPE.QUEST_BOSS_QUIET_BATTLE_END )
			or	( missionClearType == TppDefine.MISSION_CLEAR_TYPE.QUEST_LOST_QUIET_END )
			or	( missionClearType == TppDefine.MISSION_CLEAR_TYPE.QUEST_INTRO_RESCUE_EMERICH_END ) then
				TppMission.MissionFinalize{ isNoFade = true, showLoadingTips = false }
				return
			end

			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
			local missionClearType = TppMission.GetMissionClearType()
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				f30010_demo.PlayOpening()
			elseif ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR ) then
				Fox.Log("OnEndMissionReward to MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR")
				local radioList = TppStory.GetForceMBDemoNameOrRadioList("clearSideOpsForceMBRadio", { clearSideOpsName = mvars.qst_currentClearQuestName })
				if radioList and radioList[1] then
					mvars.freePlay_ForceGoToMbRadioName = radioList[1]
					SubtitlesCommand.SetIsEnabledUiPrioStrong( true )	
					TppRadioCommand.SetEnableIgnoreGamePause( true )	
					TppRadio.Play( radioList, { isEnqueue = true, delayTime = TppRadio.PRESET_DELAY_TIME.mid } )
				else
					SubtitlesCommand.SetIsEnabledUiPrioStrong( false )	
					TppRadioCommand.SetEnableIgnoreGamePause( false )	
					TppSound.PostEventOnForceGotMbHelicopter()
					TppMission.MissionFinalize{ isNoFade = true, showLoadingTips = false }
				end
			else
				TppMission.MissionFinalize{ isNoFade = true }
			end
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		OnGameOver = this.OnGameOver,
		
		OnUpdateStorySequenceInGame = function()
			local currentStorySequence = TppStory.GetCurrentStorySequence()
			if ( currentStorySequence == TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON ) then
				
				
			end
		end,
		
		CheckMissionClearOnRideOnFultonContainer = function()
			return true
		end,
		nil
	}

	
	TppMission.RegiserMissionSystemCallback(systemCallbackTable)
end

function this._ForceMBCamera()
	Player.RequestToPlayCameraNonAnimation {
		
		characterId = GameObject.GetGameObjectIdByIndex("TppPlayer2", 0),
		
		isFollowPos = true,
		
		isFollowRot = true,
		
		followTime = 4,
		
		followDelayTime = 0.1,
		
		
		
		candidateRots = { {-2,164}, {-2,-164} },
		
		skeletonNames = {"SKL_004_HEAD", "SKL_011_LUARM", "SKL_021_RUARM" },
		
		
		skeletonCenterOffsets = { Vector3(0,0.1,0.05), Vector3(0.15,0,0), Vector3(-0.15,0,0) },
		skeletonBoundings = { Vector3(0.1,0.125,0.1), Vector3(0.15,0.05,0.05), Vector3(0.15,0.05,0.05) },

		
		
		
		offsetPos = Vector3(0.0,0.0,-1.0),
		
		focalLength = 21.0,
		
		aperture = 1.875,
		
		timeToSleep = 10,
		
		interpTimeAtStart = 2,

		
		fitOnCamera = false,
		
		
		timeToStartToFitCamera = 1,
		
		fitCameraInterpTime = 0.3,
		
		diffFocalLengthToReFitCamera = 16,

		
		isCollisionCheck = false,

		
		
		useLastSelectedIndex = false,

		
		callSeOfCameraInterp = true,
	}
end




function this.AcceptMission( missionId )
	TppMission.AcceptMissionOnFreeMission( missionId, f30010_orderBoxList.orderBoxBlockList, "acceptMissionId" )
end





function this.OnCheckMBReturnRadio()
	Fox.Log("### OnCheckMBReturnRadio ###")
	local currentStorySequence = TppStory.GetCurrentStorySequence()
	local playerRideState = Player.GetGameObjectIdIsRiddenToLocal()
	local rideHeli = 7168

	
	if TppMotherBaseManagement.IsBuiltMbMedicalClusterSpecialPlatform and
	   currentStorySequence < TppDefine.STORY_SEQUENCE.CLEARD_RESCUE_HUEY and
	   TppQuest.IsActive("sovietBase_q99020") == false then

	   
	   if not(TppRadio.IsPlayed("f2000_rtrg3005")) and not(playerRideState == rideHeli) and (svars.acceptMissionId == 0) then
			
			
		end
	end
end








function this.Messages()
	return
	StrCode32Table {
		Player = {
			{
				msg = "PlayerFultoned",
				func = function( )
					mvars.f30010_playerFultoned = true
				end,
				option = { isExecMissionClear = true },
			},
		},
		Radio = {
			{
				msg = "Finish",
				func = function( radioGroupNameHash )
					if not mvars.freePlay_ForceGoToMbRadioName then
						return
					end

					if radioGroupNameHash == Fox.StrCode32(mvars.freePlay_ForceGoToMbRadioName) then
						SubtitlesCommand.SetIsEnabledUiPrioStrong( false )	
						TppRadioCommand.SetEnableIgnoreGamePause( false )	
						TppSound.PostEventOnForceGotMbHelicopter()
						TppMission.MissionFinalize{ isNoFade = true, showLoadingTips = false }
					end
				end,
				option = { isExecMissionClear = true },
			},
		},
		Block = {
			{
				msg = "OnChangeLargeBlockState",
				func = function( blockName , state)
					
					if state == StageBlock.INACTIVE then
						this.OnCheckMBReturnRadio()
					end
				end,
			},
		},
		UI = {
			{
				msg = "StartMissionTelopFadeIn", 	func = function()
					DemoDaemon.SkipAll()
				end,
				option = { isExecDemoPlaying = true, isExecMissionClear = true }
			},
			nil
		},
		Timer = {
			
			{
				msg = "Finish",	sender = "Timer_LoadOpeningDemoBlock",
				func = f30010_demo.LoadOpeningDemoBlock,
				option = { isExecMissionClear = true },
			},
			{
				msg = "Finish",	sender = "Timer_StartMissionGamEndOnOpeningDemo",
				func = function()
					TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED }
				end,
				option = { isExecMissionClear = true },
			},
		},
		Trap = {
			{	
				msg = "Enter",
				sender = "trap_Start_s10050_QuietQuest",
				func = function()
					local isBossQuietQuestOpen = TppStory.IsOccuringBossQuiet()	
					if isBossQuietQuestOpen then
						Fox.Log("### BossQuietMission Load ###")
						TppMission.ReserveMissionClear{ nextMissionId = 10050 }
					end
				end,
			},
			{	
				msg = "Enter",
				sender = "trap_BossQuiet_QuestAcitivate_1",
				func = function()
					if (this.IsQuietQuestOK()) then
						this.RequestActiveForBossQuiet("trap_1/Enter")
					end
				end,
			},
			{	
				msg = "Exit",
				sender = "trap_BossQuiet_QuestAcitivate_1",
				func = function()
					if (this.IsQuietQuestOK()) then
						this.RequestActiveForBossQuiet("trap_1/Exit")
					end
				end,
			},
			{	
				msg = "Enter",
				sender = "trap_BossQuiet_QuestAcitivate_2",
				func = function()
					if (this.IsQuietQuestOK()) then
						
						if not(mvars.q99010_questActive) then
							
							this.RequestActiveForBossQuiet("trap_2/Enter")
							
							
							Fox.Log("######### f30010_sequence:Message::trap_BossQuiet_QuestInsurance ######### waterway_q99010 / !!!NOT ACTIVE!!! waiting activation...")
							mvars.f30010_trapInBeforeQuestActive = true
							TppMain.EnablePause()
						end
					end
				end,
			},
		},
		Terminal = {
			{
				msg = "MbDvcActAcceptMissionList", func = this.AcceptMission,
			},
		},
		MotherBaseManagement = {
			{
				msg = "CompletedPlatform",
				func = function( base, cluster, grade )
					if TppStory.IsCompletedMbMedicalSpecialPlatform( base, cluster, grade ) then
						local isBossQuietQuestOpen = TppStory.IsOccuringBossQuiet()	
						if isBossQuietQuestOpen then
							f30010_radio.BossQuiet_announce()
						end
					end
				end,
			},
		},
		GameObject = {
			{	
				msg = "HeliDoorClosed", sender = "SupportHeli",
				func = function ()
					Fox.Log("Mission clear : on Heli")
					
					TppMission.ReserveMissionClear{
						missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,
						nextMissionId = TppDefine.SYS_MISSION_ID.AFGH_HELI,
					}
				end
			},
			{	
				msg =	"ChangePhase",
				func = function( cpId, phase )
					
					if cpId == GameObject.GetGameObjectId("afgh_powerPlant_cp") then
						Fox.Log( "**** s30010_sequence.ChangePhase::powerPlant ****"..phase )
						if phase == TppGameObject.PHASE_ALERT or phase == TppGameObject.PHASE_EVASION then
							Gimmick.EnableAlarmLampAll(true)	
						else
							Gimmick.EnableAlarmLampAll(false)
						end
					end
				end
			},
			{	
				msg = "BreakGimmick",
				func = function( gameObjectId, locatorName, upperLocatorName )
					local gimmickBreakSetting = gimmickBreakSettingTable[locatorName]
					if gimmickBreakSetting then
						local svarsFlagName = svars[gimmickBreakSetting.svarsFlagName]
						if svarsFlagName == false then
							if svars.isBrokenGimmick_MissionClear == false then
								
								gvars.s10043_forceMissionClear = true
							end
						end
					end
				end
			},
			{	
				msg = "BuddyPuppyFind",
				func = function( gameObjectId )
					Fox.Log( "**** s30010_sequence::BuddyPuppyFind ****" )
					if not TppRadio.IsPlayed("f1000_rtrg5040") then
						TppRadio.Play("f1000_rtrg5040", { delayTime = "long", isEnqueue = true } )
					end
				end
			},
			{	
				msg = "Damage",
				func = function( gameObjectId, attackId, attakerId )
					local puppyId = GameObject.GetGameObjectId("TppBuddyPuppy", "anml_BuddyPuppy_00")
					if puppyId ~= nil then
						if gameObjectId == puppyId and Tpp.IsPlayer( attakerId ) then
							Fox.Log( "**** s30010_sequence::Puppy Damaged by Player ****" )
							TppRadio.Play("f1000_rtrg5060", { delayTime = "short", } )
						end
					end
				end
			},
			{	
				msg = "Dead",
				func = function( gameObjectId, attakerId, attackId )
					local puppyId = GameObject.GetGameObjectId("TppBuddyPuppy", "anml_BuddyPuppy_00")
					if puppyId ~= nil then
						if gameObjectId == puppyId and Tpp.IsPlayer( attakerId ) then
							Fox.Log( "**** s30010_sequence::Puppy Dead ****" )
							TppRadio.Play("f1000_rtrg5070", { delayTime = "short", } )
						end
					end
				end
			},
			{	
				msg = "Fulton",
				func = function( gameObjectId, animaiId, arg2 )
					local puppyId = GameObject.GetGameObjectId("TppBuddyPuppy", "anml_BuddyPuppy_00")
					if puppyId ~= nil then
						if gameObjectId == puppyId then
							Fox.Log( "**** s30010_sequence::Puppy Fulton ****" )
							TppRadio.Play("f1000_rtrg5050", { delayTime = "long", isEnqueue = true } )
						end
					end
				end
			},
		},
	}
end




this.IsQuietQuestOK = function()
	if(TppQuest.IsActive("waterway_q99010") and TppQuest.IsOpen( "waterway_q99010" ) and not(TppQuest.IsCleard( "waterway_q99010" )))then
		return true
	end
	return false
end


this.RequestActiveForBossQuiet =function(place)
	if ( TppQuest.GetQuestBlockState() == ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE ) then
		return 
	end
	Fox.Log("######### f30010_sequence:Message::trap_QuietShoot_Insurance ######### waterway_q99010 / Insurance processing! ["..tostring(place).."]")
	TppQuest.OnUpdateSmallBlockIndex(Tpp.GetCurrentStageSmallBlockIndex())
	TppQuest.InitializeQuestActiveStatus()
	TppScriptBlock.Load( "animal_block", "waterway_I_Quiet", true )
end






sequences.Seq_Game_FreePlay = {

	Messages = function( self ) 
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeIn", sender = "FadeInOnGameStart",
					func = function()
						if TppSequence.IsHelicopterStart() then
							TppTerminal.ShowLocationAndBaseTelopForStartFreePlay()
						end
					end,
				},
				nil
			},
			nil
		}
	end,

	OnEnter = function()
		Fox.Log("######## Seq_Game_FreePlay.OnEnter ########")

		
		TppRadio.SetOptionalRadio( "Set_f2000_oprg0010" )

		Fox.Log("########     Free Heli Radio    ############")
		TppFreeHeliRadio.OnEnter()

		
		if TppQuest.IsActive( "waterway_q99010" ) then
			Fox.Log("######## BossQuiet Event is Active, Lock DeliveryStation ############")
			
			TppUiCommand.RegisterDisableDeliveryStation{ stationId = TppCollection.GetUniqueIdByLocatorName( "col_stat_sovietBase" ) }
			TppUiCommand.RegisterDisableDeliveryStation{ stationId = TppCollection.GetUniqueIdByLocatorName( "col_stat_powerPlant" ) }
		else
			TppUiCommand.UnRegisterDisableDeliveryStation{ stationId = TppCollection.GetUniqueIdByLocatorName( "col_stat_sovietBase" ) }
			TppUiCommand.UnRegisterDisableDeliveryStation{ stationId = TppCollection.GetUniqueIdByLocatorName( "col_stat_powerPlant" ) }
		end

	end,

	OnLeave = function()
		TppFreeHeliRadio.OnLeave()
	end,
}


sequences.Seq_Demo_RecoverVolgin = {

	OnEnter = function()
		Fox.Log("######## Seq_Demo_RecoverVolgin.OnEnter ########")

		local startFunc = function()
			if TppLocation.GetLocalMbStageClusterGrade( TppDefine.CLUSTER_DEFINE.Develop + 1 ) < 2 then 
				TppMotherBaseManagement.SetClusterSvars{ base="MotherBase", category="Develop", grade=2, buildStatus="Completed",timeMinute=0,isNew=false }
			end
		end
		local endFunc = function()
			gvars.qst_volginQuestCleared = true
			TppMission.ReserveMissionClear{
				nextMissionId = 30250,
				nextClusterId = 7,
				missionClearType = TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR
			}
		end
		f30010_demo.PlayRecoverVolgin( startFunc, endFunc )

	end,

	OnLeave = function()

	end,
}




return this
