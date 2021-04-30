local this = {}






this.Call = function( rvPointName )
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.CallSupportHelicopter( rvPointName )" )
	TppSupportHelicopterService.CallSupportHelicopter( rvPointName )
end


this.ChangeRVPoint = function( rvPointName )
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.RequestToChangeRendezvousPoint( rvPointName )" )
	TppSupportHelicopterService.RequestToChangeRendezvousPoint( rvPointName )
end


this.EnableAutoReturn = function()
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.EnableAutoReturn()" )
	TppSupportHelicopterService.EnableAutoReturn()
end


this.DisableAutoReturn = function()
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.DisableAutoReturn()" )
	TppSupportHelicopterService.DisableAutoReturn()
end


this.SetRoute = function( routeID, speed, options )
	options = options or {}

	local doWarp = options.doWarp or false
	local useNode = options.useNode or 0
	TppSupportHelicopterService.RequestRouteModeWithNodeIndex( routeID, useNode, doWarp, speed )
	TppSupportHelicopterService.ChangeTargetSpeed( speed, 0 )
end


this.ChangeRoute = function( routeID )
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.ChangeRoute( routeID )" )
	TppSupportHelicopterService.ChangeRoute( routeID )
end


this.SetStatus = function( statusName )
	if( statusName == "leftDoor_open" ) then
		TppCommon.DeprecatedFunction( "TppSupportHelicopterService.OpenLeftDoor()" )
		TppSupportHelicopterService.OpenLeftDoor()
	elseif( statusName == "leftDoor_close" ) then
		TppCommon.DeprecatedFunction( "TppSupportHelicopterService.CloseLeftDoor()" )
		TppSupportHelicopterService.CloseLeftDoor()
	elseif( statusName == "rightDoor_open" ) then
		TppCommon.DeprecatedFunction( "TppSupportHelicopterService.OpenRightDoor()" )
		TppSupportHelicopterService.OpenRightDoor()
	elseif( statusName == "rightDoor_close" ) then
		TppCommon.DeprecatedFunction( "TppSupportHelicopterService.CloseRightDoor()" )
		TppSupportHelicopterService.CloseRightDoor()
	elseif( statusName == "landingGear_up" ) then
		TppCommon.DeprecatedFunction( "TppSupportHelicopterService.TakeInLandingGear()" )
		TppSupportHelicopterService.TakeInLandingGear()
	elseif( statusName == "landingGear_down" ) then
		TppCommon.DeprecatedFunction( "TppSupportHelicopterService.PutDownLandingGear()" )
		TppSupportHelicopterService.PutDownLandingGear()
	else



		return
	end
end






this.EnableHelicopter = function()
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.ResetStopAndInvisible()" )
	TppSupportHelicopterService.ResetStopAndInvisible()
end


this.DisableHelicopter = function()
	TppCommon.DeprecatedFunction( "TppSupportHelicopterService.StopAndInvisible()" )
	TppSupportHelicopterService.StopAndInvisible()
end




return this
