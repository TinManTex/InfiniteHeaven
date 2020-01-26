local this={}
local StrCode32=Fox.StrCode32
local IsTypeTable=Tpp.IsTypeTable
local GetGameObjectId=GameObject.GetGameObjectId
local NULL_ID=GameObject.NULL_ID
local SendCommand=GameObject.SendCommand
local DEBUG_StrCode32ToString=Tpp.DEBUG_StrCode32ToString
function this.Messages()
  return Tpp.StrCode32Table{
    GameObject={
      {msg="Interrogate",func=this._OnInterrogation},
      {msg="InterrogateEnd",func=this._OnInterrogationEnd},
      {msg="MapUpdate",func=this._OnMapUpdate}
    }
  }
end
function this.DeclareSVars()
  return{
    {name="InterrogationNormal",arraySize=128,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="InterrogationHigh",arraySize=128,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function this.Init()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnReload()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
end
function this.OnMessage(i,r,n,a,t,o,l)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,i,r,n,a,t,o,l)
end
function this.MakeFlagHigh(e)
  if e==NULL_ID then
    return
  end
  if mvars.interTable[e]==nil then
    return
  end
  local n=mvars.interTable[e].index
  for a,e in pairs(mvars.interTable[e].layer.high)do
    if e.name~=0 then
      local e=svars.InterrogationHigh[n]
      local a=bit.lshift(1,a-1)
      svars.InterrogationHigh[n]=bit.bor(e,a)
    end
  end
end
function this.ResetFlagHigh(e)
  if e==NULL_ID then
    return
  end
  if mvars.interTable[e]==nil then
    return
  end
  local e=mvars.interTable[e].index
  svars.InterrogationHigh[e]=0
end
function this.ResetFlagNormal(e)
  if e==NULL_ID then
    return
  end
  if mvars.interTable[e]==nil then
    return
  end
  local e=mvars.interTable[e].index
  svars.InterrogationNormal[e]=bit.bnot(0)
end
function this.UniqueInterrogationWithVoice(a,i)
  if a==NULL_ID then
    return
  end
  local e=0
  for a,n in pairs(mvars.uniqueInterTable.unique)do
    if i==n.name then
      e=a
    end
  end
  if e==0 then
  else
    e=e+64
  end
  SendCommand(a,{id="AssignInterrogationWithVoice",soundParameterId=i,index=e})
end
function this.UniqueInterrogation(i,a)
  if i==NULL_ID then
    return
  end
  local e=0
  for n,r in pairs(mvars.uniqueInterTable.unique)do
    if a==r.name then
      e=n
    end
  end
  if e==0 then
  else
    e=e+64
  end
  SendCommand(i,{id="AssignInterrogation",messageId=a,index=e})
end
function this.QuestInterrogation(a,i)
  if a==NULL_ID then
    return
  end
  local e=0
  for n,a in pairs(mvars.questTable.unique)do
    if i==a.name then
      e=n
    end
  end
  if e==0 then
  else
    e=e+96
  end
  SendCommand(a,{id="AssignInterrogation",messageId=i,index=e})
end
function this.SetQuestHighIntTable(cpId,interrTable)
  if cpId==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[cpId].layer.high)==false then
    return
  end
  local n=1
  for e,e in pairs(mvars.interTable[cpId].layer.high)do
    n=n+1
  end
  for a,r in pairs(interrTable)do
    local index=n
    if n>32 then
      return
    end
    for e,n in pairs(mvars.interTable[cpId].layer.high)do
      if r.name==0 then
        index=e
        break
      end
    end
    if index==n then
      n=n+1
      mvars.interTable[cpId].layer.high[index]={name=0,func=0}
    end
    mvars.interTable[cpId].layer.high[index].name=r.name
    mvars.interTable[cpId].layer.high[index].func=r.func
    local cpInterrIndex=mvars.interTable[cpId].index
    local n=svars.InterrogationHigh[cpInterrIndex]
    local a=bit.lshift(1,index-1)
    svars.InterrogationHigh[cpInterrIndex]=bit.bor(n,a)
  end
end
function this.RemoveQuestHighIntTable(e,a)
  if e==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[e].layer.high)==false then
    return
  end
  for n,r in pairs(a)do
    for n,a in pairs(mvars.interTable[e].layer.high)do
      if r.name==a.name then
        mvars.interTable[e].layer.high[n]={name=0,func=0}
        local e=mvars.interTable[e].index
        local a=svars.InterrogationHigh[e]
        local n=bit.lshift(1,n-1)
        svars.InterrogationHigh[e]=bit.band(a,bit.bnot(n))
        break
      end
    end
  end
end
function this.AddHighInterrogation(e,a)
  if e==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[e].layer.high)==false then
    return
  end
  for n,a in pairs(a)do
    for r,n in pairs(mvars.interTable[e].layer.high)do
      if a.name==n.name then
        if a.func==n.func then
          local e=mvars.interTable[e].index
          local n=svars.InterrogationHigh[e]
          local a=bit.lshift(1,r-1)
          svars.InterrogationHigh[e]=bit.bor(n,a)
        end
      end
    end
  end
end
function this.RemoveHighInterrogation(e,a)
  if e==NULL_ID then
    return
  end
  if IsTypeTable(mvars.interTable[e].layer.high)==false then
    return
  end
  for n,a in pairs(a)do
    for r,n in pairs(mvars.interTable[e].layer.high)do
      if a.name==n.name then
        if a.func==n.func then
          local e=mvars.interTable[e].index
          local a=svars.InterrogationHigh[e]
          local n=bit.lshift(1,r-1)
          svars.InterrogationHigh[e]=bit.band(a,bit.bnot(n))
        end
      end
    end
  end
end
function this.InitUniqueInterrogation(e)
  mvars.uniqueInterTable={uniqueChara={},unique={}}
  for e,n in pairs(e)do
    mvars.uniqueInterTable[e]={}for n,a in pairs(n)do
      mvars.uniqueInterTable[e][n]={name=0,func=0}
      mvars.uniqueInterTable[e][n].name=a.name
      mvars.uniqueInterTable[e][n].func=a.func
    end
  end
end
function this.ResetQuestTable()
  if mvars.questTable==nil then
    mvars.questTable={uniqueChara={},unique={}}
  end
  for e,n in pairs(mvars.questTable)do
    for n,a in pairs(n)do
      mvars.questTable[e][n]={name=0,func=0}
    end
  end
end
function this.AddQuestTable(n)if mvars.questTable==nil then
  mvars.questTable={uniqueChara={},unique={}}
  this.ResetQuestTable()
end
for e,n in pairs(n)do
  mvars.questTable[e]={}
  for n,a in pairs(n)do
    mvars.questTable[e][n]={name=0,func=0}
    mvars.questTable[e][n].name=a.name
    mvars.questTable[e][n].func=a.func
  end
end
end
function this.InitInterrogation(e)
  mvars.interTable={}
  local a=0
  for e,r in pairs(e)do
    a=a+1
    local e=GetGameObjectId(e)if e==NULL_ID then
    else
      mvars.interTable[e]={index=a,layer={normal={},high={},uniqueChara={}}}
      for n,a in pairs(r)do
        mvars.interTable[e].layer[n]={}
        for a,r in pairs(a)do
          mvars.interTable[e].layer[n][a]={name=0,func=0}
          mvars.interTable[e].layer[n][a].name=r.name
          mvars.interTable[e].layer[n][a].func=r.func
        end
      end
    end
  end
end
function this._AddGene(a)
  if a==NULL_ID then
    return
  end
  if mvars.interTable[a]==nil then
    local e=0
    for a,n in pairs(mvars.interTable)do
      if e>n.index then
        e=n.index
      end
    end
    e=e+1
    mvars.interTable[a]={index=e,layer={normal={},high={},uniqueChara={}}}
  end
end
function this.AddGeneInter(a)
  for a,r in pairs(a)do
    if r then
      local a=GetGameObjectId(a)
      if a==NULL_ID then
      else
        this._AddGene(a)
      end
    end
  end
end
function this._OnMapUpdate()
  TppUI.ShowAnnounceLog"updateMap"
end
function this._OnInterrogation(a,n,r)
  if r>0 then
  end
  if mvars.questTable~=nil then
    for r,e in pairs(mvars.questTable.uniqueChara)do
      if a==GetGameObjectId(e.name)then
        if e.func(a,n)then
          return
        end
      end
    end
  end
  if mvars.uniqueInterTable~=nil then
    for r,e in pairs(mvars.uniqueInterTable.uniqueChara)do
      if a==GetGameObjectId(e.name)then
        if e.func(a,n)then
          return
        end
      end
    end
  end
  local a=this._SelectInterrogation(n,r)
  if a==nil then
    return
  end
  this._AssignInterrogation(n,a.name,a.index)
end
function this._OnInterrogationEnd(soldierId,cpId,strCodeName,index)
  if index==0 then
    return
  end
  local rangedIndex=index
  if rangedIndex>96 then
    rangedIndex=rangedIndex-96
    local interrName=false
    for n,interrInfo in pairs(mvars.questTable.unique)do
      if strCodeName==StrCode32(interrInfo.name)then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.questTable.unique[rangedIndex].func(soldierId,cpId,interrName)
      return
    end
  end
  if rangedIndex>64 then
    rangedIndex=rangedIndex-64
    local interrName=false
    for n,interrInfo in pairs(mvars.uniqueInterTable.unique)do
      if strCodeName==StrCode32(interrInfo.name)then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.uniqueInterTable.unique[rangedIndex].func(soldierId,cpId,interrName)
      return
    end
  end
  if mvars.interTable[cpId]==nil then
    return
  end
  local cpInterrIndex=mvars.interTable[cpId].index
  if rangedIndex>32 then
    rangedIndex=rangedIndex-32
    local interrName=false
    for n,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
      if n==rangedIndex then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.interTable[cpId].layer.high[rangedIndex].func(soldierId,cpId,interrName)
    end
    local svarBitField=svars.InterrogationHigh[cpInterrIndex]
    svars.InterrogationHigh[cpInterrIndex]=bit.band(svarBitField,bit.bnot(bit.lshift(1,rangedIndex-1)))
  else
    local interrName=false
    for n,interrInfo in pairs(mvars.interTable[cpId].layer.normal)do
      if n==rangedIndex then
        interrName=interrInfo.name
      end
    end
    if interrName==false then
    else
      mvars.interTable[cpId].layer.normal[rangedIndex].func(soldierId,cpId,interrName)
    end
    local svarBitfield=svars.InterrogationNormal[cpInterrIndex]
    svars.InterrogationNormal[cpInterrIndex]=bit.band(svars.InterrogationNormal[cpInterrIndex],bit.bnot(bit.lshift(1,rangedIndex-1)))
  end
end
function this._AssignInterrogation(e,n,a)
  SendCommand(e,{id="AssignInterrogation",messageId=n,index=a})
end
function this._AssignInterrogationCollection(e)
  SendCommand(e,{id="AssignInterrogationCollection"})
end
function this._SelectInterrogation(cpId,RENsomeInt)
  if mvars.interTable==nil then
    if RENsomeInt>0 then
      this._AssignInterrogationCollection(cpId)
      return nil
    end
    return{index=0,name=0}
  end
  if mvars.interTable[cpId]==nil then
    if RENsomeInt>0 then
      this._AssignInterrogationCollection(cpId)
      return nil
    end
    return{index=0,name=0}
  end
  local cpInterrIndex=mvars.interTable[cpId].index
  for index,interrInfo in pairs(mvars.interTable[cpId].layer.high)do
    local bandDone=bit.band(svars.InterrogationHigh[cpInterrIndex],bit.lshift(1,index-1))
    if bandDone~=0 then
      return{index=index+32,name=interrInfo.name}
    end
  end
  if RENsomeInt>0 then
    local rnd=math.random(1,10)
    if rnd>=5 then
      this._AssignInterrogationCollection(cpId)
      return nil
    end
  end
  local maxNormal=1
  for i,n in pairs(mvars.interTable[cpId].layer.normal)do
    maxNormal=i
  end
  local rnd=math.random(1,maxNormal)
  for index,interrInfo in pairs(mvars.interTable[cpId].layer.normal)do
    if index>=rnd then
      local bandDone=bit.band(svars.InterrogationNormal[cpInterrIndex],bit.lshift(1,index-1))
      if bandDone~=0 then
        return{index=index,name=interrInfo.name}
      end
    end
  end
  for index,interrInfo in pairs(mvars.interTable[cpId].layer.normal)do
    local bandDone=bit.band(svars.InterrogationNormal[cpInterrIndex],bit.lshift(1,index-1))
    if bandDone~=0 then
      return{index=index,name=interrInfo.name}
    end
  end
  if RENsomeInt>0 then
    this._AssignInterrogationCollection(cpId)
    return nil
  end
  return{index=0,name=0}
end
return this
