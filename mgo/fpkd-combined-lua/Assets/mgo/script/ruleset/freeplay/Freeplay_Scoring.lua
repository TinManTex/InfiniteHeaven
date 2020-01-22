






local this = {}



this.pushToParent = {}









this.scoreTable = 
{
	KILLS			= 0,
}

this.Init = function( rulesetData, ruleset )

	
	
	
	
	
	ruleset:SetTeamWinnerStat( MgoStat.STAT_KILL )
	ruleset:SetPlayerSortingStat( MgoStat.STAT_TEAM_POINTS )
	
	return true
end




this.pushToParent.SetOccluderEffectiveRange = function( range )
	Fox.Log( "SetOccluderEffectiveRange is called across the network." )	
	GrTools.SetOccluderEffectiveRange( tonumber(range) )
end




this.pushToParent.OnPlayerTagged = function( ruleset, taggedPlayer, taggerPlayer )             

end

this.CommCapture = function( player )  

end





this.pushToParent.OnPlayerDeath = function( rulesetData, ruleset, player, killer, assister, lastDamage, isHeadshot )	

end





this.UnlockMessaging = function( sessionId )

end




return this






