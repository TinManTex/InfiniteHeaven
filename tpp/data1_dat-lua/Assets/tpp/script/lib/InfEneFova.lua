-- DOBUILD: 1
--InfEneFova.lua

local this={}
local InfEneFova=this

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
  --tex fova still not working right (see TppEnemyBodyId)
  MSF_SVS={
    --GOTCHA pfs and svs swapped due to retailbug, see TppEnemyBodyId
    maleBodyId={
      --tex can't actually tell any difference between the bodies
      TppEnemyBodyId.pfs0_dds0_v00,
      TppEnemyBodyId.pfs0_dds0_v01,
      TppEnemyBodyId.pfs0_dds0_v02,
      TppEnemyBodyId.pfs0_dds0_v03,
      TppEnemyBodyId.pfs0_dds0_v04,
      TppEnemyBodyId.pfs0_dds0_v05,
      TppEnemyBodyId.pfs0_dds0_v06,
      TppEnemyBodyId.pfs0_dds0_v07,
      TppEnemyBodyId.pfs0_dds0_v08,
      TppEnemyBodyId.pfs0_dds0_v09,
    },
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    noDDHeadgear=true,
    soldierSubType="DD_FOB",
  },
  MSF_PFS={--tex WIP shows, but combined with whatever other fpk is loaded, need to find right parts file?
    maleBodyId={
      TppEnemyBodyId.svs0_dds0_v00,
      TppEnemyBodyId.svs0_dds0_v01,
      TppEnemyBodyId.svs0_dds0_v02,
      TppEnemyBodyId.svs0_dds0_v03,
      TppEnemyBodyId.svs0_dds0_v04,
      TppEnemyBodyId.svs0_dds0_v05,
      TppEnemyBodyId.svs0_dds0_v06,
      TppEnemyBodyId.svs0_dds0_v07,
      TppEnemyBodyId.svs0_dds0_v08,
      TppEnemyBodyId.svs0_dds0_v09,
    },
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
    soldierSubType="DD_FOB",
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
  SOVIET_ALL={
    maleBodyId={
      TppEnemyBodyId.svs0_rfl_v00_a,
      TppEnemyBodyId.svs0_rfl_v01_a,
      TppEnemyBodyId.svs0_rfl_v02_a,
      TppEnemyBodyId.svs0_mcg_v00_a,
      TppEnemyBodyId.svs0_mcg_v01_a,
      TppEnemyBodyId.svs0_mcg_v02_a,
      TppEnemyBodyId.svs0_snp_v00_a,
      TppEnemyBodyId.svs0_rdo_v00_a,
      TppEnemyBodyId.svs0_rfl_v00_b,
      TppEnemyBodyId.svs0_rfl_v01_b,
      TppEnemyBodyId.svs0_rfl_v02_b,
      TppEnemyBodyId.svs0_mcg_v00_b,
      TppEnemyBodyId.svs0_mcg_v01_b,
      TppEnemyBodyId.svs0_mcg_v02_b,
      TppEnemyBodyId.svs0_snp_v00_b,
      TppEnemyBodyId.svs0_rdo_v00_b,
      TppEnemyBodyId.sva0_v00_a,
      TppEnemyBodyId.svs0_unq_v010,
      TppEnemyBodyId.svs0_unq_v080,
      TppEnemyBodyId.svs0_unq_v020,
      TppEnemyBodyId.svs0_unq_v040,
      TppEnemyBodyId.svs0_unq_v050,
      TppEnemyBodyId.svs0_unq_v060,
      TppEnemyBodyId.svs0_unq_v100,
      TppEnemyBodyId.svs0_unq_v070,
      TppEnemyBodyId.svs0_unq_v071,
      TppEnemyBodyId.svs0_unq_v072,
      TppEnemyBodyId.svs0_unq_v420,
      TppEnemyBodyId.svs0_unq_v009,
      TppEnemyBodyId.svs0_unq_v421,
      TppEnemyBodyId.pfs0_dds0_v00,--msf
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
  PF_ALL={
    maleBodyId={
      TppEnemyBodyId.pfs0_rfl_v00_a,
      TppEnemyBodyId.pfs0_rfl_v01_a,
      TppEnemyBodyId.pfs0_mcg_v00_a,
      TppEnemyBodyId.pfs0_snp_v00_a,
      TppEnemyBodyId.pfs0_rdo_v00_a,
      TppEnemyBodyId.pfs0_rfl_v00_b,
      TppEnemyBodyId.pfs0_rfl_v01_b,
      TppEnemyBodyId.pfs0_mcg_v00_b,
      TppEnemyBodyId.pfs0_snp_v00_b,
      TppEnemyBodyId.pfs0_rdo_v00_b,
      TppEnemyBodyId.pfs0_rfl_v00_c,
      TppEnemyBodyId.pfs0_rfl_v01_c,
      TppEnemyBodyId.pfs0_mcg_v00_c,
      TppEnemyBodyId.pfs0_snp_v00_c,
      TppEnemyBodyId.pfs0_rdo_v00_c,
      TppEnemyBodyId.pfa0_v00_b,
      TppEnemyBodyId.pfa0_v00_c,
      TppEnemyBodyId.pfa0_v00_a,
      TppEnemyBodyId.pfs0_unq_v210,
      TppEnemyBodyId.pfs0_unq_v250,
      TppEnemyBodyId.pfs0_unq_v360,
      TppEnemyBodyId.pfs0_unq_v280,
      TppEnemyBodyId.pfs0_unq_v150,
      TppEnemyBodyId.pfs0_unq_v220,
      TppEnemyBodyId.pfs0_unq_v140,
      TppEnemyBodyId.pfs0_unq_v241,
      TppEnemyBodyId.pfs0_unq_v242,
      TppEnemyBodyId.pfs0_unq_v450,
      TppEnemyBodyId.pfs0_unq_v440,
      TppEnemyBodyId.pfs0_unq_v155,
      TppEnemyBodyId.svs0_dds0_v00,--msf
    },
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
  --soldierSubType="PF_C",
  },
  SWIMSUIT={
    maleBodyId={
      TppEnemyBodyId.dlf_enem0_def,
      TppEnemyBodyId.dlf_enem1_def,
      TppEnemyBodyId.dlf_enem2_def,
      TppEnemyBodyId.dlf_enem3_def,
      TppEnemyBodyId.dlf_enem4_def,
      TppEnemyBodyId.dlf_enem5_def,
      TppEnemyBodyId.dlf_enem6_def,
      TppEnemyBodyId.dlf_enem7_def,
      TppEnemyBodyId.dlf_enem8_def,
      TppEnemyBodyId.dlf_enem9_def,
      TppEnemyBodyId.dlf_enem10_def,
      TppEnemyBodyId.dlf_enem11_def,
    },
    femaleBodyId={
      TppEnemyBodyId.dlf_enef0_def,
      TppEnemyBodyId.dlf_enef1_def,
      TppEnemyBodyId.dlf_enef2_def,
      TppEnemyBodyId.dlf_enef3_def,
      TppEnemyBodyId.dlf_enef4_def,
      TppEnemyBodyId.dlf_enef5_def,
      TppEnemyBodyId.dlf_enef6_def,
      TppEnemyBodyId.dlf_enef7_def,
      TppEnemyBodyId.dlf_enef8_def,
      TppEnemyBodyId.dlf_enef9_def,
      TppEnemyBodyId.dlf_enef10_def,
      TppEnemyBodyId.dlf_enef11_def,
    },
    partsPath="/Assets/tpp/parts/chara/dlf/dlf1_enem0_def_v00.parts",
    extendPartsInfo={type=1,path="/Assets/tpp/parts/chara/dlf/dlf0_enem0_def_f_v00.parts"},
    missionPackPath=TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT,--"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit.fpk"
    soldierSubType="DD_FOB",
  },
}

---



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
--tex GOTCHA, may have issues if called when weaponIdTable.DD is nil (as in GetDDSuit)
--wrap in IsDDBodyEquip call instead
--TODO: should probably do a IsDDBodyEquip check, but that would mean I'd have to pass in a missioncode
function this.GetCurrentDDBodyInfo(isFemale)
  if Ivars.mbDDSuit:Is(0) then
    return nil
  end

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

--
this.femaleSuits={
  "SNEAKING_SUIT",
  "BATTLE_DRESS",
  "TIGER",
  "DRAB",
  "SWIMSUIT",
}

this.wildCardSuitName="SNEAKING_SUIT"
function this.GetCurrentWildCardBodyInfo(isFemale)
  return this.ddBodyInfo[this.wildCardSuitName]
end

--tex non exhaustive, see face and body ids.txt,Soldier2FaceAndBodyData
this.maleFaceIds={
  {min=0,max=303},
  {min=320,max=349},
}
this.maleFaceIdsUncommon={
  {min=600,max=602},--mission dudes>
  {min=603,max=612},
  {min=614,max=620},
  {min=624,max=626},
  {635,},
  {min=637,max=642},
  {min=644,max=645},
  {min=647,max=649},
  {
    602,--glasses,
    621,--Tan
    622,--hideo, NOTE doesn't show if vars.playerFaceId
    627,--finger
    628,--eye
    646,--beardy mcbeard
    680,--black skull tattoo
    683,--red hair, ddogs tattoo
    684,--fox tattoo
    687,--while skull tattoo
  },
}


this.femaleFaceIds={
  {min=350,max=399},--european
  {min=440,max=479},--african
  {min=500,max=519},--asian
  {613,643},
  {
    681,--female tatoo skull black
    682,--female tatoo whiteblack ddog red hair
    685,--female tatoo fox black
    686,--female tatoo skull white white hair
  },
}

--NOTE: make sure RandomSetToLevelSeed is setup
--ASSUMPTION: last group in table is for unqiues that you don't want to spam too much
local uniqueChance=5--TUNE
function this.RandomFaceId(faceList)
  local rnd=math.random(#faceList)
  if rnd==#faceList then
    if math.random(100)>uniqueChance then
      rnd=rnd-1
    end
  end

  local type=faceList[rnd]
  if type.min then
    return math.random(type.min,type.max)
  else
    return type[math.random(1,#type)]
  end
end


this.wildCardBodyTable={
  afgh={
    TppEnemyBodyId.svs0_unq_v010,
    TppEnemyBodyId.svs0_unq_v020,
    TppEnemyBodyId.svs0_unq_v070,
    TppEnemyBodyId.svs0_unq_v071,
    TppEnemyBodyId.svs0_unq_v072,
    TppEnemyBodyId.svs0_unq_v009,
    TppEnemyBodyId.svs0_unq_v060,
    TppEnemyBodyId.svs0_unq_v100,
    TppEnemyBodyId.svs0_unq_v420,
  },
  mafr={
    TppEnemyBodyId.pfs0_unq_v210,
    TppEnemyBodyId.pfs0_unq_v250,
    TppEnemyBodyId.pfs0_unq_v360,
    TppEnemyBodyId.pfs0_unq_v280,
    TppEnemyBodyId.pfs0_unq_v150,
    TppEnemyBodyId.pfs0_unq_v140,
    TppEnemyBodyId.pfs0_unq_v241,
    TppEnemyBodyId.pfs0_unq_v450,
    TppEnemyBodyId.pfs0_unq_v440,
  },
}

--called from TppEnemyFova fovaSetupFuncs.Afghan/Africa
--IN/Out bodies
function this.WildCardFova(bodies)
  --InfInspect.TryFunc(function(bodies)--DEBUG
  InfMain.RandomSetToLevelSeed()
  local faces={}
  InfEneFova.inf_wildCardMaleFaceList={}
  InfEneFova.inf_wildCardFemaleFaceList={}
  for i=1,InfMain.MAX_WILDCARD_FACES-InfMain.numWildCardFemales do--SYNC numwildcards
    local faceId=this.RandomFaceId(this.maleFaceIdsUncommon)
    table.insert(faces,{faceId,1,1,0})--0,0,MAX_REALIZED_COUNT})--tex TODO figure this shit out, hint is in RegisterUniqueSetting since it builds one
    table.insert(InfEneFova.inf_wildCardMaleFaceList,faceId)
  end
  for i=1,InfMain.numWildCardFemales do
    local faceId=this.RandomFaceId(this.femaleFaceIds)
    table.insert(faces,{faceId,1,1,0})--0,0,MAX_REALIZED_COUNT})--tex TODO -^-
    table.insert(InfEneFova.inf_wildCardFemaleFaceList,faceId)
  end
  TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}

  local locationName=InfMain.GetLocationName()

  this.wildCardSuitName=this.femaleSuits[math.random(#this.femaleSuits)]
  local bodyInfo=this.GetCurrentWildCardBodyInfo(true)--tex female
  if bodyInfo then
    if bodyInfo.femaleBodyId then
      TppEneFova.SetupBodies(bodyInfo.femaleBodyId,bodies)
    end
    if bodyInfo.soldierSubType then
      local bodyIdTable=TppEnemy.bodyIdTable[bodyInfo.soldierSubType]
      if bodyIdTable then
        for powerType,bodyTable in pairs(bodyIdTable)do
          TppEneFova.SetupBodies(bodyTable,bodies)
        end
      end
    end

    if bodyInfo.extendPartsInfo then
      TppSoldier2.SetExtendPartsInfo(bodyInfo.extendPartsInfo)
    end
  end

  local maleBodyTable=this.wildCardBodyTable[locationName]
  if maleBodyTable then
    TppEneFova.SetupBodies(maleBodyTable,bodies)
  end
  InfMain.RandomResetToOsTime()
  --end,bodies)--DEBUG
end

function this.GetHeadGearForPowers(powerSettings,faceId,hasHelmet)
  local validHeadGearIds={}
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
        validHeadGearIds[#validHeadGearIds+1]=headGearId
      end
    end
  end

  return validHeadGearIds
end

return this
