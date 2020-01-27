






DebugChangeCameraSitPreset = {


Exec = function( info )

	
	if info.trapFlagString == "GEO_TRAP_S_ENTER"  then
		local chara = info.moverHandle

		
		info.conditionBodyHandle.DebugChangeCameraSituationPreset_prevName = TppCameraUtility.GetCameraSituationPresetName( chara )
		
		TppCameraUtility.SetCameraSituationPresetName( chara, info.conditionHandle.DebugChangeCameraSituationPreset_name )

		
		info.conditionBodyHandle.isDone = true

	
	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then
		
		local chara = info.moverHandle
		
		TppCameraUtility.SetCameraSituationPresetName( chara, info.conditionBodyHandle.DebugChangeCameraSituationPreset_prevName )
	end

	








	return 1
	
end,


AddParam = function( condition )

	
	condition:AddConditionParam( 'String', "DebugChangeCameraSituationPreset_name" )

end,


AddParamBody = function( conditionBody )

	
	conditionBody:AddProperty( 'bool', "isIn" )
	conditionBody.isIn = false

	
	conditionBody:AddProperty( 'String', "DebugChangeCameraSituationPreset_prevName" )
	conditionBody.DebugChangeCameraSituationPreset_prevName = ""

end,

}
