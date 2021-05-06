TrapCheckpointSample = {


AddParam = function( condition )

	
	
	

	Fox.Log( "Set checkpoint information" )

	
	condition:AddConditionParam( 'String', "checkpointName" )
	condition.checkpointName = "LATEST_CHECKPOINT"
	
	
	condition:AddConditionParam( 'Vector3', "restartPosition" )
	condition.restartPosition = Vector3{ 0, 1, 0 }
	
	
	condition:AddConditionParam( 'Quat', "restartRotation" )
	condition.restartRotation = Quat( 0, 0, 0, 1 )
end,



OnStorage = function( param, data )

	
	
	

	Fox.Log( "OnStorage" )

	
	
	local players = Ch.FindCharacters( "Player" )
	if #players.array > 0 then
		local plgLife = players.array[1]:FindPlugin( "ChLifePlugin" )
		local lifeValue = plgLife:GetValue( "Life" )
		if( lifeValue ~= nil ) then
			data:AddProperty( 'int32', "playerLife" )
			data.playerLife = lifeValue:Get()
		end
	end
	
end,



OnRestoration = function( param, data )

	
	
	

	Fox.Log( "OnRestoration" )

	
	local players = Ch.FindCharacters( "Player" )
	if players.array[1] then
	
		
		
		local plgLife = players.array[1]:FindPlugin( "ChLifePlugin" )
		local lifeValue = plgLife:GetValue( "Life" )
		if( lifeValue ~= nil ) then
			if( data.playerLife ~= nil ) then
				lifeValue:Set( data.playerLife )
			else
				
				lifeValue:Set( lifeValue:GetMax() )
			end
		end
		
		
		if( param.restartPosition ~= nil ) then
			players.array[1]:SetPosition( param.restartPosition )
		else
			Fox.Log( "restartPosition is nil" )
		end
		
		if( param.restartRotation ~= nil ) then
			players.array[1]:SetRotation( param.restartRotation )
		else
			Fox.Log( "restartRotation is nil" )
		end
	end

end,

}
