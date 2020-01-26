-- DOBUILD: 1
-- NODEPS
local this = {}
local StrCode32=Fox.StrCode32

--indexed by mbLayout or 0 where layout n/a
local groundStartPositionsInitial={
  {--0 or no layout
    --tex built from /Assets/tpp/ui/Script/mbdvc_map_mission_parameter.lua, intial 'drop' lzs, other lzs in game are called 'assault' lzs??
    --story missions unique lzs
    ["lz_drp_hillNorth_W0000|rt_drp_hillNorth_W_0000"]={pos={1734.22,66.01,-407.54},},
    ["lz_drp_outland_N0000|rt_drp_outland_N_0000"]={pos={-807.61,3.47,516.01},},
    ["rts_drp_lab_S_0000"]={pos={2441.72,78.25,-1191.68},},
    ["rt_drp_mbqf_N"]={pos={-162.70,4.97,-2105.86},},
    --[30010]
    ["lz_drp_enemyBase_N0000|rt_drp_enemyBase_N_0000"]={pos={-289.80,346.69,269.68},},
    ["lz_drp_field_N0000|rt_drp_field_N_0000"]={pos={802.56,345.37,1637.75},rotY=108.72},
    ["lz_drp_enemyBase_S0000|rt_drp_enemyBase_S_0000"]={pos={-351.61,321.89,768.34},},
    ["lz_drp_citadelSouth_S0000|rt_drp_citadelSouth_S_0000"]={pos={-1663.71,536.63,-2201.78},},
    ["lz_drp_commFacility_S0000|rt_drp_commFacility_S_0000"]={pos={1651.17,353.38,587.98},},
    ["lz_drp_cliffTown_N0000|rt_drp_clifftown_N_0000"]={pos={834.42,451.21,-1420.10},},
    ["lz_drp_sovietBase_N0000|rt_drp_sovietBase_N_0000"]={pos={-1718.06,474.38,-1713.62},},
    ["lz_drp_cliffTownWest_S0000|rt_drp_cliffTownWest_S_0000"]={pos={64.77,434.32,-842.65},},
    ["lz_drp_field_W0000|rt_drp_field_W_0000"]={pos={-359.62,283.42,1714.79},rotY=108.72},
    ["lz_drp_field_I0000|rt_drp_field_I_0000"]={pos={418.33,278.22,2261.37},rotY=102.35},
    ["lz_drp_remnantsNorth_N0000|rt_drp_remnantsNorth_N_0000"]={pos={-836.84,288.90,1574.03},},
    ["lz_drp_fort_E0000|rt_drp_fort_E_0000"]={pos={2305.28,394.03,-923.73},},
    ["lz_drp_slopedTownEast_E0000|rt_drp_slopedTownEast_E_0000"]={pos={1187.73,320.98,-10.40},},
    ["lz_drp_commFacility_I0000|rt_drp_commFacility_I_0000"]={pos={1444.40,364.14,390.78},rotY=42.41},
    ["lz_drp_waterway_I0000|rt_drp_waterway_I_0000"]={pos={-1677.59,360.88,-321.82},},
    ["lz_drp_sovietBase_S0000|rt_drp_sovietBase_S_0000"]={pos={-1949.57,439.73,-1170.39},},
    ["lz_drp_powerPlant_S0000|rt_drp_powerPlant_S_0000"]={pos={-630.25,444.69,-910.73},},
    ["lz_drp_bridge_S0000|rt_drp_bridge_S_0000"]={pos={1904.32,368.36,81.33},},
    ["lz_drp_fieldWest_S0000|rt_drp_fiieldWest_S_0000"]={pos={141.47,275.51,2353.44},},
    ["lz_drp_remnants_S0000|rt_drp_remnants_S_0000"]={pos={-424.83,289.10,2004.96},},
    ["lz_drp_slopedTown_E0000|rt_drp_slopedTown_E_0000"]={pos={822.37,360.44,292.44},},
    ["lz_drp_ruinsNorth_S0000|rt_drp_ruinsNorth_S_0000"]={pos={1275.22,337.42,1313.33},},
    ["lz_drp_slopedTown_I0000|rt_drp_slopedTown_I_0000"]={pos={512.11,316.60,167.44},rotY=108.72},
    ["lz_drp_fort_I0000|rt_drp_fort_I_0000"]={pos={2106.16,463.64,-1747.21},rotY=151.95},
    ["lz_drp_tent_I0000|rt_drp_tent_I_0000"]={pos={-1761.73,317.69,806.51},rotY=35.82},
    ["lz_drp_village_W0000|rt_drp_village_W_0000"]={pos={20.70,329.63,888.03},},
    ["lz_drp_remnantsNorth_S0000|rt_drp_remnantsNorth_S_0000"]={pos={-1273.30,305.48,1342.07},},
    ["lz_drp_village_N0000|rt_drp_village_N_0000"]={pos={612.73,355.48,911.22},},
    ["lz_drp_tent_N0000|rt_drp_tent_N_0000"]={pos={-1868.78,338.48,538.78},},
    ["lz_drp_tent_E0000|rt_drp_tent_E_0000"]={pos={-1372.18,318.33,934.68},},
    ["lz_drp_slopedTown_W0000|rt_drp_slopedTown_W_0000"]={pos={95.31,320.37,243.91},},
    ["lz_drp_remnants_I0000|rt_drp_remnants_I_0000"]={pos={-805.54,291.88,1820.65},rotY=-38.93},
    ["lz_drp_fort_W0000|rt_drp_fort_W_0000"]={pos={1649.11,491.21,-1340.58},},
    ["lz_drp_commFacility_W0000|rt_drp_commFacility_W_0000"]={pos={1060.06,362.05,467.90},},
    ["lz_drp_cliffTown_I0000|rt_drp_cliffTown_I0000"]={pos={759.83,452.30,-1113.10},rotY=-4.08},
    ["lz_drp_powerPlant_E0000|rt_drp_powerPlant_E_0000"]={pos={-662.20,556.88,-1489.06},rotY=-150.97},
    ["lz_drp_cliffTown_S0000|rt_drp_cliffTown_S_0000"]={pos={491.46,418.47,-693.19},},
    ["lz_drp_enemyBase_I0000|rt_drp_enemyBase_I_0000"]={pos={-596.89,353.02,497.40},rotY=176.17},
    ["lz_drp_ruins_S0000|rt_drp_ruins_S_0000"]={pos={1272.20,329.63,1853.51},},
    ["lz_drp_sovietBase_E0000|rt_drp_sovietBase_E_0000"]={pos={-2355.80,445.52,-1431.61},rotY=-5.26},
    ["lz_drp_sovietSouth_S0000|rt_drp_sovietSouth_S_0000"]={pos={-1219.28,416.14,-886.41},},
    --[30020]
    ["lz_drp_lab_W0000|rt_drp_lab_W_0000"]={pos={2331.11,208.01,-2487.00},},
    ["lz_drp_hill_I0000|rt_drp_hill_I_0000"]={pos={2154.83,63.09,366.70},rotY=83.13},
    ["lz_drp_diamond_N0000|rt_drp_diamond_N_0000"]={pos={1096.40,150.86,-1685.39},},
    ["lz_drp_swamp_S0000|rt_drp_swamp_S_0000"]={pos={-163.59,7.96,385.58},},
    ["lz_drp_savannahWest_N0000|lz_drp_savannahWest_N_0000"]={pos={510.10,20.43,-732.55},},
    ["lz_drp_diamondWest_S0000|lz_drp_diamondWest_S_0000"]={pos={924.72,44.01,-931.28},},
    ["lz_drp_swamp_I0000|rt_drp_swamp_I_0000"]={pos={-19.63,11.17,140.91},rotY=-153.76},
    ["lz_drp_pfCamp_I0000|rt_drp_pfCamp_I_0000"]={pos={846.46,-4.97,1148.62},rotY=93.6},
    ["lz_drp_savannah_I0000|rt_drp_savannah_I_0000"]={pos={1014.25,57.18,-221.46},rotY=-71.73},
    ["lz_drp_pfCamp_N0000|rt_drp_pfcamp_N_0000"]={pos={1061.84,6.78,731.21},},
    ["lz_drp_diamond_I0000|rt_drp_diamond_I_0000"]={pos={1381.85,137.05,-1516.01},rotY=51.3},
    ["lz_drp_diamondSouth_W0000|rt_drp_diamondSouth_W_0000"]={pos={1203.80,107.74,-792.16},},
    ["lz_drp_factoryWest_S0000|lz_drp_factoryWest_S_0000"]={pos={2271.82,84.84,-418.59},},
    ["lz_drp_pfCamp_S0000|lz_drp_pfCamp_S_0000"]={pos={1007.02,-4.46,1557.61},},
    ["lz_drp_swamp_N0000|lz_drp_swamp_N_0000"]={pos={-145.52,16.15,-379.20},},
    ["lz_drp_labWest_W0000|rt_drp_labWest_W_0000"]={pos={1786.78,170.73,-2130.50},},
    ["lz_drp_lab_S0000|rt_drp_lab_S_0000"]={pos={2521.90,111.82,-1833.82},},
    ["lz_drp_savannahEast_S0000|lz_drp_savannahEast_S_0000"]={pos={1119.97,10.72,317.63},},
    ["lz_drp_hillWest_S0000|lz_drp_hillWest_S_0000"]={pos={1769.46,28.60,560.59},},
    ["lz_drp_hill_N0000|lz_drp_hill_N_0000"]={pos={1951.46,49.82,88.58},},
    ["lz_drp_pfCampNorth_S0000|rt_drp_pfCampNorth_S_0000"]={pos={582.54,-3.14,418.17},},
    ["lz_drp_swamp_W0000|lz_drp_swamp_W_0000"]={pos={-618.09,6.48,232.79},},
    ["lz_drp_bananaSouth_N0000|rt_drp_bananaSouth_N_0000"]={pos={74.70,18.20,-689.41},},
    ["lz_drp_swampEast_N0000|lz_drp_swampEast_N_0000"]={pos={266.57,1.56,-234.08},},
    ["lz_drp_diamondSouth_S0000|lz_drp_diamondSouth_S_0000"]={pos={1648.35,87.11,-555.26},},
    ["lz_drp_hillSouth_W0000|lz_drp_hillSouth_W_0000"]={pos={1688.90,-3.65,1520.55},},
    ["lz_drp_banana_I0000|rt_drp_banana_I_0000"]={pos={300.61,50.06,-1237.66},rotY=-40.98},
    ["lz_drp_hill_E0000|lz_drp_hill_E_0000"]={pos={2465.21,71.47,230.49},},
    ["lz_drp_factory_N0000|rt_drp_factory_N_0000"]={pos={2441.72,78.25,-1191.68},},
    ["lz_drp_savannahEast_N0000|rt_drp_savannahEast_N_0000"]={pos={1233.17,25.84,-127.05},},
    ["lz_drp_flowStation_E0000|lz_drp_flowStation_E_0000"]={pos={-610.26,13.10,-398.20},},
    ["lz_drp_flowStation_I0000|rt_drp_flowStation_I_0000"]={pos={-1001.38,-7.20,-199.16},rotY=-178.15},
    ["lz_drp_outland_S0000|rt_drp_outland_S_0000"]={pos={-440.57,-14.39,1339.17},},
    --zoo
    ["ly500_cl00_30150_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={9.1155920028687,8.7501268386841,-42.430213928223},  },
    ["ly500_cl00_30150_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={159.4271697998,8.7501268386841,9.6170091629028} },
    ["ly500_cl00_30150_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-131.97308349609,8.7501268386841,100.23579406738} },
    ["ly500_cl00_30150_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-104.23648071289,8.7501268386841,-131.96905517578} },
    --quarantine
    ["ly003_cl07_30050_heli0000|cl07pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-162.5267791748,8.7501268386841,-2104.9208984375},  },

    --mother base - from mbdvc_map_mbstage_parameter heliLandPointTable_FreePlay, thanks NasaNhak
    ["ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={9.1155920028687,8.7501268386841,-42.430213928223}, },
    ["ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={834.69958496094,8.7501268386841,-559.33135986328}, },
    ["ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={817.86083984375,8.7501268386841,-702.79693603516}, },
    ["ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={940.71807861328,8.7501268386841,-760.60205078125}, },
    ["ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1068.4658203125,8.7501268386841,-714.60314941406}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={878.12158203125,8.7501268386841,390.92022705078}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr"]={pos={867.09564208984,37.018760681152,318.51306152344}, },
    ["ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1021.5867919922,8.7501268386841,374.08148193359}, },
    ["ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1111.1253662109,8.7501268386841,260.72958374023}, },
    ["ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1238.8725585938,8.7501268386841,306.72833251953}, },
    ["ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={559.3310546875,8.7501268386841,834.69848632813}, },
    ["ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={702.79632568359,8.7501268386841,817.85980224609}, },
    ["ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={760.60131835938,8.7501268386841,940.71697998047}, },
    ["ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={714.60266113281,8.7501268386841,1068.4644775391}, },
    ["ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1052.3092041016,8.7501268386841,-31.604196548462}, },
    ["ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1110.1140136719,8.7501268386841,-154.46151733398}, },
    ["ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1253.5795898438,8.7501268386841,-137.62275695801}, },
    ["ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1311.3845214844,8.7501268386841,-260.48007202148}, },
    ["ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-30.111001968384,8.7501268386841,1052.3082275391}, },
    ["ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={83.241088867188,8.7501268386841,1141.8471679688}, },
    ["ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={37.241870880127,8.7501268386841,1269.5948486328}, },
    ["ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={150.59407043457,8.7501268386841,1359.1336669922}, },
    ["ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-763.33709716797,8.7501268386841,731.60040283203}, },
    ["ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-891.08483886719,8.7501268386841,685.6015625}, },
    ["ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-980.62347412109,8.7501268386841,798.95379638672}, },
    ["ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1108.3712158203,8.7501268386841,752.95513916016}, },
    --retake the plat
    ["ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr"]={pos={878.28747558594,-3.498596906662,323.64611816406}, },
    ["ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr"]={pos={974.13403320313,-3.498596906662,326.39437866211}, },
    ["ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1043.8511962891,-3.498596906662,260.56399536133}, },
    ["ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1191.4196777344,-3.498596906662,259.04104614258}, },
  },
  {--1
    --mother base
    ["ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={9.1155920028687,8.7501268386841,-42.430213928223}, },
    ["ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr"]={pos={-1.9415365457535,26.005094528198,17.777017593384}, },
    ["ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={159.4271697998,8.7501268386841,9.6170091629028}, },
    ["ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={951.6923828125,8.7501268386841,-562.83123779297}, },
    ["ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={934.85363769531,8.7501268386841,-706.29681396484}, },
    ["ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1057.7108154297,8.7501268386841,-764.10192871094}, },
    ["ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1185.4586181641,8.7501268386841,-718.10302734375}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={995.11791992188,8.7501268386841,410.41690063477}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr"]={pos={984.45190429688,37.018760681152,337.64984130859}, },
    ["ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1138.5832519531,8.7501268386841,393.57818603516}, },
    ["ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1228.1217041016,8.7501268386841,280.22622680664}, },
    ["ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1355.8688964844,8.7501268386841,326.22500610352}, },
    ["ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={279.6535949707,8.7501268386841,981.46038818359}, },
    ["ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={393.00555419922,8.7501268386841,1070.9992675781}, },
    ["ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={347.00640869141,8.7501268386841,1198.7468261719}, },
    ["ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={224.14906311035,8.7501268386841,1256.5518798828}, },
    ["ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-244.19276428223,8.7501268386841,-905.35906982422}, },
    ["ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-198.19381713867,8.7501268386841,-1033.1063232422}, },
    ["ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-311.54595947266,8.7501268386841,-1122.6448974609}, },
    ["ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-265.54711914063,8.7501268386841,-1250.3923339844}, },
    ["ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-717.70281982422,8.7501268386841,559.83355712891}, },
    ["ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-700.86419677734,8.7501268386841,703.29937744141}, },
    ["ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-823.72180175781,8.7501268386841,761.10437011719}, },
    ["ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-806.88293457031,8.7501268386841,904.57025146484},  },
    ["ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-788.7958984375,8.7501268386841,-381.5334777832}, },
    ["ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-846.60076904297,8.7501268386841,-504.39074707031}, },
    ["ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-990.06616210938,8.7501268386841,-487.55209350586}, },
    ["ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1047.8713378906,8.7501268386841,-610.40930175781}, },
    --retake the plat
    ["ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr"]={pos={995.28381347656,-3.498596906662,343.14279174805}, },
    ["ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1091.1303710938,-3.498596906662,345.89108276367}, },
    ["ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1160.8475341797,-3.498596906662,280.06066894531}, },
    ["ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1308.416015625,-3.498596906662,278.53768920898}, },
  },
  {--2
    --mother base
    ["ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={9.1155920028687,8.7501268386841,-42.430213928223}, },
    ["ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr"]={pos={-1.9415365457535,26.005094528198,17.777017593384}, },
    ["ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={159.4271697998,8.7501268386841,9.6170091629028}, },
    ["ly003_cl00_30050_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={248.96594238281,8.7501268386841,-103.73515319824}, },
    ["ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1048.2072753906,8.7501268386841,-631.77398681641}, },
    ["ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1031.3685302734,8.7501268386841,-775.23950195313}, },
    ["ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1154.2257080078,8.7501268386841,-833.04461669922}, },
    ["ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1281.9735107422,8.7501268386841,-787.04571533203}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1095.408203125,8.7501268386841,323.56674194336}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr"]={pos={1084.7421875,37.018760681152,250.79963684082}, },
    ["ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1238.8735351563,8.7501268386841,306.72796630859}, },
    ["ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1328.4119873047,8.7501268386841,193.37603759766}, },
    ["ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1456.1591796875,8.7501268386841,239.37481689453}, },
    ["ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={362.35015869141,8.7501268386841,905.54925537109}, },
    ["ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={475.70230102539,8.7501268386841,995.08782958984}, },
    ["ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={429.70343017578,8.7501268386841,1122.8355712891}, },
    ["ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={306.84616088867,8.7501268386841,1180.6407470703}, },
    ["ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-160.6671295166,8.7501268386841,-993.63580322266}, },
    ["ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-114.66819000244,8.7501268386841,-1121.3830566406}, },
    ["ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-228.02030944824,8.7501268386841,-1210.9216308594}, },
    ["ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-182.02145385742,8.7501268386841,-1338.6690673828}, },
    ["ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-717.70281982422,8.7501268386841,559.83355712891}, },
    ["ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-700.86419677734,8.7501268386841,703.29937744141}, },
    ["ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-823.72180175781,8.7501268386841,761.10437011719}, },
    ["ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-806.88293457031,8.7501268386841,904.57025146484}, },
    ["ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-788.7958984375,8.7501268386841,-381.5334777832}, },
    ["ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-846.60076904297,8.7501268386841,-504.39074707031}, },
    ["ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-990.06616210938,8.7501268386841,-487.55209350586}, },
    ["ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1047.8713378906,8.7501268386841,-610.40930175781}, },
    --retake the plat
    ["ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1095.57421875,-3.498596906662,256.29260253906}, },
    ["ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1191.4206542969,-3.498596906662,259.04086303711}, },
    ["ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1261.1378173828,-3.498596906662,193.21047973633}, },
    ["ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1408.7062988281,-3.498596906662,191.68753051758}, },

  },
  {--3
    --mother base
    ["ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={9.1155920028687,8.7501268386841,-42.430213928223}, },
    ["ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr"]={pos={-1.9415365457535,26.005094528198,17.777017593384}, },
    ["ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={159.4271697998,8.7501268386841,9.6170091629028}, },
    ["ly003_cl00_30050_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={248.96594238281,8.7501268386841,-103.73515319824}, },
    ["ly003_cl00_30050_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={376.71340942383,8.7501268386841,-57.736152648926}, },
    ["ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1168.978515625,8.7501268386841,-630.18487548828}, },
    ["ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1152.1398925781,8.7501268386841,-773.650390625}, },
    ["ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1274.9969482422,8.7501268386841,-831.45550537109}, },
    ["ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1402.7447509766,8.7501268386841,-785.45660400391}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1212.4044189453,8.7501268386841,343.06323242188}, },
    ["ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr"]={pos={1201.7384033203,37.018760681152,270.29614257813}, },
    ["ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1355.8697509766,8.7501268386841,326.22448730469}, },
    ["ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1445.408203125,8.7501268386841,212.87255859375}, },
    ["ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={1573.1553955078,8.7501268386841,258.87133789063}, },
    ["ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={362.35015869141,8.7501268386841,905.54925537109}, },
    ["ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={475.70230102539,8.7501268386841,995.08782958984}, },
    ["ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={429.70343017578,8.7501268386841,1122.8355712891}, },
    ["ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={306.84616088867,8.7501268386841,1180.6407470703}, },
    ["ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-160.6671295166,8.7501268386841,-993.63580322266}, },
    ["ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-114.66819000244,8.7501268386841,-1121.3830566406}, },
    ["ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-228.02030944824,8.7501268386841,-1210.9216308594}, },
    ["ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-182.02145385742,8.7501268386841,-1338.6690673828}, },
    ["ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-717.70281982422,8.7501268386841,559.83355712891}, },
    ["ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-700.86419677734,8.7501268386841,703.29937744141}, },
    ["ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-823.72180175781,8.7501268386841,761.10437011719}, },
    ["ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-806.88293457031,8.7501268386841,904.57025146484}, },
    ["ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-788.7958984375,8.7501268386841,-381.5334777832}, },
    ["ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-846.60076904297,8.7501268386841,-504.39074707031}, },
    ["ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-990.06616210938,8.7501268386841,-487.55209350586}, },
    ["ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr"]={pos={-1047.8713378906,8.7501268386841,-610.40930175781}, },
    --retake the plat
    ["ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1212.5700683594,-3.498596906662,275.78900146484}, },
    ["ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1308.4165039063,-3.498596906662,278.53726196289}, },
    ["ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1378.1336669922,-3.498596906662,212.70687866211}, },
    ["ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr"]={pos={1525.7021484375,-3.498596906662,211.18392944336}, },
  },
}

--TABLESETUP
this.str32LzToLz={}
this.groundStartPositions={}
for layoutIndex=1,#groundStartPositionsInitial do
  local layoutLzTableInitial=groundStartPositionsInitial[layoutIndex]

  local layoutLzTable={}
  for lzName,lzInfo in pairs(layoutLzTableInitial)do
    local strCodeLzName=StrCode32(lzName)
    layoutLzTable[strCodeLzName]=lzInfo
    this.str32LzToLz[strCodeLzName]=lzName
  end

  this.groundStartPositions[layoutIndex]=layoutLzTable
end

--tex clear initial table
groundStartPositionsInitial=nil

function this.GetGroundStartPosition(missionStartRoute,missionCode)
  local missionCode=missionCode or vars.missionCode
  local layout=0
  if missionCode==30050 or missionCode==10115 then
    layout=vars.mbLayoutCode
  end
  return this.groundStartPositions[layout+1][missionStartRoute]
end

function this.DisableLzsWithinDist(lzTable,position,distance,missionCode)
  if lzTable==nil then
    return
  end

  local TppHelicopter=TppHelicopter
  local InfLZ=InfLZ
  local TppMath=TppMath

  for dropLzName,aprLzName in pairs(lzTable)do
    --InfMenu.DebugPrint(dropLzName.." -- "..aprLzName)
    local lzCoords=InfLZ.GetGroundStartPosition(StrCode32(dropLzName),missionCode)
    if lzCoords==nil then
      --InfMenu.DebugPrint("lzPos==nil")--DEBUG
    else
      local distSqr=TppMath.FindDistance(position,lzCoords.pos)
--      InfMenu.DebugPrint(aprLzName.." dist:"..math.sqrt(distSqr))--DEBUG
      if distSqr<distance then
        if TppHelicopter.GetLandingZoneExists{landingZoneName=aprLzName}then
          TppHelicopter.SetDisableLandingZone{landingZoneName=aprLzName}
        end
      end
    end
  end
end

function this.DisableLzs(lzTable)
  if lzTable==nil then
    return
  end

  local TppHelicopter=TppHelicopter

  for dropLzName,aprLzName in pairs(lzTable)do
    if TppHelicopter.GetLandingZoneExists{landingZoneName=aprLzName}then
      TppHelicopter.SetDisableLandingZone{landingZoneName=aprLzName}
    end
  end
end

return this
