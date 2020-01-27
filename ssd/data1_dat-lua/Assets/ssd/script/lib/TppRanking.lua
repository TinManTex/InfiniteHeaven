local e={}
e.IS_ONCE={}
e.UPDATE_ORDER={}
e.ANNOUNCE_LOG_TYPE={NONE=0,TIME=1,DISTANCE=2,NUMBER=3}
e.SHOW_ANNOUNCE_LOG={}
e.OPEN_CONDITION={}
e.EXCLUDE_MISSION_LIST={}
function e.GetScore(e)
local e="rnk_"..e
local e=gvars[e]
if e==nil then
return
end
return e
end
function e.IncrementScore(n)
local o=e.GetScore(n)
if o then
e.UpdateScore(n,o+1)
end
end
function e.UpdateScore(o,a)
local n=TppDefine.RANKING_ENUM[o]
if not n then
return
end
if not Tpp.IsTypeNumber(a)then
return
end
if not gvars.rnk_isOpen[n]then
return
end
local t=e.CheckExcludeMission(n,vars.missionCode)
if t then
return
end
local t="rnk_"..o
if gvars[t]==nil then
return
end
local i=e.IS_ONCE[n]
if(svars.rnk_isUpdated[n]==false)or(i==false)then
svars.rnk_isUpdated[n]=true
local i=e.UPDATE_ORDER[n]
local o
if i then
if gvars[t]<a then
o=true
else
o=false
end
else
if gvars[t]>a then
o=true
else
o=false
end
end
if o then
e.ShowUpdateScoreAnnounceLog(n,a)gvars[t]=a
end
else
if i then
end
end
end
function e.ShowUpdateScoreAnnounceLog(a,o)
local n=e.SHOW_ANNOUNCE_LOG[a]
if n==e.ANNOUNCE_LOG_TYPE.NONE then
return
end
e._ShowCommonUpdateScoreAnnounceLog(a)
if n==e.ANNOUNCE_LOG_TYPE.TIME then
e._ShowScoreTimeAnnounceLog(o)
end
if n==e.ANNOUNCE_LOG_TYPE.DISTANCE then
e._ShowScoreDistanceAnnounceLog(o)
end
if n==e.ANNOUNCE_LOG_TYPE.NUMBER then
e._ShowScoreNumberAnnounceLog(o)
end
end
function e.GetRankingLangId(e)
return string.format("ranking_name_%02d",e)
end
function e._ShowCommonUpdateScoreAnnounceLog(n)
TppUI.ShowAnnounceLog"trial_update"local e=e.GetRankingLangId(n)
TppUiCommand.AnnounceLogViewLangId(e)
end
function e._ShowScoreTimeAnnounceLog(e)
local n=math.floor(e/6e4)
local o=math.floor((e-n*6e4)/1e3)
local e=(e-n*6e4)-o*1e3
TppUiCommand.AnnounceLogViewLangId("announce_trial_time",n,o,e)
end
function e._ShowScoreDistanceAnnounceLog(e)
local n=math.floor(e)
local e=(e-n)*1e3
TppUiCommand.AnnounceLogViewLangId("announce_trial_length",n,e)
end
function e._ShowScoreNumberAnnounceLog(e)
TppUiCommand.AnnounceLogViewLangId("announce_trial_num",e)
end
function e.UpdateOpenRanking()
for o,e in pairs(e.OPEN_CONDITION)do
local n=gvars.rnk_isOpen[o]
local n=false
if e==true then
n=true
elseif Tpp.IsTypeNumber(e)then
n=TppStory.IsMissionCleard(e)
elseif Tpp.IsTypeFunc(e)then
n=e()
end
gvars.rnk_isOpen[o]=n
end
end
function e.RegistMissionClearRankingResult(a,n,o)
local e
if a then
e=RecordRanking.GetMissionLimitBordId(n)
else
e=RecordRanking.GetMissionBordId(n)
end
if e==RankingBordId.NONE then
return
end
mvars.rnk_missionClearRankingResult={e,o}
end
function e.SendCurrentRankingScore()
if RecordRanking.IsRankingBusy()then
return
end
local n={}
for o=1,(TppDefine.RANKING_MAX-1)do
if svars.rnk_isUpdated[o]then
local a=TppDefine.RANKING_ENUM[o]
local e=e.GetScore(a)
table.insert(n,{o,e})
end
end
if mvars.rnk_missionClearRankingResult then
table.insert(n,mvars.rnk_missionClearRankingResult)
end
RecordRanking.RegistRanking(n)
end
function e.CheckExcludeMission(n,o)
local e=e.EXCLUDE_MISSION_LIST[n]
if e then
return e[o]
end
return false
end
function e.UpdateScoreTime(n)
e.UpdateScore(n,svars.scoreTime)
end
function e.Messages()
return Tpp.StrCode32Table{Player={{msg="CBoxSlideEnd",func=e.OnCBoxSlideEnd}},GameObject={{msg="Neutralize",func=e.OnNeutralize},{msg="HeadShot",func=e.OnHeadShot}}}
end
function e.Init(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
local o={2250,2260,2270,2280,2290,2300,2310,2320,2330}
function e.CheckPlayRecordChallengeTask()
local e=TppTerminal.IsEqualOrMoreTotalFultonCount
local t={e,e,e,e,e,e,e,e,e}
local i={100,200,300,400,500,600,700,800,900}
local a={true,2250,2260,2270,2280,2290,2300,2310,2320}
local n={}
for e,o in ipairs(o)do
local t,a,e=t[e],i[e],a[e]
local a=t(a)
if e==true then
table.insert(n,{taskId=o,isVisible=true,isCompleted=a})
else
table.insert(n,{taskId=o,completedTaskIdForVisible=e,isCompleted=a})
end
end
return n
end
function e.OnReload(n)
e.Init(n)
end
function e.OnMessage(n,o,a,t,l,i,r)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,n,o,a,t,l,i,r)
end
function e.OnNeutralize(n,n,e,n)
if e==NeutralizeType.HOLDUP then
PlayRecord.RegistPlayRecord"PLAYER_HOLDUP"end
end
function e.OnHeadShot(o,o,n,e)
if not Tpp.IsPlayer(n)then
return
end
if bit.band(e,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)~=HeadshotMessageFlag.IS_JUST_UNCONSCIOUS then
return
end
if bit.band(e,HeadshotMessageFlag.IS_TRANQ_HANDGUN)==HeadshotMessageFlag.IS_TRANQ_HANDGUN then
PlayRecord.RegistPlayRecord"PLAYER_HEADSHOT_STUN"else
PlayRecord.RegistPlayRecord"PLAYER_HEADSHOT"end
end
function e.OnCBoxSlideEnd(n,e)
local e=e/10
PlayRecord.RegistPlayRecord("CBOX_SLIDING",e)
if(e>gvars.rnk_CboxGlidingDistance)then
gvars.rnk_CboxGlidingDistance=e
end
end
function e.DeclareSVars()
return{{name="rnk_isUpdated",arraySize=TppDefine.RANKING_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION}}
end
return e
