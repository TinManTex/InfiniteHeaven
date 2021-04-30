




BodyTppHostage = {




OnRealize = function( plugin )

	local chara = plugin:GetCharacter()
	local charaObj = chara:GetCharacterObject()

	if charaObj.kind == 3 then 
		local plgAction = chara:FindPlugin( "TppNpcRideVehicleActionPlugin" )
		if not Entity.IsNull( plgAction ) then
			local layerName = plgAction:GetLayerName()
			plugin:BindBlendTreeControlValue( layerName, "shakeMotionSelect", plgAction, "shakeMotionIndex" )
		end
	end
end,




OnUnrealize = function( plugin )
	local chara = plugin:GetCharacter()
	local charaObj = chara:GetCharacterObject()

	if charaObj.kind == 3 then 
		local plgAction = chara:FindPlugin( "TppNpcRideVehicleActionPlugin" )
		if not Entity.IsNull( plgAction ) then
			local layerName = plgAction:GetLayerName()
			plugin:UnbindBlendTreeControlValue( layerName, "shakeMotionSelect" )
		end
	end
end,

}
