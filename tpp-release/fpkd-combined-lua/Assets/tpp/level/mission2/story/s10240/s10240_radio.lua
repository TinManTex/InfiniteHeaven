local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table


this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN ] = TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED ] = TppRadio.IGNORE_COMMON_RADIO




this.radioList = {

	{"s0240_rtrg0030"	, playOnce = true},	

	{"s0240_rtrg0032"	, playOnce = false},	
	{"s0240_rtrg0034"	, playOnce = false},	
	
	{"s0240_rtrg0040"	, playOnce = true},	
	{"s0240_rtrg0050"	, playOnce = true},	
	{"s0240_rtrg0060"	, playOnce = true},	
	{"s0240_rtrg0070"	, playOnce = true},	
	{"s0240_rtrg0080"	, playOnce = true},	
	{"s0240_rtrg0090"	, playOnce = true},	
	{"s0240_rtrg0100"	, playOnce = true},	
	{"s0240_rtrg0110"	, playOnce = true},	
	{"s0240_rtrg0120"	, playOnce = true},	
	{"s0240_rtrg0122"	, playOnce = true}, 
	{"s0240_rtrg0124"	, playOnce = true},	
	{"s0240_rtrg0130"	, playOnce = true},	
	{"s0240_rtrg0140"	, playOnce = true},	
	{"s0240_rtrg0150"	, playOnce = true},	
	{"s0240_rtrg0160"	, playOnce = true},
	{"s0240_rtrg0170"	, playOnce = true},	
	{"s0240_rtrg0190"	, playOnce = true},	
	{"s0240_rtrg0200"	, playOnce = true},	
	{"s0240_rtrg0210"	, playOnce = true},	
	{"s0240_rtrg0220"	, playOnce = true},	
	{"s0240_rtrg0230"	, playOnce = true},	
	{"s0240_rtrg0240"	, playOnce = true},	
	{"s0240_rtrg0250"	, playOnce = true},	
	{"s0240_rtrg0260"	, playOnce = true},	
	{"s0240_rtrg0270"	, playOnce = false},	
	{"s0240_rtrg0274"	, playOnce = false},	
	{"s0240_rtrg0300"	, playOnce = true},		
	{"s0240_rtrg0305"	, playOnce = true},		
	{"s0240_rtrg0307"	, playOnce = true},		
	{"s0240_rtrg0310"	, playOnce = true},		
	"s0240_mirg0010",	

	{"s0240_rtrg1000"	, playOnce = true},		
	{"s0240_rtrg1010"	, playOnce = true},		
	{"s0240_rtrg1020"	, playOnce = true},		
	{"s0240_rtrg1030"	, playOnce = true},		

	{"s0240_rtrg1050"	, playOnce = true},		
	
	{"s0240_rtrg4240"	, playOnce = true},		
	{"s0240_rtrg4250"	, playOnce = true},		
	{"s0240_rtrg4260"	, playOnce = true},		
	{"s0240_rtrg4270"	, playOnce = true},		

	{"s0240_rtrg0280"	, playOnce = true},		
	{"s0240_rtrg0290"	, playOnce = true},		

	{"s0240_rtrg5000"	, playOnce = true},		
	"s0240_rtrg5100",	

}




this.optionalRadioList = {
	"Set_s0240_oprg0010",	
	"Set_s0240_oprg1000",	
	"Set_s0240_oprg2000",	
	"Set_s0240_oprg3000",	
	"Set_s0240_oprg3500",	
	"Set_s0240_oprg4000",	
	"Set_s0240_oprg5000",	
	"Set_s0240_oprg6000",	
		
	
	
	
	
	
	

}




this.intelRadioList = {
	esp_10240_0000 = "s0240_esrg0010",	
	esp_10240_0001 = "s0240_esrg0020",	
	esp_10240_1000 = "s0240_esrg0030",	
	sol_mbqf_1000 = "s0240_esrg0040",	
	esp_10240_1002 = "s0240_esrg0050",	
	esp_10240_1001 = "s0240_esrg0060",	
	
	
	esp_10240_1003 = "s0240_esrg0090",	
	nil,
}




this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10240_STAFF_DEAD] 					= "f8000_gmov0125"	





this.MissionStart = function()
	Fox.Log("#### s10211_radio.MissionStart ####")
	TppRadio.Play( "openingText", { playDebug = true } )
end



this.HeliStartEndDemo = function()
		TppRadio.Play( "s0240_rtrg5000", {delayTime = 2}  )
end

this.StartInMBQF2 = function()
	TppRadio.Play( "s0240_rtrg0034", {delayTime = "short",isEnqueue = true}  )
end


this.EnterFacility = function()
	TppRadio.Play( "s0240_rtrg0040", {delayTime = "short"}  )	
end

this.StoryRadioNoise1 = function()
	
	TppRadio.Play( "s0240_rtrg0050",{delayTime = "long"} )
end
this.StoryRadioNoise2 = function()
	
	TppRadio.Play( "s0240_rtrg0060", {delayTime = "long"}  )
end
this.StoryRadioNoise3 = function()
	
	TppRadio.Play( "s0240_rtrg0070", {delayTime = "short"}  )
end

this.ShootSneak = function()
	
	TppRadio.Play( "s0240_rtrg0200", {delayTime = "short"} )
end

this.ShootSneakAgain = function()
	
	TppRadio.Play( "s0240_rtrg0190", {delayTime = "short"} )
end

this.SodaSorede = function()
	
	TppRadio.Play( "s0240_rtrg1030", {delayTime = "mid"} )
end

this.KillAllPlease = function()
	
	TppRadio.Play( "s0240_rtrg0220", {delayTime = "mid",isEnqueue = true} )
end

this.KillAllPleaseContinue = function()
	
	TppRadio.Play( "s0240_rtrg0230", {delayTime = "short",isEnqueue = true} )
end

this.NeedMoreKill = function()
	
	TppRadio.Play( "s0240_rtrg0250", {delayTime = "mid",isEnqueue = true} )
end

this.NotMasui = function()
	
	TppRadio.Play( "s0240_rtrg4240", {delayTime = "short",isEnqueue = true} )

end




this.Event1FRouka = function()
	
	TppRadio.Play( "s0240_rtrg0080", {delayTime = "long",isEnqueue = true} )
end

this.Event1F4Room = function()
	
	TppRadio.Play( "s0240_rtrg0120", {delayTime = "short"} )
end

this.DeadSoldier = function()
	
	TppRadio.Play( "s0240_rtrg0160", {delayTime = "short",isEnqueue = true} )	
end

this.HuyeSay = function()
	
	TppRadio.Play( "s0240_rtrg0270", {delayTime = "short"} )
end

this.AfterHuey = function()
	TppRadio.Play( "s0240_rtrg0140", {delayTime = "short",isEnqueue = true} )
	TppRadio.Play( "s0240_rtrg0150", {delayTime = "short",isEnqueue = true} )
end

this.SorryBoss = function()
	TppRadio.Play( "s0240_rtrg0274", {delayTime = "mid",isEnqueue = true} )
end

this.DontOpenDoor1 = function()
	
	TppRadio.Play( "s0240_rtrg0090" )
end
this.DontOpenDoor2 = function()
	
	TppRadio.Play( "s0240_rtrg0100" )
end

this.DontOpenDoor2after = function()
	
	TppRadio.Play( "s0240_rtrg0240" )
end

this.DontOpenDoor3 = function()
	
	TppRadio.Play( "s0240_rtrg0110" )
end

this.DontGoOut = function()
	TppRadio.Play( "s0240_rtrg0210" )
end

this.Event2F4 = function()
	
	TppRadio.Play( "s0240_rtrg0122",{delayTime = "long"} )
end

this.Event2FStep = function()
	
	TppRadio.Play( "s0240_rtrg0124",{delayTime = "long"} )
end

this.CheckMaskMan = function()
	
	TppRadio.Play( "s0240_rtrg0290",{delayTime = "mid"} )
end

this.TakeOutSide = function()
	
	TppRadio.Play( "s0240_rtrg0280",{delayTime = "short", isEnqueue = true} )
end



this.tutorial01 = function(time)
	local delay = "short"
	if time == "long" then
		delay = "long"
	end
	
	if s10240_sequence.CheckEquipGoggle() == true then
		svars.numDoEventRoof = 2
		TppRadio.Play( "s0240_rtrg1010",{delayTime = delay} )
	else
		TppRadio.Play( "s0240_rtrg1000",{delayTime = delay} )
	end
end

this.tutorial02 = function()
	TppRadio.Play( "s0240_rtrg1010",{delayTime = "short"} )
end

this.tutorial03 = function()
	
	TppRadio.Play( "s0240_rtrg1050",{delayTime = "short"} )
end



this.LastMan01 = function()
	
	TppRadio.Play( "s0240_rtrg0300",{delayTime = "short", isEnqueue = true}  )
end

this.LastMan02 = function()
	
	TppRadio.Play( "s0240_rtrg0305", {delayTime = "mid", isEnqueue = true}  )
end

this.LastMan03 = function()
	
	this.ORadioSet06()
	TppRadio.Play( "s0240_rtrg0307",{delayTime = "long", isEnqueue = true, priority = "strong"}  )
end


this.LastManCheck = function()
	
	this.ORadioSet06()
	TppRadio.Play( "s0240_rtrg0310",{delayTime = "short", isEnqueue = true}  )
end

this.DontOut = function()
	
	TppRadio.Play( "s0240_rtrg4270" )
end

this.MadaIru = function()
	TppRadio.Play( "s0240_rtrg4250",{delayTime = "short"} )
end

this.MissionClear = function()
	TppRadio.Play( "s0240_rtrg5100",{delayTime = "mid"} )
end



this.ORadioSet01 = function()
	Fox.Log("set opt 01")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg0010" )
end

this.ORadioSet02 = function()
	Fox.Log("set opt 02")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg1000" )
end

this.ORadioSet03 = function()
	Fox.Log("set opt 03")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg2000" )
end

this.ORadioSet04 = function()
	Fox.Log("set opt 04")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg3000" )
end

this.ORadioSet045 = function()
	Fox.Log("set opt 045")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg3500" )
end

this.ORadioSet05 = function()
	Fox.Log("set opt 05")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg4000" )
end

this.ORadioSet06 = function()
	Fox.Log("set opt 06")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg6000" )
end

this.ORadioSet07 = function()
	Fox.Log("set opt 07")
	TppRadio.SetOptionalRadio( "Set_s0240_oprg5000" )
end


this.InsertWhyClose = function()
	
	Fox.Log("InsertWhyClose()")
	this._InsertORadio("s0240_oprg0030")
end

this.InsertAfter2F4 = function()
	
	Fox.Log("InsertAfter2F4()")
	this._InsertORadio("s0240_oprg0090")
end



this._InsertORadio = function(radioId)
	Fox.Log("_InsertORadio()")
	if radioId == nil then
		Fox.Log("radioId is nil")
		return
	end
	Fox.Log("insert Radio. "..radioId )
	local radioDaemon = RadioDaemon:GetInstance()
	radioDaemon:RegisterRadioGroupToActiveRadioGroupSetInsert( radioId, 1 )
end




this.DebugPlay = function(id)
	Fox.Log("play debug")
	TppRadio.Play(  id , { playDebug = true, priority = "strong" } )
end


this.DebugPlayNoNise = function(id)
	Fox.Log("play debug")
	TppRadio.Play(  id , { playDebug = true,noiseType = "none" } )
end



return this
