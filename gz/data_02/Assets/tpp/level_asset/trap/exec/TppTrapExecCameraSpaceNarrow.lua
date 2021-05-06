








TppTrapExecCameraSpaceNarrow = {


Exec = function( info )


	if info.trapFlagString == "GEO_TRAP_S_ENTER" then



	elseif info.trapFlagString == "GEO_TRAP_S_INSIDE" then


		local chara = info.moverHandle
		local playerInternalWork = chara:FindPlugin( "TppPlayerInternalWorkPlugin" )

		if not Entity.IsNull( playerInternalWork ) then
			playerInternalWork.spaceState:Set( "Narrow" )

		end

	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then


		local chara = info.moverHandle
		local playerInternalWork = chara:FindPlugin( "TppPlayerInternalWorkPlugin" )

		if not Entity.IsNull( playerInternalWork ) then
			playerInternalWork.spaceState:Reset( "Narrow" )

		end


	end
	return 1
end,

}
