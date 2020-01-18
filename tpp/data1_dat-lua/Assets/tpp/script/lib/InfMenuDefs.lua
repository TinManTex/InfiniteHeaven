-- DOBUILD: 1 --
--MOVE? this is data not lib
local this={}
--menus
this.playerSettingsMenu={
  options={
    Ivars.playerHealthScale,
    --Ivars.ogrePointChange,
    --InfMenuCommands.giveOgrePoint,
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
    InfMenuCommands.printHealthTableParameterItem,
    InfMenuCommands.printSightFormParameterItem,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

--[[ 
local sightDistScaleName=Ivars.sightDistScaleName
local i=1
for n,listName in ipairs(Ivars.sightIvarLists) do
  for m,name in ipairs(Ivars[listName]) do
    local ivarName=name..sightDistScaleName
    this.soldierParamsMenu.options[i]=Ivars[ivarName]
    i=i+1
  end
end
--]]

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
    --Ivars.mbShowQuietCellSigns,
    Ivars.mbShowMbEliminationMonument,
    Ivars.mbShowSahelan,
    Ivars.mbShowEli,
    Ivars.mbShowCodeTalker,
    Ivars.mbUnlockGoalDoors,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.motherBaseMenu={
  options={
    Ivars.mbSoldierEquipGrade,
    Ivars.mbSoldierEquipRange,
    Ivars.mbDDSuit,
    --Ivars.mbDDBalaclava,
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
    Ivars.mbDontDemoDisableOcelot,
    --Ivars.mbDontDemoDisableBuddy,--WIP
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

--[[this.missionEntryExitMenu={
    Ivars.telopMode,
    Ivars.startOnFoot,
    Ivars.abortMenuItemControl,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
}--]]

this.patchupMenu={
  options={
    Ivars.telopMode,
    InfMenuCommands.unlockPlayableAvatarItem,
    InfMenuCommands.unlockWeaponCustomizationItem,
    Ivars.startOffline,   
    --Ivars.blockFobTutorial,
    --Ivars.setFirstFobBuilt,
    Ivars.langOverride,
    InfMenuCommands.returnQuietItem,
    InfMenuCommands.showQuietReunionMissionCountItem,
    InfMenuCommands.showLangCodeItem,
    InfMenuCommands.showPositionItem,
    InfMenuCommands.showMissionCodeItem,
    InfMenuCommands.showMbEquipGradeItem,
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

this.revengeMenu={
  options={
    InfMenuCommands.resetRevenge,
    Ivars.revengeMode,
    Ivars.revengeBlockForMissionCount,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

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
    this.handLevelMenu,
    this.fultonLevelMenu,
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
    this.printCurrentAppearanceItem,
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
    --InfMenuCommands.pullOutHeliItem,
    --InfMenuCommands.changeToIdleStateHeliItem,
    Ivars.disableHeliAttack,
    Ivars.setInvincibleHeli,
    Ivars.setSearchLightForcedHeli,
    Ivars.disablePullOutHeli,
    Ivars.setLandingZoneWaitHeightTop,
    Ivars.defaultHeliDoorOpenTime,
    Ivars.startOnFoot,
    --Ivars.disableDescentToLandingZone,
    --Ivars.enableGetOutHeli,--WIP
    --Ivars.heliUpdate,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  },
}

this.enemyReinforceMenu={
  options={
    Ivars.forceSuperReinforce,
    Ivars.enableHeliReinforce,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  },  
}

this.heliSpaceMenu={
  options={
    --Ivars.forceSoldierSubType,--tex WIP 
    --Ivars.manualMissionCode,--tex  WIP
    --InfMenuCommands.loadMissionItem,--tex  WIP
    Ivars.clockTimeScale,
    this.playerRestrictionsMenu,
    this.playerSettingsMenu,
    this.soldierParamsMenu,
    this.phaseMenu,
    this.revengeMenu,
    this.enemyReinforceMenu,
    this.sideOpsMenu,
    this.motherBaseMenu,
    this.demosMenu,
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
    --InfMenuCommands.warpPlayerCommand,

    InfMenuCommands.DEBUG_PrintReinforceVarsItem,
    InfMenuCommands.DEBUG_PrintSoldierDefineItem,
    InfMenuCommands.DEBUG_PrintSoldierIDListItem,
    InfMenuCommands.DEBUG_ShowRevengeConfigItem,
    --InfMenuCommands.DEBUG_ShowPhaseEnums,--CULL
    --InfMenuCommands.DEBUG_ChangePhaseItem,
    --InfMenuCommands.DEBUG_KeepPhaseOnItem,
    --InfMenuCommands.DEBUG_KeepPhaseOffItem,
    --InfMenuCommands.printPlayerPhase,
    --InfMenuCommands.DEBUG_SetPlayerPhaseToIvar,
    InfMenuCommands.showMissionCodeItem,
    InfMenuCommands.showMbEquipGradeItem,
    InfMenuCommands.showPositionItem,    
    InfMenuCommands.DEBUG_ClearAnnounceLogItem,  
    InfMenuCommands.goBackItem,
  }
}

this.inMissionMenu={
  options={
    --InfMenuCommands.DEBUG_WarpToReinforceVehicle,--DEBUGNOW
    --InfMenuCommands.doEnemyReinforce,--WIP
    Ivars.warpPlayerUpdate,
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
for n,menu in pairs(this) do
  if IsTable(item) then   
    if menu.options then--tex is menu
      this.allMenus[n]=menu
      i=i+1
    end
  end
end

return this