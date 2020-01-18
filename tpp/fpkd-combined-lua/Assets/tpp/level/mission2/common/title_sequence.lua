local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local TimerStart = GkEventTimerManager.Start
local IsSavingOrLoading = TppScriptVars.IsSavingOrLoading
local currentMissionCode = vars.missionCode

local sequences = {}



local SELECT_FLAG = TppDefine.Enum{
	"SELECT_CONTINUE" 	,
	"SELECT_RESTART_HELI" ,
	"SELECT_GAME_START" ,
	"SELECT_MGO",
}
this.SetOnSelectFlag = function( selectFlag )
	mvars.title_selectFlag = selectFlag
end
this.GetOnSelectFlag= function( )
	return mvars.title_selectFlag
end





















function this.ClearTitleMode()
	Fox.Log("title_sequence.ClearTitleMode")
	gvars.ini_isTitleMode = false
	gvars.ini_isReturnToTitle = false
end





function this.SetNewGameState()
	mvars.isExistSaveData = false
end








function this.AddTitleSequences( list )
	local sequenceList = {
		"Seq_Demo_StartHasTitleMission",	
		"Seq_Game_PushStart",	
		"Seq_Game_TitleMenu",
	}
	local init_sequenceList_size = #sequenceList

	for i, sequenceName in ipairs( list ) do
		sequenceList[ init_sequenceList_size + i ] = sequenceName
	end
	
	
	local afterSequenceList = {
		"Seq_Game_ChunkLoading",
		"Seq_Game_ChunkCanceled",
		"Seq_Game_ChunkInstalled",
		"Seq_Demo_CheckDlc",
		"Seq_Demo_ShowDlcError",
		"Seq_Demo_ShowDlcAnnouncePopup",
		"Seq_Demo_WaitSavingPersonalData",
	}
	for i, sequenceName in ipairs( afterSequenceList ) do
		table.insert( sequenceList, sequenceName )
	end

	return sequenceList
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

function this.RegisterGameStatusFunction( enableGameStatusFunction, disableGameStatusFunction )
	mvars.title_enableGameStatusFunction = enableGameStatusFunction
	mvars.title_disableGameStatusFunction = disableGameStatusFunction
end

function this.RegisterTitleModeOnEnterFunction( titleModeOnEnterFunction )
	mvars.title_titleModeOnEnterFunction = titleModeOnEnterFunction
end




function this.DoEnableGameStatusFunction()
	if mvars.title_enableGameStatusFunction then
		mvars.title_enableGameStatusFunction()
	else
		Fox.Error("Not registerd enableGameStatusFunction")
	end
end

function this.DoDisableGameStatusFunction()
	if mvars.title_disableGameStatusFunction then
		mvars.title_disableGameStatusFunction()
	else
		Fox.Error("Not registerd disableGameStatusFunction")
	end
end




function this.RegisterMessageFunction( messageFunc )
	mvars.title_messageFunction = messageFunc
end




function this.HideTitleOnInitialize()
	mvars.title_hideTitleMenuOnInitialize = true
end




function this.StartPressStartMenu()
	mvars.title_hideTitleMenuOnInitialize = false
	if vars.missionCode == 10010 then
		Fox.Log("title_sequence.StartPressStartMenu() : cypr mode")

		
		local isExistSaveData
		if not TppSave.IsNewGame() then
			isExistSaveData = true
		else
			isExistSaveData = false
		end

		TppUiCommand.StartPressStartCyprusTitle( isExistSaveData )
	else
		Fox.Log("title_sequence.StartPressStartMenu() : helispace mode")
		TppUiCommand.StartPressStartMenu()
	end
end




function this.StartTitleMenu()
	mvars.title_hideTitleMenuOnInitialize = false
	if vars.missionCode == 10010 then
		Fox.Log("title_sequence.StartTitleMenu() : cypr mode")
		TppUiCommand.StartCyprusTitle( mvars.isExistSaveData )
	else
		Fox.Log("title_sequence.StartTitleMenu() : helispace mode")
		TppUiCommand.StartTitleMenu( mvars.isExistSaveData )
	end
end




function this.MergeMessageTable( base, addMessages )
	if not addMessages then
		return base
	end
	if not Tpp.IsTypeTable( addMessages ) then
		return base
	end
	for srv, srvTbl in pairs(addMessages) do
		base[srv] = base[srv] or {}
		for index, msgAct in ipairs(srvTbl) do
			table.insert( base[srv], msgAct )
		end
	end
	return base
end








function this.MissionPrepare()
	Fox.Log("title_sequence.MissionPrepare")
end








sequences.Seq_Demo_StartHasTitleMission = {
	Messages = function()
		local titleMessages = StrCode32Table {
		
			UI = {
				{	
					msg = "TitleMenu", sender = "PressStart",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_PushStart")
					end,
				},
				{	
					msg = "PressStart",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_PushStart")
					end,
				},
				{	
					msg = "EndCyprusTitle",
					func = function()
						TppSequence.SetNextSequence("Seq_Game_PushStart")
					end,
				},
				{	
					msg = "EndFadeIn", sender = "FadeInOnStartTitle",
					func = function()
						if gvars.ini_isReturnToTitle then
							TppSequence.SetNextSequence("Seq_Game_PushStart")
						end
					end,
				},
				{
					msg = "TitleMenuReady",
					func = function()
						
						
						if currentMissionCode ~= 10010 then
							TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnStartTitle", nil, { exceptGameStatus = exceptGameStatus } )
						end
					end,
				},
			},
		}

		local registMessages
		if mvars.title_messageFunction then
			registMessages = mvars.title_messageFunction()
		end

		titleMessages = this.MergeMessageTable( titleMessages, registMessages )

		return titleMessages
	end,
	
	OnEndShowSplashScreen = function ()
	
		if not TppGameSequence.IsMaster() then
			if Chunk.GetChunkState(Chunk.INDEX_CYPR) ~= Chunk.STATE_INSTALLED then
				Fox.Warning("Cypr Chunk not Installed.")
			end
		end
		currentMissionCode = vars.missionCode	
		this.DoDisableGameStatusFunction()

		if gvars.ini_isTitleMode then
			
			TppSave.VarSaveMbMangement()
		
			if Tpp.IsMaster() then
				TppUiStatusManager.SetStatus( "TitleMenu", "DISABLE_RESTART_HELI" )
			else
				TppUiStatusManager.UnsetStatus( "TitleMenu", "DISABLE_RESTART_HELI" )
			end
		
			if mvars.title_titleModeOnEnterFunction then
				mvars.title_titleModeOnEnterFunction()
			end

			if currentMissionCode ~= 10010 then
				
				TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnStartTitle", nil, { exceptGameStatus = exceptGameStatus } )
			end
			
			
			local exceptGameStatus = Tpp.GetAllDisableGameStatusTable()

			if not gvars.ini_isReturnToTitle then
				if not mvars.title_hideTitleMenuOnInitialize then
					this.StartPressStartMenu()
				end
			end
		elseif currentMissionCode == 10010 then
			this.DoEnableGameStatusFunction()
			
			TppSequence.SetNextSequence(mvars.title_missionGameSequenceName)
		else
			this.DoEnableGameStatusFunction()
			TppDemo.EnableInGameFlagIfResereved()
			TppSequence.SetNextSequence(mvars.title_missionGameSequenceName)
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnStartMissionGame")
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
		local kjpLogoScreenId = SplashScreen.GetSplashScreenWithName("kjpLogo")
		if kjpLogoScreenId then
			if DebugText then
				local context = DebugText.NewContext()
				DebugText.Print(context, "Waiting KJP Logo...")
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

		
		if gvars.ini_isTitleMode then
			if not mvars.startHasTitleSeqeunceMbSyc then
				mvars.startHasTitleSeqeunceMbSyc = true
				TppMotherBaseManagement.OnTitleLoaded() 
				TppMotherBaseManagement.ProcessBeforeSync()
				TppMotherBaseManagement.StartSyncControl{}
			end
		end
		
		if not TppMotherBaseManagement.IsEndedSyncControl() then
			if DebugText then
				local context = DebugText.NewContext()
				DebugText.Print(context, "Waiting TppMotherBaseManagement sync process finish ...")
			end
			return
		end

		
		if not mvars.startHasTitileSeqeunce then
			mvars.startHasTitileSeqeunce = true
			self.OnEndShowSplashScreen()
		end
		
	end,

	OnLeave = function ()
	end,

}





local NEWGAME_CONFIRM_RESULT = TppDefine.Enum{
	"INIT",
	"OK",
	"NO",
	"CANCEL"
}





sequences.Seq_Game_PushStart = {

	Messages = function(self)
		local titleMessages = StrCode32Table {
		
			UI = {
				{
					msg = "PopupClose",
					func = function()
					end,
				},
			},
		}
		local registMessages
		if mvars.title_messageFunction then
			registMessages = mvars.title_messageFunction()
		end

		titleMessages = this.MergeMessageTable( titleMessages, registMessages )

		return titleMessages
	end,

	StartTitleMenu = function()
		Fox.Log("StartTitleMenu")
		mvars.isExistSaveData = true
		TppSequence.SetNextSequence("Seq_Game_TitleMenu")
	end,

	StartTitleMenuWithNoSavedData = function()
		Fox.Log("StartTitleMenuWithNoSavedData")
		mvars.isExistSaveData = false
		TppSequence.SetNextSequence("Seq_Game_TitleMenu")
	end,

	OnEnter = function ( self )
		mvars.newGameConfirmResult = NEWGAME_CONFIRM_RESULT.INIT
		if gvars.ini_isReturnToTitle then
			self.StartTitleMenu()
		end
	end,

	OnUpdate = function ( self )
		if TppUiCommand.IsShowPopup() then
			return
		end

		if TppSave.IsGameDataLoadResultOK() then
			self.StartTitleMenu()
		else
			self.StartTitleMenuWithNoSavedData()
		end
	end,

	OnLeave = function ()
	end,
}





sequences.Seq_Game_TitleMenu = {
	Messages = function(self)
		local titleMessages = StrCode32Table {
		
			UI = {
				
				{
					msg = "TitleMenu", sender = "Continue",
					func = self.OnSelectContinue,
				},
				{
					msg = "TitleMenu", sender = "RestartHeli",
					func = self.OnSelectRestartHeli,
				},
				
				{
					msg = "TitleMenu", sender = "GameStart",
					func = self.OnSelectGameStart,
				},
				{
					msg = "GameStart",
					func = self.OnSelectGameStart,
				},
				{
					msg = "Continue",
					func = self.OnSelectContinue,
				},
				
				{
					msg = "StartMGO",
					func = self.OnSelectMGO,
				},
				{
					msg = "GzSaveDataLoaded",
					func = function()
						TppSave.SaveOnlyGlobalData()
					end,
				},
			},
		}
		local registMessages
		if mvars.title_messageFunction then
			registMessages = mvars.title_messageFunction()
		end

		titleMessages = this.MergeMessageTable( titleMessages, registMessages )

		return titleMessages
	end,

	OnEnter = function ()
		if not mvars.title_hideTitleMenuOnInitialize then
			this.StartTitleMenu()
		end
	end,

	OnLeave = function ( self, nextSequenceName )
	end,
	
	OnSelectRestartHeli = function()
		this.SetOnSelectFlag( SELECT_FLAG.SELECT_RESTART_HELI )
		TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
	end,
	OnSelectContinue = function()
		if TppMission.IsHelicopterSpace(gvars.title_nextMissionCode)
		or ( gvars.title_nextMissionCode == 10115 )
		or ( gvars.title_nextMissionCode == 50050 ) then
			this.SetOnSelectFlag( SELECT_FLAG.SELECT_RESTART_HELI )
		else
			this.SetOnSelectFlag( SELECT_FLAG.SELECT_CONTINUE )
		end
		TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
	end,
	OnSelectGameStart = function()
		this.SetOnSelectFlag( SELECT_FLAG.SELECT_GAME_START )
		TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
	end,
	OnSelectMGO = function()
		this.SetOnSelectFlag( SELECT_FLAG.SELECT_MGO )
		TppSequence.SetNextSequence("Seq_Demo_CheckDlc")
	end,
}

sequences.Seq_Demo_CheckDlc = {
	OnEnter = function(self)
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
		if TppSave.IsSavingWithFileName( fileName ) or  TppSave.HasQueue( fileName ) then
			return
		end

		TppSequence.SetNextSequence("Seq_Game_ChunkLoading")
	end,
}


local OK_BUTTON = 1
local CANCEL_BUTTON = 2
sequences.Seq_Game_ChunkLoading = {
	OnEnter = function(self)
		if gvars.str_storySequence < TppDefine.STORY_SEQUENCE.CLEARD_ESCAPE_THE_HOSPITAL then
			Fox.Log("Now cypr title skip chunk installation check.")
			TppSequence.SetNextSequence("Seq_Game_ChunkInstalled")
			return
		end
		
		Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_FAST)
		self.chunkIndex = self.GetChunkIndex()
		Chunk.PrefetchChunk(self.chunkIndex)
	end,

	OnUpdate = function(self)
		if Chunk.GetChunkState(self.chunkIndex) == Chunk.STATE_INSTALLED then
			Fox.Log("Install Chunk Index:" ..tostring(self.chunkIndex) )
			
			if TppUiCommand.IsShowPopup( TppDefine.ERROR_ID.NOW_INSTALLING ) then
				TppUiCommand.ErasePopup()
			end
			TppSequence.SetNextSequence("Seq_Game_ChunkInstalled")
			return
		end
		
		Tpp.ShowChunkInstallingPopup( self.chunkIndex, true )	
		
		
		TppUI.ShowAccessIconContinue()
	end,
	
	Messages = function(self)
		local titleMessages = StrCode32Table {
		
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
		local registMessages
		if mvars.title_messageFunction then
			registMessages = mvars.title_messageFunction()
		end

		titleMessages = this.MergeMessageTable( titleMessages, registMessages )

		return titleMessages
	end,

	OnLeave = function ( self, nextSequenceName )
		
		Chunk.SetChunkInstallSpeed(Chunk.INSTALL_SPEED_NORMAL)
	end,
	GetChunkIndex = function()
		local isMGO
		if this.GetOnSelectFlag() == SELECT_FLAG.SELECT_MGO then
			isMGO = true
		end
		local chunkIndex = Tpp.GetChunkIndex( gvars.title_nextLocationCode, isMGO )
		return chunkIndex
	end,

}



sequences.Seq_Game_ChunkCanceled = {
	OnEnter = function(self)
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.INSTALL_CANCEL, Popup.TYPE_TWO_BUTTON )
	end,
	Messages = function(self)
		local titleMessages = StrCode32Table {
		
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.INSTALL_CANCEL,
					func = function()
						local select = TppUiCommand.GetPopupSelect()
						if select == OK_BUTTON then 
							TppUiCommand.RebootTitleSelectMenu() 
							TppSequence.SetNextSequence("Seq_Game_TitleMenu")
						else 
							TppSequence.SetNextSequence("Seq_Game_ChunkLoading")
						end
					end,
				},
			},
		}
		local registMessages
		if mvars.title_messageFunction then
			registMessages = mvars.title_messageFunction()
		end
		titleMessages = this.MergeMessageTable( titleMessages, registMessages )
		return titleMessages
	end,
}

sequences.Seq_Game_ChunkInstalled = {
	OnEnter = function(self)
		local onSelect = this.GetOnSelectFlag()
		if onSelect == SELECT_FLAG.SELECT_GAME_START then
			self.OnSelectGameStart()
		elseif onSelect == SELECT_FLAG.SELECT_CONTINUE then
			self.OnSelectContinue()
		elseif onSelect == SELECT_FLAG.SELECT_RESTART_HELI then
			self.OnSelectRestartHeli()
		elseif onSelect == SELECT_FLAG.SELECT_MGO then
			self.OnSelectMGO()
		end
	end,

	Messages = function(self)
		local titleMessages = StrCode32Table {
		
			UI = {
				{
					msg = "EndFadeOut", sender = "ContinueFromCheckPoint",
					func = self.OnEndFadeOutSelectContinue,
				},
				{
					msg = "EndFadeOut", sender = "GameStart",
					func = self.OnEndFadeSelectGameStart,
				},
				{
					msg = "EndFadeOut", sender = "GoToMgo",
					func = self.OnEndFadeSelectMGO,
				},
			},
		}
		local registMessages
		if mvars.title_messageFunction then
			registMessages = mvars.title_messageFunction()
		end
		titleMessages = this.MergeMessageTable( titleMessages, registMessages )
		return titleMessages
	end,
	
	OnUpdate = function ( self )
		if mvars.startLoadNewGame then
			self.OnUpdateForNewGameLoad()
		end

		self.OnUpdateSelectMGO()
	end,
	
	OnLeave = function()
	end,
	
	OnSelectContinue = function()
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "ContinueFromCheckPoint", nil, { setMute = true } )
	end,

	OnEndFadeOutSelectContinue = function()
		local titleMissionCode = vars.missionCode
		this.DoEnableGameStatusFunction()
		TppMission.SafeStopSettingOnMissionReload()	
		TppSave.VarRestoreOnContinueFromCheckPoint()
		this.ClearTitleMode()
		TppMain.ReservePlayerLoadingPosition(
			TppDefine.MISSION_LOAD_TYPE.CONTINUE_FROM_CHECK_POINT
		)
		gvars.isContinueFromTitle = true
		TppTerminal.AcquirePrivilegeInTitleScreen()

		TppSave.VarSaveMbMangement( titleMissionCode )
		TppSave.CheckAndSavePersonalData()
		TppMission.Load( vars.missionCode, currentMissionCode )
	end,

	OnSelectRestartHeli = function()
		this.DoEnableGameStatusFunction()
		TppMission.EnableInGameFlag()
		this.ClearTitleMode()

		TppTerminal.AcquirePrivilegeInTitleScreen()

		TppSave.VarSave( nil, true )
		TppSave.CheckAndSavePersonalData()
		TppSequence.SetNextSequence(mvars.title_missionGameSequenceName)
		TppTerminal.GetFobStatus()
	end,

	OnSelectGameStart = function()
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "GameStart", nil, { setMute = true } )
	end,

	OnEndFadeSelectGameStart = function()
		TppMission.SafeStopSettingOnMissionReload()
		this.ClearTitleMode()
		TppSave.MakeNewGameSaveData( true ) 
		mvars.startLoadNewGame = true
	end,

	OnUpdateForNewGameLoad = function()
		
		if TppSave.IsEnqueuedSaveData() or IsSavingOrLoading() then
			Fox.Log("Now saveing wait.")
			return
		end
		this.DoEnableGameStatusFunction()
		TppMission.Load( vars.missionCode, currentMissionCode, { showLoadingTips = false } )
	end,

	OnSelectMGO = function()
		Fox.Log("OnSelectMGO")

		InvitationManager.EnableMessage(false)	

		


		local function TitlePatchDlcCheck()
			local function existPatchDlcFunc()
				TppUiCommand.ErasePopup()
				TppException.isNowGoingToMgo = true		
				TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "GoToMgo", nil, { setMute = true } )
			end
			local function notExistPatchDlcFunc()
				
				
				TppUiCommand.ShowErrorPopup( 5103, Popup.TYPE_ONE_BUTTON )
				
				while TppUiCommand.IsShowPopup() do
					coroutine.yield()
				end

				InvitationManager.EnableMessage(true)	
				Tpp.ClearDidCancelPatchDlcDownloadRequest()
				TppSequence.SetNextSequence("Seq_Game_TitleMenu")
			end
		
			return Tpp.PatchDlcCheckCoroutine( existPatchDlcFunc, notExistPatchDlcFunc ) 
		end

		mvars.title_patchDlcCheckCoroutine = coroutine.create(TitlePatchDlcCheck)
	end,

	OnUpdateSelectMGO = function()
		if mvars.title_patchDlcCheckCoroutine then
			local status, ret1 = coroutine.resume(mvars.title_patchDlcCheckCoroutine)

			
			if not TppGameSequence.IsMaster() then
				if ( not status )then
					Fox.Hungup()
				end
			end

			
			
			if ( coroutine.status(mvars.title_patchDlcCheckCoroutine) == "dead" ) 
			or ( not status )then
				mvars.title_patchDlcCheckCoroutine = nil
				return ret1
			end
		end
	end,

	OnEndFadeSelectMGO = function()
		Fox.Log("Start MGO!")
		Mission.SwitchApplication("mgo")
	end,
}

return this