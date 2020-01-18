-- DOBUILD: 1 --
--MOVE? this is data not lib
local this={}
--menus
this.playerParamsMenu={
  options={
    Ivars.playerHealthMult,
    --Ivars.ogrePointChange,
    --InfMenuCommands.giveOgrePoint,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}
this.soldierParamsMenu={
  options={
    Ivars.enemyParameters,
    Ivars.enemyHealthMult,
    Ivars.discoveryDistScaleSightParam,
    Ivars.indisDistScaleSightParam,
    Ivars.dimDistScaleSightParam,
    Ivars.farDistScaleSightParam,
    Ivars.observeDistScaleSightParam,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}
this.sideOpsMenu={
  options={
    Ivars.unlockSideOps,
    Ivars.unlockSideOpNumber,
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

this.patchupMenu={
  options={
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
    Ivars.enablePhaseMod,
    Ivars.minPhase,
    Ivars.maxPhase,
    Ivars.keepPhase,
    Ivars.phaseUpdateRate,
    Ivars.phaseUpdateRange,
    Ivars.printPhaseChanges,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  },
  disabled=false,
  disabledReason="item_disabled_subsistence",
  OnSelect=Ivars.DisableOnSubsistence,
}

this.supportHeliMenu={
  options={
    Ivars.defaultHeliDoorOpenTime,
    Ivars.disableHeliAttack,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  },
}

this.heliSpaceMenu={
  options={
    --Ivars.warpPlayerMode,--tex WIP DEBUGNOW
    --Ivars.forceSoldierSubType,--tex WIP DEBUGNOW
    --Ivars.manualMissionCode,--tex DEBUGNOW WIP
    --InfMenuCommands.loadMissionItem,--tex DEBUGNOW WIP
    Ivars.startOnFoot,
    Ivars.clockTimeScale,
    Ivars.playerHeadgear,
    Ivars.telopMode,
    this.playerRestrictionsMenu,
    this.playerParamsMenu,
    this.soldierParamsMenu,
    this.phaseMenu,
    this.revengeMenu,
    this.sideOpsMenu,
    this.motherBaseMenu,
    this.demosMenu,
    this.supportHeliMenu,
    --this.appearanceMenu,--tex DEBUGNOW WIP
    this.patchupMenu,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.resetAllSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

this.debugInMissionMenu={
  options={
    --InfMenuCommands.warpPlayerCommand,--DEBUGNOW WIP
    --InfMenuCommands.DEBUG_PrintSoldierDefineItem,
    InfMenuCommands.DEBUG_ShowRevengeConfigItem,
    --InfMenuCommands.DEBUG_ShowPhaseEnums,--CULL
    --InfMenuCommands.DEBUG_ChangePhaseItem,
    --InfMenuCommands.DEBUG_KeepPhaseOnItem,
    --InfMenuCommands.DEBUG_KeepPhaseOffItem,
    --InfMenuCommands.printPlayerPhase,
    --InfMenuCommands.DEBUG_SetPlayerPhaseToIvar,
    --InfMenuCommands.DEBUG_ClearAnnounceLogItem,
    InfMenuCommands.showMissionCodeItem,
    InfMenuCommands.showMbEquipGradeItem,
    InfMenuCommands.showPositionItem,  
    InfMenuCommands.goBackItem,
  }
}

this.inMissionMenu={
  options={
    InfMenuCommands.HeliMenuOnTestItem,--WIP DEBUGNOW
    Ivars.warpPlayerMode,--tex WIP DEBUGNOW
    Ivars.clockTimeScale,
    --this.appearanceMenu,--WIP
    Ivars.quietRadioMode,
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