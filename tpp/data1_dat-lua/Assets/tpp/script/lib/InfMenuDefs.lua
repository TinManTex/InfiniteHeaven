-- DOBUILD: 1
local this={}
--menus
this.playerSettingsMenu={
  options={
    Ivars.playerHealthScale,
    InfMenuCommands.removeDemon,
    InfMenuCommands.setDemon,
    Ivars.useSoldierForDemos,
    Ivars.playerHeadgear,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}
this.soldierParamsMenu={
  options={
    Ivars.soldierParamsProfile,
    Ivars.soldierHealthScale,
    Ivars.soldierSightDistScale,
    InfMenuCommands.printHealthTableParameter,
    InfMenuCommands.printSightFormParameter,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.dDEquipMenu={
  options={    
    Ivars.enableMbDDEquip,
    Ivars.enableEnemyDDEquip,
    Ivars.mbSoldierEquipGrade_MIN,
    Ivars.mbSoldierEquipGrade_MAX,
    Ivars.allowUndevelopedDDEquip,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.motherBaseMenu={
  options={
    Ivars.revengeModeForMb,
    this.dDEquipMenu,
    Ivars.mbSoldierEquipRange,
    Ivars.mbDDSuit,
    Ivars.mbDDHeadGear,
    --Ivars.disableMotherbaseWeaponRestriction,--WIP
    Ivars.mbWarGames,
    Ivars.mbEnableBuddies,
    this.motherBaseShowAssetsMenu,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
    Ivars.mbDontDemoDisableOcelot,
    --Ivars.mbDontDemoDisableBuddy,--WIP
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.ospMenu={
  options={
    Ivars.ospWeaponProfile,
    Ivars.primaryWeaponOsp,
    Ivars.secondaryWeaponOsp,
    Ivars.tertiaryWeaponOsp,--tex user can set in UI, but still have it for setting the profile changes, and also if they want to set it while they're doing the other settings    
    InfMenuCommands.goBackItem,
  }
}

this.handLevelMenu={
  options={
    Ivars.handLevelProfile,
    Ivars.handLevelSonar,
    Ivars.handLevelPhysical,
    Ivars.handLevelPrecision,
    Ivars.handLevelMedical,
    InfMenuCommands.goBackItem,
  }
}

this.fultonLevelMenu={
  options={
    Ivars.fultonLevelProfile,    
    Ivars.itemLevelFulton,
    Ivars.itemLevelWormhole,
    InfMenuCommands.goBackItem,
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
  },
}

this.disableMenuMenu={
  options={
    Ivars.disableMenuDrop,
    Ivars.disableMenuBuddy,
    Ivars.disableMenuAttack,
    Ivars.disableMenuHeliAttack,
    Ivars.disableSupportMenu,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
  
  table.insert(menuOptions,InfMenuCommands.resetSettingsItem)
  table.insert(menuOptions,InfMenuCommands.goBackItem)
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
table.insert(menuOptions,InfMenuCommands.resetSettingsItem)
table.insert(menuOptions,InfMenuCommands.goBackItem)

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
table.insert(revengeMenu,InfMenuCommands.resetSettingsItem)
table.insert(revengeMenu,InfMenuCommands.goBackItem)

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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}
--

this.playerRestrictionsMenu={
  options={
    Ivars.subsistenceProfile,
    Ivars.disableHeadMarkers,
    Ivars.disableXrayMarkers,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.appearanceMenu={
  options={
    Ivars.playerPartsTypeApearance,
    Ivars.playerFaceEquipIdApearance,
    Ivars.playerTypeApearance,
    Ivars.cammoTypesApearance,
    Ivars.playerFaceIdApearance,
    Ivars.playerHeadgear,    
    this.printCurrentAppearance,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.playerRestrictionsInMissionMenu={
  options={
    Ivars.disableHeadMarkers,
    Ivars.disableXrayMarkers,  
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  },
}

this.enemyReinforceMenu={
  options={
    Ivars.forceSuperReinforce,
    Ivars.enableHeliReinforce,
    Ivars.forceReinforceRequest,
    Ivars.disableReinforceHeliPullOut,
    Ivars.enableSoldiersWithVehicleReinforce,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  },  
}

this.vehiclePatrolMenu={
  options={
    Ivars.vehiclePatrolProfile,
    Ivars.vehiclePatrolLvEnable,
    Ivars.vehiclePatrolTruckEnable,
    Ivars.vehiclePatrolWavEnable,
    Ivars.vehiclePatrolWavHeavyEnable,
    Ivars.vehiclePatrolTankEnable,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.cameraMenu={
  options={
    Ivars.adjustCameraUpdate,
    Ivars.cameraMode,
    Ivars.moveScale,
--    Ivars.focalLength,
--    Ivars.focusDistance,
--    Ivars.aperture,
    InfMenuCommands.resetCameraSettings,--tex just reset cam pos at the moment
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.heliSpaceMenu={
  options={
    --InfMenuCommands.DEBUG_SomeShiz,--DEBUGNOW
    --InfMenuCommands.DEBUG_PrintSaveVarCount,--DEBUG
    --InfMenuCommands.DEBUG_PrintNonDefaultVars,--DEBUG
    --Ivars.vehiclePatrolPaintType,
    --Ivars.vehiclePatrolClass,
    --Ivars.vehiclePatrolEmblemType,
    --Ivars.forceSoldierSubType,--tex WIP 
    --Ivars.manualMissionCode,--tex  WIP
    --InfMenuCommands.loadMission,--tex  WIP
    Ivars.clockTimeScale,
    this.playerRestrictionsMenu,
    this.playerSettingsMenu,
    this.soldierParamsMenu,
    this.phaseMenu,
    this.revengeMenu,
    this.enemyReinforceMenu,
    this.vehiclePatrolMenu,
    this.sideOpsMenu,
    this.motherBaseMenu,
    this.demosMenu,
    this.cameraMenu,
    this.supportHeliMenu,
    --this.missionEntryExitMenu,
    --this.appearanceMenu,--tex  WIP
    this.patchupMenu,
    InfMenuCommands.resetSettingsItem,
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
    --InfMenuCommands.DEBUG_PrintSoldierDefine,
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
    InfMenuCommands.goBackItem,
  }
}

this.inMissionMenu={
  options={
    --InfMenuCommands.DEBUG_SomeShiz,--DEBUGNOW
    --Ivars.selectedChangeWeapon,--WIP
    --InfMenuCommands.DEBUG_WarpToReinforceVehicle,
    --InfMenuCommands.doEnemyReinforce,--WIP
    Ivars.warpPlayerUpdate,
    this.cameraMenu,
    Ivars.clockTimeScale,
    --this.appearanceMenu,--WIP
    Ivars.quietRadioMode,
    this.phaseMenu,
    --this.enemyReinforceMenu,
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