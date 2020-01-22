-- DOBUILD: 1
local this={}

this.DEBUGMODE=false
this.modVersion="r131"
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

function this.SetLevelRandomSeed()
  math.randomseed(gvars.rev_revengeRandomValue)
  math.random()
  math.random()
  math.random()
end

function this.ResetTrueRandom()
  math.randomseed(os.time())
  math.random()
  math.random()
  math.random()
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
--tex maybe I'm missing something but not having luck indexing by EnemyType
function this.SoldierTypeNameForType(soldierType)
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
  if missionCode~=50050 and missionCode >5 then--tex IsFreeMission hangs on startup?
    local mbDDEquip = Ivars.enableMbDDEquip:Is(1) and missionCode==30050
    local enemyDDEquipFreeRoam = Ivars.enableEnemyDDEquip:Is(1) and TppMission.IsFreeMission(missionCode) and missionCode~=30050
    local enemyDDEquipMissions = Ivars.enableEnemyDDEquipMissions:Is(1) and TppMission.IsStoryMission(missionCode)
    return mbDDEquip or enemyDDEquipFreeRoam or enemyDDEquipMissions
  end
  return false
end

function this.IsDDBodyEquip(missionId)
  local missionCode=missionId or vars.missionCode
  if missionCode==30050 then
    return Ivars.mbDDSuit:Is()>0
  end
  return false
end

this.ddBodyInfo={
  SNEAKING_SUIT={
    maleBodyId=TppEnemyBodyId.dds4_enem0_def,
    femaleBodyId=TppEnemyBodyId.dds4_enef0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts",
    extendPartsInfo={type=1,path="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",
    soldierSubType="DD_FOB",
  },
  BATTLE_DRESS={
    maleBodyId=TppEnemyBodyId.dds5_enem0_def,
    femaleBodyId=TppEnemyBodyId.dds5_enef0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts",
    extendPartsInfo={type=1,path="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",
    soldierSubType="DD_FOB",
  },
  PFA_ARMOR={
    maleBodyId=TppEnemyBodyId.pfa0_v00_a,
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",
    isArmor=true,
    helmetOnly=true,
    noDDHeadgear=true,
    hasArmor=true,
    soldierSubType="DD_FOB",
  },
  TIGER={
    maleBodyId=TppEnemyBodyId.dds5_main0_v00,
    femaleBodyId=TppEnemyBodyId.dds6_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts",
    extendPartsInfo={type=1,path="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",
    soldierSubType="DD_FOB",
  },
  DRAB={--?? mother base default
    maleBodyId=TppEnemyBodyId.dds3_main0_v00,
    femaleBodyId=TppEnemyBodyId.dds8_main0_v00,
    extendPartsInfo={type=1,path="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT,
    soldierSubType="DD_FOB",
  },
  XOF={--tex Test: when XOF mission fpk loaded it stops salute morale from working?
    maleBodyId=TppEnemyBodyId.wss4_main0_v00,--wss4_main0_v01,wss4_main0_v02
    partsPath="/Assets/tpp/parts/chara/wss/wss4_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_xof_soldier.fpk",
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_AFGH",
  },
  SOVIET_A={
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    noDDHeadgear=true,
    soldierSubType="SOVIET_A",
    hasArmor=true,
  },
  SOVIET_B={
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    noDDHeadgear=true,
    soldierSubType="SOVIET_B",
    hasArmor=true,
  },
  PF_A={
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
    soldierSubType="PF_A",
    hasArmor=true,
  },
  PF_B={
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
    soldierSubType="PF_B",
    hasArmor=true,
  },
  PF_C={
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
    soldierSubType="PF_C",
    hasArmor=true,
  },
  GZ={
    maleBodyId=TppEnemyBodyId.dds0_main1_v00,--,TppEnemyBodyId.dds0_main1_v01
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main2_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_gz.fpk",
  },
  MSF={--tex WIP shows, but combined with whatever other fpk is loaded, need to find right parts file?
    maleBodyId=TppEnemyBodyId.pfs0_dds0_v00,--svs0_dds0_v00,--pfs0_dds0_v00,
  --partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
  --missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
  --    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
  --    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
  --soldierSubType="PF_A",
  },
  SOVIET_BERETS={
    maleBodyId={
      TppEnemyBodyId.svs0_unq_v010,
      TppEnemyBodyId.svs0_unq_v020,
      TppEnemyBodyId.svs0_unq_v070,
      TppEnemyBodyId.svs0_unq_v071,
      TppEnemyBodyId.svs0_unq_v072,
      TppEnemyBodyId.svs0_unq_v009,
    },
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    noDDHeadgear=true,
    noHelmet=true,--tex TODO: just do a whole equip allowed/disallowed
  --soldierSubType="SOVIET_B",
  },
  SOVIET_HOODIES={
    maleBodyId={
      TppEnemyBodyId.svs0_unq_v060,
      TppEnemyBodyId.svs0_unq_v100,
      TppEnemyBodyId.svs0_unq_v420,
    },
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    noDDHeadgear=true,
  --soldierSubType="SOVIET_B",
  },
  PF_MISC={
    maleBodyId={
      TppEnemyBodyId.pfs0_unq_v210,--black beret, glases, black vest, red shirt, tan pants
      TppEnemyBodyId.pfs0_unq_v250,--black beret, white coyote tshirt, black pants
      TppEnemyBodyId.pfs0_unq_v360,--red long sleeve shirt, black pants
      TppEnemyBodyId.pfs0_unq_v280,--black suit, white shirt, red white striped tie
      TppEnemyBodyId.pfs0_unq_v150,--green beret, brown leather top, light tan muddy pants
      TppEnemyBodyId.pfs0_unq_v140,--cap, glases, badly clipping medal, brown leather top, light tan muddy pants
      TppEnemyBodyId.pfs0_unq_v241,--brown leather top, light tan muddy pants
      --TppEnemyBodyId.pfs0_unq_v242,--brown leather top, light tan muddy pants, cant tell any difference?
      TppEnemyBodyId.pfs0_unq_v450,--red beret, brown leather top, light tan muddy pants
      TppEnemyBodyId.pfs0_unq_v440,--red beret, black leather top, black pants
    },
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
  --soldierSubType="PF_C",
  },
}

--pfs0_unq_v210=250,--black beret, glases, black vest, red shirt, tan pants
--pfs0_unq_v250=251,--black beret, white coyote tshirt, black pants
--pfs0_unq_v360=253,--red long sleeve shirt, black pants
--pfs0_unq_v280=254,--black suit, white shirt, red white striped tie
--pfs0_unq_v150=255,--green beret, brown leather top, light tan muddy pants
--pfs0_unq_v220=256,--cfa light tan short pants, red shoulder decorations maybe?
--pfs0_unq_v140=264,--cap, glases, badly clipping medal, brown leather top, light tan muddy pants
--pfs0_unq_v241=265,--brown leather top, light tan muddy pants
--pfs0_unq_v242=266,--brown leather top, light tan muddy pants, cant tell any difference?
--pfs0_unq_v450=267,--red beret, brown leather top, light tan muddy pants
--pfs0_unq_v440=272,--red beret, black leather top, black pants
--pfs0_unq_v155=275,--red beret cfa light tank shortpants

--pfs0_dds0_v00=280,
--pfs0_dds0_v01=281,
--pfs0_dds0_v02=282,
--pfs0_dds0_v03=283,
--pfs0_dds0_v04=284,
--pfs0_dds0_v05=285,
--pfs0_dds0_v06=286,
--pfs0_dds0_v07=287,
--pfs0_dds0_v08=288,
--pfs0_dds0_v09=289,

--"svs0_rfl_v00_a",
--"svs0_rfl_v01_a",
--"svs0_rfl_v02_a",
--"svs0_mcg_v00_a",
--"svs0_mcg_v01_a",
--"svs0_mcg_v02_a",
--"svs0_snp_v00_a",
--"svs0_rdo_v00_a",
--"svs0_rfl_v00_b",
--"svs0_rfl_v01_b",
--"svs0_rfl_v02_b",
--"svs0_mcg_v00_b",
--"svs0_mcg_v01_b",
--"svs0_mcg_v02_b",
--"svs0_snp_v00_b",
--"svs0_rdo_v00_b",
--"sva0_v00_a",--armor

--soviet (unless otherwise said)
--svs0_unq_v010=257,--red beret, looks ok with DD headgear, but not greentop (so no nvg either)
--svs0_unq_v080=258,--digital camo, seems like it would be in the normal soviet body selection, dont know.
--svs0_unq_v020=259,--green beret, brown coat
--svs0_unq_v040=260,--urban camo radio, headgear works nice with DD headgear (but not greentop
--svs0_unq_v050=261,--urban camo, cap, dd non green ok
--svs0_unq_v060=262,--black hoodie, green vest, urban pants, dd non green ok
--svs0_unq_v100=263,--tan/brown hoodie, brown pants
--svs0_unq_v070=268,--red beret, green vest, tan top, pants
--svs0_unq_v071=269,--red beret, woodland camo
--svs0_unq_v072=270,--red beret, glases, urban, so no headgear
--svs0_unq_v420=271,--dark brown hoodie
--svs0_unq_v009=273,--red beret, green vest, grey top, pants
--svs0_unq_v421=274,--wood camo

--svs0_dds0_v00=290,
--svs0_dds0_v01=291,
--svs0_dds0_v02=292,
--svs0_dds0_v03=293,
--svs0_dds0_v04=294,
--svs0_dds0_v05=295,
--svs0_dds0_v06=296,
--svs0_dds0_v07=297,
--svs0_dds0_v08=298,
--svs0_dds0_v09=299,

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

function this.GetCurrentDDBodyInfo(isFemale)
  local suitName=nil
  if Ivars.mbDDSuit:Is"EQUIPGRADE" then
    local ddSuit=TppEnemy.GetDDSuit()
    suitName=this.ddSuitToDDBodyInfo[ddSuit]
    --0=OFF,EQUIPGRADE,..specific suits
  elseif Ivars.mbDDSuit:Is()>1 then
    if isFemale then
      suitName=Ivars.mbDDSuitFemale.settings[Ivars.mbDDSuitFemale:Get()+1]
    else
      suitName=Ivars.mbDDSuit.settings[Ivars.mbDDSuit:Get()+1]
    end
  else
    return nil
  end

  return this.ddBodyInfo[suitName]
end

this.wildCardSuitName="SNEAKING_SUIT"--DEBUGNOW
function this.GetCurrentWildCardBodyInfo(isFemale)
  return this.ddBodyInfo[this.wildCardSuitName]
end

--function this.AddBodyPack(bodyInfo)--CULL
--  if not bodyInfo then
--    return
--  end
--  if bodyInfo.missionPackPath then
--    TppPackList.AddMissionPack(bodyInfo.missionPackPath)
--  end
--end

function this.GetHeadGearForPowers(powerSettings,faceId,hasHelmet)
  local validHeadGearIds={}
  --CULL local powerSettings=mvars.ene_soldierPowerSettings[soldierId]or nil
  if powerSettings then
    local gearPowerTypes={
      HELMET=true,
      GAS_MASK=true,
      NVG=true,
    }
    if hasHelmet then
      gearPowerTypes.HELMET=nil
    end

    local function IsFemale(faceId)
      local isFemale=TppSoldierFace.CheckFemale{face={faceId}}
      return isFemale and isFemale[1]==1
    end
    for headGearId, headGearInfo in pairs(this.ddHeadGearInfo)do
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
      --      if hasHelmet and headGearInfo.HELMET then --CULL
      --        if powerSettings.HELMET and not (powerSettings.GAS_MASK or powerSettings.NVG) then--tex really only want to prevent DD helm+nothing
      --          isMatch=false
      --        end
      --      end
      if hasHelmet and (not headGearInfo.GAS_MASK and not headGearInfo.NVG) then
        isMatch=false
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
    InfMain.SetLevelRandomSeed()
    grade=this.MinMaxIvarRandom"mbSoldierEquipGrade"
    InfMain.ResetTrueRandom()
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
    return Ivars.mbDDEquipNonLethal:Is(1)
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

  this.SetLevelRandomSeed()--tex set to a math.random on OnMissionClearOrAbort so a good base for a seed to make this constand on mission loads. Soldiers dont care since their subtype is saved but other functions read subTypeOfCp
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
  this.ResetTrueRandom()--tex back to 'truly random' /s for good measure
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
function this.SetUpMBZombie()
  --  for idx = 1, table.getn(this.soldierDefine[mtbs_enemy.cpNameDefine]) do
  --    local gameObjectId = GameObject.GetGameObjectId("TppSoldier2", this.soldierDefine[mtbs_enemy.cpNameDefine][idx])
  --    if gameObjectId ~= NULL_ID then
  --      InfMenu.DebugPrint("idx:".. idx .. "soldiername: ".. tostring(this.soldierDefine[mtbs_enemy.cpNameDefine][idx]) )--DEBUG
  --      GameObject.SendCommand( gameObjectId, { id = "SetZombie", enabled = true, isMsf = false, isZombieSkin = true, isHagure = false } )
  --    end
  --  end
  for cpName, soldierNameList in pairs( mtbs_enemy.soldierDefine ) do
    for _, soldierName in pairs( soldierNameList ) do
      local gameObjectId = GetGameObjectId("TppSoldier2", soldierName)
      if gameObjectId ~= NULL_ID then
        local command =  {
          id = "SetZombie",
          enabled = true,
          isMsf = math.random()>0.7,
          isZombieSkin = false,--math.random()>0.5,
          isHagure = math.random()>0.7,--tex donn't even know
          isHalf=math.random()>0.7,--tex donn't even know
        }
        if not command.isMsf then
          command.isZombieSkin=true
        end
        GameObject.SendCommand( gameObjectId, command )
        if command.isMsf then
          local command = { id = "SetMsfCombatLevel", level = math.random(9) }
          GameObject.SendCommand( gameObjectId, command )
        end

        if math.random()>0.8 then
          GameObject.SendCommand( gameObjectId, { id = "SetEnableHotThroat", enabled = true } )
        end
      end
    end
  end

end

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
  this.SetLevelRandomSeed()
  for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
    local powerTable=Ivars[powerTableName]
    for m,powerType in ipairs(powerTable)do
      local min=Ivars[powerType.."_MIN"].setting
      local max=Ivars[powerType.."_MAX"].setting
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

  for n,powerType in ipairs(Ivars.cpEquipBoolPowers)do
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

  if vars.missionCode==30050 then
    if Ivars.mbDDEquipNonLethal:Is(1) then
      revengeConfig.NO_KILL_WEAPON=true
    end
  end

  local bodyInfo=this.GetCurrentDDBodyInfo()
  if bodyInfo and (not bodyInfo.hasArmor) and vars.missionCode==30050 then--tex TODO: handle mother base special case better, especially with the male/female split
    revengeConfig.ARMOR=nil
  end

  this.ResetTrueRandom()
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
  local command = { id="SetFriendlyCp" }
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
    seats=4,
  },
  TRUCK={
    ivar="vehiclePatrolTruckEnable",
    seats=2,
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
    seats=1,--6,
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_MACHINE_GUN",
    },
  },
  WHEELED_ARMORED_VEHICLE_HEAVY={
    ivar="vehiclePatrolWavHeavyEnable",
    seats=2,--6,
    easternVehicles={
      "EASTERN_WHEELED_ARMORED_VEHICLE_ROCKET_ARTILLERY",
    },
    westernVehicles={
      "WESTERN_WHEELED_ARMORED_VEHICLE_TURRET_CANNON",
    },
  },
  TRACKED_TANK={
    ivar="vehiclePatrolTankEnable",
    seats=1,--tex actually seats 2, but still behaviour with it stopping, dropping off a dude, then attacking
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
  --packPath="/Assets/tpp/pack/soldier/reinforce/reinforce_veh_east_tnk.fpk",
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

local patrolVehicleEnabledList=nil--tex cleared on Init, TODO: don't like this setup

function this.IsPatrolVehicleMission()
  if vars.missionCode==TppDefine.SYS_MISSION_ID.AFGH_FREE or vars.missionCode==TppDefine.SYS_MISSION_ID.MAFR_FREE then
    return true
  end
  return false
end

this.MAX_PATROL_VEHICLES=16--SYNC: ivars MAX_PATROL_VEHICLES

function this.BuildEnabledList()
  patrolVehicleEnabledList={}
  for baseType,typeInfo in pairs(vehicleBaseTypes) do
    if typeInfo.ivar then
      --InfMenu.DebugPrint("spawnInfo.ivar="..spawnInfo.ivar)--DEBUG
      if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
        patrolVehicleEnabledList[#patrolVehicleEnabledList+1]=baseType
        --InfMenu.DebugPrint(baseType.." added to enabledList")--DEBUG
      end
    end
  end
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

--IN: missionTable.enemy.VEHICLE_SPAWN_LIST, missionTable.enemy.soldierDefine
function this.ModifyVehiclePatrol(vehicleSpawnList)
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:ExecCheck() then
    return
  end

  if patrolVehicleEnabledList==nil then
    this.BuildEnabledList()
  end

  if #patrolVehicleEnabledList==0 then
    --InfMenu.DebugPrint"ModifyVehicleSpawn - enabledList empty"--DEBUG
    return
  end

  mvars.patrolVehicleBaseInfo={}

  local singularBaseType=nil
  for n,spawnInfo in pairs(vehicleSpawnList)do
    if string.find(spawnInfo.locator, "veh_trc_000") then--tex only replacing certain ids, seen in free mission vehicle spawn list
      local vehicle=nil
      local vehicleType=nil

      local baseType=patrolVehicleEnabledList[math.random(#patrolVehicleEnabledList)]
      if Ivars.vehiclePatrolProfile:Is"SINGULAR" then
        if singularBaseType==nil then
          singularBaseType=baseType
        else
          baseType=singularBaseType
        end
      end
      local baseTypeInfo=vehicleBaseTypes[baseType]
      if baseTypeInfo~=nil then
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

        if vehicleType==nil then
          InfMenu.DebugPrint("warning: vehicleType==nil")
          break
        end

        vehicle=vehicleSpawnInfoTable[vehicleType]
        if vehicle==nil then
          InfMenu.DebugPrint("warning: vehicle==nil")
          break
        end

        mvars.patrolVehicleBaseInfo[spawnInfo.locator]=baseTypeInfo

        this.SetPatrolSpawnInfo(vehicle,spawnInfo)
      end
    end
  end
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
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:ExecCheck() then
    return
  end

  for baseType,typeInfo in pairs(vehicleBaseTypes) do
    if Ivars[typeInfo.ivar]~=nil and Ivars[typeInfo.ivar]:Is()>0 then
      --InfMenu.DebugPrint("has gvar ".. typeInfo.ivar)--DEBUG
      local vehicles=nil
      local vehicleType=""
      local locationName=""
      if TppLocation.IsAfghan()then
        vehicles=typeInfo.easternVehicles
        locationName="EASTERN_"
      elseif TppLocation.IsMiddleAfrica()then
        vehicles=typeInfo.westernVehicles
        locationName="WESTERN_"
      end


      local GetPackPath=function(vehicleType)
        local vehicle=vehicleSpawnInfoTable[vehicleType]
        if vehicle~=nil then
          return vehicle.packPath or nil
        end
      end

      if vehicles==nil then
        vehicleType=locationName..baseType
        local packPath=GetPackPath(vehicleType)
        if packPath~=nil then
          --InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
          AddMissionPack(packPath,missionPackPath)
        end
      else
        for n, vehicleType in pairs(vehicles) do
          local packPath=GetPackPath(vehicleType)
          if packPath~=nil then
            --InfMenu.DebugPrint("packpath: "..tostring(packPath))--DEBUG
            AddMissionPack(packPath,missionPackPath)
          end
        end
      end
    end--if gvar
  end--for vehicle base types
  --CULL
  --    local packPath
  --    for vehicleType,spawnInfo in pairs(vehicleSpawnInfoTable) do
  --      --CULLif Ivars.vehiclePatrolPackType:Is"QUESTPACK" then
  --      --  packPath=spawnInfo.packPathAlt
  --      --else
  --      packPath=spawnInfo.packPath
  --      --end
  --      if packPath then
  --        AddMissionPack(packPath,missionPackPath)
  --      end
  --    end
end
--<vehicle stuff

--block quests>
--DOC: vehicle quests.txt
this.disableVehicleQuests={--tex WORKAROUND, using the player vehicle/veh_rl* packs for patrol vehicle replace has a side effect of breaking quests with multiple vehicles (invis vehcile), TODO if ever get custom packs going/fix this remove this
  "quest_q52040",
  "quest_q52050",
  "quest_q52070",
  "quest_q52060",
  "quest_q52090",
  "quest_q52100",
  "quest_q52130",
  "quest_q52110",
  "quest_q52025",
  "quest_q52120",
  "quest_q52140",
  "quest_q52045",
  "quest_q52055",
  "quest_q52105",
  "quest_q52125",
  "quest_q52145",
}

--
local blockQuests={
  "tent_q99040" -- 144 - recover volgin, player is left stuck in geometry at end of quanranteed plat demo
}

function this.BlockQuest(questName)
  if vars.missionCode==30050 and Ivars.mbWarGamesProfile:Is()>1 then
    return true
  end

  for n,name in ipairs(blockQuests)do
    if name==questName then
      if TppQuest.IsCleard(questName) then
        return true
      end
    end
  end
  --tex block heli quests to allow super reinforce
  if Ivars.enableHeliReinforce:Is(1) then
    --if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    for n,name in ipairs(TppDefine.QUEST_HELI_DEFINE)do
      if name==questName then
        return true
      end
    end
    --end
  end

  if Ivars.vehiclePatrolProfile:Is()>0 then
    local isVehiclePack=false
    for baseType,typeInfo in pairs(vehicleBaseTypes) do
      if not (typeInfo.ivar~="vehiclePatrolLvEnable" or typeInfo.ivar~="vehiclePatrolTruckEnable") then
        if Ivars[typeInfo.ivar] and Ivars[typeInfo.ivar]:Is()>0 then
          isVehiclePack=true
        end
      end
    end
    if isVehiclePack==true then
      --if this.IsPatrolVehicleMission() then
      for n,name in ipairs(this.disableVehicleQuests)do
        if name==questName then
          return true
        end
      end
      --end
    end
  end
  return false
end
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
  --    for n,equipName in ipairs(this.tppEquipTable)do--DEBUGNOW still working on the indexed not grouped table
  --      local equipId=TppEquip[equipName]
  --      if equipId~=nil then
  --        table.insert(equipLoadTable,equipId)
  --      end
  --    end
  --
  --    if #equipLoadTable>0 and TppEquip.RequestLoadToEquipMissionBlock then
  --      TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)
  --    end
  --  end--<
end

function this.PreMissionLoad(missionCode,currentMissionCode)
end

function this.MissionPrepare()
  if TppMission.IsStoryMission(vars.missionCode) then
    if Ivars.gameOverOnDiscovery:Is(1) then
      TppMission.RegistDiscoveryGameOver()
    end
  end
end

local disableActionMenus=PlayerDisableAction.OPEN_CALL_MENU+PlayerDisableAction.OPEN_EQUIP_MENU
local menuDisableActions=PlayerDisableAction.OPEN_EQUIP_MENU

function this.RestoreActionFlag()
  local activeControlMode=this.GetActiveControlMode()
  -- WIP
  --  if activeControlMode then
  --    if bit.band(vars.playerDisableActionFlag,menuDisableActions)==menuDisableActions then
  --    else
  --      this.EnableAction(menuDisableActions)
  --    end
  --  else
  this.EnableAction(menuDisableActions)
  --  end
end

function this.DisableAction(actionFlag)
  if not this.ActionIsDisabled(actionFlag) then
    vars.playerDisableActionFlag=vars.playerDisableActionFlag+actionFlag
  end
end
function this.EnableAction(actionFlag)
  if this.ActionIsDisabled(actionFlag) then
    vars.playerDisableActionFlag=vars.playerDisableActionFlag-actionFlag
  end
end

function this.ActionIsDisabled(actionFlag)
  if bit.band(vars.playerDisableActionFlag,actionFlag)==actionFlag then
    return true
  end
  return false
end

--
local allButCamPadMask={
  settingName="allButCam",
  except=true,
  --buttons=PlayerPad.STANCE,
  sticks=PlayerPad.STICK_R,
}
--CULL REF
--local commonControlPadMask={
--  settingName="controlMode",
--  except=false,
--  buttons=PlayerPad.ALL,
--  sticks=PlayerPad.STICK_L,--+PlayerPad.STICK_R,
--  triggers=PlayerPad.TRIGGER_L+PlayerPad.TRIGGER_R,
--}

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
  local healthScale=Ivars.playerHealthScale:Get()/100
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
  if Ivars.disableWorldMarkers:Is(1) then
    TppUiStatusManager.SetStatus("WorldMarker","INVALID")
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
  Ivars.adjustCameraUpdate,
  Ivars.heliUpdate,
}

this.initTest=0--DEBUGNOW
--tex called at very start of TppMain.OnInitialize, use mostly for hijacking missionTable scripts
function this.OnInitializeTop(missionTable)
  if missionTable.enemy then
    local enemyTable=missionTable.enemy
    this.ResetSoldierPool()
    InfMain.SetLevelRandomSeed()
    if IsTable(enemyTable.soldierDefine) then
      if IsTable(enemyTable.VEHICLE_SPAWN_LIST)then
        this.ModifyVehiclePatrol(enemyTable.VEHICLE_SPAWN_LIST)
      end

      enemyTable.soldierTypes=enemyTable.soldierTypes or {}
      enemyTable.soldierSubTypes=enemyTable.soldierSubTypes or {}
      enemyTable.soldierPowerSettings=enemyTable.soldierPowerSettings or {}
      enemyTable.soldierPersonalAbilitySettings=enemyTable.soldierPersonalAbilitySettings or {}

      this.initTest=this.initTest+1--DEBUGNOW
      this.ModifyVehiclePatrolSoldiers(enemyTable.soldierDefine)
      this.AddWildCards(enemyTable.soldierDefine,enemyTable.soldierTypes,enemyTable.soldierSubTypes,enemyTable.soldierPowerSettings,enemyTable.soldierPersonalAbilitySettings)
      this.AddLrrps(enemyTable.soldierDefine,enemyTable.travelPlans)
    end

    --    if IsTable(missionTable.enemy.soldierPowerSettings)then
    --    --     this.SetUpPowerSettings(missionTable.enemy.soldierPowerSettings)--tex
    --    end
    InfMain.ResetTrueRandom()
  end
end
function this.OnAllocateTop(missionTable)

end

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

    if Ivars.keepPhase:Is(1) then
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
--cam buttons
--CULL
--this.zoomInButton=InfButton.ZOOM_CHANGE
--this.zoomOutButton=InfButton.SUBJECT

this.resetModeButton=InfButton.ACTION
this.verticalModeButton=InfButton.SUBJECT
this.zoomModeButton=InfButton.FIRE
this.apertureModeButton=InfButton.RELOAD
this.focusDistanceModeButton=InfButton.STANCE
this.distanceModeButton=InfButton.CALL

this.nextEditCamButton=InfButton.RIGHT
this.prevEditCamButton=InfButton.LEFT

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
--  InfButton.buttonStates[this.moveRightButton].decrement=0.1
--  InfButton.buttonStates[this.moveLeftButton].decrement=0.1
--  InfButton.buttonStates[this.moveForwardButton].decrement=0.1
--  InfButton.buttonStates[this.moveBackButton].decrement=0.1
--  InfButton.buttonStates[this.moveUpButton].decrement=0.1
--  InfButton.buttonStates[this.moveDownButton].decrement=0.1
end

function this.InitWarpPlayerUpdate()
end

function this.OnActivateWarpPlayer()
  InfButton.buttonStates[this.moveRightButton].decrement=0.1
  InfButton.buttonStates[this.moveLeftButton].decrement=0.1
  InfButton.buttonStates[this.moveForwardButton].decrement=0.1
  InfButton.buttonStates[this.moveBackButton].decrement=0.1
  InfButton.buttonStates[this.moveUpButton].decrement=0.1
  InfButton.buttonStates[this.moveDownButton].decrement=0.1

  local repeatRate=0.06
  local repeatRateUp=0.04
  InfButton.buttonStates[this.moveRightButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveLeftButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveForwardButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveBackButton].repeatRate=repeatRate
  InfButton.buttonStates[this.moveUpButton].repeatRate=repeatRateUp
  InfButton.buttonStates[this.moveDownButton].repeatRate=repeatRate

  --WIP this.DisableAction(Ivars.warpPlayerUpdate.disableActions)
end

function this.OnDeactivateWarpPlayer()
--this.EnableAction(Ivars.warpPlayerUpdate.disableActions)
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
--
local cameraOffsetDefault=Vector3(0,0.75,0)
--this.cameraPosition=cameraOffsetDefault--CULL
--this.cameraOffset=cameraOffsetDefault

--function this.ResetCamDefaults()--CULL
--  local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
--  this.cameraPosition=currentPos+cameraOffsetDefault
--end

--function this.ResetCamPosition()--CULL
--  local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
--  this.cameraPosition=currentPos+cameraOffsetDefault
--end
--SYNC: Ivars camNames
local function GetCurrentCamName()
  if Ivars.cameraMode:Is"PLAYER" then
    if PlayerInfo.OrCheckStatus{PlayerStatus.STAND}then
      return "PlayerStand"
    elseif PlayerInfo.OrCheckStatus{PlayerStatus.SQUAT}then
      return "PlayerSquat"
    elseif  PlayerInfo.OrCheckStatus{PlayerStatus.CRAWL}then
      return "PlayerCrawl"
    elseif  PlayerInfo.OrCheckStatus{PlayerStatus.DASH}then
      return "PlayerDash"
    else
      InfMenu.DebugPrint"UpdateCameraManualMode: unknow PlayerStatus"
    end
  else
    return "FreeCam"
  end
end

local function ReadPosition(camName)
  return Vector3(Ivars["positionX"..camName]:Get(),Ivars["positionY"..camName]:Get(),Ivars["positionZ"..camName]:Get())
end

local function WritePosition(camName,position)
  Ivars["positionX"..camName]:Set(position:GetX())
  Ivars["positionY"..camName]:Set(position:GetY())
  Ivars["positionZ"..camName]:Set(position:GetZ())
end

--REF
--    Player.SetAroundCameraManualModeParams{
--      --offset=this.cameraOffset,
--      distance=0,--1.2,
--      focalLength=focalLength:Get(),
--      focusDistance=focusDistance:Get(),
--      aperture=aperture:Get(),
--      --target=Vector3(0,0,0),--tex only if targetIsPlayer?--Vector3(0,1000,0),--Vector3(2,10,10),
--      target=movePosition,
--      targetInterpTime=.2,
--      --targetIsPlayer=true,
--      --targetOffsetFromPlayer=Vector3(0,0,0.5),
--      --rotationBasedOnPlayer = true,
--      ignoreCollisionGameObjectName="Player",
--      --ignoreCollisionGameObjectId
--      rotationLimitMinX=-90,
--      rotationLimitMaxX=90,
--      alphaDistance=.5,
--    --interpImmediately = immediately,
--    --enableStockChangeSe = true,
--    --rotationBasedOnPlayer = true,
--    --useShakeParam = true
--    }

function this.UpdateCameraManualMode()
  local currentCamName=GetCurrentCamName()
  local focalLength=Ivars["focalLength"..currentCamName]
  local aperture=Ivars["aperture"..currentCamName]
  local focusDistance=Ivars["focusDistance"..currentCamName]
  local cameraDistance=Ivars["distance"..currentCamName]
  local movePosition=ReadPosition(currentCamName)

  if Ivars.cameraMode:Is"PLAYER" then
    Player.SetAroundCameraManualModeParams{
      offset=movePosition,--this.cameraOffset,--Vector3(0.0,0.75,0),--this.cameraOffset,
      distance=cameraDistance:Get(),
      focalLength=focalLength:Get(),
      focusDistance=focusDistance:Get(),
      aperture=aperture:Get(),
      --target=Vector3(0,0,0),--tex only if targetIsPlayer?--Vector3(0,1000,0),--Vector3(2,10,10),--this.cameraPosition,
      targetInterpTime=.2,
      targetIsPlayer=true,
      --targetOffsetFromPlayer=Vector3(0,0,0.5),
      --rotationBasedOnPlayer = true,
      ignoreCollisionGameObjectName="Player",
      --TEST OFF rotationLimitMinX=-60,
      --TEST OFF rotationLimitMaxX=80,
      alphaDistance=.5,--3--.5,
    --enableStockChangeSe = false,
    --useShakeParam = true
    }
  else
    Player.SetAroundCameraManualModeParams{
      target=movePosition,
      distance=cameraDistance:Get(),
      focalLength=focalLength:Get(),
      focusDistance=focusDistance:Get(),
      aperture=aperture:Get(),
      targetInterpTime=.2,
      ignoreCollisionGameObjectName="Player",
      rotationLimitMinX=-90,
      rotationLimitMaxX=90,
      alphaDistance=.5,
    }
  end
  Player.UpdateAroundCameraManualModeParams()
end

function this.OnActivateCameraAdjust()
  --this.DisableAction(Ivars.adjustCameraUpdate.disableActions)--tex OFF not really needed, padmask is sufficient
  Player.SetPadMask(allButCamPadMask)
end

function this.OnDectivateCameraAdjust()
  --this.EnableAction(Ivars.adjustCameraUpdate.disableActions)--tex OFF not really needed, padmask is sufficient
  Player.ResetPadMask {
    settingName = "allButCam",
  }
end

function this.UpdateCameraAdjust(currentChecks,currentTime,execChecks,execState,updateRate,updateRange,ExecUpdate)
  if not currentChecks.inGame then
    if Ivars.adjustCameraUpdate.setting==1 then
      Ivars.adjustCameraUpdate:Set(0)
    end
    return
  end

  if Ivars.adjustCameraUpdate:Is(0) then
    if Ivars.cameraMode:Is()>0 then
      this.UpdateCameraManualMode()
    end
    return
  end

  if Ivars.cameraMode:Is(0) then
    --OFF    InfMenu.PrintLangId"cannot_edit_default_cam"
    Ivars.adjustCameraUpdate:Set(0)
    return
  end

  local isFreeCam=Ivars.cameraMode:Is"CAMERA"

  local moveAmount=1
  local zoomAmount=4
  local deadZone=0

  local moveX=0
  local moveY=0
  local moveZ=0

  local didMove=false
  if math.abs(PlayerVars.leftStickXDirect)>deadZone or math.abs(PlayerVars.leftStickYDirect)>deadZone then--tex seem like game already handles deadzone?
    didMove=true
  end

  local currentCamName=GetCurrentCamName()
  local focalLength=Ivars["focalLength"..currentCamName]
  local aperture=Ivars["aperture"..currentCamName]
  local focusDistance=Ivars["focusDistance"..currentCamName]
  local cameraDistance=Ivars["distance"..currentCamName]
  local movePosition=ReadPosition(currentCamName)

  local moveScale=Ivars.moveScale:Get()
  if not isFreeCam then
    moveScale=moveScale*0.1
  end
  --tex pretty much doing voodoo to tune these
  local focalLengthScale=focalLength:Get()/100--1
  local apertureScale=aperture:Get()/50--0.1
  local focusDistanceScale=focusDistance:Get()/10--0.1

  moveX=-PlayerVars.leftStickXDirect*moveScale
  moveZ=-PlayerVars.leftStickYDirect*moveScale

  if not currentChecks.inMenu then
    local function IvarClamp(ivar,value)
      if value>ivar.range.max then
        value=ivar.range.max
      elseif value<ivar.range.min then
        value=ivar.range.min
      end
      return value
    end

    if didMove then
      if InfButton.ButtonDown(this.zoomModeButton) then
        local newValue=focalLength:Get()-PlayerVars.leftStickYDirect*focalLengthScale
        newValue=IvarClamp(focalLength,newValue)
        focalLength:Set(newValue)
      elseif InfButton.ButtonDown(this.apertureModeButton) then
        local newValue=aperture:Get()-PlayerVars.leftStickYDirect*apertureScale
        newValue=IvarClamp(aperture,newValue)
        aperture:Set(newValue)
      elseif InfButton.ButtonDown(this.focusDistanceModeButton) then
        local newValue=focusDistance:Get()-PlayerVars.leftStickYDirect*focusDistanceScale
        newValue=IvarClamp(focusDistance,newValue)
        focusDistance:Set(newValue)
      elseif InfButton.ButtonDown(this.verticalModeButton) then
        moveY=moveZ
        moveZ=0
        moveX=0
        local vMoveDir=Vector3(moveX,moveY,moveZ)
        local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
        local camMoveDir=rotYQuat:Rotate(vMoveDir)
        movePosition=movePosition+camMoveDir
      elseif InfButton.ButtonDown(this.distanceModeButton) then
        local newValue=cameraDistance:Get()+PlayerVars.leftStickYDirect*focusDistanceScale--WIP TODO own scale
        newValue=IvarClamp(cameraDistance,newValue)
        cameraDistance:Set(newValue)
      else
        local vMoveDir=Vector3(moveX,moveY,moveZ)
        local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
        local camMoveDir=rotYQuat:Rotate(vMoveDir)
        movePosition=movePosition+camMoveDir
      end
    end--didmove
    --
    if InfButton.ButtonDown(this.resetModeButton) then
      if InfButton.OnButtonDown(this.zoomModeButton) then
        focalLength:Reset()
      elseif InfButton.OnButtonDown(this.apertureModeButton) then
        aperture:Reset()
      elseif InfButton.OnButtonDown(this.focusDistanceModeButton) then
        focusDistance:Reset()
      elseif InfButton.OnButtonDown(this.verticalModeButton) then
        if isFreeCam then
          local currentPos = Vector3(vars.playerPosX, vars.playerPosY, vars.playerPosZ)
          movePosition=currentPos+cameraOffsetDefault
        else
          movePosition=cameraOffsetDefault
        end
      elseif InfButton.OnButtonDown(this.distanceModeButton) then
        if isFreeCam then--tex KLUDGE
          cameraDistance:Set(0)
        else
          cameraDistance:Reset()
        end
      end
    end
    --
    if Ivars.disableCamText:Is(0) then
      if InfButton.OnButtonDown(this.zoomModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"focal_length_mode".." "..focalLength:Get())
      end
      if InfButton.OnButtonDown(this.apertureModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"aperture_mode".." "..aperture:Get())
      end
      if InfButton.OnButtonDown(this.focusDistanceModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"focus_distance_mode".." "..focusDistance:Get())
      end
      if InfButton.OnButtonDown(this.verticalModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"vertical_mode")
      end
      if InfButton.OnButtonDown(this.distanceModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"distance_mode".." "..cameraDistance:Get())
      end
      if InfButton.OnButtonDown(this.resetModeButton) then
        InfMenu.Print(currentCamName.." "..InfMenu.LangString"reset_mode")
      end
    end
    --inmenu-v-
  else
    if didMove then
      local vMoveDir=Vector3(moveX,moveY,moveZ)
      local rotYQuat=Quat.RotationY(TppMath.DegreeToRadian(vars.playerCameraRotation[1]))
      local camMoveDir=rotYQuat:Rotate(vMoveDir)
      movePosition=movePosition+camMoveDir
      --InfMenu.DebugPrint("movePosition "..movePosition:GetX()..","..movePosition:GetY()..","..movePosition:GetZ())
    end
  end

  WritePosition(currentCamName,movePosition)
  this.UpdateCameraManualMode()
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
---
function this.OnMenuOpen()

end
function this.OnMenuClose()
  local activeControlMode=this.GetActiveControlMode()
  if activeControlMode then
    if IsFunc(activeControlMode.OnActivate) then
      activeControlMode.OnActivate()
    end
  end
end


local controlModes={
  Ivars.warpPlayerUpdate,
  Ivars.adjustCameraUpdate,
}
function this.GetActiveControlMode()
  for i,ivar in ipairs(controlModes)do
    if ivar:Is(1) then
      return ivar
    end
  end
  return nil
end
--

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
--NOTE: grade possibly matches current developed anyhoo?
this.tppEquipTable={--SYNC: EquipIdTable
  --  SHIELD={
  --  "EQP_SLD_SV",
  --  "EQP_SLD_PF_00",
  --  "EQP_SLD_PF_01",
  --  "EQP_SLD_PF_02",
  --  "EQP_SLD_DD",
  --  "EQP_SLD_DD_G02",
  --  "EQP_SLD_DD_G03",
  --  "EQP_SLD_DD_01",
  --  },
  --  HANDGUN={
  --  "EQP_WP_West_hg_010",--AM D114 grade 1 -- PFs and DD hangun
  --  "EQP_WP_West_hg_010_WG",--no name/icon/drop model
  --  "EQP_WP_West_hg_020",--AM D114 with silencer(on icon) but no ext mag?  grade 4, skull normal strong
  --  "EQP_WP_West_hg_030",--geist p3 - shows shotgun icon but clearly isnt, machine pistol grade 4
  --  "EQP_WP_West_hg_030_cmn",--as above, no name/icon
  --  "EQP_WP_East_hg_010",--burkov grade 1, sov normal strong
  --  },
  --  TRANQ_PISTOL={
  --  "EQP_WP_West_thg_010",--wu s.pistol grade 1
  --  "EQP_WP_West_thg_020",--grade 2
  --  "EQP_WP_West_thg_030",--wu s pistol inf supressor grade 5
  --  "EQP_WP_West_thg_040",--grade 5
  --  "EQP_WP_West_thg_050",--wu s pistol cb grade7
  --  "EQP_WP_EX_hg_000",--AM A114 RP, DD, silencer, grade 9
  --  },
  --  SMG={
  --  "EQP_WP_West_sm_010",--ze'ev cs grade 3 pf normal, dd min grade
  --  "EQP_WP_West_sm_010_WG",--as above, no icon/name
  --  "EQP_WP_West_sm_020",--macht 37 grade 3, pf strong, skull normal strong
  --  "EQP_WP_East_sm_010",--sz 336 grade 3, sov normal
  --  "EQP_WP_East_sm_020",--sz 336 cs grade 5, sov strong
  --  "EQP_WP_East_sm_030",--sz 336 cs grade 3 light, supressor, skull cypr normal

  --dd table smg
  "EQP_WP_West_sm_014",--zeeve model, big scope no icon/name, supressor, DD icon backing
  "EQP_WP_West_sm_015",--as above
  "EQP_WP_West_sm_016",--loads, but missing icons and some blacked out sights DD backing, DD weapon table
  "EQP_WP_West_sm_017",--<
  --  },
  --    SMG_NONLETHAL={
  --in dd table
  --  "EQP_WP_East_sm_042",--riot smg stn grd 1 stun
  --  "EQP_WP_East_sm_043",
  --  "EQP_WP_East_sm_044",
  --  "EQP_WP_East_sm_045",
  --  "EQP_WP_East_sm_047",
  --    },
  --  SHOTGUN={
  --  "EQP_WP_Com_sg_010",--s1000 grade 2
  --  "EQP_WP_Com_sg_011",--s1000 cs grade 2, most normal shotty, sov a, pfs, skull, dd min
  --  "EQP_WP_Com_sg_011_FL",--as above, flashlight ?
  --  --in dd table
  "EQP_WP_Com_sg_013",--? mag shotgun no name no icon
  "EQP_WP_Com_sg_015",--above + scope, light
  "EQP_WP_Com_sg_020",--kabarga 83, grade 4, looks like same model as 013,14
  "EQP_WP_Com_sg_020_FL",--as abovem flashlight ?
  "EQP_WP_Com_sg_016",
  "EQP_WP_Com_sg_018",
  --},
  --SHOTGUN_NONLETHAL={
  --dd
  "EQP_WP_Com_sg_023",--s1000 air-s stn at least icon grade 3 - icon shows slilencer scope but not in game
  "EQP_WP_Com_sg_024",--as above, light ?
  "EQP_WP_Com_sg_025",--as above
  "EQP_WP_Com_sg_030",--s1000 air-s cs grade 6
  "EQP_WP_Com_sg_038",--loads, but missing icons and some blacked out sights
--  },
--  ASSAULT={
--  "EQP_WP_West_ar_010",--AM MRS 4r Grade 3, pfs normal, dd 3rd
--  "EQP_WP_West_ar_010_FL",--flashlight
--
--  "EQP_WP_West_ar_020",--un arc cs grade 3 PF strong
--  "EQP_WP_West_ar_020_FL",--flashlight
--  "EQP_WP_West_ar_030",--un arc pt cs flashlight scope laser, skull normal and strong
--
--  "EQP_WP_East_ar_010",--svg 76 grade 1, soviet normal
--  "EQP_WP_East_ar_010_FL",--+flashlight
--  "EQP_WP_East_ar_020",--svg 67 cs grade 4, child
--  "EQP_WP_East_ar_030",--above grade 6, sov strong
--  "EQP_WP_East_ar_030_FL",--+ flashlight
--
--  --in dd table
--  "EQP_WP_West_ar_040",--am mrs 4 grade 1
--  "EQP_WP_West_ar_042",--above + supressor scope
--  "EQP_WP_West_ar_055",--scope, no icon name
--  "EQP_WP_West_ar_050",--am mrs 4r grade 5 scope laser
--  "EQP_WP_West_ar_057",--loads, but missing icons and some blacked out sights
--  --  },
--  --  ASSAULT_NONLETHAL={
--  "EQP_WP_West_ar_060",--un arc nl stn grade 2
--  "EQP_WP_West_ar_063",--above + scope no icon name
--  "EQP_WP_West_ar_070",--un arc nl stn light grade 4
--  "EQP_WP_West_ar_075",--above + supressor
--  "EQP_WP_West_ar_077",
--  --  },
--  --  SNIPER={
--  "EQP_WP_West_sr_010",--m2000 d grade 2
--  "EQP_WP_West_sr_011",--PF normal, DD
--  "EQP_WP_East_sr_011",--sov a normal
--  "EQP_WP_East_sr_020",--sov a strong
--
--  "EQP_WP_EX_sr_000",--molotok-68 grade 9 --icon/scope issues
--
--  --dd table
--  "EQP_WP_West_sr_013",
--  "EQP_WP_West_sr_014",
--  "EQP_WP_West_sr_020",
--  "EQP_WP_West_sr_027",
--  --  },
--  --SNIPER_NONLETHAL={
--  --ddtable
--  "EQP_WP_East_sr_032",
--  "EQP_WP_East_sr_033",
--  "EQP_WP_East_sr_034",
--  "EQP_WP_West_sr_037",
--  "EQP_WP_West_sr_047",
--  "EQP_WP_West_sr_048",
--  --},
--  --  MG={
--  "EQP_WP_West_mg_010",--un am cs grade 4 PF normal,strong,
--  "EQP_WP_West_mg_020",--alm 48 grade 2 skull normal strong, dd min
--  "EQP_WP_West_mg_021",--alm48 flashlight grade 4
--  "EQP_WP_East_mg_010",--lpg 61 grade 4, soviet normal
--  --dd
--  "EQP_WP_West_mg_023",--
--  "EQP_WP_West_mg_024",
--  "EQP_WP_West_mg_030",--alm 48 grade 5 flashlight
--  "EQP_WP_West_mg_037",--
--  --  },
--  --  MISSILE={
--  "EQP_WP_Com_ms_010",--killer bee grade 3, sov, pf, dd,skull strong
--  "EQP_WP_West_ms_010",--fb mr r grade 3, pf,skull normal
--  "EQP_WP_East_ms_010",--grom 11, grade 2, sov normal
--  "EQP_WP_East_ms_020",--cgm 25, used in s10054
--  --dd table
--  "EQP_WP_Com_ms_023",
--  "EQP_WP_Com_ms_024",
--  "EQP_WP_Com_ms_020",--killer bee
--  "EQP_WP_Com_ms_026",

-- MISSILE_NONLETHAL={
--"EQP_WP_West_ms_020",--fb mr rl nlsp
--},

--  GRENADE_LAUNCHER={
--  "EQP_WP_EX_gl_000",--miraz zh 71 grade 9
--  },

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
--    "EQP_SWP_MolotovCocktailPlaced",
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

--special weapons
--    "EQP_WP_Wood_ar_010",
----no go
--    "EQP_WP_Quiet_sr_010",
--    "EQP_WP_Quiet_sr_020",
--    "EQP_WP_Quiet_sr_030",
--    "EQP_WP_BossQuiet_sr_010",
--    "EQP_WP_Pr_sm_010",
--    "EQP_WP_Pr_ar_010",
--    "EQP_WP_Pr_sg_010",
--    "EQP_WP_Pr_sr_010",
--    "EQP_WP_mgm0_mgun0",
--
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

--requires fob mode/specifc set up i guess
--  "EQP_WP_SCamLocator",

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
}

local equipCategories={}
for n,category in pairs(this.tppEquipTable)do
  equipCategories[n]=category
end

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

--lrrp plus
local afghBaseNames={
  "afgh_villageEast_ob",
  "afgh_commWest_ob",
  "afgh_cliffSouth_ob",
  "afgh_villageWest_ob",
  "afgh_bridgeWest_ob",
  "afgh_tentEast_ob",
  "afgh_enemyNorth_ob",
  "afgh_cliffWest_ob",
  "afgh_cliffEast_ob",
  "afgh_fortWest_ob",
  "afgh_slopedEast_ob",
  "afgh_fortSouth_ob",
  "afgh_ruinsNorth_ob",
  "afgh_villageNorth_ob",
  "afgh_slopedWest_ob",
  "afgh_fieldEast_ob",
  "afgh_plantSouth_ob",
  "afgh_waterwayEast_ob",
  "afgh_plantWest_ob",
  "afgh_fieldWest_ob",
  "afgh_remnantsNorth_ob",
  "afgh_tentNorth_ob",
  "afgh_cliffTown_cp",
  "afgh_tent_cp",
  "afgh_waterway_cp",
  "afgh_powerPlant_cp",
  "afgh_sovietBase_cp",
  "afgh_remnants_cp",
  "afgh_field_cp",
  "afgh_citadel_cp",
  "afgh_fort_cp",
  "afgh_village_cp",
  "afgh_bridge_cp",
  "afgh_commFacility_cp",
  "afgh_slopedTown_cp",
  "afgh_enemyBase_cp",
  "afgh_bridgeNorth_ob",
  "afgh_enemyEast_ob",
  "afgh_sovietSouth_ob",
}--#39

local mafrBaseNames={
  "mafr_outlandNorth_ob",
  "mafr_swampWest_ob",
  "mafr_outlandEast_ob",
  "mafr_bananaSouth_ob",
  "mafr_swampSouth_ob",
  "mafr_swampEast_ob",
  "mafr_savannahWest_ob",
  "mafr_bananaEast_ob",
  "mafr_savannahNorth_ob",
  "mafr_diamondWest_ob",
  "mafr_diamondSouth_ob",
  "mafr_hillNorth_ob",
  "mafr_savannahEast_ob",
  "mafr_hillWest_ob",
  "mafr_pfCampEast_ob",
  "mafr_pfCampNorth_ob",
  "mafr_factorySouth_ob",
  "mafr_diamondNorth_ob",
  "mafr_labWest_ob",
  "mafr_outland_cp",
  "mafr_flowStation_cp",
  "mafr_swamp_cp",
  "mafr_pfCamp_cp",
  "mafr_savannah_cp",
  "mafr_banana_cp",
  "mafr_diamond_cp",
  "mafr_hill_cp",
  "mafr_factory_cp",
  "mafr_lab_cp",
  "mafr_hillWestNear_ob",
  "mafr_hillSouth_ob",
  "mafr_swampWestNear_ob",
  "mafr_chicoVilWest_ob",
  "mafr_chicoVil_cp",
}--#34

--reserve soldierpool
this.reserveSoldierNames={}
local solPrefix="sol_ih_"
this.numReserveSoldiers=40--tex SYNC number of soldier locators i added to fox2s
for i=0,this.numReserveSoldiers-1 do
  local name=solPrefix..string.format("%04d", i)
  table.insert(this.reserveSoldierNames,name)
end

function this.ResetSoldierPool()
  this.soldierPool={}
  for n,soldierName in ipairs(this.reserveSoldierNames) do
    table.insert(this.soldierPool,soldierName)
  end
end

function this.SoldierPoolPop()
  if #this.soldierPool==0 then
    return nil
  end
  local soldierName=this.soldierPool[this.soldierPool]
  table.remove(this.soldierPool)
  return soldierName
end

local function FillLrrp(num,soldierPool,cpDefine)
  local soldiers={}
  while num>0 and #soldierPool>0 do
    local soldierName=soldierPool[#soldierPool]
    if soldierName then
      table.insert(soldiers,soldierName)
      table.remove(soldierPool)--pop
      table.insert(cpDefine,#cpDefine+1,soldierName)
      num=num-1
    end
  end
  return soldiers
end

local function ResetPool(baseNames)
  local namePool={}
  for n,name in ipairs(baseNames) do
    table.insert(namePool,name)
  end
  return namePool
end

local function GetRandomPool(pool,startBases)
  local rndIndex=math.random(#pool)
  local name=pool[rndIndex]
  table.remove(pool,rndIndex)
  --tex RETHINK, ugly bad
  if startBases then
    for i,startBaseName in ipairs(startBases) do
      if name==startBaseName then
        table.remove(pool,i)
      end
    end
  end

  return name
end

function this.ModifyVehiclePatrolSoldiers(soldierDefine)
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end

  if Ivars.vehiclePatrolProfile:Is()>0 and Ivars.vehiclePatrolProfile:ExecCheck() then
    local initPoolSize=#this.soldierPool
    for cpName,cpDefine in pairs(soldierDefine)do
      local numCpSoldiers=0
      for n,soldierName in ipairs(cpDefine)do
        numCpSoldiers=numCpSoldiers+1
      end

      if cpDefine.lrrpVehicle then
        local numSeats=2
        if mvars.patrolVehicleBaseInfo then
          local baseTypeInfo=mvars.patrolVehicleBaseInfo[cpDefine.lrrpVehicle]
          if baseTypeInfo then
            numSeats=math.random(math.min(numSeats,baseTypeInfo.seats),baseTypeInfo.seats)
            --InfMenu.DebugPrint(cpDefine.lrrpVehicle .. " numVehSeats "..numSeats)--DEBUG
          end
        end
        --
        if numCpSoldiers>numSeats then
          local gotSeat=0
          local clearIndices={}
          for n,soldierName in ipairs(cpDefine)do
            gotSeat=gotSeat+1
            if gotSeat>numSeats then
              table.insert(this.soldierPool,soldierName)
              cpDefine[n]=nil
            end
          end
        else
          numSeats=numSeats-numCpSoldiers
          --InfMenu.DebugPrint(cpDefine.lrrpVehicle .. " numfillSeats "..numSeats)--DEBUG
          if numSeats>0 then
            FillLrrp(numSeats,this.soldierPool,cpDefine) --tex TODO why is this crashing out?
          end
        end
        --if lrrpVehicle<
      end
      --for soldierdefine<
    end
    local poolChange=#this.soldierPool-initPoolSize
    InfMenu.DebugPrint("pool change:"..poolChange)--DEBUGNOW
    --if vehiclePatrol<
  end
end

--IN/OUT,SIDE reserveSoldierPool
function this.AddLrrps(soldierDefine,travelPlans)
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end

  if Ivars.enableLrrpFreeRoam:Is(0) then
    return
  end

  local cpPool={}

  local lrrpInd="_lrrp"
  for cpName,cpDefine in pairs(soldierDefine)do
    local cpId=GetGameObjectId(cpName)
    if cpId==NULL_ID then
      InfMenu.DebugPrint(cpName.."==NULL_ID")
    else
      if string.find(cpName,lrrpInd)~=nil then
        if #cpDefine==0 then
          table.insert(cpPool,cpName)
        end
      end
    end
  end
  --InfMenu.DebugPrint("cpPool"..#cpPool)--DEBUG

  local planStr="travelIH_"

  local reserved=0--6
  --tex OFF
  --  local minSize=Ivars.lrrpSizeFreeRoam_MIN:Get()
  --  local maxSize=Ivars.lrrpSizeFreeRoam_MAX:Get()
  --  if maxSize>#this.soldierPool then
  --    maxSize=#this.soldierPool
  --  end
  local numLrrps=0

  local baseNamePool={}
  local startBases={}
  if TppLocation.IsAfghan()then
    startBases=ResetPool(afghBaseNames)
  elseif TppLocation.IsMiddleAfrica()then
    startBases=ResetPool(mafrBaseNames)
  end
  for n,cpName in pairs(startBases)do
    local cpDefine=soldierDefine[cpName]
    if cpDefine==nil then
    --InfMenu.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
    else
      local cpId=GetGameObjectId(cpName)
      if cpId==NULL_ID then
      --InfMenu.DebugPrint(tostring(cpName).." cpId==NULL_ID")--DEBUG
      else
        table.insert(baseNamePool,cpName)
      end
    end
  end


  while #this.soldierPool-reserved>0 do
    --tex done, this limits to one lrrp per base (or rather starting at base, the end is much more random)
    if #startBases==0 then
      --InfMenu.DebugPrint"#startBases==0, each base should have a lrrp starting there"--DEBUG
      break
    end

    if #cpPool==0 then
      --InfMenu.DebugPrint"#cpPool==0"--DEBUG
      break
    end
    if #this.soldierPool==0 then
      --InfMenu.DebugPrint"#soldierPool==0"--DEBUG
      break
    end

    --tex 2 are used per lrrp (start>>end) so if num bases odd then will be left with 1
    --TODO: just choose a random from bases (and check it's not the same as currently in soldierpool
    if #startBases==1 then
      --InfMenu.DebugPrint"#startBases==1"--DEBUG
      break
    end

    --tex feeding from startbases gives a bit of an odd distribution
    --or we can quit here with a guarantees each base will be in a lrrp as a start or an end
    if #baseNamePool==0 or #baseNamePool==1 then
      break
      --baseNamePool=ResetBasePool(startBases)
    end

    local lrrpSize=2 --WIP custom lrrp size OFF to give coverage till I can come up with something better math.random(minSize,maxSize)
    --tex TODO: stop it from eating reserved
    --InfMenu.DebugPrint("lrrpSize "..lrrpSize)--DEBUG

    local cpName=cpPool[#cpPool]
    table.remove(cpPool)

    --InfMenu.DebugPrint("cpName:"..tostring(cpName))--DEBUG

    local cpDefine={}
    soldierDefine[cpName]=cpDefine--tex GOTCHA clearing the cp here, wheres in AddWildCards we are reading existing

    --tex TODO: random% filled to user settings
    local soldiers=FillLrrp(lrrpSize,this.soldierPool,cpDefine)
    local planName=planStr..cpName
    cpDefine.lrrpTravelPlan=planName
    travelPlans[planName]={
      {base=GetRandomPool(baseNamePool,startBases)},
      {base=GetRandomPool(baseNamePool)},
    }
    numLrrps=numLrrps+1
  end
  InfMenu.DebugPrint("num lrrps"..numLrrps)--DEBUGNOW

  --  local ins = InfInspect.Inspect(startBases)
  --  InfMenu.DebugPrint(ins)
end

this.MAX_WILDCARD_FACES=10--DEBUGNOW
function this.IsWildCardEnabled(missionCode)
  local missionCode=missionCode or vars.missionCode
  return Ivars.enableWildCardFreeRoam:Is(1) and (missionCode==30010 or missionCode==30020)
end

function this.AddWildCards(soldierDefine,soldierTypes,soldierSubTypes,soldierPowerSettings,soldierPersonalAbilitySettings)
  if not this.IsWildCardEnabled() then
    return
  end

  InfMenu.DebugPrint"AddWildCards"--DEBUGNOW

  local reserved=0

  local numLrrps=0

  local baseNamePool={}
  --  local startBases={}
  --  if TppLocation.IsAfghan()then
  --    startBases=ResetPool(afghBaseNames)
  --  elseif TppLocation.IsMiddleAfrica()then
  --    startBases=ResetPool(mafrBaseNames)
  --  end
  --
  --  --InfMenu.DebugPrint("cpName:"..tostring(cpName))--DEBUG
  --  for n,cpName in pairs(startBases)do
  --    local cpDefine=soldierDefine[cpName]
  --    if cpDefine==nil then
  --    --InfMenu.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
  --    else
  --      local cpId=GetGameObjectId(cpName)
  --      if cpId==NULL_ID then
  --      --InfMenu.DebugPrint(tostring(cpName).." cpId==NULL_ID")--DEBUG
  --      else
  --        table.insert(baseNamePool,cpName)
  --      end
  --    end
  --  end
  --
  for cpName,cpDefine in pairs(soldierDefine)do
    if #cpDefine>0 then
      local cpId=GetGameObjectId(cpName)
      if cpId~=NULL_ID then
        if cpDefine.lrrpVehicle==nil then--tex TODO: think if you want to add wildcards to vehicle lrrps
          table.insert(baseNamePool,cpName)
        end
      end
    end
  end

  local wildCardSubType="SOVIET_WILDCARD"
  if TppLocation.IsAfghan()then
    wildCardSubType="SOVIET_WILDCARD"
  elseif TppLocation.IsMiddleAfrica()then
    wildCardSubType="PF_WILDCARD"
  end
  local femaleWildCard="WILDCARD_FEMALE"


  local weaponPowers={
    --DEBUGNOW
    --    "ASSAULT",
    --    "SMG",
    --    "SHOTGUN",
    --    "MG",
    "SNIPER",
  --"MISSILE",
  }
  local weaponPool={}

  local abilityLevel="sp"
  local personalAbilitySettings={
    notice=abilityLevel,
    cure=abilityLevel,
    reflex=abilityLevel,
    shot=abilityLevel,
    grenade=abilityLevel,
    reload=abilityLevel,
    hp=abilityLevel,
    speed=abilityLevel,
    fulton=abilityLevel,
    holdup=abilityLevel
  }

  local numWildCards=math.max(1,math.floor(#baseNamePool/2.5))--DEBGUNOW/6))--DEBUGNOW
  local femaleChance=1--0.1--DEBUGNOW

  mvars.ene_wildCards={}
  local faceIdPool={}

  InfMenu.DebugPrint"ene_wildCardFaceList"
  local ins=InfInspect.Inspect(InfMain.ene_wildCardFaceList)--DEBUGNOW
  InfMenu.DebugPrint(ins)



  --while numLrrps<=numWildCards do
  for i=1,numWildCards do
    --    if #startBases==0 then
    --      --InfMenu.DebugPrint"#startBases==0, each base should have a lrrp starting there"--DEBUG
    --      break
    --    end

    --    if #this.soldierPool==0 then
    --      --InfMenu.DebugPrint"#soldierPool==0"--DEBUG
    --      break
    --    end

    if #baseNamePool==0 then
      --InfMenu.DebugPrint"#baseNamePool==0"--DEBUG
      break
    end

    local cpName=GetRandomPool(baseNamePool)
    --InfMenu.DebugPrint("cpName:"..tostring(cpName))--DEBUG

    local cpDefine=soldierDefine[cpName]
    --    if cpDefine==nil then
    --    --InfMenu.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
    --    else
    --      local cpId=GetGameObjectId(cpName)
    --      if cpId==NULL_ID then
    --      --InfMenu.DebugPrint(cpName.."==NULL_ID")--DEBUG
    --      else


    --InfMenu.DebugPrint("found cpname "..cpName)--DEBUGNOW

    local wildCardsPerCp=1
    --local soldiers=FillLrrp(wildCardsPerCp,this.soldierPool,cpDefine)
    if #cpDefine>0 then
      local soldierName=cpDefine[math.random(#cpDefine)]
      local isFemale=math.random()<=femaleChance
      --for n,soldierName in pairs(soldiers)do
      --DEBUGNOW if isFemale then--DEBUGNOW
      if InfMain.ene_wildCardFaceList then
        --InfMenu.DebugPrint"RegisterUniqueSetting s"--DEBUGNOW
        if #faceIdPool==0 then

          faceIdPool=ResetPool(InfMain.ene_wildCardFaceList)

          InfMenu.DebugPrint"faceIdPool"--DEBUGNOW
          local ins=InfInspect.Inspect(faceIdPool)--DEBUGNOW
          InfMenu.DebugPrint(ins)

        end

        local faceId=GetRandomPool(faceIdPool)--355--GetRandomBase(faceIdPool)
        InfMenu.DebugPrint("random faceid:"..faceId)--DEBUGNOW
        local bodyId=EnemyFova.INVALID_FOVA_VALUE
        InfMenu.DebugPrint"RegisterUniqueSetting e"--DEBUGNOW
        TppEneFova.RegisterUniqueSetting("enemy",soldierName,faceId,bodyId)
      end
      --            wildCardSubType="WILDCARD_FEMALE"

      local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", soldierName )
      if gameObjectId==NULL_ID then
        InfMenu.DebugPrint"gameObjectId==NULL_ID"--DEBUGNOW
      else

        local command={id="UseExtendParts",enabled=true}
        GameObject.SendCommand(gameObjectId,command)
      end
      mvars.ene_wildCards[soldierName]=true--DEBUGNOW differentiate between those that need extended and that dont
      --end
      soldierSubTypes[wildCardSubType]=soldierSubTypes[wildCardSubType] or {}
      table.insert(soldierSubTypes[wildCardSubType],soldierName)

      soldierPowerSettings[soldierName]={
        "HELMET",
        "SOFT_ARMOR",
        "GUN_LIGHT",
      --"GAS_MASK",
      }
      if #weaponPool==0 then
        weaponPool=ResetPool(weaponPowers)
      end
      local weapon=GetRandomPool(weaponPool)
      table.insert(soldierPowerSettings[soldierName],weapon)

      soldierPersonalAbilitySettings[soldierName]=personalAbilitySettings
      --end

      numLrrps=numLrrps+1
    end
    --      end
    --    end
  end
  InfMenu.DebugPrint("num wildCards"..numLrrps)--DEBUGNOW

  --  local ins = InfInspect.Inspect(startBases)
  --  InfMenu.DebugPrint(ins)
end

-- wildcard
--In: missionTable.enemy.soldierPowerSettings
function this.SetUpPowerSettings(soldierPowerSettings)

--"STEALTH_SPECIAL","COMBAT_SPECIAL"
--DEBUGNOW REF
--  this.soldierPowerSettings = {
--    sol_enemyNorth_lvVIP = { "HELMET", "MG", "SOFT_ARMOR" },
--}


end

this.wildCardBodiesAfgh={
  TppEnemyBodyId.svs0_unq_v010,
  TppEnemyBodyId.svs0_unq_v020,
  TppEnemyBodyId.svs0_unq_v070,
  TppEnemyBodyId.svs0_unq_v071,
  TppEnemyBodyId.svs0_unq_v072,
  TppEnemyBodyId.svs0_unq_v009,
  TppEnemyBodyId.svs0_unq_v060,
  TppEnemyBodyId.svs0_unq_v100,
  TppEnemyBodyId.svs0_unq_v420,
}

this.wildCardBodiesMafr={
  TppEnemyBodyId.pfs0_unq_v210,--black beret, glases, black vest, red shirt, tan pants
  TppEnemyBodyId.pfs0_unq_v250,--black beret, white coyote tshirt, black pants
  TppEnemyBodyId.pfs0_unq_v360,--red long sleeve shirt, black pants
  TppEnemyBodyId.pfs0_unq_v280,--black suit, white shirt, red white striped tie
  TppEnemyBodyId.pfs0_unq_v150,--green beret, brown leather top, light tan muddy pants
  TppEnemyBodyId.pfs0_unq_v140,--cap, glases, badly clipping medal, brown leather top, light tan muddy pants
  TppEnemyBodyId.pfs0_unq_v241,--brown leather top, light tan muddy pants
  --TppEnemyBodyId.pfs0_unq_v242,--brown leather top, light tan muddy pants, cant tell any difference?
  TppEnemyBodyId.pfs0_unq_v450,--red beret, brown leather top, light tan muddy pants
  TppEnemyBodyId.pfs0_unq_v440,--red beret, black leather top, black pants
}

return this
