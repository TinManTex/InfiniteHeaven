-- DOBUILD: 1
--InfInterrogation.lua
local this={}

local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId

this.helpYouInterrogateIds={
  "enqt1000_1x1a10",--"No need to kill me... Let me help you!"
  "enqt1000_106961",--"Wait, don't kill me...!"
  "enqt1000_107085",--"Wait... Killing me would be a mistake."
  "enqt1000_107002",--"Don't kill me... please...&#xD;&#xA;I can tell you anything. "
}

this.locationInterrogateIds={
  "enqt1000_1x1a10",
  "enqt1000_106961",
}

--DEBUG>
this.InterCall_Test=function(soldierId,cpId,interName)
  InfMenu.DebugPrint"InterCall_Test"--
end

this.UniqueInterEnd_Test=function(soldierId,cpId,interName)
  InfMenu.DebugPrint"UniqueInterEnd_Test"--
end--<


--TUNE, interrogation type selection
this.InterCall_Location=function(soldierId,cpId,interName)
  --InfMenu.DebugPrint"InterCall_Location"--DEBUG
  --InfInspect.TryFunc(function()--DEBUG
  local interrFuncs={}
  if Ivars.enableLrrpFreeRoam:Is(1) then
    table.insert(interrFuncs,this.LrrpLocation)
  end

  --  if InfMain.IvarsEnabledForMission(InfNPCHeli.heliEnableIvars) then
  --    table.insert(interrFuncs,this.HeliLocation)
  --  end

  if Ivars.enableWildCardFreeRoam:Is(1) then
    table.insert(interrFuncs,this.WildCardLocation)
  end

  local LocationInterrogate=interrFuncs[math.random(#interrFuncs)]
  if LocationInterrogate then
    LocationInterrogate()
  end
  -- end)
end

function this.LrrpLocation()
  --InfMenu.DebugPrint"LrrpLocation"--DEBUG
  --tex TODO: eliminated check
  local lrrpDefine=InfMain.lrrpDefines[math.random(#InfMain.lrrpDefines)]
  local base1Name=InfMenu.CpNameString(lrrpDefine.base1,TppLocation.GetLocationName())
  local base2Name=InfMenu.CpNameString(lrrpDefine.base2,TppLocation.GetLocationName())
  InfMenu.DebugPrint("[Intel] the soldier indicates a LRRP is traveling between "..base1Name.." and "..base2Name)--DEBUGNOW ADDLANG
end

function this.WildCardLocation()
  --InfMenu.DebugPrint"WildCardLocation"--DEBUG
  local cpName=InfMain.ene_wildCardCps[math.random(#InfMain.ene_wildCardCps)]
  local cpNameString=InfMenu.CpNameString(cpName,TppLocation.GetLocationName())
  InfMenu.DebugPrint("[Intel] the soldier indicates there was a mercenary assigned to "..cpNameString)--DEBUGNOW ADDLANG
end

function this.HeliLocation()
  local routeStrCode=InfNPCHeli.heliRouteIds[math.random(#InfNPCHeli.heliRouteIds)]
  if routeStrCode==nil then
    return
  end

  local route

  local locationName=TppLocation.GetLocationName()
  --tex TODO: badslow
  local StrCode32=Fox.StrCode32
  for i,routeName in pairs(InfNPCHeli.heliRoutes[locationName]) do
    if StrCode32(routeName)==routeStrCode then
      route=routeName
      break
    end
  end

  local cpName=InfNPCHeli.heliRouteToCp[locationName][route]
  if cpName then
    local cpNameString=InfMenu.CpNameString(cpName,locationName)
    InfMenu.DebugPrint("[Intel] the soldier indicates an attack heli is travelling to "..cpNameString)--DEBUGNOW ADDLANG
  end
end

--TUNE
local maxInterCpQuests=10
local numQuestSoldiers=maxInterCpQuests*2--SYNC Ivars svar inf_interCpQuestStatus GOTCHA must be < #cp names

this.interCpQuestSoldiers={}
this.interCpQuestIds={}
this.interCpQuestSoldiersCps={}

function this.SetupInterrogation(interrogation)
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end

  if Ivars.enableInfInterrogation:Is(0) then
    return
  end

  for cpName,interrTable in pairs(interrogation)do
    interrogation[cpName]={
      normal={
        {name="enqt1000_1x1a10",func=this.InterCall_Location}
      },
    }
    --DEBUGNOW
    --        interrogation[cpName]=interrogation[cpName] or {normal={}}
    --
    --        for i,interrId in pairs(this.locationInterrogateIds)do
    --          local interr={name=interrId,func=this.InterCall_Location}
    --          table.insert(interrogation[cpName].normal,interr)
    --        end
  end

end

function this.SetupInterCpQuests(soldierDefine,uniqueInterrogation)
  if vars.missionCode~=30010 and vars.missionCode~=30020 then
    return
  end

  if Ivars.enableInfInterrogation:Is(0) then
    return
  end


    InfMain.SetLevelRandomSeed()

    this.interCpQuestSoldiers={}
    this.interCpQuestIds={}
    this.interCpQuestSoldiersCps={}

    local numLrrps=0

    local baseNamePool={}
    local startBases={}
    local endBases={}

    local locationName=TppLocation.GetLocationName()
    baseNamePool=InfMain.ResetPool(InfMain.baseNames[locationName])

    for n,cpName in pairs(baseNamePool)do
      local cpDefine=soldierDefine[cpName]
      if cpDefine==nil then
        --InfMenu.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
      elseif #cpDefine>0 then
        local cpId=GetGameObjectId(cpName)
        if cpId==NULL_ID then
          --InfMenu.DebugPrint(tostring(cpName).." cpId==NULL_ID")--DEBUG
        else
          table.insert(startBases,cpName)
        end
      else
        --InfMenu.DebugPrint(tostring(cpName).." cp define empty")--DEBUG
      end
    end

    baseNamePool={}
    for i=0,numQuestSoldiers do
      table.insert(baseNamePool,InfMain.GetRandomPool(startBases))
    end
    startBases=baseNamePool
    local half=math.floor(#startBases/2)
    for i=0,half do
      table.insert(endBases,InfMain.GetRandomPool(startBases))
    end

    uniqueInterrogation.unique=uniqueInterrogation.unique or {}
    for i,interrogationId in pairs(this.helpYouInterrogateIds) do
      local uniqueEntry={name=interrogationId,func=this.InterCall_InterCpQuest}
      table.insert(uniqueInterrogation.unique,uniqueEntry)
    end

    local soldierIndex=1
    while #startBases>0 and #endBases>0 do
      local isEven=(soldierIndex%2)==0

      local cpPool=startBases

      if isEven then
        cpPool=endBases
      end

      local cpName=cpPool[#cpPool]
      table.remove(cpPool)
      --InfMenu.DebugPrint("cpName:"..tostring(cpName))--DEBUG

      local cpDefine=soldierDefine[cpName]
      local rnd=math.random(#cpDefine)
      local soldierName=cpDefine[rnd]
      local soldierId=GetGameObjectId("TppSoldier2",soldierName)
      if soldierId==NULL_ID then
        InfMenu.DebugPrint("WARNING SetupSoldierPairs could not find soldier "..tostring(soldierName).." aborting")--DEBUGNOW
        break
      else
        this.interCpQuestSoldiers[soldierIndex]=soldierId
        this.interCpQuestIds[soldierId]=soldierIndex
        this.interCpQuestSoldiersCps[soldierIndex]=cpName

        uniqueInterrogation.uniqueChara=uniqueInterrogation.uniqueChara or {}
        local uniqueCharaEntry={name=soldierName,func=this.InterStart_CpQuest}
        --table.insert(uniqueInterrogation.unique,uniqueEntry)
        table.insert(uniqueInterrogation.uniqueChara,uniqueCharaEntry)
      end

      soldierIndex=soldierIndex+1
      numLrrps=numLrrps+1
    end
    --InfMenu.DebugPrint("num lrrps"..numLrrps)--DEBUG
    --InfInspect.PrintInspect(uniqueInterrogation)--DEBUG

    InfMain.ResetTrueRandom()
end

function this.GetPairedSoldier(soldierIndex)
  if (soldierIndex%2)==0 then--even
    return soldierIndex-1
  else
    return soldierIndex+1
  end
end

--tex DEBUGNOW TODO better lookup
function this.GetInterCpQuestId(soldierId)
  return this.interCpQuestIds[soldierId]
end

function this.InterStart_CpQuest(soldierId,cpId,interName)
    --InfMenu.DebugPrint"InterStart"--DEBUG

  local soldierICPQId=this.GetInterCpQuestId(soldierId)
  if soldierICPQId==nil then
    InfMenu.DebugPrint"WARNING cannot find cpQuestId for soldier"--DEBUGNOW
    return false
  end

  local partnerICPQId=this.GetPairedSoldier(soldierICPQId)
  if partnerICPQId==nil then
    InfMenu.DebugPrint"WARNING partnerId==nil"--DEBUGNOW
    return false
  end

  local partnerGameId=this.interCpQuestSoldiers[partnerICPQId]
  if partnerGameId==nil then
    --InfMenu.DebugPrint"partnerGameId==nil"--DEBUG
    return false
  end
  local partnerCpName=this.interCpQuestSoldiersCps[partnerICPQId]
  if partnerCpName==nil then
    --InfMenu.DebugPrint"partnerCpName==nil"--DEBUG
    return false
  end

  local interrogationId=this.helpYouInterrogateIds[math.random(#this.helpYouInterrogateIds)]
  TppInterrogation.UniqueInterrogation(cpId,interrogationId)
  return true
end

this.InterCall_InterCpQuest = function(soldierId,cpId,interName)
    --InfInspect.TryFunc(function(soldierId,cpId,interName)--DEBUG
    --InfMenu.DebugPrint"InterCall_InterCpQuest"--DEBUG
    local soldierICPQId=this.GetInterCpQuestId(soldierId)
    if soldierICPQId==nil then
      InfMenu.DebugPrint"cannot find cpQuestId for soldier"--DEBUG
      return
    end

    local partnerICPQId=this.GetPairedSoldier(soldierICPQId)
    if partnerICPQId==nil then
      InfMenu.DebugPrint"partnerId==nil"--DEBUG
      return
    end

    --tex starting
    if not svars.inf_interCpQuestStatus[partnerICPQId] then
      local partnerGameId=this.interCpQuestSoldiers[partnerICPQId]
      local partnerCpName=this.interCpQuestSoldiersCps[partnerICPQId]
      local cpNameLang=InfMenu.CpNameString(partnerCpName,TppLocation.GetLocationName())
      --InfMenu.DebugPrint("sol cpquestid:"..soldierIQId.." partnerId:"..partnerIQId)--DEBUG
      InfMenu.DebugPrint("[Intel] the soldier indicates his comrade assigned to "..cpNameLang.." has stashed some things")--DEBUGNOW ADDLANG
      --DEBUGNOW
      --        set up marker?
      --        save starttime
      --        save startposition? -- TODO: just calculate between base positions
      svars.inf_interCpQuestStatus[soldierICPQId]=true
      --tex complete quest
    elseif svars.inf_interCpQuestStatus[partnerICPQId] and not svars.inf_interCpQuestStatus[soldierICPQId] then
      InfMenu.DebugPrint"[Intel] the soldier has given us the location of their stash"--DEBUGNOW ADDLANG
      this.GiveInterCpQuestReward()

      svars.inf_interCpQuestStatus[soldierICPQId]=true
      --tex quest completed
    elseif svars.inf_interCpQuestStatus[soldierICPQId] and svars.inf_interCpQuestStatus[partnerICPQId] then
      --       --InfMenu.DebugPrint"InterCall_InterCpQuest, quest was already completed "--DEBUG
      InfMenu.DebugPrint"[Intel] the soldier is just repeating himself"--DEBUGNOW ADDLANG
    else
      InfMenu.DebugPrint"[Intel] the soldier is just repeating himself"--DEBUGNOW ADDLANG
    end
  --end,soldierId,cpId,interName)
end--DEBUGNOW

local resourceNames={
  "CommonMetal",
  "MinorMetal",
  "PreciousMetal",
  "FuelResource",
  "BioticResource",
}

local parasiteResourceNames={
  "ParasiteFog",--mist
  "ParasiteCamofla",--camo
  "ParasiteCuring",--armor
}
--TUNE
local resourceMin=10000
local resourceMax=20000
local parasiteChance=30
function this.GiveInterCpQuestReward(rewardType)
  if math.random(100)>parasiteChance then
    local resourceCount=math.random(resourceMin,resourceMax)
    local resourceName=resourceNames[math.random(#resourceNames)]
    TppMotherBaseManagement.AddTempResource{resource=resourceName,count=resourceCount}
  else
    local resourceCount=1
    local resourceName=parasiteResourceNames[math.random(#parasiteResourceNames)]
    TppMotherBaseManagement.AddTempResource{resource=resourceName,count=resourceCount}
  end
end

return this
