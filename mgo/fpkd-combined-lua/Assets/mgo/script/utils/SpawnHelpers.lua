local this = {}
this.initialTeamAssignmentHasHappened = false
this.teamRoster = {}




this.Reset = function()
	this.initialTeamAssignmentHasHappened = false
end

this.HasTeamAssignmentHappened = function()
	return this.initialTeamAssignmentHasHappened
end

this.SetTeamGroupState = function( type, instance, teamIdx, teamCount, POI_SYSTEM_ID )

	local setGroupStateSearchTags = {
		"PARENT",
		type,
		instance,
	}

	Fox.Log( "SetTeamGroupState -> teamIdx=" .. tostring(teamIdx) .. " search tags: " .. Utils.StringArrayToCSV( setGroupStateSearchTags ) )

	
	local poiResults = GameObject.SendCommand( POI_SYSTEM_ID,
			{
				id = "Search",
				criteria = {
					
					type = TppPoi.POI_TYPE_SPAWN_POINT,

					
					tags = setGroupStateSearchTags,
				},
			}
		)	

	for i = 1, #poiResults.results do
		local result = poiResults.results[i]
		local poiHandle = result.handle

		
		for currentTeamIndex = 0, teamCount - 1 do
			local teamTag = Utils.GetTeamTag( currentTeamIndex )

			GameObject.SendCommand( POI_SYSTEM_ID,
					{
						id = "RemoveTag",
						params = {
							tag = teamTag,
							poiHandles = { poiHandle },
						}
					}
				)
		end

		local teamTag = Utils.GetTeamTag( teamIdx )

		if teamIdx ~= nil then
			
			GameObject.SendCommand( POI_SYSTEM_ID,
					{
						id = "AddTag",
						params = {
							tag = teamTag,
							poiHandles = { poiHandle },
						}
					}
				)
		end
	end	

	local groupsString = " for group " .. tostring(type) .. ", " .. tostring(instance)

	if teamIdx == nil then
		Fox.Log( "Team flag is cleared" .. groupsString )
	else
		Fox.Log( "Team flag is set to " .. tostring( teamIdx + 1 ) .. groupsString )
	end
end





this.ChooseRandomSpawnsForEachTeam = function(instances, teamCount, POI_SYSTEM_ID)
	local teamsAssigned = {}

	for teamIter = 1, teamCount do
		local currentInstance = instances[teamIter]

		local initialParentSpawnTags = {
			"PARENT",
			"INITIAL",
			currentInstance,
		}

		
		local initialParentSpawns = GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "Search",
					criteria = {
						
						type = TppPoi.POI_TYPE_SPAWN_POINT,

						
						tags = initialParentSpawnTags,
					},
				}
			)

		local initialParentSpawnCount = initialParentSpawns.resultCount

		if initialParentSpawnCount ~= 1 then
			Fox.Error( "Expected one intial spawn location with the tags " .. Utils.StringArrayToCSV( initialParentSpawnTags ) .. " but found " .. initialParentSpawnCount )
			return
		end

		local initialParentSpawn = initialParentSpawns.results[1]

		
		local teamIndex
		repeat
			teamIndex = math.random( teamCount )
		until Utils.FindInArray( teamsAssigned, teamIndex ) == 0	
		
		table.insert( teamsAssigned, teamIndex )

		
		teamIndex = teamIndex - 1

		
		this.SetTeamGroupState( "INITIAL", currentInstance, teamIndex, teamCount, POI_SYSTEM_ID )

		
		this.SetTeamGroupState( "RESPAWN", currentInstance, teamIndex, teamCount, POI_SYSTEM_ID )
	end
end




this.SwapSpawnsForEachTeam = function(POI_SYSTEM_ID)
	this.SwapPoiTeam(POI_SYSTEM_ID, TppPoi.POI_TYPE_SPAWN_POINT)
	this.SwapPoiTeam(POI_SYSTEM_ID, TppPoi.POI_TYPE_GENERIC)
	this.SwapPoiTeam(POI_SYSTEM_ID, TppPoi.POI_TYPE_VEHICLE)
end

this.SwapPoiTeam = function(POI_SYSTEM_ID, poiType)

	local setGroupStateSearchTags = {
		"TEAM_01",
	}

	
	local poiResults = GameObject.SendCommand( POI_SYSTEM_ID,
			{
				id = "Search",
				criteria = {
					
					type = poiType,

					
					tags = setGroupStateSearchTags,
				},
			}
		)	
		
	setGroupStateSearchTags = {
		"TEAM_02",
	}

	
	local poiResults2 = GameObject.SendCommand( POI_SYSTEM_ID,
			{
				id = "Search",
				criteria = {
					
					type = poiType,

					
					tags = setGroupStateSearchTags,
				},
			}
		)

	for i = 1, #poiResults.results do
		local result = poiResults.results[i]
		local poiHandle = result.handle

		GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "RemoveTag",
					params = {
						tag = "TEAM_01",
						poiHandles = { poiHandle },
					}
				}
			)
		
		GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "AddTag",
					params = {
						tag = "TEAM_02",
						poiHandles = { poiHandle },
					}
				}
			)
	end		

	for i = 1, #poiResults2.results do
		local result = poiResults2.results[i]
		local poiHandle = result.handle

		GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "RemoveTag",
					params = {
						tag = "TEAM_02",
						poiHandles = { poiHandle },
					}
				}
			)
		
		GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "AddTag",
					params = {
						tag = "TEAM_01",
						poiHandles = { poiHandle },
					}
				}
			)
	end	
	
end





this.GetSpawnChoices = function( player, ruleset_object, spawnTypeTag, instanceTag, POI_SYSTEM_ID )















		
	local ruleset = MpRulesetManager.GetActiveRuleset()

	local resultTable = {
		defaultChoiceIndex = 0,
		choices = {}
	}

	local choicesArray = resultTable.choices
	local currentChoiceIndex = 1
	local parentTagsArray = {}

	local finalResult = {
		resultTable = resultTable,
		parentTags = parentTagsArray
	}
	
	
	local teamIndex = player.teamIndex

	
	local teamTag = Utils.GetTeamTag( teamIndex )
	
	if Domination_Spawning == ruleset_object and spawnTypeTag == "RESPAWN" then
		for i = 0, Domination.numDomPoints do
			if Domination_Exfil.currentOwnerTeam[i] == teamIndex then
				local parentSearchTags = {
					"PARENT",
					spawnTypeTag,
					instanceTag,
					teamTag, 
					"GENERIC_0"..tostring(i),
				}

				
				local parentSearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
						{
							id = "Search",
							criteria = {
								
								type = TppPoi.POI_TYPE_SPAWN_POINT,

								
								tags = parentSearchTags,
							},
						}
					)

				
				for j = 1, #parentSearchResults.results do
					local parentSearchResult = parentSearchResults.results[j]

					local childSearchTags = parentSearchResult.tags
					
					
					Utils.RemoveStringFromStringArray( childSearchTags, "PARENT" )
					
					
					
					Utils.InsertArrayUniqueInArray(childSearchTags, parentTagsArray)

					
					childSearchTags[ #childSearchTags + 1 ] = "CHILD"

					local childSearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
							{
								id = "Search",
								criteria = {
									
									type = TppPoi.POI_TYPE_SPAWN_POINT,

									
									tags = childSearchTags,
								},
							}
						)

					local childSearchResultCount = childSearchResults.resultCount

					if childSearchResultCount < 1 then					
						Fox.Error( "Expected at least 1 children for a spawn choice but found 0. Search tags: " .. Utils.StringArrayToCSV( childSearchTags ) )
					else
						
						local poiHandles = {}

						for k = 1, #childSearchResults.results do
							local result = childSearchResults.results[k]
							poiHandles[ k ] = result.handle
						end

						

						local spawnPointMessageId = {
							"mgo_spawn_point_comm_a",
							"mgo_spawn_point_comm_b",
							"mgo_spawn_point_comm_c",
						}

						local choiceObject = {
							PoiHandles = poiHandles,
							MapPos = { x = parentSearchResult.posX, y = parentSearchResult.posY, z = parentSearchResult.posZ },
							MapIconId = "ApcFriendly",
							DisplayName = spawnPointMessageId[ i ],
						}

						choicesArray[ currentChoiceIndex ] = choiceObject
						currentChoiceIndex = currentChoiceIndex + 1
					end
				end
			end
		end
		local parentSearchTags = {
			"PARENT",
			spawnTypeTag,
			instanceTag,
			teamTag,
			"BASE",
		}

		
		local parentSearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "Search",
					criteria = {
						
						type = TppPoi.POI_TYPE_SPAWN_POINT,

						
						tags = parentSearchTags,
					},
				}
			)

		
		for i = 1, #parentSearchResults.results do
			local parentSearchResult = parentSearchResults.results[i]

			local childSearchTags = parentSearchResult.tags
			
			
			Utils.RemoveStringFromStringArray( childSearchTags, "PARENT" )
			
			
			
			Utils.InsertArrayUniqueInArray(childSearchTags, parentTagsArray)

			
			childSearchTags[ #childSearchTags + 1 ] = "CHILD"

			local childSearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
					{
						id = "Search",
						criteria = {
							
							type = TppPoi.POI_TYPE_SPAWN_POINT,

							
							tags = childSearchTags,
						},
					}
				)

			local childSearchResultCount = childSearchResults.resultCount

			if childSearchResultCount < 1 then					
				Fox.Error( "Expected at least 1 children for a spawn choice but found 0. Search tags: " .. Utils.StringArrayToCSV( childSearchTags ) )
			else

				
				local poiHandles = {}

				for i = 1, #childSearchResults.results do
					local result = childSearchResults.results[i]
					poiHandles[ i ] = result.handle
				end

				

				local choiceObject = {
					PoiHandles = poiHandles,
					MapPos = { x = parentSearchResult.posX, y = parentSearchResult.posY, z = parentSearchResult.posZ },
					MapIconId = "StartFriendly",	
					DisplayName = "mgo_UI_respawn_hq",
				}

				choicesArray[ currentChoiceIndex ] = choiceObject
				currentChoiceIndex = currentChoiceIndex + 1
			end
		end
	else

		local parentSearchTags = {
			"PARENT",
			spawnTypeTag,
			instanceTag,
			teamTag, 
		}

		
		local parentSearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
				{
					id = "Search",
					criteria = {
						
						type = TppPoi.POI_TYPE_SPAWN_POINT,

						
						tags = parentSearchTags,
					},
				}
			)

		local hqObject = {}
		local hq = false
		local hqFound = false
		
		for i = 1, #parentSearchResults.results do
			local parentSearchResult = parentSearchResults.results[i]

			local childSearchTags = parentSearchResult.tags
			
			for j = 1, #parentSearchResult.tags do
				if parentSearchResult.tags[j] == "BASE" then
					hq = true
				end
			end
			
			
			Utils.RemoveStringFromStringArray( childSearchTags, "PARENT" )
			
			
			
			Utils.InsertArrayUniqueInArray(childSearchTags, parentTagsArray)

			
			childSearchTags[ #childSearchTags + 1 ] = "CHILD"

			local childSearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
					{
						id = "Search",
						criteria = {
							
							type = TppPoi.POI_TYPE_SPAWN_POINT,

							
							tags = childSearchTags,
						},
					}
				)

			local childSearchResultCount = childSearchResults.resultCount

			if childSearchResultCount < 1 then					
				Fox.Error( "Expected at least 1 children for a spawn choice but found 0. Search tags: " .. Utils.StringArrayToCSV( childSearchTags ) )
			else

				
				local poiHandles = {}
				for i = 1, #childSearchResults.results do
					local result = childSearchResults.results[i]
					poiHandles[ i ] = result.handle
				end

				local choiceObject = {}
				
				if hq then
					hqObject = {
						PoiHandles = poiHandles,
						MapPos = { x = parentSearchResult.posX, y = parentSearchResult.posY, z = parentSearchResult.posZ },
						MapIconId = "StartFriendly",	
						DisplayName = "mgo_UI_respawn_hq",
					}
					hq = false
					hqFound = true
				else
					local spawnPointMessageId = {
						"mgo_spawn_point_general_1",
						"mgo_spawn_point_general_2",
						"mgo_spawn_point_general_3",
						"mgo_spawn_point_general_4",
					}

					choiceObject = {
						PoiHandles = poiHandles,
						MapPos = { x = parentSearchResult.posX, y = parentSearchResult.posY, z = parentSearchResult.posZ },
						MapIconId = "ApcFriendly",	
						DisplayName = spawnPointMessageId[ currentChoiceIndex ],
					}
					
					choicesArray[ currentChoiceIndex ] = choiceObject
					currentChoiceIndex = currentChoiceIndex + 1
				end
			end
		end
		if hqFound then
			choicesArray[ currentChoiceIndex ] = hqObject
			currentChoiceIndex = currentChoiceIndex + 1
		end
	end
	
	
	
	
	local buddy = ruleset:GetBuddy( player )
	
	if not Entity.IsNull( buddy ) and spawnTypeTag == "RESPAWN" then
	
		local buddyPoints = ruleset:GetBuddyPoints( player.sessionIndex )
		local maxBuddyPoints = ruleset:GetBuddyPointsMax( player.sessionIndex )
		
		
		if PlayerInfo.IsValidBuddySpawnInfo ~= nil then
			if PlayerInfo.IsValidBuddySpawnInfo(buddy.sessionIndex) == false then
				Fox.Log("cannot spawn on the buddy position. the position is invalid")
				buddyPoints = 0
			else
				Fox.Log("can spawn on the buddy position. the position is valid")
			end
		end
		
		if buddyPoints >= ( maxBuddyPoints * 0.5 ) then
	
		
			local buddySearchResults = GameObject.SendCommand( POI_SYSTEM_ID,
					{
						id = "Search",
						criteria = {
							
							type = TppPoi.POI_TYPE_PLAYER,

							
							attributes = {
								
								{ key = "instanceIndex", value = buddy.sessionIndex, },
								
								{ key = "isDead", value = 0 },
							},
						},
					}
				)
				
			local buddySearchResultCount = buddySearchResults.resultCount
			 
			if buddySearchResultCount < 1 then					
				
			else
			
				if buddySearchResultCount > 1 then
					
				end			
				
				local buddySearchResult = buddySearchResults.results[ 1 ]
				
				
				if PlayerInfo.CanSpawnAtBuddy( buddy.sessionIndex ) then
				
					local choiceObject = {
						PoiHandles = { buddySearchResult.handle },
						DisplayName = "mgo_UI_respawn_buddy",
						MapIconId = "PlayerFriendly",
						GameObjectId = buddySearchResult.gameObjectId,
						IsBuddySpawn = true,
						MapPos = { x = buddySearchResult.posX, y = buddySearchResult.posY, z = buddySearchResult.posZ }
					}
					
					choicesArray[ currentChoiceIndex ] = choiceObject
					currentChoiceIndex = currentChoiceIndex + 1
				end
			end
		
		end
	end
		
	

	return finalResult

end


this.BriefingTeamAssignDone = function ()

	local ruleset = MpRulesetManager.GetActiveRuleset()
	
	local allPlayers = ruleset:GetAllActivePlayers().array
	
	for playerIndex = 1, #allPlayers do
		local player = allPlayers[ playerIndex ]
		this.teamRoster[player.sessionIndex] = player.teamIndex
	end
	
	this.initialTeamAssignmentHasHappened = true
	this.DebugDumpTeamRoster()
end



this.TryTeamAssignment = function( ruleset, player )

	if this.initialTeamAssignmentHasHappened == false then
		ruleset:SetPlayerTeam( player, player.sessionIndex % 2 ) 
		return
	end
	
	
	local playerRoleID = ruleset:GetSpecialRole(player.sessionIndex)
	if playerRoleID < 2 then
		return
	end
	
	local playerCounts = { ruleset:GetActivePlayerCountByTeamIndex( Utils.Team.SOLID ), ruleset:GetActivePlayerCountByTeamIndex( Utils.Team.LIQUID ) }
	local team = Utils.Team.SOLID  	
	team = ( (playerCounts[1] > playerCounts[2]) and 1 ) or 0 
	
	if ( ruleset:SetPlayerTeam( player, team ) == false ) then
		Fox.Log("SCRIPT ERROR: SetPlayerTeam returns false")
	end
	this.teamRoster[player.sessionIndex] = team	
	this.DebugDumpTeamRoster()
end


this.TeamRoleAssignment = function( ruleset, player )
	local leaderIndex = MgoMatchMakingManager.GetPartyLeader(player.sessionIndex)
	local playerCounts = { ruleset:GetActivePlayerCountByTeamIndex( Utils.Team.SOLID ), ruleset:GetActivePlayerCountByTeamIndex( Utils.Team.LIQUID ) }
	local team = Utils.Team.SOLID  														
	
	if playerCounts[1] == playerCounts[2] and leaderIndex ~= 255 then   	
		local leader = ruleset:GetPlayerBySessionIndex( leaderIndex )
		if leader.teamIndex ~= 255 then      								
			team = leader.teamIndex
		end
	else
		team = ( (playerCounts[1] > playerCounts[2]) and 1 ) or 0 
	end
	
	
	if ( ruleset:SetPlayerTeam( player, team ) == false ) then
		Fox.Log("SCRIPT ERROR: SetPlayerTeam returns false")
	end
	this.teamRoster[player.sessionIndex] = team
	
	Fox.Log( "Assign Player to Team " .. tostring(team) .. ". Player name: " .. ruleset:GetGamerTagBySessionIndex( player.sessionIndex ) )
	this.DebugDumpTeamRoster()
end

this.BuddyAssignment = function(ruleset)
	local allPlayers = ruleset:GetAllActivePlayers().array
	local buddyTeam0 = nil
	local buddyTeam1 = nil
	
	for playerIndex = 1, #allPlayers do
		local player = allPlayers[ playerIndex ]
		local playerTeam = player.teamIndex
		if playerTeam == Utils.Team.SOLID then
			if buddyTeam0 == nil then
				buddyTeam0 = player.sessionIndex
			else
				ruleset:CreateBuddyRelation( buddyTeam0, player.sessionIndex )
				buddyTeam0 = nil
			end
		else
			if buddyTeam1 == nil then
				buddyTeam1 = player.sessionIndex
			else
				ruleset:CreateBuddyRelation( buddyTeam1, player.sessionIndex )
				buddyTeam1 = nil
			end
		end
	end
end


this.FindBuddy = function(player, ruleset)
	if this.initialTeamAssignmentHasHappened == false then
		return
	end
	
	local allPlayers = ruleset:GetAllActivePlayers().array
	for playerIndex = 1, #allPlayers do
		local potentialBuddy = allPlayers[ playerIndex ]
		if potentialBuddy.sessionIndex ~= player.sessionIndex then
			if potentialBuddy.teamIndex == player.teamIndex then			
				local buddy = ruleset:GetBuddy( potentialBuddy )
				if Entity.IsNull( buddy ) then	
					ruleset:CreateBuddyRelation( potentialBuddy.sessionIndex, player.sessionIndex )
					return
				end
			end
		end
	end
end


this.FindNewBuddyForBuddy = function(player, ruleset)
	
	local buddy = ruleset:GetBuddy( player )
	if not Entity.IsNull( buddy ) then	
		
		this.FindBuddy(buddy, ruleset)
	end
end

this.DebugDumpTeamRoster = function()
	Fox.Log( "-------------------- Debug Dump Team Roster --------------------" )
	for playerIndex, team in pairs(this.teamRoster) do
		Fox.Log( "playerIndex = " .. playerIndex .. ", team = " .. team )
	end
end

return this