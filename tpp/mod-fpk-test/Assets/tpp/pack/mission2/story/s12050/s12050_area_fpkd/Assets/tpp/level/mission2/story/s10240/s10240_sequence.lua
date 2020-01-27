
--DEBUGNOW
return InfCore.PCall(function()
	InfCore.Log("---------------- s1200 sequence")--DEBUGNOW

local this = {}
local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table

local sequences = {}


this.NO_AQUIRE_GMP = true
this.NO_MISSION_CLEAR_RANK = true
this.NO_TACTICAL_TAKE_DOWN = true
this.NO_TAKE_HIT_COUNT = true
this.MISSION_START_INITIAL_WEATHER  = TppDefine.WEATHER.SUNNY
this.NO_PLAY_STYLE = true


function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences{
	--	"Seq_Demo_Opening",	
		"Seq_Game_Setup",
		"Seq_Game_MainGame",	

		nil
	}
	TppSequence.RegisterSequenceTable(sequences)
end






this.saveVarsList = {
	numEnemyDown	= 0,
	numEnemyDownSound = 0, 
	numKillEnemy	= 0, 
	isClear3F		= false,
	isClear2F		= false,
	isClear1F		= false,
	isClear0F		= false,
	isAllClear		= false,
	numBlackOut		= 0,		

	isDoEvent00		= 0, 
	isDoEvent01		= false, 
	isDoEvent12		= false, 
	isDoEvent20		= false, 
	isDoEvent24		= false,	
	isDead24		= false,	
	isDoEvent2rouka = false,	
	isDoEvent34		= false,	
	isDoEvent35		= false, 
	isDoEventB1Pre	= false,	
	isDoEventB1		= false,	
	isDoEventB2		= false,	
	isSayRadioRoof  = false,	
	numDoEventRoof	= 0,	
	numDoEventLast	= 0,	
	isDoEventSong	= false,	
	numEventB1Talk = 0,	
	numEvent2F3		= 0,
	isLook2F4Enemy	= false,
	numCheckDead		= 0, 
	
	isObieLoop01	= false,
	isObieLoop02	= false,
	isObieLoop03	= false,
	isObieLoop04	= false,
	isObieLoop05	= false,
	isObieLoop06	= false,
	isObieLoop07	= false,
	isObieLoop08	= false,
	isObieLoop09	= false,
	isObieLoop10	= false,
	isObieLoop11	= false,
	isObieLoop12	= false,

	isTalk01		= false,
	isTalk02		= false,
	isTalk03		= false,
	isTalk04		= false,	
	isTalk05		= false,
	isTalk06		= false,	
	isTalk07		= false,	
	isTalk08		= false,	
	isTalk09		= false,
	isTalk10		= false,
	isTalk11		= false,	
	isTalk12		= false,
	isTalk13		= false,	
	isTalk14		= false,	
	isTalk15		= false,	
	isTalk16		= false,	
	isTalk17		= false,
	isTalk18		= false, 
	isDebug			= 0,
	isTalk19		= false,
	isTalk20		= false,
	isTalk21		= false,

	isHoken03	= false, 
	isHoken04	= false, 
	isHoken05	= false, 
	isHoken06	= false, 
	isHoken07	= false, 
	isHoken08	= false, 
	isHoken09	= false, 

	
	deadCase05Num = TppMotherBaseManagementConst.REMOVER_REASON_GUNDOWN,
	deadCase06Num = TppMotherBaseManagementConst.REMOVER_REASON_GUNDOWN,
	deadCase07Num = TppMotherBaseManagementConst.REMOVER_REASON_GUNDOWN,
	deadCase10Num = TppMotherBaseManagementConst.REMOVER_REASON_GUNDOWN,
	deadCase19Num = TppMotherBaseManagementConst.REMOVER_REASON_GUNDOWN,

	isSwitchBGM02 = false,
	isSwitchBGM03 = false,
	
	isTalk22	= false,	
	nil
}




this.checkPointList = {
	"CHK_roof",
	"CHK_startBattle",
	"CHK_exit",
	"CHK_enter",
	"CHK_1fRouka",
	"CHK_2f3",
	"CHK_2f4",
	"CHK_2f",
	"CHK_B1",
	nil
}








this.missionObjectiveDefine = {
	
	marker_mbqf_enter = {
		gameObjectName = "default_area_door", visibleArea = 0, randomRange = 0, viewType="all",setNew = false, announceLog = "updateMap",
	},
	
	default_photo_mbqf = {
		photoId			= 10,
		subGoalId = 0,
		
	},

	
	default_photo_in_mbqf = {
		photoId			= 10,
		photoRadioName = "s0240_mirg0010",
		subGoalId = 0,
	},

	
	slaugher_photo_mbqf = {
		photoId			= 10,
		subGoalId = 1,
		announceLog = "updateMissionInfo",
	},

	
	marker_clear_exit = {
		gameObjectName = "marker_clear_exit", visibleArea = 0, randomRange = 0, viewType="all",setNew = false, announceLog = "updateMap",
		subGoalId = 2,
	},


	
	
	default_missionTask_00 = { missionTask = { taskNo = 0, isNew = true, isComplete = false, isFirstHide = false },},	
	clear_missionTask_00 = { missionTask = { taskNo = 0, isNew = true, isComplete = true },},	

	
	default_missionTask_01 = { missionTask = { taskNo = 1, isNew = true, isComplete = false, isFirstHide = true },},	
	open_missionTask_01 = { missionTask = { taskNo = 1, isNew = true, isComplete = false, isFirstHide = false },},	
	clear_missionTask_01 = { missionTask = { taskNo = 1, isNew = true, isComplete = true },},	

}

this.missionObjectiveTree = {
	marker_clear_exit = {
		slaugher_photo_mbqf = {
			default_photo_in_mbqf = {
				default_photo_mbqf = {},
				marker_mbqf_enter = {},
			},
		},
	},
	clear_missionTask_00 = {
		default_missionTask_00 = {},
	},
	clear_missionTask_01 = {
		open_missionTask_01 = {
			default_missionTask_01 = {},
		},
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"marker_mbqf_enter",
	"default_photo_mbqf",
	"marker_clear_exit",
	"default_photo_in_mbqf",
	"slaugher_photo_mbqf",
	
	"default_missionTask_00",
	"default_missionTask_01",
	"clear_missionTask_00",
	"clear_missionTask_01",
	"open_missionTask_01",
}












--DEBUGNOW

function this.MissionPrepare()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " MissionPrepare ***")

	
--	TppWeather.RequestWeather( TppDefine.WEATHER.SUNNY )
	
--	TppPlayer.RegisterTemporaryPlayerType{
 --		partsType = PlayerPartsType.NORMAL,
--		camoType = PlayerCamoType.OLIVEDRAB,
 --		playerType = PlayerType.SNAKE,
-- 		handEquip = TppEquip.EQP_HAND_NORMAL,
-- 		faceEquipId = 0,
-- 	}
	
--	TppScriptBlock.PreloadRequestOnMissionStart{
--		{ demo_block = "Demo_Opening" },
--	}

--	this.SetMbDvcMenu(false)

	
--	TppTerminal.StopChangeDayTerminalAnnounce()
		       
	TppMission.RegiserMissionSystemCallback{
		OnEndMissionReward = function(missionClearType)
			Fox.Log("onEnd reward")
			

--[[
			
			Player.UnsetEquip{
		        slotType = PlayerSlotType.ITEM,    
		        subIndex = 1,   
		        dropPrevEquip = false,  
			}
			this.StopSongEvent()

			
			TppMission.DisablePauseForShowResult()
			
			TppMission.Reload{
				
				missionPackLabelName = "out", 			
				locationCode = TppDefine.LOCATION_ID.MTBS, 		
				layoutCode	= TppDefine.OFFLINE_MOHTER_BASE_LAYOUT_CODE,
				clusterId	= 7,
				showLoadingTips = false,
				OnEndFadeOut = function()				
					local pos = {-163.605, 0.000, -2098.350}
					TppPlayer.SetInitialPosition(pos,0)
					TppUiStatusManager.SetStatus( "AnnounceLog","INVALID_LOG")
					TppSequence.ReserveNextSequence( "Seq_Demo_Funeral", { isExecMissionClear = true })
					TppMission.ReserveForcePlayerPositionToMbDemoCenter()
				end,
			}

--]]
			
		end,
	}
	
end





function this.OnRestoreSVars()
	local missionName = TppMission.GetMissionName()
	Fox.Log("*** " .. tostring(missionName) .. " OnRestoreSVars ***")

end




function this.OnEndMissionPrepareSequence()
	local nextSequence = TppSequence.GetSequenceIndex( TppSequence.GetMissionStartSequenceName() ) 

end


function this.OnTerminate()

	--DEBUGNOW
	TppEffectUtility.SetDirtyModelMemoryStrategy("Default")

end


function this.Messages()
	return
	StrCode32Table {
		nil
	}
end



sequences.Seq_Game_Setup = {
	OnEnter = function()

	end,
	OnUpdate = function()
			TppSequence.SetNextSequence("Seq_Game_MainGame")
	end,
	OnLeave = function()
			TppMain.EnableAllGameStatus()
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "OnEndGameStartFadeIn" )
	end,
}



sequences.Seq_Game_MainGame = {

	Messages = function( self ) 
		return
		StrCode32Table {
			nil
		}
	end,

	
	OnEnter = function()
	

		TppMission.UpdateObjective{
			objectives = { "default_photo_in_mbqf" },
		}
	
	end,

	OnLeave = function()
		TppMission.UpdateCheckPointAtCurrentPosition()
	end
		
}







return this


end)--DEBUGNOW PCALL