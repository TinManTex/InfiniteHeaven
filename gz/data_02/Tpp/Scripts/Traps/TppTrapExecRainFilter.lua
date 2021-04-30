








TppTrapExecRainFilter = {


Exec = function( info )

	if info.trapFlagString == "GEO_TRAP_S_ENTER" then



			local data = info.conditionHandle.tppRainFilterData
			if data:IsKindOf( TppRainFilter ) then
			    local dataBody = data:GetDataBodyWithReferrer( info.conditionBodyHandle )
			    if dataBody ~= nil then
					dataBody:SetForceEnableFlag(false)
			    end
			end
			
	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then



			local data = info.conditionHandle.tppRainFilterData			
			if data:IsKindOf( TppRainFilter ) then
			    local dataBody = data:GetDataBodyWithReferrer( info.conditionBodyHandle )
			    if dataBody ~= nil then
					dataBody:SetForceEnableFlag(true)
			    end
			end
	end
	
	return 1
end,


AddParam = function( condition )
	condition:AddConditionParam("EntityHandle", "tppRainFilterData")
end,

}
