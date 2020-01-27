local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
function this.CreateInstance(e)
  local instance={}
  function instance.PlayIntelDemo(o,n,OnEnd,t)
    TppDemo.PlayGetIntelDemo({
      onEnd=function()
        if Tpp.IsTypeFunc(OnEnd)then
          OnEnd()
        end
      end},o,n,{useDemoBlock=false},true)
  end
  function instance.MemoryBoardDemo(n,o,OnEnd,t)
    TppDemo.PlayGetMemoryBoardDemo({
      onEnd=function()
        if Tpp.IsTypeFunc(OnEnd)then
          OnEnd()
        end
      end},n,o,{useDemoBlock=false})
  end
  function instance.GetNextStorySequenceDemoName()
    local storySequenceDemoTable=instance.storySequenceDemoTable
    if Tpp.IsTypeTable(storySequenceDemoTable)then
      for n=TppStory.GetCurrentStorySequence(),TppDefine.STORY_SEQUENCE.STORY_FINISH do
        local demoName=storySequenceDemoTable[n]
        if Tpp.IsTypeString(demoName)then
          return demoName
        end
      end
    end
  end
  function instance.GetCurrentStorySequenceDemoName()
    local storySequenceDemoTable=instance.storySequenceDemoTable
    if Tpp.IsTypeTable(storySequenceDemoTable)then
      local demoName=storySequenceDemoTable[TppStory.GetCurrentStorySequence()]
      local storySequenceDemoExclusionTable=instance.storySequenceDemoExclusionTable
      if Tpp.IsTypeString(demoName)and(not storySequenceDemoExclusionTable or not storySequenceDemoExclusionTable[demoName])then
        return demoName
      end
    end
  end
  return instance
end
return this
