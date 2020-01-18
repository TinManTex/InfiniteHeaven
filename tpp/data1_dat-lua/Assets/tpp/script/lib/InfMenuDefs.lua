-- DOBUILD: 1 --
--MOVE? this is data not lib
local this={}
--menus
this.parametersMenu={
  options={
    Ivars.enemyParameters,
    Ivars.enemyHealthMult,
    --Ivars.playerHealthMult,
    --Ivars.ogrePointChange,
    InfMenuCommands.giveOgrePoint,
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
    Ivars.mbDontDemoDisableOcelot,
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
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}

this.patchupMenu={
  options={
    Ivars.unlockPlayableAvatar,
    Ivars.startOffline,    
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

--[[this.appearanceMenu={--OFF have to comment out even if not referenced since resetall iterates the whole module
  options={
    Ivars.playerPartsTypeApearance,
    Ivars.playerFaceEquipIdApearance,
    Ivars.playerTypeApearance,
    Ivars.cammoTypesApearance,
    Ivars.playerFaceIdApearance,
    Ivars.playerBalaclava,    
    this.printCurrentAppearanceItem,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.goBackItem,
  }
}--]]



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
  OnSelect=function(self)
    if not (Ivars.subsistenceProfile:Is("DEFAULT") or Ivars.subsistenceProfile:Is("CUSTOM")) then
      InfMenu.PrintLangId("phase_menu_cannot_subsistence")
      self.disabled=true
    else
      self.disabled=false
    end
  end,
}

this.heliSpaceMenu={
  options={
    --Ivars.forceSoldierSubType,--tex WIP DEBUGNOW
    Ivars.startOnFoot,
    Ivars.clockTimeScale,
    this.playerRestrictionsMenu,
    this.parametersMenu,
    this.phaseMenu,
    this.revengeMenu,
    this.sideOpsMenu,
    this.motherBaseMenu,
    this.demosMenu,
    --this.appearanceMenu,
    this.patchupMenu,
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.resetAllSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

this.debugInMissionMenu={
  options={
    InfMenuCommands.DEBUG_ShowRevengeConfigItem,
    --this.DEBUG_ShowPhaseEnums,
    --this.DEBUG_ChangePhaseItem,
    --this.DEBUG_KeepPhaseOnItem,
    --this.DEBUG_KeepPhaseOffItem,
    --this.printPlayerPhase,
    --this.DEBUG_SetPlayerPhaseToIvar,
    --this.DEBUG_ClearAnnounceLogItem,
    this.showMissionCodeItem,
    this.showMbEquipGradeItem,
    this.showPositionItem,  
    InfMenuCommands.goBackItem,
  }
}

this.inMissionMenu={
  options={
    Ivars.clockTimeScale,
    this.phaseMenu,
    --this.appearanceMenu,
    this.debugInMissionMenu,    
    InfMenuCommands.resetSettingsItem,
    InfMenuCommands.menuOffItem,
  }
}

--TABLESETUP: MenuDefs
local IsTable=Tpp.IsTypeTable
for name,item in pairs(this) do
  if IsTable(item) then   
    if item.range or item.settings or item.options then
      item.name=name
      item.default=item.default or 0
      if item.options then
        item.disabled=false
        item.parent=nil
      end
    end
  end
end

this.allMenus={}
--TABLESETUP: allMenus, for reset, also means you have to comment out whole menu, not just references from other menus since resetall iterates the whole module
local i=1
for n,menu in pairs(this) do
  if menu.options then--tex is menu
    this.allMenus[n]=menu
    i=i+1
  end
end

return this