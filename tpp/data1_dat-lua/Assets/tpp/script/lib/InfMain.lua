-- DOBUILD: 1
local this={}

this.DEBUGMODE=false
this.modVersion = "r59"
this.modName = "Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local Enum=TppDefine.Enum

local OSP_CLEAR_WEAPON_TABLE={{primaryHip="EQP_None"},{primaryBack="EQP_None"},{secondary="EQP_None"}}
local OSP_SECONDARY_ONLY_WEAPON_TABLE={{primaryHip="EQP_None"},{primaryBack="EQP_None"}}
local OSP_TERTIARY_ONLY_WEAPON_TABLE={{primaryHip="EQP_None"},{secondary="EQP_None"}}
local OSP_PRIMARY_ONLY_CLEAR_WEAPON_TABLE={{primaryHip="EQP_None"}}
local OSP_SECONDARY_ONLY_CLEAR_WEAPON_TABLE={{secondary="EQP_None"}}
this.SUBSISTENCE_CLEAR_SUPPORT_WEAPON_TABLE={{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}}
this.subsistenceLoadouts={
  OSP_CLEAR_WEAPON_TABLE,--pure
  OSP_SECONDARY_ONLY_WEAPON_TABLE,
  OSP_TERTIARY_ONLY_WEAPON_TABLE,
  OSP_PRIMARY_ONLY_CLEAR_WEAPON_TABLE,
  OSP_SECONDARY_ONLY_CLEAR_WEAPON_TABLE,
}

this.MAX_ANNOUNCE_STRING=256--tex sting length announcde log can handle before crashing the game, actually 288 but that worries me, so keep a little lower
this.MAX_SOLDIER_STATE_COUNT = 360--tex from <mission>_enemy.lua, free missions
this.numQuests=157--tex added SYNC: number of quests
this.disallowSideOps={[144]=true};

this.SETTING_SUBSISTENCE_PROFILE=Enum{"OFF","PURE","BOUNDER"}--SYNC: isManualSubsistence setting names
this.SETTING_UNLOCK_SIDEOPS=Enum{"OFF","REPOP","OPEN","MAX"}--SYNC: unlocksideops setting names TODO: overhaul, rectify with sliders
this.SETTING_MB_EQUIPGRADE=Enum{"DEFAULT","MBDEVEL","RANDOM","GRADE1","GRADE2","GRADE3","GRADE4","GRADE5","GRADE6","GRADE7","GRADE8","GRADE9","GRADE10","MAX"}--SYNC: mbSoldierEquipGrade, settingsnames
this.SETTING_MB_EQUIPRANGE=Enum{"DEFAULT","SHORT","MEDIUM","LONG","RANDOM","MAX"}--SYNC: mbSoldierEquipRange
this.SETTING_MB_WARGAMES=Enum{"OFF","NONLETHAL","HOSTILE","MAX"}--SYNC: mbWarGames
this.SETTING_MB_DD_SUITS=Enum{--SYNC: TppEnemy
  "EQUIPGRADE",
  "FOB_DD_SUIT_ATTCKER",
  "FOB_DD_SUIT_SNEAKING",
  "FOB_DD_SUIT_BTRDRS",
  "FOB_PF_SUIT_ARMOR",
  "MAX",
}
this.SETTING_FORCE_ENEMY_TYPE=Enum{
  "DEFAULT",
  "TYPE_DD",
  "TYPE_SOVIET",
  "TYPE_PF",
  "TYPE_SKULL",
  "TYPE_CHILD",
  "MAX",
}

this.enemySubTypes={
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
}
this.SETTING_FORCE_ENEMY_SUBTYPE=Enum{
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
  "MAX",
}

--[[
EnemyType.TYPE_SOVIET
EnemyType.TYPE_PF
EnemyType.TYPE_DD
EnemyType.TYPE_SKULL
EnemyType.TYPE_CHILD
--]]
this.soldierSubTypesForTypeName={
  TYPE_DD={
    "DD_A",
    "DD_PW",
    "DD_FOB",  
  },
  TYPE_SKULL={
    "SKULL_CYPR",
    "SKULL_AFGH",
  },
  TYPE_SOVIET={
    "SOVIET_A",
    "SOVIET_B",
  },
  TYPE_PF={
    "PF_A",
    "PF_B",
    "PF_C", 
  },
  TYPE_CHILD={
    "CHILD_A",
  },
}
this.soldierTypeForSubtypes={
  DD_A=EnemyType.TYPE_DD,
  DD_PW=EnemyType.TYPE_DD,
  DD_FOB=EnemyType.TYPE_DD,  
  SKULL_CYPR=EnemyType.TYPE_SKULL,
  SKULL_AFGH=EnemyType.TYPE_SKULL,
  SOVIET_A=EnemyType.TYPE_SOVIET,
  SOVIET_B=EnemyType.TYPE_SOVIET,
  PF_A=EnemyType.TYPE_PF,
  PF_B=EnemyType.TYPE_PF,
  PF_C=EnemyType.TYPE_PF, 
  CHILD_A=EnemyType.TYPE_CHILD,
}
function this.SoldierTypeNameForType(soldierType)--tex maybe I'm missing something but not having luck indexing by EnemyType
  if soldierType == nil then
    return nil
  end
  
  if soldierType==EnemyType.TYPE_DD then
    return "TYPE_DD"
  elseif soldierType==EnemyType.TYPE_SKULL then
    return "TYPE_SKULL"
  elseif soldierType==EnemyType.TYPE_SOVIET then
    return "TYPE_SOVIET"
  elseif soldierType==EnemyType.TYPE_PF then
    return "TYPE_PF"
  elseif soldierType==EnemyType.TYPE_CHILD then
    return "TYPE_CHILD"
  end
  return nil
end

function this.IsSubTypeCorrectForType(soldierType,subType)--returns true on nil soldiertype because fsk that
  local soldierTypeName=this.SoldierTypeNameForType(soldierType)
  if soldierTypeName ~= nil then
    local subTypes=this.soldierSubTypesForTypeName[soldierTypeName]
    if subTypes ~= nil then
      for n, _subType in pairs()do
        if subType == _subType then
          return true
        end
      end
      return false
    end
  end
  return true
end
function this.ForceSoldierType(soldierId,soldierType)
  --TppEnemy.GetDefaultSoldierSubType(soldierType)
end

function this.IsMbWarGames()
  return gvars.mbWarGames>0 and vars.missionCode == 30050
end
function this.IsMbPlayTime()
  return gvars.mbPlayTime>0 and vars.missionCode == 30050
end
function this.IsForceSoldierSubType()
  return gvars.forceSoldierSubType>0 and TppMission.IsFreeMission(vars.missionCode)
end
function this.GetMbsClusterSecuritySoldierEquipGrade()--SYNC: mbSoldierEquipGrade
  local grade = 1
  
  if this.IsMbPlayTime() and gvars.mbSoldierEquipGrade>InfMain.SETTING_MB_EQUIPGRADE.MBDEVEL then
    if gvars.mbSoldierEquipGrade==InfMain.SETTING_MB_EQUIPGRADE.RANDOM then
      grade = math.random(1,10)
    else
      grade = gvars.mbSoldierEquipGrade-InfMain.SETTING_MB_EQUIPGRADE.RANDOM
    end
  else
    TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  end
  --TppUiCommand.AnnounceLogView("DBG: GetMbsClusterSecuritySoldierEquipGrade="..grade)--tex DEBUG: CULL:
  return grade
end
function this.GetMbsClusterSecuritySoldierEquipRange() 
  --[[local range = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
    if gvars.mbSoldierEquipRange==InfMain.SETTING_MB_EQUIPRANGE.RANDOM then
      range = math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
    elseif gvars.mbSoldierEquipRange>0 then
      range = gvars.mbSoldierEquipRange-1
    end
    return range--]]
end
function this.GetMbsClusterSecurityIsNoKillMode()
    local isNoKillMode=TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
    if InfMain.IsMbPlayTime() then--tex PrepareDDParameter mbwargames, mbsoldierequipgrade
      isNoKillMode=(gvars.mbWarGames==InfMain.SETTING_MB_WARGAMES.NONLETHAL)
    end
    return isNoKillMode
end
function this.DisplayFox32(foxString)    
  local str32 = Fox.StrCode32(foxString)
  TppUiCommand.AnnounceLogView("string :"..foxString .. "="..str32)
end

function this.soldierFovBodyTableAfghan(missionId)
  local bodyTable={
    {0,MAX_REALIZED_COUNT},
    {1,MAX_REALIZED_COUNT},
    {2,MAX_REALIZED_COUNT},
    {5,MAX_REALIZED_COUNT},
    {6,MAX_REALIZED_COUNT},
    {7,MAX_REALIZED_COUNT},
    {10,MAX_REALIZED_COUNT},
    {11,MAX_REALIZED_COUNT},
    {20,MAX_REALIZED_COUNT},
    {21,MAX_REALIZED_COUNT},
    {22,MAX_REALIZED_COUNT},
    {25,MAX_REALIZED_COUNT},
    {26,MAX_REALIZED_COUNT},
    {27,MAX_REALIZED_COUNT},
    {30,MAX_REALIZED_COUNT},
    {31,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.prs2_main0_v00,MAX_REALIZED_COUNT}
  }
  if not this.IsNotRequiredArmorSoldier(missionId)then
    local e={TppEnemyBodyId.sva0_v00_a,MAX_REALIZED_COUNT}
    table.insert(bodyTable,e)
  end
  return bodyTable
end
function this.soldierFovBodyTableAfrica(missionId)
 local bodyTable={
    {50,MAX_REALIZED_COUNT},
    {51,MAX_REALIZED_COUNT},
    {55,MAX_REALIZED_COUNT},
    {60,MAX_REALIZED_COUNT},
    {61,MAX_REALIZED_COUNT},
    {70,MAX_REALIZED_COUNT},
    {71,MAX_REALIZED_COUNT},
    {75,MAX_REALIZED_COUNT},
    {80,MAX_REALIZED_COUNT},
    {81,MAX_REALIZED_COUNT},
    {90,MAX_REALIZED_COUNT},
    {91,MAX_REALIZED_COUNT},
    {95,MAX_REALIZED_COUNT},
    {100,MAX_REALIZED_COUNT},
    {101,MAX_REALIZED_COUNT},
    {TppEnemyBodyId.prs5_main0_v00,MAX_REALIZED_COUNT}
  }
  local armorTypeTable=this.GetArmorTypeTable(missionId)
  if armorTypeTable~=nil then
    local numArmorTypes=#armorTypeTable
    if numArmorTypes>0 then
      for t,armorType in ipairs(armorTypeTable)do
        if armorType==TppDefine.AFR_ARMOR.TYPE_ZRS then
          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
        elseif armorType==TppDefine.AFR_ARMOR.TYPE_CFA then
          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_b,MAX_REALIZED_COUNT})
        elseif armorType==TppDefine.AFR_ARMOR.TYPE_RC then
          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_c,MAX_REALIZED_COUNT})
        else
          table.insert(bodyTable,{TppEnemyBodyId.pfa0_v00_a,MAX_REALIZED_COUNT})
        end
      end
    end
  end
end

function this.ResetCpTableToDefault()
  local subTypeOfCp=TppEnemy.subTypeOfCp
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpsubTypeOfCpDefault
    for cp, subType in pairs(subTypeOfCp)do
      subTypeOfCp[cp]=subTypeOfCpDefault[cp]
    end
end

return this