-- DOBUILD: 1
--TODO: MOVE this is data not lib
local this={}
--InfLang for Infinite Heaven r63
--Want to help out?
--Translation: Have a look below and see what you can do. Contact me by pm if you want more detail/want to send me your translation. You will be credited in the main infinite heaven description for your kind work.
--If you want more direction on a string contact me, some of my own english descriptions are not the best as it is, and sometime I have to shorten them to keep things managable for how it's presented in-game.
--This file does nothing by itself but you have modding knowledge can replace/edit \Assets\tpp\script\lib\InfLang.lua in the infinite heaven.msgv file using a zip tool
--New versions of infinite heaven will add more strings, I will add them to the end of the, and existing strings that I've changed will be noted at the end of it's line with it's version number,
--example:  menuOffItem="Turn off menu",--r58
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
  test="Ativações Советский ФОНАРЬ 你还不错  munición 侵入者をCQCにより無力化 ",
  menu_open_help="(Press Up/Down,Left/Right to navigate menu)",
  menuOffItem="Turn off menu",
  setting_defaults="Setting options for current menu to defaults...",--r61
  setting_default="Setting to default..",
  resetSettingsItem="Reset all settings in current menu",--r61
  setting_disallowed="is currently disallowed",
  goBackItem="Menu Back",
  menu_off="Menu Off",
  heliSpaceMenu="ACC Main Menu",--r62
  inMissionMenu="In Mission Menu",--r62
  parametersMenu="Parameters Menu",
  motherBaseMenu="Mother Base Menu",
  demosMenu="Cutscenes Menu",
  patchupMenu="Patchup Menu",
  enemyParameters="General Enemy Parameters",
  enemyHealthMult="Enemy life scale (REQ: Tweaked Enemy Parameters)",
  playerHealthMult="Player life scale",
  mbSoldierEquipGrade="DD Equip Grade",
  mbSoldierEquipRange="DD Equip Range",
  mbDDSuit="DD Suit (Requires Equip Grade On)",
  mbWarGames="Mother Base War Games",
  startOnFoot="Start missions on foot",
  clockTimeScale="Clock time scale",
  unlockPlayableAvatar="Unlock playable avatar",
  returnQuietItem="Return Quiet (not reversable)",
  quiet_already_returned="Quiet has already returned.",
  subsistenceProfile="Subsistence Mode",
  ospWeaponLoadout="OSP Weapon Loadout",
  revengeMode="Enemy Preparedness",
  forceSoldierSubType="Force enemy CP sub type",
  unlockSideOps="Unlock random Sideops for areas",
  unlockSideOpNumber="Open specific sideop #",
  useSoldierForDemos="Use selected soldier in cutscenes",
  mbDemoSelection="MB cutscene play mode",
  mbSelectedDemo="Select MB cutscene (REQ: Play selected)",
  set_switch={"Off","On"},
  set_do={">",">"},
  set_menu_off={">","Off"},
  set_menu_reset={">","Reset"},
  set_goBackItem={">","Back"},
  set_enemy_parameters={"Default (mods can override)","Tweaked"},
  set_dd_equip_grade={"Off","Current MB Dev","Random","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Grade 10"},
  set_dd_equip_range={"Default (FOB Setting)", "All Short", "All Medium","All Long","Random"},
  set_dd_suit={"Use Equip Grade", "Tiger","Sneaking","Battle Dress","PF Riot Suit"},
  set_mb_wargames={"Off","DD Non Lethal","DD Lethal"},
  set_mbDemoSelection={"Default","Cutscenes disabled","Play selected"},
  set_quiet_return={">","Returned"},
  set_subsistence={"Off","Pure (OSP -Items -Hand -Suit -Support -Fulton -Vehicle -Buddy)","Bounder (Pure +Buddy +Suit +Fulton)"},
  set_osp={"Off","Pure - all cleared","Secondary free","Tertiary free","Primary only cleared","Seconday only cleared"},--r58
  set_revenge={"Regular","Max"},
  set_unlock_sideops={"Off","Force Replayable","Force Open"},
  showLangCodeItem="Show game language code",--r57
  language_code="Language Code",--r58
  showPositionItem="Show position",--r58
  langOverride="Mod Menu translation override",--r60
  set_lang_override={"Off","Chinese override Japanese"},--r60
}

this.ara={--arabic, unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus, untranslated, copy lines from eng to start on
  test="TestAra",
}

this.cht={--chinese traditional, translation by rikimtasu,  unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus
  test="TestCht",
  menu_open_help="(按上/下，左/右选择菜单)",
  menuOffItem="关闭菜单",
  setting_defaults="Setting options for current menu to defaults...",--r61
  setting_default="回归默认设置..",
  resetSettingsItem="回归全部设置",--r61
  setting_disallowed="目前不允许",
  goBackItem="返回菜单",
  menu_off="关闭菜单",
  heliSpaceMenu="ACC Main Menu",--r62
  inMissionMenu="In Mission Menu",--r62
  parametersMenu="参数菜单",
  motherBaseMenu="主要基地菜单",
  demosMenu="动画菜单",
  patchupMenu="补丁菜单",
  enemyParameters="一般敌人参数",
  enemyHealthMult="敌人生命比例 (需要: 修正敌人参数)",
  playerHealthMult="玩家生命比例",
  mbSoldierEquipGrade="DD 装备等级",
  mbSoldierEquipRange="DD 装备范围",
  mbDDSuit="DD 装 (需要装备等级启动)",
  mbWarGames="主要基地战争游戏",
  startOnFoot="徒步开始任务",
  clockTimeScale="时钟时间比例",
  unlockPlayableAvatar="解锁Avatar",
  returnQuietItem="静静回归 (不可逆转)",
  quiet_already_returned="静静已经回来了.",
  subsistenceProfile="Subsistence 模式",
  ospWeaponLoadout="OSP 武器装备",
  revengeMode="敌人准备度",
  forceSoldierSubType="强制敌人CP子类型",
  unlockSideOps="解锁随机支線任務地区",
  unlockSideOpNumber="解锁特定支線任務 #",
  useSoldierForDemos="在过场动画中使用特定士兵",
  mbDemoSelection="MB 过场动画播放模式",
  mbSelectedDemo="选择MB过场动画 (需要: 选择播放)",
  set_switch={"关闭","开启"},
  set_do={">",">"},
  set_menu_off={">","关闭"},
  set_menu_reset={">","重置"},
  set_goBackItem={">","回"},
  set_enemy_parameters={"默认（MODS可以覆盖）","以调整"},
  set_dd_equip_grade={"关闭","当前MB开发进度","随机","等级 1","等级 2","等级 3","等级 4","等级 5","等级 6","等级 7","Grade 8","Grade 9","Grade 10"},
  set_dd_equip_range={"默认 (FOB 设定)", "全短", "全中","全长","随机"},
  set_dd_suit={"使用装备等级", "虎","潜行","战袍","PF防暴服"},
  set_mb_wargames={"关闭","DD 非致命","DD 致命"},
  set_mbDemoSelection={"默认","禁用过场动画","选择播放"},
  set_quiet_return={">","回去"},
  set_subsistence={"关闭","纯洁 (OSP -东西 -手臂 -衣服 -支源 -富尔顿 -车辆 -伙伴)","畛 (纯洁 +伙伴 +衣服 +富尔顿)"},
  set_osp={"关闭","纯洁 - all cleared","不带第二武器","不带第三武器","Primary only cleared","Seconday only cleared"},--r58
  set_revenge={"正规","Max"},
  set_unlock_sideops={"关闭","强迫重玩","强迫开放"},
  showLangCodeItem="Show game language code",--r57
  language_code="Language Code",--r58
  showPositionItem="Show position",--r58
}

this.fre={--french, untranslated, untranslated, copy lines from eng to start on
  test="TestFre",
}

this.ger={--german, untranslated, untranslated, copy lines from eng to start on
  test="TestGer",
}

this.ita={--italian, untranslated, untranslated, copy lines from eng to start on
  test="TestIta",
}

this.jpn={--japanese, untranslated, untranslated, copy lines from eng to start on
  test="TestJpn",
}

this.kor={--korean, unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus, untranslated, copy lines from eng to start on
  test="TestKor",
}

this.por={--portugese, untranslated, copy lines from eng to start on
  test="TestPor",
}

this.rus={--russian, untranslated, copy lines from eng to start on
  test="TestRus",
}

this.spa={--spanish, untranslated, copy lines from eng to start on
  test="TesSpa",
}

return this
