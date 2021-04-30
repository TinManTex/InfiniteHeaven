










local subtitlesDaemon = SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
	SubtitlesCommand:SetSubFilePath( "/Assets/tpp/ui/Subtitles/sub_old/" )
	SubtitlesCommand:SetSubpFilePath( "/Assets/tpp/ui/Subtitles/subp/" )
	SubtitlesCommand:SetDefaultGeneratorName( "Default" )
	SubtitlesCommand:SetSubFpkFilePath( "/Assets/tpp/pack/ui/subtitles" )
end



























UiCommonDataManager.Create()
local uiCommonData = UiCommonDataManager.GetInstance()
uiCommonData:CreateUiDependJob();
uiCommonData:CreateUiUseGrJob();
uiCommonData:UiPadStart();



if TppGameSequence.GetGameTitleName() == "TPP" then



else
	uiCommonData:CreateResidentBlock( 460 * 1024, "/Assets/tpp/pack/ui/gz/gz_ui_resident_data.fpk" );
end




uiCommonData:UiPlatFormSetting()


uiCommonData:UiAreaSetting()



local useLang = AssetConfiguration.GetDefaultCategory( "Language" )




local slotName0 = ""
local fontName0 = ""

local slotName1 = ""
local fontName1 = ""

local slotName2 = ""
local fontName2 = ""

local setSlotNo0 = 1
local setSlotNo1 = 3



if useLang == "jpn" then
	slotName0 = "FontSystem_KanjiFont"
	fontName0 = "/Assets/tpp/font/font_def_jp.ffnt"

	slotName1 = "FontSystem_Slot3"
	fontName1 = "/Assets/tpp/font/KanjiFont.ffnt"

	setSlotNo0 = 2 
	setSlotNo1 = 3 


elseif useLang == "eng" then
	slotName0 = "FontSystem_LatinFont"
	fontName0 = "/Assets/tpp/font/font_def_ltn.ffnt"

	slotName1 = "FontSystem_Slot3"
	fontName1 = "/Assets/tpp/font/LatinFont.ffnt"

	setSlotNo0 = 1 
	setSlotNo1 = 3 


elseif useLang == "rus" then
	slotName0 = "FontSystem_LatinFont"
	fontName0 = "/Assets/tpp/font/font_def_rus.ffnt"

	slotName1 = "FontSystem_Slot3"
	fontName1 = "/Assets/tpp/font/russian.ffnt"

	slotName2 = "FontSystem_KanjiFont" 
	fontName2 = "/Assets/tpp/font/font_def_ltn.ffnt"

	setSlotNo0 = 1 
	setSlotNo1 = 3 


elseif useLang == "ara" then
	slotName0 = "FontSystem_LatinFont"
	fontName0 = "/Assets/tpp/font/arabia.ffnt"

	slotName1 = "FontSystem_Slot3"
	fontName1 = "/Assets/tpp/font/arabia.ffnt"

	setSlotNo0 = 1 
	setSlotNo1 = 3 


else
	slotName0 = "FontSystem_LatinFont"
	fontName0 = "/Assets/tpp/font/font_def_ltn.ffnt"

	slotName1 = "FontSystem_Slot3"
	fontName1 = "/Assets/tpp/font/LatinFont.ffnt"

	setSlotNo0 = 1 
	setSlotNo1 = 3 

end


GrTools.FontSystemLoad( slotName0, fontName0 )
GrTools.FontSystemLoad( slotName1, fontName1 )
UiDaemon.SetFontTypeTransTable( 0, setSlotNo0 )
UiDaemon.SetFontTypeTransTable( 1, setSlotNo1 )
if useLang == "rus" then
	
	GrTools.FontSystemLoad( slotName2, fontName2 )
end







FadeFunction.InitFadeSetting()






UiDaemon.SetExecLuaFile("Tpp/Scripts/Ui/TppUiPrefetchTexture.lua")




local uidaemon = UiDaemon.GetInstance();
uidaemon.ResetDefaultButtonMap()  


uidaemon.SetButtonMap( "BUTTON_A",		fox.PAD_A,		fox.KEY_RETURN )
uidaemon.SetButtonMap( "BUTTON_B",		fox.PAD_B,		fox.KEY_ESCAPE )
uidaemon.SetButtonMap( "BUTTON_X",		fox.PAD_X,		fox.KEY_X )
uidaemon.SetButtonMap( "BUTTON_Y",		fox.PAD_Y,		fox.KEY_Y )
uidaemon.SetButtonMap( "BUTTON_UP",		fox.PAD_U,		fox.KEY_W )
uidaemon.SetButtonMap( "BUTTON_DOWN",	fox.PAD_D,		fox.KEY_S )
uidaemon.SetButtonMap( "BUTTON_LEFT",	fox.PAD_L,		fox.KEY_A )
uidaemon.SetButtonMap( "BUTTON_RIGHT",	fox.PAD_R,		fox.KEY_D )
uidaemon.SetButtonMap( "STATUS_UP",		fox.PAD_U+4,	fox.KEY_UP )
uidaemon.SetButtonMap( "STATUS_DOWN",	fox.PAD_D+4,	fox.KEY_DOWN )
uidaemon.SetButtonMap( "STATUS_LEFT",	fox.PAD_L+4,	fox.KEY_LEFT )
uidaemon.SetButtonMap( "STATUS_RIGHT",	fox.PAD_R+4,	fox.KEY_RIGHT )
uidaemon.SetButtonMap( "BUTTON_LT",		fox.PAD_L2,		fox.KEY_1 )
uidaemon.SetButtonMap( "BUTTON_RT",		fox.PAD_R2,		fox.KEY_3 )
uidaemon.SetButtonMap( "BUTTON_LB",		fox.PAD_L1,		fox.KEY_1 )
uidaemon.SetButtonMap( "BUTTON_RB",		fox.PAD_R1,		fox.KEY_3 )
uidaemon.SetButtonMap( "BUTTON_SELECT",	fox.PAD_SELECT,	fox.KEY_ESCAPE )
uidaemon.SetButtonMap( "BUTTON_START",	fox.PAD_START,	fox.KEY_TAB )


uidaemon.SetButtonDecideMap( "UI_DECIDE", fox.KEY_RETURN )
uidaemon.SetButtonCancelMap( "UI_CANCEL", fox.KEY_ESCAPE )

uidaemon.SetButtonMap( "UI_DETAIL",		fox.PAD_Y,		fox.KEY_Y )
uidaemon.SetButtonMap( "UI_CHECK",		fox.PAD_X,		fox.KEY_X )
uidaemon.SetButtonMap( "UI_SELECT",		fox.PAD_SELECT,	fox.KEY_ESCAPE )
uidaemon.SetButtonMap( "UI_START",		fox.PAD_START,	fox.KEY_TAB )
uidaemon.SetButtonMap( "UI_UP",				fox.PAD_U,		fox.KEY_W )
uidaemon.SetButtonMap( "UI_DOWN",			fox.PAD_D,		fox.KEY_S )
uidaemon.SetButtonMap( "UI_LEFT",			fox.PAD_L,		fox.KEY_A )
uidaemon.SetButtonMap( "UI_RIGHT",		fox.PAD_R,		fox.KEY_D )
uidaemon.SetButtonMap( "UI_LT",				fox.PAD_L2,		fox.KEY_1 )
uidaemon.SetButtonMap( "UI_RT",				fox.PAD_R2,		fox.KEY_3 )
uidaemon.SetButtonMap( "UI_LB",				fox.PAD_L1,		fox.KEY_1 )
uidaemon.SetButtonMap( "UI_RB",				fox.PAD_R1,		fox.KEY_3 )

uidaemon.SetButtonMap( "UI_LEFTSTICK_PUSH",		fox.PAD_L3,	fox.KEY_SHIFT )
uidaemon.SetButtonMap( "UI_RIGHTSTICK_PUSH",	fox.PAD_R3, fox.KEY_Z )

uidaemon.SetButtonMap( "UI_KBD_SHIFT",	fox.GK_PAD_NO_BUTTON, fox.KEY_SHIFT )
uidaemon.SetButtonMap( "UI_KBD_ALT",	fox.GK_PAD_NO_BUTTON, fox.KEY_ALT )
uidaemon.SetButtonMap( "UI_KBD_CTRL",	fox.GK_PAD_NO_BUTTON, fox.KEY_CTRL )

uidaemon.SetButtonMap( "UI_PAGE_UP",			fox.PAD_L,		fox.KEY_PAGEUP )
uidaemon.SetButtonMap( "UI_PAGE_DOWN",		fox.PAD_R,		fox.KEY_PAGEDOWN )
uidaemon.SetButtonMap( "UI_LB_PAGE_UP",		fox.PAD_L1,		fox.KEY_PAGEUP )
uidaemon.SetButtonMap( "UI_LB_PAGE_DOWN",	fox.PAD_R1,		fox.KEY_PAGEDOWN )


uidaemon.SetButtonMap( "PL_UP",							fox.PAD_U,						fox.KEY_W )
uidaemon.SetButtonMap( "PL_DOWN",						fox.PAD_D,						fox.KEY_S )
uidaemon.SetButtonMap( "PL_LEFT",						fox.PAD_L,						fox.KEY_A )
uidaemon.SetButtonMap( "PL_RIGHT",					fox.PAD_R,						fox.KEY_D )
uidaemon.SetButtonMap( "PL_DASH",						fox.GK_PAD_NO_BUTTON,	fox.KEY_SHIFT )
uidaemon.SetButtonMap( "PL_WALK",						fox.GK_PAD_NO_BUTTON,	fox.KEY_CTRL )
uidaemon.SetButtonMap( "MB_DEVICE",					fox.GK_PAD_NO_BUTTON,	fox.KEY_TAB )
uidaemon.SetButtonMap( "MB_MAP_MARKER",			fox.GK_PAD_NO_BUTTON,	fox.KEY_CODE_MAX ) 
uidaemon.SetButtonMap( "PL_ACTION",					fox.GK_PAD_NO_BUTTON,	fox.KEY_E )
uidaemon.SetButtonMap( "PL_RELOAD",					fox.GK_PAD_NO_BUTTON,	fox.KEY_R )
uidaemon.SetButtonMap( "PL_SQUAT",					fox.GK_PAD_NO_BUTTON,	fox.KEY_C )
uidaemon.SetButtonMap( "PL_SUB_CAMERA",			fox.GK_PAD_NO_BUTTON,	fox.KEY_F )
uidaemon.SetButtonMap( "PL_SUB_WP_CAMERA",	fox.GK_PAD_NO_BUTTON,	fox.KEY_F ) 
uidaemon.SetButtonMap( "PL_CALL",						fox.GK_PAD_NO_BUTTON,	fox.KEY_Q )
uidaemon.SetButtonMap( "PL_EVADE_ACTION",		fox.GK_PAD_NO_BUTTON,	fox.KEY_SPACE )
uidaemon.SetButtonMap( "PL_ZOOM_CHANGE",		fox.GK_PAD_NO_BUTTON,	fox.KEY_V )
uidaemon.SetButtonMap( "PL_ZOOM_IN",				fox.GK_PAD_NO_BUTTON,	fox.KEY_UP )
uidaemon.SetButtonMap( "PL_ZOOM_OUT",				fox.GK_PAD_NO_BUTTON,	fox.KEY_DOWN )
uidaemon.SetButtonMap( "PL_SEARCHLIGHT",		fox.GK_PAD_NO_BUTTON,	fox.KEY_L )
uidaemon.SetButtonMap( "PL_ROLLING",				fox.GK_PAD_NO_BUTTON,	fox.KEY_SHIFT )
uidaemon.SetButtonMap( "PL_STOCK",					fox.GK_PAD_NO_BUTTON,	fox.KEY_V )
uidaemon.SetButtonMap( "PL_LIGHTSWITCH",		fox.GK_PAD_NO_BUTTON,	fox.KEY_L )
uidaemon.SetButtonMap( "PL_CQC",						fox.GK_PAD_NO_BUTTON,	fox.KEY_CODE_MAX+1 ) 
uidaemon.SetButtonMap( "PL_CQC_KNIFE_KILL",	fox.GK_PAD_NO_BUTTON,	fox.KEY_E )
uidaemon.SetButtonMap( "PL_CQC_INTERROGATE",fox.GK_PAD_NO_BUTTON,	fox.KEY_Q )

uidaemon.SetButtonMap( "VEHICLE_TRIGGER_ACCEL",	fox.GK_PAD_NO_BUTTON,	fox.KEY_W )
uidaemon.SetButtonMap( "VEHICLE_TRIGGER_BREAK",	fox.GK_PAD_NO_BUTTON,	fox.KEY_S )
uidaemon.SetButtonMap( "VEHICLE_SWITCH_LIGHT",	fox.GK_PAD_NO_BUTTON,	fox.KEY_L )
uidaemon.SetButtonMap( "VEHICLE_FIRE",					fox.PAD_L1,	fox.KEY_CODE_MAX+1 ) 


uidaemon.SetButtonMap( "HUD_PRIMARY",				fox.GK_PAD_NO_BUTTON,	fox.KEY_1 )
uidaemon.SetButtonMap( "HUD_SECONDARY",			fox.GK_PAD_NO_BUTTON,	fox.KEY_2 )
uidaemon.SetButtonMap( "HUD_SUPPORT",				fox.GK_PAD_NO_BUTTON,	fox.KEY_3 )
uidaemon.SetButtonMap( "HUD_ITEM",					fox.GK_PAD_NO_BUTTON,	fox.KEY_4 )
uidaemon.SetButtonMap( "HUD_UP",						fox.GK_PAD_NO_BUTTON,	fox.KEY_UP )
uidaemon.SetButtonMap( "HUD_DOWN",					fox.GK_PAD_NO_BUTTON,	fox.KEY_DOWN )
uidaemon.SetButtonMap( "HUD_LEFT",					fox.GK_PAD_NO_BUTTON,	fox.KEY_LEFT )
uidaemon.SetButtonMap( "HUD_RIGHT",					fox.GK_PAD_NO_BUTTON,	fox.KEY_RIGHT )
uidaemon.SetButtonMap( "HUD_DECIDE",				fox.GK_PAD_NO_BUTTON,	fox.KEY_RETURN )
uidaemon.SetButtonMap( "HUD_EQUIP",					fox.GK_PAD_NO_BUTTON,	fox.KEY_G )
uidaemon.SetButtonMap( "HUD_EQUIP_OP_1",		fox.PAD_X,						fox.KEY_X )
uidaemon.SetButtonMap( "HUD_EQUIP_OP_2",		fox.PAD_Y,						fox.KEY_Y )
uidaemon.SetButtonMap( "EQUIP_UP",					fox.GK_PAD_NO_BUTTON,	fox.KEY_UP )
uidaemon.SetButtonMap( "EQUIP_DOWN",				fox.GK_PAD_NO_BUTTON,	fox.KEY_DOWN )
uidaemon.SetButtonMap( "EQUIP_LEFT",				fox.GK_PAD_NO_BUTTON,	fox.KEY_LEFT )
uidaemon.SetButtonMap( "EQUIP_RIGHT",				fox.GK_PAD_NO_BUTTON,	fox.KEY_RIGHT )
uidaemon.SetButtonMap( "INTERROGATE_UP",		fox.GK_PAD_NO_BUTTON,	fox.KEY_1 )
uidaemon.SetButtonMap( "INTERROGATE_DOWN",	fox.GK_PAD_NO_BUTTON,	fox.KEY_2 )
uidaemon.SetButtonMap( "INTERROGATE_LEFT",	fox.GK_PAD_NO_BUTTON,	fox.KEY_3 )
uidaemon.SetButtonMap( "INTERROGATE_RIGHT",	fox.GK_PAD_NO_BUTTON,	fox.KEY_4 )
uidaemon.SetButtonMap( "MAP_ROTATE_ADD",		fox.GK_PAD_NO_BUTTON,	fox.KEY_SHIFT )
uidaemon.SetButtonMap( "MAP_ZOOM",					fox.PAD_R3,						fox.KEY_V )
uidaemon.SetButtonMap( "CASSETTE_PLAY",			fox.PAD_A,				fox.KEY_P )



uidaemon.SetButtonMap( "PL_HOLD",		fox.GK_PAD_NO_BUTTON, fox.KEY_CODE_MAX+2 )

uidaemon.SetButtonMap( "PL_SHOT",		fox.GK_PAD_NO_BUTTON, fox.KEY_CODE_MAX+1 )



uidaemon.SetButtonMap( "UI_DIR_NORMAL",		fox.GK_PAD_NO_BUTTON,	fox.KEY_CODE_MAX )
uidaemon.SetButtonMap( "UI_DIR_LRKEY",		fox.GK_PAD_NO_BUTTON,	fox.KEY_CODE_MAX )
uidaemon.SetButtonMap( "UI_L_STICK",			fox.GK_PAD_NO_BUTTON, fox.KEY_CODE_MAX )
uidaemon.SetButtonMap( "UI_R_STICK",			fox.GK_PAD_NO_BUTTON, fox.KEY_CODE_MAX )
uidaemon.SetButtonMap( "UI_CURSOR_LEFT",	fox.PAD_L,						fox.KEY_LEFT )
uidaemon.SetButtonMap( "UI_CURSOR_RIGHT",	fox.PAD_R,						fox.KEY_RIGHT )
uidaemon.SetButtonMap( "UI_ICON_JUMP",		fox.GK_PAD_NO_BUTTON,	fox.KEY_W )
uidaemon.SetButtonMap( "TUTORIAL_PRIMARY_SEL",	fox.GK_PAD_NO_BUTTON,	fox.KEY_CODE_MAX )


uidaemon.CreateButtonMap() 

uidaemon.SetKeyCodeEqual( "UI_UP",			fox.KEY_UP )
uidaemon.SetKeyCodeEqual( "UI_DOWN",		fox.KEY_DOWN )
uidaemon.SetKeyCodeEqual( "UI_LEFT",		fox.KEY_LEFT )
uidaemon.SetKeyCodeEqual( "UI_RIGHT",		fox.KEY_RIGHT )
uidaemon.SetKeyCodeEqual( "UI_DECIDE",	fox.KEY_SPACE )
uidaemon.SetKeyCodeEqual( "UI_CANCEL",	fox.KEY_BS )
uidaemon.SetKeyCodeEqual( "HUD_DECIDE",	fox.KEY_SPACE )
uidaemon.SetKeyCodeEqual( "INTERROGATE_UP", fox.KEY_UP )
uidaemon.SetKeyCodeEqual( "INTERROGATE_DOWN", fox.KEY_DOWN )
uidaemon.SetKeyCodeEqual( "INTERROGATE_LEFT", fox.KEY_LEFT )
uidaemon.SetKeyCodeEqual( "INTERROGATE_RIGHT", fox.KEY_RIGHT )


uidaemon.CreateKeyData( 120 )






UiDaemon.ClearDrawPriorityTable()

UiDaemon.SetDrawPriorityTable {
	
	interval = 100,
	
	
	table = {
	
		{ name = "__BACK_EFFECT",			priority = 0	},
		{ name = "VERY_BACK",				priority = 11	},

	
		{ name = "__HUD",					priority = 20	},
		{ name = "WORLD_MARKER_CHARA",		priority = 23	},
		{ name = "WORLD_MARKER",			priority = 25	},
		{ name = "TIME_CIGARETTE_BG",		priority = 30	},
		{ name = "TIME_CIGARETTE",			priority = 32	},
		{ name = "NOTICE_DIR",				priority = 35	},
		{ name = "DAMAGE_DIR",				priority = 37	},
		{ name = "PRESET_RADIO",			priority = 40	},
		{ name = "PICK_UP",					priority = 49	},
		{ name = "ACTION_ICON",				priority = 50	},
		{ name = "RETICLE_LOW",				priority = 53	},
		{ name = "RETICLE",					priority = 55	},
		{ name = "RETICLE_HIGH",			priority = 57	},
	
		{ name = "__MB_DEVICE",				priority = 64	},
		{ name = "MB_BG",					priority = 65	},
		{ name = "MB_MAP",					priority = 68	},
		{ name = "MB_MAP_ICON",				priority = 70	},
		{ name = "MB_MAP_HIGH",				priority = 78	},
		{ name = "MB_MENU_LOW",				priority = 80	},
		{ name = "MB_MENU_MIDDLE",			priority = 82	},
		{ name = "MB_MENU_HIGH",			priority = 84	},
		{ name = "MB_CHILD_PAGE",			priority = 90	},
		{ name = "MB_CHILD_LOW",			priority = 92	},
		{ name = "MB_CHILD_MIDDLE",			priority = 94	},
		{ name = "MB_CHILD_HIGH",			priority = 96	},
	
		{ name = "WEP_ICON",				priority = 95	},
	
		{ name = "__SIGHT",					priority = 128 },
		{ name = "SIGHT_BG",				priority = 130 },
		{ name = "SIGHT_RETICLE",			priority = 132 },
		{ name = "SIGHT_STRONG",			priority = 135 },
	
		{ name = "SIGHT_STRONG_HUD",		priority = 137 },
		{ name = "LMENU",					priority = 137	},
		{ name = "LMENU_SELECT",			priority = 138	},
		{ name = "RADIO_GUIDE",				priority = 140 },
	
		{ name = "UNDER_SUBTITLE_BG",		priority = 145 },
	
		{ name = "__SUBTITLE",				priority = 150 },
		{ name = "SUBTITLE",				priority = 151 },
	
		{ name = "__TEXT",					priority = 160 },
		{ name = "ANNOUNCE_LOG",			priority = 161 },
	
		{ name = "__TELOP_PAUSE",			priority = 170 },
		{ name = "TELOP_BG",				priority = 171 },
		{ name = "TELOP_TEXT",				priority = 173 },
		{ name = "PAUSE_BG",				priority = 171 },
		{ name = "PAUSE_MENU",				priority = 173 },
		{ name = "PAUSE_MENU_ADD",			priority = 175 },
	
		{ name = "__POPUP",					priority = 180 },
		{ name = "POPUP_BG",				priority = 181 },
		{ name = "POPUP_MENU",				priority = 183 },
	
		{ name = "__GAME_FADE",				priority = 190 },
		{ name = "GAME_FADE",				priority = 191 },
		{ name = "GAME_FADE_UP",			priority = 192 },
	
		{ name = "__STRONG_TELOP_PAUSE",	priority = 200 },
		{ name = "STRONG_TELOP_BG",			priority = 201 },
		{ name = "STRONG_TELOP_TEXT",		priority = 203 },
		{ name = "STRONG_PAUSE_BG",			priority = 205 },
		{ name = "STRONG_PAUSE_MENU",		priority = 207 },
		{ name = "STRONG_PAUSE_ICON",		priority = 209 },
	
		{ name = "__STRONG_SUBTITLE",		priority = 210 },
	
		{ name = "__FRONT_EFFECT",			priority = 245 },
	
		{ name = "__ERROR_MESSAGE",			priority = 251 },
		{ name = "ERROR_MESSAGE",			priority = 251 },
		{ name = "SYSTEM_MESSAGE",			priority = 251 },
	}
}







