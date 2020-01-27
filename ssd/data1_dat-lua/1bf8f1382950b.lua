local a=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local this={}
function this.CreateInstance(t,n)
  local instance=BaseFlagMission.CreateInstance(t)
  instance.targetTable=n
  function instance.GetTargetCount()
    local t=0
    for e,e in pairs(instance.targetTable)do
      t=t+1
    end
    return t
  end
  function instance.GetTargetVariableName(n)
    local e
    if Tpp.IsTypeString(n)then
      e=a(n)
    else
      e=n
    end
    return tostring(t)..("_"..(tostring(e).."_Count"))
  end
  function instance.GetTargetClearVariableName(e)
    local n
    if Tpp.IsTypeString(e)then
      n=a(e)
    else
      n=e
    end
    return tostring(t)..("_"..(tostring(n).."_Cleared"))
  end
  function instance.GetConditionalExecutionVarsName(e)
    return tostring(t)..("_"..(tostring(e).."_ConditionCleared"))
  end
  function instance.BeforeOnAllocate()
    if not instance.saveVarsList then
      instance.saveVarsList={}
    end
    for t,n in pairs(instance.targetTable)do
      table.insert(instance.saveVarsList,{name=instance.GetTargetVariableName(t),type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION})
      table.insert(instance.saveVarsList,{name=instance.GetTargetClearVariableName(t),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION})
    end
    local t=instance.conditionalExecutionTableList
    if Tpp.IsTypeTable(t)then
      for t,n in pairs(t)do
        table.insert(instance.saveVarsList,{name=instance.GetConditionalExecutionVarsName(t),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION})
      end
    end
  end
  function instance.IsTarget(t)
    return fvars[instance.GetTargetVariableName(t)]~=nil
  end
  function instance.GetItemCount(t)
    return fvars[instance.GetTargetVariableName(t)]
  end
  function instance.GetClearCount()
    local t=0
    for r,a in pairs(instance.targetTable)do
      local n=0
      if a.permitPosession then
        n=SsdSbm.GetCountProduction{id=r,inInventory=true,inWarehouse=true}
      else
        n=fvars[instance.GetTargetVariableName(r)]
      end
      if n>=a.count then
        t=t+1
      end
    end
    return t
  end
  function instance.ClearCondition()
    for n,a in pairs(instance.targetTable)do
      local t=0
      if a.permitPosession then
        t=SsdSbm.GetCountProduction{id=n,inInventory=true,inWarehouse=true}
      else
        t=fvars[instance.GetTargetVariableName(n)]
      end
      if t<a.count then
        return false
      end
    end
    return true
  end
  function instance.IsConditionalExecutionCleared(t)
    return fvars[instance.GetConditionalExecutionVarsName(t)]
  end
  function instance.ClearConditionalExecution(t)fvars[instance.GetConditionalExecutionVarsName(t)]=true
  end
  instance.commonMessageTable=instance.AddMessage(instance.commonMessageTable,{Sbm={{msg="OnGetItem",func=function(t,n,n,r)
    if SsdFlagMission.GetCurrentStepIndex()>=SsdFlagMission.GetStepIndex"GameEscape"then
      return
    end
    local a=false
    if instance.IsTarget(t)then
      local n=instance.GetTargetVariableName(t)fvars[n]=fvars[n]+r
      TppUI.ShowAnnounceLog("achieveObjectiveCount",instance.GetClearCount(),instance.GetTargetCount())
      if instance.ClearCondition()then
        SsdFlagMission.SetNextStep"GameEscape"a=true
      elseif not fvars[instance.GetTargetClearVariableName(t)]then
        local n=instance.targetTable[t].radio
        if n then
          TppRadio.Play(n)
        end
        fvars[instance.GetTargetClearVariableName(t)]=true
      end
    end
    local t=instance.conditionalExecutionTableList
    if not Tpp.IsTypeTable(t)then
      return false
    end
    for t,r in pairs(t)do
      if not instance.IsConditionalExecutionCleared(t)then
        local n=r.condition
        if Tpp.IsTypeTable(n)then
          local a=true
          local n=n.resource
          if Tpp.IsTypeTable(n)then
            for t,e in ipairs(n)do
              local t=SsdSbm.GetCountResource{id=e.name,inInventory=true,inWarehouse=true}
              if t<e.count then
                a=false
              end
            end
          end
          if a then
            local n=r.execution
            if Tpp.IsTypeTable(n)then
              local e=n.radio
              if e then
                TppRadio.Play(e)
              end
            end
            instance.ClearConditionalExecution(t)
          end
        end
      end
    end
  end}}})
  return instance
end
return this
