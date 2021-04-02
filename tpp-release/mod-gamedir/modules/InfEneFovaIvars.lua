-- InfEneFova.lua
local this={}

-->
this.registerIvars={
  "mbDDHeadGear",
}

IvarProc.MissionModeIvars(
  this,
  "customSoldierType",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    settings={"NONE"},--DYNAMIC via addon
    OnSelect=function(self)
      self.settings=InfBodyInfo.bodies.MALE
      IvarProc.SetMaxToList(self,self.settings)
    end,
    GetSettingText=function(self,setting)
      local bodyType=self.settings[setting+1]
      return InfBodyInfo.bodyInfo[bodyType].description or bodyType
    end,
  },
  {
    "FREE",
    --"MISSION",--TODO: missions a bit more complicated with a bunch of specific body setup
    "MB_ALL",
  }
)

IvarProc.MissionModeIvars(
  this,
  "customSoldierTypeFemale",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    settings={"NONE"},--DYNAMIC via addon
    OnSelect=function(self)
      self.settings=InfBodyInfo.bodies.FEMALE
      IvarProc.SetMaxToList(self,self.settings)
    end,
    GetSettingText=function(self,setting)
      local bodyType=self.settings[setting+1]
      return InfBodyInfo.bodyInfo[bodyType].description or bodyType
    end,
  },
  {
    --"FREE",
    --"MISSION",--TODO: missions a bit more complicated with a bunch of specific body setup
    "MB_ALL",
  }
)

this.mbDDHeadGear={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  MissionCheck=IvarProc.MissionCheckMbAll,
}
--< ivar defs
this.langStrings={
  eng={
    mbDDHeadGear="DD Head gear",
    mbDDHeadGearSettings={"Off","Current prep"},
    customSoldierTypeFREE="Custom soldier type in Free roam",
    customSoldierTypeMB_ALL="DD Suit",
    customSoldierTypeFemaleMB_ALL="DD Suit female",
    setting_only_for_dd="This setting is only for DD soliders",
  },
  help={
    eng={
      customSoldierTypeFREE="Override the soldier type of enemy soldiers in Free Roam.\nNew soldier types can be added via the bodyInfo addon system.",
      customSoldierTypeMB_ALL="New body types can be added via the bodyInfo addon system.",
      customSoldierTypeFemaleMB_ALL="New body types can be added via the bodyInfo addon system.",
    },
  }
}
--< lang strings

return this
