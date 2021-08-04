--InfAvatar.lua
--TODO: document vars with avatar_presets.lua, packs (see TppDefine.AVATAR_ASSET_LIST)
local this={}

this.infosPath="avatars"
this.saveName="avatar"
this.infoType="AVATAR"

this.varNames={
  "avatarAcceFlag",--=255,
  "avatarAccessoryPresetID",--=11,
  "avatarAllPartsPresetID",--=11,
  "avatarBeardPresetID",--=0,
  "avatarBerdLength",--=2,
  "avatarBerdStyle",--=0,
  "avatarCheekPresetID",--=11,
  "avatarChinPresetID",--=11,
  "avatarEbrwStyle",--=3,
  "avatarEbrwWide",--=0,
  "avatarEyePresetID",--=11,
  "avatarEyebrowPresetID",--=0,
  "avatarFaceColorIndex",--=2,
  "avatarFaceRaceIndex",--=0,
  "avatarFaceTypeIndex",--=4,
  "avatarFaceVariationIndex",--=6,
  "avatarGashOrTatoVariationIndex",--=5,
  "avatarHairColor",--=2,
  "avatarHairColorPresetID",--=0,
  "avatarHairPresetID",--=11,
  "avatarHairStyleIndex",--=0,
  "avatarHeadPresetID",--=11,
  "avatarLeftEyeBrightnessIndex",--=1,
  "avatarLeftEyeColorIndex",--=2,
  "avatarMotionFrame",--={ 2, 4, 0, 4, 6, 7, 0, 6, 7, 5, 6, 2, 1, 6, 6, 2, 5, 0, 0, 7, 2, 0, 5, 0, 2, 5, 1, 0, 4, 0, 8, 7, 1, 0, 0, 0, 4, 10, 0, 7, 6, 6, 4, 8, 0, 5, 5, 0, 5, 4, 1, 0, 3, 6, 9, 8, 5, 6, 1,
  "avatarMouthPresetID",--=11,
  "avatarNosePresetID",--=25,
  "avatarReserve0",--=0,
  "avatarReserve1",--=0,
  "avatarReserve2",--=0,
  "avatarRightEyeBrightnessIndex",--=1,
  "avatarRightEyeColorIndex",--=2,
  --"avatarSaveIsValid",--=1,
  "avatarSkinColorPresetID",--=11,
  "avatarTatoColorIndex",--=0,
}--varName

local isArray={
  --[varName]=arraySize
  avatarMotionFrame=60,--0-59
}

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
end--LoadLibraries
function this.BuildSaveText(saveName,infoType,info)
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
  for i,varName in ipairs(this.varNames)do
    local arraySize=isArray[varName] or 0
    if arraySize>0 then
      local array={}
      for j=0,arraySize-1 do--tex vars 0 indexed
        table.insert(array,vars[varName][j])
      end
      info[varName]=array
    else
      info[varName]=vars[varName]
    end
  end--for varNames
  return info
end--VarsToInfo
function this.SaveVars(saveName,infoType)
  InfCore.LogFlow"InfAvatar.SaveVars"
  
  InfUtil.InsertUniqueInList(this.names,saveName)
  local info=this.VarsToInfo()
  this.infos[saveName]=info
    
  local saveTextList=this.BuildSaveText(saveName,infoType,info)
  local fileName=InfCore.paths.avatars..saveName..".lua"
  InfCore.WriteStringTable(fileName,saveTextList)
  InfCore.RefreshFileList()
  InfCore.Log("Saved "..saveName,true,true)
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
--  local module=InfCore.LoadSimpleModule(InfCore.paths.avatars,saveName)
--  if module==nil then
--    InfCore.Log("ERROR: InfAvatar.LoadVars: could not load saves\\"..saveName,true,true)
--    return
--  end
--  
--  for i,varName in ipairs(this.varNames)do
--    local arraySize=isArray[varName] or 0
--    if arraySize>0 then
--      for j=0,arraySize-1 do--tex vars 0 indexed
--        vars[varName][j]=module[varName][j+1]--tex lua index by 1
--      end
--    else
--      vars[varName]=module[varName]
--    end--if arraySize
--  end--for varNames
  
  this.TppSaveAndReload()
end--LoadVars
--tex see heli_common_sequence.Seq_Game_AvatarEditEnd
--just setting vars wont do it (unless you restart game)
--and just TppSave.SaveAvatarData() alone will hang on change to avatar (or if currently avatar)
function this.TppSaveAndReload()
    TppSave.SaveAvatarData()
    TppSave.ReserveVarRestoreForContinue()
    TppPlayer.ResetInitialPosition()
    TppSequence.ReserveNextSequence("Seq_Game_MainGame")
    TppMission.Reload{
      isNoFade = true,
      missionPackLabelName = "default",
      showLoadingTips = false,
    }
end--TppSaveAndReload

--Ivars
this.avatar_load={
--save=IvarProc.CATEGORY_EXTERNAL,
  settings={"None Found"},--DYNAMIC
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
    if not TppMission.IsHelicopterSpace(vars.missionCode) then
      InfMenu.PrintLangId"must_be_in_helispace"
      return
    end
  
    local saveName=self.settings[setting+1]
    this.LoadVars(saveName)
    InfCore.Log("Loaded "..saveName,true,true)--DEBUGNOW addlang
  end,
}--avatar_load

this.avatar_save={
--save=IvarProc.CATEGORY_EXTERNAL,
  settings={"New",},--DYNAMIC
  OnSelect=function(self)
    InfUtil.ClearArray(self.settings)
    for i,name in ipairs(this.names)do
      table.insert(self.settings,name)
    end
    table.insert(self.settings,1,"New")
    IvarProc.SetSettings(self,self.settings)
  end,
  OnActivate=function(self,setting)
    if not TppMission.IsHelicopterSpace(vars.missionCode) then
      InfMenu.PrintLangId"must_be_in_helispace"
      return
    end
  
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
}--avatar_save

this.registerIvars={
  'avatar_load',
  'avatar_save',
}

this.langStrings={
  eng={
    avatar_load="Load avatar",
    avatar_save="Save avatar",
    must_be_in_helispace="Must be in ACC",
  },
  help={
    eng={
      avatar_load="Load avatar from MGS_TPP\\mod\\avatars",
      avatar_save="Save avatar to MGS_TPP\\mod\\avatars",
    },
  }
}--langStrings

return this
