local e={}
local h=2
local l=8
local M=16
local y=32
local G=64
local S=256
local T=512
local E=1024
local P=2048
local N=4096
local i=nil
local l=nil
local t=0
local n=0
local I=.01
local u=.02
local d={}
local r={}
local s
local m
local f
function e.AddParm(e)e:AddDynamicProperty("String","MarkerName")
e.MarkerName="A"e:AddDynamicProperty("String","GenericPOITag")
e.GenericPOITag="GENERIC_01"e:AddDynamicProperty("EntityLink","SoundObject")
e.SoundObject=nil
end
function e.RemoveParm(e)e:RemoveDynamicProperty"MarkerName"e:RemoveDynamicProperty"GenericPOITag"e:RemoveDynamicProperty"SoundObject"end
function e.Construct(a)a:GetTable().capturePointFrontend=e
a:GetTable().capturePointConfig={threshold=120,captureRate={[1]=10,[2]=18,[3]=24,[4]=29,[5]=33,[6]=33,[7]=33,[8]=33},stickyCaptureEnabled=false,cooldownEnabled=true,cooldownRate=6}
if not i then
local e=a:GetParm().GenericPOITag
local e={type=TppPoi.POI_TYPE_GENERIC,tags={"DOMINATION","CONTROL_POINT",e}}i=Utils.POIinitialize(a,e)
end
l=nil
t=0
n=0
local n=nil
local o=nil
local c=false
local i=false
s(a,l,n,o,c,t,i)m(a,l,i,t)r[a:GetParm().MarkerName]=false
f(a,n,t)a:SetActive(true)
end
e.Reset=e.Construct
e.Reinitialize=e.Construct
function e.Destruct(l)Utils.POIdestruct(l,i)i=nil
l:GetTable().capturePointFrontend=nil
l:GetTable().capturePointConfig=nil
l:SetActive(false)
end
e.Teardown=e.Destruct
function e.Activate(e)
end
function e.Deactivate(e)
end
function e.ExecuteIdle(e)
end
function e.ExecuteHost(e)
end
function e.ExecuteClient(e)
end
function e.ExecuteScript(e,e)
end
function e.ProcessSignal(o,e)
local c=false
local n=nil
local a=nil
local d=false
local u=l
local r=0
local i=nil
if e==nil then
n=nil
l=nil
t=0
else
e:SetMode"R"c=e:SerializeBoolean(c)r=e:SerializeInteger(r)i=e:SerializeInteger(i)l=e:SerializeNumber(l)n=e:SerializeNumber(n)a=e:SerializeNumber(a)t=e:SerializeNumber(t)
if i==-1 then
i=nil
end
if n==-1 then
n=nil
end
if l==-1 then
l=nil
end
if a==-1 then
a=nil
end
end
local e=MpRulesetManager.GetActiveRuleset()
if e==nil or e.GetLocalPlayerSessionIndex==nil then
return
end
local h=e:GetLocalPlayerSessionIndex()
for e=0,15 do
if Utils.TestFlag(r,e+1)then
if e==h then
d=true
end
end
end
s(o,l,n,a,d,t,c)m(o,l,c,t)f(o,n,t)
local n=(l~=u and l==nil)
local c=((l~=u and l~=nil)and t==1)
if Mgo.IsHost()then
local t={}
if e==nil or e.GetPlayerBySessionIndex==nil then
return
end
for l=0,15 do
if Utils.TestFlag(r,l+1)then
local e=e:GetPlayerBySessionIndex(l)
if e~=nil then
table.insert(t,e)
end
end
end
local t=nil
local d=nil
if i~=nil then
local l=e:GetPlayerBySessionIndex(i)t=e:GetGameObjectIdFromPlayer(l):GetId()d=l.teamIndex
end
local t="Capturing"if(n)then
t="Neutral"elseif c then
t="Captured"end
local n=o:GetGameObjectId():GetId()
if a==nil then
a=-1
end
local l=MgoSerialize.NewStream(48)l:SetMode"W"Utils.SerializeEvent(l,n,Fox.StrCode32(t),a,r)MgoSignal.SendSignal(e:GetRulesetGameObjectId(),Fox.StrCode32"HOST",l)
end
end
function e.ValidateCapturers(e,o)
local e=MpRulesetManager.GetActiveRuleset()
if e==nil or e.GetPlayerFromGameObjectId==nil then
return nil,{},false
end
local n=nil
local r={}
local i=false
local l=0
local t=0
local a=e.currentState
if(a=="RULESET_STATE_ROUND_REGULAR_PLAY"or a=="RULESET_STATE_ROUND_OVERTIME")or a=="RULESET_STATE_ROUND_SUDDEN_DEATH"then
for n,a in ipairs(o)do
local e=e:GetPlayerFromGameObjectId(a)
if e~=nil and e.teamIndex~=nil then
if PlayerInfo.OrCheckStatus(e.sessionIndex,{PlayerStatus.REALIZED})then
if not PlayerInfo.OrCheckStatus(e.sessionIndex,{PlayerStatus.UNCONSCIOUS,PlayerStatus.CQC_HOLD_BY_ENEMY,PlayerStatus.FULTONED,PlayerStatus.CHARMED})then
table.insert(r,a)
local e=e.teamIndex
if e==Utils.Team.SOLID then
l=l+1
else
t=t+1
end
end
end
end
end
end
if l>0 and t>0 then
i=true
end
if t>0 then
n=Utils.Team.LIQUID
elseif l>0 then
n=Utils.Team.SOLID
end
return n,r,i
end
function s(l,o,c,d,f,n,e)
if e then
local a=MpRulesetManager.GetActiveRuleset()
local e=nil
if a~=nil and a.GetLocalPlayerTeam~=nil then
e=a:GetLocalPlayerTeam()
end
local t={}t.data=math.floor(.5+(n*255))
local i=G
local n=T
local r=P
local s=0
if(Entity.IsNull(a)or o==nil)or e==nil then
i=M
elseif o==e then
i=y
end
if(Entity.IsNull(a)or c==nil)or e==nil then
n=0
elseif c==e then
n=S
end
if(Entity.IsNull(a)or d==nil)or e==nil then
r=0
elseif d==e then
r=E
end
if f then
s=N
end
t.flags=(((h+i)+n)+r)+s
if l:GetParm().MarkerName=="A"then
t.goalType=0
elseif l:GetParm().MarkerName=="B"then
t.goalType=1
elseif l:GetParm().MarkerName=="C"then
t.goalType=2
end
l:EnableMarker(l:GetParm().MarkerName)l:UpdateMarker(t)
else
l:DisableMarker()
end
end
function f(a,t,n)
local e=MpRulesetManager.GetActiveRuleset()
local l=nil
if e~=nil and e.GetLocalPlayerTeam~=nil then
l=e:GetLocalPlayerTeam()
end
local e=a:GetParm().SoundObject
if not Entity.IsNull(e)then
local e=e:GetDataBody()
if not Entity.IsNull(e)then
if e:IsPlaying()then
if t==nil or t==l then
e:SetSwitch("DOMINATION_TEAM_OWNER","FRIENDLY",0)
else
e:SetSwitch("DOMINATION_TEAM_OWNER","ENEMY",0)
end
e:SetRTPC("DOMINATION_CAPTURE_RATIO",n,0)
end
end
end
end
function m(e,t,c,o)
local i=MpRulesetManager.GetActiveRuleset()
local a=nil
local l=nil
if i~=nil and i.GetLocalPlayerTeam~=nil then
a=i:GetLocalPlayerTeam()
else
return
end
n=n+e:GetScaledTime()
if((n>I and n<u)and o<1)and o>0 then
TppDataUtility.SetVisibleEffectFromGroupId("domLightBlue_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightRed_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightWhite_"..e:GetParm().MarkerName,false)r[e:GetParm().MarkerName]=true
else
if t~=nil and t==a then
l="domLightBlue_"elseif t~=nil and t~=a then
l="domLightRed_"elseif t==nil or a==nil then
l="domLightWhite_"end
if d[e:GetParm().MarkerName]==nil then
r[e:GetParm().MarkerName]=true
end
if l~=d[e:GetParm().MarkerName]or r[e:GetParm().MarkerName]==true then
if d[e:GetParm().MarkerName]then
TppDataUtility.SetVisibleEffectFromGroupId("domLightBlue_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightRed_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightWhite_"..e:GetParm().MarkerName,false)
end
d[e:GetParm().MarkerName]=l
l=l..e:GetParm().MarkerName
TppDataUtility.SetVisibleEffectFromGroupId(l,c)r[e:GetParm().MarkerName]=false
end
end
if n>u then
n=0
end
end
return e
