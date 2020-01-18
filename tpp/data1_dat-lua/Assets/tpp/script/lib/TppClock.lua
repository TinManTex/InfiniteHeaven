local e={}
local o=Fox.StrCode32
local t=(1/60)/60
local c=1/60
local l=60*60
local a=60
e.DEPLOY_TIME={CURRENT=0,MORNING=1,NIGHT=2}
function e.FormalizeTime(n,r)
local i=r or"time"if(i=="number")then
return n
end
local t=math.floor(n*t)
local l=t*l
local r=math.floor((n-l)*c)
local o=r*a
local n=math.floor((n-l)-o)
local l=n
if(i=="time")then
return t,r,n
elseif(i=="string")then
return string.format("%02d:%02d:%02d",t,r,n)
else
return nil
end
end
e.DAY_TO_NIGHT=e.FormalizeTime(WeatherManager.NIGHT_START_CLOCK,"string")
e.NIGHT_TO_DAY=e.FormalizeTime(WeatherManager.NIGHT_END_CLOCK,"string")
e.NIGHT_TO_MIDNIGHT="22:00:00"function e.RegisterClockMessage(t,n)
local r
if(type(n)=="string")then
r=e.ParseTimeString(n,"number")
elseif(type(n)=="number")then
r=n
else
return
end
TppCommand.Weather.RegisterClockMessage{id=o(t),seconds=r,isRepeat=true,nil}
end
function e.UnregisterClockMessage(e)
TppCommand.Weather.UnregisterClockMessage{id=o(e)}
end
function e.GetTime(n)
return e.FormalizeTime(vars.clock,n)
end
function e.GetTimeOfDay()
if(WeatherManager.IsNight())then
return"night"else
return"day"end
end
function e.GetTimeOfDayIncludeMidNight()
if WeatherManager.IsNight()then
local n=e.GetTime"number"if(n<e.TIME_AT_MIDNIGHT)then
return"night"else
return"midnight"end
else
return"day"end
end
function e.SetTime(n)
local e=e.ParseTimeString(n,"number")
vars.clock=e
end
function e.AddTime(r)
local n
if(type(r)=="number")then
n=r
else
n=e.ParseTimeString(r,"number")
end
vars.clock=vars.clock+n
end
function e.SetTimeFromHelicopterSpace(n,r,t)
if(n==e.DEPLOY_TIME.CURRENT)or(n==nil)then
e.AddTimeFromHelicopterSpace(r,t)
return
end
if n==e.DEPLOY_TIME.MORNING then
vars.clock=e.TIME_AT_MORNING
return
end
if n==e.DEPLOY_TIME.NIGHT then
vars.clock=e.TIME_AT_NIGHT
return
end
e.AddTimeFromHelicopterSpace(r,t)
end
function e.AddTimeFromHelicopterSpace(r,t)
local n
local function i(e)
if(e==50)or(e==55)then
return true
else
return false
end
end
if r~=t then
if i(r)and i(t)then
n=false
else
n=true
end
else
n=false
end
local r
if n then
r=6
else
r=1
end
e.AddTime(r*l)
end
function e.Start()
TppCommand.Weather.SetClockTimeScale(20)
end
function e.Stop()
TppCommand.Weather.SetClockTimeScale(0)
end
function e.SaveMissionStartClock(n)
if n then
gvars.missionStartClock=e.ParseTimeString(n,"number")
else
gvars.missionStartClock=vars.clock
end
end
function e.RestoreMissionStartClock()
vars.clock=gvars.missionStartClock
end
function e.ParseTimeString(n,e)
if(type(n)~="string")then
return nil
end
local n=Tpp.SplitString(n,":")
local t=tonumber(n[1])
local r=tonumber(n[2])
local n=tonumber(n[3])e=e or"time"if(e=="time")then
return t,r,n
elseif(e=="number")then
local e=t*l
local r=r*a
local n=n
return((e+r)+n)
else
return nil
end
end
function e.OnAllocate(n)
if TppCommand.Weather.UnregisterAllClockMessages then
TppCommand.Weather.UnregisterAllClockMessages()
end
end
e.TIME_AT_NIGHT=e.ParseTimeString(e.DAY_TO_NIGHT,"number")
e.TIME_AT_MORNING=e.ParseTimeString(e.NIGHT_TO_DAY,"number")
e.TIME_AT_MIDNIGHT=e.ParseTimeString(e.NIGHT_TO_MIDNIGHT,"number")
return e
