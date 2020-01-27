--DebugIHVars.lua
--tex turnin on debug crud

local this={}

function this.PostAllModulesLoad()
  InfCore.Log("DebugIHVars.PostAllModulesLoad: setting debug vars")

  Ivars.debugMode:Set(1)
  Ivars.debugMessages:Set(1)
  Ivars.debugFlow:Set(1)
  Ivars.debugOnUpdate:Set(1)

  --InfNPC.debugModule=true
  --InfModelProc.debugModule=true
  --InfQuest.debugModule=true
  --TppQuest.debugModule=true
  --InfInterrogation.debugModule=true
  --InfMBGimmick.debugModule=true
  --InfLookup.debugModule=true

  --TODO hangs InfWalkerGear=true

 Ivars.customSoldierTypeFREE:Set"OFF"--DEBUGNOW

end

return this
