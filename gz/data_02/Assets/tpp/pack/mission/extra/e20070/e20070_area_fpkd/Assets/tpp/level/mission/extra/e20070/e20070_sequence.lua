local this = {}




this.missionID							= 20070
this.CP_ID								= "e20070_cp"
this.CHARACTER_ID_SUPPORT_HELICOPTER	= "SupportHelicopter"
this.CHARACTER_ID_ENEMY_IN_HELICOPTER	= "EnemyInHelicopter"
this.CHARACTER_ID_ENEMY_IN_HELICOPTER2	= "EnemyInHelicopter2"
this.CHARACTER_ID_ENEMY_HELICOPTER		= "EnemyHelicopter"
this.ROUTE_NAME_ENEMY_HELICOPTER		= "e20070_route_enemyHeli0001"
this.CHARACTER_ID_ENEMY_VEHICLE			= "Tactical_Vehicle_WEST_001"
this.CHARACTER_ID_HUMAN_DRIVER			= "HumanEnemy0003"
this.CHARACTER_ID_ALIEN_DRIVER			= "AlienEnemy0007"


this.ChallengeLogo						= 8

this.doorMax = 10

this.initialHumanEnemies = {
	this.CHARACTER_ID_HUMAN_DRIVER,
	"HumanEnemy0000",
	"HumanEnemy0001",
	"HumanEnemy0002",
}

this.initialAlienEnemies = {
	"AlienEnemy0000",
	"AlienEnemy0001",
	"AlienEnemy0002",
	"AlienEnemy0003",
	"AlienEnemy0004",
	"AlienEnemy0005",
	"AlienEnemy0006",
	this.CHARACTER_ID_ALIEN_DRIVER,
}

this.reinforcements_1_1_AlienEnemies = {
	"Reinforcements_1_1_AlienEnemy0000",
	"Reinforcements_1_1_AlienEnemy0001",
	"Reinforcements_1_1_AlienEnemy0002",
	"Reinforcements_1_1_AlienEnemy0003",
	"Reinforcements_1_1_AlienEnemy0004",
	"Reinforcements_1_1_MissileAlienEnemy0000",
}

this.reinforcements_1_2_AlienEnemies = {
	"Reinforcements_1_2_MissileAlienEnemy0000",
	"Reinforcements_1_2_MissileAlienEnemy0001",
}

this.reinforcements_2_1_AlienEnemies = {
	"Reinforcements_2_1_AlienEnemy0000",
	"Reinforcements_2_1_AlienEnemy0001",
	"Reinforcements_2_1_AlienEnemy0002",
	"Reinforcements_2_1_AlienEnemy0003",
	"Reinforcements_2_1_AlienEnemy0004",
	"Reinforcements_2_1_AlienEnemy0005",
	"Reinforcements_2_1_AlienEnemy0006",
	"Reinforcements_2_1_AlienEnemy0007",
}

this.reinforcements_2_2_AlienEnemies = {
	"Reinforcements_2_2_AlienEnemy0000",
	"Reinforcements_2_2_AlienEnemy0001",
	"Reinforcements_2_2_AlienEnemy0003",
}

this.areas = {
	"Area_AdministrationBuilding",
	"Area_Camp_East_North",
	"Area_Camp_East_South",
	"Area_Camp_West",
	"Area_Heliport_East",
	"Area_Heliport_West",
	"Area_PrisonCompound",
	"Area_WareHouse_North",
	"Area_WareHouse_South",
	"Area_StartCliff",
}

this.reinforcements1Map = {}
for i, characterId in pairs( this.reinforcements_1_1_AlienEnemies ) do
	this.reinforcements1Map[ characterId ] = this.reinforcements_1_2_AlienEnemies[ i ]
end

this.reinforcements2Map = {}









this.RequiredFiles = {
	"/Assets/tpp/script/common/GZCommon.lua",
}

this.Sequences = {
	
	{ "Seq_MissionPrepare" },
	{ "Seq_LoadOpeningDemo" },
	{ "Seq_OpeningShowTransition" },
	
	{ "Seq_OpeningDemo" },
	{ "Seq_SearchAndDestroy" },
	{ "Seq_GotoHeliport" },
	{ "Seq_AppearReinforcements1" },
	{ "Seq_BattleInHeliport1" },
	{ "Seq_BattleInHeliport1_1" },
	{ "Seq_AppearReinforcements2" },
	{ "Seq_BattleInHeliport2" },
	{ "Seq_BattleInHeliport2_2" },
	{ "Seq_PlayerRideHelicopter" },
	{ "Seq_HelicopterMove" },
	
	{ "Seq_MissionClearShowTransition" },
	{ "Seq_MissionClear" },
	{ "Seq_ShowClearReward" },
	
	{ "Seq_MissionFailed" },
	{ "Seq_MissionFailed_HelicopterDeadNotPlayerOn" },
	{ "Seq_MissionGameOver" },
	{ "Seq_MissionFailedOutsideMissionArea" },
	
	{ "Seq_MissionEnd" },
}

this.ChangeExecSequenceList =  {
	"Seq_OpeningDemo",
	"Seq_SearchAndDestroy",
	"Seq_GotoHeliport",
	"Seq_AppearReinforcements1",
	"Seq_BattleInHeliport1",
	"Seq_AppearReinforcements2",
	"Seq_BattleInHeliport2",
}

this.OnStart = function( manager )
	GZCommon.Register( this, manager )
	TppMission.Setup()
end

this.OnEnterCommon = function()

	local sequence = TppSequence.GetCurrentSequence()
	Fox.Log( "=== " .. sequence .. " : OnEnter ===" )

	
	if TppGameSequence.GetGameFlag( "playerSkinMode" ) == 1 then
		TppCharacterUtility.ChangeFormVariationWithCharacterId( "Player", "rai0_v03_fova" ) 	
	elseif TppGameSequence.GetGameFlag( "playerSkinMode" ) == 2 then
		TppCharacterUtility.ChangeFormVariationWithCharacterId( "Player", "rai0_v02_fova" ) 	
	else
		TppCharacterUtility.ChangeFormVariationWithCharacterId( "Player", "rai0_v01_fova" ) 	
	end

end

this.OnLeaveCommon = function()
	local sequence = TppSequence.GetCurrentSequence()
	Fox.Log( "=== " .. sequence .. " : OnLeave ===" )
end





this.onMissionPrepare = function()

	
	GZCommon.MissionSetup()

	
	TppPlayerUtility.ChangeLocalPlayerType("PLTypeRaiden")

	
	TppMusicManager.ChangeParameter( "bgm_mgr" )

	
	WeatherManager.RequestTag("default", 0 )
	TppEffectUtility.RemoveColorCorrectionLut()
	TppEffectUtility.SetColorCorrectionLut( "MGS1_FILTERLUT_r1" )
	TppClock.SetTime( "00:00:00" )
	TppClock.Stop()
	TppWeather.SetWeather( "cloudy" )
	GrTools.SetLightingColorScale(2.0)
	TppPlayer.SetWeapons( GZWeapon.e20070_SetWeapons )

	
	

	if( TppMission.GetFlag( "isMakeLA" ) == true or TppMission.GetFlag( "isMakeFox" ) == true )then
		TppRadio.DisableIntelRadio( "radio_kjpLogo" )
	else
		TppRadio.EnableIntelRadio( "radio_kjpLogo" )
	end
	TppRadio.EnableIntelRadio( "gntn_serchlight_20070_0" )
	TppRadio.EnableIntelRadio( "gntn_serchlight_20070_1" )
	TppRadio.EnableIntelRadio( "intelMark_gz" )				
	TppRadio.EnableIntelRadio( "intelMark_mg" )
	TppRadio.EnableIntelRadio( "intelMark_mg2" )
	TppRadio.EnableIntelRadio( "intelMark_mgs" )
	TppRadio.EnableIntelRadio( "intelMark_mgs2" )
	TppRadio.EnableIntelRadio( "intelMark_mgs3" )
	TppRadio.EnableIntelRadio( "intelMark_mgs4" )
	TppRadio.EnableIntelRadio( "e20070_logo_001" )
	TppRadio.EnableIntelRadio( "intelMark_002" )
	
	this.SetIntelRadio()
	
	TppRadio.RegisterOptionalRadio( "OptionalRadio_010" )
	
	TppRadioConditionManagerAccessor.Register( "Tutorial", TppRadioConditionTutorialPlayer{ time = 1.5 } )
	TppRadioConditionManagerAccessor.Register( "Basic", TppRadioConditionPlayerBasic{ time = 0.3 } )

	
	local angle = 120
	TppGimmick.OpenDoor( "AsyPickingDoor01", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor04", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor05", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor15", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor08", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor09", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor13", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor16", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor17", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor21", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor22", angle )
	TppGimmick.OpenDoor( "AsyPickingDoor23", angle )

	
	if ( TppMission.GetFlag( "isGetWeapon" ) == true ) then
		TppEffect.HideEffect( "fx_weaponLight")
	else
		TppEffect.ShowEffect( "fx_weaponLight" )
	end

	
	if ( TppMission.GetFlag( "isBreakWood" ) == true ) then
		TppCharacterUtility.SetEnableCharacterId( "e20070_marker_charenge08", false )
	else
		TppCharacterUtility.SetEnableCharacterId( "e20070_marker_charenge08", true )
	end

	
	
	if TppMission.GetFlag( "isVehicleStarted" ) == false then
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ENEMY_VEHICLE, false )
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ALIEN_DRIVER, false )
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_HUMAN_DRIVER, false )
	end
	if TppMission.GetFlag( "isGroupVehicleEnd" ) == true then
		
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_ride_route0000", false )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_ride_route0001", false )
	else
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_ride_route0000", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_ride_route0001", false )
	end
	
	if TppMission.GetFlag( "isWoodTurret03Broken" ) == false then
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_d01_route0000", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_c01_route0000", false )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_d01_route0013", false )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_c01_route0032", false )
	else
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_d01_route0000", false )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_c01_route0000", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_d01_route0013", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_c01_route0032", false )
	end
	
	if TppMission.GetFlag( "isSearchLight02Broken" ) == false then
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_d01_route0014", false )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_c01_route0033", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_d01_route0002", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_c01_route0002", false )
	else
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_d01_route0002", false )
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_c01_route0002", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_d01_route0014", false )
		TppCommandPostObject.GsDeleteDisabledRoutes( this.CP_ID, "e20070_c01_route0033", false )
	end
	
	local cpRouteSets = {
		{
			cpID = this.CP_ID,
			sets = {
				sneak_night = "e20070_route_d01",
				caution_night = "e20070_route_c01",
				
			},
		},
	}
	TppEnemy.SetRouteSets( cpRouteSets, { forceUpdate = true, forceReload = true, startAtZero = true, warpEnemy = false } )

	
	TppCommandPostObject.GsSetGuardTargetValidity( this.CP_ID, "TppGuardTargetData_VipA0003", false )	

	
	
	for i, characterId in ipairs( this.initialHumanEnemies ) do
		TppEnemyUtility.SetLifeFlagByCharacterId( characterId, "NeverDown" )
	end

	
	TppSupportHelicopterService.InitializeLife( 60000 )	
	TppSupportHelicopterService.SearchLightOn()			

	
	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager ~= NULL then
		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData ~= NULL then

			
			luaData:SetTopMenuItemActive( "gz_helicopter", false )

			luaData:ResetMisionInfoCurrentStoryNo() 

			
			luaData:EnableMissionPhotoId( 10 )
			luaData:SetAdditonalMissionPhotoId( 10, true, false )

			
			luaData:SetupIconUniqueInformationTable(

				{ markerId = "gntn_area01_antiAirGun_000",		langId = "marker_info_gimmick_weapon" },
				{ markerId = "gntn_area01_antiAirGun_001",		langId = "marker_info_gimmick_weapon" },
				{ markerId = "gntn_area01_antiAirGun_002",		langId = "marker_info_gimmick_weapon" },
				{ markerId = "gntn_area01_antiAirGun_003",		langId = "marker_info_gimmick_weapon" },

				{ markerId = "Tactical_Vehicle_WEST_000",		langId = "marker_info_vehicle_4wd" },
				{ markerId = "Tactical_Vehicle_WEST_001",		langId = "marker_info_vehicle_4wd" },

				{ markerId = "common_marker_Area_EastCamp",		langId = "marker_info_area_00" },					
				{ markerId = "common_marker_Area_WestCamp",		langId = "marker_info_area_01" },					
				{ markerId = "common_marker_Area_WareHouse",	langId = "marker_info_area_02" },					
				{ markerId = "common_marker_Area_HeliPort",		langId = "marker_info_area_03" },					
				{ markerId = "common_marker_Area_Center",		langId = "marker_info_area_04" },					
				{ markerId = "common_marker_Area_Asylum",		langId = "marker_info_area_05" },					
				{ markerId = "common_marker_Armory_WareHouse",	langId = "marker_info_place_armory" },				
				{ markerId = "common_marker_Armory_HeliPort",	langId = "marker_info_place_armory" },				
				{ markerId = "common_marker_Armory_Center",		langId = "marker_info_place_armory" },				

				
				{ markerId = "e20070_logo_101",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_102",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_103",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_104",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_105",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_106",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_107",					langId = "marker_info_logo" },
				{ markerId = "e20070_logo_001",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge02",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge03",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge04",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge05",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge06",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge07",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_marker_charenge08",					langId = "marker_info_logoArea" },
				{ markerId = "e20070_logo_001",		langId = "marker_info_logoArea" },

				
				{ markerId = "marker_e20070_heliport",			langId = "marker_info_RV" }

			)

			
			luaData:RegisterIconUniqueInformation{ markerId="gz_own_player_marker", langId="marker_info_raiden" }	

		end
	end

	
	TppNewCollectibleUtility.PutCollectibleOnCharacter{ id = "WP_sg01_v00", count = 90, target = "Cargo_Truck_WEST_000" , attachPoint = "CNP_USERITEM" }

	
	TppGimmick.OpenDoor( "Paz_PickingDoor00", 270 )

	
	TppCharacterUtility.SetEnableCharacterId( "gntn_area01_searchLight_004", false )
	TppCharacterUtility.SetEnableCharacterId( "gntn_area01_searchLight_002", false )

	
	this.CounterList.dyingEnemies = {}
	this.CounterList.clearedEnemies = {}

	
	MissionManager.SetMiddleTextureWaitParameter( 0.5, 5 )

end


this.commonLoadDemoBlock = function()

	TppMission.LoadDemoBlock( "/Assets/tpp/pack/mission/extra/e20070/e20070_d01.fpk" )	
	TppMission.LoadEventBlock("/Assets/tpp/pack/location/gntn/gntn_heli.fpk" )	

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

this.SetIntelRadio = function()
	local sequence = TppSequence.GetCurrentSequence()
	Fox.Log("================== SetIntelRadio ====================== " .. sequence)

	
	TppRadio.DisableIntelRadio( "WoodTurret01" )
	TppRadio.DisableIntelRadio( "WoodTurret02" )
	TppRadio.DisableIntelRadio( "WoodTurret03" )
	TppRadio.DisableIntelRadio( "WoodTurret04" )
	TppRadio.DisableIntelRadio( "WoodTurret05" )
	
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret01", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret02", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret03", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret04", false )
	TppPlayerUtility.SetPlayerSightSearchInfoRadioEnable( "WoodTurret05", false )
	

	if ( sequence == "Seq_SearchAndDestroy" ) then
		
		TppRadio.EnableIntelRadio( "Tactical_Vehicle_WEST_000" )
		TppRadio.EnableIntelRadio( "Tactical_Vehicle_WEST_001" )
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_000" )
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_001" )
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_002" )
		TppRadio.EnableIntelRadio( "gntn_area01_antiAirGun_003" )
		TppRadio.EnableIntelRadio( "e20070_SecurityCamera_01" )
		TppRadio.EnableIntelRadio( "e20070_SecurityCamera_02" )
		TppRadio.EnableIntelRadio( "e20070_SecurityCamera_03" )
		TppRadio.EnableIntelRadio( "e20070_SecurityCamera_04" )
		TppRadio.EnableIntelRadio( "e20070_SecurityCamera_05" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0110" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0120" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0130" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0140" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0150" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0190" )
		TppRadio.EnableIntelRadio( "intel_f0090_esrg0200" )
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
	else
		
		TppRadio.DisableIntelRadio( "Tactical_Vehicle_WEST_000" )
		TppRadio.DisableIntelRadio( "Tactical_Vehicle_WEST_001" )
		TppRadio.DisableIntelRadio( "gntn_area01_antiAirGun_000" )
		TppRadio.DisableIntelRadio( "gntn_area01_antiAirGun_001" )
		TppRadio.DisableIntelRadio( "gntn_area01_antiAirGun_002" )
		TppRadio.DisableIntelRadio( "gntn_area01_antiAirGun_003" )
		TppRadio.DisableIntelRadio( "e20070_SecurityCamera_01" )
		TppRadio.DisableIntelRadio( "e20070_SecurityCamera_02" )
		TppRadio.DisableIntelRadio( "e20070_SecurityCamera_03" )
		TppRadio.DisableIntelRadio( "e20070_SecurityCamera_04" )
		TppRadio.DisableIntelRadio( "e20070_SecurityCamera_05" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0110" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0120" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0130" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0140" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0150" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0190" )
		TppRadio.DisableIntelRadio( "intel_f0090_esrg0200" )
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
		TppRadio.DisableIntelRadio( "gntnCom_drum0101" )
	end
end

this.commonOutsideMissionWarningAreaEnter = function()

	TppRadio.Play( "Radio_WarningMissionArea" )

end

this.commonOutsideMissionWarningAreaExit = function()

end

this.commonOutsideMissionArea = function()

	TppMission.ChangeState( "failed", "OutsideMissionArea" )

end

this.commonOnPlayerRideHelicopter = function()

	if TppMission.GetFlag( "isAllTargetKlled" ) == true then

		TppRadio.Play( "Radio_RideHeli_Clear" )
		TppSequence.ChangeSequence( "Seq_PlayerRideHelicopter" )

	else

		TppRadio.Play( "Radio_RideHeli_Failure" )
		TppSupportHelicopterService.SetEnableGetOffTime( GZCommon.WaitTime_HeliTakeOff )

	end

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
end

this.commonOnCloseHeliDoor = function()

	if TppMission.GetFlag( "isAllTargetKlled" ) == true then
		TppMission.ChangeState( "clear" )
	else
		TppMission.ChangeState( "failed", "RideHelicopter" )	
	end

end


this.commonOnHelicopterDead = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	if characterId == this.CHARACTER_ID_SUPPORT_HELICOPTER then

		
		local sequence = TppSequence.GetCurrentSequence()
		if sequence == "Seq_HelicopterMove" then
			TppMission.ChangeState( "failed", "HelicopterDead" )	
		else
			
		end

	end

end


this.OnShowRewardPopupWindow = function()
	Fox.Log("OnShowRewardPopupWindow")
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	local challengeString = PlayRecord.GetOpenChallenge()
	local uiCommonData = UiCommonDataManager.GetInstance()
	local AllHardClear = PlayRecord.IsAllMissionClearHard()
	local AllChicoTape = GZCommon.CheckReward_AllChicoTape()
	local Rank = PlayRecord.GetRank()
	local hardMode = TppGameSequence.GetGameFlag("hardmode")
	Fox.Log("-------RANK_IS__"..Rank.."__BESTRANK_IS__"..this.tmpBestRank )

	
	local RewardAllCount = uiCommonData:GetRewardAllCount( this.missionID )
	Fox.Log("**** ShowRewardAllCount::"..RewardAllCount)
	
	hudCommonData:SetBonusPopupCounter( this.tmpRewardNum, RewardAllCount )

	
	
	while ( challengeString ~= "" ) do
		Fox.Log("-------OnShowRewardPopupWindow:challengeString:::"..challengeString)

		
		hudCommonData:ShowBonusPopupCommon( challengeString )
		
		challengeString = PlayRecord.GetOpenChallenge()
	end

	
	while ( Rank < this.tmpBestRank ) do
		Fox.Log("-------OnShowRewardPopupWindow:ClearRankRewardItem-------"..this.tmpBestRank)

		this.tmpBestRank = ( this.tmpBestRank - 1 )
		if ( this.tmpBestRank == 4 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankC, "WP_hg02_v00" )
		elseif ( this.tmpBestRank == 3 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankB, "WP_sr01_v00" )
		elseif ( this.tmpBestRank == 2 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankA, "WP_ms02" )
		elseif ( this.tmpBestRank == 1 ) then
			hudCommonData:ShowBonusPopupItem( this.ClearRankRewardPopupList.RankS, "WP_ar00_v05", { isBarrel=true } )
		end
	end

	
	
	if ( AllChicoTape == true and
			 uiCommonData:IsHaveCassetteTape( "tp_chico_08" ) == false ) then
		Fox.Log("-------OnShowRewardPopupWindow:GetCompChico-------")

		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_allchico" )

		
		uiCommonData:GetBriefingCassetteTape( "tp_chico_08" )

	end

	
	
	if ( AllHardClear == true and
			 uiCommonData:IsHaveCassetteTape( "tp_bgm_01" ) == false ) then
		Fox.Log("-------OnShowRewardPopupWindow:GetAnubis-------")

		
		hudCommonData:ShowBonusPopupItemTape( "reward_get_tape_tp_bgm_01" )

		
		uiCommonData:GetBriefingCassetteTape( "tp_bgm_01" )

	end

	
	Fox.Log( "e20070_sequence.OnShowRewardPopupWindow(): skin reward" )
	if TppGameSequence.GetGameFlag("hardmode") == true then				
		Fox.Log( "e20070_sequence.OnShowRewardPopupWindow(): hardmode" )

		if TppGameSequence.GetGameFlag("isSkin2Enabled") == false then	
			Fox.Log( "e20070_sequence.OnShowRewardPopupWindow(): Open Skin2" )

			
			hudCommonData:ShowBonusPopupCommon( "reward_open_raiden_b_20070" )

			
			TppGameSequence.SetGameFlag("isSkin2Enabled", true)
			

		end

	else
		Fox.Log( "e20070_sequence.OnShowRewardPopupWindow(): normalmode" )

		if TppGameSequence.GetGameFlag("isSkin1Enabled") == false then 
			Fox.Log( "e20070_sequence.OnShowRewardPopupWindow(): Open Skin1" )

			
			hudCommonData:ShowBonusPopupCommon( "reward_open_raiden_w_20070" )

			
			TppGameSequence.SetGameFlag("isSkin1Enabled", true)
			

		end

	end

	if	TppGameSequence.GetGameFlag("hardmode") == false and					
		PlayRecord.GetMissionScore( 20070, "NORMAL", "CLEAR_COUNT" ) == 1 then	

		hudCommonData:ShowBonusPopupCommon( "reward_extreme" )						

	end

	
	if ( hudCommonData:IsShowBonusPopup() == false ) then
		Fox.Log("-------OnShowRewardPopupWindow:NoPopup!!-------")
		TppSequence.ChangeSequence( "Seq_MissionEnd" )	
	end

end

this.OnClosePopupWindow = function()

	local LangIdHash = TppData.GetArgument(1)

	if ( LangIdHash == this.tmpChallengeString ) then
		this.OnShowRewardPopupWindow()
	end

end


this.commonOnMissionClear = function( manager, messageId, message )

	TppSequence.ChangeSequence( "Seq_MissionClearShowTransition" )
	Trophy.TrophyUnlock( 2 )									

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
		return

	elseif message == "RideHelicopter" then
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_mission_abort" )	

		this.CounterList.GameOverRadioName = "Radio_GameOver_RideHelicopter"
	elseif message == "HelicopterDead" then
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_heli_destroyed" )	

		this.CounterList.GameOverRadioName = "Radio_GameOver_HelicopterDead"
	elseif message == "HelicopterDeadNotPlayerOn" then
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:CallFailedTelop( "gameover_reason_heli_destroyed" )	

		this.CounterList.GameOverRadioName = "Radio_GameOver_HelicopterDead"
		TppSequence.ChangeSequence( "Seq_MissionFailed_HelicopterDeadNotPlayerOn" )
		return

	elseif message == "PlayerDead" then
		this.CounterList.GameOverRadioName = "Radio_GameOver_PlayerDead"
	elseif message == "HumanEnemyDead" then
		this.CounterList.GameOverRadioName = "Radio_GameOver_HumanEnemyDead"
	else
		this.CounterList.GameOverRadioName = "Radio_GameOver_General"
	end

	TppSequence.ChangeSequence( "Seq_MissionGameOver" )

end


this.commonMissionCleanUp = function()

	
	GZCommon.MissionCleanup()

	
	TppMusicManager.EndSceneMode()

	TppRadioConditionManagerAccessor.Unregister( "Tutorial" )
	TppRadioConditionManagerAccessor.Unregister( "Basic" )
	GzRadioSaveData.ResetSaveRadioId()
	GzRadioSaveData.ResetSaveEspionageId()
	local radioManager = RadioDaemon:GetInstance()
	radioManager:ResetRadioGroupAndGroupSetAlreadyReadFlag()

end


this.commonIsEnemiesDead = function( characterIds )

	for i, characterId in pairs( characterIds ) do
		if this.commonIsEnemyAlive( characterId ) == true then
			return false
		end
	end

	return true

end


this.commonIsEnemiesDisempowerment = function( characterIds )

	for i, characterId in pairs( characterIds ) do
		if this.commonIsEnemyDisempowerment( characterId ) == false then
			return false
		end
	end

	return true

end


this.commonIsAlienEnemy = function( characterId )

	for i, value in ipairs( this.initialAlienEnemies ) do
		if characterId == value then
			return true
		end
	end

	return false

end


this.commonIsHumanEnemy = function( characterId )

	for i, value in pairs( this.initialHumanEnemies ) do
		if characterId == value then
			return true
		end
	end

	return false

end


this.commonKillEnemies = function( characterIds )

	for i, characterId in ipairs( characterIds ) do
		TppEnemyUtility.KillEnemy( characterId )
	end

end


this.commonKnockOutEnemies = function( characterIds )

	for i, characterId in ipairs( characterIds ) do
		TppEnemyUtility.ChangeStatus( characterId , "Faint" )
	end

end


this.commonEnableEnemies = function( characterIds )

	for i, characterId in ipairs( characterIds ) do
		TppEnemyUtility.SetEnableCharacterId( characterId, true )
	end

end


this.commonDisableEnemies = function( characterIds )

	for i, characterId in ipairs( characterIds ) do
		TppEnemyUtility.SetEnableCharacterId( characterId, false )
	end

end


this.commonCountAlive = function( characterIds )

	local count = 0

	for i, characterId in ipairs( characterIds ) do

		if this.commonIsEnemyAlive( characterId ) then
			count = count + 1
		end

	end

	return count

end


this.commonCountNormal = function( characterIds )

	local count = 0

	for i, characterId in ipairs( characterIds ) do

		if this.commonIsEnemyNormal( characterId ) then
			count = count + 1
		end

	end

	return count

end


this.commonIsEnemyAlive = function( characterId)

	local lifeStatus = TppEnemyUtility.GetLifeStatus( characterId )
	local status = TppEnemyUtility.GetStatus( characterId )
	if	lifeStatus == "Dead" or
		status == "OnHelicopter" then
		return false
	end

	return true

end


this.commonIsEnemyDisempowerment = function( characterId )

	if this.commonIsEnemyNormal( characterId ) == true then
		return false
	end

	return true

end


this.commonIsEnemyNormal = function( characterId )

	local lifeStatus = TppEnemyUtility.GetLifeStatus( characterId )
	local status = TppEnemyUtility.GetStatus( characterId )
	if	lifeStatus == "Dead" or
		lifeStatus == "Dying" or
		lifeStatus == "Sleep" or
		lifeStatus == "Faint" or
		status == "OnHelicopter" or
		status == "HoldUp" then
		return false
	end

	return true

end


this.commonOnHelicopterLostControl = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	if characterId == this.CHARACTER_ID_SUPPORT_HELICOPTER then
		TppSupportHelicopterService.SearchLightOff()
		TppMission.ChangeState( "failed", "HelicopterDeadNotPlayerOn" )	
	end

end


this.commonHeliDamagedByPlayer = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )

	if characterId == this.CHARACTER_ID_SUPPORT_HELICOPTER then
		local radioDaemon = RadioDaemon:GetInstance()
		if ( radioDaemon:IsPlayingRadio() == false ) then
			
			TppRadio.PlayEnqueue( "Miller_HeliAttack" )
		end
	end

end


this.characterIdToRouteMap = {
	Reinforcements_1_1_AlienEnemy0000 = "e20070_reinforcements_route0001",
	Reinforcements_1_1_AlienEnemy0001 = "e20070_reinforcements_route0002",
	Reinforcements_1_1_AlienEnemy0002 = "e20070_reinforcements_route0003",
	Reinforcements_1_1_AlienEnemy0003 = "e20070_reinforcements_route0004",
	Reinforcements_1_1_AlienEnemy0004 = "e20070_reinforcements_route0005",
	Reinforcements_1_1_AlienEnemy0005 = "e20070_reinforcements_route0006",
	Reinforcements_1_1_AlienEnemy0006 = "e20070_reinforcements_route0007",
	Reinforcements_1_1_MissileAlienEnemy0000 = "e20070_reinforcements_route0000",
	Reinforcements_1_2_MissileAlienEnemy0000 = "e20070_reinforcements_route0016",
	Reinforcements_1_2_MissileAlienEnemy0001 = "e20070_reinforcements_route0017",
	Reinforcements_2_1_AlienEnemy0000 = "e20070_reinforcements_route0027",
	Reinforcements_2_1_AlienEnemy0001 = "e20070_reinforcements_route0028",
	Reinforcements_2_1_AlienEnemy0002 = "e20070_reinforcements_route0029",
	Reinforcements_2_1_AlienEnemy0003 = "e20070_reinforcements_route0030",
	Reinforcements_2_1_AlienEnemy0004 = "e20070_reinforcements_route0031",
	Reinforcements_2_1_AlienEnemy0005 = "e20070_reinforcements_route0032",
	Reinforcements_2_1_AlienEnemy0006 = "e20070_reinforcements_route0033",
	Reinforcements_2_1_AlienEnemy0007 = "e20070_reinforcements_route0034",
	Reinforcements_2_2_AlienEnemy0000 = "e20070_reinforcements_route0035",
	Reinforcements_2_2_AlienEnemy0001 = "e20070_reinforcements_route0036",
	Reinforcements_2_2_AlienEfnemy0002 = "e20070_reinforcements_route0037",
	Reinforcements_2_2_AlienEnemy0003 = "e20070_reinforcements_route0038",
	Reinforcements_2_2_AlienEnemy0004 = "e20070_reinforcements_route0039",
	Reinforcements_2_2_AlienEnemy0005 = "e20070_reinforcements_route0040",
	AlienEnemy0000 = "e20070_d01_route0003",
	AlienEnemy0001 = "e20070_d01_route0001",
	AlienEnemy0002 = "e20070_d01_route0002",
	AlienEnemy0003 = "e20070_d01_route0010",
	AlienEnemy0004 = "e20070_d01_route0004",
	AlienEnemy0005 = "e20070_d01_route0009",
	AlienEnemy0006 = "e20070_d01_route0008",
	HumanEnemy0000 = "e20070_d01_route0000",
	HumanEnemy0001 = "e20070_d01_route0006",
	HumanEnemy0002 = "e20070_d01_route0007",
}

this.stopForceRouteModeRouteNodeMap = {
	e20070_reinforcements_route0001 = 1,
	e20070_reinforcements_route0002 = 1,
	e20070_reinforcements_route0003 = 1,
	e20070_reinforcements_route0004 = 1,
	e20070_reinforcements_route0005 = 1,
	e20070_reinforcements_route0006 = 1,
	e20070_reinforcements_route0007 = 1,
	e20070_reinforcements_route0016 = 2,
	e20070_reinforcements_route0017 = 2,
	e20070_reinforcements_route0035 = 1,
	e20070_reinforcements_route0036 = 1,
	e20070_reinforcements_route0037 = 1,
	e20070_reinforcements_route0038 = 1,
	e20070_reinforcements_route0039 = 1,
	e20070_reinforcements_route0040 = 1,
}

this.commonGetCharacterIdByRouteName = function( targetRouteName )

	for characterId, routeName in pairs( this.characterIdToRouteMap ) do
		if routeName == targetRouteName then
			return characterId
		end
	end

	return nil

end


this.commonOnMessageRoutePoint = function()

	local routeNodeIndex = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	local maxRouteNodeIndex = TppEventSequenceManagerCollector.GetMessageArg( 1 )
	local routeId = TppEventSequenceManagerCollector.GetMessageArg( 2 )

	Fox.Log( "commonOnMessageRoutePoint() routeNodeIndex:" .. routeNodeIndex .. ", maxRouteNodeIndex:" .. maxRouteNodeIndex .. ", routeId:" .. routeId )

	
	if routeNodeIndex == maxRouteNodeIndex then									
		for characterId, routeName in pairs( this.characterIdToRouteMap ) do
			if routeId == GsRoute.GetRouteId( routeName ) then
				TppEnemyUtility.SetForceRouteMode( characterId, false )			
				TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, false )
			end
		end
	end

	
	for routeName, targetNodeIndex in pairs( this.stopForceRouteModeRouteNodeMap ) do
		if routeId == GsRoute.GetRouteId( routeName ) then
			if routeNodeIndex == targetNodeIndex then
				local characterId = this.commonGetCharacterIdByRouteName( routeName )
				if characterId ~= nil then
					Fox.Log( "commonOnMessageRoutePoint() routeName:" .. routeName .. ", targetNodeIndex:" .. targetNodeIndex )
					TppEnemyUtility.SetForceRouteMode( characterId, false )			
					TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, false )
				end
			end
		end
	end

end


this.commonKillAllInitialEnemies = function()

	
	

	
	this.commonDisableEnemies( this.initialAlienEnemies )
	this.commonDisableEnemies( this.initialHumanEnemies )

end


this.commonOnEnterReinforcementsTrap = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )						
	if characterId == "Player" then																

		TppMission.SetFlag( "isPlayerInReinforcementsTrap", true )

		if TppSequence.GetCurrentSequence() == "Seq_GotoHeliport" then

			if TppMission.GetFlag( "isHelicopterCalled" ) == false then
				TppSupportHelicopterService.RequestRouteMode( "DropRoute_HeliPort0000", true, 60 )	
				
				TppMission.SetFlag( "isHelicopterCalled", true )
			end

		end

	elseif characterId == this.CHARACTER_ID_SUPPORT_HELICOPTER then

		if TppSequence.GetCurrentSequence() == "Seq_GotoHeliport" then
			TppSupportHelicopterService.RequestRouteMode( "e20070_route_heli0000" )
		end

		TppMission.SetFlag( "isHeliInReinforcementsTrap", true )
	end

	if TppSequence.GetCurrentSequence() == "Seq_GotoHeliport" then
		this.Seq_GotoHeliport.localChangeSequenceIfSequenceClear()
	end

end


this.commonOnLeaveReinforcementsTrap = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	if characterId == "Player" then
		TppMission.SetFlag( "isPlayerInReinforcementsTrap", false )
	elseif characterId == this.CHARACTER_ID_SUPPORT_HELICOPTER then
		TppMission.SetFlag( "isHeliInReinforcementsTrap", false )
	end

end


this.commonOnEnterReinforcementsTrap2 = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )						
	if characterId == "Player" then																
		TppMission.SetFlag( "isPlayerInReinforcementsTrap2", true )
	end

end


this.commonOnLeaveReinforcementsTrap2 = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	if characterId == "Player" then
		TppMission.SetFlag( "isPlayerInReinforcementsTrap2", false )
	end

end


this.commnoSetEnemiesReinforcements = function( characterIds )

	for i, characterId in pairs( characterIds ) do
		this.commnoSetEnemyReinforcements( characterId )
	end

end


this.commnoSetEnemyReinforcements = function( characterId )

	TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, true )		
	

end

this.aimTargets = {
	"Reinforcements_1_1_MissileAlienEnemy0000",
	"Reinforcements_1_1_AlienEnemy0000",
	"Reinforcements_1_1_AlienEnemy0001",
	"Reinforcements_1_1_AlienEnemy0002",
	"Reinforcements_1_1_AlienEnemy0003",
	"Reinforcements_1_1_AlienEnemy0004",
	"Reinforcements_1_1_AlienEnemy0005",
	"Reinforcements_1_1_AlienEnemy0006",
	"Reinforcements_1_2_MissileAlienEnemy0000",
	"Reinforcements_1_2_MissileAlienEnemy0001",
	this.CHARACTER_ID_ENEMY_IN_HELICOPTER,
	"Reinforcements_2_1_AlienEnemy0000",
	"Reinforcements_2_1_AlienEnemy0001",
	"Reinforcements_2_1_AlienEnemy0002",
	"Reinforcements_2_1_AlienEnemy0003",
	"Reinforcements_2_1_AlienEnemy0004",
	"Reinforcements_2_1_AlienEnemy0005",
	"Reinforcements_2_1_AlienEnemy0006",
	"Reinforcements_2_1_AlienEnemy0007",
	"Reinforcements_2_2_AlienEnemy0000",
	"Reinforcements_2_2_AlienEnemy0001",
	"Reinforcements_2_2_AlienEnemy0002",
	"Reinforcements_2_2_AlienEnemy0003",
	"Reinforcements_2_2_AlienEnemy0004",
	"Reinforcements_2_2_AlienEnemy0005",
	this.CHARACTER_ID_ENEMY_IN_HELICOPTER2,
	this.CHARACTER_ID_ENEMY_HELICOPTER,
}


this.commonOnEnemyNearAntiAirGun = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )

	if characterId ~= "Player" then

		if characterId ~= this.CounterList.aimTarget then

			TppSupportHelicopterService.StartSearchLightAutoAimToCharacter( characterId )
			this.CounterList.aimTarget = targetCharacterId

		end

		

	end


end

this.heliRouteMap = {
	Reinforcements_1_1_AlienEnemy0000 = "e20070_route_heli0004",
	Reinforcements_1_1_AlienEnemy0001 = "e20070_route_heli0004",
	Reinforcements_1_1_AlienEnemy0002 = "e20070_route_heli0004",
	Reinforcements_1_1_AlienEnemy0003 = "e20070_route_heli0004",
	Reinforcements_1_1_AlienEnemy0004 = "e20070_route_heli0004",
	Reinforcements_1_1_MissileAlienEnemy0000 = "e20070_route_heli0005",
	Reinforcements_1_2_MissileAlienEnemy0000 = "e20070_route_heli0006",
	Reinforcements_1_2_MissileAlienEnemy0001 = "e20070_route_heli0007",
	EnemyInHelicopter = "e20070_route_heli0010",
	Reinforcements_2_1_AlienEnemy0002 = "e20070_route_heli0011",
	Reinforcements_2_1_AlienEnemy0007 = "e20070_route_heli0011",
	Reinforcements_2_1_AlienEnemy0000 = "e20070_route_heli0012",
	Reinforcements_2_1_AlienEnemy0005 = "e20070_route_heli0012",
	Reinforcements_2_1_AlienEnemy0006 = "e20070_route_heli0012",
	Reinforcements_2_1_AlienEnemy0001 = "e20070_route_heli0013",
	Reinforcements_2_1_AlienEnemy0003 = "e20070_route_heli0013",
	Reinforcements_2_1_AlienEnemy0004 = "e20070_route_heli0013",
	EnemyInHelicopter2 = "e20070_route_heli0014",

	EnemyHelicopter = "e20070_route_heli0014",
	Reinforcements_2_2_AlienEnemy0000 = "e20070_route_heli0014",
	Reinforcements_2_2_AlienEnemy0001 = "e20070_route_heli0014",
	Reinforcements_2_2_AlienEnemy0002 = "e20070_route_heli0014",
	Reinforcements_2_2_AlienEnemy0003 = "e20070_route_heli0014",
	Reinforcements_2_2_AlienEnemy0004 = "e20070_route_heli0014",
	Reinforcements_2_2_AlienEnemy0005 = "e20070_route_heli0014",
}


this.commonHeliAimEnemy = function()

	local targetCharacterId = nil

	for i, characterId in ipairs( this.aimTargets ) do

		local charaObj = Ch.FindCharacterObjectByCharacterId( characterId )
		if charaObj ~= nil and TppEnemyUtility.GetLifeStatus( characterId ) ~= "Dead" then
			targetCharacterId = characterId
			break
		end

	end

	if	targetCharacterId ~= nil then

		
		local routeName = this.heliRouteMap[ targetCharacterId ]
		if routeName ~= nil then
			TppSupportHelicopterService.ChangeRouteWithNodeIndex( routeName )	
		end

		
		TppSupportHelicopterService.StartSearchLightAutoAimToCharacter( targetCharacterId )

		
		if targetCharacterId == "Reinforcements_1_1_MissileAlienEnemy0000" then
			
		elseif targetCharacterId == "Reinforcements_1_2_MissileAlienEnemy0000" then
			
		elseif targetCharacterId == "Reinforcements_1_2_MissileAlienEnemy0001" then
			
		elseif targetCharacterId == "Reinforcements_2_2_MissileAlienEnemy0000" then
			TppRadio.DelayPlayEnqueue( "Radio_HeliTarget_Missile", "short" )
		elseif targetCharacterId == "Reinforcements_1_2_AlienEnemy0000" then
			
		elseif targetCharacterId == "Reinforcements_2_2_AlienEnemy0000" then
			
		elseif targetCharacterId == "Reinforcements_2_2_AlienEnemy0001" then
			
		else

		end

		this.CounterList.aimTarget = targetCharacterId

	else

		TppSupportHelicopterService.StopSearchLightAutoAim()
		TppSupportHelicopterService.SetSearchLightAngle( 0, 0 )

	end

end


this.commonPlayClaymoreRadio = function()

	local radioDaemon = RadioDaemon:GetInstance()
	if radioDaemon:IsRadioGroupMarkAsRead("e0070_rtrg0040") == false then
		TppRadio.DelayPlay( "Radio_Claymore", "short" )
	end

end


this.commonPlayHeliRadio = function()

	local sequence = TppSequence.GetCurrentSequence()
	if	sequence == "Seq_SearchAndDestroy" and
		TppCharacterUtility.GetCurrentPhaseName() ~= "Alert" then



	end

end

this.commonShowPhotRadio = function()

	local sequence = TppSequence.GetCurrentSequence()
	if sequence == "Seq_SearchAndDestroy" then
		local photLookFunc = {
			onEnd = function()
				local radioDaemon = RadioDaemon:GetInstance()
				if( radioDaemon:IsRadioGroupMarkAsRead("e0070_rtrg0090") == false ) then
					
					TppRadio.DelayPlayEnqueue( "Radio_photoInfoPlus", "short", "end" )
				else
					
					TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
				end
			end,
		}
		TppRadio.DelayPlay( "Radio_photoInfo", "short", "begin", photLookFunc )
	end

end
this.commonOnMarkerEnabled = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	if this.commonIsAlienEnemy( characterId ) == true then
		
	end

	TppRadio.EnableIntelRadio( characterId )

end


this.interogationCharacterMap = {
	AlienEnemy0000 = "AlienEnemy0001",
	AlienEnemy0001 = "AlienEnemy0002",
	AlienEnemy0002 = "HumanEnemy0001",
	AlienEnemy0003 = "AlienEnemy0004",
	AlienEnemy0004 = "HumanEnemy0002",
	HumanEnemy0000 = "AlienEnemy0000",
	HumanEnemy0001 = "AlienEnemy0003",
}


this.interogationMarkerMap = {}

this.commonOnEnemyInterrogation = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	local targetCharacterId = this.interogationCharacterMap[ characterId ]

	if targetCharacterId == nil then
		return
	end

	local type = TppEventSequenceManagerCollector.GetMessageArg( 2 )

	Fox.Log( "commonOnEnemyInterrogation: characterId:" .. characterId .. ", type:" .. type .. ", targetCharacterId:" .. targetCharacterId )

	if type == 2 and targetCharacterId ~= nil then
		this.interogationMarkerMap[ targetCharacterId ] = true
	end

end

this.commonIsMarkerEnabledByInterogation = function( characterId )

	Fox.Log( "commonIsMarkerEnabledByInterogation: characterId:" .. characterId )

	if this.interogationMarkerMap[ characterId ] == true then
		return true
	end

	return false

end


this.commonDisableInterogationAbout = function( characterId )

	
	for srcCharcterId, dstCharacterId in pairs( this.interogationCharacterMap ) do

		if dstCharacterId == characterId then
			TppEnemyUtility.SetInterrogationAllDoneFlagByCharacterId( srcCharcterId, true )
		end

	end

end

this.commonOnNotifyLifeRate = function()

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	local lifeRate = TppEventSequenceManagerCollector.GetMessageArg( 1 )

	if characterId == this.CHARACTER_ID_SUPPORT_HELICOPTER then
		local count = this.CounterList.radioCount % 3
		if count == 0 then
			TppRadio.Play( "Radio_HeliTarget1" )
		elseif count == 1 then
		elseif count == 2 then
		end
		count = count + 1
	end

end

this.exceptionalForceRouteCharacterId = {
	"Reinforcements_1_1_MissileAlienEnemy0000",
	"Reinforcements_2_1_AlienEnemy0000",
	"Reinforcements_2_1_AlienEnemy0001",
	"Reinforcements_2_1_AlienEnemy0002",
}

this.commonIsExceptionalCharacter = function( targetCharacterId )

	for i, characterId in ipairs( this.exceptionalForceRouteCharacterId ) do
		if characterId == targetCharacterId then
			return true
		end
	end

	return false

end

this.commonStopForceRouteMode = function( characterIds )

	for i, characterId in ipairs( characterIds ) do
		if this.commonIsExceptionalCharacter( characterId ) == false then
			TppEnemyUtility.SetForceRouteMode( characterId, false )
			TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, false )
		end
	end

end


this.commonOnAlert = function()

	GZCommon.CallAlertSirenCheck()

	TppMission.SetFlag( "alertOnce", true )

	local sequence = TppSequence.GetCurrentSequence()
	if	sequence == "Seq_AppearReinforcements1" or
		sequence == "Seq_BattleInHeliport1" or
		sequence == "Seq_BattleInHeliport1_1" or
		sequence == "Seq_AppearReinforcements2" or
		sequence == "Seq_BattleInHeliport2" or
		sequence == "Seq_BattleInHeliport2_2" then

		
		TppEnemy.SetMinimumPhase( this.CP_ID, "alert" )

	end
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0070_oprg9020" )
end

this.commonOnEvasion = function()

	
	GZCommon.StopAlertSirenCheck()

	local status = TppData.GetArgument(2)

	
	if ( status == "Down" ) then
		
		if ( TppEnemy.GetPhase( this.CP_ID ) == "evasion" ) then
			local sequence = TppSequence.GetCurrentSequence()
			if sequence == "Seq_SearchAndDestroy" then
				TppEnemy.ChangeRouteSet( this.CP_ID, "e20070_route_c01", { warpEnemy = false } )
				TppRadio.DelayPlay( "Radio_PleaseOpenMbdv" ,"long" )
			end
		end
	end
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0070_oprg9010" )
end


this.commonOnCaution = function()

	GZCommon.StopAlertSirenCheck()
	
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:DisableFlagIsCallCompleted( "e0070_oprg9020" )
end


this.commonSetAntiAircraftMode = function()

	TppCommandPostObject.GsSetAntiAircraftMode( this.CP_ID, true )	

end


this.commonUnsetAntiAircraftMode = function()

	TppCommandPostObject.GsSetAntiAircraftMode( this.CP_ID, false )	

end


this.commonOnEnemyDamaged = function()

	
	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, false )
	TppEnemyUtility.SetForceRouteMode( characterId, false )

end


this.commonAddDyingEnemy = function( targetCharacterId )

	table.insert( this.CounterList.dyingEnemies, targetCharacterId )

end


this.commonDeleteDyingEnemy = function( targetCharacterId )

	for i, characterId in ipairs( this.CounterList.dyingEnemies ) do
		if characterId == targetCharacterId then
			table.remove( this.CounterList.dyingEnemies, i )
			return
		end
	end

end


this.commonIsDyingEnemy = function( targetCharacterId )

	for i, characterId in ipairs( this.CounterList.dyingEnemies ) do
		if characterId == targetCharacterId then
			return true
		end
	end

	return false

end


this.commonAddClearedEnemy = function( targetCharacterId )

	table.insert( this.CounterList.clearedEnemies, targetCharacterId )

end


this.commnoDeleteClearedEnemy = function( targetCharacterId )

	for i, characterId in ipairs( this.CounterList.clearedEnemies ) do
		if characterId == targetCharacterId then
			table.remove( this.CounterList.clearedEnemies, i )
			return
		end
	end

end


this.commonIsClearedEnemy = function( targetCharacterId )

	for i, characterId in ipairs( this.CounterList.clearedEnemies ) do
		if characterId == targetCharacterId then
			return true
		end
	end

	return false

end


this.antiAirgunsInHelipad = {
	"gntn_area01_antiAirGun_001",
	"gntn_area01_antiAirGun_002",
	"gntn_area01_antiAirGun_003",
}


this.commonIsAllAntiAirgunInHelipadBroken = function()

	Fox.Log( "e20070_sequence.commonIsAllAntiAirgunInHelipadBroken()" )

	for i, characterId in ipairs( this.antiAirgunsInHelipad ) do

		if this.commonIsAntiAirgunInHelipadBroken( characterId ) == false then
			return false
		end

	end

	return true

end


this.commonIsAntiAirgunInHelipadBroken = function( characterId )

	Fox.Log( "e20070_sequence.commonIsAntiAirgunInHelipadBroken()" )

	if TppMission.GetFlag( this.commonGetBrokenFlagName( characterId ) ) == true then
		return true
	end

	return false

end


this.commonGetBrokenFlagName = function( characterId )

	Fox.Log( "e20070_sequence.commonGetBrokenFlagName()" )

	return characterId .. "Break"

end


this.commonOnAntiAirgunBroken = function()

	Fox.Log( "e20070_sequence.commonOnAntiAirgunBroken()" )

	local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
	this.commonSetAntiAirgunInHelipadBroken( characterId )

end


this.commonSetAntiAirgunInHelipadBroken = function( characterId )

	Fox.Log( "e20070_sequence.commonSetAntiAirgunInHelipadBroken()" )

	TppMission.SetFlag( this.commonGetBrokenFlagName( characterId ), true )

end

this.After_SwitchOff = function()

	
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", true , false )

	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_02" , false )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_03" , false )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_04" , false )

	

end

this.SwitchLight_ON = function()

	
	TppDataUtility.SetEnableDataFromIdentifier( "gntn_Trap", "SwitchLightArea", false , false )

	
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_02" , true )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_03" , true )
	TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_04" , true )

	

end

this.SwitchLight_OFF = function()

	local phase = TppEnemy.GetPhase( this.CP_ID )

	
	if( TppMission.GetFlag( "isSwitchLightDemo" ) == false )
		and ( phase == "sneak" or phase == "caution" or phase == "evasion" ) then

		local onDemoStart = function()

			
			local radioDaemon = RadioDaemon:GetInstance()
			radioDaemon:StopDirect()
			
			SubtitlesCommand.StopAll()
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_02" , false )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_04" , false )

		   
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
	TppRadio.RegisterIntelRadio( characterID, "f0090_esrg0211", true )
end

this.Common_SecurityCameraPowerOff = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.RegisterIntelRadio( characterID, "f0090_esrg0211", true )
end

this.Common_SecurityCameraPowerOn = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.RegisterIntelRadio( characterID, "f0090_esrg0211", true )
end


this.Common_PickUpItem = function()
	
	if TppData.GetArgument( 1 ) == "IT_Cassette" then
		Fox.Log(":: Pick up Cassette ::")
		local uiCommonData = UiCommonDataManager.GetInstance()
		uiCommonData:GetBriefingCassetteTape( "tp_bgm_05" )
	end
end

this.Common_PickUpWeapon = function()

	
	if (TppData.GetArgument( 1 ) == "WP_ar00_v03b" ) then
		Fox.Log(":: get BlackLightRifle")
		local sequence = TppSequence.GetCurrentSequence()
		if	( sequence == "Seq_SearchAndDestroy" or sequence == "Seq_GotoHeliport" or sequence == "Seq_PlayerRideHelicopter" ) and
			TppMission.GetFlag( "isGetWeapon" ) == false then

			TppRadio.Play( "Metal_mistakeGun" )

		end
		TppMission.SetFlag( "isGetWeapon", true )
		TppEffect.HideEffect( "fx_weaponLight")
	end
end


local commonIntelCheck = function(CharacterID)
	local type = TppNpcUtility.GetNpcType( CharacterID )
	local sequence = TppSequence.GetCurrentSequence()

	if sequence == "Seq_SearchAndDestroy" then
		
		if type == "Enemy" then
			local lifeStatus = TppEnemyUtility.GetLifeStatus( CharacterID )	
			if lifeStatus == "Normal" then
				TppRadio.EnableIntelRadio( characterID )
			else	
				TppRadio.DisableIntelRadio( CharacterID )
			end
		end
	else
		TppRadio.DisableIntelRadio( CharacterID )
	end
end





local findTitleLogoMark = function(num)
	Fox.Log(":: find Mark ::")

	if( num ~= 10 ) then
		
		local count = TppMission.GetFlag( "isCountTitleLogo" )
		count = count + 1
		TppMission.SetFlag( "isCountTitleLogo", count )

		local text = "debug "..count
		Fox.Log( "HitLight : "..count)


		
		if ( count == this.ChallengeLogo ) then
			
			TppMission.SetFlag( "isTitleComp", true )

			TppRadio.Play( "Metal_allClear")
			TppRadio.DelayPlayEnqueue( "Metal_allClearThanks", "mid" )

			local mark = PlayRecord.IsMissionChallenge( "DELETE_XOF_MARK" )
			if mark == true then
				
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:AnnounceLogViewLangId( "announce_allDestroyXOF", count, this.ChallengeLogo )

				PlayRecord.RegistPlayRecord( "DELETE_XOF_MARK" )
			end


		else
			local mark = PlayRecord.IsMissionChallenge( "DELETE_XOF_MARK" )
			if mark == true then
				
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:AnnounceLogViewLangId( "announce_allDestroyXOF", count, this.ChallengeLogo )
			end
			
			TppRadio.DelayPlay( "Metal_int","short" )
		end

		
		Fox.Log("Hide marker")
		local disMark = "e20070_marker_charenge0"..num
		Fox.Log( disMark )
		TppMarkerSystem.DisableMarker{ markerId=disMark }

		
		local flagID = ""
		local locatorID = ""
		if( num == 1)then
			flagID = "isMarkMGSPW"
		elseif( num == 2)then
			locatorID = "intelMark_mgs"
			flagID = "isMarkMGS"
		elseif( num == 3)then
			locatorID = "intelMark_mg"
			flagID = "isMarkMG"
		elseif( num == 4)then
			locatorID = "intelMark_mgs4"
			flagID = "isMarkMGS4"
		elseif( num == 5)then
			locatorID = "intelMark_mgs2"
			flagID = "isMarkMGS2"
		elseif( num == 6)then
			locatorID = "intelMark_gz"
			flagID = "isMarkGZ"
		elseif( num == 7)then
			locatorID = "intelMark_mg2"
			flagID = "isMarkMG2"
		elseif( num == 8)then
			locatorID = "intelMark_mgs3"
			flagID = "isMarkMGS3"
		end

		
		TppMission.SetFlag( flagID, true )

		
		TppRadio.DisableIntelRadio( locatorID )

	else
		
		TppRadio.Play( "Metal_wrong" )
	end

end

local challengeChancel = function()
	Fox.Log("challenge chansel")
	if ( TppMission.GetFlag( "isMarkMGS3" ) == false )then

		local mark = PlayRecord.IsMissionChallenge( "DELETE_XOF_MARK" )
		if mark == true then

			TppCharacterUtility.SetEnableCharacterId( "e20070_marker_charenge08", false )
			
			PlayRecord.UnsetMissionChallenge( "DELETE_XOF_MARK" )

		end
	end
	TppMission.SetFlag( "isBreakWood", true )
end

local challengeChancelFox = function()
	Fox.Log("challenge chansel FOX")
	if( TppMission.GetFlag( "isMakeFox" ) == false )then
		local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
		if mark == true then
			
			PlayRecord.UnsetMissionChallenge( "CREATE_FOX_MARK" )

		end
	end
end

local challengeChancelLA = function()
	Fox.Log("challenge chansel LA")
	if( TppMission.GetFlag( "isMakeLA" ) == false )then
		Fox.Log("flag is ok")
		local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
		if mark == true then
			
			Fox.Log("chacele")
			PlayRecord.UnsetMissionChallenge( "CREATE_FOX_MARK" )
		end
	end
end


local highlightFoxLogo = function(type)
	Fox.Log(":: hit light fox logo ::")
	
	local check = TppEnemy.GetPhase( this.CP_ID )
	if ( check ~= "alert" ) then
		Fox.Log(type)

		local demo = ""
		local radio = ""
		local flag = ""
		local announce
		if( type == "fox" and TppMission.GetFlag( "isMakeFox" ) == false )then
			flag = "isMakeFox"
			radio = "Light_clear"
			demo = "Demo_FoxLightKJP"

		elseif(type=="la" and TppMission.GetFlag( "isMakeLA" ) == false)then
			flag = "isMakeLA"
			radio = "Light_clearLA"
			demo = "Demo_FoxLightLA"
		end

		local onDemoStart = function()
		end
		local onDemoEnd = function()
			Fox.Log("on dmeo end")
			TppMission.SetFlag( flag, true )

			if (TppMission.GetFlag( "isMakeLA" ) == true and TppMission.GetFlag( "isMakeFox" ) == true) then
				
				Fox.Log("clear !!")
				
				local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
				if mark == true then

					
					announce = "announce_mission_40_20060_009_from_0_prio_0"
					local hudCommonData = HudCommonDataManager.GetInstance()																	
					hudCommonData:AnnounceLogViewLangId( announce )

					PlayRecord.RegistPlayRecord( "CREATE_FOX_MARK" )
				end
			elseif (TppMission.GetFlag( "isMakeLA" ) == true or TppMission.GetFlag( "isMakeFox" ) == true) then
				
				local mark = PlayRecord.IsMissionChallenge( "CREATE_FOX_MARK" )
				if mark == true then
					
					announce = "announce_mission_40_20060_008_from_0_prio_0"
					local hudCommonData = HudCommonDataManager.GetInstance()																	
					hudCommonData:AnnounceLogViewLangId( announce )
				end
			end
		end

		if( demo ~= "")then
			Fox.Log(":: play fox light demo ::")
			TppDemo.Play( demo ,{ onStart = onDemoStart, onEnd = onDemoEnd},{
			  disableGame = false,			
			  disablePlayerPad = true,		
			  disableDamageFilter = false,	
			  disableDemoEnemies = false,	
			  disableHelicopter = false,	
			  disablePlacement = false, 	
			  disableThrowing = false	 
			})
			TppGameStatus.Set("TppDemo.lua","S_DISABLE_PLAYER_PAD")
		end

		
		TppRadio.DisableIntelRadio( "radio_kjpLogo" )
	end
end

this.findFoxLogo = function()

	if TppMission.GetFlag( "isMakeFox" ) == false and TppMission.GetFlag( "isMakeLA" ) == false then
		local sequence = TppSequence.GetCurrentSequence()

		if sequence == "Seq_SearchAndDestroy" or sequence == "Seq_GotoHeliport" then
			if TppCharacterUtility.GetCurrentPhaseName() ~= "Alert" then

				local radioDaemon = RadioDaemon:GetInstance()
				if ( radioDaemon:IsPlayingRadio() == false ) then	
						TppRadio.Play( "Light_near" )					
				end

			end
		end
	end
end



local charengeClaymoreCount = function()
	if(TppData.GetArgument( 1 ) == "WP_Claymore")then


		local crymore = PlayRecord.IsMissionChallenge( "CLAYMORE_RECOVERY" )
		if crymore == true then

			local count = TppMission.GetFlag( "isCountClaymore" )
			count = count + 1
			TppMission.SetFlag( "isCountClaymore", count )

			if(	TppMission.GetFlag( "isFailedClaymore" ) == false )then
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:AnnounceLogViewLangId("announce_allGetClaymore",	count,	5)
			end
			
			if (count == 5) then
				PlayRecord.RegistPlayRecord( "CLAYMORE_RECOVERY" )
			end
		end

	end
end


local charengeClaymorePut = function()
	if(TppData.GetArgument( 1 ) == "WP_Claymore")then

		local count = TppMission.GetFlag( "isCountClaymore" )
		count = count - 1
		TppMission.SetFlag( "isCountClaymore", count )
	end
end


this.DamagedOnClaymore = function()
	
	Fox.Log(":: Damaged claymore ::")
	if( (TppData.GetArgument( 1 ) == "WP_Claymore" ) and TppMission.GetFlag( "isFailedClaymore" ) == false) then

		local crymore = PlayRecord.IsMissionChallenge( "CLAYMORE_RECOVERY" )
		if crymore == true then
			Fox.Log("charenge failed - flag On!!")
			
			TppMission.SetFlag( "isFailedClaymore", true )
			
			PlayRecord.UnsetMissionChallenge( "CLAYMORE_RECOVERY" )
		end
	end
end


this.Common_DoorUnlock = function( flag )
	Fox.Log(":: Common Door Unlock ::")

	local id = TppData.GetArgument( 1 )

	if(    id == "Asy_PickingDoor"
		or id == "StartCliff_PickingDoor01"
		or id == "WareHousePickingDoor01"
		or id == "Center_PickingDoor01"
		or id == "Center_PickingDoor02"
		or id == "WP_HouseDoor01"
		or id == "WP_HouseDoor02"
		or id == "WP_HouseDoor03"
		or id == "AsyPickingDoor07"
		or id == "AsyPickingDoor24"
	)then

		Fox.Log( "Open the door : "..id )

		local counter = TppMission.GetFlag( "isDoorCounter" )
		counter = counter + 1
		TppMission.SetFlag( "isDoorCounter", counter )

		Fox.Log("Unlock Door : "..counter )

		
		local door = PlayRecord.IsMissionChallenge( "OPEN_DOOR" )
		if door == true then

			if (counter == this.doorMax)then
				PlayRecord.RegistPlayRecord( "OPEN_DOOR" )

			else
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:AnnounceLogViewLangId("announce_door_unlock",	counter,	this.doorMax)
			end
		end
	end
end

local setHeliMarker = function()
	Fox.Log("set heli marker check")
	if( TppMission.GetFlag( "isMarkMGSPW" ) == false and TppMission.GetFlag( "isJinmon" ) )then

		
		Fox.Log("set heli marker")
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge01" }
		TppMarkerSystem.SetMarkerGoalType{ markerId="e20070_logo_001", goalType="GOAL_NONE", radiusLevel=1 }
		TppMarkerSystem.EnableMarker{ markerId="e20070_logo_001", viewType="VIEW_MAP_ICON" }
		return true

	elseif( TppMission.GetFlag( "isJinmon" ) )then
		
		Fox.Log("disable heli marker")
		TppMarkerSystem.DisableMarker{ markerId="e20070_logo_001" }
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge01" }

		return false
	end
end


local jinmonMarkCheck = function()
	Fox.Log(":: jinmon mark check ::")

	TppMission.SetFlag( "isJinmon" ,true )

	
	if ( TppMission.GetFlag( "isMarkMGSPW" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge01" }	
	end
	if ( TppMission.GetFlag( "isMarkMGS" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge02" }
	end
	if ( TppMission.GetFlag( "isMarkMG" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge03" }
	end
	if ( TppMission.GetFlag( "isMarkMGS4" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge04" }
	end
	if ( TppMission.GetFlag( "isMarkMGS2" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge05" }
	end
	if ( TppMission.GetFlag( "isMarkGZ" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge06" }
	end
	if ( TppMission.GetFlag( "isMarkMG2" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge07" }
	end
	if ( TppMission.GetFlag( "isMarkMGS3" ) )then
		TppMarkerSystem.DisableMarker{ markerId="e20070_marker_charenge08" }
	end
end


this.SwitchPuchButtonDemo = function()

	local charaID = TppData.GetArgument( 1 )
	local check = TppEnemy.GetPhase( this.CP_ID )
	local status = TppGadgetManager.GetGadgetStatus( "gntn_center_SwitchLight" )

	
	if( charaID == "gntn_center_SwitchLight" )then
		
		if( status == 1 )then
			
			

			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_02", false )
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_04", false )

			if( check == "alert" )then											
				
				return
			else																
				if( TppMission.GetFlag( "isSwitchLightDemo" ) == false ) then	

					local onDemoStart = function()
						
						TppMission.SetFlag( "isSwitchLightDemo", true )
					end
					local onDemoEnd = function()
					end
					TppDemo.Play( "Demo_SwitchLight2" , { onStart = onDemoStart, onEnd = onDemoEnd } , {
						disableGame				= false,	
						disableDamageFilter		= false,	
						disableDemoEnemies		= false,	
						disableEnemyReaction	= true,		
						disableHelicopter		= false,	
						disablePlacement		= false, 	
						disableThrowing			= false	 	
					})

				end
			end
		
		elseif( status == 2 )then
			
			
			
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_02", true )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_03", true )
			TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_04", true )


		else
			
			Fox.Error(" Return Wrong Velue ... Switch Light ")
		end
	
	else
		Fox.Log(" Return wrong Switch Light Gimmick's CharacterID ... ")
	end
end



this.commonSuppressorIsBroken = function()
	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()

	if( VehicleId == "SupportHelicopter" ) then
	else

		local sequence = TppSequence.GetCurrentSequence()
		if sequence == "Seq_SearchAndDestroy" then

			local phase = TppEnemy.GetPhase( this.CP_ID )
			if not ( phase == "alert" ) then
				TppRadio.DelayPlayEnqueue( "Miller_BreakSuppressor", "short" )
			end

		end

	end
end





this.OnSkipEnterCommon = function()
	local sequence = TppSequence.GetCurrentSequence()

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then
		this.onMissionPrepare()

		
		this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )
		Fox.Log("***e20070_MissionPrepare.tmpRewardNum_IS___"..this.tmpRewardNum)
		

	end

	
	if( TppSequence.IsGreaterThan( sequence, "Seq_MissionFailed" ) ) then
		TppMission.ChangeState( "failed" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionClear" ) ) then
		TppMission.ChangeState( "clear" )
	elseif( TppSequence.IsGreaterThan( sequence, "Seq_MissionPrepare" ) ) then
		TppMission.ChangeState( "exec" )
	end

	
	this.commonLoadDemoBlock()	

end

this.OnSkipUpdateCommon = function()

	
	return IsDemoAndEventBlockActive()

end

this.OnSkipLeaveCommon = function()

	local sequence = TppSequence.GetCurrentSequence()
	if sequence == "Seq_GotoHeliport" then
		GkEventTimerManager.Start( "Timer_KillAllEnemies", 1 )
	end

	if sequence == "Seq_AppearReinforcements1" then

		
		this.commonDisableEnemies( this.initialHumanEnemies )				
		this.commonDisableEnemies( this.initialAlienEnemies )				

		TppSupportHelicopterService.RequestRouteModeWithNodeIndex( "e20070_route_heli0000", 0, true, 40 )

	elseif sequence == "Seq_AppearReinforcements2" then

		
		this.commonDisableEnemies( this.initialHumanEnemies )				
		this.commonDisableEnemies( this.initialAlienEnemies )				

		TppSupportHelicopterService.RequestRouteModeWithNodeIndex( "e20070_route_heli0008", 0, true, 40 )

	elseif sequence == "Seq_PlayerRideHelicopter" then

		
		this.commonDisableEnemies( this.initialHumanEnemies )				
		this.commonDisableEnemies( this.initialAlienEnemies )				

		TppSupportHelicopterService.RequestRouteModeWithNodeIndex( "e20070_route_heli0001", 0, true, 40 )

	end

	if sequence == "Seq_SearchAndDestroy" then
		TppMission.SetFlag( "isOpeningDemoSkipped", true )
	end

	if	sequence == "Seq_BattleInHeliport1" or
		sequence == "Seq_BattleInHeliport1_1" or
		sequence == "Seq_AppearReinforcements2" or
		sequence == "Seq_BattleInHeliport2" then
		
		local gateObj = Ch.FindCharacterObjectByCharacterId( "gntn_BigGate" )
		local gateChara = gateObj:GetCharacter()
		gateChara:SendMessage( TppGadgetStartActionRequest() )
	end

	
	if	sequence == "Seq_GotoHeliport" or
		sequence == "Seq_AppearReinforcements1" or
		sequence == "Seq_BattleInHeliport1" or
		sequence == "Seq_BattleInHeliport1_1" or
		sequence == "Seq_AppearReinforcements2" or
		sequence == "Seq_BattleInHeliport2" or
		sequence == "Seq_PlayerRideHelicopter" then

		
		TppDataUtility.SetEnableDataFromIdentifier( "DataIdentifier_CheckPointTraps", "CheckPointTraps", false, true )

	end

	if sequence == "Seq_AppearReinforcements1" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_00' )
	elseif sequence == "Seq_AppearReinforcements2" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_01' )
	elseif sequence == "Seq_BattleInHeliport2" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_02' )
	elseif sequence == "Seq_BattleInHeliport2_2" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_03' )
	elseif sequence == "Seq_PlayerRideHelicopter" then
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
		TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_04' )
	end

	if sequence ~= "Seq_OpeningDemo" then
		
		TppGadgetUtility.AttachGadgetToChara("e20070_logo_001","SupportHelicopter","CNP_MARK")
	end

end


this.OnAfterRestore = function()

	TppRadio.RestoreIntelRadio()

end




this.MissionFlagList = {
	isAllTargetKlled				= false,	
	isAlienMarked					= false,	
	isHumanMarked					= false,	
	isPlayerInReinforcementsTrap	= false,	
	isPlayerInReinforcementsTrap2	= false,	
	isHeliInReinforcementsTrap		= false,	
	isFirstSequenceSkipped			= false,	
	isHelicopterCalled				= false,	
	isHintRadioPlayed				= false,	
	isEnemyHelicopterDead			= false,	
	isVehicleStarted				= false,	
	isGroupVehicleEnd				= false,	
	isControlTowerEnemyEnabled		= false,	
	isOpeningDemoSkipped			= false,	
	isReminderRadio1Played			= false,	
	isReminderRadio2Played			= false,	
	isAlienKilled					= false,	
	isHumanKilled					= false,	
	isHeliLandNow					= false,	
	isTerminalUpdated				= false,	
	isWoodTurret03Broken			= false,	
	isSearchLight02Broken			= false,	
	isSceneMusicStarted				= false,	
	currentClearCount				= 0,		

	
	isCountTitleLogo				= 0,		
	isTitleComp						= false,	
	isMakeFox						= false,
	isMakeLA						= false,
	isCountClaymore					= 0,
	isFailedClaymore				= false,
	
	isMarkGZ		= false,
	isMarkMG		= false,
	isMarkMG2		= false,
	isMarkMGS		= false,
	isMarkMGS2		= false,
	isMarkMGS3		= false,
	isMarkMGSPW		= false,
	isMarkMGS4		= false,
	isMarkHeli		= false, 
	isHeliComming 	= false,
	isJinmon		= false,
	
	isSwitchLightDemo				= false,
	
	isCarTutorial					= false,	
	isDoorCounter			= 0,

	isBreakWood		= false,
	isGetWeapon		= false,

	
	alertOnce						= false,	
}


for i, characterId in ipairs( this.antiAirgunsInHelipad ) do
	this.MissionFlagList[ this.commonGetBrokenFlagName( characterId ) ] = false
end




this.DemoList = {
	Demo_Opening		= "p12_070000_000",	
	Demo_SwitchLight	= "p11_020002_000",	
	Demo_FoxLightKJP	= "p12_050070_000",	
	Demo_FoxLightLA		= "p12_050070_001",	
}




this.RadioList = {
	Radio_MissionStart							= { "e0070_rtrg0010", 1 },	
	Radio_Continue								= { "e0070_rtrg0011", 1 },	
	Radio_Continue2								= "e0070_rtrg0013",			
	Radio_photoInfo								= { "e0070_rtrg0020", 1 },	
	Radio_photoInfoPlus							= { "e0070_rtrg0022", 1 },	
	Radio_Background							= { "e0070_rtrg0030", 1 },	
	Radio_Marking								= { "e0070_rtrg0035", 1 },	
	Radio_Claymore								= { "e0070_rtrg0040", 1 },	
	Radio_Heli1									= { "e0070_rtrg0050", 1 },	
	Radio_Heli2									= { "e0070_rtrg0052", 1 },	
	Radio_MarkingHuman							= "e0070_rtrg0060",			
	Radio_MarkingAlien							= "e0070_rtrg0070",			
	Radio_MarkingAlien2							= "e0070_rtrg1070",			
	Radio_HoldupAlien							= "e0070_rtrg0071",			
	Radio_NoKill								= "e0070_rtrg0073",			
	Radio_AlienDead								= "e0070_rtrg0080",			
	Radio_TargetClear_First						= { "e0070_rtrg0081", 1 },	
	Radio_TargetClear_Last						= { "e0070_rtrg0082", 1 },	
	Radio_TargetClear_Reinforcements			= { "e0070_rtrg0083", 1 },	
	Radio_TargetClear_Heli						= { "e0070_rtrg0084", 1 },	
	Radio_AlienDisempowerment					= "e0070_rtrg0090",			
	Radio_HumanDead								= "e0070_rtrg0100",			
	Radio_Hint									= "e0070_rtrg0110",			
	Radio_Reminder1								= "e0070_rtrg0110",			
	Radio_Reminder2								= "e0070_rtrg0112",			
	Radio_Sequence1Clear						= "e0070_rtrg0200",			
	Radio_Reinforcements1						= "e0070_rtrg0210",			
	Radio_Reinforcements2						= "e0070_rtrg0213",			
	Radio_Reinforcements3						= "e0070_rtrg0215",			
	RadioReinforcementsHeli2					= "e0070_rtrg0214",			
	Radio_ClearReinrcements						= "e0070_rtrg0217",			
	Radio_ClearReinrcements2					= "e0070_rtrg0218",			
	Radio_ClearReinrcements3					= "e0070_rtrg0219",			
	Radio_HeliTarget1							= "e0070_rtrg0300",			
	Radio_HeliTarget_Missile					= "e0070_rtrg0303",			
	Radio_HeliTarget_AntiAirGun					= "e0070_rtrg0304",			
	Radio_HeliTarget_NotAntiAirGun				= "e0070_rtrg0307",			
	Radio_HeliTarget_Light						= "e0070_rtrg0305",			
	Radio_HeliTarget_Marker						= "e0070_rtrg0306",			
	Radio_PleaseOpenMbdv						= { "e0070_rtrg0310", 1 },	
	Radio_AfterGameClear						= "e0070_rtrg0990",			

	
	Radio_RideHeli_Clear						= "f0090_rtrg0460",			
	Radio_RideHeli_Failure						= "f0090_rtrg0120",			

	
	Light_near									= {"e0070_rtrg0500",1}, 	
	Light_clear									= {"e0070_rtrg0510",1}, 	
	Light_clearLA								= {"e0070_rtrg0520",1}, 	
	
	Metal_getGun								= {"e0070_rtrg0400",1},
	Metal_mistakeGun							= {"e0070_rtrg0410",1},
	Metal_wrong									= "e0070_rtrg0470", 		
	Metal_int									= "e0070_rtrg0420", 		
	Metal_allClear								= {"e0070_rtrg0425",1}, 		
	Metal_allClearThanks						= {"e0070_rtrg0460",1}, 		

	
	Radio_GameClear_Great						= "e0070_rtrg0950",	
	Radio_GameClear_VeryGood					= "e0070_rtrg0940",	
	Radio_GameClear_Good						= "e0070_rtrg0930",	
	Radio_GameClear_Normal						= "e0070_rtrg0920",	
	Radio_GameClear_Bad							= "e0070_rtrg0910",	

	
	Radio_GameOver_PlayerDead					= "e0070_gmov0010",	
	Radio_GameOver_MissionArea					= "e0070_gmov0020",	
	Radio_GameOver_Other						= "f0033_gmov0030",
	Radio_GameOver_PlayerRideHelicopter			= "f0033_gmov0040",
	Radio_GameOver_HelicopterDead				= "f0033_gmov0160",	
	Radio_GameOver_PlayerDestroyHeli			= "f0033_gmov0070",
	Radio_GameOver_MissionFail					= "e0050_gmov0010",
	Radio_GameOver_HelicopterDeadNotPlayerOn	= "f0033_gmov0050",
	Radio_GameOver_General						= "e0070_gmov0010",
	Radio_GameOver_HumanEnemyDead				= "e0070_rtrg0100",	

	
	Radio_WarningMissionArea					= "e0070_rtrg1010",	

	
	Radio_Interogation							= { "e0070_rtrg0320", 1 },	
	Miller_HeliAttack 							= "f0090_rtrg0225",			
	Miller_BreakSuppressor						= "f0090_rtrg0530",			
	Miller_AllGetTape							= { "f0090_rtrg0560", 1 },	
	Miller_CallHeliHot01				= "e0010_rtrg0376",	
	Miller_CallHeliHot02				= "e0010_rtrg0377",	
}
this.OptionalRadioList = {
	OptionalRadio_010	= "Set_e0070_oprg0010",	
	OptionalRadio_020	= "Set_e0070_oprg0020",	
	OptionalRadio_030	= "Set_e0070_oprg0030",	
	OptionalRadio_040	= "Set_e0070_oprg0040",	
}

this.IntelRadioList = {
	
	e20070_SecurityCamera_01	= "f0090_esrg0210",
	e20070_SecurityCamera_02	= "f0090_esrg0210",
	e20070_SecurityCamera_03	= "f0090_esrg0210",
	e20070_SecurityCamera_04	= "f0090_esrg0210",
	e20070_SecurityCamera_05	= "f0090_esrg0210",
	
	intel_f0090_esrg0220		= "f0090_esrg0220",

	intel_f0090_esrg0110		= "f0090_esrg0110",	
	intel_f0090_esrg0120		= "f0090_esrg0120",	
	intel_f0090_esrg0130		= "f0090_esrg0130",	
	intel_f0090_esrg0140		= "f0090_esrg0140",	
	intel_f0090_esrg0150		= "f0090_esrg0150",	
	intel_f0090_esrg0190		= "f0090_esrg0190",	
	intel_f0090_esrg0200		= "f0090_esrg0200",	
	gntn_area01_antiAirGun_000	= "f0090_esrg0030", 
	gntn_area01_antiAirGun_001	= "f0090_esrg0030", 
	gntn_area01_antiAirGun_002	= "f0090_esrg0030", 
	gntn_area01_antiAirGun_003	= "f0090_esrg0030", 
	Tactical_Vehicle_WEST_000	= "f0090_esrg0040", 
	Tactical_Vehicle_WEST_001	= "f0090_esrg0040", 
	APC_Machinegun_WEST_001		= "f0090_esrg0080", 
	APC_Machinegun_WEST_002		= "f0090_esrg0080", 
	
	gntnCom_drum0002			= "f0090_esrg0180",
	gntnCom_drum0005			= "f0090_esrg0180",
	gntnCom_drum0011			= "f0090_esrg0180",
	gntnCom_drum0012			= "f0090_esrg0180",
	gntnCom_drum0015			= "f0090_esrg0180",
	gntnCom_drum0019			= "f0090_esrg0180",
	gntnCom_drum0020			= "f0090_esrg0180",
	gntnCom_drum0021			= "f0090_esrg0180",
	gntnCom_drum0022			= "f0090_esrg0180",
	gntnCom_drum0023			= "f0090_esrg0180",
	gntnCom_drum0024			= "f0090_esrg0180",
	gntnCom_drum0025			= "f0090_esrg0180",
	gntnCom_drum0027			= "f0090_esrg0180",
	gntnCom_drum0028			= "f0090_esrg0180",
	gntnCom_drum0029			= "f0090_esrg0180",
	gntnCom_drum0030			= "f0090_esrg0180",
	gntnCom_drum0031			= "f0090_esrg0180",
	gntnCom_drum0035			= "f0090_esrg0180",
	gntnCom_drum0037			= "f0090_esrg0180",
	gntnCom_drum0038			= "f0090_esrg0180",
	gntnCom_drum0039			= "f0090_esrg0180",
	gntnCom_drum0040			= "f0090_esrg0180",
	gntnCom_drum0041			= "f0090_esrg0180",
	gntnCom_drum0042			= "f0090_esrg0180",
	gntnCom_drum0043			= "f0090_esrg0180",
	gntnCom_drum0044			= "f0090_esrg0180",
	gntnCom_drum0045			= "f0090_esrg0180",
	gntnCom_drum0046			= "f0090_esrg0180",
	gntnCom_drum0047			= "f0090_esrg0180",
	gntnCom_drum0048			= "f0090_esrg0180",
	gntnCom_drum0065			= "f0090_esrg0180",
	gntnCom_drum0066			= "f0090_esrg0180",
	gntnCom_drum0068			= "f0090_esrg0180",
	gntnCom_drum0069			= "f0090_esrg0180",
	gntnCom_drum0070			= "f0090_esrg0180",
	gntnCom_drum0071			= "f0090_esrg0180",
	gntnCom_drum0072			= "f0090_esrg0180",
	gntnCom_drum0101			= "f0090_esrg0180",

	
	intelMark_001 				= "e0070_esrg0010",
	intelMark_002 				= "e0070_esrg0015",
	intelMark_gz 				= "e0070_esrg0019",
	intelMark_mg 				= "e0070_esrg0020",
	intelMark_mg2 				= "e0070_esrg0021",
	intelMark_mgs 				= "e0070_esrg0023",
	intelMark_104 				= "e0070_esrg0022",
	intelMark_mgs2				= "e0070_esrg0024",
	intelMark_mgs3			 	= "e0070_esrg0025",
	e20070_logo_001 			= "e0070_esrg0026",
	intelMark_mgs4 				= "e0070_esrg0027",
	
	
	
	radio_kjpLogo 				= "e0070_esrg0030",
	gntn_serchlight_20070_1		= "e0070_esrg0035",
	gntn_serchlight_20070_0 	= "e0070_esrg0035",
}

for i, characterId in ipairs( this.initialAlienEnemies ) do	
	this.IntelRadioList[ characterId ] = "e0070_esrg0005"
end
for i, characterId in ipairs( this.initialHumanEnemies ) do	
	this.IntelRadioList[ characterId ] = "e0070_esrg0008"
end
for i, characterId in ipairs( this.reinforcements_1_1_AlienEnemies ) do	
	this.IntelRadioList[ characterId ] = "e0070_esrg0005"
end
for i, characterId in ipairs( this.reinforcements_1_2_AlienEnemies ) do	
	this.IntelRadioList[ characterId ] = "e0070_esrg0005"
end
for i, characterId in ipairs( this.reinforcements_2_1_AlienEnemies ) do	
	this.IntelRadioList[ characterId ] = "e0070_esrg0005"
end
for i, characterId in ipairs( this.reinforcements_2_2_AlienEnemies ) do	
	this.IntelRadioList[ characterId ] = "e0070_esrg0005"
end




this.CounterList = {
	GameOverRadioName		= "NoRadio",
	recentMarkerEnemy		= nil,
	radioCount				= 0,
	aimTarget				= nil,
	dyingEnemies			= {},
	clearedEnemies			= {},
	GameOverFadeTime		= GZCommon.FadeOutTime_MissionFailed,	
}

this.Messages = {
	Trap = {
		{ data = "Trap_WarningMissionArea",				message = "Enter", 							commonFunc = this.commonOutsideMissionWarningAreaEnter, },
		{ data = "Trap_WarningMissionArea",				message = "Exit", 							commonFunc = this.commonOutsideMissionWarningAreaExit, },
		{ data = "Trap_EscapeMissionArea",				message = "Enter", 							commonFunc = this.commonOutsideMissionArea, },
		{ data = "Trap_Reinforcements",					message = "Enter",							commonFunc = this.commonOnEnterReinforcementsTrap, },
		{ data = "Trap_Reinforcements",					message = "Exit",							commonFunc = this.commonOnLeaveReinforcementsTrap, },
		{ data = "Trap_Reinforcements2",				message = "Enter",							commonFunc = this.commonOnEnterReinforcementsTrap2, },
		{ data = "Trap_Reinforcements2",				message = "Exit",							commonFunc = this.commonOnLeaveReinforcementsTrap2, },
		{ data = "Trap_Claymore",						message = "Enter",							commonFunc = this.commonPlayClaymoreRadio, },
		
		{ data = "trap_logo", 							message = "Enter", 							commonFunc = this.findFoxLogo },
	},
	Character = {
		{ data = "Player",								message = "RideHelicopter",					commonFunc = this.commonOnPlayerRideHelicopter, },
		{ data = "Player", 								message = "OnPickUpItem" , 					commonFunc = this.Common_PickUpItem },	
		{ data = "Player", 								message = "OnPickUpWeapon", 				commonFunc = this.Common_PickUpWeapon },
		
		{ data = "Player", 								message = "OnPickUpPlaced", 				commonFunc = function()charengeClaymoreCount() end },	
		{ data = "Player", 								message = "WeaponPutPlaced", 				commonFunc = function()charengeClaymorePut() end },	
		{ data = "Player", 								message = "OnActivatePlaced", 				commonFunc = this.DamagedOnClaymore },
		{ data = "Player",								message = "OnVehicleRide_End",				commonFunc = this.commonOnPlayerRideVehicle },				
		
		{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "Dead",							commonFunc = this.commonOnHelicopterDead, },
		{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "CloseDoor",						commonFunc = this.commonOnCloseHeliDoor, },
		{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "LostControl",					commonFunc = this.commonOnHelicopterLostControl },
		{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "DamagedByPlayer",				commonFunc = this.commonHeliDamagedByPlayer },	
		{ data = "e20070_SecurityCamera_01",			message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20070_SecurityCamera_02",			message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20070_SecurityCamera_03",			message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20070_SecurityCamera_04",			message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20070_SecurityCamera_05",			message = "Dead",							commonFunc = this.Common_SecurityCameraBroken },
		{ data = "e20070_SecurityCamera_01",			message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20070_SecurityCamera_02",			message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20070_SecurityCamera_03",			message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20070_SecurityCamera_04",			message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20070_SecurityCamera_05",			message = "PowerOFF",						commonFunc = this.Common_SecurityCameraPowerOff },
		{ data = "e20070_SecurityCamera_01",			message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20070_SecurityCamera_02",			message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20070_SecurityCamera_03",			message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20070_SecurityCamera_04",			message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = "e20070_SecurityCamera_05",			message = "PowerON",						commonFunc = this.Common_SecurityCameraPowerOn },
		{ data = this.CP_ID,							message = "Alert",							commonFunc = this.commonOnAlert },								
		{ data = this.CP_ID,							message = "Evasion",						commonFunc = this.commonOnEvasion },	
		{ data = this.CP_ID,							message = "Caution",						commonFunc = this.commonOnCaution },	
		
	},
	Gimmick = {
		
		{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
	},
	Mission = {
		{												message = "MissionFailure",					localFunc = "commonOnMissionFailure" },
		{												message = "MissionClear",					localFunc = "commonOnMissionClear" },
		{												message = "MissionRestart", 				localFunc = "commonMissionCleanUp" },
		{												message = "MissionRestartFromCheckPoint",	localFunc = "commonMissionCleanUp" },
		{												message = "ReturnTitle",					localFunc = "commonMissionCleanUp" },
	},
	Enemy = {
		{												message = "EnemyInterrogation",				commonFunc = this.commonOnEnemyInterrogation },
		{												message = "EnemyDamage",					commonFunc = this.commonOnEnemyDamaged },
	},
	Timer = {
		{ data = "Timer_KillAllEnemies",				message = "OnEnd", 							commonFunc = this.commonKillAllInitialEnemies },
	},
	Terminal = {
		{												message = "MbDvcActOpenMenu",				commonFunc = this.commonPlayHeliRadio },
		{												message = "MbDvcActWatchPhoto",				commonFunc = this.commonShowPhotRadio },
	},
	Gimmick = {
		
		{ data = "charenge_20070_KJP",					message = "HitLight",						commonFunc =	function() highlightFoxLogo("fox")	end },
		{ data = "charenge_20070_LA",					message = "HitLight",						commonFunc =	function() highlightFoxLogo("la")	end },
		
		{ data = "e20070_logo_001",						message = "HitLight",						commonFunc = function() findTitleLogoMark(1) end},
		{ data = "e20070_logo_002",						message = "HitLight",						commonFunc = function() findTitleLogoMark(2) end},
		{ data = "e20070_logo_003",						message = "HitLight",						commonFunc = function() findTitleLogoMark(3) end},
		{ data = "e20070_logo_004",						message = "HitLight",						commonFunc = function() findTitleLogoMark(4) end},
		{ data = "e20070_logo_005",						message = "HitLight",						commonFunc = function() findTitleLogoMark(5) end},
		{ data = "e20070_logo_006",						message = "HitLight",						commonFunc = function() findTitleLogoMark(6) end},
		{ data = "e20070_logo_007",						message = "HitLight",						commonFunc = function() findTitleLogoMark(7) end},
		{ data = "e20070_logo_008",						message = "HitLight",						commonFunc = function() findTitleLogoMark(8) end},
		{ data = "e20070_logo_101",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		{ data = "e20070_logo_102",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		{ data = "e20070_logo_103",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		{ data = "e20070_logo_104",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		{ data = "e20070_logo_105",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		{ data = "e20070_logo_106",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		{ data = "e20070_logo_107",						message = "HitLight",						commonFunc = function() findTitleLogoMark(10) end},
		
		{ data = "gntn_center_SwitchLight",				message = "SwitchOn",						commonFunc = this.SwitchLight_ON },	
		{ data = "gntn_center_SwitchLight",				message = "SwitchOff",						commonFunc = this.SwitchLight_OFF },	
		
		{ data = "gntn_serchlight_20070_0", 			message = "BreakGimmick", 					commonFunc = function()	challengeChancelFox() end},
		{ data = "gntn_serchlight_20070_1", 			message = "BreakGimmick", 					commonFunc = function()	challengeChancelLA() end},
		{ data = "WoodTurret04", 						message = "BreakGimmick", 					commonFunc = function() challengeChancel()	end },
		
		{ 												message = "DoorUnlock", 					commonFunc = function()  this.Common_DoorUnlock() end},
	},
	Radio = {
		{ data = "AlienEnemy0000",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0000") end	},
		{ data = "AlienEnemy0001",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0001") end	},
		{ data = "AlienEnemy0002",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0002") end	},
		{ data = "AlienEnemy0003",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0003") end	},
		{ data = "AlienEnemy0004",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0004") end	},
		{ data = "AlienEnemy0005",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0005") end	},
		{ data = "AlienEnemy0006",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0006") end	},
		{ data = "AlienEnemy0007",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("AlienEnemy0007") end	},
		{ data = "HumanEnemy0000",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("HumanEnemy0000") end	},
		{ data = "HumanEnemy0001",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("HumanEnemy0001") end	},
		{ data = "HumanEnemy0002",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("HumanEnemy0002") end	},
		{ data = "HumanEnemy0003",						message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("HumanEnemy0003") end	},
		{ data = "Reinforcements_1_1_MissileAlienEnemy0000",	message = "EspionageRadioCandidate",commonFunc = function() commonIntelCheck("Reinforcements_1_1_MissileAlienEnemy0000") end	},
		{ data = "Reinforcements_1_1_AlienEnemy0000",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_1_1_AlienEnemy0000") end	},
		{ data = "Reinforcements_1_1_AlienEnemy0001",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_1_1_AlienEnemy0001") end	},
		{ data = "Reinforcements_1_1_AlienEnemy0002",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_1_1_AlienEnemy0002") end	},
		{ data = "Reinforcements_1_1_AlienEnemy0003",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_1_1_AlienEnemy0003") end	},
		{ data = "Reinforcements_1_1_AlienEnemy0004",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_1_1_AlienEnemy0004") end	},
		{ data = "Reinforcements_1_2_MissileAlienEnemy0000",	message = "EspionageRadioCandidate",commonFunc = function() commonIntelCheck("Reinforcements_1_2_MissileAlienEnemy0000") end	},
		{ data = "Reinforcements_1_2_MissileAlienEnemy0001",	message = "EspionageRadioCandidate",commonFunc = function() commonIntelCheck("Reinforcements_1_2_MissileAlienEnemy0001") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0000",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0000") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0001",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0001") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0002",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0002") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0003",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0003") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0004",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0004") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0005",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0005") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0006",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0006") end	},
		{ data = "Reinforcements_2_1_AlienEnemy0007",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_1_AlienEnemy0007") end	},
		{ data = "Reinforcements_2_2_AlienEnemy0000",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_2_AlienEnemy0000") end	},
		{ data = "Reinforcements_2_2_AlienEnemy0001",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_2_AlienEnemy0001") end	},

		{ data = "Reinforcements_2_2_AlienEnemy0003",	message = "EspionageRadioCandidate",		commonFunc = function() commonIntelCheck("Reinforcements_2_2_AlienEnemy0003") end	},
	},
	RadioCondition = {
		{												message = "SuppressorIsBroken",				commonFunc = function() this.commonSuppressorIsBroken() end },
	},
	Marker = {
		{												message = "ChangeToEnable",	   				commonFunc = function() jinmonMarkCheck() end},
	},

	Demo = {
		{ data = "p11_020002_000",						message = "invis_cam",						commonFunc = function() TppEnemyUtility.PowerOnSecurityCameraByCharacterId( "e20070_SecurityCamera_03", false ) end },
		{ data = "p11_020002_000",						message = "lightOff",						commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",false) end },
		{ data = "p11_020002_000",						message = "lightOn",						commonFunc = function() TppGadgetUtility.SetSwitch("gntn_center_SwitchLight",true) end },
	},
	UI = {
		{												message = "GetAllCassetteTapes" ,			commonFunc = function()  end },	
	},
}








this.ClearRankRewardList = {
	
	RankS = "e20070_Assult",
	RankA = "e20070_Missile",
	RankB = "e20070_Sniper",
	RankC = "e20070_HandShotgun",
}

this.ClearRankRewardPopupList = {
	
	RankS = "reward_clear_s_rifle",
	RankA = "reward_clear_a_rocket",
	RankB = "reward_clear_b_sniper",
	RankC = "reward_clear_c_pistol",
}

this.tmpBestRank = 0
this.tmpRewardNum = 0				

this.Seq_MissionPrepare = {

	OnEnter = function()

		this.tmpBestRank = GZCommon.CheckClearRankReward( this.missionID, this.ClearRankRewardList )

		local sequence = TppSequence.GetCurrentSequence()	
		if	sequence == "Seq_MissionPrepare" or				
			manager:IsStartingFromResearvedForDebug() then	
			this.onMissionPrepare()								
		end

		
		local uiCommonData = UiCommonDataManager.GetInstance()
		this.tmpRewardNum = uiCommonData:GetRewardNowCount( this.missionID )
		Fox.Log("***e20070_MissionPrepare.tmpRewardNum_IS___"..this.tmpRewardNum)

		TppSequence.ChangeSequence( "Seq_LoadOpeningDemo" )	

	end,
}

this.Seq_LoadOpeningDemo = {

	OnEnter = function()

		this.commonLoadDemoBlock()

	end,

	OnUpdate = function()

		
		if IsDemoAndEventBlockActive() then							
			TppSequence.ChangeSequence( "Seq_OpeningShowTransition" )		
		end

	end,

}

this.Seq_OpeningShowTransition = {

	OnEnter = function()

		TppUI.ShowTransition( "opening", {
			onOpeningBgEnd = function()
				TppSequence.ChangeSequence( "Seq_OpeningDemo" ) 
			end, } )

		TppMusicManager.PostJingleEvent( 'MissionStart', 'Play_bgm_gntn_op_default_intro' )

	end,

}


this.Seq_OpeningDemo = {

	MissionState = "exec",

	OnEnter = function()

		
		TppSupportHelicopterService.RequestRouteMode( "e20070_route_heli0003", true, 60 )	
		TppSupportHelicopterService.SearchLightOff()											

		
		TppDemo.Play( "Demo_Opening", {
			onStart = function()

				TppUI.FadeIn(1)

				
				TppGadgetUtility.UnAttachGadgetToChara("e20070_logo_001")

			end,
			onSkip = function()
				TppMission.SetFlag( "isOpeningDemoSkipped", true )
			end,
			onEnd = function()

				
				TppGadgetUtility.AttachGadgetToChara("e20070_logo_001","SupportHelicopter","CNP_MARK")

				
				TppSupportHelicopterService.RequestRouteMode( "e20070_route_heli0003", false, 60 )	
				TppSupportHelicopterService.SearchLightOff()											

				
				TppCharacterUtility.SetMeshVisible( "Player", "MESH_Visor", true )

				
				TppMissionManager.SaveGame( 10 )

				
				TppSequence.ChangeSequence( "Seq_SearchAndDestroy" )

			end }, { disableHelicopter = false } )

	end,
}

this.Seq_SearchAndDestroy = {

	MissionState = "exec",

	Messages = {
		Enemy = {
			{										message = "EnemySleep",					localFunc = "localOnEnemySleep" },
			{										message = "EnemyFaint",					localFunc = "localOnEnemyDisempowerment" },
			{										message = "EnemyDying",					localFunc = "localOnEnemyDying" },
			{										message = "EnemyDead",					localFunc = "localOnEnemyDead" },
			{										message = "EnemyFulton",				localFunc = "localOnEnemyDisempowerment" },
			{										message = "EnemyHoldUp",				localFunc = "localOnEnemyHoldUp" },
		},
		Character = {
			{ data = this.CP_ID,					message = "VehicleMessageRoutePoint",	localFunc = "localOnVehicleRoutePoint" },
			{ data = this.CP_ID,					message = "EndGroupVehicleRouteMove",	localFunc = "localOnGroupVehicleEnd" },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",	message = "AntiAircraftGunBroken",		commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",	message = "AntiAircraftGunBroken",		commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",	message = "AntiAircraftGunBroken",		commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "WoodTurret03",				message = "BreakGimmick", 				localFunc = "localOnWoodTurret03Broken" },
			{ data = "SL_WoodTurret03",				message = "BreakGimmick", 				localFunc = "localOnWoodTurret03Broken" },
			{ data = "gntn_serchlight_20070_1",		message = "BreakGimmick", 				localFunc = "localOnSearchLight002Broken" },
		},
		Marker = {
			{										message = "ChangeToEnable",				localFunc = "localOnMarkerEnabled" },
		},
		Timer = {
			{ data = "Timer_VechicleStart",			message = "OnEnd",						localFunc = "localStartVehicle" },
			{ data = "Timer_EnableControlTower",	message = "OnEnd",						localFunc = "localEnableControlTowerEnemy" },
			{ data = "Timer_BackgroundRadio",		message = "OnEnd",						localFunc = "localPlayBackgroundRadio" },
			{ data = "Timer_PlayMarkerRadio",		message = "OnEnd",						localFunc = "localPlayMarkerRadio" },
			{ data = "Timer_PlayReminderRadio",		message = "OnEnd",						localFunc = "localPlayReminderRadio" },
		},
		Trap = {
			{ data = "Trap_TutorialRadio",			message = "Enter",						localFunc = "localPlayTutorialRadio" },
			{ data = "Trap_StartVehicle",			message = "Enter",						localFunc = "localStartVehicleTimer" },
			{ data = "Trap_ChangeEnemyRoute",		message = "Enter",						localFunc = "localChangeEnemyRoute" },
			
			{ data = "trap_merker_01", 				message = "Enter",						commonFunc = function()TppRadio.Play( "Metal_getGun" ) end },
		},
		Terminal = {
			{										message = "MbDvcActSelectNonActiveMenu",	commonFunc = function() TppRadio.Play( "Radio_Heli2" ) end, },
		},
	},

	OnEnter = function()

		
		if TppMission.GetFlag( "isOpeningDemoSkipped" ) == true then									
			TppRadio.DelayPlay( "Radio_Continue2", "mid", nil, {											
				onStart = function()
					this.Seq_SearchAndDestroy.localUpdateMapAnnounceLog()
				end,
				onEnd = function()
					GkEventTimerManager.Start( "Timer_BackgroundRadio", 5 )
				end } )
		else																							
			TppRadio.DelayPlay( "Radio_MissionStart", "mid", "begin", {	
				onEnd = function()

					TppRadio.DelayPlay( { "Radio_Continue", "Radio_NoKill" }, "short", "end", {
						onStart = function()
							this.Seq_SearchAndDestroy.localUpdateMapAnnounceLog()
						end,
						onEnd = function()
							GkEventTimerManager.Start( "Timer_BackgroundRadio", 5 )
						end } )

				end } )
		end
		if TppMission.GetFlag( "isVehicleStarted" ) == true then										
			GkEventTimerManager.Start( "Timer_VechicleStart", 10 )											
		end

		if TppMission.GetFlag( "isControlTowerEnemyEnabled" ) == true then								
			GkEventTimerManager.Start( "Timer_EnableControlTower", 30 )										
		end

		
		this.SetIntelRadio()										
		TppRadio.RegisterOptionalRadio( "OptionalRadio_010" )		
		
		this.Seq_SearchAndDestroy.localStartReminderTimer()

		
		
		TppCommandPostObject.GsSetGuardTargetValidity( this.CP_ID, "TppGuardTargetData_VipA0002", false )	
		TppCommandPostObject.GsSetGuardTargetValidity( this.CP_ID, "TppGuardTargetData_VipA0003", true )	
		TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_d01_route0005", true )
		
		for i, characterId in ipairs( this.initialHumanEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, true )	
			local routeName = this.characterIdToRouteMap[ characterId ]
			if routeName ~= nil then
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_d01", routeName, 0, characterId )
			end
		end
		for i, characterId in ipairs( this.initialAlienEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, true )	
			local routeName = this.characterIdToRouteMap[ characterId ]
			if routeName ~= nil then
				TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_d01", routeName, 0, characterId )
			end
		end
		
		TppCommandPostObject.GsSetCurrentRouteSet( this.CP_ID, "e20070_route_d01", true, true, true, true )	
		TppCharacterUtility.ResetPhase()																	

		
		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then

				
				luaData:SetCurrentMissionSubGoalNo( 1 )

			end
		end
		
		TppMarkerSystem.DisableMarker{ markerId = this.CHARACTER_ID_ENEMY_VEHICLE }

	end,

	localOnWoodTurret03Broken = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		if characterId == "WoodTurret03" or characterId == "SL_WoodTurret03" then
			
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20070_d01_route0013", "e20070_d01_route0000" )
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20070_c01_route0032", "e20070_c01_route0000" )
			
			TppMission.SetFlag( "isWoodTurret03Broken", true )
		end

	end,

	
	localOnSearchLight002Broken = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		if characterId == "gntn_serchlight_20070_1" then
			
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20070_d01_route0014", "e20070_d01_route0002" )
			TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20070_c01_route0033", "e20070_c01_route0002" )
			
			TppMission.SetFlag( "isSearchLight02Broken", true )
		end

	end,

	
	localUpdateMapAnnounceLog = function()

		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then

				luaData:StartGzIntelligence( this.CP_ID, 2.0, 1.0 )	

				TppMission.SetFlag( "isTerminalUpdated", true )		

				
				local hudCommonData = HudCommonDataManager.GetInstance()				
				hudCommonData:AnnounceLogViewLangId( "announce_map_update" )			

			end
		end

	end,

	localChangeEnemyRoute = function()

		TppCommandPostObject.GsSetExclusionRoutes( this.CP_ID, "e20070_d01_route0005", "e20070_d01_route0010" )

	end,

	localStartVehicleTimer = function()

		if TppMission.GetFlag( "isVehicleStarted" ) == false then
			GkEventTimerManager.Start( "Timer_VechicleStart", 1 )
			
		end

	end,

	localStartVehicle = function()

		TppCommandPostObject.GsSetGroupVehicleRoute( this.CP_ID, this.CHARACTER_ID_ENEMY_VEHICLE, "e20070_vehicle_route0000", 0 )

		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ENEMY_VEHICLE, true )
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ALIEN_DRIVER, true )
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_HUMAN_DRIVER, true )

	end,

	
	localPlayTutorialRadio = function()

		if	TppMission.GetFlag( "isHumanMarked" ) == false and
			TppMission.GetFlag( "isAlienMarked" ) == false and
			TppMission.GetFlag( "isAlienKilled" ) == false and
			TppMission.GetFlag( "isHumanKilled" ) == false then

			TppRadio.DelayPlay( "Radio_Marking", "mid" )

			if TppMission.GetFlag( "isTerminalUpdated" ) == false then	
				this.Seq_SearchAndDestroy.localUpdateMapAnnounceLog()		
			end

		end

	end,

	localPlayBackgroundRadio = function()

		local player = TppPlayerUtility.GetLocalPlayerCharacter()
		local pos = player:GetPosition()
		if	TppCharacterUtility.GetCurrentPhaseName() ~= "Alert" and						
			TppEnemyUtility.GetNumberOfActiveSoldier( pos, 75 ) == 0 then					

			TppRadio.DelayPlayEnqueue( "Radio_Background", "long" )

		else
			GkEventTimerManager.Start( "Timer_BackgroundRadio", 5 )
		end

	end,

	
	localOnVehicleRoutePoint = function()

		local vehicleInfo = TppEventSequenceManagerCollector.GetMessageArg( 1 )
		if	vehicleInfo.vehicleCharacterId == this.CHARACTER_ID_ENEMY_VEHICLE and
			vehicleInfo.vehicleRouteId == GsRoute.GetRouteId( "e20070_vehicle_route0001" ) then

			if vehicleInfo.passedNodeIndex == 7 then
				TppCommandPostObject.GsSetGroupVehicleRoute( this.CP_ID, this.CHARACTER_ID_ENEMY_VEHICLE, "e20070_vehicle_route0000", 0 )
			elseif vehicleInfo.passedNodeIndex == 0 then

				
				TppMission.SetFlag( "isVehicleStarted", true )

			end

		end

	end,

	
	localOnGroupVehicleEnd = function()

		local vehicleInfo = TppEventSequenceManagerCollector.GetMessageArg( 1 )
		if vehicleInfo.routeInfoName == "TppGroupVehicleRouteInfo0000" then

			
			TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_ride_route0000", true )
			TppCommandPostObject.GsAddDisabledRoutes( this.CP_ID, "e20070_ride_route0001", true )

			
			TppMission.SetFlag( "isGroupVehicleEnd", true )

		end

	end,

	
	localStartHintTimer = function()

		GkEventTimerManager.Start( "Timer_Hint", 10 )

	end,

	localStartReminderTimer = function()

		GkEventTimerManager.Start( "Timer_PlayReminderRadio", 120 )

	end,

	localRestartHintTimer = function()

		GkEventTimerManager.Stop( "Timer_Hint" )
		this.Seq_SearchAndDestroy.localStartHintTimer()

	end,

	localRestartReminderTimer = function()

		GkEventTimerManager.Stop( "Timer_PlayReminderRadio" )
		this.Seq_SearchAndDestroy.localStartReminderTimer()

	end,

	localPlayReminderRadio = function()

		if	TppMission.GetFlag( "isReminderRadio1Played" ) == false and
			TppCharacterUtility.GetCpPhaseName( this.CP_ID ) == "Sneak" then

			TppRadio.PlayEnqueue( "Radio_Reminder1", {
				onStart = function()
					this.Seq_SearchAndDestroy.localUpdateMapAnnounceLog()
				end } )
			TppMission.SetFlag( "isReminderRadio1Played", true )

		elseif	TppMission.GetFlag( "isReminderRadio2Played" ) == false and
				TppCharacterUtility.GetCpPhaseName( this.CP_ID ) == "Sneak" then

			TppRadio.PlayEnqueue( "Radio_Reminder2", {
				onStart = function()
					this.Seq_SearchAndDestroy.localUpdateMapAnnounceLog()
				end } )
			TppMission.SetFlag( "isReminderRadio2Played", true )

		end

		this.Seq_SearchAndDestroy.localRestartReminderTimer()

	end,

	
	localChangeSequenceIfSequenceClear = function()

		local normalCount = this.commonCountNormal( this.initialHumanEnemies )
		local aliveCount = this.commonCountAlive( this.initialAlienEnemies )
		Fox.Log( "normalCount:" .. normalCount .. ", aliveCount:" .. aliveCount )
		if	normalCount == 0 and	
			aliveCount == 0 then	

			
			local commonDataManager = UiCommonDataManager.GetInstance()
			if commonDataManager ~= NULL then
				local luaData = commonDataManager:GetUiLuaExportCommonData()
				if luaData ~= NULL then
					luaData:SetCompleteMissionPhotoId( 10, true )
				end
			end

			
			TppSequence.ChangeSequence( "Seq_GotoHeliport" )

		end

	end,

	
	localPlayTargetClearRadioIfFulfillRequirement = function( isAlien, isKilled )

		if	TppCharacterUtility.GetCurrentPhaseName() == "Alert" then	
			return
		end

		if isAlien == true then																								
			if isKilled == true then																							
				if RadioDaemon:GetInstance():IsRadioGroupMarkAsRead( this.RadioList[ "Radio_AlienDead" ] ) == false then			
					TppRadio.DelayPlay( "Radio_AlienDead", "short" )																					
					return																												
				elseif TppCharacterUtility.GetCpPhaseName( this.CP_ID ) ~= "Alert" then	
					TppRadio.DelayPlay( "Radio_TargetClear_First", "short" )					
					return
				end

			else																												
				if RadioDaemon:GetInstance():IsRadioGroupMarkAsRead( this.RadioList[ "Radio_AlienDisempowerment" ] ) == false then	
					TppRadio.DelayPlay( "Radio_AlienDisempowerment", "short" )																		
					return																												
				end

				return

			end
		else																												
			if isKilled == true then																							
				if RadioDaemon:GetInstance():IsRadioGroupMarkAsRead( this.RadioList[ "Radio_HumanDead" ] ) == false then			
					TppRadio.DelayPlay( "Radio_HumanDead", "short" )																					
					return																												
				end
			end
		end

	end,

	
	localOnEnemyClear = function( characterId, isKilled, isDying, isSleep )

		Fox.Log( "e20070_sequence.Seq_SearchAndDestroy.localOnEnemyClear()" )

		local isAlien = this.commonIsAlienEnemy( characterId )

		if isAlien == true then										
			if isKilled == true then									
				if this.commonIsClearedEnemy( characterId ) == false then	
					this.Seq_SearchAndDestroy.localShowAnnounceLog()			
					this.commonAddClearedEnemy( characterId )
				end
				TppMission.SetFlag( "isAlienKilled", true )
			end
		else														
			if isKilled == true then
				TppMission.SetFlag( "isHumanKilled", true )
				
			else
			end
			
			if isKilled == true and this.commonIsDyingEnemy( characterId ) then

			else
				this.Seq_SearchAndDestroy.localShowAnnounceLog()			
				this.commonAddClearedEnemy( characterId )
			end
			
		end

		
		if isKilled == true and this.commonIsDyingEnemy( characterId ) then								
																											
		elseif isDying == true then																		
			this.Seq_SearchAndDestroy.localPlayTargetClearRadioIfFulfillRequirement( isAlien, true )		
		elseif isAlien == true and isSleep == true then

		else																							
			this.Seq_SearchAndDestroy.localPlayTargetClearRadioIfFulfillRequirement( isAlien, isKilled )	
		end

		
		this.Seq_SearchAndDestroy.localRestartHintTimer()

		
		this.Seq_SearchAndDestroy.localChangeSequenceIfSequenceClear()

	end,

	
	localOnEnemyDying = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )

		if this.commonIsHumanEnemy( characterId ) == true then
			this.Seq_SearchAndDestroy.localOnEnemyClear( characterId, false, true )
		end

		
		this.Seq_SearchAndDestroy.localRestartReminderTimer()

		
		this.commonDisableInterogationAbout( characterId )

		
		this.commonAddDyingEnemy( characterId )

	end,

	
	localOnEnemyDead = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		this.Seq_SearchAndDestroy.localOnEnemyClear( characterId, true )

		
		this.Seq_SearchAndDestroy.localRestartReminderTimer()

		
		this.commonDisableInterogationAbout( characterId )

		this.commonDeleteDyingEnemy( characterId )

	end,

	
	localOnEnemyDisempowerment = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		this.Seq_SearchAndDestroy.localOnEnemyClear( characterId, false )

		
		this.Seq_SearchAndDestroy.localRestartReminderTimer()

		
		this.commonDisableInterogationAbout( characterId )

	end,

	
	localOnEnemyHoldUp = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		if this.commonIsHumanEnemy( characterId )  == true then
			this.Seq_SearchAndDestroy.localOnEnemyClear( characterId, false )
		else
			
			TppRadio.DelayPlay( "Radio_HoldupAlien", "short", nil )
		end

		
		this.Seq_SearchAndDestroy.localRestartReminderTimer()

		
		this.commonDisableInterogationAbout( characterId )

	end,

	localOnEnemySleep = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		this.Seq_SearchAndDestroy.localOnEnemyClear( characterId, false, false, true )

		
		this.Seq_SearchAndDestroy.localRestartReminderTimer()

		
		this.commonDisableInterogationAbout( characterId )

	end,

	
	localShowAnnounceLog = function()

		
		local hudCommonData = HudCommonDataManager.GetInstance()
		if hudCommonData ~= nil then
			local targetNum = this.commonCountAlive( this.initialAlienEnemies ) + this.commonCountNormal( this.initialHumanEnemies )	
			local currentClearCount = TppMission.GetFlag( "currentClearCount" )
			local maxTargetNum = #(this.initialAlienEnemies) + #(this.initialHumanEnemies)												
			if (maxTargetNum - targetNum) - currentClearCount > 1 then
				currentClearCount = currentClearCount + 1
			else
				currentClearCount = maxTargetNum - targetNum
			end
			hudCommonData:AnnounceLogViewLangId( "announce_mission_goal_num", currentClearCount, maxTargetNum )			
			TppMission.SetFlag( "currentClearCount", currentClearCount )
		end

	end,

	
	localPlayMarkerRadio = function()

		Fox.Log( "e20070_sequence.Seq_SearchAndDestroy.localPlayMarkerRadio()" )

		if	TppCharacterUtility.GetCurrentPhaseName() ~= "Alert" then	

			local characterId = this.CounterList.recentMarkerEnemy

			Fox.Log( "localPlayMarkerRadio: characterId:" .. characterId )

			if this.commonIsMarkerEnabledByInterogation( characterId ) == false then

				
				if this.commonIsAlienEnemy( characterId ) == true then
					if TppMission.GetFlag( "isAlienMarked" ) == false then	

						
						TppRadio.DelayPlay( "Radio_MarkingAlien", "mid", nil, {
							onEnd = function()
								if this.commonIsEnemyAlive( characterId ) then
									TppRadio.Play( "Radio_MarkingAlien2" )
								end
							end } )

						
						TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_e20070_snatcher" )

						
						TppMission.SetFlag( "isAlienMarked", true )
					end

					

				elseif this.commonIsHumanEnemy( characterId ) == true then

					if TppMission.GetFlag( "isHumanMarked" ) == false then

						TppRadio.DelayPlay( "Radio_MarkingHuman", "mid", "begin", {
							onEnd = function()

								if this.commonIsEnemyAlive( characterId ) == true then
									TppRadio.DelayPlay( "Radio_Interogation", "long", "end" )
								end

							end } )
						TppMission.SetFlag( "isHumanMarked", true )

					else

						local radioDaemon = RadioDaemon:GetInstance()
						if( radioDaemon:IsRadioGroupMarkAsRead( "e0070_rtrg0320" ) == false ) then
							TppRadio.DelayPlay( "Radio_Interogation", "mid", "end" )
						end

					end

				end


			end

		end

		this.Seq_SearchAndDestroy.localRestartHintTimer()
		this.CounterList.recentMarkerEnemy = nil

	end,

	
	localOnMarkerEnabled = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )

		if this.commonIsAlienEnemy( characterId ) == true or this.commonIsHumanEnemy( characterId ) == true then

			Fox.Log( "localOnMarkerEnabled: characterId:" .. characterId )

			
			TppRadio.EnableIntelRadio( characterId )

			
			this.CounterList.recentMarkerEnemy = characterId			
			GkEventTimerManager.Start( "Timer_PlayMarkerRadio", 0.1 )	

			
			this.Seq_SearchAndDestroy.localRestartReminderTimer()

		end

		this.commonDisableInterogationAbout( characterId )	

	end,

}

this.Seq_GotoHeliport = {

	MissionState = "exec",

	Messages = {
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
		Trap = {
			
			{ data = "trap_merker_01", 				message = "Enter",						commonFunc = function()TppRadio.Play( "Metal_getGun" ) end },
		},
	},

	OnEnter = function()

		
		for i, areaName in ipairs( this.areas ) do
			TppMarkerSystem.DisableMarker{ markerId = areaName, viewType = "VIEW_MAP_GOAL" }
		end

		TppRadio.DelayPlay( { "Radio_TargetClear_Last", "Radio_Sequence1Clear" }, "mid", nil, {
			onStart = function()
				if TppMission.GetFlag( "isSceneMusicStarted" ) == false then
					TppMusicManager.StartSceneMode()
					TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
					TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_00' )
					TppMission.SetFlag( "isSceneMusicStarted", true )
				end
			end,
			onEnd = function()

			end } )

		TppMarkerSystem.EnableMarker{ markerId = "marker_e20070_heliport", viewType = { "VIEW_MAP_GOAL", "VIEW_WORLD_GOAL" } }
		TppMarkerSystem.SetMarkerGoalType{ markerId = "marker_e20070_heliport", goalType="GOAL_MOVE", radiusLevel=0 }

		TppCommandPostObject.GsSetAntiAircraftMode( this.CP_ID, false )	

		
		TppSupportHelicopterService.SearchLightOn()
		TppSupportHelicopterService.StartSearchLightAutoAimToCharacter( "Player" )

		this.SetIntelRadio()										
		TppRadio.RegisterOptionalRadio( "OptionalRadio_020" )		

		
		TppDataUtility.SetEnableDataFromIdentifier( "DataIdentifier_CheckPointTraps", "CheckPointTraps", false, true )

		
		TppCommandPostObject.GsSetGuardTargetValidity( this.CP_ID, "TppGuardTargetData_VipA0002", true )	
		TppCommandPostObject.GsSetGuardTargetValidity( this.CP_ID, "TppGuardTargetData_VipA0003", false )	

		
		for i, characterId in ipairs( this.initialHumanEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, false )	
		end
		for i, characterId in ipairs( this.initialAlienEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, false )	
		end
		
		for i, characterId in ipairs( this.initialHumanEnemies ) do

			TppEnemyUtility.SetLifeFlagByCharacterId( characterId, "NoRecoverFaint" )
			TppEnemyUtility.SetLifeFlagByCharacterId( characterId, "NoRecoverSleep" )

			local lifeStatus = TppEnemyUtility.GetLifeStatus( characterId )
			if lifeStatus ~= "Sleep" and lifeStatus ~= "Faint" and lifeStatus ~= "Dead" then
				TppEnemyUtility.ChangeStatus( characterId , "Faint" )
			end

		end

		
		setHeliMarker()

		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then

				
				luaData:SetCurrentMissionSubGoalNo( 2 )

				
				local hudCommonData = HudCommonDataManager.GetInstance()				
				hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )	

			end
		end

		if TppMission.GetFlag( "isPlayerInReinforcementsTrap" ) == true then
			if TppMission.GetFlag( "isHelicopterCalled" ) == false then
				TppSupportHelicopterService.RequestRouteMode( "DropRoute_HeliPort0000", true, 60 )	
				
				TppMission.SetFlag( "isHelicopterCalled", true )
			end
		end

	end,

	localChangeSequenceIfSequenceClear = function()

		if	TppMission.GetFlag( "isPlayerInReinforcementsTrap" ) == true and
			TppMission.GetFlag( "isHeliInReinforcementsTrap" ) == true then

			if TppMission.GetFlag( "isSceneMusicStarted" ) == false then
				TppMusicManager.StartSceneMode()
				TppMusicManager.PlaySceneMusic( "Play_bgm_e20070_scene_btt" )
				TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_00' )
				TppMission.SetFlag( "isSceneMusicStarted", true )
			end

			TppSequence.ChangeSequence( "Seq_AppearReinforcements1" )

		end

	end,

}

this.Seq_AppearReinforcements1 = {

	MissionState = "exec",

	Messages = {
		Timer = {
			{ data = "Timer_OpenGate",						message = "OnEnd",				localFunc = "localOpenGate" },
			{ data = "Timer_AppearMissile",					message = "OnEnd",				localFunc = "localAppearMissile" },
			{ data = "Timer_ChangeEnemyRoute",				message = "OnEnd",				localFunc = "localChangeEnemyRoute" },
		},
		Enemy = {
			{												message = "MessageRoutePoint",	commonFunc = this.commonOnMessageRoutePoint },
			{												message = "EnemyDead",			localFunc = "localOnEnemyDead" },
		},
		Marker = {
			{												message = "ChangeToEnable",		commonFunc = this.commonOnMarkerEnabled },
		},
		Character = {
			{ data = this.CP_ID,							message = "Alert",				localFunc = "localOnAlert" },
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "NotifyLifeRate",		commonFunc = this.commonOnNotifyLifeRate },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		this.commonDisableEnemies( this.initialAlienEnemies )					

		
		GkEventTimerManager.Start( "Timer_OpenGate", 1 )								
		GkEventTimerManager.Start( "Timer_AppearMissile", 12 )								
		GkEventTimerManager.Start( "Timer_ChangeEnemyRoute", 15 )							

		TppMarkerSystem.DisableMarker{ markerId = "marker_e20070_heliport", viewType = { "VIEW_MAP_GOAL", "VIEW_WORLD_GOAL" } }

		TppMissionManager.SaveGame( 20 )	

		this.SetIntelRadio()										
		TppRadio.RegisterOptionalRadio( "OptionalRadio_030" )		

	end,

	localOpenGate = function()

		
		local gateObj = Ch.FindCharacterObjectByCharacterId( "gntn_BigGate" )
		local gateChara = gateObj:GetCharacter()
		gateChara:SendMessage( TppGadgetStartActionRequest() )

		TppRadio.DelayPlay( "Radio_Reinforcements1", "long", nil, {	
			onStart = function()

				
				TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_01' )

				
				TppSupportHelicopterService.StopSearchLightAutoAim()
				TppSupportHelicopterService.SetSearchLightAngle( 0, 0 )
				TppSupportHelicopterService.ChangeRouteWithNodeIndex( "e20070_route_heli0009" )

			end,
			onEnd = function()

				TppRadio.DelayPlay( "Radio_HeliTarget_Light", "short" )
				
				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then

						
						luaData:SetCurrentMissionSubGoalNo( 3 )

						
						local hudCommonData = HudCommonDataManager.GetInstance()				
						hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )			
						hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )	

					end
				end
			end } )

	end,

	localAppearMissile = function()

		
		local characterId = "Reinforcements_1_1_MissileAlienEnemy0000"
		TppEnemyUtility.SetEnableCharacterId( characterId, true )
		this.commnoSetEnemyReinforcements( characterId )
		TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_reinforcements1", this.characterIdToRouteMap[ characterId ], 0, characterId )
		TppEnemyUtility.SetForceRouteMode( characterId, true )
		TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, true )

		
		local cpRouteSets = {
			{
				cpID = this.CP_ID,
				sets = {
					sneak_night = "e20070_route_reinforcements1",
					caution_night = "e20070_route_reinforcements1",
				},
			},
		}
		TppEnemy.SetRouteSets( cpRouteSets, { forceUpdate = true, forceReload = true, startAtZero = true, warpEnemy = false } )	
		TppCommandPostObject.GsSetAntiAircraftMode( this.CP_ID, false )															

	end,

	localChangeEnemyRoute = function()

		
		this.commonEnableEnemies( this.reinforcements_1_1_AlienEnemies )			
		this.commnoSetEnemiesReinforcements( this.reinforcements_1_1_AlienEnemies )	
		for i, characterId in ipairs( this.reinforcements_1_1_AlienEnemies ) do
			TppEnemyUtility.SetForceRouteMode( characterId, true )
			TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, true )	
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_reinforcements1", this.characterIdToRouteMap[ characterId ], 0, characterId )
		end

		
		local cpRouteSets = {
			{
				cpID = this.CP_ID,
				sets = {
					sneak_night = "e20070_route_reinforcements1",
					caution_night = "e20070_route_reinforcements1",
				},
			},
		}
		TppEnemy.SetRouteSets( cpRouteSets, { forceUpdate = true, forceReload = true, startAtZero = true, warpEnemy = false } )	
		TppCommandPostObject.GsSetAntiAircraftMode( this.CP_ID, false )															

		TppSequence.ChangeSequence( "Seq_BattleInHeliport1" )

	end,

	localOnEnemyDead = function()

		this.commonHeliAimEnemy()
		this.Seq_BattleInHeliport1.localChangeSequenceIfSequenceClear()														

	end,

	localOnAlert = function()

		this.commonSetAntiAircraftMode()
		this.commonStopForceRouteMode( this.reinforcements_1_1_AlienEnemies )

	end,

}

this.Seq_BattleInHeliport1 = {

	MissionState = "exec",

	Messages = {
		Enemy = {
			{												message = "EnemyDead",			localFunc = "localOnEnemyDead" },
			{												message = "MessageRoutePoint",	commonFunc = this.commonOnMessageRoutePoint },
		},
		Marker = {
			{												message = "ChangeToEnable",		commonFunc = this.commonOnMarkerEnabled },
		},
		Character = {
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "NotifyLifeRate",		commonFunc = this.commonOnNotifyLifeRate },
			{ data = this.CP_ID,							message = "Alert",				localFunc = "localOnAlert" },
		},
		Trap = {
			{ data = "Trap_AntiAirGun",						message = "Enter",				commonFunc = this.commonOnEnemyNearAntiAirGun, },
 			{ data = "Trap_Heliport1",						message = "Enter",				localFunc = "localOnAlert", },
			{ data = "Trap_Reinforcements2",				message = "Enter",				localFunc = "localChangeSequenceIfSequenceClear" },
		},
		Timer = {
			{ data = "Timer_SetAntiAircraftMode",			message = "OnEnd",				commonFunc = this.commonSetAntiAircraftMode },
			{ data = "Timer_StartHelicopter",				message = "OnEnd",				localFunc = "localStartHelicopter" },
			{ data = "Timer_ChangeSequence",				message = "OnEnd",				localFunc = "localChangeSequence" },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		this.SetIntelRadio()										
		TppRadio.RegisterOptionalRadio( "OptionalRadio_030" )		

		
		GkEventTimerManager.Start( "Timer_StartHelicopter", 5 )
		GkEventTimerManager.Start( "Timer_SetAntiAircraftMode", 10 )

		
		this.Seq_BattleInHeliport1.localChangeSequenceIfSequenceClear()

	end,

	localStartHelicopter = function()

		
		TppSupportHelicopterService.SearchLightOn()
		this.commonHeliAimEnemy()

	end,

	localChangeSequence = function()

		TppSequence.ChangeSequence( "Seq_BattleInHeliport1_1" )								

	end,

	localChangeSequenceIfSequenceClear = function()

		if	this.commonIsEnemiesDead( this.reinforcements_1_1_AlienEnemies ) == true and	
			TppMission.GetFlag( "isPlayerInReinforcementsTrap2" ) == true then				

			
			TppSupportHelicopterService.StopSearchLightAutoAim()
			TppSupportHelicopterService.SetSearchLightAngle( 0, 0 )
			TppSupportHelicopterService.ChangeRouteWithNodeIndex( "e20070_route_heli0000" )	

			
			GkEventTimerManager.Start( "Timer_ChangeSequence", 3 )

		elseif	this.commonIsEnemiesDead( this.reinforcements_1_1_AlienEnemies ) == true and	
				TppMission.GetFlag( "isPlayerInReinforcementsTrap2" ) == false then				

			
			TppMarkerSystem.EnableMarker{ markerId = "marker_e20070_heliport", viewType = { "VIEW_MAP_GOAL", "VIEW_WORLD_GOAL" } }
			TppMarkerSystem.SetMarkerGoalType{ markerId = "marker_e20070_heliport", goalType="GOAL_MOVE", radiusLevel=0 }

		end

	end,

	localOnEnemyDead = function()

		TppRadio.DelayPlay( "Radio_TargetClear_Reinforcements", "short" )
		this.commonHeliAimEnemy()
		this.Seq_BattleInHeliport1.localChangeSequenceIfSequenceClear()	

	end,

	localOnAlert = function()

		this.commonSetAntiAircraftMode()
		this.commonStopForceRouteMode( this.reinforcements_1_1_AlienEnemies )

	end,

}

this.Seq_BattleInHeliport1_1 = {

	MissionState = "exec",

	Messages = {
		Enemy = {
			{												message = "EnemyDead",			localFunc = "localOnEnemyDead" },
			{												message = "MessageRoutePoint",	commonFunc = this.commonOnMessageRoutePoint },
		},
		Marker = {
			{												message = "ChangeToEnable",		commonFunc = this.commonOnMarkerEnabled },
		},
		Character = {
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "NotifyLifeRate",		commonFunc = this.commonOnNotifyLifeRate },
			{ data = this.CP_ID,							message = "Alert",				localFunc = "localOnAlert" },
		},
		Trap = {
			{ data = "Trap_AntiAirGun",						message = "Enter",				commonFunc = this.commonOnEnemyNearAntiAirGun, },
			{ data = "Trap_Heliport2",						message = "Enter",				localFunc = "localOnAlert", },
			{ data = "Trap_Reinforcements2",				message = "Enter",				localFunc = "localChangeSequenceIfSequenceClear" },
		},
		Timer = {
			
			{ data = "Timer_ChangeSequence",				message = "OnEnd",				localFunc = "localChangeSequence" },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		
		for i, characterId in ipairs( this.reinforcements_1_1_AlienEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, false )	
		end
		
		TppMarkerSystem.DisableMarker{ markerId = "marker_e20070_heliport", viewType = { "VIEW_MAP_GOAL", "VIEW_WORLD_GOAL" } }

		
		TppRadio.DelayPlay( { "Radio_HeliTarget_Missile", "Radio_HeliTarget_Light" }, "mid", nil, {
			onStart = function()

			end,
			onEnd = function()

				TppSupportHelicopterService.SearchLightOn()
				this.commonHeliAimEnemy()

				
				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then
						local hudCommonData = HudCommonDataManager.GetInstance()				
						hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )			
					end
				end

			end } )														
		this.SetIntelRadio()											
		TppRadio.RegisterOptionalRadio( "OptionalRadio_030" )			

		
		this.commonUnsetAntiAircraftMode()	

		
		for i, reinforcementsCharacterId in ipairs( this.reinforcements_1_2_AlienEnemies ) do
			TppEnemyUtility.SetEnableCharacterId( reinforcementsCharacterId, true )												
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_reinforcements1", this.characterIdToRouteMap[ reinforcementsCharacterId ], 0, reinforcementsCharacterId )
			this.commnoSetEnemyReinforcements( reinforcementsCharacterId )														
			TppEnemyUtility.SetForceRouteMode( reinforcementsCharacterId, true )
		end

		
		GkEventTimerManager.Start( "Timer_SetAntiAircraftMode", 30 )

	end,

	localChangeSequence = function()

		TppSequence.ChangeSequence( "Seq_AppearReinforcements2" )	

	end,

	localChangeSequenceIfSequenceClear = function()

		if	this.commonIsEnemiesDead( this.reinforcements_1_2_AlienEnemies ) == true and	
			TppMission.GetFlag( "isPlayerInReinforcementsTrap2" ) == true then				

			
			TppSupportHelicopterService.StopSearchLightAutoAim()
			TppSupportHelicopterService.SetSearchLightAngle( 0, 0 )
			TppSupportHelicopterService.ChangeRouteWithNodeIndex( "e20070_route_heli0008" )	

			
			GkEventTimerManager.Start( "Timer_ChangeSequence", 3 )

		elseif	this.commonIsEnemiesDead( this.reinforcements_1_1_AlienEnemies ) == true and	
				TppMission.GetFlag( "isPlayerInReinforcementsTrap2" ) == false then				

			
			TppMarkerSystem.EnableMarker{ markerId = "marker_e20070_heliport", viewType = { "VIEW_MAP_GOAL", "VIEW_WORLD_GOAL" } }
			TppMarkerSystem.SetMarkerGoalType{ markerId = "marker_e20070_heliport", goalType="GOAL_MOVE", radiusLevel=0 }

		end

	end,

	localOnEnemyDead = function()

		this.commonHeliAimEnemy()
		this.Seq_BattleInHeliport1_1.localChangeSequenceIfSequenceClear()														

	end,

	localOnAlert = function()

		this.commonSetAntiAircraftMode()
		this.commonStopForceRouteMode( this.reinforcements_1_1_AlienEnemies )

	end,
}

this.Seq_AppearReinforcements2 = {

	MissionState = "exec",

	Messages = {
		Enemy = {
			{												message = "EnemyDead",					localFunc = "localOnEnemyDead" },
		},
		Timer = {
			{ data = "Timer_WaitEnemyHelicopter",			message = "OnEnd",						localFunc = "localChangeEnemyHelicopterCombatRoute" },
			{ data = "Timer_WaitRealize",					message = "OnEnd",						localFunc = "localChangeEnemyHelicopterRoute" },
			{ data = "Timer_ChangeSequence",				message = "OnEnd",						localFunc = "localChangeSequence" },
		},
		Marker = {
			{												message = "ChangeToEnable",				commonFunc = this.commonOnMarkerEnabled },
		},
		Character = {
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "NotifyLifeRate",		commonFunc = this.commonOnNotifyLifeRate },
			{ data = this.CHARACTER_ID_ENEMY_HELICOPTER,	message = "MessageRoutePoint",	localFunc = "localOnMessageRoutePoint" },
			{ data = this.CP_ID,							message = "Alert",				localFunc = "localOnAlert" },
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "Dead",				localFunc = "localOnEnemyHelicopterDead" },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		TppMarkerSystem.DisableMarker{ markerId = "marker_e20070_heliport", viewType = { "VIEW_MAP_GOAL", "VIEW_WORLD_GOAL" } }

		
		TppRadio.DelayPlay( "Radio_Reinforcements3", "mid", nil, {
			onStart = function()

				
				TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_02' )

			end,
			onEnd = function()

				
				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then

						
						luaData:SetCurrentMissionSubGoalNo( 3 )

						
						local hudCommonData = HudCommonDataManager.GetInstance()
						if hudCommonData ~= nil then
							hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )
						end

					end
				end

			end } )				
		this.SetIntelRadio()									
		TppRadio.RegisterOptionalRadio( "OptionalRadio_030" )	

		
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ENEMY_HELICOPTER, true )	
		TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ENEMY_IN_HELICOPTER, true )	

		GkEventTimerManager.Start( "Timer_WaitRealize", 1 )	

		TppMissionManager.SaveGame( 30 )	

		
		for i, characterId in ipairs( this.reinforcements_1_2_AlienEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, false )	
		end
		TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, this.CHARACTER_ID_ENEMY_IN_HELICOPTER, false )	

	end,

	localOnEnemyHelicopterDead = function()

		if TppEventSequenceManagerCollector.GetMessageArg( 0 ) == this.CHARACTER_ID_ENEMY_HELICOPTER then
			TppMission.SetFlag( "isEnemyHelicopterDead", true )
			TppRadio.DelayPlay( "Radio_TargetClear_Heli", "short" )
			
			GkEventTimerManager.Start( "Timer_ChangeSequence", 5 )
		end

	end,

	localChangeEnemyHelicopterRoute = function()

		TppEnemyUtility.RequestToGetOnHelicopterAndAimTarget( this.CHARACTER_ID_ENEMY_IN_HELICOPTER, this.CHARACTER_ID_ENEMY_HELICOPTER, this.CHARACTER_ID_SUPPORT_HELICOPTER, "RIGHT" )	
		TppSupportHelicopterService.RequestRouteMode( this.CHARACTER_ID_ENEMY_HELICOPTER,"e20070_route_enemyHeli0000", true, 80 )
		TppSupportHelicopterService.OpenRightDoor("EnemyHelicopter")

		GkEventTimerManager.Start( "Timer_WaitEnemyHelicopter", 20 )

	end,

	localChangeEnemyHelicopterCombatRoute = function()

	end,

	localOnEnemyDead = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		if characterId == this.CHARACTER_ID_ENEMY_IN_HELICOPTER then
			
			
			TppSupportHelicopterService.ChangeRoute( this.CHARACTER_ID_ENEMY_HELICOPTER, "e20070_route_enemyHeli0002" )
			
			local heliChara = Ch.FindCharacterObjectByCharacterId( "EnemyHelicopter" )
			TppSoundDaemon.PostEvent3D('sfx_m_e20040_fixed_29', heliChara:GetPosition())

			
			GkEventTimerManager.Start( "Timer_ChangeSequence", 5 )
		end

	end,

	localChangeSequence = function()

		TppSequence.ChangeSequence( "Seq_BattleInHeliport2" )	

	end,

	localOnMessageRoutePoint = function()

		local routeNodeIndex = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		local maxRouteNodeIndex = TppEventSequenceManagerCollector.GetMessageArg( 1 )
		local routeName = TppEventSequenceManagerCollector.GetMessageArg( 2 )

		if routeName == GsRoute.GetRouteId( "e20070_route_enemyHeli0000" ) then
			Fox.Log( "routeName:" .. routeName .. ", routeNodeIndex:" .. routeNodeIndex .. ", maxRouteNodeIndex:" .. maxRouteNodeIndex )
			if routeNodeIndex == maxRouteNodeIndex then

				
				TppEnemyUtility.RequestToFireOnHelicopter( this.CHARACTER_ID_ENEMY_IN_HELICOPTER, this.CHARACTER_ID_ENEMY_HELICOPTER, this.CHARACTER_ID_SUPPORT_HELICOPTER, 180, 2 )

				
				TppSupportHelicopterService.ChangeRoute( this.CHARACTER_ID_ENEMY_HELICOPTER, this.ROUTE_NAME_ENEMY_HELICOPTER )	

			elseif routeNodeIndex == 2 then

				
				TppSupportHelicopterService.SearchLightOn()
				this.commonHeliAimEnemy()

			end
		elseif routeName == GsRoute.GetRouteId( this.ROUTE_NAME_ENEMY_HELICOPTER ) then

			if	routeNodeIndex == 3 or
				routeNodeIndex == 7 or
				routeNodeIndex == 11 or
				routeNodeIndex == 15 or
				routeNodeIndex == 19 then
				TppEnemyUtility.RequestToFireOnHelicopter( this.CHARACTER_ID_ENEMY_IN_HELICOPTER, this.CHARACTER_ID_ENEMY_HELICOPTER, this.CHARACTER_ID_SUPPORT_HELICOPTER, 180, 2 )
			end

		end

	end,

}

this.Seq_BattleInHeliport2 = {

	MissionState = "exec",

	Messages = {
		Enemy = {
			{												message = "EnemyDead",			localFunc = "localOnEnemyDead" },
			{												message = "MessageRoutePoint",	commonFunc = this.commonOnMessageRoutePoint },
		},
		Character = {
			{ data = this.CHARACTER_ID_ENEMY_HELICOPTER,	message = "MessageRoutePoint",	localFunc = "localOnMessageRoutePoint" },
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "Dead",				localFunc = "localOnEnemyHelicopterDead" },
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "NotifyLifeRate",		commonFunc = this.commonOnNotifyLifeRate },
			{ data = this.CP_ID,							message = "Alert",				localFunc = "localOnAlert" },
		},
		Timer = {
			{ data = "Timer_WaitAppearReinforcements",		message = "OnEnd",				localFunc = "localAppearReinforcements" },
			{ data = "Timer_SetAntiAircraftMode",			message = "OnEnd",				commonFunc = this.commonSetAntiAircraftMode },
			{ data = "Timer_ChangeSequence",				message = "OnEnd",				localFunc = "localChangeSequence" },
		},
		Marker = {
			{												message = "ChangeToEnable",		commonFunc = this.commonOnMarkerEnabled },
		},
		Trap = {
			{ data = "Trap_AntiAirGun",						message = "Enter",				commonFunc = this.commonOnEnemyNearAntiAirGun, },
			{ data = "Trap_Heliport3",						message = "Enter",				localFunc = "localOnAlert", },
			{ data = "Trap_Reinforcements2",				message = "Enter",				localFunc = "localChangeSequenceIfSequenceClear" },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		this.commonUnsetAntiAircraftMode()	
		
		local cpRouteSets = {
			{
				cpID = this.CP_ID,
				sets = {
					sneak_night = "e20070_route_reinforcements2",
					caution_night = "e20070_route_reinforcements2",
				},
			},
		}
		TppEnemy.SetRouteSets( cpRouteSets, { forceUpdate = true, forceReload = true, startAtZero = true, warpEnemy = false } )

		
		for i, characterId in ipairs( this.reinforcements_1_2_AlienEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, false )	
		end
		this.commonEnableEnemies( this.reinforcements_2_1_AlienEnemies )			
		for i, characterId in ipairs( this.reinforcements_2_1_AlienEnemies ) do

			local routeName = this.characterIdToRouteMap[ characterId ]
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_reinforcements2", routeName, 0, characterId )	

			if	characterId == "Reinforcements_2_1_AlienEnemy0000" or
				characterId == "Reinforcements_2_1_AlienEnemy0001" or
				characterId == "Reinforcements_2_1_AlienEnemy0002" then

				TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, true )	
				TppEnemyUtility.SetForceRouteMode( characterId, true )					

			end

		end

		
		this.commonHeliAimEnemy()

		
		GkEventTimerManager.Start( "Timer_WaitAppearReinforcements", 10 )	
		

		
		this.SetIntelRadio()										
		TppRadio.RegisterOptionalRadio( "OptionalRadio_030" )		
		local radioName
		if this.commonIsAllAntiAirgunInHelipadBroken() == false then	
			radioName = "Radio_HeliTarget_AntiAirGun"						
		else															
			radioName = "Radio_HeliTarget_NotAntiAirGun"					
		end
		TppRadio.DelayPlay( radioName, "mid", nil, {
			onStart = function()

				
				TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_03' )

			end,
			onEnd = function()

				
				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then
						local hudCommonData = HudCommonDataManager.GetInstance()				
						hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )			
					end
				end

			end } )

		
		TppMarkerSystem.DisableMarker{ markerId = this.CHARACTER_ID_ENEMY_HELICOPTER }

	end,

	localOnEnemyHelicopterDead = function()

		if TppEventSequenceManagerCollector.GetMessageArg( 0 ) == this.CHARACTER_ID_ENEMY_HELICOPTER then
			TppMission.SetFlag( "isEnemyHelicopterDead", true )
			TppRadio.DelayPlay( "Radio_TargetClear_Heli", "short" )
			this.Seq_BattleInHeliport2.localChangeSequenceIfSequenceClear()	
		end

	end,

	localAppearReinforcements = function()

		this.commonHeliAimEnemy()				

	end,

	localChangeSequence = function()

		TppSequence.ChangeSequence( "Seq_BattleInHeliport2_2" )							

	end,

	localChangeSequenceIfSequenceClear = function()

		if	this.commonIsEnemiesDead( this.reinforcements_2_1_AlienEnemies ) == true then

			
			TppSupportHelicopterService.StopSearchLightAutoAim()
			TppSupportHelicopterService.SetSearchLightAngle( 0, 0 )
			TppSupportHelicopterService.ChangeRouteWithNodeIndex( "e20070_route_heli0008" )	

			
			GkEventTimerManager.Start( "Timer_ChangeSequence", 3 )

		end

	end,

	localOnEnemyDead = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )												
		Fox.Log( "characterId:" .. characterId )
		local reinforcementsCharacterId = this.reinforcements2Map[ characterId ]												

		if reinforcementsCharacterId ~= nil then																			

			Fox.Log( "reinforcementsCharacterId:" .. reinforcementsCharacterId )
			TppEnemyUtility.SetEnableCharacterId( reinforcementsCharacterId, true )												

			local routeName = this.characterIdToRouteMap[ reinforcementsCharacterId ]
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_reinforcements2", routeName, 0, reinforcementsCharacterId )

			this.commnoSetEnemyReinforcements( reinforcementsCharacterId )														

		end

		this.commonHeliAimEnemy()

		this.Seq_BattleInHeliport2.localChangeSequenceIfSequenceClear()														

	end,

	localOnAlert = function()

		this.commonSetAntiAircraftMode()
		this.commonStopForceRouteMode( this.reinforcements_2_1_AlienEnemies )

	end,

}

this.Seq_BattleInHeliport2_2 = {

	MissionState = "exec",

	Messages = {
		Enemy = {
			{												message = "EnemyDead",			localFunc = "localOnEnemyDead" },
			{												message = "MessageRoutePoint",	commonFunc = this.commonOnMessageRoutePoint },
		},
		Character = {
			{ data = this.CHARACTER_ID_ENEMY_HELICOPTER,	message = "MessageRoutePoint",	localFunc = "localOnMessageRoutePoint" },
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "Dead",				localFunc = "localOnEnemyHelicopterDead" },
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "NotifyLifeRate",		commonFunc = this.commonOnNotifyLifeRate },
			{ data = this.CP_ID,							message = "Alert",				localFunc = "localOnAlert" },
		},
		Timer = {
			{ data = "Timer_WaitEnemyHelicopterAttack",		message = "OnEnd",				localFunc = "localAppearReinforcements" },
			{ data = "Timer_SetAntiAircraftMode",			message = "OnEnd",				commonFunc = this.commonSetAntiAircraftMode },
		},
		Marker = {
			{												message = "ChangeToEnable",		commonFunc = this.commonOnMarkerEnabled },
		},
		Trap = {
			{ data = "Trap_Reinforcements2",				message = "Enter",				localFunc = "localChangeSequenceIfSequenceClear" },
			{ data = "Trap_Heliport3",						message = "Enter",				localFunc = "localOnAlert", },
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		this.commonUnsetAntiAircraftMode()	

		
		for i, characterId in ipairs( this.reinforcements_2_1_AlienEnemies ) do
			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, false )	
		end
		
		this.commonEnableEnemies( this.reinforcements_2_2_AlienEnemies )			
		for i, characterId in ipairs( this.reinforcements_2_2_AlienEnemies ) do

			local routeName = this.characterIdToRouteMap[ characterId ]
			TppCommandPostObject.GsSetPriorityEnemyForRoute( this.CP_ID, "e20070_route_reinforcements2", routeName, 0, characterId )	

			TppCommandPostObject.GsSetRealizeFirstPriority( this.CP_ID, characterId, true )		
			TppEnemyUtility.SetFlagSendMessageOnReceiveDamage( characterId, true )
			TppEnemyUtility.SetForceRouteMode( characterId, true )								

		end

		
		this.commonHeliAimEnemy()				

		
		if TppMission.GetFlag( "isEnemyHelicopterDead" ) == false then
			TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ENEMY_IN_HELICOPTER2, true )	
			TppEnemyUtility.RequestToGetOnHelicopterAndAimTarget( this.CHARACTER_ID_ENEMY_IN_HELICOPTER2, this.CHARACTER_ID_ENEMY_HELICOPTER, this.CHARACTER_ID_SUPPORT_HELICOPTER, "RIGHT" )	
		end

		
		TppRadio.DelayPlay( "Radio_Reinforcements2", "long", nil, {
			onStart = function()

				
				TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_04' )

			end,
			onEnd = function()

				
				local commonDataManager = UiCommonDataManager.GetInstance()
				if commonDataManager ~= NULL then
					local luaData = commonDataManager:GetUiLuaExportCommonData()
					if luaData ~= NULL then
						local hudCommonData = HudCommonDataManager.GetInstance()				
						hudCommonData:AnnounceLogViewLangId( "announce_enemyIncrease" )			
					end
				end

			end } )

		
		GkEventTimerManager.Start( "Timer_WaitEnemyHelicopterAttack", 10 )

	end,

	
	localOnEnemyHelicopterDead = function()

		if TppEventSequenceManagerCollector.GetMessageArg( 0 ) == this.CHARACTER_ID_ENEMY_HELICOPTER then	

			TppMission.SetFlag( "isEnemyHelicopterDead", true )
			
			TppEnemyUtility.KillEnemy( this.CHARACTER_ID_ENEMY_IN_HELICOPTER2 )
			this.Seq_BattleInHeliport2_2.localChangeSequenceIfSequenceClear()	

		end

	end,

	
	localAppearReinforcements = function()

		
		if TppMission.GetFlag( "isEnemyHelicopterDead" ) == false then
			TppCharacterUtility.SetEnableCharacterId( this.CHARACTER_ID_ENEMY_IN_HELICOPTER2, true )	
			TppEnemyUtility.RequestToGetOnHelicopterAndAimTarget( this.CHARACTER_ID_ENEMY_IN_HELICOPTER2, this.CHARACTER_ID_ENEMY_HELICOPTER, this.CHARACTER_ID_SUPPORT_HELICOPTER, "RIGHT" )	
			TppSupportHelicopterService.ChangeRoute( this.CHARACTER_ID_ENEMY_HELICOPTER, "e20070_route_enemyHeli0003" )

		end

	end,

	
	localOnMessageRoutePoint = function()

		local routeName = TppEventSequenceManagerCollector.GetMessageArg( 2 )
		local routeNodeIndex = TppEventSequenceManagerCollector.GetMessageArg( 0 )
		local maxRouteNodeIndex = TppEventSequenceManagerCollector.GetMessageArg( 1 )

		if routeName == GsRoute.GetRouteId( "e20070_route_enemyHeli0003" ) then
			Fox.Log( "routeName:" .. routeName .. ", routeNodeIndex:" .. routeNodeIndex .. ", maxRouteNodeIndex:" .. maxRouteNodeIndex )
			if routeNodeIndex == maxRouteNodeIndex then

				
				TppSupportHelicopterService.ChangeRoute( this.CHARACTER_ID_ENEMY_HELICOPTER, "e20070_route_enemyHeli0004" )

			elseif routeNodeIndex == 2 then

				
				TppRadio.Play( "RadioReinforcementsHeli2" )

			end
		elseif routeName == GsRoute.GetRouteId( "e20070_route_enemyHeli0004" ) then

			if	routeNodeIndex == 3 or
				routeNodeIndex == 6 or
				routeNodeIndex == 11 or
				routeNodeIndex == 16 or
				routeNodeIndex == 21 then
				TppEnemyUtility.RequestToFireOnHelicopter( this.CHARACTER_ID_ENEMY_IN_HELICOPTER2, this.CHARACTER_ID_ENEMY_HELICOPTER, this.CHARACTER_ID_SUPPORT_HELICOPTER, 180, 2 )
			end

		end

	end,

	
	localChangeSequenceIfSequenceClear = function()

		if	this.commonIsEnemiesDead( this.reinforcements_2_2_AlienEnemies ) == true and	
			TppMission.GetFlag( "isEnemyHelicopterDead" ) == true then

			TppSequence.ChangeSequence( "Seq_PlayerRideHelicopter" )							

		end

	end,

	
	localOnEnemyDead = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 0 )	

		if characterId == this.CHARACTER_ID_ENEMY_IN_HELICOPTER2 then
			
		end

		if TppMission.GetFlag( "isEnemyHelicopterDead" ) == true then
			this.commonHeliAimEnemy()											
		end
		this.Seq_BattleInHeliport2_2.localChangeSequenceIfSequenceClear()		

	end,

	localOnAlert = function()

		this.commonSetAntiAircraftMode()
		this.commonStopForceRouteMode( this.reinforcements_2_2_AlienEnemies )

	end,

}

this.Seq_PlayerRideHelicopter = {

	MissionState = "exec",

	Messages = {
		Character = {
			{ data = "Player",	message = "RideHelicopter",	localFunc = "localOnPlayerRideHelicopter", },	
		},
		Gimmick = {
			
			{ data = "gntn_area01_antiAirGun_001",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_002",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
			{ data = "gntn_area01_antiAirGun_003",			message = "AntiAircraftGunBroken",			commonFunc = this.commonOnAntiAirgunBroken },
		},
	},

	OnEnter = function()

		
		
		TppSupportHelicopterService.ChangeRoute( this.CHARACTER_ID_SUPPORT_HELICOPTER, "e20070_route_heli0002" )	
		TppSupportHelicopterService.SetPossibleGettingOn( this.CHARACTER_ID_SUPPORT_HELICOPTER, true )
		TppSupportHelicopterService.StopSearchLightAutoAim()
		TppSupportHelicopterService.SetSearchLightAngle( 0, 0 )

		TppMission.SetFlag( "isAllTargetKlled", true )	
		TppRadio.DelayPlay( "Radio_ClearReinrcements", "mid", "begin", {
			onStart = function()
				TppMusicManager.PostSceneSwitchEvent( 'Set_Switch_bgm_e20070_btt_escape' )
			end,
			onEnd = function()
				TppRadio.DelayPlay( "Radio_ClearReinrcements2", nil, "none", {
					onEnd = function()
						TppRadio.DelayPlay( "Radio_ClearReinrcements3", "short", "end" )
					end } )
			end } )	

		this.SetIntelRadio()										
		TppRadio.RegisterOptionalRadio( "OptionalRadio_040" )		

		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager ~= NULL then
			local luaData = commonDataManager:GetUiLuaExportCommonData()
			if luaData ~= NULL then

				
				luaData:SetCurrentMissionSubGoalNo( 4 )

				
				local hudCommonData = HudCommonDataManager.GetInstance()				
				hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )	
				hudCommonData:AnnounceLogViewLangId( "announce_mission_goal" )		

			end
		end


	end,

	
	localOnPlayerRideHelicopter = function()

		TppSupportHelicopterService.ChangeRoute( this.CHARACTER_ID_SUPPORT_HELICOPTER, "ReturnRoute_HeliPort0000" )	
		TppSequence.ChangeSequence( "Seq_HelicopterMove" )							

	end

}

this.Seq_HelicopterMove = {

	MissionState = "exec",

	Messages = {
		Character = {
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "CloseDoor",	localFunc = "localOnHelicopterDoorClosed" },
		},
	},

	OnEnter = function()

		
		GZCommon.ScoreRankTableSetup( this.missionID )

	end,

	OnLeave = function()

		TppEnemyUtility.IgnoreCpRadioCall( true )
		TppEnemyUtility.StopAllCpRadio( 1.0 )

	end,

	localOnHelicopterDoorClosed = function()

		TppMusicManager.PlaySceneMusic( "Stop_bgm_e20070_scene_btt" )

	end,

}


this.Seq_MissionClearShowTransition = {

	MissionState = "clear",

	Messages = {
		UI = {
			
			{ message = "EndMissionTelopFadeIn" ,		localFunc = "OnFinishClearFade" },
			{ message = "EndMissionTelopRadioStop" ,	commonFunc = function()
															Fox.Log( "PlatformConfiguration.SetVideoRecordingEnabled(false)" )
															PlatformConfiguration.SetVideoRecordingEnabled(false) 
														end },
		},
	},

	
	OnFinishClearFade = function()

		
		TppSoundDaemon.SetMute( 'Result' )
		

		
		local Rank = PlayRecord.GetRank()
		if( Rank == 0 ) then
			Fox.Warning( "Seq_MissionClearShowTransition:Mission not yet clear!!" )
		elseif( Rank == 1 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20070_ed_s" )
		elseif( Rank == 2 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20070_ed_ab" )
		elseif( Rank == 3 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20070_ed_ab" )
		elseif( Rank == 4 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20070_ed_cd" )
		elseif( Rank == 5 ) then
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20070_ed_cd" )
		else
			TppMusicManager.PostJingleEvent( "MissionEnd", "Play_bgm_e20070_ed_e" )
		end

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		
		local rank = PlayRecord.GetRank()
		if rank == 0 then								
			TppRadio.Play( "Radio_GameClear_Bad",
				{ onStart = function()	end } )
		elseif rank == 1 then							
			TppRadio.Play( "Radio_GameClear_Great",
				{ onStart = function()	end } )
			Trophy.TrophyUnlock( 4 )						
		elseif rank == 2 then							
			TppRadio.Play( "Radio_GameClear_VeryGood",
				{ onStart = function()	end } )
		elseif rank == 3 then							
			TppRadio.Play( "Radio_GameClear_Good",
				{ onStart = function()	end } )
		elseif rank == 4 then							
			TppRadio.Play( "Radio_GameClear_Normal",
				{ onStart = function()	end } )
		elseif rank == 5 then							
			TppRadio.Play( "Radio_GameClear_Bad",
				{ onStart = function()	end } )
		elseif rank == 6 then							
			TppRadio.Play( "Radio_GameClear_Bad",
				{ onStart = function()	end } )
		end

		if TppMission.GetFlag( "alertOnce" ) == false then
				Trophy.TrophyUnlock( 11 )					
		end

	end,

	OnEnter = function()

		TppRadioConditionManagerAccessor.Unregister( "Tutorial" )	 
		TppRadioConditionManagerAccessor.Unregister( "Basic" )

		local TelopEnd = {
			onEnd = function()
				TppSequence.ChangeSequence( "Seq_MissionClear" )
			end,
		}
		TppUI.ShowTransitionWithFadeOut( "ending", TelopEnd, 2 )

	end,

}

this.Seq_MissionClear = {

	MissionState = "clear",

	OnEnter = function()

		Fox.Log("set share : false")
		PlatformConfiguration.SetShareScreenEnabled(false) 

		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )

		TppMusicManager.PostJingleEvent( 'SingleShot', 'Set_Switch_bgm_gntn_ed_default_lp' )

		
		TppRadio.Play( "Radio_AfterGameClear", {
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

this.Seq_ShowClearReward = {

	MissionState = "clear",

	Messages = {
		UI = {
			
			{	message = "BonusPopupAllClose",	commonFunc = function() TppSequence.ChangeSequence( "Seq_MissionEnd" ) end },
		},
	},

	OnEnter = function()

		Fox.Log("set share : true")
		PlatformConfiguration.SetShareScreenEnabled(true) 

		this.OnShowRewardPopupWindow()

	end,
}


this.Seq_MissionFailed = {

	MissionState = "failed",

	OnEnter = function()

		TppSequence.ChangeSequence( "Seq_MissionGameOver" )
	end,

}

this.Seq_MissionFailed_HelicopterDeadNotPlayerOn = {

	MissionState = "failed",

	Messages = {
		Character = {
			{ data = this.CHARACTER_ID_SUPPORT_HELICOPTER,	message = "Dead",	localFunc = "localChangeSequence" },
		},
	},

	OnEnter = function()

		GZCommon.PlayCameraOnCommonHelicopterGameOver()

	end,

	localChangeSequence = function()

		local characterId = TppEventSequenceManagerCollector.GetMessageArg( 1 )
		if characterId == "Player" then
			this.CounterList.GameOverRadioName = "Radio_GameOver_PlayerDestroyHeli"
		else
			this.CounterList.GameOverRadioName = "Radio_GameOver_HelicopterDeadNotPlayerOn"
		end
		TppSequence.ChangeSequence( "Seq_MissionGameOver" )

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

		Fox.Log("----------------Seq_MissionFailed:OnFinishMissionFailedProduction----------------")

		TppSequence.ChangeSequence( "Seq_MissionGameOver" )								

	end,


	OnEnter = function( manager )
		Fox.Log("----------------Seq_MissionFailed:OnEnter----------------")

		this.CounterList.GameOverRadioName = "Radio_GameOver_MissionArea"

		
		TppTimer.Start( "MissionFailedProductionTimer", this.CounterList.GameOverFadeTime )

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

		if this.CounterList.GameOverRadioName ~= "NoRadio" then
			SubtitlesCommand.SetIsEnabledUiPrioStrong( true )
			TppRadio.DelayPlay( this.CounterList.GameOverRadioName, nil, "none" )
		end

	end,

	OnEnter = function()

	end,
}


this.Seq_MissionEnd = {

	OnEnter = function()

		this.commonMissionCleanUp()												
		TppMusicManager.PostJingleEvent( "SingleShot", "Stop_bgm_e20070_ed" )	
		TppMissionManager.SaveGame()											
		TppMission.ChangeState( "end" )

		Fox.Log( "PlatformConfiguration.SetVideoRecordingEnabled(true)" )
		PlatformConfiguration.SetVideoRecordingEnabled(true)					

	end,
}




return this
