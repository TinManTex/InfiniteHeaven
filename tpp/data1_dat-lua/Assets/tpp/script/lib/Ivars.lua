-- DOBUILD: 1
-- Ivars.lua
--tex Ivar system
--combines gvar setup, enums, functions per setting in one ungodly mess.
--lots of shortcuts/ivar setup depending-on defined values is done in various Table setups at end of file.
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

--ivars
--tex NOTE: should be mindful of max setting for save vars,
--currently the ivar setup fits to the nearest save size type and I'm not sure of behaviour when you change ivars max enough to have it shift save size and load a game with an already saved var of different size

--ivar ops n stuff
function this.OnChangeSubSetting(self)--tex notify parent profile that you've changed
  --InfMenu.DebugPrint("OnChangeSubSetting: "..self.name.. " profile: " .. self.profile.name)
  local profile=self.profile
  if profile then
    if profile.OnSubSettingChanged==nil then
      InfMenu.DebugPrint("WARNING: cannot find OnSubSettingChanged on profile " .. self.profile.name)
      return
    end
    profile.OnSubSettingChanged(profile,self)
  end
end
function this.OnSubSettingChanged(profile, subSetting)
  --InfMenu.DebugPrint("OnChangeSubSetting: "..profile.name.. " subSetting: " .. subSetting.name)
  --tex any sub setting change will flip this profile to custom since there's no real generalization i can make,
  --CUSTOM is mostly a user identifyer, it has no side effects/no settingTable function
  if not profile.enum then
    InfMenu.DebugPrint("OnChangeSubSetting: "..profile.name.. " has no enum settings")
    return
  end

  if not profile.enum.CUSTOM then
    InfMenu.DebugPrint("OnChangeSubSetting: "..profile.name.. " has no custom setting")
    return
  end

  if not profile:Is"CUSTOM" then
    profile:Set(profile.enum.CUSTOM)
    InfMenu.DisplayProfileChangedToCustom(profile)
  end
end

this.RunCurrentSetting=function(self)
  --InfMenu.DebugPrint("RunCurrentSetting on ".. self.name)
  local returnValue=nil
  if self.settingsTable then
    --this.UpdateSettingFromGvar(self)
    local settingName=self.settings[self.setting+1]
    --InfMenu.DebugPrint("setting name:" .. settingName)
    local settingFunction=self.settingsTable[settingName]

    if IsFunc(settingFunction) then
      --InfMenu.DebugPrint("has settingFunction")
      returnValue=settingFunction()
    else
      returnValue=settingFunction
    end
  end
  return returnValue
end

this.ReturnCurrent=function(self)--for data mostly same as runcurrent but doesnt trigger profile onchange
  --InfMenu.DebugPrint("ReturnCurrent on ".. self.name)
  local returnValue=nil
  if self.settingsTable then
    --InfMenu.DebugPrint("has settingstable")
    local settingName=self.settings[self.setting+1]
    --InfMenu.DebugPrint("setting name:" .. settingName)
    local settingFunction=self.settingsTable[settingName]

    if IsFunc(settingFunction) then
      --InfMenu.DebugPrint("has settingFunction")
      returnValue=settingFunction()
    else
      returnValue=settingFunction
    end
  end
  return returnValue
end

function this.ResetSetting(self,noOnChangeSub,noSave)
  if noOnChangeSub==nil then
    noOnChangeSub=true
  end
  InfMenu.SetSetting(self,self.default,noOnChangeSub,noSave)
end

--paired min/max ivar setup
local minSuffix="_MIN"
local maxSuffix="_MAX"
local function PushMax(ivar)
  local maxName=ivar.subName..maxSuffix
  if ivar.setting>Ivars[maxName]:Get() then
    Ivars[maxName]:Set(ivar.setting,true)
  end
end
local function PushMin(ivar)
  local minName=ivar.subName..minSuffix
  if ivar.setting<Ivars[minName]:Get() then
    Ivars[minName]:Set(ivar.setting,true)
  end
end

local function MinMaxIvar(name,minSettings,maxSettings,ivarSettings)
  local ivarMin={
    subName=name,
    save=MISSION,
    OnChange=PushMin,
  }
  local ivarMax={
    subName=name,
    save=MISSION,
    OnChange=PushMax,
  }

  for k,v in pairs(minSettings) do
    ivarMin[k]=v
  end

  for k,v in pairs(maxSettings) do
    ivarMax[k]=v
  end

  for k,v in pairs(ivarSettings) do
    ivarMin[k]=v
    ivarMax[k]=v
  end

  this[name..minSuffix]=ivarMin
  this[name..maxSuffix]=ivarMax
  return ivarMin,ivarMax
end

local function MissionCheckFree(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  if missionCode==30010 or missionCode==30020 then
    return true
  end
  return false
end

local function MissionCheckMb(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  return missionCode==30050
end

local function MissionCheckMbAll(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  if TppMission.IsMbFreeMissions(missionCode) then
    return true
  end
  return false
end

local function MissionCheckMission(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  if TppMission.IsStoryMission(missionCode) then
    return true
  end
  return false
end

local missionModesAll={
  "FREE",
  "MISSION",
  "MB",
}
local missionModeChecks={
  FREE=MissionCheckFree,
  MISSION=MissionCheckMission,
  MB=MissionCheckMb,
  MB_ALL=MissionCheckMbAll,
}
--
--USAGE
--MissionModeIvars(
--  "someIvarName",
--  {
--    save=MISSION,
--    range=this.switchRange,
--    settingNames="set_switch",
--  },
--  missionModesAll
--)

this.missionModeIvars={}
local function MissionModeIvars(name,ivarDefine,missionModes)
  for i,missionMode in ipairs(missionModes)do
    local ivar={}
    for k,v in pairs(ivarDefine) do
      ivar[k]=v
    end

    ivar.MissionCheck=missionModeChecks[missionMode]
    local fullName=name..missionMode
    this[fullName]=ivar
    this.missionModeIvars[name]=this.missionModeIvars[name] or {}
    this.missionModeIvars[name][#this.missionModeIvars[name]+1]=ivar--insert
  end
end

function this.IsForMission(ivarList,setting,missionCode)
  local missionId=missionCode or vars.missionCode
  if type(ivarList)=="string" then
    ivarList=Ivars.missionModeIvars[ivarList]
  end
  local passedCheck=false
  for i=1, #ivarList do
    local ivar = ivarList[i]
    if ivar:Is(setting) and ivar:MissionCheck(missionId) then
      passedCheck=true
      break
    end
  end
  return passedCheck
end

function this.EnabledForMission(ivarList,missionCode)
  local missionId=missionCode or vars.missionCode
  if type(ivarList)=="string" then
    ivarList=Ivars.missionModeIvars[ivarList]
  end

  local passedCheck=false
  for i=1, #ivarList do
    local ivar = ivarList[i]
    if ivar:Is()>0 and ivar:MissionCheck(missionId) then
      passedCheck=true
      break
    end
  end
  return passedCheck
end

--ivar definitions

this.debugMode={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
  allowFob=true,
}


--this.disableEquipOnMenu={
--  save=MISSION,
--  default=1,
--  range=this.switchRange,
--  settingNames="set_switch",
--}

--parameters
this.soldierParamsProfile={
  save=GLOBAL,--tex global since user still has to restart to get default/modded/reset
  --range=this.switchRange,
  settings={"DEFAULT","CUSTOM"},
  settingNames="soldierParamsProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.soldierSightDistScale:Set(100,true)
      Ivars.soldierHearingDistScale:Set(100,true)
      Ivars.soldierHealthScale:Set(100,true)
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
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
  range={max=750,min=0,increment=20},--tex GOTCHA overflows around 760 when medical arm 3 is equipped
  isPercent=true,
  OnChange=function(self)
    if mvars.mis_missionStateIsNotInGame then
      return
    end
    local healthScale=self.setting/100
    --if healthScale~=1 then
    Player.ResetLifeMaxValue()
    local newMax=vars.playerLifeMax
    newMax=newMax*healthScale
    if newMax < 10 then
      newMax = 10
    end
    Player.ChangeLifeMaxValue(newMax)
    --end
  end,
}
--motherbase>
MinMaxIvar(
  "mbSoldierEquipGrade",
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
    "PFA_ARMOR",
    "XOF",
    "SOVIET_A",
    "SOVIET_B",
    "PF_A",
    "PF_B",
    "PF_C",
    --"GZ",
    --"MSF",
    "SOVIET_BERETS",
    "SOVIET_HOODIES",
    "SOVIET_ALL",
    "PF_MISC",
    "PF_ALL",
  },
  settingNames="mbDDSuitSettings",
}

this.mbDDSuitFemale={
  save=MISSION,
  settings={
    "EQUIPGRADE",
    "DRAB",
    "TIGER",
    "SNEAKING_SUIT",
    "BATTLE_DRESS",
  },
  settingNames="mbDDSuitFemaleSettings",
}

this.mbDDHeadGear={
  save=MISSION,
  range=this.switchRange,
  settingNames="mbDDHeadGearSettings",
}

this.mbWarGamesProfile={
  save=MISSION,
  settings={"OFF","TRAINING","INVASION","ZOMBIE_DD","ZOMBIE_OBLITERATION"},
  settingNames="mbWarGamesProfileSettings",
  settingsTable={
    OFF=function()
      Ivars.mbDDEquipNonLethal:Set(0,true)
      Ivars.mbHostileSoldiers:Set(0,true)
      Ivars.mbEnableLethalActions:Set(0,true)
      Ivars.mbNonStaff:Set(0,true)
      Ivars.mbEnableFultonAddStaff:Set(0,true)
      Ivars.mbZombies:Set(0,true)
      Ivars.mbEnemyHeli:Set(0,true)
    end,
    TRAINING=function()
      --Ivars.mbDDEquipNonLethal:Set(0,true)--tex allow user setting
      Ivars.mbHostileSoldiers:Set(1,true)
      Ivars.mbEnableLethalActions:Set(0,true)
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
      Ivars.mbEnableLethalActions:Set(0,true)
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
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
}

this.mbWargameFemales={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
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

--NONUSER/ handled by profile>
this.mbHostileSoldiers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnableLethalActions={--tex also disables negative ogre on kill
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbNonStaff={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbZombies={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbEnemyHeli={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=MissionCheckMb,
}
--< NONUSER

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

this.isManualHard={--tex not currently user option, but left over for legacy, mostly just switches on hard game over
  save=MISSION,
  range=this.switchRange,
}

this.blockInMissionSubsistenceIvars={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.subsistenceProfile={
  save=MISSION,
  settings={"DEFAULT","PURE","BOUNDER","CUSTOM"},
  settingNames="subsistenceProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.blockInMissionSubsistenceIvars:Set(0,true)

      Ivars.disableLzs:Set(0,true)
      Ivars.disableSelectBuddy:Set(0,true)
      Ivars.disableHeliAttack:Set(0,true)
      Ivars.disableSelectTime:Set(0,true)
      Ivars.disableSelectVehicle:Set(0,true)
      Ivars.disableHeadMarkers:Set(0,true)
      Ivars.disableXrayMarkers:Set(0,true)
      Ivars.disableWorldMarkers:Set(0,true)
      Ivars.disableFulton:Set(0,true)
      Ivars.clearItems:Set(0,true)
      Ivars.clearSupportItems:Set(0,true)
      Ivars.setSubsistenceSuit:Set(0,true)
      Ivars.setDefaultHand:Set(0,true)
      Ivars.handLevelProfile:Set(0,true) --game auto sets to max developed, but still need this to stop override
      Ivars.fultonLevelProfile:Set(0,true) -- game auto turns on wormhole, user can manually chose overall level in ui
      Ivars.ospWeaponProfile:Set(0,true)
      Ivars.disableSpySearch:Set(0,true)

      Ivars.disableMenuDrop:Set(0,true)
      Ivars.disableMenuBuddy:Set(0,true)
      Ivars.disableMenuAttack:Set(0,true)
      Ivars.disableMenuHeliAttack:Set(0,true)
      Ivars.disableSupportMenu:Set(0,true)

      Ivars.abortMenuItemControl:Set(0,true)
      Ivars.disableRetry:Set(0,true)
      Ivars.gameOverOnDiscovery:Set(0,true)

      Ivars.fultonLevelProfile:Set(0,true)
      Ivars.fultonSuccessProfile:Set(0,true)
    end,
    PURE=function()
      Ivars.blockInMissionSubsistenceIvars:Set(1,true)

      Ivars.disableLzs:Set("REGULAR",true)
      Ivars.disableSelectBuddy:Set(1,true)
      Ivars.disableHeliAttack:Set(1,true)
      Ivars.disableSelectTime:Set(1,true)
      Ivars.disableSelectVehicle:Set(1,true)
      Ivars.disableHeadMarkers:Set(1,true)

      Ivars.disableXrayMarkers:Set(0,true)
      Ivars.disableWorldMarkers:Set(1,true)
      Ivars.disableFulton:Set(1,true)
      Ivars.clearItems:Set(1,true)
      Ivars.clearSupportItems:Set(1,true)
      Ivars.setSubsistenceSuit:Set(1,true)
      Ivars.setDefaultHand:Set(1,true)

      if Ivars.ospWeaponProfile:IsDefault() or Ivars.ospWeaponProfile:Is"CUSTOM" then
        Ivars.ospWeaponProfile:Set(1,true)
      end
      Ivars.disableSpySearch:Set(0,true)

      Ivars.handLevelProfile:Set(1,true)
      Ivars.fultonLevelProfile:Set(1,true)

      Ivars.disableMenuDrop:Set(1,true)
      Ivars.disableMenuBuddy:Set(1,true)
      Ivars.disableMenuAttack:Set(1,true)
      Ivars.disableMenuHeliAttack:Set(1,true)
      Ivars.disableSupportMenu:Set(1,true)

      Ivars.abortMenuItemControl:Set(1,true)
      Ivars.disableRetry:Set(0,true)
      Ivars.gameOverOnDiscovery:Set(0,true)
      Ivars.maxPhase:Reset()

      Ivars.fultonLevelProfile:Set(1,true)
      Ivars.fultonSuccessProfile:Set(1,true)
    end,
    BOUNDER=function()
      Ivars.blockInMissionSubsistenceIvars:Set(1,true)

      Ivars.disableLzs:Set("REGULAR",true)
      Ivars.disableSelectBuddy:Set(0,true)
      Ivars.disableHeliAttack:Set(1,true)
      Ivars.disableSelectTime:Set(1,true)
      Ivars.disableSelectVehicle:Set(1,true)
      Ivars.disableHeadMarkers:Set(0,true)
      Ivars.disableXrayMarkers:Set(0,true)
      Ivars.disableWorldMarkers:Set(0,true)

      Ivars.disableFulton:Set(0,true)
      Ivars.clearItems:Set(1,true)
      Ivars.clearSupportItems:Set(1,true)
      Ivars.setSubsistenceSuit:Set(0,true)
      Ivars.setDefaultHand:Set(1,true)

      if Ivars.ospWeaponProfile:IsDefault() or Ivars.ospWeaponProfile:Is"CUSTOM" then
        Ivars.ospWeaponProfile:Set(1,true)
      end

      Ivars.handLevelProfile:Set(1,true)
      Ivars.fultonLevelProfile:Set(1,true)

      Ivars.disableMenuDrop:Set(1,true)
      Ivars.disableMenuBuddy:Set(0,true)
      Ivars.disableMenuAttack:Set(1,true)
      Ivars.disableMenuHeliAttack:Set(1,true)
      Ivars.disableSupportMenu:Set(1,true)

      Ivars.abortMenuItemControl:Set(0,true)
      Ivars.disableRetry:Set(0,true)
      Ivars.gameOverOnDiscovery:Set(0,true)
      Ivars.maxPhase:Reset()

      Ivars.fultonLevelProfile:Set(1,true)
      Ivars.fultonSuccessProfile:Set(1,true)
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
}

this.disableLzs={
  save=MISSION,
  settings={"OFF","ASSAULT","REGULAR"},
  settingNames="disableLzsSettings",
  profile=this.subsistenceProfile,
}

this.disableHeliAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local enable=self.setting==0
    local gameObjectId = GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetCombatEnabled",enabled=enable})
    end
  end,
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=this.DisableOnSubsistence,
}

--spysearch
local function RequireRestartMessage(self)
  --if self.setting==1 then
  InfMenu.PrintLangId"restart_required"
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
  profile=this.subsistenceProfile,
}
--CULL
this.disableHerbSearch={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=RequireRestartMessage,
}

--mission prep
this.disableSelectBuddy={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.disableSelectTime={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.disableSelectVehicle={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.disableHeadMarkers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
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
  profile=this.subsistenceProfile,
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
  profile=this.subsistenceProfile,
  OnChange=function(self)
    local enabled=self.setting==1
    TppSoldier2.SetDisableMarkerModelEffect{enabled=enabled}
  end,
}

this.disableFulton={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

--tex TODO: RENAME RETRY this is OSP shiz
this.clearItems={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  settingsTable={"EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None","EQP_None"},
  profile=this.subsistenceProfile,
}

this.clearSupportItems={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  settingsTable={{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}},
  profile=this.subsistenceProfile,
}

this.setSubsistenceSuit={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.setDefaultHand={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.disableMenuDrop={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_DROP,
  profile=this.subsistenceProfile,
}
this.disableMenuBuddy={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_BUDDY,
  profile=this.subsistenceProfile,
}
this.disableMenuAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_ATTACK,
  profile=this.subsistenceProfile,
}
this.disableMenuHeliAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  menuId=TppTerminal.MBDVCMENU.MSN_HELI_ATTACK,
  profile=this.subsistenceProfile,
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
  profile=this.subsistenceProfile,
}

this.abortMenuItemControl={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.disableRetry={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.gameOverOnDiscovery={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

--tex no go
this.disableTranslators={
  --OFF save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
  OnChange=function(self)
    InfInspect.TryFunc(function(self)--DEBUG
      if self.setting==1 then
        InfMenu.DebugPrint"removing tranlatable"--DEBUG
        vars.isRussianTranslatable=0
        vars.isAfrikaansTranslatable=0
        vars.isKikongoTranslatable=0
        vars.isPashtoTranslatable=0
    elseif self.setting==0 then
      InfMenu.DebugPrint"adding tranlatable"--DEBUG
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
    end,self)--DEBUG
  end,
}


--fulton success>
--fultonSuccessProfile
this.fultonSuccessProfile={
  save=MISSION,
  settings={"DEFAULT","HEAVEN","CUSTOM"},
  settingNames="fultonSuccessProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.fultonNoMbSupport:Reset()
      Ivars.fultonNoMbMedical:Reset()
      Ivars.fultonDyingPenalty:Reset()
      Ivars.fultonSleepPenalty:Reset()
      Ivars.fultonHoldupPenalty:Reset()
      Ivars.fultonDontApplyMbMedicalToSleep:Reset()
      Ivars.fultonHostageHandling:Reset()
    end,
    HEAVEN=function()
      Ivars.fultonNoMbSupport:Set(1,true)
      Ivars.fultonNoMbMedical:Set(1,true)
      Ivars.fultonDyingPenalty:Set(40,true)
      Ivars.fultonSleepPenalty:Set(20,true)
      Ivars.fultonHoldupPenalty:Set(0,true)
      Ivars.fultonDontApplyMbMedicalToSleep:Set(1,true)
      Ivars.fultonHostageHandling:Set(1,true)--DEFAULT,(ZERO)
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
  profile=this.subsistenceProfile,
  profileSetting="BOUNDER",
}
--this.fultonSoldierVariationRange={--WIP
--  save=MISSION,
--  default=0,
--  range={max=100,min=0,increment=1},
--  --profile=this.fultonSuccessProfile,
--}
--this.fultonOtherVariationRange={
--  save=MISSION,
--  default=0,
--  range={max=100,min=0,increment=1},
--  --profile=this.fultonSuccessProfile,
--}
--
--this.fultonVariationInvRate={
--  save=MISSION,
--  range={max=500,min=10,increment=10},
--  --profile=this.fultonSuccessProfile,
--}

this.fultonNoMbSupport={--NOTE: does not rely on fulton profile
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.fultonSuccessProfile,
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
  profile=this.fultonSuccessProfile,
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
  profile=this.fultonSuccessProfile,
}

this.fultonSleepPenalty={
  save=MISSION,
  default=0,
  range={max=100,min=0,increment=5},
  profile=this.fultonSuccessProfile,
}

this.fultonHoldupPenalty={
  save=MISSION,
  default=10,
  range={max=100,min=0,increment=5},
  profile=this.fultonSuccessProfile,
}

this.fultonDontApplyMbMedicalToSleep={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.fultonSuccessProfile,
}

this.fultonHostageHandling={
  save=MISSION,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
  profile=this.fultonSuccessProfile,
}

this.fultonWildCardHandling={--WIP
  save=MISSION,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
--TODO profile=this.fultonSuccessProfile,
}

this.fultonMotherBaseHandling={ --WIP
  save=MISSION,
  settings={"DEFAULT","ZERO"},
  settingNames="fultonHostageHandlingSettings",
--TODO profile=this.fultonSuccessProfile,
}
--<fulton success

--item levels>
this.handLevelRange={max=4,min=0,increment=1}
this.handLevelProfile={--tex can't be set in ui by user
  save=MISSION,
  settings={"DEFAULT","ITEM_OFF","ITEM_MAX","CUSTOM"},
  settingNames="handLevelProfileSettings",
  settingsTable={
    DEFAULT=function()--the game auto sets to max developed but lets set it for apearance sake
      for i, itemIvar in ipairs(Ivars.handLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.max,true)
    end
    end,
    ITEM_OFF=function()
      for i, itemIvar in ipairs(Ivars.handLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.min,true)
      end
    end,
    ITEM_MAX=function()
      for i, itemIvar in ipairs(Ivars.handLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.max,true)
      end
    end,
    CUSTOM=nil,
  },
  ivarTable=function() return
    {
      Ivars.handLevelSonar,
      Ivars.handLevelPhysical,
      Ivars.handLevelPrecision,
      Ivars.handLevelMedical,
    }
  end,
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
  profile=this.subsistenceProfile,
}

this.handLevelSonar={
  save=MISSION,
  range=this.handLevelRange,
  equipId=TppEquip.EQP_HAND_ACTIVESONAR,
  profile=this.handLevelProfile,
}

this.handLevelPhysical={--tex called Mobility in UI
  save=MISSION,
  range=this.handLevelRange,
  equipId=TppEquip.EQP_HAND_PHYSICAL,
  profile=this.handLevelProfile,
}

this.handLevelPrecision={
  save=MISSION,
  range=this.handLevelRange,
  equipId=TppEquip.EQP_HAND_PRECISION,
  profile=this.handLevelProfile,
}

this.handLevelMedical={
  save=MISSION,
  range=this.handLevelRange,
  equipId=TppEquip.EQP_HAND_MEDICAL,
  profile=this.handLevelProfile,
}

this.fultonLevelRange={max=4,min=0,increment=1}
this.fultonLevelProfile={
  save=MISSION,
  settings={"DEFAULT","ITEM_OFF","ITEM_MAX","CUSTOM"},
  settingNames="fultonLevelProfileSettings",
  settingsTable={
    DEFAULT=function()--the game auto sets to max developed
    --    for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
    --      itemIvar:Set(itemIvar.range.max,true)
    --    end
    end,
    ITEM_OFF=function()
      Ivars.itemLevelFulton:Set(1,true)
      Ivars.itemLevelWormhole:Set(0,true)
      --      for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
      --        itemIvar:Set(itemIvar.range.min,true)
      --      end
    end,
    ITEM_MAX=function()
      Ivars.itemLevelFulton:Set(4,true)
      Ivars.itemLevelWormhole:Set(1,true)
      --      for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
      --        itemIvar:Set(itemIvar.range.max,true)
      --      end
    end,
    CUSTOM=nil,
  },
  ivarTable=function() return
    {
      Ivars.itemLevelFulton,
      Ivars.itemLevelWormhole,
    }
  end,
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
  profile=this.subsistenceProfile,
}

this.itemLevelFulton={
  save=MISSION,
  range={max=4,min=1,increment=1},
  equipId=TppEquip.EQP_IT_Fulton,
  profile=this.fultonLevelProfile,
}

this.itemLevelWormhole={
  save=MISSION,
  --range=this.switchRange,
  settings={"DISABLE","ENABLE"},
  --settingNames="itemLevelWormholeSettings",
  equipId=TppEquip.EQP_IT_Fulton_WormHole,
  profile=this.fultonLevelProfile,
}
--<item levels

this.ospWeaponProfile={
  save=MISSION,
  settings={"DEFAULT","PURE","SECONDARY_FREE","CUSTOM"},
  settingNames="ospWeaponProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.primaryWeaponOsp:Set(0,true)
      Ivars.secondaryWeaponOsp:Set(0,true)
      Ivars.tertiaryWeaponOsp:Set(0,true)
    end,
    PURE=function()
      Ivars.primaryWeaponOsp:Set(1,true)
      Ivars.secondaryWeaponOsp:Set(1,true)
      Ivars.tertiaryWeaponOsp:Set(1,true)
    end,
    SECONDARY_FREE=function()
      Ivars.primaryWeaponOsp:Set(1,true)
      Ivars.secondaryWeaponOsp:Set(0,true)
      Ivars.tertiaryWeaponOsp:Set(1,true)
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
  profile=this.subsistenceProfile,
}

local weaponSlotClearSettings={
  "OFF",
  "EQUIP_NONE",
}
this.primaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF={},
    EQUIP_NONE={{primaryHip="EQP_None"}},
  },
  profile=this.ospWeaponProfile,
  GetTable=this.ReturnCurrent,
}
this.secondaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF={},
    EQUIP_NONE={{secondary="EQP_None"}},
  },
  profile=this.ospWeaponProfile,
  GetTable=this.ReturnCurrent,
}
this.tertiaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF={},
    EQUIP_NONE={{primaryBack="EQP_None"}},
  },
  profile=this.ospWeaponProfile,
  GetTable=this.ReturnCurrent,
}

-- revenge/enemy prep stuff>
MissionModeIvars(
  "revengeMode",
  {
    save=MISSION,
    settings={"DEFAULT","CUSTOM"},
    settingNames="revengeModeSettings",
    OnChange=function()
      TppRevenge._SetUiParameters()
    end,
  },
  missionModesAll
)

this.revengeModeMB.settings={"OFF","FOB","DEFAULT","CUSTOM"}--DEFAULT = normal enemy prep system (which isn't usually used for MB)
this.revengeModeMB.settingNames="revengeModeMBSettings"

this.revengeProfile={
  save=MISSION,
  settings={"DEFAULT","HEAVEN","CUSTOM"},
  settingNames="revengeProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.revengeBlockForMissionCount:Set(3,true)
      Ivars.applyPowersToLrrp:Set(0,true)
      Ivars.applyPowersToOuterBase:Set(0,true)
      Ivars.allowHeavyArmorFREE:Set(0,true)
      Ivars.allowHeavyArmorMISSION:Set(0,true)
      --Ivars.allowLrrpArmorInFree:Set(0,true)--WIP
      Ivars.allowHeadGearCombo:Set(0,true)
      Ivars.allowMissileWeaponsCombo:Set(0,true)
      Ivars.balanceHeadGear:Set(0,true)
      Ivars.balanceWeaponPowers:Set(0,true)
      Ivars.disableConvertArmorToShield:Set(0,true)
      Ivars.disableNoRevengeMissions:Set(0,true)
      Ivars.disableMissionsWeaponRestriction:Set(0,true)
      --Ivars.disableMotherbaseWeaponRestriction:Set(0,true)--WIP
      Ivars.enableMgVsShotgunVariation:Set(0,true)
      Ivars.randomizeSmallCpPowers:Set(0,true)
      Ivars.disableNoStealthCombatRevengeMission:Set(0,true)
      Ivars.revengeDecayOnLongMbVisit:Set(0,true)
      Ivars.changeCpSubTypeFREE:Set(0,true)
      Ivars.changeCpSubTypeMISSION:Set(0,true)
    end,
    HEAVEN=function()
      Ivars.revengeBlockForMissionCount:Set(4,true)
      Ivars.applyPowersToLrrp:Set(1,true)
      Ivars.applyPowersToOuterBase:Set(1,true)
      Ivars.allowHeavyArmorFREE:Set(0,true)
      Ivars.allowHeavyArmorMISSION:Set(0,true)
      --Ivars.allowLrrpArmorInFree:Set(0,true)--WIP
      Ivars.allowHeadGearCombo:Set(1,true)
      Ivars.allowMissileWeaponsCombo:Set(1,true)
      Ivars.balanceHeadGear:Set(0,true)--tex allow headgearcombo is sufficient
      Ivars.balanceWeaponPowers:Set(0,true)--WIP
      Ivars.disableConvertArmorToShield:Set(1,true)
      Ivars.disableNoRevengeMissions:Set(0,true)
      Ivars.disableMissionsWeaponRestriction:Set(0,true)
      --Ivars.disableMotherbaseWeaponRestriction:Set(0,true)--WIP
      Ivars.enableMgVsShotgunVariation:Set(1,true)
      Ivars.randomizeSmallCpPowers:Set(1,true)
      Ivars.disableNoStealthCombatRevengeMission:Set(1,true)
      Ivars.revengeDecayOnLongMbVisit:Set(1,true)
      Ivars.changeCpSubTypeFREE:Set(1,true)
      Ivars.changeCpSubTypeMISSION:Set(0,true)
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
}

this.revengeBlockForMissionCount={
  save=MISSION,
  default=3,
  range={max=10},
  profile=this.revengeProfile,
}

this.disableNoRevengeMissions={--WIP
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.disableNoStealthCombatRevengeMission={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.revengeDecayOnLongMbVisit={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.applyPowersToLrrp={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.applyPowersToOuterBase={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}


MissionModeIvars(
  "allowHeavyArmor",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
    profile=this.revengeProfile,
  },
  {"FREE","MISSION",}
)

--WIP TODO either I got rid of this functionality at some point or I never implemented it (I could have sworn I did though)
--this.allowLrrpArmorInFree={
--  save=MISSION,
--  range=this.switchRange,
--  settingNames="set_switch",
--  profile=this.revengeProfile,
--}

this.allowHeadGearCombo={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  allowHeadGearComboThreshold=120,
  profile=this.revengeProfile,
}

this.allowMissileWeaponsCombo={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.balanceHeadGear={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  balanceHeadGearThreshold=100,
  profile=this.revengeProfile,
}

this.balanceWeaponPowers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  balanceWeaponsThreshold=100,
  profile=this.revengeProfile,
}

this.disableConvertArmorToShield={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.disableMissionsWeaponRestriction={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.disableMotherbaseWeaponRestriction={--WIP
  --OFF WIP save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.enableMgVsShotgunVariation={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

this.randomizeSmallCpPowers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.revengeProfile,
}

--
MissionModeIvars(
  "enableDDEquip",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
  },
  missionModesAll
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
    InfMenu.DebugPrint("SetMinMax: could not find ivar for "..baseName)
    return
  end
  ivarMin:Set(min,true)
  ivarMax:Set(max,true)
end

this.revengeConfigProfile={--WIP
  save=MISSION,
  settings={"WIDE","MAX","MIN","CUSTOM"},--"UPPER","LOWER","CUSTOM"},--tex default==wide,max=emulation of revenge config max
  --settingNames="revengeConfigProfileSettings",--ADDLANG
  settingsTable={
    WIDE=function()
      this.SetPercentagePowersRange(0,100)
      for n,powerType in ipairs(this.abilitiesWithLevels)do
        this.SetMinMax(powerType,"NONE","SPECIAL")
      end

      this.SetMinMax("STRONG_WEAPON",0,1)
      this.SetMinMax("STRONG_MISSILE",0,1)
      this.SetMinMax("STRONG_SNIPER",0,1)

      Ivars.reinforceLevel_MIN:Set("NONE",true)
      Ivars.reinforceLevel_MAX:Set("BLACK_SUPER_REINFORCE",true)

      this.SetMinMax("revengeIgnoreBlocked",0,0)

      this.SetMinMax("reinforceCount",1,5)

      this.SetMinMax("ACTIVE_DECOY",0,1)
      this.SetMinMax("GUN_CAMERA",0,1)
    end,
    MAX=function()
      for n,powerType in ipairs(this.cpEquipPowers)do
        this.SetMinMax(powerType,100,100)
      end
      for n,powerType in ipairs(this.abilitiesWithLevels)do
        this.SetMinMax(powerType,"SPECIAL","SPECIAL")
      end

      this.SetMinMax("ARMOR",40,40)
      this.SetMinMax("SHIELD",40,40)

      this.SetMinMax("SOFT_ARMOR",100,100)
      this.SetMinMax("HELMET",100,100)
      this.SetMinMax("NVG",75,75)
      this.SetMinMax("GAS_MASK",75,75)
      this.SetMinMax("GUN_LIGHT",75,75)

      this.SetMinMax("SNIPER",20,20)
      this.SetMinMax("MISSILE",40,40)

      this.SetMinMax("MG",40,40)
      this.SetMinMax("SHOTGUN",40,40)
      this.SetMinMax("SMG",0,0)
      this.SetMinMax("ASSAULT",0,0)

      this.SetMinMax("STRONG_WEAPON",1,1)
      this.SetMinMax("STRONG_MISSILE",1,1)
      this.SetMinMax("STRONG_SNIPER",1,1)

      this.reinforceLevel_MIN:Set("BLACK_SUPER_REINFORCE",true)
      this.reinforceLevel_MAX:Set("BLACK_SUPER_REINFORCE",true)

      this.SetMinMax("revengeIgnoreBlocked",1,1)

      this.SetMinMax("reinforceCount",4,4)

      this.SetMinMax("ACTIVE_DECOY",1,1)
      this.SetMinMax("GUN_CAMERA",1,1)
    end,
    MIN=function()
      for n,powerType in ipairs(this.cpEquipPowers)do
        this.SetMinMax(powerType,0,0)
      end
      for n,powerType in ipairs(this.abilitiesWithLevels)do
        this.SetMinMax(powerType,"NONE","NONE")
      end

      this.SetMinMax("ARMOR",0,0)
      this.SetMinMax("SHIELD",0,0)

      this.SetMinMax("SOFT_ARMOR",0,0)
      this.SetMinMax("HELMET",0,0)
      this.SetMinMax("NVG",0,0)
      this.SetMinMax("GAS_MASK",0,0)
      this.SetMinMax("GUN_LIGHT",0,0)

      this.SetMinMax("SNIPER",0,0)
      this.SetMinMax("MISSILE",0,0)

      this.SetMinMax("MG",0,0)
      this.SetMinMax("SHOTGUN",0,0)
      this.SetMinMax("SMG",0,0)
      this.SetMinMax("ASSAULT",0,0)

      this.SetMinMax("STRONG_WEAPON",0,0)
      this.SetMinMax("STRONG_MISSILE",0,0)
      this.SetMinMax("STRONG_SNIPER",0,0)

      this.reinforceLevel_MIN:Set("NONE",true)
      this.reinforceLevel_MAX:Set("NONE",true)

      this.SetMinMax("revengeIgnoreBlocked",0,0)

      this.SetMinMax("reinforceCount",1,1)

      this.SetMinMax("ACTIVE_DECOY",0,0)
      this.SetMinMax("GUN_CAMERA",0,0)
    end,
    UPPER=nil,
    LOWER=nil,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
}

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
  PushMax(self)
  InfRevenge.SetCustomRevengeUiParameters()
end
local function OnChangeCustomeRevengeMax(self)
  PushMin(self)
  InfRevenge.SetCustomRevengeUiParameters()
end

for n,powerTableName in ipairs(this.percentagePowerTables)do
  local powerTable=this[powerTableName]
  for m,powerType in ipairs(powerTable)do
    MinMaxIvar(
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
        profile=this.revengeConfigProfile,
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
  MinMaxIvar(
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
      profile=this.revengeConfigProfile,
    }
  )
end

this.weaponStrengthPowers={--tex bools
  "STRONG_WEAPON",
  "STRONG_SNIPER",
  "STRONG_MISSILE",
}

for n,powerType in ipairs(this.weaponStrengthPowers)do
  MinMaxIvar(
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
      profile=this.revengeConfigProfile,
    }
  )
end

this.cpEquipBoolPowers={
  "ACTIVE_DECOY",--tex doesn't actually seem to work
  "GUN_CAMERA",--tex dont think there are any cams in free mode?
}

for n,powerType in ipairs(this.cpEquipBoolPowers)do
  MinMaxIvar(
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
      profile=this.revengeConfigProfile,
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
MinMaxIvar(
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
    profile=this.revengeConfigProfile,
  }
)

MinMaxIvar(
  "reinforceCount",
  {default=1,OnChange=OnChangeCustomRevengeMin},
  {default=5,OnChange=OnChangeCustomeRevengeMax},
  {
    range={max=99,min=1},
    profile=this.revengeConfigProfile,
  }
)

MinMaxIvar(
  "revengeIgnoreBlocked",
  {default=0,OnChange=OnChangeCustomRevengeMin},
  {default=0,OnChange=OnChangeCustomeRevengeMax},
  {
    range=this.switchRange,
    settingNames="set_switch",
    profile=this.revengeConfigProfile,
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
  MissionCheck=MissionCheckFree,
}

--wildcard
this.enableWildCardFreeRoam={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  MissionCheck=MissionCheckFree,
}

--tex WIP ideally would have defaults of 2-5, and also let user modify, but while base assignment is random need to spread it as far as posible to get coverage
--MinMaxIvar(
--  "lrrpSizeFreeRoam",
--  {default=2},
--  {default=2},
--  {
--    range={min=1,max=10}
--  }
--)

--patrol vehicle stuff>
this.vehiclePatrolProfile={
  save=MISSION,
  settings={"OFF","SINGULAR","EACH_VEHICLE"},
  settingNames="vehiclePatrolProfileSettings",
  MissionCheck=MissionCheckFree,
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
  settings={"NONE","1","3","5","7","ENEMY_PREP"},
  settingNames="enemyHeliPatrolSettingNames",
  MissionCheck=MissionCheckFree,
}

this.putEquipOnTrucks={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
--<patrol vehicle stuff
MissionModeIvars(
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


MissionModeIvars(
  "changeCpSubType",
  {
    save=MISSION,
    range=this.switchRange,
    settingNames="set_switch",
    profile=this.revengeProfile,
    OnChange=function(self)
      if self.setting==0 then
        InfMain.ResetCpTableToDefault()
      end
    end,
  },
  {"FREE","MISSION",}
)

function this.UpdateActiveQuest()
  --InfInspect.TryFunc(function()--DEBUG
  for i=0,TppDefine.QUEST_MAX-1 do
    gvars.qst_questRepopFlag[i]=false
  end

  for i,areaQuests in ipairs(TppQuestList.questList)do
    TppQuest.UpdateRepopFlagImpl(areaQuests)
  end
  TppQuest.UpdateActiveQuest()
  --end)--
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
    --InfMenu.DebugPrint(questName)--DEBUG
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

this.mbRepopDiamondCountdown={
  save=MISSION,
  default=4,
  range={max=4,min=0,increment=1},
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
  settings={"DEFAULT","SNAKE","AVATAR","DD_MALE","DD_FEMALE"},
  settingsTable={--tex can just use number as index but want to re-arrange, actual index in exe/playertype is snake=0,dd_male=1,ddfemale=2,avatar=3
    0,
    PlayerType.SNAKE,
    PlayerType.AVATAR,
    PlayerType.DD_MALE,
    PlayerType.DD_FEMALE,
  },
  --settingNames="set_",
  OnSelect=function(self)
  -- self:Set(vars.playerType,true)
  end,
  OnChange=function(self)
    if self.setting>0 then
      vars.playerType=self.settingsTable[self.setting+1]
    end
  end,
}

local playerCammoTypes={-- SYNC: InfFova.playerCammoTypes
  "OLIVEDRAB",--0
  "SPLITTER",--1
  "SQUARE",--2
  "TIGERSTRIPE",--3
  "GOLDTIGER",--4
  "FOXTROT",--5
  "WOODLAND",--6
  "WETWORK",--7
  "ARBANGRAY",--8
  "ARBANBLUE",--9
  "SANDSTORM",--10
  "REALTREE",--11
  "INVISIBLE",--12
  "BLACK",--13
  "SNEAKING_SUIT_GZ",--14
  "SNEAKING_SUIT_TPP",--15
  "BATTLEDRESS",--16
  "PARASITE",--17
  "NAKED",--18
  "LEATHER",--19
  "SOLIDSNAKE",--20
  "NINJA",--21
  "RAIDEN",--22
  "HOSPITAL",--23
  "GOLD",--24
  "SILVER",--25
  "PANTHER",--26
  "AVATAR_EDIT_MAN",--27
  "MGS3",--28
  "MGS3_NAKED",--29
  "MGS3_SNEAKING",--30
  "MGS3_TUXEDO",--31
  "EVA_CLOSE",--32
  "EVA_OPEN",--33
  "BOSS_CLOSE",--34
  "BOSS_OPEN",--35

  "C23",--36
  "C24",--37
  "C27",--38
  "C29",--39
  "C30",--40
  "C35",--41
  "C38",--42
  "C39",--43
  "C42",--44
  "C46",--45
  "C49",--46
  "C52",--47
}
local playerCamoTypeEnums={}
for n,enum in ipairs(playerCammoTypes)do
  playerCamoTypeEnums[#playerCamoTypeEnums+1]=PlayerCamoType[enum]
end
--DEBUGNOW
this.playerCammoTypes={
  --OFF save=MISSION,

  range={min=0,max=1000},
  --DEBUGNOW
  --  settings=playerCammoTypes,
  --  settingsTable=playerCamoTypeEnums,
  --settingNames="set_",
  OnSelect=function(self)
  --self:Set(vars.playerCamoType,true)
  end,
  OnChange=function(self)
    --if self.setting>0 then--TODO: add off/default/noset setting
    --DEBUGNOW OFF vars.playerCamoType=self.settingsTable[self.setting+1]--tex playercammotype is just a enum so could just use setting, but this is if we want to re-arrange
    local noApply={
      [8]=true,--hang modelsys on snake
      [9]=true,
      [10]=true,
      [13]=true,
    --[13]=true,
    }

    if noApply[self.setting] then--DEBUGNOW
      InfMenu.DebugPrint"skip"
    else
      vars.playerCamoType=self.setting
    end
    -- vars.playerPartsType=PlayerPartsType.NORMAL--TODO: camo wont change unless this (one or both, narrow down which) set
    -- vars.playerFaceEquipId=0
    --end
  end,
}

this.playerPartsType={
  --OFF save=MISSION,
  range={min=0,max=100},--DEBUGNOW TODO: figure out max range
  --  settings={
  --  "NORMAL",--0 uses set camo type
  --  "NORMAL_SCARF",--1 uses set camo type
  --  "SNEAKING_SUIT",--2, GZ/MSF, matches PlayerCamoType.SNEAKING_SUIT_GZ (don't know why they didnt keep same name)  --crash on avatar
  --  "HOSPITAL",--3
  --  "MGS1",--4
  --  "NINJA",--5
  --  "RAIDEN",--6
  --  "NAKED",--7, uses set camo type?
  --  "SNEAKING_SUIT_TPP",--8
  --  "BATTLEDRESS",--9
  --  "PARASITE",--10
  --  "LEATHER",--11
  --  "GOLD",--12
  --  "SILVER",--13
  --  "AVATAR_EDIT_MAN",--14
  --  "MGS3",--15
  --  "MGS3_NAKED",--16 can avatar naked? muddy, normal naked is more sooty?
  --  "MGS3_SNEAKING",--17
  --  "MGS3_TUXEDO",--18
  --  "EVA_CLOSE",--19 fem>
  --  "EVA_OPEN",--20
  --  "BOSS_CLOSE",--21
  --  "BOSS_OPEN",--22<
  --  "TIGER_NOHEAD",--? for DD? placeholder? Repeats
  --  "TIGER_NOHEAD2",--? for DD?
  --  "SNEAKING_SUIT_GZ2",
  --  "HOSPITAL2",--
  --  "MGS12",
  --  "NINJA2",
  --  "RAIDEN2",
  --  "NAKED2",--> no head
  --  "SNEAKING_SUIT_TPP2",
  --  "BATTLEDRESS2",--<
  --  "PARASITE_SUIT2",
  --  "LEATHER_JACKET2",--the truth leather? has brown glove. no head, no hand
  --  },
  --
  --  settingsTable={-- TODO: build own setting enum, currently above is setting ordee
  --    PlayerPartsType.NORMAL,
  --    PlayerPartsType.NORMAL_SCARF,
  --    PlayerPartsType.SNEAKING_SUIT,
  --    PlayerPartsType.MGS1,
  --    PlayerPartsType.HOSPITAL,
  --    PlayerPartsType.AVATAR_EDIT_MAN,
  --    PlayerPartsType.NAKED,
  --  },
  OnSelect=function(self)
  --OFF self:Set(vars.playerPartsType,true)
  end,
  OnChange=function(self)
    --DEBUGNOW if self.setting>0 then--TODO: add off/default/noset setting
    --tex DEBUGNOW GOTCHA: selecting certain character types will stop playerPartsType from kicking in until cammotype is changed once
    --TODO: see what values are when you do this
    local noApply={--DEBUGNOW
      ----      [3]=true,--HOSPITAL crashes when AVATAR
      --        [12]=true,--hang model sys when DD_MALE,DD_Female
      --        [13]=true,
      --        [15]=true,--DLC males hang models syst with dd female
      --        [16]=true,
      --        [17]=true,
      --        [18]=true,
      ----        [19]=true,--DLC fems hang models syst with dd male
      ----        [20]=true,
      ----        [21]=true,
      ----        [22]=true,
      --        [23]=true,--DD fem crash
      --        [24]=true,

      -- trying to explore past end
      --      [35]=true,
      }

    if not noApply[self.setting] then
      vars.playerPartsType=self.setting
      -- vars.playerPartsType=self.settingsTable[self.setting+1]
      --end
    end--
  end,
}

this.playerFaceEquipIdApearance={
  --OFF save=MISSION,
  range={min=0,max=100},--TODO

  --NONE=0??
  --BOSS_BANDANA=1
  --  settingsTable={
  --    "NORMAL",
  --  },
  --  settingsTable={
  --    0,
  --    1,
  --  },
  OnSelect=function(self)
  --OFF self:Set(vars.playerFaceEquipId,true)
  end,
  OnChange=function(self)--TODO: add off/default/noset setting
    vars.playerFaceEquipId=self.setting
  end,
}

this.playerFaceIdApearance={
  save=MISSION,
  range={min=600,max=687},--DEBUGNOW min was 0
  OnChange=function(self)
    if self.setting>0 then--TODO: add off/default/noset setting
      vars.playerFaceId=self.setting
    end
  end,
}

--fovaInfo
this.enableFovaMod={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  OnSelect=function(self)
  --DEBUGNOW
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
  save=MISSION,
  range={min=0,max=255},--DEBUGNOW limits max fovas TODO consider
  OnSelect=function(self)
    InfInspect.TryFunc(function()--DEBUG
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
          --InfMenu.DebugPrint"OnSelect FovaInfoChanged"--DEBUG
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
    end)--
  end,
  --  OnDeselect=function(self)
  --    InfMenu.DebugPrint"fovaSelection OnDeselect"--DEBUG
  --    if Ivars.enableMod:Is(0) then
  --    --InfMenu.PrintLangId"fova_is_not_set"--DEBUG
  --    end
  --  end,
  OnChange=function(self)
    InfInspect.TryFunc(function()--DEBUG
      InfFova.SetFovaMod(self:Get()+1,true)
    end)
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
--profile=this.subsistenceProfile,
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
  profile=this.subsistenceProfile,
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
--profile=this.subsistenceProfile,
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
--profile=this.subsistenceProfile,
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

--
function this.DisableOnSubsistence(self)
  --if TppMission.IsHelicopterSpace(vars.missionCode) then
  --  return
  --end
  if Ivars.blockInMissionSubsistenceIvars:Is(1) then
    self.disabled=true
  else
    self.disabled=false
  end
end

this.warpPlayerUpdate={
  --save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  disabled=false,
  disabledReason="item_disabled_subsistence",
  isMode=true,
  OnSelect=this.DisableOnSubsistence,
  --tex WIP OFF disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,
  OnActivate=function()InfMain.OnActivateWarpPlayer()end,
  OnChange=function(self,previousSetting)
    if Ivars.adjustCameraUpdate:Is(1) then
      self.setting=0
      InfMenu.PrintLangId"other_control_active"
    end

    if self.setting==1 then
      InfMenu.PrintLangId"warp_mode_on"
      InfMain.OnActivateWarpPlayer()
    else
      InfMenu.PrintLangId"warp_mode_off"
      InfMain.OnDeactivateWarpPlayer()
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
  ExecInit=function(...)InfMain.InitWarpPlayerUpdate(...)end,
  ExecUpdate=function(...)InfMain.UpdateWarpPlayer(...)end,
}

this.adjustCameraUpdate={
  --save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  disabled=false,
  disabledReason="item_disabled_subsistence",
  isMode=true,
  OnSelect=this.DisableOnSubsistence,
  --disableActions=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU,--tex OFF not really needed, padmask is sufficient
  OnActivate=function()InfCamera.OnActivateCameraAdjust()end,
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
      InfMain.RestoreActionFlag()--DEBGNOW only restore those that menu disables that this doesnt
      InfMenu.menuOn=false
    end
  end,
  execCheckTable={inGame=true},--,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  --ExecInit=function(...)InfMain.InitWarpPlayerUpdate(...)end,
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
    default=0.75,
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
MissionModeIvars(
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
  execCheckTable={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  MissionCheck=MissionCheckMb,
  ExecInit=function(...)InfNPCHeli.InitUpdate(...)end,
  OnMissionCanStart=function(...)InfNPCHeli.OnMissionCanStart(...)end,
  ExecUpdate=function(...)InfNPCHeli.Update(...)end,
}

--heli
this.heliUpdate={--tex NONUSER, for now, need it alive to pick up pull out
  save=MISSION,
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
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=this.DisableOnSubsistence,
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
  range=this.switchRange,
  settingNames="set_disable",
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local set=self.setting==1
    local gameObjectId=GetGameObjectId("TppHeli2","SupportHeli")
    if gameObjectId~=nil and gameObjectId~=NULL_ID then
      local command
      if set then
        command={id="SetSearchLightForcedType",type="Off"}
      else
        command={id="SetSearchLightForcedType",type="On"}
      end
      GameObject.SendCommand(gameObjectId,command)
      InfMain.HeliOrderRecieved()
    end
  end,
}

this.selectedCp={
  save=MISSION,
  range={max=9999},
  prev=nil,
  GetNext=function(self)
    self.prev=self.setting
    if mvars.ene_cpList==nil then
      InfMenu.DebugPrint"mvars.ene_cpList==nil"--DEBUG
      return 0
    end--

    local nextSetting=self.setting
    if self.setting==0 then
      nextSetting=next(mvars.ene_cpList)
    else
      nextSetting=next(mvars.ene_cpList,self.setting)
    end
    if nextSetting==nil then
      --InfMenu.DebugPrint"self setting==nil"--DEBUG
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
      InfMenu.DebugPrint("no equipId found for "..equipName)
      return
    else
      --      InfMenu.DebugPrint("set "..equipName)
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

      InfMenu.DebugPrint("drop "..equipName)
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
  MissionCheck=MissionCheckFree,
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
MissionModeIvars(
  "gameEventChance",
  {
    save=MISSION,
    range={min=0,max=100,increment=5},
    isPercent=true,
  },
  {"FREE","MB",}
)

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

--non user save vars
--others grouped near usage, search NONUSER

--tex used as indicator whether save>ivar.setting should be synced
this.inf_event={--NONUSER
  save=MISSION,
  settings={"OFF","WARGAME","ROAM"},
}

this.mis_isGroundStart={--NONUSER WORKAROUND
  save=MISSION,
  range=this.switchRange,
}

this.inf_levelSeed={--NONUSER--tex cribbed from rev_revengeRandomValue
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

--DEBUG turn off saving
--for name, ivar in pairs(this) do
--  if IsIvar(ivar) then
--    ivar.save=nil
--  end
--end
--
this.OptionIsDefault=function(self)
  local currentSetting
  if TppMission.IsFOBMission(vars.missionCode) and not self.allowFob then
    currentSetting=self.default
  else
    currentSetting=self.setting
  end

  return currentSetting==self.default
end

local type=type
local numberType="number"
local TppMission=TppMission
this.OptionIsSetting=function(self,setting)
  if self==nil then
    InfMenu.DebugPrint("WARNING OptionIsSetting self==nil, Is or Get called with . instead of :")
    return
  end

  if not IsIvar(self) then
    InfMenu.DebugPrint("self not Ivar. Is or Get called with . instead of :")
    return
  end

  local currentSetting
  if TppMission.IsFOBMission(vars.missionCode) and not self.allowFob then
    currentSetting=self.default
  else
    currentSetting=self.setting
  end

  if setting==nil then
    return currentSetting
  elseif type(setting)==numberType then
    return setting==currentSetting
  end

  if self.enum==nil then
    InfMenu.DebugPrint("Is function called on ivar "..self.name.." which has no settings enum")
    return false
  end

  local settingIndex=self.enum[setting]
  if settingIndex==nil then
    InfMenu.DebugPrint("WARNING ivar "..self.name.." has no setting named "..tostring(setting))
    return false
  end
  return settingIndex==currentSetting
end

this.UpdateSettingFromGvar=function(option)
  if option.save then
    local gvar=gvars[option.name]
    if gvar~=nil then
      option.setting=gvars[option.name]
    else
      InfMenu.DebugPrint"UpdateSettingFromGvar: WARNING option.save but no gvar found"
    end
  end
end

--ivar system setup
--tex called on TppSave.VarRestoreOnMissionStart and VarRestoreOnContinueFromCheckPoint
function this.OnLoadVarsFromSlot()
  --InfInspect.TryFunc(function()--DEBUG
  if Ivars.inf_event:Is()>0 then
    --InfMenu.DebugPrint("OnLoadVarsFromSlot is mis event, aborting."..vars.missionCode)--DEBUG
    return
  end
  for name,ivar in pairs(this) do
    if IsIvar(ivar) then
      this.UpdateSettingFromGvar(ivar)
    end
  end
  --end)--
end

--TABLESETUP: Ivars
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
    ivar.setting=ivar.default

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

    --    if ivar.profile then--tex is subsetting
    --      if ivar.OnChangeSubSetting==nil then
    --        ivar.OnChangeSubSetting=OnChangeSubSetting
    --      end
    --    end

    ivar.IsDefault=this.OptionIsDefault
    ivar.Is=this.OptionIsSetting
    ivar.Get=this.OptionIsSetting

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

function this.Init(missionTable)

  for name,ivar in pairs(this) do
    if IsIvar(ivar)then
      local GetMax=ivar.GetMax--tex cludge to get around that Gvars.lua calls declarevars during it's compile/before any other modules are up, REFACTOR: Init is actually each mission load I think, only really need this to run once per game load, but don't know the good spot currently
      if GetMax and IsFunc(GetMax) then
        ivar.range.max=GetMax()
      end
      ivar.Set=InfMenu.SetSetting
      ivar.Reset=this.ResetSetting
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
          SplashScreen.Show(SplashScreen.Create("svarfail","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640),0,0.3,0)--tex dog--tex ghetto as 'does it run?' indicator
        end

        local svar={name=name,type=svarType,value=ivar.default,save=true,sync=false,wait=false,category=ivar.save}--tex what is sync? think it's network synce, but MakeSVarsTable for seqences sets it to true for all (but then 50050/fob does make a lot of use of it)
        if ok then
          varTable[#varTable+1]=svar
        end
      end--save
    end--ivar
  end

  return varTable
end

--
function this.ApplyProfile(profile,noSave)
  local random=math.random
  local type=type
  local tableType="table"
  local stringType="string"

  for ivarName,setting in pairs(profile)do
    if type(setting)==tableType then
      if setting[1]==stringType then
        --tex setting=={"SOMESETTINGNAME",...}
        setting=setting[random(#setting)]
      else
        --tex setting=={<minnum>,<maxnum>}
        setting=random(setting[1],setting[2])
      end
    end
    --InfMenu.DebugPrint(ivarName..":Set("..tostring(setting)..")")--DEBUG
    Ivars[ivarName]:Set(setting,true,noSave)
  end
end

--debug stuff
--tex only catches save vars
function this.PrintNonDefaultVars()
  if this.varTable==nil then
    InfMenu.DebugPrint("varTable not found, has it been reverted to DeclareVars local?")
    return
  end

  for n,gvarInfo in pairs(this.varTable) do
    local gvar=gvars[gvarInfo.name]
    if gvar==nil then
      InfMenu.DebugPrint("WARNING ".. gvarInfo.name.." has no gvar")
    else
      if gvar ~= gvarInfo.value then
        InfMenu.DebugPrint("DEBUG: "..gvarInfo.name.." current value is not default")
      end
    end
  end
end

function this.PrintGvarSettingMismatch()
  --InfInspect.TryFunc(function()--DEBUG
  for name, ivar in pairs(Ivars) do
    if IsIvar(ivar) then
      if ivar.save then
        local gvar=gvars[ivar.name]
        if gvar==nil then
          InfMenu.DebugPrint("WARNING ".. ivar.name.." has no gvar")
        else
          if ivar.setting~=gvar then
            InfMenu.DebugPrint("WARNING: ivar setting/gvar mismatch for "..name)
            InfMenu.DebugPrint("setting:"..tostring(ivar.setting).." gvar value:"..tostring(gvar))
          end
        end
      end
    end
  end
  --end)--
end

function this.PrintSaveVarCount()
  if this.varTable==nil then
    InfMenu.DebugPrint("varTable not found, has it been reverted to DeclareVars local?")
    return
  end

  local gvarCountCount=0
  for n,gvarInfo in pairs(this.varTable) do
    local gvar=gvars[gvarInfo.name]
    if gvar==nil then
      InfMenu.DebugPrint("WARNING ".. gvarInfo.name.." has no gvar")
    else
      gvarCountCount=gvarCountCount+1
    end
  end
  InfMenu.DebugPrint("Ivar gvar count:"..gvarCountCount.." "..#this.varTable)

  local bools=0
  for name, ivar in pairs(Ivars) do
    if IsIvar(ivar) then
      if ivar.save then
        if ivar.range.max==1 then
          bools=bools+1
        end
      end
    end
  end
  InfMenu.DebugPrint("potential ivar bools:"..bools)

  local scriptVarTypes={
    [TppScriptVars.TYPE_BOOL]="TYPE_BOOL",
    [TppScriptVars.TYPE_UINT8]="TYPE_UINT8",
    [TppScriptVars.TYPE_INT8]="TYPE_INT8",
    [TppScriptVars.TYPE_UINT16]="TYPE_UINT16",
    [TppScriptVars.TYPE_INT16]="TYPE_INT16",
    [TppScriptVars.TYPE_UINT32]="TYPE_UINT32",
    [TppScriptVars.TYPE_INT32]="TYPE_INT32",
    [TppScriptVars.TYPE_FLOAT]="TYPE_FLOAT",
  }

  local function CountVarTable(scriptVarTypes,varTable,category)
    local totalCount=0
    local typeCounts={}
    local totalCountArray=0
    local arrayCounts={}
    for scriptVarType, typeName in pairs(scriptVarTypes) do
      typeCounts[typeName]=0
      arrayCounts[typeName]=0
    end

    for n, gvarInfo in pairs(varTable)do
      if category==nil or gvarInfo.category==category then
        local scriptVarTypeName=scriptVarTypes[gvarInfo.type]
        typeCounts[scriptVarTypeName]=typeCounts[scriptVarTypeName]+1

        local count=gvarInfo.arraySize or 1
        if count==0 then count=1 end
        --if Tpp.IsTypeNumber(gvarInfo.arraySize) then
        arrayCounts[scriptVarTypeName]=arrayCounts[scriptVarTypeName]+count
        --end
        totalCount=totalCount+1
        totalCountArray=totalCountArray+count
      end
    end
    return typeCounts,arrayCounts,totalCount,totalCountArray
  end

  InfMenu.DebugPrint"NOTE: these are CATEGORY_MISSION counts"

  InfMenu.DebugPrint"Ivars.varTable"
  local typeCounts,arrayCounts,totalCount,totalCountArray=CountVarTable(scriptVarTypes,this.varTable,TppScriptVars.CATEGORY_MISSION)

  InfMenu.DebugPrint"typeCounts"
  local ins=InfInspect.Inspect(typeCounts)
  InfMenu.DebugPrint(ins)

  InfMenu.DebugPrint"arrayCounts"
  local ins=InfInspect.Inspect(arrayCounts)
  InfMenu.DebugPrint(ins)

  InfMenu.DebugPrint("totalcount:"..totalCount.." totalcountarray:"..totalCountArray)



  --  local ins=InfInspect.Inspect(TppScriptVars)
  --  InfMenu.DebugPrint(ins)

  --  local categories={
  --    [TppScriptVars.CATEGORY_NONE]="CATEGORY_NONE",
  --    [TppScriptVars.CATEGORY_GAME_GLOBAL]="CATEGORY_GAME_GLOBAL",
  --    [TppScriptVars.CATEGORY_MISSION]="CATEGORY_MISSION",
  --    [TppScriptVars.CATEGORY_RETRY]="CATEGORY_RETRY",
  --    [TppScriptVars.CATEGORY_MB_MANAGEMENT]="CATEGORY_MB_MANAGEMENT",
  --    [TppScriptVars.CATEGORY_QUEST]="CATEGORY_QUEST",
  --    [TppScriptVars.CATEGORY_CONFIG]="CATEGORY_CONFIG",
  --    --[TppDefine.CATEGORY_MISSION_RESTARTABLE]="TppDefine CATEGORY_MISSION_RESTARTABLE",
  --    [TppScriptVars.CATEGORY_MISSION_RESTARTABLE]="CATEGORY_MISSION_RESTARTABLE",
  --    [TppScriptVars.CATEGORY_PERSONAL]="CATEGORY_PERSONAL",
  --    --[TppScriptVars.CATEGORY_MGO]="CATEGORY_MGO",
  --    [TppScriptVars.CATEGORY_ALL]="CATEGORY_ALL",
  --  }

  --  for categoryType, categoryName in pairs(categories) do
  --    InfMenu.DebugPrint(categoryName..":"..tostring(categoryType))
  --  end

  InfMenu.DebugPrint"TppGVars.DeclareGVarsTable"
  local typeCounts,arrayCounts,totalCount,totalCountArray=CountVarTable(scriptVarTypes,TppGVars.DeclareGVarsTable,TppScriptVars.CATEGORY_MISSION)

  InfMenu.DebugPrint"typeCounts"
  local ins=InfInspect.Inspect(typeCounts)
  InfMenu.DebugPrint(ins)

  InfMenu.DebugPrint"arrayCounts"
  local ins=InfInspect.Inspect(arrayCounts)
  InfMenu.DebugPrint(ins)

  InfMenu.DebugPrint("totalcount:"..totalCount.." totalcountarray:"..totalCountArray)

  InfMenu.DebugPrint"TppMain.allSvars"
  local typeCounts,arrayCounts,totalCount,totalCountArray=CountVarTable(scriptVarTypes,TppMain.allSvars,TppScriptVars.CATEGORY_MISSION)
  InfMenu.DebugPrint"typeCounts"
  local ins=InfInspect.Inspect(typeCounts)
  InfMenu.DebugPrint(ins)

  InfMenu.DebugPrint"arrayCounts"
  local ins=InfInspect.Inspect(arrayCounts)
  InfMenu.DebugPrint(ins)

  InfMenu.DebugPrint("totalcount:"..totalCount.." totalcountarray:"..totalCountArray)

  --    local ins=InfInspect.Inspect(TppMain.allSvars)
  --  InfMenu.DebugPrint(ins)

end

local numQuestSoldiers=20--SYNC InfInterrogate
function this.DeclareSVars()--tex svars are created/cleared on new missions
  return{
    {name="inf_interCpQuestStatus",arraySize=numQuestSoldiers,type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end

return this
