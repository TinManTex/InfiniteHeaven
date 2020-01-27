local ssav = {}





ssav.requires = {
}

function ssav.OnAllocate()
	Fox.Log("############### ssav.OnAllocate ###############")
	mvars.loc_locationCommonTable			= ssav
end

function ssav.OnInitialize()
	Fox.Log("############### ssav.OnInitialize ###############")

end

function ssav.OnReload()
end

function ssav.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	strLogText = "ssav.lua:".. strLogText
end

function ssav.OnMissionCanStart()
end

return ssav
