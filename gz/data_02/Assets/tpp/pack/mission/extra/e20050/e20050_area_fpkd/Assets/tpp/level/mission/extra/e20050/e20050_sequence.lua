local this = {}





this.missionID					= 20050			
this.CP_ID						= "e20050_cp"

this.MISSILE_ID					= "WP_ms02"
this.CHARACTER_ID_HELICOPTER	= "SupportHelicopter"




this.RequiredFiles = {
	"/Assets/tpp/script/common/GZCommon.lua",
}

this.Sequences = {
	{ "Seq_MissionPrepare" },
	{ "Seq_MissionSetup" },
	{ "Seq_LoadOpeningDemo" },
	{ "Seq_OpeningShowTransition" },
	{ "Seq_OpeningDemo" },
	{ "Seq_DestroyTarget1" },				
	{ "Seq_DestroyTarget2" },				
	{ "Seq_CallSupportHelicopter" },		
	{ "Seq_Escape" },						
	{ "Seq_PlayerRideHelicopter" },			
	{ "Seq_PlayMissionClearDemo" },			
	{ "Seq_MissionClearShowTransition" },
	{ "Seq_MissionClear" },
	{ "Seq_MissionFailedRideHelicopter" },
	{ "Seq_MissionFailedTimeOver" },
	{ "Seq_MissionFailedOutsideMissionArea" },
	{ "Seq_MissionFailedPlayerDead" },
	{ "Seq_MissionFailedHelicopterDead" },
	{ "Seq_MissionGameOver" },
	{ "Seq_ShowClearReward" },
	{ "Seq_MissionEnd" },
}

this.OnStart = function( manager )





	GZCommon.Register( this, manager )
	TppMission.Setup()

	

end


this.ChangeExecSequenceList =  {
	"Seq_OpeningDemo",
	"Seq_DestroyTarget1",
	"Seq_DestroyTarget2",
	"Seq_CallSupportHelicopter",
	"Seq_Escape",
	"Seq_PlayerRideHelicopter",
}


local IsChangeExecSequence = function()
	local sequence = TppSequence.GetCurrentSequence()

	for i = 1, #this.ChangeExecSequenceList do
		if sequence == this.ChangeExecSequenceList[i] then
			return true
		end
	end
	return false
end


local IsDemoAndEventBlockActive = function()

	
	if ( TppMission.IsDemoBlockActive() == false ) then
		return false
	end

	
	if ( TppMission.IsEventBlockActive() == false ) then
		return false
	end

	
	if ( TppVehicleBlockControllerService.IsHeliBlockExist() ) then
		
		if ( TppVehicleBlockControllerService.IsHeliBlockActivated() == false ) then
			return false
		end
	end

	
	if ( MissionManager.IsMissionStartMiddleTextureLoaded() == false ) then
		return false
	end

	
	local hudCommonData = HudCommonDataManager.GetInstance()
	if hudCommonData:IsEndLoadingTips() == false then
			hudCommonData:PermitEndLoadingTips() 
			return false
	end

	return true

end

this.OnEnterCommon = function()

	local sequence = TppSequence.GetCurrentSequence()



	if IsChangeExecSequence() then
		TppMission.ChangeState( "exec" )
	end
end

this.OnLeaveCommon = function()

	local sequence = TppSequence.GetCurrentSequence()




end

this.OnSkipEnterCommon = function( manager )





	
	local sequence = TppSequence.GetCurrentSequence()

	
	if 	sequence == "Seq_MissionFailedRideHelicopter" or
		sequence == "Seq_MissionFailedTimeOver" or
		sequence == "Seq_MissionFailedOutsideMissionArea" or
		sequence == "Seq_MissionFailedPlayerDead" then						

		TppMission.ChangeState( "failed" )										

	elseif sequence == "Seq_MissionClear" then								
		TppMission.ChangeState( "clear" )										
	end

	
	this.commonLoadDemoBlock()	

end

this.OnSkipUpdateCommon = function()

	
	return IsDemoAndEventBlockActive()

end

this.OnSkipLeaveCommon = function()





	local sequence = TppSequence.GetCurrentSequence()
	if TppSequence.IsGreaterThan( sequence, "Seq_DestroyTarget1" ) then

		TppMission.SetFlag( "isAntiAirRouteSet", true )
		TppMission.SetFlag( "isAntiLandRouteSet", true )

	end
	if TppSequence.IsGreaterThan( sequence, "Seq_DestroyTarget2" ) then
		TppMission.SetFlag( "isArmoredVehicle0000Destroyed", true )
	end
	if sequence == "Seq_DestroyTarget1" then
		TppMission.SetFlag( "isOpeningDemoSkipped", true )
	end
	if sequence == "Seq_DestroyTarget2" then
		
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20050_count" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_aircraftgun' )
	end
	if sequence == "Seq_CallSupportHelicopter" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20050_count" )
	end
	if sequence == "Seq_Escape" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20050_count" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_count_al' )
	end
	if sequence == "Seq_PlayMissionClearDemo" then
		TppHelicopter.Call( "RV_SeaSide" )	
	end

	if sequence ~= "Seq_MissionPrepare" then
		this.onCommonMissionSetup()				

		
		this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )



		
	end

	
	TppSupportHelicopterService.SetDefaultRendezvousPointMarker( "RV_SeaSide" )

end


this.OnAfterRestore = function()

	local sequence = TppSequence.GetCurrentSequence()
	if sequence == "Seq_DestroyTarget1" then

	elseif sequence == "Seq_DestroyTarget2" then
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_aircraftgun' )
	elseif sequence == "Seq_Escape" then
		TppHelicopter.Call( "RV_SeaSide" )					
	end

	



	TppRadio.RestoreIntelRadio()
	
	this.commonIntelCheck("Hostage_e20050_000")
	this.commonIntelCheck("Hostage_e20050_001")
	this.commonIntelCheck("Hostage_e20050_002")
	this.commonIntelCheck("Hostage_e20050_003")

	GZCommon.CheckContinueHostageRegister( this.ContinueHostageRegisterList )

end


this.commonMissionCleanUp = function()

	
	GZCommon.MissionCleanup()

	
	FadeFunction.ResetFadeColor()

	
	

	
	TppMusicManager.EndSceneMode()

	
	TppPadOperatorUtility.ResetMasksForPlayer( 0, "CameraOnly")

	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:EraseDisplayTimer()

	
	TppRadioConditionManagerAccessor.Unregister( "Tutorial" )	 
	TppRadioConditionManagerAccessor.Unregister( "Basic" )

	
	GzRadioSaveData.ResetSaveRadioId()
	local radioManager = RadioDaemon:GetInstance()
	radioManager:DisableAllFlagIsMarkAsRead()
	radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()

	GzRadioSaveData.ResetSaveEspionageId()

end


this.onCommonMissionSetup = function()





	GZCommon.MissionSetup()													

	
	TppClock.SetTime( "07:10:00" )
	
	TppClock.Stop()
	TppWeather.SetWeather( "sunny" )
	WeatherManager.RequestTag("default", 0 )
	TppEffectUtility.RemoveColorCorrectionLut()
	
	GrTools.SetLightingColorScale(4.0)

	
	
	
	this.commonDisableAllMarker() 

	
	TppEnemy.RegisterRouteSet( this.CP_ID, "sneak_day", "e20050_route_d01" )			
	TppEnemy.RegisterRouteSet( this.CP_ID, "caution_day", "e20050_route_c01" )		
	TppEnemy.RegisterRouteSet( this.CP_ID, "hold", "e20050_route_r01" )				

	
	local hardmode = TppGameSequence.GetGameFlag("hardmode")
	if ( hardmode ) then
		TppPlayer.SetWeapons( GZWeapon.e20050_SetWeaponsHard )
	else
		TppPlayer.SetWeapons( GZWeapon.e20050_SetWeapons )
	end

	
	

	
	
	
	TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_000" )
	TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_001" )
	TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_002" )
	TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_003" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_000" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_001" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_002" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_003" )
	TppRadio.EnableIntelRadio( "IntelRadio_Claymore" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_000" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_001" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_002" )
	TppRadio.EnableIntelRadio( "WoodTurret01" )
	TppRadio.EnableIntelRadio( "WoodTurret02" )
	TppRadio.EnableIntelRadio( "WoodTurret03" )
	TppRadio.EnableIntelRadio( "WoodTurret04" )
	TppRadio.EnableIntelRadio( "WoodTurret05" )
	TppRadio.EnableIntelRadio( "e20050_drum0002" )
	TppRadio.EnableIntelRadio( "e20050_drum0003" )
	TppRadio.EnableIntelRadio( "e20050_drum0004" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0002" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0005" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0011" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0012" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0015" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0019" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0020" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0021" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0022" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0023" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0024" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0025" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0027" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0028" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0029" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0030" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0031" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0035" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0037" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0038" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0039" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0040" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0041" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0042" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0043" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0044" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0045" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0046" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0047" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0048" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0065" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0066" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0068" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0069" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0070" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0071" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0072" )
	TppRadio.EnableIntelRadio( "gntnCom_drum0101" )
	TppRadio.EnableIntelRadio( "e20050_SecurityCamera_01" )
	TppRadio.EnableIntelRadio( "e20050_SecurityCamera_02" )
	TppRadio.EnableIntelRadio( "e20050_SecurityCamera_03" )
	TppRadio.EnableIntelRadio( "e20050_SecurityCamera_04" )
	TppRadio.EnableIntelRadio( "e20050_SecurityCamera_05" )
	
	TppRadio.EnableIntelRadio( "Tactical_Vehicle_WEST_000" )
	TppRadio.EnableIntelRadio( "Tactical_Vehicle_WEST_001" )
	TppRadio.EnableIntelRadio( "Cargo_Truck_WEST_000" )
	TppRadio.EnableIntelRadio( "Cargo_Truck_WEST_001" )
	TppRadio.EnableIntelRadio( "Cargo_Truck_WEST_002" )

	
	TppRadio.DisableIntelRadio( "intel_f0090_esrg0190" )
	TppRadio.DisableIntelRadio( "intel_f0090_esrg0200" )

	
	TppRadio.SetAllSaveRadioId()

	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager ~= NULL then
		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData ~= NULL then

			luaData:ResetMisionInfoCurrentStoryNo() 

			
			luaData:EnableMissionPhotoId(10)
			luaData:EnableMissionPhotoId(20)
			luaData:EnableMissionPhotoId(30)
			luaData:EnableMissionPhotoId(40)

			
			luaData:SetupIconUniqueInformationTable(
				{ markerId = "gntn_area01_antiAirGun_000",		langId = "marker_info_gimmick_weapon" },
				{ markerId = "gntn_area01_antiAirGun_001",		langId = "marker_info_gimmick_weapon" },
				{ markerId = "gntn_area01_antiAirGun_002",		langId = "marker_info_gimmick_weapon" },
				{ markerId = "gntn_area01_antiAirGun_003",		langId = "marker_info_gimmick_weapon" },

				{ markerId = "Tactical_Vehicle_WEST_000",		langId = "marker_info_vehicle_4wd" },
				{ markerId = "Tactical_Vehicle_WEST_001",		langId = "marker_info_vehicle_4wd" },
				{ markerId = "Cargo_Truck_WEST_000",			langId = "marker_info_truck" },
				{ markerId = "Cargo_Truck_WEST_001",			langId = "marker_info_truck" },
				{ markerId = "Cargo_Truck_WEST_002",			langId = "marker_info_truck" },
				{ markerId = "Armored_Vehicle_WEST_000",		langId = "marker_info_APC" },

				{ markerId = "e20050_marker_c4_0000",			langId = "marker_info_weapon_06" },
				{ markerId = "e20050_marker_c4_0001",			langId = "marker_info_weapon_06" },
				{ markerId = "e20050_marker_c4_0002",			langId = "marker_info_weapon_06" },
				{ markerId = "e20050_marker_claymore0000",		langId = "marker_info_weapon_08" },
				{ markerId = "e20050_marker_grenade0000",		langId = "marker_info_weapon_07" },
				{ markerId = "e20050_marker_grenade0001",		langId = "marker_info_weapon_07" },
				{ markerId = "e20050_marker_grenade0002",		langId = "marker_info_weapon_07" },
				{ markerId = "e20050_marker_grenade0003",		langId = "marker_info_weapon_07" },
				{ markerId = "e20050_marker_ms0000",			langId = "marker_info_weapon_02" },
				{ markerId = "e20050_marker_ms0001",			langId = "marker_info_weapon_02" },
				{ markerId = "e20050_marker_shotgun0000",		langId = "marker_info_weapon_03" },
				{ markerId = "e20050_marker_smokegrenades0000",	langId = "marker_info_weapon_05" },
				{ markerId = "e20050_marker_sniperrifle0000",	langId = "marker_info_weapon_01" },
				{ markerId = "e20050_marker_submachinegun0000",	langId = "marker_info_weapon_04" },
				{ markerId = "e20050_marker_submachinegun0001",	langId = "marker_info_weapon_04" },
				{ markerId = "e20050_marker_tranq0000",			langId = "marker_info_bullet_tranq" },
				{ markerId = "e20050_marker_tranq0001",			langId = "marker_info_bullet_tranq" },
				{ markerId = "e20050_marker_tranq0002",			langId = "marker_info_bullet_tranq" },
				{ markerId = "e20050_marker_tranq0003",			langId = "marker_info_bullet_tranq" },
				{ markerId = "common_marker_Area_EastCamp",		langId="marker_info_area_00" },					
				{ markerId = "common_marker_Area_WestCamp",		langId="marker_info_area_01" },					
				{ markerId = "common_marker_Area_WareHouse",	langId="marker_info_area_02" },					
				{ markerId = "common_marker_Area_HeliPort",		langId="marker_info_area_03" },					
				{ markerId = "common_marker_Area_Center",		langId="marker_info_area_04" },					
				{ markerId = "common_marker_Area_Asylum",		langId="marker_info_area_05" }					
				,{ markerId="common_marker_Armory_WareHouse",	langId="marker_info_place_armory" }				
				,{ markerId="common_marker_Armory_HeliPort",	langId="marker_info_place_armory" }				
				,{ markerId="common_marker_Armory_Center",		langId="marker_info_place_armory" }				
			)

		end
	end

	
	TppGimmick.OpenDoor( "Paz_PickingDoor00", 270 )

	if TppMission.GetFlag( "isAntiAirRouteSet" ) == true then				
		this.commonSetPhaseToKeepCaution( true )										
	end

	if TppMission.GetFlag( "isAntiLandRouteSet" ) == true then				
		this.commonChangeToAntiLandRouteSet( true )									
	end

	this.commonRestoreRoute()												

	MissionManager.SetMiddleTextureWaitParameter( 0.5, 5 )					

	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0058", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0059", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0060", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0062", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0063", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0064", { noForceUpdate = false, }  )

	
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0068", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0069", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0070", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0074", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0075", { noForceUpdate = false, }  )
	TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0076", { noForceUpdate = false, }  )

	
	TppVehicleUtility.SetCrashActionMode( "Armored_Vehicle_WEST_000", false )

	
	TppCommandPostObject.GsAddRespawnRandomWeaponId( this.CP_ID, "WP_sg01_v00", 10 )
	TppCommandPostObject.GsAddRespawnRandomWeaponId( this.CP_ID, "WP_ms02", 5 )

	
	FadeFunction.ResetFadeColor()

	TppMission.OnLeaveInnerArea( function() TppRadio.Play( "Radio_WarningMissionArea" ) end )
	TppMission.OnLeaveOuterArea( function()
		local sequence = TppSequence.GetCurrentSequence()
		if	sequence == "Seq_DestroyTarget1" or
			sequence == "Seq_DestroyTarget2" or
			sequence == "Seq_CallSupportHelicopter" or
			sequence == "Seq_Escape" then
			TppMission.ChangeState( "failed", "OutsideMissionArea" )
		end
	end )	

	TppMission.SetFlag( "isPlayerInMinefield", false )
	TppMission.SetFlag( "isVehicleInMinefield", false )
	TppMission.SetFlag( "isPlayerInClaymoreRadioTrap", false )
	TppMission.SetFlag( "isCountdownStarted", false )			

	
	this.CounterList.HeliReachDemoCount = 0
	this.CounterList.playerInDeathTrap0000 = false

end




this.MissionFlagList = {

	
	isMissionStartRadioPlayed			= false,				
	isMissionBackgroundRadio1Played		= false,				
	isMissionBackgroundRadio2Played		= false,				
	isMissionBackgroundRadio4Played		= false,				
	isCautionRadioPlayed				= false,				
	isHostageDialogue0000Played			= false,				
	isHostageDialogue0001Played			= false,				
	isHostageDialogue0002Played			= false,				
	isVehicleIntelRadioPlayed			= false,				
	isBackGroundRadioWait				= false,				
	isClaymoreRadioPlayed				= false,				
	isEmptyAmmoRadioPlayed				= false,
	isHostage0003Talk1Played			= false,				
	isHostage0003Talk2Played			= false,				
	isCountdownStarted					= false,				

	
	isAntiLandRouteSet					= false,				
	isAntiAirRouteSet					= false,				

	
	isAntiAirGun0000Destroyed			= false,				
	isAntiAirGun0001Destroyed			= false,				
	isAntiAirGun0002Destroyed			= false,				
	isAntiAirGun0003Destroyed			= false,				

	isWoodTurret0000Destroyed			= false,				
	isWoodTurret0001Destroyed			= false,				
	isWoodTurret0002Destroyed			= false,				
	isWoodTurret0003Destroyed			= false,				
	isWoodTurret0004Destroyed			= false,				

	
	isArmoredVehicle0000Destroyed		= false,				

	isTruck0000Destroyed				= false,				
	isTruck0001Destroyed				= false,				
	isTruck0002Destroyed				= false,				

	isVehicle0000Destroyed				= false,				
	isVehicle0001Destroyed				= false,				

	isFinishLightVehicleGroup			= false,				
	isLightVechicleStarted				= false,				

	isCarTutorial						= false,				
	isAVMTutorial						= false,				

	isHeliLandNow						= false,				

	
	isC4EquipRadioPlayed				= false,				
	isC4PlaceRadioPlayed				= false,				
	isPrimaryWPIcon						= false,				

	
	isPlayerInMinefield					= false,				
	isVehicleInMinefield				= false,				
	isPlayerInClaymoreRadioTrap			= false,
	isOpeningDemoSkipped				= false,

	
	isSwitchLightDemo				= false,
}




this.DemoList = {
	Demo_Opening 						= "p12_040000_000",	
	Demo_MissionClear					= "p12_040010_000",	
	Demo_MissionClear_NotSmooth			= "p12_040015_000",	
	Demo_MissionFailure 				= "p12_040020_000",	
	Demo_MissionFailureNoPlayerReaction	= "p12_040030_000",	
	Demo_AreaEscapeNorth				= "p11_020010_000",	
	Demo_AreaEscapeWest					= "p11_020020_000",	
	Demo_SwitchLight					= "p11_020003_000",		
}




this.CounterList = {
	GameOverRadioName		= "NoRadio",							
	GameOverFadeTime		= GZCommon.FadeOutTime_MissionFailed,	
	lastRendezvouzPoint		= "",									
	currentWeapon			= "WP_ar00_v03",
	HeliReachDemoCount		= 0,
	playerInDeathTrap0000	= false,
}




this.RadioList = {
	
	Radio_MissionStart					= "e0050_rtrg0010",			
	Radio_MissionStartForSkip			= "e0050_rtrg0008",			
	Radio_MissionBackground1			= "e0050_rtrg0160",			
	Radio_MissionBackground2			= "e0050_rtrg0161",			
	Radio_MissionBackground3			= "e0050_rtrg0162",			
	Radio_MissionBackground4			= "e0050_rtrg0165",			
	Radio_Caution						= "e0050_rtrg0120",			
	Radio_AntiAirGunDestroyed			= "e0050_rtrg0040",			
	Radio_AntiAirGunDestroyedHalf		= "e0050_rtrg0043",			
	Radio_AntiAirGunDestroyedLastOne	= "e0050_rtrg0045",			
	Radio_PlayerPickUpWeapon_WP_ms02	= { "e0050_rtrg0050", 1 },	
	Radio_PlayerVehicleRide_01			= { "e0050_rtrg0020", 1 },	
	Radio_PlayerVehicleRide_02			= { "e0050_rtrg0023", 1 },	
	Radio_MbDvcActOpenHeliCall			= { "e0050_rtrg0030", 1 },	
	Radio_HelicopterArriveLZ			= "e0050_rtrg0070",			

	Radio_Reinforcements				= "e0050_rtrg0090",			
	Radio_Reinforcements2				= "e0050_rtrg0091",			
	Radio_CompletionBreakTarget1		= "e0050_rtrg0060",			
	Radio_CompletionBreakTarget2		= "e0050_rtrg0061",			
	Radio_Escape_TimeLeft_180s			= "e0050_rtrg0080",			
	Radio_Escape_TimeLeft_150s			= "e0050_rtrg0065",			
	Radio_Escape_TimeLeft_120s			= "e0050_rtrg0070",			
	Radio_Escape_TimeLeft_060s			= "e0050_rtrg0073",			
	Radio_Escape_TimeLeft_030s			= "e0050_rtrg0074",			
	Radio_Escape_TimeLeft_030s_2		= "e0050_rtrg0074",			
	Radio_Escape_TimeLeft_020s			= "e0050_rtrg0075",			
	Radio_Escape_TimeLeft_010s			= "e0050_rtrg0100",			
	Radio_Escape_TimeOver				= "e0050_rtrg0101",			
	Radio_WarningMissionArea			= "f0090_rtrg0310",			
	Radio_EmptyAmmo						= { "e0050_rtrg0130", 1 },	
	Radio_Advice						= "e0050_rtrg0097",			
	Radio_Claymore						= { "e0050_rtrg0200", 1 },	
	Radio_Target						= { "e0050_rtrg0095", 1 },	
	Radio_Conjunction1					= "e0050_rtrg9900",			
	Radio_Conjunction2					= "e0050_rtrg9910",			
	Radio_MBHostage						= { "e0050_rtrg0170", 1 },	
	Radio_ArmoredVehicle				= "e0050_rtrg0097",			
	Radio_ClaymoreInfo					= { "e0050_rtrg0205", 1 },	

	
	Radio_RideHeli_Clear				= "f0090_rtrg0460",			
	Radio_RideHeli_Failure				= "f0090_rtrg0130",			

	
	Radio_GameOver_PlayerDead			= "f0033_gmov0010",
	Radio_GameOver_MissionArea			= "f0033_gmov0020",
	Radio_GameOver_Other				= "f0033_gmov0030",
	Radio_GameOver_PlayerRideHelicopter	= "f0033_gmov0040",
	Radio_GameOver_HelicopterDead		= "f0033_gmov0160",	
	Radio_GameOver_PlayerDestroyHeli	= "f0033_gmov0120",
	Radio_GameOver_MissionFail			= "e0050_gmov0010",

	
	Radio_GameClear_Great				= "e0050_rtrg0144",
	Radio_GameClear_VeryGood			= "e0050_rtrg0143",
	Radio_GameClear_Good				= "e0050_rtrg0142",
	Radio_GameClear_Normal				= "e0050_rtrg0141",
	Radio_GameClear_Bad					= "e0050_rtrg0140",
	Radio_AfterGameClear				= "e0050_rtrg0150",

	
	Radio_EquipC4						= "f0090_rtrg0520",
	Radio_PlaceC4						= "f0090_rtrg0521",

	
	Miller_DontSneakPhase				= "f0090_rtrg0110",	
	Miller_AlartAdvice					= "f0090_rtrg0230",	
	Miller_AlertToEvasion				= "f0090_rtrg0260",	
	Miller_ReturnToSneak				= "f0090_rtrg0270",	
	Miller_SpRecoveryLifeAdvice			= "f0090_rtrg0290",	
	Miller_RevivalAdvice				= "f0090_rtrg0280",	
	Miller_CuarAdvice					= "f0090_rtrg0300",	
	Miller_TargetOnHeli					= "f0090_rtrg0200",	
	Miller_EnemyOnHeli					= "f0090_rtrg0210",	
	Miller_HeliNoCall					= "f0090_rtrg0166",	
	Miller_CallHeli01					= "f0090_rtrg0170",	
	Miller_CallHeli02					= "f0090_rtrg0171",	

	Miller_HeliDead						= "f0090_rtrg0220",	
	Miller_HeliDeadSneak				= "f0090_rtrg0155",	
	Miller_HeliAttack 					= "f0090_rtrg0225",	
	Radio_HostageDead					= "f0090_rtrg0540",	
	Miller_CallHeliHot01				= "f0090_rtrg0175",	
	Miller_CallHeliHot02				= "f0090_rtrg0176",	
}


this.OptionalRadioList = {
	OptionalRadio_001					= "Set_e0050_oprg0010",	
	OptionalRadio_002					= "Set_e0050_oprg0015",	
	OptionalRadio_003					= "Set_e0050_oprg0020",	
}


this.IntelRadioList = {

	
	gntn_area01_antiAirGun_000			= "e0050_esrg0030",	
	gntn_area01_antiAirGun_001			= "e0050_esrg0030",	
	gntn_area01_antiAirGun_002			= "e0050_esrg0030",	
	gntn_area01_antiAirGun_003			= "e0050_esrg0030",	

	
	Armored_Vehicle_WEST_000			= "e0050_esrg0040",	
	Tactical_Vehicle_WEST_000			= "e0050_esrg0053",	
	Tactical_Vehicle_WEST_001			= "e0050_esrg0053",	
	Cargo_Truck_WEST_000				= "e0050_esrg0051",	
	Cargo_Truck_WEST_001				= "e0050_esrg0051",	
	Cargo_Truck_WEST_002				= "e0050_esrg0051",	

	
	IntelRadio_WareHouse				= "e0050_esrg0060",	
	WoodTurret01						= "e0050_esrg0020",	
	WoodTurret02						= "e0050_esrg0020",	
	WoodTurret03						= "e0050_esrg0020",	
	WoodTurret04						= "e0050_esrg0020",	
	WoodTurret05						= "e0050_esrg0020",	


	
	Hostage_e20050_000					= "e0050_esrg0077",	
	Hostage_e20050_001					= "e0050_esrg0077",	
	Hostage_e20050_002					= "e0050_esrg0077",	
	Hostage_e20050_003					= "e0050_esrg0100",	

	
	IntelRadio_Claymore					= "e0050_esrg0110",	

	
	intel_f0090_esrg0110				= "f0090_esrg0110", 
	intel_f0090_esrg0120				= "f0090_esrg0120", 
	intel_f0090_esrg0130				= "f0090_esrg0130", 
	intel_f0090_esrg0140				= "f0090_esrg0140", 
	intel_f0090_esrg0150				= "f0090_esrg0150", 
	intel_f0090_esrg0190				= "f0090_esrg0190", 
	intel_f0090_esrg0200				= "f0090_esrg0200", 

	
	e20050_drum0002						= "f0090_esrg0180",
	e20050_drum0003						= "f0090_esrg0180",
	e20050_drum0004						= "f0090_esrg0180",
	gntnCom_drum0002					= "f0090_esrg0180",
	gntnCom_drum0005					= "f0090_esrg0180",
	gntnCom_drum0011					= "f0090_esrg0180",
	gntnCom_drum0012					= "f0090_esrg0180",
	gntnCom_drum0015					= "f0090_esrg0180",
	gntnCom_drum0019					= "f0090_esrg0180",
	gntnCom_drum0020					= "f0090_esrg0180",
	gntnCom_drum0021					= "f0090_esrg0180",
	gntnCom_drum0022					= "f0090_esrg0180",
	gntnCom_drum0023					= "f0090_esrg0180",
	gntnCom_drum0024					= "f0090_esrg0180",
	gntnCom_drum0025					= "f0090_esrg0180",
	gntnCom_drum0027					= "f0090_esrg0180",
	gntnCom_drum0028					= "f0090_esrg0180",
	gntnCom_drum0029					= "f0090_esrg0180",
	gntnCom_drum0030					= "f0090_esrg0180",
	gntnCom_drum0031					= "f0090_esrg0180",
	gntnCom_drum0035					= "f0090_esrg0180",
	gntnCom_drum0037					= "f0090_esrg0180",
	gntnCom_drum0038					= "f0090_esrg0180",
	gntnCom_drum0039					= "f0090_esrg0180",
	gntnCom_drum0040					= "f0090_esrg0180",
	gntnCom_drum0041					= "f0090_esrg0180",
	gntnCom_drum0042					= "f0090_esrg0180",
	gntnCom_drum0043					= "f0090_esrg0180",
	gntnCom_drum0044					= "f0090_esrg0180",
	gntnCom_drum0045					= "f0090_esrg0180",
	gntnCom_drum0046					= "f0090_esrg0180",
	gntnCom_drum0047					= "f0090_esrg0180",
	gntnCom_drum0048					= "f0090_esrg0180",
	gntnCom_drum0065					= "f0090_esrg0180",
	gntnCom_drum0066					= "f0090_esrg0180",
	gntnCom_drum0068					= "f0090_esrg0180",
	gntnCom_drum0069					= "f0090_esrg0180",
	gntnCom_drum0070					= "f0090_esrg0180",
	gntnCom_drum0071					= "f0090_esrg0180",
	gntnCom_drum0072					= "f0090_esrg0180",
	gntnCom_drum0101					= "f0090_esrg0180",

	
	e20050_SecurityCamera_01			= "f0090_esrg0210",
	e20050_SecurityCamera_02			= "f0090_esrg0210",
	e20050_SecurityCamera_03			= "f0090_esrg0210",
	e20050_SecurityCamera_04			= "f0090_esrg0210",
	e20050_SecurityCamera_05			= "f0090_esrg0210",

	
	intel_f0090_esrg0220				= "f0090_esrg0220",
}


this.commonEnableAllIntelRadio = function()

	for i, value in pairs( this.IntelRadioList ) do
		TppRadio.EnableIntelRadio( value )
	end

end

this.SetIntelRadio = function()
	local sequence = TppSequence.GetCurrentSequence()




	
	this.commonIntelCheck("Hostage_e20050_000")
	this.commonIntelCheck("Hostage_e20050_001")
	this.commonIntelCheck("Hostage_e20050_002")
	this.commonIntelCheck("Hostage_e20050_003")

	if ( sequence == "Seq_DestroyTarget1" or sequence == "Seq_DestroyTarget2" ) then
		if TppMission.GetFlag( "isMissionBackgroundRadio4Played" ) == true then			
			TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0078", true )
			TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0079", true )
			TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0080", true )
		else
			TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0077", true )
			TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0077", true )
			TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0077", true )
		end

		TppRadio.RegisterIntelRadio( "Armored_Vehicle_WEST_000", "e0050_esrg0040", true )	
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_000", "e0050_esrg0053", true )	
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_001", "e0050_esrg0053", true )	
		TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_000", "e0050_esrg0051", true )		
		TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_001", "e0050_esrg0051", true )		
		TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_002", "e0050_esrg0051", true )		
		TppRadio.RegisterIntelRadio( "IntelRadio_WareHouse", "e0050_esrg0060", true )		
		TppRadio.RegisterIntelRadio( "WoodTurret01", "e0050_esrg0020", true )				
		TppRadio.RegisterIntelRadio( "WoodTurret02", "e0050_esrg0020", true )				
		TppRadio.RegisterIntelRadio( "WoodTurret03", "e0050_esrg0020", true )				
		TppRadio.RegisterIntelRadio( "WoodTurret04", "e0050_esrg0020", true )				
		TppRadio.RegisterIntelRadio( "WoodTurret05", "e0050_esrg0020", true )				

		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0110", "f0090_esrg0110", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0120", "f0090_esrg0120", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0130", "f0090_esrg0130", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0140", "f0090_esrg0140", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0150", "f0090_esrg0150", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0190", "f0090_esrg0190", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0200", "f0090_esrg0200", true )

		TppRadio.EnableIntelRadio( "e20050_drum0002" )
		TppRadio.EnableIntelRadio( "e20050_drum0003" )
		TppRadio.EnableIntelRadio( "e20050_drum0004" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0002" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0005" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0011" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0012" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0015" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0019" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0020" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0021" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0022" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0023" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0024" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0025" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0027" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0028" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0029" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0030" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0031" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0035" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0037" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0038" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0039" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0040" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0041" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0042" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0043" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0044" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0045" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0046" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0047" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0048" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0065" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0066" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0068" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0069" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0070" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0071" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0072" )
		TppRadio.EnableIntelRadio( "e20050_drum0004" )
		TppRadio.EnableIntelRadio( "gntnCom_drum0101" )
		TppRadio.RegisterIntelRadio( "e20050_drum0002", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "e20050_drum0003", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "e20050_drum0004", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0002", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0005", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0011", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0012", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0015", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0019", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0020", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0021", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0022", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0023", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0024", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0025", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0027", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0028", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0029", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0030", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0031", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0035", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0037", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0038", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0039", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0040", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0041", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0042", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0043", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0044", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0045", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0046", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0047", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0048", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0065", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0066", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0068", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0069", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0070", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0071", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0072", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "e20050_drum0004", "f0090_esrg0180" )	
		TppRadio.RegisterIntelRadio( "gntnCom_drum0101", "f0090_esrg0180" )	
	end
	if ( sequence == "Seq_DestroyTarget1" ) then
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_000", "e0050_esrg0030", true )
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_001", "e0050_esrg0030", true )
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_002", "e0050_esrg0030", true )
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_003", "e0050_esrg0030", true )
	elseif ( sequence == "Seq_DestroyTarget2" ) then	
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_000", "e0050_esrg0033", true )
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_001", "e0050_esrg0033", true )
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_002", "e0050_esrg0033", true )
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_003", "e0050_esrg0033", true )
	else 
		if TppMission.GetFlag( "isHostage0003Talk2Played" ) == true then	
			TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0091", true )	
			TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0091", true )	
			TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0091", true )	
		else															
			TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0082", true )	
			TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0083", true )	
			TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0084", true )	
		end

		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_000", "e0050_esrg9000", true )	
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_001", "e0050_esrg9000", true )	
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_002", "e0050_esrg9000", true )	
		TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_003", "e0050_esrg9000", true )	
		TppRadio.RegisterIntelRadio( "Armored_Vehicle_WEST_000", "e0050_esrg9000", true )		
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_000", "e0050_esrg9000", true )	
		TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_001", "e0050_esrg9000", true )	
		TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_000", "e0050_esrg9000", true )			
		TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_001", "e0050_esrg9000", true )			
		TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_002", "e0050_esrg9000", true )			
		TppRadio.RegisterIntelRadio( "IntelRadio_WareHouse", "e0050_esrg9000", true )			
		TppRadio.RegisterIntelRadio( "WoodTurret01", "e0050_esrg9000", true )					
		TppRadio.RegisterIntelRadio( "WoodTurret02", "e0050_esrg9000", true )					
		TppRadio.RegisterIntelRadio( "WoodTurret03", "e0050_esrg9000", true )					
		TppRadio.RegisterIntelRadio( "WoodTurret04", "e0050_esrg9000", true )					
		TppRadio.RegisterIntelRadio( "WoodTurret05", "e0050_esrg9000", true )					

		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0110", "e0050_esrg9000", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0120", "e0050_esrg9000", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0130", "e0050_esrg9000", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0140", "e0050_esrg9000", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0150", "e0050_esrg9000", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0190", "e0050_esrg9000", true )
		TppRadio.RegisterIntelRadio( "intel_f0090_esrg0200", "e0050_esrg9000", true )

		TppRadio.DisableIntelRadio( "e20050_drum0002" )
		TppRadio.DisableIntelRadio( "e20050_drum0003" )
		TppRadio.DisableIntelRadio( "e20050_drum0004" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0002" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0005" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0011" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0012" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0015" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0019" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0020" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0021" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0022" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0023" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0024" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0025" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0027" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0028" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0029" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0030" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0031" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0035" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0037" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0038" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0039" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0040" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0041" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0042" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0043" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0044" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0045" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0046" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0047" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0048" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0065" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0066" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0068" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0069" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0070" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0071" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0072" )
		TppRadio.DisableIntelRadio( "e20050_drum0004" )
		TppRadio.DisableIntelRadio( "gntnCom_drum0101" )
	end
end


this.destroyFlagMap = {
	Armored_Vehicle_WEST_000	= "isArmoredVehicle0000Destroyed",
	Cargo_Truck_WEST_000		= "isTruck0000Destroyed",
	Cargo_Truck_WEST_001		= "isTruck0001Destroyed",
	Cargo_Truck_WEST_002		= "isTruck0002Destroyed",
	Tactical_Vehicle_WEST_000	= "isVehicle0000Destroyed",
	Tactical_Vehicle_WEST_001	= "isVehicle0001Destroyed",
	gntn_area01_antiAirGun_000	= "isAntiAirGun0000Destroyed",
	gntn_area01_antiAirGun_001	= "isAntiAirGun0001Destroyed",
	gntn_area01_antiAirGun_002	= "isAntiAirGun0002Destroyed",
	gntn_area01_antiAirGun_003	= "isAntiAirGun0003Destroyed",
	WoodTurret01				= "isWoodTurret0000Destroyed",
	WoodTurret02				= "isWoodTurret0001Destroyed",
	WoodTurret03				= "isWoodTurret0002Destroyed",
	WoodTurret04				= "isWoodTurret0003Destroyed",
	WoodTurret05				= "isWoodTurret0004Destroyed",
}


this.commonSetDestroyFlag = function( characterId )

	TppMission.SetFlag( this.destroyFlagMap[characterId], true )

end

this.commonGetDestroyFlag = function( characterId )

	return TppMission.GetFlag( this.destroyFlagMap[ characterId ] )

end




this.markerIds = {
	Armored_Vehicle_WEST_000	= "Armored_Vehicle_WEST_000",
	gntn_area01_antiAirGun_000	= "gntn_area01_antiAirGun_000",
	gntn_area01_antiAirGun_001	= "gntn_area01_antiAirGun_001",
	gntn_area01_antiAirGun_002	= "gntn_area01_antiAirGun_002",
	gntn_area01_antiAirGun_003	= "gntn_area01_antiAirGun_003",
	WoodTurret01				= "20050_marker_WoodTurret000",
	WoodTurret02				= "20050_marker_WoodTurret001",
	WoodTurret03				= "20050_marker_WoodTurret002",
	WoodTurret04				= "20050_marker_WoodTurret003",
	WoodTurret05				= "20050_marker_WoodTurret004",
}


this.commonEnableAllMarker = function()

	
	for i, value in pairs( markerIds ) do
		this.commonEnableMarker( value )
	end

end


this.commonDisableAllMarker = function()

	
	for i, value in pairs( this.markerIds ) do
		TppMarkerSystem.DisableMarker{ markerId = value }
	end

end


this.commonEnableMarker = function( characterId )

	TppMarkerSystem.EnableMarker{ markerId = this.markerIds[characterId], viewType = {"VIEW_MAP_ICON","VIEW_WORLD_ICON"} }
	TppMarkerSystem.SetMarkerImportant{ markerId = this.markerIds[characterId], isImportant = true }
	TppMarkerSystem.SetMarkerNew{ markerId = this.markerIds[characterId], isNew = true }
	

end


this.commonDisableMarker = function( characterId )




	TppMarkerSystem.DisableMarker{ markerId = this.markerIds[characterId] }

end


this.commonCountAliveAntiAirGun = function()

	local count = 0
	for i, characterId in ipairs( this.antiAirGuns ) do
		if this.commonGetDestroyFlag( characterId ) == false then
			count = count + 1
		end
	end
	return count

end

this.commonCountAliveTower = function()

	local count = 0
	for i, characterId in ipairs( this.towers ) do
		if this.commonGetDestroyFlag( characterId ) == false then
			count = count + 1
		end
	end
	return count

end


this.commonIsTarget = function( characterId )

	local sequence = TppSequence.GetCurrentSequence()
	if sequence == "Seq_DestroyTarget1" then
		for i, antiAirGunCharacterId in ipairs( this.antiAirGuns ) do
			if characterId == antiAirGunCharacterId then
				return true
			end
		end
	elseif sequence == "Seq_DestroyTarget2" then
		if characterId == "Armored_Vehicle_WEST_000" then
			return true
		end
	end

	return false

end


this.destroyAnnounceLogMap = {
	gntn_area01_antiAirGun_000	= "announce_destroy_AntiAirCraftGun",
	gntn_area01_antiAirGun_001	= "announce_destroy_AntiAirCraftGun",
	gntn_area01_antiAirGun_002	= "announce_destroy_AntiAirCraftGun",
	gntn_area01_antiAirGun_003	= "announce_destroy_AntiAirCraftGun",
	WoodTurret01				= "announce_destroy_tower",
	WoodTurret02				= "announce_destroy_tower",
	WoodTurret03				= "announce_destroy_tower",
	WoodTurret04				= "announce_destroy_tower",
	WoodTurret05				= "announce_destroy_tower",
	Armored_Vehicle_WEST_000	= "announce_destroy_APC",
}


this.commonGetDestroyAnnounceLogId = function( characterId )

	return this.destroyAnnounceLogMap[ characterId ]

end





this.commonRestoreRoute = function()

	
	if TppMission.GetFlag( "isFinishLightVehicleGroup" ) == true then							
		
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0049", "e20050_c01_route0014" )
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0049", "e20050_c01_route0015" )
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c02_route0049", "e20050_c02_route0035" )
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c02_route0049", "e20050_c02_route0036" )
	else																						
		
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0049", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0049", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "gntn_area01_antiAirGun_000" ) == true then					
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0065", { noForceUpdate = false, }  )	
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0051", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0052", { noForceUpdate = false, }  )		
	else																						
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0051", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0052", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "gntn_area01_antiAirGun_001" ) == true then					
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0002", { noForceUpdate = false, }  )	
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0003", { noForceUpdate = false, }  )	
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0053", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0054", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0055", { noForceUpdate = false, }  )		
	else																						
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0053", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0054", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0055", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "gntn_area01_antiAirGun_002" ) == true then					
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0005", { noForceUpdate = false, }  )	
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0061", { noForceUpdate = false, }  )	
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0062", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0063", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0064", { noForceUpdate = false, }  )		
	else																						
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0062", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0063", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0064", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "gntn_area01_antiAirGun_003" ) == true then					
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0006", { noForceUpdate = false, }  )	
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0057", { noForceUpdate = false, }  )	
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0058", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0059", { noForceUpdate = false, }  )		
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0060", { noForceUpdate = false, }  )		
	else																						
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0058", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0059", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0060", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "WoodTurret01" ) == true then									
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0006", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0044", { noForceUpdate = false, }  )
	else																						
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c01_route0006", { noForceUpdate = false, }  )
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0044", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "WoodTurret02" ) == true then									
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0007", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0045", { noForceUpdate = false, }  )
	else																						
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c01_route0007", { noForceUpdate = false, }  )
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0045", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "WoodTurret03" ) == true then									
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0009", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0047", { noForceUpdate = false, }  )
	else																						
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c01_route0009", { noForceUpdate = false, }  )
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0047", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "WoodTurret04" ) == true then									
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0005", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0048", { noForceUpdate = false, }  )
	else																						
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c01_route0005", { noForceUpdate = false, }  )
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0048", { noForceUpdate = false, }  )
	end

	if this.commonGetDestroyFlag( "WoodTurret05" ) == true then									
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0008", { noForceUpdate = false, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c02_route0046", { noForceUpdate = false, }  )
	else																						
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c01_route0008", { noForceUpdate = false, }  )
		TppEnemy.EnableRoute( this.CP_ID, "e20050_c02_route0046", { noForceUpdate = false, }  )
	end

end

this.photoIdMap = {
	gntn_area01_antiAirGun_000 = 10,
	gntn_area01_antiAirGun_001 = 40,
	gntn_area01_antiAirGun_002 = 30,
	gntn_area01_antiAirGun_003 = 20,
}

this.commonSetCompleteMissionPhotoId = function( characterId )

	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager ~= NULL then
		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData ~= NULL then

			local photoId = this.photoIdMap[characterId]
			if photoId ~= 0 then
				luaData:SetCompleteMissionPhotoId(photoId, true)
			end

		end
	end

end


this.commonDestroyObject = function( characterId )

	
	local hudCommonData = HudCommonDataManager.GetInstance()								
	TppRadio.DisableIntelRadio( characterId )												
	this.commonSetDestroyFlag( characterId )												
	local announceLogId = this.commonGetDestroyAnnounceLogId( characterId )					
	if announceLogId ~= nil then															
		if announceLogId == "announce_destroy_tower" then										
			if PlayRecord.IsMissionChallenge( "GUARDTOWER_DESTROY" ) == true then					
				local targetNum = this.commonCountAliveTower()
				local maxTargetNum = 5
				hudCommonData:AnnounceLogViewLangId( announceLogId, targetNum, maxTargetNum )			
			end
		elseif announceLogId == "announce_destroy_AntiAirCraftGun" then							
			if TppSequence.GetCurrentSequence() == "Seq_DestroyTarget1" then
			hudCommonData:AnnounceLogViewLangId( announceLogId )									
			end
		else																					
			hudCommonData:AnnounceLogViewLangId( announceLogId )									
		end
	end

	if characterId == "WoodTurret01" then

	elseif characterId == "WoodTurret02" then
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c01_route0007" )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c02_route0045" )
	elseif characterId == "WoodTurret03" then
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c01_route0009" )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c02_route0047" )
	elseif characterId == "WoodTurret04" then
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c01_route0005" )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c02_route0048" )
	elseif characterId == "WoodTurret05" then
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c01_route0008" )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20050_c02_route0046" )
	end

	
	if this.commonIsTarget( characterId ) then																

		this.commonDisableMarker( characterId )																	
		this.commonSetCompleteMissionPhotoId( characterId )														

	end

	
	if TppMission.GetFlag( "isAntiAirRouteSet" ) == false then												
		this.commonSetPhaseToKeepCaution( false )																		
		TppMission.SetFlag( "isAntiAirRouteSet", true )															
	end

	if TppMission.GetFlag( "isAntiLandRouteSet" ) == false then												
		this.commonChangeToAntiLandRouteSet( false )																	
		TppMission.SetFlag( "isAntiLandRouteSet", true )														
	end

	
	TppEnemy.ChangeRouteSet( this.CP_ID, "e20050_route_c02", { forceUpdate = true, forceReload = true } )	

	
	if	this.commonGetDestroyFlag( "WoodTurret01" ) == true and												
		this.commonGetDestroyFlag( "WoodTurret02" ) == true and												
		this.commonGetDestroyFlag( "WoodTurret03" ) == true and												
		this.commonGetDestroyFlag( "WoodTurret04" ) == true and												
		this.commonGetDestroyFlag( "WoodTurret05" ) == true then											

		local tower = PlayRecord.IsMissionChallenge( "GUARDTOWER_DESTROY" )
		if tower == true then

			local hardmode = TppGameSequence.GetGameFlag("hardmode")	
			if hardmode == true then									
				PlayRecord.RegistPlayRecord( "GUARDTOWER_DESTROY" )			
				
			else														
			end

		end

	end

	
	this.commonRestoreRoute()																				

end


this.commonOnPlayerEnterHostageTrap = function()

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name

	if trapName == "Trap_HostageCallHelp1" then									

		for i, characterId in ipairs( this.hostages ) do
			if	characterId ~= this.CHARACTER_ID_MB_AGENT and
				this.commonIsHostageMonologuePlayed( characterId ) == false then

				if characterId == "Hostage_e20050_001" then
					TppHostageManager.GsSetStruggleVoice( characterId, "POWV_0270" )	
				else
					TppHostageManager.GsSetStruggleVoice( characterId, "POWV_0260" )	
				end
				if this.commonIsHostageDoorOpened( characterId ) == false then
					TppHostageManager.GsSetStruggleFlag( characterId, true )			
				end

			end
		end

	elseif trapName == "Trap_HostageCallHelp2" then								

		if TppMission.GetFlag( "isHostageDialogue0001Played" ) == false then	

			TppMission.SetFlag( "isHostageDialogue0001Played", true )			
			

		end

	elseif trapName == "Trap_HostageCallHelp3" then

		if	TppSequence.GetCurrentSequence() == "Seq_CallSupportHelicopter" or	
			TppSequence.GetCurrentSequence() == "Seq_Escape" then				

			
			TppData.Enable( "Tactical_Vehicle_WEST_000" )

			
			TppData.Enable( "e20050_uss_driver0002" )
			TppData.Enable( "e20050_uss_driver0003" )

			
			

		end

	end

end


this.commonOnPlayerLeaveHostageTrap = function()

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name

	if trapName == "Trap_HostageCallHelp1" then								
		TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_000", false )		
		TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_001", false )		
		TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_002", false )		
	end

end


this.commonOnFinishHostageDialogue1 = function()

	
	SubtitlesCommand.Display( "PRSN1000_1u1210", "Default" )	
	GkEventTimerManager.Start( "Timer_WaitHostageDialogue2", 6.5 )

end


this.commonOnFinishHostageDialogue2 = function()

	
	SubtitlesCommand.Display( "PRSN1000_1u1110", "Default" )	
	GkEventTimerManager.Start( "Timer_WaitHostageDialogue3", 6.5 )

end

this.CHARACTER_ID_MB_AGENT = "Hostage_e20050_003"
this.hostages = {
	"Hostage_e20050_000",
	"Hostage_e20050_001",
	"Hostage_e20050_002",
	this.CHARACTER_ID_MB_AGENT,
}

this.hostageRescueFlagMap = {}
for i, characterId in ipairs( this.hostages ) do
	this.hostageRescueFlagMap[ characterId ] = characterId .. "isRescued"
end

for characterId, flagName in pairs( this.hostageRescueFlagMap ) do
	this.MissionFlagList[ flagName ] = false
end

this.commonSetHostageRescued = function( characterId )

	TppMission.SetFlag( this.hostageRescueFlagMap[ characterId ], true )	
	local hudCommonData = HudCommonDataManager.GetInstance()				
	GZCommon.NormalHostageRecovery( characterId )

	if characterId == this.CHARACTER_ID_MB_AGENT then						
		PlayRecord.PlusExternalScore( 6500 )									
		TppRadio.Play( "Miller_TargetOnHeli" )									
	else																	
		TppRadio.Play( "Miller_EnemyOnHeli" )									
	end

end

this.commonIsHostage = function( characterId )

	for i, hostageCharacterId in ipairs( this.hostages ) do
		if hostageCharacterId == characterId then
			return true
		end
	end

	return false

end

this.commonIsHostageRescued = function( characterId )

	return TppMission.GetFlag( this.hostageRescueFlagMap[ characterId ] )

end

this.commonIsAllHostageRescued = function()

	for i, characterId in pairs( this.hostages ) do
		if this.commonIsHostageRescued( characterId ) == false then
			return false
		end
	end

	return true

end


this.commonOnLaidHostage = function()

	local characterId = TppData.GetArgument(1)
	local vehicle = TppData.GetArgument(2)
	local vehicleId = TppData.GetArgument(3)

	if vehicleId == this.CHARACTER_ID_HELICOPTER then

		if this.commonIsHostage( characterId ) == true and TppHostageUtility.GetStatus( characterId ) ~= "Dead" then

			this.commonSetHostageRescued( characterId )			

			if	this.commonIsAllHostageRescued() == true then	
				Trophy.TrophyUnlock( 8 )							
			end

		end

	end

end

this.commonOnDeadHostage = function()




	local HostageCharacterID	= TppData.GetArgument(1)
	local PlayerDead			= TppData.GetArgument(4)
	
	if( PlayerDead == true ) then
		TppRadio.DelayPlay( "Radio_HostageDead", "mid" )
	end
	TppRadio.DisableIntelRadio( HostageCharacterID )
end

this.commonIntelCheck = function( CharacterID )



	local status = TppHostageUtility.GetStatus( CharacterID )
	if status == "Dead" then
		TppRadio.DisableIntelRadio( CharacterID )
	else
		TppRadio.EnableIntelRadio( CharacterID )
	end
end

this.commonOnLaidEnemy = function()

	local characterId = TppData.GetArgument(1)
	local vehicle = TppData.GetArgument(2)
	local vehicleId = TppData.GetArgument(3)

	if vehicleId == this.CHARACTER_ID_HELICOPTER then
		TppRadio.Play( "Miller_EnemyOnHeli" )
	end

end

this.commonOnEnterWareHouse000 = function()

	TppMarker.Disable( "20050_marker_weapon000" )

end

this.commonOnEnterWareHouse001 = function()

	TppMarker.Disable( "20050_marker_weapon001" )

end


this.commonLoadDemoBlock = function()

	TppMission.LoadDemoBlock( "/Assets/tpp/pack/mission/extra/e20050/e20050_d01.fpk" )	
	TppMission.LoadEventBlock("/Assets/tpp/pack/location/gntn/gntn_heli.fpk" )			

end


this.commonOnPlayerRideHelicopter = function()

	
	if this.commonGetDestroyFlag( "Armored_Vehicle_WEST_000" ) == true then				

		TppRadio.Play( "Radio_RideHeli_Clear" )												
		TppSequence.ChangeSequence( "Seq_PlayerRideHelicopter" )							

	else																				

		TppRadio.DelayPlay( "Radio_RideHeli_Failure", "mid" )								
		TppSupportHelicopterService.SetEnableGetOffTime( GZCommon.WaitTime_HeliTakeOff )	

	end

end

this.commonOnHelicopterDeparture = function()

	local characterId = TppData.GetArgument( 1 )
	this.CounterList.lastRendezvouzPoint = TppData.GetArgument( 2 )
	local playerRiding = TppData.GetArgument( 3 )

	if	characterId == this.CHARACTER_ID_HELICOPTER and
		playerRiding == true then

		if this.commonGetDestroyFlag( "Armored_Vehicle_WEST_000" ) == false then
			
		end

	end

end


this.commonHeliDamagedByPlayer = function()

	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		
		TppRadio.PlayEnqueue( "Miller_HeliAttack" )
	end

end


this.commonOnHelicopterReachDemoPoint = function()

	
	if TppPlayerUtility.GetRidingVehicleCharacterId() ~= "SupportHelicopter" then
		return
	end

	if this.commonGetDestroyFlag( "Armored_Vehicle_WEST_000" ) == true then	

		
		GZCommon.ScoreRankTableSetup( this.missionID )

		TppMission.ChangeState( "clear", "RideHeli_Clear" )						

	else																	

		this.CounterList.HeliReachDemoCount = this.CounterList.HeliReachDemoCount + 1
		if	TppSequence.GetCurrentSequence() == "Seq_DestroyTarget1" or
			this.CounterList.HeliReachDemoCount > 1 then

			TppMission.ChangeState( "failed", "RideHelicopter" )					

		end

	end

end

this.commonOnBeforeHelicopterReachDemoPoint = function()

	if	this.commonGetDestroyFlag( "Armored_Vehicle_WEST_000" ) == true or	
		this.CounterList.HeliReachDemoCount > 0 then						

		TppSupportHelicopterService.SetEnableLeanOut( false )						

		
		SimDaemon.SetForceSimNotActiveMode( 20.0 )

	end

end


this.commonCloseHelicopterDoor = function()

	TppSupportHelicopterService.CloseLeftDoor()		
	TppSupportHelicopterService.CloseRightDoor()	

	

end


this.commonFailMission = function()

	TppMission.ChangeState( "failed", "RideHelicopter" )					

end


this.commonOnPlayerRideVehicle = function()
	local VehicleID = TppData.GetArgument(2)
	if VehicleID == "SupportHelicopter" then
		
	else




			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:CallButtonGuide( "tutorial_accelarater", "VEHICLE_TRIGGER_ACCEL" )
			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:CallButtonGuide( "tutorial_brake", "VEHICLE_TRIGGER_BREAK" )

			TppMission.SetFlag( "isCarTutorial", true )							

	end
	if	TppSequence.GetCurrentSequence() == "Seq_DestroyTarget1" or		
		TppSequence.GetCurrentSequence() == "Seq_DestroyTarget2" then	

		local characterId = TppData.GetArgument( 1 )						
		local radioDaemon = RadioDaemon:GetInstance()
		if	characterId ~= this.CHARACTER_ID_HELICOPTER and					
			TppMission.GetFlag( "isEmptyAmmoRadioPlayed" ) == true then		
			
			if ( radioDaemon:IsPlayingRadio() == false ) then
				if TppMission.GetFlag( "isVehicleIntelRadioPlayed" ) == false then	
					TppRadio.DelayPlay( "Radio_PlayerVehicleRide_01", "mid" )			
				else																
					TppRadio.DelayPlay( "Radio_PlayerVehicleRide_02", "mid" )			
				end
			end
		end

	end

end


local Tutorial_2Button = function( textInfo, buttonIcon1, buttonIcon2 )
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( textInfo, buttonIcon1, buttonIcon2 )
end


this.commonOnPlayerPickingUpWeapon = function()

	
	local weaponId = TppData.GetArgument(1)

	if weaponId == this.MISSILE_ID then									

		local radioDaemon = RadioDaemon:GetInstance()
		if radioDaemon:IsPlayingRadio() == false then						
			TppRadio.DelayPlay( "Radio_PlayerPickUpWeapon_WP_ms02", "mid" )		
		end

		if( TppMission.GetFlag( "isPrimaryWPIcon" ) == false ) then
			Tutorial_2Button("tutorial_primary_wp_select", fox.PAD_U, "RStick")
			TppMission.SetFlag( "isPrimaryWPIcon", true )
		end

	elseif weaponID == "WP_sr01_v00" then				

		if( TppMission.GetFlag( "isPrimaryWPIcon" ) == false ) then
			Tutorial_2Button("tutorial_primary_wp_select", fox.PAD_U, "RStick")
			TppMission.SetFlag( "isPrimaryWPIcon", true )
		end

	elseif	TppMission.GetFlag( "isPlayerInClaymoreRadioTrap" ) and
			weaponId == "WP_Claymore" then

		TppRadio.DisableIntelRadio( "IntelRadio_Claymore" )
		TppMission.SetFlag( "isClaymoreRadioPlayed", true )

	end

end


this.commonOnHelicopterDescendToLZ = function()

	local sequence = TppSequence.GetCurrentSequence()
	if sequence == "Seq_CallSupportHelicopter" or sequence == "Seq_Escape" then
		TppSupportHelicopterService.DisableAutoReturn()
	end

end


this.commonOnHelicopterDead = function()

	local sequence = TppSequence.GetCurrentSequence()
	local killerCharacterId = TppData.GetArgument(2)

	
	if sequence == "Seq_PlayerRideHelicopter" then
		TppMission.ChangeState( "failed", "HelicopterDead" )	
	else
		if killerCharacterId == "Player" then
			TppRadio.Play( "Miller_HeliDeadSneak" )
		else
			TppRadio.Play( "Miller_HeliDead" )
		end
		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then
				local hudCommonData = HudCommonDataManager.GetInstance()					
				hudCommonData:AnnounceLogViewLangId( "announce_destroyed_support_heli" )	
			end
		end
	end

end


this.commonGetHostageDoorOpenedFlagName = function( characterId )

	return characterId .. "_DoorOpened"

end


for i, characterId in ipairs( this.hostages ) do
	this.MissionFlagList[ this.commonGetHostageDoorOpenedFlagName( characterId ) ] = false
end


this.commonIsHostageDoorOpened = function( characterId )

	return TppMission.GetFlag( this.commonGetHostageDoorOpenedFlagName( characterId ) )

end


this.commonSetHostageDoorOpened = function( characterId, flag )

	TppMission.SetFlag( this.commonGetHostageDoorOpenedFlagName( characterId ), flag )

end


this.commonOnPickingDoor = function()

	local characterId = TppData.GetArgument( 1 )
	local hostageCharacterId = nil

	
	if characterId == "AsyPickingDoor24" then
		hostageCharacterId = "Hostage_e20050_001"
		TppHostageManager.GsSetStruggleFlag( hostageCharacterId, false )
	elseif characterId == "AsyPickingDoor13" then
		hostageCharacterId = "Hostage_e20050_002"
		TppHostageManager.GsSetStruggleFlag( hostageCharacterId, false )
	elseif characterId == "AsyPickingDoor08" then
		hostageCharacterId = "Hostage_e20050_000"
		TppHostageManager.GsSetStruggleFlag( hostageCharacterId, false )
	end

	if hostageCharacterId ~= nil then
		this.commonSetHostageDoorOpened( hostageCharacterId, true )
	end

end


this.commonChangeToAntiLandRouteSet = function( isWarp )

	TppEnemy.RegisterRouteSet( this.CP_ID, "caution_day", "e20050_route_c02" )													
	TppEnemy.ChangeRouteSet( this.CP_ID, "e20050_route_c02", { forceUpdate = true, forceReload = true, warpEnemy = isWarp } )	

end



this.commonOnNonTargetBroken = function()

	local characterId = TppData.GetArgument(1)	
	this.commonDestroyObject( characterId )		
	

end


this.commonSetPhaseToKeepCaution = function( isWarp)

	GZCommon.CallCautionSiren()							
	TppEnemy.SetMinimumPhase( this.CP_ID, "caution" )	
	TppEnemy.ChangeRouteSet( this.CP_ID, "e20050_route_c01", { forceUpdate = true, forceReload = true, warpEnemy = isWarp } )	

end


this.commonOnMissionFailure = function( manager, messageId, message )

	
	local radioDaemon = RadioDaemon:GetInstance()
	
	radioDaemon:StopDirectNoEndMessage()
	
	SubtitlesCommand.StopAll()
	
	TppEnemyUtility.IgnoreCpRadioCall(true)	
	TppEnemyUtility.StopAllCpRadio( 0.5 )	

	
	TppSoundDaemon.SetMute( 'GameOver' )

	
	this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_MissionFailed

	if message == "OutsideMissionArea" then									

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_mission_outside" )	

		
		GZCommon.OutsideAreaCamera()

		
		TppSequence.ChangeSequence( "Seq_MissionFailedOutsideMissionArea" )		

	elseif message == "RideHelicopter" then									
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_mission_abort" )	

		TppSequence.ChangeSequence( "Seq_MissionFailedRideHelicopter" )			
	elseif message == "HelicopterDead" then
		TppSequence.ChangeSequence( "Seq_MissionFailedHelicopterDead" )
	elseif message == "TimeOver" then										
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_time_over" )	

		TppSequence.ChangeSequence( "Seq_MissionFailedTimeOver" )				
	elseif message == "PlayerDead" then										
		TppSequence.ChangeSequence( "Seq_MissionFailedPlayerDead" )				
	elseif message == "PlayerFallDead" then									
		this.CounterList.GameOverFadeTime = GZCommon.FadeOutTime_PlayerFallDead	
		TppSequence.ChangeSequence( "Seq_MissionFailedPlayerDead" )				
	else																	
		TppSequence.ChangeSequence( "Seq_MissionFailedPlayerDead" )				
	end

end


this.commonOnMissionClear = function( manager, messageId, message )

	TppSequence.ChangeSequence( "Seq_PlayMissionClearDemo" )
	Trophy.TrophyUnlock( 2 )									

end


this.commonOnEquipWeapon = function()

	local weaponId = TppData.GetArgument( 1 )			
	this.CounterList.currentWeapon = weaponId

	if TppMission.GetFlag( "isC4EquipRadioPlayed" ) == true then
		return
	end

	local sequence = TppSequence.GetCurrentSequence()	
	if 	weaponId == "WP_C4" and
		( sequence == "Seq_DestroyTarget1" or sequence == "Seq_DestroyTarget2" ) then

		TppMission.SetFlag( "isC4EquipRadioPlayed", true )

		local radioDaemon = RadioDaemon:GetInstance()
		if radioDaemon:IsPlayingRadioWithGroupName("e0050_rtrg0008") == false and radioDaemon:IsPlayingRadioWithGroupName("e0050_rtrg0010") == false then
			TppRadio.Play( "Radio_EquipC4" )
		end

	end

end


this.commonOnPlaceWeapon = function()

	if TppMission.GetFlag( "isC4PlaceRadioPlayed" ) == true then
		return
	end

	local weaponId = TppData.GetArgument( 1 )
	local sequence = TppSequence.GetCurrentSequence()	
	if 	weaponId == "WP_C4" and
		( sequence == "Seq_DestroyTarget1" or sequence == "Seq_DestroyTarget2" ) then

		TppMission.SetFlag( "isC4PlaceRadioPlayed", true )

		local radioDaemon = RadioDaemon:GetInstance()
		if radioDaemon:IsPlayingRadioWithGroupName("e0050_rtrg0008") == false and radioDaemon:IsPlayingRadioWithGroupName("e0050_rtrg0010") == false then
			TppRadio.Play( "Radio_PlaceC4" )
		end

	end

end


this.commonSub_PPRG1001_601010 = function()

	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( "tutorial_C4_set", "PL_HOLD", "PL_SHOT" )

end


this.commonSub_PPRG1001_611010 = function()

	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( "tutorial_C4_exploding", "PL_HOLD", "PL_ACTION" )

end

this.commonEnableWeaponMarker = function()

	TppMarkerSystem.EnableMarker{ markerId="20050_marker_weapon000", goalType="GOAL_NONE", viewType = "VIEW_MAP_ICON" }
	TppMarkerSystem.EnableMarker{ markerId="20050_marker_weapon001", goalType="GOAL_NONE", viewType = "VIEW_MAP_ICON" }
	
	

end


this.commonOnAlert = function()

	if TppMission.GetFlag( "isAntiLandRouteSet" ) == false then	
		this.commonChangeToAntiLandRouteSet( false )						
		TppMission.SetFlag( "isAntiLandRouteSet", true )			
	end

	GZCommon.CallAlertSirenCheck()

	
	local characters = Ch.FindCharacters( "Bird" )
	for i=1, #characters.array do
	   local chara = characters.array[i]
	   local plgAction = chara:FindPlugin("TppBirdActionPlugin")
	   plgAction:SetForceFly()
	end

end

this.commonOnEvasion = function()

	
	if ( status == "Down" ) then
		
		if ( TppEnemy.GetPhase( this.CP_ID ) == "evasion" ) then
			local sequence = TppSequence.GetCurrentSequence()
			if sequence == "Seq_SearchAndDestroy" or sequence == "Seq_GotoHeliport" then
				TppEnemy.ChangeRouteSet( this.CP_ID, "e20070_route_c01", { warpEnemy = false } )
			end
		end
	end

end


this.commonOnCaution = function()

	

	
	local characters = Ch.FindCharacters( "Bird" )
	for i=1, #characters.array do
	   local chara = characters.array[i]
	   local plgAction = chara:FindPlugin("TppBirdActionPlugin")
	   plgAction:SetForceFly()
	end

end



this.commonOnAmmoStackEmpty = function()

	local weaponId = TppData.GetArgument( 1 )
	local sequence = TppSequence.GetCurrentSequence()



	if	( weaponId == "WP_C4" or weaponId == "WP_Grenade" ) and						
		( sequence == "Seq_DestroyTarget1" or sequence == "Seq_DestroyTarget2" ) then	

		TppRadio.DelayPlay( "Radio_EmptyAmmo", "mid" )	
		TppMission.SetFlag( "isEmptyAmmoRadioPlayed", true )

		if sequence == "Seq_DestroyTarget1" then
			TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_000", "e0050_esrg0010", true )
			TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_001", "e0050_esrg0010", true )
			TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_002", "e0050_esrg0010", true )
			TppRadio.RegisterIntelRadio( "gntn_area01_antiAirGun_003", "e0050_esrg0010", true )
		end

		this.commonEnableAllAntiAirGunIntelRadio()

		local sequence = TppSequence.GetCurrentSequence()
		if sequence == "Seq_DestroyTarget1" or sequence == "Seq_DestroyTarget1" then
			TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_000", "e0050_esrg0052", true )
			TppRadio.RegisterIntelRadio( "Tactical_Vehicle_WEST_001", "e0050_esrg0052", true )
			TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_000", "e0050_esrg0050", true )
			TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_001", "e0050_esrg0050", true )
			TppRadio.RegisterIntelRadio( "Cargo_Truck_WEST_002", "e0050_esrg0050", true )
		end

	end

end

this.commonOnReachRouteNode = function()

	local routeName = TppData.GetArgument( 3 )
	local routeNode = TppData.GetArgument( 1 )
	local maxRouteNode = TppData.GetArgument( 2 )

	
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0057" ) and
		routeNode == 1 then

		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0058", "e20050_c01_route0057" )

	end
	if routeName == GsRoute.GetRouteId( "e20050_c01_route0058" ) then
		if routeNode == 0 then
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0062", "e20050_c01_route0061" )
		elseif routeNode == 1 then
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0059", "e20050_c01_route0058" )
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0063", "e20050_c01_route0062" )
		end
	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0059" ) and
		routeNode == 1 then

		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0060", "e20050_c01_route0059" )

	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0060" ) then
		if routeNode == 0 then
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0064", "e20050_c01_route0063" )
		elseif routeNode == 1 then
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0057", "e20050_c01_route0060" )
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0061", "e20050_c01_route0064" )
		end
	end

	
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0071" ) then
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0074", "e20050_c01_route0071" )
	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0074" ) then
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0068", "e20050_c01_route0074" )
	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0072" ) then
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0075", "e20050_c01_route0072" )
	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0075" ) then
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0069", "e20050_c01_route0075" )
	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0073" ) then
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0076", "e20050_c01_route0073" )
	end
	if	routeName == GsRoute.GetRouteId( "e20050_c01_route0076" ) then
		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20050_c01_route0070", "e20050_c01_route0076" )
	end

end

this.ChangeAntiAir = function()

	
	local status = TppData.GetArgument(2)

	
	if ( status == true ) then
		
		GZCommon.CallCautionSiren()
	
	else
		
		GZCommon.StopSirenNormal()
	end

end



this.SwitchPuchButtonDemo = function()



	local charaID = TppData.GetArgument( 1 )
	local check = TppEnemy.GetPhase( this.CP_ID )
	local status = TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )

	
	if( charaID == "gntn_center_SwitchLight" )then



		if( status == 1 )then	
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_02", false )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_03", false )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_04", false )

			if( TppMission.GetFlag( "isSwitchLightDemo" ) == false and check ~= "alert") then	

				local onDemoStart = function()
					
					TppMission.SetFlag( "isSwitchLightDemo", true )
				end
				TppDemo.Play( "Demo_SwitchLight" , { onStart = onDemoStart} , {
					disableGame				= false,	
					disableDamageFilter		= false,	
					disableDemoEnemies		= false,	
					disableEnemyReaction	= true,		
					disableHelicopter		= false,	
					disablePlacement		= false, 	
					disableThrowing			= false	 	
				})
			end
		elseif( status == 2 )then	



			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_02", true )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_03", true )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_04", true )
		end

	end
end


this.OnShowRewardPopupWindow = function()





	local hudCommonData = HudCommonDataManager.GetInstance()
	local uiCommonData = UiCommonDataManager.GetInstance()

	
	local RewardAllCount = uiCommonData:GetRewardAllCount( this.missionID )



	
	hudCommonData:SetBonusPopupCounter( this.tmpRewardNum, RewardAllCount )

	
	
	local challengeString = PlayRecord.GetOpenChallenge()
	while ( challengeString ~= "" ) do




		
		hudCommonData:ShowBonusPopupCommon( challengeString )
		
		challengeString = PlayRecord.GetOpenChallenge()
	end

	
	local Rank = PlayRecord.GetRank()



	while ( Rank < this.tmpBestRank ) do




		this.tmpBestRank = ( this.tmpBestRank - 1 )
		if ( this.tmpBestRank == 4 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankC, "WP_sm00_v00", { isSup=true, isLight=true } )
		elseif ( this.tmpBestRank == 3 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankB, "WP_sr01_v00" )
		elseif ( this.tmpBestRank == 2 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankA, "WP_ms02" )
		elseif ( this.tmpBestRank == 1 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankS, "WP_ar00_v05", { isBarrel=true } )
		end
	end

	
	
	local ChicoTape7 = this.commonIsHostageRescued( this.CHARACTER_ID_MB_AGENT ) == true and uiCommonData:IsHaveCassetteTape( "tp_chico_07" ) == false
	if ChicoTape7 == true then
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_20050" )
		uiCommonData:GetBriefingCassetteTape( "tp_chico_07" )
	end

	
	
	local AllChicoTape = GZCommon.CheckReward_AllChicoTape()
	if ( AllChicoTape == true and
			 uiCommonData:IsHaveCassetteTape( "tp_chico_08" ) == false ) then




		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_allchico" )

		
		uiCommonData:GetBriefingCassetteTape( "tp_chico_08" )

	end

	
	
	local AllHardClear = PlayRecord.IsAllMissionClearHard()
	if ( AllHardClear == true and
			 uiCommonData:IsHaveCassetteTape( "tp_bgm_01" ) == false ) then




		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_tp_bgm_01" )

		
		uiCommonData:GetBriefingCassetteTape( "tp_bgm_01" )

	end

	if	TppGameSequence.GetGameFlag("hardmode") == false and					
		PlayRecord.GetMissionScore( 20050, "NORMAL", "CLEAR_COUNT" ) == 1 then	

		hudCommonData:ShowBonusPopupCommon( "reward_extreme" )						

	end

	
	if ( hudCommonData:IsShowBonusPopup() == false ) then



		TppSequence.ChangeSequence( "Seq_MissionEnd" )	
	end

end

this.tmpChallengeString = 0			


this.commonOnVehicleGroupActionEnd = function()

	local vehicleGroupInfo = TppData.GetArgument( 2 )

	local routeInfoName = vehicleGroupInfo.routeInfoName									
	local vehicleCharacterId = vehicleGroupInfo.vehicleCharacterId							
	local routeId = vehicleGroupInfo.vehicleRouteId											
	local memberCharacterIds = vehicleGroupInfo.memberCharacterIds							
	local result = vehicleGroupInfo.result													
	local reason = vehicleGroupInfo.reason													

	if routeInfoName == "TppGroupVehicleDefaultRideRouteInfo0002" then						

		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0079", { noForceUpdate = true, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0080", { noForceUpdate = true, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0081", { noForceUpdate = true, }  )
		TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0082", { noForceUpdate = true, }  )

	end

end


this.OnClosePopupWindow = function()





	
	local LangIdHash = TppData.GetArgument(1)

	
	if ( LangIdHash == this.tmpChallengeString ) then

		
		this.OnShowRewardPopupWindow()
	end
end


this.commonOnPlayerDamaged = function()

	local attackId = TppData.GetArgument( 1 )



	if	attackId == "ATK_Claymore" and
		TppMission.GetFlag( "isPlayerInClaymoreRadioTrap" ) == true then

		local radioDaemon = RadioDaemon:GetInstance()
		if	TppMission.GetFlag( "isClaymoreRadioPlayed" ) == false and
			radioDaemon:IsRadioGroupMarkAsRead("e0050_esrg0110") == false then

			TppMission.SetFlag( "isClaymoreRadioPlayed", true )
			TppRadio.DelayPlay( "Radio_Claymore", "mid" )
			TppRadio.DisableIntelRadio( "IntelRadio_Claymore" )

		end

	end

end

this.commonOnActivatePlaced = function()

	local attackId = TppData.GetArgument( 1 )
	if attackId == "WP_Claymore" then							

		
		TppRadio.DisableIntelRadio( "IntelRadio_Claymore" )

	end

end

this.commonPlayerEnterClaymoreRadioTrap = function()

	TppMission.SetFlag( "isPlayerInClaymoreRadioTrap", true )

end

this.commonPlayerLeaveClaymoreRadioTrap = function()

	TppMission.SetFlag( "isPlayerInClaymoreRadioTrap", false )

end

this.commonOnPlayerLifeLessThanHalf = function()

	if	TppMission.GetFlag( "isClaymoreRadioPlayed" ) == true then

		TppRadio.Play( "Miller_SpRecoveryLifeAdvice" )

	end

end

this.commonPlayerEnterPowCarriedTalkTrap0001 = function()

	if TppMission.GetFlag( "isHostage0003Talk1Played" ) == true then
		return
	end

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name

	local obj = Ch.FindCharacterObjectByCharacterId("Hostage_e20050_003")
	if not Entity.IsNull(obj) then

		TppHostageManager.GsSetSpecialFaintFlag( "Hostage_e20050_003", false )
		TppHostageManager.GsSetSpecialIdleFlag( "Hostage_e20050_003", false )
		TppEnemyUtility.CallCharacterMonologue( "POW_CD_e0050_002" , 3, obj, true )
		trapBodyHandle:SetInvalid() 

		TppMission.SetFlag( "isHostage0003Talk1Played", true )

	end

end

this.commonPlayerEnterPowCarriedTalkTrap0002 = function()

	if TppMission.GetFlag( "isHostage0003Talk2Played" ) == true then
		return
	end

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name

	
	if( TppPlayerUtility.IsCarriedCharacter( "Hostage_e20050_003" )) then

		local obj = Ch.FindCharacterObjectByCharacterId("Hostage_e20050_003")
		if not Entity.IsNull(obj) then

			TppHostageManager.GsSetSpecialFaintFlag( "Hostage_e20050_003", false )
			TppHostageManager.GsSetSpecialIdleFlag( "Hostage_e20050_003", false )
			TppEnemyUtility.CallCharacterMonologue( "POW_CD_e0050_001" , 3, obj, true )
			trapBodyHandle:SetInvalid() 

			if TppMission.GetFlag( "isArmoredVehicle0000Destroyed" ) == false then	

				TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0090", true )
				TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0090", true )
				TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0090", true )

			else																	

				TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0091", true )
				TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0091", true )
				TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0091", true )

			end

			TppRadio.EnableIntelRadio( "Hostage_e20050_000" )
			TppRadio.EnableIntelRadio( "Hostage_e20050_001" )
			TppRadio.EnableIntelRadio( "Hostage_e20050_002" )

			TppMission.SetFlag( "isHostage0003Talk2Played", true )

		end

	else
	end

end

this.commonOnHostageIntelRadioPlayed = function()

	if TppMission.GetFlag( "isArmoredVehicle0000Destroyed" ) == false then	

		TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0090", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0090", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0090", true )

	else																	

		TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0091", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0091", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0091", true )

	end

end

this.hostageMonologues = {
	Hostage_e20050_000 = "POW_CD_0010",
	Hostage_e20050_001 = "POW_CD_0020",
	Hostage_e20050_002 = "POW_CD_0040",
}

this.hostageMonologueFlags = {
}
for i, characterId in ipairs( this.hostages ) do
	local flagName = characterId .. "_Monologue"
	this.hostageMonologueFlags[ characterId ] = flagName
	this.MissionFlagList[ flagName ] = false
end


this.commonIsHostageMonologuePlayed = function( characterId )

	if TppMission.GetFlag( this.hostageMonologueFlags[ characterId ] ) == true then
		return true
	end

	return false

end

this.commonSetHostageMonologueFlag = function( characterId, flag )

	TppMission.SetFlag( this.hostageMonologueFlags[ characterId ], flag )

end


this.commonOnEnterDeathTrap = function()

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name





	if trapName == "GeoTrapDamage" then

		this.CounterList.playerInDeathTrap0000 = true

	end

end


this.commonOnLeaveDeathTrap = function()

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name





	if trapName == "GeoTrapDamage" then

		this.CounterList.playerInDeathTrap0000 = false

	end

end

this.commonPlayerEnterPowCarriedTalkTrap0003 = function()

	local trapBodyHandle = TppData.GetArgument(3)
	local trapName = trapBodyHandle.data.name

	
	for i, characterId in ipairs( this.hostages ) do
		if	characterId ~= this.CHARACTER_ID_MB_AGENT and
			this.commonIsHostageMonologuePlayed( characterId ) == false then

			if TppPlayerUtility.IsCarriedCharacter( characterId ) == true then

				local obj = Ch.FindCharacterObjectByCharacterId( characterId )
				if not Entity.IsNull(obj) then

					TppHostageManager.GsSetSpecialFaintFlag( characterId, false )
					TppHostageManager.GsSetSpecialIdleFlag( characterId, false )
					TppEnemyUtility.CallCharacterMonologue( this.hostageMonologues[ characterId ], 3, obj, true )
					this.commonSetHostageMonologueFlag( characterId, true )

				end
			end
		end
	end

end

this.commonPlayerEnterHostageRadioTrap0000 = function()

	local trapBodyHandle = TppData.GetArgument(3)

	local radioDaemon = RadioDaemon:GetInstance()
	if radioDaemon:IsRadioGroupMarkAsRead("e0050_esrg0100") == false then	
		TppRadio.Play( "Radio_MBHostage" )
	end

	if TppMission.GetFlag( "isArmoredVehicle0000Destroyed" ) == false then	

		TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0077", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0077", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0077", true )

	else																	

		TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0082", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0083", true )
		TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0084", true )

	end

	TppRadio.EnableIntelRadio( "Hostage_e20050_000" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_001" )
	TppRadio.EnableIntelRadio( "Hostage_e20050_002" )

	trapBodyHandle:SetInvalid() 

end

this.commonPlayMissionBackgroundRadio4 = function()

	TppMission.SetFlag( "isMissionBackgroundRadio4Played", true )						
	TppRadio.DelayPlayEnqueue( "Radio_MissionBackground4", "long", "both" )											

	TppRadio.RegisterIntelRadio( "Hostage_e20050_000", "e0050_esrg0078", true )
	TppRadio.RegisterIntelRadio( "Hostage_e20050_001", "e0050_esrg0079", true )
	TppRadio.RegisterIntelRadio( "Hostage_e20050_002", "e0050_esrg0080", true )

	TppRadio.EnableIntelRadio( "Hostage_e20050_000", true )
	TppRadio.EnableIntelRadio( "Hostage_e20050_001", true )
	TppRadio.EnableIntelRadio( "Hostage_e20050_002", true )

end

this.commonPlayClaymoreInfoRadio = function()

	local radioDaemon = RadioDaemon:GetInstance()
	if radioDaemon:IsRadioGroupMarkAsRead( "e0050_esrg0110" ) == false then	
		if TppMission.GetFlag( "isClaymoreRadioPlayed" ) == false then
			TppRadio.DelayPlay( "Radio_ClaymoreInfo", "mid" )
		end
	end

end


this.OnMbDvcActOpenHeliCall = function()

	if TppSequence.GetCurrentSequence() ~= "Seq_Escape" then
		TppRadio.DelayPlay( "Radio_MbDvcActOpenHeliCall", "short" )
	end

end


this.OnMbDvcActCallRescueHeli = function(characterId, type)
	local radioDaemon = RadioDaemon:GetInstance()
	local emergency = TppData.GetArgument(2)











	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()

	if( VehicleId == "SupportHelicopter" ) then
	else
		if ( type == "MbDvc" ) then










			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
				
					if(emergency == 2) then
						TppRadio.DelayPlay( "Miller_CallHeliHot02", "long" )
					else
						TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
					end
				else
				
					local charaObj = Ch.FindCharacterObjectByCharacterId("SupportHelicopter")
					local plgHeli = charaObj:GetCharacter():FindPlugin("TppSupportHelicopterPlugin")
					if plgHeli:GetAiStatus() ~= "AI_STATUS_RETURN" then
						if(emergency == 2) then
							TppRadio.DelayPlay( "Miller_CallHeliHot01", "long" )
						else
							TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
						end
					end
				end
			end
		elseif ( type == "flare" ) then










			if ( emergency == false ) then
				
				if ( radioDaemon:IsPlayingRadio() == false ) then
					TppRadio.DelayPlay( "Miller_HeliNoCall", "long" )
				end
			else
				
				if ( radioDaemon:IsPlayingRadio() == false ) then
					
					if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
					
						if(emergency == 2) then
							TppRadio.DelayPlay( "Miller_CallHeliHot02", "long" )
						else
							TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
						end
					else
					
						local charaObj = Ch.FindCharacterObjectByCharacterId("SupportHelicopter")
						local plgHeli = charaObj:GetCharacter():FindPlugin("TppSupportHelicopterPlugin")
						if plgHeli:GetAiStatus() ~= "AI_STATUS_RETURN" then
							if(emergency == 2) then
								TppRadio.DelayPlay( "Miller_CallHeliHot01", "long" )
							else
								TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
							end
						end
					end
				end
			end
		else
			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
				
					TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
				else
				
					TppRadio.DelayPlay( "Miller_CallHeli01", "long" )
				end
			end
		end
	end
end

this.commonEnableAllAntiAirGunIntelRadio = function()

	if TppMission.GetFlag( "isAntiAirGun0000Destroyed" ) == false then
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_000" )
	end
	if TppMission.GetFlag( "isAntiAirGun0001Destroyed" ) == false then
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_001" )
	end
	if TppMission.GetFlag( "isAntiAirGun0002Destroyed" ) == false then
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_002" )
	end
	if TppMission.GetFlag( "isAntiAirGun0003Destroyed" ) == false then
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_003" )
	end

end

this.antiAirGuns = {
	"gntn_area01_antiAirGun_000",
	"gntn_area01_antiAirGun_001",
	"gntn_area01_antiAirGun_002",
	"gntn_area01_antiAirGun_003",
}

this.towers = {
	"WoodTurret01",
	"WoodTurret02",
	"WoodTurret03",
	"WoodTurret04",
	"WoodTurret05",
}

this.antiAirGunsMarkerFlagMap = {}
for i, characterId in ipairs( this.antiAirGuns ) do
	this.antiAirGunsMarkerFlagMap[ characterId ] = characterId .. "Mark"
	this.MissionFlagList[ this.antiAirGunsMarkerFlagMap[ characterId ] ] = false
end

this.commonIsAntiAirGunsMarked = function( characterId )

	return TppMission.GetFlag( this.antiAirGunsMarkerFlagMap[ characterId ] )

end

this.commonSetAntiAirGunsMarkFlag = function( characterId, flag )

	TppMission.SetFlag( this.antiAirGunsMarkerFlagMap[ characterId ], flag )
end


this.commonStartPlayBackGroundRadio2 = function()

	GkEventTimerManager.Stop( "Timer_BackGroundRadio1" )
	GkEventTimerManager.Start( "Timer_BackGroundRadio2", 5 )

end


this.commonPlayBackGroundRadio2 = function()

	if	TppCharacterUtility.GetCurrentPhaseName() ~= "Alert" then						

		if TppMission.GetFlag( "isMissionBackgroundRadio1Played" ) == false then			

			TppMission.SetFlag( "isMissionBackgroundRadio1Played", true )						
			TppRadio.DelayPlayEnqueue( "Radio_MissionBackground1", "long","both", {										
				onEnd = function()																
					GkEventTimerManager.Start( "Timer_BackGroundRadio2", 5 )								
				end } )

		elseif TppMission.GetFlag( "isMissionBackgroundRadio4Played" ) == false then		

			this.commonPlayMissionBackgroundRadio4()

		end

	else																				
		GkEventTimerManager.Start( "Timer_BackGroundRadio2", 5 )							
	end

end


this.ClearRankRewardList = {

	
	RankS = "e20050_Assult",
	RankA = "e20050_Missile",
	RankB = "e20050_Sniper",
	RankC = "e20050_MachineGun",
}

this.ClearRankRewardPopupList = {

	
	RankS = "reward_clear_s_rifle",
	RankA = "reward_clear_a_rocket",
	RankB = "reward_clear_b_sniper",
	RankC = "reward_clear_c_submachine",
}

this.After_SwitchOff = function()

	
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", true , false )

	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_02", false )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_03", false )

	

end

this.SwitchLight_ON = function()

	
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", false , false )

	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_02", true )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_03", true )

	

end

this.SwitchLight_OFF = function()

	local phase = TppEnemy.GetPhase( this.CP_ID )

	
	if( TppMission.GetFlag( "isSwitchLightDemo" ) == false )
		and ( phase == "sneak" or phase == "caution" or phase == "evasion" ) then

		local onDemoStart = function()

			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()
			
			SubtitlesCommand.StopAll()
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_02", false )

		   
		   TppDataUtility.CreateEffectFromGroupId( "wtrdrpbil" )
		   TppDataUtility.CreateEffectFromGroupId( "dstcomviw" )

		end
		local onDemoSkip = function()

			
			TppGadgetUtility.SetSwitch( "gntn_center_SwitchLight", false )

		end
		local onDemoEnd = function()

			
			TppMission.SetFlag( "isSwitchLightDemo", true )
			
			this.After_SwitchOff()

			
			TppDataUtility.DestroyEffectFromGroupId( "wtrdrpbil" )
			TppDataUtility.DestroyEffectFromGroupId( "dstcomviw" )

		end
		TppDemo.Play( "Demo_SwitchLight" , { onStart = onDemoStart, onSkip = onDemoSkip ,onEnd = onDemoEnd } , {
			disableGame			= false,	
			disableDamageFilter		= false,	
			disableDemoEnemies		= false,	
			disableEnemyReaction	= true,		
			disableHelicopter		= false,	
			disablePlacement		= false, 	
			disableThrowing		= false	 	
		})
	
	else
		
		this.After_SwitchOff()
	end
end


this.Common_SecurityCameraBroken = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.DisableIntelRadio( characterID )
end

this.Common_SecurityCameraPowerOff = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.DisableIntelRadio( characterID )
end

this.Common_SecurityCameraPowerOn = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.EnableIntelRadio( characterID)
end

this.ContinueHostageRegisterList = {
	
	CheckList01 = {
		Pos						= "TppLightVehicleForBlock0000_Position",
		VehicleType				= "Vehicle",
		HostageRegisterPoint	= { "hostageWarpPoint0004", "hostageWarpPoint0005", "hostageWarpPoint0006", "hostageWarpPoint0007", },
	},
	
	CheckList02 = {
		Pos						= "TppWesternTruckForBlock0000_Position",
		VehicleType				= "Truck",
		HostageRegisterPoint	= { "hostageWarpPoint0000", "hostageWarpPoint0001", "hostageWarpPoint0002", "hostageWarpPoint0003", },
	},
	
	CheckList03 = {
		Pos						= "TppWesternTruckForBlock0001_Position",
		VehicleType				= "Truck",
		HostageRegisterPoint	= { "hostageWarpPoint0008", "hostageWarpPoint0009", "hostageWarpPoint0010", "hostageWarpPoint0011", },
	},
	
	CheckList04 = {
		Pos						= "TppWesternTruckForBlock0002_Position",
		VehicleType				= "Truck",
		HostageRegisterPoint	= { "hostageWarpPoint0012", "hostageWarpPoint0013", "hostageWarpPoint0014", "hostageWarpPoint0015", },
	},
}




this.Messages = {
	Trap = {
		{ data = "Trap_HostageCallHelp1",			message = "Enter",							commonFunc = this.commonOnPlayerEnterHostageTrap, },		
		{ data = "Trap_HostageCallHelp1",			message = "Exit",							commonFunc = this.commonOnPlayerLeaveHostageTrap, },		
		{ data = "Trap_HostageCallHelp2",			message = "Enter",							commonFunc = this.commonOnPlayerEnterHostageTrap, },		
		{ data = "Trap_HostageCallHelp3",			message = "Enter",							commonFunc = this.commonOnPlayerEnterHostageTrap, },		
		{ data = "Trap_WareHouse000",				message = "Enter",							commonFunc = this.commonOnEnterWareHouse000, },				
		{ data = "Trap_WareHouse001",				message = "Enter",							commonFunc = this.commonOnEnterWareHouse001, },				
		{ data = "Trap_HeliReachDemoPoint",			message = "Enter",							commonFunc = this.commonOnHelicopterReachDemoPoint, },		
		{ data = "Trap_BeforeHeliReachDemoPoint",	message = "Enter",							commonFunc = this.commonOnBeforeHelicopterReachDemoPoint, },		
		{ data = "Trap_ClaymoreRadio",				message = "Enter",							commonFunc = this.commonPlayerEnterClaymoreRadioTrap, },
		{ data = "Trap_ClaymoreRadio",				message = "Exit",							commonFunc = this.commonPlayerLeaveClaymoreRadioTrap, },
		{ data = "Trap_PowCarriedTalk0001",			message = "Enter",							commonFunc = this.commonPlayerEnterPowCarriedTalkTrap0001, },
		{ data = "Trap_PowCarriedTalk0002",			message = "Enter",							commonFunc = this.commonPlayerEnterPowCarriedTalkTrap0002, },
		{ data = "Trap_HostageRadio0000",			message = "Enter",							commonFunc = this.commonPlayerEnterHostageRadioTrap0000, },
		{ data = "Trap_Monologue_Hostage01",		message = "Enter", 							commonFunc = this.commonPlayerEnterPowCarriedTalkTrap0003 },
		{ data = "Trap_ClaymoreInfo",				message = "Enter", 							commonFunc = this.commonPlayClaymoreInfoRadio },
		{ data = "GeoTrapDamage",					message = "Enter",							commonFunc = this.commonOnEnterDeathTrap, },
		{ data = "GeoTrapDamage",					message = "Exit",							commonFunc = this.commonOnLeaveDeathTrap, },
	},
	Character = {
		
		{ data = "Player",							message = "RideHelicopterStart",			commonFunc = this.commonOnPlayerRideHelicopter, },			
		{ data = "Player",							message = "OnVehicleRide_End",				commonFunc = this.commonOnPlayerRideVehicle },				
		{ data = "Player",							message = "OnPickUpWeapon", 				commonFunc = this.commonOnPlayerPickingUpWeapon },			
		{ data = "Player",							message = "TryPicking",						commonFunc = this.commonOnPickingDoor },					
		{ data = "Player",							message = "OnEquipWeapon",					commonFunc = this.commonOnEquipWeapon },
		{ data = "Player",							message = "WeaponPutPlaced",				commonFunc = this.commonOnPlaceWeapon },
		{ data = "Player",							message = "OnAmmoStackEmpty",				commonFunc = this.commonOnAmmoStackEmpty },					
		{ data = "Player",							message = "e0010_rtrg0700",					commonFunc = function() TppRadio.Play( "Miller_RecoveryLifeAdvice" ) end },
		{ data = "Player",							message = "e0010_rtrg0710",					commonFunc = function() TppRadio.Play( "Miller_SpRecoveryLifeAdvice" ) end },
		{ data = "Player",							message = "e0010_rtrg0720",					commonFunc = function() TppRadio.Play( "Miller_RevivalAdvice" ) end },
		{ data = "Player",							message = "OnDamaged",						commonFunc = this.commonOnPlayerDamaged },
		
		{ data = "Player",							message = "NotifyStartWarningFlare",		commonFunc = function() this.OnMbDvcActCallRescueHeli("SupportHelicopter", "flare") end  },	
		{ data = "Player", 							message = "OnActivatePlaced", 				commonFunc = this.commonOnActivatePlaced },

		
		{ data = this.CP_ID,						message = "Alert",							commonFunc = this.commonOnAlert },								
		{ data = this.CP_ID,						message = "Evasion",						commonFunc = this.commonOnEvasion },	
		{ data = this.CP_ID,						message = "Caution",						commonFunc = this.commonOnCaution },	
		
		{ data = this.CP_ID,						message = "AntiAir",						commonFunc = this.ChangeAntiAir },								
		{ data = this.CP_ID,						message = "EndGroupVehicleRouteMove",		commonFunc = this.commonOnVehicleGroupActionEnd },

		
		{ data = "Hostage_e20050_000",				message = "HostageLaidOnVehicle",			commonFunc = this.commonOnLaidHostage, },
		{ data = "Hostage_e20050_001",				message = "HostageLaidOnVehicle",			commonFunc = this.commonOnLaidHostage, },
		{ data = "Hostage_e20050_002",				message = "HostageLaidOnVehicle",			commonFunc = this.commonOnLaidHostage, },
		{ data = "Hostage_e20050_003",				message = "HostageLaidOnVehicle",			commonFunc = this.commonOnLaidHostage, },
		{ data = "Hostage_e20050_000",				message = "Dead",							commonFunc = this.commonOnDeadHostage, },
		{ data = "Hostage_e20050_001",				message = "Dead",							commonFunc = this.commonOnDeadHostage, },
		{ data = "Hostage_e20050_002",				message = "Dead",							commonFunc = this.commonOnDeadHostage, },
		{ data = "Hostage_e20050_003",				message = "Dead",							commonFunc = this.commonOnDeadHostage, },

		
		{ data = this.CHARACTER_ID_HELICOPTER,		message = "DescendToLandingZone",			commonFunc = this.commonOnHelicopterDescendToLZ, },
		{ data = this.CHARACTER_ID_HELICOPTER,		message = "Dead",							commonFunc = this.commonOnHelicopterDead, },
		{ data = this.CHARACTER_ID_HELICOPTER,		message = "DepartureToMotherBase",			commonFunc = this.commonOnHelicopterDeparture, },
		{ data = this.CHARACTER_ID_HELICOPTER,		message = "DamagedByPlayer",				commonFunc = this.commonHeliDamagedByPlayer },		

		
		{ data = "e20050_SecurityCamera_01",		message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20050_SecurityCamera_02",		message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20050_SecurityCamera_03",		message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20050_SecurityCamera_04",		message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20050_SecurityCamera_05",		message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20050_SecurityCamera_01",		message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20050_SecurityCamera_02",		message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20050_SecurityCamera_03",		message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20050_SecurityCamera_04",		message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20050_SecurityCamera_05",		message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20050_SecurityCamera_01",		message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20050_SecurityCamera_02",		message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20050_SecurityCamera_03",		message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20050_SecurityCamera_04",		message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20050_SecurityCamera_05",		message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
	},
	Enemy = {
		{ 											message = "MessageRoutePoint",				commonFunc = this.commonOnReachRouteNode },
		{											message = "HostageLaidOnVehicle",			commonFunc = this.commonOnLaidEnemy },	
	},
	Gimmick = {
		
		{ data = "WoodTurret01",					message = "BreakGimmick",					commonFunc = this.commonOnNonTargetBroken },
		{ data = "WoodTurret02",					message = "BreakGimmick",					commonFunc = this.commonOnNonTargetBroken },
		{ data = "WoodTurret03",					message = "BreakGimmick", 					commonFunc = this.commonOnNonTargetBroken },
		{ data = "WoodTurret04",					message = "BreakGimmick", 					commonFunc = this.commonOnNonTargetBroken },
		{ data = "WoodTurret05",					message = "BreakGimmick", 					commonFunc = this.commonOnNonTargetBroken },
		
		{ data = "gntn_center_SwitchLight",			message = "SwitchOn",						commonFunc = this.SwitchLight_ON },	
		{ data = "gntn_center_SwitchLight",			message = "SwitchOff",						commonFunc = this.SwitchLight_OFF },	
	},
	Mission = {
		{											message = "MissionFailure",					localFunc = "commonOnMissionFailure" },
		{											message = "MissionClear",					localFunc = "commonOnMissionClear" },
		{											message = "MissionRestart", 				localFunc = "commonMissionCleanUp" },		
		{											message = "MissionRestartFromCheckPoint",	localFunc = "commonMissionCleanUp" },		
		{											message = "ReturnTitle",					localFunc = "commonMissionCleanUp" },		
	},
	Timer = {
		{ data = "Timer_WaitHostageDialogue1",		message = "OnEnd",							commonFunc = this.commonOnFinishHostageDialogue1 },
		{ data = "Timer_WaitHostageDialogue2",		message = "OnEnd",							commonFunc = this.commonOnFinishHostageDialogue2 },
		{ data = "Timer_WaitClear",					message = "OnEnd",							commonFunc = this.commonCloseHelicopterDoor, },
		{ data = "Timer_CloseDoor",					message = "OnEnd",							commonFunc = this.commonFailMission, },
	},
	Subtitles = {
		{ data = "pprg1001_601010",					message = "SubtitlesEventMessage",			commonFunc = this.commonSub_PPRG1001_601010, },
		{ data = "pprg1001_611010",					message = "SubtitlesEventMessage",			commonFunc = this.commonSub_PPRG1001_611010, },
		{ data = "snes2000_191010",					message = "SubtitlesEventMessage",			commonFunc = function() TppMission.SetFlag( "isVehicleIntelRadioPlayed", true ) end },
	},
	Radio = {
		{ data = "e0050_esrg0100",					message = "RadioEventMessage",				commonFunc = this.commonOnHostageIntelRadioPlayed, },
		{ data = "e0050_rtrg0170",					message = "RadioEventMessage",				commonFunc = this.commonOnHostageIntelRadioPlayed, },
	},
	RadioCondition = {

		{											message = "PlayerHurt",						commonFunc = function() TppRadio.Play( "Miller_CuarAdvice" ) end },
		{											message = "PlayerCureComplete",				commonFunc = function() TppRadio.Play( "Miller_SpRecoveryLifeAdvice" ) end },

	},
	Terminal = {
		{											message = "MbDvcActOpenHeliCall",			commonFunc = this.OnMbDvcActOpenHeliCall },		
		{											message = "MbDvcActCallRescueHeli",			commonFunc = function() this.OnMbDvcActCallRescueHeli("SupportHelicopter", "MbDvc") end },	
	},
	Demo = {
		{ data = "p11_020003_000",					message="invis_cam",						commonFunc = function() TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20050_SecurityCamera_03", false ) end },
		{ data = "p11_020003_000",					message="lightOff",							commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",false) end },
		{ data = "p11_020003_000",					message="lightOn",							commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",true) end },
		{ data = "p11_020003_000",					message="under",							commonFunc = function() TppWeatherManager:GetInstance():RequestTag("under", 0 ) end },
		{ data = "p11_020003_000",					message="default",							commonFunc = function() TppWeatherManager:GetInstance():RequestTag("default", 0 ) end },
	},
}







this.tmpBestRank = 0
this.tmpRewardNum = 0				


this.Seq_MissionPrepare = {

	OnEnter = function( manager )

		this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )

		local sequence = TppSequence.GetCurrentSequence()							
		if	sequence == "Seq_MissionPrepare" or										
			manager:IsStartingFromResearvedForDebug() then							
			this.onCommonMissionSetup()												
		end

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )




		TppSequence.ChangeSequence( "Seq_MissionSetup" )	

	end,
}


this.Seq_MissionSetup = {

	OnEnter = function()

		TppSequence.ChangeSequence( "Seq_LoadOpeningDemo" )	

	end,

}


this.Seq_LoadOpeningDemo = {

	OnEnter = function()

		
		this.commonLoadDemoBlock()

	end,

	OnUpdate = function()

		
		if( IsDemoAndEventBlockActive() ) then							
			TppSequence.ChangeSequence( "Seq_OpeningShowTransition" )		
		end

	end,

}


this.Seq_OpeningShowTransition = {

	OnEnter = function()

		local localChangeSequence = {
			onOpeningBgEnd = function()
				TppSequence.ChangeSequence( "Seq_OpeningDemo" ) 
			end,
		}

		TppUI.ShowTransition( "opening", localChangeSequence )
		TppMusicManager.PostJingleEvent( "MissionStart", "Play_bgm_gntn_op_default" )

	end,

}


this.Seq_OpeningDemo = {

	Messages = {
		Demo = {
			{ data = "p12_040000_000",	message = "marking1",	localFunc = "localOnDemoMessage_marking1", },
			{ data = "p12_040000_000",	message = "marking2",	localFunc = "localOnDemoMessage_marking2", },
		},
	},

	OnEnter = function( manager )

		
		TppCharacterUtility.SetEnableCharacterId( "Enemy_DisableWhenDemo", false )

		TppDemo.Play( "Demo_Opening", {
			onStart = function()

				TppUI.FadeIn( 0.7 )

				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then
						luaData:RegisterDemoMarkerHandleId( "gntn_area01_antiAirGun_000" )
						luaData:RegisterDemoMarkerHandleId( "gntn_area01_antiAirGun_001" )
					end
				end

			end,
			onSkip = function()
				TppMission.SetFlag( "isOpeningDemoSkipped", true )
			end,
			onEnd = function()

				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then
						luaData:InitDemoMarkerHandleIds()
					end
				end

				TppMissionManager.SaveGame( 5 )						
				TppSequence.ChangeSequence( "Seq_DestroyTarget1" )	

			end, } )

	end,

	localOnDemoMessage_marking1 = function()

		
		this.commonEnableMarker( "gntn_area01_antiAirGun_000" )
		this.commonSetAntiAirGunsMarkFlag( "gntn_area01_antiAirGun_000", true )

		
		local charaObj = Ch.FindCharacterObjectByCharacterId( "gntn_area01_antiAirGun_000" )
		local position = charaObj:GetPosition()
		TppSoundDaemon.PostEvent3D( 'Play_Test_sfx_s_enemytag01', position )

	end,

	localOnDemoMessage_marking2 = function()

		
		TppCharacterUtility.SetEnableCharacterId( "Enemy_DisableWhenDemo", true )

		
		this.commonEnableMarker( "gntn_area01_antiAirGun_001" )
		this.commonSetAntiAirGunsMarkFlag( "gntn_area01_antiAirGun_001", true )

		
		local charaObj = Ch.FindCharacterObjectByCharacterId( "gntn_area01_antiAirGun_001" )
		local position = charaObj:GetPosition()
		TppSoundDaemon.PostEvent3D( 'Play_Test_sfx_s_enemytag01', position )

	end,

}


this.Seq_DestroyTarget1 = {

	Messages = {
		Character = {
			
			{ data = this.CP_ID,							message = "ConversationEnd",		localFunc = "localOnConversationEnd" },

			
			{ data = "Armored_Vehicle_WEST_000",			message = "StrykerDestroyed",		commonFunc = this.commonOnNonTargetBroken },
			{ data = "Tactical_Vehicle_WEST_000",			message = "VehicleBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "Tactical_Vehicle_WEST_001",			message = "VehicleBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_000",				message = "VehicleBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_001",				message = "VehicleBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_002",				message = "VehicleBroken",			commonFunc = this.commonOnNonTargetBroken },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_000",			message = "AntiAircraftGunBroken",	localFunc = "localOnTargetBroken" },
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",	localFunc = "localOnTargetBroken" },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",	localFunc = "localOnTargetBroken" },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",	localFunc = "localOnTargetBroken" },
		},
		Timer = {
			{ data = "Timer_StopRadio",						message = "OnEnd", 					localFunc = "localWaitRadioPlayUntilFlagChange" },
			{ data = "Timer_StartSilen",					message = "OnEnd", 					localFunc = "localPlaySilenSound" },
			{ data = "Timer_StartRadio",					message = "OnEnd", 					localFunc = "localPlayCautionRadio" },
			{ data = "Timer_CautionPhase",					message = "OnEnd", 					localFunc = "localChangePhaseCaution" },
			{ data = "Timer_BackGroundRadio1",				message = "OnEnd", 					localFunc = "localPlayBackGroundRadio" },
			{ data = "Timer_BackGroundRadio1AfterCaution",	message = "OnEnd", 					localFunc = "localEnableRadioPlay" },
			{ data = "Timer_BackGroundRadio2",				message = "OnEnd", 					commonFunc = this.commonPlayBackGroundRadio2 },
			{ data = "Timer_SequenceChange",				message = "OnEnd", 					localFunc = "localChangeSequence" },
			{ data = "Timer_StartVehicle",					message = "OnEnd", 					localFunc = "localStartVehicle" },
			{ data = "Timer_MarkAntiAirGun",				message = "OnEnd", 					localFunc = "localMarkAntiAirGun" },
		},
		Trap = {
			{ data = "Trap_ForceCaution0000",				message = "Enter",					localFunc = "localPlaySilenSound", },
			{ data = "Trap_MissionBackgroundRadio",			message = "Enter",					commonFunc = this.commonStartPlayBackGroundRadio2, },
		},
	},

	OnEnter = function()

		
		if TppMission.GetFlag( "isOpeningDemoSkipped" ) == true then		

			TppMission.SetFlag( "isMissionStartRadioPlayed", true )				
			TppRadio.DelayPlay( "Radio_MissionStartForSkip", "mid", nil, {		
				onEnd = function()
					TppMusicManager.PostJingleEvent( 'SingleShot', 'Stop_bgm_gntn_op_default' )
					GkEventTimerManager.Start( "Timer_BackGroundRadio1", 15 )	
				end } )

		else

			if TppMission.GetFlag( "isMissionStartRadioPlayed" ) == false then	
				TppMission.SetFlag( "isMissionStartRadioPlayed", true )				
				TppRadio.DelayPlay( "Radio_MissionStart", "short", "end", {							
					onEnd = function()
						TppMusicManager.PostJingleEvent( 'SingleShot', 'Stop_bgm_gntn_op_default' )
						GkEventTimerManager.Start( "Timer_BackGroundRadio1", 5 )		
					end } )
			end

		end

		
		TppRadio.RegisterOptionalRadio( "OptionalRadio_001" )

		
		TppRadioConditionManagerAccessor.Register( "Tutorial", TppRadioConditionTutorialPlayer{ time = 1.5 } )	  
		TppRadioConditionManagerAccessor.Register( "Basic", TppRadioConditionPlayerBasic{ time = 0.3 } )

		
		this.commonEnableAllIntelRadio()
		
		this.SetIntelRadio()

		
		
		TppUI.ShowAllMarkers()

		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then
				luaData:SetCurrentMissionSubGoalNo(1)
			end
		end

		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker( "RV_SeaSide" )

		
		
		GkEventTimerManager.Start( "Timer_StopRadio", 60 )			
		GkEventTimerManager.Start( "Timer_StartSilen", 85 )			
		GkEventTimerManager.Start( "Timer_StartVehicle", 300 )		
		GkEventTimerManager.Start( "Timer_MarkAntiAirGun", 0.5 )	

		
		
		local targetCount = this.commonCountAliveAntiAirGun()		
		if targetCount < 2 then										
			TppMusicManager.StartSceneMode()
			TppMusicManager.PlaySceneMusic( "Play_bgm_e20050_count" )
			TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_aircraftgun' )
		end

		
		
		TppCharacterUtility.SetEnableCharacterId( "Enemy_DisableWhenDemo", true )

	end,

	localMarkAntiAirGun = function()

		
		for i, characterId in ipairs( this.antiAirGuns ) do
			if	this.commonGetDestroyFlag( characterId ) == false and
				this.commonIsAntiAirGunsMarked( characterId ) == false then

				this.commonEnableMarker( characterId )	
				this.commonSetAntiAirGunsMarkFlag( characterId, true )

				
				local charaObj = Ch.FindCharacterObjectByCharacterId( characterId )
				local position = charaObj:GetPosition()
				TppSoundDaemon.PostEvent3D( 'Play_Test_sfx_s_enemytag01', position )


				GkEventTimerManager.Start( "Timer_MarkAntiAirGun", 0.5 )
				break

			end
		end

	end,

	localStartVehicle = function()

		if TppMission.GetFlag( "isLightVechicleStarted" ) == false then

			TppData.Enable( "Tactical_Vehicle_WEST_001" )	
			TppData.Enable( "e20050_uss_driver0001" )		
			TppData.Enable( "e20050_uss_driver0004" )		
			TppData.Enable( "e20050_uss_driver0005" )		
			TppData.Enable( "e20050_uss_driver0006" )		

			TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0079", { noForceUpdate = true, }  )
			TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0080", { noForceUpdate = true, }  )
			TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0081", { noForceUpdate = true, }  )
			TppEnemy.DisableRoute( this.CP_ID, "e20050_c01_route0082", { noForceUpdate = true, }  )

			
			local commonDataManager = UiCommonDataManager.GetInstance()
			if commonDataManager ~= NULL then
				local luaData = commonDataManager:GetUiLuaExportCommonData()
				if luaData ~= NULL then
					local hudCommonData = HudCommonDataManager.GetInstance()				
					hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )			
				end
			end

			TppMission.SetFlag( "isLightVechicleStarted", true )

		end

	end,

	
	localWaitRadioPlayUntilFlagChange = function()

		TppMission.SetFlag( "isBackGroundRadioWait", true )

	end,

	localEnableRadioPlay = function()

		TppMission.SetFlag( "isBackGroundRadioWait", false )

	end,

	
	localPlayBackGroundRadio = function()

		if TppMission.GetFlag( "isBackGroundRadioWait" ) == true then
			GkEventTimerManager.Start( "Timer_BackGroundRadio1", 5 )
			return
		end

		local player = TppPlayerUtility.GetLocalPlayerCharacter()
		local pos = player:GetPosition()
		if	TppCharacterUtility.GetCurrentPhaseName() ~= "Alert" and						
			TppEnemyUtility.GetNumberOfActiveSoldier( pos, 40 ) == 0 then					

			if TppMission.GetFlag( "isMissionBackgroundRadio1Played" ) == false then			

				TppMission.SetFlag( "isMissionBackgroundRadio1Played", true )						
				TppRadio.DelayPlayEnqueue( "Radio_MissionBackground1", "long","both", {										
					onEnd = function()																
						GkEventTimerManager.Start( "Timer_BackGroundRadio1", 5 )								
					end } )

			elseif TppMission.GetFlag( "isMissionBackgroundRadio2Played" ) == false then		

				TppMission.SetFlag( "isMissionBackgroundRadio2Played", true )						

				TppRadio.DelayPlayEnqueue( "Radio_Conjunction2", "long","begin", {
					onEnd = function()
						TppRadio.DelayPlay( "Radio_MissionBackground2", nil, "end", {									
							onEnd = function()																
								GkEventTimerManager.Start( "Timer_BackGroundRadio1", 5 )						
							end } )
					end } )

			elseif TppMission.GetFlag( "isMissionBackgroundRadio4Played" ) == false then		

				this.commonPlayMissionBackgroundRadio4()

			end

		else																				
			GkEventTimerManager.Start( "Timer_BackGroundRadio1", 5 )							
		end

	end,

	
	localOnTargetBroken = function()

		local characterId = TppData.GetArgument(1)				

		this.commonDestroyObject( characterId )					

		
		local targetCount = this.commonCountAliveAntiAirGun()		
		if targetCount < 2 then									

			
			TppMusicManager.StartSceneMode()
			TppMusicManager.PlaySceneMusic( "Play_bgm_e20050_count" )
			TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_aircraftgun' )

			
			
			if ( GZCommon.PlayerAreaName == "WareHouse" ) then
				TppMissionManager.SaveGame("20")
			elseif ( GZCommon.PlayerAreaName == "Asylum" ) then
				TppMissionManager.SaveGame("21")
			elseif ( GZCommon.PlayerAreaName == "EastCamp" ) then
				TppMissionManager.SaveGame("22")
			elseif ( GZCommon.PlayerAreaName == "WestCamp" ) then
				TppMissionManager.SaveGame("23")
			elseif ( GZCommon.PlayerAreaName == "Heliport" ) then
				TppMissionManager.SaveGame("24")
			elseif ( GZCommon.PlayerAreaName == "ControlTower_East" ) then
				TppMissionManager.SaveGame("25")
			elseif ( GZCommon.PlayerAreaName == "ControlTower_West" ) then
				TppMissionManager.SaveGame("26")
			elseif ( GZCommon.PlayerAreaName == "SeaSide" ) then
				TppMissionManager.SaveGame("27")
			else



				TppMissionManager.SaveGame("24")									
			end

			

			TppSequence.ChangeSequence( "Seq_DestroyTarget2" )					

		elseif targetCount == 2 then										

			TppRadio.DelayPlay( "Radio_AntiAirGunDestroyedLastOne", "short" )	

			GkEventTimerManager.Stop( "Timer_BackGroundRadio1" )				

		else																
			TppRadio.Play( "Radio_AntiAirGunDestroyed" )						
		end

		
		local hudCommonData = HudCommonDataManager.GetInstance()											
		if hudCommonData ~= nil then
			local targetNum = 4 - this.commonCountAliveAntiAirGun()													
			local maxTargetNum = 3																				
			hudCommonData:AnnounceLogViewLangId( "announce_mission_goal_num", targetNum, maxTargetNum )			
		end

	end,

	
	localPlaySilenSound = function()

		GkEventTimerManager.Stop( "Timer_StartSilen")		
		GkEventTimerManager.Start( "Timer_StartRadio", 5 )

	end,

	
	localPlayCautionRadio = function()

		GkEventTimerManager.Stop( "Timer_StartRadio")			
		GkEventTimerManager.Start( "Timer_CautionPhase", 10 )

		
		if TppMission.GetFlag( "isCautionRadioPlayed" ) == false then	
			TppMission.SetFlag( "isCautionRadioPlayed", true ) 				
			TppRadio.Play( "Radio_Caution", {								
				onEnd = function()

				end } )
		end

	end,

	
	localChangePhaseCaution = function()

		GkEventTimerManager.Stop( "Timer_CautionPhase")				
		if TppMission.GetFlag( "isAntiAirRouteSet" ) == false then	

			this.commonSetPhaseToKeepCaution()							
			TppMissionManager.SaveGame( 10 )							
			TppMission.SetFlag( "isAntiAirRouteSet", true )				

			GkEventTimerManager.Start( "Timer_BackGroundRadio1AfterCaution", 30 )	

		end

	end,

}


this.Seq_DestroyTarget2 = {

	Messages = {
		Character = {
			
			{ data = "Player",						message = "OnPickUpWeapon", 				localFunc = "localOnPlayerPickingUpWeapon" }, 

			
			{ data = "Armored_Vehicle_WEST_000",	message = "StrykerDestroyed",				localFunc = "localOnStrykerBroken" },
			{ data = "Armored_Vehicle_WEST_000",	message = "VehicleMessageRoutePoint",		localFunc = "localOnStrykerRoutePoint" },
			{ data = "Tactical_Vehicle_WEST_000",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Tactical_Vehicle_WEST_001",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_000",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_001",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_002",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_000",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_001",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_002",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_003",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
		},
		Terminal = {
			
			{ 										message = "MbDvcActFocusMapIcon", 			localFunc = "localOnFocusMapIcon" },			
		},
		Timer = {
			{ data = "Timer_SequenceChange",		message = "OnEnd", 							localFunc = "localChangeSequence" },
			{ data = "Timer_BgmChange",				message = "OnEnd", 							localFunc = "localChangeMusicIfAlert" },
			{ data = "Timer_PlayVehicleRadio",		message = "OnEnd", 							localFunc = "localPlayVehicleRadio" },
			{ data = "Timer_BackGroundRadio2",		message = "OnEnd", 							commonFunc = this.commonPlayBackGroundRadio2 },
		},
		Trap = {
			{ data = "Trap_VehicleCrash",			message = "Enter",							localFunc = "localOnVehicleEnterMinefield", },
			{ data = "Trap_VehicleCrash",			message = "Exit",							localFunc = "localOnVehicleLeaveMinefield", },
			{ data = "Trap_VehicleCrash_Player",	message = "Enter",							localFunc = "localOnPlayerEnterMinefield", },
			{ data = "Trap_VehicleCrash_Player",	message = "Exit",							localFunc = "localOnPlayerLeaveMinefield", },
			{ data = "Trap_MissionBackgroundRadio",	message = "Enter",							commonFunc = this.commonStartPlayBackGroundRadio2, },
		},
	},

	OnEnter = function()

		
		
		if TppMission.GetFlag( this.destroyFlagMap["Armored_Vehicle_WEST_000"] ) == false then
			for i, antiAirGunCharacterId in ipairs( this.antiAirGuns ) do	
				this.commonDisableMarker( antiAirGunCharacterId )
			end
			this.commonEnableMarker( "Armored_Vehicle_WEST_000" )	
		end

		
		TppData.Enable( "Armored_Vehicle_WEST_000" )		
		TppData.Enable( "e20050_uss_driver0000" )			

		
		TppCommandPostObject.GsAddRespawnRandomWeaponId( this.CP_ID, "WP_sg01_v00", 15 )
		TppCommandPostObject.GsAddRespawnRandomWeaponId( this.CP_ID, "WP_ms02", 10 )

		
		GkEventTimerManager.Start( "Timer_BgmChange", 1 )		

		
		
		TppRadio.RegisterOptionalRadio( "OptionalRadio_002" )
		
		TppRadio.EnableIntelRadio( "Armored_Vehicle_WEST_000" )
		
		TppRadio.DelayPlay( "Radio_Reinforcements", "mid", nil, {
			onEnd = function()

				TppRadio.DelayPlay( "Radio_Reinforcements2", "long", nil, {
					onStart = function()

						
						
						local commonDataManager = UiCommonDataManager.GetInstance()
						if commonDataManager ~= NULL then
							local luaData = commonDataManager:GetUiLuaExportCommonData()
							if luaData ~= NULL then

								
								luaData:SetMisionInfoCurrentStoryNo(1)									

								
								luaData:SetCurrentMissionSubGoalNo(2)

								
								local hudCommonData = HudCommonDataManager.GetInstance()				
								hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )	
								hudCommonData:AnnounceLogViewLangId( "announce_map_update" )			
								hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )			

								luaData:DisableMissionPhotoId(10)
								luaData:DisableMissionPhotoId(20)
								luaData:DisableMissionPhotoId(30)
								luaData:DisableMissionPhotoId(40)

							end
						end

					end, } )

			end } )
		
		this.SetIntelRadio()

		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker( "RV_SeaSide" )

	end,

	
	localPlayVehicleRadio = function()

		if	this.CounterList.currentWeapon == "WP_ar00_v03" or
			this.CounterList.currentWeapon == "WP_ar00_v03b" or
			this.CounterList.currentWeapon == "WP_ar00_v01" or
			this.CounterList.currentWeapon == "WP_sr01_v00" then

			TppRadio.Play( "Radio_ArmoredVehicle" )

		end

	end,

	localOnFocusMapIcon = function()

		local arg1 = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		if StringId.IsEqual32( arg1, "Armored_Vehicle_WEST_000" ) then
			TppRadio.DelayPlay( "Radio_Target", "mid" )
		end

	end,

	
	localChangeMusicIfAlert = function()

		local phaseName = TppCharacterUtility.GetCurrentPhaseName()

		local player = TppPlayerUtility.GetLocalPlayerCharacter()
		local playerPosition
		if player ~= nil then
			playerPosition = player:GetPosition()
		else
			return
		end

		local vehicle = Ch.FindCharacterObjectByCharacterId( "Armored_Vehicle_WEST_000" )
		local vehiclePosition
		if vehicle ~= nil then
			vehiclePosition = vehicle:GetPosition()
		else
			return
		end

		local length = (playerPosition - vehiclePosition):GetLength()

		if	phaseName == "Alert" and				
			length < 65 then						

			
			TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_boss' )

			
			GkEventTimerManager.Start( "Timer_PlayVehicleRadio", 10 )

		else										
			GkEventTimerManager.Stop( "Timer_BgmChange")			
			GkEventTimerManager.Start( "Timer_BgmChange", 1 )		
		end

	end,

	
	localOnPlayerEnterMinefield = function()

		TppMission.SetFlag( "isPlayerInMinefield", true )

		if TppMission.GetFlag( "isVehicleInMinefield" ) == true then
			this.Seq_DestroyTarget2.localSetVehicleCrashActionMode()
		end

	end,

	
	localOnPlayerLeaveMinefield = function()

		TppMission.SetFlag( "isPlayerInMinefield", false )

	end,

	
	localOnVehicleEnterMinefield = function()

		TppMission.SetFlag( "isVehicleInMinefield", true )

		if TppMission.GetFlag( "isPlayerInMinefield" ) == true then
			this.Seq_DestroyTarget2.localSetVehicleCrashActionMode()
		end

	end,

	
	localOnVehicleLeaveMinefield = function()

		TppMission.SetFlag( "isVehicleInMinefield", false )

	end,

	
	localSetVehicleCrashActionMode = function()

		TppCommandPostObject.GsSetGroupVehicleRoute( this.CP_ID, "Armored_Vehicle_WEST_000", "e20050_c01_route_vehicle0003", 0 )	
		TppEnemyUtility.SetForceRouteMode( "e20050_uss_driver0000", true )													
		TppVehicleUtility.SetCrashActionMode( "Armored_Vehicle_WEST_000", true )											

	end,

	
	localUnsetVehicleCrashActionMode = function()

		TppVehicleUtility.SetCrashActionMode( "Armored_Vehicle_WEST_000", false )
		TppCommandPostObject.GsSetGroupVehicleRoute( this.CP_ID, "Armored_Vehicle_WEST_000", "e20050_c01_route_vehicle0001", 0 )
		TppEnemyUtility.SetForceRouteMode( "e20050_uss_driver0000", false )

	end,

	
	localOnStrykerRoutePoint = function()

		local vehicleCharacterId = TppData.GetArgument(1)	
		local characterIds = TppData.GetArgument(2)			
		local routeId = TppData.GetArgument(3)				
		local routeNodeIndex = TppData.GetArgument(4)		

		if 	routeId == GsRoute.GetRouteId( "e20050_c01_route_vehicle0000" ) and
			routeNodeIndex == 4 then

			
			TppCommandPostObject.GsSetGroupVehicleRoute( this.CP_ID, vehicleCharacterId, "e20050_c01_route_vehicle0001", 0 )
			TppRadio.EnableIntelRadio( "Armored_Vehicle_WEST_000" )

		elseif	routeId == GsRoute.GetRouteId( "e20050_c01_route_vehicle0003" ) and
				routeNodeIndex == 1 then

			this.Seq_DestroyTarget2.localUnsetVehicleCrashActionMode()

		end

	end,

	
	localOnStrykerBroken = function()

		local characterId = TppData.GetArgument(1)								
		this.commonDestroyObject( characterId )									

		if this.commonGetDestroyFlag( "Armored_Vehicle_WEST_000" ) == true then	

			
			local hudCommonData = HudCommonDataManager.GetInstance()												
			if hudCommonData ~= nil then
				hudCommonData:AnnounceLogViewLangId( "announce_mission_goal" )									
			end

			
			
			
			if ( GZCommon.PlayerAreaName == "WareHouse" ) then
				TppMissionManager.SaveGame("30")
			elseif ( GZCommon.PlayerAreaName == "Asylum" ) then
				TppMissionManager.SaveGame("31")
			elseif ( GZCommon.PlayerAreaName == "EastCamp" ) then
				TppMissionManager.SaveGame("32")
			elseif ( GZCommon.PlayerAreaName == "WestCamp" ) then
				TppMissionManager.SaveGame("33")
			elseif ( GZCommon.PlayerAreaName == "Heliport" ) then
				TppMissionManager.SaveGame("34")
			elseif ( GZCommon.PlayerAreaName == "ControlTower_East" ) then
				TppMissionManager.SaveGame("35")
			elseif ( GZCommon.PlayerAreaName == "ControlTower_West" ) then
				TppMissionManager.SaveGame("36")
			elseif ( GZCommon.PlayerAreaName == "SeaSide" ) then
				TppMissionManager.SaveGame("37")
			else



				TppMissionManager.SaveGame("34")	
			end

			TppSequence.ChangeSequence( "Seq_CallSupportHelicopter" )				

		end

	end,

	
	localOnAntiAirGunBroken = function()

		local characterId = TppData.GetArgument(1)		
		this.commonDestroyObject( characterId )			
		TppRadio.Play( "Radio_AntiAirGunDestroyed" )	

	end,

}


this.Seq_CallSupportHelicopter = {

	Messages = {
		Character = {
			{ data = "Tactical_Vehicle_WEST_000",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Tactical_Vehicle_WEST_001",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_000",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_001",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_002",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_000",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_001",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_002",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_003",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
		},
	},

	OnEnter = function()

		
		TppRadio.RegisterOptionalRadio( "OptionalRadio_003" )	

		
		this.commonDisableMarker( "Armored_Vehicle_WEST_000" )	

		
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20050_count_al' )

		
		TppDataUtility.SetEnableDataFromIdentifier( "DataIdentifier_CheckPointTraps", "CheckPointTraps", false, true )

		
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker( "RV_SeaSide" )
		
		TppSupportHelicopterService.DisableAutoReturn()

		TppSequence.ChangeSequence( "Seq_Escape" )					

		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then

				
				luaData:SetMisionInfoCurrentStoryNo(1)

				
				luaData:DisableMissionPhotoId(10)
				luaData:DisableMissionPhotoId(20)
				luaData:DisableMissionPhotoId(30)
				luaData:DisableMissionPhotoId(40)

			end
		end

	end,

}


this.Seq_Escape = {

	Messages = {
		Character = {
			
			{ data = "Player",						message = "RideHelicopterStart",			localFunc = "localOnPlayerRideHelicopter" },

			
			{ data = this.CP_ID,					message = "EndGroupVehicleRouteMove",		localFunc = "localOnEndGroupVehicleRouteMove" },

			
			{ data = this.CHARACTER_ID_HELICOPTER,			message = "ArriveToWaitPointOnLandingZone",	localFunc = "localOnHelicopterArriveLZ" },

			{ data = "Tactical_Vehicle_WEST_000",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Tactical_Vehicle_WEST_001",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_000",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_001",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_002",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_000",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_001",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_002",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_003",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
		},
		Timer = {
			{ data = "Timer1",						message = "OnEnd",							localFunc = "OnTimer1End" },
			{ data = "Timer5",						message = "OnEnd",							localFunc = "OnTimer5End" },
			{ data = "Timer60",						message = "OnEnd",							localFunc = "OnTimer60End" },
			{ data = "Timer120",					message = "OnEnd",							localFunc = "OnTimer120End" },
			{ data = "Timer150",					message = "OnEnd",							localFunc = "OnTimer150End" },
			{ data = "Timer160",					message = "OnEnd",							localFunc = "OnTimer160End" },
			{ data = "Timer170",					message = "OnEnd",							localFunc = "OnTimer170End" },
			{ data = "Timer179",					message = "OnEnd",							localFunc = "OnTimer179End" },
			{ data = "Timer180",					message = "OnEnd",							localFunc = "OnTimer180End" },
		},
		Subtitles = {
			{ data="countdown",						message = "SubtitlesEventMessage",			localFunc = "localStartCountdown" },
		},
	},

	OnEnter = function()

		if TppSupportHelicopterService.IsDueToGoToLandingZone( this.CHARACTER_ID_HELICOPTER ) == false then	
			TppHelicopter.Call( "RV_SeaSide" )									
		end

		
		

		
		
		this.SetIntelRadio()

		
		
		TppCommandPostObject.GsAddRespawnRandomWeaponId( this.CP_ID, "WP_sg01_v00", 20 )
		TppCommandPostObject.GsAddRespawnRandomWeaponId( this.CP_ID, "WP_ms02", 15 )

		
		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then
				luaData:SetCurrentMissionSubGoalNo(3)									
				
				local hudCommonData = HudCommonDataManager.GetInstance()				
				hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )	
			end
		end

		
		
		TppSupportHelicopterService.SetDefaultRendezvousPointMarker( "RV_SeaSide" )
		
		TppSupportHelicopterService.DisableAutoReturn()

		
		GkEventTimerManager.Start( "Timer1", 1.5 )								

	end,

	
	localStartCountdown = function()

		if TppMission.GetFlag( "isCountdownStarted" ) == false then

			TppMission.SetFlag( "isCountdownStarted", true )

			
			GkEventTimerManager.Start( "Timer5", 30 )								
			GkEventTimerManager.Start( "Timer60", 60 )								
			GkEventTimerManager.Start( "Timer120", 120 )							
			GkEventTimerManager.Start( "Timer150", 150 )							
			GkEventTimerManager.Start( "Timer160", 160 )							
			GkEventTimerManager.Start( "Timer170", 170 )							
			GkEventTimerManager.Start( "Timer179", 180 )							
			GkEventTimerManager.Start( "Timer180", 181 )							

			
			local hudCommonData = HudCommonDataManager.GetInstance()
			hudCommonData:StartDisplayTimer( 180 )

		end

	end,

	
	localOnHelicopterArriveLZ = function()

		

	end,


	
	localOnEndGroupVehicleRouteMove = function()

		local vehicleGroupInfo = TppData.GetArgument( 2 )

		local routeInfoName = vehicleGroupInfo.routeInfoName									
		local vehicleCharacterId = vehicleGroupInfo.vehicleCharacterId							
		local routeId = vehicleGroupInfo.vehicleRouteId											
		local memberCharacterIds = vehicleGroupInfo.memberCharacterIds							
		local result = vehicleGroupInfo.result													
		local reason = vehicleGroupInfo.reason													

		if	routeInfoName ~= "TppGroupVehicleDefaultRideRouteInfo0001" or						
			result == "FAILURE" then															

			return																					

		end

		TppMission.SetFlag( "isFinishLightVehicleGroup", true )									
		this.commonRestoreRoute()																

	end,

	
	localOnPlayerRideHelicopter = function()

		GkEventTimerManager.Stop( "Timer180" )
		GkEventTimerManager.Stop( "Timer179" )	
		GkEventTimerManager.Stop( "Timer170" )
		GkEventTimerManager.Stop( "Timer160" )
		GkEventTimerManager.Stop( "Timer150" )
		GkEventTimerManager.Stop( "Timer120" )
		GkEventTimerManager.Stop( "Timer60" )
		GkEventTimerManager.Stop( "Timer5" )

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:EraseDisplayTimer()

	end,

	
	OnTimer1End = function()

		
		GkEventTimerManager.Stop( "Timer1" )

		
		TppRadio.PlayStrong( "Radio_CompletionBreakTarget1", {
			onEnd = function()
				this.Seq_Escape.localStartCountdown()	
			end } )

	end,

	
	OnTimer5End = function()

		GkEventTimerManager.Stop( "Timer5" )
		TppRadio.PlayStrong( "Radio_Escape_TimeLeft_150s" )

	end,

	
	OnTimer60End = function()

		GkEventTimerManager.Stop( "Timer60" )
		TppRadio.PlayStrong( "Radio_Escape_TimeLeft_120s" )

	end,

	
	OnTimer120End = function()

		GkEventTimerManager.Stop( "Timer120" )
		TppRadio.PlayStrong( "Radio_Escape_TimeLeft_060s" )

	end,

	
	OnTimer150End = function()

		GkEventTimerManager.Stop( "Timer150" )
		if TppSupportHelicopterService.IsDueToGoToLandingZone( this.CHARACTER_ID_HELICOPTER ) == false then	
			TppRadio.PlayStrong( "Radio_Escape_TimeLeft_030s_2" )
		else
			TppRadio.PlayStrong( "Radio_Escape_TimeLeft_030s" )
		end

	end,

	
	OnTimer160End = function()

		GkEventTimerManager.Stop( "Timer160" )
		TppRadio.PlayStrong( "Radio_Escape_TimeLeft_020s" )

	end,

	
	OnTimer170End = function()

		GkEventTimerManager.Stop( "Timer170" )
		TppRadio.PlayStrong( "Radio_Escape_TimeLeft_010s" )

	end,

	
	OnTimer179End = function()

		
		GkEventTimerManager.Stop( "Timer179" )

		
		
		TppSupportHelicopterService.ChangeRouteWithNodeIndex( "ReturnRoute_SeaSide", 3)

		
		
		

		
		TppPlayerUtility.SetDisableActionsWithName{ name = "DisableRideHelicopter_e20050", disableActions = {"DIS_ACT_RIDE_HELICOPTER"} }

		
		TppPadOperatorUtility.SetMasksForPlayer( 0, "CameraOnly")											

	end,

	
	OnTimer180End = function()

		
		GkEventTimerManager.Stop( "Timer180" )

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:EraseDisplayTimer()

		
		
		TppSupportHelicopterService.ChangeRouteWithNodeIndex( "ReturnRoute_SeaSide", 3)

		
		TppHelicopter.SetStatus( "leftDoor_close" )
		TppHelicopter.SetStatus( "rightDoor_close" )

		
		TppPlayerUtility.SetDisableActionsWithName{ name = "DisableRideHelicopter_e20050", disableActions = {"DIS_ACT_RIDE_HELICOPTER"} }

		

		
		TppMission.ChangeState( "failed", "TimeOver", { disableGame = false, disablePlayerPad = false,	} )	
		TppPadOperatorUtility.SetMasksForPlayer( 0, "CameraOnly")											

	end,

}


this.Seq_PlayerRideHelicopter = {

	Messages = {
		Character = {
			{ data = "Tactical_Vehicle_WEST_000",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Tactical_Vehicle_WEST_001",	message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_000",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_001",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
			{ data = "Cargo_Truck_WEST_002",		message = "VehicleBroken",					commonFunc = this.commonOnNonTargetBroken },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_000",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_001",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_002",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
			{ data = "gntn_area01_antiAirGun_003",	message = "AntiAircraftGunBroken",			commonFunc = this.commonOnNonTargetBroken },
		},
	},

	OnEnter = function()

	end,

}


this.Seq_PlayMissionClearDemo = {

	MissionState = "clear",

	OnEnter = function()

		
		TppEnemyUtility.IgnoreCpRadioCall( true )
		TppEnemyUtility.StopAllCpRadio( 1.0 )

		
		if this.CounterList.lastRendezvouzPoint == "RV_SeaSide" then
			TppDemo.Play( "Demo_MissionClear", {
				onEnd = function()													

					TppUI.FadeOut( 0 )
					TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )	

				end,
				}, { disableHelicopter = false } )
		else
			TppDemo.Play( "Demo_MissionClear_NotSmooth", {
				onEnd = function()													

					TppUI.FadeOut( 0 )
					TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )	

				end,
				}, { disableHelicopter = false } )
		end




		PlatformConfiguration.SetVideoRecordingEnabled(false) 

	end,

	OnLeave = function()

	end,

}


this.Seq_MissionClearShowTransition = {

	MissionState = "clear",

	Messages = {
		UI = {
			
			{ message = "EndMissionTelopFadeIn" ,	localFunc = "OnFinishClearFade" },
		},
	},

	
	OnFinishClearFade = function()

		TppMusicManager.PlaySceneMusic( "Stop_bgm_e20050_count" )
		TppMusicManager.EndSceneMode()

		
		TppSoundDaemon.SetMute( 'Result' )
		

		
		local Rank = PlayRecord.GetRank()
		if( Rank == 0 ) then



		elseif( Rank == 1 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_s" )
		elseif( Rank == 2 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_ab" )
		elseif( Rank == 3 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_ab" )
		elseif( Rank == 4 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_cd" )
		elseif( Rank == 5 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_cd" )
		else
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_gntn_ed_default_e" )
		end

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		
		local rank = PlayRecord.GetRank()
		if rank == 0 then								
			TppRadio.Play( "Radio_GameClear_Bad" )
		elseif rank == 1 then							
			TppRadio.Play( "Radio_GameClear_Great" )
			Trophy.TrophyUnlock( 4 )						
		elseif rank == 2 then							
			TppRadio.Play( "Radio_GameClear_VeryGood" )
		elseif rank == 3 then							
			TppRadio.Play( "Radio_GameClear_Good" )
		elseif rank == 4 then							
			TppRadio.Play( "Radio_GameClear_Normal" )
		elseif rank == 5 then							
			TppRadio.Play( "Radio_GameClear_Bad" )
		elseif rank == 6 then							
			TppRadio.Play( "Radio_GameClear_Bad" )
		end

	end,

	OnEnter = function()

		TppRadioConditionManagerAccessor.Unregister( "Tutorial" )	 
		TppRadioConditionManagerAccessor.Unregister( "Basic" )

		TppUI.ShowTransition( "ending", {
			onStart = function()
				TppUI.FadeOut( 0 )
			end,
			onEnd = function()
				TppSequence.ChangeSequence( "Seq_MissionClear" )
			end,
		} )

	end,

}


this.Seq_MissionClear = {

	MissionState = "clear",

	OnEnter = function()




		PlatformConfiguration.SetShareScreenEnabled(false) 

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		
		TppRadio.Play( "Radio_AfterGameClear", {
			onStart = function() TppMusicManager.PostJingleEvent( 'SingleShot', 'Set_Switch_bgm_gntn_ed_default_lp' ) end,
			onEnd = function()
				TppSequence.ChangeSequence( "Seq_ShowClearReward" )
			end
		}, nil, nil, "none"  )

	end,

	OnUpdate = function()

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		if hudCommonData:IsPushRadioSkipButton() == true then
			
			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()
			TppSequence.ChangeSequence( "Seq_ShowClearReward" )
		end

	end,

}


this.Seq_MissionFailedRideHelicopter = {

	MissionState = "failed",

	OnEnter = function()

		this.CounterList.GameOverRadioName = "Radio_GameOver_PlayerRideHelicopter"
		TppSequence.ChangeSequence( "Seq_MissionGameOver" )							

	end,

}


this.Seq_MissionFailedTimeOver = {

	MissionState = "failed",

	Messages = {
		Demo = {
			{ data = "p12_040020_000",	message = "snakeWarp",	localFunc = "localOnPlayerCamera", },
			{ data = "p12_040030_000",	message = "snakeWarp",	localFunc = "localOnPlayerCamera", },
		},
	},

	OnEnter = function()

		
		
		TppEnemyUtility.IgnoreCpRadioCall( true )
		TppEnemyUtility.StopAllCpRadio( 1.0 )
		
		GZCommon.OutsideAreaEffectDisable()

		
		local characterId = nil
		if characterId ~= nil then
			MissionManager.RegisterNotInGameRealizeCharacter( characterId )
		end

		if TppPlayerUtility.IsNormalState() == true or TppPlayerUtility.GetCarriedCharacterId() ~= "" then

 			TppDemo.Play( "Demo_MissionFailure", {
				onEnd = function()

					FadeFunction.SetFadeColor( 255, 255, 255, 255 )									
					TppUI.FadeOut( 0 )																

					TppPlayerUtility.ResetDisableActionsWithName("DisableRideHelicopter_e20050")	

					this.CounterList.GameOverRadioName = "Radio_GameOver_MissionFail"
					FadeFunction.ResetFadeColor()											

					TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_000", false )	
					TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_001", false )	
					TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_002", false )	

					GZCommon.StopSirenForcibly()

					TppSequence.ChangeSequence( "Seq_MissionGameOver" )						

				end
				},
				{	disableGame = false,			
					
					disableHelicopter = false,		
					disablePlayerPad = false,		
					
					disableDemoEnemies = true
				}
				)

		else

			TppDemo.Play( "Demo_MissionFailureNoPlayerReaction", {
				onEnd = function()

					FadeFunction.SetFadeColor( 255, 255, 255, 255 )									
					TppUI.FadeOut( 0 )																

					TppPlayerUtility.ResetDisableActionsWithName("DisableRideHelicopter_e20050")	

					this.CounterList.GameOverRadioName = "Radio_GameOver_MissionFail"
					FadeFunction.ResetFadeColor()											

					TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_000", false )	
					TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_001", false )	
					TppHostageManager.GsSetStruggleFlag( "Hostage_e20050_002", false )	

					GZCommon.StopSirenForcibly()

					TppSequence.ChangeSequence( "Seq_MissionGameOver" )						

				end
				},
				{	disableGame = false,			
					
					disableHelicopter = false,		
					disablePlayerPad = false,		
					
				}
				)

		end

	end,

	
	localOnPlayerCamera = function()





		local playerObject = Ch.FindCharacterObjectByCharacterId( "Player" )
		local playerPosition = playerObject:GetPosition()

		if playerPosition:GetY() < 4.25 then





			TppCharacterUtility.WarpCharacterIdFromIdentifier( "Player", "e20050_warpLocators", "SeaSide0000" )

		end

	end,

}


this.Seq_MissionFailedOutsideMissionArea = {

	
	MissionState = "failed",

	Messages = {
		Timer = {
			{ data = "MissionFailedProductionTimer",	message = "OnEnd", 	localFunc="OnFinishMissionFailedProduction" },
		},
	},

	
	OnFinishMissionFailedProduction = function()





		TppSequence.ChangeSequence( "Seq_MissionGameOver" )								

	end,


	OnEnter = function( manager )




		TppPlayerUtility.ResetDisableActionsWithName("DisableRideHelicopter_e20050")	
		this.CounterList.GameOverRadioName = "Radio_GameOver_MissionArea"

		
		TppTimer.Start( "MissionFailedProductionTimer", this.CounterList.GameOverFadeTime )

	end,

}


this.Seq_MissionFailedHelicopterDead = {

	MissionState = "failed",

	OnEnter = function()

		
		TppPlayerUtility.ResetDisableActionsWithName("DisableRideHelicopter_e20050")	

		this.CounterList.GameOverRadioName = "Radio_GameOver_HelicopterDead"

		TppSequence.ChangeSequence( "Seq_MissionGameOver" )								

	end,

}


this.Seq_MissionFailedPlayerDead = {

	MissionState = "failed",

	Messages = {
		Timer = {
			{ data = "MissionFailedProductionTimer",	message = "OnEnd", 	localFunc="OnFinishMissionFailedProduction" },
		},
	},

	OnEnter = function()

		TppPlayerUtility.ResetDisableActionsWithName("DisableRideHelicopter_e20050")			
		GkEventTimerManager.Start( "MissionFailedProductionTimer", this.CounterList.GameOverFadeTime )	

	end,

	
	OnFinishMissionFailedProduction = function( manager )

		this.CounterList.GameOverRadioName = "Radio_GameOver_PlayerDead"
		TppSequence.ChangeSequence( "Seq_MissionGameOver" )										

	end,

}



this.Seq_MissionGameOver = {

	MissionState = "gameOver",

	Messages = {
		UI = {
			{ message = "GameOverOpen" ,	localFunc = "OnFinishGameOverFade" },	
		},
	},

	
	OnFinishGameOverFade = function()

		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )	
		TppRadio.DelayPlay( this.CounterList.GameOverRadioName, nil, "none" )	

	end,

	OnEnter = function()

	end,
}


this.Seq_ShowClearReward = {

	MissionState = "clear",

	Messages = {
		UI = {
			
			
			
			{	message = "BonusPopupAllClose",	commonFunc = function() TppSequence.ChangeSequence( "Seq_MissionEnd" ) end },		},
	},

	OnEnter = function()




		PlatformConfiguration.SetShareScreenEnabled(true) 

		
		this.OnShowRewardPopupWindow()

	end,

}


this.Seq_MissionEnd = {

	OnEnter = function()

		this.commonMissionCleanUp()		
		
		TppMusicManager.PostJingleEvent( "SingleShot", "Stop_bgm_gntn_ed_default" )

		TppMissionManager.SaveGame()		

		TppMission.ChangeState( "end" )	




		PlatformConfiguration.SetVideoRecordingEnabled(true)	

	end,

}




return this
