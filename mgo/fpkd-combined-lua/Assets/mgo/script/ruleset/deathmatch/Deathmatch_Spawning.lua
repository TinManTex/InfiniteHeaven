








local this = {}




 


this.pushToParent = {}

this.Spawn = {
	teamCount = 2,
}

this.spawnGroupTag = "INITIAL"

this.Init = function( rulesetData, ruleset )
	return true
end
 






this.pushToParent.OnPlayerConnect = function( rulesetData, ruleset, player )

	Fox.Log( "Player [" .. tostring( player.sessionIndex ) .. "] is connected." )

	
	local roundState = ruleset.currentState
	
	Fox.Log( "Round state is " .. roundState .. "." )
	
	SpawnHelpers.TryTeamAssignment( ruleset, player )
	Fox.Log( "Player [" .. tostring( player.sessionIndex ) .. "] is now a part of team [" .. tostring( player.teamIndex ) .. "]." )
	
	
	if roundState == "RULESET_STATE_ROUND_REGULAR_PLAY" 
		or roundState == "RULESET_STATE_ROUND_OVERTIME"
		or roundState == "RULESET_STATE_ROUND_SUDDEN_DEATH"
		or roundState == "RULESET_STATE_ROUND_COUNTDOWN" then

		Fox.Log( "OnPlayerConnect called SpawnPlayer." )
		
		
		this.SpawnPlayer( ruleset, player, true )
	else
		Fox.Log( "OnPlayerConnect did not call SpawnPlayer." )
		if ruleset.currentState == "RULESET_STATE_BRIEFING" then
			Utils.TryReassignSpecialRole( player.teamIndex, ruleset, rulesetData, nil )
		end
	end	
	
	if SpawnHelpers.initialTeamAssignmentHasHappened == true then
		if this.owner.emptyTeam == SpawnHelpers.teamRoster[player.sessionIndex] then
			this.owner.emptyTeam = -1
		end
	end

	SpawnHelpers.DebugDumpTeamRoster()

	
	
	ruleset:SetPlayerTaggedStatus( player, false )	
	SpawnHelpers.FindBuddy(player, ruleset)		
end

this.pushToParent.OnPlayerDisconnect = function( rulesetData, ruleset, player )
	SpawnHelpers.teamRoster[player.sessionIndex] = nil
	
	if ruleset.currentState == "RULESET_STATE_ROUND_REGULAR_PLAY" 
		or ruleset.currentState == "RULESET_STATE_ROUND_OVERTIME"
		or ruleset.currentState == "RULESET_STATE_ROUND_SUDDEN_DEATH"
		or ruleset.currentState == "RULESET_STATE_ROUND_COUNTDOWN" then
		local team0empty = true
		local team1empty = true
		for index, team in pairs(SpawnHelpers.teamRoster) do
			if team == Utils.Team.SOLID then
				team0empty = false
			elseif team == Utils.Team.LIQUID then
				team1empty = false
			end
		end
		if team0empty == true then
			this.owner.emptyTeam = Utils.Team.SOLID
		elseif team1empty == true then
			this.owner.emptyTeam = Utils.Team.LIQUID
		end
		ruleset:IncrementStatByPlayerIndex( player.sessionIndex, MgoStat.STAT_DEATH, 0 )
		
	elseif ruleset.currentState == "RULESET_STATE_BRIEFING" then
		
		SpawnHelpers.FindNewBuddyForBuddy(player, ruleset)	
		
		Utils.TryReassignSpecialRole( player.teamIndex, ruleset, rulesetData, player )
	end

	SpawnHelpers.DebugDumpTeamRoster()
end






this.pushToParent.OnPlayerRespawn = function( rulesetData, ruleset, player )	

	this.spawnGroupTag = "RESPAWN"
	
	ruleset:DespawnPlayer( player )
	ruleset:ShowSpawnChoice( player )
end






this.SpawnPlayer = function( ruleset, player, initialSpawn )
	Fox.Log( "Spawn choice is being displayed for player [" .. tostring( player.sessionIndex )  .. "]." )
	ruleset:ShowSpawnChoice( player )
end










this.pushToParent.OnRoundStart = function( rulesetData, ruleset, player )	
	if player.sessionIndex == 0 then
		ruleset:ObjectiveNotification( Utils.Team.BOTH, Utils.ObjectiveMessage.MP_OBJ, Utils.ObjectiveMessage.MP_OBJ_DM, Utils.ObjectiveMessage.NONE, Utils.ObjectiveSounds.MP_SFX_TDM_INITIAL )
		local scriptFlags = ruleset:HostGetScriptFlags()
		scriptFlags = Utils.SetFlag( scriptFlags, this.owner.ScriptFlags['AnnounceObjective'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	end
end

this.SetInitialScore = function(rulesetData)
	local ruleset = MpRulesetManager.GetActiveRuleset()
	ruleset:IncrementStatByTeamIndex( Utils.Team.SOLID, MgoStat.STAT_DM_TICKET, vars.roundTickets)
	ruleset:IncrementStatByTeamIndex( Utils.Team.LIQUID, MgoStat.STAT_DM_TICKET, vars.roundTickets)
	ruleset:SetNeedsRoundEndEval()
end






this.pushToParent.OnRoundCountdownStart = function( rulesetData, ruleset, player, roundIndex )	
	
	Fox.Log( "OnRoundCountdownStart is executing for player with session index " .. tostring( player.sessionIndex ) )
	
	if player.sessionIndex == 0 then
		TppPickable.ClearAllDroppedInstance()
	
		Util.SetInterval(200, false, this._scriptPath, "countdownFlags", roundIndex)
	end

	
	
	
	ruleset:SetPlayerTaggedStatus( player, false )
	
	this.spawnGroupTag = "INITIAL"

	
	this.SpawnPlayer( ruleset, player, true )
end

this.countdownFlags = function(roundIndex)
	local ruleset = MpRulesetManager.GetActiveRuleset()
	local scriptFlags = ruleset:HostGetScriptFlags()
	if roundIndex == 1 then			
		scriptFlags = Utils.SetFlag( scriptFlags, this.owner.ScriptFlags['Countdown1'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	else
		scriptFlags = Utils.SetFlag( scriptFlags, this.owner.ScriptFlags['Countdown2'] )
		ruleset:HostSetScriptFlags( scriptFlags )
	end
end

this.pushToParent.OnRulesetRoundStart = function( rulesetData, ruleset )
	
	this.spawnGroupTag = "RESPAWN"
	
	if Mgo.IsHost() then
		Util.SetInterval(100, false, this._scriptPath, "SetInitialScore", rulesetData)
	end
end






this.pushToParent.SearchPlayersOnSameTeam = function( teamIndex )

	return GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "Search",
					criteria = {
						
						type = TppPoi.POI_TYPE_PLAYER,

						
						attributes = { key = "teamIndex", value = teamIndex },
					},
				}
			)
end






this.pushToParent.PopulateSpawnChoices = function( rulesetData, ruleset, player )
	













	local choices = SpawnHelpers.GetSpawnChoices( player, this, this.spawnGroupTag, nil, this.owner.POI_SYSTEM_ID )
	local spawnChoices = choices.resultTable
	return spawnChoices
end





this.pushToParent.ClientPopulateLoadoutChoices = function( rulesetData, ruleset, playerTeamIndex, playerClass )
	










	
	local loadoutChoices = {}
	loadoutChoices.loadouts = Deathmatch_Loadout.GetLoadouts( playerClass )
	return loadoutChoices
end





return this






