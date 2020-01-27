local e={}
local r=60
local t=60*60
local i={AFGH={{TppDefine.WEATHER.SUNNY,70},{TppDefine.WEATHER.RAINY,30}},MAFR={{TppDefine.WEATHER.SUNNY,70},{TppDefine.WEATHER.RAINY,30}},AFGH_NO_SANDSTORM={{TppDefine.WEATHER.SUNNY,100}}}
local s={{TppDefine.WEATHER.SUNNY,5*t,8*t},{TppDefine.WEATHER.CLOUDY,0,0},{TppDefine.WEATHER.SANDSTORM,13*r,20*r},{TppDefine.WEATHER.RAINY,1*t,2*t},{TppDefine.WEATHER.FOGGY,13*r,20*r}}
local o={AFGH={},MAFR={},AFGH_NO_SANDSTORM={}}
local n={[TppDefine.WEATHER.SANDSTORM]=true,[TppDefine.WEATHER.FOGGY]=true}
local a="Script"local T="WeatherSystem"local r=20
local h=255
e.DEFENSE_GAME_FOG_DENSITY={START=.05,WAVE=.0175}
function e.RequestWeather(n,t,i)
local e,t=e._GetRequestWeatherArgs(t,i)WeatherManager.PauseNewWeatherChangeRandom(true)
if e==nil then
e=r
end
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_SCRIPT,userId=a,weatherType=n,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
end
function e.CancelRequestWeather(n,i,t)
local e,t=e._GetRequestWeatherArgs(i,t)WeatherManager.PauseNewWeatherChangeRandom(false)
if e==nil then
e=r
end
WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_SCRIPT,userId=a}
if n~=nil then
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=a,weatherType=n,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
end
end
function e.ForceRequestWeather(n,i,t)
local e,t=e._GetRequestWeatherArgs(i,t)
if e==nil then
e=r
end
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=a,weatherType=n,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
end
function e.ForceRequestFoggyForDefenseGame(t,r)
if not Tpp.IsTypeString(r)then
return
end
local r=e.DEFENSE_GAME_FOG_DENSITY[r]
if not r then
return
end
e.ForceRequestWeather(TppDefine.WEATHER.FOGGY,t,{fogDensity=r})
end
function e.ForceRequestCloudyForDefenseGame(t,r)
if not Tpp.IsTypeString(r)then
return
end
local r=e.DEFENSE_GAME_FOG_DENSITY[r]
if not r then
return
end
e.ForceRequestWeather(TppDefine.WEATHER.CLOUDY,t,{fogDensity=r})
end
function e.CancelForceRequestWeather(n,t,i)
local e,t=e._GetRequestWeatherArgs(t,i)
if e==nil then
e=r
end
WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=a}
if n~=nil then
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=a,weatherType=n,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
end
end
function e.SetDefaultWeatherDurations()WeatherManager.SetWeatherDurations(s)
if not WeatherManager.SetExtraWeatherInterval then
return
end
WeatherManager.SetExtraWeatherInterval(5*t,8*t)
end
function e.SetDefaultWeatherProbabilities()
local e
local r
if TppLocation.IsAfghan()then
e=i.AFGH
r=o.AFGH
elseif TppLocation.IsMiddleAfrica()then
e=i.MAFR
r=o.MAFR
end
if e then
WeatherManager.SetNewWeatherProbabilities("default",e)
end
if r then
WeatherManager.SetExtraWeatherProbabilities(r)
end
end
function e.SetWeatherProbabilitiesAfghNoSandStorm()WeatherManager.SetNewWeatherProbabilities("default",i.AFGH_NO_SANDSTORM)WeatherManager.SetExtraWeatherProbabilities(o.AFGH_NO_SANDSTORM)
end
function e.SetMissionStartWeather(e)
mvars.missionStartWeatherScript=e
end
function e.SaveMissionStartWeather()
gvars.missionStartWeather=vars.weather
if n[gvars.missionStartWeather]then
gvars.missionStartWeather=TppDefine.WEATHER.SUNNY
end
WeatherManager.StoreToSVars()
gvars.missionStartWeatherNextTime=vars.weatherNextTime
gvars.missionStartExtraWeatherInterval=vars.extraWeatherInterval
end
function e.RestoreMissionStartWeather()WeatherManager.InitializeWeather()
local e=mvars.missionStartWeatherScript or gvars.missionStartWeather
local a=TppDefine.WEATHER.SUNNY
local t
if e==TppDefine.WEATHER.SANDSTORM or e==TppDefine.WEATHER.RAINY then
t=e
else
a=e
end
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=T,weatherType=a,interpTime=r}
if t~=nil then
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_EXTRA,userId=T,weatherType=t,interpTime=r}
end
WeatherManager.StoreToSVars()
vars.weatherNextTime=gvars.missionStartWeatherNextTime
vars.extraWeatherInterval=gvars.missionStartExtraWeatherInterval
WeatherManager.RestoreFromSVars()
end
function e.OverrideColorCorrectionLUT(e)
TppColorCorrection.SetLUT(e)
end
function e.RestoreColorCorrectionLUT()
TppColorCorrection.RemoveLUT()
end
function e.OverrideColorCorrectionParameter(r,t,e)
TppColorCorrection.SetParameter(r,t,e)
end
function e.RestoreColorCorrectionParameter()
TppColorCorrection.RemoveParameter()
end
function e.StoreToSVars()WeatherManager.StoreToSVars()
end
function e.RestoreFromSVars()
local e=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]
if n[e]then
vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]=TppDefine.WEATHER.SUNNY
vars.weatherNextTime=0
end
local e=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]
if n[e]then
vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]=h
vars.weatherNextTime=0
end
WeatherManager.RestoreFromSVars()
end
function e.Init()
TppEffectUtility.RemoveColorCorrectionLut()
TppEffectUtility.RemoveColorCorrectionParameter()
end
function e.OnMissionCanStart()
TppEffectWeatherParameterMediator.RestoreDefaultParameters()
end
local r=WeatherManager.SetDefaultReflectionTexture or function()
end
function e.OnEndMissionPrepareFunction()
if WeatherManager.ClearTag then
WeatherManager.ClearTag()
else
WeatherManager.RequestTag("default",0)
end
r()
end
function e._GetRequestWeatherArgs(e,r)
if Tpp.IsTypeTable(e)then
return nil,e
elseif Tpp.IsTypeTable(r)then
return e,r
else
return e,{}
end
end
return e
