local StrCode32=Fox.StrCode32
local StrCode32Table=Tpp.StrCode32Table
local GetGameObjectId=GameObject.GetGameObjectId
local IsTypeTable=Tpp.IsTypeTable
local this={}
function this.CreateInstance(a)
  local instance=BaseQuest.CreateInstance(a)
  instance.questType=TppDefine.QUEST_TYPE.COLLECTION
  mvars.questSpace[instance.questName].targetStateTable={}
  function instance.InitializeQuestSpaceVehicle(t)
    if not mvars.questSpace then
      mvars.questSpace={}
    end
    if not mvars.questSpace[instance.questName]then
      mvars.questSpace[t]={}
    end
    if not mvars.questSpace[t].targetStateTable then
      mvars.questSpace[t].targetStateTable={}
    end
  end
  function instance.IsVehicleTarget(gameId)
    if gameId==GameObject.GetGameObjectId(instance.gameObjectName)then
      return true
    end
    return false
  end
  function instance.SetVehicleEnabled(anabled)
    local vehicleId=GetGameObjectId(instance.gameObjectName)
    GameObject.SendCommand(vehicleId,{id="SetEnabled",enabled=anabled})
  end
  function instance.SetWalkerGearRespawn()
    local gameId=GetGameObjectId(instance.gameObjectName)
    GameObject.SendCommand(gameId,{id="Respawn"})
  end
  function instance.questStep.Quest_Main:OnEnter()
    instance.baseStep.OnEnter(self)
    instance.InitializeQuestSpaceVehicle(a)
    instance.SetVehicleEnabled(true)
    if instance.isWaklerGear==true then
      instance.SetWalkerGearRespawn()
    end
  end
  instance.questStep.Quest_Main.messageTable=Tpp.MergeMessageTable(instance.questStep.Quest_Main.messageTable,{
    Player={
      {msg="OnVehicleRide_Start",func=function(playerId,rideFlag,vehicleId)
        if instance.IsVehicleTarget(vehicleId)then
          TppQuest.ReserveEnd(instance.questBlockIndex)
          TppQuest.SetNextQuestStep(instance.questBlockIndex,"Quest_Clear")
        end
      end}}
  })
  return instance
end
return this
