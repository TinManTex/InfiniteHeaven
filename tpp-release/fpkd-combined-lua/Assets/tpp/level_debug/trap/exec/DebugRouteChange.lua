






DebugRouteChange = {


Exec = function ( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		
		local charaLocatorData = info.conditionHandle.enemyLocator
		local charaLocator = charaLocatorData:GetDataBodyWithReferrer( info.trapBodyHandle )

		if not Entity.IsNull( charaLocator ) then
			
			TppEnemyMoveUtility.ChangeSneakRoute( charaLocator, info.conditionHandle.nextRoute, info.conditionHandle.nextRoutePoint )
			TppEnemyMoveUtility.ChangeCautionRoute( charaLocator, info.conditionHandle.nextCautionRoute, info.conditionHandle.nextCautionRoutePoint )
			
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
	
	if condition:AddConditionParam( 'uint32', "nextRoutePoint" ) == true then
		condition.nextRoutePoint = 0
	end
	
	
	if condition:AddConditionParam( 'EntityLink', "nextCautionRoute" ) == true then
		condition.nextCautionRoute = nil
	end
	
	
	if condition:AddConditionParam( 'uint32', "nextCautionRoutePoint" ) == true then
		condition.nextCautionRoutePoint = 0
	end

end,

}

