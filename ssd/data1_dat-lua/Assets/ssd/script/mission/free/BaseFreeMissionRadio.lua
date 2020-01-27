local o={}
local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local t=Tpp.IsTypeTable
local l=Tpp.IsTypeString
function o.CreateInstance(n)
local e=BaseMissionRadio.CreateInstance(n)
e.missionName=n
e.storySequenceRadio={}
function e.PlayStorySequenceRadio()
local l=TppStory.GetCurrentStorySequence()
local n,a
for o=l,0,-1 do
n,a=e.storySequenceRadio[o],o
if t(n)then
break
end
end
if n then
local t,n=n.radioGroups,n.isOnce
local e=true
if n and(o.lastPlayedStorySequenceRadio==a)then
e=false
end
if e then
TppRadio.Play(t,{delayTime=4})o.lastPlayedStorySequenceRadio=a
end
end
end
function e.PlayHordeNotice()
TppRadio.Play"f3000_rtrg1101"end
function e.GetCurrentStorySequenceBlackRadioSettings()
local e=e.storySequenceBlackRadioTable
if Tpp.IsTypeTable(e)then
local e=e[TppStory.GetCurrentStorySequence()]
if t(e)then
return e
elseif l(e)then
return{e}
end
end
end
return e
end
return o
