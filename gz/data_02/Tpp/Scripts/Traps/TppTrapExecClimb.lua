








TppTrapExecClimb = {


Exec = function( info )
	

	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		

		local chara = info.moverHandle
		local plgClimb = chara:FindPlugin( "TppClimbActionPlugin" )

		if not Entity.IsNull( plgClimb ) then
			
			plgClimb:SendActionRequest( TppClimbStartRequest(0) )
		end

	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then
		

		local chara = info.moverHandle
		local plgClimb = chara:FindPlugin( "TppClimbActionPlugin" )

		if not Entity.IsNull( plgClimb ) then
			
			plgClimb:SendActionRequest( TppClimbEndRequest(0) )
		end

	end
	return 1
end,

}
