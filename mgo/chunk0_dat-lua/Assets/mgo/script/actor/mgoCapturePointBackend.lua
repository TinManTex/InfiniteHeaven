local e={}
local G
local S
local g
local A=.5
local h=false
local u=0
e.PlayersInTrap={}
local r=nil
local l=nil
local c=nil
local n=0
local o=false
local a=false
local i=nil
local d=nil
function e.AddParm(e)
end
function e.RemoveParm(e)
end
function e.Reset(t)t:GetTable().capturePointBackend=e
u=0
e.PlayersInTrap={}r=nil
l=nil
c=nil
n=0
h=true
o=false
a=false
i=nil
d=nil
A=.5
end
e.Construct=e.Reset
e.Reinitialize=e.Reset
function e.Destruct(n)
end
e.Teardown=e.Destruct
function e.Activate(e)h=true
end
function e.Deactivate(e)h=true
end
function e.ProcessSignal(e,e)
end
function e.ExecuteHost(f)
local p=f:GetScaledTime()
local t=f:GetTable().capturePointConfig
local I=r
local m=MpRulesetManager.GetActiveRuleset()
local s={}c=nil
if not f:IsActive()then
if t.cooldownEnabled then
G(p,t.cooldownRate,t.threshold)
end
else
if m==nil or m.GetPlayerFromGameObjectId==nil then
return
end
local g=f:GetMessageValet()
local u=nil
repeat
u=g:PopMessage()
if u then
local e=u:GetType()
if S[e]then
S[e](f,u)
end
end
until not u
local u=(Utils.TeamsneakId==vars.rulesetId or Utils.TeamsneakBaseId==vars.rulesetId)
if u and c~=TeamSneak.defender then
if o and i~=nil then
local e=m:GetPlayerFromGameObjectId(i)
if e==nil then
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="neutralizedA"})o=false
i=nil
end
end
if a and d~=nil then
local e=m:GetPlayerFromGameObjectId(d)
if e==nil then
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="neutralizedB"})a=false
d=nil
end
end
end
local S=false
local m=f:GetTable().capturePointFrontend
if m==nil then
else
c,s,S=m.ValidateCapturers(f,e.PlayersInTrap,o,a)
if u and c~=TeamSneak.defender then
s={}
if o and i~=nil then
table.insert(s,i)
end
if a and d~=nil then
table.insert(s,d)
end
end
end
local e=0
for n,n in ipairs(s)do
e=e+1
end
local a=l~=nil and n==t.threshold
if a and t.stickyCaptureEnabled then
elseif S then
elseif e>0 then
local a=t.captureRate[e]*p
local i=false
if u then
if c~=TeamSneak.attacker then
i=true
end
end
if(l==nil or l==c)and not i then
n=n+a
else
if e<5 then
a=t.captureRate[e+1]*p
end
n=n-a
end
if n<=0 then
n=0
l=nil
r=nil
elseif n>=t.threshold then
n=t.threshold
l=c
r=c
end
if l==nil then
l=c
end
elseif e<=0 and t.cooldownEnabled then
G(p,t.cooldownRate,t.threshold)
end
if r~=I then
h=true
end
end
u=u-p
if h or u<0 then
u=A
h=false
local e=0
local a=-1
if m~=nil and m.GetPlayerFromGameObjectId~=nil then
for l,n in ipairs(s)do
local n=m:GetPlayerFromGameObjectId(n)
if n~=nil then
local n=n.sessionIndex
e=Utils.SetFlag(e,n+1)
end
end
if s~=nil and s[1]~=nil then
local e=m:GetPlayerFromGameObjectId(s[1])a=e.sessionIndex
end
end
local n=n/t.threshold
g(f,l,r,c,n,f:IsActive(),e,a)
end
end
function e.ExecuteIdle(n)
if Mgo.IsHost()then
e.ExecuteHost(n)
end
end
function e.ExecuteClient(e)
local n=e:GetMessageValet()
local e=nil
repeat
e=n:PopMessage()until not e
end
function e.wasNeutralized()
if o==true then
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="neutralizedA"})
end
if a==true then
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="neutralizedB"})
end
o=false
a=false
i=nil
d=nil
end
function e.ExecuteScript(c,t)
if t.command=="SetOwnerTeam"then
if t.ownerTeam==nil then
l=nil
r=nil
n=0
else
local e=c:GetTable().capturePointConfig
l=t.ownerTeam
r=l
n=e.threshold
end
u=0
elseif"neutralized"==t.command then
o=false
a=false
i=nil
d=nil
elseif"FlagPickupA"==t.command then
o=false
i=nil
local n=MpRulesetManager.GetActiveRuleset()
for l,e in ipairs(e.PlayersInTrap)do
local n=n:GetPlayerFromGameObjectId(e)
if t.idx==n.sessionIndex then
o=true
i=e
end
end
elseif"FlagPickupB"==t.command then
a=false
d=nil
local n=MpRulesetManager.GetActiveRuleset()
for l,e in ipairs(e.PlayersInTrap)do
local n=n:GetPlayerFromGameObjectId(e)
if t.idx==n.sessionIndex then
a=true
d=e
end
end
end
end
local t=function(l,e)
for n,e in ipairs(e)do
if l==e then
return n
end
end
return nil
end
function G(e,a,t)
local e=a*e
if r==nil or r~=l then
n=n-e
else
n=n+e
end
if n<=0 then
n=0
l=nil
r=nil
elseif n>=t then
n=t
end
end
S={Enter=function(l,n)
local n=n:GetTriggerSource()
local r,l=MgoActor.FindAttachedTo(n)
if t(n,e.PlayersInTrap)~=nil then
elseif r then
if l:GetParm().MarkerName=="A"then
o=true
i=n
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="flagEnterA"})
else
a=true
d=n
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="flagEnterB"})
end
table.insert(e.PlayersInTrap,n)
else
table.insert(e.PlayersInTrap,n)
end
end,Exit=function(l,n)
local l=n:GetTriggerSource()
local n=t(l,e.PlayersInTrap)
local t,l=MgoActor.FindAttachedTo(l)
if n==nil then
elseif t then
if l:GetParm().MarkerName=="A"then
o=false
i=nil
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="flagExitA"})
else
a=false
d=nil
GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="flagExitB"})
end
table.remove(e.PlayersInTrap,n)
else
table.remove(e.PlayersInTrap,n)
end
end}
function g(r,l,n,e,d,o,a,i)
local t=l
local l=n
local n=e
if t==nil then
t=-1
end
if l==nil then
l=-1
end
if n==nil then
n=-1
end
local e=MgoSerialize.NewStream(49)e:SetMode"W"e:SerializeBoolean(o)e:SerializeInteger(a)e:SerializeInteger(i)e:SerializeNumber(l)e:SerializeNumber(t)e:SerializeNumber(n)e:SerializeNumber(d)MgoSignal.SendSignal(r:GetGameObjectId(),Fox.StrCode32"ALL",e)
end
return e
