local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


local TARGET_HOSTAGE_NAME 	= "hos_hillNorth_0000"
local TARGET_BONUS_HOSTAGE 	= "hos_hillNorth_0001"
local TARGET_VIP_NAME 		= "sol_hillNorth_0000"




this.radioList = {



	{ "s0200_rtrg0010", playOnce = true },	
	{ "s0200_oprg0030", playOnce = true },	
	{ "s0200_rtrg0020", playOnce = true },	
	{ "s0200_rtrg0030", playOnce = true },	
	 "f1000_rtrg2080",	
	{ "s0200_rtrg0050", playOnce = true },	
	{ "s0200_rtrg0060", playOnce = true },	
	{ "s0200_rtrg0070", playOnce = true },	
	{ "s0200_rtrg0080", playOnce = true },	
	{ "s0200_rtrg0100", playOnce = true },	
	{ "s0200_rtrg0110", playOnce = true },	
	{ "s0200_rtrg0120", playOnce = true },	
	{ "s0200_rtrg0130", playOnce = true },	

	{ "s0200_rtrg0160", playOnce = true },	
	{ "s0200_rtrg0170", playOnce = true },	
	{ "s0200_rtrg0180", playOnce = true },	
	{ "s0200_rtrg0190", playOnce = true },	
	{ "s0200_rtrg0200", playOnce = true },	
	{ "s0200_rtrg1010", playOnce = true },	
	{ "s0200_rtrg1020", playOnce = true },	
	{ "s0200_rtrg1030", playOnce = true },	

	"s0200_rtrg1050", 


	"s0200_oprg0020", 
	"s0200_oprg0040", 
	"s0200_oprg0080", 
	"s0200_rtrg0090", 

	"s0200_oprg0140", 
	"s0200_oprg0180", 
	"s0200_oprg0170", 



	"f1000_rtrg2040", 
	"f1000_rtrg7010" 

}





this.optionalRadioList = {
	"Set_s0200_oprg0000", 
	"Set_s0200_oprg0001", 
	"Set_s0200_oprg0010", 
	"Set_s0200_oprg0020", 
	"Set_s0200_oprg0030", 
	"Set_s0200_oprg0040", 
	"Set_s0200_oprg0050", 
	"Set_s0200_oprg0060", 

	"Set_s0200_oprg0070", 
	"Set_s0200_oprg0080", 
}





this.intelRadioList = {
	rds_hillNorthTown_0000				= "s0200_esrg0010",	
	rds_hillNorthTownBackStory_0000		= "f1000_esrg1810",	
	rds_hillNorthTownBackStory_0001		= "f1000_esrg1820",	

	sol_hillNorth_0000					= "s0200_esrg0060",	
	sol_hillNorth_0001					= "s0200_esrg0070",	
	sol_hillNorth_0002					= "s0200_esrg0060",	
	sol_hillNorth_0003					= "s0200_esrg0070",	
	sol_hillNorth_0004					= "s0200_esrg0060",	

	sol_hillNorth_0008					= "s0200_esrg0030",	
	sol_hillNorth_0009					= "s0200_esrg0030",	
	sol_hillNorth_0010					= "s0200_esrg0030",	
	sol_hillNorth_0011					= "s0200_esrg0030",	
}


this.intelRadioList_EnemiesBack = {
	rds_hillNorthTown_0000				= "s0200_esrg0020",	
}

this.intelRadioList_FoundLeader = {
	sol_hillNorth_0000			= "s0200_esrg0080",	
}

this.intelRadioList_Unit02Started = {
	sol_hillNorth_0008			= "Invalid",	
	sol_hillNorth_0009			= "Invalid",	
	sol_hillNorth_0010			= "Invalid",	
	sol_hillNorth_0011			= "Invalid",	
}





this.blackTelephoneDisplaySetting = {
	f6000_rtrg0190 = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10200/mb_photo_10200_010_1.ftex", 3.75, "cast_militants_no.2", },
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10200/mb_photo_10200_020_1.ftex", 9.82, "cast_child_soldiers_leader", },
			{ "hide", "sub_2", 20.63 },
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10200/mb_photo_10200_010_1.ftex", 3.95, "cast_militants_no.2", },
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/10200/mb_photo_10200_020_1.ftex", 9.95, "cast_child_soldiers_leader", },
			{ "hide", "sub_2", 19.40 },
		},
	},
}






this.LocateViewPoint = function()
	Fox.Log("#### s10200_radio.LocateViewPoint ####")
	TppRadio.Play( "s0200_oprg0030" , { isEnqueue = true, delayTime = 2.0 } )
end


this.PhaseAlart = function()
	Fox.Log("#### s10200_radio.PhaseAlart ####")
	TppRadio.Play( "s0200_rtrg0170" )
end


this.ReturnUnitReturned = function()
	Fox.Log("#### s10200_radio.ReturnUnitReturned ####")
	TppRadio.Play( "s0200_rtrg0050" , { isEnqueue = true, delayTime = 3.0 } )
	TppRadio.ChangeIntelRadio( this.intelRadioList_EnemiesBack )
	TppSound.SetPhaseBGM( "bgm_child_soldiers" )
end


this.AnotherReturnUnitReturned = function()
	Fox.Log("#### s10200_radio.AnotherReturnUnitReturned ####")
	TppRadio.Play( "s0200_rtrg0060" , { isEnqueue = true, delayTime = 3.0 } )
end


this.FultonNG = function()
	Fox.Log("#### s10200_radio.FultonNG ####")
	TppRadio.Play( "f1000_rtrg2080" )
end


this.ConfirmedTargetLeader = function()
	Fox.Log("#### s10200radio.ReachHostage ####")
	TppRadio.Play( "s0200_rtrg0120" )
	TppRadio.ChangeIntelRadio( this.intelRadioList_FoundLeader )
	if( svars.isCaptureHostage == false ) then
		if(	TppMarker.GetSearchTargetIsFound( TARGET_HOSTAGE_NAME ) == true ) then
			TppRadio.SetOptionalRadio( "Set_s0200_oprg0080" )
		else
			TppRadio.SetOptionalRadio( "Set_s0200_oprg0040" )
		end
	else
		TppRadio.SetOptionalRadio( "Set_s0200_oprg0040" )
	end
end


this.ConfirmedTargetHostage = function()
	Fox.Log("#### s10200radio.ReachHostage ####")
	TppRadio.Play( "s0200_rtrg0030" )
	if ( svars.isCaptureLeader == false ) then
		if(	TppMarker.GetSearchTargetIsFound( TARGET_VIP_NAME ) == true ) then
			TppRadio.SetOptionalRadio( "Set_s0200_oprg0080" )
		else
			TppRadio.SetOptionalRadio( "Set_s0200_oprg0010" )
		end
	else
		TppRadio.SetOptionalRadio( "Set_s0200_oprg0010" )
	end
end


this.CarryHostageBeforeFoundTarget = function()
	Fox.Log("#### s10200radio.CarryHostageBeforeFoundTarget ####")
	TppRadio.Play( "CarryHostageBeforeFoundTarget", { playDebug = true } )
end


this.HostageCaptured = function()
	Fox.Log("#### s10200radio.TargetCaptured ####")
	TppRadio.Play( "s0200_rtrg0100" )
end


this.LeaderCaptured = function()
	Fox.Log("#### s10200radio.TargetCaptured ####")
	TppRadio.Play( "s0200_rtrg0130" )
end


this.missionObjectiveComplete = function()
	Fox.Log("#### s10200radio.TargetCaptured ####")
	TppRadio.Play( "f1000_rtrg1010")
end


this.BonusHostageKilled = function()
	Fox.Log("#### s10200radio.BonusHostageKilled ####")
	TppRadio.Play( "s0200_rtrg1030")
end


this.BonusHostageCaptured = function()
	Fox.Log("#### s10200radio.BonusHostageCaptured ####")
	TppRadio.Play( "s0200_rtrg0200")
end

this.BonusHostageInDanger = function()
	Fox.Log("#### s10200radio.BonusHostageInDanger ####")
	TppRadio.Play("s0200_rtrg0190")
end


this.BonusHostageFound = function()
	Fox.Log("#### s10200radio.bonusHostageFound ####")
	local gameObjectId = GameObject.GetGameObjectId( "hos_hillNorth_0001" )
	local command = { id = "GetLifeStatus" }
	local lifeState = GameObject.SendCommand( gameObjectId, command )
	if lifeState ~= TppGameObject.NPC_LIFE_STATE_DEAD then
		TppRadio.Play( "f1000_rtrg2040" )
	else
		Fox.Log("BonusHostageAlreadyDead")		
	end
end


this.CqcChild = function()
	Fox.Log("#### s10200radio.CqcChild ####")
	if mvars.CqcChildCount == nil then
		mvars.CqcChildCount = 0
	end

	if mvars.CqcChildCount == 0 then
		mvars.CqcChildCount = 1
		TppRadio.Play( "s0200_rtrg1050")
	elseif mvars.CqcChildCount == 1 then
		mvars.CqcChildCount = 0
	end
end


this.BonusHostageAreaReached = function()
	Fox.Log("#### s10200radio.bonusHostageDead ####")
	if (svars.isBonusHostageFound == true ) then 		
		TppRadio.Play( "s0200_rtrg1010" )
	else												
		if svars.isStatusHostage == s10200_sequence.TARGET_STATUS.FOUND then
			TppRadio.Play( "s0200_rtrg1025" )
		else
			TppRadio.Play( "s0200_rtrg1020" )
		end
	end
end



this.ContinueRadio = function()
	if ( svars.isStatusHostage  == s10200_sequence.TARGET_STATUS.FOUND and svars.isStatusLeader ~= s10200_sequence.TARGET_STATUS.FOUND ) then 
		TppRadio.Play("s0200_oprg0040")
	elseif ( svars.isStatusHostage == s10200_sequence.TARGET_STATUS.CAPTURED and svars.isStatusLeader == s10200_sequence.TARGET_STATUS.NONE ) then 
		TppRadio.Play("s0200_oprg0080")
	elseif ( svars.isStatusHostage == s10200_sequence.TARGET_STATUS.CAPTURED and svars.isStatusLeader == s10200_sequence.TARGET_STATUS.FOUND ) then 
		TppRadio.Play("s0200_oprg0090")
	elseif ( svars.isStatusHostage ~= s10200_sequence.TARGET_STATUS.FOUND and svars.isStatusLeader == s10200_sequence.TARGET_STATUS.FOUND ) then 
		TppRadio.Play("s0200_oprg0130")
	elseif ( svars.isStatusHostage ~= s10200_sequence.TARGET_STATUS.CAPTURED and svars.isStatusLeader == s10200_sequence.TARGET_STATUS.CAPTURED ) then 
		TppRadio.Play("s0200_oprg0140")
	elseif ( svars.isStatusHostage == s10200_sequence.TARGET_STATUS.FOUND and svars.isStatusLeader == s10200_sequence.TARGET_STATUS.FOUND ) then 
		TppRadio.Play("s0200_oprg0180")
	else
		TppRadio.Play("s0200_oprg0020")
	end
end

this.OnGameCleared = function()
	Fox.Log("#### s10200_radio.OnGameCleared ####")
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0190" )
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





this.Speech01 = function()
	this.SetConversation( "sol_hillNorth_0004", "sol_hillNorth_0004", "CT10200_modori_A")
end


this.Speech02 = function()
	this.SetConversation( "sol_hillNorth_0008", "sol_hillNorth_0008", "CT10200_modori_B")
end




this.CarriedSpeech = function( speechLabel )
	local gameObjectId = GameObject.GetGameObjectId( TARGET_HOSTAGE_NAME )
	local command = {
	        id="CallMonologue",
	        label = speechLabel,
	        reset = true,
			carry = true,
	}
	GameObject.SendCommand( gameObjectId, command )
end

this.StartMonologue = function()
	if svars.sub_Flag_0010 == 0 then
		this.CarriedSpeech( "speech200_carry010" )

	elseif svars.sub_Flag_0010 == 1 then
		this.CarriedSpeech( "speech200_carry020" )

	elseif svars.sub_Flag_0010 == 2 then
		this.CarriedSpeech( "speech200_carry030" )

	elseif svars.sub_Flag_0010 == 3 then
		this.CarriedSpeech( "speech200_carry040" )

	elseif svars.sub_Flag_0010 == 4 then
		this.CarriedSpeech( "speech200_carry050" )

	elseif svars.sub_Flag_0010 == 5 then
		this.CarriedSpeech( "speech200_carry070" )
	else
		Fox.Log("### No Speech Left ###")
	end 
end



return this
