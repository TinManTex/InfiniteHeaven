-- InfReinforce.lua
local this={}

this.registerIvars={
  "forceSuperReinforce",
  "forceReinforceRequest",
  "enableHeliReinforce",
  "enableSoldiersWithVehicleReinforce",
  "disableReinforceHeliPullOut",
}

--reinforce stuff DOC: Reinforcements Soldier Vehicle Heli.txt
this.forceSuperReinforce={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings={"OFF","ON_CONFIG","FORCE_CONFIG"},
}

this.forceReinforceRequest={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.enableHeliReinforce={--tex chance of heli being chosen for a reinforce, also turns off heli quests
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnChange=function()
    InfQuest.UpdateActiveQuest()--tex update since quests may have changed
  end,
}

this.enableSoldiersWithVehicleReinforce={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.disableReinforceHeliPullOut={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

--this.currentReinforceCount={--NONUSER
--  save=IvarProc.CATEGORY_EXTERNAL,
--  range={max=100},
--}
--<

this.registerMenus={
  "enemyReinforceMenu",
}

this.enemyReinforceMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "Ivars.forceSuperReinforce",
    "Ivars.enableHeliReinforce",
    "Ivars.forceReinforceRequest",
    "Ivars.disableReinforceHeliPullOut",
    "Ivars.enableSoldiersWithVehicleReinforce",
  },
}
--< menu defs
this.langStrings={
  eng={
    enemyReinforceMenu="Enemy reinforcements menu",
    forceSuperReinforce="Vehicle reinforcements",
    forceSuperReinforceSettings={"Off","Enemy Prep","Force Prep"},
    forceReinforceRequest="Force reinforce request for heli",
    enableHeliReinforce="Force enable enemy heli reinforce (disable heli sideops)",
    disableReinforceHeliPullOut="Disable reinforce heli pull-out",
    enableSoldiersWithVehicleReinforce="Soldier reinforce with all vehicle reinforce types",
  },
  help={
    eng={
      forceSuperReinforce="In the normal game vehicle reinforcments through this system is only used for two missions, this enables it for more. Only heli will appear in free roam, vehicles depend on mission.",
      enableSoldiersWithVehicleReinforce="Allows an extra set of reinforce soldiers with all vehicle reinforce types instead of just Wheeled Armored Vehicles.",

    },
  }
}
--<

return this
