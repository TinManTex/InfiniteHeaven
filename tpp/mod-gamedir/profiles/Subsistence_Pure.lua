--tex additional restrictions on beyond subsistence Game that should prove more challenging
local this={
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
return this