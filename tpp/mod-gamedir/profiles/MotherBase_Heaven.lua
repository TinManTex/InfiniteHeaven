--tex My suggested settings for mother base
local this={
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
    mbPrioritizeFemale="HALF",--{ OFF, DISABLE, MAX, HALF } -- Female staff selection
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
return this