







TppTrapExecDisableTrap = {


Exec = function( info )

	
	if info.trapFlagString ~= "GEO_TRAP_S_OUT" then
		return 1
	end





	




	
	info.trapBodyHandle.enable = false

	return 1
end,

}

