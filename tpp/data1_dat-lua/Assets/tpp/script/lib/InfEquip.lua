-- DOBUILD: 1
--InfEquip.lua

local this={}
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID

this.tppEquipTableTest={
  "EQP_AB_PrimaryCommon",
  "EQP_AB_PrimaryTranq",
  "EQP_AB_PrimaryMissile",
  "EQP_AB_PrimaryMissileTranq",
  "EQP_AB_SecondaryCommon",
  "EQP_AB_SecondaryTranq",
  "EQP_AB_Support",
  "EQP_AB_Suppressor",
  "EQP_AB_Item",
  "EQP_AB_Mecha",
  "EQP_BX_Primary",
  "EQP_BX_Secondary",
  "EQP_BX_Support",
  "EQP_SWP_Magazine",

  "EQP_SWP_Kibidango",
  "EQP_SWP_Grenade",
  "EQP_SWP_SmokeGrenade",
  "EQP_SWP_SupportHeliFlareGrenade",
  "EQP_SWP_SupplyFlareGrenade",
  "EQP_SWP_StunGrenade",
  "EQP_SWP_SleepingGusGrenade",
  "EQP_SWP_MolotovCocktail",
  "EQP_SWP_C4",
  "EQP_SWP_Decoy",
  "EQP_SWP_ActiveDecoy",
  "EQP_SWP_ShockDecoy",
  "EQP_SWP_CaptureCage",
  "EQP_SWP_DMine",
  "EQP_SWP_SleepingGusMine",
  "EQP_SWP_AntitankMine",
  "EQP_SWP_ElectromagneticNetMine",

}

this.tppEquipTable={--SYNC: EquipIdTable
  --SHIELD
  "EQP_SLD_SV",
  "EQP_SLD_PF_00",
  "EQP_SLD_PF_01",
  "EQP_SLD_PF_02",

  "EQP_SLD_DD",
  "EQP_SLD_DD_G02",
  "EQP_SLD_DD_G03",

  "EQP_SLD_DD_01",

  --HANDGUN
  "EQP_WP_West_hg_010",--AM D114 grade 1 -- PFs and DD hangun
  "EQP_WP_West_hg_010_WG",--no name/icon/drop model
  "EQP_WP_West_hg_020",--AM D114 with silencer(on icon) but no ext mag?  grade 4, skull normal strong
  "EQP_WP_West_hg_030",--geist p3 - shows shotgun icon but clearly isnt, machine pistol grade 4
  "EQP_WP_West_hg_030_cmn",--as above, no name/icon
  "EQP_WP_East_hg_010",--burkov grade 1, sov normal strong

  --TRANQ_PISTOL
  "EQP_WP_West_thg_010",--wu s.pistol grade 1
  "EQP_WP_West_thg_020",--grade 2
  "EQP_WP_West_thg_030",--wu s pistol inf supressor grade 5
  "EQP_WP_West_thg_040",--grade 5
  "EQP_WP_West_thg_050",--wu s pistol cb grade7
  "EQP_WP_EX_hg_000",--AM A114 RP grade 7 - silencer, gas cloud
  --tex added in retail 1080
  "EQP_WP_EX_hg_000_G01",--AM A114 RP grade 8 - silencer, gas cloud
  "EQP_WP_EX_hg_000_G02",--AM A114 RP grade 9 - silencer, gas cloud
  -- 1090
  "EQP_WP_EX_hg_000_G03",
  "EQP_WP_EX_hg_000_G04",
  "EQP_WP_EX_hg_010",--tornado 6 grade 3
  "EQP_WP_EX_hg_011",--tornado 6 grade 5
  "EQP_WP_EX_hg_012",--tornado 6 grade 6
  "EQP_WP_EX_hg_013",--tornado 6 grade 7

  --SMG
  "EQP_WP_West_sm_010",--ze'ev cs grade 3 pf normal, dd min grade
  "EQP_WP_West_sm_010_WG",--as above, no icon/name
  "EQP_WP_West_sm_020",--macht 37 grade 3, pf strong, skull normal strong
  "EQP_WP_East_sm_010",--sz 336 grade 3, sov normal
  "EQP_WP_East_sm_020",--sz 336 cs grade 5, sov strong
  "EQP_WP_East_sm_030",--sz 336 cs grade 3 light, supressor, skull cypr normal
  --dd table smg
  "EQP_WP_West_sm_014",--zeeve model, big scope no icon/name, supressor, DD icon backing
  "EQP_WP_West_sm_015",--as above
  "EQP_WP_West_sm_016",--loads, but missing icons and some blacked out sights DD backing, DD weapon table
  "EQP_WP_West_sm_017",--<
  --1090
  "EQP_WP_West_sm_019",
  "EQP_WP_West_sm_01a",
  "EQP_WP_West_sm_01b",

  --SMG_NONLETHAL
  --in dd table
  "EQP_WP_East_sm_042",--riot smg stn grd 1 stun
  "EQP_WP_East_sm_043",
  "EQP_WP_East_sm_044",
  "EQP_WP_East_sm_045",
  "EQP_WP_East_sm_047",
  --1090
  "EQP_WP_East_sm_049",
  "EQP_WP_East_sm_04a",
  "EQP_WP_East_sm_04b",

  --SHOTGUN
  "EQP_WP_Com_sg_010",--s1000 grade 2
  "EQP_WP_Com_sg_011",--s1000 cs grade 2, most normal shotty, sov a, pfs, skull, dd min
  "EQP_WP_Com_sg_011_FL",--as above, flashlight ?
  --in dd table
  "EQP_WP_Com_sg_013",--? mag shotgun no name no icon
  "EQP_WP_Com_sg_015",--above + scope, light
  "EQP_WP_Com_sg_020",--kabarga 83, grade 4, looks like same model as 013,14
  "EQP_WP_Com_sg_020_FL",--as abovem flashlight ?
  "EQP_WP_Com_sg_016",
  "EQP_WP_Com_sg_018",

  --SHOTGUN_NONLETHAL
  --dd
  "EQP_WP_Com_sg_023",--s1000 air-s stn at least icon grade 3 - icon shows slilencer scope but not in game
  "EQP_WP_Com_sg_024",--as above, light ?
  "EQP_WP_Com_sg_025",--as above
  "EQP_WP_Com_sg_030",--s1000 air-s cs grade 6
  "EQP_WP_Com_sg_038",--loads, but missing icons and some blacked out sights

  --ASSAULT
  "EQP_WP_West_ar_010",--AM MRS 4r Grade 3, pfs normal, dd 3rd
  "EQP_WP_West_ar_010_FL",--flashlight

  "EQP_WP_West_ar_020",--un arc cs grade 3 PF strong
  "EQP_WP_West_ar_020_FL",--flashlight
  "EQP_WP_West_ar_030",--un arc pt cs flashlight scope laser, skull normal and strong

  "EQP_WP_East_ar_010",--svg 76 grade 1, soviet normal
  "EQP_WP_East_ar_010_FL",--+flashlight
  "EQP_WP_East_ar_020",--svg 67 cs grade 4, child
  "EQP_WP_East_ar_030",--above grade 6, sov strong
  "EQP_WP_East_ar_030_FL",--+ flashlight

  --in dd table
  "EQP_WP_West_ar_040",--am mrs 4 grade 1
  "EQP_WP_West_ar_042",--above + supressor scope
  "EQP_WP_West_ar_055",--scope, no icon name
  "EQP_WP_West_ar_050",--am mrs 4r grade 5 scope laser
  "EQP_WP_West_ar_057",--loads, but missing icons and some blacked out sights
  --1090
  "EQP_WP_West_ar_059",
  "EQP_WP_West_ar_05a",
  "EQP_WP_West_ar_05b",
  "EQP_WP_West_ar_079",
  "EQP_WP_West_ar_07a",
  "EQP_WP_West_ar_07b",

  --ASSAULT_NONLETHAL
  "EQP_WP_West_ar_060",--un arc nl stn grade 2
  "EQP_WP_West_ar_063",--above + scope no icon name
  "EQP_WP_West_ar_070",--un arc nl stn light grade 4
  "EQP_WP_West_ar_075",--above + supressor
  "EQP_WP_West_ar_077",

  --SNIPER
  "EQP_WP_West_sr_010",--m2000 d grade 2
  "EQP_WP_West_sr_011",--PF normal, DD
  "EQP_WP_East_sr_011",--sov a normal
  "EQP_WP_East_sr_020",--sov a strong
  "EQP_WP_EX_sr_000",--molotok-68 grade 9 --icon/scope issues
  --dd table
  "EQP_WP_West_sr_013",
  "EQP_WP_West_sr_014",
  "EQP_WP_West_sr_020",
  "EQP_WP_West_sr_027",
  --1090
  "EQP_WP_West_sr_029",
  "EQP_WP_West_sr_02a",
  "EQP_WP_West_sr_02b",
  "EQP_WP_West_sr_049",
  "EQP_WP_West_sr_04a",
  "EQP_WP_West_sr_04b",

  --SNIPER_NONLETHAL
  --ddtable
  "EQP_WP_East_sr_032",
  "EQP_WP_East_sr_033",
  "EQP_WP_East_sr_034",
  "EQP_WP_West_sr_037",
  "EQP_WP_West_sr_047",
  "EQP_WP_West_sr_048",

  --MG
  "EQP_WP_West_mg_010",--un am cs grade 4 PF normal,strong,
  "EQP_WP_West_mg_020",--alm 48 grade 2 skull normal strong, dd min
  "EQP_WP_West_mg_021",--alm48 flashlight grade 4
  "EQP_WP_East_mg_010",--lpg 61 grade 4, soviet normal
  --dd
  "EQP_WP_West_mg_023",--
  "EQP_WP_West_mg_024",
  "EQP_WP_West_mg_030",--alm 48 grade 5 flashlight
  "EQP_WP_West_mg_037",--
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

  --MISSILE
  "EQP_WP_Com_ms_010",--killer bee grade 3, sov, pf, dd,skull strong
  "EQP_WP_West_ms_010",--fb mr r grade 3, pf,skull normal
  "EQP_WP_East_ms_010",--grom 11, grade 2, sov normal
  "EQP_WP_East_ms_020",--cgm 25, used in s10054
  --dd table
  "EQP_WP_Com_ms_023",
  "EQP_WP_Com_ms_024",
  "EQP_WP_Com_ms_020",--killer bee
  "EQP_WP_Com_ms_026",

  --MISSILE_NONLETHAL
  "EQP_WP_West_ms_020",--fb mr rl nlsp

  --GRENADE_LAUNCHER
  "EQP_WP_EX_gl_000",--miraz zh 71 grade 9

  --SUPPORT_WEAPONS
  "EQP_SWP_Magazine",
  --animal bait

  "EQP_SWP_Kibidango",
  "EQP_SWP_Kibidango_G01",
  "EQP_SWP_Kibidango_G02",


  "EQP_SWP_Grenade",
  "EQP_SWP_Grenade_G01",
  "EQP_SWP_Grenade_G02",
  "EQP_SWP_Grenade_G03",
  "EQP_SWP_Grenade_G04",
  "EQP_SWP_Grenade_G05",
  --1090
  "EQP_SWP_Grenade_G06",
  "EQP_SWP_Grenade_G07",
  "EQP_SWP_Grenade_G08",

  "EQP_SWP_SmokeGrenade",
  "EQP_SWP_SmokeGrenade_G01",
  "EQP_SWP_SmokeGrenade_G02",
  "EQP_SWP_SmokeGrenade_G03",
  "EQP_SWP_SmokeGrenade_G04",

  "EQP_SWP_SupportHeliFlareGrenade",
  "EQP_SWP_SupportHeliFlareGrenade_G01",
  "EQP_SWP_SupportHeliFlareGrenade_G02",

  "EQP_SWP_SupplyFlareGrenade",
  "EQP_SWP_SupplyFlareGrenade_G01",
  "EQP_SWP_SupplyFlareGrenade_G02",

  "EQP_SWP_StunGrenade",
  "EQP_SWP_StunGrenade_G01",
  "EQP_SWP_StunGrenade_G02",
  "EQP_SWP_StunGrenade_G03",
  --1090
  "EQP_SWP_StunGrenade_G04",
  "EQP_SWP_StunGrenade_G05",
  "EQP_SWP_StunGrenade_G06",

  "EQP_SWP_SleepingGusGrenade",
  "EQP_SWP_SleepingGusGrenade_G01",
  "EQP_SWP_SleepingGusGrenade_G02",

  "EQP_SWP_MolotovCocktail",
  "EQP_SWP_MolotovCocktail_G01",
  "EQP_SWP_MolotovCocktail_G02",

  "EQP_SWP_MolotovCocktailPlaced",

  "EQP_SWP_C4",
  "EQP_SWP_C4_G01",
  "EQP_SWP_C4_G02",
  "EQP_SWP_C4_G03",
  "EQP_SWP_C4_G04",

  "EQP_SWP_Decoy",
  "EQP_SWP_Decoy_G01",
  "EQP_SWP_Decoy_G02",

  "EQP_SWP_ActiveDecoy",
  "EQP_SWP_ActiveDecoy_G01",
  "EQP_SWP_ActiveDecoy_G02",

  "EQP_SWP_ShockDecoy",
  "EQP_SWP_ShockDecoy_G01",
  "EQP_SWP_ShockDecoy_G02",
  --1090
  "EQP_SWP_ShockDecoy_G03",
  "EQP_SWP_ShockDecoy_G04",

  "EQP_SWP_CaptureCage",
  "EQP_SWP_CaptureCage_G01",
  "EQP_SWP_CaptureCage_G02",

  "EQP_SWP_DMine",
  "EQP_SWP_DMine_G01",
  "EQP_SWP_DMine_G02",
  "EQP_SWP_DMine_G03",

  "EQP_SWP_SleepingGusMine",
  "EQP_SWP_SleepingGusMine_G01",
  "EQP_SWP_SleepingGusMine_G02",

  "EQP_SWP_AntitankMine",
  "EQP_SWP_AntitankMine_G01",
  "EQP_SWP_AntitankMine_G02",

  "EQP_SWP_ElectromagneticNetMine",
  "EQP_SWP_ElectromagneticNetMine_G01",
  "EQP_SWP_ElectromagneticNetMine_G02",

  --fob
  --FOB
  "EQP_SWP_SleepingGusMineLocator",
  "EQP_SWP_DMineLocator",
  --crash requires fob mode/specifc set up i guess
  "EQP_WP_SCamLocator",
  "EQP_SWP_WormholePortal",
  --1090 --crashes on equip, looking for some fob function i guess
  "EQP_SWP_FakeSign",
  "EQP_SWP_FakeSign_G01",
  "EQP_SWP_FakeSign_G02",

  --AMMOBOX
  --tex crash on equip
  "EQP_AB_PrimaryCommon",
  "EQP_AB_PrimaryTranq",
  "EQP_AB_PrimaryMissile",
  "EQP_AB_PrimaryMissileTranq",
  "EQP_AB_SecondaryCommon",
  "EQP_AB_SecondaryTranq",
  "EQP_AB_Support",
  "EQP_AB_Suppressor",
  "EQP_AB_Item",
  "EQP_AB_Mecha",
  "EQP_BX_Primary",
  "EQP_BX_Secondary",
  "EQP_BX_Support",

  --hands
  --no world pickup model
  --no effect on pickup
  "EQP_HAND_STUNARM",
  "EQP_HAND_JEHUTY",
  "EQP_HAND_STUN_ROCKET",
  "EQP_HAND_KILL_ROCKET",
  "EQP_HAND_NORMAL",
  "EQP_HAND_GOLD",
  "EQP_HAND_SILVER",

  --items
  "EQP_IT_Fulton",
  "EQP_IT_Fulton_Cargo",
  "EQP_IT_Fulton_Child",
  "EQP_IT_Fulton_WormHole",
  "EQP_IT_Binocle",

  --equips item to players set level/amount
  --no world model
  --ITEMS
  "EQP_IT_InstantStealth",
  "EQP_IT_Pentazemin",
  "EQP_IT_Clairvoyance",
  "EQP_IT_ReflexMedicine",

  --world model is untextured/white
  --works fine on equipping though
  --CARDBOARD_BOX
  "EQP_IT_CBox_WR",
  "EQP_IT_CBox_SMK",
  "EQP_IT_CBox_DSR",
  "EQP_IT_CBox_DSR_G01",
  "EQP_IT_CBox_DSR_G02",
  "EQP_IT_CBox_FRST",
  "EQP_IT_CBox_FRST_G01",
  "EQP_IT_CBox_BOLE",
  "EQP_IT_CBox_BOLE_G01",
  "EQP_IT_CBox_CITY",
  "EQP_IT_CBox_CITY_G01",

  --tex no go
  "EQP_IT_CBox_CLB_A",
  "EQP_IT_CBox_CLB_A_G01",
  "EQP_IT_CBox_CLB_B",
  "EQP_IT_CBox_CLB_B_G01",
  "EQP_IT_CBox_CLB_C",
  "EQP_IT_CBox_CLB_C_G01",
  -- tex some kind of dlc box, defaults to regular texture though
  "EQP_IT_CBox_LIMITED",
  "EQP_IT_CBox_LIMITED_G01",
  --
  --tex needs parasite armor
  --no world model
  "EQP_IT_ParasiteMist",
  "EQP_IT_ParasiteCamouf",
  "EQP_IT_ParasiteHard",

  --tools
  --give current set level (amounts if applicable)?
  "EQP_IT_TimeCigarette",
  "EQP_IT_Stealth",--no world model
  "EQP_IT_Nvg",

  "EQP_IT_Cassette",--cassette ids?
  "EQP_IT_DevelopmentFile",
  --no effect
  "EQP_IT_FilmCase",

  "EQP_IT_IDroid",
  "EQP_IT_CureSpray",
  "EQP_IT_PickingToolR",
  "EQP_IT_PickingToolL",
  "EQP_IT_HandyLight",
  "EQP_IT_Knife",
  "EQP_IT_SKnife",
  "EQP_IT_Cigarette",
  "EQP_IT_CigaretteCase",
  "EQP_IT_Radio",
  "EQP_IT_SRadio",

  "EQP_IT_Telescope",
  "EQP_IT_GasMask",--tex likely handled through attachgasmask/requires asset fpk
  "EQP_IT_KnifePF",
  --no world model-v-
  "EQP_SWP_Dung",
  "EQP_IT_BayonetWest",
  "EQP_IT_ShotShell",
  "EQP_IT_Machete",
  "EQP_IT_MacheteLiquid",
  "EQP_IT_KnifeLiquid",
  "EQP_IT_PipeLiquid",
  "EQP_IT_BottleLiquid",
  "EQP_IT_ShellLiquid",
  "EQP_IT_mgs0_msbl0",
  "EQP_IT_DDogStunLod",

  "EQP_IT_Infected",--tex likely requires the specific mission assets

  --special weapons
  "EQP_WP_Wood_ar_010",
  --no go
  "EQP_WP_Quiet_sr_010",
  "EQP_WP_Quiet_sr_020",
  "EQP_WP_Quiet_sr_030",
  "EQP_WP_BossQuiet_sr_010",
  "EQP_WP_Pr_sm_010",
  "EQP_WP_Pr_ar_010",
  "EQP_WP_Pr_sg_010",
  "EQP_WP_Pr_sr_010",
  "EQP_WP_mgm0_mgun0",

  "EQP_WP_HoneyBee",
  "EQP_WP_Volgin_sg_010",--no go
  "EQP_WP_SkullFace_hg_010",--holds weird, its actual use in its mission has it's own custom animation?

  --hang on load --re test
  "EQP_WP_DEBUG_sr_010",
  "EQP_WP_DEMO_ar_010",
  "EQP_WP_DEMO_ar_020",
  "EQP_WP_DEMO_ar_030",
  "EQP_WP_DEMO_sr_010",
  "EQP_WP_DEMO_hg_010",
  "EQP_WP_DEMO_hg_020",
  "EQP_WP_DEMO_hg_030",
  "EQP_WP_DEMO_sm_010",
  "EQP_WP_DEMO_sm_020",
  "EQP_WP_DEMO_mg_010",
  "EQP_WP_DEMO_ms_010",
  "EQP_WP_DEMO_ms_020",

  "EQP_WP_SP_hg_010",
  "EQP_WP_SP_hg_020",
  "EQP_WP_SP_sm_010",
  "EQP_WP_SP_sg_010",

  "EQP_WP_SP_SLD_010",
  "EQP_WP_SP_SLD_010_G01",
  "EQP_WP_SP_SLD_010_G02",
  "EQP_WP_SP_SLD_020",
  "EQP_WP_SP_SLD_020_G01",
  "EQP_WP_SP_SLD_020_G02",
  "EQP_WP_SP_SLD_030",
  "EQP_WP_SP_SLD_030_G01",
  "EQP_WP_SP_SLD_030_G02",
  "EQP_WP_SP_SLD_040",
  "EQP_WP_SP_SLD_040_G01",
  "EQP_WP_SP_SLD_040_G02",

  --not equipable, hang on equip
  "EQP_AM_10001",
  "EQP_AM_10003",
  "EQP_AM_10015",
  "EQP_AM_10101",
  "EQP_AM_10103",
  "EQP_AM_10125",
  "EQP_AM_10134",
  "EQP_AM_10201",
  "EQP_AM_10203",
  "EQP_AM_10214",
  "EQP_AM_10302",
  "EQP_AM_10303",
  "EQP_AM_10305",
  "EQP_AM_10403",
  "EQP_AM_10404",
  "EQP_AM_10405",
  "EQP_AM_10407",
  "EQP_AM_10503",
  "EQP_AM_10515",
  "EQP_AM_10526",
  "EQP_AM_20002",
  "EQP_AM_20003",
  "EQP_AM_20005",
  "EQP_AM_20103",
  "EQP_AM_20104",
  "EQP_AM_20105",
  "EQP_AM_20106",
  "EQP_AM_20116",
  "EQP_AM_20203",
  "EQP_AM_20206",
  "EQP_AM_20302",
  "EQP_AM_20303",
  "EQP_AM_20304",
  "EQP_AM_20305",
  "EQP_AM_30001",
  "EQP_AM_30003",
  "EQP_AM_30014",
  "EQP_AM_30034",
  "EQP_AM_30043",
  "EQP_AM_30047",
  "EQP_AM_30054",
  "EQP_AM_30055",
  "EQP_AM_30102",
  "EQP_AM_30103",
  "EQP_AM_30123",
  "EQP_AM_30125",
  "EQP_AM_30201",
  "EQP_AM_30203",
  "EQP_AM_30223",
  "EQP_AM_30225",
  "EQP_AM_30232",
  "EQP_AM_30303",
  "EQP_AM_30305",
  "EQP_AM_30306",
  "EQP_AM_30325",
  "EQP_AM_40001",
  "EQP_AM_40004",
  "EQP_AM_40012",
  "EQP_AM_40015",
  "EQP_AM_40023",
  "EQP_AM_40102",
  "EQP_AM_40105",
  "EQP_AM_40115",
  "EQP_AM_40123",
  "EQP_AM_40126",
  "EQP_AM_40133",
  "EQP_AM_40135",
  "EQP_AM_40136",
  "EQP_AM_40143",
  "EQP_AM_40203",
  "EQP_AM_40204",
  "EQP_AM_40206",
  "EQP_AM_40304",
  "EQP_AM_50102",
  "EQP_AM_50115",
  "EQP_AM_50126",
  "EQP_AM_50147",
  "EQP_AM_50136",
  "EQP_AM_50202",
  "EQP_AM_50215",
  "EQP_AM_50226",
  "EQP_AM_50237",
  "EQP_AM_50303",
  "EQP_AM_50304",
  "EQP_AM_50306",
  "EQP_AM_60001",
  "EQP_AM_60007",
  "EQP_AM_60013",
  "EQP_AM_60102",
  "EQP_AM_60107",
  "EQP_AM_60114",
  "EQP_AM_60203",
  "EQP_AM_60303",
  "EQP_AM_60315",
  "EQP_AM_60325",
  "EQP_AM_60404",
  "EQP_AM_60406",
  "EQP_AM_60415",
  "EQP_AM_60417",
  "EQP_AM_70002",
  "EQP_AM_70003",
  "EQP_AM_70005",
  "EQP_AM_70103",
  "EQP_AM_70104",
  "EQP_AM_70105",
  "EQP_AM_70114",
  "EQP_AM_70115",
  "EQP_AM_70116",
  "EQP_AM_70203",
  "EQP_AM_70204",
  "EQP_AM_70205",
  "EQP_AM_Quiet_sr_010",
  "EQP_AM_Quiet_sr_020",
  "EQP_AM_Quiet_sr_030",
  "EQP_AM_Pr_sm_010",
  "EQP_AM_Pr_ar_010",
  "EQP_AM_Pr_sg_010",
  "EQP_AM_Pr_sr_010",
  "EQP_AM_SkullFace_hg_010",
  "EQP_AM_SP_hg_010",
  "EQP_AM_SP_hg_020",
  "EQP_AM_SP_sm_010",
  "EQP_AM_SP_sg_010",
  "EQP_AM_EX_hg_000",
  "EQP_AM_EX_gl_000",
  "EQP_BL_EX_gl_000",
  "EQP_AM_EX_sr_000",
  "EQP_AM_1003a",
  "EQP_AM_70125",
  "EQP_AM_70126",
  "EQP_AM_70127",
  "EQP_BL_ms02Fulton",
  "EQP_AM_EX_hg_010",
  "EQP_BL_HgGrenade",
  "EQP_BL_HgGrenade",
  "EQP_BL_HgSmoke",
  "EQP_BL_HgSleep",
  "EQP_BL_HgStun",
  "EQP_BL_40mmGrenade",
  "EQP_BL_40mmSmoke",
  "EQP_BL_40mmSleep",
  "EQP_BL_40mmStun",
  "EQP_BL_20mmGrenade",
  "EQP_BL_20mmRocket",
  "EQP_BL_20mmSmoke",
  "EQP_BL_20mmSleep",
  "EQP_BL_20mmStun",
  "EQP_BL_ms00",
  "EQP_BL_ms00_G2",
  "EQP_BL_ms00_G3",
  "EQP_BL_ms02",
  "EQP_BL_ms02_G2",
  "EQP_BL_ms02_G3",
  "EQP_BL_ms02Sleep",
  "EQP_BL_ms02F",
  "EQP_BL_ms02F_G2",
  "EQP_BL_ms02F_G3",
  "EQP_BL_ms03",
  "EQP_BL_ms03_G2",
  "EQP_BL_ms03_G3",
  "EQP_BL_ms03_G4",
  "EQP_BL_ms01",
  "EQP_BL_ms01_G2",
  "EQP_BL_ms01_G3",
  "EQP_BL_ms01_G4",
  "EQP_BL_ms01_Child",
  "EQP_BL_ms01_G2_Child",
  "EQP_BL_ms01_G3_Child",
  "EQP_BL_ms01_G4_Child",
  "EQP_BL_RocketPunchStun",
  "EQP_BL_RocketPunchBlast",
  "EQP_BL_uth0_ammo0",
  "EQP_BL_uth0_ammo1",
  "EQP_BL_mgm0_ammo0",
  "EQP_BL_mgm0_cmn_ammo0",
  "EQP_BL_mgm0_cmn_ammo1",
  "EQP_BL_mgm0_famo0",
  "EQP_BL_mgs0_miss1",
  "EQP_BL_mgs0_miss0",
  "EQP_BL_mgs0_srcm0",
  "EQP_BL_mgs0_grnd0",
  "EQP_BL_Mortar",
  "EQP_BL_Flare",
  "EQP_BL_Cannon",
  "EQP_BL_WavCannon",
  "EQP_BL_WavCannonHoming",
  "EQP_BL_TankCannon",
  "EQP_BL_TankCannonHoming",
  "EQP_BL_WavRocket",
  "EQP_BL_Tankgun_105mmRifledBoreGun",
  "EQP_BL_Tankgun_120mmSmoothBoreGun",
  "EQP_BL_Tankgun_125mmSmoothBoreGun",
  "EQP_BL_Tankgun_105mmRifledBoreGun_Homing",
  "EQP_BL_Tankgun_120mmSmoothBoreGun_Homing",
  "EQP_BL_Tankgun_125mmSmoothBoreGun_Homing",
  "EQP_BL_Tankgun_82mmRocketPoweredProjectile",
  "EQP_BL_Tankgun_MultipleRocketLauncher",
  "EQP_BL_SupplyBomb",
  "EQP_BL_SupplySmoke",
  "EQP_BL_SupplySleep",
  "EQP_BL_SupplyChaff",
  "EQP_BL_UavGrenade",
  "EQP_BL_UavSmokeGrenade",
  "EQP_BL_UavSleepGasGrenade",
}

--tex DEBUG, requires EquipIdTable.lua in build
function this.CheckTppEquipTable()
  InfMenu.DebugPrint"Checking InfEquip.tppEquipTable>TppEquip id"
  local equipIdToString={}
  for i,equipIdStr in ipairs(this.tppEquipTable)do
    local equipId=TppEquip[equipIdStr]
    if equipId==nil then
      InfMenu.DebugPrint("Could not find "..tostring(equipIdStr))
    else
      equipIdToString[equipId]=equipIdStr
    end
  end

  InfMenu.DebugPrint"Checking TppEquip id>InfEquip.tppEquipTable"
  for i,equipInfo in pairs(EquipIdTable.equipIdTable)do
    local equipId=equipInfo[1]
    local equipIdStr=this.tppEquipTable[equipId]
    if equipIdStr==nil then
      InfMenu.DebugPrint("Could not find equipid:"..tostring(equipId).." EquipIdTable index:"..i)
    end
  end
end

--TUNE
this.itemDropInfo={
  SUPPORT_ITEMS=5,--nades mags and bait
  ITEMS_MISC=3,
  HANDGUNS=1,
--DRUGS=1,--no world model, equips to set level amount
--SUPPORT_FLARE=1,--not if support disabled
}

this.soldierDropTable={
  SUPPORT_ITEMS={
    "EQP_SWP_Grenade",
    "EQP_SWP_SmokeGrenade",
    "EQP_SWP_StunGrenade",
    "EQP_SWP_SleepingGusGrenade",
    "EQP_SWP_MolotovCocktail",

    "EQP_SWP_C4",
  },
  ITEMS_MISC={
    "EQP_SWP_Magazine",
    "EQP_SWP_Kibidango",--animal bait
  },
  HANDGUNS={
    "EQP_WP_West_hg_010",--AM D114 grade 1 -- PFs and DD hangun
    "EQP_WP_West_hg_020",--AM D114 with silencer(on icon) but no ext mag?  grade 4, skull normal strong
    "EQP_WP_West_hg_030_cmn",----geist p3, machine pistol grade ?, no name/icon
    "EQP_WP_East_hg_010",--burkov grade 1, sov normal strong

    --"EQP_WP_West_thg_010",--wu s.pistol grade 1
    "EQP_WP_West_thg_020",--grade 2
    --"EQP_WP_West_thg_030",--wu s pistol inf supressor grade 5
    "EQP_WP_West_thg_040",--grade 5
    --"EQP_WP_West_thg_050",--wu s pistol cb grade7
    "EQP_WP_EX_hg_000",--AM A114 RP, DD, silencer, grade 7
    --"EQP_WP_EX_hg_000_G01",--AM A114 RP grade 8 - silencer, gas cloud
    "EQP_WP_EX_hg_010",--tornado 6 grade 3
  },
  DRUGS={
    "EQP_IT_Pentazemin",
    "EQP_IT_Clairvoyance",
    "EQP_IT_ReflexMedicine",
  },
}

function this.LoadEquipTable()
  local equipLoadTable={}
  --tex TODO: find a better indicator of equipable mission loading

  for n,equipName in ipairs(this.tppEquipTableTest)do
    local equipId=TppEquip[equipName]
    if equipId~=nil then
      equipLoadTable[#equipLoadTable+1]=equipId
    end
  end

  --tex TODO only seems to be for weapons not items (see RequestLoadToEquipMissionBlock)
  --for category,equipNames in pairs(this.soldierDropTable)do
  --for n,equipName in ipairs(equipNames)do

  for n,equipName in ipairs(this.soldierDropTable.HANDGUNS)do
    local equipId=TppEquip[equipName]
    if equipId~=nil then
      equipLoadTable[#equipLoadTable+1]=equipId
    end
  end
  --end

  if #equipLoadTable>0 and TppEquip.RequestLoadToEquipMissionBlock then
    TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)
  end
end

function this.Messages()
  return Tpp.StrCode32Table {
    GameObject = {
      {msg="Neutralize",func=this.OnNeutralize},
    },
    Timer={
      {msg="Finish",sender="Timer_DropItem",func=this.DropItem},
    },
  }
end
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  if TppMission.IsFOBMission(vars.missionCode)then
    return
  end

  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end
function this.Init(missionTable)
  if TppMission.IsFOBMission(vars.missionCode)then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())

  this.inf_lastNeutralized={}

  this.dropChanceBag=InfMain.ShuffleBag:New()
  for i=1,Ivars.perSoldierCount do
    local amount=1
    this.dropChanceBag:Add(i,amount)
  end

  this.dropItemBag=InfMain.ShuffleBag:New()
  for name,amount in pairs(this.itemDropInfo) do
    this.dropItemBag:Add(name,amount)
  end
end

function this.OnReload(missionTable)
  if TppMission.IsFOBMission(vars.missionCode)then
    return
  end

  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
--TUNE
local dropTimeOut=7*60
local dropTimer=0.6

this.inf_lastNeutralized={}
this.inf_dropQueue={}

function this.OnNeutralize(gameId,sourceId,neutralizeType,neutralizeCause)
  --InfInspect.TryFunc(function(gameId,sourceId,neutralizeType,neutralizeCause)--DEBUG
  local dropChance=Ivars.itemDropChance:Get()/Ivars.perSoldierCount
  if dropChance==0 then
    return
  end

  --tex have to manage table since reinforcements re-use gameobjects
  --a timeout after a few minutes should be fine
  local elapsedTime=Time.GetRawElapsedTimeSinceStartUp()
  for _gameId,dropTimer in pairs(this.inf_lastNeutralized) do
    if dropTimer<elapsedTime then
      this.inf_lastNeutralized[_gameId]=nil
    elseif _gameId==gameId then
      --InfMenu.DebugPrint"Neutralize - timeout not complete"--DEBUG
      return
    end
  end
  this.inf_lastNeutralized[gameId]=elapsedTime+dropTimeOut

  --    local neutralizeTypes={
  --      [NeutralizeType.INVALID]="INVALID",
  --      [NeutralizeType.DEAD]="DEAD",
  --      [NeutralizeType.FAINT]="FAINT",
  --      [NeutralizeType.SLEEP]="SLEEP",
  --      [NeutralizeType.DYING]="DYING",
  --      [NeutralizeType.FULTON]="FULTON",
  --    }

  --InfMenu.DebugPrint("Neutralize gameId:"..gameId.." sourceId:"..sourceId.. " neutralizeType:"..neutralizeTypes[neutralizeType].." neutralizeCause:"..neutralizeCause)--DEBUG
  if this.dropChanceBag:Next()<=dropChance then
    --      GkEventTimerManager.Start("Timer_DropItem",dropTimer)
    --      this.inf_dropQueue[#this.inf_dropQueue]=gameId
    this.DropItem(gameId)
  end
  --end,gameId,sourceId,neutralizeType,neutralizeCause)--DEBUG
end

--tex drop system a bit convoluted
--decision whether to drop an item or nothing handled in OnNeutralize by dropChanceBag shufflebag (to get a consistant rate)
--then dropItemBag chooses a category, and a random item from that category in soldierDropTable is chosen
function this.DropItem(gameId)
  --  local gameId=this.inf_dropQueue[1]
  --  table.remove(this.inf_dropQueue,1)
  local category=this.dropItemBag:Next()
  local categoryTable=this.soldierDropTable[category]
  local equipName=categoryTable[math.random(#categoryTable)]

  local equipId=TppEquip[equipName]

  --InfMenu.DebugPrint("drop "..equipName)--DEBUG

  --TUNE
  local number=1
  if category=="HANDGUNS" then
    number=math.random(14,26)
  end

  local linearMax=0.1
  local angularMax=4

  local dropOffsetY=1.2

  local dropPosition=GameObject.SendCommand(gameId,{id="GetPosition"})
  dropPosition=Vector3(dropPosition:GetX(),dropPosition:GetY()+dropOffsetY,dropPosition:GetZ())

  TppPickable.DropItem{
    equipId=equipId,
    number=number,
    position=dropPosition,
    rotation=Quat.RotationY(0),
    linearVelocity=Vector3(math.random(-linearMax,linearMax),math.random(-linearMax,linearMax),math.random(-linearMax,linearMax)),
    angularVelocity=Vector3(math.random(-angularMax,angularMax),math.random(-angularMax,angularMax),math.random(-angularMax,angularMax)),
  }

end

--tex TODO: convert equipidstring to equipid once you mock TppEquip equipid enums
--local pickables={
--  --equipid string={"<locator prefix>",<count>},
--  EQP_SWP_CaptureCage_G02={"pickable_item_capturecage_",1},
--  EQP_IT_CBox_WR={"pickable_item_cardboardbox_",1},
--}

local pickables={
  afgh={--WORKAROUND
    "pickable_ih_0000",--EQP_WP_East_ms_020--4283898693--cgm 25
    --"pickable_ih_0001",--EQP_WP_EX_sr_000--2090616205--molotok-68 grade 9
    "pickable_ih_0002",--EQP_WP_EX_gl_000--4169556718--miraz zh 71 grade 9
    "pickable_ih_0003",--EQP_SWP_CaptureCage_G02--452941044
    "pickable_ih_0004",--EQP_IT_CBox_WR--3040902098
    "pickable_ih_0005",--EQP_AB_PrimaryMissile--165673314
    "pickable_ih_0006",--EQP_AB_SecondaryTranq--550443242
  --v- TODO: these don't load in afgh for some reason
  --  "pickable_ih_0007",--EQP_AB_Suppressor--2248319796
  --  "pickable_ih_0008",--EQP_AB_Mecha--1087922814
  --  "pickable_ih_0009",--EQP_WP_West_ms_020--1022605058--fb mr rl nlsp
  --  "pickable_ih_0010",--EQP_SWP_SupportHeliFlareGrenade--2929309074
  --  "pickable_ih_0011",--EQP_SWP_SupplyFlareGrenade--160773547
  },
  mafr={
    "pickable_ih_0000",--EQP_WP_East_ms_020--4283898693--cgm 25
    --"pickable_ih_0001",--EQP_WP_EX_sr_000--2090616205--molotok-68 grade 9
    "pickable_ih_0002",--EQP_WP_EX_gl_000--4169556718--miraz zh 71 grade 9
    "pickable_ih_0003",--EQP_SWP_CaptureCage_G02--452941044
    "pickable_ih_0004",--EQP_IT_CBox_WR--3040902098
    "pickable_ih_0005",--EQP_AB_PrimaryMissile--165673314
    "pickable_ih_0006",--EQP_AB_SecondaryTranq--550443242
    "pickable_ih_0007",--EQP_AB_Suppressor--2248319796
    "pickable_ih_0008",--EQP_AB_Mecha--1087922814
    "pickable_ih_0009",--EQP_WP_West_ms_020--1022605058--fb mr rl nlsp
    "pickable_ih_0010",--EQP_SWP_SupportHeliFlareGrenade--2929309074
    "pickable_ih_0011",--EQP_SWP_SupplyFlareGrenade--160773547
  },
}
--
function this.PutEquipOnTrucks()
  if Ivars.vehiclePatrolProfile:Is(0) or not Ivars.vehiclePatrolProfile:MissionCheck() then
    return
  end

  if Ivars.vehiclePatrolTruckEnable:Is(0) then
    return
  end

  if Ivars.putEquipOnTrucks:Is(0) then
    return
  end

  InfMain.RandomSetToLevelSeed()
  local locationName=InfMain.GetLocationName()
  local pickableBag=InfMain.ShuffleBag:New(pickables[locationName])
  local pickableCount=pickableBag:Count()

  if mvars.inf_patrolVehicleInfo then
    local truckStr="TRUCK"
    local numPutOn=0
    for vehicleName,vehicleInfo in pairs(mvars.inf_patrolVehicleInfo) do
      if vehicleInfo.baseType==truckStr then
        local vehicleId=GetGameObjectId(vehicleName)
        if vehicleId~=NULL_ID then

          local itemLocator=pickableBag:Next()
          --InfMenu.DebugPrint("PutOn "..vehicleName.." "..itemLocator)--DEBUG
          TppPickable.PutOn(itemLocator,vehicleId,0)
          numPutOn=numPutOn+1
          if numPutOn==pickableCount then
            break
          end
        end
      end
    end
  end
  InfMain.RandomResetToOsTime()
  --end)--
end

return this
