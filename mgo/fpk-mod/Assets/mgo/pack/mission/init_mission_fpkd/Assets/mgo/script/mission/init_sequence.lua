--DEBUGNOW
InfCore.Log("init_sequence internal")--DEBUGNOW
if init_sequence==nil then
	InfCore.Log("ERROR init_sequence==nil")
end
InfCore.PCall(function()return init_sequence end)
if true then return end--DEBUGNOW

local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local TimerStart = GkEventTimerManager.Start

local IS_QA_RELEASE
if ( Fox.GetDebugLevel() == Fox.DEBUG_LEVEL_QA_RELEASE ) then
	IS_QA_RELEASE = true
end

local sequences = {}

this.SKIP_TEXTURE_LOADING_WAIT = true
this.NO_LOAD_UI_DEFAULT_BLOCK = true
this.NO_RESULT = true



this.lastViewedOnlineNewsId = 0



local STANDALONE_MODE = TppSystemUtility.GetIsBeta()






local ERROR_ID_SELECTED_STORAGE_NOT_FOUND = 25009





local ERROR_ID_NOT_SIGN_IN = 22100

local function DebugPrintState(state)
	if DebugText then
		DebugText.Print(DebugText.NewContext(), tostring(state))
	end
end

local function ClosePopupAndWait()
	if TppUiCommand.IsShowPopup() then
		TppUiCommand.ErasePopup()
		while TppUiCommand.IsShowPopup() do
			DebugPrintState("waiting popup closed...")
			coroutine.yield()
		end
	end
end








function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
		
		"Seq_Demo_Start",
		
		"Seq_Demo_SelectLanguage",
		"Seq_Demo_ChangeLanguage",
		"Seq_Demo_BrightnessSetting",
		
		"Seq_Demo_WaitCopyRightLogo",
		
		
		"Seq_Demo_SetInitialLanguage",
		
		"Seq_Demo_SetSavedLanguage",
		
		"Seq_Demo_SetConsoleLanguage",
		
		
		"Seq_Demo_StartCheckNecessaryStorageSpace",
		"Seq_Demo_CheckNecessaryStorageSpace",
		"Seq_Demo_CheckNecessaryStorageSpaceError",
		"Seq_Error_ShowNecessaryStorageSpaceSize",
		
		"Seq_Demo_StartCheckInstall",
		"Seq_Demo_CheckInstall",
		"Seq_Demo_InstallFailed",

		
		"Seq_Demo_ConfirmAutoSave",
		
		"Seq_Demo_StartSignIn",
		"Seq_Demo_SignIn",
		"Seq_Demo_NotSignIn",
		"Seq_Demo_SelectStorage",
		"Seq_Demo_PresetStorageError",
		"Seq_Demo_NoStorageSelected",

		"Seq_Demo_CreateOrLoadSaveData",
		"Seq_Demo_SaveDataError",
		"Seq_Demo_RetryCreateOrLoadSaveData",

		"Seq_Demo_CheckIsExistGameSaveData",
		"Seq_Error_MismatchSaveFileOwner",
		"Seq_Error_UnknownSaveDataExistenceResult",
		"Seq_Demo_ConfirmMakeNewGameSaveData",
		"Seq_Demo_MakeNewGameSaveData",
		"Seq_Error_OnWriteSaveData",
		"Seq_Error_WriteSaveDataResultNoSpacePS4",
		"Seq_Error_WriteSaveDataResultNoSpace",
		"Seq_Error_WriteSaveDataResultNoSpaceShowPopUp",
		"Seq_Error_WriteSaveDataResultUnknown",
		"Seq_Demo_LoadGameSaveData",
		"Seq_Error_ReadSaveData",
		"Seq_Demo_UseBackUpLoadGameSaveData",
		"Seq_Error_FailedLoadGameSaveData",
		"Seq_Error_LoadSaveDataVersionError",

		"Seq_Demo_CheckConfigDataExist",
		"Seq_Demo_LoadConfigData",
		"Seq_Error_FailedLoadConfigData",
		"Seq_Demo_MakeConfigData",

		"Seq_Demo_CheckPersonalDataExist",
		"Seq_Demo_LoadPersonalData",
		"Seq_Error_FailedLoadPersonalData",
		"Seq_Demo_MakePersonalData",

		"Seq_Demo_CheckMgoDataExist",
		"Seq_Demo_LoadMgoData",
		"Seq_Error_FailedLoadMgoData",
		"Seq_Demo_MakeMgoData",

		"Seq_Demo_FinishSaveDataSequence",
		
		"Seq_Demo_LogInKonamiServer",
		"Seq_Demo_WaitForServerData",
		"Seq_Demo_CheckDlc",
		"Seq_Demo_Init",
		"Seq_Demo_StartTitle",
	}
	TppSequence.RegisterSequenceTable(sequences)
end








function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** init MissionPrepare ***")
	if TppEquip.IsCommonBlockActive ~= nil then
		while not TppEquip.IsCommonBlockActive() do
			Fox.Log("init_sequence.MissionPrepare(): Wait Loading EquipCommonBlock.")
			coroutine.yield()
		end
	end
	
	TppMission.AlwaysMissionCanStart()
end

function this.IsWindowsEditor()
	if gvars.DEBUG_initMissionToTitle then
		return false
	end
	if ( Fox.GetPlatformName() == 'Windows' ) and Editor then
		return true
	else
		return false
	end
end

function this.IsNeedStorageSpaceCheck()
	local platform = Fox.GetPlatformName()
	if ( platform == "PS3" ) then
		return true
	else
		return false
	end
end

function this.IsNeedTrophyInstallation()
	local platform = Fox.GetPlatformName()
	if ( platform == "PS3" )
	or ( platform == "PS4" ) then
		return true
	else
		return false
	end
end

function this.IsNeedGameInstallation()
	local platform = Fox.GetPlatformName()
	if ( platform == "Xbox360" )
	or ( platform == "PS3" ) then
		return true
	else
		return false
	end
end

function this.SelectLanguageAndGoSequence( sequenceName, onEndChangeLanguageFunc )
	mvars.init_afterSelectLanguageSequenceName = sequenceName
	mvars.init_onEndChangeLanguageFunc = onEndChangeLanguageFunc
	mvars.init_afterChangeLanguageSequenceName = nil
	TppSequence.SetNextSequence("Seq_Demo_SelectLanguage")
end

function this.ChangeLanguageAndGoSequence( sequenceName )
	mvars.init_afterChangeLanguageSequenceName = sequenceName
	mvars.init_afterSelectLanguageSequenceName = nil
	mvars.init_onEndChangeLanguageFunc = nil
	TppSequence.SetNextSequence("Seq_Demo_ChangeLanguage")
end

function this.ShowLoadingSaveDataPopUp()
	TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
	TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOADING_SAVE_DATA )
end

function this.ShowMakingSaveDataPopUp()
	TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
	TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA )
end

function this.OnWriteSaveDataError()
	mvars.init_isSaveDataWriteError = true
	TppUiCommand.ErasePopup()
end

function this.OnMakeSaveDataResultError()
	if mvars.init_isSaveDataWriteError then
		TppSequence.SetNextSequence("Seq_Error_OnWriteSaveData")
		return
	end

	local writeResult = TppScriptVars.GetLastResult()
	if writeResult == TppScriptVars.RESULT_ERROR_NOSPACE then
		if Fox.GetPlatformName() == "PS4" then
			TppSequence.SetNextSequence("Seq_Error_WriteSaveDataResultNoSpacePS4")
		else
			TppSequence.SetNextSequence("Seq_Error_WriteSaveDataResultNoSpace")
		end
	else
		TppSequence.SetNextSequence("Seq_Error_WriteSaveDataResultUnknown")
	end
		end

function this.OnErrorPopUpCloseConfirmNewSaveData()
	local select = TppUiCommand.GetPopupSelect()
	if select == Popup.SELECT_OK then
		TppSequence.SetNextSequence( "Seq_Demo_ConfirmMakeNewGameSaveData" )
	else
		TppSequence.SetNextSequence("Seq_Demo_CheckIsExistGameSaveData")
	end
end

function this.StartRulesetMission( locationId, missionCode, rulesetId ) 
	vars.rulesetId = rulesetId
	
	TppMission.ResetNeedWaitMissionInitialize()
	gvars.ini_isTitleMode = true
	gvars.ini_isReturnToTitle = false
	TppPlayer.SetStartStatus( TppDefine.INITIAL_PLAYER_STATE.ON_FOOT )
	vars.initialPlayerAction = PlayerInitialAction.STAND
	TppPlayer.ResetDisableAction()
	TppPlayer.ResetInitialPosition()
	TppPlayer.ResetMissionStartPosition()
	TppMission.ResetIsStartFromHelispace()
	TppMission.ResetIsStartFromFreePlay()
	TppMission.VarResetOnNewMission()
	
	if clock then
		TppClock.SetTime( clock )
		TppClock.SaveMissionStartClock()
		Fox.Log( "*** clock = " .. clock )
	end
	
	TppSimpleGameSequenceSystem.Start()

	Fox.Log(" *** locationId = " .. tostring(locationId) )
	Fox.Log(" *** missionCode = " .. tostring(missionCode) )
	
	local currentMissionCode = vars.missionCode
	
	vars.locationCode = locationId
	vars.missionCode = missionCode
	
	local showLoadingTips = true
	if STANDALONE_MODE then
		showLoadingTips = false
	end

	
	
	TppMission.Load( vars.missionCode, currentMissionCode, { showLoadingTips = showLoadingTips } )	
	
	local mode = Fox.GetActMode()
	if( mode == "EDIT" ) then
		Fox.SetActMode( "GAME" )
	end

	if STANDALONE_MODE then
		Fox.Log("### Seq_Demo_ShowKonamiAndFoxLogo ###")
		local konamiLogoScreenId = SplashScreen.GetSplashScreenWithName("konamiLogo")
		local kjpLogoScreenId = SplashScreen.GetSplashScreenWithName("kjpLogo")
		local foxLogoScreenId = SplashScreen.GetSplashScreenWithName("foxLogo")

		
		local function StateCallback(screenId, state)
			if state == SplashScreen.STATE_DELETE then
				Fox.Log("konamiLogoScreen is deleted. show fox logo.")
				SplashScreen.Show( kjpLogoScreenId, 1.0, 4.0, 1.0)
			end
		end
		SplashScreen.SetStateCallback(konamiLogoScreenId, StateCallback)
		
		
		local function StateCallback(screenId, state)
			if state == SplashScreen.STATE_DELETE then
				Fox.Log("konamiLogoScreen is deleted. show fox logo.")
				SplashScreen.Show( foxLogoScreenId, 1.0, 4.0, 1.0)
			end
		end
		SplashScreen.SetStateCallback(kjpLogoScreenId, StateCallback)
		
		SplashScreen.Show( konamiLogoScreenId, 1.0, 4.0, 1.0)
		TppMpBaseRuleset.SetEnabledToSpawnPlayers(false)
	else
		
		SplashScreen.Delete(SplashScreen.GetSplashScreenWithName("konamiLogo"))
		SplashScreen.Delete(SplashScreen.GetSplashScreenWithName("kjpLogo"))
		SplashScreen.Delete(SplashScreen.GetSplashScreenWithName("foxLogo"))
	end
end








sequences.Seq_Demo_Start = {
	OnEnter = function(self)
		TppClock.Stop()
		Fox.Log("### Seq_Demo_Start modified ###")
		
		
		if DEBUG and (Fox.GetPlatformName() == 'Windows') then
			Fox.Log("Debug: Debug Menu Setup")
			if BootContext.GetOption and BootContext.GetOption("join") ~= nil and BootContext.GetOption("host") ~= nil then
				Fox.Log("AutoBoot Client")

				Script.GetScript("/Assets/mgo/level/debug_menu/SelectItem.lua")
				local selector = Selector{ title = "", buttonExit = false }
				ConnectClient(selector, 1)
			elseif BootContext.GetOption and BootContext.GetOption("location") ~= nil then
				Fox.Log("AutoBoot Host")

				local location = BootContext.GetOption("location")
				local mode = BootContext.GetOption("mode")
				if (mode == nil) then
					mode = "Freeplay"
				end

				vars.locationCode = location

				Script.GetScript("/Assets/mgo/level/debug_menu/SelectItem.lua")
				StartMode(mode)	
			end
		end
		
		
		if IS_QA_RELEASE or DEBUG then
			if MissionTest and MissionTest.qaReleaseEntryFunction then
				TppSequence.SetNextSequence("Seq_Demo_Init")
				return
			end
		end
		
		if DEBUG then
			
			if this.IsWindowsEditor() then
				TppSequence.SetNextSequence("Seq_Demo_CheckConfigDataExist")
				return
			end
		end
		
		
		TppSequence.SetNextSequence("Seq_Demo_WaitCopyRightLogo")
	end,
}









sequences.Seq_Demo_SelectLanguage = {
	OnEnter = function( self )
		if BootContext ~= nil and BootContext.GetOption("skipintro") then
			TppSequence.SetNextSequence("Seq_Demo_ChangeLanguage")
			return
		end
		TppUiCommand.ShowLangPopup()
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Now select language ...")
		end
		if not TppUiCommand.IsShowLangPopup() then
			TppSequence.SetNextSequence("Seq_Demo_ChangeLanguage")
		end
	end,
}

sequences.Seq_Demo_ChangeLanguage = {
	OnEnter = function( self )
		TppUiCommand.ChangeLanguage()
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Now wait change language ...")
		end

		TppUI.ShowAccessIconContinue()

		if TppUiCommand.IsChangeLanguage and TppUiCommand.IsChangeLanguage() then
			return
		end
	
		if mvars.init_afterSelectLanguageSequenceName then
			TppSequence.SetNextSequence("Seq_Demo_BrightnessSetting")
		else
			TppSequence.SetNextSequence(mvars.init_afterChangeLanguageSequenceName)
		end
	end,
}


sequences.Seq_Demo_BrightnessSetting = {
	OnEnter = function( self )
		TppUiCommand.OpenBrightnessSetting()
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Now wait brightness setting end...")
		end

		if not TppUiCommand.IsEndBrightnessSetting() then
			return
		end

		if mvars.init_onEndChangeLanguageFunc then
			mvars.init_onEndChangeLanguageFunc()
		end
		
		TppSequence.SetNextSequence(mvars.init_afterSelectLanguageSequenceName)
	end,
}




sequences.Seq_Demo_WaitCopyRightLogo = {
	OnUpdate = function(self)
		local screen = SplashScreen.GetSplashScreenWithName("cesa")
		if not screen then
			if STANDALONE_MODE then
				
				local konamiLogoScreenId = SplashScreen.Create("konamiLogo", "/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_konami_logo_clp_nmp.ftex", 640, 640);
				local kjpLogoScreenId = SplashScreen.Create("kjpLogo", "/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex", 640, 640)
				local foxLogoScreenId = SplashScreen.Create("foxLogo", "/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_fox_logo_clp_nmp.ftex", 640, 640);
			end

			TppSequence.SetNextSequence("Seq_Demo_SetInitialLanguage")
		else
			if DebugText then
				local context = DebugText.NewContext()
				DebugText.Print(context, "Waiting CesaCopyRightLogo ...")
			end
		end
	end,
	
	ignoreSignInUserChanged = true,
}

sequences.Seq_Demo_SetInitialLanguage = {
	OnEnter = function(self)
		local platform = Fox.GetPlatformName()
		if platform == "XboxOne" or platform == "Xbox360" then
			TppSequence.SetNextSequence("Seq_Demo_SetConsoleLanguage")
		else
			TppSequence.SetNextSequence("Seq_Demo_SetSavedLanguage")
		end
	end,
}

this.langCoroutine = nil

local function SetSavedLanguage()
	
	TppSave.LoadConfigDataFromSaveFile()
	while TppScriptVars.IsSavingOrLoading() do
		DebugPrintState("loading CONFIG file...")
		coroutine.yield()
	end
	local result = TppScriptVars.GetLastResult()
	if result ~= TppScriptVars.RESULT_OK then
		return "Seq_Demo_SetConsoleLanguage"
	end
	TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.CONFIG, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_CONFIG )

	
	TppUiCommand.SetLoadIndicatorVisible(true)
	TppUiCommand.ChangeLanguage()
	while TppUiCommand.IsChangeLanguage() do
		DebugPrintState("changing language...")
		coroutine.yield()
	end
	TppUiCommand.SetLoadIndicatorVisible(false)

	return "Seq_Demo_StartCheckNecessaryStorageSpace"
end

sequences.Seq_Demo_SetSavedLanguage = {
	OnEnter = function(self)
		self.nextSequence = nil
		this.langCoroutine = coroutine.create(SetSavedLanguage)
	end,
	OnLeave = function(self)
		this.langCoroutine = nil
		
		TppUiCommand.SetLoadIndicatorVisible(false)
	end,
	OnUpdate = function(self)
		if this.langCoroutine then
			local status, ret1 = coroutine.resume(this.langCoroutine)
			if not status then
				
				Fox.Log("init_sequence", string.format("error on SetSavedLanguage. %s", tostring(ret1)))
				self.nextSequence = "Seq_Demo_SetConsoleLanguage"
				this.langCoroutine = nil
				return
			end
			if coroutine.status(this.langCoroutine) == "dead" then
				
				self.nextSequence = ret1
				this.langCoroutine = nil
			end
		else
			TppSequence.SetNextSequence(self.nextSequence)
		end
	end,
	nextSequence = nil,
}

sequences.Seq_Demo_SetConsoleLanguage = {
	OnEnter = function(self)
		TppUiCommand.SetPlatformLanguage()
		TppUiCommand.ChangeLanguage()
		TppUiCommand.SetLoadIndicatorVisible(true)
	end,
	OnLeave = function(self)
		TppUiCommand.SetLoadIndicatorVisible(false)
	end,
	OnUpdate = function(self)
		if TppUiCommand.IsChangeLanguage() then
			if DebugText then
				DebugText.Print(DebugText.NewContext(), "Set Language with Console Setting...")
			end
			return
		end
		
		TppUiCommand.SetLoadIndicatorVisible(false)
		TppSequence.SetNextSequence("Seq_Demo_StartCheckNecessaryStorageSpace")
	end,
	
	ignoreSignInUserChanged = true,
}





sequences.Seq_Demo_StartCheckNecessaryStorageSpace = {
	OnEnter = function(self)
		if not this.IsNeedStorageSpaceCheck() then
			TppSequence.SetNextSequence("Seq_Demo_StartCheckInstall")
		else
			TppSequence.SetNextSequence("Seq_Demo_CheckNecessaryStorageSpace")
		end
	end,
}

this.storageCoroutine = nil

local function CheckNecessaryStorageSpace()

	
	TppUiCommand.SetPopupType("POPUP_TYPE_NO_BUTTON_NO_EFFECT")
	TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.CHECKING_STORAGE_FREE_SPACE_SIZE)

	
	local freeSpace = 0
	local needSpace = 0
	do
		TppScriptVars.RequestNecessaryStorageSpace()
		while TppScriptVars.IsSavingOrLoading() do
			coroutine.yield()
		end
		local result = TppScriptVars.GetLastResult()
		if result ~= TppScriptVars.RESULT_OK then
			Fox.Error("init_sequence", string.format("error while TppScriptVars.RequestNecessaryStorageSpace(). result:%s", tostring(result)))
			return "Seq_Demo_CheckNecessaryStorageSpaceError"
		end
		needSpace = needSpace + TppScriptVars.GetNecessaryStorageSpaceSize()
		freeSpace = TppScriptVars.GetFreeStorageSpaceSize()
	end

	if needSpace > freeSpace then
		
		mvars.init_needSpace = needSpace
		return "Seq_Error_ShowNecessaryStorageSpaceSize"
	end

	return "Seq_Demo_StartCheckInstall"
end

sequences.Seq_Demo_CheckNecessaryStorageSpace = {
	OnEnter = function(self)
		self.nextSequence = nil
		this.storageCoroutine = coroutine.create(CheckNecessaryStorageSpace)
	end,
	OnLeave = function(self)
		this.storageCoroutine = nil
	end,
	OnUpdate = function(self)
		if this.storageCoroutine then
			local status, ret1 = coroutine.resume(this.storageCoroutine)
			if not status then
				
				Fox.Error("init_sequence", string.format("error on CheckNecessaryStorageSpace. %s", tostring(ret1)))
				self.nextSequence = "Seq_Demo_CheckNecessaryStorageSpaceError"
				this.storageCoroutine = nil
				return
			end

			if coroutine.status(this.storageCoroutine) == "dead" then
				self.nextSequence = ret1
				this.storageCoroutine = nil
			end
		else
			
			if TppUiCommand.IsShowPopup() then
				if DebugText then
					DebugText.Print(DebugText.NewContext(), "waiting popup closed...")
				end
				TppUiCommand.ErasePopup()
			else
				TppSequence.SetNextSequence(self.nextSequence)
			end
		end
	end,

	nextSequence = nil,
}

sequences.Seq_Demo_CheckNecessaryStorageSpaceError = {
	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "error while checking necessary storage space.")
		end
	end,
}


sequences.Seq_Error_ShowNecessaryStorageSpaceSize = {
	OnEnter = function( self )
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		local needSpace = mvars.init_needSpace
		if needSpace == nil then
			needSpace = 0
		end
		local sizeValue, unitLetter, dotPosition = Tpp.GetFormatedStorageSizePopupParam(needSpace)
		TppUiCommand.SetErrorPopupParam( sizeValue, unitLetter, dotPosition )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.SAVE_FAILED_NOT_ENOUGH_STORAGE_CAPACITY )
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "Show necessary storage space size")
		end
	end,
}




sequences.Seq_Demo_StartCheckInstall = {
	OnEnter = function(self)
		if this.IsNeedGameInstallation() then
			TppSequence.SetNextSequence("Seq_Demo_CheckInstall")
		else
			TppSequence.SetNextSequence("Seq_Demo_ConfirmAutoSave")
		end
	end,
}

sequences.Seq_Demo_CheckInstall = {
	OnEnter = function(self)
		TppUiCommand.SetPopupType("POPUP_TYPE_NO_BUTTON_NO_EFFECT")
		TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.NOW_INSTALLATION_CHECKING)
		Installer.StartCheckingInstallation()
	end,
	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "checking if game data is installed...")
		end
		if Installer.IsCheckingInstallation() then
			return
		end
		if TppUiCommand.IsShowPopup() then
			TppUiCommand.ErasePopup()
		else
			if Installer.IsInstalled() then
				TppSequence.SetNextSequence("Seq_Demo_ConfirmAutoSave")
			else
				TppSequence.SetNextSequence("Seq_Demo_InstallFailed")
			end
		end
	end,
}


sequences.Seq_Demo_InstallFailed = {
	OnEnter = function( self )
		local installResult = Installer.GetInstallResult()
		
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		if installResult == Installer.INSTALL_RESULT_NOSPACE then
			TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.INSTALL_FAILED_NOT_ENOUGH_STORAGE_CAPACITY )
		else
			TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.INSTALL_FAILED_UNKNOWN_REASON )
		end
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "Install failed ...")
		end
	end,
}





sequences.Seq_Demo_ConfirmAutoSave = {
	OnEnter = function( self )
		if BootContext ~= nil then
			if DEBUG or BootContext.GetOption("skipintro") then
				TppSequence.SetNextSequence("Seq_Demo_StartSignIn")
				return
			end
		end
		
		
		if SignIn.PresetUserIdExists and SignIn.PresetUserIdExists() then
			TppSequence.SetNextSequence("Seq_Demo_StartSignIn")
			return
		end

		TppUiCommand.SetPopupAllPad()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.CONFIRM_AUTO_SAVE, Popup.TYPE_ONE_BUTTON )
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.CONFIRM_AUTO_SAVE,
					func = function()
						TppSequence.SetNextSequence("Seq_Demo_StartSignIn")
					end,
				},
			},
		}
	end,
}





sequences.Seq_Demo_StartSignIn = {
	OnEnter = function(self)
		Fox.Log("### Seq_Demo_StartSignIn ###11")
		if not SignIn.IsStartupProcessCompleted() then
			TppSequence.SetNextSequence("Seq_Demo_SignIn")
		else
			if SignIn.ClearPresetUserId then
				SignIn.ClearPresetUserId()
			end
			TppSequence.SetNextSequence("Seq_Demo_CreateOrLoadSaveData")
		end
	end,
}

sequences.Seq_Demo_SignIn = {
	OnEnter = function(self)
		Fox.Log("### Seq_Demo_SignIn ###11 "..Fox.GetPlatformName())

		local platform = Fox.GetPlatformName()
		if platform == "XboxOne" or platform == "Xbox360" then
			if SignIn.GetPresetUserId and SignIn.PresetUserIdExists then
				if SignIn.PresetUserIdExists() then
					local userId = SignIn.GetPresetUserId()
					Fox.Log("init", "sign in with preset userId:" .. tostring(userId))
					local error = SignIn.StartSignInWithUserId(userId)
					SignIn.ClearPresetUserId()
					if error then
						
						TppSequence.SetNextSequence("Seq_Demo_NotSignIn")
					end
					return
				end
			end
		end

		local padIndex = TppUiCommand.GetPopupAllPadNo()
		Fox.Log("Set padIndex = " .. tostring(padIndex) )
		
		SignIn.StartSignIn(padIndex)
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "Signing In ...")
		end
		
		if SignIn.GetSignInState() ~= SignIn.SIGN_IN_STATE_BUSY then
			if SignIn.IsOnlineSignedIn() then
				TppSequence.SetNextSequence("Seq_Demo_SelectStorage")
			else
				TppSequence.SetNextSequence("Seq_Demo_NotSignIn")
			end
			
		end
	end,
}

sequences.Seq_Demo_NotSignIn = {
	OnEnter = function(self)
		Fox.Log("### Seq_Demo_NotSignIn ###")
		TppUiCommand.SetPopupAllPad()
		TppUiCommand.ShowErrorPopup(ERROR_ID_NOT_SIGN_IN, Popup.TYPE_ONE_BUTTON)
	end,
	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = ERROR_ID_NOT_SIGN_IN,
					func = function()
						Mission.SwitchApplication("tpp")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_SelectStorage = {
	OnEnter = function(self)
		if BootContext ~= nil then
			if BootContext.GetOption("skipintro") then
				TppSequence.SetNextSequence("Seq_Demo_ConfirmMakeNewGameSaveData")
				return
			end
		end
		Fox.Log("### Seq_Demo_SelectStorage ###")
		local error = SignIn.StartSelectGameSaveStorage()
		if error then
			TppSequence.SetNextSequence("Seq_Demo_PresetStorageError")
		end
	end,

	OnUpdate = function(self)
		if SignIn.GetStorageSelectionState() ~= SignIn.STORAGE_SELECTION_STATE_BUSY then
			if SignIn.IsStorageSelected() then
				TppSequence.SetNextSequence("Seq_Demo_CreateOrLoadSaveData")
			else
				TppSequence.SetNextSequence("Seq_Demo_NoStorageSelected")
			end
		end
	end,

	OnLeave = function(self, nextSequenceName)
		if nextSequenceName ~= "Seq_Demo_NoStorageSelected" then
			if SignIn then
				SignIn.SetStartupProcessCompleted(true)
			end
		end
	end,
}

sequences.Seq_Demo_PresetStorageError = {
	OnEnter = function(self)
		TppUiCommand.SetPopupAllPad()
		TppUiCommand.ShowErrorPopup(ERROR_ID_SELECTED_STORAGE_NOT_FOUND, Popup.TYPE_ONE_BUTTON)
	end,
	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = ERROR_ID_SELECTED_STORAGE_NOT_FOUND,
					func = function()
						Mission.SwitchApplication("tpp")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_NoStorageSelected = {
	OnEnter = function(self)
		Fox.Log("### Seq_Demo_NoStorageSelected ###")
		TppUiCommand.SetPopupSelectNegative()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.NOT_SELECT_STORAGE, Popup.TYPE_TWO_BUTTON )
	end,

	OnLeave = function(self, nextSequenceName)
		if SignIn then
			SignIn.SetStartupProcessCompleted(true)
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.NOT_SELECT_STORAGE,
					func = function()
						local select = TppUiCommand.GetPopupSelect()
						if select == Popup.SELECT_OK then
							TppSave.ForbidSave()
							MgoCharacterData.SetOffline()
							this.SelectLanguageAndGoSequence( "Seq_Demo_Init" )
						else
							TppSequence.SetNextSequence("Seq_Demo_SelectStorage")
						end
					end,
				},
			},
		}
	end,
	
}





this.saveCoroutine = nil

local function CreateOrLoadSaveData()
	local function ChangeLanguage()
		TppUiCommand.ChangeLanguage()
		while TppUiCommand.IsChangeLanguage() do
			DebugPrintState("change language")
			coroutine.yield()
		end
	end

	local SAVE_FILE_CONFIG = 1
	local SAVE_FILE_PERSONAL = 2
	local SAVE_FILE_GAME = 3
	local SAVE_FILE_COUNT = 3

	
	local fileNames = {
		[SAVE_FILE_CONFIG] = TppDefine.CONFIG_SAVE_FILE_NAME,
		[SAVE_FILE_PERSONAL] = TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,
		[SAVE_FILE_GAME] = TppDefine.MGO_SAVE_FILE_NAME,
	}
	
	local saveFuncs = {
		[SAVE_FILE_CONFIG] = function()
			TppSave.VarSaveConfig()
			return TppSave.SaveConfigData(true, true)
		end,
		[SAVE_FILE_PERSONAL] = function()
			TppSave.VarSavePersonalData()
			return TppSave.SavePersonalData(false, true)
		end,
		[SAVE_FILE_GAME] = function()
			Fox.Log("### Seq_Demo_MakeMgoData ###")
			TppSave.VarSaveMGO()
			local saveParams = TppSave.MakeNewSaveQueue(
				TppDefine.SAVE_SLOT.MGO,
				TppDefine.SAVE_SLOT.MGO_SAVE,
				TppScriptVars.CATEGORY_MGO,
				TppDefine.MGO_SAVE_FILE_NAME,
				false 
			)
			return TppSave.DoSave(saveParams, true)
		end,
	}
	
	local saveCheckFuncs = {
	}

	
	local loadFuncs = {
		[SAVE_FILE_CONFIG] = function()
			return TppSave.LoadConfigDataFromSaveFile()
		end,
		[SAVE_FILE_PERSONAL] = function()
			return TppSave.LoadPersonalDataFromSaveFile()
		end,
		[SAVE_FILE_GAME] = function()
			return TppSave.LoadMGODataFromSaveFile()
		end,
	}
	
	local loadCheckFuncs = {
		[SAVE_FILE_CONFIG] = function()
			
			TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.CONFIG, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_CONFIG )
		end,
		[SAVE_FILE_PERSONAL] = function()
			
			TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.PERSONAL, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_PERSONAL )
		end,
		[SAVE_FILE_GAME] = function()
			local readResult = TppScriptVars.GetLastResult()
			local okResult = TppSave.SAVE_FILE_OK_RESULT_TABLE[readResult]
			if okResult then
				
				local saveVersion = TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.MGO, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_MGO )
				local currentVersion = TppDefine.SAVE_FILE_INFO[TppScriptVars.CATEGORY_MGO].version
				if saveVersion <= currentVersion then
					MgoCharacterData.LoadComplete(saveVersion)
					gvars.gameDataLoadingResult = okResult
				else
					
					gvars.gameDataLoadingResult = TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION
				end
			else
				gvars.gameDataLoadingResult = TppDefine.SAVE_FILE_LOAD_RESULT.ERROR_LOAD_FAILED
			end
		end,
	}

	
	gvars.gameDataLoadingResult = TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE

	
	local existCount = 0
	local fileExists = {false, false, false}
	local fileCorrupt = {false, false, false}
	local fileLoaded = {false, false, false}
	local ownerError = false
	local fileCorruptError = false
	for i = 1, SAVE_FILE_COUNT do
		Fox.Log("TppScriptVars.RequestFileExistence[" .. tostring(i).. "]:" .. tostring(fileNames[i]))
		TppScriptVars.RequestFileExistence(fileNames[i])
		while TppScriptVars.IsSavingOrLoading() do
			DebugPrintState("check file existence: " .. fileNames[i])
			coroutine.yield()
		end

		local result = TppScriptVars.GetLastResult()
		if result == TppScriptVars.RESULT_OK then
			local exists = TppScriptVars.GetFileExistence()
			fileExists[i] = exists
			if exists then
				existCount = existCount + 1
			end
		elseif result == TppScriptVars.RESULT_ERROR_OWNER then
			
			ownerError = true
		elseif result == TppScriptVars.RESULT_ERROR_FILE_CORRUPT then
			
			fileCorrupt[i] = true
			fileCorruptError = true
		else
			
			return "Seq_Demo_SaveDataError"
		end
	end

	if fileCorruptError then
		if fileCorrupt[SAVE_FILE_GAME] then
			TppUiCommand.SetPopupSelectNegative()
			TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR, Popup.TYPE_TWO_BUTTON)
			while TppUiCommand.IsShowPopup() do
				DebugPrintState("waiting file-corrupt popup closed...")
				coroutine.yield()
			end
			local popupSelect = TppUiCommand.GetPopupSelect()
			if popupSelect == Popup.SELECT_OK then
				
				for i = 1, SAVE_FILE_COUNT do
					fileExists[i] = false
				end
				existCount = 0
			else
				
				return "Seq_Demo_RetryCreateOrLoadSaveData"
			end
		else
			TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR, Popup.TYPE_ONE_BUTTON)
			while TppUiCommand.IsShowPopup() do
				DebugPrintState("waiting file-corrupt popup closed...")
				coroutine.yield()
			end
		end
	elseif ownerError then
		TppUiCommand.SetPopupSelectNegative()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_OWNER_ERROR, Popup.TYPE_TWO_BUTTON )
		coroutine.yield()
		while TppUiCommand.IsShowPopup() do
			DebugPrintState("waiting owner-error popup closed...")
			coroutine.yield()
		end
		local popupSelect = TppUiCommand.GetPopupSelect()
		if popupSelect == Popup.SELECT_OK then
			
			for i = 1, SAVE_FILE_COUNT do
				fileExists[i] = false
			end
			existCount = 0
		else
			
			return "Seq_Demo_RetryCreateOrLoadSaveData"
		end
	end

	
	
	if existCount < SAVE_FILE_COUNT and Fox.GetPlatformName() == "Xbox360" then
		TppScriptVars.RequestNecessaryStorageSpace()
		while TppScriptVars.IsSavingOrLoading() do
			DebugPrintState("checking necessary storage space...")
			coroutine.yield()
		end

		local result = TppScriptVars.GetLastResult()
		if result == TppScriptVars.RESULT_OK then
			local necessarySize = TppScriptVars.GetNecessaryStorageSpaceSize()
			local freeSize = TppScriptVars.GetFreeStorageSpaceSize()
			if necessarySize > 0 and necessarySize > freeSize then
				return "Seq_Error_WriteSaveDataResultNoSpace"
			end
		else
			
			return "Seq_Demo_SaveDataError"
		end
	end

	
	if not fileExists[SAVE_FILE_CONFIG] then
		
		TppUiCommand.ShowLangPopup()
		while TppUiCommand.IsShowLangPopup() do
			DebugPrintState("select language")
			coroutine.yield()
		end
		
		ChangeLanguage()

		
		TppUiCommand.OpenBrightnessSetting()
		while not TppUiCommand.IsEndBrightnessSetting() do
			DebugPrintState("set brightness")
			coroutine.yield()
		end
	end

	
	if existCount ~= SAVE_FILE_COUNT then
		this.ShowMakingSaveDataPopUp()
	end

	
	for i = 1, SAVE_FILE_COUNT do
		if not fileExists[i] then
			local ret = saveFuncs[i]()
			if ret == TppScriptVars.WRITE_FAILED then
				
				return "Seq_Demo_SaveDataError"
			end

			while TppScriptVars.IsSavingOrLoading() do
				DebugPrintState("create initial file: " .. fileNames[i])
				coroutine.yield()
			end

			local result = TppScriptVars.GetLastResult()
			if result == TppScriptVars.RESULT_OK then
				if saveCheckFuncs[i] ~= nil then
					saveCheckFuncs[i]()
				end
				
				fileExists[i] = true
				existCount = existCount + 1
			elseif result == TppScriptVars.RESULT_ERROR_NOSPACE then
				
				return "Seq_Error_WriteSaveDataResultNoSpace"
			elseif result == TppScriptVars.RESULT_ERROR_INVALID_STORAGE then
				
				return "Seq_Error_WriteSaveDataResultInvalidStorage"
			else
				
				return "Seq_Demo_SaveDataError"
			end
		end
	end

	
	ClosePopupAndWait()

	if existCount > 0 then
		this.ShowLoadingSaveDataPopUp()
	end

	for i = 1, SAVE_FILE_COUNT do
		fileCorrupt[i] = false
	end
	fileCorruptError = false

	
	for i = 1, SAVE_FILE_COUNT do
		if fileExists[i] then
			local ret = loadFuncs[i]()
			if ret == TppScriptVars.READ_FAILED then
				
				return "Seq_Demo_SaveDataError"
			end

			while TppScriptVars.IsSavingOrLoading() do
				DebugPrintState("load " .. tostring(fileNames[i]))
				coroutine.yield()
			end

			local result = TppScriptVars.GetLastResult()
			if result == TppScriptVars.RESULT_OK then
				loadCheckFuncs[i]()
				fileLoaded[i] = true
			elseif result == TppScriptVars.RESULT_ERROR_LOAD_BACKUP then
				loadCheckFuncs[i]()
				fileLoaded[i] = true
			elseif result == TppScriptVars.RESULT_ERROR_FILE_CORRUPT then
				
				fileCorrupt[i] = true
				fileCorruptError = true
			else
				
				return "Seq_Demo_SaveDataError"
			end
		end
	end

	ClosePopupAndWait()

	if fileCorruptError then
		if fileCorrupt[SAVE_FILE_GAME] then
			TppUiCommand.SetPopupSelectNegative()
			TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR, Popup.TYPE_TWO_BUTTON)
			while TppUiCommand.IsShowPopup() do
				DebugPrintState("waiting file-corrupt popup closed...")
				coroutine.yield()
			end
			local popupSelect = TppUiCommand.GetPopupSelect()
			if popupSelect == Popup.SELECT_OK then
				
			else
				
				return "Seq_Demo_RetryCreateOrLoadSaveData"
			end
		else
			TppUiCommand.ShowErrorPopup(TppDefine.ERROR_ID.LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR, Popup.TYPE_ONE_BUTTON)
			while TppUiCommand.IsShowPopup() do
				DebugPrintState("waiting file-corrupt popup closed...")
				coroutine.yield()
			end
		end

		
		for i = 1, SAVE_FILE_COUNT do
			if fileCorrupt[i] then
				local ret = saveFuncs[i]()
				if ret == TppScriptVars.WRITE_FAILED then
					
					return "Seq_Demo_SaveDataError"
				end

				while TppScriptVars.IsSavingOrLoading() do
					DebugPrintState("create recovery file: " .. fileNames[i])
					coroutine.yield()
				end

				local result = TppScriptVars.GetLastResult()
				if result == TppScriptVars.RESULT_OK then
					
				elseif result == TppScriptVars.RESULT_ERROR_NOSPACE then
					
					return "Seq_Error_WriteSaveDataResultNoSpace"
				elseif result == TppScriptVars.RESULT_ERROR_INVALID_STORAGE then
					
					return "Seq_Error_WriteSaveDataResultInvalidStorage"
				else
					
					return "Seq_Demo_SaveDataError"
				end
			end
		end

	end


	
	if fileExists[SAVE_FILE_CONFIG] then
		
		ChangeLanguage()
	end

	if fileExists[SAVE_FILE_GAME] and not fileCorrupt[SAVE_FILE_GAME] then
		local result = gvars.gameDataLoadingResult
		if result == TppDefine.SAVE_FILE_LOAD_RESULT.OK then
			
		elseif result == TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP then
			return "Seq_Demo_UseBackUpLoadGameSaveData"
		elseif result == TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION then
			return "Seq_Error_LoadSaveDataVersionError"
		else
			return "Seq_Demo_SaveDataError"
		end
	end

	return "Seq_Demo_LogInKonamiServer"
end

sequences.Seq_Demo_CreateOrLoadSaveData = {
	OnEnter = function(self)
		if BootContext ~= nil and BootContext.GetOption("skipintro") then
			TppSequence.SetNextSequence("Seq_Demo_ConfirmMakeNewGameSaveData")
			return
		end
		self.nextSequence = nil
		this.saveCoroutine = coroutine.create(CreateOrLoadSaveData)
	end,
	OnLeave = function(self)
		this.saveCoroutine = nil
	end,
	OnUpdate = function(self)
		if this.saveCoroutine then
			local status, ret1 = coroutine.resume(this.saveCoroutine)
			if not status then
				
				Fox.Error("init_sequence", string.format("error on CreateOnLoadSaveData. %s", tostring(ret1)))
				self.nextSequence = "Seq_Demo_SaveDataError"
				this.saveCoroutine = nil
				return
			end

			if coroutine.status(this.saveCoroutine) == "dead" then
				
				Fox.Log("CreateOrLoadSaveData() finished. next: " .. tostring(ret1))
				self.nextSequence = ret1
				this.saveCoroutine = nil
				return
			end
		else
			
			if TppUiCommand.IsShowPopup() then
				if DebugText then
					DebugText.Print(DebugText.NewContext(), "waiting popup closed...")
				end
				TppUiCommand.ErasePopup()
			else
				TppSequence.SetNextSequence(self.nextSequence)
			end
		end

	end,
	nextSequence = nil,
}

sequences.Seq_Demo_SaveDataError = {
	OnEnter = function(self)
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON )
	end,
	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "SaveDataError")
		end
	end,
}

sequences.Seq_Demo_RetryCreateOrLoadSaveData = {
	OnEnter = function(self)
		TppSequence.SetNextSequence("Seq_Demo_CreateOrLoadSaveData")
	end,
}






sequences.Seq_Demo_CheckIsExistGameSaveData = {
	OnEnter = function(self)
		local fileName = TppSave.GetGameSaveFileName()
		TppScriptVars.RequestFileExistence(fileName)

		this.ShowLoadingSaveDataPopUp()
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "Check game save data exists.")
		end

		TppUI.ShowAccessIconContinue()

		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		if TppScriptVars.GetFileExistence() then
			TppSequence.SetNextSequence("Seq_Demo_LoadGameSaveData")
		else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOADING_SAVE_DATA,
					func = function( errorId )
						local result = TppScriptVars.GetLastResult()
						if ( result == TppScriptVars.RESULT_OK ) then
							this.SelectLanguageAndGoSequence( "Seq_Demo_ConfirmMakeNewGameSaveData" )
						elseif ( result == TppScriptVars.RESULT_ERROR_OWNER ) then
							TppSequence.SetNextSequence("Seq_Error_MismatchSaveFileOwner")
						else
							TppSequence.SetNextSequence("Seq_Error_UnknownSaveDataExistenceResult")
						end
					end,
				},
			},
		}
	end,
}

sequences.Seq_Error_MismatchSaveFileOwner = {
	OnEnter = function( self )
		





		TppUiCommand.SetPopupSelectNegative()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_OWNER_ERROR, Popup.TYPE_TWO_BUTTON )
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, {1.0, 0.0, 0.0}, "Check save data exist result : owner error.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_OWNER_ERROR,
					func = this.OnErrorPopUpCloseConfirmNewSaveData,
				},
			},
		}
	end,
}

sequences.Seq_Error_UnknownSaveDataExistenceResult = {
	OnEnter = function( self )
		








		TppUiCommand.SetPopupSelectNegative()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR, Popup.TYPE_TWO_BUTTON )
		Fox.Error("Check save data exist result : unknown error. Call imada.")
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, {1.0, 0.0, 0.0}, "Check save data exist result : unknown error. Call imada.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR,
					func = this.OnErrorPopUpCloseConfirmNewSaveData,
				},
			},
		}
	end,
}

sequences.Seq_Demo_ConfirmMakeNewGameSaveData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_ConfirmMakeNewGameSaveData ###")
		gvars.gameDataLoadingResult = TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE
		this.ShowMakingSaveDataPopUp()
		TppSequence.SetNextSequence("Seq_Demo_MakeNewGameSaveData")
	end,
}

sequences.Seq_Demo_MakeNewGameSaveData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_MakeNewGameSaveData ###")
		local result = TppSave.MakeNewGameSaveData()
		if result == TppScriptVars.WRITE_FAILED then
			this.OnWriteSaveDataError()
		end
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Making New Game Save Data ...")
		end

		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		TppUI.ShowAccessIconContinue()

		local writeResult = TppScriptVars.GetLastResult()
		if writeResult == TppScriptVars.RESULT_OK then
			TppSequence.SetNextSequence("Seq_Demo_CheckConfigDataExist")
		else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
					func = this.OnMakeSaveDataResultError
				},
			},
		}
	end,
}



sequences.Seq_Error_OnWriteSaveData = {
	OnEnter = function( self )
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data write error. call Tago san.")
		end
	end,
}


sequences.Seq_Error_WriteSaveDataResultNoSpacePS4 = {
	OnEnter = function( self )
		TppScriptVars.ShowNoSpaceDialog()
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data result error : no space ps4.")
		end

		if TppScriptVars.IsShowingNoSpaceDialog() then
			return
		end

		TppSequence.SetNextSequence("Seq_Demo_CheckIsExistGameSaveData")
	end,
}


sequences.Seq_Error_WriteSaveDataResultNoSpace = {
	OnEnter = function( self )
		TppScriptVars.RequestNecessaryStorageSpace()
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data result error : checking storage space.")
		end

		TppUI.ShowAccessIconContinue()
			
		if TppScriptVars.IsSavingOrLoading() then
			return
		end
			
		local result = TppScriptVars.GetLastResult()
		if result == TppScriptVars.RESULT_OK then
			TppSequence.SetNextSequence("Seq_Error_WriteSaveDataResultNoSpaceShowPopUp")
		else
			
			TppSequence.SetNextSequence("Seq_Error_WriteSaveDataResultUnknown")
		end
	end,
}


sequences.Seq_Error_WriteSaveDataResultNoSpaceShowPopUp = {
	OnEnter = function( self )
		local buttunSetting = Popup.TYPE_ONE_BUTTON
		if this.IsNeedStorageSpaceCheck() then
			TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )	
			buttunSetting = nil 	
		end
		
		local needSpace = TppScriptVars.GetNecessaryStorageSpaceSize()
		local sizeValue, unitLetter, dotPosition = Tpp.GetFormatedStorageSizePopupParam(needSpace)
		TppUiCommand.SetErrorPopupParam( sizeValue, unitLetter, dotPosition )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.SAVE_FAILED_NOT_ENOUGH_STORAGE_CAPACITY, buttunSetting )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data result error : checking storage space.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					




					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.SAVE_FAILED_NOT_ENOUGH_STORAGE_CAPACITY,
					func = function( errorId )
						TppSequence.SetNextSequence("Seq_Demo_SelectStorage")
					end,
				},
			},
		}
	end,
}


sequences.Seq_Error_WriteSaveDataResultUnknown = {
	OnEnter = function( self )
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.SAVE_FAILED_UNKNOWN_REASON )
	end,
	
	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data result error.")
		end
	end,
}

function this.OnReadSaveDataError()
	mvars.init_isSaveDataReadError = true
	TppUiCommand.ErasePopup()
		end

function this.SetNextSequenceToCheckConfigDataExist()
						TppSequence.SetNextSequence("Seq_Demo_CheckConfigDataExist")
					end

sequences.Seq_Demo_LoadGameSaveData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_LoadGameSaveData ###")
		local result = TppSave.LoadGameDataFromSaveFile()
		if result ~= TppScriptVars.READ_OK then
			this.OnReadSaveDataError()
		end
	end,
	
	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Loading Game Save Data ...")
		end
		
		if TppScriptVars.IsSavingOrLoading() then
			return
		end
			
		if ( gvars.gameDataLoadingResult == TppDefine.SAVE_FILE_LOAD_RESULT.INIT ) then
			TppSave.CheckGameSaveDataLoadResult()
			return
		end
		
		if ( gvars.gameDataLoadingResult == TppDefine.SAVE_FILE_LOAD_RESULT.OK ) then
			this.SetNextSequenceToCheckConfigDataExist()
		else
			TppUiCommand.ErasePopup()
		end
	end,
	
	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOADING_SAVE_DATA,
					func = function()
						if mvars.init_isSaveDataReadError then
							TppSequence.SetNextSequence("Seq_Error_ReadSaveData")
							return
		end
		
			local result = gvars.gameDataLoadingResult
						if ( result == TppDefine.SAVE_FILE_LOAD_RESULT.OK_LOAD_BACKUP ) then
				TppSequence.SetNextSequence("Seq_Demo_UseBackUpLoadGameSaveData")
						elseif ( result == TppDefine.SAVE_FILE_LOAD_RESULT.DIFFER_FROM_CURRENT_VERSION ) then
							TppSequence.SetNextSequence("Seq_Error_LoadSaveDataVersionError")
			else
							TppSequence.SetNextSequence("Seq_Error_FailedLoadGameSaveData")
			end
					end,
				},
			},
		}
	end,
}



sequences.Seq_Error_ReadSaveData = {
	OnEnter = function( self )
		TppUiCommand.SetPopupSelectNegative()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR, Popup.TYPE_TWO_BUTTON )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data write error. call Tago san.")
		end
	end,
	
	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR,
					func = this.OnErrorPopUpCloseConfirmNewSaveData,
				},
			},
		}
	end,
}

sequences.Seq_Demo_UseBackUpLoadGameSaveData = {
	OnEnter = function( self )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_BACKUP_ERROR, Popup.TYPE_ONE_BUTTON )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save data write error. use back up data.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_BACKUP_ERROR,
					func = function()
						this.ShowLoadingSaveDataPopUp()
						this.SetNextSequenceToCheckConfigDataExist()
					end,
				},
			},
		}
	end,
}

sequences.Seq_Error_FailedLoadGameSaveData = {
	OnEnter = function( self )
		TppUiCommand.SetPopupSelectNegative()
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR, Popup.TYPE_TWO_BUTTON )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Save data write error. file corrupt error.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_FILE_CORRUPT_ERROR,
					func = this.OnErrorPopUpCloseConfirmNewSaveData,
				},
			},
		}
	end,
}


sequences.Seq_Error_LoadSaveDataVersionError = {
	OnEnter = function( self )
		TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_VERSION_ERROR )
	end,
}

sequences.Seq_Demo_CheckConfigDataExist = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_CheckConfigDataExist ###")
		TppScriptVars.RequestFileExistence(TppDefine.CONFIG_SAVE_FILE_NAME)
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "Check config data exists.")
		end

		TppUI.ShowAccessIconContinue()

		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		if TppScriptVars.GetFileExistence() then
			TppSequence.SetNextSequence("Seq_Demo_LoadConfigData")
		else
			if DEBUG and this.IsWindowsEditor() then
			TppSequence.SetNextSequence("Seq_Demo_MakeConfigData")
				return
			end
			
			if gvars.gameDataLoadingResult == TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
				TppSequence.SetNextSequence("Seq_Demo_MakeConfigData")
			else
				TppUiCommand.ErasePopup()
			end
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOADING_SAVE_DATA,
					func = function( errorId )
						TppSequence.SetNextSequence("Seq_Error_FailedLoadConfigData")
					end,
				},
			},
		}
	end,
}
	
sequences.Seq_Demo_LoadConfigData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_LoadConfigData ###")
		
		local result = TppSave.LoadConfigDataFromSaveFile()
		if result ~= TppScriptVars.READ_OK then
			this.OnReadSaveDataError()
		end
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Loading Config Data ...")
		end
		
		TppUI.ShowAccessIconContinue()

		if TppScriptVars.IsSavingOrLoading() then
			return
		end
		
		local readResult = TppScriptVars.GetLastResult()
		local okResult = TppSave.SAVE_FILE_OK_RESULT_TABLE[readResult]
		if okResult then
			
			TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.CONFIG, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_CONFIG )
			TppSequence.SetNextSequence("Seq_Demo_CheckPersonalDataExist")
		else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = {
						TppDefine.ERROR_ID.LOADING_SAVE_DATA,
						TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
					},
					func = function()
						TppSequence.SetNextSequence("Seq_Error_FailedLoadConfigData")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Error_FailedLoadConfigData = {
	OnEnter = function( self )
		mvars.init_isErrorLoadConfig = true
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR, Popup.TYPE_ONE_BUTTON )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Save config data load error.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR,
					func = function()
						this.SelectLanguageAndGoSequence( "Seq_Demo_MakeConfigData", this.ShowMakingSaveDataPopUp )
					end,
				},
			},
		}
	end,
}
	
sequences.Seq_Demo_MakeConfigData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_MakeConfigData ###")
		TppSave.VarSaveConfig()
		local result = TppSave.SaveConfigData( true, true ) 
		if result == TppScriptVars.WRITE_FAILED then
			this.OnWriteSaveDataError()
		end
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Making Config Data ...")
		end
		
		TppUI.ShowAccessIconContinue()

		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		local writeResult = TppScriptVars.GetLastResult()
		if writeResult == TppScriptVars.RESULT_OK then
						TppSequence.SetNextSequence("Seq_Demo_CheckPersonalDataExist")
		else
			TppUiCommand.ErasePopup()
					end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
					func = this.OnMakeSaveDataResultError,
				},
			},
		}
	end,
}

sequences.Seq_Demo_CheckPersonalDataExist = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_CheckPersonalDataExist ###")
		mvars.init_personalDataFileExistence = nil
		TppScriptVars.RequestFileExistence(TppDefine.PERSONAL_DATA_SAVE_FILE_NAME)
	end,

	OnUpdate = function(self)
		if DebugText then
			local context = DebugText.NewContext()
			DebugText.Print(context, "Check personal data exists.")
		end

		TppUI.ShowAccessIconContinue()

		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		if mvars.init_personalDataFileExistence == nil then
			mvars.init_personalDataFileExistence = TppScriptVars.GetFileExistence()
		end

		if mvars.init_personalDataFileExistence then
		
			if DEBUG and this.IsWindowsEditor() then
			TppSequence.SetNextSequence("Seq_Demo_LoadPersonalData")
				return
			end
			
			if not mvars.init_isErrorLoadConfig then
				TppSequence.SetNextSequence("Seq_Demo_LoadPersonalData")
			else
				TppUiCommand.ErasePopup()
			end
		else
			if DEBUG and this.IsWindowsEditor() then
			TppSequence.SetNextSequence("Seq_Demo_MakePersonalData")
				return
			end
		
			if gvars.gameDataLoadingResult == TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
				TppSequence.SetNextSequence("Seq_Demo_MakePersonalData")
			else
				TppUiCommand.ErasePopup()
			end
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOADING_SAVE_DATA,	
					func = function( errorId )
						if mvars.init_personalDataFileExistence then
							this.ShowLoadingSaveDataPopUp()
							TppSequence.SetNextSequence("Seq_Demo_LoadPersonalData")
						else
							TppSequence.SetNextSequence("Seq_Error_FailedLoadPersonalData")
						end
					end,
				},
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,	
					func = function( errorId )
						if mvars.init_personalDataFileExistence then
							this.ShowLoadingSaveDataPopUp()
							TppSequence.SetNextSequence("Seq_Demo_LoadPersonalData")	
						else
							TppSequence.SetNextSequence("Seq_Error_FailedLoadPersonalData")	
						end
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_LoadPersonalData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_LoadPersonalData ###")
		
		local result = TppSave.LoadPersonalDataFromSaveFile()
		if result ~= TppScriptVars.READ_OK then
			this.OnReadSaveDataError()
		end
	end,
	
	OnUpdate = function( self )
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Loading Personal Data ...")
		end

		TppUI.ShowAccessIconContinue()
		
		if TppScriptVars.IsSavingOrLoading() then
			return
		end
		
		local readResult = TppScriptVars.GetLastResult()
		local okResult = TppSave.SAVE_FILE_OK_RESULT_TABLE[readResult]
		if okResult then
			TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.PERSONAL, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_PERSONAL )
			mvars.init_configDataLoadResultOK = true
			TppSequence.SetNextSequence("Seq_Demo_CheckMgoDataExist")
			else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOADING_SAVE_DATA,
					func = function()
						TppSequence.SetNextSequence("Seq_Error_FailedLoadPersonalData")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Error_FailedLoadPersonalData = {
	OnEnter = function( self )
		TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR, Popup.TYPE_ONE_BUTTON )
	end,
	
	OnUpdate = function( self )
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Personal data load error.")
		end
	end,
		
	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOAD_RESULT_CONFIG_FILE_CORRUPT_ERROR,
					func = function()
						TppUiCommand.SetPopupType( "POPUP_TYPE_NO_BUTTON_NO_EFFECT" )
						TppUiCommand.ShowErrorPopup( TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA )
						TppSequence.SetNextSequence("Seq_Demo_MakePersonalData")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_MakePersonalData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_MakePersonalData ###")
		TppSave.VarSavePersonalData()
		local result = TppSave.SavePersonalData( true, true ) 
		if result == TppScriptVars.WRITE_FAILED then
			this.OnWriteSaveDataError()
		end
	end,
	
	OnUpdate = function( self )
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Making Personal Data ...")
		end
		
		TppUI.ShowAccessIconContinue()
		
		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		local writeResult = TppScriptVars.GetLastResult()
		if writeResult == TppScriptVars.RESULT_OK then
			TppSequence.SetNextSequence("Seq_Demo_CheckMgoDataExist")
		else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
					func = this.OnMakeSaveDataResultError,
				},
			},
		}
	end,
}




sequences.Seq_Demo_CheckMgoDataExist = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_CheckMgoDataExist ###")
		TppScriptVars.RequestFileExistence( TppDefine.MGO_SAVE_FILE_NAME )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Check MGO Data Exist.")
		end
		TppUI.ShowAccessIconContinue()
		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		if TppScriptVars.GetFileExistence() then
			TppSequence.SetNextSequence("Seq_Demo_LoadMgoData")
		else
			if DEBUG and this.IsWindowsEditor() then
				TppSequence.SetNextSequence("Seq_Demo_MakeMgoData")
				return
			end
			
			if gvars.gameDataLoadingResult == TppDefine.SAVE_FILE_LOAD_RESULT.NOT_EXIST_FILE then
				TppSequence.SetNextSequence("Seq_Demo_MakeMgoData")
			else
				TppUiCommand.ErasePopup()
			end
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.LOADING_SAVE_DATA,
					func = function( errorId )
						TppSequence.SetNextSequence("Seq_Error_FailedLoadMgoData")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_LoadMgoData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_LoadMgoData ###")
		
		local result = TppSave.LoadMGODataFromSaveFile()
		if result ~= TppScriptVars.READ_OK then
			this.OnReadSaveDataError()
		end
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Loading MGO Data.")
		end	
		TppUI.ShowAccessIconContinue()
		if TppScriptVars.IsSavingOrLoading() then
			return
		end
		
		local readResult = TppScriptVars.GetLastResult()
		local okResult = TppSave.SAVE_FILE_OK_RESULT_TABLE[readResult]
		if okResult then
			local saveVersion = TppScriptVars.LoadVarsFromSlot( TppDefine.SAVE_SLOT.MGO, TppScriptVars.GROUP_BIT_VARS, TppScriptVars.CATEGORY_MGO )			
			MgoCharacterData.LoadComplete(saveVersion)
			TppSequence.SetNextSequence("Seq_Demo_FinishSaveDataSequence")
		else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = {
						TppDefine.ERROR_ID.LOADING_SAVE_DATA,
						TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
					},
					func = function()
						TppSequence.SetNextSequence("Seq_Error_FailedLoadMgoData")
					end,
				},
			},
		}
	end,
}

local LOAD_RESULT_MGO_FILE_CORRUPT_ERROR = 1204  
sequences.Seq_Error_FailedLoadMgoData = {
	OnEnter = function( self )
		mvars.init_isErrorLoadConfig = true
		TppUiCommand.ShowErrorPopup( LOAD_RESULT_MGO_FILE_CORRUPT_ERROR, Popup.TYPE_ONE_BUTTON )
	end,

	OnUpdate = function(self)
		if DebugText then
			DebugText.Print(DebugText.NewContext(), {1.0, 0.0, 0.0}, "Error Loading MGO Data.")
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = LOAD_RESULT_MGO_FILE_CORRUPT_ERROR,
					func = function()
						TppSequence.SetNextSequence("Seq_Demo_MakeMgoData")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_MakeMgoData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_MakeMgoData ###")
		TppSave.VarSaveMGO()
		local saveParams = TppSave.MakeNewSaveQueue(
			TppDefine.SAVE_SLOT.MGO,
			TppDefine.SAVE_SLOT.MGO_SAVE,
			TppScriptVars.CATEGORY_MGO,
			TppDefine.MGO_SAVE_FILE_NAME,
			true 
		)
		local result = TppSave.DoSave( saveParams, true ) 
		if result == TppScriptVars.WRITE_FAILED then
			this.OnWriteSaveDataError()
		end
	end,
	
	OnUpdate = function( self )
		if DebugText then
			DebugText.Print(DebugText.NewContext(), "Making MGO Data.")
		end
		TppUI.ShowAccessIconContinue()
		if TppScriptVars.IsSavingOrLoading() then
			return
		end

		local writeResult = TppScriptVars.GetLastResult()
		if writeResult == TppScriptVars.RESULT_OK then
			TppSequence.SetNextSequence("Seq_Demo_LoadMgoData")
		else
			TppUiCommand.ErasePopup()
		end
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
					func = this.OnMakeSaveDataResultError,
				},
			},
		}
	end,
}




sequences.Seq_Demo_FinishSaveDataSequence = {
	OnEnter = function( self )

		
		this.lastViewedOnlineNewsId = vars.infoIdForMGO
		Fox.Log( "last viewed online news id: " .. tostring(this.lastViewedOnlineNewsId) )

		if DEBUG and this.IsWindowsEditor() then
			this.ChangeLanguageAndGoSequence( "Seq_Demo_LogInKonamiServer" )
			return
		end
	
		TppUiCommand.ErasePopup()
	end,

	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "PopupClose",
					sender = {
						TppDefine.ERROR_ID.MAKE_NEW_SAVE_DATA,
						TppDefine.ERROR_ID.LOADING_SAVE_DATA,
					},
					func = function( errorId )
						this.ChangeLanguageAndGoSequence( "Seq_Demo_LogInKonamiServer" )
					end,
				},
			}
		}
	end,
}

sequences.Seq_Demo_LogInKonamiServer = {
	Messages = function(self)
		return StrCode32Table{
			Network = {
				{
					msg = "EndLogin",
					func = function()
						TppSequence.SetNextSequence("Seq_Demo_WaitForServerData")
					end,
				},
			},
		}
	end,

	OnEnter = function( self )
		TppServerManager.StartLogin()
	end,
}

sequences.Seq_Demo_WaitForServerData = {
	OnEnter = function( self )
		Fox.Log("### Seq_Demo_WaitForServerData ###")
	end,
	
	OnUpdate = function( self )
		if MgoCharacterData.IsLoaded( MgoCharacterData.CONNECTION_CHECK_IDLE ) then
			TppSequence.SetNextSequence("Seq_Demo_CheckDlc")		
		end
	end,
}




sequences.Seq_Demo_CheckDlc = {
	OnEnter = function(self)
		TppUiCommand.ShowDlcAnnouncePopup()
	end,
	
	Messages = function(self)
		return StrCode32Table{
			UI = {
				{
					msg = "EndDlcAnnounce",
					func = function( isChange )
						
						
						if isChange == 0 then
							
							gvars.isChangeDlcStatus = true
						end
						TppSequence.SetNextSequence("Seq_Demo_Init")
					end,
				},
			},
		}
	end,
}

sequences.Seq_Demo_Init = {
	OnEnter = function( self )
		if SignIn then
			SignIn.SetStartupProcessCompleted(true)
		end

		local savePersonalData = false
		if vars.isPersonalDirty == 1 then
			savePersonalData = true
		end

		
		if this.lastViewedOnlineNewsId ~= vars.infoIdForMGO then
			Fox.Log("Last viewed online news id changed [" .. tostring(this.lastViewedOnlineNewsId) .. " -> " .. tostring(vars.infoIdForMGO) .. "] - save personal data")
			savePersonalData = true
		else
			Fox.Log("Last viewed online news id unchanged: " .. tostring(vars.infoIdForMGO) )
		end

		if savePersonalData then
			TppSave.VarSavePersonalData()
			TppSave.SavePersonalData()
		end

		TppUiCommand.CreateEmblem( 'MyEmblem' )
		AvatarPreloadTextureDaemon.PreloadRequestForLocalPlayer()

		PlayRecord.RegistPlayRecord( "MGO_START_UP" )
	
		TppSequence.SetNextSequence("Seq_Demo_StartTitle")
	end,
}
	
sequences.Seq_Demo_StartTitle = {
	OnEnter = function( self )
		if Tpp.IsMaster() then
			Fox.Log("init mission : StartTitle for master")
			if MgoSocialManager.CheckAndHandleInvite() then
				Fox.Log("### Invited ###")
			else
				this.StartRulesetMission( 101, 6, 4 )
			end
		elseif gvars.DEBUG_initMissionToTitle then
			Fox.Log("init mission : StartTitle for debug")
			this.StartRulesetMission( 101, 6, 4 )
		else
			local platform = Fox.GetPlatformName()
			if Selector then
				if platform ~= 'Windows' or not Editor then
					if MgoSocialManager.CheckAndHandleInvite() then
						Fox.Log("### Invited ###")
					elseif BootContext.GetOption("ihost") ~= nil then
						Fox.Log("### Test Host ###")
						MgoMatchMakingManager.HostTestMatch(BootContext.GetOption("ihost"), BootContext.GetOption("location"), BootContext.GetOption("mode"), BootContext.GetOption("dn"))
					elseif BootContext.GetOption("ijoin") ~= nil then
						Fox.Log("### Test Join ###")
						MgoMatchMakingManager.JoinTestMatch(BootContext.GetOption("ijoin"))
					else
						this.StartRulesetMission( 101, 6, 4 )
					end
					return
				else
					local mode = Fox.GetActMode()
					if( mode == "GAME" ) then
						Fox.SetActMode( "EDIT" )
					end
					TppUI.FadeIn(TppUI.FADE_SPEED.FADE_MOMENT)
					TppSoundDaemon.ResetMute( 'Loading' )	
				end
			else
				
				if MgoSocialManager.CheckAndHandleInvite() then
					Fox.Log("### Invited ###")
				elseif BootContext.GetOption("ihost") ~= nil then
					Fox.Log("### Test Host ###")
					MgoMatchMakingManager.HostTestMatch(BootContext.GetOption("ihost"), BootContext.GetOption("location"), BootContext.GetOption("mode"), BootContext.GetOption("dn"))
				elseif BootContext.GetOption("ijoin") ~= nil then
					Fox.Log("### Test Join ###")
					MgoMatchMakingManager.JoinTestMatch(BootContext.GetOption("ijoin"))
				else
					this.StartRulesetMission( 101, 6, 4 )
				end
			end
		end
	end,
}




return this