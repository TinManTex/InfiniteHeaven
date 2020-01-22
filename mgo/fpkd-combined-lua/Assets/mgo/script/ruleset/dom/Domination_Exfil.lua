






local this = {}



this.pushToParent = {}

this.activePointsMap = {}
this.idxMap = {}
this.idxReverseMap = {}
this.currentOwnerTeam = { }
this.setDefenderOwned = 0

local exfilTeam = -1

this.GetCurrentOwnerTeam = function()
	return this.currentOwnerTeam
end

this.Init = function( rulesetData, ruleset )
	return true
end

this.SetOwner = function(idx, teamIdx)
	GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "SetOwnerTeam", ownerTeam = teamIdx } )
	this.currentOwnerTeam[idx] = teamIdx
end

this.OnOwnershipChange = function( outpostId, teamIdx, newOwner, capturerBitArray )
	
	if this.setDefenderOwned < 3 then
		this.setDefenderOwned = this.setDefenderOwned + 1
	else

		local index = this.idxMap[outpostId]
		local prevOwner = this.currentOwnerTeam[index]		
		local ruleset = MpRulesetManager.GetActiveRuleset()

		if(prevOwner == newOwner) then
		elseif(newOwner == nil) then
			
			Domination_Scoring.NeutralizeDominationPoint(outpostId, teamIdx, prevOwner, capturerBitArray)
			TppNetworkUtil.SyncedExecute( this._scriptPath, "UpdateDomPointOwnerNone", index)
		else
			
			TppNetworkUtil.SyncedExecute( this._scriptPath, "UpdateDomPointOwnerNew", index, teamIdx)
			
			Domination_Scoring.CaptureDominationPoint(outpostId, teamIdx, capturerBitArray)
				
			TppNetworkUtil.SyncedExecute( this._scriptPath, "announceDomCapture", index, teamIdx)
		end
	end
end


this.UpdateDomPointOwnerNew = function(index, teamIdx)
	this.currentOwnerTeam[index] = teamIdx
	GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "UpdateOwnership", domPtIndex = index, teamIndex = teamIdx } )
end


this.UpdateDomPointOwnerNone = function(index)	
	this.currentOwnerTeam[index] = nil
	GameObject.SendCommand( {type="MgoActor"}, { id="ExecuteScriptAll", command = "UpdateOwnership", domPtIndex = index, teamIndex = nil } )
	TppSoundDaemon.PostEvent( "sfx_point_neutralized" )
end

this.announceDomCapture = function(domPoint, team)	

	local ruleset = MpRulesetManager.GetActiveRuleset()
	local localTeam = ruleset:GetLocalPlayerTeam()
	
	if localTeam == team then
		if domPoint == 1 then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_dom_commA" )
		elseif domPoint == 2 then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_dom_commB" )
		elseif domPoint == 3 then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_dom_commC" )
		end
		TppSoundDaemon.PostEvent( "sfx_friendly_captured_point" )
	else
		if domPoint == 1 then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_dom_commA_enemy" )
		elseif domPoint == 2 then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_dom_commB_enemy" )
		elseif domPoint == 3 then
			TppUiCommand.AnnounceLogViewLangId( "mgo_announce_dom_commC_enemy" )
		end
		TppSoundDaemon.PostEvent( "sfx_enemy_captured_point" )
	end
end

this.pushToParent.OnEventSignal = function( triggeredId, eventCode, triggeringTeam, capturerBitArray )	
	
	local controlPointId = triggeredId
	local index = this.idxMap[controlPointId]

	if index == nil then
			
			
		return
	end

	if eventCode == Fox.StrCode32("Captured") then
		this.OnOwnershipChange(controlPointId, triggeringTeam, triggeringTeam, capturerBitArray )
	elseif eventCode == Fox.StrCode32("Neutral" ) then
		this.OnOwnershipChange(controlPointId, triggeringTeam, nil, capturerBitArray )	
	elseif eventCode == Fox.StrCode32("Capturing" ) then
		
    end
    
    
    Domination_Scoring.SetCapturerData(controlPointId, capturerBitArray)
    
end

this.pushToParent.OnRoundCountdownStart = function( rulesetData, ruleset, player, roundIndex )	
	if player.sessionIndex == 0 then
		local searchTags = {
			"DOMINATION",
			"CONTROL_POINT",
		}

		local controlPoint = GameObject.SendCommand( this.owner.POI_SYSTEM_ID,
			{
				id = "Search",
				criteria = 
				{
					type = TppPoi.POI_GENERIC,
					tags = searchTags,
				}
			}
		)
		this.setDefenderOwned = 0

		if controlPoint.resultCount < 1 then
			return
		else	
			for idx = 1, controlPoint.resultCount do
				local controlPointId = controlPoint.results[idx].gameObjectId
				this.currentOwnerTeam[idx] = this.owner.defender
				TppNetworkUtil.SyncedExecute( "Domination_Exfil", "SetOwner", idx, this.owner.defender)

				if(controlPointId == nil) then
					Domination.DisplayError( "Domination_Base:SetupActiveControlPoint couldn't get control point gameObjectId for " .. this.Tags[idx] )
				else
					if controlPoint.results[idx].tags[1] == "GENERIC_01" then
						this.idxMap[controlPointId] = 1
						this.idxReverseMap[ 1 ] = controlPointId
					elseif controlPoint.results[idx].tags[1] == "GENERIC_02" then
						this.idxMap[controlPointId] = 2
						this.idxReverseMap[ 2 ] = controlPointId
					elseif controlPoint.results[idx].tags[1] == "GENERIC_03" then
						this.idxMap[controlPointId] = 3
						this.idxReverseMap[ 3 ] = controlPointId
					end
				end
			end
		end
	end
end

this.pushToParent.OnPlayerConnect = function( rulesetData, ruleset, player )
	if not Mgo.IsHost() then
		return
	end

	local roundState = ruleset.currentState
	if roundState ~= "RULESET_STATE_ROUND_REGULAR_PLAY" 
		and roundState ~= "RULESET_STATE_ROUND_OVERTIME"
		and roundState ~= "RULESET_STATE_ROUND_SUDDEN_DEATH"
		and roundState ~= "RULESET_STATE_ROUND_COUNTDOWN"
	then
		return
	end

	local searchTags = {
		"DOMINATION",
		"CONTROL_POINT",
	}

	local controlPoint = GameObject.SendCommand( this.owner.POI_SYSTEM_ID,
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_GENERIC,
				tags = searchTags,
			}
		}
	)

	if controlPoint.resultCount < 1 then
		return
	else
		for idx = 1, controlPoint.resultCount do
			TppNetworkUtil.SyncedExecuteSessionIndex( player.sessionIndex, "Domination_Exfil", "SetOwner", idx, this.currentOwnerTeam[idx] )
		end
	end
end




return this






