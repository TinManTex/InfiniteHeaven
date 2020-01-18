local e={}
local d=ScriptBlock.GetCurrentScriptBlockId
local t=ScriptBlock.GetScriptBlockState
local r=GameObject.NULL_ID
local i=Tpp.IsTypeTable
local c=Tpp.IsTypeString
local n="animal_block"local p=Tpp.CheckBlockArea
local a={Goat={type="TppGoat",locatorFormat="anml_goat_%02d",routeFormat="rt_anml_goat_%02d",nightRouteFormat="rt_anml_goat_n%02d",isHerd=true,isDead=false},Wolf={type="TppWolf",locatorFormat="anml_wolf_%02d",routeFormat="rt_anml_wolf_%02d",nightRouteFormat="rt_anml_wolf_n%02d",isHerd=true,isDead=false},Nubian={type="TppNubian",locatorFormat="anml_nubian_%02d",routeFormat="rt_anml_nubian_%02d",nightRouteFormat="rt_anml_nubian_n%02d",isHerd=true,isDead=false},Jackal={type="TppJackal",locatorFormat="anml_jackal_%02d",routeFormat="rt_anml_jackal_%02d",nightRouteFormat="rt_anml_jackal_n%02d",isHerd=true,isDead=false},Zebra={type="TppZebra",locatorFormat="anml_Zebra_%02d",routeFormat="rt_anml_Zebra_%02d",nightRouteFormat="rt_anml_Zebra_n%02d",isHerd=true,isDead=false},Bear={type="TppBear",locatorFormat="anml_bear_%02d",routeFormat="rt_anml_bear_%02d",nightRouteFormat="rt_anml_bear_n%02d",isHerd=false,isDead=false},BuddyPuppy={type="TppBuddyPuppy",locatorFormat="anml_BuddyPuppy_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false},MotherDog={type="TppJackal",locatorFormat="anml_MotherDog_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=true},Rat={type="TppRat",locatorFormat="anml_rat_%02d",routeFormat="rt_anml_rat_%02d",nightRouteFormat="rt_anml_rat_%02d",isHerd=false,isDead=false},NoAnimal={type="NoAnimal",locatorFormat="anml_NoAnimal_%02d",routeFormat="rt_anml_BuddyPuppy_%02d",nightRouteFormat="rt_anml_BuddyPuppy_%02d",isHerd=false,isDead=false}}
local t={Goat={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},Wolf={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},Bear={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},Nubian={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},Jackal={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},Zebra={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},BuddyPuppy={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},MotherDog={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},Rat={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"},NoAnimal={nightStartTime="18:00:00",nightEndTime="06:00:00",timeLag="00:10:00"}}
local m=5
e.CLOCK_MESSAGE_AT_NIGHT_FORMAT="AnimalRouteChangeAtNight%02d"e.CLOCK_MESSAGE_AT_MORNING_FORMAT="AnimalRouteChangeAtMorning%02d"e.weatherTable={}
local l=0
local o=0
function e.GetDefaultTimeTable(e)
if e=="Goat"then
return t.Goat
elseif e=="Wolf"then
return t.Wolf
elseif e=="Bear"then
return t.Bear
elseif e=="Nubian"then
return t.Nubian
elseif e=="Jackal"then
return t.Jackal
elseif e=="Zebra"then
return t.Zebra
elseif e=="BuddyPuppy"then
return t.BuddyPuppy
elseif e=="MotherDog"then
return t.MotherDog
elseif e=="Rat"then
return t.Rat
elseif e=="NoAnimal"then
return t.NoAnimal
else
return nil
end
end
function e.StopAnimalBlockLoad()
mvars.anm_stopAnimalBlockLoad=true
end
function e.UpdateLoadAnimalBlock(i,o)
if mvars.anm_stopAnimalBlockLoad then
return
end
local t=mvars
local a=t.loc_locationAnimalSettingTable
local l=a.animalAreaSetting
local a=a.MAX_AREA_NUM
if not a then
return
end
local e,a=e._GetAnimalBlockAreaName(l,a,"loadArea",i,o)
if e~=nil then
t.animalBlockAreaName=a
t.animalBlockKeyName=e
TppScriptBlock.Load(n,e)
else
t.animalBlockAreaName=nil
t.animalBlockKeyName=nil
TppScriptBlock.Unload(n)
end
end
function e.GetCurrentAnimalBlockAreaName()
local e=mvars.animalBlockAreaName
if e==nil then
end
return e
end
function e._UpdateActiveAnimalBlock(a,o)
local t=mvars.loc_locationAnimalSettingTable
local l=t.animalAreaSetting
local t=t.MAX_AREA_NUM
if not t then
return
end
local t,e=e._GetAnimalBlockAreaName(l,t,"activeArea",a,o)
if e~=nil then
local e=ScriptBlock.GetScriptBlockId(n)
TppScriptBlock.ActivateScriptBlockState(e)
else
local e=ScriptBlock.GetScriptBlockId(n)
TppScriptBlock.DeactivateScriptBlockState(e)
end
end
function e._GetAnimalBlockAreaName(e,t,l,n,a)
local o=e
for t=1,t do
local t=e[t]
local e=t[l]
if p(e,n,a)then
for a,e in ipairs(t.defines)do
if(not Tpp.IsTypeFunc(e.conditionFunc))or(e.conditionFunc())then
local a=TppClock.GetTime"number"return e.keyList[a%#e.keyList+1],t.areaName
end
end
end
end
end
function e._GetSetupTable(e)
if e=="Goat"then
return a.Goat
elseif e=="Wolf"then
return a.Wolf
elseif e=="Bear"then
return a.Bear
elseif e=="Nubian"then
return a.Nubian
elseif e=="Jackal"then
return a.Jackal
elseif e=="Zebra"then
return a.Zebra
elseif e=="BuddyPuppy"then
return a.BuddyPuppy
elseif e=="MotherDog"then
return a.MotherDog
elseif e=="Rat"then
return a.Rat
elseif e=="NoAnimal"then
return a.NoAnimal
else
return nil
end
end
function e._IsNight(e,t,a)
local e=(e<a)or(e>=t)
return e
end
function e._IsNightForAnimalType(t,a)
local t=e.GetDefaultTimeTable(t)
local n=t.nightStartTime
local n=TppClock.ParseTimeString(n,"number")
local t=t.nightEndTime
local t=TppClock.ParseTimeString(t,"number")
return e._IsNight(a,n,t)
end
function e._InitializeCommonAnimalSetting(o,a,t)
local l=1
if i(a)then
l=a.groupNumber or 0
end
local n=a.nightStartTime
if n==nil then
n=e.GetDefaultTimeTable(o).nightStartTime
end
local r=TppClock.ParseTimeString(n,"number")
local n=a.nightEndTime
if n==nil then
n=e.GetDefaultTimeTable(o).nightEndTime
end
local c=TppClock.ParseTimeString(n,"number")
local n=a.timeLag
if n==nil then
n=e.GetDefaultTimeTable(o).timeLag
end
local o=TppClock.ParseTimeString(n,"number")
local i=TppClock.GetTime"number"local n=0
if t.isDead==false then
if t.isHerd==false then
for a=0,(l-1)do
n=o*a
if e._IsNight(i,r+n,c+n)then
e._SetRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
else
e._SetRoute(t.type,t.locatorFormat,t.routeFormat,a)
end
end
else
for a=0,(l-1)do
n=o*a
if e._IsNight(i,r+n,c+n)then
e._SetHerdRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
else
e._SetHerdRoute(t.type,t.locatorFormat,t.routeFormat,a)
end
end
end
else
e._ChangeDeadState(t.type,a.position,a.degRotationY)
end
end
function e._SetHerdRoute(e,a,n,t)
local e={type=e,index=0}
if e==r then
return
end
local a=string.format(a,t)
local t=string.format(n,t)
local t={id="SetHerdEnabledCommand",type="Route",name=a,instanceIndex=0,route=t}
GameObject.SendCommand(e,t)
end
function e._SetRoute(e,a,n,t)
local e={type=e,index=0}
if e==r then
return
end
local a=string.format(a,t)
local t=string.format(n,t)
local t={id="SetRoute",name=a,route=t}
GameObject.SendCommand(e,t)
end
function e._ChangeDeadState(e,t,a)
local e={type=e,index=0}
if e==r then
return
end
local n=t or Vector3(0,0,0)
local t=a or 0
local t={id="ChangeDeadState",position=n,degRotationY=t}
GameObject.SendCommand(e,t)
end
function e._RegisterWeatherTable(t,a,n)
e.weatherTable[l]={msg="Clock",sender=t,func=function(l,a)
if n then
n(t,a)
else
e._ChangeRouteAtTime(t,a)
end
end}l=l+1
end
function e._RegisterClockMessage(t,i,o,n,a,l)
local t=string.format(t,a)
e._RegisterWeatherTable(t,n,l)
local e=i+o*a
local e=TppClock.FormalizeTime(e,"string")
TppClock.RegisterClockMessage(t,e)
return t
end
function e._AddClockMessage(n,t,a,r)
local a=1
if i(t)then
a=t.groupNumber or 0
end
if r+a>m then
return
end
local m=r+a
local a=t.nightStartTime
if a==nil then
a=e.GetDefaultTimeTable(n).nightStartTime
end
local c=TppClock.ParseTimeString(a,"number")
local a=t.nightEndTime
if a==nil then
a=e.GetDefaultTimeTable(n).nightEndTime
end
local i=TppClock.ParseTimeString(a,"number")
local t=t.timeLag
if t==nil then
t=e.GetDefaultTimeTable(n).timeLag
end
local t=TppClock.ParseTimeString(t,"number")l=0
for a=r,m-1 do
e._RegisterClockMessage(e.CLOCK_MESSAGE_AT_NIGHT_FORMAT,c,t,true,a)
e._RegisterClockMessage(e.CLOCK_MESSAGE_AT_MORNING_FORMAT,i,t,false,a)o=o+1
end
end
function e._ChangeRouteAtTime(t,m)
local a=mvars.loc_locationAnimalSettingTable
local o=a.animalTypeSetting[mvars.animalBlockKeyName]
local a=-1
for e in string.gmatch(t,"%d+")do
a=tonumber(e)
end
if a==-1 then
return
end
local l=0
local n=nil
local r=nil
for m,e in pairs(o)do
local o
local t
if c(e)then
o=e
elseif i(e)then
o=m
t=e
end
local e=t.groupNumber or 0
if l<=a and a<l+e then
n=o
r=t
break
end
l=l+e
end
if n==nil or r==nil then
return
end
local t=e._GetSetupTable(n)
if t==nil then
return
end
local a=a-l
local l=e._IsNightForAnimalType(n,m)
if n=="Bear"then
if l then
e._SetRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
else
e._SetRoute(t.type,t.locatorFormat,t.routeFormat,a)
end
else
if l then
e._SetHerdRoute(t.type,t.locatorFormat,t.nightRouteFormat,a)
else
e._SetHerdRoute(t.type,t.locatorFormat,t.routeFormat,a)
end
end
end
function e._MakeMessageExecTable()
mvars.animalBlockScript.messageExecTable=Tpp.MakeMessageExecTable(mvars.animalBlockScript.Messages)
end
function e._GetAnimalBlockState()
local e=ScriptBlock.GetScriptBlockId(n)
if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
return ScriptBlock.GetScriptBlockState(e)
end
function e.InitializeBlockStatus()
local e=ScriptBlock.GetScriptBlockId(n)
if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
return
end
TppScriptBlock.ClearSavedScriptBlockInfo(e)
end
function e.OnActivateAnimalBlock(e)
for e,e in pairs(e)do
end
end
function e.OnInitializeAnimalBlock()coroutine.yield()coroutine.yield()
if not mvars.animalBlockKeyName then
return
end
mvars.animalBlockScript.DidInitialized=true
mvars.animalBlockScript.Messages=Tpp.StrCode32Table{Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=function(t,a)
e._UpdateActiveAnimalBlock(t,a)
end}}}o=0
e.weatherTable={}
local t=mvars.loc_locationAnimalSettingTable
local t=t.animalTypeSetting[mvars.animalBlockKeyName]
local l=0
for o,n in pairs(t)do
local t
local a
if c(n)then
t=n
elseif i(n)then
t=o
a=n
end
local n=e._GetSetupTable(t)
if n~=nil and t~="NoAnimal"then
e._InitializeCommonAnimalSetting(t,a,n)
e._AddClockMessage(t,a,n,l)
TppFreeHeliRadio.RegistAnimalOptionalRadio(t)
local e=a.groupNumber or 0
l=l+e
end
end
local t=Tpp.StrCode32Table{Weather=e.weatherTable}
mvars.animalBlockScript.Messages=Tpp.MergeTable(mvars.animalBlockScript.Messages,t,false)
mvars.animalBlockScript.OnReload=e.OnReload
function mvars.animalBlockScript.OnMessage(a,n,t,l,i,r,o)
Tpp.DoMessage(mvars.animalBlockScript.messageExecTable,TppMission.CheckMessageOption,a,n,t,l,i,r,o)
end
e._MakeMessageExecTable()
end
function e.OnReload()
if not mvars.loc_locationAnimalSettingTable or not mvars.animalBlockKeyName then
return
end
local t=mvars.loc_locationAnimalSettingTable
local t=t.animalTypeSetting[mvars.animalBlockKeyName]
local a=0
for r,n in pairs(t)do
local t
local l
if c(n)then
t=n
elseif i(n)then
t=r
l=n
end
local e=e._GetSetupTable(t)
if e~=nil and t~="NoAnimal"then
local e=l.groupNumber or 0
if a+e>m then
break
end
a=a+e
end
end
o=a
e._MakeMessageExecTable()
end
function e.OnAllocate(a)
local t=d()
TppScriptBlock.InitScriptBlockState(t)
mvars.animalBlockScript=a
local t,a=Tpp.GetCurrentStageSmallBlockIndex()
e._UpdateActiveAnimalBlock(t,a)
function mvars.animalBlockScript.OnMessage(e,e,e,e,e,e,e)
end
end
function e.OnTerminate()
if mvars.animalBlockScript.DidInitialized then
for a=0,o-1 do
local t=string.format(e.CLOCK_MESSAGE_AT_NIGHT_FORMAT,a)
TppClock.UnregisterClockMessage(t)t=string.format(e.CLOCK_MESSAGE_AT_MORNING_FORMAT,a)
TppClock.UnregisterClockMessage(t)
end
end
local e=d()
TppScriptBlock.FinalizeScriptBlockState(e)
TppFreeHeliRadio.UnregistAnimalOptionalRadio()
mvars.animalBlockScript.DidInitialized=nil
mvars.animalBlockScript.OnReload=nil
mvars.animalBlockScript.OnMessage=nil
mvars.animalBlockScript=nil
end
return e
