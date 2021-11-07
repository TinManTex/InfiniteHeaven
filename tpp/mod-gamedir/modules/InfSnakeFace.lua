--InfSnakeFace.lua
--DEPENDENCY: IHHook
--namespace CharacterFova
--Implements extending avatar horn fpk/fv2s via IHHook
--Loads info files from MGS_TPP\mod\avatarHorns

--REF exe/IHHook LoadAvatarOgreHorn*

--DEBUGNOW not sure how to handle this at the moment
--basically have two axis: hornLevel[0-3] and playerFaceEquipId[0-2?] (NONE,BANDANA,INFINITY_BANDANA) (TODO verify that's the enum order) (playerFaceEquipId continues higher for DD headgear, but not handled by snakeface func
--simplest way is just set current face, which will display reguardless of hornLevel,playerFaceEquipId, aka the current playerPartsType way (ignoring playerType for a moment)
--otherwise hornLevel*playerFaceEquipId which could get out of hand, this is sort of how bionichand is currently handled (should I shift that to just single override?)
--its basically how much should players ui choice impact the ih override.

local this={}

local IHH=IHH

--TODO: sna0_face3_v00 ash face, only in a demo pack somewhere
this.infos={
  --  NONE={
  --    description="None",
  --    fpkPath="",
  --    fv2Path="",
  --  },
  NORMAL_HORN_0={
    description="Normal - Horn 0",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_face0_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_face0_v00.fv2",
  },
  NORMAL_HORN_1={
    description="Normal - Horn 1",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_face1_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_face1_v00.fv2",
  },

  NORMAL_HORN_2={
    description="Normal - Horn 2",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_face2_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_face2_v00.fv2",
  },

  BANDANA_HORN_0={
    description="Bandana - Horn 0",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_face4_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_face4_v00.fv2",
  },

  BANDANA_HORN_1={
    description="Bandana - Horn 1",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_face5_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_face5_v00.fv2",
  },

  BANDANA_HORN_2={
    description="Bandana - Horn 2",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_face6_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_face6_v00.fv2",
  },

  GOLD={
    description="Gold",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna9_face0_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna9_face0_v00.fv2",
  },
  GOLD_BANDANA={
    description="Gold Bandana",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna9_face2_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna9_face2_v00.fv2",
  },

  SILVER={
    description="Silver",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna9_face1_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna9_face1_v00.fv2",
  },
  SILVER_BANDANA={
    description="Silver Bandana",
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna9_face3_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna9_face3_v00.fv2",
  },
}--infos
this.names={
  "OFF",
  "NORMAL_HORN_0",
  "NORMAL_HORN_1",
  "NORMAL_HORN_2",
  "BANDANA_HORN_0",
  "BANDANA_HORN_1",
  "BANDANA_HORN_2",
  "GOLD",
  "GOLD_BANDANA",
  "SILVER",
  "SILVER_BANDANA",
}--names

this.ivarPrefix="character_snakeFace"

function this.PostAllModulesLoad(isReload)
  if not IHH then
    return
  end

  this.LoadInfos()

  local value=Ivars.character_snakeFace:Get()
  if value+1>#this.names then
    value=0
  end
  if value>0 then
    local name=this.names[value+1]
    local info=this.infos[name]
    this.SetOverrideValues(nil,nil,info)
  end
  Ivars.character_snakeFace:OnChange(value)
end--PostAllModulesLoad

function this.LoadInfos()
  InfCore.LogFlow("InfSnakeFace.LoadInfos")

  local infoPath="snakeFaces"
  local files=InfCore.GetFileList(InfCore.files[infoPath],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfSnakeFace.LoadInfos: "..fileName)
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

function this.SetOverrideValues(hornLevel,faceEquipId,info)
  IHH.SetSnakeFaceFpkPath(info.fpkPath)
  IHH.SetSnakeFaceFv2Path(info.fv2Path)
end--SetOverrideValues
function this.ClearOverrideValues(hornLevel,faceEquipId,info)
  --tex IHHook reverts to vanilla if set paths are "" empty string
  IHH.SetSnakeFaceFpkPath("")
  IHH.SetSnakeFaceFv2Path("")
end--ClearOverrideValues

this.registerIvars={
  "character_snakeFace",
}

this.character_snakeFace={
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
    if not IHH then
    --DEBUGNOW
    else
      if setting==0 then
        this.ClearOverrideValues(nil,nil)
      else
        local name=self.settings[setting+1]
        local info=this.infos[name]
        this.SetOverrideValues(nil,nil,info)
      end

      if vars.playerType==0 then--SNAKE
        InfPlayerParts.RefreshParts()--KLUDGE
      end
    end
  end,
}--ivar

this.langStrings={
  eng={
    character_snakeFace="Snake Face fova",
  },
  help={
    eng={
      character_snakeFace=[[Selects snakeFace addon (in MGS_TPP\mod\snakeFaces). Overrides Snakes face, including horn level/banada]],
    },
  }
}--langStrings

return this
