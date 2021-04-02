




DebugChangeTppGlobalVolFog = {


ChangeParameterRecursively = function( data, ref, atmosphere, density )
    	
    local dataBody = data:GetDataBodyWithReferrer( ref )
		
	
	if dataBody:IsKindOf( TppGlobalVolumetricFogBody ) then
		
		dataBody:SetDensity( density )
	end

	




       
       local pref = Preference.GetPreferenceEntity( "EdDebugPreference" )
       Command.SetProperty{ entity=pref, property='checkEntityPropertyIsEditable', value=false }
       
       if density < 0.000001 then

              Command.SetProperty{ entity = atmosphere, property = "fogEnable", value = false }
       else

              Command.SetProperty{ entity = atmosphere, property = "fogEnable", value = true }
       end

end,



Exec = function( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		
		DebugChangeTppGlobalVolFog.ChangeParameterRecursively( info.conditionHandle.tppGlobalVolumetricFog, info.trapBodyHandle, info.conditionHandle.tppAtmosphere,
			info.conditionHandle.inDensity )

		
		local wm=TppWeatherManager:GetInstance()
		wm:RequestTag("dia_tunnel_00", 1 )

	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then

		DebugChangeTppGlobalVolFog.ChangeParameterRecursively( info.conditionHandle.tppGlobalVolumetricFog, info.trapBodyHandle, info.conditionHandle.tppAtmosphere,
			info.conditionHandle.outDensity )

		
		local wm=TppWeatherManager:GetInstance()
		wm:RequestTag("default", 1 )

	end
	
	return 1

end,



AddParam = function( condition )

	condition:AddConditionParam( 'EntityLink', "tppGlobalVolumetricFog" )
	condition.tppGlobalVolumetricFog = nil
	condition:AddConditionParam( 'EntityLink', "tppAtmosphere" )
	condition.tppAtmosphere = nil
	
	condition:AddConditionParam( 'float', "inDensity" )
	condition.inDensity = 0.0
	condition:AddConditionParam( 'float', "outDensity" )
	condition.outDensity = 0.1

end,

}

