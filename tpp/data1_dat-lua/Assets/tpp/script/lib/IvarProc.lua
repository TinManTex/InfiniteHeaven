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
local RESTARTABLE=TppScriptVars.CATEGORY_MISSION_RESTARTABLE--NMC don't know why the vanilla code uses TppDefine.CATEGORY_MISSION_RESTARTABLE and not TppScriptVars.CATEGORY_MISSION_RESTARTABLE
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

function this.IsIvar(ivar)--TYPEID
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
    InfCore.Log("WARNING: SetSetting: self==nil, did you use ivar.Set instead of ivar:Set?",true)
    return
  end
  if type(self)~="table" then
    InfCore.Log("WARNING: SetSetting: self ~= table!",true)
    return
  end
  if self.option then
    InfCore.Log("WARNING: SetSetting called on menu",true)
    return
  end

  local currentSetting=ivars[self.name]
  if currentSetting==nil then
    InfCore.Log("WARNING: SetSetting: ivar setting==nil",true)
    return
  end

  if type(setting)=="string" then
    setting=self.enum[setting]
    if setting==nil then
      InfCore.Log("SetSetting: no setting on "..self.name,true)--DEBUG
      return
    end
  end

  if self.noBounds~=true then
    if setting < self.range.min or setting > self.range.max then
      InfCore.Log("WARNING: SetSetting for "..self.name.." OUT OF BOUNDS",true)
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

  if not this.IsIvar(self) then
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

local mbFreeMissions={[30050]=true,[30150]=true,[30250]=true}
function this.MissionCheckMbAll(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  return mbFreeMissions[missionCode] or false
end

function this.MissionCheckMission(self,missionCode)
  local missionCode=missionCode or vars.missionCode
  local firstDigit=math.floor(missionCode/1e4)
  return firstDigit==1
end

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
  if not missionModes then
    InfCore.Log("IvarProc.MissionModeIvars: ERROR: cannot missionModes for "..tostring(name))
    return
  end

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

function this.GetForMission(ivarList,missionCode)
  local missionId=missionCode or vars.missionCode
  if type(ivarList)=="string" then
    ivarList=Ivars.missionModeIvars[ivarList]
  end
  local passedCheck=false
  for i=1,#ivarList do
    local ivar=ivarList[i]
    if ivar.MissionCheck==nil then
      InfCore.Log("WARNING: GetForMission on "..ivar.name.." which has no MissionCheck func")
    elseif ivar:MissionCheck(missionId) then
      return ivar:Get()
    end
  end
  return 0
end

--tex as above but with ivar>0 check
--ivarList can be missionModeIvar name or ivar list
--GOTCHA: TODO: rename or merge to stop confusion with ivar.EnabledForMission which is set to IvarEnabledForMission
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
    InfCore.Log("WARNING: EnabledForMission on "..self.name.." which has no MissionCheck func")
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
    if this.IsIvar(ivar) then
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
    if this.IsIvar(ivar) then
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

local profileFormat={
  description="string",
  profile="table",
}

--OUT: profileNames,infProfiles
--SIDE: Ivars.profiles
--IN-SIDE: InfCore.files
function this.SetupInfProfiles()
  InfCore.LogFlow"IvarProc.SetupInfProfiles"

  local fileNames=InfCore.GetFileList(InfCore.files.profiles,".lua")

  --InfCore.PrintInspect(fileNames)--DEBUG

  local profiles={}
  local profileNames={}
  for i,fileName in ipairs(fileNames)do
    local profile=InfCore.LoadSimpleModule(InfCore.paths.profiles,fileName,true)
    if profile and profile.profile then
      local profileOk=InfCore.Validate(profileFormat,profile,fileName)
      if profileOk then
        table.insert(profileNames,fileName)
        profiles[fileName]=profile
      end
    end
  end

  --  InfCore.PrintInspect(profileNames)--DEBUG
  --  InfCore.PrintInspect(infProfiles)--DEBUG

  --CULL old single file
  --  local fileName="InfProfiles.lua"
  --  local infProfiles=InfCore.LoadSimpleModule(fileName,nil,true)
  --  if infProfiles==nil then
  --    Ivars.profiles=nil
  --    return nil
  --  end

  table.sort(profileNames)

  local firstProfileCount=0
  for i,profileName in ipairs(profileNames)do
    if profiles[profileName].firstProfile then
      local currentFirst=profileNames[1]
      profileNames[1]=profileName
      profileNames[i]=currentFirst
      firstProfileCount=firstProfileCount+1
    end
  end
  if firstProfileCount>1 then
    InfCore.DebugPrint("WARNING: multiple profiles with firstProfile set")
  end

  return {profileNames,profiles}--WORKAROUND PCall
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

function this.IsForProfile(item)
  if item.nonConfig
    or item.optionType~="OPTION"
    or item.nonUser
    or item.nonConfig
    or item.save==nil
  then
    return false
  end

  return true
end

function this.BuildProfile(onlyNonDefault)
  local profile={}
  for ivarName,ivar in pairs(Ivars)do
    if this.IsIvar(ivar) then
      if this.IsForProfile(ivar) then
        local currentSetting=ivars[ivar.name]
        if not onlyNonDefault or currentSetting~=ivar.default then
          if ivar.settings then
            profile[ivar.name]=ivar.settings[currentSetting+1]
          else
            profile[ivar.name]=currentSetting
          end
        end
      end
    end
  end
  return profile
end


--tex settings range on one line between braces
function this.GetSettingsLine(ivar)
  local settingsLine={}
  if ivar.settings then--tex DEBUGNOW TODO filter dynamic
    table.insert(settingsLine,"{ ")
    for i,setting in ipairs(ivar.settings)do
      table.insert(settingsLine,setting)
      if i~=#ivar.settings then
        table.insert(settingsLine,", ")
      end
    end
    table.insert(settingsLine," }")
  else
    table.insert(settingsLine,"{ ")
    table.insert(settingsLine,ivar.range.min.."-"..ivar.range.max)
    table.insert(settingsLine," }")
  end
  return table.concat(settingsLine)
end

function this.WriteProfile(defaultSlot,onlyNonDefault)
  local dateTime=os.date("%x %X")
  local profile={
    description="User-saved "..dateTime,
    --modVersion=InfCore.modVersion,
    profile=this.BuildProfile(onlyNonDefault),
  }
  --InfCore.PrintInspect(profile)--DEBUG

  local profileName="User_Saved"
  if not defaultSlot then
    profileName=profileName..os.time()
  end

  local ivarNames={}
  for k,v in pairs(profile.profile) do
    ivarNames[#ivarNames+1]=k
  end
  table.sort(ivarNames)

  local lang=InfLang.eng
  local helpLang=InfLang.help.eng

  local saveLineFormatStr="\t\t%s=%s,--%s -- %s -- %s"
  local saveText={}
  saveText[#saveText+1]="local this={"
  saveText[#saveText+1]="\tdescription=\""..profile.description.."\","
  saveText[#saveText+1]="\tprofile={"
  for i,name in ipairs(ivarNames)do
    local ivar=Ivars[name]

    local value=profile.profile[name]
    if value then
      if type(value)=="string"then
        value="\""..value.."\""
      end

      local settingsString=this.GetSettingsLine(ivar)
      local nameLangString=lang[name] or ""
      local helpLangString=helpLang[name] or ""
      local line=string.format(saveLineFormatStr,name,value,settingsString,nameLangString,helpLangString)

      saveText[#saveText+1]=line
    end
  end
  saveText[#saveText+1]="\t}"
  saveText[#saveText+1]="}"
  saveText[#saveText+1]="return this"

  --InfCore.PrintInspect(table.concat(saveText))--DEBUG
  profileName=profileName..".lua"
  if not Ivars.profiles[profileName] then
    table.insert(Ivars.profileNames,1,profileName)
  end
  Ivars.profiles[profileName]=profile
  local profilesFileName=InfCore.paths.profiles..profileName
  --CULL  InfPersistence.Store(InfCore.paths.mod..profilesFileName,Ivars.savedProfiles)
  InfCore.WriteStringTable(profilesFileName,saveText)
end


--IN-Side evars
function this.BuildSaveText(ihVer,inMission,onlyNonDefault,newSave)
  local inMission=inMission or false

  local saveTextList={
    "-- "..InfCore.saveName,
    "-- Save file for IH options",
    "-- While this file is editable, editing an inMission save is likely to cause issues, and it's preferable that you use InfProfiles.lua instead.",
    "-- See Readme for more info",
    "local this={}",
    "this.ihVer="..ihVer,
    "this.saveTime="..os.time(),
    "this.inMission="..tostring(inMission),
    "this.loadToACC=false",
  }

  this.BuildEvarsText(evars,saveTextList,onlyNonDefault)
  this.BuildTableText("igvars",igvars,saveTextList)
  --tex also skips depenancy on InfQuest
  if not newSave then
    if InfQuest then
      local questStates=InfQuest.GetCurrentStates()
      this.BuildTableText("questStates",questStates,saveTextList)
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
    saveTextList[#saveTextList+1]=string.format(saveLineFormatStr,k,tostring(v))
  end
  saveTextList[#saveTextList+1]="}"
end

function this.WriteSave(saveTextLines,saveName)
  local filePath=InfCore.paths.saves..saveName

  local saveFile,openError=io.open(filePath,"w")
  if not saveFile or openError then
    local errorText="WriteEvars: Create save error: "..tostring(openError)
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

  local inHeliSpace=vars.missionCode and math.floor(vars.missionCode/1e4)==4--tex heli missions are in 40k range
  local inMission=inGame and not inHeliSpace

  local saveTextList=this.BuildSaveText(InfCore.modVersion,inMission,onlyNonDefault)
  --InfCore.PrintInspect(evarsTextList)
  this.WriteSave(saveTextList,saveName)
end

function this.LoadSave()
  InfCore.LogFlow"IvarProc.LoadSave"
  local saveName=InfCore.saveName
  local filePath=InfCore.paths.saves..saveName
  local ih_save_chunk,loadError=loadfile(filePath)
  if ih_save_chunk==nil then
    --tex GOTCHA will overwrite a ih_save that exists, but failed to load (ex user edited syntax error)
    --TODO back up exising save in this case
    if not InfCore.ihSaveFirstLoad then
      --tex create
      InfCore.Log("LoadSave: No ih_save.lua found or error, creating new",false,true)
      local saveTextList=this.BuildSaveText(InfCore.modVersion,false,true,true)
      --InfCore.PrintInspect(evarsTextList)
      this.WriteSave(saveTextList,saveName)
      ih_save_chunk,loadError=loadfile(filePath)
    end
  end

  if ih_save_chunk==nil then
    local errorText="LoadSave Error: loadfile error: "..tostring(loadError)
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

--SIDE: ih_save (global module)
function this.LoadEvars()
  InfCore.LogFlow"IvarProc.LoadEvars"
  ih_save=this.LoadSave()
  if ih_save then
    local loadedEvars=this.ReadEvars(ih_save)
    if this.debugModule then
      InfCore.PrintInspect(loadedEvars,{varName="loadedEvars"})
    end
    if loadedEvars then
      for name,value in pairs(loadedEvars) do
        evars[name]=value
      end
    end

    if ih_save.igvars then
      --InfCore.PrintInspect(igvars,"igvars, preload")--DEBUG
      --InfCore.PrintInspect(ih_save.igvars,"ih_save.igvars")--DEBUG
    
      for name,value in pairs(ih_save.igvars) do
        if type(name)=="string" then
          if igvars[name]~=nil and value~=nil then
            if type(value)~=type(igvars[name]) then
              InfCore.Log("WARNING: ih_save igvar "..name.." type does not match")
            else
              igvars[name]=value
            end
          else
            InfCore.Log("LoadEvars could not find igvar "..name)
          end
        end
      end
      --InfCore.PrintInspect(igvars,"igvars, loaded")--DEBUG
    end

    if InfCore.doneStartup and igvars.inf_event==true then
      InfCore.Log("IvarProc.LoadEvars: is mis event, skiping UpdateSettingFromGvar."..vars.missionCode)--DEBUG
    else
      for name,ivar in pairs(Ivars) do
        if this.IsIvar(ivar) then
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
