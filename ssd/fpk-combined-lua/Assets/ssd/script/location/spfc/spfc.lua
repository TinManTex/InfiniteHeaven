local spfc = {}





spfc.requires = {
}

function spfc.OnAllocate()
	Fox.Log("############### spfc.OnAllocate ###############")
	mvars.loc_locationCommonTable			= spfc
end

function spfc.OnInitialize()
	Fox.Log("############### spfc.OnInitialize ###############")

end

function spfc.OnReload()
end

function spfc.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	strLogText = "spfc.lua:".. strLogText
end

function spfc.OnMissionCanStart()
end

return spfc
