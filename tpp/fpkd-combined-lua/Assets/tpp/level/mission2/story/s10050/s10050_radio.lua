local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	
	{ "s0050_rtrg1070", playOnce = true },	
	{ "s0050_rtrg2050", playOnce = true },	
	{ "s0050_rtrg2060", playOnce = true },	
	
	"s0050_rtrg1160",	
	"s0050_rtrg1170",	
	"s0050_rtrg1175",	
	
	"s0050_rtrg1080",	
	"s0050_rtrg5010",	
	
	"s0050_rtrg2010",	
	"s0050_rtrg2020",	
	"s0050_rtrg2030",	
	"s0050_rtrg2040",	

	"s0050_rtrg3040",	
	"s0050_rtrg3050",	
	"s0050_rtrg3060",	
	"s0050_rtrg3070",	
	"s0050_rtrg3080",	

	{ "s0050_rtrg3030", playOnce = true },	

	"s0050_rtrg3090",	
	"s0050_rtrg3100",	
	"s0050_rtrg3110",	
	
	"s0050_rtrg6010",	
	{ "s0050_rtrg7010", playOnce = true },	

	
	"s0050_rtrg1010",	
	"s0050_rtrg1020",	
	"s0050_rtrg1025",	
	"s0050_rtrg1030",	
	"s0050_rtrg1040",	

	"s0050_rtrg1050",	
	"s0050_rtrg1060",	
	
	"s0050_rtrg3010",	
	"s0050_rtrg3020",	
	
	"s0050_rtrg6010",	
	"s0050_rtrg6020",	
	
	"f1000_rtrg0010",	
	"s0050_rtrg7020",	
}




this.optionalRadioList = {
	"Set_s0050_oprg1000",	
	"Set_s0050_oprg2000",	
	"Set_s0050_oprg3000",	
	"Set_s0050_oprg4000",	
	"Set_s0050_oprg5000",	
	"Set_s0050_oprg6000",	
	"Set_s0050_oprg7000",	
	"Set_s0050_oprg7005",	
}





this.intelRadioList = {
	
	BossQuietGameObjectLocator	= "Invalid",		

	
	erl_woods					= "s0050_esrg1080",	
	erl_gate					= "s0050_esrg1100", 
	erl_tower_01				= "s0050_esrg1060", 
	erl_tower_02				= "s0050_esrg1060",
	erl_tower_03				= "s0050_esrg1060",








	erl_house_01				= "s0050_esrg1050", 
	erl_house_02				= "s0050_esrg1050",
	erl_house_03				= "s0050_esrg1050",






}





this.CheckSituationAndPlay = function()
	
	if (TppQuest.IsOpen("sovietBase_q99020") and not(TppQuest.IsCleard("sovietBase_q99020"))) then
		
		if( svars.isKillMode ) then
			return "s0050_rtrg7020"	
		
		else
			return "f1000_rtrg0010"	
		end
	else
		return "f1000_rtrg0010"	
	end
end

this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_S		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_A		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_B		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_C		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_D		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_E		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ]		= this.CheckSituationAndPlay



this.StartGame = function()
	Fox.Log("#### s10050_radio.StartGame ####")
	if ( svars.isQuietDown == false ) then
		
		if ( TppSequence.GetContinueCount() > 2 ) then
			TppRadio.Play( { "s0050_rtrg6010" }, { delayTime = "mid"} )
			
		
		elseif (TppQuest.IsOpen("sovietBase_q99020") and not(TppQuest.IsCleard("sovietBase_q99020"))) then
			TppRadio.Play( { "s0050_rtrg1010", "s0050_rtrg1020", "s0050_rtrg1025" }, { delayTime = "mid"} )
		







		
		else
			TppRadio.Play( { "s0050_rtrg1010", "s0050_rtrg1020" }, { delayTime = "mid"} )
		







		end
	else
		this.KillQuiet()
	end
end

this.PleaseAwayFromHere = function()
	Fox.Log("#### s10050_radio.KillQuiet ####")
	TppRadio.Play( "s0050_rtrg7010" )
end

this.KillQuiet = function()
	Fox.Log("#### s10050_radio.KillQuiet ####")
	TppRadio.Play( { "s0050_rtrg1050", "s0050_rtrg1060" }, { delayTime = "short"} )
end

this.KillQuietGame = function()
	Fox.Log("#### s10050_radio.KillQuietGame_1 ####")
	TppRadio.Play( { "s0050_rtrg2010", "s0050_rtrg2020", "s0050_rtrg2030", "s0050_rtrg2040"}, { delayTime = "short"} )
end

this.CallHeli = function()
	Fox.Log("#### s10050_radio.CallHeli ####")
	TppRadio.Play( { "s0050_rtrg3040", "s0050_rtrg3050", "s0050_rtrg3060", "s0050_rtrg3070", "s0050_rtrg3080"}, { delayTime = "short"} )
end

this.QuietDead = function()
	Fox.Log("#### s10050_radio.QuietDead ####")
	TppRadio.Play( { "s0050_rtrg3010", "s0050_rtrg3020"}, { delayTime = "short"} )
end

this.DoNotFulton = function()
	Fox.Log("#### s10050_radio.DoNotFulton ####")
	TppRadio.Play( { "s0050_rtrg3030"} )
end

this.PleaseRideHeli = function()
	Fox.Log("#### s10050_radio.PleaseRideHeli ####")
	if (svars.isPlayerRideHeliWithQ) then
		TppRadio.Play( "s0050_rtrg3100" )
	else
		TppRadio.Play( { "s0050_rtrg3090", "s0050_rtrg3100"} )
	end
end

this.PleasePutOnQuiet = function()
	Fox.Log("#### s10050_radio.PleasePutOnQuiet ####")
	TppRadio.Play( "s0050_rtrg3110" )
end

this.BeCarefulNoCover = function()
	Fox.Log("#### s10050_radio.BeCarefulNoCover ####")
	TppRadio.Play( "s0050_rtrg1070" )
end

this.WhyDoNotYouKillQuiet = function()
	Fox.Log("#### s10050_radio.WhyDoNotYouKillQuiet #### isQuietDown = "..tostring(svars.isQuietDown)..", isQuietCarried = "..tostring(svars.isQuietCarried)..", isQuietDead = "..tostring(svars.isQuietDead))
	if ( svars.isQuietDead ) then
		
		if (TppQuest.IsOpen("sovietBase_q99020")  and not(TppQuest.IsCleard("sovietBase_q99020"))) then
			TppRadio.Play( "s0050_rtrg2060", { isOverwriteProtectionForSamePrio = true} )
		end
	elseif ( svars.isQuietDown ) and not( svars.isQuietCarried ) then
		if ( TppRadio.IsPlayed("s0050_rtrg1060") ) then
			TppRadio.Play( "s0050_rtrg2050", { isOverwriteProtectionForSamePrio = true} )
		end
	end
end

this.BeCarefulDeathBullet = function()
	Fox.Log("#### s10050_radio.BeCarefulDeathBullet ####")
	if ( svars.deathBulletCount == 0 ) then
		
		TppRadio.Play( "s0050_rtrg1175" )
	elseif ( svars.deathBulletCount == 1 ) then
		
		TppRadio.Play( "s0050_rtrg1160" )
	else
		
		TppRadio.Play( "s0050_rtrg1170" )
	end
	svars.deathBulletCount = svars.deathBulletCount + 1
end

this.EraseMarkerReaction = function()
	Fox.Log("#### s10050_radio.EraseMarkerReaction ####")
	TppRadio.Play( {"s0050_rtrg5010"}, { delayTime = "short"})
end

this.AvoidQuiet = function()
	Fox.Log("#### s10050_radio.EraseMarkerReaction ####")
	
	if (TppQuest.IsOpen("sovietBase_q99020") and not(TppQuest.IsCleard("sovietBase_q99020")) and not(svars.isQuietDown)) then
		if not( svars.isPlayAvoidQuiet_1 ) then
			TppRadio.Play( {"s0050_rtrg6010"} )
			svars.isPlayAvoidQuiet_1 = true
		else
			TppRadio.Play( {"s0050_rtrg1025"} )
			svars.isPlayAvoidQuiet_1 = false		
		end
	end
end

this.SetRadioFromSituation = function()
	Fox.Log("#### s10050_radio.SetRadioFromSituation #### isUseDeathBullet ["..tostring(svars.isUseDeathBullet).."], isLostPlayer ["..tostring(svars.isLostPlayer).."]")

	local newSetting = {}							
	
	
	if not( svars.isQuietDown or svars.isQuietDead ) then
	
		if ( svars.isUseDeathBullet ) then
			
			TppRadio.SetOptionalRadio("Set_s0050_oprg4000")
			
		elseif ( svars.isLostPlayer ) then
		
			if ( svars.isFirstTimeErase ) then
				
				TppRadio.SetOptionalRadio("Set_s0050_oprg3000")
			else
				
				TppRadio.SetOptionalRadio("Set_s0050_oprg2000")
			end
			
		else
			
			TppRadio.SetOptionalRadio("Set_s0050_oprg1000")

		end
		
		if ( svars.isRecovery ) then
			if ( TppRadio.IsPlayed("s0050_esrg1030") )then
				
				newSetting = { BossQuietGameObjectLocator	= "s0050_esrg1040",}
			else
				
				newSetting = { BossQuietGameObjectLocator	= "s0050_esrg1030",}
			end
		elseif ( svars.isLostPlayer ) then
			
			newSetting = { BossQuietGameObjectLocator	= "s0050_esrg1010",}
		else
			
			newSetting = { BossQuietGameObjectLocator	= "Invalid", }
		end
		
	
	else
		newSetting = {
			BossQuietGameObjectLocator	= "Invalid",
			erl_woods					= "Invalid", 
			erl_gate					= "Invalid", 
			erl_tower_01				= "Invalid", 
			erl_tower_02				= "Invalid",
			erl_tower_03				= "Invalid",








			erl_house_01				= "Invalid", 
			erl_house_02				= "Invalid",
			erl_house_03				= "Invalid",





		}
	end
	TppRadio.ChangeIntelRadio( newSetting )
end



return this