-- DOBUILD: 1
-- NODEPS
local this={}
--InfLang for Infinite Heaven
--Want to help out?
--Translation: Have a look below and see what you can do. Contact me by pm if you want more detail/want to send me your translation. You will be credited in the main infinite heaven description for your kind work.
--If you want more direction on a string contact me, some of my own english descriptions are not the best as it is, and sometime I have to shorten them to keep things managable for how it's presented in-game.
--This file does nothing by itself but you have modding knowledge can replace/edit \Assets\tpp\script\lib\InfLang.lua in the infinite heaven.msgv file using a zip tool
--New versions of infinite heaven will add more strings, and may change existing ones. Use a merge tool like WinMerge to compare between versions.
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
  heliSpaceMenu="ACC Main menu",--r62
  inMissionMenu="In Mission menu",--r62
  motherBaseMenu="Mother Base menu",
  demosMenu="Cutscenes menu",
  patchupMenu="Patchup menu",
  playerHealthScale="Player life scale",
  mbSoldierEquipGrade="DD Equip Grade",
  mbSoldierEquipRange="MB Equip Range (MB Prep mode FOB only)",
  mbDDSuit="DD Suit",
  mbWarGamesProfile="Mother Base War Games",
  clockTimeScale="Clock time scale",
  unlockPlayableAvatar="Unlock playable avatar",
  returnQuiet="Return Quiet (not reversable)",
  quiet_already_returned="Quiet has already returned.",
  quiet_return="Quiet has returned.",
  subsistenceProfile="Subsistence profile",
  revengeModeFREE="Free roam prep mode",
  revengeModeMISSION="Missions prep mode",
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
  set_goBackItem={">",">"},
  --CULL set_dd_equip_grade={"Off","Developed","Random","Grade 1","Grade 2","Grade 3","Grade 4","Grade 5","Grade 6","Grade 7","Grade 8","Grade 9","Grade 10"},
  set_dd_equip_range={"Short","Medium","Long","Random"},
  mbWarGamesProfileSettings={"Off","DD Training","Enemy Invasion","DD Infection","Zombie Obliteration (non DD)"},
  set_mbDemoSelection={"Default","Play selected","Cutscenes disabled"},
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
  revengeMenu="Enemy Prep menu",
  sideOpsMenu="Side ops menu",
  resetAllSettingsItem="Reset all Infinite Heaven settings",
  disableHeadMarkers="Disable head markers",
  disableSelectBuddy="Disable select-buddy",
  disableHeliAttack="Disable support heli attack",
  disableSelectTime="Disable select-sortie time",
  disableSelectVehicle="Disable select vehicle",
  disableFulton="Disable fulton action",
  clearItems="Items OSP",
  clearSupportItems="Support items OSP",
  setSubsistenceSuit="Force subsistence suit (Olive Drab, no headgear)",
  setDefaultHand="Set hand type to default",
  handLevelMenu="Hand abilities levels menu",
  fultonLevelMenu="Fulton levels menu",
  ospMenu="OSP menu",
  disableSupportMenuMenu="Disable mission support-menus menu",
  disableMenuDrop="Disable Supply drop support-menu",
  disableMenuBuddy="Disable Buddies support-menu",
  disableMenuAttack="Disable Attack support-menu",
  disableMenuHeliAttack="Disable Heli attack support-menu",
  disableSupportMenu="Disable Support-menu",
  fultonLevelProfile="Fulton Levels profile",
  fultonLevelProfileSettings={"Default/No override","Fulton Min, Wormhole off","Max","Custom"},
  itemLevelFulton="Fulton Level",
  itemLevelWormhole="Wormhole Level",
  handLevelProfile="Hand abilities levels profile",
  handLevelProfileSettings={"Default","All Off","All max","Custom"},
  handLevelSonar="Sonar level",
  handLevelPhysical="Mobility level",
  handLevelPrecision="Precision level",
  handLevelMedical="Medical level",
  resetRevenge="Reset enemy preparedness levels",
  revengeBlockForMissionCount="Resupply in #missions",
  showMissionCode="Show missionCode",
  showMbEquipGrade="Show MB equip grade",
  disableLzs="Disable landing zones",
  disableLzsSettings={"Off","Assault","Regular"},
  motherBaseShowAssetsMenu="Show assets menu",--r73-v-
  mbShowBigBossPosters="Show Big Boss posters",
  mbShowQuietCellSigns="Show quiet cell signs",
  mbShowMbEliminationMonument="Show nuke elimination monument",
  mbShowSahelan="Show Sahelanthropus",
  mbShowEli="Show Eli",
  mbShowCodeTalker="Show Code Talker",
  mbUnlockGoalDoors="Unlock goal doors",
  startOffline="Start offline",--r75-v-
  mbEnableBuddies="Enable all buddies",
  abortMenuItemControl="Disable abort mission from pause menu",--r76
  playerHeadgear="Headgear (cosmetic, DD characters only)",
  playerHeadgearMaleSettings={
    "Don't set (change character to reset head)",
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
    "Don't set (change character to reset head)",
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
  debugInMissionMenu="Debug stuff menu",
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
  printSightFormParameter="Print sight param table (look in iDroid Log>All tab)",
  printHealthTableParameter="Print health param table (look in iDroid Log>All tab)",
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
  soldierAlertOnHeavyVehicleDamage="Alert phase on vehicle attack",--r95
  forceSuperReinforce="Vehicle reinforcements (only heli in free roam, vehicles depend on mission)",--r96
  forceSuperReinforceSettings={"Off","Enemy Prep","Force Prep"},
  forceReinforceRequest="Force reinforce request for heli",
  enableHeliReinforce="Force enable enemy heli reinforce (disable heli sideops)",
  enemyReinforceMenu="Enemy reinforcements menu",
  heli_hold_pulling_out="Holding",--r97
  disableReinforceHeliPullOut="Disable reinforce heli pull-out",--r98,
  vehiclePatrolMenu="Vehicle patrols menu",--r99
  vehiclePatrolProfile="Vehicle patrols in free roam profile",
  vehiclePatrolProfileSettings={"Game default - trucks only","All of one type (random from enabled)","Each vehicle differing type (random from enabled)"},
  vehiclePatrolLvEnable="Allow jeeps",
  vehiclePatrolTruckEnable="Allow trucks",
  vehiclePatrolWavEnable="Allow wheeled armored vehicles",
  vehiclePatrolWavHeavyEnable="Allow heavy wheeled armored vehicles",
  vehiclePatrolTankEnable="Allow tanks",
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
  fultonDontApplyMbMedicalToSleep="Dont apply MB medical bonus to sleeping/fainted target",
  fulton_mb_support="Current MB support bonus +",
  fulton_mb_medical="Current MB medical bonus +",
  applyPowersToOuterBase="Apply enemy prep to guard posts",--r105
  applyPowersToLrrp="Apply enemy prep to patrol soldiers",
  allowHeavyArmorFREE="Allow heavy armor in free roam (has issues)",
  allowHeavyArmorMISSION="Allow heavy armor in all missions (may have issues)",
  allowHeadGearCombo="Allow helmet and NVG or Gas mask combo",--r108
  balanceHeadGear="Ballance heavy armor and head gear distribution",
  changeCpSubTypeFREE="Random CP subtype in free roam",--r109
  changeCpSubTypeMISSION="Random CP subtype in missions",
  done="Done",--r112
  forceAllQuestOpenFlagFalse="Set questOpenFlag array to false",
  disableMissionsWeaponRestriction="Disable weapon restrictions in certain missions",
  balanceWeaponPowers="Balance primary weapon distribution",
  allowMissileWeaponsCombo="Allow missile combo with other weapons",
  disableConvertArmorToShield="Disable convert armor to shield (if armor off)",
  revengeProfile="Enemy prep system profile",--r113
  revengeProfileSettings={"Default","Heaven","Custom"},
  enableMgVsShotgunVariation="Mg vs Shotgun variation",
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
  printCustomRevengeConfig="Print example current config (look in iDroid Log>All tab)",
  revengeIgnoreBlocked_MIN="Ignore combat-deploy supply blocks min",
  revengeIgnoreBlocked_MAX="Ignore combat-deploy supply blocks max",
  reinforceCount_MIN="Reinforce calls min",
  reinforceCount_MAX="Reinforce calls max",
  weaponStrengthCustomMenu="Weapon strength menu",
  min="min",
  max="max",
  revengeConfigProfile="Custom prep profile",
  revengeConfigProfileSettings={"DEFAULT","MAX","MIN","UPPER","LOWER","CUSTOM"},
  enableSoldiersWithVehicleReinforce="Soldier reinforce with all vehicle reinforce types",--r120
  dDEquipMenu="DD Equip menu",
  enableDDEquipMB="MB staff use DD equipment",
  enableDDEquipFREE="Enemy use DD equipment in Free roam",
  enableDDEquipMISSION="Enemy use DD equipment in missions",--r125
  mbSoldierEquipGrade_MIN="DD Equip Grade RND MIN",
  mbSoldierEquipGrade_MAX="DD Equip Grade RND MAX",
  allowUndevelopedDDEquip="Allow undeveloped DD equipment",
  revengeModeSettings={"Enemy prep levels","Custom prep"},--121
  revengeModeMB="Mother base prep mode",
  revengeModeMBSettings={"Off","FOB style","Enemy prep levels","Custom prep"},
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
  speed_mode="Speed mode",
  reset_mode="Reset mode",
  resetCameraSettings="Set cam to near player",
  other_control_active="Another control mode is active",
  disableRetry="Disable retry on mission fail",
  gameOverOnDiscovery="Game over on combat alert",
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
  footPatrolMenu="Foot patrols menu",--r131
  enableLrrpFreeRoam="Foot patrols in free roam",
  lrrpSizeFreeRoam_MIN="Patrol size min",
  lrrpSizeFreeRoam_MAX="Patrol size max",
  soldierHearingDistScale="Soldier hearing distance scale",
  printHearingTable="Print hearing distance table (look in iDroid Log>All tab)",
  enemyPatrolMenu="Enemy patrols menu",
  enableWildCardFreeRoam="Wildcard soldiers Free roam",--r132
  disableWorldMarkers="Disable world markers",
  playerRestrictionsInMissionMenu="Markers menu",
  mbEnableOcelot="Enable Ocelot",--r135
  mbCollectionRepop="Repopulate plants and diamonds",--r136
  npcHeliUpdate="NPC helis",
  mbWargameFemales="Women in Enemy Invasion mode",
  mbEnemyHeliColor="Attack heli class",
  mbEnemyHeliColorSettings={"Default","Black","Red","All one random type","Each heli random type","Enemy prep"},
  warpToCamPos="Warp body to FreeCam position",--r139
  fovaModMenu="Form Variation menu",--r141
  no_fova_found="No fova for model",
  enableFovaMod="Use selected fova",
  fova_is_not_set="Use fova is off, selected fova will not be applied on mission",
  disabled_fova="Player model changed, disabling Use fova",
  change_model_to_reset_fova="Model will reset on mission start, or mission prep character change",
  printBodyInfo="Print current body info",
  userMarkerMenu="User marker menu",--r142
  warpToUserMarker="Warp to latest marker",
  printLatestUserMarker="Print latest marker",
  printUserMarkers="Print all markers",
  npcHeliUpdateSettings={"Off","Support helis","Support and Attack helis"},--r144
  missionPrepRestrictionsMenu="Mission-prep restrictions menu",
  markersMenu="Marking display menu",
  startOnFootFREE="Start free roam on foot",--r145
  startOnFootMISSION="Start missions on foot",
  startOnFootMB_ALL="Start Mother base on foot",
  onFootSettingsNames={"Off","All but assault LZs","All LZs"},
  enemyHeliPatrol="Heli patrols in free roam",
  enemyHeliPatrolSettingNames={"None","1","3","5","7","Enemy prep"},
  mbMoraleBoosts="Staff-wide morale boost for good visit",--r146
  mb_morale_visit_noticed="Word has spread of your visit",
  mb_morale_boosted="Staff-wide morale has improved due to your visit",
  enableInfInterrogation="IH interrogation in free roam",--r148
  resetPaz="Reset Paz state to beginning",
  paz_reset="Paz reset",
  motherBaseShowCharactersMenu="Show characters menu",
  quietMoveToLastMarker="Quiet move to last marker",--r149
  buddy_not_quiet="Current buddy is not Quiet",
  mbEnablePuppy="Puppy DDog",
  mbEnablePuppySettings={"Off","Missing eye","Normal eyes"},
  cpAlertOnVehicleFulton="CP alert on vehicle fulton",
  disableNoStealthCombatRevengeMission="Allow Enemy Prep shift after free roam",
  revengeDecayOnLongMbVisit="Enemy prep decrease on long MB visit",
  mb_visit_revenge_decay="Enemy prep has decreased during your absence from the field",
  phase_modification_enabled="Phase modifications enabled",
  disableSpySearch="Disable Intel team enemy spotting",
  disableHerbSearch="Disable Intel team herb spotting (requires game restart)",
  restart_required="Will change on next game restart",
  enableWalkerGearsMB="Walker gears",
  mbWalkerGearsColor="Walker gears type",
  mbWalkerGearsColorSettingNames={
    "Soviet",
    "Rogue Coyote",
    "CFA",
    "ZRS",
    "Diamond Dogs",
    "Hueys Prototype (texture issues)",
    "All one random type",
    "Each gear random type",
  },
  mbWalkerGearsWeapon="Walker gears weapons",
  mbWalkerGearsWeaponSettingNames={
    "Even split of weapons",
    "Minigun",
    "Missiles",
    "All one random type",
    "Each gear random type",
  },
  vehiclePatrolClass="Vehicle patrol class",
  vehiclePatrolClassSettingNames={"Default","Dark grey","Red","All one random type","Each vehicle random type","Enemy prep"},
  event_announce="Event: %s",--event name
  event_forced="Event will start on next MB visit or Free Roam",
  forceGameEvent="Trigger random IH event",
  gameEventChanceMB="MB event random trigger chance",
  gameEventChanceFREE="Free roam event random trigger chance",
  interrogate_lrrp="[Intel] the soldier indicates a LRRP is traveling between %s and %s",--cp name 1, cp name 2
  interrogate_wildcard="[Intel] the soldier indicates there was a mercenary assigned to %s",--cp name
  interrogate_heli="[Intel] the soldier indicates an attack heli is travelling to %s",--cp name
  intercp_comrade_location="[Intel] the soldier indicates his comrade assigned to %s has stashed some things",--cp name
  intercp_complete="[Intel] the soldier has given us the location of their stash",
  intercp_repeat="[Intel] the soldier is just repeating himself",
  no_marker_found="No marker found",
  cant_find_quiet="Can't find Quiet",
  debugMode="Debug IH mode",
  debugMenu="Debug/system menu",
  events_mb={
    "DD Training wargame",
    "Soviet attack",
    "Rogue Coyote attack",
    "XOF attack",
    "DD Infection outbreak",
    "Zombie Obliteration (non DD)",
  },
  mbAdditionalSoldiers="More soldiers on MB plats",
  mbNpcRouteChange="Soldiers move between platforms",
  itemDropChance="Soldier item drop chance",
}--eng end

this.help={}
this.help.eng={
  clockTimeScale="Changes the time scale of the day/night/weather system. Does not change the speed of soldiers like the cigar does. Lower for closer to real time, higher for faster.",
  playerRestrictionsMenu="Settings to customize the game challenge, including subsistence and OSP.",
  subsistenceProfile="Quickly set restrictions similar to Subsistence missions. Pure - similar to the games Subsistence mission settings with additional restrictions, Bounder - a bit more relaxed than Pure profile, mainly allowing any character as well as buddies.",
  disableLzs="Disables Assault Landing Zones (those usually in the center of a base that the support heli will circle before landing), or all LZs but Assault LZs",
  disableHeadMarkers="Disables markers above soldiers and objects",
  disableWorldMarkers="Disables objective and placed markers",
  disableXrayMarkers="Disables the 'X-ray' effect of marked soldiers. Note: Buddies that mark still cause the effect.",
  disableSupportMenuMenu="Disables mission support menus in iDroid",
  fultonSuccessMenu="Adjust the success rate of fultoning",
  fultonNoMbSupport="Disregards the success bonus from mother base support section, in the base game this is mostly used to counter weather penalty.",
  fultonNoMbMedical="Disregards the success bonus from mother base medical section, in the base game this used to counter injured target penalty",
  fultonDontApplyMbMedicalToSleep="Lets you balance sleeping penalty separately from dying while keeping mb medical bonus.",
  ospMenu="Allows you to enter a mission with primary, secondary, back weapons set to none, individually settable. Separate from subsistence mode (but subsistence uses it).",
  ospWeaponProfile="Start with no primary and secondary weapons, can be used seperately from subsistence profile",
  blockInMissionSubsistenceIvars="Block changing player restrictions from the in-mission menu",
  setDemon="Adds 999999 points to demon score",--SYNC
  removeDemon="Subtracts 999999 points from demon score",--SYNC
  fovaModMenu="Form Variation support for player models (requires model swap to support it), the fova system is how the game shows and hides sub-models.",
  soldierParamsMenu="Enemy soldier parameters",
  soldierParamsProfile="Due to the way Soldier2ParameterTables.lua is set up turn this off if you have another mod that modifies this, usually just Hardcore mod.",
  phaseMenu="Adjust minimum and maximum alert phase for enemy Command Posts",
  phaseUpdate="The Minimum, Maximum, and Don't downgrade phase settings are applied on at every update tick according to the Phase update rate and random variation settings",
  minPhase="PHASE_SNEAK - not alert, PHASE_CAUTION - alert, PHASE_EVASION - one step down from combat alert, PHASE_ALERT - combat alert",
  minPhase="PHASE_SNEAK - not alert, PHASE_CAUTION - alert, PHASE_EVASION - one step down from combat alert, PHASE_ALERT - combat alert",
  phaseUpdateRate="Rate that the minimum and maxium phase of CPs are modified.",
  phaseUpdateRange="Random variation of update rate",
  soldierAlertOnHeavyVehicleDamage="Does not require phase modifications setting to be enabled. The enemy reactions to heavy vehicle attack in the default game are lacking, you can kill someone and they'll act as if it's an unsourced attack. This option changes phase of soldiers command post on damaging the soldier. Setting it to ALERT recommended.",
  printPhaseChanges="Displays when phase changes.",
  resetRevenge="Resets enemy prep levels to 0",
  revengeCustomMenu="Lets you set the individual values that go into an enemy prep configuration (does not use the enemy prep levels), a random value between MIN and MAX for each setting is chosen on mission start. The order of items in the menu is generally order the equipment is allocated to each soldier in a CP.",
  weaponStrengthCustomMenu="Whether to deploy the stronger weapon class for the weapon type",
  reinforceCount_MIN="The number of times reinforcements can be called",
  reinforceCount_MAX="The number of times reinforcements can be called",
  revengeBlockForMissionCount="The number of missions the enemy dispatch/resupply with unlock after your last successful dispatch mission for that type.",
  enableMgVsShotgunVariation="In the default game the enemy prep config chooses randomly either MG or Shotguns which is applied for all CPs in the whole mission. This setting allows mixed MGs and Shotguns (but still with the enemy prep total) and also applies them per CP.",--r113
  allowMissileWeaponsCombo="In the default game soldiers with missiles only have SMGs, this allows them to have MGs, shotguns or assault rifles assigned to them.",
  randomizeSmallCpPowers="Adds limits and some randomisation to small cp/lrrps enemy prep application",
  disableMissionsWeaponRestriction="Missions 2, 12, 13, 16, 26, 31 prevent the application of shields, missiles, shotguns and mgs to the general CP enemy prep (though some may have custom enemy prep).",
  disableConvertArmorToShield="Where heavy armor is disabled (free roam by default) the normal game converts armor to shields in addition to the normal shield application, this often leads to it feeling like there's just too many.",
  balanceHeadGear="Adjusts application percentages of the normally mutally exclusive options of heavy armor and the different headgear pieces, not nessesary if Allow helmet and NVG or Gas mask combo option is on",
  changeCpSubTypeFREE="Randomizes the CP subtype - PF types in middle Affrica, urban vs general camo types in Afghanistan",
  changeCpSubTypeMISSION="Randomizes the CP subtype - PF types in middle Affrica, urban vs general camo types in Afghanistan",
  mbPrioritizeFemale="By default the game tries to assign a minimum of 2 females per cluster from the females assigned to the clusters section, All available will select females first when trying to populate a MB section, None will prevent any females from showing on mother base",
  disableNoStealthCombatRevengeMission="By default enemy prep only changes in response to actual missions, this option allows enemy prep changes to be applied after leaving Free roam (but not via abort)",
  disableMissionsWeaponRestriction="Missions 2, 12, 13, 16, 26, 31 normally prevent the application of shields, missiles, shotguns and MGs to the general CP enemy prep (though some may have custom enemy prep).",
  markersMenu="Toggles for marking in main view. Does not effect marking on iDroid map",
  unlockSideOps="Sideops are broken into areas to stop overlap, this setting lets you control the choice of sideop within the area.",
  mbDemoSelection="Forces or Disables cutscenes that trigger under certain circumstances on returning to Mother Base",
  debugMode="Switches on some error messages and enables the announce-log during loading.",
  gameEventChanceMB="Chance to randomly trigger an IH event on returning to MB",
  gameEventChanceFREE="Chance to randomly trigger an IH event on starting Free roam",
  missionPrepRestrictionsMenu="Only affects the mission-prep screen, not the in-mission equivalents.",
  disableSelectBuddy="Prevents use of buddies during mission prep.",
  disableSelectTime="Only allows ASAP at mission prep",
  disableSelectVehicle="Disallows at mission prep.",
  unlockPlayableAvatar="Unlock avatar before mission 46",
  unlockWeaponCustomization="Unlock without having to complete legendary gunsmith missions",
  returnQuiet="Instantly return Quiet, runs same code as the Reunion mission 11 replay.",
  startOffline="Start the game in offline mode, this also removes the connect option from the pause menu.",
  setLandingZoneWaitHeightTop="Set the height at which the heli hovers in wait mode (not landing mode).",
  defaultHeliDoorOpenTime="Time from mission start to you opening the door to sit on the side. You can set this lower or 0 to do it immediately, or longer to ride the heli in first person. Press <STANCE> to manually open the door.",
  disablePullOutHeli="Prevents heli from leaving when you jump on-board, so you can use the gun from a stationary position, or just change your mind and jump out again. Press <STANCE> while in the heli to get it to pull-out again (or use menu). NOTE: Disable pull-out will prevent the mother base helitaxi selection menu, press <STANCE> to re-enable or use the mod menu.",
  cameraMenu="Lets you move a detached camera, use the main movement stick/keys in combination with other keys/buttons to adjust camera settings, including Zoom, aperture, focus distance.",
  mbMoraleBoosts="Gives a staff-wide morale boost on having a number of soldiers salute (most of a cluster), visiting a number of clusters (with at least one salute on each), or staying in base a number of game days (break out that cigar). Must exit via heli for it to apply.",
  mbEnableBuddies="Does not clear D-Horse and D-Walker if set from deploy screen and returning to mother base, they may however spawn inside building geometry, use the call menu to have them respawn near. Also allows buddies on the Zoo platform, now you can take D-Dog or D-Horse to visit some animals.",
  quietMoveToLastMarker="Sets a position similar to the Quiet attack positions, but can be nearly anywhere. Quiet will still abort from that position if it's too close to enemies.",
  revengeDecayOnLongMbVisit="Spend a number of game days (break out that cigar) during a mother base visit and enemy prep levels will decrease on leaving. Currently reduces after 3 days (stacking), reduces the same as chicken hat ",
  enableInfInterrogation="Adds some interrogations to soldiers: Travel plan of foot patrol, Location of wild card soldier. Inter CP quest: Sets up pairs of soldiers in different cps, interrogating one will give CP of other, interrogating him will give a reward of unprocessed resources (around a couple of containers worth) or a skull soldier/parasite on the next extraction (reaching checkpoint etc)",
  forceGameEvent="Events are temporary custom profiles for free roam and mother base. Free roam events (can stack): Crashland: Starts you on foot in at a random start point and randomly selects OSP options - cleared primary, secondary, back weapons, items, support items. Lost-coms: Disables most mother base support menus and disable all heli landing zones except from main bases/towns. Hunted: Sets the enemy to combat alert every 15-45 seconds (this also sets the player spotted position right on you), and also disables heli landing zones in a 2k radius from your start position, so you'll have to travel if you want to 'get out'. MB events (only one active): DD Training wargame, Soviet attack, Rogue Coyote attack, XOF attack, DD Infection outbreak, Zombie Obliteration (non DD)",
  enableWildCardFreeRoam="Changes a few soldiers throughout the CPs to have unique models and high end weapons, also includes women soldiers.",
  mbEnableOcelot="Enables Ocelot to roam the command platform.",
  mbCollectionRepop="Regenerates plants on Zoo platform and diamonds on Mother base over time.",
  npcHeliUpdate="Spawns some npc helis that roam around mother base.",
  mbEnemyHeliColor="Shared between free roam and MB attack helis.",
  soldierHealthScale="0% will kill off all enemies",
  soldierSightDistScale="A rough scale over all the soldier sight distances, use the command 'Print sight param table (look in iDroid Log>All tab)' to see exact values.",
  reinforceCount_MIN="Number of reinforcement calls a CP has.",
  --reinforceCount_MAX="Number of reinforcement calls a CP has.",
  revengeIgnoreBlocked_MIN="Ignores the current results of the Combat Deployment/Dispatch/'cut off the supply' missions that affect enemy prep.",
  --revengeIgnoreBlocked_MAX="",
  disableHeliAttack="Stops support heli from engaging targets.",
  revengeMenu="Ways to modify the Enemy preparedness system that equips the enemy in response to your actions.",
  STEALTH_MIN="Adjusts enemy soldiers notice,cure,reflex and speed ablilities.",
  COMBAT_MIN="Adjusts enemy soldiers shot,grenade,reload,hp and speed abilities.",
  dDEquipMenu="Allow soldiers to have DD equipment usually only seen on FOB",
  forceSuperReinforce="In the normal game vehicle reinforcments through this system is only used for two missions, this enables it for more.",
  enableSoldiersWithVehicleReinforce="Allows an extra set of reinforce soldiers with all vehicle reinforce types instead of just Wheeled Armored Vehicles.",
  enableLrrpFreeRoam="Foot patrols will travel between two random CPs and will cross the field to get there.",
  enemyHeliPatrol="Allows multiple enemy helicopters that travel between larger CPs. Due to limitations their current position will not be saved/restored so may 'dissapear/appear' on reload.",
  vehiclePatrolProfile="Replaces the patrolling trucks in free roam with other vehicles.",
  mbNpcRouteChange="Soldiers will periodically move between platforms (only within the same cluster).",
  warpPlayerUpdate="Essentially no-clip mode (for those that remember what that means). It teleports your player a small distance each update of which warp direction button you press or hold. Will move you through walls/geometry. The menu navigation/dpad/arrow keys will warp you in that direction, <STANCE> will warp you down and <CALL> will warp you up.",
  mbAdditionalSoldiers="Increases (non main) platforms from 4 soldiers to 7-8.",
  itemDropChance="Chance soldier will drop an item when eliminated.",
}

this.cpNames={
  afgh={},
  mafr={},
}
this.cpNames.afgh.eng={
  afgh_citadelSouth_ob="Guard Post 01",-- East Afghanistan Central Base Camp
  afgh_sovietSouth_ob="Guard Post 02",-- South Afghanistan Central Base Camp
  afgh_plantWest_ob="Guard Post 03",-- NW Serak Power Plant
  afgh_waterwayEast_ob="Guard Post 04",-- East Aabe Shifap Ruins
  afgh_tentNorth_ob="Guard Post 05",-- NE Yakho Oboo Supply Outpost
  afgh_enemyNorth_ob="Guard Post 06",-- NE Wakh Sind Barracks
  afgh_cliffWest_ob="Guard Post 07",-- NW Sakhra Ee Village
  afgh_tentEast_ob="Guard Post 08",-- SE Yakho Oboo Supply Outpost
  afgh_enemyEast_ob="Guard Post 09",-- East Wakh Sind Barracks
  afgh_cliffEast_ob="Guard Post 10",-- East Sakhra Ee Village
  afgh_slopedWest_ob="Guard Post 11",-- NW Ghwandai Town
  afgh_remnantsNorth_ob="Guard Post 12",-- North Lamar Khaate Palace
  afgh_cliffSouth_ob="Guard Post 13",-- South Sakhra Ee Village
  afgh_fortWest_ob="Guard Post 14",-- West Smasei Fort
  afgh_villageWest_ob="Guard Post 15",-- NW Wialo Village
  afgh_slopedEast_ob="Guard Post 16",-- SE Da Ghwandai Khar
  afgh_fortSouth_ob="Guard Post 17",-- SW Smasei Fort
  afgh_villageNorth_ob="Guard Post 18",-- NE Wailo Village
  afgh_commWest_ob="Guard Post 19",-- West Eastern Communications Post
  afgh_bridgeWest_ob="Guard Post 20",-- West Mountain Relay Base
  afgh_bridgeNorth_ob="Guard Post 21",-- SE Mountain Relay Base
  afgh_fieldWest_ob="Guard Post 22",-- North Shago Village
  afgh_villageEast_ob="Guard Post 23",-- SE Wailo Village
  afgh_ruinsNorth_ob="Guard Post 24",-- East Spugmay Keep
  afgh_fieldEast_ob="Guard Post 25",-- East Shago Village

  --afgh_plantSouth_ob--Only references in generic setups",-- no actual missions
  --afgh_waterway_cp--Only references in generic setups",-- no actual missions

  afgh_cliffTown_cp="Qarya Sakhra Ee",
  afgh_tent_cp="Yakho Oboo Supply Outpost",
  afgh_powerPlant_cp="Serak Power Plant",
  afgh_sovietBase_cp="Afghanistan Central Base Camp",
  afgh_remnants_cp="Lamar Khaate Palace",
  afgh_field_cp="Da Shago Kallai",
  afgh_citadel_cp="OKB Zero",
  afgh_fort_cp="Da Smasei Laman",
  afgh_village_cp="Da Wialo Kallai",
  afgh_bridge_cp="Mountain Relay Base",
  afgh_commFacility_cp="Eastern Communications Post",
  afgh_slopedTown_cp="Da Ghwandai Khar",
  afgh_enemyBase_cp="Wakh Sind Barracks",
}

this.cpNames.mafr.eng={
  mafr_swampWest_ob="Guard Post 01",-- NW Kiziba Camp
  mafr_diamondNorth_ob="Guard Post 02",-- NE Kungenga Mine
  mafr_bananaEast_ob="Guard Post 03",-- SE Bampeve Plantation
  mafr_bananaSouth_ob="Guard Post 04",-- SW Bampeve Plantation
  mafr_savannahNorth_ob="Guard Post 05",-- NE Ditadi Abandoned Village
  mafr_outlandNorth_ob="Guard Post 06",-- North Masa Village
  mafr_diamondWest_ob="Guard Post 07",-- West Kungenga Mine
  mafr_labWest_ob="Guard Post 08",-- NW Lufwa Valley
  mafr_savannahWest_ob="Guard Post 09",-- North Ditadi Abandoned Village
  mafr_swampEast_ob="Guard Post 10",-- SE Kiziba Camp
  mafr_outlandEast_ob="Guard Post 11",-- East Masa Village
  mafr_swampSouth_ob="Guard Post 12",-- South Kiziba Camp
  mafr_diamondSouth_ob="Guard Post 13",-- SW Kungenga Mine
  mafr_pfCampNorth_ob="Guard Post 14",-- NE Nova Braga Airport
  mafr_savannahEast_ob="Guard Post 15",-- South Ditadi Abandoned Village
  mafr_hillNorth_ob="Guard Post 16",-- NE Munoko ya Nioka Station
  mafr_factoryWest_ob="Guard Post 17",-- West Ngumba Industrial Zone
  mafr_pfCampEast_ob="Guard Post 18",-- East Nova Braga Airport
  mafr_hillWest_ob="Guard Post 19",-- NW Munoko ya Nioka Station
  mafr_factorySouth_ob="Guard Post 20",-- SW Ngumba Industrial Zone
  mafr_hillWestNear_ob="Guard Post 21",-- West Munoko ya Nioka Station
  mafr_chicoVilWest_ob="Guard Post 22",-- South Nova Braga Airport
  mafr_hillSouth_ob="Guard Post 23",-- SW Munoko ya Nioka Station
  --mafr_swampWestNear_ob--Only references in generic setups, no actual missions
  mafr_flowStation_cp="Mfinda Oilfield",
  mafr_banana_cp="Bampeve Plantation",
  mafr_diamond_cp="Kungenga Mine",
  mafr_lab_cp="Lufwa Valley",
  mafr_swamp_cp="Kiziba Camp",
  mafr_outland_cp="Masa Village",
  mafr_savannah_cp="Ditadi Abandoned Village",
  mafr_pfCamp_cp="Nova Braga Airport",
  mafr_hill_cp="Munoko ya Nioka Station",

--"mafr_factory_cp",--Ngumba Industrial Zone - no soldiers
--"mafr_chicoVil_cp",--??
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
