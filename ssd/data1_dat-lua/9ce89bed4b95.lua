local e=Fox.StrCode32
local e=Tpp.StrCode32Table
local t=GameObject.GetGameObjectId
local this={}
function this.CreateInstance(e,a)
  local instance=BaseFlagMission.CreateInstance(e)
  instance.targetList=a
  function instance.GetTargetNameFromGameObjectId(a)
    for n,e in ipairs(instance.targetList)do
      if a==t(e)then
        return e
      end
    end
  end
  instance.commonMessageTable=instance.AddMessage(instance.commonMessageTable,{GameObject={{msg="Dead",func=function(a)
    local a=instance.GetTargetNameFromGameObjectId(a)
    if a then
      TppUI.ShowAnnounceLog"target_died"
      SsdFlagMission.ClearWithSave(TppDefine.FLAG_MISSION_CLEAR_TYPE.FAILURE,instance.missionName)
      SsdFlagMission.FadeOutAndUnloadBlock()
    end
  end}}})
  function instance.ClearCondition()
    for a,e in ipairs(instance.targetList)do
      if TppEnemy.GetStatus(e)~=TppGameObject.NPC_STATE_CARRIED then
        return false
      end
    end
    return true
  end
  instance.flagStep.GameMain.messageTable={GameObject={{msg="Carried",func=function(a,t)
    local e=instance.GetTargetNameFromGameObjectId(a)
    if e then
      TppUI.ShowAnnounceLog"recoverTarget"
      SsdFlagMission.SetNextStep"GameEscape"
      end
  end}}}
  return instance
end
return this
