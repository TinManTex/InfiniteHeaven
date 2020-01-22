






local this = {}



this.pushToParent = {}





this.Init = function( rulesetData, ruleset )

	
	ruleset:SetTeamWinnerStat( MgoStat.STAT_DISC_STEAL )
	ruleset:SetPlayerSortingStat( MgoStat.STAT_TEAM_POINTS )
	
	return true
end

this.FlagPickup = function(index)
	local ruleset = MpRulesetManager.GetActiveRuleset()

	ruleset:IncrementStatByPlayerIndex( index, MgoStat.STAT_DISC_PICKUP, 1 )
	ruleset:RulesetMessage( {player=index,  statId = "STAT_DISC_PICKUP", langTag = "mgo_ui_ruleticker_disc_pickup" } )
end

this.ExfilDone = function( attackerTeamIndex, player )
	local ruleset = MpRulesetManager.GetActiveRuleset()

	ruleset:IncrementStatByPlayerIndex( player.sessionIndex, MgoStat.STAT_DISC_STEAL, 1 )
	ruleset:RulesetMessage( {player=player.sessionIndex,  statId = "STAT_DISC_STEAL", langTag = "mgo_ui_ruleticker_disc_steal" } )
end

this.ExfilFailed = function( defenderTeamIndex )

end

this.pushToParent.OnPlayerTagged = function( ruleset, taggedPlayer, taggerPlayer )             
	if ruleset and ruleset:IsRunningOnHost() then
		ruleset:IncrementStatByPlayerIndex( taggerPlayer.sessionIndex, MgoStat.STAT_TAG, 1 )
		ruleset:IncrementStatByPlayerIndex( taggedPlayer.sessionIndex, MgoStat.STAT_TAGGED, 1 )
		ruleset:RulesetMessage( {player=taggerPlayer.sessionIndex,  statId = "STAT_TAG", langTag = "mgo_ui_ruleticker_mark" } )
	end
end

this.announcerHalf = function()
	TppUiCommand.AnnounceLogViewLangId( "mgo_announce_TS_half" )
end

this.announcerLast = function()
	TppUiCommand.AnnounceLogViewLangId( "mgo_announce_TS_alone" )
end

this.pushToParent.OnPlayerDeath = function( rulesetData, ruleset, player, killer, assister, lastDamage, isHeadshot, lastAttackId )
	if this.owner.attacker == player.teamIndex then
		
		local attackerDeaths = ruleset:GetStatByTeamIndex( this.owner.attacker, MgoStat.STAT_DEATH )
		local attackerTeamCount = ruleset:GetActivePlayerCountByTeamIndex( this.owner.attacker )
		if attackerDeaths == ( attackerTeamCount - 1 ) and this.owner.announceLast == false then
			
			this.owner.announceLast = true
			local allPlayers = ruleset:GetAllActivePlayers().array
			for playerIndex = 1, #allPlayers do
				local playerInfo = allPlayers[ playerIndex ]
				local playerSessionIndex = playerInfo.sessionIndex
				
				if playerSessionIndex ~= player.sessionIndex and not PlayerInfo.AndCheckStatus( playerSessionIndex, { PlayerStatus.DEAD } ) and playerInfo.teamIndex == this.owner.attacker then
					TppNetworkUtil.SyncedExecuteSessionIndex( playerSessionIndex, this._scriptPath, "announcerLast" )
				end
			end
		elseif attackerDeaths > 0 and attackerDeaths >= math.floor( attackerTeamCount / 2 ) and this.owner.announceLast == false and this.owner.announceHalf == false then
			
			this.owner.announceHalf = true
			local allPlayers = ruleset:GetAllActivePlayers().array
			for playerIndex = 1, #allPlayers do
				local playerInfo = allPlayers[ playerIndex ]
				local playerSessionIndex = playerInfo.sessionIndex
				
				if playerInfo.teamIndex == this.owner.attacker then
					TppNetworkUtil.SyncedExecuteSessionIndex( playerSessionIndex, this._scriptPath, "announcerHalf" )
				end
			end
		end
	else
		
		local defenderDeaths = ruleset:GetStatByTeamIndex( this.owner.defender, MgoStat.STAT_DEATH )
		local defenderTeamCount = ruleset:GetActivePlayerCountByTeamIndex( this.owner.defender )
		if defenderDeaths == ( defenderTeamCount - 1 ) and this.owner.announceLastDefend == false then
			
			this.owner.announceLastDefend = true
			local allPlayers = ruleset:GetAllActivePlayers().array
			for playerIndex = 1, #allPlayers do
				local playerInfo = allPlayers[ playerIndex ]
				local playerSessionIndex = playerInfo.sessionIndex
				
				if playerSessionIndex ~= player.sessionIndex and not PlayerInfo.AndCheckStatus( playerSessionIndex, { PlayerStatus.DEAD } ) and playerInfo.teamIndex == this.owner.defender then
					TppNetworkUtil.SyncedExecuteSessionIndex( playerSessionIndex, this._scriptPath, "announcerLast" )
				end
			end
		elseif defenderDeaths > 0 and defenderDeaths >= math.floor( defenderTeamCount / 2 ) and this.owner.announceLastDefend == false and this.owner.announceHalfDefend == false then
			
			this.owner.announceHalfDefend = true
			local allPlayers = ruleset:GetAllActivePlayers().array
			for playerIndex = 1, #allPlayers do
				local playerInfo = allPlayers[ playerIndex ]
				local playerSessionIndex = playerInfo.sessionIndex
				
				if playerInfo.teamIndex == this.owner.defender then
					TppNetworkUtil.SyncedExecuteSessionIndex( playerSessionIndex, this._scriptPath, "announcerHalf" )
				end
			end
		end
	end

	
	if not Entity.IsNull( killer ) then
		if killer ~= player then
			if ( lastAttackId ~= TppDamage.ATK_FultonDevice ) then
				if killer.teamIndex ~= player.teamIndex then
					if killer.teamIndex == this.owner.defender then
						TeamSneak_Exfil.checkFlagKill(player.sessionIndex, killer.sessionIndex)
					end
				end
			end
		end
	end
	
	
	GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "dropFlag", playerIndex = player.sessionIndex } )
end

this.pushToParent.OnPlayerStunned = function( ruleset, player, attacker, lastAttackId )
	
	GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "dropFlag", playerIndex = player.sessionIndex } )
end

this.pushToParent.OnPlayerDisconnect = function( rulesetData, ruleset, player )
	
	GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "dropFlag", playerIndex = player.sessionIndex } )
end

this.pushToParent.OnPlayerFultonSave = function( ruleset, fultonedPlayer, rescuerPlayer )
	if fultonedPlayer.teamIndex == rescuerPlayer.teamIndex then
		ruleset:IncrementStatByPlayerIndex( rescuerPlayer.sessionIndex, MgoStat.STAT_FULTONSAVE, 1 )
		ruleset:RulesetMessage( {player=rescuerPlayer.sessionIndex,  statId = "STAT_FULTONSAVE", langTag = "mgo_ui_ruleticker_fulton_save" } )
	end
end

this.pushToParent.OnPlayerInterrogated = function( ruleset, interrogatedPlayer, interrogatorPlayer )
	ruleset:IncrementStatByPlayerIndex( interrogatorPlayer.sessionIndex, MgoStat.STAT_INTERROGATION, 1 )
	ruleset:RulesetMessage( {player=interrogatorPlayer.sessionIndex,  statId = "STAT_INTERROGATION", langTag = "mgo_ui_ruleticker_interrogation" } )
	local combatMessage = 
			{ 
				playerLeft = interrogatorPlayer.sessionIndex,

				playerRight = interrogatedPlayer.sessionIndex,

				playerIcon = Utils.CombatMsg.Icon.CQC_INTERROGATION,
			}
	ruleset:CombatMessage( combatMessage )
end

this.pushToParent.OnPlayerCharmed = function( ruleset, charmedPlayer, attacker, isBinocularCharm )
	ruleset:IncrementStatByPlayerIndex( attacker.sessionIndex, MgoStat.STAT_CHARM, 1 )
	ruleset:RulesetMessage( {player=attacker.sessionIndex,  statId = "STAT_CHARM", langTag = "mgo_ui_ruleticker_purple_heart" } )
end




return this






