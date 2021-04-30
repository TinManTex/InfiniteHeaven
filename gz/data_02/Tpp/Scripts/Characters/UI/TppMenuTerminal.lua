


TppMenuTerminal = {





__Update = function( chara , plugin )

	
	
	
	
	if Pad.GetButtonPress( 0, "MB_DEVICE" ) then
		if plugin:IsVisible() then
			plugin:Stop()
		else
			plugin:Start()
		end
	end

end,

}