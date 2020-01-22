








local this = {}







this.pushToParent = {}

this.Spawn = {
	teamCount = 2,
}

this.hasInited = false

this.spawnGroupTag = "INITIAL"

this.Init = function( rulesetData, ruleset )
	return true
end







this.pushToParent.OnPlayerConnect = function( rulesetData, ruleset, player )

	SpawnHelpers.TeamRoleAssignment( ruleset, player )
	
	
	local roundState = ruleset.currentState

	
	if roundState == "RULESET_STATE_ROUND_REGULAR_PLAY" 
		or roundState == "RULESET_STATE_ROUND_OVERTIME"
		or roundState == "RULESET_STATE_ROUND_SUDDEN_DEATH" then

		
		this.SpawnPlayer( ruleset, player, true )
	end	

	
	
	ruleset:SetPlayerTaggedStatus( player, false )			
	Fox.Log( "Untag player on connect ")
end





this.pushToParent.OnPlayerRespawn = function( rulesetData, ruleset, player )	

	this.spawnGroupTag = "RESPAWN"
	
	this.SpawnPlayer( ruleset, player, false )

end






this.SpawnPlayer = function( ruleset, player, initialSpawn )

	
	local spawnChoices = SpawnHelpers.GetSpawnChoices( player, this, this.spawnGroupTag, nil, this.owner.POI_SYSTEM_ID )	

	local spawnChoiceCount = #spawnChoices.resultTable.choices

	if spawnChoiceCount ~= 1 then
		Fox.Error( "Expected a single spawn choice at start but found " .. spawnChoiceCount )
		return
	end

	local spawnChoice = spawnChoices.resultTable.choices[ 1 ]

	local poiCount = #spawnChoice.PoiHandles;

	if poiCount < 1 then
		Fox.Error( "Expected at least one spawn location at start but found none" )
		return
	end
	
	local poiIndex = math.random( poiCount )
	ruleset:SpawnUsingPoiHandle( player, spawnChoice.PoiHandles[ poiIndex ] )
end










this.pushToParent.OnRoundStart = function( rulesetData, ruleset, player )	
	
	Fox.Log( "OnRoundStart is executing for player with session index " .. tostring( player.sessionIndex ) )
	
	

	
	
	
	ruleset:SetPlayerTaggedStatus( player, false )
	


	
	Fox.Log("hasDisplayedTitleScreen CNT is "..vars.hasDisplayedTitleScreen.." !!")
	if vars.hasDisplayedTitleScreen == 0 then
		Fox.Log("Player Title Position !!")
		this.spawnGroupTag = "INITIAL"
	else
		Fox.Log("Player Non Title Position !!")
		this.spawnGroupTag = "RESPAWN"
	end
	
	this.SpawnPlayer( ruleset, player, true )
	
	
end

this.pressStart = function(ruleset, player)
	if Pad.GetButtonStatus( 0, fox.PAD_START ) then
		ruleset:ShowSpawnChoice( player )
	end
	return true
end

this.pushToParent.OnRulesetRoundStart = function( rulesetData, ruleset )

	local instances = {
		"TEAM_01",
		"TEAM_02",
	}
	
	this.spawnGroupTag = "INITIAL"

	if this.hasInited == false then
		
		
		
		this.hasInited = true
	else
		SpawnHelpers.SwapSpawnsForEachTeam(this.owner.POI_SYSTEM_ID)	
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
	loadoutChoices.loadouts = Freeplay_Loadout.GetLoadouts( playerClass )
	return loadoutChoices
end





return this






