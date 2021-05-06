













TppSystemUtility = {



SetSquadEnableState = function( locator, enableFlag )
	if ( locator:IsKindOf( "ChCharacterLocator" ) == false ) then



		return false
	end
	local charaObj = locator.charaObj
	if ( Entity.IsNull(charaObj) ) then



		
		return true
	end
	if ( charaObj:IsKindOf( "AiSquadObject" ) == false ) then



		return false
	end
	charaObj:SetMembersEnable( enableFlag )
	return true
end


} 

