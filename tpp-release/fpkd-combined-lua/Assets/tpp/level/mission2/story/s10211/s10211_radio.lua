local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {

	
	{"s0211_rtrg0010", playOnce = false },	
	
	{"s0211_rtrg1010", playOnce = false },


	
	{"s0211_rtrg1020", playOnce = false },	
	{"f1000_rtrg1230", playOnce = false },	
	{"f1000_rtrg1240", playOnce = false },	
	
	

	
	{"s0211_rtrg2010", playOnce = false },	
	{"s0211_rtrg2011", playOnce = false },	

	{"s0211_oprg2005", playOnce = false },	

	{"s0211_rtrg4031", playOnce = false },

	{"f1000_rtrg3190", playOnce = false },	
	
	{"f1000_rtrg1250", playOnce = false },	
	{"s0211_rtrg0030", playOnce = false },	
	{"s0211_rtrg0031", playOnce = false },	
	{"s0211_rtrg0040", playOnce = false },		
	{"f1000_rtrg2530", playOnce = false },	
	{"s0211_rtrg5011", playOnce = false },	
	{"s0211_rtrg5012", playOnce = false },	

	{"f1000_rtrg2610", playOnce = false },	
	{"s0211_rtrg5016", playOnce = false },	

	{"f1000_rtrg2620", playOnce = false },	

	{"s0211_rtrg5019", playOnce = false },	
	{"s0211_rtrg5018", playOnce = false },	

	
	{"f1000_rtrg1420", playOnce = false },	
	{"f1000_rtrg2650", playOnce = false },	
	{"f6000_rtrg0200", playOnce = false },	
	
	{"s0211_rtrg1000", playOnce = false },	
	{"s0211_rtrg1001", playOnce = false },	

	{"s0211_rtrg3000", playOnce = false },	
	{"s0211_rtrg4000", playOnce = false },	
	{"s0211_rtrg4040", playOnce = false },		
	{"f1000_rtrg7010", playOnce = false },		
	{"f1000_esrg0760", playOnce = false },		
	{"f1000_esrg0790", playOnce = false },		

	{"f1000_rtrg2090", playOnce = false },		
	{"f1000_oprg0460", playOnce = false },		
	{"f1000_oprg0940", playOnce = false },		


	{"f1000_esrg0090", playOnce = false },		
	{"f1000_rtrg2930", playOnce = false },		
	{"f1000_rtrg0620", playOnce = false },		
	{"s0211_rtrg5070", playOnce = false },		
	{"s0211_rtrg5071", playOnce = false },		


	
	{"s0211_mprg0010", playOnce = false },		
	{"s0211_mprg0020", playOnce = false },		
	{"s0211_mprg0021", playOnce = false },		
	{"s0211_mprg0022", playOnce = false },		
	{"s0211_mprg0023", playOnce = false },		


	{"s0211_mprg2010", playOnce = false },	
	{"s0211_mprg2020", playOnce = false },		
	{"s0211_mprg4010", playOnce = false },		
	{"s0211_mprg4020", playOnce = false },		
	{"s0211_mprg4030", playOnce = false },		

	{"f1000_rtrg0010", playOnce = false },			
	{"f1000_rtrg1650", playOnce = false },		
	{"s0211_rtrg3010" , playOnce = false },
	{"s0211_rtrg5050", playOnce = false },
	{"s0211_rtrg5051", playOnce = false },
	{"s0211_rtrg5052", playOnce = false },
	{"s0211_rtrg5060", playOnce = false },
	{"s0211_rtrg1021", playOnce = false },	
	{"s0211_rtrg1040", playOnce = false },	
	{"f1000_esrg0760", playOnce = false },	
	{"s0211_rtrg5080", playOnce = false },	




}
this.commonRadioTable = {
























	[ TppDefine.COMMON_RADIO.TARGET_MARKED	] 				= TppRadio.IGNORE_COMMON_RADIO,		

	[ TppDefine.COMMON_RADIO.TARGET_RECOVERED  ] 			= TppRadio.IGNORE_COMMON_RADIO,		
	[ TppDefine.COMMON_RADIO.TARGET_ELIMINATED	] 			= TppRadio.IGNORE_COMMON_RADIO,		
}




this.optionalRadioList = {
	"Set_s0211_oprg0010",	
	"Set_s0211_oprg0020",	
	"Set_s0211_oprg0021",	
	"Set_s0211_oprg0022",	
	"Set_s0211_oprg0030",	
	"Set_s0211_oprg0100",	
	"Set_s0211_oprg2000",	
	"Set_s0211_oprg2001",	
	"Set_s0211_oprg3010",	
	"Set_s0211_oprg5010",	
}





this.intelRadioList = {

	rds_EspRadioLocator_rock	= "f1000_esrg1830",		
	rds_EspRadioLocator_intelTent	= "s0211_esrg0010",		
	hos_mis_0000			= "f1000_esrg0790",		
	hos_mis_0001			= "f1000_esrg0790",		
	hos_mis_0002			= "f1000_esrg0790",		
	hos_mis_0003			= "f1000_esrg0790",		
	sol_mis_0000			= "s0211_esrg0051",		
	sol_mis_0001			= "s0211_esrg0040",		
	sol_mis_0002			= "s0211_esrg0040",		
	sol_mis_0003			= "s0211_esrg0040",		
	sol_mis_0004			= "s0211_esrg0040",		
	sol_mis_0005			= "s0211_esrg0040",		

	sol_bananaSouth_0000	=	"s0211_esrg0051",
	sol_bananaSouth_0001	=	"s0211_esrg0051",
	sol_bananaSouth_0002	=	"s0211_esrg0051",

	sol_savannahWest_0000	=	"s0211_esrg0051",
	sol_savannahWest_0001	=	"s0211_esrg0051",
	sol_savannahWest_0002	=	"s0211_esrg0051",

	sol_lrrp_04_07_0000	=	"s0211_esrg0051",
	sol_lrrp_04_07_0001	=	"s0211_esrg0051",
	sol_lrrp_04_07_0002	=	"f1000_esrg2070",
	sol_lrrp_04_07_0003	=	"f1000_esrg2070",


}
this.intelRadioListTargetFound = {
	sol_mis_0000			= "s0211_esrg0030",		
}

this.intelRadioListTargetNotFoundTwice = {
	sol_mis_0000			= "s0211_esrg0052",		
}
this.intelRadioListRogueCoyoteTwice = {
	sol_bananaSouth_0000	=	"s0211_esrg0052",
	sol_bananaSouth_0001	=	"s0211_esrg0052",
	sol_bananaSouth_0002	=	"s0211_esrg0052",

	sol_savannahWest_0000	=	"s0211_esrg0052",
	sol_savannahWest_0001	=	"s0211_esrg0052",
	sol_savannahWest_0002	=	"s0211_esrg0052",

	sol_lrrp_04_07_0000	=	"s0211_esrg0052",
	sol_lrrp_04_07_0001	=	"s0211_esrg0052",
}








this.blackTelephoneDisplaySetting = {

	f6000_rtrg0200	= {
		Japanese = {
			{ "face", "ocelot", 0.0 },
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10211/mb_photo_10211_010_1.ftex", 0.6,"cast_trafficker" },
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_03.ftex", 2.8 },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_04.ftex", 6.6 },
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_05.ftex", 13.2,"cast_skull_face" },
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_02.ftex", 24.9 },
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_09.ftex", 51.8 },
		},
		English = {
			{ "face", "ocelot", 0.0 },
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10211/mb_photo_10211_010_1.ftex", 0.6,"cast_trafficker" },
			{ "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_03.ftex", 2.8 },
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_04.ftex", 7.4 },
			{ "sub_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_05.ftex", 13.2,"cast_skull_face" },
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_02.ftex", 23.1 },
			{ "main_4", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10211_09.ftex", 49.4 },
		},
	},
}












this.MissionStart = function()
	Fox.Log("#### s10211_radio.MissionStart ####")

	local radioGroups
	if TppSequence.GetContinueCount() == 0 then	
		Fox.Log("#### StartFirst  ####")
		radioGroups = { "s0211_rtrg0010", }	

	else	
		Fox.Log("#### continue  ####")
		if svars.isTargetArrivedSwamp== true then
			if svars.isTargetFound then		
				TppRadio.Play( "s0211_rtrg4040")
			else
				TppRadio.Play( "s0211_rtrg3000")
			end
		else
			radioGroups = { "s0211_rtrg1001", }	
		end
	end

	return radioGroups
end


this.AfterGetDocument = function()
	Fox.Log("#### s10211_radio.Seq_Game_AfterGetDocument ####")

	if TppSequence.GetContinueCount() == 0 then	
		Fox.Log("#### StartFirst  ####")

		if svars.isTargetArrivedSwamp== true then
			TppRadio.Play( "s0211_rtrg2011")
		else
			TppRadio.Play( "s0211_rtrg2010")
		end
	else	
		Fox.Log("#### continue  ####")

		if svars.isTargetArrivedSwamp== true then
			TppRadio.Play( "s0211_rtrg3000")
		else
			TppRadio.Play( "s0211_rtrg1000")
		end
	end
end



this.KillTarget = function()
	Fox.Log("#### s10211_radio.KillTarget ####")

	local radioGroups
	if TppSequence.GetContinueCount() == 0 then	
		Fox.Log("#### StartFirst  ####")
		radioGroups = { "f1000_rtrg1250", }	

	else	
		Fox.Log("#### continue  ####")

		if svars.isTargetArrivedSwamp== true then
			radioGroups = { "s0211_rtrg4040", }	
		else
			radioGroups = { "s0211_rtrg4000", }	
		end

	end

	return radioGroups
end






this.EscapeStartRadio = function()
	Fox.Log("#### s10211_radio.EscapeStartRadio  ####")
	
	if TppSequence.GetContinueCount() == 0 then	
		Fox.Log("#### StartFirst  ####")
		
	else	
		Fox.Log("#### continue  ####")
		TppRadio.Play( "f1000_rtrg7010")
	end
end




this.MissionClear = function()
	Fox.Log("#### s10211_radio.MissionClear ####")
	TppRadio.Play( "f1000_rtrg2650" )	
end





this.TargetDead = function()
	Fox.Log("#### s10211_radio.TargetDead ####")
	TppRadio.Play( "f1000_rtrg2530",{delayTime = "mid"}  )	
	s10211_sequence.vipTaskCheckKill()	

end
this.TargetDeadNotIdentified = function()
	Fox.Log("#### s10211_radio.TargetDeadNotIdentified ####")
	TppRadio.Play( "s0211_rtrg5011",{delayTime = "mid"}  )	
	s10211_sequence.vipTaskCheckKill()	

end


this.TargetAnimalkill = function()	
	Fox.Log("#### s10211_radio.TargetAnimalkill ####")
	TppRadio.Play( "s0211_rtrg5012" )
	s10211_sequence.vipTaskCheckKill()	

end




this.FultonTarget = function()
	Fox.Log("#### s10211_radio.FultonTarget ####")

	TppRadio.Play( "f1000_rtrg2610" ,{delayTime = "mid", isEnqueue = true} )	

end

this.FultonTargetNotIdentified = function()
	Fox.Log("#### s10211_radio.FultonTargetNotIdentified ####")

	TppRadio.Play( "s0211_rtrg5016",{delayTime = "mid", isEnqueue = true}  )	
end

this.FultonFailed = function()
	Fox.Log("#### s10211_radio.FultonFailed ####")

	TppRadio.Play( "s0211_rtrg5019" ,{delayTime = "mid", isEnqueue = true} )	
	s10211_sequence.vipTaskCheckKill()	

end

this.FultonFailedNotIdentified = function()
	Fox.Log("#### s10211_radio.FultonFailedNotIdentified ####")

	TppRadio.Play( "s0211_rtrg5018",{delayTime = "mid", isEnqueue = true} )	
	s10211_sequence.vipTaskCheckKill()	

end

this.VipCpCaution = function()
	Fox.Log("#### s10211_radio.VipCpCaution ####")
	if svars.isTargetArrivedSwamp== true then
		TppRadio.Play( "s0211_rtrg0031"  )	
	elseif svars.isGetIntel== true then
		TppRadio.Play( "s0211_rtrg0030"  )	
	else
		TppRadio.Play( "s0211_rtrg0031"  )	
	end

end

this.HeliRideHostage = function()
	Fox.Log("#### HeliRideHostage ####")
	TppRadio.Play( "f1000_rtrg2090",{delayTime = "long", isEnqueue = true}	)	
	this.FultonHostage()
end
this.FultonHostage = function()
	Fox.Log("#### FultonHostage ####")
	if svars.HostageRescue	== 0 then
		TppRadio.Play( "s0211_rtrg1020",{delayTime = "long", isEnqueue = true}	)	
	else
		if svars.isGetIntel	== false		
			and svars.isTargetArrivedSwamp	== false then	

			if svars.isReserve_13 == false then	
				svars.isReserve_13 = true	
				s10211_sequence.DeleteHighInterrogationTargetGoal()	

				TppRadio.Play( "s0211_rtrg1021",{delayTime = "long", isEnqueue = true}	)	
				
				TppMission.UpdateObjective{
					objectives = { "add_TargetHint",},
				}
			end

		end
	end
	svars.HostageRescue	=svars.HostageRescue+1

end





this.MarkingTarget = function()
	Fox.Log("#### s10211_radio.MarkingTarget ####")
	TppRadio.Play( "f1000_rtrg1250" )	
end


this.TargetPlacedIntoHeli = function()
	Fox.Log("#### s10211_radio.TargetPlacedIntoHeli ####")

	TppRadio.Play( "f1000_rtrg2620" )	
end



this.FultonJackal = function()
	Fox.Log("#### s10211_radio.FultonJackal ####")

	TppRadio.Play( "f1000_rtrg0620" )	
end







this.ArrivedSavannah = function()
	Fox.Log("#### s10211_radio.ArrivedSavannah ####")
	TppRadio.Play( "s0211_rtrg1010",{isEnqueue = true})	
end


this.ArrivedViewArea = function()
	Fox.Log("#### s10211_radio.ArrivedViewArea ####")

end


this.GetSavannahInfoTape = function()
	Fox.Log("#### s10211_radio.GetSavannahInfoTape ####")
	TppRadio.Play( "s0211_rtrg2010" )	
end


this.VipArrivedSwamp = function()
	Fox.Log("#### s10211_radio.VipArrivedSwamp ####")
	TppRadio.Play( "s0211_rtrg0040")
end


this.SwampBeforeGetDocument = function()
	Fox.Log("#### s10211_radio.SwampBeforeGetDocument ####")
	TppRadio.Play( "s0211_rtrg5060",{isEnqueue = true})
end
this.SwampBeforeGetDocumentTimeOut = function()
	Fox.Log("#### s10211_radio.SwampBeforeGetDocumentTimeOut ####")
	svars.isReserve_14 = true	
	TppRadio.Play( "s0211_rtrg5062",{isEnqueue = true})
end

this.OuterBaseBeforeGetDocument = function()
	Fox.Log("#### s10211_radio.OuterBaseBeforeGetDocument ####")
	TppRadio.Play( "s0211_rtrg5071")
end
this.OuterBaseBeforeGetDocumentTimeOut = function()
	Fox.Log("#### s10211_radio.OuterBaseBeforeGetDocumentTimeOut ####")
	svars.isReserve_14 = true	
	TppRadio.Play( "s0211_rtrg5070")
end

this.GetOutRogueCoyoteOb = function()	
	Fox.Log("#### s10211_radio.OuterBaseBeforeGetDocument ####")
	TppRadio.Play( "s0211_rtrg5080")
end


this.SwampAfterGetDocument = function()	
	Fox.Log("#### s10211_radio.SwampAfterGetDocument ####")
	TppRadio.Play( "s0211_rtrg5063")
end

this.SwampVipArrivedNotIdentified = function()	
	Fox.Log("#### s10211_radio.SwampVipArrivedNotIdentified ####")
	TppRadio.Play( "s0211_rtrg5061")
end
this.SwampVipArrivedIdentified = function()	
	Fox.Log("#### s10211_radio.SwampVipArrivedIdentified ####")
	TppRadio.Play( "s0211_mprg4020")
end

this.SnipePointEquipSniperrifle = function()	
	Fox.Log("#### s10211_radio.SnipePointEquipSniperrifle ####")
	TppRadio.Play( "s0211_rtrg5050")
end

this.SnipePointDeveloppedSniperrifle = function()	
	Fox.Log("#### s10211_radio.SnipePointDeveloppedSniperrifle ####")
	TppRadio.Play( "s0211_rtrg5051")
end
this.SnipePointNotDeveloppedSniperrifle = function()	
	Fox.Log("#### s10211_radio.SnipePointNotDeveloppedSniperrifle ####")
	TppRadio.Play( "s0211_rtrg5052")
end







this.MapTargetAreaAbout = function()
	Fox.Log("#### s10211_radio.MapTargetAreaAbout ####")
	TppRadio.Play( "s0211_mapr0010" )	
end

this.MapSavannah = function()
	Fox.Log("#### s10211_radio.MapSavannah ####")
	TppRadio.Play( "s0211_mapr0020" )	
end

this.MapTargetRoute = function()
	Fox.Log("#### s10211_radio.MapTargetRoute ####")
	TppRadio.Play( "s0211_mapr2010" )	
end

this.MapSwampNoTarget = function()
	Fox.Log("#### s10211_radio.MapSwampNoTarget ####")
	TppRadio.Play( "s0211_mapr2020" )	
end

this.MapSwampArrivedTarget = function()
	Fox.Log("#### s10211_radio.MapSwampArrivedTarget ####")
	TppRadio.Play( "s0211_mapr4020" )	
end

this.MapTarget = function()
	Fox.Log("#### s10211_radio.MapTarget ####")
	TppRadio.Play( "s0211_mapr4010" )	
end




this.TelephoneRadio = function()
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0200" )	
end






return this
