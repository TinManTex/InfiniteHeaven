-- DOBUILD: 1
-- InfMessageLog.lua
local this={}

local messagesMax=1000

this.fox={}
this.display={}
this.debug={}

function this.AddMessage(messageLog,message)
  --tex kill front of queue since it will be oldest
  if #messageLog==messagesMax then
    table.remove(messageLog,1)
  end
  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  table.insert(messageLog,elapsedTime.."|"..message)
end

--hook
--tex no dice
--this.FoxLog=Fox.Log
--Fox.Log=function(message)
--
--  if InfMenu then
--    InfMenu.DebugPrint(message)
--  end
--  this.AddMessage(this.fox,message)
--  this.FoxLog(message)
--end

return this
