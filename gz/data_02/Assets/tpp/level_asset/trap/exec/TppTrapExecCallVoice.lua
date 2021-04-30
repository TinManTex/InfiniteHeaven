



TppTrapExecCallVoice = {


Exec = function ( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		
		local chara = info.moverHandle
		chara:SendMessage( TppCallVoiceMessage(info.conditionHandle.voiceId, info.conditionHandle.isStack ) )
		
		
		info.conditionBodyHandle.isDone = true
	end
	
	return 1

end,



AddParam = function ( condition )	
	
	if condition:AddConditionParam( 'String', "voiceId" ) == true then
		condition.voiceId = "None"
	end
	
	
	if condition:AddConditionParam( 'bool', "isStack" ) == true then
		condition.isStack = true
	end

end,

}