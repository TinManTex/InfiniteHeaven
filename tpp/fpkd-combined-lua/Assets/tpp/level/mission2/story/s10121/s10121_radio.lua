local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local TARGET_ENEMY_NAME = "sol_pfCamp_vip_0001"
local SUB_TARGET_ENEMY_NAME = "sol_pfCamp_vip_guard"





this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.DISCOVERED_BY_ENEMY_HELI ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.PLAYER_NEAR_ENEMY_HELI ] = "f1000_rtrg3781"




this.radioList = {
	{ "s0121_rtrg1010", playOnce = true }, 

	{ "s0121_rtrg2250", playOnce = true }, 
	{ "s0121_rtrg2260", playOnce = true }, 

	
	{ "s0121_rtrg1020", playOnce = true }, 
	{ "s0121_rtrg1040", playOnce = true }, 
	{ "s0121_rtrg0023", playOnce = true }, 
	{ "s0121_rtrg0022", playOnce = true }, 

	{ "s0121_rtrg1050", playOnce = true }, 
	{ "s0121_rtrg1051", playOnce = true }, 
	{ "s0121_rtrg1055", playOnce = true }, 
	{ "s0121_rtrg0020", playOnce = true }, 
	{ "s0121_rtrg0040", playOnce = true }, 
	{ "s0121_rtrg2110", playOnce = true }, 
	{ "s0121_rtrg2010", playOnce = true }, 

	{ "s0121_rtrg2130", playOnce = true }, 
	{ "s0121_rtrg2020", playOnce = true }, 
	{ "s0121_rtrg2030", playOnce = true }, 

	{ "s0121_rtrg1060", playOnce = true }, 
	{ "s0121_rtrg2080", playOnce = true }, 
	{ "s0121_rtrg1070", playOnce = true }, 
	{ "s0121_rtrg2130", playOnce = true }, 

	"s0121_rtrg2170", 
	"s0121_rtrg2180", 

	{ "s0121_rtrg2090", playOnce = true }, 

	"s0121_rtrg2040", 
	"s0121_rtrg2050", 
	"s0121_rtrg2060", 
	"s0121_rtrg2070", 

	"s0121_rtrg2190", 
	"s0121_rtrg2200", 
	"f1000_rtrg1030", 

	{ "f1000_rtrg2170", playOnce = true }, 
	{ "f1000_rtrg2395", playOnce = true }, 
	{ "f1000_rtrg2380", playOnce = true }, 
	{ "f1000_rtrg2505", playOnce = true }, 
	{ "s0121_oprg0060", playOnce = true }, 



}





this.optionalRadioList = {
	"Set_s0121_oprg0000", 
	"Set_s0121_oprg0010", 
	"Set_s0121_oprg0020", 
	"Set_s0121_oprg0030", 
	"Set_s0121_oprg0040", 
	"Set_s0121_oprg0050", 
	"Set_s0121_oprg0060",
	"Set_s0121_oprg0100",
}





this.intelRadioList = {
	sol_pfCamp_snp_0000					= "s0121_esrg2120",	
	sol_pfCamp_snp_0001					= "s0121_esrg2120",	
	sol_pfCamp_snp_0002					= "s0121_esrg2120",	
	rds_pfCampArea_0000					= "s0121_esrg2130",	
}

this.intelRadioList_FoundTarget = {
	sol_pfCamp_vip_0001					= "s0121_esrg2060",	
}

this.intelRadioList_TargetAfterDialogue01 = {
	sol_pfCamp_vip_0001					= "s0121_esrg2070",	
}

this.intelRadioList_TargetAfterDialogue02 = {
	sol_pfCamp_vip_0001					= "s0121_esrg2080",	
}

this.intelRadioList_TargetAfterDialogue03 = {
	sol_pfCamp_vip_0001					= "s0121_esrg2090",	
}

this.intelRadioList_TargetEscaping = {
	sol_pfCamp_vip_0001					= "s0121_esrg2110", 
}

this.intelRadioList_FoundSubTarget = {
	sol_pfCamp_vip_guard				= "s0121_esrg2010",	
}

this.intelRadioList_FoundSubTargetAfterVipFound = {
	sol_pfCamp_vip_guard				= "s0121_esrg2030",
}

this.intelRadioList_SubTargetAfterDialogue01 = {
	sol_pfCamp_vip_guard				= "s0121_esrg2020",	
}

this.intelRadioList_SubTargetAfterDialogue02 = {
	sol_pfCamp_vip_guard				= "s0121_esrg2030",	
}

this.intelRadioList_SubTargetAfterDialogue03 = {
	sol_pfCamp_vip_guard				= "s0121_esrg2040",	
}

this.intelRadioList_SubTargetAfterDialogue04 = {
	sol_pfCamp_vip_guard				= "s0121_esrg2050",	
}





this.blackTelephoneDisplaySetting = {

	f6000_rtrg0160 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_010_1.ftex", 0.6,"cast_cfa_executive" },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10121_01.ftex", 9.5 },
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_010_1.ftex", 0.6,"cast_cfa_executive" },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10121_01.ftex", 8.5 },
		},
	},

	f6000_rtrg0170 = {
		Japanese = {
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_020_1.ftex", 0.6,"cast_arms_dealer" }, 
		},
		English = {
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_020_1.ftex", 0.6,"cast_arms_dealer" }, 
		},
	},

	f6000_rtrg0165 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_010_1.ftex", 0.6,"cast_cfa_executive" },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10121_01.ftex", 9.5 },
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_020_1.ftex", 24.5,"cast_arms_dealer" },
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_010_1.ftex", 0.6,"cast_cfa_executive" },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10121_01.ftex", 8.5 },
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10121/mb_photo_10121_020_1.ftex", 21.5,"cast_arms_dealer" },
		},
	},

}





this.MissionStart = function()
	Fox.Log("#### s10121_radio.MissionStart ####")
	TppRadio.Play( "s0121_rtrg1010" )
end


this.ArrivedpfCampEarly = function()
	Fox.Log("#### s10121_radio.ArrivedpfCampEarly ####")
	TppRadio.Play( "s0121_rtrg2250", { isEnqueue = true, delayTime = 5.0 } )
end


this.ArrivedpfCamp = function()
	Fox.Log("#### s10121_radio.ArrivedpfCamp ####")
	TppRadio.Play( "s0121_rtrg2260", { isEnqueue = true, delayTime = 5.0 } )
end


this.EnemyHeliStartAfterMBMissionClear = function()
	Fox.Log("#### s10121_radio.EnemyHeliStart ####")
	TppRadio.Play( "s0121_rtrg1020" )
end


this.EnemyHeliStartBeforeMBMissionClear = function()
	Fox.Log("#### s10121_radio.EnemyHeliStart ####")
	TppRadio.Play( "s0121_rtrg1020" )
	TppRadio.Play( "f1000_rtrg1030", { isEnqueue = true, delayTime = 2.0 } )
end


this.EnemyHeliNotStartAfterMBMissionClear = function()
	Fox.Log("#### s10121_radio.EnemyHeliStart ####")
	TppRadio.Play( "s0121_rtrg0023" )
end


this.EnemyHeliNotStartBeforeMBMissionClear = function()
	Fox.Log("#### s10121_radio.EnemyHeliStart ####")
	TppRadio.Play( "s0121_rtrg0022" )
	TppRadio.Play( "f1000_rtrg1030", { isEnqueue = true, delayTime = 2.5 } )
end



this.EnemyHeliStart = function()
	Fox.Log("#### s10121_radio.EnemyHeliStart ####")
	TppRadio.Play( "s0121_rtrg0020" )
end


this.EnemyHeliReturn = function()
	Fox.Log("#### s10121_radio.TargetEvacuating ####")
	if TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame") then
		TppRadio.Play( "s0121_rtrg2110" )
	end
end


this.VisiterArrived = function()
	Fox.Log("#### s10121_radio.VisiterArrived ####")
	TppRadio.Play( "s0121_rtrg0040" )
end


this.ConfirmedSubTarget = function()
	Fox.Log("#### s10121_radio.ConfirmedSubTarget ####")
	if TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex("Seq_Game_MainGame") then
		if svars.isEnemyVIPUnite == false and TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == true then
			TppRadio.Play("s0121_rtrg1050")

		elseif svars.isEnemyVIPUnite == false and TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false then
			TppRadio.Play("s0121_rtrg1050")
			TppRadio.SetOptionalRadio( "Set_s0121_oprg0020" )
			TppRadio.ChangeIntelRadio( this.intelRadioList_FoundSubTarget )
		
		elseif svars.isEnemyVIPUnite == true and TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false then
			TppRadio.Play("s0121_rtrg1051")
			TppRadio.ChangeIntelRadio( this.intelRadioList_FoundSubTarget )

		elseif svars.isEnemyVIPUnite == true and TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == true then 
			TppRadio.Play("s0121_rtrg1055")
			TppRadio.ChangeIntelRadio( this.intelRadioList_FoundSubTargetAfterVipFound )
		end
	else
		TppRadio.Play("s0121_rtrg1055")
		TppRadio.ChangeIntelRadio( this.intelRadioList_FoundSubTargetAfterVipFound )
	end
end


this.DownSubTarget = function()
	Fox.Log("#### s10121_radio.DamageSubTarget ####")
	TppRadio.Play( "s0121_rtrg2130" )
end



this.EnemyHeliJoinGuard = function()
	Fox.Log("#### s10121_radio.EnemyHeliJoinGuard ####")
	TppRadio.Play( "s0121_rtrg2010" )
end


this.MarkerUnavailable = function()
	Fox.Log("#### s10121_radio.MarkerUnavailable ####")
	TppRadio.Play( "s0121_rtrg1060" )
end


this.InspactionStarted = function()
	Fox.Log("#### s10121_radio.MarkerUnavailable ####")
	TppRadio.Play( "s0121_rtrg2020" )
end


this.FindInspactor = function()
	Fox.Log("#### s10121_radio.MarkerUnavailable ####")
	TppRadio.Play( "s0121_rtrg2020" )
end


this.ConfirmedTarget = function()
	Fox.Log("#### s10121_radio.ConfirmedTarget ####")
	TppRadio.Play( "f1000_rtrg2170" )
	TppRadio.ChangeIntelRadio( this.intelRadioList_FoundTarget )
	if( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.ChangeIntelRadio( s10121_radio.intelRadioList_FoundSubTargetAfterVipFound )
	end
end


this.TargetEvacuating = function()
	Fox.Log("#### s10121_radio.TargetEvacuating ####")
	TppRadio.Play( "s0121_rtrg1070" )
end


this.EnemyHeliComing = function()
	Fox.Log("#### s10121_radio.EnemyHeliComing ####")
	TppRadio.Play( "s0121_rtrg2080" )
end


this.EnemyHeliRiding = function()
	Fox.Log("#### s10121_radio.EnemyHeliRiding ####")
	TppRadio.Play( "s0121_rtrg1070" , { isEnqueue = true, delayTime = 1.5 })
end


this.EnemyHeliRidden = function()
	Fox.Log("#### s10121_radio.EnemyHeliRidden ####")
	TppRadio.Play("s0121_rtrg2090")
end


this.ObjectiveCompleted = function()
	Fox.Log("#### s10121_radio.ObjectiveCompleted ####")
	TppRadio.Play( "f1000_rtrg1375" )
end




this.ListenDialogue_01 = function()
	Fox.Log("#### s10121_radio.ListenDialogue_01 ####")
	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == false )then
		TppRadio.Play( "s0121_rtrg2170" )
	elseif( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.Play( "s0121_rtrg2180" )
	else
		TppRadio.Play( "s0121_rtrg2040" )
	end

	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == true ) then
		TppRadio.ChangeIntelRadio( this.intelRadioList_TargetAfterDialogue01 )
	end

	if( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.ChangeIntelRadio( this.intelRadioList_SubTargetAfterDialogue01 )
	end
end

this.ListenDialogue_02 = function()
	Fox.Log("#### s10121_radio.ListenDialogue_02 ####")
	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == false )then
		TppRadio.Play( "s0121_rtrg2170" )
	elseif( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.Play( "s0121_rtrg2180" )
	else

	end

	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == true ) then
		TppRadio.ChangeIntelRadio( this.intelRadioList_TargetAfterDialogue02 )
	end

	if( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.ChangeIntelRadio( this.intelRadioList_SubTargetAfterDialogue02 )
	end
end

this.ListenDialogue_03 = function()
	Fox.Log("#### s10121_radio.ListenDialogue_03 ####")
	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == false )then
		TppRadio.Play( "s0121_rtrg2170" )
	elseif( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.Play( "s0121_rtrg2180" )
	else
		TppRadio.Play( "s0121_rtrg2050" )
	end

	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == true ) then
		TppRadio.ChangeIntelRadio( this.intelRadioList_TargetAfterDialogue03 )
	end

	if( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.ChangeIntelRadio( this.intelRadioList_SubTargetAfterDialogue03 )
	end

end

this.ListenDialogue_04 = function()
	Fox.Log("#### s10121_radio.ListenDialogue_04 ####")
	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == false )then
		TppRadio.Play( "s0121_rtrg2170" )
	elseif( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == false ) and ( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.Play( "s0121_rtrg2180" )
	else
		TppRadio.Play( "s0121_rtrg2060" )
	end

	if( TppMarker.GetSearchTargetIsFound( TARGET_ENEMY_NAME ) == true ) then
		TppRadio.ChangeIntelRadio( this.intelRadioList_TargetEscaping )
	end

	if( TppMarker.GetSearchTargetIsFound( SUB_TARGET_ENEMY_NAME ) == true )then
		TppRadio.ChangeIntelRadio( this.intelRadioList_SubTargetAfterDialogue04 )
	end
end

this.ContinueHeliArrived = function()
	Fox.Log("#### s10121_radio.ContinueHeliArrived ####")
	TppRadio.Play("s0121_rtrg0040")
end

this.ContinueSubVipFound = function()
	Fox.Log("#### s10121_radio.ContinueSubVipFound ####")
	TppRadio.Play( "s0121_rtrg2190" )
end

this.ContinueVipFound = function()
	Fox.Log("#### s10121_radio.ContinueVipFound ####")
	TppRadio.Play( "s0121_rtrg2200" )
end

this.ContinueVipEscaping = function()
	Fox.Log("#### s10121_radio.ContinueVipEscaping ####")
	TppRadio.Play( "s0121_rtrg2090" )
end



this.OnGameCleared_CapturePFLeader = function()
	Fox.Log("#### s10200_radio.OnGameCleared_CapturePFLeader ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0160" )
end

this.OnGameCleared_CaptureArmsDealer = function()
	Fox.Log("#### s10200_radio.OnGameCleared_CaptureArmsDealer ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0170" )
end

this.OnGameCleared_CaptureBoth = function()
	Fox.Log("#### s10200_radio.OnGameCleared_CaptureBoth ####")
	TppRadio.RequestBlackTelephoneRadio( { "f6000_rtrg0165" } )
end






this.SetConversation = function( speakerGameObjectId, friendGameObjectId, speechLabel )
    Fox.Log("*** SetConversation ***")
    if Tpp.IsTypeString( speakerGameObjectId ) then
            speakerGameObjectId = GameObject.GetGameObjectId( speakerGameObjectId )
    end
    if Tpp.IsTypeString( friendGameObjectId ) then
            friendGameObjectId = GameObject.GetGameObjectId( friendGameObjectId )
    end
    
    local command = { id = "CallConversation", label = speechLabel, friend  = friendGameObjectId, }
    GameObject.SendCommand( speakerGameObjectId, command )
end





this.SpeechAtMeeting = function()
	this.SetConversation( TARGET_ENEMY_NAME, SUB_TARGET_ENEMY_NAME, "speech121_EV010")
end


this.SpeechAtFirstDock = function()
	this.SetConversation( TARGET_ENEMY_NAME, SUB_TARGET_ENEMY_NAME, "speech121_EV020")
end


this.SpeechAtNextDock = function()
	this.SetConversation( TARGET_ENEMY_NAME, SUB_TARGET_ENEMY_NAME, "speech121_EV030")
end


this.SpeechEndInspection = function()
	this.SetConversation( SUB_TARGET_ENEMY_NAME, TARGET_ENEMY_NAME, "speech121_EV040")
end




return this
