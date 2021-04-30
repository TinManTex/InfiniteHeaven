ActionTppFultonRecovered = {
	




OnPreControl = function( plugin )

	
	if plugin:GetFultonRecoveredStatus() == "DISABLE" then
		return
	end

	local chara = plugin:GetCharacter()
	local height1st = 1.0
	local time1st = 1.0
	local idleTime = 1.0
	local height2nd = 1.0
	local time2nd = 1.0

	local gameDefaultData = TppDefaultParameter.GetDataFromGroupName("TppHumanEnemyDefaultParameter")
	if not Entity.IsNull( gameDefaultData ) then
		local gameDefaultParams = gameDefaultData:GetParam("params")
		height1st = gameDefaultParams.fultonRecovered1stStepHeight
		time1st = gameDefaultParams.fultonRecovered1stStepTime
		idleTime = gameDefaultParams.fultonRecoveredIdleTime
		height2nd = gameDefaultParams.fultonRecovered2ndStepHeight
		time2nd = gameDefaultParams.fultonRecovered2ndStepTime
	end

	local plgBody = plugin:GetBodyPlugin()
	local controlVelocity = plgBody:GetControlVelocity()
	local interval = plugin:GetCharacter():GetInterval()
		
	if plugin:FindCharacterTag( "Enemy" ) then
	
		if plgBody:CompAnimGraphCurrentTag( "Lower", "Floating" ) then

			local postControlVelocity = Vector3( 0, 0, 0 )
			if interval ~= 0 then
				local controlVelocity = plgBody:GetControlVelocity()
				postControlVelocity = Vector3( controlVelocity:GetX(), height1st / ( time1st / interval ), controlVelocity:GetZ() )
			end
			plgBody:SetControlVelocity( postControlVelocity )

		elseif  plgBody:CompAnimGraphCurrentTag( "Lower", "Idle" ) then

			if  plugin.idleTimer >= idleTime then
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateFultonRecoveredBlowOff" } )
				
				
				local mbKeyIndex = 0

					


				local locator = chara:GetLocatorHandle()
				if locator ~= nil then
					if locator.networkId ~= nil then
						mbKeyIndex = locator.networkId
					end
				end

				TppMotherBaseManager.GetInstance():FultonRecovered( mbKeyIndex )

				
				local ncld = NclDaemon.GetInstance()
				local netInfo = NetworkInfo.GetInstance()
				if( netInfo and ncld:IsLogin() and mbKyeIndex ~= 0 ) then
					local codec = CmdFultonSoldierHttpCodec{ playerId = netInfo.playerId, motherbaseId = netInfo.motherBaseId, soldierId = mbKeyIndex }
					local call = FultonSoldierReceive{}
					codec:SetCallback{callback=call}
					codec:Post{}
				end
			end

			plugin.idleTimer = plugin.idleTimer + interval

		elseif plgBody:CompAnimGraphCurrentTag( "Lower", "BlowOff" ) then

			local control = plgBody:GetControl()
			local charaHeight = plgBody:GetControlPosition():GetY()
			local floorHeight = control:GetFloorLevel()

			if height2nd > charaHeight - floorHeight then

				local postControlVelocity = Vector3( 0, 0, 0 )
				if interval ~= 0 then
					local controlVelocity = plgBody:GetControlVelocity()
					postControlVelocity = Vector3( controlVelocity:GetX(), height2nd / ( time2nd / interval ), controlVelocity:GetZ() )
				end
				plgBody:SetControlVelocity( postControlVelocity )
			else
				
				
				
				
				plugin:SetUnrealizeRequest()

				
				TppEnemyEventTriggerMessage.SendEnemyFultonMessage(chara)

				
				TppEnemyUtility.SendDeadMessage(chara)
				
				
				plugin:SetDisableStatus()
			end
		end
	elseif plugin:FindCharacterTag("Gadget") then
		
		
		
		if  plugin.idleTimer < time1st then
			
			
			
		elseif  plugin.idleTimer <= time1st + idleTime then
		
		elseif  plugin.idleTimer > 2 then
			
			
			
			
			
			TppGadgetUtility.SendMessageProxy(chara,"CompleteFultonRecover");
			
			local object = chara:GetCharacterObject()
			object:UnrealizeByRealizer()
		end
		
		
		
		
		
		
		
			
		plugin.idleTimer = plugin.idleTimer + interval
			

		
	
	elseif plugin:FindCharacterTag( "Hostage" ) then
		
		
		if plgBody:CompAnimGraphCurrentTag( "Lower", "Floating" ) then

			local postControlVelocity = Vector3( 0, 0, 0 )
			if interval ~= 0 then
				local controlVelocity = plgBody:GetControlVelocity()
				postControlVelocity = Vector3( controlVelocity:GetX(), height1st / ( time1st / interval ), controlVelocity:GetZ() )
			end
			plgBody:SetControlVelocity( postControlVelocity )
			
		elseif  plgBody:CompAnimGraphCurrentTag( "Lower", "Idle" ) then
			
			if  plugin.idleTimer >= idleTime then
				
				plugin:SendActionRequest( ChChangeStateActionRequest{ groupName="stateFultonRecoveredBlowOff" } )
			end
			
			plugin.idleTimer = plugin.idleTimer + interval
			
		elseif plgBody:CompAnimGraphCurrentTag( "Lower", "BlowOff" ) then
			
			local control = plgBody:GetControl()
			local charaHeight = plgBody:GetControlPosition():GetY()
			local floorHeight = control:GetFloorLevel()
			
			if height2nd > charaHeight - floorHeight then
				
				local postControlVelocity = Vector3( 0, 0, 0 )
				if interval ~= 0 then
					local controlVelocity = plgBody:GetControlVelocity()
					postControlVelocity = Vector3( controlVelocity:GetX(), height2nd / ( time2nd / interval ), controlVelocity:GetZ() )
				end
				plgBody:SetControlVelocity( postControlVelocity )
			else
				
				plugin:SetUnrealizeRequest()

				
				local charaObj = chara:GetCharacterObject()
				local msgBox = charaObj:GetMessageBox()
				local charaId = chara:GetCharacterId()
				msgBox:SendMessageToSubscribers( "CompleteFultonRecover", charaId, chara )
				
				
				plugin:SetDisableStatus()
			end
		end
	end
end,
}
