local this={}
local a=Fox.StrCode32
local r=(1/60)/60
local s=1/60
local l=60*60
local o=60
this.DEPLOY_TIME={CURRENT=0,MORNING=1,NIGHT=2}
function this.FormalizeTime(n,t)
  local i=t or"time"if(i=="number")then
    return n
  end
  local r=math.floor(n*r)
  local a=r*l
  local t=math.floor((n-a)*s)
  local l=t*o
  local n=math.floor((n-a)-l)
  local a=n
  if(i=="time")then
    return r,t,n
  elseif(i=="string")then
    return string.format("%02d:%02d:%02d",r,t,n)
  else
    return nil
  end
end
this.DAY_TO_NIGHT=this.FormalizeTime(WeatherManager.NIGHT_START_CLOCK,"string")
this.NIGHT_TO_DAY=this.FormalizeTime(WeatherManager.NIGHT_END_CLOCK,"string")
this.NIGHT_TO_MIDNIGHT="22:00:00"function this.RegisterClockMessage(r,n)
  local t
  if(type(n)=="string")then
    t=this.ParseTimeString(n,"number")
  elseif(type(n)=="number")then
    t=n
  else
    return
  end
  TppCommand.Weather.RegisterClockMessage{id=a(r),seconds=t,isRepeat=true,nil}
end
function this.UnregisterClockMessage(e)
  TppCommand.Weather.UnregisterClockMessage{id=a(e)}
end
function this.GetTime(n)
  return this.FormalizeTime(vars.clock,n)
end
function this.GetDays()
  return WeatherManager.GetDays()
end
function this.GetClockValue()
  return WeatherManager.GetClockValue()
end
function this.GetTimeOfDay()
  if(WeatherManager.IsNight())then
    return"night"else
    return"day"end
end
function this.GetTimeOfDayIncludeMidNight()
  if WeatherManager.IsNight()then
    local n=this.GetTime"number"if(n<this.TIME_AT_MIDNIGHT)then
      return"night"else
      return"midnight"end
  else
    return"day"end
end
function this.SetTime(n)
  local e=this.ParseTimeString(n,"number")
  vars.clock=e
end
function this.AddTime(n)
  local t
  if(type(n)=="number")then
    t=n
  else
    t=this.ParseTimeString(n,"number")
  end
  vars.clock=vars.clock+t
end
function this.Start()
  TppCommand.Weather.SetClockTimeScale(20)
end
function this.Stop()
  TppCommand.Weather.SetClockTimeScale(0)
end
function this.SaveMissionStartClock(n)
  if n then
    gvars.missionStartClock=this.ParseTimeString(n,"number")
  else
    gvars.missionStartClock=vars.clock
  end
end
function this.RestoreMissionStartClock()
  vars.clock=gvars.missionStartClock
end
function this.ParseTimeString(n,e)
  if(type(n)~="string")then
    return nil
  end
  local n=Tpp.SplitString(n,":")
  local t=tonumber(n[1])
  local r=tonumber(n[2])
  local n=tonumber(n[3])e=e or"time"if(e=="time")then
    return t,r,n
  elseif(e=="number")then
    local t=t*l
    local e=r*o
    local n=n
    return((t+e)+n)
  else
    return nil
  end
end
function this.OnAllocate(n)
  if TppCommand.Weather.UnregisterAllClockMessages then
    TppCommand.Weather.UnregisterAllClockMessages()
  end
end
this.TIME_AT_NIGHT=this.ParseTimeString(this.DAY_TO_NIGHT,"number")
this.TIME_AT_MORNING=this.ParseTimeString(this.NIGHT_TO_DAY,"number")
this.TIME_AT_MIDNIGHT=this.ParseTimeString(this.NIGHT_TO_MIDNIGHT,"number")
return this
