-- InfMenuDefs.lua
local this={}
--LOCALOPT
--tex NOTE its ok to reference modules that are reloaded before this is reloaded
local Ivars=Ivars
local InfMenuCommands=InfMenuCommands
local InfMenuDefs=this

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
    InfMenuDefs.fovaModMenu,
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
    InfMenuDefs.fovaModMenu,
  }
}

this.playerSettingsMenu={
  options={
    Ivars.playerHealthScale,
    InfMenuCommands.removeDemon,
    InfMenuCommands.setDemon,
    Ivars.useSoldierForDemos,
    --Ivars.playerHeadgear,
    InfMenuDefs.appearanceMenu,
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
    InfMenuCommands.returnQuiet,
    InfMenuCommands.showQuietReunionMissionCount,
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

this.customEquipMenu={
  options={
    --CULL
    --    Ivars.enableDDEquipMB,
    --    Ivars.enableDDEquipFREE,
    --    Ivars.enableDDEquipMISSION,
    Ivars.customWeaponTableFREE,
    Ivars.customWeaponTableMISSION,
    Ivars.customWeaponTableMB_ALL,
    Ivars.weaponTableStrength,
    Ivars.weaponTableAfgh,
    Ivars.weaponTableMafr,
    Ivars.weaponTableSkull,
    Ivars.weaponTableDD,
    Ivars.soldierEquipGrade_MIN,
    Ivars.soldierEquipGrade_MAX,
    Ivars.allowUndevelopedDDEquip,
    Ivars.mbDDEquipNonLethal,
  }
}

--tex SYNC motherbaseProfile
this.motherBaseMenu={
  options={
    Ivars.revengeModeMB,
    InfMenuDefs.customEquipMenu,
    Ivars.mbSoldierEquipRange,
    Ivars.mbDDSuit,
    Ivars.mbDDSuitFemale,
    Ivars.mbDDHeadGear,
    Ivars.mbPrioritizeFemale,
    --Ivars.disableMotherbaseWeaponRestriction,--WIP
    Ivars.heliPatrolsMB,
    Ivars.mbEnemyHeliColor,
    Ivars.enableWalkerGearsMB,
    Ivars.mbWalkerGearsColor,
    Ivars.mbWalkerGearsWeapon,
    Ivars.mbCollectionRepop,
    Ivars.mbMoraleBoosts,
    Ivars.revengeDecayOnLongMbVisit,
    Ivars.mbEnableBuddies,
    Ivars.mbAdditionalSoldiers,
    Ivars.mbqfEnableSoldiers,
    Ivars.mbNpcRouteChange,
    InfMenuDefs.motherBaseShowCharactersMenu,
    InfMenuDefs.motherBaseShowAssetsMenu,
    Ivars.mbEnableLethalActions,
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

this.progressionMenu={
  options={
    Ivars.resourceAmountScale,
    Ivars.repopulateRadioTapes,
    InfMenuCommands.unlockPlayableAvatar,
    InfMenuCommands.unlockWeaponCustomization,
    InfMenuCommands.resetPaz,
    InfMenuCommands.returnQuiet,
    InfMenuCommands.showQuietReunionMissionCount,
  --InfMenuCommands.forceAllQuestOpenFlagFalse,
  }
}

this.debugMenu={
  options={
    Ivars.debugMode,
    Ivars.debugMessages,
    Ivars.debugFlow,
    InfMenuCommands.loadExternalModules,
    InfMenuCommands.copyLogToPrev,
    Ivars.printPressedButtons,
    InfMenuCommands.showPosition,
    InfMenuCommands.showMissionCode,
    InfMenuCommands.showLangCode,
    InfMenuDefs.appearanceDebugMenu,
    Ivars.telopMode,--tex TODO move, odd one out, mission/presentation?
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
    Ivars.randomizeMineTypes,
    Ivars.additionalMineFields,
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
    InfMenuCommands.printCustomRevengeConfig,
  }
}
local revengeMenu=this.revengeCustomMenu.options
for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
  revengeMenu[#revengeMenu+1]=InfMenuDefs[powerTableName..menuSuffix]
end
table.insert(revengeMenu,InfMenuDefs.abilityCustomMenu)
table.insert(revengeMenu,InfMenuDefs.weaponStrengthCustomMenu)
table.insert(revengeMenu,InfMenuDefs.cpEquipBoolPowersMenu)
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
    InfMenuDefs.revengeCustomMenu,
    InfMenuDefs.revengeSystemMenu,
    InfMenuDefs.customEquipMenu,
    InfMenuCommands.resetRevenge,
    Ivars.changeCpSubTypeFREE,
    Ivars.changeCpSubTypeMISSION,
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
    Ivars.disableLzs,
    Ivars.startOnFootFREE,
    Ivars.startOnFootMISSION,
    Ivars.startOnFootMB_ALL,
  --Ivars.disableDescentToLandingZone,
  --Ivars.enableGetOutHeli,--WIP
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
    Ivars.enableWildCardFreeRoam,
    Ivars.heliPatrolsFREE,
    Ivars.heliPatrolsMB,
    Ivars.mbEnemyHeliColor,
    Ivars.enableWalkerGearsFREE,
    Ivars.enableWalkerGearsMB,
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

this.eventsMenu={
  options={
    InfMenuCommands.forceGameEvent,
    Ivars.gameEventChanceFREE,
    Ivars.gameEventChanceMB,
    Ivars.enableParasiteEvent,
    Ivars.armorParasiteEnabled,
    Ivars.mistParasiteEnabled,
    Ivars.camoParasiteEnabled,
    Ivars.parasitePeriod_MIN,
    Ivars.parasitePeriod_MAX,
    Ivars.parasiteWeather,
  }
}
this.playerRestrictionsMenu={
  options={
    Ivars.disableHeliAttack,
    Ivars.disableFulton,
    Ivars.setSubsistenceSuit,
    Ivars.setDefaultHand,
    Ivars.abortMenuItemControl,
    Ivars.disableRetry,
    Ivars.gameOverOnDiscovery,
    Ivars.disableSpySearch,
    Ivars.disableHerbSearch,
    Ivars.dontOverrideFreeLoadout,
    InfMenuDefs.markersMenu,
    InfMenuDefs.missionPrepRestrictionsMenu,
    InfMenuDefs.disableSupportMenuMenu,
    InfMenuDefs.handLevelMenu,
    InfMenuDefs.fultonLevelMenu,
    InfMenuDefs.fultonSuccessMenu,
    InfMenuDefs.ospMenu,
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

this.systemMenu={
  options={
    Ivars.selectProfile,
    --InfMenuCommands.applySelectedProfile,
    InfMenuCommands.resetSelectedProfile,
    --InfMenuCommands.viewProfile,--DEBUG
    Ivars.enableQuickMenu,
    Ivars.startOffline,
    Ivars.skipLogos,
    --Ivars.langOverride,
    InfMenuCommands.resetAllSettingsItem,
  },
}

this.heliSpaceMenu={
  noResetItem=true,
  noGoBackItem=true,
  options={
    --Ivars.resourceAmountScale,--DEBUG
    --InfMenuCommands.DEBUG_SomeShiz,--DEBUG
    --    InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
    --    InfMenuCommands.DEBUG_SomeShiz3,--DEBUG
    --Ivars.debugMode,
    InfMenuDefs.systemMenu,
    InfMenuDefs.eventsMenu,
    InfMenuDefs.playerRestrictionsMenu,
    InfMenuDefs.playerSettingsMenu,
    InfMenuDefs.soldierParamsMenu,
    InfMenuDefs.phaseMenu,
    InfMenuDefs.revengeMenu,
    InfMenuDefs.enemyReinforceMenu,
    InfMenuDefs.enemyPatrolMenu,
    InfMenuDefs.sideOpsMenu,
    InfMenuDefs.motherBaseMenu,
    InfMenuDefs.demosMenu,
    InfMenuDefs.cameraMenu,
    InfMenuDefs.timeScaleMenu,
    InfMenuDefs.supportHeliMenu,
    InfMenuDefs.progressionMenu,
    InfMenuDefs.debugMenu,
    InfMenuCommands.menuOffItem,
  }
}

this.debugInMissionMenu={
  nonConfig=true,
  options={
    Ivars.debugMode,
    Ivars.debugMessages,
    Ivars.debugFlow,
    InfMenuCommands.loadExternalModules,
    InfMenuCommands.copyLogToPrev,
    --InfMenuCommands.DEBUG_RandomizeCp,
    --InfMenuCommands.DEBUG_PrintRealizedCount,
    --InfMenuCommands.DEBUG_PrintEnemyFova,
    Ivars.selectedCp,
    InfMenuCommands.setSelectedCpToMarkerObjectCp,--DEBUG
    Ivars.printPressedButtons,
    InfMenuCommands.DEBUG_PrintCpPowerSettings,
    InfMenuCommands.DEBUG_PrintPowersCount,
    --InfMenuCommands.DEBUG_PrintCpSizes,
    InfMenuCommands.DEBUG_PrintReinforceVars,
    --InfMenuCommands.DEBUG_PrintVehicleTypes,
    --InfMenuCommands.DEBUG_PrintVehiclePaint,
    InfMenuCommands.DEBUG_PrintSoldierDefine,
    --InfMenuCommands.DEBUG_PrintSoldierIDList,
    InfMenuCommands.DEBUG_ShowRevengeConfig,
    InfMenuDefs.appearanceDebugMenu,
    --InfMenuCommands.DEBUG_ShowPhaseEnums,--CULL
    --InfMenuCommands.DEBUG_ChangePhase,
    --InfMenuCommands.DEBUG_KeepPhaseOn,
    --InfMenuCommands.DEBUG_KeepPhaseOff,
    --InfMenuCommands.printPlayerPhase,
    --InfMenuCommands.DEBUG_SetPlayerPhaseToIvar,
    --InfMenuCommands.DEBUG_PrintVarsClock,
    --InfMenuCommands.showMissionCode,
    --InfMenuCommands.showMbEquipGrade,
    Ivars.printPressedButtons,
    Ivars.printOnBlockChange,
    InfMenuCommands.showPosition,
  --InfMenuCommands.DEBUG_ClearAnnounceLog,
  }
}

this.inMissionMenu={
  noResetItem=true,--tex KLUDGE, to keep menuoffitem order
  noGoBackItem=true,--tex is root
  options={
    --Ivars.warpToListObject,--DEBUG
    --    InfMenuCommands.DEBUG_PrintSoldierDefine,--DEBUG
    --       InfMenuCommands.showPosition,
    --    InfMenuCommands.DEBUG_ToggleParasiteEvent,
    --InfMenuCommands.DEBUG_SomeShiz,--DEBUG
    --    InfMenuCommands.DEBUG_SomeShiz,--DEBUG
    --    InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
    ----
    InfMenuCommands.requestHeliLzToLastMarker,
    InfMenuCommands.forceExitHeli,
    InfMenuCommands.dropCurrentEquip,
    Ivars.warpPlayerUpdate,
    InfMenuDefs.cameraMenu,
    InfMenuDefs.timeScaleMenu,
    InfMenuDefs.userMarkerMenu,
    InfMenuDefs.buddyMenu,
    InfMenuDefs.appearanceMenu,
    InfMenuDefs.playerRestrictionsInMissionMenu,
    InfMenuDefs.phaseMenu,
    InfMenuDefs.supportHeliMenu,
    InfMenuDefs.debugInMissionMenu,
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

--tex TODO RETHINK
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
