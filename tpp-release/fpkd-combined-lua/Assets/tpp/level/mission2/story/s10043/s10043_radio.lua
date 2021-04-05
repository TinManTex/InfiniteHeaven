local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


this.OPTIONALRADIO_NAME = {
	MISSIONSTART							= "Set_s0043_oprg0010",
	ARRIVALATCOMMFACILITY_MARKER_OFF		= "Set_s0043_oprg0020",
	ARRIVALATCOMMFACILITY_MARKER_ON			= "Set_s0043_oprg0025",
	MISSINCOMPLETE							= "Set_s0043_oprg0030",
}




this.radioList = {
	
	"s0043_rtrg0010",				
	"s0043_rtrg0013",				
	"s0043_rtrg0015",				
	{"s0043_rtrg1013", playOnce = true},				
	{"s0043_rtrg1015", playOnce = true},				
	{"s0043_rtrg1020", playOnce = true},				
	"s0043_rtrg0060",				
	"s0043_rtrg0061",				
	"s0043_rtrg0070",				
	"s0043_rtrg0063",				
	"s0043_rtrg0062",				
	"s0043_rtrg0065",				
	"s0043_rtrg0075",				
	"s0043_rtrg1030",				
	"s0043_rtrg1032",				
	"s0043_rtrg1040",				
	"s0043_rtrg1050",				
	"s0043_rtrg2010",				
	"s0043_rtrg2011",				
	"s0043_rtrg0110",				
	"s0043_rtrg3015",				
	"s0043_rtrg3016",				
	"s0043_rtrg3017",				
	
	"f1000_rtrg3030",				
	"f1000_rtrg3040",				
	{"f1000_rtrg1470", playOnce = true},		
	
	"f1000_rtrg2160",				
	
	"s0043_mirg0020",				
	
	"s0043_mprg0010",				
	"s0043_mprg0030",				
}





this.optionalRadioList = {
	this.OPTIONALRADIO_NAME.MISSIONSTART,								
	this.OPTIONALRADIO_NAME.ARRIVALATCOMMFACILITY_MARKER_OFF,			
	this.OPTIONALRADIO_NAME.ARRIVALATCOMMFACILITY_MARKER_ON,			
	this.OPTIONALRADIO_NAME.MISSINCOMPLETE,								
}





this.intelRadioList = {
	rds_commFacility_0000	= "s0043_esrg0090",							
	type_antenna			= "s0043_esrg0018",							
	type_translate			= "s0043_esrg0020",							
	type_searchradar		= "f1000_esrg1140",							
	type_gunMount			= "f1000_esrg1120",							
	type_mortar				= "f1000_esrg1130",							
	type_trash				= "f1000_esrg1070",							
}














this.GetMissionStart = function()
	Fox.Log("#### s10043_radio.MissionStart ####")
	local radioGroups
	radioGroups = "s0043_rtrg0010"
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.MISSIONSTART )
	return radioGroups
end


this.GetBreakAnntenaOne = function()
	Fox.Log("#### s10043_radio.BreakAnntenaOne ####")
	return "s0043_rtrg1030"
end


this.GetBreakAnntenaTwo = function()
	Fox.Log("#### s10043_radio.BreakAnntenaTwo ####")
	return "s0043_rtrg1032"
end


this.GetMarkingAnntena01 = function()
	Fox.Log("#### s10043_radio.MarkingAnntena01 ####")
	return "s0043_rtrg0060"
end


this.GetMarkingAnntena02 = function()
	Fox.Log("#### s10043_radio.MarkingAnntena02 ####")
	return "s0043_rtrg0061"
end


this.GetMarkingAllAnntena = function( defaultBreakAntnCount )
	Fox.Log("#### s10043_radio.MarkingAllAnntena ####")
	local radioGroups
	if defaultBreakAntnCount == 0 then
		radioGroups = "s0043_rtrg0062"
	elseif defaultBreakAntnCount == 1 then
		radioGroups = "s0043_rtrg0063"
	else
		radioGroups = "s0043_rtrg0065"
	end
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.ARRIVALATCOMMFACILITY_MARKER_ON )
	return radioGroups
end


this.GetMarkingComm = function()
	Fox.Log("#### s10043_radio.MarkingComm ####")
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.ARRIVALATCOMMFACILITY_MARKER_ON )
	return "s0043_rtrg0070"
end


this.GetInterrogationMarking = function()
	Fox.Log("#### s10043_radio.InterrogationMarking ####")
	return "f1000_rtrg2160"
end






this.ContinueMissionStart = function()
	Fox.Log("#### s10043_radio.ContinueMissionStart ####")
	TppRadio.Play( "s0043_rtrg0013", { delayTime = "mid" } )
end


this.MissionStartGameClear = function()
	Fox.Log("#### s10043_radio.MissionStartGameClear ####")
	TppRadio.Play( "s0043_rtrg0015", { delayTime = "short" })
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.MISSINCOMPLETE )
end


this.ArrivalAtcommFacilityMarkerOn = function()
	Fox.Log("#### s10043_radio.ArrivalAtcommFacilityMarkerOn ####")
	TppRadio.Play( "s0043_rtrg1013" , { delayTime = "short" })
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.ARRIVALATCOMMFACILITY_MARKER_ON )
end


this.ArrivalAtcommFacilityMarkerOff = function()
	Fox.Log("#### s10043_radio.ArrivalAtcommFacilityMarkerOff ####")
	TppRadio.Play( "s0043_rtrg1015" , { delayTime = "short" })
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.ARRIVALATCOMMFACILITY_MARKER_OFF )
end


this.ArrivalAtcommFacilityNoExplosionWeapons = function()
	Fox.Log("#### s10043_radio.ArrivalAtcommFacilityNoExplosionWeapons ####")
	TppRadio.Play( "s0043_rtrg1020" , { delayTime = "short" })
end


this.BreakAirSearchRadar = function()
	Fox.Log("#### s10043_radio.BreakAirSearchRadar ####")
	TppRadio.Play( "s0043_rtrg1040" , { delayTime = "short" })
end


this.MarkingAllTarget = function( objectives )
	Fox.Log("#### s10043_radio.MarkingAllTarget ####")
	TppRadio.Play( "s0043_rtrg0075" , { delayTime = "short" })
end


this.DiscoveryTarget = function()
	Fox.Log("#### s10043_radio.DiscoveryTarget ####")
	TppRadio.Play( "s0043_rtrg1050" , { delayTime = "short" })
end






this.Equip_C4 = function()
	Fox.Log("#### s10043_radio.Equip_C4 ####")
	if svars.isShowControlGuide_C4_01 == false then
		TppRadio.Play( "f1000_rtrg3030", { delayTime = "mid" } )
		svars.isShowControlGuide_C4_01 = true
	end
end


this.PutPlaced_C4 = function()
	Fox.Log("#### s10043_radio.PutPlaced_C4 ####")
	if svars.isShowControlGuide_C4_02 == false then
		TppRadio.Play( "f1000_rtrg3040", { delayTime = "mid" } )
		svars.isShowControlGuide_C4_02 = true
	end
end


this.AmmoStackEmpty_C4 = function()
	Fox.Log("#### s10043_radio.AmmoStackEmpty_C4 ####")
	if TppMission.IsSubsistenceMission() == false then	
		TppRadio.Play( "f1000_rtrg1470", { delayTime = "mid",isEnqueue = true, } )
	end
end






this.SetMissionClear = function()
	Fox.Log("#### s10043_radio.SetMissionClear ####")
	
	TppRadio.SetOptionalRadio( this.OPTIONALRADIO_NAME.MISSINCOMPLETE )
	
	TppRadio.ChangeIntelRadio( { type_antenna = "Invalid" } )
	TppRadio.ChangeIntelRadio( { type_translate = "Invalid" } )
end




return this
