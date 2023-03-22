--InfEmblem.lua
--tex implements saving and loading of emblems to/from mgs_tpp\mod\emblems
--only actually refreshes/loads from \emblems on startup (or script reload),
--otherwise just works on the loaded
--TODO: add info.description for settingName
local this={}

this.infosPath="emblems"
this.saveName="emblem"
this.infoType="EMBLEM"

this.varsInfo={
  --[varName]=arraySize,--REF values
  emblemColorH=4,--{[0] = 1842204, 4046562, 0, 0,},
  emblemColorL=4,--{[0] = 7355937, 0, 1605275, 1605275, },
  emblemRotate=4,--{[0] = 0, 0, 16, 0,
  emblemScale=4,--{[0] = 12, 12, 18, 13,
  --  emblemSyncFailed=1,--0,
  --  emblemSyncFailed2=1,--0,
  emblemTextureTag=4,--{[0] = 121979538, -255272731, 34, 514211224,
  --  emblemVersion=1,-- 1,
  emblemX=4,--{[0] = 10, 10, -54, 17,
  emblemY=4,--{[0] = 2, 2, 20, 45,
  --tex not sure, possibly emblem unlock?
  --emblemFlag=680,--{[0] = 4, 4, 4, 4, 5, 4, 5, 5, 5, 5, 5, 5, 4, 5, 4, 4, 4, 4, 4, 4, 5, 5, 4, 5, 5, 5, 1, 5, 6, 5, 1, 4, 5, 5, 1, 6, 6, 4, 2, 4, 4, 4, 5, 4, 2, 6, 2, 5, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 5, 4, 4, 4, 4, 4, 4, 4, 2, 0, 5, 4, 2, 2, 5, 4, 1, 2, 5, 5, 4, 4, 4, 5, 2, 5, 5, 4, 0, 5, 4, 4, 4, 5, 4, 4, 0, 4, 4, 4, 0, 5, 1, 4, 5, 1, 5, 6, 5, 4, 4, 4, 4, 2, 4, 5, 5, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 4, 4, 5, 4, 4, 4, 5, 5, 2, 1, 4, 5, 1, 2, 5, 5, 4, 1, 5, 5, 5, 1, 4, 5, 4, 1, 5, 4, 4, 6, 4, 5, 5, 1, 4, 4, 4, 4, 4, 4, 5, 6, 4, 6, 2, 4, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 2, 0, 4, 4, 4, 2, 6, 4, 4, 4, 2, 4, 6, 4, 4, 1, 1, 4, 4, 1, 4, 4, 2, 4, 4, 2, 4, 4, 4, 2, 4, 4, 4, 2, 2, 4, 4, 4, 4, 4, 4, 4, 2, 1, 4, 1, 2, 1, 5, 1, 4, 4, 2, 4, 4, 6, 2, 2, 4, 6, 4, 2, 4, 4, 4, 4, 2, 4, 6, 4, 2, 6, 2, 4, 0, 4, 6, 2, 4, 2, 6, 6, 6, 6, 2, 6, 2, 6, 2, 4, 4, 4, 4, 2, 4, 4, 4, 4, 2, 6, 4, 4, 5, 6, 2, 4, 4, 4, 4, 2, 2, 4, 6, 4, 4, 4, 4, 6, 4, 4, 6, 2, 4, 4, 4, 4, 4, 2, 2, 4, 1, 2, 2, 4, 4, 2, 2, 4, 4, 4, 0, 4, 0, 0, 4, 4, 4, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 2, 4, 6, 2, 4, 0, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0, 4, 1, 1, 1, 1, 1, 1, 1, 0, 4, 4, 0, 0, 2, 4, 2, 4, 4, 2, 4, 4, 4, 4, 4, 4, 2, 2, 2, 4, 4, 4, 1, 4, 4, 1, 4, 2, 4, 4, 4, 4, 1, 1, 4, 1, 4, 6, 2, 6, 6, 6, 6, 2, 1, 6, 6, 6, 6, 6, 6, 2, 1, 6, 6, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 5, 4, 4, 5, 4, 4, 4, 5, 5, 6, 5, 6, 5, 5, 6, 5, 5, 4, 5, 5, 5, 5, 1, 6, 5, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
}--varsInfo

this.infos={}
this.names={}

function this.PostAllModulesLoad(isReload)
  if isReload then
    this.LoadLibraries()
  end
end--PostAllModulesLoad
function this.LoadLibraries()
  InfUtil.ClearArray(this.names)
  local infoFiles=InfCore.GetFileList(InfCore.files[this.infosPath],".lua")
  for i,fileName in ipairs(infoFiles)do
    InfCore.Log("LoadLibraries "..fileName)
    local name=InfUtil.StripExt(fileName)
    local module=InfCore.LoadSimpleModule(InfCore.paths[this.infosPath],fileName)
    if module==nil then
    --tex LoadSimpleModule should give the error
    else
      --TODO VALIDATE
      this.infos[name]=module
      table.insert(this.names,name)
    end--if module
  end--for emblemFiles

  for name,info in pairs(this.infos)do

  end--for infos
  if this.debugModule then
    InfCore.PrintInspect(this.infos,"InfEmblem infos")
  end
end--LoadLibraries
function this.BuildSaveText(saveName,infoType,info)
  InfCore.PrintInspect(info,"BuildSaveText "..infoType)--DEBUGNOW
  local saveTextList={
    "-- "..saveName,
    "-- ",
    "local this={",
  }
  table.insert(saveTextList,'\tinfoType="'..infoType..'",')

  for varName,value in pairs(info)do
    if type(value)=="table"then
      saveTextList[#saveTextList+1]='\t'..varName..'={'..table.concat(value,',')..'},'
    elseif type(value)=="string"then
      saveTextList[#saveTextList+1]='\t'..varName..'="'..value..'",'
    else
      saveTextList[#saveTextList+1]='\t'..varName..'='..value..','
    end
  end

  saveTextList[#saveTextList+1]="}--this"
  saveTextList[#saveTextList+1]="return this"

  return saveTextList
end--BuildSaveText
function this.VarsToInfo()
  local info={}
  for varName,varSize in pairs(this.varsInfo)do
    if varSize>1 then
      local array={}
      for j=0,varSize-1 do--tex vars 0 indexed
        table.insert(array,vars[varName][j])
      end
      info[varName]=array
    else
      info[varName]=vars[varName]
    end--if varSize
  end--for varsInfo
  return info
end--VarsToInfo
function this.SaveVars(saveName,infoType)
  InfCore.LogFlow"InfEmblem.SaveVars"

  InfUtil.InsertUniqueInList(this.names,saveName)
  local info=this.VarsToInfo()
  this.infos[saveName]=info

  local saveTextList=this.BuildSaveText(saveName,infoType,info)
  local fileName=InfCore.paths[this.infosPath]..saveName..".lua"
  InfCore.WriteStringTable(fileName,saveTextList)
end--SaveVars
function this.LoadVars(saveName)
  local info=this.infos[saveName]
  for varName,value in pairs(info)do
    if type(value)=="table"then
      for i,avalue in ipairs(value)do
        vars[varName][i-1]=avalue--tex shift from lua 1 indexed to vars 0 indexed
      end
    else
      vars[varName]=value
    end--if table
  end--for info

  --DEBUGNOW CULL
  --  local module,err=InfCore.LoadSimpleModule(InfCore.paths.emblems,saveName)
  --  if module==nil then
  --    InfCore.Log("ERROR: InfEmblem.LoadVars: could not load emblems\\"..saveName,true,true)
  --    return
  --  end
  --  for varName,varSize in pairs(this.varsInfo)do
  --    if varSize>1 then
  --      for j=0,varSize-1 do--tex vars 0 indexed
  --        vars[varName][j]=module[varName][j+1]--tex lua index by 1
  --      end
  --    else
  --      vars[varName]=module[varName]
  --    end--if varSize
  --  end--for varsInfo

  this.TppSave()
end--LoadVars

function this.TppSave()
  TppSave.VarSavePersonalData()
  TppSave.SavePersonalData()
end--TppSave

--Ivars
this.emblem_load={
  --save=IvarProc.CATEGORY_EXTERNAL,
  settings={"None found"},--DYNAMIC
  settingNamesDoc=[[<list of \mod\emblems>]],
  default=0,
  OnSelect=function(self)
    InfUtil.ClearArray(self.settings)
    if #this.names==0 then
      table.insert(self.settings,1,"None Found")
    else
      for i,name in ipairs(this.names)do
        table.insert(self.settings,name)
      end
    end
    IvarProc.SetSettings(self,self.settings)
  end,
  OnActivate=function(self,setting)
    local saveName=self.settings[setting+1]
    this.LoadVars(saveName)
    InfCore.Log("Loaded "..saveName,true,true)--DEBUGNOW addlang
  end,
}--emblem_load

this.emblem_save={
  --save=IvarProc.CATEGORY_EXTERNAL,
  settings={"New",},--DYNAMIC
  settingNamesDoc=[[New,<list of \mod\bionicHand>]],
  OnSelect=function(self)
    InfUtil.ClearArray(self.settings)
    for i,name in ipairs(this.names)do
      table.insert(self.settings,name)
    end
    table.insert(self.settings,1,"New")
    IvarProc.SetSettings(self,self.settings)
  end,
  OnActivate=function(self,setting)
    local saveName=self.settings[setting+1]
    --TODO: IHHook text entry?
    if saveName=="New" then
      saveName=this.saveName..os.time()..".lua"
    end
    this.SaveVars(saveName,this.infoType)
    self:OnSelect()
    InfCore.Log("Saved "..saveName,true,true)--DEBUGNOW addlang
  end,
  OnInput=function(self,input)
    local setting=ivars[self.name]--tex turns out an Ivar doesn't actually know its own value
    if setting==0 then--New 
      local saveName=input
      this.SaveVars(saveName,this.infoType)
      self:OnSelect()
      for i,name in ipairs(self.settings)do
        if name==input then
          self:Set(i-1)
          InfMenu.DisplayCurrentSetting()
          break
        end
      end
      InfCore.Log("Saved "..saveName,true,true)--DEBUGNOW addlang
    end
  end,
}--emblem_save

this.registerIvars={
  'emblem_load',
  'emblem_save',
}

this.langStrings={
  eng={
    emblem_load="Load emblem",
    emblem_save="Save emblem",
  },
  help={
    eng={
      emblem_load="Load emblem from MGS_TPP\\mod\\emblems . After loading emblem you must go to the normal Customize emblem system and OK it for it to reapply it. It will also regenerate it next time game is started.",
      emblem_save="Save emblem to MGS_TPP\\mod\\emblems",
    },
  }
}--langStrings

return this
