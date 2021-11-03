--InfAvatarHorn.lua
--DEPENDANCY: IHHook
--Implements extending avatar horn fpk/fv2s via IHHook
--Loads info files from MGS_TPP\mod\avatarHorns

--REF exe/IHHook LoadAvatarOgreHorn*

local this={}

local IHH=IHH

this.infos={
  NO_HORN={
    description="No horn",
    --KLUDGE: ihhook treats "" as use the defaults rather than path64 = 0 / NONE, but providing a non existant fpk will hang the system
    --however invalid fv2 wont
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v00.fpk",
    fv2Path="NONE",
  },
  HORN_0={
    description="Horn level 0",
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/avm/avm_hone_v00.fv2",
  },
  HORN_1={
    description="Horn level 1",
    fpkPath="/Assets/tpp/pack/player/avatar/hone/plfova_avm_hone_v01.fpk",
    fv2Path="/Assets/tpp/fova/chara/avm/avm_hone_v01.fv2",
  },
  HORN_2={
    description="Horn level 2",
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

this.ivarPrefix="horn_fova"

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

  local value=Ivars.horn_fova:Get()
  if value+1>#this.names then
    value=0
  end
  if value>0 then
    local name=this.names[value+1]
    local info=this.infos[name]
    this.SetOverrideValues(nil,info)
  end
  Ivars.horn_fova:OnChange(value)
end--PostAllModulesLoad

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
  IHH.SetAvatarHornFpkPath(hornType,info.fpkPath)
  IHH.SetAvatarHornFv2Path(hornType,info.fv2Path)
end--SetOverrideValues
function this.ClearOverrideValues(hornType,info)
  --tex IHHook reverts to vanilla if set paths are "" empty string
  IHH.SetAvatarHornFpkPath(hornType,"")
  IHH.SetAvatarHornFv2Path(hornType,"")
end--ClearOverrideValues

this.registerIvars={
  "horn_fova",
}

this.horn_fova={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.names,
  OnSelect=function(self)

  end,
  OnChange=function(self,setting)
    if not IHH then
    --DEBUGNOW
    else
      if setting==0 then
        this.ClearOverrideValues(self.hornType)
      else
        local name=self.settings[setting+1]
        local info=this.infos[name]
        this.SetOverrideValues(nil,info)
      end

      if vars.playerType==3 then--AVATAR
        InfPlayerParts.RefreshParts()--KLUDGE
      end
    end
  end,
}--ivar

return this
