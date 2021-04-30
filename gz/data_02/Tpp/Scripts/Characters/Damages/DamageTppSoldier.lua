DamageTppSoldier = {


AddKnowledgeAlertPhaseOnly = function( chara, damage )

	local plgPhase = chara:FindPlugin( "AiPhasePlugin" )
	if not Entity.IsNull( plgPhase ) then
		if plgPhase:GetCurrentPhaseName()=="Alert" then

		    local plgKnow = chara:FindPluginByName( "Knowledge" )
			if not Entity.IsNull( plgKnow ) then

				
				local attackerChara = TppEnemyDamageUtility.GetAttackCharacterOfDamage( damage )
				if not Entity.IsNull( attackerChara ) then

					
					plgKnow:AddKnowledgeEvent( AiCharacterKnowledgeEvent.Create( attackerChara ) )
				end
			end
		end
	end
end,

}
