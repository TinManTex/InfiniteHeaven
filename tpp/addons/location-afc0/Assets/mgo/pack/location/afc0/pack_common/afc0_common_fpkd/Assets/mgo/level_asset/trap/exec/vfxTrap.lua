



vfxTrap = {

BeforeRecursively = function( tag )
    	
    local data = nil
	
	if not Entity.IsNull( tag ) then
		TppDataUtility.CreateEffectFromId( tag )
		
	end
	
end,

AfterRecursively = function( tag )
    	
    local data = nil
	
	if not Entity.IsNull( tag ) then
		TppDataUtility.DestroyEffectFromId( tag )	
		
	end
	
end,

Exec = function( info )
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		vfxTrap.BeforeRecursively( info.conditionHandle.vfxInstanceName, info.trapBodyHandle)
		
	end
		
	if info.trapFlagString == "GEO_TRAP_S_OUT" then
		
		vfxTrap.AfterRecursively( info.conditionHandle.vfxInstanceName, info.trapBodyHandle)
			
	end
	
	return 1

end,









}

