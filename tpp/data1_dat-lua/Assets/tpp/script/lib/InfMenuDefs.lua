-- DOBUILD: 1
-- InfMenuDefs.lua
local this={}
--LOCALOPT
local Ivars=Ivars
local InfMenuCommands=InfMenuCommands

--menus
this.fovaModMenu={
  options={
    Ivars.enableFovaMod,
    Ivars.fovaSelection,
    InfMenuCommands.printBodyInfo,
  }
}

this.appearanceMenu={
  nonConfig=true,
  options={
    Ivars.playerType,
    Ivars.playerPartsType,
    Ivars.playerCamoType,
    Ivars.playerFaceEquipId,
    Ivars.playerFaceFilter,
    Ivars.playerFaceId,
    InfMenuCommands.printFaceInfo,
    --OFF Ivars.playerHeadgear,
    InfMenuCommands.printCurrentAppearance,
    this.fovaModMenu,
  }
}

this.appearanceDebugMenu={
  nonConfig=true,
  options={
    Ivars.faceFovaDirect,
    Ivars.faceDecoFovaDirect,
    Ivars.hairFovaDirect,
    Ivars.hairDecoFovaDirect,
    Ivars.playerTypeDirect,
    Ivars.playerPartsTypeDirect,
    Ivars.playerCamoTypeDirect,
    Ivars.playerFaceIdDirect,
    Ivars.playerFaceEquipIdDirect,

    InfMenuCommands.printFaceInfo,
    --OFF Ivars.playerHeadgear,
    InfMenuCommands.printCurrentAppearance,

    Ivars.faceFova,
    Ivars.faceDecoFova,
    Ivars.hairFova,
    Ivars.hairDecoFova,

    Ivars.faceFovaUnknown1,
    Ivars.faceFovaUnknown2,
    Ivars.faceFovaUnknown3,
    Ivars.faceFovaUnknown4,
    Ivars.faceFovaUnknown5,
    Ivars.faceFovaUnknown6,
    Ivars.faceFovaUnknown7,
    Ivars.faceFovaUnknown8,
    Ivars.faceFovaUnknown9,
    Ivars.faceFovaUnknown10,
    this.fovaModMenu,
  }
}

this.playerSettingsMenu={
  options={
    Ivars.playerHealthScale,
    InfMenuCommands.removeDemon,
    InfMenuCommands.setDemon,
    Ivars.useSoldierForDemos,
    --Ivars.playerHeadgear,
    this.appearanceMenu,
  }
}
this.soldierParamsMenu={
  options={
    Ivars.soldierParamsProfile,
    Ivars.soldierHealthScale,
    Ivars.soldierSightDistScale,
    Ivars.soldierNightSightDistScale,
    Ivars.soldierHearingDistScale,
    Ivars.itemDropChance,
    InfMenuCommands.printHealthTableParameter,
    InfMenuCommands.printSightFormParameter,
    InfMenuCommands.printHearingTable,
  }
}

--local sightDistScaleName=Ivars.sightDistScaleName
--local i=1
--for n,listName in ipairs(Ivars.sightIvarLists) do
--  for m,name in ipairs(Ivars[listName]) do
--    local ivarName=name..sightDistScaleName
--    this.soldierParamsMenu.options[i]=Ivars[ivarName]
--    i=i+1
--  end
--end

this.sideOpsMenu={
  options={
    Ivars.unlockSideOps,
    Ivars.sideOpsSelectionMode,
    Ivars.unlockSideOpNumber,
    Ivars.enableHeliReinforce,
  }
}

this.motherBaseShowCharactersMenu={
  options={
    Ivars.mbEnableOcelot,
    Ivars.mbEnablePuppy,
    Ivars.mbShowCodeTalker,
    Ivars.mbShowEli,
    InfMenuCommands.resetPaz,
  }
}

this.motherBaseShowAssetsMenu={
  options={
    Ivars.mbShowBigBossPosters,
    --Ivars.mbShowQuietCellSigns,--tex not that interesting
    Ivars.mbShowMbEliminationMonument,
    Ivars.mbShowSahelan,
    Ivars.mbUnlockGoalDoors,
  }
}

this.dDEquipMenu={
  options={
    Ivars.enableDDEquipMB,
    Ivars.enableDDEquipFREE,
    Ivars.enableDDEquipMISSION,
    Ivars.soldierEquipGrade_MIN,
    Ivars.soldierEquipGrade_MAX,
    Ivars.allowUndevelopedDDEquip,
    Ivars.mbDDEquipNonLethal,
    Ivars.mbSoldierEquipRange,
  }
}

--tex SYNC motherbaseProfile
this.motherBaseMenu={
  options={
    --OFF TODO Ivars.motherbaseProfile,
    Ivars.revengeModeMB,
    this.dDEquipMenu,
    Ivars.mbDDSuit,
    Ivars.mbDDSuitFemale,
    Ivars.mbDDHeadGear,
    Ivars.mbPrioritizeFemale,
    --Ivars.disableMotherbaseWeaponRestriction,--WIP
    Ivars.npcHeliUpdate,
    Ivars.mbEnemyHeliColor,
    Ivars.enableWalkerGearsMB,
    Ivars.mbWalkerGearsColor,
    Ivars.mbWalkerGearsWeapon,
    Ivars.mbCollectionRepop,
    Ivars.mbMoraleBoosts,
    Ivars.mbEnableBuddies,
    Ivars.mbAdditionalSoldiers,
    Ivars.mbNpcRouteChange,
    this.motherBaseShowCharactersMenu,
    this.motherBaseShowAssetsMenu,
    Ivars.mbWargameFemales,
    Ivars.mbWarGamesProfile,
  }
}

this.demosMenu={
  options={
    Ivars.useSoldierForDemos,
    Ivars.mbDemoSelection,
    Ivars.mbSelectedDemo,
    Ivars.mbDemoOverrideTime,
    Ivars.mbDemoHour,
    Ivars.mbDemoMinute,
    Ivars.mbDemoOverrideWeather,
  --Ivars.mbDontDemoDisableBuddy,--WIP
  }
}

this.patchupMenu={
  options={
  }
}

this.debugMenu={
  options={
    Ivars.debugMode,
    Ivars.telopMode,
    Ivars.startOffline,
    Ivars.langOverride,
    InfMenuCommands.unlockPlayableAvatar,
    InfMenuCommands.unlockWeaponCustomization,
    InfMenuCommands.returnQuiet,
    InfMenuCommands.showQuietReunionMissionCount,
    InfMenuCommands.forceAllQuestOpenFlagFalse,
    InfMenuCommands.showPosition,
    InfMenuCommands.showMissionCode,
    InfMenuCommands.showLangCode,
    this.appearanceDebugMenu,
  }
}

this.ospMenu={
  noResetItem=true,
  options={
    Ivars.primaryWeaponOsp,
    Ivars.secondaryWeaponOsp,
    Ivars.tertiaryWeaponOsp,--tex user can set in UI, but still have it for setting the profile changes, and also if they want to set it while they're doing the other settings
    Ivars.clearItems,
    Ivars.clearSupportItems,
  }
}

this.handLevelMenu={
  noResetItem=true,
  options={
    Ivars.handLevelSonar,
    Ivars.handLevelPhysical,
    Ivars.handLevelPrecision,
    Ivars.handLevelMedical,
  }
}

this.fultonLevelMenu={
  noResetItem=true,
  options={
    Ivars.itemLevelFulton,
    Ivars.itemLevelWormhole,
  }
}

this.fultonSuccessMenu={
  options={
    Ivars.fultonNoMbSupport,
    Ivars.fultonNoMbMedical,
    Ivars.fultonDyingPenalty,
    Ivars.fultonSleepPenalty,
    Ivars.fultonHoldupPenalty,
    Ivars.fultonDontApplyMbMedicalToSleep,
    Ivars.fultonHostageHandling,
  },
}

this.revengeSystemMenu={
  options={
    Ivars.revengeBlockForMissionCount,
    Ivars.applyPowersToOuterBase,
    Ivars.applyPowersToLrrp,
    Ivars.allowHeavyArmorFREE,
    Ivars.allowHeavyArmorMISSION,
    Ivars.disableMissionsWeaponRestriction,
    Ivars.disableNoStealthCombatRevengeMission,
    Ivars.revengeDecayOnLongMbVisit,
    --Ivars.disableMotherbaseWeaponRestriction,--WIP TODO
    Ivars.allowHeadGearCombo,
    Ivars.balanceHeadGear,
    Ivars.allowMissileWeaponsCombo,
    Ivars.enableMgVsShotgunVariation,
    Ivars.randomizeSmallCpPowers,
    Ivars.disableConvertArmorToShield,
  --Ivars.balanceWeaponPowers,--WIP
  }
}
--
local minSuffix="_MIN"
local maxSuffix="_MAX"
local menuSuffix="Menu"
local function AddMinMaxIvarsListMenu(menuName,ivarList)
  local newMenu={
    options={
    }
  }

  local menuOptions=newMenu.options
  for i,ivarName in ipairs(ivarList)do
    menuOptions[#menuOptions+1]=Ivars[ivarName..minSuffix]
    menuOptions[#menuOptions+1]=Ivars[ivarName..maxSuffix]
  end

  this[menuName..menuSuffix]=newMenu--tex add to InfMenuDefs
end

for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
  AddMinMaxIvarsListMenu(powerTableName,Ivars[powerTableName])
end

AddMinMaxIvarsListMenu("abilityCustom",Ivars.abilitiesWithLevels)
AddMinMaxIvarsListMenu("weaponStrengthCustom",Ivars.weaponStrengthPowers)
AddMinMaxIvarsListMenu("cpEquipBoolPowers",Ivars.cpEquipBoolPowers)

this.revengeCustomMenu={
  options={
    Ivars.revengeConfigProfile,
    InfMenuCommands.printCustomRevengeConfig,
  }
}
local revengeMenu=this.revengeCustomMenu.options
for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
  revengeMenu[#revengeMenu+1]=this[powerTableName..menuSuffix]
end
table.insert(revengeMenu,this.abilityCustomMenu)
table.insert(revengeMenu,this.weaponStrengthCustomMenu)
table.insert(revengeMenu,this.cpEquipBoolPowersMenu)
local revengeMinMaxIvarList={
  "reinforceCount",
  "reinforceLevel",
  "revengeIgnoreBlocked",
}
local menuOptions=revengeMenu
for i,ivarName in ipairs(revengeMinMaxIvarList)do
  menuOptions[#menuOptions+1]=Ivars[ivarName..minSuffix]
  menuOptions[#menuOptions+1]=Ivars[ivarName..maxSuffix]
end

this.revengeMenu={
  options={
    Ivars.revengeModeFREE,
    Ivars.revengeModeMISSION,
    Ivars.revengeModeMB,
    this.revengeCustomMenu,
    this.revengeSystemMenu,
    this.dDEquipMenu,
    InfMenuCommands.resetRevenge,
    Ivars.changeCpSubTypeFREE,
    Ivars.changeCpSubTypeMISSION,
    Ivars.enableWildCardFreeRoam,
    Ivars.enableInfInterrogation,
  }
}
--
this.playerRestrictionsInMissionMenu={
  options={
    Ivars.disableHeadMarkers,
    --Ivars.disableXrayMarkers,--tex doesn't seem to work realtime
    Ivars.disableWorldMarkers,
  },
}

this.phaseMenu={
  options={
    --this.printPlayerPhase,--DEBUG
    Ivars.phaseUpdate,
    Ivars.minPhase,
    Ivars.maxPhase,
    Ivars.keepPhase,
    Ivars.phaseUpdateRate,
    Ivars.phaseUpdateRange,
    Ivars.soldierAlertOnHeavyVehicleDamage,--tex these>
    --Ivars.cpAlertOnVehicleFulton,--WIP, NOTE: ivar save is disabled
    Ivars.printPhaseChanges,--<don't rely on phaseUpdate
  },
}

this.supportHeliMenu={
  options={
    --Ivars.setTakeOffWaitTime,
    --InfMenuCommands.pullOutHeli,
    --InfMenuCommands.changeToIdleStateHeli,
    Ivars.disableHeliAttack,
    Ivars.setInvincibleHeli,
    Ivars.setSearchLightForcedHeli,
    Ivars.disablePullOutHeli,
    Ivars.setLandingZoneWaitHeightTop,
    Ivars.defaultHeliDoorOpenTime,
    Ivars.startOnFootFREE,
    Ivars.startOnFootMISSION,
    Ivars.startOnFootMB_ALL,
  --Ivars.disableDescentToLandingZone,
  --Ivars.enableGetOutHeli,--WIP
  --Ivars.heliUpdate,--NONUSER
  },
}

this.enemyReinforceMenu={
  options={
    Ivars.forceSuperReinforce,
    Ivars.enableHeliReinforce,
    Ivars.forceReinforceRequest,
    Ivars.disableReinforceHeliPullOut,
    Ivars.enableSoldiersWithVehicleReinforce,
  },
}

this.enemyPatrolMenu={
  options={
    Ivars.enableLrrpFreeRoam,
    Ivars.enemyHeliPatrol,
    Ivars.mbEnemyHeliColor,
    Ivars.vehiclePatrolProfile,
    Ivars.vehiclePatrolClass,
    Ivars.vehiclePatrolLvEnable,
    Ivars.vehiclePatrolTruckEnable,
    Ivars.vehiclePatrolWavEnable,
    Ivars.vehiclePatrolWavHeavyEnable,
    Ivars.vehiclePatrolTankEnable,
    Ivars.putEquipOnTrucks,
  }
}

this.footPatrolMenu={
  options={
    Ivars.enableLrrpFreeRoam,
  --    Ivars.lrrpSizeFreeRoam_MIN,
  --    Ivars.lrrpSizeFreeRoam_MAX,
  }
}

this.cameraMenu={
  options={
    Ivars.adjustCameraUpdate,
    Ivars.cameraMode,
    InfMenuCommands.warpToCamPos,
    Ivars.moveScale,
    Ivars.disableCamText,
  --    Ivars.focalLength,--CULL
  --    Ivars.focusDistance,
  --    Ivars.aperture,
  --    InfMenuCommands.resetCameraSettings,--tex just reset cam pos at the moment
  }
}

this.userMarkerMenu={
  options={
    InfMenuCommands.warpToUserMarker,
    InfMenuCommands.printLatestUserMarker,
    InfMenuCommands.printUserMarkers,
    --    InfMenuCommands.setSelectedCpToMarkerObjectCp,--DEBUG
    --    Ivars.selectedCp,--DEBUG
    InfMenuCommands.quietMoveToLastMarker,
  }
}

this.markersMenu={
  options={
    Ivars.disableHeadMarkers,
    Ivars.disableXrayMarkers,
    Ivars.disableWorldMarkers,
  }
}

this.missionPrepRestrictionsMenu={
  options={
    Ivars.disableSelectTime,
    Ivars.disableSelectBuddy,
    Ivars.disableSelectVehicle,
  }
}

this.disableSupportMenuMenu={
  options={
    Ivars.disableMenuDrop,
    Ivars.disableMenuBuddy,
    Ivars.disableMenuAttack,
    Ivars.disableMenuHeliAttack,
    Ivars.disableSupportMenu,
  }
}

this.worldMenu={
  options={
    Ivars.gameEventChanceFREE,
    Ivars.gameEventChanceMB,
    Ivars.enableParasiteEvent,
    Ivars.parasitePeriod_MIN,
    Ivars.parasitePeriod_MAX,
    --WIP DEBUGNOW Ivars.resourceAmountScale,
    Ivars.repopulateRadioTapes,
    Ivars.randomizeMineTypes,
    Ivars.additionalMineFields,
  }
}
this.playerRestrictionsMenu={
  options={
    Ivars.blockInMissionSubsistenceIvars,
    Ivars.disableHeliAttack,
    Ivars.disableFulton,
    Ivars.setSubsistenceSuit,
    Ivars.setDefaultHand,
    Ivars.disableLzs,
    Ivars.abortMenuItemControl,
    Ivars.disableRetry,
    Ivars.gameOverOnDiscovery,
    Ivars.disableSpySearch,
    Ivars.disableHerbSearch,
    Ivars.dontOverrideFreeLoadout,
    this.markersMenu,
    this.missionPrepRestrictionsMenu,
    this.disableSupportMenuMenu,
    this.handLevelMenu,
    this.fultonLevelMenu,
    this.fultonSuccessMenu,
    this.ospMenu,
  }
}

this.timeScaleMenu={
  options={
    InfMenuCommands.highSpeedCameraToggle,
    Ivars.speedCamContinueTime,
    Ivars.speedCamWorldTimeScale,
    Ivars.speedCamPlayerTimeScale,
    Ivars.clockTimeScale,
  }
}

this.buddyMenu={
  options={
    Ivars.buddyChangeEquipVar,
    InfMenuCommands.quietMoveToLastMarker,
    Ivars.quietRadioMode,
  }
}

this.heliSpaceMenu={
  noResetItem=true,
  noGoBackItem=true,
  options={
    --InfMenuCommands.DEBUG_SetIvarsToDefault,--DEBUG
--    InfMenuCommands.DEBUG_SomeShiz,--DEBUG
--    InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
--    InfMenuCommands.DEBUG_SomeShiz3,--DEBUG
    --Ivars.playerFaceId,--DEBUG
    Ivars.selectProfile,
    --InfMenuCommands.applySelectedProfile,
    InfMenuCommands.resetSelectedProfile,
    --InfMenuCommands.viewProfile,--DEBUGNOW
    InfMenuCommands.forceGameEvent,
    this.worldMenu,
    this.playerRestrictionsMenu,
    this.playerSettingsMenu,
    this.soldierParamsMenu,
    this.phaseMenu,
    this.revengeMenu,
    this.enemyReinforceMenu,
    this.enemyPatrolMenu,
    this.sideOpsMenu,
    this.motherBaseMenu,
    this.demosMenu,
    this.cameraMenu,
    this.timeScaleMenu,
    this.supportHeliMenu,
    --this.missionEntryExitMenu,
    --this.appearanceMenu,--tex  WIP
    this.debugMenu,
    InfMenuCommands.resetAllSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

this.debugInMissionMenu={
  nonConfig=true,
  options={
    Ivars.debugMode,
    --InfMenuCommands.DEBUG_RandomizeCp,
    --InfMenuCommands.DEBUG_PrintRealizedCount,
    --InfMenuCommands.DEBUG_PrintEnemyFova,
    Ivars.selectedCp,
    InfMenuCommands.setSelectedCpToMarkerObjectCp,--DEBUG
    InfMenuCommands.DEBUG_PrintCpPowerSettings,
    InfMenuCommands.DEBUG_PrintPowersCount,
    --InfMenuCommands.DEBUG_PrintCpSizes,
    InfMenuCommands.DEBUG_PrintReinforceVars,
    --InfMenuCommands.DEBUG_PrintVehicleTypes,
    --InfMenuCommands.DEBUG_PrintVehiclePaint,
    InfMenuCommands.DEBUG_PrintSoldierDefine,
    --InfMenuCommands.DEBUG_PrintSoldierIDList,
    InfMenuCommands.DEBUG_ShowRevengeConfig,
    this.appearanceDebugMenu,
    --InfMenuCommands.DEBUG_ShowPhaseEnums,--CULL
    --InfMenuCommands.DEBUG_ChangePhase,
    --InfMenuCommands.DEBUG_KeepPhaseOn,
    --InfMenuCommands.DEBUG_KeepPhaseOff,
    --InfMenuCommands.printPlayerPhase,
    --InfMenuCommands.DEBUG_SetPlayerPhaseToIvar,
    --InfMenuCommands.DEBUG_PrintVarsClock,
    --InfMenuCommands.showMissionCode,
    --InfMenuCommands.showMbEquipGrade,
    Ivars.printOnBlockChange,
    InfMenuCommands.showPosition,
  --InfMenuCommands.DEBUG_ClearAnnounceLog,
  }
}

this.inMissionMenu={
  noResetItem=true,--tex KLUDGE, to keep menuoffitem order
  noGoBackItem=true,--tex is root
  options={
    --    InfMenuCommands.DEBUG_WarpToObject,--DEBUG
    --InfMenuCommands.DEBUG_SomeShiz,--DEBUG
--    InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
--    InfMenuCommands.DEBUG_SomeShiz3,--DEBUG
    InfMenuCommands.requestHeliLzToLastMarker,
    InfMenuCommands.forceExitHeli,
    Ivars.warpPlayerUpdate,
    this.cameraMenu,
    this.timeScaleMenu,
    this.userMarkerMenu,
    this.buddyMenu,
    this.appearanceMenu,
    this.playerRestrictionsInMissionMenu,
    this.phaseMenu,
    this.supportHeliMenu,
    this.debugInMissionMenu,
    Ivars.itemDropChance,
    Ivars.playerHealthScale,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

--TABLESETUP: MenuDefs
local optionType="MENU"
local IsTable=Tpp.IsTypeTable
for name,item in pairs(this) do
  if IsTable(item) then
    if item.options then
      item.optionType=optionType
      item.name=name
      item.disabled=false
      item.parent=nil
      if item.noResetItem~=true then
        item.options[#item.options+1]=InfMenuCommands.resetSettingsItem
      end
      if item.noGoBackItem~=true then
        item.options[#item.options+1]=InfMenuCommands.goBackItem
      end
    end
  end
end

this.allMenus={}
--TABLESETUP: allMenus, for reset, also means you have to comment out whole menu, not just references from other menus since resetall iterates the whole module
local i=1
for n,item in pairs(this) do
  if IsTable(item) then
    if item.options then--tex is menu
      this.allMenus[i]=item
      i=i+1
    end
  end
end

return this
