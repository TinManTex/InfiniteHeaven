ActionTppPlayerRideVehicleBase = {


WakeUpStates = {

},




OnWakeUp = function( plugin )
	local chara = plugin:GetCharacter()
	if Entity.IsNull( chara ) then Ch.Log( chara, "plugin:GetCharacter() failed" ) return end
	
	
	

	
	plugin:SetUseCutInCamera( true )
	plugin:SetCutInCameraConnectPointName( "CNP_ppos_b" )
	plugin:SetCutInCameraCameraAngle( -2.5, 182 )	
	plugin:SetCutInCameraTimeToSleep( 2.2 )	
	plugin:SetCutInCameraPosition( Vector3( -0.1, 0.5, 4.0 ) )
	local cutInCamera = chara:FindPlugin( "TppCutInCameraPlugin" )
	if not Entity.IsNull( cutInCamera ) then
		cutInCamera:SetFocalLength( 26 )
		cutInCamera:SetFocusDistance( 5.5 )
		cutInCamera:SetAperture( 1.875 )
	end
	
	









	
	







end,






















































}
