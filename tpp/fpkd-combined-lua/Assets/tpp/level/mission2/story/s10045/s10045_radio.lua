local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.blackTelephoneDisplaySetting = {
			f6000_rtrg0050  = {
		Japanese = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10045/mb_photo_10045_010_1.ftex", 0.6, "cast_The_CIA_Agent" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_02.ftex", 3.6 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_03.ftex", 12.3 }, 
		},
		English = {
			{ "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10045/mb_photo_10045_010_1.ftex", 0.6, "cast_The_CIA_Agent" }, 
			{ "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_02.ftex", 3.8 }, 
			{ "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_03.ftex", 11.4 }, 
		},
	},
	
	 f6000_rtrg0060  = {
        Japanese = {
            { "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10045/mb_photo_10045_010_1.ftex", 0.6, "cast_The_CIA_Agent" }, 
            { "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_02.ftex", 3.6 }, 
            { "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_03.ftex", 12.3 }, 
            { "hide", "sub_1", 63.0 }, 
            { "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_04.ftex", 76.5 }, 
        },
        English = {
            { "sub_1", "/Assets/tpp/ui/texture/Photo/tpp/10045/mb_photo_10045_010_1.ftex", 0.6, "cast_The_CIA_Agent" }, 
            { "main_1", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_02.ftex", 3.8 }, 
            { "main_2", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_03.ftex", 11.4 }, 
            { "hide", "sub_1", 58.0 }, 
            { "main_3", "/Assets/tpp/ui/texture/Photo/tpp/demo/mission_demo_s10045_04.ftex", 70.9 }, 
        },
    },
}



this.radioList = {
	
	{"s0045_rtrg2010",	playOnce = false},	
	{"s0045_rtrg3005",	playOnce = false},	
	{"s0045_rtrg3010",	playOnce = false},	
	{"s0045_rtrg3020",	playOnce = false},	
	{"s0045_rtrg4010",	playOnce = false},	
	{"s0045_rtrg1020",	playOnce = false},	
	{"f1000_rtrg3260",	playOnce = false},	
	{"s0045_rtrg6010",	playOnce = false},	
	{"s0045_rtrg6020",	playOnce = false},	
	{"s0045_rtrg6030",	playOnce = false},	
	{"s0045_rtrg6040",	playOnce = false},	
	{"s0045_rtrg1010",	playOnce = false},	
	{"f1000_rtrg3085",	playOnce = false},	
	{"f1000_rtrg2125",	playOnce = false},	
	{"f1000_rtrg1380",	playOnce = false},	
	{"f1000_rtrg8020",	playOnce = false},	
	{"f1000_rtrg2375",	playOnce = false},	
	{"f1000_rtrg3270",	playOnce = false},	
	{"f8000_gmov0115",	playOnce = false},	
	{"s0045_oprg2010",	playOnce = false},	
	{"f1000_oprg1130",	playOnce = false},	
	{"f1000_oprg1015",	playOnce = false},	
}





this.optionalRadioList = {
	"Set_s0045_oprg0010",		
	"Set_s0045_oprg0020",		
	"Set_s0045_oprg0030",		
	"Set_s0045_oprg0040",		
	"Set_s0045_oprg0050",		
	"Set_s0045_oprg4020",		
	"Set_s0045_oprg0070",		
}





this.intelRadioList = {
	wkr_WalkerGear_0000 = "s0045_esrg2010",
	wkr_WalkerGear_0001 = "s0045_esrg2010",
	wkr_WalkerGear_0002 = "s0045_esrg2010",
	wkr_WalkerGear_0003 = "s0045_esrg2010",
	veh_s10045_0000 = "s0045_esrg3010",			
	rds_remnants_0000 = "f1000_esrg1910",		
	rds_remnants_0001 = "f1000_esrg1920",		
}

this.RadioListTargetDiscovered = {
	wkr_WalkerGear_0000 = "Invalid",		
	wkr_WalkerGear_0001 = "Invalid",
	wkr_WalkerGear_0002 = "Invalid",
	wkr_WalkerGear_0003 = "Invalid",
}

this.intelRadioListOnrecovery = {
	veh_s10045_0000 = "Invalid",			
}

this.intelRadioListOnRemnants = {
	rds_remnants_0000 = "f1000_esrg1930",		
}

this.intelRadioListMarkerTarget = {
	hos_vip_0000 = "f1000_esrg1940",			
}

this.intelRadioListExecutioner = {
	sol_executioner_0000 = "s0045_oprg4020",	
}

this.intelRadioListExecutionerAfter = {			
	sol_executioner_0000 = "s0045_rtrg6030",
}





 
this.MissionStart = function()
	Fox.Log("radio play : mission start")
	TppRadio.Play( "s0045_rtrg2010",{delayTime = "short"} )
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0010" )	
end

this.TargetDiscovered = function()
	Fox.Log("#### TargetDiscovered ####")
	TppRadio.Play( "TargetDiscoveredText", { playDebug = true } )
end

 
this.WepFlr = function()
	Fox.Log("radio play : WepFlr")
	TppRadio.Play("s0045_rtrg3005",{delayTime = "short"} )
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0020" )	
end

 
this.RecoveryDead01 = function()
	Fox.Log("radio play : RecoveryDead01")
	TppRadio.Play( "s0045_rtrg3010",{delayTime = 8} )
	
end


this.WG_Annihilated_00 = function()
	Fox.Log("radio play :WG_Annihilated_00")
	TppRadio.Play( "s0045_rtrg3020",{delayTime = "short"} )
end



this.TargetJoin02 = function()
	Fox.Log("radio play : TargetJoin02")
	TppRadio.Play( "s0045_rtrg4010",{delayTime = 8} )
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0040" )	
end

this.TargetJoinOptionalRadioChange = function()
	Fox.Log("radio play : TargetJoinOptionalRadioChange")
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0030" )	
end




this.LostTarget = function()
	Fox.Log("radio play :WG_Annihilated_01")
	TppRadio.Play( "s0045_rtrg1020",{delayTime = "short"} )
end

 
this.WG_Annihilated_01 = function()
	Fox.Log("radio play :WG_Annihilated_01")
	TppRadio.Play( "f1000_rtrg3260",{delayTime = "short"} )
end


this.TargetRemnants = function()
	Fox.Log("#### TargetRemnants ####")
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0050" )	

end


this.ExecutionerSpown = function()
	Fox.Log("#### ExecutionerSpown ####")
	TppRadio.Play( "ExecutionerSpownText", { playDebug = true } )
end


 
this.ExecutionerSpown01 = function()
	Fox.Log("radio play : ExecutionerSpown01")
	TppRadio.Play( "s0045_rtrg6010",{delayTime = "short"} )
end



this.OnExecutioner = function()
	Fox.Log("radio play : OnExecutioner")
	TppRadio.Play( "s0045_rtrg6020",{delayTime = "short"} )
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0060" )
	
end


this.Searchexecutioner = function()
	Fox.Log("radio play : mission start")
	TppRadio.Play( "s0045_rtrg6030",{delayTime = "short"} )
	
end










this.ExecutionerDead = function()
	Fox.Log("radio play : ExecutionerDead")
	TppRadio.Play( "f1000_rtrg3260",{delayTime = "short"} )
end


this.CautionExecutioner = function()
	Fox.Log("#### CautionExecutioner ####")
	TppRadio.Play( "s0045_rtrg1010", {delayTime = "short"} )
end


this.ExecutionerTalk = function()
	Fox.Log("#### ExecutionerTalk ####")
	TppRadio.Play( "ExecutionerTalkText", { playDebug = true } )
end


 
this.CarryTarget = function()
	Fox.Log("radio play : CarryTarget")
	TppRadio.Play( "f1000_rtrg3085",{delayTime = "short"} )
end



this.UncertificationTarget = function()
	Fox.Log("radio play : UncertificationTarget")
	TppRadio.Play( "f1000_rtrg2125",{delayTime = "short"} )
	
end


this.TargetFulton = function()
	Fox.Log("radio play : TargetFulton")
	TppRadio.Play( "f1000_rtrg1380",{delayTime = "short"} )
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0070" )	
end


this.NoSearchtargetFulton = function()
	Fox.Log("radio play : NoSearchtargetFulton")
	TppRadio.Play( "f1000_rtrg2375",{delayTime = "short"} )
	TppRadio.SetOptionalRadio( "Set_s0045_oprg0070" )	
end


this.TargetDead = function()
	Fox.Log("#### TargetDead ####")
	TppRadio.Play( "f8000_gmov0115", {delayTime = "short"} )
end


this.SearchHostage = function()
	Fox.Log("radio play : SearchHostage")
	TppRadio.Play( "f1000_rtrg3270",{delayTime = "short"} )
end



this.MissionClear = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "missionclearText", { playDebug = true } )
end


this.Continue = function()
	Fox.Log("#### Continue ####")
	TppRadio.Play( "s0045_oprg2010", {delayTime = "short"} )
end


this.Continue01 = function()
	Fox.Log("#### Continue01 ####")
	TppRadio.Play( "f1000_oprg1130", {delayTime = "short"} )
end


this.Continue02 = function()
	Fox.Log("#### Continue02 ####")
	TppRadio.Play( "f1000_oprg1015", {delayTime = "short"} )
end


this.TargetUnconscious = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "targetUnconsciousText", { playDebug = true } )
end


this.TargetFultonFailed = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "fultonFailedText", { playDebug = true } )
end


this.TelephoneRadioNoExecutioner = function()	
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0050" )
end

this.TelephoneRadioExecutionerFulton = function()	
	TppRadio.RequestBlackTelephoneRadio( "f6000_rtrg0060" )
end




return this
