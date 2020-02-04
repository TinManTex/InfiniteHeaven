-- InfMenuDefs.lua
--
local this={}
--LOCALOPT
local InfCore=InfCore
--tex NOTE its ok to reference modules that are reloaded before this is reloaded
local Ivars=Ivars
local InfMenuDefs=this

this.debugModule=false

--tex root menus are mostly built out from menu def entries in other modules, search for parentRefs with InfMenuDefs.inSafeSpaceMenu etc

--tex root menu, in ACC
this.safeSpaceMenu={
  options={
    "InfMenuDefs.systemMenu",--tex forced order (first) rather than just by context
  }
}

--tex root menu, in mission
this.inMissionMenu={
  options={
    "InfHelicopter.RequestHeliLzToLastMarkerAlt",
    "InfHelicopter.ForceExitHeliAlt",
    "InfMenuCommandsTpp.DropCurrentEquip",
    "Ivars.warpPlayerUpdate",
  }
}

--tex root menu, in demo
this.inDemoMenu={
  options={
    "InfDemo.RestartDemo",
    "InfDemo.PauseDemo",
  },
}

this.systemMenu={
  options={
    --DEBUGNOW split into it's own menu
    "Ivars.enableIHExt",
    "Ivars.enableHelp",
    "InfMgsvToExt.TakeFocus",--tex while this is inserted to root menus on postallmodules, it still needs an non dynamic entry somewhere to make sure BuildCommandItems hits it
    --
    "Ivars.selectProfile",
    --WIP "InfMenuCommands.ApplySelectedProfile",
    "InfMenuCommands.ResetSelectedProfile",
    "InfMenuCommands.SaveToProfile",
    --WIP "InfMenuCommands.ViewProfile",
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
    "Ivars.quest_useAltForceFulton",--DEBUGNOW
    "Ivars.sys_increaseMemoryAlloc",--DEBUGNOW
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
    "Ivars.log_SetFlushLevel",
  }
}

this.debugMenu={
  parentRefs={"InfMenuDefs.safeSpaceMenu"},
  options={
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "Ivars.log_SetFlushLevel",
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

this.debugInMissionMenu={
  parentRefs={"InfMenuDefs.inMissionMenu"},
  options={
    "Ivars.debugMode",
    "Ivars.debugMessages",
    "Ivars.debugFlow",
    "Ivars.debugOnUpdate",
    "Ivars.log_SetFlushLevel",
    "InfMenuCommands.LoadExternalModules",
    "InfMenuCommands.CopyLogToPrev",
    --"InfMenuCommandsTpp.DEBUG_PrintRealizedCount",
    --"InfMenuCommandsTpp.DEBUG_PrintEnemyFova",
    "Ivars.selectedCp",
    "InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "InfMenuCommandsTpp.DEBUG_PrintCpPowerSettings",
    "InfMenuCommandsTpp.DEBUG_PrintPowersCount",
    --"InfMenuCommandsTpp.DEBUG_PrintCpSizes",
    "InfMenuCommandsTpp.DEBUG_PrintReinforceVars",
    --"InfMenuCommandsTpp.DEBUG_PrintVehicleTypes",
    --"InfMenuCommandsTpp.DEBUG_PrintVehiclePaint",
    "InfMenuCommandsTpp.DEBUG_PrintSoldierDefine",
    --"InfMenuCommandsTpp.DEBUG_PrintSoldierIDList",
    "InfMenuCommandsTpp.DEBUG_ShowRevengeConfig",
    "InfFovaIvars.appearanceDebugMenu",
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
    "InfMenuCommandsTpp.DEBUG_ToggleParasiteEvent",
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
    "Ivars.cam_disableCameraAnimations",
    "InfMenuCommands.DEBUG_SomeShiz",
    "InfMenuCommands.DEBUG_SomeShiz2",
    "InfMenuCommands.DEBUG_SomeShiz3",
    "InfMenuCommands.DEBUG_WarpToObject",
    "Ivars.warpToListPosition",
    "Ivars.warpToListObject",
    "InfHelicopter.RequestHeliLzToLastMarker",
    "InfHelicopter.RequestHeliLzToLastMarkerAlt",
    "InfHelicopter.ForceExitHeli",
    "InfHelicopter.ForceExitHeliAlt",
    "InfHelicopter.PullOutHeli",
    "InfHelicopter.ChangeToIdleStateHeli",
    "Ivars.disablePullOutHeli",
    --"Ivars.selectedCp",
    --"InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "Ivars.selectedCp",
    "InfUserMarker.PrintLatestUserMarker",
    "InfMenuCommands.SetAllZombie",
    "InfMenuCommands.CheckPointSave",
    "Ivars.manualMissionCode",
    "Ivars.setCamToListObject",
    "Ivars.dropLoadedEquip",
    "Ivars.dropTestEquip",
    "Ivars.manualMissionCode",
    "Ivars.manualSequence",
    "Ivars.allowUndevelopedDDEquip",
    "Ivars.skipDevelopChecks",
    "Ivars.debugValue",
    "InfMenuCommandsTpp.DEBUG_PrintSoldierDefine",
    --"Ivars.parasitePeriod_MIN",
    --"Ivars.parasitePeriod_MAX",
    --"InfMenuCommandsTpp.DEBUG_ToggleParasiteEvent",
    "InfLookup.DumpValidStrCode",
    "InfMenuCommands.SetAllFriendly",
    "InfCamera.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfCore.ClearLog",
  }
}

this.searchMenu={
  noDoc=true,
  nonConfig=true,
  options={
    "Ivars.searchItem",
    "InfMenuCommands.GoBackTopItem",
  }
}

--<
this.rootMenus={
  safeSpaceMenu=true,
  inMissionMenu=true,
  inDemoMenu=true,
}

local OPTIONTYPE_MENU="MENU"
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
    item.optionType=OPTIONTYPE_MENU
    item.name=name
    item.parent=nil
  end
end

--tex IHs menu system works through Options, of which Ivars,Menus and Commands are effectively subclasses of
--the runtime operation of the menu is in InfMenu, initial setup of the menu is through InfMenuDefs.SetupMenu --DEBUGNOW
--Menu definitions, or MenuDefs list the options as StringRefs which are just a string representation of <module name>.<option name>
--InfMenuDefs has a few basic menudefs, the rest are in respective IH modules which may also contain the Ivar and Commands they are referencing.
function this.SetupMenuDefs()
  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: generate menus")
  for i,module in ipairs(InfModules) do
    if module.GenerateMenus then
      InfCore.Log(module.name..".GenerateMenus")
      module.GenerateMenus()
    end
  end

  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: register menus")
  --tex add menus in this module to be picked up by registermodules
  --TODO: possibly replace registermodules completely with this, change .options to .menuOptions to give it a more explicit identifier
  this.registerMenus={}
  for name,item in pairs(this) do
    if this.IsMenu(item) then
      table.insert(this.registerMenus,name)
    end
  end

  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: build menu items and gather children menus")
  local parentRefs={}
  for i,module in ipairs(InfModules) do
    if module.registerMenus then
      if this.debugModule then
        InfCore.PrintInspect(module.registerMenus,module.name..".registerMenus")
      end
      for j,name in ipairs(module.registerMenus)do
        local menuDef=module[name]
        if not menuDef then
          InfCore.Log("WARNING: InfMenuDefs.PostAllModulesLoad: could not find "..name.." in "..module.name)
          --TODO: elseif not IsMenu(menuDef) or something
        elseif this.IsMenu(menuDef) then
          local newRef=module.name.."."..name
          if this.debugModule then
            InfCore.Log(newRef)
          end

          --tex build up full menu item object from partial definition
          this.BuildMenuItem(name,menuDef)--tex NOTE: unlike Ivars module menudefs arent built in-to InfMenuDefs

          --tex add to menus in parentRef
          if menuDef.parentRefs then
            for k,parentRef in ipairs(menuDef.parentRefs)do
              local parentMenu,name,moduleName=InfCore.GetStringRef(parentRef)
              if not parentMenu then

              else
                local childrenForMenu=parentRefs[parentRef] or {}
                parentRefs[parentRef]=childrenForMenu

                table.insert(childrenForMenu,newRef)
              end
            end
          end--if parentRefs
        end--if menudef
      end--for registermenu
    end--if registermenu
  end--for infmodules

  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: add children menus to parents")
  if this.debugModule then
    InfCore.PrintInspect(parentRefs,"parentRefs")
  end

  local function SortRefByLangName(refA, refB)
    local itemA,nameA=InfCore.GetStringRef(refA)
    local itemB,nameB=InfCore.GetStringRef(refB)

    local langA=InfLangProc.LangString(nameA)
    local langB=InfLangProc.LangString(nameB)

    return langB > langA
  end

  --tex add the gathered children menus to the parents
  for parentRef,childrenRefs in pairs(parentRefs)do
    local parentMenu,name=InfCore.GetStringRef(parentRef)
    if not parentMenu then
      InfCore.Log("WARNING: InfMenuDefs.SetupMenus: could not find parentMenu:"..parentRef)
    else
      --tex TODO: would want to sort by inflang menu name
      table.sort(childrenRefs,SortRefByLangName)--DEBUGNOW
      for i,childRef in ipairs(childrenRefs)do
        table.insert(parentMenu.options,childRef)
      end
    end
  end

  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: add bottom items")
  for i,module in ipairs(InfModules) do
    if module.registerMenus then
      if this.debugModule then
      --InfCore.PrintInspect(module.registerMenus,module.name..".registerMenus")
      end
      for j,name in ipairs(module.registerMenus)do
        local menuDef=module[name]
        if not menuDef then
          InfCore.Log("WARNING: InfMenuDefs.PostAllModulesLoad: could not find "..name.." in "..module.name)
          --TODO: elseif not IsMenu(menuDef) or something
        elseif this.IsMenu(menuDef) then
          --tex add bottom commands
          --TODO: add option to skip
          --tex see if it actually needs resetitem
          for k,optionRef in ipairs(menuDef.options)do
            local option,name=InfCore.GetStringRef(optionRef)
            if option and type(option)~="function" then
              if IvarProc.IsIvar(option) then
                menuDef.addResetItem=true
              end
              break
            end
          end

          if menuDef.addResetItem then
            table.insert(menuDef.options,"InfMenuCommands.ResetSettingsItem")
          end

          if this.rootMenus[menuDef.name] then
            table.insert(menuDef.options,"InfMenuCommands.MenuOffItem")
          else
            table.insert(menuDef.options,"InfMenuCommands.GoBackItem")
          end
          --
        end--if menudef
      end--for registermenu
    end--if registermenu
  end--for infmodules

  --DEBUGNOW doesnt insert correctly for autodoc
  if not isMockFox then
    if ivars.enableIHExt>0 then-- TODO another ivar, also change 'Turn off menu' to only add if ivar
    --local alreadyAdded=false
    --tex shouldnt be needed, assuming that it's not tranfering anything on modulereload
    --    for i,optionRef in ipairs(this.safeSpaceMenu.options)do
    --      if optionRef=="InfMgsvToExt.TakeFocus" then
    --        alreadyAdded=true
    --        break
    --      end
    --    end
    --if not alreadyAdded then
    --      local insertPos=#this.safeSpaceMenu.options-this.safeSpaceMenu.insertEndOffset
    --      table.insert(this.safeSpaceMenu.options,insertPos,"InfMgsvToExt.TakeFocus")
    --
    --      local insertPos=#this.inMissionMenu.options-this.inMissionMenu.insertEndOffset
    --      table.insert(this.inMissionMenu.options,insertPos,"InfMgsvToExt.TakeFocus")
    -- end
    end
  end

  --VALIDATE
  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: validate")
  for n,item in pairs(this) do
    if this.IsMenu(item) then
      for i,optionRef in ipairs(item.options)do
        if type(optionRef)~="string"then
          InfCore.Log("WARNING: InfMenuDefs: option "..i.." on menu "..n.."~=string")
        end
      end
    end
  end

  --tex TODO RETHINK
  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: allMenus")
  this.allMenus={}
  for i,module in ipairs(InfModules) do
    if module.registerMenus then
      for j,name in ipairs(module.registerMenus)do
        local menuDef=module[name]
        if not menuDef then
        elseif this.IsMenu(menuDef) then
          this.allMenus[#this.allMenus+1]=menuDef
        end
      end
    end
  end

  --tex for search DEBUGNOW, need some kind of context filter (safespace/inmission)
  InfCore.LogFlow("InfMenuDefs.SetupMenuDefs: allItems")
  this.allItems={
    safeSpaceMenu={},
    inMissionMenu={},
    inDemoMenu={},
  }

  local function GetOptionRefsFromMenu(source,dest)
    for i,optionRef in ipairs(source.options)do
      table.insert(dest,optionRef)

      local option,name=InfCore.GetStringRef(optionRef)
      if this.IsMenu(option) then
        GetOptionRefsFromMenu(option,dest)
      end
    end
  end

  GetOptionRefsFromMenu(this.safeSpaceMenu,this.allItems.safeSpaceMenu)
  GetOptionRefsFromMenu(this.inDemoMenu,this.allItems.inDemoMenu)
  GetOptionRefsFromMenu(this.inMissionMenu,this.allItems.inMissionMenu)

  if this.debugModule then
    InfCore.PrintInspect(this.allItems,"InfMenuDefs.allItems")
  end


  --CULL
  --  for i,module in ipairs(InfModules) do
  --    if module.registerMenus then
  --      for j,name in ipairs(module.registerMenus)do
  --        local menuDef=module[name]
  --        if not menuDef then
  --        elseif this.IsMenu(menuDef) then
  --          for k,optionRef in ipairs(menuDef.options)do
  --            local option,name=InfCore.GetStringRef(optionRef)
  --            this.allItems[#this.allItems+1]=optionRef
  --          end
  --        end
  --      end
  --    end
  --  end

  if this.debugModule then
    InfCore.PrintInspect(this,"InfMenuDefs")
  end
end--SetupMenuDefs

function this.PostAllModulesLoad()
  this.SetupMenuDefs()
end

return this
