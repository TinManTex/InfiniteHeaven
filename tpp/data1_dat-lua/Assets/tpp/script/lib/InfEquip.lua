-- DOBUILD: 0
--InfEquip.lua

local this={}

--WIP
--NOTE: grade possibly matches current developed anyhoo?
this.tppEquipTable={--SYNC: EquipIdTable
  --  SHIELD={
--    "EQP_SLD_SV",
--    "EQP_SLD_PF_00",
--    "EQP_SLD_PF_01",
--    "EQP_SLD_PF_02",
--    "EQP_SLD_DD",
--    "EQP_SLD_DD_G02",
--    "EQP_SLD_DD_G03",
--    "EQP_SLD_DD_01",
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
  --tex added in retail 1080
--  "EQP_WP_EX_hg_000_G01",--AM A114 RP grade 8 - silencer, gas cloud
--  "EQP_WP_EX_hg_000_G02",--AM A114 RP grade 9 - silencer, gas cloud
  -- 1090
  "EQP_WP_EX_hg_000_G03",
  "EQP_WP_EX_hg_000_G04",
  "EQP_WP_EX_hg_010",
  "EQP_WP_EX_hg_011",
  "EQP_WP_EX_hg_012",
  "EQP_WP_EX_hg_013",
--  },
--  SMG={
--  "EQP_WP_West_sm_010",--ze'ev cs grade 3 pf normal, dd min grade
--  "EQP_WP_West_sm_010_WG",--as above, no icon/name
--  "EQP_WP_West_sm_020",--macht 37 grade 3, pf strong, skull normal strong
--  "EQP_WP_East_sm_010",--sz 336 grade 3, sov normal
--  "EQP_WP_East_sm_020",--sz 336 cs grade 5, sov strong
--  "EQP_WP_East_sm_030",--sz 336 cs grade 3 light, supressor, skull cypr normal

--dd table smg
--  "EQP_WP_West_sm_014",--zeeve model, big scope no icon/name, supressor, DD icon backing
--  "EQP_WP_West_sm_015",--as above
--  "EQP_WP_West_sm_016",--loads, but missing icons and some blacked out sights DD backing, DD weapon table
--  "EQP_WP_West_sm_017",--<
--1090
  "EQP_WP_West_sm_019",
  "EQP_WP_West_sm_01a",
  "EQP_WP_West_sm_01b",
  --
--  },
--    SMG_NONLETHAL={
--in dd table
--  "EQP_WP_East_sm_042",--riot smg stn grd 1 stun
--  "EQP_WP_East_sm_043",
--  "EQP_WP_East_sm_044",
--  "EQP_WP_East_sm_045",
--  "EQP_WP_East_sm_047",
--1090
  "EQP_WP_East_sm_049",
  "EQP_WP_East_sm_04a",
  "EQP_WP_East_sm_04b",
  --
--    },
--  SHOTGUN={
--  "EQP_WP_Com_sg_010",--s1000 grade 2
--  "EQP_WP_Com_sg_011",--s1000 cs grade 2, most normal shotty, sov a, pfs, skull, dd min
--  "EQP_WP_Com_sg_011_FL",--as above, flashlight ?
--  --in dd table
--  "EQP_WP_Com_sg_013",--? mag shotgun no name no icon
--  "EQP_WP_Com_sg_015",--above + scope, light
--  "EQP_WP_Com_sg_020",--kabarga 83, grade 4, looks like same model as 013,14
--  "EQP_WP_Com_sg_020_FL",--as abovem flashlight ?
--  "EQP_WP_Com_sg_016",
--  "EQP_WP_Com_sg_018",
--},
--SHOTGUN_NONLETHAL={
--dd
--  "EQP_WP_Com_sg_023",--s1000 air-s stn at least icon grade 3 - icon shows slilencer scope but not in game
--  "EQP_WP_Com_sg_024",--as above, light ?
--  "EQP_WP_Com_sg_025",--as above
--  "EQP_WP_Com_sg_030",--s1000 air-s cs grade 6
--  "EQP_WP_Com_sg_038",--loads, but missing icons and some blacked out sights
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
  --1090
  "EQP_WP_West_ar_059",
  "EQP_WP_West_ar_05a",
  "EQP_WP_West_ar_05b",
  "EQP_WP_West_ar_079",
  "EQP_WP_West_ar_07a",
  "EQP_WP_West_ar_07b",
  --
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
  --1090
  "EQP_WP_West_sr_029",
  "EQP_WP_West_sr_02a",
  "EQP_WP_West_sr_02b",
  "EQP_WP_West_sr_049",
  "EQP_WP_West_sr_04a",
  "EQP_WP_West_sr_04b",
  --
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
 --1090
  "EQP_WP_West_mg_039",
  "EQP_WP_West_mg_03a",
  "EQP_WP_West_mg_03b",
  "EQP_WP_West_ms_029",
  "EQP_WP_West_ms_02a",
  "EQP_WP_West_ms_02b",
  "EQP_WP_Com_ms_029",
  "EQP_WP_Com_ms_02a",
  "EQP_WP_Com_ms_02b",
  --
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
--1090
"EQP_SWP_Grenade_G06",
  "EQP_SWP_Grenade_G07",
  "EQP_SWP_Grenade_G08",
  --
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
 --1090
  "EQP_SWP_StunGrenade_G04",
  "EQP_SWP_StunGrenade_G05",
  "EQP_SWP_StunGrenade_G06",
  --
--    "EQP_SWP_SleepingGusGrenade",
--    "EQP_SWP_SleepingGusGrenade_G01",
--    "EQP_SWP_SleepingGusGrenade_G02",
--    "EQP_SWP_MolotovCocktail",
--    "EQP_SWP_MolotovCocktail_G01",
--    "EQP_SWP_MolotovCocktail_G02",
--    "EQP_SWP_MolotovCocktailPlaced",
--1090 --crashes, looking for some fob function i guess
  "EQP_SWP_FakeSign",
  "EQP_SWP_FakeSign_G01",
  "EQP_SWP_FakeSign_G02",
  --
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
--1090
  "EQP_SWP_ShockDecoy_G03",
  "EQP_SWP_ShockDecoy_G04",
  --
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

function this.LoadEquipTable()
  local equipLoadTable={}
  --tex TODO: find a better indicator of equipable mission loading

  for n,equipName in ipairs(this.tppEquipTable)do--TODO: still working on the indexed not grouped table
    local equipId=TppEquip[equipName]
    if equipId~=nil then
      table.insert(equipLoadTable,equipId)
    end
  end

  if #equipLoadTable>0 and TppEquip.RequestLoadToEquipMissionBlock then
    TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)
  end
end

return this
