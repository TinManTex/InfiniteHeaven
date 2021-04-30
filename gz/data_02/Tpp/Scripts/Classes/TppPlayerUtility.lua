




TppPlayerUtility = {
	



ShowActionIcon = function( icon )
	GrxDebug.Print2D{ life=1, x=550, y= 600, size=15, color=Color(0.5, 1.0, 0.4, 1.0), args={ icon }, }
	GrxDebug.Print2D{ life=1, x=552, y= 602, size=15, color=Color(0.0, 0.0, 0.0, 0.8), args={ icon }, }
end,




DebugBullet = function( chara, attackName, targetGroup )
	local effectName = ""
	local speed = 5
	local penetration = 100.0
	local gravity = 9.8
	local life = 3.0
	local straightRange = 20.0
	local strengthInit = 1.0
	local strengthLast = 0.1
	local strengthStart = 10.0
	local strengthEnd = 90.0
	local penetrateInit = 100.0
	local penetrateLast = 100.0
	local penetrateStart = 0.0
	local penetrateEnd = 0.0
	local stoppingInit = 1.0
	local stoppingLast = 0.1
	local stoppingStart = 10.0
	local stoppingEnd = 90.0
	local wobbling = 0.18

	local charaObj = chara:GetCharacterObject()
	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local pos = plgBody:GetControlPosition()
	local hit = Vector3( pos:GetX(), pos:GetY()+0.2, pos:GetZ() )
	local direction = Vector3(0,0,1)

	TppBulletForLuaTest {
		attackTargetName 		= attackName,
		position				= hit,
		direction				= direction,
		speed					= speed,
		penetration				= penetration,
		gravity					= gravity,
		targetGroup				= targetGroup,
		shooter					= NULL,
		life					= life,
		straightRange			= straightRange,
		strengthDecayCurve		= { strengthInit, strengthLast, strengthStart, strengthEnd },
		penetrationDecayCurve	= { penetrateInit, penetrateLast, penetrateStart, penetrateEnd },
		stoppingPowerDecayCurve	= { stoppingInit, stoppingLast, stoppingStart, stoppingEnd },
		wobbling				= wobbling,
	}
end,





SetDisableActions = function( chara, disableActions, setFlag )



end,






CyprActionLimitCommon = function( setFlag )
	if setFlag == "Set" then
		TppPlayerUtility.SetDisableActionsWithName {
			name = "CyprCommon",
			disableActions = {
				"DIS_ACT_CQC",
				"DIS_ACT_CARRY",
				"DIS_ACT_FULTON",
				"DIS_ACT_MB_TERMINAL",
				"DIS_ACT_CALL",
				"DIS_ACT_BINOCLE"
			}
		}
	elseif setFlag == "Unset" or setFlag == "Reset" then
		TppPlayerUtility.ResetDisableActionsWithName("CyprCommon")
	else



	end
end,


CyprActionLimitChangeEquip = function( setFlag )
	if setFlag == "Set" then
		TppPlayerUtility.SetDisableActionsWithName {
			name = "CyprChangeEquip",
			disableActions = {
				"DIS_ACT_CHANGEEQUIP",
			}
		}
	elseif setFlag == "Unset" or setFlag == "Reset" then
		TppPlayerUtility.ResetDisableActionsWithName("CyprChangeEquip")
	else



	end
end,


CyprActionLimitStand = function( setFlag )
	if setFlag == "Set" then
		TppPlayerUtility.SetDisableActionsWithName {
			name = "CyprStand",
			disableActions = {
				"DIS_ACT_STAND",
				"DIS_ACT_DASH",
			}
		}
	elseif setFlag == "Unset" or setFlag == "Reset" then
		TppPlayerUtility.ResetDisableActionsWithName("CyprStand")
	else



	end
end,


CyprActionLimitDash = function( setFlag )
	if setFlag == "Set" then
		TppPlayerUtility.SetDisableActionsWithName {
			name = "CyprDash",
			disableActions = {
				"DIS_ACT_DASH",
			}
		}
	elseif setFlag == "Unset" or setFlag == "Reset" then
		TppPlayerUtility.ResetDisableActionsWithName("CyprDash")
	else



	end
end,


CyprActionLimitExceptCrawl = function( setFlag )
	if setFlag == "Set" then
		TppPlayerUtility.SetDisableActionsWithName {
			name = "CyprExceptCrawl",
			disableActions = {
				"DIS_ACT_DASH",
				"DIS_ACT_STAND",
				"DIS_ACT_SQUAT",
			}
		}
	elseif setFlag == "Unset" or setFlag == "Reset" then
		TppPlayerUtility.ResetDisableActionsWithName("CyprExceptCrawl")
	else



	end
end,

HospitalActionLimit = function( chara, setFlag )



end,





HospitalDemoActionLimit = function( chara, setFlag )



end,




RideHelicopterActionLimit = function( chara, setFlag )

	if DEBUG then



	end

	if setFlag ~= "Set" and setFlag ~= "Unset" then



		return
	end
	if setFlag == "Set" then
		TppPlayerUtility.SetDisableActionsWithName{ name = "DisActRideHelicopter", disableActions = { "DIS_ACT_RIDE_HELICOPTER" } }
	else
		TppPlayerUtility.ResetDisableActionsWithName( "DisActRideHelicopter" )
	end
end,




AddPadPlugin = function( chara )








	
	









































































	
	
	if DEBUG then
		













	end





































end,





AddCameraPlugin = function( chara )

	chara:AddPlugins{

		
		"PLG_CAMERACOMMONWORK",
		TppCameraCommonWork {
			priority		= "CameraCommonWork",
			name			= "CameraCommonWork",
		},

		
		"PLG_CUT_IN_CAMERA",
		TppCutInCameraPlugin{
			name			= "CutInCamera",
			cameraPriority	= "Game",
			exclusiveGroups	= { TppPluginExclusiveGroup.Camera },
			priority		= "CutInCamera",
			isSleepStart	= true,
		},

		
		"PLG_CAMERAMAN_CAMERA",
		TppCameramanCameraPlugin{
			name			= "NewAroundCamera",
			cameraPriority	= "Game",
			exclusiveGroups	= { TppPluginExclusiveGroup.Camera },
			priority		= "AroundCamera",

			components		= {
				TppCameraComponentShakeCamera{},	
				TppCameraComponentTargetConstrainCamera{},	
				TppCameraComponentRideHeli{},		
			},

			distance		= 5.5,				
			focalLength		= 19.2,				
			distanceInterpRate	= 0.975,

			paramScript = "/Assets/tpp/level_asset/chara/player/CameraAroundParams.lua",

			isSleepStart	= true,
		},

		
		"PLG_NEW_TPS_CAMERA",
		TppNewTpsCameraPlugin{
			name			= "NewTpsCamera",
			cameraPriority	= "Game",
			exclusiveGroups	= { TppPluginExclusiveGroup.Camera },
			priority		= "TpsCamera",

			components		= {
				TppCameraComponentEmplacement{},			
				TppCameraComponentVehicleTurret{},			
			},

			distance		= 1.35,				
			offset			= Vector3( -0.40, 0.55, 0 ),
			focalLength		= 19.2,							
			defaultFocalLength = 24.0,
			aimRootOffset	= 0.8,	

			paramScript = "/Assets/tpp/level_asset/chara/player/CameraTpsParams.lua",

			isSleepStart	= true,
		},

		
		"PLG_NEW_SUBJECTIVE_CAMERA",
		TppNewSubjectiveCameraPlugin{
			name			= "NewSubjectiveCamera",
			cameraPriority	= "Game",
			exclusiveGroups	= { TppPluginExclusiveGroup.Camera },
			priority		= "SubjectiveCamera",
			
			components		= {
				TppCameraComponentEmplacement{},			
			},
			
			defaultFocalLength = 24.0,
			attachPointType	= "Head",
			
			aimRootOffset	= 0.0,	

			nearClipMin		= 0.05,
			nearClipMax		= 0.5,
			zoomForceMax	= 10.0,

			paramScript = "/Assets/tpp/level_asset/chara/player/CameraSubjectiveParams.lua",

			isSleepStart	= true,
		},
	}

	chara:AddPlugins{

		
		"PLG_HIGHSPEEDCAMERA_EVENT_OPERATOR",
		TppHighSpeedCameraOperatorPlugin{
			name				= "HighSpeedCameraEventOperator",
			baseRateReduceTime	= 20,
			cameraRotInterp		= 0.93,
			cameraPosInterp		= 0.5,
			cameraFocusInterp	= 0.95,
			cameraFocalLength	= 40.0,
			cameraAperture		= 3.0,
			cameraRotZ			= foxmath.DegreeToRadian( 2 ),
			cameraOffset		= Vector3( -1.2, 1.0, -5.0 ),
			cameraOffsetDist	= 5.0,
			cameraBezierControlTime	= 0.3,
			cameraBezierControlRate	= 0.9,
			debugCallScript = false,
			isSleepStart	= true,
		},
	}

end,







FindNearestConnectPoint = function( chara, cnpOwner, cnpTable )

	
	local distTable = {}
	local charaPos = chara:GetPosition()
	local plgBody = cnpOwner:FindPlugin( "ChBodyPlugin" )

	for i, name in ipairs( cnpTable ) do
		local isValid, mtx = plgBody:GetValidConnectPointMatrix( name )
		if isValid then
			local cnpPos = mtx:GetTranslation()
			local distanceFromCharaToCNP = ( cnpPos - charaPos ):GetLength()
			table.insert( distTable, distanceFromCharaToCNP )



		end

	end

	
	local nearestDist = distTable[1]
	local nearestIndex = 1
	for i, dist in ipairs( distTable ) do
		if nearestDist > dist then
			nearestDist = dist
			nearestIndex = i



		end
	end

	
	return cnpTable[nearestIndex]
end,

} 

