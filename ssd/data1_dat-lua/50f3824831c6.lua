local n=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local this={}
function this.CreateInstance(e,a,t,r)
  local instance=BaseFlagMission.CreateInstance(e)
  instance.targetList=a
  instance.targetAreaIdentifier=t
  instance.targetAreaKey=r
  function instance.Initialize()
  end
  function instance.GetTargetVariableName(t)
    local a
    if Tpp.IsTypeString(t)then
      a=n(t)
    else
      a=t
    end
    return tostring(instance.missionName)..("_"..(tostring(a).."_Count"))
  end
  instance.saveVarsList={}
  for t,a in ipairs(instance.targetList)do
    table.insert(instance.saveVarsList,{name=instance.GetTargetVariableName(a.name),type=TppScriptVars.TYPE_UINT32,value=0,save=true,category=TppScriptVars.CATEGORY_MISSION})
  end
  function instance.IsTarget(a)
    if fvars[instance.GetTargetVariableName(a)]~=nil then
      return true
    end
    return false
  end
  function instance.GetItemCount(a)
    return fvars[instance.GetTargetVariableName(a)]
  end
  function instance.ClearCondition()
    for t,a in ipairs(instance.targetList)do
      if a.targetAreaIdentifier and a.targetAreaKey then
        local e=DataIdentifier.GetDataWithIdentifier(a.targetAreaIdentifier,a.targetAreaKey)
        local e=e.worldTransform
        local t=e.translation
        local e=e.scale:GetX()
        local t,a=Gimmick.SearchNearestSsdGimmick{pos=t,typeId=a.name}
        if not a or t>e then
          return false
        end
      else
        local e=fvars[instance.GetTargetVariableName(a.name)]
        if e<a.count then
          return false
        end
      end
    end
    return true
  end
  instance.commonMessageTable=instance.AddMessage(instance.commonMessageTable,{
    GameObject={
      {msg="BuildingEnd",
        func=function(t,a)
          if instance.IsTarget(a)then
            local a=instance.GetTargetVariableName(a)
            fvars[a]=fvars[a]+1
            if instance.ClearCondition()then
              SsdFlagMission.SetNextStep"GameEscape"
            end
          end
        end}
    }
  })
  return instance
end
return this
