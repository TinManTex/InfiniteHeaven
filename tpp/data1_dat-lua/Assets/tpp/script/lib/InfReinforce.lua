-- DOBUILD: 0 -- OFF WIP DEBUGWIP
--InfReinforce.lua
local this={}
--localopt
local NULL_ID=GameObject.NULL_ID
local GetGameObjectId=GameObject.GetGameObjectId
local GetTypeIndex=GameObject.GetTypeIndex
local SendCommand=GameObject.SendCommand
local StrCode32=Fox.StrCode32
local TimerStart=GkEventTimerManager.Start

--reinforce stuff
this.reinforceInfo={
  cpId=nil,
  request=0,
  count=0,
}

function this.OnRequestLoadReinforce(cpId)
  InfLog.DebugPrint"OnRequestLoadReinforce"--DEBUGWIP
  if this.reinforceInfo.cpId~=cpId then
    this.reinforceInfo.cpId=cpId
    this.reinforceInfo.count=0
    this.reinforceInfo.request=0
  end
  this.reinforceInfo.request=this.reinforceInfo.request+1
end
function this.OnRequestAppearReinforce(cpId)
  InfLog.DebugPrint"OnRequestAppearReinforce"--DEBUGWIP
  this.reinforceInfo.count=this.reinforceInfo.count+1
end
function this.OnCancelReinforce(cpId)
  InfLog.DebugPrint"OnCancelReinforce"--DEBUGWIP
end

function this.OnHeliLostControlReinforce(gameId,state,attackerId)--DOC: Helicopter shiz.txt
  InfLog.DebugPrint"InfReinforce.OnHeliLostControlReinforce"--DEBUGWIP

  if true then return end--DEBUGWIP

  local gameObjectType=GameObject.GetTypeIndex(gameId)
  if gameObjectType~=TppGameObject.GAME_OBJECT_TYPE_ENEMY_HELI then
    return
  end

  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
  if heliId~=gameId then
    return
  end

  if not mvars.reinforce_activated then
    --InfLog.DebugPrint"OnHeliLostControlReinforce is reinforce heli but not reinforce_activated"
    return
  end

  if (state==StrCode32("Start")) then
  elseif (state==StrCode32("End")) then
    --InfLog.DebugPrint"OnHeliLostControlReinforce is reinforce heli"
    --this.CheckAndFinishReinforce()

    if TppReinforceBlock._HasHeli() then--tex reinforcetype is heli
      --InfLog.DebugPrint"start timer FinishReinforce"
      local cpId=mvars.reinforce_reinforceCpId
      --TppReinforceBlock.FinishReinforce(cpId)
      TimerStart("Timer_FinishReinforce",2)--tex heli doesn't like it if reinforceblock is deactivated, even though I can't see it acually deactivating heli in finish.
    end
  end
end

function this.OnVehicleBrokenReinforce(vehicleId,state)--ASSUMPTION: Run after TppEnemy._OnVehicleBroken
  InfLog.DebugPrint"InfReinforce.OnVehicleBroken"--DEBUGWIP

  if true then return end--DEBUG

  --local gameObjectType=GameObject.GetTypeIndex(vehicleId)
  local reinforceId=GetGameObjectId(TppReinforceBlock.REINFORCE_VEHICLE_NAME)
  if reinforceId~=vehicleId then
    return
  end

  if not mvars.reinforce_activated then
    --InfLog.DebugPrint"OnVehicleBrokenReinforce is reinforce vehicle but not reinforce_activated"
    return
  end

  if (state==StrCode32("Start")) then
  elseif (state==StrCode32("End")) then
    --InfLog.DebugPrint"OnVehicleBrokenReinforce is reinforce vehicle"
    --this.CheckAndFinishReinforce()
    if TppReinforceBlock._HasVehicle() then--tex reinforcetype is heli
      --InfLog.DebugPrint"Do timer FinishReinforce"
      local cpId=mvars.reinforce_reinforceCpId
      --TppReinforceBlock.FinishReinforce(cpId)
      TimerStart("Timer_FinishReinforce",2)--tex heli doesn't like it if reinforceblock is deactivated, even though I can't see it acually deactivating heli in finish.
    end
  end
end

function this.OnFulton(vehicleId)
  InfLog.DebugPrint"InfReinforce.OnFulton"--DEBUGWIP

end

function this.OnTimer_FinishReinforce()
  InfLog.DebugPrint"InfReinforce.OnTimer_FinishReinforce FinishReinforce"--DEBUGWIP
  local cpId=mvars.reinforce_reinforceCpId
  TppReinforceBlock.FinishReinforce(cpId)
  TppReinforceBlock.UnloadReinforceBlock(cpId)
end
--WIP/UNUSED
function this.CheckAndFinishReinforce()
  if not mvars.reinforce_activated then
    return false
  end
  if this.CheckReinforceDeactivate() then
    --InfLog.DebugPrint"Do FinishReinforce"
    local cpId=mvars.reinforce_reinforceCpId
    TppReinforceBlock.FinishReinforce(cpId)
  end
end
--WIP/UNUSED
function this.CheckReinforceDeactivate()
  --if not mvars.reinforce_activated then
  --   return false
  -- end
  --mvars.reinforce_reinforceType
  local hasVehicle=TppReinforceBlock._HasVehicle()
  local hasSoldier=TppReinforceBlock._HasSoldier()
  local hasHeli=TppReinforceBlock._HasHeli()
  --local cp=mvars.ene_cpList[mvars.reinforce_reinforceCpId]
  local soldiersDead=false
  local vehicleBroken=false
  local heliBroken=false
  local vehicleAlive
  local vehicleReal
  local heliAlive
  local heliReal

  InfLog.DebugPrint("hasVehicle: "..tostring(hasVehicle).." hasHeli: "..tostring(hasHeli).." hasSoldier: "..tostring(hasSoldier))

  local deadCount=0
  for n,soldierName in ipairs(TppReinforceBlock.REINFORCE_SOLDIER_NAMES)do
    local soldierId=GetGameObjectId("TppSoldier2",soldierName)
    if soldierId~=nil and soldierId~=NULL_ID then
      local NPC_STATE_DISABLE=TppGameObject.NPC_STATE_DISABLE
      local lifeStatus=SendCommand(soldierId,{id="GetLifeStatus"})
      local status=SendCommand(soldierId,{id="GetStatus"})
      if(status~=NPC_STATE_DISABLE)and(lifeStatus~=TppGameObject.NPC_LIFE_STATE_DEAD)then
        deadCount=deadCount+1
      end
    end
  end
  if deadCount==#TppReinforceBlock.REINFORCE_SOLDIER_NAMES then
    soldiersDead=true
  end

  InfLog.DebugPrint("soldiersEliminated:"..tostring(soldiersDead))

  local vehicleId=GetGameObjectId("TppVehicle2",TppReinforceBlock.REINFORCE_VEHICLE_NAME)
  local driverId=GetGameObjectId("TppSoldier2",TppReinforceBlock.REINFORCE_DRIVER_SOLDIER_NAME)

  if vehicleId~=NULL_ID then
    --    if TppEnemy.IsVehicleBroken(vehicleId)then--tex only initied for quest eliminate targets
    --      vehicleEliminated=true
    --    end--
    --      if TppEnemy.IsRecovered(vehicleId)then
    --      vehicleEliminated=true
    --    end
    vehicleBroken=SendCommand(vehicleId,{id="IsBroken"})

    vehicleAlive=SendCommand(vehicleId,{id="IsAlive"})
    vehicleReal=SendCommand(vehicleId,{id="IsReal"})
    InfLog.DebugPrint("vehicleBroken:"..tostring(vehicleBroken).." vehicleAlive:"..tostring(vehicleAlive))--.." vehicleReal:"..tostring(vehicleReal))
  end


  local heliId=GetGameObjectId(TppReinforceBlock.REINFORCE_HELI_NAME)
  if heliId~=NULL_ID then
    heliBroken=SendCommand(heliId,{id="IsBroken"})
    heliAlive=SendCommand(heliId,{id="IsAlive"})
    --heliReal=SendCommand(heliId,{id="IsReal"})
    InfLog.DebugPrint("heliBroken:"..tostring(heliBroken).." heliAlive:"..tostring(heliAlive))--.." heliReal:"..tostring(heliReal))

    --    local aiState = SendCommand(heliId,{id="GetAiState"})--tex CULL only support heli aparently, returns strcode32 ""
    --    --InfLog.DebugPrint("heliAiState:"..tostring(aiState))
    --    if aiState==StrCode32("WaitPoint") then
    --      InfLog.DebugPrint("heliAiState: WaitPoint")
    --    elseif aiState==StrCode32("Descent") then
    --      InfLog.DebugPrint("heliAiState: Descent")
    --    elseif aiState==StrCode32("Landing") then
    --      InfLog.DebugPrint("heliAiState: Landing")
    --    elseif aiState==StrCode32("PullOut") then
    --      InfLog.DebugPrint("heliAiState: PullOut")
    --    elseif aiState==StrCode32("") then
    --    InfLog.DebugPrint("heliAiState: errr")
    --    else
    --      InfLog.DebugPrint("heliAiState: unknown")
    --    end

  end

  if hasHeli and heliBroken then
    return true
  end
end

return this
