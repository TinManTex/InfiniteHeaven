ActionTppStepDown = {



WakeUpStates = {
	 "stateStandStepDownToMove",
	 "stateSquatStepDownToMove",
	 "stateSquatStepDown",
	 "stateStandStepDown",
},




OnWakeUp = function( plugin )

	

	local chara = plugin:GetCharacter()
	local plgAdjust = chara:FindPlugin( "ChHumanAdjustPlugin" )
	if not Entity.IsNull( plgAdjust )then
		plgAdjust:LegsIkOff()
	end

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
	

	local control = plgBody:GetControl()
	

	local height = plgBody:GetControlPosition():GetY() - control:GetHeight() - control:GetFloorLevel()
	

	if height < 0.5 then

		
		
		if plgBody:CompAnimGraphCurrentTag( "Lower", "StepDown" ) and not plgBody:CompAnimGraphCurrentTag( "Lower", "Start" ) then

			
			if plgBody:CompAnimGraphCurrentTag( "Lower", "Carry" ) then
					plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateRouteRelaxedIdle" } )
			elseif plgBody:CompAnimGraphCurrentTag( "Lower", "Stand" ) then
					plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateRouteRelaxedIdle" } )
			
			elseif plgBody:CompAnimGraphCurrentTag( "Lower", "Squat" ) then
					plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateSquatIdle" } )
			else
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateRouteRelaxedIdle" } )
			end

		end
	end

	if plgBody:IsLeaveAnimGraphNode( "Lower" ) then
		if plgBody:CompAnimGraphPreviousTag( "Lower", "End" ) and plgBody:CompAnimGraphPreviousTag( "Lower", "StepDown" ) then
			
			plugin:SleepRequest()
		end
	end



	
end,

}
