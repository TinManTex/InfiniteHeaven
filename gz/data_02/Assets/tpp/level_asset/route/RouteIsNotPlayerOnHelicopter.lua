





RouteIsNotPlayerOnHelicopter = {








EnableCheck = function( chara )
	
	local plgPassenger = chara:FindPlugin("TppPassengerManagePlugin")
	if not plgPassenger:IsExist("Player") then
		return true
	end
	
	return false
end,








EndCheck = function( chara )
	return true
end,

}
