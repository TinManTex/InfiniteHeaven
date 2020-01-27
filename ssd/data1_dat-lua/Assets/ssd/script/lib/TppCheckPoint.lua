local this={}
local a=Fox.StrCode32
local n=Tpp.IsTypeFunc
local i=Tpp.IsTypeTable
local t=Tpp.IsTypeString
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local n=GameObject.SendCommand
local n=Tpp.DEBUG_StrCode32ToString
local n=Tpp.IsNotAlert
local o=0
function this.DeclareSVars()
  return{{name="chk_checkPointName",arraySize=TppDefine.CHECK_POINT_MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},{name="chk_checkPointEnable",arraySize=TppDefine.CHECK_POINT_MAX,type=TppScriptVars.TYPE_BOOL,value=0,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.Messages()
  if not mvars.loc_locationCommonCheckPointList then
    return nil
  end
  local n={}
  for t,i in pairs(mvars.loc_locationCommonCheckPointList)do
    if mvars.mis_baseList and this._DoesBaseListInclude(t)then
      for t,i in pairs(i)do
        local t="trap_"..i
        local e={msg="Enter",sender=t,func=function(n,n)
          this.Update{checkPoint=i,trapName=t,safetyCurrentPosition=true}
        end,option={isExecFastTravel=true}}
        table.insert(n,e)
      end
      table.insert(n,nil)
    end
  end
  return Tpp.StrCode32Table{Trap=n}
end
function this.OnAllocate()
  mvars.mis_checkPointList={}
end
function this.Init()
  local n=this.Messages()
  if n then
    this.messageExecTable=Tpp.MakeMessageExecTable(n)
  end
end
function this.OnReload()
  local n=this.Messages()
  if n then
    this.messageExecTable=Tpp.MakeMessageExecTable(n)
  end
end
function this.OnMessage(s,a,o,t,n,i,c)
  Tpp.DoMessage(this.messageExecTable,TppMission.CheckMessageOption,s,a,o,t,n,i,c)
end
function this.Enable(n)
  this._SetEnable(n,true)
end
function this.Disable(n)
  this._SetEnable(n,false)
end
function this.Reset()
  gvars.mis_checkPoint=o
end
function this.RegisterCheckPointList(n)
  local n=n or{}
  for t,n in pairs(n)do
    this._RegisterCheckPoint(n)
  end
  if i(mvars.mis_baseList)then
    for t,n in pairs(mvars.mis_baseList)do
      if mvars.loc_locationCommonCheckPointList and mvars.loc_locationCommonCheckPointList[n]then
        for t,n in pairs(mvars.loc_locationCommonCheckPointList[n])do
          this._RegisterCheckPoint(n)
        end
      end
    end
  end
  if next(mvars.mis_checkPointList)then
    mvars.mis_checkPointList=Tpp.Enum(mvars.mis_checkPointList)
  end
end
function this.SetCheckPointPosition()
  if mvars.mis_checkPointList==nil then
    return
  end
  local n
  for t,e in pairs(mvars.mis_checkPointList)do
    if a(e)==gvars.mis_checkPoint then
      n=e
      break
    end
  end
  if n==nil then
    return
  end
  local e,n=this.GetCheckPointLocator(n)
  if e then
    TppPlayer.SetInitialPosition(e,n)
  end
end
function this.GetCheckPointLocator(e)
  if not t(e)then
    return
  end
  return Tpp.GetLocator("CheckPointIdentifier",e.."_Player")
end
function this.FindNearestCheckPoint(n)
  if not i(n)then
    return
  end
  local i,o=65526,1600
  local o,i=i,nil
  for a,n in pairs(n)do
    if t(n)then
      local e,t=this.GetCheckPointLocator(n)
      if e then
        local t=TppPlayer.GetPosition()
        local e=TppMath.FindDistance(e,t)
        if e<o then
          o=e
          i=n
        end
      end
    end
  end
  if i then
    return i
  end
end
function this.IsEnable(e)
  local n
  if t(e)then
    n=a(e)
  else
    n=e
  end
  for e=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[e]==n then
      return svars.chk_checkPointEnable[e]
    end
  end
  return false
end
function this.Update(n)
  if vars.missionCode==TppDefine.SYS_MISSION_ID.SELECT then
    return
  end
  local o
  local l
  local s
  local r
  local c
  if t(n)then
    o=n
  elseif i(n)then
    o=n.checkPoint
    l=n.ignoreAlert
    s=n.atCurrentPosition
    r=n.safetyCurrentPosition
    c=n.trapName
  else
    return
  end
  if o~=nil and not this.IsEnable(o)then
    return
  end
  local t,t,n,t=TppMission.GetSyncMissionStatus()
  if n then
    return
  end
  local n
  if s then
    this.Reset()
    TppPlayer.SetInitialPositionToCurrentPosition()
  elseif r then
    if Gimmick.IsVehicleFultonUpdating()then
      return
    end
    if Player.CanSaveAsCheckPoint and Player.CanSaveAsCheckPoint()then
      this.Reset()
      TppPlayer.SetInitialPositionToCurrentPosition()Player.NotifyCheckPointTrapName(c)
      local e=TppSave.GetGameSaveFileName()
      if TppSave.IsSavingWithFileName(e)or TppSave.HasQueue(e)then
        n=true
      end
    end
  else
    if not mvars.mis_checkPointList then
      return
    end
    if not mvars.mis_checkPointList[o]then
      return
    end
    gvars.mis_checkPoint=a(o)
    this.SetCheckPointPosition()
  end
  TppMission.VarSaveOnUpdateCheckPoint(n)GkEventTimerManager.Start("Timer_UpdateCheckPoint",.01)
end
function this.UpdateAtCurrentPosition()
  this.Update{atCurrentPosition=true}
end
function this.DEBUG_Init()
  mvars.debug.showCheckPointList=false;(nil).AddDebugMenu("LuaCheckPoint","CHK.showCheckPointList","bool",mvars.debug,"showCheckPointList")
end
function this.DebugUpdate()
  local i=DebugText.NewContext()
  if mvars.debug.showCheckPointList then
    DebugText.Print(i,{.5,.5,1},"TppCheckPoint: showCheckPointList")
    for o,n in pairs(mvars.mis_checkPointList)do
      if t(n)and this.IsEnable(n)then
        DebugText.Print(i,{1,1,1},n)
      end
    end
  end
end
function this._SetEnable(n,o)
  if not n then
    return
  end
  if i(n)then
    if n.baseName then
      if i(n.baseName)then
        for t,n in pairs(n.baseName)do
          this._SetEnable({baseName=n},o)
        end
      else
        if this._DoesBaseListInclude(n.baseName)then
          for t,n in pairs(mvars.loc_locationCommonCheckPointList[n.baseName])do
            this._SetEnable({checkPointName=n},o)
          end
        end
      end
    end
    if n.checkPointName then
      if i(n.checkPointName)then
        for t,n in pairs(n.checkPointName)do
          this._SetEnable({checkPointName=n},o)
        end
      else
        local e
        if t(n.checkPointName)then
          e=Fox.StrCode32(n.checkPointName)
        else
          e=n.checkPointName
        end
        if e and e~=0 then
          for n=0,TppDefine.CHECK_POINT_MAX-1 do
            if svars.chk_checkPointName[n]==e then
              svars.chk_checkPointEnable[n]=o
              return
            end
          end
        end
      end
    end
  end
end
function this._RegisterCheckPoint(n)
  if not n then
    return
  end
  table.insert(mvars.mis_checkPointList,n)
  local o
  if t(n)then
    o=Fox.StrCode32(n)
  else
    o=n
  end
  if this._DoesCheckPointListInclude(o)then
    return
  end
  if i(svars.chk_checkPointName)then
    local e=0
    for n=0,TppDefine.CHECK_POINT_MAX-1 do
      if svars.chk_checkPointName[n]==0 then
        e=n
        break
      end
    end
    svars.chk_checkPointName[e]=o
    svars.chk_checkPointEnable[e]=true
  end
end
function this._DoesBaseListInclude(n)
  if mvars.mis_baseList==nil then
    return
  end
  for t,e in pairs(mvars.mis_baseList)do
    if e==n then
      return true
    end
  end
  return false
end
function this._DoesCheckPointListInclude(e)
  if not e then
    return false
  end
  local n
  if t(e)then
    n=Fox.StrCode32(e)
  else
    n=e
  end
  for e=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[e]==n then
      return true
    end
  end
  return false
end
return this
