-- DOBUILD: 1
-- NODEPS
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
  motherBaseMenu="Mother Base Menu",
  demosMenu="Cutscenes Menu",
  patchupMenu="Patchup Menu",
  playerHealthScale="Player life scale",
  mbSoldierEquipGrade="DD Equip Grade",
  mbSoldierEquipRange="DD Equip Range",
  mbDDSuit="DD Suit (Requires Equip Grade On)",
  mbWarGames="Mother Base War Games",
  startOnFoot="Start missions on foot",
  clockTimeScale="Clock time scale",
  unlockPlayableAvatar="Unlock playable avatar",
  returnQuiet="Return Quiet (not reversable)",
  quiet_already_returned="Quiet has already returned.",
  subsistenceProfile="Subsistence Mode",
  revengeMode="Enemy Preparedness",
  forceSoldierSubType="Force enemy CP sub type",
  unlockSideOps="Unlock random Sideops for areas",
  unlockSideOpNumber="Open specific sideop #",
  useSoldierForDemos="Use selected soldier in all cutscenes and missions",
  mbDemoSelection="MB cutscene play mode",
  mbSelectedDemo="Select MB cutscene (REQ: Play selected)",
  set_switch={"Off","On"},
  set_do={">",">"},
  set_menu_off={">","Off"},
  --set_menu_reset={">","Reset"},
  set_goBackItem={">","Back"},
  set_dd_equip_grade={"Off","Current MB Dev","Random","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Grade 10"},
  set_dd_equip_range={"Default (FOB Setting)", "All Short", "All Medium","All Long","Random"},
  set_dd_suit={"Use Equip Grade", "Tiger","Sneaking","Battle Dress","PF Riot Suit"},
  set_mb_wargames={"Off","DD Non Lethal","DD Lethal"},
  set_mbDemoSelection={"Default","Play selected","Cutscenes disabled"},
  set_quiet_return={">","Returned"},
  subsistenceProfileSettings={"Off","Pure","Bounder","Custom"},
  set_revenge={"Default","Max"},
  set_unlock_sideops={"Off","Force Replayable","Force Open"},
  showLangCode="Show game language code",--r57
  language_code="Language Code",--r58
  showPosition="Show position",--r58
  langOverride="Mod Menu translation override",--r60
  set_lang_override={"Off","Chinese override Japanese"},--r60
  ospWeaponProfile="OSP Weapon Profile",--r68
  ospWeaponProfileSettings={"Off","Pure - all cleared","Secondary free","Custom"},--r68
  primaryWeaponOsp="Primary Weapon OSP",--r68
  secondaryWeaponOsp="Secondary Weapon OSP",--r68
  tertiaryWeaponOsp="Back Weapon OSP",--r68
  weaponOspSettings={"Use selected weapon","Clear weapon"},--r68
  playerRestrictionsMenu="Player Restrictions Menu",--r68
  setting_all_defaults="Setting all settings to default...",--r69
  revenge_reset="Enemy preparedness levels reset",--r70-v-
  revengeMenu="Enemy Preparedness Menu",
  sideOpsMenu="Side ops Menu",
  resetAllSettingsItem="Reset all Infinite Heaven settings",
  disableHeadMarkers="Disable head markers",
  disableBuddies="Disable buddies",
  disableHeliAttack="Disable heli attack",
  disableSelectTime="Disable select sortie time",
  disableSelectVehicle="Disable select vehicle",
  disableFulton="Disable fulton action",
  clearItems="Items OSP",
  clearSupportItems="Support Items OSP",
  setSubsistenceSuit="Set subsistence suit - Olive Drab, no headgear",
  setDefaultHand="Set default hand",
  handLevelMenu="Hand levels Menu",
  fultonLevelMenu="Fulton levels Menu",
  ospMenu="Weapon OSP Menu",
  disableMenuMenu="Disable mission support-menus Menu",
  disableMenuDrop="Disable Supply drop support-menu",
  disableMenuBuddy="Disable Buddies support-menu",
  disableMenuAttack="Disable Attack support-menu",
  disableMenuHeliAttack="Disable Heli attack support-menu",
  disableSupportMenu="Disable Support-Menu",
  fultonLevelProfile="Fulton Levels profile",
  fultonLevelProfileSettings={"Default/No override","Fulton Min, Wormhole off","Max","Custom"},
  itemLevelFulton="Fulton Level",
  itemLevelWormhole="Wormhole disable",
  handLevelProfile="Hand Levels profile",
  handLevelProfileSettings={"Default","All Off","All max","Custom"},
  handLevelSonar="Sonar level",
  handLevelPhysical="Mobility level",
  handLevelPrecision="Precision level",
  handLevelMedical="Medical level",
  resetRevenge="Reset enemy preparedness levels",
  revengeBlockForMissionCount="Resupply in #missions",
  showMissionCode="Show missionCode",
  showMbEquipGrade="Show mb equip grade",
  noCentralLzs="Disable central landing zones",
  motherBaseShowAssetsMenu="Show assets Menu",--r73-v-
  mbShowBigBossPosters="Show Big Boss posters",
  mbShowQuietCellSigns="Show quiet cell signs",
  mbShowMbEliminationMonument="Show nuke elimination monument",
  mbShowSahelan="Show Sahelanthropus",
  mbShowEli="Show Eli",
  mbShowCodeTalker="Show Code Talker",
  mbUnlockGoalDoors="Unlock goal doors",
  mbDontDemoDisableOcelot="Don't disable Ocelot after mb cutscenes",
  startOffline="Start offline",--r75-v-
  mbEnableBuddies="Enable all buddies",
  abortMenuItemControl="Disable abort mission from pause",--r76
  playerHeadgear="Headgear (cosmetic)",
  playerHeadgearMaleSettings={
    "Don't set",
    "Balaclava 1",
    "Balaclava 2",
    "DD heavy headgear",
    "Gas mask and balaclava",
    "Gas mask and DD headgear",
    "Gas mask and DD heavy headgear",
    "NVG and DD heavy headgear",
    "NVG, Gas mask and DD heavy headgear",
  },
  playerHeadgearFemaleSettings={
    "Don't set",
    "DD heavy headgear",
    "Gas mask and balaclava",
    "Gas mask and DD headgear",
    "Gas mask and DD heavy headgear",
    "NVG and DD heavy headgear",
    "NVG, Gas mask and DD heavy headgear",
  },
  phaseMenu="Enemy phases menu",--r80-v-
  phaseUpdate="Enable phase modifications",
  minPhase="Minimum phase",
  maxPhase="Maximum phase",
  keepPhase="Don't downgrade phase",
  phaseUpdateRate="Phase mod update rate (seconds)",
  phaseUpdateRange="Phase mod random variation",
  printPhaseChanges="Print phase changes",
  item_disabled_subsistence="Cannot be used with current Subsistence profile",
  menu_disabled="Menu is currently disabled",
  ogrePointChange="Set demon snake",
  ogrePointChangeSettings={"Default","Normal","Demon"},
  --ogrePointChange="Demon points to set",
  --giveOgrePoint="Give set demon points",
  debugInMissionMenu="Debug stuff",
  --blockFobTutorial="Block FOB tutorial",
  --setFirstFobBuilt="Set first FOB built",
  telopMode="Disable mission intro credits",--r82
  unlockWeaponCustomization="Unlock weapon customization",--r84
  allready_unlocked="Allready unlocked",--r85
  mbDontDemoDisableBuddy="Don't disable buddy after mb cutscene",--r86
  disableXrayMarkers="Disable Xray marking",--r87
  warpPlayerUpdate="Warp Mode",
  warp_mode_on="Warp mode on",
  warp_mode_off="Warp mode off",
  item_disabled="Menu item is currently disabled",
  quietRadioMode="Quiets radio track (0=Auto)",--r88
  soldierParamsProfile="Soldier Parameters Profile",--r89
  soldierParamsProfileSettings={"Off (use game/other mod settings, requires restart)","Custom"},
  soldierHealthScale="Soldier life scale",
  soldierSightDistScale="Soldier sight scale",
  printSightFormParameter="Print sight param table (look in log - all tab)",
  printHealthTableParameter="Print health param table (look in log - all tab)",
  playerSettingsMenu="Player settings menu",
  soldierParamsMenu="Soldier parameters menu",
  heli_pulling_out="Pulling out in 5",--r91
  supportHeliMenu="Support heli menu",
  setInvincibleHeli="Set heli invincible",
  disablePullOutHeli="Disable pull-out",
  setLandingZoneWaitHeightTop="Set LZ wait height",
  defaultHeliDoorOpenTime="Mission start time till open door",
  setSearchLightForcedHeli="Force searchlight",--r92
  set_disable={"On","Off"},
  order_recieved="Order recieved",
  missionEntryExitMenu="Mission entry/exit menu",
  setting_only_for_dd="This setting is only for DD soliders",--r93
  menu_keys="(Hold Spacebar or X button for 1 second to enable menu)",
  soldierAlertOnHeavyVehicleDamage="Phase on vehicle attack",--r95
  forceSuperReinforce="Enable vehicle reinforce",--r96
  forceSuperReinforceSettings={"Off","Enemy Prep","Force Prep"},
  forceReinforceRequest="Force reinforce request",
  enableHeliReinforce="Force enable enemy heli reinforce (disable heli sideops)",
  enemyReinforceMenu="Enemy reinforcements menu",
  heli_hold_pulling_out="Holding",--r97
  disableReinforceHeliPullOut="Disable reinforce heli pullout",--r98,
  vehiclePatrolMenu="Vehicle patrols menu",--r99
  vehiclePatrolProfile="Vehicle patrols profile",
  vehiclePatrolProfileSettings={"Game default","All of one type (random)","Each vehicle differing type (random)"},
  vehiclePatrolLvEnable="Enable jeeps",
  vehiclePatrolTruckEnable="Enable trucks",
  vehiclePatrolWavEnable="Enable wheeled armored vehicles",
  vehiclePatrolWavHeavyEnable="Enable heavy wheeled armored vehicles",
  vehiclePatrolTankEnable="Enable tanks",
  setDemon="Set demon",--r102
  set_demon="Demon set, visual will refresh on mission start.",
  removeDemon="Remove demon",
  removed_demon="Demon removed, visual will refresh on mission start.",
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
  resetSettings="回归全部设置",--r61
  setting_disallowed="目前不允许",
  goBackItem="返回菜单",
  menu_off="关闭菜单",
  heliSpaceMenu="ACC Main Menu",--r62
  inMissionMenu="In Mission Menu",--r62
  motherBaseMenu="主要基地菜单",
  demosMenu="动画菜单",
  patchupMenu="补丁菜单",
  playerHealthScale="玩家生命比例",
  mbSoldierEquipGrade="DD 装备等级",
  mbSoldierEquipRange="DD 装备范围",
  mbDDSuit="DD 装 (需要装备等级启动)",
  mbWarGames="主要基地战争游戏",
  startOnFoot="徒步开始任务",
  clockTimeScale="时钟时间比例",
  unlockPlayableAvatar="解锁Avatar",
  returnQuiet="静静回归 (不可逆转)",
  quiet_already_returned="静静已经回来了.",
  subsistenceProfile="Subsistence 模式",
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
  set_dd_equip_grade={"关闭","当前MB开发进度","随机","等级 1","等级 2","等级 3","等级 4","等级 5","等级 6","等级 7","等级 8","等级 9","等级 10"},
  set_dd_equip_range={"默认 (FOB 设定)", "全短", "全中","全长","随机"},
  set_dd_suit={"使用装备等级", "虎","潜行","战袍","PF防暴服"},
  set_mb_wargames={"关闭","DD 非致命","DD 致命"},
  set_mbDemoSelection={"默认","选择播放","禁用过场动画"},
  set_quiet_return={">","回去"},
  subsistenceProfileSettings={"关闭","纯洁","畛","Custom"},--r69
  set_revenge={"正规","Max"},
  set_unlock_sideops={"关闭","强迫重玩","强迫开放"},
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
