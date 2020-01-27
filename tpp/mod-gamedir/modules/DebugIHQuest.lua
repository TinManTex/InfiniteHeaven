--DebugIHQuest.lua
--tex pass through from quest block scripts so you can test various scripting without having to repack/restart the game

local this={}

local testingQuest="quest_q30103"

--QuestBlockOnAllocate only called in added ih quests, not vanilla quests, the rest of the functions called by vannila quest scripts
function this.QuestBlockOnAllocate(questScript)--tex
  --tex filter to what quest you're testing
  local questName=TppQuest.GetCurrentQuestName()
  if questName==testingQuest then
  
  end
end
--tex called during questScript .OnAllocate
function this.RegisterQuestSystemCallbacks(callbackFunctions)
  local questName=TppQuest.GetCurrentQuestName()
  if questName==testingQuest then
  
  end
end
function this.QuestBlockOnInitialize(questScript)
  local questName=TppQuest.GetCurrentQuestName()
  if questName==testingQuest then
  
  end
end
function this.QuestBlockOnUpdate(questScript)
  local questName=TppQuest.GetCurrentQuestName()
  if questName==testingQuest then
  
  end
end
function this.QuestBlockOnTerminate(questScript)
  local questName=TppQuest.GetCurrentQuestName()
  if questName==testingQuest then
  
  end
end

return this