local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local this = BaseMissionSequence.CreateInstance( "s10060" )

this.requires = {
	"/Assets/ssd/level/mission/story/s10035/KaijuUtility.lua",
}


this.SKIP_SERVER_SAVE = true


this.sequences = {}




this.INITIAL_CAMERA_ROTATION = { 0, 84, }

local GIMMICK_DATASET_NAME = "/Assets/ssd/level/mission/story/s10060/s10060_item.fox2"
local BLADE_DATASET_NAME = "/Assets/ssd/level/mission/story/s10060/s10060_blade_gim.fox2"


this.disableBaseCheckPoint = true


this.DEFENSE_TARGET_GIMMICK_TABLE = {}

for upperLocatorName, locatorNameList in pairs( TppGimmick.ARCHAEAL_BLADE_TABLE ) do
	this.DEFENSE_TARGET_GIMMICK_TABLE[upperLocatorName] = {}
	for index, locatorName in pairs( locatorNameList ) do
		this.DEFENSE_TARGET_GIMMICK_TABLE[upperLocatorName][index] = locatorName
	end
end




this.releaseAnnounce = {
	"EnableBaseCampDefense",
	"OpenNewUnitDefense",
	"OpenNewCoopMission",
}



this.WAVE_LIST = Tpp.Enum{
	"wave_01",
	"wave_02",
	
	"wave_04",
}
















this.WAVE_PROPERTY_TABLE = {
	wave_01 = {
		defenseGameType = TppDefine.DEFENSE_GAME_TYPE.BASE,
		finishType = TppDefine.DEFENSE_FINISH_TYPE.WAVE,
		defenseTimeSec	= 1550, 
		limitTimeSec = 330,
		prepareTime = 300,
		intervalTimeSec = 90,
		intervalRadioGroups = { "f3010_rtrg2503", },
		startWaveRadioGroups = { "f3010_rtrg2502" },
		kaijuPierceLv= "PierceLv2",		
		defenseSpotName = "defenseUnit01_North",
		defenseSpotSpawnTimerSec = 20,
		defensePosition = { -330.3, 288.0, 2171.9, },
		defenseTargetGimmickProperty = {
			identificationTable = {
				archaealBlade01 = {
					gimmickId		= "GIM_P_SahelanBlade",
					name			= this.DEFENSE_TARGET_GIMMICK_TABLE[BLADE_DATASET_NAME][1],
					dataSetName		= BLADE_DATASET_NAME,
				},
				archaealBlade02 = {
					gimmickId		= "GIM_P_SahelanBlade",
					name			= this.DEFENSE_TARGET_GIMMICK_TABLE[BLADE_DATASET_NAME][2],
					dataSetName		= BLADE_DATASET_NAME,
				},
				archaealBlade03 = {
					gimmickId		= "GIM_P_SahelanBlade",
					name			= this.DEFENSE_TARGET_GIMMICK_TABLE[BLADE_DATASET_NAME][3],
					dataSetName		= BLADE_DATASET_NAME,
				},
				archaealBlade04 = {
					gimmickId		= "GIM_P_SahelanBlade",
					name			= this.DEFENSE_TARGET_GIMMICK_TABLE[BLADE_DATASET_NAME][4],
					dataSetName		= BLADE_DATASET_NAME,
				},
			},
			alertParameters = { needAlert = true, alertRadius = 15, }
		},
		forceBreakDefenseTargetGimmickName = "archaealBlade02",
	},
	wave_02 = {
		limitTimeSec = 615,
		intervalTimeSec = 90,
		intervalRadioGroups = { "f3010_rtrg2503", },
		startWaveRadioGroups = { "f3010_rtrg2504", },
		defenseSpotName = "defenseUnit03_South",
		defenseSpotSpawnTimerSec = 24,
		kaijuPierceLv= "PierceLv3",		
		defensePosition = { -363.6, 288.2, 2257.6, },
		forceBreakDefenseTargetGimmickName = "archaealBlade03",
	},
	wave_04 = {
		limitTimeSec = 400,
		intervalTimeSec = 90,
		startWaveRadioGroups = { "f3010_rtrg2506" },
		kaijuPierceLv= "PierceLv4",		
		defenseSpotName = "defenseUnit01_North02",
		defenseSpotSpawnTimerSec = 39,
		isTerminal = true,
		defensePosition = { -363.7, 287.3, 2194.6, },
		forceBreakDefenseTargetGimmickName = "archaealBlade01",
	},
}

if DEBUG then
	
	if false then
		for waveName, waveProperty in pairs( this.WAVE_PROPERTY_TABLE ) do
			if waveProperty.defenseSpotSpawnTimerSec then
				waveProperty.limitTimeSec = waveProperty.defenseSpotSpawnTimerSec + 10
			end
			waveProperty.intervalTimeSec = 20
		end
	end
end


this.DEFENSE_SPOT_MAX = 16


this.DEFENSE_SPOT_ENUM = Tpp.Enum{
	"defenseUnit01_North",
	"defenseUnit03_South",
	"defenseUnit01_East",	
	"defenseUnit01_North02",
}


if #this.DEFENSE_SPOT_ENUM > this.DEFENSE_SPOT_MAX then
	Fox.Error("s10060_sequence.DEFENSE_SPOT_ENUM is max count over. #this.DEFENSE_SPOT_ENUM = " .. tostring(#this.DEFENSE_SPOT_ENUM))
else
	Fox.Log("s10060_sequence: #this.DEFENSE_SPOT_ENUM = " .. tostring(#this.DEFENSE_SPOT_ENUM))
end


local MB_DOWN_NAVI_MAX_COUNT = 8






local defenseSpotGimmickTable = {
	defenseUnit01_North = {
		[TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE] = {
			
			"fen0_main8_def_gim_n0001|srt_fen0_main8_def",
			"fen0_main8_def_gim_n0000|srt_fen0_main8_def",
			"fen0_main8_def_gim_n0004|srt_fen0_main8_def",
			"fen0_main8_def_gim_n0005|srt_fen0_main8_def",
			"fen0_main8_def_gim_n0006|srt_fen0_main8_def",
			"fen0_main8_def_gim_n0007|srt_fen0_main8_def",

			
			"ssde_brrc001_vrtn004_gim_n0014|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0015|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0016|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0017|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0018|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0024|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0025|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0026|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0027|srt_ssde_brrc001_vrtn004",

			
			"ssde_brrc001_vrtn003_gim_n0014|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0012|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0013|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0016|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0015|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0036|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0037|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0038|srt_ssde_brrc001_vrtn003",

			
			"fen0_main9_def_gim_n0011|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0010|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0009|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0008|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0026|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0027|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0028|srt_fen0_main9_def",
		},
		[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN] = {
			"hw01_gim_n0003|srt_hw01_tpod0_def",
			"hw01_gim_n0006|srt_hw01_tpod0_def",
			"hw01_gim_n0007|srt_hw01_tpod0_def",
		},
		[TppGameObject.GAME_OBJECT_TYPE_MORTAR] = {
			"hw00_gim_n0000|srt_hw00_main0_def",
		},

	},
	defenseUnit03_South = {
		[TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE] = {
			
			"fen0_main9_def_gim_n0001|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0012|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0000|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0013|srt_fen0_main9_def",

			
			"ssde_brrc001_vrtn003_gim_n0017|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0007|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0003|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0005|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0006|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0004|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0039|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0040|srt_ssde_brrc001_vrtn003",

			
			
			"ssde_brrc001_vrtn004_gim_n0037|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0039|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0036|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0020|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0019|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0004|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0023|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0032|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0033|srt_ssde_brrc001_vrtn004",

			
			"ssde_brrc001_vrtn004_gim_n0040|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0028|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0035|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0001|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0005|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0000|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0022|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0030|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0031|srt_ssde_brrc001_vrtn004",

			
			"ssde_brrc001_vrtn004_gim_n0038|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0029|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0034|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0002|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0003|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0006|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0021|srt_ssde_brrc001_vrtn004",

			"ssde_flor001_fire001_gim_n0000|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0001|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0002|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0003|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0004|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0005|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0006|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0007|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0008|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0009|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0010|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0011|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0012|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0013|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0014|srt_ssde_flor001_fire001",
			"ssde_flor001_fire001_gim_n0015|srt_ssde_flor001_fire001",
		},
		[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN] = {
			"hw01_gim_n0002|srt_hw01_tpod0_def",
		},
		[TppGameObject.GAME_OBJECT_TYPE_MORTAR] = {
			"hw00_gim_n0001|srt_hw00_main0_def",
			"hw00_gim_n0002|srt_hw00_main0_def",
			"hw00_gim_n0003|srt_hw00_main0_def",
		},
	},
	defenseUnit01_East = {	
		[TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE] = {
			
			"fen0_main9_def_gim_n0002|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0003|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0004|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0007|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0005|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0006|srt_fen0_main9_def",

			
			"ssde_brrc001_vrtn004_gim_n0009|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0010|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0011|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0007|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0008|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0012|srt_ssde_brrc001_vrtn004",
			"ssde_brrc001_vrtn004_gim_n0013|srt_ssde_brrc001_vrtn004",

			"ssde_brrc001_vrtn002_gim_n0006|srt_ssde_brrc001_vrtn002",
			"ssde_brrc001_vrtn002_gim_n0007|srt_ssde_brrc001_vrtn002",
			"ssde_brrc001_vrtn002_gim_n0008|srt_ssde_brrc001_vrtn002",

			"ssde_brrc001_vrtn003_gim_n0009|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0010|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0011|srt_ssde_brrc001_vrtn003",

			"fen0_main8_def_gim_n0002|srt_fen0_main8_def",
			"fen0_main8_def_gim_n0003|srt_fen0_main8_def",
		},
		[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN] = {
			"hw01_gim_n0004|srt_hw01_tpod0_def",
		},
		[TppGameObject.GAME_OBJECT_TYPE_GATLINGGUN] = {
			"nad0_main0_def_gim_n0001|srt_nad0_main0_def",
		},
	},
	defenseUnit01_North02 = {
		[TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE] = {
			
			"fen0_main5_def_gim_n0011|srt_fen0_main5_def",
			"fen0_main5_def_gim_n0010|srt_fen0_main5_def",
			"fen0_main5_def_gim_n0009|srt_fen0_main5_def",
			"fen0_main5_def_gim_n0002|srt_fen0_main5_def",
			"fen0_main5_def_gim_n0003|srt_fen0_main5_def",
			"fen0_main5_def_gim_n0001|srt_fen0_main5_def",
			"fen0_main5_def_gim_n0000|srt_fen0_main5_def",
			
			"fen0_main9_def_gim_n0025|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0024|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0023|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0022|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0021|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0020|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0019|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0018|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0017|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0016|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0015|srt_fen0_main9_def",
			"fen0_main9_def_gim_n0014|srt_fen0_main9_def",

			
			
			"ssde_brrc001_vrtn003_gim_n0021|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0020|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0019|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0018|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0001|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0002|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0000|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0008|srt_ssde_brrc001_vrtn003",
			
			"ssde_brrc001_vrtn003_gim_n0042|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0041|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0027|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0026|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0023|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0024|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0022|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0025|srt_ssde_brrc001_vrtn003",
			
			"ssde_brrc001_vrtn003_gim_n0044|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0043|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0035|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0034|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0033|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0032|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0029|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0030|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0028|srt_ssde_brrc001_vrtn003",
			"ssde_brrc001_vrtn003_gim_n0031|srt_ssde_brrc001_vrtn003",
		},
		[TppGameObject.GAME_OBJECT_TYPE_MACHINEGUN] = {
			"hw01_gim_n0000|srt_hw01_tpod0_def",
			"hw01_gim_n0001|srt_hw01_tpod0_def",
			"hw01_gim_n0008|srt_hw01_tpod0_def",
			"hw01_gim_n0009|srt_hw01_tpod0_def",
		},
	},
}

local bladeAttackNameTable = {
	PierceLv2 = {
		{
			"com_blade_attack001_gim_n0000|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0001|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0002|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0003|srt_gim_blade_attack",
		},
	},
	PierceLv3 = {
		{
			"com_blade_attack001_gim_n0108|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0109|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0110|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0111|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0112|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0113|srt_gim_blade_attack",
		},
		{
			"com_blade_attack001_gim_n0114|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0115|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0116|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0117|srt_gim_blade_attack",
		},
	},
	PierceLv4 = {
		{
			"com_blade_attack001_gim_n0204|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0205|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0206|srt_gim_blade_attack",
			"com_blade_attack001_gim_n0207|srt_gim_blade_attack",
		},
	},
}



if DEBUG then
	local locatorNameRedundantCheckTable = {}
	for gameObjectType, locatorNameList in pairs( defenseSpotGimmickTable ) do
		for index, locatorName in pairs( locatorNameList ) do
			if locatorNameRedundantCheckTable[locatorName] then
				Fox.Error("defenseSpotGimmickTable has redundant locatorName. locatorName = " .. tostring(locatorName))
			end
			locatorNameRedundantCheckTable[locatorName] = true
		end
	end
end








this.sequenceList = {
	"Seq_Demo_StartMission",			
	"Seq_Game_Defense",					
	"Seq_Game_WaitCheckPointSave",		
	"Seq_Game_Selection",				
	"Seq_Demo_RailGun_Preparation",		
	"Seq_Game_Railgun",					
	"Seq_Demo_Defeat_Kaiju01",			
	"Seq_Demo_AI_Tell_Story1",			
	"Seq_Demo_BlackTelephone_AI",		
	"Seq_Demo_AI_Tell_Story2",			
	"Seq_Game_Selection2",				
	"Seq_Game_Railgun2",				
	"Seq_Demo_Defeat_Kaiju01_2",		
	"Seq_Demo_EndCredits01",			
	"Seq_Demo_Defeat_Kaiju02",			
	"Seq_Demo_EndCredits02",			
	"Seq_Demo_Epilogue",				
	"Seq_Demo_ShowMissionResult",		
	"Seq_Demo_Return01",				
	"Seq_Demo_LoadingWaitToReturn02",	
	"Seq_Demo_Return02",				
	"Seq_Demo_EndCreditsReturnEnd",		
	nil,
}





this.saveVarsList = {
	isDefenseUnitSpawned = { name = "isDefenseUnitSpawned", arraySize = this.DEFENSE_SPOT_MAX, type = TppScriptVars.TYPE_BOOL, value = false, save = false, category = TppScriptVars.CATEGORY_MISSION },
}







this.missionObjectiveDefine = {
	marker_ai = {
		gameObjectName = "marker_ai", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all",
	},
	marker_ai2 = {
		gameObjectName = "marker_ai", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all",
	},
	marker_startDefense = {
		gameObjectName = "marker_startDefense", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all",
	},
	marker_defenseUnit01_North = {
		gameObjectName = "marker_defenseUnit01_North", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", seEventName = "sfx_s_mb_reach_point",
	},
	marker_defenseUnit03_South = {
		gameObjectName = "marker_defenseUnit03_South", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", seEventName = "sfx_s_mb_reach_point",
	},
	marker_defenseUnit01_East = {
		gameObjectName = "marker_defenseUnit01_East", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", seEventName = "sfx_s_mb_reach_point",
	},
	marker_defenseUnit01_North02 = {
		gameObjectName = "marker_defenseUnit01_North02", visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", seEventName = "sfx_s_mb_reach_point",
	},
	start_railGunGame = {
	},
	start_railGunGame2 = {
	},
}

for i = 1, MB_DOWN_NAVI_MAX_COUNT do
	local objectiveName = string.format( "marker_navi%04d", i )
	this.missionObjectiveDefine[objectiveName] = {
		gameObjectName = objectiveName, visibleArea = 0, randomRange = 0, setNew = true, setImportant =true, goalType = "moving", viewType = "all", seEventName = "sfx_s_mb_reach_point",
	}
end












local naviObjectiveTree = {}

this.missionObjectiveTree = {
	start_railGunGame2 = {
		marker_ai2 = {
			start_railGunGame = {
				marker_ai = {
					marker_defenseUnit01_North02 = {
						marker_defenseUnit01_East = {
							marker_defenseUnit03_South = {
								marker_defenseUnit01_North = naviObjectiveTree,
							},
						},
					}
				},
			},
		},
	},
}

do
	local missionObjectiveTree = naviObjectiveTree
	for i = MB_DOWN_NAVI_MAX_COUNT, 1, -1 do
		local objectiveName = string.format( "marker_navi%04d", i )
		missionObjectiveTree[objectiveName] = {}
		missionObjectiveTree = missionObjectiveTree[objectiveName]
	end
	missionObjectiveTree["marker_startDefense"] = {}
end

local baseMissionObjetiveEnum = {
	"marker_defenseUnit01_North",
	"marker_defenseUnit03_South",
	"marker_defenseUnit01_East",
	"marker_defenseUnit01_North02",
	"marker_ai",
	"marker_startDefense",
	"start_railGunGame",
	"marker_ai2",
	"start_railGunGame2",
}

for i = 1, MB_DOWN_NAVI_MAX_COUNT do
	local objectiveName = string.format( "marker_navi%04d", i )
	baseMissionObjetiveEnum[#baseMissionObjetiveEnum+1] = objectiveName
end

this.missionObjectiveEnum = Tpp.Enum( baseMissionObjetiveEnum )

this.ELUDE_DOWN_CONTROLE_GUIDE_TRAP_LIST = { "trap_eludeDownControlGuide0001", "trap_eludeDownControlGuide0002" }





this.AfterMissionPrepare = function()
	Fox.Log( "10060_sequence.AfterMissionPrepare()" )

	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			TppDemo.ReserveInTheBackGround{ demoName =  "stay01" }	
			TppMission.MissionGameEnd{ fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED }
		end,
		OnDisappearGameEndAnnounceLog = function()
			TppSequence.SetNextSequence( "Seq_Demo_Defeat_Kaiju01_2", { isExecMissionClear = true } )
		end,
		OnEndMissionReward = function()
			
			SsdSaveSystem.SaveMissionEnd()
			TppMission.MissionFinalize{ isNoFade = true }
			TppPlayer.ResetInitialPosition()
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.s10060_OUT_OF_MISSION_AREA )
		end,
		OnGameOver = function()
			
			if TppMission.CheckGameOverDemo( TppDefine.GAME_OVER_TYPE.S10060_RETURN_END ) then
				TppSequence.SetNextSequence( "Seq_Demo_Return01", { isExecGameOver = true } )
				return true
			end
		end,
		nil
	}

	
	FogWallController.SetEnabled( false )
	
	TppSoundDaemon.SetKeepPhaseEnable( false )

	
	TppMission.RegisterWaveList( this.WAVE_LIST )
	TppMission.RegisterWavePropertyTable( this.WAVE_PROPERTY_TABLE )

	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )

	
	afgh_base.AddOnBaseActivatedCallBackFunction( this.OnBaseActivated )

	
	mvars.s10060_isEnterDefenseGameArea = {}

	if DebugMenu then
		mvars.qaDebug.s10060_skipWave = false
		DebugMenu.AddDebugMenu(" s10060", "skipWave", "bool", mvars.qaDebug, "s10060_skipWave")
		mvars.qaDebug.s10060_skipWaveInterval = false
		DebugMenu.AddDebugMenu(" s10060", "skipWaveInterval", "bool", mvars.qaDebug, "s10060_skipWaveInterval")
		mvars.qaDebug.s10060_finishDefenseGame = false
		DebugMenu.AddDebugMenu(" s10060", "finishDefenseGame", "bool", mvars.qaDebug, "s10060_finishDefenseGame")
	end
end

this.AfterOnRestoreSVars = function()
	Fox.Log( "s10060_sequence.AfterOnRestoreSVars()" )

	TppMission.SetInitialWaveName( "wave_01" )
	Mission.SetWaveCount( #this.WAVE_LIST )
	
	BlackRadio.ReadJsonParameter( "S10060_0010" )
	
	ScreenLifeGaugeSystem.RequestOpen()
	TppUiStatusManager.SetStatus("SsdUiCommon", "IS_KAIJU_WAR")

	
	if ( TppSequence.GetMissionStartSequenceIndex() >= TppSequence.GetSequenceIndex( "Seq_Game_WaitCheckPointSave" ) ) then
		for pierceLv, bladeAttackNameList in pairs( bladeAttackNameTable ) do
			this.StartSaheranBladeAttack( pierceLv, true )
		end
	end
end


this.AfterOnEndMissionPrepareSequence = function()
	
	TppClock.SetTime( "12:00:00" )	
	TppClock.Stop()	
	TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.0, { fogDensity = 0.0, } )

	this.PowerOffBaseBuildingTerminal()
	this.BaseBroadcasFacilityPowerSetting( true )	

	
	this.InitializeDefenseSpotGimmick()
	
	local pos, direction = Tpp.GetLocator( "ReturnEndActionIconIdentifier", "ReturnEndActionIconTrap" )
	Player.AddTrapDetailCondition{
		trapName = "trap_returnEnd",
		condition = PlayerTrap.FINE,
		action = (PlayerTrap.NORMAL + PlayerTrap.BEHIND),
		stance = (PlayerTrap.STAND + PlayerTrap.SQUAT),
		direction = direction,
		directionRange = 180,
	}
	
	for index, trapName in ipairs(this.ELUDE_DOWN_CONTROLE_GUIDE_TRAP_LIST) do
		Player.AddTrapDetailCondition{
			trapName = trapName,
			action = PlayerTrap.ELUDE,
			direction = 0,
			directionRange = 180,
		}
	end

	
	if ( TppSequence.GetMissionStartSequenceIndex() >= TppSequence.GetSequenceIndex( "Seq_Game_Defense" ) ) then
		this.SetDisableChris()
	end
	
	if ( TppSequence.GetMissionStartSequenceIndex() >= TppSequence.GetSequenceIndex( "Seq_Game_Selection" ) ) then
		this.SetUniqCrewDemoEndPosition()
	end

end




this.OnBaseActivated = function()
	Fox.Log( "s10060_sequence.OnBaseActivated()" )
	local playingDemoIdList = DemoDaemon.GetPlayingDemoId()
	if Tpp.IsTypeTable( playingDemoIdList ) then
		if DEBUG then
			Tpp.DEBUG_DumpTable( playingDemoIdList )
		end
		local hideRailgunDemoId = {
			p50_000041 = true,
			p50_000042 = true,
			p50_000050 = true,
			p50_000051 = true,
			p50_000030 = true,
			p50_000031 = true,
		}
		local demoId = playingDemoIdList[1]
		if not demoId  then
			Fox.Error( "s10060_sequence.OnBaseActivated() : demoId is nil" )
			return
		end
		if hideRailgunDemoId[demoId] then
			this.SetRailgunVisibility( false )
		end
	end
end




this.AddOnTerminateFunction(
	function()
		Fox.Log( "s10060_sequence.AfterOnTerminate()" )
		
		ScreenLifeGaugeSystem.Close()
		TppUiStatusManager.UnsetStatus("SsdUiCommon", "IS_KAIJU_WAR")
		SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.DISABLE_OPEN_AI_MENU )
		TppEffectUtility.SetSsdMistWallVisibility(true)		
		FogWallController.SetEnabled( true )
		TppDataUtility.SetVisibleEffectFromGroupId( "afgh_common_effect_FxLocatorGroup_MB", true )
		
		TppSoundDaemon.SetKeepPhaseEnable( false )
		this.BaseBroadcasFacilityPowerSetting( false )	
		
		TppEnding.Stop()
		
		SubtitlesCommand.SetIsEnabledUiPrioStrong( false )
		TppGameStatus.Reset( "s10060","S_ENABLE_TUTORIAL_PAUSE" )	
		
		if mvars.s10060_ShowEpilogueWork then
			TppSoundDaemon.PostEventAndGetHandle( "Stop_p50_000080", "Title" )	
			TppEnding.EndEndingBlackRadio()
		end
	end
)






function this.SetRailgunVisibility( visibility )
	Fox.Log( "s10060_sequence.SetRailgunVisibility : visibility = "  .. tostring(visibility) )

	Gimmick.InvisibleGimmick(
		TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		"mgs0_gim_n0000|srt_mgs0_main0_ssd_v00",
		"/Assets/ssd/level/mission/story/s10060/s10060_mgs_gim.fox2",
		( not visibility )
	)

end



function this.SetAffectsDemoAssetVisibility( visibility )
	TppGimmick.SetArchaealBladeVisibility( visibility )
	this.SetRailgunVisibility( visibility )
	TppDataUtility.SetVisibleEffectFromGroupId( "ReturnEndWormhole", visibility )
	TppDataUtility.SetVisibleDataFromIdentifier( "ParasiteSpikeIdentifier", "Group_ParasiteSpike", visibility )
end


function this.SetAffectsDemoAssetVisibilityOnDemoStart( visibility )
	this.SetAffectsDemoAssetVisibility( false )
end

function this.GoNextSequence( self, option )
	if not self then
		Fox.Error("s10065_sequence.GoNextSequence : self is nil." .. " Called  from " .. Tpp.DEBUG_Where(2) )
		return
	end
	if self.nextSequence then
		TppSequence.SetNextSequence( self.nextSequence, option )
	else
		Fox.Error("s10065_sequence.GoNextSequence : self.nextSequence is nil."  .. " Called  from " .. Tpp.DEBUG_Where(2) )
		return
	end
end


function this.InitializeDefenseSpotGimmick()
	for spotName, spotGimmickTable in pairs(defenseSpotGimmickTable) do
		for gimmickType, gimmickList in pairs(spotGimmickTable) do
			for i = 1, #gimmickList do
				local locatorName = gimmickList[i]
				Gimmick.InvisibleGimmick(
					gimmickType,
					locatorName,
					GIMMICK_DATASET_NAME,
					true
				)
			end
		end
	end
end

local gimmickSpawnOption = { needSpawnEffect = true, }	


function this.SpawnDefenseSpotGimmick( spotName )
	local spotGimmickTable = defenseSpotGimmickTable[spotName]
	if not spotGimmickTable then
		Fox.Error("SpawnDefenseSpotGimmick : Invalid spotName. spotName = " .. tostring(spotName) )
		return
	end
	local spotIndex = this.DEFENSE_SPOT_ENUM[spotName]
	if spotIndex then
		spotIndex = spotIndex - 1
	else
		Fox.Error("SpawnDefenseSpotGimmick : Cannot find spotName from this.DEFENSE_SPOT_ENUM. spotName = " .. tostring(spotName) )
		return
	end
	if not svars.isDefenseUnitSpawned[spotIndex] then
		local delayTimeCount = 0, 14.0
		local isAnyGimmickSpawned = false
		for gimmickType, gimmickList in pairs(spotGimmickTable) do
			for i = 1, #gimmickList do
				delayTimeCount = delayTimeCount + 1
				gimmickSpawnOption.spawnDelayTime = delayTimeCount * 0.09	
				isAnyGimmickSpawned = true
				local locatorName = gimmickList[i]
				Gimmick.ResetGimmick(
					gimmickType,
					locatorName,
					GIMMICK_DATASET_NAME,
					gimmickSpawnOption
				)
				
			end
		end

		svars.isDefenseUnitSpawned[spotIndex] = true
	else
		Fox.Log("SpawnDefenseSpotGimmick : already spawned. spotName = " .. tostring(spotName) )
	end
end


function this.SpawnAllDefenseSpotGimmick()
	for index, spotName in ipairs( this.DEFENSE_SPOT_ENUM ) do
		this.SpawnDefenseSpotGimmick( spotName )
	end
end


function this.BreakDefenseSpotGimmick( spotName )
	local spotGimmickTable = defenseSpotGimmickTable[spotName]
	if not spotGimmickTable then
		Fox.Error("BreakDefenseSpotGimmick : Invalid spotName. spotName = " .. tostring(spotName) )
		return
	end
	local spotIndex = this.DEFENSE_SPOT_ENUM[spotName]
	if spotIndex then
		spotIndex = spotIndex - 1
	else
		Fox.Error("BreakDefenseSpotGimmick : Cannot find spotName from this.DEFENSE_SPOT_ENUM. spotName = " .. tostring(spotName) )
		return
	end
	for gimmickType, gimmickList in pairs(spotGimmickTable) do
		for i = 1, #gimmickList do
			local locatorName = gimmickList[i]
			Gimmick.BreakGimmick(
				gimmickType,
				locatorName,
				GIMMICK_DATASET_NAME,
				false
			)
			
		end
	end
end


function this.PowerOffBaseAI()
	Gimmick.SetSsdPowerOff{
		gimmickId		= "GIM_P_AI",
		name			= "com_ai001_gim_n0000|srt_aip0_main0_def",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
		powerOff		= true,
	}
end


function this.PowerOffBaseFastTravelPoint()
	Gimmick.SetSsdPowerOff{
		gimmickId		= "GIM_P_Portal",
		name			= "com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_small/129/129_150/afgh_129_150_gimmick.fox2",
		powerOff		= true,
	}
end


function this.PowerOffBaseSkillTrainer()
	Gimmick.SetSsdPowerOff{
		gimmickId		= "GIM_P_AI_Skill",
		name			= "com_ai002_gim_n0000|srt_pup0_main0_ssd_v00",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
		powerOff		= true,
	}
end


function this.PowerOffBaseBuildingTerminal()
	Gimmick.SetSsdPowerOff{
		gimmickId		= "GIM_P_AI_Building",
		name			= "com_ai003_gim_n0000|srt_ssde_swtc001",
		dataSetName		= "/Assets/ssd/level/location/afgh/block_common/afgh_common_asset_base.fox2",
		powerOff		= true,
	}
end


function this.BaseBroadcasFacilityPowerSetting( powerOff )
	local centerPos = Vector3( -443.267, 288.906, 2240.07 )	
	local distance, pos, gameObjectId = Gimmick.SearchNearestSsdGimmick{
		pos = centerPos,
		gimmickId = "GIM_P_RadioBox",
		heavySearch = true,
		onlyBuilding = true,
		searchRadius = 120,
	}
	
	if not gameObjectId then
		return
	end
	Fox.Log("s10060_sequence.BaseBroadcasFacilityPowerSetting : powerOff = " .. tostring(powerOff) .. ", gameObjectId = " .. tostring(gameObjectId) .. ", distance = " .. tostring(distance))
















	Gimmick.SetSsdPowerOff{
		gameObjectId = gameObjectId,
		powerOff = powerOff,
	}
end


function this.SetSilentBreakSummonedDefenseUnit()
	local translation, rotQuat = Tpp.GetLocatorByTransform( "DemoStartPositionIdentifier", "InvisibleSummonGimmickRadius" )
	Gimmick.AreaBreak{
		pos = translation,
		radius = 300,
		onlyEquip = true,
		silentBreak = true,
	}
end






this.DEFENSE_TARGET_POS = {
	["dnw0_gim_n0000|srt_dnw0_main0_def_v00"] = Vector3( -363.7, 287.3, 2194.6 ),
	["dnw0_gim_n0001|srt_dnw0_main0_def_v00"] = Vector3( -330.3, 288.0, 2171.9 ),
	["dnw0_gim_n0002|srt_dnw0_main0_def_v00"] = Vector3( -363.6, 288.2, 2257.6 ),
	["dnw0_gim_n0003|srt_dnw0_main0_def_v00"] = Vector3( -325.1, 291.5, 2285.3 ),
}

this.DEFENSE_TARGET_GAMEOVER_CAMERA_ROTATION = {
	["dnw0_gim_n0000|srt_dnw0_main0_def_v00"] = Quat.RotationY( foxmath.DegreeToRadian( -180 ) ),
	["dnw0_gim_n0001|srt_dnw0_main0_def_v00"] = Quat.RotationY( foxmath.DegreeToRadian( -90 ) ),
	["dnw0_gim_n0002|srt_dnw0_main0_def_v00"] = Quat.RotationY( foxmath.DegreeToRadian( 20 ) ),
	["dnw0_gim_n0003|srt_dnw0_main0_def_v00"] = Quat.RotationY( foxmath.DegreeToRadian( 0 ) ),
}

function this.ReserveDefenseTargetBrokenCamera( gameObjectId )
	local defenseTargetGameObjectIdList, gameObjectIdToLocatorNameTable = this.GetDefenseTargetGameObjectIdList()
	local locatorName = gameObjectIdToLocatorNameTable[gameObjectId]
	if not locatorName then
		Fox.Error("s10060_sequence.StartDefenseTargetBrokenCamera : gameObjectId is not defense target. gameObjectId = " .. tostring(gameObjectId))
		return
	end
	local defenseTargetBrokenCameraInfo = {}
	defenseTargetBrokenCameraInfo.gimmickPosition = this.DEFENSE_TARGET_POS[locatorName]
	defenseTargetBrokenCameraInfo.cameraRotation = this.DEFENSE_TARGET_GAMEOVER_CAMERA_ROTATION[locatorName]
	if ( not defenseTargetBrokenCameraInfo.gimmickPosition )
	or ( not defenseTargetBrokenCameraInfo.cameraRotation ) then
		Fox.Error("s10060_sequence.StartDefenseTargetBrokenCamera : locatorName is invalid. locatorName = " .. tostring(locatorName))
		return
	end
	defenseTargetBrokenCameraInfo.cameraDistance = 7.42 

	TppPlayer.ReserveDefenseTargetBrokenCamera( defenseTargetBrokenCameraInfo )
end

function this.CanReturnEndSequence()
	local currentSequenceIndex = TppSequence.GetCurrentSequenceIndex()
	if ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Defense" ) )
	or ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Selection" ) )
	or ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Selection2" ) ) then
		return true
	else
		return false
	end
end




function this.SetUpMissionObjectiveInfo()
	MissionObjectiveInfoSystem.Clear()	
	local currentSequenceIndex = TppSequence.GetCurrentSequenceIndex()
	if ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Defense" ) ) then
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_10060_objective_01", }
	elseif
	(
		( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Selection" ) )
		or ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Selection2" ) )
	) then
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_10060_objective_09", }
	elseif
	(
		( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Railgun" ) )
		or ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Railgun2" ) )
		or ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Demo_Defeat_Kaiju01_2" ) )
	) then
		MissionObjectiveInfoSystem.SetParam{ index = 0, langId = "mission_10060_objective_10", }
	end
	MissionObjectiveInfoSystem.Open()	
	MissionObjectiveInfoSystem.SetForceOpen(true)
end


function this.SetDisableChris()
	local gameObjectId = GameObject.GetGameObjectId( "SsdCrew", "uniq_boy" )
	GameObject.SendCommand( gameObjectId, { id = "SetEnabled", enabled = false } )
end


function this.SetUniqCrewDemoEndPosition()
	local uniqCreqNameList = {
		"uniq_mlt",
		"uniq_nrs",
		"uniq_plc",
		"uniq_eng",
	}
	for index, crewName in ipairs( uniqCreqNameList ) do
		local pos, rotY = this.GetUniqCrewDemoEndPosition( crewName )
		if pos then
			local gameObjectId = GameObject.GetGameObjectId( "SsdCrew", crewName )
			GameObject.SendCommand( gameObjectId, { id="Warp", pos = pos, rotY = rotY } )
		end
	end
end

function this.GetUniqCrewDemoEndPosition( crewName )
	local enable, translation, rotQuat = DemoDaemon.GetEndPosition( "p50_000041", crewName )	
	if not enable then
		Fox.Error("s10060_sequence.GetUniqCrewDemoEndPosition : Cannot get demo end position. crewName = " .. tostring(crewName))
		return
	end
	return TppMath.Vector3toTable(translation) , Tpp.GetRotationY( rotQuat )
end

function this.SetSequenceDemoAffectBladeAttackVisibility( self, visibility )
	if not Tpp.IsTypeTable( self ) then
		Fox.Error("s10060_sequence.SetSequenceDemoAffectBladeAttackVisibility: self must be table.")
		return
	end
	if not Tpp.IsTypeTable( self.demoAffectBladeAttackList ) then
		Fox.Error("s10060_sequence.SetSequenceDemoAffectBladeAttackVisibility: self(sequence) must have demoAffectBladeAttackList table.")
		return
	end
	for _, gimmickName in ipairs( self.demoAffectBladeAttackList ) do
		Fox.Log("s10060_sequence.SetSequenceDemoAffectBladeAttackVisibility: gimmickName = " .. tostring(gimmickName) .. ", visibility = " .. tostring(visibility) )
		Gimmick.InvisibleModel{
			gimmickId = "GIM_P_SahelanBladeAttack",
			name = gimmickName,
			dataSetName = "/Assets/ssd/level/mission/story/s10060/s10060_item.fox2",
			isInvisible = ( not visibility ),
		}
	end
end


local defenseGameAreaTrapList = {
	{ "trap_defenseGameArea_Unit01East", "trap_alertDefenseGameArea_Unit01East" },
	{ "trap_defenseGameArea_Unit03South", "trap_alertDefenseGameArea_Unit03South" },
	{ "trap_defenseGameArea_Unit01North02", "trap_alertDefenseGameArea_Unit01North02" },
}




this.messageTable = this.AddMessage(
	this.messageTable,
	{
		Player = {
			{	
				msg = "OnPressedWormholeActionIcon",
				func = function()
					TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.S10060_RETURN_END, TppDefine.GAME_OVER_RADIO.s10060_OUT_OF_MISSION_AREA )
				end,
			},
		},
		Trap = {
			{
				sender = "trap_returnEnd",
				msg = "Enter",
				func = function()
					if this.CanReturnEndSequence() then
						Player.RequestToShowIcon{
							type = ActionIcon.ACTION,
							icon = ActionIcon.WORMHOLE_RETURN,
							longPress = true,
							longPressTime = 4.0,
							message = Fox.StrCode32("OnPressedWormholeActionIcon"),
						}
					end
				end,
			},
			{
				sender = "trap_returnEnd",
				msg = "Exit",
				func = function()
					Player.RequestToHideIcon{
						type = ActionIcon.ACTION,
						icon = ActionIcon.WORMHOLE_RETURN,
					}
				end,
			},
		},
		Timer = {
			{
				sender = "Timer_PermitPlayAlretRadio",
				msg = "Finish",
				func = function()
					mvars.s10060_isClosePlayedAlertRadio = nil
				end,
			},
		},
	}
)

function this.PlayRadioOnUpdateObjective( objectiveName, radioGroupName )
	if ( not TppMission.IsEnableMissionObjective( objectiveName ) )
	and ( not TppMission.IsEnableAnyParentMissionObjective( objectiveName ) ) then
		TppRadio.Play( radioGroupName )
	end
end



do
	local maxNaviMarkerName = string.format( "marker_navi%04d", MB_DOWN_NAVI_MAX_COUNT )
	for i = 1, MB_DOWN_NAVI_MAX_COUNT do
		local trapName = string.format( "trap_navi%04d", i )
		local objectiveName = string.format( "marker_navi%04d", i + 1 )
		this.messageTable = this.AddMessage(
			this.messageTable,
			{
				Trap = {
					{
						sender = trapName,
						msg = "Enter",
						func = function( trapName, gameObjectId )
							if ( TppSequence.GetCurrentSequenceIndex() == TppSequence.GetSequenceIndex( "Seq_Game_Defense" ) ) then
								if ( i == MB_DOWN_NAVI_MAX_COUNT ) then
									this.PlayRadioOnUpdateObjective( "marker_defenseUnit01_North", "f3010_rtrg2500" )
									TppMission.UpdateObjective{ objectives = { "marker_defenseUnit01_North" }, }
								else
									if ( i == 5 ) then 
										this.PlayRadioOnUpdateObjective( objectiveName, "f3010_rtrg2499" )
									end
									TppMission.UpdateObjective{	objectives = { objectiveName, }, }
								end
							end
						end,
					},
				},
			}
		)
	end
end

function this.ForceBreakDefenseTarget( waveIndex )
	local defenseTargetGimmickIdentifierTable = this.WAVE_PROPERTY_TABLE.wave_01.defenseTargetGimmickProperty.identificationTable
	local waveName = TppMission.GetCurrentWaveName()
	if not waveName then
		Fox.Error("Wave", "ForceBreakAndGameOver. Cannot get waveName = " .. tostring(waveName) )
		return
	end
	local waveProperty = TppMission.GetWaveProperty( waveName )
	if not waveProperty then
		Fox.Error("Wave", "ForceBreakAndGameOver. Cannot get waveProperty. waveName = " .. tostring(waveName) )
		return
	end
	local forceBreakDefenseTargetGimmickName = waveProperty.forceBreakDefenseTargetGimmickName
	if not forceBreakDefenseTargetGimmickName then
		Fox.Error("Wave", "ForceBreakAndGameOver. Cannot get forceBreakDefenseTargetGimmickName. waveName = " .. tostring(waveName) )
		return
	end
	local gimmickIdentifier = defenseTargetGimmickIdentifierTable[ forceBreakDefenseTargetGimmickName ]
	Gimmick.BreakGimmick(
		TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		gimmickIdentifier.name,
		BLADE_DATASET_NAME,
		false
	)
end


function this.CheckIsEnterDefenseArea()
	local currentWaveIndex = TppMission.GetCurrentWaveIndex()
	if ( not mvars.s10060_isEnterDefenseGameArea[currentWaveIndex] ) then
		this.ForceBreakDefenseTarget( currentWaveIndex )
	end
end


function this.IsDefenseGameSequence()
	local currentSequenceIndex = TppSequence.GetCurrentSequenceIndex()
	if ( currentSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Defense" ) ) then
		return true
	else
		return false
	end
end


function this.IsPlayingDefenseGameState()
	if ( Mission.GetDefenseGameState() == TppDefine.DEFENSE_GAME_STATE.NONE )	
	or ( Mission.GetDefenseGameState() == TppDefine.DEFENSE_GAME_STATE.PREPARE )	
	or mvars.s10060_isDefenseGameFinished then	
		return false
	else
		return true
	end
end


do
	local trapMessageTable = { Trap = {} }
	for trapWaveIndex, trapNameList in ipairs( defenseGameAreaTrapList ) do
		local areaTrap, alertTrap = trapNameList[1], trapNameList[2]
		table.insert(
			trapMessageTable.Trap,
			{
				sender = areaTrap,
				msg = "Enter",
				func = function( trapName, gameObjectId )
					Fox.Log("Wave", "enterDefenseGameArea : trapWaveIndex = " .. tostring(trapWaveIndex))
					mvars.s10060_isEnterDefenseGameArea[trapWaveIndex] = true
				end,
				options = { isExecMissionPrepare = true, isExecFastTravel = true, isExecDemoPlaying = true, },
			}
		)
		table.insert(
			trapMessageTable.Trap,
			{
				sender = areaTrap,
				msg = "Exit",
				func = function( trapName, gameObjectId )
					Fox.Log("Wave", "exitDefenseGameArea : trapWaveIndex = " .. tostring(trapWaveIndex))
					mvars.s10060_isEnterDefenseGameArea[trapWaveIndex] = false

					if ( not this.IsDefenseGameSequence() )
					or ( not this.IsPlayingDefenseGameState() ) then
						return
					end

					local currentWaveIndex = TppMission.GetCurrentWaveIndex()
					if ( currentWaveIndex == trapWaveIndex ) then
						this.ForceBreakDefenseTarget( currentWaveIndex )
					end
				end,
				options = { isExecMissionPrepare = true, isExecFastTravel = true, isExecDemoPlaying = true, },
			}
		)
		table.insert(
			trapMessageTable.Trap,
			{
				sender = alertTrap,
				msg = "Exit",
				func = function( trapName, gameObjectId )

					if ( not this.IsDefenseGameSequence() )
					or ( not this.IsPlayingDefenseGameState() ) then
						return
					end

					if ( TppMission.GetCurrentWaveIndex() == trapWaveIndex ) then
						this.PlayAlertOutOfMissionAreaRadio()
					end
				end,
				options = { isExecMissionPrepare = true, isExecFastTravel = true, isExecDemoPlaying = true, },
			}
		)
	end

	this.messageTable = this.AddMessage(
		this.messageTable,
		trapMessageTable
	)
end


function this.PlayAlertOutOfMissionAreaRadio()
	if not mvars.s10060_isClosePlayedAlertRadio then
		TppRadio.Play( "f3000_rtrg0114" )
		mvars.s10060_isClosePlayedAlertRadio = true

		local timerName = "Timer_PermitPlayAlretRadio"
		if GkEventTimerManager.IsTimerActive( timerName ) then
			GkEventTimerManager.Stop(timerName)
		end
		GkEventTimerManager.Start( timerName, 10 )
	end
end






this.sequences.Seq_Demo_StartMission = {
	OnEnter = function( self )
		KaijuUtility.SetUpBySequence( self.kaijuParams )
		this.SetSilentBreakSummonedDefenseUnit()
		s10060_demo.PlayStartMission{
			onStart = function()
				afgh_base.SetDiggerVisibility( false )
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
				this.SetRailgunVisibility( true )	
			end,
			onEnd = function() this.GoNextSequence( self ) end,
		}
	end,

	kaijuParams = {
		rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
	},

	nextSequence = "Seq_Game_Defense",

	OnLeave = function ()
		afgh_base.SetDiggerVisibility( true )
	end,
}






this.StartDefenseSpotSpawnTimer = function( waveName )
	if not waveName then
		Fox.Error("waveName is nil.")
		return
	end
	local defenseSpotSpawnTimerSec = this.WAVE_PROPERTY_TABLE[waveName].defenseSpotSpawnTimerSec

	local timerName = "Timer_SpawnDefenseSpotGimmick"
	if GkEventTimerManager.IsTimerActive( timerName ) then
		GkEventTimerManager.Stop(timerName)
	end
	GkEventTimerManager.Start( timerName, defenseSpotSpawnTimerSec )

	local radioTimerName = "Timer_PlaySpawnDefenseSpotGimmickRadio"
	local radioDelayTime = defenseSpotSpawnTimerSec - 4.2
	if GkEventTimerManager.IsTimerActive( radioTimerName ) then
		GkEventTimerManager.Stop(radioTimerName)
	end
	GkEventTimerManager.Start( radioTimerName, radioDelayTime )
end

this.OnTimerDefenseSpotTrap = function()
	local waveName = TppMission.GetCurrentWaveName()
	if not waveName then
		Fox.Error("waveName is nil.")
		return
	end
	local defenseSpotName = this.WAVE_PROPERTY_TABLE[waveName].defenseSpotName
	this.SpawnDefenseSpotGimmick( defenseSpotName )
end


this.StartSaheranBladeAttack = function( pierceLv, isStartImmediately )
	local bladeAttackNameList = bladeAttackNameTable[pierceLv]
	if not bladeAttackNameList then
		Fox.Error("Cannot find bladeAttackNameList from bladeAttackNameTable. pierceLv = " .. tostring(pierceLv))
		return
	end
	local kaijuPierceDelayTime = 0

	for line = 1, #bladeAttackNameList do
		local _bladeAttackNameList = bladeAttackNameList[line]
		local startDelayTime = 4.0
		for i = 1, #_bladeAttackNameList do
			local gimmickName = _bladeAttackNameList[i]
			startDelayTime = startDelayTime + 0.35
			if isStartImmediately then
				startDelayTime = 0.0
			end
			Gimmick.SetAction{
				gimmickId = "GIM_P_SahelanBladeAttack",
				name = gimmickName,
				dataSetName = "/Assets/ssd/level/mission/story/s10060/s10060_item.fox2",
				action = "Start",
				param1 = startDelayTime,
			}
			
		end
		if kaijuPierceDelayTime < startDelayTime then
			kaijuPierceDelayTime = startDelayTime
		end
	end

	kaijuPierceDelayTime  = kaijuPierceDelayTime + 0.35

	mvars.s10060_kaijuPierceLv = pierceLv
	GkEventTimerManager.Start( "Timer_SetKaijuPierceLv", kaijuPierceDelayTime )
end


this.SetSaheranBladeAttackVisibility = function( visibility )
	Fox.Log("s10060_sequence.SetSaheranBladeAttackVisibility : visibility = " .. tostring( visibility ) )
	for pierceLv, bladeAttackNameList in pairs( bladeAttackNameTable ) do
		for line = 1, #bladeAttackNameList do
			local _bladeAttackNameList = bladeAttackNameList[line]
			for i = 1, #_bladeAttackNameList do
				local gimmickName = _bladeAttackNameList[i]
				Gimmick.InvisibleModel{
					gimmickId = "GIM_P_SahelanBladeAttack",
					name = gimmickName,
					dataSetName = "/Assets/ssd/level/mission/story/s10060/s10060_item.fox2",
					isInvisible = ( not visibility ),
				}
			end
		end
	end
end


this.ExecuteKaijuPierce = function()
	if mvars.s10060_kaijuPierceLv then
		Fox.Log("s10060_sequence: ExecuteKaijuPierce : mvars.s10060_kaijuPierceLv = " .. tostring(mvars.s10060_kaijuPierceLv))
		KaijuUtility.SendCommand{
			id = "SetCommandAction",
			actionType = mvars.s10060_kaijuPierceLv,
		}
		mvars.s10060_kaijuPierceLv = nil
	end
end


this.OnFinishWave = function( waveName, waveIndex )
	local waveName = TppMission.GetCurrentWaveName()
	if not waveName then
		Fox.Error("Wave", "Seq_Game_Defense.OnFinishWave : Not defined wave name in this.WAVE_STRCODE_TO_NAME. waveNameStrCode = " .. tostring(waveNameStrCode) )
		return
	end
	local waveProperty = TppMission.GetWaveProperty( waveName )
	if not waveProperty then
		Fox.Error("Wave", "Seq_Game_Defense.OnFinishWave : Cannot get wave property = " .. tostring(waveName) )
		return
	end

	if waveProperty.kaijuPierceLv then
		this.StartSaheranBladeAttack( waveProperty.kaijuPierceLv )
	end

	this.BreakDefenseSpotGimmick( this.WAVE_PROPERTY_TABLE[waveName].defenseSpotName)

	
	if TppMission.IsTerminalWave( waveName ) then
		this.OnFinishTerminalWave()
		return
	end

	TppMission.StartWaveInterval{ useWaveProperty = true }

	local nextWaveName = TppMission.GetNextWaveName()
	if nextWaveName then
		local defenseSpotName = this.WAVE_PROPERTY_TABLE[nextWaveName].defenseSpotName
		local intervalRadioGroups
		if this.WAVE_PROPERTY_TABLE[nextWaveName].intervalRadioGroups then
			intervalRadioGroups = this.WAVE_PROPERTY_TABLE[nextWaveName].intervalRadioGroups
		end
		if intervalRadioGroups then
			TppRadio.Play( intervalRadioGroups, { delayTime = 6.0 } )
		end
		TppMission.UpdateObjective{
			objectives = { "marker_" .. tostring(defenseSpotName) },
		}
	end
end


this.OnFinishTerminalWave = function()
	Fox.Log("Wave", "Seq_Game_Defense.OnFinishWave : defense game finish!!!" )
	mvars.s10060_isDefenseGameFinished = true
	MissionObjectiveInfoSystem.Check{ langId = "mission_10060_objective_01", checked = true, }	
	TppEnemy.KillWaveEnemy{ effectName = "explosion_d50010", soundName = "sfx_s_waveend_plasma" }
	
	GameObject.SendCommand( { type="TppCommandPost2" }, { id = "ResetAllWaveEffect" } )
	TppMission.StopDefenseTotalTime()
	
	GkEventTimerManager.Start( "Timer_FinishDefenseGame", 10 )
	GkEventTimerManager.Start( "Timer_SetNextSceneBGM", 4 )
	TppRadio.Play( "f3000_rtrg1117", { delayTime = 2.0 } )
	TppMusicManager.PostJingleEvent2( "SingleShot", "DefenseResult" )
	TppMusicManager.StartSceneMode()
end


this.OnFinishWaveInterval = function()
	local waveName = TppMission.StartNextWave()
	this.StartDefenseSpotSpawnTimer( waveName )
	local defensePosition = this.WAVE_PROPERTY_TABLE[waveName].defensePosition
	TppMission.SetDefensePosition(defensePosition)
	local startWaveRadioGroups = this.WAVE_PROPERTY_TABLE[waveName].startWaveRadioGroups
	TppRadio.Play( startWaveRadioGroups )
	this.CheckIsEnterDefenseArea()
	if this.WAVE_PROPERTY_TABLE[waveName].isTerminal then
		GkEventTimerManager.Start( "Timer_PlayTerminalWaveAdditionalRadio", 15 )
	end
end





this.OnKaijuActionStart = {}

this.OnKaijuActionStart[StrCode32("AttackReady")] = function( gameObjectId, actionName, targetGameObjectId )
	if ( mvars.s10060_isDefenseTarget and mvars.s10060_isDefenseTarget[targetGameObjectId] ) then
		TppRadio.Play( "s0035_rtrg0050" )
	elseif ( Tpp.IsLocalPlayer(targetGameObjectId) ) then
		TppRadio.Play( "s0035_rtrg0050" )
	else
		
	end
end

this.OnKaijuActionStart[StrCode32("Attack")] = function( gameObjectId, actionName, targetGameObjectId )
	TppRadio.Play( "s0035_rtrg0055" )
end




local DEFENSE_TARGET_GIMMICK_ID = "GIM_P_SahelanBlade"


this.SetDefenseTargetDamageMessage = function()

	for dataSetName, locatorNameList in pairs(this.DEFENSE_TARGET_GIMMICK_TABLE) do
		for index, locatorName in pairs(locatorNameList) do
			
			local result = Gimmick.SetDamageMessage{
				gimmickId = DEFENSE_TARGET_GIMMICK_ID,
				name = locatorName,
				dataSetName = dataSetName,
				isOn = true,
			}
			
		end
	end
end


this.GetDefenseTargetGameObjectIdList = function()
	
	local defenseTargetGameObjectIdList = {}
	local gameObjectIdToLocatorNameTable = {}
	local locatorToGameObjectIdNameTable = {}
	local length = 1
	for dataSetName, locatorNameList in pairs(this.DEFENSE_TARGET_GIMMICK_TABLE) do
		for index, locatorName in pairs(locatorNameList) do
			local gameObjectId = Gimmick.SsdGetGameObjectId{
				gimmickId = DEFENSE_TARGET_GIMMICK_ID,
				name = locatorName,
				dataSetName = dataSetName,
			}
			
			defenseTargetGameObjectIdList[length] = gameObjectId
			gameObjectIdToLocatorNameTable[gameObjectId] = locatorName
			locatorToGameObjectIdNameTable[locatorName] = gameObjectId
			length = length + 1
		end
	end
	
	return defenseTargetGameObjectIdList, gameObjectIdToLocatorNameTable, locatorToGameObjectIdNameTable
end




local DEFENSE_TARGET_LOW_DURABILITY_THRESHOLD = 0.3	

this.sequences.Seq_Game_Defense = {
	Messages = function( self )
		
		local defenseTargetGameObjectIdList, gameObjectIdToLocatorNameTable, locatorToGameObjectIdNameTable = this.GetDefenseTargetGameObjectIdList()
		KaijuUtility.SetDefenseTarget( locatorToGameObjectIdNameTable )
		mvars.s10060_isDefenseTarget = gameObjectIdToLocatorNameTable
		return StrCode32Table{
			Timer = {
				{
					
					sender = "Timer_FinishDefenseGame",
					msg = "Finish",
					func = function()
						this.GoNextSequence( self )
					end,
				},
				{	
					sender = "Timer_PlayedOnDamageDefenseTargetRadio",
					msg = "Finish",
					func = function()
						mvars.s10060_isPlayedOnDamageDefenseTargetRadio = nil
					end,
				},
				{	
					sender = "Timer_PlayedOnBrokenNearDefenseTargetRadio",
					msg = "Finish",
					func = function()
						mvars.s10060_isPlayedOnBrokenNearDefenseTargetRadio = nil
					end,
				},
				{
					sender = "Timer_SetKaijuPierceLv",
					msg = "Finish",
					func = this.ExecuteKaijuPierce,
				},
				{
					sender = "Timer_SpawnDefenseSpotGimmick",
					msg = "Finish",
					func = this.OnTimerDefenseSpotTrap,
				},
				{
					sender = "Timer_PlaySpawnDefenseSpotGimmickRadio",
					msg = "Finish",
					func = function()
						TppRadio.Play( "f3010_rtrg2508" )	
					end,
				},
				{
					sender = "Timer_PlayTerminalWaveAdditionalRadio",
					msg = "Finish",
					func = function()
						Fox.Log("Approaching new enemy!!!!")
					end,
				},
				{
					sender = "Timer_SetNextSceneBGM",
					msg = "Finish",
					func = function()
						TppSound.SetSceneBGM( "selection01" )
					end,
				},
			},
			GameObject = {
				{
					msg = "FinishPrepareTimer",
					func = function()
						self.StartInitialWaveOnMessage( self )
					end,
				},
				{
					msg = "FinishWave",
					func = this.OnFinishWave,
				},
				{
					msg = "FinishWaveInterval",
					func = this.OnFinishWaveInterval,
				},
				{	
					msg = "ActionStart",
					sender = "kij_0000",
					func = function( gameObjectId, actionName, arg3 )
						local onActionStart = this.OnKaijuActionStart[actionName]
						if onActionStart then
							onActionStart( gameObjectId, actionName, arg3 )
						end
					end,
				},
				{	
					msg = "BreakGimmick",
					func = function( gameObjectId, locatorName, upperLocatorName, on )
						
						if TppGimmick.IsArchaealBlade( locatorName ) then
							this.ReserveDefenseTargetBrokenCamera( gameObjectId )
							TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.DEFENSE_TARGET_WAS_DESTROYED, TppDefine.GAME_OVER_RADIO.S10020_TARGET_KILL )
						end
					end,
				},
				{
					
					msg = "Damage",
					sender = defenseTargetGameObjectIdList,
					func = function ( gameObjectId, attackId, attackerId )
						local durability = Gimmick.GetDurability{ gameObjectId = gameObjectId }
						if durability > DEFENSE_TARGET_LOW_DURABILITY_THRESHOLD then
							if not mvars.s10060_isPlayedOnDamageDefenseTargetRadio then
								mvars.s10060_isPlayedOnDamageDefenseTargetRadio = true
								TppRadio.Play( "f3010_rtrg2510" )	
								GkEventTimerManager.Start( "Timer_PlayedOnDamageDefenseTargetRadio", 60 )
							end
						else
							if not mvars.s10060_isPlayedOnBrokenNearDefenseTargetRadio then
								mvars.s10060_isPlayedOnBrokenNearDefenseTargetRadio = true
								TppRadio.Play( "f3010_rtrg2512" )	
								GkEventTimerManager.Start( "Timer_PlayedOnBrokenNearDefenseTargetRadio", 60 )
							end
						end
					end
				},
			},
			Trap = {
				{	
					sender = "trap_defenseUnit01_North",
					msg = "Enter",
					func = function( trap )
						self.StartInitialWaveOnMessage( self )
					end,
				},
				{	
					sender = this.ELUDE_DOWN_CONTROLE_GUIDE_TRAP_LIST,
					msg = "Enter",
					func = function()
						TppUI.ShowControlGuide{
							time = 4.0,
							actionName = "ELUDE_DOWN",	
						}
					end,
				},
				{
					sender = "trap_baseDefenseGameArea",
					msg = "Exit",
					func = function( trap )
						TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.s10060_OUT_OF_MISSION_AREA )
					end,
				},
				{
					sender = "trap_baseDefenseGameAlertArea",
					msg = "Exit",
					func = function( trap )
						this.PlayAlertOutOfMissionAreaRadio()
					end,
				},
			},
		}
	end,

	OnEnter = function( self )
		KaijuUtility.EnableDefenseGameAI()
		this.SetAffectsDemoAssetVisibility( true )
		this.PowerOffBaseFastTravelPoint()
		s10060_radio.PlayDefense()	
		TppMission.UpdateObjective{ objectives = { "marker_navi0001" }, }
		this.SetUpMissionObjectiveInfo()
		KaijuUtility.SetUpBySequence( self.kaijuParams )
		this.SetDisableChris()
		
		mvars.s10060_isEnterDefenseGameArea[1] = false
		mvars.s10060_isEnterDefenseGameArea[2] = true
		mvars.s10060_isEnterDefenseGameArea[3] = true
		mvars.s10060_isDefenseGameFinished = false
		mvars.s10060_isClosePlayedAlertRadio = nil
		self.StartDefenseGame( self )
	end,

	
	StartDefenseGame = function( self )
		Fox.Log("s10060_sequence: Start parasite blade unit defense game")
		this.SetDefenseTargetDamageMessage()
		local waveName = "wave_01"
		local waveProperty = TppMission.GetWaveProperty( waveName )
		local defenseTimeSec = waveProperty.defenseTimeSec
		local alertTimeSec = waveProperty.alertTimeSec
		local defenseGameType = waveProperty.defenseGameType
		local effectName = waveProperty.endEffectName or "explosion"
		local finishType = waveProperty.finishType
		local prepareTime = waveProperty.prepareTime
		local options = {
			shockWaveEffect=effectName,
			finishType = finishType,
			prepareTime = prepareTime,
			prepareTimerLangId = "timer_info_s10060_01",	
			waveTimerLangId = "timer_info_s10060_02",		
			intervalTimerLangId = "timer_info_s10060_01",	
			showWaveTimer = false,
		}
		TppMission.StartDefenseGame( defenseTimeSec, alertTimeSec, defenseGameType, options )

		
		local targetList = TppGimmick.MakeDefenseTargetListFromWaveProperty( waveProperty.defenseTargetGimmickProperty )
		TppGimmick.SetDefenseTargetWithList( targetList, true )	
		TppGimmick.RegisterActivatedDefenseTargetList( targetList )
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0, { fogDensity = 0.0015, } )

		
		TppEnemy.EnableWaveSpawnPointEffect( waveName )

		
		SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = { "guidelines_mission_10060_04", "guidelines_mission_10060_01" } }

		GameObject.SendCommand( { type="SsdZombieShell" },  { id = "IgnoreVerticalShot", ignore=true } )

		TppMission.SetDiggerLifeBreakSetting{
			breakPoints = { 0.75, 0.5, 0.25 },
			radius = 6.0,
		}
	end,

	StartInitialWaveOnMessage = function( self )
		if not mvars.s10060_isDefenseGameStarted then
			mvars.s10060_isDefenseGameStarted = true
			self.StartInitialWave( self )
		end
	end,

	StartInitialWave = function( self )
		this.CheckIsEnterDefenseArea()
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0, { fogDensity = 0.0035, } )

		local waveName = TppMission.GetCurrentWaveName()
		local defenseSpotName = this.WAVE_PROPERTY_TABLE[waveName].defenseSpotName
		TppMission.UpdateObjective{ objectives = { "marker_" .. tostring(defenseSpotName) }, }
		local defensePosition = this.WAVE_PROPERTY_TABLE[waveName].defensePosition
		TppMission.SetDefensePosition(defensePosition)

		local waveProperty = TppMission.GetWaveProperty( waveName )
		
		if waveProperty.enemyLaneRouteList then
			TppEnemy.SetVisibleEnemyLane( waveProperty.enemyLaneRouteList )
		end

		local startWaveRadioGroups = waveProperty.startWaveRadioGroups
		TppRadio.Play( startWaveRadioGroups )

		
		local waveStartName = TppMission.GetCurrentWaveName()
		TppEnemy.StartWave( waveStartName, true, startWaveOptions )

		this.StartDefenseSpotSpawnTimer( waveName )
	end,

	CheckPointSaveForEndDefense = function( self )
		
		TppMission.VarSaveOnUpdateCheckPoint()
		
		SsdSaveSystem.SaveCheckPoint()
	end,

	kaijuParams = {
		rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
		setSpecialState = { stateType = "PierceLv1", isEnable = true, }
	},

	nextSequence = "Seq_Game_WaitCheckPointSave",

	OnUpdate = function( self )
		if DebugText then
			
			local waveName = TppMission.GetCurrentWaveName()
			if waveName then
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "Current wave = " .. tostring(waveName) )
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "isEnterDefenseGameArea[1] = " .. tostring(mvars.s10060_isEnterDefenseGameArea[1]) )
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "isEnterDefenseGameArea[2] = " .. tostring(mvars.s10060_isEnterDefenseGameArea[2]) )
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "isEnterDefenseGameArea[3] = " .. tostring(mvars.s10060_isEnterDefenseGameArea[3]) )
			end

			if DebugMenu then
				if mvars.qaDebug.s10060_skipWave then
					GkEventTimerManager.StopAll()
					this.OnFinishWave()
					mvars.qaDebug.s10060_skipWave = false
				end

				if mvars.qaDebug.s10060_skipWaveInterval then
					GkEventTimerManager.StopAll()
					this.OnFinishWaveInterval()
					mvars.qaDebug.s10060_skipWaveInterval = false
				end

				if mvars.qaDebug.s10060_finishDefenseGame then
					GkEventTimerManager.StopAll()
					TppMission.StopDefenseGame()
					mvars.qaDebug.s10060_finishDefenseGame = false
				end
			end
		end
	end,

	OnLeave = function ( self, nextSequenceName )
		KaijuUtility.DisableDefenseGameAI()
		
		GameObject.SendCommand( { type="SsdZombieShell" },  { id = "IgnoreVerticalShot", ignore=false } )
		
		TppMission.OnClearDefenseGame()
		TppMission.StopDefenseGame()

		
		if ( nextSequenceName == "Seq_Game_WaitCheckPointSave" ) then
			SsdCrewSystem.UnregisterCrew{uniqueId="uniq_boy"}	
			self.CheckPointSaveForEndDefense( self )
		end
	end,
}


this.sequences.Seq_Game_WaitCheckPointSave = {
	OnEnter = function( self )
	end,

	OnUpdate = function( self )
		
		TppUI.ShowAccessIconContinue()

		
		if TppSave.IsSaving() then
			return
		end

		this.GoNextSequence( self )
	end,


	nextSequence = "Seq_Game_Selection",

	OnLeave = function ()
	end,
}


function this.CreateGameSelectionSequence( currentSequenceName, nextSequenceName, missionObjectiveName )
	return {
		Messages = function( self )
			return StrCode32Table{
				UI = {
					{
						msg = "EndFadeOut", sender = "GoToRailgunPreparation",
						func = function()
							TppSequence.SetNextSequence( nextSequenceName )
						end,
					},
				},
				Trap = {
					{
						sender = "trap_ai",
						msg = "Enter",
						func = function()
							MissionObjectiveInfoSystem.Check{ langId = "mission_10060_objective_09", checked = true, }	
							
							Player.RequestToSetTargetStance(PlayerStance.STAND) 
							local translation, rotQuat = Tpp.GetLocatorByTransform( "DemoStartPositionIdentifier", "RailgunPreparation" )
							local direction = Tpp.GetRotationY( rotQuat )
							Player.RequestToMoveToPosition{
								name = "s10060_DemoStartMoveToPosition",
								position = translation,
								direction = direction,
								moveType = PlayerMoveType.WALK,
								onlyInterpPosition = false,
								timeout = TppUI.FADE_SPEED.FADE_NORMALSPEED,
							}
							TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "GoToRailgunPreparation" )
						end,
					},
					{
						sender = "trap_baseDefenseGameArea",
						msg = "Exit",
						func = function( trap )
							TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.s10060_OUT_OF_MISSION_AREA )
						end,
					},
					{
						sender = "trap_baseDefenseGameAlertArea",
						msg = "Exit",
						func = function( trap )
							this.PlayAlertOutOfMissionAreaRadio()
						end,
					},
				},
			}
		end,

		OnEnter = function( self )
			this.SetAffectsDemoAssetVisibility( true )
			this.SetUpMissionObjectiveInfo()
			this.PowerOffBaseFastTravelPoint()
			this.PowerOffBaseSkillTrainer()
			this.PowerOffBaseAI()
			this.SetDisableChris()
			TppSoundDaemon.SetKeepPhaseEnable( true )
			TppMission.UpdateObjective{ objectives = { missionObjectiveName, }, }


			local kaijuParams = self.kaijuParams[currentSequenceName]
			if kaijuParams then
				KaijuUtility.SetUpBySequence( kaijuParams )
			else
				Fox.Error("Cannot get kaijuParams. Inavalid sequenceName. currentSequenceName = " .. tostring(currentSequenceName) )
			end

			TppUI.SetDefenseGameMenu()
			TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0, { fogDensity = 0.0005, } )
			mvars.s10060_isClosePlayedAlertRadio = nil
			TppDataUtility.SetVisibleEffectFromGroupId( "ReturnEndStartPosition", true ) 

			if ( currentSequenceName == "Seq_Game_Selection" ) then
				TppRadio.Play( "f3010_rtrg2513", { delayTime = 2.0 } )
			end

			if ( currentSequenceName == "Seq_Game_Selection" ) then
				SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = { "guidelines_mission_10060_04", "guidelines_mission_10060_02" } }
			else
				SsdBehaviorGuidelinesParameterTable.SetMainMissionGuidelines{ guidelineIDs = { "guidelines_mission_10060_04", "guidelines_mission_10060_03" } }
			end

			local sceneBGMLabel = self.sceneBGMLabelTable[currentSequenceName]
			if not TppSound.IsPlayingSceneBGM( sceneBGMLabel ) then
				TppSound.SetSceneBGM( sceneBGMLabel )
			else
				Fox.Log("Already playing sceneBGM. currentSequenceName = " .. tostring(currentSequenceName) .. ", sceneBGMLabel = " .. tostring(sceneBGMLabel) )
			end
		end,

		kaijuParams = {
			Seq_Game_Selection = {
				rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
				setSpecialState = { stateType = "PierceLv4", isEnable = true, },
			},
			Seq_Game_Selection2 = {
				rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
				setSpecialState = { stateType = "RailGun2", isEnable = true, },
				setSpecialState2 = { stateType = "PierceLv4", isEnable = true, },
			},
		},

		sceneBGMLabelTable = {
			Seq_Game_Selection = "selection01",
			Seq_Game_Selection2 = "selection02",
		},

		OnLeave = function ( self, nextSequenceName )
			
			if not ( nextSequenceName == "Seq_Game_Railgun2" ) then
				TppSound.StopSceneBGM()
			end
		end,

	}
end


this.sequences.Seq_Game_Selection = this.CreateGameSelectionSequence( "Seq_Game_Selection", "Seq_Demo_RailGun_Preparation", "marker_ai" )

function this.SetPlayerToRailgunEventMode()
	Fox.Log("s100060_sequence.SetPlayerToRailgunEventMode")
	GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetRailgunEventMode", enable = true } )
end

function this.CreateRailGunPreparationSequence( currentSequenceName, nextSequenceName )
	return {
		OnEnter = function( self )

			s10060_demo.PlayRailGunPreparation{
				onStart = function()
					this.SetSilentBreakSummonedDefenseUnit()
					this.SetAffectsDemoAssetVisibilityOnDemoStart()
					TppGimmick.SetArchaealBladeVisibility( true )
				end,
				onEnd = function() this.GoNextSequence( self ) end,
			}
		end,

		nextSequence = nextSequenceName,

		OnLeave = function ()
		end,
	}
end


this.sequences.Seq_Demo_RailGun_Preparation = this.CreateRailGunPreparationSequence( "Seq_Demo_RailGun_Preparation", "Seq_Game_Railgun" )


this.weakPointBoneList = {
	Seq_Game_Railgun = {
		kij_0000 = {
			"SKL_101_TAIL",
			"SKL_102_TAIL",
			"SKL_103_TAIL",
		},
		kij_0001 = {
			"SKL_106_SPINE",
			"SKL_107_SPINE",
			"SKL_108_SPINE",
		}
	},
	Seq_Game_Railgun2 = {
		kij_0000 = {
			"SKL_170_SPINE",
			"SKL_171_SPINE",
		},
	},
}

function this.CreateGameRailgunSequence( currentSequenceName, nextSequenceName, missionObjectiveName )
	return {
		Messages = function( self )
			return StrCode32Table{
				UI = {
					{
						msg = "EndFadeOut", sender = "FinishRailGunGameFadeOut",
						func = function()
							if ( nextSequenceName == "Seq_Demo_Defeat_Kaiju01_2" ) then
								TppMission.ReserveMissionClear{
									missionClearType = TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,
									nextMissionId = 30010,
									resetPlayerPos = true,
								}
							else
								TppSequence.SetNextSequence( nextSequenceName )
							end
						end,
					},
				},
				GameObject = {
					{
						msg = "Damage",
						sender = { "kij_0000", "kij_0001", },
						func = function ( gameObjectId, attackId, attackerId, boneStrCode )
							if attackId == TppDamage.ATK_None then
								return
							end

							if self.IsWeakPoint( gameObjectId, boneStrCode ) then
								Fox.Log("Hit kaiju weak point!!!!")
								if not mvars.isFinishedShootRailigun then
									mvars.isFinishedShootRailigun = true
									TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "FinishRailGunGameFadeOut" )
								end
							else
								if ( currentSequenceName == "Seq_Game_Railgun" )
								and ( not mvars.isPlayedCautionRailgunReload ) then
									mvars.isPlayedCautionRailgunReload = true
									s10060_radio.PlayNotEffectiveDamageByRailGun()
								end
							end
						end
					},
				},
				Timer = {
					{
						
						sender = "Timer_PlayRadioWhileCharging",
						msg = "Finish",
						func = function()
							TppRadio.Play( "f3010_rtrg2552" )
						end,
					},
					{	
						sender = "Timer_PlayRadioAfterChargeForAWhile",
						msg = "Finish",
						func = function()
							TppRadio.Play( "f3010_rtrg2554" )
						end,
					},
				},
			}
		end,

		OnEnter = function( self )
			mvars.isFinishedShootRailigun = false
			mvars.isPlayedNotEffectiveDamageByRailGun = false
			mvars.isPlayedCautionRailgunReload = false

			
			TppUI.SetDefenseGameMenu()

			this.SetPlayerToRailgunEventMode()
			this.SetAffectsDemoAssetVisibility( true )
			this.SetUpMissionObjectiveInfo()
			this.SetDisableChris()
			this.SetSilentBreakSummonedDefenseUnit()

			TppMission.UpdateObjective{ objectives = { missionObjectiveName, }, }

			
			this.weakPointBoneTable = {}
			for gameObjectName, boneNameList in pairs(this.weakPointBoneList[currentSequenceName]) do
				local gameObjectId = GameObject.GetGameObjectId(gameObjectName)
				this.weakPointBoneTable[gameObjectId] = {}
				for index, boneName in ipairs(boneNameList) do
					this.weakPointBoneTable[gameObjectId][StrCode32(boneName)] = true
				end
			end

			
			Gimmick.SetAction{
				gimmickId = "GIM_P_SahelanRailGun",
				name = "mgs0_gim_n0000|srt_mgs0_main0_ssd_v00",
				dataSetName = "/Assets/ssd/level/mission/story/s10060/s10060_mgs_gim.fox2",
				action = "ActiveIdle",
			}
			
			local sceneBGMLabel = self.sceneBGMLabelTable[currentSequenceName]
			TppSound.SetSceneBGM( sceneBGMLabel )
			TppSoundDaemon.SetKeepPhaseEnable( true )
			s10060_radio.PlayRailgun( currentSequenceName )

			
			TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.0, { fogDensity = 0.0025, } )

			local kaijuParams = self.kaijuParams[currentSequenceName]
			if kaijuParams then
				KaijuUtility.SetUpBySequence( kaijuParams )
			else
				Fox.Error("Cannot get kaijuParams. Inavalid sequenceName. currentSequenceName = " .. tostring(currentSequenceName) )
			end

			
			if ( currentSequenceName == "Seq_Game_Railgun2" ) then
				GkEventTimerManager.Start( "Timer_PlayRadioWhileCharging", 18 )
				GkEventTimerManager.Start( "Timer_PlayRadioAfterChargeForAWhile", 50 )
			end

			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "StartRailgunFadeIn" )
		end,

		IsWeakPoint = function ( gameObjectId, boneStrCode )
			if not this.weakPointBoneTable then
				Fox.Error("this.weakPointBoneTable is not initialized.")
				return
			end
			if not this.weakPointBoneTable[gameObjectId] then
				Fox.Error("gameObjectId is not kaiju.")
				return
			end
			if this.weakPointBoneTable[gameObjectId][boneStrCode] then
				return true
			else
				return false
			end
		end,

		kaijuParams = {
			Seq_Game_Railgun = {
				rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
				setSpecialState = { stateType = "RailGun", isEnable = true, },
				setSpecialState2 = { stateType = "PierceLv4", isEnable = true, },
			},
			Seq_Game_Railgun2 = {
				rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
				setSpecialState = { stateType = "RailGun2", isEnable = true, },
				setSpecialState2 = { stateType = "PierceLv4", isEnable = true, },
			},
		},

		sceneBGMLabelTable = {
			Seq_Game_Railgun = "railGunGame",
			Seq_Game_Railgun2 = "railGunGame2",
		},

		OnLeave = function ()
			
			Gimmick.SetAction{
				gimmickId = "GIM_P_SahelanRailGun",
				name = "mgs0_gim_n0000|srt_mgs0_main0_ssd_v00",
				dataSetName = "/Assets/ssd/level/mission/story/s10060/s10060_mgs_gim.fox2",
				action = "Idle",
			}
			TppSound.StopSceneBGM()
			GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="SetRailgunEventMode", enable = false } )

			
			for _, timerName in ipairs{ "Timer_PlayRadioWhileCharging", "Timer_PlayRadioAfterChargeForAWhile" } do
				if GkEventTimerManager.IsTimerActive( timerName ) then
					GkEventTimerManager.Stop( timerName )
				end
			end
		end,
	}
end


this.sequences.Seq_Game_Railgun = this.CreateGameRailgunSequence( "Seq_Game_Railgun", "Seq_Demo_Defeat_Kaiju01", "start_railGunGame" )


this.sequences.Seq_Demo_Defeat_Kaiju01 = {
	OnEnter = function( self )
		this.SetUpMissionObjectiveInfo()
		s10060_demo.PlayDefeatKaiju01{
			onStart = function()
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
				KaijuUtility.DisableMaterialControlInDemo()
				self:SetDemoAffectBladeAttackVisibility( false )
			end,
			onEnd = function()
				self:SetDemoAffectBladeAttackVisibility( true )
				this.GoNextSequence( self, { isExecMissionClear = true, } )
			end,
		}
	end,

	
	demoAffectBladeAttackList = { "com_blade_attack001_gim_n0112|srt_gim_blade_attack", "com_blade_attack001_gim_n0113|srt_gim_blade_attack" },

	SetDemoAffectBladeAttackVisibility = this.SetSequenceDemoAffectBladeAttackVisibility,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{
					msg = "p50_000050_StartEndRoll",
					func = function()
						TppEnding.Start("main_staff_credit")
					end,
					option = { isExecMissionClear = true, isExecDemoPlaying = true },
				},
				{
					msg = "KaijuDefeat",
					func = function()
						MissionObjectiveInfoSystem.Check{ langId = "mission_10060_objective_10", checked = true, }	
					end,
					option = { isExecMissionClear = true, isExecDemoPlaying = true },
				},
			},
		}
	end,

	OnLeave = function ()
		TppEnding.Stop()
	end,

	nextSequence = "Seq_Demo_AI_Tell_Story1",	
}


this.sequences.Seq_Demo_AI_Tell_Story1 = {
	OnEnter = function( self )
		KaijuUtility.SetUpBySequence( self.kaijuParams )
		s10060_demo.PlayAI_Tell_Story1{
			onStart = function()
				afgh_base.SetAiVisibility( false )
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
				this.SetRailgunVisibility( true )	
				TppGimmick.SetArchaealBladeVisibility( true )
				KaijuUtility.DisableMaterialControlInDemo()
				TppDataUtility.SetVisibleEffectFromGroupId( "ReturnEndStartPosition", false ) 
				self:SetDemoAffectBladeAttackVisibility( false )
			end,
			onEnd = function()
				self:SetDemoAffectBladeAttackVisibility( true )
				this.GoNextSequence( self )
			end,
		}
	end,

	
	demoAffectBladeAttackList = { "com_blade_attack001_gim_n0117|srt_gim_blade_attack" },

	SetDemoAffectBladeAttackVisibility = this.SetSequenceDemoAffectBladeAttackVisibility,

	kaijuParams = {
		rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true,  isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
		setSpecialState = { stateType = "PierceLv4", isEnable = true, },
	},

	nextSequence = "Seq_Demo_BlackTelephone_AI",

	OnLeave = function ()
	end,
}


this.sequences.Seq_Demo_BlackTelephone_AI = {

	Messages = function( self )
		return StrCode32Table {
			UI = {
				{
					
					msg = "BlackRadioClosed",
					
					func = function( blackRadioId )
						Fox.Log( "BlackRadioClosed: blackRadioId:" .. tostring( blackRadioId ) )
						this.GoNextSequence( self )
					end
				},
			},
		}
	end,

	OnEnter = function( self )
		TppRadio.StartBlackRadio()
	end,

	nextSequence = "Seq_Demo_AI_Tell_Story2",

	OnLeave = function ()
	end,
}


this.sequences.Seq_Demo_AI_Tell_Story2 = {
	OnEnter = function( self )
		TppMusicManager.StartSceneMode()
		KaijuUtility.SetUpBySequence( self.kaijuParams )
		TppDemo.SpecifyIgnoreNpcDisable{ "kij_0000", "kij_0001", "kij_0002", "kij_0003" }
		TppSoundDaemon.SetKeepPhaseEnable( true )

		s10060_demo.PlayAI_Tell_Story2{
			onStart = function()
				afgh_base.SetAiVisibility( false )
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
				TppGimmick.SetArchaealBladeVisibility( true )
				KaijuUtility.DisableMaterialControlInDemo()
				TppDataUtility.SetVisibleEffectFromGroupId( "ReturnEndStartPosition", false ) 
			end,
			onEnd = function() this.GoNextSequence( self ) end,
		}
	end,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{
					msg = "p50_000041_gameModelOn",
					option = { isExecDemoPlaying = true, },
					func = function()
						this.SetAffectsDemoAssetVisibility( true )
						KaijuUtility.SetUpBySequence{
							rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
							setSpecialState = { stateType = "RailGun2", isEnable = true, },
							setSpecialState2 = { stateType = "PierceLv4", isEnable = true, },
						}
					end,
				},
			},
		}
	end,

	kaijuParams = {
		rail = { "kaiju_rail_0000", startType = "Terminal", isOneArmed = true, isGroundIkOff = { [0] = true, [1] = true, [2] = false, [3] = false, }, },
		setSpecialState = { stateType = "PierceLv4", isEnable = true, },
	},

	nextSequence = "Seq_Game_Selection2",

	OnLeave = function ()
	end,
}


this.sequences.Seq_Game_Selection2 = this.CreateGameSelectionSequence( "Seq_Game_Selection2", "Seq_Game_Railgun2", "marker_ai2" )


this.sequences.Seq_Game_Railgun2 = this.CreateGameRailgunSequence( "Seq_Game_Railgun2", "Seq_Demo_Defeat_Kaiju01_2", "start_railGunGame2" )



this.sequences.Seq_Demo_Defeat_Kaiju01_2 = {
	OnEnter = function( self )
		this.SetUpMissionObjectiveInfo()
		s10060_demo.PlayStay01{
			onStart = function()
				self:SetDemoAffectBladeAttackVisibility( false )
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
				KaijuUtility.DisableMaterialControlInDemo()
			end,
			onEnd = function()
				self:SetDemoAffectBladeAttackVisibility( true )
				this.GoNextSequence( self, { isExecMissionClear = true, } )
			end,
		}
	end,

	
	demoAffectBladeAttackList = { "com_blade_attack001_gim_n0112|srt_gim_blade_attack", "com_blade_attack001_gim_n0113|srt_gim_blade_attack" },

	SetDemoAffectBladeAttackVisibility = this.SetSequenceDemoAffectBladeAttackVisibility,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{
					msg = "p50_000050_StartEndRoll",
					func = function()
						TppEnding.Start("main_staff_credit")
					end,
					option = { isExecMissionClear = true, isExecDemoPlaying = true },
				},
				{
					msg = "KaijuDefeat",
					func = function()
						MissionObjectiveInfoSystem.Check{ langId = "mission_10060_objective_10", checked = true, }	
					end,
					option = { isExecMissionClear = true, isExecDemoPlaying = true },
				},
			},
		}
	end,

	OnLeave = function ()
		TppEnding.Stop()
	end,

	nextSequence = "Seq_Demo_EndCredits01",
}



this.sequences.Seq_Demo_EndCredits01 = {
	OnEnter = function( self )
		TppDemo.ReserveInTheBackGround{ demoName =  "stay02" }	
		this.GoNextSequence( self, { isExecMissionClear = true, } )
	end,

	nextSequence = "Seq_Demo_Defeat_Kaiju02",
}


this.sequences.Seq_Demo_Defeat_Kaiju02 = {
	OnEnter = function( self )
		s10060_demo.PlayStay02{
			onStart = function()
				self:SetDemoAffectBladeAttackVisibility( false )
				TppDataUtility.SetVisibleEffectFromGroupId( "ReturnEndStartPosition", false ) 
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
				KaijuUtility.DisableMaterialControlInDemo()
			end,
			onEnd = function()
				self:SetDemoAffectBladeAttackVisibility( true )
				this.GoNextSequence( self, { isExecMissionClear = true, } )
			end,
		}
	end,

	
	demoAffectBladeAttackList = { "com_blade_attack001_gim_n0204|srt_gim_blade_attack", "com_blade_attack001_gim_n0205|srt_gim_blade_attack", "com_blade_attack001_gim_n0206|srt_gim_blade_attack" },

	SetDemoAffectBladeAttackVisibility = this.SetSequenceDemoAffectBladeAttackVisibility,

	nextSequence = "Seq_Demo_EndCredits02",
}


this.sequences.Seq_Demo_EndCredits02 = {
	OnEnter = function( self )
		Player.SetPause()
		TppSoundDaemon.SetMute( 'Outro' )	
		TppEnding.Start("defeat_end_staff_roll")
	end,

	Messages = function( self )
		return StrCode32Table{
			UI = {
				{
					msg = "TppEndingFinish",
					func = function()
						this.GoNextSequence( self, { isExecMissionClear = true, } )
					end,
					option = { isExecMissionClear = true, },
				},
			},
		}
	end,

	nextSequence = "Seq_Demo_Epilogue",
}


this.sequences.Seq_Demo_Epilogue = {
	OnEnter = function( self )
		
		TppSoundDaemon.SetMute( "Result" )
		SubtitlesCommand.SetIsEnabledUiPrioStrong( true )
		TppGameStatus.Set( "s10060","S_ENABLE_TUTORIAL_PAUSE" )
		TppEnding.StartEndingBlackRadio()

		mvars.s10060_ShowEpilogueWork = {
			playVoiceEventName = "Play_p50_000080",
			stopVoiceEventName = "Stop_p50_000080",
			startTime = Time.GetRawElapsedTimeSinceStartUp(),
			canSkipTime = 1.0,
			
			closeStartTime = 0.0,
			closingTime = 4.0,
		}
		self.showEpilogueCoroutine = coroutine.create(self.ShowEpilogue)
	end,

	ShowEpilogue = function()
		Fox.Log( "Seq_Demo_Epilogue.ShowEpilogue" )
		local function DebugPrintState(state)
			if DebugText then
				DebugText.Print(DebugText.NewContext(), tostring(state))
			end
		end

		local function ElapsedTime()
			local elapsedTime = ( Time.GetRawElapsedTimeSinceStartUp() - mvars.s10060_ShowEpilogueWork.startTime )
			DebugPrintState("Seq_Demo_Epilogue.ShowEpilogue: ElapsedTime = " .. tostring(elapsedTime) )
			return elapsedTime
		end

		local function IsEventPlaying()
			
			return TppSoundDaemon.IsEventPlaying( mvars.s10060_ShowEpilogueWork.playVoiceEventName, mvars.s10060_blackTelephoneHandle )
		end

		
		TppUiCommand.ShowTextureLogo( "/Assets/ssd/ui/texture/logo/epilogue_mainlogo_clp_nmp.ftex", 0.0, "full" )
		mvars.s10060_blackTelephoneHandle = TppSoundDaemon.PostEventAndGetHandle( mvars.s10060_ShowEpilogueWork.playVoiceEventName, "Loading" )

		
		while ( ElapsedTime() < mvars.s10060_ShowEpilogueWork.canSkipTime ) do
			DebugPrintState("Seq_Demo_Epilogue.ShowEpilogue: Wait can skip.")
			coroutine.yield()
		end

		
		Tpp.SetGameStatus{
			target = { "PauseMenu", },
			enable = false,
			scriptName = "s10060_sequence.lua",
		}

		
		while ( not mvars.s10060_ShowEpilogueWork.isSkiped )
		and ( IsEventPlaying() ) do
			DebugPrintState("Seq_Demo_Epilogue.ShowEpilogue: Now waiting fininish epilogue.")
			coroutine.yield()
		end

		
		mvars.s10060_ShowEpilogueWork.closeStartTime = Time.GetRawElapsedTimeSinceStartUp()
		TppUiStatusManager.SetStatus( "PauseMenu", "INVALID" )	
		TppUiCommand.HideTextureLogo()

		
		while ( ( Time.GetRawElapsedTimeSinceStartUp() - mvars.s10060_ShowEpilogueWork.closeStartTime ) < mvars.s10060_ShowEpilogueWork.closingTime ) do
			DebugPrintState("Seq_Demo_Epilogue.ShowEpilogue: Now waiting closing.")
			coroutine.yield()
		end

		return true
	end,

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "PauseMenuSkipTutorial",
					func = function()
						Fox.Log( "sequences.Seq_Demo_Epilogue.Messages(): UI: PauseMenuSkipTutorial" )
						mvars.s10060_ShowEpilogueWork.isSkiped = true
						TppSoundDaemon.PostEventAndGetHandle( mvars.s10060_ShowEpilogueWork.stopVoiceEventName, "Loading" )	
						TppUiStatusManager.SetStatus( "PauseMenu", "INVALID" )	
					end,
					option = { isExecMissionClear = true, },
				},
			},
			nil
		}
	end,

	OnUpdate = function( self )
		if self.showEpilogueCoroutine then
			local status, ret1 = coroutine.resume(self.showEpilogueCoroutine)
			
			if not status then
				this.GoNextSequence( self, { isExecMissionClear = true, } )
				return
			end
			
			if ( coroutine.status(self.showEpilogueCoroutine) == "dead" ) then
				this.GoNextSequence( self, { isExecMissionClear = true, } )
			end
		end
	end,

	nextSequence = "Seq_Demo_ShowMissionResult",

	OnLeave = function( self )
		Fox.Log( "sequences.Seq_Demo_Epilogue.OnLeave()" )
		self.showEpilogueCoroutine = nil
		mvars.s10060_ShowEpilogueWork = nil
		mvars.s10060_blackTelephoneHandle = nil
		SubtitlesCommand.SetIsEnabledUiPrioStrong( false )
		TppGameStatus.Reset( "s10060","S_ENABLE_TUTORIAL_PAUSE" )	
		TppEnding.EndEndingBlackRadio()
		this.IsEpilogueFinished = true
	end,
}


this.sequences.Seq_Demo_ShowMissionResult = {
	OnEnter = function( self )
		Fox.Log( "sequences.Seq_Demo_ShowMissionResult.OnEnter()" )
		
		if not TppGameSequence.IsMaster() then
			if not this.IsEpilogueFinished then
				Fox.Hungup("Unexpected invalid sequence change!!")
			end
		end
		TppMission.ShowMissionResult()
	end,
}


this.sequences.Seq_Demo_Return01 = {
	Messages = function( self )
		return StrCode32Table{
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutGoToReturnEnd",
					option = { isExecGameOver = true },
					func = function()
						s10060_demo.PlayReturn01{
							onStart = this.SetAffectsDemoAssetVisibilityOnDemoStart,
							onEnd = function()
								this.GoNextSequence( self, { isExecGameOver = true } )
							end,
						}
					end,
				},
			},
		}
	end,
	OnEnter = function( self )
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FadeOutGoToReturnEnd" )
	end,
	nextSequence = "Seq_Demo_LoadingWaitToReturn02",
}


this.sequences.Seq_Demo_LoadingWaitToReturn02 = {
	OnEnter = function( self )
		
		TppDemo.ReserveInTheBackGround{ demoName = "Return02" }
		
		local genderGearTable = self.PLAYER_DEMO_GEAR_TABLE[ vars.playerType ]
		if Tpp.IsTypeTable( genderGearTable ) then
			for gearType, modelId in pairs( genderGearTable ) do
				Gear.SetGear{ type = gearType, id = modelId, }
			end
		end
		Gear.SetGear{ type=GearType.INNER }	
		
		mvars.s10060_startWaitTime = 1.0
		mvars.s10060_isLoadedFlags = {
			isLoadedStageBlock = false,
			isLoadedPlayer = false,
		}
		mvars.s10060_timeOutCounter = {
			whole = 60,		
		}
		
		SsdSaveSystem.SaveForBadEnding()
	end,

	PLAYER_DEMO_GEAR_TABLE = {
		[ PlayerType.AVATAR_MALE ] = {
			[ GearType.HELMET ] = "hdm18_main0_v00",	
			[ GearType.UPPER_BODY ] = "uam3_main0_v00",	
			[ GearType.ARM ] = "arm17_main0_v00",	
			[ GearType.LOWER_BODY ] = "lgm4_main0_v00",	
		},
		[ PlayerType.AVATAR_FEMALE ] = {
			[ GearType.HELMET ] = "hdf18_main0_v00",	
			[ GearType.UPPER_BODY ] = "uaf3_main0_v00",	
			[ GearType.ARM ] = "arf17_main0_v00",	
			[ GearType.LOWER_BODY ] = "lgf4_main0_v00",	
		},
	},

	OnUpdate = function( self )
		
		TppUI.ShowAccessIconContinue()

		
		
		
		if not SsdSaveSystem.IsIdle() then
			if DebugText then
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "Waiting ServerSave." )
			end
			return
		end

		
		mvars.s10060_startWaitTime = mvars.s10060_startWaitTime - Time.GetFrameTime()
		if ( mvars.s10060_startWaitTime > 0 ) then
			if DebugText then
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "Waiting 1 second." )
			end
			return
		else
			mvars.s10060_startWaitTime = 0
		end

		local isAllLoaded = true
		
		mvars.s10060_timeOutCounter.whole = mvars.s10060_timeOutCounter.whole - Time.GetFrameTime()

		
		
		if gvars.exc_processingForDisconnect then
			if DebugText then
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "Waiting Exception." )
			end
			return
		end

		


		
		if Tpp.IsLoadedSmallBlock( 127, 146 ) then
			mvars.s10060_isLoadedFlags.isLoadedStageBlock = true
		end
		
		if PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE } then
			mvars.s10060_isLoadedFlags.isLoadedPlayer = true
		end
		


		
		for flagName, value in pairs( mvars.s10060_isLoadedFlags ) do
			isAllLoaded = isAllLoaded and value
		end
		
		if ( mvars.s10060_timeOutCounter.whole < 0 ) then
			Fox.Error("s10060_sequence.Seq_Demo_LoadingWaitToReturn02. Load wait timed out. Something's loading was not completed. Please check mvars.s10060_isLoadedFlags dump.")
			if DebugText then
				Tpp.DEBUG_DumpTable(mvars.s10060_isLoadedFlags)
			end
			isAllLoaded = true
		end

		if DebugText then
			DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "Now loading waiting for go to Seq_Demo_Return02." )
			for flagName, value in pairs( mvars.s10060_isLoadedFlags ) do
				DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, "       " .. flagName .. " = " .. tostring(value) )
			end
			DebugText.Print(DebugText.NewContext(), {0.5, 0.5, 1.0}, string.format( "Whole time out counter = %02.4f.", mvars.s10060_timeOutCounter.whole ) )
		end

		if isAllLoaded then
			this.GoNextSequence( self, { isExecGameOver = true } )
		end
	end,

	nextSequence = "Seq_Demo_Return02",

	OnLeave = function ()
	end,
}


function this.SetReturnEndDemoGimmickVisibility( visibility )
	
	Gimmick.InvisibleGimmick(
		TppGameObject.GAME_OBJECT_TYPE_IMPORTANT_BREAKABLE,
		"com_portal001_gim_n0000|srt_ftp0_main0_def_v00",
		"/Assets/ssd/level/location/afgh/block_small/129/129_145/afgh_129_145_gimmick.fox2",
		( not visibility )
	)
end


this.sequences.Seq_Demo_Return02 = {
	OnEnter = function( self )
		s10060_demo.PlayReturn02{
			onStart = function()
				TppTrophy.Unlock( 16 ) 
				SsdSbm.AddNamePlate( 58 ) 
				TppEffectUtility.SetSsdMistWallVisibility(false)	
				TppDataUtility.SetVisibleEffectFromGroupId( "ReturnEndStartPosition", false ) 
				TppDataUtility.SetVisibleEffectFromGroupId( "afgh_common_effect_FxLocatorGroup_MB", false ) 
				this.SetReturnEndDemoGimmickVisibility( false )
				this.SetAffectsDemoAssetVisibilityOnDemoStart()
			end,
			onEnd = function()
				this.SetReturnEndDemoGimmickVisibility( true )
				TppEffectUtility.SetSsdMistWallVisibility(true)		
				this.GoNextSequence( self, { isExecGameOver = true } )
			end,
		}
	end,

	nextSequence = "Seq_Demo_EndCreditsReturnEnd",
}


this.sequences.Seq_Demo_EndCreditsReturnEnd = {
	OnEnter = function( self )
		Player.SetPause()
		TppEnding.Start("return_end_staff_roll")
	end,

	Messages = function( self )
		return StrCode32Table{
			UI = {
				{
					msg = "TppEndingFinish",
					func = function()
						TppMission.AbortMission{
							nextMissionId = TppDefine.SYS_MISSION_ID.TITLE,
							isAlreadyGameOver = true,
							isTitleMode = true,
							isNoSurviveBox = true,	
						}
					end,
					option = { isExecGameOver = true },
				},
			},
		}
	end,
}




return this
