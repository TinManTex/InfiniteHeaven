local this = {}


this.AddParam = function( condition )
	condition:AddConditionParam( "String", "cameraPresetName" )
end


this.AddParamBody = function( conditionBody )
	conditionBody:AddProperty( "String", "prevCameraPresetName" )
	conditionBody.prevCameraPresetName = ""
end


this.Exec = function( info )
	local chara = info.moverHandle
	
	
	if( info.trapFlagString == "GEO_TRAP_S_ENTER" ) then
		info.conditionBodyHandle.prevCameraPresetName = TppCameraUtility.GetCameraSituationPresetName( chara )
		TppCameraUtility.SetCameraSituationPresetName( chara, info.conditionHandle.cameraPresetName )
	
	
	elseif( info.trapFlagString == "GEO_TRAP_S_OUT" ) then
		TppCameraUtility.SetCameraSituationPresetName( chara, info.conditionBodyHandle.prevCameraPresetName )
	end
end

return this