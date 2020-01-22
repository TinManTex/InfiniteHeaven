-- DOBUILD: 1
local this={}

this.DEBUGMODE=false
this.modVersion="r120"
this.modName="Infinite Heaven"

--LOCALOPT:
local IsFunc=Tpp.IsTypeFunc
local IsTable=Tpp.IsTypeTable
local IsString=Tpp.IsTypeString
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local Enum=TppDefine.Enum
local StrCode32=Fox.StrCode32
local IsTimerActive=GkEventTimerManager.IsTimerActive

--this.debugSplash=SplashScreen.Create("debugEagle","/Assets/tpp/ui/texture/Emblem/front/ui_emb_front_5005_l_alp.ftex",640,640)

function this.IsTableEmpty(checkTable)--tex TODO: shove in a utility module
  local next=next
  if next(checkTable)==nil then
    return true
  end
  return false
end


function this.ForceArmor(missionCode)
  if Ivars.allowHeavyArmorInAllMissions:Is(1) and not TppMission.IsFreeMission(missionCode) then
    return true
  end
  if Ivars.allowHeavyArmorInFreeRoam:Is()>0 and TppMission.IsFreeMission(missionCode) then--DEBUG allowHeavyArmorInFreeRoam actiting as armor limit for debug
    return true
  end
  if Ivars.allowLrrpArmorInFree:Is(1) and TppMission.IsFreeMission(missionCode) then
    return true
  end

  return false
end

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

--EnemyType.TYPE_SOVIET
--EnemyType.TYPE_PF
--EnemyType.TYPE_DD
--EnemyType.TYPE_SKULL
--EnemyType.TYPE_CHILD

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

function this.IsForceSoldierSubType()
  return Ivars.forceSoldierSubType:Is()>0 and TppMission.IsFreeMission(vars.missionCode)
end

-- mb dd equip
function this.IsDDEquip(missionId)
  local missionCode=missionId or vars.missionCode
  if missionCode~=50050 then
    local mbDDEquip = missionCode==30050 and Ivars.enableMbDDEquip:Is(1)
    local enemyDDEquip = missionCode~=30050 and Ivars.enableEnemyDDEquip:Is(1)
    return mbDDEquip or enemyDDEquip
  end
  return false
end

function this.IsDDBodyEquip(missionId)
  local missionCode=missionId or vars.missionCode
  if missionCode==30050 then
    return Ivars.mbDDSuit:Is()>0 --or Ivars.mbDDHeadGear
  end
  return false
end

this.ddBodyInfo={
  SNEAKING_SUIT={
    maleBodyId=TppEnemyBodyId.dds4_enem0_def,
    femaleBodyId=TppEnemyBodyId.dds4_enef0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts",
    extendedPartsInfo={type=1,path="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",
  },
  BATTLE_DRESS={
    maleBodyId=TppEnemyBodyId.dds5_enem0_def,
    femaleBodyId=TppEnemyBodyId.dds5_enef0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts",
    extendedPartsInfo={type=1,path="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",
  },
  PFA_ARMOR={
    maleBodyId=TppEnemyBodyId.pfa0_v00_a,
    noFemaleExtended=true,
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",
    isArmor=true,
    hasHeadGear=true,
    fallBack="BATTLE_DRESS",
  },
  TIGER={
    maleBodyId=TppEnemyBodyId.dds5_main0_v00,
    femaleBodyId=TppEnemyBodyId.dds6_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts",
    extendedPartsInfo={type=1,path="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",
  },
  DRAB={--?? mother base default
    maleBodyId=TppEnemyBodyId.dds3_main0_v00,
    femaleBodyId=TppEnemyBodyId.dds8_main0_v00,
    extendedPartsInfo={type=1,path="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts"},
  },
}

this.ddSuitToDDBodyInfo={
  [TppEnemy.FOB_DD_SUIT_SNEAKING]="SNEAKING_SUIT",
  [TppEnemy.FOB_DD_SUIT_BTRDRS]="BATTLE_DRESS",
  [TppEnemy.FOB_PF_SUIT_ARMOR]="PFA_ARMOR",
  [TppEnemy.FOB_DD_SUIT_ATTCKER]="TIGER",
}

--tex see TppEnemyFaceId
this.ddHeadGearInfo={
  --HMT=DD greentop
  --tex OFF till I put selection in
  --  svs_balaclava={--550,  --[M][---][---][---] Balaclava
  --    MALE=true,
  --  },
  --  pfs_balaclava={--551,  --[M][---][---][---] Balaclava
  --    MALE=true,
  --  },
  dds_balaclava0={--552, --[M][---][---][HMT] DD
    MALE=true,
    HELMET=true,
  },
  dds_balaclava1={--553, --[M][---][---][---] DD blacktop  - some oddness here this shows as helmet/greentop (like 552) when player face set to this, so is the fova for player not set right? TODO:
    MALE=true,
  },
  dds_balaclava2={--554, --[M][---][---][---] DD no blacktop - same issue as above
    MALE=true,
  },
  dds_balaclava3={--555, --[F][---][---][HMT] DD
    FEMALE=true,
    HELMET=true,
  },
  dds_balaclava4={--556, --[F][---][---][---] DD blacktop - same issue as above (but shows as equivalent 555)
    FEMALE=true,
  },
  dds_balaclava5={--557, --[F][---][---][---] DD blacktop - same issue as above
    FEMALE=true,
  },
  dds_balaclava6={--558, --[M][GAS][---][---] DD open clava
    MALE=true,
    GAS_MASK=true,
  },
  dds_balaclava7={--559, --[F][GAS][---][---] DD open clava
    FEMALE=true,
    GAS_MASK=true,
  },
  dds_balaclava8={--560, --[M][GAS][---][---] DD clava and blacktop
    MALE=true,
    GAS_MASK=true,
  },
  dds_balaclava9={--561, --[M][GAS][---][HMT] DD
    MALE=true,
    GAS_MASK=true,
    HELMET=true,
  },
  dds_balaclava10={--562,--[F][GAS][---][---] DD clava and blacktop
    FEMALE=true,
    GAS_MASK=true,
  },
  dds_balaclava11={--563,--[F][GAS][---][HMT] DD
    FEMALE=true,
    GAS_MASK=true,
    HELMET=true,
  },
  dds_balaclava12={--564,--[M][---][NVG][HMT] DD
    MALE=true,
    NVG=true,
    HELMET=true,
  },
  dds_balaclava13={--565,--[M][GAS][NVG][HMT] DD
    MALE=true,
    GAS_MASK=true,
    NVG=true,
    HELMET=true,
  },
  dds_balaclava14={--566,--[F][---][NVG][HMT] DD
    FEMALE=true,
    NVG=true,
    HELMET=true,
  },
  dds_balaclava15={--567,--[F][GAS][NVG][HMT] DD
    FEMALE=true,
    GAS_MASK=true,
    NVG=true,
    HELMET=true,
  },
}

this.ddHeadGearSelection={
  {--[---][---][---] Balaclava
    maleId="svs_balaclava",
    femaleId="dds_balaclava5",--tex no direct match so fallback to something similar
  },
  {--[---][---][---] Balaclava
    maleId="pfs_balaclava",
    femaleId="dds_balaclava4",--tex no direct match so fallback to something similar
  },
  {--[---][---][HMT] DD
    maleId="dds_balaclava0",
    femaleId="dds_balaclava3",
  },
  {--[---][---][---] DD blacktop
    maleId="dds_balaclava1",
    femaleId="dds_balaclava4",
  },
  {--[---][---][---] DD no blacktop
    maleId="dds_balaclava2",
    femaleId="dds_balaclava5",
  },
  {--[GAS][---][---] DD open clava
    maleId="dds_balaclava6",
    femaleId="dds_balaclava7",
  },
  {--[GAS][---][---] DD clava and blacktop
    maleId="dds_balaclava8",
    femaleId="dds_balaclava10",
  },
  {--[GAS][---][HMT] DD
    maleId="dds_balaclava9",
    femaleId="dds_balaclava11",
  },
  {--[---][NVG][HMT] DD
    maleId="dds_balaclava12",
    femaleId="dds_balaclava14",
  },
  {--[GAS][NVG][HMT] DD
    maleId="dds_balaclava13",
    femaleId="dds_balaclava15",
  },
}

function this.GetCurrentDDBodyInfo()
  local suitName=nil
  if Ivars.mbDDSuit:Is"EQUIPGRADE" then
    local ddSuit=TppEnemy.GetDDSuit()
    suitName=this.ddSuitToDDBodyInfo[ddSuit]
  elseif Ivars.mbDDSuit:Is()>1 then--0=OFF,EQUIPGRADE,..specific suits
    suitName=Ivars.mbDDSuit.settings[Ivars.mbDDSuit:Get()+1]
  end
  if suitName==nil then
    return nil
  end

  return this.ddBodyInfo[suitName]
end

function this.AddBodyPack(bodyInfo)
  if not bodyInfo then
    return
  end
  if bodyInfo.missionPackPath then
    TppPackList.AddMissionPack(bodyInfo.missionPackPath)
  end
end

function this.GetHeadGearForPowers(powerSettings,faceId)
  local validHeadGearIds={}
  --CULL local powerSettings=mvars.ene_soldierPowerSettings[soldierId]or nil
  if powerSettings then
    local gearPowerTypes={
      HELMET=true,
      GAS_MASK=true,
      NVG=true,
    }
    local function IsFemale(faceId)
      local isFemale=TppSoldierFace.CheckFemale{face={faceId}}
      return isFemale and isFemale[1]==1
    end
    for headGearId, headGearInfo in pairs(InfMain.ddHeadGearInfo)do
      local isMatch=true
      if IsFemale(faceId)==true then
        if not headGearInfo.FEMALE then
          isMatch=false
        end
      else
        if not headGearInfo.MALE then
          isMatch=false
        end
      end

      if isMatch then
        for powerType, bool in pairs(gearPowerTypes)do
          if powerSettings[powerType] and not headGearInfo[powerType] then
            isMatch=false
          end
          if headGearInfo[powerType] and not powerSettings[powerType] then
            isMatch=false
          end
        end
      end
      if isMatch then
        table.insert(validHeadGearIds,headGearId)
      end
    end
  end

  return validHeadGearIds
end

function this.GetMbsClusterSecuritySoldierEquipGrade(missionId)--SYNC: mbSoldierEquipGrade
  local missionCode=missionId or vars.missionCode
  local grade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
  if this.IsDDEquip(missionCode) then
    math.randomseed(gvars.rev_revengeRandomValue)
    grade=this.MinMaxIvarRandom"mbSoldierEquipGrade"
    math.randomseed(os.time())
  end
  --TppUiCommand.AnnounceLogView("GetEquipGrade: gvar:".. Ivars.mbSoldierEquipGrade:Get() .." grade: ".. grade)--DEBUG
  --TppUiCommand.AnnounceLogView("Caller: ".. tostring(debug.getinfo(2).name) .." ".. tostring(debug.getinfo(2).source))--DEBUG
  return grade
end

function this.GetMbsClusterSecuritySoldierEquipRange(missionId)
  local missionCode=missionId or vars.missionCode
  if this.IsDDEquip(missionCode) then
    if Ivars.mbSoldierEquipRange:Is"RANDOM" then
      return math.random(0,2)--REF:{ "FOB_ShortRange", "FOB_MiddleRange", "FOB_LongRange", }, but range index from 0
    else
      return Ivars.mbSoldierEquipRange:Get()
    end
  end
  return TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipRange()
end

function this.GetMbsClusterSecurityIsNoKillMode(missionId)
  local missionCode=missionId or vars.missionCode
  if this.IsDDEquip(missionCode) then
    return Ivars.mbWarGames:Is"NONLETHAL"
  end
  return TppMotherBaseManagement.GetMbsClusterSecurityIsNoKillMode()
end

function this.DisplayFox32(foxString)
  local str32 = Fox.StrCode32(foxString)
  TppUiCommand.AnnounceLogView("string :"..foxString .. "="..str32)
end

function this.ResetCpTableToDefault()
  local subTypeOfCp=TppEnemy.subTypeOfCp
  local subTypeOfCpDefault=TppEnemy.subTypeOfCpDefault
  for cp, subType in pairs(subTypeOfCp)do
    subTypeOfCp[cp]=subTypeOfCpDefault[cp]
  end
end

local afghSubTypes={
  "SOVIET_A",
  "SOVIET_B",
}
local isAfghSubType={--tex ugly
  SOVIET_A=true,
  SOVIET_B=true,
}
local mafrSubTypes={
  "PF_A",
  "PF_B",
  "PF_C",
}
local isMafrSubType={
  PF_A=true,
  PF_B=true,
  PF_C=true,
}
function this.RandomizeCpSubTypeTable()
  if Ivars.changeCpSubTypeFree:Is(0) and Ivars.changeCpSubTypeForMissions:Is(0) then
    return
  end

  if vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE then
    if Ivars.changeCpSubTypeFree:Is(0) then
      return
    end
  else
    if Ivars.changeCpSubTypeForMissions:Is(0) then
      return
    end
  end

  math.randomseed(gvars.rev_revengeRandomValue)--tex set to a math.random on OnMissionClearOrAbort so a good base for a seed to make this constand on mission loads. Soldiers dont care since their subtype is saved but other functions read subTypeOfCp
  local subTypeOfCp=TppEnemy.subTypeOfCp
  for cp, subType in pairs(subTypeOfCp)do
    local subType=subTypeOfCp[cp]
    if isAfghSubType[subType] then
      --local rnd=TppRevenge._Random(1,#afghSubTypes)
      local rnd=math.random(1,#afghSubTypes)
      subTypeOfCp[cp]=afghSubTypes[rnd]
    elseif isMafrSubType[subType] then
      --local rnd=TppRevenge._Random(1,#mafrSubTypes)
      local rnd=math.random(1,#mafrSubTypes)
      --InfMenu.DebugPrint("rnd:"..rnd)--DEBUG
      subTypeOfCp[cp]=mafrSubTypes[rnd]
    end
  end
  math.randomseed(os.time())--tex back to 'truly random' /s for good measure
end

--function this.GetGameId(gameId,type)
--if IsString(gameId) then
--gameId=GetGameObjectId(gameId)
--local soldierId=GetGameObjectId("TppSoldier2",soldierName)
--if soldierId~=NULL_ID then
--end
--if gameId==nil or gameId==NULL_ID then
--return nil
--end
--end

function this.ChangePhase(cpName,phase)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfMenu.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetPhase",phase=phase}
  SendCommand(gameId,command)
end

function this.SetKeepAlert(cpName,enable)
  local gameId=GetGameObjectId("TppCommandPost2",cpName)
  if gameId==NULL_ID then
    InfMenu.DebugPrint("Could not find cp "..cpName)
    return
  end
  local command={id="SetKeepAlert",enable=enable}
  GameObject.SendCommand(gameId,command)
end

--
-- revenge system stuff>

--tex TODO: put in some util or math module
function this.round(num,idp)
  return tonumber(string.format("%." .. (idp or 0) .. "f", num))
end

function this.MinMaxIvarRandom(ivarName)
  local ivarMin=Ivars[ivarName.."_MIN"]
  local ivarMax=Ivars[ivarName.."_MAX"]
  return math.random(ivarMin:Get(),ivarMax:Get())
end

function this.CreateCustomRevengeConfig()
  local revengeConfig={}
  math.randomseed(gvars.rev_revengeRandomValue)
  for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
    local powerTable=Ivars[powerTableName]
    for m,powerType in ipairs(powerTable)do
      local min=Ivars[powerType.."_MIN"].setting*100
      local max=Ivars[powerType.."_MAX"].setting*100
      local random=math.random(min,max)
      random=this.round(random)
      --InfMenu.DebugPrint(ivarName.." min:"..tostring(min).." max:"..tostring(max).. " random:"..tostring(random))--DEBUG
      if random>0 then
        revengeConfig[powerType]=tostring(random).."%"
      end
    end
  end

  for n,powerType in ipairs(Ivars.abilitiesWithLevels)do
    local ivarMin=Ivars[powerType.."_MIN"]
    local ivarMax=Ivars[powerType.."_MAX"]
    local random=math.random(ivarMin:Get(),ivarMax:Get())
    if random>0 then
      local powerType=powerType.."_"..ivarMin.settings[random+1]
      revengeConfig[powerType]=true
    end
  end
  
  for n,powerType in ipairs(Ivars.weaponStrengthPowers)do
    local ivarMin=Ivars[powerType.."_MIN"]
    local ivarMax=Ivars[powerType.."_MAX"]
    local random=math.random(ivarMin:Get(),ivarMax:Get())
    if random==1 then
      revengeConfig[powerType]=true
    end
  end
  
  local random=math.random(Ivars.reinforceLevel_MIN:Get(),Ivars.reinforceLevel_MAX:Get())
  if random>0 then
    revengeConfig.SUPER_REINFORCE=true
  end
  if random==Ivars.reinforceLevel_MIN.enum.BLACK_SUPER_REINFORCE then
    revengeConfig.BLACK_SUPER_REINFORCE=true
  end
  
  local random=math.random(Ivars.revengeIgnoreBlocked_MIN:Get(),Ivars.revengeIgnoreBlocked_MAX:Get())
  if random>0 then
    revengeConfig.IGNORE_BLOCKED=true
  end
  
  local random=math.random(Ivars.reinforceCount_MIN:Get(),Ivars.reinforceCount_MAX:Get())
--  if random>0 then
    revengeConfig.REINFORCE_COUNT=random
--  end
  
  math.randomseed(os.time())
  return revengeConfig
end

local function AvePowerSetting(powerType)
  if Ivars[powerType.."_MIN"]==nil or Ivars[powerType.."_MAX"]==nil then
    InfMenu.DebugPrint("AvePowerSetting cannot find powertype:"..powerType)--DEBUG
    return 0
  end

  return (Ivars[powerType.."_MIN"]:Get()+Ivars[powerType.."_MAX"]:Get())/2
end

function this.SetCustomRevengeUiParameters()
  --tex ui params range is 0-3
  local uiRange=3
  
  --tex just averaging between min/max, could probably save actual chosen value somewhere but would only be accurate for Global config and not per cp config mode
  local fulton=this.round(AvePowerSetting"FULTON") 
  
  local headShot=this.round(uiRange*AvePowerSetting"HELMET") 
  
  --REF stealth 5
--    STEALTH_SPECIAL=true,
--    HOLDUP_HIGH=true,
--    ACTIVE_DECOY=true,
--    GUN_CAMERA=true},

  local stealthPowers={
    "DECOY",
    "MINE",
    "CAMERA",
  }
  
  local ave=0
  for n,powerType in ipairs(stealthPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/#stealthPowers
  
  local stealth=this.round(uiRange*ave)--TODO incorporate-^- stralth and holdup abilities at least
  
  --REF combat 5
  --STRONG_WEAPON=true,
  --COMBAT_SPECIAL=true,
  --SUPER_REINFORCE=true,
  --BLACK_SUPER_REINFORCE=true,
  --REINFORCE_COUNT=3},
  local combatPowers={
    "ARMOR",
    "SOFT_ARMOR",
    "SHIELD",
    "MG",
    "SHOTGUN",
    "MISSILE",--tex in normal game I don't think missile is even accounted for in ui params?
  }
  local ave=0
  for n,powerType in ipairs(combatPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/(#combatPowers/2)--tex KLUDGE half the count
  
  local combat=this.round(uiRange*ave)--tex TODO incorporate rest of combat powers
  
  local nightPowers={
    "NVG",
    "GUN_LIGHT",
  }
  local ave=0
  for n,powerType in ipairs(nightPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/(#nightPowers/2)--tex KLUDGE bump
  if ave>1 then
    ave=1
  end
  local night=this.round(uiRange*ave)

  local sniperPowers={
    "SNIPER",
    "STRONG_SNIPER",--tex mixing unalike values here, sniper is percentage, strong is intbool
  }
  local ave=0
  for n,powerType in ipairs(sniperPowers) do
    ave=ave+AvePowerSetting(powerType)
  end
  ave=ave/(#sniperPowers/2)--tex KLUDGE bump
  if ave>1 then
    ave=1
  end
  local longRange=this.round(uiRange*ave)
  
  --InfMenu.DebugPrint("fulton="..fulton.." headShot="..headShot.." stealth="..stealth.." combat="..combat.." night="..night.." longRange="..longRange)--DEBUG
  TppUiCommand.RegisterEnemyRevengeParameters{fulton=fulton,headShot=headShot,stealth=stealth,combat=combat,night=night,longRange=longRange}
end

--CALLER: TppRevenge._ApplyRevengeToCp
function this.GetSumBalance(balanceTypes,revengeConfig,totalSoldierCount,originalSettingsTable)
  local sumBalance=0
  local numBalance=0

  for n,powerType in pairs(balanceTypes) do
    local powerSetting=revengeConfig[powerType]
    if powerSetting~=nil and powerSetting~=0 then--tex powersetting should never be 0 from what I've seen, but checking anyway

      local percentage=0
      --tex convert from num soldiers to percentage
      if Tpp.IsTypeNumber(powerSetting)then
        if powerSetting>totalSoldierCount then
          powerSetting=totalSoldierCount
        end
        if totalSoldierCount~=0 then
          percentage=(powerSetting/totalSoldierCount)*100
          originalSettingsTable[powerType]=percentage
          numBalance=numBalance+1
          sumBalance=sumBalance+percentage
          --InfMenu.DebugPrint("powerType:"..powerType.." powerSetting:"..tostring(powerSetting).." numtopercentage:"..percentage)--DEBUG
        end
      elseif Tpp.IsTypeString(powerSetting)then
        if powerSetting:sub(-1)=="%"then
          percentage=powerSetting:sub(1,-2)+0
          originalSettingsTable[powerType]=percentage
          numBalance=numBalance+1
          sumBalance=sumBalance+percentage
          --InfMenu.DebugPrint("powerType:"..powerType.." powerSetting:"..powerSetting.." stringtopercentage:"..percentage)--DEBUG
        end
      end
    end--if powersetting
  end--for balanceGearTypes

  return numBalance,sumBalance,originalSettingsTable
end


--CALLER: TppRevenge._ApplyRevengeToCp
function this.BalancePowers(numBalance,reservePercent,originalSettingsTable,revengeConfig)
  if numBalance==0 then
    InfMenu.DebugPrint"BalancePowers numballance==0"
    return
  end

  local balancePercent=0
  if numBalance>0 then
    local maxPercent=100-reservePercent
    balancePercent=maxPercent/numBalance
    --tex bump up the balance percent from those that are under
    --TODO: bump up on an individual power basis biased by those that have higher original requested percentage
    local aboveBalance=numBalance
    local underflow=0
    for powerType,percentage in pairs(originalSettingsTable) do
      if percentage < balancePercent then
        underflow=underflow+(balancePercent-percentage)
        aboveBalance=aboveBalance-1
      end
    end

    --InfMenu.DebugPrint("numBalance:"..numBalance.." balancePercent:"..balancePercent.." underflow:"..underflow)--DEBUG

    --OFF if underflow>0 then--tex distribute underflow evenly
    -- balancePercent=balancePercent+(underflow/aboveBalance)
    -- underflow=0
    --end

    --tex distribute underflow in ballanceGearType order
    for powerType,percentage in pairs(originalSettingsTable) do
      if percentage>balancePercent then
        local toOriginalPercent=originalSettingsTable[powerType]-balancePercent
        local bump=math.min(underflow,toOriginalPercent)
        underflow=underflow-bump
        -- InfMenu.DebugPrint("numBalance:"..numBalance.." powerType:"..powerType.." balancePercent:"..balancePercent.." bump:"..bump)--DEBUG
        revengeConfig[powerType]=tostring(balancePercent+bump).."%"
      end
    end
    --InfMenu.DebugPrint("numBalance:"..numBalance.." sumBalance:"..sumBalance.." balancePercent:"..balancePercent)--DEBUG
  end--if numbalance
  return revengeConfig--tex already been edited in-place, but this is clearer
end--function
--

this.SetFriendlyCp = function()
  local gameObjectId = { type="TppCommandPost2", index=0 }
  local command = { id = "SetFriendlyCp" }
  GameObject.SendCommand( gameObjectId, command )
end

this.SetFriendlyEnemy = function()
  local gameObjectId = { type="TppSoldier2" }
  local command = { id="SetFriendly", enabled=true }
  GameObject.SendCommand( gameObjectId, command )
end

--tex TODO:
function this.GetClosestCp()
  local closestCpId=nil
  local closestDist=9999999999999
  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId and cpId~=NULL_ID then
      --local cpPos=?
      local playerPos=TppPlayer.GetPosition()
      local distSqr=TppMath.FindDistance(cpPos,playerPos)
    end
  end
end

--<cp stuff

--vehicle stuff>
local vehicleBaseTypes={
  LIGHT_VEHICLE={--jeep
    ivar="vehiclePatrolLvEnable",
  },
  TRUCK={
    ivar="vehiclePatrolTruckEnable",
    easternVehicles={
      "EASTERN_TRUCK",
      "EASTERN_TRUCK_CARGO_AMMUNITION",
      "EASTERN_TRUCK_CARGO_MATERIAL",
      "EASTERN_TRUCK_CARGO_DRUM",
      "EASTERN_TRUCK_CARGO_GENERATOR",
    },
    westernVehicles={
      "WESTERN_TRUCK",
      "WESTERN_TRUCK_CARGO_ITEM_BOX",
      "WESTERN_TRUCK_CARGO_CONTAINER",
    --"WESTERN_TRUCK_HOOD",--tex OFF only used in one mission TODO: build own pack with it
    },
  },
  WHEELED_ARMORED_VEHICLE={
    ivar="vehiclePatrolWavEnable",
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
    },
  },
  WHEELED_ARMORED_VEHICLE_HEAVY={
    ivar="vehiclePatrolWavHeavyEnable",
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
    },
  },
  TRACKED_TANK={
    ivar="vehiclePatrolTankEnable",
  },
}

this.VEHICLE_SPAWN_TYPE={--SYNC vehicleSpawnInfoTable
  "EASTERN_LIGHT_VEHICLE",
  "WESTERN_LIGHT_VEHICLE",
  "EASTERN_TRUCK",
  "EASTERN_TRUCK_CARGO_AMMUNITION",
  "EASTERN_TRUCK_CARGO_MATERIAL",
  "EASTERN_TRUCK_CARGO_DRUM",
  "EASTERN_TRUCK_CARGO_GENERATOR",
  "WESTERN_TRUCK",
  "WESTERN_TRUCK_CARGO_ITEM_BOX",
  "WESTERN_TRUCK_CARGO_CONTAINER",
  "WESTERN_TRUCK_CARGO_CISTERN",
  "WESTERN_TRUCK_HOOD",
  "EASTERN_WHEELED_ARMORED_VEHICLE",
  "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
  "WESTERN_WHEELED_ARMORED_VEHICLE",
  "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
  "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
  "EASTERN_TRACKED_TANK",
  "WESTERN_TRACKED_TANK",
}
this.VEHICLE_SPAWN_TYPE_ENUM=Enum(this.VEHICLE_SPAWN_TYPE)

local vehicleSpawnInfoTable={--SYNC VEHICLE_SPAWN_TYPE
  EASTERN_LIGHT_VEHICLE={
    baseType="LIGHT_VEHICLE",
    type=Vehicle.type.EASTERN_LIGHT_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },
  WESTERN_LIGHT_VEHICLE={
    baseType="LIGHT_VEHICLE",
    type=Vehicle.type.WESTERN_LIGHT_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  EASTERN_TRUCK={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_AMMUNITION={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_AMMUNITION,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_MATERIAL={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_MATERIAL,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_DRUM={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_DRUM,
    class=nil,
    paintType=nil,
  },
  EASTERN_TRUCK_CARGO_GENERATOR={
    baseType="TRUCK",
    type=Vehicle.type.EASTERN_TRUCK,
    subType=Vehicle.subType.EASTERN_TRUCK_CARGO_GENERATOR,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_CARGO_ITEM_BOX={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_ITEM_BOX,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_CARGO_CONTAINER={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_CONTAINER,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_CARGO_CISTERN={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_CARGO_CISTERN,
    class=nil,
    paintType=nil,
  },

  WESTERN_TRUCK_HOOD={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_TRUCK,
    subType=Vehicle.subType.WESTERN_TRUCK_HOOD,
    class=nil,
    paintType=nil,
  },

  EASTERN_WHEELED_ARMORED_VEHICLE={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_east_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav.fpk",
  --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52130.fpk",
  },

  EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY={
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY,
    class=nil,
    paintType=nil,
    --OWpackPath="/Assets/tpp/pack/ih_east_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_wav_rocket.fpk",
  --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52130.fpk",
  },


  WESTERN_WHEELED_ARMORED_VEHICLE={--Nope, vehicle seems almost complete, just no turret and no use cases in game
    baseType="WHEELED_ARMORED_VEHICLE",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN,
    class=nil,
    paintType=nil,
    -- packPath="/Assets/tpp/pack/ih_west_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_machinegun.fpk",
  --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52110.fpk",
  },

  WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON={
    baseType="TRUCK",
    type=Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE,
    subType=Vehicle.subType.WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_west_wavs.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_wav_cannon.fpk",
  --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52110.fpk",
  },

  EASTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.EASTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_east_tank.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_east_tnk.fpk",
  --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52015.fpk",
  },

  WESTERN_TRACKED_TANK={
    baseType="TRACKED_TANK",
    type=Vehicle.type.WESTERN_TRACKED_TANK,
    subType=Vehicle.subType.NONE,
    class=nil,
    paintType=nil,
    --packPath="/Assets/tpp/pack/ih_west_tank.fpk",
    packPath="/Assets/tpp/pack/vehicle/veh_rl_west_tnk.fpk",
  --packPathAlt="/Assets/tpp/pack/mission2/quest/extra/quest_q52045.fpk",
  },
}

local enabledList=nil--tex cleared on Init, TODO: don't like this setup

function this.IsPatrolVehicleMission()
  if vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE then
    return true
  end
  return false
end

this.MAX_PATROL_VEHICLES=16--SYNC: ivars MAX_PATROL_VEHICLES

function this.BuildEnabledList()
  enabledList={}
  for baseType,typeInfo in pairs(vehicleBaseTypes) do
    if typeInfo.ivar then
      --InfMenu.DebugPrint("spawnInfo.ivar="..spawnInfo.ivar)--DEBUG
      if gvars[typeInfo.ivar]~=nil and gvars[typeInfo.ivar]>0 then
        enabledList[#enabledList+1]=baseType
        --InfMenu.DebugPrint(baseType.." added to enabledList")--DEBUG
      end
    end
  end
end

--CALLER: TppEnemy.SpawnVehicle
--IN: spawnInfo
--OUT: spawnInfo
function this.PreSpawnVehicle(spawnInfo)
  if Ivars.vehiclePatrolProfile:Is(0) then
    return
  end

  if not this.IsPatrolVehicleMission() then
    return
  end

  if not spawnInfo.locator then
    return
  end

  if not string.find(spawnInfo.locator, "veh_trc_000") then--tex only replacing certain ids, seen in free mission vehicle spawn list
    return
  end

  local vehicleNumber=string.sub(spawnInfo.locator,9)
  vehicleNumber=tonumber(vehicleNumber)

  if vehicleNumber==nil then
    InfMenu.DebugPrint("vehiclePatrolSpawned but could not convert "..spawnInfo.locator.." to number")
    return
  end

  if vehicleNumber<0 or vehicleNumber>=this.MAX_PATROL_VEHICLES then
    InfMenu.DebugPrint("WARNING: vehicleNumber out of bounds: "..vehicleNumber)
    return
  end

  if Ivars.vehiclePatrolProfile:Is"SINGULAR" then
    vehicleNumber=0
  end

  local vehicleTypeNumber=svars.vehiclePatrolSpawnedTypes[vehicleNumber]

  if vehicleTypeNumber==nil then
    InfMenu.DebugPrint("ERROR: vehicleTypeNumber==nil")
    return
  end

  if vehicleTypeNumber==0 then
    --InfMenu.DebugPrint("vehicleTypeNumber==0")--DEBUG
    this.ModifyVehicleSpawn(vehicleNumber,spawnInfo)
  else
    this.RestoreVehiclePatrol(vehicleTypeNumber,spawnInfo)
  end
end

function this.RestoreVehiclePatrol(vehicleTypeNumber, spawnInfo)

  local vehicleType=this.VEHICLE_SPAWN_TYPE[vehicleTypeNumber]
  if vehicleType==nil then
    InfMenu.DebugPrint("could not restore vehicle "..spawnInfo.locator.." vehicletype nil with info type index "..vehicleTypeNumber)
    return
  end

  local vehicle=vehicleSpawnInfoTable[vehicleType]
  if vehicle==nil then
    InfMenu.DebugPrint("could not restore vehicle "..spawnInfo.locator.." vehicle nil with info type index "..vehicleTypeNumber)
    return
  end


  --InfMenu.DebugPrint("restoring "..spawnInfo.locator.." with "..vehicleType)--DEBUG
  this.SetPatrolSpawnInfo(vehicle,spawnInfo)
end

function this.ModifyVehicleSpawn(vehicleNumber,spawnInfo)
  if enabledList==nil then
    this.BuildEnabledList()
  end

  if #enabledList==0 then
    --InfMenu.DebugPrint"ModifyVehicleSpawn - enabledList empty"--DEBUG
    return
  end

  local vehicle=nil
  local vehicleType=nil

  --CULL if Ivars.vehiclePatrolProfile:Is"EACH_VEHICLE" or svars.vehiclePatrolSpawnedTypes[0]==0 then--tex using first in array set as indicator of Is"SINGULAR" set
  local baseType=enabledList[math.random(#enabledList)]
  local baseTypeInfo=vehicleBaseTypes[baseType]
  if baseTypeInfo==nil then
    InfMenu.DebugPrint("No baseTypeInfo for baseType "..baseType)
    return
  end

  local vehicles=nil
  local locationName=""
  if TppLocation.IsAfghan()then
    vehicles=baseTypeInfo.easternVehicles
    locationName="EASTERN_"
  elseif TppLocation.IsMiddleAfrica()then
    vehicles=baseTypeInfo.westernVehicles
    locationName="WESTERN_"
  end

  if vehicles==nil then
    vehicleType=locationName..baseType
  else
    vehicleType=vehicles[math.random(#vehicles)]
  end
  --end

  if vehicleType==nil then
    InfMenu.DebugPrint("warning: vehicleType==nil")
    return
  end

  vehicle=vehicleSpawnInfoTable[vehicleType]
  if vehicle==nil then
    InfMenu.DebugPrint("warning: vehicle==nil")
    return
  end

  --InfMenu.DebugPrint("spawning "..spawnInfo.locator.." with "..vehicleType)--DEBUG

  if svars.vehiclePatrolSpawnedTypes==nil then
    InfMenu.DebugPrint"svars.vehiclePatrolSpawnedTypes==nil"--DEBUG
  end
  svars.vehiclePatrolSpawnedTypes[vehicleNumber]=this.VEHICLE_SPAWN_TYPE_ENUM[vehicleType]+1

  this.SetPatrolSpawnInfo(vehicle,spawnInfo)
end

function this.SetPatrolSpawnInfo(vehicle,spawnInfo)
  spawnInfo.type=vehicle.type
  spawnInfo.subType=vehicle.subType
  --spawnInfo.class=vehicle.class
  --spawnInfo.paintType=vehicle.paintType

  --spawnInfo.class=gvars.vehiclePatrolClass
  --spawnInfo.paintType=gvars.vehiclePatrolPaintType
  --spawnInfo.emblemType=gvars.vehiclePatrolEmblemType
end

--OUT: missionPackPath
local function AddMissionPack(packPath,missionPackPath)
  if Tpp.IsTypeString(packPath)then
    table.insert(missionPackPath,packPath)
  end
end

--IN: vehicleSpawnInfoTable
--OUT: missionPackPath
--CALLER: TppMissionList.GetMissionPackagePath
--TODO: only add those packs of active vehicles
--ditto reinforce vehicle types (or maybe an seperate equivalent function)
function this.AddVehiclePacks(missionCode,missionPackPath)
  if Ivars.vehiclePatrolProfile:Is(0) then
    return
  end
  if not this.IsPatrolVehicleMission() then
    return
  end

  --  for baseType,typeInfo in ipairs(vehicleBaseTypes) do
  --    if gvars[typeInfo.ivar]~=nil and gvars[typeInfo.ivar]>0 then
  --      --InfMenu.DebugPrint("has gvar ".. typeInfo.ivar)--DEBUG
  --
  --      local vehicles=nil
  --      local vehicleType=""
  --      local locationName=""
  --      if TppLocation.IsAfghan()then
  --        vehicles=typeInfo.easternVehicles
  --        locationName="EASTERN_"
  --      elseif TppLocation.IsMiddleAfrica()then
  --        vehicles=typeInfo.westernVehicles
  --        locationName="WESTERN_"
  --      end
  --
  --
  --      local GetPackPath=function(vehicleType)
  --        local vehicle=vehicleSpawnInfoTable[vehicleType]
  --        if vehicle~=nil then
  --          if Ivars.vehiclePatrolPackType:Is"QUESTPACK" then
  --            return vehicle.packPathAlt or nil
  --          else
  --            return vehicle.packPath or nil
  --          end
  --        end
  --      end
  --
  --      if vehicles==nil then
  --        vehicleType=locationName..typeInfo
  --        local packPath=GetPackPath(vehicleType)
  --        if packPath~=nil then
  --           InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
  --          AddMissionPack(packPath,missionPackPath)
  --        end
  --
  --      else
  --        for n, vehicleType in ipairs(vehicles) do
  --          local packPath=GetPackPath(vehicleType)
  --          if packPath~=nil then
  --            InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
  --            AddMissionPack(packPath,missionPackPath)
  --          end
  --        end
  --      end
  --    end--if gvar
  --  end--for vehicle base types

  local packPath
  for vehicleType,spawnInfo in pairs(vehicleSpawnInfoTable) do
    --CULLif Ivars.vehiclePatrolPackType:Is"QUESTPACK" then
    --  packPath=spawnInfo.packPathAlt
    --else
    packPath=spawnInfo.packPath
    --end
    if packPath then
      AddMissionPack(packPath,missionPackPath)
    end
  end
end
--<vehicle stuff

--splash stuff>
this.oneOffSplashes={
  "startstart",
  "startend",
  "knm",
}
function this.AddOneOffSplash(splashName)
-- this.oneOffSplashes[#this.oneOffSplashes+1]=splashName
end
function this.DeleteOneOffSplashes()
  for n,splashName in pairs(this.oneOffSplashes) do
    this.DeleteSplash(splashName)
  end
  this.oneOffSplashes={}
end

function this.DeleteStartSplashes()
  this.DeleteSplash(this.currentRandomSplash)
  this.DeleteOneOffSplashes()
end


function this.DeleteSplash(splashName)
  if splashName~=nil then
    local splash=SplashScreen.GetSplashScreenWithName(splashName)
    if splash~=nil then
      SplashScreen.Delete(splash)
    end
  end
end

local emblemTypes={
  --{"base",{01,50}},--tex OFF mostly boring
  {"front",{01,85}},
  {"front",{5001,5027}},
  --{"front",{7008,7063}},--tex bunch missing (see DOC), boring emblems anyhoo
  {"front",{
    100,
    110,
    120,
    200,
    210,
    220,
    300,
    400,
    410,
    500,
    510,
    600,
    610,
    700,
    720,
    730,
    800,
    810,
    900,
    1000,
    1100,
    1200,
    1210,
    1220,
    1300,
    1310,
    1410,
    1420,
    1430,
    1500,
    1700,
    1710,
    1800,
    1900,
    1920,
    1940,
    1960,
    2000,
    2010,
    2100,
    2200,
    2210,
    2240,
    2241,
  }},
}

this.currentRandomSplash=nil
--IN: emblemTypes
--OUT: this.oneOffSplashes, this.currentRandomSplash, SplashScreen - a splashscreen
--ASSUMPTION: heavy on emblemTypes data layout assumptions, so if you change it, this do break
function this.CreateRandomEmblemSplash()
  --  if this.currentRandomSplash~=nil then
  --    if SplashScreen.GetSplashScreenWithName(this.currentRandomSplash) then
  --      return
  --    end
  --  end

  local groupNumber=math.random(#emblemTypes)
  local group=emblemTypes[groupNumber]
  local emblemType=group[1]
  local emblemRanges=group[2]
  local emblemNumber
  if #emblemRanges>2 then--tex collection of numbers rather than range
    local randomIndex=math.random(#emblemRanges)
    emblemNumber=emblemRanges[randomIndex]
  else
    emblemNumber=math.random(emblemRanges[1],emblemRanges[2])
  end

  local lowOrHi="h"--tex low is full opaque, i guess for being in background thus 'low' display order, hi is more detailed stencil
  --  if math.random()<0.5 then
  --    lowOrHi="l"
  --  else
  --    lowOrHi="h"
  --  end

  local name=emblemType..emblemNumber

  local path="/Assets/tpp/ui/texture/Emblem/"..emblemType.."/ui_emb_"..emblemType.."_"..emblemNumber.."_"..lowOrHi.."_alp.ftex"
  local randomSplash=SplashScreen.Create(name,path,640,640)

  this.currentRandomSplash=name
  --this.AddOneOffSplash(name)

  --SplashScreen.Show(randomSplash,.2,0.5,.2)
  return randomSplash
end

function this.SplashStateCallback_r(screenId, state)
  if mvars.startHasTitileSeqeunce then
    return
  end

  if state==SplashScreen.STATE_DELETE then
    local newSplash=this.CreateRandomEmblemSplash()
    SplashScreen.SetStateCallback(newSplash, this.SplashStateCallback_r)
    SplashScreen.Show( newSplash, .5, 3, .5)--.5,3,.5)-- 1.0, 4.0, 1.0)
  end
end
--<splash stuff

function this.OnAllocate(missionTable)
  if TppMission.IsFOBMission(vars.missionCode)then
    TppSoldier2.ReloadSoldier2ParameterTables(InfSoldierParams.soldierParameters)
  end


  --WIP >
--  local equipLoadTable={}
--  --tex TODO: find a better indicator of equipable mission loading
--  if missionTable.enemy then
--    for k,equipName in pairs(this.tppEquipTable)do
--      local equipId=TppEquip[equipName]
--      if equipId~=nil then
--        table.insert(equipLoadTable,equipId)
--      end
--    end
--
--    if TppEquip.RequestLoadToEquipMissionBlock then
--      TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)
--    end
--  end--<
end

this.prevDisableActionFlag=nil
function this.DisableActionFlagEquipMenu()
  if this.prevDisableActionFlag==nil then
    this.prevDisableActionFlag=vars.playerDisableActionFlag
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+PlayerDisableAction.OPEN_EQUIP_MENU
  end
end
function this.RestoreActionFlag()
  if this.prevDisableActionFlag~=nil then
    vars.playerDisableActionFlag=this.prevDisableActionFlag
    this.prevDisableActionFlag=nil
  end
end

--
local function UpdateRangeToMinMax(updateRate,updateRange)
  local min=updateRate-updateRange*0.5
  local max=updateRate+updateRange*0.5
  if min<0 then
    min=0
  end
  return min,max
end

function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Dead",func=this.OnDead},
      {msg="Damage",func=this.OnDamage},
      {msg="ChangePhase",func=this.OnPhaseChange},
      {msg="RequestLoadReinforce",func=this.OnRequestLoadReinforce},
      {msg="RequestAppearReinforce",func=this.OnRequestAppearReinforce},
      {msg="CancelReinforce",func=this.OnCancelReinforce},
      {msg="LostControl",func=this.OnHeliLostControlReinforce},--DOC: Helicopter shiz.txt
      {msg="VehicleBroken",func=this.OnVehicleBrokenReinforce},
      {msg="RequestedHeliTaxi",func=function(gameObjectId,currentLandingZoneName,nextLandingZoneName)
        --InfMenu.DebugPrint("RequestedHeliTaxi currentLZ:"..currentLandingZoneName.. " nextLZ:"..nextLandingZoneName)--DEBUG
        end},
    },
    Player={
      {msg="FinishOpeningDemoOnHeli",func=this.ClearMarkers()},--tex xray effect off doesn't stick if done on an endfadein, and cant seen any ofther diable between the points suggesting there's an in-engine set between those points of execution(unless I'm missing something) VERIFY
    },
    UI={
      {msg="EndFadeIn",sender="FadeInOnGameStart",func=function()--fires on: most mission starts, on-foot free and story missions, not mb on-foot, but does mb heli start
        --InfMenu.DebugPrint"FadeInOnGameStart"--DEBUG
        this.FadeInOnGameStart()
      end},
      --this.FadeInOnGameStart},
      {msg="EndFadeIn",sender="FadeInOnStartMissionGame",func=function()--fires on: returning to heli from mission
        --  TppUiStatusManager.ClearStatus"AnnounceLog"
        --InfMenu.ModWelcome()
        --InfMenu.DebugPrint"FadeInOnStartMissionGame"--DEBUG
        --this.FadeInOnGameStart()
        end},
      {msg="EndFadeIn",sender="OnEndGameStartFadeIn",func=function()--fires on: on-foot mother base, both initial and continue
        --InfMenu.DebugPrint"OnEndGameStartFadeIn"--DEBUG
        this.FadeInOnGameStart()
      end},
    --elseif(messageId=="Dead"or messageId=="VehicleBroken")or messageId=="LostControl"then
    },
    Timer={
      {msg="Finish",sender="Timer_FinishReinforce",func=this.OnTimer_FinishReinforce,nil},
    },
    Terminal={
      {msg="MbDvcActSelectLandPoint",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfMenu.DebugPrint("MbDvcActSelectLandPoint:"..tostring(routeName))--DEBUG
        end},
      {msg="MbDvcActSelectLandPointTaxi",func=function(nextMissionId,routeName,layoutCode,clusterId)
        --InfMenu.DebugPrint("MbDvcActSelectLandPointTaxi:"..tostring(routeName))--DEBUG
        end},
      {msg="MbDvcActHeliLandStartPos",func=function(set,x,y,z)
        --InfMenu.DebugPrint("HeliLandStartPos:"..x..","..y..","..z)--DEBUG
        end},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function this.OnDead(gameId,killerId,playerPhase,deadMessageFlag)
  --InfMenu.DebugPrint("InfMain.OnDead")
  --  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)--CULL not for heli I guess
  --  if heliId~=NULL_ID then
  --    if heliId==gameId then
  --    --InfMenu.DebugPrint("InfMain.OnDead is heli")
  --    end
  --  end

  if GetTypeIndex(gameId)~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then
    return
  end

  --local killerIsPlayer=(killerId==GameObject.GetGameObjectIdByIndex("TppPlayer2",PlayerInfo.GetLocalPlayerIndex()))
end


--TODO: VERIFY, add vehicle machineguns
local AttackIsVehicle=function(attackId)--RETAILBUG: seems like attackid must be a typo and f
  if(((((((((((((
    attackId==TppDamage.ATK_VehicleHit
    or attackId==TppDamage.ATK_Tankgun_20mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Tankgun_105mmRifledBoreGun)
    or attackId==TppDamage.ATK_Tankgun_120mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_125mmSmoothBoreGun)
    or attackId==TppDamage.ATK_Tankgun_82mmRocketPoweredProjectile)
    or attackId==TppDamage.ATK_Tankgun_30mmAutoCannon)
    or attackId==TppDamage.ATK_Wav1)
    or attackId==TppDamage.ATK_WavCannon)
    or attackId==TppDamage.ATK_TankCannon)
    or attackId==TppDamage.ATK_WavRocket)
    or attackId==TppDamage.ATK_HeliMiniGun)
    or attackId==TppDamage.ATK_HeliChainGun)
--or attackId==TppDamage.ATK_WalkerGear_BodyAttack
then
  return true
end
return false
end
function this.OnDamage(gameId,attackId,attackerId)
  --InfMenu.DebugPrint"OnDamage"--DEBUG
  local typeIndex=GameObject.GetTypeIndex(gameId)
  if typeIndex~=TppGameObject.GAME_OBJECT_TYPE_SOLDIER2 then--and typeIndex~=TppGameObject.GAME_OBJECT_TYPE_HELI2 then
    return
  end

  if Tpp.IsPlayer(attackerId) then
    --InfMenu.DebugPrint"OnDamage attacked by player"
    if Ivars.soldierAlertOnHeavyVehicleDamage:Is()>0 then
      if AttackIsVehicle(attackId) then
        --InfMenu.DebugPrint"OnDamage AttackIsVehicle"
        for cpId,soldierIds in pairs(mvars.ene_soldierIDList)do--tex TODO:find or build a better soldierid>cpid lookup
          if TppEnemy.GetPhaseByCPID(cpId)<Ivars.soldierAlertOnHeavyVehicleDamage:Is() then
            if soldierIds[gameId]~=nil then
              --InfMenu.DebugPrint"OnDamage found soldier in idlist"
              local command={id="SetPhase",phase=Ivars.soldierAlertOnHeavyVehicleDamage:Get()}
              SendCommand(cpId,command)
              break
            end
        end--if cp not phase
        end--for soldieridlist
      end--attackisvehicle
    end--gvar
  end--player is attacker
end

local function PhaseName(index)
  return Ivars.phaseSettings[index+1]
end
function this.OnPhaseChange(gameObjectId,phase,oldPhase)
  if Ivars.printPhaseChanges:Is(1) then
    --tex TODO: cpId>cpName
    InfMenu.Print("cpId:"..gameObjectId.." Phase change from:"..PhaseName(oldPhase).." to:"..PhaseName(phase))--InfMenu.LangString("phase_changed"..":"..PhaseName(phase)))--ADDLANG
  end
end

function this.FadeInOnGameStart()
  this.ClearMarkers()

  --tex player life values for difficulty. Difficult to track down the best place for this, player.changelifemax hangs anywhere but pretty much in game and ready to move, Anything before the ui ending fade in in fact, why.
  --which i don't like, my shitty code should be run in the shadows, not while player is getting viewable frames lol, this is at least just before that
  --RETRY: push back up again, you may just have fucked something up lol, the actual one use case is in sequence.OnEndMissionPrepareSequence which is the middle of tppmain.onallocate
  local healthScale=Ivars.playerHealthScale:Get()
  if healthScale~=1 then
    Player.ResetLifeMaxValue()
    local newMax=vars.playerLifeMax
    newMax=newMax*healthScale
    if newMax < 10 then
      newMax = 10
    end
    Player.ChangeLifeMaxValue(newMax)
  end

  --  if Ivars.disableQuietHumming:Is(1) then --tex no go
  --    this.SetQuietHumming(false)
  --  end

  --TppUiStatusManager.ClearStatus"AnnounceLog"
  --InfMenu.ModWelcome()
end

function this.ClearMarkers()
  if Ivars.disableHeadMarkers:Is(1) then
    TppUiStatusManager.SetStatus("HeadMarker","INVALID")
  end
  if Ivars.disableXrayMarkers:Is(1) then
    --TppSoldier2.DisableMarkerModelEffect()
    TppSoldier2.SetDisableMarkerModelEffect{enabled=true}
  end
end

--ivar update system

local updateIvars={
  Ivars.phaseUpdate,
  Ivars.warpPlayerUpdate,
  Ivars.heliUpdate,
}

function this.Init(missionTable)--tex called from TppMain.OnInitialize
  this.abortToAcc=false

  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  for i, ivar in ipairs(updateIvars) do
    if IsFunc(ivar.ExecInit) then
      ivar.ExecInit()
    end
  end

  this.UpdateHeliVars()
end

function this.OnReload(missionTable)
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end


this.execChecks={
  inGame=false,--tex actually loaded game, ie at least 'continued' from title screen
  inHeliSpace=false,
  inMission=false,
  initialAction=false,--tex mission actually started/reached ground, triggers on checkpoint save so might not be valid for some uses
  inGroundVehicle=false,
  inSupportHeli=false,
  onBuddy=false,--tex sexy
  inMenu=false,
}

local playerVehicleId=0
this.currentTime=0

this.abortToAcc=false--tex

function this.Update()
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end
  
  playerVehicleId=NULL_ID
  local currentChecks=this.execChecks
  --for k,v in ipairs(this.execChecks) do
  --this.execChecks[k]=false--tex TODO: can't figure out why this isn't actually setting REPRO: start misison, get into vehicle, get checkpoint, return to acc, still inGroundVehicle==true
  --end
  currentChecks.inHeliSpace=false
  currentChecks.inMission=false
  currentChecks.initialAction=false
  currentChecks.inGroundVehicle=false
  currentChecks.inSupportHeli=false
  currentChecks.onBuddy=false
  currentChecks.inBox=false
  currentChecks.inMenu=false

  currentChecks.inGame=not mvars.mis_missionStateIsNotInGame

  if currentChecks.inGame then
    currentChecks.inHeliSpace=TppMission.IsHelicopterSpace(vars.missionCode)
    currentChecks.inMission=currentChecks.inGame and not currentChecks.inHeliSpace
    playerVehicleId=vars.playerVehicleGameObjectId

    if not currentChecks.inHeliSpace then
      currentChecks.initialAction=svars.ply_isUsedPlayerInitialAction--VERIFY that start on ground catches this (it's triggered on checkpoint save DOESNT catch motherbase ground start
      --if not initialAction then
      --InfMenu.DebugPrint"not initialAction"
      --end
      currentChecks.inSupportHeli=Tpp.IsHelicopter(playerVehicleId)--tex VERIFY
      currentChecks.inGroundVehicle=Tpp.IsVehicle(playerVehicleId) and not currentChecks.inSupportHeli-- or Tpp.IsEnemyWalkerGear(playerVehicleId)?? VERIFY
      currentChecks.onBuddy=Tpp.IsHorse(playerVehicleId) or Tpp.IsPlayerWalkerGear(playerVehicleId)
      currentChecks.inBox=Player.IsVarsCurrentItemCBox()
    end
  else

    local abortButton=InfButton.ESCAPE
    InfButton.buttonStates[abortButton].holdTime=1.5
    if InfButton.OnButtonHoldTime(abortButton) then
      local splash=SplashScreen.Create("abortsplash","/Assets/tpp/ui/ModelAsset/sys_logo/Pictures/common_kjp_logo_clp_nmp.ftex",640,640)
      SplashScreen.Show(splash,0,0.3,0)
      this.abortToAcc=true
    end
    --if this.abortToAcc then
    --  this.abortToAcc=false
    --  TppMission.ExecuteMissionAbort()
    --end
  end

  this.currentTime=Time.GetRawElapsedTimeSinceStartUp()
  --if currentChecks.inGame then
  --InfMenu.DebugPrint(tostring(this.currentTime))
  --end

  InfButton.UpdateHeld()
  InfButton.UpdateRepeatReset()

  ---Update shiz
  InfMenu.Update(currentChecks)
  currentChecks.inMenu=InfMenu.menuOn

  for i, ivar in ipairs(updateIvars) do
    if ivar.setting==1 then
      --tex ivar.updateRate is either number or another ivar
      local updateRate=ivar.updateRate or 0
      local updateRange=ivar.updateRange or 0
      if IsTable(updateRate) then
        updateRate=updateRate.setting
      end
      if IsTable(updateRange) then
        updateRange=updateRange.setting
      end
      --

      this.ExecUpdate(currentChecks,this.currentTime,ivar.execChecks,ivar.execState,updateRate,updateRange,ivar.ExecUpdate)
    end
  end
  ---
  InfButton.UpdatePressed()--tex GOTCHA: should be after all key reads, sets current keys to prev keys for onbutton checks
end

function this.ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if execState.nextUpdate > currentTime then
    return
  end

  for check,ivarCheck in ipairs(execChecks) do
    if currentChecks[check]~=ivarCheck then
      return
    end
  end

  if not IsFunc(ExecUpdate) then
    InfMenu.DebugPrint"ExecUpdate is not a function"
    return
  end

  ExecUpdate(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)

  --tex set up next update time GOTCHA: wont reflect changes to rate and range till next update
  if updateRange then
    local updateMin=updateRate-updateRange*0.5
    local updateMax=updateRate+updateRange*0.5
    if updateMin<0 then
      updateMin=0
    end

    updateRate=math.random(updateMin,updateMax)
  end
  execState.nextUpdate=currentTime+updateRate

  --if currentChecks.inGame then
  -- InfMenu.DebugPrint("currentTime: "..tostring(currentTime).." updateRate:"..tostring(updateRate) .." nextUpdate:"..tostring(execState.nextUpdate))
  --end
end

--Phase/Alert updates DOC: Phases-Alerts.txt
--TODO RETRY, see if you can get when player comes into cp range better, playerPhase doesnt change till then
--RESEARCH music also starts up
--then can shift to game msg="ChangePhase" subscription
--state
local PHASE_ALERT=TppGameObject.PHASE_ALERT

function this.UpdatePhase(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if TppLocation.IsMotherBase() or TppLocation.IsMBQF() then
    return
  end

  local currentPhase=vars.playerPhase
  local minPhase=Ivars.minPhase:Get()
  local maxPhase=Ivars.maxPhase:Get()

  for cpName,soldierList in pairs(mvars.ene_soldierDefine)do
    if currentPhase<minPhase then
      this.ChangePhase(cpName,minPhase)--gvars.minPhase)
    end
    if currentPhase>maxPhase then
      InfMain.ChangePhase(cpName,maxPhase)
    end

    if gvars.keepPhase==1 then
      InfMain.SetKeepAlert(cpName,true)
    else
    --InfMain.SetKeepAlert(cpName,false)--tex this would trash any vanilla setting, but updating this to off would only be important if ivar was updated at mission time
    end

    --tex keep forcing ALERT so that last know pos updates, otherwise it would take till the alert>evasion cooldown
    --doesnt really work well, > alert is set last know pos, take cover and suppress last know pos
    --evasion is - is no last pos, downgrade to caution, else group advance on last know pos
    --ideally would be able to set last know pos independant of phase
    --if minPhase==PHASE_ALERT then
    --debugMessage="phase<min setting to "..PhaseName(gvars.minPhase)
    --if currentPhase==PHASE_ALERT and execState.lastPhase==PHASE_ALERT then
    --this.ChangePhase(cpName,minPhase-1)--gvars.minPhase)
    --end
    --end
    if minPhase==TppGameObject.PHASE_EVASION then
      if execState.alertBump then
        execState.alertBump=false
        InfMain.ChangePhase(cpName,TppGameObject.PHASE_EVASION)
      end
    end
    if currentPhase<minPhase then
      if minPhase==TppGameObject.PHASE_EVASION then
        InfMain.ChangePhase(cpName,PHASE_ALERT)
        execState.alertBump=true
      end
    end
  end

  execState.lastPhase=currentPhase
end

--warp mode
--config
this.moveRightButton=InfButton.RIGHT
this.moveLeftButton=InfButton.LEFT
this.moveForwardButton=InfButton.UP
this.moveBackButton=InfButton.DOWN
this.moveUpButton=InfButton.STANCE
this.moveDownButton=InfButton.CALL

this.warpModeButtons={
  this.moveRightButton,
  this.moveLeftButton,
  this.moveForwardButton,
  this.moveBackButton,
  this.moveUpButton,
  this.moveDownButton,
}

--init
function this.InitWarpPlayerUpdate()
  InfButton.buttonStates[this.moveRightButton].decrement=0.1
  InfButton.buttonStates[this.moveLeftButton].decrement=0.1
  InfButton.buttonStates[this.moveForwardButton].decrement=0.1
  InfButton.buttonStates[this.moveBackButton].decrement=0.1
  InfButton.buttonStates[this.moveUpButton].decrement=0.1
  InfButton.buttonStates[this.moveDownButton].decrement=0.1
end

function this.UpdateWarpPlayer(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if currentChecks.inMenu then
    return
  end

  if not currentChecks.inGame or currentChecks.inHeliSpace then
    if Ivars.warpPlayerUpdate.setting==1 then
      Ivars.warpPlayerUpdate:Set(0)
    end
    return
  end

  if Ivars.warpPlayerUpdate.setting==0 then
    return
  end

  --TODO: refactor, in InfMenu.Update too
  local repeatRate=0.06
  local repeatRateUp=0.04
  InfButton.buttonStates[this.moveRightButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveForwardButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveBackButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveUpButton].repeatRate=repeatRateUp
  InfButton.buttonStates[this.moveDownButton].repeatRate=repeatRate

  local warpAmount=1
  local warpUpAmount=1

  local moveDir={}
  moveDir[1]=0
  moveDir[2]=0
  moveDir[3]=0

  local didMove=false

  if InfButton.OnButtonDown(this.moveForwardButton)
    or InfButton.OnButtonRepeat(this.moveForwardButton) then
    moveDir[3]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveBackButton)
    or InfButton.OnButtonRepeat(this.moveBackButton) then
    moveDir[3]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveRightButton)
    or InfButton.OnButtonRepeat(this.moveRightButton) then
    moveDir[1]=-warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveLeftButton)
    or InfButton.OnButtonRepeat(this.moveLeftButton) then
    moveDir[1]=warpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveUpButton)
    or InfButton.OnButtonRepeat(this.moveUpButton) then
    moveDir[2]=warpUpAmount
    didMove=true
  end

  if InfButton.OnButtonDown(this.moveDownButton)
    or InfButton.OnButtonRepeat(this.moveDownButton) then
    moveDir[2]=-warpAmount
    didMove=true
  end

  if didMove then
    local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
    local vMoveDir=Vector3(moveDir[1],moveDir[2],moveDir[3])
    local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerRotY))
    local playerMoveDir=rotYQuat:Rotate(vMoveDir)
    local warpPos=currentPos+playerMoveDir
    TppPlayer.Warp{pos={warpPos:GetX(),warpPos:GetY(),warpPos:GetZ()},rotY=vars.playerCameraRotation[1]}
  end
end

--heli, called from TppMain.Onitiialize, so should only be 'enable/change from default', VERIFY it's in the right spot to override each setting
function this.UpdateHeliVars()
  if TppMission.IsFOBMission(vars.missionCode) then
    return
  end

  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  if Ivars.disableHeliAttack:Is(1) then--tex disable heli be fightan
    SendCommand(heliId,{id="SetCombatEnabled",enabled=false})
  end
  if Ivars.setInvincibleHeli:Is(1) then
    SendCommand(heliId,{id="SetInvincible",enabled=true})
  end
  if not Ivars.setTakeOffWaitTime:IsDefault() then
    SendCommand(heliId,{id="SetTakeOffWaitTime",time=Ivars.setTakeOffWaitTime:Get()})
  end
  if Ivars.disablePullOutHeli:Is(1) then
    --if not TppLocation.IsMotherBase() and not TppLocation.IsMBQF() then--tex aparently disablepullout overrides the mother base taxi service TODO: not sure if I want to turn this off to save user confusion, or keep consistant behaviour
    SendCommand(heliId,{id="DisablePullOut"})
    --end
  end
  if not Ivars.setLandingZoneWaitHeightTop:IsDefault() then
    SendCommand(heliId,{id="SetLandingZoneWaitHeightTop",height=Ivars.setLandingZoneWaitHeightTop:Get()})
  end
  if Ivars.disableDescentToLandingZone:Is(1) then
    SendCommand(heliId,{id="DisableDescentToLandingZone"})
  end
  if Ivars.setSearchLightForcedHeli:Is(1) then
    SendCommand(heliId,{id="SetSearchLightForcedType",type="Off"})
  end

  --if TppMission.IsMbFreeMissions(vars.missionCode) then--TEST no aparent result on initial testing, in-engine pullout check must be overriding
  --  TppUiStatusManager.UnsetStatus( "MbMap", "BLOCK_TAXI_CHANGE_LOCATION" )
  --end
end

function this.UpdateHeli(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  local heliId=GetGameObjectId("TppHeli2","SupportHeli")
  if heliId==nil or heliId==NULL_ID then
    return
  end

  --if Ivars.enableGetOutHeli:Is(1) then--TEST not that useful
  -- SendCommand(heliId, { id="SetGettingOutEnabled", enabled=true })
  --end

  if not currentChecks.inMenu and currentChecks.inSupportHeli then
    if Ivars.disablePullOutHeli:Is(1) then--or not currentChecks.initialAction then
      if InfButton.OnButtonDown(InfButton.STANCE) then
        --if not currentChecks.initialAction then--tex heli ride in TODO: RETRY: A reliable mission start parameter
        if IsTimerActive"Timer_MissionStartHeliDoorOpen" then
          SendCommand(heliId,{id="RequestSnedDoorOpen"})
        else
          if Ivars.disablePullOutHeli:Is(1) then
            --CULL SendCommand(heliId,{id="PullOut",forced=true})--tex even with forced wont go with player in heli
            Ivars.disablePullOutHeli:Set(0,true,true)--tex overrules all, but we can tell it to not save so that's ok
            InfMenu.PrintLangId"heli_pulling_out"
          else
            Ivars.disablePullOutHeli:Set(1,true,true)
            InfMenu.PrintLangId"heli_hold_pulling_out"
          end
        end
    end--button down
    end--nopullout or initialact
  end--not menu, insupportheli
end

function this.HeliOrderRecieved()
  if this.execChecks.inGame and not this.execChecks.inHeliSpace then
    InfMenu.PrintLangId"order_recieved"
  end
end

--reinforce stuff
this.reinforceInfo={
  cpId=nil,
  request=0,
  count=0,
}

function this.OnRequestLoadReinforce(cpId)
  --InfMenu.DebugPrint"_OnRequestLoadReinforce"--DEBUG
  if this.reinforceInfo.cpId~=cpId then
    this.reinforceInfo.cpId=cpId
    this.reinforceInfo.count=0
    this.reinforceInfo.request=0
  end
  this.reinforceInfo.request=this.reinforceInfo.request+1
end
function this.OnRequestAppearReinforce(cpId)
  --InfMenu.DebugPrint"_OnRequestAppearReinforce"--DEBUG
  this.reinforceInfo.count=this.reinforceInfo.count+1
end
function this.OnCancelReinforce(cpId)
--InfMenu.DebugPrint"_OnCancelReinforce"--DEBUG
end

function this.OnHeliLostControlReinforce(gameId,state,attackerId)--DOC: Helicopter shiz.txt
  --InfMenu.DebugPrint"OnHeliLostControlReinforce"
  local gameObjectType=GameObject.GetTypeIndex(gameId)
  if gameObjectType~=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI then
    return
  end

  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
  if heliId~=gameId then
    return
  end

  if not mvars.reinforce_activated then
    --InfMenu.DebugPrint"OnHeliLostControlReinforce is reinforce heli but not reinforce_activated"
    return
  end

  if (state==StrCode32("Start")) then
  elseif (state==StrCode32("End")) then
    --InfMenu.DebugPrint"OnHeliLostControlReinforce is reinforce heli"
    --this.CheckAndFinishReinforce()

    if TppReinforceBlock._HasHeli() then--tex reinforcetype is heli
      --InfMenu.DebugPrint"start timer FinishReinforce"
      local cpId=mvars.reinforce_reinforceCpId
      --TppReinforceBlock.FinishReinforce(cpId)
      local StartTimer=GkEventTimerManager.Start
      StartTimer("Timer_FinishReinforce",2)--tex heli doesn't like it if reinforceblock is deactivated, even though I can't see it acually deactivating heli in finish.
    end
  end
end

function this.OnVehicleBrokenReinforce(vehicleId,state)--ASSUMPTION: Run after TppEnemy._OnVehicleBroken
  --InfMenu.DebugPrint"OnVehicleBroken"
  --local gameObjectType=GameObject.GetTypeIndex(vehicleId)
  local reinforceId=GetGameObjectId(TppReinforceBlock.REINFORCE_VEHICLE_NAME)
  if reinforceId~=vehicleId then
    return
  end

  if not mvars.reinforce_activated then
    --InfMenu.DebugPrint"OnVehicleBrokenReinforce is reinforce vehicle but not reinforce_activated"
    return
  end

  if (state==StrCode32("Start")) then
  elseif (state==StrCode32("End")) then
    --InfMenu.DebugPrint"OnVehicleBrokenReinforce is reinforce vehicle"
    --this.CheckAndFinishReinforce()
    if TppReinforceBlock._HasVehicle() then--tex reinforcetype is heli
      --InfMenu.DebugPrint"Do timer FinishReinforce"
      local cpId=mvars.reinforce_reinforceCpId
      --TppReinforceBlock.FinishReinforce(cpId)
      local StartTimer=GkEventTimerManager.Start
      StartTimer("Timer_FinishReinforce",2)--tex heli doesn't like it if reinforceblock is deactivated, even though I can't see it acually deactivating heli in finish.
    end
  end
end

function this.OnTimer_FinishReinforce()
  --InfMenu.DebugPrint"Do FinishReinforce"
  local cpId=mvars.reinforce_reinforceCpId
  TppReinforceBlock.FinishReinforce(cpId)
  TppReinforceBlock.UnloadReinforceBlock(cpId)
end

function this.CheckAndFinishReinforce()--WIP/UNUSED
  if not mvars.reinforce_activated then
    return false
end
if this.CheckReinforceDeactivate() then
  --InfMenu.DebugPrint"Do FinishReinforce"
  local cpId=mvars.reinforce_reinforceCpId
  TppReinforceBlock.FinishReinforce(cpId)
end
end
function this.CheckReinforceDeactivate()--WIP/UNUSED
  --if not mvars.reinforce_activated then
  --   return false
  -- end
  --mvars.reinforce_reinforceType
  local hasVehicle=TppReinforceBlock._HasVehicle()
  local hasSoldier=TppReinforceBlock._HasSoldier()
  local hasHeli=TppReinforceBlock._HasHeli()
  --local cp=mvars.ene_cpList[mvars.reinforce_reinforceCpId]
  local soldiersDead=false
  local vehicleBroken=false
  local heliBroken=false
  local vehicleAlive
  local vehicleReal
  local heliAlive
  local heliReal

  InfMenu.DebugPrint("hasVehicle: "..tostring(hasVehicle).." hasHeli: "..tostring(hasHeli).." hasSoldier: "..tostring(hasSoldier))

  local deadCount=0
  for n,soldierName in ipairs(TppReinforceBlock.REINFORCE_SOLDIER_NAMES)do
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    if soldierId~=nil and soldierId~=NULL_ID then
      local NPC_STATE_DISABLE=TppGameObject.NPC_STATE_DISABLE
      local lifeStatus=SendCommand(soldierId,{id="GetLifeStatus"})
      local status=SendCommand(soldierId,{id="GetStatus"})
      if(status~=NPC_STATE_DISABLE)and(lifeStatus~=TppGameObject.NPC_LIFE_STATE_DEAD)then
        deadCount=deadCount+1
      end
    end
  end
  if deadCount==#TppReinforceBlock.REINFORCE_SOLDIER_NAMES then
    soldiersDead=true
  end

  InfMenu.DebugPrint("soldiersEliminated:"..tostring(soldiersDead))

  local vehicleId=GetGameObjectId("TppVehicle2",TppReinforceBlock.REINFORCE_VEHICLE_NAME)
  local driverId=GetGameObjectId("TppSoldier2",TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME)

  if vehicleId~=NULL_ID then
    --    if TppEnemy.IsVehicleBroken(vehicleId)then--tex only initied for quest eliminate targets
    --      vehicleEliminated=true
    --    end--
    --      if TppEnemy.IsRecovered(vehicleId)then
    --      vehicleEliminated=true
    --    end
    vehicleBroken=SendCommand(heliId,{id="IsBroken"})

    vehicleAlive=SendCommand(vehicleId,{id="IsAlive"})
    vehicleReal=SendCommand(vehicleId,{id="IsReal"})
    InfMenu.DebugPrint("vehicleBroken:"..tostring(vehicleBroken).." vehicleAlive:"..tostring(vehicleAlive))--.." vehicleReal:"..tostring(vehicleReal))
  end


  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
  if heliId~=NULL_ID then
    heliBroken=SendCommand(heliId,{id="IsBroken"})
    heliAlive=SendCommand(heliId,{id="IsAlive"})
    --heliReal=SendCommand(heliId,{id="IsReal"})
    InfMenu.DebugPrint("heliBroken:"..tostring(heliBroken).." heliAlive:"..tostring(heliAlive))--.." heliReal:"..tostring(heliReal))

    --    local aiState = SendCommand(heliId,{id="GetAiState"})--tex CULL only support heli aparently, returns strcode32 ""
    --    --InfMenu.DebugPrint("heliAiState:"..tostring(aiState))
    --    if aiState==StrCode32("WaitPoint") then
    --      InfMenu.DebugPrint("heliAiState: WaitPoint")
    --    elseif aiState==StrCode32("Descent") then
    --      InfMenu.DebugPrint("heliAiState: Descent")
    --    elseif aiState==StrCode32("Landing") then
    --      InfMenu.DebugPrint("heliAiState: Landing")
    --    elseif aiState==StrCode32("PullOut") then
    --      InfMenu.DebugPrint("heliAiState: PullOut")
    --    elseif aiState==StrCode32("") then
    --    InfMenu.DebugPrint("heliAiState: errr")
    --    else
    --      InfMenu.DebugPrint("heliAiState: unknown")
    --    end

  end

  if hasHeli and heliBroken then
    return true
  end
end

--WIP
this.tppEquipTable={--SYNC: EquipIdTable
  --    "EQP_SLD_SV",
  --    "EQP_SLD_PF_00",
  --    "EQP_SLD_PF_01",
  --    "EQP_SLD_PF_02",
  --    "EQP_SLD_DD",
  --    "EQP_SLD_DD_G02",
  --    "EQP_SLD_DD_G03",
  --    "EQP_SLD_DD_01",

  --not equipable, hang on equip
  --  "EQP_AM_10001",
  --  "EQP_AM_10003",
  --  "EQP_AM_10015",
  --  "EQP_AM_10101",
  --  "EQP_AM_10103",
  --  "EQP_AM_10125",
  --  "EQP_AM_10134",
  --  "EQP_AM_10201",
  --  "EQP_AM_10203",
  --  "EQP_AM_10214",
  --  "EQP_AM_10302",
  --  "EQP_AM_10303",
  --  "EQP_AM_10305",
  --  "EQP_AM_10403",
  --  "EQP_AM_10404",
  --  "EQP_AM_10405",
  --  "EQP_AM_10407",
  --  "EQP_AM_10503",
  --  "EQP_AM_10515",
  --  "EQP_AM_10526",
  --  "EQP_AM_20002",
  --  "EQP_AM_20003",
  --  "EQP_AM_20005",
  --  "EQP_AM_20103",
  --  "EQP_AM_20104",
  --  "EQP_AM_20105",
  --  "EQP_AM_20106",
  --  "EQP_AM_20116",
  --  "EQP_AM_20203",
  --  "EQP_AM_20206",
  --  "EQP_AM_20302",
  --  "EQP_AM_20303",
  --  "EQP_AM_20304",
  --  "EQP_AM_20305",
  --  "EQP_AM_30001",
  --  "EQP_AM_30003",
  --  "EQP_AM_30014",
  --  "EQP_AM_30034",
  --  "EQP_AM_30043",
  --  "EQP_AM_30047",
  --  "EQP_AM_30054",
  --  "EQP_AM_30055",
  --  "EQP_AM_30102",
  --  "EQP_AM_30103",
  --  "EQP_AM_30123",
  --  "EQP_AM_30125",
  --  "EQP_AM_30201",
  --  "EQP_AM_30203",
  --  "EQP_AM_30223",
  --  "EQP_AM_30225",
  --  "EQP_AM_30232",
  --  "EQP_AM_30303",
  --  "EQP_AM_30305",
  --  "EQP_AM_30306",
  --  "EQP_AM_30325",
  --  "EQP_AM_40001",
  --  "EQP_AM_40004",
  --  "EQP_AM_40012",
  --  "EQP_AM_40015",
  --  "EQP_AM_40023",
  --  "EQP_AM_40102",
  --  "EQP_AM_40105",
  --  "EQP_AM_40115",
  --  "EQP_AM_40123",
  --  "EQP_AM_40126",
  --  "EQP_AM_40133",
  --  "EQP_AM_40135",
  --  "EQP_AM_40136",
  --  "EQP_AM_40143",
  --  "EQP_AM_40203",
  --  "EQP_AM_40204",
  --  "EQP_AM_40206",
  --  "EQP_AM_40304",
  --  "EQP_AM_50102",
  --  "EQP_AM_50115",
  --  "EQP_AM_50126",
  --  "EQP_AM_50147",
  --  "EQP_AM_50136",
  --  "EQP_AM_50202",
  --  "EQP_AM_50215",
  --  "EQP_AM_50226",
  --  "EQP_AM_50237",
  --  "EQP_AM_50303",
  --  "EQP_AM_50304",
  --  "EQP_AM_50306",
  --  "EQP_AM_60001",
  --  "EQP_AM_60007",
  --  "EQP_AM_60013",
  --  "EQP_AM_60102",
  --  "EQP_AM_60107",
  --  "EQP_AM_60114",
  --  "EQP_AM_60203",
  --  "EQP_AM_60303",
  --  "EQP_AM_60315",
  --  "EQP_AM_60325",
  --  "EQP_AM_60404",
  --  "EQP_AM_60406",
  --  "EQP_AM_60415",
  --  "EQP_AM_60417",
  --  "EQP_AM_70002",
  --  "EQP_AM_70003",
  --  "EQP_AM_70005",
  --  "EQP_AM_70103",
  --  "EQP_AM_70104",
  --  "EQP_AM_70105",
  --  "EQP_AM_70114",
  --  "EQP_AM_70115",
  --  "EQP_AM_70116",
  --  "EQP_AM_70203",
  --  "EQP_AM_70204",
  --  "EQP_AM_70205",
  --  "EQP_AM_Quiet_sr_010",
  --  "EQP_AM_Quiet_sr_020",
  --  "EQP_AM_Quiet_sr_030",
  --  "EQP_AM_Pr_sm_010",
  --  "EQP_AM_Pr_ar_010",
  --  "EQP_AM_Pr_sg_010",
  --  "EQP_AM_Pr_sr_010",
  --  "EQP_AM_SkullFace_hg_010",
  --  "EQP_AM_SP_hg_010",
  --  "EQP_AM_SP_hg_020",
  --  "EQP_AM_SP_sm_010",
  --  "EQP_AM_SP_sg_010",
  --  "EQP_AM_EX_hg_000",
  --  "EQP_AM_EX_gl_000",
  --  "EQP_BL_EX_gl_000",
  --  "EQP_AM_EX_sr_000",
  --  "EQP_BL_HgGrenade",
  --  "EQP_BL_HgSmoke",
  --  "EQP_BL_HgSleep",
  --  "EQP_BL_HgStun",
  --  "EQP_BL_40mmGrenade",
  --  "EQP_BL_40mmSmoke",
  --  "EQP_BL_40mmSleep",
  --  "EQP_BL_40mmStun",
  --  "EQP_BL_20mmGrenade",
  --  "EQP_BL_20mmRocket",
  --  "EQP_BL_20mmSmoke",
  --  "EQP_BL_20mmSleep",
  --  "EQP_BL_20mmStun",
  --  "EQP_BL_ms00",
  --  "EQP_BL_ms00_G2",
  --  "EQP_BL_ms00_G3",
  --  "EQP_BL_ms02",
  --  "EQP_BL_ms02_G2",
  --  "EQP_BL_ms02_G3",
  --  "EQP_BL_ms02Sleep",
  --  "EQP_BL_ms02F",
  --  "EQP_BL_ms02F_G2",
  --  "EQP_BL_ms02F_G3",
  --  "EQP_BL_ms03",
  --  "EQP_BL_ms03_G2",
  --  "EQP_BL_ms03_G3",
  --  "EQP_BL_ms03_G4",
  --  "EQP_BL_ms01",
  --  "EQP_BL_ms01_G2",
  --  "EQP_BL_ms01_G3",
  --  "EQP_BL_ms01_G4",
  --  "EQP_BL_ms01_Child",
  --  "EQP_BL_ms01_G2_Child",
  --  "EQP_BL_ms01_G3_Child",
  --  "EQP_BL_ms01_G4_Child",
  --  "EQP_BL_RocketPunchStun",
  --  "EQP_BL_RocketPunchBlast",
  --  "EQP_BL_uth0_ammo0",
  --  "EQP_BL_uth0_ammo1",
  --  "EQP_BL_mgm0_ammo0",
  --  "EQP_BL_mgm0_cmn_ammo0",
  --  "EQP_BL_mgm0_cmn_ammo1",
  --  "EQP_BL_mgm0_famo0",
  --  "EQP_BL_mgs0_miss1",
  --  "EQP_BL_mgs0_miss0",
  --  "EQP_BL_mgs0_srcm0",
  --  "EQP_BL_mgs0_grnd0",
  --  "EQP_BL_Mortar",
  --  "EQP_BL_Flare",
  --  "EQP_BL_Cannon",
  --  "EQP_BL_WavCannon",
  --  "EQP_BL_WavCannonHoming",
  --  "EQP_BL_TankCannon",
  --  "EQP_BL_TankCannonHoming",
  --  "EQP_BL_WavRocket",
  --  "EQP_BL_Tankgun_105mmRifledBoreGun",
  --  "EQP_BL_Tankgun_120mmSmoothBoreGun",
  --  "EQP_BL_Tankgun_125mmSmoothBoreGun",
  --  "EQP_BL_Tankgun_105mmRifledBoreGun_Homing",
  --  "EQP_BL_Tankgun_120mmSmoothBoreGun_Homing",
  --  "EQP_BL_Tankgun_125mmSmoothBoreGun_Homing",
  --  "EQP_BL_Tankgun_82mmRocketPoweredProjectile",
  --  "EQP_BL_Tankgun_MultipleRocketLauncher",
  --  "EQP_BL_SupplyBomb",
  --  "EQP_BL_SupplySmoke",
  --  "EQP_BL_SupplySleep",
  --  "EQP_BL_SupplyChaff",
  --  "EQP_BL_UavGrenade",
  --  "EQP_BL_UavSmokeGrenade",
  --  "EQP_BL_UavSleepGasGrenade",

  --support weapons
  --    "EQP_SWP_Magazine",
  --    "EQP_SWP_Kibidango",--animal bait
  --    "EQP_SWP_Kibidango_G01",
  --    "EQP_SWP_Kibidango_G02",
  --    "EQP_SWP_Grenade",
  --    "EQP_SWP_Grenade_G01",
  --    "EQP_SWP_Grenade_G02",
  --    "EQP_SWP_Grenade_G03",
  --    "EQP_SWP_Grenade_G04",
  --    "EQP_SWP_Grenade_G05",
  --    "EQP_SWP_SmokeGrenade",
  --    "EQP_SWP_SmokeGrenade_G01",
  --    "EQP_SWP_SmokeGrenade_G02",
  --    "EQP_SWP_SmokeGrenade_G03",
  --    "EQP_SWP_SmokeGrenade_G04",
  --    "EQP_SWP_SupportHeliFlareGrenade",
  --    "EQP_SWP_SupportHeliFlareGrenade_G01",
  --    "EQP_SWP_SupportHeliFlareGrenade_G02",
  --    "EQP_SWP_SupplyFlareGrenade",
  --    "EQP_SWP_SupplyFlareGrenade_G01",
  --    "EQP_SWP_SupplyFlareGrenade_G02",
  --    "EQP_SWP_StunGrenade",
  --    "EQP_SWP_StunGrenade_G01",
  --    "EQP_SWP_StunGrenade_G02",
  --    "EQP_SWP_StunGrenade_G03",
  --    "EQP_SWP_SleepingGusGrenade",
  --    "EQP_SWP_SleepingGusGrenade_G01",
  --    "EQP_SWP_SleepingGusGrenade_G02",
  --    "EQP_SWP_MolotovCocktail",
  --    "EQP_SWP_MolotovCocktail_G01",
  --    "EQP_SWP_MolotovCocktail_G02",
  --    "EQP_SWP_MolotovCocktailPlaced",--tex just a clone, no point using
  --  "EQP_SWP_C4",
  --  "EQP_SWP_C4_G01",
  --  "EQP_SWP_C4_G02",
  --  "EQP_SWP_C4_G03",
  --  "EQP_SWP_C4_G04",
  --  "EQP_SWP_Decoy",
  --  "EQP_SWP_Decoy_G01",
  --  "EQP_SWP_Decoy_G02",
  --  "EQP_SWP_ActiveDecoy",
  --  "EQP_SWP_ActiveDecoy_G01",
  --  "EQP_SWP_ActiveDecoy_G02",
  --  "EQP_SWP_ShockDecoy",
  --  "EQP_SWP_ShockDecoy_G01",
  --  "EQP_SWP_ShockDecoy_G02",
  --  "EQP_SWP_CaptureCage",
  --  "EQP_SWP_CaptureCage_G01",
  --  "EQP_SWP_CaptureCage_G02",
  --  "EQP_SWP_DMine",
  --  "EQP_SWP_DMine_G01",
  --  "EQP_SWP_DMine_G02",
  --  "EQP_SWP_DMine_G03",
  --  "EQP_SWP_DMineLocator",
  --  "EQP_SWP_SleepingGusMine",
  --  "EQP_SWP_SleepingGusMine_G01",
  --  "EQP_SWP_SleepingGusMine_G02",
  --  "EQP_SWP_SleepingGusMineLocator",
  --  "EQP_SWP_AntitankMine",
  --  "EQP_SWP_AntitankMine_G01",
  --  "EQP_SWP_AntitankMine_G02",
  --  "EQP_SWP_ElectromagneticNetMine",
  --  "EQP_SWP_ElectromagneticNetMine_G01",
  --  "EQP_SWP_ElectromagneticNetMine_G02",
  --  "EQP_SWP_WormholePortal",
  --  "EQP_SWP_Dung",

  --tex no go
  --    "EQP_AB_PrimaryCommon",
  --    "EQP_AB_PrimaryTranq",
  --    "EQP_AB_PrimaryMissile",
  --    "EQP_AB_PrimaryMissileTranq",
  --    "EQP_AB_SecondaryCommon",
  --    "EQP_AB_SecondaryTranq",
  --    "EQP_AB_Support",
  --    "EQP_AB_Suppressor",
  --    "EQP_AB_Item",
  --    "EQP_AB_Mecha",
  --    "EQP_BX_Primary",
  --    "EQP_BX_Secondary",
  --    "EQP_BX_Support",

  --hands
  --    "EQP_HAND_STUNARM",
  --    "EQP_HAND_JEHUTY",
  --    "EQP_HAND_STUN_ROCKET",
  --    "EQP_HAND_KILL_ROCKET",
  --    "EQP_HAND_NORMAL",
  --    "EQP_HAND_GOLD",
  --    "EQP_HAND_SILVER",

  --items
  --  "EQP_IT_Fulton",
  --  "EQP_IT_Fulton_Cargo",
  --  "EQP_IT_Fulton_Child",
  --  "EQP_IT_Fulton_WormHole",
  --  "EQP_IT_Binocle",

  --    "EQP_IT_CBox_DSR",
  --    "EQP_IT_CBox_DSR_G01",
  --    "EQP_IT_CBox_DSR_G02",
  --    "EQP_IT_CBox_WR",
  --    "EQP_IT_CBox_SMK",
  --    "EQP_IT_CBox_FRST",
  --    "EQP_IT_CBox_FRST_G01",
  --    "EQP_IT_CBox_BOLE",
  --    "EQP_IT_CBox_BOLE_G01",
  --    "EQP_IT_CBox_CITY",
  --    "EQP_IT_CBox_CITY_G01",

  --tex no go
  --    "EQP_IT_CBox_CLB_A",o
  --    "EQP_IT_CBox_CLB_A_G01",
  --    "EQP_IT_CBox_CLB_B",
  --    "EQP_IT_CBox_CLB_B_G01",
  --    "EQP_IT_CBox_CLB_C",
  --    "EQP_IT_CBox_CLB_C_G01",
  -- tex some kind of dlc box, defaults to regular texture though
  --    "EQP_IT_CBox_LIMITED",
  --    "EQP_IT_CBox_LIMITED_G01",
  --  "EQP_IT_InstantStealth",
  --  "EQP_IT_Pentazemin",
  --  "EQP_IT_Clairvoyance",
  --  "EQP_IT_ReflexMedicine",
  --
  --tex needs paracites/armor I guess?
  --    "EQP_IT_ParasiteMist",
  --    "EQP_IT_ParasiteCamouf",
  --    "EQP_IT_ParasiteHard",

  --  "EQP_IT_TimeCigarette",
  --  "EQP_IT_Stealth",
  --  "EQP_IT_Nvg",

  --tex likely requires the specific mission assets
  --    "EQP_IT_Infected",

  --tex no go
  --    "EQP_IT_IDroid",
  --    "EQP_IT_CureSpray",
  --    "EQP_IT_PickingToolR",
  --    "EQP_IT_PickingToolL",
  --    "EQP_IT_HandyLight",
  --    "EQP_IT_Knife",
  --    "EQP_IT_SKnife",
  --    "EQP_IT_Cigarette",
  --    "EQP_IT_CigaretteCase",
  --    "EQP_IT_Radio",
  --    "EQP_IT_SRadio",
  --    "EQP_IT_BayonetWest",
  --    "EQP_IT_Telescope",
  --    "EQP_IT_Cassette",
  --    "EQP_IT_FilmCase",
  --    "EQP_IT_DevelopmentFile",
  --    "EQP_IT_GasMask",--tex likely handled through attachgasmask/requires asset fpk
  --    "EQP_IT_KnifePF",
  --    "EQP_IT_ShotShell",
  --    "EQP_IT_Machete",
  --    "EQP_IT_MacheteLiquid",
  --    "EQP_IT_KnifeLiquid",
  --    "EQP_IT_PipeLiquid",
  --    "EQP_IT_BottleLiquid",
  --    "EQP_IT_ShellLiquid",
  --    "EQP_IT_mgs0_msbl0",
  --    "EQP_IT_DDogStunLod",
  --TODO see if grades match currently developed
  --TODO probably better to just figure out their langid
  --handguns
  --    "EQP_WP_West_hg_010",--AM D114 grade 1
  --    "EQP_WP_West_hg_010_WG",--no name/icon/drop model
  --    "EQP_WP_West_hg_020",--AM D114 with silencer(on icon) but no ext mag?  grade 4
  --    "EQP_WP_West_hg_030",--geist p3 - shows shotgun icon but clearly isnt, machine pistol grade 4
  --    "EQP_WP_West_hg_030_cmn",--as above, no name/icon
  --    "EQP_WP_East_hg_010",--burkov grade 1
  --tranq
  --    "EQP_WP_West_thg_010",--wu s.pistol grade 1
  --    "EQP_WP_West_thg_020",--grade 2
  --    "EQP_WP_West_thg_030",--wu s pistol inf supressor grade 5
  --    "EQP_WP_West_thg_040",--grade 5
  --    "EQP_WP_West_thg_050",--wu s pistol cb grade7
  --smgs
  --    "EQP_WP_West_sm_010",--ze'ev cs grade 3
  --    "EQP_WP_West_sm_010_WG",--as above, no icon/name
  --    "EQP_WP_West_sm_014",--zeeve model, big scope no icon/name, supressor
  --    "EQP_WP_West_sm_015",--as above
  --    "EQP_WP_West_sm_020",--macht 37 grade 3
  --    "EQP_WP_East_sm_010",--sz 336 grade 3
  --    "EQP_WP_East_sm_020",--sz 336 cs grade 5
  --    "EQP_WP_East_sm_030",--sz 336 cs grade 3 light, supressor
  --    "EQP_WP_East_sm_042",--riot smg stn grd 1
  --    "EQP_WP_East_sm_043",--as above, big scope supressor, no icon
  --    "EQP_WP_East_sm_044",--as above ?
  --    "EQP_WP_East_sm_045",--as above ?
  --shotguns
  --    "EQP_WP_Com_sg_010",--s1000 grade 2
  --    "EQP_WP_Com_sg_011",--s1000 cs grade 2
  --    "EQP_WP_Com_sg_011_FL",--as above, flashlight ?
  --    "EQP_WP_Com_sg_013",--? mag shotgun no name no icon
  --    "EQP_WP_Com_sg_015",--above + scope, light
  --    "EQP_WP_Com_sg_020",--kabarga 83, grade 4, looks like same model as 013,14
  --    "EQP_WP_Com_sg_020_FL",--as abovem flashlight ?
  --    "EQP_WP_Com_sg_023",--s1000 air-s stn at least icon grade 3 - icon shows slilencer scope but not in game
  --    "EQP_WP_Com_sg_024",--as above, light ?
  --    "EQP_WP_Com_sg_025",--as above
  --    "EQP_WP_Com_sg_030",--s1000 air-s cs grade 6
  --assault rifles
  --    "EQP_WP_West_ar_010",--AM MRS 4r Grade 3
  --    "EQP_WP_West_ar_010_FL",--flashlight
  --    "EQP_WP_West_ar_055",--scope, no icon name
  --    "EQP_WP_West_ar_020",--un arc cs grade 3
  --    "EQP_WP_West_ar_020_FL",--flashlight
  --    "EQP_WP_West_ar_030",--un arc pt cs flashlight scope laser
  --    "EQP_WP_West_ar_040",--am mrs 4 grade 1
  --    "EQP_WP_West_ar_042",--above + supressor scope
  --    "EQP_WP_West_ar_050",--am mrs 4r grade 5 scope laser
  --    "EQP_WP_West_ar_060",--un arc nl stn grade 2
  --    "EQP_WP_West_ar_063",--above + scope no icon name
  --    "EQP_WP_West_ar_070",--un arc nl stn light grade 4
  --    "EQP_WP_West_ar_075",--above + supressor
  --    "EQP_WP_East_ar_010",--svg 76 grade 1
  --    "EQP_WP_East_ar_010_FL",--+flashlight
  --    "EQP_WP_East_ar_020",--svg 67 cs grade 4
  --    "EQP_WP_East_ar_030",--above grade 6
  --    "EQP_WP_East_ar_030_FL",--+ flashlight

  --    "EQP_WP_West_sr_010",
  --    "EQP_WP_West_sr_011",
  --    "EQP_WP_West_sr_013",
  --    "EQP_WP_West_sr_014",
  --    "EQP_WP_West_sr_020",
  --    "EQP_WP_West_sr_037",
  --    "EQP_WP_East_sr_011",
  --    "EQP_WP_East_sr_020",
  --    "EQP_WP_East_sr_032",
  --    "EQP_WP_East_sr_033",
  --    "EQP_WP_East_sr_034",

  --    "EQP_WP_West_mg_010",
  --    "EQP_WP_West_mg_020",
  --    "EQP_WP_West_mg_023",
  --    "EQP_WP_West_mg_024",
  --    "EQP_WP_West_mg_021",
  --    "EQP_WP_West_mg_030",
  --    "EQP_WP_East_mg_010",
  --missile launchers
  --    "EQP_WP_Com_ms_010",
  --    "EQP_WP_Com_ms_020",
  --    "EQP_WP_Com_ms_023",
  --    "EQP_WP_Com_ms_024",
  --    "EQP_WP_West_ms_010",
  --    "EQP_WP_West_ms_020",
  --    "EQP_WP_East_ms_010",
  --    "EQP_WP_East_ms_020",

  --special weapons
  --    "EQP_WP_Wood_ar_010",
  --no go
  --    "EQP_WP_Quiet_sr_010",
  --    "EQP_WP_Quiet_sr_020",
  --    "EQP_WP_Quiet_sr_030",
  --    "EQP_WP_BossQuiet_sr_010",
  --    "EQP_WP_Pr_sm_010",
  --    "EQP_WP_Pr_ar_010",
  --    "EQP_WP_Pr_sg_010",
  --    "EQP_WP_Pr_sr_010",
  --    "EQP_WP_mgm0_mgun0",

  --  "EQP_WP_HoneyBee",
  --  "EQP_WP_Volgin_sg_010",--no go
  --  "EQP_WP_SkullFace_hg_010",--holds weird, its actual use in its mission has it's own custom animation?

  --hang on load --re test
  --  "EQP_WP_DEBUG_sr_010",
  --  "EQP_WP_DEMO_ar_010",
  --  "EQP_WP_DEMO_ar_020",
  --  "EQP_WP_DEMO_ar_030",
  --  "EQP_WP_DEMO_sr_010",
  --  "EQP_WP_DEMO_hg_010",
  --  "EQP_WP_DEMO_hg_020",
  --  "EQP_WP_DEMO_hg_030",
  --  "EQP_WP_DEMO_sm_010",
  --  "EQP_WP_DEMO_sm_020",
  --  "EQP_WP_DEMO_mg_010",
  --  "EQP_WP_DEMO_ms_010",
  --  "EQP_WP_DEMO_ms_020",

  --  "EQP_WP_SP_hg_010",
  --  "EQP_WP_SP_hg_020",
  --  "EQP_WP_SP_sm_010",
  --  "EQP_WP_SP_sg_010",

  --  "EQP_WP_SP_SLD_010",
  --  "EQP_WP_SP_SLD_010_G01",
  --  "EQP_WP_SP_SLD_010_G02",
  --  "EQP_WP_SP_SLD_020",
  --  "EQP_WP_SP_SLD_020_G01",
  --  "EQP_WP_SP_SLD_020_G02",
  --  "EQP_WP_SP_SLD_030",
  --  "EQP_WP_SP_SLD_030_G01",
  --  "EQP_WP_SP_SLD_030_G02",
  --  "EQP_WP_SP_SLD_040",
  --  "EQP_WP_SP_SLD_040_G01",
  --  "EQP_WP_SP_SLD_040_G02",

  --misc new weapons
  --  "EQP_WP_EX_hg_000",
  --  "EQP_WP_EX_gl_000",
  --  "EQP_WP_EX_sr_000",

  --loads, but missing icons and some blacked out sights
  --  "EQP_WP_West_sm_016",
  --  "EQP_WP_West_sm_017",
  --  "EQP_WP_Com_sg_038",
  --  "EQP_WP_Com_sg_016",
  --  "EQP_WP_Com_sg_018",
  --  "EQP_WP_West_sr_027",
  --  "EQP_WP_West_sr_047",
  --  "EQP_WP_West_sr_048",
  --  "EQP_WP_West_mg_037",
  --  "EQP_WP_Com_ms_026",
  --  "EQP_WP_East_sm_047",
  --  "EQP_WP_West_ar_057",
  --  "EQP_WP_West_ar_077",
  --requires fob mode/specifc set up i guess
  --  "EQP_WP_SCamLocator",
  }

--tex has no effect sadly, only boss quiet gameobject i guess
function this.SetQuietHumming(hummingFlag)
  local command = {id="SetHumming", flag=hummingFlag}
  local gameObjectId = GameObject.GetGameObjectIdByIndex("TppBuddyQuiet2", 0)

  if gameObjectId ~= NULL_ID then
    --InfMenu.DebugPrint("sethumming:"..tostring(hummingFlag))--DEBUG
    SendCommand(gameObjectId, command)
  else
    --InfMenu.DebugPrint"no TppBuddyQuiet2 found"--DEBUG
  end
end

return this
