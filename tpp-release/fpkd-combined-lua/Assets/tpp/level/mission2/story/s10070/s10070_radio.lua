local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





this.CheckHeliRadio = function( radioId )
	Fox.Log("#### s10070_radio.CheckHeliRadio ####")

	
	local currentSequence = TppSequence.GetCurrentSequenceName()

	if currentSequence == "Seq_Game_EscapeSovietBase" or currentSequence == "Seq_Game_EscapeSahelan" then
		if radioId ~= nil then
			return radioId
		else
			return TppRadio.IGNORE_COMMON_RADIO
		end
	end

	return TppRadio.IGNORE_COMMON_RADIO
end




this.commonRadioTable = {

	[ TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME ] = this.CheckHeliRadio(),
	[ TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE ] = this.CheckHeliRadio(),
	[ TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME ] = this.CheckHeliRadio(),
	[ TppDefine.COMMON_RADIO.TARGET_MARKED ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.ABORT_BY_HELI ] = this.CheckHeliRadio("s0070_rtrg0160"),
	[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ] = this.CheckHeliRadio("s0070_rtrg0107"),

}









this.radioList = {
	
	
	
	
	"s0070_rtrg0030",	
	"s0070_rtrg0050",	

	
	"s0070_rtrg0040",	

	
	"s0070_rtrg0060",	
	"s0070_rtrg0070",	

	"s0070_rtrg0090",	
	{ "s0070_rtrg0080", playOnce = true },	

	
	
	
	
	"s0070_rtrg0100",	

	"s0070_rtrg0105",	

	
	"s0070_rtrg0160",	

	
	"s0070_rtrg0190",	

	
	"s0070_rtrg0200",	

	
	"s0070_rtrg0250",	

	"s0070_rtrg0107",	

	
	
	
	
	"s0070_rtrg0110",	


	"s0070_rtrg0120",	
	"s0070_rtrg0140",	

	"s0070_rtrg0150",	

	

	


	
	
	
	
	"s0070_rtrg0170",	
	"s0070_rtrg0180",	

	
	
	
	
	"s0070_mprg0020",	
	"s0070_mprg0030",	

}


this.debugRadioLineTable = {
	
	
	

	
	DoorNotOpen = {
		"[dbg]ドアロックがかかっているな",
		"[dbg]おそらく戦闘状態にあるうちは解除されないだろう",
		"[dbg]一旦引いて敵が戦闘状態を解くまでやり過ごすんだ",
	},
}






this.optionalRadioList = {
	
	
	"Set_s0070_oprg0030",	
	"Set_s0070_oprg0050",	
	"Set_s0070_oprg0040",	
	"Set_s0070_oprg0060",	
	"Set_s0070_oprg0070",	
	"Set_s0070_oprg0075",	
	"Set_s0070_oprg0080",	
	"Set_s0070_oprg0100",	
}





this.intelRadioList = {
	EspRadioLocator_powerPlant	= "s0070_esrg0200",		
	EspRadioLocator_SahelanHunger	= "s0070_rtrg0260",		
	EspRadioLocator_sovistBase	= "s0070_esrg0210",		
	EspRadioLocator_hunger		= "s0070_esrg0125",		
	EspRadioLocator_AiPod		= "s0070_esrg0130",		
	EspRadioLocator_BeforeDemoHuey	= "s0070_esrg0020",		
	wkr_s10070_0000				= "s0070_esrg0150",		
	wkr_s10070_0001				= "s0070_esrg0150",		
	wkr_s10070_0002				= "s0070_esrg0150",		

}


this.intelRadioList_AfterHueyDemo = {
	EspRadioLocator_sovistBase	= "Invalid",			
	EspRadioLocator_BeforeDemoHuey	= "Invalid",		
	TppHuey2GameObjectLocator	= "s0070_esrg0030",		
	Sahelanthropus				= "s0070_esrg0160",		
}



this.CallMonologueHuey = function( labelName )

	Fox.Log("### s10070_radio.CallMonologueHuey ###:::"..labelName )

	local locatorName = "TppHuey2GameObjectLocator"
	local gameObjectType = "TppHuey2"
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local command = {
		id="CallMonologue",
		label = labelName,
	}
	GameObject.SendCommand( gameObjectId, command )

end









this.MissionStart = function()
	Fox.Log("#### s10070_radio.MissionStart ####")
	TppRadio.Play( { "s0070_rtrg0030" } )	
end





this.TargetMarking = function()
	Fox.Log("#### s10070_radio.TargetMarking ####")
	TppRadio.Play( "TargetHuey", { playDebug = true } )
end


this.MonologueAfterKazuRadio01 = function()
	Fox.Log("#### s10070_radio.MonologueAfterKazuRadio01 ####")
	TppRadio.Play( "s0070_rtrg0190" )
end


this.MonologueAfterKazuRadio02 = function()
	Fox.Log("#### s10070_radio.MonologueAfterKazuRadio02 ####")
	TppRadio.Play( "s0070_rtrg0200" )
end





this.RV_Disabled = function()
	Fox.Log("#### s10070_radio.RV_Disabled ####")
	TppRadio.Play( "s0070_rtrg0120", { isEnqueue = true } )	
end


this.RV_Enabled = function()
	Fox.Log("#### s10070_radio.RV_Enabled ####")
	TppRadio.Play( "s0070_rtrg0140", {	isEnqueue = true } )	
end


this.WithdrawalSupportHeli = function()
	Fox.Log("#### s10070_radio.WithdrawalSupportHeli ####")
	TppRadio.Play( "WithdrawalSupportHeli", { playDebug = true } )	
end


this.ReturnSupportHeli = function()
	Fox.Log("#### s10070_radio.ReturnSupportHeli ####")
	TppRadio.Play( "ReturnSupportHeli", { playDebug = true } )	
end

this.SupprtHeliDeadByEnemy = function()
	Fox.Log("#### s10070_radio.SupprtHeliDeadByEnemy ####")
	TppRadio.Play( "f1000_rtrg1940" )
end

this.SupprtHeliDeadByPC = function()
	Fox.Log("#### s10070_radio.SupprtHeliDeadByPC ####")
	TppRadio.Play( "f1000_rtrg0090" )
end





this.CallMonologueHuey01 = function()

	this.CallMonologueHuey( "speech070_carry060" )	

end



this.CallMonologueHuey02 = function()

	this.CallMonologueHuey( "speech070_carry070" )	

end



this.CallMonologueHuey03 = function()

	this.CallMonologueHuey( "speech070_carry100" )	

end



this.CallMonologueHuey04 = function()	

	this.CallMonologueHuey( "speech070_carry110" )

end



this.CallMonologueHuey05 = function()

	this.CallMonologueHuey( "speech070_carry120" )	

end



this.CallMonologueHuey06 = function()

	this.CallMonologueHuey( "speech070_carry010" )	

end



this.CallMonologueHuey07 = function()

	this.CallMonologueHuey( "speech070_carry020" )	

end



this.CallMonologueHuey08 = function()

	this.CallMonologueHuey( "speech070_carry080" )	

end



this.CallMonologueHuey09 = function()

	this.CallMonologueHuey( "speech070_carry090" )	

end



this.CallMonologueHuey10 = function()

	this.CallMonologueHuey( "speech070_carry040" )	

end



this.CallMonologueHuey11 = function()

	this.CallMonologueHuey( "speech070_carry050" )	

end




return this
