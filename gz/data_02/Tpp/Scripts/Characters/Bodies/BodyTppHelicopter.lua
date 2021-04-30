




BodyTppHelicopter = {





__OnRealize = function( plugin )

	local chara = plugin:GetCharacter()
	
	
	local plgBasicAction = chara:FindPlugin("TppHelicopterBasicActionPlugin")
	plugin:BindBlendTreeControlValue("Full", "weight", plgBasicAction, "blendValueWeight")

end,





__OnUnrealize = function( plugin )

	plugin:UnbindBlendTreeControlValue("Full", "weight")

end,

}
