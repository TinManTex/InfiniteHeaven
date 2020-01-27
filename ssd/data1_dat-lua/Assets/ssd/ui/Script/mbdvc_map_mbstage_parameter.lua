mbdvc_map_mbstage_parameter={GetMissionParameter=function(l)
local e=l.missionId
local _=l.layoutCode
local i=l.commandClusterGrade
local o=l.combatClusterGrade
local p=l.developClusterGrade
local t=l.supportClusterGrade
local r=l.medicalClusterGrade
local n=l.spyClusterGrade
local l=l.baseDevClusterGrade
local r={i,o,p,t,r,n,l}
local l={0,1,2,3}
local t={13}
local c={{{{{routeId="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(9.1155920028687,8.7501268386841,-42.430213928223),isDefault=true}}},{{{routeId="ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(834.69958496094,8.7501268386841,-559.33135986328)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(817.86083984375,8.7501268386841,-702.79693603516)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(940.71807861328,8.7501268386841,-760.60205078125)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1068.4658203125,8.7501268386841,-714.60314941406)}}},{{{routeId="ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(878.12158203125,8.7501268386841,390.92022705078)},{routeId="ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr",point=Vector3(867.09564208984,37.018760681152,318.51306152344)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1021.5867919922,8.7501268386841,374.08148193359)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1111.1253662109,8.7501268386841,260.72958374023)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1238.8725585938,8.7501268386841,306.72833251953)}}},{{{routeId="ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(559.3310546875,8.7501268386841,834.69848632813)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(702.79632568359,8.7501268386841,817.85980224609)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(760.60131835938,8.7501268386841,940.71697998047)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(714.60266113281,8.7501268386841,1068.4644775391)}}},{{{routeId="ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1052.3092041016,8.7501268386841,-31.604196548462)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1110.1140136719,8.7501268386841,-154.46151733398)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1253.5795898438,8.7501268386841,-137.62275695801)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1311.3845214844,8.7501268386841,-260.48007202148)}}},{{{routeId="ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-30.111001968384,8.7501268386841,1052.3082275391)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(83.241088867188,8.7501268386841,1141.8471679688)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(37.241870880127,8.7501268386841,1269.5948486328)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(150.59407043457,8.7501268386841,1359.1336669922)}}},{{{routeId="ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-763.33709716797,8.7501268386841,731.60040283203)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-891.08483886719,8.7501268386841,685.6015625)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-980.62347412109,8.7501268386841,798.95379638672)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1108.3712158203,8.7501268386841,752.95513916016)}}}},{{{{routeId="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(9.1155920028687,8.7501268386841,-42.430213928223),isDefault=true},{routeId="ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr",point=Vector3(-1.9415365457535,26.005094528198,17.777017593384)}},{{routeId="ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(159.4271697998,8.7501268386841,9.6170091629028),disableClusterIndex=(TppDefine.CLUSTER_DEFINE.Develop+1)}}},{{{routeId="ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(951.6923828125,8.7501268386841,-562.83123779297)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(934.85363769531,8.7501268386841,-706.29681396484)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1057.7108154297,8.7501268386841,-764.10192871094)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1185.4586181641,8.7501268386841,-718.10302734375)}}},{{{routeId="ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(995.11791992188,8.7501268386841,410.41690063477)},{routeId="ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr",point=Vector3(984.45190429688,37.018760681152,337.64984130859)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1138.5832519531,8.7501268386841,393.57818603516)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1228.1217041016,8.7501268386841,280.22622680664)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1355.8688964844,8.7501268386841,326.22500610352)}}},{{{routeId="ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(279.6535949707,8.7501268386841,981.46038818359)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(393.00555419922,8.7501268386841,1070.9992675781)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(347.00640869141,8.7501268386841,1198.7468261719)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(224.14906311035,8.7501268386841,1256.5518798828)}}},{{{routeId="ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-244.19276428223,8.7501268386841,-905.35906982422)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-198.19381713867,8.7501268386841,-1033.1063232422)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-311.54595947266,8.7501268386841,-1122.6448974609)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-265.54711914063,8.7501268386841,-1250.3923339844)}}},{{{routeId="ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-717.70281982422,8.7501268386841,559.83355712891)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-700.86419677734,8.7501268386841,703.29937744141)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-823.72180175781,8.7501268386841,761.10437011719)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-806.88293457031,8.7501268386841,904.57025146484)}}},{{{routeId="ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-788.7958984375,8.7501268386841,-381.5334777832)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-846.60076904297,8.7501268386841,-504.39074707031)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-990.06616210938,8.7501268386841,-487.55209350586)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1047.8713378906,8.7501268386841,-610.40930175781)}}}},{{{{routeId="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(9.1155920028687,8.7501268386841,-42.430213928223),isDefault=true},{routeId="ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr",point=Vector3(-1.9415365457535,26.005094528198,17.777017593384)}},{{routeId="ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(159.4271697998,8.7501268386841,9.6170091629028)}},{{routeId="ly003_cl00_30050_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(248.96594238281,8.7501268386841,-103.73515319824),disableClusterIndex=(TppDefine.CLUSTER_DEFINE.Combat+1)}}},{{{routeId="ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1048.2072753906,8.7501268386841,-631.77398681641)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1031.3685302734,8.7501268386841,-775.23950195313)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1154.2257080078,8.7501268386841,-833.04461669922)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1281.9735107422,8.7501268386841,-787.04571533203)}}},{{{routeId="ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1095.408203125,8.7501268386841,323.56674194336)},{routeId="ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr",point=Vector3(1084.7421875,37.018760681152,250.79963684082)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1238.8735351563,8.7501268386841,306.72796630859)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1328.4119873047,8.7501268386841,193.37603759766)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1456.1591796875,8.7501268386841,239.37481689453)}}},{{{routeId="ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(362.35015869141,8.7501268386841,905.54925537109)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(475.70230102539,8.7501268386841,995.08782958984)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(429.70343017578,8.7501268386841,1122.8355712891)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(306.84616088867,8.7501268386841,1180.6407470703)}}},{{{routeId="ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-160.6671295166,8.7501268386841,-993.63580322266)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-114.66819000244,8.7501268386841,-1121.3830566406)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-228.02030944824,8.7501268386841,-1210.9216308594)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-182.02145385742,8.7501268386841,-1338.6690673828)}}},{{{routeId="ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-717.70281982422,8.7501268386841,559.83355712891)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-700.86419677734,8.7501268386841,703.29937744141)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-823.72180175781,8.7501268386841,761.10437011719)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-806.88293457031,8.7501268386841,904.57025146484)}}},{{{routeId="ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-788.7958984375,8.7501268386841,-381.5334777832)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-846.60076904297,8.7501268386841,-504.39074707031)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-990.06616210938,8.7501268386841,-487.55209350586)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1047.8713378906,8.7501268386841,-610.40930175781)}}}},{{{{routeId="ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(9.1155920028687,8.7501268386841,-42.430213928223),isDefault=true},{routeId="ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr",point=Vector3(-1.9415365457535,26.005094528198,17.777017593384)}},{{routeId="ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(159.4271697998,8.7501268386841,9.6170091629028)}},{{routeId="ly003_cl00_30050_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(248.96594238281,8.7501268386841,-103.73515319824)}},{{routeId="ly003_cl00_30050_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(376.71340942383,8.7501268386841,-57.736152648926),disableClusterIndex=(TppDefine.CLUSTER_DEFINE.Develop+1)}}},{{{routeId="ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1168.978515625,8.7501268386841,-630.18487548828)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1152.1398925781,8.7501268386841,-773.650390625)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1274.9969482422,8.7501268386841,-831.45550537109)}},{{routeId="ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1402.7447509766,8.7501268386841,-785.45660400391)}}},{{{routeId="ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1212.4044189453,8.7501268386841,343.06323242188)},{routeId="ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr",point=Vector3(1201.7384033203,37.018760681152,270.29614257813)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1355.8697509766,8.7501268386841,326.22448730469)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1445.408203125,8.7501268386841,212.87255859375)}},{{routeId="ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(1573.1553955078,8.7501268386841,258.87133789063)}}},{{{routeId="ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(362.35015869141,8.7501268386841,905.54925537109)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(475.70230102539,8.7501268386841,995.08782958984)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(429.70343017578,8.7501268386841,1122.8355712891)}},{{routeId="ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(306.84616088867,8.7501268386841,1180.6407470703)}}},{{{routeId="ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-160.6671295166,8.7501268386841,-993.63580322266)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-114.66819000244,8.7501268386841,-1121.3830566406)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-228.02030944824,8.7501268386841,-1210.9216308594)}},{{routeId="ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-182.02145385742,8.7501268386841,-1338.6690673828)}}},{{{routeId="ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-717.70281982422,8.7501268386841,559.83355712891)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-700.86419677734,8.7501268386841,703.29937744141)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-823.72180175781,8.7501268386841,761.10437011719)}},{{routeId="ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-806.88293457031,8.7501268386841,904.57025146484)}}},{{{routeId="ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-788.7958984375,8.7501268386841,-381.5334777832)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-846.60076904297,8.7501268386841,-504.39074707031)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-990.06616210938,8.7501268386841,-487.55209350586)}},{{routeId="ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-1047.8713378906,8.7501268386841,-610.40930175781)}}}}}
local o={{{},{},{{{routeId="ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(878.28747558594,-3.498596906662,323.64611816406),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(974.13403320313,-3.498596906662,326.39437866211),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1043.8511962891,-3.498596906662,260.56399536133),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1191.4196777344,-3.498596906662,259.04104614258),isDefault=true}}},{},{},{},{}},{{},{},{{{routeId="ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(995.28381347656,-3.498596906662,343.14279174805),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1091.1303710938,-3.498596906662,345.89108276367),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1160.8475341797,-3.498596906662,280.06066894531),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1308.416015625,-3.498596906662,278.53768920898),isDefault=true}}},{},{},{},{}},{{},{},{{{routeId="ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1095.57421875,-3.498596906662,256.29260253906),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1191.4206542969,-3.498596906662,259.04086303711),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1261.1378173828,-3.498596906662,193.21047973633),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1408.7062988281,-3.498596906662,191.68753051758),isDefault=true}}},{},{},{},{}},{{},{},{{{routeId="ly003_cl02_10115_heli0000|cl02pl0_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1212.5700683594,-3.498596906662,275.78900146484),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl1_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1308.4165039063,-3.498596906662,278.53726196289),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl2_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1378.1336669922,-3.498596906662,212.70687866211),isDefault=true}},{{routeId="ly003_cl02_10115_heli0000|cl02pl3_mb_fndt_plnt_heli_10115|rt_apr",point=Vector3(1525.7021484375,-3.498596906662,211.18392944336),isDefault=true}}},{},{},{},{}}}
local n={{routeId="ly500_cl00_30150_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(9.1155920028687,8.7501268386841,-42.430213928223),isDefault=true},{routeId="ly500_cl00_30150_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(159.4271697998,8.7501268386841,9.6170091629028)},{routeId="ly500_cl00_30150_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-131.97308349609,8.7501268386841,100.23579406738)},{routeId="ly500_cl00_30150_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-104.23648071289,8.7501268386841,-131.96905517578)}}
local p={{routeId="ly003_cl07_30050_heli0000|cl07pl0_mb_fndt_plnt_heli_30050|rt_apr",point=Vector3(-162.5267791748,8.7501268386841,-2104.9208984375),isSeparation=true}}
local t={}
if e==30050 then
local e={}
local i={}
local o=c
i=l
for l,t in ipairs(o)do
if _==i[l]then
e=t
end
end
for _,e in ipairs(e)do
local _=r[_]
if _>0 then
local l=0
for p,e in ipairs(e)do
if l<_ then
for e,_ in ipairs(e)do
if _.disableClusterIndex then
local l=r[_.disableClusterIndex]
if l==0 then
table.insert(t,_)
end
else
table.insert(t,_)
end
end
l=l+1
end
end
end
end
table.insert(t,p[1])
elseif e==30150 then
local _={}
local e={}
local _=n
e=l
for l,_ in ipairs(_)do
table.insert(t,_)
end
elseif e==30250 then
local _={}
local e={}
local _=p
e=l
for l,_ in ipairs(_)do
table.insert(t,_)
end
elseif e==10115 then
local e={}
local p={}
local i=o
p=l
for l,t in ipairs(i)do
if _==p[l]then
e=t
end
end
local _=2
local l=r[_+1]t=e[_+1][l]
elseif e==50050 then
local r={[1]=Vector3(34.2,-4,-3),[2]=Vector3(19.4,-8,-29.5),[3]=Vector3(-36.2,-8,-8.4)}
local l
if _>=10 and _<=13 then
l=13
elseif _>=20 and _<=23 then
l=23
elseif _>=30 and _<=33 then
l=33
elseif _>=40 and _<=43 then
l=43
elseif _>=50 and _<=53 then
l=53
elseif _>=60 and _<=63 then
l=63
elseif _>=70 and _<=73 then
l=73
elseif _>=80 and _<=83 then
l=83
elseif _>=90 and _<=93 then
l=93
elseif _>=100 and _<=103 then
l=103
end
for _=1,3 do
local e=string.format("ly%03d_cl%s_%d_heli0000|cl%spl%s_mb_fndt_plnt_heli_%d|rt_apr_of%d",l,"%02d",e,"%02d","%d",e,_)
local r=r[_]
local l=false
if _==2 then
l=true
end
local _={relativeRouteId=e,relativePoint=r,isDefault=l}
table.insert(t,_)
end
end
return{heliLandPoint=t}
end}
