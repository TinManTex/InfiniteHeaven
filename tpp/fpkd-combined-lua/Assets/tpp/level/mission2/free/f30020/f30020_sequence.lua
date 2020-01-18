local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}

this.requires = {
	"/Assets/tpp/level/mission2/free/f30020/f30020_orderBoxList.lua",
}


this.DEBUG_strCode32List = {

}

this.MAX_PICKABLE_LOCATOR_COUNT = 100

this.MAX_PLACED_LOCATOR_COUNT = 220	

this.NO_MISSION_TELOP_ON_START_HELICOPTER = true 

this.NO_RESULT = true












function this.OnLoad()
	Fox.Log("#### OnLoad ####")	

	TppSequence.RegisterSequences{
		
		"Seq_Game_FreePlay",
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end





this.saveVarsList = {
	acceptMissionId = 0
}


this.checkPointList = {
	"CHK_banana",
	"CHK_diamond",
	"CHK_factory",
	"CHK_flowStation",
	"CHK_hill",
	"CHK_lab",
	"CHK_outland",
	"CHK_pfCamp",
	"CHK_savannah",
	"CHK_swamp",
}


this.baseList = {
	"outlandNorth",
	"swampEast",
	"swampWest",
	"outlandEast",
	"bananaSouth",
	"swampSouth",
	"swampEast",
	"savannahWest",
	"bananaEast",
	"savannahNorth",
	"diamondWest",
	"diamondSouth",
	"hillNorth",
	"savannahEast",
	"hillWest",
	"pfCampEast",
	"pfCampNorth",
	"factorySouth",
	"factoryWest",
	"diamondNorth",
	"labWest",
	"outland",
	"flowStation",
	"swamp",
	"pfCamp",
	"savannah",
	"banana",
	"diamond",
	"hill",
	"factory",
	"lab",
	"hillWestNear",
	"hillSouth",
	"chicoVilWest",
	nil
}







this.missionObjectiveDefine = {
	default_none = {
	},
}

this.missionObjectiveTree = {
	default_none = {
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"default_none",
}

this.missionStartPosition = {
	orderBoxList = {
		"box_s10081_00",
		"box_s10082_00",
		"box_s10085_00",
		"box_s10085_01",
		"box_s10086_00",
		"box_s10090_00",
		"box_s10091_00",
		"box_s10093_00",
		"box_s10093_01",
		"box_s10093_02",
		"box_s10100_00",
		"box_s10100_01",
		"box_s10100_02",
		"box_s10110_00",
		"box_s10120_00",
		"box_s10121_00",
		"box_s10130_00",
		"box_s10171_00",
		"box_s10171_01",
		"box_s10195_00",
		"box_s10195_01",
		"box_s10200_00",
		"box_s10211_00",
		"box_s10211_01",
	},
	helicopterRouteList = {
	},
}





this.NPC_ENTRY_POINT_SETTING = {
        [Fox.StrCode32("lz_drp_hill_I0000|rt_drp_hill_I_0000")] = {
                [EntryBuddyType.VEHICLE] = { Vector3(2152.182, 55.992, 386.675), TppMath.DegreeToRadian( 80 ) }, 
                [EntryBuddyType.BUDDY] = { Vector3(2155.664, 55.679, 372.972), TppMath.DegreeToRadian( 60 ) }, 
        },
}









function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")
	
	
	this.RegiserMissionSystemCallback()
	
	TppScriptBlock.RegisterCommonBlockPackList( "orderBoxBlock", f30020_orderBoxList.orderBoxBlockList )
	
	
	TppRatBird.EnableBird( "TppCritterBird" )

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

end



function this.RegiserMissionSystemCallback()
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
				GkEventTimerManager.Start( "Timer_StartForceMBCamera", 0.1 ) 
				TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED, fadeDelayTime = 3.6 }
			else
				TppMission.MissionGameEnd()
			end
		end,
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			local orderBoxName = TppMission.FindOrderBoxName( gvars.mis_orderBoxName )
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO )
			and orderBoxName then
				TppMission.ShowMissionReward()
			else
				Player.SetPause()
				TppMission.ShowMissionReward()
			end
		end,
		OnEndMissionReward = function()
			local missionClearType = TppMission.GetMissionClearType()
			if ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO ) then
				f30020_demo.PlayOpening()
			elseif ( missionClearType == TppDefine.MISSION_CLEAR_TYPE.FORCE_GO_TO_MB_ON_SIDE_OPS_CLEAR ) then
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
	TppMission.AcceptMissionOnFreeMission( missionId, f30020_orderBoxList.orderBoxBlockList, "acceptMissionId" )
end








function this.Messages()
	return
	StrCode32Table {
		Player = {
			{
				msg = "PlayerFultoned",
				func = function( )
					mvars.f30020_playerFultoned = true
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
				func = f30020_demo.LoadOpeningDemoBlock,
				option = { isExecMissionClear = true },
			},
			{
				msg = "Finish",	sender = "Timer_StartMissionGamEndOnOpeningDemo",
				func = function()
					TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED }
				end,
				option = { isExecMissionClear = true },
			},
			{
				msg = "Finish", sender = "Timer_StartForceMBCamera",
				func = function()
					Fox.Error("Start Force MB Camera")
					if not mvars.f30020_playerFultoned then 
						this._ForceMBCamera()
					end
				end,
				option = { isExecMissionClear = true },
			},
		},
		Terminal = {
			{
				msg = "MbDvcActAcceptMissionList", func = this.AcceptMission,
			},
		},
		Trap = {
			{
				msg = "Enter",	sender = "trap_FreePlay_area01",
				func = function()
					Fox.Log("### trap_FreePlay_area01 Enter ###")
					f30020_enemy.UpdateOutOfAreaSetting( 1 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area02",
				func = function()
					Fox.Log("### trap_FreePlay_area02 Enter ###")
					f30020_enemy.UpdateOutOfAreaSetting( 2 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area03",
				func = function()
					Fox.Log("### trap_FreePlay_area03 Enter ###")
					f30020_enemy.UpdateOutOfAreaSetting( 3 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area04",
				func = function()
					Fox.Log("### trap_FreePlay_area04 Enter ###")
					f30020_enemy.UpdateOutOfAreaSetting( 4 )
				end,
				option = { isExecMissionPrepare = true }
			},
			{
				msg = "Enter",	sender = "trap_FreePlay_area05",
				func = function()
					Fox.Log("### trap_FreePlay_area05 Enter ###")
					f30020_enemy.UpdateOutOfAreaSetting( 5 )
				end,
				option = { isExecMissionPrepare = true }
			},
			
			{
				msg = "Enter",
				sender = "Trap_Mist_ON",
				func = function ()
					
					WeatherManager.RequestTag("factory_fog", 8 )
					TppWeather.RequestWeather( TppDefine.WEATHER.FOGGY, 10, { fogDensity=0.00, fogType=WeatherManager.FOG_TYPE_EERIE, } )
				end				
			},
			{
				msg = "Enter",
				sender = "Trap_Mist2_ON",
				func = function ()
					
					WeatherManager.RequestTag("factory_fog", 0 )
					TppWeather.RequestWeather( TppDefine.WEATHER.FOGGY, 5, { fogDensity=0.03, fogType=WeatherManager.FOG_TYPE_EERIE, } )
				end				
			},
			{
				msg = "Enter",
				sender = "Trap_Mist_OFF",
				func = function ()
					
					WeatherManager.RequestTag("default", 8 )
					TppWeather.CancelRequestWeather( TppDefine.WEATHER.CLOUDY, 5 )
				end				
			},
			{
				msg = "Enter",
				sender = "Trap_MistTag",
				func = function ()
					
					WeatherManager.RequestTag("factory_fog", 0 )
					TppWeather.RequestWeather( TppDefine.WEATHER.FOGGY, 5, { fogDensity=0.00, fogType=WeatherManager.FOG_TYPE_EERIE, } )
				end,
				option = { isExecMissionPrepare = true }
			},
		},
		GameObject = {
			{	
				msg = "HeliDoorClosed", sender = "SupportHeli",
				func = function ()
					Fox.Log("Mission clear : on Heli")
					
					TppMission.ReserveMissionClear{
						missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,
						nextMissionId = TppDefine.SYS_MISSION_ID.MAFR_HELI,
					}
				end
			},
		}
	}
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
			GameObject = {
				{	
					msg = "HeliDoorClosed", sender = "SupportHeli",
					
					func = function ()
						Fox.Log("Mission clear : on Heli")
						
						TppMission.ReserveMissionClear{
							missionClearType = TppDefine.MISSION_CLEAR_TYPE.RIDE_ON_HELICOPTER,
							nextMissionId = TppDefine.SYS_MISSION_ID.MAFR_HELI,
						}
					end
				},
				nil
			},
			nil
		}
	end,

	OnEnter = function()
		Fox.Log("######## Seq_Game_FreePlay.OnEnter ########")
		
		TppRadio.SetOptionalRadio( "Set_f2000_oprg0010" )
		
		TppFreeHeliRadio.OnEnter()
	end,

	OnLeave = function()
		
		TppFreeHeliRadio.OnLeave()
	end,
}




return this
