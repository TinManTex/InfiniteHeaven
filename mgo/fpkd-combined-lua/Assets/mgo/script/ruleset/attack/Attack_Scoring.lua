






local this = {}



this.pushToParent = {}





this.Init = function( rulesetData, ruleset )

	
	ruleset:SetTeamWinnerStat( MgoStat.STAT_DISC_STEAL )
	ruleset:SetPlayerSortingStat( MgoStat.STAT_TEAM_POINTS )
	
	this.interrogated = {}
	
	return true
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

this.pushToParent.OnPlayerDeath = function( rulesetData, ruleset, player, killer, assister, lastDamage, isHeadshot, lastAttackId )	

end

this.pushToParent.OnPlayerStunned = function( ruleset, player, attacker, lastAttackId )

end

this.pushToParent.OnPlayerFultonSave = function( ruleset, fultonedPlayer, rescuerPlayer )
	if fultonedPlayer.teamIndex == rescuerPlayer.teamIndex then
		ruleset:IncrementStatByPlayerIndex( rescuerPlayer.sessionIndex, MgoStat.STAT_FULTONSAVE, 1 )
		ruleset:RulesetMessage( {player=rescuerPlayer.sessionIndex,  statId = "STAT_FULTONSAVE", langTag = "mgo_ui_ruleticker_fulton_save" } )
	end
end

this.pushToParent.OnPlayerInterrogated = function( ruleset, interrogatedPlayer, interrogatorPlayer )
	local combatMessage = 
			{ 
				playerLeft = interrogatorPlayer.sessionIndex,

				playerRight = interrogatedPlayer.sessionIndex,

				playerIcon = Utils.CombatMsg.Icon.CQC_INTERROGATION,
			}
	ruleset:CombatMessage( combatMessage )
	
	
	if interrogatorPlayer.teamIndex == this.owner.attacker and this.owner.currentPhase == 1 and this.interrogated[interrogatedPlayer.sessionIndex] ~= true then
		this.interrogated[interrogatedPlayer.sessionIndex] = true
		
		this.owner.InterrogateIntel()
		
		ruleset:IncrementStatByPlayerIndex( interrogatorPlayer.sessionIndex, MgoStat.STAT_INTEL_INTERROGATE, 1 )
		ruleset:RulesetMessage( {player=interrogatorPlayer.sessionIndex,  statId = "STAT_INTEL_INTERROGATE", langTag = "mgo_ui_ruleticker_intel_inter" } )
	else
		ruleset:IncrementStatByPlayerIndex( interrogatorPlayer.sessionIndex, MgoStat.STAT_INTERROGATION, 1 )
		ruleset:RulesetMessage( {player=interrogatorPlayer.sessionIndex,  statId = "STAT_INTERROGATION", langTag = "mgo_ui_ruleticker_interrogation" } )
	end
end

this.pushToParent.OnPlayerCharmed = function( ruleset, charmedPlayer, attacker, isBinocularCharm )
	if this.owner.charmTracker[attacker.sessionIndex] == nil or this.owner.charmTracker[attacker.sessionIndex] <  ruleset:GetTimeSpentInCurrentState() - 20 then
		this.owner.charmTracker[attacker.sessionIndex] =  ruleset:GetTimeSpentInCurrentState()
		
		ruleset:IncrementStatByPlayerIndex( attacker.sessionIndex, MgoStat.STAT_CHARM, 1 )
		ruleset:RulesetMessage( {player=attacker.sessionIndex,  statId = "STAT_CHARM", langTag = "mgo_ui_ruleticker_purple_heart" } )
	end
end



return this






