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

    handLevelProfile=1,
    fultonLevelProfile=1,

    disableMenuDrop=1,
    disableMenuBuddy=1,
    disableMenuAttack=1,
    disableMenuHeliAttack=1,
    disableSupportMenu=1,

    abortMenuItemControl=1,
    disableRetry=0,
    gameOverOnDiscovery=0,
    maxPhase="PHASE_ALERT",--Reset

    fultonLevelProfile=1,
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

    handLevelProfile=1,
    fultonLevelProfile=1,

    disableMenuDrop=1,
    disableMenuBuddy=0,
    disableMenuAttack=1,
    disableMenuHeliAttack=1,
    disableSupportMenu=1,

    abortMenuItemControl=0,
    disableRetry=0,
    gameOverOnDiscovery=0,
    maxPhase="PHASE_ALERT",--Reset

    fultonLevelProfile=1,
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