 TppPlayerCallbackScript = {

StartCameraAnimation = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	TppPlayerCallbackScript._StartCameraAnimation( eventStartFrame, currentPlayFrame, stringIdValue1, true, false, intValue1, false, true)
end,

StartCameraAnimationNoRecover = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )
	
	
	TppPlayerCallbackScript._StartCameraAnimation( eventStartFrame, currentPlayFrame, stringIdValue1, false, false, intValue1, true)
end,

StartCameraAnimationNoRecoverNoCollsion = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )
	
	
	TppPlayerCallbackScript._StartCameraAnimation( eventStartFrame, currentPlayFrame, stringIdValue1, false, true, intValue1)
end,


StartCameraAnimationForSnatchWeapon = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	if ( TppPlayerUtility.GetStock() == 0 ) then
		TppPlayerCallbackScript._StartCameraAnimationUseFileSetName( eventStartFrame, currentPlayFrame, "CqcSnatchAssaultRight", true, false)
	else
		TppPlayerCallbackScript._StartCameraAnimationUseFileSetName( eventStartFrame, currentPlayFrame, "CqcSnatchAssaultLeft", true, false)
	end
end,

StopCameraAnimation = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	

	TppPlayerUtility.RequestToStopCameraAnimation{
		fileSet = stringIdValue1,
	}

end,

StartCureDemoEffectStart = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )
	
end,






SetCameraNoise = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	
	TppPlayerCallbackScript._SetCameraNoise( floatValue1, floatValue1, floatValue2 )

end,


SetCameraNoiseLadder = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	TppPlayerCallbackScript._SetCameraNoise( 0.2, 0.2, 0.1 )

end,


SetCameraNoiseElude = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	TppPlayerCallbackScript._SetCameraNoise( 0.2, 0.2, 0.1 )

end,


SetCameraNoiseDamageBend = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	TppPlayerCallbackScript._SetCameraNoise( 0.5, 0.5, 0.2 )

end,


SetCameraNoiseDamageBlow = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	TppPlayerCallbackScript._SetCameraNoise( 0.5, 0.5, 0.5 )

end,


SetCameraNoiseDamageDeadStart = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	TppPlayerCallbackScript._SetCameraNoise( 0.45, 0.45, 0.52 )

end,


SetCameraNoiseFallDamage = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	TppPlayerCallbackScript._SetCameraNoise( 1.0, 0.4, 0.5 )

end,


SetCameraNoiseDashToWallStop = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )

	TppPlayerCallbackScript._SetCameraNoise( 0.5, 0.5, 0.2 )

end,


SetCameraNoiseStepOn = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )





	TppPlayerCallbackScript._SetCameraNoise( 0.3, 0.3, 0.1 )

end,


SetCameraNoiseStepDown = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )





	local levelX = 0.0
	local levelY = 0.0

	
	if ( floatValue1 > 0 ) then
		levelX = floatValue1
		levelY = floatValue1 * 0.25
	else
		levelX = 0.225
		levelY = 0.057
	end

	TppPlayerCallbackScript._SetCameraNoise( levelX, levelY, 0.11 )

end,


SetCameraNoiseStepJumpEnd = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )





	local levelX = 0.0
	local levelY = 0.0

	
	if ( floatValue1 > 0 ) then
		levelX = floatValue1
		levelY = floatValue1 * 0.25
	else
		levelX = 0.225
		levelY = 0.057
	end

	TppPlayerCallbackScript._SetCameraNoise( levelX, levelY, 0.2 )

end,


SetCameraNoiseStepJumpToElude = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	TppPlayerCallbackScript._SetCameraNoise( 0.4, 0.4, 0.4 )

end,


SetCameraNoiseVehicleCrash = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	TppPlayerCallbackScript._SetCameraNoise( 0.5, 0.5, 0.5 )

end,


SetCameraNoiseCqcHit = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	TppPlayerCallbackScript._SetCameraNoise( 0.5, 0.5, 0.4 )

end,


SetCameraNoiseEndCarry = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	local levelX = 0.25
	local levelY = 0.25
	local time = 0.15
	local decayRate = 0.05
	local randomSeed = 12345
	local enableCamera = { "NewAroundCamera" }

	TppPlayerUtility.SetCameraNoise{
		levelX = levelX,
		levelY = levelY,
		time = time,
		decayRate = decayRate,
		randomSeed = randomSeed,
		enableCamera = enableCamera,
	}

end,


SetCameraNoiseOnMissileFire = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	local levelX = 0.5
	local levelY = 0.5
	local time = 0.75
	local decayRate = 0.08
	local randomSeed = 12345
	local enableCamera = { 0, 1, 2 }

	TppPlayerUtility.SetCameraNoise{
		levelX = levelX,
		levelY = levelY,
		time = time,
		decayRate = decayRate,
		randomSeed = randomSeed,
		enableCamera = enableCamera,
	}
end,


SetCameraNoiseOnRideOnAntiAircraftGun = function( eventStartFrame, currentPlayFrame,
	intValue1, intValue2, intValue3,
	floatValue1, floatValue2, floatValue3,
	stringIdValue1, stringIdValue2, stringIdValue3 )




	local levelX = 0.2
	local levelY = 0.2
	local time = 0.3
	local decayRate = 0.08
	local randomSeed = 12345
	local enableCamera = { 0, 1, 2 }

	TppPlayerUtility.SetCameraNoise{
		levelX = levelX,
		levelY = levelY,
		time = time,
		decayRate = decayRate,
		randomSeed = randomSeed,
		enableCamera = enableCamera,
	}
end,


SetNonAnimationCutInCameraFallDeath = function()

	local VehicleId = TppPlayerUtility.GetRidingVehicleCharacterId()





	if ( VehicleId ~= "" ) then
		local playerChara = TppPlayerUtility.GetLocalPlayerCharacter()
		local playerPos = playerChara:GetPosition()
		local MaxInterpCameraHeight = 5.3
		local MinInterpCameraHeight = 3.8
		
		
		local SetCameraY = -2.3		
		if ( playerPos:GetY() < MaxInterpCameraHeight ) then
			if ( playerPos:GetY() < MinInterpCameraHeight ) then
				SetCameraY = 3.3	
			else
				
				SetCameraY = 3.3 - ( playerPos:GetY() - MinInterpCameraHeight) / (MaxInterpCameraHeight - MinInterpCameraHeight )* 5.6
			end
		end
	
		
		TppPlayerUtility.RequestToPlayCameraNonAnimation{
			characterId = VehicleId,
			isFollowPos = false,
			isFollowRot = true,
			followTime = 0.1,
			useCharaPosRot = true,
			rotX = -30.0,
			rotY = 45.0,
			candidateRotX = 0.0,
			candidateRotY = 30.0,
			offsetPos = Vector3( -4.0, SetCameraY, -8.0),
			focalLength = 21.0,
			aperture = 20.0
		}
	else
		local playerChara = TppPlayerUtility.GetLocalPlayerCharacter()
		local playerPos = playerChara:GetPosition()
		local MaxInterpCameraHeight = 5.3
		local MinInterpCameraHeight = 3.8
		
		
		local SetCameraY = -2.3		
		if ( playerPos:GetY() < MaxInterpCameraHeight ) then
			if ( playerPos:GetY() < MinInterpCameraHeight ) then
				SetCameraY = 1.5	
			else
				
				SetCameraY = 1.5 - ( playerPos:GetY() - MinInterpCameraHeight) / (MaxInterpCameraHeight - MinInterpCameraHeight )* 3.8
			end
		end
		



		
		TppPlayerUtility.RequestToPlayCameraNonAnimation{
			characterId = "Player",
			isFollowPos = false,
			isFollowRot = true,
			followTime = 0.1,
			useCharaPosRot = true,
			rotX = -30.0,
			rotY = 45.0,
			candidateRotX = 0.0,
			candidateRotY = 30.0,
			offsetPos = Vector3( -2.43, SetCameraY, -2.43),
			focalLength = 21.0,
			aperture = 20.0
		}
	end

	TppHighSpeedCameraManager.RequestEvent{
		continueTime = 1.0,		
		worldTimeRate = 0.1,			
		localPlayerTimeRate = timeRate,		
		timeRateInterpTimeAtStart = 0.0,	
		timeRateInterpTimeAtEnd = 0.3,		
		cameraSetUpTime = 0.0				
	}
	
end,


SetHighSpeeCameraOnCQCDirectThrow = function()
	if TppPlayerUtility.IsCqcThrowWithHighSpeed() == true then
		TppSoundDaemon.PostEvent( 'sfx_s_highspeed_cqc' )
		TppPlayerCallbackScript._SetHighSpeedCamera( 1.0, 0.1 )
	end
end,


SetHighSpeeCameraOnCQCComboFinish = function()
	TppSoundDaemon.PostEvent( 'sfx_s_highspeed_cqc' )
	TppPlayerCallbackScript._SetHighSpeedCamera( 0.6, 0.03 )
end,


SetHighSpeeCameraAtCQCSnatchWeapon = function()
	TppSoundDaemon.PostEvent( 'sfx_s_highspeed_cqc' )
	TppPlayerCallbackScript._SetHighSpeedCamera( 1.0,	0.1 )
end,






defaultStopPlayingByCollision = false,			
defaultEnableCamera = { "NewAroundCamera" },		
defaultInterpTimeToRecoverOrientation = 0.24,	
defaultStopRecoverInterpByPadOperation = true,	
defaultInterpType = 2,							


_StartCameraAnimation = function( eventStartFrame, currentPlayFrame, animationFileSet, recoverPreOrientationSetting, ignoreCollisionCheckOnStart, offsetFrame, isRiding, StopPlayingByCollision )




	
	
	
	local startFrame = currentPlayFrame - eventStartFrame + offsetFrame
	
	local recoverPreOrientation = recoverPreOrientationSetting

	if ( StringId.IsEqual(animationFileSet,"CureGunShotWoundBodyLeft") or
		StringId.IsEqual(animationFileSet,"CureGunShotWoundBodyRight") or
		StringId.IsEqual(animationFileSet,"CureGunShotWoundBodyCrawl") or
		StringId.IsEqual(animationFileSet,"CureGunShotWoundBodySupine") ) then



		TppPlayerUtility.SetFocusParamForCameraAnimation{ aperture=3, focusDistance = 0.6 }
	end

	
	TppPlayerUtility.RequestToPlayCameraAnimation{
		
		fileSet = animationFileSet, 
		startFrame = startFrame,  
		ignoreCollisionCheckOnStart = ignoreCollisionCheckOnStart,
		recoverPreOrientation = recoverPreOrientation,
		isRiding = isRiding,
		stopPlayingByCollision = true,
		
		enableCamera = TppPlayerCallbackScript.defaultEnableCamera,
		interpTimeToRecoverOrientation = TppPlayerCallbackScript.defaultInterpTimeToRecoverOrientation,
		stopRecoverInterpByPadOperation = TppPlayerCallbackScript.defaultStopRecoverInterpByPadOperation,
		interpType = TppPlayerCallbackScript.defaultInterpType,
	}
end,


_StartCameraAnimationUseFileSetName = function( eventStartFrame, currentPlayFrame, animationFileSetName, recoverPreOrientationSetting, ignoreCollisionCheckOnStart )




	
	
	
	local startFrame = currentPlayFrame - eventStartFrame
	
	local recoverPreOrientation = recoverPreOrientationSetting

	if ( animationFileSetName == "CqcSnatchAssaultRight" or animationFileSetName == "CqcSnatchAssaultLeft" ) then



		TppPlayerUtility.SetFocusParamForCameraAnimation{ aperture=20 }
	end

	
	TppPlayerUtility.RequestToPlayCameraAnimation{
		
		fileSetName = animationFileSetName, 
		startFrame = startFrame,  
		ignoreCollisionCheckOnStart = ignoreCollisionCheckOnStart,
		recoverPreOrientation = recoverPreOrientation,
		
		stopPlayingByCollision = TppPlayerCallbackScript.defaultStopPlayingByCollision,
		enableCamera = TppPlayerCallbackScript.defaultEnableCamera,
		interpTimeToRecoverOrientation = TppPlayerCallbackScript.defaultInterpTimeToRecoverOrientation,
		stopRecoverInterpByPadOperation = TppPlayerCallbackScript.defaultStopRecoverInterpByPadOperation,
		interpType = TppPlayerCallbackScript.defaultInterpType,
	}
end,

_SetCameraNoise = function( levelX, levelY, time )

	
	local levelX = levelX
	local levelY = levelY
	local time = time
	local decayRate = 0.15
	local randomSeed = 12345
	local enableCamera = { "NewAroundCamera" }

	TppPlayerUtility.SetCameraNoise{
		levelX = levelX,
		levelY = levelY,
		time = time,
		decayRate = decayRate,
		randomSeed = randomSeed,
		enableCamera = enableCamera,
	}

end,

_SetHighSpeedCamera = function( continueTime, timeRate )





	TppHighSpeedCameraManager.RequestEvent{
		continueTime = continueTime,		
		worldTimeRate = timeRate,			
		localPlayerTimeRate = timeRate,		
		timeRateInterpTimeAtStart = 0.0,	
		timeRateInterpTimeAtEnd = 0.0,		
		cameraSetUpTime = 0.0				
	}

end,


}
