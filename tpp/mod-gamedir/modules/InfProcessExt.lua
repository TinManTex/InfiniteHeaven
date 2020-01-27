--InfProcessExt.lua
local this={}

function this.Update(currentChecks,currentTime,execChecks,execState)
  if ivars.postExtCommands==0 then
    return
  end
  
  InfCore.PCallDebug(InfCore.DoToMgsvCommands)
end

return this
