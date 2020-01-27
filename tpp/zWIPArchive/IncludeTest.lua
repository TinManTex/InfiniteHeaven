function this.CheckQuestAllTarget(questType,messageId,gameId,param4,param5)
  local clearType=TppDefine.QUEST_CLEAR_TYPE.NONE
  local _param4=param4 or false
  local _param5=param5 or false
  local RENAMEinQuestTargetList=false
  local totalTargets=0
  local fultonedCount=0
  local failedFultonCount=0
  local killedOrDestroyedCount=0
  local vanishedCount=0
  local inHeliCount=0
  local RENAMEcountIncreased=true
  local RENAMEsomeBool=false
  local currentQuestName=TppQuest.GetCurrentQuestName()
  if TppQuest.IsEnd(currentQuestName)then
    return clearType
  end
  if mvars.ene_questTargetList[gameId]then
    local targetInfo=mvars.ene_questTargetList[gameId]
    if targetInfo.messageId~="None"and targetInfo.isTarget==true then
      RENAMEsomeBool=true
    elseif targetInfo.isTarget==false then
      RENAMEsomeBool=true
    end
    targetInfo.messageId=messageId or"None"
    RENAMEinQuestTargetList=true
  end
  if(_param4==false and _param5==false)and RENAMEinQuestTargetList==false then
    return clearType
  end
  for targetGameId,targetInfo in pairs(mvars.ene_questTargetList)do
    local RENAMEsomebool2=false
    local isTarget=targetInfo.isTarget or false
    if _param4==true then
      if Tpp.IsSoldier(targetGameId)or Tpp.IsHostage(targetGameId)then
        if this.CheckQuestDistance(targetGameId)then
          targetInfo.messageId="Fulton"fultonedCount=fultonedCount+1
          RENAMEsomebool2=false
          RENAMEcountIncreased=true
        end
      end
    end
    if isTarget==true then
      if RENAMEsomebool2==false then
        local targetMessageId=targetInfo.messageId
        if targetMessageId~="None"then
          if targetMessageId=="Fulton"then
            fultonedCount=fultonedCount+1
            RENAMEcountIncreased=true
          elseif targetMessageId=="InHelicopter"then
            inHeliCount=inHeliCount+1
            RENAMEcountIncreased=true
          elseif targetMessageId=="FultonFailed"then
            failedFultonCount=failedFultonCount+1
            RENAMEcountIncreased=true
          elseif(targetMessageId=="Dead"or targetMessageId=="VehicleBroken")or targetMessageId=="LostControl"then
            killedOrDestroyedCount=killedOrDestroyedCount+1
            RENAMEcountIncreased=true
          elseif targetMessageId=="Vanished"then
            vanishedCount=vanishedCount+1
            RENAMEcountIncreased=true
          end
        end
        if _param4==true then
          RENAMEcountIncreased=false
        end
      end
      totalTargets=totalTargets+1
    end
  end
  if RENAMEsomeBool==true then
    RENAMEcountIncreased=false
  end
  if totalTargets>0 then
    if questType==TppDefine.QUEST_TYPE.RECOVERED then
      if fultonedCount+inHeliCount>=totalTargets then
        clearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif failedFultonCount>0 or killedOrDestroyedCount>0 then
        clearType=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      elseif fultonedCount+inHeliCount>0 then
        if RENAMEcountIncreased==true then
          clearType=TppDefine.QUEST_CLEAR_TYPE.UPDATE
        end
      end
    elseif questType==TppDefine.QUEST_TYPE.ELIMINATE then
      if((fultonedCount+failedFultonCount)+killedOrDestroyedCount)+inHeliCount>=totalTargets then
        clearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif((fultonedCount+failedFultonCount)+killedOrDestroyedCount)+inHeliCount>0 then
        if RENAMEcountIncreased==true then
          clearType=TppDefine.QUEST_CLEAR_TYPE.UPDATE
        end
      end
    elseif questType==TppDefine.QUEST_TYPE.MSF_RECOVERED then
      if fultonedCount>=totalTargets or inHeliCount>=totalTargets then
        clearType=TppDefine.QUEST_CLEAR_TYPE.CLEAR
      elseif(failedFultonCount>0 or killedOrDestroyedCount>0)or vanishedCount>0 then
        clearType=TppDefine.QUEST_CLEAR_TYPE.FAILURE
      end
    end
  end
  if _param5==true then
    if clearType==TppDefine.QUEST_CLEAR_TYPE.NONE or clearType==TppDefine.QUEST_CLEAR_TYPE.UPDATE then
      clearType=TppDefine.QUEST_CLEAR_TYPE.NONE
    end
  end
  return clearType
end
