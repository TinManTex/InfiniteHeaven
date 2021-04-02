local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table




this.commonRadioTable = {}
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_MARKED ]				= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.SEARCH_TARGET_ENABLED ]		= TppRadio.IGNORE_COMMON_RADIO
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ]			= TppRadio.IGNORE_COMMON_RADIO	
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_DAMAGED_FROM_PC ]	= TppRadio.IGNORE_COMMON_RADIO	
this.commonRadioTable[ TppDefine.COMMON_RADIO.HOSTAGE_DEAD  ]				= TppRadio.IGNORE_COMMON_RADIO	

this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_RECOVERED ]			= TppRadio.IGNORE_COMMON_RADIO	
this.commonRadioTable[ TppDefine.COMMON_RADIO.TARGET_ELIMINATED ]			= TppRadio.IGNORE_COMMON_RADIO	





this.radioList = {
	
	"SupprtHeliDamageByPC",					
	
	{"s0100_rtrg0040", playOnce = true},	
	"f1000_rtrg1940",						
	"f1000_rtrg0090",						
	"s0100_rtrg1010",						
	{"s0100_rtrg1060", playOnce = true},	
	"f1000_rtrg2300", 						
	"f1000_rtrg2360",						
	"f1000_rtrg2380",						
	"f1000_rtrg2390",						
	"f1000_rtrg2400",						
	"f1000_rtrg2410",						
	"f1000_rtrg2430",						
	"f1000_rtrg2425",						
	"f1000_rtrg2370",						
	{"s0100_rtrg1040", playOnce = true},	
	{"s0100_rtrg1050", playOnce = true},	
	{"s0100_rtrg2010", playOnce = true},	
	{"s0100_rtrg2020", playOnce = true},	
	{"s0100_rtrg2030", playOnce = true},	
	{"s0100_rtrg2270", playOnce = true},	
	"f1000_rtrg1850",						
	"f1000_rtrg1950",						
	{"s0100_rtrg2100", playOnce = true},	
	{"s0100_rtrg2110", playOnce = true},	
	{"f1000_rtrg1060", playOnce = true},	
	"s0100_rtrg2190",						
	"s0100_rtrg2200",						
	"s0100_rtrg2210",						
	"f1000_rtrg1561",						
	"f1000_rtrg1562",						
	"f1000_rtrg1563",						
	"f1000_rtrg1564",						
	"f1000_rtrg1565",						
	"f1000_rtrg1070",						
	"s0100_rtrg2450",						
	"f1000_rtrg1840",						
	"f1000_rtrg1960",						
	"f1000_rtrg1970",						
	"s0100_rtrg2150",						
	"s0100_rtrg2160",						
	"f1000_rtrg2420",						
	{"s0100_rtrg2180", playOnce = true},	

	"f1000_rtrg1990",						
	"f1000_rtrg2000",						
	{"s0100_rtrg3010",	playOnce = true},	
	{"s0100_rtrg3020",	playOnce = true},	
	"s0100_rtrg1020",						
	"s0100_rtrg1030",						
	"f1000_rtrg1220",						
	"s0100_rtrg0060",						
	{"s0100_rtrg0050",	playOnce = true},	
	"s0100_rtrg0030",						
	"s0100_rtrg3040",						
	"s0100_rtrg0070",						
	{"f1000_rtrg2325",	playOnce = true},	
	{"f1000_rtrg2320",	playOnce = true},	
	"f1000_rtrg3180",						
	{"f1000_rtrg3560",	playOnce = true},	
	




	"f1000_rtrg2250",						
	"f1000_rtrg2260",						
	"s0100_rtrg4010",						
	"s0100_rtrg4020",						
}




this.optionalRadioList = {
	"Set_s0100_oprg0010",	
	"Set_s0100_oprg0020",	
	"Set_s0100_oprg0030",	
	"Set_s0100_oprg0040",	
	"Set_s0100_oprg0050",	
	"Set_s0100_oprg0060",	
	"Set_s0100_oprg0070",	
}
this.optionalRadio_10 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0010")
end
this.optionalRadio_20 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0020")
end
this.optionalRadio_30 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0030")
end
this.optionalRadio_40 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0040")
end
this.optionalRadio_50 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0050")
end
this.optionalRadio_60 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0060")
end
this.optionalRadio_70 = function()
	TppRadio.SetOptionalRadio("Set_s0100_oprg0070")
end




this.intelRadioList = {
	
	
	lightPowerDown			= "f1000_esrg1720",
	bananaTower				= "f1000_esrg0650",
	
	bananaCliff				= "f1000_esrg0660",
	bananaBigHouse			= "s0100_esrg1250",
	bananaSmallHouse01		= "f1000_esrg1670",
	bananaSmallHouse02		= "f1000_esrg1680",
	bananaSmallHouse03		= "f1000_esrg1690",
	bananaTent01			= "f1000_esrg1700",
	bananaTent02			= "f1000_esrg1710",
	bananaFarm01			= "f1000_esrg1770",
	bananaFarm02			= "f1000_esrg1730",
	bananaHill				= "f1000_esrg1740",
	bananaRordSide01		= "f1000_esrg1750",
	bananaRordSide02		= "f1000_esrg1760",
	bananaBush				= "f1000_esrg1780",
	
	sol_target_0000			= "Invalid",
	sol_banana_0001			= "f1000_esrg0720",
	sol_banana_0002			= "f1000_esrg0720",
	sol_banana_0003			= "f1000_esrg0720",
	sol_banana_0004			= "f1000_esrg0720",
	sol_banana_0005			= "f1000_esrg0720",
	sol_banana_0006			= "f1000_esrg0720",
	sol_banana_0007			= "f1000_esrg0720",
	sol_banana_0008			= "f1000_esrg0720",
	sol_banana_0009			= "f1000_esrg0720",
	sol_banana_0010			= "f1000_esrg0720",
	veh_s10100_0000			= "f1000_esrg1190",
	veh_s10100_0001			= "f1000_esrg1190",
	veh_s10100_0002			= "f1000_esrg1190",
	
	
	diamond_gate			= "s0100_esrg1010",
	
	breakFence				= "f1000_esrg1620",
	boys_pickingDoor		= "s0100_esrg1090",
	dummy_pickingDoor		= "s0100_esrg1080",
	phote_pickingDoor		= "s0100_esrg1060",
	
	hos_diamond_0000		= "s0100_esrg2030",
	hos_diamond_0001		= "s0100_esrg2010",
	hos_diamond_0002		= "s0100_esrg2010",
	hos_diamond_0003		= "s0100_esrg2010",
	hos_diamond_0004		= "s0100_esrg2010",
	EnemyHeli				= "f1000_esrg1160",
}

this.intelRadioList_brokenBananaTower = {
	
	
	bananaTower				= "Invalid",
}

this.intelRadioList_brokenHATSUDENKI = {
	
	
	lightPowerDown			= "Invalid",
}

this.intelRadioList_attestationBananaTarget = {
	
	
	lightPowerDown			= "Invalid",
	bananaTower				= "Invalid",
	
	bananaCliff				= "Invalid",
	bananaBigHouse			= "Invalid",
	bananaHill				= "Invalid",
	bananaRordSide01		= "Invalid",
	bananaRordSide02		= "Invalid",
	
	sol_target_0000			= "f1000_esrg0680",
	sol_banana_0001			= "f1000_esrg0710",
	sol_banana_0002			= "f1000_esrg0710",
	sol_banana_0003			= "f1000_esrg0710",
	sol_banana_0004			= "f1000_esrg0710",
	sol_banana_0005			= "f1000_esrg0710",
	sol_banana_0006			= "f1000_esrg0710",
	sol_banana_0007			= "f1000_esrg0710",
	sol_banana_0008			= "f1000_esrg0710",
	sol_banana_0009			= "f1000_esrg0710",
	sol_banana_0010			= "f1000_esrg0710",
}

this.intelRadioList_clearBananaTarget = {
	
	
	lightPowerDown			= "Invalid",
	bananaTower				= "Invalid",
	
	bananaCliff				= "Invalid",
	bananaBigHouse			= "Invalid",
	bananaSmallHouse01		= "Invalid",
	bananaSmallHouse02		= "Invalid",
	bananaSmallHouse03		= "Invalid",
	bananaTent01			= "Invalid",
	bananaTent02			= "Invalid",
	bananaFarm01			= "Invalid",
	bananaFarm02			= "Invalid",
	bananaHill				= "Invalid",
	bananaRordSide01		= "Invalid",
	bananaRordSide02		= "Invalid",
	bananaBush				= "Invalid",
	
	sol_target_0000			= "Invalid",
	sol_banana_0001			= "Invalid",
	sol_banana_0002			= "Invalid",
	sol_banana_0003			= "Invalid",
	sol_banana_0004			= "Invalid",
	sol_banana_0005			= "Invalid",
	sol_banana_0006			= "Invalid",
	sol_banana_0007			= "Invalid",
	sol_banana_0008			= "Invalid",
	sol_banana_0009			= "Invalid",
	sol_banana_0010			= "Invalid",
}

this.intelRadioList_brokenFrontGate = {
	
	
	diamond_gate			= "Invalid",
}

this.intelRadioList_inToDiamond = {
	
	
	diamond_gate			= "Invalid",
	
	breakFence				= "Invalid",	
}

this.intelRadioList_inToDiamond_Cave = {
	
	
	dummy_pickingDoor		= "Invalid",
	phote_pickingDoor		= "Invalid",
}

this.intelRadioList_afterBoyHostages = {
	
	
	diamond_gate			= "Invalid",
	
	breakFence				= "Invalid",	
	boys_pickingDoor		= "Invalid",
	dummy_pickingDoor		= "Invalid",
	phote_pickingDoor		= "Invalid",
}




this.SupprtHeliDeadByEnemy = function()
	Fox.Log("#### s10100_radio.SupprtHeliDeadByEnemy ####")
	TppRadio.Play( "f1000_rtrg1940" )
end

this.SupprtHeliDeadByPC = function()
	Fox.Log("#### s10100_radio.SupprtHeliDeadByPC ####")
	TppRadio.Play( "f1000_rtrg0090" )
end

this.SupprtHeliDamageByEnemy = function()
	Fox.Log("#### s10100_radio.SupprtHeliDamageByEnemy ####")
	TppRadio.Play( "s0100_rtrg0030" )
end

this.SupprtHeliDamageByPC = function()
	Fox.Log("#### s10100_radio.SupprtHeliDamageByPC ####")
	TppRadio.Play( "f1000_rtrg0090" )
end

this.s10100_missionBriefing = function()
	Fox.Log("#### s10100_radio.missionBriefing ####")
	TppRadio.Play( "s0100_rtrg1010" )
end

this.arrived_banana = function()
	Fox.Log("#### s10100_radio.arrived_banana ####")
	TppRadio.Play( "s0100_rtrg1060" )
end

this.discoveryTarget = function()
	Fox.Log("#### s10100_radio.discoveryTarget ####")
	TppRadio.Play( "f1000_rtrg2300" , { delayTime = "short" })
end

this.beforeAttestationAction = function()
	Fox.Log("#### s10100_radio.beforeAttestationAction ####")
	TppRadio.Play( "f1000_rtrg2360" , { delayTime = "short" })
end

this.unconsciousTarget = function()
	Fox.Log("#### s10100_radio.unconsciousTarget ####")
	TppRadio.Play("f1000_rtrg2380" , { delayTime = "short" })
end

this.targetKill = function()
	Fox.Log("#### s10100_radio.targetKill ####")
	TppRadio.Play( "f1000_rtrg2390" , { delayTime = "short" })
end

this.targetKillBeforeAttestation = function()
	Fox.Log("#### s10100_radio.targetKillBeforeAttestation ####")
	TppRadio.Play( "f1000_rtrg2400" , { delayTime = "short" })
end

this.targetCollect = function()
	Fox.Log("#### s10100_radio.targetCollect ####")
	TppRadio.Play( "f1000_rtrg2410" )
end

this.targetFulton_Fail = function()
	Fox.Log("#### s10100_radio.targetFulton_Fail ####")
	TppRadio.Play( "f1000_rtrg2430" )
end

this.targetFulton_FailBeforeAttestation = function()
	Fox.Log("#### s10100_radio.targetFulton_FailBeforeAttestation ####")
	TppRadio.Play( "f1000_rtrg2425" )
end

this.targetCollectBeforeAttestation = function()
	Fox.Log("#### s10100_radio.targetCollectBeforeAttestation ####")
	TppRadio.Play( "f1000_rtrg2370" )
end

this.diamondAnnounce = function()
	Fox.Log("#### s10100_radio.diamondAnnounce ####")
	TppRadio.Play( "s0100_rtrg1040" , { delayTime = "short" } )
end

this.arrived_diamond = function()
	Fox.Log("#### s10100_radio.arrived_diamond ####")
	TppRadio.Play( "s0100_rtrg1050" )
end

this.purposeChange = function()
	Fox.Log("#### s10100_radio.purposeChange ####")
	TppRadio.Play( "s0100_rtrg2010", { delayTime = "long" } )
end

this.boyHostages_tutorial01 = function()
	Fox.Log("#### s10100_radio.boyHostages_tutorial01 ####")
	TppRadio.Play( "s0100_rtrg0040" )
end

this.injury_boyHostage = function()
	Fox.Log("#### s10100_radio.injury_boyHostage ####")
	TppRadio.Play( "s0100_rtrg2020" )
end

this.carryInjuryBoyHostage = function()
	Fox.Log("#### s10100_radio.carryInjuryBoyHostage ####")
	TppRadio.Play( "s0100_rtrg2030" )
end

this.gameOver_announce = function()
	Fox.Log("#### s10100_radio.gameOver_announce ####")
	TppRadio.Play( "s0100_rtrg0050" )
end

this.detourRv = function()
	Fox.Log("#### s10100_radio.detourRv ####")
	TppRadio.Play( "s0100_rtrg2270" )
end

this.aarCatchHeli = function()
	Fox.Log("#### s10100_radio.aarCatchHeli ####")
	TppRadio.Play( "f1000_rtrg1850" )
end

this.enemyHeliAppearance = function()
	Fox.Log("#### s10100_radio.enemyHeliAppearance ####")
	TppRadio.Play( "f1000_rtrg1950" )
end

this.escapePerceived = function()
	Fox.Log("#### s10100_radio.escapePerceived ####")
	TppRadio.Play( "s0100_rtrg2100" )
end

this.stopPursuer = function()
	Fox.Log("#### s10100_radio.stopPursuer ####")
	TppRadio.Play( "s0100_rtrg2110" )
end

this.reinforcementAppearance = function()
	Fox.Log("#### s10100_radio.reinforcementAppearance ####")
	TppRadio.Play( "f1000_rtrg1060" )
end

this.BoyFultonNg_01 = function()
	Fox.Log("#### s10100_radio.fultonNg_01 ####")
	TppRadio.Play( "s0100_rtrg2190" )
end

this.BoyFultonNg_02 = function()
	Fox.Log("#### s10100_radio.fultonNg_02 ####")
	TppRadio.Play( "s0100_rtrg2200" )
end

this.BoyFultonNg_03 = function()
	Fox.Log("#### s10100_radio.fultonNg_03 ####")
	TppRadio.Play( "s0100_rtrg2210" )
end

this.BoyFultonSuccess_01 = function()
	Fox.Log("#### s10100_radio.BoyFultonSuccess_01 ####")
	TppRadio.Play( "f1000_rtrg1561",{ delayTime = "mid" } )
end

this.BoyFultonSuccess_02 = function()
	Fox.Log("#### s10100_radio.BoyFultonSuccess_02 ####")
	TppRadio.Play( "f1000_rtrg1562",{ delayTime = "mid" } )
end

this.BoyFultonSuccess_03 = function()
	Fox.Log("#### s10100_radio.BoyFultonSuccess_03 ####")
	TppRadio.Play( "f1000_rtrg1563",{ delayTime = "mid" } )
end

this.BoyFultonSuccess_04 = function()
	Fox.Log("#### s10100_radio.BoyFultonSuccess_04 ####")
	TppRadio.Play( "f1000_rtrg1564",{ delayTime = "mid" } )
end

this.BoyFultonSuccess_05 = function()
	Fox.Log("#### s10100_radio.BoyFultonSuccess_05 ####")
	TppRadio.Play( "f1000_rtrg1565", { delayTime = "mid" } )
end

this.enemyDiscoveryBoys = function()
	Fox.Log("#### s10100_radio.enemyDiscoveryBoys ####")
	TppRadio.Play( "f1000_rtrg1070" )
end

this.awayFrom_boyHostages = function()
	Fox.Log("#### s10100_radio.awayFrom_boyHostages ####")
	TppRadio.Play( "f1000_rtrg2325" )
end

this.dontComeBoys = function()
	Fox.Log("#### s10100_radio.dontComeBoys ####")
	TppRadio.Play( "s0100_rtrg2450" )
end

this.nearRv = function()
	Fox.Log("#### s10100_radio.nearRv ####")
	TppRadio.Play( "f1000_rtrg1840" )
end

this.enemyHeliDead = function()
	Fox.Log("#### s10100_radio.enemyHeliDead ####")
	TppRadio.Play( "f1000_rtrg1960" )
end

this.supportHeliDownStart = function()
	Fox.Log("#### s10100_radio.supportHeliDownStart ####")
	TppRadio.Play( "f1000_rtrg1970" )
end

this.BoyHostagesRecovery = function()
	Fox.Log("#### s10100_radio.BoyHostagesRecovery ####")
	TppRadio.Play( "s0100_rtrg2150" )
end

this.BoyHostagesRecovery02 = function()
	Fox.Log("#### s10100_radio.BoyHostagesRecovery02 ####")
	TppRadio.Play( "s0100_rtrg2160" )
end

this.BoyFluton_Fail = function()
	Fox.Log("#### s10100_radio.BoyFluton_Fail ####")
	TppRadio.Play( "f1000_rtrg2420" )
end

this.nextBananaTarget = function()
	Fox.Log("#### s10100_radio.nextBananaTarget ####")
	TppRadio.Play( "s0100_rtrg2180", { delayTime = "short" } )
end

this.noCallHeli = function()
	Fox.Log("#### s10100_radio.noCallHeli ####")
	TppRadio.Play( "f1000_rtrg1980" )
end

this.heliArrivedRV = function()
	Fox.Log("#### s10100_radio.heliArrivedRV ####")
	TppRadio.Play( "f1000_rtrg1990" )
end

this.supportHeliDead = function()
	Fox.Log("#### s10100_radio.supportHeliDead ####")
	TppRadio.Play( "f1000_rtrg2000" )
end

this.farmessFrom_boyHostages = function()
	Fox.Log("#### s10100_radio.farmessFrom_boyHostages ####")
	TppRadio.Play( "s0100_rtrg0060" )
end


this.CTN_NoBananaNoBoys = function()
	Fox.Log("#### s10100_radio.CTN_NoBananaNoBoys ####")
	TppRadio.Play( "s0100_rtrg1020" )
end

this.CTN_NoBoys = function()
	Fox.Log("#### s10100_radio.CTN_NoBoys ####")
	TppRadio.Play( "s0100_rtrg1030" )
end

this.CTN_BoysToRV = function()
	Fox.Log("#### s10100_radio.CTN_BoysToRV ####")
	TppRadio.Play( "f1000_rtrg1220" )
end

this.rideOnHeli_Advice01 = function()
	Fox.Log("#### s10100_radio.rideOnHeli_Advice01 ####")
	TppRadio.Play( "s0100_rtrg3010" )
end

this.rideOnHeli_Advice02 = function()
	Fox.Log("#### s10100_radio.rideOnHeli_Advice02 ####")
	TppRadio.Play( "s0100_rtrg3020" )
end

this.rideOnHeli_Escape = function()
	Fox.Log("#### s10100_radio.rideOnHeli_Escape ####")
	TppRadio.Play( "s0100_rtrg3040" )
end

this.boyDiscoveried = function()
	Fox.Log("#### s10100_radio.boyDiscoveried ####")
	TppRadio.Play( "s0100_rtrg0070" )
end

this.not_AllBoysClear_toHotZone = function()
	Fox.Log("#### s10100_radio.not_AllBoysClear_toHotZone ####")
	TppRadio.Play( "f1000_rtrg2320" )
end

this.notClearFactor_onHeli = function()
	Fox.Log("#### s10100_radio.notClearFactor_onHeli ####")
	TppRadio.Play( "f1000_rtrg3180" )
end

this.boyOnHeli_advice = function()
	Fox.Log("#### s10100_radio.boyOnHeli_advice ####")
	TppRadio.Play( "f1000_rtrg3560" )
end




this.dontPicking_Alert = function()
	Fox.Log("#### s10100_radio.dontPicking_Alert ####")
	TppRadio.Play( "f1000_rtrg2250" )
end

this.dontPicking_Enemy = function()
	Fox.Log("#### s10100_radio.dontPicking_Enemy ####")
	TppRadio.Play( "f1000_rtrg2260" )
end

this.Alert_off = function()
	Fox.Log("#### s10100_radio.Alert_off ####")
	TppRadio.Play( "s0100_rtrg4010" )
end

this.enemy_off = function()
	Fox.Log("#### s10100_radio.enemy_off ####")
	TppRadio.Play( "s0100_rtrg4020" )
end












this.ChangeIntelRadio_brokenBananaTower = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_brokenBananaTower )
end

this.ChangeIntelRadio_brokenHATSUDENKI = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_brokenHATSUDENKI )
end

this.ChangeIntelRadio_attestationBananaTarget = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_attestationBananaTarget )
end

this.ChangeIntelRadio_clearBananaTarget = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_clearBananaTarget )
end

this.ChangeIntelRadio_brokenFrontGate = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_brokenFrontGate )
end

this.ChangeIntelRadio_inToDiamond = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_inToDiamond )
end

this.ChangeIntelRadio_inToDiamond_Cave = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_inToDiamond_Cave )
end

this.ChangeIntelRadio_afterBoyHostages = function()
	TppRadio.ChangeIntelRadio( this.intelRadioList_afterBoyHostages )
end



return this
