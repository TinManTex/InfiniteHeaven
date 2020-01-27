-- TppCrew.lua
local this={}
function this._StartFlagOrStoryMission(missionCode)
  if not Mission.SetRescueCrewInfo then
    return
  end
  local crewInfo=SsdCrewList.GetRescueCrewInfoForFlagMission(missionCode)
  if crewInfo then
    Mission.SetRescueCrewInfo{missionType=TppDefine.RESCUE_CREW_MISSION_TYPE.FLAG_MISSION,locatorName=crewInfo.locatorName,id=crewInfo.id,life=crewInfo.life}
  end
  local crewTypes=SsdCrewList.GetForceBaseCampCrewList(missionCode)
  if crewTypes then
    Tpp.DEBUG_DumpTable(crewTypes)
    if Mission.SetForceBaseCampCrewList then
      Mission.SetForceBaseCampCrewList(crewTypes)
    end
  end
  do
    local currentStorySequence=TppStory.GetCurrentStorySequence()
    if Mission.SetBefore10050 then
      if currentStorySequence==TppDefine.STORY_SEQUENCE.BEFORE_s10050 then
        Mission.SetBefore10050(true)
      else
        Mission.SetBefore10050(false)
      end
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40020 then
      Mission.SetReeveInjury(true)
    else
      Mission.SetReeveInjury(false)
    end
    if currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40090 then
      Mission.SetHasWheelChair(false)
    else
      Mission.SetHasWheelChair(true)
    end
    --RETAILPATCH: 1.0.9.0>
    if Mission.SetExistNpcCrewBoyWhenReplayMission then
      if Mission.IsReplayMission()and currentStorySequence>=TppDefine.STORY_SEQUENCE.CLEARED_k40080 then
        Mission.SetExistNpcCrewBoyWhenReplayMission(true)
      else
        Mission.SetExistNpcCrewBoyWhenReplayMission(false)
      end
    end
    if Mission.LockGasCylinderWhenReplayMission then
      if Mission.IsReplayMission()and currentStorySequence<TppDefine.STORY_SEQUENCE.CLEARED_k40070 then
        Mission.LockGasCylinderWhenReplayMission(true)
      else
        Mission.LockGasCylinderWhenReplayMission(false)
      end
    end
    --<
  end
end
function this._FinishFlagOrStoryMission(e)
  Mission.ClearForceBaseCampCrewList()
  Mission.ClearRescueCrewInfo{missionType=TppDefine.RESCUE_CREW_MISSION_TYPE.FLAG_MISSION}
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
  TppCrew.StartMission(vars.missionCode)
  Mission.RecreateBaseCrew()
end
--RETAILPATCH: 1.0.9.0>
function this.FinishReplayMission()
  Mission.ClearForceBaseCampCrewList()
  Mission.ClearRescueCrewInfo{missionType=TppDefine.RESCUE_CREW_MISSION_TYPE.FLAG_MISSION}
  if TppLocation.IsMiddleAfrica()then
    TppCrew.StartMission(30020)
  else
    TppCrew.StartMission(30010)
  end
  Mission.RecreateBaseCrew()
end
--<
function this.UpdateActiveQuest(questName)
  local crewInfo=SsdCrewList.GetRescueCrewInfoForQuest(questName)
  if crewInfo then
    local i=TppQuest.SearchBlockIndex(questName)
    Mission.SetRescueCrewInfo{missionType=(TppDefine.RESCUE_CREW_MISSION_TYPE.QUEST_1+(i-1)),locatorName=crewInfo.locatorName,id=crewInfo.id,life=crewInfo.life}
  end
end
function this.SetAcceptableQuestList(e)
  if Mission.SetCrewAcceptableQuestList then
    Mission.SetCrewAcceptableQuestList(e)
  end
end
return this
