local e={}
local r=60
local t=60*60
local i={AFGH={{TppDefine.WEATHER.SUNNY,80},{TppDefine.WEATHER.CLOUDY,20}},MAFR={{TppDefine.WEATHER.SUNNY,70},{TppDefine.WEATHER.CLOUDY,30}},MTBS={{TppDefine.WEATHER.SUNNY,80},{TppDefine.WEATHER.CLOUDY,20}},AFGH_NO_SANDSTORM={{TppDefine.WEATHER.SUNNY,80},{TppDefine.WEATHER.CLOUDY,20}}}
local T={{TppDefine.WEATHER.SUNNY,5*t,8*t},{TppDefine.WEATHER.CLOUDY,3*t,5*t},{TppDefine.WEATHER.SANDSTORM,13*r,20*r},{TppDefine.WEATHER.RAINY,1*t,2*t},{TppDefine.WEATHER.FOGGY,13*r,20*r}}
local r={AFGH={{TppDefine.WEATHER.SANDSTORM,100}},MAFR={{TppDefine.WEATHER.RAINY,100}},MTBS={{TppDefine.WEATHER.RAINY,50},{TppDefine.WEATHER.FOGGY,50}},AFGH_HELI={},MAFR_HELI={{TppDefine.WEATHER.RAINY,100}},MTBS_HELI={{TppDefine.WEATHER.RAINY,100}},AFGH_NO_SANDSTORM={}}
local o={[TppDefine.WEATHER.SANDSTORM]=true,[TppDefine.WEATHER.FOGGY]=true}
local n="Script"local s="WeatherSystem"local a=20
local p=255
function e.RequestWeather(i,t,r)
  local e,t=e._GetRequestWeatherArgs(t,r)WeatherManager.PauseNewWeatherChangeRandom(true)
  if e==nil then
    e=a
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=n,weatherType=i,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
end
function e.CancelRequestWeather(t,r,i)
  local e,r=e._GetRequestWeatherArgs(r,i)WeatherManager.PauseNewWeatherChangeRandom(false)
  if e==nil then
    e=a
  end
  if t~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=n,weatherType=t,interpTime=e,fogDensity=r.fogDensity,fogType=r.fogType}
  end
end
function e.ForceRequestWeather(r,t,i)
  local e,t=e._GetRequestWeatherArgs(t,i)
  if e==nil then
    e=a
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=n,weatherType=r,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
end
function e.CancelForceRequestWeather(r,t,i)
  local e,t=e._GetRequestWeatherArgs(t,i)
  if e==nil then
    e=a
  end
  WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=n}
  if r~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=n,weatherType=r,interpTime=e,fogDensity=t.fogDensity,fogType=t.fogType}
  end
end
function e.SetDefaultWeatherDurations()WeatherManager.SetWeatherDurations(T)
  if not WeatherManager.SetExtraWeatherInterval then
    return
  end
  WeatherManager.SetExtraWeatherInterval(5*t,8*t)
end
function e.SetDefaultWeatherProbabilities()
  local t
  local e
  local a=TppMission.IsHelicopterSpace(vars.missionCode)
  if TppLocation.IsAfghan()then
    t=i.AFGH
    if a then
      e=r.AFGH_HELI
    else
      e=r.AFGH
    end
  elseif TppLocation.IsMiddleAfrica()then
    t=i.MAFR
    if a then
      e=r.MAFR_HELI
    else
      e=r.MAFR
    end
  elseif TppLocation.IsMotherBase()then
    t=i.MTBS
    if a then
      e=r.MTBS_HELI
    else
      e=r.MTBS
    end
  end
  if t then
    WeatherManager.SetNewWeatherProbabilities("default",t)
  end
  if e then
    WeatherManager.SetExtraWeatherProbabilities(e)
  end
end
function e.SetWeatherProbabilitiesAfghNoSandStorm()
WeatherManager.SetNewWeatherProbabilities("default",i.AFGH_NO_SANDSTORM)
WeatherManager.SetExtraWeatherProbabilities(r.AFGH_NO_SANDSTORM)
end
function e.SetMissionStartWeather(e)
  mvars.missionStartWeatherScript=e
end
function e.SaveMissionStartWeather()
  gvars.missionStartWeather=vars.weather
  if o[gvars.missionStartWeather]then
    gvars.missionStartWeather=TppDefine.WEATHER.SUNNY
  end
  WeatherManager.StoreToSVars()
  gvars.missionStartWeatherNextTime=vars.weatherNextTime
  gvars.missionStartExtraWeatherInterval=vars.extraWeatherInterval
end
function e.RestoreMissionStartWeather()WeatherManager.InitializeWeather()
  local e=mvars.missionStartWeatherScript or gvars.missionStartWeather
  local r=TppDefine.WEATHER.SUNNY
  local t
  if e==TppDefine.WEATHER.SANDSTORM or e==TppDefine.WEATHER.RAINY then
    t=e
  else
    r=e
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=s,weatherType=r,interpTime=a}
  if t~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_EXTRA,userId=s,weatherType=t,interpTime=a}
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
function e.OverrideColorCorrectionParameter(t,e,r)
  TppColorCorrection.SetParameter(t,e,r)
end
function e.RestoreColorCorrectionParameter()
  TppColorCorrection.RemoveParameter()
end
function e.StoreToSVars()
  WeatherManager.StoreToSVars()
end
function e.RestoreFromSVars()
  local e=TppMission.IsFOBMission(vars.missionCode)
  if e then
  else
    local e=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]
    if o[e]then
      vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]=TppDefine.WEATHER.SUNNY
      vars.weatherNextTime=0
    end
    local e=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]
    if o[e]then
      vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]=p
      vars.weatherNextTime=0
    end
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
local t=WeatherManager.SetDefaultReflectionTexture or function()
  end
function e.OnEndMissionPrepareFunction()
  if WeatherManager.ClearTag then
    WeatherManager.ClearTag()
  else
    WeatherManager.RequestTag("default",0)
  end
  t()
end
function e._GetRequestWeatherArgs(e,t)
  if Tpp.IsTypeTable(e)then
    return nil,e
  elseif Tpp.IsTypeTable(t)then
    return e,t
  else
    return e,{}
  end
end
return e
