-- InfRevengeIvars.lua
local this={}

-->
this.registerIvars={
  'revengeBlockForMissionCount',
  'disableNoRevengeMissions',
  'disableNoStealthCombatRevengeMission',
  'applyPowersToLrrp',
  'applyPowersToOuterBase',
  'allowHeadGearCombo',
  'allowMissileWeaponsCombo',
  'balanceHeadGear',
  'balanceWeaponPowers',
  'disableConvertArmorToShield',
  'disableMissionsWeaponRestriction',
  'disableMotherbaseWeaponRestriction',
  'enableMgVsShotgunVariation',
  'randomizeSmallCpPowers',
}

IvarProc.MissionModeIvars(
  this,
  "revengeMode",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    settings={"DEFAULT","CUSTOM","NONDEFAULT"},
    settingNames="revengeModeSettings",
    OnChange=function()
      TppRevenge._SetUiParameters()
    end,
  },
  {
    "FREE",
    "MISSION",
    "MB_ALL",
  }
)

this.revengeModeMB_ALL.settings={"OFF","FOB","DEFAULT","CUSTOM","NONDEFAULT"}--DEFAULT = normal enemy prep system (which isn't usually used for MB)
this.revengeModeMB_ALL.settingNames="revengeModeMBSettings"

this.revengeBlockForMissionCount={
  save=IvarProc.CATEGORY_EXTERNAL,
  default=3,
  range={max=10},
}

this.disableNoRevengeMissions={--WIP
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.disableNoStealthCombatRevengeMission={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.applyPowersToLrrp={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.applyPowersToOuterBase={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}


IvarProc.MissionModeIvars(
  this,
  "allowHeavyArmor",
  {
    save=IvarProc.CATEGORY_EXTERNAL,
    range=Ivars.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MISSION",}
)

--WIP TODO either I got rid of this functionality at some point or I never implemented it (I could have sworn I did though)
--this.allowLrrpArmorInFree={
--  save=IvarProc.CATEGORY_EXTERNAL,
--  range=Ivars.switchRange,
--  settingNames="set_switch",
--}

this.allowHeadGearCombo={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  allowHeadGearComboThreshold=120,
}

this.allowMissileWeaponsCombo={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.balanceHeadGear={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  balanceHeadGearThreshold=100,
}

this.balanceWeaponPowers={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  balanceWeaponsThreshold=100,
}

this.disableConvertArmorToShield={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.disableMissionsWeaponRestriction={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.disableMotherbaseWeaponRestriction={--WIP
  --OFF WIP save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.enableMgVsShotgunVariation={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.randomizeSmallCpPowers={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

--CULL
IvarProc.MissionModeIvars(
  this,
  "enableDDEquip",
  {
    --OFF save=IvarProc.CATEGORY_EXTERNAL,--
    nonConfig=true,--
    range=Ivars.switchRange,
    settingNames="set_switch",
  },
  {
    "FREE",
    "MISSION",
    "MB_ALL",
  }
)

--custom revenge config --DEBUGNOW
function this.SetPercentagePowersRange(min,max)
  for n,powerTableName in ipairs(this.percentagePowerTables)do
    local powerTable=this[powerTableName]
    for m,powerType in ipairs(powerTable)do
      this.SetMinMax(powerType,min,max)
    end
  end
end

function this.SetMinMax(baseName,min,max)
  local ivarMin=this[baseName.."_MIN"]
  local ivarMax=this[baseName.."_MAX"]
  if ivarMin==nil or ivarMax==nil then
    InfCore.DebugPrint("SetMinMax: could not find ivar for "..baseName)
    return
  end
  ivarMin:Set(min)
  ivarMax:Set(max)
end

this.revengePowerRange={max=100,min=0,increment=10}

this.weaponPowers={
  "SNIPER",
  "MISSILE",
  "MG",
  "SHOTGUN",
  "SMG",
  "ASSAULT",
  "GUN_LIGHT",--tex kind of an odd one out
}

this.armorPowers={
  "ARMOR",
  "SOFT_ARMOR",
  "SHIELD",
}
this.gearPowers={
  "HELMET",
  "NVG",
  "GAS_MASK",
}
this.cpEquipPowers={
  "DECOY",
  "MINE",
  "CAMERA",
}

this.percentagePowerTables={
  "weaponPowers",
  "armorPowers",
  "gearPowers",
  "cpEquipPowers",
}

--

local function OnChangeCustomRevengeMin(self)
  IvarProc.PushMax(self)
  InfRevenge.SetCustomRevengeUiParameters()
end
local function OnChangeCustomeRevengeMax(self)
  IvarProc.PushMin(self)
  InfRevenge.SetCustomRevengeUiParameters()
end

for n,powerTableName in ipairs(this.percentagePowerTables)do
  local powerTable=this[powerTableName]
  for m,powerType in ipairs(powerTable)do
    IvarProc.MinMaxIvar(
      this,
      powerType,
      {
        default=0,
        OnChange=OnChangeCustomRevengeMin,
      },
      {
        default=100,
        OnChange=OnChangeCustomeRevengeMax,
      },
      {
        range=this.revengePowerRange,
        isPercent=true,
        powerType=powerType,
      }
    )
  end
end

this.abiltiyLevels={
  "NONE",
  "LOW",
  "HIGH",
  "SPECIAL",
}

this.abilitiesWithLevels={
  "STEALTH",
  "COMBAT",
  "HOLDUP",
  "FULTON",
}

for n,powerType in ipairs(this.abilitiesWithLevels)do
  IvarProc.MinMaxIvar(
    this,
    powerType,
    {
      default=0,
      OnChange=OnChangeCustomRevengeMin,
    },
    {
      default=3,--SPECIAL
      OnChange=OnChangeCustomeRevengeMax,
    },
    {
      settings=this.abiltiyLevels,
      powerType=powerType,
    }
  )
end

this.weaponStrengthPowers={--tex bools
  "STRONG_WEAPON",
  "STRONG_SNIPER",
  "STRONG_MISSILE",
}

for n,powerType in ipairs(this.weaponStrengthPowers)do
  IvarProc.MinMaxIvar(
    this,
    powerType,
    {
      default=0,
      OnChange=OnChangeCustomRevengeMin,
    },
    {
      default=1,
      OnChange=OnChangeCustomeRevengeMax,
    },
    {
      range=Ivars.switchRange,
      settingNames="set_switch",
      powerType=powerType,
    }
  )
end

this.cpEquipBoolPowers={
  "ACTIVE_DECOY",--tex doesn't actually seem to work
  "GUN_CAMERA",--tex dont think there are any cams in free mode?
}

for n,powerType in ipairs(this.cpEquipBoolPowers)do
  IvarProc.MinMaxIvar(
    this,
    powerType,
    {
      default=0,
      OnChange=OnChangeCustomRevengeMin,
    },
    {
      default=1,
      OnChange=OnChangeCustomeRevengeMax,
    },
    {
      range=Ivars.switchRange,
      settingNames="set_switch",
      powerType=powerType,
    }
  )
end

this.moreAbilities={
  "STRONG_NOTICE_TRANQ",--tex TODO: unused?
}

this.boolPowers={
  "STRONG_PATROL",--tex appears un-used
}

--
local reinforceLevelSettings={
  "NONE",--tex aka no flag
  "SUPER_REINFORCE",
  "BLACK_SUPER_REINFORCE",
}
IvarProc.MinMaxIvar(
  this,
  "reinforceLevel",
  {
    default=0,
    OnChange=OnChangeCustomRevengeMin
  },
  {
    default=2,--BLACK_SUPER_REINFORCE
    OnChange=OnChangeCustomeRevengeMax
  },
  {
    settings=reinforceLevelSettings,
  }
)

IvarProc.MinMaxIvar(
  this,
  "reinforceCount",
  {default=1,OnChange=OnChangeCustomRevengeMin},
  {default=5,OnChange=OnChangeCustomeRevengeMax},
  {
    range={max=99,min=1},
  }
)

IvarProc.MinMaxIvar(
  this,
  "revengeIgnoreBlocked",
  {default=0,OnChange=OnChangeCustomRevengeMin},
  {default=0,OnChange=OnChangeCustomeRevengeMax},
  {
    range=Ivars.switchRange,
    settingNames="set_switch",
  }
)
--<custom revenge config
--< ivar defs

-->
this.registerMenus={
  'revengeMenu',
  'revengeSystemMenu',
  'revengeCustomMenu',
}

this.revengeMenu={
  --WIP parentRefs={"InfMenuDefs.heliSpaceMenu"},
  options={
    "Ivars.revengeModeFREE",
    "Ivars.revengeModeMISSION",
    "Ivars.revengeModeMB_ALL",
    "InfRevengeIvars.revengeCustomMenu",
    "InfRevengeIvars.revengeSystemMenu",
    "InfEquip.customEquipMenu",
    "Ivars.customSoldierTypeFREE",
    "InfMenuCommandsTpp.ResetRevenge",
    "InfMenuCommandsTpp.DEBUG_PrintRevengePoints",
    "Ivars.changeCpSubTypeFREE",
    "Ivars.changeCpSubTypeMISSION",
    "Ivars.enableInfInterrogation",
  }
}

this.revengeSystemMenu={
  options={
    "Ivars.revengeBlockForMissionCount",
    "Ivars.applyPowersToOuterBase",
    "Ivars.applyPowersToLrrp",
    "Ivars.allowHeavyArmorFREE",
    "Ivars.allowHeavyArmorMISSION",
    "Ivars.disableMissionsWeaponRestriction",
    "Ivars.disableNoStealthCombatRevengeMission",
    "Ivars.revengeDecayOnLongMbVisit",
    --"Ivars.disableMotherbaseWeaponRestriction",--WIP TODO
    "Ivars.allowHeadGearCombo",
    "Ivars.balanceHeadGear",
    "Ivars.allowMissileWeaponsCombo",
    "Ivars.enableMgVsShotgunVariation",
    "Ivars.randomizeSmallCpPowers",
    "Ivars.disableConvertArmorToShield",
    --"Ivars.balanceWeaponPowers",--WIP
    "Ivars.randomizeMineTypes",
    "Ivars.additionalMineFields",
  }
}

--
--GENERATED
this.revengeCustomMenu={
  options={
    "InfMenuCommandsTpp.PrintCustomRevengeConfig",
  }
}

function this.GenerateMenus()
  local minSuffix="_MIN"
  local maxSuffix="_MAX"
  local menuSuffix="Menu"
  local function AddMinMaxIvarsListMenu(moduleName,menuName,ivarList)
    local newMenu={
      options={
      }
    }

    local menuOptions=newMenu.options
    for i,ivarName in ipairs(ivarList)do
      menuOptions[#menuOptions+1]="Ivars."..ivarName..minSuffix
      menuOptions[#menuOptions+1]="Ivars."..ivarName..maxSuffix
    end

    InfMenuDefs[menuName..menuSuffix]=newMenu--tex add to InfMenuDefs
  end

  local moduleName="InfMenuDefs"

  for n,powerTableName in ipairs(InfRevengeIvars.percentagePowerTables)do
    AddMinMaxIvarsListMenu(moduleName,powerTableName,InfRevengeIvars[powerTableName])
  end

  AddMinMaxIvarsListMenu(moduleName,"abilityCustom",InfRevengeIvars.abilitiesWithLevels)
  AddMinMaxIvarsListMenu(moduleName,"weaponStrengthCustom",InfRevengeIvars.weaponStrengthPowers)
  AddMinMaxIvarsListMenu(moduleName,"cpEquipBoolPowers",InfRevengeIvars.cpEquipBoolPowers)

  ---
  this.revengeCustomMenu={
    options={
      "InfMenuCommandsTpp.PrintCustomRevengeConfig",
    }
  }

  local revengeMenu=this.revengeCustomMenu.options
  for n,powerTableName in ipairs(InfRevengeIvars.percentagePowerTables)do
    revengeMenu[#revengeMenu+1]="InfMenuDefs."..powerTableName..menuSuffix
  end
  table.insert(revengeMenu,moduleName..".abilityCustomMenu")
  table.insert(revengeMenu,moduleName..".weaponStrengthCustomMenu")
  table.insert(revengeMenu,moduleName..".cpEquipBoolPowersMenu")
  local revengeMinMaxIvarList={
    "reinforceCount",
    "reinforceLevel",
    "revengeIgnoreBlocked",
  }
  local menuOptions=revengeMenu
  for i,ivarName in ipairs(revengeMinMaxIvarList)do
    menuOptions[#menuOptions+1]="Ivars."..ivarName..minSuffix
    menuOptions[#menuOptions+1]="Ivars."..ivarName..maxSuffix
  end
end
--< menu defs
this.langStrings={
  eng={
    revengeMenu="Enemy Prep menu",
    revengeCustomMenu="Custom prep menu",--r117
    revengeSystemMenu="Prep system menu",
    revengeModeFREE="Free roam prep mode",
    revengeModeMISSION="Missions prep mode",
    revengeModeMB_ALL="Mother base prep mode",
    revengeModeSettings={"Enemy prep levels","Custom prep","Prep levels + Custom overrides"},
    revengeModeMB_ALLSettings={"Off","FOB style","Enemy prep levels","Custom prep","Prep levels + Custom overrides"},
    resetRevenge="Reset enemy preparedness levels",
    revenge_reset="Enemy prep levels reset",
    revengeBlockForMissionCount="Resupply in #missions",
    revengeProfile="Enemy prep system profile",
    printCustomRevengeConfig="Print example current config (look in iDroid Log>All tab)",
    dEBUG_PrintRevengePoints="Print enemy prep levels",
    applyPowersToOuterBase="Apply enemy prep to guard posts",
    applyPowersToLrrp="Apply enemy prep to patrol soldiers",
    allowHeavyArmorFREE="Allow heavy armor in free roam (may have issues)",
    allowHeavyArmorMISSION="Allow heavy armor in all missions (may have issues)",
    disableMissionsWeaponRestriction="Disable weapon restrictions in certain missions",
    disableNoStealthCombatRevengeMission="Allow Enemy Prep change from free roam",
    allowHeadGearCombo="Allow helmet and NVG or Gas mask combo",
    balanceHeadGear="Ballance heavy armor and head gear distribution",
    balanceWeaponPowers="Balance primary weapon distribution",
    allowMissileWeaponsCombo="Allow missile combo with other weapons",
    disableConvertArmorToShield="Disable convert armor to shield (if armor off)",
    enableMgVsShotgunVariation="Mg vs Shotgun variation",
    randomizeSmallCpPowers="Balance small CPs",
    weaponPowersMenu="Weapon deployment",
    armorPowersMenu="Armor deployment",
    gearPowersMenu="Headgear deployment",
    cpEquipPowersMenu="CP deterrent deployment",
    abilityCustomMenu="Soldier abilities",
    reinforceLevel_MIN="Vehicle reinforcement level min",
    reinforceLevel_MAX="Vehicle reinforcement level max",
    revengeIgnoreBlocked_MIN="Ignore combat-deploy supply blocks min",
    revengeIgnoreBlocked_MAX="Ignore combat-deploy supply blocks max",
    reinforceCount_MIN="Reinforce calls min",
    reinforceCount_MAX="Reinforce calls max",
    weaponStrengthCustomMenu="Weapon strength menu",
    cpEquipBoolPowersMenu="CP equip strength menu",
  },
  help={
    eng={
      revengeMenu="Ways to modify the Enemy preparedness system that equips the enemy in response to your actions.",
      revengeCustomMenu="Lets you set the individual values that go into an enemy prep configuration (does not use the enemy prep levels), a random value between MIN and MAX for each setting is chosen on mission start. The order of items in the menu is generally order the equipment is allocated to each soldier in a CP.",
      revengeModeFREE="Enemy prep levels - the normal games enemy prep levels, Custom prep - uses all the settings in the Custom prep menu, Prep levels + Custom overrides - overrides the Enemy prep levels config with any Custom prep settings that aren't set to their default setting.",
      revengeBlockForMissionCount="The number of missions the enemy dispatch/resupply with unlock after your last successful dispatch mission for that type.",
      disableMissionsWeaponRestriction="Missions 2, 12, 13, 16, 26, 31 normally prevent the application of shields, missiles, shotguns and MGs to the general CP enemy prep (though some may have custom enemy prep).",
      disableNoStealthCombatRevengeMission="By default enemy prep only changes in response to actual missions, this option allows enemy prep changes to be applied after leaving Free roam (but not via abort)",
      resetRevenge="Resets enemy prep levels to 0",
      weaponStrengthCustomMenu="Whether to deploy the stronger weapon class for the weapon type",
      enableMgVsShotgunVariation="In the default game the enemy prep config chooses randomly either MG or Shotguns which is applied for all CPs in the whole mission. This setting allows mixed MGs and Shotguns (but still with the enemy prep total) and also applies them per CP.",--r113
      allowMissileWeaponsCombo="In the default game soldiers with missiles only have SMGs, this allows them to have MGs, shotguns or assault rifles assigned to them.",
      randomizeSmallCpPowers="Adds limits and some randomisation to small cp/lrrps enemy prep application",
      disableConvertArmorToShield="Where heavy armor is disabled (free roam by default) the normal game converts armor to shields in addition to the normal shield application, this often leads to it feeling like there's just too many.",
      balanceHeadGear="Adjusts application percentages of the normally mutally exclusive options of heavy armor and the different headgear pieces, not nessesary if Allow helmet and NVG or Gas mask combo option is on",
      reinforceCount_MIN="Number of reinforcement calls a CP has.",
      reinforceCount_MAX="Number of reinforcement calls a CP has.",
      revengeIgnoreBlocked_MIN="Ignores the current results of the Combat Deployment/Dispatch/'cut off the supply' missions that affect enemy prep.",
      STEALTH_MIN="Adjusts enemy soldiers notice,cure,reflex and speed ablilities.",
      COMBAT_MIN="Adjusts enemy soldiers shot,grenade,reload,hp and speed abilities.",
    },
  },
}
--< lang strings

return this
