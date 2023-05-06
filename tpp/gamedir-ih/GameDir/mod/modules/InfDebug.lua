--InfDebug.lua

local this={}

this.outPath=InfCore.UnfungePath(InfCore.paths.mod..[[\vscode\]])

--tex for want of a place to put this
--TppSequence not currently in build, but we want to log sequence entry
--TppSequence.OnChangeSvars is a pain though because it jumps through a couple of local functions that I cant be bothered going through
--so this will not accuratley log if it actually execs sequence.OnEnter
--and if it does its logging after it anyway
local GetSequenceNameWithIndex=TppSequence.GetSequenceNameWithIndex
function this.OnChangeSVars(name,key)
  if name=="seq_sequence"then
    if InfCore.debugMode then
      local sequenceName=GetSequenceNameWithIndex(svars.seq_sequence)
      InfCore.LogFlow("svars.seq_sequence: "..sequenceName..".OnEnter (maybe, see InfDebug.OnChangeSVars)")
    end
  end
end--OnChangeSVars

function this.OnAllocate(missionTable)
  if InfMain.IsPastTitle(vars.missionCode) and not this.wroteVsCodeHintOnAllocate then
    this.wroteVsCodeHintOnAllocate=true
    if Ivars.debug_WriteVscodeHintOnTitle:Is(1)then
      this.WriteVscodeHint()
    end
  end
end--OnAllocate

function this.Save()
  if Ivars.debug_WriteVarsOnSave:Is(1)then
    this.WriteVars()
  end
end--Save

--tex pulled from IHTearDown, see that for notes if you want to know how it works
--TODO: think if I really want this here, 
--issue is at the moment IHTearDown is geared towards dumping a whole bunch of stuff
--wheres here we just want the vscode relevant stuff
this.unknownId=-285212672
this.foxTableId=-285212671--tex key contains an array of id entries--Results from CheckFoxTableKeysAccountedFor suggests this is the enum table TODO: then renames it foxEnumId?

this.varArrayCountId=-285212666
this.varTableId=-285212665

--OUT:FILES: GameDir/mod/vscode/vars.lua,cvars,svars,gvars,mvars
function this.DumpRuntimeVars()
  InfCore.Log("InfDebug.DumpRunTimeVars")
  --tex runtime dumps>
  if vars.missionCode<=5 then
    InfCore.Log("vars.missionCode<=5, will not output dump files")
    return
  end
  if isMockFox then
    InfCore.Log("isMockFox, will not output dump files")
    return
  end

  --tex vars as global (for vscode lua language server extension workspace lib feature)
  local indexBy1=false--tex is the default of the dump functions anyway
  local varsTables={
    vars=this.DumpVars(vars),
    cvars=this.DumpVars(cvars),
    svars=this.DumpSaveVars(svars),
    gvars=this.DumpSaveVars(gvars),
    mvars=mvars,
  }

  for varsName,varsTable in pairs(varsTables)do
    local header={}
    table.insert(header,"--"..varsName..".lua")
    table.insert(header,[[--GENERATED by InfDebug.WriteVars]])
    table.insert(header,[[--]]..os.date('%Y-%m-%d %H:%M:%S'))
    table.insert(header,[[--missionCode:]]..vars.missionCode)
    table.insert(header,[[--vscode lua extension lib style: runtime vars arrays are indexed from 0]])
    if varsName=="mvars"then
      table.insert(header,[[--mvars is just plain tables as they arent saved or anything, mgsv just clears it on mission change (TODO: when exactly?)]])
      --TODO: something about this, or not if multiple refs too prevalent
      table.insert(header,[[--since they are just dumped via Inspect they'll error out due to how that has non lua syntax for multi references and types <function n> etc]])
    end

    local outPath=this.outPath..varsName..".lua"
    InfCore.WriteTable(outPath,header,varsTable)
  end--for varsTable
end--DumpRuntimeVars

--Dump vars table (and cvars) to a readable table 
--for gvars, svars use DumpSaveVars
--tex GOTCHA: actual runtime vars arrays are indexed indexed from 0, but output here were indexing by 1 so output doesnt look munted, and it can also be used by lua ipairs
function this.DumpVars(inputVars,indexBy1)
  if not inputVars[this.foxTableId] then
    InfCore.Log("WARNING: IHTearDown.DumpVars: inputVars incorrect type? foxTableId not found")
    return
  end

  local varsTable={}

  for k,v in pairs(inputVars[this.foxTableId])do
    varsTable[k]=inputVars[k]
  end

  local skipKeys={
    __index=true,
    __newindex=true,
  }

  local indexStart=indexBy1 and 1 or 0
  local indexShift=indexBy1 and 0 or 1

  for k,foxTable in pairs(inputVars)do
    --tex is actually a foxTable
    if type(foxTable)=="table" then
      if foxTable[this.varArrayCountId] then
        --InfCore.Log("found foxTable "..k)--DEBUGNOW
        if type(k)=="string" then
          if not skipKeys[k] then
            local foxTableArray=foxTable[this.varTableId]
            if foxTableArray then
              varsTable[k]={}
              local arraySize=foxTable[this.varArrayCountId]
              --InfCore.Log("arrayCount="..arrayCount)--DEBUGNOW
              for i=indexStart,arraySize-indexShift do
                varsTable[k][i]=inputVars[k][i]
              end
            end--if foxTableArray
          end--not skipKeys
        end--k==type string
      end--if foxTable[arrayCountIndex]
    end--foxTable==type table
  end--for inputVars

  return varsTable
end--DumpVars

--tex svars,gvars use same layout
--tex GOTCHA: actual runtime vars arrays are indexed from 0, but output here were indexing by 1 so output doesnt look munted, and it can also be used by lua ipairs
function this.DumpSaveVars(inputVars,indexBy1)
  if inputVars==nil then
    InfCore.Log("DumpSaveVars inputVars==nil")
    return
  end

  local varsTable={}

  --tex svars.__as is non array vars
  for k,v in pairs(inputVars.__as)do
    varsTable[k]=v
  end

  --tex svars.__rt is array vars
  --REF
  --  __rt = {
  --      InterrogationNormal = {
  --      __vi = 224,
  --      <metatable> = <table 1>
  --    },
  local indexStart=indexBy1 and 1 or 0
  local indexShift=indexBy1 and 0 or 1
  for k,v in pairs(inputVars.__rt)do
    varsTable[k]={}
    local arraySize=v.__vi--DEBUGNOW not sure if this is right
    for i=indexStart,arraySize-indexShift do
      varsTable[k][i]=inputVars[k][i]
    end
  end

  return varsTable
end--DumpSaveVars
--<dump vars stuff


function this.GetRequireLine(filePath)
  local moduleName=InfCore.GetModuleName(filePath)
  local fileNameWithoutExt=string.sub(filePath,1,-string.len(".lua")-1)--tex strip ext
  local line=moduleName..[[=require"]]..fileNameWithoutExt..[["]]
  return line
end--GetRequireLine

--tex TODO: really need to tag IH files so IH/other mods can have their own hint files
--IN: this.outPath
--OUT:FILE: GameDir/mod/vscode/vscode_hint-mod.lua
function this.WriteLoadedModulesVscodeHint()
  InfCore.LogFlow("WriteLoadedModulesVscodeHint")

  InfCore.PrintInspect(InfCore.loadedModules,"InfCore.loadedModules")
  InfCore.PrintInspect(Tpp.requires,"Tpp.requires")
  InfCore.PrintInspect(Tpp._requireList,"Tpp._requireList")

  if manifest_data1_dat==nil then
    InfCore.Log("ERROR: WriteLoadedModulesHint: manifest_data1_dat module not loaded")
    return
  end

  local fileName="vscode_hint-mod.lua"
  local hintLines={
    "--"..fileName,
    "--GENERATED: by Debug menu > WriteVscodeHint using InfCore.loadedModules",
    "--module/file hints for vscode lua language server extension",
    "--ASSUMPTION: file paths are somewhere the lua language servers Settings > Lua Runtime: Path can find them",
    "--which by default is anything downstream of the workspace folder", 
    "--this file is not meant to be loaded by game/IH",
    "",
  }

  table.insert(hintLines,"--tex just kinda jamming this here for want of place, need to run WriteVars to generate the actual files")
  table.insert(hintLines,[[vars=require"vars"]])
  table.insert(hintLines,[[cvars=require"cvars"]])
  table.insert(hintLines,[[svars=require"svars"]])
  table.insert(hintLines,[[gvars=require"gvars"]])
  table.insert(hintLines,[[mvars=require"mvars"]])

  table.insert(hintLines,"--tex WORKAROUND, IH bootstrap stuff that doesnt go through any SetLoaded/.loadedModules")
  table.insert(hintLines,[[InfCore=require"/Assets/tpp/script/ih/InfCore"]])
  table.insert(hintLines,[[InfInit=require"/Assets/tpp/script/ih/InfInit"]])
  table.insert(hintLines,[[InfInitMain=require"/Assets/tpp/script/ih/InfInitMain"]])

  table.insert(hintLines,"--non base game LoadLibrary")
  for fileName,loadInfo in pairs(InfCore.loadedModules.LoadLibrary)do
    if not manifest_data1_dat.fileList[fileName] and not manifest_data1_dat.fileList["/"..fileName] then--tex 'Tpp/' paths dont have leading slash      
      local line=this.GetRequireLine(fileName)
      table.insert(hintLines,line)
    end
  end--for loadedModules.LoadExternalModule

  if #InfCore.loadedModules.requires>0 then
    table.insert(hintLines,"--requires")
    for fileName,loadInfo in pairs(InfCore.loadedModules.requires)do
      if not manifest_data1_dat.fileList[fileName] and not manifest_data1_dat.fileList["/"..fileName] then--tex 'Tpp/' paths dont have leading slash      
        local line=this.GetRequireLine(fileName)
        table.insert(hintLines,line)
      end
    end--for loadedModules.LoadExternalModule
  end--if .requires

  --tex for ih this is just InfRequiresStart, which itself doesn't really do anything but log its existance
  table.insert(hintLines,"--Tpp.requires")
  for i,fileName in ipairs(Tpp.requires)do
    if not manifest_data1_dat.fileList[fileName]then
      local line=this.GetRequireLine(fileName)
      table.insert(hintLines,line)
    end
  end--for Tpp.requires

  table.insert(hintLines,"--InfModules")
  for i,moduleName in ipairs(InfModules.moduleNames)do
    --REF InfBodyInfo=require"InfBodyInfo"
    local line=moduleName..[[=require"]]..moduleName..[["]]
    table.insert(hintLines,line)
  end--for InfModules

  -- table.insert(hintLines,"--LoadExternalModule")
  -- local modules={}
  -- for moduleName,loadInfo in pairs(InfCore.loadedModules.LoadExternalModule)do
  --   table.insert(modules,moduleName)
  -- end
  -- table.sort(modules)

  -- for i,moduleName in ipairs(module)do
  --   --REF LoadExternalModule paths:
  --   --local externalPath="/Assets/tpp/script/ih/"..moduleName..".lua"    --tex not used?
  --   --local internalPath=InfCore.gamePath..InfCore.modSubPath.."/modules/"..moduleName..".lua"
    
  --   --REF InfBodyInfo=require"InfBodyInfo"
  --   local line=moduleName..[[=require"]]..moduleName..[["]]
  --   table.insert(hintLines,line)
  -- end--for loadedModules.LoadExternalModule

  --InfCore.PrintInspect(hintLines,"ihModuleLines")
  --tex depends where I want to put it. as this function is runtime, at most I can put it in GameDir or GameDir\mod without hardcoding path to put it in a repo dir
  --local savePath=[[C:/Projects/MGS/InfiniteHeaven/tpp/]]
  local savePath=this.outPath..fileName
  InfCore.Log("Writing "..savePath)
  InfCore.WriteStringTable(savePath,hintLines)
end--WriteLoadedModulesVscodeHint

--tex doesn't really need to be written each time, but on the off chance theres a game updated (and manifest luas updated to reflect changes)
--OUT:FILE: GameDir/mod/vscode/vscode_hint-base_game.lua
function this.WriteBaseGameVscodeHint()
  if manifest_data1_dat==nil then
    InfCore.Log("ERROR: WriteBaseGameVscodeHint: manifest_data1_dat module not loaded")
    return
  end

  local fileName="vscode_hint-base_game.lua"
  local hintLines={
    "--"..fileName,
    "--GENERATED: by Debug menu > WriteVscodeHint using manifest_data1_dat, manifest_fpk_combined",
    "--hint file for vscode lua language server extension by sumneko",
    "--this is not acually used in actual IH mod, the vscode lua extension needs a bit of help figuring out what modules are loaded through the games (and IHs) convoluted loading process",
    "--Assumes the files are somewhere downstream of workspace folder, ",
    "--you can hover mouse over path and see if the popup finds the actual file path",
    "--else would have to add to vscode Settings > Lua > Runtime: Path",
    "--downside of not specifiying actual subfolder (ex data1_dat-lua/Assets/bleh) means it will pick up every file of the same name but in diffent folders",
    "--(in the case of IH this might be a base file in data1_dat-lua and externally loaded one I'm kicking around in gamedir-ih/GameDir/mod)",
    "--and I'm not sure how it actually resolves in that case",

  }
  table.insert(hintLines,"--data1_dat-lua")
  for i,filePath in ipairs(manifest_data1_dat.fileList)do
    local line=this.GetRequireLine(filePath)
    table.insert(hintLines,line)
  end--for fileList
  table.insert(hintLines,"--fpk_combined-lua")
  for i,filePath in ipairs(manifest_fpkd_combined.fileList)do
    local line=this.GetRequireLine(filePath)
    table.insert(hintLines,line)
  end--for fileList

  local savePath=this.outPath..fileName
  InfCore.Log("Writing "..savePath)
  InfCore.WriteStringTable(savePath,hintLines)
end--WriteBaseGameVscodeHint

--menu commands
function this.WriteVscodeHint()
  InfCore.Log("InfDebug.WriteVscodeHint")
  this.WriteBaseGameVscodeHint()
  this.WriteLoadedModulesVscodeHint()
end--WriteVscodeHint
function this.WriteVars()
  this.DumpRuntimeVars()
end--WriteVars

this.debug_WriteVscodeHintOnTitle={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.debug_WriteVarsOnSave={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}

this.registerIvars={
  "debug_WriteVscodeHintOnTitle",
  "debug_WriteVarsOnSave",
}

this.registerMenus={
  "debugMenu",
  "debugInMissionMenu",
  "vscodeMenu",
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
    --OFF: TODO: "InfFovaIvars.characterDebugMenu",
    "Ivars.telopMode",--tex TODO move, odd one out, mission/presentation?
    "Ivars.manualMissionCode",
    "Ivars.manualSequence",
  }
}--debugMenu

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
    "Ivars.selectedCp",
    "InfMenuCommands.SetSelectedCpToMarkerObjectCp",
    "InfMenuCommands.SetSelectedCpToMarkerClosestCp",
    "InfMenuCommandsTpp.DEBUG_ShowRevengeConfig",
    "InfFovaIvars.appearanceDebugMenu",
    --OFF: TODO: "InfFovaIvars.characterDebugMenu",
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
    "Ivars.disableKillChildSoldierGameOver",--DEBUGNOW move these
    "Ivars.disableOutOfBoundsChecks",
    "InfMenuCommands.SetAllFriendly",
    "InfMenuCommands.SetAllZombie",
    "InfBossEvent.DEBUG_ToggleBossEvent",
    "InfMenuCommands.ResetStageBlockPosition",
    "InfMenuCommands.SetStageBlockPositionToMarkerClosest",
    "InfMenuCommands.SetStageBlockPositionToFreeCam",
    "InfCamera.ShowFreeCamPosition",
    "InfMenuCommands.ShowPosition",
    "InfMenuCommands.CheckPointSave",
    --"InfMenuCommands.DEBUG_ClearAnnounceLog",
    "Ivars.manualMissionCode",
    "Ivars.manualSequence",

  }
}--debugInMissionMenu

this.vscodeMenu={--tex for want of a better name
  parentRefs={"InfDebug.debugMenu", "InfDebug.debugInMissionMenu"},
  options={
    "Ivars.debug_WriteVscodeHintOnTitle",
    "InfDebug.WriteVscodeHint",
    "Ivars.debug_WriteVarsOnSave",
    "InfDebug.WriteVars",
  }
}

this.langStrings={
  eng={
    vscodeMenu="Vscode menu",
  },
  help={
    eng={
      vscodeMenu="Commands to generate files to support using vscode with a mgsv project.",
      debug_WriteVscodeHintOnTitle="Runs WriteVscodeHint when loading has reached Title",
      WriteVscodeHint="Writes GameDir/mod/vscode/vscode_hint-mod.lua,vscode_hint-base_game.lua , writes a hint files for vscode lua language server extension of mod lua files loaded.",
      debug_WriteVarsOnSave="Runs WriteVars on IH save (which includes close IH menu)",
      WriteVars="Writes vars, svars, gvars, mvars to GameDir/mod/vscode/, for manual perusal or use with vscode",
    },
  },
}--langStrings

return this