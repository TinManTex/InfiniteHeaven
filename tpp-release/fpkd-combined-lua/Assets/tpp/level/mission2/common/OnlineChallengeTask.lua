






local OnlineChallengeTask = {}


local IsTypeTable = Tpp.IsTypeTable
local IsTypeNumber = Tpp.IsTypeNumber
local ONLINE_CHALLENGE_TASK_INDEX_MAX = 23
local IsOnlineMode = Tpp.IsOnlineMode
local IsValidLocalVersion = Tpp.IsValidLocalOnlineChallengeTaskVersion
local GetOnlineChallengeTaskParam = TppNetworkUtil.GetOnlineChallengeTaskParam
local SetFlagCompletedOnlineTask = TppChallengeTask.SetFlagCompletedOnlineTask
local IsCompletedOnlineTask = TppChallengeTask.IsCompletedOnlineTask






OnlineChallengeTask.IS_ASCENDING_ORDER_DETECT_TYPE = {
	[1] = true,		
	[30] = true,	
}

OnlineChallengeTask.ASCENDING_ORDER_DETECT_TYPE_INITIAL_VALUE = {
	[1] = TppDefine.MISSION_CLEAR_RANK.E,		
	[30] = 99999999,	
}










function OnlineChallengeTask.Update( params )
	if not ( IsOnlineMode() and IsValidLocalVersion() ) then
		return
	end
	if not IsTypeTable(params) then
		Fox.Error("params must be table.")
		return
	end
	if not IsTypeTable(mvars.ui_onlineChallengeTaskDetectTypeTable) then
		
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
	local detectTypeList = mvars.ui_onlineChallengeTaskDetectTypeTable[vars.missionCode]
	if not detectTypeList then
		
		return
	end
	local challengeTaskList = detectTypeList[detectType]
	if challengeTaskList then
		OnlineChallengeTask.UpdateValue( detectType, challengeTaskList, diff, newValue )
	end
end

function OnlineChallengeTask.UpdateValue( detectType, challengeTaskList, diff, newValue )
	local currentValue = OnlineChallengeTask.GetCurrentTaskValue( challengeTaskList[1] )
	
	if diff then
		newValue = currentValue + diff
	end
	
	local needUpdate = false
	if OnlineChallengeTask.IS_ASCENDING_ORDER_DETECT_TYPE[detectType] then
		if newValue < currentValue then
			needUpdate = true
		end
	else
		if newValue > currentValue then
			needUpdate = true
		end
	end
	
	if needUpdate then
		for index, taskNo in ipairs(challengeTaskList) do
			
			OnlineChallengeTask.SetTaskValue( taskNo, newValue )
			local lastCompletedCount, currentCompletedCount = OnlineChallengeTask.UpdateIsComplete( taskNo )
			
			if currentCompletedCount > lastCompletedCount then
				TppChallengeTask.RequestUpdate( "ONLINE" )
			end
		end
	end
end


function OnlineChallengeTask.UpdateIsComplete( taskNo )
	Fox.Log("OnlineChallengeTask.UpdateIsComplete : taskNo = " .. tostring(taskNo)  )
	local isComplete = OnlineChallengeTask.IsCompleteTask( taskNo )
	local lastCompletedCount =  OnlineChallengeTask.GetLocalTaskCompletedCount()
	SetFlagCompletedOnlineTask( taskNo, isComplete )
	local currentCompletedCount =  OnlineChallengeTask.GetLocalTaskCompletedCount()
	return lastCompletedCount, currentCompletedCount
end

function OnlineChallengeTask.GetLocalTaskCompletedCount()
	local completedCount = 0
	for i = 0, ONLINE_CHALLENGE_TASK_INDEX_MAX do
		local isCompleted = IsCompletedOnlineTask(i)
		if isCompleted then
			completedCount = completedCount + 1
		end
	end
	return completedCount
end

function OnlineChallengeTask.IsCompleteTask( taskNo )
	local taskDefine
	local currentValue, threshold, detectType
	currentValue = OnlineChallengeTask.GetCurrentTaskValue( taskNo )
	taskDefine = OnlineChallengeTask.GetCurrentTaskDefine( taskNo )
	threshold = taskDefine.threshold
	detectType = taskDefine.detectType
	local isComplete = false
	if OnlineChallengeTask.IS_ASCENDING_ORDER_DETECT_TYPE[detectType] then
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

function OnlineChallengeTask.GetCurrentTaskValue( taskNo )
	return svars.onlineChallengeTaskValue[taskNo]
end

function OnlineChallengeTask.SetTaskValue( taskNo, newValue )
	svars.onlineChallengeTaskValue[taskNo] = newValue
end

function OnlineChallengeTask.InitializeAscendingOrderTaskValue( detectType, taskNo )
	
	local initialValue = OnlineChallengeTask.ASCENDING_ORDER_DETECT_TYPE_INITIAL_VALUE[detectType]
	if not initialValue then
		return 
	end
	local currentValue = OnlineChallengeTask.GetCurrentTaskValue( taskNo )
	if ( currentValue == 0 ) then
		Fox.Log( "OnlineChallengeTask.InitializeAscendingOrderTaskValue : detectType = " .. tostring(detectType) .. ", initialValue = " .. tostring(initialValue) )
		OnlineChallengeTask.SetTaskValue( taskNo, initialValue )
	end
end

function OnlineChallengeTask.GetCurrentTaskDefine( taskNo )
	if mvars.ui_onlineChallengeTaskDefine and mvars.ui_onlineChallengeTaskDefine[taskNo] then
		return mvars.ui_onlineChallengeTaskDefine[taskNo]
	end
end




function OnlineChallengeTask.InitializeTaskDefine()
	if ( IsOnlineMode() and IsValidLocalVersion() ) then
		OnlineChallengeTask._InitializeTaskDefine( TppNetworkUtil.GetOnlineChallengeTaskParam().taskList )
	end
end

function OnlineChallengeTask._InitializeTaskDefine( defineTable )
	local function InitializeDetectTypeList( taskNo, params, detectTypeList )
		if not IsTypeTable(detectTypeList) then
			Fox.HungUp("detectTypeList must be table.")
			return
		end
		if ( taskNo < 0 ) or ( taskNo > ONLINE_CHALLENGE_TASK_INDEX_MAX ) then
			Fox.Error("taskNo must set 0-23.")
			return
		end
		if ( params.detectType == nil ) or ( params.threshold == nil ) then
			Fox.Error("detectType and threshold must be defined.")
			return
		end
		detectTypeList[params.detectType] = detectTypeList[params.detectType] or {}
		table.insert( detectTypeList[params.detectType], taskNo )
		
		
		OnlineChallengeTask.InitializeAscendingOrderTaskValue( params.detectType, taskNo )
	end

	Fox.Log("OnlineChallengeTask.InitializeTask")

	if ( Tpp.IsQARelease() or DEBUG ) then
		mvars.qaDebug.debugOnlineChallengeTaskMissionList = {}
	end

	mvars.ui_onlineChallengeTaskDefine = defineTable
	mvars.ui_onlineChallengeTaskDetectTypeTable = {}
	for taskNo, params in pairs( mvars.ui_onlineChallengeTaskDefine ) do
		local missionCode = params.missionCode
		if missionCode then
			if not mvars.ui_onlineChallengeTaskDetectTypeTable[missionCode] then
				mvars.ui_onlineChallengeTaskDetectTypeTable[missionCode] = {}

				if ( Tpp.IsQARelease() or DEBUG ) then
					table.insert( mvars.qaDebug.debugOnlineChallengeTaskMissionList, missionCode )
				end
			end
			InitializeDetectTypeList( taskNo, params, mvars.ui_onlineChallengeTaskDetectTypeTable[missionCode] )
		else
			Fox.Error("Online challgenge task define must has missionCode parameter.")
		end
	end

	mvars.ui_isOnlineChallengeTaskInitialized = true
end

OnlineChallengeTask.Init = function( subScripts )
	OnlineChallengeTask.messageExecTable = Tpp.MakeMessageExecTable( OnlineChallengeTask.Messages() )
	OnlineChallengeTask.InitializeTaskDefine()

	
	if ( Tpp.IsQARelease() or DEBUG ) then
		OnlineChallengeTask.DEBUG_DetectTypeText{
			[1] = "Clear Rank :",							
			[2] = "Recover : Enemy",						
			[3] = "Recover : Hostage",						
			[4] = "Recover : LightVehicle",					
			[5] = "Recover : Truck",						
			[6] = "Recover : LAV",							
			[7] = "Recover : Tank",							
			[8] = "Recover : EnemyWalkerGear",				
			[9] = "NeutralizedCount: Enemy",				
			[10] = "Enemy-Neutralized :HundGun",			
			[11] = "Enemy-Neutralized :SMG",				
			[12] = "Enemy-Neutralized :ShotGun",			
			[13] = "Enemy-Neutralized :Assult",				
			[14] = "Enemy-Neutralized :MG",					
			[15] = "Enemy-Neutralized :Sniper",				
			[16] = "Enemy-Neutralized :Missile",			
			[17] = "Enemy-Neutralized :Throwing",			
			[18] = "Enemy-Neutralized :Placed",				
			[19] = "Enemy-Neutralized :HoldUp",				
			[20] = "Enemy-Neutralized :CQC",				
			[21] = "Enemy-Neutralized :CqcKnife",			
			[22] = "Broken : LightVehicle",					
			[23] = "Broken : Truck",						
			[24] = "Broken : LAV",							
			[25] = "Broken : Tank",							
			[26] = "Broken : EnemyWalkerGear",				
			[27] = "Broken : EnemyHelicopter",				
			[28] = "Headshot distance",						
			[29] = "Headshot count",						
			[30] = "Clear Time",							
			[31] = "TaticalTakeDown count",					
			[32] = "Annihilate : Base",						
			[33] = "Annihilate : Out-post"	,				
			[34] = "CompleteMissionTask : TaskNo.0",		
			[35] = "CompleteMissionTask : TaskNo.1",		
			[36] = "CompleteMissionTask : TaskNo.2",		
			[37] = "CompleteMissionTask : TaskNo.3",		
			[38] = "CompleteMissionTask : TaskNo.4",		
			[39] = "CompleteMissionTask : TaskNo.5",		
			[40] = "CompleteMissionTask : TaskNo.6",		
			[41] = "CompleteMissionTask : TaskNo.7",		
			[42] = "MissionClear : NoAlert",				
			[43] = "MissionClear : NoKill-NoAlert",			
			[44] = "MissionClear : PerfectStealthNoKill",	
			[45] = "Enemy-Neutralized :Grenader",			
		}
	end

end

OnlineChallengeTask.OnReload = function( subScripts )
	OnlineChallengeTask.messageExecTable = Tpp.MakeMessageExecTable( OnlineChallengeTask.Messages() )
end

OnlineChallengeTask.OnMessage = function( sender, messageId, arg0, arg1, arg2, arg3, strLogText )
	Tpp.DoMessage( OnlineChallengeTask.messageExecTable, TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText )
end

OnlineChallengeTask.DeclareSVars = function()
	return {
		{ name = "onlineChallengeTaskValue",	arraySize = 24, type = TppScriptVars.TYPE_INT32, value = 0,	save = true,  sync = false,	wait = false, category = TppScriptVars.CATEGORY_MISSION },
		nil
	}
end






local STRCODE_START = Fox.StrCode32("Start")

OnlineChallengeTask.Messages = function()
	return
	Tpp.StrCode32Table{
		GameObject = {
			{
				
				
				msg = "NeutralizeFob", func = OnlineChallengeTask.OnNeutralize,
			},
			{	
				msg = "HeadShotDistance",
				func = function( gameObjectId, attackId, attackerGameObjectId, distance )
					if Tpp.IsSoldier( gameObjectId ) then	
						OnlineChallengeTask.Update{ detectType = 28, substitute = distance, }	
					end
				end
			},
			{
				msg = "VehicleBroken",
				func = function( gameObjectId, state )
					if ( state == STRCODE_START ) then
						local detectTypeTable = {
							[Vehicle.type.EASTERN_LIGHT_VEHICLE] = 22,
							[Vehicle.type.EASTERN_TRACKED_TANK] = 25,
							[Vehicle.type.EASTERN_TRUCK] = 23,
							[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE] = 24,
							[Vehicle.type.WESTERN_LIGHT_VEHICLE] = 22,
							[Vehicle.type.WESTERN_TRACKED_TANK] = 25,
							[Vehicle.type.WESTERN_TRUCK] = 23,
							[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE] = 24,
						}
						OnlineChallengeTask.UpdateByVehicleDetectTypeTable( gameObjectId, detectTypeTable )
					end
				end,
			},
			{
				msg = "WalkerGearBroken",
				func = function (gameObjectId , state)
					if ( state == STRCODE_START )
					and Tpp.IsEnemyWalkerGear( gameObjectId ) then
						OnlineChallengeTask.Update{ detectType = 26, diff = 1 }
					end
				end
			},
		},
	}
end

OnlineChallengeTask.NEUTRALIZE_CAUSE_TO_DETECT_TYPE = {
	[NeutralizeFobCause.HANDGUN]			= 10,
	[NeutralizeFobCause.SUBMACHINE_GUN]		= 11,
	[NeutralizeFobCause.SHOTGUN]			= 12,
	[NeutralizeFobCause.ASSAULT_RIFLE]		= 13,
	[NeutralizeFobCause.MACHINE_GUN]		= 14,
	[NeutralizeFobCause.SNIPER_RIFLE]		= 15,
	[NeutralizeFobCause.ANTIMATERIAL_RIFLE]	= 15,
	[NeutralizeFobCause.MISSILE]			= 16,
	[NeutralizeFobCause.THROWING]			= 17,
	[NeutralizeFobCause.PLACED]				= 18,
	[NeutralizeFobCause.CQC]		 		= 20,
	[NeutralizeFobCause.CQC_KNIFE] 			= 21,
	[NeutralizeFobCause.GRENADER]			= 45,
}


OnlineChallengeTask.NPC_NEUTRALIZE_CAUSE = {
	[NeutralizeFobCause.ASSIST] = true,
	[NeutralizeFobCause.QUIET] = true,
	[NeutralizeFobCause.D_DOG] = true,
	[NeutralizeFobCause.D_HORSE] = true,
	[NeutralizeFobCause.VEHICLE] = true,
	[NeutralizeFobCause.HELI] = true,
	[NeutralizeFobCause.D_WALKER_GEAR] = true,
	
	
	
	
}

function OnlineChallengeTask.OnNeutralize( neutralizedGameObjectId, attackerGameObjectId, neutralizeType, neutralizeCause )
	

	local isGeneralNeutralize = false
	if OnlineChallengeTask.NPC_NEUTRALIZE_CAUSE[neutralizeCause] then
		isGeneralNeutralize = true
	
	elseif ( neutralizeType == NeutralizeType.HOLDUP ) then
		isGeneralNeutralize = true
		OnlineChallengeTask.Update{ detectType = 19, diff = 1 }	
	elseif Tpp.IsLocalPlayer(attackerGameObjectId) then
		isGeneralNeutralize = true
		local detectType = OnlineChallengeTask.NEUTRALIZE_CAUSE_TO_DETECT_TYPE[neutralizeCause]
		if detectType then
			OnlineChallengeTask.Update{ detectType = detectType, diff = 1 }
		end
	
	end

	if isGeneralNeutralize then
		OnlineChallengeTask.Update{ detectType = 9, diff = 1 }		
	end
end

function OnlineChallengeTask.DecideTaskFromResult()
	
	if svars.bestRank ~= TppDefine.MISSION_CLEAR_RANK.NOT_DEFINED then
		
		OnlineChallengeTask.Update{ detectType = 1, substitute = svars.bestRank }
	end
	
	OnlineChallengeTask.Update{ detectType = 30, substitute = ( svars.scoreTime / 1000 ) }
	
	if ( svars.alertCount == 0 ) then
		OnlineChallengeTask.Update{ detectType = 42, diff = 1 }
	end
	
	if ( svars.alertCount == 0 ) and ( svars.bestScoreKillScore > 0 )then
		OnlineChallengeTask.Update{ detectType = 43, diff = 1 }
	end
	
	if ( svars.bestScorePerfectStealthNoKillBonusScore > 0 ) then
		OnlineChallengeTask.Update{ detectType = 44, diff = 1 }
	end
end

function OnlineChallengeTask.UpdateByVehicleDetectTypeTable( gameObjectId, detectTypeTable )
	
	if ( gameObjectId == GameObject.GetGameObjectIdByIndex( "TppVehicle2", 0 ) ) then
		Fox.Log("OnlineChallengeTask.UpdateByVehicleDetectTypeTable : This vehicle is buddy.")
		return
	end
	local vehicleType = GameObject.SendCommand( gameObjectId, { id="GetVehicleType", } )
	local detectType = detectTypeTable[vehicleType]
	if detectType then
		OnlineChallengeTask.Update{ detectType = detectType, diff = 1 }
	end
end

function OnlineChallengeTask.UpdateOnFultonVehicle( gameObjectId )
	local detectTypeTable = {
		[Vehicle.type.EASTERN_LIGHT_VEHICLE] = 4,
		[Vehicle.type.EASTERN_TRACKED_TANK] = 7,
		[Vehicle.type.EASTERN_TRUCK] = 5,
		[Vehicle.type.EASTERN_WHEELED_ARMORED_VEHICLE] = 6,
		[Vehicle.type.WESTERN_LIGHT_VEHICLE] = 4,
		[Vehicle.type.WESTERN_TRACKED_TANK] = 7,
		[Vehicle.type.WESTERN_TRUCK] = 5,
		[Vehicle.type.WESTERN_WHEELED_ARMORED_VEHICLE] = 6,
	}
	OnlineChallengeTask.UpdateByVehicleDetectTypeTable( gameObjectId, detectTypeTable )
end


if ( Tpp.IsQARelease() or DEBUG ) then















function OnlineChallengeTask.DEBUG_TaskDefine( defineTable )
	if not IsTypeTable(defineTable) then
		Fox.Error("defineTable must be table.")
		return
	end
	TppVarInit.InitializeOnlineChallengeTaskLocalCompletedVars()
	OnlineChallengeTask._InitializeTaskDefine( defineTable )
end












function OnlineChallengeTask.DEBUG_DetectTypeText( debugTextTable )
	if not mvars.qaDebug then
		return
	end

	mvars.qaDebug.debugOnlineChallengeTaskTextTable = debugTextTable
end

end

return OnlineChallengeTask