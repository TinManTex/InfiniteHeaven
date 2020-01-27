local e={}
local n=GameObject.GetGameObjectId
local n=GameObject.GetTypeIndex
local t=GameObject.SendCommand
local n=GameObject.NULL_ID
e.REINFORCE_TYPE_NAME={"NONE","SOLDIER"}
e.REINFORCE_TYPE=TppDefine.Enum(e.REINFORCE_TYPE_NAME)
e.REINFORCE_FPK={[e.REINFORCE_TYPE.NONE]=""}
e.REINFORCE_SOLDIER_NAMES={"reinforce_soldier_0000","reinforce_soldier_0001","reinforce_soldier_0002","reinforce_soldier_0003"}
function e.GetReinforceBlockId()
return ScriptBlock.GetScriptBlockId(mvars.reinforce_reinforceBlockName)
end
function e.GetReinforceBlockState()
return ScriptBlock.GetScriptBlockState(e.GetReinforceBlockId())
end
function e.IsLoaded()
return e.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
end
function e.IsProcessing()
return e.GetReinforceBlockState()==ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
end
function e.GetFpk(n,o,r)
local e=e.REINFORCE_FPK[n]
if Tpp.IsTypeTable(e)then
local n=""if TppLocation.IsAfghan()then
n="AFGH"elseif TppLocation.IsMiddleAfrica()then
n="MAFR"end
local n=e[o]or e[n]
if Tpp.IsTypeTable(n)then
r=r or"_DEFAULT"if n[r]then
n=n[r]
else
n=nil
end
end
if n then
e=n
else
local n=""for o,r in pairs(e)do
if n==""then
n=r
end
end
e=n
end
end
if not e then
return""end
return e
end
function e.SetUpReinforceBlock()
mvars.reinforce_reinforceBlockName="reinforce_block"local r=false
local o=e.GetReinforceBlockId()r=(o~=ScriptBlock.SCRIPT_BLOCK_ID_INVALID)
mvars.reinforce_hasReinforceBlock=r
if not mvars.reinforce_hasReinforceBlock then
return
end
for r,n in ipairs(e.REINFORCE_SOLDIER_NAMES)do
e._SetEnabledSoldier(n,false)
end
mvars.reinforce_reinforceType=e.REINFORCE_TYPE.NONE
mvars.reinforce_reinforceColoringType=nil
mvars.reinforce_reinforceCpId=n
mvars.reinforce_activated=false
end
function e.LoadReinforceBlock(e,e,e)
end
function e.UnloadReinforceBlock(r)
if not mvars.reinforce_hasReinforceBlock then
return
end
if((r~=nil and r~=n)and mvars.reinforce_reinforceCpId~=n)and mvars.reinforce_reinforceCpId~=r then
return
end
local r=e.GetReinforceBlockId()
if e.GetReinforceBlockState()>ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE then
e.ReinforceBlockOnDeactivate()
end
ScriptBlock.Load(r,"")
mvars.reinforce_reinforceType=e.REINFORCE_TYPE.NONE
mvars.reinforce_reinforceColoringType=nil
mvars.reinforce_reinforceCpId=n
end
function e.StartReinforce(r)
if not mvars.reinforce_hasReinforceBlock then
return
end
if mvars.reinforce_reinforceType==e.REINFORCE_TYPE.NONE then
return
end
if(r~=nil and r~=n)and mvars.reinforce_reinforceCpId~=r then
return
end
local e=e.GetReinforceBlockId()ScriptBlock.Activate(e)
mvars.reinforce_activated=true
end
function e.FinishReinforce(r)
if not mvars.reinforce_hasReinforceBlock then
return
end
if(r~=nil and r~=n)and mvars.reinforce_reinforceCpId~=r then
return
end
local e=e.GetReinforceBlockId()ScriptBlock.Deactivate(e)
mvars.reinforce_activated=false
mvars.reinforce_reinforceCpId=n
end
function e.ReinforceBlockOnInitialize()
mvars.reinforce_lastReinforceBlockState=e.GetReinforceBlockState()
mvars.reinforce_isEnabledSoldiers=false
end
function e.ReinforceBlockOnUpdate()
local r=e.GetReinforceBlockState()
if r==nil then
return
end
local c=ScriptBlock
local n=mvars
local o=n.reinforce_lastReinforceBlockState
local i=c.SCRIPT_BLOCK_STATE_INACTIVE
local c=c.SCRIPT_BLOCK_STATE_ACTIVE
if r==i then
if o==c then
e.ReinforceBlockOnDeactivate()
end
n.reinforce_lastReinforceInactiveToActive=false
elseif r==c then
if n.reinforce_lastReinforceInactiveToActive then
n.reinforce_lastReinforceInactiveToActive=false
e.ReinforceBlockOnActivate()
end
if(not o)or o<=i then
n.reinforce_lastReinforceInactiveToActive=true
end
end
n.reinforce_lastReinforceBlockState=r
end
function e.ReinforceBlockOnActivate()
e._ActivateReinforce()
end
function e.ReinforceBlockOnDeactivate()
e._DeactivateReinforce()
end
function e.ReinforceBlockOnTerminate()
end
function e._HasSoldier()
return true
end
function e._SetEnabledSoldier(e,r)
local e=GameObject.GetGameObjectId(e)
if e==n then
return
end
t(e,{id="SetEnabled",enabled=r})
end
function e._ActivateReinforce()
local t=e._HasSoldier()
local o,c,r,i
local n={}
if t then
mvars.reinforce_isEnabledSoldiers=true
for r,n in ipairs(e.REINFORCE_SOLDIER_NAMES)do
e._SetEnabledSoldier(n,true)
end
o=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[1])c=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[2])r=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[3])i=GameObject.GetGameObjectId("TppSoldier2",e.REINFORCE_SOLDIER_NAMES[4])
table.insert(n,o)
table.insert(n,c)
table.insert(n,r)
table.insert(n,i)
end
GameObject.SendCommand({type="TppCommandPost2"},{id="SetReinforcePrepared"})
end
function e._DeactivateReinforce()
if mvars.reinforce_isEnabledSoldiers then
mvars.reinforce_isEnabledSoldiers=false
for r,n in ipairs(e.REINFORCE_SOLDIER_NAMES)do
e._SetEnabledSoldier(n,false)
end
end
GameObject.SendCommand({type="TppCommandPost2"},{id="SetNominateList"})
end
function e.Messages()
return Tpp.StrCode32Table{GameObject={{msg="RequestLoadReinforce",func=e._OnRequestLoadReinforce},{msg="RequestAppearReinforce",func=e._OnRequestAppearReinforce},{msg="CancelReinforce",func=e._OnCancelReinforce}}}
end
function e.Init(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnReload(n)
e.messageExecTable=Tpp.MakeMessageExecTable(e.Messages())
end
function e.OnMessage(c,t,a,o,i,r,n)
Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,c,t,a,o,i,r,n)
end
function e._OnRequestLoadReinforce(n)
local o=e.REINFORCE_TYPE.NONE
local r
e.LoadReinforceBlock(o,n,r)
end
function e._OnRequestAppearReinforce(n)
e.StartReinforce(n)
end
function e._OnCancelReinforce(n)
if mvars.reinforce_activated then
return
end
e.FinishReinforce(n)
end
return e
