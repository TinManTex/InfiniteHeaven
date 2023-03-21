--InfBodyInfo.lua
--tex used to define soldier body info for IH soldier type change (via customSoldierType option) or addon missions (TODO actually document how to do so)

--bodyInfo table can be used as a reference if you want to look up what game chara models are (mostly look at partsPath)

--Also handles \mod\bodyInfo\ addons.

--Actual implementation scattered across 
--InfEneFova 
--InfSoldierFaceAndBody - adds bodyIdNames/bodyIds to Soldier2FaceAndBodyData via fovaInfo addons
--search InfBodyInfo, InfEneFova.GetMaleBodyInfo for uses of bodyInfo



--GOTCHA: note from Warm Wallaby: option hasFace disable notification about staff morale (on MTBS) because game treat soldier like a enemy (soldiers doen't have face fova)
--https://discord.com/channels/364177293133873153/364177950805065732/902560368314961970
--TODO: document how hasface/balaclavaIds work

--tex LIMIT DEBUGNOW GOTCHA on MB max bodyids are currently interacting with MAX_STAFF_NUM_ON_CLUSTER somehow, above which will force all faces to headgear

local this={}

this.debugModule=false

--REF bodyInfo addon, just an all parameters rather than valid example
--this={
--  infoType="BODYINFO",
--  name="SOME_ENEMY",--bodyType id, automatically set using addon file name
--  description="Body name for menu",
--  --tex new bodyIds are added by fovaInfo addons with bodyFova, bodyDefinition entries. See InfSoldierFaceAndBody
--  --tex if bodyId nil then will fall back to normal GetBodyId (which relies on soldierSubType),
--  --if bodyIds is an array (like this example) bodyId is chosen randomly
--  --NOTE: old bodyInfo version has bodyIds={TppEnemyBodyId.pfs0_rfl_v01_a,} etc, where the TppEnemyBodyId bodyId entries are numbers not strings. 
--  bodyIdNames={
--    "pfs0_rfl_v00_a",
--    "pfa0_v00_c",
--    "pfs0_unq_v210",
--  },--bodyIds
--  --TppEnemy.bodyIdTable style table, NOTE: if using this don't need the above bodyIdNames (as it will be built from bodyIdTable anyway)
--  bodyIdTable={
--tex hope to eventually support multiple subTypes per body like the base game does, but for now just one entry as the bodyInfo name
--    SOME_ENEMY={
--      ASSAULT={TppEnemyBodyId.pfs0_rfl_v00_a,TppEnemyBodyId.pfs0_mcg_v00_a},
--      ASSAULT_OB={TppEnemyBodyId.pfs0_rfl_v00_a,TppEnemyBodyId.pfs0_rfl_v01_a,TppEnemyBodyId.pfs0_mcg_v00_a},
--      SNIPER={TppEnemyBodyId.pfs0_snp_v00_a},
--      SHOTGUN={TppEnemyBodyId.pfs0_rfl_v00_a},
--      SHOTGUN_OB={TppEnemyBodyId.pfs0_rfl_v00_a,TppEnemyBodyId.pfs0_rfl_v01_a},
--      MG={TppEnemyBodyId.pfs0_mcg_v00_a},
--      MISSILE={TppEnemyBodyId.pfs0_rfl_v00_a},
--      SHIELD={TppEnemyBodyId.pfs0_rfl_v00_a},
--      ARMOR={TppEnemyBodyId.pfa0_v00_b},
--      RADIO={TppEnemyBodyId.pfs0_rdo_v00_a}
--    },
--DEBUGNOW
--    SOME_ENEMY_A={
--      ASSAULT={TppEnemyBodyId.pfs0_rfl_v00_a,TppEnemyBodyId.pfs0_mcg_v00_a},
--      ASSAULT_OB={TppEnemyBodyId.pfs0_rfl_v00_a,TppEnemyBodyId.pfs0_rfl_v01_a,TppEnemyBodyId.pfs0_mcg_v00_a},
--      SNIPER={TppEnemyBodyId.pfs0_snp_v00_a},
--      SHOTGUN={TppEnemyBodyId.pfs0_rfl_v00_a},
--      SHOTGUN_OB={TppEnemyBodyId.pfs0_rfl_v00_a,TppEnemyBodyId.pfs0_rfl_v01_a},
--      MG={TppEnemyBodyId.pfs0_mcg_v00_a},
--      MISSILE={TppEnemyBodyId.pfs0_rfl_v00_a},
--      SHIELD={TppEnemyBodyId.pfs0_rfl_v00_a},
--      ARMOR={TppEnemyBodyId.pfa0_v00_b},
--      RADIO={TppEnemyBodyId.pfs0_rdo_v00_a}
--    },
--    SOME_ENEMY_B={
--      ASSAULT={TppEnemyBodyId.pfs0_rfl_v00_b,TppEnemyBodyId.pfs0_mcg_v00_b},
--      ASSAULT_OB={TppEnemyBodyId.pfs0_rfl_v00_b,TppEnemyBodyId.pfs0_rfl_v01_b,TppEnemyBodyId.pfs0_mcg_v00_b},
--      SNIPER={TppEnemyBodyId.pfs0_snp_v00_b},
--      SHOTGUN={TppEnemyBodyId.pfs0_rfl_v00_b},
--      SHOTGUN_OB={TppEnemyBodyId.pfs0_rfl_v00_b,TppEnemyBodyId.pfs0_rfl_v01_b},
--      MG={TppEnemyBodyId.pfs0_mcg_v00_b},
--      MISSILE={TppEnemyBodyId.pfs0_rfl_v00_b},
--      SHIELD={TppEnemyBodyId.pfs0_rfl_v00_b},
--      ARMOR={TppEnemyBodyId.pfa0_v00_a},
--      RADIO={TppEnemyBodyId.pfs0_rdo_v00_b}
--    },
--    SOME_ENEMY_C={
--      ASSAULT={TppEnemyBodyId.pfs0_rfl_v00_c,TppEnemyBodyId.pfs0_mcg_v00_c},
--      ASSAULT_OB={TppEnemyBodyId.pfs0_rfl_v00_c,TppEnemyBodyId.pfs0_rfl_v01_c,TppEnemyBodyId.pfs0_mcg_v00_c},
--      SNIPER={TppEnemyBodyId.pfs0_snp_v00_c},
--      SHOTGUN={TppEnemyBodyId.pfs0_rfl_v00_c},
--      SHOTGUN_OB={TppEnemyBodyId.pfs0_rfl_v00_c,TppEnemyBodyId.pfs0_rfl_v01_c},
--      MG={TppEnemyBodyId.pfs0_mcg_v00_c},
--      MISSILE={TppEnemyBodyId.pfs0_rfl_v00_c},
--      SHIELD={TppEnemyBodyId.pfs0_rfl_v01_c},
--      ARMOR={TppEnemyBodyId.pfa0_v00_c},
--      RADIO={TppEnemyBodyId.pfs0_rdo_v00_c}
--    },
--    SOME_ENEMY_D={
--      ASSAULT={TppEnemyBodyId.pfs0_rfl_v00_b,TppEnemyBodyId.pfs0_mcg_v00_b},
--      ASSAULT_OB={TppEnemyBodyId.pfs0_rfl_v00_b,TppEnemyBodyId.pfs0_rfl_v01_b,TppEnemyBodyId.pfs0_mcg_v00_b},
--      SNIPER={TppEnemyBodyId.pfs0_snp_v00_c},
--      SHOTGUN={TppEnemyBodyId.pfs0_rfl_v00_c},
--      SHOTGUN_OB={TppEnemyBodyId.pfs0_rfl_v00_c,TppEnemyBodyId.pfs0_rfl_v01_c},
--      MG={TppEnemyBodyId.pfs0_mcg_v00_c},
--      MISSILE={TppEnemyBodyId.pfs0_rfl_v00_c},
--      SHIELD={TppEnemyBodyId.pfs0_rfl_v00_b},
--      ARMOR={TppEnemyBodyId.pfa0_v00_c},
--      RADIO={TppEnemyBodyId.pfs0_rdo_v00_c}
--    },
--  },--bodyIdTable
--  soldierType="DD",--base game EnemyType "TYPE_", since there's still a lot of things tied up to the base games values DEBUGNOW TODO implement and document
--  soldierSubType="DD_FOB",--tex base game subType, since there's still a lot of things tied up to the base games values DEBUGNOW TODO document what
--  --tex map your own soldier(Sub)Types to baseType
--  --TODO actually implement
--  --tex maybe someday you'll be able to use body subtypes at a higher level, till then the way to use them is by mapping the existing types
--  subTypeForBaseType={
--    SOVIET_A="SOME_ENEMY_A",
--    SOVIET_B="SOME_ENEMY_B",
--    PF_A="SOME_ENEMY_B",
--    PF_B="SOME_ENEMY_B",
--    PF_C="SOME_ENEMY_B",
--    DD_A="SOME_ENEMY_D",
--    DD_FOB="SOME_ENEMY_C",
--    DD_PW="SOME_ENEMY_B",
--    SKULL_CYPR="SOME_ENEMY_D",
--    SKULL_AFGH="SOME_ENEMY_B",
--  },--subTypeToBaseType
--  partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00_ih_sol.parts",--tex parts for soldier base, usually matches a vanilla .parts (minus the _ih_sol suffix)
--  partsPathHostage="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00_ih_hos.parts",--tex parts for hostage base
--  missionPackPath={
--    "BASE_PACK",--tex indicator for certain get body info functions to use base pack, so your addon pack can just include the model and be smaller than the base games soldier packs
--    -- uses "/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk" for soldier
--    -- and  "/Assets/tpp/pack/mission2/ih/ih_hostage_base.fpk" for hostage
--    "/Assets/tpp/pack/mission2/ih/pfs0_main0_def_mdl.fpk",
--  },
--  missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_pf.fpk",--alternate to the above, just a full base game style pack
--  hasFace=true,--tex model includes it's own face so don't use fova face
--  hasArmor=true,--tex switches off armor at the config level (if false), for bodies that are mixed
--  isArmor=true,--tex switches armor on at the soldier config level, for bodies that are only armor
--  helmetOnly=true,--tex no gas mask or nvg.
--  hasHelmet=true,--tex indicator for DD headgear to not select gear markes as HELMET
--  useDDHeadgear=true,--tex use DD headgear as balaclava/GetHeadGearForPowers system
--  noSkinTones=true,--tex body doesn't have different textures for skintones (a lot of models just sidestep this by not showing skin/having gloves), currently only as a note, no system acting on the value
--  --DEBUGNOW DOCUMENT, how does this interact with the above settings?
--  config={
--    HELMET=true,
--    GAS_MASK=true,
--    NVG=false,
--  },
--}

--IH entries, addon system adds to this table
this.bodyInfo={
  OFF={},--KLUDGE for ivar
  RANDOM={},--KLUDGE for ivar
  DRAB={--DDS, mother base default
    description="Fatigues - Drab",
    bodyIds={TppEnemyBodyId.dds3_main0_v00},
    partsPath="/Assets/tpp/parts/chara/dds/dds3_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  DRAB_FEMALE={--DDS, mother base default
    description="Fatigues - Drab",
    gender="FEMALE",
    bodyIds={TppEnemyBodyId.dds8_main0_v00},
    partsPath="/Assets/tpp/parts/chara/dds/dds8_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_wait.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_WAIT
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  TIGER={--DDS, FOB default
    description="Fatigues - Tiger",
    bodyIds={TppEnemyBodyId.dds5_main0_v00},
    partsPath="/Assets/tpp/parts/chara/dds/dds5_enem0_def_v00.parts",
    --TODO from 10115 partsPathHostage="/Assets/tpp/parts/chara/dds/dds5_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  TIGER_FEMALE={--DDS, FOB default
    description="Fatigues - Tiger",
    gender="FEMALE",
    bodyIds={TppEnemyBodyId.dds6_main0_v00},
    partsPath="/Assets/tpp/parts/chara/dds/dds6_enef0_def_v00.parts",--tex also dds6_main0_def_v00.parts?
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_attack.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ATTACKER
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  SNEAKING_SUIT={--DDS
    description="Sneaking suit",
    bodyIds={TppEnemyBodyId.dds4_enem0_def},
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  SNEAKING_SUIT_FEMALE={--DDS
    description="Sneaking suit",
    gender="FEMALE",
    bodyIds={TppEnemyBodyId.dds4_enef0_def},
    partsPath="/Assets/tpp/parts/chara/sna/sna4_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_sneak.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SNEAKING
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  BATTLE_DRESS={--DDS
    description="Battle Dress",
    bodyIds={TppEnemyBodyId.dds5_enem0_def},
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
  },
  BATTLE_DRESS_FEMALE={--DDS
    description="Battle Dress",
    gender="FEMALE",
    bodyIds={TppEnemyBodyId.dds5_enem0_def},
    partsPath="/Assets/tpp/parts/chara/sna/sna5_enef0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_btdrs.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_BTRDRS
    soldierSubType="DD_FOB",
    useDDHeadgear=true,
    config={
      ARMOR=true,
    },
  },
  PFA_ARMOR={--CULL, use PFS > PFA fova instead? or keep this as lighter resource option?
    description="PF Riot Suit",
    bodyIds={TppEnemyBodyId.pfa0_v00_a},
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_armor.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_ARMOR--tex this pack is essentially just the mis_com_mafr soldier pack
    isArmor=true,
    helmetOnly=true,--tex no gas mask or nvg.
    hasArmor=true,
    soldierSubType="DD_FOB",
    config={
      ARMOR=true,
    },
  },
  --prologue cyprus gasmask xof
  XOF_GASMASK={
    description="XOF - Gasmask",
    bodyIds={
      --1,
      TppEnemyBodyId.wss0_main0_v00,--tex applies light in helmet effect?
    },
    partsPath="/Assets/tpp/parts/chara/wss/wss0_main0_def_v00_ih_sol.parts",
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_l01_fpkd
    missionPackPath={
      "BASE_PACK",
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
    --bodyIds={1},
    partsPath="/Assets/tpp/parts/chara/wss/wss1_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/wss/wss1_main0_def_v00_ih_hos.parts",
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s06_fpkd
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/wss1_main0_mdl.fpk",
    },
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_CYPR",
  },
  --GZ XOF, white helmet
  --tex imported from GZ
  XOF_GZ={
    description="XOF - GZ",
    --no bodyid = white helmets with blue bands, wet camo, ISSUE (included) face protudes goggles
    -- bodyIds={1},--TODO. using non applicable bodyid so it doesnt fall back to SKULL_CYPR table DEBUGNOW see if ssd model better, create fova
    --NOTE: GZ has heaps of WSS2 fovas (f00>f19)
    partsPath="/Assets/tpp/parts/chara/wss/wss2_main0_def_v00_ih_sol.parts",
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s06_fpkd
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/wss2_main0_mdl.fpk",
    },
    hasFace=true,
    hasHelmet=true,
    soldierSubType="SKULL_CYPR",
  },
  XOF={--tex Test: when XOF mission fpk loaded it stops salute morale from working?
    description="XOF",
    bodyIds={
      --tex default = goggles down, green stripe back of helmet
      --1,
      TppEnemyBodyId.wss4_main0_v00,--mixed: clava only, helmet with goggles down, helmet with goggles up | gloves at side
    --tex Cant really tell any difference DEBUGNOW check out in foxkit
    --DEBUGNOW some of the body entries have empty fpks
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
    description="Soviet",
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    soldierSubType="SOVIET_A",
    hasArmor=true,
  },
  SOVIET_B={
    description="Soviet - Urban",
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    soldierSubType="SOVIET_B",
    hasArmor=true,
  },
  PF_A={
    description="PF - CFA",
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="PF_A",
    hasArmor=true,
  },
  PF_B={
    description="PF - ZRS",
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="PF_B",
    hasArmor=true,
  },
  PF_C={
    description="PF - Rogue Coyote",
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="PF_C",
    hasArmor=true,
  },
  --TODO invisibleMeshNames in .parts files, check both tpp and gz .parts
  --TODO theres a bunch of other head modesl (check both tpp and gz, related to above?)
  MSF_GZ={--DDS0_MAIN0 - MSF PW, dirty, 25 on back
    description="MSF - GZ",
    --TODO: blinking troubles
    --TODO: GZ has dds0_v00.fova > dds0_v13.fova
    --bodyIds={},
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/dds0_main0_def_v00_ih_hos.parts",
    --\chunk3_dat\Assets\tpp\pack\mission2\free\f30050\f30050_d8010_fpk\Assets\tpp\chara\dds\Scenes\dds0_main0_def.fmdl
    --\chunk3_dat\Assets\tpp\pack\mission2\free\f30050\f30050_d8040_fpk\Assets\tpp\chara\dds\Scenes\dds0_main0_def.fmdl
    --\chunk3_dat\Assets\tpp\pack\mission2\free\f30050\f30050_d8041_fpk\Assets\tpp\chara\dds\Scenes\dds0_main0_def.fmdl
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds0_main0_mdl.fpk",
    },
    hasFace=true,
  },
  --msf from s10115 retake plat
  --TODO no eyes for hostage? check sol again too (if thats ok then maybe need to apply bodyid to hostage?)
  MSF_TPP={--DDS0_MAIN1
    description="MSF - TPP",
    bodyIds={
      TppEnemyBodyId.dds0_main1_v00,--140, TppEnemy.bodyIdTable.DD_PW
    --TppEnemyBodyId.dds0_main1_v01,--141, Mosquito
    },
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main1_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/dds0_main1_def_v00_ih_hos.parts",
    --\chunk3_dat\Assets\tpp\pack\mission2\story\s10115\s10115_area_fpkd
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds0_main1_mdl.fpk",
    },
    hasFace=true,
  },
  --msf 'the medic' body used in Truth photo/heli crash flashback demos
  --no head, but has trouble with soldierface system, eyes missing
  MSF_MEDIC={--DDS0_MAIN2
    bodyIds={
    --tex default/no set fova = no gloves
    --1,--TODO need a no-fova
    --TODO: add to TppEnemyBodyId
    --surgical gloves, clean > increasing bloodyness
    --      406,--dds0_main2_v01
    --      407,--dds0_main2_v02
    --      408,--dds0_main2_v04
    --      409,--dds0_main2_v05
    },
    partsPath="/Assets/tpp/parts/chara/dds/dds0_main2_def_v00_ih_sol.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds0_main2_mdl.fpk",
    },
  },
  --DD pilot 1 - with balaclava/ RIP Morpho, imported from GZ -- soldier CRASH on loaded/soldier realize
  DDS_PILOT1={--DDS1_MAIN0
    --bodyIds={},
    partsPath="/Assets/tpp/parts/chara/dds/dds1_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/dds1_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds1_main0_mdl.fpk",
    },
    --REF \chunk0_dat\Assets\tpp\pack\mission2\story\s10280\s10280_d14_fpkd\Assets\tpp\parts\chara\dds\dds1_main0_def_v00.parts
    hasFace=true,
  },
  --msf kojima, imported from GZ
  --TODO: gz has dds2_main0_def_v00.parts, dds2_main0_def_v01.parts which adds differen head models via ConnectModelDescription
  --TODO: also hair sim.
  MSF_KOJIMA={--DDS2_MAIN0
    partsPath="/Assets/tpp/parts/chara/dds/dds2_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds2_main0_mdl.fpk",
    },
    hasFace=true,
  },
  --tex ground crew - yellow dude that marshals helis with his light sticks in a couple of cutscenes
  --TODO: had head but not face covering, so need to make sure hair is off
  --also side of face covering designed for this faces guys, wide cheeks push through the geometry
  --ISSUE: soldier CRASH on loading
  DDS_GROUNDCREW={--DDS4_MAIN0
    --bodyIds={1},
    partsPath="/Assets/tpp/parts/chara/dds/dds4_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/dds4_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds4_main0_mdl.fpk",
    },
    hasFace=true,--tex TODO but overriding seems fine/cant see any contention for many faces
    noSkinTones=true,
  },
  --DD pilot 2 - with face/Pequad
  DDS_PILOT2={--DDS9_MAIN0
    --bodyIds={},
    partsPath="/Assets/tpp/parts/chara/dds/dds9_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/dds9_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dds9_main0_mdl.fpk",
    },
    --\chunk2_dat\Assets\tpp\pack\mission2\heli\h40010\h40010_area_fpkd
    hasFace=true,
  },
  MSF_SVS={--Wandering soldier msf
    --GOTCHA pfs and svs swapped due to retailbug, see TppEnemyBodyId/Soldier2FaceAndBodyData
    bodyIds={TppEnemyBodyId.pfs0_dds0_v00},--tex even though there's a lot more BodyId/Soldier2FaceAndBodyData entries, they're all identical/the same fova
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
    soldierSubType="DD_FOB",
  },
  MSF_PFS={--Wandering soldier msf
    bodyIds={TppEnemyBodyId.svs0_dds0_v00},--tex as above
    partsPath="/Assets/tpp/parts/chara/pfs/pfs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_mafr.fpk",
    soldierSubType="DD_FOB",
  },
  SOVIET_BERETS={
    description="Soviet - Berets",
    bodyIds={
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
    description="Soviet - Hoodies",
    bodyIds={
      TppEnemyBodyId.svs0_unq_v060,
      TppEnemyBodyId.svs0_unq_v100,
      TppEnemyBodyId.svs0_unq_v420,
    },
    partsPath="/Assets/tpp/parts/chara/svs/svs0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_afgh.fpk",
  --soldierSubType="SOVIET_B",
  },
  SOVIET_ALL={
    description="Soviet - All",
    bodyIds={
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
    description="PF - Misc",
    bodyIds={
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
    description="PF - All",
    bodyIds={
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
    description="Swimsuit",
    bodyIds={
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
    description="Swimsuit",
    gender="FEMALE",
    bodyIds={
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
  SWIMWEAR2={--GOB SUIT Goblin Suit
    description="Swimsuit - Goblin",
    bodyIds={
      TppEnemyBodyId.dlg_enem0_def,
      TppEnemyBodyId.dlg_enem1_def,
      TppEnemyBodyId.dlg_enem2_def,
      TppEnemyBodyId.dlg_enem3_def,
      TppEnemyBodyId.dlg_enem4_def,
      TppEnemyBodyId.dlg_enem5_def,
      TppEnemyBodyId.dlg_enem6_def,
      TppEnemyBodyId.dlg_enem7_def,
      TppEnemyBodyId.dlg_enem8_def,
      TppEnemyBodyId.dlg_enem9_def,
      TppEnemyBodyId.dlg_enem10_def,
      TppEnemyBodyId.dlg_enem11_def,
    },
    partsPath="/Assets/tpp/parts/chara/dlg/dlg1_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit2.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT2,
    soldierSubType="DD_FOB",
  },
  SWIMWEAR2_FEMALE={
    description="Swimsuit - Goblin",
    gender="FEMALE",
    bodyIds={
      TppEnemyBodyId.dlg_enef0_def,
      TppEnemyBodyId.dlg_enef1_def,
      TppEnemyBodyId.dlg_enef2_def,
      TppEnemyBodyId.dlg_enef3_def,
      TppEnemyBodyId.dlg_enef4_def,
      TppEnemyBodyId.dlg_enef5_def,
      TppEnemyBodyId.dlg_enef6_def,
      TppEnemyBodyId.dlg_enef7_def,
      TppEnemyBodyId.dlg_enef8_def,
      TppEnemyBodyId.dlg_enef9_def,
      TppEnemyBodyId.dlg_enef10_def,
      TppEnemyBodyId.dlg_enef11_def,
    },
    partsPath="/Assets/tpp/parts/chara/dlg/dlg0_enem0_def_f_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit2.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT2,
    soldierSubType="DD_FOB",
  },
  SWIMWEAR3={--MEG SUIT Megalodon Suit
    description="Swimsuit - Megalodon",
    bodyIds={
      TppEnemyBodyId.dlh_enem0_def,
      TppEnemyBodyId.dlh_enem1_def,
      TppEnemyBodyId.dlh_enem2_def,
      TppEnemyBodyId.dlh_enem3_def,
      TppEnemyBodyId.dlh_enem4_def,
      TppEnemyBodyId.dlh_enem5_def,
      TppEnemyBodyId.dlh_enem6_def,
      TppEnemyBodyId.dlh_enem7_def,
      TppEnemyBodyId.dlh_enem8_def,
      TppEnemyBodyId.dlh_enem9_def,
      TppEnemyBodyId.dlh_enem10_def,
      TppEnemyBodyId.dlh_enem11_def,
    },
    partsPath="/Assets/tpp/parts/chara/dlh/dlh1_enem0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit3.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT3,
    soldierSubType="DD_FOB",
  },
  SWIMWEAR3_FEMALE={
    description="Swimsuit - Megalodon",
    gender="FEMALE",
    bodyIds={
      TppEnemyBodyId.dlh_enef0_def,
      TppEnemyBodyId.dlh_enef1_def,
      TppEnemyBodyId.dlh_enef2_def,
      TppEnemyBodyId.dlh_enef3_def,
      TppEnemyBodyId.dlh_enef4_def,
      TppEnemyBodyId.dlh_enef5_def,
      TppEnemyBodyId.dlh_enef6_def,
      TppEnemyBodyId.dlh_enef7_def,
      TppEnemyBodyId.dlh_enef8_def,
      TppEnemyBodyId.dlh_enef9_def,
      TppEnemyBodyId.dlh_enef10_def,
      TppEnemyBodyId.dlh_enef11_def,
    },
    partsPath="/Assets/tpp/parts/chara/dlh/dlh0_enem0_def_f_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_swim_suit3.fpk",--TppDefine.MISSION_COMMON_PACK.DD_SOLDIER_SWIM_SUIT3,
    soldierSubType="DD_FOB",
  },
  PRISONER_AFGH={--vanil ref
    bodyIds={
      TppEnemyBodyId.prs2_main0_v00,
      TppEnemyBodyId.prs2_main0_v01,
    },
    partsPath="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/prs/prs2_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/prs2_main0_mdl.fpk",
    },
    --REF "/Assets/tpp/pack/mission2/common/mis_com_afgh_hostage.fpk",
    soldierSubType="DD_FOB",
  },
  PRISONER_AFGH_FEMALE={
    --TODO partsPath="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/prs/prs3_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/prs3_main0_mdl.fpk",
    },
  --REF \chunk1_dat\Assets\tpp\pack\mission2\quest\extra\quest_q20025_fpkd
  --and in bunch of other quest fpkds
  },
  --10040 : Mission 6 - Where Do the Bees Sleep Hamid prisoner
  PRISONER_4={
    partsPath="/Assets/tpp/parts/chara/prs/prs4_main0_def_v00.parts",
  --\chunk2_dat\Assets\tpp\pack\mission2\story\s10040\s10040_area_fpkd
  },
  PRISONER_MAFR={--vanil ref
    bodyIds={TppEnemyBodyId.prs5_main0_v00},
    partsPath="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts",
    partsPathHostage="/Assets/tpp/parts/chara/prs/prs5_main0_def_v00.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/prs5_main0_mdl.fpk",
    },
    --REF "/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage.fpk",
    soldierSubType="DD_FOB",
  },
  PRISONER_MAFR_FEMALE={
    gender="FEMALE",
    bodyIds={TppEnemyBodyId.prs6_main0_v00},--113
    --TODO partsPath="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00.parts",
    partsPathHostage="/Assets/tpp/parts/chara/prs/prs6_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/prs6_main0_mdl.fpk",
    },
    --REF "/Assets/tpp/pack/mission2/common/mis_com_mafr_hostage_woman.fpk",
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
  --also dct0_face0_cov.fmdl, dct0_face1_cov.fmdl
  --also bunch of invisibleMeshNames in original .parts
  DOCTOR_0={
    bodyIds={
      -- fv2s are different faces,
      -- even if head mesh was hidden with custom fv2 the normal soldier faces neck stick through this bodies collar.
      TppEnemyBodyId.dct0_v00,--default face
      TppEnemyBodyId.dct0_v01,
    },
    partsPath="/Assets/tpp/parts/chara/dct/dct0_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dct/dct0_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dct0_main0_mdl.fpk",
    },
    hasFace=true,
  },
  --main prologue doctor
  --noSkinTones=true,--tex no skin tone support/only white
  --TODO fv2s, not in SoldierFaceAndData system
  --dct1_v00
  --dct1_v01
  --CRASH on non mob2
  DOCTOR_1={
    partsPath="/Assets/tpp/parts/chara/dct/dct1_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dct/dct1_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dct1_main0_mdl.fpk",
    },
    noSkinTones=true,--tex no skin tone support/only white
  },
  --TODO fv2s, not in SoldierFaceAndData system
  --dct2_v00
  --dct2_v01
  --dct2_v02
  DOCTOR_2={
    partsPath="/Assets/tpp/parts/chara/dct/dct2_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dct/dct2_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/dct2_main0_mdl.fpk",
    },
    --REF "/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
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
  --blinking issues
  NURSE_3_FEMALE={
    bodyIds={
      --tex TODO: not in soldierfaceandbody sys
      --nrs3_v00,
      --nrs3_v01,
      --nrs3_v02,
      --nrs0 fovas seem to work on nrs3 too.
      TppEnemyBodyId.nrs0_v00,--brunette,bun
      TppEnemyBodyId.nrs0_v01,--black straight hair
      TppEnemyBodyId.nrs0_v02,--blond, glasses
      TppEnemyBodyId.nrs0_v03,--brunnete bun again? different face?
      TppEnemyBodyId.nrs0_v04,--brown straight, glasses
      TppEnemyBodyId.nrs0_v05,--blond and brunette
      TppEnemyBodyId.nrs0_v06,--brown, bun, glasses
      TppEnemyBodyId.nrs0_v07,--brown, bun
    },
    --partsPath="/Assets/tpp/parts/chara/nrs/nrs3_main0_def_v00.parts",
    partsPathHostage="/Assets/tpp/parts/chara/nrs/nrs3_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/nrs3_main0_mdl.fpk",
    },
  --REF "/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
  },
  --prologue hospital patients
  PATIENT={
    --TODO has a whole bunch of fv2s
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/ptn0_main0_mdl.fpk",
    },
    --TODO partsPath="/Assets/tpp/parts/chara/ptn/ptn0_main0_def_v00.parts",
    partsPathHostage="/Assets/tpp/parts/chara/ptn/ptn0_main0_def_v00_ih_hos.parts",
    --\chunk0_dat\Assets\tpp\pack\mission2\story\s10010\s10010_s03_fpkd
    hasFace=true,
  },
  SKULLFACE={--no collision/pushback
    bodyIds={
      TppEnemyBodyId.wsp_def,
      TppEnemyBodyId.wsp_dam,--bloody
    },
    partsPath="/Assets/tpp/parts/chara/wsp/wsp0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_skullface.fpk",
    hasFace=true,
    soldierSubType="SKULL_AFGH",
  },
  HUEY={
    bodyIds={
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
    -- bodyIds={1},--tex no bodyId entries, so just using 1 since my code does an if bodyId check TODO see if there's any fovas elsewhere
    partsPath="/Assets/tpp/parts/chara/kaz/kaz0_main0_def_v00.parts",
    partsPathHostage="/Assets/tpp/parts/chara/kaz/kaz0_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/kaz0_main0_mdl.fpk",
    },
    --REF "/Assets/tpp/pack/mission2/common/mis_com_miller.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  --tex crashes
  KAZ_GZ={
    --bodyIds={},
    partsPath="/Assets/tpp/parts/chara/kaz/kaz1_main1_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_miller_gz.fpk",
    hasFace=true,
    soldierSubType="DD_FOB",
  },
  OCELOT_0={
    --bodyIds={},
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
    --bodyIds={},
    partsPath="/Assets/tpp/parts/chara/paz/paz0_main0_def_v00.parts",
    missionPackPath="/Assets/tpp/pack/mission2/common/mis_com_paz_gz.fpk",
    hasFace=true,
  },
  PAZ={
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
  --fmdl also contains some dds (drab,tiger) since it's used in shining lights
  DDS_RESEARCHER={
    --bodyIds={
    --1,
    --tex dont know why wolbachia throat shows by default, should only be with the shining lights nvg. and I'm sure I had it at some point without it showing, maybe when they are as soldier, not hostage?
    --TppEnemyBodyId.ddr0_main0_v00,--wolbachia throat, default clean lab coat, ocasionally lab goggles
    --TppEnemyBodyId.ddr0_main0_v01,--wolbachia throat, dds DRAB
    --TppEnemyBodyId.ddr0_main0_v02,--wolbachia throat, dds tiger

    --TppEnemyBodyId.ddr0_main1_v00=149,--bloody lab coat
    --TppEnemyBodyId.ddr0_main1_v01=150,--bloody lab coat with knife stuck in?
    --TppEnemyBodyId.ddr0_main1_v02=151,--fova not in fova common packs, likely in shining lights mission pack
    --TppEnemyBodyId.ddr0_main1_v03=152,--bloody drab
    --TppEnemyBodyId.ddr0_main1_v04=153,--bloody tiger
    -- all have bloody eyeballs
    --not sure goggles are binary on specific fovas or using fova seed/randomisation

    --fovas not in fova common packs, in shining lights mission pack
    -- TppEnemyBodyId.ddr0_main0_v03=166,
    -- TppEnemyBodyId.ddr0_main0_v04=167,
    --
    --  ddr0_main1_v05=168,
    --  ddr0_main1_v06=169,
    --},
    partsPath="/Assets/tpp/parts/chara/dds/ddr0_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/ddr0_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/ddr0_main0_mdl.fpk",
    },
    noSkinTones=true,
  },
  DDS_RESEARCHER_FEMALE={
    --  ddr1_main0_v00=154,
    --  ddr1_main0_v01=155,
    --  ddr1_main0_v02=156,
    --
    --  ddr1_main1_v00=157,
    --  ddr1_main1_v01=158,
    --  ddr1_main1_v02=159,
    gender="FEMALE",
    -- bodyIds={},--tex TODO
    partsPath="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00_ih_sol.parts",
    partsPathHostage="/Assets/tpp/parts/chara/dds/ddr1_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
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
  --crash
  CHILD_0={
    bodyIds={
      TppEnemyBodyId.chd0_v00,
      TppEnemyBodyId.chd0_v01,
      TppEnemyBodyId.chd0_v02,
      TppEnemyBodyId.chd0_v03,
      TppEnemyBodyId.chd0_v04,
      TppEnemyBodyId.chd0_v05,
      TppEnemyBodyId.chd0_v06,
      TppEnemyBodyId.chd0_v07,
      TppEnemyBodyId.chd0_v08,
      TppEnemyBodyId.chd0_v09,
      TppEnemyBodyId.chd0_v10,
      TppEnemyBodyId.chd0_v11,
    },
    --partsPath="/Assets/tpp/parts/chara/chd/chd0_main0_def_v00.parts",
    partsPathHostage="/Assets/tpp/parts/chara/chd/chd0_main0_def_v00_ih_hos.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/chd0_main0_mdl.fpk",
    --"/Assets/tpp/pack/mission2/common/mis_com_child_soldier.fpk",
    },
    hasFace=true,
    soldierSubType="CHILD_A",
  },
  CHILD_1={--TODO
    bodyIds={
      TppEnemyBodyId.chd1_v00,
      TppEnemyBodyId.chd1_v01,
      TppEnemyBodyId.chd1_v02,
      TppEnemyBodyId.chd1_v03,
      TppEnemyBodyId.chd1_v04,
      TppEnemyBodyId.chd1_v05,
    },
    partsPath="/Assets/tpp/parts/chara/chd/chd1_main0_def_v00.parts",
    missionPackPath={
    },
    hasFace=true,
    soldierSubType="CHILD_A",
  },
  CHILD_2={--TODO
    bodyIds={
      TppEnemyBodyId.chd2_v00,
      TppEnemyBodyId.chd2_v01,
      TppEnemyBodyId.chd2_v02,
      TppEnemyBodyId.chd2_v03,
      TppEnemyBodyId.chd2_v04,
    },
    partsPath="/Assets/tpp/parts/chara/chd/chd2_main0_def_v00.parts",
    missionPackPath={
    },
    hasFace=true,
    soldierSubType="CHILD_A",
  },

  --voices mission infected prisoners i think
  --plh0_main0_def_v00.parts
  --plh2_main0_def_v00.parts
  --plh3_main0_def_v00.parts
  GENOME_SOLDIER={
    description="Genome Soldier",
    -- bodyIds={},
    partsPath="/Assets/tpp/parts/chara/gns/gns0_main0_def_v00_ih_sol.parts",
    missionPackPath={
      "BASE_PACK",
      "/Assets/tpp/pack/mission2/ih/gns0_main0_mdl.fpk",
    },
    hasFace=true,
    config={
      HELMET=false,
    --GAS_MASK=true,
    --NVG=true,
    },
  },
}

--tex installed bodies, used by customSoldierType ivar, \mod\bodyInfo addons automatically add to this
this.bodies={
  MALE={
    "OFF",
    "RANDOM",
    "DRAB",
    "TIGER",
    "SNEAKING_SUIT",
    "BATTLE_DRESS",
    "SWIMWEAR",
    "SWIMWEAR2",
    "SWIMWEAR3",
    "PFA_ARMOR",
    "SOVIET_A",
    "SOVIET_B",
    "PF_A",
    "PF_B",
    "PF_C",
    "SOVIET_BERETS",
    "SOVIET_HOODIES",
    "SOVIET_ALL",
    "PF_MISC",
    "PF_ALL",
    "MSF_GZ",
    "MSF_TPP",
    "XOF",
    "XOF_GASMASK",
    "XOF_GZ",
    "GENOME_SOLDIER",
  },
  FEMALE={
    "OFF",
    "RANDOM",
    "DRAB_FEMALE",
    "TIGER_FEMALE",
    "SNEAKING_SUIT_FEMALE",
    "BATTLE_DRESS_FEMALE",
    "SWIMWEAR_FEMALE",
    "SWIMWEAR2_FEMALE",
    "SWIMWEAR3_FEMALE",
  },
}

--tex used to map to InfFova.playerCamoTypesInfo / IsDeveloped
this.bodyIdToCamoType={
  --FATIGUES
  --DEBUGNOW
  --[[
  [TppEnemyBodyId.dds5_main0_ply_v00]=0,
  [TppEnemyBodyId.dds5_main0_ply_v01]=3,
  [TppEnemyBodyId.dds5_main0_ply_v02]=4,
  [TppEnemyBodyId.dds5_main0_ply_v03]=5,
  [TppEnemyBodyId.dds5_main0_ply_v05]=7,
  [TppEnemyBodyId.dds5_main0_ply_v06]=1,
  [TppEnemyBodyId.dds5_main0_ply_v07]=9,
  [TppEnemyBodyId.dds5_main0_ply_v08]=8,
  --none [TppEnemyBodyId.dds5_main0_ply_v09]=,
  [TppEnemyBodyId.dds5_main0_ply_v10]=6,
  [TppEnemyBodyId.dds5_main0_ply_v11]=10,
  [TppEnemyBodyId.dds5_main0_ply_v12]=2,
  [TppEnemyBodyId.dds5_main0_ply_v13]=13,
  [TppEnemyBodyId.dds5_main0_ply_v14]=26,
  --none [TppEnemyBodyId.dds5_main0_ply_v15]=,
  [TppEnemyBodyId.dds5_main0_ply_v16]=48,
  [TppEnemyBodyId.dds5_main0_ply_v17]=49,
  [TppEnemyBodyId.dds5_main0_ply_v18]=50,
  [TppEnemyBodyId.dds5_main0_ply_v19]=51,
  [TppEnemyBodyId.dds5_main0_ply_v20]=52,
  --none [TppEnemyBodyId.dds5_main0_ply_v21]=,
  [TppEnemyBodyId.dds5_main0_ply_v22]=53,
  [TppEnemyBodyId.dds5_main0_ply_v23]=36,
  [TppEnemyBodyId.dds5_main0_ply_v24]=37,
  [TppEnemyBodyId.dds5_main0_ply_v25]=54,
  [TppEnemyBodyId.dds5_main0_ply_v26]=55,
  [TppEnemyBodyId.dds5_main0_ply_v27]=38,
  [TppEnemyBodyId.dds5_main0_ply_v28]=56,
  [TppEnemyBodyId.dds5_main0_ply_v29]=39,
  [TppEnemyBodyId.dds5_main0_ply_v30]=40,
  [TppEnemyBodyId.dds5_main0_ply_v31]=57,
  [TppEnemyBodyId.dds5_main0_ply_v32]=58,
  [TppEnemyBodyId.dds5_main0_ply_v33]=59,
  [TppEnemyBodyId.dds5_main0_ply_v35]=41,
  [TppEnemyBodyId.dds5_main0_ply_v36]=60,
  [TppEnemyBodyId.dds5_main0_ply_v37]=61,
  [TppEnemyBodyId.dds5_main0_ply_v38]=42,
  [TppEnemyBodyId.dds5_main0_ply_v39]=43,
  [TppEnemyBodyId.dds5_main0_ply_v40]=62,
  [TppEnemyBodyId.dds5_main0_ply_v41]=63,
  [TppEnemyBodyId.dds5_main0_ply_v42]=44,
  [TppEnemyBodyId.dds5_main0_ply_v43]=64,
  [TppEnemyBodyId.dds5_main0_ply_v44]=65,
  [TppEnemyBodyId.dds5_main0_ply_v45]=66,
  [TppEnemyBodyId.dds5_main0_ply_v46]=45,
  [TppEnemyBodyId.dds5_main0_ply_v47]=67,
  [TppEnemyBodyId.dds5_main0_ply_v48]=68,
  [TppEnemyBodyId.dds5_main0_ply_v49]=46,
  [TppEnemyBodyId.dds5_main0_ply_v50]=69,
  [TppEnemyBodyId.dds5_main0_ply_v51]=70,
  [TppEnemyBodyId.dds5_main0_ply_v52]=47,
  [TppEnemyBodyId.dds5_main0_ply_v53]=71,
  [TppEnemyBodyId.dds5_main0_ply_v54]=72,
  [TppEnemyBodyId.dds5_main0_ply_v55]=73,
  [TppEnemyBodyId.dds5_main0_ply_v56]=74,
  [TppEnemyBodyId.dds5_main0_ply_v57]=75,
  [TppEnemyBodyId.dds5_main0_ply_v58]=76,
  [TppEnemyBodyId.dds5_main0_ply_v59]=77,
  [TppEnemyBodyId.dds5_main0_ply_v60]=78,
  --]]
  --FATIGUES FEMALE
  --   [TppEnemyBodyId.dds6_main0_ply_v00]=0,
  --  [TppEnemyBodyId.dds6_main0_ply_v01]=3,
  --  [TppEnemyBodyId.dds6_main0_ply_v02]=4,
  --  [TppEnemyBodyId.dds6_main0_ply_v03]=5,
  --  [TppEnemyBodyId.dds6_main0_ply_v05]=7,
  --  [TppEnemyBodyId.dds6_main0_ply_v06]=1,
  --  [TppEnemyBodyId.dds6_main0_ply_v07]=9,
  --  [TppEnemyBodyId.dds6_main0_ply_v08]=8,
  --  --none [TppEnemyBodyId.dds6_main0_ply_v09]=,
  --  [TppEnemyBodyId.dds6_main0_ply_v10]=6,
  --  [TppEnemyBodyId.dds6_main0_ply_v11]=10,
  --  [TppEnemyBodyId.dds6_main0_ply_v12]=2,
  --  [TppEnemyBodyId.dds6_main0_ply_v13]=13,
  --  [TppEnemyBodyId.dds6_main0_ply_v14]=26,
  --  --none [TppEnemyBodyId.dds6_main0_ply_v15]=,
  --  [TppEnemyBodyId.dds6_main0_ply_v16]=48,
  --  [TppEnemyBodyId.dds6_main0_ply_v17]=49,
  --  [TppEnemyBodyId.dds6_main0_ply_v18]=50,
  --  [TppEnemyBodyId.dds6_main0_ply_v19]=51,
  --  [TppEnemyBodyId.dds6_main0_ply_v20]=52,
  --  --none [TppEnemyBodyId.dds6_main0_ply_v21]=,
  --  [TppEnemyBodyId.dds6_main0_ply_v22]=53,
  --  [TppEnemyBodyId.dds6_main0_ply_v23]=36,
  --  [TppEnemyBodyId.dds6_main0_ply_v24]=37,
  --  [TppEnemyBodyId.dds6_main0_ply_v25]=54,
  --  [TppEnemyBodyId.dds6_main0_ply_v26]=55,
  --  [TppEnemyBodyId.dds6_main0_ply_v27]=38,
  --  [TppEnemyBodyId.dds6_main0_ply_v28]=56,
  --  [TppEnemyBodyId.dds6_main0_ply_v29]=39,
  --  [TppEnemyBodyId.dds6_main0_ply_v30]=40,
  --  [TppEnemyBodyId.dds6_main0_ply_v31]=57,
  --  [TppEnemyBodyId.dds6_main0_ply_v32]=58,
  --  [TppEnemyBodyId.dds6_main0_ply_v33]=59,
  --  [TppEnemyBodyId.dds6_main0_ply_v35]=41,
  --  [TppEnemyBodyId.dds6_main0_ply_v36]=60,
  --  [TppEnemyBodyId.dds6_main0_ply_v37]=61,
  --  [TppEnemyBodyId.dds6_main0_ply_v38]=42,
  --  [TppEnemyBodyId.dds6_main0_ply_v39]=43,
  --  [TppEnemyBodyId.dds6_main0_ply_v40]=62,
  --  [TppEnemyBodyId.dds6_main0_ply_v41]=63,
  --  [TppEnemyBodyId.dds6_main0_ply_v42]=44,
  --  [TppEnemyBodyId.dds6_main0_ply_v43]=64,
  --  [TppEnemyBodyId.dds6_main0_ply_v44]=65,
  --  [TppEnemyBodyId.dds6_main0_ply_v45]=66,
  --  [TppEnemyBodyId.dds6_main0_ply_v46]=45,
  --  [TppEnemyBodyId.dds6_main0_ply_v47]=67,
  --  [TppEnemyBodyId.dds6_main0_ply_v48]=68,
  --  [TppEnemyBodyId.dds6_main0_ply_v49]=46,
  --  [TppEnemyBodyId.dds6_main0_ply_v50]=69,
  --  [TppEnemyBodyId.dds6_main0_ply_v51]=70,
  --  [TppEnemyBodyId.dds6_main0_ply_v52]=47,
  --  [TppEnemyBodyId.dds6_main0_ply_v53]=71,
  --  [TppEnemyBodyId.dds6_main0_ply_v54]=72,
  --  [TppEnemyBodyId.dds6_main0_ply_v55]=73,
  --  [TppEnemyBodyId.dds6_main0_ply_v56]=74,
  --  [TppEnemyBodyId.dds6_main0_ply_v57]=75,
  --  [TppEnemyBodyId.dds6_main0_ply_v58]=76,
  --  [TppEnemyBodyId.dds6_main0_ply_v59]=77,
  --  [TppEnemyBodyId.dds6_main0_ply_v60]=78,

  --SWIMWEAR
  [TppEnemyBodyId.dlf_enem0_def]=79,
  [TppEnemyBodyId.dlf_enem1_def]=80,
  [TppEnemyBodyId.dlf_enem2_def]=81,
  [TppEnemyBodyId.dlf_enem3_def]=82,
  [TppEnemyBodyId.dlf_enem4_def]=83,
  [TppEnemyBodyId.dlf_enem5_def]=84,
  [TppEnemyBodyId.dlf_enem6_def]=85,
  [TppEnemyBodyId.dlf_enem7_def]=86,
  [TppEnemyBodyId.dlf_enem8_def]=87,
  [TppEnemyBodyId.dlf_enem9_def]=88,
  [TppEnemyBodyId.dlf_enem10_def]=89,
  [TppEnemyBodyId.dlf_enem11_def]=90,
  --SWIMWEAR_FEMALE
  [TppEnemyBodyId.dlf_enef0_def]=79,
  [TppEnemyBodyId.dlf_enef1_def]=80,
  [TppEnemyBodyId.dlf_enef2_def]=81,
  [TppEnemyBodyId.dlf_enef3_def]=82,
  [TppEnemyBodyId.dlf_enef4_def]=83,
  [TppEnemyBodyId.dlf_enef5_def]=84,
  [TppEnemyBodyId.dlf_enef6_def]=85,
  [TppEnemyBodyId.dlf_enef7_def]=86,
  [TppEnemyBodyId.dlf_enef8_def]=87,
  [TppEnemyBodyId.dlf_enef9_def]=88,
  [TppEnemyBodyId.dlf_enef10_def]=89,
  [TppEnemyBodyId.dlf_enef11_def]=90,
  --SWIMWEAR2
  [TppEnemyBodyId.dlg_enem0_def]=91,
  [TppEnemyBodyId.dlg_enem1_def]=92,
  [TppEnemyBodyId.dlg_enem2_def]=93,
  [TppEnemyBodyId.dlg_enem3_def]=94,
  [TppEnemyBodyId.dlg_enem4_def]=95,
  [TppEnemyBodyId.dlg_enem5_def]=96,
  [TppEnemyBodyId.dlg_enem6_def]=97,
  [TppEnemyBodyId.dlg_enem7_def]=98,
  [TppEnemyBodyId.dlg_enem8_def]=99,
  [TppEnemyBodyId.dlg_enem9_def]=100,
  [TppEnemyBodyId.dlg_enem10_def]=101,
  [TppEnemyBodyId.dlg_enem11_def]=102,
  --SWIMWEAR2_FEMALE
  [TppEnemyBodyId.dlg_enef0_def]=91,
  [TppEnemyBodyId.dlg_enef1_def]=92,
  [TppEnemyBodyId.dlg_enef2_def]=93,
  [TppEnemyBodyId.dlg_enef3_def]=94,
  [TppEnemyBodyId.dlg_enef4_def]=95,
  [TppEnemyBodyId.dlg_enef5_def]=96,
  [TppEnemyBodyId.dlg_enef6_def]=97,
  [TppEnemyBodyId.dlg_enef7_def]=98,
  [TppEnemyBodyId.dlg_enef8_def]=99,
  [TppEnemyBodyId.dlg_enef9_def]=100,
  [TppEnemyBodyId.dlg_enef10_def]=101,
  [TppEnemyBodyId.dlg_enef11_def]=102,
  --SWIMWEAR3
  [TppEnemyBodyId.dlh_enem0_def]=103,
  [TppEnemyBodyId.dlh_enem1_def]=104,
  [TppEnemyBodyId.dlh_enem2_def]=105,
  [TppEnemyBodyId.dlh_enem3_def]=106,
  [TppEnemyBodyId.dlh_enem4_def]=107,
  [TppEnemyBodyId.dlh_enem5_def]=108,
  [TppEnemyBodyId.dlh_enem6_def]=109,
  [TppEnemyBodyId.dlh_enem7_def]=110,
  [TppEnemyBodyId.dlh_enem8_def]=111,
  [TppEnemyBodyId.dlh_enem9_def]=112,
  [TppEnemyBodyId.dlh_enem10_def]=113,
  [TppEnemyBodyId.dlh_enem11_def]=114,
  --SWIMWEAR3_FEMALE
  [TppEnemyBodyId.dlh_enef0_def]=103,
  [TppEnemyBodyId.dlh_enef1_def]=104,
  [TppEnemyBodyId.dlh_enef2_def]=105,
  [TppEnemyBodyId.dlh_enef3_def]=106,
  [TppEnemyBodyId.dlh_enef4_def]=107,
  [TppEnemyBodyId.dlh_enef5_def]=108,
  [TppEnemyBodyId.dlh_enef6_def]=109,
  [TppEnemyBodyId.dlh_enef7_def]=110,
  [TppEnemyBodyId.dlh_enef8_def]=111,
  [TppEnemyBodyId.dlh_enef9_def]=112,
  [TppEnemyBodyId.dlh_enef10_def]=113,
  [TppEnemyBodyId.dlh_enef11_def]=114,
}

--Loads \mod\bodyInfo\*.lua into this.bodyInfo
function this.LoadBodyInfos()
  InfCore.LogFlow("InfBodyInfo.LoadBodyInfos")

  local files=InfCore.GetFileList(InfCore.files.bodyInfo,".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfBodyInfo.LoadBodyInfos: "..fileName)
    local bodyInfoName=InfUtil.StripExt(fileName)
    local bodyInfo=InfCore.LoadSimpleModule(InfCore.paths.bodyInfo,fileName)
    if not bodyInfo then
      InfCore.Log("")
    else
      this.bodyInfo[bodyInfoName]=bodyInfo

      local gender=bodyInfo.gender or "MALE"
      if not InfUtil.FindInList(this.bodies[gender],bodyInfoName) then
        table.insert(this.bodies[gender],bodyInfoName)
      end
    end
  end

  for bodyType,bodyInfo in pairs(this.bodyInfo)do
    bodyType=bodyInfo.bodyType or bodyInfo.name or bodyType
    bodyInfo.bodyType=bodyType--LEGACY TODO cull once you've changed code to .name
    bodyInfo.name=bodyType--tex standard with other ih info formats
     
    if bodyInfo.bodyIds and bodyInfo.bodyIdNames then
      InfCore.Log("ERROR: InfBodyInfo.LoadBodyInfos: bodyInfo has both .bodyIds and .bodyIdNames",false,true)--tex author warning
    end
    
    --tex PATCHUP: MUTATION: new (post r261) bodyInfos should have bodyInfo.bodyNames entries instead (which in hindsight I should have implemented my example as from the start)  
    if bodyInfo.bodyIds and #bodyInfo.bodyIds>0 then
      if type(bodyInfo.bodyIds[1])=="string" then--ASSUMPTION: if first entry is string, then this is a list of strings
        bodyInfo.bodyIdNames=bodyInfo.bodyIds
        bodyInfo.bodyIds=nil
      end
    end
    
    if bodyInfo.bodyIdNames then
      bodyInfo.bodyIds={}
      for i,bodyIdName in ipairs(bodyInfo.bodyIdNames)do
        if TppEnemyBodyId[bodyIdName]==nil then
          InfCore.Log("WARNING: InfBodyInfo.LoadBodyInfos: could not find TppEnemyBodyId."..bodyIdName,false,true)
          InfCore.PrintInspect(bodyInfo,"bodyInfo")
        else
          table.insert(bodyInfo.bodyIds,TppEnemyBodyId[bodyIdName])
        end
      end--for bodyIdNames
    end--bodyIdNames
   
    --tex DEBUGNOW see if theres any released addons that use this.
    --DEBUGNOW handle string bodyIds
    --DEBUGNOW bodyInfo.name vs soldierSubType used on my builtins that fallback to TppEnemy.bodyIdTable
    if bodyInfo.bodyIds==nil or bodyInfo.bodyIdTable then
      local bodyIdTable=bodyInfo.bodyIdTable or TppEnemy.bodyIdTable
      bodyInfo.bodyIds=this.GatherBodyIds(bodyInfo.name,bodyIdTable)--DEBUGNOW need to handle multiple soldiertypes
    end
  end--for bodyInfos
end--LoadBodyInfos
--crunch down bodyIdTable to array
function this.GatherBodyIds(soldierSubType,bodyIdTable)
  local bodyIds={}
  local bodyIdTable=bodyIdTable[soldierSubType]
  if bodyIdTable then
    local bodyIdsUnique={}--tex may be multiple references to a bodyId
    for powerType,bodyTable in pairs(bodyIdTable)do
      for i,bodyId in ipairs(bodyTable)do
        bodyIdsUnique[bodyId]=true
      end
    end
    for bodyId,bool in pairs(bodyIdsUnique)do
      bodyIds[#bodyIds+1]=bodyId
    end
  end
  return bodyIds
end--GatherBodyIds

function this.PostAllModulesLoad()
  this.LoadBodyInfos()
  if this.debugModule then
    InfCore.Log("InfBodyInfo")
    InfCore.PrintInspect(this.bodyInfo,"bodyInfo")
    InfCore.PrintInspect(this.bodies,"bodies names")
  end
end

return this
