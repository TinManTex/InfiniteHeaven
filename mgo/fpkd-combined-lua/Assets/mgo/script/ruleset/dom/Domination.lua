









local this = {}
 
this.requires = {
	"/Assets/mgo/script/utils/GimmickIDs.lua",
	"/Assets/mgo/script/utils/RulesetCallbacks.lua",
	"/Assets/mgo/script/utils/SpawnHelpers.lua",
	"/Assets/mgo/script/ruleset/dom/Domination_Spawning.lua",
	"/Assets/mgo/script/ruleset/dom/Domination_Scoring.lua",
	"/Assets/mgo/script/ruleset/dom/Domination_Loadout.lua",
	"/Assets/mgo/script/ruleset/dom/Domination_Config.lua",
	"/Assets/mgo/script/ruleset/dom/Domination_Exfil.lua",
}
this.POI_SYSTEM_ID = nil
this.numDomPoints = 3
this.winner = 0
this.attacker = 0
this.defender = 1
this.round = 1
this.round1Winner = -1
this.emptyTeam = -1
this.teamPointsSolid = 0
this.teamPointsLiquid = 0
this.teamScore = {}
this.doRoundEnd = false


this.stunTracker = {}


this.tranqTracker = {}

this.roundTimeTracker = {}

this.handle = {}

this.ScriptFlags = {
    [ 'Round1' ] = 1,
    [ 'Round2' ] = 2,
    [ 'Countdown1' ] = 3,
    [ 'Countdown2' ] = 4,
    [ 'AnnounceObjective' ] = 5,
} 




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
		xPos				= 50,
		yPos				= 275,
		notificationLife	= 8,
		fontHeight			= 20,
		fontWidth			= 10,
		stackUp				= true,
		color				= Color(1, 1, 1, 1),
	},
	
	{
		id					= this.notificationGroupIds.MISSION_DD,
		xPos				= 50,
		yPos				= 275,
		notificationLife	= 8,
		fontHeight			= 20,
		fontWidth			= 10,
		stackUp				= true,
		color				= Color(1, 1, 1, 1),
		teamIndex			= Utils.Team.SOLID,
	},
	
	{
		id					= this.notificationGroupIds.MISSION_XOF,
		xPos				= 50,
		yPos				= 275,
		notificationLife	= 8,
		fontHeight			= 20,
		fontWidth			= 10,
		stackUp				= true,
		color				= Color(1, 1, 1, 1),
		teamIndex			= Utils.Team.LIQUID,
	},
}



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












this.gameStartSeq = 0

this.rulesetState = nil
this.soundtrackPhase = nil
this.soundAlertRank = 0

this.textureWaitTime = 0
this.textureWaitFrameTimeLast = 0





function string.starts(String,Start)
   return string.sub(String,1,string.len(Start))==Start
end




this.SetCurrentClock = function( hour, minute )
	Fox.Log( "SetCurrentClock is called across the network." )	
	WeatherManager.SetCurrentClock(hour, minute)	
	WeatherManager.PauseClock(true)		
	Fox.Log( "RefreshWeather is called across the network." )
end




this.Events = 
{

}





this.OnRulesetRoundStart = function( ... ) 
	this.stunTracker = {}
	this.tranqTracker = {}
	RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRulesetRoundStart, unpack(arg)) 
	
	Utils.WeatherRequest(vars.locationCode, 1==vars.isNight, true)
	
end

this.OnRulesetRoundEnd = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRulesetRoundEnd, unpack(arg)) end
this.OnRoundStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundStart, unpack(arg)) end
this.OnRoundCountdownStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundCountdownStart, unpack(arg)) end
this.OnPlayerDeath = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDeath, unpack(arg)) end
this.OnPlayerStunned = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerStunned, unpack(arg)) end
this.OnPlayerInterrogated = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerInterrogated, unpack(arg)) end
this.OnPlayerTagged = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerTagged, unpack(arg)) end
this.OnPlayerCharmed = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerCharmed, unpack(arg)) end

this.OnPlayerConnect = function( ... )
	RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerConnect, unpack(arg)) 
	
	local rulesetData, ruleset, player = unpack(arg)
	
	local round1Time = 0;
	local round2Time = 0;
	local roundState = ruleset.currentState
	if roundState == "RULESET_STATE_ROUND_REGULAR_PLAY" or
		roundState == "RULESET_STATE_ROUND_OVERTIME" or 
		roundState == "RULESET_STATE_ROUND_SUDDEN_DEATH" then
		
		local timeSpent = ruleset:GetTimeSpentInCurrentState()
		if timeSpent < 0 then
			timeSpent = 0
		end
		timeSpent = math.floor(timeSpent)
		
		if this.round == 1 then
			round1Time = timeSpent
		end
		if this.round == 2 then
			round2Time = timeSpent
		end
	end
	
	
	this.roundTimeTracker[player.sessionIndex] = { round1Time, round2Time }
	
end

this.OnPlayerDisconnect = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDisconnect, unpack(arg)) end
this.OnPlayerRespawn = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerRespawn, unpack(arg)) end
this.OnPlayerFultonSave = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerFultonSave, unpack(arg)) end
this.OnPlayerSpawnChoiceExecute = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerSpawnChoiceExecute, unpack(arg)) end
this.OnEventSignal = function( stream )
	local triggeredId, eventCode, triggeringTeam, capturerBitArray = Utils.SerializeEvent( stream )
	RulesetCallbacks.Multiplex( RulesetCallbacks.CallbackLists.OnEventSignal, triggeredId, eventCode, triggeringTeam, capturerBitArray ) 
end
this.SetupPlayerLoadout = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.SetupPlayerLoadout, unpack(arg)) end

this.OnRulesetReset = function( ruleset )
	Fox.Log("Init starting")
	
	this.winner = 0
	this.round = 1

	RulesetCallbacks.ClearCallbacks()

	
	local ret = true
				and RulesetCallbacks.SetupComponent("spawning", Domination_Spawning, this)
				and RulesetCallbacks.SetupComponent("scoring", Domination_Scoring, this)
				and RulesetCallbacks.SetupComponent("loadout", Domination_Loadout, this)
				and RulesetCallbacks.SetupComponent("exfil", Domination_Exfil, this)

	Fox.Log( "Domination::OnRulesetReset " .. (ret and "successful" or "failed" ) )
	
	Utils.SetStaminaConfig(ruleset)

	this.textureWaitTime = 0
	this.textureWaitFrameTimeLast = 0
	
	
	Utils.StopWeatherClock()
	
	this.POI_SYSTEM_ID = nil
	this.numDomPoints = 3
	this.winner = 0
	this.attacker = 0
	this.defender = 1
	this.round = 1
	this.round1Winner = -1
	this.emptyTeam = -1
	this.teamPointsSolid = 0
	this.teamPointsLiquid = 0
	this.teamScore = {
		["SOLID"] = 0,
		["LIQUID"] = 0
	}
	
	this.doRoundEnd = false

	this.rulesetState = nil
	this.soundtrackPhase = nil
	this.soundAlertRank = 0

	this.handle = {}
	
	if Mgo.IsHost() then
		local scriptFlags = ruleset:HostGetScriptFlags()
		scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Round1'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	end
	
	return ret
end




this.OnSessionDisconnect = function( rulesetData, ruleset )
	Utils.HandleSessionDisconnect( rulesetData, ruleset )
end





this.IsReadyToInitialize = function()
	return Utils.AllRulesetBlocksAreLoaded()
end


this.OnBuddyStateChanged = function( rulesetData, ruleset, created, buddy1, buddy2 )
	Utils.TryNotifyBuddyChange(ruleset, created, buddy1, buddy2)
end





this.Init = function( rulesetData, ruleset )
	math.randomseed(os.time())
	this.POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )

	local ret = true
				and RulesetCallbacks.InitComponent("spawning", Domination_Spawning, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("scoring", Domination_Scoring, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("loadout", Domination_Loadout, rulesetData, ruleset )
				and RulesetCallbacks.InitComponent("exfil", Domination_Exfil, rulesetData, ruleset )

	Fox.Log( "Domination::Init " .. (ret and "successful" or "failed" ) )

	local disableDebugFly = false

	if rulesetData.DisableDebugFly ~= nil then
		disableDebugFly = rulesetData.DisableDebugFly
	end

	ruleset:SetDebugFlyEnabled( not disableDebugFly )
	
	this.gameStartSeq = 0
	
	for i = 1, #this.notificationGroups do

		ruleset:RegisterNotificationGroup( this.notificationGroups[ i ] )

	end
	
	return ret
end






this.IsGamePreLoad = function( rulesetData, ruleset )
	local textureLoadRatio = Mission.GetTextureLoadedRate()
	
	if ((textureLoadRatio >= Utils.TextureLoadWaitRatio) or (this.textureWaitTime <= 0)) then
		return false
	else
		return true
	end

	return false
end




this.CanGameStart = function( rulesetData, ruleset )
	if this.gameStartSeq == 0 then
		if this.textureWaitFrameTimeLast == 0 then
			this.textureWaitTime = Utils.TextureLoadWaitTimeout
			this.textureWaitFrameTimeLast = Time.GetRawElapsedTimeSinceStartUp()
		else
			local elapsedTime = Time.GetRawElapsedTimeSinceStartUp()
			this.textureWaitTime = this.textureWaitTime - (elapsedTime - this.textureWaitFrameTimeLast)
			this.textureWaitFrameTimeLast = elapsedTime
		end
	
		local textureLoadRatio = Mission.GetTextureLoadedRate()
		
		if ( this.IsGamePreLoad( rulesetData, ruleset ) == false ) then
			this.gameStartSeq = 1
		end
	elseif this.gameStartSeq == 1 then
	
		Fox.Log("GAME START")	

		this.gameStartSeq = 2
		return true
	elseif this.gameStartSeq == 2 then
	
		return true
	end	

	return false
end

this.round2StateFlags = function()
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local scriptFlags = ruleset:HostGetScriptFlags()
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Round1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['Countdown1'] )
	scriptFlags = Utils.ClearFlag( scriptFlags, this.ScriptFlags['AnnounceObjective'] )
	scriptFlags = Utils.SetFlag( scriptFlags, this.ScriptFlags['Round2'] )
	ruleset:HostSetScriptFlags( scriptFlags )
end

this.DespawnPlayers = function(ruleset)
	ruleset:DespawnAllPlayers()
	GameObject.SendCommand( {type="MgoActor"}, { id="ResetAll" } )
	ruleset:HideSpawnChoiceForAll()
	if this.round == 2 then
		this.callbackId = Util.SetInterval(0, true, this._scriptPath, "HostRestart")
	else
		this.round = 2
		this.round1Winner = this.winner
		this.round2StateFlags()
	end
end

this.HostRestart = function()
	local padIndex = Pad.GetMainPadIndex()
	if Pad.GetButtonStatus( padIndex, fox.PAD_B ) then
		TppNetworkUtil.StopDebugSession()
		return false
	end
	return true
end

this.FreeplayReturn = function()
	GimmickIDs.removeTeamIcons()
	if not Mgo.IsHost() then
		vars.locationCode = TppDefine.LOCATION_ID.INIT
		vars.missionCode = TppDefine.SYS_MISSION_ID.INIT
		TppMission.Load( vars.locationCode )
		TppSimpleGameSequenceSystem.SetShowLoadScreen(1)
	else
		Util.SetInterval(8000, false, this._scriptPath, "FreeplayHostReturn")
	end
end

this.FreeplayHostReturn = function()
	vars.locationCode = TppDefine.LOCATION_ID.INIT
	vars.missionCode = TppDefine.SYS_MISSION_ID.INIT
	TppMission.Load( vars.locationCode )
	TppSimpleGameSequenceSystem.SetShowLoadScreen(1)
end


this.RoundEndEval = function( rulesetData, ruleset )

	local scoreDefender = ruleset:GetStatByTeamIndex( this.defender, MgoStat.STAT_COMTIX )
	if scoreDefender < 0 then
		scoreDefender = 0
	end

	if this.emptyTeam == Utils.Team.SOLID then
		this.doRoundEnd = true
		this.winner = Utils.Team.LIQUID
		if this.round == 1 then
			this.round1Winner = this.winner
			TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", 1, this.winner, 0, 0, false )
		end
		this.round = 2
	elseif this.emptyTeam == Utils.Team.LIQUID then
		this.doRoundEnd = true
		this.winner = Utils.Team.SOLID
		if this.round == 1 then
			this.round1Winner = this.winner
			TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", 1, this.winner, 0, 0, false )
		end
		this.round = 2
	end
	
	if ruleset:IsRegularTimeOver() then	
		
		ruleset:ObjectiveNotification( this.attacker, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_TS_ATTACK_LOSE, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
		ruleset:ObjectiveNotification( this.defender, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_TS_ATTACK_LOSE, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
		
		this.winner = this.defender
		this.doRoundEnd = true
	elseif this.emptyTeam > -1 then 
		ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
	elseif scoreDefender <= 0 then
		
		ruleset:ObjectiveNotification( this.attacker, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DOM_ATTACK_WIN, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
		ruleset:ObjectiveNotification( this.defender, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DOM_ATTACK_WIN, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
	
		this.winner = this.attacker
		this.timeToBeat = rulesetData.regularTimeLimit - ruleset:GetTimeSpentInCurrentState()
		this.doRoundEnd = true
	end
	
	
	if this.doRoundEnd then
		this.doRoundEnd = false
		this.teamPointsSolid = this.teamPointsSolid + ruleset:GetStatByTeamIndex( Utils.Team.SOLID, MgoStat.STAT_TEAM_POINTS )
		this.teamPointsLiquid = this.teamPointsLiquid + ruleset:GetStatByTeamIndex( Utils.Team.LIQUID, MgoStat.STAT_TEAM_POINTS )
		local timeSpent = ruleset:GetTimeSpentInCurrentState()
		if timeSpent < 0 then
			timeSpent = 0
		end
		timeSpent = math.floor(timeSpent)
		TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", this.round, this.winner, timeSpent, scoreDefender, true )
		

		local matchWinner
		if this.round == 2 then
			matchWinner = Utils.DetermineMatchWinner(ruleset, this.winner, this.round1Winner, this.teamPointsSolid, this.teamPointsLiquid)
		end
		
		
		local allPlayers = ruleset:GetAllActivePlayers().array
		
		for playerIndex = 1, #allPlayers do
			local player = allPlayers[ playerIndex ]		
			local localPlayerIndex = player.sessionIndex
			
			if this.round == 2 then
				if player.teamIndex == matchWinner then
					ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_MATCHES_WON, 1 )
				else
					ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_MATCHES_LOST, 1 )
				end
			end
			
			ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_TOTAL_PLAYTIME, timeSpent )
			
			if this.round == 1 then
				this.roundTimeTracker[player.sessionIndex][1] = timeSpent - this.roundTimeTracker[player.sessionIndex][1]
			else
				this.roundTimeTracker[player.sessionIndex][2] = timeSpent - this.roundTimeTracker[player.sessionIndex][2]
			end
			
			
		end
		
		
		if this.round == 2 then
			Utils.AwardGearPointsToAllPlayers(ruleset, matchWinner)
			this.AwardMatchEndXPToAllPlayers(ruleset, matchWinner)	
		end
		
		if this.emptyTeam > -1 then 
			return true, this.winner, true
		else
			return true, this.winner
		end
	end
	
	return false, 0
end

this.CheckNoContest = function(ruleset, playerIndex)
	local killCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_KILL )
	local deathCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_DEATH )
	local stunCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_TRANQ )
	local stunnedCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_STUNNED )
	local fultonCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_FULTON )
	local fultonedCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_FULTONED )
	local domCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_DOM )
	local neutralCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_DOM_NEUTRAL )
	local assistCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_ASSIST )
	local tagCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_TAG )

	if killCount == 0 and deathCount == 0 and stunCount == 0 and stunnedCount == 0 and fultonCount == 0
		and fultonedCount == 0 and domCount == 0 and neutralCount == 0 and assistCount == 0 and tagCount == 0 then
		return true
	else
		return false
	end
end


this.AwardMatchEndXPToAllPlayers = function(ruleset, winner)		
	for playerIndex, team in pairs(SpawnHelpers.teamRoster) do
		if not this.CheckNoContest(ruleset, playerIndex) then
			local xpBonus = 0
			if team == winner then
				if this.roundTimeTracker[playerIndex] ~= nil then
					local totalPlayTime = (this.roundTimeTracker[playerIndex][1] + this.roundTimeTracker[playerIndex][2])
					xpBonus = (totalPlayTime / 60) * Utils.DOM_WinBonusPerMin
				end
			else
				if this.roundTimeTracker[playerIndex] ~= nil then
					local totalPlayTime = (this.roundTimeTracker[playerIndex][1] + this.roundTimeTracker[playerIndex][2])
					xpBonus = (totalPlayTime / 60) * Utils.DOM_LossBonusPerMin
				end
			end
			ruleset:IncrementStatByPlayerIndex( playerIndex, MgoStat.STAT_CALC_XP, xpBonus )
		end
	end
end

this.SetWinner = function( round, winner, time, scoreDefender, announce )
	this.winner = winner
	if announce then
		if winner == Utils.Team.SOLID then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_solid_win" )
		else
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_liquid_win" )
		end
	end
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local objectiveComplete = false
	if scoreDefender == 0 then
		objectiveComplete = true
	elseif ruleset.data.DominationTicketCount ~= 0 then
		scoreDefender = scoreDefender * (100 / ruleset.data.DominationTicketCount )
	end
	local localTeam = ruleset:GetLocalPlayerTeam()
	local isAttacker = false
	if localTeam == this.attacker then
		isAttacker = true
	end
	local RoundEndTableData = 
	{
		roundTime = time,
		roundWinnerId = winner,
		isLocalPlayerAttacking = isAttacker,
		ticketCountTeam1 = scoreDefender,
		hasObjective1 = objectiveComplete,
	}
	ruleset:SubmitRoundEndState( round, RoundEndTableData )
end

this.OnMatchEnd = function(rulesetData, ruleset)
	local matchWinner = -1
	local localPlayerIndex = ruleset:GetLocalPlayerSessionIndex()

	if Mgo.IsHost() then
		matchWinner = Utils.DetermineMatchWinner(ruleset, this.winner, this.round1Winner, this.teamPointsSolid, this.teamPointsLiquid)
	end

	if this.CheckNoContest( ruleset, localPlayerIndex ) then
		vars.isNoContest = 1
	else
		vars.isNoContest = 0
	end

	return matchWinner
end




this.InitFrame = function( rulesetData, ruleset )
	Utils.SetupEffects(vars.locationCode, 1==vars.isNight)
	Utils.InitTutorial()
end

this.DoFrame = function( rulesetData, ruleset )
	Utils.DrawTutorial( ruleset, this.round )

	if this.rulesetState ~= TppMpBaseRuleset.RULESET_STATE_ROUND_REGULAR_PLAY
		and this.rulesetState ~= TppMpBaseRuleset.RULESET_STATE_ROUND_OVERTIME
		and this.rulesetState ~= TppMpBaseRuleset.RULESET_STATE_ROUND_SUDDEN_DEATH
	then
		return
	end

	local scoreDefender = ruleset:GetStatByTeamIndex( this.defender, MgoStat.STAT_COMTIX )

	if scoreDefender > 0 then
		local maxDefender = rulesetData.DominationTicketCount
		local remainingTime = vars.roundTimeLimit - ruleset:GetTimeSpentInCurrentState();
		local localTeam = ruleset:GetLocalPlayerTeam()

		if this.soundAlertRank == 1 then
			local doRankUp = false
			local leadTeam = this.attacker

			if scoreDefender * 5 <= maxDefender then
				doRankUp = true
				leadTeam = this.attacker
			elseif remainingTime * 5 <= vars.roundTimeLimit then
				doRankUp = true
				leadTeam = this.defender
			end

			if doRankUp then
				if localTeam == leadTeam then
					TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_mission" )
				else
					TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_enemy" )
				end
				this.soundAlertRank = 2
				this.UpdateSoundtrack()
			end
		elseif this.soundAlertRank == 0 then
			local doRankUp = false
			local leadTeam = this.attacker

			if scoreDefender * 2 <= maxDefender then
				doRankUp = true
				leadTeam = this.attacker
			elseif remainingTime * 2 <= vars.roundTimeLimit then
				doRankUp = true
				leadTeam = this.defender
			end

			if doRankUp then
				if localTeam == leadTeam then
					TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_lead" )
				else
					TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_enemy" )
				end
				this.soundAlertRank = 1
				this.UpdateSoundtrack()
			end
		end
	end
end

this.OnRulesetStateChange = function( ruleset, newState )
	
	this.rulesetState = newState
	this.UpdateSoundtrack()

	if newState == TppMpBaseRuleset.RULESET_STATE_END_OF_MATCH_FLOW then
		if Mgo.IsHost() then
			this.DespawnPlayers(ruleset)
		end
		this.soundAlertRank = 0
	end
end

this.UpdateSoundtrack = function()
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local prevSoundtrackPhase = this.soundtrackPhase

	if this.rulesetState == TppMpBaseRuleset.RULESET_STATE_INACTIVE then
		this.soundtrackPhase = 'BGM_STOP_ALL'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_GAME_START then
		this.soundtrackPhase = 'BGM_STOP_ALL'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_COUNTDOWN then
		this.soundtrackPhase = 'BGM_INTRO'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_REGULAR_PLAY then
		if this.soundAlertRank == 2 then
			this.soundtrackPhase = 'BGM_ALERT'
		elseif ruleset:IsRegularTimeNearEnd() then
			this.soundtrackPhase = 'BGM_EVASION'
		elseif this.soundAlertRank == 1 then
			this.soundtrackPhase = 'BGM_CAUTION'
		else
			this.soundtrackPhase = 'BGM_SNEAK'
		end
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_OVERTIME then
		this.soundtrackPhase = 'BGM_ALERT'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_SUDDEN_DEATH then
		this.soundtrackPhase = 'BGM_ALERT'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_END then
		if ruleset:GetLocalPlayerTeam() == this.winner then
			this.soundtrackPhase = 'BGM_OUTRO_WIN'
		else
			this.soundtrackPhase = 'BGM_OUTRO_LOSE'
		end
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_GAME_END then
		if ruleset:GetLocalPlayerTeam() == this.winner then
			this.soundtrackPhase = 'BGM_OUTRO_WIN'
		else
			this.soundtrackPhase = 'BGM_OUTRO_LOSE'
		end
	end
	
	
	if prevSoundtrackPhase ~= this.soundtrackPhase then
		if this.soundtrackPhase == "BGM_STOP_ALL" then
			MGOSoundtrack2.Stop()
		elseif this.soundtrackPhase == "BGM_INTRO" then
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_START_JINGLE )
		elseif this.soundtrackPhase == "BGM_ALERT" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_ALERT )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_EVASION" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_EVASION )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_CAUTION" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_CAUTION )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_SNEAK" then
			MGOSoundtrack2.SetPhase( MGOSoundtrack2.BGM_PHASE_SNEAK )
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_PHASE )
		elseif this.soundtrackPhase == "BGM_OUTRO_WIN" then
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_WIN_JINGLE )
		elseif this.soundtrackPhase == "BGM_OUTRO_LOSE" then
			MGOSoundtrack2.Play( MGOSoundtrack2.BGM_TYPE_LOSE_JINGLE )
		end
	end
end

this.setSoundTrack = function(final)
	local ruleset = MpRulesetManager.GetActiveRuleset()
	if final then
		if this.soundtrackPhase ~= 'BGM_ALERT' then
			this.soundtrackPhase = 'BGM_ALERT'
		end
	else
		if this.soundtrackPhase ~= 'BGM_SNEAK' then
			this.soundtrackPhase = 'BGM_SNEAK'
		end
	end
end

this.OnPlayerSpawn = function(rulesetData, ruleset, localPlayerSessionId)
	WeatherManager.PauseClock(true)
end

this.OnPlayerSpawnChoiceExecute = function(rulesetData, ruleset, player, isBuddySpawn)
	
end


this.OnRegularTimeNearEnd = function(ruleset)
	Utils.OneMinuteLeft()

	this.UpdateSoundtrack()

	
	MgoUi.PreLoad( "MgoRoundEndUi" );
end

this.BriefingTeamAssignCallback = function(rulesetData, ruleset)
	SpawnHelpers.BuddyAssignment(ruleset)		
	Utils.AssignSpecialRoles( rulesetData, ruleset )
	SpawnHelpers.BriefingTeamAssignDone()
end


this.OnLocalPlayerTeamChanged = function(ruleset)
	GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
end




this.OnScriptFlagChanged = function( flagIndex, isOn ) 
    
    local flagString = nil
    for k,v in pairs(this.ScriptFlags) do
        if flagIndex == v  then flagString = k end
    end

    
    if( isOn ) then
		this.POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )
        if flagString == "Round1" then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			this.round = 1
			this.attacker = Utils.Team.SOLID
			this.defender = Utils.Team.LIQUID
			ruleset:GetTeamByIndex( this.attacker ).isAsymmetricAttacker = true
			ruleset:GetTeamByIndex( this.defender ).isAsymmetricAttacker = false
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
		elseif flagString == "Round2" then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			this.round = 2
			this.attacker = Utils.Team.LIQUID
			this.defender = Utils.Team.SOLID
			ruleset:GetTeamByIndex( this.attacker ).isAsymmetricAttacker = true
			ruleset:GetTeamByIndex( this.defender ).isAsymmetricAttacker = false
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			SpawnHelpers.SwapSpawnsForEachTeam(this.POI_SYSTEM_ID)
			GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
			TppBullet.ClearBulletMark()
		elseif flagString == "Countdown1" or flagString == "Countdown2"  then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
		elseif flagString == "AnnounceObjective" then
			

			TppUiCommand.RequestMbSoundControllerVoice("VOICE_CAPTURE_HOLD_LINKS")
		end
    else
        Fox.Log( "Host has Cleared flag:  flagIndex " .. flagIndex .. ", flagString " .. flagString )
    end
end





this.DBEUG_LookupObjectiveMessage = function( ruleset, messageId )
	return Utils.DBEUG_LookupObjectiveMessage ( ruleset, messageId )
end




return this






