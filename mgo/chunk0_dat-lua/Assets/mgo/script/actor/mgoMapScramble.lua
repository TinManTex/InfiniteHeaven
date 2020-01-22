local e={}
e.playerInJammingZone=false
function e.AddParm(e)e:AddDynamicProperty("int8","MarkerNum")
e.MarkerNum=0
end
function e.RemoveParm(e)e:RemoveDynamicProperty"MarkerNum"end
function e.UpdateOwnership(a,n)
if e.playerInJammingZone==false then
return
end
local a=MpRulesetManager.GetActiveRuleset()
local a=a:GetLocalPlayerTeam()
if n==nil then
MgoMap.UnJam()
elseif a==n then
MgoMap.UnJam()
else
MgoMap.Jam()
end
end
e.MessageHandler={Enter=function(n,a)
e.playerInJammingZone=true
local e=MpRulesetManager.GetActiveRuleset()
local e=e:GetLocalPlayerTeam()
if Domination_Exfil.currentOwnerTeam[n:GetParm().MarkerNum]~=nil then
if Domination_Exfil.currentOwnerTeam[n:GetParm().MarkerNum]~=e then
MgoMap.Jam()
else
MgoMap.UnJam()
end
else
MgoMap.UnJam()
end
end,Exit=function(n,n)
e.playerInJammingZone=false
MgoMap.UnJam()
end}
local function l(l,a)
local t=l:GetMessageValet()
local e=t:PopMessage()
while e do
local n=e:GetType()
if a[n]then
a[n](l,e)
end
e=t:PopMessage()
end
end
function e.Initialize(n)
end
e.Construct=e.Reset
e.Reinitialize=e.Reset
function e.Destruct(n)
end
e.Teardown=e.Destruct
function e.Activate(e)
end
function e.Deactivate(e)
end
function e.Reset(e)
end
function e.ExecuteHost(n)l(n,e.MessageHandler)
end
function e.ExecuteClient(n)l(n,e.MessageHandler)
end
function e.ExecuteScript(a,n)
if n.command=="UpdateOwnership"then
if a:GetParm().MarkerNum==n.domPtIndex then
e.UpdateOwnership(n.domPtIndex,n.teamIndex)
end
else
local e=GeoTrapBody.GetByName("dom_map_scramble_trap000"..n.command)
e.enable=false
Util.SetInterval(2e3,false,"mgoMapScramble","EnableTrap",e)
end
end
function e.EnableTrap(e)
e.enable=true
end
return e
