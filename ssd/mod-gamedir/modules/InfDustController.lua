-- InfDustControler.lua
--tex disables SSDs fogwallcontroller to enable custom fog/weather
--NOTES: vanilla FogWallController is mostly for single player/free roam maps? It's disabled in coop maps (they weather manager forced fog).
--While enabled it halts the weather manager/forces fog
--Sets GameStatuses
--"S_FOG_PASSAGE"--tex area between entering/exiting fog proper?
--"S_FOG_AREA"
--"S_NO_FOG_AREA"
--"S_NEED_OXYGEN_MASK" --puts on mask and starts oxygen tickdown
--Possibly other stuff who knows
--unsure what drives increased stamina drain TODO: TEST FOG_AREA
--unsure what drives map marker fade when in unvisited block

--some no dust areas (within main fog, not around basecamp/fob) seem additionally have trap entities covering them
--        {
--          msg = "Enter",  sender = "trap_noFogArea01",
--          func = function ()  SunnyAreaSystem.UnlockSunnyArea{ areaName = "sunny_area_1" }  end,
--        },
--this seems seperate from the passage/fog area/no fog area that FogWallController drives which is probably a seperate Entity
--as there doesnt seem to be traps around base camps fog area

--Entity-wise there is FogWallControllerData in <loc>_common_effect.fox2, but that seems to be the effect part only, but then I can't see any other likely data defining the fog areas.

local this={}

this.updateRate=1

this.execState={
  nextUpdate=0,
}

this.dustTrapNames={
  "trap_noFogArea01",
  "trap_noFogArea02",
  "trap_noFogArea03",
  "trap_noFogArea04",
  "trap_noFogArea05",
  "trap_noFogArea06",
  "trap_noFogArea07",
  "trap_noFogArea08",
}
this.dustTraps={}
for i,trapName in ipairs(this.dustTrapNames)do
  this.dustTraps[Fox.StrCode32(trapName)]=true
end

this.registerIvars={
  "dust_enableController",
  "dust_requireOxygenMask",
  "dust_wallVisible",
  "dust_forceWeather",
  "dust_fogDensity",
  "dust_fogType",
}

this.dust_enableController={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    local isNoFogArea=TppGameStatus.IsSet("", "S_NO_FOG_AREA")
    if not isNoFogArea then
      Infmenu.Print("This should only be toggled while outside of dust")--DEBUGNOW ADDLANG
    end
    
    FogWallController.SetEnabled(setting==0)
  end,
}

this.dust_requireOxygenMask={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  default=1,
  OnChange=function(self,setting)
    --tex GOTCHA wont work right if toggled while fogcontroller is on (and have mask on) since it will have it keyed to its id (TODO: test to see if it is FogWallController)
    if setting==1 then
      TppGameStatus.Set("IHDustController","S_NEED_OXYGEN_MASK")
    else
      TppGameStatus.Reset("IHDustController","S_NEED_OXYGEN_MASK")
    end
  end,
}

this.dust_wallVisible={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  default=1,
  OnChange=function(self,setting)
    local enabled=setting==1
    TppEffectUtility.SetSsdMistWallVisibility(enabled)
  end,
}

--REF TppDefine.WEATHER={SUNNY=0,CLOUDY=1,RAINY=2,SANDSTORM=3,FOGGY=4,POURING=5}
--tex cant use direct TppDefine references here since it wont be up while module is loading
local forceWeatherToWeatherType={
  4,
  0,
  1,
  2,
  3,
}

this.dust_forceWeather={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"NONE","FOGGY","SUNNY","RAINY","SANDSTORM"},
  OnChange=function(self,setting)

  end,
}

this.dust_fogDensity={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1.0,increment=0.001},--DEBUGNOW
  OnChange=function(self,setting)

  end,
}

local fogTypeToWeatherFogType={--DEBUGNOW TODO its probably the exact same value as the enum anyway
  WeatherManager.FOG_TYPE_NORMAL,
  WeatherManager.FOG_TYPE_PARASITE,
  WeatherManager.FOG_TYPE_EERIE,
}

this.dust_fogType={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"NORMAL","PARASITE","EERIE"},
  OnChange=function(self,setting)

  end,
}

this.registerMenus={
  "dustControllerMenu",
}
this.dustControllerMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfDustController.dust_enableController",
    "InfDustController.dust_requireOxygenMask",
    "InfDustController.dust_wallVisible",
    "InfDustController.dust_forceWeather",
    "InfDustController.dust_fogDensity",
    "InfDustController.dust_fogType",
  }
}
--< menu defs
this.langStrings={
  eng={
  },
  help={
    eng={
      dustControllerMenu="WIP alternate to games FogWallController",
      enableDustController="Enables custom Dust settings. You should only toggle this while outside of dust.",
    },
  }
}
--<

function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="ChangeFogAreaState",func=function()--tex probably fired by FogWallController --DEBUGNOW VERIFY with wallcontroller enabled and disabled
        end},
    },
    Trap={
      {msg="Enter",func=this.OnEnterNoFogTrap},
      {msg="Exit",func=this.OnExitNoFogTrap},
    },
  }
end

--DEBUGNOW
function this.Update(currentChecks,currentTime,execChecks,execState)
  if not currentChecks.inGame then
    return
  end

  --DEBUGNOW
  if this.debugModule then
    local isFogArea=TppGameStatus.IsSet("", "S_FOG_AREA")
    local isNoFogArea=TppGameStatus.IsSet("", "S_NO_FOG_AREA")
    local isFogPassage=TppGameStatus.IsSet("", "S_FOG_PASSAGE")

    InfCore.Log("S_FOG_AREA:"..tostring(isFogArea))
    InfCore.Log("S_NO_FOG_AREA:"..tostring(isNoFogArea))
    InfCore.Log("S_FOG_PASSAGE:"..tostring(isFogPassage))

    local needOxygenMask=TppGameStatus.IsSet("", "S_NEED_OXYGEN_MASK")
    InfCore.Log("S_NEED_OXYGEN_MASK:"..tostring(needOxygenMask))
  end
end

function this.OnEnterNoFogTrap(trapName,gameId)
  if this.dustTraps[trapName]then
    this.OnExitDust()
  end
end

function this.OnExitNoFogTrap(trapName,gameId)
  if this.dustTraps[trapName]then
    this.OnEnterDust()
  end
end

function this.OnEnterDust()
  if Ivars.dust_enableController:Get()==0 then
    return
  end
  InfCore.LogFlow("InfDustController.OnEnterDust")

  FogWallController.SetEnabled(false)

  TppWeather.CancelForceRequestWeather()

  local forceWeather=Ivars.dust_forceWeather:Get()
  if forceWeather>0 then
    local weatherType=forceWeatherToWeatherType[forceWeather]

    local interpTime=.1

    local fogParam=nil
    if weatherType==TppDefine.WEATHER.FOGGY then
      local fogDensity=Ivars.dust_fogDensity:Get()
      local fogType=Ivars.dust_fogType:Get()
      fogType=fogTypeToWeatherFogType[fogType]

      fogParam={fogDensity=fogDensity,fogType}
    end
    TppWeather.ForceRequestWeather(weatherType,interpTime,fogParam)
    WeatherManager.ClearTag("ssd_ClearSky",5)
  end

  local mistWallEnabled=Ivars.dust_wallVisible:Get()==1
  TppEffectUtility.SetSsdMistWallVisibility(mistWallEnabled)

  local requireOxygenMask=Ivars.dust_requireOxygenMask:Get()==1
  TppGameStatus.Set("IHDustController","S_NEED_OXYGEN_MASK")

  TppGameStatus.Set("IHDustController","S_FOG_AREA")
  TppGameStatus.Reset("IHDustController","S_NO_FOG_AREA")
end

function this.OnExitDust()
  if Ivars.dust_enableController:Get()==0 then
    return
  end
  InfCore.LogFlow("InfDustController.OnExitDust")

  FogWallController.SetEnabled(false)

  TppWeather.CancelForceRequestWeather()

  local mistWallEnabled=Ivars.dust_wallVisible:Get()==1
  TppEffectUtility.SetSsdMistWallVisibility(mistWallEnabled)

  TppGameStatus.Reset("IHDustController","S_NEED_OXYGEN_MASK")

  TppGameStatus.Set("IHDustController","S_NO_FOG_AREA")
  TppGameStatus.Reset("IHDustController","S_FOG_AREA")
end

return this
