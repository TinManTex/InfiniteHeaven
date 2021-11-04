--InfBionicHand.lua
--DEPENDENCY: IHHook
--namespace CharacterFova
--Implements extending bionic hand fpk/fv2s / vars.playerHand via IHHook
--Loads info files from MGS_TPP\mod\bionicHands

--DEBUGNOW GOTCHA: while turning hand off for partstypes that usually have them works,
--setting a partsType to one that has no hand also sets playerHandType to 0, which resolves to empty path/no hand
--WORKAROUND is to set ivar hand_fovaNONE to something.

--TODO: figure out interaction between vars.playerHandType and vars.handEquip (handequip actually seems to be the driver)

--REF TODO info
--local this={
--  infoType="BIONICHAND",
--  description="NORMAL hook hand",
--  handTypeName="NORMAL",--OPTIONAL: limit to one type, see PlayerHandType below DEBUGNOW TODO
--  fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm0_v00_hookhand.fpk",
--  fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm0_v00.fv2",
--}--this
--return this

local this={}

local IHH=IHH

this.infos={
  --tex vanilla
  NONE={
    vanillaHandType=PlayerHandType.NONE,--tex vanillaHandType for reference, not used for addons
    fpkPath="",--tex DEBUGNOW "" doesn't really work as a NONE option for other hand types since IHHook is using "" as fall-back to vanilla value instead. a kludge is to give valid fpkPath and invalid fv2Path
    fv2Path="",
  },
  NORMAL={
    vanillaHandType=PlayerHandType.NORMAL,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm0_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm0_v00.fv2",
  },
  STUN_ARM={
    vanillaHandType=PlayerHandType.STUN_ARM,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm3_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm3_v00.fv2",
  },
  JEHUTY={
    vanillaHandType=PlayerHandType.JEHUTY,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm4_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm4_v00.fv2",
  },
  STUN_ROCKET={
    handType=PlayerHandType.STUN_ROCKET,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm2_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm2_v00.fv2",
  },
  KILL_ROCKET={
    handType=PlayerHandType.KILL_ROCKET,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm1_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm1_v00.fv2",
  },
  GOLD={
    handType=PlayerHandType.GOLD,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm6_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm6_v00.fv2",
  },
  SILVER={
    handType=PlayerHandType.SILVER,
    fpkPath="/Assets/tpp/pack/player/fova/plfova_sna0_arm7_v00.fpk",
    fv2Path="/Assets/tpp/fova/chara/sna/sna0_arm7_v00.fv2",
  },
}--infos
this.names={
  "OFF",
  "NORMAL",--1
  "STUN_ARM",--2
  "JEHUTY",--3
  "STUN_ROCKET",--4
  "KILL_ROCKET",--5
  "GOLD",--6
  "SILVER",--7
}

this.ivarPrefix="character_bionicHand"

this.PlayerHandType={
  "NONE",--0
  "NORMAL",--1
  "STUN_ARM",--2
  "JEHUTY",--3
  "STUN_ROCKET",--4
  "KILL_ROCKET",--5
  "GOLD",--6
  "SILVER",--7
}

function this.PostAllModulesLoad(isReload)
  if not IHH then
    return
  end

  this.LoadInfos()

  --CULL old/alternate style where I had ivar for each handtype
  --  for i,handType in ipairs(this.PlayerHandType)do
  --    --DEBUGNOW if handType~="NONE"then
  --      local ivarName=this.ivarPrefix..handType
  --      local ivar=Ivars[ivarName]
  --      local value=ivar:Get()
  --      if value>#this.names then
  --        value=0
  --      end
  --      if value>0 then
  --        local name=this.names[value]
  --        local info=this.infos[name]
  --        this.SetOverrideValues(ivar.handType,info)
  --      end
  --      ivar:OnChange(value)
  --    end
  --  --end--for PlayerHandType

  local value=Ivars.character_bionicHand:Get()
  if value+1>#this.names then
    value=0
  end
  if value>0 then
    local name=this.names[value+1]
    local info=this.infos[name]
    this.SetOverrideValues(nil,info)
  end
  Ivars.character_bionicHand:OnChange(value)
end--PostAllModulesLoad

function this.LoadInfos()
  InfCore.LogFlow("InfBionicHand.LoadInfos")

  local infoPath="bionicHands"
  local files=InfCore.GetFileList(InfCore.files[infoPath],".lua")
  for i,fileName in ipairs(files)do
    InfCore.Log("InfBionicHand.LoadInfos: "..fileName)
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
--handType UNUSED, is for alternate per hand type ivars
function this.SetOverrideValues(handType,info)
  IHH.SetBionicHandFpkPath(handType,info.fpkPath)
  IHH.SetBionicHandFv2Path(handType,info.fv2Path)
end--SetOverrideValues
function this.ClearOverrideValues(handType,info)
  --tex IHHook reverts to vanilla if set paths are "" empty string
  IHH.SetBionicHandFpkPath(handType,"")
  IHH.SetBionicHandFv2Path(handType,"")
end--ClearOverrideValues

this.registerIvars={
  "character_bionicHand",
}

--CULL old/alternate style where I had ivar for each handtype
--character_bionicHand<handType> ivars
--for i,handType in ipairs(this.PlayerHandType)do
--  --DEBUGNOW if handType~="NONE"then
--    local ivarName=this.ivarPrefix..handType
--    local ivar={
--      save=IvarProc.CATEGORY_EXTERNAL,
--      settings=this.names,
--      handType=PlayerHandType[handType],
--      OnSelect=function(self)
--      --DEBUGNOW troublesome
--      --for infos
--      --if info.handType==nil or info.handType==self.handType then
--      --
--      end,
--      OnChange=function(self,setting)
--        if not IHH then
--        --DEBUGNOW
--        else
--          if setting==0 then
--            this.ClearOverrideValues(self.handType)
--          else
--            local name=self.settings[setting+1]
--            local info=this.infos[name]
--            --DEBUGNOW if info.handType and info.handType~=self.handType then
--            --  this.ClearOverrideValues(self.handType)
--            --else
--            this.SetOverrideValues(self.handType,info)
--            --end
--          end
--          --DEBUGNOW TODO a way to refresh the handType, basically swap away and back, but need to wait some frames, does handType change use the Parts ACTIVE status?
--        end
--      end,
--    }--ivar
--    this[ivarName]=ivar
--    table.insert(this.registerIvars,ivarName)
-- -- end--if handType~=NONE
--end--for this.PlayerHandType


this.character_bionicHand={
  save=IvarProc.CATEGORY_EXTERNAL,
  settings=this.names,
  OnSelect=function(self)

  end,
  OnChange=function(self,setting)
    if not IHH then
    --DEBUGNOW
    else
      if setting==0 then
        this.ClearOverrideValues(self.handType)
      else
        local name=self.settings[setting+1]
        local info=this.infos[name]
        --DEBUGNOW if info.handType and info.handType~=self.handType then
        --  this.ClearOverrideValues(self.handType)
        --else
        this.SetOverrideValues(self.handType,info)
        --end
      end
      if vars.playerType==0 or vars.playerType==3 then--SNAKE,AVATAR
        InfPlayerParts.RefreshParts()--KLUDGE
      end
    end
  end,
}--ivar

this.langStrings={
  eng={
    character_bionicHand="Bionic Hand fova",
  },
  help={
    eng={
      character_bionicHand=[[Selects bionicHand addon (in MGS_TPP\mod\bionicHands). Overrides whatever bionic hand is displayed.]],
    },
  }
}--langStrings

return this
