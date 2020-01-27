-- InfProfiles.lua
-- Profiles are lists of settings for IH options. 
-- IH only reads this file/does not write to it. 
-- In-game the settings are saved to your save file when mission saves (usually during mission load).

-- See Features and Options.html for longer descriptions of some settings.

-- Options are added and sometimes changed as IH develops, use the defaults profile and compare with a prior version using a tool like WinMerge to see changes to make sure your own profiles are correct.

local profiles={}
-- Defaults/example of all profile options for IH r193
profiles.defaults={
	description="Defaults/All disabled",
	firstProfile=false,--puts profile first for the IH menu option, only one profile should have this set.
	loadOnACCStart=false,
	profile={
		--IH system menu
		enableQuickMenu=0,--{ 0-1 } -- Enable Quick Menu
		startOffline=0,--{ 0-1 } -- Start offline
		skipLogos=0,--{ 0-1 } -- Skip startup logos
		--Events menu
		gameEventChanceFREE=0,--{ 0-100 } -- Free roam event random trigger chance (percentage)
		gameEventChanceMB=0,--{ 0-100 } -- MB event random trigger chance (percentage)
		enableParasiteEvent=0,--{ 0-1 } -- Enable Skull attacks in Free roam
		armorParasiteEnabled=1,--{ 0-1 } -- Allow armor skulls
		mistParasiteEnabled=1,--{ 0-1 } -- Allow mist skulls
		camoParasiteEnabled=1,--{ 0-1 } -- Allow sniper skulls
		parasitePeriod_MIN=10,--{ 0-180 } -- Skull attack min (minutes)
		parasitePeriod_MAX=30,--{ 0-180 } -- Skull attack max (minutes)
		parasiteWeather="PARASITE_FOG",--{ NONE, PARASITE_FOG, RANDOM } -- Weather on Skull attack
		--Player restrictions menu
		disableHeliAttack=0,--{ 0-1 } -- Disable support heli attack
		disableFulton=0,--{ 0-1 } -- Disable fulton action
		setSubsistenceSuit=0,--{ 0-1 } -- Force subsistence suit (Olive Drab, no headgear)
		setDefaultHand=0,--{ 0-1 } -- Set hand type to default
		abortMenuItemControl=0,--{ 0-1 } -- Disable abort mission from pause menu
		disableRetry=0,--{ 0-1 } -- Disable retry on mission fail
		gameOverOnDiscovery=0,--{ 0-1 } -- Game over on combat alert
		disableSpySearch=0,--{ 0-1 } -- Disable Intel team enemy spotting
		disableHerbSearch=0,--{ 0-1 } -- Disable Intel team herb spotting (requires game restart)
		dontOverrideFreeLoadout=0,--{ 0-1 } -- Keep equipment Free<>Mission
		--Marking display menu
		disableHeadMarkers=0,--{ 0-1 } -- Disable head markers
		disableXrayMarkers=0,--{ 0-1 } -- Disable Xray marking
		disableWorldMarkers=0,--{ 0-1 } -- Disable world markers
		--Mission-prep restrictions menu
		disableSelectTime=0,--{ 0-1 } -- Disable select-sortie time
		disableSelectBuddy=0,--{ 0-1 } -- Disable select-buddy
		disableSelectVehicle=0,--{ 0-1 } -- Disable select vehicle
		--Disable mission support-menus menu
		disableMenuDrop=0,--{ 0-1 } -- Disable Supply drop support-menu
		disableMenuBuddy=0,--{ 0-1 } -- Disable Buddies support-menu
		disableMenuAttack=0,--{ 0-1 } -- Disable Attack support-menu
		disableMenuHeliAttack=0,--{ 0-1 } -- Disable Heli attack support-menu
		disableSupportMenu=0,--{ 0-1 } -- Disable Support-menu
		--Hand abilities levels menu
		handLevelSonar=0,--{ DEFAULT, DISABLE, GRADE2, GRADE3, GRADE4 } -- Sonar level
		handLevelPhysical=0,--{ DEFAULT, DISABLE, GRADE2, GRADE3, GRADE4 } -- Mobility level
		handLevelPrecision=0,--{ DEFAULT, DISABLE, GRADE2, GRADE3, GRADE4 } -- Precision level
		handLevelMedical=0,--{ DEFAULT, DISABLE, GRADE2, GRADE3, GRADE4 } -- Medical level
		--Fulton levels menu
		itemLevelFulton=0,--{ DEFAULT, GRADE1, GRADE2, GRADE3, GRADE4 } -- Fulton Level
		itemLevelWormhole=0,--{ DEFAULT, DISABLE, ENABLE } -- Wormhole Level
		--Fulton success menu
		fultonNoMbSupport=0,--{ 0-1 } -- Disable MB fulton support
		fultonNoMbMedical=0,--{ 0-1 } -- Disable MB fulton medical
		fultonDyingPenalty=70,--{ 0-100 } -- Target dying penalty
		fultonSleepPenalty=0,--{ 0-100 } -- Target sleeping penalty
		fultonHoldupPenalty=10,--{ 0-100 } -- Target holdup penalty
		fultonDontApplyMbMedicalToSleep=0,--{ 0-1 } -- Dont apply MB medical bonus to sleeping/fainted target
		fultonHostageHandling=0,--{ DEFAULT, ZERO } -- Hostage handling
		--OSP menu
		primaryWeaponOsp=0,--{ OFF, EQUIP_NONE } -- Primary weapon OSP
		secondaryWeaponOsp=0,--{ OFF, EQUIP_NONE } -- Secondary weapon OSP
		tertiaryWeaponOsp=0,--{ OFF, EQUIP_NONE } -- Back Weapon OSP
		clearItems=0,--{ OFF, EQUIP_NONE } -- Items OSP
		clearSupportItems=0,--{ OFF, EQUIP_NONE } -- Support items OSP
		--Player settings menu
		playerHealthScale=100,--{ 0-650 } -- Player life scale (percentage)
		useSoldierForDemos=0,--{ 0-1 } -- Use selected soldier in all cutscenes and missions
		--Soldier parameters menu
		soldierParamsProfile=0,--{ 0-1 } -- Enable soldier parameter settings
		soldierHealthScale=100,--{ 0-900 } -- Soldier life scale (percentage)
		soldierSightDistScale=100,--{ 0-400 } -- Soldier sight scale (percentage)
		soldierNightSightDistScale=100,--{ 0-400 } -- Soldier night sight scale (percentage)
		soldierHearingDistScale=100,--{ 0-400 } -- Soldier hearing distance scale (percentage)
		itemDropChance=0,--{ 0-100 } -- Soldier item drop chance (percentage)
		--Enemy phases menu
		phaseUpdate=0,--{ 0-1 } -- Enable phase modifications
		minPhase="PHASE_SNEAK",--{ PHASE_SNEAK, PHASE_CAUTION, PHASE_EVASION, PHASE_ALERT } -- Minimum phase
		maxPhase="PHASE_ALERT",--{ PHASE_SNEAK, PHASE_CAUTION, PHASE_EVASION, PHASE_ALERT } -- Maximum phase
		keepPhase=0,--{ 0-1 } -- Don't downgrade phase
		phaseUpdateRate=3,--{ 1-255 } -- Phase mod update rate (seconds)
		phaseUpdateRange=0,--{ 0-255 } -- Phase mod random variation
		soldierAlertOnHeavyVehicleDamage="PHASE_SNEAK",--{ PHASE_SNEAK, PHASE_CAUTION, PHASE_EVASION, PHASE_ALERT } -- Alert phase on vehicle attack
		printPhaseChanges=0,--{ 0-1 } -- Print phase changes
		--Enemy Prep menu
		revengeModeFREE=0,--{ DEFAULT, CUSTOM, NONDEFAULT } -- Free roam prep mode
		revengeModeMISSION=0,--{ DEFAULT, CUSTOM, NONDEFAULT } -- Missions prep mode
		revengeModeMB=0,--{ OFF, FOB, DEFAULT, CUSTOM, NONDEFAULT } -- Mother base prep mode
		changeCpSubTypeFREE=0,--{ 0-1 } -- Random CP subtype in free roam
		changeCpSubTypeMISSION=0,--{ 0-1 } -- Random CP subtype in missions
		enableInfInterrogation=0,--{ 0-1 } -- IH interrogation in free roam
		--Custom prep menu
		reinforceCount_MIN=1,--{ 1-99 } -- Reinforce calls min
		reinforceCount_MAX=5,--{ 1-99 } -- Reinforce calls max
		reinforceLevel_MIN="NONE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level min
		reinforceLevel_MAX="BLACK_SUPER_REINFORCE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level max
		revengeIgnoreBlocked_MIN=0,--{ 0-1 } -- Ignore combat-deploy supply blocks min
		revengeIgnoreBlocked_MAX=0,--{ 0-1 } -- Ignore combat-deploy supply blocks max
		--Weapon deployment
		SNIPER_MIN=0,--{ 0-100 } --  (percentage)
		SNIPER_MAX=100,--{ 0-100 } --  (percentage)
		MISSILE_MIN=0,--{ 0-100 } --  (percentage)
		MISSILE_MAX=100,--{ 0-100 } --  (percentage)
		MG_MIN=0,--{ 0-100 } --  (percentage)
		MG_MAX=100,--{ 0-100 } --  (percentage)
		SHOTGUN_MIN=0,--{ 0-100 } --  (percentage)
		SHOTGUN_MAX=100,--{ 0-100 } --  (percentage)
		SMG_MIN=0,--{ 0-100 } --  (percentage)
		SMG_MAX=100,--{ 0-100 } --  (percentage)
		ASSAULT_MIN=0,--{ 0-100 } --  (percentage)
		ASSAULT_MAX=100,--{ 0-100 } --  (percentage)
		GUN_LIGHT_MIN=0,--{ 0-100 } --  (percentage)
		GUN_LIGHT_MAX=100,--{ 0-100 } --  (percentage)
		--Armor deployment
		ARMOR_MIN=0,--{ 0-100 } --  (percentage)
		ARMOR_MAX=100,--{ 0-100 } --  (percentage)
		SOFT_ARMOR_MIN=0,--{ 0-100 } --  (percentage)
		SOFT_ARMOR_MAX=100,--{ 0-100 } --  (percentage)
		SHIELD_MIN=0,--{ 0-100 } --  (percentage)
		SHIELD_MAX=100,--{ 0-100 } --  (percentage)
		--Headgear deployment
		HELMET_MIN=0,--{ 0-100 } --  (percentage)
		HELMET_MAX=100,--{ 0-100 } --  (percentage)
		NVG_MIN=0,--{ 0-100 } --  (percentage)
		NVG_MAX=100,--{ 0-100 } --  (percentage)
		GAS_MASK_MIN=0,--{ 0-100 } --  (percentage)
		GAS_MASK_MAX=100,--{ 0-100 } --  (percentage)
		--CP deterrent deployment
		DECOY_MIN=0,--{ 0-100 } --  (percentage)
		DECOY_MAX=100,--{ 0-100 } --  (percentage)
		MINE_MIN=0,--{ 0-100 } --  (percentage)
		MINE_MAX=100,--{ 0-100 } --  (percentage)
		CAMERA_MIN=0,--{ 0-100 } --  (percentage)
		CAMERA_MAX=100,--{ 0-100 } --  (percentage)
		--Soldier abilities
		STEALTH_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers notice,cure,reflex and speed ablilities.
		STEALTH_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } -- 
		COMBAT_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers shot,grenade,reload,hp and speed abilities.
		COMBAT_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } -- 
		HOLDUP_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- 
		HOLDUP_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } -- 
		FULTON_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- 
		FULTON_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } -- 
		--Weapon strength menu
		STRONG_WEAPON_MIN=0,--{ 0-1 } -- 
		STRONG_WEAPON_MAX=1,--{ 0-1 } -- 
		STRONG_SNIPER_MIN=0,--{ 0-1 } -- 
		STRONG_SNIPER_MAX=1,--{ 0-1 } -- 
		STRONG_MISSILE_MIN=0,--{ 0-1 } -- 
		STRONG_MISSILE_MAX=1,--{ 0-1 } -- 
		--CP equip strength menu
		ACTIVE_DECOY_MIN=0,--{ 0-1 } -- 
		ACTIVE_DECOY_MAX=1,--{ 0-1 } -- 
		GUN_CAMERA_MIN=0,--{ 0-1 } -- 
		GUN_CAMERA_MAX=1,--{ 0-1 } -- 
		--Prep system menu
		revengeBlockForMissionCount=3,--{ 0-10 } -- Resupply in #missions
		applyPowersToOuterBase=0,--{ 0-1 } -- Apply enemy prep to guard posts
		applyPowersToLrrp=0,--{ 0-1 } -- Apply enemy prep to patrol soldiers
		allowHeavyArmorFREE=0,--{ 0-1 } -- Allow heavy armor in free roam (has issues)
		allowHeavyArmorMISSION=0,--{ 0-1 } -- Allow heavy armor in all missions (may have issues)
		disableMissionsWeaponRestriction=0,--{ 0-1 } -- Disable weapon restrictions in certain missions
		disableNoStealthCombatRevengeMission=0,--{ 0-1 } -- Allow Enemy Prep shift after free roam
		revengeDecayOnLongMbVisit=0,--{ 0-1 } -- Enemy prep decrease on long MB visit
		allowHeadGearCombo=0,--{ 0-1 } -- Allow helmet and NVG or Gas mask combo
		balanceHeadGear=0,--{ 0-1 } -- Ballance heavy armor and head gear distribution
		allowMissileWeaponsCombo=0,--{ 0-1 } -- Allow missile combo with other weapons
		enableMgVsShotgunVariation=0,--{ 0-1 } -- Mg vs Shotgun variation
		randomizeSmallCpPowers=0,--{ 0-1 } -- Balance small CPs
		disableConvertArmorToShield=0,--{ 0-1 } -- Disable convert armor to shield (if armor off)
		randomizeMineTypes=0,--{ 0-1 } -- Randomize minefield mine types
		additionalMineFields=0,--{ 0-1 } -- Enable additional minefields
		--Custom soldier equip menu
		customWeaponTableFREE=0,--{ 0-1 } -- Enemy use custom equip table in free roam
		customWeaponTableMISSION=0,--{ 0-1 } -- Enemy use custom equip table in missions
		customWeaponTableMB_ALL=0,--{ 0-1 } -- MB staff use custom equip table
		weaponTableStrength="NORMAL",--{ NORMAL, STRONG, COMBINED } -- Weapon stengths
		weaponTableAfgh=1,--{ 0-1 } -- Include Soviet weapons
		weaponTableMafr=1,--{ 0-1 } -- Include PF weapons
		weaponTableSkull=1,--{ 0-1 } -- Include XOF weapons
		weaponTableDD=0,--{ 0-1 } -- Include DD weapons
		soldierEquipGrade_MIN=3,--{ 1-15 } -- DD weapons grade MIN
		soldierEquipGrade_MAX=15,--{ 1-15 } -- DD weapons grade MAX
		allowUndevelopedDDEquip=0,--{ 0-1 } -- Allow undeveloped DD weapons
		mbDDEquipNonLethal=0,--{ 0-1 } -- DD equipment non-lethal
		--Enemy reinforcements menu
		forceSuperReinforce=0,--{ OFF, ON_CONFIG, FORCE_CONFIG } -- Vehicle reinforcements (only heli in free roam, vehicles depend on mission)
		enableHeliReinforce=0,--{ 0-1 } -- Force enable enemy heli reinforce (disable heli sideops)
		forceReinforceRequest=0,--{ 0-1 } -- Force reinforce request for heli
		disableReinforceHeliPullOut=0,--{ 0-1 } -- Disable reinforce heli pull-out
		enableSoldiersWithVehicleReinforce=0,--{ 0-1 } -- Soldier reinforce with all vehicle reinforce types
		--Patrols and deployments menu
		enableLrrpFreeRoam=0,--{ 0-1 } -- Foot patrols in free roam
		enableWildCardFreeRoam=0,--{ 0-1 } -- Wildcard soldiers Free roam
		heliPatrolsFREE=0,--{ OFF, ON } -- Heli patrols in free roam
		heliPatrolsMB=0,--{ OFF, UTH, HP48, UTH_AND_HP48 } -- Heli patrols in MB
		mbEnemyHeliColor=0,--{ DEFAULT, BLACK, RED, RANDOM, RANDOM_EACH, ENEMY_PREP } -- Attack heli class
		enableWalkerGearsFREE=0,--{ 0-1 } -- Walker gears in free roam
		enableWalkerGearsMB=0,--{ 0-1 } -- Walker gears in MB
		vehiclePatrolProfile=0,--{ OFF, SINGULAR, EACH_VEHICLE } -- Vehicle patrols in free roam
		vehiclePatrolClass=0,--{ DEFAULT, DARK_GRAY, OXIDE_RED, RANDOM, RANDOM_EACH, ENEMY_PREP } -- Vehicle patrol class
		vehiclePatrolLvEnable=1,--{ 0-1 } -- Allow jeeps
		vehiclePatrolTruckEnable=1,--{ 0-1 } -- Allow trucks
		vehiclePatrolWavEnable=1,--{ 0-1 } -- Allow wheeled armored vehicles
		vehiclePatrolWavHeavyEnable=1,--{ 0-1 } -- Allow heavy wheeled armored vehicles
		vehiclePatrolTankEnable=1,--{ 0-1 } -- Allow tanks
		putEquipOnTrucks=0,--{ 0-1 } -- Equipment on trucks
		--Side ops menu
		unlockSideOps=0,--{ OFF, REPOP, OPEN } -- Unlock Sideops mode
		sideOpsSelectionMode=0,--{ OFF, RANDOM, STORY, EXTRACT_INTERPRETER, BLUEPRINT, EXTRACT_HIGHLY_SKILLED, PRISONER, CAPTURE_ANIMAL, WANDERING_SOLDIER, DDOG_PRISONER, ELIMINATE_HEAVY_INFANTRY, MINE_CLEARING, ELIMINATE_ARMOR_VEHICLE, EXTRACT_GUNSMITH, ELIMINATE_TANK_UNIT, ELIMINATE_PUPPETS } -- Sideop selection mode
		unlockSideOpNumber=0,--{ 0-157 } -- Open specific sideop #
		--Mother Base menu
		mbSoldierEquipRange="SHORT",--{ SHORT, MEDIUM, LONG, RANDOM } -- MB Equip Range (MB Prep mode FOB only)
		mbDDSuit=0,--{ OFF, EQUIPGRADE, DRAB, TIGER, SNEAKING_SUIT, BATTLE_DRESS, SWIMWEAR, PFA_ARMOR, XOF, SOVIET_A, SOVIET_B, PF_A, PF_B, PF_C, SOVIET_BERETS, SOVIET_HOODIES, SOVIET_ALL, PF_MISC, PF_ALL, MSF_PFS } -- DD Suit
		mbDDSuitFemale="EQUIPGRADE",--{ EQUIPGRADE, DRAB_FEMALE, TIGER_FEMALE, SNEAKING_SUIT_FEMALE, BATTLE_DRESS_FEMALE, SWIMWEAR_FEMALE } -- DD Suit female
		mbDDHeadGear=0,--{ 0-1 } -- DD Head gear
		mbPrioritizeFemale=0,--{ OFF, DISABLE, MAX } -- Female staff selection
		mbWalkerGearsColor="SOVIET",--{ SOVIET, ROGUE_COYOTE, CFA, ZRS, DDOGS, HUEY_PROTO, RANDOM, RANDOM_EACH } -- Walker gears type
		mbWalkerGearsWeapon=0,--{ DEFAULT, MINIGUN, MISSILE, RANDOM, RANDOM_EACH } -- Walker gears weapons
		mbCollectionRepop=0,--{ 0-1 } -- Repopulate plants and diamonds
		mbMoraleBoosts=0,--{ 0-1 } -- Staff-wide morale boost for good visit
		mbEnableBuddies=0,--{ 0-1 } -- Enable all buddies
		mbAdditionalSoldiers=0,--{ 0-1 } -- More soldiers on MB plats
		mbqfEnableSoldiers=0,--{ 0-1 } -- Force enable Quaranine platform soldiers
		mbNpcRouteChange=0,--{ 0-1 } -- Soldiers move between platforms
		mbEnableLethalActions=0,--{ 0-1 } -- Allow lethal actions
		mbWargameFemales=0,--{ 0-100 } -- Women in Enemy Invasion mode (percentage)
		mbWarGamesProfile=0,--{ OFF, TRAINING, INVASION, ZOMBIE_DD, ZOMBIE_OBLITERATION } -- Mother Base War Games
		--Show characters menu
		mbEnableOcelot=0,--{ 0-1 } -- Enable Ocelot
		mbEnablePuppy=0,--{ OFF, MISSING_EYE, NORMAL_EYES } -- Puppy DDog
		mbShowCodeTalker=0,--{ 0-1 } -- Show Code Talker
		mbShowEli=0,--{ 0-1 } -- Show Eli
		--Show assets menu
		mbShowBigBossPosters=0,--{ 0-1 } -- Show Big Boss posters
		mbShowMbEliminationMonument=0,--{ 0-1 } -- Show nuke elimination monument
		mbShowSahelan=0,--{ 0-1 } -- Show Sahelanthropus
		mbUnlockGoalDoors=0,--{ 0-1 } -- Unlock goal doors
		--Cutscenes menu
		mbDemoSelection=0,--{ DEFAULT, PLAY, DISABLED } -- MB cutscene play mode
		mbSelectedDemo=0,--{ 0-46 } -- Select MB cutscene (REQ: Play selected)
		mbDemoOverrideTime=0,--{ DEFAULT, CURRENT, CUSTOM } -- Override time
		mbDemoHour=0,--{ 0-23 } -- Hour
		mbDemoMinute=0,--{ 0-59 } -- Minute
		mbDemoOverrideWeather=0,--{ DEFAULT, CURRENT, SUNNY, CLOUDY, RAINY, SANDSTORM, FOGGY, POURING } -- Override weather
		--Camera menu
		cameraMode=0,--{ DEFAULT, CAMERA } -- Non-save -- Camera mode
		moveScale=0.5,--{ 0.01-10 } -- Cam speed scale
		disableCamText=0,--{ 0-1 } -- Non-save -- Disable mode text feedback
		--Time scale menu
		speedCamContinueTime=10,--{ 0-1000 } -- TSM length (seconds)
		speedCamWorldTimeScale=0.3,--{ 0-100 } -- TSM world time scale
		speedCamPlayerTimeScale=1,--{ 0-100 } -- TSM player time scale
		clockTimeScale=20,--{ 1-10000 } -- Clock time scale
		--Support heli menu
		setInvincibleHeli=0,--{ 0-1 } -- Set heli invincible
		setSearchLightForcedHeli=0,--{ DEFAULT, OFF, ON } -- Force searchlight
		disablePullOutHeli=0,--{ 0-1 } -- Disable pull-out
		setLandingZoneWaitHeightTop=20,--{ 5-50 } -- Set LZ wait height
		defaultHeliDoorOpenTime=15,--{ 0-120 } -- Mission start time till open door
		disableLzs=0,--{ OFF, ASSAULT, REGULAR } -- Disable landing zones
		startOnFootFREE=0,--{ OFF, NOT_ASSAULT, ALL } -- Start free roam on foot
		startOnFootMISSION=0,--{ OFF, NOT_ASSAULT, ALL } -- Start missions on foot
		startOnFootMB_ALL=0,--{ OFF, NOT_ASSAULT, ALL } -- Start Mother base on foot
		--Progression menu
		resourceAmountScale=100,--{ 100-1000 } -- Resource amount scale (percentage)
		repopulateRadioTapes=0,--{ 0-1 } -- Repopulate music tape radios
		--Debug menu
		printPressedButtons=0,--{ 0-1 } -- Non-save -- 
		telopMode=0,--{ 0-1 } -- Disable mission intro credits
		--Buddy menu
		quietRadioMode=0,--{ 0-31 } -- Quiets MB radio track (0=Auto)
	}
}

--tex My suggested settings for mother base
profiles.motherBaseHeaven={
  description="Mother Base Heaven",
  profile={
    revengeModeMB="DEFAULT",--{ OFF, FOB, DEFAULT, CUSTOM } -- Mother base prep mode
    --DD Equip menu
    enableDDEquipMB=0,--{ 0-1 } -- MB staff use DD equipment
    soldierEquipGrade_MIN=15,--{ 1-15 } -- DD Equip Grade RND MIN
    soldierEquipGrade_MAX=15,--{ 1-15 } -- DD Equip Grade RND MAX
    allowUndevelopedDDEquip=0,--{ 0-1 } -- Allow undeveloped DD equipment
    mbDDEquipNonLethal=0,--{ 0-1 } -- MB DD Equip non-lethal
    --Mother base menu
    mbDDSuit="EQUIPGRADE",--{ OFF, EQUIPGRADE, DRAB, TIGER, SNEAKING_SUIT, BATTLE_DRESS, SWIMWEAR, PFA_ARMOR, XOF, SOVIET_A, SOVIET_B, PF_A, PF_B, PF_C, SOVIET_BERETS, SOVIET_HOODIES, SOVIET_ALL, PF_MISC, PF_ALL, MSF_PFS } -- DD Suit
    mbDDSuitFemale="EQUIPGRADE",--{ EQUIPGRADE, DRAB_FEMALE, TIGER_FEMALE, SNEAKING_SUIT_FEMALE, BATTLE_DRESS_FEMALE, SWIMWEAR_FEMALE } -- DD Suit female
    mbDDHeadGear=0,--{ 0-1 } -- DD Head gear
    mbPrioritizeFemale="MAX",--{ OFF, DISABLE, MAX } -- Female staff selection
    heliPatrolsMB="UTH_AND_HP48",--{ OFF, UTH, UTH_AND_HP48 } -- NPC helis
    enableWalkerGearsMB=1,--{ 0-1 } -- Walker gears
    mbWalkerGearsColor="DDOGS",--{ SOVIET, ROGUE_COYOTE, CFA, ZRS, DDOGS, HUEY_PROTO, RANDOM, RANDOM_EACH } -- Walker gears type
    mbWalkerGearsWeapon=0,--{ DEFAULT, MINIGUN, MISSILE, RANDOM, RANDOM_EACH } -- Walker gears weapons
    mbCollectionRepop=1,--{ 0-1 } -- Repopulate plants and diamonds
    mbMoraleBoosts=1,--{ 0-1 } -- Staff-wide morale boost for good visit
    mbEnableBuddies=1,--{ 0-1 } -- Enable all buddies
    mbAdditionalSoldiers=1,--{ 0-1 } -- More soldiers on MB plats
    mbqfEnableSoldiers=1,--{ 0-1 } -- Force enable Quaranine platform soldiers
    mbNpcRouteChange=1,--{ 0-1 } -- Soldiers move between platforms
    mbWargameFemales=15,--{ 0-100 } -- Women in Enemy Invasion mode (percentage)
    --Show characters menu
    mbEnableOcelot=1,--{ 0-1 } -- Enable Ocelot
    mbEnablePuppy="NORMAL_EYES",--{ OFF, MISSING_EYE, NORMAL_EYES } -- Puppy DDog
    mbShowCodeTalker=1,--{ 0-1 } -- Show Code Talker
    mbShowEli=1,--{ 0-1 } -- Show Eli
    --Show assets menu
    mbShowBigBossPosters=0,--{ 0-1 } -- Show Big Boss posters
    mbShowMbEliminationMonument=0,--{ 0-1 } -- Show nuke elimination monument
    mbShowSahelan=1,--{ 0-1 } -- Show Sahelanthropus
    mbUnlockGoalDoors=1,--{ 0-1 } -- Unlock goal doors
  }
}

--tex My suggested fulton settings
profiles.fultonHeaven={
  description="Fulton Heaven",
  profile={
    --Fulton levels menu
    --itemLevelFulton=1,--{ 1-4 } -- Fulton Level
    --itemLevelWormhole="DISABLE",--{ DISABLE, ENABLE } -- Wormhole Level
    --Fulton success menu
    fultonNoMbSupport=1,--{ 0-1 } -- Disable MB fulton support
    fultonNoMbMedical=1,--{ 0-1 } -- Disable MB fulton medical
    fultonDyingPenalty=40,--{ 0-100 } -- Target dying penalty
    fultonSleepPenalty=20,--{ 0-100 } -- Target sleeping penalty
    fultonHoldupPenalty=0,--{ 0-100 } -- Target holdup penalty
    fultonDontApplyMbMedicalToSleep=1,--{ 0-1 } -- Dont apply MB medical bonus to sleeping/fainted target
    fultonHostageHandling="ZERO",--Force you to manually extract hostages
  }
}

--tex aims to match same settings as Subsistence missions
profiles.subsistenceGame={
  description="Subsistence - Game",
  profile={
    disableSelectBuddy=1,
    disableHeliAttack=1,
    disableSelectTime=1,
    disableSelectVehicle=1,

    disableXrayMarkers=0,
    disableHeadMarkers=0,
    disableWorldMarkers=0,
    
    disableFulton=0,
    
    clearItems=1,
    clearSupportItems=1,
    setSubsistenceSuit=1,
    setDefaultHand=1,
--tex now better to Equip none in mission prep
--    primaryWeaponOsp="EQUIP_NONE",
--    secondaryWeaponOsp="EQUIP_NONE",
--    tertiaryWeaponOsp="EQUIP_NONE",

    handLevelSonar="DEFAULT",
    handLevelPhysical="DEFAULT",
    handLevelPrecision="DEFAULT",
    handLevelMedical="DEFAULT",

    itemLevelFulton="DEFAULT",
    itemLevelWormhole="DEFAULT",

    disableMenuDrop=1,
    disableMenuBuddy=1,
    disableMenuAttack=1,
    disableMenuHeliAttack=1,
    disableSupportMenu=1,

    abortMenuItemControl=1,
    disableRetry=0,
    gameOverOnDiscovery=0,
  }
}

--tex additional restrictions on top of Game that 
profiles.subsistencePure={
  description="Subsistence - Pure",
  profile={
    disableLzs="REGULAR",--tex this setting can be troublesome when trying to start a mission from ACC since it only allows Assault Landing zones, can be a fun restriction when entering from free roam, forces you to either exit on foot, or risk the heli by calling it to the assault LZ
    disableSelectBuddy=1,
    disableHeliAttack=1,
    disableSelectTime=1,
    disableSelectVehicle=1,

    disableXrayMarkers=1,
    disableHeadMarkers=1,
    disableWorldMarkers=0,
    disableFulton=1,--tex forces you to deal with enemy soldiers, but feel free to adjust if you can't give up on your extraction addiction.
    fultonHostageHandling="ZERO",--tex Forces you to manually extract hostages (moot with above disabling fulton completely, but good without)
    clearItems=1,
    clearSupportItems=1,
    setSubsistenceSuit=1,
    setDefaultHand=1,
--tex now better to Equip none in mission prep
--    primaryWeaponOsp="EQUIP_NONE",
--    secondaryWeaponOsp="EQUIP_NONE",
--    tertiaryWeaponOsp="EQUIP_NONE",

    handLevelSonar="DISABLE",
    handLevelPhysical="DISABLE",
    handLevelPrecision="DISABLE",
    handLevelMedical="DISABLE",

    itemLevelFulton="GRADE1",
    itemLevelWormhole="DISABLE",

    disableMenuDrop=1,
    disableMenuBuddy=1,
    disableMenuAttack=1,
    disableMenuHeliAttack=1,
    disableSupportMenu=1,

    abortMenuItemControl=1,
    disableRetry=0,
    gameOverOnDiscovery=0,
    maxPhase="PHASE_ALERT",--Reset
    
    dontOverrideFreeLoadout=1,
  }
}

--tex A bit less restrictive subsistence style
profiles.subsistenceBounder={
  description="Subsistence - Bounder",
  profile={
    --disableLzs="REGULAR",
    disableSelectBuddy=0,
    disableHeliAttack=1,
    disableSelectTime=1,
    disableSelectVehicle=1,
    
    disableHeadMarkers=0,
    disableXrayMarkers=0,
    disableWorldMarkers=0,

    disableFulton=0,
    clearItems=1,
    clearSupportItems=1,
    setSubsistenceSuit=0,
    setDefaultHand=1,

--tex now better to Equip none in mission prep
--    primaryWeaponOsp="EQUIP_NONE",
--    secondaryWeaponOsp="EQUIP_NONE",
--    tertiaryWeaponOsp="EQUIP_NONE",

    handLevelSonar="DISABLE",
    handLevelPhysical="DISABLE",
    handLevelPrecision="DISABLE",
    handLevelMedical="DISABLE",

    itemLevelFulton="GRADE1",
    itemLevelWormhole="DISABLE",

    disableMenuDrop=1,
    disableMenuBuddy=0,
    disableMenuAttack=1,
    disableMenuHeliAttack=1,
    disableSupportMenu=1,

    abortMenuItemControl=0,
    disableRetry=0,
    gameOverOnDiscovery=0,
    maxPhase="PHASE_ALERT",--Reset
    
    dontOverrideFreeLoadout=1,
  },
}

--tex suggested settings for enemy prep system
profiles.revengeHeaven={
  description="Enemy Prep Heaven",
  profile={
    revengeBlockForMissionCount=4,
    applyPowersToLrrp=1,
    applyPowersToOuterBase=1,
    allowHeavyArmorFREE=0,
    allowHeavyArmorMISSION=0,
    allowHeadGearCombo=1,
    allowMissileWeaponsCombo=1,
    balanceHeadGear=0,--tex allow headgearcombo is sufficient
    balanceWeaponPowers=0,--WIP
    disableConvertArmorToShield=1,
    disableNoRevengeMissions=0,
    disableMissionsWeaponRestriction=0,
    enableMgVsShotgunVariation=1,
    randomizeSmallCpPowers=1,
    disableNoStealthCombatRevengeMission=1,
    revengeDecayOnLongMbVisit=1,
    changeCpSubTypeFREE=1,
    changeCpSubTypeMISSION=0,
  },
}


--tex Custom Enemy Prep Configs
--In-game Custom Prep Configs are built by choosing random values between the min,max options.
--This only sets up the Prep config, Enemy prep mode must still be set to Custom in the menu.

profiles.customPrepMax={
  description="Custom Prep - Max",
  profile={
    --Custom prep menu
    reinforceCount_MIN=99,--{ 1-99 } -- Reinforce calls min
    reinforceCount_MAX=99,--{ 1-99 } -- Reinforce calls max
    reinforceLevel_MIN="BLACK_SUPER_REINFORCE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level min
    reinforceLevel_MAX="BLACK_SUPER_REINFORCE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level max
    revengeIgnoreBlocked_MIN=1,--{ 0-1 } -- Ignore combat-deploy supply blocks min
    revengeIgnoreBlocked_MAX=1,--{ 0-1 } -- Ignore combat-deploy supply blocks max
    --Weapon deployment
    SNIPER_MIN=20,--{ 0-100 } --  (percentage)
    SNIPER_MAX=20,--{ 0-100 } --  (percentage)
    MISSILE_MIN=40,--{ 0-100 } --  (percentage)
    MISSILE_MAX=40,--{ 0-100 } --  (percentage)
    MG_MIN=40,--{ 0-100 } --  (percentage)
    MG_MAX=40,--{ 0-100 } --  (percentage)
    SHOTGUN_MIN=40,--{ 0-100 } --  (percentage)
    SHOTGUN_MAX=40,--{ 0-100 } --  (percentage)
    SMG_MIN=0,--{ 0-100 } --  (percentage)
    SMG_MAX=0,--{ 0-100 } --  (percentage)
    ASSAULT_MIN=0,--{ 0-100 } --  (percentage)
    ASSAULT_MAX=0,--{ 0-100 } --  (percentage)
    GUN_LIGHT_MIN=100,--{ 0-100 } --  (percentage)
    GUN_LIGHT_MAX=100,--{ 0-100 } --  (percentage)
    --Armor deployment
    ARMOR_MIN=40,--{ 0-100 } --  (percentage)
    ARMOR_MAX=40,--{ 0-100 } --  (percentage)
    SOFT_ARMOR_MIN=100,--{ 0-100 } --  (percentage)
    SOFT_ARMOR_MAX=100,--{ 0-100 } --  (percentage)
    SHIELD_MIN=40,--{ 0-100 } --  (percentage)
    SHIELD_MAX=40,--{ 0-100 } --  (percentage)
    --Headgear deployment
    HELMET_MIN=100,--{ 0-100 } --  (percentage)
    HELMET_MAX=100,--{ 0-100 } --  (percentage)
    NVG_MIN=100,--{ 0-100 } --  (percentage)
    NVG_MAX=100,--{ 0-100 } --  (percentage)
    GAS_MASK_MIN=100,--{ 0-100 } --  (percentage)
    GAS_MASK_MAX=100,--{ 0-100 } --  (percentage)
    --CP deterrent deployment
    DECOY_MIN=100,--{ 0-100 } --  (percentage)
    DECOY_MAX=100,--{ 0-100 } --  (percentage)
    MINE_MIN=100,--{ 0-100 } --  (percentage)
    MINE_MAX=100,--{ 0-100 } --  (percentage)
    CAMERA_MIN=100,--{ 0-100 } --  (percentage)
    CAMERA_MAX=100,--{ 0-100 } --  (percentage)
    --Soldier abilities
    STEALTH_MIN="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers notice,cure,reflex and speed ablilities.
    STEALTH_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    COMBAT_MIN="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers shot,grenade,reload,hp and speed abilities.
    COMBAT_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    HOLDUP_MIN="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    HOLDUP_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    FULTON_MIN="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    FULTON_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    --Weapon strength menu
    STRONG_WEAPON_MIN=1,--{ 0-1 } --
    STRONG_WEAPON_MAX=1,--{ 0-1 } --
    STRONG_SNIPER_MIN=1,--{ 0-1 } --
    STRONG_SNIPER_MAX=1,--{ 0-1 } --
    STRONG_MISSILE_MIN=1,--{ 0-1 } --
    STRONG_MISSILE_MAX=1,--{ 0-1 } --
    --CP equip strength menu
    ACTIVE_DECOY_MIN=1,--{ 0-1 } --
    ACTIVE_DECOY_MAX=1,--{ 0-1 } --
    GUN_CAMERA_MIN=1,--{ 0-1 } --
    GUN_CAMERA_MAX=1,--{ 0-1 } --
  }
}

profiles.customPrepMin={
  description="Custom Prep - Min",
  profile={
    --Custom prep menu
    reinforceCount_MIN=1,--{ 1-99 } -- Reinforce calls min
    reinforceCount_MAX=1,--{ 1-99 } -- Reinforce calls max
    reinforceLevel_MIN="NONE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level min
    reinforceLevel_MAX="NONE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level max
    revengeIgnoreBlocked_MIN=0,--{ 0-1 } -- Ignore combat-deploy supply blocks min
    revengeIgnoreBlocked_MAX=0,--{ 0-1 } -- Ignore combat-deploy supply blocks max
    --Weapon deployment
    SNIPER_MIN=0,--{ 0-100 } --  (percentage)
    SNIPER_MAX=0,--{ 0-100 } --  (percentage)
    MISSILE_MIN=0,--{ 0-100 } --  (percentage)
    MISSILE_MAX=0,--{ 0-100 } --  (percentage)
    MG_MIN=0,--{ 0-100 } --  (percentage)
    MG_MAX=0,--{ 0-100 } --  (percentage)
    SHOTGUN_MIN=0,--{ 0-100 } --  (percentage)
    SHOTGUN_MAX=0,--{ 0-100 } --  (percentage)
    SMG_MIN=0,--{ 0-100 } --  (percentage)
    SMG_MAX=0,--{ 0-100 } --  (percentage)
    ASSAULT_MIN=0,--{ 0-100 } --  (percentage)
    ASSAULT_MAX=0,--{ 0-100 } --  (percentage)
    GUN_LIGHT_MIN=0,--{ 0-100 } --  (percentage)
    GUN_LIGHT_MAX=0,--{ 0-100 } --  (percentage)
    --Armor deployment
    ARMOR_MIN=0,--{ 0-100 } --  (percentage)
    ARMOR_MAX=0,--{ 0-100 } --  (percentage)
    SOFT_ARMOR_MIN=0,--{ 0-100 } --  (percentage)
    SOFT_ARMOR_MAX=0,--{ 0-100 } --  (percentage)
    SHIELD_MIN=0,--{ 0-100 } --  (percentage)
    SHIELD_MAX=0,--{ 0-100 } --  (percentage)
    --Headgear deployment
    HELMET_MIN=0,--{ 0-100 } --  (percentage)
    HELMET_MAX=0,--{ 0-100 } --  (percentage)
    NVG_MIN=0,--{ 0-100 } --  (percentage)
    NVG_MAX=0,--{ 0-100 } --  (percentage)
    GAS_MASK_MIN=0,--{ 0-100 } --  (percentage)
    GAS_MASK_MAX=0,--{ 0-100 } --  (percentage)
    --CP deterrent deployment
    DECOY_MIN=0,--{ 0-100 } --  (percentage)
    DECOY_MAX=0,--{ 0-100 } --  (percentage)
    MINE_MIN=0,--{ 0-100 } --  (percentage)
    MINE_MAX=0,--{ 0-100 } --  (percentage)
    CAMERA_MIN=0,--{ 0-100 } --  (percentage)
    CAMERA_MAX=0,--{ 0-100 } --  (percentage)
    --Soldier abilities
    STEALTH_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers notice,cure,reflex and speed ablilities.
    STEALTH_MAX="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    COMBAT_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers shot,grenade,reload,hp and speed abilities.
    COMBAT_MAX="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    HOLDUP_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    HOLDUP_MAX="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    FULTON_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    FULTON_MAX="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    --Weapon strength menu
    STRONG_WEAPON_MIN=0,--{ 0-1 } --
    STRONG_WEAPON_MAX=0,--{ 0-1 } --
    STRONG_SNIPER_MIN=0,--{ 0-1 } --
    STRONG_SNIPER_MAX=0,--{ 0-1 } --
    STRONG_MISSILE_MIN=0,--{ 0-1 } --
    STRONG_MISSILE_MAX=0,--{ 0-1 } --
    --CP equip strength menu
    ACTIVE_DECOY_MIN=0,--{ 0-1 } --
    ACTIVE_DECOY_MAX=0,--{ 0-1 } --
    GUN_CAMERA_MIN=0,--{ 0-1 } --
    GUN_CAMERA_MAX=0,--{ 0-1 } --
  }
}

--tex widest range of randomization
profiles.customPrepWide={
  description="Custom Prep - Random",
  profile={
    --Custom prep menu
    reinforceCount_MIN=0,--{ 1-99 } -- Reinforce calls min
    reinforceCount_MAX=1,--{ 1-99 } -- Reinforce calls max
    reinforceLevel_MIN="NONE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level min
    reinforceLevel_MAX="BLACK_SUPER_REINFORCE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level max
    revengeIgnoreBlocked_MIN=0,--{ 0-1 } -- Ignore combat-deploy supply blocks min
    revengeIgnoreBlocked_MAX=1,--{ 0-1 } -- Ignore combat-deploy supply blocks max
    --Weapon deployment
    SNIPER_MIN=0,--{ 0-100 } --  (percentage)
    SNIPER_MAX=100,--{ 0-100 } --  (percentage)
    MISSILE_MIN=0,--{ 0-100 } --  (percentage)
    MISSILE_MAX=100,--{ 0-100 } --  (percentage)
    MG_MIN=0,--{ 0-100 } --  (percentage)
    MG_MAX=100,--{ 0-100 } --  (percentage)
    SHOTGUN_MIN=0,--{ 0-100 } --  (percentage)
    SHOTGUN_MAX=100,--{ 0-100 } --  (percentage)
    SMG_MIN=0,--{ 0-100 } --  (percentage)
    SMG_MAX=100,--{ 0-100 } --  (percentage)
    ASSAULT_MIN=0,--{ 0-100 } --  (percentage)
    ASSAULT_MAX=100,--{ 0-100 } --  (percentage)
    GUN_LIGHT_MIN=0,--{ 0-100 } --  (percentage)
    GUN_LIGHT_MAX=100,--{ 0-100 } --  (percentage)
    --Armor deployment
    ARMOR_MIN=0,--{ 0-100 } --  (percentage)
    ARMOR_MAX=100,--{ 0-100 } --  (percentage)
    SOFT_ARMOR_MIN=0,--{ 0-100 } --  (percentage)
    SOFT_ARMOR_MAX=100,--{ 0-100 } --  (percentage)
    SHIELD_MIN=0,--{ 0-100 } --  (percentage)
    SHIELD_MAX=100,--{ 0-100 } --  (percentage)
    --Headgear deployment
    HELMET_MIN=0,--{ 0-100 } --  (percentage)
    HELMET_MAX=100,--{ 0-100 } --  (percentage)
    NVG_MIN=0,--{ 0-100 } --  (percentage)
    NVG_MAX=100,--{ 0-100 } --  (percentage)
    GAS_MASK_MIN=0,--{ 0-100 } --  (percentage)
    GAS_MASK_MAX=100,--{ 0-100 } --  (percentage)
    --CP deterrent deployment
    DECOY_MIN=0,--{ 0-100 } --  (percentage)
    DECOY_MAX=100,--{ 0-100 } --  (percentage)
    MINE_MIN=0,--{ 0-100 } --  (percentage)
    MINE_MAX=100,--{ 0-100 } --  (percentage)
    CAMERA_MIN=0,--{ 0-100 } --  (percentage)
    CAMERA_MAX=100,--{ 0-100 } --  (percentage)
    --Soldier abilities
    STEALTH_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers notice,cure,reflex and speed ablilities.
    STEALTH_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    COMBAT_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } -- Adjusts enemy soldiers shot,grenade,reload,hp and speed abilities.
    COMBAT_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    HOLDUP_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    HOLDUP_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    FULTON_MIN="NONE",--{ NONE, LOW, HIGH, SPECIAL } --
    FULTON_MAX="SPECIAL",--{ NONE, LOW, HIGH, SPECIAL } --
    --Weapon strength menu
    STRONG_WEAPON_MIN=0,--{ 0-1 } --
    STRONG_WEAPON_MAX=1,--{ 0-1 } --
    STRONG_SNIPER_MIN=0,--{ 0-1 } --
    STRONG_SNIPER_MAX=1,--{ 0-1 } --
    STRONG_MISSILE_MIN=0,--{ 0-1 } --
    STRONG_MISSILE_MAX=1,--{ 0-1 } --
    --CP equip strength menu
    ACTIVE_DECOY_MIN=0,--{ 0-1 } --
    ACTIVE_DECOY_MAX=1,--{ 0-1 } --
    GUN_CAMERA_MIN=0,--{ 0-1 } --
    GUN_CAMERA_MAX=1,--{ 0-1 } --

    reinforceLevel_MIN="NONE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level min
    reinforceLevel_MAX="BLACK_SUPER_REINFORCE",--{ NONE, SUPER_REINFORCE, BLACK_SUPER_REINFORCE } -- Vehicle reinforcement level min

    reinforceCount_MIN=1,
    reinforceCount_MAX=5,
  }
}


return profiles