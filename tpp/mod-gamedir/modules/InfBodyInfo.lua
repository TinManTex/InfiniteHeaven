--InfBodyInfo.lua
--tex used for IH soldier type change, but can be used as a reference to what game chara models are (mostly look at partsPath)

local this={}
--tex GOTCHA on MB max bodyids are currently interacting with MAX_STAFF_NUM_ON_CLUSTER somehow, above which will force all faces to headgear
-- ex
--  SOME_BODY={
--    bodyId={--tex if bodyId nil then will fall back to normal GetBodyId, if bodyId is a table (like this example) bodyId is chosen randomly
--      TppEnemyBodyId.dlf_enef0_def,
--      TppEnemyBodyId.dlf_enef1_def,
--    },
--    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
--    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR--tex this pack is essentially just the mis_com_mafr soldier pack
--    hasFace=true,--tex model includes it's own face so don't use fova face
--    hasArmor=true,--tex switches off armor at the config level (if false), for bodies that are mixed
--    isArmor=true,--tex switches armor on at the soldier config level, for bodies that are only armor
--    helmetOnly=true,--tex no gas mask or nvg.
--    hasHelmet=true,--tex indicator for DD headgear to not select gear markes as HELMET
--    soldierSubType="DD_FOB",
--    useDDHeadgear=true,--tex use DD headgear as balaclava/GetHeadGearForPowers system
--    noSkinTones=true,--tex body doesn't have different textures for skintones (a lot of models just sidestep this by not showing skin/having gloves), currently only as a note, no system acting on the value
--  },

this.bodyInfo={
  DRAB={--DDS, mother base default
    bodyId=TppEnemyBodyId.dds8_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds3_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  DRAB_FEMALE={--DDS, mother base default
    bodyId=TppEnemyBodyId.dds8_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  TIGER={--DDS, FOB default
    bodyId=TppEnemyBodyId.dds5_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts",--tex TODO also dds5_main0_v00?
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  TIGER_FEMALE={--DDS, FOB default
    bodyId=TppEnemyBodyId.dds6_main0_v00,
    partsPath="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts",--tex also dds6_main0_def_v00.parts?
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  FATIGUES_CAMO_MIX={
    --tex see GOTCHA above
    bodyId={
      406,
      407,
      408,
      409,
      410,

      411,
      412,
      413,
      414,
      415,

      416,
      417,
      418,
      419,
      420,

      421,
      422,
      423,
      --#18 - MAX_STAFF_NUM_ON_CLUSTER without additionalsoldiers
      424,
      425,

      426,
      427,
      428,
      429,
      430,

      431,
      432,
      433,
      434,
      435,

      436,
      437,
      438,
      439,
      440,
      --
      441,
    --#36 - MAX_STAFF_NUM_ON_CLUSTER with additionalsoldiers
    --      442,
    --      443,
    --      444,
    --      445,
    --
    --      446,
    --      447,
    --      448,
    --      449,
    --      450,
    --      451,
    --      452,
    --      453,
    --      454,
    --      455,
    --      456,
    --      457,
    --      458,
    },
    partsPath="/Assets/tpp/parts/chara/dds/dds3_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  --tex TODO fova not applying unlike males
  FATIGUES_CAMO_MIX_FEMALE={
    bodyId={
      459,
      460,
      461,
      462,
      463,

      464,
      465,
      466,
      467,
      468,

      469,
      470,
      471,
      472,
      473,

      474,
      475,
      476,
      477,
      478,

      479,
      480,
      481,
      482,
      483,

      484,
      485,
      486,
      487,
      488,

      489,
      490,
      491,
      492,
      493,

      494,
    ----
    --495,
    --496,
    --497,
    --498,
    --499,
    --500,
    --501,
    --502,
    --503,
    --504,
    --505,
    --506,
    --507,
    --508,
    --509,
    --510,
    --511,
    },

    partsPath="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  SNEAKING_SUIT={--DDS
    bodyId=TppEnemyBodyId.dds4_enem0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  SNEAKING_SUIT_FEMALE={--DDS
    bodyId=TppEnemyBodyId.dds4_enef0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  BATTLE_DRESS={--DDS
    bodyId=TppEnemyBodyId.dds5_enem0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  BATTLE_DRESS_FEMALE={--DDS
    bodyId=TppEnemyBodyId.dds5_enem0_def,
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  PFA_ARMOR={
    bodyId=TppEnemyBodyId.pfa0_v00_a,
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR--tex this pack is essentially just the mis_com_mafr soldier pack
    isArmor=true,
    helmetOnly=true,--tex no gas mask or nvg.
    hasArmor=true,
    soldierSubType="DD_FOB",
  },
  --prologue cyprus gasmask xof
  XOF_GASMASK={
    bodyId={
      --1,
      TppEnemyBodyId.wss0_main0_v00,--tex applies light in helmet effect?
    },
    partsPath="/Assets/tpp/parts/chara/wss/wss0_main0_def_v00_ih_sol.parts",
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_l01_fpkd
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/wss0_main0_mdl.fpk",
    },
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_CYPR",
    config={
      HELMET=true,
      GAS_MASK=true,
      NVG=false,
    },
  },
  WSS1_MAIN0={--tex soldier CRASH on loaded/soldier realize
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/wss/wss1_main0_def_v00_ih_sol.parts",
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s06_fpkd
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/wss1_main0_mdl.fpk",
    },
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_CYPR",
  },
  --GZ XOF, white helmet
  --tex imported from GZ
  XOF_GZ={
    bodyId=1, -- white helmets with blue bands, wet camo, ISSUE (included) face protudes goggles
    --NOTE: GZ has heaps of WSS2 fovas (f00>f19)
    partsPath="/Assets/tpp/parts/chara/wss/wss2_main0_def_v00_ih_sol.parts",
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s06_fpkd
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/wss2_main0_mdl.fpk",
    },
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_CYPR",
  },
  XOF={--tex Test: when XOF mission fpk loaded it stops salute morale from working?
    bodyId={
      --tex default = goggles down, green stripe back of helmet
      --1,
      TppEnemyBodyId.wss4_main0_v00,--mixed: clava only, helmet with goggles down, helmet with goggles up | gloves at side
    --tex Cant really tell any difference
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10070\s10070_d01_fpk\Assets\tpp\fova\chara\wss\wss4_main0_v01.fv2
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10070\s10070_d01_fpk\Assets\tpp\fova\chara\wss\wss4_main0_v02.fv2
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10150\s10150_d03_fpk\Assets\tpp\fova\chara\wss\wss4_main0_v01.fv2
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10150\s10150_d03_fpk\Assets\tpp\fova\chara\wss\wss4_main0_v02.fv2
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10151\s10151_d01_fpk\Assets\tpp\fova\chara\wss\wss4_main0_v01.fv2
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10151\s10151_d01_fpk\Assets\tpp\fova\chara\wss\wss4_main0_v02.fv2
    --411,--wss4_main0_v01
    --412,--wss4_main0_v02
    --TODO: TEST, intended for different fmdls, but some times get interesting results from shared textures/sub models
    --TppEnemyBodyId.wss0_main0_v00,
    --TppEnemyBodyId.wss3_main0_v00,
    --tex TODO seen different color stripes at back of helmet, but can't recall from which fova,
    },
    partsPath="/Assets/tpp/parts/chara/wss/wss4_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_xof_soldier.fpk",
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_AFGH",
    useDDHeadgear=true,
  },
  SOVIET_A={
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    soldierSubType="SOVIET_A",
    hasArmor=true,
  },
  SOVIET_B={
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    soldierSubType="SOVIET_B",
    hasArmor=true,
  },
  PF_A={
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="PF_A",
    hasArmor=true,
  },
  PF_B={
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="PF_B",
    hasArmor=true,
  },
  PF_C={
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="PF_C",
    hasArmor=true,
  },
  --TODO invisibleMeshNames in .parts files, check both tpp and gz .parts
  --TODO theres a bunch of other head modesl (check both tpp and gz, related to above?)
  MSF_GZ={--DDS0_MAIN0 - MSF PW, dirty, 25 on back
    --TODO: blinking troubles
    --TODO: GZ has dds0_v00.fova > dds0_v13.fova
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main0_def_v00_ih_sol.parts",
    --\chunk3_dat\Assets\tpp\pack\mission2\free\f30050\f30050_d8010_fpk\Assets\tpp\chara\dds\Scenes\dds0_main0_def.fmdl
    --\chunk3_dat\Assets\tpp\pack\mission2\free\f30050\f30050_d8040_fpk\Assets\tpp\chara\dds\Scenes\dds0_main0_def.fmdl
    --\chunk3_dat\Assets\tpp\pack\mission2\free\f30050\f30050_d8041_fpk\Assets\tpp\chara\dds\Scenes\dds0_main0_def.fmdl
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds0_main0_mdl.fpk",
    },
    hasFace=true,
  },
  --msf from s10115 retake plat
  MSF_TPP={--DDS0_MAIN1
    bodyId={
      TppEnemyBodyId.dds0_main1_v00,--140, TppEnemy.bodyIdTable.DD_PW
    --TppEnemyBodyId.dds0_main1_v01,--141, Mosquito
    },
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main1_def_v00_ih_sol.parts",
    --\chunk3_dat\Assets\tpp\pack\mission2\story\s10115\s10115_area_fpkd
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds0_main1_mdl.fpk",
    },
    hasFace=true,
  },
  --msf 'the medic' body used in Truth photo/heli crash flashback demos
  --no head, but has trouble with soldierface system, eyes missing
  MSF_MEDIC={--DDS0_MAIN2
    bodyId={
      --tex default/no set fova = no gloves
      1,
    --TODO: add to TppEnemyBodyId
    --surgical gloves, clean > increasing bloodyness
    --      406,--dds0_main2_v01
    --      407,--dds0_main2_v02
    --      408,--dds0_main2_v04
    --      409,--dds0_main2_v05
    },
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main2_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds0_main2_mdl.fpk",
    },
  },
  --DD pilot 1 - with balaclava/ RIP Morpho, imported from GZ -- soldier CRASH on loaded/soldier realize
  DDS_PILOT1={--DDS1_MAIN0
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/dds/dds1_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds1_main0_mdl.fpk",
    },
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10280\s10280_d14_fpkd\Assets\tpp\parts\chara\dds\dds1_main0_def_v00.parts
    hasFace=true,
  },
  --msf kojima, imported from GZ
  --TODO: gz has dds2_main0_def_v00.parts, dds2_main0_def_v01.parts which adds differen head models via ConnectModelDescription
  --TODO: also hair sim.
  MSF_KOJIMA={--DDS2_MAIN0
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/dds/dds2_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds2_main0_mdl.fpk",
    },
    hasFace=true,
  },
  --tex ground crew - yellow dude that marshals helis with his light sticks in a couple of cutscenes
  --TODO: had head but not face covering, so need to make sure hair is off
  --also side of face covering designed for this faces guys, wide cheeks push through the geometry
  --ISSUE: soldier CRASH on loading
  DDS_GROUNDCREW={--DDS4_MAIN0
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/dds/dds4_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds4_main0_mdl.fpk",
    },
    hasFace=true,--tex TODO but overriding seems fine/cant see any contention for many faces
    noSkinTones=true,
  },
  --DD pilot 2 - with face/Pequad
  DDS_PILOT2={--DDS9_MAIN0
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/dds/dds9_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/dds9_main0_mdl.fpk",
    },
    --\chunk2_dat\Assets\tpp\pack\mission2\heli\h40010\h40010_area_fpkd
    hasFace=true,
  },
  MSF_SVS={--Wandering soldier msf
    --GOTCHA pfs and svs swapped due to retailbug, see TppEnemyBodyId/Soldier2FaceAndBodyData
    bodyId=TppEnemyBodyId.pfs0_dds0_v00,--tex even though there's a lot more BodyId/Soldier2FaceAndBodyData entries, they're all identical/the same fova
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    soldierSubType="DD_FOB",
  },
  MSF_PFS={--Wandering soldier msf
    bodyId=TppEnemyBodyId.svs0_dds0_v00,--tex as above
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
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
  PRISONER_AFGH_FEMALE={
    partsPath="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00.parts",
  --\chunk1_dat\Assets\tpp\pack\mission2\quest\extra\quest_q20025_fpkd
  --and in bunch of other quest fpkds
  },
  --10040 : Mission 6 - Where Do the Bees Sleep Hamid prisoner
  PRISONER_4={
    partsPath="/Assets/tpp/parts/chara/prs/prs4_main0_def_v00.parts",
  --\chunk2_dat\Assets\tpp\pack\mission2\story\s10040\s10040_area_fpkd
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
  --Kojima prisoner DD tiger body - sideop q99080 Intel Agent Extraction
  --partsPath="/Assets/tpp/parts/chara/prs/prs7_main0_def_v00.parts",
  --\chunk2_dat\Assets\tpp\pack\mission2\quest\afgh\cliffTown\cliffTown_q99080_fpkd

  --PRISONER_DD ??
  --\Assets\tpp\parts\chara\prs\pdd5_main0_def_v00.parts
  --Mission 22 - Retake the Platform
  --\chunk3_dat\Assets\tpp\pack\mission2\story\s10115\s10115_area_fpkd
  --Mission 17 - Rescue the Intel Agents
  --\chunk4_dat\Assets\tpp\pack\mission2\story\s10091\s10091_area_fpkd

  --Doctors
  --TODO fv2s
  --dct1_v00
  --dct1_v01
  --dct2_v00
  --dct2_v01
  --dct2_v02
  DOCTOR_0={
    bodyId={
      -- fv2s are different faces,
      -- even if head mesh was hidden with custom fv2 the normal soldier faces neck stick through this bodies collar.
      348,--dct0_v00
      349,--dct0_v01
    },
    partsPath="/Assets/tpp/parts/chara/dct/dct0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/ih/ih_doctor.fpk",
    hasFace=true,
    noSkinTones=true,--tex no skin tone support/only white
  },
  DOCTOR_1={
    partsPath="/Assets/tpp/parts/chara/dct/dct1_main0_def_v00.parts",
    noSkinTones=true,--tex no skin tone support/only white
  },
  --tex crash, the file packs are very incomplete from a character standpoint
  DOCTOR_2={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/dct/dct2_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  --nurses
  --nrs0_main0_def_v00
  --\chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s02_fpkd
  --nrs1_main0_def_v00
  --\chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s02_fpkd
  --nrs2_main0_def_v00
  --\chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s02_fpkd
  --tex crash
  NURSE_3_FEMALE={
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
  --prologue hospital patients
  PATIENT={
    --TODO has a whole bunch of fv2s
    partsPath="/Assets/tpp/parts/chara/ptn/ptn0_main0_def_v00.parts",
    --\chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s03_fpkd
    hasFace=true,
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
  --kaz1_main0_def_v00.parts
  --\chunk0_dat\Assets\tpp\pack\mission2\story\s10280\s10280_d12_fpkd
  --kaz2_main0_def_v00.parts
  --\chunk2_dat\Assets\tpp\pack\mission2\story\s10020\s10020_area_fpkd
  --\chunk3_dat\Assets\tpp\pack\mission2\story\s10030\s10030_area_fpkd
  --tex no walk, or hit collision target. crash on cqc down
  --mb Kaz - coat and hat
  KAZ={
    bodyId=1,--tex no bodyId entries, so just using 1 since my code does an if bodyId check TODO see if there's any fovas elsewhere
    partsPath="/Assets/tpp/parts/chara/kaz/kaz0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_miller.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  --tex crashes
  KAZ_GZ={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/kaz/kaz1_main1_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_miller_gz.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  OCELOT_0={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/oce/oce0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/free/f30050/f30050_ocelot.fpk",
    hasFace=true,
  },
  OCELOT_1={
    partsPath="/Assets/tpp/parts/chara/oce/oce1_main0_def_v00.parts",
    --\chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s07_fpkd
    --\chunk2_dat\Assets\tpp\pack\mission2\story\s10020\s10020_d01_fpkd
    hasFace=true,
  },
  PAZ_GZ={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/paz/paz0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_paz_gz.fpk",
    hasFace=true,
  },
  PAZ={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/paz/paz1_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/free/f30050/f30050_paz.fpk",
    hasFace=true,
  },
  --quiet
  --  qui0_main0_def_v00.parts
  --  qui0_main1_def_v00.parts
  --  qui1_main0_def_v00.parts
  --  qui2_main0_def_v00.parts
  --  qui3_main0_def_v00.parts
  --  qui4_main0_def_v00.parts
  --  qui5_main0_def_v00.parts
  --volgin
  --vol0_main0_def_v00.parts
  --vol1_main0_def_v00.parts

  --vol2_main0_def_v00.parts

  --Skulls/parasite unit
  --wmu0_main0_def_v00.parts
  --wmu1_main0_def_v00.parts
  --wmu3_main0_def_v00.parts
  --tex lab coat and red id tag, used in epidemic/quarantine
  --also some dds drab since it's used in shining lights
  DD_RESEARCHER={
    bodyId={
      1,
    --REF
    --dd researcher/labcoat male
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--63,146,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--64,147,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v02.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--65,148,,
    --
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--66,149,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--67,150,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v02.fv2",""},--68,151,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v03.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--69,152,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v04.fv2","/Assets/tpp/pack/fova/chara/dds/ddr0_main0_v00.fpk"},--70,153,,
    --  --female
    --  {"/Assets/tpp/fova/chara/dds/ddr1_main0_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--71,154,,
    --  {"/Assets/tpp/fova/chara/dds/ddr1_main0_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--72,155,,
    --  {"/Assets/tpp/fova/chara/dds/ddr1_main0_v02.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--73,156,,
    --
    --  {"/Assets/tpp/fova/chara/dds/ddr1_main1_v00.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--74,157,,
    --  {"/Assets/tpp/fova/chara/dds/ddr1_main1_v01.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--75,158,,
    --  {"/Assets/tpp/fova/chara/dds/ddr1_main1_v02.fv2","/Assets/tpp/pack/fova/chara/dds/ddr1_main0_v00.fpk"},--76,159,,


    --  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v03.fv2",""},--83,166,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main0_v04.fv2",""},--84,167,,
    --
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v05.fv2",""},--85,168,,
    --  {"/Assets/tpp/fova/chara/dds/ddr0_main1_v06.fv2",""},--86,169,,

    --TppEnemyBodyId.ddr0_main0_v00,--default clean lab coat, ocasionally lab goggles
    --TppEnemyBodyId.ddr0_main0_v01,--dds DRAB
    --TppEnemyBodyId.ddr0_main0_v02,--dds tiger
    --TppEnemyBodyId.ddr0_main0_v03,
    --TppEnemyBodyId.ddr0_main0_v04,
    },
    partsPath="/Assets/tpp/parts/chara/dds/ddr0_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/ddr0_main0_mdl.fpk",
    },
    noSkinTones=true,
  },
  DD_RESEARCHER_FEMALE={
    bodyId=1,--tex TODO
    partsPath="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/ddr1_main0_mdl.fpk",
    },
    noSkinTones=true,
  },
  CODETALKER={
    partsPath="/Assets/tpp/parts/chara/cdt/cdt0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_codetalker.fpk",
    hasFace=true,
  },
  CHICO_GZ={
    partsPath="/Assets/tpp/parts/chara/chi/chi1_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_chico_gz.fpk",
    hasFace=true,
  },
  ISHMAEL={
    partsPath="/Assets/tpp/parts/chara/ish/ish0_main0_def_v00.parts",
    hasFace=true,
  },
  -- kids
  --  chd0_main0_def_v00.parts
  --missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_child_soldier.fpk",--chd0 only
  --  chd1_main0_def_v00.parts
  --  chd2_main0_def_v00.parts
  --voices mission infected prisoners i think
  --plh0_main0_def_v00.parts
  --plh2_main0_def_v00.parts
  --plh3_main0_def_v00.parts
  GENOME_SOLDIER={
    bodyId=1,
    partsPath="/Assets/tpp/parts/chara/gns/gns0_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",
      "/Assets/tpp/pack/mission2/ih/gns0_main0_mdl.fpk",
    },
    soldierSubType="DD_FOB",
    hasFace=true,
    hasHelmet=true,
  },
}

return this
