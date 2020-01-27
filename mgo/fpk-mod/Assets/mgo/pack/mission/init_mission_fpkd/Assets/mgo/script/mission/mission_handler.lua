local this = {}





local MainOnAllocate	= MgoMain.OnAllocate
local MainOnInitialize	= MgoMain.OnInitialize
local MainOnReload		= MgoMain.OnReload
local MainOnUpdate 		= MgoMain.OnUpdate 
local MainOnChangeSVars	= MgoMain.OnChangeSVars
local MainOnMessage		= MgoMain.OnMessage
local MainOnTerminate	= MgoMain.OnTerminate

this.OnAllocate = function(subScripts)
	return MainOnAllocate(subScripts)
end

this.OnInitialize = function(subScripts)
	return MainOnInitialize(subScripts)
end

this.OnReload = function(subScripts)
	return MainOnReload(subScripts)
end

this.OnUpdate = function(subScripts)
	return MainOnUpdate(subScripts)
end

this.OnChangeSVars = function(subScripts, varName, key)
	return MainOnChangeSVars(subScripts, varName, key)
end

this.OnMessage = function(subScripts, sender, messageId, arg0, arg1, arg2, arg3)
	return MainOnMessage(subScripts, sender, messageId, arg0, arg1, arg2, arg3)
end

this.OnTerminate = function(subScripts)
	return MainOnTerminate(subScripts)
end

return this