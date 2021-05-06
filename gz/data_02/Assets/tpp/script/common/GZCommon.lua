local this = {}




this.RequiredFiles = {
	"/Assets/tpp/script/common/TppClock.lua",
	"/Assets/tpp/script/common/TppData.lua",
	"/Assets/tpp/script/common/TppDemo.lua",
	"/Assets/tpp/script/common/TppEffect.lua",
	"/Assets/tpp/script/common/TppEnemy.lua",
	"/Assets/tpp/script/common/TppGimmick.lua",
	"/Assets/tpp/script/common/TppHelicopter.lua",
	"/Assets/tpp/script/common/TppLocation.lua",
	"/Assets/tpp/script/common/TppMarker.lua",
	"/Assets/tpp/script/common/TppMission.lua",
	"/Assets/tpp/script/common/TppPlayer.lua",
	"/Assets/tpp/script/common/TppRadio.lua",
	"/Assets/tpp/script/common/TppSequence.lua",
	"/Assets/tpp/script/common/TppSound.lua",
	"/Assets/tpp/script/common/TppStaticModel.lua",
	"/Assets/tpp/script/common/TppTimer.lua",
	"/Assets/tpp/script/common/TppUI.lua",
	"/Assets/tpp/script/common/TppUtility.lua",
	"/Assets/tpp/script/common/TppWeather.lua",
}


this.Register = function( script, manager, type )
	type = type or "mission"

	
	TppSequence.Register( script, manager, type )

	
	if( type == "location" ) then
		TppLocation.Register( script )

	
	elseif( type == "mission" ) then
		TppDemo.Register( script.DemoList )
		TppMission.Register( script.missionID, script.MissionFlagList )
		TppRadio.Register( script.RadioList, script.OptionalRadioList, script.IntelRadioList )

		
		TppDemo.Start()
		TppMission.Start()
		TppRadio.Start()
		TppSound.Start()
		TppUI.Start()
	end
end

this.RequiredFiles = {
	"/Assets/tpp/script/common/GZWeapon.lua",
}






this.FadeOutTime_MissionFailed	= 1.4


this.FadeOutTime_PlayerFallDead	= 0.03


this.FadeOutTime_MissionClear	= 1.6


this.WaitTime_HeliTakeOff	= 10


this.Time_HintPhotoCheck	= (60*2)





this.VehicleSpeed_OutsideArea = 50


this.VehicleWarpPos_OutsideAreaWest = { -297.319, 28.672, 172.444 }
this.VehicleWarpAngle_OutsideAreaWest = -135.0


this.VehicleWarpPos_OutsideAreaNorth = { 33.611, 30.831, 45.635 }
this.VehicleWarpAngle_OutsideAreaNorth = 150.0


this.PlayerMovePos_OutsideAreaWest = Vector3(-326.115, 28.693, 143.885)


this.PlayerMovePos_OutsideAreaNorth = Vector3(51.198, 30.795, 14.387)


this.OutsideAreaCamOffSetPos_LightVehicle = { 1.7, 1.2, 20 }


this.OutsideAreaCamOffSetPos_Truck = { 2.8, 2.0, 20 }


this.OutsideAreaCamOffSetPos_MgWav = { 3.9, 2.5, 23 }


this.OutsideAreaCamOffSetPos_Human = { 2, 0.8, 5 }


this.isOutOfMissionEffectEnable = true


this.isPlayerWarningMissionArea = false




this.PlayerAreaName = "WareHouse"	


this.PlayerOnVehicle = "NoRide"


this.PlayerOnCargo = "NoRide"


this.BigGateVehicleData = {}


this.BigGateCallRadioName = "CPRGZ0020"


this.BigGateOpenTimer = (5)


this.BigGateOpenFlag = false


this.BigGateOpenToRouteTimer = (1)


this.Time_CpRadioFadeOutStart = (5.0)

this.Time_CpRadioFadeOut = (15.0)


this.EnemyAntiAirActCheck = false


this.PlayerEscapeOnHeli = false


this.ChicoPazDeadRideOnHelicopter = false


this.CamOffSetPos_Paz = { 0, -0.5, -3.0 }


this.UniqueCharacterId_AnnounceLog = {}

this.DefaultAmmoCountOnContinueMission	= {
	{ "WP_ar00_v00", 150 },
	{ "WP_ar00_v01", 150 },
	{ "WP_ar00_v03", 150 },
	{ "WP_ar00_v03b", 150 },
	{ "WP_ar00_v05", 150 },
	{ "WP_hg00_v01", 21 },
	{ "WP_hg01_v00", 14 },
	{ "WP_hg02_v00", 15 },
	{ "WP_sg01_v00", 30 },
	{ "WP_sm00_v00", 150 },
	{ "WP_sr01_v00", 10 },
	{ "WP_ms02", 3 },
	{ "WP_Grenade", 2 },
	{ "WP_SmokeGrenade", 2 },
	{ "WP_WarningFlare", 2 },
	{ "WP_C4", 3 },
	{ "WP_Claymore", 3 },
}


this.LastVehicleGroupInfo_routeInfoName = ""
this.LastVehicleGroupInfo_vehicleRouteId = ""
this.LastVehicleGroupInfo_passedNodeIndex = 0
this.LastVehicleGroupInfo_memberCharacterIds = nil
this.LastVehicleGroupInfo_vehicleCharacterId = ""







this.MissionPrepare = function()

	

end


this.MissionSetup = function()

	
	this.StopSirenForcibly()

	
	TppOutOfMissionRangeEffect.Disable( 0 )

	
	this.Common_CenterBigGateVehicleInit()

	
	this.PlayerOnVehicle = "NoRide"
	this.PlayerOnCargo = "NoRide"

	
	this.UniqueCharacterId_AnnounceLog = {}

	
	TppEnemyUtility.ResetCpRadioManager()

	
	this.EnemyAntiAirActCheck = false

	
	this.PlayerEscapeOnHeli = false

	
	
	if ( TppGadgetManager.GetGadgetStatus("gntn_BigGateSwitch") == 1 ) then
		this.BigGateOpenFlag = true
		TppGadgetUtility.SetSwitch("gntn_BigGateSwitch","lock")
		TppGadgetUtility.SetDoor{ id = "gntn_BigGate", isVisible = true, isOpen = true }
	else
		this.BigGateOpenFlag = false
		TppGadgetUtility.SetSwitch("gntn_BigGateSwitch","unlock")
		TppGadgetUtility.SetDoor{ id = "gntn_BigGate", isVisible = true, isOpen = false }
	end

	



	TppPlayerUtility.SetAmmoCountOnContinueMission( this.DefaultAmmoCountOnContinueMission )
end


this.MissionCleanup = function()

	
	this.StopSirenForcibly()

	
	TppTimer.StopAll()

	
	SubtitlesCommand.SetIsEnabledUiPrioStrong( false )

	
	
	
	
	
	

	
	TppOutOfMissionRangeEffect.Disable( 0 )

	
	this.isOutOfMissionEffectEnable = true

	
	this.Common_CenterBigGateVehicleInit()

	


	
	this.ChicoPazDeadRideOnHelicopter = false

	
	this.PlayerOnVehicle = "NoRide"
	this.PlayerOnCargo = "NoRide"

	
	this.isPlayerWarningMissionArea = false

	
	this.UniqueCharacterId_AnnounceLog = {}

	
	TppEnemyUtility.ResetCpRadioManager()

	
	this.EnemyAntiAirActCheck = false

	
	this.PlayerEscapeOnHeli = false

	
	this.StopHeliEscapeBGM()

	
	TppDataUtility.DestroyEffectFromGroupId( "dstcomviw" )

end


this.ShowCommonAnnounceLog = function( LangId )

	if LangId == nil then return end





	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( LangId )
end





this.OutsideAreaVoiceStart = function()




	
	if ( this.isPlayerWarningMissionArea ) then
		
		local commonDataManager = UiCommonDataManager.GetInstance()
		if commonDataManager == NULL then return end

		local luaData = commonDataManager:GetUiLuaExportCommonData()
		if luaData == NULL then return end

		luaData:RequestMbSoundControllerVoice( "VOICE_WARN_MISSION_AREA", true, 1.0 ) 
	end
end




this.OutsideAreaVoiceEnd = function()




	
	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then return end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then return end

	luaData:RequestMbSoundControllerVoice( "VOICE_WARN_MISSION_AREA", false ) 
end




this.OutsideAreaEffectEnable = function()





	
	if ( TppMission.GetMissionID() ~= 20040 ) then
		
		if( this.isOutOfMissionEffectEnable == true ) then
			TppOutOfMissionRangeEffect.Enable( 2.0 )

			
			TppTimer.Start( "Timer_OutSideAreaVoiceStart", 1 )

			
			
			if ( TppMission.GetMissionID() ~= 20020 ) then
				
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:AnnounceLogViewLangId( "announce_mission_area_warning" )
				TppSoundDaemon.PostEvent( "sfx_s_terminal_data_fix" )	
			end
		end
	end
end



this.OutsideAreaEffectDisable = function()





	TppOutOfMissionRangeEffect.Disable( 1.0 )

	this.OutsideAreaVoiceEnd()		

end




this.OutsideAreaCamera = function()

	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
	this.PlayerOnVehicle = TppPlayerUtility.GetRidingVehicleCharacterId()





	
	if ( VehicleId ~= "" ) then		
		
		if ( VehicleId == "SupportHelicopter" ) then



		else
			
			this.OutsideAreaCamera_Vehicle( VehicleId, "Player" )	
		end
	else
		if ( this.PlayerOnCargo ~= "NoRide" ) then
			
			this.OutsideAreaCamera_Vehicle( this.PlayerOnCargo, "Player" )	
		else
			
			this.OutsideAreaCamera_Human( "Player" )
		end

	end
end



this.OutsideAreaCamera_Vehicle = function( VehicleId, CharaId, options )



	local Pos
	local Angle
	local VehicleType
	local charaId = CharaId or nil

	
	if ( options ) then
		
		if ( options == "North" ) then
			Pos =	this.VehicleWarpPos_OutsideAreaNorth
			Angle =	this.VehicleWarpAngle_OutsideAreaNorth
		elseif ( options == "West" ) then
			Pos =	this.VehicleWarpPos_OutsideAreaWest
			Angle =	this.VehicleWarpAngle_OutsideAreaWest
		else
			



		end
	
	else
		
		if ( this.PlayerAreaName == "Heliport" ) then
			Pos =	this.VehicleWarpPos_OutsideAreaNorth
			Angle =	this.VehicleWarpAngle_OutsideAreaNorth
		elseif ( this.PlayerAreaName == "WestCamp" ) then
			Pos =	this.VehicleWarpPos_OutsideAreaWest
			Angle =	this.VehicleWarpAngle_OutsideAreaWest
		else
			



		end
	end
	
	this.OutsideAreaGameRealizeCharacter( VehicleId, CharaId, options, true )
	
	this.OutsideAreaEffectDisable()
	
	if ( this.isOutOfMissionEffectEnable == true ) then
		
		TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_gntn_jingle_area_failed" )
	else
		
		TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_gntn_jingle_area_clear" )
	end
	
	VehicleType = TppVehicleUtility.GetVehicleType( VehicleId )



	if ( charaId == "Player" ) then
		
		this.ForceMove_Vehicle( VehicleId, Pos, Angle )
	end
	
	
	if( VehicleType == 2 ) then
		this.PlayCameraOnCommonCharacterOutsideArea( charaId, this.OutsideAreaCamOffSetPos_LightVehicle )
	
	elseif( VehicleType == 3 ) then
		this.PlayCameraOnCommonCharacterOutsideArea( charaId, this.OutsideAreaCamOffSetPos_Truck )
	
	elseif( VehicleType == 5 ) then
		this.PlayCameraOnCommonCharacterOutsideArea( charaId, this.OutsideAreaCamOffSetPos_MgWav )
	else
		



	end

	
	if ( this.PlayerAreaName == "WestCamp" ) then
		
		TppTimer.Start( "Timer_OutSideAreaWestVehicleTurn", 4.5 )
	end
end



this.ForceMove_Vehicle = function( VehicleId, Pos, Angle )





	
	local vehicleObject = Ch.FindCharacterObjectByCharacterId( VehicleId )
	local vehicleCharacter = vehicleObject:GetCharacter()

	
	local plgBasicAction = vehicleCharacter:FindPluginByName( "TppStrykerBasicAction" )

	
	plgBasicAction:WarpToPosition( Vector3( Pos ), Angle )

	
	plgBasicAction:QuickAccelerate( this.VehicleSpeed_OutsideArea, Angle )

	
	vehicleObject:SetDrivingInput( 0.0, 1.0, 0.0 ) 

end




this.OutsideAreaCamera_Human = function( CharacterId, Options )





	local Pos
	local options = Options or nil

	if( CharacterId == "Player" ) then
		
		if ( this.PlayerAreaName == "Heliport" ) then
			Pos = this.PlayerMovePos_OutsideAreaNorth
		elseif ( this.PlayerAreaName == "WestCamp" ) then
			Pos = this.PlayerMovePos_OutsideAreaWest
		else
			



		end
	end

	
	this.OutsideAreaGameRealizeCharacter( "NoVehicle", CharacterId, options, false )

	
	this.OutsideAreaEffectDisable()

	
	if ( this.isOutOfMissionEffectEnable == true ) then
		
		TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_gntn_jingle_area_failed" )

	else
		
		TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_gntn_jingle_area_clear" )
	end

	if( CharacterId == "Player" ) then
		
		TppPlayerUtility.RequestToStartTransition{ stance="Stand", position=Pos, direction=0, doKeep=true, run=true }
	else
		
	end

	
	this.PlayCameraOnCommonCharacterOutsideArea( CharacterId, this.OutsideAreaCamOffSetPos_Human )

end




this.OutsideAreaGameRealizeCharacter = function( VehicleID, CharaId, Options, EnemyDisable )



	local pos			= Vector3( 0, 0, 0 )					
	local size			= Vector3( 0, 0, 0 )					
	local rot			= Quat( 0.0, 0.0, 0.0, 0.0 )			
	local options		= Options or nil
	local charaId		= CharaId or nil
	local npcIds		= 0
	local vehicleIds	= 0
	local characterID
	local status
	local enemytype
	local npctype
	
	if ( options ) then
		
		if( options == "North" ) then
			pos		= Vector3( 40, 30, 36 )
			size	= Vector3( 33, 14, 130 )
			rot		= Quat( 0.0, -0.3, 0.0, 0.8 )
		elseif( options == "West" ) then
			pos		= Vector3( -290, 30, 180 )
			size	= Vector3( 33, 14, 130 )
			rot		= Quat( 0.0, 0.4, 0.0, 0.8 )
		else
			return
		end
	
	else
		
		if( this.PlayerAreaName == "Heliport" ) then
			pos		= Vector3( 40, 30, 36 )
			size	= Vector3( 33, 14, 130 )
			rot		= Quat( 0.0, -0.3, 0.0, 0.8 )
		elseif( this.PlayerAreaName == "WestCamp" ) then
			pos		= Vector3( -290, 30, 180 )
			size	= Vector3( 33, 14, 130 )
			rot		= Quat( 0.0, 0.4, 0.0, 0.8 )
		else
			return
		end
	end

	
	if( CharacterId == "Player" or EnemyDisable == true ) then
		
		npcIds = TppNpcUtility.GetNpcByBoxShape( pos, size, rot )
		
		if( npcIds and #npcIds.array > 0 ) then
			for i,id in ipairs( npcIds.array ) do
				npctype = TppNpcUtility.GetNpcType( id )



				if( npctype == "Enemy" ) then
					status = TppEnemyUtility.GetStatus( id )



					if( status ~= "RideVehicle" and status ~= "Carried" ) then
						characterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )



						TppEnemyUtility.SetEnableCharacterId( characterID, false )
					end
				elseif( npctype == "Hostage" ) then
					status = TppHostageUtility.GetStatus( id )
					if( status ~= "RideOnVehicle" and status ~= "Carried" ) then
						characterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )



						TppEnemyUtility.SetEnableCharacterId( characterID, false )
					end
				end
			end
		end
	end

	
	vehicleIds = TppVehicleUtility.GetVehicleByBoxShape( pos, size, rot )

	
	if( vehicleIds and #vehicleIds.array > 0 ) then
		for i,id in ipairs( vehicleIds.array ) do
			characterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )



			if( characterID ~= VehicleID ) then
				



				TppData.Disable( characterID )
			end
		end
	end

end






this.PlayerRideOnVehicle = function()

	local Type = TppData.GetArgument(2)

	
	this.PlayerOnVehicle = TppData.GetArgument(1)




end


this.PlayerGetOffVehicle = function()

	this.PlayerOnVehicle = "NoRide"




end



this.PlayerRideOnCargo = function()

	local Type = TppData.GetArgument(2)

	if ( Type == "Truck" ) then
		
		this.PlayerOnCargo = TppData.GetArgument(1)



	end
end


this.PlayerGetOffCargo = function()

	this.PlayerOnCargo = "NoRide"




end





this.SupporHeliLandingZone = function()



	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_heli_arrive_LZ" )
end


this.OnStartMotherBaseDevise = function()
	local arg1 = TppData.GetArgument(1)



	TppSupportHelicopterService.CallSupportHelicopter(arg1)

end


this.OnStartWarningFlare = function()





	local arg1 = TppData.GetArgument(1)
	local arg2 = TppData.GetArgument(2)

	
	if ( arg2 ) then
		
		TppSupportHelicopterService.CallSupportHelicopter(arg1)
		TppSupportHelicopterService.RequestAirStrike()
	end
end


this.SupporHeliCloseDoor = function()



	local isPlayer = TppData.GetArgument(2)

	if ( isPlayer ) then
		
		TppEnemyUtility.StopAllCpRadio( 1.0 )	

		
		this.StopHeliEscapeBGM()

		
		TppMusicManager.StopMusicPlayer( 3000 )
	end
end



this.SupporHeliDeparture = function()

	local isPlayer = TppData.GetArgument(3)

	if ( isPlayer ) then



		
		TppTimer.Start( "Timer_CpRadioFadeStart", this.Time_CpRadioFadeOutStart )

		
		this.PlayerEscapeOnHeli = true

		
		if ( this.EnemyAntiAirActCheck == true ) then
			this.CallHeliEscapeBGM()
		end
	end
end






this.EnemyInterrogation = function()



	
	
	local Type = TppData.GetArgument(3)
	
	if ( Type == 2 or Type == 1 ) then
		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:AnnounceLogViewLangId( "announce_map_update" )
		
		TppSoundDaemon.PostEvent( "sfx_s_terminal_data_fix" )
	end
end



this.EnemyLaidonHeliNoAnnounceSet = function( CharacterID )



	this.UniqueCharacterId_AnnounceLog[ #(this.UniqueCharacterId_AnnounceLog) + 1 ] = CharacterID
end



this.CheckEnemyLaidonHeliNoAnnounce = function( CharacterID )



	for i, value in pairs( this.UniqueCharacterId_AnnounceLog ) do
		if( value == CharacterID ) then
			return true
		end
	end
	return false
end



this.EnemyLaidonVehicle = function()



	local EnemyCharacterID		= TppData.GetArgument(1)
	local VehicleCharacterID	= TppData.GetArgument(3)
	local EnemyLife				= TppEnemyUtility.GetLifeStatus( EnemyCharacterID )
	if ( EnemyLife ~= "Dead" ) then
		
		if( VehicleCharacterID == "SupportHelicopter" ) then
			
			if( this.CheckEnemyLaidonHeliNoAnnounce( EnemyCharacterID ) == false ) then
				
				local hudCommonData = HudCommonDataManager.GetInstance()
				hudCommonData:AnnounceLogViewLangId( "announce_collection_enemy" )
				
				PlayRecord.RegistPlayRecord( "SOLDIER_RESCUE" )
			end
		end
	end
end



this.CpRadioFadeOut = function( CharacterID )



	
	TppEnemyUtility.StopAllCpRadio( this.Time_CpRadioFadeOut )	
	
	TppTimer.Start( "Timer_CpRadioFadeOutEnd", this.Time_CpRadioFadeOut )
end



this.ChangeAntiAir = function()





	local Flag		= TppData.GetArgument(2)

	if ( Flag == true) then
		
		this.EnemyAntiAirActCheck = true

		
		if ( this.PlayerEscapeOnHeli == true ) then
			this.CallHeliEscapeBGM()
		end
	elseif ( Flag == false ) then
		
		this.EnemyAntiAirActCheck = false
	else



	end
end







this.NormalHostageRecovery = function( HostageCharacterID )



	
	local HostageStatus = TppHostageUtility.GetStatus( HostageCharacterID )
	
	if ( HostageStatus ~= "Dead" ) then
		
		local hudCommonData = HudCommonDataManager.GetInstance()
		hudCommonData:AnnounceLogViewLangId( "announce_collection_hostage" )
		
		PlayRecord.RegistPlayRecord( "HOSTAGE_RESCUE", HostageCharacterID )
	end
end



this.CallMonologueHostage = function( CharacterID, HostageVoiceType, DataIdentifierName, OffTrapName )



	local VoiceID
	
	if( TppPlayerUtility.IsCarriedCharacter( CharacterID )) then
		local obj = Ch.FindCharacterObjectByCharacterId( CharacterID )
		if not Entity.IsNull(obj) then
			
			if( HostageVoiceType == "hostage_a" ) then
				VoiceID = "POW_CD_0010"
			elseif( HostageVoiceType == "hostage_b" ) then
				VoiceID = "POW_CD_0020"
			elseif( HostageVoiceType == "hostage_c" ) then
				VoiceID = "POW_CD_0030_01"
			elseif( HostageVoiceType == "hostage_d" ) then
				VoiceID = "POW_CD_0040"
			else



				return
			end
			TppEnemyUtility.CallCharacterMonologue( VoiceID , 3, obj, true )
			TppDataUtility.SetEnableDataFromIdentifier( DataIdentifierName, OffTrapName, false, false )
		end
	end
end






local onEnterPlayerAreaTrap = function()
	local trapName = TppEventSequenceManagerCollector.GetMessageArg( 3 )

	
	
	

	this.PlayerAreaName = trapName	




end

local Fence_SE = function()
	local position = Vector3( 81.01846 , 17.24862 , 225.3844 )
	TppSoundDaemon.PostEvent3D( 'Play_sfx_P_Fs_FENCA_Rn_Grd_L', position )
end



this.Common_CenterBigGate_Open = function()




	local gateObj = Ch.FindCharacterObjectByCharacterId( "gntn_BigGate" )
	local gateChara = gateObj:GetCharacter()

	gateChara:SendMessage( TppGadgetStartActionRequest() )

	
	TppGadgetUtility.SetSwitch("gntn_BigGateSwitch", true)

	TppGadgetUtility.SetSwitch("gntn_BigGateSwitch","lock")

	
	this.BigGateOpenFlag = true
end



this.Common_CenterBigGate_Close = function()




	local gateObj = Ch.FindCharacterObjectByCharacterId( "gntn_BigGate" )
	local gateChara = gateObj:GetCharacter()

	gateChara:SendMessage( TppGadgetUnsetOwnerRequest() )
	gateChara:SendMessage( TppGadgetEndActionRequest() )

	TppGadgetUtility.SetSwitch("gntn_BigGateSwitch","unlock")

	
	TppGadgetUtility.SetSwitch("gntn_BigGateSwitch", false)

	
	this.BigGateOpenFlag = false
end


this.Common_CenterBigGateVehicleInit = function( )



	this.BigGateVehicleData["Init"]						= false
	this.BigGateVehicleData["Cpid"]						= 0
	this.BigGateVehicleData["VehicleRouteInfoName"]		= 0
	this.BigGateVehicleData["VehicleID"]				= 0
	this.BigGateVehicleData["VehicleRouteName01"]		= 0
	this.BigGateVehicleData["VehicleRouteName02"]		= 0
	this.BigGateVehicleData["VehicleRouteNodeIndex01"]	= 0
	this.BigGateVehicleData["VehicleRouteNodeIndex02"]	= 0
end



this.Common_CenterBigGateVehicleSetup = function( CpId, VehicleRouteInfoName, VehicleRouteName01, VehicleRouteName02, VehicleRouteNodeIndex01, VehicleRouteNodeIndex02 )



	this.BigGateVehicleData["Init"]						= true							
	this.BigGateVehicleData["Cpid"]						= CpId							
	this.BigGateVehicleData["VehicleRouteInfoName"]		= VehicleRouteInfoName			
	this.BigGateVehicleData["VehicleID"]				= 0								
	this.BigGateVehicleData["VehicleRouteName01"]		= VehicleRouteName01			
	this.BigGateVehicleData["VehicleRouteName02"]		= VehicleRouteName02			
	this.BigGateVehicleData["VehicleRouteNodeIndex01"]	= VehicleRouteNodeIndex01		
	this.BigGateVehicleData["VehicleRouteNodeIndex02"]	= VehicleRouteNodeIndex02		
end



this.Common_CenterBigGateVehicle = function()

	local	VehicleGroupInfo	= TppData.GetArgument(2)

	
	
	
	
	if not Entity.IsNull(VehicleGroupInfo.memberCharacterIds) then
		this.LastVehicleGroupInfo_routeInfoName 	 = VehicleGroupInfo.routeInfoName
		this.LastVehicleGroupInfo_vehicleRouteId	 = VehicleGroupInfo.vehicleRouteId
		this.LastVehicleGroupInfo_passedNodeIndex	 = VehicleGroupInfo.passedNodeIndex
		this.LastVehicleGroupInfo_memberCharacterIds = VehicleGroupInfo.memberCharacterIds
		this.LastVehicleGroupInfo_vehicleCharacterId = VehicleGroupInfo.vehicleCharacterId



	else



	end

	
	if( this.BigGateVehicleData["Init"] == true ) then
		
		if( this.LastVehicleGroupInfo_routeInfoName	== this.BigGateVehicleData["VehicleRouteInfoName"] ) then
			
			if( this.LastVehicleGroupInfo_vehicleRouteId == GsRoute.GetRouteId( this.BigGateVehicleData["VehicleRouteName01"] ) ) then
				
				if( this.LastVehicleGroupInfo_passedNodeIndex == this.BigGateVehicleData["VehicleRouteNodeIndex01"] ) then
					
					if( this.BigGateOpenFlag == false ) then
						if( this.BigGateVehicleData["Cpid"] ~= 0 ) then
							local phase = TppCharacterUtility.GetCpPhaseName( this.BigGateVehicleData["Cpid"] )



							
							if( phase == "Sneak" ) then
								
								TppEnemyUtility.CallRadioFromEnemyToCp( this.BigGateCallRadioName, 1, this.LastVehicleGroupInfo_memberCharacterIds[1], this.BigGateVehicleData["Cpid"] )
								
								this.BigGateVehicleData["VehicleID"] = this.LastVehicleGroupInfo_vehicleCharacterId
							
							else
								
								this.Common_CenterBigGate_Open()
								
								this.BigGateVehicleData["VehicleID"] = this.LastVehicleGroupInfo_vehicleCharacterId
								
	
							end
						end
					
					else
						
						this.BigGateVehicleData["VehicleID"] = this.LastVehicleGroupInfo_vehicleCharacterId
						

						
						this.Common_CenterBigGate_OpenTime()
					end
				end
			
			
			elseif( this.LastVehicleGroupInfo_vehicleRouteId == GsRoute.GetRouteId( this.BigGateVehicleData["VehicleRouteName02"] ) ) then
				
				if( GsRoute.GetRouteId( this.BigGateVehicleData["VehicleRouteName02"] ) ~= "NotClose" ) then
					
					if( this.LastVehicleGroupInfo_passedNodeIndex == this.BigGateVehicleData["VehicleRouteNodeIndex02"] ) then
						
						this.Common_CenterBigGate_Close()
						
						this.Common_CenterBigGateVehicleInit()
					end
				end
			end
		end
	end
end



this.Common_CenterBigGateVehicleEndCPRadio = function()

	local RadioEnentName = TppData.GetArgument(1)





	
	if( RadioEnentName == this.BigGateCallRadioName ) then
		
		this.Common_CenterBigGate_Open()
		
		
	end

end



this.Common_CenterBigGate_OpenTime = function()





	
	if( this.BigGateVehicleData["Init"] == true ) then



		
		TppCommandPostObject.GsSetGroupVehicleRoute( this.BigGateVehicleData["Cpid"], this.BigGateVehicleData["VehicleID"], this.BigGateVehicleData["VehicleRouteName02"], 0 )
	end
end






this.Common_ChicoPazDead = function()

	local manager = TppEventSequenceManagerCollector.GetManagerBody()
	local message = TppEventSequenceManagerCollector.GetMessageStr()
	local characterID = TppEventSequenceManagerCollector.GetMessageArg(0)
	local DeadSituation = TppEventSequenceManagerCollector.GetMessageArg(1)




	
	if ( DeadSituation == 11 ) then
		this.ChicoPazDeadRideOnHelicopter = true
	end

	TppMission.ChangeState( "failed", characterID .. "Dead" )

end

this.PlayCameraAnimationOnChicoPazDead = function( characterId )




	if ( not this.ChicoPazDeadRideOnHelicopter ) then
		this.PlayCameraOnCommonCharacterGameOver(characterId, this.CamOffSetPos_Paz )
	end
end



this.PlayCameraOnCommonCharacterGameOver = function( characterId, OffSetPos)




	local OffSetPos = OffSetPos or { 0, -0.5, -3.0 }

	TppHighSpeedCameraManager.RequestEvent{
		continueTime = 1.0,		
		worldTimeRate = 0.1,			
		localPlayerTimeRate = timeRate,		
		timeRateInterpTimeAtStart = 0.0,	
		timeRateInterpTimeAtEnd = 0.3,		
		cameraSetUpTime = 0.0				
	}

	
	
	TppPlayerUtility.RequestToPlayCameraNonAnimation{
		characterId = characterId, 
		isFollowPos = false,
		isFollowRot = true,
		isCollisionCheck = false, 
		isCameraAutoSelect = true, 
		followTime = 10.0,
		followDelayTime = 0.1, 
		useCharaPosRot = true,
		rotX = 30.0,
		rotY = 145.0,	 
		candidateRotX = 30.0,
		candidateRotY = 45.0,
		offsetPos = Vector3( OffSetPos ),
		focalLength = 50.0,
		focusDistance = 3.0 ,
		
		aperture = 20.0,
		timeToSleep = 10.0 
	}

	
	TppMusicManager.PostJingleEvent( "SingleShot", "Play_bgm_gntn_jingle_area_failed" )

end


this.PlayCameraOnCommonHelicopterGameOver = function( )




	TppPlayerUtility.RequestToPlayCameraNonAnimation{
		characterId = "SupportHelicopter", 
		isFollowPos = false,
		isFollowRot = true,
		followTime = 10.0,
		useCharaPosRot = true,
		rotX = 13.00,
		rotY = 145.0,	 
		candidateRotX = 0.0,
		candidateRotY = 45.0,
		offsetPos = Vector3( -11.471, 3.0, 16.383),
		focalLength = 21.0,
		focusDistance = 3.0 ,
		
		aperture = 20.0,
		timeToSleep = 30.0 
	}

	
	local levelX = 0.5
	local levelY = 0.5
	local time = 5.0
	local decayRate = 0.08
	local randomSeed = 12345
	local enableCamera = { 3 }

	TppPlayerUtility.SetCameraNoise{
		levelX = levelX,
		levelY = levelY,
		time = time,
		decayRate = decayRate,
		randomSeed = randomSeed,
		enableCamera = enableCamera,
	}
end


this.PlayCameraOnCommonCharacterOutsideArea = function( characterId, OffSetPos)




	local OffSetPos = OffSetPos or { 0, -0.5, -3.0 }

	TppHighSpeedCameraManager.RequestEvent{
		continueTime = 1.0,		
		worldTimeRate = 0.1,			
		localPlayerTimeRate = timeRate,		
		timeRateInterpTimeAtStart = 0.0,	
		timeRateInterpTimeAtEnd = 0.3,		
		cameraSetUpTime = 0.0				
	}

	
	
	TppPlayerUtility.RequestToPlayCameraNonAnimation{
		characterId = characterId,			
		isFollowPos = false,				
		isFollowRot = true,					
		isCollisionCheck = false,			
		isCameraAutoSelect = true,			
		followTime = 10.0,					
		followDelayTime = 0.05,				
		useCharaPosRot = true,				
		rotX = 30.0,						
		rotY = 145.0,						
		candidateRotX = 30.0,				
		candidateRotY = 45.0,				
		offsetPos = Vector3( OffSetPos ),	
		focalLength = 30.0,					
		focusDistance = 3.0 ,				
		
		aperture = 20.0,
		timeToSleep = 10.0					
	}

end





this.SearchTargetCharacterSetup = function( manager, CharacterID )



	
	manager.CheckLookingTarget:AddSearchTargetEntity{				
		mode 						= "CHARACTER",					
		name						= CharacterID,					
		targetName					= CharacterID,					
		skeletonName				= "SKL_004_HEAD",				
		offset 						= Vector3(0,0.15,0),			
		lookingTime					= 1.0,							
		doWideCheck					= true,							
		wideCheckRadius				= 0.15,							
		wideCheckRange				= 0.07,							
		doDirectionCheck			= true,							
		directionCheckRange			= 125,							
		doInMarkerCheckingMode		= true,							
		doCollisionCheck			= true,							
		doSendMessage				= true,							
		doNearestCheck				= false							
	}
end


this.CallSearchTarget = function()



	
	TppSoundDaemon.PostEvent( "sfx_s_enemytag_main_tgt" )
end

















this.CheckContinueHostageRegister = function( ContinueHostageRegisterList )
	local VehicleTypeBoxShapeSizeList = {
		Vehicle			= Vector3( 5.0, 5.0, 5.0 ),
		Truck			= Vector3( 4.0, 6.0, 8.0 ),
		Armored_Vehicle	= Vector3( 5.0, 7.0, 9.0 ),
	}



	local missionName	= TppMission.GetMissionName()
	local warpLocatorID = missionName .. "_warpHostageLocators"
	
	for i, CheckList in pairs( ContinueHostageRegisterList ) do
		local dataBody	= TppData.GetData( CheckList.Pos )
		local pos		= dataBody:GetWorldTransform().translation
		local rot		= dataBody:GetWorldTransform().rotQuat
		local size
		
		if( CheckList.VehicleType == "Vehicle" or CheckList.VehicleType == "Truck" or CheckList.VehicleType == "Armored_Vehicle" ) then
			size = VehicleTypeBoxShapeSizeList[ CheckList.VehicleType ]
		else
			size = nil
		end
		if( size ~= nil ) then
			local npcIds = TppNpcUtility.GetNpcByBoxShape( pos, size, rot )



			
			if( npcIds and #npcIds.array > 0 ) then



				local count = 1
				for j, id in ipairs( npcIds.array ) do
					local npctype = TppNpcUtility.GetNpcType( id )
					local CharacterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )






					
					if( npctype == "Hostage" ) then
						local registerpoint = CheckList.HostageRegisterPoint[ count ]
						if( registerpoint ~= nil ) then



							local CharacterID = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
							TppCharacterUtility.WarpCharacterIdFromIdentifier( CharacterID, warpLocatorID, registerpoint )
							count = count + 1
						else



						end
					end
				end
			end
		end
	end
end





this.CallAlertSirenCheck = function()





	local status = TppData.GetArgument(2)

	
	if ( status == "Up" ) then



		this.CallAlertSiren()
	end

end


this.StopAlertSirenCheck = function()





	local status = TppData.GetArgument(2)

	
	
	if ( status == "Down" ) then



		this.StopSirenNormal()
	end

end


this.CallAlertSiren = function()




	local daemon = TppSoundDaemon.GetInstance()

	
	daemon:RegisterSourceEvent{
			sourceName = "SoundSource_alertsiren",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren_lp",
	}

	
	daemon:RegisterSourceEvent{
			sourceName = "SoundSource_alertsiren2",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren2_lp",
	}

end


this.CallCautionSiren = function()




	local daemon = TppSoundDaemon.GetInstance()

	
	daemon:RegisterSourceEvent{
			sourceName = "SoundSource_alertsiren",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren_lp",
	}

	
	daemon:RegisterSourceEvent{
			sourceName = "SoundSource_alertsiren2",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren2_lp",
	}

	
	daemon:RegisterSourceEvent{
			sourceName = "SoundSource_alertsiren3",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren3_lp",
	}

end


this.StopSirenNormal = function()




	local daemon = TppSoundDaemon.GetInstance()

	
	daemon:UnregisterSourceEvent{
			sourceName = "SoundSource_alertsiren",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren_lp",
			stopEvent = "Stop_sfx_m_gntn_alert_siren_lp",
	}

	
	daemon:UnregisterSourceEvent{
			sourceName = "SoundSource_alertsiren2",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren2_lp",
			stopEvent = "Stop_sfx_m_gntn_alert_siren2_lp",
	}

	
	daemon:UnregisterSourceEvent{
			sourceName = "SoundSource_alertsiren3",
			tag = "Loop",
			playEvent = "sfx_m_gntn_alert_siren3_lp",
			stopEvent = "Stop_sfx_m_gntn_alert_siren3_lp",
	}

end


this.StopSirenForcibly = function()




	local daemon = TppSoundDaemon.GetInstance()

	
	daemon:UnregisterSourceEvent{
			sourceName = "SoundSource_alertsiren",
			tag = "Loop",
	}

	
	daemon:UnregisterSourceEvent{
			sourceName = "SoundSource_alertsiren2",
			tag = "Loop",
	}

	
	daemon:UnregisterSourceEvent{
			sourceName = "SoundSource_alertsiren3",
			tag = "Loop",
	}

end


this.CallHeliEscapeBGM = function()




	
	if ( TppMission.GetMissionID() ~= 20040 and
		 TppMission.GetMissionID() ~= 20050 and
		 TppMission.GetMissionID() ~= 20070 ) then




		
		TppMusicManager.StartSceneMode()
		TppMusicManager.PlaySceneMusic( "Play_bgm_gntn_heli_leave" )

	end
end

this.StopHeliEscapeBGM = function()




	
	if ( TppMission.GetMissionID() ~= 20040 and
		 TppMission.GetMissionID() ~= 20050 and
		 TppMission.GetMissionID() ~= 20070 ) then




		
		TppMusicManager.PostSceneSwitchEvent( "Stop_bgm_gntn_heli_leave" )
		TppMusicManager.EndSceneMode()
	end

end






this.commonEsrConClean = function()



	EspionageRadioController.Clean()
end




this.Messages = {
	Trap = {
		
		{  data = "Asylum", 					message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "ControlTower_East",		 	message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "ControlTower_West",		 	message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "EastCamp", 					message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "Heliport", 					message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "SeaSide", 					message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "WareHouse", 					message = "Enter", 						commonFunc = onEnterPlayerAreaTrap },
		{  data = "WestCamp", 					message = "Enter",						commonFunc = onEnterPlayerAreaTrap },

		
		{  data = "trap_wtrdrpbil", 			message = "Enter", 						commonFunc = function() TppDataUtility.CreateEffectFromGroupId( "wtrdrpbil" ) end },
		{  data = "trap_wtrdrpbil", 			message = "Exit", 						commonFunc = function() TppDataUtility.DestroyEffectFromGroupId( "wtrdrpbil" ) end },
		
		{  data = "trap_dstcomviw", 			message = "Enter", 						commonFunc = function() TppDataUtility.CreateEffectFromGroupId( "dstcomviw" ) end },
		{  data = "trap_dstcomviw", 			message = "Exit", 						commonFunc = function() TppDataUtility.DestroyEffectFromGroupId( "dstcomviw" ) end },

		
		{ data = "Trap_WarningMissionArea",		message = "Enter", 						commonFunc = function()
																											this.OutsideAreaEffectEnable()
																											this.isPlayerWarningMissionArea = true
																									end },
		{ data = "Trap_WarningMissionArea",		message = "Exit",						commonFunc = function()
																											this.OutsideAreaEffectDisable()
																											this.isPlayerWarningMissionArea = false
																									end },
		
		{  data = "Fence_SE", 					message = "Enter", 						commonFunc = Fence_SE },
	},
	Timer = {
		
	
		
		{ data = "Timer_CpRadioFadeStart",		message = "OnEnd", 						commonFunc = function() this.CpRadioFadeOut() end },
		{ data = "Timer_CpRadioFadeOutEnd",		message = "OnEnd", 						commonFunc = function() TppEnemyUtility.IgnoreCpRadioCall(true) end },	
		
		{ data = "Timer_OutSideAreaWestVehicleTurn",	message = "OnEnd", 				commonFunc = function() this.ForceMove_Vehicle( this.PlayerOnVehicle, { -334.646, 28.693, 140.815 }, -45.0 ) end },
		
		{ data = "Timer_OutSideAreaVoiceStart",	message = "OnEnd", 				commonFunc = function() this.OutsideAreaVoiceStart() end },
	},
	Character = {
		
		{ data = "Player", 						message = "OnVehicleRide_End", 			commonFunc = function() this.PlayerRideOnVehicle() end },	
		{ data = "Player", 						message = "OnVehicleGetOff_Start",		commonFunc = function() this.PlayerGetOffVehicle() end },	
		{ data = "Player", 						message = "OnVehicleRideSneak_End", 	commonFunc = function() this.PlayerRideOnCargo() end },		
		{ data = "Player", 						message = "OnVehicleGetOffSneak_Start", commonFunc = function() this.PlayerGetOffCargo() end },		

		
		{ data = "Player", 						message = "CallRescueHeli", 			localFunc = "OnStartMotherBaseDevise" },	
		{ data = "Player", 						message = "NotifyStartWarningFlare",	localFunc = "OnStartWarningFlare" },		
		
		{ data = "SupportHelicopter",			message = "ArriveToLandingZone",		commonFunc = function() this.SupporHeliLandingZone() end },	
		{ data = "SupportHelicopter",			message = "CloseDoor",					commonFunc = function() this.SupporHeliCloseDoor() end },	
		{ data = "SupportHelicopter",			message = "DepartureToMotherBase",		commonFunc = function() this.SupporHeliDeparture() end },	
		
		{ data = "gntn_BigGateSwitch", 			message = "SwitchOn",					commonFunc = function() this.Common_CenterBigGate_Open() end },	

		
		{ data = "gntn_cp",		message = "AntiAir",	commonFunc = function() this.ChangeAntiAir() end },	
		{ data = "e20020_cp",	message = "AntiAir",	commonFunc = function() this.ChangeAntiAir() end },	
	},
	Enemy = {
		{ 										message = "EnemyInterrogation",			commonFunc = function() this.EnemyInterrogation() end },	
		{										message = "HostageLaidOnVehicle",		commonFunc = function() this.EnemyLaidonVehicle() end },	
	},
	Mission = {
		{ message = "MissionClear", 			localFunc = "commonEsrConClean" },		
		{ message = "ReturnTitle", 				localFunc = "commonEsrConClean" },		
	},
	Gimmick = {
		
		{ data = "gntn_BigGate", message = "DoorOpenComplete", commonFunc = function() this.Common_CenterBigGate_OpenTime() end },
		
		{ data = "gntn_center_SwitchLight", message = "SwitchOn", commonFunc = function() this.ShowCommonAnnounceLog( "announce_power_on" ) end },	
		{ data = "gntn_center_SwitchLight", message = "SwitchOff", commonFunc = function() this.ShowCommonAnnounceLog( "announce_power_off" ) end },	
	},
}




this.ScoreRankTableSetup = function( missionId )




	
	local challengeBonus
	local hardmode = TppGameSequence.GetGameFlag("hardmode")

	
	if ( missionId == 20010 ) then

		
		PlayRecord.InvalidResultScore( "SCORE_HERI_COUNT" )
		PlayRecord.InvalidResultScore( "SCORE_BONUS_CHALLENGE_COUNT" )

		
		challengeBonus = 0	

		
		if ( hardmode ) then
			
			PlayRecord.SetRankTable{ rank_s = 59000, rank_a = 44000, rank_b = 28000, rank_c = 12000, rank_d = 1 }
		else
			
			PlayRecord.SetRankTable{ rank_s = 57000, rank_a = 42000, rank_b = 26000, rank_c = 10000, rank_d = 1 }
		end
		
		
		
		

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,						
			reflexScore = 5250,						

			
			clearTime	 = { diffValue =  3000,		baseValue = 600,	baseScore = 39000,	bonusScore =	0,	minScore =		0,	maxScore = 40000 },	
			alertCount	 = { diffValue =   300,		baseValue =   0,	baseScore = 	0,	bonusScore = 5250,	minScore =	-6000,	maxScore =	   0 },	
			killCount	 = { diffValue =   200,		baseValue =   0,	baseScore = 	0,	bonusScore = 3500,	minScore = -10000,	maxScore =	   0 },	
			retryCount	 = { diffValue =   300,		baseValue =   0,	baseScore = 	0,	bonusScore = 5250,	minScore =	-6000,	maxScore =	   0 },	
			heriCount	 = { diffValue = 0,			baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore = -12000,	maxScore =	   0 },	
			hostageCount = { diffValue = -3500,		baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore =		0,	maxScore = 24500 }	
		}

	
	elseif ( missionId == 20020 ) then

		PlayRecord.InvalidResultScore( "SCORE_BONUS_CHALLENGE_COUNT" )

		
		challengeBonus = 0	

		
		if ( hardmode ) then
			
			PlayRecord.SetRankTable{ rank_s = 50000, rank_a = 38000, rank_b = 25000, rank_c = 12000, rank_d = 1 }
		else
			
			PlayRecord.SetRankTable{ rank_s = 48000, rank_a = 35500, rank_b = 23000, rank_c = 10000, rank_d = 1 }
		end

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,						
			reflexScore = 7500,						

			
			clearTime	 = { diffValue =  3000,		baseValue = 250,	baseScore = 33500,	bonusScore =	0,	minScore =		0,	maxScore = 31700 },	
			alertCount	 = { diffValue =   600,		baseValue =   0,	baseScore = 	0,	bonusScore = 7500,	minScore = -12000,	maxScore =	   0 },	
			killCount	 = { diffValue =   200,		baseValue =   0,	baseScore = 	0,	bonusScore = 2500,	minScore = -10000,	maxScore =	   0 },	
			retryCount	 = { diffValue =   300,		baseValue =   0,	baseScore = 	0,	bonusScore = 3750,	minScore =	-6000,	maxScore =	   0 },	
			heriCount	 = { diffValue =  1500,		baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore = -12000,	maxScore =	   0 },	
			hostageCount = { diffValue = -3500,		baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore =		0,	maxScore = 24500 }	
		}

	
	elseif ( missionId == 20030 ) then

		PlayRecord.InvalidResultScore( "SCORE_BONUS_CHALLENGE_COUNT" )

		
		challengeBonus = 0	

		
		if ( hardmode ) then



			
			PlayRecord.SetRankTable{ rank_s = 52000, rank_a = 39000, rank_b = 25500, rank_c = 12000, rank_d = 1 }
		else



			
			PlayRecord.SetRankTable{ rank_s = 50750, rank_a = 38000, rank_b = 24000, rank_c = 10000, rank_d = 1 }
		end

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,					
			reflexScore = 6000,						

			
			clearTime	 = { diffValue =  3000, baseValue =  200, baseScore = 40000, bonusScore =	 0, minScore =		0, maxScore = 37000 },	
			alertCount	 = { diffValue =   600, baseValue =    0, baseScore =	  0, bonusScore = 6000, minScore = -12000, maxScore =	  0 },	
			killCount	 = { diffValue =   200, baseValue =    0, baseScore =	  0, bonusScore = 2000, minScore = -10000, maxScore =	  0 },	
			retryCount	 = { diffValue =   300, baseValue =    0, baseScore =	  0, bonusScore = 3000, minScore =	-6000, maxScore =	  0 },	
			heriCount	 = { diffValue =  1500, baseValue =    0, baseScore =	  0, bonusScore =	 0, minScore = -12000, maxScore =	  0 },	
			hostageCount = { diffValue = -3500, baseValue =    0, baseScore =	  0, bonusScore =	 0, minScore =		0, maxScore = 24500 }	
		}

	
	elseif ( missionId == 20040 ) then

		
		PlayRecord.InvalidResultScore( "SCORE_HERI_COUNT" )
		
		PlayRecord.InvalidResultScore( "SCORE_ALERT_COUNT" )
		
		PlayRecord.InvalidResultScore( "SCORE_HOSTAGE_COUNT" )
		
		PlayRecord.InvalidResultScore( "SCORE_BONUS_NOREFLEX" )

		PlayRecord.InvalidResultScore( "SCORE_BONUS_CHALLENGE" )

		
		challengeBonus = 0	

		
		if ( hardmode ) then
			
			PlayRecord.SetRankTable{ rank_s = 23500, rank_a = 18500, rank_b = 13500, rank_c = 8500, rank_d = 1 }
		else
			
			PlayRecord.SetRankTable{ rank_s = 19250, rank_a = 15000, rank_b = 10750, rank_c = 6500, rank_d = 1 }
		end

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,						
			reflexScore = 0,						

			
			clearTime	 = { diffValue = 3000, baseValue = 525, baseScore = 24750, bonusScore =    0, minScore =	  0, maxScore = 24779 },	
			alertCount	 = { diffValue =	0, baseValue =	 0, baseScore = 	0, bonusScore =    0, minScore =	  0, maxScore = 	0 },	
			killCount	 = { diffValue =  200, baseValue =	 0, baseScore = 	0, bonusScore =  250, minScore = -10000, maxScore = 	0 },	
			retryCount	 = { diffValue =  300, baseValue =	 0, baseScore = 	0, bonusScore =  375, minScore =  -6000, maxScore = 	0 },	
			heriCount	 = { diffValue =	0, baseValue =	 0, baseScore = 	0, bonusScore =    0, minScore =	  0, maxScore = 	0 },	
			hostageCount = { diffValue =	0, baseValue =	 0, baseScore = 	0, bonusScore =    0, minScore =	  0, maxScore = 	0 },	

		}

	
	elseif ( missionId == 20050 ) then

		PlayRecord.InvalidResultScore( "SCORE_BONUS_CHALLENGE_COUNT" )

		
		challengeBonus = 0	

		
		if ( hardmode ) then
			
			PlayRecord.SetRankTable{ rank_s = 46000, rank_a = 35000, rank_b = 24000, rank_c = 12000, rank_d = 1 }
		else
			
			PlayRecord.SetRankTable{ rank_s = 44000, rank_a = 33000, rank_b = 22000, rank_c = 10000, rank_d = 1 }
		end

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,						
			reflexScore = 8250,						

			
			clearTime	 = { diffValue =  3000,	baseValue = 225,	baseScore = 33750,	bonusScore =	0,	minScore =		0,	maxScore = 31417 },
			alertCount	 = { diffValue =   600,	baseValue =   0,	baseScore = 	0,	bonusScore = 8250,	minScore = -12000,	maxScore =	   0 },	
			killCount	 = { diffValue =   200,	baseValue =   0,	baseScore = 	0,	bonusScore = 2750,	minScore = -10000,	maxScore =	   0 },	
			retryCount	 = { diffValue =   300,	baseValue =   0,	baseScore = 	0,	bonusScore = 4125,	minScore =	-6000,	maxScore =	   0 },	
			heriCount	 = { diffValue =  1500,	baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore = -12000,	maxScore =	   0 },	
			hostageCount = { diffValue = -3500,	baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore =		0,	maxScore = 24500 }	
		}

	
	elseif ( missionId == 20060 ) then

		
		PlayRecord.InvalidResultScore( "SCORE_HOSTAGE_COUNT" )

		
		challengeBonus = 0	

		
		if ( hardmode ) then
			
			PlayRecord.SetRankTable{ rank_s = 69000, rank_a = 54500, rank_b = 40000, rank_c = 20000, rank_d = 1 }
		else
			
			PlayRecord.SetRankTable{ rank_s = 65000, rank_a = 50500, rank_b = 36000, rank_c = 18000, rank_d = 1 }
		end

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,						
			reflexScore = 3000,						

			
			clearTime	 = { diffValue =  3000, baseValue = 120, baseScore = 46800, bonusScore =	0, minScore =	   0,	maxScore = 39800 },	
			alertCount	 = { diffValue =   300, baseValue =	  0, baseScore =	 0, bonusScore = 3000, minScore =  -6000,	maxScore =	   0 },	
			killCount	 = { diffValue =   200, baseValue =   0, baseScore =	 0, bonusScore = 2000, minScore = -10000,	maxScore =	   0 },	
			retryCount	 = { diffValue =   300, baseValue =   0, baseScore =	 0, bonusScore = 3000, minScore =  -6000,	maxScore =	   0 },	
			heriCount	 = { diffValue =  1500, baseValue =   0, baseScore =	 0, bonusScore =	0, minScore = -12000,	maxScore =	   0 },	
			hostageCount = { diffValue =	 0, baseValue =   0, baseScore =	 0, bonusScore =	0, minScore =	   0,	maxScore =	   0 }	
		}

	
	elseif ( missionId == 20070 ) then
		
		challengeBonus = 0	

		
		PlayRecord.InvalidResultScore( "SCORE_HERI_COUNT" )	
		PlayRecord.InvalidResultScore( "SCORE_HOSTAGE_COUNT" )	
		PlayRecord.InvalidResultScore( "SCORE_BONUS_CHALLENGE" )

		
		if ( hardmode ) then
			
			PlayRecord.SetRankTable{ rank_s = 23000, rank_a = 19500, rank_b = 16000, rank_c = 12000, rank_d = 1 }
		else
			
			PlayRecord.SetRankTable{ rank_s = 22000, rank_a = 18000, rank_b = 14000, rank_c = 10000, rank_d = 1 }
		end

		PlayRecord.SetScoreTable{
			initializeScore = 0,					
			challengeScore = challengeBonus,		
			markingScore = 0,						
			reflexScore = 1200,						

			
			clearTime	 = { diffValue =  3000,	baseValue = 510,	baseScore = 21900,	bonusScore =	0,	minScore =		0,	maxScore = 22547 },
			alertCount	 = { diffValue =   600,	baseValue =   0,	baseScore = 	0,	bonusScore = 1200,	minScore = -12000,	maxScore =	   0 },	
			killCount	 = { diffValue =   600,	baseValue =   0,	baseScore = 	0,	bonusScore = 1200,	minScore = -30000,	maxScore =	   0 },	
			retryCount	 = { diffValue =   200,	baseValue =   0,	baseScore = 	0,	bonusScore =  400,	minScore =	-4000,	maxScore =	   0 },	
			heriCount	 = { diffValue =  1500,	baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore = -12000,	maxScore =	   0 },	
			hostageCount = { diffValue =	 0,	baseValue =   0,	baseScore = 	0,	bonusScore =	0,	minScore =		0,	maxScore =	   0 }	
		}

	else



		challengeBonus = 0
	end

end





this.DromItemFromPlayer = function( itemId, index )




	local player = TppPlayerUtility.GetLocalPlayerCharacter()
	local pos = player:GetPosition()
	local isSquat = TppPlayerUtility.IsLocalPlayerSquat()

	if ( isSquat ) then
		
		local vel = player:GetRotation():Rotate( Vector3( 0.0, 0.5, 2.5) )
		local offset = player:GetRotation():Rotate( Vector3( 0.0, -0.35, 0.5) )
		TppNewCollectibleUtility.DropItem{ id = itemId, index = index, pos = pos+offset, rot = Quat.RotationY(1.5), vel = vel, rotVel = Vector3(0,2,0) }
	else
		
		local vel = player:GetRotation():Rotate( Vector3( 0.0, 0.5, 1.5) )
		local offset = player:GetRotation():Rotate( Vector3( 0.0, 0.175, 0.5) )
		TppNewCollectibleUtility.DropItem{ id = itemId, index = index, pos = pos+offset, rot = Quat.RotationY(1.5), vel = vel, rotVel = Vector3(0,2,0) }
	end
end





this.CheckClearRankReward = function( missionId, ClearRankRewardList )





	local hardmode = TppGameSequence.GetGameFlag("hardmode")
	local bestRank = 0

	
	if ( hardmode ) then
		
		bestRank = PlayRecord.GetMissionScore( missionId, "HARD", "BEST_RANK")



	else
		
		bestRank = PlayRecord.GetMissionScore( missionId, "NORMAL", "BEST_RANK")



	end

	
	
	if ( bestRank == 1 ) then
		
		
		return bestRank
	elseif ( bestRank == 2 ) then
		
		
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankS )
		return bestRank
	elseif ( bestRank == 3 ) then
		
		
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankS )
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankA )
		return bestRank
	elseif ( bestRank == 4 ) then
		
		
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankS )
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankA )
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankB )
		return bestRank
	else
		
		
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankS )
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankA )
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankB )
		TppPickableManager.DisableByLocator( ClearRankRewardList.RankC )
		return 5	
	end

end



this.CheckReward_AllChicoTape = function()




	local uiCommonData = UiCommonDataManager.GetInstance()

	if ( uiCommonData:IsHaveCassetteTape( "tp_chico_01" ) == true and
		 uiCommonData:IsHaveCassetteTape( "tp_chico_02" ) == true and
		 uiCommonData:IsHaveCassetteTape( "tp_chico_03" ) == true and
		 uiCommonData:IsHaveCassetteTape( "tp_chico_04" ) == true and
		 uiCommonData:IsHaveCassetteTape( "tp_chico_05" ) == true and
		 uiCommonData:IsHaveCassetteTape( "tp_chico_06" ) == true and
		 uiCommonData:IsHaveCassetteTape( "tp_chico_07" ) == true ) then



		return true
	else



		return false
	end

end




this.Radio_pleaseLeaveHeli = function()

	local player = Ch.FindCharacterObjectByCharacterId( "Player" )
	local pPos = player:GetPosition()
	local heli = Ch.FindCharacterObjectByCharacterId( "SupportHelicopter")
	local hPos = heli:GetPosition()

	local dist = TppUtility.FindDistance( pPos, hPos )




	
	if( dist < 1000 )then



		return true
	end

	return false
end


this.SetGameStatusForDemoTransition = function()



	
	TppGameStatus.Set("TppDemo.lua","S_DISABLE_NPC_NOTICE")
	TppGameStatus.Set("TppDemo.lua","S_DISABLE_TARGET")
	TppGameStatus.Set("TppDemo.lua","S_DISABLE_PLAYER_PAD")
	TppGameStatus.Set("TppDemo.lua","S_DISABLE_THROWING")
	TppGameStatus.Set("TppDemo.lua","S_DISABLE_PLACEMENT")
end




return this
