TppTrapExecCheckPoint = {


Exec = function( info )



	
	
	if( Checkpoint.IsBusy() == true ) then



		return 0
	end
	
	
	
	
	
	local param = CheckpointData()
	if param == nil then



		return 0
	end
	
	
	local checkpointTag = "LATEST_CHECKPOINT"
	if( info.conditionHandle.checkpointName == nil ) then



	else



		checkpointTag = info.conditionHandle.checkpointName
		
		if( Checkpoint.IsPassedCheckpoint( checkpointTag ) == true ) then



			return 0
		end
		
		param:AddProperty( 'String', "checkpointTag" )
		param.checkpointTag = checkpointTag
	end




























	
	if ( Entity.IsNull(info.conditionHandle.restartLocater) ) then



	else
		local locater = info.conditionHandle.restartLocater
		param:AddProperty('Vector3', "restartPosition")
		param:AddProperty('Quat', "restartRotation" )

		local matrix = locater.worldMatrix;
		param.restartPosition = matrix:GetTranslation()
		
		param.restartRotation = locater.transform.rotQuat 




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
