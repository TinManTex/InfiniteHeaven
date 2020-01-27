InfCore.Log("!!!!!!!!!!----cypr_mission_block.lua")--DEBUGNOW
local cypr_mission_block = {}

local CYPRUS_SMALL_MISSION_BLOCK_LIST = {
	"cypr_small_mission_block_1",
	"cypr_small_mission_block_2",
	"cypr_small_mission_block_3",
}
local CYPRUS_DEMO_BLOCK = "cypr_demo_block"

cypr_mission_block.GetSmallMissionPackageLabel = function( index, step )
	return "cypr_small_mission_" .. tostring( index ) .. "_" .. tostring( step )
end

cypr_mission_block.GetDemoPackageLabel = function( step )
	return "cypr_demo_" .. tostring( step )
end

local missionPackTable = {
	[ CYPRUS_SMALL_MISSION_BLOCK_LIST[ 1 ] ] = {
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 1 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 2 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 3 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 4 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 5 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 6 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s04.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 7 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s04.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 8 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s04.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 9 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON,
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s04.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 10 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s04.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 11 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s07.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 12 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s07.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 13 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 21 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s01.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 31 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s07.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 32 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_snake_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_miller_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_paz_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_chico_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_snake_cypr.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_msx.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s11.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 33 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s12.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 34 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s12.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 1, 35 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s12.fpk",
		},
	},
	[ CYPRUS_SMALL_MISSION_BLOCK_LIST[ 2 ]  ] = {
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 1 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 2 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 3 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 4 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 5 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 6 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 7 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 8 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 9 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 10 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s05.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 11 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s05.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 12 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s05.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 13 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 21 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s02.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 31 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s05.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 32 ) ] = {
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s05.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 33 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s13.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 34 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s13.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 2, 35 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s05.fpk",
		},
	},
	[ CYPRUS_SMALL_MISSION_BLOCK_LIST[ 3 ]  ] = {
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 1 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_cypr_title.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s09.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 2 ) ] = {
			TppDefine.MISSION_COMMON_PACK.VOLGIN,
			TppDefine.MISSION_COMMON_PACK.WEST_WAV_CANNON,
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s04.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 3 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 4 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 5 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 6 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 7 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 8 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 9 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s03.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 10 ) ] = {
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s06.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 11 ) ] = {
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s06.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 12 ) ] = {
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s06.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 13 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s12.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 21 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s11.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 31 ) ] = {
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s06.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 32 ) ] = {
			TppDefine.MISSION_COMMON_PACK.ENEMY_HELI,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s10.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 33 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s14.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 34 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s14.fpk",
		},
		[ cypr_mission_block.GetSmallMissionPackageLabel( 3, 35 ) ] = {
			TppDefine.MISSION_COMMON_PACK.AMBULANCE,
			TppDefine.MISSION_COMMON_PACK.HELICOPTER,
			"/Assets/tpp/pack/mission2/story/s10010/s10010_s06.fpk",
		},
	},
	[ CYPRUS_DEMO_BLOCK ] = {
		[ cypr_mission_block.GetDemoPackageLabel( 1 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d01.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 2 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d02.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 3 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_xof_soldier.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d03.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 4 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d04.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 5 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d05.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 6 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d06.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 7 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d07.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 8 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d08.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 9 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
			"/Assets/tpp/pack/mission2/common/veh_mc_west_wav_trt_cannon.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d09.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 10 ) ] = {
			"/Assets/tpp/pack/mission2/common/veh_mc_west_lv.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d10.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 11 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d11.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 12 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_mantis.fpk",
			"/Assets/tpp/pack/mission2/story/s10010/s10010_d11.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 13 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10010/s10010_avatar_ex.fpk",
			TppDefine.MISSION_COMMON_PACK.AVATAR_EDIT,
		},
		[ cypr_mission_block.GetDemoPackageLabel( 21 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10280/s10280_d01.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 31 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10280/s10280_d11.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 32 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10280/s10280_d12.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 33 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_snake_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_miller_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_doctor.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_nurse.fpk",
			"/Assets/tpp/pack/mission2/story/s10280/s10280_d13.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 34 ) ] = {
			"/Assets/tpp/pack/mission2/common/mis_com_snake_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_miller_gz.fpk",
			"/Assets/tpp/pack/mission2/common/mis_com_dd_soldier_gz.fpk",
			"/Assets/tpp/pack/mission2/story/s10280/s10280_d14.fpk",
		},
		[ cypr_mission_block.GetDemoPackageLabel( 35 ) ] = {
			"/Assets/tpp/pack/mission2/story/s10280/s10280_d15.fpk",
		},
	},
}

for i, packagePath in ipairs( TppDefine.MISSION_COMMON_PACK.AVATAR_ASSET_LIST ) do
	table.insert( missionPackTable[ CYPRUS_SMALL_MISSION_BLOCK_LIST[ 3 ] ][ cypr_mission_block.GetSmallMissionPackageLabel( 3, 13 ) ], packagePath )
end




cypr_mission_block.IsCompleteLoading = function()
	for blockName, packageTable in pairs( missionPackTable ) do
		local state = ScriptBlock.GetScriptBlockState( ScriptBlock.GetScriptBlockId( blockName ) )
		if DEBUG then
			DebugText.Print( DebugText.NewContext(), {0.5, 0.5, 1.0}, "cypr_mission_block.IsCompleteLoading(): state:" .. tostring( state ) )
			
		end
		if state ~= ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE then
			return false
		end

	end

	return true

end





cypr_mission_block.OnInitialize = function()

	Fox.Log( "cypr_mission_block.OnInitialize()" )

	for blockName, packageTable in pairs( missionPackTable ) do
		Fox.Log( "cypr_mission_block.OnInitialize(): blockName:" .. tostring( blockName ) )
		TppScriptBlock.RegisterCommonBlockPackList( blockName, packageTable )
	end

end




cypr_mission_block.LoadSmallMissionBlock = function( step )

	Fox.Log( "cypr_mission_block.LoadSmallMissionBlock()" )

	for i, missionBlockName in ipairs( CYPRUS_SMALL_MISSION_BLOCK_LIST ) do
		TppScriptBlock.Load( missionBlockName, cypr_mission_block.GetSmallMissionPackageLabel( i, step ), true, true )
	end

end




cypr_mission_block.SetLoadStep = function( step )

	Fox.Log( "cypr_mission_block.SetLoadStep(): step:" .. tostring( step ) )

	
	
	--DEBUGNOW cypr_mission_block.LoadSmallMissionBlock( step )

	
	TppScriptBlock.Load( CYPRUS_DEMO_BLOCK, cypr_mission_block.GetDemoPackageLabel( step ), true, true )

end

return cypr_mission_block
