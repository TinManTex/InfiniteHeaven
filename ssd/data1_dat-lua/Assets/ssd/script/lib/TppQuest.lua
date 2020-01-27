local this={}
local q=256
local p=0
local Q=0
local t="quest_block"local c="QStep_Clear"local t=Fox.StrCode32
local T=Tpp.StrCode32Table
local o=Tpp.IsTypeFunc
local t=Tpp.IsTypeTable
local m=Tpp.IsTypeString
local _=Tpp.IsTypeNumber
local u=TppDefine.Enum{"NONE","DEACTIVATE","DEACTIVATING","ACTIVATE"}
local l=TppDefine.Enum{"OPEN","CLEAR","FAILURE","UPDATE"}
local n=TppDefine.QUEST_BLOCK_TYPE_DEFINE
local r=TppDefine.QUEST_BLOCK_TYPE_INDEX
local a=#r
local i=ScriptBlock.SCRIPT_BLOCK_STATE_EMPTY
local h=ScriptBlock.SCRIPT_BLOCK_STATE_PROCESSING
local f=ScriptBlock.SCRIPT_BLOCK_STATE_INACTIVE
local d=ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE
local v={}
local S={}
function this.RegisterQuestPackList(e)
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    return
  end
  mvars.qst_questPackList=nil
  if not t(e)then
    return
  end
  if not next(e)then
    return
  end
  mvars.qst_questPackList=e
end
function this.RegisterQuestList(s)
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    return
  end
  if not t(s)then
    return
  end
  if not mvars.qst_questPackList then
    return
  end
  local r=#s
  if r==0 then
    return
  end
  local a={}
  for n=1,r do
    if not t(s[n])then
      return
    end
    local r=s[n].infoList
    if not t(r)then
      Tpp.DEBUG_DumpTable(s,2)
      return
    end
    if#r==0 then
      return
    end
    if not _(s[n].locationId)then
      return
    end
    if not t(s[n].loadArea)then
      return
    end
    if not m(s[n].blockType)then
      return
    end
    if not m(s[n].areaName)then
      return
    end
    mvars.qst_isLockedArea[s[n].areaName]=false
    local t=s[n].blockType
    if a[t]==nil then
      a[t]={}
    end
    for s,n in ipairs(r)do
      if not m(n.name)then
        return
      end
      if not m(n.invokeStepName)then
        return
      end
      this.AddPackList(a[t],n.name)
    end
  end
  for e=1,#n do
    local e=n[e]
    if a[e]then
      TppScriptBlock.RegisterCommonBlockPackList(e,a[e])
    end
  end
  mvars.qst_questList=s
end
function this.InitializeQuestActiveStatus()
  for t=1,#n do
    this._InitializeQuestActiveStatus(n[t])
  end
end
function this.GetQuestBlockIndex(t)
  if not t then
    return
  end
  for e=1,a do
    if mvars.qst_currentQuestName[e]==t then
      return e
    end
  end
end
function this.RegisterQuestInfo(n)
  if not n then
    return
  end
  local t=this.GetQuestBlockIndex(n)
  if not t then
    t=this.SearchBlockIndex(n)
    if not t then
      return
    end
  end
  this.ResetQuestStatus(t)
  this.SetCurrentQuestName(t,n)
  mvars.qst_currentQuestTable[t]=this.GetQuestTable(t,n)
  return t
end
function this.RegisterQuestStepList(n,e)
  if not t(e)then
    return
  end
  local t=#e
  if t==0 then
    return
  end
  if t>=q then
    return
  end
  if not n then
    return
  end
  table.insert(e,c)
  mvars.qst_questStepList[n]=Tpp.Enum(e)
end
function this.RegisterQuestStepTable(n,e)
  if not t(e)then
    return
  end
  e[c]={}
  mvars.qst_questStepTable[n]=e
end
function this.RegisterQuestSystemCallbacks(e,n)
  if not t(n)then
    return
  end
  mvars.qst_systemCallbacks[e]=mvars.qst_systemCallbacks[e]or{}
  local function s(n,t)
    if o(n[t])then
      mvars.qst_systemCallbacks[e][t]=n[t]
    end
  end
  local e={"OnActivate","OnOutOfAcitveArea","OnDeactivate","OnTerminate"}
  for t=1,#e do
    s(n,e[t])
  end
end
function this.OnUpdate()
  for s=1,a do
    local n=n[s]
    local t=this.GetQuestBlockState(n)
    if t then
      this.UpdateChangeQuest(s,n,t)
      this.UpdateWatchingQuest(s,n,t)
    end
  end
end
function this.OnDeactivate(e)
end
function this.QuestBlockOnInitialize(s)
  local t=s.questBlockIndex
  if not t then
    local n=s.questName
    if n then
      t=this.SearchBlockIndex(n)
    end
    if not t then
      return
    else
      this.ResetQuestStatus(t)
      this.SetCurrentQuestName(t,n)
      mvars.qst_currentQuestTable[t]=this.GetQuestTable(t,n)
    end
  end
  local n=s.Messages
  if o(n)then
    local e=n()
    mvars.qst_questScriptMsgExecTable[t]=Tpp.MakeMessageExecTable(e)
  end
  this.MakeQuestStepMessageExecTable(t)
  mvars.qst_isRadioTarget[t]=false
end
function this.QuestBlockOnUpdate(t)
  local t=t.questBlockIndex
  if not t or t==0 then
    return
  end
  local e=this
  local a=n[t]
  local r=e.GetQuestBlockState(a)
  if r==nil then
    return
  end
  local n=mvars
  local l=n.qst_lastQuestBlockState[t]
  if n.qst_requestInitActiveStatus[t]then
    e._InitializeQuestActiveStatus(a)
    return
  end
  local s=ScriptBlock
  local i=f
  local s=d
  if r==i then
    if l==s then
      e._DoDeactivate(t)
    end
    if n.qst_blockStateRequest[t]~=u.DEACTIVATE then
      if e._CanActivateQuest()then
        e.ActivateCurrentQuestBlock(a)
        e.ClearBlockStateRequest(t)
      end
    else
      e._DoDeactivate(t)
    end
    n.qst_lastInactiveToActive[t]=false
  elseif r==s then
    if not e._CanActivateQuest()then
      return
    end
    if not e.IsInvokingImpl(t)then
      e.Invoke(a)
      return
    end
    local s=t-1
    local s=e.GetQuestStepTable(t,gvars.qst_currentQuestStepNumber[s])
    if(not l)or l<=i then
      n.qst_lastInactiveToActive[t]=true
    end
    if n.qst_lastInactiveToActive[t]then
      n.qst_lastInactiveToActive[t]=false
      e.ExecuteSystemCallback(t,"OnActivate")n.qst_allocated[t]=true
      if s and o(s.OnEnter)then
        s.OnEnter(s)
      end
    end
    if s and o(s.OnUpdate)then
      s.OnUpdate(urrentStepTable)
    end
    if n.qst_blockStateRequest[t]==u.DEACTIVATE then
      e.DeactivateCurrentQuestBlock(a)
      e.ClearBlockStateRequest(t)
    end
  else
    n.qst_lastInactiveToActive[t]=false
    e.ClearBlockStateRequest(t)
  end
  n.qst_lastQuestBlockState[t]=r
end
function this.QuestBlockOnTerminate(t)
  local t=t.questBlockIndex
  if not t then
    return
  end
  if mvars.qst_reserveEnd[t]then
    local t=mvars.qst_currentQuestName[t]
    if t then
      local n=this.IsCleard(t)
      if(not n)or(n and this.IsRepop(t))then
        this.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.FAILURE,t)
      end
    end
  end
  this.ExecuteSystemCallback(t,"OnTerminate")
  mvars.qst_systemCallbacks[t]=nil
  mvars.qst_questStepList[t]=nil
  mvars.qst_questStepTable[t]=nil
  mvars.qst_currentQuestTable[t]=nil
  mvars.qst_isRadioTarget[t]=false
  mvars.qst_lastQuestBlockState[t]=nil
  mvars.qst_reserveEnd[t]=false
  mvars.qst_isWatchingDefenseFlag[t]=false
  gvars.qst_currentQuestStepNumber[t-1]=p
  this.ClearCurrentQuestName(t)
  local e=n[t]
  local e=ScriptBlock.GetScriptBlockId(e)
  TppScriptBlock.FinalizeScriptBlockState(e)
end
function this.SetNextQuestStep(t,s)
  if not t or t==0 then
    return
  end
  if not mvars.qst_questStepTable[t]then
    return
  end
  if not mvars.qst_questStepList[t]then
    return
  end
  local n=mvars.qst_questStepTable[t]
  local a=mvars.qst_questStepList[t]
  local n=n[s]
  local s=a[s]
  if n==nil then
    return
  end
  if s==nil then
    return
  end
  local a=t-1
  if this.IsInvokingImpl(t)then
    local e=this.GetQuestStepTable(t,gvars.qst_currentQuestStepNumber[a])
    local t=e.OnLeave
    if o(t)then
      t(e)
    end
  end
  gvars.qst_currentQuestStepNumber[a]=s
  if mvars.qst_allocated[t]then
    local e=n.OnEnter
    if o(e)then
      e(n)
    end
  end
end
function this.ClearWithSave(n,t)
  if not t then
    return
  end
  local s=this.GetQuestIndex(t)
  if n==TppDefine.QUEST_CLEAR_TYPE.CLEAR then
    this.AddStaffsFromTempBuffer()
    this.Clear(t)
    this.SetGimmickResourceValidity(t,false)
    this.Save()
    this.OpenWormhole("questEnd",t)
    this.OpenRewardCbox(t)
    this.GetNamePlate(t)
  elseif n==TppDefine.QUEST_CLEAR_TYPE.FAILURE then
    this.AddStaffsFromTempBuffer()
    this.Failure(t)
    this.SetGimmickResourceValidity(t,false)
    this.Save()
  elseif n==TppDefine.QUEST_CLEAR_TYPE.UPDATE then
    this.Update(t)
  end
end
function this.FadeOutAndDeativateQuestBlock(t)
  if not t then
    for e=1,a do
      mvars.qst_isRequestedDeactivate[e]=true
    end
  else
    local e=this.GetQuestBlockIndex(t)
    if e~=nil and e>0 then
      mvars.qst_isRequestedDeactivate[e]=true
    end
  end
  TppUI.FadeOut(TppUI.FADE_SPEED.FADE_NORMALSPEED,"FadeOutOnOutOfMissionArea",TppUI.FADE_PRIORITY.QUEST)
end
function this.OnMissionGameEnd()
  for t=1,#n do
    local n=n[t]
    local n=this.GetQuestBlockState(n)
    if n==d then
      this._DoDeactivate(t)
    end
  end
  this.UpdateAllGimmickValidity(false)
end
function this.UpdateActiveQuest(t)
  if not this.NeedUpdateActiveQuest(t)then
    return
  end
  this.UpdateGimmickValidity(false)
  mvars.qst_loadableQuestNameList={}
  mvars.qst_openableQuestNameList={}
  mvars.qst_suspendedQuestNameList={}
  mvars.qst_acceptableQuestNameList={}
  this.UpdateQuestTimeCount()
  this.UpdateOpenQuest()
  for t=1,a do
    this._UpdateActiveQuest(t)
  end
  TppCrew.SetAcceptableQuestList(mvars.qst_acceptableQuestNameList)
  this.UpdateCloseQuest()
  this.UpdateOpenableQuest()
  this.UpdateLoadableQuestListForOtherLocation()
  this.UpdateTerminalDisplayQuest()
  this.UpdateGimmickValidity(true)
end
function this.ShowAnnounceLogQuestOpen()
  if mvars.qst_isQuestNewOpenFlag==true then
    mvars.qst_isQuestNewOpenFlag=false
    this.ShowAnnounceLog(l.OPEN)
  end
end
function this.ClearAreaLock()
  if not mvars.qst_isLockedArea then
    return
  end
  for e=1,#mvars.qst_isLockedArea do
    mvars.qst_isLockedArea[e]=false
  end
end
function this.StartWatchingOtherDefenseGame(e)
  if not e or e==0 then
    return
  end
  mvars.qst_isWatchingDefenseFlag[e]=true
end
function this.StopWatchingOtherDefenseGame(e)
  if not e or e==0 then
    return
  end
  mvars.qst_isWatchingDefenseFlag[e]=false
end
function this.RegisterSkipStartQuestDemo(e)
  mvars.qst_isSkipStartQuestDemo[e]=true
end
function this.UnregisterSkipStartQuestDemo()
  mvars.qst_isSkipStartQuestDemo={}
end
function this.IsSkipStartQuestDemo(e)
  return mvars.qst_isSkipStartQuestDemo[e]
end
function this.SetUnloadableAll(t)
  if mvars.qst_unloadableAllQuestFlag~=t then
    mvars.qst_unloadableAllQuestFlag=t
    if t==true then
      for t=1,#n do
        this.UnloadCurrentQuestBlock(n[t])
      end
    end
    this.UpdateActiveQuest()
  end
end
function this.AddPackList(n,e)
  local s=mvars.qst_questPackList[e]
  if s==nil then
    return
  end
  if not t(s)then
    return
  end
  if not n[e]then
    n[e]={}
  end
  for t,s in pairs(s)do
    if type(s)=="number"then
      table.insert(n[e],s)
    elseif t=="faceIdList"then
    elseif t=="bodyIdList"then
    elseif t=="randomFaceList"then
    else
      table.insert(n[e],s)
    end
  end
end
function this._InitializeQuestActiveStatus(n)
  local s=this.GetQuestBlockState(n)
  if s==nil then
    return
  end
  if s==i then
    return
  end
  local t=r[n]
  if not t or t==0 then
    return
  end
  mvars.qst_requestInitActiveStatus[t]=false
  if s<f or not this._CanActivateQuest()then
    mvars.qst_requestInitActiveStatus[t]=true
    return
  end
  local s=this.GetCurrentQuestTable(t)
  if s==nil then
    return
  end
  local r,a=Tpp.GetCurrentStageSmallBlockIndex()
  if this.IsInsideArea("loadArea",s,r,a)then
    this.ActivateCurrentQuestBlock(n)
  end
  if not this.IsInvokingImpl(t)then
    this.Invoke(n)
  else
    local n=t-1
    gvars.qst_currentQuestStepNumber[n]=1
    local n=mvars.qst_questStepList[t][1]
    this.SetNextQuestStep(t,n)
  end
end
function this.OnAllocate(t)
  this.InitMvars()
end
function this.Init(t)
  this.CommonInit()
end
function this.OnReload(t)
  this.CommonInit()
  this.RegisterQuestPackList(TppQuestList.questPackList)
  this.RegisterQuestList(TppQuestList.questList)
  this.UpdateActiveQuest()
  this.InitializeQuestLoad()
end
function this.CommonInit()
  this.messageExecTable=Tpp.MakeMessageExecTable(this.Messages())
  this.InitMvars()
  this.InitLoadableQuestList()
end
function this.InitMvars()
  mvars.qst_reserveUpdateTerminalFlag=false
  mvars.qst_unloadableAllQuestFlag=false
  mvars.qst_skipLoadQuestList={}
  mvars.qst_currentQuestName={}
  mvars.qst_currentQuestTable={}
  mvars.qst_loadableQuestList={}
  mvars.qst_loadableQuestInArea={}
  mvars.qst_loadableQuestNameList={}
  mvars.qst_loadableQuestNameList2={}
  mvars.qst_invokeReserveOnActivate={}
  mvars.qst_reserveNextQuest={}
  mvars.qst_questStepList={}
  mvars.qst_questStepTable={}
  mvars.qst_systemCallbacks={}
  mvars.qst_questScriptMsgExecTable={}
  mvars.qst_allocated={}
  mvars.qst_lastQuestBlockState={}
  mvars.qst_lastInactiveToActive={}
  mvars.qst_isRadioTarget={}
  mvars.qst_blockStateRequest={}
  mvars.qst_isRequestedDeactivate={}
  mvars.qst_requestInitActiveStatus={}
  mvars.qst_isLockedArea={}
  mvars.qst_reserveEnd={}
  mvars.qst_otherLocationQuestList={}
  mvars.qst_isWatchingDefenseFlag={}
  for e=1,a do
    mvars.qst_currentQuestName[e]=nil
    mvars.qst_currentQuestTable[e]={}
    mvars.qst_loadableQuestList[e]={}
    mvars.qst_loadableQuestInArea[e]={}
    mvars.qst_invokeReserveOnActivate[e]=false
    mvars.qst_reserveNextQuest[e]=nil
    mvars.qst_questStepList[e]=nil
    mvars.qst_questStepTable[e]=nil
    mvars.qst_systemCallbacks[e]=nil
    mvars.qst_questScriptMsgExecTable[e]=nil
    mvars.qst_allocated[e]=false
    mvars.qst_lastQuestBlockState[e]=nil
    mvars.qst_lastInactiveToActive[e]=nil
    mvars.qst_isRadioTarget[e]=false
    mvars.qst_blockStateRequest[e]=false
    mvars.qst_isRequestedDeactivate[e]=false
    mvars.qst_requestInitActiveStatus[e]=false
    mvars.qst_reserveEnd[e]=false
    mvars.qst_otherLocationQuestList[e]={}
    mvars.qst_isWatchingDefenseFlag[e]=false
  end
  mvars.qst_isSkipStartQuestDemo={}
end
function this.InitLoadableQuestList()
  if TppMission.IsMultiPlayMission(vars.missionCode)then
    return
  end
  local n=vars.locationCode
  if not mvars.qst_questList then
    return
  end
  local e=#mvars.qst_questList
  if e==0 then
    return
  end
  for e=1,e do
    local t=mvars.qst_questList[e]
    local e=r[t.blockType]
    if not e or e>a then
      return
    end
    if t.locationId==n then
      table.insert(mvars.qst_loadableQuestList[e],t)
    else
      table.insert(mvars.qst_otherLocationQuestList[e],t)
    end
  end
end
function this.InitializeQuestLoad()
end
function this.GetQuestBlockState(e)
  local e=ScriptBlock.GetScriptBlockId(e)
  if e==ScriptBlock.SCRIPT_BLOCK_ID_INVALID then
    return
  end
  return ScriptBlock.GetScriptBlockState(e)
end
function this.UnloadCurrentQuestBlock(e)
  TppScriptBlock.Unload(e)
end
function this.IsNeedWaitCheckPoint()
  for s=1,#n do
    local t=n[s]
    local t=this.GetQuestBlockState(t)
    if t~=nil and t~=i then
      local t=mvars.qst_currentQuestName[s]
      if t then
        local n=TppQuestList.questTimerList[t].isOnce
        if n then
          return true
        end
        local n=mvars.qst_reserveEnd[s]
        if n then
          local n=this.IsCleard(t)
          local e=this.IsFailure(t)
          if(not n)and(not e)then
            return true
          end
        end
      end
    end
  end
  return false
end
function this.ClearCurrentQuestName(e)
  if not e or e==0 then
    return
  end
  mvars.qst_currentQuestName[e]=nil
  gvars.qst_currentQuestName[e-1]=Q
end
function this.SetCurrentQuestName(e,t)
  if not e or e==0 then
    return
  end
  mvars.qst_currentQuestName[e]=t
  gvars.qst_currentQuestName[e-1]=Fox.StrCode32(t)
end
function this.GetCurrentQuestName(e)
  return mvars.qst_currentQuestName[e]
end
function this.ResetQuestStatus(e)
  if not e or e==0 then
    for e=1,a do
      gvars.qst_currentQuestName[e-1]=Q
      gvars.qst_currentQuestStepNumber[e-1]=p
    end
    return
  end
  local e=e-1
  gvars.qst_currentQuestName[e]=Q
  gvars.qst_currentQuestStepNumber[e]=p
end
function this.UpdateQuestBlockStateAtNotLoaded(s,t,l)
  local n=r[s]
  if not n then
    return
  end
  if not mvars.qst_loadableQuestList or not mvars.qst_loadableQuestList[n]then
    return
  end
  local a=this.GetCurrentQuestName(n)
  local t=this.SearchQuestFromAllSpecifiedArea("loadArea",n,t,l)
  local l=this.GetQuestBlockState(s)
  local r=i
  if t==nil then
    if l~=r then
      this.UnloadCurrentQuestBlock(s)
      this.ClearCurrentQuestName(n)
      this.ResetQuestStatus(n)
    end
    return
  end
  if a then
    if t then
      if(l==r or a~=t)then
        this.SetNewQuestAndLoadQuestBlock(s,t)
      end
      if(l~=r)and(a==t)then
        mvars.qst_currentQuestTable[n]=this.GetQuestTable(n,t)
      end
    end
  else
    if t then
      this.SetNewQuestAndLoadQuestBlock(s,t)
    end
  end
  return t
end
function this.UpdateQuestBlockStateAtInactive(e,t,t)
  local e=r[e]
  if not e then
    return
  end
  mvars.qst_invokeReserveOnActivate[e]=true
end
function this.UpdateQuestBlockStateAtActive(n,l,a)
  local t=r[n]
  if not t or t==0 then
    return
  end
  if mvars.qst_blockStateRequest[t]==u.DEACTIVATE then
    return
  end
  if not this.IsInvoking(n)then
    this.Invoke(n)
    return
  end
  local s=this.GetCurrentQuestTable(t)
  if s==nil then
    return
  end
  if not this.IsInsideArea("loadArea",s,l,a)then
    local r=this.GetCurrentQuestName(t)
    local s=this.SearchQuestFromAllSpecifiedArea("loadArea",t,l,a)
    if s==nil or r~=s then
      this.UnloadCurrentQuestBlock(n)
      mvars.qst_reserveNextQuest[t]=s
    end
  end
end
function this.GetFirstPriorityQuest(s)
  if not t(s)then
    return
  end
  local n
  for s,t in ipairs(s)do
    local t=t.name
    local s=TppQuestList.QUEST_INDEX[t]
    if s then
      gvars.qst_questActiveFlag[s]=false
      if this.IsOpen(t)then
        if not this.IsCleard(t)then
          n=t
          break
        elseif not n and this.IsRepop(t)then
          n=t
        end
      end
    end
  end
  return n
end
function this._UpdateActiveQuest(s)
  local t=mvars.qst_loadableQuestList[s]
  if not t or not next(t)then
    return
  end
  mvars.qst_loadableQuestInArea[s]={}
  if mvars.qst_unloadableAllQuestFlag then
    return
  end
  local n=n[s]
  local n=this.GetQuestBlockState(n)
  if n==nil then
    return
  end
  for n,t in ipairs(t)do
    local n=t.areaName
    local t=this.GetFirstPriorityQuest(t.infoList)
    if t then
      mvars.qst_loadableQuestInArea[s][n]=t
      table.insert(mvars.qst_loadableQuestNameList,t)
      local n=TppQuestList.QUEST_INDEX[t]
      gvars.qst_questActiveFlag[n]=true
      TppCrew.UpdateActiveQuest(t)
      this._UpdateOrderQuest(t)
      if mvars.qst_openableQuestNameList[t]then
        local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]
        local e=Mission.RequestOpenQuestToServer(e,TppQuestList.questTimerList[t].openTime)
        if e then
          mvars.qst_openableQuestNameList[t]=false
        end
      end
    end
  end
end
function this._UpdateOrderQuest(t)
  if TppQuestList.questOrderList[t]and not this.IsAccepted(t)then
    table.insert(mvars.qst_acceptableQuestNameList,t)
    local e=TppQuestList.QUEST_INDEX[t]
    gvars.qst_questActiveFlag[e]=false
  end
end
function this.AssignNpcInfosToGameObjectType(e)
  for t,e in ipairs(e)do
    SsdNpc.AssignInfosToGameObjectType{gameObjectType=e[1],npcType=e[2],partsType=e[3],isRegisterResource=false}
  end
end
function this.NeedUpdateActiveQuest(t)
  if not this.CanOpenSideOpsList()then
    return false
  end
  if not SsdSaveSystem.IsIdle()then
    return false
  end
  return true
end
function this.UpdateChangeQuest(t,s,n)
  if n~=i then
    return
  end
  if mvars.qst_reserveNextQuest[t]then
    local n=mvars.qst_reserveNextQuest[t]
    this.SetNewQuestAndLoadQuestBlock(s,n)
    mvars.qst_reserveNextQuest[t]=nil
  end
end
function this.UpdateWatchingQuest(t,s,n)
  if n~=d then
    return
  end
  if Mission.GetDefenseGameState()~=TppDefine.DEFENSE_GAME_STATE.NONE then
    if not mvars.qst_isWatchingDefenseFlag[t]then
      return
    end
    this.UnloadCurrentQuestBlock(s)
    local t=this.GetCurrentQuestName(t)
    table.insert(mvars.qst_skipLoadQuestList,t)
    this.UpdateTerminalDisplayQuest()
  else
    if#mvars.qst_skipLoadQuestList>0 then
      mvars.qst_skipLoadQuestList={}
      mvars.qst_reserveUpdateTerminalFlag=true
    end
  end
end
function this.IsSkipLoading(t)
  for n,e in ipairs(mvars.qst_skipLoadQuestList)do
    if t==e then
      return true
    end
  end
  return false
end
function this.IsInvoking(t)
  local t=r[t]
  return this.IsInvokingImpl(t)
end
function this.IsInvokingImpl(e)
  if not e or e==0 then
    return
  end
  if gvars.qst_currentQuestStepNumber[e-1]~=p then
    return true
  else
    return false
  end
end
function this.Invoke(t)
  local t=r[t]
  if not t then
    return
  end
  local n=this.GetCurrentQuestName(t)
  local s,n=this.GetQuestTable(t,n)
  local n=n.invokeStepName
  this.SetNextQuestStep(t,n)
end
function this.SetNewQuestAndLoadQuestBlock(s,t)
  local n=TppQuestList.npcsList[t]
  if n~=nil then
    this.AssignNpcInfosToGameObjectType(n)
  end
  local n=TppScriptBlock.Load(s,t)
  if n==false then
    return
  end
  local n=r[s]
  this.ResetQuestStatus(n)
  this.SetCurrentQuestName(n,t)
  mvars.qst_currentQuestTable[n]=this.GetQuestTable(n,t)
end
function this.GetQuestTable(e,n)
  local e=mvars.qst_loadableQuestList[e]
  local t=#e
  for t=1,t do
    local t=e[t]
    for s,e in ipairs(t.infoList)do
      if e.name==n then
        return t,e
      end
    end
  end
end
function this.GetQuestStepTable(e,n)
  if mvars.qst_questStepList[e]==nil then
    return
  end
  local t=mvars.qst_questStepList[e]
  local t=t[n]
  if t==nil then
    return
  end
  local e=mvars.qst_questStepTable[e]
  if e==nil then
    return
  end
  local e=e[t]
  if e~=nil then
    return e
  else
    return
  end
end
function this.SearchQuestFromAllSpecifiedArea(r,t,l,a)
  local s=mvars.qst_loadableQuestList[t]
  local n=mvars.qst_loadableQuestInArea[t]
  local t=#s
  for t=1,t do
    local t=s[t]
    if this.IsInsideArea(r,t,l,a)then
      local t=t.areaName
      if mvars.qst_isLockedArea[t]then
        return
      end
      if n[t]then
        local t=n[t]
        if this.IsActive(t)and not this.IsSkipLoading(t)then
          return t
        end
      end
    end
  end
end
function this.SearchBlockIndex(s)
  local e=0
  for t=1,#n do
    if e~=0 then
      break
    end
    if mvars.qst_loadableQuestList[t]then
      local n=mvars.qst_loadableQuestList[t]
      for a=1,#n do
        if e~=0 then
          break
        end
        local n=n[a]
        for a,n in ipairs(n.infoList)do
          if n.name==s then
            e=t
            break
          end
        end
      end
    end
  end
  return e
end
function this.IsInsideArea(n,e,t,s)
  local a=e.areaName
  local e=e[n]
  if e==nil then
    return
  end
  return Tpp.CheckBlockArea(e,t,s)
end
function this.IsActive(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    return gvars.qst_questActiveFlag[e]
  end
end
function this.Messages()
  return T{GameObject={{msg="AcceptQuest",func=function(t)
    local t=TppQuestList.QUEST_DEFINE_HASH_TABLE[t]
    if not t then
      return
    end
    this.Accept(t)
  end}},Block={{msg="StageBlockCurrentSmallBlockIndexUpdated",func=this.OnUpdateSmallBlockIndex,option={isExecFastTravel=true}}},UI={{msg="EndFadeOut",sender="FadeOutOnOutOfMissionArea",func=function()
    for e=1,a do
      if mvars.qst_isRequestedDeactivate[e]then
        mvars.qst_isRequestedDeactivate[e]=false
        mvars.qst_blockStateRequest[e]=u.DEACTIVATE
      end
    end
    TppUI.FadeIn(TppUI.FADE_SPEED.FADE_NORMALSPEED,nil,TppUI.FADE_PRIORITY.QUEST)
  end},{msg="QuestAreaAnnounceText",func=function(t)
    this.OnQuestAreaAnnounceText(t)
  end}},Marker={{msg="ChangeToEnable",func=function(a,n,s,t)
    this._ChangeToEnable(a,n,s,t)
  end}}}
end
function this.OnMessage(i,o,l,s,r,t,n)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,i,o,l,s,r,t,n)
  for a=1,a do
    this.ExecMessageToBlockScript(a,i,o,l,s,r,t,n)
  end
end
function this.ExecMessageToBlockScript(t,n,s,a,r,u,o,l)
  if mvars.qst_questScriptMsgExecTable==nil then
    return
  end
  local i=mvars.qst_questScriptMsgExecTable[t]
  if i then
    local e=l
    local t
    Tpp.DoMessage(i,TppMission.CheckMessageOption,n,s,a,r,u,o,e)
  end
  if this.IsInvokingImpl(t)and mvars.qst_questStepList[t]then
    local i=gvars.qst_currentQuestStepNumber[t-1]
    local e=this.GetQuestStepTable(t,i)
    if e then
      local e=e._messageExecTable
      if e then
        local t=l
        local l
        Tpp.DoMessage(e,TppMission.CheckMessageOption,n,s,a,r,u,o,t)
      end
    end
  end
end
function this.MakeQuestStepMessageExecTable(e)
  if not t(mvars.qst_questStepTable[e])then
    return
  end
  for t,e in pairs(mvars.qst_questStepTable[e])do
    local t=e.Messages
    if o(t)then
      local t=t(e)
      e._messageExecTable=Tpp.MakeMessageExecTable(t)
    end
  end
end
function this.OnUpdateSmallBlockIndex(s,a)
  for t=1,#n do
    local t=n[t]
    this.OnUpdateQuestBlockState(t,s,a)
  end
  if mvars.qst_reserveUpdateTerminalFlag then
    mvars.qst_reserveUpdateTerminalFlag=false
    this.UpdateTerminalDisplayQuest()
  end
end
function this.OnUpdateQuestBlockState(t,s,a)
  local r=r[t]
  local n=this.GetQuestBlockState(t)
  if n~=nil then
    mvars.qst_invokeReserveOnActivate[r]=false
    if(n==i)or(n==h)then
      this.UpdateQuestBlockStateAtNotLoaded(t,s,a)
    elseif(n==f)then
      this.UpdateQuestBlockStateAtInactive(t,s,a)
    elseif(n==d)then
      this.UpdateQuestBlockStateAtActive(t,s,a)
    end
  end
end
function this.GetCurrentQuestTable(e)
  return mvars.qst_currentQuestTable[e]
end
function this.Clear(t)
  if t==nil then
    return
  end
  local n=this.GetQuestIndex(t)
  if n==nil then
    return
  end
  local s=this.GetQuestBlockIndex(t)
  if not s then
    return
  end
  this.SetNextQuestStep(s,c)
  this.ShowAnnounceLog(l.CLEAR,t)
  this.CheckClearBounus(n,t)
  this.UpdateClearFlag(n,true)
  this.UpdateRepopFlag(s,n)
  this.CheckAllClearBounus()
  this.DecreaseElapsedClearCount(t)
  this.PlayClearRadio(t)
  this.GetClearKeyItem(t)
  TppStory.UpdateStorySequence{updateTiming="OnSideOpsClear"}
  gvars.qst_questSuspendFlag[n]=true
  Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[t],TppQuestList.questTimerList[t].closeTime)
  this.UpdateTerminalDisplayQuest()
end
function this.Failure(t)
  if t==nil then
    return
  end
  local n=this.GetQuestIndex(t)
  if n==nil then
    return
  end
  local s=this.GetQuestBlockIndex(t)
  if not s then
    return
  end
  this.UpdateClearFlag(n,false)
  this.UpdateRepopFlag(s,n)
  this.SetNextQuestStep(s,c)
  this.ShowAnnounceLog(l.FAILURE,t)
  gvars.qst_questSuspendFlag[n]=true
  if not TppQuestList.questTimerList[t].isOnce then
    Mission.RequestClearQuestToServer(TppQuestList.QUEST_DEFINE_IN_NUMBER[t],TppQuestList.questTimerList[t].closeTime)
  end
  this.UpdateTerminalDisplayQuest()
end
function this.ReserveEnd(e)
  mvars.qst_reserveEnd[e]=true
end
function this.Update(t)
  if t==nil then
    return
  end
  local n=this.GetQuestIndex(t)
  if n==nil then
    return
  end
  local n,s=TppEnemy.GetQuestCount()
  if n>0 and s>1 then
    this.ShowAnnounceLog(l.UPDATE,t,n,s)
  end
end
function this.IsOpen(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    if not gvars.qst_questOpenFlag[e]then
      return false
    end
    if gvars.qst_questSuspendFlag[e]then
      return false
    end
    return true
  end
end
function this.IsCleard(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    return gvars.qst_questClearedFlag[e]
  end
end
function this.IsFailure(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    return gvars.qst_questFailureFlag[e]
  end
end
function this.IsRepop(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    return gvars.qst_questRepopFlag[e]
  end
end
function this.IsReservedClear(e)
  local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[e]
  if e and Mission.IsReserveClearQuest(e)then
    return true
  end
  return false
end
function this.IsAccepted(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    return gvars.qst_questAcceptedFlag[e]
  end
end
function this.Accept(t)
  local n=TppQuestList.QUEST_INDEX[t]
  if n then
    local s=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]
    local t=Mission.RequestOpenQuestToServer(s,TppQuestList.questTimerList[t].openTime)
    if t then
      gvars.qst_questAcceptedFlag[n]=true
      this.UpdateActiveQuest()
      TppUiCommand.AnnounceLogViewQuestReceived{id={s}}
    end
  end
end
function this.IsEnd(t)
  if t==nil then
    return
  end
  local e=this.GetQuestBlockIndex(t)
  if not e then
    return
  end
  local t=gvars.qst_currentQuestStepNumber[e-1]
  if mvars.qst_questStepList[e][t]==c then
    return true
  end
  return false
end
function this.UpdateClearFlag(e,t)
  if t then
    gvars.qst_questClearedFlag[e]=true
    gvars.qst_questFailureFlag[e]=false
    gvars.qst_questRepopFlag[e]=false
  else
    gvars.qst_questFailureFlag[e]=true
  end
  gvars.qst_questActiveFlag[e]=false
end
function this.UpdateRepopFlag(n,t)
  gvars.qst_questRepopFlag[t]=false
  local t=this.GetCurrentQuestTable(n)
  if not t then
    return
  end
  this.UpdateRepopFlagImpl(t)
end
function this.UpdateRepopFlagImpl(s)
  local n=0
  for t,s in ipairs(s.infoList)do
    local t=s.name
    if this.IsOpen(t)then
      if not s.isOnce then
        n=n+1
      end
      if this.IsRepop(t)or not this.IsCleard(t)then
        return
      end
    end
  end
  if n==0 then
    return
  end
  for n,t in ipairs(s.infoList)do
    if this.IsCleard(t.name)and not t.isOnce then
    end
  end
end
function this.CheckAllClearBounus()
  local e=true
  for t=1,#TppQuestList.QUEST_DEFINE do
    if not gvars.qst_questClearedFlag[t]then
      e=false
      break
    end
  end
  if e then
    gvars.qst_allQuestCleared=true
  end
end
function this.AddStaffsFromTempBuffer()
  TppTerminal.AddStaffsFromTempBuffer(true)
end
function this.Save()
end
function this.ExecuteSystemCallback(e,t)
  if mvars.qst_systemCallbacks[e]==nil then
    return
  end
  local e=mvars.qst_systemCallbacks[e][t]
  if e then
    return e()
  end
end
function this.ActivateCurrentQuestBlock(e)
  local e=ScriptBlock.GetScriptBlockId(e)
  TppScriptBlock.ActivateScriptBlockState(e)
end
function this.DeactivateCurrentQuestBlock(e)
  local e=ScriptBlock.GetScriptBlockId(e)
  TppScriptBlock.DeactivateScriptBlockState(e)
end
function this.ClearBlockStateRequest(e)
  mvars.qst_blockStateRequest[e]=u.NONE
end
function this.GetQuestIndex(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    return e
  else
    return
  end
end
function this._CanActivateQuest()
  return true
end
function this._DoDeactivate(t)
  this.ExecuteSystemCallback(t,"OnDeactivate")
  mvars.qst_allocated[t]=false
end
function this.UpdateOpenQuest()
  local p=TppQuestList.QUEST_DEFINE_IN_NUMBER
  local l=TppQuestList.questTimerList
  local a=gvars.qst_questOpenFlag
  local s=gvars.qst_questSuspendFlag
  local d=gvars.qst_questLockedFlag
  local u=gvars.qst_questFailureFlag
  local i=gvars.qst_questAcceptedFlag
  local o=gvars.qst_questRepopFlag
  local r=vars.questTimeCounter
  local m=TppQuestList.questOpenCondition
  local f=TppQuestList.questLockCondition
  mvars.qst_isQuestNewOpenFlag=false
  for t,e in pairs(TppQuestList.QUEST_INDEX)do
    local n=p[t]
    local Q=l[t].isOnce
    local v=a[e]
    local n=s[e]
    local h=d[e]
    local c=r[e]
    if h then
      a[e]=false
      s[e]=false
      u[e]=false
      i[e]=false
      o[e]=false
    else
      local f=f[t]
      if f and f()then
        d[e]=true
        local t=p[t]
        local t=Mission.RequestOpenQuestToServer(t,0)
        if not t then
          d[e]=false
        end
      else
        if Q then
          s[e]=false
          u[e]=false
        else
          if n then
            if c==0 then
              s[e]=false
              u[e]=false
              i[e]=false
              o[e]=true
              n=false
              mvars.qst_openableQuestNameList[t]=true
              r[e]=l[t].openTime
            end
          elseif v and not n then
            if c==0 then
              s[e]=true
              o[e]=false
              i[e]=false
              n=true
              table.insert(mvars.qst_suspendedQuestNameList,t)r[e]=l[t].closeTime
            end
          end
        end
        local s=m[t]
        if s then
          if s()and not n then
            if a[e]==false then
              mvars.qst_isQuestNewOpenFlag=true
              mvars.qst_openableQuestNameList[t]=true
              r[e]=l[t].openTime
            end
            a[e]=true
          end
        end
      end
    end
  end
end
function this.UpdateCloseQuest()
  if not mvars.qst_suspendedQuestNameList then
    return
  end
  if not next(mvars.qst_suspendedQuestNameList)then
    return
  end
  for t,e in ipairs(mvars.qst_suspendedQuestNameList)do
    local t=TppQuestList.QUEST_DEFINE_IN_NUMBER[e]
    local t=Mission.RequestOpenQuestToServer(t,TppQuestList.questTimerList[e].closeTime)
    if not t then
      local e=TppQuestList.QUEST_INDEX[e]
      gvars.qst_questSuspendFlag[e]=false
    end
  end
end
function this.UpdateOpenableQuest()
  if not mvars.qst_openableQuestNameList then
    return
  end
  if not next(mvars.qst_openableQuestNameList)then
    return
  end
  for e,t in pairs(mvars.qst_openableQuestNameList)do
    if t then
      local t=TppQuestList.QUEST_DEFINE_IN_NUMBER[e]
      local t=Mission.RequestOpenQuestToServer(t,TppQuestList.questTimerList[e].openTime)
      if not t then
        local e=TppQuestList.QUEST_INDEX[e]
        gvars.qst_questOpenFlag[e]=false
      end
    end
  end
end
function this.UpdateLoadableQuestListForOtherLocation()
  mvars.qst_loadableQuestNameList2={}
  for t=1,a do
    local t=mvars.qst_otherLocationQuestList[t]
    if t and next(t)then
      local t=t
      for n,t in ipairs(t)do
        local n=t.areaName
        local e=this.GetFirstPriorityQuest(t.infoList)
        if e then
          table.insert(mvars.qst_loadableQuestNameList2,e)
        end
      end
    end
  end
end
function this.UpdateTerminalDisplayQuest()
  local n={}
  for s,t in ipairs(mvars.qst_loadableQuestNameList)do
    if this.IsReservedClear(t)then
    elseif TppQuestList.questOrderList[t]and not this.IsAccepted(t)then
    elseif this.IsSkipLoading(t)then
    elseif TppQuestList.questTimerList[t].isOnce and this.IsFailure(t)then
    elseif#n<16 then
      local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]
      if e then
        table.insert(n,e)
      end
    end
  end
  for s,t in ipairs(mvars.qst_loadableQuestNameList2)do
    local s=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]
    if s then
      if TppQuestList.questOrderList[t]and not this.IsAccepted(t)then
      else
        table.insert(n,s)
      end
    end
  end
  MapInfoSystem.ClearAllActiveQuests()MapInfoSystem.SetActiveQuests{questCodes=n}
  this.DEBUG_SetExecutableQuestCode()
end
function this.DEBUG_SetExecutableQuestCode()
  if not Mission.DEBUG_SetExecutableQuest then
    return
  end
  local n={}
  for s,t in ipairs(mvars.qst_loadableQuestNameList)do
    if this.IsReservedClear(t)then
    elseif TppQuestList.questOrderList[t]and not this.IsAccepted(t)then
    elseif this.IsSkipLoading(t)then
    elseif#n<16 then
      local e=TppQuestList.QUEST_DEFINE_IN_NUMBER[t]
      if e then
        table.insert(n,e)
      end
    end
  end
  local t={}
  for s,n in ipairs(mvars.qst_loadableQuestNameList2)do
    local s=TppQuestList.QUEST_DEFINE_IN_NUMBER[n]
    if s then
      if TppQuestList.questOrderList[n]and not this.IsAccepted(n)then
      else
        table.insert(t,s)
      end
    end
  end
  if vars.locationCode==TppDefine.LOCATION_ID.SSD_AFGH then
    Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.SSD_AFGH,questCodes=n}Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.MAFR,questCodes=t}
  elseif vars.locationCode==TppDefine.LOCATION_ID.MAFR then
    Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.MAFR,questCodes=n}Mission.DEBUG_SetExecutableQuest{locationCode=TppDefine.LOCATION_ID.SSD_AFGH,questCodes=t}
  end
end
function this.UpdateQuestTimeCount()Mission.UpdateQuestTimeCount()
end
function this.UpdateGimmickValidity(n)
  if not t(mvars.qst_loadableQuestNameList)then
    return
  end
  for s,t in ipairs(mvars.qst_loadableQuestNameList)do
    this.SetGimmickResourceValidity(t,n)
  end
end
function this.IsLoadableQuestName(n)
  for s,t in ipairs(mvars.qst_loadableQuestNameList)do
    if n==t then
      if(this.IsReservedClear(t)or(TppQuestList.questOrderList[t]and not this.IsAccepted(t)))or this.IsSkipLoading(t)then
        return false
      else
        return true
      end
    end
  end
  return false
end
function this.UpdateAllGimmickValidity(s)
  if not t(mvars.loc_locationTreasureQuest)then
    return
  end
  local n=mvars.loc_locationTreasureQuest.treasureTableList
  if not t(n)then
    return
  end
  for t,n in pairs(n)do
    this.SetGimmickResourceValidity(t,s)
  end
end
function this.ShowAnnounceLog(n,t,a,s)
  if not n then
    return
  end
  if n==l.OPEN then
    TppUI.ShowAnnounceLog"quest_list_update"TppUI.ShowAnnounceLog"quest_add"elseif n==l.CLEAR then
    if not t then
      return
    end
    local n=this.GetQuestNameLangId(t)
    if n~=false then
      local t=ANNOUNCE_LOG_TYPE_LIST[t]
      if t then
        local e,n=TppEnemy.GetQuestCount()
        if e>1 then
          TppUI.ShowAnnounceLog(t,e,n)
        end
      end
      TppUI.ShowAnnounceLog"quest_list_update"TppUI.ShowAnnounceLog("quest_complete",n)
    end
  elseif n==l.FAILURE then
    if not t then
      return
    end
    local e=this.GetQuestNameLangId(t)
    if e~=false then
      TppUI.ShowAnnounceLog"quest_list_update"TppUI.ShowAnnounceLog("quest_delete",e)
    end
  elseif n==l.UPDATE then
    if not t then
      return
    end
    local e=ANNOUNCE_LOG_TYPE_LIST[t]
    if e then
      TppUI.ShowAnnounceLog(e,a,s)
    end
  end
end
function this.OnQuestAreaAnnounceText(t)
  local n=this.GetQuestName(t)
  local t
  if n then
    for s,e in pairs(QUEST_START_RADIO_LIST)do
      if s==n then
        if e.radioNameFirst then
          if e.radioNameSecond then
            if TppRadio.IsPlayed(e.radioNameFirst)then
              t=e.radioNameSecond
            else
              t=e.radioNameFirst
            end
          else
            t=e.radioNameFirst
          end
        end
      end
    end
    if t~=nil then
      TppRadio.Play(t,{delayTime="mid"})
    end
    TppSoundDaemon.PostEvent"sfx_s_sideops_sted"end
end
function this._ChangeToEnable(s,s,n,t)
  if t~=Fox.StrCode32"Player"then
    return
  end
  for t=1,a do
    if this.IsInvokingImpl(t)then
      local e=false
      local s=TppGimmick.IsQuestTarget(n)
      local n=TppAnimal.IsQuestTarget(n)
      if(e or s)or n then
        TppSoundDaemon.PostEvent"sfx_s_enemytag_quest_tgt"if mvars.qst_isRadioTarget[t]==false then
          TppRadio.Play("f1000_rtrg2180",{delayTime="short"})
          mvars.qst_isRadioTarget[t]=true
        end
      end
    end
  end
end
function this.StartSafeTimer(t,n)
  this.StopTimer(t)GkEventTimerManager.Start(t,n)
end
function this.StopTimer(e)
  if GkEventTimerManager.IsTimerActive(e)then
    GkEventTimerManager.Stop(e)
  end
end
function this.GetQuestId(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local e=string.sub(t,-5)
  return e
end
function this.TelopStart(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local n
  n=this.GetQuestId(t)QuestTelopSystem.SetInfo(n,QuestTelopType.Start)QuestTelopSystem.RequestOpen()
end
function this.TelopComplete(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local n
  n=this.GetQuestId(t)QuestTelopSystem.SetInfo(n,QuestTelopType.Complete)QuestTelopSystem.RequestOpen()
end
function this.SetGimmickResourceValidity(s,n)
  if not t(mvars.loc_locationTreasureQuest)then
    return
  end
  local e=mvars.loc_locationTreasureQuest.treasureTableList
  if not t(e)then
    return
  end
  local e=e[s]
  if not e then
    return
  end
  local s=e.treasureBoxResourceTable
  if t(s)then
    for s,e in ipairs(s)do
      if t(e)then
        local e={name=e.name,dataSetName=e.dataSetName,validity=n}Gimmick.SetResourceValidity(e)
      end
    end
  end
  local s=e.treasurePointResourceTable
  if t(s)then
    for s,e in ipairs(s)do
      if t(e)then
        local e={name=e.name,dataSetName=e.dataSetName,validity=n}Gimmick.SetResourceValidity(e)
      end
    end
  end
  if n==true then
    local e=e.treasureKubResourceTable
    if t(e)then
      for s,e in ipairs(e)do
        if t(e)then
          if e.gimmickId then
            Gimmick.ResetGimmick(0,e.name,e.dataSetName,{gimmickId=e.gimmickId})
          else
            local e={name=e.name,dataSetName=e.dataSetName,validity=n}Gimmick.SetResourceValidity(e)
          end
        end
      end
    end
  end
end
function this.GetGimmickResource(n)
  if not t(mvars.loc_locationTreasureQuest)then
    return
  end
  local e=mvars.loc_locationTreasureQuest.treasureTableList
  if not t(e)then
    return
  end
  local e=e[n]
  if not e then
    return
  end
  return e
end
function this.GetWormholeQuest(n)
  if not t(mvars.loc_locationWormholeQuest)then
    return
  end
  local e=mvars.loc_locationWormholeQuest.wormholeQuestTable
  if not t(e)then
    return
  end
  if not e[n]then
    return
  end
  return e[n]
end
function this.OpenWormhole(s,n)
  local e=this.GetWormholeQuest(n)
  if not e then
    return
  end
  local a=e[s]
  if not t(a)then
    return
  end
  local r=mvars.loc_locationWormholeQuest.wormholeHeight or 10
  local l=TppStory.GetCurrentStorySequence()
  local s={}
  local function o(n)
    if t(n)then
      for t,e in ipairs(n)do
        local t={}
        for e,n in ipairs(e.position)do
          t[e]=n
        end
        t[2]=t[2]+r
        local a=0
        if _(n.level)then
          a=n.level
        end
        local e={dropType=TppDefine.WORMHOLE_DROP_TYPE.NPC,position=t,radius=e.radius or 4,gameObjectType=e.gameObjectType or"SsdZombie",count=e.count or 1,level=a,routes=e.routes or{}}
        table.insert(s,e)
      end
    end
  end
  for n,e in ipairs(a)do
    local s=0
    local n
    if t(e)then
      for e,a in ipairs(e)do
        local e=a.storySequence or 0
        local a=a.positionTable or nil
        if((l>=e)and(e>=s))and t(a)then
          s=e
          n=a
        end
      end
    end
    if n then
      o(n)
    end
  end
  if next(s)then
    Mission.OpenWormhole(s)
  end
end
function this.GetOpenRewardCbox(n)
  if not t(mvars.loc_locationTreasureQuest)then
    return
  end
  local e=mvars.loc_locationTreasureQuest.clearRewardCboxTableList
  if not t(e)then
    return
  end
  if not e[n]then
    return
  end
  return e[n]
end
function this.OpenRewardCbox(n)
  local e=this.GetOpenRewardCbox(n)
  if t(e)then
    for n,e in ipairs(e)do
      if(e.pos and e.model)and t(e.contents)then
        SsdRewardCbox.DropCoopObjective{pos=e.pos,model=e.model,showRewardLog=e.showRewardLog or false,contents=e.contents}
      end
    end
  end
end
function this.GetNamePlate(n)
  if not t(mvars.loc_locationTreasureQuest)then
    return
  end
  local e=mvars.loc_locationTreasureQuest.clearNamePlateTableList
  if not t(e)then
    return
  end
  if not e[n]then
    return
  end
  local e=e[n]
  if t(e)then
    for t,e in pairs(e)do
      SsdSbm.AddNamePlate(e)
    end
  end
end
function this.IsRandomFaceQuestName(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local e=TppDefine.QUEST_RANDOM_FACE_INDEX[t]
  if e then
    return true
  end
  return false
end
function this.GetRandomFaceId(t)
  if t==nil then
    t=this.GetCurrentQuestName()
    if t==nil then
      return
    end
  end
  local e=TppDefine.QUEST_RANDOM_FACE_INDEX[t]
  if e then
    return gvars.qst_randomFaceId[e]
  end
end
function this.SetRandomFaceId(e,t)
  local e=TppDefine.QUEST_RANDOM_FACE_INDEX[e]
  if e then
    gvars.qst_randomFaceId[e]=t
  end
end
function this.GetSideOpsListTable()
end
function this.CheckClearBounus(e,e)
end
function this.DecreaseElapsedClearCount(e)
end
function this.PlayClearRadio(e)
end
function this.GetClearKeyItem(e)
end
function this.GetSideOpsInfo(t)
  for n,e in ipairs(v)do
    if e.questName==t then
      return e
    end
  end
  return nil
end
function this.IsShowSideOpsList(t)
  return this.GetSideOpsInfo()~=nil
end
function this.GetQuestNameLangId(t)
  local e=this.GetSideOpsInfo(t)
  if e then
    local e="name_"..string.sub(e.questId,-6)
    return e
  end
  return false
end
function this.GetQuestNameId(t)
  local e=this.GetSideOpsInfo(t)
  if e then
    local e=string.sub(e.questId,-6)
    return e
  end
  return false
end
function this.GetQuestName(t)
  for n,e in ipairs(v)do
    local n=tonumber(string.sub(e.questId,-5))
    if t==n then
      return e.questName
    end
  end
end
function this.CanOpenSideOpsList()
  return true
end
function this.IsImportant(t)
  local e=this.GetSideOpsInfo(t)
  if e then
    return e.isImportant
  end
  return false
end
function this.OpenQuestForce(e)
  local e=TppQuestList.QUEST_INDEX[e]
  if e then
    gvars.qst_questOpenFlag[e]=true
  end
end
function this.CalcQuestClearedCount()
  local e=0
  local t=0
  for s,n in ipairs(v)do
    local n=n.questName
    local n=TppQuestList.QUEST_INDEX[n]
    if gvars.qst_questClearedFlag[n]then
      e=e+1
    end
    t=t+1
  end
  return e,t
end
local s={}
local a={}
function this.AcquireKeyItemOnMissionStart()
  for n,t in pairs(S)do
    if this.IsCleard(n)then
      TppTerminal.AcquireKeyItem{dataBaseId=t,isShowAnnounceLog=true}
    end
  end
  for n,t in pairs(s)do
    if this.IsCleard(n)then
      TppTerminal.AcquireKeyItem{dataBaseId=t,isShowAnnounceLog=true}
    end
  end
  for n,t in pairs(a)do
    if this.IsCleard(n)and not TppMotherBaseManagement.IsGotDataBase{dataBaseId=t.dataBaseId}then
      TppMotherBaseManagement.DirectAddDataBaseAnimal{dataBaseId=t.dataBaseId,areaName=t.areaName,isNew=true}
    end
  end
end
if(Tpp.IsQARelease()or nil)then
  function this.QARELEASE_DEBUG_Init()
    local e
    if DebugMenu then
      e=DebugMenu
    else
      return
    end
    local t={}
    for n,e in ipairs(TppQuestList.QUEST_DEFINE)do
      local e=tonumber(string.sub(e,-5))
      table.insert(t,e)
    end
    if QuestTelopSystem.DEBUG_SetInfo then
      QuestTelopSystem.DEBUG_SetInfo{questCodes=t}
    end
    do
      mvars.qaDebug.targetQuestBlockIndex=0
      e.AddDebugMenu("LuaQuest","targetBlockIndex","int32",mvars.qaDebug,"targetQuestBlockIndex")
      mvars.qaDebug.showCurrentQuest=false
      e.AddDebugMenu("LuaQuest","showCurrentQuest","bool",mvars.qaDebug,"showCurrentQuest")
      mvars.qaDebug.forceQuestClear=false
      e.AddDebugMenu("LuaQuest","forceClear","bool",mvars.qaDebug,"forceQuestClear")
      mvars.qaDebug.updateQuestActive=false
      e.AddDebugMenu("LuaQuest","updateActive","bool",mvars.qaDebug,"updateQuestActive")
      mvars.qaDebug.resetQuestClearFlagAll=false
      e.AddDebugMenu("LuaQuest","resetClearFlagAll","bool",mvars.qaDebug,"resetQuestClearFlagAll")
      mvars.qaDebug.forceLoadQuestIndex=0
      e.AddDebugMenu("LuaQuest","forceLoadIndex","int32",mvars.qaDebug,"forceLoadQuestIndex")
      mvars.qaDebug.enableForceLoadQuest=false
      e.AddDebugMenu("LuaQuest","forceLoad","bool",mvars.qaDebug,"enableForceLoadQuest")
      mvars.qaDebug.enableCheckDefense=false
      e.AddDebugMenu("LuaQuest","checkDefense","bool",mvars.qaDebug,"enableCheckDefense")
      mvars.qaDebug.showOpenedQuests=false
      e.AddDebugMenu("LuaQuest","showOpenedQuests","bool",mvars.qaDebug,"showOpenedQuests")
      mvars.qaDebug.startTelopCheck=false
      e.AddDebugMenu("LuaQuest","startTelopCheck","bool",mvars.qaDebug,"startTelopCheck")
    end
  end
  function this.QAReleaseDebugUpdate()
    if mvars.qaDebug.targetQuestBlockIndex>#n then
      mvars.qaDebug.targetQuestBlockIndex=0
    elseif mvars.qaDebug.targetQuestBlockIndex<0 then
      mvars.qaDebug.targetQuestBlockIndex=#n
    end
    if mvars.qaDebug.forceLoadQuestIndex>#TppQuestList.QUEST_DEFINE then
      mvars.qaDebug.forceLoadQuestIndex=0
    elseif mvars.qaDebug.forceLoadQuestIndex<0 then
      mvars.qaDebug.forceLoadQuestIndex=#TppQuestList.QUEST_DEFINE
    end
    local t=mvars.qaDebug.targetQuestBlockIndex
    local n=mvars.qaDebug.forceLoadQuestIndex
    if mvars.qaDebug.showCurrentQuest then
      this.DEBUG_ShowQuestState()
    end
    if mvars.qaDebug.forceQuestClear then
      mvars.qaDebug.forceQuestClear=false
      this.DEBUG_ForceClear(t)
    end
    if mvars.qaDebug.updateQuestActive then
      mvars.qaDebug.updateQuestActive=false
      this.DEBUG_UpdateActive(t)
    end
    if mvars.qaDebug.resetQuestClearFlagAll then
      mvars.qaDebug.resetQuestClearFlagAll=false
      this.DEBUG_ResetClearFlagAll()
    end
    if mvars.qaDebug.enableForceLoadQuest then
      this.DEBUG_ForceLoad(n)
      mvars.qaDebug.enableForceLoadQuest=false
      mvars.qaDebug.forceLoadQuestIndex=0
    end
    if mvars.qaDebug.showOpenedQuests then
      this.DEBUG_ShowOpenedQuests()
    end
    if mvars.qaDebug.startTelopCheck then
      mvars.qaDebug.startTelopCheck=false
      if QuestTelopSystem.DEBUG_TelopCheckStart then
        QuestTelopSystem.DEBUG_TelopCheckStart()
      end
    end
  end
  function this.DEBUG_ShowQuestState()
    local s=DebugText.Print
    local t=DebugText.NewContext()s(t,"")s(t,{.5,.5,1},"Quest ShowState")
    local a=mvars.qaDebug.forceLoadQuestIndex
    if not a or a==0 then
      s(t,"Load Target[-] : -----")
    else
      local n=TppQuestList.QUEST_DEFINE[a]
      local e=this.SearchBlockIndex(n)s(t,"Load Target["..(tostring(e)..("] : "..tostring(n))))
    end
    for r=1,#n do
      local n=n[r]s(t,"Block : "..n)
      local a=this.GetCurrentQuestName(r)
      if not a then
        s(t,"Current Quest : -----")
      else
        s(t,"Current Quest : "..tostring(a))
      end
      local a=this.GetQuestBlockState(n)
      if not a then
        s(t,"Block State : -----")
      else
        local n={}n[i]="EMPTY"n[h]="PROCESSING"n[f]="INACTIVE"n[d]="ACTIVE"s(t,"Block State : "..tostring(n[a]))
        local n=this.GetCurrentQuestTable(r)
        if n and a~=i then
          s(t,"AreaName : "..tostring(n.areaName))
          local e=n.loadArea
          local r,a,e,l=e[1],e[2],e[3],e[4]s(t,"LoadArea : { "..(tostring(r)..(", "..(tostring(a)..(", "..(tostring(e)..(", "..(tostring(l).." }"))))))))s(t,"InfoList : ")
          for n,e in ipairs(n.infoList)do
            local e=e.name
            s(t,"     "..tostring(e))
          end
        end
      end
    end
  end
  function this.DEBUG_ShowOpenedQuests()Mission.DEBUG_DisplayQuestList()
  end
  function this.DEBUG_ForceClear(s)
    if s==0 then
      for t=1,#n do
        local t=this.GetCurrentQuestName(t)
        if t then
          this.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,t)
        end
      end
    else
      local t=this.GetCurrentQuestName(s)
      if t then
        this.ClearWithSave(TppDefine.QUEST_CLEAR_TYPE.CLEAR,t)
      end
    end
  end
  function this.DEBUG_UpdateActive(t)
    if t==0 then
      for t=1,#n do
        this.UnloadCurrentQuestBlock(n[t])
      end
    else
      this.UnloadCurrentQuestBlock(n[t])
    end
    this.UpdateActiveQuest()
  end
  function this.DEBUG_ResetClearFlagAll()
    for e=1,#TppQuestList.QUEST_DEFINE do
      gvars.qst_questClearedFlag[e]=false
      gvars.qst_questFailureFlag[e]=false
    end
  end
  function this.DEBUG_ForceLoad(t)
    if t==0 then
      return
    end
    local t=TppQuestList.QUEST_DEFINE[t]
    if not t then
      return
    end
    local s=this.SearchBlockIndex(t)
    if s==0 then
      return
    end
    TppCrew.UpdateActiveQuest(t)Mission.RecreateBaseCrew()
    this.UnloadCurrentQuestBlock(n[s])
    mvars.qst_reserveNextQuest[s]=t
  end
end
return this
