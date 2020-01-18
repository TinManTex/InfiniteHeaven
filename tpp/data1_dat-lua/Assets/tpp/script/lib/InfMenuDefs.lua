-- DOBUILD: 1
--MOVE? this is data not lib
local this={}

this.switchRange={max=1,min=0,increment=1}

--menu menu items
this.menuOffItem={
  range=this.switchRange,
  settingNames="set_menu_off",
  onChange=function()
    InfMenu.MenuOff()
    InfMenu.currentOption=1
  end,
}
this.resetSettingsItem={
  range=this.switchRange,
  settingNames="set_menu_reset",
  onChange=function()
    InfMenu.ResetSettingsDisplay()
    InfMenu.MenuOff()
  end,
}
this.resetAllSettingsReallyItem={--DEBUG ADDLANG
  range=this.switchRange,
  settingNames="set_menu_reset",
  onChange=function()
    InfMenu.ResetSettings()
    InfMenu.MenuOff()
  end,
}
this.goBackItem={
  range=this.switchRange,
  settingNames="set_goBackItem",
  onChange=function()
    InfMenu.GoBackCurrent()
  end,
}

--menu items
this.showPositionItem={
  range=this.switchRange,
  settingNames="set_do",
  onChange=function()
    TppUiCommand.AnnounceLogView(string.format("%.2f,%.2f,%.2f | %.2f",vars.playerPosX,vars.playerPosY,vars.playerPosZ,vars.playerRotY))
  end,
}

this.showLangCodeItem={
  range=this.switchRange,
  settingNames="set_do",
  onChange=function()
    local languageCode=AssetConfiguration.GetDefaultCategory"Language"
    TppUiCommand.AnnounceLogView(InfMenu.LangString"language_code"..": "..languageCode)
  end,
}

this.returnQuietItem={
  range=this.switchRange,
  settingNames="set_quiet_return",
  onChange=function()
    if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
      InfMenu.AnnounceLogLangId"quiet_already_returned"--"Quiet has already returned."
    else
      InfPatch.QuietReturn()
    end
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
    --Ivars.startOffline,
    this.goBackItem,
  }
}

this.heliSpaceMenu={
  options={
    --this.resetAllSettingsReallyItem,--DEBUGNOW
    --Ivars.forceSoldierSubType,--tex WIP DEBUGNOW
    Ivars.subsistenceProfile,
    Ivars.ospWeaponLoadout,
    --Ivars.primaryWeaponOsp,
    --Ivars.secondaryWeaponOsp,
    --Ivars.tertiaryWeaponOsp,
    Ivars.revengeMode,
    Ivars.startOnFoot,
    Ivars.clockTimeScale,
    Ivars.unlockSideOps,
    Ivars.unlockSideOpNumber,
    this.parametersMenu,
    this.motherBaseMenu,
    this.demosMenu,
    this.patchupMenu,
    this.resetSettingsItem,
    this.menuOffItem,
  }
}

this.inMissionMenu={
  options={
    Ivars.clockTimeScale,
    this.showPositionItem,
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

this.allMenus={--SYNC: used for resetall
  this.heliSpaceMenu,
  this.parametersMenu,
  this.motherBaseMenu,
  this.demosMenu,
  this.patchupMenu,
  this.inMissionMenu,
}

return this