local e={}
local S=GameObject.SendCommand
local r=Tpp.IsTypeTable
local t,t,t=bit.band,bit.bor,bit.bxor
local s=TppDefine.MAX_32BIT_UINT
e.PLAYSTYLE_HEAD_SHOT=.9
e.RANK_THRESHOLD={S=13e4,A=1e5,B=6e4,C=3e4,D=1e4,E=0}
e.RANK_BASE_SCORE={S=11e4,A=9e4,B=7e4,C=5e4,D=3e4,E=0}
e.RANK_BASE_SCORE_10054={S=1e4,A=9e3,B=7e3,C=5e3,D=3e3,E=0}
e.RANK_BASE_SCORE_10040={S=2e4,A=18e3,B=14e3,C=1e4,D=6e3,E=0}
e.RANK_BASE_SCORE_10130={S=5e4,A=45e3,B=35e3,C=25e3,D=2e4,E=0}
e.RANK_BASE_SCORE_10140={S=1e5,A=8e4,B=65e3,C=5e4,D=35e3,E=0}
e.RANK_BASE_GMP={S=28e3,A=23400,B=2e4,C=18e3,D=13500,E=9999}
e.COMMON_SCORE_PARAM={noReflexBonus=1e4,noAlertBonus=5e3,noKillBonus=5e3,noRetryBonus=5e3,perfectStealthNoKillBonus=2e4,noTraceBonus=1e5,firstSpecialBonus=5e3,secondSpecialBonus=5e3,alertCount={valueToScoreRatio=-5e3},rediscoveryCount={valueToScoreRatio=-500},takeHitCount={valueToScoreRatio=-100},tacticalActionPoint={valueToScoreRatio=1e3},hostageCount={valueToScoreRatio=5e3},markingCount={valueToScoreRatio=30},interrogateCount={valueToScoreRatio=150},headShotCount={valueToScoreRatio=1e3},neutralizeCount={valueToScoreRatio=200}}
e.MISSION_GUARANTEE_GMP={[10010]=nil,[10020]=8e4,[10030]=nil,[10036]=9e4,[10043]=1e5,[10033]=1e5,[10040]=11e4,[10041]=11e4,[10044]=12e4,[10052]=12e4,[10054]=13e4,[10050]=13e4,[10070]=13e4,[10080]=15e4,[10082]=15e4,[10086]=15e4,[10090]=17e4,[10195]=17e4,[10091]=17e4,[10100]=17e4,[10110]=17e4,[10121]=17e4,[10115]=19e4,[10120]=19e4,[10085]=19e4,[10200]=19e4,[10211]=19e4,[10081]=19e4,[10130]=21e4,[10140]=21e4,[10150]=21e4,[10151]=21e4,[10045]=21e4,[10093]=25e4,[10156]=26e4,[10171]=28e4,[10240]=3e5,[10260]=6e5,[10280]=nil,[11043]=3e5,[11054]=42e4,[11082]=5e5,[11090]=5e5,[11033]=4e5,[11050]=52e4,[11140]=6e5,[11080]=6e5,[11121]=68e4,[11130]=68e4,[11044]=68e4,[11151]=82e4,[11041]=19e4,[11085]=35e4,[11036]=15e4,[11091]=31e4,[11195]=31e4,[11211]=35e4,[11200]=35e4,[11171]=43e4,[11115]=35e4,[10230]=23e4}
e.MISSION_TASK_LIST={[10010]={0,1},[10020]={0,1,2,3,4,5},[10030]={0,1,2,3,4},[10036]={0,1,2,3,4},[10043]={0,1,2,3,4,5},[10033]={0,1,2,3,4},[10040]={0,1,2,3,4,5},[10041]={0,1,2,3,4,5,6},[10044]={0,2,3,4,5,6,7},[10050]={0,1,2,5},[10052]={1,2,3,4,5},[10054]={0,1,2,3,4,5,6,7},[10070]={0,1,2,3,4,5},[10080]={0,1,2,3,4,5},[10086]={0,1,2,3,4,5,6},[10082]={1,2,3,4,5},[10090]={0,1,2,3,4,5,6,7},[10195]={0,1,2,3,4,5,6},[10091]={1,3,4,5,6,7},[10100]={0,1,2,3,4,5,6,7},[10110]={0,1,2,3,4,5},[10121]={0,1,2,3,4,5,6,7},[10115]={0},[10120]={1,2,3,4,5},[10085]={0,1,2,3,4,5,6},[10200]={2,3,4,5,6,7},[10211]={0,2,3,4,5,6},[10081]={1,2,3},[10130]={0,1,2,3,4,5},[10140]={0,1,2,3},[10150]={0,1,2,3,4,5},[10151]={0,1,2},[10045]={1,2,3,4,5,6},[10156]={0,1,2,3,4},[10093]={0,2,3,4,5,6},[10171]={0,1,3,4,5,6,7},[10240]={0,1},[10260]={0,1,2,3,4},[10280]={0,1}}
e.HARD_MISSION_LIST={11043,11041,11054,11085,11082,11090,11036,11033,11050,11091,11195,11211,11140,11200,11080,11171,11121,11115,11130,11044,11052,11151}
for a,t in ipairs(e.HARD_MISSION_LIST)do
local a=TppDefine.MISSING_NUMBER_MISSION_ENUM[tostring(t)]
if not a then
e.MISSION_TASK_LIST[t]=e.MISSION_TASK_LIST[t-1e3]
end
end
e.NO_SPECIAL_BONUS={[10030]=true,[10115]=true,[10240]=true}
function e.AcquireSpecialBonus(t)
if not r(t)then
return
end
if t.first then
if mvars.res_isExistFirstSpecialBonus then
e._AcquireSpecialBonus(t.first,"bestScoreBounus","bestScoreBounusScore",mvars.res_firstSpecialBonusMaxCount,e.COMMON_SCORE_PARAM.firstSpecialBonus,"isCompleteFirstBonus",mvars.res_firstBonusMissionTask,mvars.res_firstSpecialBonusPointList,"isAcquiredFirstBonusInPointList")
end
end
if t.second then
if mvars.res_isExistSecondSpecialBonus then
e._AcquireSpecialBonus(t.second,"bestScoreBounus2","bestScoreBounusScore2",mvars.res_secondSpecialBonusMaxCount,e.COMMON_SCORE_PARAM.secondSpecialBonus,"isCompleteSecondBonus",mvars.res_secondBonusMissionTask,mvars.res_secondSpecialBonusPointList,"isAcquiredSecondBonusInPointList")
end
end
end
function e._AcquireSpecialBonus(t,a,o,s,c,u,i,n,l)
local r=t.isComplete
if t.isComplete then
r=true
if(not n)and(not s)then
svars[o]=c
end
end
if t.count then
if not s then
return
end
if svars[a]<t.count then
if t.count<=s then
svars[a]=t.count
else
svars[a]=s
end
svars[o]=(svars[a]/s)*c
if svars[a]==s then
r=true
end
end
end
if t.pointIndex then
if not n then
return
end
local t=t.pointIndex
if not Tpp.IsTypeNumber(t)then
return
end
if t<1 then
return
end
if t>#n then
return
end
svars[l][t]=true
local e,t=e.CalcPoinListBonusScore(n,l)svars[a]=e
svars[o]=t
if svars[a]==#n then
r=true
end
end
if r then
e._CompleteBonus(u,i)
else
i.isHide=false
TppUI.EnableMissionTask(i)
end
end
function e.CalcPoinListBonusScore(a,s)
local t=0
local e=0
for a,n in ipairs(a)do
if svars[s][a]then
t=t+1
e=e+n
end
end
return t,e
end
function e.SetSpecialBonusMaxCount(e)
if not Tpp.IsTypeTable(e)then
return
end
if e.first and e.first.maxCount then
mvars.res_firstSpecialBonusMaxCount=e.first.maxCount
end
if e.second and e.second.maxCount then
mvars.res_secondSpecialBonusMaxCount=e.second.maxCount
end
end
function e._CompleteBonus(a,e)
local t=true
if svars[a]then
t=false
end
svars[a]=true
if e then
e.isComplete=true
TppUI.EnableMissionTask(e,t)
end
end
function e.RegistNoMissionClearRank()
mvars.res_noMissionClearRank=true
end
function e.SetMissionScoreTable(e)
if not r(e)then
return
end
mvars.res_missionScoreTable=e
end
function e.SetMissionFinalScore()
if mvars.res_noResult then
return
end
e.RegistUsedLimitedItemLangId()
TppBuddyService.BuddyProcessMissionSuccess()
e.SaveBestCount()
local t,a=e.CalcBaseScore()
e.CalcTimeScore(t,a)
e.CalcEachScore()
local n=e.CalcTotalScore()
local t=e.DecideMissionClearRank()
local a
if TppMission.IsFOBMission(vars.missionCode)then
return
end
Tpp.IncrementPlayData"totalMissionClearCount"e.SetSpecialBonusResultScore()
if t~=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
TppHero.MissionClear(t)
end
if t==TppDefine.MISSION_CLEAR_RANK.S then
TppEmblem.AcquireOnSRankClear(vars.missionCode)
end
TppMotherBaseManagement.AwardedMeritMedalPointToPlayerStaff{clearRank=t}
if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP then
if gvars.chickenCapClearCount<s then
gvars.chickenCapClearCount=gvars.chickenCapClearCount+1
end
end
if(vars.playerType==PlayerType.DD_MALE or vars.playerType==PlayerType.DD_FEMALE)then
TppTrophy.Unlock(11)
end
a=e.UpdateGmpOnMissionClear(vars.missionCode,t,n)
if vars.totalBatteryPowerAsGmp then
TppTerminal.UpdateGMP{gmp=vars.totalBatteryPowerAsGmp}
end
e.SetBestRank(vars.missionCode,t)
if a then
local t=e.CalcMissionClearHistorySize()
e.SetMissionClearHistorySize(t)
e.AddMissionClearHistory(vars.missionCode)
end
if vars.missionCode==10020 then
if TppStory.GetCurrentStorySequence()==TppDefine.STORY_SEQUENCE.CLEARD_RECUE_MILLER then
local e=TppMotherBaseManagement.GetGmp()
gvars.firstRescueMillerClearedGMP=e
end
end
if mvars.res_enablePlayStyle then
e.SaveMissionClearPlayStyleParameter()svars.playStyle=e.DecidePlayStyle()
TppEmblem.AcquireByPlayStyle(svars.playStyle)
e.AddNewPlayStyleHistory()
else
svars.playStyle=0
e.ClearNewestPlayStyleHistory()
end
end
function e.IsUsedChickCap()
if bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICK_CAP)==PlayerPlayFlag.USE_CHICK_CAP then
return true
else
return false
end
end
function e.RegistUsedLimitedItemLangId()
mvars.res_isUsedRankLimitedItem=false
local e={{PlayerPlayFlag.USE_CHICKEN_CAP,"name_st_chiken"},{PlayerPlayFlag.USE_STEALTH,"name_it_12043"},{PlayerPlayFlag.USE_INSTANT_STEALTH,"name_it_12040"},{PlayerPlayFlag.USE_FULTON_MISSILE,"name_dw_31007"},{PlayerPlayFlag.USE_PARASITE_CAMO,"name_it_13050"},{PlayerPlayFlag.USE_MUGEN_BANDANA,"name_st_37002"}}
for t,e in ipairs(e)do
local e,t=e[1],e[2]
if e then
if bit.band(vars.playerPlayFlag,e)==e then
mvars.res_isUsedRankLimitedItem=true
TppUiCommand.SetResultScore(t,"ranklimited")
end
end
end
if svars.isUsedSupportHelicopterAttack then
if not mvars.res_rankLimitedSetting.permitSupportHelicopterAttack then
mvars.res_isUsedRankLimitedItem=true
TppUiCommand.SetResultScore("func_heli_attack","ranklimited")
end
end
if svars.isUsedFireSupport then
if not mvars.res_rankLimitedSetting.permitFireSupport then
mvars.res_isUsedRankLimitedItem=true
TppUiCommand.SetResultScore("func_spprt_battle","ranklimited")
end
end
end
function e.IsUsedRankLimitedItem()
return mvars.res_isUsedRankLimitedItem
end
function e.DeclareSVars()
return{{name="bestScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestRank",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="playCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="clearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noAlertClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="noKillClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="stealthClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rankSClearCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="failedCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="timeParadoxCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="retryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="gameOverCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="scoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="playTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_RETRY},{name="squatTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="crawlTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="clearTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="shotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="headshotCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="killCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="dyingCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="holdupCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="stunCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="sleepCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="interrogationCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="discoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="alertCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="oldTakeHitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="takeHitCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="reflexCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="rediscoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="tacticalActionPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="traceCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="headshotCount2",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="neutralizeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="shootNeutralizeCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="destroyVehicleCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="destroyHeriCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="ratCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="crowCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="useWeapon",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="hostageCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="soldierCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="markingEnemyCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="mbTerminalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="externalCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="externalScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="reinforceCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="stealthAssistCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="interrogateCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="supportGmpCost",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="heroicPointDiff",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="gmpDiamond",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="gmpAnimal",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreAlert",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreKill",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreHostage",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreGameOver",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreBounus",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreBounus2",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="isAcquiredFirstBonusInPointList",type=TppScriptVars.TYPE_BOOL,value=false,save=true,arraySize=16,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="isAcquiredSecondBonusInPointList",type=TppScriptVars.TYPE_BOOL,value=false,save=true,arraySize=16,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="isCompleteFirstBonus",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="isCompleteSecondBonus",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreRediscoveryCount",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTacticalActionPoint",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTimeScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreAlertScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreKillScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreHostageScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreGameOverScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreRediscoveryCountScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTakeHitCountScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreTacticalActionPointScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreBounusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreBounusScore2",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreNoKillScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreNoRetryScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreNoReflexScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScorePerfectStealthNoKillBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreNoTraceBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreDeductScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreMarkingCountScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreInterrogateScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreHeadShotBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreNeutralizeBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="bestScoreHitRatioBonusScore",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="gmpClear",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="gmpOutcome",type=TppScriptVars.TYPE_INT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="playStyle",type=TppScriptVars.TYPE_INT8,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="isUsedSupportHelicopterAttack",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="isUsedFireSupport",type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="questScoreTime",type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function e.Init(t)
e.SetRankTable(e.RANK_THRESHOLD)
e.SetScoreTable(e.COMMON_SCORE_PARAM)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
if TppUiCommand.RegisterMbMissionListFunction then
if TppUiCommand.IsTppUiReady()then
TppUiCommand.RegisterMbMissionListFunction("TppResult","GetMbMissionListParameterTable")
end
end
do
for t,e in ipairs{10043,11043}do
local e=TppDefine.MISSION_ENUM[tostring(e)]
if gvars.res_bestRank[e]==TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
gvars.res_bestRank[e]=TppDefine.MISSION_CLEAR_RANK.E+1
end
end
end
if t.sequence then
if t.sequence.NO_TAKE_HIT_COUNT then
mvars.res_noTakeHitCount=true
end
if t.sequence.NO_TACTICAL_TAKE_DOWN then
mvars.res_noTacticalTakeDown=true
end
if t.sequence.NO_RESULT then
mvars.res_noResult=true
mvars.res_noTakeHitCount=true
mvars.res_noTacticalTakeDown=true
end
if t.sequence.NO_PLAY_STYLE then
mvars.res_enablePlayStyle=false
else
mvars.res_enablePlayStyle=true
end
if t.sequence.NO_AQUIRE_GMP then
mvars.res_noAquireGmp=true
end
if t.sequence.NO_MISSION_CLEAR_RANK then
mvars.res_noMissionClearRank=true
end
if t.sequence.specialBonus then
local e=t.sequence.specialBonus.first
if e then
mvars.res_isExistFirstSpecialBonus=true
if e.maxCount then
mvars.res_firstSpecialBonusMaxCount=e.maxCount
end
local t=e.missionTask
if t then
mvars.res_firstBonusMissionTask={}
for t,e in pairs(t)do
mvars.res_firstBonusMissionTask[t]=e
end
mvars.res_firstBonusMissionTask.isFirstHide=true
end
if e.pointList then
if Tpp.IsTypeTable(e.pointList)then
mvars.res_firstSpecialBonusPointList=e.pointList
mvars.res_firstSpecialBonusMaxCount=#e.pointList
end
end
end
local e=t.sequence.specialBonus.second
if e then
mvars.res_isExistSecondSpecialBonus=true
if e.maxCount then
mvars.res_secondSpecialBonusMaxCount=e.maxCount
end
local t=e.missionTask
if t then
mvars.res_secondBonusMissionTask={}
for e,t in pairs(t)do
mvars.res_secondBonusMissionTask[e]=t
end
mvars.res_secondBonusMissionTask.isFirstHide=true
end
if e.pointList then
if Tpp.IsTypeTable(e.pointList)then
mvars.res_secondSpecialBonusPointList=e.pointList
mvars.res_secondSpecialBonusMaxCount=#e.pointList
end
end
end
end
mvars.res_rankLimitedSetting={}
if t.sequence.rankLimitedSetting then
mvars.res_rankLimitedSetting=t.sequence.rankLimitedSetting
end
mvars.res_hitRatioBonusParam={hitRatioBaseScoreUnit=30,numOfBulletsPerNeutralizeCount=10,exponetHitRatio=6,limitHitRatioBonus=1e3,perfectBonusBase=3e4}
if t.sequence.hitRatioBonusParam then
for e,t in pairs(t.sequence.hitRatioBonusParam)do
mvars.res_hitRatioBonusParam[e]=t
end
end
end
if TppMission.IsHelicopterSpace(vars.missionCode)or TppMission.IsFreeMission(vars.missionCode)then
mvars.res_noResult=true
end
if mvars.res_noResult then
return
end
if t.score and t.score.missionScoreTable then
e.SetMissionScoreTable(t.score.missionScoreTable)
else
e.SetMissionScoreTable{baseTime={S=300,A=600,B=1800,C=5580,D=6480,E=8280},tacticalTakeDownPoint={countLimit=40},missionUniqueBonus={5e3,5e3}}
end
mvars.res_bonusMissionClearTimeRatio=mvars.res_missionScoreTable.baseTime.S/600
if mvars.res_bonusMissionClearTimeRatio<1 then
mvars.res_bonusMissionClearTimeRatio=1
end
end
function e.OnReload(t)
e.Init(t)
end
function e.OnMessage(o,t,i,a,r,n,s)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,o,t,i,a,r,n,s)
end
function e.OnMissionCanStart()
if mvars.res_firstBonusMissionTask then
if svars.isCompleteFirstBonus then
e._CompleteBonus("isCompleteFirstBonus",mvars.res_firstBonusMissionTask)
else
TppUI.EnableMissionTask(mvars.res_firstBonusMissionTask,false)
end
end
if mvars.res_secondBonusMissionTask then
if svars.isCompleteSecondBonus then
e._CompleteBonus("isCompleteSecondBonus",mvars.res_secondBonusMissionTask)
else
TppUI.EnableMissionTask(mvars.res_secondBonusMissionTask,false)
end
end
end
function e.SetScoreTable(e)
if not r(e)then
return
end
mvars.res_scoreTable=e
end
function e.SetRankTable(t)
if not r(t)then
return
end
mvars.res_rankTable=t
end
e.saveCountTable={{"bestScoreTime","scoreTime"},{"bestScoreAlert","alertCount"},{"bestScoreKill","killCount"},{"bestScoreHostage","hostageCount"},{"bestScoreGameOver","failedCount"},{"bestScoreGameOver","timeParadoxCount"},{"bestScoreTacticalActionPoint","tacticalActionPoint"}}
function e.SaveBestCount()
local t=svars
for a,e in pairs(e.saveCountTable)do
t[e[1]]=0
end
for a,e in pairs(e.saveCountTable)do
t[e[1]]=t[e[1]]+t[e[2]]
end
end
function e.DEBUG_Count()
for e,e in pairs(e.saveCountTable)do
end
end
local o=1e3
function e.CalcBaseScore()
if not mvars.res_missionScoreTable then
return
end
local i=svars
local s
local n,t
local a=TppMission.GetMissionName()
local r=#TppDefine.MISSION_CLEAR_RANK_LIST
for e=1,r do
s=TppDefine.MISSION_CLEAR_RANK_LIST[e]
local t=mvars.res_missionScoreTable.baseTime[s]*o
if i.bestScoreTime<=t then
n=e
break
end
end
if n==nil then
n=r
end
if a=="s10040"then
t=e.RANK_BASE_SCORE_10040[s]
elseif a=="s10054"or a=="s11054"then
t=e.RANK_BASE_SCORE_10054[s]
elseif a=="s10130"or a=="s11130"then
t=e.RANK_BASE_SCORE_10130[s]
elseif a=="s10140"or a=="s11140"then
t=e.RANK_BASE_SCORE_10140[s]
else
t=e.RANK_BASE_SCORE[s]
end
if e.IsUsedChickCap()then
t=0
n=TppDefine.MISSION_CLEAR_RANK.E
end
return t,n
end
local a=1/1e3
local t=60
local n=(t*60)*5
local i=(t*60)*.25
local o=(t*60)*1
local c=(t*60)*4
local u=(t*60)*.5
function e.CalcTimeScore(r,l)
if not mvars.res_missionScoreTable then
return
end
local s=svars
local S=TppDefine.MISSION_CLEAR_RANK_LIST[l]
local S=mvars.res_missionScoreTable.baseTime[S]
local a=S-(s.bestScoreTime*a)
if a<0 then
a=0
end
local t=a*t
local a=TppMission.GetMissionName()
if l>TppDefine.MISSION_CLEAR_RANK.S then
if a=="s10040"then
if t>u then
t=u
end
elseif a=="s10054"or a=="s11054"then
if t>i then
t=i
end
elseif a=="s10130"or a=="s11130"then
if t>o then
t=o
end
elseif a=="s10140"or a=="s11140"then
if t>c then
t=c
end
else
if t>n then
t=n
end
end
end
if e.IsUsedChickCap()then
t=0
r=0
end
s.bestScoreTimeScore=t+r
end
e.calcScoreTable={bestScoreAlertScore={"alertCount","bestScoreAlert"},bestScoreHostageScore={"hostageCount","bestScoreHostage"},bestScoreTakeHitCountScore={"takeHitCount","takeHitCount"},bestScoreTacticalActionPointScore={"tacticalActionPoint","tacticalActionPoint","tacticalTakeDownPoint"},bestScoreMarkingCountScore={"markingCount",vars="playerMarkingCountInMission"},bestScoreInterrogateScore={"interrogateCount","interrogateCount"},bestScoreHeadShotBonusScore={"headShotCount","headshotCount2"},bestScoreNeutralizeBonusScore={"neutralizeCount","neutralizeCount"}}
e.bonusScoreTable={bestScoreNoReflexScore={"reflexCount","noReflexBonus",nil},bestScoreAlertScore={"alertCount","noAlertBonus",true},bestScoreKillScore={"bestScoreKill","noKillBonus",nil},bestScoreNoRetryScore={"retryCount","noRetryBonus",true},bestScorePerfectStealthNoKillBonusScore={{"alertCount","bestScoreKill","reflexCount"},"perfectStealthNoKillBonus",true}}
function e.CalcEachScore()
local t=svars
for n,a in pairs(e.calcScoreTable)do
local s
if a.vars then
s=vars[a.vars]
else
s=t[a[2]]
end
t[n]=e.CalcScore(s,mvars.res_scoreTable[a[1]],mvars.res_missionScoreTable[a[3]])
end
if not e.IsUsedChickCap()then
for n,e in pairs(e.bonusScoreTable)do
local a
if r(e[1])then
a=e[1]
else
a={e[1]}
end
local s=true
for a,e in ipairs(a)do
if t[e]>0 then
s=false
break
end
end
local a=1
if e[3]then
a=mvars.res_bonusMissionClearTimeRatio
end
if s and(not isUsedChickCap)then
t[n]=mvars.res_scoreTable[e[2]]*a
end
end
t.bestScoreHitRatioBonusScore=e.CalcHitRatioBonusScore(vars.shootHitCountInMission,vars.playerShootCountInMission,vars.shootHitCountEliminatedInMission,t.shootNeutralizeCount,mvars.res_hitRatioBonusParam.hitRatioBaseScoreUnit,mvars.res_hitRatioBonusParam.numOfBulletsPerNeutralizeCount,mvars.res_hitRatioBonusParam.exponetHitRatio,mvars.res_hitRatioBonusParam.limitHitRatioBonus,mvars.res_hitRatioBonusParam.perfectBonusBase)
if bit.band(vars.playerPlayFlag,PlayerPlayFlag.FAILED_NO_TRACE_PLAY)==0 then
t.bestScoreNoTraceBonusScore=mvars.res_scoreTable.noTraceBonus*mvars.res_bonusMissionClearTimeRatio
end
end
end
local r=999999
local i=-999999
function e.CalcScore(s,a,n)
local t=a.unitValue or 1
local s=s/t
local t=0
local o=a.valueToScoreRatio or 1
local a=999999
if n and n.countLimit then
a=n.countLimit
end
if s>a then
s=a
end
t=s*o
if t<i then
t=i
elseif t>r then
t=r
end
if e.IsUsedChickCap()then
t=0
end
return t
end
function e.CalcHitRatioBonusScore(o,t,r,a,l,u,c,s,n)
local t=t-r
if t<=0 then
return 0
end
local r=t
local i=o/r
if a<1 then
a=.5
end
local t=(((l*2)*r)/(a*u))*(i^c)
local t=(l+t)*o
if t>(a*s)then
t=a*s
end
local s
if i>=1 then
s=(((n/2)*a)/10)*(a/r)
if s>n then
s=n
end
t=t+s
end
t=math.ceil(t)
return t
end
e.playScoreList={"bestScoreTimeScore","bestScoreTakeHitCountScore","bestScoreTacticalActionPointScore","bestScoreHeadShotBonusScore","bestScoreHitRatioBonusScore","bestScoreNeutralizeBonusScore","bestScoreMarkingCountScore","bestScoreInterrogateScore","bestScoreHostageScore"}
e.bounusScoreList={"bestScoreBounusScore","bestScoreBounusScore2","bestScoreNoRetryScore","bestScoreKillScore","bestScoreNoReflexScore","bestScoreAlertScore","bestScorePerfectStealthNoKillBonusScore","bestScoreNoTraceBonusScore"}
local n=999999
local r=-999999
function e.CalcTotalScore()
local t=0
local a=0
for a,e in pairs(e.playScoreList)do
local a=svars[e]t=t+svars[e]
end
for s,e in pairs(e.bounusScoreList)do
local s=svars[e]t=t+svars[e]a=a+svars[e]
end
if t>=n then
t=n
elseif t<=r then
t=r
end
if e.IsUsedChickCap()then
t=0
a=0
end
svars.bestScore=t
if a>=n then
a=n
elseif a<=0 then
a=0
end
local s=TppDefine.MISSION_ENUM[tostring(vars.missionCode)]
if s then
local e=e.IsUsedRankLimitedItem()
if e then
if t>gvars.rnk_missionBestScoreUsedLimitEquip[s]then
gvars.rnk_missionBestScoreUsedLimitEquip[s]=t
end
else
if t>gvars.rnk_missionBestScore[s]then
gvars.rnk_missionBestScore[s]=t
end
end
if not(((vars.missionCode==10043)or(vars.missionCode==11043))and mvars.res_noMissionClearRank)then
TppRanking.RegistMissionClearRankingResult(e,vars.missionCode,t)
end
end
return a
end
function e.DecideMissionClearRank()
local t
local s=svars.bestScore
local a=#TppDefine.MISSION_CLEAR_RANK_LIST
if not mvars.res_noMissionClearRank then
for e=1,a do
local a=TppDefine.MISSION_CLEAR_RANK_LIST[e]
if s>=mvars.res_rankTable[a]then
t=e
break
end
end
if t==nil then
t=a
end
else
t=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED
end
if e.IsUsedRankLimitedItem()then
if t==TppDefine.MISSION_CLEAR_RANK.S then
t=TppDefine.MISSION_CLEAR_RANK.A
end
end
svars.bestRank=t
return svars.bestRank
end
function e.UpdateGmpOnMissionClear(t,a,n)
local s=e.MISSION_GUARANTEE_GMP[t]
if not s then
return
end
if t==10020 and(not TppStory.IsMissionCleard(t))then
return
end
local s=e.GetMissionGuaranteeGMP(t)svars.gmpClear=TppTerminal.CorrectGMP{gmp=s}
if a~=TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
local e=e.GetMissionClearRankGMP(a,t)e=e+n
svars.gmpOutcome=TppTerminal.CorrectGMP{gmp=e}
else
svars.gmpOutcome=0
end
local e=svars.gmpClear+svars.gmpOutcome
TppTerminal.UpdateGMP{gmp=e,withOutAnnouceLog=true}
return e
end
function e.SetBestRank(t,e)
local a=TppDefine.MISSION_ENUM[tostring(t)]
if not a then
return
end
if(e<TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED)or(e>#TppDefine.MISSION_CLEAR_RANK_LIST)then
return
end
if((t==10043)or(t==11043))and(e==TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED)then
return
end
if e<gvars.res_bestRank[a]then
gvars.res_bestRank[a]=e
end
end
function e.GetBestRank(e)
local e=TppDefine.MISSION_ENUM[tostring(e)]
if not e then
return
end
return gvars.res_bestRank[e]
end
function e.GetMissionClearRankGMP(n,t)
local s=e.GetBestRank(t)
if not s then
return 0
end
local r=e.GetRepeatPlayGMPReduceRatio(t)
local t=0
local a=#TppDefine.MISSION_CLEAR_RANK_LIST
for a=a,n,-1 do
local n=TppDefine.MISSION_CLEAR_RANK_LIST[a]
local e=e.RANK_BASE_GMP[n]
if a<s then
t=t+e
else
t=t+e*r
end
end
return t
end
function e.GetMbMissionListParameterTable()
local s={}
for t,a in pairs(TppDefine.MISSION_ENUM)do
local t=tonumber(t)
local a={}a.missionId=t
if e.MISSION_GUARANTEE_GMP[t]then
a.baseGmp=e.MISSION_GUARANTEE_GMP[t]a.currentGmp=e.GetMissionGuaranteeGMP(t)
end
if e.MISSION_TASK_LIST[t]then
a.completedTaskNum=TppUI.GetTaskCompletedNumber(t)a.maxTaskNum=#e.MISSION_TASK_LIST[t]a.taskList=e.MISSION_TASK_LIST[t]
end
table.insert(s,a)
end
return s
end
function e.GetMissionGuaranteeGMP(t)
local s=e.MISSION_GUARANTEE_GMP[t]
local a=e.GetRepeatPlayGMPReduceRatio(t)
local t
if e.IsUsedChickCap()then
t=(s*a)/2
else
t=s*a
end
return t
end
local a=.5
function e.GetRepeatPlayGMPReduceRatio(t)
local e=e.GetMissionClearCountFromHistory(t)
local e=a^e
return e
end
local a=0
function e.AddMissionClearHistory(a)
local t=gvars.res_missionClearHistorySize-1
for e=t,0,-1 do
gvars.res_missionClearHistory[e+1]=gvars.res_missionClearHistory[e]
end
gvars.res_missionClearHistory[0]=a
e.ClearOverSizeHistory(gvars.res_missionClearHistorySize)
end
function e.GetMissionClearCountFromHistory(a)
local e=0
local t=gvars.res_missionClearHistorySize-1
for t=0,t do
if gvars.res_missionClearHistory[t]==a then
e=e+1
end
end
return e
end
local n=.6
function e.CalcMissionClearHistorySize()
local t=TppStory.GetOpenMissionCount()
local e
if t<=1 then
e=1
else
e=math.floor(t*n)
end
return e
end
function e.SetMissionClearHistorySize(t)
if t>=TppDefine.MISSION_CLEAR_HISTORY_LIMIT then
return
end
gvars.res_missionClearHistorySize=t
e.ClearOverSizeHistory(t)
end
function e.ClearOverSizeHistory(e)
for e=e,TppDefine.MISSION_CLEAR_HISTORY_LIMIT-1 do
gvars.res_missionClearHistory[e]=a
end
end
function e.SetSpecialBonusResultScore()
if e.NO_SPECIAL_BONUS[vars.missionCode]then
TppUiCommand.SetResultScore("invalid","bonus",0)
TppUiCommand.SetResultScore("invalid","bonus",1)
return
end
if mvars.res_isExistFirstSpecialBonus then
e._SetSpecialBonusResultScore(0,"bestScoreBounus","bestScoreBounusScore",mvars.res_firstSpecialBonusMaxCount,e.COMMON_SCORE_PARAM.firstSpecialBonus,"isCompleteFirstBonus",mvars.res_firstBonusMissionTask)
end
if mvars.res_isExistSecondSpecialBonus then
e._SetSpecialBonusResultScore(1,"bestScoreBounus2","bestScoreBounusScore2",mvars.res_secondSpecialBonusMaxCount,e.COMMON_SCORE_PARAM.secondSpecialBonus,"isCompleteSecondBonus",mvars.res_secondBonusMissionTask)
end
end
function e._SetSpecialBonusResultScore(t,i,n,r,s,o,a)
if not a.taskNo then
TppUiCommand.SetResultScore("invalid","bonus",t)
return
end
local s=e.MakeMissionTaskLangId(a.taskNo)
local a=svars[i]
if(not svars[o])and(a==0)then
TppUiCommand.SetResultScore("invalid","bonus",t)
return
end
local n=svars[n]
local e=-1
if a>0 then
e=a
end
if e==-1 then
TppUiCommand.SetResultScore(s,"bonus",t,e,n)
else
TppUiCommand.SetResultScore(s,"bonus_rate",t,e,r,n)
end
end
function e.MakeMissionTaskLangId(t)
local e=vars.missionCode
if(e>=11e3)and(e<12e3)then
e=e-1e3
end
return"task_mission_"..(string.format("%02d",vars.locationCode)..("_"..(tostring(e)..("_"..string.format("%02d",t)))))
end
function e.SaveMissionClearPlayStyleParameter()
if svars.bestScorePerfectStealthNoKillBonusScore>0 then
gvars.res_isPerfectStealth[0]=true
Tpp.IncrementPlayData"totalPerfectStealthMissionClearCount"elseif svars.alertCount==0 then
gvars.res_isStealth[0]=true
Tpp.IncrementPlayData"totalStealthMissionClearCount"end
end
function e.DecidePlayStyle()
local t=TppStory.GetCurrentStorySequence()
if t<TppDefine.STORY_SEQUENCE.CLEARD_FIND_THE_SECRET_WEAPON then
return 1
end
if vars.playerPlayFlag then
if(bit.band(vars.playerPlayFlag,PlayerPlayFlag.USE_CHICKEN_CAP)==PlayerPlayFlag.USE_CHICKEN_CAP)then
return 2
end
end
local t=true
for e=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
if gvars.res_isPerfectStealth[e]==false then
t=false
break
end
end
if t then
return 3
end
local t=true
for e=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
if gvars.res_isStealth[e]==false then
t=false
break
end
end
if t then
return 4
end
local a,t=e.GetTotalHeadShotCount(),e.GetTotalNeutralizeCount()
if t<1 then
t=1
end
local t=a/t
if t>=e.PLAYSTYLE_HEAD_SHOT then
return 6
end
return e.DecideNeutralizePlayStyle()
end
function e.DEBUG_Init()
mvars.debug.showHitRatio=false;(nil).AddDebugMenu("LuaMission","RES.hitRatio","bool",mvars.debug,"showHitRatio")
mvars.debug.showMissionClearHistory=false;(nil).AddDebugMenu("LuaMission","RES.clearHistory","bool",mvars.debug,"showMissionClearHistory")
mvars.debug.showMissionScoreTable=false;(nil).AddDebugMenu("LuaMission","RES.scoreTable","bool",mvars.debug,"showMissionScoreTable")
mvars.debug.showPlayData=false;(nil).AddDebugMenu("LuaMission","RES.showPlayData","bool",mvars.debug,"showPlayData")
mvars.debug.showPlayStyleHistory=false;(nil).AddDebugMenu("LuaMission","showPlayStyleHistory","bool",mvars.debug,"showPlayStyleHistory")
mvars.debug.showPlayDataNeutralizeCount=false;(nil).AddDebugMenu("LuaMission","showPlayDataNeutralizeCount","bool",mvars.debug,"showPlayDataNeutralizeCount")
mvars.debug.doForceSetPlayStyle=false;(nil).AddDebugMenu("LuaMission","doForceSetStyle","bool",mvars.debug,"doForceSetPlayStyle")
mvars.debug.playStyleHistory=0;(nil).AddDebugMenu("LuaMission","styleHistory","int32",mvars.debug,"playStyleHistory")
mvars.debug.playStyleIsPerfectStealth=false;(nil).AddDebugMenu("LuaMission","styleIsPerfectStealth","bool",mvars.debug,"playStyleIsPerfectStealth")
mvars.debug.playStyleIsStealth=false;(nil).AddDebugMenu("LuaMission","styleIsStealth","bool",mvars.debug,"playStyleIsStealth")
mvars.debug.playStyleHeadShotCount=0;(nil).AddDebugMenu("LuaMission","styleHeadShotCount","int32",mvars.debug,"playStyleHeadShotCount")
mvars.debug.playStyleSaveIndex=-1;(nil).AddDebugMenu("LuaMission","styleSaveIndex","int32",mvars.debug,"playStyleSaveIndex")
mvars.debug.playStyleNeutralizeCount=0;(nil).AddDebugMenu("LuaMission","styleNeutralizeCount","int32",mvars.debug,"playStyleNeutralizeCount")
mvars.debug.addNewPlayStyleHistory=false;(nil).AddDebugMenu("LuaMission","addNewPlayStyleHistory","bool",mvars.debug,"addNewPlayStyleHistory")
mvars.debug.beforeMaxPlayRecord=false;(nil).AddDebugMenu("LuaMission","beforeMaxPlayRecord","bool",mvars.debug,"beforeMaxPlayRecord")
end
e.DEBUG_NEUTRALIZE_TYPE_TEXT={" HOLDUP","    CQC","NO_KILL","  KNIFE","HANDGUN","SUBMGUN","SHOTGUN","ASSAULT","MCH_GUN"," SNIPER","MISSILE","GRENADE","   MINE","  QUIET","  D_DOG","D_HORSE","D_WLKER","VEHICLE","SP_HELI"," ASSIST"}
function e.DebugUpdate()
local n=5
local s=svars
local a=mvars
local t=(nil).NewContext()
if a.debug.showHitRatio then
local e=vars.playerShootCountInMission-vars.shootHitCountEliminatedInMission
local a=0
if e>0 then
a=vars.shootHitCountInMission/e
end(nil).Print(t,{.5,.5,1},"LuaMission RES.hitRatio");(nil).Print(t,"vars.playerShootCountInMission = "..tostring(vars.playerShootCountInMission));(nil).Print(t,"vars.shootHitCountInMission = "..tostring(vars.shootHitCountInMission));(nil).Print(t,"vars.shootHitCountEliminatedInMission = "..tostring(vars.shootHitCountEliminatedInMission));(nil).Print(t,"valid shoot count = "..tostring(e));(nil).Print(t,"hitRatio = "..tostring(a));(nil).Print(t,"svars.headshotCount2 = "..tostring(s.headshotCount2));(nil).Print(t,"svars.neutralizeCount = "..tostring(s.neutralizeCount));(nil).Print(t,"svars.shootNeutralizeCount = "..tostring(s.shootNeutralizeCount))
end
if a.debug.showMissionClearHistory then(nil).Print(t,{.5,.5,1},"LuaMission RES.clearHistory");(nil).Print(t,"historySize = "..tostring(gvars.res_missionClearHistorySize))
local a={}
local s,e=0,1
local r=gvars.res_missionClearHistorySize-1
for t=0,r do
e=math.floor(s/n)+1
a[e]=a[e]or"   "a[e]=a[e]..(tostring(gvars.res_missionClearHistory[t])..", ")s=s+1
end
for e=1,e do(nil).Print(t,a[e])
end
end
if a.debug.showMissionScoreTable and a.res_missionScoreTable then(nil).Print(t,{.5,.5,1},"LuaMission RES.scoreTable");(nil).Print(t,"baseTime")
for s,e in ipairs(TppDefine.MISSION_CLEAR_RANK_LIST)do
local a=a.res_missionScoreTable.baseTime[e];(nil).Print(t,"rank = "..(tostring(e)..(": baseTime = "..(tostring(a).."[s]."))))
end
if a.res_missionScoreTable.tacticalTakeDownPoint then(nil).Print(t,"tacticalTakeDownPoint : countLimit = "..tostring(a.res_missionScoreTable.tacticalTakeDownPoint.countLimit))
else(nil).Print(t,"cannot find tacticalTakeDown param")
end
end
if a.debug.showPlayData then(nil).Print(t,{.5,.5,1},"LuaMission RES.showPlayData");(nil).Print(t,"gvars.totalMissionClearCount = "..tostring(gvars.totalMissionClearCount));(nil).Print(t,"gvars.totalPerfectStealthMissionClearCount = "..tostring(gvars.totalPerfectStealthMissionClearCount));(nil).Print(t,"gvars.totalStealthMissionClearCount = "..tostring(gvars.totalStealthMissionClearCount));(nil).Print(t,"gvars.totalRetryCount = "..tostring(gvars.totalRetryCount));(nil).Print(t,"gvars.totalNeutralizeCount = "..tostring(gvars.totalNeutralizeCount));(nil).Print(t,"gvars.totalKillCount = "..tostring(gvars.totalKillCount));(nil).Print(t,"gvars.totalHelicopterDestoryCount = "..tostring(gvars.totalHelicopterDestoryCount));(nil).Print(t,"gvars.totalBreakVehicleCount = "..tostring(gvars.totalBreakVehicleCount));(nil).Print(t,"gvars.totalBreakPlacedGimmickCount = "..tostring(gvars.totalBreakPlacedGimmickCount));(nil).Print(t,"gvars.totalBreakBurglarAlarmCount = "..tostring(gvars.totalBreakBurglarAlarmCount));(nil).Print(t,"gvars.totalWalkerGearDestoryCount = "..tostring(gvars.totalWalkerGearDestoryCount));(nil).Print(t,"gvars.totalMineRemoveCount = "..tostring(gvars.totalMineRemoveCount));(nil).Print(t,"gvars.totalAnnihilateOutPostCount = "..tostring(gvars.totalAnnihilateOutPostCount));(nil).Print(t,"gvars.totalAnnihilateBaseCount = "..tostring(gvars.totalAnnihilateBaseCount));(nil).Print(t,"gvars.totalInterrogateCount = "..tostring(gvars.totalInterrogateCount));(nil).Print(t,"gvars.totalRescueCount = "..tostring(gvars.totalRescueCount));(nil).Print(t,"vars.totalMarkingCount = "..tostring(vars.totalMarkingCount))
end
if a.debug.showPlayStyleHistory then(nil).Print(t,{.5,.5,1},"LuaMission RES.showPlayStyleHistory");(nil).Print(t,{.5,1,.5},"gvars.res_neutralizeHistorySize = "..tostring(gvars.res_neutralizeHistorySize));(nil).Print(t,{.5,1,.5}," history = 0         | history = 1          | history = 2        ");(nil).Print(t,{.5,1,.5},"isPerfectStealth");(nil).Print(t,"( "..(tostring(gvars.res_isPerfectStealth[0])..(" ) | ( "..(tostring(gvars.res_isPerfectStealth[1])..(" ) | ( "..(tostring(gvars.res_isPerfectStealth[2]).." )"))))));(nil).Print(t,{.5,1,.5},"isStealth");(nil).Print(t,"( "..(tostring(gvars.res_isStealth[0])..(" ) | ( "..(tostring(gvars.res_isStealth[1])..(" ) | ( "..(tostring(gvars.res_isStealth[2]).." )"))))));(nil).Print(t,{.5,1,.5},"Head shot count");(nil).Print(t,string.format("( %07d ) | ( %07d ) | ( %07d )",gvars.res_headShotCount[0],gvars.res_headShotCount[1],gvars.res_headShotCount[2]));(nil).Print(t,{.5,1,.5},"( historyIndex, neutralizeType, count )")
for s=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
local a=""local n=e.DEBUG_NEUTRALIZE_TYPE_TEXT[s+1]
for e=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
local e=string.format("( %02d, %s, %03d ) | ",e,n,gvars.res_neutralizeCount[e*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+s])a=a..e
end(nil).Print(t,a)
end
end
if a.debug.showPlayDataNeutralizeCount then(nil).Print(t,{.5,.5,1},"LuaMission RES.showPlayDataNeutralizeCount");(nil).Print(t,{.5,1,.5},"( neutralizeType, count )")
for a=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
local e=e.DEBUG_NEUTRALIZE_TYPE_TEXT[a+1]
local e=string.format("( %s, %016d ) | ",e,gvars.res_neutralizeCountForPlayData[a]);(nil).Print(t,e)
end
end
if a.debug.doForceSetPlayStyle then
a.debug.doForceSetPlayStyle=false
local e=a.debug.playStyleHistory
if e<0 then
e=0
a.debug.playStyleHistory=0
end
if e>2 then
e=2
a.debug.playStyleHistory=2
end
gvars.res_isPerfectStealth[e]=a.debug.playStyleIsPerfectStealth
gvars.res_isStealth[e]=a.debug.playStyleIsStealth
if a.debug.playStyleHeadShotCount>0 then
gvars.res_headShotCount[e]=a.debug.playStyleHeadShotCount
end
local t=a.debug.playStyleSaveIndex
if t<0 then
a.debug.playStyleSaveIndex=0
t=0
end
if t>=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX then
a.debug.playStyleSaveIndex=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1
t=TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1
end
if a.debug.playStyleNeutralizeCount>0 then
gvars.res_neutralizeCount[e*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+t]=a.debug.playStyleNeutralizeCount
end
end
if a.debug.addNewPlayStyleHistory then
a.debug.addNewPlayStyleHistory=false
e.AddNewPlayStyleHistory()
end
if a.debug.beforeMaxPlayRecord then
a.debug.beforeMaxPlayRecord=false
local e=999999997
local t={"totalMissionClearCount","totalPerfectStealthMissionClearCount","totalStealthMissionClearCount","totalRetryCount","totalNeutralizeCount","totalKillCount","totalBreakVehicleCount","totalHelicopterDestoryCount","totalWalkerGearDestoryCount","totalBreakPlacedGimmickCount","totalBreakBurglarAlarmCount","totalMineRemoveCount","totalAnnihilateOutPostCount","totalAnnihilateBaseCount","totalMarkingCount","totalInterrogateCount","totalRescueCount","totalheadShotCount","rnk_TotalTacticalTakeDownCount"}
for a,t in ipairs(t)do
gvars[t]=e
end
for t=0,19 do
gvars.res_neutralizeCountForPlayData[t]=e
end
gvars.chickenCapClearCount=e
end
end
function e.Messages()
return Tpp.StrCode32Table{Player={{msg="PlayerDamaged",func=e.IncrementTakeHitCount}},GameObject={{msg="Dead",func=function(e,t,a,a)
if not Tpp.IsLocalPlayer(t)then
return
end
if Tpp.IsEnemyWalkerGear(e)then
Tpp.IncrementPlayData"totalWalkerGearDestoryCount"end
end},{msg="TapHeadShotFar",func=e.OnTacticalActionPoint},{msg="TapRocketArm",func=e.OnTacticalActionPoint},{msg="TapHoldup",func=e.OnTacticalActionPoint},{msg="TapCqc",func=e.OnTacticalActionPoint},{msg="HeadShot",func=e.OnHeadShot},{msg="Neutralize",func=e.OnNeutralize},{msg="InterrogateSetMarker",func=e.IncrementInterrogateCount},{msg="BreakGimmickBurglarAlarm",func=function(e)
if not Tpp.IsLocalPlayer(e)then
return
end
Tpp.IncrementPlayData"totalBreakBurglarAlarmCount"end}}}
end
local t=s
local t=s
local t=true
local a=false
function e.IncrementInterrogateCount()
Tpp.IncrementPlayData"totalInterrogateCount"if svars.interrogateCount<s then
svars.interrogateCount=svars.interrogateCount+1
end
end
function e.IncrementTakeHitCount()
if mvars.res_noTakeHitCount then
return
end
if svars.oldTakeHitCount<svars.takeHitCount then
svars.oldTakeHitCount=svars.takeHitCount
e.CallCountAnnounce("result_hit",svars.takeHitCount,t)
end
end
function e.OnTacticalActionPoint(t)
if S(t,{id="IsDoneTacticalTakedown"})then
else
S(t,{id="SetTacticalTakedown"})
e.AddTacticalActionPoint()
end
end
function e.AddTacticalActionPoint()
if mvars.res_noTacticalTakeDown then
return
end
Tpp.IncrementPlayData"rnk_TotalTacticalTakeDownCount"if svars.tacticalActionPoint>=mvars.res_missionScoreTable.tacticalTakeDownPoint.countLimit then
return
end
svars.tacticalActionPoint=svars.tacticalActionPoint+1
e.CallCountAnnounce("result_tactical_takedown",svars.tacticalActionPoint,a)
TppTutorial.DispGuide("TAKE_DOWN",TppTutorial.DISPLAY_OPTION.TIPS)
end
function e.CallCountAnnounce(t,a,s)
TppUiCommand.CallCountAnnounce(t,a,s)
end
e.PLAYER_CAUSE_TO_SAVE_INDEX={[NeutralizeCause.CQC]=1,[NeutralizeCause.NO_KILL]=2,[NeutralizeCause.NO_KILL_BULLET]=2,[NeutralizeCause.CQC_KNIFE]=3,[NeutralizeCause.HANDGUN]=4,[NeutralizeCause.SUBMACHINE_GUN]=5,[NeutralizeCause.SHOTGUN]=6,[NeutralizeCause.ASSAULT_RIFLE]=7,[NeutralizeCause.MACHINE_GUN]=8,[NeutralizeCause.SNIPER_RIFLE]=9,[NeutralizeCause.MISSILE]=10,[NeutralizeCause.GRENADE]=11,[NeutralizeCause.MINE]=12}
e.NPC_CAUSE_TO_SAVE_INDEX={[NeutralizeCause.QUIET]=13,[NeutralizeCause.D_DOG]=14,[NeutralizeCause.D_HORSE]=15,[NeutralizeCause.D_WALKER_GEAR]=16,[NeutralizeCause.VEHICLE]=17,[NeutralizeCause.SUPPORT_HELI]=18,[NeutralizeCause.ASSIST]=19}
e.NEUTRALIZE_PLAY_STYLE_ID={7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,26,27,28}
function e.GetPlayStyleSaveIndex(n,r,a,t)
if a==NeutralizeType.INVALID then
return
end
local n=e.NPC_CAUSE_TO_SAVE_INDEX[t]
if n then
return n
end
if a==NeutralizeType.HOLDUP then
return 0
end
if Tpp.IsPlayer(r)then
local a={[NeutralizeCause.NO_KILL_BULLET]=true,[NeutralizeCause.HANDGUN]=true,[NeutralizeCause.SUBMACHINE_GUN]=true,[NeutralizeCause.SHOTGUN]=true,[NeutralizeCause.ASSAULT_RIFLE]=true,[NeutralizeCause.MACHINE_GUN]=true,[NeutralizeCause.SNIPER_RIFLE]=true,[NeutralizeCause.MISSILE]=true}
if a[t]then
if svars.shootNeutralizeCount<s then
svars.shootNeutralizeCount=svars.shootNeutralizeCount+1
end
end
local e=e.PLAYER_CAUSE_TO_SAVE_INDEX[t]
if e then
return e
else
return
end
end
end
function e.OnNeutralize(r,n,a,t)
local t=e.GetPlayStyleSaveIndex(r,n,a,t)
if not t then
return
end
e.IncrementPlayDataNeutralizeCount(t)
if mvars.res_noResult then
return
end
if svars.neutralizeCount<s then
svars.neutralizeCount=svars.neutralizeCount+1
end
local e=gvars.res_neutralizeCount[t]
if e>=255 then
return
end
gvars.res_neutralizeCount[t]=e+1
end
function e.IncrementPlayDataNeutralizeCount(e)
Tpp.IncrementPlayData"totalNeutralizeCount"if gvars.res_neutralizeCountForPlayData[e]<s then
gvars.res_neutralizeCountForPlayData[e]=gvars.res_neutralizeCountForPlayData[e]+1
end
end
function e.OnHeadShot(a,a,e,t)
if not Tpp.IsPlayer(e)then
return
end
local e=false
if bit.band(t,HeadshotMessageFlag.IS_JUST_UNCONSCIOUS)==HeadshotMessageFlag.IS_JUST_UNCONSCIOUS then
if HeadshotMessageFlag.NEUTRALIZE_DONE==nil then
e=true
else
if bit.band(t,HeadshotMessageFlag.NEUTRALIZE_DONE)~=HeadshotMessageFlag.NEUTRALIZE_DONE then
e=true
end
end
end
if e then
Tpp.IncrementPlayData"totalheadShotCount"end
if mvars.res_noResult then
return
end
if e then
if svars.headshotCount2<s then
svars.headshotCount2=svars.headshotCount2+1
TppUiCommand.CallCountAnnounce("playdata_playing_headshot",svars.headshotCount2,false)
end
if gvars.res_headShotCount[0]<255 then
gvars.res_headShotCount[0]=gvars.res_headShotCount[0]+1
end
end
end
function e.AddNewPlayStyleHistory()
if gvars.res_neutralizeHistorySize<TppDefine.PLAYSTYLE_HISTORY_MAX then
gvars.res_neutralizeHistorySize=gvars.res_neutralizeHistorySize+1
end
for t=(TppDefine.PLAYSTYLE_HISTORY_MAX-1),0,-1 do
for e=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
gvars.res_neutralizeCount[(t+1)*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+e]=gvars.res_neutralizeCount[t*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+e]
end
gvars.res_headShotCount[(t+1)]=gvars.res_headShotCount[t]
gvars.res_isStealth[(t+1)]=gvars.res_isStealth[t]
gvars.res_isPerfectStealth[(t+1)]=gvars.res_isPerfectStealth[t]
end
e.ClearNewestPlayStyleHistory()
end
function e.ClearNewestPlayStyleHistory()
for e=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
gvars.res_neutralizeCount[e]=0
end
gvars.res_headShotCount[0]=0
gvars.res_isStealth[0]=false
gvars.res_isPerfectStealth[0]=false
end
function e.GetTotalHeadShotCount()
local e=0
for t=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
e=e+gvars.res_headShotCount[t]
end
return e
end
function e.GetTotalNeutralizeCount()
local e=0
for a=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
for t=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
e=e+gvars.res_neutralizeCount[a*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+t]
end
end
return e
end
function e.IsTotalPlayStyleStealth()
local e=true
for t=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
if gvars.res_isStealth[t]==false then
e=false
break
end
end
return e
end
function e.GetNeutralizeCountBySaveIndex(a)
local e=0
for t=0,TppDefine.PLAYSTYLE_HISTORY_MAX do
e=e+gvars.res_neutralizeCount[t*TppDefine.PLAYSTYLE_SAVE_INDEX_MAX+a]
end
return e
end
function e.DecideNeutralizePlayStyle()
local t
local r
local s=-1
for a=0,TppDefine.PLAYSTYLE_SAVE_INDEX_MAX-1 do
local n=e.GetNeutralizeCountBySaveIndex(a)
if s<n then
t=false
r=a
s=n
elseif s==e.GetNeutralizeCountBySaveIndex(a)then
t=true
end
end
if t then
return 28
else
local e=e.NEUTRALIZE_PLAY_STYLE_ID[r+1]
if e then
return e
else
return
end
end
end
return e
