local e={}
local n=Tpp.IsTypeTable
local n=GameObject.SendCommand
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
e.GMP_POSTER=500
e.keyItemAnnounceLogTable={}
e.keyItemRewardTable={}
e.parasiteSquadFultonResouceId={}
e.setUpMenuList={}
e.MBDVCMENU={ALL="all"}
e.RESOURCE_INFORMATION_TABLE={[TppCollection.TYPE_MATERIAL_CM_0]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_1]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_2]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_3]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_4]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_5]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_6]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_CM_7]={resourceName="CommonMetal",count=100},[TppCollection.TYPE_MATERIAL_MM_0]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_1]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_2]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_3]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_4]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_5]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_6]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_MM_7]={resourceName="MinorMetal",count=50},[TppCollection.TYPE_MATERIAL_PM_0]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_1]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_2]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_3]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_4]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_5]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_6]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_PM_7]={resourceName="PreciousMetal",count=10},[TppCollection.TYPE_MATERIAL_FR_0]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_1]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_2]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_3]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_4]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_5]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_6]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_FR_7]={resourceName="FuelResource",count=100},[TppCollection.TYPE_MATERIAL_BR_0]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_1]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_2]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_3]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_4]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_5]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_6]={resourceName="BioticResource",count=100},[TppCollection.TYPE_MATERIAL_BR_7]={resourceName="BioticResource",count=100},[TppCollection.TYPE_HERB_G_CRESCENT]={resourceName="Plant2000",count=10},[TppCollection.TYPE_HERB_A_PEACH]={resourceName="Plant2001",count=10},[TppCollection.TYPE_HERB_DIGITALIS_P]={resourceName="Plant2002",count=10},[TppCollection.TYPE_HERB_DIGITALIS_R]={resourceName="Plant2003",count=10},[TppCollection.TYPE_HERB_B_CARROT]={resourceName="Plant2004",count=10},[TppCollection.TYPE_HERB_WORM_WOOD]={resourceName="Plant2005",count=10},[TppCollection.TYPE_HERB_TARRAGON]={resourceName="Plant2006",count=10},[TppCollection.TYPE_HERB_HAOMA]={resourceName="Plant2007",count=10},[TppCollection.TYPE_POSTER_SOL_AFGN]={resourceName="Poster1000",count=1},[TppCollection.TYPE_POSTER_SOL_MAFR]={resourceName="Poster1001",count=1},[TppCollection.TYPE_POSTER_SOL_ZRS]={resourceName="Poster1002",count=1},[TppCollection.TYPE_POSTER_GRAVURE_V]={resourceName="Poster1003",count=1},[TppCollection.TYPE_POSTER_GRAVURE_H]={resourceName="Poster1004",count=1},[TppCollection.TYPE_POSTER_MOE_V]={resourceName="Poster1005",count=1},[TppCollection.TYPE_POSTER_MOE_H]={resourceName="Poster1006",count=1}}
e.BLUE_PRINT_LOCATOR_TABLE={}
e.BLUE_PRINT_LANG_ID={}
function e.UpdateGMP(e)
end
function e.CorrectGMP(e)
end
function e.AddStaffsFromTempBuffer(e,e)
end
function e.ReserveMissionStartMbSync()
end
function e.StartSyncMbManagementOnMissionStart()
end
function e.VarSaveMbMissionStartSyncEnd()
end
function e.AcquireKeyItem(e)
end
function e.ReserveHelicopterSoundOnMissionGameEnd()
end
function e.UnSetUsageRestriction(n)
TppUiCommand.SetMbTopMenuItemActive(e.MBDVCMENU.ALL,n)
end
function e.AcquirePrivilegeInTitleScreen()
e.AcquireGzPrivilegeKeyItem()
e.AcquireDlcItemKeyItem()
end
function e.AcquireGzPrivilegeKeyItem()
end
function e.AcquireDlcItemKeyItem()
end
function e.AcquireGzPrivilege(e,e)
end
function e.AcquireDlcItem(e,e,e)
end
function e.EraseDlcItem(e,e,e)
end
function e.OnAllocate(e)
mvars.trm_fultonInfo={}
end
function e.Init(n)
if n.sequence then
if n.sequence.ALLWAYS_DIRECT_ADD_STAFF then
mvars.trm_isAlwaysDirectAddStaff=true
end
if n.sequence.SKIP_ADD_STAFF_TO_TEMP_BUFFER then
mvars.trm_isAlwaysDirectAddStaff=true
end
if n.sequence.SKIP_ADD_RESOURCE_TO_TEMP_BUFFER then
mvars.trm_isSkipAddResourceToTempBuffer=true
end
end
mvars.trm_voiceDisabled=mvars.trm_voiceDisabled or false
e.SetUp()
e.ReleaseFreePlay()
TppUiCommand.SetAllInvalidMbSoundControllerVoice(false)
TppUiCommand.ClearMbDvcOpenConditionRequest()
end
function e.MakeMessage()
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(n)
e.Init(n)
e.MakeMessage()
end
function e.OnMissionGameStart(e)
end
function e.Messages()
return Tpp.StrCode32Table{GameObject={{msg="Fulton",func=function(t,o,n,r)
e.OnFultonMessage(t,o,n,r)
end,option={isExecMissionClear=true,isExecDemoPlaying=true}},{msg="FultonInfo",func=function(t,o,n)
e.OnFultonInfoMessage(t,o,n)
end,option={isExecMissionClear=true,isExecDemoPlaying=true}},{msg="FultonFailedEnd",func=e.OnFultonFailedEnd}},Weather={{msg="WeatherForecast",func=e.TerminalVoiceWeatherForecast}}}
end
function e.OnMessage(n,i,a,c,t,r,o)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,n,i,a,c,t,r,o)
end
function e.OnFultonMessage(e,n,o,t)
mvars.trm_fultonInfo=mvars.trm_fultonInfo or{}
mvars.trm_fultonInfo[e]={e,n,o,t}
end
function e.OnFultonInfoMessage(o,t,r)
mvars.trm_fultonInfo=mvars.trm_fultonInfo or{}
local n=mvars.trm_fultonInfo[o]
if n then
e.OnFulton(n[1],n[2],n[3],n[4],nil,nil,t,r)
mvars.trm_fultonInfo[o]=nil
end
mvars.trm_fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo or{}
local n=mvars.trm_fultonFaileEndInfo[o]
if n then
e._OnFultonFailedEnd(n[1],n[2],n[3],n[4],t)
mvars.trm_fultonFaileEndInfo[o]=nil
end
end
function e.SetUp()
e.SetUpStorySsdStart()
TppUiStatusManager.UnsetStatus("Subjective","SUPPORT_NO_USE")
end
function e.OnFulton(e,o,t,r,a,n,c,i)
if n then
mvars.trm_needHeliSoundOnAddStaffsFromTempBuffer=true
end
TppEnemy.SetRecovered(e)
TppEnemy.ExecuteOnRecoveredCallback(e,o,t,r,a,n,c)
if Tpp.IsLocalPlayer(c)then
TppEnemy._OnFulton(e,o,t,r)
end
end
function e.IncrementRecoveredSoldierCount()
gvars.trm_recoveredSoldierCount=gvars.trm_recoveredSoldierCount+1
end
function e.GetRecoveredSoldierCount()
return gvars.trm_recoveredSoldierCount
end
function e.IncrementRecoveredHostageCount()
gvars.trm_recoveredHostageCount=gvars.trm_recoveredHostageCount+1
end
function e.GetRecoveredHostageCount()
return gvars.trm_recoveredHostageCount
end
function e.IsEqualOrMoreTotalFultonCount(n)
local e=gvars.trm_recoveredSoldierCount+gvars.trm_recoveredHostageCount
if(e>=n)then
return true
else
return false
end
end
function e.GetRecoveredAfghGoatCount()
return gvars.trm_recoveredAfghGoatCount
end
function e.GetRecoveredMafrGoatCount()
return gvars.trm_recoveredMafrGoatCount
end
function e.GetRecoveredDonkeyCount()
return gvars.trm_recoveredDonkeyCount
end
function e.GetRecoveredZebraCount()
return gvars.trm_recoveredZebraCount
end
function e.GetRecoveredOkapiCount()
return gvars.trm_recoveredOkapiCount
end
function e.IsRecoveredCompleatedGoat()
return false
end
function e.IsRecoveredCompleatedHorse()
return false
end
function e.IsRecoveredCompleatedDog()
return false
end
function e.IsRecoveredCompleatedBear()
return false
end
function e.GetAnimalTypeCountFromRecoveredHistory(o)
local e=0
for n=0,(TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1)do
if gvars.trm_animalRecoverHistory[n]==o then
e=e+1
end
end
return e
end
function e.AddAnimalRecoverHistory(n)
local e=gvars.trm_animalRecoverHistorySize
if e<TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE then
gvars.trm_animalRecoverHistory[e]=n
gvars.trm_animalRecoverHistorySize=e+1
else
for e=1,(TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1)do
gvars.trm_animalRecoverHistory[e-1]=gvars.trm_animalRecoverHistory[e]
end
gvars.trm_animalRecoverHistory[TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE-1]=n
gvars.trm_animalRecoverHistorySize=TppDefine.MAX_ANIMAL_RECOVERED_HISTORY_SIZE
end
end
function e.IsAnimalDog(e)
return false
end
function e.IsAnimalHorse(e)
return false
end
function e.IsAnimalBear(e)
return false
end
function e.IsAnimalGoat(e)
return false
end
function e.AddTempStaffFulton(e)
end
function e.AddTempResource(e,e,e)
end
function e.AddTempDataBase(e)
end
function e.AddTempDataBaseAnimal(e,e)
end
function e.AddPickedUpResourceToTempBuffer(e,e)
end
function e.SetUpStorySsdStart()
end
function e.StopChangeDayTerminalAnnounce()
mvars.trm_stopChangeDayTerminalAnnounce=true
end
function e.StartChangeDayTerminalAnnounce()
mvars.trm_stopChangeDayTerminalAnnounce=nil
end
function e.TerminalVoiceWeatherForecast(n)
local o={[TppDefine.WEATHER.SUNNY]="VOICE_WEATHER_CLAER",[TppDefine.WEATHER.CLOUDY]=nil,[TppDefine.WEATHER.RAINY]=nil,[TppDefine.WEATHER.SANDSTORM]="VOICE_WEATHER_SANDSTORM",[TppDefine.WEATHER.FOGGY]=nil}
local t={[TppDefine.WEATHER.SUNNY]="weather_sunny",[TppDefine.WEATHER.CLOUDY]="weather_cloudy",[TppDefine.WEATHER.RAINY]="weather_rainy",[TppDefine.WEATHER.SANDSTORM]="weather_sandstorm",[TppDefine.WEATHER.FOGGY]="weather_foggy"}
local o=o[n]
local n=t[n]
if o then
e.PlayTerminalVoice(o)
end
if n then
TppUI.ShowAnnounceLog(n)
end
end
function e.TerminalVoiceOnSupportFireIncoming()
e.PlayTerminalVoice"VOICE_SUPPORT_FIRE_INCOMING"end
function e.SetBaseTelopName(e)
mvars.trm_baseTelopCpName=e
end
function e.ClearBaseTelopName()
mvars.trm_baseTelopCpName=nil
end
function e.GetLocationAndBaseTelop()
return mvars.trm_currentIntelCpName or mvars.trm_baseTelopCpName
end
function e.ShowLocationAndBaseTelop()
if TppUiCommand.IsStartTelopCast and TppUiCommand.IsStartTelopCast()then
return
end
TppUiCommand.RegistInfoTypingText("location",1)
local e=e.GetLocationAndBaseTelop()
if e then
TppUiCommand.RegistInfoTypingText("cpname",2,e)
end
TppUiCommand.ShowInfoTypingText()
end
function e.OnExitCpIntelTrap(e)
mvars.trm_currentIntelCpName=nil
if Player.OnExitBase~=nil then
Player.OnExitBase()
end
end
function e.OpenAllSection()
end
function e.OnEstablishMissionClear()
end
function e.ReleaseFreePlay()
end
function e.PickUpBluePrint(t,o)
local n=nil
if o then
n=o
else
n=mvars.trm_bluePrintLocatorIdTable[t]
end
if not n then
return
end
e.AddTempDataBase(n)
local e=e.BLUE_PRINT_LANG_ID[n]
TppUI.ShowAnnounceLog("get_blueprint",e)
end
function e.InitializeBluePrintLocatorIdTable()
mvars.trm_bluePrintLocatorIdTable={}
for e,n in pairs(e.BLUE_PRINT_LOCATOR_TABLE)do
local e=TppCollection.GetUniqueIdByLocatorName(e)
mvars.trm_bluePrintLocatorIdTable[e]=n
end
end
function e.GetBluePrintKeyItemId(e)
return mvars.trm_bluePrintLocatorIdTable[e]
end
function e.EnableTerminalVoice(e)
mvars.trm_voiceDisabled=not e
end
function e.PlayTerminalVoice(n,e,o)
if mvars.trm_voiceDisabled and e~=false then
return
end
TppUiCommand.RequestMbSoundControllerVoice(n,e,o)
end
function e.OnFultonFailedEnd(e,t,n,o)
mvars.trm_fultonFaileEndInfo=mvars.trm_fultonFaileEndInfo or{}
mvars.trm_fultonFaileEndInfo[e]={e,t,n,o}
end
function e._OnFultonFailedEnd(n,n,n,n,e)
if Tpp.IsLocalPlayer(e)then
TppUI.ShowAnnounceLog"extractionFailed"end
end
function e.HasVehicle()
return false
end
function e._SetUpDvcMenu(n)
if not Tpp.IsTypeTable(n)then
return
end
TppUiCommand.InitAllMbTopMenuItemVisible(false)
TppUiCommand.InitAllMbTopMenuItemActive(true)
e.EnableDvcMenuByList(n)
end
function e.EnableDvcMenuByList(e)
for n=1,table.getn(e)do
if e[n]==nil then
return
else
TppUiCommand.SetMbTopMenuItemVisible(e[n].menu,true)
if e[n].active~=nil then
TppUiCommand.SetMbTopMenuItemActive(e[n].menu,e[n].active)
end
end
end
end
function e.SetUpDvcMenuAll()
TppUiCommand.InitAllMbTopMenuItemVisible(true)
TppUiCommand.InitAllMbTopMenuItemActive(true)
end
function e.SetActiveTerminalMenu(n)
if not Tpp.IsTypeTable(n)then
return
end
if n[1]==e.MBDVCMENU.ALL then
TppUiCommand.InitAllMbTopMenuItemActive(true)
else
TppUiCommand.InitAllMbTopMenuItemActive(false)
for e=1,table.getn(n)do
if n[e]==nil then
return
else
TppUiCommand.SetMbTopMenuItemActive(n[e],true)
end
end
end
end
return e
