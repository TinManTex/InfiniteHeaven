local e={}
e.RequestQueue={}
e.REFRESH_DELTA=15
e.elapsedTime=0
local n={HOST_STATE=0}
e.partsIndex=nil
local function t(r,t)
local e=MgoSerialize.NewStream(32)e:SetMode"W"e:SerializeInteger(n.HOST_STATE)e:SerializeNumber(t)MgoSignal.SendSignal(r:GetGameObjectId(),Fox.StrCode32"ALL",e)
end
function e.ProcessSignal(r,t)t:SetMode"R"local r=t:SerializeInteger(e.MSG_ID_ROTATION)
if n.HOST_STATE==r then
e.rot=t:SerializeNumber(rotation)
end
end
function e.Construct(t)
e.RequestQueue={}
if e.partsIndex==nil then
local r,n=MgoParts.Realize("/Assets/mgo/parts/objective/antenna.parts",1,1,0,1)
if r then
e.partsIndex=n
e.ResetParts(t)
end
end
t:SetActive(true)
end
function e.Reset(e)e:SetActive(false)
end
function e.Activate(e)e:SetActive(true)
end
function e.Deactivate(t)
e.RequestQueue={}t:SetActive(false)
end
function e.Destruct(t)t:DetachAndTearDownAllParts()t:SetActive(false)
end
e.Reinitialize=e.Construct
e.Teardown=e.Destruct
function e.ExecuteIdle(t)
if e.partsIndex~=nil then
e.rot=e.rot+.01
if e.rot>360 then
e.rot=0
end
t:SetTransform(Matrix4.RotTranslation(Quat.RotationY(e.rot),e.worldPos))
end
end
e.worldPos=Vector3(0,0,0)
e.rot=0
function e.ExecuteHost(t)
if(t:IsActive()==false)then
return
end
if e.partsIndex~=nil then
e.rot=e.rot+.01
if e.rot>360 then
e.rot=0
end
t:SetTransform(Matrix4.RotTranslation(Quat.RotationY(e.rot),e.worldPos))
end
end
function e.ExecuteClient(t)
if t:IsActive()==false then
return
end
if e.partsIndex~=nil then
e.rot=e.rot+.01
if e.rot>360 then
e.rot=0
end
t:SetTransform(Matrix4.RotTranslation(Quat.RotationY(e.rot),e.worldPos))
end
end
function e.ExecuteScript(e,e)
end
function e.ResetParts(n,t)
if e.partsIndex~=nil then
if t==nil then
t=n:GetInitialTransform()
end
n:SetTransform(t)n:AttachParts(e.partsIndex)
local t=t:GetTranslation()
e.worldPos=t
end
end
return e
