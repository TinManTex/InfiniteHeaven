TrapCheckpointExecSample = {


Exec = function( info )
	
	Fox.Log( "Checkpoint Trap Exec" )
	
	
	if( Checkpoint.IsBusy() == true ) then
		Fox.Log( "Busy" )
		return 0
	end
	
	
	
	
	
	local param = CheckpointData()
	if param == nil then
		Fox.Log( "Checkpoint parameter is nil" )
		return 0
	end
	
	
	local checkpointTag = "LATEST_CHECKPOINT"
	if( info.conditionHandle.checkpointName == nil ) then
		Fox.Log( "checkpointName is nil" )
	else
		Fox.Log( "Checkpoint " .. info.conditionHandle.checkpointName )
		checkpointTag = info.conditionHandle.checkpointName
		
		if( Checkpoint.IsPassedCheckpoint( checkpointTag ) == true ) then
			Fox.Log( "Already Passed " .. checkpointTag )
			return 0
		end
		
		param:AddProperty( 'String', "checkpointTag" )
		param.checkpointTag = checkpointTag
	end
	
	
	local restartPosition = Vector3{ 0, 0, 0 }
	if( info.conditionHandle.restartPosition == nil ) then
		Fox.Log( "restartPosition is nil" )
	else
		restartPosition = info.conditionHandle.restartPosition
		
		param:AddProperty( 'Vector3', "restartPosition" )
		param.restartPosition = restartPosition
	end
	
	
	local restartRotation = Quat( 0, 0, 0, 1 )
	if( info.conditionHandle.restartRotation == nil ) then
		Fox.Log( "restartRotation is nil" )
	else
		restartRotation = info.conditionHandle.restartRotation
		
		param:AddProperty( 'Quat', "restartRotation" )
		param.restartRotation = restartRotation
	end
	
	
	
	
	
	local ret = Checkpoint.PostCheckpointCreation {
		tag = checkpointTag,
		parameter = param,
		replace = true,
	}
	
	
	GrxDebug.Print2D {
		life = 100,
		size = 30,
		x=50, y=600,
		color=Color(1,1,1, 1),
		args={ "チェックポイント" }
	}
	
    return 1

end,

}
