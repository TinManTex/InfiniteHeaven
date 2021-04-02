







Debug2DPrint = {




AddParam = function( condition )
	
	
	local oneSecond = 60
	
	
	condition:AddConditionParam( 'bool', "onlyShowWhenInTrap" )
	condition.onlyShowWhenInTrap = false
	
	
	condition:AddConditionParam( 'String', "text" )
	condition.text = ""
	
	
	condition:AddConditionParam( 'uint32', "textLife" )
	condition.textLife = oneSecond * 5
	
	
	condition:AddConditionParam( 'uint32', "textPosX" )
	condition.textPosX = 50
	
	
	condition:AddConditionParam( 'uint32', "textPosY" )
	condition.textPosY = 150
	
	
	condition:AddConditionParam( 'float', "textSize" )
	condition.textSize = 20
	
	
	condition:AddConditionParam( 'Color', "textColor" )
	condition.textColor = Color{ 1.0, 1.0, 1.0, 1.0 }
	
end,




Exec = function( info )

	local function displayText( textLife )
		
		local textData = string.gsub( info.conditionHandle.text, "\\n", "\n" )
		
		
		GrxDebug.Print2D {
			life	= textLife,
			x		= info.conditionHandle.textPosX,
			y		= info.conditionHandle.textPosY,
			size	= info.conditionHandle.textSize,
			color	= info.conditionHandle.textColor,
			args	= { textData }
		}
	end

	
	if( info.conditionHandle.onlyShowWhenInTrap == true ) then
		if( info.trapFlagString == "GEO_TRAP_S_INSIDE" ) then
			displayText( 1 )
		end
	elseif( info.trapFlagString == "GEO_TRAP_S_ENTER" ) then
		displayText( info.conditionHandle.textLife )
		
		
		info.conditionBodyHandle.isDone = true
	end
	
	return 1
end,

}