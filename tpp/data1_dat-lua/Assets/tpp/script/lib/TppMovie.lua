local e={}
local i=Fox.StrCode32
local t=Tpp.IsTypeFunc
local o=Tpp.IsTypeTable
local l=Tpp.IsTypeString
e.CallbackFunctionTable={}
function e.Play(n)
local a
if TppGameSequence.GetTargetArea()=="Japan"then
a="_jp"else
a="_en"end
if not o(n)then
return
end
local o=n.videoName
if not l(o)then
return
end
o=o..a
local d=n.subtitleName or""local a=false
if n.isLoop then
a=true
end
local a=n.onStart
if a then
if not t(a)then
return
end
end
local l=n.onEnd
if l then
if not t(l)then
return
end
end
local t=n.memoryPool
if not t then
end
local n=i(o)
e.CallbackFunctionTable[n]={videoName=o,onStart=a,onEnd=l}
local o=TppVideoPlayer.LoadVideo{VideoName=o,SubtitleName=d,MemoryPool=t}
if not o then
TppVideoPlayer.PlayVideo()
else
e.DoMessage(n,"onStart")
e.DoMessage(n,"onEnd")
end
end
e.CommonDoMessage={}
function e.CommonDoMessage.onStart()
local e={}
for n,o in pairs(TppDefine.GAME_STATUS_TYPE_ALL)do
e[n]=false
end
for n,o in pairs(TppDefine.UI_STATUS_TYPE_ALL)do
e[n]=false
end
e.PauseMenu=nil
TppUI.FadeIn(TppUI.FADE_SPEED.FADE_MOMENT,"FadeInForMovieStart",nil,{exceptGameStatus=e})
TppUiStatusManager.ClearStatus"PauseMenu"Player.SetPause()
end
function e.CommonDoMessage.onEnd()
TppUI.FadeOut(TppUI.FADE_SPEED.FADE_MOMENT)Player.UnsetPause()
end
function e.DoMessage(n,o)
local n=e.CallbackFunctionTable[n]
if not n then
return
end
local a=n.videoName
e.CommonDoMessage[o]()
local e=n[o]
if e then
e()
end
end
return e
