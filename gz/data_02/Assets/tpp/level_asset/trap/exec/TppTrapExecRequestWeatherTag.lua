TppTrapExecRequestWeatherTag = {


Exec = function( info )
	
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		if info.conditionHandle.inTag ~= "" then
			local wm=TppWeatherManager:GetInstance()
			wm:RequestTag(info.conditionHandle.inTag, info.conditionHandle.inTime)
		end
		
		
		info.conditionBodyHandle.isDone = true
		
	
	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then
		if info.conditionHandle.outTag ~= "" then
			local wm=TppWeatherManager:GetInstance()
			wm:RequestTag(info.conditionHandle.outTag, info.conditionHandle.outTime)
		end
	end
	
	return 1

end,


AddParam = function( condition )

	condition:AddConditionParam("String", "inTag" )
	condition.inTag = ""
	condition:AddConditionParam("float", "inTime" )
	condition.inTime = 0
	condition:AddConditionParam("String", "outTag")
	condition.outTag = ""
	condition:AddConditionParam("float", "outTime")
	condition.outTime = 0

end,

}
