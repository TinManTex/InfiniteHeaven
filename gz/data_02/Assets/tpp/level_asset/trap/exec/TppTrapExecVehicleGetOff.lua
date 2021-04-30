



TppTrapExecVehicleGetOff = {


Exec = function ( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		
		local charaLocatorData = info.conditionHandle.enemyLocator
		local charaLocator = charaLocatorData:GetDataBodyWithReferrer( info.trapBodyHandle )
                local charaObject = charaLocator:GetCharacterObject()
                local chara = charaObject:GetCharacter()
          
		if not Entity.IsNull( charaLocator ) then
                  local request = TppNpcGetOffAndRouteChangeRequest( info.conditionHandle.nextRouteId, info.conditionHandle.nextRoutePoint )
                  chara:SendMessage( request )
		end
		
		
		info.conditionBodyHandle.isDone = true
	end
	
	return 1

end,



AddParam = function ( condition )

	
        if condition:AddConditionParam( 'EntityLink', "enemyLocator" ) == true then
		condition.enemyLocator = nil
	end
	
	
	if condition:AddConditionParam( 'EntityLink', "nextRoute" ) == true then
		condition.nextRoute = nil
	end

	
	if condition:AddConditionParam( 'String', "nextRouteId" ) == true then
		condition.nextRouteId = ""
	end

	
	if condition:AddConditionParam( 'uint32', "nextRoutePoint" ) == true then
		condition.nextRoutePoint = 0
	end
end,

}

