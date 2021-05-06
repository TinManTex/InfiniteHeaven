



ActionTppSoldierTurret = {



WakeUpStates = {
	"stateTurretIdle",
},


GetTurret = function( plugin )

	local character = plugin:GetCharacter()
	local characterPosition = character:GetPosition()
	local searchRadius = 10.0
	
	local objects = Ch.FindCharacterObjectsSphere{ center = characterPosition, radius = searchRadius, tags = { "Character", "Gadget"} }
	
	for i, object in ipairs( objects.array ) do
		
		if object.isEnabled then
			if object:IsKindOf( TppEmplacementObject ) then
				if object:IsGunEmplacement() then
				
					local characterObject = character:GetCharacterObject()
					local turretOwner = object:GetOwner()
					if turretOwner ~= nil then
						
						if object:IsOccupied() and turretOwner ~= character then
							break
						end
					end
					
					
					if object:IsReserved() and not object:CheckReserved( character ) then
						break
					end
					
					
					local turret = object:GetCharacter()
					local plgGadgetAction = turret:FindPluginByName("AttackEmplacementAction")
					if plgGadgetAction == nil then
						break
					else
						local pos = TppEnemyUtility.GetNearestLastPosition(character)
						local isPosIn = plgGadgetAction:IsPosInAimRange(pos)
						if isPosIn ~= true then
							break
						end
					end
					
					return object
				end
			end
		end
	end

	return Entity.Null()

end,

}
