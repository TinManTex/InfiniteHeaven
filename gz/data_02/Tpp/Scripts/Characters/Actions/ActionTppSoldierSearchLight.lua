



ActionTppSoldierSearchLight = {



WakeUpStates = {
	"stateSearchLightIdle",
},


GetSearchLight = function( plugin )

	local character = plugin:GetCharacter()
	local characterPosition = character:GetPosition()
	local searchRadius = 10.0
	local objects = Ch.FindCharacterObjectsSphere{ center = characterPosition, radius = searchRadius, tags = { "Gadget" } }

	for i, object in ipairs( objects.array ) do
		
		
		if object.isEnabled then

			if object:IsKindOf( TppEmplacementObject ) then

				return object
			end
		end
	end

	return Entity.Null()

end,

}
