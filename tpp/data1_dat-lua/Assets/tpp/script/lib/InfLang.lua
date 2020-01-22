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
  mbSoldierEquipRange="MB Equip Range (MB Prep mode FOB only)",
  mbDDSuit="DD Suit",
  mbWarGamesProfile="Mother Base War Games",
  startOnFoot="Start missions on foot",
  clockTimeScale="Clock time scale",
  unlockPlayableAvatar="Unlock playable avatar",
  returnQuiet="Return Quiet (not reversable)",
  quiet_already_returned="Quiet has already returned.",
  subsistenceProfile="Subsistence profile",
  revengeMode="Free roam prep mode",
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
  --CULL set_dd_equip_grade={"Off","Developed","Random","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Grade 10"},
  set_dd_equip_range={"Short","Medium","Long","Random"},
  mbWarGamesProfileSettings={"Off","DD Training","Enemy Invasion","DD Infection","Zombie Obliteration (non DD)"},
  set_mbDemoSelection={"Default","Play selected","Cutscenes disabled"},
  set_quiet_return={">","Returned"},
  subsistenceProfileSettings={"Off","Pure","Bounder","Custom"},
  set_unlock_sideops={"Off","Force Replayable","Force Open"},
  showLangCode="Show game language code",--r57
  language_code="Language code",--r58
  showPosition="Show position",--r58
  langOverride="Mod Menu translation override",--r60
  set_lang_override={"Off","Chinese override Japanese"},--r60
  ospWeaponProfile="OSP Weapon Profile",--r68
  ospWeaponProfileSettings={"Off","Pure - all cleared","Secondary free","Custom"},--r68
  primaryWeaponOsp="Primary weapon OSP",--r68
  secondaryWeaponOsp="Secondary weapon OSP",--r68
  tertiaryWeaponOsp="Back Weapon OSP",--r68
  weaponOspSettings={"Use selected weapon","Clear weapon"},--r68
  playerRestrictionsMenu="Player restrictions menu",--r68
  setting_all_defaults="Setting all settings to default...",--r69
  revenge_reset="Enemy prep levels reset",--r70-v-
  revengeMenu="Enemy Prep Menu",
  sideOpsMenu="Side ops Menu",
  resetAllSettingsItem="Reset all Infinite Heaven settings",
  disableHeadMarkers="Disable head markers",
  disableBuddies="Disable buddies",
  disableHeliAttack="Disable support heli attack",
  disableSelectTime="Disable select sortie time",
  disableSelectVehicle="Disable select vehicle",
  disableFulton="Disable fulton action",
  clearItems="Items OSP",
  clearSupportItems="Support items OSP",
  setSubsistenceSuit="Set subsistence suit - Olive Drab, no headgear",
  setDefaultHand="Set default hand",
  handLevelMenu="Hand levels Menu",
  fultonLevelMenu="Fulton levels Menu",
  ospMenu="Weapon OSP Menu",
  disableMenuMenu="Disable mission support-menus menu",
  disableMenuDrop="Disable Supply drop support-menu",
  disableMenuBuddy="Disable Buddies support-menu",
  disableMenuAttack="Disable Attack support-menu",
  disableMenuHeliAttack="Disable Heli attack support-menu",
  disableSupportMenu="Disable Support-Menu",
  fultonLevelProfile="Fulton Levels profile",
  fultonLevelProfileSettings={"Default/No override","Fulton Min, Wormhole off","Max","Custom"},
  itemLevelFulton="Fulton Level",
  itemLevelWormhole="Wormhole Level",
  handLevelProfile="Hand Levels profile",
  handLevelProfileSettings={"Default","All Off","All max","Custom"},
  handLevelSonar="Sonar level",
  handLevelPhysical="Mobility level",
  handLevelPrecision="Precision level",
  handLevelMedical="Medical level",
  resetRevenge="Reset enemy preparedness levels",
  revengeBlockForMissionCount="Resupply in #missions",
  showMissionCode="Show missionCode",
  showMbEquipGrade="Show MB equip grade",
  noCentralLzs="Disable central landing zones",
  motherBaseShowAssetsMenu="Show assets Menu",--r73-v-
  mbShowBigBossPosters="Show Big Boss posters",
  mbShowQuietCellSigns="Show quiet cell signs",
  mbShowMbEliminationMonument="Show nuke elimination monument",
  mbShowSahelan="Show Sahelanthropus",
  mbShowEli="Show Eli",
  mbShowCodeTalker="Show Code Talker",
  mbUnlockGoalDoors="Unlock goal doors",
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
  quietRadioMode="Quiets cell radio track (0=Auto)",--r88
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
  menu_keys="Hold <Quick dive> to open menu",
  soldierAlertOnHeavyVehicleDamage="Phase on vehicle attack",--r95
  forceSuperReinforce="Enable vehicle reinforce (only heli in free, vehicles depend on mission)",--r96
  forceSuperReinforceSettings={"Off","Enemy Prep","Force Prep"},
  forceReinforceRequest="Force reinforce request",
  enableHeliReinforce="Force enable enemy heli reinforce (disable heli sideops)",
  enemyReinforceMenu="Enemy reinforcements menu",
  heli_hold_pulling_out="Holding",--r97
  disableReinforceHeliPullOut="Disable reinforce heli pullout",--r98,
  vehiclePatrolMenu="Vehicle patrols menu",--r99
  vehiclePatrolProfile="Vehicle patrols profile",
  vehiclePatrolProfileSettings={"Game default - trucks only","All of one type (random from enabled)","Each vehicle differing type (random from enabled)"},
  vehiclePatrolLvEnable="Enable jeeps",
  vehiclePatrolTruckEnable="Enable trucks",
  vehiclePatrolWavEnable="Enable wheeled armored vehicles",
  vehiclePatrolWavHeavyEnable="Enable heavy wheeled armored vehicles",
  vehiclePatrolTankEnable="Enable tanks",
  setDemon="Add demon points",--r102
  set_demon=" demon points subtracted, visual will refresh on mission start or retry command.",
  removeDemon="Subtract demon points",
  removed_demon=" demon points subtracted, visual should refresh on mission start or retry command.",
  fultonSuccessMenu="Fulton success menu",--r104
  fultonSuccessProfile="Fulton success profile",
  fultonSuccessProfileSettings={"Default","Heaven","Custom"},
  fultonNoMbSupport="Disable MB fulton support",
  fultonNoMbMedical="Disable MB fulton medical",
  fultonDyingPenalty="Target dying penalty",
  fultonSleepPenalty="Target sleeping penalty",
  fultonHoldupPenalty="Target holdup penalty",
  fultonDontApplyMbMedicalToSleep="Dont apply MB medical to sleeping/fainted target",
  fulton_mb_support="Current MB support bonus +",
  fulton_mb_medical="Current MB medical bonus +",
  applyPowersToOuterBase="Apply enemy prep to guard posts",--r105
  applyPowersToLrrp="Apply enemy prep to patrol soldiers",
  allowHeavyArmorInFreeRoam="Allow heavy armor in free roam (has issues)",
  allowHeavyArmorInAllMissions="Allow heavy armor in all missions (may have issues)",
  allowHeadGearCombo="Allow helmet and NVG or Gas mask combo",--r108
  balanceHeadGear="Ballance heavy armor and head gear distribution",
  changeCpSubTypeFree="Random CP subtype in free roam",--r109 
  changeCpSubTypeForMissions="Random CP subtype in missions",
  done="Done",--r112
  forceAllQuestOpenFlagFalse="Set questOpenFlag array to false",
  disableMissionsWeaponRestriction="Disable weapon restrictions in certain missions",
  balanceWeaponPowers="Balance primary weapon distribution",
  allowMissileWeaponsCombo="Allow missile combo with other weapons",
  disableConvertArmorToShield="Disable convert armor to shield (if armor off)",
  revengeProfile="Enemy prep system profile",--r113
  revengeProfileSettings={"Default","Heaven","Custom"},
  enableMgVsShotgunVariation="Enable Mg vs Shotgun variation",
  randomizeSmallCpPowers="Balance small CPs",
  mbDDHeadGear="DD Head gear",--r115
  mbDDHeadGearSettings={"Off","Current prep"},
  mbDDSuitSettings={
    "Off",
    "Use Equip Grade",
    "Drab",
    "Tiger",
    "Sneaking",
    "Battle Dress",
    "PF Riot Suit",
    "XOF",
    "Soviet",
    "Soviet Urban",
    "CFA",
    "ZRS",
    "Rogue Coyote",
    "Soviet berets",
    "Soviet hoodies",
    "Soviet All",
    "PF misc",
    "PF All",
  },
  revengeCustomMenu="Custom prep menu",--r117
  revengeSystemMenu="Prep system menu",
  revengeModeSettings={"Enemy prep levels","Custom prep"},
  weaponPowersMenu="Weapon deployment",
  armorPowersMenu="Armor deployment",
  gearPowersMenu="Headgear deployment",
  cpEquipPowersMenu="CP deterrent deployment",
  abilityCustomMenu="Soldier abilities",
  reinforceLevel_MIN="Vehicle reinforcement level min",
  reinforceLevel_MAX="Vehicle reinforcement level max",
  printCustomRevengeConfig="Calculate example config (look in log - all tab)",
  revengeModeForMissions="Missions prep mode",
  revengeIgnoreBlocked_MIN="Ignore combat-deploy supply blocks min",
  revengeIgnoreBlocked_MAX="Ignore combat-deploy supply blocks max",
  reinforceCount_MIN="Reinforce count min",
  reinforceCount_MAX="Reinforce count max",
  weaponStrengthCustomMenu="Weapon strength menu",
  min="min",
  max="max",
  revengeConfigProfile="Custom prep profile",
  revengeConfigProfileSettings={"DEFAULT","MAX","MIN","UPPER","LOWER","CUSTOM"},
  enableSoldiersWithVehicleReinforce="Soldier reinforce with all vehicle reinforce types",--r120    
  dDEquipMenu="DD Equip menu",
  enableMbDDEquip="MB use DD equipment",
  mbSoldierEquipGrade_MIN="DD Equip Grade Min",
  mbSoldierEquipGrade_MAX="DD Equip Grade Max",
  allowUndevelopedDDEquip="Allow undeveloped DD equipment",
  revengeModeSettings={"Enemy prep levels","Custom prep"},--121
  revengeModeForMb="Mother base prep mode",
  revengeModeForMbSettings={"Off","FOB style","Enemy prep levels","Custom prep"},
  mbDemoOverrideTime="Override time",
  mbDemoOverrideTimeSettings={"Cutscene default","Current","Custom"},
  mbDemoHour="Hour",
  mbDemoMinute="Minute",
  mbDemoOverrideWeather="Override weather",
  mbDemoOverrideWeatherSettings={"Cutscene default","Current","Sunny","Cloudy","Rainy","Sandstorm","Foggy","Pouring"},
  cpEquipBoolPowersMenu="CP equip strength menu",
  adjustCameraUpdate="Adjust-cam mode",--r123
  cam_mode_on="Adjust-cam mode on",
  cam_mode_off="Adjust-cam mode off",
  moveScale="Cam speed scale",
  cameraMode="Camera mode",
  cameraModeSettings={"Default","Free cam"},--"Player","Free cam"},
  cameraMenu="Camera menu",
  focal_length_mode="Focal length mode",
  aperture_mode="Aperture mode",
  focus_distance_mode="Focus distance mode",
  vertical_mode="Vertical mode",
  reset_mode="Reset mode",
  resetCameraSettings="Set cam to near player",
  other_control_active="Another control mode is active",
  disableRetry="Disable retry",
  gameOverOnDiscovery="Game over on combat alert",
  enableEnemyDDEquip="Enemy use DD equipment in Free roam",
  enableEnemyDDEquipMissions="Enemy use DD equipment in missions",--r125
  cannot_edit_default_cam="Cannot adjust Camera mode Default",
  distance_mode="Distance mode",
  fultonHostageHandling="Hostage handling",
  fultonHostageHandlingSettings={"Default","Must extract (0%)"},
  blockInMissionSubsistenceIvars="Block in-mission menu restriction options",
  disableCamText="Disable mode text feedback",--r128
  mbDDEquipNonLethal="MB DD Equip non-lethal",
  mbDDSuitFemale="DD Suit female",--r130
  mbDDSuitFemaleSettings={"Use Equip Grade","Drab","Tiger","Sneaking","Battle Dress"},
  mbPrioritizeFemale="Female staff selection",
  mbPrioritizeFemaleSettings={"Default","None","All available"},
  footPatrolMenu="Foot patrols Menu",--r131
  enableLrrpFreeRoam="Foot patrols in free roam",
  lrrpSizeFreeRoam_MIN="Patrol size min",
  lrrpSizeFreeRoam_MAX="Patrol size max",
  soldierHearingDistScale="Soldier hearing distance scale",
  printHearingTable="Print hearing distance table (look in log - all tab)",
  enemyPatrolMenu="Enemy patrols menu",
  enableWildCardFreeRoam="Enable Wildcard soldiers Free roam",--r132
  disableWorldMarkers="Disable world markers",
  playerRestrictionsInMissionMenu="Markers menu",
  mbEnableOcelot="Enable Ocelot",--r135
  mbCollectionRepop="Repopulate plants and diamonds",--r136
  npcHeliUpdate="Enable npc helis",
  mbWargameFemales="Women in Enemy Invasion mode",
  mbEnemyHeliColor="Heli type in Enemy Invasion mode",
  mbEnemyHeliColorSettings={"Black","Red"},
}

this.eng_help={
  unlockSideOps="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area.",
  ospWeaponProfile="Start with no primary and secondary weapons, can be used seperately from subsistence profile",
  mbDemoSelection="Forces or Disables cutscenes that trigger under certain circumstances on returning to Mother Base",
  fultonNoMbSupport="Disregards the success bonus from mother base support section, in the base game this is mostly used to counter weather penalty.",
  fultonNoMbMedical="Disregards the success bonus from mother base medical section, in the base game this used to counter injured target penalty",
  enableMgVsShotgunVariation="In the default game the enemy prep config chooses randomly either MG or Shotguns which is applied for all CPs in the whole mission. This setting allows mixed MGs and Shotguns (but still with the enemy prep total) and also applies them per CP.",--r113
  allowMissileWeaponsCombo="In the default game soldiers with missiles only have SMGs, this allows them to have MGs, shotguns or assault rifles assigned to them.",
  randomizeSmallCpPowers="Adds limits and some randomisation to small cp/lrrps enemy prep application",
  disableMissionsWeaponRestriction="Missions 2, 12, 13, 16, 26, 31 prevent the application of shields, missiles, shotguns and mgs to the general CP enemy prep (though some may have custom enemy prep).",
  disableConvertArmorToShield="Where heavy armor is disabled (free roam by default) the normal game converts armor to shields in addition to the normal shield application, this often leads to it feeling like there's just too many.",
  balanceHeadGear="- adjusts application percentages of the normally mutally exclusive options of heavy armor and the different headgear pieces, not nessesary if Allow helmet and NVG or Gas mask combo option is on",
  changeCpSubTypeFree="Randomizes the CP subtype - PF types in middle Affrica, urban vs general camo types in Afghanistan",
  changeCpSubTypeForMissions="Randomizes the CP subtype - PF types in middle Affrica, urban vs general camo types in Afghanistan",
  mbPrioritizeFemale="By default the game tries to assign a minimum of 2 females per cluster from the females assigned to the clusters section, All available is self explanitory, None will prevent any females from showing on mother base",
}

this.ara={--arabic, unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus, untranslated, copy lines from eng to start on
  test="TestAra",
}

this.cht={--chinese traditional,  unconfirmed lang code, use the Patchup > Show language code option to get the language code and contact me on nexus
  test="TestCht",
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
