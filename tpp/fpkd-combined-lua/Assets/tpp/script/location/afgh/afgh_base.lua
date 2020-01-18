





local  afgh_base = {}

afgh_base.baseList = {
	
	"afgh_bridge",
	"afgh_citadel",
	"afgh_cliffTown",
	"afgh_commFacility",
	"afgh_enemyBase",
	"afgh_field",
	"afgh_fort",
	"afgh_powerPlant",
	"afgh_remnants",
	"afgh_ruins",
	"afgh_slopedTown",
	"afgh_sovietBase",
	"afgh_tent",
	"afgh_village",
	"afgh_waterway",
}





afgh_base.RAT_LIST = {
	"anml_rat_00",
	"anml_rat_01",
	"anml_rat_02",
	"anml_rat_03",
	"anml_rat_04",
}






afgh_base.RAT_ROUTE_LIST = {
	afgh_bridge = {
		{ name = "rt_anml_bridge_rat_00",		pos = {1960.935, 318.498, -488.383} },
		{ name = "rt_anml_bridge_rat_01",		pos = {1965.661, 342.076, -516.631} },
		{ name = "rt_anml_bridge_rat_02",		pos = {2053.618, 346.593, -485.443} },
		{ name = "rt_anml_bridge_rat_03",		pos = {1838.086, 368.633, -272.460} },
		{ name = "rt_anml_bridge_rat_04",		pos = {1877.703, 342.036, -406.845} },
	},
	afgh_citadel = {
		{ name = "rt_anml_citadel_rat_00",		pos = {-1299.455, 584.605, -2869.357} },
		{ name = "rt_anml_citadel_rat_01",		pos = {-1282.905, 599.821, -3124.549} },
		{ name = "rt_anml_citadel_rat_02",		pos = {-1308.289, 608.404, -2985.823} },
		{ name = "rt_anml_citadel_rat_03",		pos = {-1244.322, 599.245, -3141.795} },
		{ name = "rt_anml_citadel_rat_04",		pos = {-1350.114, 595.982, -2803.616} },

	},
	afgh_cliffTown = {
		{ name = "rt_anml_cliffTown_rat_00", pos = {788.383, 473.155, -922.115} },
		{ name = "rt_anml_cliffTown_rat_01", pos = {607.645, 431.660, -970.443} },
		{ name = "rt_anml_cliffTown_rat_02", pos = {789.663, 454.934, -1093.971} },
		{ name = "rt_anml_cliffTown_rat_03", pos = {805.411, 464.348, -1099.411} },
		{ name = "rt_anml_cliffTown_rat_04", pos = {718.617, 462.843, -888.450} },
	},
	afgh_commFacility = {
		{ name = "rt_anml_commFacility_rat_00", pos = {1483.538, 358.099+0.1, 483.473} },
		{ name = "rt_anml_commFacility_rat_01", pos = {1463.968, 357.854+0.1, 471.034} },
		{ name = "rt_anml_commFacility_rat_02", pos = {1506.778, 366.672+0.1, 490.439} },
		{ name = "rt_anml_commFacility_rat_03", pos = {1500.183, 356.615+0.1, 450.959} },
		{ name = "rt_anml_commFacility_rat_04", pos = {1510.874, 381.945+0.1, 543.124} },
	},
	afgh_enemyBase = {
		{ name = "rt_anml_enemyBase_rat_00",	pos = {-492.231, 304.954, 625.851} },
		{ name = "rt_anml_enemyBase_rat_01",	pos = {-508.233, 322.621, 488.518} },
		{ name = "rt_anml_enemyBase_rat_02",	pos = {-625.139, 342.823, 472.057} },
		{ name = "rt_anml_enemyBase_rat_03",	pos = {-567.245, 344.959, 410.789} },
		{ name = "rt_anml_enemyBase_rat_04",	pos = {-596.673, 346.086, 509.424} },
	},
	afgh_field = {
		{ name = "rt_anml_field_rat_00",		pos = {440.632, 269.528, 2204.044} },
		{ name = "rt_anml_field_rat_01",		pos = {500.594, 267.313, 2208.401} },
		{ name = "rt_anml_field_rat_02",		pos = {457.135, 267.841, 2151.960} },
		{ name = "rt_anml_field_rat_03",		pos = {437.102, 269.523, 2212.274} },
		{ name = "rt_anml_field_rat_04",		pos = {427.526, 269.762, 2220.970} },
	},
	afgh_fort = {
		{ name = "rt_anml_fort_rat_00",			pos = {2223.137, 487.063, -1602.293} },
		{ name = "rt_anml_fort_rat_01",			pos = {2184.353, 477.635, -1716.150} },
		{ name = "rt_anml_fort_rat_02",			pos = {2095.615, 483.917, -1804.768} },
		{ name = "rt_anml_fort_rat_03",			pos = {2066.022, 494.919, -1817.830} },
		{ name = "rt_anml_fort_rat_04",			pos = {2043.897, 477.152, -1924.412} },
	},
	afgh_powerPlant = {
		{ name = "rt_anml_powerPlant_rat_00",	pos = {-762.977, 530.937, -1441.290} },
		{ name = "rt_anml_powerPlant_rat_01",	pos = {-770.414, 533.351, -1468.899} },
		{ name = "rt_anml_powerPlant_rat_02",	pos = {-730.058, 534.501, -1579.959} },
		{ name = "rt_anml_powerPlant_rat_03",	pos = {-644.520, 533.503, -1478.073} },
		{ name = "rt_anml_powerPlant_rat_04",	pos = {-720.222, 533.305, -1558.978} },
	},
	afgh_remnants = {
		{ name = "rt_anml_remnants_rat_00",		pos = {-881.445, 288.703, 1952.509} },
		{ name = "rt_anml_remnants_rat_01",		pos = {-887.444, 288.703, 1942.534} },
		{ name = "rt_anml_remnants_rat_02",		pos = {-881.895, 297.103, 1941.428} },
		{ name = "rt_anml_remnants_rat_03",		pos = {-891.574, 292.927, 1942.867} },
		{ name = "rt_anml_remnants_rat_04",		pos = {-914.017, 289.806, 1901.584} },
	},
	afgh_ruins = {
		{ name = "rt_anml_ruins_rat_00",		pos = {1484.355, 336.564, 1466.907} },
		{ name = "rt_anml_ruins_rat_01",		pos = {1439.857, 327.182, 1533.250} },
		{ name = "rt_anml_ruins_rat_02",		pos = {1481.104, 325.326, 1601.650} },
		{ name = "rt_anml_ruins_rat_03",		pos = {1467.220, 335.910, 1495.733} },
		{ name = "rt_anml_ruins_rat_04",		pos = {1393.389, 324.337, 1516.086} },
	},
	afgh_slopedTown = {
		{ name = "rt_anml_slopedTown_rat_00",	pos = {530.431, 335.219, 27.309} },
		{ name = "rt_anml_slopedTown_rat_01",	pos = {546.500, 334.401, 19.824} },
		{ name = "rt_anml_slopedTown_rat_02",	pos = {548.254, 322.431, 84.600} },
		{ name = "rt_anml_slopedTown_rat_03",	pos = {462.568, 325.040, 67.682} },
		{ name = "rt_anml_slopedTown_rat_04",	pos = {617.679, 320.449, 19.682} },
	},
	afgh_sovietBase = {
		{ name = "rt_anml_sovietBase_rat_00",	pos = {-2172.193, 437.020, -1394.109} },
		{ name = "rt_anml_sovietBase_rat_01",	pos = {-2224.495, 443.264, -1472.717} },
		{ name = "rt_anml_sovietBase_rat_02",	pos = {-2311.129, 437.680, -1458.912} },
		{ name = "rt_anml_sovietBase_rat_03",	pos = {-2215.266, 443.385, -1655.317} },
		{ name = "rt_anml_sovietBase_rat_04",	pos = {-2354.145, 439.824, -1584.955} },
	},
	afgh_tent = {
		{ name = "rt_anml_tent_rat_00",			pos = {-1782.975, 310.309, 785.230} },
		{ name = "rt_anml_tent_rat_01",			pos = {-1765.327, 317.495, 838.294} },
		{ name = "rt_anml_tent_rat_02",			pos = {-1794.635, 312.495, 782.447} },
		{ name = "rt_anml_tent_rat_03",			pos = {-1762.392, 308.185, 850.397} },
		{ name = "rt_anml_tent_rat_04",			pos = {-1711.967, 308.009, 834.223} },
	},
	afgh_village = {
		{ name = "rt_anml_village_rat_00",		pos = {496.209, 319.623, 1218.193} },
		{ name = "rt_anml_village_rat_01",		pos = {512.617, 319.949, 1157.339} },
		{ name = "rt_anml_village_rat_02",		pos = {583.063, 320.236, 1186.606} },
		{ name = "rt_anml_village_rat_03",		pos = {568.163, 319.862, 1159.268} },
		{ name = "rt_anml_village_rat_04",		pos = {422.834, 320.116, 1192.676} },
	},
	afgh_waterway = {
		{ name = "rt_anml_waterway_rat_00",		pos = {-1760.134, 349.658, -335.160} },
		{ name = "rt_anml_waterway_rat_01",		pos = {-1659.059, 354.897, -286.186} },
		{ name = "rt_anml_waterway_rat_02",		pos = {-1852.681, 343.392, -298.377} },
		{ name = "rt_anml_waterway_rat_03",		pos = {-1854.812, 339.102, -261.484} },
		{ name = "rt_anml_waterway_rat_04",		pos = {-1847.429, 359.476, -334.796} },
	},
}





afgh_base.BIRD_LIST = {
	{ name = "anml_bird_00", birdType = "TppCritterBird" },
	{ name = "anml_bird_01", birdType = "TppCritterBird" },
	{ name = "anml_bird_02", birdType = "TppCritterBird" },
	{ name = "anml_bird_03", birdType = "TppCritterBird" },
	{ name = "anml_bird_04", birdType = "TppCritterBird" },
}






afgh_base.BIRD_FLY_ZONE_LIST = {
	afgh_bridge = {
		{ center = {2319,386,-474}, radius = 68.174995422363, height = 17.043748855591, perch = { {2326.8137207031,378.62899780273,-564.17999267578}, {2330.484375,357.78503417969,-370.58166503906}, }, },
		{ center = {2110.4416503906,367.01678466797,-454.91201782227}, radius = 34, height = 14.85000038147, perch = { {2046.5112304688,345.87878417969,-405.00415039063}, {2148.9326171875,350.35430908203,-490.60690307617}, }, },
		{ center = {1980,343,-508}, radius = 30, height = 10, perch = { {1978.8458251953,325.79312133789,-409.78387451172}, {1921.4311523438,336.43545532227,-537.47155761719}, }, },
		{ center = {1922,346.13452148438,-410}, radius = 62.141250610352, height = 13.495055198669, perch = { {1854.2200927734,333.04098510742,-435.80764770508}, {1918.4112548828,333.46109008789,-338.32360839844}, }, },
		{ center = {2156,414.14819335938,-101}, radius = 59.849998474121, height = 19.950000762939, perch = { {2187.7624511719,398.69604492188,-57.270763397217}, {2095.8413085938,393.70703125,-119.33564758301}, }, },
	},
	afgh_citadel = {
		{ center = {-1262.9318847656,618.60833740234,-3045.7487792969}, radius = 42.191955566406, height = 5.2286024093628, perch = { {-1294.2414550781,613.47528076172,-3001.4421386719}, {-1221.2316894531,608.95904541016,-3091.3586425781}, }, },
		{ center = {-1306.7852783203,619.61560058594,-2906.0954589844}, radius = 65.022720336914, height = 8.3840970993042, perch = { {-1333.7359619141,613.15838623047,-2957.6037597656}, {-1224.4553222656,608.63220214844,-2919.7036132813}, }, },
		{ center = {-1133.4554443359,632.36322021484,-3054.6401367188}, radius = 58.133918762207, height = 8.1798057556152, perch = { {-1064.7420654297,621.50891113281,-3060.8117675781}, {-1206.2188720703,629.09588623047,-2938.8950195313}, }, },
		{ center = {-1505.9210205078,565.67584228516,-2608.3325195313}, radius = 92.279228210449, height = 16.019798278809, perch = { {-1560.2144775391,550.7412109375,-2528.4353027344}, {-1486.9197998047,550.56024169922,-2516.33984375}, }, },
		{ center = {-1316.1086425781,664.3955078125,-3302.4038085938}, radius = 55.660495758057, height = 10.970411300659, perch = { {-1347.8023681641,649.64874267578,-3217.3425292969}, {-1180.7059326172,647.50610351563,-3307.9279785156}, }, },
	},
	afgh_cliffTown = {
		{ center = {755.65106201172,459.33755493164,-1121.4548339844}, radius = 28.25, height = 4.5245018005371, ground = { {777.90576171875,453.59603881836,-1101.7857666016}, {714.23266601563,447.18298339844,-1151.9897460938}, }, },
		{ center = {772.25250244141,473.4948425293,-1136.5045166016}, radius = 37.25, height = 6.2225661277771, perch = { {804.53796386719,463.31774902344,-1103.1140136719}, {809.89282226563,465.43786621094,-1145.4197998047}, }, },
		{ center = {712.57000732422,473.92437744141,-955.85400390625}, radius = 48.75, height = 10.269355773926, ground = { {750.19097900391,466.77899169922,-918.32232666016}, {646.96051025391,463.74548339844,-993.43530273438}, }, },
		{ center = {723.25512695313,495.95819091797,-1043.4305419922}, radius = 65, height = 10.614549636841, perch = { {806.76116943359,488.73098754883,-1007.80859375}, {641.27191162109,482.36712646484,-1088.1997070313}, }, },
		{ center = {486.26416015625,482.22805786133,-887.89074707031}, radius = 67.904769897461, height = 18.038118362427, perch = { {484.41555786133,467.99044799805,-942.3291015625}, {473.22277832031,467.7077331543,-942.37817382813}, }, },
	},
	afgh_commFacility = {
		{ center = {1474.3955078125,372.95370483398,442.51058959961}, radius = 36.283798217773, height = 8.3873834609985, perch = { {1509.1622314453,366.38522338867,476.21896362305}, {1431.060546875,368.73846435547,464.32070922852}, }, },
		{ center = {1503.1492919922,403.88424682617,444.03817749023}, radius = 52.598701477051, height = 18.66423034668, ground = { {1524.6547851563,393.41625976563,346.55090332031}, {1498.4593505859,377.94641113281,390.73971557617}, }, },
		{ center = {1663.7685546875,384.12191772461,543.64184570313}, radius = 69.884048461914, height = 16.825817108154, perch = { {1743.6345214844,372.7219543457,552.88775634766}, {1609.9342041016,374.57662963867,519.58062744141}, }, },
		{ center = {1090.5229492188,375.18292236328,520.96630859375}, radius = 73.302322387695, height = 15.802940368652, perch = { {1174.5942382813,374.18930053711,577.53955078125}, {1033.7438964844,373.58297729492,431.78012084961}, }, },
		{ center = {1344.3475341797,380.00643920898,389.24203491211}, radius = 57.599998474121, height = 8.9613637924194, perch = { {1388.3387451172,367.37866210938,349.26290893555}, {1323.2387695313,365.42236328125,346.89428710938}, }, },
	},
	afgh_enemyBase = {
		{ center = {-592.08038330078,378.84103393555,428.876953125}, radius = 45.85725402832, height = 5.7505960464478, perch = { {-551.80902099609,353.66284179688,416.22622680664}, {-559.15954589844,357.46987915039,435.55889892578}, }, },
		{ center = {-489.48208618164,349.37435913086,574.78814697266}, radius = 67.238670349121, height = 9.1443195343018, perch = { {-399.44036865234,346.17904663086,539.22076416016}, {-556.66143798828,337.16360473633,537.57543945313}, }, },
		{ center = {-458.95098876953,341.44680786133,469.81683349609}, radius = 46.816070556641, height = 9.7212772369385, perch = { {-405.56039428711,338.87283325195,423.61685180664}, {-476.53582763672,330.05291748047,458.84329223633}, }, },
		{ center = {-385.43869018555,358.62759399414,292.20291137695}, radius = 52.786975860596, height = 7.815043926239, perch = { {-368.49481201172,353.2060546875,261.75527954102}, {-344.86999511719,353.04724121094,267.48477172852}, }, },
		{ center = {-423.91061401367,347.89785766602,797.97326660156}, radius = 59.072162628174, height = 20.191610336304, perch = { {-468.61288452148,336.01541137695,867.03784179688}, {-315.14990234375,328.22805786133,837.33856201172}, }, },
	},
	afgh_field = {
		{ center = {458.30810546875,281.00003051758,2140.8913574219}, radius = 55.491649627686, height = 4.3206701278687, perch = { {401.31695556641,279.42379760742,2225.5300292969}, {491.68432617188,274.02645874023,2175.4357910156}, }, },
		{ center = {656.03759765625,306.29461669922,2072.0998535156}, radius = 42.572345733643, height = 5.2571129798889, perch = { {701.71203613281,302.4348449707,2039.2541503906}, {610.61340332031,301.21194458008,2026.4903564453}, }, },
		{ center = {407.87603759766,283.43588256836,2384.4685058594}, radius = 29.709999084473, height = 5.9258332252502, perch = { {454.07995605469,274.10220336914,2405.203125}, {454.0680847168,275.62963867188,2409.3393554688}, }, },
		{ center = {156.00579833984,288.63543701172,2111.203125}, radius = 60.365619659424, height = 5.9563608169556, perch = { {192.42216491699,287.01171875,2041.9096679688}, {124.7247467041,282.4990234375,2034.5247802734}, }, },
		{ center = {402.70581054688,304.63415527344,1993.3463134766}, radius = 43.75, height = 9.2400007247925, perch = { {352.92364501953,300.73587036133,1988.2232666016}, {444.96118164063,298.48828125,1990.9504394531}, }, },
	},
	afgh_fort = {
		{ center = {2116.3347167969,486.91223144531,-1461.8540039063}, radius = 34.004825592041, height = 6.5642042160034, perch = { {2107.4614257813,480.58251953125,-1490.6861572266}, {2095.2041015625,481.58853149414,-1489.0401611328}, }, },
		{ center = {2124.3837890625,484.15167236328,-1719.5417480469}, radius = 48.928798675537, height = 6.1160998344421, perch = { {2038.9736328125,469.50439453125,-1727.4483642578}, {2192.5307617188,473.13345336914,-1724.6910400391}, }, },
		{ center = {2153.5629882813,514.11993408203,-1732.1280517578}, radius = 85.262550354004, height = 10.65781879425, perch = { {2192.1865234375,502.57891845703,-1772.2305908203}, {2181.7143554688,497.68099975586,-1737.8734130859}, }, },
		{ center = {2086.8889160156,496.47360229492,-1922.4008789063}, radius = 18.661500930786, height = 6.2204999923706, perch = { {2105.4663085938,479.86795043945,-1904.1279296875}, {2089.3732910156,478.60168457031,-1911.8819580078}, }, },
		{ center = {1980.5789794922,509.18209838867,-1449.0280761719}, radius = 51.536548614502, height = 10.694741249084, perch = { {1960.2119140625,501.05551147461,-1501.7313232422}, {1996.5236816406,503.14129638672,-1410.8259277344}, }, },
	},
	afgh_powerPlant = {
		{ center = {-801.15417480469,545.56439208984,-1282.0947265625}, radius = 33.133869171143, height = 6.7294912338257, perch = { {-831.23944091797,540.44134521484,-1312.7877197266}, {-765.92425537109,544.11419677734,-1304.8782958984}, }, },
		{ center = {-737.03283691406,560.02105712891,-1490.9158935547}, radius = 37.60453414917, height = 7.5876407623291, perch = { {-755.59820556641,569.93890380859,-1596.4545898438}, {-809.49456787109,556.45001220703,-1464.8466796875}, }, },
		{ center = {-698.48736572266,572.91082763672,-1516.7612304688}, radius = 71.917495727539, height = 9.7448778152466, perch = { {-614.7060546875,563.81805419922,-1488.8280029297}, {-686.89910888672,564.16674804688,-1410.2224121094}, }, },
		{ center = {-897.78118896484,545.03033447266,-1249.6538085938}, radius = 62.21875, height = 9.360878944397, perch = { {-829.7255859375,538.99603271484,-1310.1459960938}, {-854.99200439453,538.42749023438,-1198.2833251953}, }, },
		{ center = {-647.44171142578,584.48571777344,-1685.1011962891}, radius = 28.491186141968, height = 11.396474838257, perch = { {-616.50091552734,580.74975585938,-1667.3939208984}, {-659.3388671875,573.00250244141,-1706.1540527344}, }, },
	},
	afgh_remnants = {
		{ center = {-836.82556152344,319.73150634766,1949.0311279297}, radius = 85.695663452148, height = 9.436806678772, perch = { {-883.50708007813,312.34518432617,1947.3826904297}, {-847.0478515625,311.63500976563,2058.0166015625}, }, },
		{ center = {-756.04357910156,293.40805053711,1880.5128173828}, radius = 50.823444366455, height = 8.9531574249268, perch = { {-787.52185058594,285.15148925781,1941.4396972656}, {-735.94592285156,283.15563964844,1890.0389404297}, }, },
		{ center = {-855.29895019531,314.5412902832,1745.0369873047}, radius = 50, height = 6.1831669807434, perch = { {-883.19842529297,299.29861450195,1696.9501953125}, {-861.43988037109,298.28723144531,1741.4866943359}, }, },
		{ center = {-665.32116699219,300.77133178711,1837.9787597656}, radius = 42.899143218994, height = 7.7442283630371, perch = { {-652.4853515625,297.54699707031,1953.9221191406}, {-642.71380615234,293.98593139648,1883.3474121094}, }, },
		{ center = {-885.07568359375,306.66903686523,1831.4519042969}, radius = 30, height = 10, perch = { {-922.3115234375,302.04946899414,1818.2165527344}, {-922.91662597656,298.52499389648,1844.9130859375}, }, },
	},
	afgh_ruins = {
		{ center = {1477.1325683594,360.14788818359,1488.8671875}, radius = 38.699996948242, height = 6.4499998092651, perch = { {1478.4110107422,352.42541503906,1465.0090332031}, {1462.6407470703,351.61480712891,1472.849609375}, }, },
		{ center = {1409.9671630859,361.1110534668,1486.3411865234}, radius = 35.709423065186, height = 9.7722177505493, perch = { {1459.9770507813,345.07955932617,1476.8193359375}, {1460.4766845703,342.22106933594,1489.2077636719}, }, },
		{ center = {1463.5860595703,381.49157714844,1504.0993652344}, radius = 91.057502746582, height = 15.176250457764, perch = { {1453.5921630859,363.01623535156,1428.4519042969}, {1464.1566162109,363.31204223633,1422.3822021484}, }, },
		{ center = {1562.2170410156,361.83938598633,1678.8359375}, radius = 60, height = 12.095999717712, perch = { {1490.8736572266,356.416015625,1711.7388916016}, {1588.5642089844,352.34204101563,1607.7387695313}, }, },
		{ center = {1298.9833984375,349.70663452148,1463.3426513672}, radius = 49, height = 9.5500001907349, perch = { {1342.8293457031,342.47213745117,1408.9110107422}, {1279.8895263672,339.26132202148,1506.0959472656}, }, },
	},
	afgh_slopedTown = {
		{ center = {427.77362060547,336.40142822266,129.5843963623}, radius = 53.194244384766, height = 10.877429008484, perch = { {481.38873291016,322.57861328125,98.61011505127}, {470.73187255859,330.23593139648,67.340682983398}, }, },
		{ center = {513.11975097656,345.36456298828,101.42353057861}, radius = 72.322242736816, height = 7.0144481658936, perch = { {580.21032714844,335.72253417969,184.99719238281}, {516.2109375,353.49163818359,25.748062133789}, }, },
		{ center = {683.32183837891,343.1594543457,69.545829772949}, radius = 58.235626220703, height = 12.09845161438, perch = { {631.35345458984,323.29797363281,16.181667327881}, {763.89276123047,335.6217956543,70.201721191406}, }, },
		{ center = {286.15887451172,372.94711303711,141.22933959961}, radius = 49.432498931885, height = 19.773000717163, perch = { {304.28350830078,363.42501831055,34.892776489258}, {288.84896850586,355.05401611328,174.16622924805}, }, },
		{ center = {220.28276062012,343.26773071289,80.606986999512}, radius = 45.048240661621, height = 7.7130136489868, perch = { {269.40063476563,329.46148681641,125.3717956543}, {189.34811401367,332.96270751953,29.16930770874}, }, },
	},
	afgh_sovietBase = {
		{ center = {-2168.7902832031,468.54174804688,-1226.9620361328}, radius = 43.106922149658, height = 7.6602864265442, perch = { {-2210.4572753906,459.43490600586,-1202.5554199219}, {-2127.6198730469,463.59429931641,-1255.1589355469}, }, },
		{ center = {-2167.6862792969,466.13192749023,-1397.0811767578}, radius = 52.108436584473, height = 7.4557237625122, perch = { {-2139.3464355469,461.66479492188,-1295.1966552734}, {-2138.6706542969,461.51614379883,-1295.5947265625}, }, },
		{ center = {-2115.1076660156,460.1169128418,-1561.5850830078}, radius = 59.343746185303, height = 7.9365038871765, perch = { {-2166.4904785156,455.46710205078,-1547.5963134766}, {-2192.2094726563,457.35220336914,-1608.1107177734}, }, },
		{ center = {-2226.7897949219,463.59036254883,-1665.5836181641}, radius = 54.599998474121, height = 7.507345199585, perch = { {-2214.3193359375,456.98883056641,-1656.3607177734}, {-2280.5388183594,459.43737792969,-1644.2465820313}, }, },
		{ center = {-2397.3452148438,457.16348266602,-1529.2264404297}, radius = 56.384998321533, height = 8.1465339660645, perch = { {-2381.6440429688,450.75637817383,-1537.3165283203}, {-2448.3505859375,452.42367553711,-1567.6647949219}, }, },
	},
	afgh_tent = {
		{ center = {-1732.5836181641,330.99545288086,831.439453125}, radius = 50.146923065186, height = 9.9034700393677, perch = { {-1731.9819335938,321.57196044922,832.98327636719}, {-1790.5709228516,325.72793579102,777.24743652344}, }, },
		{ center = {-1664.7415771484,321.46151733398,904.66003417969}, radius = 57.837409973145, height = 8.7636575698853, perch = { {-1645.7667236328,309.71810913086,886.26123046875}, {-1730.7637939453,316.76565551758,966.8447265625}, }, },
		{ center = {-1894.9781494141,354.22793579102,898.56085205078}, radius = 62.262813568115, height = 8.2969226837158, perch = { {-1870.4260253906,345.3293762207,838.56781005859}, {-1879.2993164063,348.60232543945,969.22473144531}, }, },
		{ center = {-1860.5639648438,343.80502319336,603.80151367188}, radius = 44.100002288818, height = 9.393406867981, perch = { {-1860.5335693359,331.63775634766,549.36029052734}, {-1824.9879150391,327.87872314453,651.92346191406}, }, },
		{ center = {-1418.5655517578,331.43856811523,972.10089111328}, radius = 63.812992095947, height = 12.595925331116, perch = { {-1442.7708740234,319.02450561523,1043.8843994141}, {-1543.4447021484,317.76712036133,899.23999023438}, }, },
	},
	afgh_village = {
		{ center = {612.43200683594,347.32543945313,1245.8800048828}, radius = 40.5, height = 13.54630279541, perch = { {633.95361328125,332.36059570313,1268.6572265625}, {623.44580078125,338.63244628906,1316.6647949219}, }, },
		{ center = {619.34143066406,345.9674987793,1183.7248535156}, radius = 74.210311889648, height = 9.940299987793, perch = { {708.68072509766,330.68612670898,1133.6853027344}, {711.5283203125,335.74127197266,1105.0096435547}, }, },
		{ center = {512.26086425781,345.28384399414,1141.1446533203}, radius = 70.443748474121, height = 20.843904495239, perch = { {479.9680480957,326.67321777344,1034.3308105469}, {507.70977783203,331.72601318359,1187.4207763672}, }, },
		{ center = {433.25500488281,338.82229614258,1045.3620605469}, radius = 71.449501037598, height = 14.12403678894, perch = { {414.58581542969,324.74139404297,1067.8947753906}, {579.46337890625,347.07757568359,931.44104003906}, }, },
		{ center = {402.71057128906,348.51135253906,1147.6396484375}, radius = 58.308002471924, height = 10.171430587769, perch = { {486.16616821289,329.68649291992,1179.9487304688}, {465.93478393555,326.97644042969,1090.2448730469}, }, },
	},
	afgh_waterway = {
		{ center = {-1814.3843994141,357.44024658203,-246.18740844727}, radius = 39.135593414307, height = 11.882709503174, perch = { {-1783.3695068359,344.05587768555,-203.31350708008}, {-1767.1904296875,351.21649169922,-175.00863647461}, }, },
		{ center = {-1719.427734375,371.0703125,-249.90740966797}, radius = 72.61799621582, height = 13.625172615051, perch = { {-1664.4493408203,367.3362121582,-172.73611450195}, {-1676.6535644531,363.3415222168,-287.18542480469}, }, },
		{ center = {-1756.1927490234,372.85824584961,-348.48043823242}, radius = 65.790390014648, height = 7.7397317886353, perch = { {-1704.6749267578,366.24896240234,-361.3649597168}, {-1765.5721435547,370.51580810547,-425.25415039063}, }, },
		{ center = {-1670.4504394531,382.83016967773,-393.68200683594}, radius = 58.107135772705, height = 8.426570892334, perch = { {-1622.9285888672,373.82861328125,-412.15222167969}, {-1666.4287109375,373.14202880859,-351.99670410156}, }, },
		{ center = {-1622.1611328125,370.62222290039,-259.54611206055}, radius = 47.528797149658, height = 8.2480449676514, perch = { {-1601.345703125,362.48510742188,-249.01173400879}, {-1576.5208740234,369.83602905273,-319.45901489258}, }, },
	},
}




afgh_base.REVENGE_MINE_LIST = {
	afgh_bridge = {
		decoyLocatorList = {
			"itm_revDecoy_bridge_a_0000",
			"itm_revDecoy_bridge_a_0001",
			"itm_revDecoy_bridge_a_0002",
			"itm_revDecoy_bridge_a_0003",
			"itm_revDecoy_bridge_a_0004",
		},
		{
			trapName = "trap_afgh_bridge_mine_west",
				mineLocatorList = {
					"itm_revMine_bridge_a_0000",
					"itm_revMine_bridge_a_0001",
					"itm_revMine_bridge_a_0002",
				},

		},
		{
			trapName = "trap_afgh_bridge_mine_east",
				mineLocatorList = {
					"itm_revMine_bridge_a_0003",
					"itm_revMine_bridge_a_0004",
				},
		},
	},
	afgh_citadel = {
		{
			trapName = "trap_afgh_citadel_mine_west",
				mineLocatorList = {
					"itm_revMine_citadel_a_0000",
					"itm_revMine_citadel_a_0001",
					"itm_revMine_citadel_a_0002",
					"itm_revMine_citadel_a_0003",
					"itm_revMine_citadel_a_0004",
				},
		},
		{
			trapName = "trap_afgh_citadel_mine_south",
				mineLocatorList = {
					"itm_revMine_citadel_a_0005",
					"itm_revMine_citadel_a_0006",
					"itm_revMine_citadel_a_0007",
					"itm_revMine_citadel_a_0008",
					"itm_revMine_citadel_a_0009",
				},
		},
	},
	afgh_cliffTown = {
	{
			trapName = "trap_revMine_cliffTown_east",
				mineLocatorList = {
					"itm_revMine_cliffTown_b_0000",
					"itm_revMine_cliffTown_b_0001",
					"itm_revMine_cliffTown_b_0002",
					"itm_revMine_cliffTown_b_0003",
				},
				decoyLocatorList = {
					"itm_revDecoy_cliffTown_b_0000",
					"itm_revDecoy_cliffTown_b_0001",
				},
		},
		{
			trapName = "trap_revMine_cliffTown_west",
				mineLocatorList = {
					"itm_revMine_cliffTown_a_0000",
					"itm_revMine_cliffTown_a_0001",
					"itm_revMine_cliffTown_a_0002",
				},
				decoyLocatorList = {
					"itm_revDecoy_cliffTown_a_0000",
					"itm_revDecoy_cliffTown_a_0001",
					"itm_revDecoy_cliffTown_a_0002",
				},
		},
	},
	afgh_commFacility = {
		{
			trapName = "trap_revMine_commFacility_east",
				mineLocatorList = {
					"itm_revMine_commFacility_a_0000",
					"itm_revMine_commFacility_a_0001",
					"itm_revMine_commFacility_a_0002",
					"itm_revMine_commFacility_a_0003",
					"itm_revMine_commFacility_a_0004",
				},
				decoyLocatorList = {
					"itm_revDecoy_commFacility_a_0000",
				},
		},
		{
			trapName = "trap_revMine_commFacility_west",
				mineLocatorList = {
					"itm_revMine_commFacility_b_0000",
					"itm_revMine_commFacility_b_0001",
					"itm_revMine_commFacility_b_0002",
					"itm_revMine_commFacility_b_0003",
					"itm_revMine_commFacility_b_0004",
				},
				decoyLocatorList = {
					"itm_revDecoy_commFacility_b_0000",
				},
		},
	},
	afgh_enemyBase = {
		decoyLocatorList = {
			"itm_revDecoy_enemyBase_a_0000",
			"itm_revDecoy_enemyBase_a_0001",
			"itm_revDecoy_enemyBase_a_0002",
			"itm_revDecoy_enemyBase_a_0003",
			"itm_revDecoy_enemyBase_a_0004",
		},
		{
			trapName = "trap_afgh_enemyBase_mine_south",
				mineLocatorList = {
					"itm_revMine_enemyBase_a_0000",
					"itm_revMine_enemyBase_a_0001",
					"itm_revMine_enemyBase_a_0002",
				},
		},
		{
			trapName = "trap_afgh_enemyBase_mine_west",
				mineLocatorList = {
					"itm_revMine_enemyBase_a_0003",
					"itm_revMine_enemyBase_a_0004",
				},
		},
		{
			trapName = "trap_afgh_enemyBase_mine_east",
				mineLocatorList = {
					"itm_revMine_enemyBase_a_0005",
					"itm_revMine_enemyBase_a_0006",
					"itm_revMine_enemyBase_a_0007",
					"itm_revMine_enemyBase_a_0008",
					"itm_revMine_enemyBase_a_0009",
				},
		},
	},
	afgh_field = {
		decoyLocatorList = {
			"itm_revDecoy_field_a_0000",
			"itm_revDecoy_field_a_0001",
			"itm_revDecoy_field_a_0002",
			"itm_revDecoy_field_a_0003",
			"itm_revDecoy_field_a_0004",
		},
		{
			trapName = "trap_afgh_field_mine_west",
			mineLocatorList = {
				"itm_revMine_field_a_0000",
				"itm_revMine_field_a_0001",
				"itm_revMine_field_a_0002",
			},
		},
		{
			trapName = "trap_afgh_field_mine_north",
			mineLocatorList = {
				"itm_revMine_field_a_0003",
				"itm_revMine_field_a_0004",
			},
		},
	},
	afgh_fort = {
		decoyLocatorList = {
			"itm_revDecoy_fort_a_0000",
			"itm_revDecoy_fort_a_0001",
			"itm_revDecoy_fort_a_0002",
			"itm_revDecoy_fort_a_0003",
			"itm_revDecoy_fort_a_0004",
		},
		{
			trapName = "trap_afgh_fort_mine_west",
				mineLocatorList = {
					"itm_revMine_fort_a_0000",
					"itm_revMine_fort_a_0001",
					"itm_revMine_fort_a_0002",
				},
		},
		{
			trapName = "trap_afgh_fort_mine_south",
				mineLocatorList = {
					"itm_revMine_fort_a_0003",
					"itm_revMine_fort_a_0004",
				},
		},

	},
	afgh_powerPlant = {
		{
			trapName = "trap_revMine_powerPlant_West",
			mineLocatorList = {
				"itm_revMine_powerPlant_a_0000",
				"itm_revMine_powerPlant_a_0001",
				"itm_revMine_powerPlant_a_0002",
				"itm_revMine_powerPlant_a_0003",
				"itm_revMine_powerPlant_a_0004",
				"itm_revMine_powerPlant_a_0005",

			},
			decoyLocatorList = {
				"itm_revDecoy_powerPlant_a_0000",
				"itm_revDecoy_powerPlant_a_0001",
				"itm_revDecoy_powerPlant_a_0002",
				nil,
			},
		},
		{
			trapName = "trap_revMine_powerPlant_East",
			mineLocatorList = {
				"itm_revMine_powerPlant_b_0000",
				"itm_revMine_powerPlant_b_0001",
				"itm_revMine_powerPlant_b_0002",
				"itm_revMine_powerPlant_b_0003",

			},
			decoyLocatorList = {
				"itm_revDecoy_powerPlant_b_0000",
				"itm_revDecoy_powerPlant_b_0001",
				nil,
			},
		},
	},
	afgh_remnants = {
		decoyLocatorList = {
			"itm_revDecoy_remnants_a_0000",
			"itm_revDecoy_remnants_a_0001",
			"itm_revDecoy_remnants_b_0000",
			"itm_revDecoy_remnants_b_0001",
			"itm_revDecoy_remnants_b_0002",
		},
		{
			trapName = "trap_revMine_remnants_East",
			mineLocatorList = {
				"itm_revMine_remnants_a_0000",
				"itm_revMine_remnants_a_0001",
				"itm_revMine_remnants_a_0002",
				"itm_revMine_remnants_a_0003",
				"itm_revMine_remnants_a_0004",
			},
		},
		{
			trapName = "trap_revMine_remnants_North",
			mineLocatorList = {
				"itm_revMine_remnants_b_0000",
				"itm_revMine_remnants_b_0001",
				"itm_revMine_remnants_b_0002",
				"itm_revMine_remnants_b_0003",
				"itm_revMine_remnants_b_0004",
			},
		},
	},
	afgh_ruins = {},
	afgh_slopedTown = {
		{
			trapName = "trap_revMine_slopedTown_West",
			mineLocatorList = {
				"itm_revMine_slopedTown_a_0000",
				"itm_revMine_slopedTown_a_0001",
				"itm_revMine_slopedTown_a_0002",
				"itm_revMine_slopedTown_a_0003",
				"itm_revMine_slopedTown_a_0004",
			},
			decoyLocatorList = {
				"itm_revDecoy_slopedTown_a_0000",
				"itm_revDecoy_slopedTown_a_0001",
			},
		},
		{
			trapName = "trap_revMine_slopedTown_East",
			mineLocatorList = {
				"itm_revMine_slopedTown_b_0000",
				"itm_revMine_slopedTown_b_0001",
				"itm_revMine_slopedTown_b_0002",
				"itm_revMine_slopedTown_b_0003",
				"itm_revMine_slopedTown_b_0004",
			},
			decoyLocatorList = {
				"itm_revDecoy_slopedTown_b_0000",
				"itm_revDecoy_slopedTown_b_0001",
				"itm_revDecoy_slopedTown_b_0002",
			},
		},
		{
			trapName = "trap_revMine_slopedTown_South",
			mineLocatorList = {
				nil,
			},
			decoyLocatorList = {
				nil,
			},
		},
	},
	afgh_sovietBase = {
		decoyLocatorList = {
			"itm_revDecoy_sovietBase_a_0000",
			"itm_revDecoy_sovietBase_a_0001",
			"itm_revDecoy_sovietBase_a_0002",
			"itm_revDecoy_sovietBase_b_0000",
			"itm_revDecoy_sovietBase_b_0001",
		},
		{
			trapName = "trap_revMine_sovietBase_North",
			mineLocatorList = {
				"itm_revMine_sovietBase_a_0000",
				"itm_revMine_sovietBase_a_0001",
				"itm_revMine_sovietBase_a_0002",
				"itm_revMine_sovietBase_a_0003",
				"itm_revMine_sovietBase_a_0004",

			},
		},
		{
			trapName = "trap_revMine_sovietBase_South",
			mineLocatorList = {
				"itm_revMine_sovietBase_b_0000",
				"itm_revMine_sovietBase_b_0001",
				"itm_revMine_sovietBase_b_0002",
				"itm_revMine_sovietBase_b_0003",
				"itm_revMine_sovietBase_b_0004",

			},
		},
	},
	afgh_tent = {
		decoyLocatorList = {
			"itm_revDecoy_tent_a_0000",
			"itm_revDecoy_tent_a_0001",
			"itm_revDecoy_tent_b_0000",
			"itm_revDecoy_tent_c_0000",
			"itm_revDecoy_tent_c_0001",
		},
		{
			trapName = "trap_revMine_tent_East",
			mineLocatorList = {
				"itm_revMine_tent_a_0000",
				"itm_revMine_tent_a_0001",
				"itm_revMine_tent_a_0002",
			},
		},
		{
			trapName = "trap_revMine_tent_South",
			mineLocatorList = {
				"itm_revMine_tent_b_0000",
				"itm_revMine_tent_b_0001",
				"itm_revMine_tent_b_0002",
				"itm_revMine_tent_b_0003",
			},
		},
		{
			trapName = "trap_revMine_tent_Underpass",	
			mineLocatorList = {
				"itm_revMine_tent_c_0000",
				"itm_revMine_tent_c_0001",
				"itm_revMine_tent_c_0002",
			},
		},
	},
	afgh_village = {
		{
			trapName = "trap_revMine_village_East",
			mineLocatorList = {
				"itm_revMine_village_a_0000",
				"itm_revMine_village_a_0001",
				"itm_revMine_village_a_0002",
				"itm_revMine_village_a_0003",
				"itm_revMine_village_a_0004",
			},
			decoyLocatorList = {
				"itm_revDecoy_village_a_0000",
				"itm_revDecoy_village_a_0001",
				"itm_revDecoy_village_a_0002",
			},
		},
		{
			trapName = "trap_revMine_village_North",
			mineLocatorList = {
				"itm_revMine_village_b_0000",
				"itm_revMine_village_b_0001",
				"itm_revMine_village_b_0002",
				"itm_revMine_village_b_0003",
				"itm_revMine_village_b_0004",
			},
			decoyLocatorList = {
				"itm_revDecoy_village_b_0000",
				"itm_revDecoy_village_b_0001",
			},
		},
		{
			trapName = "trap_revMine_village_West",
			mineLocatorList = {
				nil,
			},
			decoyLocatorList = {
				nil,
			},
		},
	},
	afgh_waterway = {},
}






afgh_base.QUIET_SUPPLY_POS_LIST = {
	afgh_bridge_cp = {
		{ 1794.310, 352.924, -310.236 },
		{ 2022.439, 346.162, -320.918 },
		{ 2037.171, 339.351, -549.022 },
	},
	afgh_citadel_cp = {
		{ -1336.767, 600.881, -2767.545 },
		{ -1261.442, 604.004, -3004.219 },
		{ -1204.805, 612.449, -3177.491 },
	},
	afgh_cliffTown_cp = {
		{ 590.292, 447.807, -981.343 },
		{ 761.597, 471.248, -891.119 },
		{ 812.261, 464.945, -1147.669 },
	},
	afgh_commFacility_cp = {
		{ 1496.922, 380.136, 520.904 },
		{ 1434.778, 368.888, 487.050 },
	},
	afgh_enemyBase_cp = {
		{ -618.316, 342.089, 564.302 },
		{ -553.415, 352.444, 431.015 },
		{ -637.286, 353.123, 457.758 },
	},
	afgh_field_cp = {
		{ 540.771, 286.877, 2031.634 },
		{ 489.028, 285.295, 2324.810 },
		{ 354.157, 285.312, 2298.377 },
	},
	afgh_fort_cp = {
		{ 2218.386, 471.777, -1649.649 },
		{ 2070.051, 482.360, -1638.693 },
	},
	afgh_powerPlant_cp = {
		{ -729.935, 543.348, -1357.400 },
		{ -640.076, 544.681, -1464.046 },
		{ -775.831, 538.520, -1546.310 },
	},
	afgh_remnants_cp = {
		{ -957.243, 303.165, 1915.690 },
		{ -731.744, 290.428, 1998.584 },
		{ -669.367, 289.030, 1888.180 },
	},
	afgh_slopedTown_cp = {
		{ 546.981, 347.283, 230.397 },
		{ 376.4611,331.0777,211.4483 },
		{ 579.374, 332.724, -0.204 },
	},
	afgh_sovietBase_cp = {
		{ -2166.310, 451.308, -1251.776 },
		{ -2203.199, 456.352, -1600.273 },
		{ -2076.699, 449.923, -1670.044 },
		{ -2452.255, 442.538, -1478.409 },
	},
	afgh_tent_cp = {
		{ -1737.933, 318.654, 750.888 },
		{ -1799.683, 328.872, 770.346 },
		{ -1755.011, 310.906, 882.568 },
	},
	afgh_village_cp = {
		{ 642.347, 331.272, 1275.001 },
		{ 647.142, 346.145, 972.440 },
	},
	afgh_waterway_cp = {
		{ -1825.963, 335.985, -209.075 },
		{ -1769.528, 355.545, -405.740 },
	},
}



afgh_base.OnActiveSmallBlockTable = {
	citadelSouth = {
		activeArea = { 120, 113, 120, 113 },	
		OnActive = function()
			Fox.Log("afgh_base.OnActiveSmallBlockTable : citadelSouth")
			if TppStory.IsMissionCleard( 10151 ) then
				
				TppDataUtility.SetVisibleDataFromIdentifier( "afgh_120_113_asset_DataIdentifier", "gate_close", false, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "afgh_120_113_asset_DataIdentifier", "gate_open", true, true)

				Nav.SetEnabledTacticalActionInRange("", Vector3(-1636.367,532.4562,-2465.553), 3.0, true)
			else
				
				TppDataUtility.SetVisibleDataFromIdentifier( "afgh_120_113_asset_DataIdentifier", "gate_close", true, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "afgh_120_113_asset_DataIdentifier", "gate_open", false, true)

				Nav.SetEnabledTacticalActionInRange("", Vector3(-1636.367,532.4562,-2465.553), 3.0, false)
			end
		end,
	},
	enemyNorth = {
		activeArea = { 130, 128, 130, 128 },	
		OnActive = function()
			Fox.Log("afgh_base.OnActiveSmallBlockTable : enemyNorth")
			
			if TppStory.IsMissionOpen( 10050 ) then
				
				TppDataUtility.SetVisibleDataFromIdentifier( "afgh_130_129_asset_DataIdentifier", "sbh0_main1_bre_0000", false, true)
				TppDataUtility.SetEnableDataFromIdentifier( "afgh_130_129_asset_DataIdentifier", "pathWall_0001", false)
				TppDataUtility.SetEnableDataFromIdentifier( "afgh_130_129_asset_DataIdentifier", "GeoxPath20000", true)
			else
				
				TppDataUtility.SetVisibleDataFromIdentifier( "afgh_130_129_asset_DataIdentifier", "sbh0_main1_bre_0000", true, true)
				TppDataUtility.SetEnableDataFromIdentifier( "afgh_130_129_asset_DataIdentifier", "pathWall_0001", true)
				TppDataUtility.SetEnableDataFromIdentifier( "afgh_130_129_asset_DataIdentifier", "GeoxPath20000", false)
			end
		end,
	}

}



afgh_base.OnActiveTable = {
	afgh_bridge = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_bridge")
		
		afgh_base.QuietSupplyCheck("afgh_bridge_cp")
	end,

	afgh_citadel = function()
		if TppMission.GetMissionID() ~= 10150 then
			Fox.Log("afgh_base.OnActiveTable : afgh_citadel")
			TppDataUtility.SetVisibleDataFromIdentifier( "citadel_asset_DataIdentifier", "heliport_door", true, true)
		end
		
		afgh_base.QuietSupplyCheck("afgh_citadel_cp")
	end,

	afgh_cliffTown = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_cliffTown")
		
		afgh_base.QuietSupplyCheck("afgh_cliffTown_cp")
	end,

	afgh_commFacility = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_commFacility")
		
		
		
		local currentMissionId = TppMission.GetMissionID()
		if ( currentMissionId == 10043 ) or ( currentMissionId == 11043 ) then
			local resetGimmickIdTable = {
				"commFacility_antn001",
				"commFacility_antn002",
				"commFacility_antn003",
				"commFacility_mchn001",
				"commFacility_mchn002",
				"commFacility_mchn003",
				"commFacility_cmmn001",
				"commFacility_cmmn002",
			}
			for i, gimmickId in pairs( resetGimmickIdTable ) do
				TppGimmick.ResetGimmick{ gimmickId = gimmickId, searchFromSaveData = false }
			end
		end
		
		afgh_base.QuietSupplyCheck("afgh_commFacility_cp")
	end,

	afgh_enemyBase = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_enemyBase")
		
		afgh_base.QuietSupplyCheck("afgh_enemyBase_cp")
	end,

	afgh_field = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_field")
		
		afgh_base.QuietSupplyCheck("afgh_field_cp")
	end,

	afgh_fort = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_fort")
		
		afgh_base.QuietSupplyCheck("afgh_fort_cp")
	end,

	afgh_powerPlant = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_powerPlant")
		
		local currentStorySequence = TppStory.GetCurrentStorySequence()
		local isHueyQuestCleard = TppQuest.IsCleard("sovietBase_q99020")
		local currentMissionId = TppMission.GetMissionID()
		
		if (currentStorySequence == TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_AFTER_FIND_THE_SECRET_WEAPON and not isHueyQuestCleard ) or
		   currentMissionId == 10070 or currentMissionId == 10150 or currentMissionId == 10151 or currentMissionId == 11151 then
			Fox.Log("afgh_powerPlant : free_mission_asset::Disable")
			TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_asset_DataIdentifier", "free_misson_asset", false, true)
			TppDataUtility.SetEnableDataFromIdentifier( "powerPlant_asset_DataIdentifier", "free_misson_asset_bounder", false, true)
		else
			Fox.Log("afgh_powerPlant : free_mission_asset::Enable")
			TppDataUtility.SetVisibleDataFromIdentifier( "powerPlant_asset_DataIdentifier", "free_misson_asset", true, true)
			TppDataUtility.SetEnableDataFromIdentifier( "powerPlant_asset_DataIdentifier", "free_misson_asset_bounder", true, true)
		end

		
		Gimmick.ResetGimmickData ( "cypr_cabl002_vrtn005_gim_i0000|TppSharedGimmick_cypr_cabl002_vrtn005", "/Assets/tpp/level/location/afgh/block_large/powerPlant/afgh_powerPlant_asset.fox2" )

		
		afgh_base.QuietSupplyCheck("afgh_powerPlant_cp")
	end,

	afgh_remnants = function()
		local missionId = 10260
		if TppMission.GetMissionID() ~= missionId then
				TppDataUtility.SetVisibleDataFromIdentifier( "id_for10260", "tent01", true )	
				TppDataUtility.SetVisibleDataFromIdentifier( "id_for10260", "tent02", true )	
				TppDataUtility.SetVisibleDataFromIdentifier( "id_for10260", "tent_collition", true )	

			if TppStory.IsMissionCleard( missionId ) then
				
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_0000", false ) 
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_vrtn004_0001", false )	
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_wndw003_wdfm003_0000", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_wndw003_wdfm003_00001", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_wndw003_wdfm003_00002", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_wndw001_0000", false )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas001", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas002", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas003_0000", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas003_0001", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas004", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas005_0000", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas005_0001", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas005_0002", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas005_0000", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_wndw003_wdfm003_gim_n0001|srt_afgh_wndw003_glas003_0000", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_wndw003_wdfm003_gim_n0001|srt_afgh_wndw003_glas003_0001", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas003_0002", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas003_0003", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas003_0004", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_buld005_wndw001_gim_n0001|srt_afgh_buld005_glas003_0005", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_wndw003_wdfm003_gim_n0003|srt_afgh_wndw003_glas003_0000", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_wndw003_wdfm003_gim_n0003|srt_afgh_wndw003_glas003_0001", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_wndw003_wdfm003_gim_n0002|srt_afgh_wndw003_glas003_0000", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
				Gimmick.InvisibleGimmick ( -1, "afgh_wndw003_wdfm003_gim_n0002|srt_afgh_wndw003_glas003_0001", "/Assets/tpp/level/location/afgh/block_large/remnants/afgh_remnants_asset.fox2", true )
			else
				
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_vrtn004_0001", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_vrtn001_0000", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_buld005_burn001_0000", false )



				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "afgh_tank003_vrtn002_0000", false )
				
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "mafr_grbg004_vrtn002_0000", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "mafr_grbg004_vrtn002_0001", false )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_forDemo", "mafr_grbg004_vrtn002_0002", false )
			end
		end
		
		afgh_base.QuietSupplyCheck("afgh_remnants_cp")
	end,

	afgh_slopedTown = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_slopedTown")
		
		afgh_base.QuietSupplyCheck("afgh_slopedTown_cp")
	end,

	afgh_sovietBase = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_sovietBase")
		
		afgh_base.QuietSupplyCheck("afgh_sovietBase_cp")
		
		local currentMissionId = TppMission.GetMissionID()
		local isQuestActive = TppQuest.IsActive( "sovietBase_q99030" )	
		local DATASET_PATH = "/Assets/tpp/level/location/afgh/block_large/sovietBase/afgh_sovietBase_asset.fox2"


		if currentMissionId == 10070 then
			
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0005|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0002|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0006|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0003|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0007|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0004|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
		elseif isQuestActive then
			
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0005|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0002|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0006|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0003|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0007|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0004|srt_mtbs_door006_door005" , DATASET_PATH, false , 0 )
		else
			
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0005|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0002|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0006|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0003|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0007|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )
			
			Gimmick.SetEventDoorLock( "mtbs_door006_door005_gim_n0004|srt_mtbs_door006_door005" , DATASET_PATH, true , 0 )

		end

	end,

	afgh_tent = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_tent")
		
		afgh_base.QuietSupplyCheck("afgh_tent_cp")
	end,

	afgh_village = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_village")
		
		afgh_base.QuietSupplyCheck("afgh_village_cp")
	end,

	afgh_waterway = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_waterway")
		
		afgh_base.QuietSupplyCheck("afgh_waterway_cp")
	end,

	afgh_ruins = function()
		Fox.Log("afgh_base.OnActiveTable : afgh_ruins")
		
		TppDataUtility.SetVisibleDataFromIdentifier( "id_village_rnpt", "afgh_rnpt001_0000", false , true )
	end,


}




function afgh_base.RegisterCrackPoints()
	Fox.Log( "afgh_base.RegisterCrackPoints" )
	TppUiCommand.RegisterCrackPoints{
		Vector3(451.4234,268.9413,2059.778),
		Vector3(502.491,270.4769,2179.7),
		Vector3(1464.682,353.1352,1433.652),
		Vector3(1607.16,361.2092,550.2523),
		Vector3(-594.5807,323.8413,647.9941),
		Vector3(-584.4622,325.0274,582.5809),
		Vector3(-463.1054,334.2138,355.8104),
		Vector3(-900.4858,290.3305,1956.564),
		Vector3(-726.0238,539.3185,-1366.024),
		Vector3(1980.945,307.5733,-496.1255),
		Vector3(1865.837,318.1019,-380.4251),
		Vector3(-1340.78,596.8517,-2771.541),
		Vector3(-1343.087,595.0551,-2782.617),
		Vector3(-1309.777,597.3832,-2971.19),
		Vector3(2091.219,478.2067,-1820.542),
		Vector3(529.3447,337.7473,9.986572),
		Vector3(764.3511,458.8442,-1036.495),
		Vector3(770.8134,460.0755,-1005.047),
		Vector3(-1446.582,294.3126,995.8232),
		Vector3(-1437.528,294.3657,980.6818),
		Vector3(-1376.357,292.0499,1006.505),
		Vector3(-1378.895,292.6224,1039.208),
		Vector3(-1373.945,295.9665,1050.913),
		Vector3(-1313.019,294.2779,1130.35),
		Vector3(-1292.315,291.9832,1161.58),
		Vector3(-1473.26,293.5357,961.9572),
		Vector3(-1328.514,292.6284,1108.255),
		Vector3(-885.243,296.3309,1930.643),
		Vector3(-347.5424,420.697,-487.0363),
	}
end






function afgh_base.QuietSupplyCheck( cpName )
	local quietSupplyList = afgh_base.QUIET_SUPPLY_POS_LIST
	if cpName ~= nil  then
		
		for cpKey, posList in pairs(quietSupplyList) do
			if cpName == cpKey then
				if TppBuddyService.IsEspionagedCp(cpName) then
					Fox.Log("afgh_base.QuietSupplyCheck: Supply Enable!!::"..cpName)
					for k, pos in pairs(posList) do
						TppPickable.PutBuddyItems( Vector3(pos[1], pos[2], pos[3]) )
					end
				else
					Fox.Log("afgh_base.QuietSupplyCheck: Supply Disable!!::"..cpName)
				end
				return
			end
		end
	else
		Fox.Warning("afgh_base.QuietSupplyCheck:: cpName error !!")
	end
end

function afgh_base.OnInitialize()
	StageBlock.AddLargeBlockNameForMessage( afgh_base.baseList )
	TppRatBird.RegisterBaseList( afgh_base.baseList )
	TppRatBird.RegisterRat( afgh_base.RAT_LIST, afgh_base.RAT_ROUTE_LIST)
	TppRatBird.RegisterBird( afgh_base.BIRD_LIST, afgh_base.BIRD_FLY_ZONE_LIST )
	TppRevenge.RegisterMineList( afgh_base.baseList, afgh_base.REVENGE_MINE_LIST )
	TppLocation.RegistBaseAssetTable( afgh_base.OnActiveTable, afgh_base.OnActiveSmallBlockTable )
	afgh_base.RegisterCrackPoints()
end

function afgh_base.OnReload()
	TppRatBird.RegisterBaseList( afgh_base.baseList )
	TppRatBird.RegisterRat( afgh_base.RAT_LIST, afgh_base.RAT_ROUTE_LIST)
	TppRatBird.RegisterBird( afgh_base.BIRD_LIST, afgh_base.BIRD_FLY_ZONE_LIST )
	TppRevenge.RegisterMineList( afgh_base.baseList, afgh_base.REVENGE_MINE_LIST )
end


return afgh_base