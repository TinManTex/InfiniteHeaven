-- InfResources.lua
-- tex implements resrouce scaling via ivar resourceAmountScale / this.ScaleResourceTables()
local this={}

local IsTable=Tpp.IsTypeTable

this.debugModule=false

--tex various default resource amount tables gathered from different vanilla files.

--TppDefine
this.SMALL_DIAMOND_GMP=10000
this.LARGE_DIAMOND_GMP=100000

--MbmCommonSetting20BaseRecSec.lua

--STATE
--tex GOTCHA I think values might be capped at 10k
this.scaledContainerParams={
  commonMetalCounts={white=750,red=7500,yellow=1500},
  fuelResourceCounts={white=750,red=7500,yellow=1500},
  bioticResourceCounts={white=750,red=7500,yellow=1500},
  minorMetalCounts={white=400,red=4000,yellow=800},
  preciousMetalCounts={white=50,red=500,yellow=100},
  usableResourceContainerRate=50,
  redContainerCountRate=40,
  yellowContainerCountRate=40
}

--defaults
this.containerParams={
  commonMetalCounts={white=750,red=7500,yellow=1500},
  fuelResourceCounts={white=750,red=7500,yellow=1500},
  bioticResourceCounts={white=750,red=7500,yellow=1500},
  minorMetalCounts={white=400,red=4000,yellow=800},
  preciousMetalCounts={white=50,red=500,yellow=100},
  usableResourceContainerRate=50,
  redContainerCountRate=40,
  yellowContainerCountRate=40
}

--TppTerminal.lua
--tex added scaleType
this.RESOURCE_INFORMATION_TABLE={
  [TppCollection.TYPE_MATERIAL_CM_0]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_1]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_2]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_3]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_4]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_5]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_6]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_CM_7]={resourceName="CommonMetal",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_0]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_1]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_2]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_3]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_4]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_5]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_6]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_MM_7]={resourceName="MinorMetal",count=50,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_0]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_1]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_2]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_3]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_4]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_5]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_6]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_PM_7]={resourceName="PreciousMetal",count=10,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_0]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_1]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_2]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_3]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_4]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_5]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_6]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_FR_7]={resourceName="FuelResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_0]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_1]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_2]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_3]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_4]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_5]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_6]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_MATERIAL_BR_7]={resourceName="BioticResource",count=100,scaleType="Material"},
  [TppCollection.TYPE_HERB_G_CRESCENT]={resourceName="Plant2000",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_A_PEACH]={resourceName="Plant2001",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_DIGITALIS_P]={resourceName="Plant2002",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_DIGITALIS_R]={resourceName="Plant2003",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_B_CARROT]={resourceName="Plant2004",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_WORM_WOOD]={resourceName="Plant2005",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_TARRAGON]={resourceName="Plant2006",count=10,scaleType="Plant"},
  [TppCollection.TYPE_HERB_HAOMA]={resourceName="Plant2007",count=10,scaleType="Plant"},
  [TppCollection.TYPE_POSTER_SOL_AFGN]={resourceName="Poster1000",count=1,scaleType="Poster"},
  [TppCollection.TYPE_POSTER_SOL_MAFR]={resourceName="Poster1001",count=1,scaleType="Poster"},
  [TppCollection.TYPE_POSTER_SOL_ZRS]={resourceName="Poster1002",count=1,scaleType="Poster"},
  [TppCollection.TYPE_POSTER_GRAVURE_V]={resourceName="Poster1003",count=1,scaleType="Poster"},
  [TppCollection.TYPE_POSTER_GRAVURE_H]={resourceName="Poster1004",count=1,scaleType="Poster"},
  [TppCollection.TYPE_POSTER_MOE_V]={resourceName="Poster1005",count=1,scaleType="Poster"},
  [TppCollection.TYPE_POSTER_MOE_H]={resourceName="Poster1006",count=1,scaleType="Poster"},
}

--tex see Ivars.resourceScaleTypes

--tex pretty much above default tables * resource scale
function this.ScaleResourceTables()
  for collectionType,collectionInfo in pairs(TppTerminal.RESOURCE_INFORMATION_TABLE)do
    local defaultInfo=this.RESOURCE_INFORMATION_TABLE[collectionType]
    local resourceScale=Ivars["resourceScale"..defaultInfo.scaleType]:Get()/100
    collectionInfo.count=this.RESOURCE_INFORMATION_TABLE[collectionType].count*resourceScale
  end

  local diamondScale=Ivars.resourceScaleDiamond:Get()/100
  local smallDiamondGmp=this.SMALL_DIAMOND_GMP*diamondScale
  local largeDiamondGmp=this.LARGE_DIAMOND_GMP*diamondScale

  TppMotherBaseManagement.SetSmallDiamondGmp{gmp=smallDiamondGmp}
  TppMotherBaseManagement.SetLargeDiamondGmp{gmp=largeDiamondGmp}

  local containerScale=Ivars.resourceScaleContainer:Get()/100
  for k,resourceCounts in pairs(this.scaledContainerParams) do
    local defaultResourceCounts=this.containerParams[k]
    if IsTable(resourceCounts) then
      for containerType,resourceCount in pairs(resourceCounts) do
        resourceCounts[containerType]=defaultResourceCounts[containerType]*containerScale
      end
    end
  end

  TppMotherBaseManagement.RegisterContainerParam(this.scaledContainerParams)

  if this.debugModule then
    for i,scaleType in ipairs(Ivars.resourceScaleTypes) do
      local resourceScale=Ivars["resourceScale"..scaleType]:Get()/100
      InfCore.Log("resourceScale"..scaleType.."="..tostring(resourceScale))
    end


    InfCore.Log("RESOURCE_INFORMATION_TABLE")
    InfCore.PrintInspect(this.RESOURCE_INFORMATION_TABLE)

    InfCore.Log("scaled RESOURCE_INFORMATION_TABLE")
    InfCore.PrintInspect(TppTerminal.RESOURCE_INFORMATION_TABLE)

    InfCore.Log("smallDiamondGmp:"..this.SMALL_DIAMOND_GMP.." largeDiamondGmp:"..this.LARGE_DIAMOND_GMP)
    InfCore.Log("scaled smallDiamondGmp:"..smallDiamondGmp.." largeDiamondGmp:"..largeDiamondGmp)

    InfCore.PrintInspect(this.containerParams,{varName="containerParams"})

    InfCore.PrintInspect(this.scaledContainerParams,{varName="scaledContainerParams"})
  end
end

function this.DefaultResourceTables()
  for collectionType,collectionInfo in pairs(TppTerminal.RESOURCE_INFORMATION_TABLE)do
    local defaultInfo=this.RESOURCE_INFORMATION_TABLE[collectionType]
    collectionInfo.count=this.RESOURCE_INFORMATION_TABLE[collectionType].count
  end

  local smallDiamondGmp=this.SMALL_DIAMOND_GMP
  local largeDiamondGmp=this.LARGE_DIAMOND_GMP

  TppMotherBaseManagement.SetSmallDiamondGmp{gmp=smallDiamondGmp}
  TppMotherBaseManagement.SetLargeDiamondGmp{gmp=largeDiamondGmp}


  TppMotherBaseManagement.RegisterContainerParam(this.containerParams)
end

function this.OnAllocate(missionTable)
  if Ivars.enableResourceScale:Is(1) then
    this.ScaleResourceTables()
  end
end

return this
