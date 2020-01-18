local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table






local INTEL_LOCATOR_NAME = {
	SAVANNAH					= "GetIntel_savannah",												
	PFCAMPNORTH 				= "GetIntel_pfCampNorth",											
	PFCAMPEAST 					= "GetIntel_pfCampEast",											
	SWAMPEAST 					= "GetIntel_swampEast",												
}




this.demoList = {
	Demo_ParasiteAppearance		= "p41_050010",														
	Demo_TargetEscape			= "p41_050020_000_final",											
}




this.demoBlockList = {
	Demo_GetIntel				= { "/Assets/tpp/pack/mission2/story/s10090/s10090_d01.fpk" },		
	Demo_ParasiteAppearance		= { "/Assets/tpp/pack/mission2/story/s10090/s10090_d02.fpk" },		
	Demo_TargetEscape			= { "/Assets/tpp/pack/mission2/story/s10090/s10090_d03.fpk" },		
}






local PARASITE_DEMO_GROUP = {
	"veh_wav_0000",
	"veh_wav_0001",
	"veh_trc_0000",
	"veh_lv_0000",
}


local ESCAPE_DEMO_GROUP = {
	"veh_wav_0000",
	"veh_wav_0001",
	"veh_trc_0000",
	"sol_ZRS_demo_0000",
	"sol_ZRS_demo_0001",
}






this.TargetEscape = function(func)
	Fox.Log("#### s10090_demo.TargetEscape ####")
	
	TppDemo.SpecifyIgnoreNpcDisable( ESCAPE_DEMO_GROUP )
	
	TppDemo.Play( "Demo_TargetEscape",
				{
					onEnd = function()
						func()
					end,
				},
				{
					useDemoBlock	= true,					
					startNoFadeIn	= true,
					finishFadeOut	= true,					
					isExecGameOver	= true,					
					isSnakeOnly     = false,
				}
	)
end


this.ParasiteAppearance = function(func)
	Fox.Log("#### s10090_demo.ParasiteAppearance ####")
	local gameObjectName = s10090_enemy.VEHICLE_NAME.TRUCK_TARGET
	local position = s10090_enemy.GetVehiclePosition( gameObjectName )
	local rotQuat = Quat.RotationY( math.atan2( position:GetX() - vars.playerPosX, position:GetZ() - vars.playerPosZ ) + TppMath.DegreeToRadian( 45 ) - foxmath.PI )
	local wavId_01 = GameObject.GetGameObjectId( "TppVehicle2", "veh_wav_0000" )
	local wavId_02 = GameObject.GetGameObjectId( "TppVehicle2", "veh_wav_0001" )
	local lvId = GameObject.GetGameObjectId( "TppVehicle2", "veh_lv_0000" )
	

	TppDemo.SpecifyIgnoreNpcDisable( "veh_trc_0000" )
	
	if GameObject.SendCommand( wavId_01 , { id="IsAlive", } ) then
		TppDemo.SpecifyIgnoreNpcDisable( "veh_wav_0000" )
	else
		Fox.Log("veh_wav_0000 is broken or recover ... Nothing Done !!")
	end
	
	if GameObject.SendCommand( wavId_02 , { id="IsAlive", } ) then
		TppDemo.SpecifyIgnoreNpcDisable( "veh_wav_0001" )
	else
		Fox.Log("veh_wav_0001 is broken or recover ... Nothing Done !!")
	end
	
	if GameObject.SendCommand( lvId , { id="IsAlive", } ) then
		TppDemo.SpecifyIgnoreNpcDisable( "veh_lv_0000" )
	else
		Fox.Log("veh_lv_0000 is broken or recover ... Nothing Done !!")
	end
	
	DemoDaemon.SetDemoTransform( this.demoList.Demo_ParasiteAppearance, rotQuat, position )
	
	TppDemo.Play( "Demo_ParasiteAppearance",
							{
								onEnd = function()
									func()
								end,
							},
							{
								useDemoBlock	 = true,	
								isSnakeOnly     = false,
							}
	)
end


this.GetIntel_savannah = function(func)
	Fox.Log("#### s10090_demo.GetIntel_savannah ####")
	TppDemo.PlayGetIntelDemo(
							{
								onEnd = function()
									func()
								end,
							},
							"GetIntelIdentifier",
							INTEL_LOCATOR_NAME.SAVANNAH,
							{
								useDemoBlock	 = true,	
							}
	)
end


this.GetIntel_pfCampNorth = function(func)
	Fox.Log("#### s10090_demo.GetIntel_pfCampNorth ####")
	TppDemo.PlayGetIntelDemo(
							{
								onEnd = function()
									func()
								end,
							},
							"GetIntelIdentifier",
							INTEL_LOCATOR_NAME.PFCAMPNORTH,
							{
								useDemoBlock	 = true,	
							}
	)
end


this.GetIntel_pfCampEast = function(func)
	Fox.Log("#### s10090_demo.GetIntel_pfCampEast ####")
	TppDemo.PlayGetIntelDemo(
							{
								onEnd = function()
									func()
								end,
							},
							"GetIntelIdentifier",
							INTEL_LOCATOR_NAME.PFCAMPEAST,
							{
								useDemoBlock	 = true,	
							}
	)
end

this.GetIntel_swampEast = function(func)
	Fox.Log("#### s10090_demo.GetIntel_swampEast ####")
	TppDemo.PlayGetIntelDemo(
							{
								onEnd = function()
									func()
								end,
							},
							"GetIntelIdentifier",
							INTEL_LOCATOR_NAME.SWAMPEAST,
							{
								useDemoBlock	 = true,	
							}
	)
end




return this
