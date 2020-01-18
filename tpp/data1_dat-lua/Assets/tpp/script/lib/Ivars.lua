-- DOBUILD: 1
--tex Ivar system
--combines gvar setup, enums, functions per setting in one ungodly mess.
local this={}

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local Enum=TppDefine.Enum
local IsDemoPlaying=DemoDaemon.IsDemoPlaying

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
this.healthMultRange={max=4,min=0,increment=0.2}

this.switchSettings={"OFF","ON"}

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

function this.OnSubSettingChanged(profile, subSetting)--tex here the parent profile is notfied a sub setting was changed
  --InfMenu.DebugPrint("OnChangeSubSetting: "..profile.name.. " subSetting: " .. subSetting.name)
  --tex any sub setting will flip this profile to custom, CUSTOM is mostly a user identifyer, it has no side effects/no settingTable function
  if subSetting.enum==nil or subSetting.enum.CUSTOM==nil or (subSetting:Is("DEFAULT") or subSetting:Is("CUSTOM")) then--tex just a hack way of figuring out if subsetting is a profile itself
    if not profile:Is("CUSTOM") then
      profile:Set(profile.enum.CUSTOM)
      InfMenu.DisplayProfileChangedToCustom(profile)
    end
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

this.UpdateSettingFromGvar=function(option)
  if option.save then
    option.setting=gvars[option.name]
  end
end

this.OptionIsSetting=function(self,settingName)
  local settingIndex=self.enum[settingName]
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

--ivars
--tex NOTE: should be mindful of max setting for save vars, 
--currently the ivar setup fits to the nearest save size type and I'm not sure of behaviour when you change ivars max enough to have it shift save size and load a game with an already saved var of different size

--parameters
this.enemyParameters={
  save=GLOBAL,--tex global since user still has to restart to get default/modded/reset
  range=this.switchRange,
  settingNames="set_enemy_parameters",
}
this.enemyHealthMult={
  save=MISSION,
  default=1,
  range=this.healthMultRange,
} 
this.playerHealthMult={
  save=MISSION,
  default=1,
  range=this.healthMultRange,
}
----motherbase
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
--[[this.mbDDBalaclava={--DEPENDANCY: mbPlayTime OFF: Buggy, RETRY DEBUGNOW: ADDLANG
  save=MISSION,
  range=this.switchRange,
  settingNames={"Use Equip Grade", "Force Off"},
}--]]
this.mbWarGames={
  save=MISSION,
  settings={"OFF","NONLETHAL","HOSTILE"},
  settingNames="set_mb_wargames",
}
--demos
this.useSoldierForDemos={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}
this.mbDemoSelection={
  save=MISSION,
  range={max=2},
  settingNames="set_mbDemoSelection",
  helpText="Forces or Disables cutscenes that trigger under certain circumstances on returning to Mother Base",--ADDLANG:
}
this.mbSelectedDemo={
  save=MISSION,
  range={max=#TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST-1},
  settingNames=TppDefine.MB_FREEPLAY_DEMO_PRIORITY_LIST,
}
----patchup
this.unlockPlayableAvatar={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_switch",
  OnChange=function()
    local currentStorySequence=TppStory.GetCurrentStorySequence()
    if gvars.unlockPlayableAvatar==0 then
      if currentStorySequence<=TppDefine.STORY_SEQUENCE.CLEARD_THE_TRUTH then
        vars.isAvatarPlayerEnable=0
      end
    else
      vars.isAvatarPlayerEnable=1
    end
  end
}

this.langOverride={
  save=GLOBAL,
  range=this.switchRange,
  settingNames="set_lang_override",
}

this.startOffline={--tex cant get it to read, yet isNewgame is fine? does it only work with bools?
  save=GLOBAL,
  default=0,--DEBUGNOW startoffline
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
      
      if Ivars.ospWeaponProfile:Is("DEFAULT") or Ivars.ospWeaponProfile:Is("CUSTOM") then
        Ivars.ospWeaponProfile:Set(1,true)
      end
      if not Ivars.handLevelProfile:Is(1) then
        Ivars.handLevelProfile:Set(1)
      end
      if not Ivars.fultonLevelProfile:Is(1) then
        Ivars.fultonLevelProfile:Set(1)
      end
      
      Ivars.disableMenuDrop:Set(1,true)
      Ivars.disableMenuBuddy:Set(1,true)
      Ivars.disableMenuAttack:Set(1,true)
      Ivars.disableMenuHeliAttack:Set(1,true)
      Ivars.disableSupportMenu:Set(1,true)
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
      
      if Ivars.ospWeaponProfile:Is("DEFAULT") or Ivars.ospWeaponProfile:Is("CUSTOM") then
        Ivars.ospWeaponProfile:Set(1,true)
      end
      
      if Ivars.handLevelProfile:Is("DEFAULT") or Ivars.handLevelProfile:Is("CUSTOM") then
        Ivars.handLevelProfile:Set(1)
      end
      if Ivars.fultonLevelProfile:Is("DEFAULT") or Ivars.fultonLevelProfile:Is("CUSTOM") then
        Ivars.fultonLevelProfile:Set(1)
      end
      
      Ivars.disableMenuDrop:Set(1,true)
      Ivars.disableMenuBuddy:Set(0,true)
      Ivars.disableMenuAttack:Set(1,true)
      Ivars.disableMenuHeliAttack:Set(1,true)
      Ivars.disableSupportMenu:Set(1,true)
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
  profile=this.subsistenceProfile,
}

this.clearSupportItems={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
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
      for i, itemIvar in ipairs(Ivars.fultonLevelProfile.ivarTable()) do
        itemIvar:Set(itemIvar.range.max,true)
      end
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
--]]

this.ospWeaponProfile={
  save=MISSION,
  settings={"DEFAULT","PURE","SECONDARY_FREE","CUSTOM"},
  settingNames="ospWeaponProfileSettings",
  helpText="Start with no primary and secondary weapons, can be used seperately from subsistence mode",
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
  data=this.ReturnCurrent,
}
this.secondaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF={},
    EQUIP_NONE={{primaryBack="EQP_None"}},
  },
  profile=this.ospWeaponProfile,
  data=this.ReturnCurrent,
}
this.tertiaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,
  settingNames="weaponOspSettings",
  settingsTable={
    OFF={},
    EQUIP_NONE={{secondary="EQP_None"}},
  },  
  profile=this.ospWeaponProfile,
  data=this.ReturnCurrent,
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

this.startOnFoot={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_switch",
}

this.clockTimeScale={
  save=GLOBAL,
  default=20,
  range={max=1000,min=1,increment=1},
  OnChange=function()
    if not IsDemoPlaying() then
      TppClock.Start()
    end
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
  --settingNames=InfMain.enemySubTypes,--DEBUGNOW
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
  helpText="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area.",
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

local function IsIvar(ivar)
  return IsTable(ivar) and (ivar.range or ivar.settings)   
end

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
    ivar.range.max=ivar.range.max or 0
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

    ivar.Is=this.OptionIsSetting
    ivar.Above=this.OptionAboveSetting
    ivar.Below=this.OptionBelowSetting
    ivar.AboveOrIs=this.OptionIsOrAboveSetting
    ivar.BelowOrIs=this.OptionIsOrBelowSetting
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
    end
  end
end

function this.DeclareVars()
 -- local 
 local varTable={
 --   {name="ene_typeForcedName",type=TppScriptVars.UINT32,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
 --   {name="ene_typeIsForced",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
    
    {name="mbPlayTime",type=TppScriptVars.TYPE_UINT8,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
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
      if ivar.save and ivar.save~="NOSAVE" then
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
          local debugSplash=SplashScreen.Create("svarfail","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
          SplashScreen.Show(debugSplash,0,0.3,0)--tex dog
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

return this