local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local n=GameObject.GetGameObjectId
local this={}
function this.CreateInstance(t,a)
  local instance=BaseFlagMission.CreateInstance(t)
  instance.targetList=a
  function instance.GetTargetDeadVariableName(a)
    return tostring(t)..("_"..(tostring(a).."_IsDead"))
  end
  instance.saveVarsList={}
  for a,t in ipairs(instance.targetList)do
    table.insert(instance.saveVarsList,{name=instance.GetTargetDeadVariableName(t),type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION})
  end
  function instance.IsTarget(t)
    if fvars[instance.GetTargetDeadVariableName(t)]~=nil then
      return true
    end
    return false
  end
  function instance.GetTargetNameFromGameObjectId(t)
    for a,e in ipairs(instance.targetList)do
      if t==n(e)then
        return e
      end
    end
  end
  function instance.IsTargetDead(t)
    return fvars[instance.GetTargetDeadVariableName(t)]
  end
  function instance.OnTargetDead(t)fvars[instance.GetTargetDeadVariableName(t)]=true
  end
  function instance.ClearCondition()
    for a,t in ipairs(instance.targetList)do
      if not instance.IsTargetDead(t)then
        return false
      end
    end
    return true
  end
  function instance.GetDeadCount()
    local t=0
    for n,a in ipairs(instance.targetList)do
      if instance.IsTargetDead(a)then
        t=t+1
      end
    end
    return t
  end
  instance.commonMessageTable=instance.AddMessage(instance.commonMessageTable,{GameObject={{msg="Dead",func=function(t)
    local t=instance.GetTargetNameFromGameObjectId(t)
    if t then
      instance.OnTargetDead(t)
    else
      return
    end
    TppUI.ShowAnnounceLog("achieveObjectiveCount",instance.GetDeadCount(),#instance.targetList)
    if instance.ClearCondition()then
      SsdFlagMission.SetNextStep"GameEscape"end
  end}}})
  return instance
end
return this
