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
    Ivars.mbSoldierEquipGrade_MIN,
    Ivars.mbSoldierEquipGrade_MAX,
    Ivars.allowUndevelopedDDEquip,
    Ivars.mbDDEquipNonLethal,
    Ivars.mbSoldierEquipRange,
  }
}

this.motherBaseMenu={
  options={
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
    InfMenuCommands.DEBUG_PrintSaveVarCount,
    InfMenuCommands.showMissionCode,
    InfMenuCommands.showLangCode,
  }
}

this.ospMenu={
  noResetItem=true,
  options={
    Ivars.clearItems,
    Ivars.clearSupportItems,
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



this.revengeSystemMenu={
  options={
    Ivars.revengeProfile,
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
    Ivars.changeCpSubTypeForMISSION,
    Ivars.enableWildCardFreeRoam,
    Ivars.enableInfInterrogation,
  }
}
--

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
    Ivars.soldierAlertOnHeavyVehicleDamage,--tex these>
    --Ivars.cpAlertOnVehicleFulton,--WIP, NOTE: ivar save is disabled
    Ivars.printPhaseChanges,--<don't rely on phaseUpdate
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

this.playerRestrictionsMenu={
  options={
    Ivars.subsistenceProfile,    
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
    --WIP OFF Ivars.disableHerbSearch,
    this.markersMenu,
    this.missionPrepRestrictionsMenu,
    this.disableSupportMenuMenu,
    this.handLevelMenu,
    this.fultonLevelMenu,
    this.fultonSuccessMenu,
    this.ospMenu,
  }
}

this.heliSpaceMenu={
  noResetItem=true,
  noGoBackItem=true,
  options={
    --    InfMenuCommands.DEBUG_PrintRevengePoints,--DEBUG
    --    --    InfMenuCommands.DEBUG_PrintMenu,
    --    InfMenuCommands.DEBUG_SomeShiz,--DEBUGNOW
--        InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
--        InfMenuCommands.DEBUG_SomeShiz3,--DEBUG
    --    InfMenuCommands.DEBUG_FovaTest,--DEBUG
    --    this.fovaModMenu,--DEBUG
    --    this.appearanceMenu,--DEBUG
    --Ivars.vehiclePatrolPaintType,
    --Ivars.vehiclePatrolClass,
    --Ivars.vehiclePatrolEmblemType,
    --Ivars.forceSoldierSubType,--tex WIP DEBUG
    --Ivars.manualMissionCode,--tex  WIP
    --InfMenuCommands.loadMission,--tex  WIP
    InfMenuCommands.forceGameEvent,--DEBUGNOW
    Ivars.gameEventChance,--DEBUGNOW
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
    this.debugMenu,
    InfMenuCommands.resetAllSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

this.debugInMissionMenu={
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
  noGoBackItem=true,--tex is root
  options={
    --    InfMenuCommands.DEBUG_WarpToObject,--DEBUG
    ----    Ivars.playerFaceIdApearance,--DEBUG
    ----    --    InfMenuCommands.DEBUG_FovaTest,--DEBUG
    ----    --    this.appearanceMenu,--DEBUG
--        InfMenuCommands.DEBUG_SomeShiz,--DEBUG
--        InfMenuCommands.DEBUG_SomeShiz2,--DEBUG
--        InfMenuCommands.DEBUG_SomeShiz3,--DEBUG
    --    Ivars.selectedChangeWeapon,--WIP DEBUG
    --   InfMenuCommands.DEBUG_WarpToReinforceVehicle,--DEBUG
    --InfMenuCommands.doEnemyReinforce,--WIP
    Ivars.warpPlayerUpdate,
    this.cameraMenu,
    this.userMarkerMenu,
    Ivars.clockTimeScale,
    Ivars.quietRadioMode,
    this.playerRestrictionsInMissionMenu,
    this.phaseMenu,
    this.supportHeliMenu,
    this.debugInMissionMenu,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.menuOffItem,
  }
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
