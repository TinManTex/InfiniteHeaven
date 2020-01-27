-- ssd TppWeather.lua
local this={}
local minuteInSeconds=60
local hourInSeconds=60*60
local weatherProbabilitiesTable={
  AFGH={
    {TppDefine.WEATHER.SUNNY,70},
    {TppDefine.WEATHER.RAINY,30}
  },
  MAFR={
    {TppDefine.WEATHER.SUNNY,70},
    {TppDefine.WEATHER.RAINY,30}
  },
  AFGH_NO_SANDSTORM={
    {TppDefine.WEATHER.SUNNY,100}
  }
}
local weatherDurations={
  {TppDefine.WEATHER.SUNNY,5*hourInSeconds,8*hourInSeconds},
  {TppDefine.WEATHER.CLOUDY,0,0},
  {TppDefine.WEATHER.SANDSTORM,13*minuteInSeconds,20*minuteInSeconds},
  {TppDefine.WEATHER.RAINY,1*hourInSeconds,2*hourInSeconds},
  {TppDefine.WEATHER.FOGGY,13*minuteInSeconds,20*minuteInSeconds}
}
local extraWeatherProbabilitiesTable={
  AFGH={},
  MAFR={},
  AFGH_NO_SANDSTORM={}
}
local sandStormOrFoggy={[TppDefine.WEATHER.SANDSTORM]=true,[TppDefine.WEATHER.FOGGY]=true}
local userIdScript="Script"
local userIdWeather="WeatherSystem"
local defaultInterpTime=20
local unkM1NoWeather=255
this.DEFENSE_GAME_FOG_DENSITY={START=.05,WAVE=.0175}
function this.RequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  WeatherManager.PauseNewWeatherChangeRandom(true)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.RequestWeather{
    priority=WeatherManager.REQUEST_PRIORITY_SCRIPT,
    userId=userIdScript,
    weatherType=weatherType,
    interpTime=interpTime,
    fogDensity=fogInfo.fogDensity,
    fogType=fogInfo.fogType
  }
end
function this.CancelRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  WeatherManager.PauseNewWeatherChangeRandom(false)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  --NMC seems like they added cancelrequest call for ssd (ala CancelForceRequestWeather), tpp just requested the new? DEBUGNOW VERIFY with unmodded tpp
  WeatherManager.CancelRequestWeather{
    priority=WeatherManager.REQUEST_PRIORITY_SCRIPT,
    userId=userIdScript
  }
  if weatherType~=nil then
    WeatherManager.RequestWeather{
      priority=WeatherManager.REQUEST_PRIORITY_NORMAL,
      userId=userIdScript,
      weatherType=weatherType,
      interpTime=interpTime,
      fogDensity=fogInfo.fogDensity,
      fogType=fogInfo.fogType
    }
  end
end
function this.ForceRequestWeather(weatherType,param1,param2)
  local interpTime,fogInfo=this._GetRequestWeatherArgs(param1,param2)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,
    userId=userIdScript,
    weatherType=weatherType,
    interpTime=interpTime,
    fogDensity=fogInfo.fogDensity,
    fogType=fogInfo.fogType
  }
end
function this.ForceRequestFoggyForDefenseGame(param1,defenseStage)
  if not Tpp.IsTypeString(defenseStage)then
    return
  end
  local fogDensity=this.DEFENSE_GAME_FOG_DENSITY[defenseStage]
  if not fogDensity then
    return
  end
  this.ForceRequestWeather(TppDefine.WEATHER.FOGGY,param1,{fogDensity=fogDensity})
end
function this.ForceRequestCloudyForDefenseGame(param1,defenseStage)
  if not Tpp.IsTypeString(defenseStage)then
    return
  end
  local fogDensity=this.DEFENSE_GAME_FOG_DENSITY[defenseStage]
  if not fogDensity then
    return
  end
  this.ForceRequestWeather(TppDefine.WEATHER.CLOUDY,param1,{fogDensity=fogDensity})
end
function this.CancelForceRequestWeather(n,param1,param2)
  local interpTime,fogDensity=this._GetRequestWeatherArgs(param1,param2)
  if interpTime==nil then
    interpTime=defaultInterpTime
  end
  WeatherManager.CancelRequestWeather{priority=WeatherManager.REQUEST_PRIORITY_FORCE,userId=userIdScript}
  if n~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=userIdScript,weatherType=n,interpTime=interpTime,fogDensity=fogDensity.fogDensity,fogType=fogDensity.fogType}
  end
end
function this.SetDefaultWeatherDurations()WeatherManager.SetWeatherDurations(weatherDurations)
  if not WeatherManager.SetExtraWeatherInterval then
    return
  end
  WeatherManager.SetExtraWeatherInterval(5*hourInSeconds,8*hourInSeconds)
end
function this.SetDefaultWeatherProbabilities()
  local weatherProbabilities
  local extraWeatherProbabilities
  if TppLocation.IsAfghan()then
    weatherProbabilities=weatherProbabilitiesTable.AFGH
    extraWeatherProbabilities=extraWeatherProbabilitiesTable.AFGH
  elseif TppLocation.IsMiddleAfrica()then
    weatherProbabilities=weatherProbabilitiesTable.MAFR
    extraWeatherProbabilities=extraWeatherProbabilitiesTable.MAFR
  end
  if weatherProbabilities then
    WeatherManager.SetNewWeatherProbabilities("default",weatherProbabilities)
  end
  if extraWeatherProbabilities then
    WeatherManager.SetExtraWeatherProbabilities(extraWeatherProbabilities)
  end
end
function this.SetWeatherProbabilitiesAfghNoSandStorm()
  WeatherManager.SetNewWeatherProbabilities("default",weatherProbabilitiesTable.AFGH_NO_SANDSTORM)
  WeatherManager.SetExtraWeatherProbabilities(extraWeatherProbabilitiesTable.AFGH_NO_SANDSTORM)
end
function this.SetMissionStartWeather(weatherType)
  mvars.missionStartWeatherScript=weatherType
end
function this.SaveMissionStartWeather()
  gvars.missionStartWeather=vars.weather
  if sandStormOrFoggy[gvars.missionStartWeather]then
    gvars.missionStartWeather=TppDefine.WEATHER.SUNNY
  end
  WeatherManager.StoreToSVars()
  gvars.missionStartWeatherNextTime=vars.weatherNextTime
  gvars.missionStartExtraWeatherInterval=vars.extraWeatherInterval
end
function this.RestoreMissionStartWeather()
  WeatherManager.InitializeWeather()
  local missionStartWeather=mvars.missionStartWeatherScript or gvars.missionStartWeather
  local defaultWeatherType=TppDefine.WEATHER.SUNNY
  local weatherType
  if missionStartWeather==TppDefine.WEATHER.SANDSTORM or missionStartWeather==TppDefine.WEATHER.RAINY then
    weatherType=missionStartWeather
  else
    defaultWeatherType=missionStartWeather
  end
  WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_NORMAL,userId=userIdWeather,weatherType=defaultWeatherType,interpTime=defaultInterpTime}
  if weatherType~=nil then
    WeatherManager.RequestWeather{priority=WeatherManager.REQUEST_PRIORITY_EXTRA,userId=userIdWeather,weatherType=weatherType,interpTime=defaultInterpTime}
  end
  WeatherManager.StoreToSVars()
  vars.weatherNextTime=gvars.missionStartWeatherNextTime
  vars.extraWeatherInterval=gvars.missionStartExtraWeatherInterval
  WeatherManager.RestoreFromSVars()
end
function this.OverrideColorCorrectionLUT(unkP1)
  TppColorCorrection.SetLUT(unkP1)
end
function this.RestoreColorCorrectionLUT()
  TppColorCorrection.RemoveLUT()
end
function this.OverrideColorCorrectionParameter(unkP1,unkP2,unkP3)
  TppColorCorrection.SetParameter(unkP1,unkP2,unkP3)
end
function this.RestoreColorCorrectionParameter()
  TppColorCorrection.RemoveParameter()
end
function this.StoreToSVars()
  WeatherManager.StoreToSVars()
end
function this.RestoreFromSVars()
  local normalWeatherType=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]
  if sandStormOrFoggy[normalWeatherType]then
    vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_NORMAL]=TppDefine.WEATHER.SUNNY
    vars.weatherNextTime=0
  end
  local extraWeatherType=vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]
  if sandStormOrFoggy[extraWeatherType]then
    vars.requestWeatherType[WeatherManager.REQUEST_PRIORITY_EXTRA]=unkM1NoWeather
    vars.weatherNextTime=0
  end
  WeatherManager.RestoreFromSVars()
end
function this.Init()
  TppEffectUtility.RemoveColorCorrectionLut()
  TppEffectUtility.RemoveColorCorrectionParameter()
end
function this.OnMissionCanStart()
  TppEffectWeatherParameterMediator.RestoreDefaultParameters()
end
local SetDefaultReflectionTexture=WeatherManager.SetDefaultReflectionTexture or function()end
function this.OnEndMissionPrepareFunction()
  if WeatherManager.ClearTag then
    WeatherManager.ClearTag()
  else
    WeatherManager.RequestTag("default",0)
  end
  SetDefaultReflectionTexture()
end
--NMC returns interpTime (integer), fogInfo (table)
function this._GetRequestWeatherArgs(param1,param2)
  if Tpp.IsTypeTable(param1)then
    return nil,param1
  elseif Tpp.IsTypeTable(param2)then
    return param1,param2
  else
    return param1,{}
  end
end
return this
