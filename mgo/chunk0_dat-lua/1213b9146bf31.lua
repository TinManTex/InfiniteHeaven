local e={}
e.pushToParent={}
local A={HOST_STATE=0,INTERACTION=1}
local O="/Assets/mgo/parts/objective/floppy_disk.parts"
local k="CNP_HEAD"
local E=Vector3{0,.15,0}
local I=1
local t=16
local G=32
local u=64
local f=30
local C=1.5
local l=true
local i=0
local d=Vector3{0,0,0}
local a=-1
local c=false
local S=nil
local t=nil
local M={}
local o=false
local r=-1
local h
local m
local s
local g
local T
local P
function e.AddParm(e)e:AddDynamicProperty("String","MarkerName")
  e.MarkerName="A"e:AddDynamicProperty("String","GenericPOITag")
  e.GenericPOITag="GENERIC_01"end
function e.RemoveParm(e)e:RemoveDynamicProperty"MarkerName"e:RemoveDynamicProperty"GenericPOITag"end
function e.Construct(n)
  if not S then
    local e=n:GetParm().GenericPOITag
    local e={type=TppPoi.POI_TYPE_GENERIC,tags={"OBJECTIVE",e}}
    S=Utils.POIinitialize(n,e)
  end
  i=0
  C=1.5
  a=-1
  f=30
  c=false
  n:GetTable().AttachedToPlayerIndex=-1
  l=true
  o=false
  r=-1
  local a=n:GetInitialTransform()
  n:SetTransform(a)
  d=a:GetTranslation()
  if t==nil then
    n:DetachAndTearDownAllParts()
    local e=nil
    e,t=MgoParts.Realize(O,1,1)
    if not e then
      t=nil
    else
      n:AttachParts(t)
      MgoParts.SetVisibility(t,true)
    end
  end
  M={attachmentPoint=k,attachmentBone="SKL_004_HEAD",localMatrix=Matrix4.Translation(E)}
  n:SetActive(true)
  s(n,n:IsActive(),n:GetTable().AttachedToPlayerIndex)
  P=vars.optionShowMissionInfo
end
e.Reset=e.Construct
e.Reinitialize=e.Construct
function e.Destruct(a)Utils.POIdestruct(a,S)S=nil
  if t then
    MgoParts.StopEffect(t,"Icon")MgoParts.SetVisibility(t,false)
  end
  a:DetachAndTearDownAllParts()a:GetTable().AttachedToPlayerIndex=-1
  a:DisableMarker()a:SetActive(false)s(a,a:IsActive(),a:GetTable().AttachedToPlayerIndex)
end
e.Teardown=e.Destruct
function e.Activate(e)l=true
end
function e.Deactivate(e)l=true
end
function e.ExecuteIdle(e)h(e,o,r)
end
function e.ExecuteHost(t)
  local n=t:GetScaledTime()
  local s=MpRulesetManager.GetActiveRuleset()
  if t:GetTable().AttachedToPlayerIndex<0 and a>0 then
    a=a-n
    if a<=0 and c==false then
      a=-1
      local a=t:GetInitialTransform()d=a:GetTranslation()
      e.LineChecker.OnResultReady(t,true,d,nil)
      local t=t:GetGameObjectId():GetId()
      local e=MgoSerialize.NewStream(33)e:SetMode"W"Utils.SerializeEvent(e,t,Fox.StrCode32"flagreturn")MgoSignal.SendSignal(s:GetRulesetGameObjectId(),Fox.StrCode32"LOCAL",e)
    end
  else
    a=-1
  end
  i=i-n
  if l or i<0 then
    i=C
    l=false
    local e=t:GetTable().AttachedToPlayerIndex
    g(t,t:IsActive(),e,d)
  end
  h(t,o,r)
end
function e.ExecuteClient(e)h(e,o,r)
end
function e.ExecuteScript(e,e)
end
function e.ProcessSignal(a,i)
  if i==nil then
    return
  end
  i:SetMode"R"local c=nil
  c=i:SerializeInteger(c)
  if Mgo.IsHost()and c==A.INTERACTION then
    local c=MpRulesetManager.GetActiveRuleset()
    local n=nil
    local o=nil
    n=i:SerializeInteger(n)o=i:SerializeInteger(o)
    local r=MgoActor.GetPlayerGameObjectId(n)
    local r,i=MgoActor.FindAttachedTo(r)l=true
    if((o==MgoActor.ACTOR_PLAYER_ACTION_PICKUP and not r)and a:GetTable().AttachedToPlayerIndex==-1)and not PlayerInfo.OrCheckStatus(n,{PlayerStatus.CHARMED,PlayerStatus.UNCONSCIOUS})then
      a:GetTable().AttachedToPlayerIndex=n
      local e=a:GetGameObjectId():GetId()
      local l=MgoSerialize.NewStream(33)l:SetMode"W"Utils.SerializeEvent(l,e,Fox.StrCode32"flagPickup",-1,attachedToId)MgoSignal.SendSignal(c:GetRulesetGameObjectId(),Fox.StrCode32"LOCAL",l)
      if a:GetParm().MarkerName=="A"then
        GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="FlagPickupA",flagId=e,idx=n})
      else
        GameObject.SendCommand({type="MgoActor"},{id="ExecuteScriptAll",command="FlagPickupB",flagId=e,idx=n})
      end
      if n==0 then
        if vars.optionShowMissionInfo==0 then
          MgoParts.CreateEffect(t,"Icon")
        end
      end
      TeamSneak.OnFlagStateChange(a,true,a:GetParm().MarkerName)
    elseif o==MgoActor.ACTOR_PLAYER_ACTION_DROP then
      MgoParts.StopEffect(t,"Icon")
      local t=a:GetTransform():GetTranslation()
      local n=Vector3.Add(t,Vector3.Scale(10,Vector3(0,-1,0)))
      e.LineChecker.RequestLineCheck(a,T,t,n,MgoActor.GEO_COL_F_CHK_ALL,MgoActor.CATEGORY_CHARA,MgoActor.GEO_COL_ATR_PLAYER)
    end
  elseif c==A.HOST_STATE then
    local e=nil
    o=i:SerializeBoolean(o)
    r=i:SerializeInteger(r)
    e=i:SerializeVector3(e)
    m(a,o,r,e)
    s(a,o,r)
  end
end
function h(a,e,r)
  local l=(r~=-1)
  if e then
    local n=MpRulesetManager.GetActiveRuleset()
    local o=nil
    if n~=nil and n.GetLocalPlayerTeam~=nil then
      o=n:GetLocalPlayerTeam()
    end
    local e={}
    e.data=math.floor(.5+(.5*255))
    if o==TeamSneak.attacker then
      if l then
        e.flags=I+G
      else
        e.flags=I+u
      end
    else
      if l then
        e.flags=I+u
      else
        e.flags=I+G
      end
    end
    a:UpdateMarker(e)
    if l and o==TeamSneak.defender then
      a:DisableMarker(true)
    else
      if n:GetLocalPlayerSessionIndex()==r then
        a:DisableMarker(true)
      else
        a:EnableMarker(a:GetParm().MarkerName)
      end
    end
    local e=false
    if P~=vars.optionShowMissionInfo then
      P=vars.optionShowMissionInfo
      e=true
    end
    if e then
      if vars.optionShowMissionInfo==1 or not l then
        MgoParts.StopEffect(t,"Icon")
      else
        if o==TeamSneak.defender then
          MgoParts.CreateEffect(t,"Icon")
          if MgoParts.SendMessageVector4 then
            MgoParts.SendMessageVector4(t,"Icon","color",Vector4(1,.024,0,1))
          end
        elseif n:GetLocalPlayerSessionIndex()==r then
          MgoParts.CreateEffect(t,"Icon")
        end
      end
    end
  else
    a:DisableMarker()
  end
end
function m(a,e,o,r)
  local n=MpRulesetManager.GetActiveRuleset()
  if n==nil then
    return
  end
  local l=a:GetAttachedToGameObject()
  local e=nil
  if o>=0 then
    e=MgoActor.GetPlayerGameObjectId(o)
  end
  if(e==nil or not e:IsSet())and l:IsSet()then
    a:Detach()
  elseif(e~=nil and e:IsSet())and not l:IsSet()then
    a:AttachToGameObject(e:GetId(),M)
  elseif(e~=nil and e:IsSet())and l:GetId()~=e:GetId()then
    a:Detach()a:AttachToGameObject(e:GetId(),M)
  end
  if(e==nil or not e:IsSet())then
    local e=a:GetInitialTransform():Translate(r)a:SetTransform(e)MgoParts.SetVisibility(t,true)MgoParts.StopEffect(t,"Icon")
  else
    MgoParts.SetVisibility(t,false)
    local e=nil
    if n~=nil and n.GetLocalPlayerTeam~=nil then
      e=n:GetLocalPlayerTeam()
    end
    if vars.optionShowMissionInfo==0 then
      if e==TeamSneak.defender then
        MgoParts.CreateEffect(t,"Icon")
        if MgoParts.SendMessageVector4 then
          MgoParts.SendMessageVector4(t,"Icon","color",Vector4(1,.024,0,1))
        end
      elseif n:GetLocalPlayerSessionIndex()==o then
        MgoParts.CreateEffect(t,"Icon")
      end
    end
  end
end
function s(n,o,l)
  local t=MpRulesetManager.GetActiveRuleset()
  local a=nil
  local e=nil
  if t~=nil and t.GetLocalPlayerTeam~=nil then
    a=t:GetLocalPlayerTeam()e=t:GetLocalPlayerSessionIndex()
  end
  local t=MgoActor.GetPlayerGameObjectId(e)
  local t,r=MgoActor.FindAttachedTo(t)n:RemoveActionForPlayer()
  if((not o or a==nil)or e==nil)or PlayerInfo.OrCheckStatus(e,{PlayerStatus.CHARMED,PlayerStatus.UNCONSCIOUS})then
  elseif l==e then
    n:AddActionForPlayer(MgoActor.ACTOR_PLAYER_ACTION_DROP,8192,MgoActor.ACTOR_PLAYER_ACTION_PERMISSION_ALLOW_TEAM,TeamSneak.attacker)
  elseif((not t and a==TeamSneak.attacker)and l==-1)and not PlayerInfo.AndCheckStatus(e,{PlayerStatus.UNCONSCIOUS})then
    n:AddActionForPlayer(MgoActor.ACTOR_PLAYER_ACTION_PICKUP,2,MgoActor.ACTOR_PLAYER_ACTION_PERMISSION_ALLOW_TEAM,TeamSneak.attacker)
  end
end
function g(n,l,t,a)
  local e=MgoSerialize.NewStream(29)e:SetMode"W"e:SerializeInteger(A.HOST_STATE)e:SerializeBoolean(l)e:SerializeInteger(t)e:SerializeVector3(a)MgoSignal.SendSignal(n:GetGameObjectId(),Fox.StrCode32"ALL",e)
end
function e.HandlePlayerAction(n,t,a)
  local e=MgoSerialize.NewStream(24)e:SetMode"W"e:SerializeInteger(A.INTERACTION)e:SerializeInteger(t)e:SerializeInteger(a)MgoSignal.SendSignal(n:GetGameObjectId(),Fox.StrCode32"HOST",e)
end
function e.ExecuteScript(t,n)
  if not Mgo.IsHost()then
    return
  end
  if"dropFlag"==n.command then
    if t:GetTable().AttachedToPlayerIndex==n.playerIndex then
      e.HandlePlayerAction(t,n.playerIndex,MgoActor.ACTOR_PLAYER_ACTION_DROP)
    end
  elseif"flagEnterA"==n.command then
    if t:GetParm().MarkerName=="A"then
      c=true
    end
  elseif"flagEnterB"==n.command then
    if t:GetParm().MarkerName=="B"then
      c=true
    end
  elseif"flagExitA"==n.command then
    if t:GetParm().MarkerName=="A"then
      c=false
      if t:GetTable().AttachedToPlayerIndex==-1 then
        a=f
        l=true
      end
    end
  elseif"flagExitB"==n.command then
    if t:GetParm().MarkerName=="B"then
      c=false
      if t:GetTable().AttachedToPlayerIndex==-1 then
        a=f
        l=true
      end
    end
  elseif"neutralizedA"==n.command then
    if t:GetParm().MarkerName=="A"then
      a=.5
      c=false
    end
  elseif"neutralizedB"==n.command then
    if t:GetParm().MarkerName=="B"then
      a=.5
      c=false
    end
  end
end
e.LineChecker={lineCheckIdInternal=MgoActor.INVALID_LINE_CHECK_ID,callbackMethodInternal=nil,RequestLineCheck=function(a,t,n,c,d,i,r,l,o)
  if e.LineChecker.lineCheckIdInternal~=MgoActor.INVALID_LINE_CHECK_ID then
    return false
  end
  e.LineChecker.callbackMethodInternal=t
  e.LineChecker.lineCheckIdInternal=a:RequestLineCheck(n,c,d,i,r,l,o)
  return e.LineChecker.lineCheckIdInternal~=MgoActor.INVALID_LINE_CHECK_ID
end,OnResultReady=function(a,l,n,t)
  if e.LineChecker.callbackMethodInternal~=nil then
    e.LineChecker.callbackMethodInternal(a,l,n,t)
  end
  e.LineChecker.lineCheckIdInternal=MgoActor.INVALID_LINE_CHECK_ID
  e.LineChecker.callbackMethodInternal=nil
end}
function e.HandleCollisionResult(o,l,n,a,t)
  if l==e.LineChecker.lineCheckIdInternal then
    e.LineChecker.OnResultReady(o,n,a,t)
  end
end
function T(e,t,n,o)e:GetTable().AttachedToPlayerIndex=-1
  if a<0 then
    a=f
  end
  l=true
  if t then
    d=n
  else
    d=e:GetTransform():GetTranslation()
  end
  local a=MpRulesetManager.GetActiveRuleset()
  local n=e:GetGameObjectId():GetId()
  local t=MgoSerialize.NewStream(48)t:SetMode"W"Utils.SerializeEvent(t,n,Fox.StrCode32"flagDrop",-1,attachedToId)MgoSignal.SendSignal(a:GetRulesetGameObjectId(),Fox.StrCode32"LOCAL",t)TeamSneak.OnFlagStateChange(e,false,e:GetParm().MarkerName)
end
return e
