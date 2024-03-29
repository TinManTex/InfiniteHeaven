--tex A bit less restrictive subsistence style
local this={
  description="Subsistence - Bounder",
  profile={
    --disableLzs="REGULAR",
    heliSpace_NoBuddyMenuFromMissionPreparetionFREE=0,
    heliSpace_DisableSelectSortieTimeFromMissionPreparetionFREE=1,
    heliSpace_NoVehicleMenuFromMissionPreparetionFREE=1,
    heliSpace_NoBuddyMenuFromMissionPreparetionMISSION=0,
    heliSpace_DisableSelectSortieTimeFromMissionPreparetionMISSION=1,
    heliSpace_NoVehicleMenuFromMissionPreparetionMISSION=1,    
    disableHeliAttack=1,
    
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
return this