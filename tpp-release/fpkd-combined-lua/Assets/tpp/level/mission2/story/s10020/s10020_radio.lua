local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table





local OCELOT_NAME = "Ocelot"
local OCELOT_GAMEOBJTYPE = "TppOcelot2"
local MILLER_NAME = "s10020_hostage_miller"
local MILLER_GAMEOBJTYPE = "TppHostageKaz"

local SPEECH_CHARACTER = {
	OCELOT = {
		NAME = "Ocelot",
		GAMEOBJTYPE = "TppOcelot2",
	},
	MILLER = {
		NAME = "s10020_hostage_miller",
		GAMEOBJTYPE = "TppHostageKaz",
	}
}

local PRESET_DELAY_TIME = {
	short	= 0.5,
	mid		= 1.5,
	long	= 3.0,
}




this.commonRadioTable = {
	[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE_ALERT ] 	= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.OUTSIDE_HOTZONE ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME ] 	= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.CALL_HELI_FIRST_TIME_HOT_ZONE ] = TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.CALL_HELI_SECOND_TIME ] 	= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.ABORT_BY_HELI ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RETURN_HOTZONE ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.OUTSIDE_MISSION_AREA ] 	= "f1000_rtrg0015",
	[ TppDefine.COMMON_RADIO.RECOMMEND_CURE ] 			= "f1000_rtrg0125",
	[ TppDefine.COMMON_RADIO.SUPPRESSOR_BROKEN ] 		= "f1000_rtrg0135",
	
	[ TppDefine.COMMON_RADIO.ENEMY_RECOVERED ] 			= "f1000_rtrg0105",
	[ TppDefine.COMMON_RADIO.HOSTAGE_RECOVERED ] 		= "f1000_rtrg0105",
	
	[ TppDefine.COMMON_RADIO.TARGET_RECOVERED ] 		= TppRadio.IGNORE_COMMON_RADIO,
	
	
	[ TppDefine.COMMON_RADIO.RESULT_RANK_S ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_A ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_B ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_C ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_D ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_E ] 			= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.RESULT_RANK_NOT_DEFINED ] = TppRadio.IGNORE_COMMON_RADIO,
	
	
	[ TppDefine.COMMON_RADIO.UNLOCK_LANDING_ZONE  ] 	= TppRadio.IGNORE_COMMON_RADIO,

	[ TppDefine.COMMON_RADIO.HELI_LOST_CONTROL_END ] 	= TppRadio.IGNORE_COMMON_RADIO,		
	[ TppDefine.COMMON_RADIO.HELI_DAMAGE_FROM_PLAYER ] 	= "f1000_rtrg0085",		
	[ TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_RUSSIAN ]	= TppRadio.IGNORE_COMMON_RADIO,
	[ TppDefine.COMMON_RADIO.DISABLE_TRANSLATE_AFRIKANS ] 	= TppRadio.IGNORE_COMMON_RADIO,
}




this.radioList = {

	
	"s0020_mirg0010",	
	
	
	"s0020_mprg0020", 	
	"f1000_mprg0150", 	
	"s0020_mprg0040", 	
	
	
	{ "f1000_rtrg2970", playOnce = true },	
	{ "f1000_rtrg2910", playOnce = true },	
	{ "f1000_rtrg2740", playOnce = true },	
	{ "f1000_rtrg2745", playOnce = true },	
	{ "s0020_rtrg0040", playOnce = true },	
	{ "s0020_rtrg0050", playOnce = true },	
	{ "s0020_rtrg0060", playOnce = true },	
	{ "s0020_rtrg0070", playOnce = true },	
	{ "s0020_rtrg0080", playOnce = true },	
	{ "f1000_rtrg2730", playOnce = true },	
	{ "f1000_rtrg2980", playOnce = true },	
	{ "f1000_rtrg2990", playOnce = true },	
	{ "s0020_rtrg0130", playOnce = true },	
	{ "s0020_rtrg0132", playOnce = true },	
	
	{ "f1000_rtrg0930", playOnce = true },	
	{ "f1000_rtrg0940", playOnce = true },	
	
	{ "f1000_rtrg0950", playOnce = true },	
	{ "f1000_rtrg2890", playOnce = true },	
	{ "f1000_rtrg2900", playOnce = true },	

	{ "f1000_rtrg3000", playOnce = true },	
	{ "s0020_rtrg1020", playOnce = true },	
	{ "s0020_rtrg1023", playOnce = true },	
	{ "f1000_rtrg3020", playOnce = true },	
	{ "f1000_rtrg3020", playOnce = true },	
	
	{ "f1000_rtrg1680", playOnce = true },	
	{ "f1000_rtrg1690", playOnce = true },	
	{ "f1000_rtrg1700", playOnce = true },	
	{ "s0020_rtrg1070", playOnce = true },	

	{ "f1000_rtrg2010", playOnce = true },	
	{ "s0020_rtrg1090", playOnce = true },	
	{ "s0020_rtrg1100", playOnce = true },	
	{ "s0020_rtrg2010", playOnce = true },	
	{ "s0020_rtrg2020", playOnce = true },	
	{ "s0020_rtrg2030", playOnce = true },	
	{ "s0020_rtrg2040", playOnce = true },	
	{ "s0020_rtrg3010", playOnce = true },	
	{ "s0020_rtrg3020", playOnce = true },	
	{ "s0020_rtrg3060", playOnce = true },	

	{ "f1000_rtrg3570", playOnce = true },	
	
	"s0020_rtrg3030",	
	"s0020_rtrg3040",	
	"s0020_rtrg3050",	
	"s0020_rtrg4010",	
	"s0020_rtrg4020",	

	{ "s0020_rtrg4030", playOnce = true },	
	{ "s0020_rtrg5010", playOnce = true },	
	{ "s0020_rtrg5020", playOnce = true },	
	"s0020_rtrg5030",	
	"s0020_rtrg5050",	
	{ "s0020_rtrg6010", playOnce = true },	
	{ "s0020_rtrg6020", playOnce = true },	
	{ "s0020_rtrg6030", playOnce = true },	

	{ "s0020_rtrg7010", playOnce = true },	
	{ "s0020_rtrg7020", playOnce = true },	
	{ "s0020_rtrg8010", playOnce = true },	
	{ "s0020_rtrg8020", playOnce = true },	
	{ "s0020_rtrg8030", playOnce = true },	
	{ "s0020_rtrg8040", playOnce = true },	

	{ "s0020_rtrg0200", playOnce = true },	
	{ "s0020_rtrg0210", playOnce = true },	
	{ "s0020_rtrg0220", playOnce = true },	
	{ "s0020_rtrg0230", playOnce = true },	
	{ "s0020_rtrg0240", playOnce = true },	
	{ "s0020_rtrg0250", playOnce = true },	
	{ "s0020_rtrg0260", playOnce = true },	
	{ "s0020_rtrg0270", playOnce = true },	

	"s0020_rtrg9010",	
	"s0020_rtrg9015",	
	"s0020_rtrg9020",	
	"s0020_rtrg9030",	
	"s0020_rtrg9050",	
	"s0020_rtrg9051",	
	"f1000_rtrg2760",	
	
	"f1000_rtrg1540",	
}





this.optionalRadioList = {
	"Set_s0020_oprg0010",
	"Set_s0020_oprg1010",
	"Set_s0020_oprg1030",
	"Set_s0020_oprg2010",
	"Set_s0020_oprg3010",
	"Set_s0020_oprg3020",
	"Set_s0020_oprg3030",
	"Set_s0020_oprg4010",
	"Set_s0020_oprg5010",
	"Set_s0020_oprg6010",
}





this.intelRadioList = {
	
	type_searchradar 					= "Invalid",
	type_antiAirGun 					= "Invalid",
	type_searchlight  					= "Invalid",
	type_drumcan  						= "Invalid",
	type_camera 	 					= "Invalid",
	type_truck  						= "Invalid",	
	
	erl_binotutolial_village 			= "MessageOnly",
	erl_village_IntelHouse 				= "Invalid",
	erl_village_canal 					= "Invalid",
	erl_flag 							= "Invalid",
	erl_Center 							= "Invalid",
	erl_slopedTpwn_MirrorHouse 			= "Invalid",
	erl_slopedTpwn_MirrorHouse_Intel 	= "Invalid",
	type_enemy 							= "Invalid" 
}

this.intelRadioList_mission = {
	
	type_searchradar 					= "Invalid",
	type_antiAirGun 					= "Invalid",
	type_searchlight  					= "Invalid",
	type_drumcan  						= "Invalid",
	type_camera 	 					= "Invalid",
	type_truck  						= "Invalid",	

	erl_binotutolial_village 			= "Invalid",
	erl_village_IntelHouse 				= "f1000_esrg1530",
	erl_village_canal 					= "f1000_esrg1540",
	erl_flag 							= "f1000_esrg1550",
	erl_Center 							= "f1000_esrg1560",
	erl_slopedTpwn_MirrorHouse 			= "s0020_esrg3020",
	erl_slopedTpwn_MirrorHouse_Intel 	= "s0020_esrg3025",
	type_enemy 							= "f1000_esrg0850",
	
	sol_slopedTown_0000					= "f1000_esrg0840",
	sol_slopedTown_0001					= "f1000_esrg0840",
	sol_slopedTown_0002					= "f1000_esrg0840",
	sol_slopedTown_0003					= "f1000_esrg0840",
	sol_slopedTown_0004					= "f1000_esrg0840",
	sol_slopedTown_0005					= "f1000_esrg0840",
	sol_slopedTown_0006					= "f1000_esrg0840",
	sol_slopedTown_0007					= "f1000_esrg0840",
	sol_slopedTown_0008					= "f1000_esrg0840",
	sol_slopedTown_0009					= "f1000_esrg0840",
	sol_slopedTown_0010					= "f1000_esrg0840",
	sol_village_0000					= "f1000_esrg0840",
	sol_village_0001					= "f1000_esrg0840",
	sol_village_0002					= "f1000_esrg0840",
	sol_village_0003					= "f1000_esrg0840",
	sol_village_0004					= "f1000_esrg0840",
	sol_village_0005					= "f1000_esrg0840",
	sol_village_0006					= "f1000_esrg0840",
	
}



this.gameOverRadioTable = {}
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.PLAYER_DEAD] 					= "f8000_gmov0100"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA] 		= "f8000_gmov0090"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10020_TARGET_TIMEOVERDEAD] 		= "s0020_gmov4010"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10020_TARGET_DEAD] 				= "s0020_gmov4020"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10020_TARGET_KILL] 				= "s0020_gmov4030"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10020_RIDING_HELI_DESTROYED] 	= "s0020_gmov4040"	
this.gameOverRadioTable[TppDefine.GAME_OVER_RADIO.S10020_PLAYER_DESTROY_HELI] 		= "s0020_gmov4050"	













this.PlaySpeech = function ( speechSetTable )
	local locatorName = speechSetTable.speakerName
	local gameObjectType = speechSetTable.speakerType
	local gameObjectId = GameObject.GetGameObjectId(gameObjectType, locatorName)
	local carryFlag = speechSetTable.carry or false
	local command = {
		id = "CallMonologue",
		label = speechSetTable.speechLabel,
		carry = carryFlag,
	}
	GameObject.SendCommand( gameObjectId, command )
end

this.ResetSpeech_Miller = function()
	local gameObjectId = GameObject.GetGameObjectId( "s10020_hostage_miller" )
	local command = {
			id="CallMonologue",
			reset = true,
	}
	GameObject.SendCommand( gameObjectId, command )
end







this.Tutorial_start = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_001",
	}
end


this.SuggestOpenIdroid = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_002",
	}
end


this.OpenedIdroid = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_003",
	}
end


this.CloseIdroid = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_003_end",
	}
end


this.SuggestCloseIdroid = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_004",
	}
end


this.Tutorial_Binoculars = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_005",
	}
end


this.SuggestUseBino = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_006",
	}
end


this.Tutorial_UseZoom = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_007",
	}
end

this.Tutorial_MoreRight = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_008",
	}
end
this.Tutorial_MoreLeft = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_009",
	}
end
this.Tutorial_MoreUp = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_010",
	}
end
this.Tutorial_MoreDown = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_011",
	}
end


this.SuggestUseZoom = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_013",
	}
end


this.Tutorial_EspionageRadio = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_014",
	}
end


this.SuggestEspionageRadio = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_015",
	}
end


this.EspionageRadio = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_016",
	}
end


this.Tutorial_CustumMarker = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_017",
	}
end


this.SuggestCustumMarker = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_018",
	}
end


this.ThisisNotVillage = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_019",
	}
end


this.SuccessCustumMarker = function()
	this.PlaySpeech{
		speakerName = OCELOT_NAME,
		speakerType = OCELOT_GAMEOBJTYPE,
		speechLabel = "MRTS_020",
	}
end




this.Tutorial_OpenMap = function()
	TppRadio.Play( "s0020_rtrg0080")
end

this.TutolialAtFirstOB = function()
	TppRadio.Play( "s0020_rtrg0270")
end


this.Tutorial_Diamond = function()
	TppRadio.Play( "s0020_rtrg0200", { delayTime = "short" })
end

this.Tutorial_Resources = function()
	TppRadio.Play( "s0020_rtrg0210", { delayTime = "short" })
end

this.Tutorial_Plant = function()
	TppRadio.Play( "s0020_rtrg0220", { delayTime = "short" })
end

this.Tutorial_Animal = function()
	TppRadio.Play( "s0020_rtrg0230", { delayTime = "short" })
end


this.Tutorial_MapMaker = function()
	TppRadio.Play( "s0020_rtrg0090" )
end

this.Tutorial_Ruins = function()
	TppRadio.Play( "s0020_rtrg0240" )
end


this.Tutorial_Climb = function()
	TppRadio.Play( "s0020_rtrg0250", { delayTime = "short" } )
end


this.Tutorial_NeutralizeEnemy = function()
	TppRadio.Play( "f1000_rtrg2910", { delayTime = "long" } )
end


this.Tutorial_Callhorse = function()
	TppRadio.Play( "f1000_rtrg2970" )
end


this.ObtainIntelAtVillage = function()
	TppRadio.Play( "s0020_rtrg2010" )
end


this.ObtainIntelAtCommfacility = function()
	TppRadio.Play( "s0020_rtrg2020" )
end


this.ObtainIntelAtEnemyBase = function()
	TppRadio.Play( "s0020_rtrg2010" )
end


this.ArriveAtVillageBuild1F = function()

end


this.ApproachVillage = function()
	TppRadio.Play( "s0020_rtrg0050" )
end


this.ArriveAtVillage_EP = function()
	TppRadio.Play( "f1000_rtrg3000" )
end


this.ArriveAtVillage_farEP_useBino = function()
	TppRadio.Play( "s0020_rtrg0070" )
end


this.UseBinoOnEP = function()
	TppRadio.Play( "s0020_rtrg1020" )
end


this.NotUseBinoArriveVillage = function()
	TppRadio.Play( "s0020_rtrg1023" )
end


this.PutCustumMarker = function()
	TppRadio.Play( "f1000_rtrg3020" )
end


this.NotUseBinoIntoIntelBuild = function()
	TppRadio.Play( "f1000_rtrg3020" )
end


this.ArriveAtVillage_EP_useBino = function()
	TppRadio.Play( "s0020_rtrg0060" )
end


this.OptionalRadio = function()
	TppRadio.Play( "f1000_rtrg2730", { delayTime = "short" } )
end


this.TutorialCiger = function()
	TppRadio.Play( "f1000_rtrg2990" )
end


this.AlertToEvasion = function()
	TppRadio.Play( "f1000_rtrg0930" )
end


this.EvasionToCaution = function()
	TppRadio.Play( "f1000_rtrg0940" )
end


this.NeedTranslater1 = function()
	TppRadio.Play( "f1000_rtrg0950" )
end


this.NeedTranslater2 = function()
	TppRadio.Play( "f1000_rtrg2890" )
end


this.NeedTranslater3 = function()
	TppRadio.Play( "f1000_rtrg2900" )
end


this.ApproachWayToEnemyBase = function()
	TppRadio.Play( "s0020_rtrg7010" )
end


this.ArriveAtFirstOB = function()
	TppRadio.Play( "s0020_rtrg0260" )
end

this.ArriveAtOB = function()
	TppRadio.Play( "f1000_rtrg2010" )
end


this.ArriveAtCommFacility_intel  = function()
	TppRadio.Play( "s0020_rtrg2030" )
end

this.ArriveAtCommFacility_NoIntel = function()
	TppRadio.Play( "s0020_rtrg1090" )
end


this.ArriveAtSlopedTown_Intel = function()
	TppRadio.Play( "s0020_rtrg3020" )
end

this.ArriveAtSlopedTown_NoIntel = function()
	TppRadio.Play( "s0020_rtrg3010" )
end


this.ArriveAtEnemyBase_Intel = function()
	TppRadio.Play( "s0020_rtrg2040" )
end

this.ArriveAtEnemyBase_NoIntel = function()
	TppRadio.Play( "s0020_rtrg1100" )	
end

this.ArriveAtMillerHouse_Intel = function()
	TppRadio.Play( "s0020_rtrg3060" )	
end	

this.CantMeetsKazOnAlert = function()
	TppRadio.Play( "s0020_rtrg3030" )
end


this.CantGetIntelOnAlert = function()
	TppRadio.Play( "f1000_rtrg1680" )
end


this.LostIntel = function()
	TppRadio.Play( "f1000_rtrg1690" )
end


this.LostIntel_gotoOther = function()
	TppRadio.Play( "f1000_rtrg1700" )
end


this.LostIntel_gotoSloped = function()
	TppRadio.Play( "s0020_rtrg1070" )
end


this.InIntelHouse = function()
	TppRadio.Play( "f1000_rtrg3570" )
end


this.tutorial_marking = function()
	TppRadio.Play( "f1000_rtrg2740" )
end


this.tutorial_marking_notUseBino = function()
	TppRadio.Play( "f1000_rtrg2745" )
end


this.Tutorial_cure = function()
	TppRadio.Play( "s0020_rtrg0130")
end


this.Tutorial_lowStance = function()
	TppRadio.Play( "s0020_rtrg0132")
end


this.DontAttackMiller = function()
	TppRadio.Play( "s0020_rtrg3040")
end


this.DontAttackMiller2 = function()
	TppRadio.Play( "s0020_rtrg3050")
end


this.DontPutMiller = function()
	TppRadio.Play( "s0020_rtrg4010")
end


this.DontAttackMiller_afterMeets = function()
	TppRadio.Play( "s0020_rtrg4020")
end


this.OutOfMissionArea = function()
	TppRadio.Play( "s0020_rtrg7020" )
end


this.ChangePhaseEvasion = function()
	TppRadio.Play( "f1000_rtrg0930" )
end


this.ChangePhaseCaution = function()
	TppRadio.Play( "f1000_rtrg0940" )
end



this.OneDayCourse = function()
	TppRadio.Play( "s0020_rtrg8010" )
end

this.TwoDayCourse = function()
	TppRadio.Play( "s0020_rtrg8020" )
end

this.ThreeDayCourse= function()	
	TppRadio.Play( "s0020_rtrg8030" )
end

this.FourDayCourse = function()
	TppRadio.Play( "s0020_rtrg8040" )
end

this.FourDayCourse_near = function()
	TppRadio.Play( "s0020_rtrg8040" )
end

this.FirstNight = function()
	TppRadio.Play( "f1000_rtrg2980" )
end



this.GoToRVPointWithMiller = function()
	TppRadio.Play( "s0020_rtrg4030" )
end


this.MillerMonologue1 = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0010",
		carry	= true ,
	}
end

this.MillerMonologue2 = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0020",
		carry	= true ,
	}
end
this.MillerMonologue3 = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0030",
		carry	= true ,
	}
end
this.MillerMonologue4 = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0040",
		carry	= true ,
	}
end
this.MillerMonologue5 = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0050",
		carry	= true ,
	}
end

this.MillerKoParaUnit = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0120",
	}
end



this.GoToNewRVPointWithMiller = function()
	TppRadio.Play( "s0020_rtrg5010" )
end


this.EscapeFromParaUnit = function()
	TppRadio.Play( "s0020_rtrg5020" )
end


this.DontFightParaUnit = function()
	TppRadio.Play( "s0020_rtrg5030" )
end


this.CantEscapeByWalk = function()
	TppRadio.Play( "s0020_rtrg5050" )
end


this.MillerMonologue_EscapeComplete = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0110",
	}
end



this.EscapeComplete = function()
	TppRadio.Play( "s0020_rtrg6010"  , { delayTime = "long" })
end


this.MillerMonologue_EscapeComplete = function()
	this.PlaySpeech{
		speakerName = MILLER_NAME,
		speakerType = MILLER_GAMEOBJTYPE,
		speechLabel = "KZCT_0050",
	}
end


this.Tutorial_PutOnMirrorOnHeli = function()
	TppRadio.Play( "s0020_rtrg6020" )
end


this.PutOnMirrorOnHeli = function()
	TppRadio.Play( "s0020_rtrg6030" )
end




this.Continue_gotoVillage = function()
	TppRadio.Play( "s0020_rtrg9010" )
end
this.Continue_searchIntel = function()
	TppRadio.Play( "s0020_rtrg9015" )
end

this.Continue_gotoSlopedTown = function()
	TppRadio.Play( "s0020_rtrg9020" )
end

this.Continue_rescueMirror = function()
	TppRadio.Play( "s0020_rtrg9030" )
end



this.ContinueTutorial_camof = function()
	TppRadio.Play( "s0020_rtrg9050" )
end

this.ContinueTutorial_dontMakeSound = function()
	TppRadio.Play( "s0020_rtrg9051" )
end

this.ContinueTutorial_lookYourMap = function()
	TppRadio.Play( "f1000_rtrg2760" )
end


this.NotNewIntel = function()
	TppRadio.Play( "f1000_rtrg1540" )
end






return this
