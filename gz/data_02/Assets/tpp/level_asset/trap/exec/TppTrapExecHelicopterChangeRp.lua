










TppTrapExecHelicopterChangeRp = {




AddParam = function( condition )
	condition:AddConditionParam( "String", "rendezvousTag" )
end,




Exec = function( info )
	if info.trapFlagString == "GEO_TRAP_S_ENTER" then
		local rendezvousTag = info.conditionHandle.rendezvousTag
		TppSupportHelicopterService.RequestToChangeRendezvousPoint(rendezvousTag)
	end
	return 1
end,


}