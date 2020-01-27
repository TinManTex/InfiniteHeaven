-- Ivars.lua
--tex Ivar system
--combines gvar setup, enums, functions per setting in one ungodly mess.
--lots of shortcuts/ivar setup depending-on defined values is done in various Table setups at end of file.
--Currently tied to gvars, so keep save setting commented out if editing module at runtime
local this={}
--NOTE: Resetsettings will call OnChange, so/and make sure defaults are actual default game behaviour,
--in general this means all stuff should have a 0 that at least does nothing,
--dont let the lure of nice straight setting>game value lure you, just -1 it
--LOCALOPT:
local Ivars=this
local IsString=Tpp.IsTypeString
local IsNumber=Tpp.IsTypeNumber
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum

local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId

local GLOBAL=TppScriptVars.CATEGORY_GAME_GLOBAL
local MISSION=TppScriptVars.CATEGORY_MISSION
local RETRY=TppScriptVars.CATEGORY_RETRY
local MB_MANAGEMENT=TppScriptVars.CATEGORY_MB_MANAGEMENT
local QUEST=TppScriptVars.CATEGORY_QUEST
local CONFIG=TppScriptVars.CATEGORY_CONFIG
local RESTARTABLE=TppDefine.CATEGORY_MISSION_RESTARTABLE
local PERSONAL=TppScriptVars.CATEGORY_PERSONAL

local int8=256
local int16=2^16
local int32=2^32

this.numQuests=157--tex SYNC: number of quests
this.MAX_SOLDIER_STATE_COUNT = 360--tex from <mission>_enemy.lua, free missions/whatever was highest

this.switchRange={max=1,min=0,increment=1}

this.switchSettings={"OFF","ON"}
this.simpleProfileSettings={"DEFAULT","CUSTOM"}

--tex set via IvarsProc.MissionModeIvars, used by IsForMission,EnabledForMission
this.missionModeIvars={}

this.updateIvars={}

this.profiles={}
this.savedProfiles={}

--ivar definitions
--tex NOTE: should be mindful of max setting for save vars,
--currently the ivar setup fits to the nearest save size type and I'm not sure of behaviour when you change ivars max enough to have it shift save size and load a game with an already saved var of different size
this.debugMode={
  nonConfig=true,
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
  -- CULL settings={"OFF","NORMAL","BLANK_LOADING_SCREEN"},
  allowFob=true,
}

this.printPressedButtons={
  range=this.switchRange,
  settingNames="set_switch",
}

this.printOnBlockChange={
  range=this.switchRange,
  settingNames="set_switch",
}


--this.disableEquipOnMenu={
--  save=MISSION,
--  default=1,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

--parameters
--tex DEBUGNOW TODO: shift to simply being an allow-original soldier params/mods
this.soldierParamsProfile={
  save=GLOBAL,--tex global since user still has to restart to get default/modded/reset
  --range=this.switchRange,
  settings={"DEFAULT","CUSTOM"},
  settingNames="soldierParamsProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.soldierSightDistScale:Set(100,true)
      Ivars.soldierNightSightDistScale:Set(100,true)
      Ivars.soldierHearingDistScale:Set(100,true)
      Ivars.soldierHealthScale:Set(100,true)
      TppSoldier2.ReloadSoldier2ParameterTables(InfSoldierParams.soldierParametersDefaults)
    end,
    CUSTOM=nil,
  },
  OnChange=IvarProc.RunCurrentSetting,
  OnSubSettingChanged=IvarProc.OnSubSettingChanged,
}

--enemy parameters sight
this.sightScaleRange={max=400,min=0,increment=5}

this.soldierSightDistScale={
  save=MISSION,
  default=100,
  range=this.sightScaleRange,
  isPercent=true,
  profile=this.soldierParamsProfile,
}

this.soldierNightSightDistScale={
  save=MISSION,
  default=100,
  range=this.sightScaleRange,
  isPercent=true,
  profile=this.soldierParamsProfile,
}

this.soldierHearingDistScale={
  save=MISSION,
  default=100,
  range={max=400,min=0,increment=5},
  isPercent=true,
  profile=this.soldierParamsProfile,
}


--this.sightForms={
--  "contactSightForm",
--  "normalSightForm",
--  "farSightForm",
--  "searchLightSightForm",
--  "observeSightForm",
--}
--
--this.sightTypeNames={
--  "baseSight",
--  "nightSight",
--  "combatSight",
--  "walkerGearSight",
--  "observeSight",
--  "snipingSight",
--  "searchLightSight",
--  "armoredVehicleSight",
--  "zombieSight",
--  "msfSight",
--  "vehicleSight",
--}
--
--this.sightFormNames={
--  "discovery",
--  "indis",
--  "dim",
--  "far",
--  "observe",
--}
--
--this.sightIvarLists={
--  "sightForms",
--  "sightTypeNames",
--  "sightFormNames",
--}
--
--this.sightDistScaleName="DistScaleSightParam"
--for n,listName in ipairs(this.sightIvarLists) do
--  for i,name in ipairs(this[listName]) do
--    local ivarName=name..this.sightDistScaleName
--    local ivar={
--      save=MISSION,
--      default=1,
--      range=this.sightScaleRange,
--    }
--    this[ivarName]=ivar
--  end
--end
--
this.healthScaleRange={max=900,min=0,increment=20}
this.soldierHealthScale={
  save=MISSION,
  default=100,
  range=this.healthScaleRange,
  isPercent=true,
  profile=this.soldierParamsProfile,
}
---end soldier params
this.playerHealthScale={
  save=MISSION,
  default=100,
  range={max=650,min=0,increment=20},--tex GOTCHA overflows around 760 when medical arm 3 is equipped
  isPercent=true,
  OnChange=function(self)
    if mvars.mis_missionStateIsNotInGame then
      return
    end
    InfMain.ChangeMaxLife(true)
  end,
}
--custom weapon table
IvarProc.MissionModeIvars(
  this,
  "customWeaponTable",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MISSION","MB_ALL",}
)
this.weaponTableStrength={
  save=MISSION,
  settings={"NORMAL","STRONG","COMBINED"},
  settingNames="weaponTableStrengthSettings",
}
this.weaponTableAfgh={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
this.weaponTableMafr={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
this.weaponTableSkull={--xof
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
this.weaponTableDD={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--motherbase>
--tex used for customWeaponIdTable
--TODO BREAKOUT these are enabled by Ivar enableDDEquip > InfMain. IsDDEquip
IvarProc.MinMaxIvar(
  this,
  "soldierEquipGrade",
  {default=3},--tex 3 is the min grade at which all weapon types are available
  {default=15},
  {
    range={min=1,max=15}
  }
)

this.allowUndevelopedDDEquip={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbSoldierEquipRange={
  save=MISSION,
  settings={"SHORT","MEDIUM","LONG","RANDOM"},
  settingNames="set_dd_equip_range",
}

this.mbDDEquipNonLethal={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMbAll,
}

this.mbDDSuit={
  save=MISSION,
  settings={
    "OFF",
    "EQUIPGRADE",
    "DRAB",
    "TIGER",
    "SNEAKING_SUIT",
    "BATTLE_DRESS",
    "SWIMWEAR",
    "PFA_ARMOR",
    "XOF",
    "SOVIET_A",
    "SOVIET_B",
    "PF_A",
    "PF_B",
    "PF_C",
    "SOVIET_BERETS",
    "SOVIET_HOODIES",
    "SOVIET_ALL",
    "PF_MISC",
    "PF_ALL",
    --OFF "MSF_SVS",
    "MSF_PFS",
  --"GZ",
  --"PRISONER_AFGH",
  --"PRISONER_MAFR",
  --"SKULLFACE",
  --"HUEY",
  --"KAZ",
  --"KAZ_GZ",
  --"DOCTOR",
  },
  settingNames="mbDDSuitSettings",
}

this.mbDDSuitFemale={
  save=MISSION,
  settings={
    "EQUIPGRADE",
    "DRAB_FEMALE",
    "TIGER_FEMALE",
    "SNEAKING_SUIT_FEMALE",
    "BATTLE_DRESS_FEMALE",
    "SWIMWEAR_FEMALE",
  --    "PRISONER_AFGH_FEMALE",
  --    "NURSE_FEMALE",
  },
  settingNames="mbDDSuitFemaleSettings",
}

this.mbDDHeadGear={
  save=MISSION,
  range=this.switchRange,
  settingNames="mbDDHeadGearSettings",
  MissionCheck=IvarProc.MissionCheckMbAll,
}

this.mbWarGamesProfile={
  save=MISSION,
  settings={"OFF","TRAINING","INVASION","ZOMBIE_DD","ZOMBIE_OBLITERATION"},
  settingNames="mbWarGamesProfileSettings",
  settingsTable={
    OFF=function()
      Ivars.mbDDEquipNonLethal:Set(0,true)
      Ivars.mbHostileSoldiers:Set(0,true)
      --CULL Ivars.mbEnableLethalActions:Set(0,true)
      Ivars.mbNonStaff:Set(0,true)
      Ivars.mbEnableFultonAddStaff:Set(0,true)
      Ivars.mbZombies:Set(0,true)
      Ivars.mbEnemyHeli:Set(0,true)
    end,
    TRAINING=function()
      --Ivars.mbDDEquipNonLethal:Set(0,true)--tex allow user setting
      Ivars.mbHostileSoldiers:Set(1,true)
      --CULL Ivars.mbEnableLethalActions:Set(0,true)
      Ivars.mbNonStaff:Set(0,true)
      Ivars.mbEnableFultonAddStaff:Set(0,true)
      Ivars.mbZombies:Set(0,true)
      Ivars.mbEnemyHeli:Set(0,true)
    end,
    INVASION=function()
      Ivars.mbDDEquipNonLethal:Set(0,true)
      Ivars.mbHostileSoldiers:Set(1,true)
      Ivars.mbEnableLethalActions:Set(1,true)
      Ivars.mbNonStaff:Set(1,true)
      Ivars.mbEnableFultonAddStaff:Set(1,true)
      Ivars.mbZombies:Set(0,true)
      Ivars.mbEnemyHeli:Set(1,true)
    end,
    ZOMBIE_DD=function()
      Ivars.mbDDEquipNonLethal:Set(0,true)--tex n/a
      Ivars.mbHostileSoldiers:Set(1,true)
      --CULL Ivars.mbEnableLethalActions:Set(0,true)
      Ivars.mbNonStaff:Set(0,true)
      Ivars.mbEnableFultonAddStaff:Set(0,true)
      Ivars.mbZombies:Set(1,true)
      Ivars.mbEnemyHeli:Set(0,true)
    end,
    ZOMBIE_OBLITERATION=function()
      Ivars.mbDDEquipNonLethal:Set(0,true)
      Ivars.mbHostileSoldiers:Set(1,true)
      Ivars.mbEnableLethalActions:Set(1,true)
      Ivars.mbNonStaff:Set(1,true)
      Ivars.mbEnableFultonAddStaff:Set(0,true)
      Ivars.mbZombies:Set(1,true)
      Ivars.mbEnemyHeli:Set(0,true)
    end,
  --CUSTOM=nil,
  },
  OnChange=IvarProc.RunCurrentSetting,
  OnSubSettingChanged=IvarProc.OnSubSettingChanged,
}

this.mbWargameFemales={
  save=MISSION,
  range={min=0,max=100,increment=10},
  isPercent=true,
}

this.mbAdditionalSoldiers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbNpcRouteChange={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnableLethalActions={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--NONUSER/ handled by profile>
this.mbHostileSoldiers={
  nonUser=true,
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbNonStaff={--tex also disables negative ogre on kill
  nonUser=true,
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbZombies={
  nonUser=true,
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnemyHeli={
  nonUser=true,
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,
}
--< NONUSER

this.mbqfEnableSoldiers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnemyHeliColor={
  save=MISSION,
  settings={"DEFAULT","BLACK","RED","RANDOM","RANDOM_EACH","ENEMY_PREP"},
  settingNames="mbEnemyHeliColorSettings",
}

this.mbEnableFultonAddStaff={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--
this.mbEnableBuddies={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbPrioritizeFemale={
  save=MISSION,
  settings={"OFF","DISABLE","MAX"},
  settingNames="mbPrioritizeFemaleSettings",
}
--<motherbase

--demos
this.useSoldierForDemos={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
this.mbDemoSelection={
  save=MISSION,
  settings={"DEFAULT","PLAY","DISABLED"},
  settingNames="set_mbDemoSelection",
}
this.mbSelectedDemo={
  save=MISSION,
  range={max=#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST-1},
  settingNames=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST,
}

this.mbDemoOverrideTime={
  save=MISSION,
  settings={"DEFAULT","CURRENT","CUSTOM"},
  settingNames="mbDemoOverrideTimeSettings",
}

this.mbDemoHour={
  save=MISSION,
  range={min=0,max=23},
}

this.mbDemoMinute={
  save=MISSION,
  range={min=0,max=59},
}

this.mbDemoOverrideWeather={
  save=MISSION,
  settings={"DEFAULT","CURRENT","SUNNY","CLOUDY","RAINY","SANDSTORM","FOGGY","POURING"},
  settingNames="mbDemoOverrideWeatherSettings",
}


--patchup
this.langOverride={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_lang_override",
  allowFob=true,
}

this.startOffline={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.blockFobTutorial={
  --OFF save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.setFirstFobBuilt={
  --OFF save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableLzs={
  save=MISSION,
  settings={"OFF","ASSAULT","REGULAR"},
  settingNames="disableLzsSettings",
}

this.disableHeliAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local enable=self.setting==0
    local gameObjectId = GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetCombatEnabled",enabled=enable})
    end
  end,
}

--spysearch
local function RequireRestartMessage(self)
  --if self.setting==1 then
  local settingName = self.description or InfMenu.LangString(self.name)
  InfMenu.Print(settingName..InfMenu.LangString"restart_required")
  --end
end
--tex not happy with the lack of flexibility as GetLocationParameter is only read once on init,
--now just bypassing on trap enter/exit, doesnt give control of search type though
this.disableSpySearch={
  --OFF save=GLOBAL,--CULL
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
--CULL OnChange=RequireRestartMessage,
}
this.disableHerbSearch={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=RequireRestartMessage,
}

--mission prep

--tex also TppBuddyService.SetDisableAllBuddy
this.disableSelectBuddy={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableSelectTime={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableSelectVehicle={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableHeadMarkers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if self.setting==1 then
      TppUiStatusManager.SetStatus("HeadMarker","INVALID")
    else
      TppUiStatusManager.ClearStatus("HeadMarker")
    end
  end,
}

this.disableWorldMarkers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if self.setting==1 then
      TppUiStatusManager.SetStatus("WorldMarker","INVALID")
    else
      TppUiStatusManager.ClearStatus("WorldMarker")
    end
  end,
}

this.disableXrayMarkers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    local enabled=self.setting==1
    TppSoldier2.SetDisableMarkerModelEffect{enabled=enabled}
  end,
}

this.disableFulton={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.dontOverrideFreeLoadout={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--tex TODO: RENAME RETRY this is OSP shiz
local ospSlotClearSettings={
  "OFF",
  "EQUIP_NONE",
}
this.clearItems={
  save=MISSION,
  settings=ospSlotClearSettings,
  settingNames="set_switch",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={"EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None"},
  },
  GetTable=IvarProc.ReturnCurrent,
}

this.clearSupportItems={
  save=MISSION,
  settings=ospSlotClearSettings,
  settingNames="set_switch",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}},
  },
  GetTable=IvarProc.ReturnCurrent,
}

this.setSubsistenceSuit={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.setDefaultHand={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableMenuDrop={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_DROP,
}
this.disableMenuBuddy={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_BUDDY,
}
this.disableMenuAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_ATTACK,
}
this.disableMenuHeliAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_HELI_ATTACK,
}
this.disableMenuIvars={
  this.disableMenuDrop,
  this.disableMenuBuddy,
  this.disableMenuAttack,
  this.disableMenuHeliAttack,
}

this.disableSupportMenu={--tex doesnt use dvcmenu, RESEARCH, not sure actually what it is
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.abortMenuItemControl={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableRetry={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.gameOverOnDiscovery={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--tex no go
this.disableTranslators={
  --OFF save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if self.setting==1 then
      InfLog.DebugPrint"removing tranlatable"--DEBUG
      vars.isRussianTranslatable=0
      vars.isAfrikaansTranslatable=0
      vars.isKikongoTranslatable=0
      vars.isPashtoTranslatable=0
    elseif self.setting==0 then
      InfLog.DebugPrint"adding tranlatable"--DEBUG
      --tex don't really need to do this, is handled by TppQuest.AcquireKeyItemOnMissionStart
      if TppQuest.IsCleard"ruins_q19010"then
        vars.isRussianTranslatable=1
      end
      if TppQuest.IsCleard"outland_q19011"then
        vars.isAfrikaansTranslatable=1
      end
      if TppQuest.IsCleard"hill_q19012"then
        vars.isKikongoTranslatable=1
      end
      if TppQuest.IsCleard"commFacility_q19013"then
        vars.isPashtoTranslatable=1
      end
    end
  end,
}


--fulton success>
--this.fultonSoldierVariationRange={--WIP
--  save=MISSION,
--  default=0,
--  range={max=100,min=0,increment=1},
--}
--this.fultonOtherVariationRange={
--  save=MISSION,
--  default=0,
--  range={max=100,min=0,increment=1},
--}
--
--this.fultonVariationInvRate={
--  save=MISSION,
--  range={max=500,min=10,increment=10},
--}

this.fultonNoMbSupport={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnSelect=function()
    local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
    local mbSectionSuccess=TppPlayer.mbSectionRankSuccessTable[mbFultonRank]or 0
    InfMenu.Print(InfMenu.LangString"fulton_mb_support"..":"..mbSectionSuccess)
  end,
}
this.fultonNoMbMedical={--NOTE: does not rely on fulton profile
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnSelect=function()
    local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}
    local mbSectionSuccess=TppPlayer.mbSectionRankSuccessTable[mbFultonRank]or 0
    InfMenu.Print(InfMenu.LangString"fulton_mb_medical"..":"..mbSectionSuccess)
  end,
}

this.fultonDyingPenalty={
  save=MISSION,
  default=70,
  range={max=100,min=0,increment=5},
}

this.fultonSleepPenalty={
  save=MISSION,
  default=0,
  range={max=100,min=0,increment=5},
}

this.fultonHoldupPenalty={
  save=MISSION,
  default=10,
  range={max=100,min=0,increment=5},
}

this.fultonDontApplyMbMedicalToSleep={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.fultonHostageHandling={
  save=MISSION,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}

this.fultonWildCardHandling={--WIP
  save=MISSION,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}

this.fultonMotherBaseHandling={ --WIP
  save=MISSION,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}
--<fulton success

--item levels>
--CULL this.handLevelRange={max=4,min=0,increment=1}
local handLevelSettings={"DEFAULT","DISABLE","GRADE2","GRADE3","GRADE4"}
this.handLevelSonar={
  save=MISSION,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_ACTIVESONAR,
}

this.handLevelPhysical={--tex called Mobility in UI
  save=MISSION,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_PHYSICAL,
}

this.handLevelPrecision={
  save=MISSION,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_PRECISION,
}

this.handLevelMedical={
  save=MISSION,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_MEDICAL,
}

this.itemLevelFulton={
  save=MISSION,
  settings={"DEFAULT","GRADE1","GRADE2","GRADE3","GRADE4"},
  settingNames="itemLevelFultonSettings",
  equipId=TppEquip.EQP_IT_Fulton,
}
this.itemLevelWormhole={
  save=MISSION,
  --range=this.switchRange,
  settings={"DEFAULT","DISABLE","ENABLE"},
  settingNames="itemLevelWormholeSettings",
  equipId=TppEquip.EQP_IT_Fulton_WormHole,
}
--<item levels
this.primaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=ospSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{primaryHip="EQP_None"}},
  },
  GetTable=IvarProc.ReturnCurrent,
}
this.secondaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=ospSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{secondary="EQP_None"}},
  },
  GetTable=IvarProc.ReturnCurrent,
}
this.tertiaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=ospSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{primaryBack="EQP_None"}},
  },
  GetTable=IvarProc.ReturnCurrent,
}

-- revenge/enemy prep stuff>
IvarProc.MissionModeIvars(
  this,
  "revengeMode",
  {
    save=MISSION,
    settings={"DEFAULT","CUSTOM"},
    settingNames="revengeModeSettings",
    OnChange=function()
      TppRevenge._SetUiParameters()
    end,
  },
  IvarProc.missionModesAll
)

this.revengeModeMB.settings={"OFF","FOB","DEFAULT","CUSTOM"}--DEFAULT = normal enemy prep system (which isn't usually used for MB)
this.revengeModeMB.settingNames="revengeModeMBSettings"

this.revengeBlockForMissionCount={
  save=MISSION,
  default=3,
  range={max=10},
}

this.disableNoRevengeMissions={--WIP
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableNoStealthCombatRevengeMission={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.revengeDecayOnLongMbVisit={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.applyPowersToLrrp={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.applyPowersToOuterBase={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}


IvarProc.MissionModeIvars(
  this,
  "allowHeavyArmor",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MISSION",}
)

--WIP TODO either I got rid of this functionality at some point or I never implemented it (I could have sworn I did though)
--this.allowLrrpArmorInFree={
--  save=MISSION,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

this.allowHeadGearCombo={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  allowHeadGearComboThreshold=120,
}

this.allowMissileWeaponsCombo={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.balanceHeadGear={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  balanceHeadGearThreshold=100,
}

this.balanceWeaponPowers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  balanceWeaponsThreshold=100,
}

this.disableConvertArmorToShield={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableMissionsWeaponRestriction={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableMotherbaseWeaponRestriction={--WIP
  --OFF WIP save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.enableMgVsShotgunVariation={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.randomizeSmallCpPowers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--TODO: CULL
IvarProc.MissionModeIvars(
  this,
  "enableDDEquip",
  {
    --OFF save=MISSION,--
    nonConfig=true,--
    range=this.switchRange,
    settingNames="set_switch",
  },
  IvarProc.missionModesAll
)

--custom revenge config
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
    InfLog.DebugPrint("SetMinMax: could not find ivar for "..baseName)
    return
  end
  ivarMin:Set(min,true)
  ivarMax:Set(max,true)
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
      range=this.switchRange,
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
      range=this.switchRange,
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
    range=this.switchRange,
    settingNames="set_switch",
  }
)

--<revenge stuff
--reinforce stuff DOC: Reinforcements Soldier Vehicle Heli.txt
this.forceSuperReinforce={
  save=MISSION,
  settings={"OFF","ON_CONFIG","FORCE_CONFIG"},
  settingNames="forceSuperReinforceSettings",
}

this.forceReinforceRequest={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.enableHeliReinforce={--tex chance of heli being chosen for a rienforce, also turns off heli quests
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function()
    TppQuest.UpdateActiveQuest()--tex update since quests may have changed
  end,
}

this.enableSoldiersWithVehicleReinforce={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableReinforceHeliPullOut={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--this.currentReinforceCount={--NONUSER
--  save=MISSION,
--  range={max=100},
--}

--lrrp
this.enableLrrpFreeRoam={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

--wildcard
this.enableWildCardFreeRoam={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

--tex WIP ideally would have defaults of 2-5, and also let user modify, but while base assignment is random need to spread it as far as posible to get coverage
--IvarProc.MinMaxIvar(
--  this,
--  "lrrpSizeFreeRoam",
--  {default=2},
--  {default=2},
--  {
--    range={min=1,max=10}
--  }
--)

--patrol vehicle stuff>
this.vehiclePatrolProfile={--TODO rename, this is not an IH profile 'vehicle patrol style?'
  save=MISSION,
  settings={"OFF","SINGULAR","EACH_VEHICLE"},
  settingNames="vehiclePatrolProfileSettings",
  MissionCheck=IvarProc.MissionCheckFree,
}

local function TypeChange(self)
--CULL InfVehicle.BuildEnabledList()
end

this.vehiclePatrolLvEnable={
  save=MISSION,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=TypeChange,
}

this.vehiclePatrolTruckEnable={
  save=MISSION,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=TypeChange,
}

this.vehiclePatrolWavEnable={
  save=MISSION,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=TypeChange,
}

this.vehiclePatrolWavHeavyEnable={
  save=MISSION,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=TypeChange,
}

this.vehiclePatrolTankEnable={
  save=MISSION,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=TypeChange,
}

this.vehiclePatrolPaintType={
  --OFF save=MISSION,
  range={max=10},
}

this.vehiclePatrolClass={
  save=MISSION,
  settings={"DEFAULT","DARK_GRAY","OXIDE_RED","RANDOM","RANDOM_EACH","ENEMY_PREP"},
  settingNames="vehiclePatrolClassSettingNames",
}

this.vehiclePatrolEmblemType={
  --OFF save=MISSION,
  range={max=10},
}

this.enemyHeliPatrol={
  save=MISSION,
  settings={"OFF","1","3","5","7","ENEMY_PREP"},
  settingNames="enemyHeliPatrolSettingNames",
  MissionCheck=IvarProc.MissionCheckFree,
}

this.putEquipOnTrucks={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
--<patrol vehicle stuff
IvarProc.MissionModeIvars(
  this,
  "startOnFoot",
  {
    save=MISSION,
    settings={"OFF","NOT_ASSAULT","ALL"},
    settingNames="onFootSettingsNames",
  },
  {"FREE","MISSION","MB_ALL"}
)

this.clockTimeScale={
  save=GLOBAL,
  default=20,
  range={max=10000,min=1,increment=1},
  OnChange=function()
    --if not DemoDaemon.IsDemoPlaying() then
    if not mvars.mis_missionStateIsNotInGame then
      TppClock.Start()
    end
    --end
  end
}

this.forceSoldierSubType={--DEPENDENCY soldierTypeForced WIP
  save=MISSION,
  settings={
    "DEFAULT",
    "DD_A",
    "DD_PW",
    "DD_FOB",
    "SKULL_CYPR",
    "SKULL_AFGH",
    "SOVIET_A",
    "SOVIET_B",
    "PF_A",
    "PF_B",
    "PF_C",
    "CHILD_A",
  },
  --settingNames=InfMain.enemySubTypes,
  OnChange=function(self)
    if self.setting==0 then
      InfMain.ResetCpTableToDefault()
    end
  end,
}

IvarProc.MissionModeIvars(
  this,
  "changeCpSubType",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
    OnChange=function(self)
      if self.setting==0 then
        InfMain.ResetCpTableToDefault()
      end
    end,
  },
  {"FREE","MISSION",}
)

function this.UpdateActiveQuest()
  for i=0,TppDefine.QUEST_MAX-1 do
    gvars.qst_questRepopFlag[i]=false
  end

  for i,areaQuests in ipairs(TppQuestList.questList)do
    TppQuest.UpdateRepopFlagImpl(areaQuests)
  end
  TppQuest.UpdateActiveQuest()
end
this.unlockSideOps={
  save=MISSION,
  settings={"OFF","REPOP","OPEN"},
  settingNames="set_unlock_sideops",
  OnChange=this.UpdateActiveQuest,
}

this.unlockSideOpNumber={
  save=MISSION,
  range={max=this.numQuests},
  SkipValues=function(self,newSetting)
    local questName=TppQuest.questNameForUiIndex[newSetting]
    --InfLog.DebugPrint(questName)--DEBUG
    return InfMain.BlockQuest(questName)
  end,
  OnChange=this.UpdateActiveQuest,
}

this.sideOpsSelectionMode={
  save=MISSION,
  settings={
    "OFF",
    "RANDOM",
    "STORY",
    "EXTRACT_INTERPRETER",
    "BLUEPRINT",
    "EXTRACT_HIGHLY_SKILLED",
    "PRISONER",
    "CAPTURE_ANIMAL",
    "WANDERING_SOLDIER",
    "DDOG_PRISONER",
    "ELIMINATE_HEAVY_INFANTRY",
    "MINE_CLEARING",
    "ELIMINATE_ARMOR_VEHICLE",
    "EXTRACT_GUNSMITH",
    --"EXTRACT_CONTAINERS",
    --"INTEL_AGENT_EXTRACTION",
    "ELIMINATE_TANK_UNIT",
    "ELIMINATE_PUPPETS",
  --"TARGET_PRACTICE",
  },
  settingNames="sideOpsSelectionModeSettings",
  OnChange=this.UpdateActiveQuest,
}

--mbshowstuff
this.mbShowBigBossPosters={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowQuietCellSigns={
  --OFF save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowMbEliminationMonument={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowSahelan={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowAiPod={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowEli={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowCodeTalker={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbUnlockGoalDoors={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnableOcelot={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnablePuppy={
  save=MISSION,
  settings={"OFF","MISSING_EYE","NORMAL_EYES"},
  settingNames="mbEnablePuppySettings",
  OnChange=function(self)
    local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
    if self.setting==0 then
      gvars.qst_questRepopFlag[puppyQuestIndex]=false
      gvars.qst_questOpenFlag[puppyQuestIndex]=false
    else
      local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
      gvars.qst_questRepopFlag[puppyQuestIndex]=true
      gvars.qst_questOpenFlag[puppyQuestIndex]=true
    end
    TppQuest.UpdateRepopFlagImpl(TppQuestList.questList[17])--MtbsCommand
    TppQuest.UpdateActiveQuest()
  end
}

this.mbDontDemoDisableBuddy={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbCollectionRepop={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbMoraleBoosts={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
--
this.manualMissionCode={
  --OFF save=MISSION,
  settings={
    --LOC,TYPE,Notes
    "1",--INIT
    "5",--TITLE
    --storyMissions
    --  "10010",--CYPR
    --  "10020",
    --  "10030",
    --  "10036",
    --  "10043",
    --  "10033",
    --  "10040",
    --  "10041",
    --  "10044",
    --  "10052",
    --  "10054",
    --  "10050",
    --  "10070",
    --  "10080",
    --  "10086",
    --  "10082",
    --  "10090",
    --  "10195",
    --  "10091",
    --  "10100",
    --  "10110",
    --  "10121",
    --  "10115",
    --  "10120",
    --  "10085",
    --  "10200",
    --  "10211",
    --  "10081",
    --  "10130",
    --  "10140",
    --  "10150",
    --  "10151",
    --  "10045",
    --  "10156",
    --  "10093",
    --  "10171",
    --  "10240",
    --  "10260",
    --  "10280",--CYPR
    --hard missions
    --"11043",
    "11041",--missingno
    --"11054",
    "11085",--missingno
    --"11082",
    --"11090",
    "11036",--missingno
    --"11033",
    --"11050",
    "11091",--missingno
    "11195",--missingno
    "11211",--missingno
    --"11140",
    "11200",--missingno
    --"11080",
    "11171",--missingno
    --"11121",
    "11115",--missingno
    --"11130",
    --"11044",
    "11052",--missingno
    --"11151",
    --
    "10230",--FLYK,missing completely, chap 3, no load
    --in PLAY_DEMO_END_MISSION, no other refs
    "11070",
    "11100",
    "11110",
    "11150",
    "11240",
    "11260",
    "11280",
    "11230",
    --free mission
    --"30010",--AFGH,FREE
    --"30020",--MAFR,FREE
    --"30050",--MTBS,FREE
    --"30150",--MTBS,MTBS_ZOO,FREE
    --"30250",--MBQF,MBTS_WARD,FREE
    --heli space
    "40010",--AFGH,AFGH_HELI,HLSP
    "40020",--MAFR,MAFR_HELI,HLSP
    "40050",--MTBS
    "40060",--HLSP,HELI_SPACE,--no load
    --online
    "50050",--MTBS,FOB
    --select??
    "60000",--SELECT --6e4
    --show demonstrations (not demos lol)
    "65020",--AFGH,e3_2014
    "65030",--MTBS,e3_2014
    "65050",--MAFR??,e3_2014
    "65060",--MAFR,tgs_2014
    "65414",--gc_2014
    "65415",--tgs_2014
    "65416",--tgs_2014
  }
}

--AFGH={10020,10033,10034,10036,10040,10041,10043,10044,10045,10050,10052,10054,10060,10070,10150,10151,10153,10156,10164,10199,10260,,,
--11036,11043,11041,11033,11050,11054,11044,11052,11151},
--MAFR={10080,10081,10082,10085,10086,10090,10091,10093,10100,10110,10120,10121,10130,10140,10154,10160,10162,10171,10200,10195,10211,,,
--11085,11082,11090,11091,11195,11211,11140,11200,11080,11171,11121,11130},
--MTBS={10030,10115,11115,10240},

--appearance
--CULL this.useAppearance={
--  save=MISSION,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

this.playerType={
  --OFF save=MISSION,
  settings={"SNAKE","AVATAR","DD_MALE","DD_FEMALE"},
  settingsTable={--tex can just use number as index but want to re-arrange, actual index in exe/playertype is snake=0,dd_male=1,ddfemale=2,avatar=3
    PlayerType.SNAKE,
    PlayerType.AVATAR,
    PlayerType.DD_MALE,
    PlayerType.DD_FEMALE,
  },
  playerTypeToSetting={
    --    [PlayerType.SNAKE]=0,
    --    [PlayerType.AVATAR]=1,
    --    [PlayerType.DD_MALE]=2,
    --    [PlayerType.DD_FEMALE]=3,
    [0]=0,
    [1]=2,
    [2]=3,
    [3]=1,
  },
  GetSettingText=function(self)
    local playerType=self.settingsTable[self.setting+1]
    local playerTypeInfo=InfFova.playerTypesInfo[playerType+1]
    return playerTypeInfo.description or playerTypeInfo.name
  end,
  OnSelect=function(self)
    self.setting=self.playerTypeToSetting[vars.playerType]
  end,
  OnChange=function(self)
    local currentSetting=vars.playerType
    local newSetting=self.settingsTable[self.setting+1]
    if newSetting==currentSetting then
      return
    end

    if (InfFova.playerTypeGroup.VENOM[newSetting] and InfFova.playerTypeGroup.DD[currentSetting])
      or (InfFova.playerTypeGroup.VENOM[currentSetting] and InfFova.playerTypeGroup.DD[newSetting]) then
      --InfLog.DebugPrint"playerTypeGroup changed"--DEBUG
      vars.playerPartsType=0
    end

    if currentSetting==PlayerType.DD_MALE then
      Ivars.maleFaceId:Set(vars.playerFaceId)
    elseif currentSetting==PlayerType.DD_FEMALE then
      Ivars.femaleFaceId:Set(vars.playerFaceId)
    end

    if newSetting==PlayerType.DD_FEMALE then
      vars.playerFaceId=Ivars.femaleFaceId:Get()
    else
      vars.playerFaceId=Ivars.maleFaceId:Get()
    end

    local faceEquipInfo=InfFova.playerFaceEquipIdInfo[vars.playerFaceEquipId+1]
    if faceEquipInfo and faceEquipInfo.playerTypes and not faceEquipInfo.playerTypes[vars.playerType] then
      vars.playerFaceEquipId=0
    end

    vars.playerType=self.settingsTable[self.setting+1]
  end,
}

this.playerTypeDirect={
  --OFF save=MISSION,
  settings={"SNAKE","AVATAR","DD_MALE","DD_FEMALE"},
  settingsTable={--tex can just use number as index but want to re-arrange, actual index in exe/playertype is snake=0,dd_male=1,ddfemale=2,avatar=3
    PlayerType.SNAKE,
    PlayerType.AVATAR,
    PlayerType.DD_MALE,
    PlayerType.DD_FEMALE,
  },
  playerTypeToSetting={
    --    [PlayerType.SNAKE]=0,
    --    [PlayerType.AVATAR]=1,
    --    [PlayerType.DD_MALE]=2,
    --    [PlayerType.DD_FEMALE]=3,
    [0]=0,
    [1]=2,
    [2]=3,
    [3]=1,
  },
  OnSelect=function(self)
    self.setting=self.playerTypeToSetting[vars.playerType]
  end,
  OnActivate=function(self)
    vars.playerType=self.settingsTable[self.setting+1]
  end,
}


local playerPartsTypeSettings={
  "NORMAL",--0,
  "NORMAL_SCARF",--1,
  "NAKED",--7,
  "SNEAKING_SUIT_TPP",--8,
  "SNEAKING_SUIT",--2,
  "SNEAKING_SUIT_BB",--25
  "BATTLEDRESS",--9
  "PARASITE",--10
  "LEATHER",--11
  "SWIMWEAR",--23
  "RAIDEN",--6,
  "HOSPITAL",--3,
  "MGS1",--4,
  "NINJA",--5,
  "GOLD",--12
  "SILVER",--13
--DLC TODO find a have-this check
--    "MGS3",--15
--  "MGS3_NAKED",--16
--  "MGS3_SNEAKING",--17
--  "MGS3_TUXEDO",--18
--  "EVA_CLOSE",--19
--  "EVA_OPEN",--20
--  "BOSS_CLOSE",--21
--  "BOSS_OPEN",--22
}

this.playerPartsType={
  --OFF save=MISSION,
  settings=playerPartsTypeSettings,
  GetSettingText=function(self)
    local InfFova=InfFova
    local partsTypeName=self.settings[self.setting+1]
    local partsType=InfFova.PlayerPartsType[partsTypeName]
    local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]

    local playerTypeName=InfFova.playerTypes[vars.playerType+1]

    local fovaTable,modelDescription=InfFova.GetFovaTable(playerTypeName,partsTypeName)

    return modelDescription or partsTypeInfo.description or partsTypeInfo.name
  end,
  OnSelect=function(self)
    local settingsForPlayerType={}
    for i,partsTypeName in ipairs(playerPartsTypeSettings) do
      local partsType=InfFova.PlayerPartsType[partsTypeName]
      local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]
      if not partsTypeInfo then
        InfLog.DebugPrint("WARNING: could not find partsTypeInfo for "..partsTypeName)
      else
        local plPartsName=partsTypeInfo.plPartsName
        if not plPartsName then
          InfLog.DebugPrint("WARNING: could not find plPartsName for "..partsTypeName)
        else
          local playerTypeName=InfFova.playerTypes[vars.playerType+1]
          if plPartsName.ALL or plPartsName[playerTypeName] then
            table.insert(settingsForPlayerType,partsTypeName)
          end
        end
      end
    end

    self.settings=settingsForPlayerType
    self.range.max=#settingsForPlayerType-1
    self.enum=Enum(self.settings)
    if #self.settings==0 then
      InfLog.DebugPrint("WARNING: #self.settings==0 for playerType")
      return
    end

    local partsTypeName=InfFova.playerPartsTypes[vars.playerPartsType+1]
    local setting=self.enum[partsTypeName]
    if setting==nil then
      --InfLog.DebugPrint("WARNING: could not find enum for "..partsTypeName)--DEBUG
      self.setting=0
    else
      self.setting=self.enum[partsTypeName]
    end
  end,
  OnChange=function(self)
    local partsTypeName=self.settings[self.setting+1]

    local playerCamoTypes=InfFova.GetCamoTypes(partsTypeName)
    if playerCamoTypes==nil then
      return
    end

    --InfLog.PrintInspect(playerCamoTypes)--DEBUG
    local enum=Enum(playerCamoTypes)
    local camoName=InfFova.playerCamoTypes[vars.playerCamoType+1]
    --InfLog.DebugPrint(camoName)--DEBUG

    --tex sort out camo type too
    local camoType=PlayerCamoType[camoName]
    if camoType==nil or enum[camoName]==nil then
      camoType=0
    end

    vars.playerCamoType=camoType

    vars.playerPartsType=InfFova.PlayerPartsType[partsTypeName]
  end,
}

this.playerPartsTypeDirect={
  --OFF save=MISSION,
  range={min=0,max=100},
  OnSelect=function(self)
    self.setting=vars.playerPartsType
  end,
  OnActivate=function(self)
    vars.playerPartsType=self.setting
  end,
}

--tex GOTCHA: setting var.playerCamoType to a unique type (non-common/only one camo type for it) seems to lock it in/prevent vars.playerPartsType from applying until set back to a common camo type
this.playerCamoType={
  --OFF save=MISSION,
  --settings=playerCamoTypes,
  range={min=0,max=1000},
  GetSettingText=function(self)
    local camoName=self.settings[self.setting+1]
    local camoType=PlayerCamoType[camoName]
    local camoInfo=InfFova.playerCamoTypesInfo[camoType+1]
    return camoInfo.description or camoInfo.name
  end,
  OnSelect=function(self)
    local partsTypeName=InfFova.playerPartsTypes[vars.playerPartsType+1]

    local playerCamoTypes=InfFova.GetCamoTypes(partsTypeName)
    if playerCamoTypes==nil then
      return
    end

    --InfLog.PrintInspect(playerCamoTypes)--DEBUG
    local enum=Enum(playerCamoTypes)
    local camoName=InfFova.playerCamoTypes[vars.playerCamoType+1]
    --InfLog.DebugPrint(camoName)--DEBUG

    local camoSetting=enum[camoName]
    if camoSetting==nil then
      camoSetting=0
    end

    self.setting=camoSetting

    self.settings=playerCamoTypes
    self.enum=enum
    self.range.max=#self.settings-1
  end,
  OnChange=function(self)
    local camoName=self.settings[self.setting+1]
    vars.playerCamoType=PlayerCamoType[camoName]
  end,
}

--tex for DEBUG, just exploring direct value
this.playerCamoTypeDirect={
  range={min=0,max=1000},
  OnSelect=function(self)
    self.setting=vars.playerCamoType
  end,
  OnActivate=function(self)
    vars.playerCamoType=self.setting
    -- vars.playerPartsType=PlayerPartsType.NORMAL--TODO: camo wont change unless this (one or both, narrow down which) set
    -- vars.playerFaceEquipId=0
  end,
}

this.playerFaceEquipId={
  --OFF save=MISSION,
  range={min=0,max=100},
  settingsTable={0},
  GetSettingText=function(self)
    local faceEquipId=self.settingsTable[self.setting+1]
    local faceEquipInfo=InfFova.playerFaceEquipIdInfo[faceEquipId+1]
    return faceEquipInfo.description or faceEquipInfo.name
  end,
  OnSelect=function(self)
    self.setting=0
    local settingsTable={}
    for i,faceEquipInfo in ipairs(InfFova.playerFaceEquipIdInfo)do
      if faceEquipInfo.playerTypes==nil or faceEquipInfo.playerTypes[vars.playerType] then
        local playerFaceEquipId=i-1
        table.insert(settingsTable,playerFaceEquipId)
        if playerFaceEquipId==vars.playerType then
          self.setting=playerFaceEquipId
        end
      end
    end

    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnChange=function(self)
    vars.playerFaceEquipId=self.settingsTable[self.setting+1]
  end,
}

this.playerFaceEquipIdDirect={
  --OFF save=MISSION,
  range={min=0,max=100},--TODO
  OnSelect=function(self)
    self.setting=vars.playerFaceEquipId
  end,
  OnActivate=function(self)
    vars.playerFaceEquipId=self.setting
  end,
}

this.playerFaceId={
  --save=MISSION,
  range={min=0,max=1000},
  currentGender=0,
  settingsTable={1},
  --noSettingCounter=true,
  GetSettingText=function(self)
    return InfLog.PCall(function(self)--DEBUGNOW
      if InfFova.playerTypeGroup.VENOM[vars.playerType] then
        return InfMenu.LangString"only_for_dd_soldier"
    end

    local faceDefId=self.settingsTable[self.setting+1]
    local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
    local faceId=faceDef[1]

    if Ivars.playerFaceFilter:Is"FOVAMOD" then
      if not InfModelRegistry or not InfModelRegistry.headDefinitions or #InfModelRegistry.headDefinitions==0 then
        return InfMenu.LangString"no_head_fovas"
      end
    end

    if InfModelRegistry then
      if InfModelRegistry.headDefinitions then
        local headDefinitionName=InfModelRegistry.headDefinitions[faceId]
        if headDefinitionName then
          local headDefinition=InfModelRegistry.headDefinitions[headDefinitionName]
          local desciption=headDefinition.description or headDefinitionName
          return "faceId:"..faceId.." - "..desciption
        end
      end
    end
    return "faceId:"..faceId

      --    local faceFova=faceDef[5]
      --    local faceDecoFova=faceDef[6]
      --    local hairFova=faceDef[7]
      --    local hairDecoFova=faceDef[8]
      --    local faceFovaInfo=InfEneFova.faceFovaInfo[faceFova+1]
      --    local faceDecoFovaInfo=InfEneFova.faceDecoFovaInfo[faceDecoFova+1]
      --    local hairFovaInfo=InfEneFova.hairFovaInfo[hairFova+1]
      --    local hairDecoFovaInfo=InfEneFova.hairDecoFovaInfo[hairDecoFova+1]
      --
      --    return string.format("faceId:%s, f:%s, fd:%s, h:%s, hd:%s",
      --      faceDef[1],
      --      faceFovaInfo.description or faceFovaInfo.name,
      --      faceDecoFovaInfo.description or faceDecoFovaInfo.name,
      --      hairFovaInfo.description or hairFovaInfo.name,
      --      hairDecoFovaInfo.description or hairDecoFovaInfo.name)
    end,self)--DEBUGNOW
  end,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.setting=0
      self.settingsTable={0}
      self.range.max=0
      return
    end

    local faceModSlots={}
    for i,slot in ipairs(InfEneFova.faceModSlots)do
      local faceId=Soldier2FaceAndBodyData.faceDefinition[slot][1]
      faceModSlots[faceId]=true
    end

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]
    local settingsTable={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      local faceId=entry[1]
      local limit=Ivars.playerFaceFilter:GetTable()
      if faceId>=limit then
        if entry[InfEneFova.faceDefinitionParams.gender]==gender then
          if not faceModSlots[faceId] then
            table.insert(settingsTable,i)
          end
        end
      end
    end

    if #settingsTable==0 then
      self.setting=0
      self.settingsTable={0}
      self.range.max=0
      return
    end

    --tex don't need to sort, assuming faceDefinition entries are also in ascending faceId

    if self.currentGender~=gender then
      self.setting=0
    end

    local foundFace=false
    --tex set setting to current face, TODO grinding through whole table isnt that nice, build a faceId to faceDef lookup
    for i,faceDefId in ipairs(settingsTable)do
      local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
      if vars.playerFaceId==faceDef[1] then
        self.setting=i-1
        foundFace=true
        break
      end
    end

    if not foundFace then
      self.setting=0
      local faceDefId=settingsTable[self.setting+1]
      local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
      vars.playerFaceId=faceDef[1]
    end

    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
    self.currentGender=gender
  end,
  OnChange=function(self)
    local faceDefId=self.settingsTable[self.setting+1]
    local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
    vars.playerFaceId=faceDef[1]
  end,
}

this.playerFaceFilter={
  --save=MISSION,
  settings={"ALL","UNIQUE","FOVAMOD"},
  settingNames="playerFaceFilterSettings",
  settingsTable={
    ALL=0,
    UNIQUE=550,
    FOVAMOD=Soldier2FaceAndBodyData.highestVanillaFaceId
  },
  GetTable=IvarProc.ReturnCurrent,
}

this.playerFaceIdDirect={
  save=MISSION,
  range={min=0,max=687},
  OnSelect=function(self)
    self.setting=vars.playerFaceId
  end,
  OnActivate=function(self)
    vars.playerFaceId=self.setting
  end,
}

--tex saving prefered faceId per gender
this.maleFaceId={
  save=MISSION,
  default=0,
  range={min=0,max=5000},--TODO sync max?, Soldier2FaceAndBodyData.MAX_FACEID, but since since ivar gvar size is based on range.max, make sure ivars that change their max during run have a specified fixed size, because I don't  know if the save system is robust enough to handle size changes.
}

this.femaleFaceId={
  save=MISSION,
  default=350,
  range={min=0,max=5000},--TODO see above
}

--tex WIP
this.faceFova={
  --OFF save=MISSION,
  range={min=0,max=1000},
  settingsTable={0},
  GetSettingText=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      return InfMenu.LangString"only_for_dd_soldier"
    end
    local faceFova=self.settingsTable[self.setting+1]
    local faceFovaInfo=InfEneFova.faceFovaInfo[faceFova+1]
    return faceFovaInfo.description or faceFovaInfo.name
  end,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

    local settingsNonDup={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if entry[InfEneFova.faceDefinitionParams.gender]==gender then
        local param=entry[InfEneFova.faceDefinitionParams[self.name]]--tex ASSUMPTION ivar same name as param
        settingsNonDup[param]=true
      end
    end

    local settingsTable={}
    for param,bool in pairs(settingsNonDup) do
      table.insert(settingsTable,param)
    end
    InfMain.SortAscend(settingsTable)
    --InfLog.PrintInspect(settingsTable)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}

this.faceDecoFova={
  --OFF save=MISSION,
  range={min=0,max=1000},
  settingsTable={0},
  GetSettingText=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      return InfMenu.LangString"only_for_dd_soldier"
    end
    local faceDecoFova=self.settingsTable[self.setting+1]
    local faceDecoFovaInfo=InfEneFova.faceDecoFovaInfo[faceDecoFova+1]
    return faceDecoFovaInfo.description or faceDecoFovaInfo.name
  end,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end
    --tex since we are going by faceDefinitionParams instead faceDecoFova is dependant on faceFova
    Ivars.faceFova:OnSelect()
    local faceFova=Ivars.faceFova.settingsTable[Ivars.faceFova.setting+1]

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

    local settingsNonDup={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if entry[InfEneFova.faceDefinitionParams.gender]==gender then
        if entry[InfEneFova.faceDefinitionParams.faceFova]==faceFova then
          local param=entry[InfEneFova.faceDefinitionParams[self.name]]--tex ASSUMPTION ivar same name as param
          settingsNonDup[param]=true
        end
      end
    end

    local settingsTable={}
    for param,bool in pairs(settingsNonDup) do
      table.insert(settingsTable,param)
    end
    InfMain.SortAscend(settingsTable)
    InfLog.PrintInspect(settingsTable)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}
this.hairFova={
  --OFF save=MISSION,
  range={min=0,max=1000},
  settingsTable={0},
  GetSettingText=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      return InfMenu.LangString"only_for_dd_soldier"
    end
    local hairFova=self.settingsTable[self.setting+1]
    local hairFovaInfo=InfEneFova.faceFovaInfo[hairFova+1]
    return hairFovaInfo.description or hairFovaInfo.name
  end,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

    local settingsNonDup={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if entry[InfEneFova.faceDefinitionParams.gender]==gender then
        local index=i-1
        local param=entry[InfEneFova.faceDefinitionParams[self.name]]--tex ASSUMPTION ivar same name as param
        settingsNonDup[param]=true
      end
    end

    local settingsTable={}
    for param,bool in pairs(settingsNonDup) do
      table.insert(settingsTable,param)
    end
    InfMain.SortAscend(settingsTable)
    --InfLog.PrintInspect(settings)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}
this.hairDecoFova={
  --OFF save=MISSION,
  range={min=0,max=1000},
  settingsTable={0},
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end
    self.range.max=#Soldier2FaceAndBodyData.hairDecoFova-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}
--<

this.faceFovaDirect={
  --OFF save=MISSION,
  range={min=0,max=1000},
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.faceFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceDecoFovaDirect={
  --OFF save=MISSION,
  range={min=0,max=1000},
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.faceDecoFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.hairFovaDirect={
  --OFF save=MISSION,
  range={min=0,max=1000},
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.hairFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.hairDecoFovaDirect={
  --OFF save=MISSION,
  range={min=0,max=1000},
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.hairDecoFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}

this.faceFovaUnknown1={
  --OFF save=MISSION,
  range={min=0,max=50},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown2={
  --OFF save=MISSION,
  range={min=0,max=1},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown3={
  --OFF save=MISSION,
  range={min=0,max=4},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown4={
  --OFF save=MISSION,
  range={min=0,max=4},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown5={
  --OFF save=MISSION,
  range={min=0,max=1},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown6={
  --OFF save=MISSION,
  range={min=0,max=3},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown7={
  --OFF save=MISSION,
  range={min=0,max=303},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown8={
  --OFF save=MISSION,
  range={min=0,max=303},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown9={
  --OFF save=MISSION,
  range={min=0,max=303},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown10={
  --OFF save=MISSION,
  range={min=0,max=3},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
--
--fovaInfo
this.enableFovaMod={
  nonConfig=true,--tex too dependant on installed mods/dynamic settings
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnSelect=function(self)
  --    if self:Is(1) then
  --    else
  --      InfMenu.PrintLangId"change_model_to_reset_fova"
  --      Ivars.fovaSelection:Reset()
  --    end
  end,
  OnChange=function(self)
    if self:Is(1) then
      Ivars.fovaSelection:Reset()
      InfFova.SetFovaMod(self:Get(),true)
    else
      InfMenu.PrintLangId"change_model_to_reset_fova"
      Ivars.fovaSelection:Reset()
    end
  end,
}

--tex: index into fovaInfor for current playerType,playerPartsType
this.fovaSelection={
  nonConfig=true,--tex too dependant on installed mods/dynamic settings
  save=MISSION,
  range={min=0,max=255},--limits max fovas TODO consider
  OnSelect=function(self)
    local fovaTable,modelDescription=InfFova.GetCurrentFovaTable()
    if modelDescription then
      self.description=modelDescription
    else
      self.description="No model description"
    end

    if fovaTable then
      if Ivars.enableFovaMod:Is(0) then
        InfMenu.PrintLangId"fova_is_not_set"
      end

      self.range.max=#fovaTable-1
      if InfFova.FovaInfoChanged(fovaTable,self:Get()+1) then
        --InfLog.DebugPrint"OnSelect FovaInfoChanged"--DEBUG
        self:Reset()
      end

      self.settingNames={}
      for i=1,#fovaTable do
        local fovaDescription,fovaFile=InfFova.GetFovaInfo(fovaTable,i)

        if not fovaDescription or not IsString(fovaDescription)then
          self.settingNames[i]=i
        else
          self.settingNames[i]=fovaDescription
        end
      end

      InfFova.SetFovaMod(self:Get()+1,true)
    else
      self.range.max=0
      self.settingNames={InfMenu.LangString"no_fova_found"}
      return
    end
  end,
  --  OnDeselect=function(self)
  --    InfLog.DebugPrint"fovaSelection OnDeselect"--DEBUG
  --    if Ivars.enableMod:Is(0) then
  --    --InfMenu.PrintLangId"fova_is_not_set"--DEBUG
  --    end
  --  end,
  OnChange=function(self)
    InfFova.SetFovaMod(self:Get()+1,true)
  end,
}

this.fovaPlayerType={
  save=MISSION,
  range={min=0,max=3},
}

this.fovaPlayerPartsType={
  save=MISSION,
  range={min=0,max=127},
}

this.playerHandTypes={
  "NONE",--0
  "NORMAL",--1
  "STUN_ARM",--2
  "JEHUTY",--3
  "STUN_ROCKET",--4
  "KILL_ROCKET",--5
}

--tex driven by playerHandEquip
--this.playerHandType={
--  --save=MISSION,
--  range={min=0,max=1000},
--  OnChange=function(self)
--    if self.setting>0 then--TODO: add off/default/noset setting
--      vars.playerHandType=self.setting
--    end
--  end,
--}

--TppEquip.
local playerHandEquipTypes={
  "EQP_HAND_NORMAL",
  "EQP_HAND_STUNARM",
  "EQP_HAND_JEHUTY",
  "EQP_HAND_STUN_ROCKET",
  "EQP_HAND_SILVER",
  "EQP_HAND_GOLD",
}
local handEquipTypeToHandType={
  EQP_HAND_NORMAL="NORMAL",
  EQP_HAND_STUNARM="STUNARM",
  EQP_HAND_JEHUTY="JEHUTY",
  EQP_HAND_STUN_ROCKET="STUN_ROCKET",
  EQP_HAND_KILL_ROCKET="KILL_ROCKET",
  EQP_HAND_SILVER="NORMAL",--VERIFY
  EQP_HAND_GOLD="NORMAL",--VERIFY
}

local playerHandEquipIds={}
for n,equipType in ipairs(playerHandEquipTypes)do
  playerHandEquipIds[#playerHandEquipIds+1]=TppEquip[equipType]
end

this.playerHandEquip={
  --OFF save=MISSION,
  settings=playerHandEquipTypes,

  settingsTable=playerHandEquipIds,
  --settingNames="set_",
  OnSelect=function(self)
  -- self:Set(vars.playerHandEquip,true)
  end,
  OnChange=function(self)
    if self.setting>0 then--TODO: add off/default/noset setting
      --DEBUG OFF vars.playerHandType=handEquipTypeToHandType[playerHandEquipTypes[self.setting]]
      vars.handEquip=self.settingsTable[self.setting]
    end
  end,
}

this.playerHeadgear={--DOC: player appearance.txt
  save=MISSION,
  range={max=7},--TODO: needed something, anything here, RETRY now that I've changed unset max default to 1 from 0
  maleSettingsTable={
    0,
    550,--Balaclava Male
    551,--Balaclava Male
    552,--DD armor helmet (green top)
    558,--Gas mask and clava Male
    560,--Gas mask DD helm Male
    561,--Gas mask DD greentop helm Male
    564,--NVG DDgreentop Male
    565,--NVG DDgreentop GasMask Male
  },
  femaleSettingsTable={
    0,
    555,--DD armor helmet (green top) female - i cant really tell any difference between
    559,--Gas mask and clava Female
    562,--Gas mask DD helm Female
    563,--Gas mask DD greentop helm Female
    566,--NVG DDgreentop Female (or just small head male lol, total cover)
    567,--NVG DDgreentop GasMask
  },
  OnSelect=function(self)
    if vars.playerType==PlayerType.DD_FEMALE then
      if self.settingsTable~=self.femaleSettingsTable then
        self.settingNames="playerHeadgearFemaleSettings"
        self.settingsTable=self.femaleSettingsTable
        self.range.max=#self.femaleSettingsTable-1
      end
    else
      if self.settingsTable~=self.maleSettingsTable then
        self.settingNames="playerHeadgearMaleSettings"
        self.settingsTable=self.maleSettingsTable
        self.range.max=#self.maleSettingsTable-1
      end
    end
    if self.setting>self.range.max then
      self:Set(1)
    elseif self.setting>0 then
      self:Set(self.setting)
    end
  end,
  OnChange=function(self)
    if self.setting==0 then

    else
      if vars.playerType~=PlayerType.DD_MALE and vars.playerType~=PlayerType.DD_FEMALE then
        InfMenu.PrintLangId"setting_only_for_dd"
        return
      end
      vars.playerFaceId=self.settingsTable[self.setting+1]
    end
  end,
}

--enemy phases
this.phaseSettings={
  "PHASE_SNEAK",
  "PHASE_CAUTION",
  "PHASE_EVASION",
  "PHASE_ALERT",
}

--this.phaseTable={
--  TppGameObject.PHASE_SNEAK,--0
--  TppGameObject.PHASE_CAUTION,--1
--  TppGameObject.PHASE_EVASION,--2
--  TppGameObject.PHASE_ALERT,--3
--}

this.minPhase={
  save=MISSION,
  settings=this.phaseSettings,
  --settingsTable=this.phaseTable,
  OnChange=function(self)
    if self.setting>Ivars.maxPhase:Get() then
      Ivars.maxPhase:Set(self.setting)
    end
    --OFF
    --    if Ivars.phaseUpdate:Is(0) then
    --      InfMenu.PrintLangId"phase_modification_enabled"
    --      Ivars.phaseUpdate:Set(1)
    --    end
  end,
}

this.maxPhase={
  save=MISSION,
  settings=this.phaseSettings,
  default=#this.phaseSettings-1,
  --settingsTable=this.phaseTable,
  OnChange=function(self)
    if self.setting<Ivars.minPhase:Get() then
      Ivars.minPhase:Set(self.setting)
    end
    --OFF
    --    if Ivars.phaseUpdate:Is(0) then
    --      InfMenu.PrintLangId"phase_modification_enabled"
    --      Ivars.phaseUpdate:Set(1)
    --    end
  end,
}

this.keepPhase={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
--OFF
--  OnChange=function(self)
--
--    if self.setting>0 and Ivars.phaseUpdate:Is(0) then
--      InfMenu.PrintLangId"phase_modification_enabled"
--      Ivars.phaseUpdate:Set(1)
--    end
--  end,
}

this.phaseUpdate={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
    lastPhase=0,
    alertBump=false,
  },
  ExecUpdate=function(...)InfEnemyPhase.Update(...)end,
}

this.phaseUpdateRate={--seconds
  save=MISSION,
  default=3,
  range={min=1,max=255},
}
this.phaseUpdateRange={--seconds
  save=MISSION,
  range={min=0,max=255},
}

this.printPhaseChanges={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--
this.soldierAlertOnHeavyVehicleDamage={
  save=MISSION,
  settings=this.phaseSettings,
}

this.cpAlertOnVehicleFulton={
  --OFF WIP save=MISSION,
  settings=this.phaseSettings,
}

--this.ogrePointChange={
--  --save=MISSION,
--  default=-100,
--  range={min=-10000,max=10000,increment=100},
--}

--this.ogrePointChange={
--  save=MISSION,
--  settings={"DEFAULT","NORMAL","DEMON"},
--  settingNames="ogrePointChangeSettings",
--  settingsTable=99999999,
--  OnChange=function(self)
--    if self.setting==3 then
--      TppMotherBaseManagement.SubOgrePoint{ogrePoint=-99999999}
--    elseif self.setting==2 then
--      TppMotherBaseManagement.AddOgrePoint{ogrePoint=99999999}
--    end
--  end,
--}

--telop
this.telopMode={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.warpPlayerUpdate={
  nonConfig=true,
  --save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  isMode=true,
  --tex WIP OFF disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,
  OnModeActivate=function()InfMain.OnActivateWarpPlayer()end,
  OnChange=function(self,previousSetting)
    if Ivars.adjustCameraUpdate:Is(1) then
      self.setting=0
      InfMenu.PrintLangId"other_control_active"
    end

    if self.setting==1 then
      InfMenu.PrintLangId"warp_mode_on"
      InfWarp.OnActivate()
    else
      InfMenu.PrintLangId"warp_mode_off"
      InfWarp.OnDeactivate()
    end

    if InfMenu.menuOn then
      InfMain.RestoreActionFlag()
      InfMenu.menuOn=false
    end
  end,
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecUpdate=function(...)InfWarp.Update(...)end,
}

this.adjustCameraUpdate={
  nonConfig=true,
  --save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  isMode=true,
  --disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,--tex OFF not really needed, padmask is sufficient
  OnModeActivate=function()InfCamera.OnActivateCameraAdjust()end,
  OnChange=function(self,previousSetting)
    if Ivars.warpPlayerUpdate:Is(1) then
      self.setting=0
      InfMenu.PrintLangId"other_control_active"
      return
    end

    if self.setting==1 then
      --      if Ivars.cameraMode:Is(0) then
      --        InfMenu.PrintLangId"cannot_edit_default_cam"
      --        self.setting=0
      --        return
      --      else
      InfMenu.PrintLangId"cam_mode_on"
      --InfMain.ResetCamDefaults()
      InfCamera.OnActivateCameraAdjust()
      Ivars.cameraMode:Set(1)
      --end
    else
      InfMenu.PrintLangId"cam_mode_off"
      InfCamera.OnDectivateCameraAdjust()
      Ivars.cameraMode:Set(0)
    end

    if InfMenu.menuOn then
      InfMain.RestoreActionFlag()--TODO only restore those that menu disables that this doesnt
      InfMenu.menuOn=false
    end
  end,
  execCheckTable={inGame=true},--,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecUpdate=function(...)InfCamera.UpdateCameraAdjust(...)end,
}

this.cameraMode={
  --save=MISSION,
  settings={"DEFAULT","CAMERA"},--"PLAYER","CAMERA"},
  settingNames="cameraModeSettings",
  OnChange=function(self,previousSetting)
    if self:Is"DEFAULT" then
      Player.SetAroundCameraManualMode(false)
    else
      Player.SetAroundCameraManualMode(true)
      InfCamera.UpdateCameraManualMode()
    end
  end,
}

this.moveScale={
  save=MISSION,
  default=0.5,
  range={max=10,min=0.01,increment=0.1},
}

this.disableCamText={
  --OFF save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.camNames={
  "FreeCam",
--  "PlayerStand",
--  "PlayerSquat",
--  "PlayerCrawl",
--  "PlayerDash",
}

for i,camName in ipairs(this.camNames) do
  this["focalLength"..camName]={
    --OFF save=MISSION,
    default=21,
    range={max=10000,min=0.1,increment=1},
  }

  this["focusDistance"..camName]={
    --OFF save=MISSION,
    default=8.175,
    range={max=1000,min=0.01,increment=0.1},
  }

  this["aperture"..camName]={
    --OFF save=MISSION,
    default=1.875,
    range={max=100,min=0.001,increment=0.1},
  }

  this["distance"..camName]={
    --OFF save=MISSION,
    default=0,--WIP TODO need seperate default for playercam and freemode (player wants to be about 5, free 0)
    range={max=100,min=0,increment=0.1},
  }

  this["positionX"..camName]={
    --OFF save=MISSION,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
  this["positionY"..camName]={
    --OFF save=MISSION,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
  this["positionZ"..camName]={
    --OFF save=MISSION,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
end

--highspeedcamera/slowmo
this.speedCamContinueTime={
  save=MISSION,
  default=10,
  range={max=1000,min=0,increment=1},
}
this.speedCamWorldTimeScale={
  save=MISSION,
  default=0.3,
  range={max=100,min=0,increment=0.1},
}
this.speedCamPlayerTimeScale={
  save=MISSION,
  default=1,
  range={max=100,min=0,increment=0.1},
}

--buddies

local buddyTypeToCommandInfo={
  [BuddyType.QUIET]="quietChangeWeaponVar",
  [BuddyType.DOG]="dogChangeEquipVar",
  [BuddyType.HORSE]="horseChangeTypeVar",
  [BuddyType.WALKER_GEAR]=nil,--WIP "walkerGearChangeMainWeaponVar",
}

local function GetCommandInfo(name)
  local commandInfo=InfBuddy[name] or InfBuddy[buddyTypeToCommandInfo[vars.buddyType]]
  return commandInfo
end

local BuddyVarGetSettingText=function(self)
  if vars.buddyType==BuddyType.NONE then
    return InfMenu.LangString"no_buddy_set"
  end

  local commandInfo=GetCommandInfo(self.name)
  if not commandInfo then
    return InfMenu.LangString"none_defined"
  end

  local varTypeTable=commandInfo.varTypeTable
  return varTypeTable[self.setting].name
end
local BuddyVarOnSelect=function(self)
  if vars.buddyType==BuddyType.NONE then
    return InfMenu.LangString"no_buddy_set"
  end

  local commandInfo=GetCommandInfo(self.name)
  if not commandInfo then
    return
  end
  local var=vars[commandInfo.varName]
  local varTypeTable=commandInfo.varTypeTable
  self.range.max=#varTypeTable
  local index=InfBuddy.GetTableIndexForBuddyVar(var,varTypeTable)
  self.setting=index
end
local BuddyVarOnActivate=function(self)
  if vars.buddyType==BuddyType.NONE then
    return
  end

  local commandInfo=GetCommandInfo(self.name)
  if not commandInfo then
    return
  end
  InfBuddy.ChangeBuddyVar(commandInfo,self.setting)
end

this.buddyChangeEquipVar={
  nonConfig=true,
  --OFF save=MISSION,
  range={max=5,min=1},
  GetSettingText=BuddyVarGetSettingText,
  OnSelect=BuddyVarOnSelect,
  OnActivate=BuddyVarOnActivate,
}

--quiet
this.disableQuietHumming={--tex no go
  --OFF save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if self.setting==1 then
      InfMain.SetQuietHumming(false)
    else
      InfMain.SetQuietHumming(true)
    end
  end,
}

this.quietRadioMode={
  save=MISSION,
  range={min=0,max=31},
  OnChange=function(self,previousSetting)
    if self.setting>0 or previousSetting~=0 then
      if f30050_sequence and mvars.f30050_quietRadioName then
        f30050_sequence.PlayMusicFromQuietRoom()
      end
    end
  end,
}

this.repopulateRadioTapes={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

-- walkergear
IvarProc.MissionModeIvars(
  this,
  "enableWalkerGears",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MB"}
)


this.mbWalkerGearsColor={
  save=MISSION,
  settings={
    "SOVIET",--green, default
    "ROGUE_COYOTE",--Blue grey
    "CFA",--tan
    "ZRS",
    "DDOGS",--light grey
    "HUEY_PROTO",--yellow/grey - texure error on side shields
    "RANDOM",--all of one type
    "RANDOM_EACH",--each random
  },
  settingNames="mbWalkerGearsColorSettingNames",
}

this.mbWalkerGearsWeapon={
  save=MISSION,
  settings={
    "DEFAULT",--dont apply specific value, seems to alternate to give an even count of miniguns and missiles
    "MINIGUN",
    "MISSILE",
    "RANDOM",--all of one type
    "RANDOM_EACH",
  },
  settingNames="mbWalkerGearsWeaponSettingNames",
}
--

this.npcUpdate={--tex NONUSER
  --save=MISSION,
  nonUser=true,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecInit=function(...)InfNPC.InitUpdate(...)end,
  ExecUpdate=function(...)InfNPC.Update(...)end,
}

this.npcOcelotUpdate={--tex NONUSER
  --save=MISSION,
  nonUser=true,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecInit=function(...)InfNPCOcelot.InitUpdate(...)end,
  ExecUpdate=function(...)InfNPCOcelot.Update(...)end,
}

this.npcHeliUpdate={
  save=MISSION,
  settings={"OFF","UTH","UTH_AND_HP48"},
  settingNames="npcHeliUpdateSettings",
  allwaysExec=true,--tex KLUDGE
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  MissionCheck=IvarProc.MissionCheckMb,
  ExecInit=function(...)InfNPCHeli.InitUpdate(...)end,
  OnMissionCanStart=function(...)InfNPCHeli.OnMissionCanStart(...)end,
  ExecUpdate=function(...)InfNPCHeli.Update(...)end,
}

--support heli
this.heliUpdate={--tex NONUSER, for now, need it alive to pick up pull out
  --save=MISSION,
  nonUser=true,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecUpdate=function(...)InfHelicopter.Update(...)end,
}

--this.heliUpdateRate={--seconds
--  save=MISSION,
--  default=3,
--  range={min=1,max=255},
--}

--this.heliUpdateRange={--seconds
--  save=MISSION,
--  range={min=0,max=255},
--}

this.defaultHeliDoorOpenTime={--seconds
  save=MISSION,
  default=15,
  range={min=0,max=120},
}

local HeliEnabledGameCommand=function(self)
  if TppMission.IsFOBMission(vars.missionCode) then return end
  local enable=self.setting==1
  local gameObjectId = GetGameObjectId("TppHeli2", "SupportHeli")
  if gameObjectId ~= nil and gameObjectId ~= NULL_ID then
    GameObject.SendCommand(gameObjectId,{id=self.gameEnabledCommand,enabled=enable})
  end
end

this.enableGetOutHeli={--WIP TEST force every frame via update to see if it actually does anything beyond the allow get out when allready at LZ
  --OFF save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  gameEnabledCommand="SetGettingOutEnabled",
  OnChange=HeliEnabledGameCommand,
}

this.setInvincibleHeli={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  gameEnabledCommand="SetInvincible",
  OnChange=HeliEnabledGameCommand,
}

this.setTakeOffWaitTime={--tex NOTE: 0 is wait indefinately WIP TEST, maybe it's not what I think it is, check the instances that its used and see if its a take-off empty wait or take-off with player in wait
  --OFF save=MISSION,
  default=5,--tex from TppHelicopter.SetDefaultTakeOffTime
  range={min=0,max=15},
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetTakeOffWaitTime",time=self.setting})
    end
  end,
}

this.disablePullOutHeli={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local set=self.setting==1
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      local command
      if set then
        command="DisablePullOut"
      else
        command="EnablePullOut"
      end
      GameObject.SendCommand(gameObjectId,{id=command})
      InfMain.HeliOrderRecieved()
    end
  end,
}

this.setLandingZoneWaitHeightTop={
  save=MISSION,
  default=20,--tex the command is only used in sahelan mission, so don't know if this is actual default,
  range={min=5,max=50,increment=5},
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetLandingZoneWaitHeightTop",height=self.setting})
    end
  end,
}

this.disableDescentToLandingZone={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local set=self.setting==1
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      local command
      if set then
        command="DisableDescentToLandingZone"
      else
        command="EnableDescentToLandingZone"
      end
      GameObject.SendCommand(gameObjectId,{id=command})
    end
  end,
}

this.setSearchLightForcedHeli={
  save=MISSION,
  settings={"DEFAULT","OFF","ON"},
  settingNames="set_default_off_on",
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GetGameObjectId("TppHeli2","SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      local command
      if self.setting==1 then
        command={id="SetSearchLightForcedType",type="On"}
      elseif self.setting==2 then
        command={id="SetSearchLightForcedType",type="Off"}
      end
      if command then
        GameObject.SendCommand(gameObjectId,command)
        InfMain.HeliOrderRecieved()
      end
    end
  end,
}

this.selectedCp={
  nonConfig=true,
  save=MISSION,
  range={max=9999},
  prev=nil,
  GetNext=function(self)
    self.prev=self.setting
    if mvars.ene_cpList==nil then
      InfLog.DebugPrint"mvars.ene_cpList==nil"--DEBUG
      return 0
    end--

    local nextSetting=self.setting
    if self.setting==0 then
      nextSetting=next(mvars.ene_cpList)
    else
      nextSetting=next(mvars.ene_cpList,self.setting)
    end
    if nextSetting==nil then
      --InfLog.DebugPrint"self setting==nil"--DEBUG
      nextSetting=next(mvars.ene_cpList)
    end
    return nextSetting
  end,
  GetPrev=function(self)
    local nextSetting=self.setting
    if self.prev~=nil then
      nextSetting=self.prev
      self.prev=nil
    else
      nextSetting=next(mvars.ene_cpList)--tex go back to start
    end
    return nextSetting
  end,
  GetSettingText=function(self)
    if self.setting==nil then
      return "nil"
    end
    if self.setting==0 then
      return "none"
    end
    return mvars.ene_cpList[self.setting] or "no cp for setting"
  end,
}

--
local currentCategory=0
this.selectedChangeWeapon={--WIP
  --OFF save=MISSION,
  range={max=490,min=1},--tex SYNC: tppEquipTable
  GetSettingText=function(self)
    return InfEquip.tppEquipTableTest[self.setting]
  end,
  OnActivate=function(self)
    local equipName=InfEquip.tppEquipTableTest[self.setting]
    local equipId=TppEquip[equipName]
    if equipId==nil then
      InfLog.DebugPrint("no equipId found for "..equipName)
      return
    else
      --      InfLog.DebugPrint("set "..equipName)
      --      Player.ChangeEquip{
      --        equipId = equipId,
      --        stock = 30,
      --        stockSub = 30,
      --        ammo = 30,
      --        ammoSub = 30,
      --        suppressorLife = 100,
      --        isSuppressorOn = true,
      --        isLightOn = false,
      --        dropPrevEquip = true,
      --      -- toActive = true,
      --      }
      --    end

      --      Player.ChangeEquip{
      --        equipId = equipId,
      --        stock = 30,
      --        stockSub = 0,
      --        ammo = 30,
      --        ammoSub = 0,
      --        suppressorLife = 0,
      --        isSuppressorOn = false,
      --        isLightOn = false,
      --        toActive = false,
      --        dropPrevEquip = false,
      --        temporaryChange = true,
      --      }

      InfLog.DebugPrint("drop "..equipName)
      local dropPosition=Vector3(vars.playerPosX,vars.playerPosY+1,vars.playerPosZ)

      local linearMax=2
      local angularMax=14

      local number=100

      TppPickable.DropItem{
        equipId=equipId,
        number=number,
        position=dropPosition,
        rotation=Quat.RotationY(0),
        linearVelocity=Vector3(math.random(-linearMax,linearMax),math.random(-linearMax,linearMax),math.random(-linearMax,linearMax)),
        angularVelocity=Vector3(math.random(-angularMax,angularMax),math.random(-angularMax,angularMax),math.random(-angularMax,angularMax)),
      }
    end
  end,
}

this.enableInfInterrogation={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

--item drops
this.perSoldierCount=10
this.itemDropChance={
  save=MISSION,
  --range={min=0,max=this.perSoldierCount,increment=1},
  range={min=0,max=100,increment=10},
  isPercent=true,
}

--gameevent
IvarProc.MissionModeIvars(
  this,
  "gameEventChance",
  {
    save=MISSION,
    range={min=0,max=100,increment=5},
    isPercent=true,
  },
  {"FREE","MB",}
)

--parasite
this.enableParasiteEvent={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

--tex time in minutes
IvarProc.MinMaxIvar(
  this,
  "parasitePeriod",
  {
    default=10,
  },
  {
    default=30,
  },
  {
    range={min=0,max=180,increment=1},
  }
)

this.selectProfile={
  nonConfig=true,
  --save=MISSION,
  range={min=0,max=0},
  GetSettingText=function(self)
    if Ivars.profiles==nil or self.settings==nil then
      return InfMenu.LangString"no_profiles_installed"
    else
      local profileName=self.settings[self.setting+1]
      local profileInfo=Ivars.profiles[profileName]
      return profileInfo.description or profileName
    end
  end,
  OnSelect=function(self)
    IvarProc.SetupInfProfiles()
  end,
  OnActivate=function(self)
    if self.settings==nil then
      InfMenu.PrintLangId"no_profiles_installed"
    end

    local profileName=self.settings[self.setting+1]
    local profileInfo=Ivars.profiles[profileName]
    --local profileDescription=profileInfo.description or profileName
    InfMenu.PrintLangId"applying_profile"
    IvarProc.ApplyProfile(profileInfo.profile)
  end,
  GetProfileInfo=function(self)
    if not Ivars.profiles or self.settings==nil then
      return nil
    else
      local profileName=self.settings[self.setting+1]
      return Ivars.profiles[profileName]
    end
  end,
}

--mines
this.randomizeMineTypes={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.additionalMineFields={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.resourceAmountScale={
  save=MISSION,
  default=100,
  range={max=1000,min=100,increment=100},
  isPercent=true,
}

this.skipDevelopChecks={
  nonConfig=true,
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--non user save vars
--others grouped near usage, search NONUSER

--tex used as indicator whether save>ivar.setting should be synced
this.inf_event={--NONUSER
  nonUser=true,
  save=MISSION,
  settings={"OFF","WARGAME","ROAM"},
}

this.inf_parasiteEvent={
  nonUser=true,
  save=MISSION,
  default=0,
  range={max=4,min=0,increment=1},
}

this.mis_isGroundStart={--NONUSER WORKAROUND
  nonUser=true,
  save=MISSION,
  range=this.switchRange,
}

this.mbRepopDiamondCountdown={
  nonUser=true,
  save=MISSION,
  default=4,
  range={max=4,min=0,increment=1},
}

this.inf_levelSeed={--NONUSER--tex cribbed from rev_revengeRandomValue
  nonUser=true,
  save=RESTARTABLE,
  noBounds=true,
  range={max=int32,},
  default=4934224,
  svarType=TppScriptVars.TYPE_UINT32,
}
--end ivar defines

local function IsIvar(ivar)--TYPEID
  return type(ivar)=="table" and (ivar.range or ivar.settings)
end

--ivar system setup
function this.PreModuleReload()
  --tex TODO: kill once individual ivars state (ivar.setting) shifted to ivars global
  ivars={}
  for name,ivar in pairs(this) do
    if IsIvar(ivar) then
      ivars[ivar.name]=ivar.setting
    end
  end
end

--TABLESETUP: Ivars
function this.SetupIvars()
  ivars=ivars or {}

  local optionType="OPTION"
  for name,ivar in pairs(this) do
    if IsIvar(ivar) then
      ivar.optionType=optionType
      --ivar.name=ivar.name or name
      ivar.name=name

      ivar.range=ivar.range or {}
      ivar.range.max=ivar.range.max or 1
      ivar.range.min=ivar.range.min or 0
      ivar.range.increment=ivar.range.increment or 1

      ivar.default=ivar.default or ivar.range.min
      ivar.setting=ivars[ivar.name] or ivar.default

      if ivar.settings then
        ivar.enum=Enum(ivar.settings)
        --      for name,enum in ipairs(ivar.enum) do
        --        ivar[name]=false
        --        if enum==ivar.default then
        --          ivar[name]=true
        --        end
        --      end
        --      ivar[ivar.settings[ivar.default] ]=true
        ivar.range.max=#ivar.settings-1--tex ivars are indexed by 1, lua tables (settings) by 1
      end
      local i,f = math.modf(ivar.range.increment)--tex get fractional part
      f=math.abs(f)
      ivar.isFloat=false
      if f<1 and f~=0 then
        ivar.isFloat=true
      end

      ivar.IsDefault=IvarProc.OptionIsDefault
      ivar.Is=IvarProc.OptionIsSetting
      ivar.Get=IvarProc.OptionIsSetting
      ivar.Set=IvarProc.SetSetting
      ivar.Reset=IvarProc.ResetSetting

      --ExecUpdate setup
      if ivar.ExecUpdate then
        local rateVar=this[ivar.name.."Rate"]
        if rateVar then
          ivar.updateRate=rateVar
        end
        local rangeVar=this[ivar.name.."Range"]
        if rangeVar then
          ivar.updateRange=rangeVar
        end
      end
    end--is ivar
  end
end

function this.SetupUpdateIvars()
  for name,ivar in pairs(this) do
    if IsIvar(ivar) then
      if ivar.ExecUpdate then
        table.insert(this.updateIvars,ivar)
      end
    end
  end
end

function this.Init(missionTable)
  for name,ivar in pairs(this) do
    if IsIvar(ivar)then
      local GetMax=ivar.GetMax--tex cludge to get around that Gvars.lua calls declarevars during it's compile/before any other modules are up, REFACTOR: Init is actually each mission load I think, only really need this to run once per game load, but don't know the good spot currently
      if GetMax and IsFunc(GetMax) then
        ivar.range.max=GetMax()
      end
    end
  end
end

this.varTable={}--tex DEBUG changed from local to function so I can run some debug tests, revert to save some memory
function this.DeclareVars()
  local varTable=this.varTable
  --varTable={
  --   {name="ene_typeForcedName",type=TppScriptVars.UINT32,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
  --   {name="ene_typeIsForced",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
  --}
  --  from MakeSVarsTable, a bit looser, but strings to strcode is interesting
  --    local valueType=type(value)
  --    if valueType=="boolean"then
  --      type=TppScriptVars.TYPE_BOOL,value=value
  --    elseif valueType=="number"then
  --      type=TppScriptVars.TYPE_INT32,value=value
  --    elseif valueType=="string"then
  --      type=TppScriptVars.TYPE_UINT32,value=StrCode32(value)
  --    elseif valueType=="table"then
  --      value=value
  --    end

  for name, ivar in pairs(Ivars) do
    if IsIvar(ivar) then
      if ivar.save then
        local ok=true
        local svarType=0
        local max=ivar.range.max or 0
        local min=ivar.range.min
        if ivar.svarType then
          svarType=ivar.svarType
        elseif ivar.isFloat then
          svarType=TppScriptVars.TYPE_FLOAT
          --elseif max < 2 then --tex TODO: bool support
          --svar.type=TppScriptVars.TYPE_BOOL
        elseif max < int8 then
          svarType=TppScriptVars.TYPE_UINT8
        elseif max < int16 then
          svarType=TppScriptVars.TYPE_UINT16
        elseif max < int32 or max==0 then
          svarType=TppScriptVars.TYPE_INT32
        else
          ok=false
          InfLog.Add("WARNING Ivars.DeclareVars could not find svarType")
        end

        local gvar={name=name,type=svarType,value=ivar.default,save=true,sync=false,wait=false,category=ivar.save}--tex what is sync? think it's network synce, but MakeSVarsTable for seqences sets it to true for all (but then 50050/fob does make a lot of use of it)
        if ok then
          varTable[#varTable+1]=gvar
        end
      end--save
    end--ivar
  end

  local maxQuestSoldiers=20--SYNC InfInterrogate numQuestSoldiers
  local arrays={
    {name="inf_interCpQuestStatus",arraySize=maxQuestSoldiers,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
  }
  for i,gvar in ipairs(arrays)do
    varTable[#varTable+1]=gvar
  end

  return varTable
end

--EXEC
InfLog.PCall(function()
  --DEBUG
  --local breakSave=false
  --if breakSave then
  --  for i=1,100000 do
  --    this["breakVar"..i]={
  --      save=MISSION,
  --      default=100,
  --      range={max=1000,min=0,increment=1},
  --    }
  --  end
  --end

  --DEBUG turn off saving
  --for name, ivar in pairs(this) do
  --  if IsIvar(ivar) then
  --    ivar.save=nil
  --  end
  --end

  this.SetupIvars()
  this.SetupUpdateIvars()
end)

return this
