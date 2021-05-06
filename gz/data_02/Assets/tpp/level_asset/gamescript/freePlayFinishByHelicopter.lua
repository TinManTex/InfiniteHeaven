





freePlayFinishByHelicopter = {






events = {
	Heli = { CloseDoor="OnCloseDoor" },
},


AddDynamicPropertiesToData = function( data, body )

	
	if data.variables.Heli == NULL then
		data.variables.Heli = nil
	end

end,


Init = function( data, body )

end,


SetMessageBoxes = function( data, body )

end,


Restore = function( data, body )

end,





OnCloseDoor = function( data, body, sender, id, arg1, arg2, arg3, arg4 )

	
	local missionManager = TppMissionManager:GetInstance()
	
	
	
		missionManager:RequestMissionFinishOnHeli()
	

end,
}

