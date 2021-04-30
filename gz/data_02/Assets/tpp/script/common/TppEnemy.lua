local this = {}




this.Messages = {
	CommandPost = {
		{ message = "Sneak", commonFunc = function() this._ChangeRouteSetOnPhase( "sneak" ) end },
		{ message = "Caution", commonFunc = function() this._ChangeRouteSetOnPhase( "caution" ) end },
	},
	Weather = {
		{ message = "_locationDayTime",		commonFunc = function() this._ChangeRouteSetOnTime( "day" ) end },
		{ message = "_locationNightTime",	commonFunc = function() this._ChangeRouteSetOnTime( "night" ) end },
	},
}




this.PhaseNames = {
	sneak	= "Sneak",
	caution	= "Caution",
	alert	= "Alert",
}

this.RouteSetTypes = {
	"sneak_day",
	"sneak_night",
	"caution_day",
	"caution_night",
	"hold",
}

this.EnemyStatusList = {
	dead			= "Dead",
	dying			= "Dying",
	sleep			= "Sleep",
	faint			= "Faint",
	broken_leftArm	= "BrokenLArm",
	broken_rightArm	= "BrokenRArm",
	broken_leftLeg	= "BrokenLLeg",
	broken_rightLeg	= "BrokenRLeg",
	dropWeapon		= "DropWeapon",
	holdUp			= "HoldUp",
	lieDown			= "HoldUpDown",
}






this.Setup = function()



	
	
	local defaultRouteSets = TppLocation.GetDefaultRouteSets()
	this.SetRouteSets( defaultRouteSets, { warpEnemy = true } )
end






this.GetCharacter = function( characterID )
	TppCommon.DeprecatedFunction( "Ch.FindCharacterObjectByCharacterId( characterID )" )
	return Ch.FindCharacterObjectByCharacterId( characterID )
end


this.GetPosition = function( characterID )
	TppCommon.DeprecatedFunction( "character:GetPosition()" )
	local character = this.GetCharacter( characterID )
	if( character == nil ) then return end
	return character:GetPosition()
end


this.SetPosition = function( characterID, position )
	TppCommon.DeprecatedFunction( "character:SetPosition( position )" )
	local character = this.GetCharacter( characterID )
	if( character == nil ) then return end
	character:SetPosition( position )
end


this.GetRotation = function( characterID )
	TppCommon.DeprecatedFunction( "character:GetRotation()" )
	local character = this.GetCharacter( characterID )
	if( character == nil ) then return end
	return character:GetRotation()
end


this.SetRotation = function( characterID, rotation )
	TppCommon.DeprecatedFunction( "character:SetRotation( rotation )" )
	local character = this.GetCharacter( characterID )
	if( character == nil ) then return end
	character:SetRotation( rotation )
end


this.Warp = function( characterID, warpLocator )
	TppCommon.DeprecatedFunction( "TppCharacterUtility.WarpCharacterIdFromIdentifier( characterID, dataIdentifierID, keyName )" )
	local missionName = TppMission.GetMissionName()
	local warpLocatorID = missionName .. "_warpLocators"
	TppCharacterUtility.WarpCharacterIdFromIdentifier( characterID, warpLocatorID, warpLocator )
end


this.IsWithinDistance = function( chara01, chara02, distance )
	local pos1 = this.GetPosition( chara01 )
	local pos2 = this.GetPosition( chara02 )
	local dist = TppUtility.FindDistance( pos1, pos2 )

	
	if( dist <= (distance * distance) ) then
		return true
	else
		return false
	end
end


this.SetFormVariation = function( characterID, fovaKey )
	return TppCharacterUtility.ChangeFormVariationWithCharacterId( characterID, fovaKey, 0)
end






this.GetEnemyStatus = function( characterID )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.GetLifeStatus( characterID )" )



	return TppEnemyUtility.GetLifeStatus( characterID )
end


this.SetEnemyStatus = function( characterID, status )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.ChangeStatus( characterID, status )" )



	local _status = this.EnemyStatusList[status]
	if( _status == nil ) then



		return
	end
	TppEnemyUtility.ChangeStatus( characterID, _status )
end


this.GetHostageStatus = function( characterID )
	TppCommon.DeprecatedFunction( "TppHostageUtility.GetStatus( characterID )" )



	return TppHostageUtility.GetStatus( characterID )
end


this.GetEnemyType = function( characterID )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.GetEnemyType( characterID )" )



	return TppEnemyUtility.GetEnemyType( characterID )
end


this.GetEnemyCountNearEnemy = function( characterID, radius )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( characterID, radius )" )



	return TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( characterID, radius )
end


this.RealizeEnemy = function( cpID, characterID, options )



	options = options or {}

	if( options.setPriority == true ) then
		TppCommandPostObject.GsSetRealizeFirstPriority( cpID, characterID, true )
	else
		TppCommandPostObject.GsSetRealizeEnable( cpID, characterID, true )
	end
end


this.UnrealizeEnemy = function( cpID, characterID, options )



	options = options or {}

	if( options.setPriority == true ) then
		TppCommandPostObject.GsSetRealizeFirstPriority( cpID, characterID, false )
	else
		TppCommandPostObject.GsSetRealizeEnable( cpID, characterID, false )
	end
end


this.KillEnemy = function( characterID )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.KillEnemy( characterID )" )



	TppEnemyUtility.KillEnemy( characterID )
end


this.KillCommandPost = function( cpID )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.GetNumberOfActiveSoldierByCharacterId( characterID, radius )" )



	TppEnemyUtility.KillAllEnemiesInCp( cpID )
end






this.GetPhase = function( cpID )




	
	local phase
	if( cpID == nil ) then
		phase = TppCharacterUtility.GetCurrentPhaseName()
	else
		phase = TppCharacterUtility.GetCpPhaseName( cpID )
	end
	return string.lower( phase )
end


this.SetMinimumPhase = function( cpID, phase )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsSetKeepPhaseName( cpID, phase )" )



	if( this._IsPhaseNameValid( phase ) == false ) then return end
	local _phase = this.PhaseNames[phase]
	TppCommandPostObject.GsSetKeepPhaseName( cpID, _phase )
end






this.GetCharacterOnRoute = function( cpID, routeID )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.GetCharacterIdByRoute( cpID, routeID )" )



	return TppEnemyUtility.GetCharacterIdByRoute( cpID, routeID )
end


this.ChangeRoute = function( cpID, enemyID, routeSetName, routeName, nodeNum, options )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsSetPriorityEnemyForRoute( cpID, routeSetName, routeName, nodeNum, enemyID, priorityType )" )



	options = options or {}

	local priorityType
	if( options.forceChange == true ) then
		priorityType = "ROUTE_PRIORITY_TYPE_FORCED"
	else
		priorityType = "ROUTE_PRIORITY_TYPE_NORMAL"
	end

	TppCommandPostObject.GsSetPriorityEnemyForRoute( cpID, routeSetName, routeName, nodeNum, enemyID, priorityType )
end


this.EnableRoute = function( cpID, routeName, options )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsDeleteDisabledRoutes( cpID, routeName, noForceUpdate )" )



	options = options or {}
	local noForceUpdate = options.noForceUpdate or false

	TppCommandPostObject.GsDeleteDisabledRoutes( cpID, routeName, noForceUpdate )
end


this.DisableRoute = function( cpID, routeName, options )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsAddDisabledRoutes( cpID, routeName, noForceUpdate )" )



	options = options or {}
	local noForceUpdate = options.noForceUpdate or false

	TppCommandPostObject.GsAddDisabledRoutes( cpID, routeName, noForceUpdate )
end






this.ChangeRouteSet = function( cpID, routeSetName, options )



	options = options or {}
	local forceUpdate = options.forceUpdate or false
	local forceReload = options.forceReload or false
	local startAtZero = options.startAtZero or false
	local warpEnemy = options.warpEnemy or false

	
	if( warpEnemy == true ) then
		TppCharacterUtility.ResetPhase()
	end

	TppCommandPostObject.GsSetCurrentRouteSet( cpID, routeSetName, forceUpdate, forceReload, startAtZero, warpEnemy )
end


this.SetRouteSets = function( routeSets, options )



	for i = 1, #routeSets do
		local cpID = routeSets[i].cpID
		local holdTime = routeSets[i].holdTime
		local sets = routeSets[i].sets
		for routeSetType, routeSetName in pairs( sets ) do
			TppEnemy.RegisterRouteSet( cpID, routeSetType, routeSetName )
		end
		TppEnemy.RegisterHoldTime( cpID, holdTime )
		TppEnemy.SetStartingRouteSet( cpID, options )
	end
end


this.RegisterHoldTime = function( cpID, holdTime )



	this.m_holdTimes[cpID] = holdTime
end


this.ShiftRouteSet = function( cpID, routeSets, holdTime, options )



	options = options or {}
	local doReverseShift = options.doReverseShift or false

	if( routeSets.routeSetStartToHold ~= nil ) then
		TppCommandPostObject.GsAddRouteSetConnection( cpID, routeSets.routeSetStart, routeSets.routeSetHold, routeSets.routeSetStartToHold )
	end
	if( routeSets.routeSetHoldToEnd ~= nil ) then
		TppCommandPostObject.GsAddRouteSetConnection( cpID, routeSets.routeSetHold, routeSets.routeSetEnd, routeSets.routeSetHoldToEnd )
	end
	TppCommandPostObject.GsSetRouteSetShift( cpID, routeSets.routeSetEnd, routeSets.routeSetHold, not doReverseShift, holdTime )
end






this.EnableGuardTarget = function( cpID, guardTarget )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsSetGuardTargetValidity( cpID, guardTarget, true )" )



	TppCommandPostObject.GsSetGuardTargetValidity( cpID, guardTarget, true )
end


this.DisableGuardTarget = function( cpID, guardTarget )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsSetGuardTargetValidity( cpID, guardTarget, false )" )



	TppCommandPostObject.GsSetGuardTargetValidity( cpID, guardTarget, false )
end






this.EnableCombatLocator = function( cpID, combatLocator )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsSetCombatLocatorValidity( cpID, combatLocator, true )" )



	TppCommandPostObject.GsSetCombatLocatorValidity( cpID, combatLocator, true )
end


this.DisableCombatLocator = function( cpID, combatLocator )
	TppCommon.DeprecatedFunction( "TppCommandPostObject.GsSetCombatLocatorValidity( cpID, combatLocator, false )" )



	TppCommandPostObject.GsSetCombatLocatorValidity( cpID, combatLocator, false )
end






this.EnableEnemyReaction = function()
	TppCommon.DeprecatedFunction( "TppEnemyUtility.SetNoReactionModeForCutScene( false )" )



	TppEnemyUtility.SetNoReactionModeForCutScene( false )
end


this.DisableEnemyReaction = function()
	TppCommon.DeprecatedFunction( "TppEnemyUtility.SetNoReactionModeForCutScene( true )" )



	TppEnemyUtility.SetNoReactionModeForCutScene( true )
end


this.EnableDemoEnemies = function( demoName )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.SetForcedUnrealizeOutOfCutScene( false )" )
	TppEnemyUtility.SetForcedUnrealizeOutOfCutScene( false )
end


this.DisableDemoEnemies = function( demoName )
	TppCommon.DeprecatedFunction( "TppEnemyUtility.SetForcedUnrealizeOutOfCutScene( true, demoName )" )
	TppEnemyUtility.SetForcedUnrealizeOutOfCutScene( true, demoName )
end


this.EnableSecurityCamera = function()
	TppCommon.DeprecatedFunction( "TppEnemyUtility.StopSecurityCamera( false )" )
	TppEnemyUtility.StopSecurityCamera( false )
end


this.DisableSecurityCamera = function()
	TppCommon.DeprecatedFunction( "TppEnemyUtility.StopSecurityCamera( true )" )
	TppEnemyUtility.StopSecurityCamera( true )
end


this.RegisterRouteSet = function( cpID, routeSetType, routeSetName )



	if( this._IsRouteSetTypeValid( routeSetType ) == false ) then return end
	if( this.m_routeSets[cpID] == nil ) then
		this.m_routeSets[cpID] = {}
	end
	this.m_routeSets[cpID][routeSetType] = routeSetName
end


this.SetStartingRouteSet = function( cpID, options )



	if( this._IsCharacterIDValid( cpID ) == false ) then return end
	local phase = this.GetPhase( cpID )
	local timeOfDay = TppClock.GetTimeOfDay()
	local routeSetType = phase .. "_" .. timeOfDay

	
	if( this.m_routeSets == nil or
		this.m_routeSets[cpID] == nil or
		this.m_routeSets[cpID][routeSetType] == nil ) then return end

	this.ChangeRouteSet( cpID, this.m_routeSets[cpID][routeSetType], options )
end






this._IsCharacterIDValid = function( characterID )
	local character = Ch.FindCharacterObjectByCharacterId( characterID )
	if( character == nil ) then
		return false
	else
		return true
	end
end


this._IsPhaseNameValid = function( phaseName )
	if( phaseName == nil or type( phaseName ) ~= "string" ) then



		return false
	end

	for k, v in pairs( this.PhaseNames ) do
		if( phaseName == k ) then
			return true
		end
	end




	return false
end


this._IsRouteSetTypeValid = function( routeSetType )
	if( routeSetType == nil or type( routeSetType ) ~= "string" ) then



		return false
	end

	for i = 1, #this.RouteSetTypes do
		if( routeSetType == this.RouteSetTypes[i] ) then
			return true
		end
	end




	return false
end


this._ChangeRouteSetOnPhase = function( phase )
	local cpID = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	if( this._IsCharacterIDValid( cpID ) == false ) then return end
	if( this.m_routeSets[cpID] == nil ) then return end

	local timeOfDay = TppClock.GetTimeOfDay()
	local routeSetType = phase .. "_" .. timeOfDay
	this.ChangeRouteSet( cpID, this.m_routeSets[cpID][routeSetType] )
end


this._ChangeRouteSetOnTime = function( time )
	for cpID, routeSets in pairs( this.m_routeSets ) do
		if( this._IsCharacterIDValid( cpID ) == true ) then
			local sets = {}

			local phase = this.GetPhase( cpID )
			if( phase == "sneak" or phase == "caution" ) then
				local dayRoute = phase .. "_day"
				local nightRoute = phase .. "_night"

				if( time == "day" ) then
					sets.routeSetStart = routeSets[nightRoute]
					sets.routeSetEnd = routeSets[dayRoute]
				elseif( time == "night" ) then
					sets.routeSetStart = routeSets[dayRoute]
					sets.routeSetEnd = routeSets[nightRoute]
				end
				sets.routeSetHold = routeSets.hold
				local holdTime = this.m_holdTimes[cpID]

				this.ShiftRouteSet( cpID, sets, holdTime )
			end
		end
	end
end




this.m_routeSets = {}
this.m_holdTimes = {}




return this
