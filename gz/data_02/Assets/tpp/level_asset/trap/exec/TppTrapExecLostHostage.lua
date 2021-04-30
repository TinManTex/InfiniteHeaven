








TppTrapExecLostHostage = {


Exec = function( info )
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then

		if info.moverHandle:IsKindOf( ChCharacter ) then
			local charaObj = info.moverHandle:GetCharacterObject()

			local hostageLocater = info.conditionHandle.hostageLocator:GetDataBodyWithReferrer( info.trapBodyHandle )
			local hostageObj = hostageLocater:GetCharacterObject()

			
			
			
			if not Entity.IsNull(hostageObj) then
				if charaObj:GetCharacterId() == hostageLocater:GetCharacterId() then
					
					local hostage = hostageObj:GetCharacter()
					local chLocater = info.conditionHandle.commandPostLocator:GetDataBodyWithReferrer( info.trapBodyHandle )
					local cpObj = chLocater:GetCharacterObject()
					local cpChara = cpObj:GetCharacter()
					local hostageStatus = cpObj:GetHostageStatus(hostage, info.conditionBodyHandle.noticeObject)

					if cpObj:CompHostageStatus(hostage, info.conditionBodyHandle.noticeObject, "HOSTAGE_STATUS_LOST") == true then
						
						TppTrapExecLostHostage.HostageInfoSet(info.conditionHandle, info.trapBodyHandle, hostage, info.conditionBodyHandle.noticeObject, false )
						info.conditionBodyHandle.noticeObject = Entity.Null()
					end
				end
			end
		end

	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then

		if info.moverHandle:IsKindOf( ChCharacter ) then
			local charaObj = info.moverHandle:GetCharacterObject()

			local hostageLocater = info.conditionHandle.hostageLocator:GetDataBodyWithReferrer( info.trapBodyHandle )
			local hostageObj = hostageLocater:GetCharacterObject()
			
			

			if not Entity.IsNull(hostageObj) then
				if charaObj:GetCharacterId() == hostageLocater:GetCharacterId() then
					
					local hostage = hostageObj:GetCharacter()
					if Entity.IsNull(info.conditionBodyHandle.noticeObject) then
						if MgsEnemyNoticeObject ~= nil then
							info.conditionBodyHandle.noticeObject = MgsEnemyNoticeObject(info.trapPosition+Vector3(0,0.5,0), "LostPrisoner")
						else
							info.conditionBodyHandle.noticeObject = TppEnemyNoticeObject(info.trapPosition+Vector3(0,0.5,0), "LostPrisoner")
						end
						TppTrapExecLostHostage.HostageInfoSet(info.conditionHandle, info.trapBodyHandle, hostage, info.conditionBodyHandle.noticeObject, true )
					end
				end
			end
		end
	end
	
	return 1
end,


AddParam = function( condition )
	
	
	condition:AddConditionParam( 'EntityLink', "commandPostLocator" )
	condition.commandPostLocator = nil

	
	condition:AddConditionParam( 'EntityLink', "hostageLocator" )
	condition.hostageLocator = nil

end,



AddParamBody = function( conditionBody )
	
	conditionBody:AddProperty("EntityPtr", "noticeObject")
	conditionBody.noticeObject = Entity.Null()
end,





HostageInfoSet = function(data, body, hostage, notice, request )
	local commandPostLocatorDataBody = data.commandPostLocator:GetDataBodyWithReferrer(body)
	TppCommandPostObject.GsHostageInfoSet( commandPostLocatorDataBody , hostage, notice, request )
end,


}
