-- InfClockExample.lua
-- 
local this={}

function this.Init(missionTable)
  this.messageExecTable=nil

  --DEBUGNOW limit!!!!!

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

end

function this.OnReload(missionTable)
  this.messageExecTable=nil

  --DEBUGNOW limit!!!!!

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnMissionCanStart()
  --tex don't mission filter since it needs to unregister clock (see the function)
  this.StartYourClockMessage()
end






function this.Messages()
  return Tpp.StrCode32Table{
    Weather = {
      {msg="Clock",sender="YourClockMessage",func=this.YourClockMessage},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end


function this.StartYourClockMessage()
  InfCore.Log"RegisterClock YourClockMessage"
  TppClock.RegisterClockMessage("YourClockMessage","08:00:00")
  --tex alternate: certain time from current
  --local messageTime=TppClock.GetTime("number")+(60*2)*60 --in 2 hours
  --TppClock.RegisterClockMessage("YourClockMessage",currentTime)
end

--tex on Clock message
function this.YourClockMessage(sender,time)
  InfCore.Log"YourClockMessage"--DEBUG
  --tex stop it from triggering again
  TppClock.UnregisterClockMessage("YourClockMessage")

  --tex do whatever
end

return this
