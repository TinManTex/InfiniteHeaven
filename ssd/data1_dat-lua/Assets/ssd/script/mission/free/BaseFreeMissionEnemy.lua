local r={}
local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local t=Tpp.IsTypeTable
local i=GameObject.GetGameObjectId
local e=GameObject.GetGameObjectIdByIndex
function r.CreateInstance(n)
local e={}
e.requires={}
e.missionName=n
e.soldierDefine={cp_base={nil},nil}
e.routeSets={cp_base={priority={"groupA"},sneak_day={groupA={}},sneak_night={groupA={}},caution={groupA={}},hold={default={}},nil},nil}
e.combatSetting={cp_base={},nil}
function e.InitEnemy()
end
function e.SetUpEnemy()
e.SetWave()
e.SetWormHoleDropInstanceCount()
e.SetVehicle()
e.SetWalkerGear()
e.SetCreature()
e.SetStartKaiju(true)
end
function e.OnLoad()
end
function e.GetSpawnLocatorNames(t)
local n=e.waveSettingTable
if Tpp.IsTypeTable(n)then
local a={}
local n=n[t]
while n do
if n.endLoop then
break
end
local t=n.spawnTableName
if t then
local t=e.spawnSettingTable[t]
if Tpp.IsTypeTable(t)then
local t=t.locatorSet
if Tpp.IsTypeTable(t)then
local t=t.spawnLocator
if t then
local o=true
for n,e in ipairs(a)do
if e==t then
o=false
end
end
if o then
table.insert(a,t)
end
n=e.waveSettingTable[n.nextWave]
else
n=nil
end
end
end
end
end
return a
end
end
function e.SetWave()
if mvars.loc_locationCommomnWaveSettings then
local e={mvars.loc_locationCommomnWaveSettings.waveList,mvars.loc_locationCommomnWaveSettings.propertyTable,mvars.loc_locationCommomnWaveSettings.waveTable,mvars.loc_locationCommomnWaveSettings.spawnPointDefine}
TppMission.RegisterFreePlayWaveSetting(e)
TppMission.SetUpWaveSetting{e}
end
end
function e.SetCreature()
local e=e.creatureDataTable
if t(e)then
for n,e in pairs(e)do
if e.enemytype=="SsdZombie"or e.enemytype=="SsdZombieDash"then
local t={type=e.enemytype}
if e.route then
local e={id="SetSneakRoute",route=e.route,name=n,point=0}
GameObject.SendCommand(t,e)
end
elseif e.enemytype=="SsdInsect1"then
local t=GameObject.GetGameObjectId(e.enemytype,n)
if t~=NULL_ID then
if e.route then
local e={id="SetSneakRoute",route=e.route,name=n,point=0}
GameObject.SendCommand(t,e)
end
if e.target then
local e={id="SetSneakTarget",target=e.target}
GameObject.SendCommand(t,e)
end
end
elseif e.enemytype=="SsdInsect2"then
local t=GameObject.GetGameObjectId(e.enemytype,n)
if t~=NULL_ID then
if e.route then
local e={id="SetSneakRoute",route=e.route,name=n,point=0}
GameObject.SendCommand(t,e)
end
if e.isStiction then
local e={id="SetSpider",isProwl=true,isStiction=true}
GameObject.SendCommand(t,e)
end
end
end
end
end
end
function e.SetVehicle()
local e=e.spawnList
if t(e)then
for n,e in ipairs(e)do
GameObject.SendCommand({type="TppVehicle2"},e)
end
end
end
function e.SetWalkerGear()
local e=e.walkerGearTableList
if t(e)then
for e,n in ipairs(e)do
local e=i(n.name)
if e~=NULL_ID then
GameObject.SendCommand(e,{id="SetEnabled",enabled=false})
if n.coloringType then
GameObject.SendCommand(e,{id="SetColoringType",type=n.coloringType})
end
end
end
end
end
function e.SetWormHoleDropInstanceCount()
if t(mvars.loc_locationWormholeQuest)and t(mvars.loc_locationWormholeQuest.wormholeDropInstanceCountTable)then
for n,e in pairs(mvars.loc_locationWormholeQuest.wormholeDropInstanceCountTable)do
if GameObject.GetGameObjectIdByIndex(e.gameObjectType,0)~=GameObject.NULL_ID then
local n={type=e.gameObjectType}
local e={id="SetDropInstanceCount",count=e.count}
GameObject.SendCommand(n,e)
end
end
end
end
function e.SetStartKaiju(r)
local a=TppStory.GetCurrentStorySequence()
local n=nil
local e=e.kaijuRailList
local i={}
local l=nil
local o=false
if a<=TppDefine.STORY_SEQUENCE.CLEARED_k40030 or a>=TppDefine.STORY_SEQUENCE.CLEARED_STORY_LAST then
return
end
if t(e)then
for n,e in ipairs(e)do
if e.railName and e.pos then
if a==e.sequence and e.isPriority==true then
l=e
elseif a>=e.sequence then
table.insert(i,e)
end
end
end
if l~=nil then
n=l
else
if#i==0 then
return
end
local e=math.random(1,#i)n=i[e]
end
if t(n)then
o=false
if a>=TppDefine.STORY_SEQUENCE.CLEARED_AFGH_LAST and a<=TppDefine.STORY_SEQUENCE.BEFORE_STORY_LAST then
if r==true or TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")and n.pos then
TppEnemy.SetKaijuRailOneArmedStartPosition(n.railName,n.pos)
else
TppEnemy.SetKaijuRailOneArmed(n.railName)
end
o=true
else
if r==true or TppGameStatus.IsSet("","S_IN_BASE_CHECKPOINT")and n.pos then
TppEnemy.SetKaijuRailStartPosition(n.railName,n.pos)
else
TppEnemy.SetKaijuRail(n.railName)
end
o=true
end
if o==true then
TppEnemy.SetEnableKaiju()
end
end
end
end
function e.SetEndKaiju()
TppEnemy.SetDisableKaiju()
local e=e.KaijuEnableTimer or(60*2)GkEventTimerManager.Start("TimerKaijuEnable",e)
end
return e
end
return r
