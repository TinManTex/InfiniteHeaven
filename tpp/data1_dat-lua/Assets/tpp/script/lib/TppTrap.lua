local a={}
local e=Fox.StrCode32
local e=Tpp.IsTypeFunc
local e=Tpp.IsTypeTable
local t=Tpp.IsTypeString
local r=64
function a.OnAllocate(a)
  if a.sequence and a.sequence.VARIABLE_TRAP_SETTING then
    if not e(a.sequence.VARIABLE_TRAP_SETTING)then
      return
    end
    mvars.trp_variableTrapList=a.sequence.VARIABLE_TRAP_SETTING
    if#mvars.trp_variableTrapList==0 then
      return
    end
    if#mvars.trp_variableTrapList>r then
      return
    end
    mvars.trp_variableTrapTable={}
    for r,e in ipairs(mvars.trp_variableTrapList)do
      local a=e.name
      if not t(a)then
        return
      end
      if e.initialState==nil then
        return
      end
      if e.type==nil then
        return
      end
      mvars.trp_variableTrapTable[a]={}
      mvars.trp_variableTrapTable[a].type=e.type
      mvars.trp_variableTrapTable[a].initialState=e.initialState
      mvars.trp_variableTrapTable[a].index=r
      mvars.trp_variableTrapTable[a].packLabel=e.packLabel
    end
  end
end
function a.DEBUG_Init()
  mvars.debug.showTrapStatus=false;(nil).AddDebugMenu("LuaSystem","TRP.trapStatus","bool",mvars.debug,"showTrapStatus")
  mvars.debug.trapStatusScroll=0;(nil).AddDebugMenu("LuaSystem","TRP.trapScroll","int32",mvars.debug,"trapStatusScroll")
end
function a.DebugUpdate()
  local a=mvars
  local e=a.debug
  local t=(nil).Print
  local r=(nil).NewContext()
  if a.debug.showTrapStatus and a.trp_variableTrapList then
    t(r,{.5,.5,1},"LuaSystem TRP.trapStatus")
    local e=1
    if a.debug.trapStatusScroll>1 then
      e=a.debug.trapStatusScroll
    end
    for a,n in ipairs(a.trp_variableTrapList)do
      if a>=e then
        local e=n.name
        local a=svars.trp_variableTrapEnable[a]t(r,{.5,.5,1},"trapName = "..(tostring(e)..(", status = "..tostring(a))))
      end
    end
  end
end
function a.InitializeVariableTraps()
  if mvars.trp_variableTrapList==nil then
    return
  end
  for t,e in ipairs(mvars.trp_variableTrapList)do
    local t=true
    if e.packLabel then
      t=TppPackList.IsMissionPackLabelList(e.packLabel)
    end
    if t then
      if e.initialState==TppDefine.TRAP_STATE.ENABLE then
        a.Enable(e.name)
      elseif e.initialState==TppDefine.TRAP_STATE.DISABLE then
        a.Disable(e.name)
      else
        a.Enable(e.name)
      end
    end
  end
end
function a.RestoreVariableTrapState()
  if mvars.trp_variableTrapList==nil then
    return
  end
  for r,e in ipairs(mvars.trp_variableTrapList)do
    local t=true
    if e.packLabel then
      t=TppPackList.IsMissionPackLabelList(e.packLabel)
    end
    if t then
      if svars.trp_variableTrapEnable[r]then
        a.Enable(e.name)
      else
        a.Disable(e.name)
      end
    end
  end
end
function a.DeclareSVars()
  return{{name="trp_variableTrapEnable",arraySize=r,type=TppScriptVars.TYPE_BOOL,value=true,save=true,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function a.Enable(e)a.ChangeTrapState(e,true)
end
function a.Disable(e)a.ChangeTrapState(e,false)
end
function a.ChangeTrapState(e,t)
  local r=mvars.trp_variableTrapTable[e]
  if r==nil then
    return
  end
  local i=r.index
  local n
  if r.type==TppDefine.TRAP_TYPE.NORMAL then
    n=a.ChangeNormalTrapState(e,t)
  elseif r.type==TppDefine.TRAP_TYPE.TRIGGER then
    n=a.ChangeTriggerTrapState(e,t)
  else
    n=a.ChangeNormalTrapState(e,t)
  end
  if n then
    svars.trp_variableTrapEnable[i]=t
  end
end
function a.ChangeNormalTrapState(a,t)
  local e=Tpp.GetDataBodyWithIdentifier("VariableTrapIdentifier",a,"GeoTrap")
  if e then
    TppDataUtility.SetEnableDataFromIdentifier("VariableTrapIdentifier",a,t)
    return true
  end
end
function a.ChangeTriggerTrapState(e,a)Geo.GeoLuaEnableTriggerTrap(e,a)
  return true
end
return a
