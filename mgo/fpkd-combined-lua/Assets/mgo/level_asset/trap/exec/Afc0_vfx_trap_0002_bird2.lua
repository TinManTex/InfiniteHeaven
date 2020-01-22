Afc0_vfx_trap_0002_bird2 = {

Exec = function( info )
    if( info.trapFlagString == "GEO_TRAP_S_ENTER" ) then 
 
        TppDataUtility.CreateEffectFromId("bird2")
     
    elseif( info.trapFlagString == "GEO_TRAP_S_OUT" ) then   
 
        TppDataUtility.DestroyEffectFromId("bird2")

    end
     
    return 1
     
end,
AddParam = function( condition )
     
end,
}