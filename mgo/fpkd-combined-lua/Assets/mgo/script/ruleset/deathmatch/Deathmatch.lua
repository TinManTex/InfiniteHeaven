









local this = {}

local winByTieBreakTopPlayerScore = false

this.requires = {
	"/Assets/mgo/script/utils/GimmickIDs.lua",
	"/Assets/mgo/script/utils/RulesetCallbacks.lua",
	"/Assets/mgo/script/utils/SpawnHelpers.lua",
	"/Assets/mgo/script/ruleset/deathmatch/Deathmatch_Spawning.lua",
	"/Assets/mgo/script/ruleset/deathmatch/Deathmatch_Scoring.lua",
	"/Assets/mgo/script/ruleset/deathmatch/Deathmatch_Loadout.lua",
	"/Assets/mgo/script/ruleset/deathmatch/Deathmatch_Config.lua",
}
this.POI_SYSTEM_ID = nil
this.winner = 0
this.round = 1
this.round1Winner = -1
this.overTime = false
this.teamPointsSolid = 0
this.teamPointsLiquid = 0
this.emptyTeam = -1


this.stunTracker = {}


this.tranqTracker = {}

this.roundTimeTracker = {}

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
this.doRoundEnd = false

this.rulesetState = nil
this.soundtrackPhase = nil

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
this.OnRoundCountdownStart = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundCountdownStart, unpack(arg)) end
this.OnRoundStart = function( ... )	RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnRoundStart, unpack(arg)) end
this.OnPlayerDeath = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDeath, unpack(arg)) end
this.OnPlayerStunned = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerStunned, unpack(arg)) end
this.OnPlayerInterrogated = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerInterrogated, unpack(arg)) end
this.OnPlayerCharmed = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerCharmed, unpack(arg)) end
this.OnPlayerTagged = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerTagged, unpack(arg)) end

this.OnPlayerConnect = function( ... )
	RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerConnect, unpack(arg)) 
	
	local rulesetData, ruleset, player = unpack(arg)
	local round1Time = 0;
	local round2Time = 0;
	local roundState = ruleset.currentState
	
	if roundState == "RULESET_STATE_ROUND_REGULAR_PLAY" or
		roundState == "RULESET_STATE_ROUND_OVERTIME" or 
		roundState == "RULESET_STATE_ROUND_SUDDEN_DEATH" then
		
		local timeSpent = ruleset:GetTimeSpentInCurrentRound()
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
	Fox.Log("Deathmatch OnPlayerConnect[" .. tostring(player.sessionIndex) .. "] - Round Time Tracker[round 1, round 2]: " .. tostring( round1Time ) .. " secs , " .. tostring( round2Time ) .. " secs" )
	
end

this.OnPlayerDisconnect = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerDisconnect, unpack(arg)) end
this.OnPlayerRespawn = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerRespawn, unpack(arg)) end
this.OnPlayerFultonSave = function( ... ) RulesetCallbacks.Multiplex(RulesetCallbacks.CallbackLists.OnPlayerFultonSave, unpack(arg)) end
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
				and RulesetCallbacks.SetupComponent("spawning", Deathmatch_Spawning, this)
				and RulesetCallbacks.SetupComponent("scoring", Deathmatch_Scoring, this)
				and RulesetCallbacks.SetupComponent("loadout", Deathmatch_Loadout, this)

	Fox.Log( "Deathmatch::OnRulesetReset " .. (ret and "successful" or "failed" ) )

	Deathmatch_Config.SetReviveConfig(ruleset)
	Deathmatch_Config.SetCloakingConfig(ruleset)
	Utils.SetStaminaConfig(ruleset)
	
	this.textureWaitTime = 0
	this.textureWaitFrameTimeLast = 0
	
	this.gameStartSeq = 0
	this.doRoundEnd = false

	this.rulesetState = nil
	this.soundtrackPhase = nil
	
	
	Utils.StopWeatherClock()
	
	this.POI_SYSTEM_ID = nil
	this.winner = 0
	this.round = 1
	this.overTime = false
	this.round1Winner = -1
	this.teamPointsSolid = 0
	this.teamPointsLiquid = 0
	this.emptyTeam = -1
	
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





this.Init = function( rulesetData, ruleset )
	
	math.randomseed(os.time())
	this.POI_SYSTEM_ID = GameObject.GetGameObjectIdByIndex( "TppPoiSystem", 0 )

	local ret = true
				and RulesetCallbacks.InitComponent("spawning", Deathmatch_Spawning, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("scoring", Deathmatch_Scoring, rulesetData, ruleset)
				and RulesetCallbacks.InitComponent("loadout", Deathmatch_Loadout, rulesetData, ruleset )

	Fox.Log( "Deathmatch::Init " .. (ret and "successful" or "failed" ) )

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
	
		if( this.IsGamePreLoad( rulesetData, ruleset ) == false ) then
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

this.DespawnPlayers = function(ruleset)
	ruleset:DespawnAllPlayers()
	ruleset:HideSpawnChoiceForAll()
	if this.round == 2 then
		this.callbackId = Util.SetInterval(0, true, this._scriptPath, "HostRestart")
	else
		this.round = 2
		this.round1Winner = this.winner
		this.overTime = false
		this.round2StateFlags()
	end
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

this.GetLoser = function(solidKills, liquidKills, ruleset)

	local loserTeamIndex = Utils.Team.SOLID
	if solidKills > liquidKills then
		this.winner = Utils.Team.SOLID
		loserTeamIndex = Utils.Team.LIQUID
	elseif liquidKills > solidKills then
		this.winner = Utils.Team.LIQUID
		loserTeamIndex = Utils.Team.SOLID
	else
		if ruleset:GetStatByTeamIndex( Utils.Team.SOLID, MgoStat.STAT_TEAM_POINTS ) > ruleset:GetStatByTeamIndex( Utils.Team.LIQUID, MgoStat.STAT_TEAM_POINTS ) then
			this.winner = Utils.Team.SOLID
			loserTeamIndex = Utils.Team.LIQUID
		elseif ruleset:GetStatByTeamIndex( Utils.Team.SOLID, MgoStat.STAT_TEAM_POINTS ) < ruleset:GetStatByTeamIndex( Utils.Team.LIQUID, MgoStat.STAT_TEAM_POINTS ) then
			this.winner = Utils.Team.LIQUID
			loserTeamIndex = Utils.Team.SOLID
		else
			loserTeamIndex = Utils.BreakTie(ruleset, true)	
			if loserTeamIndex == Utils.Team.SOLID then
				this.winner = Utils.Team.LIQUID
			else
				this.winner = Utils.Team.SOLID
			end
			this.winByTieBreakTopPlayerScore = true
		end
	end
	
	return loserTeamIndex
end





this.RoundEndEval = function( rulesetData, ruleset )	
	
	local solidKills = ruleset:GetStatByTeamIndex( Utils.Team.SOLID, MgoStat.STAT_DM_TICKET )
	local liquidKills = ruleset:GetStatByTeamIndex( Utils.Team.LIQUID, MgoStat.STAT_DM_TICKET )
	
	if solidKills < 0 then
		solidKills = 0
	end
	if liquidKills < 0 then
		liquidKills = 0
	end

	local killsToWin = 0
	local loserTeamIndex = this.GetLoser(solidKills, liquidKills, ruleset)
	
	local scoreDelta = solidKills - liquidKills
	
	local ticketsLeft = ruleset:GetStatByTeamIndex( loserTeamIndex, MgoStat.STAT_DM_TICKET )
	local targetKillScoreReached = ticketsLeft <= killsToWin
	
	if this.emptyTeam > -1 then
		
	elseif targetKillScoreReached or ruleset:IsRegularTimeOver() then
		if ruleset.currentState == "RULESET_STATE_ROUND_REGULAR_PLAY" then		
			if targetKillScoreReached and scoreDelta ~= 0 then
				this.doRoundEnd = true
			elseif  targetKillScoreReached and scoreDelta == 0 then
				
				
				
				ruleset:IncrementStatByPlayerIndex( Utils.Team.SOLID, MgoStat.STAT_DM_TICKET, 1 )
				ruleset:IncrementStatByPlayerIndex( Utils.Team.LIQUID, MgoStat.STAT_DM_TICKET, 1 )
				return false, this.winner 
			else
				if ruleset:IsRegularTimeOver() then
					if scoreDelta ~= 0 then
						this.doRoundEnd = true
					else 
						ruleset:ActivateOvertime()
						this.overTime = true
						ruleset:ObjectiveNotification( Utils.Team.BOTH, Utils.ObjectiveMessage.MP_OBJ, Utils.ObjectiveMessage.MP_OBJ_OVERTIME, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TDM_OVERTIME )
						return false, this.winner 
					end
				else
					return false, this.winner 
				end
			end
		elseif ruleset.currentState == "RULESET_STATE_ROUND_OVERTIME" then
			this.overTime = true
			if scoreDelta ~= 0 then
				this.doRoundEnd = true
			elseif  targetKillScoreReached and scoreDelta == 0 then
				
				
				ruleset:IncrementStatByPlayerIndex( Utils.Team.SOLID, MgoStat.STAT_DM_TICKET, 1 )
				ruleset:IncrementStatByPlayerIndex( Utils.Team.LIQUID, MgoStat.STAT_DM_TICKET, 1 )
				return false, this.winner 
			else
				if ruleset:IsOvertimeTimeOver() then
					this.doRoundEnd = true
				else
					return false, this.winner 
				end
			end
		elseif ruleset.currentState == "RULESET_STATE_ROUND_SUDDEN_DEATH" and scoreDelta > 0 then
			this.overTime = true
			this.doRoundEnd = true
		end
	end
	
	if this.emptyTeam == Utils.Team.SOLID then
		this.winner = Utils.Team.LIQUID
		this.loserTeamIndex = Utils.Team.SOLID
		this.doRoundEnd = true
		if this.round == 1 then
			this.round1Winner = this.winner
			TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", 1, this.winner, 0, false, 0, 0, false)
		end
		this.round = 2
	elseif this.emptyTeam == Utils.Team.LIQUID then
		this.winner = Utils.Team.SOLID
		this.loserTeamIndex = Utils.Team.LIQUID
		this.doRoundEnd = true
		if this.round == 1 then
			this.round1Winner = this.winner
			TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", 1, this.winner, 0, false, 0, 0, false)
		end
		this.round = 2
	end
	
		
	if this.doRoundEnd then
		this.doRoundEnd = false
		this.teamPointsSolid = this.teamPointsSolid + ruleset:GetStatByTeamIndex( 0, MgoStat.STAT_TEAM_POINTS )
		this.teamPointsLiquid = this.teamPointsLiquid + ruleset:GetStatByTeamIndex( 1, MgoStat.STAT_TEAM_POINTS )
		local timeSpent = ruleset:GetTimeSpentInCurrentState()
		if timeSpent < 0 then
			timeSpent = 0
		end
		timeSpent = math.floor(timeSpent)
		TppNetworkUtil.SyncedExecute( this._scriptPath, "SetWinner", this.round, this.winner, timeSpent, this.overTime, solidKills, liquidKills, true)
		
		
		
		if this.overTime then
			if ruleset:IsOvertimeTimeOver() then
				
				if this.winByTieBreakTopPlayerScore == true then
					this.winByTieBreakTopPlayerScore = false
					ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_WIN_TIE, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
					ruleset:ObjectiveNotification( loserTeamIndex, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_LOSS_TIME, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
				else
					
					ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_WIN_TIME, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
					ruleset:ObjectiveNotification( loserTeamIndex, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_LOSS_TIME, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
				end
			else
				
				ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_OT_WIN, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
				ruleset:ObjectiveNotification( loserTeamIndex, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_OT_LOSS, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
			end
		elseif targetKillScoreReached then
			
			ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_WIN_TIX, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
			ruleset:ObjectiveNotification( loserTeamIndex, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_LOSS_TIX, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )
		elseif this.emptyTeam > -1 then 
			ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_NOTIFY_WON_ENEMY_ABANDONED, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
		else
			
			ruleset:ObjectiveNotification( this.winner, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_WIN_TIME_TIX, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_GOOD_END, true )
			ruleset:ObjectiveNotification( loserTeamIndex, Utils.ObjectiveMessage.MP_INFO, Utils.ObjectiveMessage.MP_OBJ_DM_LOSS_TIME_TIX, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TSNE_BAD_END, true )			
		end	
		
		
		local matchWinner
		if this.round == 2 then
			matchWinner = Utils.DetermineMatchWinner(ruleset, this.winner, this.round1Winner, this.teamPointsSolid, this.teamPointsLiquid)
		end
		
		local totalRoundTime = ruleset:GetTimeSpentInCurrentRound()		
		if totalRoundTime < 0 then
			totalRoundTime = 0
		end
		totalRoundTime = math.floor(totalRoundTime)
		
		Fox.Log("Deathmatch round end - Total Round Time (host) : " .. tostring(totalRoundTime) .. " secs" )
		
		
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
	
			if this.round == 1 then
				this.roundTimeTracker[player.sessionIndex][1] = totalRoundTime - this.roundTimeTracker[player.sessionIndex][1]
				ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_TOTAL_PLAYTIME, this.roundTimeTracker[player.sessionIndex][1] )
				Fox.Log("Deathmatch round end - Round Time Tracker[round 1][player " .. tostring(playerIndex) .. "]: " .. tostring( this.roundTimeTracker[player.sessionIndex][1] ) .. " secs" )
			else
				this.roundTimeTracker[player.sessionIndex][2] = totalRoundTime - this.roundTimeTracker[player.sessionIndex][2]
				ruleset:IncrementStatByPlayerIndex( localPlayerIndex, MgoStat.STAT_TOTAL_PLAYTIME, this.roundTimeTracker[player.sessionIndex][2] )
				Fox.Log("Deathmatch round end - Round Time Tracker[round 2][player " .. tostring(playerIndex) .. "]: " .. tostring( this.roundTimeTracker[player.sessionIndex][2] ) .. " secs" )
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
	local assistCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_ASSIST )
	local tagCount = ruleset:GetTotalStatByPlayerIndex( playerIndex, MgoStat.STAT_TAG )

	if killCount == 0 and deathCount == 0 and stunCount == 0 and stunnedCount == 0 and fultonCount == 0
		and fultonedCount == 0 and assistCount == 0 and tagCount == 0 then
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
					xpBonus = (totalPlayTime / 60) * Utils.TDM_WinBonusPerMin
				end
			else
				if this.roundTimeTracker[playerIndex] ~= nil then
					local totalPlayTime = (this.roundTimeTracker[playerIndex][1] + this.roundTimeTracker[playerIndex][2])
					xpBonus = (totalPlayTime / 60) * Utils.TDM_LossBonusPerMin
				end
			end
			ruleset:IncrementStatByPlayerIndex( playerIndex, MgoStat.STAT_CALC_XP, xpBonus )
		end
	end
end

this.SetWinner = function(round, winner, time, overtime, ticket1, ticket2, announce)
	this.winner = winner
	if announce then
		if winner == Utils.Team.SOLID then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_solid_win" )
		else
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_generic_liquid_win" )
		end	
	end
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local RoundEndTableData = 
	{
		roundTime = time,
		roundOvertime = overtime,
		roundWinnerId = winner,
		ticketCountTeam1 = ticket1,
		ticketCountTeam2 = ticket2,
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


this.OnBuddyStateChanged = function( rulesetData, ruleset, created, buddy1, buddy2 )
	Utils.TryNotifyBuddyChange(ruleset, created, buddy1, buddy2)
end



this.InitFrame = function( rulesetData, ruleset )
	Utils.SetupEffects(vars.locationCode, 1==vars.isNight)
	Utils.InitTutorial()
end

this.DoFrame = function( rulesetData, ruleset )
	Utils.DrawTutorial( ruleset, this.round )
	this.FrameDeathmatchSoundtrack()
end

this.FrameDeathmatchSoundtrack = function()
	if this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_REGULAR_PLAY then
		local ruleset = MpRulesetManager.GetActiveRuleset()
		local prevSoundtrackPhase = this.soundtrackPhase
		local solidKills = ruleset:GetStatByTeamIndex( Utils.Team.SOLID, MgoStat.STAT_DM_TICKET )
		local liquidKills = ruleset:GetStatByTeamIndex( Utils.Team.LIQUID, MgoStat.STAT_DM_TICKET )

		if solidKills > 0 and liquidKills > 0 then
			local alertTicket = 5

			if solidKills <= alertTicket or liquidKills <= alertTicket then
				this.soundtrackPhase = 'BGM_ALERT'
			elseif ruleset:IsRegularTimeNearEnd() then
				this.soundtrackPhase = 'BGM_EVASION'
			else
				this.soundtrackPhase = 'BGM_SNEAK'
			end

			if prevSoundtrackPhase ~= this.soundtrackPhase then
				this.PlayDeathmatchSoundtrack()
			end
		end
	end
end

this.StateDeathmatchSoundtrack = function()
	
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local prevSoundtrackPhase = this.soundtrackPhase
	
	if this.rulesetState == TppMpBaseRuleset.RULESET_STATE_INACTIVE then
		this.soundtrackPhase = 'BGM_STOP_ALL'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_GAME_START then
		this.soundtrackPhase = 'BGM_STOP_ALL'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_COUNTDOWN then
		this.soundtrackPhase = 'BGM_INTRO'
	elseif this.rulesetState == TppMpBaseRuleset.RULESET_STATE_ROUND_REGULAR_PLAY then
		if ruleset:IsRegularTimeNearEnd() then
			this.soundtrackPhase = 'BGM_EVASION'
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
		this.PlayDeathmatchSoundtrack()
	end
end

this.PlayDeathmatchSoundtrack = function()
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
 
this.OnRulesetStateChange = function( ruleset, newState )
	
	this.rulesetState = newState
	this.StateDeathmatchSoundtrack()

	if newState == TppMpBaseRuleset.RULESET_STATE_END_OF_MATCH_FLOW then
		if Mgo.IsHost() then
			this.DespawnPlayers(ruleset)
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

	this.StateDeathmatchSoundtrack()

	
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




this.DBEUG_LookupObjectiveMessage = function( ruleset, messageId )
	return Utils.DBEUG_LookupObjectiveMessage ( ruleset, messageId )
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
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
		elseif flagString == "Round2" then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			this.round = 2
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
			SpawnHelpers.SwapSpawnsForEachTeam(this.POI_SYSTEM_ID)
			GimmickIDs.AddObjectiveBlip(this.POI_SYSTEM_ID)
			TppBullet.ClearBulletMark()
		elseif flagString == "Countdown1" or flagString == "Countdown2"  then
			local ruleset = MpRulesetManager.GetActiveRuleset()
			GimmickIDs.SwapFlags( ruleset:GetMapId(), this.round )
		elseif flagString == "AnnounceObjective" then
			
			TppUiCommand.RequestMbSoundControllerVoice("VOICE_ELIMINATE_OPPOSITION")
		end
    else
        Fox.Log( "Host has Cleared flag:  flagIndex " .. flagIndex .. ", flagString " .. flagString )
    end
end




return this






