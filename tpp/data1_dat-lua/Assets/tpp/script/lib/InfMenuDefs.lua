-- DOBUILD: 1
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
    TppUiCommand.AnnounceLogView("MissionCode: "..vars.missionCode)--DEBUGNOW: ADDLANG
  end,
}

this.showMbEquipGradeItem={
  range=this.switchRange,
  settingNames="set_do",
  OnChange=function()
    local soldierGrade = TppMotherBaseManagement.GetMbsClusterSecuritySoldierEquipGrade{}
    local infGrade = InfMain.GetMbsClusterSecuritySoldierEquipGrade()
    TppUiCommand.AnnounceLogView("Security Grade: "..soldierGrade)--DEBUGNOW: ADDLANG
    TppUiCommand.AnnounceLogView("Inf Grade: "..soldierGrade)--DEBUGNOW: ADDLANG
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

this.returnQuietItem={
  range=this.switchRange,
  settingNames="set_quiet_return",
  OnChange=function()
    if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
      InfMenu.PrintLangId"quiet_already_returned"--"Quiet has already returned."
    else
      InfPatch.QuietReturn()
    end
  end,
}

this.resetRevenge={--DEBUGNOW: ADDLANG
  range=this.switchRange,
  settingNames="set_do",--DEBUGNOW: ADDLANG
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
this.motherBaseMenu={
  options={
    Ivars.mbSoldierEquipGrade,
    Ivars.mbSoldierEquipRange,
    Ivars.mbDDSuit,
    --Ivars.mbDDBalaclava,
    Ivars.mbWarGames,
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
    this.returnQuietItem,
    Ivars.langOverride,
    this.showLangCodeItem,
    this.showPositionItem,
    this.showMissionCodeItem,
    this.showMbEquipGradeItem,
    --Ivars.startOffline,
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

this.inMissionMenu={
  options={
    Ivars.clockTimeScale,
    this.showPositionItem,
    this.showMissionCodeItem,
    this.showMbEquipGradeItem,
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

--[[CULL this.allMenus={--SYNC: used for resetall TODO: just iterate this for all istable and .options
  this.heliSpaceMenu,
  this.parametersMenu,
  this.motherBaseMenu,
  this.demosMenu,
  this.patchupMenu,
  this.inMissionMenu,
  this.playerRestrictionsMenu,
  this.handLevelMenu,
  this.fultonLevelMenu,
  this.ospMenu
}--]]
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