-- InfClockExample.lua
-- 
local this={}

--whatever other quest stuff you have
Assuming its for a quest, one solution would be something like 


```quest_step.QStep_Main = {
  Messages = function( self )
    return
      StrCode32Table {
        Weather = {
          {msg="Clock",sender="YourClockMessage",func=this.YourClockMessage},
        },
        --tex whatever other messages you have
      }--StrCode32Table
  end,--Messages
  --tex whatever other stuff you have in QStep_Main
}--QStep_Main

--tex on Clock message
function this.YourClockMessage(sender,time)
  InfCore.Log"YourClockMessage"--DEBUG
  --tex stop it from triggering again
  TppClock.UnregisterClockMessage("YourClockMessage")

  --tex set back to whatever the user has set
  TppCommand.Weather.SetClockTimeScale(Ivars.clockTimeScale:Get())--tex default is 20, higher for faster

end

function this.AccelerateClockToACertainTime()
  InfCore.Log"RegisterClockMessage YourClockMessage"
  --tex trigger a message at certain clock tine
  TppClock.RegisterClockMessage("YourClockMessage","08:00:00")
  --tex alternate: certain time from current
  --local messageTime=TppClock.GetTime("number")+(60*2)*60 --in 2 hours
  --TppClock.RegisterClockMessage("YourClockMessage",currentTime)

  TppCommand.Weather.SetClockTimeScale(4000)--tex default is 20, higher for faster
end```


Except that would give you a sudden start and end. You'd have to mess around with interpolating up to your desired clock time scale when starting the clock and then down to default after the clock message in OnUpdate or something.

