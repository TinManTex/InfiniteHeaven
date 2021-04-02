local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ]		= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ]	= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ]			= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_RECOVERED ]		= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.ABORT_BY_HELI ]			= TppRadio.IGNORE_COMMON_RADIO




this.radioList = {
	
	{"s0052_rtrg2010",	playOnce = true},


	"f1000_rtrg2560",	
	"f1000_rtrg1200",	
	
	"s0052_rtrg0020",	

	"s0052_rtrg1020",	
	"s0052_rtrg3080",	
	"s0052_rtrg3090",	
	"s0052_rtrg3100",	
	"s0052_rtrg4030",	

	"f1000_rtrg2580",	
	"f1000_rtrg1380",	
	"f1000_rtrg0030",	

	"f1000_rtrg2340",	
	"f1000_rtrg2320",	
	"f1000_rtrg2325",	
	"f1000_rtrg3150",	

	"s0052_rtrg1030",	
	"s0052_rtrg3110",	
	"s0052_rtrg3120",	
	"s0052_rtrg3130",	
	"s0052_rtrg3140",	
	"s0052_rtrg3150",	
	"f1000_rtrg2570",	
	"f1000_rtrg3160",	


	"f1000_rtrg1540",	

	
	"s0052_rtrg1010",	

	"s0052_rtrg3010",	
	"s0052_rtrg3030",	
	"s0052_rtrg3040",	
	"s0052_rtrg3020",	
	"s0052_rtrg3050",	

	"f1000_rtrg2210",	
	"f1000_rtrg2220",	
	"f1000_rtrg2230",	

	"f1000_rtrg2170",	
	"f1000_rtrg1210",	
	"f1000_rtrg0100",	

	
	
}



this.optionalRadioList = {
	"Set_s0052_oprg0100",	
	"Set_s0052_oprg0200",	
	"Set_s0052_oprg0300",	
	"Set_s0052_oprg0310",	
	"Set_s0052_oprg0320",	
	"Set_s0052_oprg0330",	
	"Set_s0052_oprg0400",	
	"Set_s0052_oprg0410",	
	"Set_s0052_oprg0420",	
	"Set_s0052_oprg0500",	
	"Set_s0052_oprg0600",	

	"Set_s0052_oprg0700",	
	"Set_s0052_oprg0710",	
	"Set_s0052_oprg0720",	

	"Set_s0052_oprg0730",	
	"Set_s0052_oprg0800",	
	"Set_s0052_oprg0810",	
	"Set_s0052_oprg0900",	
	"Set_s0052_oprg1000",	
	"Set_f1000_oprg0010",	
}




this.intelRadioList = {
	
	hos_target_0000						= "f1000_esrg0010",	





	sol_s10052_guardVehicle_0000		= "f1000_esrg1150",	
	veh_transportVehicle_0001			= "f1000_esrg1150",	
	sol_s10052_Executioner_tent_0000	= "Invalid",		
	
	
	erl_remnants						= "s0052_esrg1010",	
	erl_tent							= "s0052_esrg2010",	
}




this.blackTelephoneDisplaySetting = {
	f6000_rtrg0070 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10052/mb_photo_10052_010_1.ftex", 1,"cast_malak" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_02.ftex", 11.2 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_03.ftex", 30.2 }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_04.ftex", 34.2 }, 
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/10040/mb_photo_10040_010.ftex", 49.1 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_06.ftex", 49.4 }, 
			{ "hide", "main_2", 65.3 }, 
			{ "hide", "sub_2", 65.6 }, 
			{ "hide", "main_3", 65.9 }, 
			{ "hide", "main_4", 66.2 }, 
			{ "hide", "main_1", 80.1 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10052/mb_photo_10052_010_1.ftex", 1,"cast_malak" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_02.ftex", 10.3 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_03.ftex", 28.8 }, 
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_04.ftex", 32.5 }, 
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/10040/mb_photo_10040_010.ftex", 45.1 }, 
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10052_06.ftex", 45.4 }, 
			{ "hide", "main_2", 60.9 }, 
			{ "hide", "sub_2", 61.2 }, 
			{ "hide", "main_3", 61.5 }, 
			{ "hide", "main_4", 61.8 }, 
			{ "hide", "main_1", 73.4 }, 
		},
	},
}





this.ArrivedRemnants = function()
	Fox.Log("#### s10052_radio.ArrivedRemnants ####")
	TppRadio.Play( "s0052_rtrg2010" )
end


this.LetsActionInConversation = function()
	Fox.Log("#### s10052_radio.LetsActionInConversation #### isTargetMarked = "..tostring(svars.isTargetMarked))
	if ( not svars.isTargetRescue ) then

	end











end


this.RevelationTransportProject = function()
	Fox.Log("#### s10052_radio.RevelationTransportProject ####")
	TppRadio.Play( {"s0052_rtrg0020"}, {delayTime = "short"} )
end


this.HostageRecoverd = function()
	Fox.Log("#### s10052_radio.HostageRecoverd ####")
	TppRadio.Play( {"f1000_rtrg0100"}, {delayTime = "long"} )
end



this.ArrivedTent = function()
	Fox.Log("#### s10052_radio.ArrivedTent #### isTargetMarked = "..tostring(svars.isTargetMarked)..", infoCount = "..svars.infoCount)

	
	local radioId = "s0052_rtrg1020"	
	
	
	if ( svars.isTargetMarked ) then
		radioId = "s0052_rtrg4030"
		
	
	elseif ( svars.infoCount >= 3 ) then
		radioId = "s0052_rtrg3100"
		
	
	elseif ( svars.infoCount == 2 ) then
		radioId = "s0052_rtrg3090"
		
	
	elseif ( svars.infoCount == 1 ) then
		radioId = "s0052_rtrg3080"
		
	else
		
	end
	
	if not( svars.isArrivedTent ) then
		TppRadio.Play( radioId )
	end
end


this.ArrivedLZ = function()
	Fox.Log("#### s10052_radio.ArrivedLZ ####")
	TppRadio.Play( "f1000_rtrg2580" )
end


this.BeforeClear = function()
	Fox.Log("#### s10052_radio.BeforeClear ####")
	TppRadio.Play( "f1000_rtrg1380" )
end


this.NoInfoFromIF = function(getInfoFrom)
	Fox.Log("#### s10052_radio.NoInfoFromIF #### ")
	TppRadio.Play( "f1000_rtrg1540" )
end




this.AfterContinue_BeforeGetInfo = function()
	Fox.Log("#### s10052_radio.AfterContinue_BeforeGetInfo ####")
	TppRadio.Play( "s0052_rtrg1030" )
end


this.AfterContinue_GetInfo1_WithoutEnemy = function()
	Fox.Log("#### s10052_radio.AfterContinue_GetInfo1_WithoutEnemy ####")
	TppRadio.Play( "s0052_rtrg3110" )
end


this.AfterContinue_GetInfo1_WithoutFile = function()
	Fox.Log("#### s10052_radio.AfterContinue_GetInfo1_WithoutFile ####")
	TppRadio.Play( "s0052_rtrg3120" )
end


this.AfterContinue_GetInfo1_WithoutHostage = function()
	Fox.Log("#### s10052_radio.AfterContinue_GetInfo1_WithoutHostage ####")
	TppRadio.Play( "s0052_rtrg3130" )
end


this.AfterContinue_GetInfo2 = function()
	Fox.Log("#### s10052_radio.AfterContinue_GetInfo1 ####")
	TppRadio.Play( "s0052_rtrg3140" )
end


this.AfterContinue_GetInfo3 = function()
	Fox.Log("#### s10052_radio.AfterContinue_GetInfo3 ####")
	TppRadio.Play( "s0052_rtrg3150" )
end


this.AfterContinue_TargetMarked = function()
	Fox.Log("#### s10052_radio.AfterContinue_TargetMarked ####")
	TppRadio.Play( "f1000_rtrg2570" )
end


this.AfterContinue_TargetRescued = function()
	Fox.Log("#### s10052_radio.AfterContinue_TargetRescued ####")
	TppRadio.Play( "f1000_rtrg3160" )
end




this.Caution_LeaveBehind = function()
	Fox.Log("#### s10052_radio.Caution_LeaveBheind ####")
	if (TppRadio.IsPlayed( "f1000_rtrg2320" )) then
		TppRadio.Play( {"f1000_rtrg2325"}, { isOverwriteProtectionForSamePrio = true } )	
	else
		TppRadio.Play( "f1000_rtrg2320" )
	end
end


this.Caution_LeaveBheind_Heli = function()
	Fox.Log("#### s10052_radio.Caution_LeaveBheind_Heli ####")
	TppRadio.Play( "f1000_rtrg3150" )
end


this.AbortByHeli = function()
	Fox.Log("#### s10052_radio.AbortByHeli ####")
	TppRadio.Play( "f1000_rtrg0030" )
end


this.Caution_CollateralDamage = function()
	Fox.Log("#### s10052_radio.Caution_CollateralDamage ####")
	TppRadio.Play( {"f1000_rtrg2340"}, { delayTime = "mid" } )
end


this.OnGameCleared = function()
	Fox.Log("#### s10052_radio.OnGameCleared ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0070" )
end



this.CheckSituationAndPlayRadio = function()
	local executeFlag = false
	local situationTable = {
		event = {
			[1] = {
				allow	= s10052_enemy.EVENT_SEQUENCE["REMNANTS_CONVERSATION_START"],
				deny	= s10052_enemy.EVENT_SEQUENCE["REMNANTS_TURNAROUND_HOSTAGE"],
			},
			[2] = {
				allow	= s10052_enemy.EVENT_SEQUENCE["REMNANTSNORTH_CONVERSATION_START"],
				deny	= s10052_enemy.EVENT_SEQUENCE["REMNANTSNORTH_MONOLOGUE_TO_HOSTAGE"],
			},
			[3] = {
				allow	= s10052_enemy.EVENT_SEQUENCE["BETWEEN_A_MONOLOGUE_START"],
				deny	= s10052_enemy.EVENT_SEQUENCE["BETWEEN_A_MONOLOGUE_TO_HOSTAGE"],
			},
			[4] = {
				allow	= s10052_enemy.EVENT_SEQUENCE["BETWEEN_B_CONVERSATION_START"],
				deny	= s10052_enemy.EVENT_SEQUENCE["BETWEEN_B_MONOLOGUE_TO_HOSTAGE"],
			},
			[5] = {
				allow	= s10052_enemy.EVENT_SEQUENCE["TENT_CONVERSATION_START"],
				deny	= s10052_enemy.EVENT_SEQUENCE["TENT_GOTO_TORTURE_ROOM"],
			},
		},
	}
	
	
	
	if ( svars.isNearTarget ) then
		executeFlag = true
	end
	
	
	if(	situationTable.event[5].allow <= svars.eventCount	and
		situationTable.event[5].deny  >= svars.eventCount)	then

		
		if ( svars.isReactionOnEvent_5 ) then
			executeFlag = false

		else
			
			if ( svars.isNearTarget ) then
				svars.isReactionOnEvent_5 = true
			end
		end

	
	elseif(	situationTable.event[4].allow <= svars.eventCount	and
			situationTable.event[4].deny  >= svars.eventCount)	then
		
		if ( svars.isReactionOnEvent_4 ) then
			executeFlag = false
		else
			if ( svars.isNearTarget ) then
				svars.isReactionOnEvent_4 = true
			end
		end
	
	elseif(	situationTable.event[3].allow <= svars.eventCount	and
			situationTable.event[3].deny  >= svars.eventCount)	then
		
		if ( svars.isReactionOnEvent_3 ) then
			executeFlag = false
		else
			if ( svars.isNearTarget ) then
				svars.isReactionOnEvent_3 = true
			end
		end
	
	elseif(	situationTable.event[2].allow <= svars.eventCount	and
			situationTable.event[2].deny  >= svars.eventCount)	then
		
		if ( svars.isReactionOnEvent_2 ) then
			executeFlag = false
		else
			if ( svars.isNearTarget ) then
				svars.isReactionOnEvent_2 = true
			end
		end

	elseif(	situationTable.event[1].allow <= svars.eventCount	and
			situationTable.event[1].deny  >= svars.eventCount)	then
		
		if ( svars.isReactionOnEvent_1 ) then
			executeFlag = false
		else
			if ( svars.isNearTarget ) then
				svars.isReactionOnEvent_1 = true
			end
		end

	else
		executeFlag = false
	end
	
	
	
	
	if ( executeFlag ) then
		
		this.LetsActionInConversation()
	end
end






this.SetOptionalRadioFromSituation = function()
	
	TppRadio.SetOverwriteByPhaseOptionalRadio( "Set_s0052_oprg1000" )
	
	if ( svars.isTargetRaidHeli ) then
		
		TppRadio.SetOptionalRadio("Set_s0052_oprg0900")
		TppRadio.SetOverwriteByPhaseOptionalRadio( "Set_f1000_oprg0010" )	
		
	elseif ( svars.isTargetRescue ) then
		if ( svars.isNearTarget ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0800")
		else
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0810")
		end
		
	elseif( svars.isTargetMarked )then
		if ( svars.isNearTarget ) then
			if ( svars.isTalkTime ) then
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0720")
				
			elseif ( svars.isVehicleArrivedTent ) then
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0730")
			
			elseif ( not svars.isDriveTime ) then
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0710")

			else
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0700")
			
			end
		else
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0700")
			
		end
		
	elseif( svars.infoCount >= 3 )then
		
		TppRadio.SetOptionalRadio("Set_s0052_oprg0500")
		
	elseif( svars.infoCount == 2 )then
		if ( svars.isGetInfoFromEnemy and svars.isGetInfoFromFile ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0400")
			
		elseif ( svars.isGetInfoFromEnemy and svars.isGetInfoFromHostage ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0410")
			
		elseif ( svars.isGetInfoFromFile and svars.isGetInfoFromHostage ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0420")
		else
			
			if ( svars.isGetInfoFromEnemy ) then
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0300")
				
			elseif ( svars.isGetInfoFromFile ) then
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0310")
				
			elseif ( svars.isGetInfoFromHostage ) then
				
				TppRadio.SetOptionalRadio("Set_s0052_oprg0320")
			end
		end
		
	elseif( svars.infoCount == 1 )then
		if ( svars.isGetInfoFromEnemy ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0300")
			
		elseif ( svars.isGetInfoFromFile ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0310")
			
		elseif ( svars.isGetInfoFromHostage ) then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0320")
		else
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0330")	
		end
		
	elseif( svars.isArrivedRemnants )then	
		if( svars.tempSvars_007 )then
			
			TppRadio.SetOptionalRadio("Set_s0052_oprg0200")
		else
			TppRadio.SetOptionalRadio("Set_s0052_oprg0100")
		end
	else
		
		TppRadio.SetOptionalRadio("Set_s0052_oprg0100")
		
	end
end






this.SetIntelRadioFromSituation = function()
	local newSetting = {}

	
	if ( svars.isTargetMarked ) then
		if ( svars.isTargetRescue ) then
			newSetting = { hos_target_0000 = "f1000_esrg0620", }
		elseif ( svars.isDriveTime ) then
			newSetting = { hos_target_0000 = "s0052_esrg3020", }
		elseif( svars.isTortureTime ) then
			newSetting = { hos_target_0000 = "Invalid", }	
		else
			newSetting = { hos_target_0000 = "f1000_esrg0620", }
		end
		TppRadio.ChangeIntelRadio( newSetting )
	end

	
	if ( svars.isTargetMarked or svars.isHearTransportProject or ( svars.infoCount > 0 ) ) then
		newSetting = { erl_remnants = "s0052_esrg1020", }
		TppRadio.ChangeIntelRadio( newSetting )
	end
	
	
	if ( svars.isTargetRescue ) then
		newSetting = { erl_tent = "s0052_esrg2060", }
	elseif ( svars.isTargetMarked ) then
		newSetting = { erl_tent = "s0052_esrg2050", }
	elseif ( svars.infoCount >= 3 ) then
		newSetting = { erl_tent = "s0052_esrg2040", }
	elseif ( svars.infoCount == 2 ) then
		newSetting = { erl_tent = "s0052_esrg2030", }
	elseif ( svars.infoCount == 1 ) then
		newSetting = { erl_tent = "s0052_esrg2020", }
	else
		newSetting = { erl_tent = "s0052_esrg2010", }
	end
	TppRadio.ChangeIntelRadio( newSetting )

	
	if ( svars.isTargetMarked ) then	
		if ( svars.isTargetRescue ) then
			newSetting = {
				sol_s10052_guardVehicle_0000	= "f1000_esrg1150",
				veh_transportVehicle_0001		= "f1000_esrg1150",
			}	
		elseif (svars.tempSvars_003) then
			newSetting = {
				sol_s10052_guardVehicle_0000	= "f1000_esrg1150",
				veh_transportVehicle_0001		= "f1000_esrg1150",
			}	
		elseif ( svars.isDriveTime ) then
			newSetting = {
				sol_s10052_guardVehicle_0000	= "s0052_esrg3010",
				veh_transportVehicle_0001		= "s0052_esrg3010",
			}	
		else
			newSetting = {
				sol_s10052_guardVehicle_0000	= "f1000_esrg1150",
				veh_transportVehicle_0001		= "f1000_esrg1150",
			}	
		end
	else
		newSetting = {
			sol_s10052_guardVehicle_0000	= "f1000_esrg1150",
			veh_transportVehicle_0001		= "f1000_esrg1150",
		}
	end
	TppRadio.ChangeIntelRadio( newSetting )

	
	if ( svars.isTortureTime ) then
		newSetting = { sol_s10052_Executioner_tent_0000 = "s0052_esrg4010", }
	else
		newSetting = { sol_s10052_Executioner_tent_0000 = "Invalid", }
	end
	TppRadio.ChangeIntelRadio( newSetting )

end




return this
