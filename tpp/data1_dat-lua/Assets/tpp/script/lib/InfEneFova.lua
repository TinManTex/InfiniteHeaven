-- DOBUILD: 1
--InfEneFova.lua

--DEPENDANCY InfMain.ShuffleBag, todo thow in InfUtil and require

local this={}
local InfEneFova=this

this.ddBodyInfo={
  DRAB={--mother base default
    bodyId=TppEnemyBodyId.dds8_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds3_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT
    soldierSubType="DD_FOB",
  },
  DRAB_FEMALE={--mother base default
    bodyId=TppEnemyBodyId.dds8_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT
    soldierSubType="DD_FOB",
  },
  TIGER={--FOB default
    bodyId=TppEnemyBodyId.dds5_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER
    soldierSubType="DD_FOB",
  },
  TIGER_FEMALE={--FOB default
    bodyId=TppEnemyBodyId.dds6_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER
    soldierSubType="DD_FOB",
  },
  SNEAKING_SUIT={
    bodyId=TppEnemyBodyId.dds4_enem0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING
    soldierSubType="DD_FOB",
  },
  SNEAKING_SUIT_FEMALE={
    bodyId=TppEnemyBodyId.dds4_enef0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING
    soldierSubType="DD_FOB",
  },
  BATTLE_DRESS={
    bodyId=TppEnemyBodyId.dds5_enem0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS
    soldierSubType="DD_FOB",
  },
  BATTLE_DRESS_FEMALE={
    bodyId=TppEnemyBodyId.dds5_enem0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts",
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS
    soldierSubType="DD_FOB",
  },
  PFA_ARMOR={
    bodyId=TppEnemyBodyId.pfa0_v00_a,
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR--tex this pack is essentially just the mis_com_mafr soldier pack
    isArmor=true,
    helmetOnly=true,
    noDDHeadgear=true,
    hasArmor=true,
    soldierSubType="DD_FOB",
  },
  XOF={--tex Test: when XOF mission fpk loaded it stops salute morale from working?
    bodyId=TppEnemyBodyId.wss4_main0_v00,--mixed: clava only, helmet with goggles down, helmet with goggles up | gloves at side
    --TppEnemyBodyId.wss0_main0_v00,--helmet goggles down only
    --TppEnemyBodyId.wss3_main0_v00,--ditto??
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
  GZ={--tex crash on use, also missing bodyId/Soldier2FaceAndBodyData
    bodyId=TppEnemyBodyId.dds0_main1_v00,--,TppEnemyBodyId.dds0_main1_v01
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main2_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_gz.fpk",
  },
  MSF_SVS={
    --GOTCHA pfs and svs swapped due to retailbug, see TppEnemyBodyId/Soldier2FaceAndBodyData
    bodyId=TppEnemyBodyId.pfs0_dds0_v00,--tex even though there's a lot more BodyId/Soldier2FaceAndBodyData entries, they're all identical/the same fova
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    noDDHeadgear=true,
    soldierSubType="DD_FOB",
  },
  MSF_PFS={
    bodyId=TppEnemyBodyId.svs0_dds0_v00,--tex as above
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    noDDHeadgear=true,
    soldierSubType="DD_FOB",
  },
  SOVIET_BERETS={
    bodyId={
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
    bodyId={
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
    bodyId={
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
    bodyId={
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
    bodyId={
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
  SWIMWEAR={
    bodyId={
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
    partsPath="/Assets/tpp/parts/chara/dlf/dlf1_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT,
    soldierSubType="DD_FOB",
  },
  SWIMWEAR_FEMALE={
    bodyId={
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
    partsPath="/Assets/tpp/parts/chara/dlf/dlf0_enem0_def_f_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT,
    soldierSubType="DD_FOB",
  },
  --tex no collision/push target
  PRISONER_AFGH={
    bodyId=TppEnemyBodyId.prs2_main0_v00,
    partsPath="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh_hostage.fpk",
    soldierSubType="DD_FOB",
  },
  PRISONER_MAFR={
    bodyId=TppEnemyBodyId.prs5_main0_v00,--tex CRASH on initial game start if access TppEnemyBodyId?
    partsPath="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage.fpk",
    soldierSubType="DD_FOB",
  },
  PRISONER_MAFR_FEMALE={--tex still male body, don't know what's up
    bodyId=TppEnemyBodyId.prs6_main0_v00,--113
    partsPath="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk",
    soldierSubType="DD_FOB",
  },
  --tex crash, the file packs are very incomplete from a character standpoint
  DOCTOR={
    bodyId={
      TppEnemyBodyId.dct0_v00,--348,
    --TppEnemyBodyId.dct0_v01,--349,
    },
    partsPath="/Assets/tpp/parts/chara/dct/dct2_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  --tex crash
  NURSE_FEMALE={
    bodyId={
      TppEnemyBodyId.nrs0_v00,--340,
      TppEnemyBodyId.nrs0_v01,--341,
      TppEnemyBodyId.nrs0_v02,--342,
      TppEnemyBodyId.nrs0_v03,--343,
      TppEnemyBodyId.nrs0_v04,--344,
      TppEnemyBodyId.nrs0_v05,--345,
      TppEnemyBodyId.nrs0_v06,--346,
      TppEnemyBodyId.nrs0_v07,--347,
    },
    partsPath="/Assets/tpp/parts/chara/nrs/nrs3_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
    soldierSubType="DD_FOB",
  },
  SKULLFACE={--no collision/pushback
    bodyId={
      TppEnemyBodyId.wsp_def,
      TppEnemyBodyId.wsp_dam,--bloody
    },
    partsPath="/Assets/tpp/parts/chara/wsp/wsp0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_skullface.fpk",
    hasFace=true,
    soldierSubType="SKULL_AFGH",
  },
  HUEY={
    bodyId={
      TppEnemyBodyId.hyu0_main0_v00,--377 no glasses
      TppEnemyBodyId.hyu0_main0_v01,--378 oval glasses
      TppEnemyBodyId.hyu0_main0_v02,--379 rectangle glasses
    },
    partsPath="/Assets/tpp/parts/chara/hyu/hyu0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_huey.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  --tex no walk, or hit collision target. crash on cqc down
  --mb Kaz - coat and hat
  KAZ={
    bodyId=1,--tex no bodyId entries, so just using 1 since my code does an if bodyId check TODO see if there's any fovas elsewhere
    partsPath="/Assets/tpp/parts/chara/kaz/kaz0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_miller.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  --tex crash
  KAZ_GZ={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/kaz/kaz1_main1_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_miller_gz.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
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
--REF mbDDSuit = 0=OFF,EQUIPGRADE,..specific suits
function this.GetMaleDDBodyInfo()
  if Ivars.mbDDSuit:Is(0) then
    return nil
  end

  local suitName=nil
  if Ivars.mbDDSuit:Is"EQUIPGRADE" then
    if TppEnemy.weaponIdTable.DD==nil then
      return this.ddBodyInfo.DRAB
    end
    local ddSuit=TppEnemy.GetDDSuit()
    suitName=this.ddSuitToDDBodyInfo[ddSuit]
  else
    suitName=Ivars.mbDDSuit.settings[Ivars.mbDDSuit:Get()+1]
  end
  return this.ddBodyInfo[suitName]
end
--GOTCHA: relies on mbDDSuit > 0
local femaleSuffixStr="_FEMALE"
function this.GetFemaleDDBodyInfo()
  if Ivars.mbDDSuit:Is(0) then
    return nil
  end

  local suitName=nil
  if Ivars.mbDDSuitFemale:Is"EQUIPGRADE" then
    local ddSuit=TppEnemy.GetDDSuit()
    suitName=this.ddSuitToDDBodyInfo[ddSuit]..femaleSuffixStr
  else
    suitName=Ivars.mbDDSuitFemale.settings[Ivars.mbDDSuitFemale:Get()+1]
  end
  return this.ddBodyInfo[suitName]
end

--
this.wildCardFemaleSuits={
  "SNEAKING_SUIT_FEMALE",
  "BATTLE_DRESS_FEMALE",
  "TIGER_FEMALE",
  "DRAB_FEMALE",
  "SWIMWEAR_FEMALE",
}

this.wildCardFemaleSuitName="SNEAKING_SUIT"
function this.GetFemaleWildCardBodyInfo()
  return this.ddBodyInfo[this.wildCardFemaleSuitName]
end

--tex non exhaustive, see face and body ids.txt,Soldier2FaceAndBodyData, face and bodyids.txt
this.faceIds={
  MALE={
    COMMON={
      {min=0,max=303},
      {min=320,max=349},
    },
    UNCOMMON={
      {min=600,max=602},--mission dudes
      {min=603,max=612},
      {min=614,max=620},
      {min=624,max=626},
      {635,},
      {min=637,max=642},
      {min=644,max=645},
      {min=647,max=649},
    },
    UNIQUE={
      {
        602,--glasses,
        621,--Tan
        622,--hideo, NOTE doesn't show if vars.playerFaceId
        627,--finger
        628,--eye
        646,--beardy mcbeard
        680,--fox hound tattoo
        683,--red hair, ddogs tattoo
        684,--fox tattoo
        687,--while skull tattoo
      },
    },
  },
  FEMALE={
    COMMON={
      {min=350,max=399},--european
      {min=440,max=479},--african
      {min=500,max=519},--asian
      {613,643},
    },
    UNIQUE={
      {
        681,--female tatoo fox hound black
        682,--female tatoo whiteblack ddog red hair
        685,--female tatoo fox black
        686,--female tatoo skull white white hair
      },
    },
  }
}

--TUNE
this.categoryChances={
  MALE={
    COMMON=80,
    UNCOMMON=15,
    UNIQUE=5,
  },
  FEMALE={
    COMMON=95,
    UNIQUE=5,
  }
}

--IN InfEneFova.faceIds
function this.BuildFaceBags(faceIds)
  local faceBags={MALE={},FEMALE={}}
  for gender,categoryTables in pairs(faceIds) do
    for category,faceIdTables in pairs(categoryTables)do
      local faceBag=InfMain.ShuffleBag:New()
      faceBags[gender][category]=faceBag
      for i,faceIds in ipairs(faceIdTables) do
        if faceIds.min then
          for i=faceIds.min,faceIds.max do
            faceBag:Add(i)
          end
        else
          faceBag:Fill(faceIds)
        end
      end
    end
  end
  return faceBags
end

function this.GetCategoryBag(categoryChances,gender,categories)
  local bag=InfMain.ShuffleBag:New()
  for i,category in ipairs(categories) do
    local chance=categoryChances[gender][category]
    bag:Add(category,chance)
  end
  return bag
end

function this.RandomFaceId(faceBags,gender,categoryBag)
  local category=categoryBag:Next()
  return faceBags[gender][category]:Next()
end

--NOTE: make sure RandomSetToLevelSeed is setup
--ASSUMPTION: last group in table is for unqiues that you don't want to spam too much
--CULL
--local uniqueChance=5--TUNE
--function this.RandomFaceId(faceList)
--  local rnd=math.random(#faceList)
--  if rnd==#faceList then
--    if math.random(100)>uniqueChance then
--      rnd=rnd-1
--    end
--  end
--
--  local type=faceList[rnd]
--  if type.min then
--    return math.random(type.min,type.max)
--  else
--    return type[math.random(1,#type)]
--  end
--end

this.DEFAULT_FACEID_MALE=0
this.DEFAULT_FACEID_FEMALE=350

this.GENDER={
  MALE=0,
  FEMALE=1,
}

this.RACE={
  CAUCASIAN=0,--TppDefine.QUEST_RACE_TYPE.CAUCASIAN, TppMotherBaseManagementConst.RACE_WHITE
  BROWN=1,--TppDefine.QUEST_RACE_TYPE.BROWN, TppMotherBaseManagementConst.RACE_BLOWN
  BLACK=2,--TppDefine.QUEST_RACE_TYPE.BLACK, TppMotherBaseManagementConst.RACE_BLACK
  ASIAN=3,--TppDefine.QUEST_RACE_TYPE.ASIA, TppMotherBaseManagementConst.RACE_YELLOW
}

this.PLAYERTYPE_GENDER={
  [PlayerType.DD_MALE]=this.GENDER.MALE,
  [PlayerType.DD_FEMALE]=this.GENDER.FEMALE,
}

this.HAIRCOLOR={
  BROWN=0,
  BLACK=1,
  BLOND=2,
  AUBURN=3,
  RED=4,
  WHITE=5,
}

this.faceFovas={
  FEMALE={
    49,--35,36,37,38,39,57,
    50,--35,36,37,38,42,43,58,
    51,--35,36,37,38,41,59,
    52,--35,36,37,38,60,
    53,--39,40,41,
    54,--39,40,41,
    55,--39,40,41,
    56,--39,40,41,42,43,44
    57,--37,38,42,43,44,
    58,--42,43,44,
  },
}

this.faceFovaInfo={
  {
    name="cm_m0_h0_v000_eye0.fv2",
    faceFova=0,
  },
  {
    name="cm_m0_h0_v001_eye0.fv2",
    faceFova=1,
  },
  {
    name="cm_m0_h0_v002_eye0.fv2",
    faceFova=2,
  },
  {
    name="cm_m0_h0_v003_eye0.fv2",
    faceFova=3,
  },
  {
    name="cm_m0_h0_v004_eye0.fv2",
    faceFova=4,
  },
  {
    name="cm_m0_h0_v005_eye1.fv2",
    faceFova=5,
  },
  {
    name="cm_m0_h0_v006_eye1.fv2",
    faceFova=6,
  },
  {
    name="cm_m0_h0_v007_eye0.fv2",
    faceFova=7,
  },
  {
    name="cm_m0_h0_v008_eye0.fv2",
    faceFova=8,
  },
  {
    name="cm_m0_h0_v009_eye1.fv2",
    faceFova=9,
  },
  {
    name="cm_m0_h0_v010_eye0.fv2",
    faceFova=10,
  },
  {
    name="cm_m0_h0_v011_eye0.fv2",
    faceFova=11,
  },
  {
    name="cm_m0_h0_v012_eye1.fv2",
    faceFova=12,
  },
  {
    name="cm_m0_h0_v013_eye0.fv2",
    faceFova=13,
  },
  {
    name="cm_m0_h0_v014_eye1.fv2",
    faceFova=14,
  },
  {
    name="cm_m0_h0_v015_eye1.fv2",
    faceFova=15,
  },
  {
    name="cm_m0_h0_v016_eye1.fv2",
    faceFova=16,
  },
  {
    name="cm_m0_h0_v017_eye1.fv2",
    faceFova=17,
  },
  {
    name="cm_m0_h0_v018_eye0.fv2",
    faceFova=18,
  },
  {
    name="cm_m0_h1_v000_eye0.fv2",
    faceFova=19,
  },
  {
    name="cm_m0_h1_v001_eye0.fv2",
    faceFova=20,
  },
  {
    name="cm_m0_h1_v002_eye0.fv2",
    faceFova=21,
  },
  {
    name="cm_m0_h1_v003_eye0.fv2",
    faceFova=22,
  },
  {
    name="cm_m0_h1_v004_eye0.fv2",
    faceFova=23,
  },
  {
    name="cm_m0_h2_v000_eye0.fv2",
    faceFova=24,
  },
  {
    name="cm_m0_h2_v001_eye0.fv2",
    faceFova=25,
  },
  {
    name="cm_m0_h2_v002_eye0.fv2",
    faceFova=26,
  },
  {
    name="cm_svs0_head_z_eye0.fv2",
    description="Soviet Balaclava",
    faceFova=27,
  },
  {
    name="cm_pfs0_head_z_eye0.fv2",
    description="PF Balaclava",
    faceFova=28,
  },
  {
    name="cm_dds5_head_z_eye0.fv2",
    desciption="DD armor helmet (green top)",
    faceFova=29,
  },
  {
    name="cm_dds6_head_z_eye0.fv2",
    desciption="DD armor helmet (green top)",
    faceFova=30,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_dds3_eqhd1_eye0.fv2",
    description="DD Gas Mask and Balaclava",
    faceFova=31,
  },
  {
    name="cm_dds8_eqhd1_eye0.fv2",
    description="DD Gas Mask and Balaclava",
    faceFova=32,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_dds3_eqhd4_eye0.fv2",
    description="Gas mask DD helm",
    faceFova=33,
  },
  {
    name="cm_dds3_eqhd5_eye0.fv2",
    description="Gas mask DD greentop",
    faceFova=34,
  },
  {
    name="cm_dds8_eqhd2_eye0.fv2",
    description="Gas mask DD helm",
    faceFova=35,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_dds8_eqhd3_eye0.fv2",
    description="Gas mask DD greentop",
    faceFova=36,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_dds3_eqhd6_eye0.fv2",
    description="NVG DDgreentop",
    faceFova=37,
  },
  {
    name="cm_dds3_eqhd7_eye0.fv2",
    description="NVG DD greentop GasMask",
    faceFova=38,
  },
  {
    name="cm_dds8_eqhd6_eye0.fv2",
    description="NVG DD greentop",
    faceFova=39,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_dds8_eqhd7_eye0.fv2",
    description="NVG DD greentop GasMask",
    faceFova=40,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_unq_v000_eye1.fv2",
    faceFova=41,
  },
  {
    name="cm_unq_v001_eye1.fv2",
    faceFova=42,
  },
  {
    name="cm_unq_v002_eye0.fv2",
    faceFova=43,
  },
  {--unique all-in-one, also has hair.sim
    name="cm_unq_v003_eye1.fv2",
    description="Hideo",
    faceFova=44,
  },
  {
    name="cm_unq_v004_eye0.fv2",
    faceFova=45,
  },
  {
    name="cm_unq_v005_eye0.fv2",
    faceFova=46,
  },
  {
    name="cm_unq_v006_eye0.fv2",
    faceFova=47,
  },
  {
    name="cm_unq_v007_eye0.fv2",
    faceFova=48,
  },
  {
    name="cm_f0_h0_v000_eye0.fv2",
    faceFova=49,
  },
  {
    name="cm_f0_h0_v001_eye0.fv2",
    faceFova=50,
  },
  {
    name="cm_f0_h0_v002_eye0.fv2",
    faceFova=51,
  },
  {
    name="cm_f0_h0_v003_eye0.fv2",
    faceFova=52,
  },
  {
    name="cm_f0_h1_v000_eye0.fv2",
    faceFova=53,
  },
  {
    name="cm_f0_h1_v001_eye0.fv2",
    faceFova=54,
  },
  {
    name="cm_f0_h1_v002_eye0.fv2",
    faceFova=55,
  },
  {
    name="cm_f0_h2_v000_eye1.fv2",
    faceFova=56,
  },
  {
    name="cm_f0_h2_v001_eye0.fv2",
    faceFova=57,
  },
  {
    name="cm_f0_h2_v002_eye0.fv2",
    faceFova=58,
  },
}

this.faceDecoFovaInfo={
  {
    name="cm_w000_m.fv2",
    faceDecoFova=0,
  },
  {
    name="cm_w001_m.fv2",
    faceDecoFova=1,
  },
  {
    name="cm_w002_m.fv2",
    faceDecoFova=2,
  },
  {
    name="cm_w003_m.fv2",
    faceDecoFova=3,
  },
  {
    name="cm_w004_m.fv2",
    faceDecoFova=4,
  },
  {
    name="cm_w005_m.fv2",
    faceDecoFova=5,
  },
  {
    name="cm_w006_m.fv2",
    faceDecoFova=6,
  },
  {
    name="cm_w007_m.fv2",
    faceDecoFova=7,
  },
  {
    name="cm_w008_m.fv2",
    faceDecoFova=8,
  },
  {
    name="cm_w009_m.fv2",
    faceDecoFova=9,
  },
  {
    name="cm_w010_m.fv2",
    faceDecoFova=10,
  },
  {
    name="cm_w011_m.fv2",
    faceDecoFova=11,
  },
  {
    name="cm_w012_m.fv2",
    faceDecoFova=12,
  },
  {
    name="cm_w013_m.fv2",
    faceDecoFova=13,
  },
  {
    name="cm_w014_m.fv2",
    faceDecoFova=14,
  },
  {
    name="cm_w015_m.fv2",
    faceDecoFova=15,
  },
  {
    name="cm_w016_m.fv2",
    faceDecoFova=16,
  },
  {
    name="cm_w017_m.fv2",
    faceDecoFova=17,
  },
  {
    name="cm_w018_m.fv2",
    faceDecoFova=18,
  },
  {
    name="cm_w019_m.fv2",
    faceDecoFova=19,
  },
  {
    name="cm_b000_m.fv2",
    faceDecoFova=20,
  },
  {
    name="cm_b001_m.fv2",
    faceDecoFova=21,
  },
  {
    name="cm_b002_m.fv2",
    faceDecoFova=22,
  },
  {
    name="cm_b003_m.fv2",
    faceDecoFova=23,
  },
  {
    name="cm_b004_m.fv2",
    faceDecoFova=24,
  },
  {
    name="cm_b005_m.fv2",
    faceDecoFova=25,
  },
  {
    name="cm_b006_m.fv2",
    faceDecoFova=26,
  },
  {
    name="cm_b007_m.fv2",
    faceDecoFova=27,
  },
  {
    name="cm_b008_m.fv2",
    faceDecoFova=28,
  },
  {
    name="cm_b009_m.fv2",
    faceDecoFova=29,
  },
  {
    name="cm_b010_m.fv2",
    faceDecoFova=30,
  },
  {
    name="cm_y000_m.fv2",
    faceDecoFova=31,
  },
  {
    name="cm_y001_m.fv2",
    faceDecoFova=32,
  },
  {
    name="cm_y002_m.fv2",
    faceDecoFova=33,
  },
  {
    name="cm_y003_m.fv2",
    faceDecoFova=34,
  },
  {
    name="cm_w000_f.fv2",
    faceDecoFova=35,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  {
    name="cm_w001_f.fv2",
    faceDecoFova=36,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  {
    name="cm_w002_f.fv2",
    faceDecoFova=37,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  {
    name="cm_w003_f.fv2",
    faceDecoFova=38,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.BLACK,
  },
  {
    name="cm_b000_f.fv2",
    faceDecoFova=39,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.BLACK,
  },
  {
    name="cm_b001_f.fv2",
    faceDecoFova=40,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.BLACK,
  },
  {
    name="cm_b002_f.fv2",
    faceDecoFova=41,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.BLACK,
  },
  {
    name="cm_y000_f.fv2",
    faceDecoFova=42,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.ASIAN,
  },
  {
    name="cm_y001_f.fv2",
    faceDecoFova=43,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.ASIAN,
  },
  {
    name="cm_y002_f.fv2",
    faceDecoFova=44,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.ASIAN,
  },
  {
    name="sp_w000_m.fv2",
    faceDecoFova=45,
  },
  {
    name="sp_w001_m.fv2",
    faceDecoFova=46,
  },
  {
    name="sp_w002_m.fv2",
    faceDecoFova=47,
  },
  {
    name="sp_w003_m.fv2",
    faceDecoFova=48,
  },
  {
    name="sp_w004_m.fv2",
    faceDecoFova=49,
  },
  {
    name="sp_b000_m.fv2",
    faceDecoFova=50,
  },
  {
    name="sp_y000_m.fv2",
    faceDecoFova=51,
  },
  {
    name="sp_y001_m.fv2",
    faceDecoFova=52,
  },
  {
    name="sp_face_m000.fv2",
    faceDecoFova=53,
  },
  {
    name="sp_face_m001.fv2",
    faceDecoFova=54,
  },
  {
    name="sp_face_m002.fv2",
    faceDecoFova=55,
  },
  {
    name="sp_face_m003.fv2",
    faceDecoFova=56,
  },
  {--tatoo_foxhound
    name="sp_face_f000.fv2",
    faceDecoFova=57,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  {--tatoo_ddogemblem
    name="sp_face_f001.fv2",
    faceDecoFova=58,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.RED,
    race=this.RACE.CAUCASIAN,
  },
  {--tatoo_fox
    name="sp_face_f002.fv2",
    faceDecoFova=59,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  {--tattoo_whiteskull
    name="sp_face_f003.fv2",
    faceDecoFova=60,
    gender=this.GENDER.FEMALE,
    hairColor=this.HAIRCOLOR.WHITE,
    race=this.RACE.CAUCASIAN,
  },
}
this.faceDecoFovaInfo[EnemyFova.INVALID_FOVA_VALUE+1]={
  name="NO_FOVA",
  description="None",
  faceDecoFova=EnemyFova.INVALID_FOVA_VALUE,
}

this.hairFovaInfo={
  {
    name="cm_hair_c000.fv2",
    hairFova=0,
  },
  {
    name="cm_hair_c001.fv2",
    hairFova=1,
  },
  {
    name="cm_hair_c002.fv2",
    hairFova=2,
  },
  {
    name="cm_hair_c003.fv2",
    hairFova=3,
  },
  {
    name="cm_hair_c004.fv2",
    hairFova=4,
  },
  {
    name="cm_hair_c005.fv2",
    hairFova=5,
  },
  {
    name="sp_hair_c000.fv2",
    hairFova=6,
  },
  {
    name="cm_hair_c100.fv2",
    description="Bob",
    hairFova=7,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      10,
      17,
    },
  },
  {
    name="cm_hair_c101.fv2",
    description="Pixie",
    hairFova=8,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      11,
      22,
      24,
    },
  },
  {
    name="cm_hair_c102.fv2",
    description="Crop",
    hairFova=9,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      12,
      21,
      23,
    },
  },
  {
    name="cm_hair_c103.fv2",
    description="Ponytail bangs",
    hairFova=10,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      13,
    },
  },
  {
    name="cm_hair_c104.fv2",
    description="Ponytail parted",
    hairFova=11,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      14,
    },
  },
  {
    name="cm_hair_c105.fv2",
    description="Bun",
    hairFova=12,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      15,
    },
  },
  {
    name="cm_hair_c106.fv2",
    description="Afro-texured short",
    hairFova=13,
    gender=this.GENDER.FEMALE,
    hairDecoFovas={
      16,
    },
  },
  --tex unused?
  {
    name="cm_hair_c107.fv2",
    hairFova=14,
    gender=this.GENDER.FEMALE,
  },
}
this.hairFovaInfo[EnemyFova.INVALID_FOVA_VALUE+1]={
  name="NO_FOVA",
  description="None",
  hairFova=EnemyFova.INVALID_FOVA_VALUE,
}

this.hairDecoFovaInfo={
  {
    name="cm_hair_c000_c000.fv2",
    hairDecoFova=0,
  },
  {
    name="cm_hair_c000_c001.fv2",
    hairDecoFova=1,
  },
  {
    name="cm_hair_c000_c002.fv2",
    hairDecoFova=2,
  },
  {
    name="cm_hair_c000_c003.fv2",
    hairDecoFova=3,
  },
  {
    name="cm_hair_c001_c000.fv2",
    hairDecoFova=4,
  },
  {
    name="cm_hair_c001_c001.fv2",
    hairDecoFova=5,
  },
  {
    name="cm_hair_c002_c000.fv2",
    hairDecoFova=6,
  },
  {
    name="cm_hair_c003_c000.fv2",
    hairDecoFova=7,
  },
  {
    name="cm_hair_c004_c000.fv2",
    hairDecoFova=8,
  },
  {
    name="cm_hair_c005_c000.fv2",
    hairDecoFova=9,
  },
  {
    name="cm_hair_c100_c000.fv2",
    description="Blond",
    hairDecoFova=10,
    gender=this.GENDER.FEMALE,
    hairFova=7,
  },
  {
    name="cm_hair_c101_c000.fv2",
    description="Brown",
    hairDecoFova=11,
    hairFova=8,
    gender=this.GENDER.FEMALE,
  },
  {
    name="cm_hair_c102_c000.fv2",
    description="Dark brown",
    hairDecoFova=12,
    gender=this.GENDER.FEMALE,
    hairFova=9,
  },
  {
    name="cm_hair_c103_c000.fv2",
    description="Brown",
    hairDecoFova=13,
    gender=this.GENDER.FEMALE,
    hairFova=10,
  },
  {
    name="cm_hair_c104_c000.fv2",
    name="Brown",
    hairDecoFova=14,
    gender=this.GENDER.FEMALE,
    hairFova=11,
  },
  {
    name="cm_hair_c105_c000.fv2",
    description="Brown",
    hairDecoFova=15,
    gender=this.GENDER.FEMALE,
    hairFova=12,
  },
  {
    name="cm_hair_c106_c000.fv2",
    description="Dark brown",
    hairDecoFova=16,
    gender=this.GENDER.FEMALE,
    hairFova=13,
  },
  {
    name="cm_hair_c107_c000.fv2",
    description="Brown",
    hairDecoFova=17,
    gender=this.GENDER.FEMALE,
    hairFova=7,
  },
  {
    name="sp_hair_m000.fv2",
    hairDecoFova=18,
  },
  {
    name="sp_hair_m001.fv2",
    hairDecoFova=19,
  },
  {
    name="sp_hair_m002.fv2",
    hairDecoFova=20,
  },
  {
    name="sp_hair_f000.fv2",
    description="Green",
    hairDecoFova=21,
    gender=this.GENDER.FEMALE,
    hairFova=9,
  },
  {
    name="sp_hair_f001.fv2",
    description="Red",
    hairDecoFova=22,
    gender=this.GENDER.FEMALE,
    hairFova=8,
  },
  {
    name="sp_hair_f002.fv2",
    description="Auburn",
    hairDecoFova=23,
    gender=this.GENDER.FEMALE,
    hairFova=9,
  },
  {
    name="sp_hair_f003.fv2",
    description="White",
    hairDecoFova=24,
    gender=this.GENDER.FEMALE,
    hairFova=8,
  },
}
this.hairDecoFovaInfo[EnemyFova.INVALID_FOVA_VALUE+1]={
  name="NO_FOVA",
  description="None",
  hairDecoFova=EnemyFova.INVALID_FOVA_VALUE,
}

this.faceDefinitionParams=Tpp.Enum{
  "currentFaceId",
  "unknown1",
  "gender",
  "unknown2",
  "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
  "unknown3",
  "unknown4",
  "unknown5",
  "uiTextureName",
  "unknown6",
  "unknown7",
  "unknown8",
  "unknown9",
  "unknown10",
}


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
  --InfLog.PCall(function(bodies)--DEBUG
  InfMain.RandomSetToLevelSeed()
  local faceBags=this.BuildFaceBags(this.faceIds)
  local faces={}
  InfEneFova.inf_wildCardMaleFaceList={}
  InfEneFova.inf_wildCardFemaleFaceList={}
  local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT
  local categoryBag=this.GetCategoryBag(this.categoryChances,"MALE",{"UNCOMMON","UNIQUE"})
  for i=1,InfMain.MAX_WILDCARD_FACES-InfMain.numWildCardFemales do--SYNC numwildcards
    local faceId=this.RandomFaceId(faceBags,"MALE",categoryBag)
    table.insert(faces,{faceId,1,1,0})
    table.insert(InfEneFova.inf_wildCardMaleFaceList,faceId)
  end
  local categoryBag=this.GetCategoryBag(this.categoryChances,"FEMALE",{"COMMON","UNIQUE"})
  for i=1,InfMain.numWildCardFemales+1 do
    local faceId=this.RandomFaceId(faceBags,"FEMALE",categoryBag)
    table.insert(faces,{faceId,1,1,0})
    table.insert(InfEneFova.inf_wildCardFemaleFaceList,faceId)
  end
  --InfLog.PrintInspect(InfEneFova.inf_wildCardFemaleFaceList)--DEBUG
  TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}

  local locationName=InfMain.GetLocationName()

  this.wildCardFemaleSuitName=this.wildCardFemaleSuits[math.random(#this.wildCardFemaleSuits)]
  local bodyInfo=this.GetFemaleWildCardBodyInfo()
  if bodyInfo then
    if bodyInfo.bodyId then
      this.SetupBodies(bodyInfo.bodyId,bodies)
    end
    if bodyInfo.soldierSubType then
      local bodyIdTable=TppEnemy.bodyIdTable[bodyInfo.soldierSubType]
      if bodyIdTable then
        for powerType,bodyTable in pairs(bodyIdTable)do
          this.SetupBodies(bodyTable,bodies)
        end
      end
    end

    if bodyInfo.partsPath then
      TppSoldier2.SetExtendPartsInfo{type=1,path=bodyInfo.partsPath}
    end
  end

  local maleBodyTable=this.wildCardBodyTable[locationName]
  if maleBodyTable then
    this.SetupBodies(maleBodyTable,bodies)
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

this.faceModSlots={
  512,
  513,
}
this.currentFaceIdSlot=1
function this.ApplyFaceFova()
  if vars.playerType~=PlayerType.DD_MALE and vars.playerType~=PlayerType.DD_FEMALE then
    InfMenu.PrintLangId"setting_only_for_dd"
    return
  end

  local noFova=EnemyFova.INVALID_FOVA_VALUE
  local faceDefinitions=Soldier2FaceAndBodyData.faceDefinition

  --tex since the engine only applies face if vars.playerFaceId changes to a different id I'm just cyling between a couple of faceDefinition entries
  --index in faceDefinition


  local faceFova=Ivars.faceFovaDirect:Get()
  local faceDecoFova=Ivars.faceDecoFovaDirect:Get()
  local hairFova=Ivars.hairFovaDirect:Get()
  local hairDecoFova=Ivars.hairDecoFovaDirect:Get()
  local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

  local uiTextureName=""

  local unknown1=Ivars.faceFovaUnknown1:Get()
  local unknown2=Ivars.faceFovaUnknown2:Get()
  local unknown3=Ivars.faceFovaUnknown3:Get()
  local unknown4=Ivars.faceFovaUnknown4:Get()
  local unknown5=Ivars.faceFovaUnknown5:Get()
  local unknown6=Ivars.faceFovaUnknown6:Get()
  local unknown7=Ivars.faceFovaUnknown7:Get()
  local unknown8=Ivars.faceFovaUnknown8:Get()
  local unknown9=Ivars.faceFovaUnknown9:Get()
  local unknown10=Ivars.faceFovaUnknown10:Get()

  local currentSlotIndex=this.faceModSlots[this.currentFaceIdSlot]
  local currentFaceId=faceDefinitions[currentSlotIndex][1]

  local newFace={
    currentFaceId,
    unknown1,
    gender,
    unknown2,
    faceFova,
    faceDecoFova,
    hairFova,
    hairDecoFova,
    unknown3,
    unknown4,
    unknown5,
    uiTextureName,
    unknown6,
    unknown7,
    unknown8,
    unknown9,
    unknown10,
  }

  faceDefinitions[currentSlotIndex]=newFace

  --tex GOTCHA crashes after repeated calls, wouldnt really trust it even after one
  TppSoldierFace.SetFaceFovaDefinitionTable{table=faceDefinitions,uiTexBasePath="/Assets/tpp/ui/texture/StaffImage/"}

  vars.playerFaceId=currentFaceId

  if this.currentFaceIdSlot==1 then
    this.currentFaceIdSlot=2
  else
    this.currentFaceIdSlot=1
  end
end

function this.PrintFaceInfo(faceId)
  InfLog.PCall(function(faceId)--DEBUG
    for i,faceDef in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if faceDef[1]==faceId then
        local faceFova=faceDef[5]
        local faceDecoFova=faceDef[6]
        local hairFova=faceDef[7]
        local hairDecoFova=faceDef[8]
        local faceFovaInfo=InfEneFova.faceFovaInfo[faceFova+1]
        local faceDecoFovaInfo=InfEneFova.faceDecoFovaInfo[faceDecoFova+1]
        local hairFovaInfo=InfEneFova.hairFovaInfo[hairFova+1]
        local hairDecoFovaInfo=InfEneFova.hairDecoFovaInfo[hairDecoFova+1]

        InfLog.DebugPrint(
          string.format("faceId:%s, faceFova: %s, faceDecoFova: %s, hairFova: %s, hairDecoFova: %s",
            faceId,
            faceFovaInfo.name,
            faceDecoFovaInfo.name,
            hairFovaInfo.name,
            hairDecoFovaInfo.name))
        break
      end
  end
  end,faceId)--DEBUG
end

--In: bodyIds
--In/Out: bodies
local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT--==255
function this.SetupBodies(bodyIds,bodies)
  if bodyIds==nil then return end

  if type(bodyIds)=="number"then
    local bodyEntry={bodyIds,MAX_REALIZED_COUNT}
    bodies[#bodies+1]=bodyEntry
  elseif type(bodyIds)=="table"then
    for n,bodyId in ipairs(bodyIds)do
      local bodyEntry={bodyId,MAX_REALIZED_COUNT}
      bodies[#bodies+1]=bodyEntry
    end
  end
end

local allowHeavyArmorStr="allowHeavyArmor"
function this.ForceArmor(missionCode)
  if IvarProc.EnabledForMission(allowHeavyArmorStr,missionCode) then
    return true
  end
  --TODO either I got rid of this functionality at some point or I never implemented it (I could have sworn I did though), search in past versions
  --  if Ivars.allowLrrpArmorInFree:Is(1) and TppMission.IsFreeMission(missionCode) then
  --    return true
  --  end

  return false
end

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

return this
