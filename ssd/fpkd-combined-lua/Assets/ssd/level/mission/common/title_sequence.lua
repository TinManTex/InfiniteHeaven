


local this = {}

local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local TimerStart = GkEventTimerManager.Start
local IsSavingOrLoading = TppScriptVars.IsSavingOrLoading

local sequences = {}



local SELECT_FLAG = TppDefine.Enum{
	"SELECT_CONTINUE" 	,
	"SELECT_GAME_START" ,
}


this.NO_RESULT = true
this.SKIP_SERVER_SAVE = true




















function this.ClearTitleMode()
	Fox.Log("title_sequence.ClearTitleMode")
	gvars.ini_isTitleMode = false
	gvars.ini_isReturnToTitle = false
end




function this.SetNewGameState()
	mvars.isExistSaveData = false
end








function this.AddTitleSequences(missionSequenceList)
	Fox.Log("#### Add TitleSequence ####")

	local titleSequenceList = {
		
		"Seq_Demo_StartHasTitleMission",	
		"Seq_Game_PushStart",		
		"Seq_Game_CheckLogin",
		"Seq_Game_OnlineNews",
		"Seq_Game_CharacterSelect",
		"Seq_Game_InitLocalSave",
		"Seq_Game_WaitFading",
		"Seq_Game_WaitInitializeToServer",
		"Seq_Game_WaitInitializeToServer2",
		"Seq_Game_WaitLoadingFromServer",
		"Seq_Game_WaitPlayerActive",
		"Seq_Game_MissionStartCamera",
		"Seq_Game_RestoreToVars",
		
		"Seq_Game_ChunkLoading",
		"Seq_Game_ChunkCanceled",
		"Seq_Game_ChunkInstalled",
		
		"Seq_Demo_CheckDlc",
		"Seq_Demo_ShowDlcError",
		"Seq_Demo_ShowDlcAnnouncePopup",
		"Seq_Demo_WaitSavingPersonalData",
		
		"Seq_Game_CheckCanAcceptInvite",
		"Seq_Game_WaitConsumeInvite",
		"Seq_Game_GoToCoopLobby",
	}
	local retSequenceList = {}
	Tpp.ApendArray(retSequenceList, missionSequenceList )
	
	Tpp.ApendArray(retSequenceList, titleSequenceList )
	return retSequenceList
end

function this.AddTitleSequenceTable( sequenceTable )
	for key, value in pairs(sequences) do
		sequenceTable[key] = value
	end
	return sequenceTable
end

function this.RegisterMissionGameSequenceName( sequenceName )
	Fox.Log("RegisterMissionGameSequenceName: sequenceName = " .. tostring(sequenceName ))
	mvars.title_missionGameSequenceName = sequenceName
end

function this.RegisterCallbackOnRestoreSvars( func )
	mvars.title_callbackOnRestoreSvars = func
end

function this.OnBuddyBlockLoad() 
	
	TppPlayer.SetInitialPosition( {0, 1000.8, 7}, 180 )
end

function this.MissionPrepare()
	Fox.Log("*** SSD Title MissionPrepare ***")
	
	TppGameStatus.Set( "TitleSequence", "S_DISABLE_PLAYER_PAD" )
	TppGameStatus.Set( "TitleSequence", "S_DISABLE_GAME_PAUSE" )
	TppGameStatus.Set( "TitleSequence", "S_IS_NO_TIME_ELAPSE_MISSION" )
	TppGameStatus.Set( "TitleSequence", "S_DISABLE_PLAYER_DAMAGE")
	
	TppVarInit.InitializeOnTitle()
end

function this.OnRestoreSVars()
	
	TppSoundDaemon.ResetMute( 'Title' )
	TppSoundDaemon.ResetMute( 'Loading' )
	
	
	TppSoundDaemon.SetMute( 'Result' )
	
	TppSound.SetSceneBGM( "bgm_title" )
end

function this.OnEndMissionPrepareSequence()
	TppClock.Stop()
	TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY, 0 )

	
	Gimmick.InvisibleGimmick( -1, "ssde_boxx001_gim_n0000|srt_ssde_boxx001", "/Assets/ssd/level/mission/common/mis_com_robby_stage.fox2", true, {gimmickId = "GIM_P_Ornament"} )
end

function this.OnTerminate()
	if not mvars.title_isCalledOnTerminate then
		mvars.title_isCalledOnTerminate = true
		
		TppGameStatus.Reset( "TitleSequence", "S_DISABLE_PLAYER_PAD" )
		TppGameStatus.Reset( "TitleSequence", "S_DISABLE_GAME_PAUSE" )
		TppGameStatus.Reset( "TitleSequence", "S_IS_NO_TIME_ELAPSE_MISSION" )
		TppGameStatus.Reset( "TitleSequence", "S_DISABLE_PLAYER_DAMAGE")
		
		
		if Player.IsGameObjectActive() then
			Player.SetAroundCameraManualMode( false )
		end
		
		TppMovie.Stop()
		
		TppSound.StopSceneBGM()
	end
end















function this.IsBrokenSaveData( missionCode )
	
	return false
end




function this.ShouldCheckServer()
	if not SsdSaveSystem.IsUseSaveSystem() then
		return false
	end
	if Editor and not TppServerManager.IsLoginKonami() then
		return false
	end
	return true
end




function this.SetPlayerCamera( index )
	Player.SetAroundCameraManualModeParams {
		distance = 3.0,				
		focusDistance = 1.5,		
		aperture = 10.0, 			
		targetInterpTime = 0.2,		
		targetIsPlayer = true,		
		targetOffsetFromPlayer = Vector3( 0, 0.05, 0 ),	
		targetInstanceIndex = index,	
	}
	Player.UpdateAroundCameraManualModeParams()
	Player.RequestToSetCameraRotation { rotX = 0, rotY = 0, interpTime = 0.2 }
end




function this.StartTitleMovie()
	TppMovie.Play{
		videoName = "p10_000001",
		isLoop = true,
		isNoFade = true,
		memoryPool = "p10_000001",
	}
end




function this.InitializeScriptVars()
	TppScriptVars.InitOnTitle()
	TppGVars.InitializeOnTitle()
	Player.ResetVarsOnMissionStart()
end

function this.InitializeScriptVarsOnNewGame()
	TppScriptVars.InitOnTitle()
	TppGVars.InitializeOnTitle()
	SsdSaveSystem.RestoreToVars()
	Player.ResetVarsOnMissionStart()
	SsdSbm.RestoreFromSVars()
end





function this.SelectNewGame()
	Fox.Log("Select new game")
	local currentSequenceName = TppSequence.GetCurrentSequenceName()
	this.InitializeScriptVarsOnNewGame()
	Player.SetSurvivalStateResetRequest()
	Player.SetPause()
	TppSave.MakeNewGameSaveData()
	TppMission.SafeStopSettingOnMissionReload()
	
	gvars.canExceptionHandling = true
	gvars.ini_isTitleMode = true
	gvars.ini_isReturnToTitle = false

	vars.locationCode = TppDefine.LOCATION_ID.SSD_OMBS
	vars.missionCode = 10010
	TppSave.VarSave()
	
	mvars.title_nextMissionSequenceIndex = svars.seq_sequence
	mvars.title_loadOptions = { waitOnLoadingTipsEnd = false, }
	TppSequence.ReserveNextSequence(currentSequenceName)
	TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
end




function this.SelectMultiPlay()
	Fox.Log("Select goto staging area")
	local currentSequenceName = TppSequence.GetCurrentSequenceName()

	local curClock = vars.clock
	local curWeather = vars.weather

	
	this.StorePlayerGearState()
	this.InitializeScriptVars()

	gvars.sav_skipRestoreToVars = false
	TppSave.VarRestoreOnContinueFromCheckPoint()

	
	this.RestorePlayerGearState()
	
	vars.missionCode = TppDefine.SYS_MISSION_ID.TITLE
	vars.locationCode = TppDefine.LOCATION_ID.INIT
	
	vars.clock = curClock
	vars.weather = curWeather
	
	local hour, min, sec = TppClock.GetTime("time")
	WeatherManager.SetCurrentClock(hour, min, sec)

	
	Player.SetEnableUpdateAvatarInfo(false) 
	gvars.isContinueFromTitle = true
	mvars.title_loadOptions = nil

	TppVarInit.SetBuildingLevel()
	TppVarInit.RestoreBuildingData()

	TppSave.CheckAndSavePersonalData()
	TppSoundDaemon.LoadRegidentStreamData()

	TppSequence.ReserveNextSequence(currentSequenceName)
end




function this.SelectContinue()
	local currentSequenceName = TppSequence.GetCurrentSequenceName()
	this.InitializeScriptVars()
	Player.SetPause()
	gvars.sav_skipRestoreToVars = false
	TppMission.SafeStopSettingOnMissionReload()
	TppSave.VarRestoreOnContinueFromCheckPoint()
	TppSave.ReserveVarRestoreForContinue()
	TppPlayer.SetInitialPositionToCurrentPosition()
	gvars.ini_isReturnToTitle = false
	gvars.isContinueFromTitle = true
	mvars.title_loadOptions = nil

	TppMain.ReservePlayerLoadingPosition (
		TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT
	)
	TppSave.CheckAndSavePersonalData()
	TppSoundDaemon.LoadRegidentStreamData()
	
	mvars.title_nextMissionSequenceIndex = svars.seq_sequence
	TppSequence.ReserveNextSequence(currentSequenceName)

	TppUI.PreloadLoadingTips()
end

function this.LoadMissionForContinue()
	Fox.Log("Load mission for continue")
	gvars.ini_isTitleMode = false

	if mvars.title_selectedMultiPlay then 
		TppUI.FadeIn(TppUI.FADE_SPEED.FADE_MOMENT ) 
		SsdMatching.RequestCreateJoinRoom() 
		TppSequence.SetNextSequence(mvars.title_missionGameSequenceName)
		Player.UnsetPause()
		Player.SetAroundCameraManualMode( false )
		TppMain.EnableGameStatus()
		this.OnTerminate()
	else
		
		TppScriptVars.SetSVarsNotificationEnabled(false)
		svars.seq_sequence = mvars.title_nextMissionSequenceIndex
		TppScriptVars.SetSVarsNotificationEnabled(true)

		TppSave.CheckAndSaveInitMission()
		local currentMissionCode = TppDefine.SYS_MISSION_ID.TITLE
		TppMission.Load( vars.missionCode, currentMissionCode, mvars.title_loadOptions )
	end
end

function this.StorePlayerGearState()
	this.tmp_gearState = {}
	local count = GearState.GRAR_MAX_COUNT * GearState.GEAR_STATE_SIZE_BY_UINT32
	for i=1, count do
		this.tmp_gearState[i] = vars.gearState[i-1]
	end
end

function this.RestorePlayerGearState()
	local count = GearState.GRAR_MAX_COUNT * GearState.GEAR_STATE_SIZE_BY_UINT32
	for i=1, count do
		vars.gearState[i-1] = this.tmp_gearState[i]
	end
end







sequences.Seq_Demo_StartHasTitleMission = {
	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{	
					msg = "EndFadeIn", sender = "FadeInOnStartTitle",
					func = function()
						if gvars.ini_isReturnToTitle then
							TppSequence.SetNextSequence("Seq_Game_PushStart")
						end
					end,
				},
			},
			nil
		}
	end,

	OnEndShowSplashScreen = function ()
		if InvitationManager.IsAccepted() then
			
			TppSequence.SetNextSequence("Seq_Game_CheckLogin")
		else
			
			TitleMenuSystem.RequestOpen()
			TppSequence.SetNextSequence("Seq_Game_PushStart")
		end
	end,

	OnUpdate = function ( self )
		local konamiLogoScreenId = SplashScreen.GetSplashScreenWithName("konamiLogo")
		if konamiLogoScreenId then
			if DebugText then
				local context = DebugText.NewContext()
				DebugText.Print(context, "Waiting Konami Logo...")
			end
			return
		end
		







		local foxLogoScreenId = SplashScreen.GetSplashScreenWithName("foxLogo")
		if foxLogoScreenId then
			if DebugText then
				local context = DebugText.NewContext()
				DebugText.Print(context, "Waiting Fox Logo...")
			end
			return
		end

		
		if not mvars.startHasTitileSeqeunce then
			mvars.startHasTitileSeqeunce = true
			self.OnEndShowSplashScreen()
		end

	end,

	OnEnter = function ( self )
		
		if gvars.ini_isFirstLogin then
			self.OnEndShowSplashScreen()
		else
			gvars.ini_isFirstLogin = true
		end
	end,

	OnLeave = function ()
	end,

}




sequences.Seq_Game_CheckCanAcceptInvite = {
	OnEnter = function()
		Fox.Log("Seq_Game_CheckCanAcceptInvite.OnEnter")
		if InvitationManager.IsAccepted() then
			if TppStory.CanPlayCoopMission() then
				TppSequence.SetNextSequence("Seq_Game_WaitConsumeInvite")
			else
				Fox.Log("Call Error Popup")
				



				TppUiCommand.ShowErrorPopup(5004, Popup.TYPE_ONE_BUTTON)
				InvitationManager.ResetAccept() 
			end
		else
			Fox.Log("Mission Load Start")
			
			this.LoadMissionForContinue()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = 5004,
					func = function()
						this.LoadMissionForContinue()
					end,
				},
			},
		}
	end,
}




sequences.Seq_Game_WaitConsumeInvite = {
	OnEnter = function(self)
		Fox.Log("OnEnter Seq_Game_WaitConsumeInvite")
		gvars.title_isInvitationStart = true
		mvars.title_isPlaytogetherHost = InvitationManager.IsPlayTogetherHost()
		InvitationManagerController.RequestConsumeInviteInTitle()
		self.requestedLoadMission = false
	end,
	OnUpdate = function(self)
		if InvitationManagerController.IsWaitingConsumeInviteInTitile() then
			return
		end
		if TppServerManager.GetIsPlus() then
			
			TppSequence.SetNextSequence("Seq_Game_GoToCoopLobby")
		else
			if not self.requestedLoadMission then
				Fox.Log("Mission Load Start")
				gvars.title_isInvitationStart = false
				
				this.LoadMissionForContinue()
				self.requestedLoadMission = true
			end
		end
	end,
}




sequences.Seq_Game_GoToCoopLobby = {
	OnEnter = function()
		Fox.Log("OnEnter Seq_Game_GoToCoopLobby")
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		if mvars.title_isPlaytogetherHost then
			TppUiCommand.ShowPopup("lobby_quickMatch_state_move_stagingArea",0)
		else
			TppUiCommand.ShowErrorPopup(5000)
		end
		
		TimerStart("Timer_GoToCoopLobby",1)
	end,
	Messages = function(self)
		return StrCode32Table{
			Timer = {
				{
					msg = "Finish",
					sender = "Timer_GoToCoopLobby",
					func = function()
						TppUiCommand.ErasePopup()
						this.LoadMissionForContinue()
					end,
				},
			},
		}
	end,
}




sequences.Seq_Game_PushStart = {

	Messages = function(self)
		return
		StrCode32Table {
			UI = {
				{
					msg = "TitleMenuOpened",
					func = function()
						TppUI.FadeIn( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FadeInOnStartTitle", TppUI.FADE_PRIORITY.SYSTEM )
					end,
				},
				{
					msg = "TitleMenuContinueSelected",
					func = function()
						
						
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnStartTitle", TppUI.FADE_PRIORITY.SYSTEM )
					end,
				},
				{
					msg = "DEBUG_TitleStart",
					func = function()
						
						
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnDebugStart", TppUI.FADE_PRIORITY.SYSTEM )
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOnStartTitle",
					func = self.OnSelectStart,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOnDebugStart",
					func = self.OnDebugSelectStart,
				},
				{
					msg = "FailFadeOut", sender = "FadeOutOnStartTitle",
					func = self.OnSelectStart,
				},
			},
			nil
		}
	end,

	OnSelectStart = function()
		Fox.Log("--- OnSelectStart ---")
		TppSequence.SetNextSequence("Seq_Game_CheckLogin")
	end,

	OnDebugSelectStart = function()
		Fox.Log("--- OnDebugSelectStart ---")
		
		if Tpp.IsMaster() then
			this.SelectNewGame()
		else
			
			if Mission.LoadPraiseJson then
				Mission.LoadPraiseJson()
			end
			
			if Selector then
				tpp_editor_menu2.StartTestStage(60000)
			end
		end
		TppMovie.Stop()
		TitleMenuSystem.RequestClose()
	end,

	OnEnter = function ( self )
		this.StartTitleMovie()

		if IS_GC_2017_COOP then
			
			InvitationManager.SetAccept()
		end
	end,

	OnUpdate = function ( self )
	end,

	OnLeave = function ()
		TppMovie.Stop()
	end,
}




sequences.Seq_Game_CheckLogin = {

	Messages = function(self)
		return
		StrCode32Table {
			Network = {
				{
					msg = "EndLogin",
					func = function()
						self.EndLogin(self)
					end,
				},
			},
			nil
		}
	end,

	LoginSuccess = function()
		
		TitleMenuSystem.RequestClose()
		TppSequence.SetNextSequence("Seq_Game_OnlineNews")
	end,

	LoginFail = function()
		
		
		










		TppMission.ReturnToTitleForException()
	end,

	EndLogin = function(self)
		if TppServerManager.IsLoginKonami() then
			self.LoginSuccess()
		else
			self.LoginFail()
		end
	end,

	OnEnter = function(self)
		if not this.ShouldCheckServer() then
			self.LoginSuccess()
			return
		end

		if not TppServerManager.IsLoginKonami() then
			
			self.LoginFail()
		else
			
			self.LoginSuccess()
		end
	end,
}




sequences.Seq_Game_OnlineNews = {
	Messages = function(self)
		return
		StrCode32Table {
			Network = {
				{
					msg = "EndOnlineNews",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_InitLocalSave")
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function(self)
		
		TppServerManager.StartOnlineNews()
	end,
}




sequences.Seq_Game_InitLocalSave = {
	OnEnter = function(self)
		TppSave.VarSave()
		TppMarker.StoreMarkerLocator()
		TppSave.CheckAndSavePersonalData()
	end,

	OnUpdate = function(self)
		if not TppSave.IsSaving() then
			TppSequence.SetNextSequence( "Seq_Game_CharacterSelect" )
		end
	end,
}




sequences.Seq_Game_CharacterSelect = {
	Messages = function(self)
		return
		StrCode32Table {
			UI = {
				{
					msg = "CharacterSelectMenuNewGameSelected",
					func = function()
						Fox.Log( "### Selected NEW GAME ###")
						TppSequence.SetNextSequence("Seq_Game_WaitFading")
						mvars.title_selectedNewGame = true
					end,
				},
				{
					msg = "CharacterSelectMenuContinueSelected",
					func = function()
						Fox.Log( "### Selected CONTINUE ###")
						TppSequence.SetNextSequence("Seq_Game_WaitFading")
					end,
				},
				{
					msg = "CharacterSelectMenuMultiplaySelected",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_WaitFading")
						mvars.title_selectedMultiPlay = true
					end,
				},
				{
					msg = "CharacterSelectMenuChangeCharaSlot",
					func = function( slotIndex )
						Fox.Log( "### Slot Change ###")
						this.SetPlayerCamera( slotIndex )
						mvars.title_selectedPlayerIndex = slotIndex
					end,
				},
				{
					msg = "CharacterSelectMenuEndCharaLoading",
					func = function( genderBit )
						
						Player.StartCharacterSelect()
						TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnStartCharaSelect", TppUI.FADE_PRIORITY.SYSTEM )
					end,
				},
				{
					msg = "CharacterSelectMenuFailServerConnect",
					func = function()
						
						TitleMenuSystem.RequestReopen()
						mvars.startHasTitileSeqeunce = false
						TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnStartTitle", TppUI.FADE_PRIORITY.SYSTEM )
						TppSequence.SetNextSequence("Seq_Demo_StartHasTitleMission")
					end,
				},
				
				{
					msg = "StartChangeLangOrVoiceFromOptionMenu",
					func = function()
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOut_ChangeLang", TppUI.FADE_PRIORITY.SYSTEM )
					end,
				},
				{
					msg = "EndChangeLangOrVoiceFromOptionMenu",
					func = function()
						TppMission.AbortMission{ isTitleMode = true, isAlreadyGameOver = true }
					end,
				},
				{
					msg = "EndFadeOut",
					sender = "FadeOut_ChangeLang",
					func = function()
						CharacterSelectMenuSystem.RequestClose()
					end,
				},
				
			},
			nil
		}
	end,

	OnEnter = function(self)
		
		if Mission.LoadPraiseJson then
			Mission.LoadPraiseJson()
		end
		
		CharacterSelectMenuSystem.RequestOpen()
		
		Player.SetAroundCameraManualMode( true )	
		this.SetPlayerCamera( 0 )
		
		gvars.ini_isTitleMode = true
		mvars.title_selectedNewGame = false
		mvars.title_selectedPlayerIndex = 0
		
		self.isInvitationMode = InvitationManager.IsAccepted()
	end,
	OnUpdate = function(self)
		if not self.isInvitationMode then
			if InvitationManager.IsAccepted() then
				TppMission.AbortMission{ isTitleMode = true, isAlreadyGameOver = true }
				self.isInvitationMode = true
			end
		end
	end,
	OnLeave = function ( self, nextSequenceName )
	end,
}

sequences.Seq_Game_WaitFading = {
	Messages = function(self)
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutOnGameStart",
					func = function()
						self.OnEndFadeOut(self)
					end,
				},
			},
			Timer = {
				{	
					sender = "Timer_WaitDecisionCamera",
					msg = "Finish",
					func = function()
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnGameStart", TppUI.FADE_PRIORITY.SYSTEM )
					end
				},
			},
			nil
		}
	end,

	OnEndFadeOut = function(self)
		CharacterSelectMenuSystem.RequestClose()
		self.InitializeOnGameStart()
		if mvars.title_selectedNewGame then
			TppSequence.SetNextSequence("Seq_Game_WaitInitializeToServer")
		else
			TppSequence.SetNextSequence("Seq_Game_WaitLoadingFromServer")
		end
	end,

	InitializeOnGameStart = function()
		if Player.EndCharacterSelect then
			Player.EndCharacterSelect()
		end
		if SsdSaveSystem.Reset then
			SsdSaveSystem.Reset()
		end
		
		Player.SetAroundCameraManualMode( false )
	end,

	OnEnter = function( self )
		if mvars.title_selectedMultiPlay then 
			SsdSaveSystem.Reset()
			TppSequence.SetNextSequence("Seq_Game_WaitLoadingFromServer")
		else
			GkEventTimerManager.Start( "Timer_WaitDecisionCamera", 1 )
		end
		
		TppSave.CheckAndSavePersonalData()
	end,
}





sequences.Seq_Game_WaitInitializeToServer = {
	OnEnter = function(self)
		if not this.ShouldCheckServer() then
			TppSequence.SetNextSequence("Seq_Game_WaitInitializeToServer2")
			mvars.title_initRequestEnd = true
			return
		end

		mvars.title_initRequestEnd = false
	end,

	OnUpdate = function(self)
		if mvars.title_initRequestEnd then
			return
		end

		if IsSavingOrLoading() then
			return
		end

		mvars.title_initRequestEnd = true
		TppSequence.SetNextSequence("Seq_Game_WaitInitializeToServer2")

		









	end,
}




sequences.Seq_Game_WaitInitializeToServer2 = {
	OnEnter = function(self)
		if not this.ShouldCheckServer() then
			this.SelectNewGame()
			mvars.title_initRequestEnd = true
			return
		end
		
		SsdSaveSystem.LoadInit()
		mvars.title_initRequestEnd = false
	end,

	OnUpdate = function(self)
		if mvars.title_initRequestEnd then
			return
		end

		if SsdSaveSystem.IsIdle() then
			this.SelectNewGame()
			mvars.title_initRequestEnd = true
		end
	end,
}





sequences.Seq_Game_WaitLoadingFromServer = {
	OnEnter = function(self)
		if not this.ShouldCheckServer() then
			TppSequence.SetNextSequence("Seq_Game_WaitPlayerActive")
			mvars.title_isStartContinue = true
			return
		end
		SsdSaveSystem.LoadInit()
		mvars.title_isStartContinue = false
	end,

	OnUpdate = function(self)
		if not SsdSaveSystem.IsIdle() then
			return
		end

		if IsSavingOrLoading() then
			return
		end

		if not mvars.title_isStartContinue then
			if Mission.HasServerSave() then
				TppSequence.SetNextSequence("Seq_Game_WaitPlayerActive")
			elseif mvars.title_selectedMultiPlay then
				
			else
				this.SelectNewGame()
			end
			mvars.title_isStartContinue = true
		end
	end,
}


sequences.Seq_Game_WaitPlayerActive = {
	OnEnter = function(self)
		self.needCheckActivatePlayer= true
	end,
	OnUpdate = function(self)
		if self.needCheckActivatePlayer then
			if PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE } then
				self.needCheckActivatePlayer = false
				TppSequence.SetNextSequence("Seq_Game_RestoreToVars")
			end
		end
	end,
}

sequences.Seq_Game_MissionStartCamera = {
	Messages = function(self)
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutOnGameStart",
					func = function()
						self.OnEndFadeOut(self)
					end,
				},
				{
					msg = "CharacterSelectMenuClosed",
					func = function()
						GkEventTimerManager.Start( "Timer_RequestEmotion", 0.1 )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_WaitDecisionCamera",
					msg = "Finish",
					func = function()
						this.ClearTitleMode()
						SsdSbm.ApplyLoadoutToPlayer()
						Player.OnStartGameAftetCharacterSelectAtCoopLobby()
						mvars.title_callbackOnRestoreSvars()
						TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
					end
				},
				{
					sender = "Timer_RequestEmotion",
					msg = "Finish",
					func = function()
						
						GkEventTimerManager.Start( "Timer_TimeOutEmotion", 3 )
						self.RequestEmotion(self)
					end
				},
				{ 
					sender = "Timer_TimeOutEmotion",
					msg = "Finish",
					func = function()
						self.EndEmotion(self)
					end,
				},
				{ 
					
					sender = "Timer_WaitGimmickRestore",
					msg = "Finish",
					func = function()
						Gimmick.RestoreSaveDataPermanentGimmickFromCheckPoint() 
					end,
				}
			},
			Player = {
				{
					msg = "EmotionEnd",
					func = function()
						self.EndEmotion(self)
					end,
				},
				{
					msg = "FinishMovingToPosition",
					func = function(name, result)
						if result == Fox.StrCode32("success") then
							mvars.waitChangeRotY = true
						else
							RequestEmotion(self)
						end
					end,
				}
			},
			nil
		}
	end,
	OnEnter = function(self)
		if mvars.title_selectedMultiPlay then 
			Player.UnsetPause()
			
			TppMain.DisableGameStatus()
			
			TppSound.StopSceneBGM()
			TppSoundDaemon.PostEvent( "sfx_s_bgm_start_mission" )
			CharacterSelectMenuSystem.RequestClose()
			Player.EndCharacterSelect()
		else
			
			TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
		end
	end,

	OnUpdate = function ( self )
		if mvars.requestedEmotion then
			if PlayerInfo.OrCheckStatus{ PlayerStatus.REQUEST_EMOTION_COMBINATION} then
				self.EndEmotion(self)
			end
		end
	end,

	EndEmotion = function(self)
		if mvars.requestedEmotion then
			Player.RequestToSetCameraRotation { rotX = 0, rotY = 180, interpTime = 1.0 }
			Player.SetAroundCameraManualMode( false )
			GkEventTimerManager.Start( "Timer_WaitDecisionCamera", 1 )
			GkEventTimerManager.Start( "Timer_WaitGimmickRestore", 0.9 ) 
			mvars.requestedEmotion = false
		end
	end,
	RequestEmotion = function(self)
		mvars.requestedEmotion = true
		Mission.RequestEmotionForTitleToStagingArea()
	end,
}

sequences.Seq_Game_RestoreToVars = {
	OnEnter = function(self)
		
		Player.SetPause()
		self.waitFrame = 0
	end,
	OnUpdate = function(self)
		if self.waitFrame > 0 then
			if mvars.title_selectedMultiPlay then
				this.SelectMultiPlay()
			else
				this.SelectContinue()
			end
			TppSequence.SetNextSequence("Seq_Game_MissionStartCamera")
		end
		self.waitFrame = self.waitFrame + 1
	end,
}

sequences.Seq_Demo_CheckDlc = {
	OnEnter = function(self)
		Mission.InitializeDlcMission()
		if ( Fox.GetPlatformName() ~= "XboxOne" ) then
			TppSequence.SetNextSequence("Seq_Game_ChunkLoading")
			return
		end
		Dlc.StartCheckingDlc()
	end,
	OnUpdate = function(self)
		if Dlc.IsCheckingDlc() then
			if DebugText then
				DebugText.Print(DebugText.NewContext(), "Checking DLC...")
			end
		else
			if Dlc.GetLastError() == DlcError.E_OK then
				TppSequence.SetNextSequence("Seq_Demo_ShowDlcAnnouncePopup")
			else
				TppSequence.SetNextSequence("Seq_Demo_ShowDlcError")
			end
		end
	end,
}

sequences.Seq_Demo_ShowDlcError = {
	OnEnter = function(self)
		local dlcError = Dlc.GetLastError()
		if dlcError == DlcError.E_NETWORK then
		else
		end
		
		
		
		TppSequence.SetNextSequence("Seq_Demo_ShowDlcAnnouncePopup")
	end,
}

sequences.Seq_Demo_ShowDlcAnnouncePopup = {
	OnEnter = function(self)
		TppUiCommand.ShowDlcAnnouncePopup()
	end,

	OnUpdate = function( self )
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Showing dlc announce popup ...")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "EndDlcAnnounce",
					func = function()
						TppSequence.SetNextSequence("Seq_Demo_WaitSavingPersonalData")
					end,
				},
			},
		}
	end,
	OnLeave = function(self)
		TppSave.CheckAndSavePersonalData()
	end,
}

sequences.Seq_Demo_WaitSavingPersonalData = {
	OnEnter = function(self)
	end,

	OnUpdate = function( self )
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Wait saving personal data ...")
		end

		local fileName = TppDefine.PERSONAL_DATA_SAVE_FILE_NAME
		if TppSave.IsSavingWithFileName( fileName ) or	TppSave.HasQueue( fileName ) then
			return
		end

		TppSequence.SetNextSequence("Seq_Game_ChunkLoading")
	end,
}


local OK_BUTTON = 1
local CANCEL_BUTTON = 2
sequences.Seq_Game_ChunkLoading = {
	OnEnter = function(self)
		
		Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
		self.chunkIndexList = self.GetChunkIndexList()
	end,

	OnUpdate = function(self)
		
		TppUI.ShowAccessIconContinue()

		
		if TppMission.IsChunkLoading( self.chunkIndexList , true) then
			return
		end
		TppSequence.SetNextSequence("Seq_Game_ChunkInstalled")
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.NOW_INSTALLING,
					func = function()
						TppSequence.SetNextSequence("Seq_Game_ChunkCanceled")
					end,
				},
			},
		}
	end,

	OnLeave = function ( self, nextSequenceName )
		
		Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
	end,

	GetChunkIndexList = function()
		if InvitationManager.IsAccepted() or vars.missionCode == 5 then
			return Tpp.GetChunkIndexList( vars.locationCode , 21000 )
		else
			return Tpp.GetChunkIndexList( vars.locationCode , vars.missionCode)
		end
	end,

}



sequences.Seq_Game_ChunkCanceled = {
	OnEnter = function(self)
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.INSTALL_CANCEL, Popup.TYPE_TWO_BUTTON )
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.INSTALL_CANCEL,
					func = function()
						local select = TppUiCommand.GetPopupSelect()
						if select == OK_BUTTON then 
							TppMission.EnableInGameFlag() 
							TppMission.ReturnToTitle()
						else 
							TppSequence.SetNextSequence("Seq_Game_ChunkLoading")
						end
					end,
				},
			},
		}
	end,
}

sequences.Seq_Game_ChunkInstalled = {
	OnEnter = function(self)
		
		TppSequence.SetNextSequence("Seq_Game_CheckCanAcceptInvite")
	end,

	OnUpdate = function ( self )
	end,

	OnLeave = function()
	end,
}
return this
