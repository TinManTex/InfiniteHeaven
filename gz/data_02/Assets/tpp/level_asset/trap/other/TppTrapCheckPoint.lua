TppTrapCheckPoint = {


AddParam = function( condition )

	
	
	





	
	condition:AddConditionParam( 'String', "checkpointName" )
	condition.checkpointName = "LATEST_CHECKPOINT"









	condition:AddConditionParam( 'EntityPtr', "restartLocater" )
	condition.restartLocater = NULL
end,



OnStorage = function( param, data )

	
	
	





	
	
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



		end
		
		if( param.restartRotation ~= nil ) then
			
			local bodyPlugin = players.array[1]:FindPlugin("ChBodyPlugin")
			bodyPlugin:SetControlTurn(param.restartRotation)
			bodyPlugin:SetControlRotation(param.restartRotation)
		else



		end
	end

	
	
	local phaseManager = TppSystemUtility.GetPhaseController()
	if phaseManager ~= NULL then
		
		local cpControllers = phaseManager:GetSubPhaseControllers()
		if cpControllers ~= nil then
			for i, cpController in ipairs( cpControllers ) do
				
				local cpDefPhase = cpController:GetDefaultPhaseName()
				cpController:SetCurrentPhaseByName( cpDefPhase )

				
				local charaControllers = cpController:GetSubPhaseControllers()
				if charaControllers ~= nil then
					for j, charaController in ipairs( charaControllers ) do
						
						local charaDefPhase = charaController:GetDefaultPhaseName()
						charaController:SetCurrentPhaseByName( charaDefPhase )
					end
				end
			end
		end
	end

	
	local commandPosts = Ch.FindCharacters( "CommandPost" )
	for i, cp in ipairs( commandPosts.array ) do
		local members = cp:GetMembers()
		if #members.array > 0 then
			for j, member in ipairs( members.array ) do
				local desc = member:GetCharacterDesc()
				if desc:IsKindOf( TppSquadDesc ) then
					local squadMembers = member:GetMembers()
					if #squadMembers.array > 0 then
						for k, squadMember in ipairs( squadMembers.array ) do
							local charaDesc = squadMember:GetCharacterDesc()
							if charaDesc:IsKindOf( TppHumanEnemyDesc ) or charaDesc:IsKindOf( TppProtoEnemyStrykerDesc ) then
								local message = NULL
								if MgsRemoveSpreadMessage ~= nil then
									message = MgsRemoveSpreadMessage( charaDesc )
								else
									message = TppRemoveSpreadMessage( charaDesc )
								end
								if not Entity.IsNull( message ) then
									
									cp:SendMessage( message )
								end
							end
							
							local plgKnow = squadMember:FindPlugin( "AiKnowledgePlugin" )
							if plgKnow ~= NULL then
								plgKnow:RemoveAllKnowledge()
								plgKnow:RemoveAllKnowledgePoints()
							end
						end
					end
				elseif desc:IsKindOf( TppHumanEnemyDesc ) then
					local message = NULL
					if MgsRemoveSpreadMessage ~= nil then
						message = MgsRemoveSpreadMessage( desc )
					else
						message = TppRemoveSpreadMessage( desc )
					end
					
					if not Entity.IsNull( message ) then
						
						cp:SendMessage( message )
					end
				end
				
				local plgKnow = member:FindPlugin( "AiKnowledgePlugin" )
				if plgKnow ~= NULL then
					plgKnow:RemoveAllKnowledge()
					plgKnow:RemoveAllKnowledgePoints()
				end
			end
		end
		
		local plgKnow = cp:FindPlugin( "AiKnowledgePlugin" )
		if plgKnow ~= NULL then
			plgKnow:RemoveAllKnowledge()
			plgKnow:RemoveAllKnowledgePoints()
		end
	end

end,

}
