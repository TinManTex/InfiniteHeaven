local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ] = TppRadio.IGNORE_COMMON_RADIO



this.radioList = {
	{"s0054_rtrg2010", playOnce = true},	
	{"s0054_rtrg2020", playOnce = true},	
	{"s0054_rtrg2030", playOnce = true},	
	{"s0054_rtrg2040", playOnce = true},	
	{"s0054_rtrg2050", playOnce = true},	
	{"s0054_rtrg2060", playOnce = true},	
	{"s0054_rtrg2070", playOnce = true},	
	{"s0054_rtrg2080", playOnce = true},	
	{"s0054_rtrg2090", playOnce = true},	
	{"s0054_rtrg2100", playOnce = true},	
	{"s0054_rtrg2110", playOnce = true},	
	{"s0054_rtrg2120", playOnce = true},	
	"s0054_rtrg2130",				
	{"s0054_rtrg2140", playOnce = true},	
	"s0054_rtrg2160",				
	"s0054_rtrg2170",				
	{"s0054_rtrg2180", playOnce = true},	
	"s0054_rtrg3010",				
	{"s0054_rtrg3020", playOnce = true},	
	{"s0054_rtrg3040", playOnce = true},	
	{"s0054_rtrg3050", playOnce = true},	
	"s0054_rtrg3060",				
	"f1000_rtrg3280",				
	"f1000_rtrg3290",				
	"f1000_rtrg3300",				
	"f1000_rtrg3310",				
	"f1000_rtrg3320",				
	"f1000_rtrg3330",				
	"f1000_rtrg3340",				
	"f1000_rtrg3350",				
	"f1000_rtrg3360",				
	"f1000_rtrg3370",				
	"f1000_rtrg3380",				
	"f1000_rtrg3390",				
	"f1000_rtrg3400",				
	"f1000_rtrg1562",				
	"f1000_rtrg3410",				
	"f1000_rtrg3420",				

	"f1000_rtrg3430",				
	"f1000_rtrg3440",				
	"f1000_rtrg3450",				
	"f1000_rtrg3460",				
	"f1000_rtrg3470",				
	"f1000_rtrg3480",				

	"f1000_rtrg3490",				
	"f1000_rtrg3500",				
	"f1000_rtrg3510",				
	"f1000_rtrg3520",				
	"f1000_rtrg3530",				
	"s0054_rtrg2160",				
	"f1000_rtrg3540",				
	"s0054_rtrg2170",				
	
	"f1000_rtrg0745",				
	"f1000_rtrg1674",				
	"f1000_rtrg1675",				
	"f1000_rtrg1676",				
	"f1000_rtrg1677",				
	"f1000_rtrg1678",				
}




this.optionalRadioList = {
	"Set_s0054_oprg0010",	
	"Set_s0054_oprg0020",	
	"Set_s0054_oprg0030",	
	"Set_s0054_oprg0040",	
	"Set_s0054_oprg0050",	
	"Set_s0054_oprg0060",	
}

this.optionalRadio_01 = function()
	TppRadio.SetOptionalRadio("Set_s0054_oprg0010")
end

this.optionalRadio_02 = function()
	TppRadio.SetOptionalRadio("Set_s0054_oprg0040")
end

this.optionalRadio_03 = function()
	TppRadio.SetOptionalRadio("Set_s0054_oprg0030")
end

this.optionalRadio_04 = function()
	TppRadio.SetOptionalRadio("Set_s0054_oprg0020")
end

this.optionalRadio_escape = function()
	TppRadio.SetOptionalRadio("Set_s0054_oprg0050")
end

this.optionalRadio_bonus = function()
	TppRadio.SetOptionalRadio("Set_s0054_oprg0060")
end




this.intelRadioList = {
	
	type_gunMount		= "f1000_esrg2040",	
	type_mortar			= "f1000_esrg2050",	
	
	EnemyHeli			= "s0054_rtrg2170",
	hos_s10054_0005		= "f1000_esrg2060",
	hos_s10054_0000		= "f1000_esrg2060",
	hos_s10054_0002		= "f1000_esrg2060",
}
this.intelRadioList_HostageDead_MNT = {
	
	hos_s10054_0005		= "Invalid",
}
this.intelRadioList_HostageDead_RIV = {
	
	hos_s10054_0000		= "Invalid",
}
this.intelRadioList_HostageDead_SAN = {
	
	hos_s10054_0002		= "Invalid",
}
this.intelRadioList_gunMount2nd = {
	type_gunMount		= "f1000_esrg0020",
}
this.intelRadioList_mortar2nd = {
	type_mortar			= "f1000_esrg0050",
}

this.ChangeIntelRadio_HostageDead_MNT = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_HostageDead_MNT )
end

this.ChangeIntelRadio_HostageDead_RIV = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_HostageDead_RIV )
end

this.ChangeIntelRadio_HostageDead_SAN = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_HostageDead_SAN )
end

this.ChangeIntelRadio_gunMount2nd = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_gunMount2nd )
end

this.ChangeIntelRadio_mortar2nd = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_mortar2nd )
end





this.missionStart = function()
	Fox.Log("#### s10054_radio.missionStart ####")
	TppRadio.Play( "s0054_rtrg2010" )
end

this.confirmationTarget = function()
	Fox.Log("#### s10054_radio.confirmationTarget ####")
	TppRadio.Play( "s0054_rtrg2020" )
end

this.noTargetClear_halfTime = function()
	Fox.Log("#### s10054_radio.noTargetClear_halfTime ####")
	TppRadio.Play( "s0054_rtrg2030" )
end

this.TargetClear_halfTime_nml = function()
	Fox.Log("#### s10054_radio.TargetClear_halfTime_nml ####")
	TppRadio.Play( "s0054_rtrg2040" )
end

this.TargetClear_halfTime_high = function()
	Fox.Log("#### s10054_radio.TargetClear_halfTime_high ####")
	TppRadio.Play( "s0054_rtrg2050" )
end

this.EmergencyTime = function()
	Fox.Log("#### s10054_radio.EmergencyTime ####")
	TppRadio.Play( "s0054_rtrg2060" )
end

this.noTargetClear_EmergencyTime = function()
	Fox.Log("#### s10054_radio.noTargetClear_EmergencyTime ####")
	TppRadio.Play( "s0054_rtrg2070" )
end

this.TargetClear_EmergencyTime_01 = function()
	Fox.Log("#### s10054_radio.TargetClear_EmergencyTime_01 ####")
	TppRadio.Play( "s0054_rtrg2080" )
end

this.TargetClear_EmergencyTime_02 = function()
	Fox.Log("#### s10054_radio.TargetClear_EmergencyTime_02 ####")
	TppRadio.Play( "s0054_rtrg2090" )
end

this.Seq_MainGame_Continue = function()
	Fox.Log("#### s10054_radio.Seq_MainGame_Continue ####")
	TppRadio.Play( "s0054_rtrg2130" )
end

this.Seq_EscapeGame_Continue = function()
	Fox.Log("#### s10054_radio.Seq_EscapeGame_Continue ####")
	TppRadio.Play( "s0054_rtrg3010" )
end

this.escape_AllTargetClear_after = function()
	Fox.Log("#### s10054_radio.escape_AllTargetClear_after ####")
	TppRadio.Play( "s0054_rtrg3040" )
end

this.escape_TargetClear = function()
	Fox.Log("#### s10054_radio.escape_TargetClear ####")
	TppRadio.Play( "s0054_rtrg3020" )
end

this.comeTo_areaOut01 = function()
	Fox.Log("#### s10054_radio.comeTo_areaOut01 ####")
	TppRadio.Play( "s0054_rtrg2110" )
end

this.comeTo_areaOut02 = function()
	Fox.Log("#### s10054_radio.comeTo_areaOut02 ####")
	TppRadio.Play( "s0054_rtrg2120" )
end

this.escape_AllTargetClear = function()
	Fox.Log("#### s10054_radio.escape_AllTargetClear ####")
	TppRadio.Play( "s0054_rtrg2100" )
end

this.TargetBroken_CNT_1 = function()
	Fox.Log("#### s10054_radio.TargetBroken_CNT_1 ####")
	TppRadio.Play( "f1000_rtrg3330" )
end

this.TargetBroken_CNT_2 = function()
	Fox.Log("#### s10054_radio.TargetBroken_CNT_2 ####")
	TppRadio.Play( "f1000_rtrg3340" )
end

this.TargetBroken_CNT_3 = function()
	Fox.Log("#### s10054_radio.TargetBroken_CNT_3 ####")
	TppRadio.Play( "f1000_rtrg3350" )
end

this.TargetBroken_CNT_4 = function()
	Fox.Log("#### s10054_radio.TargetBroken_CNT_4 ####")
	TppRadio.Play( "f1000_rtrg3360" )
end

this.TargetBroken_CNT_5 = function()
	Fox.Log("#### s10054_radio.TargetBroken_CNT_5 ####")
	TppRadio.Play( "f1000_rtrg3370" )
end

this.TargetBroken_CNT_6 = function()
	Fox.Log("#### s10054_radio.TargetBroken_CNT_6 ####")
	TppRadio.Play( "f1000_rtrg3380" )
end

this.bulletTruck = function()
	Fox.Log("#### s10054_radio.bulletTruck ####")
	TppRadio.Play( "f1000_rtrg3300" )
end

this.hostageVehicle_start = function()
	Fox.Log("#### s10054_radio.hostageVehicle_start ####")
	TppRadio.Play( "f1000_rtrg3460" )
end


this.hostageInfo_hideTarget = function()
	Fox.Log("#### s10054_radio.hostageInfo_hideTarget ####")
	TppRadio.Play( "s0054_rtrg2140" )
end

this.bonusTank_headMark = function()
	Fox.Log("#### s10054_radio.bonusTank_headMark ####")
	TppRadio.Play( "s0054_rtrg2160" )
end

this.bonusHeli_headMark = function()
	Fox.Log("#### s10054_radio.bonusHeli_headMark ####")
	TppRadio.Play( "s0054_rtrg2170" )
end

this.noMore_reinforce = function()
	Fox.Log("#### s10054_radio.noMore_reinforce ####")
	TppRadio.Play( "s0054_rtrg2180" )
end

this.bonus_EnemyHeli_Clear = function()
	Fox.Log("#### s10054_radio.bonus_EnemyHeli_Clear ####")
	TppRadio.Play( "s0054_rtrg3050" )
end

this.bonus_Tank_Clear = function()
	Fox.Log("#### s10054_radio.bonus_Tank_Clear ####")
	TppRadio.Play( "s0054_rtrg3060" )
end

this.discovery_hideTargetVehicle01 = function()
	Fox.Log("#### s10054_radio.discovery_hideTargetVehicle01 ####")
	TppRadio.Play( "f1000_rtrg3310" )
end

this.discovery_hideTargetVehicle02 = function()
	Fox.Log("#### s10054_radio.discovery_hideTargetVehicle02 ####")
	TppRadio.Play( "f1000_rtrg3320" )
end

this.TargetFulton_succes_01 = function()
	Fox.Log("#### s10054_radio.TargetFulton_succes ####")
	TppRadio.Play( "f1000_rtrg3390" )
end

this.TargetFulton_succes_02 = function()
	Fox.Log("#### s10054_radio.TargetFulton_succes ####")
	TppRadio.Play( "f1000_rtrg3400" )
end

this.TargetFulton_succes_03 = function()
	Fox.Log("#### s10054_radio.TargetFulton_succes ####")
	TppRadio.Play( "f1000_rtrg1562" )
end

this.TargetFulton_failed_01 = function()
	Fox.Log("#### s10054_radio.TargetFulton_failed ####")
	TppRadio.Play( "f1000_rtrg3410" )
end

this.TargetFulton_failed_02 = function()
	Fox.Log("#### s10054_radio.TargetFulton_failed ####")
	TppRadio.Play( "f1000_rtrg3420" )
end

this.Target_movingStart = function()
	Fox.Log("#### s10054_radio.Target_movingStart ####")
	TppRadio.Play( "f1000_rtrg3280" )
end

this.comeTo_areaOut03 = function()
	Fox.Log("#### s10054_radio.comeTo_areaOut03 ####")
	TppRadio.Play( "f1000_rtrg3290" )
end

this.targetVehicle_areaOut_01 = function()
	Fox.Log("#### s10054_radio.targetVehicle_areaOut ####")
	TppRadio.Play( "f1000_rtrg3430" )
end

this.targetVehicle_areaOut_02 = function()
	Fox.Log("#### s10054_radio.targetVehicle_areaOut ####")
	TppRadio.Play( "f1000_rtrg3440" )
end

this.targetVehicle_areaOut_03 = function()
	Fox.Log("#### s10054_radio.targetVehicle_areaOut ####")
	TppRadio.Play( "f1000_rtrg3450" )
end

this.hostageVehicle_moving = function()
	Fox.Log("#### s10054_radio.hostageVehicle_moving ####")
	TppRadio.Play( "f1000_rtrg3470" )
end

this.markingTarget_01 = function()
	Fox.Log("#### s10054_radio.markingTarget_01 ####")
	TppRadio.Play( "f1000_rtrg3480" )
end








this.markingTarget_03 = function()
	Fox.Log("#### s10054_radio.markingTarget_03 ####")
	TppRadio.Play( "f1000_rtrg3490" )
end

this.markingTargetRct_01 = function()
	Fox.Log("#### s10054_radio.markingTargetRct_01 ####")
	TppRadio.Play( "f1000_rtrg3500" )
end

this.markingTargetRct_02 = function()
	Fox.Log("#### s10054_radio.markingTargetRct_02 ####")
	TppRadio.Play( "f1000_rtrg3510" )
end

this.markingTargetRct_03 = function()
	Fox.Log("#### s10054_radio.markingTargetRct_03 ####")
	TppRadio.Play( "f1000_rtrg3520" )
end

this.markingBonusTank_01 = function()
	Fox.Log("#### s10054_radio.markingBonusTank_01 ####")
	TppRadio.Play( "f1000_rtrg3530" )
end

this.markingBonusTank_02 = function()
	Fox.Log("#### s10054_radio.markingBonusTank_02 ####")
	TppRadio.Play( "s0054_rtrg2160" )
end

this.markingBonusTank_03 = function()
	Fox.Log("#### s10054_radio.markingBonusTank_03 ####")
	TppRadio.Play( "f1000_rtrg3540" )
end

this.markingBonusHeli = function()
	Fox.Log("#### s10054_radio.markingBonusHeli ####")
	TppRadio.Play( "s0054_rtrg2170" )
end

this.occelotAdvice = function()
	Fox.Log("#### s10054_radio.occelotAdvice ####")
	TppRadio.Play( "f1000_rtrg0745" , { delayTime = "short" })
end

this.last_3min = function()
	Fox.Log("#### s10054_radio.occelotAdvice ####")
	TppRadio.Play( "f1000_rtrg1674" )
end

this.last_2min = function()
	Fox.Log("#### s10054_radio.occelotAdvice ####")
	TppRadio.Play( "f1000_rtrg1675" )
end

this.last_1min = function()
	Fox.Log("#### s10054_radio.occelotAdvice ####")
	TppRadio.Play( "f1000_rtrg1676" )
end

this.last_5s = function()
	Fox.Log("#### s10054_radio.occelotAdvice ####")
	TppRadio.Play( "f1000_rtrg1677" )
end

this.last_30s = function()
	Fox.Log("#### s10054_radio.occelotAdvice ####")
	TppRadio.Play( "f1000_rtrg1678" )
end



return this
