Afc0_vfx_trap_0000_birds = {

Exec = function( info )
    if( info.trapFlagString == "GEO_TRAP_S_ENTER" ) then 
 
        TppDataUtility.CreateEffectFromId("birds")
     
    elseif( info.trapFlagString == "GEO_TRAP_S_OUT" ) then   
 
        TppDataUtility.DestroyEffectFromId("birds")

    end
     
    return 1
     
end,
AddParam = function( condition )
     
end,
}