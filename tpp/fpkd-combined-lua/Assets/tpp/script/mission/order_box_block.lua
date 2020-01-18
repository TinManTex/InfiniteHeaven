local order_box_block = {}
local GetGameObjectId = GameObject.GetGameObjectId
local NULL_ID = GameObject.NULL_ID





function order_box_block.OnTrapMessage( trap, orderBoxTrapTable, isEnter )
	local orderBoxName = orderBoxTrapTable[trap]
	if not orderBoxName then
		return
	end
	if isEnter then
		Fox.Log("order_box_block.OnEnterTrap : orderBoxName = " .. orderBoxName )
		mvars.order_box_currentEnterOrderBoxName = orderBoxName
	else
		mvars.order_box_currentEnterOrderBoxName = nil
	end
end


function order_box_block.OnGroundMessage( gameObjectId, locatorUpper, locatorLower )
	mvars.order_box_onGroundCount = mvars.order_box_onGroundCount + 1
	if mvars.order_box_onGroundCount >= mvars.order_box_orderBoxCount then
		Fox.Log("EspionageBox is all on ground")
		mvars.order_box_isAllOnGround = true
	end
end


function order_box_block.ReserveMissionClearOnOrderBoxTrap( orderBoxName )
	if orderBoxName and svars.acceptMissionId > 0 then
		Fox.Log("order_box_block.ReserveMissionClearOnOrderBoxTrap. orderBoxName = " .. tostring(orderBoxName) )
		mvars.mis_orderBoxName = orderBoxName
		gvars.mis_orderBoxName = Fox.StrCode32( orderBoxName )
		TppMission.ReserveMissionClear{
			missionClearType = TppDefine.MISSION_CLEAR_TYPE.FREE_PLAY_ORDER_BOX_DEMO,
			nextMissionId = svars.acceptMissionId
		}
	end
end


function order_box_block.OnInitializeOrderBoxBlock( orderBoxScript, orderBoxTrapTable )

	local orderBoxScript = orderBoxScript
	local orderBoxTrapTable = orderBoxTrapTable
	local blockId = ScriptBlock.GetCurrentScriptBlockId()
	local state = ScriptBlock.GetScriptBlockState(blockId)
	TppScriptBlock.ActivateScriptBlockState( blockId )

	mvars.order_box_script = orderBoxScript
	mvars.orb_orderBoxMarkerEnabled = false
	
	mvars.order_box_gameObjectInfo = {}
	mvars.order_box_orderBoxCount = #mvars.order_box_script.orderBoxList
	mvars.order_box_onGroundCount = 0
	mvars.order_box_isAllOnGround = false

	mvars.order_box_script.Messages = function()
		return
		Tpp.StrCode32Table{
			Trap = {
				{
					msg = "Enter",
					func = function( trap, player )
						order_box_block.OnTrapMessage( trap, orderBoxTrapTable, true )
					end,
					option = { isExecMissionPrepare = true }
				},
				{
					msg = "Exit",
					func = function( trap, player )
						order_box_block.OnTrapMessage( trap, orderBoxTrapTable, false )
					end,
					option = { isExecMissionPrepare = true }
				},
			},
			GameObject = {
				{
					msg = "EspionageBoxGimmickOnGround",
					func = order_box_block.OnGroundMessage,
					option = { isExecMissionPrepare = true }
				}
			}
		}
	end
	
	local function MakeMessageExecTable()
		mvars.order_box_script.messageExecTable = Tpp.MakeMessageExecTable( mvars.order_box_script.Messages() )
	end
	mvars.order_box_script.OnReload = MakeMessageExecTable
	mvars.order_box_script.OnMessage = function(sender, messageId, arg0, arg1, arg2, arg3, strLogText )
		Tpp.DoMessage( mvars.order_box_script.messageExecTable,TppMission.CheckMessageOption, sender, messageId, arg0, arg1, arg2, arg3, strLogText)
	end
	MakeMessageExecTable()
end


function order_box_block.OnUpdateOrderBoxBlock( orderBoxScript, orderBoxList )
	local blockId = ScriptBlock.GetCurrentScriptBlockId()
	local state = ScriptBlock.GetScriptBlockState(blockId)
	if not ( state == ScriptBlock.SCRIPT_BLOCK_STATE_ACTIVE ) then
		return
	end
	
	if not mvars.orb_orderBoxMarkerEnabled then
		for index, orderBoxName in pairs(orderBoxList) do
			
			TppMarker.Enable(
				orderBoxName,	
				0,				
				nil,			
				"all",			
				0,				
				false,			
				false			
			)
			local gameObjectId = GameObject.GetGameObjectId(orderBoxName)
			if ( gameObjectId ~= GameObject.NULL_ID ) then
				TppUiCommand.RegisterIconUniqueInformation{ markerId = gameObjectId, langId = "marker_mission_start_point" }
			else
				Fox.Error("Cannot get gameObjectId. orderBoxName = " .. tostring(orderBoxName) )
			end
		end
		TppUI.ShowAnnounceLog( "updateMap" )
		
		mvars.orb_orderBoxMarkerEnabled = true
	end
	
	local orderBoxName = mvars.order_box_currentEnterOrderBoxName
	if orderBoxName and mvars.order_box_isAllOnGround and (not mvars.order_box_didResereveMissionClear) then
		if TppSequence.IsMissionPrepareFinished() then
			order_box_block.ReserveMissionClearOnOrderBoxTrap( orderBoxName )
			mvars.order_box_didResereveMissionClear = true
		end
	end
end


function order_box_block.OnTerminateOrderBoxBlock( order_box_block, orderBoxList )
	mvars.order_box_script = nil
	mvars.orb_orderBoxMarkerEnabled = nil
	mvars.order_box_didResereveMissionClear = nil
	mvars.order_box_gameObjectInfo = nil
	mvars.order_box_orderBoxCount = nil
	mvars.order_box_onGroundCount = nil
	mvars.order_box_isAllOnGround = nil
	local blockId = ScriptBlock.GetCurrentScriptBlockId()
	TppScriptBlock.FinalizeScriptBlockState( blockId )
	
	
	if Tpp.IsTypeTable(orderBoxList) then
		for index, orderBoxName in pairs(orderBoxList) do
		
			local gameObjectId = GameObject.GetGameObjectId(orderBoxName)
			if ( gameObjectId ~= GameObject.NULL_ID ) then
				TppUiCommand.UnRegisterIconUniqueInformation(gameObjectId)
			else
				Fox.Error("Cannot get gameObjectId. orderBoxName = " .. tostring(orderBoxName) )
			end
			
		end
	end
end

return order_box_block
