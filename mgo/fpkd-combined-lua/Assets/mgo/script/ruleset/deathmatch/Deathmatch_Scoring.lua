






local this = {}



this.pushToParent = {}





BOUNTY_SELF_TAG_THRESHOLD = 7


this.Init = function( rulesetData, ruleset )

	
	ruleset:SetTeamWinnerStat( MgoStat.STAT_DM_TICKET )
	ruleset:SetPlayerSortingStat( MgoStat.STAT_TEAM_POINTS )
	
	return true
end




this.pushToParent.SetOccluderEffectiveRange = function( range )
	Fox.Log( "SetOccluderEffectiveRange is called across the network." )	
	GrTools.SetOccluderEffectiveRange( tonumber(range) )
end




this.pushToParent.OnPlayerTagged = function( ruleset, taggedPlayer, taggerPlayer )             
	if ruleset and ruleset:IsRunningOnHost() then
		ruleset:IncrementStatByPlayerIndex( taggerPlayer.sessionIndex, MgoStat.STAT_TAG, 1 )
		ruleset:IncrementStatByPlayerIndex( taggedPlayer.sessionIndex, MgoStat.STAT_TAGGED, 1 )
		ruleset:RulesetMessage( {player=taggerPlayer.sessionIndex,  statId = "STAT_TAG", langTag = "mgo_ui_ruleticker_mark" } )
	end
end

this.announceBounty = function()
	TppUiCommand.AnnounceLogViewLangId( "mgo_announce_TDM_bounty" )
end





this.pushToParent.OnPlayerDeath = function( rulesetData, ruleset, player, killer, assister, lastDamage, isHeadshot, lastAttackId )
	if ruleset:GetStatByTeamIndex( player.teamIndex, MgoStat.STAT_DM_TICKET ) > 0 then
		ruleset:DecrementStatByTeamIndex( player.teamIndex, MgoStat.STAT_DM_TICKET, 1 )
	end

	if not Entity.IsNull( killer ) then
		if killer ~= player then
			if ( TppDamage.ATK_FultonDevice == lastAttackId ) then
				
				local killerBounty = ruleset:GetStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_BOUNTY )
				local victimBounty = ruleset:GetStatByPlayerIndex( player.sessionIndex, MgoStat.STAT_BOUNTY )
				local victimBountyAdjusted
				local killerReduction
				local victimReduction = victimBounty
				local bountyDelta

				if 0 >= victimBounty then
					victimBountyAdjusted = 1
				else
					victimBountyAdjusted = victimBounty
				end
				bountyDelta = killerBounty - victimBountyAdjusted
				if 0 <= bountyDelta then
					killerReduction = victimBountyAdjusted
				else
					killerReduction = killerBounty
				end
				
				






				ruleset:DecrementStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_BOUNTY, killerReduction )
				ruleset:IncrementStatByTeamIndex( killer.teamIndex, MgoStat.STAT_DM_TICKET, victimBountyAdjusted )
				ruleset:IncrementStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_BOUNTY_CAPTURE, victimBountyAdjusted )
				ruleset:RulesetMessage( {player=killer.sessionIndex, statId = "STAT_BOUNTY_CAPTURE", langTag = "mgo_ui_ruleticker_bounty_capture", count = victimBountyAdjusted } )
				ruleset:DecrementStatByPlayerIndex( player.sessionIndex, MgoStat.STAT_BOUNTY, victimReduction )
			else
				
				local bountyIncrease = 1
				
				
				if killer.teamIndex == player.teamIndex then
					bountyIncrease = 3
				end
				
				ruleset:IncrementStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_BOUNTY, bountyIncrease )
				if ruleset:GetStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_BOUNTY ) == 1 then
					TppNetworkUtil.SyncedExecuteSessionIndex( killer.sessionIndex, this._scriptPath, "announceBounty" )
				end
				
				local killerBounty = ruleset:GetStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_BOUNTY )
				if BOUNTY_SELF_TAG_THRESHOLD <= killerBounty then
					ruleset:SetPlayerTaggedStatus( killer, true )
				end
			end
		end
	end
end















this.pushToParent.OnPlayerFultonSave = function( ruleset, fultonedPlayer, rescuerPlayer )
	if fultonedPlayer.teamIndex == rescuerPlayer.teamIndex then
		ruleset:IncrementStatByPlayerIndex( rescuerPlayer.sessionIndex, MgoStat.STAT_FULTONSAVE, 1 )
		ruleset:RulesetMessage( {player=rescuerPlayer.sessionIndex,  statId = "STAT_FULTONSAVE", langTag = "mgo_ui_ruleticker_fulton_save" } )
	end
end

this.pushToParent.OnPlayerStunned = function(ruleset, player, attacker, lastAttackId)

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





this.UnlockMessaging = function( sessionId )
	local ruleSet = MpRulesetManager.GetActiveRuleset()
	local localPlayerId = ruleSet:GetLocalPlayerGameObjectId()
	
	if localPlayerId == sessionId then
		Utils.DisplayLog( "LOADOUT UNLOCKED!", false, 90, 400, 200, 24 )
	end
end




return this






