local e={}
local t={"tp_m_10020_03","tp_m_10020_04","tp_m_10020_05","tp_m_10020_06","tp_m_10020_12","tp_m_10280_11","tp_c_00000_03"}
local _={}_[10010]={"tp_m_10010_01","tp_m_10010_02","tp_m_10010_03","tp_m_10010_05","tp_m_10010_06","tp_m_10010_07","tp_m_10010_10","tp_m_10110_03","tp_bgm_11_32"}_[10020]={"tp_m_10020_01","tp_m_10020_02","tp_m_10280_11"}_[10030]={"tp_m_10010_04","tp_m_10010_08","tp_m_10010_09"}_[10036]=t
_[10043]=t
_[10033]={"tp_m_10020_03","tp_m_10020_04","tp_m_10020_05","tp_m_10020_06","tp_m_10020_12","tp_m_10280_11","tp_c_00000_14","tp_c_00000_03"}_[10040]={"tp_m_10040_03","tp_c_00000_12"}_[10041]={}_[10044]={}_[10052]={}_[10054]={}_[10050]={}_[10070]={"tp_m_10070_03","tp_m_10070_04","tp_m_10070_05","tp_m_10070_06","tp_m_10070_08"}_[10080]={"tp_m_10070_01","tp_m_10070_02","tp_m_10070_07"}_[10086]={}_[10082]={}_[10090]={"tp_m_10090_01","tp_c_00000_10"}_[10195]={}_[10091]={"tp_m_10090_02","tp_m_10090_03"}_[10100]={}_[10110]={"tp_m_10110_01","tp_m_10110_02"}_[10121]={}_[10115]={}_[10120]={"tp_m_10120_03"}_[10085]={}_[10200]={}_[10211]={}_[10081]={}_[10130]={"tp_m_10130_00"}_[10140]={"tp_m_10140_01","tp_m_10140_02","tp_m_10140_03","tp_m_10140_04","tp_m_10140_07"}_[10150]={}_[10151]={"tp_m_10150_01","tp_m_10150_02","tp_m_10150_05","tp_m_10150_06","tp_m_10150_07","tp_m_10150_08","tp_m_10150_19","tp_m_10150_27","tp_c_00000_05"}_[10045]={"tp_m_10150_03","tp_m_10150_04","tp_m_10150_10","tp_m_10150_18","tp_m_10150_26","tp_m_10150_31","tp_c_00001_01"}_[10156]={"tp_m_10156_01","tp_m_10156_02","tp_m_10156_03","tp_c_00001_03"}_[10093]={"tp_m_10093_01","tp_m_10093_02","tp_m_10093_03","tp_m_10093_04","tp_m_10093_05","tp_m_10150_14","tp_m_10150_28","tp_c_00001_02"}_[10171]={"tp_c_00001_04","tp_m_10150_11","tp_m_10150_12"}_[10240]={"tp_m_10240_01","tp_m_10240_02"}_[10260]={"tp_m_10260_03"}_[10280]={"tp_m_10150_13","tp_m_10280_02","tp_m_10280_03","tp_m_10280_08","tp_m_10280_09","tp_m_10280_10","tp_m_10280_12","tp_m_10280_13","tp_m_10280_14","tp_m_10280_15","tp_m_10280_16","tp_m_10280_17"}_[10230]={}
local t={}t[10010]={}t[10020]={}t[10030]={"tp_m_10030_00"}t[10036]={"tp_m_10036_00"}t[10043]={"tp_m_10043_00"}t[10033]={"tp_m_10033_00"}t[10040]={"tp_m_10040_00"}t[10041]={"tp_m_10041_00"}t[10044]={"tp_m_10044_00"}t[10052]={"tp_m_10052_00"}t[10054]={"tp_m_10054_00"}t[10050]={}t[10070]={"tp_m_10070_00"}t[10080]={"tp_m_10100_02"}t[10086]={"tp_m_10086_00"}t[10082]={"tp_m_10082_00"}t[10090]={"tp_m_10090_00"}t[10195]={"tp_m_10195_00"}t[10091]={"tp_m_10091_00"}t[10100]={"tp_m_10100_00"}t[10110]={"tp_m_10110_00"}t[10121]={"tp_m_10121_00"}t[10115]={"tp_m_10115_00"}t[10120]={"tp_m_10120_00"}t[10085]={"tp_m_10085_00"}t[10200]={"tp_m_10200_00"}t[10211]={"tp_m_10211_00"}t[10081]={"tp_m_10081_00"}t[10130]={"tp_m_10130_00"}t[10140]={"tp_m_10140_00"}t[10150]={"tp_m_10150_00"}t[10151]={"tp_m_10151_00"}t[10045]={"tp_m_10045_00"}t[10156]={"tp_m_10156_00"}t[10093]={"tp_m_10093_00"}t[10171]={"tp_m_10171_00"}t[10240]={"tp_m_10240_00"}t[10260]={"tp_m_10260_00"}t[10280]={}t[10230]={}
local n={[BuddyType.QUIET]=function()
local _={"tp_c_00000_02"}
local t=TppBuddyService.GetFriendlyPoint(BuddyFriendlyType.QUIET)
if t>60 then
table.insert(_,"tp_sp_01_04")
end
e.Acquire{cassetteList=_,pushReward=true}
end,[BuddyType.DOG]=function()
e.Acquire{cassetteList={"tp_c_00000_01"},pushReward=true}
end}
function e.Acquire(t)
local e,_,p
if Tpp.IsTypeTable(t)then
e=t.cassetteList
_=t.isShowAnnounceLog
p=t.pushReward
end
for e,t in ipairs(e)do
if not TppMotherBaseManagement.IsGotCassetteTapeTrack(t)then
TppMotherBaseManagement.AddCassetteTapeTrack(t)
if p then
local _=TppUiCommand.GetTapeLangIdByTrackId(t)
TppReward.Push{category=TppScriptVars.CATEGORY_MB_MANAGEMENT,langId="dummy",rewardType=TppReward.TYPE.CASSET_TAPE,arg1=_}
end
if _ then
local e
if Tpp.IsTypeTable(_)then
e=_.delayTimeSec
end
TppUI.ShowAnnounceLog("get_tape",t,nil,e)
end
end
end
end
function e.AcquireOnMissionClear(t)
local _=_[t]
if _ then
e.Acquire{cassetteList=_,pushReward=true}
end
local _=n[vars.buddyType]
if _ then
_()
end
if TppTerminal.IsReleaseSection"BaseDev"then
e.Acquire{cassetteList={"tp_m_10020_07","tp_m_10020_08","tp_m_10020_09","tp_m_10020_10","tp_m_10020_11"},pushReward=true}
end
end
function e.AcquireOnMissionOpen(_)
local _=t[_]
if _ then
e.Acquire{cassetteList=_,pushReward=true}
end
end
function e.AcquireOnPickUp(_)Gimmick.NotifyOfTakingCassette(_)
TppMotherBaseManagement.AddCassetteTapeTrackByIndex(_)
local _=TppUiCommand.GetTrackLangIdBySaveIndex(_)
TppUI.ShowAnnounceLog("get_tape",_)
end
function e.OnEstablishMissionClear()
local _=TppMission.GetMissionID()
if _==10260 then
local _="tp_c_00000_16"if not TppMotherBaseManagement.IsGotCassetteTapeTrack(_)then
e.Acquire{cassetteList={_},pushReward=true}
end
end
if TppRadio.IsPlayed"f2000_rtrg8400"then
local _="tp_m_10190_04"if not TppMotherBaseManagement.IsGotCassetteTapeTrack(_)and TppBuddy2BlockController.DidObtainBuddyType(BuddyType.DOG)then
e.Acquire{cassetteList={_},pushReward=true}
end
end
end
function e.OnEnterFreeHeliPlay()
local _=TppStory.GetCurrentStorySequence()
if TppStory.IsNowOccurringElapsedMission(TppDefine.ELAPSED_MISSION_EVENT.QUIET_VISIT_MISSION)or TppQuest.IsCleard"mtbs_q99011"then
e.Acquire{cassetteList={"tp_m_10050_02"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_c_00000_06"},isShowAnnounceLog={delayTimeSec=2}}
end
if _>=TppDefine.STORY_SEQUENCE.CLEARD_FLAG_MISSIONS_BEFORE_ENDRESS_PROXY_WAR then
e.Acquire{cassetteList={"tp_c_00001_03"},isShowAnnounceLog={delayTimeSec=2}}
end
if _>=TppDefine.STORY_SEQUENCE.CLEARD_CAPTURE_THE_WEAPON_DEALER then
e.Acquire{cassetteList={"tp_m_10120_01"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_m_10120_02"},isShowAnnounceLog={delayTimeSec=2}}
end
if _>=TppDefine.STORY_SEQUENCE.CLEARD_METALLIC_ARCHAEA then
e.Acquire{cassetteList={"tp_m_10140_05"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_m_10140_06"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_c_00000_04"},isShowAnnounceLog={delayTimeSec=2}}
end
if TppStory.IsMissionOpen(10040)then
e.Acquire{cassetteList={"tp_m_10040_01"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_m_10040_02"},isShowAnnounceLog={delayTimeSec=2}}
end
if TppStory.IsMissionOpen(10080)then
e.Acquire{cassetteList={"tp_c_00000_07"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_c_00000_08"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_c_00000_11"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_c_00000_17"},isShowAnnounceLog={delayTimeSec=2}}
end
if TppStory.IsMissionOpen(10082)then
e.Acquire{cassetteList={"tp_m_10100_03"},isShowAnnounceLog={delayTimeSec=2}}
end
if TppStory.IsMissionOpen(10100)then
e.Acquire{cassetteList={"tp_m_10100_01"},isShowAnnounceLog={delayTimeSec=2}}
e.Acquire{cassetteList={"tp_c_00000_09"},isShowAnnounceLog={delayTimeSec=2}}
end
end
return e
