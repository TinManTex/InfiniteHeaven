ActionTppStepOn = {


WakeUpStates = {
	 "stateStandStepOnToMove",
	 "stateSquatStepOnToMove",
	 "stateStandStepOn",
	 "stateSquatStepOn",
	 "stateBehindStandStepOn",
	 "stateBehindSquatStepOn",
},




OnWakeUp = function( plugin )

	
	
	
	local chara = plugin:GetCharacter()
	

	local plgAdjust = chara:FindPlugin( "ChHumanAdjustPlugin" )
	if not Entity.IsNull( plgAdjust )then
		plgAdjust:LegsIkOff()
	end
end,





OnLoad = function( plugin )

end,




OnSleep = function( plugin )

	
	local chara = plugin:GetCharacter()
	local plgAdjust = chara:FindPlugin( "ChHumanAdjustPlugin" )
	if not Entity.IsNull( plgAdjust )then
		plgAdjust:LegsIkOn()
	end

	local plgBody = plugin:GetBodyPlugin()
	local control = plgBody:GetControl()
	control:SetSize( 0.4, 0.8 )

end,




OnPreAnim = function( plugin )
	

	local plgBody = plugin:GetBodyPlugin()

	if plgBody:CompAnimGraphCurrentTag( "Lower", "StepOn" ) then

		
		if plgBody:CompAnimGraphCurrentTag( "Lower", "Carry" ) then
			plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateRouteRelaxedIdle" } )

		elseif plgBody:CompAnimGraphCurrentTag( "Lower", "Stand" ) then
			if plgBody:CompAnimGraphCurrentTag( "Lower", "Run" ) then
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateStandRun" } )
			elseif plgBody:CompAnimGraphCurrentTag( "Lower", "Walk" ) then
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateStandWalk" } )
			else
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateRouteRelaxedIdle" } )
			end
		elseif plgBody:CompAnimGraphCurrentTag( "Lower", "Squat" ) then
			if plgBody:CompAnimGraphCurrentTag( "Lower", "Run" ) then
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSquatRun" } )
			elseif plgBody:CompAnimGraphCurrentTag( "Lower", "Walk" ) then
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSquatWalk" } )
			else
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSquatIdle" } )
			end
		end
	end

	









	if plgBody:IsLeaveAnimGraphNode( "Lower" ) then
		if plgBody:CompAnimGraphPreviousTag( "Lower", "StepOn" ) then
			
			plugin:SleepRequest()
		end
	end	
	
	
end,




OnReceiveMessage  = function( plugin, messages )
	
	
	local plgBody	= plugin:GetBodyPlugin()

	if not plgBody:CompAnimGraphCurrentTag( "Lower", "Walk" ) and
		not plgBody:CompAnimGraphCurrentTag( "Lower", "Run" ) and
		not plgBody:CompAnimGraphCurrentTag( "Lower", "Dash" ) and
		not plgBody:CompAnimGraphCurrentTag( "Lower", "Behind" ) and
		not plgBody:CompAnimGraphCurrentTag( "Lower", "Idle" ) then
		
		return
	end

	
	local mesPrio = {}
		mesPrio["PrioMax"]	= 5
		mesPrio["EntryReq"]	= mesPrio["PrioMax"]
		mesPrio["LeaveReq"]	= 2
		mesPrio["MoveReq"]	= 1

	
	local curPrio = 0	
	for i, message in ipairs( messages.array ) do

		

		
		if curPrio >= mesPrio["PrioMax"] then
			local chara = plugin:GetCharacter()
			Ch.Log( chara,"curPrio is bigger than PrioMax")
			break
		end

		local message = messages.array[i]

		
		if message:IsKindOf( TppStepOnRequest ) then
			
			local chara = plugin:GetCharacter()
			local plgBody = chara:FindPlugin( "ChBodyPlugin" )
			local charaObj = chara:GetCharacterObject()
			local blendControlValue = charaObj:GetBlendControlValue()

			
			local stepOnToMoveHeightMax = plugin.stepOnToMoveHeightMax
			local stepOnHeightMin = plugin.stepOnHeightMin
			local stepOnHeightMax = plugin.stepOnHeightMax

			
			
			local height = message:GetHeight()
			
			

			local desc = chara:GetCharacterDesc()
			local descStatus = desc.state_status

			if height >= stepOnHeightMin and height <= stepOnToMoveHeightMax then

				local rate = ( height - stepOnHeightMin ) / ( stepOnToMoveHeightMax - stepOnHeightMin )

				if rate > 1 then
					rate = 1
				end

				if plgBody:CompAnimGraphCurrentTag( "Lower", "Run" ) or plgBody:CompAnimGraphCurrentTag( "Lower", "Move" ) then
					
					blendControlValue.startSelectString = "Run"
				else
					
					blendControlValue.startSelectString = "Walk"
				end

				
				blendControlValue.startBlendRate = rate
				
				if descStatus:Check( "Stand" ) then
					plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateStandStepOnToMove" } )
				elseif descStatus:Check( "Squat" ) then
					
					plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSquatStepOnToMove" } )
				end
				curPrio = mesPrio["EntryReq"]

			
			elseif height > stepOnToMoveHeightMax and height <= stepOnHeightMax then
				local rate = 0	

				
				if height < stepOnToMoveHeightMax then
					blendControlValue.startSelectIndex = 0
					rate = 0
				elseif height < 1.5 then
					blendControlValue.startSelectIndex = 0
					rate = ( height - stepOnToMoveHeightMax ) * 1.333
				elseif height >= 1.5 and height < 1.51 then
					blendControlValue.startSelectIndex = 0
					rate = 1
				
				elseif height < stepOnHeightMax then
					blendControlValue.startSelectIndex = 1
					rate = ( height - 1.5 ) * 1.333
				else
					blendControlValue.startSelectIndex = 1
					rate = 1
				end

				
				
				blendControlValue.startBlendRate = rate

				
				local charaPos = plugin.startPos	
				local checkPos = plugin.checkPos			

				local charaToCheck = Vector3( checkPos:GetX() - charaPos:GetX(), 0, checkPos:GetZ() - charaPos:GetZ() )
				local charaToCheckLength = charaToCheck:GetLength()

				local blendRate = charaToCheckLength - 0.9	

				













				

				
				blendControlValue.commonBlendRate = foxmath.Clamp( blendRate, 0.0, 1.0 )

				if plgBody:CompAnimGraphCurrentTag( "Lower", "Behind" ) then
					
					if descStatus:Check( "Stand" ) then
						
						plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateBehindStandStepOn" } )
					elseif descStatus:Check( "Squat" ) then
						
						plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateBehindSquatStepOn" } )
					end
				else
					if descStatus:Check( "Stand" ) then
						
						plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateStandStepOn" } )
					elseif descStatus:Check( "Squat" ) then
						
						plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSquatStepOn" } )
					end
				end

				curPrio = mesPrio["EntryReq"]
				
			else
				
			end
		end
	end
end,





GetStepFloorInfo = function( plugin )

	

	local chara = plugin:GetCharacter()
	local plgBody = chara:FindPlugin( "ChBodyPlugin" )

	local charaPos	= plgBody:GetControlPosition()
	local charaRot	= chara:GetRotation()

	
	local checkPos

	if plgBody:CompAnimGraphCurrentTag( "Lower", "Behind" ) then
		checkPos = charaPos + charaRot:Rotate( Vector3( 0, 0, -1 ) )
	else
		checkPos = charaPos + charaRot:Rotate( Vector3( 0, 0, 1 ) )
	end

 	
	plugin.checkPos = checkPos

	





	local fromPos = checkPos + Vector3( 0, 2, 0 )
	local toPos = checkPos + Vector3( 0, -1, 0 )

	local stepLevel = plugin:GetFloorLevel{ from = fromPos  , to = toPos }

	

	local checkNormal = plugin:GetFloorNormal{ from = fromPos, to = toPos }
	plugin.checkNormal = checkNormal

	

	
	local angle = foxmath.Atan2( checkNormal:GetZ(), checkNormal:GetY() )
	plugin.checkAngle = angle
	

	local control = plgBody:GetControl()
	local height = stepLevel - control:GetFloorLevel()
	
	plugin.height = height
	

end,

}
