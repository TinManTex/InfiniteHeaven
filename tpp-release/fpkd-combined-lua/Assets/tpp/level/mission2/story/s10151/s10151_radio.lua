local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.radioList = {
	
	{"s0150_rtrg0160",	playOnce = true },		
	{"s0150_rtrg0170",	playOnce = false },		
	{"s0150_rtrg0180",	playOnce = false },		
	{"s0150_rtrg0190",	playOnce = false },		
	
	"s0150_rtrg0250",	
	"s0150_rtrg0260",	
	"s0150_rtrg0270",	
	"s0150_rtrg0280",	

	"f1000_rtrg1640",	
	"f1000_rtrg1647",	
	"f1000_rtrg1660",	
	"f1000_rtrg1665",	
	
	"f1000_rtrg1985",	
}







this.optionalRadioList = {
	"Set_s0150_oprg0030",
}





this.intelRadioList = {
	Sahelanthropus	= "s0150_esrg0130",
	
}






this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.PHASE_DOWN_OUTSIDE_HOTZONE ] = TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT ] 		= TppRadio.IGNORE_COMMON_RADIO        
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE		 ]		= TppRadio.IGNORE_COMMON_RADIO        


Fox.Log("s10151_radio.lua___________vars.missionCode".. tostring(vars.missionCode))
local radioList = {
	TppDefine.COMMON_RADIO.RESULT_RANK_S,
	TppDefine.COMMON_RADIO.RESULT_RANK_A,
	TppDefine.COMMON_RADIO.RESULT_RANK_B,
	TppDefine.COMMON_RADIO.RESULT_RANK_C,
	TppDefine.COMMON_RADIO.RESULT_RANK_D,
	TppDefine.COMMON_RADIO.RESULT_RANK_E,
	TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED,
	
}
for i, radioId in ipairs( radioList ) do
	this.commonRadioTable[ radioId ] = function()
		if vars.missionCode == 10151 then
			return nil
		else
			return TppRadio.COMMON_RADIO_LIST[ radioId ]
		end
	end
end

this.commonRadioTable[ TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN ]			= TppRadio.IGNORE_COMMON_RADIO

this.GetRadioGroup = function()
		local radioGroup = {
			"s0150_rtrg0170",
			"s0150_rtrg0180",
			"s0150_rtrg0190",
		}

		mvars.EscapeCount = mvars.EscapeCount + 1

		Fox.Log(" mvars.EscapeCount : " .. mvars.EscapeCount)

        return radioGroup[mvars.EscapeCount % 3 + 1] 
end
this.commonRadioTable[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ] = this.GetRadioGroup
















this.HelpSupportAttack = function()
	TppRadio.Play{"s0150_rtrg0260","s0150_rtrg0270"}
end

this.HelpSupportBullet = function()
	TppRadio.Play("s0150_rtrg0280",{ isEnqueue = true})
end

this.Help1stRailGun = function()
	TppRadio.Play( "s0150_rtrg0250", { isEnqueue = true, priority = "strong" } )
end

this.PartsBroken = function()
	TppRadio.Play("f1000_rtrg1640")
end

this.CleanHit = function()
	TppRadio.Play("f1000_rtrg1647")
end

this.HelpSuportHeli = function()
	TppRadio.Play( "f1000_rtrg1985", { isEnqueue = true, priority = "strong" } )
end

this.SahelanFinalPhase = function()
	
	TppRadio.Play("f1000_rtrg1660")
end






return this
