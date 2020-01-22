local e={}
local i=Tpp.IsTypeFunc
local n=Tpp.IsTypeTable
local i=Tpp.IsTypeString
local i=Tpp.IsTypeNumber
local i=bit.bnot
local i,i,i=bit.band,bit.bor,bit.bxor
function e.StartTitle(e)
vars.rulesetId=4
vars.locationCode=101
vars.missionCode=6
TppMission.ResetNeedWaitMissionInitialize()
gvars.ini_isTitleMode=true
gvars.ini_isReturnToTitle=false
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
vars.initialPlayerAction=PlayerInitialAction.STAND
TppPlayer.ResetDisableAction()
TppPlayer.ResetInitialPosition()
TppPlayer.ResetMissionStartPosition()
TppMission.ResetIsStartFromHelispace()
TppMission.ResetIsStartFromFreePlay()
TppMission.VarResetOnNewMission()
if clock then
TppClock.SetTime(clock)
TppClock.SaveMissionStartClock()
end
TppSimpleGameSequenceSystem.Start()
TppMission.Load(vars.missionCode,currentMissionCode)
local e=Fox.GetActMode()
if(e=="EDIT")then
Fox.SetActMode"GAME"end
end
function e.SetVarsTitleCypr()
TppMission.VarResetOnNewMission()
vars.locationCode=TppDefine.LOCATION_ID.CYPR
vars.missionCode=10010
TppPlayer.SetWeapons(TppDefine.CYPR_PLAYER_INITIAL_WEAPON_TABLE)
TppPlayer.SetItems(TppDefine.CYPR_PLAYER_INITIAL_ITEM_TABLE)
gvars.title_nextLocationCode=vars.locationCode
gvars.title_nextMissionCode=vars.missionCode
end
function e.SetVarsTitleHeliSpace()
TppMission.VarResetOnNewMission()
local i,e=TppMission.GetCurrentLocationHeliMissionAndLocationCode()
gvars.title_nextMissionCode=vars.missionCode
gvars.title_nextLocationCode=e
vars.missionCode=i
vars.locationCode=e
TppUiCommand.LoadoutSetForStartFromHelicopter()
TppHelicopter.ResetMissionStartHelicopterRoute()
TppPlayer.ResetInitialPosition()
TppPlayer.ResetMissionStartPosition()
end
function e.InitializeOnStartTitle()
e.InitializeOnStatingMainFrame()
e.InitializeOnNewGameAtFirstTime()
e.InitializeOnNewGame()
end
function e.InitializeOnStatingMainFrame()
local i=1024
local e={}
local t=1*i
local a=TppGameSequence.GetTargetPlatform()
if a=="Steam"then
t=2*i
end
local a=t
e[TppDefine.SAVE_SLOT.CONFIG+1]=a
e[TppDefine.SAVE_SLOT.CONFIG_SAVE+1]=a
local t=3*i
e[TppDefine.SAVE_SLOT.PERSONAL+1]=t
e[TppDefine.SAVE_SLOT.PERSONAL_SAVE+1]=t
local i=16*i
e[TppDefine.SAVE_SLOT.MGO+1]=i
e[TppDefine.SAVE_SLOT.MGO_SAVE+1]=i
Tpp.DEBUG_DumpTable(e)
TppScriptVars.CreateSaveSlot(e)
TppScriptVars.SetFileSizeList{{TppDefine.CONFIG_SAVE_FILE_NAME,a},{TppDefine.PERSONAL_DATA_SAVE_FILE_NAME,t},{TppDefine.MGO_SAVE_FILE_NAME,i}}
end
function e.InitializeOnNewGameAtFirstTime()
vars.locationCode=TppDefine.LOCATION_ID.CYPR
vars.missionCode=10010
end
function e.InitializeOnNewGame()
gvars.ply_initialPlayerState=TppDefine.INITIAL_PLAYER_STATE.ON_FOOT
gvars.ply_missionStartPoint=0
gvars.heli_missionStartRoute=0
gvars.str_storySequence=TppDefine.STORY_SEQUENCE.STORY_START
TppPackList.SetDefaultMissionPackLabelName()
gvars.sav_varRestoreForContinue=false
for e=0,TppDefine.MISSION_COUNT_MAX do
gvars.str_missionOpenPermission[e]=false
end
for e=0,TppDefine.MISSION_COUNT_MAX do
gvars.str_missionOpenFlag[e]=false
end
for e=0,TppDefine.MISSION_COUNT_MAX do
gvars.str_missionClearedFlag[e]=false
end
gvars.mis_isExistOpenMissionFlag=true
gvars.ene_isRecoverdInterpreterAfgh=false
gvars.ene_isRecoverdInterpreterMafr=false
gvars.dbg_autoMissionOpenClearCheck=false
gvars.ini_isTitleMode=false
for e=0,1024 do
gvars.gim_missionStartBreakableObjects[e]=0
gvars.gim_checkPointBreakableObjects[e]=0
gvars.gim_missionStartFultonableObjects[e]=0
gvars.gim_checkPointStartFultonableObjects[e]=0
end
for e=0,511 do
gvars.gim_brekableLightStatus[e]=false
end
for e=0,1999 do
gvars.col_daimondStatus_afgh[e]=0
gvars.col_daimondStatus_mafr[e]=0
gvars.col_isRegisteredInDb_afgh[e]=false
gvars.col_isRegisteredInDb_mafr[e]=false
end
for e=0,32 do
gvars.col_markerStatus_afgh[e]=0
gvars.col_markerStatus_mafr[e]=0
end
local i={"tp_bgm_10_01","tp_bgm_10_02","tp_bgm_10_03","tp_bgm_10_04","tp_bgm_10_05","tp_bgm_10_06","tp_bgm_10_07"}
for i,e in ipairs(i)do
TppMotherBaseManagement.AddCassetteTapeTrack(e)
end
TppMotherBaseManagement.DirectAddResource{resource="Plant2005",count=20,isNew=true}
gvars.solface_groupNumber=(math.random(0,255)*65536)+math.random(1,255)
gvars.hosface_groupNumber=(math.random(0,65535)*65536)+math.random(1,65535)
local t,i
t={{slot=TppDefine.WEAPONSLOT.PRIMARY_HIP,equip=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SECONDARY,equip=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SUPPORT_0,equip=TppEquip.EQP_None},{slot=TppDefine.WEAPONSLOT.SUPPORT_1,equip=TppEquip.EQP_None}}i={TppEquip.EQP_None,TppEquip.EQP_None,TppEquip.EQP_None,TppEquip.EQP_None}
e.SetInitPlayerWeapons(t)
TppPlayer.SupplyAllAmmoFullOnMissionFinalize()
e.SetInitPlayerItems(i)
e.InitializeAllPlatformForNewGame()
end
function e.InitializeForNewMission(e)
TppSave.VarRestoreOnMissionStart()
TppStory.DisableMissionNewOpenFlag(vars.missionCode)
TppClock.RestoreMissionStartClock()
if e.sequence and e.sequence.MISSION_START_INITIAL_WEATHER then
TppWeather.SetMissionStartWeather(e.sequence.MISSION_START_INITIAL_WEATHER)
end
TppWeather.RestoreMissionStartWeather()
TppPlayer.SetInitialPlayerState(e)
TppPlayer.ResetDisableAction()
TppEnemy.RestoreOnMissionStart()
if e.sequence then
TppPlayer.InitItemStockCount()
end
Player.ResetVarsOnMissionStart()
TppPlayer.SetSelfSubsistenceOnHardMission()
TppPlayer.RestoreChimeraWeaponParameter()
if e.sequence and n(e.sequence.playerInitialWeaponTable)then
TppPlayer.SetInitWeapons(e.sequence.playerInitialWeaponTable)
end
TppPlayer.RestorePlayerWeaponsOnMissionStart()
TppPlayer.SetMissionStartAmmoCount()
if e.sequence and n(e.sequence.playerInitialItemTable)then
TppPlayer.SetInitItems(e.sequence.playerInitialItemTable)
end
TppPlayer.RestorePlayerItemsOnMissionStart()
TppUI.OnMissionStart()
local e=TppMission.SetMissionOrderBoxPosition()
if not e then
if TppMission.IsFreeMission(vars.missionCode)then
TppPlayer.SetMissionStartPositionFromNoOrderBoxPosition()
end
end
TppPlayer.SetInitialPositionFromMissionStartPosition()
TppMotherBaseManagement.ClearAllStaffBonusPopupFlag()
TppBuddyService.ResetVarsMissionStart()
if not gvars.ini_isTitleMode then
Vehicle.LoadCarry()
end
Gimmick.RestoreSaveDataPermanentGimmickFromMission()
TppMotherBaseManagement.SetupAfterRestoreFromSVars()
end
function e.InitializeForContinue(e)
TppSave.VarRestoreOnContinueFromCheckPoint()
TppEnemy.RestoreOnContinueFromCheckPoint()
if not TppMission.IsFOBMission(vars.missionCode)then
Gimmick.RestoreSaveDataPermanentGimmickFromCheckPoint()
end
TppMotherBaseManagement.SetupAfterRestoreFromSVars()
vars.requestFlagsAboutEquip=255
if svars.chickCapEnabled then
gvars.elapsedTimeSinceLastUseChickCap=0
end
if e.sequence and e.sequence.ALWAYS_APPLY_TEMPORATY_PLAYER_PARTS_SETTING then
TppPlayer.MissionStartPlayerTypeSetting()
end
if gvars.isContinueFromTitle then
TppMission.IncrementRetryCount()
TppSave.VarSaveOnRetry()
end
end
function e.ClearIsContinueFromTitle()
gvars.isContinueFromTitle=false
end
function e.StartInitMission()
TppSystemLua.UseAiSystem(true)
TppSimpleGameSequenceSystem.Start()
vars.locationCode=TppDefine.LOCATION_ID.INIT
vars.missionCode=TppDefine.SYS_MISSION_ID.INIT
TppMission.VarResetOnNewMission()
TppPlayer.ResetInitialPosition()
TppPlayer.SetStartStatus(TppDefine.INITIAL_PLAYER_STATE.ON_FOOT)
TppSave.VarSave(nil,true)
TppSave.VarSaveConfig()
TppSave.VarSavePersonalData()
TppMission.Load(vars.locationCode,nil,{force=true,showLoadingTips=false})
local e=Fox.GetActMode()
if(e=="EDIT")then
Fox.SetActMode"GAME"end
end
function e.SetInitPlayerWeapons(e)
for e,i in pairs(e)do
local a=i.ammo
local e=i.slot
local t=i.equip
local n=i.ammoMax
local i=i.bulletId
if e>=TppDefine.WEAPONSLOT.SUPPORT_0 and e<=TppDefine.WEAPONSLOT.SUPPORT_3 then
local n=e-TppDefine.WEAPONSLOT.SUPPORT_0
vars.initSupportWeapons[n]=t
vars.ammoStockIds[e]=i
vars.ammoStockCounts[e]=a
else
vars.initWeapons[e]=t
vars.ammoStockIds[e]=i
vars.ammoStockCounts[e]=a
vars.ammoInWeapons[e]=n
vars.isInitialWeapon[e]=1
end
end
end
function e.SetInitPlayerItems(e)
for i,e in pairs(e)do
vars.initItems[i-1]=e
vars.items[i-1]=e
end
end
function e.InitializeAllPlatformForNewGame()
local t=0
local a=1
local i={"Command","Combat","Develop","BaseDev","Support","Spy","Medical"}
local e={"MotherBase","Fob1","Fob2","Fob3","Fob4"}
for a,e in ipairs(e)do
for a,i in ipairs(i)do
TppMotherBaseManagement.SetClusterSvars{base=e,category=i,grade=t,buildStatus="Completed",timeMinute=0,isNew=false}
end
end
TppMotherBaseManagement.SetClusterSvars{base="MotherBase",category="Command",grade=a,buildStatus="Completed",timeMinute=0,isNew=true}
end
function e.SetHorseObtainedAndCanSortie()
TppBuddyService.SetObtainedBuddyType(BuddyType.HORSE)
TppBuddyService.SetSortieBuddyType(BuddyType.HORSE)
end
return e
