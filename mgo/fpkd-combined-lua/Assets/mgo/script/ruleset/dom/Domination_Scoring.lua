







local this = {}



local targetHoldTimeFor2Coefficient = 1.2


local actualCaptureRate = 0

local captureRateWith2Points = 3

local captureRateWith3Points = 6




this.pushToParent = {}





this.capturingPlayerBitsMap = {}


this.Init = function( rulesetData, ruleset, owner )
	
	
	ruleset:SetTeamWinnerStat( MgoStat.STAT_COMTIX )
	ruleset:SetPlayerSortingStat( MgoStat.STAT_TEAM_POINTS )

	return true
end

this.pushToParent.OnPlayerTagged = function( ruleset, taggedPlayer, taggerPlayer )             
	if ruleset and ruleset:IsRunningOnHost() then
		ruleset:IncrementStatByPlayerIndex( taggerPlayer.sessionIndex, MgoStat.STAT_TAG, 1 )
		ruleset:IncrementStatByPlayerIndex( taggedPlayer.sessionIndex, MgoStat.STAT_TAGGED, 1 )
		ruleset:RulesetMessage( {player=taggerPlayer.sessionIndex,  statId = "STAT_TAG", langTag = "mgo_ui_ruleticker_mark" } )
	end
end





this.pushToParent.OnRulesetRoundStart = function( rulesetData, ruleset )
	actualCaptureRate = ruleset.data.DominationTicketCount / ( vars.roundTimeLimit * targetHoldTimeFor2Coefficient )

	
	
end





this.SetCapturerData = function (controlPointId, capturerBitArray)
	this.capturingPlayerBitsMap[controlPointId] = capturerBitArray
end





this.pushToParent.OnPlayerDeath = function( rulesetData, ruleset, player, killer, assister, lastDamage, isHeadshot, lastAttackId )	
	
	if not Entity.IsNull( killer ) then
		if killer ~= player and lastAttackId ~= TppDamage.ATK_FultonDevice and killer.teamIndex ~= player.teamIndex then
			local ownerTeamTable = Domination_Exfil.GetCurrentOwnerTeam()
			for key,value in pairs(ownerTeamTable) do
				
				local outpostId = Domination_Exfil.idxReverseMap[key]
				
				local capturingPlayerBits = this.capturingPlayerBitsMap[outpostId]

				
				if Utils.TestFlag(capturingPlayerBits, player.sessionIndex + 1 ) and killer.teamIndex == value then
					ruleset:IncrementStatByPlayerIndex( killer.sessionIndex, MgoStat.STAT_DOM_DEFEND, 1 )	
					ruleset:RulesetMessage( {player = killer.sessionIndex,  statId = "STAT_DOM_DEFEND", langTag = "mgo_ui_obj_commdefend" } )
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





this.NeutralizeDominationPoint = function ( dominationPoint, teamIdx, prevOwner, capturerBitArray )

	local ruleset = MpRulesetManager.GetActiveRuleset()
	
	local otherTeamIndex
	if teamIdx == Utils.Team.SOLID then 
		otherTeamIndex = Utils.Team.LIQUID
	else
		otherTeamIndex = Utils.Team.SOLID
	end
	
	ruleset:DecrementStatByTeamIndex( otherTeamIndex, MgoStat.STAT_DOMTEAM, 1)
	
	for sessionIndex = 0, 15 do
		if Utils.TestFlag( capturerBitArray, sessionIndex + 1 ) then
			local player = ruleset:GetPlayerBySessionIndex( sessionIndex )
			if player ~= nil then
				if player.teamIndex == teamIdx then
					ruleset:IncrementStatByPlayerIndex( sessionIndex, MgoStat.STAT_DOM_NEUTRAL, 1 )	
					ruleset:RulesetMessage( {player = sessionIndex,  statId = "STAT_DOM_NEUTRAL", langTag = "mgo_ui_ruleticker_com_neutral" } )
				end
			end
		end
	end
	
	for teamIndex,data in pairs(this.DominationPointsOwned) do
		if data ~= nil then
			data[dominationPoint] = nil
		end
	end

end





this.CaptureDominationPoint = function ( dominationPoint, teamIdx, capturerBitArray )

	local ruleset = MpRulesetManager.GetActiveRuleset()
	ruleset:IncrementStatByTeamIndex( teamIdx, MgoStat.STAT_DOMTEAM, 1 )
	for sessionIndex = 0, 15 do
		if Utils.TestFlag( capturerBitArray, sessionIndex + 1 ) then
			local player = ruleset:GetPlayerBySessionIndex( sessionIndex )
			if player ~= nil then
				if player.teamIndex == teamIdx then
					ruleset:IncrementStatByPlayerIndex( sessionIndex, MgoStat.STAT_DOM, 1 )	
					ruleset:RulesetMessage( {player = sessionIndex,  statId = "STAT_DOM", langTag = "mgo_ui_ruleticker_com_capture" } )
				end
			end
		end
	end
	
		
	if(this.DominationPointsOwned[teamIdx] == nil) then
		this.DominationPointsOwned[teamIdx] = {}
	end
	this.DominationPointsOwned[teamIdx][dominationPoint] = true

	
	if(this.periodicScoringCbId == nil) and teamIdx == this.owner.attacker and ruleset:GetStatByTeamIndex( this.owner.defender, MgoStat.STAT_COMTIX ) > 0 then
		
		ruleset:DecrementStatByTeamIndex( this.owner.defender, MgoStat.STAT_COMTIX, ruleset.data.DominationCaptureBonusTickets )

		this.periodicScoringCbId = Util.SetInterval( 1000, true, this._scriptPath, "PeriodicDominationPointScore", player)
	end
end

this.periodicScoringCbId = nil
this.DominationPointsOwned = { }
this.TicketsAccumulated = { 0, 0, 0, 0 }





this.ResetDominationPoint = function( dominationPoint )

	Domination.DisplayLog( "ResetDominationPoint = " .. tostring(dominationPoint) )

	for teamIndex,data in pairs(this.DominationPointsOwned) do
		if data ~= nil then
			data[dominationPoint] = nil
		end
	end

end


this.PeriodicDominationPointScore = function( player )
	local anyDominationPoints = false

	local ruleset = MpRulesetManager.GetActiveRuleset()
	local roundState 	= ruleset.currentState
	
	
	if "RULESET_STATE_ROUND_REGULAR_PLAY" == roundState then
		for teamIdx,data in pairs(this.DominationPointsOwned) do
			if teamIdx == this.owner.attacker then

				local dominationPointsOwned = 0

				for id,value in pairs(data) do

					if(value == true) then
						dominationPointsOwned = dominationPointsOwned + 1				
						anyDominationPoints = true
					end
				end

				if dominationPointsOwned > 0 then
					local scoreRate
					
					if dominationPointsOwned == 1 then
						scoreRate = actualCaptureRate
					elseif dominationPointsOwned == 2 then
						scoreRate = actualCaptureRate * captureRateWith2Points
					else
						scoreRate = actualCaptureRate * captureRateWith3Points
					end
					
					
					
					local ticketsThisTick = scoreRate
					
					
					this.TicketsAccumulated[ teamIdx + 1 ] = this.TicketsAccumulated[ teamIdx + 1 ] + ticketsThisTick
					
					if this.TicketsAccumulated[ teamIdx + 1 ] > 1 then

						local consumed = math.floor( this.TicketsAccumulated[ teamIdx + 1 ] )
						local remainder = this.TicketsAccumulated[ teamIdx + 1 ] - consumed

						
						if ruleset:GetStatByTeamIndex( this.owner.defender, MgoStat.STAT_COMTIX ) > 0 then
							ruleset:DecrementStatByTeamIndex( this.owner.defender, MgoStat.STAT_COMTIX, consumed )
						end

						

						
						this.TicketsAccumulated[ teamIdx + 1 ] = remainder
					end			
				end
			end
		end

		if( not anyDominationPoints ) then
			this.periodicScoringCbId = nil
			this.DominationPointsOwned = {}
			return false  
		end
	end

	return true
end

this.ResetBaseScoring = function()

	if(this.periodicScoringCbId ~= nil) then
		Util.ClearInterval(this.periodicScoringCbId)
	end

	this.periodicScoringCbId = nil
	this.DominationPointsOwned = {}

end

this.pushToParent.OnRulesetRoundEnd = function( rulesetData, ruleset )
	this.ResetBaseScoring()
end




return this






