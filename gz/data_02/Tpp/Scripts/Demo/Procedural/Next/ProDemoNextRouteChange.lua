





































ProDemoNextRouteChange = {





events = {
	PRO_DEMO_GAMESCRIPT1 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT2 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT3 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT4 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT5 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT6 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT7 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
	PRO_DEMO_GAMESCRIPT8 = { PlayEnd = "OnProDemoPlayEnd", Break = "OnProDemoBreak", Stop = "OnProDemoStop" },
},


AddDynamicPropertiesToData = function( data, body )





	data:AddProperty( "EntityLink", "character" )			
	data.character = NULL

	data:AddProperty( "EntityLink", "playEndPatrolRoute" )	
	data.playEndPatrolRoute = NULL
	data:AddProperty( "int32", "playEndPatrolRoutePoint" )	
	data.playEndPatrolRoutePoint = 0
	data:AddProperty( "EntityLink", "playEndCautionRoute" )	
	data.playEndCautionRoute = NULL
	data:AddProperty( "int32", "playEndCautionRoutePoint" )	
	data.playEndCautionRoutePoint = 0

	data:AddProperty( "EntityLink", "breakPatrolRoute" )	
	data.breakPatrolRoute = NULL
	data:AddProperty( "int32", "breakPatrolRoutePoint" )	
	data.breakPatrolRoutePoint = 0
	data:AddProperty( "EntityLink", "breakCautionRoute" )	
	data.breakCautionRoute = NULL
	data:AddProperty( "int32", "breakCautionRoutePoint" )	
	data.breakCautionRoutePoint = 0

	data:AddProperty( "EntityLink", "stopPatrolRoute" )		
	data.stopPatrolRoute = NULL
	data:AddProperty( "int32", "stopPatrolRoutePoint" )		
	data.stopPatrolRoutePoint = 0
	data:AddProperty( "EntityLink", "stopCautionRoute" )	
	data.stopCautionRoute = NULL
	data:AddProperty( "int32", "stopCautionRoutePoint" )	
	data.stopCautionRoutePoint = 0

end,







OnProDemoPlayEnd = function( data, body, sender, id, arg1, arg2, arg3 )





	
	local characterLocatorData = data.character
	local patrolRouteData      = data.playEndPatrolRoute
	local patrolRoutePoint     = data.playEndPatrolRoutePoint
	local cautionRouteData     = data.playEndCautionRoute
	local cautionRoutePoint    = data.playEndCautionRoutePoint
	ProDemoNextRouteChange.CharacterRouteChange( data, body, characterLocatorData, patrolRouteData, patrolRoutePoint, cautionRouteData, cautionRoutePoint )

end,



OnProDemoBreak = function( data, body, sender, id, arg1, arg2, arg3 )





	
	local characterLocatorData = data.character
	local patrolRouteData      = data.breakPatrolRoute
	local patrolRoutePoint     = data.breakPatrolRoutePoint
	local cautionRouteData     = data.breakCautionRoute
	local cautionRoutePoint    = data.breakCautionRoutePoint
	ProDemoNextRouteChange.CharacterRouteChange( data, body, characterLocatorData, patrolRouteData, patrolRoutePoint, cautionRouteData, cautionRoutePoint )

end,



OnProDemoStop = function( data, body, sender, id, arg1, arg2, arg3 )





	
	local characterLocatorData = data.character
	local patrolRouteData      = data.stopPatrolRoute
	local patrolRoutePoint     = data.stopPatrolRoutePoint
	local cautionRouteData     = data.stopCautionRoute
	local cautionRoutePoint    = data.stopCautionRoutePoint
	ProDemoNextRouteChange.CharacterRouteChange( data, body, characterLocatorData, patrolRouteData, patrolRoutePoint, cautionRouteData, cautionRoutePoint )

end,







CharacterRouteChange = function( data, body, characterLocatorData, patrolRouteData, patrolRoutePoint, cautionRouteData, cautionRoutePoint )

	if characterLocatorData == NULL then



		return
	end

	
	local characterLocatorBody = characterLocatorData:GetDataBodyWithReferrer( body )
	if characterLocatorBody == NULL or not characterLocatorBody:IsKindOf( ChCharacterLocator ) then



		return
	end

	if patrolRouteData == NULL and cautionRouteData == NULL then



		return
	end

	
	if patrolRouteData ~= NULL then



		TppEnemyMoveUtility.ChangeSneakRoute( characterLocatorBody, patrolRouteData, patrolRoutePoint )
	end
	if cautionRouteData ~= NULL then



		TppEnemyMoveUtility.ChangeCautionRoute( characterLocatorBody, cautionRouteData, cautionRoutePoint )
	end

end,

}

