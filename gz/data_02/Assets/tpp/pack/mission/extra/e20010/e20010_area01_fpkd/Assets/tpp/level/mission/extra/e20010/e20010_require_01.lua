local this = {}



this.missionID	= 20010
this.cpID		= "gntn_cp"




local KillWaiting_SpHostahe_EnemyPos = function()
	TppMission.SetFlag( "isSpHostageKillVersion", true )
	
	TppHostageUtility.SetHostageStatusInCp( "gntn_cp", "SpHostage", "HOSTAGE_STATUS_NONE" )
	TppEnemy.Warp( "SpHostage" , "warp_KillingHostage" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "KillWaiting_Hostage01" , -1 , "Seq20_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "KillWaiting_Hostage02" , -1 , "ComEne13" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "KillWaiting_Hostage03" , -1 , "ComEne14" , "ROUTE_PRIORITY_TYPE_FORCED" )
end



local NoKillWaiting_SpHostahe_EnemyPos = function()
	TppMission.SetFlag( "isSpHostageKillVersion", false )
	
	TppHostageUtility.SetHostageStatusInCp( "gntn_cp", "SpHostage", "HOSTAGE_STATUS_LOST" )
	
	TppEnemyUtility.SetEnableCharacterId( "Seq20_03" , false )
	TppEnemyUtility.SetEnableCharacterId( "Seq20_06" , true )
	
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Talk_SearchSpHostage", true , false )
	
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Seaside2manStartRouteChange", false , false )

	
	if ( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == true ) or
		( TppMission.GetFlag( "isSpHostage_Dead" ) == true ) then
		TppMarkerSystem.DisableMarker{ markerId = "SpHostage" }
	else
	end
	TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage01" ) 					
	TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage02" ) 					
	TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage03" ) 					
	TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage04" ) 					
	TppEnemy.EnableRoute( this.cpID , "S_SearchSpHostage05a" ) 					
	TppEnemy.DisableRoute( this.cpID , "S_Waiting_PC_AsyOut01" )				
	TppEnemy.DisableRoute( this.cpID , "S_Waiting_PC_AsyOut02" )				
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SearchSpHostage03" , 0 , "Seq20_01" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SearchSpHostage04" , 0 , "Seq20_06" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SearchSpHostage05a" , 0 , "Seq20_04" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SearchSpHostage01" , 0 , "ComEne13" , "ROUTE_PRIORITY_TYPE_FORCED" )
	TppCommandPostObject.GsSetPriorityEnemyForRoute( this.cpID , "e20010_Seq20_SneakRouteSet" , "S_SearchSpHostage02" , 0 , "ComEne14" , "ROUTE_PRIORITY_TYPE_FORCED" )
end



local commonUiMissionSubGoalNo = function( id )



	local commonDataManager = UiCommonDataManager.GetInstance()
	if commonDataManager == NULL then
			return
	end

	local luaData = commonDataManager:GetUiLuaExportCommonData()
	if luaData == NULL then
			return
	end
	
	luaData:SetCurrentMissionSubGoalNo( id)
end




this.Radio_OnAmmoStackEmpty = function()
	local weaponID = TppData.GetArgument( 1 )



	
	if weaponID == "WP_ar00_v03" then
		TppRadio.Play( "Miller_EmptyMagazin" )
	end
end


this.Tutorial_1Button = function( textInfo, buttonIcon )
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( textInfo, buttonIcon )
end
this.Tutorial_2Button = function( textInfo, buttonIcon1, buttonIcon2 )
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( textInfo, buttonIcon1, buttonIcon2 )
end


this.Sub_rdps0z00_0x1012 = function()
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( "tutorial_pause", "UI_SELECT" )
	hudCommonData:CallButtonGuide( "tutorial_controll", fox.PAD_Y )
end

this.Sub_rdps1001_111010 = function()
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( "tutorial_pause", "UI_SELECT" )
	hudCommonData:CallButtonGuide( "tutorial_apc", fox.PAD_Y )
end
this.Sub_RDPS1000_181015 = function()
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:CallButtonGuide( "tutorial_equipment_wp", true, true )
	hudCommonData:CallButtonGuide( "tutorial_attack", "PL_HOLD", "PL_SHOT" )
end
this.Sub_ENQT1000_1m1310 = function()
	
	local timer = 3
	GkEventTimerManager.Start( "Timer_GetPazInfo", timer )
end
this.Sub_SLTB0z10_5y1010 = function()
	
	local DelayTime = 3
	TppRadio.DelayPlay( "Miller_EscapeOrAttack", DelayTime )
end
this.Sub_rdps2110_141010 = function()
	this.Tutorial_1Button("tutorial_restraint","PL_CQC")
	this.Tutorial_1Button("tutorial_interrogation","PL_CQC_INTERROGATE")
end


this.Common_Elude = function()
	if( TppMission.GetFlag( "isInSeaCliffArea" ) == true ) then	
		TppRadio.DelayPlayEnqueue("Miller_MillerEludeFall", "short")
	elseif( TppMission.GetFlag( "isInStartCliffArea" ) == true ) then	
		
	else														
		TppRadio.DelayPlayEnqueue("Miller_MillerEludeNoFall", "short")
	end

	
	local sequence = TppSequence.GetCurrentSequence()
	if ( sequence == "Seq_NextRescuePaz" ) then
		if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false and
			 TppMission.GetFlag( "isQuestionChico" ) == false ) then
			TppRadio.RegisterOptionalRadio( "Optional_RescueChicoToRVChico" )	
		end
	end
end


this._InterrogationAdviceTimerStart = function( timer )

	
	GkEventTimerManager.Start( "Timer_InterrogationAdvice", timer )
end

this.InterrogationAdviceTimerStart = function()
	this._InterrogationAdviceTimerStart(600)
end

this.InterrogationAdviceTimerReStart = function()
	TppRadio.DelayPlay("Miller_ChicoTapeAdvice01", "mid")
	this._InterrogationAdviceTimerStart(360)
end


this.Radio_InterrogationAdvice = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		TppRadio.PlayEnqueue("Miller_InterrogationAdvice")
		TppEnemyUtility.SetInterrogationForceCharaIdAllCharacter( "PazHint_01" )	
		TppMission.SetFlag( "isInterrogation_Radio", true )	
		TppMission.SetFlag( "isPlayInterrogationAdv", true )
		TppRadio.RegisterOptionalRadio( "Optional_Interrogation" )
		
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
		end
	else
		this._InterrogationAdviceTimerStart(30)
	end
end


this.Common_ConversationEnd = function()





end


this.OnVehicleCheckRadioPlay = function( radioID, DelayTime )
	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
	if( VehicleId == "" and GZCommon.PlayerOnCargo == "NoRide" ) then
		TppRadio.DelayPlay( radioID, DelayTime )
	end
end
this.OnVehicleCheckRadioPlayEnqueue = function( radioID, DelayTime )
	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
	if( VehicleId == "" and GZCommon.PlayerOnCargo == "NoRide" ) then
		if( TppRadio.IdRadioPlayable() == true ) then
			TppRadio.DelayPlayEnqueue( radioID, DelayTime )
		end
	end
end

this.Radio_drainTutorial = function()

	local characterId = TppPlayerUtility.GetCarriedCharacterId()
	local radioDaemon = RadioDaemon:GetInstance()
	
	radioDaemon:EnableFlagIsMarkAsRead( "e0010_rtrg0968" )
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1250") == false ) then
		if( characterId == "" ) then
			TppRadio.DelayPlayEnqueue( "Miller_HohukuAdvice" ,"short" )
		end
		radioDaemon:EnableFlagIsMarkAsRead( "e0010_rtrg1250" )
	end
end


this.Radio_helipad = function()
	if( TppMission.GetFlag( "isCenterEnter" ) == false ) then
		this.OnVehicleCheckRadioPlay( "Miller_InHeliport" )
	end
end


this.Radio_RouteDrain = function()
	local timer = 1
	GkEventTimerManager.Start( "Timer_MillerHistory1", timer )

	
	TppMission.SetFlag( "isBehindTutorial", e20010_sequence.flagchk_CoverTutorialEnd )
	
	TppMission.SetFlag( "isCenterEnter", true )
	
	GkEventTimerManager.Stop( "Timer_InterrogationAdvice" )
end


this.Radio_InCenterCoverAdvice = function()
	local radioDaemon = RadioDaemon:GetInstance()

	if( TppMission.GetFlag( "isCenterEnter" ) == false ) then
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg3070") == false and
			radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg3072") == false ) then
			if( TppMission.GetFlag( "isDoneCQC" ) == false ) then
				TppRadio.PlayEnqueue("Miller_InCenterCoverAdviceCQC")
				TppMission.SetFlag( "isDoneCQC", true ) 
			else
				TppRadio.PlayEnqueue("Miller_InCenterCoverAdvice")
			end

			
			TppMission.SetFlag( "isBehindTutorial", e20010_sequence.flagchk_CoverTutorialEnd )
			
			GkEventTimerManager.Stop( "Timer_InterrogationAdvice" )
			
			TppMission.SetFlag( "isCenterEnter", true )
		end
	end
end


this.Common_e0010_rtrg0740 = function()
	local VehicleID = TppData.GetArgument(2)
	if VehicleID == "LightVehicle" then

	else

	end
end


this.CallTapeReaction0 = function()
	if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
		TppRadio.Play( "Miller_TapeReaction00" )
	end
	if ( TppMission.GetFlag( "isChicoTapePlay" ) == false ) then
		TppMission.SetFlag( "isChicoTapePlay", true )
	end
end
this.CallTapeReaction1 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			TppRadio.Play( "Miller_TapeReaction01" )
		end
	end
end
this.CallTapeReaction2 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			TppRadio.Play( "Miller_TapeReaction02" )
		end
	end
end
this.CallTapeReaction3 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			TppRadio.Play( "Miller_TapeReaction03" )
		end
	end
end
this.CallTapeReaction4 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			
		end
	end
end
this.CallTapeReaction5 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			TppRadio.Play( "Miller_TapeReaction05" )
		end
	end
end
this.CallTapeReaction6 = function()
	local phase = TppEnemy.GetPhase( this.cpID )
	if ( phase == "alert" or phase == "evasion" ) then
	else
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			
		end
	end
end
this.CallTapeReaction7 = function()
	local phase = TppEnemy.GetPhase( this.cpID )
	local radioDaemon = RadioDaemon:GetInstance()
	if ( phase == "alert" or phase == "evasion" ) then
	else
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false ) then
			TppRadio.DelayPlay( "Miller_TapeReaction07", "mid" )
		end
	end
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1270") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1271") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1272") == false or
		radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1274") == false) then
		if( TppMission.GetFlag( "isPazMarkJingle" ) == false and TppMission.GetFlag( "isInterrogation_Radio" ) == false ) then
			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( true )
		else
			
			TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
		end
	else
		
		TppRadioCommand.SetEnableDisableRadioWhileChico3TapeIsPlaying( false )
	end
end
















this.MbDvcActCallRescueHeli = function(characterId, type)
	local radioDaemon = RadioDaemon:GetInstance()
	local emergency = TppData.GetArgument(2)
	local charaObj = Ch.FindCharacterObjectByCharacterId("SupportHelicopter")
	local plgHeli = charaObj:GetCharacter():FindPlugin("TppSupportHelicopterPlugin")












	TppMission.SetFlag( "isHeliComingRV", true )

	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()

	if( VehicleId == "SupportHelicopter" ) then
	else
		if ( type == "MbDvc" ) then










			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0381") == false and
				
					TppMission.GetFlag( "isDoCarryAdvice" ) == false ) then
						TppRadio.DelayPlay( "Miller_StartCallHeli", "long" )
				else
					if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
					
						if(emergency == 2) then
							TppRadio.DelayPlay( "Miller_CallHeliHot02", "long" )
						else
							TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
						end
					else
					
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
		elseif ( type == "flare" ) then










			if ( emergency == false ) then
				
				if ( radioDaemon:IsPlayingRadio() == false ) then
					
					TppRadio.DelayPlay( "Miller_HeliNoCall", "long" )
				end
				TppMission.SetFlag( "isHeliComingRV", false )
			else
				
				if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0381") == false and
				
					TppMission.GetFlag( "isDoCarryAdvice" ) == false ) then
						TppRadio.DelayPlay( "Miller_StartCallHeli", "long" )
				else
					if ( radioDaemon:IsPlayingRadio() == false ) then
						
						if(TppSupportHelicopterService.IsDueToGoToLandingZone(characterId)) then
						
							if(emergency == 2) then
								TppRadio.DelayPlay( "Miller_CallHeliHot02", "long" )
							else
								TppRadio.DelayPlay( "Miller_CallHeli02", "long" )
							end
						else
						
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
			end
		else
			if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0381") == false and
			
				TppMission.GetFlag( "isDoCarryAdvice" ) == false ) then
					TppRadio.DelayPlay( "Miller_StartCallHeli", "long" )
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
end


this.HostageQuiet_Trap = function()
	TppHostageManager.GsSetStruggleFlag( "Hostage_e20010_003" , false )
	TppHostageManager.GsSetStruggleFlag( "Hostage_e20010_004" , false )
end


this.ChicoPaznHeliSave = function()

	local sequence = TppSequence.GetCurrentSequence()
	local LzName = TppSupportHelicopterService.GetRendezvousPointNameWhichHelicopterIsWaitingOn("SupportHelicopter")

	if ( sequence == "Seq_NextRescuePaz" ) and						
		( TppMission.GetFlag( "isCassetteDemo" ) == false ) and		
		( TppMission.GetFlag( "isChicoTapePlay" ) == false ) then	
			
	else
		if ( LzName == "RV_HeliPort" ) then
			TppMissionManager.SaveGame("50")
		elseif ( LzName == "RV_SeaSide" ) then
			TppMissionManager.SaveGame("40")
		elseif ( LzName == "RV_StartCliff" ) then
			TppMissionManager.SaveGame("10")
		elseif ( LzName == "RV_WareHouse" ) then
			TppMissionManager.SaveGame("51")
		else
			TppMissionManager.SaveGame("10")
		end
	end
end

this.Common_HeliDescend = function()

	local JingleFlag		= 0
	local lz_name = TppData.GetArgument(2)

	
	if lz_name == "RV_SeaSide" then			
		local pos_seaside		= Vector3( 136.785 , 4.964 , 110.680 )
		local size_seaside		= Vector3( 40 , 10 , 40 )
		local npcIds = TppNpcUtility.GetNpcByBoxShape( pos_seaside , size_seaside )
		
		if npcIds and #npcIds.array > 0 then
			for i,id in ipairs(npcIds.array) do
				local type = TppNpcUtility.GetNpcType( id )
				if type == "Hostage" then
					local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
					if( characterId == "Chico" ) then
						if( TppMission.GetFlag( "isChicoHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isChicoHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					elseif ( characterId == "Paz" )then
						if( TppMission.GetFlag( "isPazHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isPazHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					end
				end
			end
		end
	elseif lz_name == "RV_HeliPort" then	
		local pos_heliport		= Vector3( -89.871 , 31.080 , 52.4140 )
		local size_heliport		= Vector3( 40 , 10 , 40 )
		local npcIds = TppNpcUtility.GetNpcByBoxShape( pos_heliport , size_heliport )
		
		if npcIds and #npcIds.array > 0 then
			for i,id in ipairs(npcIds.array) do
				local type = TppNpcUtility.GetNpcType( id )
				if type == "Hostage" then
					local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
					if( characterId == "Chico" ) then
						if( TppMission.GetFlag( "isChicoHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isChicoHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					elseif ( characterId == "Paz" )then
						if( TppMission.GetFlag( "isPazHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isPazHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					end
				end
			end
		end
	elseif lz_name == "RV_WareHouse" then	
		local pos_warehouse 	= Vector3( -116.094 , 27.944 , 144.713 )
		local size_warehouse	= Vector3( 40 , 10 , 40 )
		local npcIds = TppNpcUtility.GetNpcByBoxShape( pos_warehouse , size_warehouse )
		
		if npcIds and #npcIds.array > 0 then
			for i,id in ipairs(npcIds.array) do
				local type = TppNpcUtility.GetNpcType( id )
				if type == "Hostage" then
					local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
					if( characterId == "Chico" ) then
						if( TppMission.GetFlag( "isChicoHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isChicoHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					elseif ( characterId == "Paz" )then
						if( TppMission.GetFlag( "isPazHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isPazHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					end
				end
			end
		end
	elseif lz_name == "RV_StartCliff" then	
		local pos_startcliff	= Vector3( -221.038 , 37.841 , 301.937 )
		local size_startcliff	= Vector3( 60 , 20 , 60 )
		local npcIds = TppNpcUtility.GetNpcByBoxShape( pos_startcliff , size_startcliff )
		
		if npcIds and #npcIds.array > 0 then
			for i,id in ipairs(npcIds.array) do
				local type = TppNpcUtility.GetNpcType( id )
				if type == "Hostage" then
					local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
					if( characterId == "Chico" ) then
						if( TppMission.GetFlag( "isChicoHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isChicoHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					elseif ( characterId == "Paz" )then
						if( TppMission.GetFlag( "isPazHeliJingle" ) == false ) then
							if JingleFlag == 0 then
								TppMusicManager.PostJingleEvent( "SuspendPhase", "Play_bgm_gntn_jingle_heli" )
								TppMission.SetFlag( "isPazHeliJingle", true )
								JingleFlag = 1
							else
							end
						else
						end
					end
				end
			end
		end
	else
	end
end

this.OpenGateTruck_SneakRideON = function()
	local VehicleId		= TppData.GetArgument(1)
	if( VehicleId == "Cargo_Truck_WEST_004" ) then
		TppMission.SetFlag( "isTruckSneakRideOn", true )
	else
	end
end

this.OpenGateTruck_SneakRideOFF = function()
	local VehicleId		= TppData.GetArgument(1)
	if( VehicleId == "Cargo_Truck_WEST_004" ) then
		TppMission.SetFlag( "isTruckSneakRideOn", false )
	else
	end
end

this.SpHostageMonologue = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

	
	if( TppPlayerUtility.IsCarriedCharacter( "SpHostage" )) then
		local obj = Ch.FindCharacterObjectByCharacterId("SpHostage")

		if not Entity.IsNull(obj) then
			TppEnemyUtility.CallCharacterMonologue( "POW_CD_paz_001" , 3, obj, true )
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "SpHostageMonologue", false , false )
		end
	else
	end
end

this.Hostage01Monologue = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

	
	if( TppPlayerUtility.IsCarriedCharacter( "Hostage_e20010_001" )) then
		local obj = Ch.FindCharacterObjectByCharacterId("Hostage_e20010_001")

		if not Entity.IsNull(obj) then
			TppEnemyUtility.CallCharacterMonologue( "POW_CD_0010" , 3, obj, true )
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Hostage01Monologue", false , false )
		end
	else
	end
end

this.Hostage02Monologue = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

	
	if( TppPlayerUtility.IsCarriedCharacter( "Hostage_e20010_002" )) then
		local obj = Ch.FindCharacterObjectByCharacterId("Hostage_e20010_002")

		if not Entity.IsNull(obj) then
			TppEnemyUtility.CallCharacterMonologue( "POW_CD_0020" , 3, obj, true )
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Hostage02Monologue", false , false )
		end
	else
	end
end

this.Hostage03Monologue = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

	
	if( TppPlayerUtility.IsCarriedCharacter( "Hostage_e20010_003" )) then
		local obj = Ch.FindCharacterObjectByCharacterId("Hostage_e20010_003")

		if not Entity.IsNull(obj) then
			TppEnemyUtility.CallCharacterMonologue( "POW_CD_0030_01" , 3, obj, true )
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Hostage03Monologue", false , false )
		end
	else
	end
end

this.Hostage04Monologue = function( manager, messageId, characterId, characterHandle, trapBodyHandle, trapName )

	
	if( TppPlayerUtility.IsCarriedCharacter( "Hostage_e20010_004" )) then
		local obj = Ch.FindCharacterObjectByCharacterId("Hostage_e20010_004")

		if not Entity.IsNull(obj) then
			TppEnemyUtility.CallCharacterMonologue( "POW_CD_0040" , 3, obj, true )
			TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap", "Hostage04Monologue", false , false )
		end
	else
	end
end

this.SpHostageInformation = function()
	TppMission.SetFlag( "isGetDuctInfomation", true )					
	
	local hudCommonData = HudCommonDataManager.GetInstance()
	hudCommonData:AnnounceLogViewLangId( "announce_map_update" )
	
	TppMarker.Enable( "Marker_Duct", 0 , "none" , "map_only_icon" , 0 , false , true )
end


this.commonHeliLeaveJudge = function()
	local radioDaemon = RadioDaemon:GetInstance()
	local timer = 55 

	
	if( TppMission.GetFlag( "isHeliLandNow" ) == true ) then
		
		if ( GZCommon.Radio_pleaseLeaveHeli() == true ) then
			
			if ( radioDaemon:IsPlayingRadio() == false ) then
				
				TppRadio.PlayEnqueue( "Miller_HeliLeave" )
			end
			GkEventTimerManager.Start( "Timer_pleaseLeaveHeli", timer )
		end
	end
end

this.commonHeliLeaveExtension = function()
	local timer = 55 

	
	GkEventTimerManager.Stop( "Timer_pleaseLeaveHeli" )
	GkEventTimerManager.Start( "Timer_pleaseLeaveHeli", timer )
end



this.ComeEne17_NodeAction = function()

	local RouteName			= TppData.GetArgument(3)
	local RoutePointNumber	= TppData.GetArgument(1)

	if ( RouteName ==  GsRoute.GetRouteId( "ComEne17_TalkRoute" )) then
		if( RoutePointNumber == 11 ) then
			TppEnemy.EnableRoute( this.cpID , "S_Sen_Bridge" )
			TppEnemy.DisableRoute( this.cpID , "ComEne17_TalkRoute" )
			TppEnemy.ChangeRoute( this.cpID , "ComEne17","e20010_Seq20_SneakRouteSet","S_Sen_Bridge", 0 )
		else
		end
	else
	end
end
this.ComEne17_RouteChange = function()

	TppEnemy.EnableRoute( this.cpID , "ComEne17_TalkRoute" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortHouse" )
	TppEnemy.ChangeRoute( this.cpID , "ComEne17","e20010_Seq20_SneakRouteSet","ComEne17_TalkRoute", 0 )
end

this.Talk_Helipad02 = function()

	local sequence = TppSequence.GetCurrentSequence()

	TppEnemy.EnableRoute( this.cpID , "ComEne15_TalkRoute" )
	TppEnemy.DisableRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" )

	
	if ( sequence == "Seq_RescueHostages" ) then
		TppEnemy.ChangeRoute( this.cpID , "ComEne15","e20010_Seq10_SneakRouteSet","ComEne15_TalkRoute", 0 )
	elseif ( sequence == "Seq_NextRescuePaz" ) then
		TppEnemy.ChangeRoute( this.cpID , "ComEne15","e20010_Seq20_SneakRouteSet","ComEne15_TalkRoute", 0 )
	else
		
	end
end

this.Select_ComEne15_NodeAction = function()
	local RouteName			= TppData.GetArgument(3)
	local RoutePointNumber	= TppData.GetArgument(1)
	local sequence			= TppSequence.GetCurrentSequence()
	
	if ( RouteName ==  GsRoute.GetRouteId( "ComEne15_TalkRoute" )) then
		if( RoutePointNumber == 2 ) then
			TppEnemy.EnableRoute( this.cpID , "S_Sen_HeliPortFrontGate_a" ) 	
			TppEnemy.DisableRoute( this.cpID , "ComEne15_TalkRoute" ) 			
			
			if ( sequence == "Seq_RescueHostages" ) then
				TppEnemy.ChangeRoute( this.cpID , "ComEne15","e20010_Seq10_SneakRouteSet","S_Sen_HeliPortFrontGate_a", 0 )	
			elseif ( sequence == "Seq_NextRescuePaz" ) then
				TppEnemy.ChangeRoute( this.cpID , "ComEne15","e20010_Seq20_SneakRouteSet","S_Sen_HeliPortFrontGate_a", 0 )	
			else
				
			end
		else
		end
	else
	end
end

this.Radio_QustionAdvice = function()
	if( TppMission.GetFlag( "isDoCarryAdvice" ) == true ) then	
		TppRadio.DelayPlay("Miller_QustionAdvice", "short")
	end
end


this.Radio_BinocularsTutorial = function()






end

this.Radio_BinocularsModeOn = function()
	



	local radioDaemon = RadioDaemon:GetInstance()
	local binoJudge = radioDaemon:GetRadioGroupSetNameCurrentRegistered()

	local hash1 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg0010" )
	local hash2 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg0020" )
	local hash3 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg0022" )
	local hash4 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg0030" )

	if ( binoJudge == hash1 ) then
			TppRadio.RegisterOptionalRadio( "Optional_GameStartToRescueBino" )
	elseif ( binoJudge == hash2 ) then
			TppRadio.RegisterOptionalRadio( "Optional_RVChicoToRescuePazBino" )
	elseif ( binoJudge == hash3 ) then
			TppRadio.RegisterOptionalRadio( "Optional_InterrogationBino" )
	elseif ( binoJudge == hash4 ) then
			TppRadio.RegisterOptionalRadio( "Optional_RescuePazToRescueChicoBino" )
	end
end

this.Radio_BinocularsModeOff = function()
	



	local radioDaemon = RadioDaemon:GetInstance()
	local binoJudge = radioDaemon:GetRadioGroupSetNameCurrentRegistered()

	local hash1 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg1010" )
	local hash2 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg1020" )
	local hash3 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg1022" )
	local hash4 = radioDaemon.ConvertToGroupNameID( "Set_e0010_oprg1030" )

	if ( binoJudge == hash1 ) then
			TppRadio.RegisterOptionalRadio( "Optional_GameStartToRescue" )
	elseif ( binoJudge == hash2 ) then
			TppRadio.RegisterOptionalRadio( "Optional_RVChicoToRescuePaz" )
	elseif ( binoJudge == hash3 ) then
			TppRadio.RegisterOptionalRadio( "Optional_Interrogation" )
	elseif ( binoJudge == hash4 ) then
			TppRadio.RegisterOptionalRadio( "Optional_RescuePazToRescueChico" )
	end
end


this.Select_SwitchLightAdvice = function()





end

this.Radio_NearRvEscapedTarget = function()
	if( TppMission.GetFlag( "isHeliComingRV" ) == false ) then
		TppRadio.Play( "Miller_NearRvEscapedTarget" )
	end
end


this.Radio_SearchChico = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( TppMission.GetFlag( "isSearchLightChicoArea" ) < 2 ) then
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0070") == false and radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0080") == false ) then
			TppRadio.DelayPlayEnqueue( "Miller_SearchChico", "short" )
		end
	end
end


this.Radio_Cheer = function()
	if( TppMission.GetFlag( "isKeepCaution" ) == true ) then
		TppRadio.PlayEnqueue( "Miller_Cheer" )
	end
end


this.Radio_CQCTutorial = function()
	local radioDaemon = RadioDaemon:GetInstance()

	if( TppMission.GetFlag( "isDoCarryAdvice" ) == true ) then
		if( TppMission.GetFlag( "isDoneCQC" ) == false ) then
			TppRadio.PlayEnqueue( "Miller_CqcAdvice" )
			TppMission.SetFlag( "isDoneCQC", true )	
		elseif( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0680") == true ) then
			TppRadio.PlayEnqueue( "Miller_RestrictAdvice" )
		end
	end
end


this.Radio_RePazChicoAdvice = function()
	local sequence = TppSequence.GetCurrentSequence()

	
	if ( sequence == "Seq_NextRescuePaz" ) then				
		TppRadio.PlayEnqueue("Miller_ReChicoAdvice")
	elseif ( sequence == "Seq_NextRescueChico" ) then		

	else
	end
end


this.EndTapeReAdvice = function()
	
	TppRadio.RegisterOptionalRadio( "Optional_RVChicoToRescuePaz" )	
end


this.Check_AlertTapeReAdvice = function()
	local phase = TppEnemy.GetPhase( this.cpID )
	if ( phase == "alert" ) then
		TppMission.SetFlag( "isAlertTapeAdvice", true )
	else
		this.EndTapeReAdvice()
	end
end

this.Radio_AlertTapeReAdvice = function()
	if( TppMission.GetFlag( "isQuestionChico" ) == true ) then	
		TppRadio.Play("Miller_ChicoTapeAdvice02", { onEnd = this.EndTapeReAdvice } )
	else														
		TppRadio.Play("Miller_ChicoTapeReAdvice")
	end
end



this.Timer_PlayerOnHeliAdviceStart = function()
	local timer = 5
	GkEventTimerManager.Start( "Timer_PlayerOnHeliAdvice", timer )
end


this.Radio_PlayerOnHeliAdvice = function()
	TppRadio.Play("Miller_PlayerOnHeliAdvice")
end


this.Common_CarryHostageOnHeli = function()
	GkEventTimerManager.Stop( "Timer_PlayerOnHeliAdvice" )
end


this.OptionalRadio_InOldAsylum = function()
	
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0070") == false and radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0080") == false ) then
		TppRadio.RegisterOptionalRadio( "Optional_InOldAsylum" )
	else
		TppRadio.RegisterOptionalRadio( "Optional_DiscoveryChico" )
	end
end


this.OptionalRadio_OutOldAsylum = function( optRadioID )
	
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg0180") == true ) then
		TppRadio.RegisterOptionalRadio( "Optional_DiscoveryPaz" )			
	elseif( radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0070") == false and radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0080") == false ) then
		TppRadio.RegisterOptionalRadio( optRadioID )
	end
end

this.HostageWarp_FrontGateArmorVehicle = function()

	local pos = Vector3( -111.743 , 31.080 , 22.037 )
	local size = Vector3( 11.0 , 10.0 , 7.0 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp( "Chico" , "HW_Chico_FrontGateArmorVehicle" )
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_SpHostage_FrontGateArmorVehicle")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_FrontGateArmorVehicle")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_FrontGateArmorVehicle")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_FrontGateArmorVehicle")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_FrontGateArmorVehicle")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_FrontGateArmorVehicle")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_EastCampVehicle01 = function()

	local pos = Vector3( -33.052 , 27.140 , 190.926 )
	local size = Vector3( 5 , 6 , 4 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp( "Chico" , "HW_Chico_EastCampVehicle01" )
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_EastCampVehicle01")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp( "SpHostage" , "HW_SpHostage_EastCampVehicle01" )
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp( "Hostage_e20010_001" , "HW_Hostage01_EastCampVehicle01" )
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp( "Hostage_e20010_002" , "HW_Hostage02_EastCampVehicle01" )
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp( "Hostage_e20010_003" , "HW_Hostage03_EastCampVehicle01" )
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp( "Hostage_e20010_004" , "HW_Hostage04_EastCampVehicle01" )
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_EastCampTruck = function()

	local pos = Vector3( -24.640 , 25.364 , 113.673 )
	local size = Vector3( 10 , 4 , 7 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp( "Chico" , "HW_Chico_EastCampTruck" )
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_EastCampTruck")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp( "SpHostage" , "HW_SpHostage_EastCampTruck" )
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_EastCampTruck")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_EastCampTruck")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_EastCampTruck")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_EastCampTruck")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_CarryWeaponTruck = function()

	local pos = Vector3( -139.098 , 27.944 , 177.126 )
	local size = Vector3( 10 , 8 , 5 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp( "Chico" , "HW_Chico_CarryWeaponTruck" )
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_CarryWeaponTruck")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_CarryWeaponTruck")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_CarryWeaponTruck")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_CarryWeaponTruck")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_CarryWeaponTruck")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_CarryWeaponTruck")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_OpenGateTruck01 = function()

	local pos = Vector3( -14.309 , 26.228 , 112.424 )
	local size = Vector3( 4 , 6 , 8 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp( "Chico" , "HW_Chico_GateOpenTruck01" )
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_GateOpenTruck01")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_GateOpenTruck01")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_GateOpenTruck01")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_GateOpenTruck01")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_GateOpenTruck01")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_GateOpenTruck01")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_OpenGateTruck02 = function()

	local pos = Vector3( -74.926 , 31.080 , 16.313 )
	local size = Vector3( 12 , 6 , 8 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_SpHostage_GateOpenTruck02")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_GateOpenTruck02")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_OpenGateTruck02")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_OpenGateTruck03 = function()

	local pos = Vector3( -133.609 , 31.071 , 17.321 )
	local size = Vector3( 6 , 6 , 8 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_Chico_GateOpenTruck03")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_GateOpenTruck03")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_GateOpenTruck03")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_GateOpenTruck03")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_GateOpenTruck03")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_GateOpenTruck03")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_GateOpenTruck03")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_CenterOutVehicle01 = function()

	local pos = Vector3( -181.6569 , 31.071 , 11.82651 )
	local size = Vector3( 5 , 6 , 6 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_Chico_CenterOutVehicle01")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_CenterOutVehicle01")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_CenterOutVehicle01")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_CenterOutVehicle01")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_CenterOutVehicle01")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_CenterOutVehicle01")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_CenterOutVehicle01")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_CenterOutVehicle02 = function()

	local pos = Vector3( 34.867 , 17.141 , 218.102 )
	local size = Vector3( 4 , 6 , 5 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_Chico_CenterOutVehicle02")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_CenterOutVehicle02")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_CenterOutVehicle02")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_WareHouseArmorVehicle = function()

	local pos = Vector3( -112.754 , 27.944 , 158.058 )
	local size = Vector3( 6 , 8 , 8 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_Chico_WareHouseArmorVehicle")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_WareHouseArmorVehicle")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_WareHouseArmorVehicle")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_WareHouseArmorVehicle")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_WareHouseArmorVehicle")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_WareHouseArmorVehicle")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_WareHouseArmorVehicle")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_AsylumVehicle = function()

	local pos = Vector3( 46.939 , 16.911 , 182.370 )
	local size = Vector3( 5 , 8 , 4 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_Chico_CenterOutVehicle02")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_CenterOutVehicle02")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_CenterOutVehicle02")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_CenterOutVehicle02")
				end
			else
			end
		end
	else
	end
end

this.HostageWarp_HeliPortFrontGateArmorVehicle = function()

	local pos = Vector3( -88.168 , 31.080 , 19.823 )
	local size = Vector3( 8 , 8 , 10 )
	local npcIds = TppNpcUtility.GetNpcByBoxShape( pos , size )

	if npcIds and #npcIds.array > 0 then
		for i,id in ipairs(npcIds.array) do
			local type = TppNpcUtility.GetNpcType( id )
			if type == "Hostage" then
				local characterId = TppCharacterUtility.GetCharacterIdFromUniqueId( id )
				if( characterId =="Chico" )then
					TppEnemy.Warp("Chico", "HW_Chico_GateOpenTruck02")
				elseif( characterId =="Paz" )then
					TppEnemy.Warp("Paz", "HW_Paz_GateOpenTruck02")
				elseif( characterId =="SpHostage" )then
					TppEnemy.Warp("SpHostage", "HW_SpHostage_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_001" )then
					TppEnemy.Warp("Hostage_e20010_001", "HW_Hostage01_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_002" )then
					TppEnemy.Warp("Hostage_e20010_002", "HW_Hostage02_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_003" )then
					TppEnemy.Warp("Hostage_e20010_003", "HW_Hostage03_GateOpenTruck02")
				elseif( characterId =="Hostage_e20010_004" )then
					TppEnemy.Warp("Hostage_e20010_004", "HW_Hostage04_GateOpenTruck02")
				end
			else
			end
		end
	else
	end
end

this.Common_SecurityCameraBroken = function()
	local characterID = TppData.GetArgument( 1 )

	TppRadio.RegisterIntelRadio( characterID, "e0010_esrg0471", true )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap_SecurityCameraAdvice", "Radio_SecurityCameraAdvice", false , false )
end

this.Common_SecurityCameraPowerOff = function()
	local characterID = TppData.GetArgument( 1 )

	TppRadio.RegisterIntelRadio( characterID, "e0010_esrg0471", true )
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap_SecurityCameraAdvice", "Radio_SecurityCameraAdvice", false , false )
end

this.Common_SecurityCameraPowerOn = function()
	local characterID = TppData.GetArgument( 1 )
	TppRadio.EnableIntelRadio( characterID)
	TppRadio.RegisterIntelRadio( characterID, "e0010_esrg0470", true )
end

this.Common_SecurityCameraAlert = function()
	TppDataUtility.SetEnableDataFromIdentifier( "e20010_Trap_SecurityCameraAdvice", "Radio_SecurityCameraAdvice", false , false )
end


this.Radio_SecurityCameraAdvice = function()
	local phase = TppEnemy.GetPhase( this.cpID )
	if ( phase == "alert" ) then
	else
		TppRadio.Play( "Miller_SecurityCameraAdvice" )
	end
end


this.Radio_CarryDownInDanger = function()
	if( TppMission.GetFlag( "isHostageOnVehicle") == false and
		TppMission.GetFlag( "isHeliLandNow" ) == false ) then
		TppRadio.DelayPlayEnqueue("Miller_CarryDownInDanger", "short")
	end
	TppMission.SetFlag( "isHostageOnVehicle", false )
end


this.Common_HostageOnVehicleInDangerArea = function()
	local VehicleID = TppData.GetArgument( 3 )

	if( VehicleID == "SupportHelicopter" ) then
		
	else
		if( TppMission.GetFlag( "isDangerArea" ) == true ) then
			TppMission.SetFlag( "isHostageOnVehicle", true )
		end
	end
end




this.Chico_Espion = function()
	if( TppMission.GetFlag( "isPlaceOnHeliChico" ) == false ) then
		local sequence = TppSequence.GetCurrentSequence()

		
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Chico" }
		TppMarker.Enable( "20010_marker_ChicoPinpoint" , 0 , "moving" , "all" , 0 , false )
		TppMarker.Enable( "Chico" , 0 , "none" , "map_and_world_only_icon" , 0 , true )

			
			if( TppMission.GetFlag( "isChicoMarkJingle" ) == false ) then
				GZCommon.CallSearchTarget()
				TppMission.SetFlag( "isChicoMarkJingle", true )
			end
		
		if ( sequence == "Seq_RescueHostages" ) then
			TppRadio.RegisterIntelRadio( "SL_WoodTurret05", "e0010_esrg0010", true )	
			TppRadio.RegisterOptionalRadio( "Optional_DiscoveryChico" )					
		end
	end
end

this.Paz_Espion = function()
	if( TppMission.GetFlag( "isPlaceOnHeliPaz" ) == false ) then
					
		
		TppMarkerSystem.DisableMarker{ markerId = "20010_marker_Paz" }
		TppMarker.Enable( "Paz" , 0 , "none" , "map_and_world_only_icon" , 0 , true )

			
			if( TppMission.GetFlag( "isPazMarkJingle" ) == false ) then
				GZCommon.CallSearchTarget()
				TppMission.SetFlag( "isPazMarkJingle", true )
			end

		TppRadio.RegisterOptionalRadio( "Optional_DiscoveryPaz" )
		TppRadio.RegisterIntelRadio( "intel_e0010_esrg0100", "e0010_esrg0101", true )
	end
end




this.getDemoStartPos = function( demoId )



	if( demoId ~= nil )then



		local body = DemoDaemon.FindDemoBody( demoId )
		local data = body.data
		local controlCharacters = data.controlCharacters
		for k, controlCharacter in pairs(controlCharacters) do
			local characterId = controlCharacter.characterId



			local translation = controlCharacter.startTranslation



			local rotation = controlCharacter.startRotation



			
			if( characterId == "Player")then

				local direction = rotation:Rotate( Vector3( 0.0, 0.0, 1.0 ) )
				local angle = foxmath.Atan2( direction:GetX(), direction:GetZ() )
				local degree = foxmath.RadianToDegree( angle )

				return translation, degree
			end
		end
	end
end







this.Mb_WatchPhoto = function()
	local photLookFunc = {
		onEnd = function()
			local radioDaemon = RadioDaemon:GetInstance()
			if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1410") == true 
				and radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1420") == true ) then
				
				TppRadio.DelayPlayEnqueue( "Miller_WatchPhotoAll", "short", "end" )
			else
				
				TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
			end
		end,
	}

	local photoID = TppData.GetArgument( 1 )



	local radioDaemon = RadioDaemon:GetInstance()
	local watchFirst = false
	if( radioDaemon:IsRadioGroupMarkAsRead("e0010_rtrg1429") == false ) then
		
		TppRadio.DelayPlayEnqueue( "Miller_WatchPhotoStart", "short", "end" )
		watchFirst = true
	end

	local RadioName
	if( photoID == 30 ) then
		RadioName = "Miller_WatchPhotoPaz"
	else
		RadioName = "Miller_WatchPhotoChico"
	end

	if watchFirst == true then
		TppRadio.DelayPlayEnqueue( RadioName, "short", "begin", photLookFunc )
	else
		TppRadio.DelayPlay( RadioName, "short", "begin", photLookFunc )
	end
end

this.Timer_SC_Vehicle_Clean = function()
	local vehicleObj = Ch.FindCharacterObjectByCharacterId("Tactical_Vehicle_WEST_002")
	vehicleObj:CleanDriver()
end

this.Timer_EC_Truck_Clean = function()
	local vehicleObj = Ch.FindCharacterObjectByCharacterId("Cargo_Truck_WEST_003")
	vehicleObj:CleanDriver()
end

this.Timer_Weapon_Truck_Clean = function()
	local vehicleObj = Ch.FindCharacterObjectByCharacterId("Cargo_Truck_WEST_002")
	vehicleObj:CleanDriver()
end

this.Timer_Gate_Truck_Clean = function()
	local vehicleObj = Ch.FindCharacterObjectByCharacterId("Cargo_Truck_WEST_004")
	vehicleObj:CleanDriver()
end

this.Timer_ToAsylum_Vehicle_Clean = function()
	local vehicleObj = Ch.FindCharacterObjectByCharacterId("Tactical_Vehicle_WEST_005")
	vehicleObj:CleanDriver()
end

this.Timer_Patrol_Vehicle_Clean = function()
	local vehicleObj = Ch.FindCharacterObjectByCharacterId("Tactical_Vehicle_WEST_003")
	vehicleObj:CleanDriver()
end

this.Timer_CallCautionSiren = function()
	GZCommon.CallCautionSiren()
	
	TppMusicManager.SetSwitch{
		groupName = "bgm_phase_ct_level",
		stateName = "bgm_phase_ct_level_02",
	}
end

this.Radio_RescuePaz1Timer = function()
	local timer = 600
	GkEventTimerManager.Start( "Timer_RescuePaz1", timer )
end
this.Radio_RescuePaz1TimerStop = function()
	GkEventTimerManager.Stop( "Timer_RescuePaz1" )
end
this.Radio_RescuePaz1 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		TppRadio.Play("Miller_RescuePaz1")
	end
end


this.Radio_RescuePaz2Timer = function()
	local timer = 900
	GkEventTimerManager.Start( "Timer_RescuePaz2", timer )
end
this.Radio_RescuePaz2TimerStop = function()
	GkEventTimerManager.Stop( "Timer_RescuePaz2" )
end
this.Radio_RescuePaz2 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		TppRadio.Play("Miller_RescuePaz2")
	end
end


this.Radio_MillerHistory1 = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		TppRadio.DelayPlay( "Miller_MillerHistory1", "mid" )
	end
end


this.Radio_GetPazInfo = function()

end


this.Radio_ListenTape = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if ( radioDaemon:IsPlayingRadio() == false ) then
		TppRadio.Play( "Miller_TapeReaction07" )
	end
end


this.Radio_DramaPaz = function()
	TppMission.SetFlag( "isDramaPazArea", true )

	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
	if( VehicleId == "" ) then
		TppRadio.DelayPlayEnqueue( "Miller_DramaPaz1", "long", "begin", {onEnd = function()
				local radioDaemon = RadioDaemon:GetInstance()
				if ( radioDaemon:IsPlayingRadio() == false ) then
					if( TppMission.GetFlag( "isDramaPazArea") == true ) then
						TppRadio.Play( "Miller_DramaPaz2", nil, nil, nil, "end" )
					else
						TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
					end
				end
		end}, nil )
	end
end

this.Radio_DramaChico = function()
	TppMission.SetFlag( "isAsylumRadioArea", true )


	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()
	if( VehicleId == "" ) then
		TppRadio.Play( "Miller_DramaChico", {onEnd = function()
				local radioDaemon = RadioDaemon:GetInstance()
				if ( radioDaemon:IsPlayingRadio() == false ) then
					if( TppMission.GetFlag( "isAsylumRadioArea") == true ) then
						TppRadio.Play( "Miller_Drama2Chico", nil, nil, nil, "end" )
					else
						TppSoundDaemon.PostEvent( "Play_sfx_s_codec_NPC_end" )
					end
				end
		end}, nil, nil, "begin" )
	end
end


this.Radio_StartCliffTimer = function()
	if( TppMission.GetFlag( "isDoCarryAdvice" ) == false ) then
		local timer = 5
		GkEventTimerManager.Start( "Timer_StartCliff", timer )
	end
end

this.Radio_StartCliff = function()
	local radioDaemon = RadioDaemon:GetInstance()
	if( radioDaemon:IsPlayingRadio() == false and
		TppMission.GetFlag( "isHeliComingRV" ) == false ) then
		TppRadio.PlayEnqueue("Miller_MillerHistory2")
	end
end


this.playerNearCheck = function( characterID )





	local pos		= TppPlayerUtility.GetLocalPlayerCharacter():GetPosition()	
	local size		= Vector3( 20, 12, 20 )										
	local rot		= Quat( 0.0 , 0.0, 0.0, 0.0 )								
	local npcIds	= TppNpcUtility.GetNpcByBoxShape( pos, size, rot )

	
	local charaObj = Ch.FindCharacterObjectByCharacterId( characterID )
	if Entity.IsNull( charaObj ) then



		return false
	end
	local chara = charaObj:GetCharacter()
	local uniqueId = chara:GetUniqueId()

	
	if( npcIds and #npcIds.array > 0 ) then
		for i,id in ipairs(npcIds.array) do



			
			if ( id == uniqueId ) then
				return true
			end
		end
	end

	return false

end

this.Radio_DiscoveryPaz = function()

	local radioDaemon = RadioDaemon:GetInstance()
	local phase = TppEnemy.GetPhase( this.cpID )
	if ( phase == "alert" or phase == "evasion" ) then
	else
		if( radioDaemon:IsRadioGroupMarkAsRead("e0010_esrg0100") == false ) then
			TppRadio.Play( "Miller_DiscoveryPaz", { onEnd = function()
				TppRadio.RegisterOptionalRadio( "Optional_DiscoveryPaz" )
				TppRadio.RegisterIntelRadio( "intel_e0010_esrg0100", "e0010_esrg0101", true )
			end} )
		end
	end

end






this.Common_PlayListenTape = function()
	local CassetteId = TppData.GetArgument(1)

	if ( CassetteId == "tp_chico_03" and TppMission.GetFlag( "isChicoTapePlay" ) == false ) then
	
		TppMission.SetFlag( "isChicoTapePlay", true )
	else
	end
end


this.SpHostageStatus = function()

	if( TppMission.GetFlag( "isCarryOnSpHostage" ) == false ) and			
		( TppMission.GetFlag( "isSpHostage_Dead" ) == false ) and			
		( TppMission.GetFlag( "isPlaceOnHeliSpHostage" ) == false ) then	
		KillWaiting_SpHostahe_EnemyPos()								
	else
		NoKillWaiting_SpHostahe_EnemyPos()								
	end
end




this.Seq20_Interrogation = function()
	
	if( TppMission.GetFlag( "isInterrogation_Radio" ) == true ) then
		local CountInterrogation = TppMission.GetFlag( "isInterrogation_Count" )
		
		TppMission.SetFlag( "isInterrogation_Count", ( CountInterrogation + 1 ) )
		CountInterrogation = CountInterrogation + 1






		if( CountInterrogation == 1 ) then



			TppEnemyUtility.UnsetInterrogationForceCharaIdAllCharacter()	
		elseif( CountInterrogation == 2 ) then



			TppEnemyUtility.SetInterrogationForceCharaIdAllCharacter( "PazHint_02" )	
		elseif( CountInterrogation == 3 ) or ( CountInterrogation == 4 ) then



			TppEnemyUtility.UnsetInterrogationForceCharaIdAllCharacter()	
		elseif( CountInterrogation == 5 ) then



			TppEnemyUtility.SetInterrogationForceCharaIdAllCharacter( "PazHint_03" )	
		elseif( CountInterrogation == 6 ) then



			TppEnemyUtility.UnsetInterrogationForceCharaIdAllCharacter()	
		end
	else
		



	end
end

this.Common_interrogation_B = function()
	local hudCommonData = HudCommonDataManager.GetInstance()
	

	
	TppMarker.Enable( "20010_marker_Paz", 2 , "moving" , "all" , 0 , true , true )
	
	hudCommonData:AnnounceLogViewLangId( "announce_mission_info_update" )
	
	commonUiMissionSubGoalNo(5)
	
	TppRadio.RegisterOptionalRadio( "Optional_ChicoOnHeli" )		
	
	TppRadio.DelayPlay( "Miller_GetPazInfo", "long" )
	
	this.Radio_RescuePaz1TimerStop()
	this.Radio_RescuePaz2TimerStop()
	
	TppMission.SetFlag( "isAlertTapeAdvice", false )
end

this.NextRescuePaz_DiscoveryPaz = function()
	TppMission.SetFlag( "isAlertTapeAdvice", false )
	TppRadio.RegisterOptionalRadio( "Optional_DiscoveryPaz" )
	
	this.Radio_RescuePaz1TimerStop()
	this.Radio_RescuePaz2TimerStop()
end



this.PazCarryStart = function()

	local phase = TppEnemy.GetPhase( this.cpID )
	TppMission.SetFlag( "isPazChicoDemoArea", false )

	if ( phase == "alert" ) then
		
	else
		if( TppMission.GetFlag( "isChicoPaz1stCarry" ) == false ) then
			TppMusicManager.PostJingleEvent( 'SuspendPhase', 'Play_bgm_e20010_jingle_rescue' )
			TppMission.SetFlag( "isChicoPaz1stCarry", true )
		else
		end
	end
end

return this
