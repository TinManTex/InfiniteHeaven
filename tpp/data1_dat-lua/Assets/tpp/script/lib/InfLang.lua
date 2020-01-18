-- DOBUILD: 1
local this={}
--InfLang for Infinite Heaven r57
--Want to help out?
--Translation: Have a look below and see what you can do. Contact me by pm if you want more detail/want to send me your translation. You will be credited in the main infinite heaven description for your kind work.
--If you want more direction on a string contact me, some of my own english descriptions are not the best as it is, and sometime I have to shorten them to keep things managable for how it's presented in-game.
--This file does nothing by itself but you have modding knowledge can replace/edit \Assets\tpp\script\lib\InfLang.lua in the infinite heaven.msgv file using a zip tool
--New versions of infinite heaven will add more strings, I will add them to the end of the, and existing strings that I've changed will be noted at the end of it's line with it's version number,
--example:  inf_turn_off_menu="Turn off menu",--r58
--remove the version comment to indicate to me that you've uodated the line.
--Thanks again, any help, big or small will be appreciated.
-- tin man tex

--game localizations known: 
--eng,fre,ger,ita,jpn,por,rus,spa
--english, french, german, italian, japanese, portuguese, russian, spanish
--unconfirmed lang codes:
--ara, cht, kor
--arabic, chinese traditional, korean
--if your current games language is on the unconfirmed list use the Patchup > Show language code option in infinite heaven to get the language code and contact me on nexus

--tex if the lang function cant find a langid/string pair for a language it will default to eng, if it can't find in eng it will return the langId
--if translating only edit the text within the quotation marks.
this.eng={--english
  inf_test="Ativações Советский ФОНАРЬ 你还不错  munición 侵入者をCQCにより無力化 ",
  inf_menu_open_help="(Press Up/Down,Left/Right to navigate menu)",
  inf_turn_off_menu="Turn off menu",
  inf_setting_defaults="Setting mod options to defaults...",
  inf_setting_default="Setting to default..",
  inf_reset_all_settings="Reset all settings",
  inf_setting_disallowed="is currently disallowed",
  inf_menu_back="Menu Back",
  inf_menu_off="Menu Off",
  inf_main_menu="Main Menu",
  inf_parameters_menu="Parameters Menu",
  inf_mother_base_menu="Mother Base Menu",
  inf_demos_menu="Cutscenes Menu",
  inf_patchup_menu="Patchup Menu",
  inf_general_enemy_parameters="General Enemy Parameters",
  inf_enemy_life_scale="Enemy life scale (REQ: Tweaked Enemy Parameters)",
  inf_player_life_scale="Player life scale",
  inf_dd_equip_grade="DD Equip Grade",
  inf_dd_equip_range="DD Equip Range",
  inf_dd_suit="DD Suit (Requires Equip Grade On)",
  inf_mother_base_war_games="Mother Base War Games",
  inf_start_missions_on_foot="Start missions on foot",
  inf_clock_time_scale="Clock time scale",
  inf_unlock_avatar="Unlock playable avatar",
  inf_return_quiet="Return Quiet (not reversable)",
  inf_quiet_already_returned="Quiet has already returned.",
  inf_subsistence_mode="Subsistence Mode",
  inf_osp_weapon_loadout="OSP Weapon Loadout",
  inf_enemy_preparedness="Enemy Preparedness",
  inf_force_enemy_subtype="Force enemy CP sub type",
  inf_unlock_random_sideops="Unlock random Sideops for areas",
  inf_open_specific_sideop="Open specific sideop #",
  inf_use_soldier_for_demos="Use selected soldier in cutscenes",
  inf_mb_demo_selection="MB cutscene play mode",
  inf_mb_select_demo="Select MB cutscene (REQ: Play selected)",
  inf_set_switch={"Off","On"},
  inf_set_do={">",">"},
  inf_set_menu_off={">","Off"},
  inf_set_menu_reset={">","Reset"},
  inf_set_menu_back={">","Back"},
  inf_set_enemy_parameters={"Default (mods can override)","Tweaked"},
  inf_set_dd_equip_grade={"Off","Current MB Dev","Random","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Grade 10"},
  inf_set_dd_equip_range={"Default (FOB Setting)", "All Short", "All Medium","All Long","Random"},
  inf_set_dd_suit={"Use Equip Grade", "Tiger","Sneaking","Battle Dress","PF Riot Suit"},
  inf_set_mb_wargames={"Off","DD Non Lethal","DD Lethal"},
  inf_set_mb_demo_selection={"Default","Cutscenes disabled","Play selected"},
  inf_set_quiet_return={">","Returned"},
  inf_set_subsistence={"Off","Pure (OSP -Items -Hand -Suit -Support -Fulton -Vehicle -Buddy)","Bounder (Pure +Buddy +Suit +Fulton)"},
  inf_set_osp={"Off","Pure - all cleared","Secondary free","Tertiary free","Primary only cleared","Seconday only cleared"},--r58
  inf_set_revenge={"Regular","Max"},
  inf_set_unlock_sideops={"Off","Force Replayable","Force Open"},
  inf_show_game_lang_code="Show game language code",--r57
  inf_language_code="Language Code",--r58
  inf_show_position="Show position",--r58
}

this.ara={--arabic, unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus, untranslated, copy lines from eng to start on
  inf_test="TestAra",
}

this.cht={--chinese traditional, translation by rikimtasu,  unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus
  inf_test="TestCht",
  --[[
  inf_menu_open_help="(按上/下，左/右选择菜单)",
  inf_turn_off_menu="关闭菜单",
  inf_setting_defaults="设置MOD选项为默认值...",
  inf_setting_default="回归默认设置..",
  inf_reset_all_settings="回归全部设置",
  inf_setting_disallowed="目前不允许",
  inf_menu_back="返回菜单",
  inf_menu_off="关闭菜单",
  inf_main_menu="主要菜单",
  inf_parameters_menu="参数菜单",
  inf_mother_base_menu="主要基地菜单",
  inf_demos_menu="动画菜单",
  inf_patchup_menu="补丁菜单",
  inf_general_enemy_parameters="一般敌人参数",
  inf_enemy_life_scale="敌人生命比例 (需要: 修正敌人参数)",
  inf_player_life_scale="玩家生命比例",
  inf_dd_equip_grade="DD 装备等级",
  inf_dd_equip_range="DD 装备范围",
  inf_dd_suit="DD 装 (需要装备等级启动)",
  inf_mother_base_war_games="主要基地战争游戏",
  inf_start_missions_on_foot="徒步开始任务",
  inf_clock_time_scale="时钟时间比例",
  inf_unlock_avatar="解锁Avatar",
  inf_return_quiet="静静回归 (不可逆转)",
  inf_quiet_already_returned="静静已经回来了.",
  inf_subsistence_mode="Subsistence 模式",
  inf_osp_weapon_loadout="OSP 武器装备",
  inf_enemy_preparedness="敌人准备度",
  inf_force_enemy_subtype="强制敌人CP子类型",
  inf_unlock_random_sideops="解锁随机支線任務地区",
  inf_open_specific_sideop="解锁特定支線任務 #",
  inf_use_soldier_for_demos="在过场动画中使用特定士兵",
  inf_mb_demo_selection="MB 过场动画播放模式",
  inf_mb_select_demo="选择MB过场动画 (需要: 选择播放)",
  inf_set_switch={"关闭","开启"},
  inf_set_do={">",">"},
  inf_set_menu_off={">","关闭"},
  inf_set_menu_reset={">","重置"},
  inf_set_menu_back={">","回"},
  inf_set_enemy_parameters={"默认（MODS可以覆盖）","以调整"},
  inf_set_dd_equip_grade={"关闭","当前MB开发进度","随机","等级 1","等级 2","等级 3","等级 4","等级 5","等级 6","等级 7","Grade 8","Grade 9","Grade 10"},
  inf_set_dd_equip_range={"默认 (FOB 设定)", "全短", "全中","全长","随机"},
  inf_set_dd_suit={"使用装备等级", "虎","潜行","战袍","PF防暴服"},
  inf_set_mb_wargames={"关闭","DD 非致命","DD 致命"},
  inf_set_mb_demo_selection={"默认","禁用过场动画","选择播放"},
  inf_set_quiet_return={">","回去"},
  inf_set_subsistence={"关闭","纯洁 (OSP -东西 -手臂 -衣服 -支源 -富尔顿 -车辆 -伙伴)","畛 (纯洁 +伙伴 +衣服 +富尔顿)"},
  inf_set_osp={"关闭","纯洁 - all cleared","不带第二武器","不带第三武器","Primary only cleared","Seconday only cleared"},--r58
  inf_set_revenge={"正规","Max"},
  inf_set_unlock_sideops={"关闭","强迫重玩","强迫开放"},
  inf_show_game_lang_code="Show game language code",--r57
  inf_language_code="Language Code",--r58
  inf_show_position="Show position",--r58
  --]]
}

this.fre={--french, untranslated, untranslated, copy lines from eng to start on
  inf_test="TestFre",
}

this.ger={--german, untranslated, untranslated, copy lines from eng to start on
  inf_test="TestGer",
}

this.ita={--italian, untranslated, untranslated, copy lines from eng to start on
  inf_test="TestIta",
}

this.jpn={--japanese, untranslated, untranslated, copy lines from eng to start on
  inf_test="TestJpn",
}

this.kor={--korean, unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus, untranslated, copy lines from eng to start on
  inf_test="TestKor",
}

this.por={--portugese, untranslated, copy lines from eng to start on
  inf_test="TestPor",
}

this.rus={--russian, untranslated, copy lines from eng to start on
  inf_test="TestRus",
}

this.spa={--spanish, untranslated, copy lines from eng to start on
  inf_test="TesSpa",
}

return this
