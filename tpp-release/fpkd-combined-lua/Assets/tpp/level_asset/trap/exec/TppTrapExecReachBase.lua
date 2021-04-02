



TppTrapExecReachBase = {


Exec = function ( info )
	
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		
		local MBmanager = TppMotherBaseManager:GetInstance()
		MBmanager:SetIntelligenceUnitSearchCp( info.conditionHandle.CP_CHARA_ID ) 
		
		
		info.conditionBodyHandle.isDone = true
	
	elseif info.trapFlagString == "GEO_TRAP_S_OUT" then
		
		local MBmanager = TppMotherBaseManager:GetInstance()
		MBmanager:ResetIntelligenceUnitSearchCp() 

		
		info.conditionBodyHandle.isDone = true
	end
	return 1
end,


AddParam = function ( condition )	
	
	condition:AddConditionParam( 'String', "CP_CHARA_ID" )
	condition.voiceId = Entity.Null()
end,
}