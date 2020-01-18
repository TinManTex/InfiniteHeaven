-- DOBUILD: 1 --
--MOVE? this is data not lib
local this={}

this.switchRange={max=1,min=0,increment=1}

--menu menu items
this.menuOffItem={
  range=this.switchRange,
  settingNames="set_menu_off",
  OnChange=function()
    InfMenu.MenuOff()
    InfMenu.currentIndex=1
  end,
}
this.resetSettingsItem={
  range=this.switchRange,
  settingNames="set_menu_reset",
  OnChange=function()
    InfMenu.ResetSettingsDisplay()
    InfMenu.MenuOff()
  end,
}
this.resetAllSettingsItem={
  range=this.switchRange,
  settingNames="set_menu_reset",
  OnChange=function()
    InfMenu.PrintLangId"setting_all_defaults"
    InfMenu.ResetSettings()
    InfMenu.MenuOff()
  end,
}
this.goBackItem={
  range=this.switchRange,
  settingNames="set_goBackItem",
  OnChange=function()
    InfMenu.GoBackCurrent()
  end,
}

--menu items
this.showPositionItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiCommand.AnnounceLogView(string.format("%.2f,%.2f,%.2f | %.2f",vars.playerPosX,vars.playerPosY,vars.playerPosZ,vars.playerRotY))
  end,
}

this.showMissionCodeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiCommand.AnnounceLogView("MissionCode: "..vars.missionCode)--ADDLANG
  end,
}

this.showMbEquipGradeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    local soldierGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local infGrade = InfMain.GetMbsClusterSecuritySoldierEquipGrade()
    TppUiCommand.AnnounceLogView("Security Grade: "..soldierGrade)--ADDLANG
    TppUiCommand.AnnounceLogView("Inf Grade: "..soldierGrade)--ADDLANG
  end,
}

this.showLangCodeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    local languageCode=AssetConfiguration.GetDefaultCategory"Language"
    TppUiCommand.AnnounceLogView(InfMenu.LangString"language_code"..": "..languageCode)
  end,
}

this.showQuietReunionMissionCountItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    TppUiCommand.AnnounceLogView("quietReunionMissionCount: "..gvars.str_quietReunionMissionCount)
  end,
}

this.DEBUG_ShowRevengeConfigItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("RevRandomValue): "..gvars.rev_revengeRandomValue)
    InfMenu.DebugPrint("RevengeType:")
    local revengeType=InfInspect.Inspect(mvars.revenge_revengeType)
    InfMenu.DebugPrint(revengeType)  
  
    InfMenu.DebugPrint("RevengeConfig:")
    local revengeConfig=InfInspect.Inspect(mvars.revenge_revengeConfig)
    InfMenu.DebugPrint(revengeConfig)
  end,
}

this.DEBUG_Item2={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    InfMenu.DebugPrint("EnemyTypes:")
    InfMenu.DebugPrint("TYPE_DD:"..EnemyType.TYPE_DD)
    InfMenu.DebugPrint("TYPE_SKULL:"..EnemyType.TYPE_SKULL )
    InfMenu.DebugPrint("TYPE_SOVIET:"..EnemyType.TYPE_SOVIET)
    InfMenu.DebugPrint("TYPE_PF:"..EnemyType.TYPE_PF )
    InfMenu.DebugPrint("TYPE_CHILD:".. EnemyType.TYPE_CHILD )
    --InfMenu.DebugPrint("bef")
   -- local strout=InfInspect.Inspect(gvars.soldierTypeForced)
   -- InfMenu.DebugPrint(strout)
   -- InfMenu.DebugPrint("aft")
  end,
}


this.returnQuietItem={
  range=this.switchRange,
  settingNames="set_quiet_return",
  OnChange=function()
    if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
      InfMenu.PrintLangId"quiet_already_returned"--"Quiet has already returned."
    else
      --InfPatch.QuietReturn()
      TppStory.RequestReunionQuiet()
    end
  end,
}

this.resetRevenge={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    Ivars.revengeMode:Set(0)
    TppRevenge.ResetRevenge()
    TppRevenge._SetUiParameters()
    InfMenu.PrintLangId("revenge_reset")
  end,
}

--menus
this.parametersMenu={
  options={
    Ivars.enemyParameters,
    Ivars.enemyHealthMult,
    Ivars.playerHealthMult,
    this.resetSettingsItem,
    this.goBackItem,
  }
}
this.sideOpsMenu={
  options={
    Ivars.unlockSideOps,
    Ivars.unlockSideOpNumber,
    this.resetSettingsItem,
    this.goBackItem,
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
    this.resetSettingsItem,
    this.goBackItem,
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
    this.resetSettingsItem,
    this.goBackItem,
  }
}

this.demosMenu={
  options={
    Ivars.useSoldierForDemos,
    Ivars.mbDemoSelection,
    Ivars.mbSelectedDemo,
    this.resetSettingsItem,
    this.goBackItem,
  }
}

this.patchupMenu={
  options={
    Ivars.unlockPlayableAvatar,
    Ivars.startOffline,    
    Ivars.langOverride,
    this.returnQuietItem,
    this.showQuietReunionMissionCountItem,
    this.showLangCodeItem,
    this.showPositionItem,
    this.showMissionCodeItem,
    this.showMbEquipGradeItem,
    this.resetSettingsItem,
    this.goBackItem,
  }
}

this.ospMenu={
  options={
    Ivars.ospWeaponProfile,
    Ivars.primaryWeaponOsp,
    Ivars.secondaryWeaponOsp,
    Ivars.tertiaryWeaponOsp,--tex user can set in UI, but still have it for setting the profile changes, and also if they want to set it while they're doing the other settings    
    this.goBackItem,
  }
}

this.handLevelMenu={
  options={
    Ivars.handLevelProfile,
    Ivars.handLevelSonar,
    Ivars.handLevelPhysical,
    Ivars.handLevelPrecision,
    Ivars.handLevelMedical,
    this.goBackItem,
  }
}

this.fultonLevelMenu={
  options={
    Ivars.fultonLevelProfile,    
    Ivars.itemLevelFulton,
    Ivars.itemLevelWormhole,
    this.goBackItem,
  }
}

this.disableMenuMenu={
  options={
    Ivars.disableMenuDrop,
    Ivars.disableMenuBuddy,
    Ivars.disableMenuAttack,
    Ivars.disableMenuHeliAttack,
    Ivars.disableSupportMenu,
    this.resetSettingsItem,
    this.goBackItem,
  }
}

this.revengeMenu={
  options={
    this.resetRevenge,
    Ivars.revengeMode,
    Ivars.revengeBlockForMissionCount,
    this.goBackItem,
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
    this.handLevelMenu,
    this.fultonLevelMenu,
    this.ospMenu,
    this.disableMenuMenu,
    this.resetSettingsItem,
    this.goBackItem,
  }
}

this.heliSpaceMenu={
  options={
    --Ivars.forceSoldierSubType,--tex WIP DEBUGNOW
    Ivars.startOnFoot,
    Ivars.clockTimeScale,
    this.playerRestrictionsMenu,
    this.parametersMenu,
    this.revengeMenu,
    this.sideOpsMenu,
    this.motherBaseMenu,
    this.demosMenu,
    this.patchupMenu,
    this.resetSettingsItem,
    this.resetAllSettingsItem,
    this.menuOffItem,
  }
}


this.debugInMissionMenu={
  options={
    this.DEBUG_ShowRevengeConfigItem,
    this.showMissionCodeItem,
    this.showMbEquipGradeItem,
    this.showPositionItem,   
    this.goBackItem,
  }
}

this.inMissionMenu={
  options={
    Ivars.clockTimeScale,
    this.debugInMissionMenu,    
    this.resetSettingsItem,
    this.menuOffItem,
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
        item.parent=nil
      end
    end
  end
end

this.allMenus={}
--TABLESETUP: allMenus
local i=1
for n,menu in pairs(this) do
  if menu.options then--tex is menu
    this.allMenus[n]=menu
    i=i+1
  end
end

return this