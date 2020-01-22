Afc0_vfx_trap_0001_bird1 = {

Exec = function( info )
    if( info.trapFlagString == "GEO_TRAP_S_ENTER" ) then 
 
        TppDataUtility.CreateEffectFromId("bird1")
     
    elseif( info.trapFlagString == "GEO_TRAP_S_OUT" ) then   
 
        TppDataUtility.DestroyEffectFromId("bird1")

    end
     
    return 1
     
end,
AddParam = function( condition )
     
end,
}