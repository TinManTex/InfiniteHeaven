--DebugIHVars.lua
--tex turnin on debug crud

local this={}

function this.PostAllModulesLoad()
	InfCore.Log("!InfDebugVars.PostAllModulesLoad: setting debug vars")

    Ivars.debugMode:Set(1)
    Ivars.debugMessages:Set(1)
    Ivars.debugFlow:Set(1)
    Ivars.debugOnUpdate:Set(1)

    InfNPC.debugModule=true
    InfModelProc.debugModule=true
    InfQuest.debugModule=true
    TppQuest.debugModule=true
    --DEBUGNOW hangs InfWalkerGear=true
end

return this