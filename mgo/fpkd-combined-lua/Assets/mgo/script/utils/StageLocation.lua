local this = {}
local StrCode32 = Fox.StrCode32

function this.QuatToRotX( rotQuat )
	local vec = rotQuat:Rotate( Vector3( 0, 1, 0 ) )
	local rot = foxmath.Atan2(vec:GetZ(), vec:GetY() )
	return TppMath.RadianToDegree(rot)
end
function this.QuatToRotY( rotQuat )
	local vec = rotQuat:Rotate( Vector3( 0, 0, 1 ) )
	local rot = foxmath.Atan2(vec:GetX(), vec:GetZ() )
	return TppMath.RadianToDegree(rot)
end

function this.WarpPlayer()
	Fox.Log("StageLocation.WarpPlayer - resets to PlayerPosition")
	local pPos, pRotY = Tpp.GetLocator( "MgoCustomizeStageIdentifier", "PlayerPosition" )
	TppPlayer.Warp{
		pos = pPos,
		rotY = pRotY,
	}
end


function this.WarpToStage()
	
	this.WarpPlayer()
	this.SetCameraStageCenter()
end

function this.SetCameraStageCenter()
	this.UpdateCameraParameterInterp( "Player", true )
end

function this.WarpFromStage()
	
	Player.SetAroundCameraManualMode(false)
end

local SelectCameraParameter = {
	[ Fox.StrCode32( "Player" ) ]
		= { locName = "Camera_Player", distance = 4.3, interpTime = 0.3, lock=false, minX = -5, maxX = 40 },
		
	[ Fox.StrCode32( "PlayerHeadShot" ) ]
		= { locName = "Camera_Player_HeadShot", distance = 2.0, interpTime = 0.3, lock=false, minX = -40, maxX = 40 },
		
	[ Fox.StrCode32( "PlayerHeadCloseShot" ) ]
		= { locName = "Camera_Player_HeadCloseShot", distance = 1.7, interpTime = 0.3, lock=false, minX = -40, maxX = 40 },
			
	[ Fox.StrCode32( "PlayerBustShot" ) ]
		= { locName = "Camera_Player_BustShot", distance = 3.0, interpTime = 0.3, lock=false, minX = -20, maxX = 40 },

	[ Fox.StrCode32( "PlayerOverviewFullShot" ) ]
		= { locName = "Camera_Player_Overview_FullShot", distance = 4.3, interpTime = 0.3, lock=false, minX = -5, maxX = 40 },
		
	[ Fox.StrCode32( "PlayerOverviewHeadShot" ) ]
		= { locName = "Camera_Player_Overview_HeadShot", distance = 2.0, interpTime = 0.3, lock=false, minX = -40, maxX = 40 },
		
	[ Fox.StrCode32( "PlayerOverviewHeadCloseShot" ) ]
		= { locName = "Camera_Player_Overview_HeadCloseShot", distance = 1.7, interpTime = 0.3, lock=false, minX = -40, maxX = 40 },
		
	[ Fox.StrCode32( "PlayerOverviewBustShot" ) ]
		= { locName = "Camera_Player_Overview_BustShot", distance = 3.0, interpTime = 0.3, lock=false, minX = -20, maxX = 40 },
		
	[ Fox.StrCode32( "LoadoutWithPool" ) ]
		= { locName = "Camera_LoadoutWithPool", distance = 5.0, interpTime = 0.3, lock=true },

	[ Fox.StrCode32( "WeaponPrimary" ) ]
		= { locName = "Camera_WeaponPrimary", distance = 2.0, interpTime = 0.3, lock=true },

	[ Fox.StrCode32( "WeaponSecondary" ) ]
		= { locName = "Camera_WeaponSecondary", distance = 1.4, interpTime = 0.3, lock=true },

	[ Fox.StrCode32( "PlayerCreate" ) ]
		= { locName = "Camera_Player_Create", distance = 4.3, interpTime = 0.3, lock=false, minX = -5, maxX = 40 },
}

function this.UpdateCameraParameter( focusTargetStr )
	this.UpdateCameraParameterInterp(focusTargetStr, false)
end

function this.UpdateCameraParameterInterp( focusTargetStr, noInterpTime )
	local focusTarget = Fox.StrCode32(focusTargetStr)

	local cameraParameter = SelectCameraParameter[ focusTarget ]
	if not cameraParameter then
		Fox.Error("Invalid focus target. focusTarget = " .. focusTargetStr )
		return
	end

	local targetTrans, targetRotQ = Tpp.GetLocatorByTransform( "MgoCustomizeStageIdentifier", cameraParameter.locName )
	local playerTrans, playerRotQ = Tpp.GetLocatorByTransform( "MgoCustomizeStageIdentifier", "PlayerPosition" )
	local params =	{
						distance = cameraParameter.distance,
						target = playerTrans,
						
						offset = Vector3( playerTrans:GetX()-targetTrans:GetX(), targetTrans:GetY()-playerTrans:GetY(), playerTrans:GetZ()-targetTrans:GetZ() ),
						aperture = 100,
						targetInterpTime = cameraParameter.interpTime,
						ignoreCollisionGameObjectId = ignoreCollision,	
					}

	
	if cameraParameter.lock then
		params.target = targetTrans
		params.offset = Vector3( 0, 0, 0 )
	end

	if noInterpTime then
		params.targetInterpTime = 0
	end
	
	Fox.Log("StageLocation.UpdateCameraParameter(" .. focusTargetStr .. ") : locatorName = " .. tostring(cameraParameter.locName) .. ", distance = " .. tostring(params.distance) .. ", interp = " .. params.targetInterpTime )
	Fox.Log("StageLocation.UpdateCameraParameter(" .. focusTargetStr .. ") : locatorName = " .. tostring(cameraParameter.locName) .. ", target = " .. tostring(params.target:GetX()) .. " " .. tostring(params.target:GetY()) .. " " .. tostring(params.target:GetZ()) )
	Fox.Log("StageLocation.UpdateCameraParameter(" .. focusTargetStr .. ") : locatorName = " .. tostring(cameraParameter.locName) .. ", offset = " .. tostring(params.offset:GetX()) .. " " .. tostring(params.offset:GetY()) .. " " .. tostring(params.offset:GetZ()) )
	Fox.Log("StageLocation.UpdateCameraParameter(" .. focusTargetStr .. ") : locatorName = " .. tostring(cameraParameter.locName) .. ", targetTrans = " .. targetTrans:GetX() .. " " .. targetTrans:GetY() .. " " .. targetTrans:GetZ() )

	if cameraParameter.lock then








		params.rotationLimitMinY = 180
		params.rotationLimitMaxY = 180
		params.rotationLimitMinX = 0
		params.rotationLimitMaxX = 0
	else






		local rotX = this.QuatToRotX(targetRotQ)
		params.rotationLimitMinX = rotX + cameraParameter.minX
		params.rotationLimitMaxX = rotX + cameraParameter.maxX




	end

	Player.SetAroundCameraManualMode(true)
	Player.SetAroundCameraManualModeParams(params)
	Player.UpdateAroundCameraManualModeParams()

	Player.RequestToSetCameraRotation( { rotQ = targetRotQ, interpTime = params.targetInterpTime } )
	Player.RequestToSetCameraStock{ direction = "right" }
end

function this.ResetPlayerRotation( valueStr )
		local unusedTrans, playerRotQ = Tpp.GetLocatorByTransform( "MgoCustomizeStageIdentifier", "PlayerPosition" )
		Player.WarpToRotation( {rotQ = playerRotQ} )
end

return this