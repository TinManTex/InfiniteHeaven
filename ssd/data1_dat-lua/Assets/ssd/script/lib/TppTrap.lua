-- ssd TppTrap.lua
local this={}
local StrCode32=Fox.StrCode32
local IsTypeFunc=Tpp.IsTypeFunc
local IsTypeTable=Tpp.IsTypeTable
local IsTypeString=Tpp.IsTypeString
local trapListMax=64
function this.OnAllocate(missionTable)
  if missionTable.sequence and missionTable.sequence.VARIABLE_TRAP_SETTING then
    if not IsTypeTable(missionTable.sequence.VARIABLE_TRAP_SETTING)then
      return
    end
    mvars.trp_variableTrapList=missionTable.sequence.VARIABLE_TRAP_SETTING
    if#mvars.trp_variableTrapList==0 then
      return
    end
    if#mvars.trp_variableTrapList>trapListMax then
      return
    end
    mvars.trp_variableTrapTable={}
    for i,trapInfo in ipairs(mvars.trp_variableTrapList)do
      local trapName=trapInfo.name
      if not IsTypeString(trapName)then
        return
      end
      if trapInfo.initialState==nil then
        return
      end
      if trapInfo.type==nil then
        return
      end
      mvars.trp_variableTrapTable[trapName]={}
      mvars.trp_variableTrapTable[trapName].type=trapInfo.type
      mvars.trp_variableTrapTable[trapName].initialState=trapInfo.initialState
      mvars.trp_variableTrapTable[trapName].index=i
      mvars.trp_variableTrapTable[trapName].packLabel=trapInfo.packLabel
    end
  end
end
function this.DEBUG_Init()
  mvars.debug.showTrapStatus=false
  ;(nil).AddDebugMenu("LuaSystem","TRP.trapStatus","bool",mvars.debug,"showTrapStatus")
  mvars.debug.trapStatusScroll=0
  ;(nil).AddDebugMenu("LuaSystem","TRP.trapScroll","int32",mvars.debug,"trapStatusScroll")
end
function this.DebugUpdate()
  local mvars=mvars
  local debug=mvars.debug
  local DebugPrint=DebugText.Print
  local context=DebugText.NewContext()
  if mvars.debug.showTrapStatus and mvars.trp_variableTrapList then
    DebugPrint(context,{.5,.5,1},"LuaSystem TRP.trapStatus")
    local e=1
    if mvars.debug.trapStatusScroll>1 then
      e=mvars.debug.trapStatusScroll
    end
    for i,trapInfo in ipairs(mvars.trp_variableTrapList)do
      if i>=e then
        local trapName=trapInfo.name
        local enabled=svars.trp_variableTrapEnable[i]
        DebugPrint(context,{.5,.5,1},"trapName = "..(tostring(trapName)..(", status = "..tostring(enabled))))
      end
    end
  end
end
function this.InitializeVariableTraps()
  if mvars.trp_variableTrapList==nil then
    return
  end
  for i,trapInfo in ipairs(mvars.trp_variableTrapList)do
    local isForPackLabel=true
    if trapInfo.packLabel then
      isForPackLabel=TppPackList.IsMissionPackLabelList(trapInfo.packLabel)
    end
    if isForPackLabel then
      if trapInfo.initialState==TppDefine.TRAP_STATE.ENABLE then
        this.Enable(trapInfo.name)
      elseif trapInfo.initialState==TppDefine.TRAP_STATE.DISABLE then
        this.Disable(trapInfo.name)
      else
        this.Enable(trapInfo.name)
      end
    end
  end
end
function this.RestoreVariableTrapState()
  if mvars.trp_variableTrapList==nil then
    return
  end
  for i,trapInfo in ipairs(mvars.trp_variableTrapList)do
    local isForPackLabel=true
    if trapInfo.packLabel then
      isForPackLabel=TppPackList.IsMissionPackLabelList(trapInfo.packLabel)
    end
    if isForPackLabel then
      if svars.trp_variableTrapEnable[i]then
        this.Enable(trapInfo.name)
      else
        this.Disable(trapInfo.name)
      end
    end
  end
end
function this.DeclareSVars()
  return{{name="trp_variableTrapEnable",arraySize=trapListMax,type=TppScriptVars.TYPE_BOOL,value=true,save=false,sync=false,wait=false,category=TppScriptVars.CATEGORY_MISSION},nil}
end
function this.Enable(trapName)
this.ChangeTrapState(trapName,true)
end
function this.Disable(trapName)
this.ChangeTrapState(trapName,false)
end
function this.ChangeTrapState(trapName,enable)
  local trapInfo=mvars.trp_variableTrapTable[trapName]
  if trapInfo==nil then
    return
  end
  local i=trapInfo.index
  local trapFound
  if trapInfo.type==TppDefine.TRAP_TYPE.NORMAL then
    trapFound=this.ChangeNormalTrapState(trapName,enable)
  elseif trapInfo.type==TppDefine.TRAP_TYPE.TRIGGER then
    trapFound=this.ChangeTriggerTrapState(trapName,enable)
  else
    trapFound=this.ChangeNormalTrapState(trapName,enable)
  end
  if trapFound then
    svars.trp_variableTrapEnable[i]=enable
  end
end
function this.ChangeNormalTrapState(trapName,enable)
  return TppDataUtility.SetEnableDataFromIdentifier("VariableTrapIdentifier",trapName,enable)
end
function this.ChangeTriggerTrapState(trapName,enable)
  Geo.GeoLuaEnableTriggerTrap(trapName,enable)
  return true
end
return this
