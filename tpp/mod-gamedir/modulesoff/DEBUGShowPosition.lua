--tex DEBUGNOW
local e={}

if true then return {} end--DEBUGNOW

--global tpp
local G={
	tpp=Tpp,
	dmg=TppDamage,
	mis=TppMission,
	def=TppDefine,
	eqp=TppEquip,
	ene=TppEnemy,
	mbDev=TppMbDev,
	gameObj_tpp=TppGameObject,
	gameObj_v=GameObject,
	user=Player,
	userCamo=PlayerCamoType,
	userInfo=PlayerInfo,
	--userParts=PlayerPartsType,
	--userType=PlayerType,
	tppClock=TppClock,
	time=Time,
	uiCmd=TppUiCommand,
	vehType=Vehicle.type
}

--global functions
local F={
	userItemLevel=G.user.GetItemLevel,
	echo=G.uiCmd.AnnounceLogView,
	echoLng=G.uiCmd.AnnounceLogViewLangId,
	gameElapsedTime=G.time.GetRawElapsedTimeSinceStartUp,
	playerInfoAnd=G.userInfo.AndCheckStatus
}

--global lua
local tostring=tostring
local pairs=pairs
--local ipairs=ipairs
local coroutine=coroutine
local bit=bit

local t={true,true,true,true,true,true}

t=math--31 
local ceil=t.ceil
local floor=t.floor
local sqrt=t.sqrt

--t=string--15
--local str_match=t.match
--local str_gsub=t.gsub

--t=table--9
--local tab_cat=t.concat
--local tab_insert=t.insert

--t=Vehicle.type

--dictionary table, essentially
e.define={
	time={},
	weather={sunny=G.def.WEATHER.SUNNY,cloudy=G.def.WEATHER.CLOUDY,rainModerate=G.def.WEATHER.RAINY,sandstorm=G.def.WEATHER.SANDSTORM,fog=G.def.WEATHER.FOGGY,rainHeavy=G.def.WEATHER.POURING},--0-5
	location={afgh={G.def.LOCATION_ID.AFGH},mafr={G.def.LOCATION_ID.MAFR},mtbs={G.def.LOCATION_ID.MTBS,G.def.LOCATION_ID.MBQF,G.def.LOCATION_ID.CYPR}},
	mission={free={[30010]=true,[30020]=true}},
	quest={
		areaRestriction={[10010]={-1426.164,319.449,1053.029},[10020]={574.394,320.805,1091.39},[10030]={1301.97,331.741,1746.641},[10040]={-1200,399,-660},[10050]={545.646,339.103,7.983},[10060]={1580.025,346.609,47.889},[10070]={-2081.274,436.152,-1532.619},[10080]={2144.585,459.984,-1764.566},[10090]={-1258.72,598.68,-3055.925},[10100]={-1117,-22,-250},[10200]={1830.153,-12.065,1217.415},[10300]={352.291,-5.991,.927},[10400]={2155.126,56.012,392.11},[10500]={846.97,36.452,-917.762},[10600]={1611.429,128.189,-848.904},[10700]={2695.907,154.625,-2304.778},[11010]={-1058.028,290.648,1472.578},[11020]={-1143.261,322.876,839.478},[11030]={-1347.736,397.481,-729.448},[11040]={369.861,413.892,-905.375},[11050]={2383.08,86.157,-1125.214},[11060]={1812.198,465.938,-1241.909},[11070]={2194.519,429.075,-1284.068},[11080]={1475.388,344.972,13.41},[11090]={-386.984,9.648,762.663},[11100]={-552.513,-.011,-197.752},[11200]={1555.195,-12.034,1790.219},[11300]={965.708,-4.035,287.023},[11400]={1200.66,7.889,113.637},[11500]={2342.049,68.132,-104.587},[11600]={563.844,77.95,-1070.378},[11700]={713.795,33.409,-904.592},[19010]={1622.974,322.257,1062.973},[19011]={222.113,20.445,-930.962},[19012]={1910.658,59.872,-231.274},[19013]={1589.157,352.634,47.628},[20015]={-1764.669,311.1947,805.5405},[20025]={419.7284,270.3819,2206.412},[20035]={1444.029,332.4536,1493.478},[20045]={-1721.014,349.7935,-300.9322},[20055]={784.1397,474.0518,-1008.116},[20065]={1481.748,359.7492,467.3845},[20075]={-2200.667,443.142,-1632.121},[20085]={2154.21,458.245,-1782.244},[20095]={-1216.737,609.074,-3102.734},[20105]={-318.246,-13.006,1078.101},[20205]={911.094,-3.444,1072.21},[20305]={303.023,-5.295,401.582},[20405]={2172.657,56.106,377.634},[20505]={592.412,52.144,-955.067},[20605]={1532.148,127.692,-1296.662},[20705]={2643.892,143.728,-2179.943},[20805]={1876.726,321.956,-426.263},[20905]={1807.693,468.119,-1232.137},[20910]={-865.471,300.445,1949.157},[20911]={2181.73,470.912,-1815.881},[20912]={-1573.917,369.848,-321.113},[20913]={-958.532,-14.1,-224.044},[20914]={2747.504,200.042,-2401.418},[21005]={-902.816,288.046,1905.899},[22005]={-1326.552,598.564,-3041.07},[23005]={269.693,43.457,-1208.378},[24005]={2527.301,71.168,-817.188},[25005]={967.334,-11.938,1269.883},[26005]={1728.982,155.168,-1869.883},[27005]={2073.421,51.254,355.372},[30010]={516.088,321.572,1065.328},[39010]={-473.987,417.258,-496.137},[39011]={2656.23,144.117,-2173.246},[39012]={1367.551,-3.12,1892.457},[40010]={222.904,20.496,-932.784},[52010]={1388.719,299.004,1976.527},[52015]={-1836.664,358.543,-326.481},[52020]={-380.063,-2.53,490.478},[52025]={-608.622,278.374,1694.876},[52030]={-1889.494,332.666,546.761},[52035]={730.943,320.818,88.148},[52040]={-1589.128,511.561,-2113.037},[52045]={1722.589,152.294,-2079.907},[52050]={672.542,-3.727,108.875},[52055]={-350.247,-2.555,-190.417},[52060]={1156.773,-12.097,1524.507},[52065]={811.036,-11.657,1193.033},[52070]={2364.716,56.688,314.611},[52075]={1349.26,11.259,285.945},[52080]={793.002,347.536,255.957},[52085]={-1898.048,316.223,610.601},[52090]={1722.589,152.294,-2079.907},[52095]={2429.92,61.019,189.081},[52100]={810.898,-11.701,1194.177},[52105]={672.542,-3.727,108.875},[52110]={-1007.882,-14.2,-231.401},[52115]={-775.086,-3.786,563.539},[52120]={840.141,4.947,-130.741},[52125]={1156.773,-12.097,1524.507},[52130]={-1836.664,358.543,-326.481},[52135]={1393.775,299.887,1910.528},[52140]={-608.622,278.374,1694.876},[52145]={-1589.128,511.561,-2113.037},[60010]={1331.732,295.46,2164.405},[60011]={-513.1647,372.9764,1148.782},[60012]={369.4612,412.6812,-844.1393},[60013]={1921.452,456.3248,-1253.83},[60014]={-1440.167,415.0882,-1282.796},[60020]={1555.736,-8.822165,1725.071},[60021]={2151.132,70.83097,-116.7761},[60022]={2658.126,139.3819,-2146.524},[60023]={646.064,103.2225,-1122.37},[60024]={-1205.26,-21.20666,129.0079},[60110]={-719.57,536.851,-1571.775},[60111]={-2330.799,438.515,-1568.261},[60112]={785.013,473.162,-916.954},[60113]={-281.612,-8.36,751.687},[60114]={712.931,-3.225,1221.926},[60115]={501.702,321.852,1194.651},[71010]={-1759.032,310.695,806.245},[71020]={421.778,269.679,2207.088},[71030]={-859.822,301.749,1954.213},[71040]={-1490.294,396.138,-792.581},[71050]={527.023,328.63,50},[71060]={782.651,463.722,-1027.08},[71070]={-675.085,533.228,-1482.026},[71080]={2080.718,456.726,-1927.582},[71090]={474.7,322.281,1062.864},[71200]={-594.489,-17.482,1095.318},[71300]={803.255,-11.806,1225.636},[71400]={278.127,42.996,-1232.378},[71500]={1518,145,-2115},[71600]={2522.474,100.128,-896.065},[71700]={2746.635,200.042,-2401.35},[80010]={-1396.746,286.758,1009.375},[80020]={482.031,286.844,2474.655},[80040]={-1839.279,358.371,-339.326},[80060]={1385.748,368,-23.469},[80080]={1408.371,500.486,-1300.667},[80100]={-454.016,3.955,977.738},[80200]={338.505,1.002,1746.528},[80400]={2566.009,68,-200.753},[80600]={1460.408,121.347,-1411.282},[80700]={2702.945,127.026,-1972.265},[99012]={-1335.904,398.264,-739.165},[99020]={-716.5531,536.7278,-1485.517},[99030]={-2199.997,456.352,-1581.944},[99040]={-1762.503,310.288,802.482},[99070]={-2127.887,436.594,-1564.366},[99071]={-648.583,-18.483,1032.586},[99072]={-1761.536,310.333,806.76},[99080]={530.911,335.119,29.67}},
		areaUndefined={99011,99050},--unused
		areaFailsafe={125,125,125,125,200,200,200,200,200,200}--used if player hits checkpoint inside of quest area; indice=TppQuest quest radius, value=radius in meters; still need to set up proper with quest radius; uses indice 4 by default
	},
	phase={sneak=G.gameObj_tpp.PHASE_SNEAK,caution=G.gameObj_tpp.PHASE_CAUTION,evade=G.gameObj_tpp.PHASE_EVASION,alert=G.gameObj_tpp.PHASE_ALERT},
	eqp={
		cbox={
			all={G.eqp.EQP_IT_CBox_WR,G.eqp.EQP_IT_CBox_SMK,G.eqp.EQP_IT_CBox_DSR,G.eqp.EQP_IT_CBox_DSR_G01,G.eqp.EQP_IT_CBox_DSR_G02,G.eqp.EQP_IT_CBox_FRST,G.eqp.EQP_IT_CBox_FRST_G01,G.eqp.EQP_IT_CBox_BOLE,G.eqp.EQP_IT_CBox_BOLE_G01,G.eqp.EQP_IT_CBox_CITY,G.eqp.EQP_IT_CBox_CITY_G01,G.eqp.EQP_IT_CBox_CLB_A,G.eqp.EQP_IT_CBox_CLB_A_G01,G.eqp.EQP_IT_CBox_CLB_B,G.eqp.EQP_IT_CBox_CLB_B_G01,G.eqp.EQP_IT_CBox_CLB_C,G.eqp.EQP_IT_CBox_CLB_C_G01},
			subtype={
				camo={
					desert={G.eqp.EQP_IT_CBox_DSR,G.eqp.EQP_IT_CBox_DSR_G01,G.eqp.EQP_IT_CBox_DSR_G02},
					green={G.eqp.EQP_IT_CBox_FRST,G.eqp.EQP_IT_CBox_FRST_G01},
					mix={G.eqp.EQP_IT_CBox_CLB_A,G.eqp.EQP_IT_CBox_CLB_A_G01},
					red={G.eqp.EQP_IT_CBox_BOLE,G.eqp.EQP_IT_CBox_BOLE_G01},
					urban={G.eqp.EQP_IT_CBox_CITY,G.eqp.EQP_IT_CBox_CITY_G01},
					rock={G.eqp.EQP_IT_CBox_CLB_B,G.eqp.EQP_IT_CBox_CLB_B_G01},
					wet={G.eqp.EQP_IT_CBox_CLB_C,G.eqp.EQP_IT_CBox_CLB_C_G01}
				},
				ability={G.eqp.EQP_IT_CBox_WR,G.eqp.EQP_IT_CBox_SMK}
			}
		},
		sCamo={
			all={G.eqp.EQP_IT_InstantStealth,G.eqp.EQP_IT_Stealth,G.eqp.EQP_IT_ParasiteCamouf},
			subtype={
				limited={G.eqp.EQP_IT_InstantStealth},
				battery={G.eqp.EQP_IT_Stealth},
				parasiteStealth={G.eqp.EQP_IT_ParasiteCamouf}
			}
		}
	},
	eneBase={--unused
		afgh={'bridge','enemyBase','field','fort','tent','cliffTown','commFacility','powerPlant','remmnants','slopedTown','sovietBase','village'},
		mafr={'banana','diamond','lab','flowStation','hill','outland','pfCamp','savannah','swamp'},
		mtbs={'Command','Combat','Develop','Support','Medical','Spy','BaseDev'}
	},
	vehicle={
		west4WD=G.vehType.WESTERN_LIGHT_VEHICLE,east4WD=G.vehType.EASTERN_LIGHT_VEHICLE,westTruck=G.vehType.WESTERN_TRUCK,eastTruck=G.vehType.EASTERN_TRUCK,westIFV=G.vehType.WESTERN_WHEELED_ARMORED_VEHICLE,eastIFV=G.vehType.EASTERN_WHEELED_ARMORED_VEHICLE,westMBT=G.vehType.WESTERN_TRACKED_TANK,eastMBT=G.vehType.EASTERN_TRACKED_TANK,
		category={lowInvalid=(G.vehType.WESTERN_LIGHT_VEHICLE-1),low4WD=G.vehType.WESTERN_LIGHT_VEHICLE,high4WD=G.vehType.EASTERN_LIGHT_VEHICLE,lowTruck=G.vehType.WESTERN_TRUCK,highTruck=G.vehType.EASTERN_TRUCK,lowIFV=G.vehType.WESTERN_WHEELED_ARMORED_VEHICLE,highIFV=G.vehType.EASTERN_WHEELED_ARMORED_VEHICLE,lowMBT=G.vehType.WESTERN_TRACKED_TANK,highMBT=G.vehType.EASTERN_TRACKED_TANK,highInvalid=(G.vehType.EASTERN_TRACKED_TANK+1)}
	},
	flags={
		item={
			null_low=0,
			stealth_minIndex=10,limited=10,battery=11,parasiteStealth=12,stealth_maxIndex=12,
			null_high=20
		},
		state={disabled=0,enabled=1,setEnable=2,setDisable=3,increaseDuration=4},
		itemParams={
			limited={30,40,50},--more like 25,35,50; stopwatch may have been off.
			battery={180},
			parasiteStealth={30,60,90}--actually refers to suit
		}
	}
}

e.InitCamoufTable={{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,50,0,50,50,50,50,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,50,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,50,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{50,50,0,0,50,50,50,50,50,50,50,50,50,0,50,50,50,50,50,0,0,0,0,0,0,50,0,50,50,0,0,0,50,50,0,0,0,0,0,50,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,50,0,0,50,50,50,50,50,50,50,0,50,0,0,0,50,50,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}}
--tex the camo index overhaul mod exposes the player2_camouf_param camo table for use (and others should follow this method)
if player2_camouf_param and player2_camouf_param.camoTable then
  e.InitCamoufTable=player2_camouf_param.camoTable
end

e.index={
	sight={
		camo={ghost=2e3,friendly=1e3,discovery=840,indis=390,dim=260,far=0},
		distance={--unused
			day={contact=2,discovery=10,indis=20,dim=45,far=70,observe=200},
			night={contact=2,discovery=10,indis=15,dim=35,far=false,observe=false},
			proneStealth=true
		}
	},
	points={
		speed={idle=0,evade=0,walk=-10,crawl=-20,jog=-30,dash=-60},
		stance={prone=50,crouch=10,stand=0,fall=0,trash=0},
		material={bush=100,surface=50,cover=10,none=0},
		item={stealthCamo=1e3,parasiteCamo=2e3},
		weather={fog=1.5,sandstorm=1.4,normal=1},
		time={day=0,night=0.5},
		light={night=10,shadow=10,ambient=-20,flare=-40,searchlight=-60},--need to figure out how to actually check these; maybe TppDamage checks?
		gun={suppressor=0,flash=-60},
		special={
			proneStealthDay=true,
			proneStealthNight=true
		}
	}
}
t={disco=840,seeDayFar=70,seeNightDim=35,seeProneStealth=8}--##CHANGE

e.index.sight.distance.proneStealth=t.seeProneStealth
e.index.points.special={
	proneStealthDay=(t.disco*(t.seeProneStealth/t.seeDayFar)),
	proneStealthNight=(t.disco*(t.seeProneStealth/t.seeNightDim))
}

t=nil

function e:resetLocalVarTable()
	e.var={
		flashed=false,
		ride=self.ride,
		guardPhase=self.guardPhase,
		stealthCamo=self.stealthCamo,
		cboxCamo=self.cboxCamo,
		mission=self.mission,
		quest=self.quest,
		location=self.location,
		time=self.time,
		weather=self.weather,
		player=self.player,
		exception={playerVehicleImpact=false,brokeSpecialStance=false,itemCancel=false,playerLeftQuestArea=self.exception.playerLeftQuestArea},
		keepTime=self.keepTime,
		keyLog={},
		special=self.special,
		icon=self.icon,
		flags=self.flags
	}

	if not self.keyLog.moveAction then
		e.var.keyLog={action=self.keyLog.action,stance=self.keyLog.stance}
	end
end

function e.playerPressed(button)
	local PlayerPad=PlayerPad
	return (bit.band(PlayerVars.scannedButtonsDirect,PlayerPad[button])==PlayerPad[button])
end

function e.playerStatus(status)
	return F.playerInfoAnd{PlayerStatus[status]}
end

if not e.var then 
	e.var={
		flashed=false,
		ride=false,
		guardPhase=0,--stealth
		stealthCamo=false,
		cboxCamo=false,
		mission=1,--game init screen
		quest=false,
		location=1,--INIT
		time='day',
		weather=0,--sunny
		player={},
		exception={playerVehicleImpact=false,brokeSpecialStance=false,itemCancel=false,playerLeftQuestArea=true},
		keepTime={limited=false,battery=false,parasiteStealth=false},
		keyLog={},
		special={truck=false,proneStealth=false},
		icon={proneStealth=false},
		flags={state={limited=0,battery=0,parasiteStealth=0}}
	}
end

e.debug={}
e.debugTable={
	playerStatus={
		'STAND',--standing; false if HORSE_STAND; true when ON_VEHICLE
		'SQUAT',--crouching or doing cbox slide
		'CRAWL',--prone or when CBOX_EVADE
		'NORMAL_ACTION',--true for most generic on-foot movement-related actions including STOP; false when ON_VEHICLE or ON_HORSE or CBOX
		'PARALLEL_MOVE',--aiming
		'IDLE',
		'GUN_FIRE',--true even with suppressor; GUN_FIRE and GUN_FIRE_SUPPRESSOR not true with player vehicle weapons
		'GUN_FIRE_SUPPRESSOR',--true when discharge with suppressor; GUN_FIRE also true when this
		'STOP',--when idle on foot or cbox; true when CBOX_EVADE; always true if ON_VEHICLE; 
		'WALK',--slow speed
		'RUN',--default speed
		'DASH',--fast speed
		'ON_HORSE',--piloting D-Horse
		'ON_VEHICLE',--piloting vehicle
		'ON_HELICOPTER',--riding helicopter
		'HORSE_STAND',--
		'HORSE_HIDE_R',--hiding on right side of horse
		'HORSE_HIDE_L',--hiding on left side of horse
		'HORSE_IDLE',--HORSE_[speed] also used for D-Walker
		'HORSE_TROT',--slow speed
		'HORSE_CANTER',--default speed
		'HORSE_GALLOP',--fast speed
		'BINOCLE',--using int-scope
		'SUBJECT',--first-person camera
		'INTRUDE',
		'LFET_STOCK',
		'CUTIN',--placing guard in something (probably dev typo for PUT_IN)
		'DEAD',
		'DEAD_FRESH',
		'NEAR_DEATH',
		'NEAR_DEAD',
		'FALL',
		'CBOX',--true while in cbox and not sliding and not CBOX_EVADE
		'CBOX_EVADE',--crawling out of cbox; CBOX false if true
		'TRASH_BOX',
		'TRASH_BOX_HALF_OPEN',
		'INJURY_LOWER',
		'INJURY_UPPER',
		'CURE',
		'CQC_CONTINUOUS',
		'BEHIND',--pressed against cover/wall
		'ENABLE_TARGET_MARKER_CHECK',
		'UNCONSCIOUS',
		'PARTS_ACTIVE',--seems to always be true when deployed or in ACC
		'CARRY',
		'CURTAIN',
		'VOLGIN_CHASE'
	},
	buttons={
		'DECIDE',
		'STANCE',
		'DASH',
		'HOLD',
		'FIRE',
		'RIDE_ON',
		'RIDE_OFF',
		'ACTION',
		'MOVE_ACTION',
		'JUMP',
		'RELOAD',
		'STOCK',
		'ZOOM_CHANGE',
		'VEHICLE_CHANGE_SIGHT',
		'MB_DEVICE',
		'CALL',
		'INTERROGATE',
		'SUBJECT',
		'UP',
		'PRIMARY_WEAPON',
		'DOWN',
		'SECONDARY_WEAPON',
		'LEFT',
		'RIGHT',
		'VEHICLE_LIGHT_SWITCH',
		'VEHICLE_TOGGLE_WEAPON',
		'CQC',
		'SIDE_ROLL',
		'LIGHT_SWITCH',
		'EVADE',
		'VEHICLE_FIRE',
		'VEHICLE_CALL',
		'VEHICLE_DASH',
		'BUTTON_PLACE_MARKER',
		'PLACE_MARKER',
		'ESCAPE'
	}
}

function e.debug:buttonsOrStatus(check)
	if not self or not check then return end
	local t={}
	check=((check=='buttons' and e.playerPressed) or (check=='status' and e.playerStatus) or false)
	if not check then return end
	for i=1,#self do
		t[self[i]]=check(self[i])
	end
	self,check=nil
	local tostring=tostring
	local e=F.echo
	for k,v in pairs(t) do
		if v then
			e(k..'='..tostring(v))
		end
	end
	return
end

function e.debug:updateVars()
	if not self or #self<2 then return end
	for i=1,(#self-1) do
		F.echo(self[i])
	end
end

function e.debug:multiEcho()
	local a=F.echo
	local ts=tostring
	for i=1,#self do
		a(ts(self[i]))
	end
end

function e.debug.errMsg(func,msg)
	local e=F.echo
	if not func or not msg then e('ERROR|func:e.debug.errMsg(func,msg)|msg:no arguments');return end
	e('ERROR|func:'..func..'|msg:'..msg)
end

--###############Coroutines#############

function e.createRoutine(id,key)
	if id==e.define.eqp.sCamo.subtype.parasiteStealth then
		id=G.eqp.EQP_SUIT
	end
	local grade=F.userItemLevel(id) or 1

	if type(id)~='number'then
		e.debug.errMsg('e.createRoutine(id,key)','var id must be a number!')
	end

	id=nil

	e.var.keepTime[key]=coroutine.create(
		function(item,grade)
			local flags=e.define.flags
			local rawTime=F.gameElapsedTime
			local t=(rawTime()+(flags.itemParams[item][grade]))
			while true do
				--F.echo('in coroutine')
				if e.var.flags.state[item]==flags.state.increaseDuration then
					t=(t+(flags.itemParams[item][grade]))
					e.var.flags.state[item]=flags.state.enabled
				end
				if e.var.exception.itemCancel or (t-rawTime())<=0 then
					e.var.flags.state[item]=flags.state.setDisable
					e.changeState(item,e.var.flags.state[item])
					e.var.stealthCamo=false
					break
				end
				coroutine.yield()
			end
		end
	)

	coroutine.resume(e.var.keepTime[key],key,grade)
end

function e.changeState(key,flag)--battery,2
	local l={flagType=e.define.flags.state}
	local id=e.define.eqp.sCamo.subtype[key][1]

	if flag==l.flagType.setEnable then
		e.createRoutine(id,key)--e.define.eqp.sCamo.subtype.battery,battery
		e.var.flags.state[key]=l.flagType.enabled
	elseif flag==l.flagType.setDisable then
		if e.var.keepTime[key] then
			e.var.exception.itemCancel=true
			coroutine.resume(e.var.keepTime[key])
			e.var.exception.itemCancel=false
		end
		e.var.keepTime[key]=false
		e.var.flags.state[key]=l.flagType.disabled
	end
end

function e:checkFlags()--e.var.flags.state={battery=2}
	local pairs=pairs
	local flagType=e.define.flags.state
	for k,v in pairs(self) do
		if v==flagType.enabled then
			coroutine.resume(e.var.keepTime[k])
			if e.var.flags.state[k]==flagType.setDisable then
				e.changeState(k,e.var.flags.state[k])
			end
		elseif flagType.enabled<v and v<flagType.increaseDuration then
			e.changeState(k,v)--battery,2
		end
	end
end
--######################################

function e.getItemType(item)
	local def=e.define.eqp
	local t={false,false}

	local assignSubType=function(subTable)
		for k,_ in pairs(subTable) do
			for i=1,#subTable[k] do
				if (item==subTable[k][i]) then
					return k
				end
			end
		end
		return false
	end

	local checkMatch=function(itemTable,subTable,newType)
		for i=1,#itemTable do
			if item==itemTable[i] then
				t[1]=newType
				t[2]=assignSubType(subTable)
				return
			end
		end
		return
	end

	checkMatch(def.sCamo.all,def.sCamo.subtype,'stealth')
	if not t[1] then
		t={false,false}--for some reason second arg kept returning nil instead of false when doing multi one-liner conditional var assignment in single func; lazy workaround
		checkMatch(def.cbox.all,def.cbox.subtype.camo,'cbox')
	end
	if not t[1] then
		t={false,false}
	end
	return t[1],t[2]
end

function e.Messages()
	return G.tpp.StrCode32Table{--{msg='',func=e.On},	{msg='',func=function()F.echo('')end},
	    Player={
			{msg='PlayerDamaged',func=e.OnPlayerDamaged},--function(playerIndex,attackId,attackerId)
			{msg='OnPlayerMachineGun',func=function()e.var.ride='gimmickMG'end},
			{msg='OnPlayerSearchLight',func=function()e.var.ride='gimmickSearchlight'end},
			{msg='OnPlayerMortar',func=function()e.var.ride='gimmickMortar'end},
			{msg='OnPlayerGatling',func=function()e.var.ride='gimmickAA'end},
			{msg='OnVehicleDrive',func=e.OnVehicleDrive},
			{msg='OnPlayerPipeAction',func=function()e.var.ride='pipe'end},
			{msg='OnPlayerElude',func=function()e.var.ride='elude'end},
			{msg='OnPlayerToilet',func=function()e.var.ride='toilet'end},
			{msg='OnPlayerTrashBox',func=function()e.var.ride='trash'end},
			--{msg='IconCrawlStealthShown',func=e.OnCrawlStealthShown},
			{msg='IconFultonShown',func=e.IconFultonShown},
			{msg='OnEquipItem',func=e.OnEquipItem}
		},
		GameObject={
			{msg='Carried',func=e.OnCarried}--,
			--{msg='Damage',func=e.OnDamage},
			--{msg='Observed',func=e.OnObserved}
			--{msg='PointLight',func=e.OnPointLight}, --just grphx setting
		},
		UI={
			{msg='QuestAreaAnnounceLog',func=e.OnQuestAreaAnnounceLog}--,
			--{msg='QuestIconInDisplay',func=function()F.echo('QuestIconInDisplay')end},
			--{msg='QuestStarted',func=function()F.echo('QuestStarted')end}
		}--,
		--Trap={
		--	{msg='Enter',func=function()F.echo('enter trap')end}
		--}
  	}
end

function e.Init(missionTable)--arg0=missionTable
  e.messageExecTable=G.tpp.MakeMessageExecTable(e.Messages())
end

function e.OnReload(missionTable)--arg0=missionTable
  e.messageExecTable=G.tpp.MakeMessageExecTable(e.Messages())
end

function e.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  G.tpp.DoMessage(e.messageExecTable,G.mis.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
end

function e.OnPlayerDamaged(_,attackId)--arg0=playerIndex | arg2=attackerId
  	_={'limited','battery','parasiteStealth'}
	e.var.stealthCamo=false
	local t=e.var.keepTime

	for i=1,#_ do
		if t[_[i]] then
			e.var.flags.state[_[i]]=e.def.flags.setDisable
			e.checkFlags(e.var.flags.state)
		end
	end

	t=G.dmg
	t={light={[t.ATK_FlashLight]=true,[t.ATK_FlashLightAttack]=true}}

	e.var.flashed=(t.light[attackId] or false)
	t=nil
	e.var.ride=((e.playerStatus('ON_VEHICLE') and 'vehicle') or e.var.ride)
	e.var.exception.playerVehicleImpact=((e.var.ride and true) or false)
end

function e.OnVehicleDrive()
	e.var.ride=((e.playerStatus('ON_VEHICLE') and 'vehicle') or e.var.ride)
end

function e.OnCarried(gameObjectId,carriedState)--arg1=0 based flag to 2
	local l={obj=G.gameObj_tpp,ene=G.ene}
	local t={true,false,true}
	e.var.ride=((((G.gameObj_v.GetTypeIndex(gameObjectId)==l.obj.GAME_OBJECT_TYPE_SOLDIER2) and t[carriedState+1]) and (l.ene.GetLifeStatus(gameObjectId)~=l.ene.LIFE_STATUS.DEAD) and 'carry') or false)
end

function e.OnObserved()
	F.echo('observed')
end
function e.OnPointLight()
	F.echo('light pointed')
end
function e.OnCrawlStealthShown()
	e.var.icon.proneStealth=true
end

function e.IconFultonShown()
	local r=e.var.ride
	if not r then return end
	local t={cbox=true,carry=true}
	if t[r] then
		return
	end
	e.var.ride=false
end

--[[
	cboxIsValid
	cboxLife
	cboxFlag
	cboxPosterType
	cboxEquipId
	cboxLocation
]]

function e.OnEquipItem()--nET
	local l={elapsedTime=F.gameElapsedTime(),flags=e.define.flags.state}
	local t
	if (vars.items[vars.currentItemIndex])<=0 then
		e.var.ride=false
		e.var.cboxCamo=false
	end
	local eqpType,eqpSubtype=e.getItemType(vars.items[vars.currentItemIndex])
	--e.debug.multiEcho({'eqpType',eqpType,'eqpSubtype',eqpSubtype})
	local key
	--[[local slot={
		[0]=0,--right
		[1]=486,--left
		[2]=464,--up
		[3]=472,--down
		[4]=450,
		[5]=451,
		[6]=470,--upRight
		[7]=469--downRight
	}]]

	if e.var.stealthCamo then--previous item was stealth type
		if e.var.stealthCamo~='parasiteStealth' then--only parasite stealth can be used with other items
			t={'limited','battery'}
			for i=1,#t do
				if e.var.keepTime[t[i]] then
					e.var.flags.state[t[i]]=l.flags.setDisable
				end
			end
			t=nil
			e.var.stealthCamo=false
		elseif eqpSubtype=='parasiteStealth' then
			key=eqpSubtype
			e.var.flags.state[key]=((e.var.keepTime[key] and l.flags.increaseDuration)or l.flags.setEnable)
			if e.var.flags.state[key]==l.flags.increaseDuration then
				coroutine.resume(e.var.keepTime[key])
			end
			key=nil
		else
			t={'limited','battery'}
			for i=1,#t do
				if eqpSubtype==t[i] then
					e.var.flags.state.parasiteStealth=l.flags.setDisable
				end
			end
			t=nil
		end
		e.checkFlags(e.var.flags.state)
		return
	elseif eqpType=='stealth' then
		e.var.stealthCamo=eqpSubtype
		key=eqpSubtype
		e.var.flags.state[key]=((e.var.keepTime[key] and l.flags.increaseDuration)or l.flags.setEnable)
		if e.var.flags.state[key]==l.flags.increaseDuration then
			coroutine.resume(e.var.keepTime[key])
		end
		e.checkFlags(e.var.flags.state)
		return
	end

	l=nil

	if eqpType=='cbox' then
		e.var.ride=eqpType
		e.var.cboxCamo=eqpSubtype
		return
	elseif e.var.ride=='cbox' then
		e.var.ride=false
		e.var.cboxCamo=false
	end
end

--function e.OnDamage(gameId,attackId,attackerId)
--end

function e.OnQuestAreaAnnounceLog(questCode)
	local l={vars=vars}
	local m={ceil=ceil,floor=floor,sqrt=sqrt}
	--F.echo('questCode: '..tostring(questCode))
	if not questCode then e.var.quest=false return end

	local playerPos={l.vars.playerPosX,l.vars.playerPosY,l.vars.playerPosZ}
	l=nil
	local questPos=e.define.quest.areaRestriction[questCode] or false
  	questCode=nil

	if not questPos then e.var.quest=false return end

	local x,y,z=(playerPos[1]-questPos[1]),(playerPos[2]-questPos[2]),(playerPos[3]-questPos[3])
	local distance=m.sqrt((x*x)+(y*y)+(z*z))
	x,y,z=nil
	distance=((m.floor(distance*1e3))*1e-3)--reduce decimal to thousandths
	distance=((50<distance and (m.ceil(distance/25)*25)) or e.define.areaFailsafe[4])
  	m=nil
	e.var.quest={area={questPos[1],questPos[2],questPos[3]},len=distance}
end

--[[
	e.camoParam={}

	e.camoParam.material={
	IRON_A=1,IRON_B=2,IRON_C=3,IRON_D=4,IRON_E=5,IRON_F=6,IRON_G=7,IRON_M=8,IRON_N=9,IRON_W=10,--iron
	PIPE_A=11,PIPE_B=12,PIPE_S=13,--pipe
	TIN_A=14,--tin
	FENC_A=15,FENC_B=16,FENC_F=17,--fence
	CONC_A=18,CONC_B=19,--concrete
	BRIC_A=20,--brick
	PLAS_A=21,PLAS_B=22,PLAS_W=23,--plastic
	PAPE_A=24,PAPE_B=25,PAPE_C=26,PAPE_D=27,--paper
	RUBB_A=28,RUBB_B=29,--rubber
	CLOT_A=30,CLOT_B=31,CLOT_C=32,CLOT_D=33,CLOT_E=34,--cloth
	GLAS_A=35,GLAS_B=36,GLAS_C=37,--glass
	VINL_A=38,VINL_W=39,--vinyl
	TILE_A=40,--tile
	TLRF_A=41,--tile_roof
	ALRM_A=42,--alarm_lamp
	COPS_A=43,COPS_B=44,--corpse
	BRIR_A=45,--bridge
	BLOD_A=46,--blood
	SOIL_A=47,SOIL_B=48,SOIL_C=49,SOIL_D=50,SOIL_E=51,SOIL_F=52,SOIL_G=53,SOIL_H=54,SOIL_R=55,SOIL_W=56,--soil
	GRAV_A=57,--gravel
	SAND_A=58,SAND_B=59,SAND_C=60,--sand
	LEAF=61,--leaf
	RLEF=62,RLEF_B=63,--? maybe r_leaf
	WOOD_A=64,WOOD_B=65,WOOD_C=66,WOOD_D=67,WOOD_G=68,WOOD_M=69,WOOD_W=70,--wood
	FWOD_A=71,--? maybe forest_wood
	PLNT_A=72,--plant
	ROCK_A=73,ROCK_B=74,ROCK_P=75,--rock
	MOSS_A=76,--moss
	TURF_A=77,--turf (africa grass ground texture)
	WATE_A=78,WATE_B=79,WATE_C=80,--water
	AIR_A=81,--air
	NONE_A=82--none
	}
	e.camoParam.tableOrder={'Olive_Drab','Splitter','Squares','Tiger_Stripe','Golden_Tiger','Desert_Fox','Woodland','Wetwork','Urban_Gray','Urban_Blue','APD','unk1','unk2','Black_Ocelot','SV_Sneaking_Suit','Sneaking_Suit','Battle_Dress','Parasite_Suit','unk3','Leather_Jacket','Solid_Snake','Grey_Fox','Raiden','Sneaking_Suit_TB_standard','Naked_Gold','Naked_Silver','Animals','unk4','Fatigues_NS_standard','Fatigues_NS_naked','unk5','Tuxedo','EVA_Jumpsuit_standard','EVA_Jumpsuit_naked','unk6','Sneaking_Suit_TB_naked','Woodland_Fleck','Ambush','Solum','Deadleaf','Lichen','Stone','Parasite_Mist','Old_Rose','Brick_Red','Iron_Blue','Steel_Gray','Tselinoyarsk','Night_Splitter','Rain','Green_Tiger','Birch_Leaf','Desert_Ambush','Dark_Leaf_Fleck','Night_Bush','Grass','Ripple','Citrullus','Digital_Bush','Zebra','Desert_Sand','Steel_Khaki','Dark_Rubber','Gray','Camouflage_Yellow','Camouflage_Green','Iron_Green','Light_Rubber','Red_Rust','Steel_Green','Steel_Orange','Mud','Steel_Blue','Dark_Rust','Citrullus_2T','Gold_Tiger_2T','Birch_Leaf_2T','Stone_2T','Khaki_Urban_2T','Swimsuit_Olive_Drab','Swimsuit_Tiger_Stripe','Swimsuit_Golden_Tiger','Swimsuit_Desert_Fox','Swimsuit_Wetwork','Swimsuit_Splitter','Swimsuit_Parasite_Mist','Swimsuit_Old_Rose','Swimsuit_Camouflage_Green','Swimsuit_Iron_Blue','Swimsuit_Red_Rust','Swimsuit_Mud'}
]]

function e.checkInitCamoufTable(tablePos)
	local t=e.InitCamoufTable[tablePos]
	tablePos=nil
	local n={'desert','green','red','rock','urban','wet'}
	local m,s={},{}

	for i=1,#n do
		s[n[i]]=0
		m[n[i]]={true,true,true,true,true,true}
	end

	m={
		urban={1,2,5,6,7,8,9,10,11,12,13,15,16,17,18,19,26,28,29,33,34,40},
		green={61,64,65,66,67,68,69,70,72,76,77},
		desert={47,48,55,57,58,59,60},
		wet={49,50,51,54,79},
		red={53},
		rock={56,73,74}
	}

	local getCamoTableValues=function(InitCamoufTableIndex,returnedTable,materialTable,materialName)
		local p=0
		local m=materialTable[materialName]
		materialTable=nil
		local t=InitCamoufTableIndex
		InitCamoufTableIndex=nil
		for i=1,#m do
			if t[m[i]]~=p then
				if p<t[m[i]] then
					p=t[m[i]]
				end
			end
		end
		returnedTable[materialName]=p
		m,p,materialName=nil
		return returnedTable
	end

	for i=1,#n do
		s=getCamoTableValues(t,s,m,n[i])
	end
	t,m,n=nil
	return s
end

e.cloth={
	none=G.userCamo.NONE,
	green={
		G.userCamo.OLIVEDRAB,e.checkInitCamoufTable(1),
		G.userCamo.WOODLAND,e.checkInitCamoufTable(7),
		G.userCamo.C23,e.checkInitCamoufTable(37),
		G.userCamo.C24,e.checkInitCamoufTable(38),
		G.userCamo.C29,e.checkInitCamoufTable(40),
		G.userCamo.C30,e.checkInitCamoufTable(41),
		G.userCamo.C16,e.checkInitCamoufTable(49),
		G.userCamo.C19,e.checkInitCamoufTable(52),
		G.userCamo.C20,e.checkInitCamoufTable(53),
		G.userCamo.C22,e.checkInitCamoufTable(54),
		G.userCamo.C26,e.checkInitCamoufTable(56),
		G.userCamo.C28,e.checkInitCamoufTable(57),
		G.userCamo.C31,e.checkInitCamoufTable(58),
		G.userCamo.C56,e.checkInitCamoufTable(75),
		G.userCamo.C57,e.checkInitCamoufTable(76),
		G.userCamo.C58,e.checkInitCamoufTable(77),
		G.userCamo.C59,e.checkInitCamoufTable(78),
		G.userCamo.C60,e.checkInitCamoufTable(79)
	},
	desert={G.userCamo.FOXTROT,e.checkInitCamoufTable(6)},
	mix={
		G.userCamo.PANTHER,e.checkInitCamoufTable(27),
		G.userCamo.SANDSTORM,e.checkInitCamoufTable(11),
		G.userCamo.MGS3,e.checkInitCamoufTable(29),
		G.userCamo.MGS3_NAKED,e.checkInitCamoufTable(30),
		G.userCamo.EVA_CLOSE,e.checkInitCamoufTable(33),
		G.userCamo.EVA_OPEN,e.checkInitCamoufTable(34)
	},
	red={G.userCamo.GOLDTIGER,e.checkInitCamoufTable(5)},
	wet={
		G.userCamo.WETWORK,e.checkInitCamoufTable(8),
		G.userCamo.ARBANBLUE,e.checkInitCamoufTable(10),
		G.userCamo.C27,e.checkInitCamoufTable(39),
		G.userCamo.C17,e.checkInitCamoufTable(50),
		G.userCamo.C32,e.checkInitCamoufTable(59)
	},
	rock={
		G.userCamo.TIGERSTRIPE,e.checkInitCamoufTable(4),
		G.userCamo.C35,e.checkInitCamoufTable(42),
		G.userCamo.C18,e.checkInitCamoufTable(51),
		G.userCamo.C25,e.checkInitCamoufTable(55),
		G.userCamo.C33,e.checkInitCamoufTable(60)
	},
	urban={
		G.userCamo.SQUARE,e.checkInitCamoufTable(3),
		G.userCamo.ARBANGRAY,e.checkInitCamoufTable(9),
		G.userCamo.C38,e.checkInitCamoufTable(43),
		G.userCamo.C39,e.checkInitCamoufTable(44),
		G.userCamo.C42,e.checkInitCamoufTable(45),
		G.userCamo.C46,e.checkInitCamoufTable(46),
		G.userCamo.C49,e.checkInitCamoufTable(47),
		G.userCamo.C52,e.checkInitCamoufTable(48),
		G.userCamo.C36,e.checkInitCamoufTable(61),
		G.userCamo.C37,e.checkInitCamoufTable(62),
		G.userCamo.C40,e.checkInitCamoufTable(63),
		G.userCamo.C41,e.checkInitCamoufTable(64),--issues
		G.userCamo.C43,e.checkInitCamoufTable(65),
		G.userCamo.C44,e.checkInitCamoufTable(66),
		G.userCamo.C45,e.checkInitCamoufTable(67),
		G.userCamo.C47,e.checkInitCamoufTable(68),
		G.userCamo.C48,e.checkInitCamoufTable(69),
		G.userCamo.C50,e.checkInitCamoufTable(70),
		G.userCamo.C51,e.checkInitCamoufTable(71),
		G.userCamo.C53,e.checkInitCamoufTable(72),
		G.userCamo.C54,e.checkInitCamoufTable(73),
		G.userCamo.C55,e.checkInitCamoufTable(74)
	},
	vehicle={G.userCamo.SPLITTER,e.checkInitCamoufTable(2)},
	night={G.userCamo.BLACK,e.checkInitCamoufTable(14)},
	sneak={
		G.userCamo.SNEAKING_SUIT_GZ,e.checkInitCamoufTable(15),
		G.userCamo.SNEAKING_SUIT_TPP,e.checkInitCamoufTable(16),
		G.userCamo.SOLIDSNAKE,e.checkInitCamoufTable(21),
		G.userCamo.BOSS_CLOSE,e.checkInitCamoufTable(24),
		G.userCamo.MGS3_SNEAKING,e.checkInitCamoufTable(31),
		G.userCamo.BOSS_OPEN,e.checkInitCamoufTable(36)
	},
	ability={
		G.userCamo.BATTLEDRESS,e.checkInitCamoufTable(17),
		G.userCamo.PARASITE,e.checkInitCamoufTable(18),
		G.userCamo.NINJA,e.checkInitCamoufTable(22),
		G.userCamo.RAIDEN,e.checkInitCamoufTable(23)
	},
	casual={
		G.userCamo.LEATHER,e.checkInitCamoufTable(20),
		G.userCamo.GOLD,e.checkInitCamoufTable(25),
		G.userCamo.SILVER,e.checkInitCamoufTable(26),
		G.userCamo.MGS3_TUXEDO,e.checkInitCamoufTable(32)
	},
	swimwear={
		G.userCamo.SWIMWEAR_C00,e.checkInitCamoufTable(80),
		G.userCamo.SWIMWEAR_C01,e.checkInitCamoufTable(81),
		G.userCamo.SWIMWEAR_C02,e.checkInitCamoufTable(82),
		G.userCamo.SWIMWEAR_C03,e.checkInitCamoufTable(83),
		G.userCamo.SWIMWEAR_C05,e.checkInitCamoufTable(84),
		G.userCamo.SWIMWEAR_C06,e.checkInitCamoufTable(85),
		G.userCamo.SWIMWEAR_C38,e.checkInitCamoufTable(86),
		G.userCamo.SWIMWEAR_C39,e.checkInitCamoufTable(87),
		G.userCamo.SWIMWEAR_C44,e.checkInitCamoufTable(88),
		G.userCamo.SWIMWEAR_C46,e.checkInitCamoufTable(89),
		G.userCamo.SWIMWEAR_C48,e.checkInitCamoufTable(90),
		G.userCamo.SWIMWEAR_C53,e.checkInitCamoufTable(91)
	},
	unused={
		G.userCamo.REALTREE,e.checkInitCamoufTable(12),
		G.userCamo.INVISIBLE,e.checkInitCamoufTable(13),
		G.userCamo.NAKED,e.checkInitCamoufTable(19),
		G.userCamo.HOSPITAL,e.checkInitCamoufTable(24),
		G.userCamo.AVATAR_EDIT_MAN,e.checkInitCamoufTable(28),
		G.userCamo.NONE,e.checkInitCamoufTable(35)
	}
}
e.parts={
	--fatigue
		--[0]=e.checkInitCamoufTable(tablePos),--PlayerPartsType.NORMAL
		--[1]=e.checkInitCamoufTable(tablePos),--PlayerPartsType.NORMAL_SCARF
		--[7]=e.checkInitCamoufTable(tablePos),--PlayerPartsType.NAKED
		[19]=e.checkInitCamoufTable(33),--PlayerPartsType.EVA_CLOSE
		[20]=e.checkInitCamoufTable(34),--PlayerPartsType.EVA_OPEN
	--misc
		[3]=e.checkInitCamoufTable(24),--PlayerPartsType.HOSPITAL
		[14]=e.checkInitCamoufTable(28),--PlayerPartsType.AVATAR_EDIT_MAN
	--sneak
		[2]=e.checkInitCamoufTable(15),--PlayerPartsType.SNEAKING_SUIT,PlayerCamoType.SNEAKING_SUIT_GZ
		[4]=e.checkInitCamoufTable(21),-- PlayerCamoType.SOLIDSNAKE; PlayerPartsType.MGS1; don't know real type name
		[8]=e.checkInitCamoufTable(16),--PlayerPartsType.SNEAKING_SUIT_TPP
		[17]=e.checkInitCamoufTable(31),--PlayerPartsType.MGS3_SNEAKING
		[21]=e.checkInitCamoufTable(24),--PlayerPartsType.BOSS_CLOSE
		[22]=e.checkInitCamoufTable(36),--PlayerPartsType.BOSS_OPEN
	--ability
		[5]=e.checkInitCamoufTable(22),--PlayerPartsType.NINJA
		[6]=e.checkInitCamoufTable(23),--PlayerPartsType.RAIDEN
		[9]=e.checkInitCamoufTable(17),--PlayerPartsType.BATTLEDRESS
		[10]=e.checkInitCamoufTable(18),--PlayerPartsType.PARASITE
		--[23]=e.checkInitCamoufTable(tablePos),--PlayerPartsType.SWIMWEAR
	--casual
		[11]=e.checkInitCamoufTable(20),--PlayerPartsType.LEATHER
		[12]=e.checkInitCamoufTable(25),--PlayerPartsType.GOLD
		[13]=e.checkInitCamoufTable(26),--PlayerPartsType.SILVER
		[18]=e.checkInitCamoufTable(32)--PlayerPartsType.MGS3_TUXEDO
}

--[[
	PlayerType
	DD_MALE
	DD_FEMALE
	LIQUID
	AVATAR

	PlayerCamoType
	OLIVEDRAB
	SPLITTER
	TIGERSTRIPE
	GOLDTIGER
	FOXTROT
	WOODLAND
	WETWORK
	ARBANGRAY
	ARBANBLUE
	REALTREE
	INVISIBLE
	SNEAKING_SUIT_GZ
	SNEAKING_SUIT_TPP
	BATTLEDRESS
	PARASITE
	NAKED
	LEATHER
	SOLIDSNAKE
	NINJA
	RAIDEN
	GOLD
	SILVER
	PANTHER
	AVATAR_EDIT_MAN
	MGS3
	MGS3_NAKED
	MGS3_SNEAKING
	MGS3_TUXEDO
	EVA_CLOSE
	EVA_OPEN
	BOSS_CLOSE
	BOSS_OPEN
	C23
	C24
	C27
	C29
	C30
	C35
	C38
	C39
	C42
	C46
	C49
	C52
	C16
	C17
	C18
	C19
	C20
	C22
	C25
	C26
	C28
	C31
	C32
	C33
	C36
	C37
	C40
	C41
	C43
	C44
	C45
	C47
	C48
	C50
	C51
	C53
	C54
	C55
	C56
	C57
	C58
	C59
	C60
	SWIMWEAR_C00
	SWIMWEAR_C01
	SWIMWEAR_C02
	SWIMWEAR_C03
	SWIMWEAR_C05
	SWIMWEAR_C06
	SWIMWEAR_C38
	SWIMWEAR_C39
	SWIMWEAR_C44
	SWIMWEAR_C46
	SWIMWEAR_C48
	SWIMWEAR_C53

	PlayerPartsType
	NORMAL_SCARF
	SNEAKING_SUIT
	MGS1
	SWIMWEAR

	PlayerHandType
	STUN_ARM
	JEHUTY
	STUN_ROCKET
	KILL_ROCKET

	PlayerSlotType
	PRIMARY_1
	PRIMARY_2
	SECONDARY
	ITEM
	STOLE
	HAND

	AmmoStockIndex
	PRIMARY_1_SUB
	PRIMARY_2_SUB
	ARM
	SUPPORT_END
	ITEM_END
	INDEX_COUNT

	PlayerConstants
	WEAPON_COUNT
	SUPPORT_WEAPON_COUNT
	ITEM_COUNT

	PlayerCanPlayDemoFlag
	DONOT_REMOVE_CBOX

	PlayerMissionPrepareAction
	READY
	LOOK_QUIET

	PlayerVars
	leftStickX
	leftStickY
	rightStickX
	rightStickY
	leftStickXDirect
	leftStickYDirect
	rightStickXDirect
	rightStickYDirect
	scannedButtons
	scannedButtonsDirect
	cameraZoomRate
	distanceForSeCallOfPassingObjects
	distanceForSeCallOfPassingObjectsOnHorse
]]

function e.checkItem(phase)
	--###|DEBUG|###
	--[==[
		do
			local f=e.var.flags.state
			local k=e.var.keepTime
			local d={
				varSCamo={'e.var.stealthCamo',e.var.stealthCamo},
				state='e.var.flags.state',
				flagLimited={'limited',f.limited},
				flagBattery={'battery',f.battery},
				flagParasite={'parasite',f.parasiteStealth},
				keepTime='e.var.keepTime',
				timeLimited={'limited',k.limited},
				timeBattery={'battery',k.battery},
				timeParasite={'parasite',k.parasiteStealth}
			}
			local s
			f=e.define.flags.state
			k={'varSCamo','state','flagLimited','flagBattery','flagParasite','keepTime','timeLimited','timeBattery','timeParasite'}
			for i=1,#k do
				s=d[k[i]]
				if type(s)=='string'then
					F.echo(s)
				else
					F.echo(s[1]..'|'..tostring(s[2]))
				end
			end
		end
	--]==]
	--###|\DEBUG|###

	local l={flag=e.define.flags.state,bonus=e.index.points.item}
	local n=0

	local k=e.var.stealthCamo or false
	if not k then return n end

	if phase==e.define.phase.alert then
		e.var.flags.state[k]=l.flag.setDisable
		e.checkFlags(e.var.flags.state)
		return n
	end

	if e.var.keepTime[k] then
		coroutine.resume(e.var.keepTime[k])
		if (l.flag.disabled<e.var.flags.state[k]) then
			n=((k=='parasiteStealth'and l.bonus.parasiteCamo)or l.bonus.stealthCamo)
		end
	end
	return n or 0
end

function e.checkCamouflage(camo)
	local t=e.cloth
	local s={'green','desert','mix','red','wet','rock','urban','sneak','ability','casual','swimwear','vehicle','night','unused'}
	for i=1,#s do
		for I=1,#t[s[i]],2 do
			if camo==(t[s[i]][I]) then
				return (t[s[i]][I+1]),s[i]
			end
		end
	end
	return false,false
end

function e.checkParts(part)
	if part<2 or part==7 or 22<part then
		return e.checkCamouflage(vars.playerCamoType)
	end

	if 0<part%2 then
		for i=3,21,2 do
			if part==i then
				return e.parts[i],false
			end
		end
	else
		for i=2,22,2 do
			if part==i then
				return e.parts[i],false
			end
		end
	end--minor optimization; doubt it makes much of a difference though; should probably remove it
end

function e.checkTime(gameTime)
	--gameTime=(gameTime=='night' or false)
	--return gameTime
	return gameTime=='night' or false
end

function e.checkWeather(weather)
	local t=e.define.weather
	return ((t.fog==weather and 'fog') or (t.sandstorm==weather and 'sandstorm') or 'normal')
end

function e.checkLocation(location)
	local t=e.define.location
	if not location then return 'other' end
	local checkMatch=function(locationTablePos,location)
		for i=1,#locationTablePos do
			if location==locationTablePos[i] then
				return true
			end
		end
		return false
	end
	return ((checkMatch(t.afgh,location) and 'AFGH') or (checkMatch(t.mafr,location) and 'MAFR') or (checkMatch(t.mtbs,location) and 'MTBS') or 'other')
end

function e.checkMission(missionCode)--good; need to add other codes; afgh quiet pre/post; mtbs
	--local t=e.define.mission.free
	--return (t[missionCode] or false)
	return e.define.mission.free[missionCode] or false
end

function e.checkGunfire(ride,guardPhase)
	local t={vehicle=true,helicopter=true,dwalker=true,gimmickMG=true,gimmickAA=true,gimmickMortar=true}
	local is=e.playerStatus
	local gunfire=((is('GUN_FIRE') and not is('GUN_FIRE_SUPPRESSOR') and true) or (is('GUN_FIRE_SUPPRESSOR') and e.define.phase.caution<guardPhase and true) or false)
	if e.var.keyLog.fire and t[ride] then
		if ride=='vehicle' then
			local e=e.define.vehicle.category
			t=(G.gameObj_v.SendCommand(vars.playerVehicleGameObjectId,{id='GetVehicleType'})) or e.highInvalid
			if e.highTruck<t and t<e.highInvalid then
				return true
			end
			return false
		end
		return true
	elseif gunfire then
		return true
	end
	return false
end

function e.checkEnclosed()
	local p=(G.gameObj_v.SendCommand(vars.playerVehicleGameObjectId,{id='GetVehicleType'})) or 65535
	local t=e.define.vehicle.category
	t={null_low=t.lowInvalid,max_4WD=t.high4WD,max_truck=t.highTruck,null_high=t.highInvalid}
	if p<t.null_high and t.null_low<p then
		if t.max_truck<p then
			return 'enclosed'
		elseif t.max_4WD<p then
			return 'truck'
		end
	end
	return false
end

--[[function e:monitorSpecialStance(vehicleType,guardPhase,stance,speed)
	if e.var.exception.brokeSpecialStance then
		e.var.special.vehicle=false
		e.var.special.proneStealth=false
		return
	elseif not self.moveAction and not self.fire and guardPhase<e.define.phase.alert then
		if ((self.stance or e.var.special.vehicle) and vehicleType=='truck') then
			e.var.special.vehicle=true
		elseif (e.var.special.proneStealth and stance=='prone' and speed=='idle' and e.playerStatus('NORMAL_ACTION')) then
			e.var.special.proneStealth=true
		elseif e.var.icon.proneStealth then
			if stance=='prone' and speed=='idle' and e.playerStatus('NORMAL_ACTION') then
				e.var.special.proneStealth=true
				return
			end
		end
	end
	e.var.special.vehicle=false
	e.var.special.proneStealth=false
end]]

function e:getAllPlayerStatus(func)
	local t={}
	for i=1,#self do
		t[self[i]]=func(self[i])
	end
	self,func=nil
	return t
end

function e.checkStatus()
	local speed='dash'
	local stance='stand'
	local ride=e.var.ride or false
	local t=e.debugTable.playerStatus
	local is=e.getAllPlayerStatus(t,e.playerStatus)--bool table

	if ride~='carry' and is.NORMAL_ACTION then
		ride=false
	end
	--F.echo(tostring(ride))
	--e.debug.buttonsOrStatus(e.debugTable.playerStatus,'status')
	t={
		speed=function(s)if(is.STOP or is.HORSE_IDLE or is.IDLE)then return'idle'elseif(is.WALK or is.HORSE_TROT)then return'walk'elseif(is.RUN or is.HORSE_CANTER)then return'jog'end return s end,
		stance=function(s)if(is.CRAWL)then return'prone'elseif(is.SQUAT or is.HORSE_HIDE_L or is.HORSE_HIDE_R)then return'crouch'end return s=='stand'and is.FALL and'fall'or s end,
		stanceSpeedMax=function(sp,st)if(st=='prone'or st=='crouch')then return((sp=='dash'and'jog')or sp)end return sp end,
		stationary={gimmickMG=true,gimmickSearchlight=true,gimmickAA=true,gimmickMortar=true},
		trash={trash=true,trash_open=true,trash_closed=true},
		dwalker=function()return is.HORSE_IDLE or is.HORSE_TROT or is.HORSE_CANTER or is.HORSE_GALLOP or false end,
		strings={staticStand={gimmickMG=true,gimmickSearchlight=true},staticCrouch={gimmickAA=true,gimmickMortar=true},trash={trash=true,trash_open=true,trash_closed=true}}
	}
	speed=t.speed(speed)
	stance=t.stance(stance)
	speed=t.stanceSpeedMax(speed,stance)
	t.speed,t.stance,t.stanceSpeedMax=false

	if ride then
		local func
		--F.echo(ride)
		if t.stationary[ride] then
			--F.echo('t.strings.staticStand[ride] | '..tostring(t.strings.staticStand[ride]))
			--F.echo('t.strings.staticCrouch[ride] | '..tostring(t.strings.staticCrouch[ride]))
			if t.strings.staticStand[ride] then
				func=function(r,sp,_)return r,sp,'stand'end
			elseif t.strings.staticCrouch[ride] then
				func=function(r,_,_)return r,'idle','crouch'end
			end
		elseif ride=='toilet' then
			func=function(r,sp,st)return is.STOP and is.STAND and is.SUBJECT and is.PARTS_ACTIVE and r,sp,'stand'or r,sp,st,true end
		elseif t.trash[ride] then
			func=function(_,sp,st)st='crouch';if is.TRASH_BOX then return'trash_closed',sp,st elseif is.TRASH_BOX_HALF_OPEN then return 'trash_open',sp,st end; return false,sp,st end
		elseif ride=='carry' then
			func=function(r,sp,st)return is.CARRY and r,sp,st or false,sp,st end
		elseif ride=='cbox' then
			func=function(r,sp,st)return r,sp,st end
		elseif (ride=='vehicle' or is.ON_VEHICLE) then
			func=function(r,sp,_)r=((is.ON_VEHICLE and r)or false);return r,sp,'stand' end
		end
		--if func then F.echo('func('..tostring(ride)..','..tostring(speed)..','..tostring(stance)..')')end
		if func then return func(ride,speed,stance)end
	end

	ride=((is.ON_HORSE and'horse')or(t.dwalker() and'dwalker')or(is.ON_VEHICLE and'vehicle')or(is.ON_HELICOPTER and'helicopter')or false)
	--stance=((stance=='stand'and is.FALL and'fall')or stance)
	return ride,speed,stance
end

function e:largestCamoBonus(location)
	local n=self.urban
	if location=='AFGH' then
		self.green=-65535
		self.red=-65535
	elseif location=='MTBS' then
		return n
	end
	location=nil
	for _,v in pairs(self) do
		if n<v then
			n=v
		end
	end
	return n
end

function e.checkItemBonusConflicts(bonus)
	--F.echo('ride='..tostring(e.var.ride))
	if bonus~=0 and ride then
		local t={cbox=true,vehicle=true,horse=true,dwalker=true}
		if t[e.var.ride] then
			bonus=0
		end
		t=nil
	end
	return bonus
end

function e.calculate(ci)
	if ci then
		local n=e.index.sight.camo
		if ci<n.far then
			ci=(n.far-200)
		else
			ci=(ci-200)
		end
		ci=(floor((ci/(n.discovery-200))*1e3)*0.1)
		InfCore.ExtCmd('SetContent','camoIndex','CI: '..ci..'%')--tex
	else
		F.echo('ERROR: CI is '..tostring(ci)..' | type: '..type(ci))
	end
	e.resetLocalVarTable(e.var)
	return
end

--DEBUGNOW
e.buttonHold=0--tex
--tex>
e.uiEnabled=false

function e.CreateUi()
local camoIndexLabelXaml={
  [[<Label ]],
  [[xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" ]],
  [[Name="camoIndex" ]],
  [[Visibility="Hidden" ]],
  [[Content="----" ]],
  [[Foreground="White" ]],
  [[Background="Transparent" ]],
  [[FontSize="25" ]],
  [[Canvas.Left="1764" ]],
  [[Canvas.Top="66">]],
  [[<Label.Effect>]],
  [[<DropShadowEffect ]],
  [[ShadowDepth="2" ]],
  [[Direction="325" ]],
  [[Color="Black" ]],
  [[Opacity="1" ]],
  [[BlurRadius="0.0"/>]],
  [[</Label.Effect>]],
  [[</Label>]],
}

  if InfCore then
    InfMgsvToExt.CreateUiElement('camoIndex',table.concat(camoIndexLabelXaml))
  end
end

function e.ShowUi()
  if not e.uiEnabled then
    e.uiEnabled=true
    if InfCore then--tex is IH
      InfCore.ExtCmd('UiElementVisible','camoIndex',1)
    end
  end
end
function e.HideUi()
  if e.uiEnabled then
    e.uiEnabled=false
    if InfCore then--tex is IH
      InfCore.ExtCmd('UiElementVisible','camoIndex',0)
    end
  end
end

function e.OnFadeInDirect(msgName)
  --if not mvars.mis_missionStateIsNotInGame then--DEBUGNOW
  if vars.missionCode > 5 and not TppMission.IsHelicopterSpace(vars.missionCode) and not InfTppUtil.IsDemoPlaying() then
    e.ShowUi()
  end
end
function e.OnFadeOutDirect(msgName)
  e.HideUi()
end

function e.Init()
  e.CreateUi()
end
--<

function e.Update(currentChecks,currentTime,execChecks,execState)--tex added IH vars
  --tex
  if currentChecks and not currentChecks.inMission then
    return
  end

	if e.playerPressed('VEHICLE_FIRE') or e.playerPressed('FIRE') then
		e.var.keyLog.fire=true
		e.var.exception.brokeSpecialStance=true
		e.var.icon.proneStealth=false
	else
		e.var.keyLog.fire=false
	end

	--[[
		if e.playerPressed('ACTION') then
			e.var.keyLog.action=true
		else
			e.var.keyLog.action=false
		end

		if e.playerPress('STANCE') then
			e.var.keyLog.stance=true
			e.var.icon.proneStealth=false
		else
			e.var.keyLog.stance=false
		end

		if e.playerPress('MOVE_ACTION') then
			e.var.keyLog.moveAction=true
			e.var.exception.brokeSpecialStance=true
			e.var.icon.proneStealth=false
		else
			e.var.keyLog.moveAction=false
		end
	]]

  if e.playerPressed('RELOAD') or InfCore then--tex
		if (1<(F.gameElapsedTime()-e.buttonHold)) then
			e.buttonHold=F.gameElapsedTime()
			
			if currentChecks and currentChecks.inDemo then
			 e.HideUi()
			else
			 e.ShowUi()
			end
			
			local l={vars=vars,def=e.define}
			local m={floor=floor,sqrt=sqrt}

			e.var.guardPhase=l.vars.playerPhase--int
			e.var.mission=l.vars.missionCode--int
			e.var.time=G.tppClock.GetTimeOfDay()--str
			e.var.weather=l.vars.weather--int
			e.var.location=l.vars.locationCode--int
			e.var.player.currentPos={l.vars.playerPosX,l.vars.playerPosY,l.vars.playerPosZ}--int float

			--F.echo('e.Update()|pre lv table|e.var.ride='..tostring(e.var.ride))

      		local lv={
      			freeroam=e.checkMission(l.vars.missionCode),--bool
      			item=e.checkItem(e.var.guardPhase),--int
      			night=e.checkTime(e.var.time),--bool
      			weather=e.checkWeather(l.vars.weather),--str
      			location=e.checkLocation(l.vars.locationCode),--int
      			ride=false,--bool/str
      			speed='idle',--str
      			stance='stand',--str
      			gunfire=false,--bool
      			inCover=e.playerStatus('BEHIND'),--bool
      			vType=false,--bool
      			camo=false,--bool/str
      			ability=false,--bool/str
      			inQuestArea=false,--bool
      			phase=l.vars.playerPhase,--int
      		}

      		lv.ride,lv.speed,lv.stance=e.checkStatus()
      		--F.echo('e.Update()|post e.checkStatus()|lv.ride='..tostring(lv.ride))
      		e.var.ride=lv.ride
      		lv.item=e.checkItemBonusConflicts(lv.item)
      		lv.gunfire=e.checkGunfire(lv.ride,lv.phase)
      		lv.vType=(lv.ride=='vehicle'and e.checkEnclosed()or false)
      		lv.camo,lv.ability=(lv.ride=='cbox'and e.var.cboxCamo)
      		if not lv.camo then lv.camo,lv.ability=e.checkParts(l.vars.playerPartsType)end

			if type(e.var.quest)=='table'and lv.vType=='enclosed'then
				local a=e.var.quest.area
				local qp={a[1],a[2],a[3]}
				a=nil
				local ql=e.var.quest.len
				local pp=e.var.player.currentPos
				local x,y,z=(pp[1]-qp[1]),(pp[2]-qp[2]),(pp[3]-qp[3])
				x=m.sqrt((x*x)+(y*y)+(z*z))
				y,z=nil
				x=((m.floor(x*1e3))*1e-3)
				e.var.exception.playerLeftQuestArea=(ql<x)
			end

			m.sqrt=nil

			lv.inQuestArea=((not e.var.exception.playerLeftQuestArea and true)or false)

			l.vars=nil
		
			local n=e.index.sight.camo.discovery--standard max; 840
			local ci=0
			local p=e.index.points

			if lv.night then
				ci=(((n*p.time.night)*p.weather[lv.weather])+p.light.night)
				ci=(lv.ability=='night'and(ci+p.material.surface)or ci)
				ci=(e.var.flashed and(ci+p.light.ambient)or ci)
			else
				ci=((m.floor(n*0.239))*p.weather[lv.weather])--~24% of standard max by weather bonus percent
			end

			m=nil

			ci=((ci+lv.item)+p.stance[lv.stance])
			ci=((lv.gunfire and (ci+p.gun.flash))or ci)
			n=e.index.sight.camo	

			if lv.ride then
				if lv.ride=='helicopter'then
					ci=(ci+p.speed[lv.speed])
					if lv.phase==l.def.phase.sneak then
						e.calculate(ci)
					else
						e.calculate(n.far)
					end
					return
				elseif lv.ride=='dwalker'then
					if lv.ability=='vehicle'then
						ci=(ci+p.material.surface)
					end
					if lv.stance=='stand'then
						ci=(ci+p.speed[lv.speed])
					else
						if lv.speed=='idle'then
							ci=(ci+p.speed[lv.speed])
						else
							ci=(ci+p.speed.walk)
						end
					end
					e.calculate(ci)
					return
				elseif lv.freeroam and lv.vType=='enclosed'then
					if not lv.inQuestArea and(lv.phase<l.def.phase.alert)then
						if lv.gunfire then
							ci=n.dim
						elseif e.var.exception.playerVehicleImpact then
							ci=n.indis
						else
							ci=n.friendly
						end
						if lv.ability~='vehicle'then
							ci=(ci-p.material.surface)
						end
					else
						ci=((lv.ability=='vehicle'and(ci+p.material.surface))or ci)
					end
					e.calculate(ci)
					return
				end
			end

			ci=(ci+p.speed[lv.speed])

			if lv.phase<l.def.phase.alert then
				if lv.ride=='cbox'and lv.speed=='idle'then
					if lv.stance=='prone'or lv.stance=='crouch'then
						e.calculate(n.friendly)
						return
					end
				elseif lv.ride=='toilet'or lv.ride=='trash_closed'then
					e.calculate(n.friendly)
					return
				elseif lv.ride=='trash_open'then
					e.calculate(n.indis)
					return
				end
			end

			l.def=nil

			ci=((lv.inCover and(ci+p.material.cover))or ci)
			local t={vehicle=true,gimmickMG=true,gimmickSearchlight=true,gimmickAA=true,gimmickMortar=true}
			ci=((t[lv.ride] and lv.ability=='vehicle' and (ci+p.material.surface)) or (lv.ride=='carry' and (ci+p.material.surface)) or ci)
			t={toilet=true,trash_closed=true,trash_open=true}

			if lv.camo and lv.location~='other'then
				if type(lv.camo)=='table'then
					if t[lv.ride]then
						ci=(ci+lv.camo.urban)
					else
						ci=(ci+e.largestCamoBonus(lv.camo,lv.location))
					end
				else
					if((t[lv.ride]and lv.camo=='urban')or(not t[lv.ride]and lv.location=='MAFR'))then
						ci=(ci+p.material.surface)
					else
						t={AFGH={desert=true,mix=true,wet=true,rock=true,urban=true},MTBS={urban=true}}
						if t[lv.location][lv.camo]then
							ci=(ci+p.material.surface)
						end
					end
				end
			end

			e.calculate(ci)
			return
		end
	else
		e.buttonHold=F.gameElapsedTime()
	end
end
--[[
	NEW:
		- Cbox type now checked. Camo bonus will no longer be given when using water-resistant or smoke cboxes. Cbox camo bonus will be given by location like with fatigue camo bonus.
		- Vehicle and stationary weapon gunfire checks added. Does not factor in actual discharge, only if the fire button is pressed and vehicle has a weapon.
		- Stealth camo now factored into total camo bonus.
		- Enclosed vehicle bonus will now take into account vehicle type, player vehicle damage, and vehicle fire.
		- Bonus for carrying an enemy fixed; now only given if the carried AI is alive and an enemy.
		- When wearing Splitter fatigues an index bonus will be added when operating stationary weapons (AA gun, mortar, searchlight, etc.).
		
		- Patch: typo caused idle speed to give a bonus of 10. Now properly set 0.
		- Patch: syntax errors with guard phases interfered with bonuses possessing guard phase conditionals.
		- Patch: bonus for carrying enemy soldier was being given for any AI, will now only occur if the AI is alive and an enemy.
		- Patch: freeroam enclosed vehicle bonus now being given properly (was being given when using jeep or truck).

	To do:
		- Bug: CI for cbox dash and cbox jog same; not sure if this was intentional

		- coroutine for tracking keyLog.fire
		- "speedometer" function to gauge speed for vehicles
		- while ON_TOILET log zoom button press (makes noise that attracts guards)

	Limitations:
		- Camo surface bonus being given if material type exists at location (AFGH,MAFR,MTBS,CYPR) rather than by catching player collision with material.
		- Player illumination not checked. Only the +10 stacked bonus for nighttime ci.
		- No status check for prone stealth mode. Might be possible by keeping track of action button press
		- No status check for vehicle speed. PlayerStatus always returns STOP. Could implement by keeping track of player distance travelled.
		- Hiding in truck cabin is not checked. PlayerStatus always STAND in vehicles.
]]
return e