local StrCode32 = Fox.StrCode32
local StrCode32Table = Tpp.StrCode32Table
local GetGameObjectId = GameObject.GetGameObjectId

local this = BaseMissionSequence.CreateInstance( "s10010" )

this.sequences = {}




this.NO_RESULT = true				
this.disableEnemyRespawn = true		


local GEAR_TABLE_FOR_MB = {
	[ PlayerType.AVATAR_MALE ] = {
		[ GearType.HELMET ] = "hdm19_main0_v00",	
		[ GearType.UPPER_BODY ] = "uam3_main0_v00",
		[ GearType.ARM ] = "arm7_main0_v00",	
		[ GearType.LOWER_BODY ] = "lgm4_main0_v00",	
	},
	[ PlayerType.AVATAR_FEMALE ] = {
		[ GearType.HELMET ] = "hdf19_main0_v00",	
		[ GearType.UPPER_BODY ] = "uaf3_main0_v00",	
		[ GearType.ARM ] = "arf7_main0_v00",	
		[ GearType.LOWER_BODY ] = "lgf4_main0_v00",	
	},
}


local GEAR_TABLE_FOR_AFGH = {
	[ PlayerType.AVATAR_MALE ] = {
		[ GearType.UPPER_BODY ] = "uam0_main0_v00",
		[ GearType.ARM ] = "arm12_main0_v00",	
		[ GearType.LOWER_BODY ] = "lgm4_main0_v00",	
	},
	[ PlayerType.AVATAR_FEMALE ] = {
		[ GearType.UPPER_BODY ] = "uaf0_main0_v00",	
		[ GearType.ARM ] = "arf12_main0_v00",	
		[ GearType.LOWER_BODY ] = "lgf4_main0_v00",	
	},
}


local GEAR_TABLE_FOR_GAME = {
	[ PlayerType.AVATAR_MALE ] = {
		[ GearType.UPPER_BODY ] = "uam4_main0_v00",
		[ GearType.ARM ] = "arm16_main0_v00",	
		[ GearType.LOWER_BODY ] = "lgm15_main0_v00",	
	},
	[ PlayerType.AVATAR_FEMALE ] = {
		[ GearType.UPPER_BODY ] = "uaf4_main0_v00",	
		[ GearType.ARM ] = "arf16_main0_v00",	
		[ GearType.LOWER_BODY ] = "lgf15_main0_v00",	
	},
}



local tipsMenuList = {
	
	TIPS_LIFE = {
		startRadio		= "f3010_rtrg0018",
		tipsTypes		= {
							{ HelpTipsType.TIPS_1_A, HelpTipsType.TIPS_1_B, HelpTipsType.TIPS_1_C },
						},
		tipsRadio		= "f3010_rtrg0020",
	},
	
	TIPS_ACTION = {
		tipsTypes		= {
							{ HelpTipsType.TIPS_28_A, HelpTipsType.TIPS_28_B, HelpTipsType.TIPS_28_C },
						},
		tipsRadio		= "f3010_rtrg0022",
		endFunction		= function()
			if not svars.control_guide_jump then
				
				TppUI.ShowControlGuide{
					actionName = "JUMP", 
					time = 5.0,
					continue = false
				}
				svars.control_guide_jump = true
			end
		end,
	},
	
	TIPS_ZOMBIE_VISION_HEARING = {
		startRadio		= "f3010_rtrg0042",	
		tipsTypes		= {
							{ HelpTipsType.TIPS_2_A, HelpTipsType.TIPS_2_B, HelpTipsType.TIPS_2_C },
							{ HelpTipsType.TIPS_29_A, HelpTipsType.TIPS_29_B, HelpTipsType.TIPS_29_C },
						},
		tipsRadio		= "f3010_rtrg0044",
		endFunction		= function()
			
			TppRadio.Play("f3010_rtrg0046")
			
			GkEventTimerManager.Start( "TimerWaitingEnableThreatRing", 6.4 )
		end,
	},
	
	TIPS_PAD = {
		tipsTypes		= {
							{ HelpTipsType.TIPS_27_C },
						},
	},
	
	TIPS_CRAFT = {
		startRadio		= "f3010_rtrg0038",
		tipsTypes		= {
							{ HelpTipsType.TIPS_15_A, HelpTipsType.TIPS_15_B, HelpTipsType.TIPS_15_C },
						},

	},
	
	TIPS_MATERIAL		= {
		startRadio		= "f3010_rtrg0034",
		tipsTypes		= {
							{ HelpTipsType.TIPS_30_A, HelpTipsType.TIPS_30_B, HelpTipsType.TIPS_30_C },
						},
		tipsRadio		= "f3010_rtrg0036",
	},
	
	TIPS_BACKSTAB		= {
		startRadio		= "f3010_rtrg0050",
		tipsTypes		= {
							{ HelpTipsType.TIPS_21_A, HelpTipsType.TIPS_21_B },
		},
		tipsRadio		= "f3010_rtrg0052",
		endFunction		= function()
			
			this.SetZombieMissionTarget( "zmb_s10010_0001", false )
			this.SetZombieMissionTarget( "zmb_s10010_st_01", true )
			Fox.Log( "TIPS_BACKSTAB.endfunction.Targeting_zmb_s10010_st_01" )
		end,
	},
}









this.sequenceList = {
	"Seq_Demo_Synopsis",
	"Seq_Demo_ReadyFuneral",

	"Seq_Demo_OpenPlayerInfoEdit",
	"Seq_Game_SelectGender",
	"Seq_Game_InputName",
	"Seq_Game_EndPlayerInfoEdit",
	"Seq_Game_WaitAvatarLoadAfterGenderSelected",
	"Seq_Demo_WaitAvatarLoadAfterMbGearChanged1",

	"Seq_Demo_BattleOnMb",
	"Seq_Demo_GzMovie",
	"Seq_Demo_Burial",

	"Seq_Demo_OpenAvatarEdit",
	"Seq_Game_WaitAvatarLoadBeforeAvatarEdit",
	"Seq_Demo_SelectGenderForAvatarEdit",
	"Seq_Game_StartAvatarEdit",
	"Seq_Game_UpdateAvatarEdit",
	"Seq_Game_EndAvatarEdit",
	"Seq_Game_WaitAvatarLoad",
	"Seq_Demo_WaitAvatarLoadBeforeSouvenirPhotograph",

	"Seq_Demo_SouvenirPhotograph",
	"Seq_Game_WaitAvatarLoadAfterMbGearChanged2",

	"Seq_Demo_Wormhole",
	"Seq_Demo_MissionSetting",

	"Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1",
	"Seq_Demo_ArriveInAfgh",

	"Seq_Game_Tutorial1",

	"Seq_Demo_ReeveEncounter",

	"Seq_Game_Tutorial2_Escape",
	"Seq_Demo_ReunionReeve",
	"Seq_Demo_BlackRadioMeetReeve",
	"Seq_Demo_WaitAvatarLoadAfterAfghGearChanged4",

	"Seq_Game_Tutorial3_Craft",
	"Seq_Demo_ZombieAppearance",
	"Seq_Game_Tutorial4_Sneak",

	"Seq_Demo_Relics",

	"Seq_Demo_WaitAvatarLoadAfterMbGearChanged3",
	"Seq_Demo_Retrospect",
	"Seq_Demo_MissionBriefing",

	"Seq_Demo_WaitAvatarLoadAfterAfghGearChanged2",
	"Seq_Demo_Recapture",

	"Seq_Demo_EncounterAi",
	"Seq_Demo_BlackTelephone",

	"Seq_Game_DebugForDemo",
}

function this.OnLoad()
	Fox.Log("#### OnLoad ####")

	TppSequence.RegisterSequences( this.sequenceList )
	TppSequence.RegisterSequenceTable( this.sequences )
end





this.saveVarsList = {
	control_guide_camera			= false,				
	control_guide_jump				= false,				
	control_guide_shoot				= false,				
	control_guide_attack			= false,				
	intrudeTips						= false,				
	craftTips						= false,				
	usemacheteRadio					= false,				
	isEscape_ContinueCheck			= false,				
	radderRadio						= false,				
	selectedGender					= GenderMenuResult.Male,
	control_guide_elude 			= false,				
	ismarker_jump						= false,				
	marker_elude					= false,				
	isStartRadioFinish				= false,				
	isTipsLife						= false,				
	isTipsCompass					= false,				
	isTipsAction					= false,				
	isNotMeetCondition				= false,				
	isContinueZombieAppearance		= false,				
	isZombieThreatArea				= false,				
	isContinueZombieBattle			= false,				
	goalmarker						= false,				
	isZombieSetUp01					= false,				
	isZombieSetUp02					= false,				
	isZombieSetUp03					= false,				
	isZombieSetUp04					= false,				
	isZombieSetUp05					= false,				
	isZombieSetUp06					= false,				
	isZombieSetUp07					= false,				
	isZombieSetUp08					= false,				
	isZombieSetUp09					= false,				
	isZombieSetUp10					= false,				
	isZombieSetUp11					= false,				
	isZombieSetUpST00				= false,				
	isZombieSetUpST01				= false,				
	isBacksTabRadio					= false,				
	isRadio_RuinsFactory			= false,				
	isRadio_Equipment				= false,				
	isFenceAreaRadio00				= false,				
	isResourceCountCheck			= false,				
	isRadio_CompleteExpPreparation	= false,				
	isZombieWakeUpThroughCatWalk	= false,				
	isZombieSetUpOutOfFact			= false,				
	isInEncounterReeveRoom			= false,				
	isDisableZombieOutOfFact		= false,				
	isPlayerOnTheCatWalk			= false,				
	isZombieFanceArea0000			= false,				
	isDemoZombieKilled				= false,				
	isOutOfAmmoRadio				= false,				
	isInDemoRoomKillArea			= false,				
	isInAisleMiddleArea				= false,				
	isAisleZombieAttack00			= false,				
	isSetUpStealthZombie			= false,				
	isdemoRoomZombieDeadCount		= 0,					
	isWindowZombieAttack00			= false,				
	isAisleZombieAttack02			= false,				
	isFence0005Break				= false,				
	isZombieNoticeOnCount			= 0,					
	isZombieNoticeOnFlag			= false,					
	ismarker_return					= false,				
	ismarker_FactoryOuter			= false,				
	ismarker_FactoryEntrance		= false,				
	ismarker_FactoryInner			= false,				
	isAlert_Radio					= false,				
	isFence0007Break				= false,				
	isSetInvincibleFence0004 		= false,
	isSetInvincibleFence0013 		= false,
	isNoAmmoRadioArea				= false,				
	isStealthZombieNotice			= false,				
}


this.checkPointList = {
	"CHK_Tutorial1",
	"CHK_Tutorial2",
	"CHK_Tutorial3",
	"CHK_Tutorial4",
	"CHK_Tutorial5",
	nil,
}







this.missionObjectiveDefine = {
	marker_tutorial1_checkpoint_0001 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0001_01 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001_01", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0001_02 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001_02", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0001_03 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001_03", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0001_04 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001_04", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0001_05 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001_05", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0001_06 = {
		gameObjectName = "marker_tutorial1_checkpoint_0001_06", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0002 = {
		gameObjectName = "marker_tutorial1_checkpoint_0002", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0003 = {
		gameObjectName = "marker_tutorial1_checkpoint_0003", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0004 = {
		gameObjectName = "marker_tutorial1_checkpoint_0004", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0005 = {
		gameObjectName = "marker_tutorial1_checkpoint_0005", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0006 = {
		gameObjectName = "marker_tutorial1_checkpoint_0006", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	maker_tutorial1_disable_all_0007 = {
	},
	marker_tutorial1_checkpoint_0008 = {
		gameObjectName = "marker_tutorial1_checkpoint_0008", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0009 = {
		gameObjectName = "marker_tutorial1_checkpoint_0009", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0010 = {
		gameObjectName = "marker_tutorial1_checkpoint_0010", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0011 = {
		gameObjectName = "marker_tutorial1_checkpoint_0011", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0012 = {
		gameObjectName = "marker_tutorial1_checkpoint_0012", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_checkpoint_0013 = {
		gameObjectName = "marker_tutorial1_checkpoint_0013", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	marker_tutorial1_goal = {
		gameObjectName = "marker_tutorial1_goal", visibleArea = 0, randomRange = 0, setNew = true, setImportant = true,
		announceLog = "updateMap", langId = "marker_info_place_02", goalType = "moving", viewType = "all",
	},
	maker_disable_all = {},
}












this.missionObjectiveTree = {
	maker_disable_all = {
		marker_tutorial1_goal = {
			marker_tutorial1_checkpoint_0013 = {
				marker_tutorial1_checkpoint_0012 = {
					marker_tutorial1_checkpoint_0011 = {
						marker_tutorial1_checkpoint_0010 = {
							marker_tutorial1_checkpoint_0009 = {
								marker_tutorial1_checkpoint_0008 = {
									maker_tutorial1_disable_all_0007 = {
										marker_tutorial1_checkpoint_0006 = {
											marker_tutorial1_checkpoint_0005 = {
												marker_tutorial1_checkpoint_0004 = {
													marker_tutorial1_checkpoint_0003 = {
														marker_tutorial1_checkpoint_0002 = {
															marker_tutorial1_checkpoint_0001_06 = {
																marker_tutorial1_checkpoint_0001_05 = {
																	marker_tutorial1_checkpoint_0001_04 = {
																		marker_tutorial1_checkpoint_0001_03 = {
																			marker_tutorial1_checkpoint_0001_02 = {
																				marker_tutorial1_checkpoint_0001_01 = {
																					marker_tutorial1_checkpoint_0001 = {},
																				},
																			},
																		},
																	},
																},
															},
														},
													},
												},
											},
										},
									},
								},
							},
						},
					},
				},
			},
		},
	},
}

this.missionObjectiveEnum = Tpp.Enum{
	"marker_tutorial1_checkpoint_0001",		
	"marker_tutorial1_checkpoint_0001_01",	
	"marker_tutorial1_checkpoint_0001_02",	
	"marker_tutorial1_checkpoint_0001_03",	
	"marker_tutorial1_checkpoint_0001_04",	
	"marker_tutorial1_checkpoint_0001_05",	
	"marker_tutorial1_checkpoint_0001_06",	
	"marker_tutorial1_checkpoint_0002",		
	"marker_tutorial1_checkpoint_0003",		
	"marker_tutorial1_checkpoint_0004",		
	"marker_tutorial1_checkpoint_0005",		
	"marker_tutorial1_checkpoint_0006",		
	"maker_tutorial1_disable_all_0007",		
	"marker_tutorial1_checkpoint_0008",		
	"marker_tutorial1_checkpoint_0009",		
	"marker_tutorial1_checkpoint_0010",		
	"marker_tutorial1_checkpoint_0011",		
	"marker_tutorial1_checkpoint_0012",		
	"marker_tutorial1_checkpoint_0013",		
	"marker_tutorial1_goal",				
	"maker_disable_all",
}


this.UNSET_PAUSE_MENU_SETTING = {
	GamePauseMenu.RETURN_TO_BASE,
}


this.UNSET_GAME_OVER_MENU_SETTING = {
	GameOverMenuType.RETURN_TO_BASE,
}




local zombieSettingTableList = {
	IncomingDemoRoom0010 = {
		{ name = "zmb_s10010_0005", zombieType = "SsdZombie", key = "warp_s10010_0005", routeName = "rts_s10010_0005_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0006", zombieType = "SsdZombie", key = "warp_s10010_0006", routeName = "rts_s10010_0006_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_xof_0005", zombieType = "SsdZombieEvent", key = "warp_s10010_0001", routeName = "rts_s10010_xof_0005_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0000", zombieType = "SsdZombie", key = "warp_s10010_0000", routeName = "rts_s10010_0000_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0002", zombieType = "SsdZombie", key = "warp_s10010_0002", routeName = "rts_s10010_0002_0000", zombieSpeed = "walk", },
	},
	IncomingDemoRoom0020 = {
		{ name = "zmb_s10010_0000_0001", zombieType = "SsdZombie", key = "warp_s10010_0000", routeName = "rts_s10010_0000_0001", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0005_0001", zombieType = "SsdZombie", key = "warp_s10010_0005", routeName = "rts_s10010_0005_0001", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0006_0001", zombieType = "SsdZombie", key = "warp_s10010_0006", routeName = "rts_s10010_0006_0001", zombieSpeed = "walk", },
	},
	IncomingDemoRoom0030 = {
		{ name = "zmb_s10010_0003", zombieType = "SsdZombie", key = "warp_s10010_0003", routeName = "rts_s10010_0003", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0004", zombieType = "SsdZombie", key = "warp_s10010_0004", routeName = "rts_s10010_0004", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0008", zombieType = "SsdZombie", key = "warp_s10010_0008", routeName = "rts_s10010_0008", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0043", zombieType = "SsdZombie", key = "warp_s10010_0043", routeName = "rts_s10010_0043", zombieSpeed = "walk", },
	},
	WaitingDemoRoomZombie0010 = {
		{ name = "zmb_s10010_0009", zombieType = "SsdZombie", key = "warp_s10010_0009", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0010", zombieType = "SsdZombie", key = "warp_s10010_0010", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0011", zombieType = "SsdZombie", key = "warp_s10010_0011", zombieSpeed = "walk", },
	},
	IncomingFactory0010 = {	
		{ name = "zmb_s10010_0017", zombieType = "SsdZombie", key = "warp_s10010_0017",  routeName = "rts_s10010_0017", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0018", zombieType = "SsdZombie", key = "warp_s10010_0018",  routeName = "rts_s10010_0018", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0019", zombieType = "SsdZombie", key = "warp_s10010_0019",  routeName = "rts_s10010_0019", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0020", zombieType = "SsdZombie", key = "warp_s10010_0020",  routeName = "rts_s10010_0020", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0021", zombieType = "SsdZombie", key = "warp_s10010_0021",  routeName = "rts_s10010_0021", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0022", zombieType = "SsdZombie", key = "warp_s10010_0022",  routeName = "rts_s10010_0022", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0023", zombieType = "SsdZombie", key = "warp_s10010_0023",  routeName = "rts_s10010_0023", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0024", zombieType = "SsdZombie", key = "warp_s10010_0024",  routeName = "rts_s10010_0024", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0044", zombieType = "SsdZombie", key = "warp_s10010_0044",  routeName = "rts_s10010_0044", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0045", zombieType = "SsdZombie", key = "warp_s10010_0045",  routeName = "rts_s10010_0045", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0046", zombieType = "SsdZombie", key = "warp_s10010_0046",  routeName = "rts_s10010_0046", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0047", zombieType = "SsdZombie", key = "warp_s10010_0047",  routeName = "rts_s10010_0047", zombieSpeed = "walk", },
	},
	WindowsAisle_Right = {
		{ name = "zmb_s10010_0025", zombieType = "SsdZombie", key = "warp_s10010_0025", routeName = "rts_s10010_0025", zombieSpeed = "walk", },
	},
	WindowsAisle_ExitDemoRoom = {	
		{ name = "zmb_s10010_0026", zombieType = "SsdZombie", key = "warp_s10010_0026", routeName = "rts_s10010_0026_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0027", zombieType = "SsdZombie", key = "warp_s10010_0027", routeName = "rts_s10010_0027_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0028", zombieType = "SsdZombie", key = "warp_s10010_0028", routeName = "rts_s10010_0028", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0029", zombieType = "SsdZombie", key = "warp_s10010_0029", routeName = "rts_s10010_0029", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0030", zombieType = "SsdZombie", key = "warp_s10010_0030", routeName = "rts_s10010_0030", zombieSpeed = "walk", },
	},
	WindowsAisle_Outer = {	
		{ name = "zmb_s10010_0057", zombieType = "SsdZombie", key = "warp_s10010_0057", routeName = "rts_s10010_0057", zombieSpeed = "walk", },
	},
	WindowsAisle_Surprise0010 = {	
		{ name = "zmb_s10010_0058", zombieType = "SsdZombie", key = "warp_s10010_0058", routeName = "rts_s10010_0058_0000", zombieSpeed = "walk", },
	},
	WindowAisle_WaitingToThroughPlayer = {	
		{ name = "zmb_s10010_0012", zombieType = "SsdZombie", key = "warp_s10010_0012", routeName = "rts_s10010_0012", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0013", zombieType = "SsdZombie", key = "warp_s10010_0013", routeName = "rts_s10010_0013", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0014", zombieType = "SsdZombie", key = "warp_s10010_0014", routeName = "rts_s10010_0014", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0015", zombieType = "SsdZombie", key = "warp_s10010_0015", routeName = "rts_s10010_0015", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0016", zombieType = "SsdZombie", key = "warp_s10010_0016", routeName = "rts_s10010_0016", zombieSpeed = "walk", },
	},
	FenceArea_NearestTheEntrance = {	
		{ name = "zmb_s10010_infc_0000", zombieType = "SsdZombie", key = "warp_s10010_infc_0000", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0002", zombieType = "SsdZombie", key = "warp_s10010_infc_0002", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0006", zombieType = "SsdZombie", key = "warp_s10010_infc_0006", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0011", zombieType = "SsdZombie", key = "warp_s10010_infc_0011", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0013", zombieType = "SsdZombie", key = "warp_s10010_infc_0013", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0016", zombieType = "SsdZombie", key = "warp_s10010_infc_0016", zombieSpeed = "walk", },
	},
	FenceArea_independentZombie0010 = {	
		{ name = "zmb_s10010_infc_0015", zombieType = "SsdZombie", key = "warp_s10010_infc_0015", zombieSpeed = "walk", },
	},
	FenceArea_NearestTheEntranceNo2 = {	
		{ name = "zmb_s10010_infc_0001", zombieType = "SsdZombie", key = "warp_s10010_infc_0001", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0003", zombieType = "SsdZombie", key = "warp_s10010_infc_0003", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0005", zombieType = "SsdZombie", key = "warp_s10010_infc_0005", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0040", 	zombieType = "SsdZombie", key = "warp_s10010_0040", zombieSpeed = "walk", },
		{ name = "zmb_s10010_xof_0004", zombieType = "SsdZombieEvent", key = "warp_s10010_xof_0004", zombieSpeed = "walk", },
		{ name = "zmb_s10010_xof_0006", zombieType = "SsdZombieEvent", key = "warp_s10010_xof_0006", zombieSpeed = "walk", },
	},
	FenceArea_InFences0020 = {	
		{ name = "zmb_s10010_infc_0004", zombieType = "SsdZombie", key = "warp_s10010_infc_0004", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0008", zombieType = "SsdZombie", key = "warp_s10010_infc_0008", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0009", zombieType = "SsdZombie", key = "warp_s10010_infc_0009", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0017", zombieType = "SsdZombie", key = "warp_s10010_infc_0017", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0018", zombieType = "SsdZombie", key = "warp_s10010_infc_0018", zombieSpeed = "walk", },
	},
	FenceArea_independentZombie0020 = {	
		{ name = "zmb_s10010_xof_0011", zombieType = "SsdZombieEvent", key = "warp_s10010_xof_0011", zombieSpeed = "walk", },
	},
	FenceArea_WindowSurprise = {	
		{ name = "zmb_s10010_infc_0010", zombieType = "SsdZombie", key = "warp_s10010_infc_0010", routeName = "rts_s10010_infc_0010", zombieSpeed = "walk", },
		{ name = "zmb_s10010_infc_0014", zombieType = "SsdZombie", key = "warp_s10010_infc_0014", routeName = "rts_s10010_infc_0014", zombieSpeed = "walk", },
	},
	FenceArea_IncomingFromAisle = {	
		{ name = "zmb_s10010_0033", zombieType = "SsdZombie", key = "warp_s10010_0033", routeName = "rts_s10010_0033", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0034", zombieType = "SsdZombie", key = "warp_s10010_0034", routeName = "rts_s10010_0034", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0035", zombieType = "SsdZombie", key = "warp_s10010_0035", routeName = "rts_s10010_0035", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0036", zombieType = "SsdZombie", key = "warp_s10010_0036", routeName = "rts_s10010_0036", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0037", zombieType = "SsdZombie", key = "warp_s10010_0037", routeName = "rts_s10010_0037", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0038", zombieType = "SsdZombie", key = "warp_s10010_0038", routeName = "rts_s10010_0038", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0039", zombieType = "SsdZombie", key = "warp_s10010_0039", routeName = "rts_s10010_0039", zombieSpeed = "walk", },
	},
	FenceArea_WaitingBasementEntrance0020 = {
		{ name = "zmb_s10010_0031", zombieType = "SsdZombie", key = "warp_s10010_0031", routeName = "rts_s10010_0031", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0032", zombieType = "SsdZombie", key = "warp_s10010_0032", routeName = "rts_s10010_0032", zombieSpeed = "walk", },
	},
	FenceArea_WaitingBasementEntrance0010 = {
		{ name = "zmb_s10010_infc_0007", zombieType = "SsdZombie", key = "warp_s10010_infc_0007", zombieSpeed = "walk", },
	},
	AttackCatWalkZombies0010 = {	
		{ name = "zmb_s10010_xof_0007", zombieType = "SsdZombieEvent", key = "warp_s10010_xof_0007", routeName = "rts_s10010_xof_0007", zombieSpeed = "walk", },
	},
	StealthAreaZombie0010 = {	
		{ name = "zmb_s10010_0001", zombieType = "SsdZombie", key = "warp_s10010_st_00", routeName = "rts_s10010_st_00", zombieSpeed = "walk", },
	},
	StealthAreaZombie0020 = {	
		{ name = "zmb_s10010_st_01", zombieType = "SsdZombie", key = "warp_s10010_st_01", routeName = "rts_s10010_st_01", zombieSpeed = "walk", },
	},
	OutOfFactoryZombies0010 = {	
		{ name = "zmb_s10010_0007", zombieType = "SsdZombie", key = "warp_s10010_0007", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0048", zombieType = "SsdZombie", key = "warp_s10010_0048", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0049", zombieType = "SsdZombie", key = "warp_s10010_0049", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0050", zombieType = "SsdZombie", key = "warp_s10010_0050", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0051", zombieType = "SsdZombie", key = "warp_s10010_0051", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0052", zombieType = "SsdZombie", key = "warp_s10010_0052", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0053", zombieType = "SsdZombie", key = "warp_s10010_0053", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0054", zombieType = "SsdZombie", key = "warp_s10010_0054", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0055", zombieType = "SsdZombie", key = "warp_s10010_0055", zombieSpeed = "walk", },
		{ name = "zmb_s10010_0056", zombieType = "SsdZombie", key = "warp_s10010_0056", zombieSpeed = "walk", },
	},
}

local NOTzombieSettingTableList ={
	{ zombieType = "SsdZombie", name = "zmb_s10010_0041", },
	{ zombieType = "SsdZombie", name = "zmb_s10010_0042", },
	{ zombieType = "SsdZombie", name = "zmb_s10010_infc_0007_1", },
	{ zombieType = "SsdZombie", name = "zmb_s10010_infc_0012", },
	{ zombieType = "SsdZombieEvent", name = "zmb_s10010_demo_0000", },
	{ zombieType = "SsdZombieEvent",  name = "zmb_s10010_demo_0001",},
}


local AisleNoticeOnOffList ={
	zombieSettingTableList.WindowsAisle_Surprise0010,
	zombieSettingTableList.WindowsAisle_Outer,
	zombieSettingTableList.WindowsAisle_ExitDemoRoom,
}

local WindowsZombieList = {
	"zmb_s10010_0025",
	"zmb_s10010_0026",
	"zmb_s10010_0027",
	"zmb_s10010_0028",
	"zmb_s10010_0029",
	"zmb_s10010_0030",
	"zmb_s10010_0057",
	"zmb_s10010_0058",
	"zmb_s10010_infc_0010",
	"zmb_s10010_infc_0014",
}







function this.AfterMissionPrepare()
	local systemCallbackTable ={
		OnEstablishMissionClear = function( missionClearType )
			
			Player.SetPadMask{
				settingName = "MissionClearCamera",
				except = true,
			}
			Player.RequestToSetTargetStance(PlayerStance.STAND) 

			
			SsdBlankMap.UpdateReachInfo()

			TppMission.MissionGameEnd{
				fadeSpeed = TppUI.FADE_SPEED.FADE_HIGHESTSPEED,
				fadeDelayTime = 0.1,
				delayTime = 0.1,
			}
			TppTrophy.Unlock( 2 ) 
		end,
		OnEndMissionReward = function()
			TppSequence.SetNextSequence( "Seq_Demo_EncounterAi", { isExecMissionClear = true, } )
		end,
		
		OnOutOfMissionArea = function()
			TppMission.ReserveGameOver( TppDefine.GAME_OVER_TYPE.OUTSIDE_OF_MISSION_AREA, TppDefine.GAME_OVER_RADIO.S10020_OUT_OF_MISSION_AREA )
		end,
		nil
	}
	
	TppMission.RegiserMissionSystemCallback( systemCallbackTable )
end




function this.AfterOnRestoreSVars()
	Fox.Log( "s10010_sequence.AfterOnRestoreSVars()" )

	local missionStartSequenceIndex = TppSequence.GetMissionStartSequenceIndex()

	
	if missionStartSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Tutorial1" ) then
		
		TppUiStatusManager.SetStatus( "AnnounceLog","INVALID_LOG", "s10010_sequence" )
	else
		TppUiStatusManager.UnsetStatus( "AnnounceLog","INVALID_LOG", "s10010_sequence" )
	end

	
	if missionStartSequenceIndex >= TppSequence.GetSequenceIndex( "Seq_Game_Tutorial2_Escape" ) then
		TppUiStatusManager.UnsetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )
	else
		TppUiStatusManager.SetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )
	end

	
	if missionStartSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Game_Tutorial3_Craft" ) then
		SsdUiSystem.Unlock( SsdUiLockType.FACILITY_PANEL )
	else
		SsdUiSystem.Lock( SsdUiLockType.FACILITY_PANEL )
	end
	
	if missionStartSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Demo_Relics" ) then
		vars.playerDisableActionFlag = PlayerDisableAction.MB_TERMINAL+ PlayerDisableAction.RIP_OUT+ PlayerDisableAction.CQC+ PlayerDisableAction.FULTON
	end

	
	SsdSbm.SetRecipeIdsCraftable{ "RCP_EQP_WP_Spear_A", }

	local sequenceNameToPackageLabelName = {
		Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1 = "arriveInAfgh",
		Seq_Demo_BlackRadioMeetReeve = "zombieAppearance",
		Seq_Demo_WaitAvatarLoadAfterMbGearChanged3 = "retrospect",
		Seq_Demo_WaitAvatarLoadAfterAfghGearChanged2 = "recapture",
	}
	local currentPackageLabelName = "readyFuneral"
	for _, sequenceName in pairs( this.sequenceList ) do
		local sequenceIndex = TppSequence.GetSequenceIndex( sequenceName )
		if missionStartSequenceIndex < sequenceIndex then
			break
		end
		local packageLabelName = sequenceNameToPackageLabelName[ sequenceName ]
		if packageLabelName then
			currentPackageLabelName = packageLabelName
		end
	end
	Fox.Log( "s10010_sequence.AfterMissionPrepare(): currentPackageLabelName:" .. tostring( currentPackageLabelName ) )
	TppScriptBlock.PreloadRequestOnMissionStart{
		{ demo_block = currentPackageLabelName },
	}
end




function this.AfterOnEndMissionPrepareSequence()
	Fox.Log( "s10010_sequence.AfterOnEndMissionPrepareSequence():" )

	local missionStartSequenceIndex = TppSequence.GetMissionStartSequenceIndex()
	if missionStartSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1" ) then 
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.SUNNY, 0.00 )		
	elseif missionStartSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Demo_Relics" ) then 
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.CLOUDY, 0.00 )	
		TppClock.SetTime( "02:00:00" )
	else
		TppWeather.ForceRequestWeather( TppDefine.WEATHER.SUNNY, 0.00 )		
		TppClock.SetTime( "07:30:00" )
	end
	
	TppClock.Stop()
	
	GameObject.SendCommand( { type = "TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex(), }, { id = "SetDisableInjury", disable = true, } )
	
	if missionStartSequenceIndex == TppSequence.GetSequenceIndex( "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1" ) then
		GameObject.SendCommand( { type = "TppPlayer2", index = PlayerInfo.GetLocalPlayerIndex() }, { id = "CureInjury", } )
	end
	if TppLocation.IsAfghan() then
		
		if missionStartSequenceIndex > TppSequence.GetSequenceIndex( "Seq_Game_Tutorial4_Sneak" ) then
			
			SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_THREAT_RING )
		else
			
			SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.INVISIBLE_THREAT_RING )
		end
		
		if TppStory.GetCurrentStorySequence() == TppDefine.STORY_SEQUENCE.STORY_START then
			TppVarInit.InitializeBuildingData( true )
		end
		
		local visibility = false
		if missionStartSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Demo_Relics" ) then 
			visibility = true
		end
		TppDataUtility.SetVisibleDataFromIdentifier( "DataIdentifier_s10010_d03_identifier", "MB_switchVisibility", visibility, true )

		
		if missionStartSequenceIndex >= TppSequence.GetSequenceIndex( "Seq_Game_Tutorial1" ) and Tpp.IsTypeTable( afgh_base ) then
			afgh_base.SetAfghOpeningAssetVisibility( true )
		end

		
		if missionStartSequenceIndex >= TppSequence.GetSequenceIndex( "Seq_Game_Tutorial3_Craft" ) then
			Mission.SetHas10010ReeveHelmet(false)
		end

		
		if TppSequence.GetSequenceIndex( "Seq_Demo_ReeveEncounter" ) < missionStartSequenceIndex and missionStartSequenceIndex < TppSequence.GetSequenceIndex( "Seq_Demo_ReunionReeve" ) then
			
			SsdSbm.AddWeaponForTutorial{ id="PRD_EQP_WP_hg00", ammoCount= 13, }
			
			this.SetZombieVoice( "POINT_ZMB_VOICES_A",false )
			this.SetZombieVoice( "POINT_ZMB_VOICES_B",false )
			
			TppSound.StopSceneBGM("bgm_escape")
			
			this.SetBreakAndWarp( "SsdZombieEvent", "zmb_s10010_demo_0000", "warp_s10010_demo_0000", 0, 0, 1, 1 )
			
			this.DisableAllZombiesSeqEscape( zombieSettingTableList )
			
			this.ZombieSleepSetting( "SsdZombie", "zmb_s10010_0041", {-287.771,292.7355,2442.432}, 10.0, 1, 0 )
			this.ZombieSleepSetting( "SsdZombie", "zmb_s10010_0042", {-251.9574,288.55,2468.755}, 230.0, 1, 0 )
			
			this.ZombieSleepSetting( "SsdZombie", "zmb_s10010_infc_0012", { -284.6035,288.55,2459.78 }, 100.0, 1, 0 )
			
			svars.isEscape_ContinueCheck = true
		else
			
			this.DisableAllZombiesSeqEscape( zombieSettingTableList )
			
			if missionStartSequenceIndex > TppSequence.GetSequenceIndex( "Seq_Game_Tutorial2_Escape" ) then
				
				this.ZombieListSetEnable(NOTzombieSettingTableList, false)
			end
		end
	end
end





this.AddOnTerminateFunction(
	function()
		Fox.Log( "s10010_sequence.AfterOnTerminate()" )
		
		if mvars.s10010_SynopsisBGSoundHandle then
			TppSoundDaemon.PostEventAndGetHandle( "Stop_wave_loop", "Title" )	
		end
		
		local resetGameStatusList = {
			{ "AvatarEdit", "S_DISABLE_HUD" },
			{ "AvatarEdit", "S_DISABLE_PLAYER_DAMAGE" },
			{ "AvatarEdit", "S_DISABLE_GAME_PAUSE" },
			{ "s10010_sequence", "S_DISABLE_PLAYER_PAD" },
		}
		for _, gameStatusTable in ipairs( resetGameStatusList ) do
			local scriptName, gameStatusName = gameStatusTable[1], gameStatusTable[2]
			TppGameStatus.Reset( scriptName, gameStatusName )
		end
		
		TppUiStatusManager.UnsetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )
		
		SsdUiSystem.ClearScriptFlag()
		
		SsdSbm.ResetRecipeIdsCraftable()
	end
)




function this.Messages()
	return StrCode32Table{
		Trap = {
			{
				sender = "trap_tutorial1_goal",
				msg = "Enter",
				func = function( trapName, gameObjectId )
					Fox.Log( "s10010_sequence.Messages(): Trap: sender:trap_tutorial1_goal, msg:Enter, trapName:" .. tostring( trapName ) .. ", gameObjectId:" .. tostring( gameObjectId ) )
					if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Demo_Relics" ) then
						TppSequence.SetNextSequence( "Seq_Demo_Relics" )
					end
				end,
			},
			{	
				sender = "trap_0005_encounter_reeve",
				msg = "Enter",
				func = function( trapName, gameObjectId )
					Fox.Log( "s10010_sequence.Messages(): Trap: sender:trap_0005_start_sneak_view, msg:Enter, trapName:" .. tostring( trapName ) .. ", gameObjectId:" .. tostring( gameObjectId ) )
					if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Demo_ReeveEncounter" ) then
						TppSequence.SetNextSequence( "Seq_Demo_ReeveEncounter" )
					end
				end,
			},
			{	
				sender = "trap_forgetThreatArea0000",
				msg = "Enter",
				func = function( trapName, gameObjectId )
					
					if svars.isZombieThreatArea == true then
						svars.isZombieThreatArea = false
					end
				end,
			},
			{	
				sender = "trap_forgetThreatArea0001",
				msg = "Enter",
				func = function( trapName, gameObjectId )
					if svars.isZombieThreatArea == false then
						this.SetZombieForgetThreat( "zmb_s10010_0001" )
						this.SetZombieForgetThreat( "zmb_s10010_0002" )
						svars.isZombieThreatArea = true
					end
				end,
			},
		},
		UI = {
			{
				msg = "BlackRadioClosed",
				func = function( blackRadioId )
					Fox.Log( "s10010_sequence.sequences.Seq_Demo_BlackTelephone.Messages(): UI: msg:BlackRadioClosed, BlackRadioClosed:" .. tostring( BlackRadioClosed ) )
					if blackRadioId == StrCode32( "S10010_0020" ) then
						TppMission.MissionFinalize{ isNoFade = true }
					end
				end,
				option = { isExecMissionClear = true, },
			},
		},
	}
end




function this.OnSelectGender( type )
	if type == GenderMenuResult.Female then
		Fox.Log( "### Select Female ###" )
		
		vars.avatarSaveIsValid = 0
		vars.playerType				= PlayerType.AVATAR_FEMALE
		vars.playerPartsType		= PlayerPartsType.AVATAR_EDIT_WOMAN
		vars.avatarFaceRaceIndex	= 128
		this.selectedGender			= PlayerPartsType.AVATAR_WOMAN
		this.avatar_edit_presets	= avatar_presets_women.presets
	else
		Fox.Log( "### Select Male ###" )
		
		vars.avatarSaveIsValid = 0
		vars.playerType				= PlayerType.AVATAR_MALE
		vars.playerPartsType		= PlayerPartsType.AVATAR_EDIT_MAN
		vars.avatarFaceRaceIndex	= 0
		this.selectedGender			= PlayerPartsType.AVATAR_MAN
		this.avatar_edit_presets	= avatar_presets.presets
	end

	Fox.Log( "vars.avatarSaveIsValid   : " .. tostring( vars.avatarSaveIsValid ) )
	Fox.Log( "vars.playerType          : " .. tostring( vars.playerType ) )
	Fox.Log( "vars.playerPartsType     : " .. tostring( vars.playerPartsType ) )
	Fox.Log( "vars.avatarFaceRaceIndex : " .. tostring( vars.avatarFaceRaceIndex ) )
	Fox.Log( "this.selectedGender      : " .. tostring( this.selectedGender ) )
	Fox.Log( "this.avatar_edit_presets : " .. tostring( this.avatar_edit_presets ) )
end

this.WarpPlayerForMbDemo = function()
	Fox.Log( "s10010_sequence.WarpPlayerForMbDemo()" )

	
	local position, rotationY = Tpp.GetLocator( "DataIdentifier_s10010_sequence", "warp_mb" )
	GameObject.SendCommand( GameObject.GetGameObjectId( "TppPlayer2", "Player" ), { id = "WarpAndWaitBlock", pos = position, rotY = rotationY, unrealize = true, } )
end

this.CreateGearChangeSequence = function( nextSequenceName, gearTable, helmet, skin, currentSequenceName, needSave )
	return {
		OnEnter = function( self )
			Fox.Log( "s10010_sequence.sequences." .. tostring( currentSequenceName ) .. ".OnEnter(): self:" .. tostring( self ) )
			local playerType = vars.playerType
			
			if skin then
				if playerType == PlayerType.AVATAR_MALE then
					vars.avatarFaceColorIndex = 4
				elseif playerType ==  PlayerType.AVATAR_FEMALE then
					vars.avatarFaceColorIndex = 132
				end
				Player.SetEnableUpdateAvatarInfo( true )
			end
			local genderGearTable = gearTable[ playerType ]
			if Tpp.IsTypeTable( genderGearTable ) then
				for gearType, modelId in pairs( genderGearTable ) do
					if gearType ~= GearType.HELMET then	
						Gear.SetGear{ type = gearType, id = modelId, }
					end
				end
				local helmetGearModelId = genderGearTable[ GearType.HELMET ]
				if helmetGearModelId and helmet then
					Gear.SetGear{ type = GearType.HELMET, id = helmetGearModelId, }
				else
					Gear.SetGear{ type = GearType.HELMET, }
				end
			end
			Gear.SetGear{ type=GearType.INNER }	
			mvars.avatarWaitCount = 0
		end,
		OnUpdate = function()
			if not mvars.avatarWaitCount then
				mvars.avatarWaitCount = 0
			end
			if mvars.avatarWaitCount > 3 and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, } then	
				TppSequence.SetNextSequence( nextSequenceName )
			else
				mvars.avatarWaitCount = mvars.avatarWaitCount + 1
			end
		end,
		OnLeave = function()
			if needSave then
				
				TppMission.UpdateCheckPointAtCurrentPosition()
			end
		end,
	}
end


this.SetInitialPlayerPositionForAfgh = function()
	Fox.Log( "s10010_sequence.SetInitialPlayerPositionForAfgh()" )
	TppPlayer.SetInitialPosition( { -231.3611,289.1893,2543.889, }, 206.671 )
end

this.SetInitialPlayerPositionForOmbs = function()
	Fox.Log( "s10010_sequence.SetInitialPlayerPositionForAfgh()" )
	TppPlayer.SetInitialPosition( { 0.887757,-50.4697,-4.160109, }, 200 )
end







this.sequences.Seq_Demo_Synopsis = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Synopsis.OnEnter(): self:" .. tostring( self ) )
		StorySummarySystem.RequestOpen("back_story")
		mvars.s10010_SynopsisBGSoundHandle = TppSoundDaemon.PostEventAndGetHandle( "Play_wave_loop", "Loading" )
	end,

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "StorySummaryFinished",
					func = function()
						mvars.s10010_SynopsisBGSoundHandle = nil
						TppSoundDaemon.PostEventAndGetHandle( "Stop_wave_loop", "Loading" )	
						GkEventTimerManager.Start( "Timer_GoNextSequence", 8 )
					end,
				},
			},
			Timer = {
				{
					sender = "Timer_GoNextSequence",
					msg = "Finish",
					func = function()
						Fox.Log( "s10010_sequence.sequences.Seq_Demo_Synopsis.Messages(): Timer.Finish : Timer_GoNextSequence" )
						TppSequence.SetNextSequence( "Seq_Demo_ReadyFuneral" )
					end,
				},
			},
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Synopsis.OnLeave()" )
		StorySummarySystem.RequestClose()
	end,
}


this.sequences.Seq_Demo_ReadyFuneral = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ReadyFuneral.OnEnter(): self:" .. tostring( self ) )
		TppGameStatus.Set( "s10010_sequence", "S_DISABLE_PLAYER_PAD" )
		s10010_demo.PlayReadyFuneral{ onEnd = function() TppSequence.SetNextSequence( "Seq_Game_SelectGender" ) end, }
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ReadyFuneral.OnLeave()" )

		this.WarpPlayerForMbDemo()
	end,
}

this.sequences.Seq_Game_SelectGender = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "GenderMenuOpened",
					func = function()
						
						if TppUiCommand.IsAvatarEditReady() then
							TppUiCommand.EndAvatarEdit()
						end
					end,
				},
				{
					msg = "GenderMenuSelected",
					func = function( result )
						if result == GenderMenuResult.Cancel then
							
							
						else
							svars.selectedGender = result
							mvars.selectedGender = result
							TppMusicManager.PlaySceneMusic( "Stop_p10_000010_name" )
						end
					end,
				},
				{
					msg = "EndFadeIn", sender = "FadeInOnOpenAvatarEdit",
					func = function()
						mvars.fadeInOnOpenAvatarEditEnd = true
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOnSelectGender",
					func = function()
						AvatarMenuSystem.RequestCloseGenderMenu()
						mvars.startLoadingPlayer = true
					end,
				},
			},
			nil,
		}
	end,

	OnEnter = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_SelectGender.OnEnter()" )

		if DebugMenu then
			DebugMenu.SetDebugMenuValue( "Avatar", "UseTrueTextureTimeoutTime", 1 )
		end

		Player.SetPadMask {
			settingName = "avatar_edit_mission",
			except = true,
			sticks = PlayerPad.STICK_R,
		}
		Player.SetAroundCameraManualMode( true )
		Player.SetAroundCameraManualModeParams{
			target = Vector3( 0, 100, 0 ),
			offset = Vector3( 0, 0, 0 ),
		}
		Player.UpdateAroundCameraManualModeParams()
		Player.SetGearVisibility( false )

		TppGameStatus.Set( "AvatarEdit", "S_DISABLE_HUD" )
		TppGameStatus.Set( "AvatarEdit", "S_DISABLE_PLAYER_DAMAGE" )
		TppGameStatus.Set( "AvatarEdit", "S_IS_NO_TIME_ELAPSE_MISSION" )
		TppGameStatus.Set( "AvatarEdit", "S_DISABLE_GAME_PAUSE" )

		TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnOpenAvatarEdit", TppUI.FADE_PRIORITY.SYSTEM )

		mvars.selectedGender		= nil
		mvars.changeAvatarPartsType	= false
		mvars.startLoadingPlayer	= false
		
		AvatarMenuSystem.OpenGenderMenu()
		
		TppMain.EnableGameStatus()
		
		TppSoundDaemon.SetMute( 'Telop' )
	end,

	OnUpdate = function()
		if not mvars.selectedGender then
			return
		end

		if not mvars.fadeInOnOpenAvatarEditEnd then
			return
		end

		if not mvars.changeAvatarPartsType then
			mvars.changeAvatarPartsType = true
			TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnSelectGender", TppUI.FADE_PRIORITY.MISSION )


			if mvars.selectedGender == GenderMenuResult.Female then
				Fox.Log( "### Select Female ###" )
				
				vars.playerType				= PlayerType.AVATAR_FEMALE
				vars.playerPartsType		= PlayerPartsType.AVATAR_WOMAN
			else
				Fox.Log( "### Select Male ###" )
				
				vars.playerType				= PlayerType.AVATAR_MALE
				vars.playerPartsType		= PlayerPartsType.AVATAR_MAN
			end
		end

		if not mvars.startLoadingPlayer then
			return
		end

		
		TppUI.ShowAccessIconContinue()
		
		if not PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE } then
			if not Tpp.IsMaster() then
				GrxDebug.Print2D{ x=100, y=100, size=10, color=Color(1.0,0.2,0.2,1), args={ "Player is not Active..." }, life=1 }
			end
			return
		end

		TppSequence.SetNextSequence( "Seq_Game_InputName" )
	end,

	OnLeave = function()
		TppSoundDaemon.ResetMute( 'Telop' )
		mvars.selectedGender		= nil
		mvars.changeAvatarPartsType	= nil
		mvars.startLoadingPlayer	= nil
	end,
}

this.sequences.Seq_Game_InputName = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "NameEntryMenuButtonPushed",
					func = function()
						TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnInputName", TppUI.FADE_PRIORITY.MISSION )
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOnInputName",
					func = function()
						AvatarMenuSystem.RequestCloseNameEntryMenu()
						TppSequence.SetNextSequence( "Seq_Game_EndPlayerInfoEdit" )
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnInputName", TppUI.FADE_PRIORITY.MISSION )

		AvatarMenuSystem.OpenNameEntryMenu()
		TppSoundDaemon.SetMute( 'Telop' )
	end,
	OnLeave = function ()
		TppSoundDaemon.ResetMute( 'Telop' )
	end,
}

this.sequences.Seq_Game_EndPlayerInfoEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutOnAvatarEditEnd",
					func = function()
						
						AvatarMenuSystem.RequestCloseGenderMenu()
						
						TppSequence.SetNextSequence( "Seq_Game_WaitAvatarLoadAfterGenderSelected" )
						
						TppSoundDaemon.ResetMute( 'Telop' )
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		
		TppSoundDaemon.PostEvent( 'env_custom_end' )
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnAvatarEditEnd", TppUI.FADE_PRIORITY.MISSION )
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_EndAvatarEdit.OnLeave()" )

		vars.isAvatarEditMode = 0
		if this.needSavePlayerType then
			
			TppPlayer.SaveCurrentPlayerType()
		end
		Player.ResetPadMask {
			settingName = "avatar_edit_mission"
		}
		TppUiStatusManager.UnsetStatus( "EquipHud", "INVALID", "s10010_sequence" )
		if TppUiCommand.IsTppUiReady() then
			Fox.Log( "not IsTppUiReady" )
		end
		TppUiCommand.EndAvatarEdit()

		Player.SetGearVisibility( true )
		Player.SetEnableUpdateAvatarInfo( true )
		SsdSbm.ApplyLoadoutToPlayer()
		TppGameStatus.Reset("AvatarEdit", "S_DISABLE_HUD")
		TppGameStatus.Reset("AvatarEdit", "S_DISABLE_PLAYER_DAMAGE")
		TppGameStatus.Reset("AvatarEdit", "S_IS_NO_TIME_ELAPSE_MISSION")
		TppGameStatus.Reset("AvatarEdit", "S_DISABLE_GAME_PAUSE")

		
		
		
		TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.AVATAR_EDIT_END)
	end,
}


this.sequences.Seq_Game_WaitAvatarLoadAfterGenderSelected = {
	OnEnter = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_WaitAvatarLoadAfterGenderSelected.OnEnter()" )

		TppUiCommand.CreateBlendTexture( "PassPort" )
		mvars.avatarWaitCount = 0
	end,

	OnUpdate = function()
		if mvars.avatarWaitCount > 3 and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, } and not TppUiCommand.IsCreatingBlendTexture() then	
			TppSequence.SetNextSequence( "Seq_Demo_WaitAvatarLoadAfterMbGearChanged1" )
		else
			mvars.avatarWaitCount = mvars.avatarWaitCount + 1
		end
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_WaitAvatarLoadAfterGenderSelected.OnLeave()" )
	end,
}

this.sequences.Seq_Demo_WaitAvatarLoadAfterMbGearChanged1 = this.CreateGearChangeSequence( "Seq_Demo_BattleOnMb", GEAR_TABLE_FOR_MB, true, true, "Seq_Demo_WaitAvatarLoadAfterMbGearChanged1",false )


this.sequences.Seq_Demo_BattleOnMb = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_BattleOnMb.OnEnter(): self:" .. tostring( self ) )

		s10010_demo.PlayBattleOnMb{ onEnd = function() TppSequence.SetNextSequence( "Seq_Demo_GzMovie" ) end, }
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_BattleOnMb.OnLeave()" )

		TppGameStatus.Reset( "s10010_sequence", "S_DISABLE_PLAYER_PAD" )

		this.WarpPlayerForMbDemo()
	end,
}


this.sequences.Seq_Demo_GzMovie = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_GzMovie.OnEnter(): self:" .. tostring( self ) )

		TppMovie.Play{
			videoName = "p10_000025",
			isLoop = false,
			onEnd = function()
				TppSequence.SetNextSequence( "Seq_Demo_Burial" )
			end,
			memoryPool = "p10_000025",
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_GzMovie.OnLeave()" )
	end,
}


this.sequences.Seq_Demo_Burial = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_BattleOnMb.OnEnter(): self:" .. tostring( self ) )

		s10010_demo.PlayBurial{ onEnd = function() TppSequence.SetNextSequence( "Seq_Demo_OpenAvatarEdit" ) end, }
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_OpeningMovie.OnLeave()" )
		this.WarpPlayerForMbDemo()
	end,
}


this.sequences.Seq_Demo_OpenAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			Player = {
				{
					msg = "WarpEnd",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_WaitAvatarLoadBeforeAvatarEdit" )
					end,
				},
			},
			Timer = { 
				{
					sender = "StartSelectGenderTimeOut",
					msg = "Finish",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_WaitAvatarLoadBeforeAvatarEdit" )
					end
				}
			}
		}
	end,

	OnEnter = function()
		if DebugMenu then
			DebugMenu.SetDebugMenuValue("Avatar", "UseTrueTextureTimeoutTime", 1)
		end

		this.OnSelectGender( svars.selectedGender )

		
		local position, rotationY = Tpp.GetLocator( "AvatarEditIdentifier", "warp_avatarEdit" )
		GameObject.SendCommand( GameObject.GetGameObjectId( "TppPlayer2", "Player" ), { id = "WarpAndWaitBlock", pos = position, rotY = rotationY } )

		Player.SetPadMask {
			settingName = "avatar_edit_mission",
			except = true,
			sticks = PlayerPad.STICK_R,
		}
		Player.SetAroundCameraManualMode( true )
		Player.SetAroundCameraManualModeParams{
			target = Vector3(0,100,0),
			offset = Vector3(0,0,0),
		}
		Player.UpdateAroundCameraManualModeParams()
		Player.SetGearVisibility( false )

		TppGameStatus.Set("AvatarEdit", "S_DISABLE_HUD")
		TppGameStatus.Set("AvatarEdit", "S_DISABLE_PLAYER_DAMAGE")
		TppGameStatus.Set("AvatarEdit", "S_IS_NO_TIME_ELAPSE_MISSION")
		TppGameStatus.Set("AvatarEdit", "S_DISABLE_GAME_PAUSE")

		GkEventTimerManager.Start( "StartSelectGenderTimeOut", 20 ) 

		TppClock.SetTime( "00:00:00" )
	end,

}


this.sequences.Seq_Game_WaitAvatarLoadBeforeAvatarEdit = {
	OnEnter = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_WaitAvatarLoadBeforeAvatarEdit.OnEnter()" )
	end,

	OnUpdate = function()
		if not mvars.avatarWaitCount then
			mvars.avatarWaitCount = 0
		end
		if mvars.avatarWaitCount > 3 and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, } then
			TppSequence.SetNextSequence( "Seq_Game_StartAvatarEdit" )
		else
			mvars.avatarWaitCount = mvars.avatarWaitCount + 1
		end
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_WaitAvatarLoadBeforeAvatarEdit.OnLeave()" )
	end,
}

this.sequences.Seq_Demo_SelectGenderForAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "GenderMenuOpened",
					func = function()
						
						if TppUiCommand.IsAvatarEditReady() then
							TppUiCommand.EndAvatarEdit()
						end
					end,
				},
				{
					msg = "GenderMenuSelected",
					func = function( result )
						if result == GenderMenuResult.Cancel then
							
							
						else
							mvars.selectedGender = result
						end
					end,
				},
				{
					msg = "EndFadeOut", sender = "FadeOutOnSelectGender",
					func = function()
						AvatarMenuSystem.RequestCloseGenderMenu()
						mvars.startLoadingPlayer = true
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		mvars.selectedGender		= nil
		mvars.changeAvatarPartsType	= false
		mvars.startLoadingPlayer	= false
		
		AvatarMenuSystem.OpenGenderMenu()
		
		TppMain.EnableGameStatus()
		
		TppSoundDaemon.SetMute( 'Telop' )
	end,

	OnUpdate = function()
		if not mvars.selectedGender then
			return
		end

		if not mvars.changeAvatarPartsType then
			this.OnSelectGender( mvars.selectedGender )
			mvars.changeAvatarPartsType = true
			TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnSelectGender", TppUI.FADE_PRIORITY.MISSION )
		end

		if not mvars.startLoadingPlayer then
			return
		end

		
		TppUI.ShowAccessIconContinue()
		
		if not PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE } then
			if not Tpp.IsMaster() then
				GrxDebug.Print2D{ x=100, y=100, size=10, color=Color(1.0,0.2,0.2,1), args={ "Player is not Active..." }, life=1 }
			end
			return
		end
		TppSequence.SetNextSequence( "Seq_Game_StartAvatarEdit" )
	end,

	OnLeave = function()
		mvars.selectedGender		= nil
		mvars.changeAvatarPartsType	= nil
		mvars.startLoadingPlayer	= nil
	end,

}

this.sequences.Seq_Game_StartAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeIn", sender = "FadeInOnAvatarEditStart",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_UpdateAvatarEdit" )
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		mvars.isRequestedFadeIn = false
		
		
		TppUiCommand.LoadAvatarEdit( { type=AvatarEdit.AVATAR_IN_DEMO, presets=this.avatar_edit_presets } )
		
		GrTools.SetSubSurfaceScatterFade( 1.0 )
	end,

	OnUpdate = function()
		if not TppUiCommand.IsAvatarEditReady() then
			if not Tpp.IsMaster() then
				GrxDebug.Print2D{ x=100, y=100, size=10, color=Color(1.0,0.2,0.2,1), args={ "AvatarEditor not Ready..." }, life=1 }
			end
			return
		end
		if not mvars.isRequestedFadeIn then
			TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnAvatarEditStart", TppUI.FADE_PRIORITY.MISSION )
			mvars.isRequestedFadeIn = true
			TppUiCommand.StartAvatarEdit()
			vars.isAvatarEditMode = 1
			
			TppSoundDaemon.PostEvent( 'env_custom' )
			TppSoundDaemon.SetMute( 'Telop' )
		end
	end,

	OnLeave = function ()
		mvars.isRequestedFadeIn = nil
	end,
}

this.sequences.Seq_Game_UpdateAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "AvatarEditEnd",
					func = function()
						if vars.cancelAvatarEdit == 0 then
							
							Fox.Log( "s10010_sequences.Seq_Game_UpdateAvatarEdit.Messages(): UI: AvatarEditEnd" )
							TppSequence.SetNextSequence( "Seq_Game_EndAvatarEdit" )
							this.needSavePlayerType = true
						else
							
							TppSequence.SetNextSequence( "Seq_Demo_SelectGenderForAvatarEdit" )
						end
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		TppUiStatusManager.SetStatus( "EquipHud", "INVALID", "s10010_sequence" )
	end,

}

this.sequences.Seq_Game_EndAvatarEdit = {

	Messages = function( self )
		return
		StrCode32Table {
			UI = {
				{
					msg = "EndFadeOut", sender = "FadeOutOnAvatarEditEnd",
					func = function()
						
						AvatarMenuSystem.RequestCloseGenderMenu()
						
						TppSequence.SetNextSequence( "Seq_Game_WaitAvatarLoad" )
						
						TppSoundDaemon.ResetMute( 'Telop' )
					end,
				},
			},
			nil
		}
	end,

	OnEnter = function()
		
		TppSoundDaemon.PostEvent( 'env_custom_end' )
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeOutOnAvatarEditEnd", TppUI.FADE_PRIORITY.MISSION )
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_EndAvatarEdit.OnLeave()" )

		vars.isAvatarEditMode = 0
		if this.selectedGender then
			vars.playerPartsType = this.selectedGender
		end
		if this.needSavePlayerType then
			
			TppPlayer.SaveCurrentPlayerType()
		end
		Player.ResetPadMask {
			settingName = "avatar_edit_mission"
		}
		TppUiStatusManager.UnsetStatus( "EquipHud", "INVALID", "s10010_sequence" )
		if TppUiCommand.IsTppUiReady() then
			Fox.Log( "not IsTppUiReady" )
		end
		TppUiCommand.EndAvatarEdit()
		Player.SetGearVisibility( true )
		Player.SetEnableUpdateAvatarInfo( true )
		SsdSbm.ApplyLoadoutToPlayer()
		TppGameStatus.Reset("AvatarEdit", "S_DISABLE_HUD")
		TppGameStatus.Reset("AvatarEdit", "S_DISABLE_PLAYER_DAMAGE")
		TppGameStatus.Reset("AvatarEdit", "S_IS_NO_TIME_ELAPSE_MISSION")
		TppGameStatus.Reset("AvatarEdit", "S_DISABLE_GAME_PAUSE")

		
		TppSave.SaveToServer(TppDefine.SERVER_SAVE_TYPE.AVATAR_EDIT_END)

		
		this.WarpPlayerForMbDemo()

		
		GrTools.SetSubSurfaceScatterFade( 0.0 )
	end,
}


this.sequences.Seq_Game_WaitAvatarLoad = {
	OnEnter = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_WaitAvatarLoad.OnEnter()" )
		mvars.avatarWaitCount = 0
		
		
		TppVarInit.SetTutorialPlayerHungerAndThirst()
		
		Player.SetRequestToResetLifeToRecoveryLimit()
		Player.SetRequestToResetStaminaToRecoveryLimit()
	end,

	OnUpdate = function()
		if not mvars.avatarWaitCount then
			mvars.avatarWaitCount = 0
		end
		if mvars.avatarWaitCount > 10 and PlayerInfo.OrCheckStatus{ PlayerStatus.PARTS_ACTIVE, } then
			TppSequence.SetNextSequence( "Seq_Demo_WaitAvatarLoadBeforeSouvenirPhotograph" )
		else
			mvars.avatarWaitCount = mvars.avatarWaitCount + 1
		end
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Game_WaitAvatarLoad.OnLeave()" )
		this.WarpPlayerForMbDemo()
		
		TppMission.UpdateCheckPointAtCurrentPosition()
	end,
}


this.sequences.Seq_Demo_WaitAvatarLoadBeforeSouvenirPhotograph = this.CreateGearChangeSequence( "Seq_Demo_SouvenirPhotograph", GEAR_TABLE_FOR_MB, false, false, "Seq_Demo_WaitAvatarLoadBeforeSouvenirPhotograph", false )


this.sequences.Seq_Demo_SouvenirPhotograph = {
	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_SouvenirPhotograph.OnEnter(): self:" .. tostring( self ) )

		s10010_demo.PlaySouvenirPhotograph{
			onEnd = function()
				TppSequence.SetNextSequence( "Seq_Game_WaitAvatarLoadAfterMbGearChanged2" )
			end,
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_SouvenirPhotograph.OnLeave()" )
	end,
}


this.sequences.Seq_Game_WaitAvatarLoadAfterMbGearChanged2 = this.CreateGearChangeSequence( "Seq_Demo_Wormhole", GEAR_TABLE_FOR_MB, true, false, "Seq_Game_WaitAvatarLoadAfterMbGearChanged2",false )


this.sequences.Seq_Demo_Wormhole = {
	Messages = function( self ) 
		return StrCode32Table{
			Demo = {
				{
					sender = "p10_000040",
					msg = "p10_000040_mask_off",
					func = function()
						Player.SetHeadPartsOff( true )
					end,
					option = { isExecDemoPlaying = true, },
				},
			},
		}
	end,

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Wormhole.OnEnter(): self:" .. tostring( self ) )

		s10010_demo.PlayWormhole{
			onEnd = function()
				TppDemo.SetPlayerPause()
				TppSequence.SetNextSequence( "Seq_Demo_MissionSetting" )
			end,
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Wormhole.OnLeave()" )
	end,
}


this.sequences.Seq_Demo_MissionSetting = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_MissionSetting.OnEnter(): self:" .. tostring( self ) )

		TppMovie.Play{
			videoName = "p10_000045",
			isLoop = false,
			onEnd = function()
				
				TppSequence.ReserveNextSequence( "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1", {} )
				this.SetInitialPlayerPositionForAfgh()
				TppMission.Reload{
					locationCode = TppDefine.LOCATION_ID.AFTR,
					showLoadingTips = false,
					isNoFade = true,
					missionPackLabelName = "s10010_d02",
				}
			end,
			memoryPool = "p10_000045",
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_MissionSetting.OnLeave()" )
	end,
}

this.sequences.Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1 = this.CreateGearChangeSequence( "Seq_Demo_ArriveInAfgh", GEAR_TABLE_FOR_AFGH, false, false, "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged1",false )


this.sequences.Seq_Demo_ArriveInAfgh = {

	Messages = function( self ) 
		return StrCode32Table{
			Demo = {
				{
					sender = "p10_000050",
					msg = "p10_000050_gameModelOn",
					func = function()
						if TppLocation.IsAfghan() then
							afgh_base.SetAfghOpeningAssetVisibility( true )
						end
					end,
					option = { isExecDemoPlaying = true, },
				},
			},
		}
	end,

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ArriveInAfgh.OnEnter(): self:" .. tostring( self ) )

		s10010_demo.PlayArriveInAfgh{ onEnd = function() TppSequence.SetNextSequence( "Seq_Game_Tutorial1" ) end, }
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ArriveInAfgh.OnLeave()" )
	end,
}







this.IsProductionSpear = function()
	local count = SsdSbm.GetCountProduction{ id="PRD_EQP_WP_Spear_A", inInventory=true, inWarehouse=true }
	if count > 0 then
		return true
	end
	return false
end


this.EndTipsCompass = function()
	SsdUiSystem.UnsetScriptFlag( SsdUiScriptFlag.INVISIBLE_THREAT_RING )
end


this.TreasureSetting = function()
	local treasureSettingTableList = {
		"com_treasure_null001_gim_n0001|srt_gim_null_treasure",
		"com_treasure_null001_gim_n0002|srt_gim_null_treasure",
		"com_treasure_null001_gim_n0003|srt_gim_null_treasure",
	}

	for _, treasurePointName in ipairs( treasureSettingTableList ) do
		Fox.Log( "s10010_sequences.TreasureSetting():"..tostring(treasureSettingTableList) )
		Gimmick.SetTreasurePointResources{
			name = treasurePointName,				
			dataSetName = "/Assets/ssd/level/mission/story/s10010/s10010_gimmick.fox2", 
			label = "treasurePoint_name_016",	
			resources = {
				"RES_AmmoBox_01",	
			},
		}
	end
end


this.FullStorageInvisibleGimmick = function()
	local fullStorageInvisibleGimmickTableList = {
		"ssdm_fenc008_vrtn002_gim_n0000|srt_ssdm_fenc008_vrtn002",
		"ssdm_fenc008_vrtn002_gim_n0001|srt_ssdm_fenc008_vrtn002",
	}
	for _, fullStorageInvisibleGimmick in ipairs( fullStorageInvisibleGimmickTableList ) do
		Gimmick.InvisibleGimmick( -1, fullStorageInvisibleGimmick, "/Assets/ssd/level/mission/story/s10010/s10010_gimmick.fox2", true )
	end
end

this.SetInvincibleFence = function( locatorName, enable )
	Fox.Log("Gimmick.SetInvincible")
	Gimmick.SetInvincible{
		gimmickId = "GIM_P_Fence",
		name = locatorName,
		dataSetName = "/Assets/ssd/level/mission/story/s10010/s10010_gimmick.fox2",
		isInvincible = enable,
	}
end
this.GimmickAreaBreak = function( position, radius, locatorName )
	Fox.Log("Gimmick.AreaBreak")
	local pos = Vector3( position )
	local radius = radius
	Gimmick.AreaBreak{
		pos = pos,
		radius = radius,
		effectiveNames = { locatorName, },
	}
end




this.SetupZombie = function( list ,enable, warp, route, speed, tutrial )
	Fox.Log( "s10010_sequences.SetupZombie(): list:".. tostring(list) .. ", enable:" .. tostring( enable ) .. ", warp:" .. tostring( warp ) .. ", route:" .. tostring( route ) )

	for index, zombieSettingTable in ipairs( list ) do
		
		local zombieName = zombieSettingTable.name
		GameObject.SendCommand( GameObject.GetGameObjectId( zombieName ), { id = "SetEnabled", enabled = enable, } )

		local zombieType = zombieSettingTable.zombieType
		local key = zombieSettingTable.key
		if warp and Tpp.IsTypeString( key ) then
			local position, rotY = Tpp.GetLocator( "DataIdentifier_s10010_enemy", key )
			local RotY = TppMath.DegreeToRadian(rotY)
			GameObject.SendCommand( GameObject.GetGameObjectId( zombieType, zombieName ), { id = "Warp", pos = position, rotY = RotY, } )
 		end

		local routeName = zombieSettingTable.routeName
		if route and routeName then
			GameObject.SendCommand( { type = zombieType, }, { id = "SetSneakRoute", name = zombieName, route = routeName, point = 0, } )
		end

		
		local zombieSpeed = zombieSettingTable.zombieSpeed
		if speed and zombieSpeed then
			GameObject.SendCommand( { type= zombieType, }, { id="SetCombatWalkSpeed", speed= zombieSpeed, locatorName= zombieName, } )
			Fox.Log( "s10010_sequences.SetCombatWalkSpeed" )
		else
			Fox.Log( "s10010_sequences.NoSetCombatWalkSpeed" )
		end
		
		if tutrial then
			GameObject.SendCommand( GameObject.GetGameObjectId( zombieType, zombieName ), { id = "SetTutrealZombie", } )
		end
	end
end


this.ResetZombieSpeed = function( list )
	for index, zombieSettingTable in ipairs( list ) do
		local zombieType = zombieSettingTable.zombieType
		local zombieName = zombieSettingTable.name
		if type and locatorName then
			GameObject.SendCommand( { type= zombieType, }, { id="ResetCombatWalkSpeed", locatorName= zombieName, } )
			Fox.Erroe( "s10010_sequences.ResetZombieSpeed():"..tostring(zombieName) )
		else
			Fox.Log( "Failed.s10010_sequences.ResetZombieSpeed()" )
		end
	end
end


this.UnsetZombieRoute = function(list)
	Fox.Log( "s10010_sequences.UnsetZombieRoute" )
	for index, zombieSettingTable in ipairs( list ) do
		local zombieType = zombieSettingTable.zombieType
		local zombieName = zombieSettingTable.name
		local routeName = zombieSettingTable.routeName
		if routeName then
			GameObject.SendCommand( { type = zombieType, }, { id = "SetSneakRoute", name = zombieName, route = "", point = 0, } )
		end
	end
end

this.UnsetNoListZombieRoute = function( zombieType, zombieName )
	Fox.Log( "s10010_sequences.UnsetNoListZombieRoute" )
	GameObject.SendCommand( { type = zombieType, }, { id = "SetSneakRoute", name = zombieName, route = "", point = 0, } )
end


this.SetZombieMissionTarget = function( name, enabled )
	Fox.Log( "Targeting: "..tostring(name) )
	local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", name )
	local command = { id = "SetMissionTarget", enabled = enabled, }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetZombieBreakBody = function( type, locatorName, armR, armL, legR, legL )
	Fox.Log( "s10010_sequences.SetBreakAndWarp"..tostring(locatorName) )
	
	GameObject.SendCommand( { type= type, }, { id="SetBreakBody", locatorName= locatorName, armR = armR, armL = armL, legR = legR, legL = legL, } )
end


this.SetBreakAndWarp = function( type, locatorName, key, armR, armL, legR, legL )
	Fox.Log( "s10010_sequences.SetBreakAndWarp"..tostring(locatorName) )
	
	GameObject.SendCommand( { type= type, }, { id="SetBreakBody", locatorName= locatorName, armR = armR, armL = armL, legR = legR, legL = legL, } )
	
	local position, rotY = Tpp.GetLocator( "DataIdentifier_s10010_enemy", key  )
	local RotY = TppMath.DegreeToRadian(rotY)
	GameObject.SendCommand( GameObject.GetGameObjectId( type, locatorName ), { id = "Warp", pos = position, rotY = RotY, } )
	
	local gameObjectId = GameObject.GetGameObjectId( type, locatorName )
	local command = { id = "SetTutrealZombie", }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetZombieForceAlert = function( list )
	Fox.Log( "s10010_sequences.SetZombieForceAlert" )
	for _, zombieSettingTable in ipairs( list ) do
		local zombieType = zombieSettingTable.zombieType
		local zombieName = zombieSettingTable.name
		local gameObjectId = GameObject.GetGameObjectId( zombieType, zombieName )
		GameObject.SendCommand( gameObjectId, { id = "SetForceAlert", } )
	end
end


this.SetZombieForceWakeUp = function( type, locatorName )
	Fox.Log( "s10010_sequences.SetZombieForceWakeUp" )
	local gameObjectId = GameObject.GetGameObjectId( type, locatorName )
	local playerPos = GameObject.SendCommand( { type="TppPlayer2", index=PlayerInfo.GetLocalPlayerIndex() }, { id="GetFloorPosition", } )
	GameObject.SendCommand( gameObjectId, { id = "SetForceAlert", } )
	GameObject.SendCommand( gameObjectId, { id = "SetForceWakeUp", locatorName=locatorName, pos=playerPos, } )
end


this.SetZombieRoute = function( zombieName, routeName )
	Fox.Log( "s10010_sequences.SetZombieRoute" )
	GameObject.SendCommand( { type = "SsdZombie", }, { id = "SetSneakRoute", name = zombieName, route = routeName, point = 0, } )
end


this.SetZombieForgetThreat = function( zombieType, name )
	Fox.Log( "s10010_sequence.function.SetZombieForgetThreat()" )
	local gameObjectId = { type=zombieType, }
	local command = { id = "ForgetThreat", locatorName = name }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetZombieListForgetThreat = function( list, number )
	if number == 0 then
		for _, forgetthreatlist in ipairs(list) do
			local zombieType = forgetthreatlist.zombieType
			local zombieName = forgetthreatlist.name
			this.SetZombieForgetThreat( zombieType, zombieName )
		end
	elseif number == 1 then
		for _, forgetthreatlist in pairs(list) do
			for _, forgetlist in ipairs(forgetthreatlist) do
				local zombieType = forgetlist.zombieType
				local zombieName = forgetlist.name
				this.SetZombieForgetThreat( zombieType, zombieName )
			end
		end
	end
end



this.SetForceAlertDemoZombie = function()
	Fox.Log( "s10010_sequences.function.SetForceAlertDemoZombie" )
	local gameObjectId = GameObject.GetGameObjectId( "SsdZombieEvent", "zmb_s10010_demo_0000" )
	GameObject.SendCommand( gameObjectId, { id = "SetForceAlert", } )
	GameObject.SendCommand( gameObjectId, { id = "SetForceWakeUp", playerIndex = 0, selectMotion = true } )
	GameObject.SendCommand(  { type="SsdZombieEvent", } , { id="SetCombatWalkSpeed", speed= "walk", locatorName= "zmb_s10010_demo_0000", } )
end

this.SetUpZombieOutOfTheFactory = function()
	Fox.Log( "s10010_sequences.function.SetUpZombieOutOfTheFactory" )
	if svars.isZombieSetUp03 == false then
		
		this.SetupZombie( zombieSettingTableList.IncomingFactory0010, true, true, true, true, true )
		svars.isZombieSetUp03 = true
	end
end

this.ZombieSetEnable = function(type, locatorName, enable)
	Fox.Log( "s10010_sequences.function.ZombieSetEnable" )
	local gameObjectId = GameObject.GetGameObjectId( type, locatorName )
	GameObject.SendCommand( gameObjectId, { id="SetEnabled", enabled=enable } )
end

this.ZombieListSetEnable = function(list, enable)
	Fox.Log( "s10010_sequences.function.ZombieListSetEnable" )
	for _, enableZombieList in ipairs( list ) do
		local type = enableZombieList.zombieType
		local zombieName = enableZombieList.name
		this.ZombieSetEnable(type, zombieName, enable)
	end
end


this.ZombieSleepSetting = function( type, locatorName, pos, rollY, crawl, wake )
	Fox.Log( "s10010_sequences.function.ZombieSleepSetting"..tostring(locatorName)	)
	local gameObjectId = GameObject.GetGameObjectId( type, locatorName )
	local command = { id = "SetSleepZombie", pos=pos, rollY=rollY, crawl=crawl, wake=wake }
	GameObject.SendCommand( gameObjectId, command )
end



this.SetUpZombieBreakWindows = function()
	Fox.Log( "s10010_sequences.function.SetUpZombieBreakWindows" )
	for _, locatorName in pairs(WindowsZombieList) do
		local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", locatorName )
		local command = { id = "SetNoWaitOverFence", enable = true }
		GameObject.SendCommand( gameObjectId, command )
	end
end

this.DisableAllZombiesSeqEscape = function( list )
	for _, DisablezombieList in pairs( list ) do
		Fox.Log( "s10010_sequences.function.DisableAllZombiesSeqEscape:"..tostring(list))
		
		this.SetupZombie( DisablezombieList, false, false, false, false, false )
		
		this.ResetZombieSpeed( DisablezombieList )
	end
end


this.SetUpDemoZombieCreeping = function( enabled )
	local gameObjectId = GameObject.GetGameObjectId( "SsdZombieEvent", "zmb_s10010_demo_0000" )
	local command = { id = "SetDownAttackIdleMode", enable = enabled }
	GameObject.SendCommand( gameObjectId, command )
end

this.SetFixRandVal = function()
	local gameObjectId = GameObject.GetGameObjectId( "SsdZombie", "zmb_s10010_0001" )
	local command = { id = "SetFixRandVal", randVal = 120 }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetZombieForceGrabFence = function( list )
	for _, zombieSettingTable in ipairs( list ) do
		Fox.Log( "s10010_sequences.function.SetZombieForceGrabFence" )
		local zombieType = zombieSettingTable.zombieType
		local zombieName = zombieSettingTable.name
		local gameObjectId = { type=zombieType } 
		local command = { id = "SetForceGrabFence", locatorName= zombieName }
		GameObject.SendCommand( gameObjectId, command )
	end
end


this.SetZombieNoticePosition = function( zombieType, zombieName, noticePosition )
	local position = Vector3( noticePosition )
	local gameObjectId = { type=zombieType } 
	local command = { id = "SetNoticePosition", locatorName= zombieName, pos= position }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetZombieNoticePosition = function( zombieType, zombieName, combatPosition )
	local position = Vector3( combatPosition )
	local gameObjectId = { type= zombieType } 
	local command = { id = "SetCombatPosition", locatorName= zombieName, pos= position }
	GameObject.SendCommand( gameObjectId, command )
end


this.SetIgnoreNotice = function( list, notice )
	for index, zombieSettingTable in ipairs( list ) do
		Fox.Log( "s10010_sequences.SetIgnoreNotice:"..tostring(list)..","..tostring(notice) )
		local zombieName = zombieSettingTable.name
		local zombieType = zombieSettingTable.zombieType
		local gameObjectId = GameObject.GetGameObjectId( zombieType, zombieName )
		local command = { id="SetIgnoreNotice", enabled = notice, }
		GameObject.SendCommand( gameObjectId, command )
	end
end

this.SetIgnoreNoticeForList = function( list, notice )
	for _, Noticezombielist in pairs( list ) do
		this.SetIgnoreNotice( Noticezombielist, notice )
	end
end

this.SetZombieIgnoreNotice = function( zombieType, zombieName, notice )
	Fox.Log( "s10010_sequences.SetZombieIgnoreNotice: type:"..tostring(zombieType).."zombieName,"..tostring(zombieName).."notice:"..tostring(notice) )
	local gameObjectId = GameObject.GetGameObjectId( zombieType, zombieName )
	local command = { id="SetIgnoreNotice", enabled = notice, }
	GameObject.SendCommand( gameObjectId, command )
end



this.SetZombieVoice = function( sourceName, enable)
	local daemon = TppSoundDaemon.GetInstance()

	if enable == true then
		
		daemon:RegisterSourceEvent{
			sourceName = sourceName,
			tag = "Loop",
			playEvent = "sfx_e_zmb_voices",
			stopEvent = "Stop_sfx_e_zmb_voices",
		}
	elseif enable == false then
		
		daemon:UnregisterSourceEvent{
			sourceName = sourceName,
			tag = "Loop",
			playEvent = "sfx_e_zmb_voices",
			stopEvent = "Stop_sfx_e_zmb_voices",
		}
	end
end






this.sequences.Seq_Game_Tutorial1 = {
	OnEnter = function()
		Fox.Log( "s10010_sequences.Seq_Game_Tutorial1.OnEnter()" )
		
		
		TppUiStatusManager.SetStatus( "AnnounceLog","INVALID_LOG", "s10010_sequence" )
		
		
		
		vars.playerDisableActionFlag = PlayerDisableAction.MB_TERMINAL+ PlayerDisableAction.RIP_OUT+ PlayerDisableAction.CQC+ PlayerDisableAction.FULTON
		
		TppVarInit.SetTutorialPlayerHungerAndThirst()
		
		Player.SetRequestToResetLifeToRecoveryLimit()
		Player.SetRequestToResetStaminaToRecoveryLimit()
		
		Player.RequestToSetCameraRotation {
			
			rotX = 0,
			
			rotY = 200,
			
			interpTime = 0
		}
		
		SsdSbm.RemoveFromPlayerLoadout( PlayerSlotTypeSsd.PRIMARY_1 )
		
		SsdSbm.AddExperiencePoint( 1000 )
		
		SsdSbm.AddRecipe( "RCP_EQP_WP_Spear_A" )
		
		this.DisableAllZombiesSeqEscape( zombieSettingTableList )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_OXYGEN )
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_HUNGER )
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.INVISIBLE_PLAYER_HUD_THIRST )
		
		TppUiStatusManager.SetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )

		
		TppUI.FadeIn( TppUI.FADE_SPEED.FADE_NORMALSPEED, "FadeInOnTutorial1Start", TppUI.FADE_PRIORITY.MISSION )
	end,

	Messages = function( self )
		return StrCode32Table {
			Player = {
				{
					msg = "OnPlayerElude", 
					func = function()
						if not svars.control_guide_elude then
							
							TppUI.ShowControlGuide{
								actionName = "ELUDE_UP", 
								time = 3.0,
								continue = false
							}
							svars.control_guide_elude = true 
						end
					end,
				},
			},
			Trap = {
				
				{
					sender = "trap_0002_disp_life",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isTipsLife == false then
							if svars.isStartRadioFinish == true then
								
								TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_LIFE )
								GkEventTimerManager.Start( "TimerEnableLifeAndEquip", 4 )
							else
								GkEventTimerManager.Start( "TimerWaitRadioLife", 1 )
							end
							svars.isTipsLife = true
						end
					end,
				},
				{
					sender = "trap_0004_beyond_athletic",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isTipsAction == false then
							Fox.Log( "trap_0004_beyond_athletic.Enter" )
							if TppTutorial.IsHelpTipsMenu() then
								
								TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_ACTION )
							else
								GkEventTimerManager.Start( "TimerWaitTipsAthletic", 1 )
							end
							svars.isTipsAction = true
						end
					end,
				},
				
				{
					sender = "trap_0000_control_guide_camera",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.control_guide_camera then
							
							TppUI.ShowControlGuide{
								actionName = "CAMERA_MOVE", 
								time = 3.0,
								continue = false,
							}
							svars.control_guide_camera = true
						end
					end,
				},
				{
					sender = "trap_0001_control_guide_jump",
					msg = "Enter",
					func = function( trapName, gameObjectId )
					end,
				},
				{
					sender = "trap_0001_marker_01_jump",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.ismarker_jump then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001_01", }, }
							svars.ismarker_jump = true
						end
					end,
				},
				{
					sender = "trap_0001_marker_02_elude",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.marker_elude then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001_02", }, }
							svars.marker_elude = true
						end
					end,
				},
				{
					sender = "trap_0001_marker_03_Return",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.ismarker_return then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001_03", }, }
							svars.ismarker_return = true
						end
					end,
				},
				{
					sender = "trap_0001_marker_04_FactoryOuter",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.ismarker_FactoryOuter then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001_04", }, }
							svars.ismarker_FactoryOuter = true
						end
					end,
				},
				{
					sender = "trap_0001_marker_05_FactoryEntrance",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.ismarker_FactoryEntrance then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001_05", }, }
							svars.ismarker_FactoryEntrance = true
						end
					end,
				},
				{
					sender = "trap_0001_marker_06_FactoryInner",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.ismarker_FactoryInner then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001_06", }, }
							svars.ismarker_FactoryInner = true
						end
					end,
				},
				{
					sender = "trap_radio_0000",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.isRadio_RuinsFactory then
							TppRadio.Play( "f3010_rtrg0026" )
							svars.isRadio_RuinsFactory = true
						end
					end,
				},
				{
					sender = "trap_radio_0003",
					msg = "Enter",
					func = function( trapName, gameObjectId )
					end,
				},
			},
			UI = {
				{  
					msg = "EndFadeIn", sender = "FadeInOnTutorial1Start",
					func = function()
						GkEventTimerManager.Start( "TimerEndFadeInMissionStart", 1 )
					end,
				},
			},
			Timer = {
				{	
					msg = "Finish",
					sender = "TimerEndFadeInMissionStart",
					func = function()
						if svars.isStartRadioFinish == false then
							
							if not svars.isRadio_Equipment then
								TppRadio.Play( "f3010_rtrg0024" )
								svars.isRadio_Equipment = true
							end
							
							TppUI.ShowControlGuide{
								actionName = "PLAY_MOVE", 
								time = 3.0,
								continue = false
							}
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0001", }, }
							svars.isStartRadioFinish = true
						end
					end
				},
				{	
					msg = "Finish",
					sender = "TimerWaitRadioLife",
					func = function()
						if svars.isStartRadioFinish == true then
							
							TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_LIFE )
							GkEventTimerManager.Start( "TimerEnableLifeAndEquip", 4 )
						else
							GkEventTimerManager.Start( "TimerWaitRadioLife", 1 )
						end
					end
				},
				{	
					msg = "Finish",
					sender = "TimerEnableLifeAndEquip",
					func = function()
						
						TppUiStatusManager.UnsetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )
					end
				},
				{	
					msg = "Finish",
					sender = "TimerWaitTipsAthletic",
					func = function()
						if TppTutorial.IsHelpTipsMenu() then
							GkEventTimerManager.Start( "TimerWaitTipsAthletic", 1 )
						else
							TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_ACTION )
						end
					end
				},
			},
		}
	end,


	OnLeave = function ()
		
		TppUiStatusManager.UnsetStatus( "AnnounceLog", "INVALID_LOG", "s10010_sequence" )
	end,
}





this.sequences.Seq_Demo_ReeveEncounter = {
	Messages = function( self )
		return StrCode32Table {
			UI = {
				{
					msg = "EndFadeOut", sender = "StartDemoReeveEncounterFadeOut",
					func = function()
						s10010_demo.PlayEncountReeve{
							onSkip = function()
								Fox.Log( "onSkip.Demo_ReeveEncounter.p10_000056_GameModelOn" )
								
								this.ZombieSleepSetting( "SsdZombieEvent", "zmb_s10010_demo_0000", {-261.4617,288.5001,2467.989}, 240.0, 1, 0 )
								
								this.SetZombieBreakBody( "SsdZombieEvent", "zmb_s10010_demo_0000", 0, 0, 1, 1 )
								
								this.SetForceAlertDemoZombie()
								
								this.SetUpDemoZombieCreeping( true )
								
								svars.isEscape_ContinueCheck = true
								
								SsdSbm.AddWeaponForTutorial{ id="PRD_EQP_WP_hg00", ammoCount= 13, }
							end,
							onEnd = function()
								
								TppSound.SetSceneBGM( "bgm_escape" )
								TppSequence.SetNextSequence( "Seq_Game_Tutorial2_Escape" )
								
								Mission.ResetCrew()
							end,
						}
					end,
				},
			},
			Demo = {
				{	
					msg = "p10_000056_GameModelOn",
					func = function()
						Fox.Log( "Message.Demo_ReeveEncounter.p10_000056_GameModelOn" )
						
						this.ZombieSleepSetting( "SsdZombieEvent", "zmb_s10010_demo_0000", {-261.4617,288.5001,2467.989}, 240.0, 1, 0 )
						
						this.SetZombieBreakBody( "SsdZombieEvent", "zmb_s10010_demo_0000", 0, 0, 1, 1 )
						
						this.SetUpDemoZombieCreeping( true )
						
						this.SetForceAlertDemoZombie()
						
						SsdSbm.AddWeaponForTutorial{ id="PRD_EQP_WP_hg00", ammoCount= 13, }
					end,
					option = { isExecDemoPlaying = true },
				},
			},
		}
	end,
	OnEnter = function( self )
		Fox.Log( "s10010_sequence.Seq_Demo_ReeveEncounter.OnEnter(): self:" .. tostring( self ) )
		TppUI.FadeOut( TppUI.FADE_SPEED.FADE_HIGHESTSPEED, "StartDemoReeveEncounterFadeOut" )
		Player.RequestToSetTargetStance(PlayerStance.STAND) 

		
		local demoEnemyList = {
			"zmb_s10010_demo_0000",
		}
		TppDemo.SpecifyIgnoreNpcDisable( demoEnemyList )
	end,
	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ReeveEncounter.OnLeave()" )
		
		TppMission.UpdateCheckPointAtCurrentPosition()
	end,
}




this.sequences.Seq_Game_Tutorial2_Escape = {
	Messages = function( self )
		return StrCode32Table {
			Trap = {
				
				
				
				{	
					sender = "trap_zombie_spawn0010",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isZombieSetUp10 == false then
							

							this.SetZombieForceWakeUp( "SsdZombie", "zmb_s10010_0042" )
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0003", }, }
							
							this.SetupZombie( zombieSettingTableList.WindowsAisle_Right, true, true, true, true, true )
							this.SetupZombie( zombieSettingTableList.WindowsAisle_ExitDemoRoom, true, true, true, true, true )
							
							this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_0025", true )
							
							GkEventTimerManager.Start( "Timer_zmb_s10010_0025_Notice", 2.0 )
							svars.isZombieSetUp10 = true
						end
						if svars.isZombieFanceArea0000 == false then
							
							
							
							
							svars.isZombieFanceArea0000 = true
						end
					end,
				},
				{	
					sender = "trap_location_0006_AisleMiddle0002",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isWindowZombieAttack00 == false then
							
							this.SetupZombie( zombieSettingTableList.WindowsAisle_Surprise0010, true, true, true, true, true )
							
							this.SetZombieForceGrabFence( zombieSettingTableList.FenceArea_NearestTheEntrance )
							this.SetZombieForceGrabFence( zombieSettingTableList.FenceArea_NearestTheEntranceNo2 )
							this.SetZombieForceGrabFence( zombieSettingTableList.FenceArea_InFences0020 )
							
							GkEventTimerManager.Start( "TimerWindowsAisleNoticeOn", 2.0 )
							svars.isWindowZombieAttack00 = true
						end
					end,
				},
				{	
					sender = "trap_location_0006_AisleMiddle",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isAisleZombieAttack00 == false then
							this.SetZombieRoute( "zmb_s10010_0026", "rts_s10010_0026_0001" )
							this.SetZombieRoute( "zmb_s10010_0027", "rts_s10010_0027_0001" )
							
							this.SetupZombie( zombieSettingTableList.FenceArea_NearestTheEntrance, true, true, true, true, true )
							this.SetupZombie( zombieSettingTableList.FenceArea_independentZombie0010, true, true, true, true, true )
							this.SetupZombie( zombieSettingTableList.FenceArea_NearestTheEntranceNo2, true, true, true, true, true )
							svars.isAisleZombieAttack00 = true
						end
						
						if svars.isInAisleMiddleArea == false then
							
							svars.isInAisleMiddleArea = true
						end
					end,
				},
				{	
					sender = "trap_zombie_spawn0007",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieSetUp07 == false then
							this.SetupZombie( zombieSettingTableList.FenceArea_WindowSurprise, true, true, true, true, true )
							
							this.SetBreakAndWarp( "SsdZombie",	"zmb_s10010_infc_0012", "warp_s10010_infc_0012", 1, 0, 1, 0 )
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0004", }, }
							GkEventTimerManager.Start( "TimerSetIgnorenoticeOFF", 4.0 )
							svars.isZombieSetUp07 = true
						end
						
						if svars.isZombieSetUpOutOfFact == true and svars.isDisableZombieOutOfFact == false then
							this.SetupZombie( zombieSettingTableList.OutOfFactoryZombies0010, false, false, false, false, false )
							svars.isDisableZombieOutOfFact = true
						end
					end,
				},
				{	
					sender = "trap_radio_0002",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isFenceAreaRadio00 == false then
							
							TppRadio.Play( "f3010_rtrg0032" )
							svars.isFenceAreaRadio00 = true
						end
					end,
				},
				{	
					sender = "trap_zombie_spawn0008",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieSetUp08 == false then
							this.SetupZombie( zombieSettingTableList.FenceArea_InFences0020, true, true, true, true, true )
							this.SetupZombie( zombieSettingTableList.FenceArea_independentZombie0020, true, true, true, true, true )
							svars.isZombieSetUp08 = true
						end
					end,
				},
				{	
					sender = "trap_zombie_spawn0011",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isZombieSetUp11 == false then
							
							this.GimmickAreaBreak( {-263.239, 288.693, 2452.655}, 3, "mafr_door006_gim_n0003|srt_mafr_door006" )
							
							local position = Vector3( -266.541, 290.796, 2452.485 )
							TppSoundDaemon.PostEvent3D( "sfx_m_brk_door_ev", position )
							
							this.SetupZombie( zombieSettingTableList.WindowAisle_WaitingToThroughPlayer, true, true, true, true, true )
							
							this.SetZombieForceGrabFence( zombieSettingTableList.WindowAisle_WaitingToThroughPlayer )
							
							this.SetIgnoreNotice( zombieSettingTableList.WindowAisle_WaitingToThroughPlayer, true )
							
							this.SetZombieForceWakeUp( "SsdZombie", "zmb_s10010_infc_0012" )
							
							svars.isZombieSetUp11 = true
						end
					end,
				},
				{	
					sender = "trap_zombie_spawn0002",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieSetUp02 == false then
							
							this.SetupZombie( zombieSettingTableList.WaitingDemoRoomZombie0010, true, true, true, true, true )
							svars.isZombieSetUp02 = true
						end
					end,
				},
				{	
					sender = "trap_0022_FenceDown",
					msg = "Enter",
					func = function( trapName, gameObjectId )
							Fox.Log( "s10010_sequence.trap.Enter.trap_0022_FenceDown" )
					end,
				},
				{	
					sender = "trap_zombie_spawn0009",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isZombieSetUp09 == false then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0005", }, }
							Fox.Log( "s10010_sequence.trap.Enter.trap_zombie_spawn0009()" )
							
							svars.isZombieSetUp09 = true
						end
						if svars.isSetInvincibleFence0004 == false then
							
							this.SetInvincibleFence( "fen0_main8_def_gim_n0004|srt_fen0_main8_def", false )
							
							this.SetIgnoreNotice( zombieSettingTableList.FenceArea_NearestTheEntranceNo2, false )
							svars.isSetInvincibleFence0004 = true
						end
						if svars.isSetInvincibleFence0013 == false then
							
							this.SetInvincibleFence( "fen0_main8_def_gim_n0013|srt_fen0_main8_def", false )
							svars.isSetInvincibleFence0013 = true
						end
					end,
				},
				{	
					sender = "trap_zombie_spawn0005",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieSetUp05 == false then
							this.SetupZombie( zombieSettingTableList.FenceArea_IncomingFromAisle, true, true, true, true, true )
							
							this.SetBreakAndWarp( "SsdZombie", "zmb_s10010_0041", "warp_s10010_0041", 0, 0, 1, 0 )
							
							this.SetInvincibleFence( "fen0_main8_def_gim_n0000|srt_fen0_main8_def", false )
							svars.isZombieSetUp05 = true
						end
					end,
				},
				{	
					sender = "trap_zombie_spawn0006",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieSetUp06 == false then
							
							this.SetupZombie( zombieSettingTableList.FenceArea_WaitingBasementEntrance0010, true, true, true, true, true )
							this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_infc_0007", true )
							
							GkEventTimerManager.Start( "Timerzmb_s10010_infc_0007NoticeOn", 3.0 )
							this.SetupZombie( zombieSettingTableList.AttackCatWalkZombies0010, true, true, true, true, true )
							
							this.SetBreakAndWarp( "SsdZombie", "zmb_s10010_infc_0007_1", "warp_s10010_infc_0007_1", 0, 0, 1, 0 )
						end
						
						if svars.isAisleZombieAttack02 == false then
							this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_0041", false )
							this.SetZombieForceWakeUp( "SsdZombie", "zmb_s10010_0041" )
							svars.isAisleZombieAttack02 = true
						end
					end,
				},
				{	
					sender = "trap_location_0005_CWLatterHalf",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieWakeUpThroughCatWalk == false then
							
							this.SetZombieForceWakeUp( "SsdZombie", "zmb_s10010_infc_0007_1" )
							
							GkEventTimerManager.Start( "TimerDisableInvincibleFence0007", 15.0 )
							svars.isZombieWakeUpThroughCatWalk = true
						end
					end,
				},
				{	
					sender = "trap_0023_noAmmoRadioArea",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						svars.isNoAmmoRadioArea = true
					end,
				},
				{	
					sender = "trap_0011_basement_entrance",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0006", }, }
					end,
				},
				{	
					sender = "trap_0019_middle_basement",
					msg = "Enter",
					func = function( trapName, gameObjectId )
					end,
				},
				{	
					sender = "trap_zombie_spawn0004",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isZombieSetUp04 == false then
							
							this.SetupZombie( zombieSettingTableList.FenceArea_WaitingBasementEntrance0020, true, true, true, true, true )
							svars.isZombieSetUp04 = true
						end
					end,
				},
				{	
					sender = "trap_0018_demo_reunion_reeve",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Demo_ReunionReeve" ) then
							TppSequence.SetNextSequence( "Seq_Demo_ReunionReeve" )
						end
					end,
				},
				
				
				
				{	
					sender = "trap_zombie_spawn0003",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isZombieSetUpOutOfFact == false then
							
							this.SetUpZombieOutOfTheFactory()
							
							this.SetupZombie( zombieSettingTableList.OutOfFactoryZombies0010, true, true, true, true, true )
							
							svars.isZombieSetUpOutOfFact = true
						end
					end,
				},
				{	
					sender = "trap_0021_ZombieNoticeOn",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						Fox.Log("Trap.Enter.trap_location_0008_DemoRoom_KillArea")
						if svars.isZombieNoticeOnFlag == false then
							if svars.isZombieNoticeOnCount < 1 then
								Fox.Log("isZombieNoticeOnCount+1")
								svars.isZombieNoticeOnCount = svars.isZombieNoticeOnCount + 1
							elseif svars.isZombieNoticeOnCount <= 1 then
								Fox.Log("isZombieNoticeOnCount<=1!!NoticeOn!!")
								
								this.SetIgnoreNotice( zombieSettingTableList.WindowAisle_WaitingToThroughPlayer, false )
								svars.isZombieNoticeOnFlag = true
							end
						end
					end,
				},
				
				
				
				{	
					sender = "trap_location_0008_DemoRoom_KillArea",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isInDemoRoomKillArea == false then
							
							svars.isInDemoRoomKillArea = true
							Fox.Log("Trap.Enter.trap_location_0008_DemoRoom_KillArea")
						end
					end,
				},
				{	
					sender = "trap_location_0008_DemoRoom_KillArea",
					msg = "Exit",
					func = function( trapName, gameObjectId )
						if svars.isInDemoRoomKillArea == true then
							Fox.Log("Trap.Exit.trap_location_0008_DemoRoom_KillArea")
							
							this.SetZombieVoice( "POINT_ZMB_VOICES_B",false )
							
							svars.isInDemoRoomKillArea = false
						end
					end,
				},
				{	
					sender = "trap_location_0000_demoroom",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isInEncounterReeveRoom == false then
							
							svars.isInEncounterReeveRoom = true
						end
					end,
				},
				{	
					sender = "trap_location_0000_demoroom",
					msg = "Exit",
					func = function( trapName, gameObjectId )
						if svars.isInEncounterReeveRoom == true then
							
							svars.isInEncounterReeveRoom = false
						end
					end,
				},
				{	
					sender = "trap_location_0006_AisleMiddle",
					msg = "Exit",
					func = function( trapName, gameObjectId )
						if svars.isInAisleMiddleArea == true then
							
							svars.isInAisleMiddleArea = false
						end
					end,
				},
				{	
					sender = "trap_0020_treasure0002",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						svars.isFence0005Break = true
						Fox.Log( "s10010_sequence.trap.Enter.trap_0020_treasure0002" )
						if svars.isSetInvincibleFence0004 == false then
							
							this.SetIgnoreNotice( zombieSettingTableList.FenceArea_NearestTheEntranceNo2, false )
							
							this.SetInvincibleFence( "fen0_main8_def_gim_n0004|srt_fen0_main8_def", false )
							svars.isSetInvincibleFence0004 = true
						end
					end,
				},
				{	
					sender = "trap_0020_treasure0002",
					msg = "Exit",
					func = function( trapName, gameObjectId )
						Fox.Log( "s10010_sequence.trap.Exit.trap_0020_treasure0002" )
						
						svars.isFence0005Break = false
					end,
				},
				{	
					sender = "trap_location_0001_CatWalkAllArea",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if svars.isPlayerOnTheCatWalk == false then
							
							GkEventTimerManager.Start( "TimerOntheCatWalk", 45.0 )
							
							svars.isPlayerOnTheCatWalk = true
						end
					end,
				},
				{	
					sender = "trap_location_0001_catwalk",
					msg = "Exit",
					func = function( trapName, gameObjectId )
						if svars.isPlayerOnTheCatWalk == true then
							
							svars.isPlayerOnTheCatWalk = false
						end
					end,
				},
			},
			Timer = {
				{	
					msg = "Finish",
					sender = "TimerDisableCreeping",
					func = function()
						
						this.SetUpDemoZombieCreeping( false )
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerLimitDemoZombieKill",
					func = function()
						if svars.isDemoZombieKilled == false then
							if svars.isInEncounterReeveRoom == false then
							end
						end
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerWindowsAisleNoticeOn",
					func = function()
						
						this.SetIgnoreNoticeForList( AisleNoticeOnOffList, false )
					end,
				},
				{	
					msg = "Finish",
					sender = "Timer_zmb_s10010_0025_Notice",
					func = function()
						
						this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_0025", false )
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerSetIgnorenoticeOFF",
					func = function()
						
						this.SetIgnoreNotice( zombieSettingTableList.FenceArea_NearestTheEntrance, false )
					end,
				},
				{	
					msg = "Finish",
					sender = "Timerzmb_s10010_infc_0007NoticeOn",
					func = function()
						
						this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_infc_0007", false )
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerDestroyfence0004",
					func = function()
						
						this.GimmickAreaBreak( {-280.551, 288.524, 2453.537}, 5, "fen0_main8_def_gim_n0004|srt_fen0_main8_def" )
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerDisableInvincibleFence0007",
					func = function()
						this.SetInvincibleFence( "fen0_main8_def_gim_n0007|srt_fen0_main8_def", false )
						this.SetInvincibleFence( "fen0_main8_def_gim_n0008|srt_fen0_main8_def", false )
						this.SetInvincibleFence( "fen0_main8_def_gim_n0010|srt_fen0_main8_def", false )
						this.SetInvincibleFence( "fen0_main8_def_gim_n0012|srt_fen0_main8_def", false )
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerDestroyDoor",
					func = function()
						
						if svars.isInEncounterReeveRoom == true then
							Fox.Log("Gimmick.AreaBreak")	
							
							this.GimmickAreaBreak( {-283.695, 288.469, 2477.556}, 2, "mafr_door006_gim_n0001|srt_mafr_door006" )
							
							local position = Vector3( -268.528, 290.908, 2470.865 )
							TppSoundDaemon.PostEvent3D( "sfx_m_brk_door_ev", position )
							
							this.SetZombieVoice( "POINT_ZMB_VOICES_B",true )
						
						elseif svars.isInEncounterReeveRoom == false then
							
							this.GimmickAreaBreak( {-283.695, 288.469, 2477.556}, 2, "mafr_door006_gim_n0001|srt_mafr_door006" )
							
							local position = Vector3( -283.020, 288.502, 2478.030 )
							TppSoundDaemon.PostEvent3D( "sfx_m_brk_door_ev", position )
						end
					end,
				},
				{	
					msg = "Finish",
					sender = "TimerOntheCatWalk",
					func = function()
						
						if svars.isPlayerOnTheCatWalk == true then
							
							this.UnsetZombieRoute(zombieSettingTableList.IncomingDemoRoom0030)
							this.UnsetZombieRoute(zombieSettingTableList.WaitingDemoRoomZombie0010)
							this.UnsetZombieRoute(zombieSettingTableList.FenceArea_WaitingBasementEntrance0020)
							this.UnsetZombieRoute(zombieSettingTableList.FenceArea_IncomingFromAisle)
							this.UnsetZombieRoute(zombieSettingTableList.WindowsAisle_ExitDemoRoom)
							this.UnsetZombieRoute(zombieSettingTableList.WindowAisle_WaitingToThroughPlayer)
						
						elseif svars.isPlayerOnTheCatWalk == false then
							
							GkEventTimerManager.Start( "TimerOntheCatWalk", 30.0 )
						end
					end,
				},
			},
			Player = {	
				{
					msg = "OnAmmoStackEmpty",
					func = function( )
						Fox.Log("s10010.Message.Player.OnAmmoStackEmpty")
						if svars.isOutOfAmmoRadio == false then
							if svars.isNoAmmoRadioArea == false then
								TppRadio.Play( "f3010_rtrg0058" )
								svars.isOutOfAmmoRadio = true
							end
						end
					end,
				},
			},
			GameObject = {
				{
					msg = "Dead",
					func = function( gameObjectId )
						local zombieDeadCount = 0
						if svars.isInDemoRoomKillArea == true then
							
							if gameObjectId == GetGameObjectId( "zmb_s10010_demo_0000") then
								Fox.Log( "zmb_s10010_0006.ChangeWaveA'sRoute" )
								this.SetupZombie( zombieSettingTableList.IncomingDemoRoom0010, true, true, true, true, true )
							end
							
							if gameObjectId == GetGameObjectId( "zmb_s10010_0002") or gameObjectId == GetGameObjectId( "zmb_s10010_0000") or gameObjectId == GetGameObjectId( "zmb_s10010_xof_0005") then
								svars.isdemoRoomZombieDeadCount = svars.isdemoRoomZombieDeadCount + 1
								if svars.isdemoRoomZombieDeadCount == 2 then
									this.SetupZombie( zombieSettingTableList.IncomingDemoRoom0020, true, true, true, true, true )
								end
							end
						end
					end,
				},
				{
					msg = "RoutePoint2",
					func = function( gameObjectId )
						if gameObjectId == GetGameObjectId( "zmb_s10010_xof_0007") then
							Fox.Log( "zmb_s10010_xof_0007.RouteRevocation" )
							this.UnsetZombieRoute(zombieSettingTableList.AttackCatWalkZombies0010)
						elseif gameObjectId == GetGameObjectId( "zmb_s10010_infc_0010") then
							Fox.Log( "zmb_s10010_infc_0010.RouteRevocation" )
							this.UnsetNoListZombieRoute( "SsdZombie", "zmb_s10010_infc_0010" )
						elseif gameObjectId == GetGameObjectId( "zmb_s10010_infc_0014") then
							Fox.Log( "zmb_s10010_infc_0010.RouteRevocation" )
							this.UnsetNoListZombieRoute( "SsdZombie", "zmb_s10010_infc_0014" )
						end
					end,
				},
				{	
					msg = "BreakGimmick",
					func = function( gameObjectId, locatorName, upperLocatorName, on )
						
						if locatorName == Fox.StrCode32( "fen0_main8_def_gim_n0013|srt_fen0_main8_def" ) then
							
							this.SetIgnoreNotice( zombieSettingTableList.FenceArea_InFences0020, false )
						end
					end,
				},
			},
			Sbm = {
				{	
					msg = "OnGetItem",
					func = function( resourceIdCode, inventoryItemType, type, num )
						
						if resourceIdCode == Fox.StrCode32( "RES_AmmoBox_01" ) then
							if svars.isFence0005Break == true then
								if svars.isSetInvincibleFence0013 == false then
									
									this.SetInvincibleFence( "fen0_main8_def_gim_n0013|srt_fen0_main8_def", false )
									
									GkEventTimerManager.Start( "TimerDestroyfence0004", 2.0 )
									svars.isSetInvincibleFence0013 = true
								end
							end
						end
					end,
				},
			},
		}
	end,



	OnEnter = function()
		Fox.Log( "s10010_sequences.Seq_Game_Tutorial2_Escape.OnEnter()" )
		
		
		
		
		if not svars.control_guide_shoot then
			TppUI.ShowControlGuide{
				actionName = "ATTACK", 
				time = 5.0,
				continue = false
			}
			svars.control_guide_shoot = true
		end
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.INVISIBLE_THREAT_RING )
		
		SsdUiSystem.Lock( SsdUiLockType.FACILITY_PANEL )
		
		TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0002", }, }

		
		Gimmick.SetAllUnitGaugeOff( true )
		vars.playerDisableActionFlag = PlayerDisableAction.MB_TERMINAL+ PlayerDisableAction.RIP_OUT+ PlayerDisableAction.CQC+ PlayerDisableAction.FULTON
		
		TppUiStatusManager.UnsetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )

		
		
		
		
		TppRadio.Play( "f3010_rtrg0028" )

		
		
		
		
		this.SetInvincibleFence( "fen0_main8_def_gim_n0000|srt_fen0_main8_def", true )
		this.SetInvincibleFence( "fen0_main8_def_gim_n0004|srt_fen0_main8_def", true )
		this.SetInvincibleFence( "fen0_main8_def_gim_n0007|srt_fen0_main8_def", true )
		this.SetInvincibleFence( "fen0_main8_def_gim_n0008|srt_fen0_main8_def", true )
		this.SetInvincibleFence( "fen0_main8_def_gim_n0010|srt_fen0_main8_def", true )
		this.SetInvincibleFence( "fen0_main8_def_gim_n0012|srt_fen0_main8_def", true )
		this.SetInvincibleFence( "fen0_main8_def_gim_n0013|srt_fen0_main8_def", true )
		
		this.TreasureSetting()
		
		
		
		
		if svars.isEscape_ContinueCheck == true then
			
			Player.RequestToSetCameraRotation {
				
				rotX = 22,
				
				rotY = 80,
				
				interpTime = 0
			}
			
			TppSound.SetSceneBGM( "bgm_escape" )
			Fox.Log( "Seq_Game_Tutorial2_Escape.OnEnter.CheckPointStart!" )
			
			this.SetUpDemoZombieCreeping( true )
			
			this.ZombieSleepSetting( "SsdZombieEvent", "zmb_s10010_demo_0000", {-261.4617,288.5001,2467.989}, 240.0, 1, 0 )
			
			GkEventTimerManager.Start( "TimerDisableCreeping", 4.0)
		end
		
		if svars.isEscape_ContinueCheck == false then
			Fox.Log( "Seq_Game_Tutorial2_Escape.OnEnter.NOTCheckPointStart!" )
			
			GkEventTimerManager.Start( "TimerDisableCreeping", 5.0)
		end

		

		
		this.SetForceAlertDemoZombie()
		
		this.ZombieSleepSetting( "SsdZombieEvent", "zmb_s10010_demo_0001", {-263.561, 288.502, 2462.595 }, 300.0, 0, 0 )

		this.SetupZombie( zombieSettingTableList.WindowsAisle_Outer, true, true, true, true, true )
		
		this.ZombieSleepSetting( "SsdZombie", "zmb_s10010_0041", {-287.698, 292.736, 2442.375 }, 300.0, 1, 0 )
		this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_0041", true )
		
		this.ZombieSleepSetting( "SsdZombie", "zmb_s10010_0042", {-251.9574,288.55,2468.755}, 230.0, 1, 0 )
		
		this.ZombieSleepSetting( "SsdZombie", "zmb_s10010_infc_0012", { -284.6035,288.55,2459.78 }, 100.0, 1, 0 )
		this.SetBreakAndWarp( "SsdZombie", "zmb_s10010_0042", "warp_s10010_0042", 1, 0, 1, 0 )
		
		this.SetUpZombieBreakWindows()
		
		if svars.isZombieSetUp01 == false then
			
			this.SetupZombie( zombieSettingTableList.IncomingDemoRoom0030, true, true, true, true, true )
			
			svars.isZombieSetUp01 = true
		end
		
		this.SetIgnoreNoticeForList( AisleNoticeOnOffList, true )
		
		this.SetIgnoreNotice( zombieSettingTableList.FenceArea_NearestTheEntrance, true )
		this.SetIgnoreNotice( zombieSettingTableList.FenceArea_NearestTheEntranceNo2, true )
		this.SetIgnoreNotice( zombieSettingTableList.FenceArea_InFences0020, true )
		
		
		
		
		GkEventTimerManager.Start( "TimerDestroyDoor", 5.0 )
		
		GkEventTimerManager.Start( "TimerLimitDemoZombieKill", 15 )
		
		
		
		
		svars.isInEncounterReeveRoom = true
		
		svars.isInDemoRoomKillArea = true

	end,



	OnLeave = function ()
		Fox.Log( "s10010_sequences.Seq_Game_Tutorial2_Escape.OnLeave()" )
		
		SsdSbm.RemoveWeaponForTutorial{ id = "PRD_EQP_WP_hg00", tryEquip = true, }
		
		TppSound.StopSceneBGM("bgm_escape")
		
		
		
		
		this.DisableAllZombiesSeqEscape( zombieSettingTableList )
		
		this.SetZombieListForgetThreat( NOTzombieSettingTableList, 0 )
		this.SetZombieListForgetThreat( zombieSettingTableList,1 )
		
		this.ZombieListSetEnable(NOTzombieSettingTableList, false)
		
		this.SetZombieVoice( "POINT_ZMB_VOICES_A",false )
		this.SetZombieVoice( "POINT_ZMB_VOICES_B",false )
	end,
}




this.sequences.Seq_Demo_ReunionReeve = {
	OnEnter = function( self )
		Fox.Log( "s10010_sequence.Seq_Demo_ReunionReeve.OnEnter(): self:" .. tostring( self ) )
		s10010_demo.PlayReunionReeve{
			onSkip = function()
			end,
			onEnd = function()
				
				TppScriptBlock.LoadDemoBlock( "relics" )

				TppSequence.SetNextSequence( "Seq_Demo_BlackRadioMeetReeve" )

				
				Mission.ResetCrew()
			end,
		}
	end,
	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ReunionReeve.OnLeave()" )
		
		Mission.ResetCrew()
	end,
}




this.sequences.Seq_Demo_BlackRadioMeetReeve = {
	Messages = function( self )
		return StrCode32Table {
			UI = {
				{
					msg = "BlackRadioClosed",
					func = function( blackRadioId )
						GkEventTimerManager.Start( "TimerWaitCameraReverse", 0.5 )
						
						TppPlayer.Warp{
							pos = { -293.469, 284.500, 2416.020 },
							rotY = 220,
							fobRespawn = false,
						}
						
						Player.RequestToSetCameraRotation {
							
							rotX = 20,
							
							rotY = 210,
							
							interpTime = 0
						}
					end,
				},
				{	
					msg = "EndFadeIn",
					sender = "FinishBlackRadioFadeIn",
					func = function()
						TppSequence.SetNextSequence( "Seq_Game_Tutorial3_Craft" )		
					end,
				},
			},
			Timer = {
				{	
					msg = "Finish",
					sender = "TimerWaitCameraReverse",
					func = function()
						TppUI.FadeIn( TppUI.FADE_SPEED.FADE_HIGHSPEED, "FinishBlackRadioFadeIn" )
						TppSequence.SetNextSequence( "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged4" )		
					end,
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log( "s10010_sequences.Seq_Demo_BlackRadioMeetReeve.OnEnter()" )
		BlackRadio.ReadJsonParameter( "S10010_0010" )
		TppRadio.StartBlackRadio()
		
	end,
	OnLeave = function ()
		Fox.Log( "s10010_sequences.Seq_Demo_BlackRadioMeetReeve.OnLeave()" )
	end,
}


this.sequences.Seq_Demo_WaitAvatarLoadAfterAfghGearChanged4 = this.CreateGearChangeSequence( "Seq_Game_Tutorial3_Craft", GEAR_TABLE_FOR_GAME, false, false, "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged4",true )





this.sequences.Seq_Game_Tutorial3_Craft = {
	Messages = function( self )
		return StrCode32Table {
			Trap = {
				{
					sender = "trap_location_0007_CraftRoomBarricade",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						local CheckStorageCpacity = SsdSbm.IsWeaponStorageFull()
						if not svars.control_guide_attack then
							if svars.usemacheteRadio == true then
								
								if CheckStorageCpacity == false then
									TppRadio.Play( "f3010_rtrg0054" )
									
									GkEventTimerManager.Start( "TimerWaitShowControlGuide", 2.0 )	
									svars.control_guide_attack = true
								end
							end
						end
					end,
				},
				{
					sender = "trap_location_0004_CraftRoomExit",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0010", }, }
					end,
				},
				{
					sender = "trap_zombie_spawn_stealth0000",
					msg = "Enter",
					func = function( trapName, gameObjectId )
					end,
				},
				{
					sender = "trap_0006_start_sneak_tutorial",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Demo_ZombieAppearance" ) then
							TppSequence.SetNextSequence( "Seq_Demo_ZombieAppearance" )
						end
					end,
				},
			},
			Timer = {
				{	
					msg = "Finish",
					sender = "TimerWaitShowControlGuide",
					func = function()
						
						TppUI.ShowControlGuide{
							actionName = "ATTACK", 
							time = 7.0,
							continue = false
						}
					end
				},
				{	
					msg = "Finish",
					sender = "TimerWaitCompass",
					func = function()
						if TppTutorial.IsHelpTipsMenu() then
							GkEventTimerManager.Start( "TimerWaitCompass", 1 )
						else
							TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_COMPASS )
						end
					end
				},
				{	
					msg = "Finish",
					sender = "TimerWaitResourceCount",
					func = function()
						if TppTutorial.IsHelpTipsMenu() then
							GkEventTimerManager.Start( "TimerWaitResourceCount", 1 )	
						else
							this.ResourceCountCheck()
						end
					end,
				},
			},
			Sbm = {
				{	
					msg = "OnGetItem",
					func = function()
						local CheckStorageCpacity = SsdSbm.IsWeaponStorageFull()
						if CheckStorageCpacity == false then
							if not this.IsProductionSpear() then
								this.ResourceCountCheck()
							end
						end
					end,
				},
			},
			UI = {
				{
					msg = "CraftMenuClosed",
					func = function( craftMenuEntryType )
						
						if craftMenuEntryType == CraftMenu.ENTRY_CRAFT_WEAPON then
							if this.IsProductionSpear() then
								if not svars.usemacheteRadio then
									
									TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0009", }, }
									svars.usemacheteRadio = true
								end
							end
						end
					end,
				},
			},
		}
	end,
	OnEnter = function()
		Fox.Log( "sequences.Seq_Game_Tutorial3_Craft.OnEnter()" )
		
		this.DisableAllZombiesSeqEscape( zombieSettingTableList )
		this.ZombieListSetEnable(NOTzombieSettingTableList, false)
		
		TppUiStatusManager.UnsetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )
		
		vars.playerDisableActionFlag = PlayerDisableAction.MB_TERMINAL+ PlayerDisableAction.RIP_OUT+ PlayerDisableAction.CQC+ PlayerDisableAction.FULTON
		
		SsdUiSystem.Unlock( SsdUiLockType.FACILITY_PANEL )
		
		for _, lockType in ipairs{
			SsdUiLockType.REPAIR,		
			SsdUiLockType.CUSTOMIZE,	
			SsdUiLockType.DISASSEMBLE,	
			SsdUiLockType.CONVERT,		
			SsdUiLockType.CRAFT_KUB,	
		}
		do
			SsdUiSystem.Lock( lockType )
		end
		
		
		if not this.IsProductionSpear() then
			TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_MATERIAL )
			
			TppMission.UpdateObjective{ objectives = { "maker_tutorial1_disable_all_0007", }, }
		else
		
			
			TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0009", }, }
			svars.usemacheteRadio = true
		end
		
		this.SetupZombie( zombieSettingTableList.StealthAreaZombie0010, false, false, false, false, false )
		this.SetupZombie( zombieSettingTableList.StealthAreaZombie0020, false, false, false, false, false )
		
		SsdUiSystem.SetScriptFlag( SsdUiScriptFlag.INVISIBLE_THREAT_RING )
		
		local CheckStorageCpacity = SsdSbm.IsWeaponStorageFull()
		if CheckStorageCpacity == true then
			Fox.Log( "sequences.Seq_Game_Tutorial3_Craft.CheckStorageCpacity" )
			this.FullStorageInvisibleGimmick()
			
			TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0009", }, }
		end
		
		afgh_base.SetAfghReeveReunionAssetVisibility( true )
		
		Mission.SetHas10010ReeveHelmet(false)
		
		SsdSbm.ClearResourcesInInventory()	
	end,

	OnLeave = function ()
		Fox.Log( "s10010_sequences.Seq_Game_Tutorial3_Craft.OnLeave()" )
	end,
}





this.ResourceCountCheck = function()
	Fox.Log( "s10010_sequences.Seq_Game_Craft.ResourceCountCheck()" )
	if TppTutorial.IsHelpTipsMenu() then	
		GkEventTimerManager.Start( "TimerWaitResourceCount", 1 )	
		Fox.Log( "ResourceCountCheck.Timer.TimerWaitResourceCount" )
	else	
		Fox.Log( "ResourceCountCheck.NOT_TIPS" )
		local ironCount = SsdSbm.GetCountResource{ id="RES_Iron", inInventory=true, inWarehouse=false }
		local ragConut	= SsdSbm.GetCountResource{ id="RES_Rag", inInventory=true, inWarehouse=false }
		if ironCount >= 5 then
			if ragConut >= 2 then	
				if svars.isResourceCountCheck == false then
					Fox.Log( "ResourceCountCheck.CompleteCount" )
					if not svars.craftTips then
						
						TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_CRAFT )
						svars.craftTips = true
					end
					
					TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0008", }, }

					svars.isResourceCountCheck = true
				end
			end
		end
	end
end



this.sequences.Seq_Demo_ZombieAppearance = {
	OnEnter = function( self )
		this.SetFixRandVal()
		Fox.Log( "s10010_sequence.Seq_Demo_ZombieAppearance.OnEnter(): self:" .. tostring( self ) )
		
		s10010_demo.PlayZombieAppearance{
			onInit = function()
				if svars.isSetUpStealthZombie == false then
					
					this.SetupZombie( zombieSettingTableList.StealthAreaZombie0010, true, true, true, true, true )
					svars.isSetUpStealthZombie = true
				end
			end,
			onEnd = function()
				if TppSequence.GetCurrentSequenceIndex() < TppSequence.GetSequenceIndex( "Seq_Game_Tutorial4_Sneak" ) then
					TppSequence.SetNextSequence( "Seq_Game_Tutorial4_Sneak" )
				end
			end,
		}
	end,
	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_ZombieAppearance.OnLeave()" )
	end,
}





this.sequences.Seq_Game_Tutorial4_Sneak = {
	Messages = function( self )
		return StrCode32Table {
			Trap = {
				{
					sender = "trap_stealthZombie_noticeOff",
					msg = "Exit",
					func = function( trapName, gameObjectId )
						
						if svars.isStealthZombieNotice == true then
							this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_0001", false )
						end
					end,
				},
				{
					sender = "trap_zombie_spawn_stealth0001",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						this.SetZombieForgetThreat( "zmb_s10010_0001" )
						
						if svars.isZombieSetUpST01 == false then
							this.SetupZombie( zombieSettingTableList.StealthAreaZombie0020, true, true, true, true, false )
							svars.isZombieSetUpST01 = true
						end
					end,
				},
				{
					sender = "trap_0015_backstab",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						if svars.isBacksTabRadio == false then
							
							TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_BACKSTAB )
							svars.isBacksTabRadio = true
							
							vars.playerDisableActionFlag = PlayerDisableAction.MB_TERMINAL+ PlayerDisableAction.RIP_OUT+ PlayerDisableAction.FULTON
						end
					end,
				},
				{
					sender = "trap_0013_before_ladder",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.radderRadio then
							
							TppRadio.Play( "f3010_rtrg0056" )
							svars.radderRadio = true
						end
					end,
				},
				{
					sender = "trap_0014_basement_exit",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						local CheckStorageCpacity = SsdSbm.IsWeaponStorageFull()
						if not svars.goalmarker then
							
							TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0013", }, }
							
							if CheckStorageCpacity == false then
								Fox.Log( "sequences.Seq_Game_Tutorial3_Craft.CheckStorageCpacity" )
								TppRadio.Play( "f3010_rtrg0060" )
							end
							
							this.SetZombieMissionTarget( "zmb_s10010_0001", false )
							svars.goalmarker = true
						end
					end,
				},
				{
					sender = "trap_0017_marker07",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0012", }, }
					end,
				},
				{
					sender = "trap_0017_basement_exit_2",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						
						TppMission.UpdateObjective{ objectives = { "marker_tutorial1_goal", }, }
					end,
				},
				{
					sender = "trap_0008_intrude",
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.intrudeTips then
							
							TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_PAD )
							
							HelpTipsMenuSystem.SetPageOpenedNoAnnounce{ HelpTipsType.TIPS_27_A, HelpTipsType.TIPS_27_B }
							
							TppUI.ShowControlGuide{
								actionName = "STANCE", 
								time = 3.0,
								continue = false
							}
							svars.intrudeTips = true 
						end
					end,
				},
				{
					sender = "trap_radio_0004",	
					msg = "Enter",
					func = function( trapName, gameObjectId )
						if not svars.isRadio_CompleteExpPreparation then
							
							TppRadio.Play( "f3010_rtrg0062" )
							svars.isRadio_CompleteExpPreparation = true
						end
					end,
				},
			},
			Timer = {
				{	
					msg = "Finish",
					sender = "TimerWaitingEnableThreatRing",
					func = function()
						
						this.EndTipsCompass()
					end
				},
			},
			GameObject = {
				{
					msg = "WakeCombatAi",
					func = function( gameObjectId, phase )
						Fox.Log( "s10010_sequences.Seq_Game_Tutorial4_Sneak.WakeCombatAi" )
						if svars.isAlert_Radio == false then
							
							local CheckStorageCpacity = SsdSbm.IsWeaponStorageFull()
							if CheckStorageCpacity == false then
								TppRadio.Play( "f3010_rtrg0048" )
								svars.isAlert_Radio = true
							else
								Fox.Log( "CheckStorageCpacity = true!!So,I didn't call Alert_Radio!!" )
							end
						end
					end,
				},
			},
		}
	end,

	OnEnter = function()
		Fox.Log( "s10010_sequences.Seq_Game_Tutorial4_Sneak.OnEnter()" )
		
		
		
		
		Player.RequestToSetTargetStance( PlayerStance.SQUAT )
		
		vars.playerDisableActionFlag = PlayerDisableAction.MB_TERMINAL+ PlayerDisableAction.RIP_OUT+ PlayerDisableAction.CQC+ PlayerDisableAction.FULTON
		
		TppUiStatusManager.UnsetStatus( "SsdPlayerStatusHUD", "DISABLE_LIFE_AND_EQUIP", "s10010_sequence" )
		
		
		
		
		if svars.isStealthZombieNotice == false then
			this.SetZombieIgnoreNotice( "SsdZombie", "zmb_s10010_0001", true )
			svars.isStealthZombieNotice = true
		end
		if svars.isSetUpStealthZombie == false then
			
			this.SetupZombie( zombieSettingTableList.StealthAreaZombie0010, true, true, true, true, true )
			svars.isSetUpStealthZombie = true
		end
		
		this.SetZombieMissionTarget( "zmb_s10010_0001", true )
		
		
		
		
		TppMission.UpdateObjective{ objectives = { "marker_tutorial1_checkpoint_0011", }, }
		
		TppTutorial.StartHelpTipsMenu( tipsMenuList.TIPS_ZOMBIE_VISION_HEARING )
		
		SsdUiSystem.Lock( SsdUiLockType.FACILITY_PANEL )
		
		local CheckStorageCpacity = SsdSbm.IsWeaponStorageFull()
		if CheckStorageCpacity == true then
			this.FullStorageInvisibleGimmick()
		end

		
		TppDataUtility.SetVisibleDataFromIdentifier( "DataIdentifier_s10010_d03_identifier", "MB_switchVisibility", false, true )
	end,

	OnLeave = function ()
		Fox.Log( "sequences.Seq_Game_Tutorial4_Sneak.OnLeave()" )
		
		SsdUiSystem.ClearScriptFlag()
	end,
}





this.sequences.Seq_Demo_Relics = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Relics.OnEnter(): self:" .. tostring( self ) )

		
		TppDataUtility.SetVisibleDataFromIdentifier( "DataIdentifier_s10010_d03_identifier", "MB_switchVisibility", true, true )
		s10010_demo.PlayRelics{
			onEnd = function()
				TppSequence.ReserveNextSequence( "Seq_Demo_WaitAvatarLoadAfterMbGearChanged3", {} )
				TppDemo.SetPlayerPause()
				this.SetInitialPlayerPositionForOmbs()
				TppMission.Reload{
					locationCode = TppDefine.LOCATION_ID.SSD_OMBS,
					showLoadingTips = false,
					isNoFade = true,
					missionPackLabelName = "s10010_d01",
				}
			end,
		}
	end,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{	
					sender = "p10_000060",
					msg = "TitleTrophy",	
					func = function()
						Fox.Log( "s10010_sequence.sequences.Seq_Demo_Relics.Messages(): sender:p10_000060, msg:TitleTrophy" )

						
						TppTrophy.Unlock( 1 )	
					end,
					option = { isExecDemoPlaying = true, },
				},
			},
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Retrospect.OnLeave()" )
		TppTrophy.Unlock( 1 ) 
	end,
}

this.sequences.Seq_Demo_WaitAvatarLoadAfterMbGearChanged3 = this.CreateGearChangeSequence( "Seq_Demo_Retrospect", GEAR_TABLE_FOR_MB, false, false, "Seq_Demo_WaitAvatarLoadAfterMbGearChanged3",false )




this.sequences.Seq_Demo_Retrospect = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Retrospect.OnEnter(): self:" .. tostring( self ) )

		TppTrophy.Unlock( 1 ) 

		s10010_demo.PlayRetrospect{
			onEnd = function()
				TppSequence.SetNextSequence( "Seq_Demo_MissionBriefing" )
			end,
		}
	end,

	Messages = function( self )
		return StrCode32Table{
			Demo = {
				{
					msg = "p00_000010_env_on",
					func = function()
						Fox.Log( "s10010_sequence.sequences.Seq_Demo_Retrospect.Messages(): Demo: p00_000010_env_on" )
						TppDataUtility.SetVisibleDataFromIdentifier( "DataIdenitifier_ombs_common_identifier", "mtbs_hide_assets", true, true )
					end,
					option = { isExecDemoPlaying = true },
				},
				{
					msg = "p00_000010_env_off",
					func = function()
						Fox.Log( "s10010_sequence.sequences.Seq_Demo_Retrospect.Messages(): Demo: p00_000010_env_off" )
						TppDataUtility.SetVisibleDataFromIdentifier( "DataIdenitifier_ombs_common_identifier", "mtbs_hide_assets", false, true )
					end,
					option = { isExecDemoPlaying = true },
				},
			},
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Retrospect.OnLeave()" )
	end,
}



this.sequences.Seq_Demo_MissionBriefing = {

	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_MissionBriefing.OnEnter(): self:" .. tostring( self ) )

		TppMovie.Play{
			videoName = "p10_000075",
			isLoop = false,
			onEnd = function()
				TppSequence.ReserveNextSequence( "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged2", {} )
				
				TppDemo.ResetReserveInGameFlag()
				gvars.waitLoadingTipsEnd = true
				this.SetInitialPlayerPositionForAfgh()
				
				local namedCrewQuestId = "k40020"
				local crewHandle = SsdCrewSystem.RegisterTempCrew{ quest = namedCrewQuestId }
				SsdCrewSystem.EmployTempCrew{ handle = crewHandle }
				
				TppUI.SetFadeColorToWhite()
				TppMission.Reload{
					locationCode = TppDefine.LOCATION_ID.SSD_AFGH,
					showLoadingTips = false,
					isNoFade = true,
					missionPackLabelName = "s10010_d04",
				}
			end,
			memoryPool = "p10_000075",
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_MissionBriefing.OnLeave()" )
	end,
}

this.sequences.Seq_Demo_WaitAvatarLoadAfterAfghGearChanged2 = this.CreateGearChangeSequence( "Seq_Demo_Recapture", GEAR_TABLE_FOR_GAME, false, false, "Seq_Demo_WaitAvatarLoadAfterAfghGearChanged2",true )




this.sequences.Seq_Demo_Recapture = {
	OnEnter = function( self )
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Recapture.OnEnter(): self:" .. tostring( self ) )

		
		s10010_demo.PlayRecapture{
			onEnd = function()
				
				if TppLocation.IsAfghan() then
					afgh_base.SetAfghOpeningAssetVisibility( true )
				end
				
				TppMission.ReserveMissionClear{
					missionClearType = TppDefine.MISSION_CLEAR_TYPE.ON_FOOT,
					nextMissionId = 30010,
				}
			end,
		}
	end,

	OnLeave = function()
		Fox.Log( "s10010_sequence.sequences.Seq_Demo_Recapture.OnLeave()" )
	end,
}




this.sequences.Seq_Demo_EncounterAi = {
	OnEnter = function( self )
		Fox.Log( "s10010_sequences.Seq_Demo_EncounterAi.OnEnter(): self" .. tostring( self ) )
		s10010_demo.PlayEncounterAi{
			onEnd = function()
				TppSequence.SetNextSequence( "Seq_Demo_BlackTelephone", { isExecMissionClear = true, } )
			end,
		}
	end,
}




this.sequences.Seq_Demo_BlackTelephone = {
	OnEnter = function( self )
		Fox.Log( "s10010_sequences.Seq_Demo_BlackTelephone.OnEnter(): self" .. tostring( self ) )
		BlackRadio.ReadJsonParameter( "S10010_0020" )
		TppRadio.StartBlackRadio()
	end,
}




this.sequences.Seq_Game_DebugForDemo = {
	OnEnter = function()
		Fox.Log( "s10010_sequences.Seq_Game_DebugForDemo.OnEnter()" )
	end,

	OnLeave = function ()
		Fox.Log( "s10010_sequences.Seq_Game_DebugForDemo.OnLeave()" )
	end,
}




return this
