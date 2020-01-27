local this={}
this.BASE_DEFENSE_LIST={{name="d50010",location="afgh",loadCondition=function()
  return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.BEFORE_DEFENSE_AREA_1
end,pack="/Assets/ssd/pack/mission/defense/d50010/d50010.fpk"}}
this.BASE_DEFENSE_PARAMETER={{missionCode=50010,waveCountMax=5,waveSettings={{waveTime=434,autoDefenseScore=5e3},{waveTime=124,autoDefenseScore=5e3},{waveTime=134,autoDefenseScore=5e3},{waveTime=144,autoDefenseScore=5e3},{waveTime=154,autoDefenseScore=5e3}},intervalSettings={24,24,24,24}}}
return this
