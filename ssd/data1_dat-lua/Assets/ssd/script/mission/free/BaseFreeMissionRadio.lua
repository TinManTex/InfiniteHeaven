local this={}
local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local t=Tpp.IsTypeTable
local l=Tpp.IsTypeString
function this.CreateInstance(n)
  local instance=BaseMissionRadio.CreateInstance(n)
  instance.missionName=n
  instance.storySequenceRadio={}
  function instance.PlayStorySequenceRadio()
    local l=TppStory.GetCurrentStorySequence()
    local n,a
    for o=l,0,-1 do
      n,a=instance.storySequenceRadio[o],o
      if t(n)then
        break
      end
    end
    if n then
      local t,n=n.radioGroups,n.isOnce
      local e=true
      if n and(this.lastPlayedStorySequenceRadio==a)then
        e=false
      end
      if e then
        TppRadio.Play(t,{delayTime=4})this.lastPlayedStorySequenceRadio=a
      end
    end
  end
  function instance.PlayHordeNotice()
    TppRadio.Play"f3000_rtrg1101"end
  function instance.GetCurrentStorySequenceBlackRadioSettings()
    local e=instance.storySequenceBlackRadioTable
    if Tpp.IsTypeTable(e)then
      local e=e[TppStory.GetCurrentStorySequence()]
      if t(e)then
        return e
      elseif l(e)then
        return{e}
      end
    end
  end
  return instance
end
return this
