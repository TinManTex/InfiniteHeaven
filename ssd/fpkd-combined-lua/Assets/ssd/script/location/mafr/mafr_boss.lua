


local  mafr_boss = {}

mafr_boss.baseList = {
	
	"mafr_diamond",
}




mafr_boss.stealthAreaNameTable = {
	[ Fox.StrCode32("mafr_diamond") ] = {
		[ Fox.StrCode32( "Gluttony" ) ] = "coop_location_mafr_1_stealth_area_1",	
		[ Fox.StrCode32( "Aerial" ) ] = "coop_location_mafr_1_stealth_area_2",	
	},
}




mafr_boss.aerialRouteTable = {
	[ Fox.StrCode32("mafr_diamond") ] = {},
}
for i = 0, 9 do
	table.insert( mafr_boss.aerialRouteTable[ Fox.StrCode32("mafr_diamond") ], string.format( "HuntDown%04d", i ) )
end
for i = 0, 6 do
	table.insert( mafr_boss.aerialRouteTable[ Fox.StrCode32("mafr_diamond") ], string.format( "RoomHuntDown%04d", i ) )
end




mafr_boss.OnActiveSmallBlockTable = {
	diamond = {	
		activeArea = { 142, 119, 145, 124 },
		OnActive = function()
		end,
	},
}




function mafr_boss.OnActiveFunction( baseNameHash )
	
	mvars.loc_stealthAreaNameTable	= mafr_boss.stealthAreaNameTable[baseNameHash]
	
	mvars.loc_aerialRouteTable		= mafr_boss.aerialRouteTable[baseNameHash]
end

function mafr_boss.OnInitialize()
	Fox.Log("mafr_boss.OnInitialize()")
	StageBlock.AddLargeBlockNameForMessage( mafr_boss.baseList )
	TppLocation.RegistBossAssetInitializeTable( mafr_boss.OnActiveFunction, mafr_boss.OnActiveSmallBlockTable )
end

return mafr_boss
