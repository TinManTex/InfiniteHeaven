local e={}
local t=60
local r=60*60
local o={AFGH={{TppDefine.WEATHER.SUNNY,80},{TppDefine.WEATHER.CLOUDY,20}},MAFR={{TppDefine.WEATHER.SUNNY,70},{TppDefine.WEATHER.CLOUDY,30}},MTBS={{TppDefine.WEATHER.SUNNY,80},{TppDefine.WEATHER.CLOUDY,20}},AFGH_NO_SANDSTORM={{TppDefine.WEATHER.SUNNY,80},{TppDefine.WEATHER.CLOUDY,20}}}
local T={{TppDefine.WEATHER.SUNNY,5*r,8*r},{TppDefine.WEATHER.CLOUDY,3*r,5*r},{TppDefine.WEATHER.SANDSTORM,13*t,20*t},{TppDefine.WEATHER.RAINY,1*r,2*r},{TppDefine.WEATHER.FOGGY,13*t,20*t}}
local s={AFGH={{TppDefine.WEATHER.SANDSTORM,100}},MAFR={{TppDefine.WEATHER.RAINY,100}},MTBS={{TppDefine.WEATHER.RAINY,50},{TppDefine.WEATHER.FOGGY,50}},AFGH_HELI={},MAFR_HELI={{TppDefine.WEATHER.RAINY,100}},MTBS_HELI={{TppDefine.WEATHER.RAINY,100}},AFGH_NO_SANDSTORM={}}
local n={[TppDefine.WEATHER.SANDSTORM]=true,[TppDefine.WEATHER.FOGGY]=true}
local a="Script"local i="WeatherSystem"local t=20
local p=255
function e.RequestWeather(i,n,r)
local e,r=e._GetRequestWeatherArgs(n,r)WeatherManager.PauseNewWeatherChangeRandom(true)
if e==nil then
e=t
end
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=a,weatherType=i,interpTime=e,fogDensity=r.fogDensity,fogType=r.fogType}
end
function e.CancelRequestWeather(n,r,i)
local e,r=e._GetRequestWeatherArgs(r,i)WeatherManager.PauseNewWeatherChangeRandom(false)
if e==nil then
e=t
end
if n~=nil then
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=a,weatherType=n,interpTime=e,fogDensity=r.fogDensity,fogType=r.fogType}
end
end
function e.ForceRequestWeather(n,i,r)
local e,r=e._GetRequestWeatherArgs(i,r)
if e==nil then
e=t
end
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=a,weatherType=n,interpTime=e,fogDensity=r.fogDensity,fogType=r.fogType}
end
function e.CancelForceRequestWeather(r,n,i)
local e,n=e._GetRequestWeatherArgs(n,i)
if e==nil then
e=t
end
WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=a}
if r~=nil then
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=a,weatherType=r,interpTime=e,fogDensity=n.fogDensity,fogType=n.fogType}
end
end
function e.SetDefaultWeatherDurations()WeatherManager.SetWeatherDurations(T)
if not WeatherManager.SetExtraWeatherInterval then
return
end
WeatherManager.SetExtraWeatherInterval(5*r,8*r)
end
function e.SetDefaultWeatherProbabilities()
local e
local r
if e then
WeatherManager.SetNewWeatherProbabilities("default",e)
end
if r then
WeatherManager.SetExtraWeatherProbabilities(r)
end
end
function e.SetWeatherProbabilitiesAfghNoSandStorm()WeatherManager.SetNewWeatherProbabilities("default",o.AFGH_NO_SANDSTORM)WeatherManager.SetExtraWeatherProbabilities(s.AFGH_NO_SANDSTORM)
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
local r
if e==TppDefine.WEATHER.SANDSTORM or e==TppDefine.WEATHER.RAINY then
r=e
else
a=e
end
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=i,weatherType=a,interpTime=t}
if r~=nil then
WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_EXTRA,userId=i,weatherType=r,interpTime=t}
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
function e.OverrideColorCorrectionParameter(e,r,t)
TppColorCorrection.SetParameter(e,r,t)
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
vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]=p
vars.weatherNextTime=0
end
WeatherManager.RestoreFromSVars()
end
function e.Init()
TppEffectUtility.RemoveColorCorrectionLut()
TppEffectUtility.RemoveColorCorrectionParameter()
end
function e.OnMissionCanStart()
if TppMission.IsHelicopterSpace(vars.missionCode)then
TppEffectWeatherParameterMediator.SetParameters{addTppSkyOffsetY=1320,setTppSkyScale=.1,setTppSkyScrollSpeedRate=-20}
else
TppEffectWeatherParameterMediator.RestoreDefaultParameters()
end
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
