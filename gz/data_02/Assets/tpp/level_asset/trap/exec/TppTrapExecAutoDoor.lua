






TppTrapExecAutoDoor = {


Exec = function( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		
		if not Entity.IsNull(info.conditionHandle.doorLocator) then

			
			if not Entity.IsNull( info.conditionHandle.characterTag ) and info.conditionHandle.characterTag ~= "" then		
				local chara = info.moverHandle
				if chara:IsKindOf( ChCharacter ) then
					if chara:FindTag( info.conditionHandle.characterTag ) then
						local door = Ch.FindCharacter( info.conditionHandle.doorLocator )
						door:SendMessage( TppGadgetStartActionRequest() )
					end
				end
			else
				local door = Ch.FindCharacter( info.conditionHandle.doorLocator )
				door:SendMessage( TppGadgetStartActionRequest() )
			end
		end

		
		info.conditionBodyHandle.isDone = true
	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then

		
		if not Entity.IsNull(info.conditionHandle.doorLocator) then

			
			if not Entity.IsNull( info.conditionHandle.characterTag ) and info.conditionHandle.characterTag ~= "" then
				local chara = info.moverHandle
				if chara:IsKindOf( ChCharacter ) then
					if chara:FindTag( info.conditionHandle.characterTag ) then
						local door = Ch.FindCharacter( info.conditionHandle.doorLocator )
						door:SendMessage( TppGadgetUnsetOwnerRequest() )
					end
				end
			else
				local door = Ch.FindCharacter( info.conditionHandle.doorLocator )
				door:SendMessage( TppGadgetUnsetOwnerRequest() )
			end
		end
	end
	return 1

end,


AddParam = function( condition )
	
	
	condition:AddConditionParam( 'EntityLink', "doorLocator" )
	condition.charaLocator = Entity.Null()

	
	condition:AddConditionParam( 'String', "characterTag" )
	condition.characterTag = Entity.Null()

end,

}

