--TppEnemyBodyId.lua
--tex NMC: maps bodyIdName (usually similar to the fv2 name) to bodyId.
--bodyIds are defined in Soldier2FacaAndBodyData.bodyDefinition entries, which also map the bodyFova index which lists the the actual fv2 path and fpk
--GOTCHA: initially thought the numbers might be bodyIdName=bodyDefinition index, but the names match the fv2 names for the bodyDefinition with the same bodyId as number
--In a lot of cases these aren't used and the bodyId is used directly
--and in some cases the mapping is incorrect (see note on pfs0_dds0_v00 below)
--DYNAMIC: ADDON: added to by IH InfSoldierFaceAndBody
local this={
  --[bodyIdName]=<bodyId>,
  --SOVIET see TppEnemy.bodyIdTable
  svs0_rfl_v00_a=0,
  svs0_rfl_v01_a=1,
  svs0_rfl_v02_a=2,
  svs0_mcg_v00_a=5,
  svs0_mcg_v01_a=6,
  svs0_mcg_v02_a=7,
  svs0_snp_v00_a=10,
  svs0_rdo_v00_a=11,
  svs0_rfl_v00_b=20,
  svs0_rfl_v01_b=21,
  svs0_rfl_v02_b=22,
  svs0_mcg_v00_b=25,
  svs0_mcg_v01_b=26,
  svs0_mcg_v02_b=27,
  svs0_snp_v00_b=30,
  svs0_rdo_v00_b=31,
  sva0_v00_a=49,
  --PF see TppEnemy.bodyIdTable
  pfs0_rfl_v00_a=50,
  pfs0_rfl_v01_a=51,
  pfs0_mcg_v00_a=55,
  pfs0_snp_v00_a=60,
  pfs0_rdo_v00_a=61,
  pfs0_rfl_v00_b=70,
  pfs0_rfl_v01_b=71,
  pfs0_mcg_v00_b=75,
  pfs0_snp_v00_b=80,
  pfs0_rdo_v00_b=81,
  pfs0_rfl_v00_c=90,
  pfs0_rfl_v01_c=91,
  pfs0_mcg_v00_c=95,
  pfs0_snp_v00_c=100,
  pfs0_rdo_v00_c=101,
  --pf armor
  pfa0_v00_b=107,
  pfa0_v00_c=108,
  pfa0_v00_a=109,
  --prisoners
  prs2_main0_v00=110,
  prs5_main0_v00=111,
  prs3_main0_v00=112,
  prs6_main0_v00=113,
  --children
  chd0_v00=115,
  chd0_v01=116,
  chd0_v02=117,
  chd0_v03=118,
  chd0_v04=119,
  chd0_v05=120,
  chd0_v06=121,
  chd0_v07=122,
  chd0_v08=123,
  chd0_v09=124,
  chd0_v10=125,
  chd0_v11=126,
  chd1_v00=130,
  chd1_v01=131,
  chd1_v02=132,
  chd1_v03=133,
  chd1_v04=134,
  chd1_v05=135,

  dds0_main1_v00=140,
  dds0_main1_v01=141,
  dds3_main0_v00=142,
  dds5_main0_v00=143,
  dds5_main0_v01=144,--tex NMC incomplete fovaPathInfo, fv2 used in demos, cant see any usage of bodyId either through this or as direct id.
  dds5_main0_v02=145,--tex as above

  ddr0_main0_v00=146,--tex NMC fovaSetupFuncs.mbqf/shining lights>
  ddr0_main0_v01=147,
  ddr0_main0_v02=148,

  ddr0_main1_v00=149,
  ddr0_main1_v01=150,
  ddr0_main1_v02=151,--tex NMC incomplete fovaPathInfo, though is in ddr0 pack. direct reference to bodyId in fovaSetupFuncs.mbqf
  ddr0_main1_v03=152,
  ddr0_main1_v04=153,

  ddr1_main0_v00=154,
  ddr1_main0_v01=155,
  ddr1_main0_v02=156,

  ddr1_main1_v00=157,
  ddr1_main1_v01=158,--<
  ddr1_main1_v02=159,--?

  dds3_main0_v01=160,--tex NMC incomplete fovaPathInfo, direct refrence in mtbs_enemy.SetupSortieSoldierFovaForMemoryDump ?
  dds5_main0_v03=161,--as above, but no direct refs
  dds6_main0_v00=162,--tex NMC incomplete fovaPathInfo, and fv2 doesnt exist
  dds6_main0_v01=163,
  dds8_main0_v00=164,
  dds8_main0_v01=165,--tex NMC incomplete fovaPathInfo, and fv2 doesnt exist

  ddr0_main0_v03=166,--tex NMC incomplete fovaPathInfo, fv2 in s10240 shining lights, no direct references?
  ddr0_main0_v04=167,--tex NMC as above

  ddr0_main1_v05=168,--tex NMC as above
  ddr0_main1_v06=169,--tex NMC as above

  dds3_main0_v02=170,--tex NMC incomplete fovaPathInfo,
  dds8_main0_v02=171,--tex NMC fv2 file doesnt exist?

  dds4_enem0_def=172,
  dds4_enef0_def=173,
  dds5_enem0_def=174,
  dds5_enef0_def=175,
  dds5_main0_v04=176,
  dla0_plym0_def=177,
  dla1_plym0_def=178,
  dlb0_plym0_def=179,
  dlc0_plyf0_def=180,
  dlc1_plyf0_def=181,
  dld0_plym0_def=182,
  dle0_plyf0_def=183,
  dle1_plyf0_def=184,

  wss4_main0_v00=190,
  wss4_main0_v01=191,--tex NMC incomplete fovaPathInfo
  wss4_main0_v02=192,--as above
  wss0_main0_v00=195,
  wss3_main0_v00=196,

  prs2_main0_v01=200,
  prs5_main0_v01=201,
  prs3_main0_v01=202,
  prs6_main0_v01=203,
  --children
  chd2_v00=205,
  chd2_v01=206,
  chd2_v02=207,
  chd2_v03=208,
  chd2_v04=209,
  --unique bodies
  pfs0_unq_v210=250,
  pfs0_unq_v250=251,
  pfs0_unq_v360=253,
  pfs0_unq_v280=254,
  pfs0_unq_v150=255,
  pfs0_unq_v220=256,
  svs0_unq_v010=257,
  svs0_unq_v080=258,
  svs0_unq_v020=259,
  svs0_unq_v040=260,
  svs0_unq_v050=261,
  svs0_unq_v060=262,
  svs0_unq_v100=263,
  pfs0_unq_v140=264,
  pfs0_unq_v241=265,
  pfs0_unq_v242=266,
  pfs0_unq_v450=267,
  svs0_unq_v070=268,
  svs0_unq_v071=269,
  svs0_unq_v072=270,
  svs0_unq_v420=271,
  pfs0_unq_v440=272,
  svs0_unq_v009=273,
  svs0_unq_v421=274,
  pfs0_unq_v155=275,
  --RETAILBUG pfs and svs dds are swapped (svs is 280>289, pfs is 290>299), like a lot of bugs overlooked because it wasn't used (TppDefine.QUEST_BODY_ID_LIST was used instead)
  --lost msf soldiers mafr
  pfs0_dds0_v00=280,--
  pfs0_dds0_v01=281,--
  pfs0_dds0_v02=282,
  pfs0_dds0_v03=283,
  pfs0_dds0_v04=284,
  pfs0_dds0_v05=285,
  pfs0_dds0_v06=286,
  pfs0_dds0_v07=287,--
  pfs0_dds0_v08=288,--
  pfs0_dds0_v09=289,--
  --lost msf soldiers afgh
  svs0_dds0_v00=290,
  svs0_dds0_v01=291,
  svs0_dds0_v02=292,--
  svs0_dds0_v03=293,--
  svs0_dds0_v04=294,--
  svs0_dds0_v05=295,--
  svs0_dds0_v06=296,
  svs0_dds0_v07=297,--
  svs0_dds0_v08=298,
  svs0_dds0_v09=299,
  --cyprus hospital patients
  ptn0_v00=300,
  ptn0_v01=301,
  ptn0_v02=302,
  ptn0_v03=303,
  ptn0_v04=304,
  ptn0_v05=305,
  ptn0_v06=306,
  ptn0_v07=307,
  ptn0_v08=308,
  ptn0_v09=309,
  ptn0_v10=310,
  ptn0_v11=311,
  ptn0_v12=312,
  ptn0_v13=313,
  ptn0_v14=314,
  ptn0_v15=315,
  ptn0_v16=316,
  ptn0_v17=317,
  ptn0_v18=318,
  ptn0_v19=319,
  ptn0_v20=320,
  ptn0_v21=321,
  ptn0_v22=322,
  ptn0_v23=323,
  ptn0_v24=324,
  ptn0_v25=325,
  ptn0_v26=326,
  ptn0_v27=327,
  ptn0_v28=328,
  ptn0_v29=329,
  ptn0_v30=330,
  ptn0_v31=331,
  ptn0_v32=332,
  ptn0_v33=333,
  ptn0_v34=334,
  ptn1_v00=335,--tex NMC incomplete fovaPathInfo. fv2 does not exist
  ptn2_v00=336,--as above
  --cyprus hospital nurses
  nrs0_v00=340,
  nrs0_v01=341,
  nrs0_v02=342,
  nrs0_v03=343,
  nrs0_v04=344,
  nrs0_v05=345,
  nrs0_v06=346,
  nrs0_v07=347,
  --cyprus hospital doc
  dct0_v00=348,
  dct0_v01=349,

  plh0_v00=350,
  plh0_v01=351,
  plh0_v02=352,
  plh0_v03=353,
  plh0_v04=354,
  plh0_v05=355,
  plh0_v06=356,
  plh0_v07=357,
  --ocellot
  oce0_main0_v00=370,
  oce0_main0_v01=371,
  oce0_main0_v02=372,

  prs7_main0_v00=373,
  prs7_main0_v01=374,

  wsp_def=375,
  wsp_dam=376,
  --huey
  hyu0_main0_v00=377,
  hyu0_main0_v01=378,
  hyu0_main0_v02=379,
  --ishmael
  ish0_v00=380,
  ish0_v01=381,
  --RETAILPATCH 1.10>
  --swimwear
  dlf_enem0_def=382,
  dlf_enef0_def=383,
  dlf_enem1_def=384,
  dlf_enef1_def=385,
  dlf_enem2_def=386,
  dlf_enef2_def=387,
  dlf_enem3_def=388,
  dlf_enef3_def=389,
  dlf_enem4_def=390,
  dlf_enef4_def=391,
  dlf_enem5_def=392,
  dlf_enef5_def=393,
  dlf_enem6_def=394,
  dlf_enef6_def=395,
  dlf_enem7_def=396,
  dlf_enef7_def=397,
  dlf_enem8_def=398,
  dlf_enef8_def=399,
  dlf_enem9_def=400,
  dlf_enef9_def=401,
  dlf_enem10_def=402,
  dlf_enef10_def=403,
  dlf_enem11_def=404,
  dlf_enef11_def=405,
  --<
  --RETAILPATCH 1.0.11>
  dlg_enem0_def=406,
  dlg_enef0_def=407,
  dlg_enem1_def=408,
  dlg_enef1_def=409,
  dlg_enem2_def=410,
  dlg_enef2_def=411,
  dlg_enem3_def=412,
  dlg_enef3_def=413,
  dlg_enem4_def=414,
  dlg_enef4_def=415,
  dlg_enem5_def=416,
  dlg_enef5_def=417,
  dlg_enem6_def=418,
  dlg_enef6_def=419,
  dlg_enem7_def=420,
  dlg_enef7_def=421,
  dlg_enem8_def=422,
  dlg_enef8_def=423,
  dlg_enem9_def=424,
  dlg_enef9_def=425,
  dlg_enem10_def=426,
  dlg_enef10_def=427,
  dlg_enem11_def=428,
  dlg_enef11_def=429,
  
  dlh_enem0_def=430,
  dlh_enef0_def=431,
  dlh_enem1_def=432,
  dlh_enef1_def=433,
  dlh_enem2_def=434,
  dlh_enef2_def=435,
  dlh_enem3_def=436,
  dlh_enef3_def=437,
  dlh_enem4_def=438,
  dlh_enef4_def=439,
  dlh_enem5_def=440,
  dlh_enef5_def=441,
  dlh_enem6_def=442,
  dlh_enef6_def=443,
  dlh_enem7_def=444,
  dlh_enef7_def=445,
  dlh_enem8_def=446,
  dlh_enef8_def=447,
  dlh_enem9_def=448,
  dlh_enef9_def=449,
  dlh_enem10_def=450,
  dlh_enef10_def=451,
  dlh_enem11_def=452,
  dlh_enef11_def=453,
  --<
}
return this
