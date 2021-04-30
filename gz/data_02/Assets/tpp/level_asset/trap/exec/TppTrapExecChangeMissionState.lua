TppTrapExecChangeMissionState = {

Exec = function( info )
	if ( info.conditionHandle.enable == false ) then
		return 1
	end

	if ( info.trapFlagString == "GEO_TRAP_S_ENTER" and info.conditionBodyHandle.isIn == false ) then
		local missionManager = TppMissionManager:GetInstance()
		
		if ( Entity.IsNull( missionManager ) ) then



			return 1
		end
		if ( missionManager:IsMainMissionDefault() == false ) then



			return 1
		end

		info.conditionBodyHandle.isIn = true

		if ( info.conditionHandle.enableFlag == true ) then



			missionManager:SendMainMissionChangeRequest( info.conditionHandle.missionName )
		else
			



			missionManager:ReleaseMainMission()
		end
	end
	
end,

AddParam = function( condition )
	
	condition:AddConditionParam( 'bool', "enable" )
	condition.enable = true
	
	
	condition:AddConditionParam( 'bool', "onlyFirstTime" )
	condition.onlyFirstTime = true		
	
	condition:AddConditionParam( 'String', "missionName" )
	condition:AddConditionParam( 'bool', "enableFlag" )
	condition.enableFlag = true

end,

AddParamBody = function( conditionBody )
	conditionBody:AddProperty( 'bool', "isIn" )
	conditionBody.isIn = false
end,

}
