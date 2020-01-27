-- DOBUILD: 1
-- ORIGINALQAR: chunk3
-- PACKPATH: \Assets\tpp\pack\location\mtbs\pack_common\mtbs_script.fpkd


local mtbs_helicopter = {}
local IsTypeTable = Tpp.IsTypeTable
local IsTypeString = Tpp.IsTypeString
local IsTypeNumber = Tpp.IsTypeNumber
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID





local DEFAULT_CLUSTER_ID = 1

local DEFAULT_PLATFORM_ID = 1





mtbs_helicopter.clusterHeliRouteTable = {
	
	{
		{ platformId = 1, routeId = "ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 1, routeId = "ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|rt_apr",		isHeliport = true },
		{ platformId = 2, routeId = "ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl00_30050_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl00_30050_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 2, routeId = "ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 1, routeId = "ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|rt_apr",		isHeliport = true },
		{ platformId = 2, routeId = "ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 2, routeId = "ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 2, routeId = "ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 2, routeId = "ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 2, routeId = "ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 3, routeId = "ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|rt_apr", },
		{ platformId = 4, routeId = "ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly500_cl00_30150_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly500_cl00_30150_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly500_cl00_30150_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly500_cl00_30150_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|rt_apr", },
	},
	
	{
		{ platformId = 1, routeId = "ly003_cl07_30050_heli0000|cl07pl0_mb_fndt_plnt_heli_30050|rt_apr", },
	},
}





mtbs_helicopter.Messages = function()
	return
end









mtbs_helicopter.OnInitialize = function( subScripts )
	
	mtbs_helicopter.messageExecTable = Tpp.MakeMessageExecTable( mtbs_helicopter.Messages() )
	
	mvars.mbHelicopter_startClusterId	= DEFAULT_CLUSTER_ID
	mvars.mbHelicopter_startPlatformId	= DEFAULT_PLATFORM_ID
	mvars.mbHelicopter_startIsHeliport	= false
	
	mtbs_helicopter._SetClusterId()
end





mtbs_helicopter.OnReload = function( subScripts )
	
	mtbs_helicopter.messageExecTable = Tpp.MakeMessageExecTable( mtbs_helicopter.Messages() )
end




mtbs_helicopter.OnMessage = function( sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	
	Tpp.DoMessage( mtbs_helicopter.messageExecTable, TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText )
end





function mtbs_helicopter.OnMissionGameStart()
	
end





local LANDING_ZONE_GROUP_TABLE = {
	
	[  StrCode32( "ly003_cl00_30050_heli0000|cl00pl0_uq_0000_heli_30050|lz_cl00")	  ]	= "groupCommand",
	[  StrCode32( "ly003_cl00_30050_heli0000|cl00pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCommand",
	[  StrCode32( "ly003_cl00_30050_heli0000|cl00pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCommand",
	[  StrCode32( "ly003_cl00_30050_heli0000|cl00pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCommand",
	[  StrCode32( "ly003_cl00_30050_heli0000|cl00pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCommand",
	
	[  StrCode32( "ly003_cl01_30050_heli0000|cl01pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCombat",
	[  StrCode32( "ly003_cl01_30050_heli0000|cl01pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCombat",
	[  StrCode32( "ly003_cl01_30050_heli0000|cl01pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCombat",
	[ StrCode32(  "ly003_cl01_30050_heli0000|cl01pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupCombat",
	
	[  StrCode32( "ly003_cl02_30050_heli0000|cl02pl0_uq_0020_heli_30050|lz_cl02")	  ] = "groupDevelop",
	[  StrCode32( "ly003_cl02_30050_heli0000|cl02pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupDevelop",
	[  StrCode32( "ly003_cl02_30050_heli0000|cl02pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupDevelop",
	[  StrCode32( "ly003_cl02_30050_heli0000|cl02pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupDevelop",
	[  StrCode32( "ly003_cl02_30050_heli0000|cl02pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupDevelop",
	
	[  StrCode32( "ly003_cl03_30050_heli0000|cl03pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupSupport",
	[  StrCode32( "ly003_cl03_30050_heli0000|cl03pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupSupport",
	[  StrCode32( "ly003_cl03_30050_heli0000|cl03pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupSupport",
	[  StrCode32( "ly003_cl03_30050_heli0000|cl03pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupSupport",
	
	[  StrCode32( "ly003_cl04_30050_heli0000|cl04pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMedic",
	[  StrCode32( "ly003_cl04_30050_heli0000|cl04pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMedic",
	[  StrCode32( "ly003_cl04_30050_heli0000|cl04pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMedic",
	[  StrCode32( "ly003_cl04_30050_heli0000|cl04pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMedic",
	
	[  StrCode32( "ly003_cl05_30050_heli0000|cl05pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupIntel",
	[  StrCode32( "ly003_cl05_30050_heli0000|cl05pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupIntel",
	[  StrCode32( "ly003_cl05_30050_heli0000|cl05pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupIntel",
	[  StrCode32( "ly003_cl05_30050_heli0000|cl05pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupIntel",
	
	[  StrCode32( "ly003_cl06_30050_heli0000|cl06pl0_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMBDev",
	[  StrCode32( "ly003_cl06_30050_heli0000|cl06pl1_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMBDev",
	[  StrCode32( "ly003_cl06_30050_heli0000|cl06pl2_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMBDev",
	[  StrCode32( "ly003_cl06_30050_heli0000|cl06pl3_mb_fndt_plnt_heli_30050|lz_plnt")] = "groupMBDev",
}


mtbs_helicopter.GetLandingZoneGroup = function( landingZoneName )
	Fox.Log( "this.GetLandingZoneGroup(): landingZoneName:" .. tostring( landingZoneName ) )
	return LANDING_ZONE_GROUP_TABLE[ landingZoneName ]
end


mtbs_helicopter.RequestHeliTaxi = function( gameObjectId, currentLandingZoneName, nextLandingZoneName )

	Fox.Log( "### RequestHeliTaxi currentLZName"..tostring(currentLandingZoneName).."nextLZName"..tostring(nextLandingZoneName).. "###" )

	local currentLandingZoneGroup =  mtbs_helicopter.GetLandingZoneGroup( currentLandingZoneName )
	local nextLandingZoneGroup =  mtbs_helicopter.GetLandingZoneGroup( nextLandingZoneName )
	Fox.Log( "### currentLandingZoneGroup ("..tostring(currentLandingZoneGroup)..") nextLandingZoneGroup ( "..tostring(nextLandingZoneGroup).. ") ###" )

	local HELI_TAXI_SETTING_TABLE_LAYOUT_0 = {
		
		[ "groupCommand"  ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat"	 ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", relayRoute = "rt_hltx_ly000_0to1", nextClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", relayRoute = "rt_hltx_ly000_0to2", nextClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", relayRoute = "rt_hltx_ly000_0to3", nextClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic"	 ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", relayRoute = "rt_hltx_ly000_0to4", nextClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel"	 ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", relayRoute = "rt_hltx_ly000_0to5", nextClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev"	 ]	= { currentClusterRoute = "rt_hltx_ly000_cl00", relayRoute = "rt_hltx_ly000_0to6", nextClusterRoute = "rt_hltx_ly000_cl06", },
		},
		
		[ "groupCombat" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly000_cl01", relayRoute = "rt_hltx_ly000_1to0", nextClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat"	 ]	= { currentClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ]	= { currentClusterRoute = "rt_hltx_ly000_cl01", relayRoute = "rt_hltx_ly000_1to2", nextClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ]	= { currentClusterRoute = "rt_hltx_ly000_cl01", relayRoute = "rt_hltx_ly000_1to3", nextClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic"	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl01", relayRoute = "rt_hltx_ly000_1to4", nextClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel"	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl01", relayRoute = "rt_hltx_ly000_1to5", nextClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev"	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl01", relayRoute = "rt_hltx_ly000_1to6", nextClusterRoute = "rt_hltx_ly000_cl06", },
		},
		
		[ "groupDevelop" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly000_cl02", relayRoute = "rt_hltx_ly000_2to0", nextClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat"	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl02", relayRoute = "rt_hltx_ly000_2to1", nextClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl02", relayRoute = "rt_hltx_ly000_2to3", nextClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic"	 ]	= { currentClusterRoute = "rt_hltx_ly000_cl02", relayRoute = "rt_hltx_ly000_2to4", nextClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel"	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl02", relayRoute = "rt_hltx_ly000_2to5", nextClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev"	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl02", relayRoute = "rt_hltx_ly000_2to6", nextClusterRoute = "rt_hltx_ly000_cl06", },
		},
		
		[ "groupSupport" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly000_cl03", relayRoute = "rt_hltx_ly000_3to0", nextClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat"  ] 	= { currentClusterRoute = "rt_hltx_ly000_cl03", relayRoute = "rt_hltx_ly000_3to1", nextClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl03", relayRoute = "rt_hltx_ly000_3to2", nextClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic" 	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl03", relayRoute = "rt_hltx_ly000_3to4", nextClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel" 	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl03", relayRoute = "rt_hltx_ly000_3to5", nextClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev" 	 ] 	= { currentClusterRoute = "rt_hltx_ly000_cl03", relayRoute = "rt_hltx_ly000_3to6", nextClusterRoute = "rt_hltx_ly000_cl06", },
		},
		
		[ "groupMedic" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly000_cl04", relayRoute = "rt_hltx_ly000_4to0", nextClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl04", relayRoute = "rt_hltx_ly000_4to1", nextClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl04", relayRoute = "rt_hltx_ly000_4to2", nextClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl04", relayRoute = "rt_hltx_ly000_4to3", nextClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl04", relayRoute = "rt_hltx_ly000_4to5", nextClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl04", relayRoute = "rt_hltx_ly000_4to6", nextClusterRoute = "rt_hltx_ly000_cl06", },
		},
		
		[ "groupIntel" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly000_cl05", relayRoute = "rt_hltx_ly000_5to0", nextClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl05", relayRoute = "rt_hltx_ly000_5to1", nextClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl05", relayRoute = "rt_hltx_ly000_5to2", nextClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl05", relayRoute = "rt_hltx_ly000_5to3", nextClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl05", relayRoute = "rt_hltx_ly000_5to4", nextClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl05", relayRoute = "rt_hltx_ly000_5to6", nextClusterRoute = "rt_hltx_ly000_cl06", },
		},
		
		[ "groupMBDev" ] = { 
			[ "groupCommand" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", relayRoute = "rt_hltx_ly000_6to0", nextClusterRoute = "rt_hltx_ly000_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", relayRoute = "rt_hltx_ly000_6to1", nextClusterRoute = "rt_hltx_ly000_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", relayRoute = "rt_hltx_ly000_6to2", nextClusterRoute = "rt_hltx_ly000_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", relayRoute = "rt_hltx_ly000_6to3", nextClusterRoute = "rt_hltx_ly000_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", relayRoute = "rt_hltx_ly000_6to4", nextClusterRoute = "rt_hltx_ly000_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", relayRoute = "rt_hltx_ly000_6to5", nextClusterRoute = "rt_hltx_ly000_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly000_cl06", },
		},
	}

	local HELI_TAXI_SETTING_TABLE_LAYOUT_1 = {
		
		[ "groupCommand" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat"	]	= { currentClusterRoute = "rt_hltx_ly001_cl00", relayRoute = "rt_hltx_ly001_0to1", nextClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop"]	= { currentClusterRoute = "rt_hltx_ly001_cl00", relayRoute = "rt_hltx_ly001_0to2", nextClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport"]	= { currentClusterRoute = "rt_hltx_ly001_cl00", relayRoute = "rt_hltx_ly001_0to3", nextClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic"	]	= { currentClusterRoute = "rt_hltx_ly001_cl00", relayRoute = "rt_hltx_ly001_0to4", nextClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel"	]	= { currentClusterRoute = "rt_hltx_ly001_cl00", relayRoute = "rt_hltx_ly001_0to5", nextClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev"	]	= { currentClusterRoute = "rt_hltx_ly001_cl00", relayRoute = "rt_hltx_ly001_0to6", nextClusterRoute = "rt_hltx_ly001_cl06", },
		},
		
		[ "groupCombat" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly001_cl01", relayRoute = "rt_hltx_ly001_1to0", nextClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat"	]	= { currentClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop"]	= { currentClusterRoute = "rt_hltx_ly001_cl01", relayRoute = "rt_hltx_ly001_1to2", nextClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport"]	= { currentClusterRoute = "rt_hltx_ly001_cl01", relayRoute = "rt_hltx_ly001_1to3", nextClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic"	] 	= { currentClusterRoute = "rt_hltx_ly001_cl01", relayRoute = "rt_hltx_ly001_1to4", nextClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel"	] 	= { currentClusterRoute = "rt_hltx_ly001_cl01", relayRoute = "rt_hltx_ly001_1to5", nextClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev"	] 	= { currentClusterRoute = "rt_hltx_ly001_cl01", relayRoute = "rt_hltx_ly001_1to6", nextClusterRoute = "rt_hltx_ly001_cl06", },
		},
		
		[ "groupDevelop" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly001_cl02", relayRoute = "rt_hltx_ly001_2to0", nextClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat"	] 	= { currentClusterRoute = "rt_hltx_ly001_cl02", relayRoute = "rt_hltx_ly001_2to1", nextClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly001_cl02", relayRoute = "rt_hltx_ly001_2to3", nextClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic"	]	= { currentClusterRoute = "rt_hltx_ly001_cl02", relayRoute = "rt_hltx_ly001_2to4", nextClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel"	] 	= { currentClusterRoute = "rt_hltx_ly001_cl02", relayRoute = "rt_hltx_ly001_2to5", nextClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev"	] 	= { currentClusterRoute = "rt_hltx_ly001_cl02", relayRoute = "rt_hltx_ly001_2to6", nextClusterRoute = "rt_hltx_ly001_cl06", },
		},
		
		[ "groupSupport" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly001_cl03", relayRoute = "rt_hltx_ly001_3to0", nextClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat"  ] 	= { currentClusterRoute = "rt_hltx_ly001_cl03", relayRoute = "rt_hltx_ly001_3to1", nextClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl03", relayRoute = "rt_hltx_ly001_3to2", nextClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl03", relayRoute = "rt_hltx_ly001_3to4", nextClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl03", relayRoute = "rt_hltx_ly001_3to5", nextClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl03", relayRoute = "rt_hltx_ly001_3to6", nextClusterRoute = "rt_hltx_ly001_cl06", },
		},
		
		[ "groupMedic" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly001_cl04", relayRoute = "rt_hltx_ly001_4to0", nextClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat"  ] 	= { currentClusterRoute = "rt_hltx_ly001_cl04", relayRoute = "rt_hltx_ly001_4to1", nextClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl04", relayRoute = "rt_hltx_ly001_4to2", nextClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl04", relayRoute = "rt_hltx_ly001_4to3", nextClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl04", relayRoute = "rt_hltx_ly001_4to5", nextClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl04", relayRoute = "rt_hltx_ly001_4to6", nextClusterRoute = "rt_hltx_ly001_cl06", },
		},
		
		[ "groupIntel" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly001_cl05", relayRoute = "rt_hltx_ly001_5to0", nextClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat"  ] 	= { currentClusterRoute = "rt_hltx_ly001_cl05", relayRoute = "rt_hltx_ly001_5to1", nextClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl05", relayRoute = "rt_hltx_ly001_5to2", nextClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl05", relayRoute = "rt_hltx_ly001_5to3", nextClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl05", relayRoute = "rt_hltx_ly001_5to4", nextClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev" 	 ] 	= { currentClusterRoute = "rt_hltx_ly001_cl05", relayRoute = "rt_hltx_ly001_5to6", nextClusterRoute = "rt_hltx_ly001_cl06", },
		},
		
		[ "groupMBDev" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly001_cl06", relayRoute = "rt_hltx_ly001_6to0", nextClusterRoute = "rt_hltx_ly001_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly001_cl06", relayRoute = "rt_hltx_ly001_6to1", nextClusterRoute = "rt_hltx_ly001_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly001_cl06", relayRoute = "rt_hltx_ly001_6to2", nextClusterRoute = "rt_hltx_ly001_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly001_cl06", relayRoute = "rt_hltx_ly001_6to3", nextClusterRoute = "rt_hltx_ly001_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly001_cl06", relayRoute = "rt_hltx_ly001_6to4", nextClusterRoute = "rt_hltx_ly001_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly001_cl06", relayRoute = "rt_hltx_ly001_6to5", nextClusterRoute = "rt_hltx_ly001_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly001_cl06", },
		},
	}

	local HELI_TAXI_SETTING_TABLE_LAYOUT_2 = {
		
		[ "groupCommand" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat"	]	= { currentClusterRoute = "rt_hltx_ly002_cl00", relayRoute = "rt_hltx_ly002_0to1", nextClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop"]	= { currentClusterRoute = "rt_hltx_ly002_cl00", relayRoute = "rt_hltx_ly002_0to2", nextClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport"]	= { currentClusterRoute = "rt_hltx_ly002_cl00", relayRoute = "rt_hltx_ly002_0to3", nextClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic"	]	= { currentClusterRoute = "rt_hltx_ly002_cl00", relayRoute = "rt_hltx_ly002_0to4", nextClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel"	]	= { currentClusterRoute = "rt_hltx_ly002_cl00", relayRoute = "rt_hltx_ly002_0to5", nextClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev"	]	= { currentClusterRoute = "rt_hltx_ly002_cl00", relayRoute = "rt_hltx_ly002_0to6", nextClusterRoute = "rt_hltx_ly002_cl06", },
		},
		
		[ "groupCombat" ] = { 
			[ "groupCommand"] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", relayRoute = "rt_hltx_ly002_1to0", nextClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", relayRoute = "rt_hltx_ly002_1to2", nextClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", relayRoute = "rt_hltx_ly002_1to3", nextClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", relayRoute = "rt_hltx_ly002_1to4", nextClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", relayRoute = "rt_hltx_ly002_1to5", nextClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl01", relayRoute = "rt_hltx_ly002_1to6", nextClusterRoute = "rt_hltx_ly002_cl06", },
		},
		
		[ "groupDevelop" ] = { 
			[ "groupCommand"] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", relayRoute = "rt_hltx_ly002_2to0", nextClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", relayRoute = "rt_hltx_ly002_2to1", nextClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", relayRoute = "rt_hltx_ly002_2to3", nextClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", relayRoute = "rt_hltx_ly002_2to4", nextClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", relayRoute = "rt_hltx_ly002_2to5", nextClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev"	] 	= { currentClusterRoute = "rt_hltx_ly002_cl02", relayRoute = "rt_hltx_ly002_2to6", nextClusterRoute = "rt_hltx_ly002_cl06", },
		},
		
		[ "groupSupport" ] = { 
			[ "groupCommand" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", relayRoute = "rt_hltx_ly002_3to0", nextClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", relayRoute = "rt_hltx_ly002_3to1", nextClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", relayRoute = "rt_hltx_ly002_3to2", nextClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", relayRoute = "rt_hltx_ly002_3to4", nextClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", relayRoute = "rt_hltx_ly002_3to5", nextClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl03", relayRoute = "rt_hltx_ly002_3to6", nextClusterRoute = "rt_hltx_ly002_cl06", },
		},
		
		[ "groupMedic" ] = { 
			[ "groupCommand" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", relayRoute = "rt_hltx_ly002_4to0", nextClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", relayRoute = "rt_hltx_ly002_4to1", nextClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", relayRoute = "rt_hltx_ly002_4to2", nextClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", relayRoute = "rt_hltx_ly002_4to3", nextClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", relayRoute = "rt_hltx_ly002_4to5", nextClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl04", relayRoute = "rt_hltx_ly002_4to6", nextClusterRoute = "rt_hltx_ly002_cl06", },
		},
		
		[ "groupIntel" ] = { 
			[ "groupCommand" ]	= { currentClusterRoute = "rt_hltx_ly002_cl05", relayRoute = "rt_hltx_ly002_5to0", nextClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl05", relayRoute = "rt_hltx_ly002_5to1", nextClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl05", relayRoute = "rt_hltx_ly002_5to2", nextClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl05", relayRoute = "rt_hltx_ly002_5to3", nextClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl05", relayRoute = "rt_hltx_ly002_5to4", nextClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl05", relayRoute = "rt_hltx_ly002_5to6", nextClusterRoute = "rt_hltx_ly002_cl06", },
		},
		
		[ "groupMBDev" ] = { 
			[ "groupCommand" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", relayRoute = "rt_hltx_ly002_6to0", nextClusterRoute = "rt_hltx_ly002_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", relayRoute = "rt_hltx_ly002_6to1", nextClusterRoute = "rt_hltx_ly002_cl01", },
			[ "groupDevelop" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", relayRoute = "rt_hltx_ly002_6to2", nextClusterRoute = "rt_hltx_ly002_cl02", },
			[ "groupSupport" ] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", relayRoute = "rt_hltx_ly002_6to3", nextClusterRoute = "rt_hltx_ly002_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", relayRoute = "rt_hltx_ly002_6to4", nextClusterRoute = "rt_hltx_ly002_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", relayRoute = "rt_hltx_ly002_6to5", nextClusterRoute = "rt_hltx_ly002_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly002_cl06", },
		},
	}

	local HELI_TAXI_SETTING_TABLE_LAYOUT_3 = {
		
		[ "groupCommand"  ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat"	]	= { currentClusterRoute = "rt_hltx_ly003_cl00", relayRoute = "rt_hltx_ly003_0to1", nextClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"]	= { currentClusterRoute = "rt_hltx_ly003_cl00", relayRoute = "rt_hltx_ly003_0to2", nextClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"]	= { currentClusterRoute = "rt_hltx_ly003_cl00", relayRoute = "rt_hltx_ly003_0to3", nextClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic"	]	= { currentClusterRoute = "rt_hltx_ly003_cl00", relayRoute = "rt_hltx_ly003_0to4", nextClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel"	]	= { currentClusterRoute = "rt_hltx_ly003_cl00", relayRoute = "rt_hltx_ly003_0to5", nextClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev"	]	= { currentClusterRoute = "rt_hltx_ly003_cl00", relayRoute = "rt_hltx_ly003_0to6", nextClusterRoute = "rt_hltx_ly003_cl06", },
		},
		
		[ "groupCombat" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl01", relayRoute = "rt_hltx_ly003_1to0", nextClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat"	]	= { currentClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"]	= { currentClusterRoute = "rt_hltx_ly003_cl01", relayRoute = "rt_hltx_ly003_1to2", nextClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"]	= { currentClusterRoute = "rt_hltx_ly003_cl01", relayRoute = "rt_hltx_ly003_1to3", nextClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic"	] 	= { currentClusterRoute = "rt_hltx_ly003_cl01", relayRoute = "rt_hltx_ly003_1to4", nextClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel"	] 	= { currentClusterRoute = "rt_hltx_ly003_cl01", relayRoute = "rt_hltx_ly003_1to5", nextClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev"	] 	= { currentClusterRoute = "rt_hltx_ly003_cl01", relayRoute = "rt_hltx_ly003_1to6", nextClusterRoute = "rt_hltx_ly003_cl06", },
		},
		
		[ "groupDevelop" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl02", relayRoute = "rt_hltx_ly003_2to0", nextClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat"	] 	= { currentClusterRoute = "rt_hltx_ly003_cl02", relayRoute = "rt_hltx_ly003_2to1", nextClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly003_cl02", relayRoute = "rt_hltx_ly003_2to3", nextClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic"	]	= { currentClusterRoute = "rt_hltx_ly003_cl02", relayRoute = "rt_hltx_ly003_2to4", nextClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel"	] 	= { currentClusterRoute = "rt_hltx_ly003_cl02", relayRoute = "rt_hltx_ly003_2to5", nextClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev"	] 	= { currentClusterRoute = "rt_hltx_ly003_cl02", relayRoute = "rt_hltx_ly003_2to6", nextClusterRoute = "rt_hltx_ly003_cl06", },
		},
		
		[ "groupSupport" ]  = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl03", relayRoute = "rt_hltx_ly003_3to0", nextClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly003_cl03", relayRoute = "rt_hltx_ly003_3to1", nextClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly003_cl03", relayRoute = "rt_hltx_ly003_3to2", nextClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl03", relayRoute = "rt_hltx_ly003_3to4", nextClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl03", relayRoute = "rt_hltx_ly003_3to5", nextClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl03", relayRoute = "rt_hltx_ly003_3to6", nextClusterRoute = "rt_hltx_ly003_cl06", },
		},
		
		[ "groupMedic" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl04", relayRoute = "rt_hltx_ly003_4to0", nextClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly003_cl04", relayRoute = "rt_hltx_ly003_4to1", nextClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly003_cl04", relayRoute = "rt_hltx_ly003_4to2", nextClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly003_cl04", relayRoute = "rt_hltx_ly003_4to3", nextClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl04", relayRoute = "rt_hltx_ly003_4to5", nextClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl04", relayRoute = "rt_hltx_ly003_4to6", nextClusterRoute = "rt_hltx_ly003_cl06", },
		},
		
		[ "groupIntel" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl05", relayRoute = "rt_hltx_ly003_5to0", nextClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly003_cl05", relayRoute = "rt_hltx_ly003_5to1", nextClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly003_cl05", relayRoute = "rt_hltx_ly003_5to2", nextClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly003_cl05", relayRoute = "rt_hltx_ly003_5to3", nextClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl05", relayRoute = "rt_hltx_ly003_5to4", nextClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl05", relayRoute = "rt_hltx_ly003_5to6", nextClusterRoute = "rt_hltx_ly003_cl06", },
		},
		
		[ "groupMBDev" ] = { 
			[ "groupCommand"]	= { currentClusterRoute = "rt_hltx_ly003_cl06", relayRoute = "rt_hltx_ly003_6to0", nextClusterRoute = "rt_hltx_ly003_cl00", },
			[ "groupCombat" ] 	= { currentClusterRoute = "rt_hltx_ly003_cl06", relayRoute = "rt_hltx_ly003_6to1", nextClusterRoute = "rt_hltx_ly003_cl01", },
			[ "groupDevelop"] 	= { currentClusterRoute = "rt_hltx_ly003_cl06", relayRoute = "rt_hltx_ly003_6to2", nextClusterRoute = "rt_hltx_ly003_cl02", },
			[ "groupSupport"] 	= { currentClusterRoute = "rt_hltx_ly003_cl06", relayRoute = "rt_hltx_ly003_6to3", nextClusterRoute = "rt_hltx_ly003_cl03", },
			[ "groupMedic" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl06", relayRoute = "rt_hltx_ly003_6to4", nextClusterRoute = "rt_hltx_ly003_cl04", },
			[ "groupIntel" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl06", relayRoute = "rt_hltx_ly003_6to5", nextClusterRoute = "rt_hltx_ly003_cl05", },
			[ "groupMBDev" 	] 	= { currentClusterRoute = "rt_hltx_ly003_cl06", },
		},
	}

	local heliTaxiSettings
	Fox.Log( "### Mtbs LayoutCode is "..tostring(vars.mbLayoutCode).. " ###" )	
	if ( vars.mbLayoutCode == 0 ) then
		Fox.Log( "### Refered to Layout Table 0 ###" )	
		heliTaxiSettings = HELI_TAXI_SETTING_TABLE_LAYOUT_0[ currentLandingZoneGroup ][ nextLandingZoneGroup ]
	elseif ( vars.mbLayoutCode == 1 ) then
		Fox.Log( "### Refered to Layout Table 1 ###" )	
		heliTaxiSettings = HELI_TAXI_SETTING_TABLE_LAYOUT_1[ currentLandingZoneGroup ][ nextLandingZoneGroup ]
	elseif ( vars.mbLayoutCode == 2 ) then
		Fox.Log( "### Refered to Layout Table 2 ###" )	
		heliTaxiSettings = HELI_TAXI_SETTING_TABLE_LAYOUT_2[ currentLandingZoneGroup ][ nextLandingZoneGroup ]
	elseif ( vars.mbLayoutCode == 3 ) then
		Fox.Log( "### Refered to Layout Table 3 ###" )	
		heliTaxiSettings = HELI_TAXI_SETTING_TABLE_LAYOUT_3[ currentLandingZoneGroup ][ nextLandingZoneGroup ]
	else
		Fox.Error("### Unknown Mtbs LayoutCode ###")
	end

	Fox.Log( "### heliTaxiSettings ("..tostring(heliTaxiSettings.currentClusterRoute).." , "..tostring(heliTaxiSettings.relayRoute).. " , "..tostring(heliTaxiSettings.nextClusterRoute).. ") ###" )
	if heliTaxiSettings then
		GameObject.SendCommand(
		  gameObjectId,--tex changed from -v-
			--ORIG { type = "TppHeli2", index = 0, },
			{
				id="SetTaxiRoute",
				currentClusterRoute = heliTaxiSettings.currentClusterRoute,
				relayRoute = heliTaxiSettings.relayRoute,
				nextClusterRoute = heliTaxiSettings.nextClusterRoute,
			}
		)
	else
		Fox.Log( " ### this.RequestHeliTaxi(): ignore operation because heliTaxiSettings is nil. ### " )
	end
	return heliTaxiSettings--tex
end







function mtbs_helicopter.GetHeliStartClusterId()
	return mvars.mbHelicopter_startClusterId
end




function mtbs_helicopter.GetHeliStartPlatformId()
	return mvars.mbHelicopter_startPlatformId
end




function mtbs_helicopter.IsHeliStartHeliport()
	return mvars.mbHelicopter_startIsHeliport
end








mtbs_helicopter._SetClusterId = function()
	
	local missionId = TppMission.GetMissionID()
	
	
	if missionId == 30050 or missionId == 30150 or missionId == 30250 then
		mvars.mbHelicopter_startClusterId, mvars.mbHelicopter_startPlatformId, mvars.mbHelicopter_startIsHeliport = mtbs_helicopter._GetClusterId()
	
	elseif missionId == 50050 then
		mvars.mbHelicopter_startClusterId	= MotherBaseStage.GetFirstCluster() + 1
		mvars.mbHelicopter_startPlatformId	= 1
		mvars.mbHelicopter_startIsHeliport	= false
	end
	
end




mtbs_helicopter._GetClusterId = function()
	if gvars.heli_missionStartRoute ~= 0 then
		for clusterId, clusterData in ipairs( mtbs_helicopter.clusterHeliRouteTable ) do
			for i, params in pairs( clusterData ) do
				local route = StrCode32( params.routeId )
				if route == gvars.heli_missionStartRoute then
					local isHeliport = params.isHeliport or false
					return clusterId, params.platformId, isHeliport
				end
			end
		end
	end
	return DEFAULT_CLUSTER_ID, DEFAULT_PLATFORM_ID, false
end

return mtbs_helicopter

