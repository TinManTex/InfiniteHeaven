local e={}
local n=Tpp.IsTypeFunc
local n=Tpp.IsTypeTable
local a=Tpp.IsTypeString
e.TYPE=Tpp.Enum{"MIN","COMMON","MAX"}
e.REWARD_FIRST_LANG={[e.TYPE.COMMON]=nil}
e.REWARD_MAX={[TppScriptVars.CATEGORY_MISSION]=TppDefine.REWARD_MAX.MISSION,[TppScriptVars.CATEGORY_QUEST]=TppDefine.REWARD_MAX.QUEST}
e.LANG_ENUM={[TppScriptVars.CATEGORY_MISSION]=Tpp.Enum{"dummy"},[TppScriptVars.CATEGORY_QUEST]=Tpp.Enum{"dummy"}}
e.GVARS_NAME={[TppScriptVars.CATEGORY_MISSION]={langEnumName="rwd_missionRewardLangEnum",stackSizeName="rwd_missionRewardStackSize",paramName="rwd_missionRewardParam"},[TppScriptVars.CATEGORY_QUEST]={langEnumName="rwd_questRewardLangEnum",stackSizeName="rwd_questRewardStackSize",paramName="rwd_questRewardParam"}}
e.RADIO_GROUP_NAME={}
function e.Push(a)
if not n(a)then
return
end
if e.DEBUG_IgnorePush then
if e.DEBUG_isIgnorePushReward then
return
end
end
local r=a.category
local o=a.langId
local n=a.rewardType
local p=a.arg1 or 0
local i=a.arg2 or 0
if not(((n)and(n>e.TYPE.MIN))and(n<e.TYPE.MAX))then
return
end
local t=e.GVARS_NAME[r].stackSizeName
local s=e.GVARS_NAME[r].langEnumName
local l=e.GVARS_NAME[r].paramName
if not t then
return
end
local d=e.LANG_ENUM[r][o]
if not d then
return
end
local o=gvars[t]
local r=e.REWARD_MAX[r]
local a=o
if(n==e.TYPE.CASSET_TAPE)then
if mvars then
mvars.rwd_cassetTapeLangIdRegisted=mvars.rwd_cassetTapeLangIdRegisted or{}
if mvars.rwd_cassetTapeLangIdRegisted[p]then
return
else
mvars.rwd_cassetTapeLangIdRegisted[p]=true
end
end
elseif(n==e.TYPE.EMBLEM)then
elseif(n==e.TYPE.RANKING)then
else
for e=0,o do
local n=gvars[s][e]
if n==d then
a=e
break
end
end
end
if a>r then
return
end
if a==o then
gvars[t]=o+1
end
gvars[s][a]=d
e.SetParameters(l,a,n,p,i)
end
if(Tpp.IsQARelease()or nil)then
function e.DEBUG_IgnorePush(n)
e.DEBUG_isIgnorePushReward=n
end
end
function e.PushBluePrintReward(e)
end
function e.ShowAllReward()
for n,a in pairs(e.GVARS_NAME)do
e.ShowReward(n)
end
if TppUiCommand.GetBonusPopupRegist"animal">0 then
TppUiCommand.ShowBonusPopupRegist"animal"end
if TppUiCommand.GetBonusPopupRegist"staff">0 then
TppUiCommand.ShowBonusPopupRegist"staff"end
local e=TppRadio.DoEventOnRewardEndRadio()
if next(e)then
TppUiCommand.SetBonusPopupAfterRadio(e[1])
end
end
function e.IsStacked()
for n,e in pairs(e.GVARS_NAME)do
local e=e.stackSizeName
local e=gvars[e]
if e>0 then
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
function e.ShowReward(n)
local a=e.GVARS_NAME[n].stackSizeName
local o=e.GVARS_NAME[n].langEnumName
local t=e.GVARS_NAME[n].paramName
if not a then
return
end
local r=gvars[a]
if r<=0 then
return
end
local o=gvars[o]
for a=0,(r-1)do
local r,t,d=e.GetParameters(t,a)
e.ShowBonusPopup(n,r,o[a],t,d)
end
gvars[a]=0
end
function e.ShowBonusPopup(a,n,o,r,r)
local a=e.LANG_ENUM[a][o]
if not a then
return
end
local r=e.REWARD_FIRST_LANG[n]
if n==e.TYPE.COMMON then
TppUiCommand.ShowBonusPopupCommon(a)
e.ShowBonusPopupCategory(n,a,o)
elseif r then
TppUiCommand.ShowBonusPopupCommon(r,a)
e.ShowBonusPopupCategory(n,r,o)
end
end
function e.SetParameters(n,a,d,o,t)
local r,a,e=e.GetParameterOffsets(a)gvars[n][r]=d
gvars[n][a]=o
gvars[n][e]=t
end
function e.GetParameters(n,a)
local a,e,r=e.GetParameterOffsets(a)
local a=gvars[n][a]
local e=gvars[n][e]
local n=gvars[n][r]
return a,e,n
end
function e.GetParameterOffsets(e)
local e=e*TppDefine.REWARD_PARAM.MAX
local a=e+TppDefine.REWARD_PARAM.TYPE
local n=e+TppDefine.REWARD_PARAM.ARG1
local e=e+TppDefine.REWARD_PARAM.ARG2
return a,n,e
end
function e.ShowBonusPopupCategory(a,n,r)
if a==e.TYPE.COMMON then
e.ShowBonusPopupCategoryCommon(n,r)
end
end
function e.ShowBonusPopupCategoryCommon(e,e)
end
function e.IsStorySequenceRewardRequired()
return gvars.rwd_storySequenceReward<TppStory.GetCurrentStorySequence()
end
function e.UpdateStorySequenceRewardRequired()
local a=TppStory.GetCurrentStorySequence()
for e=gvars.rwd_storySequenceReward+1,a do
local e=SsdStorySequenceRewardList.storySequenceRewardList[e+1]
if Tpp.IsTypeTable(e)then
local n=e.recipe
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
SsdSbm.AddRecipe(e)
end
end
local n=e.resource
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
SsdSbm.AddResource(e.name,e.count)
end
end
local n=e.production
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
SsdSbm.AddProduction{id=e.name,count=e.count,tryEquip=false}
end
end
local n=e.skill
if Tpp.IsTypeTable(n)then
for n,e in ipairs(n)do
SsdSbm.OpenSkill{id=e}
end
end
local e=e.experience
SsdSbm.AddExperiencePoint(e)
end
end
gvars.rwd_storySequenceReward=a
SsdSbm.ShowSettlementReport()
end
return e
