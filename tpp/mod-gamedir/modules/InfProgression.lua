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
--tex Cribbed from TppTerminal.AcquireDlcItemKeyItem
local MBMConst=TppMotherBaseManagementConst
this.dlcItemKeyItemList={
  WEAPON_MACHT_P5_WEISS=MBMConst.EXTRA_4000,
  WEAPON_RASP_SB_SG_GOLD=MBMConst.EXTRA_4001,
  WEAPON_PB_SHIELD_SIL=MBMConst.EXTRA_4002,
  WEAPON_PB_SHIELD_OD=MBMConst.EXTRA_4003,
  WEAPON_PB_SHIELD_WHT=MBMConst.EXTRA_4004,
  WEAPON_PB_SHIELD_GLD=MBMConst.EXTRA_4005,
  ITEM_CBOX_APD=MBMConst.EXTRA_4006,
  ITEM_CBOX_RT=MBMConst.EXTRA_4007,
  ITEM_CBOX_WET=MBMConst.EXTRA_4008,
  SUIT_FATIGUES_APD=MBMConst.EXTRA_4015,
  SUIT_FATIGUES_GRAY_URBAN=MBMConst.EXTRA_4016,
  SUIT_FATIGUES_BLUE_URBAN=MBMConst.EXTRA_4017,
  SUIT_FATIGUES_BLACK_OCELOT=MBMConst.EXTRA_4018,
  WEAPON_ADAM_SKA_SP=MBMConst.EXTRA_4024,
  WEAPON_WU_S333_CB_SP=MBMConst.EXTRA_4025,
  SUIT_MGS3_NORMAL=MBMConst.EXTRA_4019,
  SUIT_MGS3_SNEAK=MBMConst.EXTRA_4022,
  SUIT_MGS3_TUXEDO=MBMConst.EXTRA_4023,
  SUIT_THE_BOSS=MBMConst.EXTRA_4026,
  SUIT_EVA=MBMConst.EXTRA_4027,
  HORSE_WESTERN=MBMConst.EXTRA_4028,
  HORSE_PARADE=MBMConst.EXTRA_4009,
  ARM_GOLD=MBMConst.EXTRA_6000,--RETAILPATCH 1.10 added
 }--dlcItemKeyItemList
function this.UnlockDLC()
  local function AddDlcItem(dlcId,dlcType)
    local dataBaseId=this.dlcItemKeyItemList[dlcType]
    TppMotherBaseManagement.DirectAddDataBase{dataBaseId=dataBaseId,isNew=true}
    return true
  end
--  local function RemoveDlcItem(dlcId,dlcType)--RETAILPATCH: 1060
--    local platform=Fox.GetPlatformName()
--    local dataBaseId=this.dlcItemKeyItemList[dlcType]
--    if platform=="Xbox360"or platform=="XboxOne"then
--      if((dataBaseId==NULL_ID.EXTRA_4025)or(dataBaseId==NULL_ID.EXTRA_4003))or(dataBaseId==NULL_ID.EXTRA_4008)then
--        return false
--      end
--    end
--    TppMotherBaseManagement.DirectRemoveDataBase{dataBaseId=dataBaseId}
--    return true
--  end--
  for dlcType,databaseId in pairs(this.dlcItemKeyItemList)do
    local dlcItem=DlcItem[dlcType]
    --InfCore.Log("AcquireDlcItemKeyItem dlcType:"..tostring(dlcType).." databaseId:"..tostring(databaseId).." dlcId:"..tostring(databaseId))--dlcId == databaseId
    if dlcItem then
      --tex OFF this.EraseDlcItem(dlcItem,RemoveDlcItem,dlcType)--RETAILPATCH: 1.0.4.1
      this.AcquireDlcItem(dlcItem,AddDlcItem,dlcType)
    end
  end
end--UnlockDLC
--tex Cribbed from TppTerminal
--param==emblemType or dlcType
function this.AcquireDlcItem(databaseId,FuncOnAquire,param)
--OFF
--  if not TppUiCommand.CheckDlcFlag(databaseId)then
--    return
--  end
  if TppUiCommand.CheckDlcAcquiredFlag(databaseId)then
    return
  end
  if not Tpp.IsTypeFunc(FuncOnAquire)then
    return
  end
  local aquired=FuncOnAquire(databaseId,param)
  if aquired then
    TppUiCommand.SetDlcAcquired(databaseId)
  end
end--AcquireDlcItem

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
    "InfProgression.UnlockWeaponCustomization",
    "InfProgression.UnlockDLC",--DEBUGNOW lang
    "InfProgression.ResetPaz",--tex also in motherBaseShowCharactersMenu
    "InfProgression.ReturnQuiet",--tex also in motherBaseShowCharactersMenu
    "InfProgression.ShowQuietReunionMissionCount",
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