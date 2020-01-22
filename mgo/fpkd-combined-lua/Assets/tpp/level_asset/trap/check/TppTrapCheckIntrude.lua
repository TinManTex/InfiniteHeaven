








TppTrapCheckIntrude = {



Check = function( info )
	for key, value in pairs( info.moverTags ) do
		
		
		if key == "PlayerLocator" then
			
			return 1
		end
	end
	return 0
end,
}
