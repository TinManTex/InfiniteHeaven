TrapCheckpointCheckSample = {


Check = function( info )

	
	for key, value in pairs( info.moverTags ) do
		if key == "PlayerLocator" or key == "AiPlayerLocatorData0000" then

			
		    if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		    	return 0
		    end

			
			if( Checkpoint.IsBusy() == true ) then
				
				return 0
			end

			
			local checkpointTag = ""
			if( info.conditionHandle.checkpointName == nil ) then
				Fox.Log( "checkpointName is nil" )
				checkpointTag = "LATEST_CHECKPOINT"
			else
				
				checkpointTag = info.conditionHandle.checkpointName
				
				if( Checkpoint.IsPassedCheckpoint( checkpointTag ) == true ) then
					
					return 0
				end
			end

			Fox.Log("Check OK")

			return 1
		end
	end

	return 0

end,
}
