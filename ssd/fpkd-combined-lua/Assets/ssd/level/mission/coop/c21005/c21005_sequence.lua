local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.sequences = {}




this.INITIAL_CAMERA_ROTATION = { 20, 90, }
this.MISSION_WORLD_CENTER = Vector3( 0, 1000, 0 )




this.RETURN_BASE_POSITION = {
	afgh = Vector3( -442.0, 288.0, 2239.0 ),
}
this.RETURN_BASE_ROTY = {
	afgh = -90,
}
this.RETURN_BASE_CAMERA_ROTY = {
	afgh = -90,
}
this.MATCHING_ROOM_POSITION = Vector3( -23, 1000.8, 4.15 )
this.MATCHING_ROOM_ROTY = 90.0
this.MATCHING_ROOM_CAMERA_ROTY = 0.0


this.INITIAL_INFINIT_OXYGEN  = true

this.INITIAL_IGNORE_HUNGER = true

this.INITIAL_IGNORE_THIRST = true

this.ReturnToBase = function( location )
	if mvars.ply_deliveryWarpState == TppPlayer.DELIVERY_WARP_STATE.START_WARP then
		Fox.Error( "Can't Exec WarpCommand" )
		return
	end

	local warpPos = Vector3( vars.playerPosX, vars.playerPosY, vars.playerPosZ )
	local rotY = vars.playerRotY
	local locationName = TppLocation.GetLocationName()

	if location == locationName then
		if this.RETURN_BASE_POSITION[locationName] then
			warpPos = this.RETURN_BASE_POSITION[locationName]
			rotY = this.RETURN_BASE_ROTY[locationName]
		end
		this.RequestWarp( warpPos, rotY )
	else
		local locCode = TppDefine.LOCATION_ID[location]
		if not locCode then
			Fox.Error( "UnKnown Location / " .. tostring(location) )
			return
		end
		if locCode == TppDefine.LOCATION_ID.AFGH then
			locCode = TppDefine.LOCATION_ID.SSD_AFGH
		end

		if this.RETURN_BASE_POSITION[location] then
			warpPos = this.RETURN_BASE_POSITION[location]
			rotY = this.RETURN_BASE_ROTY[locationName]
		end
		local pos = TppMath.Vector3toTable( warpPos )
		TppPlayer.SetInitialPosition( pos, rotY )
		TppMission.Reload {
			locationCode = locCode,
			showLoadingTips = false,
		}
	end

	TppGameStatus.Set( "MatchingRoom", "S_IN_BASE_ON_MATCHING" )
	return true
end

this.ReturnToMatchingRoom = function()
	if mvars.ply_deliveryWarpState == TppPlayer.DELIVERY_WARP_STATE.START_WARP then
		Fox.Error( "Can't Exec WarpCommand" )
		return
	end
	TppGameStatus.Reset( "MatchingRoom", "S_IN_BASE_ON_MATCHING" )
	this.RequestWarp( this.MATCHING_ROOM_POSITION, this.MATCHING_ROOM_ROTY ) 
end








function this.OnLoad()
	Fox.Log( "c21005_sequence.OnLoad()" )

	TppSequence.RegisterSequences{
		"Seq_Game_SwitchSequence",
		"Seq_Game_ExplainGeneral",	
		"Seq_Game_Tips_General",	
		"Seq_Game_ExplainCraftBoard",	
		"Seq_Game_Tips_Craft",	
		"Seq_Game_AfterCraftTips",
		"Seq_Game_ExplainAcceptMission",	
		"Seq_Game_ExplainMatching",	
		"Seq_Game_Tips_Matching",	
		"Seq_Game_ExplainSortie",	
		"Seq_Game_ExplainNextMission",
		nil
	}
	TppSequence.RegisterSequenceTable( this.sequences )
end





this.saveVarsList = {
	nil,
}


this.checkPointList = {
	nil
}







this.missionObjectiveDefine = {
	marker_craftBoard = {
		gameObjectName = "marker_craftBoard", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true, announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_missionAccept = {
		gameObjectName = "marker_missionAccept", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true, announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_sortie = {
		gameObjectName = "marker_sortie", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true, announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_disable_all = {
	},
}











this.missionObjectiveTree = {
	marker_disable_all = {
		marker_sortie = {
			marker_missionAccept = {
				marker_craftBoard = {},
			},
		},
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"marker_craftBoard",
	"marker_missionAccept",
	"marker_sortie",
	"marker_disable_all",
}








function this.MissionPrepare()
	Fox.Log( "c21005_sequence.MissionPrepare()" )
	this.RegiserMissionSystemCallback()

	
	FogWallController.SetEnabled( false )

	
	
	Mission.SetCoopLobbyEnabled( true )
end

function this.OnTerminate()
	Fox.Log( "c21005_sequence.OnTerminate()" )

	
	FogWallController.SetEnabled( true )
	TppGameStatus.Reset( "MatchingRoom", "S_IN_BASE_ON_MATCHING" )
	TppGameStatus.Reset( "MatchingRoom", "S_DISABLE_PLAYER_DAMAGE" )
	
	if Fox.GetDebugLevel() >= Fox.DEBUG_LEVEL_QA_RELEASE then
		DebugMatchingMenuSystem.Close()
	end

	
	TppClock.Start()
end

this.RegiserMissionSystemCallback = function()
	Fox.Log( "c21005_sequence.RegiserMissionSystemCallback()" )
	
	local systemCallbackTable ={
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
			TppMission.MissionFinalize{ isNoFade = true }
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		nil
	}

	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )
end




function this.OnRestoreSVars()
	Fox.Log( "c21005_sequence.OnRestoreSVars()" )
end

function this.OnEndMissionPrepareSequence()
	Fox.Log("c21005_sequence.OnEndMissionPrepare")
	
	Gimmick.InvincibleGimmickData( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "com_mchn_l001_vrtn001_gim_i0000|TppPermanentGimmick_mtbs_mchn015_vrtn002", "/Assets/ssd/level/mission/coop/c21005/c21005_gimmick.fox2", true )
	Gimmick.InvincibleGimmickData( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "ssde_gate001_gim_i0000|TppPermanentGimmick_ssde_gate001", "/Assets/ssd/level/mission/coop/c21005/c21005_gimmick.fox2", true )
	Gimmick.InvincibleGimmickData( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "ssde_gate002_gim_i0000|TppPermanentGimmick_ssde_gate002", "/Assets/ssd/level/mission/coop/c21005/c21005_gimmick.fox2", true )
	Gimmick.InvincibleGimmickData( TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE, "ssde_mchn001_gim_i0000|TppPermanentGimmick_ssde_mchn001", "/Assets/ssd/level/mission/coop/c21005/c21005_gimmick.fox2", true )
	
	TppGameStatus.Reset( "MatchingRoom", "S_DISABLE_PLAYER_DAMAGE" )

	
	TppClock.SetTime("18:00:00")
	TppClock.Stop()
end






function this.RequestWarp( pos, rotY ) 
	mvars.c21005_warpPos = pos
	mvars.c21005_warpRotY = rotY
	TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)
end

function this.WarpPlayer() 
	if mvars.c21005_warpPos then
		local gameObjectId = { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }
		local command = { id = "WarpAndWaitBlock", pos = mvars.c21005_warpPos, rotY = mvars.c21005_warpRotY , unrealize = true }
		GameObject.SendCommand( gameObjectId, command )
	end
end




function this.Messages()
	return StrCode32Table {
		UI = {
			{	
				msg = "FacilityListMenuReturnToAfghPreparationSelected",
				func = function( )
					Fox.Log("Return to Afgh base to get ready")
					this.ReturnToBase( "afgh" )
				end
			},
			{	
				msg = "FacilityListMenuReturnToAfghSingleSelected",
				func = function()
					Fox.Log("Return to Afgn base for single mode")
					TppMission.AbandonCoopLobbyMission( TppDefine.SYS_MISSION_ID.AFGH_FREE )
				end				
			},
			{	
				msg = "AiPodMenuMoveToAssemblyPointSelected",
				func = function()
					Fox.Log("Return to coop lobby from base")
					this.ReturnToMatchingRoom()
				end
			},
			{
				msg = "EndFadeIn",
				func = function()
					
				end
			},
			{
				msg = "EndFadeOut",
				func = function()
					
					this.WarpPlayer()
				end
			},
		},
		Player = {
			{
				msg = "WarpEnd",
				func = function()
					
					GkEventTimerManager.Start( "WaitCameraMoveEnd", 0.5 )
					
					Player.RequestToSetCameraRotation{rotX =10 , rotY = mvars.c21005_warpRotY}
					Fox.Log("rotY:"..tostring(mvars.c21005_warpRotY) )
					
					mvars.c21005_warpPos = nil
					mvars.c21005_warpRotY = nil
					mvars.c21005_warpCameraRotY = nil
				end,
			}
		},
		Timer = {
			{
				msg = "Finish",
				sender = "WaitCameraMoveEnd",
				func = function ( )
					
					TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)
				end,
			},
		},
	}
end


function this.OnUpdate()
	if Tpp.IsMaster() then
		return
	end

	
	
	local isSet = TppGameStatus.IsSet( "MatchingRoom", "S_IN_BASE_ON_MATCHING" )
	if not isSet then
		if mvars.qaDebug.returnToAfghBase then
			this.ReturnToBase( "afgh" )
			mvars.qaDebug.returnToAfghBase = false
		elseif mvars.qaDebug.returnToMafrBase then
			this.ReturnToBase( "mafr" )
			mvars.qaDebug.returnToMafrBase = false
		end
		mvars.qaDebug.returnToMatchingRoom = false
	else
		if mvars.qaDebug.returnToMatchingRoom then
			this.ReturnToMatchingRoom()
			mvars.qaDebug.returnToMatchingRoom = false
		end
		mvars.qaDebug.returnToAfghBase = false
		mvars.qaDebug.returnToMafrBase = false
	end
end





this.sequences.Seq_Game_SwitchSequence = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Demo_SwitchSequence.OnEnter(): self:" .. tostring( self ) )

		local currentStorySequence = TppStory.GetCurrentStorySequence()

		local nextSequenceName
		if currentStorySequence >= TppDefine.STORY_SEQUENCE.CLEARED_COOP_AREA_1 then
			nextSequenceName = "Seq_Game_ExplainNextMission"
		else
			nextSequenceName = "Seq_Game_ExplainGeneral"
		end

		TppSequence.SetNextSequence( nextSequenceName )
	end,

	OnLeave = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Demo_SwitchSequence.OnLeave(): self:" .. tostring( self ) )
	end,
}

this.sequences.Seq_Game_ExplainGeneral = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainGeneral.OnEnter(): self:" .. tostring( self ) )

		
		TppUiStatusManager.SetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_10", "SsdUiCoopTutorial" )

		c21005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_WaitExplainGeneralRadio", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainGeneral.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_Tips_General" )
						GkEventTimerManager.Stop( "Timer_WaitExplainGeneralRadio" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_WaitExplainGeneralRadio",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_WaitExplainGeneralRadio", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Tips_General" )
						end
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_General = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_General.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsRadio = "Seq_Game_Tips_General",
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_ExplainCraftBoard" )
			end,
		}
	end,
}

this.sequences.Seq_Game_ExplainCraftBoard = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainCraftBoard.OnEnter(): self:" .. tostring( self ) )

		
		TppUiStatusManager.UnsetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_10", "SsdUiCoopTutorial" )
		TppUiStatusManager.SetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_20", "SsdUiCoopTutorial" )

		c21005_radio.PlaySequenceRadio()

		TppMission.UpdateObjective{ objectives = { "marker_craftBoard" }, }
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainCraftBoard.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			UI = {
				{
					msg = "WarehouseMenuOpened",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_Tips_Craft" )
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_Craft = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_Craft.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsRadio = "Seq_Game_Tips_Craft",
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_AfterCraftTips" )
			end,
		}
	end,
}

this.sequences.Seq_Game_AfterCraftTips = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_AfterCraftTips.OnEnter(): self:" .. tostring( self ) )

		c21005_radio.PlaySequenceRadio()
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_AfterCraftTips.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			UI = {
				{
					msg = "WarehouseMenuClosed",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_ExplainAcceptMission" )
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_ExplainAcceptMission = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainAcceptMission.OnEnter(): self:" .. tostring( self ) )

		
		TppUiStatusManager.UnsetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_20", "SsdUiCoopTutorial" )
		TppUiStatusManager.SetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_30", "SsdUiCoopTutorial" )

		c21005_radio.PlaySequenceRadio()

		TppMission.UpdateObjective{ objectives = { "marker_missionAccept" }, }
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainAcceptMission.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			UI = {
				{
					msg = "CoopMissionListMenuAcceptedMission",
					func = function( nextMissionId )
						TppSequence.SetNextSequence( "Seq_Game_ExplainMatching" )
					end
				},
			},
		}
	end,
}

this.sequences.Seq_Game_ExplainMatching = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainMatching.OnEnter(): self:" .. tostring( self ) )

		c21005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_WaitExplainMatchingRadio", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainMatching.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_Tips_Matching" )
						GkEventTimerManager.Stop( "Timer_WaitExplainMatchingRadio" )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_WaitExplainMatchingRadio",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_WaitExplainMatchingRadio", 1 )
						else
							TppSequence.SetNextSequence( "Seq_Game_Tips_Matching" )
						end
					end,
				},
			},
		}
	end,
}

this.sequences.Seq_Game_Tips_Matching = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_Tips_Matching.OnEnter(): self:" .. tostring( self ) )

		TppTutorial.StartHelpTipsMenu{
			tipsRadio = "Seq_Game_Tips_Matching",
			tipsTypes = { HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C, },
			endFunction = function()
				TppSequence.SetNextSequence( "Seq_Game_ExplainSortie" )
			end,
		}
	end,
}

this.sequences.Seq_Game_ExplainSortie = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainSortie.OnEnter(): self:" .. tostring( self ) )

		
		TppUiStatusManager.UnsetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_30", "SsdUiCoopTutorial" )
		TppUiStatusManager.SetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_40", "SsdUiCoopTutorial" )

		c21005_radio.PlaySequenceRadio()

		TppMission.UpdateObjective{ objectives = { "marker_sortie" }, }
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainSortie.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			UI = {
				{	
					msg = "StartCoopMissionFromLobby",
					func = function( needHostMigration )
						Fox.Log("Call Start CoopMission!")

						TppUiStatusManager.UnsetStatus( "SsdUiCoopTutorial", "COOP_TUTORIAL_40", "SsdUiCoopTutorial" )

						TppMission.UpdateObjective{ objectives = { "marker_disable_all" }, }

						TppMission.ReserveMissionClear{
							missionClearType = TppDefine.MISSION_CLEAR_TYPE.CYPRUS_GOAL,
							nextMissionId = 20005,
						}
					end
				},
			},
			Trap = {
				{
					sender = "trap_goal",
					msg = "Enter",
					func = function( trapBodyHandle, moverInstanceIndex )
						Fox.Log( "c21005_sequence.Messages(): sender:trap_goal, msg:Enter" ) 
						Fox.Log( "trapBodyHandle" .. tostring(trapBodyHandle) .. " moverId:" .. tostring(moverInstanceIndex) )
						if moverInstanceIndex == PlayerInfo.GetLocalPlayerIndex() then
							Mission.SetIsReadySortieCoopMission( true )
						end
					end
				},
				{
					sender = "trap_goal",
					msg = "Exit",
					func = function( trapBodyHandle, moverInstanceIndex )
						Fox.Log( "c21005_sequence.Messages(): sender:trap_goal, msg:Exit" )
						if moverInstanceIndex == PlayerInfo.GetLocalPlayerIndex() then
							Mission.SetIsReadySortieCoopMission( false )
						end
					end
				},
			},
		}
	end,
}

this.sequences.Seq_Game_ExplainNextMission = {
	OnEnter = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainMatching.OnEnter(): self:" .. tostring( self ) )

		c21005_radio.PlaySequenceRadio()
		GkEventTimerManager.Start( "Timer_WaitExplainMatchingRadio", 10 )
	end,

	Messages = function( self )
		Fox.Log( "c21005_sequence.sequences.Seq_Game_ExplainMatching.Messages(): self:" .. tostring( self ) )
		return StrCode32Table{
			Radio = {
				{
					msg = "Finish",
					func = function()
						GkEventTimerManager.Stop( "Timer_WaitExplainMatchingRadio" )
						TppMission.ReserveMissionClear{
							missionClearType = TppDefine.MISSION_CLEAR_TYPE.CYPRUS_GOAL,
							nextMissionId = 21010,
						}
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_WaitExplainMatchingRadio",
					msg = "Finish",
					func = function()
						if TppRadioCommand.IsPlayingRadio() then
							GkEventTimerManager.Start( "Timer_WaitExplainMatchingRadio", 1 )
						else
							TppMission.ReserveMissionClear{
								missionClearType = TppDefine.MISSION_CLEAR_TYPE.CYPRUS_GOAL,
								nextMissionId = 30010,
							}
						end
					end,
				},
			},
		}
	end,
}




return this
