-- Ivars.lua
--tex Ivar system
--combines gvar setup, enums, functions per setting in one ungodly mess.
--lots of shortcuts/ivar setup depending-on defined values is done in SetupIvars
--Ivars as a whole are actually split across several modules/tables
--this module is mostly defintion of the bounds, settings and functions to run on changing Ivar state
--the working state/value of an Ivar is in the global ivar table, with save values in either gvars (the game save system) or evars (IHs save system)
--the IvarProc module ties together the Ivar definitions and their state

--NOTE: Resetsettings will call OnChange, so/and make sure defaults are actual default game behaviour,
--in general this means all stuff should have a 0 that at least does nothing,
--dont let the lure of nice straight setting>game value lure you, just -1 it
local this={}

--LOCALOPT:
local Ivars=this
local InfCore=InfCore

local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId

local GLOBAL=TppScriptVars.CATEGORY_GAME_GLOBAL
local MISSION=TppScriptVars.CATEGORY_MISSION
local RETRY=TppScriptVars.CATEGORY_RETRY
local MB_MANAGEMENT=TppScriptVars.CATEGORY_MB_MANAGEMENT
local QUEST=TppScriptVars.CATEGORY_QUEST
local CONFIG=TppScriptVars.CATEGORY_CONFIG
local RESTARTABLE=TppScriptVars.CATEGORY_MISSION_RESTARTABLE--DEBUGNOW TppDefine.CATEGORY_MISSION_RESTARTABLE
local PERSONAL=TppScriptVars.CATEGORY_PERSONAL

local EXTERNAL=IvarProc.CATEGORY_EXTERNAL-- was 1024--tex SYNC IvarProc DEBUGNOW

--tex set via IvarsProc.MissionModeIvars, used by IsForMission,EnabledForMission
this.missionModeIvars={}

this.profiles={}
this.savedProfiles={}
--
local int8=256
local int16=2^16
local int32=2^32

this.MAX_SOLDIER_STATE_COUNT = 360--tex from <mission>_enemy.lua, free missions/whatever was highest

this.switchRange={max=1,min=0,increment=1}

this.switchSettings={"OFF","ON"}
this.simpleProfileSettings={"DEFAULT","CUSTOM"}
--

--ivar definitions
--tex NOTE: should be mindful of max setting for save vars,
--currently the ivar setup fits to the nearest save size type and I'm not sure of behaviour when you change ivars max enough to have it shift save size and load a game with an already saved var of different size

this.debugMode={
  nonConfig=true,
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  -- CULL settings={"OFF","NORMAL","BLANK_LOADING_SCREEN"},
  allowFob=true,
  OnChange=function(self,prevStting,setting)
    InfMain.DebugModeEnable(setting==1)
  end,
}

this.debugMessages={
  nonConfig=true,
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.debugFlow={
  nonConfig=true,
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.debugOnUpdate={
  nonConfig=true,
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevStting,setting)
    InfCore.debugOnUpdate=setting==1
  end,
}

this.printPressedButtons={
  range=this.switchRange,
  settingNames="set_switch",
}

this.printOnBlockChange={
  range=this.switchRange,
  settingNames="set_switch",
}

--parameters
--tex TODO: change over name to something more accurate next time you do a change that would require the user to update their settings anyway
this.soldierParamsProfile={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--enemy parameters sight
this.sightScaleRange={max=400,min=0,increment=5}
local function OnChangeEnemyParam(self,currentSetting,setting)
  if Ivars.soldierParamsProfile:Is(0) then
    Ivars.soldierParamsProfile:Set(1)
  end
end

this.soldierSightDistScale={
  save=EXTERNAL,
  default=100,
  range=this.sightScaleRange,
  isPercent=true,
--OnChange=OnChangeEnemyParam,
}

this.soldierNightSightDistScale={
  save=EXTERNAL,
  default=100,
  range=this.sightScaleRange,
  isPercent=true,
--OnChange=OnChangeEnemyParam,
}

this.soldierHearingDistScale={
  save=EXTERNAL,
  default=100,
  range={max=400,min=0,increment=5},
  isPercent=true,
--OnChange=OnChangeEnemyParam,
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
--      save=EXTERNAL,
--      default=1,
--      range=this.sightScaleRange,
--    }
--    this[ivarName]=ivar
--  end
--end
--
this.healthScaleRange={max=900,min=0,increment=20}
this.soldierHealthScale={
  save=EXTERNAL,
  default=100,
  range=this.healthScaleRange,
  isPercent=true,
}
---end soldier params
this.playerHealthScale={
  save=EXTERNAL,
  default=100,
  range={max=650,min=0,increment=20},--tex GOTCHA see InfMain.ChangeMaxLife,http://wiki.tesnexus.com/index.php/Life
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
    save=EXTERNAL,
    range=this.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MISSION","MB_ALL",}
)
this.weaponTableStrength={
  save=EXTERNAL,
  settings={"NORMAL","STRONG","COMBINED"},
}
this.weaponTableAfgh={
  save=EXTERNAL,
  range=this.switchRange,
  default=1,
  settingNames="set_switch",
}
this.weaponTableMafr={
  save=EXTERNAL,
  range=this.switchRange,
  default=1,
  settingNames="set_switch",
}
this.weaponTableSkull={--xof
  save=EXTERNAL,
  range=this.switchRange,
  default=1,
  settingNames="set_switch",
}
this.weaponTableDD={
  save=EXTERNAL,
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
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbSoldierEquipRange={
  save=EXTERNAL,
  settings={"SHORT","MEDIUM","LONG","RANDOM"},
}

this.mbDDEquipNonLethal={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMbAll,
}

this.mbDDSuit={
  save=EXTERNAL,
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
}

this.mbDDSuitFemale={
  save=EXTERNAL,
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
}

this.mbDDHeadGear={
  save=EXTERNAL,
  range=this.switchRange,
  MissionCheck=IvarProc.MissionCheckMbAll,
}

this.mbWarGamesProfile={
  save=EXTERNAL,
  settings={"OFF","TRAINING","INVASION","ZOMBIE_DD","ZOMBIE_OBLITERATION"},
  settingsTable={
    OFF={
      mbDDEquipNonLethal=0,
      mbHostileSoldiers=0,
      mbNonStaff=0,
      mbEnableFultonAddStaff=0,
      mbZombies=0,
      mbEnemyHeli=0,
    },
    TRAINING={
      --mbDDEquipNonLethal=0,--tex allow user setting
      mbHostileSoldiers=1,
      mbEnableLethalActions=0,
      mbNonStaff=0,
      mbEnableFultonAddStaff=0,
      mbZombies=0,
      mbEnemyHeli=0,
    },
    INVASION={
      mbDDEquipNonLethal=0,
      mbHostileSoldiers=1,
      mbEnableLethalActions=1,
      mbNonStaff=1,
      mbEnableFultonAddStaff=1,
      mbZombies=0,
      heliPatrolsMB="HP48",
      mbEnemyHeli=1,
    },
    ZOMBIE_DD={
      mbDDEquipNonLethal=0,--tex n/a
      mbHostileSoldiers=1,
      mbEnableLethalActions=0,
      mbNonStaff=0,
      mbEnableFultonAddStaff=0,
      mbZombies=1,
      mbEnemyHeli=0,
    },
    ZOMBIE_OBLITERATION={
      mbDDEquipNonLethal=0,
      mbHostileSoldiers=1,
      mbEnableLethalActions=1,
      mbNonStaff=1,
      mbEnableFultonAddStaff=0,
      mbZombies=1,
      mbEnemyHeli=0,
    },
  },
  OnChange=IvarProc.OnChangeProfile,
}

this.mbWargameFemales={
  save=EXTERNAL,
  range={min=0,max=100,increment=10},
  isPercent=true,
}

this.mbAdditionalSoldiers={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,
}

this.mbNpcRouteChange={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,
}

this.mbEnableLethalActions={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--DEBUGNOW TODO:
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

this.mbEnemyHeliColor={--TODO RENAME, split into missionmode
  save=EXTERNAL,
  settings={"DEFAULT","BLACK","RED","RANDOM","RANDOM_EACH","ENEMY_PREP"},
}

this.mbEnableFultonAddStaff={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--
this.mbEnableBuddies={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbPrioritizeFemale={
  save=EXTERNAL,
  settings={"OFF","DISABLE","MAX","HALF"},
}
--<motherbase

--demos
this.useSoldierForDemos={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}
this.mbDemoSelection={
  save=EXTERNAL,
  settings={"DEFAULT","PLAY","DISABLED"},
}

this.mbSelectedDemo={
  save=EXTERNAL,
  range={max=1},--DYNAMIC
  settingNames={"NONE"},
  OnSelect=function(self)
    self.range.max=#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST-1
    self.settingNames=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST
  end,
}

this.forceDemoAllowAction={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbDemoOverrideTime={
  save=EXTERNAL,
  settings={"DEFAULT","CURRENT","CUSTOM"},
}

this.mbDemoHour={
  save=EXTERNAL,
  range={min=0,max=23},
}

this.mbDemoMinute={
  save=EXTERNAL,
  range={min=0,max=59},
}

this.mbDemoOverrideWeather={
  save=EXTERNAL,
  settings={"DEFAULT","CURRENT","SUNNY","CLOUDY","RAINY","SANDSTORM","FOGGY","POURING"},
}

--patchup
this.langOverride={
  save=EXTERNAL,
  range=this.switchRange,
  allowFob=true,
}

this.startOffline={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.skipLogos={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.enableQuickMenu={
  save=EXTERNAL,
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
  save=EXTERNAL,
  settings={"OFF","ASSAULT","REGULAR"},
}

this.disableHeliAttack={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local enable=self:Is(0)
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
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}
this.disableHerbSearch={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=RequireRestartMessage,
}

--mission prep

--tex also TppBuddyService.SetDisableAllBuddy
this.disableSelectBuddy={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableSelectTime={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableSelectVehicle={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableHeadMarkers={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevSetting,setting)
    if setting==1 then
      TppUiStatusManager.SetStatus("HeadMarker","INVALID")
    else
      TppUiStatusManager.ClearStatus("HeadMarker")
    end
  end,
}

this.disableWorldMarkers={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevSetting,setting)
    if setting==1 then
      TppUiStatusManager.SetStatus("WorldMarker","INVALID")
    else
      TppUiStatusManager.ClearStatus("WorldMarker")
    end
  end,
}

this.disableXrayMarkers={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevSetting,setting)
    local enabled=setting==1
    TppSoldier2.SetDisableMarkerModelEffect{enabled=enabled}
  end,
}

this.disableFulton={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.dontOverrideFreeLoadout={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--tex TODO: RENAME RETRY this is OSP shiz
local ospSlotClearSettings={
  "OFF",
  "EQUIP_NONE",
}
this.clearItems={
  save=EXTERNAL,
  settings=ospSlotClearSettings,
  settingNames="set_switch",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={"EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None"},
  },
}

this.clearSupportItems={
  save=EXTERNAL,
  settings=ospSlotClearSettings,
  settingNames="set_switch",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}},
  },
}

this.setSubsistenceSuit={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.setDefaultHand={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableMenuDrop={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  menuId="MSN_DROP",
}
this.disableMenuBuddy={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  menuId="MSN_BUDDY",
}
this.disableMenuAttack={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  menuId="MSN_ATTACK",
}
this.disableMenuHeliAttack={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  menuId="MSN_HELI_ATTACK",
}
this.disableMenuIvars={
  this.disableMenuDrop,
  this.disableMenuBuddy,
  this.disableMenuAttack,
  this.disableMenuHeliAttack,
}

this.disableSupportMenu={--tex doesnt use dvcmenu, RESEARCH, not sure actually what it is
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.abortMenuItemControl={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableRetry={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.gameOverOnDiscovery={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}


this.disableOutOfBoundsChecks={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevSetting,setting)
    local enable=setting==0
    mvars.mis_ignoreAlertOfMissionArea=not enable
    local trapName="trap_mission_failed_area"
    TppTrap.ChangeNormalTrapState(trapName,enable)
    TppTrap.ChangeTriggerTrapState(trapName,enable)
  end
}

this.disableGameOver={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--tex no go
this.disableTranslators={
  --OFF save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,prevSetting,setting)
    if setting==1 then
      InfCore.DebugPrint"removing tranlatable"--DEBUG
      vars.isRussianTranslatable=0
      vars.isAfrikaansTranslatable=0
      vars.isKikongoTranslatable=0
      vars.isPashtoTranslatable=0
    elseif setting==0 then
      InfCore.DebugPrint"adding tranlatable"--DEBUG
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
--  save=EXTERNAL,
--  default=0,
--  range={max=100,min=0,increment=1},
--}
--this.fultonOtherVariationRange={
--  save=EXTERNAL,
--  default=0,
--  range={max=100,min=0,increment=1},
--}
--
--this.fultonVariationInvRate={
--  save=EXTERNAL,
--  range={max=500,min=10,increment=10},
--}

this.fultonNoMbSupport={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnSelect=function()
    local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_SUPPORT_FULTON}
    local mbSectionSuccess=TppPlayer.mbSectionRankSuccessTable[mbFultonRank]or 0
    InfMenu.Print(InfMenu.LangString"fulton_mb_support"..":"..mbSectionSuccess)
  end,
}
this.fultonNoMbMedical={--NOTE: does not rely on fulton profile
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnSelect=function()
    local mbFultonRank=TppMotherBaseManagement.GetSectionFuncRank{sectionFuncId=TppMotherBaseManagementConst.SECTION_FUNC_ID_MEDICAL_STAFF_EMERGENCY}
    local mbSectionSuccess=TppPlayer.mbSectionRankSuccessTable[mbFultonRank]or 0
    InfMenu.Print(InfMenu.LangString"fulton_mb_medical"..":"..mbSectionSuccess)
  end,
}

this.fultonDyingPenalty={
  save=EXTERNAL,
  default=70,
  range={max=100,min=0,increment=5},
}

this.fultonSleepPenalty={
  save=EXTERNAL,
  default=0,
  range={max=100,min=0,increment=5},
}

this.fultonHoldupPenalty={
  save=EXTERNAL,
  default=10,
  range={max=100,min=0,increment=5},
}

this.fultonDontApplyMbMedicalToSleep={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.fultonHostageHandling={
  save=EXTERNAL,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}

this.fultonWildCardHandling={--WIP
  save=EXTERNAL,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}

this.fultonMotherBaseHandling={ --WIP
  save=EXTERNAL,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
}
--<fulton success

--item levels>
--CULL this.handLevelRange={max=4,min=0,increment=1}
local handLevelSettings={"DEFAULT","DISABLE","GRADE2","GRADE3","GRADE4"}
this.handLevelSonar={
  save=EXTERNAL,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_ACTIVESONAR,
}

this.handLevelPhysical={--tex called Mobility in UI
  save=EXTERNAL,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_PHYSICAL,
}

this.handLevelPrecision={
  save=EXTERNAL,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_PRECISION,
}

this.handLevelMedical={
  save=EXTERNAL,
  settings=handLevelSettings,
  settingNames="handLevelSettings",
  equipId=TppEquip.EQP_HAND_MEDICAL,
}

this.itemLevelFulton={
  save=EXTERNAL,
  settings={"DEFAULT","GRADE1","GRADE2","GRADE3","GRADE4"},
  equipId=TppEquip.EQP_IT_Fulton,
}
this.itemLevelWormhole={
  save=EXTERNAL,
  --range=this.switchRange,
  settings={"DEFAULT","DISABLE","ENABLE"},
  equipId=TppEquip.EQP_IT_Fulton_WormHole,
}
--<item levels
this.primaryWeaponOsp={
  save=EXTERNAL,
  range=this.switchRange,
  settings=ospSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{primaryHip="EQP_None"}},
  },
}
this.secondaryWeaponOsp={
  save=EXTERNAL,
  range=this.switchRange,
  settings=ospSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{secondary="EQP_None"}},
  },
}
this.tertiaryWeaponOsp={
  save=EXTERNAL,
  range=this.switchRange,
  settings=ospSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF=nil,
    EQUIP_NONE={{primaryBack="EQP_None"}},
  },
}

-- revenge/enemy prep stuff>
IvarProc.MissionModeIvars(
  this,
  "revengeMode",
  {
    save=EXTERNAL,
    settings={"DEFAULT","CUSTOM","NONDEFAULT"},
    settingNames="revengeModeSettings",
    OnChange=function()
      TppRevenge._SetUiParameters()
    end,
  },
  IvarProc.missionModesAll
)

this.revengeModeMB.settings={"OFF","FOB","DEFAULT","CUSTOM","NONDEFAULT"}--DEFAULT = normal enemy prep system (which isn't usually used for MB)
this.revengeModeMB.settingNames="revengeModeMBSettings"

this.revengeBlockForMissionCount={
  save=EXTERNAL,
  default=3,
  range={max=10},
}

this.disableNoRevengeMissions={--WIP
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableNoStealthCombatRevengeMission={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.revengeDecayOnLongMbVisit={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMbAll,
}

this.applyPowersToLrrp={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.applyPowersToOuterBase={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}


IvarProc.MissionModeIvars(
  this,
  "allowHeavyArmor",
  {
    save=EXTERNAL,
    range=this.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MISSION",}
)

--WIP TODO either I got rid of this functionality at some point or I never implemented it (I could have sworn I did though)
--this.allowLrrpArmorInFree={
--  save=EXTERNAL,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

this.allowHeadGearCombo={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  allowHeadGearComboThreshold=120,
}

this.allowMissileWeaponsCombo={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.balanceHeadGear={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  balanceHeadGearThreshold=100,
}

this.balanceWeaponPowers={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  balanceWeaponsThreshold=100,
}

this.disableConvertArmorToShield={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableMissionsWeaponRestriction={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableMotherbaseWeaponRestriction={--WIP
  --OFF WIP save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.enableMgVsShotgunVariation={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.randomizeSmallCpPowers={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--TODO: CULL
IvarProc.MissionModeIvars(
  this,
  "enableDDEquip",
  {
    --OFF save=EXTERNAL,--
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
  save=EXTERNAL,
  settings={"OFF","ON_CONFIG","FORCE_CONFIG"},
}

this.forceReinforceRequest={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.enableHeliReinforce={--tex chance of heli being chosen for a reinforce, also turns off heli quests
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function()
    this.UpdateActiveQuest()--tex update since quests may have changed
  end,
}

this.enableSoldiersWithVehicleReinforce={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.disableReinforceHeliPullOut={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--this.currentReinforceCount={--NONUSER
--  save=EXTERNAL,
--  range={max=100},
--}

--lrrp
this.enableLrrpFreeRoam={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

--wildcard
this.enableWildCardFreeRoam={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

this.enableWildCardHostageFREE={--WIP
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

this.enableSecurityCamFREE={--WIP
  save=EXTERNAL,
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
  save=EXTERNAL,
  settings={"OFF","SINGULAR","EACH_VEHICLE"},
  MissionCheck=IvarProc.MissionCheckFree,
}
this.vehiclePatrolLvEnable={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.vehiclePatrolTruckEnable={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.vehiclePatrolWavEnable={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.vehiclePatrolWavHeavyEnable={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.vehiclePatrolTankEnable={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.vehiclePatrolPaintType={
  --OFF save=EXTERNAL,
  range={max=10},
}

this.vehiclePatrolClass={
  save=EXTERNAL,
  settings={"DEFAULT","DARK_GRAY","OXIDE_RED","RANDOM","RANDOM_EACH","ENEMY_PREP"},
}

this.vehiclePatrolEmblemType={
  --OFF save=EXTERNAL,
  range={max=10},
}

IvarProc.MissionModeIvars(
  this,
  "heliPatrols",
  {
    save=EXTERNAL,
    settings={"OFF","ON"},
  },
  {"FREE","MB",}
)

this.heliPatrolsMB.settings={"OFF","UTH","HP48","UTH_AND_HP48"}

--CULL
--this.enemyHeliPatrol={
--  save=EXTERNAL,
--  settings={"OFF","1","3","5","7","ENEMY_PREP"},
--  MissionCheck=IvarProc.MissionCheckFree,
--}

this.putEquipOnTrucks={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}
--<patrol vehicle stuff
IvarProc.MissionModeIvars(
  this,
  "startOnFoot",
  {
    save=EXTERNAL,
    settings={"OFF","NOT_ASSAULT","ALL"},
    settingNames="onFootSettingsNames",
  },
  {"FREE","MISSION","MB_ALL"}
)

this.clockTimeScale={
  save=EXTERNAL,
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

--tex CULL
--this.forceSoldierSubType={--DEPENDENCY soldierTypeForced WIP
--  save=EXTERNAL,
--  settings={
--    "DEFAULT",
--    "DD_A",
--    "DD_PW",
--    "DD_FOB",
--    "SKULL_CYPR",
--    "SKULL_AFGH",
--    "SOVIET_A",
--    "SOVIET_B",
--    "PF_A",
--    "PF_B",
--    "PF_C",
--    "CHILD_A",
--  },
--  --settingNames=InfEneFova.enemySubTypes,
--  OnChange=function(self,prevSetting,setting)
--    if setting==0 then
--      InfMain.ResetCpTableToDefault()
--    end
--  end,
--}

IvarProc.MissionModeIvars(
  this,
  "changeCpSubType",
  {
    save=EXTERNAL,
    range=this.switchRange,
    settingNames="set_switch",
    OnChange=function(self,prevSetting,setting)
      if setting==0 then
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
  save=EXTERNAL,
  settings={"OFF","REPOP","OPEN"},
  OnChange=this.UpdateActiveQuest,
}

this.unlockSideOpNumber={
  save=EXTERNAL,
  range={max=157},--DYNAMIC, TODO: AutoDoc won't pull an accurate count, also this wont update till actually selected meaning profile wont be able to set to new sideops.
  SkipValues=function(self,newSetting)
    local questName=TppQuest.questNameForUiIndex[newSetting]
    --InfCore.DebugPrint(questName)--DEBUG
    return InfQuest.BlockQuest(questName)
  end,
  OnSelect=function(self,setting)
    self.range.max=#TppQuest.GetQuestInfoTable()
    if setting>self.range.max then
      self:Set(0)
    end
  end,
  OnChange=this.UpdateActiveQuest,
}

local ivarPrefix="sideops_"
--DEBUGNOW SYNC TppQuest. TODO: don't like this
this.QUEST_CATEGORIES={
  "STORY",--11,7,2,2
  "EXTRACT_INTERPRETER",--4,2,2
  "BLUEPRINT",--6,4,2,Secure blueprint
  "EXTRACT_HIGHLY_SKILLED",--16,9,,Extract highly-skilled soldier
  "PRISONER",--20,10,Prisoner extraction
  "CAPTURE_ANIMAL",--4,2,
  "WANDERING_SOLDIER",--10,5,Wandering Mother Base soldier
  "DDOG_PRISONER",--5,Unlucky Dog
  "ELIMINATE_HEAVY_INFANTRY",--16
  "MINE_CLEARING",--10
  "ELIMINATE_ARMOR_VEHICLE",--14,Eliminate the armored vehicle unit
  "EXTRACT_GUNSMITH",--3,Extract the Legendary Gunsmith
  --"EXTRACT_CONTAINERS",--1, #110
  --"INTEL_AGENT_EXTRACTION",--1, #112
  "ELIMINATE_TANK_UNIT",--14
  "ELIMINATE_PUPPETS",--15
  "TARGET_PRACTICE",--7,0,0,7
}
for i,categoryName in ipairs(this.QUEST_CATEGORIES)do
  local ivarName=ivarPrefix..categoryName
  local ivar={
    save=EXTERNAL,
    default=1,
    range=this.switchRange,
    settingNames="set_switch",
    OnChange=this.UpdateActiveQuest,
  }
  this[ivarName]=ivar
end

this.sideOpsSelectionMode={
  save=EXTERNAL,
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
  OnChange=this.UpdateActiveQuest,
}

--mbshowstuff
this.mbShowBigBossPosters={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowQuietCellSigns={
  --OFF save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowMbEliminationMonument={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowSahelan={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowAiPod={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowEli={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowCodeTalker={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbUnlockGoalDoors={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnableOcelot={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,
}

this.mbEnablePuppy={
  save=EXTERNAL,
  settings={"OFF","MISSING_EYE","NORMAL_EYES"},
  OnChange=function(self,prevSetting,setting)
    local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
    if setting==0 then
      gvars.qst_questRepopFlag[puppyQuestIndex]=false
      gvars.qst_questOpenFlag[puppyQuestIndex]=false
    else
      local puppyQuestIndex=TppDefine.QUEST_INDEX.Mtbs_child_dog
      gvars.qst_questRepopFlag[puppyQuestIndex]=true
      gvars.qst_questOpenFlag[puppyQuestIndex]=true
    end
    TppQuest.UpdateRepopFlagImpl(TppQuestList.questList[17])--MtbsCommand
    TppQuest.UpdateActiveQuest()
  end,
  MissionCheck=IvarProc.MissionCheckMb,
}

this.mbEnableBirds={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckMb,--TODO extend to quarantine, and zoo? lol
}

this.mbDontDemoDisableBuddy={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbCollectionRepop={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbMoraleBoosts={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}
--
this.manualMissionCode={
  --OFF save=EXTERNAL,
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
this.playerType={
  --OFF save=EXTERNAL,
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
  GetSettingText=function(self,setting)
    local playerType=self.settingsTable[setting+1]
    local playerTypeInfo=InfFova.playerTypesInfo[playerType+1]
    return playerTypeInfo.description or playerTypeInfo.name
  end,
  OnSelect=function(self)
    ivars[self.name]=self.playerTypeToSetting[vars.playerType]
  end,
  OnChange=function(self,previousSetting,setting)

    local currentPlayerType=vars.playerType
    local newSetting=self:GetTableSetting()
    if newSetting==currentPlayerType then
      return
    end

    if (InfFova.playerTypeGroup.VENOM[newSetting] and InfFova.playerTypeGroup.DD[currentPlayerType])
      or (InfFova.playerTypeGroup.VENOM[currentPlayerType] and InfFova.playerTypeGroup.DD[newSetting]) then
      --InfCore.DebugPrint"playerTypeGroup changed"--DEBUG
      vars.playerPartsType=0
    end

    if currentPlayerType==PlayerType.DD_MALE then
      Ivars.maleFaceId:Set(vars.playerFaceId)
    elseif currentPlayerType==PlayerType.DD_FEMALE then
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

    vars.playerType=newSetting
  end,
}

this.playerTypeDirect={
  --OFF save=EXTERNAL,
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
    ivars[self.name]=self.playerTypeToSetting[vars.playerType]
  end,
  OnActivate=function(self,setting)
  --self:OnChange(setting,setting)
  end,
}

--tex seperate from InfFova so can control order from playerPartsType
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
  "MGS3",--15
  "MGS3_NAKED",--16
  "MGS3_SNEAKING",--17
  "MGS3_TUXEDO",--18
  "EVA_CLOSE",--19
  "EVA_OPEN",--20
  "BOSS_CLOSE",--21
  "BOSS_OPEN",--22
}

this.playerPartsType={
  --OFF save=EXTERNAL,
  settings=playerPartsTypeSettings,--DYNAMIC
  GetSettingText=function(self,setting)
    local InfFova=InfFova
    local partsTypeName=self.settings[setting+1]
    local partsType=InfFova.PlayerPartsType[partsTypeName]
    local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]

    local playerTypeName=InfFova.playerTypes[vars.playerType+1]

    local fovaTable,modelDescription=InfFova.GetFovaTable(playerTypeName,partsTypeName)

    return modelDescription or partsTypeInfo.description or partsTypeInfo.name
  end,
  OnSelect=function(self)
    local playerPartsTypes=InfFova.GetPlayerPartsTypes(playerPartsTypeSettings,vars.playerType)
    if playerPartsTypes==nil then
      return
    end

    self.settings=playerPartsTypes
    self.range.max=#playerPartsTypes-1
    self.enum=TppDefine.Enum(self.settings)
    if #self.settings==0 then
      InfCore.DebugPrint("WARNING: #self.settings==0 for playerType")
      return
    end

    local partsTypeName=InfFova.playerPartsTypes[vars.playerPartsType+1]
    local setting=self.enum[partsTypeName]
    if setting==nil then
      --InfCore.DebugPrint("WARNING: could not find enum for "..partsTypeName)--DEBUG
      ivars[self.name]=0
    else
      ivars[self.name]=self.enum[partsTypeName]
    end
  end,
  OnChange=function(self,previousSetting,setting)
    local partsTypeName=self.settings[setting+1]

    local playerCamoTypes=InfFova.GetCamoTypes(partsTypeName)
    if playerCamoTypes==nil then
      return
    end

    --InfCore.PrintInspect(playerCamoTypes)--DEBUG
    local enum=TppDefine.Enum(playerCamoTypes)
    local camoName=InfFova.playerCamoTypes[vars.playerCamoType+1]
    --InfCore.DebugPrint(camoName)--DEBUG

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
  --OFF save=EXTERNAL,
  range={min=0,max=100},
  OnSelect=function(self)
    ivars[self.name]=vars.playerPartsType
  end,
  OnActivate=function(self,setting)
    vars.playerPartsType=setting
  end,
}

--tex GOTCHA: setting var.playerCamoType to a unique type (non-common/only one camo type for it) seems to lock it in/prevent vars.playerPartsType from applying until set back to a common camo type
this.playerCamoType={
  --OFF save=EXTERNAL,
  --settings=playerCamoTypes,--DYNAMIC
  range={min=0,max=1000},--DYNAMIC
  GetSettingText=function(self,setting)
    local camoName=self.settings[setting+1]
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

    --InfCore.PrintInspect(playerCamoTypes)--DEBUG
    local enum=TppDefine.Enum(playerCamoTypes)
    local camoName=InfFova.playerCamoTypes[vars.playerCamoType+1]
    --InfCore.DebugPrint(camoName)--DEBUG

    local camoSetting=enum[camoName]
    if camoSetting==nil then
      camoSetting=0
    end

    ivars[self.name]=camoSetting

    self.settings=playerCamoTypes
    self.enum=enum
    self.range.max=#self.settings-1
  end,
  OnChange=function(self,previousSetting,setting)
    local camoName=self.settings[setting+1]
    vars.playerCamoType=PlayerCamoType[camoName]
  end,
}

--tex for DEBUG, just exploring direct value
this.playerCamoTypeDirect={
  range={min=0,max=1000},
  OnSelect=function(self)
    self:SetDirect(vars.playerCamoType)
  end,
  OnActivate=function(self,setting)
    vars.playerCamoType=setting
    -- vars.playerPartsType=PlayerPartsType.NORMAL--TODO: camo wont change unless this (one or both, narrow down which) set
    -- vars.playerFaceEquipId=0
  end,
}

this.playerFaceEquipId={
  --OFF save=EXTERNAL,
  range={min=0,max=100},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=function(self,setting)
    local faceEquipId=self.settingsTable[setting+1]
    local faceEquipInfo=InfFova.playerFaceEquipIdInfo[faceEquipId+1]
    return faceEquipInfo.description or faceEquipInfo.name
  end,
  OnSelect=function(self)
    self:SetDirect(0)
    local settingsTable={}
    for i,faceEquipInfo in ipairs(InfFova.playerFaceEquipIdInfo)do
      if faceEquipInfo.playerTypes==nil or faceEquipInfo.playerTypes[vars.playerType] then
        local playerFaceEquipId=i-1
        table.insert(settingsTable,playerFaceEquipId)
        if playerFaceEquipId==vars.playerType then
          self:SetDirect(playerFaceEquipId)
        end
      end
    end

    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnChange=function(self,previousSetting,setting)
    vars.playerFaceEquipId=self.settingsTable[setting+1]
  end,
}

this.playerFaceEquipIdDirect={
  --OFF save=EXTERNAL,
  range={min=0,max=100},--TODO
  OnSelect=function(self)
    self:SetDirect(vars.playerFaceEquipId)
  end,
  OnActivate=function(self,setting)
    vars.playerFaceEquipId=setting
  end,
}

this.playerFaceId={
  --save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  currentGender=0,--STATE
  settingsTable={1},--DYNAMIC
  --noSettingCounter=true,
  GetSettingText=function(self,setting)
    return InfCore.PCall(function(self)--DEBUG
      if InfFova.playerTypeGroup.VENOM[vars.playerType] then
        return InfMenu.LangString"only_for_dd_soldier"
    end

    local faceDefId=self.settingsTable[setting+1]
    local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
    local faceId=faceDef[1]

    local InfModelRegistry=InfModelProc.infModelRegistry--tex WORKAROUND
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
    end,self,setting)--DEBUG
  end,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self:SetDirect(0)
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

    local filter=Ivars.playerFaceFilter:GetTableSetting()
    local isUpperLimit=type(filter)=="number"
    local isDirect=type(filter)=="table"
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      local faceId=entry[1]
      if (isUpperLimit and faceId>=filter) or (isDirect and filter[faceId]) then
        if entry[InfEneFova.faceDefinitionParams.gender]==gender then
          if not faceModSlots[faceId] then
            table.insert(settingsTable,i)
          end
        end
      end
    end

    if #settingsTable==0 then
      self:SetDirect(0)
      self.settingsTable={0}
      self.range.max=0
      return
    end

    --tex don't need to sort, assuming faceDefinition entries are also in ascending faceId

    if self.currentGender~=gender then
      self:SetDirect(0)
    end

    local foundFace=false
    --tex set setting to current face, TODO grinding through whole table isnt that nice, build a faceId to faceDef lookup
    for i,faceDefId in ipairs(settingsTable)do
      local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
      if vars.playerFaceId==faceDef[1] then
        self:SetDirect(i-1)
        foundFace=true
        break
      end
    end

    if not foundFace then
      self:SetDirect(0)
      local faceDefId=settingsTable[1]
      local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
      vars.playerFaceId=faceDef[1]
    end

    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
    self.currentGender=gender
  end,
  OnChange=function(self,previousSetting,setting)
    local faceDefId=self.settingsTable[setting+1]
    local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
    vars.playerFaceId=faceDef[1]
  end,
}

this.playerFaceFilter={
  --save=EXTERNAL,
  settings={"ALL","HEADGEAR","UNIQUE","FOVAMOD"},
  settingsTable={
    ALL=0,
    HEADGEAR={
      --male
      [550]=true,--Balaclava Male
      [551]=true,--Balaclava Male
      [552]=true,--DD armor helmet (green top)
      [558]=true,--Gas mask and clava Male
      [560]=true,--Gas mask DD helm Male
      [561]=true,--Gas mask DD greentop helm Male
      [564]=true,--NVG DDgreentop Male
      [565]=true,--NVG DDgreentop GasMask Male
      --female
      [555]=true,--DD armor helmet (green top) female - i cant really tell any difference between
      [559]=true,--Gas mask and clava Female
      [562]=true,--Gas mask DD helm Female
      [563]=true,--Gas mask DD greentop helm Female
      [566]=true,--NVG DDgreentop Female (or just small head male lol, total cover)
      [567]=true,--NVG DDgreentop GasMask
    },
    UNIQUE={
      --male
      [602]=true,--glasses,
      [621]=true,--Tan
      --[622]=true,--hideo, not working outside mission
      [627]=true,--finger
      [628]=true,--eye
      [646]=true,--beardy mcbeard
      [680]=true,--fox hound tattoo
      [683]=true,--red hair]=true, ddogs tattoo
      [684]=true,--fox tattoo
      [687]=true,--while skull tattoo
      [688]=true,--IH hideo entry
      --female
      [681]=true,--female tatoo fox hound black
      [682]=true,--female tatoo whiteblack ddog red hair
      [685]=true,--female tatoo fox black
      [686]=true,--female tatoo skull white white hair
    },

    FOVAMOD=687,--SYNC Soldier2FaceAndBodyData.highestVanillaFaceId,
  },
}

this.playerFaceIdDirect={
  save=EXTERNAL,
  range={min=0,max=687},
  OnSelect=function(self)
    self:SetDirect(vars.playerFaceId)
  end,
  OnActivate=function(self,setting)
    vars.playerFaceId=setting
  end,
}

--tex saving prefered faceId per gender
this.maleFaceId={
  save=EXTERNAL,
  default=0,
  range={min=0,max=5000},--TODO sync max?, Soldier2FaceAndBodyData.MAX_FACEID, but since since ivar gvar size is based on range.max, make sure ivars that change their max during run have a specified fixed size, because I don't  know if the save system is robust enough to handle size changes.
}

this.femaleFaceId={
  save=EXTERNAL,
  default=350,
  range={min=0,max=5000},--TODO see above
}

--tex WIP
this.faceFova={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=function(self,setting)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      return InfMenu.LangString"only_for_dd_soldier"
    end
    local faceFova=self.settingsTable[setting+1]
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
    --InfCore.PrintInspect(settingsTable)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}

this.faceDecoFova={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=function(self,setting)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      return InfMenu.LangString"only_for_dd_soldier"
    end
    local faceDecoFova=self.settingsTable[setting+1]
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
    local faceFova=Ivars.faceFova:GetTableSetting()

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
    InfCore.PrintInspect(settingsTable,{varName="Ivars.faceDecoFova.settingsTable"})--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}
this.hairFova={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=function(self,setting)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      return InfMenu.LangString"only_for_dd_soldier"
    end
    local hairFova=self.settingsTable[setting+1]
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
    --InfCore.PrintInspect(settings)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --InfEneFova.ApplyFaceFova()
  end,
}
this.hairDecoFova={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
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
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.faceFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceDecoFovaDirect={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.faceDecoFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.hairFovaDirect={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.hairFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.hairDecoFovaDirect={
  --OFF save=EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.hairDecoFova-1
  end,
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}

this.faceFovaUnknown1={
  --OFF save=EXTERNAL,
  range={min=0,max=50},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown2={
  --OFF save=EXTERNAL,
  range={min=0,max=1},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown3={
  --OFF save=EXTERNAL,
  range={min=0,max=4},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown4={
  --OFF save=EXTERNAL,
  range={min=0,max=4},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown5={
  --OFF save=EXTERNAL,
  range={min=0,max=1},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown6={
  --OFF save=EXTERNAL,
  range={min=0,max=3},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown7={
  --OFF save=EXTERNAL,
  range={min=0,max=303},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown8={
  --OFF save=EXTERNAL,
  range={min=0,max=303},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown9={
  --OFF save=EXTERNAL,
  range={min=0,max=303},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
this.faceFovaUnknown10={
  --OFF save=EXTERNAL,
  range={min=0,max=3},
  OnActivate=function(self)
    InfEneFova.ApplyFaceFova()
  end,
}
--
--fovaInfo
this.enableFovaMod={
  nonConfig=true,--tex too dependant on installed mods/dynamic settings
  save=EXTERNAL,
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
  save=EXTERNAL,
  range={min=0,max=255},--DYNAMIC limits max fovas TODO consider
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
        --InfCore.DebugPrint"OnSelect FovaInfoChanged"--DEBUG
        self:Reset()
      end

      self.settingNames={}
      for i=1,#fovaTable do
        local fovaDescription,fovaFile=InfFova.GetFovaInfo(fovaTable,i)

        if not fovaDescription or not type(fovaDescription)=="string"then
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
  --    InfCore.DebugPrint"fovaSelection OnDeselect"--DEBUG
  --    if Ivars.enableMod:Is(0) then
  --    --InfMenu.PrintLangId"fova_is_not_set"--DEBUG
  --    end
  --  end,
  OnChange=function(self)
    InfFova.SetFovaMod(self:Get()+1,true)
  end,
}

this.fovaPlayerType={
  nonUser=true,--DEBUGNOW set
  save=MISSION,
  range={min=0,max=3},
}

this.fovaPlayerPartsType={
  nonUser=true,
  save=MISSION,--DEBUGNOW set
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
--  --save=EXTERNAL,
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
  --OFF save=EXTERNAL,
  settings=playerHandEquipTypes,

  settingsTable=playerHandEquipIds,
  --settingNames="set_",
  OnSelect=function(self)
  -- self:Set(vars.playerHandEquip,true)
  end,
  OnChange=function(self,previousSetting,setting)
    if setting>0 then--TODO: add off/default/noset setting
      --DEBUG OFF vars.playerHandType=handEquipTypeToHandType[playerHandEquipTypes[setting]]
      vars.handEquip=self.settingsTable[setting]
    end
  end,
}

--CULL
this.playerHeadgear={--DOC: player appearance.txt
  save=EXTERNAL,
  range={max=1},--DYNAMIC
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
  OnSelect=function(self,currentSetting)
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
    if currentSetting>self.range.max then
      self:Set(1)
    elseif currentSetting>0 then
      self:Set(currentSetting)
    end
  end,
  OnChange=function(self,previousSetting,setting)
    if setting==0 then

    else
      if vars.playerType~=PlayerType.DD_MALE and vars.playerType~=PlayerType.DD_FEMALE then
        InfMenu.PrintLangId"setting_only_for_dd"
        return
      end
      vars.playerFaceId=self.settingsTable[setting+1]
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
  save=EXTERNAL,
  settings=this.phaseSettings,
  --settingsTable=this.phaseTable,
  OnChange=function(self,previousSetting,setting)
    if setting>Ivars.maxPhase:Get() then
      Ivars.maxPhase:Set(setting)
    end

    InfEnemyPhase.execState.nextUpdate=0
  end,
}

this.maxPhase={
  save=EXTERNAL,
  settings=this.phaseSettings,
  default=#this.phaseSettings-1,
  --settingsTable=this.phaseTable,
  OnChange=function(self,previousSetting,setting)
    if setting<Ivars.minPhase:Get() then
      Ivars.minPhase:Set(setting)
    end

    InfEnemyPhase.execState.nextUpdate=0
  end,
}

this.keepPhase={
  save=EXTERNAL,
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

this.phaseUpdateRate={--seconds
  save=EXTERNAL,
  default=3,
  range={min=1,max=255},
}
this.phaseUpdateRange={--seconds
  save=EXTERNAL,
  range={min=0,max=255},
}

this.phaseUpdate={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,previousSetting,setting)
    InfEnemyPhase.execState.nextUpdate=0
  end,
}

this.printPhaseChanges={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--
this.soldierAlertOnHeavyVehicleDamage={
  save=EXTERNAL,
  settings=this.phaseSettings,
}

this.cpAlertOnVehicleFulton={
  --OFF WIP save=EXTERNAL,
  settings=this.phaseSettings,
}

--this.ogrePointChange={
--  --save=EXTERNAL,
--  default=-100,
--  range={min=-10000,max=10000,increment=100},
--}

--this.ogrePointChange={
--  save=EXTERNAL,
--  settings={"DEFAULT","NORMAL","DEMON"},
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
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.warpPlayerUpdate={
  nonConfig=true,
  --save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  isMode=true,
  --tex WIP OFF disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,
  OnModeActivate=function()InfMain.OnActivateWarpPlayer()end,
  OnChange=function(self,previousSetting,setting)
    if Ivars.adjustCameraUpdate:Is(1) then
      self:SetDirect(0)
      InfMenu.PrintLangId"other_control_active"
    end

    if setting==1 then
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
}

this.adjustCameraUpdate={
  nonConfig=true,
  --save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  isMode=true,
  --disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,--tex OFF not really needed, padmask is sufficient
  OnModeActivate=function()InfCamera.OnActivateCameraAdjust()end,
  OnChange=function(self,previousSetting,setting)
    if Ivars.warpPlayerUpdate:Is(1) then
      self:SetDirect(0)
      InfMenu.PrintLangId"other_control_active"
      return
    end

    if setting==1 then
      --      if Ivars.cameraMode:Is(0) then
      --        InfMenu.PrintLangId"cannot_edit_default_cam"
      --        setting=0
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
}

this.cameraMode={
  --save=EXTERNAL,
  settings={"DEFAULT","CAMERA"},--"PLAYER","CAMERA"},
  OnChange=function(self,previousSetting)
    if self:Is"DEFAULT" then
      Player.SetAroundCameraManualMode(false)
    else
      Player.SetAroundCameraManualMode(true)
      InfCamera.UpdateCameraManualMode()
    end
  end,
}

--tex DEBUGNOW Set
this.moveScale={
  save=EXTERNAL,
  default=0.5,
  range={max=10,min=0.01,increment=0.1},
}

this.disableCamText={
  --OFF save=EXTERNAL,
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
    --OFF save=EXTERNAL,
    default=21,
    range={max=10000,min=0.1,increment=1},
  }

  this["focusDistance"..camName]={
    --OFF save=EXTERNAL,
    default=8.175,
    range={max=1000,min=0.01,increment=0.1},
  }

  this["aperture"..camName]={
    --OFF save=EXTERNAL,
    default=1.875,
    range={max=100,min=0.001,increment=0.1},
  }

  this["distance"..camName]={
    --OFF save=EXTERNAL,
    default=0,--WIP TODO need seperate default for playercam and freemode (player wants to be about 5, free 0)
    range={max=100,min=0,increment=0.1},
  }

  this["positionX"..camName]={
    --OFF save=EXTERNAL,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
  this["positionY"..camName]={
    --OFF save=EXTERNAL,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
  this["positionZ"..camName]={
    --OFF save=EXTERNAL,
    default=0,
    range={max=1000,min=0,increment=0.1},
    noBounds=true,
  }
end

--highspeedcamera/slowmo
this.speedCamContinueTime={
  save=EXTERNAL,
  default=10,
  range={max=1000,min=0,increment=1},
}
this.speedCamWorldTimeScale={
  save=EXTERNAL,
  default=0.3,
  range={max=100,min=0,increment=0.1},
}
this.speedCamPlayerTimeScale={
  save=EXTERNAL,
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

local BuddyVarGetSettingText=function(self,setting)
  if vars.buddyType==BuddyType.NONE then
    return InfMenu.LangString"no_buddy_set"
  end

  local commandInfo=GetCommandInfo(self.name)
  if not commandInfo then
    return InfMenu.LangString"none_defined"
  end

  local varTypeTable=commandInfo.varTypeTable
  return varTypeTable[setting].name
end
local BuddyVarOnSelect=function(self,currentSetting)
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
  self:SetDirect(index)
end
local BuddyVarOnActivate=function(self,setting)
  if vars.buddyType==BuddyType.NONE then
    return
  end

  local commandInfo=GetCommandInfo(self.name)
  if not commandInfo then
    return
  end
  InfBuddy.ChangeBuddyVar(commandInfo,setting)
end

this.buddyChangeEquipVar={
  nonConfig=true,
  --OFF save=EXTERNAL,
  range={max=5,min=1},
  GetSettingText=BuddyVarGetSettingText,
  OnSelect=BuddyVarOnSelect,
  OnActivate=BuddyVarOnActivate,
}

--quiet
this.quietRadioMode={
  save=EXTERNAL,
  range={min=0,max=31},
  OnChange=function(self,previousSetting,setting)
    if setting>0 or previousSetting~=0 then
      if f30050_sequence and mvars.f30050_quietRadioName then
        f30050_sequence.PlayMusicFromQuietRoom()
      end
    end
  end,
}

this.repopulateRadioTapes={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

-- walkergear
IvarProc.MissionModeIvars(
  this,
  "enableWalkerGears",
  {
    save=EXTERNAL,
    range=this.switchRange,
    settingNames="set_switch",
  },
  {"FREE","MB"}
)


this.mbWalkerGearsColor={
  save=EXTERNAL,
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
}

this.mbWalkerGearsWeapon={
  save=EXTERNAL,
  settings={
    "DEFAULT",--dont apply specific value, seems to alternate to give an even count of miniguns and missiles
    "MINIGUN",
    "MISSILE",
    "RANDOM",--all of one type
    "RANDOM_EACH",
  },
}
--

--CULL
--this.npcUpdate={--tex NONUSER
--  --save=MISSION,
--  nonUser=true,
--  default=1,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

--CULL
--this.npcOcelotUpdate={--tex NONUSER
--  --save=MISSION,
--  nonUser=true,
--  default=1,
--  range=this.switchRange,
--  settingNames="set_switch",
--  execCheckTable={inGame=true,inHeliSpace=false},
--  MissionCheck=IvarProc.MissionCheckMb,
--}

--CULL
--this.npcHeliUpdate={
--  save=EXTERNAL,
--  settings={"OFF","UTH","HP48","UTH_AND_HP48"},
--  MissionCheck=IvarProc.MissionCheckMb,
--}

--support heli
--this.heliUpdate={--tex NONUSER, InfHeli always active to pick up pull out
--  --save=MISSION,
--  nonUser=true,
--  default=1,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

this.defaultHeliDoorOpenTime={--seconds
  save=EXTERNAL,
  default=15,
  range={min=0,max=120},
}

local HeliEnabledGameCommand=function(self,previousSetting,setting)
  if TppMission.IsFOBMission(vars.missionCode) then return end
  local enable=setting==1
  local gameObjectId = GetGameObjectId("TppHeli2", "SupportHeli")
  if gameObjectId ~= nil and gameObjectId ~= NULL_ID then
    GameObject.SendCommand(gameObjectId,{id=self.gameEnabledCommand,enabled=enable})
  end
end

this.enableGetOutHeli={--WIP TEST force every frame via update to see if it actually does anything beyond the allow get out when allready at LZ
  --OFF save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  gameEnabledCommand="SetGettingOutEnabled",
  OnChange=HeliEnabledGameCommand,
}

this.setInvincibleHeli={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  gameEnabledCommand="SetInvincible",
  OnChange=HeliEnabledGameCommand,
}

this.setTakeOffWaitTime={--tex NOTE: 0 is wait indefinately WIP TEST, maybe it's not what I think it is, check the instances that its used and see if its a take-off empty wait or take-off with player in wait
  --OFF save=EXTERNAL,
  default=5,--tex from TppHelicopter.SetDefaultTakeOffTime
  range={min=0,max=15},
  OnChange=function(self,previousSetting,setting)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetTakeOffWaitTime",time=setting})
    end
  end,
}

this.disablePullOutHeli={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,previousSetting,setting)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local set=setting==1
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      local command
      if set then
        command="DisablePullOut"
      else
        command="EnablePullOut"
      end
      GameObject.SendCommand(gameObjectId,{id=command})
      InfHelicopter.HeliOrderRecieved()
    end
  end,
}

this.setLandingZoneWaitHeightTop={
  save=EXTERNAL,
  default=20,--tex the command is only used in sahelan mission, so don't know if this is actual default,
  range={min=5,max=50,increment=5},
  OnChange=function(self,previousSetting,setting)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetLandingZoneWaitHeightTop",height=setting})
    end
  end,
}

this.disableDescentToLandingZone={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,previousSetting,setting)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local set=setting==1
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
  save=EXTERNAL,
  settings={"DEFAULT","OFF","ON"},
  settingNames="set_default_off_on",
  OnChange=function(self,previousSetting,setting)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GetGameObjectId("TppHeli2","SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      local command
      if setting==1 then
        command={id="SetSearchLightForcedType",type="On"}
      elseif setting==2 then
        command={id="SetSearchLightForcedType",type="Off"}
      end
      if command then
        GameObject.SendCommand(gameObjectId,command)
        InfHelicopter.HeliOrderRecieved()
      end
    end
  end,
}

this.selectedCp={
  nonConfig=true,
  --save=EXTERNAL,
  range={max=9999},--DYNAMIC (not currently, TODO)
  prev=nil,--STATE
  GetNext=function(self,currentSetting)
    self.prev=self.setting
    if mvars.ene_cpList==nil then
      InfCore.DebugPrint"mvars.ene_cpList==nil"--DEBUG
      return 0
    end--

    local nextSetting=currentSetting
    if currentSetting==0 then
      nextSetting=next(mvars.ene_cpList)
    else
      nextSetting=next(mvars.ene_cpList,hurrentSetting)
    end
    if nextSetting==nil then
      --InfCore.DebugPrint"self setting==nil"--DEBUG
      nextSetting=next(mvars.ene_cpList)
    end
    return nextSetting
  end,
  GetPrev=function(self,currentSetting)
    local nextSetting=currentSetting
    if self.prev~=nil then
      nextSetting=self.prev
      self.prev=nil
    else
      nextSetting=next(mvars.ene_cpList)--tex go back to start
    end
    return nextSetting
  end,
  GetSettingText=function(self,setting)
    if setting==nil then
      return "nil"
    end
    if self.setting==0 then
      return "none"
    end
    return mvars.ene_cpList and mvars.ene_cpList[setting] or "no cp for setting"
  end,
}

--
local currentCategory=0
this.selectedChangeWeapon={--WIP
  --OFF save=EXTERNAL,
  range={max=490,min=1},--tex SYNC: tppEquipTable
  GetSettingText=function(self,setting)
    return InfEquip.tppEquipTableTest[setting]
  end,
  OnActivate=function(self,setting)
    local equipName=InfEquip.tppEquipTableTest[setting]
    local equipId=TppEquip[equipName]
    if equipId==nil then
      InfCore.DebugPrint("no equipId found for "..equipName)
      return
    else
      --      InfCore.DebugPrint("set "..equipName)
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

      InfCore.DebugPrint("drop "..equipName)
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
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

--item drops
this.perSoldierCount=10
this.itemDropChance={
  save=EXTERNAL,
  --range={min=0,max=this.perSoldierCount,increment=1},
  range={min=0,max=100,increment=10},
  isPercent=true,
}

--gameevent
IvarProc.MissionModeIvars(
  this,
  "gameEventChance",
  {
    save=EXTERNAL,
    range={min=0,max=100,increment=5},
    isPercent=true,
  },
  {"FREE","MB",}
)

--parasite
this.enableParasiteEvent={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFree,
}

this.armorParasiteEnabled={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mistParasiteEnabled={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.camoParasiteEnabled={
  save=EXTERNAL,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
}

this.parasiteWeather={
  save=EXTERNAL,
  default=1,--parasite
  settings={"NONE","PARASITE_FOG","RANDOM"},
}

--tex time in minutes
IvarProc.MinMaxIvar(
  this,
  "parasitePeriod",
  {
    default=10,
    OnChange=function(self)
      IvarProc.PushMax(self)
      InfParasite.StartEventTimer()
    end,
  },
  {
    default=30,
    OnChange=function(self)
      IvarProc.PushMin(self)
      InfParasite.StartEventTimer()
    end,
  },
  {
    range={min=0,max=180,increment=1},
  }
)
--

this.selectProfile={
  nonConfig=true,
  --save=EXTERNAL,
  range={min=0,max=0},--DYNAMIC
  GetSettingText=function(self,setting)
    if Ivars.profiles==nil or self.settings==nil then
      return InfMenu.LangString"no_profiles_installed"
    else
      local profileName=self.settings[setting+1]
      local profileInfo=Ivars.profiles[profileName]
      return profileInfo.description or profileName
    end
  end,
  OnSelect=function(self)
    local profileNames=Ivars.profileNames
    if profileNames then
      self.range.max=#profileNames-1
      self.settings=profileNames
    else
      self.range.max=0
      ivars[self.name]=0
    end
  end,
  OnActivate=function(self,setting)
    if self.settings==nil then
      InfMenu.PrintLangId"no_profiles_installed"
    end

    local profileName=self.settings[setting+1]
    local profileInfo=Ivars.profiles[profileName]
    --local profileDescription=profileInfo.description or profileName
    InfMenu.PrintLangId"applying_profile"
    IvarProc.ApplyProfile(profileInfo.profile)
  end,
  GetProfileInfo=function(self)
    if not Ivars.profiles or self.settings==nil then
      return nil
    else
      local profileName=self:GetTableSetting()
      return Ivars.profiles[profileName]
    end
  end,
}

this.warpToListObject={
  range={max=1},--DYNAMIC
  GetSettingText=function(self,setting)
    local objectName,info,position=InfLookup.GetObjectInfoOrPos(setting+1)
    if info and not position then
      return info
    end

    return objectName.." pos:".. math.ceil(position[1])..",".. math.ceil(position[2]).. ","..math.ceil(position[3])
  end,
  OnSelect=function(self)
    local objectList=InfLookup.GetObjectList()
    local numObjects=#objectList

    self.range.max=numObjects-1
    self.setting=0
  end,
  OnActivate=function(self,setting)
    local objectName,info,position=InfLookup.GetObjectInfoOrPos(setting+1)
    if position==nil then
      return
    end

    if position[1]~=0 or position[2]~=0 or position[3]~=0 then
      position[2]=position[2]+1
      InfCore.Log(objectName.." pos:".. position[1]..",".. position[2].. ","..position[3],true)
      TppPlayer.Warp{pos=position,rotY=vars.playerCameraRotation[1]}
    end
  end,
}

this.warpToListPosition={
  range={max=1},--DYNAMIC
  GetSettingText=function(self,setting)
    local positionsList=InfQuest.GetQuestPositions()
    local position=positionsList[setting+1]
    return "pos:".. math.ceil(position[1])..",".. math.ceil(position[2]).. ","..math.ceil(position[3])
  end,
  OnSelect=function(self)
    local positionsList=InfQuest.GetQuestPositions()
    local numObjects=#positionsList

    self.range.max=numObjects-1
    self.setting=0
  end,
  OnActivate=function(self,setting)
    local positionsList=InfQuest.GetQuestPositions()
    local position=positionsList[setting+1]

    if position[1]~=0 or position[2]~=0 or position[3]~=0 then
      position[2]=position[2]+1
      InfCore.Log("pos:".. position[1]..",".. position[2].. ","..position[3],true)
      TppPlayer.Warp{pos=position,rotY=vars.playerCameraRotation[1]}
    end
  end,
}

--mines
this.randomizeMineTypes={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.additionalMineFields={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.enableResourceScale={
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function(self,previousSetting,setting)
    if setting==1 then
      InfResources.ScaleResourceTables()
    else

    end
  end,
}

this.resourceScaleTypes={
  "Material",
  "Plant",
  "Poster",
  "Diamond",
  "Container",
}

for i,resourceScaleType in ipairs(this.resourceScaleTypes)do
  local ivar={
    save=EXTERNAL,
    default=100,
    range={max=1000,min=100,increment=100},
    isPercent=true,
  }

  this["resourceScale"..resourceScaleType]=ivar
end

this.debugValue={
  save=EXTERNAL,
  default=400,
  range={max=400,min=0,increment=10},
  OnChange=function(self,previousSetting,setting)
    InfCore.Log("debugValue:"..setting)
  end,
}

--tex NOTE: not currently exposed
this.skipDevelopChecks={
  nonConfig=true,
  save=EXTERNAL,
  range=this.switchRange,
  settingNames="set_switch",
}

--non user save vars
--others grouped near usage, search NONUSER

--tex used as indicator whether save>ivars should be synced
this.inf_event={--NONUSER
  nonUser=true,--DEBUGNOW set
  save=MISSION,
  settings={"OFF","WARGAME","ROAM"},
}

this.mis_isGroundStart={--NONUSER WORKAROUND
  nonUser=true,
  save=MISSION,
  range=this.switchRange,
}

this.mbRepopDiamondCountdown={
  nonUser=true,
  save=MISSION,--DEBUGNOW set, nonuser
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

--ivar system setup>
--gvars setup
function this.DeclareVars()
  local varTable={}
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
      if ivar.save and ivar.save~=EXTERNAL then
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
          InfCore.Log("WARNING Ivars.DeclareVars could not find svarType")
        end

        local gvar={name=name,type=svarType,value=ivar.default,save=true,sync=false,wait=false,category=ivar.save}--tex what is sync? think it's network synce, but MakeSVarsTable for seqences sets it to true for all (but then 50050/fob does make a lot of use of it)
        if ok then
          varTable[#varTable+1]=gvar
        end
      end--save
    end--ivar
  end

  --InfInterrogation
  local maxQuestSoldiers=20--SYNC InfInterrogate numQuestSoldiers
  local arrays={
    {name="inf_interCpQuestStatus",arraySize=maxQuestSoldiers,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
  }
  for i,gvar in ipairs(arrays)do
    varTable[#varTable+1]=gvar
  end

  return varTable
end

--TABLESETUP: Ivars
function this.Enum(enumNames)
  if type(enumNames)~="table"then
    return
  end
  local enumTable={}
  for i,enumName in pairs(enumNames)do
    enumTable[enumName]=i-1--NMC: lua tables indexed from 1, enums indexed from 0
  end
  return enumTable
end

function this.SetupIvars()
  InfCore.LogFlow("Ivars.SetupIvars")
  local ivars=ivars
  local IvarProc=IvarProc

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
      ivars[ivar.name]=ivars[ivar.name] or ivar.default

      if ivar.settings then
        ivar.enum=this.Enum(ivar.settings)
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
      ivar.SetDirect=IvarProc.SetDirect
      ivar.Reset=IvarProc.ResetSetting
      ivar.GetTableSetting=IvarProc.GetTableSetting
      ivar.GetSettingName=IvarProc.GetSettingName
      ivar.MissionCheck=ivar.MissionCheck--tex OFF or IvarProc.MissionCheckAll--rather have the functions on it bring up warnings than have it cause issues by going through
      ivar.EnabledForMission=IvarProc.IvarEnabledForMission

      if ivar.save and ivar.save==EXTERNAL then
        evars[ivar.name]=evars[ivar.name] or ivars[ivar.name]
      end
    end--is ivar
  end
end

function this.PostAllModulesLoad()
  InfCore.LogFlow"Ivars.PostAllModulesLoad"
  --tex check to see if theres a settingNames in InfLang
  --has to be postmodules since InfLang is loaded after Ivars
  --GOTCHA this will lock in language till next modules reload (not that there's any actual InfLang translations I'm aware of lol)
  local settingsStr="Settings"
  local languageCode=AssetConfiguration.GetDefaultCategory"Language"
  local langTable=InfLang[languageCode] or InfLang.eng
  for name,ivar in pairs(this) do
    if IsIvar(ivar) then
      local settingNames=name..settingsStr
      if langTable[settingNames] then
        ivar.settingNames=settingNames
      end
      ivar.settingNames=ivar.settingNames or ivar.settings--tex fall back to settings table
    end
  end
end
--<

--EXEC
InfCore.PCall(function()
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
end)

return this
