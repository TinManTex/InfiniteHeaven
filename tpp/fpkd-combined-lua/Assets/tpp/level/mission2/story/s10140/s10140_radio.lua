local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.OutsideMissionArea = function()
	local currentSeq		= TppSequence.GetCurrentSequenceName( )		
	local branchSeqTable	= { "Seq_Game_MainGame","Seq_Game_Escape",}	

	Fox.Log("#### s10140_radio.OnsideMissionArea #### currentSeq = " .. currentSeq )
	
	
	if ( currentSeq == branchSeqTable[1] ) then
		
		if (svars.outOfHotzoneCount == 0) then
			svars.outOfHotzoneCount = svars.outOfHotzoneCount + 1
			return "s0140_rtrg1050"
		
		else
			svars.outOfHotzoneCount = 0
			return "s0140_rtrg1060"
		end
	
	elseif ( currentSeq == branchSeqTable[2] ) then
		
		if (svars.outOfHotzoneCount == 0) then
			svars.outOfHotzoneCount = svars.outOfHotzoneCount + 1
			return "s0140_rtrg2050"
		
		else
			svars.outOfHotzoneCount = 0
			return "s0140_rtrg2060"
		end
	end
end

this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ]				= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_DEAD ]					= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ]			= this.OutsideMissionArea
this.commonRadioTable[ TppDefine.COMMON_RADIO.RETURN_HOTZONE ]					= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.RECOMMEND_CURE ]					= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN ]				= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME ]			= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE ]	= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME ]			= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ]					= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ]			= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_RECOVERED ]				= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_ELIMINATED ]				= TppRadio.IGNORE_COMMON_RADIO





this.radioList = {
	
	"s0140_rtrg1010",	
	"s0140_rtrg1015",	
	
	{"s0140_rtrg3010", playOnce = true },	
	
	"s0140_rtrg2010",	
	"s0140_rtrg2020",	

	"s0140_rtrg2030",	

	{"s0140_rtrg1040", playOnce = true },	

	"s0140_rtrg1020",	
	{"s0140_rtrg1030", playOnce = true },	

	"s0140_rtrg1050",	
	"s0140_rtrg1060",	
	"s0140_rtrg2050",	
	"s0140_rtrg2060",	
	
	"s0140_rtrg8010",	
	"s0140_rtrg9010",	
	
	"f1000_rtrg4420",	
}





this.optionalRadioList = {
	"Set_s0140_oprg1010",	
	"Set_s0140_oprg1020",	
	"Set_s0140_oprg2010",	
	"Set_s0140_oprg2020",	
}





this.intelRadioList = {
	localtorName = "ThisRadioIsNone",	
}





this.StartGame = function()
	Fox.Log("#### s10140_radio.StartGame ####")
	TppRadio.Play( { "s0140_rtrg1010" } )
end

this.DefeatedParasites = function()
	Fox.Log("#### s10140_radio.DefeatedParasites ####")
	TppRadio.Play( { "s0140_rtrg2010", "s0140_rtrg2020", } )
end

this.UseWarningFlare = function()
	Fox.Log("#### s10140_radio.UseWarningFlare ####")
	if ( svars.isFinishFirstRadio ) then
		TppRadio.Play( { "s0140_rtrg1040" }, { delayTime = "short" } )
	end
end

this.TakeAwayFromCodeTalker = function(trigger)
	Fox.Log("#### s10140_radio.TakeAwayFromCodeTalker ####")
	if ( svars.isFinishFirstRadio ) then
		if ( not TppRadio.IsPlayed("s0140_rtrg1030") ) then
			TppRadio.Play( { "s0140_rtrg1030" }, { isOverwriteProtectionForSamePrio = true } )
		else
			if(trigger == "action")then
				TppRadio.Play( { "s0140_rtrg1020" }, { isOverwriteProtectionForSamePrio = true } )
			end
		end
	end
end

this.BeCarefulRustyGus = function()
	local currentSeq	= TppSequence.GetCurrentSequenceName( )		
	local targetSeq		= "Seq_Game_MainGame"	
	
	if( currentSeq == targetSeq )then
		Fox.Log("#### s10140_radio.BeCarefulRustyGus ####")
		TppRadio.Play( { "s0140_rtrg3010" } )
		
		TppRadio.SetOptionalRadio("Set_s0140_oprg1020")
	else
		Fox.Log("#### s10140_radio.BeCarefulRustyGus #### No Play, Because currentSeq = "..tostring(currentSeq))
	end
end

this.ArrivedHeli = function()
	Fox.Log("#### s10140_radio.ArrivedHeli ####")
	TppRadio.Play( { "s0140_rtrg2030" } )
end

this.PleasePutOnCodeTalker = function()
	Fox.Log("#### s10140_radio.PleasePutOnCodeTalker ####")
	TppRadio.Play( { "s0140_rtrg1050" }, {delayTime = "short", isOverwriteProtectionForSamePrio = true }  )
end

this.PleaseComeBack_1 = function()
	Fox.Log("#### s10140_radio.PleaseComeBack_1 #### outOfHotzoneCount = " .. tostring(svars.outOfHotzoneCount) )
	
	if ( svars.outOfHotzoneCount == 0 ) then
		TppRadio.Play( { "s0140_rtrg1050" }, { isOverwriteProtectionForSamePrio = true } )
		
	elseif ( svars.outOfHotzoneCount == 1 ) then
		TppRadio.Play( { "s0140_rtrg1060" }, { isOverwriteProtectionForSamePrio = true } )
		
	else
		Fox.Log("#### s10140_radio.PleaseComeBack_1 #### Unknown State!! ")
	end
end

this.PleaseComeBack_2 = function()
	Fox.Log("#### s10140_radio.PleaseComeBack_2 #### outOfHotzoneCount = " .. tostring(svars.outOfHotzoneCount) )

	if ( svars.outOfHotzoneCount == 0 ) then
		TppRadio.Play( { "s0140_rtrg2050" }, { isOverwriteProtectionForSamePrio = true } )
		
	elseif ( svars.outOfHotzoneCount == 1 ) then
		TppRadio.Play( { "s0140_rtrg2060" }, { isOverwriteProtectionForSamePrio = true } )
		
	else
		Fox.Log("#### s10140_radio.PleaseComeBack_2 #### Unknown State!! ")
	end
end

this.NotYetFultonSkulls = function()
	Fox.Log("#### s10140_radio.NotYetFultonSkulls #### " )
	TppRadio.Play( { "f1000_rtrg4420" }, { delayTime = "short", isOverwriteProtectionForSamePrio = true } )
end

this.PlayerAttackHeli = function(target)
	Fox.Log("#### s10140_radio.PlayerAttackHeli #### " )
	TppRadio.Play( { "s0140_rtrg8010" }, { delayTime = "short", isOverwriteProtectionForSamePrio = true } )
end

this.PlayerKillFriend = function(target)
	Fox.Log("#### s10140_radio.PlayerKillFriend #### " )
	if target == "heli" then
		TppRadio.Play( { "s0140_rtrg9010" }, { delayTime = "mid", priority = "strong" } )
	else
		TppRadio.Play( { "s0140_rtrg9010" }, { priority = "strong" } )
	end
end





this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.TARGET_DEAD]			= "s0140_gmov1010"
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.PLAYER_DESTROY_HELI]	= "s0140_gmov1020"




return this
