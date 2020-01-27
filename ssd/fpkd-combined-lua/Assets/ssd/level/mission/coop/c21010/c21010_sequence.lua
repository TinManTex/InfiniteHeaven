local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

this.sequences = {}




this.INITIAL_CAMERA_ROTATION = { -5, 180, }
this.MISSION_WORLD_CENTER = Vector3( 0, 1000, 0 )



this.RETURN_BASE_POSITION = {
	afgh = Vector3( -444.451, 287.296, 2240.096 ),
	mafr = Vector3( 2862.977, 101.611, -906.474 ),
}
this.RETURN_BASE_ROTY = {
	afgh = -90,
	mafr = 90,
}


this.INITIAL_INFINIT_OXYGEN  = true

this.INITIAL_IGNORE_HUNGER = true

this.INITIAL_IGNORE_THIRST = true

this.INITIAL_IGNORE_FATIGUE = true

this.INITIAL_INFINITE_STAMINA = true


this.MISSION_START_INITIAL_WEATHER = TppDefine.WEATHER.SUNNY


this.KAKASHI_LIST = {
	"mafr_pllr004_gim_n10_0|srt_mafr_pllr004",
	"mafr_pllr004_gim_n10_1|srt_mafr_pllr004",
	"mafr_pllr004_gim_n10_2|srt_mafr_pllr004",
	"mafr_pllr004_gim_n15_0|srt_mafr_pllr004",
	"mafr_pllr004_gim_n15_1|srt_mafr_pllr004",
	"mafr_pllr004_gim_n15_2|srt_mafr_pllr004",
	"mafr_pllr004_gim_n20_0|srt_mafr_pllr004",
	"mafr_pllr004_gim_n20_1|srt_mafr_pllr004",
	"mafr_pllr004_gim_n20_2|srt_mafr_pllr004",
	"mafr_pllr004_gim_n25_0|srt_mafr_pllr004",
	"mafr_pllr004_gim_n25_1|srt_mafr_pllr004",
	"mafr_pllr004_gim_n25_2|srt_mafr_pllr004",
	"mafr_pllr004_gim_n30_0|srt_mafr_pllr004",
	"mafr_pllr004_gim_n30_1|srt_mafr_pllr004",
	"mafr_pllr004_gim_n30_2|srt_mafr_pllr004",
}


this.CRAFT_LIST = {
	"ssde_acce001_coop001_gim_n0000|srt_ssde_acce001_coop001",
	"ssde_ktch001_coop001_gim_n0000|srt_ssde_ktch001_coop001",
	"ssde_mdcn001_coop001_gim_n0000|srt_ssde_mdcn001_coop001",
	"ssde_wepn001_coop001_gim_n0000|srt_ssde_wepn001_coop001",
	"ssde_wepn003_coop001_gim_n0000|srt_ssde_wepn003_coop001",
}

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
			rotY = this.RETURN_BASE_ROTY[location]
		end

		local pos = TppMath.Vector3toTable( warpPos )
		TppPlayer.SetInitialPosition( pos, rotY )
		Fox.Log("Mission Reload for return to base")
		this.MissionReload(locCode)
		gvars.cLobby_isStartBase = true 
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

	local position, rotY = Tpp.GetLocator( "DataIdentifier_c21010_sequence", "Warp_MatchingRoom" )
	this.RequestWarp( position, rotY )
end

this.MissionReload = function( locationCode, showLoadingTips )
	mvars.c21010_missionReloaded = true
	TppMission.Reload{
		locationCode = locationCode,
		missionPackLabelName = "StagingArea",
		showLoadingTips = showLoadingTips,
	}
end








function this.OnLoad()
	Fox.Log( "c21010_sequence.OnLoad()" )

	local sequenceList = {
		"Seq_Demo_Select_MissionStartSequence",
		"Seq_Demo_GoToCoopMission_If_Already_Sortie",
		"Seq_Game_MainGame",
		"Seq_Game_Sortie",
		"Seq_Game_Sortie_Failed",
		"Seq_Game_Disconnected",
		nil
	}
	if title_sequence then
		sequenceList = title_sequence.AddTitleSequences(sequenceList)
		this.sequences = title_sequence.AddTitleSequenceTable(this.sequences)
	end
	TppSequence.RegisterSequences(sequenceList)
	TppSequence.RegisterSequenceTable(this.sequences)
end





this.saveVarsList = {
 nil,
}


this.checkPointList = {
	nil
}







this.missionObjectiveDefine = {
}











this.missionObjectiveTree = {
}

this.missionObjectiveEnum = Tpp.Enum{
}





function this.OnBuddyBlockLoad() 
	if title_sequence then
		title_sequence.OnBuddyBlockLoad()
	else
		TppPlayer.ResetInitialPosition()
	end
end




function this.MissionPrepare()
	Fox.Log( "c21010_sequence.MissionPrepare()" )
	if title_sequence then
		title_sequence.MissionPrepare()
		title_sequence.RegisterMissionGameSequenceName( "Seq_Game_MainGame" )
	end
	this.RegiserMissionSystemCallback()

	
	FogWallController.SetEnabled( false )
end

function this.OnTerminate()
	Fox.Log( "c21010_sequence.OnTerminate()" )

	if title_sequence then
		title_sequence.OnTerminate()
	end

	
	FogWallController.SetEnabled( true )
	TppGameStatus.Reset( "MatchingRoom", "S_IN_BASE_ON_MATCHING" )
	TppGameStatus.Reset( "MatchingRoom", "S_DISABLE_PLAYER_LIFE_DAMAGE" )
	
	if Fox.GetDebugLevel() >= Fox.DEBUG_LEVEL_QA_RELEASE then
		DebugMatchingMenuSystem.Close()
	end
end

this.RegiserMissionSystemCallback = function()
	Fox.Log( "c21010_sequence.RegiserMissionSystemCallback()" )

	local systemCallbackTable ={
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
			this.OnEndMission()
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		nil
	}

	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )
end

function this.OnEndMission()
		
		local nextMissionCode = Mission.GetCoopMissionCode()
		Fox.Log("SetNextMissionCode:" ..tostring(nextMissionCode) )
		
		if not TppMission.IsMultiPlayMission( nextMissionCode ) then
			nextMissionCode = TppMission.GetCoopLobbyMissionCode()
		end
		TppMission.SetNextMissionCodeForMissionClear(nextMissionCode)
		TppMission.MissionFinalize{ isNoFade = true }
end




function this.OnRestoreSVars()
	Fox.Log( "c21010_sequence.OnRestoreSVars()" )
	if title_sequence then
		title_sequence.OnRestoreSVars()
	else
		Player.RequestToAppearWithWormhole( 0.0 )
	end
	TppClock.SetTime("17:00:00")
end

function this.OnEndMissionPrepareSequence()
	Fox.Log("c21010_sequence.OnEndMissionPrepare")

	if title_sequence then
		this.SetupGimmick()
		title_sequence.OnEndMissionPrepareSequence()
		title_sequence.RegisterCallbackOnRestoreSvars(this._OnEndMissionPrepareSequence)
	else
		this._OnEndMissionPrepareSequence()
	end
end

function this.SetupGimmick()
	do 
		local isInvisible = true
		if Mission.IsOnShootingArea ~= nil and Mission.IsOnShootingArea() then
			isInvisible = false
		end
		for i, name in ipairs(this.KAKASHI_LIST) do
			Gimmick.InvisibleGimmick( -1, name, "/Assets/ssd/level/mission/coop/c21010/c21010_item.fox2", isInvisible, {gimmickId = "GIM_P_Ornament"} )
		end
	end

	do 
		local isInvisible = true
		if Mission.IsOnCraftArea ~= nil and Mission.IsOnCraftArea() then
			isInvisible = false
		end
		for i, name in ipairs(this.CRAFT_LIST) do
			Gimmick.InvisibleGimmick( -1, name, "/Assets/ssd/level/mission/common/mis_com_robby_stage.fox2", isInvisible, {gimmickId = "GIM_P_Ornament"} )
		end
	end
end

function this._OnEndMissionPrepareSequence()
	Player.SetWormholeFilterEnabled( TppGameStatus.IsSet( "MatchingRoom", "S_IN_BASE_ON_MATCHING" ) )
	MapInfoSystem.SetupInfos()

	
	Player.SetInfiniteAmmoFromScript( true )

	--RETAILPATCH: 1.0.12
  local missionCodeList = {
    20010,
    20110,
    20210,
    20610,
    20710,
  }
  for _, missionCode in ipairs( missionCodeList ) do
    TppStory.PermitMissionOpen( missionCode )
    TppStory.MissionOpen( missionCode )
  end

	
	Gimmick.InvisibleGimmick( -1, "ssde_boxx001_gim_n0000|srt_ssde_boxx001", "/Assets/ssd/level/mission/common/mis_com_robby_stage.fox2", false, {gimmickId = "GIM_P_Ornament"} )

	this.SetupGimmick()

	
	Mission.UnsetForceVoiceChatDisable()

	
	TppUI.SetCoopFullUiLockType()

	
	NamePlateMenu.SetBeginnerNamePlateIfTutorialUnfinied()
end







function this.RequestWarp( pos, rotY )
	mvars.c21010_warpPos = pos
	mvars.c21010_warpRotY = rotY
	TppUI.FadeOut(TppUI.FADE_SPEED.FADE_HIGHESTSPEED,"playerWarp")
end

function this.WarpPlayer()
	if mvars.c21010_warpPos then
		local gameObjectId = { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }
		local command = { id = "WarpAndWaitBlock", pos = mvars.c21010_warpPos, rotY = TppMath.DegreeToRadian(mvars.c21010_warpRotY) , unrealize = true }
		GameObject.SendCommand( gameObjectId, command )
	end
end

function this.ReturnToSingle( returnMission )
	if mvars.c21010_missionReloaded then
		return
	end
	local callbackFunc = function()
		TppMission.AbandonCoopLobbyMission( returnMission )
	end

	TppSave.AddServerSaveCallbackFunc( callbackFunc )
	SsdSaveSystem.SaveCoopLobbyEnd()
	Mission.SetCoopLobbyMissionAbort()
end





function this.ShowTips()
	Fox.Log( "c21010_sequence.ShowTips()" )

	local tipsAnnounceTableListTable = {	
		normal = {
			{
				tipsTypes = {
					HelpTipsType.TIPS_73_A, HelpTipsType.TIPS_73_B,					
					HelpTipsType.TIPS_86_A, HelpTipsType.TIPS_86_B,					
					HelpTipsType.TIPS_75_A, HelpTipsType.TIPS_75_B,					
					HelpTipsType.TIPS_85_A, HelpTipsType.TIPS_85_B,					
					HelpTipsType.TIPS_36_A, HelpTipsType.TIPS_36_B, HelpTipsType.TIPS_36_C,		
					HelpTipsType.TIPS_106_A, HelpTipsType.TIPS_106_B, HelpTipsType.TIPS_106_C,		
				},
			},
			{
				tipsTypes = {
					HelpTipsType.TIPS_72_A, HelpTipsType.TIPS_72_B, HelpTipsType.TIPS_72_C,		
					HelpTipsType.TIPS_76_A, HelpTipsType.TIPS_76_B, HelpTipsType.TIPS_76_C,		
					HelpTipsType.TIPS_80_A, HelpTipsType.TIPS_80_B, HelpTipsType.TIPS_80_C,		
					HelpTipsType.TIPS_81_A, HelpTipsType.TIPS_81_B,					
					HelpTipsType.TIPS_79_A, HelpTipsType.TIPS_79_B, HelpTipsType.TIPS_79_C,		
				},
			},
			{
				tipsTypes = {
					HelpTipsType.TIPS_67_A, HelpTipsType.TIPS_67_B, HelpTipsType.TIPS_67_C,		
					HelpTipsType.TIPS_34_B, HelpTipsType.TIPS_34_C,					
					HelpTipsType.TIPS_104_A, HelpTipsType.TIPS_104_B, HelpTipsType.TIPS_104_C,		
					HelpTipsType.TIPS_107_A, HelpTipsType.TIPS_107_B, HelpTipsType.TIPS_107_C,		
					HelpTipsType.TIPS_109_A, HelpTipsType.TIPS_109_B, HelpTipsType.TIPS_109_C,		
				},
			},
		},
		hard = {
			{
				tipsTypes = {
					HelpTipsType.TIPS_105_A, HelpTipsType.TIPS_105_B, HelpTipsType.TIPS_105_C,		
				},
			},
		}
	}

	local levelList = { "normal", }
	if TppStory.IsMissionOpen( 20020 ) then	
		table.insert( levelList, "hard" )
	end

	for i, level in ipairs( levelList ) do
		local tipsAnnounceTableList = tipsAnnounceTableListTable[ level ]
		if Tpp.IsTypeTable( tipsAnnounceTableList ) then
			for _, tipsAnnounceTable in ipairs( tipsAnnounceTableList ) do
				TppTutorial.StartHelpTipsMenuOnlyAnnounce( tipsAnnounceTable )
			end
		end
	end
end




function this.Messages()
	return StrCode32Table {
		UI = {
			{
				msg = "CoopMissionListMenuAcceptedMission",
				func = function( nextMissionCode )
					Fox.Log("Mission List Selected : Next Mission ID = " .. tostring(nextMissionCode) )
				end
			},
			{
				msg = "FacilityListMenuReturnToAfghPreparationSelected",
				func = function( )
					Fox.Log("Return to Afgh base to get ready")
					this.ReturnToBase( "afgh" )
				end
			},
			{
				msg = "FacilityListMenuReturnToMafrPreparationSelected",
				func = function()
					Fox.Log("Return to Mafr base to get ready")
					this.ReturnToBase( "mafr" )
				end
			},
			{
				msg = "FacilityListMenuReturnToAfghSingleSelected",
				func = function()
					Fox.Log("Return to Afgn base for single mode")
					this.ReturnToSingle( TppDefine.SYS_MISSION_ID.AFGH_FREE )
				end
			},
			{
				msg = "FacilityListMenuReturnToMafrSingleSelected",
				func = function( )
					Fox.Log("Return to mafr base for single mode")
					this.ReturnToSingle( TppDefine.SYS_MISSION_ID.MAFR_FREE )
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
				msg = "EndFadeOut",
				sender = "playerWarp",
				func = function()
					
					this.WarpPlayer()
				end
			},
			{
				msg = "StartCoopMissionFromLobby",
				func = function(isFailedForLimitLevel)
					Fox.Log("Reserve Mission Clear for Coop Mission Start" )
					if isFailedForLimitLevel ~= 0 then
						TppSequence.SetNextSequence("Seq_Game_Sortie_Failed")
						return
					end
					TppSequence.SetNextSequence("Seq_Game_Sortie")
				end
			},
			{ 
				msg = "StartShootingArea",
				func = function()
					for i, name in ipairs(this.KAKASHI_LIST) do
						Gimmick.ResetGimmick( -1, name, "/Assets/ssd/level/mission/coop/c21010/c21010_item.fox2",{gimmickId = "GIM_P_Ornament", needSpawnEffect = true, spawnDelayTime = 1.0+i*0.1} )
					end
				end,
			},
			{ 
				msg = "StartCraftArea",
				func = function()
					for i, name in ipairs(this.CRAFT_LIST) do
						Gimmick.ResetGimmick( -1, name, "/Assets/ssd/level/mission/common/mis_com_robby_stage.fox2",{gimmickId = "GIM_P_Ornament", needSpawnEffect = true, spawnDelayTime = 1.0+i*0.1} )
					end
				end,
			},
			{	
				msg = "EndFadeIn",
				sender = "StartMainGame",
				func = function()
					this.ShowTips()
				end,
			},
			{ 
				msg = "GoToCoopMatchingScreen",
				func = function()
					Fox.Log("Mission reload for Auto Match.")
					this.MissionReload(nil, false)
				end,
				option = { isExecMissionPrepare = true, isExecDemoPlaying = true, isExecFastTravel = true, }
			},
		},
		Network = {
			{
				msg = "FaildAutoMatch", 
				func = function()
					TppMission.AbandonMission()
				end,
			},
		},
		Player = {
			{
				msg = "WarpEnd",
				func = function()
					
					GkEventTimerManager.Start( "WaitCameraMoveEnd", 0.5 )
					
					Player.RequestToSetCameraRotation{rotX =10 , rotY = mvars.c21010_warpRotY}
					Fox.Log("rotY:"..tostring(mvars.c21010_warpRotY) )
					
					mvars.c21010_warpPos = nil
					mvars.c21010_warpRotY = nil
					mvars.c21010_warpCameraRotY = nil
				end,
			}
		},
		Timer = {
			{
				msg = "Finish",
				sender = "WaitCameraMoveEnd",
				func = function ( )
					Player.SetWormholeFilterEnabled( TppGameStatus.IsSet( "MatchingRoom", "S_IN_BASE_ON_MATCHING" ) )
					TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHESTSPEED)
				end,
			},
		},
		GameObject = {
			{	
				msg = "SwitchGimmick",
				func = function( gameObjectId, locatorName, upperLocatorName, on )

					Fox.Log( "c21010_sequence.Messages(): GameObject: SwitchGimmick: gameObjectId:" .. tostring( gameObjectId ) .. ", locatorName:" .. tostring( locatorName ) ..
						", upperLocatorName:" .. tostring( upperLocatorName ) .. ", on:" .. tostring( on ) )

					
					if locatorName == Fox.StrCode32( "com_mchn_l001_vrtn001_gim_n0000|srt_mtbs_mchn015_vrtn002" ) then
						if Fox.GetDebugLevel() >= Fox.DEBUG_LEVEL_QA_RELEASE then
							DebugMatchingMenuSystem.RequestOpen()
						end
					end
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





this.sequences.Seq_Game_MainGame = {
	OnEnter = function( self )
		Fox.Log( "c21010_sequence.sequences.Seq_Game_MainGame.OnEnter()" )
		
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.SUNNY, 0 )
		
		TppGameStatus.Set( "MatchingRoom", "S_DISABLE_PLAYER_LIFE_DAMAGE" )
		
		TppGameStatus.Reset( "TitleSequence", "S_DISABLE_PLAYER_PAD" )
		TppGameStatus.Reset( "TitleSequence", "S_DISABLE_GAME_PAUSE" )
		
		TppClock.Stop()
		
		self.SetBaseDiggerPowerOffIfAfgh()

		
		this.ShowTips()

		
		if title_sequence then	
			RewardPopupSystem.RequestOpen( RewardPopupSystem.OPEN_TYPE_ALL )
		else
			RewardPopupSystem.RequestOpen( RewardPopupSystem.OPEN_TYPE_CHECK_POINT )
		end
	end,
	OnUpdate = function()
		if Tpp.IsEditor() then
			return
		end
		
		if not SsdAutoMatching.IsBusy() then
			if (not TppNetworkUtil.IsSessionConnect()) and (not TppException.HasQueue()) then
				TppSequence.SetNextSequence("Seq_Game_Disconnected")
			end
		end
	end,
	Messages = function( self )
		return
		StrCode32Table {
			Network = {
				{
					msg = "SuccessJoinRoom",
					func = function()
						
						
						
						Fox.Log("Mission Reload for Success Join Room")
						this.MissionReload()
					end,
				},
				{
					msg = "SuccessLeaveRoom",
					func = function()
						
						
						Fox.Log("Mission Reload for Success Leave Room")
						this.MissionReload()
					end,
				},
			},
		}
	end,

	SetBaseDiggerPowerOffIfAfgh = function()
		if TppLocation.IsAfghan() then
			Fox.Log( "c21010_sequence.sequences.Seq_Game_MainGame.SetBaseDiggerPowerOffIfAfgh()" )
			local digger = TppGimmick.baseImportantGimmickList.afgh[4]
			Gimmick.SetSsdPowerOff{
				gimmickId = digger.gimmickId,
				name = digger.locatorName,
				dataSetName = digger.datasetName,
				powerOff	= true,
			}
		end
	end
}


this.sequences.Seq_Game_Disconnected = {
	OnEnter = function()
		Fox.Log( "c21010_sequence.sequences.Seq_GameDisconnected.OnEnter()" )
		
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.SESSION_ABANDON )
	end,
}


this.sequences.Seq_Game_Sortie = {
		Messages = function( self )
		return
		StrCode32Table {
			Timer = {
				{
					msg = "Finish",
					sender = "Timer_WaitMissionClear",
					func = function ( )
						this.OnEndMission()
					end,
				},
			},
		}
	end,
	OnEnter = function()
		
		if not TppGameStatus.IsSet( "", "S_IS_ONLINE" ) then
			TppMission.ReturnToTitle()
			return
		end

		local nextMissionCode = Mission.GetCoopMissionCode()
		Fox.Log("Call Start CoopMission! next mission : " ..tostring(nextMissionCode))

		TppMission.ReserveMissionClear{
			missionClearType = TppDefine.MISSION_CLEAR_TYPE.CYPRUS_GOAL,
			nextMissionId = nextMissionCode,
		}

		
		GkEventTimerManager.Start( "Timer_WaitMissionClear", 35 )
	end,
}


this.sequences.Seq_Game_Sortie_Failed ={
	OnEnter = function(self)
		Mission.OpenPopupSortieReadyFailed()
		self.isClosedPopup = false
		self.isOpenedPopup = false
	end,
	OnUpdate = function(self)
		if not self.isOpenedPopup then
			if TppUiCommand.IsShowPopup() then
				self.isOpenedPopup = true
				TppMission.DisconnectMatching(true) 
			end
			return
		end
		if not self.isClosedPopup then
			if not TppUiCommand.IsShowPopup() then
				self.isClosedPopup = true
				TppMission.AbandonMission()
			end
		end
	end,
}



this.sequences.Seq_Demo_Select_MissionStartSequence = {
	OnEnter = function()
		if title_sequence then
			TppSequence.SetNextSequence("Seq_Demo_StartHasTitleMission")
		else
			TppSequence.SetNextSequence("Seq_Demo_GoToCoopMission_If_Already_Sortie")
		end
	end,
}


this.sequences.Seq_Demo_GoToCoopMission_If_Already_Sortie = {
	OnEnter = function( self )
		TppMain.EnableGameStatus()
		if not TppNetworkUtil.IsSessionConnect() then 
			if Tpp.IsEditor() then
				
				self.GoToNextSequence()
				return
			end
			TppException.OnSessionDisconnectFromHost()
		elseif Mission.IsJoinedCoopRoom() then
			local nextMissionCode = Mission.GetCoopMissionCode()
			if Mission.IsSortiedCoopMission() and TppMission.IsCoopMission(nextMissionCode) then 
				
				TppMission.SetNextMissionCodeForMissionClear(nextMissionCode)
				TppMission.ExecuteMissionFinalize{showLoadingTips = true}
				Fox.Log("Is Alady Sortie members. Goto Coop Mission : !" .. tostring(nextMissionCode) )
			else
				
				self.GoToNextSequence()
			end
		else 
			if TppMission.IsInvitationStart() then
				
				TppException.OnSessionDisconnectFromHost()
			else
				
				self.GoToNextSequence()
			end
		end

		TppMission.SetInvitationStart( false )
	end,

	GoToNextSequence = function()
		TppUI.FadeIn(TppUI.FADE_SPEED.FADE_HIGHSPEED, "StartMainGame")
		GkEventTimerManager.Start( "TimeOutSequenceChange", 5 )
	end,

	Messages = function( self )
		return
		StrCode32Table {
			Network = {
				{
					msg = "SuccessJoinRoom",
					func = function()
						
						
						 Fox.Log("Mission Reload for Success Join Room")
						this.MissionReload()
						end,
				},
				{
					msg = "SuccessLeaveRoom",
					func = function()
						
						
						Fox.Log("Mission Reload for Success Leave Room")
						this.MissionReload()
					end,
				},
			},
			UI = {
				{	
					msg = "EndFadeIn",
					sender = "StartMainGame",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_MainGame")
					end,
				},
			},
			Timer = {
				{
					msg = "Finish",
					sender = "TimeOutSequenceChange",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_MainGame")
					end,
				},
			},
		}
	end,
	OnLeave = function()
	end,
}

if IS_GC_2017_COOP then
this.sequences.Seq_Demo_SyncPlayers = {
	OnEnter = function()
		Fox.Log("Waiting Players")
		Mission.SetIsReadyLobbyMissionStart()
	end,
	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "StartCoopLobbyMission",
					func = function()
						Fox.Log("Finish wait Sync players")
						TppSequence.SetNextSequence("Seq_Demo_GoToCoopMission_If_Already_Sortie")
					end,
				},
			},
		}
	end,
}
end 




return this
