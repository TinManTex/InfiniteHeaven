-- DOBUILD: 1
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

local DEFAULT="DEFAULT"
local CUSTOM="CUSTOM"

local function OnChangeSubSetting(setting)
  local profile = setting.profile
  if profile then
    if IsFunc(profile.OnSubSettingChanged) then
      profile.OnSubSettingChanged(profile,self)
    end
  end
end

--local function OnSubSettingChange(profile, subSetting)--tex here the parent profile is notfied a sub setting was changed
  
--end


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
  --[[ CULL: handled by InfMain.Ismbplaytime
   onChange=function()--DEPENDENCY: mbPlayTime
    if gvars.mbSoldierEquipGrade==0 then
      gvars.mbPlayTime=0
    elseif gvars.mbSoldierEquipGrade>0 then
      gvars.mbPlayTime=1
    end
  end--]]
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
--[[this.mbDDBalaclava={--DEPENDANCY: mbPlayTime
  save=MISSION,
  default=0,
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
  onChange=function()
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
  default=0,--DEBUGNOW
  range=this.switchRange,
  settingNames="set_switch",
}

this.isManualHard={
  save=MISSION,
  range=this.switchRange,
}

this.subsistenceProfile={--was isManualSubsistence
  save=MISSION,
  settings={"OFF","PURE","BOUNDER"},
  settingNames="set_subsistence",
  onChange=function()--DEPENDENCY: ospWeaponLoadout. noCentralLzs
    if gvars.subsistenceProfile==0 then
      gvars.ospWeaponLoadout=0
      gvars.noCentralLzs=0
    else
      gvars.noCentralLzs=1
      if gvars.ospWeaponLoadout==0 then
        gvars.ospWeaponLoadout=1
      end
    end
  end,
}

this.noCentralLzs={--NONUSER: DEPENDENCY: subsistenceProfile
  save=MISSION,
  range=this.switchRange,
}

this.ospWeaponLoadout={
  save=MISSION,
  range={max=int8},
  GetMax=function()return #InfMain.ospWeaponLoadouts end,
  settingNames="set_osp",
  helpText="Start with no primary and secondary weapons, can be used seperately from subsistence mode",
}

this.ospWeaponProfile={
  save=MISSION,
  settings={"DEFAULT","PURE","SECONDARY_FREE","CUSTOM"},
  --settingNames="ospWeaponProfileSettings",--DEBUGNOW: ADDLANG
  helpText="Start with no primary and secondary weapons, can be used seperately from subsistence mode",
  profiles={
    DEFAULT=function()
      gvars.primaryWeaponOsp=0
      gvars.secondaryWeaponOsp=0
      gvars.tertiaryWeaponOsp=0    
    end,
    PURE=function()
      gvars.primaryWeaponOsp=1
      gvars.secondaryWeaponOsp=1
      gvars.tertiaryWeaponOsp=1   
    end,
    SECONDARY_FREE=function()
      gvars.primaryWeaponOsp=1
      gvars.secondaryWeaponOsp=0
      gvars.tertiaryWeaponOsp=1
    end,
    CUSTOM=nil,
  },
  OnSubSettingChange=function(profile, subSetting)
    --tex any sub setting will flip this profile to custom
    InfMenu.SetSetting(profile,profile.range.max)--ASSUMPTION: profiles last setting is always CUSTOM
    InfMenu.DisplayProfileChangedToCustom(profile)
  end,
}

local weaponSlotClearSettings={
  "OFF",
  "EQUIP_NONE",
}
this.primaryWeaponOsp={--DEBUGNOW: ADDLANG:
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,--DEBUGNOW: ADDLANG:
  profile=this.ospWeaponLoadout,
}
this.secondaryWeaponOsp={--DEBUGNOW: ADDLANG:
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,--DEBUGNOW: ADDLANG:
  profile=this.ospWeaponLoadout,
}
this.tertiaryWeaponOsp={
  save=MISSION,
  range=this.switchRange,
  settings=weaponSlotClearSettings,--DEBUGNOW: ADDLANG:
  profile=this.ospWeaponLoadout,
}

this.revengeMode={
  save=MISSION,
  range=this.switchRange,
  settingNames="set_revenge",
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
  onChange=function()
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
  onChange=function()
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
  onChange=function()
    TppQuest.UpdateActiveQuest()
  end,
}

this.unlockSideOpNumber={
  save=MISSION,
  range={max=this.numQuests},
  skipValues={[144]=true},
  onChange=function()
    TppQuest.UpdateActiveQuest()
  end,
}


function this.Set(value)
end

--TABLESETUP: Ivars
for name,ivar in pairs(this) do
  if IsTable(ivar) then   
    if ivar.range or ivar.settings then
      ivar.name=name
      ivar.default=ivar.default or 0
      ivar.range=ivar.range or {}
      ivar.range.max=ivar.range.max or 0
      ivar.range.min=ivar.range.min or 0
      ivar.range.increment=ivar.range.increment or 1
      if ivar.settings then
        ivar.enum=Enum(ivar.settings)
        for name,enum in pairs(ivar.enum) do
          ivar[name]=false
          if enum==ivar.default then
            ivar[name]=true
          end
        end
        ivar.range.max=#ivar.settings-1--tex ivars are indexed by 1, lua tables (settings) by 1
      end
      local i,f = math.modf(ivar.range.increment)--tex get fractional part
      f=math.abs(f)
      if f<1 and f~=0 then
        ivar.isFloat=true
      end
      
      if ivar.profile then--tex is subsetting
      --  ivar.onChange=OnChangeSubSetting--DEBUGNOW:
      end
      
      ivar.Set=this.Set
    end--is ivar
  end--is table
end

function this.Init(missionTable)
  for name,ivar in pairs(this) do
    if IsTable(ivar)then
      local GetMax=ivar.GetMax--tex cludge to get around that Gvars.lua calls declarevars during it's compile/before any other modules are up, REFACTOR: Init is actually each mission load I think, only really need this to run once per game load, but don't know the good spot currently
      if GetMax and IsFunc(GetMax) then
        ivar.range.max=GetMax()
      end
    end
  end
end

this.varTable={}--DEBUGNOW: change back to local in DeclareSVars once you no longer want to inspect it
function this.DeclareVars()
 -- local 
 this.varTable={
    {name="soldierTypeForced",type=TppScriptVars.TYPE_BOOL,value=false,arraySize=this.MAX_SOLDIER_STATE_COUNT,save=true,category=TppScriptVars.CATEGORY_MISSION},--NONUSER:
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
    if ivar~=nil then
      if Tpp.IsTypeTable(ivar) then
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
            local debugSplash=SplashScreen.Create("svarfail","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5020_l_alp.ftex",1280,640)--tex ghetto as 'does it run?' indicator
            SplashScreen.Show(debugSplash,0,0.3,0)--tex dog
          end

          local svar={name=name,type=svarType,value=ivar.default,save=true,sync=false,wait=false,category=ivar.save}--tex what is sync? think it's network synce, but MakeSVarsTable for seqences sets it to true for all (but then 50050/fob does make a lot of use of it)          
          if ok then
            this.varTable[#this.varTable+1]=svar
          end
        end--save
      end--table
    end--ivar
  end
  return this.varTable
end

return this