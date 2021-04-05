










TppTrapExecVolginSetParams = {



AddParam = function( condition )
	
	
	condition:AddConditionParam( "bool", "isInvincible" )
	condition:AddConditionParam( "bool", "enableEye" )
	condition:AddConditionParam( "bool", "enableEar" )
	condition:AddConditionParam( "bool", "enableCloseAttack" )
	condition:AddConditionParam( "bool", "enableGameOverAttack" )
	condition:AddConditionParam( "bool", "enableChargeAttack" )
	condition:AddConditionParam( "bool", "enableWarpAttack" )
	condition:AddConditionParam( "bool", "enableSearchAttack" )
	condition:AddConditionParam( "bool", "enableShootAttack" )
	condition:AddConditionParam( "bool", "enableSpearAttack" )
	condition:AddConditionParam( "bool", "enableGhostAttack" )	
end,




Exec = function( info )
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		local volgin = Ch.FindCharacters( "Volgin" )
		if #volgin.array ~= 0 then
			local p = volgin.array[1]:GetParams()
			p.isInvincible = info.conditionHandle.isInvincible
			p.enableEye = info.conditionHandle.enableEye
			p.enableEar = info.conditionHandle.enableEar
			p.enableCloseAttack = info.conditionHandle.enableCloseAttack
			p.enableGameOverAttack = info.conditionHandle.enableGameOverAttack
			p.enableChargeAttack = info.conditionHandle.enableChargeAttack
			p.enableWarpAttack = info.conditionHandle.enableWarpAttack
			p.enableSearchAttack = info.conditionHandle.enableSearchAttack
			p.enableShootAttack = info.conditionHandle.enableShootAttack
			p.enableSpearAttack = info.conditionHandle.enableSpearAttack
			p.enableGhostAttack = info.conditionHandle.enableGhostAttack
		else
			Fox.Warning( "Attempted to set Volgin's params, but Volgin character does not exist!" )
		end
	end
	return 1
end,

}