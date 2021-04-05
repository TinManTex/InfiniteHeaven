local this={}

local InfButton=InfButton
local InfMenu=InfMenu
local Ivars=Ivars
local DemoDaemon=DemoDaemon
local GetPlayingDemoId=DemoDaemon.GetPlayingDemoId
local IsDemoPaused=DemoDaemon.IsDemoPaused
local IsDemoPlaying=DemoDaemon.IsDemoPlaying

this.pauseDemoButton=InfButton.STANCE--was InfButton.EVADE
this.restartDemoButton=InfButton.RELOAD

this.updateOutsideGame=true

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
  settings=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST,
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
    restartDemo="Restart cutscene",
    pauseDemo="Pause cutscene",
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

  if InfMenu.menuOn or InfMenu.quickMenuOn or Ivars.cameraMode:Is()>0 then
    return
  end

  if InfButton.OnButtonDown(this.pauseDemoButton) then
    DemoDaemon.PauseAll()
  end

  if InfButton.OnButtonDown(this.restartDemoButton) then
    if IsDemoPlaying() then--tex breaks demo playback if restarted while paused (goes into gameplay, but entering the escape pause/skip menu will hang the game in black screen)
      InfCore.Log("InfDemo: Restarting "..InfInspect.Inspect(demoId))
      DemoDaemon.RestartAll()
    end
  end
end--Update

function this.RestartDemo()
  --tex breaks demo playback if restarted while paused (goes into gameplay, but entering the escape pause/skip menu will hang the game in black screen)
  --DEBUGNOW can't notify user using announcelog since its disabled while in demo, more reason to add notifcations to ihext
  if IsDemoPlaying() then
    DemoDaemon.RestartAll()
  end
end

function this.PauseDemo()
  DemoDaemon.PauseAll()
end

return this
