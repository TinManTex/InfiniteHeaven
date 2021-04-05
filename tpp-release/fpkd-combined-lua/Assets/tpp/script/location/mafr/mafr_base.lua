





local  mafr_base = {}

mafr_base.baseList = {
	
	"mafr_banana",
	"mafr_chicoVil",
	"mafr_diamond",
	"mafr_factory",
	"mafr_flowStation",
	"mafr_hill",
	"mafr_lab",
	"mafr_outland",
	"mafr_pfCamp",
	"mafr_savannah",
	"mafr_swamp",
}





mafr_base.RAT_LIST = {
	"anml_rat_00",
	"anml_rat_01",
	"anml_rat_02",
	"anml_rat_03",
	"anml_rat_04",
}






mafr_base.RAT_ROUTE_LIST = {
	mafr_banana = {
		{ name = "rt_anml_banana_rat_00", pos = {293.178, 43.300, -1264.636} },
		{ name = "rt_anml_banana_rat_01", pos = {261.727, 39.707, -1125.195} },
		{ name = "rt_anml_banana_rat_02", pos = {312.243, 41.360, -1150.473} },
		{ name = "rt_anml_banana_rat_03", pos = {271.629, 43.546, -1211.930} },
		{ name = "rt_anml_banana_rat_04", pos = {325.176, 43.103, -1222.508} },
	},
	mafr_chicoVil = {},
	mafr_diamond = {
		{ name = "rt_anml_diamond_rat_00", pos = {1295.005, 139.712, -1653.386} },
		{ name = "rt_anml_diamond_rat_01", pos = {1225.663, 138.799, -1513.537} },
		{ name = "rt_anml_diamond_rat_02", pos = {1305.926, 115.935, -1532.515} },
		{ name = "rt_anml_diamond_rat_03", pos = {1404.197, 128.773, -1515.155} },
		{ name = "rt_anml_diamond_rat_04", pos = {1460.737, 120.405, -1397.062} },
	},
	mafr_factory = {},
	mafr_flowStation = {
		{ name = "rt_anml_flowStation_rat_00",		pos = {-1090.732, -21.029, -136.694} },
		{ name = "rt_anml_flowStation_rat_01",		pos = {-1130.578, -20.105, -236.008} },
		{ name = "rt_anml_flowStation_rat_02",		pos = {-1073.469, -19.603, -283.514} },
		{ name = "rt_anml_flowStation_rat_03",		pos = {-1056.180, -12.630, -247.264} },
		{ name = "rt_anml_flowStation_rat_04",		pos = {-972.607, -13.601, -269.563} },
	},
	mafr_hill = {
		{ name = "rt_anml_hill_rat_00",		pos = {2078.947, 50.939, 397.284} },
		{ name = "rt_anml_hill_rat_01",		pos = {2133.701, 56.704, 405.947} },
		{ name = "rt_anml_hill_rat_02",		pos = {2216.022, 56.486, 393.910} },
		{ name = "rt_anml_hill_rat_03",		pos = {2157.137, 56.815, 418.261} },
		{ name = "rt_anml_hill_rat_04",		pos = {2078.947, 52.046, 350.850} },
	},
	mafr_lab = {
		{ name = "rt_anml_lab_rat_00", pos = {2626.717,130.4585,-2053.883} },
		{ name = "rt_anml_lab_rat_01", pos = {2651.305,138.2911,-2079.972} },
		{ name = "rt_anml_lab_rat_02", pos = {2650.141,128.3472,-2009.068} },
		{ name = "rt_anml_lab_rat_03", pos = {2578.429,120.3837,-2113.017} },
		{ name = "rt_anml_lab_rat_04", pos = {2586.854,132.1135,-2153.625} },
	},
	mafr_north = {},
	mafr_northEast = {},
	mafr_outland = {
		{ name = "rt_anml_outland_rat_00",		pos = {-687.116, -2.359, 919.469} },
		{ name = "rt_anml_outland_rat_01",		pos = {-688.710, -11.539, 975.624} },
		{ name = "rt_anml_outland_rat_02",		pos = {-595.305, -16.638, 1079.417} },
		{ name = "rt_anml_outland_rat_03",		pos = {-521.961, -11.537, 1114.271} },
		{ name = "rt_anml_outland_rat_04",		pos = {-674.055, -14.841, 1076.805} },
	},
	mafr_pfCamp = {
		{ name = "rt_anml_pfCamp_rat_00",		pos = {809.736, -10.855, 1224.839} },
		{ name = "rt_anml_pfCamp_rat_01",		pos = {770.284, -10.902, 1182.176} },
		{ name = "rt_anml_pfCamp_rat_02",		pos = {729.866, -11.780, 1201.092} },
		{ name = "rt_anml_pfCamp_rat_03",		pos = {785.970, -6.909, 1290.874} },
		{ name = "rt_anml_pfCamp_rat_04",		pos = {872.971, -6.909, 993.444} },
	},
	mafr_savannah = {
		{ name = "rt_anml_savannah_rat_00",		pos = {991.462, 26.312, -195.333} },
		{ name = "rt_anml_savannah_rat_01",		pos = {925.820, 14.200, -200.100} },
		{ name = "rt_anml_savannah_rat_02",		pos = {875.107, 7.724, -211.645} },
		{ name = "rt_anml_savannah_rat_03",		pos = {899.540, 11.227, -191.259} },
		{ name = "rt_anml_savannah_rat_04",		pos = {850.167, 7.090, -120.060} },
	},
	mafr_south = {},
	mafr_southEast = {},
	mafr_swamp = {
		{ name = "rt_anml_swamp_rat_00",		pos = {-23.362, -4.337, 106.441} },
		{ name = "rt_anml_swamp_rat_01",		pos = {-63.126, -2.991, 86.477} },
		{ name = "rt_anml_swamp_rat_02",		pos = {-82.477, -3.399, 102.042} },
		{ name = "rt_anml_swamp_rat_03",		pos = {-107.334, -4.078, 56.635} },
		{ name = "rt_anml_swamp_rat_04",		pos = {14.811, -2.846, 5.669} },
	},
	mafr_test = {},
	mafr_west = {},
	mafr_yrdy = {},
}





mafr_base.BIRD_LIST = {
	{ name = "anml_bird_00", birdType = "TppCritterBird" },
	{ name = "anml_bird_01", birdType = "TppCritterBird" },
	{ name = "anml_bird_02", birdType = "TppCritterBird" },
	{ name = "anml_bird_03", birdType = "TppCritterBird" },
	{ name = "anml_bird_04", birdType = "TppCritterBird" },
}






mafr_base.BIRD_FLY_ZONE_LIST = {
	mafr_banana = {
		{ center = {264.80029296875,73.724159240723,-1250.8507080078}, radius = 70, height = 5, perch = { {280.29418945313,69.958320617676,-1327.9168701172}, {257.76794433594,73.217864990234,-1327.7723388672}, }, },
		{ center = {251.97866821289,77.990165710449,-1161.2696533203}, radius = 74.612495422363, height = 11.767175674438, ground = { {335.85992431641,56.019081115723,-1127.1997070313}, {331.52154541016,57.162902832031,-1150.8167724609}, }, },
		{ center = {454.71340942383,92.796211242676,-1276.9909667969}, radius = 58.800003051758, height = 7.3500003814697, perch = { {497.11483764648,82.280517578125,-1349.3658447266}, {552.56732177734,72.548782348633,-1233.2451171875}, }, },
		{ center = {413.28106689453,70.126167297363,-941.17150878906}, radius = 79.210258483887, height = 10.956476211548, ground = { {384.93316650391,57.929664611816,-1022.8223266602}, {473.52059936523,50.774806976318,-963.12976074219}, }, },
		{ center = {269.09844970703,74.538642883301,-1000.6384887695}, radius = 81.153671264648, height = 16.690313339233, perch = { {353.55026245117,54.128089904785,-1069.6461181641}, {248.61950683594,55.263084411621,-1035.6846923828}, }, },
	},
	mafr_diamond = {
		{ center = {1490.7449951172,140.42889404297,-942.5830078125}, radius = 40, height = 5, perch = { {1449.1169433594,129.50311279297,-934.27105712891}, {1516.3970947266,128.51695251465,-907.25073242188}, }, },
		{ center = {1293.5891113281,161.45710754395,-1574.4832763672}, radius = 44, height = 11.078914642334, perch = { {1344.607421875,142.82754516602,-1637.0466308594}, {1344.8488769531,145.95620727539,-1666.8427734375}, }, },
		{ center = {1064.9351806641,168.07879638672,-1464.6977539063}, radius = 50, height = 10, perch = { {1023.412109375,156.61999511719,-1402.3323974609}, {1110.1281738281,159.49517822266,-1395.8247070313}, }, },
		{ center = {1468.1192626953,135.11958312988,-1435.0322265625}, radius = 32.48558807373, height = 5.9502458572388, perch = { {1452.2685546875,127.3184967041,-1388.2885742188}, {1452.9052734375,127.28310394287,-1388.5419921875}, }, },
		{ center = {1244.1193847656,161.03512573242,-1554.7274169922}, radius = 52.535003662109, height = 7.5050001144409, perch = { {1341.1683349609,147.40922546387,-1609.1019287109}, {1216.6843261719,150.43266296387,-1503.572265625}, }, },
	},
	mafr_factory = {
		{ center = {2839.7834472656,123.80258178711,-910.64721679688}, radius = 53.551879882813, height = 7.5749001502991, perch = { {2893.4516601563,110.1378326416,-903.12432861328}, {2900.4558105469,109.91020965576,-911.27960205078}, }, },
		{ center = {2750.8649902344,128.52772521973,-915.23962402344}, radius = 60, height = 5, perch = { {2728.7521972656,121.14289855957,-970.16247558594}, {2685.3330078125,119.48041534424,-950.08294677734}, }, },
		{ center = {2873.1088867188,112.01026153564,-771.80737304688}, radius = 40, height = 5, perch = { {2826.9753417969,108.73066711426,-811.68804931641}, {2889.9853515625,105.14181518555,-808.06713867188}, }, },
		{ center = {2413.2092285156,120.82822418213,-829.69732666016}, radius = 60, height = 15, perch = { {2368.7966308594,101.02375793457,-875.74566650391}, {2443.7036132813,95.185256958008,-870.26739501953}, }, },
		{ center = {2636.4379882813,130.2922668457,-935.43920898438}, radius = 40, height = 5, perch = { {2591.8166503906,127.20724487305,-964.5625}, {2639.4536132813,124.85047912598,-969.49737548828}, }, },
	},
	mafr_flowStation = {
		{ center = {-982.07232666016,11.705760955811,-228.20848083496}, radius = 61.709999084473, height = 8.7125263214111, perch = { {-1043.8620605469,-1.2820272445679,-215.34921264648}, {-911.45050048828,4.0676064491272,-203.37306213379}, }, },
		{ center = {-1166.5694580078,18.674921035767,-148.87753295898}, radius = 97.704002380371, height = 18.813776016235, perch = { {-980.71105957031,1.0197372436523,-129.20635986328}, {-1066.4864501953,0.95047378540039,-26.238548278809}, }, },
		{ center = {-768.87872314453,35.337890625,-427.22991943359}, radius = 100, height = 15, perch = { {-828.99536132813,23.765830993652,-326.5263671875}, {-781.85272216797,21.59294128418,-371.94891357422}, }, },
		{ center = {-981.40222167969,36.196071624756,-459.95291137695}, radius = 140, height = 15, perch = { {-1032.1276855469,-3.9636077880859,-267.67007446289}, {-1053.7583007813,9.2160625457764,-226.36209106445}, }, },
		{ center = {-1155.6324462891,2.8627517223358,-334.63888549805}, radius = 77.199996948242, height = 9.6499996185303, perch = { {-1070.0098876953,-1.2819707393646,-252.17144775391}, {-1084.8568115234,-7.2110710144043,-298.35784912109}, }, },
	},
	mafr_hill = {
		{ center = {2156.1818847656,97.745178222656,369.43685913086}, radius = 63.349998474121, height = 14.912643432617, perch = { {2133.0180664063,74.719009399414,423.76400756836}, {2186.8647460938,72.712341308594,354.81173706055}, }, },
		{ center = {2112.5639648438,99.448936462402,341.24020385742}, radius = 40, height = 10, perch = { {2090.6318359375,79.568939208984,259.82897949219}, {2114.4538574219,74.645164489746,434.71438598633}, }, },
		{ center = {1939.5759277344,70.30827331543,367.11801147461}, radius = 108.59999847412, height = 13.574999809265, perch = { {1984.9497070313,49.167106628418,315.36022949219}, {2008.8948974609,48.772796630859,342.85433959961}, }, },
		{ center = {2312.6049804688,93.592910766602,356.87658691406}, radius = 120, height = 10, perch = { {2287.3256835938,86.046821594238,268.5432434082}, {2354.0239257813,84.955833435059,461.57678222656}, }, },
		{ center = {2133.4870605469,109.53170013428,497.65539550781}, radius = 100, height = 10, perch = { {2167.1391601563,88.497344970703,453.80673217773}, {2210.3798828125,76.166213989258,360.76599121094}, }, },
	},
	mafr_lab = {
		{ center = {2750.3010253906,206.7039642334,-2372.4423828125}, radius = 37.247997283936, height = 3.0474035739899, perch = { {2723.7729492188,205.06970214844,-2414.576171875}, {2749.8627929688,200.7378692627,-2387.84765625}, }, },
		{ center = {2699.5366210938,114.88748931885,-1847.6317138672}, radius = 45, height = 8, perch = { {2667.3217773438,94.250793457031,-1874.4953613281}, {2657.2624511719,95.60009765625,-1863.7554931641}, }, },
		{ center = {2458.5859375,224.64199829102,-2376.2590332031}, radius = 40, height = 5, perch = { {2423.5627441406,215.39279174805,-2396.1594238281}, {2426.7954101563,216.74491882324,-2336.0336914063}, }, },
		{ center = {2697.595703125,185.79400634766,-2340.2915039063}, radius = 34.349998474121, height = 5.7249999046326, perch = { {2730.7875976563,169.23278808594,-2345.5144042969}, {2671.9956054688,172.01644897461,-2345.5373535156}, }, },
		{ center = {2683.3862304688,163.97100830078,-2223.1354980469}, radius = 45, height = 9, perch = { {2710.6484375,159.73956298828,-2232.1560058594}, {2705.7524414063,158.52931213379,-2232.859375}, }, },
	},
	mafr_outland = {
		{ center = {-640.06048583984,5.2864055633545,1030.0244140625}, radius = 52.939250946045, height = 10.951700210571, perch = { {-639.36822509766,-2.7836132049561,976.23095703125}, {-658.27911376953,-8.4732398986816,992.39758300781}, }, },
		{ center = {-684.89715576172,38.363147735596,835.69677734375}, radius = 100, height = 18.258165359497, perch = { {-700.22418212891,11.249370574951,848.82299804688}, {-700.62213134766,9.4573860168457,813.33355712891}, }, },
		{ center = {-452.10864257813,34.784858703613,1128.4069824219}, radius = 102.76499938965, height = 11.857500076294, perch = { {-534.46911621094,17.849143981934,1188.7978515625}, {-468.92544555664,19.431411743164,1174.5915527344}, }, },
		{ center = {-510.32760620117,30.015186309814,965.77960205078}, radius = 120, height = 10, perch = { {-527.38208007813,11.965274810791,1029.7016601563}, {-519.83349609375,13.072553634644,1050.8413085938}, }, },
		{ center = {-724.13140869141,-0.11131499707699,1081.0129394531}, radius = 60, height = 11.918763160706, perch = { {-697.85382080078,-8.1412591934204,1065.6108398438}, {-690.83551025391,1.5558577775955,1070.8381347656}, }, },
	},
	mafr_pfCamp = {
		{ center = {735.01281738281,14.879675865173,1050.5970458984}, radius = 60, height = 10, perch = { {748.18774414063,10.075074195862,1030.3673095703}, {738.78967285156,-6.8849000930786,1138.0454101563}, }, },
		{ center = {865.02709960938,19.704570770264,1181.6700439453}, radius = 130, height = 10, perch = { {800.47778320313,16.052528381348,1216.9781494141}, {802.87982177734,10.058926582336,1214.1176757813}, }, },
		{ center = {1011.2801513672,23.109241485596,998.35260009766}, radius = 102.79999542236, height = 12.849999427795, perch = { {910.94537353516,-2.2837600708008,1073.8367919922}, {903.15026855469,-3.2849864959717,1007.4172363281}, }, },
		{ center = {634.07708740234,18.218851089478,864.60412597656}, radius = 108, height = 9, perch = { {736.18939208984,0.37704277038574,898.40802001953}, {549.81207275391,1.8556842803955,873.81628417969}, }, },
		{ center = {827.26300048828,22.91028213501,863.44763183594}, radius = 100, height = 20, perch = { {954.12860107422,-2.9562301635742,905.01989746094}, {736.75024414063,0.29704284667969,899.48400878906}, }, },
	},
	mafr_savannah = {
		{ center = {944.11181640625,44.260501861572,-176.05349731445}, radius = 45, height = 10, perch = { {1015.5978393555,28.092704772949,-184.06050109863}, {973.5087890625,35.054763793945,-219.61224365234}, }, },
		{ center = {999.26190185547,62.8268699646,-221.90330505371}, radius = 120, height = 10, perch = { {1010.3992919922,50.955375671387,-222.36898803711}, {994.58477783203,48.421058654785,-221.4965057373}, }, },
		{ center = {1136.8006591797,48.335933685303,-271.46588134766}, radius = 93, height = 13.949999809265, perch = { {1053.9597167969,29.502201080322,-247.22885131836}, {1035.07421875,39.10684967041,-209.34777832031}, }, },
		{ center = {1138.2409667969,36.878898620605,-50.808128356934}, radius = 109.375, height = 8.75, perch = { {1087.9998779297,19.821426391602,-158.57092285156}, {1237.9071044922,21.916969299316,15.787582397461}, }, },
		{ center = {805.75451660156,23.864448547363,-69.485481262207}, radius = 88.160003662109, height = 9.3650321960449, perch = { {823.46533203125,14.458168029785,-100.7914276123}, {866.46435546875,11.00248336792,-126.70386505127}, }, },
	},
	mafr_swamp = {
		{ center = {-43.014068603516,23.847789764404,-113.4508972168}, radius = 125, height = 10, perch = { {-5.3013191223145,2.4658298492432,-119.3583984375}, {-87.580123901367,3.0611515045166,-101.77365112305}, }, },
		{ center = {-130.58540344238,29.335048675537,92.376831054688}, radius = 100, height = 20, perch = { {-221.7434387207,6.7741165161133,57.506782531738}, {-63.366088867188,3.4369735717773,84.976135253906}, }, },
		{ center = {-360.28582763672,23.263481140137,-56.959079742432}, radius = 100, height = 15, perch = { {-278.69982910156,5.1341667175293,-82.510284423828}, {-277.78811645508,5.0747737884521,-41.996284484863}, }, },
		{ center = {-153.5699005127,35.260520935059,-146.70120239258}, radius = 80, height = 10, perch = { {-202.78631591797,13.673856735229,-87.546035766602}, {-202.78900146484,13.670486450195,-86.864700317383}, }, },
		{ center = {114.65456390381,35.260520935059,29.759304046631}, radius = 135.5, height = 27.10000038147, perch = { {-7.3175430297852,4.1033935546875,125.67570495605}, {137.09239196777,-2.8180313110352,260.05157470703}, }, },
	},
}





mafr_base.REVENGE_MINE_LIST = {
	mafr_banana = {
		decoyLocatorList = {
			"itm_revDecoy_banana_a_0000",
			"itm_revDecoy_banana_a_0001",
			"itm_revDecoy_banana_a_0002",
			"itm_revDecoy_banana_a_0003",
			"itm_revDecoy_banana_a_0004",
		},
		{
			trapName = "trap_mafr_banana_mine_east",
				mineLocatorList = {
					"itm_revMine_banana_a_0000",
					"itm_revMine_banana_a_0001",
					"itm_revMine_banana_a_0002",
					"itm_revMine_banana_a_0003",
					"itm_revMine_banana_a_0004",
				},
		},
		{
			trapName = "trap_mafr_banana_mine_south",
				mineLocatorList = {
					"itm_revMine_banana_a_0005",
					"itm_revMine_banana_a_0006",
					"itm_revMine_banana_a_0007",
					"itm_revMine_banana_a_0008",
					"itm_revMine_banana_a_0009",
				},
		},
	},
	mafr_chicoVil = {},
	mafr_diamond = {
		decoyLocatorList = {
			"itm_revDecoy_diamond_a_0000",
			"itm_revDecoy_diamond_a_0001",
			"itm_revDecoy_diamond_a_0002",
			"itm_revDecoy_diamond_a_0003",
			"itm_revDecoy_diamond_a_0004",
		},
		{
			trapName = "trap_mafr_diamond_mine_north",
				mineLocatorList = {
					"itm_revMine_diamond_a_0005",
					"itm_revMine_diamond_a_0006",
					"itm_revMine_diamond_a_0007",
					"itm_revMine_diamond_a_0008",
					"itm_revMine_diamond_a_0009",
				},
		},
		{
			trapName = "trap_mafr_diamond_mine_west",
				mineLocatorList = {
					"itm_revMine_diamond_a_0000",
					"itm_revMine_diamond_a_0001",
					"itm_revMine_diamond_a_0002",
					"itm_revMine_diamond_a_0003",
					"itm_revMine_diamond_a_0004",
				},
		},
	},
	mafr_factory = {},
	mafr_flowStation = {
		decoyLocatorList = {
			"itm_revDecoy_flowStation_a_0000",
			"itm_revDecoy_flowStation_a_0001",
			"itm_revDecoy_flowStation_a_0002",
			"itm_revDecoy_flowStation_b_0001",
			"itm_revDecoy_flowStation_b_0004",
		},
		{
			trapName = "trap_revMine_flowStation_South",
				mineLocatorList = {
					"itm_revMine_flowStation_a_0000",
					"itm_revMine_flowStation_a_0001",
					"itm_revMine_flowStation_a_0002",
					"itm_revMine_flowStation_a_0003",
					"itm_revMine_flowStation_a_0004",
				},
		},
		{
			trapName = "trap_revMine_flowStation_East",
				mineLocatorList = {
					"itm_revMine_flowStation_b_0000",
					"itm_revMine_flowStation_b_0001",
					"itm_revMine_flowStation_b_0002",
					"itm_revMine_flowStation_b_0003",
					"itm_revMine_flowStation_b_0004",
				},
		},
	},
	mafr_hill = {
		{
			trapName = "trap_mafr_hill_mine_northWest",
				mineLocatorList = {
					"itm_revMine_hill_a_0000",
					"itm_revMine_hill_a_0001",
					"itm_revMine_hill_a_0002",
				},
				decoyLocatorList = {
					"itm_revDecoy_hill_a_0001",
				},
		},
		{
			trapName = "trap_mafr_hill_mine_northEast",
				mineLocatorList = {
					"itm_revMine_hill_a_0003",
					"itm_revMine_hill_a_0004",
					"itm_revMine_hill_a_0005",
				},
				decoyLocatorList = {
					"itm_revDecoy_hill_a_0000",
					"itm_revDecoy_hill_a_0002",
					"itm_revDecoy_hill_a_0003",
					"itm_revDecoy_hill_a_0004",
				},
		},
		{
			trapName = "trap_mafr_hill_mine_south",
				mineLocatorList = {
					"itm_revMine_hill_a_0006",
					"itm_revMine_hill_a_0007",
					"itm_revMine_hill_a_0008",
					"itm_revMine_hill_a_0009",
				},
		},
		{
			trapName = "trap_mafr_hill_mine_factorySouth",
		},
	},
	mafr_lab = {
		decoyLocatorList = {
			"itm_revDecoy_lab_a_0000",
			"itm_revDecoy_lab_a_0001",
			"itm_revDecoy_lab_a_0002",
			"itm_revDecoy_lab_a_0003",
			"itm_revDecoy_lab_a_0004",
		},
		{
			trapName = "trap_mafr_lab_mine_west",
				mineLocatorList = {
					"itm_revMine_lab_a_0000",
					"itm_revMine_lab_a_0001",
					"itm_revMine_lab_a_0002",
					"itm_revMine_lab_a_0003",
					"itm_revMine_lab_a_0004",
				},
		},
		{
			trapName = "trap_mafr_lab_mine_south",
				mineLocatorList = {
					"itm_revMine_lab_a_0005",
					"itm_revMine_lab_a_0006",
					"itm_revMine_lab_a_0007",
					"itm_revMine_lab_a_0008",
					"itm_revMine_lab_a_0009",
				},
		},
	},
	mafr_north = {},
	mafr_northEast = {},
	mafr_outland = {
		{
			trapName = "trap_revMine_outland_East",
				mineLocatorList = {
					"itm_revMine_outland_a_0000",
					"itm_revMine_outland_a_0001",
					"itm_revMine_outland_a_0002",
					"itm_revMine_outland_a_0003",
				},
				decoyLocatorList = {
					
					




				},
		},
		{
			trapName = "trap_revMine_outland_North",
				mineLocatorList = {
					"itm_revMine_outland_b_0000",
					"itm_revMine_outland_b_0001",
					"itm_revMine_outland_b_0002",
					"itm_revMine_outland_b_0003",
					"itm_revMine_outland_b_0004",
					"itm_revMine_outland_b_0005",
				},
				decoyLocatorList = {
					
					




				},
		},
	},
	mafr_pfCamp = {
		decoyLocatorList = {
			"itm_revDecoy_pfCamp_a_0000",
			"itm_revDecoy_pfCamp_a_0001",
			"itm_revDecoy_pfCamp_a_0002",
			"itm_revDecoy_pfCamp_a_0003",
			"itm_revDecoy_pfCamp_a_0004",
		},
		{
			trapName = "trap_mafr_pfCamp_mine_south",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0008",
					"itm_revMine_pfCamp_a_0009",
				},
		},
		{
			trapName = "trap_mafr_pfCamp_mine_southEast",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0006",
					"itm_revMine_pfCamp_a_0007",
				},
		},
		{
			trapName = "trap_mafr_pfCamp_mine_east2",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0004",
					"itm_revMine_pfCamp_a_0005",
				},
		},
		{
			trapName = "trap_mafr_pfCamp_mine_east1",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0002",
					"itm_revMine_pfCamp_a_0003",
				},
		},
		{
			trapName = "trap_mafr_pfCamp_mine_northEast",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0000",
					"itm_revMine_pfCamp_a_0001",
				},
		},
		{
			trapName = "trap_mafr_pfCamp_mine_north",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0010",
					"itm_revMine_pfCamp_a_0011",
				},
		},
		{
			trapName = "trap_mafr_pfCamp_mine_west",
				mineLocatorList = {
					"itm_revMine_pfCamp_a_0012",
					"itm_revMine_pfCamp_a_0013",
				},
		},
		{
			trapName = "trap_mafr_pfCampNorth_mine",
		},
	},
	mafr_savannah = {
		{
			trapName = "trap_mafr_savannah_mine_south1",
				mineLocatorList = {
					"itm_revMine_savannah_a_0000",
					"itm_revMine_savannah_a_0001",
					"itm_revMine_savannah_a_0004",

				},
				decoyLocatorList = {
					"itm_revDecoy_savannah_b_0004",
				},
		},
		{
			trapName = "trap_mafr_savannah_mine_south2",
				mineLocatorList = {
					"itm_revMine_savannah_a_0002",
					"itm_revMine_savannah_a_0003",
				},
				decoyLocatorList = {
					"itm_revDecoy_savannah_b_0000",
					"itm_revDecoy_savannah_b_0003",
				},
		},
		{
			trapName = "trap_mafr_savannah_mine_north",
				mineLocatorList = {
					"itm_revMine_savannah_a_0006",
					"itm_revMine_savannah_a_0009",
				},
				decoyLocatorList = {
					"itm_revDecoy_savannah_b_0001",
				},
		},
		{
			trapName = "trap_mafr_savannah_mine_west",
				mineLocatorList = {
					"itm_revMine_savannah_a_0005",
					"itm_revMine_savannah_a_0007",
					"itm_revMine_savannah_a_0008",
				},
				decoyLocatorList = {
					"itm_revDecoy_savannah_b_0002",
				},
		},
	},
	mafr_south = {},
	mafr_southEast = {},
	mafr_swamp = {
		decoyLocatorList = {
			"itm_revDecoy_swamp_b_0000",
			"itm_revDecoy_swamp_b_0001",
			"itm_revDecoy_swamp_b_0002",
			"itm_revDecoy_swamp_b_0003",
			"itm_revDecoy_swamp_b_0004",
		},
		{
			trapName = "trap_mafr_swamp_mine_north",
				mineLocatorList = {
					"itm_revMine_swamp_a_0000",
					"itm_revMine_swamp_a_0001",
					"itm_revMine_swamp_a_0002",

				},
		},
		{
			trapName = "trap_mafr_swamp_mine_south",
				mineLocatorList = {
					"itm_revMine_swamp_a_0003",
					"itm_revMine_swamp_a_0004",
					"itm_revMine_swamp_a_0005",
				},
		},
		{
			trapName = "trap_mafr_swamp_mine_west",
				mineLocatorList = {
					"itm_revMine_swamp_a_0006",
					"itm_revMine_swamp_a_0007",
					"itm_revMine_swamp_a_0008",
					"itm_revMine_swamp_a_0009",
				},
		},
	},
	mafr_test = {},
	mafr_west = {},
	mafr_yrdy = {},
}






mafr_base.QUIET_SUPPLY_POS_LIST = {
	mafr_banana_cp = {
		{ 321.317, 47.354, -1152.974 },
		{ 290.927, 38.380, -1063.879 },
		{ 310.624, 43.505, -1218.276 },
	},



	mafr_diamond_cp = {
		{ 1191.770, 149.465, -1495.481 },
		{ 1283.890, 139.722, -1652.183 },
		{ 1521.181, 124.491, -981.401 },
	},
	mafr_factory_cp = {
		{ 2831.867, 101.871, -815.645 },
		{ 2833.824, 101.100, -961.203 },
	},
	mafr_flowStation_cp = {
		{ -1143.332, -3.256, -59.786 },
		{ -984.767, -11.112, -262.644 },
		{ -866.788, 6.221, -315.335 },
	},
	mafr_hill_cp = {
		{ 2102.763, 63.271, 439.511 },
		{ 2110.861, 73.254, 338.909 },
		{ 2237.354, 60.164, 411.151 },
	},
	mafr_lab_cp = {
		{ 2677.939, 158.960, -2300.971 },
		{ 2640.247, 180.451, -2391.957 },
		{ 2783.725, 189.756, -2419.956 },
	},
	mafr_outland_cp = {
		{ -486.479, 2.256, 1167.307 },
		{ -572.506, 4.942, 967.851 },
		{ -691.621, 2.073, 907.860 },
	},
	mafr_pfCamp_cp = {
		{ 743.215, -1.545, 923.035 },
		{ 590.550, 3.599, 1195.359 },
		{ 976.516, -6.909, 1355.149 },
		{ 881.413, -3.642, 1062.074 },
	},
	mafr_savannah_cp = {
		{ 823.501, 13.281, -97.537 },
		{ 793.804, 8.229, -306.432 },
		{ 1008.791, 51.137, -221.880 },
	},
	mafr_swamp_cp = {
		{ -90.692, 1.492, -103.426 },
		{ -197.914, 11.565, -72.561 },
		{ -17.339, -6.775, -17.878 },
		{ -192.801, 0.105, 178.989 },
	},
}




mafr_base.OnActiveTable = {
	mafr_banana = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_banana")
		
		mafr_base.QuietSupplyCheck("mafr_banana_cp")
	end,

	mafr_diamond = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_diamond")
		local sequence = TppSequence.GetCurrentSequenceName()
		
		local EVENT_DOOR_BOY		= "mafr_gate002_vrtn002_gim_n0001|srt_mafr_gate002_vrtn002"
		local EVENT_DOOR_DEMO		= "mafr_gate002_vrtn001_gim_n0000|srt_mafr_gate002_vrtn001"
		local EVENT_DOOR_PATH		= "/Assets/tpp/level/location/mafr/block_large/diamond/mafr_diamond_gimmick.fox2"
		local CAVE_DOOR_DATA		= "mafr_gate002_vrtn002_gim_n0003|srt_mafr_gate002_vrtn002"
		local CAVE_DOOR_PATH		= "/Assets/tpp/level/location/mafr/block_large/diamond/mafr_diamond_gimmick.fox2"
		if TppMission.GetMissionID() == 10100 then		
			if 		sequence == "Seq_Game_BeforeRescueBoy" then
				Fox.Log("Event Door Setting ON")
				Gimmick.SetEventDoorLock( EVENT_DOOR_BOY , EVENT_DOOR_PATH , true , 0 )	
				Gimmick.SetEventDoorLock( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , true , 0 )	
			elseif 	sequence == "Seq_Game_AfterRescueBoy" then
				Fox.Log("Event Door Enable")
				Gimmick.SetEventDoorInvisible( EVENT_DOOR_BOY , EVENT_DOOR_PATH , false )	
				Gimmick.SetEventDoorInvisible( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , false )	
				Fox.Log("Event Door Setting OFF")
				Gimmick.SetEventDoorLock( EVENT_DOOR_BOY , EVENT_DOOR_PATH , false , 1 )	
				Gimmick.SetEventDoorLock( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , false , -1 )	
			elseif 	sequence == "Seq_Game_Escape" then
				
				Fox.Log("Event Door Enable")
				Gimmick.SetEventDoorInvisible( EVENT_DOOR_BOY , EVENT_DOOR_PATH , false )	
				Gimmick.SetEventDoorInvisible( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , false )	
				Fox.Log("Event Door Setting OFF")
				Gimmick.SetEventDoorLock( EVENT_DOOR_BOY , EVENT_DOOR_PATH , false , 0 )	
				Gimmick.SetEventDoorLock( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , false , 0 )	
			else
				Fox.Log("DemoSequence ... No Setting !!")
			end
		else											
			
			Fox.Log("Event Door Enable")
			Gimmick.SetEventDoorInvisible( EVENT_DOOR_BOY , EVENT_DOOR_PATH , false )	
			Gimmick.SetEventDoorInvisible( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , false )	
			Fox.Log("Event Door Setting OFF")
			Gimmick.SetEventDoorLock( EVENT_DOOR_BOY , EVENT_DOOR_PATH , false , 0 )	
			Gimmick.SetEventDoorLock( EVENT_DOOR_DEMO , EVENT_DOOR_PATH , false , 0 )	
		end
		
		mafr_base.QuietSupplyCheck("mafr_diamond_cp")
	end,

	mafr_factory = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_factory")
		local missionId = 10110
		if TppMission.GetMissionID() ~= missionId then
			if TppStory.IsMissionCleard( missionId ) then
				
				
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenTunnel", true, true)
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel_after", true )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel", true )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_rock", true )
			else
				
				
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenTunnel", false, true)
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel_after", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_rock", false )
			end
		elseif TppMission.GetMissionID() == 10110 then
			if sequence == "Seq_Game_GoToFactory" then
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenWall", false, true) 
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenTunnel", false, true) 
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Broken_stfr0001", false, true) 
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Broken_stfr0002", false, true) 
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_after", true, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_before", false, true)
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "bed_before", true, true)
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_bed_after", false )
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_door", false )
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel_after", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_rock", false )
			elseif sequence == "Seq_Game_SearchTarget" then
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenWall", false, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenTunnel", false, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Broken_stfr0001", false, true) 
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Broken_stfr0002", false, true) 
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_after", true, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_before", false, true)
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_door", false )
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel_after", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_rock", false )
			elseif sequence == "Seq_Game_Escape" then
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "bed_before", false, true)
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_bed_after", true )
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "bed_after", true, true)
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_bed_before", false )
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_door", false )
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel_after", false )
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_rock", false )
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenWall", false, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Volgin_BrokenTunnel", false, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Broken_stfr0001", false, true) 
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "Broken_stfr0002", false, true) 
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_after", true, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_before", false, true)
			elseif sequence == "Seq_Game_Escape2" then
				
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_after", true, true)
				TppDataUtility.SetVisibleDataFromIdentifier( "GimmickIdentifier", "door_before", false, true)
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_door", true )
				
				TppDataUtility.SetEnableDataFromIdentifier( "GimmickIdentifier", "Wall_tunnel_after", true )
			end
		end
		
		mafr_base.QuietSupplyCheck("mafr_factory_cp")
	end,

	mafr_flowStation = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_flowStation")
		local PDOR_NAME1	 				= "flowStation_pickingDoor_01"		
		local PDOR_NAME2	 				= "flowStation_pickingDoor_02"		
		local missionId = 10080
		local missionId_hard = 11080

		if TppMission.GetMissionID() == missionId or TppMission.GetMissionID() == missionId_hard then
		else
			if TppStory.IsMissionCleard( missionId ) then
				
				
				TppGimmick.Hide( PDOR_NAME1 )
				TppGimmick.Hide( PDOR_NAME2 )

				TppDataUtility.SetVisibleDataFromIdentifier( "id_before_explosion", "before_explosion",false , true )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_after_explosion" , "after_explosion" , true , true )

				TppDataUtility.SetVisibleDataFromIdentifier( "id_after_explosion_tank", "mafr_tank003_vrtn001_0000",false , true )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_after_explosion_tank", "mafr_tank003_vrtn001_0001",false , true )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_after_explosion_tank", "mafr_tank003_vrtn001_0002",false , true )

				TppDataUtility.SetEnableDataFromIdentifier( "id_after_explosion", "pathWall_0001", true)

				TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupFlowStationBefore", 	false )
				TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupFlowStationAfter", 		true )

			else
				
				
				TppDataUtility.SetVisibleDataFromIdentifier( "id_before_explosion", "before_explosion", true , true )
				TppDataUtility.SetVisibleDataFromIdentifier( "id_after_explosion" , "after_explosion" , false , true )

				TppDataUtility.SetEnableDataFromIdentifier( "id_after_explosion", "pathWall_0001", false)

				TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupFlowStationBefore", 	true )
				TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupFlowStationAfter", 		false )
			end
		end
		
		mafr_base.QuietSupplyCheck("mafr_flowStation_cp")
	end,

	mafr_hill = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_hill")
		
		mafr_base.QuietSupplyCheck("mafr_hill_cp")
	end,

	mafr_lab = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_lab")
		
		mafr_base.QuietSupplyCheck("mafr_lab_cp")
	end,

	mafr_outland = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_outland")

		
		local missionId = 10080
		local missionId_hard = 11080
		if TppMission.GetMissionID() == missionId or TppMission.GetMissionID() == missionId_hard then
			TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupfx_tpp_smkfir14_mission", 	true )
			TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupfx_tpp_smkfir14n_mission", 	true )
		else
			TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupfx_tpp_smkfir14_mission", 	false )
			TppDataUtility.SetVisibleEffectFromGroupId( "FxLocatorGroupfx_tpp_smkfir14n_mission", 	false )
		end

		
		mafr_base.QuietSupplyCheck("mafr_outland_cp")
	end,

	mafr_pfCamp = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_pfCamp")
		
		mafr_base.QuietSupplyCheck("mafr_pfCamp_cp")
	end,

	mafr_savannah = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_savannah")
		
		mafr_base.QuietSupplyCheck("mafr_savannah_cp")
	end,

	mafr_swamp = function()
		Fox.Log("mafr_base.OnActiveTable : mafr_swamp")
		
		mafr_base.QuietSupplyCheck("mafr_swamp_cp")
	end,
}




function mafr_base.RegisterCrackPoints()
	Fox.Log( "mafr_base.RegisterCrackPoints" )
	TppUiCommand.RegisterCrackPoints{
		Vector3(2671.136, 95.238, -1909.543),
		Vector3(2665.200, 109.902, -1911.108),
		Vector3(2677.496,76.1169,-1880.355),
		Vector3(2652.903,81.15977,-1835.519),
		Vector3(-487.8229,-1.70036,1163.904),
		Vector3(1026.979,75.92828,-1052.156),
		Vector3(1031.718,84.6208,-1056.016),
		Vector3(966.5699,85.13107,-1080.624),
		Vector3(-855.5587,-16.27699,733.6937),
		Vector3(-833.2029,-15.90319,777.0134),
		Vector3(2424.981,97.67179,-937.2994),
		Vector3(2430.719,100.2974,-928.8987),

	}
end






function mafr_base.QuietSupplyCheck( cpName )
	local quietSupplyList = mafr_base.QUIET_SUPPLY_POS_LIST
	if cpName ~= nil  then
		
		for cpKey, posList in pairs(quietSupplyList) do
			if cpName == cpKey then
				if TppBuddyService.IsEspionagedCp(cpName) then
					Fox.Log("mafr_base.QuietSupplyCheck: Supply Enable!!::"..cpName)
					for k, pos in pairs(posList) do
						TppPickable.PutBuddyItems( Vector3(pos[1], pos[2], pos[3]) )
					end
				else
					Fox.Log("mafr_base.QuietSupplyCheck: Supply Disable!!::"..cpName)
				end
				return
			end
		end
	else
		Fox.Warning("mafr_base.QuietSupplyCheck:: cpName error !!")
	end
end

function mafr_base.OnInitialize()
	
	StageBlock.AddLargeBlockNameForMessage( mafr_base.baseList )
	
	TppRatBird.RegisterBaseList( mafr_base.baseList )
	TppRatBird.RegisterRat( mafr_base.RAT_LIST, mafr_base.RAT_ROUTE_LIST )
	TppRatBird.RegisterBird( mafr_base.BIRD_LIST, mafr_base.BIRD_FLY_ZONE_LIST )
	TppRevenge.RegisterMineList( mafr_base.baseList, mafr_base.REVENGE_MINE_LIST )
	TppLocation.RegistBaseAssetTable( mafr_base.OnActiveTable )
	mafr_base.RegisterCrackPoints()
end

function mafr_base.OnReload()
	TppRatBird.RegisterBaseList( mafr_base.baseList )
	TppRatBird.RegisterRat( mafr_base.RAT_LIST, mafr_base.RAT_ROUTE_LIST)
	TppRatBird.RegisterBird( mafr_base.BIRD_LIST, mafr_base.BIRD_FLY_ZONE_LIST )
	TppRevenge.RegisterMineList( mafr_base.baseList, mafr_base.REVENGE_MINE_LIST )
end

return mafr_base
