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
    npcHeliUpdate="UTH_AND_HP48",--{ OFF, UTH, UTH_AND_HP48 } -- NPC helis
    enableWalkerGearsMB=1,--{ 0-1 } -- Walker gears
    mbWalkerGearsColor="DDOGS",--{ SOVIET, ROGUE_COYOTE, CFA, ZRS, DDOGS, HUEY_PROTO, RANDOM, RANDOM_EACH } -- Walker gears type
    mbWalkerGearsWeapon=0,--{ DEFAULT, MINIGUN, MISSILE, RANDOM, RANDOM_EACH } -- Walker gears weapons
    mbCollectionRepop=1,--{ 0-1 } -- Repopulate plants and diamonds
    mbMoraleBoosts=1,--{ 0-1 } -- Staff-wide morale boost for good visit
    mbEnableBuddies=1,--{ 0-1 } -- Enable all buddies
    mbAdditionalSoldiers=1,--{ 0-1 } -- More soldiers on MB plats
    mbNpcRouteChange=1,--{ 0-1 } -- Soldiers move between platforms
    mbWargameFemales=15,--{ 0-100 } -- Women in Enemy Invasion mode (percentage)
    --Show characters menu
    mbEnableOcelot=1,--{ 0-1 } -- Enable Ocelot
    mbEnablePuppy=2,--{ OFF, MISSING_EYE, NORMAL_EYES } -- Puppy DDog
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
    fultonHostageHandling="ZERO",--{ DEFAULT, ZERO } -- Hostage handling
  }
}

--tex aims to match same settings as Subsistence missions
profiles.subsistencePure={
  description="Subsistence - Pure",
  profile={
    blockInMissionSubsistenceIvars=1,

    disableLzs="REGULAR",
    disableSelectBuddy=1,
    disableHeliAttack=1,
    disableSelectTime=1,
    disableSelectVehicle=1,
    disableHeadMarkers=1,

    disableXrayMarkers=0,
    disableWorldMarkers=1,
    disableFulton=1,
    clearItems=1,
    clearSupportItems=1,
    setSubsistenceSuit=1,
    setDefaultHand=1,

    primaryWeaponOsp="EQUIP_NONE",
    secondaryWeaponOsp="EQUIP_NONE",
    tertiaryWeaponOsp="EQUIP_NONE",

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
    blockInMissionSubsistenceIvars=1,

    disableLzs="REGULAR",
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

    primaryWeaponOsp="EQUIP_NONE",
    secondaryWeaponOsp="EQUIP_NONE",
    tertiaryWeaponOsp="EQUIP_NONE",

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
