PadTppPlayerUseTurretAction = {







Component = PlayerUseTurretActionPadOperatorComponent, 


TriggerButtons = {
	"PL_ACTION","PL_SHOT","PL_SEARCHLIGHT",
},


TriggerSticks = {
	fox.PAD_AXIS_RX,fox.PAD_AXIS_RY
},


TriggerMotionTags = {
},


InitParameters = {

	debugCallScriptFunc = false, 

},



IsEnableToUse = function( plgTurret,collectible )
	return ActionTppUseTurret.IsEnableToUse( plgTurret, collectible, 90 )
end,




__EnableCheck = function( chara, plugin )

	


	local plgTurret = chara:FindPlugin( "MgsUseTurretActionPlugin" )

	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local layerName = plgTurret:GetLayerName()
	if plgBody:CompAnimGraphCurrentTag( layerName, "Turret" ) then
		return true
	end


	
	if not plgTurret:IsSleeping() then
		
		return true
	end

	
	local stance = ActionTppUseTurret.IsEnableStance( plgBody, layerName )
	if stance == "" then
		
		return false
	end

	if not Pad.GetButtonStatus( 0, "PL_ACTION" ) then
		
		return false
	end

	
	local charaPos = chara:GetPosition()
	local searchRadius = 2.0
	local objects = Ch.FindCharactersSphere{ center = charaPos, radius = searchRadius, tags = { "Character", "Collectible" } }
	for i, object in ipairs( objects.array ) do
		while true do	
			
			




			local collectible = objects.array[i]
			if Entity.IsNull( collectible ) then break end
			if collectible:GetId() ~= "WP_M2" then break end

			
			
			if not ActionTppUseTurret.IsEnableToUse( plgTurret, collectible, 60 ) then break end

			
			plgTurret:SendActionRequest( MgsUseGimmickStartActionRequest( collectible ) )

			
			
			return true
		end
	end

	
	return false
end,





Update = function( chara, plugin )
	
	local plgTurret = chara:FindPlugin( "MgsUseTurretActionPlugin" )
	
	if Entity.IsNull( plgTurret ) then
		
		return
	end

	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local layerName = plgTurret:GetLayerName()























































	if plgBody:CompAnimGraphCurrentTag( layerName, "Turret" ) then
		if plgBody:CompAnimGraphCurrentTag( layerName, "End" ) then
			
			return
		end

		local isStartMotion = plgBody:CompAnimGraphCurrentTag( layerName, "Start" )


		if not isStartMotion and Pad.GetButtonPress( 0, "PL_ACTION" ) then
			
			
			plgTurret:SendActionRequest( MgsUseGimmickEndActionRequest() )

			
			return
		end


		local plgAim = chara:FindPlugin( "ChAimPlugin" )
		local aimPos = plgAim:GetAimPosition()

		if isStartMotion then

			plgTurret:SendActionRequest( MgsTurretAimActionRequest{ aimPosition = aimPos, interpTime = 5.0 } )

		elseif Pad.GetButtonStatus( 0, "PL_SHOT" ) then

			local fireRequest =	MgsTurretFireActionRequest{
				aimPosition = aimPos,
				interpTime = 5.0,
				allowDiffX = foxmath.DegreeToRadian( 30 ),
				allowDiffY = foxmath.DegreeToRadian( 30 ),
			}
			plgTurret:SendActionRequest( fireRequest )

		else

			plgTurret:SendActionRequest( MgsTurretAimActionRequest{ aimPosition = aimPos, interpTime = 5.0 } )
			

		end

		
		local plgTps = chara:FindPlugin( "TppTpsCameraPlugin" )
		if not Entity.IsNull( plgTps ) and not plgTps:IsSleeping() then
			
			local padX = plugin.rightStickX
			local padY = plugin.rightStickY
			local force

if true then
		
		padX,padY,force = TppPadOperatorUtility.GetAdjustPadAxis(padX,padY)

end

			local padConfig = TppPadConfigData.GetInstance()
			if( padConfig ) then
				if( padConfig.tpsCameraXIsReversed ) then
					padX = -padX
				end
				if( padConfig.tpsCameraYIsReversed ) then
					padY = -padY
				end
				padX = padX * padConfig.tpsCameraXSencitiveness
				padY = padY * padConfig.tpsCameraYSencitiveness
			end
	



			plgTps:SetRotationForce( Vector3( padX, padY, 0 ) )
			
			
			

		end
	end




	
end,

GetDiffDir = function( radFrom, radTo )

	local pi2 = foxmath.PI * 2

	local diff = radTo - radFrom

	
	if diff >= pi2 then
		diff = foxmath.Mod( diff, pi2 )
	elseif diff <= -pi2 then
		diff = -diff
		diff = -foxmath.Mod( diff, pi2 )
	end

	
	if diff < -foxmath.PI then
		diff = diff + pi2
	elseif diff > foxmath.PI then
		diff = diff - pi2
	end

	return diff

end,

}
