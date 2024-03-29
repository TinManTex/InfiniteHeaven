local FobUI = {}

local IsTypeTable = Tpp.IsTypeTable
local IsTypeNumber = Tpp.IsTypeNumber










FobUI.IS_ASCENDING_ORDER_DETECT_TYPE = {
  [68] = true,
  [70] = true,
  [71] = true,
  [73] = true,
  [77] = true,
  [97] = true,
}

FobUI.ASCENDING_ORDER_DETECT_TYPE_INITIAL_VALUE = {
  [68] = 99999999,
  [70] = 256,
  [71] = 99999999,
  [73] = 99999999,
  [77] = 99999999,
  [97] = 99999999,
}










function FobUI.UpdateEventTask( params )
  if not IsTypeTable(params) then
    Fox.Error("params must be table.")
    return
  end
  if not IsTypeTable(mvars.ui_sneakDetectTypeEventList) then
    Fox.Error("Not defined mvars.ui_sneakDetectTypeEventList.")
    return
  end
  if not IsTypeTable(mvars.ui_defenceDetectTypeEventList) then
    Fox.Error("Not defined mvars.ui_defenceDetectTypeEventList.")
    return
  end
  local detectType = params.detectType
  if not detectType then
    Fox.Error("params must set detectType.")
    return
  end
  local newValue = params.substitute
  local diff = params.diff
  if not ( IsTypeNumber(newValue) or IsTypeNumber(diff) ) then
    Fox.Error("Must set substitute or diff option by number value.")
    return
  end

  if not ( vars.fobSneakMode == FobMode.MODE_ACTUAL ) then

    return
  end


  local sneakEventList = mvars.ui_sneakDetectTypeEventList[detectType]
  if sneakEventList then
    FobUI.UpdateEventTaskValue( detectType, sneakEventList, diff, newValue, true )
  end

  local defenceEventList = mvars.ui_defenceDetectTypeEventList[detectType]

  if defenceEventList then
    FobUI.UpdateEventTaskValue( detectType, defenceEventList, diff, newValue, false )
  end


end

function FobUI.UpdateEventTaskValue( detectType, eventList, diff, newValue, isSneak )
  local currentValue = FobUI.GetCurrentEventTaskValue( eventList[1], isSneak )

  if diff then
    newValue = currentValue + diff
  end

  local needUpdate = false
  if FobUI.IS_ASCENDING_ORDER_DETECT_TYPE[detectType] then
    if newValue < currentValue then
      needUpdate = true
    end
  else
    if newValue > currentValue then
      needUpdate = true
    end
  end

  if needUpdate then
    for index, taskNo in ipairs(eventList) do

      FobUI.SetEventTaskValue( taskNo, isSneak, newValue )
    end
  end
end


function FobUI.UpdateEventTaskView( taskNo, isFobSneak )
  Fox.Log("FobUI.UpdateEventTaskView : taskNo = " .. tostring(taskNo) .. ", isFobSneak = " .. tostring(isFobSneak) )
  local isComplete = FobUI.IsCompleteEventTask( taskNo, isFobSneak )
  FobUI._EnableMissionTask( taskNo, isFobSneak, isComplete, ( FobUI.GetCurrentEventTaskDefine( taskNo, isFobSneak ) or {} ) )


  local lastCompletedCount =  FobUI.GetLocalEventTaskCompletedCount()
  mvars.ui_localFobEventTaskCompletedList[taskNo] = isComplete
  local currentCompletedCount =  FobUI.GetLocalEventTaskCompletedCount()
  if currentCompletedCount > lastCompletedCount then
    TppUI.ShowAnnounceLog( "task_complete", currentCompletedCount, mvars.ui_localFobEventTaskMax )
  end
end

function FobUI._EnableMissionTask( taskNo, isFobSneak, isComplete, eventTaskDefine )
  local currentValue = FobUI.GetCurrentEventTaskValue( taskNo, isFobSneak )
  TppUiCommand.EnableMissionTask{
    taskNo = taskNo, isComplete = isComplete,
    value1 = currentValue, value2 = eventTaskDefine.threshold
  }
end

function FobUI.GetLocalEventTaskCompletedCount()
  local completedCount = 0
  for i = 0, 7 do
    local isCompleted = mvars.ui_localFobEventTaskCompletedList[i]
    if isCompleted then
      completedCount = completedCount + 1
    end
  end
  return completedCount
end

function FobUI.IsCompleteEventTask( taskNo, isFobSneak )
  if not mvars.ui_eventTaskDefine then
    Fox.Error("FobUI.IsCompleteEventTask : Not defined event task")
    return
  end
  local eventTaskDefine
  local currentValue, threshold, detectType
  currentValue = FobUI.GetCurrentEventTaskValue( taskNo, isFobSneak )
  eventTaskDefine = FobUI.GetCurrentEventTaskDefine( taskNo, isFobSneak )
  if not eventTaskDefine then
    Fox.Error("FobUI.IsCompleteEventTask : must define eventTaskDefine. isFobSneak = " .. tostring(isFobSneak) )
    return
  end
  threshold = eventTaskDefine.threshold
  detectType = eventTaskDefine.detectType
  local isComplete = false
  if FobUI.IS_ASCENDING_ORDER_DETECT_TYPE[detectType] then
    if currentValue <= threshold then
      isComplete = true
    end
  else
    if currentValue >= threshold then
      isComplete = true
    end
  end

  return isComplete
end

function FobUI.GetCurrentEventTaskValue( taskNo, isFobSneak )
  if isFobSneak then
    return svars.sneakEventTaskValue[taskNo]
  else
    return svars.defenceEventTaskValue[taskNo]
  end
end

function FobUI.SetEventTaskValue( taskNo, isFobSneak, newValue )
  if isFobSneak then
    svars.sneakEventTaskValue[taskNo] = newValue
  else
    svars.defenceEventTaskValue[taskNo] = newValue
  end
end

function FobUI.InitializeAscendingOrderEventTaskValue( detectType, taskNo, isFobSneak )

  local initialValue = FobUI.ASCENDING_ORDER_DETECT_TYPE_INITIAL_VALUE[detectType]
  if not initialValue then
    return
  end

  local currentValue = FobUI.GetCurrentEventTaskValue( taskNo, isFobSneak )
  if ( currentValue == 0 ) then
    Fox.Log( "FobUI.InitializeAscendingOrderEventTaskValue : detectType = " .. tostring(detectType) .. ", initialValue = " .. tostring(initialValue) )
    FobUI.SetEventTaskValue( taskNo, isFobSneak, initialValue )
  end
end

function FobUI.GetCurrentEventTaskDefine( taskNo, isFobSneak )
  if isFobSneak then
    if mvars.ui_eventTaskDefine.sneak and mvars.ui_eventTaskDefine.sneak[taskNo] then
      return mvars.ui_eventTaskDefine.sneak[taskNo]
    end
  else
    if mvars.ui_eventTaskDefine.defence and mvars.ui_eventTaskDefine.defence[taskNo] then
      return mvars.ui_eventTaskDefine.defence[taskNo]
    end
  end
end

function FobUI.InitializeEventTask()
  if ( vars.fobSneakMode == FobMode.MODE_ACTUAL ) then
    FobUI._InitializeEventTask( TppNetworkUtil.GetFobEventTaskParam() )
  else

    FobUI._InitializeEventTask{
      sneak = {},
      defence = {},
    }
  end
end

function FobUI._InitializeEventTask( defineTable )
  local function InitializeDetectTypeEventList( taskNo, params, detectTypeEventList, isFobSneak )
    if not IsTypeTable(detectTypeEventList) then
      Fox.Error("detectTypeEventList must be table.")
      return
    end
    if ( taskNo < 0 ) or ( taskNo > 7 ) then
      Fox.Error("taskNo must set 0-7.")
      return
    end
    if ( params.detectType == nil ) or ( params.threshold == nil ) then
      Fox.Error("detectType and threshold must be defined.")
      return
    end
    detectTypeEventList[params.detectType] = detectTypeEventList[params.detectType] or {}
    table.insert( detectTypeEventList[params.detectType], taskNo )


    FobUI.InitializeAscendingOrderEventTaskValue( params.detectType, taskNo, isFobSneak )
  end

  Fox.Log("FobUI.InitializeEventTask")
  if ( Tpp.IsQARelease() or DEBUG ) then
    Tpp.DEBUG_DumpTable( defineTable )
  end

  mvars.ui_eventTaskDefine = defineTable
  mvars.ui_sneakDetectTypeEventList = {}
  for taskNo, params in pairs( mvars.ui_eventTaskDefine.sneak ) do
    InitializeDetectTypeEventList( taskNo, params, mvars.ui_sneakDetectTypeEventList, true )
  end

  mvars.ui_defenceDetectTypeEventList = {}
  for taskNo, params in pairs( mvars.ui_eventTaskDefine.defence ) do
    InitializeDetectTypeEventList( taskNo, params, mvars.ui_defenceDetectTypeEventList, false )
  end

  if TppServerManager.FobIsSneak() then
    mvars.ui_localFobEventTaskMax = #mvars.ui_eventTaskDefine.sneak + 1
    FobUI.InitializeEventTaskCompletedList( true )
  else
    mvars.ui_localFobEventTaskMax = #mvars.ui_eventTaskDefine.defence + 1
    FobUI.InitializeEventTaskCompletedList( false )
  end

  mvars.ui_isEventTaskInitialized = true
end

function FobUI.InitializeEventTaskCompletedList( isFobSneak )
  mvars.ui_localFobEventTaskCompletedList = {}
  for i = 0, 7 do
    local eventTaskDefine = FobUI.GetCurrentEventTaskDefine( i, isFobSneak )
    if eventTaskDefine then
      local isComplete = FobUI.IsCompleteEventTask( i, isFobSneak )

      mvars.ui_localFobEventTaskCompletedList[i] = isComplete

      FobUI._EnableMissionTask( i, isFobSneak, isComplete, eventTaskDefine )
    end
  end
end

function FobUI.InitializeDefenceEventTaskValue()
  Fox.Log("FobUI.InitializeDefenceEventTaskValue" )
  for i = 0, 7 do
    svars.defenceEventTaskValue[i] = 0
  end
end

FobUI.OnChangeSVars = function( varName, key )
  if not mvars.ui_isEventTaskInitialized then

    return
  end
  local isFobSneak = TppServerManager.FobIsSneak()

  if ( varName == "sneakEventTaskValue" )
    and isFobSneak then
    FobUI.UpdateEventTaskView( key, isFobSneak )
  end

  if ( varName == "defenceEventTaskValue" )
    and ( not isFobSneak ) then
    FobUI.UpdateEventTaskView( key, isFobSneak )
  end

  if ( varName == "tacticalActionPointClient" )
    and ( not isFobSneak ) then
    TppResult.CallCountAnnounce( "result_tactical_takedown", svars.tacticalActionPointClient, false )
    Tpp.IncrementPlayData( "rnk_TotalTacticalTakeDownCount" )
  end
end

if ( Tpp.IsQARelease() or DEBUG ) then

  function FobUI.DEBUG_EventTaskDefine( defineTable )
    if not IsTypeTable(defineTable) then
      Fox.Error("defineTable must be table.")
      return
    end
    if not IsTypeTable(defineTable.sneak) then
      Fox.Error("defineTable must be table.")
      return
    end
    if not IsTypeTable(defineTable.defence) then
      Fox.Error("defineTable must be table.")
      return
    end

    FobUI._InitializeEventTask( defineTable )
  end

  function FobUI.DEBUG_DetectTypeText( debugTextTable )
    if not mvars.qaDebug then
      return
    end

    mvars.qaDebug.debugEventTaskTextTable = debugTextTable
  end

end

return FobUI
