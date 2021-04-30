local this = {}




this.StartStatusList = {
	rideHeli_sit		= "ACTION_STATUS_RIDE_HELI",
	rideHeli_standLeft	= "ACTION_STATUS_RIDE_HELI_LEFT",
	rideHeli_standRight	= "ACTION_STATUS_RIDE_HELI_RIGHT",
}

this.DisableAbilityList = {
	Stand	= "DIS_ACT_STAND",
	Squat	= "DIS_ACT_SQUAT",
	Crawl	= "DIS_ACT_CRAWL",
	Dash	= "DIS_ACT_DASH",
}

this.ControlModeList = {
	LockPadMode					= "All",
	LockMBTerminalOpenCloseMode	= "MB_Disable",
	MBTerminalOnlyMode			= "MB_OnlyMode",
}

this.StockDirectionRight = 0
this.StockDirectionLeft = 1






this.GetPlayer = function()
	TppCommon.DeprecatedFunction( "TppPlayerUtility.GetLocalPlayerCharacter()" )
	return TppPlayerUtility.GetLocalPlayerCharacter()
end


this.SetStartStatus = function( startStatus )
	TppCommon.DeprecatedFunction( "TppPlayerUtility.SetActionStatusOnStartMission( startStatus )" )
	if( this._IsStartStatusValid( startStatus ) == false ) then return end
	TppPlayerUtility.SetActionStatusOnStartMission( this.StartStatusList[startStatus] )
end


this.SetEventStatus = function( eventStatus )
	PlayerManager:SetEventState( eventStatus )
end


this.GetPosition = function()
	TppCommon.DeprecatedFunction( "player:GetPosition()" )
	local player = this.GetPlayer()
	return player:GetPosition()
end


this.SetPosition = function( position )
	TppCommon.DeprecatedFunction( "player:SetPosition( position )" )
	local player = this.GetPlayer()
	player:SetPosition( position )
end


this.GetRotation = function()
	TppCommon.DeprecatedFunction( "player:GetRotation()" )
	local player = this.GetPlayer()
	return player:GetRotation()
end


this.SetRotation = function( rotation )
	TppCommon.DeprecatedFunction( "player:SetRotation( rotation )" )
	local player = this.GetPlayer()
	player:SetRotation( rotation )
end


this.Warp = function( warpLocator )
	local pos = TppData.GetPosition( warpLocator )
	local rot = TppData.GetRotation( warpLocator )
	this.SetPosition( pos )
	this.SetRotation( rot )
	TppPlayerUtility.SetCameraToPlayerDirection()
end


this.SetFormVariation = function( fovaKey )
	return TppCharacterUtility.ChangeFormVariationWithCharacterId( "player", fovaKey, 0 )
end


this.EnableAbility = function( abilityName )
	TppCommon.DeprecatedFunction( "TppPlayerUtility.ResetDisableActionsWithName( name )" )
	
	local disabledName = "DisabledPlayer_" .. abilityName
	TppPlayerUtility.ResetDisableActionsWithName( disabledName )
end


this.DisableAbility = function( abilityName )
	TppCommon.DeprecatedFunction( "TppPlayerUtility.SetDisableActionsWithName{ name = name, disableActions = { abilityName } }" )
	
	local disabledName = "DisabledPlayer_" .. abilityName
	TppPlayerUtility.SetDisableActionsWithName{ name = disabledName, disableActions = { this.DisableAbilityList[abilityName] } }
end


this.EnableControlMode = function( controlMode )
	TppCommon.DeprecatedFunction( "TppPadOperatorUtility.SetMasksForPlayer( 0, controlMode )" )
	if( this._IsControlModeValid( controlMode ) == false ) then return end
	TppPadOperatorUtility.SetMasksForPlayer( 0, this.ControlModeList[controlMode] )
end


this.DisableControlMode = function( controlMode )
	TppCommon.DeprecatedFunction( "TppPadOperatorUtility.ResetMasksForPlayer( 0, controlMode )" )
	if( this._IsControlModeValid( controlMode ) == false ) then return end
	TppPadOperatorUtility.ResetMasksForPlayer( 0, this.ControlModeList[controlMode] )
end


this.SetWeapons = function( weapons )
	TppCommon.DeprecatedFunction( "TppPlayerUtility.SetWeaponIdsOnStartMission( weapons )" )
	if( type( weapons ) ~= "table" ) then



		return
	end

	TppPlayerUtility.SetWeaponIdsOnStartMission( weapons )
end


this.AddWeapons = function( weapons )
	if( type( weapons ) ~= "table" ) then



		return
	end

	for i = 1, #weapons do
		local weaponID = weapons[i]
		TppPlayerUtility.AddWeaponIdOnStartMissionLua( weaponID )
	end
end


this.SetDefaultFacialMotion = function( facialMotionName )
	TppPlayerUtility.SetDefaultFacialMotion( facialMotionName )
end


this.WarpForDebugStartInVipRestorePoint = function( manager, characterID, warpLocatorKey )
	if manager:IsStartingFromResearvedForDebug() then
		TppCharacterUtility.WarpCharacterIdFromIdentifier( characterID, "id_vipRestorePoint", warpLocatorKey )
	end
end





this._IsStartStatusValid = function( startStatus )
	if( this.StartStatusList[startStatus] == nil ) then



		return false
	end
	return true
end

this._IsAbilityNameValid = function( abilityName )
	if( this.DisableAbilityList[abilityName] == nil ) then



		return false
	end
	return true
end

this._IsControlModeValid = function( controlMode )
	if( this.ControlModeList[controlMode] == nil ) then



		return false
	end
	return true
end




return this
