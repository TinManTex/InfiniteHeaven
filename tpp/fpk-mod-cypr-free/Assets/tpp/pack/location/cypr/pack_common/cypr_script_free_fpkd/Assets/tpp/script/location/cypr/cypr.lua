InfCore.Log("!!!!!!!!!!----cypr.lua")--DEBUGNOW 
local cypr = {}

cypr.requires = {
	"/Assets/tpp/script/location/cypr/cypr_mission_block.lua",
}

function cypr.OnAllocate()
	Fox.Log("############### cypr.OnAllocate ###############")
	mvars.loc_locationCommonTable = cypr
end

function cypr.OnInitialize()
	Fox.Log("############### cypr.OnInitialize ###############")
end

function cypr.OnReload()
end

function cypr.OnMessage(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
end

function cypr.OnMissionCanStart()
end

return cypr
