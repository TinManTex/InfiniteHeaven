-- InfModelProc.lua --TODO bad name, rename
-- Loads addons in \mod\fovaInfo which add face or body fova entries to Solder2FaceAndBodyData

--GOTCHA: There seems to be a limit to the number of additions for body fovas, which manifests in fovas past that not applying
--dont know if its for bodyDefinition or bodyFova count though.
--seems to be vanilla count + 64 = 366
--TODO: when fv2 random variation is figured out could crush down the FATIGUES_CAMO_MIX from ~60 to just 1, or a few similar sets

local this={}

--STATE
this.debugModule=false

--tex TODO: not really proc if holding this state
this.fovaInfos={}
--REF mod\fovaInfo\example_head_fovaInfo
--local this={
--  faceFova={
--    {"/Assets/tpp/fova/common_source/chara/cm_head/face/example_face1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face/example_face1.fpk"},
--  },
--  faceDecoFova={
--    {"/Assets/tpp/fova/common_source/chara/cm_head/face_deco/example_faceDeco1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/face_deco/example_faceDeco1.fpk"},
--  },
--  hairFova={
--    {"/Assets/tpp/fova/common_source/chara/cm_head/hair/example_hair1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair/example_hair1.fpk"},
--  },
--
--  hairDecoFova={
--    {"/Assets/tpp/fova/common_source/chara/cm_head/hair_deco/example_hairDeco1.fv2","/Assets/tpp/pack/fova/common_source/chara/cm_head/hair_deco/example_hairDeco1.fpk"},
--  },
--
--  headDefinitions={
--    example_head1={
--      description="Example 1",
--      gender="FEMALE",-- "MALE", "FEMALE" - must be allcaps
--      faceFova="example_face1.fv2",--Indexes into faceFova by .fv2 name, can be existing Soldier2FaceAndBodyData entry
--      faceDecoFova="example_faceDeco1.fv2",
--      hairFova="example_hair1.fv2",
--      hairDecoFova="example_hairDeco1.fv2",
--    },
--  },
--}

--REF mod\fovaInfo\uss0_main0
--local this={
--  bodyFova={
--    {"/Assets/tpp/fova/chara/uss/uss0_main0_v00.fv2","/Assets/tpp/pack/fova/chara/uss/uss0_main0_v00.fpk"},
--    {"/Assets/tpp/fova/chara/uss/uss0_main0_v01.fv2","/Assets/tpp/pack/fova/chara/uss/uss0_main0_v01.fpk"},
--    {"/Assets/tpp/fova/chara/uss/uss0_main0_v02.fv2","/Assets/tpp/pack/fova/chara/uss/uss0_main0_v02.fpk"},
--    {"/Assets/tpp/fova/chara/uss/uss0_main0_v03.fv2","/Assets/tpp/pack/fova/chara/uss/uss0_main0_v03.fpk"},
--    {"/Assets/tpp/fova/chara/uss/uss0_main0_v04.fv2","/Assets/tpp/pack/fova/chara/uss/uss0_main0_v04.fpk"},
--  },
--
--  bodyDefinitions={
--    uss0_main0_v00={
--      description="USS Soldier - fatigues camo, no equipment",
--      bodyFova="uss0_main0_v00.fv2",
--    },
--    uss0_main0_v01={
--      description="USS Soldier - fatigues drab, no equipment",
--      bodyFova="uss0_main0_v01.fv2",
--    },
--    uss0_main0_v02={
--      description="USS Soldier - fatigues camo, harness, all belt equipment",
--      bodyFova="uss0_main0_v02.fv2",
--    },
--    uss0_main0_v03={
--      description="USS Soldier - fatigues drab, harness, all belt equipment",
--      bodyFova="uss0_main0_v03.fv2",
--    },
--    uss0_main0_v04={
--      description="USS Soldier - fatigues drab, heli gear",
--      bodyFova="uss0_main0_v04.fv2",
--    },
--  },
--}
--return this

local bodyFovaLimit=366

this.bodyFova={}
--tex fova index lookups by fv2 - this[fovaTypeName][fovaName]=fovaIndex, TABLESETUP in Setup()
--TODO put lookups in InfEneFova instead, merge or shift the current tables there
--TODO also integrate fv2 info from external fovainfo modules
this.faceFova={}
this.faceDecoFova={}
this.hairFova={}
this.hairDecoFova={}

this.headDefinitions={}
this.faceDefinitions={}

this.hasFaceFova=false
--
this.fovaTypes={
  "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
  "bodyFova",
}

this.faceFovaTypes={
  "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
}

this.bodyFovaTypes={
  "bodyFova",
}

function this.LoadFovaInfo()
  InfCore.Log("InfModelProc.LoadFovaInfo")
  this.fovaInfos={}
  if not InfCore.files.fovaInfo then
    return
  end

  local fovaInfoFiles=InfCore.GetFileList(InfCore.files.fovaInfo,".lua")
  for i,fileName in ipairs(fovaInfoFiles)do
    InfCore.Log("InfModelProc.LoadFovaInfo: "..fileName)
    local box=false
    local fovaInfo=InfCore.LoadSimpleModule(InfCore.paths.fovaInfo,fileName,box)
    if fovaInfo==nil then
      InfCore.Log("ERROR: InfModelProc.LoadFovaInfo: fovaInfo "..fileName.." ==nil")
    else
      this.fovaInfos[fileName]=fovaInfo
    end
  end
  if this.debugModule then
    InfCore.PrintInspect(fovaInfoFiles,"fovaInfoFiles")--DEBUG
    InfCore.PrintInspect(this.fovaInfos,"IvarProc.fovaInfos")--DEBUG
  end
end

--IN/SIDE this[fovaTypeName]
function this.CheckDefinition(definition,fovaTypes,definitionName)
  local definitionOK=true
  for i,fovaTypeName in ipairs(fovaTypes) do
    local fovaName=definition[fovaTypeName]
    --TODO type check fovaName
    if fovaName and not this[fovaTypeName][fovaName] then
      InfCore.Log("WARNING: InfModelProc.CheckDefinition: invalid definition "..definitionName..", could not find "..fovaTypeName.."."..fovaName)
      definitionOK=false
      break
    end
  end

  return definitionOK
end

--tex patches Solder2FaceAndBodyData.faceDefinition acording to fovaInfo files
--IN/OUT Solder2FaceAndBodyData.lua
function this.Setup(faceAndBodyData)
  InfCore.LogFlow"InfModelProc.SetupFova:"

  --tex clear this state
  for i,fovaTypeName in ipairs(this.fovaTypes) do
    this[fovaTypeName]={}
  end

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

  this.SetupFaceFova(faceAndBodyData)
  this.SetupBodyFova(faceAndBodyData)
  
    if this.debugModule then
      InfCore.PrintInspect(faceAndBodyData,"Soldier2FaceAndBodyData")
      InfCore.Log("#faceAndBodyData.bodyFova:"..#faceAndBodyData.bodyFova)--DEBUGNOW
    end
end
--tex patches Solder2FaceAndBodyData.faceDefinition acording to fovaInfo files
--IN/OUT Solder2FaceAndBodyData.lua
function this.SetupFaceFova(faceAndBodyData)
  local genders={
    MALE=0,
    FEMALE=1,
  }

  this.headDefinitions={}
  this.faceDefinitions={}

  this.hasFaceFova=false

  --tex build faceAndBodyData faceDefinition from fovaInfo head definitions
  for moduleName,module in pairs(this.fovaInfos)do
    local headDefinitions=module.headDefinitions
    if headDefinitions then
      this.hasFaceFova=true
      local definitionIndex=#faceAndBodyData.faceDefinition
      local currentFaceId=faceAndBodyData.faceDefinition[definitionIndex][1]
      InfCore.Log("#faceDefinitions:"..definitionIndex.." start faceId:"..currentFaceId)--DEBUG
      for definitionName,headDefinition in pairs(headDefinitions)do
        if this.CheckDefinition(headDefinition,this.faceFovaTypes,definitionName) then
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
        end--if checkDefintion
      end--for module.headDefinitions
    end--if module.headDefinitions
  end--for fovaInfos

  --tex update fova counts for TppSoldierFace.SetFovaFileTable
  if this.debugModule then
    InfCore.PrintInspect(faceAndBodyData.fovaFileTable)
  end
  for i,fovaTypeName in ipairs(this.faceFovaTypes) do
    local defaultCount=faceAndBodyData.fovaFileTable[fovaTypeName].maxCount
    faceAndBodyData.fovaFileTable[fovaTypeName].maxCount=math.max(defaultCount,#faceAndBodyData[fovaTypeName]+1)
  end
  if this.debugModule then
    InfCore.PrintInspect(faceAndBodyData.fovaFileTable)
  end

  if this.debugModule then
    InfCore.PrintInspect(this,"InfModelProc")
    InfCore.PrintInspect(faceAndBodyData,"faceAndBodyData")
  end
end

-- bodies

--DEBUGNOW CULL
  --  {--MSF_MEDIC
  --    name="DDS0_MAIN2",
  --    chara="dds",
  --    fpkChara="dds",
  --    idFmt="uss0_main0_v%02d",
  --    fpkFmt="/Assets/tpp/pack/fova/chara/dds/dds0_main2_v%02d_ih",
  --    fovas={
  --      1,
  --      2,
  --      4,
  --      5,
  --    },
  --  },

  --TODO look at the incomplete wss4_main0 entries in soldier2faceandbodydata
  --  {"/Assets/tpp/fova/chara/wss/wss4_main0_v00.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00_ih.fpk"},--256,410,,
  --  {"/Assets/tpp/fova/chara/wss/wss4_main0_v01.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00_ih.fpk"},--257,411,,
  --  {"/Assets/tpp/fova/chara/wss/wss4_main0_v01.fv2","/Assets/tpp/pack/fova/chara/wss/wss4_main0_v00_ih.fpk"},--258,412,,
  --<


--tex Adds body fova info to Solder2FaceAndBodyData
--IN/OUT Solder2FaceAndBodyData.lua
function this.SetupBodyFova(faceAndBodyData)
  InfCore.LogFlow("InfEneBodyFova.Setup:")

  this.bodyDefinitions={}

  for moduleName,module in pairs(this.fovaInfos)do
    local bodyDefinitions=module.bodyDefinitions
    if bodyDefinitions then
      local definitionIndex=#faceAndBodyData.bodyDefinition
      local currentBodyId=faceAndBodyData.bodyDefinition[definitionIndex][1]
      InfCore.Log("#bodyDefinitions:"..definitionIndex.." start bodyId:"..currentBodyId)--DEBUG
      for definitionName,definition in pairs(bodyDefinitions)do
        if this.CheckDefinition(definition,this.bodyFovaTypes,definitionName) then
          currentBodyId=currentBodyId+1
          definitionIndex=definitionIndex+1
          local currentBodyFova=this.bodyFova[definition.bodyFova]
          local isArmor=definition.isArmor or 0
          local newBody={
            currentBodyId,
            currentBodyFova,
            isArmor
          }
          faceAndBodyData.bodyDefinition[definitionIndex]=newBody
          TppEnemyBodyId[definitionName]=currentBodyId

          definition.bodyId=currentBodyId
          definition.bodyDefinitionIndex=definitionIndex

          this.bodyDefinitions[definitionName]=definition
          this.bodyDefinitions[currentBodyId]=definitionName
        end--if checkDefintion
      end--for module.bodyDefinitions
    end--if module.bodyDefinitions
  end--for fovaInfos

  --tex set .maxCount
  for i,fovaTypeName in ipairs(this.bodyFovaTypes) do
    local fileTableInfo=faceAndBodyData.fovaFileTable[fovaTypeName]
    local defaultCount=fileTableInfo.maxCount
    fileTableInfo.maxCount=math.max(defaultCount,#faceAndBodyData[fovaTypeName]+1)
  end
  
  if #faceAndBodyData.bodyFova>=bodyFovaLimit then
    InfCore.Log("WARNING: SetupBodyFova: hit bodyFova limit, too many additional body fovaInfos installed",false,true)
  end

  if this.debugModule then
    InfCore.PrintInspect(this,"InfEneBodyFova")
    InfCore.PrintInspect(faceAndBodyData,"faceAndBodyData")
    InfCore.PrintInspect(TppEnemyBodyId,"TppEnemyBodyId")
    InfCore.Log("#bodyDefinition:"..#faceAndBodyData.bodyDefinition..", #bodyFova:"..#faceAndBodyData.bodyFova)
  end
end

return this
