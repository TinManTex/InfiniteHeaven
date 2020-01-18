local e={}
local r=Tpp.IsTypeFunc
local r=Tpp.IsTypeTable
local a=Tpp.IsTypeString
e.TYPE=Tpp.Enum{"MIN","COMMON","CASSET_TAPE","KEY_ITEM","BLUE_PRINT","EMBLEM","ANIMAL","RANKING","MAX"}e.REWARD_FIRST_LANG={[e.TYPE.COMMON]=nil,[e.TYPE.CASSET_TAPE]=nil,[e.TYPE.KEY_ITEM]="announce_find_keyitem",[e.TYPE.BLUE_PRINT]="announce_get_blueprint",[e.TYPE.EMBLEM]=nil,[e.TYPE.ANIMAL]="announce_extract_animal",[e.TYPE.RANKING]="reward_607"}e.REWARD_MAX={[TppScriptVars.CATEGORY_MISSION]=TppDefine.REWARD_MAX.MISSION,[TppScriptVars.CATEGORY_MB_MANAGEMENT]=TppDefine.REWARD_MAX.MB_MANAGEMENT,[TppScriptVars.CATEGORY_QUEST]=TppDefine.REWARD_MAX.QUEST}e.LANG_ENUM={[TppScriptVars.CATEGORY_MISSION]=Tpp.Enum{"reward_fob_goal_staff","reward_fob_goal_resources","reward_fob_goal_herbs","reward_fob_goal_wormhole"},[TppScriptVars.CATEGORY_MB_MANAGEMENT]=Tpp.Enum{"key_item_3013","key_item_3003","key_item_3008","reward_100","reward_101","reward_102","reward_103","reward_104","reward_105","reward_106","reward_107","reward_108","reward_109","reward_110","reward_111","reward_112","reward_113","reward_300","reward_301","reward_302","reward_303","reward_304","reward_305","reward_306","reward_400","reward_401","reward_402","reward_403","reward_404","reward_405","reward_406","reward_500","reward_501","reward_502","reward_503","reward_504","reward_600","reward_601","reward_602","reward_603","reward_604","reward_605","reward_606","reward_607","dummy","reward_114","reward_115","key_item_3014","key_item_3015","key_item_3016","key_item_3017","key_item_3018","key_item_3019","key_item_3007","reward_307","key_item_3010","key_item_3020"},[TppScriptVars.CATEGORY_QUEST]=Tpp.Enum{"dummy"}}e.GVARS_NAME={[TppScriptVars.CATEGORY_MISSION]={langEnumName="rwd_missionRewardLangEnum",stackSizeName="rwd_missionRewardStackSize",paramName="rwd_missionRewardParam"},[TppScriptVars.CATEGORY_MB_MANAGEMENT]={langEnumName="rwd_mbManagementRewardLangEnum",stackSizeName="rwd_mbManagementRewardStackSize",paramName="rwd_mbManagementRewardParam"},[TppScriptVars.CATEGORY_QUEST]={langEnumName="rwd_questRewardLangEnum",stackSizeName="rwd_questRewardStackSize",paramName="rwd_questRewardParam"}}e.RADIO_GROUP_NAME={[5]="f6000_rtrg2010",[6]="f6000_rtrg2020",[7]="f6000_rtrg2030",[8]="f6000_rtrg2040",[10]="f6000_rtrg2050",[11]="f6000_rtrg2060",[20]="f6000_rtrg2130",[22]="f6000_rtrg2140",[30]="f6000_rtrg2150",[25]="f6000_rtrg2160",[55]="f6000_rtrg2270"}
function e.Push(a)
  if not r(a)then
    return
  end
  if e.DEBUG_IgnorePush then
    if e.DEBUG_isIgnorePushReward then
      return
    end
  end
  local n=a.category
  local t=a.langId
  local r=a.rewardType
  local i=a.arg1 or 0
  local _=a.arg2 or 0
  if not(((r)and(r>e.TYPE.MIN))and(r<e.TYPE.MAX))then
    return
  end
  local d=e.GVARS_NAME[n].stackSizeName
  local p=e.GVARS_NAME[n].langEnumName
  local s=e.GVARS_NAME[n].paramName
  if not d then
    return
  end
  local o=e.LANG_ENUM[n][t]if not o then
    return
  end
  local t=gvars[d]local n=e.REWARD_MAX[n]local a=t
  if(r==e.TYPE.CASSET_TAPE)then
    if mvars then
      mvars.rwd_cassetTapeLangIdRegisted=mvars.rwd_cassetTapeLangIdRegisted or{}
      if mvars.rwd_cassetTapeLangIdRegisted[i]then
        return
      else
        mvars.rwd_cassetTapeLangIdRegisted[i]=true
      end
    end
  elseif(r==e.TYPE.EMBLEM)then
  elseif(r==e.TYPE.RANKING)then
  else
    for e=0,t do
      local r=gvars[p][e]
      if r==o then
        a=e
        break
      end
    end
  end
  if a>n then
    return
  end
  if a==t then
    gvars[d]=t+1
  end
  gvars[p][a]=o
  e.SetParameters(s,a,r,i,_)
end
function e.PushBluePrintReward(e)
end
function e.ShowAllReward()
  for r,a in pairs(e.GVARS_NAME)do
    e.ShowReward(r)
  end
  if TppUiCommand.GetBonusPopupRegist"animal">0 then
    TppUiCommand.ShowBonusPopupRegist"animal"
  end
  if TppUiCommand.GetBonusPopupRegist"staff">0 then
    TppUiCommand.ShowBonusPopupRegist"staff"
  end
  local e=TppRadio.DoEventOnRewardEndRadio()
  if next(e)then
    TppUiCommand.SetBonusPopupAfterRadio(e[1])
  end
end
function e.IsStacked()
  for r,e in pairs(e.GVARS_NAME)do
    local e=e.stackSizeName
    local e=gvars[e]if e>0 then
      return true
    end
  end
  if TppUiCommand.GetBonusPopupRegist"animal">0 then
    return true
  end
  if TppUiCommand.GetBonusPopupRegist"staff">0 then
    return true
  end
  if#TppRadio.DoEventOnRewardEndRadio()>0 then
    return true
  end
  return false
end
function e.ShowReward(r)
  local a=e.GVARS_NAME[r].stackSizeName
  local t=e.GVARS_NAME[r].langEnumName
  local i=e.GVARS_NAME[r].paramName
  if not a then
    return
  end
  local n=gvars[a]if n<=0 then
    return
  end
  local o=gvars[t]for a=0,(n-1)do
    local n,t,i=e.GetParameters(i,a)e.ShowBonusPopup(r,n,o[a],t,i)
  end
  gvars[a]=0
end
function e.ShowBonusPopup(i,r,t,o,d)
  local a=e.LANG_ENUM[i][t]if not a then
    return
  end
  local n=e.REWARD_FIRST_LANG[r]if r==e.TYPE.COMMON then
    TppUiCommand.ShowBonusPopupCommon(a)e.ShowBonusPopupCategory(r,a,t)
    if i==TppScriptVars.CATEGORY_MB_MANAGEMENT then
      local e=e.RADIO_GROUP_NAME[t]if e then
        TppUiCommand.SetBonusPopupRadio(a,e)
      end
    end
  elseif r==e.TYPE.CASSET_TAPE then
    TppUiCommand.ShowBonusPopupItemTape(o)
  elseif r==e.TYPE.EMBLEM then
    TppUiCommand.ShowBonusPopupEmblem(o,d)
  elseif r==e.TYPE.RANKING then
    local a=TppRanking.GetRankingLangId(o)
    TppUiCommand.ShowBonusPopupCommon(n,a)e.ShowBonusPopupCategory(r,n,t)
  elseif n then
    TppUiCommand.ShowBonusPopupCommon(n,a)e.ShowBonusPopupCategory(r,n,t)
  end
end
function e.SetParameters(r,a,o,i,t)
  local n,e,a=e.GetParameterOffsets(a)gvars[r][n]=o
  gvars[r][e]=i
  gvars[r][a]=t
end
function e.GetParameters(r,a)
  local a,e,n=e.GetParameterOffsets(a)
  local a=gvars[r][a]local e=gvars[r][e]local r=gvars[r][n]return a,e,r
end
function e.GetParameterOffsets(e)
  local e=e*TppDefine.REWARD_PARAM.MAX
  local r=e+TppDefine.REWARD_PARAM.TYPE
  local a=e+TppDefine.REWARD_PARAM.ARG1
  local e=e+TppDefine.REWARD_PARAM.ARG2
  return r,a,e
end
function e.ShowBonusPopupCategory(r,a,n)
  if r==e.TYPE.COMMON then
    e.ShowBonusPopupCategoryCommon(a,n)
  elseif r==e.TYPE.CASSET_TAPE then
  elseif r==e.TYPE.KEY_ITEM then
    TppUiCommand.SetBonusPopupCategory(a,"keyitem")
  elseif r==e.TYPE.BLUE_PRINT then
    TppUiCommand.SetBonusPopupCategory(a,"devfile")
  elseif r==e.TYPE.EMBLEM then
  elseif r==e.TYPE.ANIMAL then
  elseif r==e.TYPE.RANKING then
    TppUiCommand.SetBonusPopupCategory(a,"trial")
  end
end
function e.GetBonusPopupCategory(e)
  if e<4 then
    return"keyitem"
  elseif e<18 then
    return"motherbase"
  elseif e<25 then
    return"develop"
  elseif e<32 then
    return"custom"
  elseif e<37 then
    return"callmenu"
  elseif e==37 then
  elseif e==38 then
    return"devfile"
  elseif e==39 then
    return"keyitem"
  elseif e<43 then
  elseif e==43 then
  elseif e==44 then
    return"trial"
  elseif e==45 then
  elseif e<48 then
    return"motherbase"
  elseif e<55 then
    return"keyitem"
  elseif e==55 then
    return"develop"
  elseif e<58 then
    return"keyitem"
  end
  return nil
end
function e.ShowBonusPopupCategoryCommon(r,a)
  local e=e.GetBonusPopupCategory(a)
  if e~=nil then
    TppUiCommand.SetBonusPopupCategory(r,e)
  end
end
return e
