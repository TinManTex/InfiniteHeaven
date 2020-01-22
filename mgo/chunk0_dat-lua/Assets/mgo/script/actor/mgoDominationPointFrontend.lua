local e={}
local N=2
local l=8
local M=16
local G=32
local S=64
local I=256
local T=512
local p=1024
local P=2048
local h=4096
local i=nil
local l=nil
local t=0
local n=0
local y=.01
local u=.02
local d={}
local o={}
local s
local f
local m
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
local i=nil
local c=nil
local r=false
local n=false
s(a,l,i,c,r,t,n)f(a,l,n,t)o[a:GetParm().MarkerName]=false
m(a,i,t)a:SetActive(true)
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
local a=nil
local n=nil
local u=false
local d=l
local r=0
local i=nil
if e==nil then
a=nil
l=nil
t=0
else
e:SetMode"R"c=e:SerializeBoolean(c)r=e:SerializeInteger(r)i=e:SerializeInteger(i)l=e:SerializeNumber(l)a=e:SerializeNumber(a)n=e:SerializeNumber(n)t=e:SerializeNumber(t)
if i==-1 then
i=nil
end
if a==-1 then
a=nil
end
if l==-1 then
l=nil
end
if n==-1 then
n=nil
end
end
local e=MpRulesetManager.GetActiveRuleset()
if e==nil or e.GetLocalPlayerSessionIndex==nil then
return
end
local G=e:GetLocalPlayerSessionIndex()
for e=0,15 do
if Utils.TestFlag(r,e+1)then
if e==G then
u=true
end
end
end
s(o,l,a,n,u,t,c)f(o,l,c,t)m(o,a,t)
local s=(l~=d and l==nil)
local c=((l~=d and l~=nil)and t==1)
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
local a=nil
local t=nil
if i~=nil then
local l=e:GetPlayerBySessionIndex(i)a=e:GetGameObjectIdFromPlayer(l):GetId()t=l.teamIndex
end
local t="Capturing"if(s)then
t="Neutral"elseif c then
t="Captured"end
local a=o:GetGameObjectId():GetId()
local l=MgoSerialize.NewStream(48)l:SetMode"W"Utils.SerializeEvent(l,a,Fox.StrCode32(t),n,r)MgoSignal.SendSignal(e:GetRulesetGameObjectId(),Fox.StrCode32"HOST",l)
end
end
function e.ValidateCapturers(e,r)
local e=MpRulesetManager.GetActiveRuleset()
if e==nil or e.GetPlayerFromGameObjectId==nil then
return nil,{},false
end
local a=nil
local i={}
local n=false
local l=0
local t=0
for n,a in ipairs(r)do
local e=e:GetPlayerFromGameObjectId(a)
if e~=nil and e.teamIndex~=nil then
if not PlayerInfo.OrCheckStatus(e.sessionIndex,{PlayerStatus.UNCONSCIOUS,PlayerStatus.CQC_HOLD_BY_ENEMY})then
table.insert(i,a)
local e=e.teamIndex
if e==Utils.Team.SOLID then
l=l+1
else
t=t+1
end
end
end
end
if l>0 and t>0 then
n=true
end
if t>0 then
a=Utils.Team.LIQUID
elseif l>0 then
a=Utils.Team.SOLID
end
return a,i,n
end
function s(e,o,s,c,f,n,l)
if l then
local a=MpRulesetManager.GetActiveRuleset()
local l=nil
if a~=nil and a.GetLocalPlayerTeam~=nil then
l=a:GetLocalPlayerTeam()
end
local t={}t.data=math.floor(.5+(n*255))
local r=S
local i=T
local n=P
local d=0
if(Entity.IsNull(a)or o==nil)or l==nil then
r=M
elseif o==l then
r=G
end
if(Entity.IsNull(a)or s==nil)or l==nil then
i=0
elseif s==l then
i=I
end
if(Entity.IsNull(a)or c==nil)or l==nil then
n=0
elseif c==l then
n=p
end
if f then
d=h
end
t.flags=(((N+r)+i)+n)+d
if e:GetParm().MarkerName=="A"then
t.goalType=0
elseif e:GetParm().MarkerName=="B"then
t.goalType=1
elseif e:GetParm().MarkerName=="C"then
t.goalType=2
end
e:EnableMarker(e:GetParm().MarkerName)e:UpdateMarker(t)
else
e:DisableMarker()
end
end
function m(a,t,n)
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
function f(e,t,c,r)
local i=MpRulesetManager.GetActiveRuleset()
local a=nil
local l=nil
if i~=nil and i.GetLocalPlayerTeam~=nil then
a=i:GetLocalPlayerTeam()
else
return
end
n=n+e:GetScaledTime()
if((n>y and n<u)and r<1)and r>0 then
TppDataUtility.SetVisibleEffectFromGroupId("domLightBlue_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightRed_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightWhite_"..e:GetParm().MarkerName,false)o[e:GetParm().MarkerName]=true
else
if t~=nil and t==a then
l="domLightBlue_"elseif t~=nil and t~=a then
l="domLightRed_"elseif t==nil or a==nil then
l="domLightWhite_"end
if d[e:GetParm().MarkerName]==nil then
o[e:GetParm().MarkerName]=true
end
if l~=d[e:GetParm().MarkerName]or o[e:GetParm().MarkerName]==true then
if d[e:GetParm().MarkerName]then
TppDataUtility.SetVisibleEffectFromGroupId("domLightBlue_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightRed_"..e:GetParm().MarkerName,false)
TppDataUtility.SetVisibleEffectFromGroupId("domLightWhite_"..e:GetParm().MarkerName,false)
end
d[e:GetParm().MarkerName]=l
l=l..e:GetParm().MarkerName
TppDataUtility.SetVisibleEffectFromGroupId(l,c)o[e:GetParm().MarkerName]=false
end
end
if n>u then
n=0
end
end
return e
