-- DOBUILD: 1
--InfEneFova.lua

local this={}
local InfEneFova=this

this.debugModule=false

--
this.inf_wildCardMaleFaceList={}
this.inf_wildCardFemaleFaceList={}

this.bodyTypes={
  SOLDIER=1,
  HOSTAGE=2,
}

this.basePackPaths={
  SOLDIER="/Assets/tpp/pack/mission2/ih/ih_soldier_base.fpk",--tex built off mis_com_dd_soldier_wait.fpk
  HOSTAGE="/Assets/tpp/pack/mission2/ih/ih_hostage_base.fpk",--tex built off mis_com_mafr_hostage.fpk
}

this.ddSuitToDDBodyInfo={
  [TppEnemy.FOB_DD_SUIT_SNEAKING]="SNEAKING_SUIT",
  [TppEnemy.FOB_DD_SUIT_BTRDRS]="BATTLE_DRESS",
  [TppEnemy.FOB_PF_SUIT_ARMOR]="PFA_ARMOR",
  [TppEnemy.FOB_DD_SUIT_ATTCKER]="TIGER",
}

--tex see TppEnemyFaceId
--{[TppEnemyFaceId id]=faceInfo{},}
this.ddHeadGearInfo={
  --HMT=DD greentop
  --tex OFF till I put selection in
  --  svs_balaclava={--550,  --[M][---][---][---] Balaclava
  --    MALE=true,
  --  },
  --  pfs_balaclava={--551,  --[M][---][---][---] Balaclava
  --    MALE=true,
  --  },
  dds_balaclava0={--552, --[M][---][---][HMT] DD
    MALE=true,
    HELMET=true,
  },
  dds_balaclava1={--553, --[M][---][---][---] DD blacktop  - some oddness here this shows as helmet/greentop (like 552) when player face set to this, so is the fova for player not set right? TODO: sort this out, force balaclava for soldiers to each
    MALE=true,
  },
  dds_balaclava2={--554, --[M][---][---][---] DD no blacktop - same issue as above
    MALE=true,
  },
  dds_balaclava3={--555, --[F][---][---][HMT] DD
    FEMALE=true,
    HELMET=true,
  },
  dds_balaclava4={--556, --[F][---][---][---] DD blacktop - same issue as above (but shows as equivalent 555)
    FEMALE=true,
  },
  dds_balaclava5={--557, --[F][---][---][---] DD blacktop - same issue as above
    FEMALE=true,
  },
  dds_balaclava6={--558, --[M][GAS][---][---] DD open clava
    MALE=true,
    GAS_MASK=true,
  },
  dds_balaclava7={--559, --[F][GAS][---][---] DD open clava
    FEMALE=true,
    GAS_MASK=true,
  },
  dds_balaclava8={--560, --[M][GAS][---][---] DD clava and blacktop
    MALE=true,
    GAS_MASK=true,
  },
  dds_balaclava9={--561, --[M][GAS][---][HMT] DD
    MALE=true,
    GAS_MASK=true,
    HELMET=true,
  },
  dds_balaclava10={--562,--[F][GAS][---][---] DD clava and blacktop
    FEMALE=true,
    GAS_MASK=true,
  },
  dds_balaclava11={--563,--[F][GAS][---][HMT] DD
    FEMALE=true,
    GAS_MASK=true,
    HELMET=true,
  },
  dds_balaclava12={--564,--[M][---][NVG][HMT] DD
    MALE=true,
    NVG=true,
    HELMET=true,
  },
  dds_balaclava13={--565,--[M][GAS][NVG][HMT] DD
    MALE=true,
    GAS_MASK=true,
    NVG=true,
    HELMET=true,
  },
  dds_balaclava14={--566,--[F][---][NVG][HMT] DD
    FEMALE=true,
    NVG=true,
    HELMET=true,
  },
  dds_balaclava15={--567,--[F][GAS][NVG][HMT] DD
    FEMALE=true,
    GAS_MASK=true,
    NVG=true,
    HELMET=true,
  },
}

--UNUSED
this.ddHeadGearSelection={
  {--[---][---][---] Balaclava
    maleId="svs_balaclava",
    femaleId="dds_balaclava5",--tex no direct match so fallback to something similar
  },
  {--[---][---][---] Balaclava
    maleId="pfs_balaclava",
    femaleId="dds_balaclava4",--tex no direct match so fallback to something similar
  },
  {--[---][---][HMT] DD
    maleId="dds_balaclava0",
    femaleId="dds_balaclava3",
  },
  {--[---][---][---] DD blacktop
    maleId="dds_balaclava1",
    femaleId="dds_balaclava4",
  },
  {--[---][---][---] DD no blacktop
    maleId="dds_balaclava2",
    femaleId="dds_balaclava5",
  },
  {--[GAS][---][---] DD open clava
    maleId="dds_balaclava6",
    femaleId="dds_balaclava7",
  },
  {--[GAS][---][---] DD clava and blacktop
    maleId="dds_balaclava8",
    femaleId="dds_balaclava10",
  },
  {--[GAS][---][HMT] DD
    maleId="dds_balaclava9",
    femaleId="dds_balaclava11",
  },
  {--[---][NVG][HMT] DD
    maleId="dds_balaclava12",
    femaleId="dds_balaclava14",
  },
  {--[GAS][NVG][HMT] DD
    maleId="dds_balaclava13",
    femaleId="dds_balaclava15",
  },
}
function this.GetMaleBodyInfo(missionCode)
  if not IvarProc.EnabledForMission("customSoldierType",missionCode) then
    return nil
  end
  --CULL
  --  local suitName=nil
  --  if IvarProc.IsForMission("customSoldierType","EQUIPGRADE") then
  --    if TppEnemy.weaponIdTable.DD==nil then
  --      return InfBodyInfo.bodyInfo.DRAB
  --    end
  --    local ddSuit=TppEnemy.GetDDSuit()
  --    suitName=this.ddSuitToDDBodyInfo[ddSuit]
  --  else
  local customSoldierType=IvarProc.GetForMission"customSoldierType"
  local suitName=Ivars.customSoldierTypeFREE.settings[customSoldierType+1]--KLUDGE
  --end
  return InfBodyInfo.bodyInfo[suitName]
end
function this.GetFemaleBodyInfo(missionCode)
  if not IvarProc.EnabledForMission("customSoldierTypeFemale",missionCode) then
    return InfBodyInfo.bodyInfo.DRAB --tex since a bunch of stuff still predicated by customSoldierType cant really havecustomSoldierTypeFemale nil
      --OFF return nil
  end
  --CULL
  --  local suitName=nil
  --  if IvarProc.IsForMission("customSoldierTypeFemale","EQUIPGRADE") then
  --    if TppEnemy.weaponIdTable.DD==nil then
  --      return InfBodyInfo.bodyInfo.DRAB
  --    end
  --    local ddSuit=TppEnemy.GetDDSuit()
  --    suitName=this.ddSuitToDDBodyInfo[ddSuit].."_FEMALE"
  --  else
  local customSoldierType=IvarProc.GetForMission"customSoldierTypeFemale"
  local suitName=Ivars.customSoldierTypeFemaleMB_ALL.settings[customSoldierType+1]
  --  end
  return InfBodyInfo.bodyInfo[suitName]
end

--
this.wildCardFemaleSuits={
  "SNEAKING_SUIT_FEMALE",
  "BATTLE_DRESS_FEMALE",
  "TIGER_FEMALE",
  "DRAB_FEMALE",
  "SWIMWEAR_FEMALE",
}

this.wildCardFemaleSuitName="SNEAKING_SUIT"--tex set in WildCardFovaSetup
function this.GetFemaleWildCardBodyInfo()
  return InfBodyInfo.bodyInfo[this.wildCardFemaleSuitName]
end

function this.AddBodyPackPaths(bodyInfo,bodyType)
  if not bodyInfo then
    return
  end
  bodyType=bodyType or "SOLDIER"
  if type(bodyInfo.missionPackPath)=="table" then
    for i,missionPackPath in ipairs(bodyInfo.missionPackPath) do
      if missionPackPath=="BASE_PACK" then--tex GOTCHA this means base pack is likely to be added multiple times, but doesnt seem to be an issue.
        TppPackList.AddMissionPack(this.basePackPaths[bodyType])
      else
        TppPackList.AddMissionPack(missionPackPath)
      end
    end
  else
    TppPackList.AddMissionPack(bodyInfo.missionPackPath)
  end
end

--tex non exhaustive, see face and body ids.txt,Soldier2FaceAndBodyData, face and bodyids.txt
this.faceIds={
  MALE={
    COMMON={
      {min=0,max=303},
      {min=320,max=349},
    },
    UNCOMMON={
      {min=600,max=602},--mission dudes
      {min=603,max=612},
      {min=614,max=620},
      {min=624,max=626},
      {635,},
      {min=637,max=642},
      {min=644,max=645},
      {min=647,max=649},
    },
    UNIQUE={
      {
        602,--glasses,
        621,--Tan
        --622,--hideo, NOTE doesn't show if vars.playerFaceId or assigned to wildcard, not sure how it's loaded for mission then, maybe its in the mission fpks?
        627,--finger
        628,--eye
        646,--beardy mcbeard
        680,--fox hound tattoo
        683,--red hair, ddogs tattoo
        684,--fox tattoo
        687,--while skull tattoo
      },
    },
  },
  FEMALE={
    COMMON={
      {min=350,max=399},--european
      {min=450,max=479},--african
      {min=500,max=519},--asian
      {613,643},
    },
    UNIQUE={
      {
        681,--female tatoo fox hound black
        682,--female tatoo whiteblack ddog red hair
        685,--female tatoo fox black
        686,--female tatoo skull white white hair
      },
    },
  }
}

--TUNE
this.categoryChances={
  MALE={
    COMMON=80,
    UNCOMMON=15,
    UNIQUE=5,
  },
  FEMALE={
    COMMON=95,
    UNIQUE=5,
  }
}

--IN InfEneFova.faceIds
function this.BuildFaceBags(faceIds)
  local faceBags={MALE={},FEMALE={}}
  for gender,categoryTables in pairs(faceIds) do
    for category,faceIdTables in pairs(categoryTables)do
      local faceBag=InfUtil.ShuffleBag:New()
      faceBags[gender][category]=faceBag
      for i,faceIds in ipairs(faceIdTables) do
        if faceIds.min then
          for i=faceIds.min,faceIds.max do
            faceBag:Add(i)
          end
        else
          faceBag:Fill(faceIds)
        end
      end
    end
  end
  return faceBags
end

function this.GetCategoryBag(categoryChances,gender,categories)
  local bag=InfUtil.ShuffleBag:New()
  for i,category in ipairs(categories) do
    local chance=categoryChances[gender][category]
    if chance then
      bag:Add(category,chance)
    end
  end
  return bag
end

function this.RandomFaceId(faceBags,gender,categoryBag)
  local category=categoryBag:Next()
  return faceBags[gender][category]:Next()
end

--NOTE: make sure RandomSetToLevelSeed is setup
--ASSUMPTION: last group in table is for unqiues that you don't want to spam too much
--CULL
--local uniqueChance=5--TUNE
--function this.RandomFaceId(faceList)
--  local rnd=math.random(#faceList)
--  if rnd==#faceList then
--    if math.random(100)>uniqueChance then
--      rnd=rnd-1
--    end
--  end
--
--  local type=faceList[rnd]
--  if type.min then
--    return math.random(type.min,type.max)
--  else
--    return type[math.random(1,#type)]
--  end
--end

this.DEFAULT_FACEID_MALE=0
this.DEFAULT_FACEID_FEMALE=350

this.GENDER={
  MALE=0,
  FEMALE=1,
}

this.RACE={
  CAUCASIAN=0,--TppDefine.QUEST_RACE_TYPE.CAUCASIAN, TppMotherBaseManagementConst.RACE_WHITE
  BROWN=1,--TppDefine.QUEST_RACE_TYPE.BROWN, TppMotherBaseManagementConst.RACE_BLOWN
  BLACK=2,--TppDefine.QUEST_RACE_TYPE.BLACK, TppMotherBaseManagementConst.RACE_BLACK
  ASIAN=3,--TppDefine.QUEST_RACE_TYPE.ASIA, TppMotherBaseManagementConst.RACE_YELLOW
}

this.PLAYERTYPE_GENDER={
  [PlayerType.DD_MALE]=this.GENDER.MALE,
  [PlayerType.DD_FEMALE]=this.GENDER.FEMALE,
}

--tex unlike race I I think I just made this enum up? not that useful though
this.HAIRCOLOR={
  BROWN=0,
  BLACK=1,
  BLOND=2,
  AUBURN=3,
  RED=4,
  WHITE=5,
  GREEN=6,
}

--headGearId = this.ddHeadGearInfo key
this.faceFova={
  ["cm_m0_h0_v000_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v001_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v002_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v003_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v004_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v005_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v006_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v007_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v008_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v009_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v010_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v011_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v012_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v013_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v014_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v015_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v016_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v017_eye1.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h0_v018_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h1_v000_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h1_v001_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h1_v002_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h1_v003_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h1_v004_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h2_v000_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h2_v001_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_m0_h2_v002_eye0.fv2"]={
    gender="MALE",
  },
  ["cm_svs0_head_z_eye0.fv2"]={
    description="Soviet Balaclava",
    gender="MALE",
    type="BALACLAVA",
    headGearId="svs_balaclava",
  },
  ["cm_pfs0_head_z_eye0.fv2"]={
    description="PF Balaclava",
    gender="MALE",
    type="BALACLAVA",
    headGearId="pfs_balaclava",
  },
  --TODO: give headGearId and clear up descriptions with ddgearinfo tppfaceid in game dd headgear
  ["cm_dds5_head_z_eye0.fv2"]={
    description="DD Mask with Helmet (Greentop)",--HP-Headgear
    gender="MALE",
    type="BALACLAVA",
  },
  ["cm_dds6_head_z_eye0.fv2"]={
    description="DD Mask with Helmet (Greentop)",--HP-Headgear
    gender="FEMALE",
    type="BALACLAVA",
  },
  ["cm_dds3_eqhd1_eye0.fv2"]={
    description="Gas mask and clava Male",
    gender="MALE",
    type="BALACLAVA",
  },
  ["cm_dds8_eqhd1_eye0.fv2"]={
    description="Gas mask and clava Female",
    gender="FEMALE",
    type="BALACLAVA",
  },
  ["cm_dds3_eqhd4_eye0.fv2"]={
    description="Gas mask DD helm Male",
    gender="MALE",
    type="BALACLAVA",
  },
  ["cm_dds3_eqhd5_eye0.fv2"]={
    description="Gas mask DD greentop helm Male",
    gender="MALE",
    type="BALACLAVA",
  },
  ["cm_dds8_eqhd2_eye0.fv2"]={
    description="Gas mask DD helm Female",
    gender="FEMALE",
    type="BALACLAVA",
  },
  ["cm_dds8_eqhd3_eye0.fv2"]={
    description="Gas mask DD greentop helm Female",
    gender="FEMALE",
    type="BALACLAVA",
  },
  ["cm_dds3_eqhd6_eye0.fv2"]={
    description="NVG DDgreentop Male",
    gender="MALE",
    type="BALACLAVA",
  },
  ["cm_dds3_eqhd7_eye0.fv2"]={
    description="NVG DDgreentop GasMask Male",
    gender="MALE",
    type="BALACLAVA",
  },
  ["cm_dds8_eqhd6_eye0.fv2"]={
    description="NVG DDgreentop Female",--total cover VERIFY, bit of nose shows?
    gender="FEMALE",
    type="BALACLAVA",
  },
  ["cm_dds8_eqhd7_eye0.fv2"]={
    description="NVG DDgreentop GasMask Female",--total cover VERIFY, bit ofnose shows?
    gender="FEMALE",
    type="BALACLAVA",
  },--<
  ["cm_unq_v000_eye1.fv2"]={--41,--bio engineer / glasses dude
    type="UNIQUE",
  },
  ["cm_unq_v001_eye1.fv2"]={
    type="UNIQUE",
  },--42,--includes hair>
  ["cm_unq_v002_eye0.fv2"]={
    type="UNIQUE",
  },--43,--<
  ["cm_unq_v003_eye1.fv2"]={
    description="Hideo",--kojima, hair, glasses -- all-in-one, also has hair.sim
    type="UNIQUE",
  },
  ["cm_unq_v004_eye0.fv2"]={
    type="UNIQUE",
  },--45,
  ["cm_unq_v005_eye0.fv2"]={
    type="UNIQUE",
  },--46,--
  ["cm_unq_v006_eye0.fv2"]={
    type="UNIQUE",
  },--47,
  ["cm_unq_v007_eye0.fv2"]={
    type="UNIQUE",
  },--48,
  ["cm_f0_h0_v000_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h0_v001_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h0_v002_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h0_v003_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h1_v000_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h1_v001_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h1_v002_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h2_v000_eye1.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h2_v001_eye0.fv2"]={
    gender="FEMALE",
  },
  ["cm_f0_h2_v002_eye0.fv2"]={
    gender="FEMALE",
  },
}
--< faceFova
--face textures
--TODO not sure on how kjp made determination between brown/black for race var, have just all as black for now - see this.RACE table to see if you can figure out from data. Also guessing one of the faceDefinition unks is race, but don't know which
this.faceDecoFova={
  ["cm_w000_m.fv2"]={--light stubble
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,--or brown? shaved
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w001_m.fv2"]={--stubble
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,--or brown? shaved
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w002_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,--or brown? shaved
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w003_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w004_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w005_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w006_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w007_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w008_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w009_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w010_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w011_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w012_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w013_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w014_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w015_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w016_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w017_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w018_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w019_m.fv2"]={
    gender="MALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_b000_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b001_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b002_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b003_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b004_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b005_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b006_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b007_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b008_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b009_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_b010_m.fv2"]={
    gender="MALE",
    race=this.RACE.BLACK,
  },
  ["cm_y000_m.fv2"]={
    gender="MALE",
    race=this.RACE.ASIAN,
  },
  ["cm_y001_m.fv2"]={
    gender="MALE",
    race=this.RACE.ASIAN,
  },
  ["cm_y002_m.fv2"]={
    gender="MALE",
    race=this.RACE.ASIAN,
  },
  ["cm_y003_m.fv2"]={
    gender="MALE",
    race=this.RACE.ASIAN,
  },

  ["cm_w000_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w001_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w002_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_w003_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.CAUCASIAN,
  },
  ["cm_b000_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.BLACK,
  },
  ["cm_b001_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.BLACK,
  },
  ["cm_b002_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.BLACK,
  },
  ["cm_y000_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.ASIAN,
  },
  ["cm_y001_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.ASIAN,
  },
  ["cm_y002_f.fv2"]={
    gender="FEMALE",
    race=this.RACE.ASIAN,
  },

  ["sp_w000_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_w001_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_w002_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,--shaved
    race=this.RACE.CAUCASIAN,
  },
  ["sp_w003_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_w004_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_b000_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.BLACK,
  },
  ["sp_y000_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.ASIAN,
  },
  ["sp_y001_m.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    race=this.RACE.ASIAN,
  },

  ["sp_face_m000.fv2"]={
    description="Tatoo Foxhound",--black foxhound
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_face_m001.fv2"]={
    description="Tatoo DDogs emblem",--white and black ddog emblem
    gender="MALE",
    hairColor=this.HAIRCOLOR.RED,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_face_m002.fv2"]={
    description="Tatoo Fox",--fox logo fox
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_face_m003.fv2"]={
    description="Tatoo White skull",
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,--shaved
    race=this.RACE.CAUCASIAN,
  },

  ["sp_face_f000.fv2"]={
    description="Tatoo Foxhound",--black foxhound
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_face_f001.fv2"]={
    description="Tatoo DDogs emblem",--white and black ddog emblem
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.RED,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_face_f002.fv2"]={
    description="Tatoo Fox",--fox logo fox
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    race=this.RACE.CAUCASIAN,
  },
  ["sp_face_f003.fv2"]={
    description="Tatoo White skull",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.WHITE,
    race=this.RACE.CAUCASIAN,
  },
}--<faceDecoFova

--hair meshes
--TODO: descriptions. im terrible at describing haircuts
this.hairFova={
  ["cm_hair_c000.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c000_c000.fv2",
      "cm_hair_c000_c001.fv2",
      "cm_hair_c000_c002.fv2",
      "cm_hair_c000_c003.fv2",
      "sp_hair_m000.fv2",
      "sp_hair_m001.fv2",
    },
  },
  ["cm_hair_c001.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c001_c000.fv2",
      "cm_hair_c001_c001.fv2",
      "sp_hair_m002.fv2",
    },
  },
  ["cm_hair_c002.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c002_c000.fv2",
    },
  },
  ["cm_hair_c003.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c003_c000.fv2",
    },
  },
  ["cm_hair_c004.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c106_c000.fv2",
    },
  },
  ["cm_hair_c005.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c005_c000.fv2",
    },
  },
  ["sp_hair_c000.fv2"]={
    gender="MALE",
    hairDecoFovas={
      "cm_hair_c004_c000.fv2",
    },
  },
  ["cm_hair_c100.fv2"]={
    description="Bob",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c100_c000.fv2",
      "cm_hair_c107_c000.fv2",
    },
  },
  ["cm_hair_c101.fv2"]={
    description="Pixie",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c101_c000.fv2",
      "sp_hair_f001.fv2",
      "sp_hair_f003.fv2",
    },
  },
  ["cm_hair_c102.fv2"]={
    description="Crop",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c102_c000.fv2",
      "sp_hair_f000.fv2",
      "sp_hair_f002.fv2",
    },
  },
  ["cm_hair_c103.fv2"]={
    description="Ponytail bangs",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c103_c000.fv2",
    },
  },
  ["cm_hair_c104.fv2"]={
    description="Ponytail parted",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c104_c000.fv2",
    },
  },
  ["cm_hair_c105.fv2"]={
    description="Bun",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c105_c000.fv2",
    },
  },
  ["cm_hair_c106.fv2"]={
    description="Afro-texured short",
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c106_c000.fv2",
    },
  },
  --tex unused?
  ["cm_hair_c107.fv2"]={
    gender="FEMALE",
    hairDecoFovas={
      "cm_hair_c107_c000.fv2",--tex no actual headdefinitions with this i can see?
    },
  },
}--<hairFova

--hair textures
--tex colors not that accurate
this.hairDecoFova={
  ["cm_hair_c000_c000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,--blonde brown
    hairFova={
      "cm_hair_c000.fv2",
    },
  },
  ["cm_hair_c000_c001.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,--dark brown
    hairFova={
      "cm_hair_c000.fv2",
    },
  },
  ["cm_hair_c000_c002.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c000.fv2",
    },
  },
  ["cm_hair_c000_c003.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,--dark brown
    hairFova={
      "cm_hair_c000.fv2",
    },
  },
  ["cm_hair_c001_c000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c001.fv2"
    },
  },
  ["cm_hair_c001_c001.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c001.fv2"
    },
  },
  ["cm_hair_c002_c000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c002.fv2"
    },
  },
  ["cm_hair_c003_c000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    hairFova={
      "cm_hair_c003.fv2"
    },
  },
  ["cm_hair_c004_c000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLACK,
    hairFova={
      "sp_hair_c000.fv2"
    },
  },
  ["cm_hair_c005_c000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLOND,
    hairFova={
      "cm_hair_c005.fv2"
    },
  },
  ["cm_hair_c100_c000.fv2"]={
    description="Blond",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BLOND,
    hairFova={
      "cm_hair_c100.fv2",
    },
  },
  ["cm_hair_c101_c000.fv2"]={
    description="Brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c101.fv2",
    },
  },
  ["cm_hair_c102_c000.fv2"]={
    description="Dark brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c102.fv2",
    },
  },
  ["cm_hair_c103_c000.fv2"]={
    description="Brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c103.fv2",
    },
  },
  ["cm_hair_c104_c000.fv2"]={
    name="Brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c104.fv2",
    },
  },
  ["cm_hair_c105_c000.fv2"]={
    description="Brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c105.fv2",
    },
  },
  ["cm_hair_c106_c000.fv2"]={
    description="Dark brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c004.fv2",
      "cm_hair_c106.fv2",
    },
  },
  ["cm_hair_c107_c000.fv2"]={
    description="Brown",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.BROWN,
    hairFova={
      "cm_hair_c100.fv2",
    --"cm_hair_c107.fv2"--tex no heads actually referencing this match?
    },
  },
  ["sp_hair_m000.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLOND,--light brown?
    hairFova={
      "cm_hair_c000.fv2",
    },
  },
  ["sp_hair_m001.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.RED,
    hairFova={
      "cm_hair_c000.fv2",
    },
  },
  ["sp_hair_m002.fv2"]={
    gender="MALE",
    hairColor=this.HAIRCOLOR.BLONDE,
    hairFova={
      "cm_hair_c001.fv2",
    },
  },
  ["sp_hair_f000.fv2"]={
    description="Green",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.GREEN,
    hairFova=9,
  },
  ["sp_hair_f001.fv2"]={
    description="Red",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.RED,
    hairFova={
      "cm_hair_c101.fv2",
    },
  },
  ["sp_hair_f002.fv2"]={
    description="Auburn",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.AUBURN,
    hairFova={
      "cm_hair_c102.fv2",
    },
  },
  ["sp_hair_f003.fv2"]={
    description="White",
    gender="FEMALE",
    hairColor=this.HAIRCOLOR.WHITE,
    hairFova={
      "cm_hair_c101.fv2",
    },
  },
}

this.faceDefinitionParams=Tpp.Enum{
  "currentFaceId",
  "unknown1",
  "gender",
  "unknown2",
  "faceFova",
  "faceDecoFova",
  "hairFova",
  "hairDecoFova",
  "unknown3",
  "unknown4",
  "unknown5",
  "uiTextureName",
  "unknown6",
  "unknown7",
  "unknown8",
  "unknown9",
  "unknown10",
}

function this.GetFovaName(fovaType,fovaIndex)
  local faceDecoName=Soldier2FaceAndBodyData[fovaType][fovaIndex]
  return InfUtil.GetFileName(faceDecoName)
end


this.wildCardBodyTable={
  afgh={
    TppEnemyBodyId.svs0_unq_v010,
    TppEnemyBodyId.svs0_unq_v020,
    TppEnemyBodyId.svs0_unq_v070,
    TppEnemyBodyId.svs0_unq_v071,
    TppEnemyBodyId.svs0_unq_v072,
    TppEnemyBodyId.svs0_unq_v009,
    TppEnemyBodyId.svs0_unq_v060,
    TppEnemyBodyId.svs0_unq_v100,
    TppEnemyBodyId.svs0_unq_v420,
  },
  mafr={
    TppEnemyBodyId.pfs0_unq_v210,
    TppEnemyBodyId.pfs0_unq_v250,
    TppEnemyBodyId.pfs0_unq_v360,
    TppEnemyBodyId.pfs0_unq_v280,
    TppEnemyBodyId.pfs0_unq_v150,
    TppEnemyBodyId.pfs0_unq_v140,
    TppEnemyBodyId.pfs0_unq_v241,
    TppEnemyBodyId.pfs0_unq_v450,
    TppEnemyBodyId.pfs0_unq_v440,
  },
}

--called from TppEnemyFova fovaSetupFuncs.Afghan/Africa
--IN/OUT faces
function this.WildCardFovaFaces(faces)
  InfMain.RandomSetToLevelSeed()
  local faceBags=this.BuildFaceBags(this.faceIds)
  this.inf_wildCardMaleFaceList={}
  this.inf_wildCardFemaleFaceList={}
  local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT
  if not IvarProc.EnabledForMission"customSoldierType" then--tex bail out of male because customSoldierType interferes TODO: extend wildcard to other soldiertypes with multiple bodies
    local categoryBag=this.GetCategoryBag(this.categoryChances,"MALE",{"UNCOMMON","UNIQUE"})
    for i=1,InfSoldier.numWildCards.MALE do
      local faceId=this.RandomFaceId(faceBags,"MALE",categoryBag)
      table.insert(faces,{faceId,1,1,0})
      table.insert(InfEneFova.inf_wildCardMaleFaceList,faceId)
    end
  end
  local categoryBag=this.GetCategoryBag(this.categoryChances,"FEMALE",{"COMMON","UNIQUE"})
  for i=1,InfSoldier.numWildCards.FEMALE do
    local faceId=this.RandomFaceId(faceBags,"FEMALE",categoryBag)
    table.insert(faces,{faceId,1,1,0})
    table.insert(InfEneFova.inf_wildCardFemaleFaceList,faceId)
  end

  InfCore.PrintInspect(InfEneFova.inf_wildCardFemaleFaceList,{varName="inf_wildCardFemaleFaceList"})--DEBUG
  --TppSoldierFace.OverwriteMissionFovaData{face=faces,additionalMode=true}--tex OFF TEST is mixing additionalmode here and via UniqueSettings is causing issues?
  InfMain.RandomResetToOsTime()
end

function this.GetRandomFaces(gender,count)
  InfMain.RandomSetToLevelSeed()
  local faceBags=this.BuildFaceBags(this.faceIds)
  local categoryBag
  if gender=="MALE" then
    categoryBag=this.GetCategoryBag(this.categoryChances,gender,{"UNCOMMON","UNIQUE"})
  else
    categoryBag=this.GetCategoryBag(this.categoryChances,gender,{"COMMON","UNIQUE"})
  end
  local faces={}
  for i=1,count do
    local faceId=this.RandomFaceId(faceBags,gender,categoryBag)
    table.insert(faces,faceId)
  end
  InfMain.RandomResetToOsTime()
  return faces
end

--called from TppEnemyFova fovaSetupFuncs.Afghan/Africa
--IN/OUT bodies
function this.WildCardFovaBodies(bodies)
  InfMain.RandomSetToLevelSeed()

  local locationName=InfUtil.GetLocationName()

  this.wildCardFemaleSuitName=InfUtil.GetRandomInList(this.wildCardFemaleSuits)
  local bodyInfo=this.GetFemaleWildCardBodyInfo()
  if bodyInfo then
    if bodyInfo.bodyId then
      this.SetupBodies(bodyInfo.bodyId,bodies)
    end
    if bodyInfo.soldierSubType then
      local bodyIdTable=TppEnemy.bodyIdTable[bodyInfo.soldierSubType]
      if bodyIdTable then
        for powerType,bodyTable in pairs(bodyIdTable)do
          this.SetupBodies(bodyTable,bodies)
        end
      end
    end

    if bodyInfo.partsPath then
      TppSoldier2.SetExtendPartsInfo{type=1,path=bodyInfo.partsPath}
    end
  end

  if not IvarProc.EnabledForMission"customSoldierType" then --tex bail out of male because customSoldierType interferes TODO: extend wildcard to other soldiertypes with multiple bodies
    local maleBodyTable=this.wildCardBodyTable[locationName]
    if maleBodyTable then
      this.SetupBodies(maleBodyTable,bodies)
    end
    --TppSoldierFace.OverwriteMissionFovaData{body=bodies,additionalMode=true}--tex OFF TEST is mixing additionalmode here and via UniqueSettings is causing issues?
  end

  InfMain.RandomResetToOsTime()
end

function this.GetHeadGearForPowers(powerSettings,isFemale,bodyInfo)
  if powerSettings==nil then--DEBUGNOW
    InfCore.Log("GetHeadGearForPowers powerSettings==nil" )
    return {}
  end

  local validHeadGearIds={}

  local gearPowerTypes={
    HELMET=true,
    GAS_MASK=true,
    NVG=true,
  }
  --tex copy over soldier powertypes since we may want to filter without modifying actual settings
  local soldierSettings={}
  for powerType,bool in pairs(gearPowerTypes)do
    soldierSettings[powerType]=powerSettings[powerType]
  end

  --tex using balavlava headgear means it's still using the face system, some of it works out ok,
  --NVG,GAS_MASK covers different parts so may not be noticable, really depends on the head thats with the body, but tuning for XOF
  --TODO: may need to reconsider if expanding headgear
  if bodyInfo.hasFace then
    if soldierSettings.NVG==nil and soldierSettings.GAS_MASK==nil then
      return validHeadGearIds
    end
  end

  --tex no point in having DD hardtop if body has its own helmet TODO: may need to reconsider if expanding headgear
  --tex PATCHUP there's no heads with nvg and no helmet/greentop
  if bodyInfo.hasHelmet then
    if not soldierSettings.NVG then
      soldierSettings.HELMET=nil
    end
  end

  for headGearId,headGearInfo in pairs(this.ddHeadGearInfo)do
    local isMatch=true
    if isFemale then
      isMatch=headGearInfo.FEMALE==true
    else
      isMatch=headGearInfo.MALE==true
    end

    if isMatch then
      for powerType, bool in pairs(gearPowerTypes)do
        if soldierSettings[powerType] and not headGearInfo[powerType] then
          isMatch=false
        end
        if headGearInfo[powerType] and not soldierSettings[powerType] then
          isMatch=false
        end
      end
    end
    if isMatch then
      validHeadGearIds[#validHeadGearIds+1]=headGearId
    end
  end

  if this.debugModule then
    InfCore.Log("GetHeadGearForPowers bodyHasHelmet:"..tostring(bodyInfo.hasHelmet))
    InfCore.PrintInspect(powerSettings,"GetHeadGearForPowers.powerSettings")
    InfCore.PrintInspect(soldierSettings,"GetHeadGearForPowers.soldierSettings")
    InfCore.PrintInspect(validHeadGearIds,"GetHeadGearForPowers.validHeadGearIds")
  end

  return validHeadGearIds
end

--CALLER ApplyPowerSetting,ApplyMTBSUniqueSetting
function this.ApplyCustomBodyPowers(soldierId,powerSettings)
  local isFemale=GameObject.SendCommand(soldierId,{id="isFemale"})
  local bodyInfo=nil
  if isFemale then
    bodyInfo=InfEneFova.GetFemaleBodyInfo()
  else
    bodyInfo=InfEneFova.GetMaleBodyInfo()
  end
  if bodyInfo then
    if bodyInfo.isArmor then
      powerSettings.ARMOR=true
      --DEBUGNOW TODO?  mvars.ene_soldierPowerSettings[soldierId].ARMOR=true
    end

    --tex headgear futzing
    if bodyInfo.helmetOnly then
      powerSettings.GAS_MASK=nil
      powerSettings.NVG=nil
    end

    --tex PATCHUP there's no heads with nvg and no helmet/greentop
    if powerSettings.NVG then
      if bodyInfo.useDDHeadgear then
        powerSettings.HELMET=true
        --DEBUGNOW TODO?  mvars.ene_soldierPowerSettings[soldierId].HELMET=true
      end
    end

    if bodyInfo.config then
      local gear={"HELMET","GAS_MASK","NVG","ARMOR"}
      for i,power in ipairs(gear)do
        if bodyInfo.config[power]~=nil then
          powerSettings[power]=bodyInfo.config[power]
        end
      end
    end
  end

  local clearHeadGear=false--tex DEBUG>
  if clearHeadGear then
    powerSettings.HELMET=nil
    powerSettings.GAS_MASK=nil
    powerSettings.NVG=true
  end--<
end

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
  local unknown3=Ivars.faceFovaUnknown3:Get()
  local unknown4=Ivars.faceFovaUnknown4:Get()
  local unknown5=Ivars.faceFovaUnknown5:Get()
  local unknown6=Ivars.faceFovaUnknown6:Get()
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
    unknown3,
    unknown4,
    unknown5,
    uiTextureName,
    unknown6,
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
end

function this.PrintFaceInfo(faceId)
  local faceAndBodyData=Soldier2FaceAndBodyData
  for i,faceDef in ipairs(faceAndBodyData.faceDefinition)do
    if faceDef[1]==faceId then
      local faceInfoString=""
      for i,fovaType in ipairs(InfModelProc.fovaTypes)do
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
end

--In: bodyIds
--In/Out: bodies
local MAX_REALIZED_COUNT=EnemyFova.MAX_REALIZED_COUNT--==255
function this.SetupBodies(bodyIds,bodies,count)
  if bodyIds==nil then return end

  local count=count or MAX_REALIZED_COUNT

  if type(bodyIds)=="number"then
    local bodyEntry={bodyIds,MAX_REALIZED_COUNT}
    bodies[#bodies+1]=bodyEntry
  elseif type(bodyIds)=="table"then
    for n,bodyId in ipairs(bodyIds)do
      local bodyEntry={bodyId,MAX_REALIZED_COUNT}
      bodies[#bodies+1]=bodyEntry
    end
  end
end

local allowHeavyArmorStr="allowHeavyArmor"
function this.ForceArmor(missionCode)
  if IvarProc.EnabledForMission(allowHeavyArmorStr,missionCode) then
    return true
  end
  --TODO either I got rid of this functionality at some point or I never implemented it (I could have sworn I did though), search in past versions
  --  if Ivars.allowLrrpArmorInFree:Is(1) and TppMission.IsFreeMission(missionCode) then
  --    return true
  --  end

  return false
end

this.enemySubTypes={
  "Default",
  "DD_A",
  "DD_PW",
  "DD_FOB",
  "SKULL_CYPR",
  "SKULL_AFGH",
  "SOVIET_A",
  "SOVIET_B",
  "PF_A",
  "PF_B",
  "PF_C",
  "CHILD_A",
}

this.soldierSubTypesForTypeName={
  TYPE_DD={
    "DD_A",
    "DD_PW",
    "DD_FOB",
  },
  TYPE_SKULL={
    "SKULL_CYPR",
    "SKULL_AFGH",
  },
  TYPE_SOVIET={
    "SOVIET_A",
    "SOVIET_B",
  },
  TYPE_PF={
    "PF_A",
    "PF_B",
    "PF_C",
  },
  TYPE_CHILD={
    "CHILD_A",
  },
}

--tex maybe I'm missing something but not having luck indexing by EnemyType
function this.SoldierTypeNameForType(soldierType)
  if soldierType == nil then
    return nil
  end

  if soldierType==EnemyType.TYPE_DD then
    return "TYPE_DD"
  elseif soldierType==EnemyType.TYPE_SKULL then
    return "TYPE_SKULL"
  elseif soldierType==EnemyType.TYPE_SOVIET then
    return "TYPE_SOVIET"
  elseif soldierType==EnemyType.TYPE_PF then
    return "TYPE_PF"
  elseif soldierType==EnemyType.TYPE_CHILD then
    return "TYPE_CHILD"
  end
  return nil
end

function this.IsSubTypeCorrectForType(soldierType,subType)--returns true on nil soldiertype because fsk that
  local soldierTypeName=this.SoldierTypeNameForType(soldierType)
  if soldierTypeName ~= nil then
    local subTypes=this.soldierSubTypesForTypeName[soldierTypeName]
    if subTypes ~= nil then
      for n, _subType in pairs()do
        if subType == _subType then
          return true
        end
      end
      return false
    end
  end
  return true
end

return this
