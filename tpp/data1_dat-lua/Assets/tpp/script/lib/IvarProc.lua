-- DOBUILD: 1
-- IvarProc.lua
-- tex functions for working on Ivars and their associated ivars,evars,gvars
-- STATELESS (except for debugModule)
-- EXECLESS
local this={}

--LOCALOPT
local InfCore=InfCore
local vars=vars
local type=type
local loadfile=loadfile
local tostring=tostring

local GLOBAL=TppScriptVars.CATEGORY_GAME_GLOBAL
local MISSION=TppScriptVars.CATEGORY_MISSION
local RETRY=TppScriptVars.CATEGORY_RETRY
local MB_MANAGEMENT=TppScriptVars.CATEGORY_MB_MANAGEMENT
local QUEST=TppScriptVars.CATEGORY_QUEST
local CONFIG=TppScriptVars.CATEGORY_CONFIG
local RESTARTABLE=TppScriptVars.CATEGORY_MISSION_RESTARTABLE--DEBUGNOW TppDefine.CATEGORY_MISSION_RESTARTABLE
local PERSONAL=TppScriptVars.CATEGORY_PERSONAL

this.debugModule=false

this.CATEGORY_EXTERNAL=1024--tex SYNC Ivars

function this.IsFOBMission(missionCode)
  local firstDigit=math.floor(missionCode/1e4)
  if firstDigit==5 then
    return true
  else
    return false
  end
end

local function IsIvar(ivar)--TYPEID
  return type(ivar)=="table" and ivar.name and (ivar.range or ivars[ivar.name])
end

function this.GetSetting(self)
  return ivars[self.name]
end

--tex TODO bounds checking?
function this.GetSaved(self)
  local gvar=nil
  if self.save then
    if self.save==this.CATEGORY_EXTERNAL then
      gvar=evars[self.name]
    elseif gvars then
      gvar=gvars[self.name]
    end
    if gvar==nil and gvars then
      InfCore.Log("IvarProc.GetSaved: WARNING ivar.save but no gvar found for "..tostring(self.name),true)
    end
  end
  return gvar
end

function this.SetSaved(self,value)
  if value~=nil and self.save then
    if self.save==this.CATEGORY_EXTERNAL then
      evars[self.name]=value
    else
      gvars[self.name]=value
    end
  end
end

--tex currently not used. GOTCHA currently only supports settingsTable as array, see GetTableSetting
function this.GetTableSettingDirect(self,setting)
  if not self.settingsTable then
    InfCore.Log("GetTableSettingDirect no settingsTable for "..self.name)
    return nil
  end

  if not setting then
    setting=ivars[self.name]
  end
  return self.settingsTable[setting+1]
end

--tex return ivars settingsTable setting for setting
this.GetTableSetting=function(self)
  local returnValue=nil
  if self.settingsTable then
    local currentSetting
    if this.IsFOBMission(vars.missionCode) and not self.allowFob then
      currentSetting=self.default
    else
      currentSetting=ivars[self.name]
    end

    local tableSetting
    if #self.settingsTable>0 then
      tableSetting=self.settingsTable[currentSetting+1]
    else
      local settingName=self.settings[currentSetting+1]
      tableSetting=self.settingsTable[settingName]
    end

    if type(tableSetting)=="function" then
      returnValue=tableSetting()
    else
      returnValue=tableSetting
    end
  end
  return returnValue
end

function this.GetSettingNameDirect(self,setting)
  if not self.settings then
    InfCore.Log("GetSettingNameDirect no settings for "..self.name)
    return nil
  end

  if not setting then
    setting=ivars[self.name]
  end
  return self.settings[setting+1]
end

function this.GetSettingName(self,setting)
  if not self.settings then
    InfCore.Log("GetSettingName no settings for "..self.name)
    return nil
  end

  if not setting then
    setting=self:Get()
  end
  return self.settings[setting+1]
end

function this.SetDirect(self,setting)
  ivars[self.name]=setting
end

function this.SetSetting(self,setting,noSave)
  --InfCore.DebugPrint("Ivars.SetSetting "..self.name.." "..setting)--DEBUG
  if self==nil then
    InfCore.DebugPrint("WARNING: SetSetting: self==nil, did you use ivar.Set instead of ivar:Set?")
    return
  end
  if type(self)~="table" then
    InfCore.DebugPrint("WARNING: SetSetting: self ~= table!")
    return
  end
  if self.option then
    InfCore.DebugPrint("WARNING: SetSetting called on menu")
    return
  end

  local currentSetting=ivars[self.name]
  if currentSetting==nil then
    InfCore.DebugPrint("WARNING: SetSetting: ivar setting==nil")
    return
  end

  if type(setting)=="string" then
    setting=self.enum[setting]
    if setting==nil then
      TppUiCommand.AnnounceLogView("SetSetting: no setting on "..self.name)--DEBUG
      return
    end
  end

  if self.noBounds~=true then
    if setting < self.range.min or setting > self.range.max then
      TppUiCommand.AnnounceLogView("WARNING: SetSetting for "..self.name.." OUT OF BOUNDS")
      return
    end
  end
  --InfCore.DebugPrint("Ivars.SetSetting "..self.name.." "..setting)--DEBUG
  local prevSetting=currentSetting
  ivars[self.name]=setting
  if self.save and not noSave then
    local gvar=this.GetSaved(self)
    if gvar~=nil then
      this.SetSaved(self,setting)
    end
  end
  if self.OnChange then
    --InfCore.Log("SetSetting OnChange for "..self.name)--DEBUG
    InfCore.PCallDebug(self.OnChange,self,prevSetting,setting)
  end
end

function this.ResetSetting(self,noSave)
  this.SetSetting(self,self.default,noSave)
end

this.OptionIsDefault=function(self)
  local currentSetting
  if this.IsFOBMission(vars.missionCode) and not self.allowFob then
    currentSetting=self.default
  else
    currentSetting=ivars[self.name]
  end

  return currentSetting==self.default
end

local type=type
local numberType="number"
--tex NOTE: returns currentsetting if no setting given
this.OptionIsSetting=function(self,setting)
  if self==nil then
    InfCore.DebugPrint("WARNING OptionIsSetting self==nil, Is or Get called with . instead of :")
    return
  end

  if not IsIvar(self) then
    InfCore.DebugPrint("self not Ivar. Is or Get called with . instead of :")
    return
  end

  local currentSetting
  if this.IsFOBMission(vars.missionCode) and not self.allowFob then
    currentSetting=self.default
  else
    currentSetting=ivars[self.name]
  end

  if setting==nil then
    return currentSetting
  elseif type(setting)==numberType then
    return setting==currentSetting
  end

  if self.enum==nil then
    InfCore.DebugPrint("Is function called on ivar "..self.name.." which has no settings enum")
    return false
  end

  local settingIndex=self.enum[setting]
  if settingIndex==nil then
    InfCore.DebugPrint("WARNING ivar "..self.name.." has no setting named "..tostring(setting))
    return false
  end
  return settingIndex==currentSetting
end

this.OnChangeProfile=function(self,previousSetting,setting)
  local returnValue=nil
  local currentSetting=setting or ivars[self.name]
  if self.settingsTable then
    local settingName=self.settings[currentSetting+1]
    local settingTable=self.settingsTable[settingName]

    if type(settingTable)=="function" then
      returnValue=settingTable()
    elseif type(settingTable)=="table" then
      this.ApplyProfile(settingTable)
    end
  end
  return returnValue
end

--paired min/max ivar setup
local minSuffix="_MIN"
local maxSuffix="_MAX"
function this.PushMax(ivar)
  local maxName=ivar.subName..maxSuffix
  local currentSetting=ivars[ivar.name]
  if currentSetting>ivars[maxName] then
    Ivars[maxName]:Set(currentSetting)
  end
end
function this.PushMin(ivar)
  local minName=ivar.subName..minSuffix
  local currentSetting=ivars[ivar.name]
  if currentSetting<ivars[minName] then
    Ivars[minName]:Set(currentSetting)
  end
end
--tex creates someIvarName_MIN,someIvarName_MAX
--and adds them to Ivars
--IvarProc.MinMaxIvar(
--  Ivars,
--  "someIvarName",
--  {default=3},
--  {default=15},
--  {
--    range={min=1,max=15}
--  },
--)
--OUT: Ivars
--tex
function this.MinMaxIvar(Ivars,name,minSettings,maxSettings,ivarSettings,dontSetIvars)
  local ivarMin={
    subName=name,
    save=this.CATEGORY_EXTERNAL,
    OnChange=this.PushMax,
  }
  local ivarMax={
    subName=name,
    save=this.CATEGORY_EXTERNAL,
    OnChange=this.PushMin,
  }

  for k,v in pairs(minSettings) do
    ivarMin[k]=v
  end

  for k,v in pairs(maxSettings) do
    ivarMax[k]=v
  end

  for k,v in pairs(ivarSettings) do
    ivarMin[k]=v
    ivarMax[k]=v
  end

  if not dontSetIvars then
    Ivars[name..minSuffix]=ivarMin
    Ivars[name..maxSuffix]=ivarMax
  end
  return {
    [name..minSuffix]=ivarMin,
    [name..maxSuffix]=ivarMax
  }
end

function this.MissionCheckAll()
  return true
end

function this.MissionCheckFree(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  if missionCode==30010 or missionCode==30020 then
    return true
  end
  return false
end

function this.MissionCheckMb(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  return missionCode==30050
end

function this.MissionCheckMbqf(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  return missionCode==30250
end

function this.MissionCheckMbAll(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  if TppMission.IsMbFreeMissions(missionCode) then--DEBUGNOW dependancy
    return true
  end
  return false
end

function this.MissionCheckMission(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  if TppMission.IsStoryMission(missionCode) then--tex DEBUGNOW DEPENDANCY TppMission, TODO: check if missioncheck (ivar .MissionCheck :MissionCheck) are used in normal use of ivars (ie so cant be used when IvarProc shifter to init.lua/before TppDefine.requires modules)
    return true
  end
  return false
end

this.missionModesAll={
  "FREE",
  "MISSION",
  "MB",
}
local missionModeChecks={
  FREE=this.MissionCheckFree,
  MISSION=this.MissionCheckMission,
  MB=this.MissionCheckMb,
  MB_ALL=this.MissionCheckMbAll,
}
--tex Creates <ivarName><missionMode> ex someIvarNameMB,someIvarNameFREE
--and adds them to Ivars, as well as Ivars.missionModeIvars for IsForMission,EnabledForMission support
--USAGE
--IvarProc.MissionModeIvars(
--  Ivars,
--  "someIvarName",
--  {
--    save=EXTERNAL,
--    range=this.switchRange,
--    settingNames="set_switch",
--  },
--  {"FREE","MISSION",},
--)
--OUT: Ivars
function this.MissionModeIvars(Ivars,name,ivarDefine,missionModes)
  for i,missionMode in ipairs(missionModes)do
    local ivar={}
    for k,v in pairs(ivarDefine) do
      ivar[k]=v
    end

    ivar.MissionCheck=missionModeChecks[missionMode]
    local fullName=name..missionMode
    Ivars[fullName]=ivar

    --tex used by IsForMission/EnabledForMission
    Ivars.missionModeIvars[name]=Ivars.missionModeIvars[name] or {}
    Ivars.missionModeIvars[name][#Ivars.missionModeIvars[name]+1]=ivar--insert
  end
end

--tex ivarList can be missionModeIvar name or ivar list
function this.IsForMission(ivarList,setting,missionCode)
  local missionId=missionCode or vars.missionCode
  if type(ivarList)=="string" then
    ivarList=Ivars.missionModeIvars[ivarList]
  end
  local passedCheck=false
  for i=1,#ivarList do
    local ivar=ivarList[i]
    if ivar.MissionCheck==nil then
      InfCore.Log("WARNING: IsForMission on "..ivar.name.." which has no MissionCheck func")
    elseif ivar:Is(setting) and ivar:MissionCheck(missionId) then
      passedCheck=true
      break
    end
  end
  return passedCheck
end

--tex as above but with ivar>0 check
--ivarList can be missionModeIvar name or ivar list
function this.EnabledForMission(ivarList,missionCode)
  local missionId=missionCode or vars.missionCode
  if type(ivarList)=="string" then
    local name=ivarList
    ivarList=Ivars.missionModeIvars[ivarList]
    if ivarList==nil then
      InfCore.Log("EnabledForMission cannot find missionModeIvars:"..tostring(name))
      return false
    end
  end

  local passedCheck=false
  for i=1,#ivarList do
    local ivar=ivarList[i]
    if ivar.MissionCheck==nil then
      InfCore.Log("WARNING: EnabledFoMission on "..ivar.name.." which has no MissionCheck func")
    elseif ivar:Is()>0 and ivar:MissionCheck(missionId) then
      passedCheck=true
      break
    end
  end
  return passedCheck
end

function this.IvarEnabledForMission(self,missionCode)
  local missionId=missionCode or vars.missionCode
  if self.MissionCheck==nil then
    InfCore.Log("WARNING: EnabledFoMission on "..self.name.." which has no MissionCheck func")
    return false
  end
  return self:Is()>0 and self:MissionCheck(missionId)
end

--
function this.ApplyProfile(profile,noSave)
  InfCore.LogFlow"IvarProc.ApplyProfile"
  local random=math.random
  local type=type
  local tableType="table"
  local stringType="string"

  for ivarName,setting in pairs(profile)do
    if type(setting)==tableType then
      if setting[1]==stringType then
        --tex setting=={"SOMESETTINGNAME",...}
        setting=setting[random(#setting)]
      else
        --tex setting=={<minnum>,<maxnum>}
        setting=random(setting[1],setting[2])
      end
    end
    Ivars[ivarName]:Set(setting,noSave)
  end
end
function this.ResetProfile(profile)
  for i,ivarName in ipairs(profile) do
    local ivar=Ivars[ivarName]
    if ivar==nil then
      InfCore.DebugPrint("WARNING: ResetProfile cant find ivar "..ivarName)
    else
      ivar:Reset()
    end
  end
end

this.UpdateSettingFromGvar=function(option)
  if option.save then
    local gvar=this.GetSaved(option)
    if gvar~=nil then
      ivars[option.name]=gvar
    end
  end
end

--CALLER: TppSave.DoSave > InfMain.OnSave (via InfHooks)
function this.OnSave()
  InfCore.PCallDebug(this.SaveEvars)
end

--CALLER: TppSave.VarRestoreOnMissionStart and VarRestoreOnContinueFromCheckPoint (via InfHooks)
function this.OnLoadVarsFromSlot()
  InfCore.PCallDebug(this.LoadEvars)
end

--debug stuff
--tex only catches save vars
function this.PrintNonDefaultVars()
  local varTable=Ivars.DeclareVars()
  if varTable==nil then
    InfCore.DebugPrint("varTable not found")
    return
  end

  for name,value in pairs(evars) do
    local default=Ivars[name].default
    if value~=default then
      InfCore.DebugPrint("DEBUG: "..name.." current value "..value.." is not default "..default)
    end
  end
end

function this.PrintGvarSettingMismatch()
  --InfCore.PCall(function()--DEBUG
  for name,ivar in pairs(Ivars) do
    if IsIvar(ivar) then
      local gvar=this.GetSaved(ivar)
      if gvar~=nil then
        if ivars[ivar.name]~=gvar then
          InfCore.Log("WARNING: ivar setting/gvar mismatch for "..name,true)
          InfCore.Log("setting:"..tostring(ivars[ivar.name]).." gvar value:"..tostring(gvar),true)
        end
      end
    end
  end
  --end)--
end

--tex TODO update to catch evars
function this.PrintSaveVarCount()
  local varTable=Ivars.DeclareVars()
  if varTable==nil then
    InfCore.DebugPrint("varTable not found")
    return
  end

  local gvarCountCount=0
  for n,gvarInfo in pairs(varTable) do
    local gvar=gvars[gvarInfo.name]
    if gvar==nil then
      InfCore.DebugPrint("WARNING ".. gvarInfo.name.." has no gvar")
    else
      gvarCountCount=gvarCountCount+1
    end
  end
  InfCore.DebugPrint("Ivar gvar count:"..gvarCountCount.." "..#varTable)

  local bools=0
  for name, ivar in pairs(Ivars) do
    if IsIvar(ivar) then
      if ivar.save then
        if ivar.range.max==1 then
          bools=bools+1
        end
      end
    end
  end
  InfCore.DebugPrint("potential ivar bools:"..bools)

  local scriptVarTypes={
    [TppScriptVars.TYPE_BOOL]="TYPE_BOOL",
    [TppScriptVars.TYPE_UINT8]="TYPE_UINT8",
    [TppScriptVars.TYPE_INT8]="TYPE_INT8",
    [TppScriptVars.TYPE_UINT16]="TYPE_UINT16",
    [TppScriptVars.TYPE_INT16]="TYPE_INT16",
    [TppScriptVars.TYPE_UINT32]="TYPE_UINT32",
    [TppScriptVars.TYPE_INT32]="TYPE_INT32",
    [TppScriptVars.TYPE_FLOAT]="TYPE_FLOAT",
  }

  local function CountVarTable(scriptVarTypes,varTable,category)
    local totalCount=0
    local typeCounts={}
    local totalCountArray=0
    local arrayCounts={}
    for scriptVarType, typeName in pairs(scriptVarTypes) do
      typeCounts[typeName]=0
      arrayCounts[typeName]=0
    end

    for n, gvarInfo in pairs(varTable)do
      if category==nil or gvarInfo.category==category then
        local scriptVarTypeName=scriptVarTypes[gvarInfo.type]
        typeCounts[scriptVarTypeName]=typeCounts[scriptVarTypeName]+1

        local count=gvarInfo.arraySize or 1
        if count==0 then count=1 end
        --if Tpp.IsTypeNumber(gvarInfo.arraySize) then
        arrayCounts[scriptVarTypeName]=arrayCounts[scriptVarTypeName]+count
        --end
        totalCount=totalCount+1
        totalCountArray=totalCountArray+count
      end
    end
    return typeCounts,arrayCounts,totalCount,totalCountArray
  end

  InfCore.DebugPrint"NOTE: these are CATEGORY_MISSION counts"

  InfCore.DebugPrint"Ivars.varTable"
  local ivarTable=Ivars.DeclareVars()
  local typeCounts,arrayCounts,totalCount,totalCountArray=CountVarTable(scriptVarTypes,ivarTable,TppScriptVars.CATEGORY_MISSION)

  InfCore.DebugPrint"typeCounts"
  InfCore.PrintInspect(typeCounts)

  InfCore.DebugPrint"arrayCounts"
  InfCore.PrintInspect(arrayCounts)

  InfCore.DebugPrint("totalcount:"..totalCount.." totalcountarray:"..totalCountArray)



  --  InfCore.PrintInspect(TppScriptVars)

  --  local categories={
  --    [TppScriptVars.CATEGORY_NONE]="CATEGORY_NONE",
  --    [TppScriptVars.CATEGORY_GAME_GLOBAL]="CATEGORY_GAME_GLOBAL",
  --    [TppScriptVars.CATEGORY_MISSION]="CATEGORY_MISSION",
  --    [TppScriptVars.CATEGORY_RETRY]="CATEGORY_RETRY",
  --    [TppScriptVars.CATEGORY_MB_MANAGEMENT]="CATEGORY_MB_MANAGEMENT",
  --    [TppScriptVars.CATEGORY_QUEST]="CATEGORY_QUEST",
  --    [TppScriptVars.CATEGORY_CONFIG]="CATEGORY_CONFIG",
  --    --[TppDefine.CATEGORY_MISSION_RESTARTABLE]="TppDefine CATEGORY_MISSION_RESTARTABLE",
  --    [TppScriptVars.CATEGORY_MISSION_RESTARTABLE]="CATEGORY_MISSION_RESTARTABLE",
  --    [TppScriptVars.CATEGORY_PERSONAL]="CATEGORY_PERSONAL",
  --    --[TppScriptVars.CATEGORY_MGO]="CATEGORY_MGO",
  --    [TppScriptVars.CATEGORY_ALL]="CATEGORY_ALL",
  --  }

  --  for categoryType, categoryName in pairs(categories) do
  --    InfCore.DebugPrint(categoryName..":"..tostring(categoryType))
  --  end

  InfCore.DebugPrint"TppGVars.DeclareGVarsTable"
  local typeCounts,arrayCounts,totalCount,totalCountArray=CountVarTable(scriptVarTypes,TppGVars.DeclareGVarsTable,TppScriptVars.CATEGORY_MISSION)

  InfCore.DebugPrint"typeCounts"
  InfCore.PrintInspect(typeCounts)

  InfCore.DebugPrint"arrayCounts"
  InfCore.PrintInspect(arrayCounts)

  InfCore.DebugPrint("totalcount:"..totalCount.." totalcountarray:"..totalCountArray)

  InfCore.DebugPrint"TppMain.allSvars"
  local typeCounts,arrayCounts,totalCount,totalCountArray=CountVarTable(scriptVarTypes,TppMain.allSvars,TppScriptVars.CATEGORY_MISSION)
  InfCore.DebugPrint"typeCounts"
  InfCore.PrintInspect(typeCounts)

  InfCore.DebugPrint"arrayCounts"
  InfCore.PrintInspect(arrayCounts)

  InfCore.DebugPrint("totalcount:"..totalCount.." totalcountarray:"..totalCountArray)

  --    InfCore.PrintInspect(TppMain.allSvars)
end

--IN: FILE: InfProfiles.lua
--OUT: profileNames
--SIDE: Ivars.profiles
function this.SetupInfProfiles()
  InfCore.LogFlow"IvarProc.SetupInfProfiles"
  --tex TODO: just can't seem to assign a loaded module to Global for some reason, works fine in external VM, and works fine at end of InfMain
  --InfProfiles=require"InfProfiles"--
  --  local infProfiles=require"InfProfiles"
  --    if infProfiles then
  --      --_G["InfProfiles"]=infProfiles
  --      InfProfiles=infProfiles
  --      InfCore.PrintInspect(InfProfiles)
  --    end
  --  InfCore.PrintInspect(InfProfiles)

  local fileName="InfProfiles.lua"
  local infProfiles=InfCore.LoadBoxed(fileName)
  if infProfiles==nil then
    Ivars.profiles=nil
    return nil
  end

  local profileNames={}
  for profileName,profileInfo in pairs(infProfiles)do
    if type(profileName)=="string" then
      if type(profileInfo)=="table" then
        if not profileInfo.profile then
          InfCore.DebugPrint("WARNING: profile on "..tostring(profileName).." is nil",true)
        else
          if type(profileInfo)=="table" then
            --tex ok
            table.insert(profileNames,profileName)
            profileInfo.name=profileName
          else
            InfCore.Log("WARNING: profile on "..tostring(profileName).." is not a table",true)
          end
        end
      else
        InfCore.Log("WARNING: profileInfo for "..tostring(profileName).." is not a table",true)
      end
    else
      InfCore.Log("WARNING: profileName is not a string:"..tostring(profileName),true)
    end
  end

  table.sort(profileNames)

  local firstProfileCount=0
  for i,profileName in ipairs(profileNames)do
    if infProfiles[profileName].firstProfile then
      local currentFirst=profileNames[1]
      profileNames[1]=profileName
      profileNames[i]=currentFirst
      firstProfileCount=firstProfileCount+1
    end
  end
  if firstProfileCount>1 then
    InfCore.DebugPrint("WARNING: multiple profiles with firstProfile set")
  end

  Ivars.profiles=infProfiles
  return profileNames
end

function this.ApplyInfProfiles(profileNames)
  if not Ivars.profiles or profileNames==nil then
    InfCore.Log"ApplyInfProfiles: profileNames==nil"--DEBUG
    return
  else
    for i,profileName in ipairs(profileNames)do
      local profileInfo=Ivars.profiles[profileName]
      if profileInfo.loadOnACCStart then
        local profileName=profileInfo.description or profileName
        InfMenu.Print(InfMenu.LangString"applying_profile".." "..profileName)
        InfCore.Log("Applying profile "..profileName)
        IvarProc.ApplyProfile(profileInfo.profile)
      end
    end
  end
end


local function IsForProfile(item)
  if item.nonConfig
    or item.optionType~="OPTION"
    or item.nonUser
  then
    return false
  end
  return true
end

function this.BuildProfile(onlyNonDefault)
  local profile={}
  for ivarName,ivar in pairs(Ivars)do
    if IsIvar(ivar) then
      if IsForProfile(ivar) then
        local currentSetting=ivars[ivar.name]
        if not onlyNonDefault or currentSetting~=ivar.default then
          profile[ivar.name]=currentSetting
        end
      end
    end
  end
  return profile
end

function this.WriteProfile(defaultSlot,onlyNonDefault)
  local dateTime=os.date("%x %X")
  local profile={
    description="Saved profile "..dateTime,
    modVersion=InfCore.modVersion,
    profile=this.BuildProfile(onlyNonDefault),
  }
  --InfCore.PrintInspect(profile)--DEBUGN

  local profileName="savedProfile"
  if not defaultSlot then
    profileName="savedProfile"..os.time()
  end
  Ivars.savedProfiles[profileName]=profile

  local profilesFileName="InfSavedProfiles.lua"
  InfPersistence.Store(InfCore.modPath..profilesFileName,Ivars.savedProfiles)
end


--IN-Side evars,InfQuest.installedQuests
function this.BuildSaveText(ihVer,inMission,onlyNonDefault,newSave)
  local inMission=inMission or false

  local saveTextList={
    "-- "..InfCore.saveName,
    "-- Save file for IH options",
    "-- While this file is editable, editing an inMission save is likely to cause issues.",
    "-- See Readme for more info",
    "local this={}",
    "this.ihVer="..ihVer,
    "this.saveTime="..os.time(),
    "this.inMission="..tostring(inMission),
  }

  this.BuildEvarsText(evars,saveTextList,onlyNonDefault)
  --tex also skips depenancy on InfQuest
  if not newSave then
    if InfQuest then
      this.BuildTableText("installedQuests",InfQuest.installedQuests,saveTextList)
    end
  end

  saveTextList[#saveTextList+1]="return this"

  return saveTextList
end

--IN/OUT saveTextList
local evarLineFormatStr="\t%s=%g,"
function this.BuildEvarsText(evars,saveTextList,onlyNonDefault)
  saveTextList[#saveTextList+1]="this.evars={"
  for name,value in pairs(evars)do
    local ivar=Ivars[name]
    if not onlyNonDefault or value~=ivar.default then
      if ivar and ivar.save and ivar.save==this.CATEGORY_EXTERNAL then
        saveTextList[#saveTextList+1]=string.format(evarLineFormatStr,name,value)
      end
    end
  end
  saveTextList[#saveTextList+1]="}"
end

local saveLineFormatStr="\t%s=%s,"
function this.BuildTableText(tableName,sourceTable,saveTextList)
  saveTextList[#saveTextList+1]="this."..tableName.."={"
  for k,v in pairs(sourceTable)do
    saveTextList[#saveTextList+1]=string.format(saveLineFormatStr,k,v)
  end
  saveTextList[#saveTextList+1]="}"
end

function this.WriteSave(saveTextLines,saveName)
  local filePath=InfCore.modPath..saveName

  local saveFile,error=io.open(filePath,"w")
  if not saveFile or error then
    local errorText="WriteEvars: Create save error: "..tostring(error)
    InfCore.DebugPrint(errorText)
    InfCore.Log(errorText)
    return
  end

  saveFile:write(table.concat(saveTextLines,"\r\n"))
  saveFile:close()
end

local typeString="string"
local typeNumber="number"
local typeFunction="function"
local typeTable="table"
--tex validates loadfiled module and returns table of just evars
function this.ReadEvars(ih_save)
  if ih_save==nil then
    local errorText="ReadEvars Error: ih_save==nil"
    InfCore.Log(errorText,true,true)
    return
  end

  if type(ih_save.evars)~=typeTable then
    local errorText="ReadEvars Error: ih_save.evars~=typeTable"
    InfCore.Log(errorText,true,true)
    return
  end

  local loadedEvars={}
  for name,value in pairs(ih_save.evars) do
    if type(name)~=typeString then
      InfCore.Log("ReadEvars ih_save: name~=string:"..tostring(name),false,true)
    else
      if type(value)~=typeNumber then
        InfCore.Log("ReadEvars ih_save: value~=number: "..name.."="..tostring(value),false,true)
      elseif ivars and ivars[name]==nil then
        InfCore.Log("ReadEvars ih_save: cannot find ivar for evar "..name,false,true)
      else
        loadedEvars[name]=value
      end
    end
  end
  return loadedEvars
end

function this.SaveEvars()
  InfCore.LogFlow"SaveEvars"
  local saveName=InfCore.saveName
  local onlyNonDefault=true

  --tex TODO: figure out some last-know good method and write a backup

  local inGame=not mvars.mis_missionStateIsNotInGame
  local inHeliSpace=vars.missionCode and TppMission.IsHelicopterSpace(vars.missionCode)--DEBUGNOW dependance
  local inMission=inGame and not inHeliSpace

  local saveTextList=this.BuildSaveText(InfCore.modVersion,inMission,onlyNonDefault)
  --InfCore.PrintInspect(evarsTextList)
  this.WriteSave(saveTextList,saveName)
end

function this.LoadSave()
  InfCore.LogFlow"IvarProc.LoadSave"
  local saveName=InfCore.saveName
  local filePath=InfCore.modPath..saveName
  local ih_save_chunk,error=loadfile(filePath)
  if ih_save_chunk==nil then
    --tex GOTCHA will overwrite a ih_save that exists, but failed to load (ex user edited syntax error)
    --TODO back up exising save in this case
    if not InfCore.ihSaveFirstLoad then
      --tex create
      InfCore.Log("LoadSave: No ih_save.lua found or error, creating new",false,true)
      local saveTextList=this.BuildSaveText(InfCore.modVersion,false,true,true)
      --InfCore.PrintInspect(evarsTextList)
      this.WriteSave(saveTextList,saveName)
      ih_save_chunk,error=loadfile(filePath)
    end
  end

  if ih_save_chunk==nil then
    local errorText="LoadSave Error: loadfile error: "..tostring(error)
    InfCore.Log(errorText,true,true)
    return nil
  end

  local sandboxEnv={}
  setfenv(ih_save_chunk,sandboxEnv)
  local ih_save=ih_save_chunk()

  if ih_save==nil then
    local errorText="LoadSave Error: ih_save==nil"
    InfCore.Log(errorText,true,true)

    return nil
  end

  if type(ih_save)~="table"then
    local errorText="LoadSave Error: ih_save==table"
    InfCore.Log(errorText,true,true)

    return nil
  end

  return ih_save
end

function this.LoadEvars()
  InfCore.LogFlow"IvarProc.LoadEvars"
  local ih_save=this.LoadSave()
  if ih_save then
    local loadedEvars=this.ReadEvars(ih_save)
    if this.debugModule then
      InfCore.PrintInspect(loadedEvars)
    end
    if loadedEvars then
      for name,value in pairs(loadedEvars) do
        evars[name]=value
      end
    end

    if gvars and Ivars.inf_event:Is()>0 then
      InfCore.Log("IvarProc.LoadEvars: is mis event, skiping UpdateSettingFromGvar."..vars.missionCode)--DEBUG
    else
      for name,ivar in pairs(Ivars) do
        if IsIvar(ivar) then
          this.UpdateSettingFromGvar(ivar)
        end
      end
    end

    InfCore.OnLoadEvars()
    if InfMain then
      InfMain.OnLoadEvars()
    end
  end
end

return this
