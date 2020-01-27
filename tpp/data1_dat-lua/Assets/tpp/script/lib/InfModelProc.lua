-- DOBUILD: 1
-- InfModelProc.lua
local this={}

--STATE
this.debugModule=false

--tex TODO: not really proc if holding this state
this.fovaInfos={}

--tex fova index lookups by fv2 - this[fovaTypeName][fovaName]=fovaIndex, TABLESETUP in Setup()
--DEBUGNOW TODO put lookups in InfEneFova instead, merge or shift the current tables there
--TODO also integrate fv2 info from external fovainfo modules
this.faceFova={}
this.faceDecoFova={}
this.hairFova={}
this.hairDecoFova={}

this.headDefinitions={}
this.faceDefinitions={}

this.hasFova=false
--
this.fovaTypes={
  "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
}

function this.LoadFovaInfo()
  InfCore.Log("InfModelProc.LoadFovaInfo")
  this.fovaInfos={}
  local fovaInfoFiles=InfCore.GetFileList(InfCore.files.fovaInfo,".lua")
  for i,fileName in ipairs(fovaInfoFiles)do
    InfCore.Log("InfModelProc.LoadFovaInfo: "..fileName)
    this.fovaInfos[fileName]=InfCore.LoadBoxed(InfCore.paths.fovaInfo,fileName)
  end
  if this.debugModule then
    InfCore.PrintInspect(fovaInfoFiles,"fovaInfoFiles")--DEBUG
    InfCore.PrintInspect(this.fovaInfos,"IvarProc.fovaInfos")--DEBUG
  end

  --CULL
  --    this.infModelRegistry=InfCore.LoadBoxed(InfCore.paths.mod,"InfModelRegistry.lua")
  --    if this.infModelRegistry then
  --      local commonHeadPath="/Assets/tpp/pack/fova/common_source/chara/cm_head/"
  --      for i,moduleName in ipairs(this.infModelRegistry.headFovaModNames)do
  --        if type(moduleName)=="string"then
  --          Script.LoadLibrary(commonHeadPath..moduleName..".lua")
  --          if _G[moduleName] then
  --            InfCore.Log("InfModelRegistry loaded module "..moduleName)
  --          else
  --            InfCore.Log("InfModelRegistry could not load module "..moduleName)
  --          end
  --        end
  --      end
  --    end
end

--tex patches Solder2FaceAndBodyData.faceDefinition acording to fovaInfo files
--IN/OUT Solder2FaceAndBodyData.lua
function this.Setup(faceAndBodyData)
  InfCore.LogFlow"InfModelRegistry.Setup:"
  local genders={
    MALE=0,
    FEMALE=1,
  }

  --tex clear this state
  for i,fovaTypeName in ipairs(this.fovaTypes) do
    this[fovaTypeName]={}
  end
  this.headDefinitions={}
  this.faceDefinitions={}

  --tex add fova entries from fovaInfos
  --tex TODO validate
  for moduleName,module in pairs(this.fovaInfos)do
    for i,fovaTypeName in ipairs(this.fovaTypes) do
      local localFova=faceAndBodyData[fovaTypeName]
      local moduleFova=module[fovaTypeName]
      if moduleFova then
        for i,fovaInfo in ipairs(moduleFova)do
          local fovaIndex=#localFova+1
          if type(fovaInfo)=="table" then
            localFova[fovaIndex]=fovaInfo
            this.hasFova=true
          end
        end
      end
    end
  end
  
  --tex build fova file name lookup to fova index tables
  for i,fovaTypeName in ipairs(this.fovaTypes) do
    for fovaIndex,fovaInfo in ipairs(faceAndBodyData[fovaTypeName]) do
      local fovaName=InfUtil.GetFileName(fovaInfo[1])
      local existing=this[fovaTypeName][fovaName]
      if existing~=nil then
        InfCore.Log("InfModelProc.Setup: "..fovaTypeName.."."..fovaName.." already has index "..existing)
      end
      this[fovaTypeName][fovaName]=fovaIndex-1--tex shift from lua indexed (from 1), to fova indexed (from 0)
    end
  end

  --tex build faceAndBodyData faceDefinition from fovaInfo head definitions
  for moduleName,module in pairs(this.fovaInfos)do
    local headDefinitions=module.headDefinitions
    if headDefinitions then
      local definitionIndex=#faceAndBodyData.faceDefinition
      local currentFaceId=faceAndBodyData.faceDefinition[definitionIndex][1]
      InfCore.Log("#faceDefinitions:"..definitionIndex.." start faceId:"..currentFaceId)--DEBUG
      for definitionName,headDefinition in pairs(headDefinitions)do
        local definitionOK=true
        for i,fovaTypeName in ipairs(this.fovaTypes) do
          local fovaName=headDefinition[fovaTypeName]
          --TODO type check fovaName
          if fovaName and not this[fovaTypeName][fovaName] then
            InfCore.Log("InfModelProc.Setup: WARNING: invalid head definition "..definitionName..", could not find "..fovaTypeName.."."..fovaName)
            definitionOK=false
            break
          end
        end

        if definitionOK then
          currentFaceId=currentFaceId+1
          definitionIndex=definitionIndex+1
          local newFace={
            currentFaceId,
            0,--unk1
            genders[headDefinition.gender],
            0,--unk2
            this.faceFova[headDefinition.faceFova] or EnemyFova.INVALID_FOVA_VALUE,
            this.faceDecoFova[headDefinition.faceDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
            this.hairFova[headDefinition.hairFova] or EnemyFova.INVALID_FOVA_VALUE,
            this.hairDecoFova[headDefinition.hairDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
            0,--unk3
            0,--unk4
            0,--unk5
            "",--uiTextureName
            1,--unk6
            0,--unk7            
            0,--unk8
            0,--unk9
            0,--unk10
          }
          
          --DEBUGEXP balaclava experiment
--         local newFace={
--            currentFaceId,
--            16,--unk1
--            genders[headDefinition.gender],
--            0,--unk2
--            this.faceFova[headDefinition.faceFova] or EnemyFova.INVALID_FOVA_VALUE,
--            this.faceDecoFova[headDefinition.faceDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
--            this.hairFova[headDefinition.hairFova] or EnemyFova.INVALID_FOVA_VALUE,
--            this.hairDecoFova[headDefinition.hairDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
--            EnemyFova.INVALID_FOVA_VALUE,--unk3
--            EnemyFova.INVALID_FOVA_VALUE,--unk4
--            0,--unk5
--            "",--uiTextureName
--            0,--unk6
--          }

              
          faceAndBodyData.faceDefinition[definitionIndex]=newFace
          TppEnemyFaceId[definitionName]=currentFaceId

          headDefinition.faceId=currentFaceId
          headDefinition.faceDefinitionIndex=definitionIndex

          this.faceDefinitions[definitionName]=newFace
          this.headDefinitions[definitionName]=headDefinition
          this.headDefinitions[currentFaceId]=definitionName
        end
      end
    end
  end

  --tex update fova counts for TppSoldierFace.SetFovaFileTable
  if this.debugModule then
    InfCore.PrintInspect(faceAndBodyData.fovaFileTable)
  end
  for i,fovaTypeName in ipairs(this.fovaTypes) do
    local defaultCount=faceAndBodyData.fovaFileTable[fovaTypeName].maxCount
    faceAndBodyData.fovaFileTable[fovaTypeName].maxCount=math.max(defaultCount,#faceAndBodyData[fovaTypeName]+1)
  end
  if this.debugModule then
    InfCore.PrintInspect(faceAndBodyData.fovaFileTable)

    InfCore.PrintInspect(this,"InfModelProc")
    InfCore.PrintInspect(faceAndBodyData,"faceAndBodyData")
  end
end

--EXEC
InfCore.PCall(this.LoadFovaInfo)

return this
