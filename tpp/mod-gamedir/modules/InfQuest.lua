-- InfQuest.lua
-- tex implements various sideops/quest selection options
-- and IH quest addon system
local this={}

local TppDefine=TppDefine
local InfCore=InfCore

this.debugModule=false

--tex the engine breaks down the quest name in some cases to the last 6 characters (ie q30010), or just the numbers
--see TppQuest GetQuestNameId, GetQuestName
--it uses the q name as the lookup for the lang string name_<qname> and info_<qname>
--I'm not sure if anything before that has any signifincance, many have quest_ as the prefix, others have the quest area name.
--Because of this restriction any mod authors that want to build a sideop will have to notify me so to not collide with others
--questNameFmt="q3%04d"--tex currently straddling between 30010 : Little Lost Sheep and 39010 : Legendary Brown Bear
--tex current questIds claimed
--q30100 - q30102--IH mb quests
--q30103--IH quest example
--q30104 - q30154--morbidslinky sideops pack
--q30155--IH pilot rescue test
--q30156-q30199--darkhaven
--q30200-q30299--ih reserved
--q30300-q30349--caplag
--q30350-q30360--morbidslinky example sideops
--q30500-q30504--hsronacse (via nexus posts page)
--q31069-q31099--jackwall (via nexus message)

--GOTCHA: also currently limited by TppDefine.QUEST_MAX=250, with 167 vanilla quests.
--this is governing the qst_* gvars that hold the quest states (see TppGvars).

this.questsRegistered=false

--tex see LoadQuestDefs,
this.ihQuestNames={}
--tex see LoadQuestDefs, RegisterQuests
--k=questName,v=questDef module
this.ihQuestsInfo={}

function this.PostModuleReload(prevModule)
  this.questsRegistered=prevModule.questsRegistered
  this.ihQuestNames=prevModule.ihQuestNames
  this.ihQuestsInfo=prevModule.ihQuestsInfo
end

function this.PostAllModulesLoad()
  this.LoadQuestDefs()
  if this.questsRegistered then
    this.RegisterQuests()
  end
end

function this.OnTitleStart()
  this.SetupInstalledQuestsState()
end

function this.OnAllocate(missionTable)
  if missionTable.enemy then
  --CULL this.LoadEquipTable()
  end
end

--tex see InfEquip.LoadEquipTable for notes
--CULL, now in InfEquip.LoadEquipTable
--function this.LoadEquipTable()
--  if not TppMission.IsFreeMission(vars.missionCode) and not TppMission.IsStoryMission(vars.missionCode) then
--    return
--  end
--
--  local equipLoadTable={}
--
--  for questName,questInfo in pairs(this.ihQuestsInfo)do
--    if TppQuest.IsActive(questName) then
--      if questInfo.requestEquipIds then
--        InfCore.Log("InfQuest.LoadEquipTable IsActive:"..questName)
--        for n,equipName in ipairs(questInfo.requestEquipIds)do
--          local equipId=TppEquip[equipName]
--          if equipId==nil then
--            InfCore.Log("ERROR InfQuest.LoadEquipTable: requestEquipIds "..questName.."  could not find equipId "..tostring(equipId))
--          else
--            equipLoadTable[#equipLoadTable+1]=equipId
--          end
--        end
--      end
--    end
--  end
--
--  if #equipLoadTable>0 and TppEquip.RequestLoadToEquipMissionBlock then
--    TppEquip.RequestLoadToEquipMissionBlock(equipLoadTable)
--  end
--end

function this.CanOpenClusterGrade0(questName)
  local questInfo=this.ihQuestsInfo[questName]
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE[questInfo.clusterName]+1)>0
end
function this.AllwaysOpenQuest()
  return true
end

--REF questDef
-- ih_quest_q30103.lua --file name must have q%05u format as suffix.
--local this={
--  questPackList={
--    "/Assets/tpp/pack/mission2/ih/ih_hostage_base.fpk",--base hostage pack
--    "/Assets/tpp/pack/mission2/ih/ddr1_main0_mdl.fpk",--model pack, edit the partsType in the TppHostage2Parameter in the quest .fox2 to match, see InfBodyInfo.lua for different body types.
--    "/Assets/tpp/pack/mission2/quest/ih/ih_example_quest.fpk",--quest fpk
--    randomFaceListIH={--for hostage isFaceRandom, see TppQuestList
--      gender="FEMALE",
--      count=1,
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
--  disableLzs={--disables lzs while the quest is active. Turn on the debugMessages option and look in ih_log.txt for StartedMoveToLandingZone after calling in a support heli to find the lz name.
--    "lz_lab_S0000|lz_lab_S_0000",
--  },
--  requestEquipIds={--equipIds of TppPickable weapons in the quest.
--    "EQP_WP_EX_hg_010",
--    "EQP_WP_West_ar_050",
--  },
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
--tex NOTE: questCompleteLangId is a misnomer, it's actually an announceLogId for the TppUI.ANNOUNCE_LOG_TYPE announceLogId>langId table.
--if the announceLogId isn't found IH essentially use your questCompleteLangId as a direct langId


local blockQuests={
  tent_q99040=true, -- 144 - recover volgin, player is left stuck in geometry at end of quanranteed plat demo
  sovietBase_q99020=true,-- 82, make contact with emmeric
}

--block quests>
function this.BlockQuest(questName)
  --tex TODO: doesn't work for the quest area you start in (need to clear before in actual mission)
  if InfMainTpp.IsMbEvent() then
    --InfCore.Log("BlockQuest on event "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
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
  if InfMainTpp.IsMbEvent() then
    --InfCore.Log("GetForced on event "..tostring(vars.missionCode))--DEBUG
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

local gvarFlagNames={
  "qst_questOpenFlag",
  "qst_questRepopFlag",
  "qst_questClearedFlag",
  "qst_questActiveFlag",
}
local gvarFlagTypes=Tpp.Enum(gvarFlagNames)

--CULL
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

--tex loads the quest definitions/scripts from MGS_TPP\mod\quests
--the name of the script file will be used for questName throughout the tables
--name of file can be anything, provided it has a qname suffix (see notes at start of this file).
--SIDE: this.ihQuestNames,this.ihQuestsInfo
function this.LoadQuestDefs()
  InfCore.LogFlow("InfQuest.LoadQuestDefs")
  local ihQuestNames={}
  local ihQuestsInfo={}
  local questIdToQuestName={}
  local questIds={}

  local questFiles=InfCore.GetFileList(InfCore.files.quests,".lua")
  for i,fileName in ipairs(questFiles)do
    InfCore.Log("InfQuest.LoadQuestDefs: "..fileName)

    local questName=InfUtil.StripExt(fileName)
    local module=InfCore.LoadSimpleModule(InfCore.paths.quests,fileName)
    if module.questPackList then--tex TYPE
      ihQuestsInfo[questName]=module
      ihQuestNames[#ihQuestNames+1]=questName
    end
  end

  --TODO validate questDef
  --TODO collision quest nubmer with existing quests

  --tex bit of futzing to put ihQuestNames in questId order
  for i,questName in ipairs(ihQuestNames) do
    local questNumber=this.GetQuestNumber(questName)
    if not questNumber then
      InfCore.Log("InfQuest.LoadQuestDefs: Could not find questNumber on "..questName)
    else
      if questIdToQuestName[questNumber] then
        InfCore.Log("InfQuest.LoadQuestDefs: WARNING: questNumber "..questNumber.." collision with "..questIdToQuestName[questNumber].." and "..questName)
      end
      questIdToQuestName[questNumber]=questName
    end
  end

  for questId,questName in pairs(questIdToQuestName)do
    questIds[#questIds+1]=questId
  end
  table.sort(questIds)

  ihQuestNames={}--tex clear, finally putting in order
  for i,questId in ipairs(questIds)do
    ihQuestNames[#ihQuestNames+1]=questIdToQuestName[questId]
  end
  --

  if this.debugModule then
    InfCore.PrintInspect(questFiles,"questFiles")
    InfCore.PrintInspect(questIds,"questIds")

    InfCore.PrintInspect(ihQuestNames,"LoadQuestDefs ihQuestNames")
    InfCore.PrintInspect(ihQuestsInfo,"LoadQuestDefs ihQuestsInfo")
  end

  this.ihQuestNames=ihQuestNames
  this.ihQuestsInfo=ihQuestsInfo
end

--REF
--TppQuestList.questList={
--  {locationId=TppDefine.LOCATION_ID.MTBS,areaName="MtbsCombat",clusterName="Combat",
--    infoList={
--    {name="mtbs_q42070",invokeStepName="QStep_Start"},
--    {name="quest_q30100",invokeStepName="QStep_Start"},
--TppQuestList.questAreaTable
--tex just grinding through arrays since too many lookup tables are a pain to manage and this is a once-on-load, or on user command function.
function this.AddToQuestList(questList,questAreaTable,questName,questInfo)
  for i,areaQuests in ipairs(questList)do
    if areaQuests.locationId==questInfo.locationId
      and areaQuests.areaName==questInfo.areaName then

      local infoList=areaQuests.infoList

      --tex find existing index
      local infoListIndex
      for i,areaQuest in ipairs(infoList)do
        if areaQuest.name==questName then
          infoListIndex=i
          break
        end
      end
      --tex get new index
      if not infoListIndex then
        infoListIndex=#infoList+1
      end

      questAreaTable[questName]=questInfo.areaName
      infoList[infoListIndex]={name=questName,invokeStepName="QStep_Start"}

      break
    end
  end
end

--REF TppQuest.questInfoTable={
--  --[[XXX]]{questName="quest_q30100",questId="quest_q30100",locationId=TppDefine.LOCATION_ID.MTBS,clusterId=TppDefine.CLUSTER_DEFINE.Combat,plntId=TppDefine.PLNT_DEFINE.Special,category=this.QUEST_CATEGORIES_ENUM.CAPTURE_ANIMAL},--tex
--  --[[XXX]]{questName="fort_q71080",questId="quest_q71080",locationId=TppDefine.LOCATION_ID.AFGH,iconPos=Vector3(2080.718,456.726,-1927.582),radius=5,category=this.QUEST_CATEGORIES_ENUM.ELIMINATE_PUPPETS},
--IN/OUT: questInfoTable,questTableIndexes
function this.AddToQuestInfoTable(questInfoTable,questInfoIndexes,questName,questInfo)
  local addQuestInfo={
    questName=questName,
    questId=questName,
    locationId=questInfo.locationId,
    clusterId=TppDefine.CLUSTER_DEFINE[questInfo.clusterName],
    plntId=questInfo.plntId,
    iconPos=questInfo.iconPos,
    radius=questInfo.radius,
    category=questInfo.category,
  }

  --tex get existing index (if user manually reloading scripts in-game), or add new (on first call/startup).
  local questInfoIndex=questInfoIndexes[questName] or #questInfoTable+1
  questInfoIndexes[questName]=questInfoIndex
  questInfoTable[questInfoIndex]=addQuestInfo
end

--CALLER: InfMain OnInitialize, before TppQuest.RegisterQuestList
--tex basically just pulls together a lot of scattered data for easier setup of new quests
function this.RegisterQuests()
  InfCore.LogFlow("InfQuest.RegisterQuests")

  local questInfoTable=TppQuest.GetQuestInfoTable()

  if this.debugModule then
    InfCore.Log("numVanillaUiQuests:"..TppQuest.NUM_VANILLA_UI_QUESTS.." #questInfoTable:"..#questInfoTable)
  end

  local TppQuest=TppQuest
  local TppQuestList=TppQuestList
  local QUEST_DEFINE=TppDefine.QUEST_DEFINE

  local questInfoTable=TppQuest.GetQuestInfoTable()
  local openQuestCheckTable=TppQuest.GetCanOpenQuestTable()

  InfMain.RandomSetToLevelSeed()

  for i,questName in ipairs(this.ihQuestNames)do
    local questInfo=this.ihQuestsInfo[questName]

    --tex find existing or new
    local questIndex
    for i,_questName in ipairs(QUEST_DEFINE)do
      if _questName==questName then
        questIndex=i
        break
      end
    end
    if not questIndex then
      questIndex=#QUEST_DEFINE+1
    end

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
    --tex -^- this goes through TppQuest.ShowAnnounceLog > TppUI.ShowAnnounceLog so hits the imho silly TppUI.ANNOUNCE_LOG_TYPE indirect
    --so I'll just patch it in if it doesnt exist
    if not TppUI.ANNOUNCE_LOG_TYPE[questInfo.questCompleteLangId] then
      TppUI.ANNOUNCE_LOG_TYPE[questInfo.questCompleteLangId]=questInfo.questCompleteLangId
    end

    this.AddToQuestList(TppQuestList.questList,TppQuestList.questAreaTable,questName,questInfo)
    TppQuestList.questPackList[questName]=questInfo.questPackList

    if questInfo.hasEnemyHeli then
      if not InfUtil.FindInList(TppDefine.QUEST_HELI_DEFINE,questName) then
        table.insert(TppDefine.QUEST_HELI_DEFINE,questName)
      end
    end
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

--CALLER: TppVarInit.StartTitle - since registerquests is run before the first game save/gvar load
function this.SetupInstalledQuestsState()
  InfCore.LogFlow"InfQuest.SetupInstalledQuestsState"
  --  InfCore.Log"pre"
  --this.DEBUG_PrintQuestClearedFlags()      f
  --tex clear quest gvars as matter of course
  for i,questName in ipairs(this.ihQuestNames)do
    local questIndex=TppDefine.QUEST_INDEX[questName]
    for i,gvarName in ipairs(gvarFlagNames)do
      gvars[gvarName][questIndex]=false
    end
  end

  --tex restore any saved quest gvars from ih_save state
  this.questStates=this.ReadQuestStates()

  --  InfCore.Log"post"
  --this.DEBUG_PrintQuestClearedFlags()
end

function this.GetQuestNumber(questName)
  return tonumber(string.sub(questName,-5))
end

--tex called from equivalent TppQuest funcs
--QuestBlockOnAllocate only called in added ih quests, not vanilla quests, the rest of the functions called by vannila quest scripts
function this.QuestBlockOnAllocate(questScript)--tex
  local questName=TppQuest.GetCurrentQuestName()

  if DebugIHQuest then
    InfCore.PCall(DebugIHQuest.QuestBlockOnUpdate,questScript)
  end
end
--tex called during questScript .OnAllocate
function this.RegisterQuestSystemCallbacks(callbackFunctions)
  if DebugIHQuest then
    InfCore.PCall(DebugIHQuest.RegisterQuestSystemCallbacks,callbackFunctions)
  end
end
function this.QuestBlockOnInitialize(questScript)
  if DebugIHQuest then
    InfCore.PCall(DebugIHQuest.QuestBlockOnUpdate,questScript)
  end
end
function this.QuestBlockOnUpdate(questScript)
  if DebugIHQuest then
    InfCore.PCall(DebugIHQuest.QuestBlockOnUpdate,questScript)
  end
end
function this.QuestBlockOnTerminate(questScript)
  if DebugIHQuest then
    InfCore.PCall(DebugIHQuest.QuestBlockOnUpdate,questScript)
  end
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
    if clusterId==nil then
      InfCore.Log("InfQuest.PrintQuestArea: WARNING: GetCurrentCluster==nil")
    else
      local clusterName=TppDefine.CLUSTER_NAME[clusterId+1]
      --tex not using InfMain.CLUSTER_NAME because there's currently no quest area for separation,zoo
      --GOTCHA doesn't take into account MtbsPaz area, but im not sure how it decides that area
      if clusterName==nil then
        InfCore.Log("InfQuest.PrintQuestArea: WARNING: clusterName==nil")
      else
        InfCore.Log("Quest Area: Mtbs"..clusterName)
      end
    end
    return
  end

  local blockIndexX,blockIndexY=Tpp.GetCurrentStageSmallBlockIndex()
  local blockIndexMessage="blockIndexX:"..blockIndexX..",blockIndexY:"..blockIndexY
  InfCore.Log(blockIndexMessage,false,true)

  local areaTypes={
    loadArea=false,
    invokeArea=false,
    activeArea=false,
  }

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

--tex set questCleared gvars from ih_save state
--IN/SIDE: ih_save
function this.ReadQuestStates()
  InfCore.LogFlow"InfQuest.ReadQuestStates"

  if ih_save==nil then
    local errorText="ReadQuestStates Error: ih_save==nil"
    InfCore.Log(errorText,true,true)
    return
  end

  if ih_save.questStates==nil then
    InfCore.Log"ReadQuestStates: ih_save.questStates==nil"
    return {}
  end

  if type(ih_save.questStates)~="table" then
    local errorText="ReadQuestStates Error: ih_save.questStates~=typeTable"
    InfCore.Log(errorText,true,true)
    return
  end

  for questName,questState in pairs(ih_save.questStates) do
    if type(questName)~="string" then
      InfCore.Log("ReadQuestStates ih_save: name~=string:"..tostring(questName),false,true)
    else
      if type(questState)~="number" then
        InfCore.Log("ReadQuestStates ih_save: value~=number: "..questName.."="..tostring(questState),false,true)
      else
        local questIndex=TppDefine.QUEST_INDEX[questName]
        if not questIndex then
          InfCore.Log("InfQuest.ReadQuestStates: Could not find questIndex for "..questName)
        else
          for i=1,#gvarFlagNames do
            local value=bit.band(questState,i^2)==i^2
            gvars[gvarFlagNames[i]][questIndex]=value
          end
        end
      end
    end
  end

  return ih_save.questStates
end

local questClearStates={}--tex cache of last to compare against for isdirty
function this.GetCurrentStates()
  local QUEST_INDEX=TppDefine.QUEST_INDEX
  local gvars=gvars
  local bor=bit.bor

  local isSaveDirty=false

  for i,questName in ipairs(this.ihQuestNames)do
    local questIndex=QUEST_INDEX[questName]
    if not questIndex then
      InfCore.Log("ERROR: InfQuest.GetQuestStates: Could not find questIndex for "..questName,false,true)
    else
      local bitState=0

      for i=1,#gvarFlagNames do
        local gvarValue=gvars[gvarFlagNames[i]][questIndex]
        if gvarValue==true then
          bitState=bor(bitState,i^2)
        end
      end

      local currentClearState=questClearStates[questName]
      if currentClearState==nil or currentClearState~=bitState  then
        isSaveDirty=true
      end

      questClearStates[questName]=bitState
    end
  end

  --tex WORKAROUND (not quite the place for it, should have it's own func then anoteher uniting the two tables
  --transfer over existing states in ih_save
  --this will cover any runs of ih without the addon quests installed
  --downside is old data will still persist if developer changes questName
  local ih_save=ih_save
  if ih_save and ih_save.questStates then
    for questName,bitState in ipairs(ih_save.questStates)do
      if not questClearStates[questName] then
        questClearStates[questName]=bitState
        isSaveDirty=true
      end
    end
  end

 if isSaveDirty then--DEBUGNOW  
    return questClearStates
 end

return nil
end

--CALLER: TppLandingZone.OnMissionCanStart
function this.DisableLandingZones()
  InfCore.LogFlow("InfQuest.DisableLandingZones:")
  local function FindMatchLZ(lz)
    for location,lzs in pairs(TppLandingZone.assaultLzs)do
      for drpRoute,aprRoute in pairs(lzs) do
        if aprRoute==lz then
          return drpRoute
        end
      end
    end
    for location,lzs in pairs(TppLandingZone.missionLzs)do
      for aprRoute,drpRoute in pairs(lzs) do
        if drpRoute==lz then
          return aprRoute
        end
      end
    end
    return lz
  end

  for questName,questInfo in pairs(this.ihQuestsInfo)do
    if TppQuest.IsActive(questName) then
      if questInfo.disableLzs then
        InfCore.Log("DisableLandingZones IsActive:"..questName)
        for i,lz in ipairs(questInfo.disableLzs) do
          local otherRoute=FindMatchLZ(lz)
          InfCore.Log("otherRoute "..tostring(otherRoute))
          TppUiCommand.AddDisabledLandPoint(otherRoute)
          TppLandingZone.GroundDisableLandingZone(lz)
        end
      end
    end
  end
end

function this.UpdateActiveQuest()
  for i=0,TppDefine.QUEST_MAX-1 do
    gvars.qst_questRepopFlag[i]=false
  end

  for i,areaQuests in ipairs(TppQuestList.questList)do
    TppQuest.UpdateRepopFlagImpl(areaQuests)
  end
  TppQuest.UpdateActiveQuest()

  TppLandingZone.OnMissionCanStart()--tex redo disable lzs
end

--tex called from quest script to have the external quest defintion script as the quest script
function this.GetScript(scriptName)
  InfCore.Log("InfQuest.GetScript: "..tostring(scriptName))
  local questScript=this.ihQuestsInfo[scriptName]
  if not questScript then
    InfCore.Log("ERROR: InfQuest.GetScript: could not find quest script "..tostring(scriptName),false,true)
    return {}
  else
    return questScript
  end
end

--Commands
this.ForceAllQuestOpenFlagFalse=function()
  for n,questIndex in ipairs(TppDefine.QUEST_INDEX)do
    gvars.qst_questOpenFlag[questIndex]=false
    gvars.qst_questActiveFlag[questIndex]=false
  end
  TppQuest.UpdateActiveQuest()
  InfMenu.PrintLangId"done"
end

this.RerollQuestSelection=function()
  InfMain.RegenSeed(vars.missionCode,vars.missionCode)

  InfQuest.UpdateActiveQuest()
end

return this
