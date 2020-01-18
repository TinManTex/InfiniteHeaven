-- DOBUILD: 1 --
--tex mostly acting as InfDefine at the moment
local this={}

this.DEBUGMODE=false
this.modVersion = "r74"
this.modName = "Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local Enum=TppDefine.Enum

this.SUBSISTENCE_CLEAR_SUPPORT_WEAPON_TABLE={{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"},{support="EQP_None"}}

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
  "Default",
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

--[[REF:
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

function this.IsMbWarGames(missionId)
  missionId=missionId or vars.missionCode
  return gvars.mbWarGames>0 and missionId==30050
end
function this.IsMbPlayTime(missionId)
  missionId=missionId or vars.missionCode
  if missionId==30050 then
    return gvars.mbPlayTime>0 or gvars.mbSoldierEquipGrade>0
  end
  return false
end
function this.IsForceSoldierSubType()
  return gvars.forceSoldierSubType>0 and TppMission.IsFreeMission(vars.missionCode)
end

function this.GetMbsClusterSecuritySoldierEquipGrade(missionId)--SYNC: mbSoldierEquipGrade
  local grade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  if this.IsMbPlayTime(missionId) and gvars.mbSoldierEquipGrade>Ivars.mbSoldierEquipGrade.enum.MBDEVEL then
    --TppUiCommand.AnnounceLogView("GetEquipGrade ismbplay, grade > devel")--DEBUG
    if gvars.mbSoldierEquipGrade==Ivars.mbSoldierEquipGrade.enum.RANDOM then
      grade = math.random(1,10)
    else
      grade = gvars.mbSoldierEquipGrade-Ivars.mbSoldierEquipGrade.enum.RANDOM
    end
  end
  --TppUiCommand.AnnounceLogView("GetEquipGrade: gvar:".. gvars.mbSoldierEquipGrade .." grade: ".. grade)--DEBUG
  --TppUiCommand.AnnounceLogView("Caller: ".. tostring(debug.getinfo(2).name) .." ".. tostring(debug.getinfo(2).source))--DEBUG
  return grade
end

function this.GetMbsClusterSecuritySoldierEquipRange(missionId)
  if InfMain.IsMbPlayTime(missionId) then
    if gvars.mbSoldierEquipRange==Ivars.mbSoldierEquipRange.enum.RANDOM then
      return math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
    elseif gvars.mbSoldierEquipRange>0 then
      return gvars.mbSoldierEquipRange-1
    end
  end
  return TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
end

function this.GetMbsClusterSecurityIsNoKillMode(missionId)
  if this.IsMbPlayTime(missionId) then--tex PrepareDDParameter mbwargames, mbsoldierequipgrade
    return gvars.mbWarGames==Ivars.mbWarGames.enum.NONLETHAL
  end
  return TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
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
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpDefault
  for cp, subType in pairs(subTypeOfCp)do
    subTypeOfCp[cp]=subTypeOfCpDefault[cp]
  end
end

return this