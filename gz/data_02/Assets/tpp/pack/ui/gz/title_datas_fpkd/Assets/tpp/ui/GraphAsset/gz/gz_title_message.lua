gz_title_message = {

events = {
	GzTitleMessage = {
 		InitGzTitle		= "OnInitGzTitle",
		
		TitleGo = "standUp",
		
		TitleSelectMenu		= "missionSelectMenu",
		TitleMission 		= "missionMode",
		TitleMissionUp	 	= "missionUp",
		TitleMissionDown 	= "missionDown",
		TitleBlackOut		= "blackOut",
		TitleShuffle		= "kantokuShuffle",
	},
	kantoku = {
		PlayEnd = "loopMotionKantoku",
		MotionEvent = "shuffleCommand"
	},
	sneak = {
		PlayEnd = "loopMotionSneak",
		MotionEvent = "missionSelectMotion"
	},
},
titleTabacco = false,
titlePhase = 0,



kantokuFlag  = 0, 
kantokuVisible = false,


OnInitGzTitle = function( data, body, sender, id, arg1, arg2, arg3, arg4 )
	Fox.Log( "=== OnInitGzTitle !!!===" )
	Fox.Log(":: init ::")

	
	TppPlayerUtility.ChangeLocalPlayerType("PLTypeSneakingSuit")

	
	local lastMissionId = 0
	local isClear 	= "notClear"
	local hour 		= 0
	local minute 	= 0
	local time 		= "night" 		
	local weather 	= 0 			
	local colorCorrectionLUTPath = "ombs_demo_r1_FILTERLUT"
	local lightGroup = "nightR"
	local tobacco 	= false		
	local medic		= true		
	local bloodType = false		
	local kantoku 	= false
	local lowPoly = false
	local soundEvent = "Set_RTPCs_title_e20010"
	local skyLuminance = 0.5

	
	Fox.Log(":: get missionID ::")

	local getLastMissionId = MissionManager.GetLastMissionId()
	local getClear = MissionManager.GetLastClearedMissionId()

	Fox.Log("getLastMissionId = "..getLastMissionId)
	Fox.Log("getClear = "..getClear)

	
	if ( getLastMissionId == 0 or getLastMissionId == nil ) then
		Fox.Log( "Starting GZ fist time :: lastMissionID is 0" )
	else
		lastMissionId = getLastMissionId
		Fox.Log("Get!! lastMissionId = "..lastMissionId )
	end

	
	if ( getClear ~= 0 ) then
		
		isClear = "Clear"
	end

	Fox.Log(":: get setting data ::")

	
	
	if ( lastMissionId == 20015) then	
		time = "morning"
		weather = 0
		medic = false			
		bloodType = true		
		soundEvent = "Set_RTPCs_title_e20015"
	elseif (lastMissionId == 20020) then	
		time = "afternoon"
		weather = 0
		soundEvent = "Set_RTPCs_title_e20020"
	elseif (lastMissionId == 20030) then	
		time = "evening"
		weather = 0
		soundEvent = "Set_RTPCs_title_e20030"
	elseif (lastMissionId == 20040) then	
		time = "afternoon"
		weather = 1
		soundEvent = "Set_RTPCs_title_e20040"
		if( isClear == "Clear" ) then
			kantoku = true
		end
	elseif (lastMissionId == 20050) then	
		time = "afternoon"
		weather = 0
		soundEvent = "Set_RTPCs_title_e20050"
	elseif (lastMissionId == 20060 or lastMissionId == 20070 ) then	
		time = "night"
		weather = 1
		
		if ( isClear == "Clear") then
			soundEvent = "Set_RTPCs_title_e20065"
		else
			soundEvent = "Set_RTPCs_title_e20060"
		end

	else	
		if ( isClear == "Clear") then
			time = "night"
			weather = 0
		else
			time = "nightR"	
			weather = 5
		end

	end

	Fox.Log("Time = "..time..", : Weather = "..weather)

	
	if (isClear == "Clear") then
		
		gz_title_message.titleTabacco = true
		Fox.Log(":: tabacco is true")
	end

	Fox.Log(":: get setting data light and colorCorrection::")

	
	if ( time == "morning") then
		lightGroup = "Group12_00"
		hour = 5
		minute = 31
		skyLuminance = 600
	elseif ( time == "afternoon") then
		lightGroup = "Group12_00"
		hour = 12
		minute = 0
		skyLuminance = 2000
	elseif ( time == "evening") then
		colorCorrectionLUTPath = "mtbs_midd_FILTERLUT"
		lightGroup = "Group17_00"
		hour = 18
		minute = 20
		skyLuminance = 2000
	elseif ( time == "night") then
		lightGroup = "Group00_00"
		hour = 0
		minute = 0
		skyLuminance = 0.5
	elseif ( time == "nightR") then
		lightGroup = "Group00_00R"
		hour = 0
		minute = 0
		skyLuminance = 0.5
	end

	Fox.Log("Get time="..hour..":"..minute.." - light = "..lightGroup)


	

	Fox.Log(":: set data :: ")

	
	
	TppDemoPuppet.SetModelVisible("title_lowPoly", false)

	
	

	if ( bloodType == true ) then
		Fox.Log(":: set blood fova ::")
		TppCharacterUtility.ChangeFormVariationWithCharacterId("title_sneak", "fova1", 0)
		TppDemoPuppet.SetMeshVisible("title_sneak", "MESH_cheek_blood_ST_OL0_NSW", true) 
		TppDemoPuppet.SetMeshVisible("title_sneak", "MESH_hige1_blood_ST_OL1_NSW", true)
		TppDemoPuppet.SetMeshVisible("title_sneak", "MESH_hige2_blood_ST_OL1_NSW", true)
	end
	
	
	if( gz_title_message.titleTabacco == true )then
		
		Fox.Log(":: set tobacco and tobacco motion::")
		TppDemoPuppet.CreateAttachmentAndAttachToMtp("title_sneak","cig","MTP_RHAND_A")
		TppDemoPuppet.CreateAttachmentPartsEffect("title_sneak", "cig", "CigarSmoke" )
		TppDemoPuppet.SetAttachmentMeshVisible("title_sneak", "cig", "MESH_FIRE_IV", true )
		TppDemoPuppet.SetAttachmentMeshVisible("title_sneak", "cig", "MESH_NORMAL_DEF", false)
		
		local cigaretteSmokeManager = TppCigaretteSmokeGlobalManager:GetInstance()
		if cigaretteSmokeManager then
			Fox.Log("creat Cig")
			cigaretteSmokeManager:SetBaseColorSmoke( 1.0, 1.0, 1.0, 0.9 ) 
		end
		
		if( medic == false)then
			
			TppDemoPuppet.SetMotion("title_sneak","sneak_tobaccoIdle","m_cigIdle","m_cigIdle2","m_cigIdle3",5)
		else
			
			TppDemoPuppet.SetMotion("title_sneak","sneak_tobaccoIdle","m_cigIdle","m_cigIdle1","m_cigIdle2","m_cigIdle3",5)
		end
	else
		
		Fox.Log(":: set sneak normal motion ::")
		TppDemoPuppet.SetMotion("title_sneak","sneak_Idle","defaultMotion","m_idle1","m_idle2","m_idle3",5)

	end
	
	Fox.Log(":: set sneak position ::")
	TppDemoPuppet.AttachMtpToCharacterCnp("title_sneak", "MTP_GLOBAL_C", "title_heli", "CNP_pos_rfr" )

	
	if( medic == false)then
		Fox.Log(":: set disable medic ::")
		TppDemoPuppet.SetModelVisible("title_medic", false)
	else
		
		Fox.Log(":: set medic position and motion ::")
		TppDemoPuppet.AttachMtpToCharacterCnp("title_medic", "MTP_GLOBAL_C", "title_heli", "CNP_pos_rbl")
		TppDemoPuppet.SetMotionByRandom("title_medic","medic_idle","defaultMotion","m_random", 8)
	end

	
	if (kantoku == false) then
		Fox.Log(":: set disable kantoku ::")
		TppDemoPuppet.SetModelVisible("title_kantoku", false)
		gz_title_message.kantokuVisible = false
	else
		
		Fox.Log(":: set kantoku poisition ::")
		gz_title_message.kantokuVisible = true
		TppDemoPuppet.AttachMtpToCharacterCnp("title_kantoku", "MTP_GLOBAL_C", "title_heli", "CNP_pos_rfl")
		TppDemoPuppet.SetMeshVisible("title_kantoku", "MESH_globe_3finger", false)	
		TppDemoPuppet.SetMeshVisible("title_kantoku", "MESH_code", false)			
		TppDemoPuppet.SetMeshVisible("title_kantoku", "MESH_headset", false)		
		TppDemoPuppet.SetMeshVisible("title_kantoku", "MESH_globe_5finger_IV", true)
		TppDemoPuppet.SetMotion("title_kantoku","kantoku_toIdle","defaultMotion")
	end

	
	
	TppDataUtility.SetEnableDataFromIdentifier( "id_dlcTitleLight", "Group00_00", false )
	TppDataUtility.SetEnableDataFromIdentifier( "id_dlcTitleLight", "Group12_00", false )
	TppDataUtility.SetEnableDataFromIdentifier( "id_dlcTitleLight", "Group17_00", false )
	TppDataUtility.SetEnableDataFromIdentifier( "id_dlcTitleLight", "Group00_00R", false )

	TppDataUtility.SetEnableDataFromIdentifier( "id_dlcTitleLight", lightGroup, true )
	
	TppEffectUtility.SetColorCorrectionLut( colorCorrectionLUTPath )

	
	if(weather == 5)then
		
		Fox.Log("Effect enable Sky,Thuonder - rain")
		TppDataUtility.SetEnableDataFromIdentifier( "id_dlcTitleEffect", "TppWeatherThunder0000", true )
		TppWeatherEffectManager.SetWeatherThunderAutoGeneration(true)
	else
		
		Fox.Log("Off Thunder")
		TppWeatherEffectManager.SetWeatherThunderAutoGeneration(false)
	end
	if(weather ~= 5)then
		
		Fox.Log("Effect disable rain - not rain")
		TppEffect.HideEffect("fx_rain_001")
		TppEffect.HideEffect("fx_rain_002")
		TppEffect.HideEffect("fx_rain_003")
		TppEffect.HideEffect("fx_rain_004")
		TppEffect.HideEffect("fx_rain_005")
		TppEffect.HideEffect("fx_rain_006")
	end

	if(time == "afternoon" or time == "morning")then
		
		Fox.Log("Effect enable sunshine - afternoon")
		TppEffect.ShowEffect("fx_afternoon_001")
		TppEffect.ShowEffect("fx_afternoon_002")
		TppEffect.ShowEffect("fx_afternoon_003")
		TppEffect.ShowEffect("fx_afternoon_004")
		TppEffect.ShowEffect("fx_afternoon_005")
		TppEffect.ShowEffect("fx_afternoon_006")
		TppEffect.ShowEffect("fx_afternoon_007")
		TppEffect.ShowEffect("fx_afternoon_008")
	end

	if(time == "evening")then
		
		Fox.Log("Effect enable sunshine - evening")
		TppEffect.ShowEffect("fx_yugata")
	end
	
	
	Fox.Log("set weahter")
	WeatherManager.RequestTag("title", 0 )
	WeatherManager.SetCurrentClock( hour, minute )
	WeatherManager.PauseClock(true)
	WeatherManager.RequestWeather(weather,0) 
	
	Fox.Log( "Sky Luminunce = "..skyLuminance )
	TppEffectUtility.SetLuminanceScaleTppSkyClouds3( skyLuminance )

	
	local commonDataManager = UiCommonDataManager.GetInstance()
	commonDataManager:GzTitlePreSetting( 0.168, 1.1)

	
	Fox.Log(": set sound event :")
	Fox.Log(soundEvent)
	TppSoundDaemon.PostEvent(soundEvent)

	Fox.Log( "PlatformConfiguration.SetVideoRecordingEnabled(true)" )
	PlatformConfiguration.SetVideoRecordingEnabled(true)	

	Fox.Log( "=== OnInitGzTitle !!! END ===" )

end,




blackOut = function(data, body, sender, id, arg1, arg2, arg3, arg4)
	Fox.Log(":: BLACK OUT !! ::")


	Fox.Log("unset sneak")
	
	gz_title_message.titleTabacco = false	
	TppDemoPuppet.SetMotion("title_sneak","sneak_Idle","defaultMotion") 
	TppDemoPuppet.DeleteAttachment("title_sneak", "cig")
	TppDemoPuppet.SetModelVisible("title_sneak", false)

	
	Fox.Log("set lowPolyl motion")
	TppDemoPuppet.SetModelVisible("title_lowPoly", true)
	TppDemoPuppet.SetMotionByRandom("title_lowPoly","lowPoly_Idle","defaultMotion","m_idle1","m_idle2","m_idle3",5)
	TppDemoPuppet.AttachMtpToCharacterCnp("title_lowPoly", "MTP_GLOBAL_C", "title_heli", "CNP_pos_rfr" )
end,







standUp = function(data, body, sender, id, arg1, arg2, arg3, arg4)
		gz_title_message.titlePhase = 20

end,


missionSelectMotion = function(data, body, sender, id, arg1, arg2, arg3, arg4)
 	

	if (gz_title_message.titlePhase == 20 and arg1 == "MTEV_TITLE") then
		
		Fox.Log(":: standup Sneak ::")

		
		if( gz_title_message.titleTabacco == true )then
			TppDemoPuppet.SetMotion("title_sneak","sneak_standup","m_cigStandUp", { interpTime = 0.5 })
		else
			TppDemoPuppet.SetMotion("title_sneak","sneak_standup","m_standUp", { interpTime = 0.5})
		end
		
		TppDemoPuppet.SetMotion("title_lowPoly","lowPoly_standup","m_standUp", { interpTime = 0.5 })

		gz_title_message.titlePhase = 21
	end

	

	if (arg1 == "MTEV_Ashon") then
		Fox.Log( arg1.." Ash On" )
		
		TppDemoPuppet.CreateAttachmentAndAttachToMtp("title_sneak","pat","MTP_LHAND_A")
		TppDemoPuppet.CreateAttachmentAndAttachToMtp("title_sneak","pat2","MTP_LHAND_B")
	end
	if (arg1 == "MTEV_Ashoff") then
		Fox.Log( arg1.." Ash Off" )
		
		TppDemoPuppet.DeleteAttachment("title_sneak", "pat")
		TppDemoPuppet.DeleteAttachment("title_sneak", "pat2")
	end
	if (arg1 == "MTEV_Cigon") then
		Fox.Log( arg1.." Cig On" )
		
		TppDemoPuppet.CreateAttachmentAndAttachToMtp("title_sneak","cig","MTP_RHAND_A")
	end
	if (arg1 == "MTEV_Cigoff") then
		Fox.Log( arg1.." Cig Off" )
		
		TppDemoPuppet.DeleteAttachment("title_sneak", "cig")
	end

	
	if( gz_title_message.titleTabacco == true )then
		if (arg1 == "MTEV_Suu") then
			Fox.Log( arg1 )
			
			local cigaretteSmokeManager = TppCigaretteSmokeGlobalManager:GetInstance()
			if cigaretteSmokeManager then
				Fox.Log("set Cig Alpha")
				cigaretteSmokeManager:SetInitAlphaRate( 0.0, 1.0 ) 
			end

		end

		if (arg1 == "MTEV_SuiOwari") then
			Fox.Log( arg1 )
			
			local cigaretteSmokeManager = TppCigaretteSmokeGlobalManager:GetInstance()
			if cigaretteSmokeManager then
				Fox.Log("reset Cig Alpha")
				cigaretteSmokeManager:ResetInitAlphaRate( 1.0 ) 
			end
		end
	end
end,


loopMotionSneak = function(data, body, sender, id, arg1, arg2, arg3, arg4)
	
	
	Fox.Log(":: loop Sneak ::")
	Fox.Log(gz_title_message.titlePhase)

	if (gz_title_message.titlePhase == 0 or gz_title_message.titlePhase == 1) then
		Fox.Log("phase = 0")
		
		if( gz_title_message.titleTabacco == true )then
			
			TppDemoPuppet.SetMotion("title_sneak","sneak_tobaccoIdle","m_cigIdle","m_cigIdle1","m_cigIdle2","m_cigIdle3")
			Fox.Log("phase = 0 motion on tabacco")
		else
			TppDemoPuppet.SetMotion("title_sneak","sneak_Idle","defaultMotion","m_idle1","m_idle2","m_idle3")
			Fox.Log("phase = 0 motion not tabacco")
		end
	
		gz_title_message.titlePhase = 1
		Fox.Log("set phase = 1")

	elseif (gz_title_message.titlePhase == 10 or gz_title_message.titlePhase == 11) then
		Fox.Log("phase = 10")
		
		if( gz_title_message.titleTabacco == true )then
			
			TppDemoPuppet.SetMotion("title_sneak","sneak_tobaccoIdle","m_cigIdle","m_cigIdle2","m_cigIdle")
			Fox.Log("phase = 10 motion on tabacco")
		else
			TppDemoPuppet.SetMotion("title_sneak","sneak_Idle","defaultMotion","m_idle2","defaultMotion")
			Fox.Log("phase = 10 motion not tabacco")
		end
		gz_title_message.titlePhase = 11 
		Fox.Log("set phase = 11")
	end
end,


loopMotionKantoku = function(data, body, sender, id, arg1, arg2, arg3, arg4)
	
	
	Fox.Log(":: loop Kantoku ::")
	local checkId = arg1
	Fox.Log(checkId..":"..arg2)

	if( checkId == "kantoku_kamaeToIdle" )then
		if ( arg2 >= 3 ) then
			TppDemoPuppet.SetMotion("title_kantoku","kantoku_Idle","defaultMotion")
		end
	elseif( checkId == "kantoku_Idle")then
			TppDemoPuppet.SetMotion("title_kantoku","kantoku_Idle","defaultMotion")
	end
end,



shuffleCommand = function(data, body, sender, id, arg1, arg2, arg3, arg4)
	if( gz_title_message.kantokuVisible == true )then
		if (arg1 == "MTEV_TITLE") then
			if ( gz_title_message.kantokuFlag == 1) then
				gz_title_message.kantokuFlag = 0
				Fox.Log("Get motion event. Start shuffle.")
				TppDemoPuppet.SetMotion("title_kantoku","kantoku_kamaeToIdle","m_idle2kamae","m_slideIdle","m_slideStart","m_slideToIdle",{ interpTime = 0.2 })
				local uiCommonData = UiCommonDataManager.GetInstance()
				uiCommonData:GzTitleShuffle()
			end
		end
	end
end,


kantokuShuffle = function(data, body, sender, id, arg1, arg2, arg3, arg4)
	if(gz_title_message.kantokuVisible == true  )then
		
		Fox.Log(":: Shuffle FlagOn ::")
		gz_title_message.kantokuFlag = 1

	end
end,



missionSelectMenu = function(data, body, sender, id, arg1, arg2, arg3, arg4)
		gz_title_message.titlePhase = 0
		
end,


missionMode = function(data, body, sender, id, arg1, arg2, arg3, arg4)
		gz_title_message.titlePhase = 10 
		
end,


missionUp = function(data, body, sender, id, arg1, arg2, arg3, arg4)
		
end,


missionDown = function(data, body, sender, id, arg1, arg2, arg3, arg4)
		
end,

} 
