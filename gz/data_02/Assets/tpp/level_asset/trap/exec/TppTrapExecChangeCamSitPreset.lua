TppTrapExecChangeCamSitPreset = {


Exec = function( info )

	
	if info.trapFlagString == "GEO_TRAP_S_ENTER"  then
		local chara = info.moverHandle

		
		TppCameraUtility.SetCameraSituationPresetName( chara, info.conditionHandle.ChangeCameraSituationPreset_name )

		
		info.conditionBodyHandle.isDone = true

		local funcName = info.conditionHandle.ChangeCameraSituationPreset_enterFuncName
		
		if funcName == "gntn_000" then
			TppTrapExecChangeCamSitPreset.enter_gntn_000()
		elseif funcName == "gntn_001" then
			TppTrapExecChangeCamSitPreset.enter_gntn_001()
		elseif funcName == "" then
			
		else



		end
		
	
	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then



		local chara = info.moverHandle
		
		TppCameraUtility.ResetCameraSituationPresetName( chara, info.conditionHandle.ChangeCameraSituationPreset_name )
		
		local funcName = info.conditionHandle.ChangeCameraSituationPreset_leaveFuncName
		
		if funcName == "gntn_000" then
			TppTrapExecChangeCamSitPreset.leave_gntn_000()
		elseif funcName == "gntn_001" then
			TppTrapExecChangeCamSitPreset.leave_gntn_001()
		elseif funcName == "" then
			
		else



		end
		
	end
	
	return 1
	
end,


AddParam = function( condition )

	
	condition:AddConditionParam( 'String', "ChangeCameraSituationPreset_name" )
	condition:AddConditionParam( 'String', "ChangeCameraSituationPreset_enterFuncName" )
	condition:AddConditionParam( 'String', "ChangeCameraSituationPreset_leaveFuncName" )

end,


AddParamBody = function( conditionBody )

	
	conditionBody:AddProperty( 'bool', "isIn" )
	conditionBody.isIn = false

	
	conditionBody:AddProperty( 'String', "ChangeCameraSituationPreset_prevName" )
	conditionBody.ChangeCameraSituationPreset_prevName = ""

end,


enter_gntn_000 = function()
	TppPlayerUtility.RequestToSetCameraParamInterp{
	enableCamera = { 0 },				
		param = {
			{	
			paramType	= 0,			
			interpTime	= 0.5,			
			interpType	= 1,			
			interpMode	= 2,			
			},
			{	
			paramType	= 1,
			interpTime	= 0.5,
			interpType	= 1,
			interpMode	= 2,
			},
			{	
			paramType	= 2,
			interpTime	= 0.5,
			interpType	= 1,
			interpMode	= 2,
			},
		},
	}
end,
leave_gntn_000 = function()
	TppPlayerUtility.RequestToSetCameraParamInterp{
	enableCamera = { 0 },				
		param = {
			{	
			paramType	= 0,			
			interpTime	= 1.0,			
			interpType	= 1,			
			interpMode	= 2,			
			},
			{	
			paramType	= 1,
			interpTime	= 1.0,
			interpType	= 1,
			interpMode	= 2,
			},
			{	
			paramType	= 2,
			interpTime	= 1.0,
			interpType	= 1,
			interpMode	= 2,
			},
		},
	}
end,


enter_gntn_001 = function()
	TppPlayerUtility.RequestToSetCameraParamInterp{
	enableCamera = { 0 },				
		param = {
			{	
			paramType	= 0,			
			interpTime	= 0.5,			
			interpType	= 1,			
			interpMode	= 2,			
			},
			{	
			paramType	= 1,
			interpTime	= 0.5,
			interpType	= 1,
			interpMode	= 2,
			},
			{	
			paramType	= 2,
			interpTime	= 0.5,
			interpType	= 1,
			interpMode	= 2,
			},
		},
	}
end,
leave_gntn_001 = function()
	TppPlayerUtility.RequestToSetCameraParamInterp{
	enableCamera = { 0 },				
		param = {
			{	
			paramType	= 0,			
			interpTime	= 1.0,			
			interpType	= 1,			
			interpMode	= 2,			
			},
			{	
			paramType	= 1,
			interpTime	= 1.0,
			interpType	= 1,
			interpMode	= 2,
			},
			{	
			paramType	= 2,
			interpTime	= 1.0,
			interpType	= 1,
			interpMode	= 2,
			},
		},
	}
end,

}
