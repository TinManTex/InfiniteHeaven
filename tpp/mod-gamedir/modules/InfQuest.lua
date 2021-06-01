-- InfQuest.lua
-- tex implements various sideops/quest selection options
-- and IH quest addon system
local this={}

local TppDefine=TppDefine

local InfCore=InfCore
local IvarProc=IvarProc
local pairs=pairs
local ipairs=ipairs
local floor=math.floor
local format=string.format

this.debugModule=true--DEBUGNOW
this.debugSave=true--DEBUGNOW

--tex the engine breaks down the quest name in some cases to the last 6 characters (ie q30010), or just the numbers
--see TppQuest GetQuestNameId, GetQuestName
--it uses the q name as the lookup for the lang string name_<qname> and info_<qname>
--I'm not sure if anything before that has any signifincance, many have quest_ as the prefix, others have the quest area name.
--Because of this restriction any mod authors that want to build a sideop will have to notify me so to not collide with others
--questNameFmt="q3%04d"--tex currently straddling between 30010 : Little Lost Sheep and 39010 : Legendary Brown Bear
--tex current questIds claimed
--q30100 - q30102--IH mb quests
--q30103--IH quest example
--q30104-q30154--morbidslinky sideops pack
--q30155--IH pilot rescue test
--q30156-q30199--darkhaven
--q30200-q30299--ih reserved
--q30300-q30349--caplag
--q30350-q30360--morbidslinky example sideops
--q30400-q30499--MgSolidus (via nexus message)
--q30500-q30504--hsronacse (via nexus posts page)
--q30600-q30699--amars464 (via discord) (currently made 12)
--q31069-q31099--jackwall (via nexus message)
--q31100-q31199--Adam_Online (discord) - Tales from Mother Base sidop collection on nexus.
--q36660-q36760--ventos

--GOTCHA: also currently limited by TppDefine.QUEST_MAX=250, with 157 vanilla quests.
--this is governing the qst_* gvars that hold the quest states (see TppGvars).

--tex see LoadQuestDefs,
this.ihQuestNames={}
--tex see LoadQuestDefs, RegisterQuests
--k=questName,v=questDef module
this.ihQuestsInfo={}

function this.PostModuleReload(prevModule)
  this.ihQuestNames=prevModule.ihQuestNames
  this.ihQuestsInfo=prevModule.ihQuestsInfo
  this.messageExecTable=prevModule.messageExecTable
  --DEBUGNOW this.LoadLibraries()--TODO: see that stuff in RegisterQuests isnt additive/go pear shaped with multiple calls
end

function this.LoadLibraries()
  this.LoadStates()
  this.LoadQuestDefs()
  this.RegisterQuests()
end

function this.OnStartTitle()
  --tex since registerquests is run before the first game save/gvar load
  this.SetupInstalledQuestsState()
end

function this.OnAllocate(missionTable)
  if missionTable.enemy then
  --CULL this.LoadEquipTable()
  end
end

function this.AddMissionPacks(missionCode,packPaths)
  if missionCode < 5 then
    return
  end

  for questName,questInfo in pairs(this.ihQuestsInfo)do
    if TppQuest.IsActive(questName) then
      if questInfo.missionPackList and questInfo.missionPackList[missionCode]then
        local packs=questInfo.missionPackList[missionCode]
        if missionCode==30050 then --DEBUGNOW
          packs=packs[vars.mbLayoutCode] or packs[0]
        end
        for i,packPath in ipairs(packs)do
          packPaths[#packPaths+1]=packPath
        end
      end--if questInfo.missionPackList
    end--if IsActive
  end--for ihQuestsInfo
end--AddMissionPacks

function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload(missionTable)
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end

function this.Messages()
  local shootingPracticeTrapNames={
    --tex vanilla traps
    "ly003_cl00_npc0000|cl00pl0_uq_0000_npc2|trap_shootingPractice_start",--Command
    "ly003_cl01_npc0000|cl01pl0_uq_0010_npc2|trap_shootingPractice_start",--Combat
    "ly003_cl02_npc0000|cl02pl0_uq_0020_npc2|trap_shootingPractice_start",--Develop
    "ly003_cl03_npc0000|cl03pl0_uq_0030_npc2|trap_shootingPractice_start",--Support
    "ly003_cl04_npc0000|cl04pl0_uq_0040_npc2|trap_shootingPractice_start",--Medical
    "ly003_cl05_npc0000|cl05pl0_uq_0050_npc2|trap_shootingPractice_start",--Spy
    "ly003_cl06_npc0000|cl06pl0_uq_0060_npc2|trap_shootingPractice_start",--BaseDev
  }
  for questName,questInfo in pairs(this.ihQuestsInfo)do
    if questInfo.startTrapName then
      table.insert(shootingPracticeTrapNames,questInfo.startTrapName)
    end
  end
  
  return Tpp.StrCode32Table{
    Player={
      {
        --tex sent by ActionIcon of start trap
        --Overriding the quest scripts message callback via this.QuestBlockOnInitializeBottom
        msg="QuestStarted",
        sender="ShootingPractice",
        func=function(questNameHash)
          InfCore.Log("InfQuest msg QuestStarted")
          if mvars.qst_isShootingPracticeStarted then
            InfCore.Log("ShootingPractice manual cancel")
            local isClearType=TppGimmick.CheckQuestAllTarget(TppDefine.QUEST_TYPE.SHOOTING_PRACTIVE,nil,true)
            TppQuest.ClearWithSave(isClearType)--tex will have to think this through (and all calls to ClearWithSave) if you chand ClearWithSave to actually save (it currently doesnt for shooting practice)
          else
            InfCore.Log("InfQuest QuestStarted")
            --TppPlayer.QuestStarted(questNameHash)--tex hides action icon and stops sfx when entering start trap  
            TppQuest.SetQuestShootingPractice()
            
            if MotherBaseStage.GetCurrentCluster()==4 then--Medical
              f30050_sequence.StopMusicFromQuietRoom()
              mvars.isShootingPracticeInMedicalStopMusicFromQuietRoom = true
            end
          
            --KLUDGE, don't know why these aren't just a single var anyway
            mvars.needToUpdateRankingInCommand = false
            mvars.needToUpdateRankingInCombat = false
            mvars.needToUpdateRankingInDevelop = false
            mvars.needToUpdateRankingInSupport = false
            mvars.needToUpdateRankingInMedical = false
            mvars.needToUpdateRankingInSpy = false
            mvars.needToUpdateRankingInBaseDev = false
          end
        end--func
      }--msg QuestStarted
    },--Player
    Trap = {
      {
        msg="Enter",sender=shootingPracticeTrapNames,
        func=function(trap,player)
          if mvars.qst_isShootingPracticeStarted then
            --InfCore.Log( "Shooting Quest Trap Enter: ShootingPractice is Deactivated. Return" )
            return
          end
          local questName=TppQuest.GetCurrentQuestName()
          this.PrintShootingPracticeBestTime(questName)
        end
      },--msg Enter
      {
        msg="Exit",sender=shootingPracticeTrapNames,
        func=function(trap,player)
          if mvars.qst_isShootingPracticeStarted then
            --InfCore.Log( "Shooting Quest Trap Exit: ShootingPractice is Deactivated. Return" )
            return
          end
          local questName=TppQuest.GetCurrentQuestName()
        end
      },--msg Exit
    },--Trap  
  }--StrCode32Table
end--Messages
function this.OnMessage(sender,messageId,arg0,arg1,arg2,arg3,strLogText)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,sender,messageId,arg0,arg1,arg2,arg3,strLogText)
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
--tex some basic 'CanOpen' functions
function this.CanOpenClusterGrade0(questName)
  local questInfo=this.ihQuestsInfo[questName]
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE[questInfo.clusterName]+1)>0
end
--tex mother base mbLayout changes from 0-3 depending on the plnts built off command
--so if you don't want to mess around with having to work out positions for all the layouts you can just limit it to this
--(through the player will have to have developed mb to that point before
function this.CanOpenIsMbLayout3(questName)
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE.Command+1)>=4
end
function this.CanOpenPlntIsDeveloped(questName)
  local questInfo=this.ihQuestsInfo[questName]
  return TppLocation.GetLocalMbStageClusterGrade(TppDefine.CLUSTER_DEFINE[questInfo.clusterName]+1)>=(questInfo.plntId+1)
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
--  allowInWarGames=true,--by default quests are blocked on mb wargames, this is to allow the quest during wargames
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
    local questInfo=this.ihQuestsInfo[questName]
    if not questInfo or not questInfo.allowInWargames then
      return true
    end
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
  InfCore.LogFlow("InfQuest.GetForced")
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
  if unlockSideOpNumber>0 and unlockSideOpNumber<=#questTable then
    local unlockedName=questTable[unlockSideOpNumber].questName
    local unlockedArea=nil
    if unlockedName~=nil then
      unlockedArea=TppQuestList.questAreaNameTable[unlockedName]
      if unlockedArea==nil then
        InfCore.Log("ERROR: InfQuest.GetForced questAreaNameTable[] nil for "..unlockedName)
      else
        forcedQuests[unlockedArea]=unlockedName
        forcedCount=forcedCount+1
        InfCore.Log(string.format(printUnlockedFmt,unlockSideOpNumber,unlockedName,unlockedArea))
      end
    end--if unlockedName
  end--if unlockSideOpNumber <=#questTable

  if forcedCount==0 then
    return nil
  else
    if this.debugModule then
      InfCore.PrintInspect(forcedQuests,forcedQuests)
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

--tex clear range above vanilla quests
function this.ClearGvarFlagsAddonRange()
  for questGvarIndex=TppDefine.NUM_VANILLA_QUEST_DEFINES,TppDefine.QUEST_MAX-1 do
    for i,gvarName in ipairs(gvarFlagNames)do
      gvars[gvarName][questGvarIndex]=false
    end
  end
end--ClearGvarFlagsAddonRange

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
--TppQuestList.questAreaNameTable
--tex just grinding through arrays since too many lookup tables are a pain to manage and this is a once-on-load, or on user command function.
function this.AddToQuestList(questList,questAreaNameTable,questName,questInfo)
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

      questAreaNameTable[questName]=questInfo.areaName
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
  questInfoIndexes[questInfoIndex]=questName
  questInfoTable[questInfoIndex]=addQuestInfo
end

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

    this.AddToQuestList(TppQuestList.questList,TppQuestList.questAreaNameTable,questName,questInfo)
    TppQuestList.questPackList[questName]=questInfo.questPackList

    if questInfo.hasEnemyHeli then
      if not InfUtil.FindInList(TppDefine.QUEST_HELI_DEFINE,questName) then
        table.insert(TppDefine.QUEST_HELI_DEFINE,questName)
      end
    end
  end

  InfMain.RandomResetToOsTime()

  InfCore.Log("numUiQuests:"..#questInfoTable)

  if this.debugModule then
    InfCore.PrintInspect(TppDefine.QUEST_INDEX,"QUEST_INDEX")
    InfCore.PrintInspect(TppDefine.QUEST_RANK_TABLE,"QUEST_RANK_TABLE")
    InfCore.PrintInspect(TppQuestList.questAreaNameTable,"questAreaNameTable")
    InfCore.PrintInspect(TppQuestList.questList,"questList")
    InfCore.PrintInspect(openQuestCheckTable,"openQuestCheckTable")
    InfCore.PrintInspect(TppQuestList.questPackList,"questPackList")
  end
end--RegisterQuests

--REF
--  <locationInfo>.questAreas={
--    {
--      areaName="tent",
--      --xMin,yMin,xMax,yMax, in smallblock coords. see Tpp.CheckBlockArea. debug menu ShowPosition will log GetCurrentStageSmallBlockIndex, or you can use whatever block visualisation in unity you have
--      loadArea={116,134,131,152},--load is the larger area, so -1 minx, -1miny, +1maxx,+1maxy vs active
--      activeArea={117,135,130,151},
--      invokeArea={117,135,130,151},--same size as active, but keeping here to stay same implementation as vanilla
--    },
--    ...
--  },

--locationInfo questAreas to TppQuestList.questList
--CALLER: InfMission.AddInLocations
--GOTCHA: must be run before InfQuest.RegisterQuests,
--and it is because InfMission.LoadLibraries > AddInLocations > InfQuest.AddLocationQuestAreas . And InfQuest.PostAllModulesLoad > RegisterQuests
--but watch out if you split InfMission to InfLocation
--DEBUGNOW also see what happens RE: reloadmodules
--OUT/SIDE: TppQuestList.questList
function this.AddLocationQuestAreas(locationId,locationQuestAreas)
  if locationQuestAreas==nil then
    return
  end

  InfCore.Log("InfQuest.AddLocationQuestAreas locationId:"..locationId)

  --TODO: VALIDATE locationQuestAreas (or should that be done on load?)

  --TODO: if this is useful move somewhere (I might have some lookup tables to make this easier, but since we're adding they wont be accurate)
  --IN: TppQuestList.questList
  local function GetLocationQuestArea(locationId,areaName)
    local locationHasArea=false
    for i,questArea in ipairs(TppQuestList.questList)do
      if locationId==questArea.locationId then
        if areaName==questArea.areaName then
          return questArea
        end
      end
    end--for questList

    return nil
  end--GetLocationQuestArea

  for i,questArea in ipairs(locationQuestAreas)do
    local currentQuestArea=GetLocationQuestArea(locationId,questArea.areaName)

    if currentQuestArea then
      InfCore.Log("WARNING: InfQuest.AddLocationQuestAreas locationId already has questArea "..questArea.areaName)
    else
      local newQuestArea={
        locationId=locationId,--tex could probably add this on load then just copy table in
        areaName=questArea.areaName,
        loadArea=questArea.loadArea,
        activeArea=questArea.activeArea,
        invokeArea=questArea.invokeArea,
        clusterName=questArea.clusterName,
        infoList={
        },
      }
      table.insert(TppQuestList.questList,newQuestArea)
      if this.debugModule then
        InfCore.PrintInspect(newQuestArea,"newQuestArea")
      end
    end
  end--for locationQuestAreas
end--AddLocationQuestAreas

--DEBUG
function this.DEBUG_PrintQuestClearedFlags()
  for i=0,TppDefine.QUEST_MAX-1 do
    InfCore.Log("qst_questClearedFlag["..i.."]="..tostring(gvars.qst_questClearedFlag[i]))
  end
end

--CALLER: TppVarInit.StartTitle (>InfMain CallOnModules this.OnStartTitle) - since registerquests is run before the first game save/gvar load
function this.SetupInstalledQuestsState()
  InfCore.LogFlow"InfQuest.SetupInstalledQuestsState"
  if not this.questStatesLoaded then
    --tex clear quest gvars range as matter of course and rely on ih_save.questStates to restore them
    this.ClearGvarFlagsAddonRange()--DEBUGNOW TESTS
    --complete addon quest, quit and see if its still completed next session
    --then uninstall it, run game, reinstall it, run game, see if its cleared
    --
    this.questStatesLoaded=true
  end

  --this.DEBUG_PrintQuestClearedFlags()      f
  --tex clear quest gvars as matter of course
  --CULL
  --  for i,questName in ipairs(this.ihQuestNames)do
  --    local questIndex=TppDefine.QUEST_INDEX[questName]
  --    for i,gvarName in ipairs(gvarFlagNames)do
  --      gvars[gvarName][questIndex]=false
  --    end
  --  end

  --tex restore any saved quest gvars from ih_save state
  this.ReadSaveStates()

  --this.DEBUG_PrintQuestClearedFlags()
end

function this.GetQuestNumber(questName)
  return tonumber(string.sub(questName,-5))
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
function this.QuestBlockOnInitializeBottom(questScript)
  InfCore.LogFlow("InfQuest.QuestBlockOnInitializeBottom")--DEBUGNOW
   --DEBUGNOW REF
--mvars.qst_questScriptBlockMessageExecTable={
--  [738746875] = {
--    [669800987] = {
--      func = <function 1>
--    }
--  },
--  [2524903270] = {
--    [166925615] = {
--      sender = {
--        [814656445] = <function 2>
--      },
--      senderOption = {}
--    },
--    [246347329] = {
--      sender = {
--        [814656445] = <function 3>
--      },
--      senderOption = {}
--    }
--  },
--  [3087473413] = {
--    [845558693] = {
--      func = <function 4>
--    },
--    [3220759189] = {
--      sender = {
--        [2294579761] = <function 5>
--      },
--      senderOption = {}
--    },
--    [4187264311] = {
--      func = <function 6>
--    }
--  }
--} 
  if mvars.qst_questScriptBlockMessageExecTable then
    --tex kill quests message subscriber so it doesn't interfere with our override (in this.Messages)
    --TODO: generalize this to KillMessage or something
    local PlayerS32=Fox.StrCode32("Player")
    local QuestStartedS32=Fox.StrCode32("QuestStarted")
    local ShootingPracticeS32=Fox.StrCode32("ShootingPractice")
    --REF Tpp.MakeMessageExecTable, mvars.qst_questScriptBlockMessageExecTable
    for messageClassS32,messageNames in pairs(mvars.qst_questScriptBlockMessageExecTable)do
      if messageClassS32==PlayerS32 then
        InfCore.LogFlow("found PlayerS32")--DEBUGNOW
        for messageNameS32,messageInfo in pairs(messageNames)do
          if messageNameS32==QuestStartedS32 then
            InfCore.LogFlow("found QuestStartedS32")--DEBUGNOW
            mvars.qst_questScriptBlockMessageExecTable[PlayerS32][QuestStartedS32]=nil
--            for senderS32,senderInfo in pairs(messageInfo)do
--              if senderS32==ShootingPracticeS32 then
--                --DEBUGNOW not finding it
--                InfCore.LogFlow("found ShootingPracticeS32")--DEBUGNOW
--                --tex TODO: should really check there is only one sender listed
--                
--                break
--              end
--            end--for messageInfo
          end--if QuestStartedS32
        end--for messageNames
      end--if PlayerS32
    end--for qst_questScriptBlockMessageExecTable
  end--if qst_questScriptBlockMessageExecTable
end--QuestBlockOnInitializeBottom
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
  if TppLocation.GetLocationName()=="mtbs" or TppLocation.GetLocationName()=="mbqf" then
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

--saving/loading
--tex currently only loads ih_quest_states once on session
--but saves to is on every game save
--the qst_ gvars keep doing their thing normally after the initial set by ih
--
this.isSaveDirty=true

this.saveName="ih_quest_states.lua"

--tex don't lose existing on modulereload
ih_quest_states=ih_quest_states or {}--DEBUGNOW

function this.Save(newSave)
  InfCore.LogFlow"InfQuest.Save"

  local isDirty=this.GetCurrentStates()
  if isDirty then
    if this.debugSave then
      InfCore.Log("questStates isDirty")
    end

    local saveTextList={
      "-- "..this.saveName,
      "-- save states for quests (sideops).",
      "local this={}",
    }
    for questName,questStates in pairs(ih_quest_states)do
      IvarProc.BuildTableText(questName,questStates,saveTextList)
    end

    saveTextList[#saveTextList+1]="return this"
    IvarProc.WriteSave(saveTextList,this.saveName)
  end

  if this.debugSave then
    InfCore.PrintInspect(ih_quest_states,"ih_quest_states")
  end
end--Save
--GOTCHA: not module 'LoadSave' because we only really want to load once on , as gvars handles reverting state
function this.LoadStates()
  InfCore.LogFlow"InfQuest.LoadStates"
  local saveName=this.saveName
  local filePath=InfCore.paths.saves..saveName
  local ih_save_chunk,loadError=LoadFile(filePath)--tex WORKAROUND Mock
  if ih_save_chunk==nil then
    local errorText="LoadStates Error: loadfile error: "..tostring(loadError)
    InfCore.Log(errorText,false,true)
    return nil
  end

  local sandboxEnv={}
  if setfenv then
    setfenv(ih_save_chunk,sandboxEnv)
  end
  local ih_save=ih_save_chunk()

  if ih_save==nil then
    local errorText="LoadStates Error: ih_save==nil"
    InfCore.Log(errorText,true,true)

    return nil
  end

  if type(ih_save)~="table"then
    local errorText="LoadStates Error: ih_save==table"
    InfCore.Log(errorText,true,true)

    return nil
  end

  ih_quest_states=ih_save
  if this.debugSave then
    InfCore.PrintInspect(ih_quest_states,"ih_quest_states")
  end
end--LoadStates

--tex set questCleared gvars from ih_save state
--IN/SIDE: ih_save
--REF ih_save
--ih_quest_states={
--  ih_quest_q30100={
--    qst_questOpenFlag=true,
--  },
--}

function this.ReadSaveStates()
  InfCore.LogFlow"InfQuest.ReadSaveStates"

  if ih_quest_states==nil then
    local errorText="ERROR: ReadSaveStates: ih_quest_states==nil"
    InfCore.Log(errorText,true,true)
    return {}
  end

  if this.debugSave then
    InfCore.PrintInspect(ih_quest_states,"ih_quest_states")
  end

  local clearStates={}
  for questName,questStates in pairs(ih_quest_states) do
    local questIndex=TppDefine.QUEST_INDEX[questName]
    if not questIndex then
      InfCore.Log("InfQuest.ReadSaveStates: Could not find questIndex for "..questName)
      table.insert(clearStates,questName)--tex dont propogate it (also cant delete from table you're iterating, so actual clear ias after the loop)
    else
      for i,gvarFlagName in ipairs(gvarFlagNames)do
        gvars[gvarFlagName][questIndex]=questStates[gvarFlagName] or false
      end
    end
  end--for ih_quest_states

  for i,questName in ipairs(clearStates)do
    ih_quest_states[questName]=nil
  end

  --tex open up new quests
  for i,questName in ipairs(this.ihQuestNames)do
    if not ih_quest_states[questName] then
      local questIndex=TppDefine.QUEST_INDEX[questName]
      if not questIndex then
        InfCore.Log("ERROR: InfQuest.ReadSaveStates: Could not find questIndex for "..questName)
      else
        gvars.qst_questOpenFlag[questIndex]=true
      end
    end
  end--for ihQuestNames

  if this.debugSave then
    for questName,questStates in pairs(ih_quest_states) do
      InfCore.Log(questName)
      local questIndex=TppDefine.QUEST_INDEX[questName]
      if not questIndex then
      else
        for i,gvarFlagName in ipairs(gvarFlagNames)do
          local value=tostring(gvars[gvarFlagName][questIndex])
          InfCore.Log(gvarFlagName.."="..value)
        end
      end
    end--for ih_quest_states
  end
end--ReadSaveStates

--CALLER: IvarProc.BuildSaveText
function this.GetCurrentStates()
  local QUEST_INDEX=TppDefine.QUEST_INDEX
  local gvars=gvars

  local isSaveDirty=false

  for i,questName in ipairs(this.ihQuestNames)do
    local questIndex=QUEST_INDEX[questName]
    if not questIndex then
      InfCore.Log("ERROR: InfQuest.GetCurrentStates: Could not find questIndex for "..questName,false,true)
    else
      local questStates=ih_quest_states[questName] or {}

      for i,gvarFlagName in ipairs(gvarFlagNames) do
        local gvarValue=gvars[gvarFlagName][questIndex]
        if questStates[gvarFlagName]~=gvarValue then
          isSaveDirty=true
          questStates[gvarFlagName]=gvarValue
        end
      end

      ih_quest_states[questName]=questStates
    end
  end--for ihQuestNames

  return isSaveDirty
end--GetCurrentStates

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

--TODO move to util
function this.BreakDownMs(timeInMs)
  local minutes=math.floor(timeInMs/6e4)
  local seconds=math.floor((timeInMs-minutes*6e4)/1e3)
  local milliseconds=(timeInMs-minutes*6e4)-seconds*1e3
  return minutes,seconds,milliseconds
end
local timeFmt="%d:%02d:%d"
function this.PrintShootingPracticeBestTime(questName)
  local scoreTime=this.GetShootingPracticeTime(questName)
  local parTime=mvars.gim_questDisplayTimeSec*1000
  
  if not scoreTime then
    InfMenu.PrintLangId("quest_no_best_time")
  else
    local minutes,seconds,milliseconds=this.BreakDownMs(scoreTime)
    local bestTimeStr=format(timeFmt,minutes,seconds,milliseconds)
    local minutes,seconds,milliseconds=this.BreakDownMs(parTime)
    local parTimeStr=format(timeFmt,minutes,seconds,milliseconds)
    --TppUiCommand.AnnounceLogView(InfLangProc.LangString("quest_best_time").."["..bestTimeStr.."/"..parTimeStr.."]")--tex announcelog not up long enough for this to be readable
    TppUiCommand.AnnounceLogView(InfLangProc.LangString("quest_best_time").." "..bestTimeStr)
  end
end--PrintShootingPracticeBestTime
--tex addon equivalent of TppRanking. , since those are backed up by the whole ui and leaderboards don't really want to poke at that at the moment
--called from quest script on quest clear
--leftTime in ms
--'best times' are actually time-left in respect to the starting time limit
function this.UpdateShootingPracticeClearTime(questName,leftTime)
  --  local limitIsBestTime=Ivars.quest_setShootingPracticeTimeLimitToBestTime:Is(1)
  --
  --
  --  local fullTimeLimit=mvars.gim_questDefaultTimeSec or mvars.gim_questDisplayTimeSec
  --  local fullTimeLimit=fullTimeLimit*1000
  --  local currentTimeLimit=mvars.gim_questDisplayTimeSec*1000
  --
  --  local bestTimeLeft=this.GetShootingPracticeTime(questName)
  --  local bestTimeTaken=fullTimeLimit-bestTimeLeft
  --
  --  local currentTimeLeft=leftTime
  --  local currentTimeTaken=currentTimeLimit-currentTimeLeft
  --
  --  --tex leftTime is time left in respect to the 'best time', which is time left of default/full time limit. fun
  --  if limitIsBestTime then
  --    leftTime=fullTimeLimit-(bestTimeTaken+currentTimeTaken)
  --  end

  local questState=ih_quest_states[questName] or {}
  local bestTime=questState.scoreTime or 0--tex
  InfCore.Log("UpdateShootingPracticeClearTime currentBestTime:"..tostring(bestTime).." leftTime:"..tostring(leftTime))--DEBUGNOW
  if leftTime>bestTime then--tex since it's timeleft
    --tex replicate TppRanking.UpdateScore>ShowUpdateScoreAnnounceLog
    TppUI.ShowAnnounceLog"trial_update"
    --tex uhh, I don't see anything print in vanilla between trial_update - announce_trial_update 'New trial record:' and the time?
    --local rankingLangId=this.GetRankingLangId(rankingCategoryEnum)
    --TppUiCommand.AnnounceLogViewLangId(rankingLangId)
    --tex DEBUGNOW TODOif Ivars.quest_showShootingPracticeBestTimeAsTimeTaken -- show as time taken on quest clear message and on announcelog when entering start trap
    --TppRanking._ShowScoreTimeAnnounceLog(currentTimeTaken)
    --else
    TppRanking._ShowScoreTimeAnnounceLog(leftTime)
    questState.scoreTime=leftTime
    ih_quest_states[questName]=questState
  end
end--UpdateShootingPracticeClearTime

--CALLER: TppQuest.StartShootingPractice
--mvars.gim_questDisplayTimeSec,mvars.gim_questCautionTimeSec
function this.OverrideShootingPracticeTime()
  InfCore.LogFlow"OverrideShootingPracticeTime"--DEBUGNOW
  local overRideTime=this.GetShootingPracticeTime()
  if overRideTime then
    mvars.gim_questDefaultTimeSec=mvars.gim_questDisplayTimeSec--tex added
    --GOTCHA: mvars must be set directly, can't set it on passed in reference
    mvars.gim_questDisplayTimeSec=math.ceil(overRideTime/1000)--tex scoreTime is in ms
    mvars.gim_questCautionTimeSec=math.ceil(mvars.gim_questCautionTimeSec/5)
  end
end--OverrideShootingPracticeTime

function this.GetShootingPracticeTime(questName)
  questName=questName or TppQuest.GetCurrentQuestName()
  InfCore.Log("GetShootingPracticeTime "..tostring(questName))--DEBUGNOW
  if questName then
    local questState=ih_quest_states[questName]
    if questState then
      InfCore.Log("has questState, scoreTime:"..tostring(questState.scoreTime))--DEBUGNOW
      return questState.scoreTime
    else
      --tex vanilla shootingpractice quests
      local gvarName="rnk_"..questName
      local scoreTime=gvars[gvarName]
      if scoreTime then
        return scoreTime
      end
    end
  end--if questName
end--GetShootingPracticeTime

--Commands
--DEBUG, UNUSED
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
