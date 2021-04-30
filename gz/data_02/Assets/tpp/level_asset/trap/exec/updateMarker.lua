






updateMarker = {



AddParam = function( condition )

	condition:AddConditionParam( 'bool', "isAboutDraw" )
	condition:AddConditionParam( 'EntityLink', "onMarker" ) 
	condition:AddConditionParam( 'EntityLink', "offMarker" ) 	
	condition.isAboutDraw = false
	condition.onMarker = nil
	condition.offMarker = nil

end,



Exec = function( info )

	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then

		local player = Ch.FindCharacters( "Player" )

		if (#player.array ~= 0) then
			
			if (not Entity.IsNull(info.conditionHandle.onMarker)) then

				local charaLocatorOn = info.conditionHandle.onMarker:GetDataBodyWithReferrer( info.trapBodyHandle )
				local charaObjOn = charaLocatorOn:GetCharacterObject()

				local characterId = charaObjOn:GetCharacterId()
				local isAboutDrawOn = info.conditionHandle.isAboutDraw

				TppMarkerSystem.EnableMarker{ markerId=characterId, isAbout=isAboutDrawOn }

			else



			end

			
			if (not Entity.IsNull(info.conditionHandle.offMarker)) then

				local charaLocatorOff = info.conditionHandle.offMarker:GetDataBodyWithReferrer( info.trapBodyHandle )
				local charaObjOff = charaLocatorOff:GetCharacterObject()

				local characterId = charaObjOff:GetCharacterId()

				



				TppMarkerSystem.DisableMarker{ markerId=characterId}

			else



			end

		else



		end
		
		
		info.conditionBodyHandle.isDone = true
		
	end

	return 1

end,

}

