local e={}
e.IS_ONCE={false,true,true,true,true,false,false,false,true,true,false,false,false,false,false,false,false,false,false,false}
e.UPDATE_ORDER={true,false,false,false,false,true,true,true,false,false,true,true,true,true,true,true,true,true,true,true}
e.ANNOUNCE_LOG_TYPE={NONE=0,TIME=1,DISTANCE=2,NUMBER=3}
e.SHOW_ANNOUNCE_LOG={e.ANNOUNCE_LOG_TYPE.NONE,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.DISTANCE,e.ANNOUNCE_LOG_TYPE.NONE,e.ANNOUNCE_LOG_TYPE.DISTANCE,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.NONE,e.ANNOUNCE_LOG_TYPE.NONE,e.ANNOUNCE_LOG_TYPE.NONE,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME,e.ANNOUNCE_LOG_TYPE.TIME}
e.OPEN_CONDITION={
  true,
  10043,
  10036,
  10033,
  10041,
  10044,
  10054,
  10052,
  10086,
  function()
    if gvars.rnk_isOpen[TppDefine.RANKING_ENUM.XRocketArmNeutralizeTime]then
      return true
    end
    if vars.handEquip==TppEquip.EQP_HAND_STUN_ROCKET then
      return true
    else
      return false
    end
  end,
  10115,
  10115,
  10151,
  TppQuest.ShootingPracticeOpenCondition.Command,
  TppQuest.ShootingPracticeOpenCondition.Develop,
  TppQuest.ShootingPracticeOpenCondition.Support,
  TppQuest.ShootingPracticeOpenCondition.BaseDev,
  TppQuest.ShootingPracticeOpenCondition.Medical,
  TppQuest.ShootingPracticeOpenCondition.Spy,
  TppQuest.ShootingPracticeOpenCondition.Combat
}
local n={[30010]=true,[30020]=true,[30050]=true}
e.EXCLUDE_MISSION_LIST={false,n,n,n,n,false,false,false,n,n,false,false,false,false,false,false,false,false,false,false}
function e.GetScore(e)
  local e="rnk_"..e
  local e=gvars[e]
  if e==nil then
    return
  end
  return e
end
function e.IncrementScore(n)
  local a=e.GetScore(n)
  if a then
    e.UpdateScore(n,a+1)
  end
end
function e.UpdateScore(t,a)
  local n=TppDefine.RANKING_ENUM[t]
  if not n then
    return
  end
  if not Tpp.IsTypeNumber(a)then
    return
  end
  if not gvars.rnk_isOpen[n]then
    return
  end
  local o=e.CheckExcludeMission(n,vars.missionCode)
  if o then
    return
  end
  local o="rnk_"..t
  if gvars[o]==nil then
    return
  end
  local r=e.IS_ONCE[n]
  if(svars.rnk_isUpdated[n]==false)or(r==false)then
    svars.rnk_isUpdated[n]=true
    local r=e.UPDATE_ORDER[n]
    local t
    if r then
      if gvars[o]<a then
        t=true
      else
        t=false
      end
    else
      if gvars[o]>a then
        t=true
      else
        t=false
      end
    end
    if t then
      e.ShowUpdateScoreAnnounceLog(n,a)gvars[o]=a
    end
  else
    if r then
    end
  end
end
function e.ShowUpdateScoreAnnounceLog(t,a)
  local n=e.SHOW_ANNOUNCE_LOG[t]
  if n==e.ANNOUNCE_LOG_TYPE.NONE then
    return
  end
  e._ShowCommonUpdateScoreAnnounceLog(t)
  if n==e.ANNOUNCE_LOG_TYPE.TIME then
    e._ShowScoreTimeAnnounceLog(a)
  end
  if n==e.ANNOUNCE_LOG_TYPE.DISTANCE then
    e._ShowScoreDistanceAnnounceLog(a)
  end
  if n==e.ANNOUNCE_LOG_TYPE.NUMBER then
    e._ShowScoreNumberAnnounceLog(a)
  end
end
function e.GetRankingLangId(e)
  return string.format("ranking_name_%02d",e)
end
function e._ShowCommonUpdateScoreAnnounceLog(n)
  TppUI.ShowAnnounceLog"trial_update"
  local e=e.GetRankingLangId(n)
  TppUiCommand.AnnounceLogViewLangId(e)
end
function e._ShowScoreTimeAnnounceLog(e)
  local n=math.floor(e/6e4)
  local a=math.floor((e-n*6e4)/1e3)
  local e=(e-n*6e4)-a*1e3
  TppUiCommand.AnnounceLogViewLangId("announce_trial_time",n,a,e)
end
function e._ShowScoreDistanceAnnounceLog(n)
  local e=math.floor(n)
  local n=(n-e)*1e3
  TppUiCommand.AnnounceLogViewLangId("announce_trial_length",e,n)
end
function e._ShowScoreNumberAnnounceLog(e)
  TppUiCommand.AnnounceLogViewLangId("announce_trial_num",e)
end
function e.UpdateOpenRanking()
  for e,n in pairs(e.OPEN_CONDITION)do
    local t=gvars.rnk_isOpen[e]
    local a=false
    if n==true then
      a=true
    elseif Tpp.IsTypeNumber(n)then
      a=TppStory.IsMissionCleard(n)
    elseif Tpp.IsTypeFunc(n)then
      a=n()
    end
    if(((e==11)or(e==12))or(e==13))and(not t)then
      if a then
        TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="dummy",rewardType=TppReward.TYPE.RANKING,arg1=e}
      end
    end
    gvars.rnk_isOpen[e]=a
  end
end
function e.RegistMissionClearRankingResult(a,n,t)
  local e
  if a then
    e=RecordRanking.GetMissionLimitBordId(n)
  else
    e=RecordRanking.GetMissionBordId(n)
  end
  if e==RankingBordId.NONE then
    return
  end
  mvars.rnk_missionClearRankingResult={e,t}
end
function e.SendCurrentRankingScore()
  if RecordRanking.IsRankingBusy()then
    return
  end
  local n={}
  for a=1,(TppDefine.RANKING_MAX-1)do
    if svars.rnk_isUpdated[a]then
      local t=TppDefine.RANKING_ENUM[a]
      local e=e.GetScore(t)table.insert(n,{a,e})
    end
  end
  if mvars.rnk_missionClearRankingResult then
    table.insert(n,mvars.rnk_missionClearRankingResult)
  end
  RecordRanking.RegistRanking(n)
end
function e.CheckExcludeMission(a,n)
  local e=e.EXCLUDE_MISSION_LIST[a]
  if e then
    return e[n]
  end
  return false
end
function e.UpdateScoreTime(n)
  e.UpdateScore(n,svars.scoreTime)
end
function e.UpdateShootingPracticeClearTime(n,a)
  e.UpdateScore(n,a)
end
function e.Messages()
  return Tpp.StrCode32Table{Player={{msg="CBoxSlideEnd",func=e.OnCBoxSlideEnd}},GameObject={{msg="Neutralize",func=e.OnNeutralize},{msg="HeadShot",func=e.OnHeadShot}}}
end
function e.Init(n)
  e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function TppResult.OnReload(n)
  e.Init(n)
end
function e.OnMessage(t,a,s,n,r,i,o)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,t,a,s,n,r,i,o)
end
function e.OnNeutralize(n,n,e,n)
  if e==NeutralizeType.HOLDUP then
    PlayRecord.RegistPlayRecord"PLAYER_HOLDUP"end
end
function e.OnHeadShot(a,a,n,e)
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
end
function e.DeclareSVars()
  return{{name="rnk_isUpdated",arraySize=TppDefine.RANKING_MAX,type=TppScriptVars.TYPE_BOOL,value=false,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION}}
end
return e
