local e={}
local a=Fox.StrCode32
local n=Tpp.IsTypeFunc
local i=Tpp.IsTypeTable
local t=Tpp.IsTypeString
local n=GameObject.GetGameObjectId
local n=GameObject.NULL_ID
local n=GameObject.SendCommand
local n=Tpp.DEBUG_StrCode32ToString
local h=Tpp.IsHelicopter
local f=Tpp.IsNotAlert
local s=0
function e.DeclareSVars()
  return{
    {name="chk_checkPointName",arraySize=TppDefine.CHECK_POINT_MAX,type=TppScriptVars.TYPE_UINT32,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    {name="chk_checkPointEnable",arraySize=TppDefine.CHECK_POINT_MAX,type=TppScriptVars.TYPE_BOOL,value=0,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},
    nil
  }
end
function e.Messages()
  if not mvars.loc_locationCommonCheckPointList then
    return nil
  end
  local n={}
  for t,i in pairs(mvars.loc_locationCommonCheckPointList)do
    if mvars.mis_baseList and e._DoesBaseListInclude(t)then
      for t,i in pairs(i)do
        local t="trap_"..i
        local e={msg="Enter",sender=t,
          func=function(n,n)
            e.Update{checkPoint=i,trapName=t,safetyCurrentPosition=true}
          end
        }
        table.insert(n,e)
      end
      table.insert(n,nil)
    end
  end
  return Tpp.StrCode32Table{Trap=n}
end
function e.OnAllocate()mvars.mis_checkPointList={}
end
function e.Init()
  local n=e.Messages()
  if n then
    e.messageExecTable=Tpp.MakeMessageExecTable(n)
  end
end
function e.OnReload()
  local n=e.Messages()
  if n then
    e.messageExecTable=Tpp.MakeMessageExecTable(n)
  end
end
function e.OnMessage(t,c,n,i,o,a,s)
  Tpp.DoMessage(e.messageExecTable,TppMission.CheckMessageOption,t,c,n,i,o,a,s)
end
function e.Enable(n)e._SetEnable(n,true)
end
function e.Disable(n)e._SetEnable(n,false)
end
function e.Reset()gvars.mis_checkPoint=s
end
function e.RegisterCheckPointList(n)
  local n=n or{}
  for t,n in pairs(n)do
    e._RegisterCheckPoint(n)
  end
  if i(mvars.mis_baseList)then
    for t,n in pairs(mvars.mis_baseList)do
      if mvars.loc_locationCommonCheckPointList and mvars.loc_locationCommonCheckPointList[n]then
        for t,n in pairs(mvars.loc_locationCommonCheckPointList[n])do
          e._RegisterCheckPoint(n)
        end
      end
    end
  end
  if next(mvars.mis_checkPointList)then
    mvars.mis_checkPointList=Tpp.Enum(mvars.mis_checkPointList)
  end
end
function e.SetCheckPointPosition()
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
  local e,n=e.GetCheckPointLocator(n)
  if e then
    TppPlayer.SetInitialPosition(e,n)
  end
end
function e.GetCheckPointLocator(e)
  if not t(e)then
    return
  end
  return Tpp.GetLocator("CheckPointIdentifier",e.."_Player")
end
function e.FindNearestCheckPoint(n)
  if not i(n)then
    return
  end
  local i,o=65526,1600
  local o,i=i,nil
  for a,n in pairs(n)do
    if t(n)then
      local e,t=e.GetCheckPointLocator(n)
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
function e.IsEnable(e)
  local n
  if t(e)then
    n=a(e)
  else
    n=e
  end
  for e=0,TppDefine.CHECK_POINT_MAX-1 do
    if svars.chk_checkPointName[e]==n then
      return svars.chk_checkPointEnable[e]end
  end
  return false
end
function e.Update(n)
  local o
  local s
  local r
  local c
  local d
  local l
  if t(n)then
    o=n
  elseif i(n)then
    o=n.checkPoint
    s=n.ignoreAlert
    r=n.permitHelicopter
    c=n.atCurrentPosition
    d=n.safetyCurrentPosition
    l=n.trapName
  else
    return
  end
  if o~=nil and not e.IsEnable(o)then
    return
  end
  local t,t,n,t=TppMission.GetSyncMissionStatus()
  if n then
    return
  end
  if not r and h(vars.playerVehicleGameObjectId)then
    return
  end
  if not s and not f()then
    return
  end
  local n
  if c then
    e.Reset()
    TppPlayer.SetInitialPositionToCurrentPosition()
  elseif d then
    if Gimmick.IsVehicleFultonUpdating()then
      return
    end
    if Player.CanSaveAsCheckPoint and Player.CanSaveAsCheckPoint()then
      e.Reset()
      TppPlayer.SetInitialPositionToCurrentPosition()Player.NotifyCheckPointTrapName(l)
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
    gvars.mis_checkPoint=a(o)e.SetCheckPointPosition()
  end
  TppMission.VarSaveOnUpdateCheckPoint(n)
  GkEventTimerManager.Start("Timer_UpdateCheckPoint",.01)
end
function e.UpdateAtCurrentPosition()
  e.Update{atCurrentPosition=true}
end
function e.DEBUG_Init()
  mvars.debug.showCheckPointList=false;
  (nil).AddDebugMenu("LuaCheckPoint","CHK.showCheckPointList","bool",mvars.debug,"showCheckPointList")
end
function e.DebugUpdate()
  local i=(nil).NewContext()
  if mvars.debug.showCheckPointList then
    (nil).Print(i,{.5,.5,1},"TppCheckPoint: showCheckPointList")
    for o,n in pairs(mvars.mis_checkPointList)do
      if t(n)and e.IsEnable(n)then
        (nil).Print(i,{1,1,1},n)
      end
    end
  end
end
function e._SetEnable(n,o)
  if not n then
    return
  end
  if i(n)then
    if n.baseName then
      if i(n.baseName)then
        for t,n in pairs(n.baseName)do
          e._SetEnable({baseName=n},o)
        end
      else
        if e._DoesBaseListInclude(n.baseName)then
          for t,n in pairs(mvars.loc_locationCommonCheckPointList[n.baseName])do
            e._SetEnable({checkPointName=n},o)
          end
        end
      end
    end
    if n.checkPointName then
      if i(n.checkPointName)then
        for t,n in pairs(n.checkPointName)do
          e._SetEnable({checkPointName=n},o)
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
function e._RegisterCheckPoint(n)
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
  if e._DoesCheckPointListInclude(o)then
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
function e._DoesBaseListInclude(n)
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
function e._DoesCheckPointListInclude(e)
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
return e
