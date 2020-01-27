


local  afgh_boss = {}

afgh_boss.baseList = {
	
	"afgh_field",
	"afgh_village",
}




afgh_boss.stealthAreaNameTable = {
	[ Fox.StrCode32("afgh_field") ] = {
		[ Fox.StrCode32( "Gluttony" ) ]		= "coop_location_afgh_1_stealth_area_1",	
		[ Fox.StrCode32( "Aerial" ) ]		= "coop_location_afgh_1_stealth_area_2",	
	},
	[ Fox.StrCode32("afgh_village") ] = {
		[ Fox.StrCode32( "Gluttony" ) ] 	= "coop_location_afgh_2_stealth_area_2",	
		[ Fox.StrCode32( "Aerial" ) ]		= "coop_location_afgh_2_stealth_area_1",	
	},
}




afgh_boss.aerialRouteTable = {
	[ Fox.StrCode32("afgh_village") ] = {
		
		"HuntDown0001",
		"HuntDown0002",
		"HuntDown0003",
		
		"HuntDown0005",
		"HuntDown0006",
		"HuntDown0007",
		"HuntDown0008",
		"HuntDown0009",
		"HuntDown0010",
		"HuntDown0011",
		"HuntDown0012",
		"HuntDown0013",
		
		
		
		
		"RoomHuntDown0004",
		"RoomHuntDown0005",
		"RoomHuntDown0006",
		"RoomHuntDown0007",
		"RoomHuntDown0008",
		"RoomHuntDown0009",
		"RoomHuntDown0010",
	},
}




afgh_boss.OnActiveSmallBlockTable = {
	field = {	
		activeArea = { 135, 149, 136, 151 },
		OnActive = function()
		end,
	},
	village = {	
		activeArea = { 136, 141, 137, 142 },
		OnActive = function()
		end
	},
}




function afgh_boss.OnActiveFunction( baseNameHash )
	
	mvars.loc_stealthAreaNameTable	= afgh_boss.stealthAreaNameTable[baseNameHash]
	
	mvars.loc_aerialRouteTable		= afgh_boss.aerialRouteTable[baseNameHash]
end

function afgh_boss.OnInitialize()
	Fox.Log("afgh_boss.OnInitialize()")
	StageBlock.AddLargeBlockNameForMessage( afgh_boss.baseList )
	TppLocation.RegistBossAssetInitializeTable( afgh_boss.OnActiveFunction, afgh_boss.OnActiveSmallBlockTable )
end

return afgh_boss
