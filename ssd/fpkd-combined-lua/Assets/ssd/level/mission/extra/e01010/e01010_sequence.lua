local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}
local avatar_edit_presets	= nil
local selectedGender 		= PlayerPartsType.AVATAR_MAN
local needSavePlayerType	= false

this.NO_RESULT = true
this.SKIP_SERVER_SAVE = true
this.disableEnemyRespawn = true


this.INITIAL_INFINIT_OXYGEN  = true

this.INITIAL_IGNORE_HUNGER = true

this.INITIAL_IGNORE_THIRST = true

this.INITIAL_IGNORE_FATIGUE = true

this.INITIAL_INFINITE_STAMINA = true














function this.OnBuddyBlockLoad() 
	
	local position, rotationY = Tpp.GetLocator( "AvatarEditIdentifier", "warp_avatarEdit" )
	TppPlayer.SetInitialPosition( position, rotationY )
	TppMain.StageBlockCurrentPosition()
end

function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		
		"Seq_Demo_OpenAvatarEdit",
		"Seq_Game_SelectGender",
		"Seq_Game_StartAvatarEdit",
		"Seq_Game_UpdateAvatarEdit",
		"Seq_Game_EndAvatarEdit",
		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end








function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")
	this.RegiserMissionSystemCallback()
	
	
	FogWallController.SetEnabled( false )
end




function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")
end

this.RegiserMissionSystemCallback = function()
	Fox.Log( "e01010_sequence.RegiserMissionSystemCallback()" )

	local systemCallbackTable = {
		OnEstablishMissionClear = function( missionClearType )
			TppMission.MissionGameEnd()
		end,
		OnDisappearGameEndAnnounceLog = function( missionClearType )
			Player.SetPause()
			TppMission.ShowMissionReward()
		end,
		OnEndMissionReward = function()
			TppMission.MissionFinalize{ isNoFade = true }
		end,
		nil
	}

	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )
end

function this.Messages()
	return StrCode32Table {
		UI = {
			{
				msg = "AvatarEditEnd",
				func = function()
					if vars.cancelAvatarEdit == 0 then
						this.needSavePlayerType = true
					end
					
					Fox.Log( "sequences.Seq_Game_UpdateAvatarEdit.Messages(): UI: AvatarEditEnd" )
					mvars.finishAvatarEdit = true
				end,
			},
		},
		Network = {
			{
				msg = "AcceptedInvate",
				func = function()
					mvars.gotoCoopLobby = true
					Fox.Log( "AcceptedInvite" )
					mvars.finishAvatarEdit = true					
				end,
				option = { isExecMissionClear = true, isExecDemoPlaying = true, isExecGameOver = true, isExecMissionPrepare = true, isExecFastTravel = true, },
			},
		},
	}
end







function this.OnSelectGender()
	if vars.playerType == PlayerType.AVATAR_FEMALE then
		Fox.Log( "### Select Female ###" )
		vars.avatarSaveIsValid = 1
		vars.playerType				= PlayerType.AVATAR_FEMALE
		vars.playerPartsType		= PlayerPartsType.AVATAR_EDIT_WOMAN
		vars.avatarFaceRaceIndex	= 128
		this.selectedGender			= PlayerPartsType.AVATAR_WOMAN
		this.avatar_edit_presets	= avatar_presets_women.presets
	else
		Fox.Log( "### Select Male ###" )
		vars.avatarSaveIsValid = 1
		vars.playerType				= PlayerType.AVATAR_MALE
		vars.playerPartsType		= PlayerPartsType.AVATAR_EDIT_MAN
		vars.avatarFaceRaceIndex	= 0
		this.selectedGender			= PlayerPartsType.AVATAR_MAN
		this.avatar_edit_presets	= avatar_presets.presets
	end

	Fox.Log( "vars.avatarSaveIsValid   : " .. tostring( vars.avatarSaveIsValid ) )
	Fox.Log( "vars.playerType          : " .. tostring( vars.playerType ) )
	Fox.Log( "vars.playerPartsType     : " .. tostring( vars.playerPartsType ) )
	Fox.Log( "vars.avatarFaceRaceIndex : " .. tostring( vars.avatarFaceRaceIndex ) )
	Fox.Log( "this.selectedGender      : " .. tostring( this.selectedGender ) )
	Fox.Log( "this.avatar_edit_presets : " .. tostring( this.avatar_edit_presets ) )
end




function this.ReturnToMission()
	Fox.Log( "##### ReturnToMission #####" )
	vars.isAvatarEditMode = 0
	vars.playerPartsType = this.selectedGender
	if this.needSavePlayerType then
		
		TppPlayer.SaveCurrentPlayerType()
	end
	Player.ResetPadMask {
		settingName = "avatar_edit_mission"
	}
	TppUiStatusManager.UnsetStatus( "EquipHud", "INVALID" )
	if TppUiCommand.IsTppUiReady() then
		Fox.Log( "not IsTppUiReady" )
	end
	TppUiCommand.EndAvatarEdit()
	Player.SetGearVisibility( true )
	Player.SetEnableUpdateAvatarInfo( true )
	SsdSbm.ApplyLoadoutToPlayer()
	TppGameStatus.Reset("AvatarEdit", "S_DISABLE_HUD")
	TppGameStatus.Reset("AvatarEdit", "S_DISABLE_PLAYER_DAMAGE")
	TppGameStatus.Reset("AvatarEdit", "S_IS_NO_TIME_ELAPSE_MISSION")
	TppGameStatus.Reset("AvatarEdit", "S_DISABLE_GAME_PAUSE")

	
	FogWallController.SetEnabled( true )
	
	if this.needSavePlayerType then
		
		SsdSaveSystem.SaveAvatar()
	end

	
	GrTools.SetSubSurfaceScatterFade( 0.0 )

	if mvars.gotoCoopLobby then
		
		TppMission.GoToCoopLobby()
	else
		TppMission.SetIsFromAvatarRoom(true)
		
		TppMission.ContinueFromCheckPoint()
	end
end





sequences.Seq_Demo_OpenAvatarEdit = {

	OnEnter = function()
		if DebugMenu then
			DebugMenu.SetDebugMenuValue("Avatar", "UseTrueTextureTimeoutTime", 1)
		end

		Player.SetPadMask {
			settingName = "avatar_edit_mission",
			except = true,
			sticks = PlayerPad.STICK_R,
		}
		Player.SetAroundCameraManualMode( true )
		Player.SetAroundCameraManualModeParams{
			target = Vector3(0,100,0),
			offset = Vector3(0,0,0),
		}
		Player.UpdateAroundCameraManualModeParams()
		Player.SetGearVisibility( false )

		TppGameStatus.Set("AvatarEdit", "S_DISABLE_HUD")
		TppGameStatus.Set("AvatarEdit", "S_DISABLE_PLAYER_DAMAGE")
		TppGameStatus.Set("AvatarEdit", "S_IS_NO_TIME_ELAPSE_MISSION")
		
		TppGameStatus.Set( "AvatarEdit", "S_DISABLE_GAME_PAUSE" )
	end,
	OnUpdate = function()
		
		TppUI.ShowAccessIconContinue()
		
		if not PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE } then
			GrxDebug.Print2D{ x=100, y=100, size=10, color=Color(1.0,0.2,0.2,1), args={ "Player is not Active..." }, life=1 }
			return
		end
		TppSequence.SetNextSequence( "Seq_Game_SelectGender" )
	end,
}

sequences.Seq_Game_SelectGender = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "GenderMenuOpened",
					func = function()
						
						if TppUiCommand.IsAvatarEditReady() then
							TppUiCommand.EndAvatarEdit()
						end
					end,
				},
				{
					msg = "GenderMenuSelected",
					func = function( result )
						if result == GenderMenuResult.Cancel then
							
							TppSequence.SetNextSequence( "Seq_Game_EndAvatarEdit" )
						else
							mvars.selectedGender = result
						end
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOnSelectGender",
					func = function()
						AvatarMenuSystem.RequestCloseGenderMenu()
						mvars.startLoadingPlayer = true
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		mvars.selectedGender		= nil
		mvars.changeAvatarPartsType	= false
		mvars.startLoadingPlayer	= false
		
		mvars.selectedGender = true
	end,

	OnUpdate = function()
		if not mvars.selectedGender then
			return
		end

		if not mvars.changeAvatarPartsType then
			this.OnSelectGender()
			mvars.changeAvatarPartsType = true
			TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnSelectGender", TppUI.FADE_PRIORITY.MISSION )
		end

		if not mvars.startLoadingPlayer then
			return
		end

		
		TppUI.ShowAccessIconContinue()
		
		if not PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE } then
			GrxDebug.Print2D{ x=100, y=100, size=10, color=Color(1.0,0.2,0.2,1), args={ "Player is not Active..." }, life=1 }
			return
		end
		TppSequence.SetNextSequence( "Seq_Game_StartAvatarEdit" )
	end,

	OnLeave = function()
		mvars.selectedGender		= nil
		mvars.changeAvatarPartsType	= nil
		mvars.startLoadingPlayer	= nil
	end,

}

sequences.Seq_Game_StartAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeIn", sender = "FadeInOnAvatarEditStart",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_UpdateAvatarEdit" )
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		mvars.isRequestedFadeIn = false
		
		
		TppUiCommand.LoadAvatarEdit( { type=AvatarEdit.AVATAR_IN_HELI, presets=this.avatar_edit_presets } )
		
		GrTools.SetSubSurfaceScatterFade( 1.0 )
	end,

	OnUpdate = function()
		if not TppUiCommand.IsAvatarEditReady() then
			GrxDebug.Print2D{ x=100, y=100, size=10, color=Color(1.0,0.2,0.2,1), args={ "AvatarEditor not Ready..." }, life=1 }
			return
		end
		if not mvars.isRequestedFadeIn then
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnAvatarEditStart", TppUI.FADE_PRIORITY.MISSION )
			mvars.isRequestedFadeIn = true
			TppUiCommand.StartAvatarEdit()
			vars.isAvatarEditMode = 1
			
			TppSoundDaemon.ResetMute( 'Loading' )
			TppSoundDaemon.SetMute( 'Telop' )
		end
	end,

	OnLeave = function ()
		mvars.isRequestedFadeIn = nil
	end,
}

sequences.Seq_Game_UpdateAvatarEdit = {
	OnEnter = function()
		TppUiStatusManager.SetStatus( "EquipHud", "INVALID" )
	end,
	OnUpdate = function()
		if mvars.finishAvatarEdit then
			TppSequence.SetNextSequence( "Seq_Game_EndAvatarEdit" )
		end
	end,
}

sequences.Seq_Game_EndAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutOnAvatarEditEnd",
					func = function()
						this.ReturnToMission()
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		TppSoundDaemon.ResetMute( 'Telop' )
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnAvatarEditEnd", TppUI.FADE_PRIORITY.MISSION )
	end,
}




return this
