local o=SubtitlesDaemon.GetInstance()
if SubtitlesCommand then
SubtitlesCommand:SetSubFilePath"/Assets/tpp/ui/Subtitles/sub_old/"SubtitlesCommand:SetSubpFilePath"/Assets/tpp/ui/Subtitles/subp/"SubtitlesCommand:SetDefaultGeneratorName"Default"SubtitlesCommand:SetSubFpkFilePath"/Assets/tpp/pack/ui/subtitles"end
UiCommonDataManager.Create()HudCommonDataManager.Create()
local o=UiCommonDataManager.GetInstance()
TppUiCommand.CreateUiDependJob()
TppUiCommand.CreateUiUpdateMarkerJob()
TppUiCommand.CreateUiUseGrJob()
TppUiCommand.UiPadStart()
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
dofile"Tpp/Scripts/Ui/MgoUiBlocksConfig.lua"if TppGameSequence.GetTargetArea()=="ChinaKorea"then
TppUiCommand.CreateResidentBlockController(19e4,"/Assets/mgo/pack/ui/ui_resident_data_ck.fpk")
else
TppUiCommand.CreateResidentBlockController(152720,"/Assets/mgo/pack/ui/ui_resident_data.fpk")
end
elseif TppGameSequence.GetGameTitleName()=="TPP"then
if TppGameSequence.GetTargetArea()=="ChinaKorea"then
TppUiCommand.CreateResidentBlockController(348*1024,"/Assets/tpp/pack/ui/ui_resident_data_ck.fpk")
else
TppUiCommand.CreateResidentBlockController(350*1024,"/Assets/tpp/pack/ui/ui_resident_data.fpk")
end
else
TppUiCommand.CreateResidentBlockController(460*1024,"/Assets/tpp/pack/ui/gz/gz_ui_resident_data.fpk")
end
TppUiCommand.UiPlatFormSetting()
TppUiCommand.UiAreaSetting()
local t=Fox.GetPlatformName()
local o=550
if TppSystemUtility.GetCurrentGameMode()=="MGO"then
if t=="PS4"then
o=650
elseif t=="XboxOne"then
o=650
elseif t=="Windows"then
o=650
end
end
LanguageBlock.Create(o*1024)LanguageBlock.Create(96*1024)
if Fox.GetPlatformName()=="Windows"then
if Editor then
TppUiCommand.SetVarsLanguage(8)
else
TppUiCommand.SetPlatformLanguage()
end
else
TppUiCommand.SetPlatformLanguage()
end
local p=AssetConfiguration.GetDefaultCategory"Language"local i=""local n=""local _=""local t=""local T=""local U=""local o=1
local e=3
local a="/Assets/tpp"if TppSystemUtility.GetCurrentGameMode()=="MGO"then
a="/Assets/mgo"end
local E=a.."/pack/ui/lang/lang_default_data_eng.fpk"if p=="jpn"then
i="FontSystem_KanjiFont"n="/Assets/tpp/font/font_def_jp.ffnt"_="FontSystem_Slot3"t="/Assets/tpp/font/KanjiFont.ffnt"o=2
e=3
E=a.."/pack/ui/lang/lang_default_data_jpn.fpk"elseif p=="eng"then
i="FontSystem_LatinFont"n="/Assets/tpp/font/font_def_ltn.ffnt"_="FontSystem_Slot3"t="/Assets/tpp/font/LatinFont.ffnt"o=1
e=3
elseif p=="rus"then
i="FontSystem_LatinFont"n="/Assets/tpp/font/font_def_rus.ffnt"_="FontSystem_Slot3"t="/Assets/tpp/font/russian.ffnt"T="FontSystem_KanjiFont"U="/Assets/tpp/font/font_def_ltn.ffnt"o=1
e=3
E=a.."/pack/ui/lang/lang_default_data_rus.fpk"elseif p=="ara"then
i="FontSystem_LatinFont"n="/Assets/tpp/font/arabia.ffnt"_="FontSystem_Slot3"t="/Assets/tpp/font/arabia.ffnt"o=1
e=3
E=a.."/pack/ui/lang/lang_default_data_ara.fpk"else
i="FontSystem_LatinFont"n="/Assets/tpp/font/font_def_ltn.ffnt"_="FontSystem_Slot3"t="/Assets/tpp/font/LatinFont.ffnt"o=1
e=3
end
GrTools.FontSystemLoad(i,n)GrTools.FontSystemLoad(_,t)UiDaemon.SetFontTypeTransTable(0,o)UiDaemon.SetFontTypeTransTable(1,e)
if p=="rus"then
GrTools.FontSystemLoad(T,U)
end
TppUiCommand.ChangeLanguage()FadeFunction.InitFadeSetting()UiDaemon.SetExecLuaFile"Tpp/Scripts/Ui/TppUiPrefetchTexture.lua"local o=UiDaemon.GetInstance()o.ResetDefaultButtonMap()o.SetButtonMap("BUTTON_A",fox.PAD_A,fox.KEY_RETURN)o.SetButtonMap("BUTTON_B",fox.PAD_B,fox.KEY_ESCAPE)o.SetButtonMap("BUTTON_X",fox.PAD_X,fox.KEY_G)o.SetButtonMap("BUTTON_Y",fox.PAD_Y,fox.KEY_T)o.SetButtonMap("BUTTON_UP",fox.PAD_U,fox.KEY_W)o.SetButtonMap("BUTTON_DOWN",fox.PAD_D,fox.KEY_S)o.SetButtonMap("BUTTON_LEFT",fox.PAD_L,fox.KEY_A)o.SetButtonMap("BUTTON_RIGHT",fox.PAD_R,fox.KEY_D)o.SetButtonMap("STATUS_UP",fox.PAD_U+4,fox.KEY_UP)o.SetButtonMap("STATUS_DOWN",fox.PAD_D+4,fox.KEY_DOWN)o.SetButtonMap("STATUS_LEFT",fox.PAD_L+4,fox.KEY_LEFT)o.SetButtonMap("STATUS_RIGHT",fox.PAD_R+4,fox.KEY_RIGHT)o.SetButtonMap("BUTTON_LT",fox.PAD_L2,fox.KEY_1)o.SetButtonMap("BUTTON_RT",fox.PAD_R2,fox.KEY_3)o.SetButtonMap("BUTTON_LB",fox.PAD_L1,fox.KEY_1)o.SetButtonMap("BUTTON_RB",fox.PAD_R1,fox.KEY_3)o.SetButtonDecideMap("UI_DECIDE",fox.KEY_SPACE)o.SetButtonCancelMap("UI_CANCEL",fox.KEY_ESCAPE)o.SetButtonDecideMap("DECISION",fox.KEY_SPACE)o.SetButtonCancelMap("CANCEL",fox.KEY_ESCAPE)o.SetButtonDecideMap("UI_MOUSE_DECIDE",fox.MOUSE_CODE_LEFT)o.SetButtonCancelMap("UI_MOUSE_CANCEL",fox.MOUSE_CODE_RIGHT)o.SetButtonMap("UI_DETAIL",fox.PAD_Y,fox.KEY_T)o.SetButtonMap("UI_CHECK",fox.PAD_X,fox.KEY_G)o.SetButtonMap("UI_SELECT",fox.PAD_SELECT,fox.KEY_ESCAPE)o.SetButtonMap("UI_START",fox.PAD_START,fox.KEY_TAB)o.SetButtonMap("UI_UP",fox.PAD_U,fox.KEY_W)o.SetButtonMap("UI_DOWN",fox.PAD_D,fox.KEY_S)o.SetButtonMap("UI_LEFT",fox.PAD_L,fox.KEY_A)o.SetButtonMap("UI_RIGHT",fox.PAD_R,fox.KEY_D)o.SetButtonMap("UI_LT",fox.PAD_L2,fox.KEY_Q)o.SetButtonMap("UI_RT",fox.PAD_R2,fox.KEY_E)o.SetButtonMap("UI_LB",fox.PAD_L1,fox.KEY_1)o.SetButtonMap("UI_RB",fox.PAD_R1,fox.KEY_3)o.SetButtonMap("UI_LEFTSTICK_PUSH",fox.PAD_L3,fox.KEY_SHIFT)o.SetButtonMap("UI_RIGHTSTICK_PUSH",fox.PAD_R3,fox.KEY_V)o.SetButtonMap("UI_LB_PAGE_UP",fox.PAD_L1,fox.KEY_PAGEUP)o.SetButtonMap("UI_RB_PAGE_DOWN",fox.PAD_R1,fox.KEY_PAGEDOWN)o.SetButtonMap("UI_KBD_SHIFT",fox.GK_PAD_NO_BUTTON,fox.KEY_SHIFT)o.SetButtonMap("UI_KBD_ALT",fox.GK_PAD_NO_BUTTON,fox.KEY_ALT)o.SetButtonMap("UI_KBD_CTRL",fox.GK_PAD_NO_BUTTON,fox.KEY_CTRL)o.SetButtonMap("UI_KBD_BS",fox.GK_PAD_NO_BUTTON,fox.KEY_BS)o.SetButtonMap("UI_KBD_RETURN",fox.GK_PAD_NO_BUTTON,fox.KEY_RETURN)o.SetButtonMap("UI_KBD_1",fox.GK_PAD_NO_BUTTON,fox.KEY_1)o.SetButtonMap("UI_KBD_2",fox.GK_PAD_NO_BUTTON,fox.KEY_2)o.SetButtonMap("UI_KBD_3",fox.GK_PAD_NO_BUTTON,fox.KEY_3)o.SetButtonMap("UI_KBD_4",fox.GK_PAD_NO_BUTTON,fox.KEY_4)o.SetButtonMap("UI_KBD_5",fox.GK_PAD_NO_BUTTON,fox.KEY_5)o.SetButtonMap("UI_KBD_6",fox.GK_PAD_NO_BUTTON,fox.KEY_6)o.SetButtonMap("UI_KBD_7",fox.GK_PAD_NO_BUTTON,fox.KEY_7)o.SetButtonMap("UI_KBD_8",fox.GK_PAD_NO_BUTTON,fox.KEY_8)o.SetButtonMap("UI_KBD_9",fox.GK_PAD_NO_BUTTON,fox.KEY_9)o.SetButtonMap("UI_KBD_0",fox.GK_PAD_NO_BUTTON,fox.KEY_0)o.SetButtonMap("UI_KBD_X",fox.GK_PAD_NO_BUTTON,fox.KEY_G)o.SetButtonMap("UI_KBD_Y",fox.GK_PAD_NO_BUTTON,fox.KEY_T)o.SetButtonMap("UI_KBD_UP",fox.GK_PAD_NO_BUTTON,fox.KEY_UP)o.SetButtonMap("UI_KBD_DOWN",fox.GK_PAD_NO_BUTTON,fox.KEY_DOWN)o.SetButtonMap("UI_KBD_LEFT",fox.GK_PAD_NO_BUTTON,fox.KEY_LEFT)o.SetButtonMap("UI_KBD_RIGHT",fox.GK_PAD_NO_BUTTON,fox.KEY_RIGHT)o.SetButtonMap("UI_KBD_PAGE_UP",fox.GK_PAD_NO_BUTTON,fox.KEY_PAGEUP)o.SetButtonMap("UI_KBD_PAGE_DOWN",fox.GK_PAD_NO_BUTTON,fox.KEY_PAGEDOWN)o.SetButtonMap("UI_EQUIP_PRIMARY",fox.GK_PAD_NO_BUTTON,fox.KEY_1)o.SetButtonMap("UI_EQUIP_SECONDARY",fox.GK_PAD_NO_BUTTON,fox.KEY_2)o.SetButtonMap("UI_EQUIP_SUPPORT",fox.GK_PAD_NO_BUTTON,fox.KEY_3)o.SetButtonMap("UI_EQUIP_ITEM",fox.GK_PAD_NO_BUTTON,fox.KEY_4)o.SetButtonMap("UI_EQUIP_UP",fox.GK_PAD_NO_BUTTON,fox.KEY_UP)o.SetButtonMap("UI_EQUIP_DOWN",fox.GK_PAD_NO_BUTTON,fox.KEY_DOWN)o.SetButtonMap("UI_EQUIP_LEFT",fox.GK_PAD_NO_BUTTON,fox.KEY_LEFT)o.SetButtonMap("UI_EQUIP_RIGHT",fox.GK_PAD_NO_BUTTON,fox.KEY_RIGHT)o.SetButtonMap("UI_EQUIP_OP_1",fox.PAD_X,fox.KEY_G)o.SetButtonMap("UI_EQUIP_OP_2",fox.PAD_Y,fox.KEY_T)o.SetButtonMap("UI_PAGE_UP",fox.PAD_L,fox.KEY_PAGEUP)o.SetButtonMap("UI_PAGE_DOWN",fox.PAD_R,fox.KEY_PAGEDOWN)o.SetButtonMap("UI_MOVE_UP",fox.PAD_R2,fox.KEY_W)o.SetButtonMap("UI_MOVE_DOWN",fox.PAD_L2,fox.KEY_S)o.SetButtonMap("UI_MOVE_LEFT",fox.GK_PAD_NO_BUTTON,fox.KEY_A)o.SetButtonMap("UI_MOVE_RIGHT",fox.GK_PAD_NO_BUTTON,fox.KEY_D)o.SetButtonMap("UI_STANCE",fox.GK_PAD_NO_BUTTON,fox.KEY_C)o.SetButtonMap("UI_ACTION",fox.GK_PAD_NO_BUTTON,fox.KEY_E)o.SetButtonMap("UI_SUBJECT",fox.GK_PAD_NO_BUTTON,fox.KEY_F)o.SetButtonMap("UI_EVADE",fox.GK_PAD_NO_BUTTON,fox.KEY_SPACE)o.SetButtonMap("UI_RELOAD",fox.GK_PAD_NO_BUTTON,fox.KEY_R)o.SetButtonMap("UI_RADIO",fox.PAD_L1,fox.KEY_Q)o.SetButtonMap("UI_HOLD",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_RIGHT)o.SetButtonMap("UI_SHOT",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_LEFT)o.SetButtonMap("UI_STOCK",fox.PAD_R3,fox.KEY_V)o.SetButtonMap("UI_CQC",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_LEFT)o.SetButtonMap("UI_SIDE_ROLL",fox.GK_PAD_NO_BUTTON,fox.KEY_SHIFT)o.SetButtonMap("UI_LIGHT_SWITCH",fox.PAD_R,fox.KEY_X)o.SetButtonMap("UI_VEHICLE_FIRE",fox.PAD_L1,fox.MOUSE_CODE_LEFT)o.SetButtonMap("UI_VEHICLE_CALL",fox.GK_PAD_NO_BUTTON,fox.KEY_Q)o.SetButtonMap("UI_VEHICLE_DASH",fox.GK_PAD_NO_BUTTON,fox.KEY_W)o.SetButtonMap("UI_VEHICLE_CAMERA",fox.PAD_R1,fox.KEY_F)o.SetButtonMap("UI_PLACE_MARKER",fox.PAD_L2,fox.MOUSE_CODE_LEFT)o.SetButtonMap("UI_MAP_MARKER",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_LEFT)o.SetButtonMap("UI_SCORES",fox.GK_PAD_NO_BUTTON,fox.KEY_ESCAPE)o.SetButtonMap("UI_DASH",fox.GK_PAD_NO_BUTTON,fox.KEY_SHIFT)o.SetButtonMap("UI_WALK",fox.GK_PAD_NO_BUTTON,fox.KEY_CTRL)o.SetButtonMap("UI_MB_HELP",fox.PAD_SELECT,fox.KEY_H)o.SetButtonMap("UI_BUDDY_DASH",fox.PAD_X,fox.KEY_SHIFT)o.SetButtonMap("UI_KEY_PAUSE",fox.GK_PAD_NO_BUTTON,fox.KEY_ESCAPE)o.SetButtonMap("UI_KEY_PARTY",fox.PAD_SELECT,fox.KEY_H)o.SetButtonMap("UI_KEY_MIC",fox.GK_PAD_NO_BUTTON,fox.KEY_B)o.SetButtonMap("UI_MISSION_INFO",fox.PAD_L2,fox.KEY_1)o.SetButtonMap("UI_SURVIVAL_CANCEL",fox.PAD_B,fox.KEY_2)o.SetButtonMap("HUD_DECIDE",fox.PAD_R3,fox.KEY_SPACE)o.SetButtonMap("UI_PAD_ALL",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_PAD_DIR)o.SetButtonMap("UI_PAD_KEY_UD",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_KEY_UD)o.SetButtonMap("UI_PAD_KEY_LR",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_KEY_LR)o.SetButtonMap("UI_PAD_STICK_L",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_STICK_L)o.SetButtonMap("UI_PAD_STICK_R",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_STICK_R)o.SetButtonMap("UI_MOUSE_WHEEL",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_MOUSE_WHEEL)o.SetButtonMap("UI_MOUSE_MIDDLE",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_MIDDLE)o.SetButtonMap("UI_EQUIP_STICK",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_MOUSE_WHEEL)o.SetButtonMap("UI_EQUIP_DIR",fox.GK_PAD_NO_BUTTON,fox.EX_CODE_PAD_DIR)o.SetButtonMap("UI_BINO_RADIO",fox.GK_PAD_NO_BUTTON,fox.KEY_Q)o.SetButtonMap("UI_BINO_ZOOM",fox.GK_PAD_NO_BUTTON,fox.KEY_V)o.SetButtonMap("UI_BINO_MARKER",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_LEFT)o.SetButtonMap("UI_BINO_CHANGE",fox.GK_PAD_NO_BUTTON,fox.KEY_T)o.SetButtonMap("UI_BINO_DECIDE",fox.GK_PAD_NO_BUTTON,fox.KEY_RETURN)o.SetButtonMap("CQC_KNIFE_KILL",fox.GK_PAD_NO_BUTTON,fox.KEY_E)o.SetButtonMap("CQC_HOLD",fox.GK_PAD_NO_BUTTON,fox.MOUSE_CODE_LEFT)o.SetButtonMap("CQC_INTERROGATE",fox.GK_PAD_NO_BUTTON,fox.KEY_Q)o.CreateButtonMap()o.SetKeyCodeEqual("UI_UP",fox.KEY_UP)o.SetKeyCodeEqual("UI_DOWN",fox.KEY_DOWN)o.SetKeyCodeEqual("UI_LEFT",fox.KEY_LEFT)o.SetKeyCodeEqual("UI_RIGHT",fox.KEY_RIGHT)o.SetKeyCodeEqual("UI_DECIDE",fox.KEY_RETURN)o.SetKeyCodeEqual("HUD_DECIDE",fox.KEY_RETURN)o.SetKeyCodeEqual("UI_STOCK",fox.MOUSE_CODE_MIDDLE)o.CreateKeyData(144)UiDaemon.ClearDrawPriorityTable()UiDaemon.SetDrawPriorityTable{interval=100,table={{name="__BACK_EFFECT",priority=0},{name="VERY_BACK",priority=11},{name="__HUD",priority=20},{name="WORLD_MARKER_CHARA",priority=23},{name="BOSS_GAUGE_HEAD",priority=25},{name="WORLD_MARKER",priority=27},{name="TIME_CIGARETTE_BG",priority=30},{name="TIME_CIGARETTE",priority=32},{name="NOTICE_DIR",priority=35},{name="DAMAGE_DIR",priority=37},{name="PRESET_RADIO",priority=40},{name="PICK_UP",priority=49},{name="ACTION_ICON",priority=50},{name="RETICLE_LOW",priority=53},{name="RETICLE",priority=55},{name="RETICLE_HIGH",priority=57},{name="BOSS_GAUGE_2D",priority=60},{name="__MB_DEVICE",priority=64},{name="MB_BG",priority=65},{name="MB_MENU_LOW",priority=66},{name="MB_MENU_MIDDLE",priority=68},{name="MB_MENU_HIGH",priority=70},{name="MB_MAP_BG",priority=71},{name="MB_MAP",priority=72},{name="MB_MAP_ICON",priority=74},{name="MB_MAP_HIGH",priority=82},{name="MB_CHILD_PAGE",priority=84},{name="MB_CHILD_LOW",priority=85},{name="MB_CHILD_MIDDLE",priority=86},{name="MB_CHILD_HIGH",priority=88},{name="MB_COMMON_HIGH",priority=94},{name="DEV_COND_POPUP",priority=98},{name="SORTIE_BG_LOW",priority=79},{name="SORTIE_BG",priority=80},{name="SORTIE_MENU",priority=84},{name="SORTIE_DETAIL",priority=90},{name="SORTIE_POPUP",priority=98},{name="WEP_ICON",priority=95},{name="__SIGHT",priority=128},{name="SIGHT_BG",priority=128},{name="SIGHT_RETICLE",priority=130},{name="SIGHT_RETICLE_ADD",priority=131},{name="SIGHT_STRONG",priority=132},{name="SIGHT_STRONG_HUD",priority=133},{name="LMENU",priority=133},{name="LOCKON_RETICLE",priority=134},{name="LMENU_SELECT",priority=135},{name="CALL_MENU",priority=135},{name="RADIO_GUIDE",priority=136},{name="WEAPON_PANEL",priority=146},{name="ITEM_PANEL",priority=152},{name="UNDER_SUBTITLE_BG",priority=150},{name="__SUBTITLE",priority=150},{name="SUBTITLE",priority=151},{name="__TEXT",priority=160},{name="PIC_INFO",priority=161},{name="MISSION_ICON",priority=161},{name="RESOURCE_PANEL",priority=161},{name="GMP_INFO",priority=162},{name="ANNOUNCE_LOG",priority=163},{name="TELOP_TEXT",priority=165},{name="__TELOP_PAUSE",priority=170},{name="TELOP_BG",priority=171},{name="PAUSE_BG",priority=171},{name="PAUSE_MENU",priority=173},{name="PAUSE_MENU_ADD",priority=175},{name="TITLE_BG_LOW",priority=79},{name="TITLE_BG",priority=80},{name="TITLE_NORMAL_BG",priority=166},{name="TITLE_LOGO",priority=167},{name="TITLE_MENU",priority=168},{name="__POPUP",priority=180},{name="POPUP_BG",priority=181},{name="POPUP_MENU",priority=183},{name="__GAME_FADE",priority=190},{name="GAME_FADE",priority=191},{name="GAME_FADE_UP",priority=192},{name="__STRONG_TEXT",priority=195},{name="STRONG_ANNOUNCE_LOG",priority=196},{name="__STRONG_TELOP_PAUSE",priority=200},{name="STRONG_TELOP_BG",priority=201},{name="STRONG_TELOP_PAGE",priority=202},{name="STRONG_TELOP_TEXT",priority=203},{name="STRONG_PAUSE_BG",priority=205},{name="STRONG_PAUSE_MENU",priority=207},{name="STRONG_PAUSE_ICON",priority=209},{name="LYRIC_TELOP",priority=209},{name="__STRONG_SUBTITLE",priority=210},{name="__FRONT_EFFECT",priority=245},{name="__ERROR_MESSAGE",priority=251},{name="ERROR_MESSAGE",priority=251},{name="SYSTEM_MESSAGE",priority=251},{name="SYSTEM_ICON",priority=252},{name="PREFAB_COMMON",priority=86},{name="PREFAB_POPUP",priority=92}}}
TppUiCommand.InitPrefabSystem()
if TppSystemUtility.GetCurrentGameMode()~="MGO"then
TppUiCommand.RegistMissionEpisodeNo(10020,1)
TppUiCommand.RegistMissionEpisodeNo(10030,2)
TppUiCommand.RegistMissionEpisodeNo(10036,3)
TppUiCommand.RegistMissionEpisodeNo(10043,4)
TppUiCommand.RegistMissionEpisodeNo(10033,5)
TppUiCommand.RegistMissionEpisodeNo(10040,6)
TppUiCommand.RegistMissionEpisodeNo(10041,7)
TppUiCommand.RegistMissionEpisodeNo(10044,8)
TppUiCommand.RegistMissionEpisodeNo(10054,9)
TppUiCommand.RegistMissionEpisodeNo(10052,10)
TppUiCommand.RegistMissionEpisodeNo(10050,11)
TppUiCommand.RegistMissionEpisodeNo(10070,12)
TppUiCommand.RegistMissionEpisodeNo(10080,13)
TppUiCommand.RegistMissionEpisodeNo(10086,14)
TppUiCommand.RegistMissionEpisodeNo(10082,15)
TppUiCommand.RegistMissionEpisodeNo(10090,16)
TppUiCommand.RegistMissionEpisodeNo(10091,17)
TppUiCommand.RegistMissionEpisodeNo(10100,18)
TppUiCommand.RegistMissionEpisodeNo(10195,19)
TppUiCommand.RegistMissionEpisodeNo(10110,20)
TppUiCommand.RegistMissionEpisodeNo(10121,21)
TppUiCommand.RegistMissionEpisodeNo(10115,22)
TppUiCommand.RegistMissionEpisodeNo(10120,23)
TppUiCommand.RegistMissionEpisodeNo(10085,24)
TppUiCommand.RegistMissionEpisodeNo(10200,25)
TppUiCommand.RegistMissionEpisodeNo(10211,26)
TppUiCommand.RegistMissionEpisodeNo(10081,27)
TppUiCommand.RegistMissionEpisodeNo(10130,28)
TppUiCommand.RegistMissionEpisodeNo(10140,29)
TppUiCommand.RegistMissionEpisodeNo(10150,30)
TppUiCommand.RegistMissionEpisodeNo(10151,31)
TppUiCommand.RegistMissionEpisodeNo(10045,32)
TppUiCommand.RegistMissionEpisodeNo(11043,33)
TppUiCommand.RegistMissionEpisodeNo(11054,34)
TppUiCommand.RegistMissionEpisodeNo(10093,35)
TppUiCommand.RegistMissionEpisodeNo(11082,36)
TppUiCommand.RegistMissionEpisodeNo(11090,37)
TppUiCommand.RegistMissionEpisodeNo(10156,38)
TppUiCommand.RegistMissionEpisodeNo(11033,39)
TppUiCommand.RegistMissionEpisodeNo(11050,40)
TppUiCommand.RegistMissionEpisodeNo(10171,41)
TppUiCommand.RegistMissionEpisodeNo(11140,42)
TppUiCommand.RegistMissionEpisodeNo(10240,43)
TppUiCommand.RegistMissionEpisodeNo(11080,44)
TppUiCommand.RegistMissionEpisodeNo(10260,45)
TppUiCommand.RegistMissionEpisodeNo(10280,46)
TppUiCommand.RegistMissionEpisodeNo(11121,47)
TppUiCommand.RegistMissionEpisodeNo(11130,48)
TppUiCommand.RegistMissionEpisodeNo(11044,49)
TppUiCommand.RegistMissionEpisodeNo(11151,50)
else
local o=1
local _=2
local t=3
local p=4
local E=5
local a=6
local n=7
local e=7
local e={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=0,[9]=3,[10]=1,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,[19]=0,[20]=1,[21]=0,[22]=1,[23]=0,[24]=0,[25]=0,[26]=0,[27]=0,[28]=0,[29]=0,[30]=0,[31]=0,[32]=0,[33]=0,[34]=0,[35]=0,[36]=0,[37]=0,[38]=0,[39]=1,[40]=0,[41]=1,[42]=0,[43]=0,[44]=0}
local T={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[8]=1,[9]=0,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=1,[16]=0,[17]=2}
local s={[1]=0,[2]=0,[3]=0,[4]=0,[5]=0,[6]=0,[7]=0,[9]=1,[10]=0,[11]=0,[12]=0,[13]=0,[14]=0,[15]=0,[16]=0,[17]=0,[18]=0,[19]=0,[20]=0,[21]=0,[22]=0,[23]=0,[24]=1,[25]=1,[26]=0,[27]=0,[28]=0,[29]=1,[30]=0,[31]=0,[32]=0,[33]=0}
local f={[1]=3}
local U={[1]=3}
local S={[1]=3}
local i={[1]=3}
local p={{_,1},{_,2},{_,3},{_,4},{_,5},{_,16},{_,17},{t,1},{t,2},{t,3},{t,4},{t,5},{t,6},{t,7},{_,6},{o,1},{o,2},{o,3},{t,9},{t,30},{t,31},{t,32},{t,10},{t,11},{t,12},{t,13},{t,14},{t,15},{t,16},{o,4},{_,7},{_,8},{_,9},{o,5},{_,10},{o,42},{_,11},{_,12},{o,6},{_,13},{_,14},{o,7},{o,39},{t,17},{_,15},{o,8},{o,9},{o,41},{o,40},{o,10},{o,11},{o,12},{o,13},{o,14},{o,15},{o,16},{t,18},{t,19},{t,20},{t,21},{t,22},{t,23},{o,44},{t,24},{t,25},{t,26},{t,27},{t,28},{t,33},{t,29},{o,17},{o,19},{o,20},{o,21},{o,43},{o,22},{o,23},{o,24},{o,25},{o,26},{o,27},{o,28},{o,29},{o,30},{o,31},{o,32},{o,33},{o,34},{o,35},{o,36},{o,37},{o,38},{p,1},{E,1},{a,1},{n,1}}
local a={e,T,s,f,U,S,i}
local i={"gen","fre","gam","bty","cad","com","sab"}
local t=Fox.GetPlatformName()
local n=false
local E=false
local T=false
if t=="Xbox360"or t=="PS3"then
n=true
end
if t=="XboxOne"then
E=true
end
if t=="Xbox360"or t=="XboxOne"then
T=true
end
for e,t in ipairs(p)do
local e=t[1]
local t=t[2]
local p=a[e]
local a=i[e]
local U=p[t]
local i=string.format("mgo_tips_%s_%03d",a,t)
local p=true
if e==_ and t==15 then
if n==true then
p=false
end
if E==true then
i=i.."_xone"end
end
if e==_ and t==16 then
if n==true then
p=false
end
end
if p==true then
TppUiCommand.RegistTipsTitle(i,i)
TppUiCommand.RegistTipsGroup(a,i)
for n=0,U do
local n=string.format("mgo_tips_%s_info_%03d_%02d",a,t,n)
if e==_ and t==15 then
if E==true then
n=n.."_xone"end
end
if e==o and t==44 then
if T==true then
n=n.."_xbox"end
end
TppUiCommand.RegistTipsDoc(i,n)
end
end
end
end
TppUiCommand.InitEmblemSaveData()
TppUiCommand.CallAccessMessage()
