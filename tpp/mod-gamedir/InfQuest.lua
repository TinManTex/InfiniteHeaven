-- InfQuest.lua
local this={}

--block quests>
local blockQuests={
  "tent_q99040", -- 144 - recover volgin, player is left stuck in geometry at end of quanranteed plat demo
  "sovietBase_q99020",-- 82, make contact with emmeric
}

function this.BlockQuest(questName)
  --tex TODO: doesn't work for the quest area you start in (need to clear before in actual mission)
  if vars.missionCode==30050 and Ivars.mbWarGamesProfile:Is()>0 then
    --InfLog.Add("BlockQuest on event "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
    return true
  end

  if  Ivars.inf_event:Is"WARGAME" then
    --InfLog.Add("BlockQuest on WARGAME "..tostring(questName).." "..tostring(vars.missionCode))--DEBUG
    return true
  end

  for n,name in ipairs(blockQuests)do
    if name==questName then
      if TppQuest.IsCleard(questName) then
        return true
      end
    end
  end
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
  if vars.missionCode==30050 and Ivars.mbWarGamesProfile:Is()>0 then
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

  if Ivars.mbEnablePuppy:Is()>0 and Ivars.mbWarGamesProfile:Is(0) and Ivars.inf_event:Is(0) then
    local unlockedName="Mtbs_child_dog"
    local unlockedArea=TppQuestList.questAreaTable[unlockedName]
    if forcedQuests[unlockedArea]==nil then
      forcedQuests[unlockedArea]=unlockedName
      forcedCount=forcedCount+1
    end
  end

  if forcedCount==0 then
    return nil
  else
    --tex DEBUG
    InfLog.Add("forcedQuests")
    InfLog.PrintInspect(forcedQuests)

    return forcedQuests
  end
end

return this
