-- InfMainSsd.lua

local this={}

this.registerIvars={
  "disableOutOfBoundsChecks",
  "disableGameOver",
  "enableMinimap",
  "disableCommonRadio",
  "avatar_enableGenderSelect",
}

this.disableOutOfBoundsChecks={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevSetting,setting)
    mvars.mis_ignoreAlertOfMissionArea=setting==1
    mvars.mis_enableAlertOutOfMissionArea=setting==0--DEBUGNOW
    local enable=setting==0
    mvars.mis_ignoreAlertOfMissionArea=not enable
    local trapName="trap_mission_failed_area"
    TppTrap.ChangeNormalTrapState(trapName,enable)
    TppTrap.ChangeTriggerTrapState(trapName,enable)
    local trapName="innerZone"--DEBUGNOW
    TppTrap.ChangeNormalTrapState(trapName,enable)
    TppTrap.ChangeTriggerTrapState(trapName,enable)
    local trapName="outerZone"--DEBUGNOW
    TppTrap.ChangeNormalTrapState(trapName,enable)
    TppTrap.ChangeTriggerTrapState(trapName,enable)
    local trapName="trap_border_a"--DEBUGNOW
    TppTrap.ChangeNormalTrapState(trapName,enable)
    TppTrap.ChangeTriggerTrapState(trapName,enable)
    local trapName="trap_border_b"--DEBUGNOW
    TppTrap.ChangeNormalTrapState(trapName,enable)
    TppTrap.ChangeTriggerTrapState(trapName,enable)
  end
}

this.disableGameOver={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}


this.enableMinimap={
  inMission=true,
  --DEBUGNOW save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function(self,setting)
    if setting==1 then
      SsdMinimap.Open()
    else
      SsdMinimap.Close()
    end
  end,
}

this.disableCommonRadio={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.avatar_enableGenderSelect={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}


this.registerMenus={
  "ssdSafeSpaceMenu",
  "ssdInMissionMenu",
}

this.ssdSafeSpaceMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "InfMainSsd.disableCommonRadio",
    "InfMainSsd.avatar_enableGenderSelect",
    "Ivars.disableGameOver",
    "Ivars.disableOutOfBoundsChecks",
  },
}

this.ssdInMissionMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "InfMainSsd.enableMinimap",
    "InfMainSsd.disableCommonRadio",
    "InfMainSsd.avatar_enableGenderSelect",
    "Ivars.disableGameOver",
    "Ivars.disableOutOfBoundsChecks",
  },
}

this.langStrings={
  eng={
    ssdInMissionMenu="Misc menu",
    ssdSafeSpaceMenu="Misc menu",
    enableMinimap="Enable minimap",
    disableCommonRadio="Disable common radio warnings",
    avatar_enableGenderSelect="Enable gender select",
    disableOutOfBoundsChecks="Disable out of bounds checks",
    disableGameOver="Disable game over",
  },
  help={
    eng={
      disableCommonRadio="Disables radio warnings by the AI about your oxygen, health etc status.",
      avatar_enableGenderSelect="Enables gender select for when using the in-base avatar editor.",
    },
  },
}

function this.OnMissionCanStart(currentChecks)
  if Ivars.disableOutOfBoundsChecks:Is(1) then
    --DEBUGNOW
    Ivars.disableOutOfBoundsChecks:OnChange(Ivars.disableOutOfBoundsChecks:Get())--DEBUGNOW
    --    mvars.mis_ignoreAlertOfMissionArea=true
    --    local trapName="trap_mission_failed_area"
    --    local enable=false
    --    TppTrap.ChangeNormalTrapState(trapName,enable)
    --    TppTrap.ChangeTriggerTrapState(trapName,enable)
  end
end

return this
