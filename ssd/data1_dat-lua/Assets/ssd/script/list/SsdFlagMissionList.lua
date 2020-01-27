local this={}
this.FLAG_MISSION_LIST={
  {name="k40040",location="afgh",openCondition=function()
    return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_TUTORIAL
  end,
  pack="/Assets/ssd/pack/mission/flag/k40040/k40040.fpk"},
  {name="k40050",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40040
    end,
    pack="/Assets/ssd/pack/mission/flag/k40050/k40050.fpk"},
  {name="k40060",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40050
    end,
    pack="/Assets/ssd/pack/mission/flag/k40060/k40060.fpk"},
  {name="k40070",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40060
    end,pack="/Assets/ssd/pack/mission/flag/k40070/k40070.fpk"},
  {name="k40010",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40070
    end,
    pack="/Assets/ssd/pack/mission/flag/k40010/k40010.fpk"},
  {name="k40025",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40010
    end,
    pack="/Assets/ssd/pack/mission/flag/k40025/k40025.fpk"},
  {name="k40015",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40025
    end,
    pack="/Assets/ssd/pack/mission/flag/k40015/k40015.fpk"},
  {name="k40020",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40015
    end,
    pack="/Assets/ssd/pack/mission/flag/k40020/k40020.fpk"},
  {name="k40030",location="afgh",
    openCondition=function()
      return TppStory.GetCurrentStorySequence()>=TppDefine.STORY_SEQUENCE.CLEARED_k40020
    end,
    pack="/Assets/ssd/pack/mission/flag/k40030/k40030.fpk"}
}
return this
