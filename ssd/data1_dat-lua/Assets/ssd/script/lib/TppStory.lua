-- ssd TppStory.lua
local this={}
local IsTypeTable=Tpp.IsTypeTable
local IsTypeNumber=Tpp.IsTypeNumber
this.radioDemoTable={}
this.eventPlayTimmingTable={
  blackTelephone={},
  clearSideOpsForceMBDemo={},
  clearSideOpsForceMBRadio={},
  forceMBDemo={},
  afterMBDemo={},
  clearSideOps={},
  freeHeliRadio={}
}
this.PLAY_DEMO_END_MISSION={}
function this.GetCurrentStorySequence()
  --RETAILPATCH: 1.0.9.0>
  if Mission.IsReplayMission and Mission.IsReplayMission()then
    return Mission.GetReplayMissionStorySequence()
  else
    --<
    return gvars.str_storySequence
  end
end
function this.IncrementStorySequence()
  --RETAILPATCH: 1.0.9.0>
  if Mission.IsReplayMission and Mission.IsReplayMission()then
    Mission.SetReplayMissionStorySequence(Mission.GetReplayMissionStorySequence()+1)
  else
    --<
    gvars.str_storySequence=gvars.str_storySequence+1
  end
  TppTrophy.UnlockByStorySequence()
end
function this.PermitMissionOpen(missionCode)
  local missionEnum=SsdMissionList.MISSION_ENUM[tostring(missionCode)]
  if missionEnum then
    gvars.str_missionOpenPermission[missionEnum]=true
  end
end
function this.MissionOpen(missionCode)
  this.SetMissionOpenFlag(missionCode,true)
  this.EnableMissionNewOpenFlag(missionCode)
  Mission.RequestOpenMissionToServer(missionCode)
end
function this.MissionClose(missionCode)
  this.SetMissionOpenFlag(missionCode,false)
end
function this.SetMissionOpenFlag(missionCode,open)
  local missionEnum=SsdMissionList.MISSION_ENUM[tostring(missionCode)]
  if missionEnum then
    local n=gvars.str_missionOpenPermission[missionEnum]
    if n then
      gvars.str_missionOpenFlag[missionEnum]=open
    end
  end
end
function this.GetMissionEnemyLevel()
  local currentStorySequenceTable=this.GetCurrentStorySequenceTable()
  if not currentStorySequenceTable or not IsTypeTable(currentStorySequenceTable)then
    return 0,0
  end
  local baseEnemyLevel=currentStorySequenceTable.baseEnemyLevel
  local enemyLevelRandRange=currentStorySequenceTable.enemyLevelRandRange or 0
  if not baseEnemyLevel then
    baseEnemyLevel=0
    local currentStorySequence=this.GetCurrentStorySequence()
    if currentStorySequence>0 then
      for s=(currentStorySequence-1),0,-1 do
        local e=this.GetStorySequenceTable(s)
        if IsTypeTable(e)and e.baseEnemyLevel then
          if e.enemyLevelRandRange then
            enemyLevelRandRange=e.enemyLevelRandRange
          end
          baseEnemyLevel=e.baseEnemyLevel
          break
        end
      end
    end
  end
  --RETAILPATCH: 1.0.9.0>
  if Mission.IsReplayMission()and Mission.GetReplayMissionBaseEnemyLevel then
    local replayEnemyLevel,replayEnemyRange=Mission.GetReplayMissionBaseEnemyLevel()
    if replayEnemyLevel~=nil then
      baseEnemyLevel=replayEnemyLevel
      enemyLevelRandRange=replayEnemyRange
    end
  end
  --<
  return baseEnemyLevel,enemyLevelRandRange
end
function this.GetRegionEnemyLevel()
  local currentStorySequence=this.GetCurrentStorySequence()
  if currentStorySequence<=0 then
    return
  end
  for i=currentStorySequence,0,-1 do
    local e=this.GetStorySequenceTable(i)
    if IsTypeTable(e)and(e.regionEnemyLevelSetting)then
      return e.regionEnemyLevelSetting
    end
  end
end
function this.GetMissionGuideLine()
  local currentStorySequenceTable=this.GetCurrentStorySequenceTable()
  if not currentStorySequenceTable or not IsTypeTable(currentStorySequenceTable)then
    return
  end
  local guideLine=currentStorySequenceTable.guideLine
  if not IsTypeTable(guideLine)then
    return
  end
  return guideLine
end
function this.GetNextMissionInfo()
local currentStorySequence=this.GetCurrentStorySequence()
  local missionInfo=SsdStorySequenceList.sequenceAutoLoadMissionList[currentStorySequence+1]
  if not IsTypeTable(missionInfo)then
    return
  end
  return missionInfo
end
function this.GetObjectiveInfoAtAnotherLocation()
  local currentStorySequenceTable=this.GetCurrentStorySequenceTable()
  if not currentStorySequenceTable or not IsTypeTable(currentStorySequenceTable)then
    return
  end
  local objectiveInfoAtAnotherLocation=currentStorySequenceTable.objectiveInfoAtAnotherLocation
  if not IsTypeTable(objectiveInfoAtAnotherLocation)then
    return
  end
  return objectiveInfoAtAnotherLocation
end
function this.GetGuideLineInfoAtAnotherLocation()
  local currentStorySequenceTable=this.GetCurrentStorySequenceTable()
  if not currentStorySequenceTable or not IsTypeTable(currentStorySequenceTable)then
    return
  end
  local guideLineInfoAtAnotherLocation=currentStorySequenceTable.guideLineInfoAtAnotherLocation
  if not IsTypeTable(guideLineInfoAtAnotherLocation)then
    return
  end
  return guideLineInfoAtAnotherLocation
end
function this.GetMarkerInfoAtAnotherLocation()
  local currentStorySequenceTable=this.GetCurrentStorySequenceTable()
  if not currentStorySequenceTable or not IsTypeTable(currentStorySequenceTable)then
    return
  end
  local markerInfoAtAnotherLocation=currentStorySequenceTable.markerInfoAtAnotherLocation
  if not IsTypeTable(markerInfoAtAnotherLocation)then
    return
  end
  return markerInfoAtAnotherLocation
end
function this.IsMissionOpen(missionCode)
  local missionEnum=SsdMissionList.MISSION_ENUM[tostring(missionCode)]
  if missionEnum then
    return gvars.str_missionOpenFlag[missionEnum]
  end
  return false
end
function this.IsMissionCleard(missionCode)
  local missionEnum=SsdMissionList.MISSION_ENUM[tostring(missionCode)]
  if missionEnum then
    return gvars.str_missionClearedFlag[missionEnum]
  end
  return false
end
function this.CalcAllMissionClearedCount()
  local completedCount=0
  local totalCount=0
  for missionCodeStr,enum in pairs(SsdMissionList.MISSION_ENUM)do
    local missingNumberEnum=TppDefine.MISSING_NUMBER_MISSION_ENUM[missionCodeStr]
    if not missingNumberEnum then
      local missionCode=tonumber(missionCodeStr)
      if(gvars.str_missionClearedFlag[enum])then
        completedCount=completedCount+1
      end
      totalCount=totalCount+1
    end
  end
  return completedCount,totalCount
end
function this.CalcAllMissionTaskCompletedCount()
  local completedCount=0
  local totalCount=0
  for missionCodeStr,enum in pairs(SsdMissionList.MISSION_ENUM)do
    local missingNumberEnum=TppDefine.MISSING_NUMBER_MISSION_ENUM[missionCodeStr]
    if not missingNumberEnum then
      local missionCode=tonumber(missionCodeStr)
      completedCount=completedCount+TppUI.GetTaskCompletedNumber(missionCode)
      totalCount=totalCount+TppUI.GetMaxMissionTask(missionCode)
    end
  end
  return completedCount,totalCount
end
function this.UpdateMissionCleardFlag(e)
  local e=SsdMissionList.MISSION_ENUM[tostring(e)]
  if e then
    gvars.str_missionClearedFlag[e]=true
  end
end
function this.GetStorySequenceName(e)
  return TppDefine.STORY_SEQUENCE_LIST[e+1]
end
function this.GetStorySequenceTable(e)
  return SsdStorySequenceList.storySequenceTable[e+1]
end
function this.GetCurrentStorySequenceTable()
  local n=this.GetCurrentStorySequence()
  local e=this.GetStorySequenceTable(n)
  return e
end
function this.IsMainMission()
  for n,e in pairs(SsdStorySequenceList.storySequenceTable)do
    local n=0
    if e.main then
      n=TppMission.ParseMissionName(e.main)
    end
    if n==vars.missionCode then
      return true
    end
  end
  return false
end
function this.GetOpenMissionCount(t)
  local i=0
  if t==nil then
    for e=0,TppDefine.MISSION_COUNT_MAX do
      if gvars.str_missionOpenFlag[e]then
        i=i+1
      end
    end
  elseif IsTypeNumber(t)then
    for t=0,t do
      local e=this.GetStorySequenceTable(t)
      if e==nil then
        break
      end
      for s,t in ipairs{"story","coop","flag","onlyOpen"}do
        local e=e[t]
        if IsTypeTable(e)then
          i=i+#e
        end
      end
    end
  end
  return i
end
function this.GetClearedMissionCount(i)
  local n=0
  for t,s in ipairs(i)do
    if this.IsMissionCleard(i[t])==true then
      n=n+1
    end
  end
  return n
end
function this.GetElapsedMissionEventName(e)
  return TppDefine.ELAPSED_MISSION_EVENT_LIST[e+1]
end
function this.StartElapsedMissionEvent(i,n)
  if not this.GetElapsedMissionEventName(i)then
    return
  end
  if not IsTypeNumber(n)then
    return
  end
  if n<1 or n>128 then
    return
  end
  gvars.str_elapsedMissionCount[i]=n
end
function this.GetElapsedMissionCount(n)
  if not this.GetElapsedMissionEventName(n)then
    return
  end
  local e=gvars.str_elapsedMissionCount[n]
  return e
end
function this.IsNowOccurringElapsedMission(n)
  if not this.GetElapsedMissionEventName(n)then
    return
  end
  if gvars.str_elapsedMissionCount[n]==TppDefine.ELAPSED_MISSION_COUNT.NOW_OCCURRING then
    return true
  else
    return false
  end
end
function this.SetDoneElapsedMission(n)
  if not TppDefine.ELAPSED_MISSION_EVENT_LIST[n+1]then
    return
  end
  if this.IsNowOccurringElapsedMission(n)then
    gvars.str_elapsedMissionCount[n]=TppDefine.ELAPSED_MISSION_COUNT.DONE_EVENT
  else
    if gvars.str_elapsedMissionCount[n]>TppDefine.ELAPSED_MISSION_COUNT.NOW_OCCURRING then
    end
  end
end
function this.CanPlayMgo(e)
  return false
end
function this.CanPlayCoopMission()
  return Mission.IsCoopLobbyEnabled()
end
function this.OnReload(n)
  this.SetUpStorySequenceTable()
end
function this.SetUpStorySequenceTable()
end
function this.Init(n)
  this.UpdateStorySequence{updateTiming="OnMissionStart"}
end
this.SetUpStorySequenceTable()
function this.UpdateStorySequence(i)
  if not IsTypeTable(i)then
    return
  end
  local n
  local t=i.updateTiming
  local o=i.isInGame
  local s=function()
    TppQuest.UpdateActiveQuest()
  end
  if t=="OnMissionClear"then
    local i=i.missionId
    n=this.UpdateStorySequenceOnMissionClear(i)s()
  else
    local i=this.GetCurrentStorySequenceTable()
    if(i and i.updateTiming)and i.updateTiming[t]then
      n=this._UpdateStorySequence()
      s()
    end
  end
  if n and o then
    TppMission.ExecuteSystemCallback("OnUpdateStorySequenceInGame",n)
  end
  if n then
    if next(n)then
      gvars.mis_isExistOpenMissionFlag=true
    end
    local e=this.GetCurrentStorySequence()
    if TppDefine.CONTINUE_TIPS_TABLE[e]then
      gvars.continueTipsCount=1
    end
  end
  this.UpdateDisplayMissionList()
  return n
end
function this.UpdateDisplayMissionList()
  local i={}
  local n=TppLocation.GetLocationName()
  if not n then
    return
  end
  local e=n
  if e=="afgh"then
    e="SSD_AFGH"
  else
    e=string.upper(e)
  end
  if not SsdMissionList.MISSION_LIST_FOR_LOCATION[e]then
    return
  end
  for t,e in ipairs(SsdMissionList.MISSION_LIST_FOR_LOCATION[e])do
    local t=SsdMissionList.MISSION_ENUM[e]
    if(t and gvars.str_missionOpenFlag[t])and not SsdMissionList.MISSION_LIST_FOR_IGNORE_MISSION_LIST_UI[e]then
      if not TppMission.IsMultiPlayMission(e)then
        table.insert(i,{e,n,t})
      end
    end
  end
  if next(i)then
    MissionInfoSystem.RegisterInfos(i)
  end
end
function this.UpdateStorySequenceOnMissionClear(n)
  for i,e in pairs(TppDefine.SYS_MISSION_ID)do
    if(n==e)then
      return
    end
  end
  local i=SsdMissionList.MISSION_ENUM[tostring(n)]
  if not i then
    if DebugMenu then
      this.DEBUG_StoryVars()
    end
    return
  end
  if gvars.str_missionOpenFlag[i]==false then
    if DebugMenu then
      this.DEBUG_StoryVars()
    end
    return
  end
  this.UpdateMissionCleardFlag(n)
  this.DecreaseElapsedMissionClearCount()
  local e=this._UpdateStorySequence()
  return e
end
function this._UpdateStorySequence()
  local n=this.GetCurrentStorySequence()
  local t,s
  local i
  repeat
    s=this.GetStorySequenceTable(n)
    if s==nil then
      return
    end
    local s=this.CheckNeedProceedStorySequence(s)and n<TppDefine.STORY_SEQUENCE.STORY_FINISH
    if not s then
      break
    end
    t=this.ProceedStorySequence()
    n=this.GetCurrentStorySequence()
    if n<TppDefine.STORY_SEQUENCE.STORY_FINISH then
      i=false
    else
      i=true
    end
  until(i or next(t))
  return t
end
function this.CheckNeedProceedStorySequence(n)
  local i={}
  local t=n.story
  if t then
    for t,n in pairs(t)do
      local n=TppMission.ParseMissionName(n)
      table.insert(i,this.IsMissionCleard(n))
    end
  end
  local t=n.coop
  if t then
    for t,n in pairs(t)do
      local n=TppMission.ParseMissionName(n)
      table.insert(i,this.IsMissionCleard(n))
    end
  end
  local e=n.flag
  if e then
    for n,e in pairs(e)do
      table.insert(i,SsdFlagMission.IsCleared(e))
    end
  end
  local e=n.defense
  if e then
    for n,e in pairs(e)do
      table.insert(i,SsdBaseDefense.IsCleared(e))
    end
  end
  local e=true
  local t=0
  for e=1,#i do
    if i[e]then
      t=t+1
    end
  end
  local i=#i
  if n.proceedCount then
    i=n.proceedCount
  end
  if t<i then
    e=false
  end
  if e and n.condition then
    e=n.condition()
  end
  return e
end
function this.ProceedStorySequence()
  this.IncrementStorySequence()
  local i=this.GetCurrentStorySequence()
  local i=this.GetStorySequenceTable(i)
  if i==nil then
    return
  end
  local t={}
  local function s(n,i,o)
    local s=i or{}
    local i=TppMission.ParseMissionName(n)
    this.PermitMissionOpen(i)
    if not s[n]then
      if o~="onlyOpen"then
        table.insert(t,n)
      end
      this.MissionOpen(i)
    end
  end
  for e,t in ipairs{"story","coop","flag","onlyOpen"}do
    local e=i[t]
    if IsTypeTable(e)then
      for n,e in ipairs(e)do
        s(e,i.defaultClose,t)
      end
    end
  end
  for e,e in pairs(t)do
  end
  return t
end
function this.CanPlayDemoOrRadio(n)
  local e=this.radioDemoTable[n]
  if e then
    return e.storyCondition()and e.detailCondition()
  end
  return false
end
function this.GetStoryRadioListFromIndex(n,i)
  local n=this.eventPlayTimmingTable[n]
  if not n then
    return nil
  end
  local n=n[i][2]
  return this.radioDemoTable[n].radioList
end
function this._GetRadioList(e,n)
  if e.selectRadioFunction then
    return e.selectRadioFunction(n)
  end
  return e.radioList
end
function this.IsDoneEvent(e,n,i,i)
  if not n then
    return false
  end
  if e.radioList then
    for n,e in ipairs(e.radioList)do
      if TppRadio.IsPlayed(e)then
        return true
      end
    end
    return false
  end
  return true
end
function this.DEBUG_GetUnclearedMissionCode()
  for i,e in pairs(SsdMissionList.MISSION_ENUM)do
    local n=gvars.str_missionOpenFlag[e]
    local e=gvars.str_missionClearedFlag[e]
    if n and(not e)then
      return tonumber(i)
    end
  end
end
function this.DEBUG_TestStorySequence()
  this.DEBUG_SkipDemoRadio=true
  TppScriptVars.InitForNewGame()
  TppGVars.AllInitialize()
  TppVarInit.InitializeOnNewGame()
  this.DEBUG_InitQuestFlagsForTest()
  local t
  repeat
    local i=""for t,n in ipairs(SsdMissionList.MISSION_LIST)do
      if this.IsMissionCleard(n)then
        i=i..(","..tostring(n))
      end
    end
    coroutine.yield()
    if DebugText then
      local e=DebugText.NewContext()DebugText.Print(e,{.5,.5,1},"vars.missionCode = "..tostring(vars.missionCode))
    end
    this.UpdateStorySequence{updateTiming="OnMissionClear",missionId=TppMission.GetMissionID()}
    repeat
      coroutine.yield()
      TppQuest.UpdateActiveQuest{debugUpdate=true}
    until(not this.DEBUG_ClearQuestForTest(vars.missionCode))
    this.MissionOpen(10260)
    local n=this.DEBUG_GetUnclearedMissionCode()
    if mvars.str_DEBUG_needClearOneMission then
      n=10036
      mvars.str_DEBUG_needClearOneMission=false
    end
    if n==nil then
      break
    end
    vars.missionCode=n
    coroutine.yield()
  until(t or mvars.str_testBreak)
  this.DEBUG_SkipDemoRadio=nil
end
function this.DEBUG_InitQuestFlagsForTest()
  for n,e in ipairs(TppDefine.QUEST_INDEX)do
    gvars.qst_questOpenFlag[e]=false
    gvars.qst_questActiveFlag[e]=false
    gvars.qst_questClearedFlag[e]=false
    gvars.qst_questRepopFlag[e]=false
  end
end
function this.DEBUG_ClearQuestForTest(e)
  for n,e in ipairs(TppDefine.QUEST_DEFINE)do
    if TppQuest.IsOpen(e)and not TppQuest.IsCleard(e)then
      TppQuest.Clear(e)
      return true
    end
  end
  return false
end
function this.DEBUG_SetStorySequence(s,a)
  if Tpp.IsMaster()then
    return
  end
  gvars.str_storySequence=s
  for e=0,TppDefine.MISSION_COUNT_MAX do
    gvars.str_missionOpenPermission[e]=false
    gvars.str_missionOpenFlag[e]=false
    gvars.str_missionClearedFlag[e]=false
    gvars.str_missionNewOpenFlag[e]=false
  end
  local function r(i,r,o,t,n)
    local s=n or{}
    local n=TppMission.ParseMissionName(i)
    local t=(i==t)
    this.PermitMissionOpen(n)
    if(not s[i])or(t)then
      this.MissionOpen(n)
      if(r<o)and(not t)then
        this.DisableMissionNewOpenFlag(n)
        this.UpdateMissionCleardFlag(n)
      end
    end
    return t
  end
  local i
  for t=0,s do
    local e=this.GetStorySequenceTable(t)
    if e==nil then
      break
    end
    for l,o in ipairs{"story","coop","flag","onlyOpen"}do
      local o=e[o]
      if IsTypeTable(o)then
        for o,n in ipairs(o)do
          local e=r(n,t,s,a,e.defaultClose)
          i=i or e
        end
      end
    end
    if i then
      gvars.str_storySequence=t
      break
    end
  end
  TppTerminal.OnEstablishMissionClear()
  TppRanking.UpdateOpenRanking()
  this.UpdateDisplayMissionList()
  if DebugMenu then
    local n,i=this.GetMissionEnemyLevel()
    DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelBasic",(n+i))
    if not gvars.DEBUG_skipInitialEquip then
      this.QARELEASE_DEBUG_SetStoryPacingProduct()
    end
  end
end
function this.DecreaseElapsedMissionClearCount()
  for n=0,TppDefine.ELAPSED_MISSION_COUNT_MAX-1 do
    if n~=TppDefine.ELAPSED_MISSION_EVENT.STORY_SEQUENCE or(not this.PLAY_DEMO_END_MISSION[vars.missionCode])then
      if gvars.str_elapsedMissionCount[n]>0 then
        local e=gvars.str_elapsedMissionCount[n]-1
        gvars.str_elapsedMissionCount[n]=e
      end
    end
  end
end
function this.EnableMissionNewOpenFlag(n)
  this.SetMissionNewOpenFlag(n,true)
end
function this.DisableMissionNewOpenFlag(n)
  this.SetMissionNewOpenFlag(n,false)
end
function this.SetMissionNewOpenFlag(e,n)
  if TppMission.IsSysMissionId(e)then
    return
  end
  local e=SsdMissionList.MISSION_ENUM[tostring(e)]
  if e then
    gvars.str_missionNewOpenFlag[e]=n
  end
end
if DebugMenu then
  function this.QARELEASE_DEBUG_Init()
    mvars.qaDebug.setAfterStoryPacing=false
    DebugMenu.AddDebugMenu(" Pacing","setAfterStoryPacing","bool",mvars.qaDebug,"setAfterStoryPacing")
    mvars.qaDebug.pacingStage=0
    DebugMenu.AddDebugMenu(" Pacing","pacingStage","int32",mvars.qaDebug,"pacingStage")
    mvars.qaDebug.setStoryPacing=false
    DebugMenu.AddDebugMenu(" Pacing","setStoryPacing","bool",mvars.qaDebug,"setStoryPacing")
    mvars.qaDebug.showStorySequence=false
    DebugMenu.AddDebugMenu("LuaSystem","showStorySequnce","bool",mvars.qaDebug,"showStorySequence")
    mvars.qaDebug.showMissionOpenPermission=false
    DebugMenu.AddDebugMenu("LuaSystem","showPermitOpen","bool",mvars.qaDebug,"showMissionOpenPermission")
    mvars.qaDebug.showOpenMission=false
    DebugMenu.AddDebugMenu("LuaSystem","showOpenMission","bool",mvars.qaDebug,"showOpenMission")
    mvars.qaDebug.showCleardMission=false
    DebugMenu.AddDebugMenu("LuaSystem","showClearedMission","bool",mvars.qaDebug,"showCleardMission")
    mvars.qaDebug.prepareMissionClear=false
    DebugMenu.AddDebugMenu("LuaSystem","prepareMissionClear","bool",mvars.qaDebug,"prepareMissionClear")
    mvars.qaDebug.forceMissionClear=false
    DebugMenu.AddDebugMenu("LuaSystem","forceMissionClear","bool",mvars.qaDebug,"forceMissionClear")
    mvars.qaDebug.openAllMission=false
    DebugMenu.AddDebugMenu("LuaSystem","OpenAllMission","bool",mvars.qaDebug,"openAllMission")
    DebugMenu.AddDebugMenu(" Pacing","OpenAllMission","bool",mvars.qaDebug,"openAllMission")
    mvars.qaDebug.allMissionTaskClear=false
    DebugMenu.AddDebugMenu("LuaSystem","AllMissionTaskClear","bool",mvars.qaDebug,"allMissionTaskClear")
  end
  function this.QAReleaseDebugUpdate()
    local unkL1=5
    local svars=svars
    local mvars=mvars
    local Context=DebugText.NewContext()
    if gvars.DEBUG_reserveAddProductForPacing then
      this.QARELEASE_DEBUG_AddProductForPacing()
    end
    if mvars.qaDebug.showStorySequence then
      DebugText.Print(Context,"")
      DebugText.Print(Context,{.5,.5,1},"LuaSystem showStorySequnce")
      DebugText.Print(Context," Current story sequnce = "..tostring(this.GetStorySequenceName(this.GetCurrentStorySequence())))
    end
    if mvars.qaDebug.showMissionOpenPermission then
      DebugText.Print(Context,"")
      DebugText.Print(Context,{.5,.5,1},"LuaSystem showPermitOpen")
      local n={}
      local s,e=0,1
      for o,i in ipairs(SsdMissionList.MISSION_LIST)do
        local o=o-1
        if gvars.str_missionOpenPermission[o]then
          e=math.floor(s/unkL1)+1
          if n[e]then
            n[e]=n[e]..(", "..tostring(i))
          else
            n[e]="  "..tostring(i)
          end
          s=s+1
        end
      end
      for e=1,e do
        DebugText.Print(Context,n[e])
      end
    end
    if mvars.qaDebug.showOpenMission then
      DebugText.Print(Context,"")
      DebugText.Print(Context,{.5,.5,1},"LuaSystem showOpenMission")
      local n={}
      local s,e=0,1
      for o,i in ipairs(SsdMissionList.MISSION_LIST)do
        local o=o-1
        if gvars.str_missionOpenFlag[o]then
          e=math.floor(s/unkL1)+1
          if n[e]then
            n[e]=n[e]..(", "..tostring(i))
          else
            n[e]="  "..tostring(i)
          end
          s=s+1
        end
      end
      for e=1,e do
        DebugText.Print(Context,n[e])
      end
    end
    if mvars.qaDebug.showCleardMission then
      DebugText.Print(Context,"")
      DebugText.Print(Context,{.5,.5,1},"LuaSystem showCleardMission")
      local n={}
      local s,e=0,1
      for o,i in ipairs(SsdMissionList.MISSION_LIST)do
        local o=o-1
        if gvars.str_missionClearedFlag[o]then
          e=math.floor(s/unkL1)+1
          if n[e]then
            n[e]=n[e]..(", "..tostring(i))
          else
            n[e]="  "..tostring(i)
          end
          s=s+1
        end
      end
      for e=1,e do
        DebugText.Print(Context,n[e])
      end
    end
    if mvars.qaDebug.prepareMissionClear then
      if TppMission.CheckMissionState()then
        local e=TppMission._CreateMissionName(vars.missionCode)
        local e=e.."_sequence"local e=_G[e]
        if e and e.DEBUG_PrepareMissionClear then
          e.DEBUG_PrepareMissionClear()
        end
      end
      mvars.qaDebug.prepareMissionClear=false
    end
    if mvars.qaDebug.forceMissionClear then
      if TppMission.CheckMissionState()then
        local e=TppMission._CreateMissionName(vars.missionCode)
        local e=e.."_sequence"
        local e=_G[e]
        if e and e.ReserveMissionClear then
          e.ReserveMissionClear()
        else
          TppMission.ReserveMissionClearOnOutOfHotZone()
        end
      end
    end
    if mvars.qaDebug.openAllMission then
      mvars.qaDebug.openAllMission=false
      Mission.DEBUG_DisableUpdateEffectveMission()
      for missionCodeStr,enum in pairs(SsdMissionList.MISSION_ENUM)do
        local missingEnum=TppDefine.MISSING_NUMBER_MISSION_ENUM[missionCodeStr]
        if not missingEnum then
          local missionCode=tonumber(missionCodeStr)
          this.PermitMissionOpen(missionCode)
          this.MissionOpen(missionCode)
          this.UpdateMissionCleardFlag(missionCode)
        end
      end
      Mission.SetLocationReleaseState(Mission.LOCATION_RELEASE_STATE_AFGH_AND_MAFR)
      gvars.str_storySequence=TppDefine.STORY_SEQUENCE.STORY_FINISH
      this.UpdateDisplayMissionList()
    end
    if mvars.qaDebug.allMissionTaskClear then
      mvars.qaDebug.allMissionTaskClear=false
    end
    if mvars.qaDebug.setStoryPacing then
      mvars.qaDebug.setStoryPacing=false
      this.QARELEASE_DEBUG_SetStoryPacingProduct()
    end
    if mvars.qaDebug.pacingStage>7 then
      mvars.qaDebug.pacingStage=7
    end
    if mvars.qaDebug.pacingStage<0 then
      mvars.qaDebug.pacingStage=0
    end
    if mvars.qaDebug.setAfterStoryPacing then
      mvars.qaDebug.setAfterStoryPacing=false
      this.QARELEASE_DEBUG_afterStoryPacingSetting(mvars.qaDebug.pacingStage)
      mvars.qaDebug.pacingStage=0
    end
  end
  function this.QARELEASE_DEBUG_SetStoryPacingProduct()
    if TppPause.IsPausedAny(TppPause.PAUSE_FLAG_GAME_SEQUENCE)then
      if mvars.qaDebug then
        mvars.qaDebug.setStoryPacing=true
      end
      return
    end
    DebugMenu.SetDebugMenuValue(" Craft&Inventory","ClearBaseStorage",true)
    gvars.DEBUG_reserveAddProductForPacing=true
  end
  function this.QARELEASE_DEBUG_AddProductForPacing()
    gvars.DEBUG_reserveAddProductForPacing=false
    local function GetDebugStorySequenceTable(storySequence)
      return SsdStorySequenceList.DEBUG_storySequenceTable[storySequence+1]
    end
    local currentStorySequence=this.GetCurrentStorySequence()
    for storySequence=TppDefine.STORY_SEQUENCE.STORY_START,currentStorySequence do
      local e=GetDebugStorySequenceTable(storySequence)
      if e then
        if e.Equip then
          TppPlayer.DEBUG_ProductAndEquipWithTable(e.Equip)
        end
        if e.Skill then
          TppPlayer.DEBUG_GetSkills(e.Skill)
        end
        if e.Resource then
          TppPlayer.DEBUG_GetResource(e.Resource)
        end
        if e.Exp then
          SsdSbm.AddExperiencePoint(e.Exp)
        end
        if e.FastTravel then
          SsdFastTravel.RegisterFastTravelPoints()
          for n,e in ipairs(e.FastTravel)do
            SsdFastTravel.UnlockFastTravelPoint(e)
            local questName=SsdFastTravel.GetQuestName(e)
            if questName then
              local questIndex=TppQuest.GetQuestIndex(questName)
              if questIndex then
                TppQuest.UpdateClearFlag(questIndex,true)
              end
              Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[questName])
            end
          end
        end
        if e.overrideVarsFunction and(storySequence==currentStorySequence)then
          e.overrideVarsFunction()
        end
      end
    end
    local e={"PRD_CURE_Bleeding","PRD_CURE_Sprain","PRD_CURE_Ruptura","PRD_CURE_Tiredness","PRD_CURE_Weakening","PRD_CURE_Poison_Normal","PRD_CURE_Poison_Deadly","PRD_CURE_Poison_Food","PRD_CURE_Poison_Water"}
    for n,id in ipairs(e)do
      local n=SsdSbm.GetCountProduction{id=id,inInventory=true,inWarehoud=false}
      if n<5 then
        SsdSbm.AddProduction{id=id,toInventory=true,count=(5-n)}
      end
    end
  end
  function this.QARELEASE_DEBUG_afterStoryPacingSetting(pacingStage)
    if not Tpp.IsTypeNumber(pacingStage)then
      return
    end
    if pacingStage<1 then
      return
    end
    for e=1,pacingStage do
      local e=SsdStorySequenceList.DEBUG_afterStoryPacingTable[e]
      if e then
        if e.Recipe and next(e.Recipe)then
          for n,e in ipairs(e.Recipe)do
            if not SsdSbm.HasRecipe(e)then
              SsdSbm.AddRecipe{id=e,count=1,toInventory=false}
            end
          end
        end
        if e.Exp then
          SsdSbm.AddExperiencePoint(e.Exp)
        end
        if e.Skill then
          TppPlayer.DEBUG_GetSkills(e.Skill)
        end
        if e.PlayerBaseLevel then
          DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelBasic",(e.PlayerBaseLevel))
        end
        if e.PlayerLevelFighter then
          DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelFighter",(e.PlayerLevelFighter))
        end
        if e.PlayerLevelShooter then
          DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelShooter",(e.PlayerLevelShooter))
        end
        if e.PlayerLevelMedic then
          DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelMedic",(e.PlayerLevelMedic))
        end
        if e.PlayerLevelScout then
          DebugMenu.SetDebugMenuValue(" Craft&Inventory","PlayerLevelScout",(e.PlayerLevelScout))
        end
        if e.UniqueCrew then
          for n,quest in ipairs(e.UniqueCrew)do
            local handle=SsdCrewSystem.RegisterTempCrew{quest=quest}
            SsdCrewSystem.EmployTempCrew{handle=handle}
          end
        end
      end
    end
  end
end
if DebugMenu then
  function this.DEBUG_AllMissionOpen()
    if TppGameSequence.IsMaster()then
      return
    end
    this.DEBUG_SetStorySequence(TppDefine.STORY_SEQUENCE.STORY_FINISH)
    DebugMenu.SetDebugMenuValue("MotherBaseManagement","SetAll","Set")
  end
  function this.DEBUG_StoryVars()
    for n,e in pairs(SsdMissionList.MISSION_ENUM)do
      if gvars.str_missionOpenPermission[e]then
      end
    end
    for n,e in pairs(SsdMissionList.MISSION_ENUM)do
      if gvars.str_missionOpenFlag[e]then
      end
    end
    for n,e in pairs(SsdMissionList.MISSION_ENUM)do
      if gvars.str_missionClearedFlag[e]then
      end
    end
  end
end
return this
