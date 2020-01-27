-- InfQuest.lua
-- tex implements various sideops/quest selection options
-- WIP also easier new quest setup
local this={}

local TppDefine=TppDefine
local InfLog=InfLog

this.debugModule=false

this.ihQuestNames={
  "quest_q30100",
  "quest_q30101",
  "quest_q30102",
}

local CanOpenClusterGrade0=function(questName)
  local questInfo=this.ihQuestsInfo[questName]
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE[questInfo.clusterName]+1)>0
end
local function AllwaysOpenQuest()
  return true
end

--tex see RegisterQuests
this.ihQuestsInfo={
  quest_q30100={--mtbs sheep
    questPackList={"/Assets/tpp/pack/mission2/quest/ih/ih_sheep_quest.fpk"},
    locationId=TppDefine.LOCATION_ID.MTBS,
    areaName="MtbsCombat",
    clusterName="Combat",
    plntId=TppDefine.PLNT_DEFINE.Special,
    category=TppQuest.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL,
    questCompleteLangId="announce_quest_extract_animal",
    canOpenQuest=CanOpenClusterGrade0,
    questRank=TppDefine.QUEST_RANK.G,
  },
  quest_q30101={--mtbs bird
    questPackList={"/Assets/tpp/pack/mission2/quest/ih/ih_bird_quest.fpk"},
    locationId=TppDefine.LOCATION_ID.MTBS,
    areaName="MtbsSpy",
    clusterName="Spy",
    plntId=TppDefine.PLNT_DEFINE.Special,
    category=TppQuest.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL,
    questCompleteLangId="announce_quest_extract_animal",
    canOpenQuest=CanOpenClusterGrade0,
    questRank=TppDefine.QUEST_RANK.G,
  },
  quest_q30102={--mtbs rat
    questPackList={"/Assets/tpp/pack/mission2/quest/ih/ih_rat_quest.fpk"},
    locationId=TppDefine.LOCATION_ID.MTBS,
    areaName="MtbsSupport",
    clusterName="Support",
    plntId=TppDefine.PLNT_DEFINE.Special,
    category=TppQuest.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL,
    questCompleteLangId="announce_quest_extract_animal",
    canOpenQuest=CanOpenClusterGrade0,
    questRank=TppDefine.QUEST_RANK.G,
  },
}

local blockQuests={
  tent_q99040=true, -- 144 - recover volgin, player is left stuck in geometry at end of quanranteed plat demo
  sovietBase_q99020=true,-- 82, make contact with emmeric
}

local mbShootingPracticeQuests={
  mtbs_q42010=true,
  mtbs_q42020=true,
  mtbs_q42030=true,
  mtbs_q42040=true,
  mtbs_q42050=true,
  mtbs_q42060=true,
  mtbs_q42070=true,
}

--block quests>
function this.BlockQuest(questName)
  --tex TODO: doesn't work for the quest area you start in (need to clear before in actual mission)
  if vars.missionCode==30050 and InfGameEvent.IsMbEvent() then
    --InfLog.Add("BlockQuest on event "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
    return true
  end

  if Ivars.inf_event:Is"WARGAME" then--tex WARGAME is mb events
    --InfLog.Add("BlockQuest on WARGAME "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
    return true
  end

  if blockQuests[questName] then
    if TppQuest.IsCleard(questName) then
      return true
    end
  end

  --tex TODO
  -- if Ivars.mbBlockShootingQuests:Is(1) then
  --    if mbShootingPracticeQuests[questName] then
  --    if TppQuest.IsCleard(questName) then
  --      return true
  --    end
  --  end
  -- end

  --tex block heli quests to allow super reinforce
  if Ivars.enableHeliReinforce:Is(1) then
    --if TppMission.GetMissionID()==30010 or TppMission.GetMissionID()==30020 then
    for n,name in ipairs(TppDefine.QUEST_HELI_DEFINE)do
      if name==questName then
        return true
      end
    end
    --end
  end

  return false
end

--tex <areaName>=<questName>
local forcedQuests={}

local printUnlockedFmt="unlockSideOpNumber:%u %s %s"
function this.GetForced()
  --tex TODO: need to get intended mission code
  if vars.missionCode==30050 and InfGameEvent.IsMbEvent() then
    --InfLog.Add("GetForced on event "..tostring(vars.missionCode))--DEBUG
    return nil
  end

  if Ivars.inf_event:Is"WARGAME" then
    --InfLog.Add("GetForced on Wargame "..tostring(vars.missionCode))--DEBUG
    return nil
  end

  local forcedCount=0
  --tex Clear
  for areaName,forceCount in pairs(forcedQuests)do
    forcedQuests[areaName]=nil
  end

  local questTable=TppQuest.GetQuestInfoTable()

  --tex find name and area for unlocksideop
  local unlockSideOpNumber=Ivars.unlockSideOpNumber:Get()
  if unlockSideOpNumber>0 then
    local unlockedName=questTable[unlockSideOpNumber].questName
    local unlockedArea=nil
    if unlockedName~=nil then
      unlockedArea=TppQuestList.questAreaTable[unlockedName]
      forcedQuests[unlockedArea]=unlockedName
      forcedCount=forcedCount+1
      InfLog.Add(string.format(printUnlockedFmt,unlockSideOpNumber,unlockedName,unlockedArea))
    end
  end

  if forcedCount==0 then
    return nil
  else
    if this.debugModule then
      InfLog.Add("forcedQuests")
      InfLog.PrintInspect(forcedQuests)
    end

    return forcedQuests
  end
end

--REF TppQuestList.questList={
--  {locationId=TppDefine.LOCATION_ID.MTBS,areaName="MtbsCombat",clusterName="Combat",
--    infoList={
--    {name="mtbs_q42070",invokeStepName="QStep_Start"},
--    {name="quest_q30100",invokeStepName="QStep_Start"},
function this.AddToQuestList(questList,questAreaTable,questName,questInfo)
  if not questAreaTable[questName]then
    for i,areaQuests in ipairs(questList)do
      if areaQuests.locationId==questInfo.locationId
        and areaQuests.areaName==questInfo.areaName then
        local questAdded=false
        local infoList=areaQuests.infoList
        for i,areaQuest in ipairs(infoList)do
          if areaQuest==questName then
            questAdded=true
            break
          end
        end
        if not questAdded then
          questAreaTable[questName]=questInfo.areaName
          local infoEntry={name=questName,invokeStepName="QStep_Start"}
          table.insert(infoList,infoEntry)
        end
      end
    end
  end
end

--REF TppQuest.questInfoTable={
--  --[[XXX]]{questName="quest_q30100",questId="quest_q30100",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Combat,plntId=TppDefine.PLNT_DEFINE.Special,category=this.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL},--tex
--  --[[XXX]]{questName="fort_q71080",questId="quest_q71080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2080.718,456.726,-1927.582),radius=5,category=this.QUEST_CATEGORIES_ENUM.ELIMINATE_PUPPETS},
function this.AddToQuestInfoTable(questInfoTable,questTableIndexes,questName,questInfo)
  if not questTableIndexes[questName] then
    local index=#questInfoTable+1
    questTableIndexes[questName]=index
    questInfoTable[index]={
      questName=questName,
      questId=questName,
      locationId=questInfo.locationId,
      clusterId=TppDefine.CLUSTER_DEFINE[questInfo.clusterName],
      plntId=questInfo.plntId,
      iconPos=questInfo.iconPos,
      radius=questInfo.radius,
      category=questInfo.category,
    }
  end
end

--CALLER: InfMain OnInitialize, before TppQuest.RegisterQuestList
--tex basically just pulls together a lot of scattered data for easier setup of new quests
--GOTCHA: since the quest save variables (gvars.qst_questOpenFlag etc) are indexed there will be issues with removing quests
--TODO: if you really want to be able to add/remove willy nilly, instead of automatically registering all in ihQuestsInfo
--have the user manually register/deregister. would have to have saved table of questname to index
function this.RegisterQuests()
  InfLog.AddFlow("InfQuest.RegisterQuests")--DEBUG

  local questInfoTable=TppQuest.GetQuestInfoTable()
  local questTableIndexes=TppQuest.QUESTTABLE_INDEX
  local openQuestCheckTable=TppQuest.GetCanOpenQuestTable()
  local questAreaTable=TppQuestList.questAreaTable
  local questList=TppQuestList.questList

  --tex TODO: validate ihQuestNames,ihQuestsInfo

  for i,questName in ipairs(this.ihQuestNames)do
    local questInfo=this.ihQuestsInfo[questName]
    local questIndex=TppDefine.QUEST_INDEX[questName]
    --InfLog.Add("RegisterQuests "..questName.." "..tostring(questIndex))--DEBUG
    if this.debugModule then
      InfLog.PrintInspect(questInfo)
    end
    if questIndex==nil then
      questIndex=#TppDefine.QUEST_DEFINE+1
      if this.debugModule then
        InfLog.Add("RegisterQuests "..questName.." "..tostring(questIndex))--DEBUG
      end
      TppDefine.QUEST_DEFINE[questIndex]=questName
      TppDefine.QUEST_INDEX=TppDefine.Enum(TppDefine.QUEST_DEFINE)
      --InfLog.PrintInspect(TppDefine.QUEST_RANK_TABLE)--DEBUG
      TppDefine.QUEST_RANK_TABLE[TppDefine.QUEST_INDEX[questName]]=questInfo.questRank
      --InfLog.PrintInspect(TppDefine.QUEST_RANK_TABLE)--DEBUG

      this.AddToQuestInfoTable(questInfoTable,questTableIndexes,questName,questInfo)
      openQuestCheckTable[questName]=questInfo.canOpenQuest or AllwaysOpenQuest
      TppQuest.questCompleteLangIds[questName]=questInfo.questCompleteLangId

      this.AddToQuestList(questList,questAreaTable,questName,questInfo)
      TppQuestList.questPackList[questName]=questInfo.questPackList
    end
  end

  if this.debugModule then
    InfLog.AddFlow"InfQuest.RegisterQuests"
    InfLog.Add"QUEST_INDEX"
    InfLog.PrintInspect(TppDefine.QUEST_INDEX)
    InfLog.Add"QUEST_RANK_TABLE"
    InfLog.PrintInspect(TppDefine.QUEST_RANK_TABLE)
    InfLog.Add"questAreaTable"
    InfLog.PrintInspect(questAreaTable)
    InfLog.Add"questList"
    InfLog.PrintInspect(questList)
    InfLog.Add"openQuestCheckTable"
    InfLog.PrintInspect(openQuestCheckTable)
    InfLog.Add"questPackList"
    InfLog.PrintInspect(TppQuestList.questPackList)
  end
end

--tex GetSideOpsListTable is called by engine for sideops ui
function this.PrintSideOpsListTable()
  local sideOpsTable=TppQuest.GetSideOpsListTable()
  InfLog.PrintInspect(sideOpsTable)
end

--
function this.Test_SetBirdPostion()
  local birdInfo={
    name="anml_quest_00",
    birdType="TppStork",
    center={-679.108,31.5,534.532},
    radius=0,
    height=0,
    ground={-679.108,29.809,534.532},
    perch={-679.108,29.809,534.532},
  }

  --tex TppBirdLocatorParameter2 - radius=5, height=10

  local birdGameId={type=birdInfo.birdType,index=0}
  local setEnabledCommand={id="SetEnabled",name=birdInfo.name,birdIndex=0,enabled=true}
  GameObject.SendCommand(birdGameId,setEnabledCommand)
  if(birdInfo.center and birdInfo.radius)and birdInfo.height then
    local changeFlyingZoneCommand={id="ChangeFlyingZone",name=birdInfo.name,center=birdInfo.center,radius=birdInfo.radius,height=birdInfo.height}
    GameObject.SendCommand(birdGameId,changeFlyingZoneCommand)
    local setLandingPointCommand=nil
    if birdInfo.ground then
      setLandingPointCommand={id="SetLandingPoint",birdIndex=0,name=birdInfo.name,groundPos=birdInfo.ground}
      GameObject.SendCommand(birdGameId,setLandingPointCommand)
    elseif birdInfo.perch then
      setLandingPointCommand={id="SetLandingPoint",birdIndex=0,name=birdInfo.name,perchPos=birdInfo.perch}
      GameObject.SendCommand(birdGameId,setLandingPointCommand)
    end
    local setAutoLandingCommand={id="SetAutoLanding",name=birdInfo.name}
    GameObject.SendCommand(birdGameId,setAutoLandingCommand)
  end
end

function this.Test_SetRatPosition()
  local ratList={
    "anml_rat_00",
    "anml_rat_01",
    "anml_rat_02",
    "anml_rat_03",
    "anml_rat_04",
    "anml_rat_05",
  }

  local positionsList={
    {359.466,-4.013,850.132},
    {356.234,-4.013,856.585},
    {360.531,-4.013,865.436},
    {355.715,-4.013,871.195},
    {359.369,-4.013,877.347},
    {368.626,-4.013,866.201},
    {368.027,-4.013,876.324},
    {376.112,-4.013,875.328},
    {374.444,-4.013,866.858},
    {383.520,-4.013,870.073},
    {384.246,-4.013,860.197},
    {386.223,-4.013,847.923},
    {375.588,-4.013,852.175},
    {374.930,-4.013,858.982},
    {366.645,-4.013,849.100},
  }

  local positionBag=InfMain.ShuffleBag:New()
  for i,coords in ipairs(positionsList)do
    positionBag:Add(coords)
  end

  function this.WarpRats()
    local tppRat={type="TppRat",index=0}
    for i,name in ipairs(ratList)do
      local pos=positionBag:Next()
      local rotY=math.random(360)
      local route=""

      local command={id="Warp",name=name,ratIndex=0,position=pos,degreeRotationY=rotY,route=route,nodeIndex=0}
      GameObject.SendCommand(tppRat,command)
    end
  end
end

return this
