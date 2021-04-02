local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {

	
	{"s0195_rtrg0010",	playOnce = true },		
	{"s0195_rtrg0020",	playOnce = true },		
	{"s0195_rtrg0030",	playOnce = true },		
	{"s0195_rtrg0040",	playOnce = true },		
	{"s0195_rtrg0050",	playOnce = true },		
	{"s0195_rtrg0060",	playOnce = true },		
	{"s0195_rtrg0070",	playOnce = true },		
	{"s0195_rtrg0080",	playOnce = true },		
	{"s0195_rtrg0090",	playOnce = true },		
	{"s0195_rtrg0100",	playOnce = true },		
	{"s0195_rtrg0110",	playOnce = true },		
	{"s0195_rtrg0120",	playOnce = true },		
	{"s0195_rtrg0130",	playOnce = true },		
	{"s0195_rtrg0140",	playOnce = true },		
	{"s0195_rtrg0150",	playOnce = true },		
	{"s0195_rtrg0160",	playOnce = true },		
	{"s0195_rtrg0170",	playOnce = true },		
	{"s0195_rtrg0180",	playOnce = true },		
	{"s0195_rtrg0190",	playOnce = true },		
	{"s0195_rtrg0200",	playOnce = true },		
	{"s0195_rtrg0210",	playOnce = true },		
	{"s0195_rtrg0220",	playOnce = true },		
	{"s0195_rtrg0230",	playOnce = true },		
	{"f1000_rtrg2175",	playOnce = true },		
	{"s0195_rtrg0250",	playOnce = true },		

	{"f1000_rtrg1561",	playOnce = true },		
	{"s0195_rtrg0280",	playOnce = true },		
	{"s0195_rtrg0290",	playOnce = true },		
	{"s0195_rtrg0310",	playOnce = true },		
	{"s0195_rtrg0320",	playOnce = true },		
	
	{"s0195_rtrg0330",	playOnce = true },		
	{"s0195_rtrg0340",	playOnce = true },		
	{"s0195_rtrg0350",	playOnce = true },		
	{"s0195_rtrg0360",	playOnce = true },		
	{"s0195_rtrg0370",	playOnce = true },		
	{"s0195_rtrg0380",	playOnce = true },		
	

	
	"s0195_oprg0010",
	"s0195_oprg0015",
	"s0195_oprg0060",
}






this.optionalRadioList = {

	"Set_s0195_oprg0010",	
	"Set_s0195_oprg0020",	
	"Set_s0195_oprg0030",	
	"Set_s0195_oprg0040",	
	"Set_s0195_oprg0050",	
	"Set_s0195_oprg0060",	
	"Set_s0195_oprg0080",	

}





this.intelRadioList = {
	sol_vip			= "f1000_esrg0730",
	sol_dealer		= "f1000_esrg0740",
}
this.intelRadioList_MarkVip = {
	sol_vip 		 = "s0195_esrg0070",
	sol_vip_driver	 = "s0195_esrg0010",
	sol_vip_pass0000 = "s0195_esrg0010",
	sol_vip_pass0001 = "s0195_esrg0010",

}
this.intelRadioList_MarkDealer = {
	sol_dealer 	= "s0195_esrg0040",
}




this.blackTelephoneDisplaySetting = {
	
	f6000_rtrg0180  = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10195/mb_photo_10195_020_1.ftex", 0.6, "cast_major" }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10195.ftex", 16.5 }, 
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10195_02.ftex", 20 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10195/mb_photo_10195_020_1.ftex", 0.6, "cast_major" }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10195.ftex", 14.5 }, 
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10195_02.ftex", 18 }, 
		},
	},
}



this.commonRadioTable = {}








this.GetKillTargetRadioGroup = function()
	Fox.Log("______________s10195_radio.GetKillTargetRadioGroup() ")

	local temp = "s0195_rtrg0070"
	
	
	
	if svars.DelearLifeStatus == TppGameObject.NPC_LIFE_STATE_DEAD then
		if svars.isInfo then
			temp = "s0195_rtrg0070"
			
		else
			temp = "s0195_rtrg0080"
			
		end
	
	else
		if svars.isInfo then
			temp = "s0195_rtrg0060"
			
		else
			temp = "s0195_rtrg0050"
			
		end
	end
	
	return temp
end
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_ELIMINATED ] 	= this.GetKillTargetRadioGroup





this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10195_TARGET_ESCAPE] 		= "s0195_gmov0020"
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10195_TARGET_ESCAPE_UNREAL] 	= "s0195_gmov0010"









function this.Messages()
	return
	StrCode32Table {
		Trap = {
		
			{ msg = "Enter", sender = "trap_MeetingArea",func = this.FuncMeetingArea },
			nil
		},
	}
end







this.MissionWarning = function()
	if not svars.isKnowVIP and not svars.isKnowDealer and not svars.isCancelMeeting then
		if not svars.isMoveObjective then
			TppRadio.Play( "s0195_rtrg0020" )
		end
	end
end

this.FollowTheVip = function()
	TppRadio.Play( "s0195_rtrg0040" )
end



this.FultonVip = function()
	if not svars.isKnowDealer then
		TppRadio.Play( "s0195_rtrg0170")
	end
end



this.CancelMeeting = function()

	
	

	
	if svars.isAnomalyDealer then
		TppRadio.Play( "s0195_rtrg0370")
		

	
	else
		
		if svars.VipArea < s10195_sequence.AREA_STATUS.MEETING_AREA then
			
			if svars.VipLifeStatus == TppGameObject.NPC_LIFE_STATE_DEAD then
				if svars.isKnowDealer == false then
					TppRadio.Play( {"s0195_rtrg0250","s0195_rtrg0380"})	
				end
			
			elseif svars.VipLifeStatus == TppGameObject.NPC_LIFE_STATE_FAINT or
					svars.VipLifeStatus == TppGameObject.NPC_LIFE_STATE_DYING then

				if svars.isKnowDealerPlace then
					TppRadio.Play( {"s0195_rtrg0150","s0195_rtrg0140","s0195_rtrg0380"})	
				else
					TppRadio.Play( {"s0195_rtrg0150","s0195_rtrg0130","s0195_rtrg0380"})	
				end


			
			else
				if svars.isKnowDealerPlace then
					TppRadio.Play( {"s0195_rtrg0090","s0195_rtrg0110","s0195_rtrg0380"})	
				else
					TppRadio.Play( {"s0195_rtrg0090","s0195_rtrg0100","s0195_rtrg0380"})	
				end
			end
		end
	end


end


this.TargetNeutralize = function()
	
	
	if svars.DelearLifeStatus == TppGameObject.NPC_LIFE_STATE_DEAD then
		if svars.isInfo then
			TppRadio.Play( "s0195_rtrg0070")
		else
			TppRadio.Play( "s0195_rtrg0080")
		end
	
	else
		if svars.isInfo then
			TppRadio.Play( "s0195_rtrg0060")
		else
			TppRadio.Play( "s0195_rtrg0050")
		end
	end
end

this.FuncMeetingArea = function()
	






	if svars.isCancelMeeting and svars.isKnowDealerPlace and svars.isLeaveMA and not svars.isKnowDealer then
		TppRadio.Play( "s0195_rtrg0360")
	end

end

this.FuncRideOnCar = function(vehicleId)
	
	
	if svars.isKnowVIP and not svars.isEndMeeting then
	
		
		if vehicleId == GameObject.GetGameObjectId("Vehs_lv_savannahEast_0000") then
			
			TppRadio.SetOptionalRadio( "Set_s0195_oprg0020" )
		end
	
		
		if vehicleId == GameObject.GetGameObjectId("Vehs_lv_hillNorth_0000") then
			TppRadio.Play( "s0195_rtrg0230")
		end
	end
	
end

this.FuncGotOutCar = function()

	if svars.isKnowVIP and not svars.isSolVipCarAccident then
		TppRadio.Play( "s0195_rtrg0220")
		
		TppRadio.SetOptionalRadio( "Set_s0195_oprg0060" )
	end
	

end

this.IsNormalRoute = function()
	
	local gameObjectId = GameObject.GetGameObjectId( "TppSoldier2", "sol_vip" )
	local command1 = { id = "IsOnRoute", route="rts_v_hillNorth", }
	local isOnRoute1 = GameObject.SendCommand( gameObjectId, command1 )
	
	local command2 = { id = "IsOnRoute", route="rts_hillNorth_toNextCar", }
	local isOnRoute2 = GameObject.SendCommand( gameObjectId, command2 )
	
	if isOnRoute1 or isOnRoute2 then
		return true
	else
		return false
	end
end



this.ContinueObjective = function()

end



this.TelephoneRadio = function()
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0180" ) 
end




return this
