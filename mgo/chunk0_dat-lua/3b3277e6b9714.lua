local this={}
local h=4
local n=8
local S=16
local P=32
local m=64
local I=1024
local f=2048
local G=4096
local a=nil
local t=nil
local l=0
local d=false
local n
function this.AddParm(e)
e:AddDynamicProperty("String","MarkerName")
  e.MarkerName="A"e:AddDynamicProperty("String","GenericPOITag")
  e.GenericPOITag="GENERIC_01"e:AddDynamicProperty("EntityLink","SoundObject")
  e.SoundObject=nil
end
function this.RemoveParm(e)e:RemoveDynamicProperty"MarkerName"e:RemoveDynamicProperty"GenericPOITag"e:RemoveDynamicProperty"SoundObject"end
function this.Construct(n)n:GetTable().capturePointFrontend=this
  n:GetTable().capturePointConfig={threshold=120,captureRate={[1]=20,[2]=120,[3]=120,[4]=120,[5]=120,[6]=120,[7]=120,[8]=120},stickyCaptureEnabled=true,cooldownEnabled=true,cooldownRate=6}
  if not a then
    local e=n:GetParm().GenericPOITag
    local e={type=TppPoi.POI_TYPE_GENERIC,tags={"CONTROL_POINT",e}}a=Utils.POIinitialize(n,e)
  end
  t=nil
  l=0
  local t=false
  local t=nil
  local a=false
  UpdateUI(n,t,false,false,l,a)
  this.UpdateSoundFx(n,nil,l)
  n:SetActive(true)
end
this.Reset=this.Construct
this.Reinitialize=this.Construct
function this.Destruct(n)Utils.POIdestruct(n,a)a=nil
  n:GetTable().capturePointFrontend=nil
  n:GetTable().capturePointConfig=nil
  n:SetActive(false)
end
this.Teardown=this.Destruct
function this.Activate(e)
end
function this.Deactivate(e)
end
function this.ProcessSignal(e,e)
end
function this.ExecuteIdle(e)
end
function this.ExecuteHost(e)
end
function this.ExecuteClient(e)
end
function this.ExecuteScript(e,e)
end
function this.ProcessSignal(i,n)
  local a=i:GetGameObjectId():GetId()
  local d=false
  local r=nil
  local f=t
  local o=nil
  local s=false
  local u=false
  local c=0
  local a=nil
  if n==nil then
    r=nil
    t=nil
    l=0
  else
    n:SetMode"R"d=n:SerializeBoolean(d)c=n:SerializeInteger(c)a=n:SerializeInteger(a)t=n:SerializeNumber(t)r=n:SerializeNumber(r)o=n:SerializeNumber(o)l=n:SerializeNumber(l)
    if a==-1 then
      a=nil
    end
    if r==-1 then
      r=nil
    end
    if t==-1 then
      t=nil
    end
  end
  local n=MpRulesetManager.GetActiveRuleset()
  if n==nil or n.GetLocalPlayerSessionIndex==nil then
    return
  end
  local r=n:GetLocalPlayerSessionIndex()
  for e=0,15 do
    if Utils.TestFlag(c,e+1)then
      if e==r then
        s=true
      end
      u=true
    end
  end
  UpdateUI(i,TeamSneak.attacker,s,u,l,d)
  if(n.currentState~="RULESET_STATE_ROUND_REGULAR_PLAY"and n.currentState~="RULESET_STATE_ROUND_OVERTIME")and n.currentState~="RULESET_STATE_ROUND_SUDDEN_DEATH"then
    this.UpdateSoundFx(i,o,0)
  else
    this.UpdateSoundFx(i,o,l)
  end
  local o=((l==0 and o==TeamSneak.defender)and c~=0)
  local d=((t~=f and t~=nil)and l==1)
  if Mgo.IsHost()and(o or d)then
    local l={}
    if n==nil or n.GetPlayerBySessionIndex==nil then
      return
    end
    for e=0,15 do
      if Utils.TestFlag(c,e+1)then
        local e=n:GetPlayerBySessionIndex(e)
        if e~=nil then
          table.insert(l,e)
        end
      end
    end
    local t=nil
    local r=nil
    if a~=nil then
      local e=n:GetPlayerBySessionIndex(a)t=n:GetGameObjectIdFromPlayer(e):GetId()r=e.teamIndex
    end
    local l="Neutral"if d then
      l="Captured"elseif o then
      local e=i:GetTable().capturePointBackend
      e.wasNeutralized()
    end
    local a=i:GetGameObjectId():GetId()
    local e=MgoSerialize.NewStream(48)e:SetMode"W"Utils.SerializeEvent(e,a,Fox.StrCode32(l),r,t)MgoSignal.SendSignal(n:GetRulesetGameObjectId(),Fox.StrCode32"HOST",e)
  end
end
function this.ValidateCapturers(e,o,t,a)
  local l=MpRulesetManager.GetActiveRuleset()
  if l==nil or l.GetPlayerFromGameObjectId==nil then
    return nil,{},false
  end
  local e=nil
  if t or a then
    e=TeamSneak.attacker
  end
  local c={}
  local r=false
  local i=false
  local n=false
  for r,o in ipairs(o)do
    local l=l:GetPlayerFromGameObjectId(o)
    if l~=nil and l.teamIndex~=nil then
      if t or a then
        table.insert(c,o)
        if e~=l.teamIndex then
          n=true
        else
          i=true
        end
      end
    end
  end
  if n and i then
    r=true
  elseif n then
    e=TeamSneak.defender
  end
  return e,c,r
end
function UpdateUI(t,a,r,c,l,e)
  if e then
    local activeRuleset=MpRulesetManager.GetActiveRuleset()
    local localPlayerTeam=nil
    if activeRuleset~=nil and activeRuleset.GetLocalPlayerTeam~=nil then
      localPlayerTeam=activeRuleset:GetLocalPlayerTeam()
    end
    local o={}
    o.data=math.floor(.5+(l*255))
    local i=m
    local l=0
    if(Entity.IsNull(activeRuleset)or a==nil)or localPlayerTeam==nil then
      i=S
    elseif a==localPlayerTeam then
      i=P
    end
    if r then
      l=G
    elseif c then
      if a==localPlayerTeam then
        l=I
      else
        l=f
      end
    end
    o.flags=(h+i)+l
    t:EnableMarker(t:GetParm().MarkerName)
    t:UpdateMarker(o)
  else
    t:DisableMarker()
  end
end
function this.UpdateSoundFx(l,e,n)
  local e=MpRulesetManager.GetActiveRuleset()
  local t=nil
  if e~=nil and e.GetLocalPlayerTeam~=nil then
    t=e:GetLocalPlayerTeam()
  end
  local e=l:GetParm().SoundObject
  if not Entity.IsNull(e)then
    local e=e:GetDataBody()
    if((not Entity.IsNull(e)and n>0)and n<1)and d==false then
      d=true
      e:PostEvent"sfx_UI_Uploading_LP"elseif n<=0 then
      d=false
      e:StopEvent()
    elseif n>=1 and d==true then
      d=false
      e:StopEvent()e:PostEvent"sfx_UI_Uploading_Complete_Sting"end
    if e:IsPlaying()then
      e:SetRTPC("meters_pitch",n,0)
    end
  end
end
return this
