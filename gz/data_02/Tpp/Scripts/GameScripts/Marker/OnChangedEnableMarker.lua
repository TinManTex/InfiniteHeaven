
OnChangedEnableMarker = {






events = {
	markedLocator = { OnChangedEnable="OnChangedEnable" },
},


AddDynamicPropertiesToData = function( data, body )
	
	if data.variables.markedLocator == NULL then
		data.variables.markedLocator = nil
	end
	
	
	data:AddProperty( "String", "text", 1 )
	data.text = ""
	
	
	data:AddProperty( "uint32", "textLife", 1 )
	data.textLife = 60 * 5
	
	
	data:AddProperty( "uint32", "textPosX", 1 )
	data.textPosX = 100
	
	
	data:AddProperty( "uint32", "textPosY", 1 )
	data.textPosY = 320
	
	
	data:AddProperty( "float", "textSize", 1 )
	data.textSize = 60
	
	
	data:AddProperty( "Color", "textColor" )
	data.textColor = Color{ 1.0, 1.0, 1.0, 1.0 }
	
	
	data:AddProperty( "String", "playSoundLabel" )
	data.playSoundLabel = ""
end,


Init = function( data, body )

	

end,


SetMessageBoxes = function( data, body )

	

end,


Restore = function( data, body )

	

end,




OnChangedEnable = function( data, body, sender, id, arg1, arg2, arg3, arg4 )
	local textData = string.gsub( data.text, "\\n", "\n" )
	
	
	GrxDebug.Print2D {	
		life = 	data.textLife,
		x = 	data.textPosX,
		y = 	data.textPosY,
		size = 	data.textSize,
		color = data.textColor,
		args = 	{ textData }
	}
	
	
	SoundCommand.PostEvent( data.playSoundLabel )
end,


}
