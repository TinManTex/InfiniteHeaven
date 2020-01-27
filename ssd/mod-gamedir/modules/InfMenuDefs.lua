-- InfMenuDefs.lua
local this={}
--LOCALOPT
--tex NOTE its ok to reference modules that are reloaded before this is reloaded
local Ivars=Ivars
local InfMenuDefs=this

this.debugModule=false--DEBUGNOW

--menus
this.systemMenu={
  options={
    --DEBUGNOW split into it's own menu
    "Ivars.enableIHExt",
    "Ivars.enableHelp",
    "InfMgsvToExt.TakeFocus",--tex while this is inserted to root menus on postallmodules, it still needs an non dynamic entry somewhere to make sure BuildCommandItems hits it
    --
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



this.devInAccMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "Ivars.resetAACRCount",--DEBUGNOW
    "InfGimmick.resetAACRCount",--DEBUGNOW
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

this.debugMenu={
  options={
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "InfMenuCommands.LoadExternalModules",
    "InfMenuCommands.CopyLogToPrev",
    "Ivars.printPressedButtons",
    "InfCamera.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfMenuCommands.ShowMissionCode",
    "InfMenuCommands.ShowLangCode",
    "InfFovaIvars.appearanceDebugMenu",
    "Ivars.disableGameOver",
    "Ivars.disableOutOfBoundsChecks",
    "Ivars.telopMode",--tex TODO move, odd one out, mission/presentation?
    "Ivars.manualMissionCode",
  }
}

this.heliSpaceMenu={
  noResetItem=true,
  noGoBackItem=true,
  insertEndOffset=1,--tex MenuOffItem
  options={
    "InfMenuDefs.systemMenu",
    "InfGameEvent.eventsMenu",
    "InfMainTppIvars.playerRestrictionsMenu",
    "InfMainTppIvars.playerSettingsMenu",
    "InfSoldierParams.soldierParamsMenu",
    "InfEnemyPhase.phaseMenu",
    "InfRevengeIvars.revengeMenu",
    "InfReinforce.enemyReinforceMenu",
    "InfMainTppIvars.enemyPatrolMenu",
    "InfQuestIvars.sideOpsMenu",
    "InfMainTppIvars.motherBaseMenu",
    "InfDemo.demosMenu",
    "InfCamera.cameraMenu",
    "InfTimeScale.timeScaleMenu",
    "InfHelicopter.supportHeliMenu",
    "InfMainTppIvars.progressionMenu",
    "InfMenuDefs.debugMenu",
    "InfMenuCommands.MenuOffItem",
  }
}

this.debugInMissionMenu={
  options={
    "Ivars.manualMissionCode",--DEBUGNOW
    "InfFovaIvars.appearanceMenu",
    "InfFovaIvars.appearanceDebugMenu",
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "InfMenuCommands.LoadExternalModules",
    "InfMenuCommands.CopyLogToPrev",
    --"InfMenuCommandsTpp.DEBUG_PrintRealizedCount",
    --"InfMenuCommandsTpp.DEBUG_PrintEnemyFova",
    "InfMenuCommands.SetSelectedObjectToMarkerClosest",
    "Ivars.selectedCp",
    "InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    --"InfMenuCommandsTpp.DEBUG_PrintCpPowerSettings",
    --"InfMenuCommandsTpp.DEBUG_PrintPowersCount",
    --"InfMenuCommandsTpp.DEBUG_PrintCpSizes",
   -- "InfMenuCommandsTpp.DEBUG_PrintReinforceVars",
    --"InfMenuCommandsTpp.DEBUG_PrintVehicleTypes",
    --"InfMenuCommandsTpp.DEBUG_PrintVehiclePaint",
    --"InfMenuCommandsTpp.DEBUG_PrintSoldierDefine",
    --"InfMenuCommandsTpp.DEBUG_PrintSoldierIDList",
    --"InfMenuCommandsTpp.DEBUG_ShowRevengeConfig",
    "InfFovaIvars.appearanceDebugMenu",
    --"InfMenuCommandsTpp.DEBUG_ShowPhaseEnums",--CULL
    --"InfMenuCommandsTpp.DEBUG_ChangePhase",
    --"InfMenuCommandsTpp.DEBUG_KeepPhaseOn",
    --"InfMenuCommandsTpp.DEBUG_KeepPhaseOff",
    --"InfMenuCommandsTpp.printPlayerPhase",
    --"InfMenuCommandsTpp.DEBUG_SetPlayerPhaseToIvar",
    --"InfMenuCommandsTpp.DEBUG_PrintVarsClock",
    --"InfMenuCommands.ShowMissionCode",
    --"InfMenuCommandsTpp.ShowMbEquipGrade",
    "Ivars.printPressedButtons",
    "Ivars.printOnBlockChange",
    "Ivars.disableGameOver",
    "Ivars.disableOutOfBoundsChecks",
    "InfMenuCommands.SetAllFriendly",
    "InfMenuCommands.SetAllZombie",
    --"InfMenuCommandsTpp.DEBUG_ToggleParasiteEvent",
    "InfMenuCommands.ResetStageBlockPosition",
    "InfMenuCommands.SetStageBlockPositionToMarkerClosest",
    "InfMenuCommands.SetStageBlockPositionToFreeCam",
    "InfCamera.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfMenuCommands.CheckPointSave",
  --"InfMenuCommands.DEBUG_ClearAnnounceLog",
  }
}

this.devInMissionMenu={
  noDoc=true,
  nonConfig=true,
  options={
--    "InfHelicopter.RequestHeliLzToLastMarkerAlt",--DEBUGNOW
--    "InfHelicopter.ForceExitHeli",
--    "InfHelicopter.ForceExitHeliAlt",
--    "InfHelicopter.PullOutHeli",
--    "InfHelicopter.ChangeToIdleStateHeli",
--    "Ivars.disablePullOutHeli",
--    "Ivars.motionGroupIndex",
--    "Ivars.motionGaniIndex",
--    'Ivars.motionHold',
--    'Ivars.motionRepeat',
--    "InfMotion.StopMotion",
--    "InfMotion.PlayCurrentMotion",
--    "InfCore.StartIHExt",--DEBUGNOW
    "InfMenuCommands.DEBUG_SomeShiz",
    "InfMenuCommands.DEBUG_SomeShiz2",
    "InfMenuCommands.DEBUG_SomeShiz3",
--    "InfMenuCommands.SetSelectedObjectToMarkerClosest",
--    --"Ivars.selectedCp",
--    --"InfMenuCommands.SetSelectedCpToMarkerObjectCp",
--    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
--    "Ivars.selectedCp",
--    "Ivars.warpToListObject",
--    "InfUserMarker.PrintLatestUserMarker",
--    "InfMenuCommands.SetAllZombie",
--    "InfMenuCommands.CheckPointSave",
--    "Ivars.manualMissionCode",
--    "InfCore.ClearLog",
--    "InfHelicopter.RequestHeliLzToLastMarkerAlt",
--    "InfHelicopter.RequestHeliLzToLastMarker",
--    "InfHelicopter.ForceExitHeliAlt",
--    "Ivars.warpToListPosition",
--    "Ivars.warpToListObject",
--    "Ivars.setCamToListObject",
--    "Ivars.dropLoadedEquip",
--    "Ivars.dropTestEquip",
--    "Ivars.selectedGameObjectType",
--    "Ivars.manualMissionCode",
--    "Ivars.manualSequence",
--    "Ivars.allowUndevelopedDDEquip",
--    "Ivars.skipDevelopChecks",
--    "Ivars.debugValue",
--    "InfMenuCommandsTpp.DEBUG_PrintSoldierDefine",
--    --"Ivars.parasitePeriod_MIN",
--    --"Ivars.parasitePeriod_MAX",
--    --"InfMenuCommandsTpp.DEBUG_ToggleParasiteEvent",
--    "InfLookup.DumpValidStrCode",
--    "InfMenuCommands.SetAllFriendly",
--    "InfCamera.ShowFreeCamPosition",
--    "InfMenuCommands.ShowPosition",
  }
}

this.inMissionMenu={
  noResetItem=true,--tex KLUDGE, to keep menuoffitem order
  noGoBackItem=true,--tex is root
  insertEndOffset=2,--tex ResetSettingsItem,MenuOffItem
  options={
    --"InfHelicopter.RequestHeliLzToLastMarker",
    --"InfHelicopter.ForceExitHeli",
    --"InfMenuCommandsTpp.DropCurrentEquip",
    "Ivars.warpPlayerUpdate",
    "InfCamera.cameraMenu",
    "InfTimeScale.timeScaleMenu",
    --"InfPositions.positionsMenu",
    --"InfMotion.motionsMenu",
    "InfUserMarker.userMarkerMenu",
    --"InfMainTppIvars.buddyMenu",
    --"InfFovaIvars.appearanceMenu",
    --"InfMBStaff.mbStaffInMissionMenu",
    --"InfMainTppIvars.playerRestrictionsInMissionMenu",
    --"InfEnemyPhase.phaseMenu",
    --"InfHelicopter.supportHeliMenu",
    --"InfMBAssets.mbOceanMenu",
    "InfMenuDefs.debugInMissionMenu",
    --"Ivars.itemDropChance",
    --"Ivars.playerHealthScale",
    "InfMenuCommands.ResetSettingsItem",
    "InfMenuCommands.MenuOffItem",
  }
}
--<

local optionType="MENU"
local IsTable=Tpp.IsTypeTable
local IsFunc=Tpp.IsTypeFunc

function this.IsMenu(item)
  if IsTable(item) then
    if item.options then
      return true
    end
  end

  return false
end

--tex build up full item object from partial definition
function this.BuildMenuItem(name,item)
  if this.IsMenu(item) then
      item.optionType=optionType
      item.name=name
      item.disabled=false
      item.parent=nil
      if item.noResetItem~=true and not item.hasResetItem then
        item.hasResetItem=true
        item.options[#item.options+1]="InfMenuCommands.ResetSettingsItem"
      end
      if item.noGoBackItem~=true and not item.hasGoBackItem then
        item.hasGoBackItem=true
        item.options[#item.options+1]="InfMenuCommands.GoBackItem"
      end
    end
  end

this.menuForContext={
  HELISPACE=this.heliSpaceMenu,
  MISSION=this.inMissionMenu,
}

function this.PostAllModulesLoad()
  InfCore.LogFlow("Adding module menuDefs")

  for i,module in ipairs(InfModules) do
    if module.GenerateMenus then
      InfCore.Log(module.name..".GenerateMenus")
      module.GenerateMenus()
    end
  end

  for i,module in ipairs(InfModules) do
    if module.registerMenus and module~=InfMenuDefs then
      if this.debugModule then
        InfCore.PrintInspect(module.registerMenus,module.name..".registerMenus")
      end
      for j,name in ipairs(module.registerMenus)do
        local menuDef=module[name]
        if not menuDef then
          InfCore.Log("InfMenuDefs.PostAllModulesLoad: WARNING: could not find "..name.." in "..module.name)
          --TODO: elseif not IsMenu(menuDef) or something
        else
          local newRef=module.name.."."..name
          if this.debugModule then
            InfCore.Log(newRef)
          end
          this.BuildMenuItem(name,menuDef)--tex NOTE: unlike Ivars module menudefs arent built in-to InfMenuDefs
          --tex set them to nonconfig by default so to not trip up AutoDoc--DEBUGNOW
          --        if menuDef.nonConfig~=false then--tex unless we specficially want it to be for config
          --          menuDef.nonConfig=true
          --        end
          --        if menuDef.noDoc~=false then
          --          menuDef.noDoc=true
          --        end
          --tex add to one of the main menus --DEBUGNOW
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
          end--if context
        end--if menudef
      end--for registermenu
    end--if registermenu
  end--for infmodules

  --tex DEBUGNOW shouldnt need to run this, but AutoDoc is spazzing out, see if issue is in BuildRevengeCustomMenu or higher
  for name,item in pairs(this) do
    this.BuildMenuItem(name,item)
  end


  if not isMockFox then--DEBUGNOW doesnt insert correctly for autodoc
    if ivars.enableIHExt>0 then-- TODO another ivar, also change 'Turn off menu' to only add if ivar
      --local alreadyAdded=false
      --tex shouldnt be needed, assuming that it's not tranfering anything on modulereload
      --    for i,optionRef in ipairs(this.heliSpaceMenu.options)do
      --      if optionRef=="InfMgsvToExt.TakeFocus" then
      --        alreadyAdded=true
      --        break
      --      end
      --    end
      --if not alreadyAdded then
      local insertPos=#this.heliSpaceMenu.options-this.heliSpaceMenu.insertEndOffset
      table.insert(this.heliSpaceMenu.options,insertPos,"InfMgsvToExt.TakeFocus")

      local insertPos=#this.inMissionMenu.options-this.inMissionMenu.insertEndOffset
      table.insert(this.inMissionMenu.options,insertPos,"InfMgsvToExt.TakeFocus")
      -- end
  end
  end

  --VALIDATE
  for n,item in pairs(this) do
    if this.IsMenu(item) then
      for i,optionRef in ipairs(item.options)do
        if type(optionRef)~="string"then
          InfCore.Log("InfMenuDefs: WARNING option "..i.." on menu "..n.."~=string")
        end
      end
    end
  end

  --tex TODO RETHINK
  this.allMenus={}
  --TABLESETUP: allMenus, for reset, also means you have to comment out whole menu, not just references from other menus since resetall iterates the whole module
  local i=1
  for n,item in pairs(this) do
    if this.IsMenu(item) then
      this.allMenus[i]=item
      i=i+1
    end
  end

  this.allItems={}
  for n,item in pairs(this) do
    if this.IsMenu(item) then
      for i,optionRef in ipairs(item.options)do
        if type(optionRef)=="string"then
          this.allItems[#this.allItems+1]=optionRef
        end
      end
    end
  end

  if this.debugModule then
    InfCore.PrintInspect(this,"InfMenuDefs")
  end
end

function this.SetupMenus()
  InfCore.LogFlow("InfMenuDefs.SetupMenus")

  for name,item in pairs(this) do
    this.BuildMenuItem(name,item)
  end
end

--EXEC
InfCore.PCall(this.SetupMenus)

return this
