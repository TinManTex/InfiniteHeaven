-- DOBUILD: 1
local this={}
--menus
this.fovaModMenu={
  options={    
    Ivars.enableFovaMod,
    Ivars.fovaSelection,
    InfMenuCommands.printBodyInfo,
  }
}

this.playerSettingsMenu={
  options={
    Ivars.playerHealthScale,
    InfMenuCommands.removeDemon,
    InfMenuCommands.setDemon,
    Ivars.useSoldierForDemos,
    Ivars.playerHeadgear,
    this.fovaModMenu,
  }
}
this.soldierParamsMenu={
  options={
    Ivars.soldierParamsProfile,
    Ivars.soldierHealthScale,
    Ivars.soldierSightDistScale,
    Ivars.soldierHearingDistScale,
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
    Ivars.unlockSideOpNumber,
    Ivars.enableHeliReinforce,
  }
}

this.motherBaseShowAssetsMenu={
  options={
    Ivars.mbShowBigBossPosters,
    --Ivars.mbShowQuietCellSigns,--tex not that interesting
    Ivars.mbShowMbEliminationMonument,
    Ivars.mbShowSahelan,
    Ivars.mbShowEli,
    Ivars.mbShowCodeTalker,
    Ivars.mbUnlockGoalDoors,
  }
}

this.dDEquipMenu={
  options={
    Ivars.enableMbDDEquip,
    Ivars.enableEnemyDDEquip,
    Ivars.enableEnemyDDEquipMissions,
    Ivars.mbSoldierEquipGrade_MIN,
    Ivars.mbSoldierEquipGrade_MAX,
    Ivars.allowUndevelopedDDEquip,
    Ivars.mbDDEquipNonLethal,
    Ivars.mbSoldierEquipRange,
  }
}

this.motherBaseMenu={
  options={
    Ivars.revengeModeForMb,
    this.dDEquipMenu,
    Ivars.mbDDSuit,
    Ivars.mbDDSuitFemale,
    Ivars.mbDDHeadGear,
    Ivars.mbPrioritizeFemale,
    --Ivars.disableMotherbaseWeaponRestriction,--WIP
    Ivars.mbEnableBuddies,
    Ivars.mbEnableOcelot,
    Ivars.npcHeliUpdate,
    Ivars.mbCollectionRepop,
    this.motherBaseShowAssetsMenu,
    Ivars.mbWargameFemales,
    Ivars.mbEnemyHeliColor,
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
    Ivars.telopMode,
    InfMenuCommands.unlockPlayableAvatar,
    InfMenuCommands.unlockWeaponCustomization,
    Ivars.startOffline,
    --Ivars.blockFobTutorial,
    --Ivars.setFirstFobBuilt,
    Ivars.langOverride,
    InfMenuCommands.returnQuiet,
    InfMenuCommands.showQuietReunionMissionCount,
    InfMenuCommands.showLangCode,
    InfMenuCommands.showPosition,
    InfMenuCommands.showMissionCode,
    InfMenuCommands.printCustomRevengeConfig,
    --InfMenuCommands.showMbEquipGrade,
    InfMenuCommands.forceAllQuestOpenFlagFalse,
    InfMenuCommands.DEBUG_PrintSaveVarCount,
  }
}

this.ospMenu={
  noResetItem=true,
  options={
    Ivars.ospWeaponProfile,
    Ivars.primaryWeaponOsp,
    Ivars.secondaryWeaponOsp,
    Ivars.tertiaryWeaponOsp,--tex user can set in UI, but still have it for setting the profile changes, and also if they want to set it while they're doing the other settings
  }
}

this.handLevelMenu={
  noResetItem=true,
  options={
    Ivars.handLevelProfile,
    Ivars.handLevelSonar,
    Ivars.handLevelPhysical,
    Ivars.handLevelPrecision,
    Ivars.handLevelMedical,
  }
}

this.fultonLevelMenu={
  noResetItem=true,
  options={
    Ivars.fultonLevelProfile,
    Ivars.itemLevelFulton,
    Ivars.itemLevelWormhole,
  }
}

this.fultonSuccessMenu={
  options={
    Ivars.fultonSuccessProfile,
    Ivars.fultonNoMbSupport,
    Ivars.fultonNoMbMedical,
    Ivars.fultonDyingPenalty,
    Ivars.fultonSleepPenalty,
    Ivars.fultonHoldupPenalty,
    Ivars.fultonDontApplyMbMedicalToSleep,
    Ivars.fultonHostageHandling,
  },
}

this.disableMenuMenu={
  options={
    Ivars.disableMenuDrop,
    Ivars.disableMenuBuddy,
    Ivars.disableMenuAttack,
    Ivars.disableMenuHeliAttack,
    Ivars.disableSupportMenu,
  }
}

this.revengeSystemMenu={
  options={
    Ivars.revengeProfile,
    Ivars.revengeBlockForMissionCount,
    Ivars.applyPowersToOuterBase,
    Ivars.applyPowersToLrrp,
    Ivars.allowHeavyArmorInFreeRoam,
    Ivars.allowHeavyArmorInAllMissions,
    Ivars.disableMissionsWeaponRestriction,
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
for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
  local powerTable=Ivars[powerTableName]

  local powerMenu={
    options={
    }
  }
  this[powerTableName.."Menu"]=powerMenu

  local menuOptions=powerMenu.options
  for m,powerType in ipairs(powerTable)do
    table.insert(menuOptions,Ivars[powerType.."_MIN"])
    table.insert(menuOptions,Ivars[powerType.."_MAX"])
  end
end

this.abilityCustomMenu={
  options={
  }
}
local menuOptions=this.abilityCustomMenu.options
for n,powerType in ipairs(Ivars.abilitiesWithLevels)do
  table.insert(menuOptions,Ivars[powerType.."_MIN"])
  table.insert(menuOptions,Ivars[powerType.."_MAX"])
end

this.weaponStrengthCustomMenu={
  options={
  }
}
local menuOptions=this.weaponStrengthCustomMenu.options
for n,powerType in ipairs(Ivars.weaponStrengthPowers)do
  table.insert(menuOptions,Ivars[powerType.."_MIN"])
  table.insert(menuOptions,Ivars[powerType.."_MAX"])
end

this.cpEquipBoolPowersMenu={
  options={
  }
}
local menuOptions=this.cpEquipBoolPowersMenu.options
for n,powerType in ipairs(Ivars.cpEquipBoolPowers)do
  table.insert(menuOptions,Ivars[powerType.."_MIN"])
  table.insert(menuOptions,Ivars[powerType.."_MAX"])
end
table.insert(menuOptions,InfMenuCommands.resetSettingsItem)
table.insert(menuOptions,InfMenuCommands.goBackItem)


this.revengeCustomMenu={
  options={
  }
}
local revengeMenu=this.revengeCustomMenu.options

table.insert(revengeMenu,Ivars.revengeConfigProfile)

for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
  table.insert(revengeMenu,this[powerTableName.."Menu"])
end
table.insert(revengeMenu,this.abilityCustomMenu)
table.insert(revengeMenu,this.weaponStrengthCustomMenu)
table.insert(revengeMenu,this.cpEquipBoolPowersMenu)
table.insert(revengeMenu,Ivars.reinforceCount_MIN)
table.insert(revengeMenu,Ivars.reinforceCount_MAX)
table.insert(revengeMenu,Ivars.reinforceLevel_MIN)
table.insert(revengeMenu,Ivars.reinforceLevel_MAX)
table.insert(revengeMenu,Ivars.revengeIgnoreBlocked_MIN)
table.insert(revengeMenu,Ivars.revengeIgnoreBlocked_MAX)

this.revengeMenu={
  options={
    Ivars.revengeMode,
    Ivars.revengeModeForMissions,
    Ivars.revengeModeForMb,
    this.revengeCustomMenu,
    this.revengeSystemMenu,
    this.dDEquipMenu,
    InfMenuCommands.resetRevenge,
    Ivars.changeCpSubTypeFree,
    Ivars.changeCpSubTypeForMissions,
    Ivars.enableWildCardFreeRoam,
  }
}
--

this.playerRestrictionsMenu={
  options={
    Ivars.subsistenceProfile,
    Ivars.disableHeadMarkers,
    Ivars.disableXrayMarkers,
    Ivars.disableWorldMarkers,
    Ivars.disableBuddies,
    Ivars.disableHeliAttack,
    Ivars.disableSelectTime,
    Ivars.disableSelectVehicle,
    Ivars.disableFulton,
    Ivars.clearItems,
    Ivars.clearSupportItems,
    Ivars.setSubsistenceSuit,
    Ivars.setDefaultHand,
    Ivars.noCentralLzs,
    Ivars.abortMenuItemControl,
    Ivars.disableRetry,
    Ivars.gameOverOnDiscovery,
    this.handLevelMenu,
    this.fultonLevelMenu,
    this.fultonSuccessMenu,
    this.ospMenu,
    this.disableMenuMenu,
    Ivars.blockInMissionSubsistenceIvars,
  }
}

this.appearanceMenu={
  options={
    Ivars.playerType,
    Ivars.playerPartsType,
    Ivars.playerCammoTypes,
    Ivars.playerFaceEquipIdApearance,--DEBUG wut -v-
    Ivars.playerFaceIdApearance,--DEBUG are these again, lol -^-
    Ivars.playerHeadgear,
    InfMenuCommands.printCurrentAppearance,
  }
}

this.playerRestrictionsInMissionMenu={
  options={
    Ivars.disableHeadMarkers,
    --Ivars.disableXrayMarkers,--tex doesn't seem to work realtime
    Ivars.disableWorldMarkers,
  },
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=Ivars.DisableOnSubsistence,
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
    Ivars.soldierAlertOnHeavyVehicleDamage,--tex this and
    Ivars.printPhaseChanges,--tex this don't rely on phaseUpdate
  },
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=Ivars.DisableOnSubsistence,
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
    Ivars.startOnFoot,
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
    Ivars.vehiclePatrolProfile,
    Ivars.vehiclePatrolLvEnable,
    Ivars.vehiclePatrolTruckEnable,
    Ivars.vehiclePatrolWavEnable,
    Ivars.vehiclePatrolWavHeavyEnable,
    Ivars.vehiclePatrolTankEnable,
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
  }
}

this.heliSpaceMenu={
  noResetItem=true,
  noGoBackItem=true,
  options={
    Ivars.fobMode,--DEBUGNOW
   -- this.ospMenu,--DEBUG
    --InfMenuCommands.DEBUG_SomeShiz,--DEBUG
--    this.fovaModMenu,--DEBUG
--    this.appearanceMenu,--DEBUG
--    InfMenuCommands.DEBUG_FovaTest,--DEBUG
    --InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
    --Ivars.vehiclePatrolPaintType,
    --Ivars.vehiclePatrolClass,
    --Ivars.vehiclePatrolEmblemType,
    --Ivars.forceSoldierSubType,--tex WIP DEBUG
    --Ivars.manualMissionCode,--tex  WIP
    --InfMenuCommands.loadMission,--tex  WIP
    Ivars.clockTimeScale,
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
    this.supportHeliMenu,
    --this.missionEntryExitMenu,
    --this.appearanceMenu,--tex  WIP
    this.patchupMenu,
    --InfMenuCommands.resetSettingsItem,
    InfMenuCommands.resetAllSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

this.debugInMissionMenu={
  options={
    --InfMenuCommands.DEBUG_RandomizeCp,
    --InfMenuCommands.DEBUG_PrintRealizedCount,
    --InfMenuCommands.DEBUG_PrintEnemyFova,
    Ivars.selectedCp,
    InfMenuCommands.DEBUG_PrintCpPowerSettings,
    InfMenuCommands.DEBUG_PrintPowersCount,
    --InfMenuCommands.DEBUG_PrintCpSizes,
    --InfMenuCommands.warpPlayerCommand,
    InfMenuCommands.DEBUG_PrintReinforceVars,
    --InfMenuCommands.DEBUG_PrintVehicleTypes,
    --InfMenuCommands.DEBUG_PrintVehiclePaint,
    InfMenuCommands.DEBUG_PrintSoldierDefine,
    --InfMenuCommands.DEBUG_PrintSoldierIDList,
    InfMenuCommands.DEBUG_ShowRevengeConfig,
    --InfMenuCommands.DEBUG_ShowPhaseEnums,--CULL
    --InfMenuCommands.DEBUG_ChangePhase,
    --InfMenuCommands.DEBUG_KeepPhaseOn,
    --InfMenuCommands.DEBUG_KeepPhaseOff,
    --InfMenuCommands.printPlayerPhase,
    --InfMenuCommands.DEBUG_SetPlayerPhaseToIvar,
    --InfMenuCommands.DEBUG_PrintVarsClock,
    --InfMenuCommands.showMissionCode,
    --InfMenuCommands.showMbEquipGrade,
    InfMenuCommands.showPosition,
  --InfMenuCommands.DEBUG_ClearAnnounceLog,
  }
}

this.inMissionMenu={
  noResetItem=true,--tex KLUDGE, to keep menuoffitem order
  noGoBack=true,--tex is root
  options={
--    this.fovaModMenu,--DEBUG
--    InfMenuCommands.DEBUG_FovaTest,--DEBUG
--    this.appearanceMenu,--DEBUG
    InfMenuCommands.DEBUG_SomeShiz,--DEBUGNOW
    InfMenuCommands.DEBUG_SomeShiz2,--DEBUGNOW
    InfMenuCommands.DEBUG_SomeShiz3,--DEBUGNOW
  --  InfMenuCommands.DEBUG_WarpToObject,--DEBUG
    --InfMenuCommands.showPosition,--DEBUG
    --InfMenuCommands.DEBUG_PrintSoldierDefine,--DEBUG
    --    Ivars.selectedChangeWeapon,--WIP DEBUG
 --   InfMenuCommands.DEBUG_WarpToReinforceVehicle,--DEBUG
    --InfMenuCommands.doEnemyReinforce,--WIP
    Ivars.warpPlayerUpdate,
    this.cameraMenu,
    this.userMarkerMenu,
    Ivars.clockTimeScale,
    --this.appearanceMenu,--WIP
    Ivars.quietRadioMode,
    this.playerRestrictionsInMissionMenu,
    this.phaseMenu,
    --this.enemyReinforceMenu,
    this.supportHeliMenu,
    this.debugInMissionMenu,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

this.inFOBMenu={--DEBUGNOW
  noResetItem=true,--tex KLUDGE, to keep menuoffitem order
  noGoBack=true,--tex is root
  options={
    InfMenuCommands.DEBUG_SomeFOBShiz,--DEBUGNOW
    InfMenuCommands.DEBUG_SomeFOBShiz2,--DEBUGNOW
    InfMenuCommands.DEBUG_showSyncSVars,--DEBUGNOW
  },
}

--TABLESETUP: MenuDefs
local IsTable=Tpp.IsTypeTable
for name,item in pairs(this) do
  if IsTable(item) then
    if item.options then
      item.name=name
      item.disabled=false
      item.parent=nil
      if item.noResetItem~=true then
        table.insert(item.options,InfMenuCommands.resetSettingsItem)
      end
      if item.noGoBackItem~=true then
        table.insert(item.options,InfMenuCommands.goBackItem)
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
