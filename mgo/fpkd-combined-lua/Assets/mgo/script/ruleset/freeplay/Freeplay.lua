









local this = {}
local IS_QA_RELEASE
if ( Fox.GetDebugLevel() == Fox.DEBUG_LEVEL_QA_RELEASE ) then
	IS_QA_RELEASE = true
end

this.requires = {
	"/Assets/mgo/script/utils/RulesetCallbacks.lua",
	"/Assets/mgo/script/utils/SpawnHelpers.lua",
	"/Assets/mgo/script/utils/GimmickIDs.lua",
	"/Assets/mgo/script/ruleset/freeplay/Freeplay_Spawning.lua",
	"/Assets/mgo/script/ruleset/freeplay/Freeplay_Scoring.lua",
	"/Assets/mgo/script/ruleset/freeplay/Freeplay_Loadout.lua",
	"/Assets/mgo/script/ruleset/freeplay/Freeplay_Config.lua",
}
this.POI_SYSTEM_ID = nil;







this.AddParam = function(data)
	data:AddDynamicParam("bool", "DisableDebugFly")
	data.DisableDebugFly = false

	data:AddDynamicParam("String", "RespawnOption")
	data.RespawnOption = "Locator"
end




this.ClearParam = function(data)
	data.RemoveDynamicParam("DisableDebugFly")
	data:RemoveDynamicParam("RespawnOption")
end











this.notificationGroupIds =
{
	DEFAULT			= 0,
	MISSION_DD		= 1,
	MISSION_XOF		= 2,
}

this.notificationGroups = 
{
	
	{
		id					= this.notificationGroupIds.DEFAULT,
		xPos				= 1280 - 350,
		yPos				= 200,
		notificationLife	= 8,
		fontHeight			= 16,
		fontWidth			= 8,
		stackUp				= true,
		color				= Color(0, 0, 1, 0.75),
	},
	
	{
		id					= this.notificationGroupIds.MISSION_DD,
		xPos				= 350,
		yPos				= 250,
		notificationLife	= 8,
		fontHeight			= 32,
		fontWidth			= 16,
		stackUp				= true,
		color				= Color(0, 0, 1, 1),
		teamIndex			= 0,
	},
	
	{
		id					= this.notificationGroupIds.MISSION_XOF,
		xPos				= 280,
		yPos				= 250,
		notificationLife	= 8,
		fontHeight			= 32,
		fontWidth			= 16,
		stackUp				= true,
		color				= Color(0, 0, 1, 1),
		teamIndex			= 1,
	},
}

this.PhaseID = {
	PHASE_INIT						= 0,
	PHASE_ENTER_GAME_TITLE			= 1,	
	PHASE_GAME_TITLE				= 2,	
	PHASE_ENTER_INITIAL_TUTORIAL	= 3,	
	PHASE_INITIAL_TUTORIAL			= 4,	
	PHASE_ENTER_KEY_GUIDE			= 5,	
	PHASE_KEY_GUIDE_MB_TERMINAL		= 6,	
	PHASE_KEY_GUIDE_SYSTEM_MENU		= 7,	
	PHASE_KEY_GUIDE_PARTY_MENU		= 8,	
	PHASE_NO_EVENT					= 9,	
}




this.gameStartSeq = 0

this.poiSystemId = nil

this.textureWaitTime = 0
this.textureWaitFrameTimeLast = 0

this.tutorialPhase = this.PhaseID.PHASE_INIT
this.tutorialTime = 0
this.titleLighting = false
this.titleLightingTime = 0
this.removeTitleLightRequest = false
this.isVisibleCustomizeFloor = false

this.isDemoPlay = false
this.textureLoadWaitRatio = 0.8







this.AddObjectiveBlip = function( )	
	Fox.Log( "AddObjectiveBlip Start" )			
	local objectives = GameObject.SendCommand( this.poiSystemId,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_GENERIC,
				tags = { "OBJECTIVE" },
			}
		}
	)

	if ( objectives.resultCount == 0) then
		Fox.Log( "AddObjectiveBlip - Can't find any objective." )			
	else
		Fox.Log( "AddObjectiveBlip - Num of objective found: " .. objectives.resultCount)			
		for i=1, objectives.resultCount do
			Fox.Log( "AddObjectiveBlip - Add Objective" )

			local objective =
			{ 
				keyPlaceIndex = i,
				enabled = true,
				position = 
				{
					objectives.results[i].posX,
					objectives.results[i].posY,
					objectives.results[i].posZ,					
				},
				name = "ANTENNA",
				networkTarget = "ALL",
			}
		 
			Mission.SetKeyPlace(objective)
		end		
	end	
end

function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end




this.SetCurrentClock = function( hour, minute )
	Fox.Log( "SetCurrentClock is called across the network." )	
	WeatherManager.SetCurrentClock(hour, minute)	
	WeatherManager.PauseClock(true)		
	Fox.Log( "RefreshWeather is called across the network." )
end




this.InitialTutorial = {
	state = 0,
	
	Init = function(self)
		self.state = 0
	end,
	
	Update = function(self)

		if self.state == 0 then
			
			if TppUiCommand.IsMbDvcTerminalOpened() == false then
				TppUiCommand.ReserveStartInitialTutorial()
				Player.RequestToOpenMBTerminal()
			end
			self.state = 1
		elseif self.state == 1 then
			
			if TppUiCommand.IsMbDvcTerminalOpened() and TppUiCommand.IsTutorialModePG() then
				self.state = 2
			end
		elseif self.state == 2 then
			
			if TppUiCommand.IsTutorialModePG() == false then
				if TppUiCommand.IsLastTutorialSuccess() then
					if TppUiCommand.IsCharacterDataAlreadyExistForInitialTutorial() == false then
						
						TppUiCommand.OpenSelectInitialCharacterClass()
						self.state = 3
					else
						
						self.state = 7
					end
				else
					
					TppUiCommand.ReserveStartInitialTutorial()
					self.state = 8
				end
			end
		elseif self.state == 3 then
			
			if TppUiCommand.IsOpenCustomizeMenu() then
				self.state = 4
			end
		elseif self.state == 4 then
			
			if TppUiCommand.IsOpenCustomizeMenu() == false then
				
				TppUiCommand.RequestMbDvcOpenCondition{ isForceTutorial=true, tutorialMode="MATCH" }
				Player.RequestToOpenMBTerminal()
				self.state = 5
			end
		elseif self.state == 5 then
			
			if TppUiCommand.IsMbDvcTerminalOpened() and TppUiCommand.IsTutorialModePG() then
				self.state = 6
			end
		elseif self.state == 6 then
			
			if TppUiCommand.IsTutorialModePG() == false then
				if TppUiCommand.IsLastTutorialSuccess() then
					
					self.state = 7
				else
					
					TppUiCommand.ReserveStartInitialTutorial()
					self.state = 8
				end
			end
		elseif self.state == 7 then
			vars.isInitialTutorialFinished = 1
			TppSave.VarSaveMGO()
			TppSave.SaveMGOData()
			self.state = 8
		elseif self.state == 8 then
			TppUiCommand.CloseMbDvcTerminal()
			self.state = 9
		end
		if self.state < 9 then
			return 0
		end
		return 1
	end
}




this.Events = 
{

}













this.OnRulesetRoundStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRulesetRoundStart, unpack(arg)) end
this.OnRulesetRoundEnd = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRulesetRoundEnd, unpack(arg)) end
this.OnRoundCountdownStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundCountdownStart, unpack(arg)) end
this.OnRoundStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundStart, unpack(arg)) end
this.OnPlayerDeath = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDeath, unpack(arg)) end
this.OnPlayerTagged = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerTagged, unpack(arg)) end
this.OnPlayerConnect = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerConnect, unpack(arg)) end
this.OnPlayerDisconnect = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDisconnect, unpack(arg)) end
this.OnPlayerRespawn = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerRespawn, unpack(arg)) end
this.OnPlayerSpawnChoiceExecute = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerSpawnChoiceExecute, unpack(arg)) end
this.OnEventSignal = function( stream )
	local triggeredId, eventCode, triggeringTeam, triggeringPlayerId = Utils.SerializeEvent( stream )
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local triggeringPlayer = nil
	if triggeringPlayerId >= 0 then
		triggeringPlayer = ruleset:GetPlayerFromGameObjectId(triggeringPlayerId)
	else 
		triggeringPlayer = ruleset:GetPlayerFromTeamIndex(triggeringTeam, 0)
	end
	RulesetCallbacks.Multiplex( RulesetCallbacks.CallbackLists.OnEventSignal, triggeredId, eventCode, triggeringTeam, triggeringPlayer ) 
end
this.SetupPlayerLoadout = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.SetupPlayerLoadout, unpack(arg)) end

this.OnRulesetReset = function( ruleset )
	Fox.Log("Init starting")

	RulesetCallbacks.ClearCallbacks()

	
	local ret = true
				and RulesetCallbacks.SetupComponent("spawning", Freeplay_Spawning, this)
				and RulesetCallbacks.SetupComponent("scoring", Freeplay_Scoring, this)
				and RulesetCallbacks.SetupComponent("loadout", Freeplay_Loadout, this)

	Fox.Log( "Freeplay::OnRulesetReset " .. (ret and "successful" or "failed" ) )

	Freeplay_Config.SetReviveConfig(ruleset)
	Freeplay_Config.SetCloakingConfig(ruleset)
	
	if IS_QA_RELEASE or DEBUG then
		Script.LoadLibrary("/Assets/mgo/level/debug_menu/SelectItem.lua")
	end
	
	FadeFunction.CallFadeOut(0.1)

	this.textureWaitTime = 0
	this.textureWaitFrameTimeLast = 0
	
	
	Utils.StopWeatherClock()

	return ret
end





this.IsReadyToInitialize = function()
	return Utils.AllRulesetBlocksAreLoaded()
end





this.Init = function( rulesetData, ruleset )	
	math.randomseed(os.time())
	this.POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )

	local ret = true
				and RulesetCallbacks.InitComponent("spawning", Freeplay_Spawning, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("scoring", Freeplay_Scoring, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("loadout", Freeplay_Loadout, rulesetData, ruleset )

	Fox.Log( "Freeplay::Init " .. (ret and "successful" or "failed" ) )

	local disableDebugFly = false

	if rulesetData.DisableDebugFly ~= nil then
		disableDebugFly = rulesetData.DisableDebugFly
	end

	ruleset:SetDebugFlyEnabled( not disableDebugFly )
	
	this.gameStartSeq = 0

	

	for i = 1, #this.notificationGroups do

		ruleset:RegisterNotificationGroup( this.notificationGroups[ i ] )

	end
	
	Utils.SetupEffects(vars.locationCode, false)
	
	return ret
end





this.IsGamePreLoad = function( rulesetData, ruleset )
	local textureLoadRatio = Mission.GetTextureLoadedRate()
if DEBUG then
	this.DEBUG_Print( "IsGamePreLoad textureLoadRatio:" .. tostring( textureLoadRatio ) .. " / textureLoadWaitRatio:" .. tostring( this.textureLoadWaitRatio ) )
end
	if ((textureLoadRatio >= this.textureLoadWaitRatio) or (this.textureWaitTime <= 0)) then
		return false
	else
		return true
	end

	return false
end




this.CanGameStart = function( rulesetData, ruleset )
	if this.textureWaitFrameTimeLast == 0 then
		this.textureWaitTime = Utils.TextureLoadWaitTimeout
		this.textureWaitFrameTimeLast = Time.GetRawElapsedTimeSinceStartUp()
	else
		local elapsedTime = Time.GetRawElapsedTimeSinceStartUp()
		this.textureWaitTime = this.textureWaitTime - (elapsedTime - this.textureWaitFrameTimeLast)
		this.textureWaitFrameTimeLast = elapsedTime
	end	
	
	local isFreeplayCharacterLoaded = MgoCharacterData.IsLoaded( MgoCharacterData.CONNECTION_CHECK_LOCAL )

	if not this.isDemoPlay and not TppUiCommand.IsShowTitle() then
		DemoDaemon.StopAll()
		DemoDaemon.Play("mgotitle")
		DemoPlayback.SetLoopMode(1)
		this.isDemoPlay = true
		Fox.Log( "demo play mgotitle" )
		return false
	end

	local isTitleDemoPlaying = true
	local isTitleEnvTextureLoaded = true
	
	if this.isDemoPlay then
		isTitleDemoPlaying = DemoDaemon.IsDemoPlaying()
		isTitleEnvTextureLoaded = TppDemoUtility.IsMgoTitleDemoEnvTextureLoadCompleted()
	end

	if( not isTitleDemoPlaying or not isTitleEnvTextureLoaded or not isFreeplayCharacterLoaded or this.IsGamePreLoad( rulesetData, ruleset ) ) then
		return false
	else
		Fox.Log("GAME START")
		if TppSimpleGameSequenceSystem.IsShowLoadScreen then
			if TppSimpleGameSequenceSystem.IsShowLoadScreen() then
				Fox.Warning("not called TppSimpleGameSequenceSystem.SetShowLoadScreen(0)!!!!!!!!")
			else
				Fox.Log("already called TppSimpleGameSequenceSystem.SetShowLoadScreen(0)!!!!!!!!")
			end
		end
		TppSimpleGameSequenceSystem.SetShowLoadScreen( 0 )
		Fox.Log( "Insurance processing TppSimpleGameSequenceSystem.SetShowLoadScreen( 0 )" )
		
		
		
		
		
		
		WeatherManager.RequestWeather(0, 0)
		WeatherManager.SetCurrentClock("15", "00")
		
		GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
		
		return true
	end
end

this.DespawnPlayers = function(ruleset)
	ruleset:DespawnAllPlayers()
	GameObject.SendCommand( {type="MgoActor"}, { id="ResetAll" } )
end





this.RoundEndEval = function( rulesetData, ruleset )	
	

	return false, 0
end




this.InitFrame = function( rulesetData, ruleset )
end

this.DoFrame = function( rulesetData, ruleset )
	local roundState = ruleset.currentState
	
	if this.tutorialPhase == this.PhaseID.PHASE_INIT or this.tutorialPhase >= this.PhaseID.PHASE_ENTER_KEY_GUIDE then
		
		if DemoDaemon.IsDemoPlaying() then
			this.tutorialPhase = this.PhaseID.PHASE_ENTER_GAME_TITLE
			Fox.Log( "next this.tutorialPhase is " .. tostring( this.tutorialPhase ) )
		end
		
		if TppUiCommand.IsMbDvcTerminalOpened() and TppUiCommand.IsTutorialModePG() then
			this.tutorialPhase = this.PhaseID.PHASE_ENTER_INITIAL_TUTORIAL
			Fox.Log("Initial tutorial resumed")
		end
	end
	
	if this.tutorialPhase == this.PhaseID.PHASE_ENTER_GAME_TITLE then
		
		
		TppDataUtility.SetEnableDataFromIdentifier( "id_2015071x_Mgo_Title_Light", "Light_Mgo_Title_Isolate", true, true )
		
		
		TppUiCommand.SendRequestToTitleEffectSet( true )
		
		this.titleLighting				= true
		this.removeTitleLightRequest	= false
		this.tutorialPhase = this.PhaseID.PHASE_GAME_TITLE
		Fox.Log("Start game title")
	elseif this.tutorialPhase == this.PhaseID.PHASE_GAME_TITLE then
		
		if DemoDaemon.IsDemoPlaying() == false then
			this.tutorialPhase = this.PhaseID.PHASE_ENTER_INITIAL_TUTORIAL
			
			
			TppUiCommand.SendRequestToTitleEffectSet( false )
			Fox.Log("================================= TitleEffectSet Off =================================")
		end
	elseif this.tutorialPhase == this.PhaseID.PHASE_ENTER_INITIAL_TUTORIAL then
		
		if vars.isInitialTutorialFinished == 0 then
			this.InitialTutorial:Init()
			this.tutorialPhase = this.PhaseID.PHASE_INITIAL_TUTORIAL
			Fox.Log("Start initial tutorial")
		else
			this.tutorialPhase = this.PhaseID.PHASE_ENTER_KEY_GUIDE
			Fox.Log("Initial tutorial skipped (vars.isInitialTutorialFinished==1)")
		end
	elseif this.tutorialPhase == this.PhaseID.PHASE_INITIAL_TUTORIAL then
		
		if this.InitialTutorial:Update() > 0 then
			this.tutorialPhase = this.PhaseID.PHASE_ENTER_KEY_GUIDE
			Fox.Log( "next this.tutorialPhase is " .. tostring( this.tutorialPhase ) )
		end
	elseif this.tutorialPhase == this.PhaseID.PHASE_ENTER_KEY_GUIDE then
		
		this.removeTitleLightRequest	= true
		this.titleLightingTime			= ruleset:GetTimeSpentInCurrentState()
		this.tutorialPhase				= this.PhaseID.PHASE_KEY_GUIDE_MB_TERMINAL
		Fox.Log("Start button guide")
	elseif this.tutorialPhase == this.PhaseID.PHASE_KEY_GUIDE_MB_TERMINAL then
		
		if DemoDaemon.IsDemoPlaying() == false and roundState == "RULESET_STATE_ROUND_REGULAR_PLAY" then
			
			local time = ruleset:GetTimeSpentInCurrentState()
			if TppUiCommand.IsMbDvcTerminalOpened() or TppUiCommand.IsOpenCustomizeMenu() then
				this.tutorialPhase	= this.PhaseID.PHASE_KEY_GUIDE_SYSTEM_MENU
				Fox.Log( "next this.tutorialPhase is " .. tostring( this.tutorialPhase ) )
				this.tutorialTime	= time
			else
				if this.tutorialTime == 0 then
					
					this.tutorialTime = time
				else
					
					if time - this.tutorialTime > 8 then
						TppUiCommand.CallButtonGuide( "tutorial_mb_device" )
						this.tutorialPhase	= this.PhaseID.PHASE_KEY_GUIDE_SYSTEM_MENU
						Fox.Log( "next this.tutorialPhase is " .. tostring( this.tutorialPhase ) )
						this.tutorialTime	= time
					end
				end
			end
		end
	elseif this.tutorialPhase == this.PhaseID.PHASE_KEY_GUIDE_SYSTEM_MENU then
		
		local time = ruleset:GetTimeSpentInCurrentState()
		if TppUiCommand.IsMbDvcTerminalOpened() or TppUiCommand.IsOpenCustomizeMenu() then
			this.tutorialTime = time - 5	
		else
			
			if time - this.tutorialTime > 8 then
				TppUiCommand.CallButtonGuide( "tutorial_system_menu" )
				
				local platform = Fox.GetPlatformName()
				if platform == 'XboxOne' or platform == 'PS4' then
					this.tutorialPhase = this.PhaseID.PHASE_KEY_GUIDE_PARTY_MENU
				else
					this.tutorialPhase = this.PhaseID.PHASE_NO_EVENT
				end
				Fox.Log( "next this.tutorialPhase is " .. tostring( this.tutorialPhase ) )
				this.tutorialTime = time
			end
		end
	elseif this.tutorialPhase == this.PhaseID.PHASE_KEY_GUIDE_PARTY_MENU then
		
		local time = ruleset:GetTimeSpentInCurrentState()
		if TppUiCommand.IsMbDvcTerminalOpened() or TppUiCommand.IsOpenCustomizeMenu() then
			this.tutorialTime = time - 5	
		else
			
			if time - this.tutorialTime > 8 then
				local platform = Fox.GetPlatformName()
				if platform == 'XboxOne' then
					TppUiCommand.CallButtonGuide( "tutorial_party_menu_xone" )
				else
					TppUiCommand.CallButtonGuide( "tutorial_party_menu" )
				end
				this.tutorialPhase	= this.PhaseID.PHASE_NO_EVENT
				Fox.Log( "next this.tutorialPhase is " .. tostring( this.tutorialPhase ) )
				this.tutorialTime	= 0
			end
		end
	end
	
	
	if this.removeTitleLightRequest	then
		if this.titleLighting then
			local time = ruleset:GetTimeSpentInCurrentState()
			if time - this.titleLightingTime > 4.5 then
				TppDataUtility.SetEnableDataFromIdentifier( "id_2015071x_Mgo_Title_Light", "Light_Mgo_Title_Isolate", false, true )
				this.titleLighting = false
			end
			TppDemoUtility.ResetMgoTitleDemoEnvTextureLoadCompleted()
		else
			this.removeTitleLightRequest = false
		end
	end

	this.UpdateLoadoutFloor()
end

this.OnRulesetStateChange = function( ruleset, newState )
	









	
	if newState == TppMpBaseRuleset.RULESET_STATE_INACTIVE then
		MGOSoundtrack2.Stop()
	elseif newState == TppMpBaseRuleset.RULESET_STATE_GAME_START then
		MGOSoundtrack2.Stop()
	else
		MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_TITLE )
	end
	
end

this.OnPlayerSpawn = function(rulesetData, ruleset, localPlayerSessionId)
	WeatherManager.PauseClock(true)
	Player.SetInfiniteAmmoFromScript( true )
	
	TppSimpleGameSequenceSystem.SetShowLoadScreen(0)
	
	if not TppUiCommand.IsPushStartOnTitle() then
		FadeFunction.CallFadeIn(TppUI.FADE_SPEED.FADE_LOWESTSPEED)
		Fox.Log("CallFadeIn (called by Freeplay.OnPlayerSpawn)")
	end
	Fox.Log( "this.tutorialPhase:" .. tostring( this.tutorialPhase ) )
end

this.ShowStartMatchMenu = function()
	if IS_QA_RELEASE or DEBUG then
		SelectItem.MGORoot()
	end
end

this.HideStartMatchMenu = function()
	if IS_QA_RELEASE or DEBUG then
		SelectItem.MGOClearSelector()
	end
end

this.UpdateLoadoutFloor = function()
	if TppUiCommand.IsOpenCustomizeMenu() or TppUiCommand.IsPlayerInCustomizeMenu() then
		if not this.isVisibleCustomizeFloor then
			
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor2", true, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor3", true, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor4", true, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor5", true, false )
			this.isVisibleCustomizeFloor = true
		end
	else
		if this.isVisibleCustomizeFloor then
			
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor2", false, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor3", false, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor4", false, false )
			TppDataUtility.SetVisibleDataFromIdentifier( "MgoCustomizeStageIdentifier", "Floor5", false, false )
			this.isVisibleCustomizeFloor = false
		end
	end
end





this.DBEUG_LookupObjectiveMessage = function( ruleset, messageId )
	return Utils.DBEUG_LookupObjectiveMessage ( ruleset, messageId )
end

this.DEBUG_Print = function( strings )
	local DebugTextPrint = DebugText.Print
	local context = DebugText.NewContext()
	DebugTextPrint( context, { 0.5, 0.5, 1.0 }, strings )
end




return this






