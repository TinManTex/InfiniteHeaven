-- BaseMission.lua
local this={}
local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
function this.CreateInstance(missionName)
  local instance={}
  instance.missionName=missionName
  instance.NO_RESULT=true
  instance.sequences={}
  instance.sequenceList={"Seq_Game_MainGame"}
  function instance.OnLoad()
    TppSequence.RegisterSequences(instance.sequenceList)
    TppSequence.RegisterSequenceTable(instance.sequences)
    instance.enemyScript=_G[tostring(instance.missionName).."_enemy"]
    instance.radioScript=_G[tostring(instance.missionName).."_radio"]
  end
  function instance.MissionPrepare()
    if instance.RegiserMissionSystemCallback()then
      instance.RegiserMissionSystemCallback()
    end
  end
  function instance.OnRestoreSVars()
  end
  instance.messageTable={
    Trap={
      {sender="trap_base",msg="Enter",func=function()
        instance.OnReturnToBaseOrCamp()
        TppQuest.UpdateActiveQuest()
        TppMission.UpdateCheckPointAtCurrentPosition()
      end,option={isExecFastTravel=true}},
      {sender="trap_base",msg="Exit",func=function()
        SsdBlankMap.StartExploration()
        TppMission.UpdateCheckPointAtCurrentPosition()
      end,option={isExecFastTravel=true}}
    },
    GameObject={
      {msg="GimmickIn",func=function(t,n)
        if n==Fox.StrCode32"TYPE_CAMP"then
          instance.OnReturnToBaseOrCamp()
          TppMission.UpdateCheckPointAtCurrentPosition()
        end
      end}
    },
    nil
  }
  function instance.Messages()
    if instance.messageTable then
      return StrCode32Table(instance.messageTable)
    end
  end
  function instance.OnReturnToBaseOrCamp()
    SsdSbm.ShowSettlementReport()
    SsdBlankMap.UpdateReachInfo()
  end
  return instance
end
return this
