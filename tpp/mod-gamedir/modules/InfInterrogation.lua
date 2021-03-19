--InfInterrogation.lua
--tex implements enableInfInterrogation
local this={}

local StrCode32=InfCore.StrCode32
local InfMain=InfMain
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local IsTable=Tpp.IsTypeTable

this.debugModule=false

--STATE
--tex also gvars.inf_interCpQuestStatus --see Ivars.DeclareVars
this.interCpQuestSoldiers={}
this.interCpQuestIds={}
this.interCpQuestSoldiersCps={}

--TUNE
local maxInterCpQuests=10
local numQuestSoldiers=maxInterCpQuests*2--SYNC Ivars gvar inf_interCpQuestStatus GOTCHA must be < #cp names

local resourceMin=10000
local resourceMax=20000
local parasiteChance=40

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

this.registerIvars={
  "enableInfInterrogation",
}

this.enableInfInterrogation={
  save=IvarProc.CATEGORY_EXTERNAL,
  range=Ivars.switchRange,
  settingNames="set_switch",
  MissionCheck=IvarProc.MissionCheckFreeVanilla,
}
--<
this.langStrings={
  eng={
    enableInfInterrogation="IH interrogation in free roam",
    interrogate_lrrp="[Intel] the soldier indicates a LRRP is traveling between %s and %s",--cp name 1, cp name 2
    interrogate_lrrp_walker="[Intel] the soldier indicates a Walker Gear was traveling between %s and %s",--cp name 1, cp name 2
    interrogate_walker="[Intel] the soldier indicates there was a Walker Gear assigned to %s",--cp name
    interrogate_wildcard="[Intel] the soldier indicates there was a mercenary assigned to %s",--cp name
    interrogate_heli="[Intel] the soldier indicates an attack heli is travelling to %s",--cp name
    intercp_comrade_location="[Intel] the soldier indicates their comrade assigned to %s has stashed some things",--cp name
    intercp_complete="[Intel] the soldier has given us the location of their stash",
    intercp_repeat="[Intel] the soldier is just repeating himself",
  },
  help={
    eng={
      enableInfInterrogation="Adds some interrogations to soldiers: Travel plan of foot patrol, Location of wild card soldier, Location of walker gear. Inter CP quest: Sets up pairs of soldiers in different cps, interrogating one will give CP of other, interrogating him will give a reward of unprocessed resources (around a couple of containers worth) or a skull soldier/parasite on the next extraction (reaching checkpoint etc)",
    },
  },
}

function this.Init(missionTable)
  if not missionTable.enemy then
    return
  end

  if TppMission.IsMissionStart() then
    --InfCore.Log("InfInterrogate IsMissionStart")--DEBUG
    --tex TODO KLUDGE, cant actually see how it's reset normally, I guess it's through the TppInterrogate.DeclareSvars
    --but it doesn't seem to trigger unless I do
    --also there seems to be only one actual .normal interrogation used in one mission (s10043), unless the generic interrogation uses the .normal layer
    --and doing it this way actually resets the save vars
    --breaking my policy here in that this code is run reguardless
    for index=0,127 do
      svars.InterrogationNormal[index]=bit.bnot(0)--tex from TppInterrogation.ResetFlagNormal
    end
  end
  if not Ivars.enableInfInterrogation:EnabledForMission() then
    return
  end

  local enemyTable=missionTable.enemy
  if IsTable(enemyTable.soldierDefine) then
    --InfCore.Log("InfInterrogation setting up")--DEBUG
    this.SetupInterrogation(enemyTable.interrogation)
    enemyTable.uniqueInterrogation=enemyTable.uniqueInterrogation or {}
    this.SetupInterCpQuests(enemyTable.soldierDefine,enemyTable.uniqueInterrogation)
  end
  if this.debugModule then
    InfCore.PrintInspect(enemyTable.interrogation,"enemyTable.interrogation")
    InfCore.PrintInspect(enemyTable.uniqueInterrogation,"enemyTable.uniqueInterrogation")
  end
end

--DEBUG>
this.InterCall_Test=function(soldierId,cpId,interName)
  InfCore.DebugPrint"InterCall_Test"--
end

this.UniqueInterEnd_Test=function(soldierId,cpId,interName)
  InfCore.DebugPrint"UniqueInterEnd_Test"--
end--<


--TUNE, interrogation type selection
this.InterCall_Location=function(soldierId,cpId,interName)
  --InfCore.DebugPrint"InterCall_Location"--DEBUG
  InfCore.PCallDebug(function(soldierId,cpId,interName)--DEBUG
    local interrFuncs={}
    if Ivars.enableLrrpFreeRoam:Is(1) then
      interrFuncs[#interrFuncs+1]=this.LrrpLocation
    end

    --  if InfNPCHeli and IvarProc.EnabledForMission("attackHeliPatrols") then
    --    table.insert(interrFuncs,this.HeliLocation)
    --  end

    if Ivars.enableWildCardFreeRoam:Is(1) then
      interrFuncs[#interrFuncs+1]=this.WildCardLocation
    end

    if Ivars.enableWalkerGearsFREE:Is(1) then
      interrFuncs[#interrFuncs+1]=this.WalkerStaticLocation
    end

    local LocationInterrogate=interrFuncs[math.random(#interrFuncs)]
    if LocationInterrogate then
      LocationInterrogate()
    end
  end,soldierId,cpId,interName)--
end

function this.LrrpLocation()
  --InfCore.PCall(function()--DEBUG
  --InfCore.DebugPrint"LrrpLocation"--DEBUG
  --tex TODO: eliminated check
  local lrrpName=InfMain.lrrpDefines[math.random(#InfMainTpp.lrrpDefines)]
  local lrrpDefine=InfMainTpp.lrrpDefines[lrrpName]
  local base1Name=InfLangProc.CpNameString(lrrpDefine.base1,InfUtil.GetLocationName())
  local base2Name=InfLangProc.CpNameString(lrrpDefine.base2,InfUtil.GetLocationName())

  if base1Name==nil then
    InfCore.DebugPrint("Interr LrrpLocation no cpnamestring for "..tostring(lrrpDefine.base1))
  end
  if base2Name==nil then
    InfCore.DebugPrint("Interr LrrpLocation no cpnamestring for "..tostring(lrrpDefine.base2))
  end

  if lrrpDefine.cpDefine.lrrpWalker then
    InfMenu.PrintFormatLangId("interrogate_lrrp_walker",base1Name,base2Name)
  else
    InfMenu.PrintFormatLangId("interrogate_lrrp",base1Name,base2Name)
  end
  --end)--
end

function this.WalkerStaticLocation()

  --InfCore.PCall(function()--DEBUG
  InfCore.Log"WalkerStaticLocation"--DEBUG
  --tex TODO: eliminated check

  local walkerInfos=InfWalkerGear.mvar_walkerInfo
  local infoName=walkerInfos[math.random(#walkerInfos)]
  local walkerInfo=walkerInfos[infoName]
  local cpName=walkerInfo.cpName
  local cpNameString=InfLangProc.CpNameString(cpName,InfUtil.GetLocationName())
  InfMenu.PrintFormatLangId("interrogate_walker",cpNameString)
  --end)--
end

function this.WildCardLocation()
  --InfCore.DebugPrint"WildCardLocation"--DEBUG
  local soldierName=InfUtil.GetRandomInList(InfSoldier.ene_wildCardNames)
  local cpName=InfSoldier.ene_wildCardInfo[soldierName].cpName
  local cpNameString=InfLangProc.CpNameString(cpName,InfUtil.GetLocationName())
  InfMenu.PrintFormatLangId("interrogate_wildcard",cpNameString)
end

function this.HeliLocation()
  if not InfNPCHeli then
    return
  end
  local routeStrCode=InfNPCHeli.heliRouteIds[math.random(#InfNPCHeli.heliRouteIds)]
  if routeStrCode==nil then
    return
  end

  local route

  local locationName=InfUtil.GetLocationName()
  --tex TODO: badslow
  for i,routeName in pairs(InfNPCHeli.heliRoutes[locationName]) do
    if StrCode32(routeName)==routeStrCode then
      route=routeName
      break
    end
  end

  local cpName=InfNPCHeli.heliRouteToCp[locationName][route]
  if cpName then
    local cpNameString=InfLangProc.CpNameString(cpName,locationName)
    InfMenu.PrintFormatLangId("interrogate_heli",cpNameString)
  end
end

function this.SetupInterrogation(interrogation)
  for cpName,interrTable in pairs(interrogation)do
    interrogation[cpName]={
      normal={
        {name="enqt1000_1x1a10",func=this.InterCall_Location}
      },
    }
    --TODO
    --        interrogation[cpName]=interrogation[cpName] or {normal={}}
    --
    --        for i,interrId in pairs(this.locationInterrogateIds)do
    --          local interr={name=interrId,func=this.InterCall_Location}
    --          table.insert(interrogation[cpName].normal,interr)
    --        end
  end
end

function this.SetupInterCpQuests(soldierDefine,uniqueInterrogation)
  --InfCore.PCall(function(soldierDefine,uniqueInterrogation)--DEBUG
  if TppMission.IsMissionStart() then
    for i=0,numQuestSoldiers do
      gvars.inf_interCpQuestStatus[i]=false
    end
  end

  local InfMain=InfMain

  InfMain.RandomSetToLevelSeed()

  --tex basic interrogations
  uniqueInterrogation.unique=uniqueInterrogation.unique or {}
  for i,interrogationId in pairs(this.helpYouInterrogateIds) do
    local uniqueEntry={name=interrogationId,func=this.InterCall_InterCpQuest}
    table.insert(uniqueInterrogation.unique,uniqueEntry)
  end

  --tex intercp quests
  this.interCpQuestSoldiers={}
  this.interCpQuestIds={}
  this.interCpQuestSoldiersCps={}

  local numLrrps=0--DEBUG

  local baseNameBag=InfUtil.ShuffleBag:New()
  local locationName=InfUtil.GetLocationName()
  local baseNames=InfMain.baseNames[locationName]
  for n,cpName in pairs(baseNames)do
    local cpDefine=soldierDefine[cpName]
    if cpDefine==nil then
    --InfCore.DebugPrint(tostring(cpName).." cpDefine==nil")--DEBUG
    elseif #cpDefine>0 then
      local cpId=GetGameObjectId("TppCommandPost2",cpName)
      if cpId==NULL_ID then
        InfCore.DebugPrint("SetupInterCpQuests baseNamePool "..tostring(cpName).." cpId==NULL_ID")--DEBUG
      else
        baseNameBag:Add(cpName)
      end
    end
  end

  local soldierIndex=1
  local numBases=baseNameBag:Count()
  --tex cp quests work in pairs of soldiers, one pointing to another
  --currently theres a quest soldier in every cp, since it's a specific soldier, and the quest requires travel, it's not really 'too many'
  local evenBases=(numBases%2)==0
  if not evenBases then
    numBases=numBases-1
  end
  for i=1,numBases do
    local cpName=baseNameBag:Next()
    --InfCore.DebugPrint("cpName:"..tostring(cpName))--DEBUG

    local cpDefine=soldierDefine[cpName]
    local rnd=math.random(#cpDefine)
    local soldierName=cpDefine[rnd]
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    if soldierId==NULL_ID then
      InfCore.DebugPrint("WARNING SetupSoldierPairs could not find soldier "..tostring(soldierName).." aborting")--DEBUG
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
  --InfCore.DebugPrint("num lrrps"..numLrrps)--DEBUG

  --InfCore.PrintInspect(uniqueInterrogation)--DEBUG

  InfMain.RandomResetToOsTime()
  --end,soldierDefine,uniqueInterrogation)--DEBUG
end

function this.GetPairedSoldier(soldierIndex)
  if (soldierIndex%2)==0 then--even
    return soldierIndex-1
  else
    return soldierIndex+1
  end
end

function this.GetInterCpQuestId(soldierId)
  return this.interCpQuestIds[soldierId]
end

function this.InterStart_CpQuest(soldierId,cpId,interName)
  --InfCore.DebugPrint"InterStart"--DEBUG

  local soldierICPQId=this.GetInterCpQuestId(soldierId)
  if soldierICPQId==nil then
    InfCore.DebugPrint"WARNING cannot find cpQuestId for soldier"--DEBUG
    return false
  end

  local partnerICPQId=this.GetPairedSoldier(soldierICPQId)
  if partnerICPQId==nil then
    InfCore.DebugPrint"WARNING partnerId==nil"--DEBUG
    return false
  end

  local partnerGameId=this.interCpQuestSoldiers[partnerICPQId]
  if partnerGameId==nil then
    --InfCore.DebugPrint"partnerGameId==nil"--DEBUG
    return false
  end
  local partnerCpName=this.interCpQuestSoldiersCps[partnerICPQId]
  if partnerCpName==nil then
    --InfCore.DebugPrint"partnerCpName==nil"--DEBUG
    return false
  end

  local interrogationId=this.helpYouInterrogateIds[math.random(#this.helpYouInterrogateIds)]
  TppInterrogation.UniqueInterrogation(cpId,interrogationId)
  return true
end

this.InterCall_InterCpQuest = function(soldierId,cpId,interName)
  --InfCore.PCall(function(soldierId,cpId,interName)--DEBUG
  --InfCore.DebugPrint"InterCall_InterCpQuest"--DEBUG
  local soldierICPQId=this.GetInterCpQuestId(soldierId)
  if soldierICPQId==nil then
    InfCore.DebugPrint"cannot find cpQuestId for soldier"--DEBUG
    return
  end

  local partnerICPQId=this.GetPairedSoldier(soldierICPQId)
  if partnerICPQId==nil then
    InfCore.DebugPrint"partnerId==nil"--DEBUG
    return
  end

  --tex starting
  if not gvars.inf_interCpQuestStatus[partnerICPQId] then
    local partnerGameId=this.interCpQuestSoldiers[partnerICPQId]
    local partnerCpName=this.interCpQuestSoldiersCps[partnerICPQId]
    local cpNameLang=InfLangProc.CpNameString(partnerCpName,InfUtil.GetLocationName())
    --InfCore.DebugPrint("sol cpquestid:"..soldierIQId.." partnerId:"..partnerIQId)--DEBUG
    InfMenu.PrintFormatLangId("intercp_comrade_location",cpNameLang)
    --tex TODO:
    --        set up marker?
    --        save starttime
    --        save startposition? -- TODO: just calculate between base positions
    gvars.inf_interCpQuestStatus[soldierICPQId]=true
    --tex complete quest
  elseif gvars.inf_interCpQuestStatus[partnerICPQId] and not gvars.inf_interCpQuestStatus[soldierICPQId] then
    InfMenu.PrintLangId"intercp_complete"
    this.GiveInterCpQuestReward()

    gvars.inf_interCpQuestStatus[soldierICPQId]=true
    --tex quest completed
  elseif gvars.inf_interCpQuestStatus[soldierICPQId] and gvars.inf_interCpQuestStatus[partnerICPQId] then
    --       --InfCore.DebugPrint"InterCall_InterCpQuest, quest was already completed "--DEBUG
    InfMenu.PrintLangId"intercp_repeat"
  else
    InfMenu.PrintLangId"intercp_repeat"
  end
  --end,soldierId,cpId,interName)
end

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
