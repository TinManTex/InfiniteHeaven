local FobUI = {}

local IsTypeTable = Tpp.IsTypeTable
local IsTypeNumber = Tpp.IsTypeNumber










FobUI.IS_ASCENDING_ORDER_DETECT_TYPE = {
	[3] = false,
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
	for index, taskNo in ipairs(eventList) do
		
		if isSneak then
			svars.sneakEventTaskValue[taskNo] = newValue
		else
			svars.defenceEventTaskValue[taskNo] = newValue
		end
	end
end

function FobUI.UpdateEventTaskView( taskNo, isFobSneak )
	Fox.Log("FobUI.UpdateEventTaskView : taskNo = " .. tostring(taskNo) .. ", isFobSneak = " .. tostring(isFobSneak) )
	local isComplete = FobUI.IsCompleteEventTask( taskNo, isFobSneak )
	local currentValue = FobUI.GetCurrentEventTaskValue( taskNo, isFobSneak )
	local eventTaskDefine = FobUI.GetCurrentEventTaskDefine( taskNo, isFobSneak ) or {}
	TppUiCommand.EnableMissionTask{
		taskNo = taskNo, isComplete = isComplete,
		value1 = currentValue, value2 = eventTaskDefine.threshold
	}
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

	local function InitializeDetectTypeEventList( taskNo, params, detectTypeEventList )
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
	end

	mvars.ui_eventTaskDefine = defineTable
	mvars.ui_sneakDetectTypeEventList = {}
	for taskNo, params in pairs( mvars.ui_eventTaskDefine.sneak ) do
		InitializeDetectTypeEventList( taskNo, params, mvars.ui_sneakDetectTypeEventList )
	end

	mvars.ui_defenceDetectTypeEventList = {}
	for taskNo, params in pairs( mvars.ui_eventTaskDefine.defence ) do
		InitializeDetectTypeEventList( taskNo, params, mvars.ui_defenceDetectTypeEventList )
	end

	
	
	
end












function FobUI.DEBUG_DetectTypeText( debugTextTable )
	if not mvars.qaDebug then
		return
	end
	
	mvars.qaDebug.debugEventTaskTextTable = debugTextTable
end

end

return FobUI 