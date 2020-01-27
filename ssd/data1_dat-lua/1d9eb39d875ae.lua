local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local e=GameObject.GetGameObjectId
local this={}
function this.CreateInstance(a,s)
  local instance=BaseFlagMission.CreateInstance(a)
  this.targetTrapName=s
  instance.saveVarsList={{name=tostring(a).."isClear",type=TppScriptVars.TYPE_BOOL,value=false,save=true,category=TppScriptVars.CATEGORY_MISSION}}
  function instance.ClearCondition()
    return fvars[tostring(a).."isClear"]
  end
  instance.commonMessageTable=instance.AddMessage(instance.commonMessageTable,{Trap={{sender=s,msg="Enter",func=function(t,e)
    if Tpp.IsPlayer(e)then
      local e=SsdFlagMission.GetCurrentStepName()
      if e~="GameEscape"then
        SsdFlagMission.SetNextStep"GameEscape"fvars[tostring(a).."isClear"]=true
      end
    end
  end,option={isExecFastTravel=true}}}})
  return instance
end
return this
