





TppGsCallSupportHelicopter = {






events = {
	Player = {
		NotifyStartWarningFlare="OnStartWarningFlare",
		CallRescueHeli="OnStartMotherBaseDevise"
	},
},


AddDynamicPropertiesToData = function( data, body )

	
	if data.variables.Player == NULL then
		data.variables.Player = nil
	end

end,


Init = function( data, body )

	

end,


SetMessageBoxes = function( data, body )

	
	
	
	local playerMessageBox = PlayerManager:GetManagerMessageBox()
	body:AddMessageBox( "Player", playerMessageBox )

end,


Restore = function( data, body )

	

end,





OnStartWarningFlare = function( data, body, sender, id, arg1, arg2, arg3, arg4 )
	local heliLocator = body.messageBoxes.Helicopter.owner
	TppSupportHelicopterService.CallSupportHelicopter(arg1)
	TppSupportHelicopterService.RequestAirStrike()

end,


OnStartMotherBaseDevise = function( data, body, sender, id, arg1, arg2, arg3, arg4 )

	local heliLocator = body.messageBoxes.Helicopter.owner
	TppSupportHelicopterService.CallSupportHelicopter(arg1)

end,

}

