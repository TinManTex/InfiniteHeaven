-- InfFovaIvars.lua
--player appearance ivars
local this={}

-->
this.registerIvars={
  "playerType",
  "playerTypeDirect",
  "playerPartsType",
  "playerPartsTypeDirect",
  "playerCamoType",
  "playerCamoTypeDirect",
  "playerFaceEquipId",
  "playerFaceEquipIdDirect",
  "playerFaceId",
  "playerFaceFilter",
  "playerFaceIdDirect",
  "maleFaceId",
  "femaleFaceId",
  "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
  "faceFovaDirect",
  "faceDecoFovaDirect",
  "hairFovaDirect",
  "hairDecoFovaDirect",
  "faceFovaUnknown1",
  "faceFovaUnknown2",
  "eyeFova",
  "skinFova",
  "faceFovaUnknown5",
  "uiTextureCount",
  "faceFovaUnknown7",
  "faceFovaUnknown8",
  "faceFovaUnknown9",
  "faceFovaUnknown10",
  "enableFovaMod",
  "fovaSelection",
  "fovaPlayerType",
  "fovaPlayerPartsType",
  "skipDevelopChecks",
}

--appearance
this.playerType={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  settings={"SNAKE","AVATAR","DD_MALE","DD_FEMALE","OCELOT","QUIET"},
  GetSettingText=function(self,setting)
    local playerTypeName=self.settings[setting+1]
    local playerType=PlayerType[playerTypeName]
    local playerTypeInfo=InfFova.playerTypesInfo[playerType+1]
    local fobLocked=""
    if InfFova.fobLocked[playerTypeInfo.name] then
      fobLocked=" "..InfLangProc.LangString"fob_locked_warning"
    end
    local settingText = playerTypeInfo.description or playerTypeInfo.name
    return settingText..fobLocked
  end,
  OnSelect=function(self)
    local playerTypeName=InfFova.playerTypesInfo[vars.playerType+1].name--TODO better playerType to playerTypeName
    for setting,playerType in ipairs(self.settings)do
      if playerType==playerTypeName then
        ivars[self.name]=setting-1
        break
      end
    end
  end,
  OnChange=function(self,setting)
    local currentPlayerType=vars.playerType
    local newPlayerTypeName=self.settings[setting+1]
    local newPlayerType=PlayerType[newPlayerTypeName]
    if newPlayerType==currentPlayerType then
      return
    end

    if (InfFova.playerTypeGroup.VENOM[newPlayerTypeName] and InfFova.playerTypeGroup.DD[currentPlayerType])
      or (InfFova.playerTypeGroup.VENOM[currentPlayerType] and InfFova.playerTypeGroup.DD[newPlayerTypeName]) then
      --InfCore.DebugPrint"playerTypeGroup changed"--DEBUG
      vars.playerPartsType=0
    end

    if currentPlayerType==PlayerType.DD_MALE then
      Ivars.maleFaceId:Set(vars.playerFaceId)
    elseif currentPlayerType==PlayerType.DD_FEMALE then
      Ivars.femaleFaceId:Set(vars.playerFaceId)
    end

    if newPlayerType==PlayerType.DD_FEMALE then
      vars.playerFaceId=Ivars.femaleFaceId:Get()
    else
      vars.playerFaceId=Ivars.maleFaceId:Get()
    end

    local faceEquipInfo=InfFova.playerFaceEquipIdInfo[vars.playerFaceEquipId+1]
    if faceEquipInfo and faceEquipInfo.playerTypes and not faceEquipInfo.playerTypes[vars.playerType] then
      vars.playerFaceEquipId=0
    end

    --tex fob locked player types such as Occelot and Quiet can be set in sortie
    --unfortunately the exe will force them back to snake on reset so user has to live with side effects
    if InfFova.fobLocked[newPlayerTypeName] then
      TppGameStatus.Set("heli_common_sequence.lua", "S_IS_SORTIE_PREPARATION")
    else
      TppGameStatus.Reset("heli_common_sequence.lua", "S_IS_SORTIE_PREPARATION")
    end

    vars.playerType=newPlayerType
  end,
}

this.playerTypeDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=255},
  OnSelect=function(self)
    ivars[self.name]=vars.playerType
  end,
  OnActivate=function(self,setting)
    vars.playerType=setting
  end,
}

--tex seperate from InfFova so can control order from playerPartsType
local playerPartsTypeSettings={
  "NORMAL",--0,
  "NORMAL_SCARF",--1,
  "NAKED",--7,
  "SNEAKING_SUIT_TPP",--8,
  "SNEAKING_SUIT",--2,
  "SNEAKING_SUIT_BB",--30--GOTCHA: overflow
  "BATTLEDRESS",--9
  "PARASITE",--10
  "LEATHER",--11
  "SWIMWEAR",--23
  "SWIMWEAR_G",--24
  "SWIMWEAR_H",--25
  "RAIDEN",--6,
  "HOSPITAL",--3,
  "MGS1",--4,
  "NINJA",--5,
  "GOLD",--12
  "SILVER",--13
  "MGS3",--15
  "MGS3_NAKED",--16
  "MGS3_SNEAKING",--17
  "MGS3_TUXEDO",--18
  "EVA_CLOSE",--19
  "EVA_OPEN",--20
  "BOSS_CLOSE",--21
  "BOSS_OPEN",--22
  "OCELOT",
  "QUIET",
}

this.playerPartsType={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  settings=playerPartsTypeSettings,--DYNAMIC
  GetSettingText=function(self,setting)
    local InfFova=InfFova
    local partsTypeName=self.settings[setting+1]
    local partsType=InfFova.PlayerPartsType[partsTypeName]
    local partsTypeInfo=InfFova.playerPartsTypesInfo[partsType+1]

    local playerTypeName=InfFova.playerTypes[vars.playerType+1]

    local fovaTable,modelDescription=InfFova.GetFovaTable(playerTypeName,partsTypeName)
    return modelDescription or partsTypeInfo.description or partsTypeInfo.name
  end,
  OnSelect=function(self)
    local playerPartsTypes=InfFova.GetPlayerPartsTypes(playerPartsTypeSettings,vars.playerType)
    if playerPartsTypes==nil then
      InfCore.Log("WARNING: No playerPartsTypes for playerType "..vars.playerType)
      return
    end

    IvarProc.SetSettings(self,playerPartsTypes)
    if #self.settings==0 then
      InfCore.DebugPrint("WARNING: #self.settings==0 for playerType")
      return
    end

    local partsTypeName=InfFova.playerPartsTypes[vars.playerPartsType+1]
    local setting=self.enum[partsTypeName]
    if setting==nil then
      --InfCore.DebugPrint("WARNING: could not find enum for "..partsTypeName)--DEBUG
      self:Set(0)
    else
      self:Set(self.enum[partsTypeName])
    end
  end,
  OnChange=function(self,setting)
    local partsTypeName=self.settings[setting+1]
    local partsType=InfFova.PlayerPartsType[partsTypeName]

    vars.playerPartsType=partsType

    Ivars.playerCamoType:OnSelect()--tex sort out camo type too, as the exe doesnt seem to change on camotype change, not playerpartstype change
  end,
}

this.playerPartsTypeDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=255},
  OnSelect=function(self)
    ivars[self.name]=vars.playerPartsType
  end,
  OnActivate=function(self,setting)
    vars.playerPartsType=setting
    vars.playerCamoType=0--DEBUGNOW
  end,
}

--tex GOTCHA: setting var.playerCamoType to a unique type (non-common/only one camo type for it) seems to lock it in/prevent vars.playerPartsType from applying until set back to a common camo type
this.playerCamoType={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  settings={},--playerCamoTypes,--DYNAMIC
  GetSettingText=function(self,setting)
    local camoName=self.settings[setting+1]
    if camoName==nil then
      return InfLangProc.LangString"no_developed_camo"
    end
    --InfCore.PrintInspect(camoName,"camoName")--DEBUG
    local camoType=PlayerCamoType[camoName]
    --InfCore.PrintInspect(camoType,"camoType")--DEBUG
    local camoInfo=InfFova.playerCamoTypesInfo[camoType+1]
    return camoInfo.description or camoInfo.name
  end,
  OnSelect=function(self)
    local partsTypeName=InfFova.playerPartsTypes[vars.playerPartsType+1]
    --InfCore.PrintInspect(partsTypeName,"partsTypeName")--DEBUG
    local playerCamoTypes=InfFova.GetCamoTypes(partsTypeName)
    if playerCamoTypes==nil then
      InfCore.Log("WARNING GetCamoTypes == nil")--DEBUG
      return
    end    
    
    IvarProc.SetSettings(self,playerCamoTypes)
    if #playerCamoTypes==0 then
      InfCore.Log("WARNING #playerCamoTypes==0")--DEBUG
      ivars[self.name]=0
      return
    end

    --InfCore.PrintInspect(playerCamoTypes,"playerCamoTypes")--DEBUG

    local camoName=InfFova.playerCamoTypes[vars.playerCamoType+1]
    --InfCore.PrintInspect(camoName,"camoName")--DEBUG

    local camoSetting=self.enum[camoName]
    if camoSetting==nil then
      camoSetting=0
    end

    self:Set(camoSetting)
  end,
  OnChange=function(self,setting)
    local camoName=self.settings[setting+1]
    vars.playerCamoType=PlayerCamoType[camoName]
  end,
}

--tex for DEBUG, just exploring direct value
this.playerCamoTypeDirect={
  inMission=true,
  range={min=0,max=255},
  OnSelect=function(self)
    self:SetDirect(vars.playerCamoType)
  end,
  OnActivate=function(self,setting)
    vars.playerCamoType=setting
    -- vars.playerPartsType=PlayerPartsType.NORMAL--TODO: camo wont change unless this (one or both, narrow down which) set
    -- vars.playerFaceEquipId=0
  end,
}

this.playerFaceEquipId={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=100},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=function(self,setting)
    local faceEquipId=self.settingsTable[setting+1]
    local faceEquipInfo=InfFova.playerFaceEquipIdInfo[faceEquipId+1]
    return faceEquipInfo.description or faceEquipInfo.name
  end,
  OnSelect=function(self)
    self:SetDirect(0)
    local settingsTable={}
    for i,faceEquipInfo in ipairs(InfFova.playerFaceEquipIdInfo)do
      if faceEquipInfo.playerTypes==nil or faceEquipInfo.playerTypes[vars.playerType] then
        local playerFaceEquipId=i-1
        table.insert(settingsTable,playerFaceEquipId)
        if playerFaceEquipId==vars.playerType then
          self:SetDirect(playerFaceEquipId)
        end
      end
    end

    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnChange=function(self,setting)
    vars.playerFaceEquipId=self.settingsTable[setting+1]
  end,
}

this.playerFaceEquipIdDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=100},--TODO
  OnSelect=function(self)
    self:SetDirect(vars.playerFaceEquipId)
  end,
  OnActivate=function(self,setting)
    vars.playerFaceEquipId=setting
  end,
}

this.playerFaceId={
  inMission=true,
  --save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=0},--DYNAMIC
  currentGender=0,--STATE
  settingsTable={1},--DYNAMIC
  --noSettingCounter=true,
  GetSettingText=function(self,setting)
    return InfCore.PCall(function(self)--DEBUG
      if InfFova.playerTypeGroup.VENOM[vars.playerType] then
        return InfLangProc.LangString"only_for_dd_soldier"
    end

    local faceDefId=self.settingsTable[setting+1]
    local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
    if faceDef==nil then
      local err="ERROR: could not find faceDefinition["..tostring(faceDefId).."]"
      InfCore.Log("Ivars.playerFaceId - "..err)
      return err
    end
    local faceId=faceDef[1]

    if Ivars.playerFaceFilter:Is"FOVAMOD" then
      if not InfSoldierFace.hasFaceFova then
        return InfLangProc.LangString"no_head_fovas"
      end
    end

    local headDefinitionName=InfSoldierFace.headDefinitions[faceId]
    if headDefinitionName then
      local headDefinition=InfSoldierFace.headDefinitions[headDefinitionName]
      local desciption=headDefinition.description or headDefinitionName
      return "faceId:"..faceId.." - "..desciption
    end
    return "faceId:"..faceId
    end,self,setting)--DEBUG
  end,
  OnSelect=function(self)
    --DEBUGNOW what am I doing here?
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self:SetDirect(0)
      self.settingsTable={0}
      self.range.max=0
      return
    end

    --CULL
    --    local faceModSlots={}
    --    for i,slot in ipairs(InfEneFova.faceModSlots)do
    --      local faceId=Soldier2FaceAndBodyData.faceDefinition[slot][1]
    --      faceModSlots[faceId]=true
    --    end

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]
    local settingsTable={}

    local filter=Ivars.playerFaceFilter:GetTableSetting()
    local isUpperLimit=type(filter)=="number"
    local isDirect=type(filter)=="table"
    for faceDefinitionIndex,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      local faceId=entry[1]
      if (isUpperLimit and faceId>=filter) or (isDirect and filter[faceId]) then
        if entry[InfEneFova.faceDefinitionParams.gender]==gender then
          --CULLif not faceModSlots[faceId] then
          table.insert(settingsTable,faceDefinitionIndex)
          --end
        end
      end
    end

    --InfCore.PrintInspect(settingsTable,"settingsTable")--DEBUG

    if #settingsTable==0 then
      self:SetDirect(0)
      self.settingsTable={0}
      self.range.max=0
      return
    end

    --tex don't need to sort, assuming faceDefinition entries are also in ascending faceId

    if self.currentGender~=gender then
      self:SetDirect(0)
    end

    local foundFace=false
    --tex set setting to current face, TODO grinding through whole table isnt that nice, build a faceId to faceDef lookup
    for i,faceDefId in ipairs(settingsTable)do
      local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
      if vars.playerFaceId==faceDef[1] then
        self:SetDirect(i-1)
        foundFace=true
        break
      end
    end

    if not foundFace then
      self:SetDirect(0)
      local faceDefId=settingsTable[1]
      local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
      vars.playerFaceId=faceDef[1]
    end

    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
    self.currentGender=gender
  end,
  OnChange=function(self,setting)
    local faceDefId=self.settingsTable[setting+1]
    if faceDefId==nil then
      InfCore.Log("ivar playerFaceId faceDefId==nil for setting "..tostring(setting))
      return
    end
    local faceDef=Soldier2FaceAndBodyData.faceDefinition[faceDefId]
    vars.playerFaceId=faceDef[1]
  end,
}

this.playerFaceFilter={
  inMission=true,
  --save=IvarProc.CATEGORY_EXTERNAL,
  settings={"ALL","HEADGEAR","UNIQUE","FOVAMOD"},
  settingsTable={
    ALL=0,
    HEADGEAR={
      --male
      [550]=true,--Balaclava Male
      [551]=true,--Balaclava Male
      [552]=true,--DD armor helmet (green top)
      [558]=true,--Gas mask and clava Male
      [560]=true,--Gas mask DD helm Male
      [561]=true,--Gas mask DD greentop helm Male
      [564]=true,--NVG DDgreentop Male
      [565]=true,--NVG DDgreentop GasMask Male
      --female
      [555]=true,--DD armor helmet (green top) female - i cant really tell any difference between
      [559]=true,--Gas mask and clava Female
      [562]=true,--Gas mask DD helm Female
      [563]=true,--Gas mask DD greentop helm Female
      [566]=true,--NVG DDgreentop Female (or just small head male lol, total cover)
      [567]=true,--NVG DDgreentop GasMask
    },
    UNIQUE={
      --male
      [602]=true,--glasses,
      [621]=true,--Tan
      --[622]=true,--hideo, not working outside mission
      [627]=true,--finger
      [628]=true,--eye
      [646]=true,--beardy mcbeard
      [680]=true,--fox hound tattoo
      [683]=true,--red hair]=true, ddogs tattoo
      [684]=true,--fox tattoo
      [687]=true,--while skull tattoo
      [688]=true,--IH hideo entry
      --female
      [681]=true,--female tatoo fox hound black
      [682]=true,--female tatoo whiteblack ddog red hair
      [685]=true,--female tatoo fox black
      [686]=true,--female tatoo skull white white hair
    },

    FOVAMOD=691,--SYNC Soldier2FaceAndBodyData.highestVanillaFaceId,
  },
}

this.playerFaceIdDirect={
  inMission=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=730},
  OnSelect=function(self)
  --OFF self:SetDirect(vars.playerFaceId)
  end,
  OnActivate=function(self,setting)
    vars.playerFaceId=setting
  end,
}

--tex saving prefered faceId per gender
this.maleFaceId={
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  default=0,
  range={min=0,max=5000},--TODO sync max?, Soldier2FaceAndBodyData.MAX_FACEID, but since since ivar gvar size is based on range.max, make sure ivars that change their max during run have a specified fixed size, because I don't  know if the save system is robust enough to handle size changes.
}

this.femaleFaceId={
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  default=350,
  range={min=0,max=5000},--TODO see above
}
--
--tex WIP
this.GetSettingTextFova=function(self,setting)
  if InfFova.playerTypeGroup.VENOM[vars.playerType] then
    return InfLangProc.LangString"only_for_dd_soldier"
  end
  local fovaType=self.name
  local fovaIndex=self.settingsTable[setting+1]
  local fovaName=InfEneFova.GetFovaName(fovaType,fovaIndex)

  local fovaInfo=InfEneFova[fovaType][fovaName]
  if fovaInfo==nil then
    return "could not find InfEneFova."..fovaType
  end
  return fovaInfo.description or fovaInfo.name
end

this.faceFova={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=this.GetSettingTextFova,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

    local settingsNonDup={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if entry[InfEneFova.faceDefinitionParams.gender]==gender then
        local param=entry[InfEneFova.faceDefinitionParams[self.name]]--tex ASSUMPTION ivar same name as param
        settingsNonDup[param]=true
      end
    end

    local settingsTable={}
    for param,bool in pairs(settingsNonDup) do
      table.insert(settingsTable,param)
    end
    table.sort(settingsTable)
    --InfCore.PrintInspect(settingsTable)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --this.ApplyFaceFova()
  end,
}

this.faceDecoFova={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=this.GetSettingTextFova,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end
    --tex since we are going by faceDefinitionParams instead faceDecoFova is dependant on faceFova
    Ivars.faceFova:OnSelect()
    local faceFova=Ivars.faceFova:GetTableSetting()

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

    local settingsNonDup={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if entry[InfEneFova.faceDefinitionParams.gender]==gender then
        if entry[InfEneFova.faceDefinitionParams.faceFova]==faceFova then
          local param=entry[InfEneFova.faceDefinitionParams[self.name]]--tex ASSUMPTION ivar same name as param
          settingsNonDup[param]=true
        end
      end
    end

    local settingsTable={}
    for param,bool in pairs(settingsNonDup) do
      table.insert(settingsTable,param)
    end
    table.sort(settingsTable)
    InfCore.PrintInspect(settingsTable,{varName="Ivars.faceDecoFova.settingsTable"})--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --this.ApplyFaceFova()
  end,
}
this.hairFova={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=this.GetSettingTextFova,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end

    local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

    local settingsNonDup={}
    for i,entry in ipairs(Soldier2FaceAndBodyData.faceDefinition)do
      if entry[InfEneFova.faceDefinitionParams.gender]==gender then
        local index=i-1
        local param=entry[InfEneFova.faceDefinitionParams[self.name]]--tex ASSUMPTION ivar same name as param
        settingsNonDup[param]=true
      end
    end

    local settingsTable={}
    for param,bool in pairs(settingsNonDup) do
      table.insert(settingsTable,param)
    end
    table.sort(settingsTable)
    --InfCore.PrintInspect(settings)--DEBUG
    self.settingsTable=settingsTable
    self.range.max=#settingsTable-1
  end,
  OnActivate=function(self)
  --this.ApplyFaceFova()
  end,
}
this.hairDecoFova={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  settingsTable={0},--DYNAMIC
  GetSettingText=this.GetSettingTextFova,
  OnSelect=function(self)
    if InfFova.playerTypeGroup.VENOM[vars.playerType] then
      self.settings={"NOT_FOR_PLAYERTYPE"}
      self.range.max=0
    end
    self.range.max=#Soldier2FaceAndBodyData.hairDecoFova-1
  end,
  OnActivate=function(self)
  --this.ApplyFaceFova()
  end,
}
--<

this.faceFovaDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.faceFova-1
  end,
  GetSettingText=function(self,setting)
    local fovaInfo=Soldier2FaceAndBodyData.faceFova[setting+1]
    local path=fovaInfo[1]
    return InfUtil.GetFileName(path)
  end,
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceDecoFovaDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.faceDecoFova-1
  end,
  GetSettingText=function(self,setting)
    local fovaInfo=Soldier2FaceAndBodyData.faceDecoFova[setting+1]
    local path=fovaInfo[1]
    return InfUtil.GetFileName(path)
  end,
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.hairFovaDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.hairFova-1
  end,
  GetSettingText=function(self,setting)
    local fovaInfo=Soldier2FaceAndBodyData.hairFova[setting+1]
    local path=fovaInfo[1]
    return InfUtil.GetFileName(path)
  end,
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.hairDecoFovaDirect={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1000},--DYNAMIC
  OnSelect=function(self)
    self.range.max=#Soldier2FaceAndBodyData.hairDecoFova-1
  end,
  GetSettingText=function(self,setting)
    local fovaInfo=Soldier2FaceAndBodyData.hairDecoFova[setting+1]
    local path=fovaInfo[1]
    return InfUtil.GetFileName(path)
  end,
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}

this.faceFovaUnknown1={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=50},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceFovaUnknown2={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.eyeFova={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=4},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.skinFova={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=5},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceFovaUnknown5={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=1},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.uiTextureCount={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=3},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceFovaUnknown7={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=303},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceFovaUnknown8={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=303},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceFovaUnknown9={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=303},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
this.faceFovaUnknown10={
  inMission=true,
  --OFF save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=3},
  OnActivate=function(self)
    this.ApplyFaceFova()
  end,
}
--
--fovaInfo
this.enableFovaMod={
  inMission=true,
  nonConfig=true,--tex too dependant on installed mods/dynamic settings
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  OnSelect=function(self)
  --    if self:Is(1) then
  --    else
  --      InfMenu.PrintLangId"change_model_to_reset_fova"
  --      Ivars.fovaSelection:Reset()
  --    end
  end,
  OnChange=function(self)
    if self:Is(1) then
      Ivars.fovaSelection:Reset()
      InfFova.SetFovaMod(self:Get(),true)
    else
      InfMenu.PrintLangId"change_model_to_reset_fova"
      Ivars.fovaSelection:Reset()
    end
  end,
}

--tex: index into fovaInfor for current playerType,playerPartsType
this.fovaSelection={
  inMission=true,
  nonConfig=true,--tex too dependant on installed mods/dynamic settings
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=255},--DYNAMIC limits max fovas TODO consider
  OnSelect=function(self)
    local fovaTable,modelDescription=InfFova.GetCurrentFovaTable()
    if modelDescription then
      self.description=modelDescription
    else
      self.description="No model description"
    end

    if fovaTable then
      if Ivars.enableFovaMod:Is(0) then
        InfMenu.PrintLangId"fova_is_not_set"
      end

      self.range.max=#fovaTable-1
      if InfFova.FovaInfoChanged(fovaTable,self:Get()+1) then
        --InfCore.DebugPrint"OnSelect FovaInfoChanged"--DEBUG
        self:Reset()
      end

      self.settingNames={}
      for i=1,#fovaTable do
        local fovaDescription,fovaFile=InfFova.GetFovaInfo(fovaTable,i)

        if not fovaDescription or not type(fovaDescription)=="string"then
          self.settingNames[i]=i
        else
          self.settingNames[i]=fovaDescription
        end
      end

      InfFova.SetFovaMod(self:Get()+1,true)
    else
      self.range.max=0
      self.settingNames={InfLangProc.LangString"no_fova_found"}
      return
    end
  end,
  --  OnDeselect=function(self)
  --    InfCore.DebugPrint"fovaSelection OnDeselect"--DEBUG
  --    if Ivars.enableMod:Is(0) then
  --    --InfMenu.PrintLangId"fova_is_not_set"--DEBUG
  --    end
  --  end,
  OnChange=function(self)
    InfFova.SetFovaMod(self:Get()+1,true)
  end,
}

this.fovaPlayerType={--Set
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=3},
}

this.fovaPlayerPartsType={--Set
  nonUser=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range={min=0,max=127},
}

--tex NOTE: not currently exposed
this.skipDevelopChecks={
  inMission=true,
  nonConfig=true,
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
}
--< ivar defs

this.registerMenus={
  "appearanceMenu",
  "appearanceDebugMenu",
  "fovaModMenu",
}

this.fovaModMenu={
  options={
    "Ivars.enableFovaMod",
    "Ivars.fovaSelection",
    "InfMenuCommandsTpp.PrintBodyInfo",
  }
}

this.appearanceMenu={
  nonConfig=true,
  parentRefs={"InfMenuDefs.inMissionMenu","InfMenuDefs.inDemoMenu"},
  options={
    "Ivars.playerType",
    "Ivars.playerPartsType",
    "Ivars.playerCamoType",
    "Ivars.playerFaceEquipId",
    "Ivars.playerFaceFilter",
    "Ivars.playerFaceId",
    "Ivars.skipDevelopChecks",
    "Ivars.avatar_load",
    "Ivars.avatar_save",
    "InfMenuCommandsTpp.PrintFaceInfo",
    "InfMenuCommandsTpp.PrintCurrentAppearance",
    "InfFovaIvars.fovaModMenu",
  }
}

this.appearanceDebugMenu={
  nonConfig=true,
  options={
    "Ivars.faceFovaDirect",
    "Ivars.faceDecoFovaDirect",
    "Ivars.hairFovaDirect",
    "Ivars.hairDecoFovaDirect",
    "Ivars.playerTypeDirect",
    "Ivars.playerPartsTypeDirect",
    "Ivars.playerCamoTypeDirect",
    "Ivars.playerFaceIdDirect",
    "Ivars.playerFaceEquipIdDirect",

    "InfMenuCommandsTpp.PrintFaceInfo",
    "InfMenuCommandsTpp.PrintCurrentAppearance",

    "Ivars.faceFova",
    "Ivars.faceDecoFova",
    "Ivars.hairFova",
    "Ivars.hairDecoFova",

    "Ivars.faceFovaUnknown1",
    "Ivars.faceFovaUnknown2",
    "Ivars.eyeFova",
    "Ivars.skinFova",
    "Ivars.faceFovaUnknown5",
    "Ivars.uiTextureCount",
    "Ivars.faceFovaUnknown7",
    "Ivars.faceFovaUnknown8",
    "Ivars.faceFovaUnknown9",
    "Ivars.faceFovaUnknown10",
    "InfFovaIvars.fovaModMenu",
  }
}
--< menu defs
this.langStrings={
  eng={
    fovaModMenu="Form Variation menu",
    no_fova_found="No fova for model",
    enableFovaMod="Use selected fova",
    fova_is_not_set="Use fova is off, selected fova will not be applied on mission",
    disabled_fova="Player model changed, disabling Use fova",
    change_model_to_reset_fova="Model will reset on mission start, or mission prep character change",
    printBodyInfo="Print current body info",
    playerType="Player type",
    playerPartsType="Suit type",
    playerCamoType="Camo type",
    playerFaceEquipId="Headgear",
    playerFaceId="Face",
    skipDevelopChecks="Skip developed checks",
    printFaceInfo="Print face info",
    printCurrentAppearance="Print appearance info",
    appearanceMenu="Appearance menu",
    only_for_dd_soldier="Only for DD soldiers",
    no_head_fovas="No head fova mods found",
    playerFaceFilter="Filter faces",
    playerFaceFilterSettings={"Show all","Headgear (cosmetic)","Unique","Head fova mods"},
    no_developed_camo="No developed camos found for suit",
    fob_locked_warning="WARNING: Pause menu disabled, may cause other issues",
  },
  help={
    eng={
      playerType="Change main player type. WARNING: Ocelot and Quiet player types have side effect when used due to trying to work around them being restricted to FOB. The Pause menu will be disabled and the game may hit an infinite load if you complete a mission while they are used. Use nexusmods.com/metalgearsolidvtpp/mods/518 by BobDoleOwndU to fix sound issues with using these player types.",
      skipDevelopChecks="Allows items that haven't been developed to be selected.",
    },
  },
}

--tex for face fova ivars
--Soldier2FaceAndBodyData.faceDefinition indexes for
--DEBUGNOW TODO: make so faceDefinition is built from the ivars on startup (just apply same to both so if player loading game with face set you don't have to worry about saving current used mod face slot)
this.faceModSlots={
  512,
  513,
}
this.currentFaceIdSlot=1
function this.ApplyFaceFova()
  if vars.playerType~=PlayerType.DD_MALE and vars.playerType~=PlayerType.DD_FEMALE then
    InfMenu.PrintLangId"setting_only_for_dd"
    return
  end

  local noFova=EnemyFova.INVALID_FOVA_VALUE
  local faceDefinitions=Soldier2FaceAndBodyData.faceDefinition

  --tex since the engine only applies face if vars.playerFaceId changes to a different id I'm just cyling between a couple of faceDefinition entries
  --index in faceDefinition


  local faceFova=Ivars.faceFovaDirect:Get()
  local faceDecoFova=Ivars.faceDecoFovaDirect:Get()
  local hairFova=Ivars.hairFovaDirect:Get()
  local hairDecoFova=Ivars.hairDecoFovaDirect:Get()
  local gender=InfEneFova.PLAYERTYPE_GENDER[vars.playerType]

  local uiTextureName=""

  local unknown1=Ivars.faceFovaUnknown1:Get()
  local unknown2=Ivars.faceFovaUnknown2:Get()
  local eyeFova=Ivars.eyeFova:Get()
  local skinFova=Ivars.skinFova:Get()
  local unknown5=Ivars.faceFovaUnknown5:Get()
  local uiTextureCount=Ivars.uiTextureCount:Get()
  local unknown7=Ivars.faceFovaUnknown7:Get()
  local unknown8=Ivars.faceFovaUnknown8:Get()
  local unknown9=Ivars.faceFovaUnknown9:Get()
  local unknown10=Ivars.faceFovaUnknown10:Get()

  local currentSlotIndex=this.faceModSlots[this.currentFaceIdSlot]
  local currentFaceId=faceDefinitions[currentSlotIndex][1]

  local newFace={
    currentFaceId,
    unknown1,
    gender,
    unknown2,
    faceFova,
    faceDecoFova,
    hairFova,
    hairDecoFova,
    eyeFova,
    skinFova,
    unknown5,
    uiTextureName,
    uiTextureCount,
    unknown7,
    unknown8,
    unknown9,
    unknown10,
  }

  faceDefinitions[currentSlotIndex]=newFace

  --tex GOTCHA crashes after repeated calls, wouldnt really trust it even after one
  TppSoldierFace.SetFaceFovaDefinitionTable{table=faceDefinitions,uiTexBasePath="/Assets/tpp/ui/texture/StaffImage/"}

  vars.playerFaceId=currentFaceId

  if this.currentFaceIdSlot==1 then
    this.currentFaceIdSlot=2
  else
    this.currentFaceIdSlot=1
  end
end--ApplyFaceFova

function this.PrintFaceInfo(faceId)
  local faceAndBodyData=Soldier2FaceAndBodyData
  for i,faceDef in ipairs(faceAndBodyData.faceDefinition)do
    if faceDef[1]==faceId then
      local faceInfoString=""
      for i,fovaType in ipairs(InfSoldierFace.fovaTypes)do
        local index=faceDef[InfEneFova.faceDefinitionParams[fovaType]]
        local fovaInfo=faceAndBodyData[fovaType][index]
        local name
        if fovaInfo then
          name=InfUtil.GetFileName(fovaInfo[1])
        elseif index==EnemyFova.INVALID_FOVA_VALUE then
          name="nil_fova"
        else
          name=index
        end

        local fovaInfoExt=InfEneFova[fovaType][name]
        local description=name
        if fovaInfoExt and fovaInfoExt.description then
          description=description..":"..fovaInfoExt.description
        end

        faceInfoString=faceInfoString..fovaType..":"..description..", "
      end

      InfCore.Log(faceInfoString,true)
      break
    end
  end
end--PrintFaceInfo

return this
