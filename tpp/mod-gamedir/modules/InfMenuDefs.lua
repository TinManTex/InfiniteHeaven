-- InfMenuDefs.lua
local this={}
--LOCALOPT
--tex NOTE its ok to reference modules that are reloaded before this is reloaded
local Ivars=Ivars
local InfMenuCommands=InfMenuCommands
local InfMenuDefs=this

--menus
this.fovaModMenu={
  options={
    "Ivars.enableFovaMod",
    "Ivars.fovaSelection",
    "InfMenuCommands.PrintBodyInfo",
  }
}

this.appearanceMenu={
  nonConfig=true,
  options={
    "Ivars.playerType",
    "Ivars.playerPartsType",
    "Ivars.playerCamoType",
    "Ivars.playerFaceEquipId",
    "Ivars.playerFaceFilter",
    "Ivars.playerFaceId",
    "InfMenuCommands.PrintFaceInfo",
    --OFF "Ivars.playerHeadgear",
    "InfMenuCommands.PrintCurrentAppearance",
    "InfMenuDefs.fovaModMenu",
  }
}

this.appearanceDebugMenu={
  nonConfig=true,
  options={
    "Ivars.faceFovaDirect",
    "Ivars.faceDecoFovaDirect",
    "Ivars.hairFovaDirect",
    "Ivars.hairDecoFovaDirect",
    "Ivars.playerTypeDirect",
    "Ivars.playerPartsTypeDirect",
    "Ivars.playerCamoTypeDirect",
    "Ivars.playerFaceIdDirect",
    "Ivars.playerFaceEquipIdDirect",

    "InfMenuCommands.PrintFaceInfo",
    --OFF "Ivars.playerHeadgear",
    "InfMenuCommands.PrintCurrentAppearance",

    "Ivars.faceFova",
    "Ivars.faceDecoFova",
    "Ivars.hairFova",
    "Ivars.hairDecoFova",

    "Ivars.faceFovaUnknown1",
    "Ivars.faceFovaUnknown2",
    "Ivars.faceFovaUnknown3",
    "Ivars.faceFovaUnknown4",
    "Ivars.faceFovaUnknown5",
    "Ivars.faceFovaUnknown6",
    "Ivars.faceFovaUnknown7",
    "Ivars.faceFovaUnknown8",
    "Ivars.faceFovaUnknown9",
    "Ivars.faceFovaUnknown10",
    "InfMenuDefs.fovaModMenu",
  }
}

this.playerSettingsMenu={
  options={
    "Ivars.playerHealthScale",
    "InfMenuCommands.RemoveDemon",
    "InfMenuCommands.SetDemon",
    "Ivars.useSoldierForDemos",
    --"Ivars.playerHeadgear",
    "InfMenuDefs.appearanceMenu",
  }
}
this.soldierParamsMenu={
  options={
    "Ivars.soldierParamsProfile",
    "Ivars.soldierHealthScale",
    "Ivars.soldierSightDistScale",
    "Ivars.soldierNightSightDistScale",
    "Ivars.soldierHearingDistScale",
    "Ivars.itemDropChance",
    "InfMenuCommands.PrintHealthTableParameter",
    "InfMenuCommands.PrintSightFormParameter",
    "InfMenuCommands.PrintHearingTable",
  }
}

--tex Generated
this.sideOpsCategoryMenu={
  options={
  }
}

local ivarPrefix="sideops_"
for i,categoryName in ipairs(TppQuest.QUEST_CATEGORIES)do
  if categoryName~="ADDON_QUEST" then--tex only for selection ivar currently
    local ivarName=ivarPrefix..categoryName
    table.insert(this.sideOpsCategoryMenu.options,"Ivars."..ivarName)
  end
end

this.sideOpsMenu={
  options={
    "InfQuest.RerollQuestSelection",
    "Ivars.unlockSideOpNumber",
    "Ivars.unlockSideOps",
    "Ivars.sideOpsSelectionMode",
    "InfMenuDefs.sideOpsCategoryMenu",
    "Ivars.showAllOpenSideopsOnUi",
    "Ivars.enableHeliReinforce",
    "Ivars.ihSideopsPercentageCount",
  }
}

this.motherBaseShowCharactersMenu={
  options={
    "Ivars.mbEnableOcelot",
    "Ivars.mbEnablePuppy",
    "Ivars.mbShowCodeTalker",
    "Ivars.mbShowEli",
    "Ivars.mbShowHuey",
    "Ivars.mbAdditionalNpcs",
    "Ivars.mbEnableBirds",
    "InfMenuCommands.ResetPaz",
    "InfMenuCommands.ReturnQuiet",
    "InfMenuCommands.ShowQuietReunionMissionCount",
  }
}

this.motherBaseShowAssetsMenu={
  options={
    "Ivars.mbShowBigBossPosters",
    --"Ivars.mbShowQuietCellSigns",--tex not that interesting
    "Ivars.mbShowMbEliminationMonument",
    "Ivars.mbShowSahelan",
    "Ivars.mbShowShips",
    "Ivars.enableFultonAlarmsMB",
    "Ivars.enableIRSensorsMB",
    "Ivars.hideContainersMB",
    "Ivars.hideAACannonsMB",
    "Ivars.hideAAGatlingsMB",
    "Ivars.hideTurretMgsMB",
    "Ivars.hideMortarsMB",
    "Ivars.mbUnlockGoalDoors",
    "Ivars.mbForceBattleGearDevelopLevel",
  }
}

this.customEquipMenu={
  options={
    --CULL
    --    "Ivars.enableDDEquipMB",
    --    "Ivars.enableDDEquipFREE",
    --    "Ivars.enableDDEquipMISSION",
    "Ivars.customWeaponTableFREE",
    "Ivars.customWeaponTableMISSION",
    "Ivars.customWeaponTableMB_ALL",
    "Ivars.weaponTableStrength",
    "Ivars.weaponTableAfgh",
    "Ivars.weaponTableMafr",
    "Ivars.weaponTableSkull",
    "Ivars.weaponTableDD",
    "Ivars.soldierEquipGrade_MIN",
    "Ivars.soldierEquipGrade_MAX",
    "Ivars.allowUndevelopedDDEquip",
    "Ivars.mbDDEquipNonLethal",
  }
}

this.mbStaffMenu={
  options={
    "InfMBStaff.AddPlayerStaff",
    "InfMBStaff.RemovePlayerStaff",
    "InfMBStaff.ClearPriorityStaff",
    "Ivars.mbPrioritizeFemale",
    "Ivars.mbMoraleBoosts",
  }
}

this.mbStaffInMissionMenu={
  options={
    "InfMBStaff.AddPlayerStaff",
    "InfMBStaff.RemovePlayerStaff",
    "InfMBStaff.AddMarkerStaff",
    "InfMBStaff.RemoveMarkerStaff",
    "InfMBStaff.ClearPriorityStaff",
  }
}

--tex SYNC motherbaseProfile
this.motherBaseMenu={
  options={
    "Ivars.revengeModeMB_ALL",
    "InfMenuDefs.customEquipMenu",
    "Ivars.mbSoldierEquipRange",
    "Ivars.customSoldierTypeMB_ALL",
    "Ivars.customSoldierTypeFemaleMB_ALL",
    "Ivars.mbDDHeadGear",
    --"Ivars.disableMotherbaseWeaponRestriction",--WIP
    "Ivars.supportHeliPatrolsMB",
    "Ivars.attackHeliPatrolsMB",
    "Ivars.mbEnemyHeliColor",
    "Ivars.enableWalkerGearsMB",
    "Ivars.mbWalkerGearsColor",
    "Ivars.mbWalkerGearsWeapon",
    "Ivars.mbCollectionRepop",
    "Ivars.revengeDecayOnLongMbVisit",
    "Ivars.mbEnableBuddies",
    "Ivars.mbAdditionalSoldiers",
    "Ivars.mbqfEnableSoldiers",
    "Ivars.mbNpcRouteChange",
    "InfMenuDefs.mbStaffMenu",
    "InfMenuDefs.motherBaseShowCharactersMenu",
    "InfMenuDefs.motherBaseShowAssetsMenu",
    "Ivars.mbEnableLethalActions",
    "Ivars.mbWargameFemales",
    "Ivars.mbWarGamesProfile",
  }
}

this.demosMenu={
  options={
    "Ivars.useSoldierForDemos",
    "Ivars.mbDemoSelection",
    "Ivars.mbSelectedDemo",
    "Ivars.forceDemoAllowAction",
    "Ivars.mbDemoOverrideTime",
    "Ivars.mbDemoHour",
    "Ivars.mbDemoMinute",
    "Ivars.mbDemoOverrideWeather",
  --"Ivars.mbDontDemoDisableBuddy",--WIP
  }
}

this.resourceScaleMenu={
  options={
    "Ivars.enableResourceScale",
    "Ivars.resourceScaleMaterial",
    "Ivars.resourceScalePlant",
    "Ivars.resourceScalePoster",
    "Ivars.resourceScaleDiamond",
    "Ivars.resourceScaleContainer",
  }
}

this.progressionMenu={
  options={
    "InfMenuDefs.resourceScaleMenu",
    "Ivars.repopulateRadioTapes",
    "InfMenuCommands.UnlockPlayableAvatar",
    "InfMenuCommands.UnlockWeaponCustomization",
    "InfMenuCommands.ResetPaz",
    "InfMenuCommands.ReturnQuiet",
    "InfMenuCommands.ShowQuietReunionMissionCount",
  --"InfQuest.ForceAllQuestOpenFlagFalse",
  }
}

this.debugMenu={
  options={
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "InfMenuCommands.LoadExternalModules",
    "InfMenuCommands.CopyLogToPrev",
    "Ivars.printPressedButtons",
    "InfMenuCommands.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfMenuCommands.ShowMissionCode",
    "InfMenuCommands.ShowLangCode",
    "InfMenuDefs.appearanceDebugMenu",
    "Ivars.disableGameOver",
    "Ivars.disableOutOfBoundsChecks",
    "Ivars.telopMode",--tex TODO move, odd one out, mission/presentation?
    "Ivars.manualMissionCode",
  }
}

this.ospMenu={
  noResetItem=true,
  options={
    "Ivars.primaryWeaponOsp",
    "Ivars.secondaryWeaponOsp",
    "Ivars.tertiaryWeaponOsp",--tex user can set in UI, but still have it for setting the profile changes", and also if they want to set it while they"re doing the other settings
    "Ivars.clearItems",
    "Ivars.clearSupportItems",
  }
}

this.itemLevelMenu={
  noResetItem=true,
  options={
    "Ivars.itemLevelIntScope",
    "Ivars.itemLevelIDroid",
  }
}

this.handLevelMenu={
  noResetItem=true,
  options={
    "Ivars.handLevelSonar",
    "Ivars.handLevelPhysical",
    "Ivars.handLevelPrecision",
    "Ivars.handLevelMedical",
  }
}

this.fultonLevelMenu={
  noResetItem=true,
  options={
    "Ivars.itemLevelFulton",
    "Ivars.itemLevelWormhole",
  }
}

this.fultonSuccessMenu={
  options={
    "Ivars.fultonNoMbSupport",
    "Ivars.fultonNoMbMedical",
    "Ivars.fultonDyingPenalty",
    "Ivars.fultonSleepPenalty",
    "Ivars.fultonHoldupPenalty",
    "Ivars.fultonDontApplyMbMedicalToSleep",
    "Ivars.fultonHostageHandling",
  },
}

this.revengeSystemMenu={
  options={
    "Ivars.revengeBlockForMissionCount",
    "Ivars.applyPowersToOuterBase",
    "Ivars.applyPowersToLrrp",
    "Ivars.allowHeavyArmorFREE",
    "Ivars.allowHeavyArmorMISSION",
    "Ivars.disableMissionsWeaponRestriction",
    "Ivars.disableNoStealthCombatRevengeMission",
    "Ivars.revengeDecayOnLongMbVisit",
    --"Ivars.disableMotherbaseWeaponRestriction",--WIP TODO
    "Ivars.allowHeadGearCombo",
    "Ivars.balanceHeadGear",
    "Ivars.allowMissileWeaponsCombo",
    "Ivars.enableMgVsShotgunVariation",
    "Ivars.randomizeSmallCpPowers",
    "Ivars.disableConvertArmorToShield",
    --"Ivars.balanceWeaponPowers",--WIP
    "Ivars.randomizeMineTypes",
    "Ivars.additionalMineFields",
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
    menuOptions[#menuOptions+1]="Ivars."..ivarName..minSuffix
    menuOptions[#menuOptions+1]="Ivars."..ivarName..maxSuffix
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
    "InfMenuCommands.PrintCustomRevengeConfig",
  }
}
local revengeMenu=this.revengeCustomMenu.options
for n,powerTableName in ipairs(Ivars.percentagePowerTables)do
  revengeMenu[#revengeMenu+1]="InfMenuDefs."..powerTableName..menuSuffix
end
table.insert(revengeMenu,"InfMenuDefs.abilityCustomMenu")
table.insert(revengeMenu,"InfMenuDefs.weaponStrengthCustomMenu")
table.insert(revengeMenu,"InfMenuDefs.cpEquipBoolPowersMenu")
local revengeMinMaxIvarList={
  "reinforceCount",
  "reinforceLevel",
  "revengeIgnoreBlocked",
}
local menuOptions=revengeMenu
for i,ivarName in ipairs(revengeMinMaxIvarList)do
  menuOptions[#menuOptions+1]="Ivars."..ivarName..minSuffix
  menuOptions[#menuOptions+1]="Ivars."..ivarName..maxSuffix
end

this.revengeMenu={
  options={
    "Ivars.revengeModeFREE",
    "Ivars.revengeModeMISSION",
    "Ivars.revengeModeMB_ALL",
    "InfMenuDefs.revengeCustomMenu",
    "InfMenuDefs.revengeSystemMenu",
    "InfMenuDefs.customEquipMenu",
    "Ivars.customSoldierTypeFREE",
    "InfMenuCommands.ResetRevenge",
    "InfMenuCommands.DEBUG_PrintRevengePoints",
    "Ivars.changeCpSubTypeFREE",
    "Ivars.changeCpSubTypeMISSION",
    "Ivars.enableInfInterrogation",
  }
}
--
this.playerRestrictionsInMissionMenu={
  options={
    "Ivars.disableHeadMarkers",
    --"Ivars.disableXrayMarkers",--tex doesn"t seem to work realtime
    "Ivars.disableWorldMarkers",
  },
}

this.phaseMenu={
  options={
    --this.printPlayerPhase",--DEBUG
    "Ivars.phaseUpdate",
    "Ivars.minPhase",
    "Ivars.maxPhase",
    "Ivars.keepPhase",
    "Ivars.phaseUpdateRate",
    "Ivars.phaseUpdateRange",
    "Ivars.soldierAlertOnHeavyVehicleDamage",--tex these>
    --"Ivars.cpAlertOnVehicleFulton",--WIP", NOTE: ivar save is disabled
    "Ivars.printPhaseChanges",--<don"t rely on phaseUpdate
  },
}

this.supportHeliMenu={
  options={
    --"Ivars.setTakeOffWaitTime",
    --"InfHelicopter.PullOutHeli",
    --"InfMenuCommands.ChangeToIdleStateHeli",
    "Ivars.disableHeliAttack",
    "Ivars.setInvincibleHeli",
    "Ivars.setSearchLightForcedHeli",
    "Ivars.disablePullOutHeli",
    "Ivars.setLandingZoneWaitHeightTop",
    "Ivars.defaultHeliDoorOpenTime",
    "Ivars.disableLzs",
    "Ivars.startOnFootFREE",
    "Ivars.startOnFootMISSION",
    "Ivars.startOnFootMB_ALL",
  --"Ivars.disableDescentToLandingZone",
  --"Ivars.enableGetOutHeli",--WIP
  },
}

this.enemyReinforceMenu={
  options={
    "Ivars.forceSuperReinforce",
    "Ivars.enableHeliReinforce",
    "Ivars.forceReinforceRequest",
    "Ivars.disableReinforceHeliPullOut",
    "Ivars.enableSoldiersWithVehicleReinforce",
  },
}

this.enemyPatrolMenu={
  options={
    "Ivars.enableLrrpFreeRoam",
    "Ivars.enableWildCardFreeRoam",
    "Ivars.attackHeliPatrolsFREE",
    "Ivars.attackHeliPatrolsMB",
    "Ivars.mbEnemyHeliColor",
    "Ivars.enableWalkerGearsFREE",
    "Ivars.enableWalkerGearsMB",
    "Ivars.vehiclePatrolProfile",
    "Ivars.vehiclePatrolClass",
    "Ivars.vehiclePatrolLvEnable",
    "Ivars.vehiclePatrolTruckEnable",
    "Ivars.vehiclePatrolWavEnable",
    "Ivars.vehiclePatrolWavHeavyEnable",
    "Ivars.vehiclePatrolTankEnable",
    "Ivars.putEquipOnTrucks",
  }
}

this.cameraMenu={
  options={
    "Ivars.adjustCameraUpdate",
    "Ivars.cameraMode",
    "InfMenuCommands.WarpToCamPos",
    "Ivars.moveScale",
    "Ivars.disableCamText",
    "InfMenuCommands.ShowFreeCamPosition",
  --    "Ivars.focalLength",--CULL
  --    "Ivars.focusDistance",
  --    "Ivars.aperture",
  --    "InfMenuCommands.ResetCameraSettings",--tex just reset cam pos at the moment
  }
}

this.userMarkerMenu={
  options={
    "InfMenuCommands.WarpToUserMarker",
    "InfUserMarker.PrintLatestUserMarker",
    "InfUserMarker.PrintUserMarkers",
    --    "InfMenuCommands.SetSelectedCpToMarkerObjectCp",--DEBUG
    --    "Ivars.selectedCp",--DEBUG
    "InfMenuCommands.QuietMoveToLastMarker",
  }
}

this.markersMenu={
  options={
    "Ivars.disableHeadMarkers",
    "Ivars.disableXrayMarkers",
    "Ivars.disableWorldMarkers",
  }
}

this.missionPrepRestrictionsMenu={
  options={
    "Ivars.disableSelectTime",
    "Ivars.disableSelectBuddy",
    "Ivars.disableSelectVehicle",
    "Ivars.mbEnableMissionPrep",
  }
}

this.disableSupportMenuMenu={
  options={
    "Ivars.disableMenuDrop",
    "Ivars.disableMenuBuddy",
    "Ivars.disableMenuAttack",
    "Ivars.disableMenuHeliAttack",
    "Ivars.disableSupportMenu",
  }
}

this.eventsMenu={
  options={
    "InfGameEvent.ForceGameEvent",
    "Ivars.gameEventChanceFREE",
    "Ivars.gameEventChanceMB",
    "Ivars.enableEventHUNTED",
    "Ivars.enableEventCRASHLAND",
    "Ivars.enableEventLOST_COMS",
    "Ivars.enableParasiteEvent",
    "Ivars.armorParasiteEnabled",
    "Ivars.mistParasiteEnabled",
    "Ivars.camoParasiteEnabled",
    "Ivars.parasitePeriod_MIN",
    "Ivars.parasitePeriod_MAX",
    "Ivars.parasiteWeather",
  }
}
this.playerRestrictionsMenu={
  options={
    "Ivars.disableHeliAttack",
    "Ivars.disableFulton",
    "Ivars.setSubsistenceSuit",
    "Ivars.setDefaultHand",
    "Ivars.abortMenuItemControl",
    "Ivars.disableRetry",
    "Ivars.gameOverOnDiscovery",
    "Ivars.disableSpySearch",
    "Ivars.disableHerbSearch",
    "Ivars.dontOverrideFreeLoadout",
    "InfMenuDefs.markersMenu",
    "InfMenuDefs.missionPrepRestrictionsMenu",
    "InfMenuDefs.disableSupportMenuMenu",
    "InfMenuDefs.itemLevelMenu",
    "InfMenuDefs.handLevelMenu",
    "InfMenuDefs.fultonLevelMenu",
    "InfMenuDefs.fultonSuccessMenu",
    "InfMenuDefs.ospMenu",
  }
}

this.timeScaleMenu={
  options={
    "InfMenuCommands.HighSpeedCameraToggle",
    "Ivars.speedCamContinueTime",
    "Ivars.speedCamWorldTimeScale",
    "Ivars.speedCamPlayerTimeScale",
    "Ivars.speedCamNoDustEffect",
    "Ivars.clockTimeScale",
  }
}

this.buddyMenu={
  options={
    "Ivars.buddyChangeEquipVar",
    "InfMenuCommands.QuietMoveToLastMarker",
    "Ivars.quietRadioMode",
  }
}

this.systemMenu={
  options={
    "Ivars.enableIHExt",
    "InfMgsvToExt.TakeFocus",--tex while this is inserted to root menus on postallmodules, it still needs an non dynamic entry somewhere to make sure BuildCommandItems hits it
    "Ivars.selectProfile",
    --"InfMenuCommands.ApplySelectedProfile",
    "InfMenuCommands.ResetSelectedProfile",
    "InfMenuCommands.SaveToProfile",
    --"InfMenuCommands.ViewProfile",--DEBUG
    "Ivars.enableQuickMenu",
    "Ivars.startOffline",
    "Ivars.skipLogos",
    --"Ivars.langOverride",
    "Ivars.loadAddonMission",
    "Ivars.ihMissionsPercentageCount",
    "InfMenuCommands.ResetAllSettingsItem",
  },
}

this.mbOceanMenu={
  options={
    "Ivars.mbEnableOceanSettings",
    "Ivars.mbSetOceanBaseHeight",
    "Ivars.mbSetOceanProjectionScale",
    "Ivars.mbSetOceanBlendEnd",
    "Ivars.mbSetOceanFarProjectionAmplitude",
    "Ivars.mbSetOceanSpecularIntensity",
    "Ivars.mbSetOceanDisplacementStrength",
    "Ivars.mbSetOceanWaveAmplitude",
    "Ivars.mbSetOceanWindDirectionP1",
    "Ivars.mbSetOceanWindDirectionP2",
  },
}

this.devInAccMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "InfMenuCommands.DEBUG_SomeShiz",
    "InfMenuCommands.DEBUG_SomeShiz2",
    "InfMenuCommands.DEBUG_SomeShiz3",
    --"Ivars.customBodyTypeMB_ALL",--DEBUGNOW
    "Ivars.selectEvent",
    --"Ivars.customSoldierTypeMISSION",--TODO:
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "Ivars.skipDevelopChecks",
    "InfLookup.DumpValidStrCode",
    --TODO: debugmodeall command/profile
    --"Ivars.enableWildCardHostageFREE",--WIP
    --"Ivars.enableSecurityCamFREE",
    "InfMenuCommands.ForceRegenSeed",
    "Ivars.debugValue",
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
  }
}

this.heliSpaceMenu={
  noResetItem=true,
  noGoBackItem=true,
  insertEndOffset=1,--tex MenuOffItem
  options={
    "InfMenuDefs.systemMenu",
    "InfMenuDefs.eventsMenu",
    "InfMenuDefs.playerRestrictionsMenu",
    "InfMenuDefs.playerSettingsMenu",
    "InfMenuDefs.soldierParamsMenu",
    "InfMenuDefs.phaseMenu",
    "InfMenuDefs.revengeMenu",
    "InfMenuDefs.enemyReinforceMenu",
    "InfMenuDefs.enemyPatrolMenu",
    "InfMenuDefs.sideOpsMenu",
    "InfMenuDefs.motherBaseMenu",
    "InfMenuDefs.demosMenu",
    "InfMenuDefs.cameraMenu",
    "InfMenuDefs.timeScaleMenu",
    "InfMenuDefs.supportHeliMenu",
    "InfMenuDefs.progressionMenu",
    "InfMenuDefs.debugMenu",
    "InfMenuCommands.MenuOffItem",
  }
}

this.debugInMissionMenu={
  options={
    "InfMenuDefs.appearanceMenu",
    "InfMenuDefs.appearanceDebugMenu",
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "InfMenuCommands.LoadExternalModules",
    "InfMenuCommands.CopyLogToPrev",
    --"InfMenuCommands.DEBUG_RandomizeCp",
    --"InfMenuCommands.DEBUG_PrintRealizedCount",
    --"InfMenuCommands.DEBUG_PrintEnemyFova",
    "InfMenuCommands.SetSelectedObjectToMarkerClosest",
    "Ivars.selectedCp",
    "InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "InfMenuCommands.DEBUG_PrintCpPowerSettings",
    "InfMenuCommands.DEBUG_PrintPowersCount",
    --"InfMenuCommands.DEBUG_PrintCpSizes",
    "InfMenuCommands.DEBUG_PrintReinforceVars",
    --"InfMenuCommands.DEBUG_PrintVehicleTypes",
    --"InfMenuCommands.DEBUG_PrintVehiclePaint",
    "InfMenuCommands.DEBUG_PrintSoldierDefine",
    --"InfMenuCommands.DEBUG_PrintSoldierIDList",
    "InfMenuCommands.DEBUG_ShowRevengeConfig",
    "InfMenuDefs.appearanceDebugMenu",
    --"InfMenuCommands.DEBUG_ShowPhaseEnums",--CULL
    --"InfMenuCommands.DEBUG_ChangePhase",
    --"InfMenuCommands.DEBUG_KeepPhaseOn",
    --"InfMenuCommands.DEBUG_KeepPhaseOff",
    --"InfMenuCommands.printPlayerPhase",
    --"InfMenuCommands.DEBUG_SetPlayerPhaseToIvar",
    --"InfMenuCommands.DEBUG_PrintVarsClock",
    --"InfMenuCommands.ShowMissionCode",
    --"InfMenuCommands.ShowMbEquipGrade",
    "Ivars.printPressedButtons",
    "Ivars.printOnBlockChange",
    "Ivars.disableGameOver",
    "Ivars.disableOutOfBoundsChecks",
    "InfMenuCommands.SetAllFriendly",
    "InfMenuCommands.ResetStageBlockPosition",
    "InfMenuCommands.SetStageBlockPositionToMarkerClosest",
    "InfMenuCommands.SetStageBlockPositionToFreeCam",
    "InfMenuCommands.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
  --"InfMenuCommands.DEBUG_ClearAnnounceLog",
  }
}

this.devInMissionMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "InfCore.StartExt",--DEBUGNOW
    "InfMenuCommands.ResetStageBlockPosition",--DEBUGNOW
    "InfMenuCommands.SetStageBlockPositionToMarkerClosest",
    "InfMenuCommands.SetStageBlockPositionToFreeCam",
    "InfMenuCommands.DEBUG_SomeShiz",
    "InfMenuCommands.DEBUG_SomeShiz2",
    "InfMenuCommands.DEBUG_SomeShiz3",
    "InfMenuCommands.SetSelectedObjectToMarkerClosest",
    --"Ivars.selectedCp",
    --"InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "Ivars.selectedCp",
    "Ivars.warpToListObject",
    "InfUserMarker.PrintLatestUserMarker",
    "InfMenuCommands.SetAllZombie",
    "InfMenuCommands.CheckPointSave",
    "Ivars.manualMissionCode",
    "InfCore.ClearLog",
    "InfMenuCommands.RequestHeliLzToLastMarkerAlt",
    "InfMenuCommands.RequestHeliLzToLastMarker",
    "InfMenuCommands.ForceExitHeliAlt",
    "Ivars.warpToListPosition",
    "Ivars.warpToListObject",
    "Ivars.setCamToListObject",
    "Ivars.dropLoadedEquip",
    "Ivars.dropTestEquip",
    "Ivars.selectedGameObjectType",
    "Ivars.manualMissionCode",
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "Ivars.skipDevelopChecks",
    "Ivars.debugValue",
    "InfMenuCommands.DEBUG_PrintSoldierDefine",
    "Ivars.parasitePeriod_MIN",
    "Ivars.parasitePeriod_MAX",
    "InfMenuCommands.DEBUG_ToggleParasiteEvent",
    "InfLookup.DumpValidStrCode",
    "InfMenuCommands.SetAllFriendly",
    "InfMenuCommands.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
  }
}

this.inMissionMenu={
  noResetItem=true,--tex KLUDGE, to keep menuoffitem order
  noGoBackItem=true,--tex is root
  insertEndOffset=2,--tex ResetSettingsItem,MenuOffItem
  options={
    "InfMenuCommands.RequestHeliLzToLastMarker",
    "InfMenuCommands.ForceExitHeli",
    "InfMenuCommands.DropCurrentEquip",
    "Ivars.warpPlayerUpdate",
    "InfMenuDefs.cameraMenu",
    "InfMenuDefs.timeScaleMenu",
    "InfMenuDefs.userMarkerMenu",
    "InfMenuDefs.buddyMenu",
    "InfMenuDefs.appearanceMenu",
    "InfMenuDefs.mbStaffInMissionMenu",
    "InfMenuDefs.playerRestrictionsInMissionMenu",
    "InfMenuDefs.phaseMenu",
    "InfMenuDefs.supportHeliMenu",
    "InfMenuDefs.mbOceanMenu",
    "InfMenuDefs.debugInMissionMenu",
    "Ivars.itemDropChance",
    "Ivars.playerHealthScale",
    "InfMenuCommands.ResetSettingsItem",
    "InfMenuCommands.MenuOffItem",
  }
}



local optionType="MENU"
local IsTable=Tpp.IsTypeTable
local IsFunc=Tpp.IsTypeFunc

--tex build up full item object from partial definition
function this.BuildMenuItem(name,item)
  if IsTable(item) then
    if item.options then
      item.optionType=optionType
      item.name=name
      item.disabled=false
      item.parent=nil
      if item.noResetItem~=true then
        item.options[#item.options+1]="InfMenuCommands.ResetSettingsItem"
      end
      if item.noGoBackItem~=true then
        item.options[#item.options+1]="InfMenuCommands.GoBackItem"
      end
    end
  end
end

--WIP DEBUGNOW
this.menuForContext={
  HELISPACE=this.heliSpaceMenu,
  MISSION=this.inMissionMenu,
}

function this.PostAllModulesLoad()
  InfCore.LogFlow("Adding module menuDefs")
  
  --tex DEBUGNOW monkeying around with inserting menu items currently breaks AutoDoc
  if isMockFox then
    return
  end
  
  for i,module in ipairs(InfModules) do
    if IsTable(module.menuDefs) then
      for name,menuDef in pairs(module.menuDefs)do
        local newRef=module.name.."."..name
        InfCore.Log(newRef)
        this.BuildMenuItem(name,menuDef)
        --tex set them to nonconfig by default so to not trip up AutoDoc
        if menuDef.nonConfig~=false then--tex unless we specficially want it to be for config
          menuDef.nonConfig=true
        end
        if menuDef.noDoc~=false then
          menuDef.noDoc=true
        end        
        if menuDef.context then
          local menuForContext=this.menuForContext[menuDef.context]
          if menuForContext then
            --tex check to see it isn"t already in menu
            local alreadyAdded=false
            for i,optionRef in ipairs(menuForContext.options)do
              if optionRef==newRef then
                InfCore(optionRef.." was already added")
                alreadyAdded=true
                break
              end
            end
            if not alreadyAdded then
              local insertPos = menuForContext.insertEndOffset and (#menuForContext.options-menuForContext.insertEndOffset) or #menuForContext.options
              InfCore.Log("Adding "..newRef.." to menu at pos "..insertPos.." of "..#menuForContext.options)
              table.insert(menuForContext.options,insertPos,newRef)
            end
          end
        end
      end
    end
  end

  if ivars.enableIHExt>0 then--DEBUGNOW TODO another ivar, also change 'Turn off menu' to only add if ivar
    local insertPos=#this.heliSpaceMenu.options-this.heliSpaceMenu.insertEndOffset
    this.heliSpaceMenu.options[insertPos]="InfMgsvToExt.TakeFocus"
    local insertPos=#this.inMissionMenu.options-this.inMissionMenu.insertEndOffset
    this.inMissionMenu.options[insertPos]="InfMgsvToExt.TakeFocus"
  end
end

--EXEC
--TABLESETUP: MenuDefs
for name,item in pairs(this) do
  this.BuildMenuItem(name,item)
end

--tex TODO RETHINK
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

--DEBUGNOW
for n,item in pairs(this) do
  if IsTable(item) then
    if item.options then--tex is menu
      for i,optionRef in ipairs(item.options)do
        if type(optionRef)~="string"then
          InfCore.Log("InfMenuDefs: WARNING option "..i.." on menu "..n.."~=string")
        end
    end
    end
  end
end

return this
