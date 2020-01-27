-- DOBUILD: 1
-- InfModelProc.lua
local this={}

--STATE
this.debugModule=false

--tex TODO: not really proc if holding this state
this.fovaInfos={}
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
--IN/OUT faceDefinition -
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

  --tex TODO validate
  for moduleName,module in pairs(this.fovaInfos)do
    for i,fovaTypeName in ipairs(this.fovaTypes) do
      local localFova=faceAndBodyData[fovaTypeName]
      local moduleFova=module[fovaTypeName]
      if moduleFova then
        for fovaName,fovaInfo in pairs(moduleFova)do
          local fovaIndex=#localFova+1
          if type(fovaInfo)=="table" then
            localFova[fovaIndex]=fovaInfo
            if this[fovaTypeName][fovaName] then
              InfCore.Log("Conflict module:"..fovaTypeName.."."..fovaName)
            end
            this[fovaTypeName][fovaName]=fovaIndex-1
            this.hasFova=true
          end
        end
      end
    end

    local headDefinitions=module.headDefinitions
    if headDefinitions then
      local definitionIndex=#faceAndBodyData.faceDefinition
      local currentFaceId=faceAndBodyData.faceDefinition[definitionIndex][1]
      InfCore.Log("#faceDefinitions:"..definitionIndex.." start faceId:"..currentFaceId)--DEBUG
      for definitionName,headDefinition in pairs(headDefinitions)do
        currentFaceId=currentFaceId+1
        definitionIndex=definitionIndex+1
        local newFace={
          currentFaceId,
          0,
          genders[headDefinition.gender],
          0,
          this.faceFova[headDefinition.faceFova] or EnemyFova.INVALID_FOVA_VALUE,
          this.faceDecoFova[headDefinition.faceDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
          this.hairFova[headDefinition.hairFova] or EnemyFova.INVALID_FOVA_VALUE,
          this.hairDecoFova[headDefinition.hairDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
          0,
          0,
          0,
          "",
          1,
          0,
          0,
          0,
          0,
        }

        headDefinition.faceId=currentFaceId
        headDefinition.faceDefinitionIndex=definitionIndex

        faceAndBodyData.faceDefinition[definitionIndex]=newFace
        this.faceDefinitions[definitionName]=newFace
        this.headDefinitions[definitionName]=headDefinition
        this.headDefinitions[currentFaceId]=definitionName
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
