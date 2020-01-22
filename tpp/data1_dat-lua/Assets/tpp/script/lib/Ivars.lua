-- DOBUILD: 1 --
--tex Ivar system
--combines gvar setup, enums, functions per setting in one ungodly mess.
--lots of shortcuts/ivar setup depending-on defined values is done in various Table setups at end of file.
local this={}
--NOTE: Resetsettings will call OnChange, so/and make sure defaults are actual default game behaviour, 
--in general this means all stuff should have a 0 that at least does nothing, 
--dont let the lure of nice straight setting>game value lure you, just -1 it

--LOCALOPT:
local IsString=Tpp.IsTypeString
local IsNumber=Tpp.IsTypeNumber
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum

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
this.MAX_PATROL_VEHICLES=16

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

--parameters
this.soldierParamsProfile={
  save=GLOBAL,--tex global since user still has to restart to get default/modded/reset
  --range=this.switchRange,
  settings={"DEFAULT","CUSTOM"},
  settingNames="soldierParamsProfileSettings",
  settingsTable={
    DEFAULT=function()
      Ivars.soldierSightDistScale:Set(1,true)
      Ivars.soldierHealthScale:Set(1,true) 
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
}

--enemy parameters sight
this.sightScaleRange={max=4,min=0,increment=0.05}

this.soldierSightDistScale={
  save=MISSION,
  default=1,
  range=this.sightScaleRange,
  profile=this.soldierParamsProfile,
}

--[[
this.sightForms={
  "contactSightForm",
  "normalSightForm",
  "farSightForm",
  "searchLightSightForm",
  "observeSightForm",
}

this.sightTypeNames={
  "baseSight",
  "nightSight",
  "combatSight",
  "walkerGearSight",
  "observeSight",
  "snipingSight",
  "searchLightSight",
  "armoredVehicleSight",
  "zombieSight",
  "msfSight",
  "vehicleSight",
}
this.sightFormNames={
  "discovery",
  "indis",
  "dim",
  "far",
  "observe",
}


this.sightIvarLists={
  "sightForms",
  "sightTypeNames",
  "sightFormNames",
}

this.sightDistScaleName="DistScaleSightParam"
for n,listName in ipairs(this.sightIvarLists) do
  for i,name in ipairs(this[listName]) do
    local ivarName=name..this.sightDistScaleName
  
    local ivar={
      save=MISSION,
      default=1,
      range=this.sightScaleRange,
    }
    this[ivarName]=ivar
  end
end--]]
--
this.healthScaleRange={max=9,min=0,increment=0.2}
this.soldierHealthScale={
  save=MISSION,
  default=1,
  range=this.healthScaleRange,
  profile=this.soldierParamsProfile, 
} 
---end soldier params 
this.playerHealthScale={
  save=MISSION,
  default=1,
  range=this.healthScaleRange,
  OnChange=function()
    local healthScale=gvars.playerHealthScale
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
this.mbSoldierEquipGrade={--DEPENDANCY: mbPlayTime
  save=MISSION,
  settings={
    "DEFAULT",
    "MBDEVEL",
    "RANDOM",
    "GRADE1",
    "GRADE2",
    "GRADE3",
    "GRADE4",
    "GRADE5",
    "GRADE6",
    "GRADE7",
    "GRADE8",
    "GRADE9",
    "GRADE10"
  },
  settingNames="set_dd_equip_grade",
}

this.mbSoldierEquipRange={--DEPENDANCY: mbPlayTime
  save=MISSION,
  settings={"DEFAULT","SHORT","MEDIUM","LONG","RANDOM"},
  settingNames="set_dd_equip_range",
}

this.mbDDSuit={--DEPENDANCY: mbPlayTime
  save=MISSION,
  settings={--SYNC: is manually indexed in TppEnemy
    "EQUIPGRADE",
    "FOB_DD_SUIT_ATTCKER",
    "FOB_DD_SUIT_SNEAKING",
    "FOB_DD_SUIT_BTRDRS",
    "FOB_PF_SUIT_ARMOR",
  },
  settingNames="set_dd_suit",
}
--[[this.mbDDBalaclava={--DEPENDANCY: mbPlayTime OFF: Buggy, is setting female bala faceids to male, RETRY ADDLANG
  save=MISSION,
  range=this.switchRange,
  settingNames={"Use Equip Grade", "Force Off"},
}--]]
this.mbWarGames={
  save=MISSION,
  settings={"OFF","NONLETHAL","HOSTILE"},
  settingNames="set_mb_wargames",
}

this.mbEnableBuddies={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
--<motherbase

--demos
this.useSoldierForDemos={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
this.mbDemoSelection={  helpText="Forces or Disables cutscenes that trigger under certain circumstances on returning to Mother Base",--ADDLANG:
  save=MISSION,
  settings={"DEFAULT","PLAY","DISABLED"},
  settingNames="set_mbDemoSelection",
}
this.mbSelectedDemo={
  save=MISSION,
  range={max=#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST-1},
  settingNames=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST,
}

--patchup
this.langOverride={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_lang_override",
}

this.startOffline={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.blockFobTutorial={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.setFirstFobBuilt={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
}

this.isManualHard={--tex not currently user option, but left over for legacy, mostly just switches on hard game over
  save=MISSION,
  range=this.switchRange,
}

this.subsistenceProfile={
  save=MISSION,
  settings={"DEFAULT","PURE","BOUNDER","CUSTOM"},
  settingNames="subsistenceProfileSettings",
  settingsTable={
    DEFAULT=function() 
      Ivars.noCentralLzs:Set(0,true)
      Ivars.disableBuddies:Set(0,true)
      Ivars.disableHeliAttack:Set(0,true)
      Ivars.disableSelectTime:Set(0,true)
      Ivars.disableSelectVehicle:Set(0,true)
      Ivars.disableHeadMarkers:Set(0,true)
      Ivars.disableXrayMarkers:Set(0,true)
      Ivars.disableFulton:Set(0,true)
      Ivars.clearItems:Set(0,true)
      Ivars.clearSupportItems:Set(0,true)
      Ivars.setSubsistenceSuit:Set(0,true)
      Ivars.setDefaultHand:Set(0,true)      
      Ivars.handLevelProfile:Set(0,true) --game auto sets to max developed, but still need this to stop override
      Ivars.fultonLevelProfile:Set(0,true) -- game auto turns on wormhole, user can manually chose overall level in ui
      Ivars.ospWeaponProfile:Set(0,true)
      
      Ivars.disableMenuDrop:Set(0,true)
      Ivars.disableMenuBuddy:Set(0,true)
      Ivars.disableMenuAttack:Set(0,true)
      Ivars.disableMenuHeliAttack:Set(0,true)
      Ivars.disableSupportMenu:Set(0,true)
      
      Ivars.abortMenuItemControl:Set(0,true)
      
      Ivars.fultonLevelProfile:Set(0,true)
    end,
    PURE=function() 
      Ivars.noCentralLzs:Set(1,true)
      Ivars.disableBuddies:Set(1,true)
      Ivars.disableHeliAttack:Set(1,true)
      Ivars.disableSelectTime:Set(1,true)
      Ivars.disableSelectVehicle:Set(1,true)
      Ivars.disableHeadMarkers:Set(1,true)
      Ivars.disableFulton:Set(1,true)
      Ivars.clearItems:Set(1,true)
      Ivars.clearSupportItems:Set(1,true)
      Ivars.setSubsistenceSuit:Set(1,true)
      Ivars.setDefaultHand:Set(1,true)   
      
      if Ivars.ospWeaponProfile:IsDefault() or Ivars.ospWeaponProfile:Is"CUSTOM" then
        Ivars.ospWeaponProfile:Set(1,true)
      end
      if not Ivars.handLevelProfile:Is(1) then
        Ivars.handLevelProfile:Set(1,true)
      end
      if not Ivars.fultonLevelProfile:Is(1) then
        Ivars.fultonLevelProfile:Set(1,true)
      end
      
      Ivars.disableMenuDrop:Set(1,true)
      Ivars.disableMenuBuddy:Set(1,true)
      Ivars.disableMenuAttack:Set(1,true)
      Ivars.disableMenuHeliAttack:Set(1,true)
      Ivars.disableSupportMenu:Set(1,true)
      
      Ivars.abortMenuItemControl:Set(1,true)
      Ivars.phaseUpdate:Set(0,true)
      
      Ivars.fultonLevelProfile:Set(1,true)
    end,
    BOUNDER=function() 
      Ivars.noCentralLzs:Set(1,true)
      Ivars.disableBuddies:Set(0,true)
      Ivars.disableHeliAttack:Set(1,true)
      Ivars.disableSelectTime:Set(1,true)
      Ivars.disableSelectVehicle:Set(1,true)
      Ivars.disableHeadMarkers:Set(0,true)
      Ivars.disableFulton:Set(0,true)
      Ivars.clearItems:Set(1,true)
      Ivars.clearSupportItems:Set(1,true)
      Ivars.setSubsistenceSuit:Set(0,true)
      Ivars.setDefaultHand:Set(1,true)   
      
      if Ivars.ospWeaponProfile:IsDefault() or Ivars.ospWeaponProfile:Is"CUSTOM" then
        Ivars.ospWeaponProfile:Set(1,true)
      end
      
      if Ivars.handLevelProfile:IsDefault() or Ivars.handLevelProfile:Is"CUSTOM" then
        Ivars.handLevelProfile:Set(1,true)
      end
      if Ivars.fultonLevelProfile:IsDefault() or Ivars.fultonLevelProfile:Is"CUSTOM" then
        Ivars.fultonLevelProfile:Set(1,true)
      end
      
      Ivars.disableMenuDrop:Set(1,true)
      Ivars.disableMenuBuddy:Set(0,true)
      Ivars.disableMenuAttack:Set(1,true)
      Ivars.disableMenuHeliAttack:Set(1,true)
      Ivars.disableSupportMenu:Set(1,true)
      
      Ivars.abortMenuItemControl:Set(0,true)
      Ivars.phaseUpdate:Set(0,true)
      
      Ivars.fultonLevelProfile:Set(1,true)
    end,
    CUSTOM=nil,
  },
  OnChange=this.RunCurrentSetting,
  OnSubSettingChanged=this.OnSubSettingChanged,
}

this.noCentralLzs={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
}

this.disableHeliAttack={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
  OnChange=function()
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local enable=gvars.disableHeliAttack==0
    local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
      GameObject.SendCommand(gameObjectId,{id="SetCombatEnabled",enabled=enable}) 
    end 
  end,
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=this.DisableOnSubsistence,
}

this.disableBuddies={
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
}

this.disableXrayMarkers={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  profile=this.subsistenceProfile,
  --[[OnChange=function(self)
    local enabled=self.setting==1
    TppSoldier2.SetDisableMarkerModelEffect{enabled=enabled}
  end,--]]
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
    end,
    HEAVEN=function()
      Ivars.fultonNoMbSupport:Set(1,true)
      Ivars.fultonNoMbMedical:Set(1,true)
      Ivars.fultonDyingPenalty:Set(40,true)
      Ivars.fultonSleepPenalty:Set(20,true)
      Ivars.fultonHoldupPenalty:Set(0,true)
      Ivars.fultonDontApplyMbMedicalToSleep:Set(1,true)
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
  
--<fulton success

--item levels>
this.handLevelRange={max=4,min=1,increment=1}
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
    DEFAULT=function()--the game auto sets to max developed but lets set it for apearance sake 
      --[[for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.max,true)
      end--]]
    end,
    ITEM_OFF=function() 
      for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.min,true)
      end
    end,
    ITEM_MAX=function() 
      for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.max,true)
      end
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
  range=this.switchRange,
  settings=this.switchSettings,
  settingNames="set_switch",
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

this.revengeMode={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_revenge",
  OnChange=function()
    TppRevenge._SetUiParameters()
  end,
}

this.revengeBlockForMissionCount={
  save=MISSION,
  default=3,
  range={max=10},
}

this.applyPowersToLlrp={
  save=MISSION,
  range=this.switchRange,
}

this.applyPowersToOuterBase={
  save=MISSION,
  range=this.switchRange,
}

this.allowHeavyArmorInFreeMode={
  save=MISSION,
  range=this.switchRange,
}

this.allowHeavyArmorInAllMissions={
  save=MISSION,
  range=this.switchRange,
}

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

this.disableReinforceHeliPullOut={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

--this.currentReinforceCount={--NONUSER
--  save=MISSION,
--  range={max=100},
--}

--patrol vehicle stuff>
this.vehiclePatrolProfile={
  save=MISSION,
  settings={"OFF","SINGULAR","EACH_VEHICLE"},
  settingNames="vehiclePatrolProfileSettings",
}

local function TypeChange()
  InfMain.BuildEnabledList()
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
  save=MISSION,
  range={max=10},
}

this.vehiclePatrolClass={
  save=MISSION,
  range={max=10},
}

this.vehiclePatrolEmblemType={
  save=MISSION,
  range={max=10},
}

--<patrol vehicle stuff
this.startOnFoot={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

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
  OnChange=function()
    if gvars.forceSoldierSubType==0 then
      InfMain.ResetCpTableToDefault()
    end
  end,
}

this.unlockSideOps={
  save=MISSION,
  settings={"OFF","REPOP","OPEN"},
  settingNames="set_unlock_sideops",
  OnChange=function()
    TppQuest.UpdateActiveQuest()
  end,
}

this.unlockSideOpNumber={
  save=MISSION,
  range={max=this.numQuests},
  skipValues={[144]=true},
  OnChange=function()
    TppQuest.UpdateActiveQuest()
  end,
}

--mbshowstuff
this.mbShowBigBossPosters={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbShowQuietCellSigns={
  save=MISSION,
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

this.mbDontDemoDisableOcelot={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.mbDontDemoDisableBuddy={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.manualMissionCode={
  save=MISSION,
  settings={
  --LOC,TYPE,Notes
  "1",--INIT
  "5",--TITLE
   --storyMissions
   --[[
  "10010",--CYPR
  "10020",
  "10030",
  "10036",
  "10043",
  "10033",
  "10040",
  "10041",
  "10044",
  "10052",
  "10054",
  "10050",
  "10070",
  "10080",
  "10086",
  "10082",
  "10090",
  "10195",
  "10091",
  "10100",
  "10110",
  "10121",
  "10115",
  "10120",
  "10085",
  "10200",
  "10211",
  "10081",
  "10130",
  "10140",
  "10150",
  "10151",
  "10045",
  "10156",
  "10093",
  "10171",
  "10240",
  "10260",
  "10280",--CYPR
  --]]
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
--[[CULL this.useAppearance={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}--]]

this.playerTypeApearance={
  save=MISSION,
  settings={"DEFAULT","SNAKE","AVATAR","DD_MALE","DD_FEMALE"},
  settingsTable={--tex can just use number as index but want to re-arrange, actual index in exe/playertype is snake=0,dd_male=1,ddfemale=2,avatar=3 
    0,
    PlayerType.SNAKE,
    PlayerType.AVATAR,
    PlayerType.DD_MALE,
    PlayerType.DD_FEMALE
  },
  --settingNames="set_",
  OnChange=function(self)
    if self.setting>0 then
      vars.playerType=self.settingsTable[self.setting+1]
    end
  end,
}

--categories: avatar:avatar,snake dd:dd_male,dd_female
this.cammoTypesApearance={
  save=MISSION,
  settings={
    "OLIVEDRAB",
    "SPLITTER",
    "SQUARE",
    "TIGERSTRIPE",
    "GOLDTIGER",
    "FOXTROT",
    "WOODLAND",
    "WETWORK",    
    "PANTHER",
    --"ARBANGRAY",--hang on ddmale,avatar
    --"ARBANBLUE",
    "REALTREE",--shows as olive
    "INVISIBLE",--shows as olive
    "SNEAKING_SUIT_GZ",--avatar
    "SNEAKING_SUIT_TPP",
    "BATTLEDRESS",
    "PARASITE",
    "NAKED",--shows as olive
    "LEATHER",--avatar
    "SOLIDSNAKE",
    "NINJA",
    "RAIDEN",
    "GOLD",--avatar
    "SILVER",--avatar
    --"AVATAR_EDIT_MAN",--just part of upper body that fits the zoomed cam, lel
    "MGS3",
    "MGS3_NAKED",
    "MGS3_SNEAKING",
    "MGS3_TUXEDO",--not DD_FEMALE
    "EVA_CLOSE",--dd_fem, also works on avatar/snake but they dont have right head lol
    "EVA_OPEN",
    "BOSS_CLOSE",
    "BOSS_OPEN",
    --[["C23",--in exe in same area but may be nothing to do with
    "C27",
    "C30",
    "C35",
    "C38",
    "C39",
    "C42",
    "C49",--]]
  },
  settingsTable={
    PlayerCamoType.OLIVEDRAB,
    PlayerCamoType.SPLITTER,
    PlayerCamoType.SQUARE,
    PlayerCamoType.TIGERSTRIPE,
    PlayerCamoType.GOLDTIGER,
    PlayerCamoType.FOXTROT,
    PlayerCamoType.WOODLAND,
    PlayerCamoType.WETWORK,    
    PlayerCamoType.PANTHER,
    --PlayerCamoType.ARBANGRAY,
    --PlayerCamoType.ARBANBLUE,
    --PlayerCamoType.REALTREE,
    --PlayerCamoType.INVISIBLE,
    PlayerCamoType.SNEAKING_SUIT_GZ,
    PlayerCamoType.SNEAKING_SUIT_TPP,
    PlayerCamoType.BATTLEDRESS,
    PlayerCamoType.PARASITE,
    PlayerCamoType.NAKED,
    PlayerCamoType.LEATHER,
    PlayerCamoType.SOLIDSNAKE,
    PlayerCamoType.NINJA,
    PlayerCamoType.RAIDEN,
    PlayerCamoType.GOLD,
    PlayerCamoType.SILVER,
    --PlayerCamoType.AVATAR_EDIT_MAN,
    PlayerCamoType.MGS3,
    PlayerCamoType.MGS3_NAKED,
    PlayerCamoType.MGS3_SNEAKING,
    PlayerCamoType.MGS3_TUXEDO,
    PlayerCamoType.EVA_CLOSE,
    PlayerCamoType.EVA_OPEN,
    PlayerCamoType.BOSS_CLOSE,
    PlayerCamoType.BOSS_OPEN,
    --[[PlayerCamoType.C23,
    PlayerCamoType.C27,
    PlayerCamoType.C30,
    PlayerCamoType.C35,
    PlayerCamoType.C38,
    PlayerCamoType.C39,
    PlayerCamoType.C42,
    PlayerCamoType.C49,--]]
  },
  --settingNames="set_",
  OnChange=function(self)
    if self.setting>0 then--TODO: add off/default/noset setting
    --vars.playerCamoType=self.settingsTable[self.setting+1]--tex playercammotype is just a enum so could just use setting, but this is if we want to re-arrange
   -- vars.playerPartsType=PlayerPartsType.NORMAL--TODO: camo wont change unless this (one or both, narrow down which) set
   -- vars.playerFaceEquipId=0
   end
  end,
}

this.playerPartsTypeApearance={
  save=MISSION,
  range={min=0,max=100},--TODO: figure out max range

  --[[
  settingsTable={
    "NORMAL",
    "NORMAL_SCARF",
    "SNEAKING_SUIT",
    "MGS1",
    "HOSPITAL",
    "AVATAR_EDIT_MAN",
    "NAKED",
  },
  settingsTable={
    PlayerPartsType.NORMAL,
    PlayerPartsType.NORMAL_SCARF,
    PlayerPartsType.SNEAKING_SUIT,
    PlayerPartsType.MGS1,
    PlayerPartsType.HOSPITAL,
    PlayerPartsType.AVATAR_EDIT_MAN,
    PlayerPartsType.NAKED,
  },
  --]]
  OnChange=function(self)
    if self.setting>0 then--TODO: add off/default/noset setting
     -- vars.playerPartsType=self.setting-1
    end
  end,
}

this.playerFaceEquipIdApearance={
  save=MISSION,
  range={min=0,max=100},--TODO

  --NONE=0??
  --BOSS_BANDANA=1
  --[[
  settingsTable={
    "NORMAL",

  },
  settingsTable={
    0,
    1,
  },
  --]]
  OnChange=function(self)--TODO: add off/default/noset setting
    --vars.playerFaceEquipId=self.setting
  end,
}

this.playerFaceIdApearance={
  save=MISSION,
  range={min=0,max=687},
  OnChange=function(self)
    if self.setting>0 then--TODO: add off/default/noset setting
      vars.playerFaceId=self.setting
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
    if self.setting>0 then--TODO: add off/default/noset setting
      if vars.playerType~=PlayerType.DD_MALE and vars.playerType~=PlayerType.DD_FEMALE then
        InfMenu.PrintLangId"setting_only_for_dd"
        return
      end 
      vars.playerFaceId=self.settingsTable[self.setting+1]
    end
  end,
}

--
this.phaseSettings={
  "PHASE_SNEAK",
  "PHASE_CAUTION",
  "PHASE_EVASION",
  "PHASE_ALERT",
}

--[[this.phaseTable={
  TppGameObject.PHASE_SNEAK,--0
  TppGameObject.PHASE_CAUTION,--1
  TppGameObject.PHASE_EVASION,--2
  TppGameObject.PHASE_ALERT,--3
}--]]

this.minPhase={
  save=MISSION,
  settings=this.phaseSettings,
  --settingsTable=this.phaseTable,
  OnChange=function(self)
    if self.setting>gvars.maxPhase then
      Ivars.maxPhase:Set(self.setting)
    end
  end,
  --profile=this.subsistenceProfile,
}

this.maxPhase={
  save=MISSION,
  settings=this.phaseSettings,
  default=#this.phaseSettings-1,
  --settingsTable=this.phaseTable,
  OnChange=function(self)
    if self.setting<gvars.minPhase then
      Ivars.minPhase:Set(self.setting)
    end
  end,
  profile=this.subsistenceProfile,
}

this.keepPhase={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.phaseUpdate={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  execChecks={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
    lastPhase=0,
    alertBump=false,
  },
  ExecInit=function()InfMain.InitWarpPlayerUpdate()end,
  ExecUpdate=function(...)InfMain.UpdatePhase(...)end,
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

--[[
this.ogrePointChange={
  --save=MISSION,
  default=-100,
  range={min=-10000,max=10000,increment=100},
}
--]]
--[[
this.ogrePointChange={
  save=MISSION,
  settings={"DEFAULT","NORMAL","DEMON"},
  settingNames="ogrePointChangeSettings",
  settingsTable=99999999,
  OnChange=function(self)
    if self.setting==3 then
      TppMotherBaseManagement.SubOgrePoint{ogrePoint=-99999999}
    elseif self.setting==2 then
      TppMotherBaseManagement.AddOgrePoint{ogrePoint=99999999}
    end
  end,
}
--]]

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

  if not (Ivars.subsistenceProfile:IsDefault() or Ivars.subsistenceProfile:Is"CUSTOM") then
    self.disabled=true
    --InfMenu.DebugPrint("is subs")--DEBUG
  else
    self.disabled=false
    --InfMenu.DebugPrint("not subs")--DEBUG
  end
end

this.warpPlayerUpdate={
  --save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=this.DisableOnSubsistence,
  OnChange=function(self,previousSetting)--tex REFACTOR what a mess VERIFY that you can bitcheck disableflags
    --[[
    local OPEN_EQUIP=PlayerDisableAction.OPEN_EQUIP_MENU
    if self.setting==0 and previousSetting~=0 then
      if bit.band(vars.playerDisableActionFlag,OPEN_EQUIP)==OPEN_EQUIP then
       vars.playerDisableActionFlag=vars.playerDisableActionFlag-OPEN_EQUIP
      end
    elseif self.setting==1 and previousSetting~=1 then
      if not (bit.band(vars.playerDisableActionFlag,OPEN_EQUIP)==OPEN_EQUIP) then
       vars.playerDisableActionFlag=vars.playerDisableActionFlag+OPEN_EQUIP
      end 
      vars.playerDisableActionFlag=PlayerDisableAction.OPEN_EQUIP_MENU
    end
    --]]
    if InfMenu.menuOn then 
      InfMain.RestoreActionFlag()
      InfMenu.menuOn=false
    end
    
    if self.setting==1 then
      InfMenu.PrintLangId"warp_mode_on"
    else
      InfMenu.PrintLangId"warp_mode_off"
    end
  end,
  execChecks={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecUpdate=function(...)InfMain.UpdateWarpPlayer(...)end,
}

--
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

--heli
this.heliUpdate={--tex NONUSER, for now, need it alive to pick up pull out
  save=MISSION,
  default=1,
  range=this.switchRange,
  settingNames="set_switch",
  execChecks={inGame=true,inHeliSpace=false},
  execState={
    nextUpdate=0,
  },
  ExecUpdate=function(...)InfMain.UpdateHeli(...)end,
}

--[[
this.heliUpdateRate={--seconds
  save=MISSION,
  default=3,
  range={min=1,max=255},
}
this.heliUpdateRange={--seconds
  save=MISSION,
  range={min=0,max=255},
}
--]]

this.defaultHeliDoorOpenTime={--seconds
  save=MISSION,
  default=15,
  range={min=0,max=120},
}

local HeliEnabledGameCommand=function(self)
  if TppMission.IsFOBMission(vars.missionCode) then return end
  local enable=self.setting==1
  local gameObjectId = GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
  if gameObjectId ~= nil and gameObjectId ~= GameObject.NULL_ID then
    GameObject.SendCommand(gameObjectId,{id=self.gameEnabledCommand,enabled=enable})
  end 
end

this.enableGetOutHeli={--WIP TEST force every frame via update to see if it actually does anything beyond the allow get out when allready at LZ
  save=MISSION,
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
  save=MISSION,
  default=5,--tex from TppHelicopter.SetDefaultTakeOffTime
  range={min=0,max=15},
  OnChange=function(self)
    if TppMission.IsFOBMission(vars.missionCode) then return end
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
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
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
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
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
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
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
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
    local gameObjectId=GameObject.GetGameObjectId("TppHeli2", "SupportHeli")
    if gameObjectId~=nil and gameObjectId~=GameObject.NULL_ID then
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

--end ivar defines

this.OptionIsDefault=function(self)
  return self.setting==self.default
end

this.OptionIsSetting=function(self,setting)--tex for getting setting via name or enum index, just use gvar. if you want the value, or Ivars. if it has none
  if self.enum==nil then
    InfMenu.DebugPrint("Is function called on ivar "..self.name.." which has no settings enum")
    return false
  end
  local settingIndex=self.enum[setting]
  return self.setting==settingIndex
end


this.OptionAboveSetting=function(self,settingName) 
  local settingIndex=self.enum[settingName]
  return self.setting>settingIndex
end

this.OptionBelowSetting=function(self,settingName)
  local settingIndex=self.enum[settingName]
  return self.setting<settingIndex
end

this.OptionIsOrAboveSetting=function(self,settingName)  
  local settingIndex=self.enum[settingName]
  return self.setting>=settingIndex
end

this.OptionIsOrBelowSetting=function(self,settingName)
  local settingIndex=self.enum[settingName]
  return self.setting<=settingIndex
end

local function IsIvar(ivar)--TYPEID
  return IsTable(ivar) and (ivar.range or ivar.settings)   
end

this.UpdateSettingFromGvar=function(option)
  if option.save then
    local gvar=gvars[option.name]
    if gvar~=nil then
      option.setting=gvars[option.name]
    else
      InfMenu.DebugPrint"UpdateSettingFromGvar option.save but no gvar found"
    end
  end
end

--ivar system setup
function this.OnLoadVarsFromSlot()--tex on TppSave.VarRestoreOnMissionStart and checkpoint 
  for name,ivar in pairs(this) do
    if IsIvar(ivar) then
      this.UpdateSettingFromGvar(ivar)
    end
  end
end

--TABLESETUP: Ivars
for name,ivar in pairs(this) do
  if IsIvar(ivar) then   
    ivar.name=name
    
    ivar.range=ivar.range or {}
    ivar.range.max=ivar.range.max or 1
    ivar.range.min=ivar.range.min or 0
    ivar.range.increment=ivar.range.increment or 1
    
    ivar.default=ivar.default or ivar.range.min
    ivar.setting=ivar.default
    
    if ivar.settings then
      ivar.enum=Enum(ivar.settings)
      --[[for name,enum in ipairs(ivar.enum) do
        ivar[name]=false
        if enum==ivar.default then
          ivar[name]=true
        end
      end
      ivar[ivar.settings[ivar.default] ]=true
      --]]
      ivar.range.max=#ivar.settings-1--tex ivars are indexed by 1, lua tables (settings) by 1
    end
    local i,f = math.modf(ivar.range.increment)--tex get fractional part
    f=math.abs(f)
    ivar.isFloat=false
    if f<1 and f~=0 then
      ivar.isFloat=true
    end
    
    --[[if ivar.profile then--tex is subsetting
      if ivar.OnChangeSubSetting==nil then
        ivar.OnChangeSubSetting=OnChangeSubSetting
      end
    end--]]
    
    ivar.IsDefault=this.OptionIsDefault
    ivar.Is=this.OptionIsSetting
    ivar.Above=this.OptionAboveSetting
    ivar.Below=this.OptionBelowSetting
    ivar.AboveOrIs=this.OptionIsOrAboveSetting
    ivar.BelowOrIs=this.OptionIsOrBelowSetting
    
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

function this.DeclareVars()
 -- local 
 local varTable={
 --   {name="ene_typeForcedName",type=TppScriptVars.UINT32,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
 --   {name="ene_typeIsForced",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
    
    {name="mbPlayTime",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
    --CULL{name="vehiclePatrolSpawnedTypes",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=this.MAX_PATROL_VEHICLES,save=true,category=TppScriptVars.CATEGORY_MISSION},
  }
  --[[ from MakeSVarsTable, a bit looser, but strings to strcode is interesting
    local valueType=type(value)
    if valueType=="boolean"then
      type=TppScriptVars.TYPE_BOOL,value=value
    elseif valueType=="number"then
      type=TppScriptVars.TYPE_INT32,value=value
    elseif valueType=="string"then
      type=TppScriptVars.TYPE_UINT32,value=StrCode32(value)
    elseif valueType=="table"then
      value=value
    end
  --]]
  
  for name, ivar in pairs(Ivars) do
    if IsIvar(ivar) then
      if ivar.save then
        local ok=true          
        local svarType=0
        local max=ivar.range.max or 0
        local min=ivar.range.min
        if ivar.isFloat then
          svarType=TppScriptVars.TYPE_FLOAT
        --elseif max < 2 then --TODO: tex bool supprt
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

function this.DeclareSVars()--tex svars are created/cleared on new missions
  return{
    {name="vehiclePatrolSpawnedTypes",type=TppScriptVars.TYPE_UINT8,value=0,arraySize=this.MAX_PATROL_VEHICLES,save=true,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end

return this