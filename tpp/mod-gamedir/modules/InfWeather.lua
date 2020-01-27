-- InfWeather.lua
local this={}

--REF TppDefine.WEATHER={SUNNY=0,CLOUDY=1,RAINY=2,SANDSTORM=3,FOGGY=4,POURING=5}



local fogTypeToWeatherFogType={--DEBUGNOW TODO its probably the exact same value as the enum anyway
  WeatherManager.FOG_TYPE_NORMAL,
  WeatherManager.FOG_TYPE_PARASITE,
  WeatherManager.FOG_TYPE_EERIE,
}

local function OnChangeWeather()
  TppWeather.CancelForceRequestWeather()

  local weatherType=Ivars.weather_forceType:Get()-1
  if weatherType>=0 then
    local interpTime=1
    local fogParam=nil
    if weatherType==TppDefine.WEATHER.FOGGY then
      local fogDensity=Ivars.weather_fogDensity:Get()
      local fogType=Ivars.weather_fogType:Get()--DEBUG
      --InfCore.PrintInspect(fogType,"fogType")--DEBUG
      fogType=fogTypeToWeatherFogType[fogType+1]
      --InfCore.PrintInspect(fogType,"weatherfogType")--DEBUG

      fogParam={fogDensity=fogDensity,fogType=fogType,}
    end
    --WeatherManager.RequestTag("default",8)
    --WeatherManager.RequestTag("factory_fog", 8 )
    TppWeather.ForceRequestWeather(weatherType,interpTime,fogParam)
  end
end

this.registerIvars={
  "weather_forceType",
  "weather_fogDensity",
  "weather_fogType",
}

this.weather_forceType={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  settings={"NONE","SUNNY","CLOUDY","RAINY","SANDSTORM","FOGGY"},
  OnChange=OnChangeWeather,
}

this.weather_fogDensity={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1.0,increment=0.01},
  default=0.1,
  OnChange=OnChangeWeather,
}

this.weather_fogType={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"NORMAL","PARASITE"},--OFF ,"EERIE"},--tex I cant tell difference between EERIE and NORMAL
  OnChange=OnChangeWeather,
}

this.registerMenus={
  "weatherMenu",
}
this.weatherMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfWeather.weather_forceType",
    "InfWeather.weather_fogDensity",
    "InfWeather.weather_fogType",
  }
}
--< menu defs
this.langStrings={
  eng={
    weatherMenu="Weather menu",
    weather_forceType="Force weather",
    weather_fogDensity="Fog density",
    weather_fogType="Fog type",
  },
  help={
    eng={
    },
  }
}
--<

return this
