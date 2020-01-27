-- InfQuest.lua
-- tex implements various sideops/quest selection options
-- also new quest setup
local this={}

local TppDefine=TppDefine
local InfCore=InfCore

this.debugModule=false

--tex the engine breaks down the quest name in some cases to the last 6 characters (ie q30010), or just the numbers
--see TppQuest GetQuestNameId, GetQuestName
--it uses the q name as the lookup for the lang string name_<qname> and info_<qname>
--I'm not sure if anything before that has any signifincance, many have quest_ as the prefix, others have the quest area name.
this.numIHQuests=100
this.questNameFmt="quest_q301%02d"

this.questsRegistered=false

--tex see LoadQuestDefs,
this.ihQuestNames={}
--tex see LoadQuestDefs, RegisterQuests
--k=questName,v=questDef module
this.ihQuestsInfo={}

--k=questName,v=quest status gvar index
this.installedQuests={}

function this.PostModuleReload(prevModule)
  this.questsRegistered=prevModule.questsRegistered
  this.ihQuestNames=prevModule.ihQuestNames
  this.ihQuestsInfo=prevModule.ihQuestsInfo
  this.installedQuests=prevModule.installedQuests
end

function this.CanOpenClusterGrade0(questName)
  local questInfo=this.ihQuestsInfo[questName]
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE[questInfo.clusterName]+1)>0
end
function this.AllwaysOpenQuest()
  return true
end

--REF questDef
-- ih_quest_q30103.lua
-- IH quest definition - example quest, afgh wailo village hostage
--local this={
--  questPackList={
--    "/Assets/tpp/pack/mission2/quest/ih/ih_example_quest.fpk",--quest fpk
--    randomFaceList={--for hostage isFaceRandom, see TppQuestList
--      race={TppDefine.QUEST_RACE_TYPE.ASIA},
--      gender=TppDefine.QUEST_GENDER_TYPE.WOMAN
--    }
--  },
--  locationId=TppDefine.LOCATION_ID.AFGH,
--  areaName="field",--tex use the 'Show position' command in the debug menu to print the quest area you are in to ih_log.txt, see TppQuest. afgAreaList,mafrAreaList,mtbsAreaList. 
--  --If areaName doesn't match the area the iconPos is in the quest fpk will fail to load (even though the Commencing Sideop message will trigger fine).
--  iconPos=Vector3(489.741,321.901,1187.506),--position of the quest area circle in idroid
--  radius=4,--radius of the quest area circle
--  category=TppQuest.QUEST_CATEGORIES_ENUM.PRISONER,--Category for the IH selection/filtering options.
--  questCompleteLangId="quest_extract_hostage",--Used for feedback of quest progress, see REF questCompleteLangId in InfQuest
--  canOpenQuest=InfQuest.AllwaysOpenQuest,--function that decides whether the quest is open or not
--  questRank=TppDefine.QUEST_RANK.G,--reward rank for clearing quest, see TppDefine.QUEST_BONUS_GMP and TppHero.QUEST_CLEAR
--}
--return this

--REF questCompleteLangId =
--"quest_extract_elite",--Highly-Skilled Soldier Extracted [%d/%d]"
--"quest_defeat_armor",--"Heavy Infantry Eliminated [%d/%d]"
--"quest_defeat_zombie",--"Wandering Puppet Eliminated [%d/%d]"
--"quest_extract_hostage","Prisoner Extracted [%d/%d]"
--"quest_defeat_armor_vehicle","Armored Vehicle Unit Eliminated [%d/%d]"
--"quest_defeat_tunk","Tank Unit Eliminated [%d/%d]"
--"quest_target_eliminate","Target Destroyed [%d/%d]"
--"mine_quest_log",--"Mine Cleared [%d/%d]"
--"quest_extract_animal",--"Animal Extracted [%d/%d]"--tex added by IH


local blockQuests={
  tent_q99040=true, -- 144 - recover volgin, player is left stuck in geometry at end of quanranteed plat demo
  sovietBase_q99020=true,-- 82, make contact with emmeric
}

--block quests>
function this.BlockQuest(questName)
  --tex TODO: doesn't work for the quest area you start in (need to clear before in actual mission)
  if vars.missionCode==30050 and InfMain.IsMbEvent() then
    --InfCore.Log("BlockQuest on event "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
    return true
  end

  if Ivars.inf_event:Is"WARGAME" then--tex WARGAME is mb events
    --InfCore.Log("BlockQuest on WARGAME "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
    return true
  end

  if blockQuests[questName] then
    if TppQuest.IsCleard(questName) then
      return true
    end
  end

  --TODO instead of faffing about in tppquest to filter categories just filter here

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
  if vars.missionCode==30050 and InfMain.IsMbEvent() then
    --InfCore.Log("GetForced on event "..tostring(vars.missionCode))--DEBUG
    return nil
  end

  if Ivars.inf_event:Is"WARGAME" then
    --InfCore.Log("GetForced on Wargame "..tostring(vars.missionCode))--DEBUG
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
  if unlockSideOpNumber>0 and unlockSideOpNumber<=#questTable  then
    local unlockedName=questTable[unlockSideOpNumber].questName
    local unlockedArea=nil
    if unlockedName~=nil then
      unlockedArea=TppQuestList.questAreaTable[unlockedName]
      forcedQuests[unlockedArea]=unlockedName
      forcedCount=forcedCount+1
      InfCore.Log(string.format(printUnlockedFmt,unlockSideOpNumber,unlockedName,unlockedArea))
    end
  end

  if forcedCount==0 then
    return nil
  else
    if this.debugModule then
      InfCore.PrintInspect(forcedQuests,{varName="questInfo"})
    end

    return forcedQuests
  end
end

local questDefPath="/Assets/tpp/script/ih/quest/"
local extension=".lua"
function this.LoadQuestDefs()
  InfCore.LogFlow"LoadQuestDefs"
  for i=0,this.numIHQuests-1 do
    local questId=string.format(this.questNameFmt,i)
    local moduleName="ih_"..questId
    local path=questDefPath..moduleName..extension
    --InfCore.Log("Attempting to load module "..path)--DEBUG
    Script.LoadLibrary(path)
    local module=_G[moduleName]
    if module then
      InfCore.Log("Loaded questDef "..moduleName)

      --tex TODO validate questDef

      this.ihQuestNames[#this.ihQuestNames+1]=questId
      this.ihQuestsInfo[questId]=module
    end
  end
end

--REF TppQuestList.questList={
--  {locationId=TppDefine.LOCATION_ID.MTBS,areaName="MtbsCombat",clusterName="Combat",
--    infoList={
--    {name="mtbs_q42070",invokeStepName="QStep_Start"},
--    {name="quest_q30100",invokeStepName="QStep_Start"},
function this.AddToQuestList(questList,questAreaTable,questName,questInfo)
  --tex TODO: build an area>questList areaQuests index lookup? -- use TppQuest.questAreaToQuestListIndex (after verifying its valid)
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
          break
        end
      end
    end
  end
end

local gvarFlagNames={
  "qst_questOpenFlag",
  "qst_questRepopFlag",
  "qst_questClearedFlag",
  "qst_questActiveFlag",
}
function this.GetGvarFlags()
  local gvarFlags={}
  for questGvarIndex=TppDefine.NUM_VANILLA_QUEST_DEFINES,TppDefine.QUEST_MAX-1 do
    gvarFlags[questGvarIndex]={}
    for i,gvarName in ipairs(gvarFlagNames)do
      gvarFlags[questGvarIndex][gvarName]=gvars[gvarName][questGvarIndex]
    end
  end
  return gvarFlags
end

--tex ASSUMPTION: questInfo.areaName valid
--IN/OUT questList,questAreaTable
-- WIP
function this.AddToQuestListQuick(questList,questAreaTable,questAreaToQuestListIndex,questName,questInfo)
  if not questAreaTable[questName]then
    questAreaTable[questName]=questInfo.areaName
    local areaIndex=questAreaToQuestListIndex[questInfo.areaName]
    local areaQuests=questList[areaIndex]
    areaQuests.infoList[#areaQuests.infoList]={name=questName,invokeStepName="QStep_Start"}
  end
end

--REF TppQuest.questInfoTable={
--  --[[XXX]]{questName="quest_q30100",questId="quest_q30100",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Combat,plntId=TppDefine.PLNT_DEFINE.Special,category=this.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL},--tex
--  --[[XXX]]{questName="fort_q71080",questId="quest_q71080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2080.718,456.726,-1927.582),radius=5,category=this.QUEST_CATEGORIES_ENUM.ELIMINATE_PUPPETS},
--IN/OUT: questInfoTable,questTableIndexes
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
  InfCore.LogFlow("InfQuest.RegisterQuests")

  local questInfoTable=TppQuest.GetQuestInfoTable()

  if this.debugModule then
    InfCore.Log("numVanillaUiQuests:"..TppQuest.NUM_VANILLA_UI_QUESTS.." #questInfoTable:"..#questInfoTable)
  end

  --tex already registered, TODO alternatively, set a bool, but if its in the module make sure you transfer it on module reload
  if this.questsRegistered then
    InfCore.Log"Quests already registered"
    --InfCore.PrintInspect(questInfoTable)--DEBUG

    --tex WORKAROUND, cant do in TppQuest.RegisterQuestPackList since it's already using random inside its loop
    --GOTCHA: since it's putting it into faceId list randomFaceListIH doesn't work with mixed random and defined faces like randomFaceList does
    for i,questName in ipairs(this.ihQuestNames)do
      local questInfo=this.ihQuestsInfo[questName]
      local faceSettings=questInfo.questPackList.randomFaceListIH
      if faceSettings then
        questInfo.questPackList.faceIdList=InfEneFova.GetRandomFaces(faceSettings.gender,faceSettings.count)
      end
    end

    return
  end

  local TppQuest=TppQuest
  local TppQuestList=TppQuestList

  local questInfoTable=TppQuest.GetQuestInfoTable()
  local openQuestCheckTable=TppQuest.GetCanOpenQuestTable()

  InfMain.RandomSetToLevelSeed()

  for i,questName in ipairs(this.ihQuestNames)do
    local questInfo=this.ihQuestsInfo[questName]

    local questIndex=#TppDefine.QUEST_DEFINE+1

    InfCore.Log("RegisterQuests "..questName.." "..tostring(questIndex))--DEBUG
    if this.debugModule then
      InfCore.PrintInspect(questInfo,{varName="questInfo"})
    end

    TppDefine.QUEST_DEFINE[questIndex]=questName
    TppDefine.QUEST_INDEX=TppDefine.Enum(TppDefine.QUEST_DEFINE)
    --InfCore.PrintInspect(TppDefine.QUEST_RANK_TABLE)--DEBUG
    TppDefine.QUEST_RANK_TABLE[TppDefine.QUEST_INDEX[questName]]=questInfo.questRank
    --InfCore.PrintInspect(TppDefine.QUEST_RANK_TABLE)--DEBUG

    if questInfo.questPackList.randomFaceList then
      table.insert(TppDefine.QUEST_RANDOM_FACE_DEFINE,questName)
      TppDefine.QUEST_RANDOM_FACE_INDEX=TppDefine.Enum(TppDefine.QUEST_RANDOM_FACE_DEFINE)
      --InfCore.PrintInspect(TppDefine.QUEST_RANDOM_FACE_INDEX)
    end
    --tex WORKAROUND, cant do in TppQuest.RegisterQuestPackList since it's already using random inside its loop
    local randomFaceListIH=questInfo.questPackList.randomFaceListIH
    if randomFaceListIH then
      questInfo.questPackList.faceIdList=InfCore.PCallDebug(InfEneFova.GetRandomFaces,randomFaceListIH.gender,randomFaceListIH.count)
    end
    this.AddToQuestInfoTable(questInfoTable,TppQuest.QUESTTABLE_INDEX,questName,questInfo)
    openQuestCheckTable[questName]=questInfo.canOpenQuest or this.AllwaysOpenQuest
    TppQuest.questCompleteLangIds[questName]=questInfo.questCompleteLangId

    this.AddToQuestList(TppQuestList.questList,TppQuestList.questAreaTable,questName,questInfo)
    TppQuestList.questPackList[questName]=questInfo.questPackList
  end

  InfMain.RandomResetToOsTime()

  this.questsRegistered=true

  InfCore.Log("numUiQuests:"..#questInfoTable)

  if this.debugModule then
    InfCore.PrintInspect(TppDefine.QUEST_INDEX,{varName="QUEST_INDEX"})
    InfCore.PrintInspect(TppDefine.QUEST_RANK_TABLE,{varName="QUEST_RANK_TABLE"})
    InfCore.PrintInspect(TppQuestList.questAreaTable,{varName="questAreaTable"})
    InfCore.PrintInspect(TppQuestList.questList,{varName="questList"})
    InfCore.PrintInspect(openQuestCheckTable,{varName="openQuestCheckTable"})
    InfCore.PrintInspect(TppQuestList.questPackList,{varName="questPackList"})
  end
end

--DEBUG
function this.DEBUG_PrintQuestClearedFlags()
  for i=0,TppDefine.QUEST_MAX-1 do
    InfCore.Log("qst_questClearedFlag["..i.."]="..tostring(gvars.qst_questClearedFlag[i]))
  end
end

--DEBUGNOW TEST add example quest and rocks quest test one at a time and remove (in different order)
--CALLER: TppVarInit.StartTitle - since registerquests is  run before the first game save/gvar load
function this.SetupInstalledQuestsState()
  InfCore.LogFlow"InfQuest.SetupInstalledQuestsState"
  --  InfCore.Log"pre"
  --this.DEBUG_PrintQuestClearedFlags()

  this.installedQuests=this.ReadInstalledQuests()
  if this.debugModule then
  InfCore.Log("ReadInstalledQuests:")
  InfCore.PrintInspect(this.installedQuests,{varName="InfQuest.installedQuests"})
  end

  --tex back up existing flag states
  local gvarFlags=this.GetGvarFlags()
  if this.debugModule then
    --InfCore.PrintInspect(gvarFlags)
  end

  for i,questName in ipairs(this.ihQuestNames)do
    local questIndex=TppDefine.QUEST_INDEX[questName]
    if questIndex==nil then
      InfCore.Log("InfQuest.SetupInstalledQuestsStates: Error: questIndex==nil for "..questName)
    else

      if not this.installedQuests[questName] then
        InfCore.Log(questName.." was not previously installed, clearing")
        for i,gvarName in ipairs(gvarFlagNames)do
          gvars[gvarName][questIndex]=false
        end
      else
        local previousIndex=this.installedQuests[questName]
        --InfCore.Log("previousIndex:"..previousIndex)

        if previousIndex~=questIndex then
          InfCore.Log(questName.." shifting from previous index of "..previousIndex)
        end

        for i,gvarName in ipairs(gvarFlagNames)do
          local previousValue=gvarFlags[previousIndex][gvarName]
          gvars[gvarName][questIndex]=previousValue
        end
      end

      this.installedQuests[questName]=questIndex
      --tex will be saved on next ih_save
    end
  end

  --  InfCore.Log"post"
  --this.DEBUG_PrintQuestClearedFlags()
end

--tex called from equivalent TppQuest funcs
--QuestBlockOnAllocate only called in added ih quests, not vanilla quests, the rest of the functions called by vannila quest scripts
function this.QuestBlockOnAllocate(questScript)--tex 

end
--tex called during questScript .OnAllocate
function this.RegisterQuestSystemCallbacks(callbackFunctions)

end
function this.QuestBlockOnInitialize(questScript)

end
function this.QuestBlockOnUpdate(questScript)

end
function this.QuestBlockOnTerminate(questScript)

end
--

--tex GetSideOpsListTable is called by engine for sideops ui
function this.PrintSideOpsListTable()
  local sideOpsTable=TppQuest.GetSideOpsListTable()
  InfCore.PrintInspect(sideOpsTable,{varName="sideOpsTable"})
end

function this.PrintQuestArea()
  if vars.missionCode==30050 then
    local clusterId=MotherBaseStage.GetCurrentCluster()
    local clusterName=TppDefine.CLUSTER_NAME[clusterId+1]
    InfCore.Log("Quest Area: Mtbs"..clusterName)
    return
  end

  local areaTypes={
    loadArea=false,
    invokeArea=false,
    activeArea=false,
  }

  local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()

  local numAreas=#mvars.qst_questList
  for i=1,numAreas do
    local areasQuestInfo=mvars.qst_questList[i]--TppQuestList .questList

    for areaType,inArea in pairs(areaTypes)do
      areaTypes[areaType]=TppQuest.IsInsideArea(areaType,areasQuestInfo,blockIndexX,blockIndexY)
    end

    local inAnyArea=false
    for areaType,inArea in pairs(areaTypes)do
      if areaTypes[areaType]==true then
        inAnyArea=true
        break
      end
    end

    if inAnyArea then
      local areaInfoMessage="Quest area: "..areasQuestInfo.areaName..", in:"
      for areaType,inArea in pairs(areaTypes)do
        areaInfoMessage=areaInfoMessage.." "..areaType.."="..tostring(inArea)
      end

      InfCore.Log(areaInfoMessage,false,true)
    end
  end
end

function this.GetQuestPositions()
  local positions={}
  local questTable=TppQuest.GetQuestInfoTable()
  for sideopNum,sideOpInfo in ipairs(questTable)do
    if sideOpInfo.locationId==vars.locationCode then
      local iconPos=sideOpInfo.iconPos
      if iconPos then
        local pos={iconPos:GetX(),iconPos:GetY(),iconPos:GetZ()}
        table.insert(positions,pos)
      end
    end
  end
  return positions
end

function this.ResetQuestState(gvarIndex,value)
  --VALIDATE gvarIndex>0 <TppDefine.QUEST_MAX
  local value=value or false
  gvars.qst_questOpenFlag[gvarIndex]=value
  gvars.qst_questClearedFlag[gvarIndex]=value
  gvars.qst_questActiveFlag[gvarIndex]=value
end

local typeString="string"
local typeNumber="number"
local typeFunction="function"
local typeTable="table"
function this.ReadInstalledQuests()
  InfCore.LogFlow"InfQuest.ReadInstalledQuests"

  local ih_save=IvarProc.LoadSave()
  if ih_save==nil then
    local errorText="ReadInstalledQuests Error: ih_save==nil"
    InfCore.Log(errorText,true,true)
    return
  end

  if ih_save.installedQuests==nil then
    InfCore.Log"ReadInstalledQuests: ih_save.installedQuests==nil"
    return {}
  end

  if type(ih_save.installedQuests)~=typeTable then
    local errorText="ReadInstalledQuests Error: ih_save.evars~=typeTable"
    InfCore.Log(errorText,true,true)
    return
  end

  local installedQuests={}
  for name,gvarIndex in pairs(ih_save.installedQuests) do
    if type(name)~=typeString then
      InfCore.Log("ReadInstalledQuests ih_save: name~=string:"..tostring(name),false,true)
    else
      if type(gvarIndex)~=typeNumber then
        InfCore.Log("ReadInstalledQuests ih_save: value~=number: "..name.."="..tostring(gvarIndex),false,true)
      elseif gvarIndex<0 or gvarIndex>TppDefine.QUEST_MAX-1 then
        InfCore.Log("ReadInstalledQuests ih_save: gvarIndex out of bounds: "..name.."="..tostring(gvarIndex),false,true)
      else
        --tex will clear removed entries
        if this.ihQuestsInfo[name]==nil then
          InfCore.Log("ReadInstalledQuests ih_save: "..name.." not found in ihQuestsInfo")
        else
          installedQuests[name]=gvarIndex
        end
      end
    end
  end
  return installedQuests
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

  local positionBag=InfUtil.ShuffleBag:New()
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
