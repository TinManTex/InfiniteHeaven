





PadTppPlayerCommon = {









Component = PlayerCommonPadOperatorComponent, 


InitParameters = {

	debugCallScriptFunc = false, 

},




__Update = function( chara, plugin )

	






















	
end,


ViewStatus  = function( chara )

	local desc = chara:GetCharacterDesc()
	if desc.state_status == nil then
		
		return
	end

	local status = desc.state_status:GetStatusString()
	local pos = chara:GetPosition()
	GrxDebug.Print3D
	{
		life	= 1,							
		pos		= pos + Vector3( 0, 1.0, 0 ),	
		size	= 30,							
		color	= Color(0.3,0.7,0.5, 0.9),		
		args	= { status },						
	}


	
	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local charaObject = chara:GetCharacterObject()
	local blendControlValue = charaObject:GetBlendControlValue()
	local playerInternalWork = chara:FindPlugin( "TppPlayerInternalWorkPlugin" )
	GrxDebug.Print2D {
		x=0, y=244,
		size = 10,
		color=Color(1,1,1,1),
		args={ "dashModeBlendRate :", blendControlValue.dashMoveBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=256,
		size = 10,
		color=Color(1,1,1,1),
		args={ "moveTypeSelectIndex :", blendControlValue.moveTypeSelectIndex }
	}
	GrxDebug.Print2D {
		x=0, y=268,
		size = 10,
		color=Color(1,1,1,1),
		args={ "turnTypeSelectIndex :", blendControlValue.turnTypeSelectIndex }
	}
	GrxDebug.Print2D {
		x=0, y=280,
		size = 10,
		color=Color(1,1,1,1),
		args={ "standIdleTypeSelectIndex :", blendControlValue.standIdleTypeSelectIndex }
	}
	GrxDebug.Print2D {
		x=0, y=292,
		size = 10,
		color=Color(1,1,1,1),
		args={ "moveSpeedBlendRate :", blendControlValue.moveSpeedBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=304,
		size = 10,
		color=Color(1,1,1,1),
		args={ "turnSpeedBlendRate :", blendControlValue.turnSpeedBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=316,
		size = 10,
		color=Color(1,1,1,1),
		args={ "generalBlendRate :", blendControlValue.generalBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=328,
		size = 10,
		color=Color(1,1,1,1),
		args={ "moveRandomBlendRate :", blendControlValue.moveRandomBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=340,
		size = 10,
		color=Color(1,1,1,1),
		args={ "standIdleBlendRate :", blendControlValue.standIdleBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=352,
		size = 10,
		color=Color(1,1,1,1),
		args={ "cameraDirTypeSelectIndex :", blendControlValue.cameraDirTypeSelectIndex }
	}
	GrxDebug.Print2D {
		x=0, y=364,
		size = 10,
		color=Color(1,1,1,1),
		args={ "cameraDirSpeedBlendRate :", blendControlValue.cameraDirSpeedBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=376,
		size = 10,
		color=Color(1,1,1,1),
		args={ "holdAngleX :", blendControlValue.holdAngleX }
	}
	GrxDebug.Print2D {
		x=0, y=388,
		size = 10,
		color=Color(1,1,1,1),
		args={ "holdAngleY :", blendControlValue.holdAngleY }
	}
	GrxDebug.Print2D {
		x=0, y=400,
		size = 10,
		color=Color(1,1,1,1),
		args={ "toHoldTurnType :", blendControlValue.toHoldTurnType }
	}
	GrxDebug.Print2D {
		x=0, y=412,
		size = 10,
		color=Color(1,1,1,1),
		args={ "toHoldTurnSpeed :", blendControlValue.toHoldTurnSpeed }
	}
	GrxDebug.Print2D {
		x=0, y=424,
		size = 10,
		color=Color(1,1,1,1),
		args={ "toPutTurnType :", blendControlValue.toPutTurnType }
	}
	GrxDebug.Print2D {
		x=0, y=436,
		size = 10,
		color=Color(1,1,1,1),
		args={ "crawlBodyAngle :", blendControlValue.crawlBodyAngle }
	}
	GrxDebug.Print2D {
		x=0, y=448,
		size = 10,
		color=Color(1,1,1,1),
		args={ "wallFaceDir :", blendControlValue.wallFaceDir }
	}
	GrxDebug.Print2D {
		x=0, y=460,
		size = 10,
		color=Color(1,1,1,1),
		args={ "wallDirBlendRate :", blendControlValue.wallDirBlendRate }
	}

	GrxDebug.Print2D {
		x=0, y=472,
		size = 10,
		color=Color(1,1,1,1),
		args={ "upperMask :", blendControlValue.upperMask }
	}
	GrxDebug.Print2D {
		x=0, y=484,
		size = 10,
		color=Color(1,1,1,1),
		args={ "holdBlendRate :", blendControlValue.holdBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=496,
		size = 10,
		color=Color(1,1,1,1),
		args={ "testNoHold :", blendControlValue.testNoHold }
	}
	GrxDebug.Print2D {
		x=0, y=508,
		size = 10,
		color=Color(1,1,1,1),
		args={ "upperDisableMask :", blendControlValue.upperDisableMask }
	}
	GrxDebug.Print2D {
		x=0, y=520,
		size = 10,
		color=Color(1,1,1,1),
		args={ "commonSelectIndex :", blendControlValue.commonSelectIndex }
	}
	GrxDebug.Print2D {
		x=0, y=532,
		size = 10,
		color=Color(1,1,1,1),
		args={ "commonBlendRate :", blendControlValue.commonBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=544,
		size = 10,
		color=Color(1,1,1,1),
		args={ "turnTypeSelectIndex :", blendControlValue.turnTypeSelectIndex }
	}
	GrxDebug.Print2D {
		x=0, y=556,
		size = 10,
		color=Color(1,1,1,1),
		args={ "fireBlendRate :", blendControlValue.fireBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=568,
		size = 10,
		color=Color(1,1,1,1),
		args={ "jumpType :", blendControlValue.jumpType }
	}
	GrxDebug.Print2D {
		x=0, y=580,
		size = 10,
		color=Color(1,1,1,1),
		args={ "stepOnType :", blendControlValue.stepOnType }
	}
	GrxDebug.Print2D {
		x=0, y=592,
		size = 10,
		color=Color(1,1,1,1),
		args={ "behindType :", blendControlValue.behindType }
	}
	GrxDebug.Print2D {
		x=0, y=604,
		size = 10,
		color=Color(1,1,1,1),
		args={ "cannotHold :", blendControlValue.cannotHold }
	}
	GrxDebug.Print2D {
		x=0, y=616,
		size = 10,
		color=Color(1,1,1,1),
		args={ "slopeBlend :", blendControlValue.slopeBlendRate }
	}
	GrxDebug.Print2D {
		x=0, y=628,
		size = 10,
		color=Color(1,1,1,1),
		args={ "groundType :", blendControlValue.groundType }
	}
	GrxDebug.Print2D {
		x=0, y=640,
		size = 10,
		color=Color(1,1,1,1),
		args={ "eludeType :", blendControlValue.eludeType }
	}

	
	local isEnableChangeMoveType
	if playerInternalWork:GetEnableChangeMoveType() == true then
		isEnableChangeMoveType = 1
	else
		isEnableChangeMoveType = 0
	end
	GrxDebug.Print2D {
		x=0, y=652,
		size = 10,
		color=Color(1,1,1,1),
		args={ "EnableChangeMoveType:", isEnableChangeMoveType }
	}
	local isRequestTurn
	if playerInternalWork:GetRequestTurn() == true then
		isRequestTurn = 1
	else
		isRequestTurn = 0
	end
	GrxDebug.Print2D {
		x=0, y=664,
		size = 10,
		color=Color(1,1,1,1),
		args={ "RequestMoveTurn:", isRequestTurn }
	}

end,


ViewRightStick = function( chara, plugin )
	local plgCamera = chara:FindPluginByName( "TpsCamera" )

	if plgCamera:IsSleeping() then
		return
	end
	local pos = plgCamera:GetPosition()
	local radius = 1.0
	local vecZ = Vector3( 0, 0, 1 )
	local camDir = plgCamera:GetOrientation():Rotate( vecZ )

	
	local playerPadOperator = chara:FindPluginByName( "PadOperator" )
	local padX = playerPadOperator.rightStickX
	local padY = playerPadOperator.rightStickY
	local force = playerPadOperator.rightStickForce

	local dir = foxmath.Atan2( -padX, -padY );
	local stickVec = Vector3( (radius * force) * foxmath.Sin(dir), (radius * force) * foxmath.Cos(dir), 0 )
	local stickDir = plgCamera:GetOrientation():Rotate( stickVec )

	
	pos = pos + 3.0 * camDir
	local stickPos = pos + stickDir

	GrxDebug.Sphere {
		center	= pos,
		radius	= radius,
		color	= Color{ 0.75, 0.0, 0.0, 1.0 },
		life	= 1,
	}
	
	GrxDebug.Arrow {
		from	= pos,
		to		= stickPos,
		color	= Color{ 0.0, force, 0.0, 1.0 },
		life	= 1,
	}

	GrxDebug.Print2D {
		x=0, y=324,
		size = 10,
		color=Color(1,1,1,1),
		args={ "Stick X:", stickVec:GetX(), " Y:", stickVec:GetY(), " Z:", stickVec:GetZ()  }
	}
	GrxDebug.Print2D {
		x=0, y=336,
		size = 10,
		color=Color(1,1,1,1),
		args={ "Pad X:", padX, " Y:", padY  }
	}
	GrxDebug.Print2D {
		x=0, y=348,
		size = 10,
		color=Color(1,1,1,1),
		args={ "force:", force, " Dir:", dir }
	}

end,


ViewLeftStick = function( chara, plugin )
	local plgBody = chara:FindPlugin( "ChBodyPlugin" )
	local playerInternalWork = chara:FindPlugin( "TppPlayerInternalWorkPlugin" )
	local control = plgBody:GetControl()
	local pos = plgBody:GetControlPosition()
	local radius = 2.0
	local stickColor = { 0.0, 1.0, 0.0, 1.0 }
	local desc = chara:GetCharacterDesc()
	local rotY = desc.ch_direction

	
	local playerPadOperator = chara:FindPluginByName( "PadOperator" )
	local padX = playerPadOperator.leftStickX
	local padY = playerPadOperator.leftStickY

	
	local force = playerInternalWork:GetPadForce()
	local dir = playerInternalWork:GetPadDirection()
	local diff = foxmath.Mod( foxmath.RadianToDegree( dir - rotY ) + 360, 360 )

	
	GrxDebug.Sphere {
		center	= pos,
		radius	= radius,
		color	= Color{ 0.75, 0.0, 0.0, 1.0 },
		life	= 1,
	}

	if TppDefaultParameter.IsExistingData( "TppNewPlayerPad" ) == true then
		local paddata = TppDefaultParameter.GetDataFromGroupName( "TppNewPlayerPad" )
		if paddata then
			local padparams = paddata:GetParam( "TppNewPlayerPad" )
			if padparams then
				local forceMin = padparams.leftStickForceResponseMin
				local forceMax = padparams.leftStickForceResponseMax
				local forceWalkToRun = padparams.leftStickForceWalkToRun
				local forceWalkHalf = (forceMin+forceWalkToRun) * 0.5
				local sensitive = padparams.leftStickSensitivity
				
				GrxDebug.Sphere {
					center	= pos,
					radius	= radius * forceMin,
					color	= Color{ 0.0, 0.75, 0.0, 1.0 },
					life	= 1,
				}
				
				GrxDebug.Sphere {
					center	= pos,
					radius	= radius * forceMax,
					color	= Color{ 0.75, 0.375, 0.0, 1.0 },
					life	= 1,
				}
				
				GrxDebug.Sphere {
					center	= pos,
					radius	= radius * (forceMin + (forceMax-forceMin) * forceWalkToRun),
					color	= Color{ 0.75, 0.75, 0.0, 1.0 },
					life	= 1,
				}
				
				GrxDebug.Sphere {
					center	= pos,
					radius	= radius * (forceMin + (forceMax-forceMin) * forceWalkHalf),
					color	= Color{ 0.375, 0.75, 0.0, 1.0 },
					life	= 1,
				}
				if force >= forceMax then
					stickColor = Color{ 1.0, 0.25, 0.25, 1.0 }
				elseif force < forceMin then
					stickColor = Color{ 0.5, 0.5, 0.5, 1.0 }
				elseif force >= forceWalkToRun then
					stickColor = Color{ 1.0, 1.0 - 0.5 * (force - forceWalkToRun) / (forceMax - forceWalkToRun), 0.25, 1.0 }
				else
					stickColor = Color{ 1.5 * (force - forceMin) / (forceWalkToRun - forceMin), 1.0, 0.25, 1.0 }
				end

if DEBUG then
				GrxDebug.Print2D {
					x=0, y=512,
					size = 12,
					color=Color(1,1,1,1),
					args={ "Pad forceMin:", forceMin }
				}
				GrxDebug.Print2D {
					x=0, y=528,
					size = 12,
					color=Color(1,1,1,1),
					args={ "Pad forceMax:", forceMax }
				}
				GrxDebug.Print2D {
					x=0, y=544,
					size = 12,
					color=Color(1,1,1,1),
					args={ "Pad fW2R:", forceWalkToRun, " sense:", sensitive }
				}
end
			end
		end
	end

	local stickPos = Vector3( pos:GetX() + (radius * force) * foxmath.Sin(dir) , pos:GetY(), pos:GetZ() + (radius * force) * foxmath.Cos(dir) )
	GrxDebug.Sphere {
		center	= stickPos,
		radius	= 0.1,
		color	= stickColor,
		life	= 1,
	}
	GrxDebug.Arrow {
		from	= pos,
		to		= stickPos,
		color	= stickColor,
		life	= 1,
	}

	local vecZ = Vector3( 0, 0, 1 )
	local plgArdCam = chara:FindPluginByName( "AroundCamera" )
	local plgTpsCam = chara:FindPluginByName( "TpsCamera" )
	local camDir = Vector3( 0, 0, 0 )
	local camDirY = 0
	if not plgArdCam:IsSleeping() then
		camDir = plgArdCam:GetOrientation():Rotate( vecZ )
		camDirY = foxmath.Atan2( camDir:GetX(), camDir:GetZ() )
	end
	if not plgTpsCam:IsSleeping() then
		camDirY = plgTpsCam:GetRotationY()
	end
	local camPos = Vector3( pos:GetX() + foxmath.Sin(camDirY) , pos:GetY(), pos:GetZ() + foxmath.Cos(camDirY) )
	GrxDebug.Arrow {
		from	= pos,
		to		= camPos,
		color	= Color(1,1,1,1),
		life	= 1,
	}

	GrxDebug.Print2D {
		x=0, y=560,
		size = 12,
		color=Color(1,1,1,1),
		args={ "Pad X:", padX, " Y:", padY  }
	}
	GrxDebug.Print2D {
		x=0, y=576,
		size = 12,
		color=Color(1,1,1,1),
		args={ "force:", force, " Dir:", dir }
	}
	if diff > 180 then
		diff = 360-diff
	end
	GrxDebug.Print2D {
		x=0, y=592,
		size = 12,
		color=Color(1,1,1,1),
		args={ "Diff:", diff  }
	}



end,


}
