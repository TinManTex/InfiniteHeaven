


local this = {}

this.CallbackLists = {
	OnRulesetRoundStart = {},
	OnRulesetRoundEnd = {},
	OnRoundCountdownStart = {},
	OnRoundStart = {},
	OnPlayerDeath = {},
	OnPlayerStunned = {},
	OnPlayerInterrogated = {},
	OnPlayerCharmed = {},
	OnPlayerTagged = {},
	OnPlayerConnect = {},
	OnPlayerDisconnect = {},
	OnPlayerRespawn = {},
	OnPlayerSpawnChoiceExecute = {},
	OnEventSignal = {},
	SetupPlayerLoadout = {},
}

this.Multiplex = function( callbacks, ... )
	for _,cb in pairs(callbacks) do
		cb(unpack(arg))
	end
end

this.ClearCallbacks = function()
	for _,list in pairs(this.CallbackLists) do
		if(list ~= nil) then
			for entry,_ in pairs(list) do
				list[entry] = nil
			end
		end
	end
end

this.SetupComponent = function( name, component, parent )
	if(component == nil) then 
		Fox.Error("SetupComponent error. Component: " .. name .. " is nil!")
		return false
	end

	Fox.Log("AboutToAdd: " .. name)
 	for k,v in pairs(component.pushToParent) do
		if this.CallbackLists[k] ~= nil then
			Fox.Log("Adding function to callback list " .. name .. ":" .. k)
			table.insert(this.CallbackLists[k], v)
		else
			Fox.Log("Adding new function to root " .. name .. ":" .. k)
			parent[k] = v
		end
	end

	component.owner = parent

	if(component.SetupComponent ~= nil) then
		return component.SetupComponent()
	end

	return true
end

this.InitComponent = function( name, component, rulesetData, ruleset )
	if(component == nil) then 
		Fox.Error("InitComponent error. Component: " .. name .. " is nil!")
		return false
	end

	return component.Init(rulesetData, ruleset)
end

return this