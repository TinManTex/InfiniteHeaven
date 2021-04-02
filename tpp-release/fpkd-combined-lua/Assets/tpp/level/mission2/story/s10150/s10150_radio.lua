local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.radioList = {
	
	{"s0150_rtrg0010",	playOnce = true },		
	{"s0150_rtrg0020",	playOnce = true },		
	{"s0150_rtrg0030",	playOnce = true },		
	{"s0150_rtrg0040",	playOnce = true },		
	"s0150_rtrg0050",							
	{"s0150_rtrg0060",	playOnce = true },		
	{"s0150_rtrg0070",	playOnce = true },		
	{"s0150_rtrg0080",	playOnce = true },		
	{"s0150_rtrg0090",	playOnce = true },		
	{"s0150_rtrg0100",	playOnce = true },		
	{"s0150_rtrg0110",	playOnce = true },		
	{"s0150_rtrg0120",	playOnce = true },		
	{"s0150_rtrg0130",	playOnce = true },		
	{"s0150_rtrg0140",	playOnce = true },		
	{"s0150_rtrg0150",	playOnce = true },		

	{"s0150_rtrg0200",	playOnce = true },		
	{"s0150_rtrg0210",	playOnce = true },		
	{"s0150_rtrg0220",	playOnce = true },		
	"s0150_rtrg0230",		
	"s0150_rtrg0240",		

}





this.optionalRadioList = {
	"Set_s0150_oprg0010",	
	"Set_s0150_oprg0020",	
}





this.intelRadioList = {
	type_enemy		= "f1000_esrg2410",
	firstGate 		= "s0150_esrg0010",
	firstCliff		= "s0150_esrg0030",
	citadelSouth	= "s0150_esrg0160",
	secondGate		= "s0150_esrg0140",
	thirdGate		= "s0150_esrg0150",
	evGate 			= "s0150_esrg0080",
	evPit			= "s0150_esrg0100",
	northTower		= "s0150_esrg0050",
	sahelanPit		= "s0150_esrg0060",
	heliport		= "Invalid",
}

this.ResetIntelRadio = function()
	Fox.Log("_____s10150_radio.ResetIntelRadio()")
	TppRadio.ChangeIntelRadio{	type_enemy	= "Invalid",}
	TppRadio.ChangeIntelRadio{	firstGate	= "Invalid",}
	TppRadio.ChangeIntelRadio{	firstCliff	= "Invalid",}
	TppRadio.ChangeIntelRadio{	citadelSouth	= "Invalid",}
	TppRadio.ChangeIntelRadio{	secondGate	= "Invalid",}
	TppRadio.ChangeIntelRadio{	thirdGate	= "Invalid",}
	TppRadio.ChangeIntelRadio{	evGate	= "Invalid",}
	TppRadio.ChangeIntelRadio{	evPit	= "Invalid",}
	TppRadio.ChangeIntelRadio{	northTower	= "Invalid",}
	TppRadio.ChangeIntelRadio{	sahelanPit	= "Invalid",}
	TppRadio.ChangeIntelRadio{	heliport	= "Invalid",}
end





this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.PHASE_DOWN_OUTSIDE_HOTZONE ] = TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT ] 		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_S		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_A		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_B		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_C		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_D		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_E		 ]		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED]		= TppRadio.IGNORE_COMMON_RADIO        


this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ] 		= "s0150_rtrg0050"







function this.Messages()
	return
	StrCode32Table {
		Trap = {

			{ msg = "Enter", sender = "trap_NearCitadelSouth",	func = this.FuncNearCitadelSouth },
			{ msg = "Enter", sender = "trap_TalkHuey",	func = this.FuncTalkHuey },
			{ msg = "Enter", sender = "trap_ThisIsOKB",	func = this.FuncThisIsOKB },
			
			{ msg = "Enter", sender = "trap_ClearGate01",		func = this.FuncClearGate01 },
			{ msg = "Enter", sender = "trap_ClearGate02",		func = this.FuncClearGate02 },
			{ msg = "Enter", sender = "trap_EnterEvArea", 		func = this.FuncEnterEvArea },
			{ msg = "Enter", sender = "trap_NearHole", 			func = this.FuncNearHole },
			nil
		},
		Terminal = {
			{ msg = "MbDvcActSelectNonActiveMenu", func = this.FuncSelectNonActiveMenu },
			nil
		},
		
		Radio = {
			{ msg = "EspionageRadioPlay", sender = "s0150_esrg0010",		
				func = function() 
					TppRadio.ChangeIntelRadio{	firstGate	= "s0150_esrg0020"	}
				end, 
			},
			{ msg = "EspionageRadioPlay", sender = "s0150_esrg0030",		
				func = function() 
					TppRadio.ChangeIntelRadio{	firstCliff	= "s0150_esrg0040"	}
				end, 
			},
			{ msg = "EspionageRadioPlay", sender = "s0150_esrg0100",		
				func = function() 
					TppRadio.ChangeIntelRadio{	evPit	= "s0150_esrg0110"	}
				end, 
			},
			{ msg = "EspionageRadioPlay", sender = "s0150_esrg0050",		
				func = function() 
					TppRadio.ChangeIntelRadio{	northTower	= "s0150_esrg0070"	}
				end, 
			},
			{ msg = "EspionageRadioPlay", sender = "s0150_esrg0080",		
				func = function() 
					TppRadio.ChangeIntelRadio{	evGate	= "s0150_esrg0090"	}
				end, 
			},

		},
	}
end








this.FuncNearCitadelSouth = function()
	TppRadio.Play("s0150_rtrg0060")
end

this.FuncTalkHuey = function()
	
	local options = {
		isEnqueue = true
	}
	TppRadio.Play({"s0150_rtrg0010","s0150_rtrg0020","s0150_rtrg0030","s0150_rtrg0040"},options)
end

this.FuncThisIsOKB = function()
	TppRadio.Play("s0150_rtrg0070")
end

this.FuncClearGate01 = function()
	TppRadio.Play{"s0150_rtrg0080","s0150_rtrg0090","s0150_rtrg0100"}
end

this.FuncClearGate02 = function()
	TppRadio.Play{"s0150_rtrg0110","s0150_rtrg0120"}
	
	
	TppRadio.ChangeIntelRadio{thirdGate="s0150_esrg0150",}
end

this.FuncClearGate03 = function()
	TppRadio.Play("s0150_rtrg0100")
	
	
	TppRadio.ChangeIntelRadio{	northTower= "Invalid",	 }
	
end

this.FuncEnterEvArea = function()
	local options = {
		isEnqueue = true
	}
	TppRadio.Play({"s0150_rtrg0130"},options)
end


this.FuncNearHole =function()
	local options = {
		isEnqueue = true
	}
	TppRadio.Play({"s0150_rtrg0140"},options)
end

this.MarkingXof =function()
	TppRadio.Play("s0150_rtrg0200")
end

local SelectNonActiveMenuRadioGroup = {
	"s0150_rtrg0230",
	"s0150_rtrg0240",
}


this.FuncSelectNonActiveMenu = function()
	
	Fox.Log("_____s10150_radio.FuncSelectNonActiveMenu() / CurrentSequenceName is ".. tostring(TppSequence.GetCurrentSequenceName()) .. " / mvars.NgMbCount : "..mvars.NgMbCount)
	if TppSequence.GetCurrentSequenceName() == "Seq_Game_TalkSkullFace" or TppSequence.GetCurrentSequenceName() == "Seq_Game_SkullFaceToPlant" then
		mvars.NgMbCount = mvars.NgMbCount + 1
		TppRadio.Play(SelectNonActiveMenuRadioGroup[mvars.NgMbCount%2 + 1])
	end
end


this.EVinAlert = function()
	if TppEnemy.GetPhase("afgh_citadel_cp") >= TppGameObject.PHASE_CAUTION  then
		TppRadio.Play("s0150_rtrg0220",{ delayTime = "long" })
	end
end












return this
