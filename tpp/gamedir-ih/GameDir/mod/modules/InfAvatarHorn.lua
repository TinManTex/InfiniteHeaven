--InfAvatarHorn.lua
--WIP: kinda stopped after I fell off IH dev in nov 21 (and zip was doing something similar)
--DEPENDENCY: IHHook
--namespace CharacterFova
--Implements extending avatar horn fpk/fv2s via IHHook
--Loads info files from MGS_TPP\mod\avatarHorns

--REF example avatarHornInfo
--local this={
--  description="Horn level 0",
--  hornLevel=0,--optional. level of horn [0-2] it's intended to represent. currently unused
--  fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v00.fpk",
--  fv2Path="/Assets/tpp/fova/chara/avm/avm_hone_v00.fv2",
--}--this
--return this

--REF exe/IHHook LoadAvatarOgreHorn*

local this={}

local IHH=IHH

this.infos={
  NO_HORN={
    description="No horn",
    --KLUDGE: ihhook treats "" as 'use the defaults' rather than path64 = 0 / NONE, but providing a non existant fpk will hang the system
    --however invalid fv2 wont
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v00.fpk",
    fv2Path="NONE",
  },
  HORN_0={
    description="Horn level 0",
    hornLevel=0,
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/avm/avm_hone_v00.fv2",
  },
  HORN_1={
    description="Horn level 1",
    hornLevel=1,
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v01.fpk",
    fv2Path="/Assets/tpp/fova/chara/avm/avm_hone_v01.fv2",
  },
  HORN_2={
    description="Horn level 2",
    hornLevel=2,
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v02.fpk",
    fv2Path="/Assets/tpp/fova/chara/avm/avm_hone_v02.fv2",
  },
}--infos
this.names={
  "OFF",
  "NO_HORN",
  "HORN_0",
  "HORN_1",
  "HORN_2",
}--names

this.ivarPrefix="character_avatarHorn"

this.AvatarHornType={
  "HORN_0",
  "HORN_1",
  "HORN_2",
}
--EXEC
for i,hornName in ipairs(this.AvatarHornType)do
  this.AvatarHornType[hornName]=i-1
end--for AvatarHornType

function this.PostAllModulesLoad(isReload)
  if not IHH then
    return
  end

  this.LoadInfos()

  local value=Ivars.character_avatarHorn:Get()
  if value+1>#this.names then
    value=0
  end
  if value>0 then
    local name=this.names[value+1]
    local info=this.infos[name]
    this.SetOverrideValues(nil,info)
  end
  Ivars.character_avatarHorn:OnChange(value)
end--PostAllModulesLoad
function this.OnAllocate(missionTable)
  if InfMain.IsOnlineMission(vars.missionCode) then
    this.ClearOverrideValues(nil,nil)
  else
  --DEBUGNOW reapply?
  end
end--OnAllocate
function this.LoadInfos()
  InfCore.LogFlow("InfAvatarHorn.LoadInfos")

  local infoPath="avatarHorns"
  local files=InfCore.GetFileList(InfCore.files[infoPath],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfAvatarHorn.LoadInfos: "..fileName)
    local infoName=InfUtil.StripExt(fileName)
    local info=InfCore.LoadSimpleModule(InfCore.paths[infoPath],fileName)
    if not info then
      InfCore.Log("")
    else
      this.infos[infoName]=info
      table.insert(this.names,infoName)
    end
  end--for files

  for infoName, info in pairs(this.infos)do

  end--for infos
end--LoadInfos

function this.SetOverrideValues(hornType,info)
  IhkCharacter.SetAvatarHornFpkPath(hornType,info.fpkPath)
  IhkCharacter.SetAvatarHornFv2Path(hornType,info.fv2Path)
end--SetOverrideValues
function this.ClearOverrideValues(hornType,info)
  --tex IHHook reverts to vanilla if set paths are "" empty string
  IhkCharacter.SetAvatarHornFpkPath(hornType,"")
  IhkCharacter.SetAvatarHornFv2Path(hornType,"")
end--ClearOverrideValues
function this.ApplyInfo(setting)
  if not IHH then
    return
  end
  if setting+1>#this.names then
    setting=0
  end
  if setting==0 then
    this.ClearOverrideValues()
  else
    local name=this.names[setting+1]
    local info=this.infos[name]
    this.SetOverrideValues(nil,info)
  end
end--ApplyInfo
this.registerIvars={
  "character_avatarHorn",
}

this.character_avatarHorn={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.names,
  OnSelect=function(self)

  end,
  GetSettingText=function(self,setting)
    if setting==0 then return "Off" end

    local infoNameSetting=self.settings[setting+1]
    local info=this.infos[infoNameSetting]
    InfCore.Log("getsettingtext infoname "..tostring(infoNameSetting))--DEBUGNOW
    return info.description or infoNameSetting or "WARNING: invalid value"
  end,
  OnChange=function(self,setting)
    this.ApplyInfo(setting)
    if vars.playerType==3 then--AVATAR
      InfPlayerParts.RefreshParts()--KLUDGE
    end
  end,
}--ivar

this.langStrings={
  eng={
    character_avatarHorn="Avatar Horn fova",
  },
  help={
    eng={
      character_avatarHorn=[[Selects avatarHorn addon (in MGS_TPP\mod\avatarHorns).]],
    },
  }
}--langStrings

return this
