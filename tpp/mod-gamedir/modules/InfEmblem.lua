--InfEmblem.lua
local this={}

this.saveName="emblem"

this.varsInfo={
  emblemColorH=4,--{[0] = 1842204, 4046562, 0, 0,},
  emblemColorL=4,--{[0] = 7355937, 0, 1605275, 1605275, },
  emblemFlag=680,--{[0] = 4, 4, 4, 4, 5, 4, 5, 5, 5, 5, 5, 5, 4, 5, 4, 4, 4, 4, 4, 4, 5, 5, 4, 5, 5, 5, 1, 5, 6, 5, 1, 4, 5, 5, 1, 6, 6, 4, 2, 4, 4, 4, 5, 4, 2, 6, 2, 5, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 4, 5, 4, 4, 4, 4, 4, 4, 4, 2, 0, 5, 4, 2, 2, 5, 4, 1, 2, 5, 5, 4, 4, 4, 5, 2, 5, 5, 4, 0, 5, 4, 4, 4, 5, 4, 4, 0, 4, 4, 4, 0, 5, 1, 4, 5, 1, 5, 6, 5, 4, 4, 4, 4, 2, 4, 5, 5, 2, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 1, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 5, 4, 4, 5, 4, 4, 4, 5, 5, 2, 1, 4, 5, 1, 2, 5, 5, 4, 1, 5, 5, 5, 1, 4, 5, 4, 1, 5, 4, 4, 6, 4, 5, 5, 1, 4, 4, 4, 4, 4, 4, 5, 6, 4, 6, 2, 4, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, 2, 0, 4, 4, 4, 2, 6, 4, 4, 4, 2, 4, 6, 4, 4, 1, 1, 4, 4, 1, 4, 4, 2, 4, 4, 2, 4, 4, 4, 2, 4, 4, 4, 2, 2, 4, 4, 4, 4, 4, 4, 4, 2, 1, 4, 1, 2, 1, 5, 1, 4, 4, 2, 4, 4, 6, 2, 2, 4, 6, 4, 2, 4, 4, 4, 4, 2, 4, 6, 4, 2, 6, 2, 4, 0, 4, 6, 2, 4, 2, 6, 6, 6, 6, 2, 6, 2, 6, 2, 4, 4, 4, 4, 2, 4, 4, 4, 4, 2, 6, 4, 4, 5, 6, 2, 4, 4, 4, 4, 2, 2, 4, 6, 4, 4, 4, 4, 6, 4, 4, 6, 2, 4, 4, 4, 4, 4, 2, 2, 4, 1, 2, 2, 4, 4, 2, 2, 4, 4, 4, 0, 4, 0, 0, 4, 4, 4, 4, 4, 4, 2, 4, 4, 4, 4, 4, 4, 4, 4, 2, 2, 2, 4, 6, 2, 4, 0, 4, 4, 4, 4, 4, 0, 4, 4, 4, 4, 4, 4, 0, 4, 1, 1, 1, 1, 1, 1, 1, 0, 4, 4, 0, 0, 2, 4, 2, 4, 4, 2, 4, 4, 4, 4, 4, 4, 2, 2, 2, 4, 4, 4, 1, 4, 4, 1, 4, 2, 4, 4, 4, 4, 1, 1, 4, 1, 4, 6, 2, 6, 6, 6, 6, 2, 1, 6, 6, 6, 6, 6, 6, 2, 1, 6, 6, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 0, 0, 4, 5, 4, 4, 5, 4, 4, 4, 5, 5, 6, 5, 6, 5, 5, 6, 5, 5, 4, 5, 5, 5, 5, 1, 6, 5, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4,
  emblemRotate=4,--{[0] = 0, 0, 16, 0,
  emblemScale=4,--{[0] = 12, 12, 18, 13,
  --  emblemSyncFailed=1,--0,
  --  emblemSyncFailed2=1,--0,
  emblemTextureTag=4,--{[0] = 121979538, -255272731, 34, 514211224,
  --  emblemVersion=1,-- 1,
  emblemX=4,--{[0] = 10, 10, -54, 17,
  emblemY=4,--{[0] = 2, 2, 20, 45,
}--varsInfo

function this.BuildSaveText(saveName)
  local saveTextList={
    "-- "..saveName,
    "-- ",
    "local this={",
  }

  for varName,varSize in pairs(this.varsInfo)do
    if varSize>1 then
      --tex on one line
      local line=varName.."={"
      for j=0,varSize-1 do--tex vars 0 indexed
        line=line..vars[varName][j]..","--tex one line
      end
      line=line.."},"
      saveTextList[#saveTextList+1]='\t'..line
    else
      saveTextList[#saveTextList+1]='\t'..varName.."="..vars[varName]..","
    end--if varSize
  end--for varsInfo

  saveTextList[#saveTextList+1]="}--this"
  saveTextList[#saveTextList+1]="return this"

  return saveTextList
end--BuildSaveText

function this.SaveVars(saveName)
  InfCore.LogFlow"InfEmblem.SaveVars"
  local saveTextList=this.BuildSaveText(saveName)
  local fileName=InfCore.paths.emblems..saveName
  InfCore.WriteStringTable(fileName,saveTextList)
  InfCore.RefreshFileList()
  InfCore.Log("Saved "..saveName,true,true)
end--SaveVars
function this.LoadVars(saveName)
  local module,err=InfCore.LoadSimpleModule(InfCore.paths.emblems,saveName)
  if module==nil then
    InfCore.Log("ERROR: InfEmblem.LoadVars: could not load emblems\\"..saveName,true,true)
    return
  end
  
  for varName,varSize in pairs(this.varsInfo)do
    if varSize>1 then
      for j=0,varSize-1 do--tex vars 0 indexed
        vars[varName][j]=module[varName][j+1]--tex lua index by 1
      end
    else
      vars[varName]=module[varName]
    end--if varSize
  end--for varsInfo
  
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
  default=0,
  OnSelect=function(self)
    local files=InfCore.GetFileList(InfCore.files.emblems,".lua")
    if #files==0 then
      table.insert(files,1,"None Found")
    end
    IvarProc.SetSettings(self,files)
  end,
  OnActivate=function(self,setting)
    local saveName=self.settings[setting+1]
    this.LoadVars(saveName)
  end,
}--emblem_load

this.emblem_save={
--save=IvarProc.CATEGORY_EXTERNAL,
  settings={"New",},--DYNAMIC
  OnSelect=function(self)
    local files=InfCore.GetFileList(InfCore.files.emblems,".lua")
    table.insert(files,1,"New")
    IvarProc.SetSettings(self,files)
  end,
  OnActivate=function(self,setting)
    local saveName=self.settings[setting+1]
    --TODO: IHHook text entry?
    if saveName=="New" then
      saveName=this.saveName..os.time()..".lua"
    end
    this.SaveVars(saveName)
    self:OnSelect()
  end,
}--emblem_save

this.registerIvars={
  'emblem_load',
  'emblem_save',
}

this.registerMenus={
  'emblemMenu',
}

this.emblemMenu={
  --parentRefs={"InfMenuDefs.playerSettingsMenu"},
  options={
    'Ivars.emblem_load',
    'Ivars.emblem_save',
  },
}

this.langStrings={
  eng={
    emblem_load="Load emblem",
    emblem_save="Save emblem",
    emblemMenu="Emblem menu",
  },
  help={
    eng={
      emblem_load="Load emblem from MGS_TPP\\mod\\emblems . After loading emblem you must go to the normal Customize emblem system and OK it for it to reapply it. It will also regenerate it next time game is started.",
      emblem_save="Save emblem to MGS_TPP\\mod\\emblems",
    },
  }
}--langStrings

return this
