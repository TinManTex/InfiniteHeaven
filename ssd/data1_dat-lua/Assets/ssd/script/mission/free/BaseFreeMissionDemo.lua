local o={}
local e=Fox.StrCode32
local e=Tpp.StrCode32Table
function o.CreateInstance(e)
local e={}
function e.PlayIntelDemo(o,n,e,t)
TppDemo.PlayGetIntelDemo({onEnd=function()
if Tpp.IsTypeFunc(e)then
e()
end
end},o,n,{useDemoBlock=false},true)
end
function e.MemoryBoardDemo(n,o,e,t)
TppDemo.PlayGetMemoryBoardDemo({onEnd=function()
if Tpp.IsTypeFunc(e)then
e()
end
end},n,o,{useDemoBlock=false})
end
function e.GetNextStorySequenceDemoName()
local e=e.storySequenceDemoTable
if Tpp.IsTypeTable(e)then
for n=TppStory.GetCurrentStorySequence(),TppDefine.STORY_SEQUENCE.STORY_FINISH do
local e=e[n]
if Tpp.IsTypeString(e)then
return e
end
end
end
end
function e.GetCurrentStorySequenceDemoName()
local n=e.storySequenceDemoTable
if Tpp.IsTypeTable(n)then
local n=n[TppStory.GetCurrentStorySequence()]
local e=e.storySequenceDemoExclusionTable
if Tpp.IsTypeString(n)and(not e or not e[n])then
return n
end
end
end
return e
end
return o
