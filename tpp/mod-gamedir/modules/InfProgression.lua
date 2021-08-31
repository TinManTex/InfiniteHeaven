--InfProgression.lua
--tex options and commands for managing games progression
local this={}

this.registerIvars={
  "repopulateRadioTapes",
  "mbCollectionRepop",
  "mbForceBattleGearDevelopLevel",
}

this.repopulateRadioTapes={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
this.mbCollectionRepop={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
this.mbForceBattleGearDevelopLevel={
  save=IvarProc.CATEGORY_EXTERNAL,
  range={max=5,min=0,increment=1},
}

this.UnlockPlayableAvatar=function()
  if vars.isAvatarPlayerEnable==1 then
    InfMenu.PrintLangId"allready_unlocked"
  else
    vars.isAvatarPlayerEnable=1
  end
end
this.UnlockWeaponCustomization=function()
  if vars.mbmMasterGunsmithSkill==1 then
    InfMenu.PrintLangId"allready_unlocked"
  else
    vars.mbmMasterGunsmithSkill=1
  end
end
this.ResetPaz=function()
  gvars.pazLookedPictureCount=0
  gvars.pazEventPhase=0

  local demoNames = {
    "PazPhantomPain1",
    "PazPhantomPain2",
    "PazPhantomPain3",
    "PazPhantomPain4",
    "PazPhantomPain4_jp",
  }
  for i,demoName in ipairs(demoNames)do
    TppDemo.ClearPlayedMBEventDemoFlag(demoName)
  end
  InfMenu.PrintLangId"paz_reset"
end
this.ReturnQuiet=function()
  if not TppBuddyService.CheckBuddyCommonFlag(BuddyCommonFlag.BUDDY_QUIET_LOST)then
    InfMenu.PrintLangId"quiet_already_returned"--"Quiet has already returned."
  else
    InfMenu.PrintLangId"quiet_return"
    --InfPatch.QuietReturn()
    TppStory.RequestReunionQuiet()
  end
end
this.ShowQuietReunionMissionCount=function()
  TppUiCommand.AnnounceLogView("quietReunionMissionCount: "..gvars.str_quietReunionMissionCount)
end

this.registerMenus={
  "progressionMenu",
}
this.progressionMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "InfResources.resourceScaleMenu",
    "Ivars.repopulateRadioTapes",
    "Ivars.mbCollectionRepop",--tex also in motherBaseMenu
    "Ivars.mbForceBattleGearDevelopLevel",--tex also in motherBaseShowAssetsMenu
    "InfProgression.UnlockPlayableAvatar",
    "InfMenuCommandsTpp.UnlockWeaponCustomization",
    "InfMenuCommandsTpp.ResetPaz",--tex also in motherBaseShowCharactersMenu
    "InfMenuCommandsTpp.ReturnQuiet",--tex also in motherBaseShowCharactersMenu
    "InfMenuCommandsTpp.ShowQuietReunionMissionCount",
  --"InfQuest.ForceAllQuestOpenFlagFalse",
  }
}--progressionMenu

this.langStrings={
  eng={
    progressionMenu="Progression menu",
    repopulateRadioTapes="Repopulate music tape radios",
    mbCollectionRepop="Repopulate plants and diamonds",
    mbForceBattleGearDevelopLevel="Force BattleGear built level",
    resetPaz="Reset Paz state to beginning",
    paz_reset="Paz reset",
    unlockPlayableAvatar="Unlock playable avatar",
    returnQuiet="Return Quiet after mission 45",
    quiet_already_returned="Quiet has already returned.",
    quiet_return="Quiet has returned.",
  },--eng
  help={
    eng={
      mbCollectionRepop="Regenerates plants on Zoo platform and diamonds on Mother base over time.",
      mbForceBattleGearDevelopLevel="Changes the build state of BattleGear in it's hangar, 0 is use the regular story progression.",
      unlockPlayableAvatar="Unlock avatar before mission 46",
      unlockWeaponCustomization="Unlock without having to complete legendary gunsmith missions",
      returnQuiet="Instantly return Quiet, runs same code as the Reunion mission 11 replay.",
    },--eng
  },--help
}--langStrings

return this