local e={}
local a=GameObject.SendCommand
local s=Tpp.IsTypeTable
local a,a,a=bit.band,bit.bor,bit.bxor
local a=TppDefine.MAX_32BIT_UINT
function e.SetMissionScoreTable(e)
if not s(e)then
return
end
mvars.res_missionScoreTable=e
end
function e.SetMissionFinalScore(a)
if mvars.res_noResult and a==TppDefine.MISSION_TYPE.STORY then
return
end
if not a then
return
end
e.SaveBestCount(a)
local s,t=e.CalcBaseScore()
e.CalcTimeScore(s,t)
e.CalcTotalScore(a)
local s=e.DecideMissionClearRank()
e.SetBestRank(a,s)
end
e.RANK_THRESHOLD={S=13e4,A=1e5,B=6e4,C=3e4,D=1e4,E=0}
e.RANK_BASE_SCORE={S=125e3,A=1e5,B=75e3,C=5e4,D=25e3,E=0}
function e.DeclareSVars()
return{{name="bestScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,server=true,category=TppScriptVars.CATEGORY_MISSION},{name="bestRank",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,server=true,category=TppScriptVars.CATEGORY_MISSION},{name="playCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="clearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noKillClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="stealthClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rankSClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="failedCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="retryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="gameOverCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="scoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,server=true,category=TppScriptVars.CATEGORY_MISSION},{name="playTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="squatTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="crawlTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="clearTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="shotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="headshotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="killCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="dyingCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="holdupCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="discoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="takeHitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="tacticalActionPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="traceCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="headshotCount2",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="useWeapon",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mbTerminalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="externalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="externalScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTimeScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="flagMissionTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,server=true,category=TppScriptVars.CATEGORY_MISSION},{name="baseDefenseTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.Init(a)
e.SetRankTable(e.RANK_THRESHOLD)
if a.sequence then
if a.sequence.NO_RESULT then
mvars.res_noResult=true
end
if a.sequence.NO_MISSION_CLEAR_RANK then
mvars.res_noMissionClearRank=true
end
mvars.res_rankLimitedSetting={}
if a.sequence.rankLimitedSetting then
mvars.res_rankLimitedSetting=a.sequence.rankLimitedSetting
end
end
if(TppMission.IsFreeMission(vars.missionCode)or TppMission.IsMultiPlayMission(vars.missionCode))or TppMission.IsAvatarEditMission(vars.missionCode)then
mvars.res_noResult=true
end
if mvars.res_noResult then
return
end
if a.score and a.score.missionScoreTable then
e.SetMissionScoreTable(a.score.missionScoreTable)
else
e.SetMissionScoreTable{baseTime={S=300,A=600,B=1800,C=5580,D=6480,E=8280}}
end
end
function e.OnReload(a)
e.Init(a)
end
function e.OnMessage(e,e,e,e,e,e,e)
end
function e.OnMissionCanStart()
end
function e.SetRankTable(e)
if not s(e)then
return
end
mvars.res_rankTable=e
end
function e.SaveBestCount(a)
local e=svars
e.bestScoreTime=0
if a==TppDefine.MISSION_TYPE.STORY then
e.bestScoreTime=e.scoreTime
elseif a==TppDefine.MISSION_TYPE.FLAG then
e.bestScoreTime=e.flagMissionTime
elseif a==TppDefine.MISSION_TYPE.DEFENSE then
e.bestScoreTime=e.baseDefenseTime
end
end
local i=1e3
function e.CalcBaseScore()
if not mvars.res_missionScoreTable then
return
end
local n=svars
local s
local a,t
local r=#TppDefine.MISSION_CLEAR_RANK_LIST
for e=1,r do
s=TppDefine.MISSION_CLEAR_RANK_LIST[e]
local s=mvars.res_missionScoreTable.baseTime[s]*i
if n.bestScoreTime<=s then
a=e
break
end
end
if a==nil then
a=r
end
t=e.RANK_BASE_SCORE[s]
return t,a
end
local i=1/1e3
local a=60
local t=(a*60)*5
local s=(a*60)*.25
local s=(a*60)*1
local s=(a*60)*4
local s=(a*60)*.5
function e.CalcTimeScore(n,r)
if not mvars.res_missionScoreTable then
return
end
local s=svars
local e=TppDefine.MISSION_CLEAR_RANK_LIST[r]
local e=mvars.res_missionScoreTable.baseTime[e]
local e=e-(s.bestScoreTime*i)
if e<0 then
e=0
end
local e=e*a
if r>TppDefine.MISSION_CLEAR_RANK.S then
if e>t then
e=t
end
end
s.bestScoreTimeScore=e+n
end
local a=999999
local r=-999999
function e.CalcTotalScore(t)
local e=0
local s=0
e=svars.bestScoreTimeScore
if e>=a then
e=a
elseif e<=r then
e=r
end
svars.bestScore=e
if s>=a then
s=a
elseif s<=0 then
s=0
end
local a
if t==TppDefine.MISSION_TYPE.STORY then
a=SsdMissionList.MISSION_ENUM[tostring(vars.missionCode)]
elseif t==TppDefine.MISSION_TYPE.FLAG then
a=SsdMissionList.MISSION_ENUM[tostring(gvars.fms_currentFlagMissionCode)]
end
if a then
if e>gvars.rnk_missionBestScore[a]then
gvars.rnk_missionBestScore[a]=e
end
end
end
function e.DecideMissionClearRank()
local e
local s=svars.bestScore
local a=#TppDefine.MISSION_CLEAR_RANK_LIST
if not mvars.res_noMissionClearRank then
for a=1,a do
local t=TppDefine.MISSION_CLEAR_RANK_LIST[a]
if s>=mvars.res_rankTable[t]then
e=a
break
end
end
if e==nil then
e=a
end
else
e=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED
end
svars.bestRank=e
return svars.bestRank
end
function e.SetBestRank(s,e)
if(e<TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED)or(e>#TppDefine.MISSION_CLEAR_RANK_LIST)then
return
end
local a
if s==TppDefine.MISSION_TYPE.STORY then
a=vars.missionCode
elseif s==TppDefine.MISSION_TYPE.FLAG then
a=gvars.fms_currentFlagMissionCode
else
return
end
local a=SsdMissionList.MISSION_ENUM[tostring(a)]
if not a then
return
end
if e<gvars.res_bestRank[a]then
gvars.res_bestRank[a]=e
end
end
function e.DEBUG_Init()
end
function e.DebugUpdate()
end
function e.Messages()
end
return e
