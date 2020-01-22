local this = {}
this.pushToParent = {}


local PointsTable = {}
local FlagsTable = {}


this.Init = function( rulesetData, ruleset )
	return true
end


this.pushToParent.OnRulesetRoundStart = function( rulesetData, ruleset )
	if not Mgo.IsHost() then
		return
	end

	PointsTable = {}
	FlagsTable = {}

	
	local controlQuery =
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_GENERIC,
				tags = {
					"CONTROL_POINT",
				},
			}
		}
	local pointsSearch = GameObject.SendCommand( this.owner.POI_SYSTEM_ID, controlQuery )
	if pointsSearch.resultCount < 1 then
		Utils.DisplayError( "TeamSneak_Exfil:SetupPointsAndFlags. Could not find any control points. POI Search Tags=" .. Utils.StringArrayToCSV( controlQuery.criteria.tags ) )    
	else
		for i = 1, #pointsSearch.results do
			local controlPointId = pointsSearch.results[i].gameObjectId
			local controlPointTags = pointsSearch.results[i].tags
			if( controlPointId == nil ) then
				Utils.DisplayError( "TeamSneak_Exfil:SetupPointsAndFlags couldn't get control point gameObjectId for " .. controlPointTags )
			else
				local actor = MgoGameObject.GetActor( controlPointId )
				table.insert( PointsTable, actor )
			end
		end
	end
	
	
	local flagQuery =
		{
			id = "Search",
			criteria = 
			{
				type = TppPoi.POI_GENERIC,
				tags = {
					"OBJECTIVE",
				},
			}
		}
	local flagsSearch = GameObject.SendCommand( this.owner.POI_SYSTEM_ID, flagQuery )
	if flagsSearch.resultCount < 1 then
		Utils.DisplayError( "TeamSneak_Exfil:SetupPointsAndFlags. Could not find any flags. POI Search Tags=" .. Utils.StringArrayToCSV( flagQuery.criteria.tags ) )    
	else
		for i = 1, #flagsSearch.results do
			local flagId = flagsSearch.results[i].gameObjectId
			local flagTags = flagsSearch.results[i].tags
			if( flagId == nil ) then
				Utils.DisplayError( "TeamSneak_Exfil:SetupPointsAndFlags couldn't get flag gameObjectId for " .. flagTags )
			else
				local actor = MgoGameObject.GetActor( flagId )
				table.insert( FlagsTable, actor )
			end
		end
	end
end


this.pushToParent.OnEventSignal = function( triggeredId, eventCode, triggeringTeam, triggeringPlayer )	

	if not Mgo.IsHost() then
		return
	end
	local ruleset = MpRulesetManager.GetActiveRuleset()
	
	if eventCode == Fox.StrCode32( "flagreturn" ) then
		local actor = MgoGameObject.GetActor(triggeredId)
		this.owner.setFlagDropped( nil, actor:GetParm().MarkerName, false )
	end

	
	if eventCode == Fox.StrCode32("Captured") then
		TeamSneak_Scoring.ExfilDone(triggeringTeam, triggeringPlayer)
		return
	end
	
	
	
	if eventCode == Fox.StrCode32("flagPickup") or eventCode == Fox.StrCode32("flagDrop") then
		for i, pointActor in ipairs( PointsTable ) do
			if pointActor ~= nil then
				pointActor:SetActive( true )
			end
		end
		return
	end
end

this.checkFlagKill = function(victimIndex, killerIndex)
	local ruleset = MpRulesetManager.GetActiveRuleset()
	for i, flagActor in ipairs( FlagsTable ) do
		if flagActor ~= nil and flagActor:GetTable().AttachedToPlayerIndex ~= nil and flagActor:GetTable().AttachedToPlayerIndex >= 0 then
			if flagActor:GetTable().AttachedToPlayerIndex == victimIndex then
				ruleset:IncrementStatByPlayerIndex( killerIndex, MgoStat.STAT_DISC_DEFEND, 1 )
				ruleset:RulesetMessage( {player=killerIndex,  statId = "STAT_DISC_DEFEND", langTag = "mgo_ui_obj_discdefend" } )
			end
		end
	end
end

return this
