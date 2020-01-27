--tex aims to match same settings as Subsistence missions
local this={
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
return this