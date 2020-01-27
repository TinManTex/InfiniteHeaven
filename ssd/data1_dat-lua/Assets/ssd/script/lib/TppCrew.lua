local this={}
function this._StartFlagOrStoryMission(i)
  if not Mission.SetRescueCrewInfo then
    return
  end
  local e=SsdCrewList.GetRescueCrewInfoForFlagMission(i)
  if e then
    Mission.SetRescueCrewInfo{missionType=TppDefine.RESCUE_CREW_MISSION_TYPE.FLAG_MISSION,locatorName=e.locatorName,id=e.id,life=e.life}
  end
  local e=SsdCrewList.GetForceBaseCampCrewList(i)
  if e then
    Tpp.DEBUG_DumpTable(e)
    if Mission.SetForceBaseCampCrewList then
      Mission.SetForceBaseCampCrewList(e)
    end
  end
  do
    local e=TppStory.GetCurrentStorySequence()
    if Mission.SetBefore10050 then
      if e==TppDefine.STORY_SEQUENCE.BEFORE_s10050 then
        Mission.SetBefore10050(true)
      else
        Mission.SetBefore10050(false)
      end
    end
    if e<TppDefine.STORY_SEQUENCE.CLEARED_k40020 then
      Mission.SetReeveInjury(true)
    else
      Mission.SetReeveInjury(false)
    end
    if e<TppDefine.STORY_SEQUENCE.CLEARED_k40090 then
      Mission.SetHasWheelChair(false)
    else
      Mission.SetHasWheelChair(true)
    end
  end
end
function this._FinishFlagOrStoryMission(e)Mission.ClearForceBaseCampCrewList()Mission.ClearRescueCrewInfo{missionType=TppDefine.RESCUE_CREW_MISSION_TYPE.FLAG_MISSION}
end
function this.StartMission(e)
  TppCrew._StartFlagOrStoryMission(e)
end
function this.FinishMission(e)
  TppCrew._FinishFlagOrStoryMission(e)
end
function this.StartFlagMission(e)
  TppCrew._StartFlagOrStoryMission(e)
end
function this.FinishFlagMission(e)
  TppCrew._FinishFlagOrStoryMission(e)
  TppCrew.StartMission(vars.missionCode)Mission.RecreateBaseCrew()
end
function this.UpdateActiveQuest(i)
  local e=SsdCrewList.GetRescueCrewInfoForQuest(i)
  if e then
    local i=TppQuest.SearchBlockIndex(i)Mission.SetRescueCrewInfo{missionType=(TppDefine.RESCUE_CREW_MISSION_TYPE.QUEST_1+(i-1)),locatorName=e.locatorName,id=e.id,life=e.life}
  end
end
function this.SetAcceptableQuestList(e)
  if Mission.SetCrewAcceptableQuestList then
    Mission.SetCrewAcceptableQuestList(e)
  end
end
return this
