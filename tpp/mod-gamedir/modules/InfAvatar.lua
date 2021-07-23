--InfAvatar.lua
--TODO: document vars with avatar_presets.lua, packs (see TppDefine.AVATAR_ASSET_LIST)
local this={}

this.saveName="avatar"

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

function this.BuildSaveText(saveName)
  local saveTextList={
    "-- "..saveName,
    "-- ",
    "local this={",
  }

  for i,varName in ipairs(this.varNames)do
    local arraySize=isArray[varName] or 0
    if arraySize>0 then
      --tex on one line
      local line=varName.."={"
      for j=0,arraySize-1 do--tex vars 0 indexed
        line=line..vars[varName][j]..","--tex one line
      end
      line=line.."},"
      saveTextList[#saveTextList+1]='\t'..line
    else
      saveTextList[#saveTextList+1]='\t'..varName.."="..vars[varName]..","
    end
  end--for varNames

  saveTextList[#saveTextList+1]="}--this"
  saveTextList[#saveTextList+1]="return this"

  return saveTextList
end--BuildSaveText
function this.SaveVars(saveName)
  InfCore.LogFlow"InfAvatar.SaveVars"
  local saveTextList=this.BuildSaveText(saveName)
  local fileName=InfCore.paths.avatars..saveName
  InfCore.WriteStringTable(fileName,saveTextList)
  InfCore.RefreshFileList()
  InfCore.Log("Saved "..saveName,true,true)
end--SaveVars
function this.LoadVars(saveName)
  local module=InfCore.LoadSimpleModule(InfCore.paths.avatars,saveName)
  if module==nil then
    InfCore.Log("ERROR: InfAvatar.LoadVars: could not load saves\\"..saveName,true,true)
    return
  end
  
  for i,varName in ipairs(this.varNames)do
    local arraySize=isArray[varName] or 0
    if arraySize>0 then
      for j=0,arraySize-1 do--tex vars 0 indexed
        vars[varName][j]=module[varName][j+1]--tex lua index by 1
      end
    else
      vars[varName]=module[varName]
    end--if arraySize
  end--for varNames
  
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
this.loadAvatar={
--save=IvarProc.CATEGORY_EXTERNAL,
  settings={"None Found"},--DYNAMIC
  default=0,
  OnSelect=function(self)
    local files=InfCore.GetFileList(InfCore.files.avatars,".lua")
    if #files==0 then
      table.insert(files,1,"None Found")
    end
    IvarProc.SetSettings(self,files)
  end,
  OnActivate=function(self,setting)
    if not TppMission.IsHelicopterSpace(vars.missionCode) then
      InfMenu.PrintLangId"must_be_in_helispace"
      return
    end
  
    local saveName=self.settings[setting+1]
    this.LoadVars(saveName)
  end,
}--loadAvatar

this.saveAvatar={
--save=IvarProc.CATEGORY_EXTERNAL,
  settings={"New",},--DYNAMIC
  OnSelect=function(self)
    local files=InfCore.GetFileList(InfCore.files.avatars,".lua")
    table.insert(files,1,"New")
    IvarProc.SetSettings(self,files)
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
    this.SaveVars(saveName)
    self:OnSelect()
  end,
}--saveAvatar

this.registerIvars={
  'loadAvatar',
  'saveAvatar',
}

this.langStrings={
  eng={
    loadAvatar="Load avatar",
    saveAvatar="Save avatar",
    must_be_in_helispace="Must be in ACC",
  },
  help={
    eng={
      loadAvatar="Load avatar from MGS_TPP\\mod\\avatars",
      saveAvatar="Save avatar to MGS_TPP\\mod\\avatars",
    },
  }
}--langStrings

return this
