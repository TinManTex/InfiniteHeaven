-- DOBUILD: 1
-- InfModelProc.lua
local this={}

this.infModelRegistry={}

InfCore.LogFlow"Load InfModelRegistry.lua"
function this.LoadLibraries()
  this.infModelRegistry=InfCore.LoadBoxed"InfModelRegistry.lua"
  if this.infModelRegistry then
    local commonHeadPath="/Assets/tpp/pack/fova/common_source/chara/cm_head/"
    for i,moduleName in ipairs(this.infModelRegistry.headFovaModNames)do
      if type(moduleName)=="string"then
        Script.LoadLibrary(commonHeadPath..moduleName..".lua")
        if _G[moduleName] then
          InfCore.Log("InfModelRegistry loaded module "..moduleName)
        else
          InfCore.Log("InfModelRegistry could not load module "..moduleName)
        end
      end
    end
  end
end

--tex patches Solder2FaceAndBodyData.faceDefinition acording to infModelRegistry
--IN/OUT faceDefinition - 
function this.Setup(faceDefinition)
  local fovaTypes={
    "faceFova",
    "faceDecoFova",
    "hairFova",
    "hairDecoFova",
  }
  local genders={
    MALE=0,
    FEMALE=1,
  }

  --local InfModelRegistry=InfModelRegistry
  InfCore.LogFlow"InfModelRegistry setup"
  local InfModelRegistry=this.infModelRegistry
  if InfModelRegistry then
    --InfCore.Log("InfModelRegistry Setup")
    for i,fovaTypeName in ipairs(fovaTypes) do
      InfModelRegistry[fovaTypeName]={}
    end
    InfModelRegistry.headDefinitions={}--headdefinition indicies
    for i,moduleName in ipairs(InfModelRegistry.headFovaModNames)do
      if type(moduleName)=="string"then
        local module=_G[moduleName]
        if not module then
          InfCore.Log("InfModelRegistry could not find lua module "..moduleName)
        else
          for i,fovaTypeName in ipairs(fovaTypes) do
            local localFova=this[fovaTypeName]
            local moduleFova=module[fovaTypeName]
            if moduleFova then
              for fovaName,fovaInfo in pairs(moduleFova)do
                local fovaIndex=#localFova+1
                if type(fovaInfo)=="table" then
                  localFova[fovaIndex]=fovaInfo
                  if InfModelRegistry[fovaTypeName][fovaName] then
                    InfCore.Log("Conflict module:"..fovaTypeName.."."..fovaName)
                  end
                  InfModelRegistry[fovaTypeName][fovaName]=fovaIndex-1
                end
              end
            end
          end

          local headDefinitions=module.headDefinitions
          if headDefinitions then
            local definitionIndex=#faceDefinition
            local currentFaceId=faceDefinition[definitionIndex][1]
            for definitionName,headDefinition in pairs(headDefinitions)do
              currentFaceId=currentFaceId+1
              definitionIndex=definitionIndex+1
              local newFace={
                currentFaceId,
                0,
                genders[headDefinition.gender],
                0,
                InfModelRegistry.faceFova[headDefinition.faceFova] or EnemyFova.INVALID_FOVA_VALUE,
                InfModelRegistry.faceDecoFova[headDefinition.faceDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
                InfModelRegistry.hairFova[headDefinition.hairFova] or EnemyFova.INVALID_FOVA_VALUE,
                InfModelRegistry.hairDecoFova[headDefinition.hairDecoFova] or EnemyFova.INVALID_FOVA_VALUE,
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
              faceDefinition[definitionIndex]=newFace
              headDefinition.faceId=currentFaceId
              headDefinition.definitionIndex=definitionIndex
              InfModelRegistry.headDefinitions[definitionName]=headDefinition
              InfModelRegistry.headDefinitions[currentFaceId]=definitionName
            end
          end
        end
      end
    end
  end
end

--EXEC
this.LoadLibraries()

return this
