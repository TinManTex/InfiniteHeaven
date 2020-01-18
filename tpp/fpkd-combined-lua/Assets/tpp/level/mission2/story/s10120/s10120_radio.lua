local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10120_TARGET_DEAD]	= "f8000_gmov0220"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10120_CHILD_DEAD]	= "f8000_gmov0230"	




this.radioList = {

	
	"s0120_mprg0010",
	
	"s0120_mirg0010",
	
	
	"s0120_rtrg0010",
	"s0120_rtrg0020",
	"s0120_rtrg0030",
	"s0120_rtrg0040",
	"s0120_rtrg0050",
	"s0120_rtrg0060",
	"s0120_rtrg0070",
	{ "s0120_rtrg0100", playOnce = true },
	{ "s0120_rtrg0110", playOnce = true },
	{ "s0120_rtrg0120", playOnce = true },
	"s0120_rtrg1000",
	"f1000_rtrg2190",
	
	
	
	openingText = {
		"[dbg]今回の目的は敵部隊長の「排除」だ",
		"[dbg]だがその敵部隊がどこにいるかがわからない",
		"[dbg]まずは敵部隊の作戦計画書を入手するんだ",
		"[dbg]スネーク、savannah拠点に向かい作戦計画書を入手してくれ",
	},
	
	SavannahText = {
		"[dbg]よし、到着したな",
		"[dbg]作戦計画書はおそらく中央テントにあるはずだ",
		"[dbg]マーカーの位置だ。何とか接近してくれ",
	},
	
	GetInfoTape = {
		"[dbg]よし、作戦計画書を回収したな",
		"[dbg]こちらで内容を解析しよう",
		"[dbg]そこは危険だ。ひとまず拠点外まで離脱するんだ",
		"[dbg]最寄のRVをマークした。そこまで退避してくれ",
	},
	
	"s0093_rtrg0020",	
	"s0093_rtrg2010",	
}





this.optionalRadioList = {
	"Set_s0120_oprg0010",
	"Set_s0120_oprg0020",
	"Set_s0120_oprg0030",
	"Set_s0120_oprg0040",
	"Set_s0120_oprg0050",
	"Set_s0120_oprg0060",
}





this.intelRadioList = {
	TppLiquid2 = "f1000_esrg0010",	
	targetBoat = "Invalid",	
}

this.intelRadioFoundLiquid = {
	TppLiquid2 = "f1000_esrg1940",	
}

this.intelRadioBeforeLiquidFight = {}

this.intelRadioAfterLiquidFight = {}




this.GetIntoOutland = function()
	Fox.Log("#### s10120_radio.GetIntoOutland ####")
	TppRadio.Play( "s0120_rtrg0010" )
end





this.GetMissionStartRadioGroup = function()
	local radioGroup = "s0120_rtrg0020"
	local radioGroupTable = {}
	table.insert( radioGroupTable, radioGroup )
	Fox.Log( "#### s10120_radio.GetMissionStartRadioGroup: " .. tostring(radioGroup) )
	return radioGroupTable
end

this.MissionStart = function()
	Fox.Log("#### s10120_radio.MissionStart ####")
	TppRadio.Play( "s0120_rtrg0020" )
end






this.MissionContinueDuringLiquidFight = function()
	Fox.Log("#### s10120_radio.MissionContinueDuringLiquidFight ####")
	TppRadio.Play( "s0120_rtrg0040", { delayTime = "long" } )
end


this.MissionContinueAfterLiquid = function()
	Fox.Log("#### s10120_radio.MissionContinueAfterLiquid ####")
	TppRadio.Play( "s0120_oprg0100" )
end


this.DontKillKids = function()
	Fox.Log("#### s10120_radio.DontKillKids ####")
	TppRadio.Play( "s0120_rtrg0030", { isEnqueue = true, delayTime = "short" } )
end


this.ClearLiquid = function()
	Fox.Log("#### s10120_radio.ClearLiquid ####")
	TppRadio.Play( "s0120_rtrg0050" )
end


this.ClearLiquidFromFar = function()
	Fox.Log("#### s10120_radio.ClearLiquidFromFar ####")
	TppRadio.Play( "s0120_rtrg0060" )
end


this.CantFultonChild = function()
	Fox.Log("#### s10120_radio.CantFultonChild ####")
	TppRadio.Play( "s0120_rtrg0100" )
end


this.CantHoldChild = function()
	Fox.Log("#### s10120_radio.CantHoldChild ####")
	TppRadio.Play( "s0120_rtrg0120" )
end


this.DontAimChild = function()
	Fox.Log("#### s10120_radio.DontAimChild ####")
	TppRadio.Play( "s0120_rtrg0110" )
end





this.OptionalRadioGoToOutland = function()
	Fox.Log("#### s10120_radio.OptionalRadioGoToOutland ####")
	TppRadio.SetOptionalRadio( "Set_s0120_oprg0010" )
end





this.OptionalRadioFightPhaseOne = function()
	Fox.Log("#### s10120_radio.OptionalRadioFightPhaseOne ####")
	TppRadio.SetOptionalRadio( "Set_s0120_oprg0020" )
end





this.OptionalRadioFightPhaseTwo = function()
	Fox.Log("#### s10120_radio.OptionalRadioFightPhaseTwo ####")
	TppRadio.SetOptionalRadio( "Set_s0120_oprg0030" )
end





this.OptionalRadioCarryLZ = function()
	Fox.Log("#### s10120_radio.OptionalRadioCarryLZ ####")
	TppRadio.SetOptionalRadio( "Set_s0120_oprg0040" )
end





this.OptionalRadioChildFulton = function()
	Fox.Log("#### s10120_radio.OptionalRadioChildFulton ####")
	TppRadio.SetOptionalRadio( "Set_s0120_oprg0060" )
end





this.SetIntelRadioBeforeLiquidFight = function()
	Fox.Log("#### s10120_radio.SetIntelRadioBeforeLiquidFight ####")
	
	for i, enemyName in ipairs(s10120_enemy.AllChildSoldier) do
		Fox.Log( "SetIntelRadioBeforeLiquidFight: childSoldierName-> " .. enemyName )
		this.intelRadioBeforeLiquidFight[enemyName] = "s0120_esrg0010"
	end
	
	TppRadio.ChangeIntelRadio( this.intelRadioBeforeLiquidFight )
end





this.SetIntelRadioLiquidFightStarted = function()
	Fox.Log("#### s10120_radio.SetIntelRadioLiquidFightStarted ####")
	
	this.intelRadioAfterLiquidFight["TppLiquid2"] = "Invalid"
	for i, enemyName in ipairs(s10120_enemy.AllChildSoldier) do
		Fox.Log( "SetIntelRadioLiquidFightStarted: childSoldierName-> " .. enemyName )
		this.intelRadioAfterLiquidFight[enemyName] = "Invalid"
	end
	
	TppRadio.ChangeIntelRadio( this.intelRadioAfterLiquidFight )
end





this.SetIntelRadioLiquidFound = function()
	Fox.Log("#### s10120_radio.SetIntelRadioLiquidFound ####")
	TppRadio.ChangeIntelRadio( this.intelRadioFoundLiquid )
end



return this
