local this = {}






this.OpenDoor = function( doorID, openAngle )
	local params = {
		id = doorID,
		isVisible = true,
		isOpen = true,
		isEnableBounder = false,
		angle = openAngle,
	}
	TppGadgetUtility.SetDoor( params )
end


this.CloseDoor = function( doorID )
	local params = {
		id = doorID,
		isVisible = true,
		isOpen = false,
		isEnableBounder = true,
		angle = 0,
	}
	TppGadgetUtility.SetDoor( params )
end




return this