








TppTrapExecIntrude = {


Exec = function( info )
	

	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		

		local chara = info.moverHandle
		local playerInternalWork = chara:FindPlugin( "TppPlayerInternalWorkPlugin" )

		if not Entity.IsNull( playerInternalWork ) then
			
			
			playerInternalWork.intrudeState:Set( "Enter" )
			
		end

	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then
		

		local chara = info.moverHandle
		local playerInternalWork = chara:FindPlugin( "TppPlayerInternalWorkPlugin" )

		if not Entity.IsNull( playerInternalWork ) then
			
			
			
			playerInternalWork.intrudeState:Set( "Out" )
			
		end

	end
	return 1
end,

}
