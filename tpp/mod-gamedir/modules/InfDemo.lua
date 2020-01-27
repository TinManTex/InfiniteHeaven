local this={}

local InfButton=InfButton
local DemoDaemon=DemoDaemon
local GetPlayingDemoId=DemoDaemon.GetPlayingDemoId
local IsDemoPaused=DemoDaemon.IsDemoPaused
local IsDemoPlaying=DemoDaemon.IsDemoPlaying

this.pauseDemoButton=InfButton.EVADE
this.resetDemoButton=InfButton.RELOAD

-->
this.registerIvars={
  "useSoldierForDemos",
  "mbDemoSelection",
  "mbSelectedDemo",
  "forceDemoAllowAction",
  "mbDemoOverrideTime",
  "mbDemoHour",
  "mbDemoMinute",
  "mbDemoOverrideWeather",
  "mbDontDemoDisableBuddy",
}

this.useSoldierForDemos={
  --inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
this.mbDemoSelection={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","PLAY","DISABLED"},
}

this.mbSelectedDemo={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=1},--DYNAMIC
  settingNames={"NONE"},
  OnSelect=function(self)
    self.range.max=#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST-1
    self.settingNames=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST
  end,
}

this.forceDemoAllowAction={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.mbDemoOverrideTime={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","CURRENT","CUSTOM"},
}

this.mbDemoHour={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=23},
}

this.mbDemoMinute={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=59},
}

this.mbDemoOverrideWeather={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"DEFAULT","CURRENT","SUNNY","CLOUDY","RAINY","SANDSTORM","FOGGY","POURING"},
}

this.mbDontDemoDisableBuddy={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--< ivar defs
-->
this.registerMenus={
  "demosMenu",
}

this.demosMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "Ivars.useSoldierForDemos",
    "Ivars.mbDemoSelection",
    "Ivars.mbSelectedDemo",
    "Ivars.forceDemoAllowAction",
    "Ivars.mbDemoOverrideTime",
    "Ivars.mbDemoHour",
    "Ivars.mbDemoMinute",
    "Ivars.mbDemoOverrideWeather",
  --"Ivars.mbDontDemoDisableBuddy",--WIP
  }
}
--< menu defs
this.langStrings={
  eng={
    demosMenu="Cutscenes menu",
    mbDemoSelection="MB cutscene play mode",
    mbDemoSelectionSettings={"Default","Play selected","Cutscenes disabled"},
    mbSelectedDemo="Select MB cutscene (REQ: Play selected)",
    mbDemoOverrideTime="Override time",
    mbDemoOverrideTimeSettings={"Cutscene default","Current","Custom"},
    mbDemoHour="Hour",
    mbDemoMinute="Minute",
    mbDemoOverrideWeather="Override weather",
    mbDemoOverrideWeatherSettings={"Cutscene default","Current","Sunny","Cloudy","Rainy","Sandstorm","Foggy","Pouring"},
    useSoldierForDemos="Use selected soldier in all cutscenes and missions",
    forceDemoAllowAction="Force allow actions",
    mbDontDemoDisableBuddy="Don't disable buddy after mb cutscene",
  },
  help={
    eng={
      mbDemoSelection="Forces or Disables cutscenes that trigger under certain circumstances on returning to Mother Base",
      forceDemoAllowAction="Prevents disabling of player actions during cutscene, but most cutscenes require the Disable cutscene camera mod from the IH files page.",
    },
  },
}
--<

function this.Update(currentChecks,currentTime,execChecks,execState)
  --tex don't know if its worth allowing user to override this for the few genuine in game demos
  if currentChecks.inGame then
    return
  end

  if not IsDemoPaused() and not IsDemoPlaying() then
    return
  end

  local demoId=GetPlayingDemoId()
  if demoId==nil then
    return
  end

  if InfButton.OnButtonDown(this.pauseDemoButton) then
    DemoDaemon.PauseAll()
  end

  if InfButton.OnButtonDown(this.resetDemoButton) then
    if IsDemoPlaying() and InfMenu.quickMenuOn==false then
      InfCore.Log("InfDemo: Restarting "..InfInspect.Inspect(demoId))
      DemoDaemon.RestartAll()
    end

  end
end

return this
