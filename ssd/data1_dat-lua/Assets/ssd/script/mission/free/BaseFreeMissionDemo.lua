local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
function this.CreateInstance(e)
  local instance={}
  function instance.PlayIntelDemo(o,n,e,t)
    TppDemo.PlayGetIntelDemo({onEnd=function()
      if Tpp.IsTypeFunc(e)then
        e()
      end
    end},o,n,{useDemoBlock=false},true)
  end
  function instance.MemoryBoardDemo(n,o,e,t)
    TppDemo.PlayGetMemoryBoardDemo({onEnd=function()
      if Tpp.IsTypeFunc(e)then
        e()
      end
    end},n,o,{useDemoBlock=false})
  end
  function instance.GetNextStorySequenceDemoName()
    local e=instance.storySequenceDemoTable
    if Tpp.IsTypeTable(e)then
      for n=TppStory.GetCurrentStorySequence(),TppDefine.STORY_SEQUENCE.STORY_FINISH do
        local e=e[n]
        if Tpp.IsTypeString(e)then
          return e
        end
      end
    end
  end
  function instance.GetCurrentStorySequenceDemoName()
    local n=instance.storySequenceDemoTable
    if Tpp.IsTypeTable(n)then
      local n=n[TppStory.GetCurrentStorySequence()]
      local e=instance.storySequenceDemoExclusionTable
      if Tpp.IsTypeString(n)and(not e or not e[n])then
        return n
      end
    end
  end
  return instance
end
return this
