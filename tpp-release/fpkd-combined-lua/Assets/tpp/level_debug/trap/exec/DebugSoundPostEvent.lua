






DebugSoundPostEvent = {


Exec = function( info )
	
	if info.conditionHandle.isOutPlay == true then
	
		
		if info.trapFlagString == "GEO_TRAP_S_OUT" then
		
			
			SoundCommand.PostEvent( info.conditionHandle.playSoundLabel )
			
			
			info.conditionBodyHandle.isDone = true
		
		end
		
	else
		
		
		if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
			
			SoundCommand.PostEvent( info.conditionHandle.playSoundLabel )
			
			
			info.conditionBodyHandle.isDone = true
		
		end
		
	end
	
	return 1
	
end,



AddParam = function( condition )
	
	
	condition:AddConditionParam( 'bool', "isOutPlay" )
	
	
	condition:AddConditionParam( 'String', "playSoundLabel" ) 
	
end,

}


