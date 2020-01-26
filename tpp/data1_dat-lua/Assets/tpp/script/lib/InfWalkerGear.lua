-- DOBUILD: 1
-- InfWalkerGear.lua
local this={}

this.walkerList={}

local walkerNamePre="wkr_WalkerGear_"

local numWalkerGears=20
for i=0,numWalkerGears-1 do
  local name=string.format("%s%04d", walkerNamePre,i)
  table.insert(this.walkerList,name)
end


local walkerGearEquip={
  WALKERGEAR_EQP_MACHINEGUN=0,
  WALKERGEAR_EQP_MISSILE=1,
}

--tex "SetColoringType" type, from 0
this.walkerGearColorTypeName={
  "SOVIET",--green, default
  "ROGUE_COYOTE",--Blue grey
  "CFA",--tan
  "ZRS",
  "DDOGS",--light grey
  "HUEY_PROTO",--yellow/grey - texure error on side shields since it's used in 10070 : Mission 12 - Hellbound with "SetExtraPartsForSpecialEnemy" which has no side shields
}
local walkerGearColorType=TppDefine.Enum(this.walkerGearColorTypeName)

local cpSubTypeToColor={
  SOVIET_A="SOVIET",
  SOVIET_B="SOVIET",
  PF_A="CFA",
  PF_B="ZRS",
  PF_C="ROGUE_COYOTE",
}

--REF clusters {"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
local walkerStartPositionsMb={
  --command
  {
    {pos={1.275,0.00,-30.20},rot=0},
    {pos={117.35,0.00,-5.05},rot=-94},
    {pos={233.315,0.00,-57.34},rot=131},
    {pos={323.00,0.00,-51.00},rot=180},
  },
  --combat
  {
    {pos={1149.00,0.00,-591.00},rot=45},
    {pos={1150.15,0.00,-741.00},rot=0},
    {pos={1253.00,4.00,-809.00},rot=-90},
    {pos={1356.065,0.00,-792.547},rot=90},
  },
  --r&d
  {
    {pos={1199.72,32.00,298.822},rot=135},
    {pos={1317.23,0.00,338.366},rot=-45},
    {pos={1410.00,0.00,231.00},rot=-45},
    {pos={1526.00,0.00,229.00},rot=-180},
  },
  --base dev
  {
    {pos={-754.00,8.00,-356.00},rot=0},
    {pos={-821.587,0.00,-473.22},rot=-45},
    {pos={-952.00,0.00,-483.00},rot=0},
    {pos={-1015.132,0.00,-570.126},rot=0},
  },
  --support
  {
    {pos={372.00,0.00,875.00},rot=0},
    {pos={464.62,0.00,937.96},rot=135},
    {pos={435.637,0.00,1074.866},rot=90},
    {pos={343.397,0.00,1166.265},rot=45},
  },
  --intel
  {
    {pos={-654.565,4.00,536.165},rot=89},
    {pos={-693.882,0.00,665.266},rot=0},
    {pos={-794.00,0.00,740.00},rot=-45},
    {pos={-797.00,0.00,853.00},rot=0},
  },
  --med
  {
    {pos={-143.546,0.00,-973.570},rot=134.5},
    {pos={-121.202,0.00,-1076.245},rot=230},
    {pos={-231.141,0.00,-1169.666},rot=-45},
    {pos={-160.00,0.00,-1306.00},rot=0},
  },
}

local walkerStartPositionsWorld={
  afgh={
    afgh_remnants_cp={
      {pos={-906.802,288.846,1923.874},rot=100.7},
    },
    afgh_field_cp={
      {pos={415.052,270.933,2207.31},rot=-178.46},
    },
    afgh_village_cp={
      {pos={507.349,320.454,1160.997},rot=73},
    },
    afgh_commFacility_cp={
      {pos={1491.027,357.429,469.534},rot=131.386},
    },
    afgh_bridge_cp={
      {pos={1941.284,322.766,-528.093},rot=50.1},
    },
    afgh_fort_cp={
      {pos={2136.47,455.56,-179.82},rot=47.827},
    },
    afgh_cliffTown_cp={
      {pos={779.312,463.273,-989.820},rot=-177.267},
    },
    afgh_slopedTown_cp={
      {pos={541.161,328.605,58.012},rot=8.95},
    },
    afgh_enemyBase_cp={
      {pos={-628.698,353.423,457.301},rot=96.6},
    },
    afgh_tent_cp={
      {pos={-1763.372,311.495,784.801},rot=0178.618},
    },
    afgh_powerPlant_cp={
      {pos={-676.716,533.915,-1474.162},rot=82.7},
    },
    afgh_sovietBase_cp={
      {pos={-2335.55,439.315,-1482.474},rot=-58.77},
    },
    afgh_citadel_cp={
      {pos={-1232.651,600.599,-3098.633},rot=90.475},
    },
  },
}

this.walkerPlats={}

function this.SetupWalkerGear()
  if vars.missionCode==30050 then
    this.SetupWalkerGearMb()
    return
  end
  --OFF WIP
  --  if vars.missionCode==30010 or vars.missionCode==30020 then
  --    this.SetupWalkerGearWorld()
  --  end
end

function this.SetupWalkerGearWorld()
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end
  if Ivars.enableWalkerGearsFREE:Is(0) then
    return
  end


  InfInspect.TryFunc(function()--DEBUGNOW

    InfMain.SetLevelRandomSeed()

    local locationName=TppLocation.GetLocationName()

    local positions=walkerStartPositionsWorld[locationName]

    local cpPool={}
    for cpName,coordList in pairs(positions)do
      table.insert(cpPool,cpName)
    end

    local numWalkers=#this.walkerList
    for i=1,numWalkers do
      local walkerName=this.walkerList[i]
      local walkerId=GameObject.GetGameObjectId("TppCommonWalkerGear2",walkerName)
      if walkerId==GameObject.NULL_ID then
        InfMenu.DebugPrint("WARNING NULL_ID for "..walkerName)
      else
        --ASSUMPTION only one pos per cp
        local cpName=InfMain.GetRandomPool(cpPool)
        local coord=positions[cpName][1]


        local command={id="SetPosition",pos=coord.pos,rotY=coord.rot}
        GameObject.SendCommand(walkerId,command)


        local cpSubType=TppEnemy.subTypeOfCp[cpName]
        local colorName=cpSubTypeToColor[cpSubType]
        local walkerColorType=walkerGearColorType[colorName]

        local cpId=GameObject.GetGameObjectId("TppCommandPost2",cpName)
        if cpId==GameObject.NULL_ID then
          InfMenu.DebugPrint(tostring(cpName).." cpId==NULL_ID")--DEBUG
        else
        end
        local command={id="SetColoringType",type=walkerColorType}
        GameObject.SendCommand(walkerId,command)
      end
    end
    InfMain.ResetTrueRandom()

  end)

end

function this.SetupWalkerGearMb()
    if vars.missionCode~=30050 then
      return
  end

  if Ivars.enableWalkerGearsMB:Is(0) then
    return
  end

  InfMain.SetLevelRandomSeed()


  local numClusters=0

  for clusterId, clusterName in ipairs(TppDefine.CLUSTER_NAME) do
    local grade=TppLocation.GetMbStageClusterGrade(clusterId)
    if grade>0 then
      numClusters=numClusters+1
    end
  end

  local numWalkers=#this.walkerList
  local numAssigned=0
  local walkersPerCluster=math.floor(numWalkers/numClusters)

  local totalPlats=0
  local platsPool={}
  for clusterId, clusterName in ipairs(TppDefine.CLUSTER_NAME) do
    local grade=TppLocation.GetMbStageClusterGrade(clusterId)
    if grade>0 then
      platsPool[clusterId]={}
      for i=1,grade do
        table.insert(platsPool[clusterId],i)
        totalPlats=totalPlats+1
      end
    end
  end
  if numWalkers>totalPlats then
    numWalkers=totalPlats
  end

  --tex don't want to bother with this case
  if numWalkers<#platsPool then
    InfMenu.DebugPrint"SetupWalkerGearPositions - WANRING: less walkers than clusters, aborting"
    return
  end

  --tex first pass, get at lease one per cluster
  this.walkerPlats={}

  local function GetRandomPoolPlat(plats)
    local rnd=math.random(1,#plats)
    local plat=plats[rnd]
    table.remove(plats,rnd)
    return plat
  end

  local walkerIndex=1
  for clusterId,plats in ipairs(platsPool)do
    this.walkerPlats[clusterId]={}

    for i=1,walkersPerCluster do
      if numAssigned==numWalkers then
        --InfMenu.DebugPrint"numAssigned==numWalkers"--DEBUG
        break
      end
      if #plats>0 then
        local plat=GetRandomPoolPlat(plats)
        this.walkerPlats[clusterId][plat]=walkerIndex
        numAssigned=numAssigned+1
        walkerIndex=walkerIndex+1
      end
    end
  end

  --InfMenu.DebugPrint("numWalkers:"..numWalkers.." walkersPerCluster: "..walkersPerCluster.." numAssigned:"..numAssigned)--DEBUG
  --InfInspect.PrintInspect(this.walkerPlats)--DEBUG

  --tex assign unassigned
  while numAssigned<numWalkers do

    local clusters={}
    for clusterId,plats in ipairs(platsPool)do
      if #plats>0 then
        table.insert(clusters,clusterId)
      end
    end

    local clusterId=clusters[math.random(1,#clusters)]
    local plats=platsPool[clusterId]
    local plat=GetRandomPoolPlat(plats)
    this.walkerPlats[clusterId][plat]=walkerIndex
    numAssigned=numAssigned+1
    walkerIndex=walkerIndex+1
  end

  InfMenu.DebugPrint("numWalkers:"..numWalkers.." numAssigned:"..numAssigned)--DEBUGNOW
  --InfInspect.PrintInspect(this.walkerPlats)--DEBUG

  local function GetRandomColorType()
    return math.random(1,5)--tex NOTE leaving out HUEY_PROTO because of texure error
  end
  local walkerColorType=GetRandomColorType()

  local function GetRandomWeaponType()
    return math.random(0,1)
  end
  local walkerGearWeapon=GetRandomWeaponType()

  for clusterId,plats in ipairs(this.walkerPlats) do
    for platId,walkerIndex in pairs(plats)do
      local walkerName=this.walkerList[walkerIndex]
      local walkerId=GameObject.GetGameObjectId("TppCommonWalkerGear2",walkerName)
      if walkerId==GameObject.NULL_ID then
        InfMenu.DebugPrint("WARNING NULL_ID for "..walkerName)
      else

        local coord=walkerStartPositionsMb[clusterId][platId]
        local command={id="SetPosition",pos=coord.pos,rotY=coord.rot}
        GameObject.SendCommand(walkerId,command)

        if Ivars.mbWalkerGearsWeapon:Is()>0 then
          if Ivars.mbWalkerGearsWeapon:Is"RANDOM" then
          --tex outside loop
          elseif Ivars.mbWalkerGearsWeapon:Is"RANDOM_EACH" then
            walkerGearWeapon=GetRandomWeaponType()
          else
            walkerGearWeapon=Ivars.mbWalkerGearsWeapon:Get()-1
          end
          local command={id="SetMainWeapon",weapon=walkerGearWeapon}
          GameObject.SendCommand(walkerId,command)
        end

        if Ivars.mbWalkerGearsColor:Is"RANDOM" then
        --tex outside loop
        elseif Ivars.mbWalkerGearsColor:Is"RANDOM_EACH" then
          walkerColorType=GetRandomColorType()
        else
          walkerColorType=Ivars.mbWalkerGearsColor:Get()
        end


        --tex hueys prototype from 10070 : Mission 12
        -- no side sheilds, small dwalker head, arm
        -- but has bugs, arm hangs down straight/unanimated, pickup up body make them dissapear, and reappear in wrong pos on drop
        --TODO possibly needs data from 10070 pack
        --        local command={id="SetExtraPartsForSpecialEnemy",enabled=true}
        --        GameObject.SendCommand(walkerId,command)

        local command={id="SetColoringType",type=walkerColorType-1}
        GameObject.SendCommand(walkerId,command)
      end
    end
  end

  InfMain.ResetTrueRandom()
end

function this.GetNumDDWalkers()
  --tex what is the resource name for WG.PP?
  local walkerResourceNames={
    --"SovietWalkerGear1",--1 seems to be dup of 2
    "SovietWalkerGear2",
    "SovietWalkerGear3",
    --"CfaWalkerGear1",--1 seems to be dup of 2
    "CfaWalkerGear2",
    "CfaWalkerGear3",
  --DEBUG OFF seems to have a count even though they dont list?
  --they seem to print with the count of some of the others?
  --          "RogueCoyoteWalkerGear1",
  --          "RogueCoyoteWalkerGear2",
  --          "RogueCoyoteWalkerGear3",
  --          "ZrsWalkerGear1",
  --          "ZrsWalkerGear2",
  --          "ZrsWalkerGear3",
  }
  local totalGears=0
  for i,resourceName in ipairs(walkerResourceNames)do

    local gearCount=TppMotherBaseManagement.GetResourceUsableCount{resource=resourceName}
    InfMenu.DebugPrint(resourceName..":"..gearCount)
    totalGears=totalGears+gearCount
  end
  InfMenu.DebugPrint("totalGears:"..totalGears)
end


return this
